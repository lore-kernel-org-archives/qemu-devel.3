Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A79D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 00:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVIVX-0008C4-45; Mon, 15 Dec 2025 19:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIVV-0008B2-Ai
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:01:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVIVS-0002HT-8a
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 19:01:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so19350655ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765843291; x=1766448091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fkFXL27/vO6rPF9XJikLFrhlDyxaIrdk7FdCvb5lKGw=;
 b=OItXTErI2s8z6fhuGMne2TA/gryBve7YC1flG/2R/8qA4fbZkRriqA3bxFjYCyVvFa
 EgekkeCI4+gUe02E3TEHO1Be7D8mLMl724hZ0G556OEt74MOMjigMnbjSVjdDwEpXWEV
 cUTjR1DxlQbZfmW62l9o2M7T9axhZEmibTe7b/VIKseorwq3Cb9ikgWrVsfV3GVkAY0T
 EOzjRsP8LAH4u24G/IauQXeF2FTVkjG/liK8fPsC9BLip8XvtN8tvxw22NDdZ/45TSrn
 0XK6adFBvNAceUJtsvGWLNzP4iKJDfepNhi6ZVFXWBYTkgoEyKIh5KXCdWkx5rFzt96Y
 XCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765843291; x=1766448091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkFXL27/vO6rPF9XJikLFrhlDyxaIrdk7FdCvb5lKGw=;
 b=hWDpeogjjKkPd3suSQAB4fr/BVmIohoEQkJmwL73aEICU6KDpHfwa/XEfsw4tAmuEO
 MLE0chAL/46eaa4LljlXI46JIhcQgi8zchhnQRAcIrff+328nlAHntZz5AoSmcYmhBtd
 Mf5rNMwSNczSzh3a9U6sfjHfGAauS8/x4YJLrgsljMu9LjhQ19mfKNSvmIGGoLuk/N01
 03xwDOj+nWG9//cL8jzNLTpNuCs5Kr1p+Hf+LaQqEAnfoQD9vAyAMRQVy6HzNpvC7haY
 i0HMFLEvzcECv6xr+0AA4T15119tmLryeGeWXCGsFj7doBOPU0/+Q8cdjzIT8OkBsOKT
 Oadg==
X-Gm-Message-State: AOJu0Yy8cIMHDtc+PLBt6z/ernVW0GFcilgMtDfWfJUNmbdyT4p6vbr5
 5U1p/qFxkzmoVkrYflKk/ZMk3O62kvhixiMkNxr0p3OTtqkrDIusExDG9x+Rbm8XImLS3m8MbIA
 cicQJEdo=
X-Gm-Gg: AY/fxX7Z+BfIaUR+ECWPIz0pJ12PTA4YXgv21rQGoYWJzOTMa84T7/6g0W5wQzjvWS6
 t3Y5nK2Utq0hWgGTL3bh/KSzoP4Alkexfjy5Fw3dfqvYjyjvBllV3/Qas7hhfv67l2s6OxLjgkR
 JpB73uoOc7MStdo62ny9Z4ZbMkT+egzYfZgbVTNcyt4w0Q/JHiXOBT0ZlXtRbiUAu5hLVubMi5r
 ru3nYJVs4nHHKO1vtHIjC6v7wyytbpZRqcm3fxkm6i3O+t9n6l+Aq5uDO+o2z/f4B1sbE9MA1Q4
 AyTKpAR1mh2BoTX+5LThIdgHpYIJkmiJhGYINl4/E/0ki8sEr5b8Vl3H4Zd+22BBbVxkvzb3aBQ
 /HFQgQPwriIktkkQqCRAIcYJE3OV382N5zxA+YFXnPqstPkKxKCqgOwAmgOO/WxEhKJ6tiMH37P
 UO5Kv7sHRHweEswnOYQ3kDMUKRJyjceJwckyfOBqU80fUkfUIqA5khvaIDf+sD9PM=
X-Google-Smtp-Source: AGHT+IF/q6BhU7z0qzoinfuuOaUDWex1w5dUCEIKRwNnMP43Rcmtj8JCbiyvbvlY1ZV7ecBMWzotYw==
X-Received: by 2002:a17:902:f682:b0:2a0:9028:11af with SMTP id
 d9443c01a7336-2a0902814c0mr92509175ad.59.1765843290349; 
 Mon, 15 Dec 2025 16:01:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a0e96df1c9sm44882915ad.39.2025.12.15.16.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 16:01:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/2] target/arm: make granule_protection_check usable from
 SMMU
Date: Mon, 15 Dec 2025 16:01:20 -0800
Message-ID: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series prepare granule_protection_check to be usable from SMMU, for
implementing RME feature.
It's based on Tao's commit [1] extracting ARMSecuritySpace from cpu.h header for
convenience.

[1] https://lore.kernel.org/qemu-devel/20251012150701.4127034-5-tangtao1634@phytium.com.cn/

To demonstrate the purpose, this is the (wip) change to use that from SMMU:

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 80f48df3dda..1acff3bbd66 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1055,12 +1056,36 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
     }

     cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
     if (desc_s2_translation) {
         cfg->asid = asid;
         cfg->stage = stage;
     }

+    if (cached_entry) {
+        /* The fields in SMMU_ROOT_GPT_BASE_CFG are the same as for GPCCR_EL3,
+         * except there is no copy of GPCCR_EL3.GPC. See SMMU_ROOT_CR0.GPCEN. */
+        const bool gpc_enabled = FIELD_EX32(s->root.cr0, ROOT_CR0, GPCEN);
+        if (gpc_enabled) {
+            hwaddr paddress = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
+            ARMSecuritySpace pspace = sec_sid_to_security_space(cfg->sec_sid);
+            ARMSecuritySpace ss = ARMSS_Root;
+            ARMMMUFaultInfo fi;
+
+            ARMGranuleProtectionConfig config = {
+                .gpccr = s->root.gpt_base_cfg,
+                .gptbr = s->root.gpt_base >> 12,
+                .parange = 6, /* 52 bits */
+                .support_sel2 = false,
+                .gpt_as = &s->smmu_state.as_secure_memory
+            };
+            if (!arm_granule_protection_check(config, paddress,
+                                              pspace, ss, &fi)) {
+                printf("ERROR: fi.type=%d fi.gpcf=%d\n", fi.type, fi.gpcf);
+                g_assert_not_reached();
+            }
+        }
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);

v2
--

- remove extra boilerplate/include/line from arm-security.h
- use local var gpccr instead of config.gpccr
- extract GPC enable check out of arm_granule_protection_check
- rename as_secure in gpt_as
- use arm_addresspace to retrieve gpt address space

Pierrick Bouvier (1):
  target/arm/ptw: make granule_protection_check usable without a cpu

Tao Tang (1):
  target/arm: Move ARMSecuritySpace to a common header

 include/hw/arm/arm-security.h | 37 ++++++++++++++++++++++
 target/arm/cpu.h              | 59 +++++++++++++++++++++--------------
 target/arm/ptw.c              | 59 ++++++++++++++++++++++-------------
 3 files changed, 110 insertions(+), 45 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

-- 
2.47.3


