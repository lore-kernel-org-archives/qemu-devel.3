Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B866DE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCqL-0006Xx-NV; Tue, 07 Jan 2025 11:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCpQ-0004zM-Tr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoW-0005uJ-Ru
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:16 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso11993338f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268739; x=1736873539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=kyDYbzuLyBygTTJHPC8OObhghBQVfaW49d0Ik+3XbbNXg1PDtriwkyfAftIpUbaUEa
 wbgMchYAZedzR3a0WTDEqeAhWZGL2cm9YdHIDEX3SsEJYdvTG0X9H5qylXJwwil1DAxf
 F/OFu2ZaLl0r9hSFYa43sth3wDWUx/MjZcJb6rc1r9lq4/Vz81tC3ArY9ipeA2r2dU46
 YtMpdcGnvixaEnl8yjphXtM2I1xxDg0tjdsL8BUY9yaLe0GFWYcBVkMKVyb1iEPjnYDB
 f+0HaSqNNsWEm/MkRBrAKtnaJOlwwMI2qFC9pIu2f/U2ej5XM8UsUpoGN2bc2rb6qT+y
 ss5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268739; x=1736873539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=MHWvdUADLdwBQ3A+WdEzSSMC8o6jeXCB4ZGOQQu2SfZcjXkqJspmQny1MV+F2A90Uw
 JCkldPZuD/XLefYraPReY8GwXo/wluipu5JK/XUqnM6kCFZeP3OFTlGra/AxiCTOa07e
 wTDrVY0tnaYySbuwSwImAWA0oD73lRujWZEhEbwvzeYxgB0qMOlCYhyGH1QgPrOj9Vzq
 DdrI2i39+GPKk4k2bETklJ/JusyrunsvaUhk/4zI+CAt3cxGagcXuwZuez6aA8JlM5/C
 6rGvRXzHnOUes0InOxQDDokvERz/jEXeddeQiuDem+VYUXwLiO/G87YuIp/wzjt1W9Oj
 Bj1A==
X-Gm-Message-State: AOJu0Yz0bfoQD0/pZFn5QLm4WG8ybsePZOq6z/awYnNP52Nz+xYIUDLW
 LdcAwl9ny1iia19gKBNIbqDrLh8XLrr/ybDHrEkAm3Z/YBnsXdEzb0rr/eC+1fM=
X-Gm-Gg: ASbGncu0ZwZRp1SMP6CU9rqfWh4ZvCgABHT3/fnq8THeTgix5CvN59wB0p2cWWSY5I+
 3PX+RmKweDTR6ChNOlRhsX9c6/8gpzz8ywnd/coImIY7N/42i9uaOOwCffPJqBiHrUWgE3KM9Dx
 Ba2g1CWsKGqGfGFnGwZcIyD0T5vZtoAaZZhQVtKJdfa3U5D+CdRaQk7m7I71AwVOBTmyAcZR2Kl
 26XTOLFRx5mjnQlHGFZKCf1+wO05K87FkeHHnavk7nVeVClzzL3HGk=
X-Google-Smtp-Source: AGHT+IEaWFrVpOOV5AjR1fah5b3WuHfNw+KGECGBFK2AyHtnqReD+Gjicrr0aKlo3ea/TR1IkPP+gg==
X-Received: by 2002:adf:9b83:0:b0:38a:624b:e609 with SMTP id
 ffacd0b85a97d-38a624be681mr16073594f8f.55.1736268739033; 
 Tue, 07 Jan 2025 08:52:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8472b3sm50758769f8f.58.2025.01.07.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B3D75FB57;
 Tue,  7 Jan 2025 16:52:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 14/29] tests/functional: update the x86_64 tuxrun tests
Date: Tue,  7 Jan 2025 16:51:52 +0000
Message-Id: <20250107165208.743958-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
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


