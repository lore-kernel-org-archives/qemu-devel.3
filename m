Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40221D21264
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MaD-0005mh-Ex; Thu, 17 Oct 2024 05:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1MaB-0005m0-8j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1Ma9-0002Ug-Ie
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729156448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7D2q4GegnvVC8fr/YynFn0Bq28q3DgZueEGrK5m0WmE=;
 b=J59/0djnUr1+/eruHKFK6gKtXhgwLnWKOJRJwRFpVFTDta6QGwRD8yTcgDU20JtUIpJlqx
 XaOPqNBifqJOSt6ppVOrodr+k0x5vWTaztJfHsoqlX/dl5lAVVuBH5VL7OLtUu35k6L3LX
 V1acg7tdYL6RYj4hhUat2G7RHFUga/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-1BanoPX5MmiOR3Ql8CVsRQ-1; Thu, 17 Oct 2024 05:14:07 -0400
X-MC-Unique: 1BanoPX5MmiOR3Ql8CVsRQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so285509f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729156446; x=1729761246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7D2q4GegnvVC8fr/YynFn0Bq28q3DgZueEGrK5m0WmE=;
 b=dj8zqB+PvMUnBu87o47CFNCrZRWLt5rCgPifATIarD6XF0dsHpqiEFXpXihdLVHRbu
 xvTAiI9/EGNKgYMP+t155AWA5RrDH44Mau+jojOueEh7BCJnDMbCKhhjMAyfv2R1oWrD
 If+ZrgZypk5Yiz1wO+rjH6IkROcmFz3B1ZCdqyJps/UxaNetuXvzvKukXL03zvCy9hKF
 G+TjuAn9QHqXXkCkhX/1l+TU/1RdDs0mOQfyXMl326uVD5ab6ultAr4JLtIvu0m4hKYS
 3CCIGd/l1Gt883tzlNJMs7FrhyAq42Q/BDy7ygjkNHX8HvIdyZJgean4/g/0QAR/f9CJ
 /wgA==
X-Gm-Message-State: AOJu0YxRa6LDThtBz9NKYu3VlD/IZazeKy0wJpQrPu+rgvqnOywDOGUU
 HLTmokJELAEEXtqK/xXeIXO5JrdwYjZkWz9mNQgi7580k9oUBtOtGw63mRUD9HHBVrVzMaaYnwt
 yRejWnAxsHaZxdlajSugfcMOt2eY1Wy2AVs/nSoIudJE0RDz6wPtYuwJkOLjt47/GtopxaB+pJZ
 zBF+rhs/Cp91TWjWgMbTnNlLT9tprrFqFO41msBdk=
X-Received: by 2002:a5d:598d:0:b0:37d:3b79:d1e9 with SMTP id
 ffacd0b85a97d-37d5fe95608mr13673703f8f.8.1729156445659; 
 Thu, 17 Oct 2024 02:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorrcSt99f5CxJdubWbZAPchM1CNTi3d8kJpD82eGfhjp9hw/0v8D4+PPmrYS5EZFKiX3dzw==
X-Received: by 2002:a5d:598d:0:b0:37d:3b79:d1e9 with SMTP id
 ffacd0b85a97d-37d5fe95608mr13673679f8f.8.1729156445143; 
 Thu, 17 Oct 2024 02:14:05 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf838dsm6661997f8f.78.2024.10.17.02.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 02:14:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
Date: Thu, 17 Oct 2024 11:14:01 +0200
Message-ID: <20241017091401.783102-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

32-bit TSTEQ and TSTNE is subject to the same constraints as
for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").

Adjust the constraint and make tcg_target_const_match use the
same sequence as tgen_cmp2: first check if the constant is a
valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
non-test comparisons, finally check if the constant is a valid
operand for 64-bit non-test comparisons.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/s390x/tcg-target.c.inc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a5d57197a4b..27bccc14e50 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -565,6 +565,20 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
 
     if (ct & TCG_CT_CONST_CMP) {
+        if (is_tst_cond(cond)) {
+            if (is_const_p16(uval) >= 0) {
+                return true;  /* TMxx */
+            }
+            if (risbg_mask(uval)) {
+                return true;  /* RISBG */
+            }
+            return false;
+        }
+
+        if (type == TCG_TYPE_I32) {
+            return true;
+        }
+
         switch (cond) {
         case TCG_COND_EQ:
         case TCG_COND_NE:
@@ -584,13 +598,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
             break;
         case TCG_COND_TSTNE:
         case TCG_COND_TSTEQ:
-            if (is_const_p16(uval) >= 0) {
-                return true;  /* TMxx */
-            }
-            if (risbg_mask(uval)) {
-                return true;  /* RISBG */
-            }
-            break;
+            /* checked above, fallthru */
         default:
             g_assert_not_reached();
         }
@@ -3231,9 +3239,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
+        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
-        return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
-- 
2.46.2


