Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47A9F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sf-0000Yc-D5; Tue, 21 Apr 2026 01:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3SG-00005Z-Oc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3SD-0006wa-CR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2addb31945aso24957515ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748520; x=1777353320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTWYsrlrSDgJMZnV9Rs9ckmBr1fuOPVbeNXWFzp4dX4=;
 b=o8Uk4K7WvtMb75ViyMAbgDfqH3LS1yhzw9O6VCboYZr8rMMgnTVwHx4J3QEkBAsfLj
 vyscZKCQREfACOA4XZ/PJqKN1p4aTck4rLkAvZ6YYW2NvtPaJadUrhpyu1Kf6TXDZmZx
 0pXWxcTYkMWV1m33Vr5Awzrb+AEpjUGhXTruS9urfmU8NC1yRDH2gzPBqJdR9R0+OvEw
 f/LT2xzpvMpHvXqjM24V28PVEoGjeNQeXZswJ80eEfDVVslZdS3HSy2a1fRA1djo3Qin
 4CZBBP1uId2TkwzT/wnjlyPWlVw7PVh+ZvbEGQRdGrT4pVvF22rlCfsL7hCKz7XZMi+p
 5sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748520; x=1777353320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tTWYsrlrSDgJMZnV9Rs9ckmBr1fuOPVbeNXWFzp4dX4=;
 b=OBiyRbozfGVwANzXlQxTLHi4J1h9JrqVYuidmTH/imz+q/xbPNIltw9OCeVSj+wC/8
 AdipUPx6QSEjlvwfHhdTKI6i/iMXtNupZHrX4BSMLRv9kodpOlEVUwnaVqMSsod9hN/L
 TsQqIYZAkn43u2IGEVCT+WMA5NVNDLNGdIJWx8Hu/JN/1pRTaEGHURir+Y1LT6iPh8Xd
 J1uixvV8o2QmgCppY8sGcXC0A47BChT2cuG13qUP9oDHkGqC2GMjpgBxvrMkRI2UvT9e
 LiifbB55G7d01ShC3VsNxZgPXr/W2pOLMRlEYB9KAx6irs/CS5z20qih1LCbSKqucpeq
 8GQw==
X-Gm-Message-State: AOJu0YwFNaJvqOewKT9XyAIUVmZ0Ulp55o2qhmJTYcnGcitKPFDILUnG
 CnzEzqj6F/vU1rAyo59HKS8R4MHSopLRRmzi1DGs8LCzJ8azQ65jEHzyMPApdgNtRrd3pEtD65N
 XISFZXP8=
X-Gm-Gg: AeBDieslbvGCcsjOzYVffEUE8G8jtYir9B9z2tqnScSDeZKkptqPoioEgjCHai8S1Ci
 XroZPPUjq/f9jGl1oOuP9tBIrQovVEonx+kqy4kvpT778RpyJgplo4N/3EQk8MJe2MSMuIKHQEb
 EU3CSkFzpFx6LRSKQTgUCamIAx0z8ZvW0/gAx3VsocA8/0uDWbTagV4zz3Ash/tSxtqGX2BItR4
 E+vvwDN3hWpV8Ni6s2iAFDV/5vSirSt6trHvaWb3wuctOYoWIg2ExYzuWrGhsSwGJaZ0OdWnxTG
 e6/7jZHhLtlBhKp6Q5Pv30TR98YKlQORmKaOxmXWeGbM89a2Dp0jqFW0uZwgklQY02hazV3/auT
 jhi+/jQkeyS2anESQOXoj4ZsEnmhn2mU9kvNY75WwDqCgr0ZtliAgBECMYbUP6ZbcDznwMxNmVl
 piwrarpKtsBq46COfwjiQihvLIpurbvudV+0ujHn5DPPLoF69iK/0=
X-Received: by 2002:a17:903:3d49:b0:2b2:3eec:c75f with SMTP id
 d9443c01a7336-2b5f9f638f0mr131009515ad.28.1776748519874; 
 Mon, 20 Apr 2026 22:15:19 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 37/37] target/arm: Enable FEAT_FP8 for -cpu max
Date: Tue, 21 Apr 2026 15:13:46 +1000
Message-ID: <20260421051346.41106-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 40ed799fb8..f0cb03fdf1 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1380,6 +1380,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index fda73d3d07..b0be880ae6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -72,6 +72,7 @@ the following architecture extensions:
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
+- FEAT_FP8 (FP8 convert instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
-- 
2.43.0


