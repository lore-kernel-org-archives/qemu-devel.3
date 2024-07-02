Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293CAC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiM-0001eU-Hw; Tue, 02 Jul 2024 05:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiJ-0001QQ-0z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiH-0006UE-4b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so2250208f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912130; x=1720516930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqX6iaUQgzL1offrhP+HrFxeqPqsVcUC+AhsVlpqm/g=;
 b=p1t6KJV70eZsL15wNHuZpbnL3b11zlNsYJEATh/eGjHZcv04hEFe/sumsaFSwvNr78
 UxVQv8YYeCSyhrHhvSK+Mt+7nmxUVIICOPvje7rgkaDisa7c7sjuJcIx3ICiRaKclN4/
 dMhQW/g5YzSkwBET2pNqfvMteZh9jKuLRhwO0W5RYfDgboeYX84UWTp5c3fRhFCHOAAU
 OpjP2dR10LoROusD5U/9hgz9T5R73S85fWwix98CbrjLSNgVZqNgNAtPHTC4JvgDZrDH
 RkHHqsuOQ5bmmI3W0Qxjju+521XWxveQVOZTYv17LfKUsdW3uj4rpIxZjACaCnwEBxFT
 qZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912130; x=1720516930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqX6iaUQgzL1offrhP+HrFxeqPqsVcUC+AhsVlpqm/g=;
 b=FntdBzXJTFVLP+hL69Mb19ZTjahzEuvsaC008n6Ch+edJpbfh2Fzz+40Ta4cgygEvD
 qbo0vpyROgAH/a+aoYrtofAFLfoeA+u72PypwUjZm8Rdlz/zAxVRO84ZYKC9rf3Pj6fJ
 ng78PQGjUBJBiL2Gtois8l81VYHnIwUic+/ViYsKwrCtyGLlTGZpOBh+cenO4ajsXvxx
 hBebOj7yZoCJCZCMa/6jB+LYBQLOnAP2PxTziC87XYYNEWmGxGqiUX3BX82pJ0gT4gU1
 Qc5kboHpkwRvp9dVSSXwzbfIMrZwoFlKcSZm7OWi7EKOU+i3TplbIOxF3ElA8aTxXFYC
 96tA==
X-Gm-Message-State: AOJu0YxCc/wfAFQwd9cTOkNeNZ/r382sIj6TlIUYpVSah7dYDBbJjKCl
 b3dFzviEL+DMgbnFaSOtOkWt/dzvAHRQ5QeeLAIalNR3FN2921AJSs6PMmpBpx2sNePX+xpGXc3
 b
X-Google-Smtp-Source: AGHT+IH/Y9BwftBzWc3gClvIqL5hK62V0hzPkVAdId21uR+VecvKVtyAi/xBI3OOdHofyZUB1v4yMQ==
X-Received: by 2002:a05:6000:b01:b0:363:ac4d:c44f with SMTP id
 ffacd0b85a97d-36774f6cabdmr7104281f8f.17.1719912130181; 
 Tue, 02 Jul 2024 02:22:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm12665190f8f.99.2024.07.02.02.22.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/67] hw/sd/sdcard: Introduce definitions for EXT_CSD register
Date: Tue,  2 Jul 2024 11:19:56 +0200
Message-ID: <20240702092051.45754-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240628070216.92609-18-philmd@linaro.org>
---
 hw/sd/sdmmc-internal.h | 108 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index d8bf17d204..936c75cace 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -11,6 +11,114 @@
 #ifndef SDMMC_INTERNAL_H
 #define SDMMC_INTERNAL_H
 
+/*
+ * EXT_CSD Modes segment
+ *
+ * Define the configuration the Device is working in.
+ * These modes can be changed by the host by means of the SWITCH command.
+ */
+#define EXT_CSD_CMDQ_MODE_EN            15      /* R/W */
+#define EXT_CSD_FLUSH_CACHE             32      /* W */
+#define EXT_CSD_CACHE_CTRL              33      /* R/W */
+#define EXT_CSD_POWER_OFF_NOTIFICATION  34      /* R/W */
+#define EXT_CSD_PACKED_FAILURE_INDEX    35      /* RO */
+#define EXT_CSD_PACKED_CMD_STATUS       36      /* RO */
+#define EXT_CSD_EXP_EVENTS_STATUS       54      /* RO, 2 bytes */
+#define EXT_CSD_EXP_EVENTS_CTRL         56      /* R/W, 2 bytes */
+#define EXT_CSD_CLASS_6_CTRL            59
+#define EXT_CSD_INI_TIMEOUT_EMU         60
+#define EXT_CSD_DATA_SECTOR_SIZE        61      /* R */
+#define EXT_CSD_USE_NATIVE_SECTOR       62
+#define EXT_CSD_NATIVE_SECTOR_SIZE      63
+#define EXT_CSD_VENDOR_SPECIFIC_FIELD   64      /* 64 bytes */
+#define EXT_CSD_PROGRAM_CID_CSD_DDR_SUPPORT 130
+#define EXT_CSD_PERIODIC_WAKEUP         131
+#define EXT_CSD_TCASE_SUPPORT           132
+#define EXT_CSD_SEC_BAD_BLK_MGMNT       134
+#define EXT_CSD_GP_SIZE_MULT            143     /* R/W */
+#define EXT_CSD_PARTITION_SETTING_COMPLETED 155 /* R/W */
+#define EXT_CSD_PARTITION_ATTRIBUTE     156     /* R/W */
+#define EXT_CSD_MAX_ENH_SIZE_MULT       157     /* RO, 3 bytes */
+#define EXT_CSD_PARTITION_SUPPORT       160     /* RO */
+#define EXT_CSD_HPI_MGMT                161     /* R/W */
+#define EXT_CSD_RST_N_FUNCTION          162     /* R/W */
+#define EXT_CSD_BKOPS_EN                163     /* R/W */
+#define EXT_CSD_BKOPS_START             164     /* W */
+#define EXT_CSD_SANITIZE_START          165     /* W */
+#define EXT_CSD_WR_REL_PARAM            166     /* RO */
+#define EXT_CSD_WR_REL_SET              167
+#define EXT_CSD_RPMB_MULT               168     /* RO */
+#define EXT_CSD_FW_CONFIG               169     /* R/W */
+#define EXT_CSD_USER_WP                 171
+#define EXT_CSD_BOOT_WP                 173     /* R/W */
+#define EXT_CSD_BOOT_WP_STATUS          174
+#define EXT_CSD_ERASE_GROUP_DEF         175     /* R/W */
+#define EXT_CSD_BOOT_BUS_CONDITIONS     177
+#define EXT_CSD_BOOT_CONFIG_PROT        178
+#define EXT_CSD_PART_CONFIG             179     /* R/W */
+#define EXT_CSD_ERASED_MEM_CONT         181     /* RO */
+#define EXT_CSD_BUS_WIDTH               183     /* R/W */
+#define EXT_CSD_STROBE_SUPPORT          184     /* RO */
+#define EXT_CSD_HS_TIMING               185     /* R/W */
+#define EXT_CSD_POWER_CLASS             187     /* R/W */
+#define EXT_CSD_CMD_SET_REV             189
+#define EXT_CSD_CMD_SET                 191
+/*
+ * EXT_CSD Properties segment
+ *
+ * Define the Device capabilities, cannot be modified by the host.
+ */
+#define EXT_CSD_REV                     192
+#define EXT_CSD_STRUCTURE               194
+#define EXT_CSD_CARD_TYPE               196
+#define EXT_CSD_DRIVER_STRENGTH         197
+#define EXT_CSD_OUT_OF_INTERRUPT_TIME   198
+#define EXT_CSD_PART_SWITCH_TIME        199
+#define EXT_CSD_PWR_CL_52_195           200
+#define EXT_CSD_PWR_CL_26_195           201
+#define EXT_CSD_PWR_CL_52_360           202
+#define EXT_CSD_PWR_CL_26_360           203
+#define EXT_CSD_SEC_CNT                 212     /* 4 bytes */
+#define EXT_CSD_S_A_TIMEOUT             217
+#define EXT_CSD_S_C_VCCQ                219
+#define EXT_CSD_S_C_VCC                 220
+#define EXT_CSD_REL_WR_SEC_C            222
+#define EXT_CSD_HC_WP_GRP_SIZE          221
+#define EXT_CSD_ERASE_TIMEOUT_MULT      223
+#define EXT_CSD_HC_ERASE_GRP_SIZE       224
+#define EXT_CSD_ACC_SIZE                225
+#define EXT_CSD_BOOT_MULT               226
+#define EXT_CSD_BOOT_INFO               228
+#define EXT_CSD_SEC_FEATURE_SUPPORT     231
+#define EXT_CSD_TRIM_MULT               232
+#define EXT_CSD_INI_TIMEOUT_PA          241
+#define EXT_CSD_BKOPS_STATUS            246
+#define EXT_CSD_POWER_OFF_LONG_TIME     247
+#define EXT_CSD_GENERIC_CMD6_TIME       248
+#define EXT_CSD_CACHE_SIZE              249     /* 4 bytes */
+#define EXT_CSD_EXT_SUPPORT             494
+#define EXT_CSD_LARGE_UNIT_SIZE_M1      495
+#define EXT_CSD_CONTEXT_CAPABILITIES    496
+#define EXT_CSD_TAG_RES_SIZE            497
+#define EXT_CSD_TAG_UNIT_SIZE           498
+#define EXT_CSD_DATA_TAG_SUPPORT        499
+#define EXT_CSD_MAX_PACKED_WRITES       500
+#define EXT_CSD_MAX_PACKED_READS        501
+#define EXT_CSD_BKOPS_SUPPORT           502
+#define EXT_CSD_HPI_FEATURES            503
+#define EXT_CSD_S_CMD_SET               504
+
+#define EXT_CSD_WR_REL_PARAM_EN                 (1 << 2)
+#define EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR     (1 << 4)
+
+#define EXT_CSD_PART_CONFIG_ACC_MASK            (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_DEFAULT         (0x0)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT0           (0x1)
+
+#define EXT_CSD_PART_CONFIG_EN_MASK             (0x7 << 3)
+#define EXT_CSD_PART_CONFIG_EN_BOOT0            (0x1 << 3)
+#define EXT_CSD_PART_CONFIG_EN_USER             (0x7 << 3)
+
 #define SDMMC_CMD_MAX 64
 
 /**
-- 
2.41.0


