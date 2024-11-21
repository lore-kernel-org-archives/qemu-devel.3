Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EE7D78799
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfp-0004K8-MT; Thu, 21 Nov 2024 12:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdv-0000lb-1o
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:07:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdV-0001fS-Kg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso9947365e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208792; x=1732813592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7laBJrl+W4Rvzk4IQJPfXs6McNiuuH0uqEtfbvfMrF8=;
 b=whG99bOxWqwt61iJnpudZ57fwkcpuGlmhj53pQYwbFmLFHqJxl165NaJlcR4V77/7d
 6egNIW4mxbG2bYE8SaDvcs5I/W8wr9qBf7QOZOKnj6zlnIaxSH0JnFsSjVUqvRxfH0jL
 F5I6FevsML79tvSupn9HnVUR1u6RnLz0yT3Pkh/5H7a1WsCL5gpp40Ys8XajnaNGRxTq
 34RQjol6pzIa+uBadq0xWcAuMmsYOiEQKbi9BxEWyVp+HULQ4KzOSHxuAGk8McfPzm1M
 xJB3C8heWRFLXg2wGGf+XM5cxLryJd3UBDC2yYXHVmpOBuCEK5u2AMyh/P7hiGPn5s0x
 dNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208792; x=1732813592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7laBJrl+W4Rvzk4IQJPfXs6McNiuuH0uqEtfbvfMrF8=;
 b=hWcgN5mBbavZLi7L+2hnYzp145NNLLsWhtz8qctzeN3fZdOYhMWC8k3gKdgt0Q4WPq
 V0s+kqBI9nlDFXGg66J+QO4lH1OycDMHXWtaNMjZ7AxBJXsSDkSty+ffoMP4mVGb/wCN
 qNQz9MMaNdAsheR5O2d5fnxw0ndbvbuptwWQ+PLAnclzjFYTs8kjXWK71Tk1wzT40UmW
 EzDpSIw37rZyPbSJqGSWgqG927MUoWAWBfZPfnpTWka5Tdib9NiRgoVWYeC29x4d3nju
 EdgJbqX9NaRUtY6qvdOyclv4s/j9FBhxVpzcVnQwykLstDaWanamIBu93+oiYmUcFai6
 r47w==
X-Gm-Message-State: AOJu0YzP4UznVeG9A4AVzRG5moIwKn5bZbKClt7TIT5iBZ9CqeT/iSaf
 rvc3xzHB4duhFVSo4G4u5l0yG+rV6nZBMD5SN6wtZ1VmberfFm02CQCmfMKphdo=
X-Gm-Gg: ASbGncvs/h+T84Nj5ReDovPbdERviSxu0svlzsYWdz+ArGa4AND8q6MELOVNbFaWTJT
 B84lStMqBnR2kDAZMy1ifll+WhnYMaSiAwD3SwCgEIZnHdfAdh8KZ7mB7xNAUF8Kp0oQ4PUlmG2
 iDQIwpMTSVVf+CN8hR1Tw0wkECRPqMCg00eCW8atxE136ykaBAFNgPC2nEiVGZ5X9F0WQwLuUNs
 Q9oYc8/MXEHWbNbmiYXaC/K8wH51cCqkHty2e3jm3eY0yp6
X-Google-Smtp-Source: AGHT+IEQy+BuKZaCrNU69MYqx+XrV6o4zO2GbFzRyEevncGawYr0VelvSVji1yZp7srfd4MlbrohSQ==
X-Received: by 2002:a05:600c:4f08:b0:431:5ba1:a529 with SMTP id
 5b1f17b1804b1-433489af8cfmr70393605e9.14.1732208790899; 
 Thu, 21 Nov 2024 09:06:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ab37sm61332365e9.28.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BFF560439;
 Thu, 21 Nov 2024 16:58:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 22/39] tests/functional: update the i386 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:49 +0000
Message-Id: <20241121165806.476008-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Now there are new upto date images available we should update to them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_i386_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/test_i386_tuxrun.py
index c593ffbe8c..f3ccf11ae8 100755
--- a/tests/functional/test_i386_tuxrun.py
+++ b/tests/functional/test_i386_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunI386Test(TuxRunBaselineTest):
 
     ASSET_I386_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/i386/bzImage',
-        'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/bzImage',
+        '47fb44e38e34101eb0f71a2a01742b959d40ed5fd67cefb5608a39be11d3b74e')
     ASSET_I386_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/i386/rootfs.ext4.zst',
-        'f15e66b2bf673a210ec2a4b2e744a80530b36289e04f5388aab812b97f69754a')
+        'https://storage.tuxboot.com/buildroot/20241119/i386/rootfs.ext4.zst',
+        'a1a3b3b4c9dccd6475b58db95c107b468b736b700f6620985a8ed050a73d51c8')
 
     def test_i386(self):
         self.set_machine('q35')
-- 
2.39.5


