Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C9FC83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 04:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6Cm-0004XS-Gf; Mon, 30 Jun 2025 00:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6Cc-0004Uc-KZ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:10 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6CZ-00054a-OF
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:10 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a5903bceffso55177571cf.3
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751257983; x=1751862783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7p1tDIFwTjQb2kYrEx8VXYNJTLr+20o3ghBktTtRy4=;
 b=pzhPGvEhKD/+PcEqWjwDYSgJPmNxg8E3+mfBciB1cUbCDb7s/MXLmRrLUkjPPciGhR
 kEv4Es8T42MAvK+aL7NLbdKftoZI60QpwYkqHim8L9VI6/r4TE8wIu8jTLYvszmzJhgP
 JgFs0rpt4AGwC7SsCgwgsn/9jgpuhg05loApohwsFBVnBmO1s2JhKjwNIOHqABBjVmHg
 jczQmr9yFM+k2q0BoK3YtjxtARjZiF4QA5GaP4Aiy+D+YxNua+cfa7onSzTTgLph6atV
 n6nf87Rp09HoUPiMf/ccpLjxMboiby3DMRNORtjv9LX+mUqInbQ371UlIjJwMKf2ZcVB
 xssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751257983; x=1751862783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7p1tDIFwTjQb2kYrEx8VXYNJTLr+20o3ghBktTtRy4=;
 b=Xmdd8lBqDIpuAdE1IddAZM8hwHxx9kpGgA3uqFxbMEba3lNQL2YGgINV/IdXjLZoZX
 pyFS/QagU/JoTZVurjhuWQHxmcW7lmG4DXq+tQXrheSBHAkWVKzWJvfekcz0QRgNNV89
 2G9dHkbzvY8oT+szQIyCXAubpLw4lPI/NtyNrLvm92mfc4Twp/fRNR13vLL5pkqJSgek
 3TKSwihQSeHFYBQHK6VRCinO4kvOi25u8A+X7vLG+t4zEKVOa1aqTB9s6BAUbX7ACC93
 mZNFrUWuYWHjJzoU9JMV25SvlDroyXkhaSPekdP+ZnZYvKMhTOPSMZUBJZuQtPED9rs2
 hyzA==
X-Gm-Message-State: AOJu0YywVEgx+FRlTkM6TYUaokEKiGcRFOWCZyYpNXIzB1V6WePdlXf8
 r1rC1pb7A7RZjd750LfXbpZdfpxtDdm2PRL+QNPWJnFmfmPjO6kErIhgQCsXTvS4xUI0urAoFNF
 no35w
X-Gm-Gg: ASbGncueJFWGKh+Tsgd14iJ92Ybi7bBf/ebGy7IUJ86p0oYwm75BGWQ4/eFFUT5+bIb
 SaRXYM4+vuHBn8rx5Ir0OwgjlM34N4pfJz3X51xGA9U4kQ9PwrHuvClVY+QX/hhBC1geth5jBJM
 3pDzh6Cy+z213Xq4EoAoBN2oyI05NSOBHsqUTBHRGY+3aLpkFFxnrKKdVkCIzYdG7ucjkd9rDhC
 m25pLLAziZlYtd8TSzW98GdX9jX949Jq9EPK+u8XLt677TrbuxoBHtSeQs8/cUv90ioJn8moqxv
 s03/ncvghwtRJGHSWhM6/fe4OgVcVmKnYOh/ixveAdvwk7A68I9HFPa32jHLiMyI32s=
X-Google-Smtp-Source: AGHT+IFj5wFwbOMqR/+3+2Bt9LpdUyGqCRpRf2COHd39idOzknEGTiSuLuiV7CPBqU8z7ahE3cAL6g==
X-Received: by 2002:a05:622a:4012:b0:4a7:a8a:eed with SMTP id
 d75a77b69052e-4a7fcae72c0mr214110621cf.39.1751257983162; 
 Sun, 29 Jun 2025 21:33:03 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc13971fsm53470171cf.20.2025.06.29.21.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 21:33:02 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH 2/3] target/arm: Advertise FEAT_MEC in cpu max
Date: Mon, 30 Jun 2025 04:32:36 +0000
Message-Id: <20250630043237.996788-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630043237.996788-1-gustavo.romero@linaro.org>
References: <20250630043237.996788-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qt1-x836.google.com
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-features.h     | 5 +++++
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 7 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 78c2fd2113..68acb49825 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4452e7c21e..128d75e68f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -593,6 +593,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
 }
 
+static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr3, ID_AA64MMFR3, MEC);
+}
+
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5d8ed2794d..66c4d1d789 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1242,6 +1242,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64mmfr3;
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     cpu->isar.id_aa64mmfr3 = t;
 
     t = cpu->isar.id_aa64zfr0;
-- 
2.34.1


