Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7793FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziet-00039P-Mk; Mon, 09 Mar 2026 18:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziem-00033q-26
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:57 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziej-0004Yc-Pz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:55 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79868cde1eeso132686787b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093652; x=1773698452; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f0cSdpBLxPbmGMgvkaOnNCGqIDUbCYxrFo7c36qodk4=;
 b=fTG17XXw9qyj2qIS0Nac+9Fjra1Rt6QUH1vq4qRvWuikEQjYjyVS8QjNfD8KB+3XPk
 nFWuuU+/i61kvDqhUVa7LQCGP1eS7QMUuMoIGO4/ZKuB3TsdCY9ge4SfwGET9vTDd5Tq
 dDksFRdYNjpnrcKuOVTDcvRBfXJYhHdfory/xnLcAWAhfCxuec1+MeixUrQytxaDbL51
 K5Jy6f0uHJVuBiRMrEPJHQw/H0l0uy8OnAacYmjtRjERr3UM60HYXo8oJQUZWN5Tbrhv
 aqv38AaZdnPRJ9qHoC2cc2Msfa903IcUZPytp4L4FQaH+w+lyWY9QRdjy6Tqx2alx2mX
 Sfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093652; x=1773698452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f0cSdpBLxPbmGMgvkaOnNCGqIDUbCYxrFo7c36qodk4=;
 b=mFTMCc7p+61X0uduQyvk8fAqYrI5EmjEKCE/yPxNb1GCJgXtiJ3kffcnypdw2iFFDz
 muXjfdGmuo5JZu3fm6FbAKOmy4tmvAHPdpmB5mJf6j+W7gZKbT6a4+2grzt6hTDxFet1
 ypAiZeRyVlCtcrlbNOeounpIWPSI1egF+rbDP6isxvQi9BGVy3H0ix0Rzg8XzucDHQlI
 T3ZbNxTkqF8/98LXBI9P01C2CjhwIM+l2jGz/9vTOqL6Cc8bgw1PlzKOauG38YroCMn4
 rWo2MevCupk81vF+/W5uxKkIjCVbhfSvZ7/XfZQbgf2HAHPv/n5kijCU1JdbR1b2Z4ju
 eEWw==
X-Gm-Message-State: AOJu0YwtpnNUv5iOZLR2JCdW1Uw9RevH9+C4a6+eVBd+PCpM2/C1fsWh
 /v9ET5+2VWgl4kSRr3kiSjqlLVIVHFSzr+MS5596TnG3pnuC+f41Tbvq
X-Gm-Gg: ATEYQzzyABtE+i6rmhvM+iNhYEc2iou/ElyUw5nGiraXajbBXapjOzuJSzTVt3etKNd
 UezTZxzmZVYP1W7LY6HRfW9n3dtAnfkf4GLOgXr/wmMV0+ArCvdqhVyg0ZnnNaOznEmS942a5aP
 WjbPd1WjkNXJ5uOpCtSU8j0MFnHsfuQYGwExlcGipZcf354MQ7dhAj9qVgmbmB+CvHgjEAsgvK5
 yJUiOJKmqFOOkE1tXDZws0+YVTldclVf8VqWFy4IRPIaGYjxfBgMn1tjTxrBwtxTO5K5Bq/OhgA
 OB+iNUzR0UdHnH0y7LiZRhR0HTWrTMrT4T3vhQ4raFBScPBWW9LTMstsvM8cWkBSKTDDlcWOvRQ
 1DoPt0c6mLdOhUGM5dUbCrUYJhWbCEgY7jDv6L5oPE+TRJzHPp8zH+tC71DZQMO2QCo6nIbxh9X
 7I+g6LnWqzQd2hDHDeHppcdNr/Ie6ktKx9tI0=
X-Received: by 2002:a05:690c:6e83:b0:798:769e:ec44 with SMTP id
 00721157ae682-798dd79453amr111610677b3.54.1773093651891; 
 Mon, 09 Mar 2026 15:00:51 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:51 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:41 -0400
Subject: [PATCH v4 09/13] target/arm: with MTX, no tag bit bounds check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-9-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=5011;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=g+DPdAhyY+UIYOMM9CEaKmfl8VqevdmlMc/7aUSAHfs=;
 b=/nzqKf6VfiU7+i9VaZ0+3BtRx+Qbt6K2v2Rf+RC7uizOcI+exHeP22yAYf5iYL6sCrY7cH8cK
 vqMNJDQrKW3De/r37ZdmWJH0Fm78miSs40TDpQqQecE3wfS0dufJqCS
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Virtual address canonicity checks should ignore mismatch in tag bits
during translation step if MTX is set.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/helper.c    |  6 +++++-
 target/arm/internals.h |  1 +
 target/arm/ptw.c       | 28 +++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 56858367fd..a61944dedd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9747,7 +9747,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
-    bool aie = false;
+    bool aie, mtx = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
@@ -9784,6 +9784,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ha = extract32(tcr, 21, 1) && cpu_isar_feature(aa64_hafs, cpu);
         hd = extract32(tcr, 22, 1) && cpu_isar_feature(aa64_hdbs, cpu);
         ds = extract64(tcr, 32, 1);
+        mtx = extract64(tcr, 33, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
     } else {
         bool e0pd;
 
@@ -9799,6 +9800,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 12, 2);
             hpd = extract64(tcr, 41, 1);
             e0pd = extract64(tcr, 55, 1);
+            mtx = extract64(tcr, 60, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         } else {
             tsz = extract32(tcr, 16, 6);
             gran = tg1_to_gran_size(extract32(tcr, 30, 2));
@@ -9806,6 +9808,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             sh = extract32(tcr, 28, 2);
             hpd = extract64(tcr, 42, 1);
             e0pd = extract64(tcr, 56, 1);
+            mtx = extract64(tcr, 61, 1) && cpu_isar_feature(aa64_mte_mtx, cpu);
         }
         ps = extract64(tcr, 32, 3);
         ha = extract64(tcr, 39, 1) && cpu_isar_feature(aa64_hafs, cpu);
@@ -9905,6 +9908,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .gran = gran,
         .pie = pie,
         .aie = aie,
+        .mtx = mtx,
     };
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 52597a351c..2c4369cc16 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1396,6 +1396,7 @@ typedef struct ARMVAParameters {
     ARMGranuleSize gran : 2;
     bool pie        : 1;
     bool aie        : 1;
+    bool mtx        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d381413ef7..e31b3085f8 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1929,7 +1929,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        uint64_t top_bits = sextract64(address, inputsize,
+        /*
+         * If MTX is enabled, bits 56-59 aren't checked for canonicity
+         * during translation, since they will later be checked during
+         * the tag check step.
+         */
+        uint64_t masked_address = address;
+        if (param.mtx) {
+            masked_address = deposit64(address, 56, 4, param.select * 0xf);
+        }
+        uint64_t top_bits = sextract64(masked_address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
@@ -3481,15 +3490,28 @@ static bool get_phys_addr_disabled(CPUARMState *env,
         if (arm_el_is_aa64(env, r_el)) {
             int pamax = arm_pamax(env_archcpu(env));
             uint64_t tcr = env->cp15.tcr_el[r_el];
-            int addrtop, tbi;
+            int addrtop, tbi, mtx;
+            bool bit55;
 
             tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
+            mtx = aa64_va_parameter_mtx(tcr, mmu_idx);
             if (access_type == MMU_INST_FETCH) {
                 tbi &= ~aa64_va_parameter_tbid(tcr, mmu_idx);
             }
-            tbi = (tbi >> extract64(address, 55, 1)) & 1;
+            bit55 = extract64(address, 55, 1);
+            tbi = (tbi >> bit55) & 1;
+            mtx = (mtx >> bit55) & 1;
             addrtop = (tbi ? 55 : 63);
 
+            /*
+             * With MTX enabled, bits 56-59 are not checked according to
+             * AArch64.S1DisabledOutput.
+             */
+            if (cpu_isar_feature(aa64_mte_mtx, env_archcpu(env)) && mtx &&
+                access_type != MMU_INST_FETCH) {
+                address = deposit64(address, 56, 4, ((mmu_idx) && bit55) * 0xF);
+            }
+
             if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
                 fi->type = ARMFault_AddressSize;
                 fi->level = 0;

-- 
2.52.0


