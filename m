Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7DEA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3S1-0008LA-LK; Tue, 21 Apr 2026 01:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RM-00080F-8M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RK-0006SW-Oj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:28 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso27379795ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748465; x=1777353265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK09IV4jv+83fptexQw6qhQ3h5DqduadUD1Gz4A8BTk=;
 b=S+le+dy34c0SvWCe/PKDHJzCKytZFi2BgBVr4I2Z/F866eXTTJEd4Req6o2cUH+hLh
 20UCn3r+vjwQyC3Dtr9MJ41mLAxHFbzAKgKJzzbKny+kxhZePLP8g4Djh7kTwn7Yt5QM
 A2d2sIxhrxJI8ZI4r8IajN8+4RkDMyrC3ROq2qIVZkc6pR5ubq6oh7N4HH59AUs/RR7C
 gSNsAiPvnp95zUcgzla2QWXLs3UBQU3+DRVXxi8PzuTwfmkotLrnp19eaZbbRATnSelL
 nqj49cQtyNSFT9ahX42McY2KhhT0ChTRa1Nrt/zVCMvaQfTAwRPWxXwdLickfmETKjCj
 z6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748465; x=1777353265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WK09IV4jv+83fptexQw6qhQ3h5DqduadUD1Gz4A8BTk=;
 b=Du/91lHh5rOMWUH0G8/0pRUckc+DH7XZJBZluPP1QeVvW0blcqUewUl+q6ItPGoiRS
 vb3iYcKYPokIeB9PCCyEiNejeD5lLbxgX4fbg1/K/n4HI7Ry8cMP3WMPyn8g57OQkqjn
 dVS0z4j8VBtQ2FqJBQdd23H9/1pdb5Zz92dUMQh2m0ktYrkVPAjdBaYcBt2J8SrvsFVE
 CsV0tYD8SCKaQZHGEa+opg+bfiO7vlWcENaw1lbRj6rmd7Fj2EjSMnrR75lhEOMWn6k1
 k3Ddro6pTpnq0dvbJkJYdBuPf09Y3h/6R2yiNYk6pF8DuElhb/woZ/5ceUp/sWrBAVRL
 JpZg==
X-Gm-Message-State: AOJu0YzgQ/zgcRT5YVVf4ACd+sRbVOt/Vf3BdzSEBizmfXBZ7ktkaMwI
 b0jBWGErRKakhhc7WEcIOZTEJLsaOAy+kSaDqtsFE5HwRTh5LYS+uI1sxaMQ+x2WYcHdBXIS8j+
 KV3eLaIU=
X-Gm-Gg: AeBDieuHCQCj9Vh2hRWm82aTvQTqaBjnnvDbWZ4ottjF/Ib3dusQ6XeA5EoaUzFrWfM
 zmn3VlFGHksUmoivoZ7PVh0Ck6aW/U/uvbgnzOWar1Cx+/FJNnpFGtW+whT++cyZrvvCPP3NGe7
 M6m1igCcf8JxlOHZTvjNG96o2dtd7/yo3L7pEwDxgir7nRubHWSBRtPlkCqS3+e4zoH2cUR+Kyj
 72ekbmBCoTEnmeHafdhTazU4Dc/2b6R8x4stgI37qzIY8WyT+bYFoffpjIlY65n7j5BLS8ojTNi
 Dg8Jk6poFSL6wOue3f7vW/SYlM/42xpSOemQDPvtXSqHRpMTPgOrFXfVKMDIvS8qSwfLLQxAVj2
 Z3YMMyNNgQuNbYT6plPkCgwPgAwci90Uv3injhb8owEfC7uNxI3TNfGZSOnVBcpLP3uxSszDFm0
 QsMDZQvxmalV2dF45clUbo16n2Q3HudBezQvuIIXRB
X-Received: by 2002:a17:902:cf12:b0:2b4:460e:6fa8 with SMTP id
 d9443c01a7336-2b5f9f61d45mr158091645ad.34.1776748465172; 
 Mon, 20 Apr 2026 22:14:25 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/37] target/arm: Enable FEAT_FPMR for -cpu max
Date: Tue, 21 Apr 2026 15:13:23 +1000
Message-ID: <20260421051346.41106-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
index 343536523a..40ed799fb8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1287,6 +1287,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 579df4c47b..fda73d3d07 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point mode register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


