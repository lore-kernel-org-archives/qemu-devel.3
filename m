Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A866CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPQC-0000VQ-Bl; Sat, 16 May 2026 20:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOz-0007JI-PX
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOy-0005Fv-A2
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so430687b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977837; x=1779582637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=UX3xPEFu1k26ViTsdrTlND7Og9TQd/XjkXIFja4ziSw4knkYKHd/rLHsTqzKQ5sYac
 R2B/YOSjN/4j0KjMHC0jrlRIlWhMX7wiH+dmw3PMyrGnMjpHsX61nBxhNkAv4MWGR5rl
 rc0GqSfRH5/QEjPtRZ9M1h+bA3GpITk42axZYYAX35DIGu4h8nqB7Nh/t6tH2c52rF/f
 6VN0CdApK8nib8R9Vo84rrAZaWDJfBiT8XvDXCvD5n5wGgEON7QozWbpBiJ+xOg3zB11
 w98IYngfbCcaSxnN8xmMWveMi8UGLhrU5vAS9Idlnb4PdZhQG/JRtWDVbK31bojQAbR4
 /WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977837; x=1779582637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QG3SAWZXTLSfeqfkLdTcj+WQldu34LGY3+/Bb5YVXA=;
 b=fNB/cWQ5AOaJ1jX0n41oyqADxjPlKtoMUcEIP2ZDgUaoDHFc8UO3lg5RrHpjxhLB7e
 Vm3yb2xDUNmja+0JjQUGt5ZtQ5G0sDeuqX4Gi1XCmfCSeDE6kKJ/35cO0CiTtghoZehC
 +b0hgKH+Rn9fuIq/pV1XqiGzI2HPiUXKMN9u0ihr5SMwCPAdB/xttIJwaP4JcHWH4OAp
 UbgQTJAr1f0md70UmMv9mEPVqHf4tdA9rkCI/WNT2McSoic6Y2VQm//zQML5vpZIxpP3
 ddDXWndcvIpK7pH5EyntWzTwVEp/dGVFYHFk1Sw31clZD3TWidgl+QPgLDK+uMHLRcb/
 Kwyg==
X-Gm-Message-State: AOJu0YwDhtThzic8GcaBn4v+B43omU21nkzqVYoEVMc+/NsNXrbL27Xh
 QZWgr5pLTejITZYFqfTfZZamwrm1wiVUyrw5DLa5Huvv8xm8FnFEslOHABL1A2z1pdpFu2mnalo
 1Ffq8
X-Gm-Gg: Acq92OEJOlA9zVkFFMksR1UuH6qT7WvnZSjrwMPeM06AYWw8Fu/ZesIOOaj18kopWLf
 Vw/TKrguNQR+xIYGLgqkHiRhYG40p6FIGt/Xr9Q8MySDZlSeoQuSX+QR18a+g+36+gpYEEMIC8S
 8FQMQKYTBqXPRHiTPmcUrUevpfsfu28RQCPpufj9sK+wc/D40/ouTxV0+B49hpGSFOgOHCs4TKL
 VYt72/krOFy+zWAw1tj8pSVucnIgp6ZepW1hjhf2DAor4vBY6Ts/J7EvRtLCg17fhXZkPBNGwjh
 dswhvQwkW97prf2h24vFg7teu/2TUWwuu5gCNtROL2LCc7zF/ZVvdb12R1HgZCMLA14uFPGxEMm
 AAF1qETkF3xaGwgLx+vMGgILfqsWxdx6/pmJBczcT0qHmSgf6ahNhU4pc83ZJzKqS54v8nPE1Un
 WMM8K8aHr7t/jeOPVgRn3YCTkdIKye
X-Received: by 2002:a05:6a00:1146:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-83f18dbd9c4mr10903925b3a.14.1778977836984; 
 Sat, 16 May 2026 17:30:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 39/63] target/arm: Enable FEAT_LUT for -cpu max
Date: Sat, 16 May 2026 17:29:38 -0700
Message-ID: <20260517003002.321430-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..bc866c5a67 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1263,6 +1263,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 44c7196d09..cf8771d541 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -101,6 +101,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
+- FEAT_LUT (Lookup table instructions with 2-bit and 4-bit indices)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MEC (Memory Encryption Contexts)
 
-- 
2.43.0


