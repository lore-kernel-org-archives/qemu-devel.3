Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E59E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUv2-00017t-O5; Wed, 08 Jan 2025 07:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUu4-0000Y3-Bp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:20 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUty-0007FI-4F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:13 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d437235769so9937187a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338260; x=1736943060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqqTepJSvigFJNtOuIXqMUPxmyV0Odh55cVF5+vDAVM=;
 b=XmGj4ebx9NCVx7sLb5g6sieR8SiGVi17rQbZlZXpqJvKzlQ+Hz8JEK0Bnn6oEne9BQ
 jQjG18S9cEngWmS80HWGe8OwGFGURnXHqYIC5iXl/h/nQRle8v3xl+cNISyPtvlj/7oq
 t/anmXV7MA7WXVh6JS8rMpMDQ5c9DjzhvIa8F72ADC7t+0PTjp7+KdN1gUmWZGMNu51d
 VrxykoJ+kWW5GF4NRbvAN+qudQjkBMbkxEve0/B9qPeKhj5OO+iyKx7ANdblfP3zT4aW
 tXHi23A0bu9eSJ5423T1GMKMsbGu+yIu/8UMuJdhnXpTDM5P/0eEXsXJPzdOlqU82lFx
 hhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338260; x=1736943060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqqTepJSvigFJNtOuIXqMUPxmyV0Odh55cVF5+vDAVM=;
 b=u42DDQrZPtn1rOltFxqkSOXrkjiJiPQt0IYDpubBMcMHnDOPtbZT59Vd8Ur81AJxht
 GJGxLVQRoK1sR0vRxH4h/3uCK/TSgGDRbUX3sOMnTRpSp+WfxUyrrPWJKsKdRMh9wE4O
 NrqtcktftJf4ta7UgMYqGusveAWd9XT87YH0lS8vAzw5uaVZ1An0zKAbSaVM2q6358uh
 BQ/N0oBH9xsbwQOoRbcy+cRR5H0hHI9zq60F1TI7MeD3zjv3ppvzlH5EPKydu45rYdK1
 T7aIOAhYkzQid6HsEzrOJI4PUOmEI1xFWt5Tg8Hyv7UV0PP6B0bMHmJChvSuGlEtP/z7
 AWKQ==
X-Gm-Message-State: AOJu0YzjecCuOAjbB0RinOgybwKV1Iyh4sE+B2GuvK+WJ6k4ajtNfiUy
 74hyv3o1N0jTViSB3TBDL2MqW8RyTY2vxiSeFkDnumMF6kXddtx2pBxRE6MydJg=
X-Gm-Gg: ASbGncs1GT7cNbawtg8zfcCyGIzoPS8+cjX84SrvZi+DdQnH+ODqJP5zS/zAGPONAIY
 utDUBmAAIKLQ9rx6twDrZ/Po//HIWluhRlrPcpDcPutmPODqoeyVfwfVopuG4waDnqtMd/BPdj8
 wiwD/Iv1gXM6GxT0wbB/sdbAwRkahv4XSNJjZR8qJBeqdn2ib/eZj1U2Rvg1GLVNX3hD8Oqurjl
 +V76FiVWsGYVetZ6X5GDx96xTiBSIqYP/BhMieYyKynsOOd33aN6mc=
X-Google-Smtp-Source: AGHT+IFa2d8uZ9SIDFxzxS9uWLRjCmo1mYQXxfkxQrpAww6d99DHh9NBk2G7MODrvg0vuv7VFP40Aw==
X-Received: by 2002:a05:6402:40c6:b0:5d0:c8fd:108a with SMTP id
 4fb4d7f45d1cf-5d972e0e594mr2151228a12.13.1736338259735; 
 Wed, 08 Jan 2025 04:10:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aaee340665asm2051194866b.187.2025.01.08.04.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:10:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57FCD5F948;
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
Subject: [PATCH v4 08/32] tests/functional: update the ppc32 tuxrun tests
Date: Wed,  8 Jan 2025 12:10:30 +0000
Message-Id: <20250108121054.1126164-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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
Message-Id: <20241121165806.476008-29-alex.bennee@linaro.org>
---
 tests/functional/test_ppc_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/test_ppc_tuxrun.py
index 50b76946c4..5458a7fb71 100755
--- a/tests/functional/test_ppc_tuxrun.py
+++ b/tests/functional/test_ppc_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunPPC32Test(TuxRunBaselineTest):
 
     ASSET_PPC32_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc32/uImage',
-        '1a68f74b860fda022fb12e03c5efece8c2b8b590d96cca37a8481a3ae0b3f81f')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc32/uImage',
+        'aa5d81deabdb255a318c4bc5ffd6fdd2b5da1ef39f1955dcc35b671d258b68e9')
     ASSET_PPC32_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc32/rootfs.ext4.zst',
-        '8885b9d999cc24d679542a02e9b6aaf48f718f2050ece6b8347074b6ee41dd09')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc32/rootfs.ext4.zst',
+        '67554f830269d6bf53b67c7dd206bcc821e463993d526b1644066fea8117019b')
 
     def test_ppc32(self):
         self.set_machine('ppce500')
-- 
2.39.5


