Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B8D43363
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 23:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTqKt-0003Ou-UP; Thu, 11 Dec 2025 18:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTqKr-0003Mk-OZ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:44:37 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vTqKp-0003Wm-VN
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 18:44:37 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so647034b3a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765496674; x=1766101474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n/kApJcFOEGmRRa1OLrQIEELHvqnoG2PtkXXaM683OI=;
 b=VDovCPwkfFJLoqMGtPnfgKo88xqACe+qbUU/Al2nKegO9mnjOcqNuMjXgoZxZBPxhd
 wBNJpA455OwFwIeZCFgw0ktX/1LFIJ9ubJ78kY8bCSHB/+dv0Rj2s5u72515dzhb2mO/
 xGFiJRwqhgAV0iguldObFvI5gZ8gK72Jyj9Icb0zOTexjuw6EtVxDLNGWjFVnB4cPlWX
 EGZT9mbv56GoplMNYPJFt5U5UZILKsTSq9cfd92ggTqrFyh0DgsGCKYHjp+4HzdYcQ2g
 O2PZyDQBv7VwicVzueaeMtSpV+Q62ycLvbVtwMI0r8FAN24wzTUpIRmsqLIHq4aPrATL
 7UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765496674; x=1766101474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/kApJcFOEGmRRa1OLrQIEELHvqnoG2PtkXXaM683OI=;
 b=Fh4eGAh5WycFfE1KN/+kvQzCAhWTzUCtxulykFjlbJAczx6Jkx5wPnHVx+xLzofH/J
 +i1o0YlajdY+5W9qra1dSCVbbA01Y8qad/ieLpLwQncyvG8N8PW6wbnwbFggK8TJu7ID
 KasT73UXAsxWRN8cV4d/gwiqF7q0wgYm0LO9f5D1/TOcLg4J280PRFBa16nxV/peH+ad
 eeMUdTU/FnXJIGHFiUepTBDEM9h2Q1B9Jqc0M7rFM3xxlqrJmlVh8sOtS3CM1lgKuLij
 cxEjnrELLppD/oFCV2fBKCv7LeI53SgMRReATCM3yb3ZrFDki19fPFSfdu0qcfnkHxub
 zecg==
X-Gm-Message-State: AOJu0YweOIB3SoVhNfOvYVJgkEIPvx9XVGIVIEripGj/Cp/LYKjEt1gl
 FFoyhAcEIsecaUYOTsZy9z5zOSYruIdaWNhpTkiqMC8OdGIpbwofbxLsN+XJUREMq4Xme3M4hRr
 L03f4Pwpn2w==
X-Gm-Gg: AY/fxX4PApJqO6AwOQwWJ8bfVqKFzIbOi1aAYQQUEl6T4JhGuatOJOY+ljjCdBO3QkA
 Vt0BHdWH0qoLgcWwMC3cA31Dy3QJjKBaqBkZ9FK9DpR14sK95gjDvzDFPuPF+9JUkHqi/VLFB50
 Pak0YZQAJMvOMBfsbbeXGUheGVKxEc7DIwptAkYwg5xvcOZDCO/krWB0U8/sZl4kWjGWuln3mrz
 4E/mJuNxVRjJNgd7Inzo6BQy32JPYjI5rblzVGYNOgIHdebEz3be7b2l3CAOFMxPN3KemomhLB3
 rZZ63eB1/zGi9vmJ6jCo6igp/+Qdmr1BHloAB7cfEhFpCsrCvinfYTRkXAZqa6KOt5H8wrvnoKl
 ns5DMUHSFdGDhWUfqCQM64TJdxbODIXnHu/FGJjRiaIDImTlqG86CCfhpH/X9XG0RQ1NAYKq0Sv
 iBylgmGhqaTwPqxOe+zPQdCQni0/iWdv7YbLquXsvCjFiDKK8m/kpVESQaRbt19mw=
X-Google-Smtp-Source: AGHT+IGpndTZ+y98hnvSU0KUXddeQJcFrDHYu001T78oBYlkCp01KrbUELyJt9ankzp6tdKGP//cWw==
X-Received: by 2002:a05:6a20:3d1c:b0:342:fa4f:5849 with SMTP id
 adf61e73a8af0-369afc018ecmr187326637.39.1765496674336; 
 Thu, 11 Dec 2025 15:44:34 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2599228dsm3370410a12.1.2025.12.11.15.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 15:44:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] target/arm: make granule_protection_check usable from SMMU
Date: Thu, 11 Dec 2025 15:44:24 -0800
Message-ID: <20251211234426.2403792-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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
+        hwaddr paddress = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
+        ARMSecuritySpace pspace = sec_sid_to_security_space(cfg->sec_sid);
+        ARMSecuritySpace ss = ARMSS_Root;
+        ARMMMUFaultInfo fi;
+
+        ARMGranuleProtectionConfig gpc = {
+            .gpccr = s->root.gpt_base_cfg,
+            .gptbr = s->root.gpt_base >> 12,
+            .parange = 6, /* 52 bits */
+            .support_sel2 = false,
+            .as_secure = &s->smmu_state.as_secure_memory
+        };
+        /* The fields in SMMU_ROOT_GPT_BASE_CFG are the same as for GPCCR_EL3,
+         * except there is no copy of GPCCR_EL3.GPC. See SMMU_ROOT_CR0.GPCEN. */
+        const bool gpc_enabled = FIELD_EX32(s->root.cr0, ROOT_CR0, GPCEN);
+        gpc.gpccr = FIELD_DP64(gpc.gpccr, GPCCR, GPC, gpc_enabled);
+        bool gpc_check = arm_granule_protection_check(gpc, paddress,
+                                                      pspace, ss, &fi);
+        if (!gpc_check) {
+            printf("ERROR: fi.type=%d fi.gpcf=%d\n", fi.type, fi.gpcf);
+            g_assert_not_reached();
+        }
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);

Pierrick Bouvier (1):
  target/arm/ptw: make granule_protection_check usable without a cpu

Tao Tang (1):
  target/arm: Move ARMSecuritySpace to a common header

 include/hw/arm/arm-security.h | 54 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h              | 39 ++++++++++---------------
 target/arm/ptw.c              | 41 +++++++++++++++-----------
 3 files changed, 93 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/arm/arm-security.h

-- 
2.47.3


