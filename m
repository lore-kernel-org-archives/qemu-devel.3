Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C18C369CF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zxs-0002j2-FV; Thu, 17 Apr 2025 20:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxV-0002II-1L
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5ZxT-000688-5l
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso925287f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937513; x=1745542313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUftrT9mw1sdbt1Cgea3mziIB2FdIW29aFiLhpIfymM=;
 b=r2gyQ5xLQO1UCl446GZLr/c+UooTdmoGo967hSSQqFTG2EtOIwYLvpOJh7qlGTuxze
 8c3aG+SnWCrjy++qbuDryIVf4r22ct+EaVD0kS8amBqCRuiyMWYfdHE72JIGvJHR37jf
 BZBaUL9Px/wkZZyofbbfsiHT7xxxYxFUPBqF+exhUnVcMGWUYCJM3kP1pPtiriZAU4Uq
 X6Pms+rO6Ttl/lPaEXDWEp45kqhLPWgWhhhYyLWa/njrca75jIgcNLhUQAZNyYdM2B2j
 qPxZyBPgZfUu5DLPCcsdnC4Bc0I4hh+/BFcRbSKCttZXjBJZD1Gm4J9C5uRKwFNswC4d
 iLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937513; x=1745542313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUftrT9mw1sdbt1Cgea3mziIB2FdIW29aFiLhpIfymM=;
 b=qGQSOCZxBwBejF4KRMJ61QsrBS5+XCO6VV5q/dvWn6zq1ymfRvgKlOGrPu4nHlH/OZ
 fspNnF77eC6o3kKKGQup4rBv4Yn0CEECPuC0bzbTI+eSqf4JiV9p08p4+n4pQWYJFho1
 aA0z32M3lWs7eIv2PN4SBD5HJDFXIvfpnPgXxCliI9uBIGBSb/Shm4YKFvE2IcYtMeor
 534XnGrEuIdZB7YhAPtvF1Nmdb9id6Zzc9aZbtg3wDT/nAXAoIDCUREAcxREhm/26/yo
 /rALEiJlLswdqvFs/dlV4CCD6AAhLF/nXGzy9JOKQNg8TlzqAIecsk1t9qjbEmhkbn4q
 y01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh/3bPXX7T3aPIS3uqJVB2rGJkzi1gXyI2AOePdtNmD/zs0J7NAs20nrWMsKzpbmHfEw65FYnm4AYd@nongnu.org
X-Gm-Message-State: AOJu0YyaDCxljqwmHebYjc2iGtje2dKDACsqU+SNFWLjkmiAGekGPyUQ
 gpFW+Lf/H8Qh2rtkGS7NBmDwmclsLjTHowB4FcTtgradODFhpbyPAexDcDqBc3w=
X-Gm-Gg: ASbGncsu/UJsBmN8OFbeMlovSU/0ZSvA/ly6unxKEAs41gZfxsM1hWwPldV2t6TY+Mu
 /ZqukjzizC/rSOw1TQ3s0o8YSOGoQMSYKvAXW3DD9oT20+p04hZZDbwmkMxU5aYicMb70R0mVxc
 DufLCw7PTn0STA+OG9DJVwS6rUBgKiZaCuMJG6I6A2nLGmIPaisDT5TGFMiWNgYcYZ/6wzWbhTY
 X2xInnkiAzj33THV8i24SW9kBhaG75KKucrZtPta9eLDUfeRY82sqzlY/BDUYLk8fhE4V4SjtWI
 xsKPRIG+AVGWHX1QnhKcRQk4jXoud9BuQbjoZ6vb5RdWo/th/wDHovr+yZcov3239yyedEJAweb
 VPdYcfcN/G8l7OQEXUGrm
X-Google-Smtp-Source: AGHT+IGymwmjgGz/Oothgof8/UtKJpBKKJxQ0Ep9UmNCVkvR4uwKpbGwfVwYWLOACFL1tWfuDt7Qmg==
X-Received: by 2002:a5d:588c:0:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-39efbae064fmr531643f8f.43.1744937513590; 
 Thu, 17 Apr 2025 17:51:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4c8fsm1109311f8f.89.2025.04.17.17.51.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 10/11] hw/arm/aspeed: Build objects once
Date: Fri, 18 Apr 2025 02:50:58 +0200
Message-ID: <20250418005059.4436-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
remove the TARGET_AARCH64 #ifdef'ry and compile the
aspeed.c file once, moving it from arm_ss[] source set
to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c    | 6 ------
 hw/arm/meson.build | 4 ++--
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index d54ee2d4b53..363be2daf60 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -179,13 +179,11 @@ struct AspeedMachineState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
-#ifdef TARGET_AARCH64
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
 #define AST2700_EVB_HW_STRAP1 0x00000800
 /* SCUIO HW Strap1 */
 #define AST2700_EVB_HW_STRAP2 0x00000700
-#endif
 
 /* Rainier hardware value: (QEMU prototype) */
 #define RAINIER_BMC_HW_STRAP1 (0x00422016 | SCU_AST2600_HW_STRAP_BOOT_SRC_EMMC)
@@ -1663,7 +1661,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-#ifdef TARGET_AARCH64
 static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1713,7 +1710,6 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
-#endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
                                                      void *data)
@@ -1936,7 +1932,6 @@ static const TypeInfo aspeed_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
-#ifdef TARGET_AARCH64
     }, {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
@@ -1953,7 +1948,6 @@ static const TypeInfo aspeed_machine_types[] = {
             { TYPE_TARGET_AARCH64_MACHINE },
             { },
         },
-#endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 09b1cfe5b57..f76e7fb229f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,15 +39,15 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
+  'aspeed_ast27x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.47.1


