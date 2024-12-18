Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E893E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoU-000065-T7; Wed, 18 Dec 2024 11:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnk-0007XK-5w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:35 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnR-0006mw-JW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:26 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so10254551a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538872; x=1735143672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=hhhF9cB554hLCzySmpV/aDJFpUSz6/UXrzKQEUMVS+vGiffQNgX0xMh6xGueb5Fqbs
 VQBRGshazM5yNbC9e59ENS37YsL8c64k69S0PaA9/Bm1eT4VKwxU7uUsQ1lDJym/OABk
 WEC7Cz/cVpDEJLWJTE8mGv9ifQK6dR9DeKJiS7K/5KDXpP9FXGW64qxk6aa8vsuX2KhU
 o7ZnXklsxNtzZ2PXFsMaYYpA/xSYvwa2WJpU2jJHMbqbiM/pLp1fBdUSHuJ3m5kyMNIW
 R8MrwpDDhOVGLj7nFV2IQfArSKA4Qiw7+UJUpItfPFKrO7EwwokejTU1G9CYDiTfsYGP
 qmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538872; x=1735143672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=BcWXheYqiCYMl5HWmDinYTDhKoUSDSW9qbwG1C7hJx6NVwJj6RIcT+xmzhjBwp748c
 IyyFXKdBuAta+/pFoHs22ftjvZunpw1p7vxF/iBQt6nuIHCK8vrqyoPlhIvs8YL4JmWz
 SVscF3TLrnxrxvuKmXGJn0RuTLOm60S3I8X1kBmOoo71YTMtJii7IarZqDhn+bDXedn7
 EFJwVooedqZxoxQv21LgnySUQu0K1aDSCKNGjsQTp1KvXy4whdvw/IwwyIHV8g17CfPv
 c2yrq0O8R9w2Ww5KqLS/wK4GukYklQRVx2mo8FXgp0zn6PVVMihFK8eMiBJGvafDMrIe
 EKyw==
X-Gm-Message-State: AOJu0YxGj3V8PdiKyUvU6IT7RX5v1I4dnmIshEmgRcjyLxg71LXoVH27
 oNJDtE2Jr8idb9m+gzZOxXYwOtENZUJSOQjsHpgOO0mxSSftHYH4swOy/zDCP7w=
X-Gm-Gg: ASbGncsPaJniNZZE9p5rUH/exeajsh1ymh0QGkiLXrHb8REZsjNZtHfovEiG5hasWp3
 7BqEX8Y8TPfAmnzU47pEfyXZ+HPFx2txBrbyDLTi+kxZ0yyOlE8fBGMT4NzJ0cvRN/WcWWOnpUN
 78qSxQvgc9rA0+1Gsme6yCRDOMNDTjvMnLvrQ2jrNuBYowEl513+t6/jw0tkuG2hJ1MNm9n4S2X
 JiNGUcsTBjR3BkD8TqKq0C2REDLigglBaJ4aufJZ7jVpoBe9ZFfi8w=
X-Google-Smtp-Source: AGHT+IG5/nPrXOE16aGHFoCQQajQvWD4WrZI5eVE0+W/fpWlO8sHRSpqFjYYoG4s/kkwVffmezY1mg==
X-Received: by 2002:a05:6402:3605:b0:5d3:fb9d:3f69 with SMTP id
 4fb4d7f45d1cf-5d7ee3fd6d3mr2931864a12.21.1734538871711; 
 Wed, 18 Dec 2024 08:21:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ab5077sm5551729a12.17.2024.12.18.08.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3F4B5FD05;
 Wed, 18 Dec 2024 16:21:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 07/27] tests/functional: update the mips64el tuxrun tests
Date: Wed, 18 Dec 2024 16:20:43 +0000
Message-Id: <20241218162104.3493551-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-Id: <20241121165806.476008-28-alex.bennee@linaro.org>
---
 tests/functional/test_mips64el_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/test_mips64el_tuxrun.py
index 819549a27b..0a24757c51 100755
--- a/tests/functional/test_mips64el_tuxrun.py
+++ b/tests/functional/test_mips64el_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64ELTest(TuxRunBaselineTest):
 
     ASSET_MIPS64EL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/vmlinux',
-        'd4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/vmlinux',
+        '0d2829a96f005229839c4cd586d4d8a136ea4b488d29821611c8e97f2266bfa9')
     ASSET_MIPS64EL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/rootfs.ext4.zst',
-        'fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/rootfs.ext4.zst',
+        '69c8b69a4f1582ce4c6f01a994968f5d73bffb2fc99cbeeeb26c8b5a28eaeb84')
 
     def test_mips64el(self):
         self.set_machine('malta')
-- 
2.39.5


