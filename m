Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7CAC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUVL-0005Sy-P3; Mon, 26 May 2025 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVJ-0005Si-Dv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:21 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUVG-0006y0-Jv
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:52:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so1308555f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748253135; x=1748857935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1EgJfHgz/mFD3bMeaNrrEU/wCAJuJvS8AzxOjZcWMJ8=;
 b=N6ZTq7bBUbZvQH25sZq0yeRbfNFsCOXb/0axgkhhY6gNMY2At6PQ0n71PP/b+MQim4
 4uoRGGftjlVd8GowGyt4Ym0XYjSMxlArbgkPc65CV9KEmZGOAAY/NiA2xs7Yt3frQ9It
 FiXDjHuysdMwSd7W/smDrJZvXq+JDxiN78Sdo0mOPwR7bsd7rOpSWeCM+kgBuPyjrz3E
 VlwVQYVDlKA1q9lVDeunHi7JUFb9TO6W2EHEmM7X4YmuUupK4HVPHfekSmo06XZzPka4
 l4EnipFQpQpFGsbWCLd41MwR4v2W7/WhU39oF6zC8iPDlLUR2s+ySqLoi7dXEA2LQvV9
 8FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253135; x=1748857935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EgJfHgz/mFD3bMeaNrrEU/wCAJuJvS8AzxOjZcWMJ8=;
 b=XQDcQdtJq0fR4cya0rtYB/Vo1NHMYjbjhD2wAm/s5e/qHoAtwiNCR/Fjw2DV8CYy3E
 D4Jt/UliW2xNdB0JCqigURw0WBuPR/tAFFaaff7NelqPK6GCwip5BJoLrIPAzCGoE2dB
 2R5dAi0Cmrm2wkjnHAxSwJvdeQyltBXWPIuoCuWuzHRVdk/HjJ/yvgHxFHo9R+0bK/Zy
 DlzhkdPNGCeA/nxHNjHbIalXgRFcosudaOqUnngQWg5rJGfaXM4rcYfT45kIjfxVj3BZ
 rfi+BqHB8eJ+Vh+b6dO2PEexe+KuWhDlfFlTmlTDPnXM8qqz0xCEDiueYQustEEtBG8V
 nvbw==
X-Gm-Message-State: AOJu0YyUUf6bL40QGRGEH+JF3G3UvoUiTpazrA0jn6YYdLk791tbzlRs
 7yL2NpuGztLWo+EcdLzS9lGYTNrxquLkqw3HJWpDGFWfRzJ/DBomGuvnvM4UbB/eYaMBwyuQ4Xa
 Yfhjl8+WKHg==
X-Gm-Gg: ASbGncspO+zVsAJSkQBnlUMOQ8LV0xOxt/6o1l87nxrGsMQ7Jo2KNUKVOzn0cvRiRMH
 Tzs/ZjZVAtpUeOhKNDoNXLcqmJXBjvxl1n45cRdmrE7/wj2jkWMYyXQGYQPONulRTc+3bDaxkFt
 pUcTg2rVaazC8g4kKhaLDwFLRgmvDesLgaEOWUwdIyzFG26fm32wpAH9Qa78znrmoP5EDGajwz+
 cRKo+9nMZAxlgwmA0xNhXTDlmcwAVq2u5PPHfsqDDHEdPnXAA6+UbXOvUenFpzy/5yLcpbbS6Uc
 9eqUD2tjFGf1VxkpNYx6HjugIGUKae/mY6EsOmoTI8pbbjlAyDRPy+FMPoUQJzfVJmw8o2jJWSi
 gjUyuaIZSlXgCV5jHB8f1pH3/tzOtSGU=
X-Google-Smtp-Source: AGHT+IHainXQPeO7FwPkslwDcAH5aeBv+kj78tjRWnjqEh3qEoeYzLIR0s5iCr6BijnLDfM5rd816Q==
X-Received: by 2002:a05:6000:2312:b0:3a4:d975:7d6f with SMTP id
 ffacd0b85a97d-3a4d9757e7dmr1581686f8f.39.1748253135318; 
 Mon, 26 May 2025 02:52:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1825457sm240166335e9.1.2025.05.26.02.52.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 02:52:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] semihosting/uaccess: Compile once
Date: Mon, 26 May 2025 11:52:11 +0200
Message-ID: <20250526095213.14113-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Replace target_ulong -> vaddr/size_t to compile once.

since v2:
- fixed build error when TCG enabled (Pierrick)
since v1:
- fixed build error when TCG disabled (Pierrick)

Based-on: <20250521223414.248276-1-pierrick.bouvier@linaro.org>

Philippe Mathieu-Daudé (2):
  semihosting/uaccess: Remove uses of target_ulong type
  semihosting/uaccess: Compile once

 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 semihosting/meson.build       |  5 +----
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.47.1


