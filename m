Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ABEC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetfw-0007If-Tb; Thu, 24 Jul 2025 06:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfv-0007Em-7B
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetft-0007xI-DD
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:46 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso1743464a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354783; x=1753959583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2j0rreVKxKZW1/bQwPMyAcXvrAutpqYSKulSVnU2qbs=;
 b=y8RMqOoz8FwxwDV8nkrHaMgAZvDuSEBerdYNw3eKKe4U83QwWm3xo/iv6p/KF7HMJA
 K/UeXf94e6feBp/v5QifelSwaCXcKHHhViFV9XtEp5EAv3UkOKIIdwIJw3fKEfV3i8iO
 v1dcw7VWI5zy5Y2KGqTaZZaiSjeQiK5inTtPvjqsIk4pbjpFxNe7o6+DFWEpgt7oiv89
 dji7l1tMoRcCQ+iJ9+KrBhclfBhr7XWT3G0ceRSR0wtFHFFUFUewGfZLevhmiKIaj0rY
 bpzWj4nzGVjlyrCRfxPGAuv02fyBHThjsThX6Cr+S/O97bhvBdSTBr0S0nO8SJxgyKFe
 EG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354783; x=1753959583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2j0rreVKxKZW1/bQwPMyAcXvrAutpqYSKulSVnU2qbs=;
 b=LycK2BDFJke4Il7/SALFY6DfVlxFOfZRpRNZ4MliVt+7Of3ho8IKMkXBUI2i614s9h
 DgFxg06AkMKzNfua2cb72Gl3jXBjVz19sskKjPm+7DoBUc96Na7uMT++bEQEpAgmpPFN
 q2q21qKi3PBis8vk/h7XCxsXJM4njIcfyt+3F24gmmiHfDdMxSExOWPBUhfrvVt20oDd
 D+fQaWYNGkW++dNP+W9supMV+Am7J4ja69Yx1/TxmEl09lcae4xliU13RJoCwaamIIGo
 McfVCxfJpSZO1brk9GCFUzsdj0l8Hb2x8O4ejQgWKoQ7GJSc9CsR4tdkYvV9w+s+3r3g
 BOHw==
X-Gm-Message-State: AOJu0YzUa5onKdvCoCd0xRuEM0C2YdBBUd4gI4vsmMCW2elzZbGkIReK
 mcTXqy0PEijtNH/M9q0fHWQwYImjuNdTV63yRmmLWLu3+tlpWUhSjnCtYa3eOJ9/IFc=
X-Gm-Gg: ASbGncs+58wYf7PNgAurWsL3XrqRIH+c7UldZaJoF5FrF5vM2mvYTzeck5Q2B9gaOZb
 SDEV5U8wSaOLq9VRXidUeC3bUc5zTCoGLalQezp9qQomdNtw5TBRKIIy5gAWgm5BbFxaTVfQSNq
 8iUa0MjbvfUv96eOFKI1goB/CCfsG50HkHNR1mqXC1REtlqTfBGZr4Yes8Uniq9Xc1bPnIYNOtE
 Bv3A82yVXHq70MHG/7UaQlKMqSkHKIknW0QNGL5qfYpBgewCCbwkiAmICCumgRKQsQOxmls2vB1
 R9AiIyT91/ic6xf5EvzSHkIqza3hqKuIaBphRA5PuY8gaedV816wxBYZUGKbAORmNrPoWos34xG
 8T8KbLXMwABy00yFyBdJZp9g=
X-Google-Smtp-Source: AGHT+IHcBBiwwQJsfX0ylitwjosvDWDU10CvWCfwM+CfOFK0ZjaRU5KtHE/2uRSMCBQeZJA3ubXndg==
X-Received: by 2002:a05:6402:51cc:b0:614:9439:cdd6 with SMTP id
 4fb4d7f45d1cf-6149b417f9cmr5139299a12.1.1753354783105; 
 Thu, 24 Jul 2025 03:59:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd335f7dsm687680a12.61.2025.07.24.03.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 075265F88F;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 01/13] docs/user: clarify user-mode expects the same
 OS
Date: Thu, 24 Jul 2025 11:59:27 +0100
Message-ID: <20250724105939.2393230-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

While we somewhat cover this later when we talk about supported
operating systems make it clear in the front matter.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/index.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/user/index.rst b/docs/user/index.rst
index 782d27cda27..2307580cb97 100644
--- a/docs/user/index.rst
+++ b/docs/user/index.rst
@@ -5,8 +5,9 @@ User Mode Emulation
 -------------------
 
 This section of the manual is the overall guide for users using QEMU
-for user-mode emulation.  In this mode, QEMU can launch
-processes compiled for one CPU on another CPU.
+for user-mode emulation. In this mode, QEMU can launch programs
+compiled for one CPU architecture on the same Operating System (OS)
+but running on a different CPU architecture.
 
 .. toctree::
    :maxdepth: 2
-- 
2.47.2


