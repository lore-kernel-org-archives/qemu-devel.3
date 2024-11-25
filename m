Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A31D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatp-0003xf-0D; Mon, 25 Nov 2024 10:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatl-0003vE-7A
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatj-0001kB-8j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3823194a879so3288407f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548069; x=1733152869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTG3Y5tKOEfi9fqNN9BGVUN5gFj9NcGy0+qiUrm1Pjg=;
 b=q5LaW0QJjlBTsaq4DnQYc2Ly1AMyOkONxbjPVG5qXA+D88QtcyLy7mF9Zi7Zlg/pUz
 ZB0t3zL1bMUEg8tVhbNg/DFfbeVMwaWyMx543AephCgZnieKRirrqIaRKAVp8AgbAE+N
 1GnL0mZ3Vkf/sUOaQcjlmkhQFzHSQdcrDyiwrh4bYf2FwQBzwrXJRWLCNHkSgzeFwsZa
 nG1+2h57LuH13DlHjGJi9YzbCdLu2xnDxylTkACnS9wsTNqIea66DoztMW+HtV3yrsQl
 6CVG0HtCRnCMIlywxtmTpqjIZi6AicoejBeGjtUZZpG6iOTJtL8eIiOe6M1x4vMoSGts
 ppEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548069; x=1733152869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTG3Y5tKOEfi9fqNN9BGVUN5gFj9NcGy0+qiUrm1Pjg=;
 b=ZAa6L0FLMS8COfg45t2mGC59IgG/nk2Vdi7Ah9ifStxIlEUFxTQfOyDZTrBsf2BP/H
 +JCDBSvD1HtekqF7wCDnZN9WlD2rRFfeeDPc97BYZhRpyqtnddnVkjaWRX2vYp2QXnzw
 cBcDmuUUJvQFf5UR5S/bAieqaZ/8473iCZnywmrlir1zboFyBpZUb+UsIRVmGDxAcCsZ
 T1CirSsqn9BeWZ6HSNGYvB5KBq5hcRxtpGiEM8gpCc636LuZzdQmYnlc2WQEFEljKubd
 MkUKO7sezj2/XVC4NSqSC9LEcKIs12Q4eYQ9Ml7b0GJXvlKi15KkVxvIrysoXphHHc4x
 EZZA==
X-Gm-Message-State: AOJu0YwDy+H9bSC0wZCZYifSt1ZW6MzvqViy2ayOpg/emM8p8h8zWdCw
 Y0yrX5bnCK4wBOYNPB/oKYVYnFYpMZJJUV2R5Oy7ZQl9dVX8j6wvY2xXIb5R0yE=
X-Gm-Gg: ASbGncvxzSjjdpnaFjLiu/nrsxIcMvaAb417zG8SxBYAePz117xEwa6a+nOPm5+WrT0
 FJSOpeIinutKTIfHlP2cr2zX3WGIhpKXNUhI5Au0slwvfQmDmbOcnDwda0NjIfV8c1NuHtRn1qR
 c7n/5gID4dFujU6mkWswfBz0TwYm4HPoFAUVbg6sVIpqt2Pw4i1mjsln585QIXFHAPd9PYk2B20
 bhiGat8S7K4sMbq5EO8XRVkXXj5Ex4pXbdekvHqHFVgQyfQ
X-Google-Smtp-Source: AGHT+IEsMhhF6mUF1FELVG2Yg4OyrfcQOYTEGn2JoZ6kGCoZh5jWW/Zz78iFPsye7sWkPV/dIURRCg==
X-Received: by 2002:a05:6000:400b:b0:382:4f70:10cf with SMTP id
 ffacd0b85a97d-38260b6213cmr11679493f8f.20.1732548069467; 
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2685csm10901782f8f.46.2024.11.25.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DF985F94A;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 04/28] tests/functional: remove todo wrt avocado.utils.wait_for
Date: Mon, 25 Nov 2024 15:20:41 +0000
Message-Id: <20241125152105.2100395-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

We're not using avocado anymore, so while the TODO item is still
relevant, suggesting use of avocado.utils is not.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-5-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-5-alex.bennee@linaro.org>

diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/test_m68k_nextcube.py
index 89385a134a..0124622c40 100755
--- a/tests/functional/test_m68k_nextcube.py
+++ b/tests/functional/test_m68k_nextcube.py
@@ -37,8 +37,7 @@ def check_bootrom_framebuffer(self, screenshot_path):
         self.vm.launch()
 
         self.log.info('VM launched, waiting for display')
-        # TODO: Use avocado.utils.wait.wait_for to catch the
-        #       'displaysurface_create 1120x832' trace-event.
+        # TODO: wait for the 'displaysurface_create 1120x832' trace-event.
         time.sleep(2)
 
         self.vm.cmd('human-monitor-command',
-- 
2.39.5


