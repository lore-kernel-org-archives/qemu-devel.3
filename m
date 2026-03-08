Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452CEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMiL-0007pB-8D; Sun, 08 Mar 2026 18:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiJ-0007mg-MI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiI-0003Fi-6f
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so127842345e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009304; x=1773614104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x7Yb5EbKwVxfF5zbcjgROKL5ZCps1r9DwcyPOGOHfQA=;
 b=hdAguXal8kI+1WZ4vxy7Wl1CF6HIJwszAruHY4wlWWTt+9Ley+Ig6B/vkfsLVNomPN
 IOc+Fv/h1l0NVlfw2UTk1avHpOlGWEVCeL8lfN1H5HXIORxKKUoLFTAM8AumDzdFG0O2
 AqtRrbEp1RS58NbhjzlhCpIhQBScm/fg3XudlKLIgRoy4+kG2mzw8Ggl5vXCCFwoQWy2
 IwCmzDx+zbH4jFnsNDYTtcDDFFQt2iP95PUN0QPHSAhIFNRpG6Fql6e4Dq0HnOoLrNu6
 2CuFwPwk45uijoDPrByXcxt9nEl/LuY2BizC/YWpgvsiE0RsB3htvkdtJmbdSyR6jBV7
 nTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009304; x=1773614104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x7Yb5EbKwVxfF5zbcjgROKL5ZCps1r9DwcyPOGOHfQA=;
 b=N9SFFWcY8I7L/e8osGAJaLWdbmHthu70qOGFSrLwx9m0VBQ211QomcTZve2UnhAdb2
 EZZwN9BRmPfGNiN5K68Xtbg2p0NEX30bJB0mg1uAkTJaul0vCMjd+PioMRzYi6UjdCOR
 lFyHWUm57enSkH7gGrBMMsK+u6MDkLMVqoGG0kMbype/Zk+BsS1oKur0F4JwhIrqNMV7
 F5/Tz1sQdchq4GkU0m7eA9HUDcDnwkjOZ2IFT/Q6ljIv2KUUu2LKKnwC8EbYpVY0cQWx
 yKF5FRuG/lHGtRn6P6tazBsImMoa099/dLxFOVKeb0yld9c7Y08PKdCj9bynhVa7A0Yc
 QeTA==
X-Gm-Message-State: AOJu0YxNihxO7vJMkBKQ6qY4YIgMNzJpfHOhoehjI9EjUygjxcpEXdyp
 J0oHCb3uZaBWkJNEHhVM2NRQdfz3Xc0aEKfoKJiYKjOEBm0I/00UTKJgEJhvm3B1g6zfU9ltWv+
 2dyNEcdU=
X-Gm-Gg: ATEYQzzDS4s/HUy1JbjKu+vndXJKoXgdqVzdqBjFkV0T0yr833+wbLNxk7XwVeil0zx
 wrk9r66DhOKge4mCSpWfEZPQNpTgUy4aVXxU6W9VDNPFTDpr91gYGdlHEq6VkoNjN/giZzeZfB8
 2SHfHJ2Sq1YKLsCbCqXXZotF5tqWwjePdXAXKUEsS/B/9XISiYLKIBr+sNHhhCthVar3NW2jvah
 hO3DTti7oOKNzQN17U2+7c3S3Y2XIFaMxXPn/cQLy6+m33HGdAVGb28hJARJd2WfB9g1sucsQMh
 z7FZZsZqj8gUxAaygoWB7wytH4n/pA/jffry99wKF+wvVHMIRJanxr17+S0UJMI7mjBuL6Z2TDW
 Bg6GDE2UoaKYN5h4fqhcfXEZfpd5jH/djnZYJKXMQyXZpbu4WtO32ovsQSC9E+2pOw51A/8IUmy
 amCMP/hS3s11NPd8mfVbGvYb6TkfdlJ+dp6WOSOcMaSvQ8mDQ0vk/vUKrR3nvrYdKLGIwqJ+4c4
 K9y9g==
X-Received: by 2002:a05:600c:45d1:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-48526978962mr157970345e9.34.1773009304029; 
 Sun, 08 Mar 2026 15:35:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm290082365e9.4.2026.03.08.15.35.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/49] hw/core/machine: Remove the hw_compat_3_0[] array
Date: Sun,  8 Mar 2026 23:33:48 +0100
Message-ID: <20260308223433.25503-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The hw_compat_3_0[] array was only used by the pc-q35-3.0
and pc-i440fx-3.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307150042.78030-5-philmd@linaro.org>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f4ee68bbea5..9ad2a7d5c97 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -871,7 +871,4 @@ extern const size_t hw_compat_4_0_len;
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
 
-extern GlobalProperty hw_compat_3_0[];
-extern const size_t hw_compat_3_0_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4770618b559..162600425b0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -238,9 +238,6 @@ GlobalProperty hw_compat_3_1[] = {
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
-GlobalProperty hw_compat_3_0[] = {};
-const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0


