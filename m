Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F36CAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TUc-0002SR-RB; Wed, 24 Sep 2025 13:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TUW-0002Oq-E4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TU5-0001Jm-Jn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so147664f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735647; x=1759340447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jSggU97dftRdWlmI3jSsk+722rW+9Ct/Nrb9t9k1otM=;
 b=TKOQSPKhhQRsQ1uGPWKUbShH7VKP6j+2QywWVy9g4tvCQKiOEZBffOUolGrMKUbB+e
 UNOWvgGBij3mdxQtsjoxXFHlVEoVxzeV18ioAXmO+2UFfAv7UEQgOOqzS6bmrBZdb2Mv
 5/cMIcps2YXbPOUSJOyRc16bfTm1npsxJclBU93KBffv4dBNdI9hy7sooaPHrNtrYqnQ
 FrujC5kpIwTWAmi7TCsQ3Xedv3BS76rRXfcGLeuDZO6lmBo40tsMmcclrypNxZSWa3uL
 uxPG4R9gSDhRI1aon+gy/yy3LT8m+nSGkVP8rVGZoAxwf7IXd1KKFWQsnok0e4cintpP
 FSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735647; x=1759340447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSggU97dftRdWlmI3jSsk+722rW+9Ct/Nrb9t9k1otM=;
 b=wqoH8Iy4b5ckzn2Gh6xuwQH/wEuhk6SwUy3LzpilUEFZ9YxcLyg97rnR+pfOsWPuJQ
 /uAuup8Nk+E2/iCopBLauKl8CRXcBhcVnPuWhAXTEhPKTxGxEGTCDG+kEdh7AJ0YAclJ
 lZmptVrMnY6fe1z8nF7ZqqBrGgqft8CAqDEQ7UtcxD1ZYU0Vy04DagmVCjZBsfoYETsX
 cxmQIGbPZ4HhyuGeTbaiueusz78R9yvI5mpyukyCKV5JISDVJd22iMkAcQIIIIbbIGBb
 oYiSp9Udzlyn0bujd4QDP/DzXJL6M51h3kqOJuwAWZALPazR7DkUNpdcHtIPbdZM9PHu
 Ev2g==
X-Gm-Message-State: AOJu0YyDKHpWrD8FCYYUXoWfOPXh8jRbQHhQMDr8GDK/NbkR/y+oMHBQ
 t2zwbseJerhFXC6I8vNE3ZS98l0IPluza6qTZpfCefWQoKTv3CcGyPDdnHjm/dEnn0CYfSwmTin
 LvRBnpBrbcA==
X-Gm-Gg: ASbGncvjoVosTYc/e3LIjJRskiETehMkeAElp86U2Wllbwl+BYerkgw7zg0CD0IoK1o
 dJqitmiHyZwA0ooJFlFp5+vVWM1t80v5jM26+0g6kh8EjGzmH354zSaffy+AJWsW74uXfGzOtlI
 +NjBrcne+qsfnM4BSnkAfTnOaOcnP1F+yp2KLykwWFX/fzNjbmiYpqJHOMze6jcjFraYmBKICf7
 Oyrwy2su+bvL7qZFvNWsNqp1tgB6gU8KpWJbbxDw+IStiWF6kuyRYq0PWJEq/u5pty+HLzwzcI3
 iaUxAf8CkgXYx6rShFbaiaHDUoE2zJX8jFN6lIK1Zgp55QhascxBanAKYCxwIRhNtaQBWiWQhQt
 l6b/42JHtebBMolkW9anZgN14Gy1zq7FxT5C7AIbPlhoevxpK0WadXxWj37AdULe2wtPH/OOhl6
 ICRzSqeuU=
X-Google-Smtp-Source: AGHT+IHZyWYnXZWjmykN/zgdtzGIoO0Xh3WVOWhpfxMtxcWlx7dywBuozCGPwe/bPwuVry65TbYyfA==
X-Received: by 2002:a05:6000:1847:b0:3ff:17ac:a347 with SMTP id
 ffacd0b85a97d-40e483a7f97mr752975f8f.27.1758735647523; 
 Wed, 24 Sep 2025 10:40:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40e0641fa13sm948106f8f.61.2025.09.24.10.40.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] target/xtensa: Replace CPUXtensa:runstall by
 CPUState:start_powered_off
Date: Wed, 24 Sep 2025 19:40:43 +0200
Message-ID: <20250924174045.54241-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

CPUXtensa::runstall and CPUState::start_powered_off are
semantically equivalent. Replace the target specific field
by the generic one.

Philippe Mathieu-Daudé (2):
  hw/core/cpu: Expose CPUState::start_powered_off docstring
  target/xtensa: Replace CPUXtensa:runstall by
    CPUState:start_powered_off

 include/hw/core/cpu.h  | 2 +-
 target/xtensa/cpu.h    | 1 -
 target/xtensa/cpu.c    | 8 ++++++--
 target/xtensa/helper.c | 6 ++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.51.0


