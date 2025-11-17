Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132B8CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2jZ-0002Lh-Dr; Mon, 17 Nov 2025 12:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jM-0002Id-G4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jK-0005jV-RK
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso29876015e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399368; x=1764004168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsnbT3j0Gpb5qxhin8xm580J8CadoBQUdRwStMHWYw8=;
 b=nLAyHuaKt8aAo54zNSf7rwKTiS9gEofiq5yTe4g9FuxR7hgRF+WmYZ0CusUb2HsTIM
 /E9oKaz55pwgSDVeQBW8PeU0nvJs8Q00uSePvGLmiuZ0V6R2XGMoFBoN55cU2jpYv4h/
 GZztX0u3ne7u3htWlnJvLtBYB/DJSefegPeXOxYJ/Wk+hylfHYdIyA3raTnXtb/C89E+
 ZTGtKday7dGvGyH1JO8erpRD8jBQOAUtIpcrXUq57XTC6YHRWVZJzKCy59ItSW6bgjPQ
 QZ3tfB1bOkO35KWsfnodtG7IldEYbQJ6+Opo3vAz/Yfsa3AWblYwCBpvqK6aNAtSq8UM
 QJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399368; x=1764004168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YsnbT3j0Gpb5qxhin8xm580J8CadoBQUdRwStMHWYw8=;
 b=O7L2NP2QofPLdz+KD/Pn4dquwgIimK9IS6UnImqvWeRm5ywBxG7qdR3rWQZKNMUBKN
 uXHrngxF3BnPh9S6GkCY6wX6S4EZE4jCd06r50ar2DLiKAAE6s1j4mFmHSqspkkPq+W3
 Eg4rQKV7+QkVxhOBLUelhoIk59uY9dAkUmKqDS2zU+Z+IVPV99Gb1Jor3rBxwdqGsnEX
 wbz7ZjPsaIBBKQOPwbcW9tSQo2bnOWKkeP8dhdRTzkkaeR97nLxFntdm6re4hzYuENoV
 /XHjLFeCFmn5sH2PjnrsRzBDSIyUWCVASy0sqFecnBIdydJmNH13Y+/OMu9mx9VdaWG/
 7blA==
X-Gm-Message-State: AOJu0YyqcJpmIpqUuNZHtA9AAvgPVOFksT7+2/RKvDGGMSqixPdvU1TO
 zSnO/IbP1c2749eVDMPQ8ITX4/eRed5G+ECdttIM42/ykhKqX1kbYTM6GjtVD0Bxesv22mWURcx
 47dDl0pA7PQ==
X-Gm-Gg: ASbGnctuwM1sR6Lw6zo7UeeXTv1HYOx0+aUhKNju/bZgN9ZM2LZqVghJ3Wj9AypzzWP
 7C9UR6xgwNsZjoNHj3dAl3xUYc7BFtZjDpt/GfRZUwzvraltMFuT8PuUHWDbQ6/pRh6OoW5OrZQ
 LFkLiMaxG8k1SFnjeRej8qvWfyHjCf0Q56ZkHF31yvjL/iHz3zrnArMmAvi0WatsdeyTvgtMIio
 o9qtAVwfRAjHi6GnnEZzjTit5AsGnETMlxSuDAWLP0IqttDkB8b1uMPddagf+4jXWlH484rQ3O+
 1FWPyjJYYD28FZXMFsY95oA7cLct0PlOGU997/NY/aWun52/82xWUKsETLL7p48TJMUZSrB23KE
 AyLYcwaOO8X8HicITlwT6ktCNQQ+eI4jGwT3qO1IesG5Krf66LuZofu99i9u/RxAMHpSsscsGLy
 TIwk7KHhfkKrwl9CUuHUqM3LE7ZYVINt7vkGk5ZDeLsGYLg/RlXfoFM0w2NPfK
X-Google-Smtp-Source: AGHT+IGiizAFXdbk4QhC45vlRRwoe1Pnnd/shre7Oo34f/XWN1GQcb3Oh6SUsnsk40lgEvcgPAovug==
X-Received: by 2002:a05:600c:6289:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-477a94ace2emr1201515e9.1.1763399368045; 
 Mon, 17 Nov 2025 09:09:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477980cb1aasm65792615e9.8.2025.11.17.09.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:09:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v2 1/2] docs: Correct release of MIPS deprecations /
 removals
Date: Mon, 17 Nov 2025 18:09:17 +0100
Message-ID: <20251117170918.80248-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117170918.80248-1-philmd@linaro.org>
References: <20251117170918.80248-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are going to release 10.2, not 11.0 :)

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 2 +-
 docs/about/removed-features.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03e29915f0a..30ab72b2a4c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -192,7 +192,7 @@ The ``info capture`` command is deprecated and will be removed in a future relea
 Host Architectures
 ------------------
 
-MIPS (since 11.0)
+MIPS (since 10.2)
 '''''''''''''''''
 
 MIPS is not supported by Debian 13 ("Trixie") and newer, making it hard to
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 88ea0dc4edc..a72df26dd24 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -896,7 +896,7 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
-32-bit MIPS (since 11.0)
+32-bit MIPS (since 10.2)
 ''''''''''''''''''''''''
 
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
-- 
2.51.0


