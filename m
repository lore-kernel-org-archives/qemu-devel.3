Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E29C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6e-0008ON-8y; Tue, 11 Feb 2025 11:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht65-0006tI-VR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht64-0003Wo-63
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394c192285so10769855e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291211; x=1739896011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qymzXrO+9F4JBSFIAl0zaVLUHcekNoeWY0bsti7Y49Q=;
 b=NAC0A99aqCn4oiqGPvJ9U3rWeeozLcKjeceEhcYEB0KRE99W+qBi/1E5tyBO/TgIWb
 2B860HTK1jcRAjH+bhPmNhBsE+318529Kn83ueD/qD5umWC4RY8MlTdjQIhl7cctWuBx
 JWKPgo6Kg+I5ON48+5oCThT/nk3WyPJp+q47Pl8ci52JMkWEoc5eM9ISqNkP+myHOvI9
 I7cDhKNLDelLVqdG3RZIbIkLg99R40snSTZ9CpHgTth0ei2g41itPKpHpNrQa+JGrgGM
 SsOeLyaC7TWyrbRMrQXTlJpcyYPIstcNmTOBqw9knWDl6CZ8ulX1KGtIQpvJN49tyWj9
 hhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291211; x=1739896011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qymzXrO+9F4JBSFIAl0zaVLUHcekNoeWY0bsti7Y49Q=;
 b=DiJv7YYB9JdFWUahuVHrKMTzCUhNpJjDyfUSxd136PGCiaUqZXV1EeEYIgNZ2frcV5
 mv5FQx6N0vcL+RUIh+RSys1lPXsgDqlZMO15rVTdIIKKj2MPP05NFRsNhGMIwKw2lC+j
 Nvw4Oupq+DqI/CpRKE8zQcpjLZbtkjhT3tAHhjW9c3hnS1hLyiTadvKMgBwulgFPsq7b
 SFh45NE8kuDDRse1HzGbmi2Z1DalfTAkZQLsss515ub+7oiIFA3UCIwILOSEA5gCwLL3
 x5Ri1nT8RkYAI1ZBbJGmbYNRZ+nVjyXx7mJgzU1PQWqNThBZ1eY80ygUJhOfbNaXEoIF
 Fnww==
X-Gm-Message-State: AOJu0YwAJ6kq+BufRds2gVqaeA68GsVpwpRsEVlH443JWvOHasRXy2VR
 ui0gldhoBZJctYvPuBaxsokbukBRuIyGzM90LJYblpTdmXNvd26/WiACIf45ex6TZHDKVnEzwZP
 W
X-Gm-Gg: ASbGnct7Lpl/ztRO+x09Pfba7++cglhdd5PDWtmoi8Bu0bhi6omFXhU2ZcynqoXsWKt
 wTqNkwTLEjsQrHwVbu21oSXMwy6Z5YnXBbvqnAG5bkr4mucwZyMZR8JjmyFhbZxkcja3dHw36hA
 BEM5/sfFzdv6MD6BKcegNNnay5ni1SutHUdZ7YWmz3khW79a3FOagAR8DIFa4IvqgGt3ZJKMFe4
 DRt397KN4RmjMGn85r4p4gu6+yDKcJlyn9q8mNUwnkJApaTFZ2Nsu41/FouwNVkMElRr0jMcm3/
 FZx/QMkc9WJ7kEo0UdPL
X-Google-Smtp-Source: AGHT+IFMEGqpKiMdlQngWDgqVyLX9SReoTkj+7EM5xnC9aaRR4aDtkiQ+0QIPFNKHnYtuGpUtuh6Rg==
X-Received: by 2002:a05:600c:1d99:b0:439:5506:717f with SMTP id
 5b1f17b1804b1-43955067392mr24958015e9.9.1739291210809; 
 Tue, 11 Feb 2025 08:26:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/68] target/arm: Enable FEAT_AFP for '-cpu max'
Date: Tue, 11 Feb 2025 16:25:37 +0000
Message-Id: <20250211162554.4135349-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Now that we have completed the handling for FPCR.{AH,FIZ,NEP}, we
can enable FEAT_AFP for '-cpu max', and document that we support it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 60176d08597..63b4cdf5fb1 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -20,6 +20,7 @@ the following architecture extensions:
 - FEAT_AA64EL3 (Support for AArch64 at EL3)
 - FEAT_AdvSIMD (Advanced SIMD Extension)
 - FEAT_AES (AESD and AESE instructions)
+- FEAT_AFP (Alternate floating-point behavior)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 93573ceeb1a..0bc68aac177 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1218,6 +1218,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
     t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
     cpu->isar.id_aa64mmfr1 = t;
-- 
2.34.1


