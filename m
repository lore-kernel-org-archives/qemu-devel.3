Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7D3F4BB72
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux20-0002og-Jo; Tue, 24 Feb 2026 13:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1Q-0002LW-MB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1K-0004A1-UJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so677195e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957226; x=1772562026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTH/oQn763OmE0nrbxbiu2BCcUB/edRHlv+U8EHS6Ik=;
 b=b9Y+3CsGmMRmbCevLUlvfrrJVp5tX0nFxU8dokCtc8FAZlzjEII7Ymm+rVQrDgbODR
 AFoHBZmvQ/E1tlxuuuFA6yuZfgbiTtsSAvu6bebtnEU5hOA1klzDWg3VPHiN95i3ZPov
 IJxa55OSLCQsUZZSHo4m0yEpdAYmSAjk4Eq+rzJztw4IK+GpMnBHllH0eHTT6OZcbE0P
 Ar9NuGxA3ORcBcQg6qyR/FJdXu8MQqmjL2J76YIYI3b4/dwIEpcfHVI+DTeeBM0oIYbN
 FIOnXejmnVgI7QAmgU+ZRHyX2ka4a5UFPL02+8IgLLeAOWY1iQ61oZiz5YDT5ouuLq7e
 vR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957226; x=1772562026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTH/oQn763OmE0nrbxbiu2BCcUB/edRHlv+U8EHS6Ik=;
 b=YCLp69Mb+eOC4lYyxZC7xKXKjfx0Gcz1eBoaOXw/eWM2qiQpTO3oXkbaNCjxujAlXI
 A5WHUwx7sCG757vE+4MNapEEFqfe9DP4bhuoJYwpFgQ+wedCaTBXl+B7+sxRHfh3NDh4
 QmtM689lhFXJF4hy2m8Cu9xBBG9VRGDBJizhguVCLx60oDtXQPtNczR0wwyoV/bT72ZI
 yhr2iMU7P/EzwFAaBL7VsSOZkhPxAYOKgF4ZNdaxlUS2Vg51LLivJLHEDNXHdPlAHuAl
 UKCpINAnIxPzrfMuI9xdGR9lVcATCzfPb9ktUM0kFl5eaSxTffF6ISj13FS1cjn0bQMy
 uaTg==
X-Gm-Message-State: AOJu0Yxypfqm54HrRu6xKqAqyC3OT4oVFQio+P0/XoJtcEI1CxtsIa3H
 YMnnF+hcrrnygUhwxlHALjQhrk/9Ho9kdCD9M7jt14vrPg8VDuhiYGt3DLDNbn0C1K6etJKscOR
 Xjj7FyIE=
X-Gm-Gg: AZuq6aKjS/MqnsoR5xOuxhjclEFZJUhBAUbKXUGH6OUQg9jJyRZnpmN7mZygSLJKVO4
 e5ZCzz/YPawgZhXYP0sDbPf8s5ve3vclx3vzm5HSiGkAYhXQ9RlbF6kJrVREisQNjw68Iz4X22n
 emwrrwq9CEROzhEUBQ+Y2enzydwbHrJkf4wOIFe51l+7tTg4LgZlxG5isd4jbYxQ2/6cGzxkaXw
 d6dAZCxUOGY5y1541EXMD0ukQkklPUtZwcFZCZEs4+R6vHwo6e6V7C4H88kBBQA3nHJwPSump9o
 QwFQbxHIOrrdztoE5O0QX3cosieoavKJqqQ2TqdndDwuiNyNwiSY8G3lBj5b0Ub/l7kZmxgASa0
 ANAxMPUG+zI0c5Rd62jdkBav/11pSsoYS+/CaAGg7Qjtq5Y6fr7ym5fI0R7RD31PHZ+rEDbEYr0
 n/CaV+VI+FuGba/q3Rxs8cOW2ssdDcWYnXc4zXcbMo84zmcicat3Cgn1HarvQcJtIMxzeV3F5E
X-Received: by 2002:a05:600c:4c04:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-483bd76c506mr7428675e9.15.1771957226018; 
 Tue, 24 Feb 2026 10:20:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd72bd66sm14009605e9.11.2026.02.24.10.20.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/10] meson: Include various directories providing stubs
 before libqemuutil
Date: Tue, 24 Feb 2026 19:20:07 +0100
Message-ID: <20260224182017.99865-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Stubs are provided by libqemuutil. We want to use the generic meson
machinery to provide stubs once, instead of per sub-directories. Move
the 'subdir' calls earlier so when these directories are processed
they can add units to the global stub_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 4ffbb96fe49..db051a1b87b 100644
--- a/meson.build
+++ b/meson.build
@@ -3725,6 +3725,13 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 subdir('gdbstub')
+subdir('semihosting')
+subdir('audio')
+subdir('io')
+subdir('chardev')
+subdir('fsdev')
+subdir('dump')
+
 if have_system
   subdir('hw')
 else
@@ -3770,12 +3777,6 @@ if have_system or have_user
   subdir('target')
 endif
 
-subdir('audio')
-subdir('io')
-subdir('chardev')
-subdir('fsdev')
-subdir('dump')
-
 if have_block
   block_ss.add(files(
     'block.c',
@@ -3845,7 +3846,6 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
-subdir('semihosting')
 subdir('stats')
 subdir('tcg')
 subdir('fpu')
-- 
2.52.0


