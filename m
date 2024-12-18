Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDB1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwno-0007cT-8m; Wed, 18 Dec 2024 11:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnW-0007T4-NQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:19 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnP-0006iI-6D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:18 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so11462889a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538870; x=1735143670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAm5CLLg9CbkGcsm6UEr9S48g/0qIqAr62CjoayD1as=;
 b=zIy23gx0QFVg/EAy2eem36McrkMn3G5IvsEr65gJgAYWCmJrYf2vy83ofX3uc4dR7I
 QOcjNkiDl+WR+NzppB6lE1O/Xl7PxYPaZbhiBxcfIdPhJthSBNINTrcvZQQWMOyVIDkR
 9LJ3INaivOoHkPJqeZY1CJLRCEwKA15iT+6jcyJQqjmewN1GYMd7Frx902AAeaumaIbo
 1A74cGXF+4r+2gKXYTxXEbU4xeGAzsc0HVkBQnsqVfYlkO/IbndmyO8T/8qVicL0lZW1
 L6Wlim1pchBpbhcIgskLaZXR28godhMDqTmIta2W6SbkpqgyYQ3w/i29mgIxxQ9BPaJi
 jJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538870; x=1735143670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAm5CLLg9CbkGcsm6UEr9S48g/0qIqAr62CjoayD1as=;
 b=iwSu0fn1+jiUNbINj0ih8Z+SaxO/mg/chJroXpTEH1uw7PIOAxCu1Ws4WSiksMndTP
 EuW1k3KlcrlhmcIQWW3T8A+REV1czH1TemqMO1wes4fVyyYi2L6+epI55uRs+W8Sogtb
 RNClERU4k1TMGrnSBD3J2BD8OSVyHwfLI2qqVuvYdBFznnIWSZ7vv69hKS0y2E19uNxq
 0LIjD8xY3fKU90njLN8dy9yYVOyIyK/9S1rfCIKKv1hPGprdOUt8jW5dGoNQWqc3GRY7
 B6NtgV7PTlQ/828SefJ8yv5VjSDH5l36lrmoFLTtNFvMm32VQIkcAdYY5lx3THdNu74d
 6mVQ==
X-Gm-Message-State: AOJu0YzvTrX+nrbfXZ+bHzB49vPfkFHgxpzPXydNdcmsALa+8rP6l476
 AD+n60aC0IQZ1DyHODl3HZ86elZ2RmlWxi9LswhhNreRF4pXKp87ulQVlhGchXU=
X-Gm-Gg: ASbGnctK3Bf2x2YozsYzsA+cUEo4Hj1ZVG52L0sI+QAG5yhnEUyZnXkYFu6nUIIe+gr
 wIlwavpkSN+Yg2Om9rSM9Wr6YuJga9iCtqMGUMm9NQJ2a+1x3cC8OT467gRgcIVgWSvTTjoNlvK
 zuqURDcf/j4U94Wm+d1P45x8H3ulCClmVcBcy4w8upoEGgaJ57Ll1/HXeTw3MAZgVilGAHCrprl
 XPLymoPAeXbh+Q4wcFpWw8+u1MfdnLNikJNG/HWN8RaNDQW4Nh/MDo=
X-Google-Smtp-Source: AGHT+IGgEJFqy6xvUX7qZX72PzvrtxGNWBSp+bhDEGv71AVeMwpfd3MDsAQcsw72vditHd9aluekGQ==
X-Received: by 2002:a05:6402:5008:b0:5d0:e90c:dd61 with SMTP id
 4fb4d7f45d1cf-5d7ee3ef55emr3275812a12.21.1734538869612; 
 Wed, 18 Dec 2024 08:21:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ad17a9sm5600337a12.30.2024.12.18.08.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92FAD5FC9D;
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
Subject: [PATCH v2 05/27] tests/functional: update the mips32el tuxrun tests
Date: Wed, 18 Dec 2024 16:20:41 +0000
Message-Id: <20241218162104.3493551-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-26-alex.bennee@linaro.org>
---
 tests/functional/test_mipsel_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/test_mipsel_tuxrun.py
index 2965bbd913..d4b39baab5 100755
--- a/tests/functional/test_mipsel_tuxrun.py
+++ b/tests/functional/test_mipsel_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMipsELTest(TuxRunBaselineTest):
 
     ASSET_MIPSEL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips32el/vmlinux',
-        '8573867c68a8443db8de6d08bb33fb291c189ca2ca671471d3973a3e712096a3')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32el/vmlinux',
+        '660dd8c7a6ca7a32d37b4e6348865532ab0edb66802e8cc07869338444cf4929')
     ASSET_MIPSEL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips32el/rootfs.ext4.zst',
-        'e799768e289fd69209c21f4dacffa11baea7543d5db101e8ce27e3bc2c41d90e')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32el/rootfs.ext4.zst',
+        'c5d69542bcaed54a4f34671671eb4be5c608ee02671d4d0436544367816a73b1')
 
     def test_mips32el(self):
         self.set_machine('malta')
-- 
2.39.5


