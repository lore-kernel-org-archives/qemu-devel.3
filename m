Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8AE6ADCA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVX-0005il-Ls; Fri, 22 Nov 2024 17:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVU-0005h3-SP
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:08 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVT-0003iC-5u
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:08 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724e1742d0dso1057326b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315925; x=1732920725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMGyDQYSWfYuxqAd92U6ssjLzVraBx5dxtJzlIPJIio=;
 b=Bl3jgDePCF9+CBf3N3WLUt6JmoD72qY+lDgpDhAWy41sZ0GCTIRG9gDdRHixTuwhIt
 0bpCED4SBjCF3n64FgXEDnei/UvSwJjewAlre4JDmzJBWao/sWEpv4mnHaiohsr7XOHM
 M/UAetOoYqz5XTEKedMDU2MplQhxlYbFflluBKDDC5A1rukotU4QUG0Mw0cjo6X3sqYF
 F2PuzjscKmbpCYMn18lfvjvAt60MbT9+qyPWDgCqeiL9hcQWllQDVdl3HX9ZFfH0eAhJ
 nvAV5V52aHYOl4cbmlqC+SiadXP2Z/YGAquo8c1cSYDIFnNlHpUhwJVSVk/GjMU61JNC
 Czug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315925; x=1732920725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMGyDQYSWfYuxqAd92U6ssjLzVraBx5dxtJzlIPJIio=;
 b=HMPmEhV/rnDjRcOdNBV+nflsvJIsKMe8mUexFG81ttuTUZV6PIXeRpjpt7PAjNa6XV
 R5W88CTR9cjXyNDfjyCbcHlqlTaXInGVcYPyim1PekJS9vubDJ1TR03RdGKN7nzqpQg9
 RnB0qu3CuJnXyWOlg1/ruplTe+ORwAw8IuobOnY45ektSeWZahNey+/8quyAI8oIV2LI
 Hg4UunToEarG6ZgR7C4Pbd163DYKqjGnbwltlvf2WwyKyWr9yRgi+mbrzKLE1u85ZZHt
 vqq4nD5djrtn52Xhi+yUmk2ybiatTKv8Y+YVi7VLwkPoyBspp5E6qZGixhPsFVK2JYvj
 mxMw==
X-Gm-Message-State: AOJu0YzUw2DSHbhssE2vsxQzOhxBns5HE1lYZjNRocdhxIKC11OkdB2k
 EY+O4OoBPTi7ZGfpH9/t2IDd2RvQYnA3oxFuplRJ1V2GHRo2b4Qj4sEurwJxU6P9BcsbypJrU4k
 F
X-Gm-Gg: ASbGncsccivtaQlBhlK8wiNKznrDUC7Qbb5zT4prar43isomuekTA4FPFjq8vX3Jmnc
 aZO0m6kksyCZvSxc7p0F7CRzQcuEsfShzeB1pnmfz9qIm5AY3dEECP851HZG9oDTb+abAJpPjGc
 e7jI5/yxQCkC/EpG1ga782SiNGhpNJTXoaKgh3FLDBmEKViJCtU/o745GlC5oPtlRbdW5JXfX80
 ay33USdd9WSjzioD12P0jChC0Al8J50qtqOFhJqBliNtxT2Ku8BHkoTsc2lEVe6PQ7XHDde6zrp
 ck407WXgGjbUog==
X-Google-Smtp-Source: AGHT+IEOIBycBt6uzo9Fy9yo3WTNsXiIANTAUyn3WhjV/kbsUn071KG5dDeA84VVJw9kwvIhomjB6Q==
X-Received: by 2002:a17:902:ce82:b0:20b:6d82:acb with SMTP id
 d9443c01a7336-2129f244317mr61947525ad.23.1732315925594; 
 Fri, 22 Nov 2024 14:52:05 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/12] docs/system/arm/emulation: fix typo in feature name
Date: Fri, 22 Nov 2024 14:50:39 -0800
Message-Id: <20241122225049.1617774-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/emulation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2956c22a1b7..af613b9c8b8 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -88,7 +88,7 @@ the following architecture extensions:
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MixedEnd (Mixed-endian support)
-- FEAT_MixdEndEL0 (Mixed-endian support at EL0)
+- FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
-- 
2.39.5


