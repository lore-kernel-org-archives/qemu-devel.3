Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922AC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7U-0002Ua-UY; Tue, 11 Feb 2025 11:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht6D-0006xC-5C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:04 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht67-0003aQ-SH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:57 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso12784475e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291214; x=1739896014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sRqqPpGVbwUeVvN/4CiKtvqDsOf3lS1J+P0K/UtKIGM=;
 b=RerYIHJaUgQek9/77BzcHQhsUbUweBRe0A1y+4S0OheRPn63BiWK6SS9so+Tu7iQx+
 MfsPz2vfufgRCSItd+gZ5tSAHXhiaUSlRpeo64+YK3w6DKC5t03EQvo10vgnXTONeOpi
 aEY+e17VPNgjcQ3VRDX3UmXTETlqHAujFRy68FwoApsNom+BEUtPYDgbX01mAwG7qLO0
 ayncaI6A1DraXIcTNXds1gBZMlEpJFXvhT5KwXtlrJibw00eavmYYPSqEUesyrtu4taI
 uHkaAh5yYre9DThFcq87H7zW2AaygFHMePtoCzNwa7JZtVWUXoikZRATZBzYHm1WqcKP
 efpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291214; x=1739896014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRqqPpGVbwUeVvN/4CiKtvqDsOf3lS1J+P0K/UtKIGM=;
 b=Wl/ah5udKzhjafSbPt0o3A5ZVfRob36DGnuchH2gT+5jiTYmexETLZOA6b4raEbYP2
 u3SMWUE54CdNFo1I1XAtZwkavamYbcogoqfsxuT0PpvqLsbyRG1ftz14su5FjhOvJaiy
 esVp2lZ1gf4KWs0kkgpdpk6H0oXpbeSXnfETWvDHaX22Swbx7U5e8xBRkLCsJFVnYRZB
 7d5ZWhuqnC3vmXD3fG4SeCf2QlV8VuqcikITG72ojqoqUrjNaYSZemoGM8QJH4AaSjQn
 iqnXjayBomOWgfj3iIvCB51wvjvO0HVE0BayiVh+5d2pVxpEPnQcMEH0sMxDQwWDUipK
 E1Uw==
X-Gm-Message-State: AOJu0YwKJdrEOScowJbn2RjHKs9+JmZlCuiur1h8saLv7hAqK++12CzV
 GZOIiTSQr+oFDGMog2E1fuVHG4X/w8qoI3l/EhO3uEPBv4HueOPMTz3Et06BoBgBzqF4KlxsKXT
 J
X-Gm-Gg: ASbGncu+xzGvJynNaucGdrs9n49mFJ6KTwEw10DMMZiME88WwxaUVg0tEBAkL0ZshL4
 n5oijiO5g2DlfvuZhsdvcDyTzp9aTjv1zFMve3995F8jyoOhJxRGlMPNp7/u2qdKMOgk1zxmRFy
 6XCRbILYHl8t5eiuS+3iLaEuWA0QmIDbKkv6RJgs4wD0gYYEar4EZs+90P+IHKJahuPT2QE56EZ
 oiVRxD7qDF+KRls/jx/lwdsXSjABJ05DU35/ik/0uuKPtusVKLjyLP2NN81NBsutk5+y1m3V+Bf
 nBdteA/0TKJBCVjpdWpf
X-Google-Smtp-Source: AGHT+IFEz7i6DmpGREQnkTm8JKLBgm8//BheM8UHu3EBT/kXQynYqRnkahxeZviWbQeFtLQjwbL8OQ==
X-Received: by 2002:a7b:cd17:0:b0:439:33ac:ba49 with SMTP id
 5b1f17b1804b1-4394ceaf87fmr36667045e9.1.1739291214239; 
 Tue, 11 Feb 2025 08:26:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/68] target/arm: Enable FEAT_RPRES for -cpu max
Date: Tue, 11 Feb 2025 16:25:41 +0000
Message-Id: <20250211162554.4135349-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Now the emulation is complete, we can enable FEAT_RPRES for the 'max'
CPU type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 63b4cdf5fb1..78c2fd2113c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -118,6 +118,7 @@ the following architecture extensions:
 - FEAT_RDM (Advanced SIMD rounding double multiply accumulate instructions)
 - FEAT_RME (Realm Management Extension) (NB: support status in QEMU is experimental)
 - FEAT_RNG (Random number generator)
+- FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SEL2 (Secure EL2)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0bc68aac177..29ab0ac79da 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-- 
2.34.1


