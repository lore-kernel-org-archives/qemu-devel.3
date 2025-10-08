Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA71CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEl-0002Gq-AE; Wed, 08 Oct 2025 18:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDC-0001Kl-KV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCW-0007Pb-Mh
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso198822b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960795; x=1760565595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEx/hrefNIXj4jtd/TlO4/MQQCdcfyzeDKOCLqegICo=;
 b=JTKwqwI5+W4eT6nHHfY+8Lyb9mv6+QydhnK+n1OKuFkGQFEvf9tFBUl1kkciMfFQ5k
 3aKq4Qn3+/7AgDe3WpMF9rqveNNDBp1J9Vxt0/ZKG+ParYxG/KI8LZlW4548aCbkfxpG
 QgX2gIL4Gi9CQRHarPAEkSze3D/e/SgZnkc0UG/LUh3OqtFx9QFBNW3Ket3SYVteYI/M
 ZtPAwXQYrEzHaVEyZ7uN/++w5ZqBoaoE4exGqGyFvoHnWMgQ/xNprZODtVWifITonMk7
 FgmKfnZ8KlIZ2FJjsMgDVatjn1/iEYSbKCvyCbHIiE6t5pu3cvuUG27G5UXNbeJjkHiZ
 qWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960795; x=1760565595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEx/hrefNIXj4jtd/TlO4/MQQCdcfyzeDKOCLqegICo=;
 b=SyM2NYO9Kza7ffArBH3t/aXPz6py2pVNMK1JmAH2j8clTGodzO3v0itzIj/EaIcOzl
 hAvJjS0aBgXV5mSKoPzhlvPLbalAVU7fD5RTLJlgOU1b28wFr3VPSlEOqFs4YeZI2N46
 OmujvMTTynTURu7bv/jIoq9rMY0e5UmLVbajf6j2cQ0SRYy4zfGSWv0obhZTWYvUuYnn
 QUI9gKKQaEzVToIbONfI5LlSEVK9VSam3t9t8xc9MYVmmNv6SJi7wqAdOsCtsQFHrMi+
 dUH/LpWe1bmAshOS+LvSBsl/o+05ARaNlxmKMq/arw/i4T5kS3G2xMrATCU0EEiBHfBo
 jqdQ==
X-Gm-Message-State: AOJu0YwYoe2DSMQxwlCyO+bxgzapzmfA85O4oisfGYLPV/tTDimyv3wk
 scX1xKDxjN5Y88f6NUnE1r/J518C+jyfPMKksctjlWXoVjIerxE2zZ68kzdujdfaC0EzgbtkBc/
 NBq3rkGs=
X-Gm-Gg: ASbGncvI1jQSvP1Xc/wRq+6bajdqOkmrUAKBUD9rvxr1s3B4IwpnMNwj/LvbtL1Ksqs
 Zb+EybCW/eZGcJ9AB9kyauf8/dECbvufbT1rYYwBUcJJ2T1JQNgzGzzk/oAd08qeWkOUmTrw/Jn
 yC1sx+OoBPfBZLSfQgI+J5vXeVVbOMTO4JMbpFPHAy8xqjXfHg29LTzn2SnIL4BiW1ZIxyYA+Pd
 JXoEsHldFpLNsIBEOrla2y4ZVoDSX3GACVVJ0Jtt+HHfW1rnG//xBBEPxIc7q7cxD249/DNbLMZ
 RG+mMXIItTbELgkx2Qx9M1dfjaalZWaVKxoIhy9ptuZzi8cCgcL/Jf+LWjMX31XvfXpiGGeNW8t
 wXgNgeepPgjqjf1xHksiExMJX5DqHL702XCCiiTeT/mbUmo4jjo6UIKkl
X-Google-Smtp-Source: AGHT+IGxAYr7EXhoVxc33ZrksSl/Em/ypRuYiR8x3fnF+qWRSgdjD+LZ9glAjjXmy6ENOW6UvZt8Uw==
X-Received: by 2002:a05:6a00:4fcf:b0:781:1916:c5fb with SMTP id
 d2e1a72fcca58-79385ddc921mr6387565b3a.14.1759960795162; 
 Wed, 08 Oct 2025 14:59:55 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 62/73] target/arm: Enable FEAT_GCS with -cpu max
Date: Wed,  8 Oct 2025 14:56:02 -0700
Message-ID: <20251008215613.300150-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f024db1d29..cc42dfdf56 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1280,6 +1280,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 68d9a4e734..4496178c48 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -73,6 +73,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


