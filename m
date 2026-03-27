Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108E410F2872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Ehv-0003ui-AI; Fri, 27 Mar 2026 17:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehp-0003fd-LQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Ehl-0003iJ-Su
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j+8F9WY80KMSNsIWnJr/7G6jY4kVXncWxg0JKnHv9A=;
 b=VmzxgmzhYltZu+llmVcmKUainiiHDMzLlnFaeV19XEB7hatZxETTWJKgBfliPIk+dE/kRU
 Xpm96nAXEX+pMBxn7x3F0YSSAzDPhg06Myhthx+IRhfN4GcSX+XjCG8JmbywwJCd+8kI+7
 6LEfrZoiQYZDc8kR2iitUg+VWJ+pdvo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-HFpQQ921MTSMdlM8WSCXIQ-1; Fri, 27 Mar 2026 17:26:55 -0400
X-MC-Unique: HFpQQ921MTSMdlM8WSCXIQ-1
X-Mimecast-MFC-AGG-ID: HFpQQ921MTSMdlM8WSCXIQ_1774646815
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4871fc50fe7so16847985e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646813; x=1775251613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j+8F9WY80KMSNsIWnJr/7G6jY4kVXncWxg0JKnHv9A=;
 b=tB7kMR89smjw2mOcULJ9lL30zg+EWagjKuOx1eUh6YstpVadFR4IZSvzyhtl3mnHmS
 REUtI8jVezDPO1y3bfkbQSZQUCxH4WiHwauGqWVoBwUvItVn7+bzlTyrEzodTICxOBTo
 QGay/6hhyEO+p2iwJmzZ6BFMFhH0JgsI5aQahPyNwhbskNCZlUYPDEiA3ETA01cmRtOV
 KnOi5Uf41j5EFpKhg3vQsFZWhZ/8jSreyd6Ap7NG461pD8isrR63EZgl0cO9FH10zWnX
 jN31QdFtUB589yKDTeWrNjoXaYzVwHECo00Lf10+ceXF+trxLeEezXiKLEW4o79VtGxX
 L6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646813; x=1775251613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6j+8F9WY80KMSNsIWnJr/7G6jY4kVXncWxg0JKnHv9A=;
 b=Hr3AYx7SVLWIoI+2bumWAip8hyeDpNCWStCjoHcgLmHi/PBM8yyFwB2p7kxAJlfF0O
 AlpoHegPewUlx+mo5KT4EB/0dL6kzmLzT0ETPRK+jd1vv+vKM7Qwpv88yRD6dzE+hBTw
 LQ0NIf4c33BcgZYNIZwjpQdsUPbhGOV1mFi8nyh2j8NKMJZiLKt7MVmkqwuwQIfKnTzr
 bGavpaMww43jsA48ZcGVdhPK7avOoMYlpcWtvPRAedkzRW/k7MJQns4OfNnfsATKbFAI
 LyORBLfmZhI8+ozw02j/ISnrLY4RsXi67RjmodwGFypMzQQXoX+NuviPliUDpgbhLAW/
 sS+A==
X-Gm-Message-State: AOJu0YwLFHRRvvS8mJIw/dReAWxYrgeSCdZy9KE6+aS/nYSBnrAO5VKL
 bGIvmFJGPciznD5Gs+IMCq+qP6cive+iHrhcN0H6YrKtnDePf8eTcBH8CCiDzXDlRyjxWw6QLVp
 ng3Hrck9ypI5OzMLWACXj8cjjpkqiddothKugEwsoNHHLaZT+Mov8yz1umaa1qqlJAYfeCwCUL7
 1VNjCmirJuOm5Q2otN0USxArwkTMtq9zCf9J5GyWtc
X-Gm-Gg: ATEYQzwaCB4gxJVOXN+e5hkY/AwQNooyHlWoDb12X1GG2OXjhsQUIchz7IhnYMhzvu2
 jv0sKCTjmUwNiMEWqdpWffmauo7G96KCs3lZZdi4iNjIMLIHvNdJ9zpplQf66TEujfe0MqR2qp8
 uY2OvFmFUbewWzlPW9SLtY3Na4XJD5PqnbKCbOdEQeKoTPfw+2qROwL605dxm4D7R6YoEVgyeW7
 19HfSgtnHkix9EX6oP+XhMYr2aEmogiWXnUKQEKTNmX6ZYPh+GDOq2UFiisO2XCD6DsTGj/4O+v
 bs48kS/sZPB3mZ4SeHmhDINkmoeqhNr+4IFHsxqqHVB6RdE2TV0oYjkSSPUkYkIH3uwmcBhertw
 uCDpMw6XXkL18rYOIJjWGgjn0bUWNS1k7cZtLoabThHhgsEZrz4p/D215qW4/QxZKoRlxFkehUD
 z2skyT0UVIkEuNs1Y1aoZhsfjv
X-Received: by 2002:a05:600c:a10a:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48727e9ea73mr65002955e9.14.1774646813588; 
 Fri, 27 Mar 2026 14:26:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a10a:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48727e9ea73mr65002735e9.14.1774646813152; 
 Fri, 27 Mar 2026 14:26:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm115720295e9.14.2026.03.27.14.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:26:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 10/16] ncr710: remove weird p->req == NULL case
Date: Fri, 27 Mar 2026 22:25:41 +0100
Message-ID: <20260327212547.460420-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Setting p->req to NULL in ncr710_request_cancelled and ncr710_command_complete
only protects from clearing p->req->hba_private in ncr_request_free.  However,
in this case p->req->hba_private must have been already cleared (by the same
ncr710_request_cancelled and ncr710_command_complete); so the reference to the
SCSIRequest can be kept until ncr710_request_free (called eventually by e.g.
ncr710_do_command) and that assignment can be made unconditional in
ncr710_request_free.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 7503d791205..ff0d3cf0c86 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -735,12 +735,11 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
-    if (p->req && p->req->hba_private == p) {
-        p->req->hba_private = NULL;
-    }
+    p->req->hba_private = NULL;
     if (p == s->current) {
         s->current = NULL;
     }
+    scsi_req_unref(p->req);
     g_free(p);
 }
 
@@ -750,10 +749,8 @@ void ncr710_request_cancelled(SCSIRequest *req)
     NCR710Request *p = (NCR710Request *)req->hba_private;
     if (p) {
         req->hba_private = NULL;
-        p->req = NULL;
         ncr710_request_free(s, p);
     }
-    scsi_req_unref(req);
 }
 
 static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
@@ -795,12 +792,9 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
 
     if (p) {
         req->hba_private = NULL;
-        if (p == s->current) {
-            p->req = NULL;
-        } else {
+        if (p != s->current) {
             ncr710_request_free(s, p);
         }
-        scsi_req_unref(req);
     }
 
     if (s->waiting == NCR710_WAIT_RESELECT || s->waiting == NCR710_WAIT_DMA) {
-- 
2.53.0


