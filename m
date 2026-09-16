Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83817C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pZy-0005z5-Q6; Wed, 16 Sep 2026 09:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZx-0005yi-0d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZv-00033m-I8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4zCgCofAbSIwBV7LwLzPbmwRhQRvzJQGav11HNAOOQ=;
 b=BwecgD+qy27WaSfkXURGPF712O9gMNBmRYUWxeGKkaLM4gprF5TGlug7uckRnfGdCwLayF
 QGRG4PDtKC5xpZLaL7fDoATkNlUMgbfC14hw4k0/mBKbNmDy3A83IZZI0IXsnRD7WGBhQ8
 S7GR8T9WE/qF5Ct8zBDlQrPlVwG2TQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-2R5RzYCTNzmZvLSLNDZnrQ-1; Wed, 16 Sep 2026 09:21:32 -0400
X-MC-Unique: 2R5RzYCTNzmZvLSLNDZnrQ-1
X-Mimecast-MFC-AGG-ID: 2R5RzYCTNzmZvLSLNDZnrQ_1789564892
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so46654645e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564891; x=1790169691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4zCgCofAbSIwBV7LwLzPbmwRhQRvzJQGav11HNAOOQ=;
 b=Q8sy2+3wLN9c9X1IUn8UOuixQ3bO13qTQkmmosnTE5WDvnBDHEEuuif+NNCx9WRI4k
 yjZ8Ts0F2/+1K8MR6mZWIlsLtUg/nUGZhB9a+ubReVMeuqxgb0L0LmQLmjkPTMOESVoM
 PPxM3micyTkvT9d0V3jAgg1TjKbt5W8wzOXdT/VPtWpSpR10Od19irgx6IZvESncd6M9
 zGDWK/GOhgpTy9S0NhYndo2w4XccsTvSe+0U0asNW1chLyj7wIysPyB08+ZOvGNhMvRa
 5ART1d5xzEl+rN+I2rpC7JUvZ9Em8xD3eAWa8WZYGWhEdqzYABR/RNMJWfJOcl1WOk4A
 RVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564891; x=1790169691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I4zCgCofAbSIwBV7LwLzPbmwRhQRvzJQGav11HNAOOQ=;
 b=w2jGuet7ZoRb/gDu4Yhyh1NYMYr9IdxgO3Fh6quoSQeNjM+ZeKE34tmXcPwtFNpDHG
 Q1FR8l0n8Kzu5D8Sy3rJ8IzpjBd72NZZpML92GBMgoZO0jGGdfNfDB9xPZ4xLcTznYy6
 uTN/UQBT2MBIcB8v1gfnLOPDBlydoxDIi3LnHOr7IvJzeTg81wquxIu2dbNbgZXNacwi
 Eg7//UQNKg8/z580XTnygsp6IjYt2Or8JjtF/9OwgOKw/rCzsf1m6TyflFjmHw+f8Wo/
 S5AqsoCRRb+fYV3y0UTKmVLPOyXKbcveSIF12ZIP/eW2JaQdqvvKcT+K+vPLVrHPTn3/
 IkQQ==
X-Gm-Message-State: AFuF++l+YYhK+vrQgLpJqewyrld7O2O1SZVf8MpBy40+Mlrca7R3OjLy
 f7XlgZVCHG+XYCW68bDRpWW4VePoMRRxeheoDiNlvOEokWNoTHD0zYBeEmplzwqGmsoHyS4qI0g
 uRPM1SW6jCr2/+2ey6EZG6mWfzROL9rVoR+YUduXFSlN5JA7aKoFffJ0E/zYyCCAvQK2FnqlrcE
 RxvaBc7NlqDeipL7zFG1uewGHW96Aez/ZExVmFfMiY
X-Gm-Gg: AYBFou2VIRS6Tt5DfUk870Gjz8Lp1n1CI8OnDVhDWVCfHALTmtgiZl0KT+ZGJGDQ/jz
 oMhVR5hQsbVsYVAAHpIFz5XIBXAGSf7M8SonOiHOqipbJn1MOFqN+Liwn6N7h8rxcLMdrTaUy2E
 CcncRu/hT5DR1VzY2xfX4J+B9Y980iyJq5ODGufFIyrv0NTAEOPBboUUaJz5LwfURBYIPx8Wi65
 NyQi6s0QDnK6I6pk1frJb3SxMbnKL6ytEV6yy1cjyRijkhifgAfvV8Jqh7ZLutaBaW11H9SCg6A
 6EI+j5nZJa4gwvtYsW3eLsp1NetuxJUjYMX5hzCoOjAQ48pzv2ysau1ymm1eTMdtrxM+5xiqstu
 CbYDxMfS5jvN4gRxoncOqxkHFcg/b2LIleUg2YFyEyD0xXJe0Rx8vFE5ZjfFu+fRtv1b6ETKl6V
 2ytbOU
X-Received: by 2002:a05:600c:8b61:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49eb732e411mr27612475e9.25.1789564891596; 
 Wed, 16 Sep 2026 06:21:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8b61:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49eb732e411mr27612025e9.25.1789564891093; 
 Wed, 16 Sep 2026 06:21:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf26c8dsm7349604f8f.14.2026.09.16.06.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/8] ncr710: remove weird p->req == NULL case
Date: Wed, 16 Sep 2026 15:21:15 +0200
Message-ID: <20260916132120.860910-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 12a9b69336a..ac44e99dd90 100644
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
 
@@ -749,11 +748,8 @@ void ncr710_request_cancelled(SCSIRequest *req)
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
     if (p) {
-        req->hba_private = NULL;
-        p->req = NULL;
         ncr710_request_free(s, p);
     }
-    scsi_req_unref(req);
 }
 
 static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
@@ -794,13 +790,11 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
-        req->hba_private = NULL;
         if (p == s->current) {
-            p->req = NULL;
+            req->hba_private = NULL;
         } else {
             ncr710_request_free(s, p);
         }
-        scsi_req_unref(req);
     }
 
     if (s->waiting == NCR710_WAIT_RESELECT || s->waiting == NCR710_WAIT_DMA) {
-- 
2.55.0


