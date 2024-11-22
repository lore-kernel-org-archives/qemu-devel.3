Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C745E6ADCD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVV-0005hi-UJ; Fri, 22 Nov 2024 17:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVT-0005gb-Uj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:07 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVR-0003hz-VL
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:07 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21200c749bfso26923815ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315924; x=1732920724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YFLbZLOczXBElPPKg8w5+mMH+iVSKvrslYIT3YcYvo=;
 b=cPucjloBliScDX1e4vl83Ua5H2nszX+qHZzHx8Qvl7ACYfs5uSbBnzD0kSQecwSa5c
 jaDSJYg4NTj/lQYZTNJOIVn3GnPw0sfabPGVFRBuXQh4bqlmCdadohBHAZ2uZsJGKkIi
 rzvxHMcoiMwRT6ZvsSwVilpjnUZSHGe8vKJJ7X6gbkV7LWdyJUVedPCow93OI35PH109
 7xRz0PHYZcC5FmN34B9P1pHxa8QDOJKYJb3zpzwxA8PhIfgVirxY86ObeXZCpJ6zavQr
 8DoRaT4NUoyObVzdWmw4pkKFW0o0fDyVutiacg621j0TyVGJlcxn6N1MnaIGzuMSwSvC
 X3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315924; x=1732920724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YFLbZLOczXBElPPKg8w5+mMH+iVSKvrslYIT3YcYvo=;
 b=vYK395O9UxF7T5nHK8TWCyQxKMKNzPDDGcevbhDdJIGY5jvKWetq0CTgHMYsPFh1bI
 5sdakqCBiiH8dUL/Y+ltFFaHq+C9mQ/8d+JRtbEOf76iwJKfsOCHbw6KiByT6pSnBFzC
 yB5SDYeoDBL1DqMKbbLckARE+CXQiXx4EcUT0ApvcEYEfXvSuepx5j3yh614/BAEzdk8
 tO0tcgc2X0lnJ8fInhO9km+yb/WCl5b9V9dCwnivYgXyueQ/RVQ0cAwR7siVye1pi5vI
 lS5btuCZhAWIABsdaezUzZ1Tw1hq/4L/zsSDrhxMTl/xWMUBaD/o904TtUpyzO1gmSYR
 9MZg==
X-Gm-Message-State: AOJu0Yz14smwMFaOs7CRZEor/ZfKW/W+OG81m9tzJccYul3alFkwrU5x
 XlE/HJE9moRhZDlnmaTirckRvanBaRkp7j1TAxNrdYWIrrpUI/vtumkTbJYQOE+5/owGQtK/jIZ
 Q
X-Gm-Gg: ASbGncsXxQ37+BY9tluhlmFnYZtZ5VQyhCN1WCxvc5FwNxnNGGRCWnr/SzdX8X/7/3G
 Kn/FubXak5k750YbGlwZaJq9k0ggUQaCn7NgJQNEXEMOxrmoanHxNv7+tyFj82ELKcCJFws3FrB
 FSzPXkfFvD0RKsiiNhm0oNihUWYfKFub3v/HgfMv1Um1OsE6DAe4cOOuPyhg2/nKNbmTkgRM7ek
 38Lpt4hrrRnH0E3SSe01aQuQXe1ntFnw5vQFZg6e8DKjRXR4y9ScpwwvJc7MM32eqSfarM369Em
 YjLEPqn1ktL2sQ==
X-Google-Smtp-Source: AGHT+IHUaAPqGY0pVQ2KVgG0CwtD+igzfbJyv2dYuIam3jB2EpwZQnkhSl0ziQwdQPVdfVJaXddVVA==
X-Received: by 2002:a17:902:cec4:b0:20c:ab33:f8b8 with SMTP id
 d9443c01a7336-2129f226036mr65032875ad.15.1732315924506; 
 Fri, 22 Nov 2024 14:52:04 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:02 -0800 (PST)
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
Subject: [PATCH 01/12] docs/system/arm/emulation: mention armv9
Date: Fri, 22 Nov 2024 14:50:38 -0800
Message-Id: <20241122225049.1617774-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/emulation.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a2a388f0919..2956c22a1b7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -3,8 +3,8 @@
 A-profile CPU architecture support
 ==================================
 
-QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7 and
-Armv8 versions of the A-profile architecture. It also has support for
+QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
+Armv8 and Armv9 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
@@ -153,7 +153,7 @@ the following architecture extensions:
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
 
 For information on the specifics of these extensions, please refer
-to the `Armv8-A Arm Architecture Reference Manual
+to the `Arm Architecture Reference Manual for A-profile architecture
 <https://developer.arm.com/documentation/ddi0487/latest>`_.
 
 When a specific named CPU is being emulated, only those features which
-- 
2.39.5


