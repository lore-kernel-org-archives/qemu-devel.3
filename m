Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61DFCCD195
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lKS-00036t-6W; Tue, 14 Oct 2025 16:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lKC-0002od-54
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJC-0005R4-Ba
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso67771635ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472464; x=1761077264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbIPf39C/nOyYzA/Hj0JrQcXy1Pq3ydN164jP8835Fk=;
 b=uQuRuQtZSHnomhDr3AHn9tFy3uMDUgjnfoWYx2wrHU/E0TAyIivsq/Gm828V1CxUub
 VGBY74FnCvLpsXZlGI5yz7Zr+osIGUpQxnIcpjgWeoa31IPWnug1cO/oxkmvM10GW3dB
 z+5KyL0WR8pq06BvB4VsqMAB9qvjTxz2I6Yut2o+COIzpmTgoHYDP7QCTa6Y09d4nABy
 tjuoAvnp/loTbxdvod9kO5aXvmDuDbbnRex1dLqko58ao+5c/ic5IoFry6xKLBpvEd9L
 Vq6cQMHMkVkyCEwPRwXCKzCOUoTN4nL5cz3AbiQTD62pVVDYE5eBPRGfeeg6QKiOCGVJ
 eDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472464; x=1761077264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbIPf39C/nOyYzA/Hj0JrQcXy1Pq3ydN164jP8835Fk=;
 b=L30Vzl/CMwCjYmgEtXh+zVphq71qluebpS6LgZijWTaEq1cVpWGV2QtFvI+zaEjPIr
 fDm/RXrF9YcQIlP2fOTQdCks7auEBTGJ6AR4CXreSeyZrq9ZwTnJLTc8xfNAEH0S2/vz
 +ayy4c9QwpcVgFpuivpO91N8akztwQ5GaVO/p28FS1YA5/zRDaJrSPDCCuLtl+CHrIVj
 QVzOBi/FgvK/VB8OwAdDYCm/nMTrM//KcbY/+xRuK6+xmESURvlGjwro5n96TWJD+/wa
 yeXKVUySvLXJp6neoF/J6KV9VAY+DxAoXfVgNQYUNPZ07PcN8UOWzevpiL+vgp52+YC1
 GF2w==
X-Gm-Message-State: AOJu0YzMutjnL3spqU8AQNYxoAs/F/7w7BElLN7nD1FjNfPEIJPTiH8p
 ax8WLBFRvQFi4x0b1k4424HJCDqo6XhKQd++cZxewq6RdCvCc1YK0j6HmO17JKTpXgmrFccV2NK
 0jSb7ZD0=
X-Gm-Gg: ASbGncsnrfZSdotx9g+tuc1mOKsShnL/9tKgd7vJx7JavAoY5N+4w9YqmO2KKTnKioG
 zGoEoig1x7fVV/Q+D6gr9/zX25ha7gVLNmLu6eA/o0JoJjT8SLi8DgKjighO3LO3PZHOic5p2LW
 IHuVlqJ+MHmqCNw8Lq2YoXDow9aabE60gYwDbLY59PkpYUkyAdSP3f8XflFjs9VNWvda+PnZ61h
 4yY1zuVWOae6DPZxT1PsnwElJR4Ke00ArppKs9RtRjLY2GWS9qASehRTPhE1t7XZMU0VUY/N3Nh
 M5EwOXah01/oeiqfI8VHY1ww2kJf7UDVn+ysPOUpr7MH3Haka8/tKqgXyoCUQA9M2enJHYoW5WC
 fftdPSkVT5QwT6+/0QRn1aBsFqwFGeB7wIgw3n6j3+f4jAFhCxEM=
X-Google-Smtp-Source: AGHT+IGd5hkteQKarqIN6FTT4P5RJrY0E4jhj9ekdZ6C8HtQrKdGIgcbtoxACBZflDvUMeEj0JWxdQ==
X-Received: by 2002:a17:902:d60f:b0:269:ba61:222e with SMTP id
 d9443c01a7336-29027303330mr328562865ad.53.1760472463921; 
 Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 35/37] target/arm: Implement TLBIP VA{L}E2{IS,OS}
Date: Tue, 14 Oct 2025 13:07:16 -0700
Message-ID: <20251014200718.422022-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 10ee973068..ea2b56e245 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -518,6 +518,17 @@ static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
+static void tlbi_aa64_vae2is_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      uint64_t vallo, uint64_t valhi)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
+    uint64_t pageaddr = sextract64(valhi << 12, 0, 56);
+    int bits = vae2_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+}
+
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
@@ -868,13 +879,17 @@ static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
     { .name = "TLBI_VAE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2is_write,
+      .write128fn = tlbi_aa64_vae2is_write128 },
     { .name = "TLBI_VALE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2is_write,
+      .write128fn = tlbi_aa64_vae2is_write128 },
 };
 
 static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
@@ -1421,8 +1436,10 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
     { .name = "TLBI_VAE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 1,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2is_write,
+      .write128fn = tlbi_aa64_vae2is_write128 },
    { .name = "TLBI_ALLE1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 4,
       .access = PL2_W,
@@ -1431,8 +1448,10 @@ static const ARMCPRegInfo tlbios_reginfo[] = {
     { .name = "TLBI_VALE2OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 5,
       .access = PL2_W,
-      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS |
+              ARM_CP_EL3_NO_EL2_UNDEF | ARM_CP_128BIT,
+      .writefn = tlbi_aa64_vae2is_write,
+      .write128fn = tlbi_aa64_vae2is_write128 },
     { .name = "TLBI_VMALLS12E1OS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 1, .opc2 = 6,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_ADD_TLBI_NXS,
-- 
2.43.0


