Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DDAE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoY-0000H1-NO; Wed, 18 Dec 2024 11:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnn-0007a2-Fx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:35 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnT-0006oX-KT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:35 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so896617766b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538873; x=1735143673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=v6et6jg4jFzKEM4ZlsyaLgy85D7gmiwYV1pZKYlhKrW7pZ10dhhebSzS0G6z4LdEwV
 y1zLPMfE+pqG1+G4q3oM/QjlbltI+une4PT73e5XowfQcEw2nlhZH+f/yTFCmTZN3aNh
 s/Gb46xoylQjTjgC7hALxQd5tf90E50PASNT2Xm4HpmCbZ3pf7i302StTi4SjYhhaXkS
 faLbDj4NfL/UwiXtFW+UzJwm7BHCh1EvRuTuxKZbEF3cixJWjesRwCbz8DHgr/IWC/fw
 QInbOOGHT6VhX37aGxu1HcUu5rQRYv5bSmwiDQ35RnM6Rw3Q4c/XcKU9IbFEqEPc4Efp
 fFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538873; x=1735143673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYtPKP+K5TFg3ROfXNJmvA24TJ2xerIjRSKiAVxUUqc=;
 b=Dl+Aag/LfoYoO02/KW+9fksok5aUQ6VBAM6aFAQBK8EZTlHNs6atUClNdmkidvsfwJ
 5D0xaixrx5ZhAG55/beLcggigQkzg/s3c8slKGrQ64+jGC1U3Hljsz2ia2QTLknmR4No
 2PumyQX/4xSuODgxJvUlu2cV5cfEJnWCP+0RUPkHIIIleaJU1v5wK5M09Vfeh+pf3aWr
 dbdBo0GDzDAonAWt4Wk7XU1UO2uKjqTN7vWr62KqN0zzsiKAXuT8lN0laoTdOKzlWyKL
 U33WMb4rZ7Usa15El7rjqqYY96Cr6AIKVglMW0ughB78Dyl6qB5in6yVjRviNOp4t1hx
 u+TQ==
X-Gm-Message-State: AOJu0YwHzvAmdE599arENyoCbZ5qJCo4n42Z/0ghdgAmKWTgOkkqaUy7
 kqK2QunfYu3u2pNuKuabbHLEmZq3xmjWDuUoOYzHFMlO/pI8ex4zzQfEMn0bQy4=
X-Gm-Gg: ASbGncsVQAX+ICT/lrIkpH/3ABBBalyWHz5SJ4v1zocsmBcBVjXYXdR2B8Jjta7VvrD
 +C6aeP+DVqSV0VAir7HY5jKYP15ul4lNk3/3gkeCvnJrsB/momc+imF2Nm3AGaUg9xw7GJHyIOo
 oETW+N8a/MhRJzj9+dI4hztbCkmFw4CKf7kzV+6sj5yh/3/GWm2459fXiAMokBOe/O5P+Bs5VL1
 O12wO4VKIobwB4AIVl62b8nbttg/InTUJVP5vrgbLCSXBexO0VQIZ8=
X-Google-Smtp-Source: AGHT+IEVQsX8wrlPMgS73Y3pvurdLk+llJT2zW1uH3n4JzYgo5lxxebfSsmJEwFAq6K/zx7senVVvg==
X-Received: by 2002:a05:6402:4403:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d7ee390c89mr8579814a12.13.1734538873132; 
 Wed, 18 Dec 2024 08:21:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ae1127sm5745867a12.42.2024.12.18.08.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 75ADD5FF59;
 Wed, 18 Dec 2024 16:21:05 +0000 (GMT)
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
Subject: [PATCH v2 14/27] tests/functional: update the x86_64 tuxrun tests
Date: Wed, 18 Dec 2024 16:20:50 +0000
Message-Id: <20241218162104.3493551-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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


