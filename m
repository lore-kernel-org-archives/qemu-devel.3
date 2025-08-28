Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8348CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau4-0003M5-TV; Thu, 28 Aug 2025 07:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau3-0003Ks-7q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau1-0005kq-Cr
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3c7edd71bbfso591181f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380887; x=1756985687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EnGGrcv97B1m9Yhyyzk0TCrzPdK4iabw1UUxjeGtLm0=;
 b=EELQuHTRxwpjAy+S4mh+yNqrsogCTx7fxObZODrlQIkcvyI/FlA04Qci0xqzmBidih
 gE/0Z1cnFHcbEbmaz2Lkn6PtH2FgqbFvBCz7zps0HmR18epsw3KBkUhwtOxd28N3Y1iH
 LSEt0z5FLkgiloCAweBgANMqqpYMJ81xAuSbOLnNXeQX0BnQPONgRIYs5HzDcmg352I3
 m19gaekeBiM8OdPNoCEITHU4BaD/ms1SxRyjlD5hSopw2LmdEY2/jV0sW/jhlbsbCMHh
 dX+mWrfnb21HCjqGHRNQMOlS/Pv5d/vkBCMsO0+CqPVv/wE0wu1Ky5Ukjg8H1EXCMpd+
 Vc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380887; x=1756985687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnGGrcv97B1m9Yhyyzk0TCrzPdK4iabw1UUxjeGtLm0=;
 b=YZfYhMHNtgDSm4kfFGQXmDwgtEmKdTk5ZvbU2BknEZaPmVz5dNEHlxTiuEoo+CquQq
 F2dudaSLqFqGA3ehyeFi4DoKBcIMfnqj4+4pH3NUAQp5SmAkHOEZyk9tfLolpwfNiGEo
 HKQ6S6yLf6PSqmmbbmUdUcPERHBp7yQ3U0s6ssO1Lio9I+1prjidSFJEsyp1bwdkSY7Z
 wJb689dUIfWlmnaEgu/VmEEGtiTJ01mmQTTT64ppHOzK7n0B9CQuDR89hrWWWZJwsXu+
 C7OnkOB4I1cRN9k7E3mFd6kNmMdd/CdJ8+ZYcC7G46DiZjIj6mavXDHpxibRYRTCdY1W
 De3A==
X-Gm-Message-State: AOJu0Yz48LCcs0C08d243vtTwCHrSCi4iBeAJQfaibPw4gxtSmHRM6C7
 wwf9GXFl3fstCTNsNxpN0mB87B6i34OEX046P3l14pmme+/J6bLXvggRwCBbwpXJSsgBIdKB33y
 7acq9
X-Gm-Gg: ASbGncvObE+tnbkzGwXURsjyt2GVerZ0PJZKP/199OX0BPY+E0Ji4yB7MIFBGLdjV9v
 /N5Oj8VvolqDUMmb1dTu+bGWGZhB9zv73T3EUBaw/rpmlw22XKOKqG/TDGaj6lv5u6wAMV1ypcl
 sUDrt2+uXdb93nYae3rwg6LhJpdiDDqjDbo9/M8PQQKsnJixV/5IEZpu1V1dMWXSx6dDdEwo+b/
 H89/nQlqFbz8aNS6l1WYOId0x5xja3a5JvAiofkSBahICNrM5OvscSVSO5jn8/JxrVMP2O+M6+d
 Z0aDYKp9lqxsLB/PqH4Y5+4Lv5qWXrbCGokh7F0fsnwWVd/dbnwsd3fDOhth7DFcALQTigDxmis
 hgU4TECRNwFN0YSK46/d+OIO8Hen4rodFOQPUfTA=
X-Google-Smtp-Source: AGHT+IEK3Jn6RMpgrGSjsU4+RCTgzWAVF8xAIPG9vm94prJO6lX3c4c3qChjik9DnvFxvyxTCYOYaw==
X-Received: by 2002:a5d:5d0c:0:b0:3cb:46fc:8ea8 with SMTP id
 ffacd0b85a97d-3cb46fc9040mr6613020f8f.3.1756380887507; 
 Thu, 28 Aug 2025 04:34:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/32] target/arm: Enable FEAT_CSSC for -cpu max
Date: Thu, 28 Aug 2025 12:34:10 +0100
Message-ID: <20250828113430.3214314-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-7-richard.henderson@linaro.org
[PMM: rebased to handle linux-user elfload.c refactor]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d86738..b12f013b4fc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -30,6 +30,7 @@ the following architecture extensions:
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
+- FEAT_CSSC (Common Short Sequence Compression instructions)
 - FEAT_CSV2 (Cache speculation variant 2)
 - FEAT_CSV2_1p1 (Cache speculation variant 2, version 1.1)
 - FEAT_CSV2_1p2 (Cache speculation variant 2, version 1.2)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1030cb80947..482c0df2d7f 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -212,6 +212,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_sme_b16b16, ARM_HWCAP2_A64_SME_B16B16);
     GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
     GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
+    GET_FEATURE_ID(aa64_cssc, ARM_HWCAP2_A64_CSSC);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4eb51420ef6..eaf8846a6a5 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1178,6 +1178,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
-- 
2.43.0


