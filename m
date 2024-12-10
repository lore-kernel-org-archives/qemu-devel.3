Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435EDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75t-0007SO-Oh; Tue, 10 Dec 2024 15:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75X-00078p-NT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75L-00022n-T3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a736518eso67199835e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863438; x=1734468238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAm5CLLg9CbkGcsm6UEr9S48g/0qIqAr62CjoayD1as=;
 b=TIRU9b4bTCCfqvfQHCGg8QovJNQe5c8k9OWY7vKdwTQuvJcUmOIdeLuocH6Dqy4JvF
 zcFA3zv6lsz0BDPjoYufvYwt38TucZtOWD3HUoNxFDPTDqL0c2c0/eB8r6CMcUKkWy+J
 Vb0rLUNJ5D+Qb8n8AOurQswZJPj0ePkoRJQerr0l0N2UNrOzr60Yvatpjc9l7Mp3z4qy
 J5fucumrfrDcSZt0hoqmFG+RuVtfFznsgNuaS1zo7JYk7CGj5cSkA1egiVw7ZZ+ThFDz
 SePacAtnoK5cgJHcKmxZp/AznIqTYwCemzSoKqEuqyDvhRDniLoj8dqqzNXkWUVX/fr/
 Teaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863438; x=1734468238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAm5CLLg9CbkGcsm6UEr9S48g/0qIqAr62CjoayD1as=;
 b=WKa05zCGp5//KbBdNxWfAh7y9LxNgM/6857qowckjj2DTKdxHwixTK/+0Q+5qOdpOh
 wgLVAlmOEzURPJCAJaw34xUn7F0mUs9LNKPy6y2pM5S+v/3OJH/iJb8TnF94o0jzw96E
 CvdL4CMSg7tg1EFKoCUtgbCXZdF/BlSIby9RujRYuhhrwlu5wIVTtM7n/42NQftzHyrb
 yjAj3M0tey5UIigpqaYC1nE81FosKH5HiB2FYuWk9jekphk2lGGgUeqaNIlYwBY5n+0O
 AU+a/SCMmDBJ1gQeibssdtJnmQ+jj6zVjqLXlmK5pO0JQLhEAuaAYJAsPxT+6/AIyL5v
 4uiQ==
X-Gm-Message-State: AOJu0Yy5bCtkmX3pySgKwLaFDQF029sLkjT9EDa7mUp9hZDmYN3bmdEd
 o4WMTPhHqiyptds7ip36H8gO2Sz/7qHHAqUdhTEY2RLF/JcnL1KmxT3xuIyHqig=
X-Gm-Gg: ASbGnctJu2pkgP7znJ38ssKsylKEwODEnbq6q6hMMi0tFl8JOfhdBwAwU5MYiKFon1a
 J9isEsS7qLGIQoLBZqbS1mQB6Wfd2hBSVj83pzxSVJkXRWzlc59ZqpB44MbJ+6fH8tH8+4ljEmO
 3LW+BmAspqB5tW3Qt/Yzi3QTOTNoO5ZWo+hYRkfYMUUelM0+cwv5Dy6EE0sBYvHDBs88IU6j5gq
 pFh3WQ6mvK07JV36W0gM71DulCrF7QowJoqXsfZb6eNRkn3Per0
X-Google-Smtp-Source: AGHT+IEL6jMxvvzOYoe1qqTb4tJgqJEPu/6YCNky8Kp3M6zESCEEXcSSuFIQ169G3SeoAbH9WArnLw==
X-Received: by 2002:a05:600c:cc7:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-4361c43d6bfmr1480675e9.29.1733863438112; 
 Tue, 10 Dec 2024 12:43:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f43a58b1sm102975945e9.13.2024.12.10.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D34C25FC66;
 Tue, 10 Dec 2024 20:43:49 +0000 (GMT)
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
Subject: [PATCH 05/20] tests/functional: update the mips32el tuxrun tests
Date: Tue, 10 Dec 2024 20:43:34 +0000
Message-Id: <20241210204349.723590-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


