Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2p-00061f-Cn; Mon, 25 May 2026 11:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2c-0005xr-P6
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2a-0007RE-Uz
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xb0lwzwT0j8aOb6w9EmhSr1ORdgc3Kl57dK6QxGGC6w=;
 b=PCAi+Jg/9+sDgC8tjo3ZgLEBik2nf3srermIpZ84FzyLNwd5J3TYaIwFDNSQatitpbJwtr
 elwUAPowcGCfRsat6okCeP1+kErazyfFQC0bWwfQTEqKcbSPYroLj6y+eD8BApc54otiCh
 1r4YFoD925NK7AUawLkHQEr9h7miSVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-qOnhLHjPN2OwF9fxB-T1fQ-1; Mon, 25 May 2026 11:16:26 -0400
X-MC-Unique: qOnhLHjPN2OwF9fxB-T1fQ-1
X-Mimecast-MFC-AGG-ID: qOnhLHjPN2OwF9fxB-T1fQ_1779722185
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe24773c8so51053705e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722185; x=1780326985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xb0lwzwT0j8aOb6w9EmhSr1ORdgc3Kl57dK6QxGGC6w=;
 b=koDB9WQRbBxBPjAWtOLV6Lle2mOS2uWTzSZXd5u9jOklmT4rc3GRQoVM3U8ow/H5vS
 FMSYKWE08VWMKYusDDCdGjFqCPzDm2EiMpWaaXhBd6uhAD7BDrnoo4bOKD4PqEnCTHfu
 mD5sqYFF4aaHVltLRLQ3kF/IS82qIiUZEyIRzoIz673YywNQB3e8qf49b9fjkUG5NcrQ
 UOYiljCg0bIwqBTjmXhz6N5W2Mc2dS7Rm+tW+tQzqUGDF0B8CoVQEoAryrieOqR6wNSc
 FpIU6ahXms3qq97WeCPIJj+qsQa44gVgw1PP6HrK78kzN2+dWAB6NWAt96AQ55Y+ssSn
 o9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722185; x=1780326985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xb0lwzwT0j8aOb6w9EmhSr1ORdgc3Kl57dK6QxGGC6w=;
 b=bhidBo5rya81D2hMfs70ktM2F8O+9xDF4GGlFt1+76faQaZNIRSy0f3B5lBTY7I7Qt
 9EHMVQb9iEoEZtY2/3iGNuMLqe/RliDKaFYtL0mIl8XUdaxwkS5P7L3sVlUx6G2IoKeN
 Gb/eFhrPqTAEqzvGwuteU37E+RosdeTxS/iaJGhXjIsidxV3ae9LIJ89tn/+X2cKfK1i
 gJE6Ufi0bmLIreIUzr4+kAV+s24CjWl6DFjsoOVNqLz5nMKb4K6OeRM4dk25K5XMqYct
 1e0ofpADoFcj28WEt6USE5GKppFqLnZJKE/C/7zDMjPcTOAnkGycxqBiiooZoMXEd8WW
 ydFw==
X-Gm-Message-State: AOJu0YyyU8oQK0ebQ/jaKREHM6gB9KBd4FmTrR7fg8pHzr7ec71gXtXI
 EYbGmQ1jqqRBzkUf26d4l/6pYTElBsqhsRkIu0IkhtGbjQwrgiOaVRCgNAiwVcolFPGST3AHJkr
 v2BO68Y7FerGJR+2yky/+7nKX7vMSDKwA4FKATwjN3McpmBJ0QAEpyUGkUAR0/myUtN/GRFE7y9
 gJRXN3BaBsuV47mwCbcG2cXQJNwxwHBaZs5MCgntKi
X-Gm-Gg: Acq92OHa30HalhFzGQtnlcVEWkWUXOKnNXVAhfTAmdKT8hTVUjBmcXWUSoI4Z/s0Vek
 yuYTEQeVYh2Ssu+jxBOMg4QUA2nAGLOQos3Y4FJLNX0xHBfamr575YC4Xu6Q+dF+COuBSdMzVUh
 G8QAb5YUhZZz4QkDEjAiRwrlqMyFdnj8A4kPvZTE9FOC0eudPFWc/4Sp9qTjYGGuq7nuMlLwCZT
 dhZasdyP/vJqfxlDpnUmIlIWyKkBbeG7lhR1jMslLWXNsgy1m/eYWQyx0CQlsS8tUJNgM+3vd+n
 eVdybGKh1I1rgxKoKtIBhItXccaadihdGij4MPwAZx2UIIeJthFXoyKYQ2XGMh6+9aFnUbr+j0F
 BDB96DcuOICTe2ueZECUzV7dprbBRXnvmgEgs2x0zaZp8nMLG2OO3RmeMZ40R9dWcLTv2YLXV3t
 esOVW4YNddbKRwuHw91eLIyinyFOTu
X-Received: by 2002:a05:600c:4688:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-49042ae99afmr240339555e9.33.1779722185316; 
 Mon, 25 May 2026 08:16:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-49042ae99afmr240338925e9.33.1779722184742; 
 Mon, 25 May 2026 08:16:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm284968585e9.8.2026.05.25.08.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Che Kao <skps96g313.cs10@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 1/6] lsi53c895a: fix use-after-free of cancelled request
Date: Mon, 25 May 2026 17:16:16 +0200
Message-ID: <20260525151621.395954-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-stable@nongnu.org
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


