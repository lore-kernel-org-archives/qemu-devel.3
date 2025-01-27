Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBC6C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNHN-0006vF-IL; Mon, 27 Jan 2025 06:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNH1-0006qd-45
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:27 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNGy-0002ua-AK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so3557974f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977237; x=1738582037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRakPZ6OV3eBLWtDvjLaBsJfRq8OfeLe2uxM2sXVI94=;
 b=N37l6MjSWTDRX4Lw3xnnsfa5t6rBbTT2dCDd0vDLAfnBp00USrdIg0ttSYTM0TybnF
 iSIMLD2cg62br5VOW0/WesMwLp/xinN+CcpdTNuawn9mm5WaOouiu47yTgrNaPUaD8O6
 nQG9mkGEgIjeQAKXQ2f7PLW7bVUMv/n7E0e8dV1sxBGJ/Kdo87F6PNhoNL0KxVIh+9BU
 t8nQN8Ti7f44jVBXlm5GHmXpvOPLD6xjzGhfz8+I5WjKK9bxa8ScjHf8WjvX3grW15qc
 +V5CcreICvt3dbAJnWeonP5zLwzl4kUrhDVZ7mLkkG4nqcJpSgeMXlgJEap1+BfAJftd
 ieug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977237; x=1738582037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRakPZ6OV3eBLWtDvjLaBsJfRq8OfeLe2uxM2sXVI94=;
 b=Beim/XIUrkxaOCmESJo9Wm9/tdxjYahQ2Hy9CgDbyRzpS5+/TNOCmtrwtd2YPWqgt0
 D0wtZYAI0yZzzdvtokrUbJBrN6sQL/cnW6FPexSp2NL8FOpkuS8CUeuJAChZeq2wz6/C
 ptbZtuWfOSX1YGmnbhALF1ANzYCl7cRHftm6pKiW27R6IRKi4kJftagzCGm2Tyr3qTOE
 IKo8c6MTpVsuFBmMJ13nJD69VSbIUOJ0951LTi5N6Lfb2qZM45Zm96iux2GjMnPURtSv
 fmcuVVCMA3j7fZ4t4XMjbqdH+RxwAt3+P12nIzubd1KsG6xiJZnpXsAr8CYbJNOvz1VY
 kCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiYSl7jvIykVMljJQqrU7GgOd8bBI+APNiKp/DVJI8/kr5CY5O4Kuas4Ne7cEM1Fs93oAvb/RCGe//@nongnu.org
X-Gm-Message-State: AOJu0YzVS6piH6tM72RBYe5/2GYJznc2PEA6zk3GgHLyF0TkHz0FHRVN
 4QXfdeKn+mNCb6q7DKVIIypiCvtBMXEKhXwA0Tfvw+DbB3NQjFxyl9gU/tmWaGPjLmUfP4agIt7
 L
X-Gm-Gg: ASbGncvzNBiow+EVBVyFXIHYewe5kE2KAEr2Kl0e0YGfk0GaraFJ3fqdKfWFPr1xrgM
 z4RcDqOZF1dHoALwm+EliAXYqYY/aOmzhjCb84iBX0IDpaOvxY3NjA8yj39XuhIVFbRSn7Uu+xd
 iGKHKE8S6PmWlY5Fr/kzrLXOsQG2WvzgfbHUWQykCQESj5h43pZ/cJEHlmfvCPaivRUPmH9DLgc
 mFIRkRCKPp4Efp36yhVjPzWsOI0W4j9T+KqAFF1c/t8koCffdT1FDhLAzIaeTTCopb+j3cdViU+
 Q4H1LviBBA==
X-Google-Smtp-Source: AGHT+IFEhsDNE79jQlGV9DJmJTYivqF8DL1W0eW1HSPlawlxrYEI5BpzZJQSs04wm6g8rFlZDK9rbw==
X-Received: by 2002:a5d:47a4:0:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-38c2b65eccbmr11107200f8f.1.1737977237462; 
 Mon, 27 Jan 2025 03:27:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176449sm10925329f8f.11.2025.01.27.03.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 03:27:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Deprecate iwMMXt emulation and associated CPUs
Date: Mon, 27 Jan 2025 11:27:13 +0000
Message-Id: <20250127112715.2936555-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patchset marks all the CPUs that support iwMMXt as deprecated,
because I don't believe anybody is using them, and we have no way to
test the thousands of lines of code we have that's only there for
iwMMXt emulation.  (See for instance the recent thread where a patch
was submitted to fix an issue detected by a static analyzer: we
didn't take it, largely because we had no way to know if the
behaviour change the patch would produce was correct or not.)

The pxa2xx CPUs are now only useful with user-mode emulation, because
we dropped all the machine types that used them in 9.2.  (Technically
you could alse use "-cpu pxa270" with a board model like versatilepb
which doesn't sanity-check the CPU type, but that has never been a
supported config.)

To use them (or iwMMXt emulation) with QEMU user-mode you would need
to explicitly select them with the -cpu option or the QEMU_CPU
environment variable, because the '-cpu max' default CPU does not
include iwMMXt emulation.  A google search finds no examples of
anybody doing this in the last decade.

I asked some of the Linaro GCC folks if they were using QEMU to test
their iwMMXt codegen, or knew anybody doing that upstream, and the
answer was "no". In fact, GCC is in the process of dropping support
for iwMMXt entirely.
                    
We have one test case in check-tcg which purports to be checking
iwMMXt. In fact it is doing no such thing: it runs the test without
selecting an iwMMXt CPU, which means the iwMMXt insns are interpreted
as FPA11 insns by the linux-user emulate_arm_fpa11() code. So the test
prints garbage and then succeeds anyway. Modern distro toolchains
can't generate a binary that will run with -cpu pxa270 (because their
crt startup code uses Thumb insns); rather than putting in a lot of
effort trying to salvage the test case to really test a feature we've
deprecated, I opted to just remove the test.

-- PMM

Peter Maydell (2):
  target/arm: deprecate the pxa2xx CPUs and iwMMXt emulation
  tests/tcg/arm: Remove test-arm-iwmmxt test

 docs/about/deprecated.rst       | 21 ++++++++++++++
 target/arm/cpu.h                |  1 +
 target/arm/cpu.c                |  3 ++
 target/arm/tcg/cpu32.c          | 36 ++++++++++++++++--------
 tests/tcg/arm/Makefile.target   |  7 -----
 tests/tcg/arm/README            |  5 ----
 tests/tcg/arm/test-arm-iwmmxt.S | 49 ---------------------------------
 7 files changed, 49 insertions(+), 73 deletions(-)
 delete mode 100644 tests/tcg/arm/test-arm-iwmmxt.S

-- 
2.34.1


