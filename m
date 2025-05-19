Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91589C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3P-0000cs-3v; Mon, 19 May 2025 00:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnU-0005X4-Cg; Mon, 19 May 2025 00:08:16 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnS-0004CS-Mp; Mon, 19 May 2025 00:08:16 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1fde81de05so2407529a12.1; 
 Sun, 18 May 2025 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627692; x=1748232492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdCffJ+XNsE2W4eMa2COlJLe6Kq0hb7x+qX3poViG4U=;
 b=TF5PIKrWeYFQqmOQjoD7gdFYulzkluFP7iILyISlwK06xpeghX/HpU87skjrcM++4Q
 bszihkpsEq3AguAHViUnlPbAIWOPCCH3yqipWFQS005DZ8TsNcLX9rUWxOg7A+RXazv3
 FWp5IGe/SrPFu7Yj6zBc54urVqzFgVTCELZ+Ci9e+3P5lERw3yQZjn5o5wnHys+4ZiyY
 xolYzt34gG+ELPXD67xQq8sjQR4rcBlF4H4ZgjYyHBxTg5S4yFXb4s4YYaJU/1qK+5kt
 QkyzHPdmNB+zzShEMBNSSu4O/n3YaNHeOOMQi0wsK8C09iAzQ1MGAyaJPplb28CqX6CR
 o1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627692; x=1748232492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdCffJ+XNsE2W4eMa2COlJLe6Kq0hb7x+qX3poViG4U=;
 b=HSCbRr9i1l0JWWEnXMk7GkV1nj7OyjVc81LXWV9rRMYzyecVhgnIPNSWJywDMQwPsd
 sh0pAZntecCn6EHQJVN/zntf7f9/dn36ozfYUessXwGLEEKFf4Nlu55V7oTKuPEzWCeu
 ghfMVONdz1qJrHXO6Pfx3VP+PEsLXaHgnsxfOP/7ApneiIKRQhE7lTP/RruW+7abuNPp
 JE8q6CskfjbqLfdfhwnSCqnKcGts3yWB/J0L2zpJ44v2bBnGKmTBtzBRjpQbENB6EHh1
 gRUx/SgGNXrdzW/MBX09uNnJl2gWsyK/ANwCIsjrKk/6X7s/b99vhN3QHJH4ocrbSgqa
 ofiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM7Gao6iB2rFU42ZfReM5hwxrfhb9TdMCkkkqp+MEOhaM72hVQKq0gYRuamjen/VIB/qfNpyxTderR8Q==@nongnu.org
X-Gm-Message-State: AOJu0YwnHrz3ZVmKJk2I9TkMjCl0hBcnLA1dz9XPAvVo2otxElD4Jsi8
 GoEGzwbxUJMWotj/m5YiPBeqUIOOI88QBhpu2Q2O2JNP9SDnDLzfB5IrltK1IQ==
X-Gm-Gg: ASbGncvZIWOy5LZeOFKrSgxW9XD6WbJWnyKDsNnjmX7Sn/SvmB65p37LqjftMAQDEEp
 RI+1nhsuoA/M1l4EX0kq/v64lIujPShBxZi6HtRZdGka66VxCzTQHHlI/V5eBxT/ceKk0Tgyeeu
 Tptr6lGwLNuXta4GCFlJv6b9nCGUcWjJnuAh5A/Wd+sSokStZdcuZN+xjjdoTnVXjWxcTRvAkXk
 /H/yQdEcXmmDu+OwVNdw0s3HKR37nqUlczvNZ0qmdJ0cb1QA4t9btmCtREitQy1Tpu6qrtjkQ8v
 C3ldhx+Haylwa5QAzl43ZIi8WkYyi0uNiJrud+Y5H8yQ4A6xi/T+a15uZ3c6wIKFOZ1781YFBv0
 WBvcf6aEWIZKOqCn5aVHIltQTU3fSBche3eNUwS8nSZ/wV1E+RIyAMftB
X-Google-Smtp-Source: AGHT+IEhKnvIaSPuM6czV7eN03ZR3wBAfCPA/L4ttEtGU58y2sc3XRtbVgUs6Qow89/bTdQHCJgxEg==
X-Received: by 2002:a17:903:1b6d:b0:231:cec7:34fe with SMTP id
 d9443c01a7336-231d454ebb5mr172968135ad.46.1747627692486; 
 Sun, 18 May 2025 21:08:12 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 21/56] target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
Date: Mon, 19 May 2025 14:05:18 +1000
Message-ID: <20250519040555.3797167-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Blanchard <antonb@tenstorrent.com>

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2110392d1c..d8333d8311 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2687,10 +2687,10 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
 }
 
 /* OPFVF with WIDEN */
-#define GEN_OPFVF_WIDEN_TRANS(NAME)                              \
+#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
 {                                                                \
-    if (opfvf_widen_check(s, a)) {                               \
+    if (CHECK(s, a)) {                                           \
         uint32_t data = 0;                                       \
         static gen_helper_opfvf *const fns[2] = {                \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
@@ -2706,8 +2706,8 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
     return false;                                                \
 }
 
-GEN_OPFVF_WIDEN_TRANS(vfwadd_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
 
 static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
 {
@@ -2789,7 +2789,7 @@ GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 
 /* Vector Widening Floating-Point Multiply */
 GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmul_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
 
 /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
 GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
@@ -2814,10 +2814,10 @@ GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
 GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.49.0


