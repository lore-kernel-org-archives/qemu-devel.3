Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502DDCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 09:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNone-0004Wd-NR; Fri, 15 May 2026 05:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNond-0004WI-4q
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wNonb-0001yH-MP
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778837138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0VgeAWIJpNc6wqjlJZoP6bqRroG+IMcBE3u+efHxuoU=;
 b=bnWLIfe6dZOqUzhwHgt32VEtEY9mol7fda8dOudY19IDauhOgQwtMgQZqY0Jr0kI7pDKpP
 dxaJq4n0hPm4vwOFkf49xqNzQC+yWKcPNBLMpXsOETXC/Mf2xJLPgtSmWjouq+msqmPSwp
 VGFTok/AIitV+OEKA3Y/X5XCsn87znc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-f38y6dlnMTC1DTUss4Ndlg-1; Fri, 15 May 2026 05:25:32 -0400
X-MC-Unique: f38y6dlnMTC1DTUss4Ndlg-1
X-Mimecast-MFC-AGG-ID: f38y6dlnMTC1DTUss4Ndlg_1778837131
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ae994d9aaso4598906f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778837131; x=1779441931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0VgeAWIJpNc6wqjlJZoP6bqRroG+IMcBE3u+efHxuoU=;
 b=ebqMv5IhgkNkM8t14NLU6r4SUv6j2wy2abWgKsRJkhetHJzPfn1XmFyqKmpLNdl4It
 nRLkDDS6YwMvNzj3sI+Bc6HGuQMTizmZXqLsVxhgApXbd1NOnEWL2BmtVRGKnY27/5Qc
 vcKgggKELzK0xK8er72W3uR/GmvhLmHCg2w++yW6PRPz8Oe1GWSm0SCU4T3DEIXcRdMA
 ZiXeCsWrw2GEfpIapkBipphkS+Eoy1IG49o1Z9ijCOWT0Xzn12zA1S98lttyDyYs5fc6
 Dclpre4QYguoeIgAwyBtCFKWAM7v4+jKxBwzkewRyvbbpvX1LIMwVHPlJrQn8L9pvdA3
 Ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778837131; x=1779441931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VgeAWIJpNc6wqjlJZoP6bqRroG+IMcBE3u+efHxuoU=;
 b=FebZZaisIQThm6nBqLk8jfsZdXMdHha8r9bg0zlJKUrp4Z/Sf8IdXGhdnCoR0TnWp0
 WYnSmvAAKFqMqHG1udTYOszzSrJ+cPKgZQ4H8uO5/Q4AqHeYcyWkdLGy4FT1sbac6vqn
 hU1/2Etm1dIbBJkSQSGWKb+W1dLzRncbiMSEqMeyw2hODG2FoVO1Ccan+4YAZr2hjcPF
 Txy4GfjF9cZ7iOpm7D8zfWX9+YWvkaJeYJcGFeXY6Pps6E1E5qXcPtjkifQRzNrY+ue2
 r/fNGZKalmwX4VYU3IKOOSQ/6MdB1bYGNN2RGiUS70u8STkzwTpcL78n9nx9qi+/PYxf
 SZsQ==
X-Gm-Message-State: AOJu0Yx28byYcjVQvj7qXgjseimZLyex7J1g4smsy6mBKlsKSvQhgEoo
 rz8FLvA/UOCPgY8eo0jBlQ/sq3cWt345Nfb1KadEN5/tBjRVpY6TJTJNJJgWARt9w7+5vJA0hw0
 48IBjGXFK4VTR7lbwVX0EBtvU0KfSLj7fqSUHocIDrfqvBg6smzDGcNnIn7UsOUQLOrSsWRZTUw
 WBE8yFAfTmMYxOrrEoilJufeDLHYXluOCL3IbLv4sC
X-Gm-Gg: Acq92OHFALj266oT/AUS9XyljEsMmLSSytqRb9X6xCfmnrcioWE16MLANKA9aq6CQUk
 4UpkL02uogNf1uUO8NxgTdYns0BIm6PKO1bvA9EG9kQHWIp7DkWKDqJs3I0vmPaCuQEqR8ZTUMU
 aoMSrJXIg/DIxV3VPspc1iiySN7B4dSs2msdc8LlEvDNuBUYa8677Rk0PfoOAE/JaTru3fdoJEr
 8haPBOgrQhcKpwRqmRikzSerZV3LAYLtTL8oWKeQEWVKvqRilEvDrqjGoLevCHg5SDYxwqWZ/VM
 b1Kcbxp+iDPk4k9gzZcX1t1S10/XyrwZtu2IDqIqUMosRQQ2mCFaT6I/MoBZl//turYO1t5cneh
 Zy15HZgnbysfSSoYbPTkXIrC1IOTg6H2ojOW3BKohV+d3IPlC7EJB/WfggOJjdTUQsbmEQr6Htk
 jV20JeXlLpJLo6GYisE2WJR0oRQyDX
X-Received: by 2002:a05:600c:3e1b:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48fe6515f20mr38481725e9.24.1778837131156; 
 Fri, 15 May 2026 02:25:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1b:b0:48a:9562:7a30 with SMTP id
 5b1f17b1804b1-48fe6515f20mr38481345e9.24.1778837130696; 
 Fri, 15 May 2026 02:25:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm57016045e9.7.2026.05.15.02.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 02:25:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Che Kao <skps96g313.cs10@gmail.com>
Subject: [PATCH] lsi53c895a: fix use-after-free of cancelled request
Date: Fri, 15 May 2026 11:25:27 +0200
Message-ID: <20260515092528.3860322-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When processing the Message Out phase, the lsi53c895a controller
can cancel a request and the continue by processing more messages.
When this happens, it is important that a cancelled request is not
processed further, because scsi_req_cancel can cause the request
to be freed.

Right now this is happening in two cases, but not when cancelling
the entire queue of requests after an ABORT, CLEAR QUEUE or
BUS DEVICE RESET message.  In that case, a subsequent ABORT TAG
message can use a dangling current_req.

There are three possible fixes:

- add a missing check inside the loop, clearing current_req
  if p->req == current_req.  This is obvious but complicates the
  code inside the foreach loop.

- change the conditional prior to the loop from "if (s->current)"
  to "if (current_req)".  This would work, because s->current != NULL
  implies current_req != NULL, and would clear current_req correctly.
  However it is less obvious because the point of the code
  is to clear the entire queue, which consists of s->current
  and s->queue; current_req is not special here.

- delay the retrieval of current_req until an ABORT TAG message
  is seen.  This is the most correct option, because the SCSI
  protocol only deals with tags; requests are a QEMU concept
  that only makes sense for the purpose of calling into the
  SCSI layer.

Reported-by: Wei Che Kao <skps96g313.cs10@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 54123f77579..0843d325ab1 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1000,10 +1000,8 @@ static void lsi_do_msgout(LSIState *s)
 
     if (s->current) {
         current_tag = s->current->tag;
-        current_req = s->current;
     } else {
         current_tag = s->select_tag;
-        current_req = lsi_find_by_tag(s, current_tag);
     }
 
     trace_lsi_do_msgout(s->dbc);
@@ -1058,9 +1056,13 @@ static void lsi_do_msgout(LSIState *s)
         case 0x0d:
             /* The ABORT TAG message clears the current I/O process only. */
             trace_lsi_do_msgout_abort(current_tag);
+            if (s->current) {
+                current_req = s->current;
+            } else {
+                current_req = lsi_find_by_tag(s, current_tag);
+            }
             if (current_req && current_req->req) {
                 scsi_req_cancel(current_req->req);
-                current_req = NULL;
             }
             lsi_disconnect(s);
             break;
@@ -1086,7 +1088,6 @@ static void lsi_do_msgout(LSIState *s)
             /* clear the current I/O process */
             if (s->current) {
                 scsi_req_cancel(s->current->req);
-                current_req = NULL;
             }
 
             /* As the current implemented devices scsi_disk and scsi_generic
-- 
2.54.0


