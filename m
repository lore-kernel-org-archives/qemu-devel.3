Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7392E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75s-0007Rp-Gr; Tue, 10 Dec 2024 15:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75W-00078h-P5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75K-00021t-V5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:10 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434fef8203fso13800125e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863437; x=1734468237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqqTepJSvigFJNtOuIXqMUPxmyV0Odh55cVF5+vDAVM=;
 b=Wul8dip/V9GQ59JTRMDT6jhlquIFDQNIrHWRMe6fkxOMTENh4Ni7uyILMlXT9i5vs/
 XCT0rh427nP9ELK34LM5HuY+ptoMycLjt+L0KQE3vsWGToXMelGOTPR2r5b/obu1sR8O
 J6lxZdvC8gaquIo44eXFWnHucu1oqI9unTk3v8T4fE5tIqn99ekUM5EdySc3klQIkp8z
 4E+CDkLwLWG3W/vad3QhRxc73G3HxJTMh0CMkrWZMfHAUO3LOItlOjsysyDwuYgI/T4u
 VNGl/D33aRb3DIQVET8bL4RsDIaoCA8FVp/umh71V0hD47hi5yYilBCKd3sf+x8qua0H
 HJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863437; x=1734468237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqqTepJSvigFJNtOuIXqMUPxmyV0Odh55cVF5+vDAVM=;
 b=oyGOGTuslT1RFKPTywMklkxBbzA+0DFMWVxWAYcorG813+1gpmbxbwYEZSgIjAlHtw
 uKkSj47ew50IAFyEiIOmyRxj2xaKdvyvIzbUTW1YxmQUIzzkE48PObAymtqUZ3EjWY5m
 TkmfM0U4qxxqj3dcH9JbTg617FzIatdhL6OdDDaSMyp+xZz98BEWiyZEjeT77/GZ4Zcb
 qTfrZRj8hKQ2wfj70KT+sQ1idhxFdjcGldAD3RVMWxO5dEiWvOdVTOeOtp65uQAqrIfa
 2xZMqIb9YKYuYJK4dsU27anY7nj9lbOi1QDZzqBXrhxD0J3JEDGXno5/FMz8XRzGKTCS
 xsVA==
X-Gm-Message-State: AOJu0Ywj7GEF3dovAmUDApcp4tLxICOfPKa1Egmro48Cb+iZIjkeuSO+
 Xj1odZBpWM81l0XxSVTiM4A13uy94hWAlpqrrLX1oUp45GfXA1OkV38XeRc++uQ=
X-Gm-Gg: ASbGncs5mxN5lnNgd12G5z7H9dAs+zJHooSFt0FYXn8S0AoyZJBqIWf05wDEU5Ni1Lg
 32CyYiDjJbNOyobB3YAPL7ThYjSc5A9uu1nNgHYLZqv7k4N7iZYZL1Szezw28GMpHse452+rvqV
 aTYv24hTHB39quYffB0g6V9oooH8ElIgEkQ48U05l9P4JN0MQWofaXMNzjinCdSrtFhbu9YNiAq
 NBfnxkg5PZ6GRassg0rHyDrcJuSux/BQgqxYQoBBp9H3Kf4HI9I
X-Google-Smtp-Source: AGHT+IGnVSSF/rWB9BThH3vaBXB7cJsoBT4jf4svNmVdMEr47YR4MQuRCwt0q/rfvUAFGbau4KRxAA==
X-Received: by 2002:a05:600c:4fd3:b0:434:f7f0:1880 with SMTP id
 5b1f17b1804b1-4361c4425c7mr1233195e9.32.1733863437003; 
 Tue, 10 Dec 2024 12:43:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361b6d6ea0sm8644145e9.16.2024.12.10.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C1265FD0D;
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
Subject: [PATCH 08/20] tests/functional: update the ppc32 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:37 +0000
Message-Id: <20241210204349.723590-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


