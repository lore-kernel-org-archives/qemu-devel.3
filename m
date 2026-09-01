Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79E9C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONd-0001Pj-E2; Tue, 01 Sep 2026 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONb-0001Kl-Sx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:23 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONa-0007Ky-1x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:23 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso775703066b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268701; x=1788873501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PEi8jGFgaRCgBW7jEoxN8hzMz3pAXb3DvYTFRVPdJvI=;
 b=bEdwN0TcpMIcEcKGS7yXNhvnK/TGfh3fSP423F5VI++P2S6XL0Kz6joSZY6NZn5dfw
 QCdnSpw7CTlSPv/3Qv8ZhXMYRbaWn3sW6MihbOvgetfPRa6Ikf+uIAqECEf470vE2AY1
 66XY3wUB+IDAHakvyHc0gnnSL2FtgTNKocWP2xDhTshCJLREg7CwtDxBi9bw50RSBdI5
 bZINTk/26yQvSA1D4peGB1QMR1sbrkt/3rWo+swmTIwsS0Xtkqg4pNYUypgBFCRTtnk5
 hxn26d9a7bor2eq6QxUZ/dAXV3GhEe0V0C3IKv+buVZ2QYU+RHMzhk9/H/gqc9Q5wZF+
 ggVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268701; x=1788873501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PEi8jGFgaRCgBW7jEoxN8hzMz3pAXb3DvYTFRVPdJvI=;
 b=GnZPJVHa85ZCOSCTXZtPKZVdh1NGqt7hTkl5Vt5wKFCkoFbObd76aKAc7d5NODAUjn
 Q7htxKvaJetneJqonOpmcMtwQkmZpUhmKSg4C+dFycsy1uJy/q3pxne/PfKqRbTjlOwb
 KGTYk9ud+Zcz0YK4meNI8SA/fO1va09dixSOT9cni9qlAmyAwoLwIaLzU+LVsAYGrYN+
 vOoZR5RxeV3yeaWyhi6IpxV6AUPr99JjFqG+xb8kOsk82S7BwiiU3fy3kQZ3Zm9RwWds
 Xz9Or6+D4I6G7Qka0iPmzbEyVmspdjyhqRfa5hOv7aL4sxA9YVqmHPnO9X5D8KN1TYhk
 HP5A==
X-Gm-Message-State: AFuF++kGTrHPIkBttZwNDMFNSxqOdTMEWeD7l1xL+1ozoEGYBoBjNHoP
 /DNjrTNafbYwbnGpSFRiJ0nTZ9k550CgYh4yV6aQR8yI39WKIX5eV8lgzEHe37Kf6vpertQs2Sb
 +LfrGOc8=
X-Gm-Gg: AYBFou1PpGGAbt4nWgu0/P0pEqu8I7bb5tkSjZhM/pcNv5Eod3JNpMvwmljOtMS06C9
 M3mXynqJKOZdaj57pnF9/eMpSGJDE9rFPjmZRnq9OrAUV2Lr2c1lFdxvuXI35g2Bs7Mp9gA+9Oi
 K/vA5kR55SFg+9D5DgdUyxt3IQNkJNDONZTQGH8AxDgyWCmCJXchpAfMmqYre9eqZfzZEslFQxS
 /EYNJ1F8UuiS7o7lWaoFnvgF+j/Fr1b/b6Ey42Ukj7KLCef15UiTjjqee1hXO6oLPHBZct4gjvY
 4VOr6+m4yDCfxi2Bwz0P41nrGzcxquNkOxYZQXU4uUzDEQ1O3v+JNbGeyjsbhU1evZ/P89Xry7s
 sYJ1niZNPnFNHHg9I0JmncS4eWD9UP/rXSWhQolg9WK3t8cw0M9dFF/MRGZm29hb0lhtr0KCS8y
 xDoHe/mXCNgVwwWQOUNTVfqZezphS5xCofPbwxjrSLIqAvJ1a3CcFSk1F6U0MM11R8rJHy8sMX4
 5y8I1rInDswJtAmG7D7G6/exKmE6IRmO7U4VLPZAHfN88weT7YBLEZzFxytcoGP26Qzsg0=
X-Received: by 2002:a17:906:564c:b0:c25:9195:6ece with SMTP id
 a640c23a62f3a-c25b3d82a76mr504054466b.23.1788268700568; 
 Tue, 01 Sep 2026 06:18:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/58] target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
Date: Tue,  1 Sep 2026 14:17:21 +0100
Message-ID: <20260901131732.2263947-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 862341933ac..af5245cd21b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -199,6 +199,7 @@ the following architecture extensions:
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
+- FEAT_SVE_BFSCALE (BFloat16 Floating-Point Adjust Exponent)
 - FEAT_SVE_BitPerm (Scalable Vector Bit Permutes instructions)
 - FEAT_SVE_PMULL128 (Scalable Vector PMULL instructions)
 - FEAT_SVE_SHA3 (Scalable Vector SHA3 instructions)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index c086548f7fd..bcf2e6b9c18 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -180,6 +180,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
+    GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 12270b42977..2eb049b6002 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1474,7 +1474,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, ELTPERM, 1);   /* v9.4: FEAT_SVE2p2 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 2);    /* v9.2: FEAT_SVE_BFSCALE */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
     SET_IDREG(isar, ID_AA64ZFR0, t);
-- 
2.43.0


