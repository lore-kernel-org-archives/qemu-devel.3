Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A924E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL762-0007bO-FV; Tue, 10 Dec 2024 15:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75f-0007GD-RX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75P-00025t-Dx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:19 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso187235e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863442; x=1734468242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=mRg04X0UvG4R0peY1H4xWwvgeVFy+KucXzWvxokoa7kaGrJqt400msKDI9hEQPXRvx
 Ewwt/scovlLZrj/nqASTWIy+D9Ye3DvYQR8ZPwdmQxFttepgyoqOyDFuAXKoUQpSyiFG
 MHUPWyPtTs131YBsHaaDdDxeGDp6ICTPjgMZRDXQbC6WH2Lmbq4pSPuFYzXbckDoJ78I
 o/WlMW0HhJljdIuSt2f6zw364PrH6oA4AbiqqNQUF7Q1Hu5D0HgjJ/hVdgnPPjguANEq
 ScutaJtdeAR0YmpY869RzoJv5yh8n8vrWulobZ72dcDkVRMNG3CTKmNl1xCO3psZF/rd
 /a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863442; x=1734468242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=Evpy1xsXaC/SsGNF0gEDsT3rlPTgCgfMxBeEZsxmMjYphSGpzyer7sEqe4fueJUZuJ
 X0Ghj+EDGbrurbs9bzDluoinpGIAXtpU9RM+ueSZBG9wELW5QlBaQLX+mY0OwkhZCLL9
 J7b+W4lqIjhSDyzDQHzkZSttRQUzKUQ8W14NUTEWVs+KYQ1357/P2oBjo48OGSkieV5n
 yLBDYVhiVwk2dC2iWzJWXnSfj0vnO9Wwff2oBJe/y1OP6bOZ5/8KQ08yUDxVHF3lLFna
 24MPHX6bzA0rMeKhX21XXwjF+iQI8TR9f3Y0qC3Vpyfe4x1LSHAdXGEMJD/9D0lgIi64
 000Q==
X-Gm-Message-State: AOJu0YxT5KWyGOdy1FZ8mZlOdfdw1rN8algWixn/i12z5qJr1mr/dV0J
 4wMWSs7AoPrDc/yNaSuTXHd0vBu/S26yNi59szZSLOpey/q3xzL3oAZ2JF9Twlk=
X-Gm-Gg: ASbGncu8jc43a1svyyGOXkYWXAaUZPvhNhzoPOZk5zZbIqvbsgnP5A8izCrP6Il4i9W
 SdrLdXU2EOIC+hMLYCx9Iuf8hwBflCyPw5aCz8cGeZ/JWH8t0U1N05KpT4g5PtCvAxHufXFpntc
 2qtJ/JlSB0h3MVZ0HDNvR+QOhzAcWbYuutb6aoP9PHILWJUHo9aleIGBdB7XCDbSEt2iLrc6jL6
 LLsj/M415lpuXehldEdwA+294RBCtPw2pCHdKmNZFHCXsnJonEy
X-Google-Smtp-Source: AGHT+IH8BnERptkU7k4QMcxR60Yv9v9mI4DrIhO2pUwrrrapv1S+iIzAfLvztAY1nuTxXt4P7U53iQ==
X-Received: by 2002:a05:600c:3b9b:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-4361c3c6dd9mr1882795e9.18.1733863441915; 
 Tue, 10 Dec 2024 12:44:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm236170905e9.17.2024.12.10.12.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94B3D60370;
 Tue, 10 Dec 2024 20:43:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 14/20] tests/functional: update the x86_64 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:43 +0000
Message-Id: <20241210204349.723590-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-35-alex.bennee@linaro.org>
---
 tests/functional/test_x86_64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/test_x86_64_tuxrun.py
index 4f96139871..fcbc62b1b0 100755
--- a/tests/functional/test_x86_64_tuxrun.py
+++ b/tests/functional/test_x86_64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/x86_64/bzImage',
-        '2bc7480a669ee9b6b82500a236aba0c54233debe98cb968268fa230f52f03461')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
+        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
     ASSET_X86_64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/x86_64/rootfs.ext4.zst',
-        'b72ac729769b8f51c6dffb221113c9a063c774dbe1d66af30eb593c4e9999b4b')
+        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
+        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
     def test_x86_64(self):
         self.set_machine('q35')
-- 
2.39.5


