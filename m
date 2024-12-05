Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB25FE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 23:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLDD-0007IN-ER; Thu, 05 Dec 2024 18:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLDC-0007I9-2F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJLD8-0002KT-LE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 18:24:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso15642395e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733441080; x=1734045880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=srEVO03MgqW7zZf4nGmzSVgDCZFD1nGbBJuvAH/Cxfc=;
 b=cntrJrQL+TP2+nulkFY+43JgUXStLpMj5Wl+zUBGlmSfukHn0WHA89yIiFa9VVxJLm
 8qT7454oswo7UH5fDz3Ep0hFwtGNziNmNCJ3XQVm1O/vqtY1h/bPdbP7UiacgzmSupNs
 OBc+j9Osf1wz0aeUeumzZpeCaDG0wsjBODMbZix0xoEazPBOZz3UTYYeDtVJlVnY7nuM
 hEItGrZtkYFp/WJJ25+u3d1yGlaXC+vIb3AvJQHm/IihFg/BtAJhmyq9OxxcCcliOqLL
 qK/CchGIJXogCZ3s7RsiG4oQdveHM8/zV/3OhiecM3s120aTfPslUIDpCewAZXxZF+M4
 Lfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733441080; x=1734045880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srEVO03MgqW7zZf4nGmzSVgDCZFD1nGbBJuvAH/Cxfc=;
 b=wEYlydyNCZQE59oypr0q2n6VsZXTWh6B/ye2IAb6Lv99GJBPqG6MLE+VLZNWoo2ZWr
 eJgBS0SbUWKOqzQ1fVS63G9Rgn6tkdgoXgtJ/ZnlapX+dFEw9vdLG5X/fR+X16ow6brs
 gINXI2U8UA62jsBf8Z+E/jX3zb15qWnTMiQHNCwfmNBh0JUmaiwd4pJeXKK1Ox42hLte
 IAxw2EgzUFwdU2MiuQi4mE/bvfv5oaZdXJeCrzpOQUzHbYbd7hBGvt0qcr139b3T2qjm
 2I9q861p/hwQt4WgncnweY48kEuqW6n8OKAMQBJs5fVY8Q3rdzj9eI9KYZAzJ1HoWYKR
 0Z+A==
X-Gm-Message-State: AOJu0YxRkrExxvF30NS58GM9ORVOTBZDYgklZoGmySaLQ5sqWZkbiKBi
 MAFs0JXf2uiPI+MtcGQ4An7/lCrfknGpDHQa6PsOgL1TtEzcoA86ThGmGk4eJWwL6fgNW2bEAWx
 l
X-Gm-Gg: ASbGncvPtllCfyyyO8mYEZCml2MXP0RVLy5V/ImemANbrU9mScsebEbjrVFG6nTCnwV
 AUPpYdDYjFkUJX9lgDl0EDExz6Urb4dEmw36o1IU3XHx1iA+Tzd0FPLDLDYb9OB7u7McfChvON6
 zEpXWYDEdQHYZ4EqesD/P0l4+LqNsvLe3rWUlq72W9Vhs7MSaom5WkgXJlrF09GQWVvbPBxIPi/
 GJkxtfh7fn0iQ1UMqV8gnPWU3a6fynO1GU5Bhna9SFeRMWU7ztyIE20BKtOjyqK7bOzBNx0Nfh2
 f+z6aNpPaNBHVAaJIS7QgvlQ
X-Google-Smtp-Source: AGHT+IGzUqJf/JYdG1RMDCGxk1BoVvr96cj3Z7+iZoTRL7oa9IIi0afnjNHuwvVg81BcxvdflrdghQ==
X-Received: by 2002:a05:600c:4e49:b0:434:a4fe:cd6d with SMTP id
 5b1f17b1804b1-434ddeb49d2mr8626825e9.12.1733441080002; 
 Thu, 05 Dec 2024 15:24:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cc2fdsm74906675e9.42.2024.12.05.15.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Dec 2024 15:24:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/xtensa: Remove tswap() calls in semihosting
Date: Fri,  6 Dec 2024 00:24:35 +0100
Message-ID: <20241205232437.85235-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The first patch modifying Xtensa libisa has already been
posted in https://lore.kernel.org/qemu-devel/20241204202602.58083-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  target/xtensa: Implement xtensa_isa_is_big_endian()
  target/xtensa: Remove tswap() calls in semihosting simcall() helper

 include/hw/xtensa/xtensa-isa.h |  1 +
 target/xtensa/xtensa-isa.c     |  7 +++++++
 target/xtensa/xtensa-semi.c    | 16 ++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.45.2


