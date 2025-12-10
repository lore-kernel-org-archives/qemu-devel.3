Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42DAD3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4U-0004s7-GP; Wed, 10 Dec 2025 08:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4I-0004py-HH
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4G-0003E6-7J
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpoQK+0nuozislWPiqikqnKa1Cv0Zspgf159fKre7JA=;
 b=awIgbBZ8xTx2eeKy7YyRQl/BMjyKMciLZ/uVzmCUWA/35dUgI1vm76i1kXUxU03LaDuKKF
 CZIt04lcekKsynDqU2ijaewRIiSEXpe7hIGyoGuL0TEg6zQRE+geS+NkBOANVOmeZHC+23
 XX/nsUo/wpZXhsZfGobUs3j3BDUeI/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-0WHtGTYKOLi_pswMQoz_lA-1; Wed, 10 Dec 2025 08:17:15 -0500
X-MC-Unique: 0WHtGTYKOLi_pswMQoz_lA-1
X-Mimecast-MFC-AGG-ID: 0WHtGTYKOLi_pswMQoz_lA_1765372634
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so3415858f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372633; x=1765977433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cpoQK+0nuozislWPiqikqnKa1Cv0Zspgf159fKre7JA=;
 b=ReUDEwYlbJDzVRolo9DP21RE9/cHaQkW2JRotRJukvVIyn9rhXAtTTdbQH3Vt1ZsA9
 Swwz27d6KbqNa+34ufjP/WL3/p756S139wtDlR8ngxNc6OoMWQcJgUFYtkf//kV5IkSH
 POxzjdHi7BDQxFUnsvHwgcfdr8wEWIXSkxFi6DBQ4uqG7riwxz6PA0Nh8EiqJP2qZez+
 FIo5W8535xq2UE2gvh2NAOl+xJM7ZZYutkNxuMGWR8uquirpXpJDKkBBeq8IsY1ewPpp
 +IL+Wg9vImKrUyAibbYjl2qOL4iMwpDIkru/ZwSwgtR5DhB1nklDjNNuapiUfQAZ+V2V
 rCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372633; x=1765977433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cpoQK+0nuozislWPiqikqnKa1Cv0Zspgf159fKre7JA=;
 b=YbOyIQ7QS3ptRFzsSpxmvnfgNwh9cHFw+DdYR1O+cbyugxNk9ZaTR5njAUOMrzBFKt
 5pvciCI/zZGX87P+aVk/vUwzWZATwEE+PEn59K1t3Qqvz970XTz34/9K/2SgyDxEPuxU
 1nmTo5yO4G6YlozgQRZ1vQcQhXiq0x2rrCITCVIynA43tT02tq9bhNkvILdAHO7aHqKc
 02/I5yphvZKBmCegI4fuujXbnvsYhbq1lLKYYo89cX6T9ov6wTleGT9yDPi1DwYkCiU4
 4QerGVCXKDjuNpSr3qfFLPdbhL8XZlVvWYVp13i15O5mtj9AGpblhXsIZ4OaqV4UFFCV
 m9fQ==
X-Gm-Message-State: AOJu0YwEL4EfBcRK87YkdnT5ryjsLaL/oxCxKHd7TtsFIzo+fA90PdDF
 wMs0PHVTEJCAGX7Q1J4KiR0X6NACjnQTFVzm1z3AsrhthDOXGg4T2MxcZp6CUPsoVsoUuWv0uKW
 bM/PRBPvyJBPubsAkUNfA9LYntfHs40GuBW6J/Oto7bgfFmAxf+UC8VRWE3AHfkiwqyjW0p+Tpt
 no3EYQKCVLvj0OIetTft6eo0fRntM0UJuCZrbgUcUQ
X-Gm-Gg: AY/fxX4A0Ip9bEv19L3vksrBLftsirPMnCYfhcnKuYDKgAElg6N/A7FZYEB7ObLeVTI
 eWM9dora3n0yVv8qPgz4a8g5vpnaWoYOyeHQmWbOzLfsLshSNaOXPY2U6bNHdL1PBP51k+tHyje
 iQuHNJbmbTuakMFUg2hUJv0gCCgE9/KHrt2AOoKNQvycuwxHVceicw3J/B3EMY9mXylJwrD3Rdb
 rw4MBDGtRX1oCje/62ywnWfVhUsIJt3ELBH7EPYAGohZmedwWA9whSRbG8Jlxtdik+Obazr5viy
 DKYjUtLszkIT9umsnv3pL9FTYVcRK66l3/PflmW8pIhCLqhm7roi8TA2FOxwd/2Tg65xF9QhWCx
 DRKe5pjDYhDPJnaghQ/2ga/GG5/7gjKU0yTDg09rLKCp/YBjSpZZfQRzH1HKjjF5A86hCGNQ3Rz
 xpzkRXV/uD5c+pu+Y=
X-Received: by 2002:a05:6000:402c:b0:42b:2f79:755e with SMTP id
 ffacd0b85a97d-42fa39d8607mr2803245f8f.3.1765372633215; 
 Wed, 10 Dec 2025 05:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG50R2/eay63rrmwVO+kA7ClBQJfCqD16oMV0WZlRHQ/uYY0g2XmiTn13c5wtYnnSRQyAMMhA==
X-Received: by 2002:a05:6000:402c:b0:42b:2f79:755e with SMTP id
 ffacd0b85a97d-42fa39d8607mr2803208f8f.3.1765372632755; 
 Wed, 10 Dec 2025 05:17:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7ca4f219sm35843868f8f.0.2025.12.10.05.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] target/i386/tcg: move fcom/fcomp differentiation to
 gen_helper_fp_arith_ST0_FT0
Date: Wed, 10 Dec 2025 14:16:45 +0100
Message-ID: <20251210131653.852163-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is only one call site for gen_helper_fp_arith_ST0_FT0(), therefore
there is no need to check the op1 == 3 in the caller.  Once this is done,
eliminate the goto to that call site.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c755329b3d9..3c55b62bdec 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1485,6 +1485,7 @@ static void gen_helper_fp_arith_ST0_FT0(int op)
         break;
     case 3:
         gen_helper_fcom_ST0_FT0(tcg_env);
+        gen_helper_fpop(tcg_env);
         break;
     case 4:
         gen_helper_fsub_ST0_FT0(tcg_env);
@@ -2460,36 +2461,28 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LEUL);
             gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x10 ... 0x17: /* fixxxl */
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LEUL);
             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x20 ... 0x27: /* fxxxl */
             tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                 s->mem_index, MO_LEUQ);
             gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x30 ... 0x37: /* fixxx */
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LESW);
             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
-
-fp_arith_ST0_FT0:
-            {
-                int op1 = op & 7;
-
-                gen_helper_fp_arith_ST0_FT0(op1);
-                if (op1 == 3) {
-                    /* fcomp needs pop */
-                    gen_helper_fpop(tcg_env);
-                }
-            }
+            gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
         case 0x08: /* flds */
-- 
2.52.0


