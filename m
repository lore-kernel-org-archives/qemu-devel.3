Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C85EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMiS-00080X-0W; Sun, 08 Mar 2026 18:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiQ-0007yi-2G
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiO-0003GO-IC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-480706554beso122859705e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009310; x=1773614110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OzEr0Nd2AyO6RB9wHjs1m98fsLiXBTjIk06FoEIBMxQ=;
 b=DqM20ATmLG8midKcuwcipAKfjKpnrYjpf++MXbI4En91I89tftjR/kraafOetkEFb8
 8GXsZnfJQY3ZlsfmhRSowJWgU5JOH3Sj73BWx9Yj7ttY3FqUKBy6Mh4LRAB6+5l0HMNU
 N7HbEXxxoH/DdrSed6+D6rvdmROLMv96BM9Ws3mLSNNdxxyeFSl9qYPhn0Nda1v7BNGt
 futf3iSR2SdZjQxBA9e1bpm1R7C1omjZX+4oEh1XjzvKWVIfhhSLrdhHgsaV7D22Fp1h
 OodgFjVrqtFrfzlaaPgYt0wWt/qNCf8rU7QAws55tWJ41tjNN7tJzA/nVj2NCnKyxk5J
 I4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009310; x=1773614110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OzEr0Nd2AyO6RB9wHjs1m98fsLiXBTjIk06FoEIBMxQ=;
 b=S0htbsDpulMWeeljGyuQ9UDmf/Fjt0fVRFZIujpTs6wuqGlwyl9p3SLed+jXvtvMKR
 W/Xj3pfdEN6onOy3yDLUi29SK92YxqGwIV/cDwov3FE1RDB2DF7btHjbyzTaeN0BTLZK
 4oheY4FqT0kr+X81oFH9asHJfs0H45/aJK6lQOJO7i4uN3wZpkFSUiEdWUoEZeUzOqaH
 3w0QFnD4KtTd61gc5ieWTEmjoE5CKlxJwVjDRvCI0oxySE/Emck9w+g9lLCj0JSpxqht
 60/FLSyN1nxu9MoBvqWgQm/hH2hK1dOVd6vjYl8hJpw+K6dyfwG9hbSRzquqYd7cdAqF
 mLmg==
X-Gm-Message-State: AOJu0YzoQ8OkXObIpgC3Ir27JrerhQXvebNRt2UE+oSiiyPD4Mn0XTcf
 VKwwKmEqurgCi8bNG8x4R+Llbm8z5QaUwCZzq299ierxqoIKuGUlpXwLCeOXaw0YQ3wPmUD2tnw
 OjXJEa3g=
X-Gm-Gg: ATEYQzzCX+ak/DDWOnDBsSDVcbok8nnCCMXSIA59Vb5CWklkoKFakA9kZJ/VeeguvFO
 6p7E1wI0WjCt+zTWNSWsAcg5dONXNa0V2qfq9DccKdvVJHjrsDnfa8SUCSo+O8MjLue7l/IkVvZ
 b6ckNvJHof2EwDwBC4Gei3Jtz9rmdHw/nzuxwQr5KGyVbSdIBPUz9jG8Hf+/isn9AiTcqGyEYWX
 RSSPvU2FQh/scqztc+XuOVGvTD5S/iV8vHghePUNzKHXFCk6mXrIZHqmP0qUlXainHS1UWvXkBJ
 lik1HfbE/zlnuw2KNxH4Il0g6mEniBv9P86bSloZinS+PmlvwvtWpTG9pivP07szINuSBrgjaOU
 elepJhnt0lChS9K18eOR5P4hQ6gtETtmBzSOwALajndaoE/xwMmI8vvVMQ9HDS/Gdmll4H8nXUX
 gF4rqvGCcjveshA7B4mrhg3An3Mt958aezsvW60V9pj0dEREOlv2cr8HNFxbkl/0K7rCak0s2ZS
 GiJwQ==
X-Received: by 2002:a05:600c:3b8e:b0:485:35a4:939c with SMTP id
 5b1f17b1804b1-48535a4a188mr61363785e9.29.1773009310524; 
 Sun, 08 Mar 2026 15:35:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad1cb7csm21405961f8f.0.2026.03.08.15.35.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/49] meson: Include various directories providing stubs
 before libqemuutil
Date: Sun,  8 Mar 2026 23:33:49 +0100
Message-ID: <20260308223433.25503-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260225035739.42848-2-philmd@linaro.org>
---
 meson.build | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 0029c970b08..102f0cbb13e 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,6 +3754,14 @@ subdir('authz')
 subdir('crypto')
 subdir('ui')
 subdir('gdbstub')
+subdir('semihosting')
+subdir('audio')
+subdir('io')
+subdir('chardev')
+subdir('fsdev')
+subdir('dump')
+subdir('accel')
+
 if have_system
   subdir('hw')
 else
@@ -3799,12 +3807,6 @@ if have_system or have_user
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
@@ -3874,11 +3876,9 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
-subdir('semihosting')
 subdir('stats')
 subdir('tcg')
 subdir('fpu')
-subdir('accel')
 subdir('plugins')
 subdir('ebpf')
 
-- 
2.53.0


