Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEDBC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td7r0-000843-Mx; Wed, 29 Jan 2025 08:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td7qz-00083s-3f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td7qx-0002G1-6s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738156293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Ds0FKXz6e3lXFB/JQuUA/Jge19Ry9C7VmOj6Fnxkro=;
 b=GSH1rQQNGE6vUxFMMDFaImq02kaM9nXag/gyF/gFyshy3s/PqdLH4fNFkOHfwElwj0bm8Y
 xVlzof3KtD7d471RQOqL8irj59KPlfh9a6u4A3ivmZPP+nm64askVBfQGSlot74KUJwvNj
 xuTWnemaF0XWt6LCQ4DCa4OxIKw0JnI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-K2thAohLNZSF5ucnb4aolQ-1; Wed, 29 Jan 2025 08:11:31 -0500
X-MC-Unique: K2thAohLNZSF5ucnb4aolQ-1
X-Mimecast-MFC-AGG-ID: K2thAohLNZSF5ucnb4aolQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43626224274so38841895e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 05:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738156289; x=1738761089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ds0FKXz6e3lXFB/JQuUA/Jge19Ry9C7VmOj6Fnxkro=;
 b=fKHaVQCMS5n4eOUx9d/kzEy1T4OwlN9ybcAr0cFib37JcPiMCLMEPB7aedAsKsg6EN
 CJfMGN0sJxMoxkqNkDWwxh2igpCQeSY5Uk72/iNSmN8/FuxSDqY+vpkLXbbFMVs19gf8
 zYtY5YYQ5FopBC9iSSeYyg5Dd9AY+pe8AWaKXuLURg/aAMUigYq85DKsFWpP/oi1yZO0
 yZX5XZ8XGX2S7YwiXW00ImpfAKIZmbkIaqwiYFwALXXcB500FlFADyExRm0vS1bewtNv
 AQJa6tn5hbzOPjqpx557zDh5RgOnj15RZnq40qKQOjx7C0omaciXKiJdmWUJhmzhkhwI
 geEQ==
X-Gm-Message-State: AOJu0YzNx3qryKQP4hkgPopn6RwxWoupEo6CcsiKlB47DZ/JRXdoeJb9
 X12Q87kAUlV11XA+i9E2tfd6Tposre09Rbjl1yOBf5YfKVuQz/FiNaqUaJzzHT4Qp+2VsdawzoU
 RDscQfJxohCdhgdQh0XDoLAu55aGuZDdD7sHfZnWK+AsK4dWUjWq3Q2X7/t7OZFs/BxjZoILMgH
 rkn/rqTwdK/Gl0rVSHQw671JaqANKnm6lWEcmWjIc=
X-Gm-Gg: ASbGnctLeB0R/AImfoyzbKv2xzTw2yP9T1B/UckPxPlR0WANxGumedYCRIVeIKsQjBk
 R/Xim8RE/4ZHq/xe1I14bZkFMu/dAR+fP/sZxCf/7RwY8SeNT4Ze9td6z5RVinGu6KXaxGtmF9L
 dVtaKYQ4INkv580+vKoTLVuSl7x7Y1PdlcfOFTu8/zincnHAzYupjAuYU5x8UJObeA2CzqBBZHT
 O2sKSlorGbvHwQnuzesgBG0YgCMrpgfqlGA0JIr7CNu2zvqJZHGIAxhpDeJBEqj2G8jEIvxw3ae
 h6E8CA==
X-Received: by 2002:a05:600c:c12:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-438dc3cc378mr27544305e9.16.1738156289219; 
 Wed, 29 Jan 2025 05:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE39BQYG/mU8HboXW1lKhPWDPhlxErWYvUuB64zvPJhgt6PtwG1bljmHn9BOAlrHIAco4hIaw==
X-Received: by 2002:a05:600c:c12:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-438dc3cc378mr27543965e9.16.1738156288742; 
 Wed, 29 Jan 2025 05:11:28 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc819ebsm22108975e9.39.2025.01.29.05.11.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 05:11:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] tcg/optimize: optimize TSTNE using smask and zmask
Date: Wed, 29 Jan 2025 14:11:27 +0100
Message-ID: <20250129131127.1368879-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Generalize the existing optimization of "TSTNE x,sign" and "TSTNE x,-1".
This can be useful for example in the i386 frontend, which will generate
tests of zero-extended registers against 0xffffffff.

Ironically, on x86 hosts this is a very slight pessimization in the very
case it's meant to optimize because

 brcond_i64 cc_dst,$0xffffffff,tsteq,$L1

(test %ebx, %ebx) is 1 byte smaller than

 brcond_i64 cc_dst,$0x0,eq,$L1

(test %rbx, %rbx).  However, in general it is an improvement, especially
if it avoids placing a large immediate in the constant pool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v2->v3: adjust for recent change to s_mask format

 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c23f0d13929..0f34b7d6068 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -765,6 +765,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
+    TempOptInfo *i1;
     bool swap;
     int r;
 
@@ -782,19 +783,21 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         return -1;
     }
 
+    i1 = arg_info(*p1);
+
     /*
      * TSTNE x,x -> NE x,0
-     * TSTNE x,-1 -> NE x,0
+     * TSTNE x,i -> NE x,0 if i includes all nonzero bits of x
      */
-    if (args_are_copies(*p1, *p2) || arg_is_const_val(*p2, -1)) {
+    if (args_are_copies(*p1, *p2) ||
+        (arg_is_const(*p2) && (i1->z_mask & ~arg_info(*p2)->val) == 0)) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_eqne_cond(cond);
         return -1;
     }
 
-    /* TSTNE x,sign -> LT x,0 */
-    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
-                               ? INT32_MIN : INT64_MIN))) {
+    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
+    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
-- 
2.48.1


