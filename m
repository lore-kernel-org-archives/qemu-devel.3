Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FDE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUzk-0007eA-Mf; Wed, 08 Jan 2025 07:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuX-0000qs-I1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuQ-0007JB-OA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:44 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso29184407a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338268; x=1736943068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HRwD3Xk/RE1GAmonVu05a0HKbmwgTGs+7B2YTG5x8w=;
 b=okO41V5SBfHiHYX5gdDtxVa/Ym+l2ZVqDFx7Mo7UaUn4J3UnJ7i+GfbCKI2oC8swWT
 znCIRPg9jyBADG8pkY3/Y1ckWVY79IwQuX2665/wfGj17wbXAXtSCp4x0moCq4rC70Z1
 yEg3F1muZZDen6wIBR3wnkXIUyGMzcW3IB4v6saxgox48YgGawYvucw6OKnXKpRmaCBa
 XM7BPJAD9tqeOU8+mi8iGdwgXtKdbXq2oMnzyvDcEz3D4XbLtzMjyokMOukmB3+J4T81
 T3bqzap/W8r2Wh8PHn4L/INdg87TdnlLEWCUbP9uFcHnE5R00dycnOrIj97x2D9Da5ZQ
 q9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338268; x=1736943068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HRwD3Xk/RE1GAmonVu05a0HKbmwgTGs+7B2YTG5x8w=;
 b=NiPLg3HRghNZZey8lJKGP0O8WEL7aCfOoF+vEAXqUxPorsxCf4ge1SV/i1c5A33NZ2
 O4UaDQEzjV11K/XTOBXvy3a7DboDSBQF9yCkZrVHSd3eMKqcBEyAumpio7OZPnZnZdYQ
 oBTqJP9dlciGzw/Oap+ZUYpmLiA2bOVkq4x5FjJu44vDJG63cBAeAQ8lm44yodt85ufZ
 9lSG43cjsqEaXnOOLSH+w9yM0tdiHN+RQUJx8GbJulgazdnBac1Zq6dvWLH/e+JdvPvY
 oM+ZcFjgdXH2b1Z2/2oCjIkyuukkO3Coafg1jhyNzJmgl4v2bns4cHXH5o1LzGl03Fwn
 GaTg==
X-Gm-Message-State: AOJu0Yw/rFugEatGadsKDpzDZrniXox4JW0+BHJqcVdzKNsofARU2PIa
 OqmGYNCIFe+wgIKx0GseRFbGsC4NkXpH0DiDtasLBlE5fDx7z8sspx5Nzkg/IwA=
X-Gm-Gg: ASbGnctUdrtnv9ZVmjEKCl8Psi2IuIZ5qaleFukCZS6G98H/2Mn2r6GXT/MKbkyuyv3
 W/uI0Y1czuYKe0KUiSISS0ylQ99OcKvnDKV4pUd1Fp/mWQ/NZkwIviR4eS1Rfe4+JpBtolOAZxw
 inpU0Ve05Q0ZbDNXt3gR8tmx5zn55X+a4MdrgJ4Hv80RzKzpv/Rb5tmHBa31ILpCsb7KOpadBeM
 3l36DR/wSIrlS0w1bATRtvrT8/9DqUOc49UwuyfjfwX8znRdcHfPnY=
X-Google-Smtp-Source: AGHT+IFY3ZzBcQM1E6/alkP2RAZ8qSnRf6906PsySVEEVZ8O/5Ja/l+Urwz/mjb8Eu8b2C9k9OpbCg==
X-Received: by 2002:a05:6402:2681:b0:5d3:bc56:3b24 with SMTP id
 4fb4d7f45d1cf-5d972dfcb34mr2190829a12.4.1736338267819; 
 Wed, 08 Jan 2025 04:11:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80676f08dsm25968279a12.21.2025.01.08.04.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0FE75F9E9;
 Wed,  8 Jan 2025 12:10:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v4 11/32] tests/functional: update the riscv64 tuxrun tests
Date: Wed,  8 Jan 2025 12:10:33 +0000
Message-Id: <20250108121054.1126164-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
Note we re-use the riscv32 kernel and rootfs for test_riscv64_rv32.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-32-alex.bennee@linaro.org>
---
 tests/functional/test_riscv64_tuxrun.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
index 4e2449539c..0d8de36204 100755
--- a/tests/functional/test_riscv64_tuxrun.py
+++ b/tests/functional/test_riscv64_tuxrun.py
@@ -17,18 +17,18 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/riscv64/Image',
-        'cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
+        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
     ASSET_RISCV64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
-        'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
+        'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')
 
     ASSET_RISCV32_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/riscv32/Image',
-        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv32/Image',
+        '872bc8f8e0d4661825d5f47f7bec64988e9d0a8bd5db8917d57e16f66d83b329')
     ASSET_RISCV32_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
-        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
+        'https://storage.tuxboot.com/buildroot/20241119/riscv32/rootfs.ext4.zst',
+        '511ad34e63222db08d6c1da16fad224970de36517a784110956ba6a24a0ee5f6')
 
     def test_riscv64(self):
         self.set_machine('virt')
-- 
2.39.5


