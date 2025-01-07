Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B29E7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCpE-0004bF-PA; Tue, 07 Jan 2025 11:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCp5-0004S1-Nu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoT-0005rl-9X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so27754595e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268735; x=1736873535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FzFnlzkuRqAIG729x/b7511sIkBqkjnI6qfjXVG1TA=;
 b=cTx3uJhhkaW8pNdz5T4l8M9GyL7H9zpgufwj4mtjDMXpRga4E6G4BWuciGlloaW0Zt
 kPnlM0pCY+qSMI/dx2OxARytwkIqYmxWP2vNk/zP7MiCeZYEbYBmhD7mdHcNIML7ay6X
 lRCSvC1tyZpO0KrrDjiC1Y3JnajJkvXwy2F2gwUA5XAoKm6kGTpDY39D44Q7POFsxxvl
 Y7HxWHGeVbZD0FUA+BOnRhxrgQSLZxhBhODHhSj58IZUstdLtP6ShYOtRjzLo6Iks7wx
 rmYv1ITjknFayPgcPHUtyb0OzBnnpB6jOIKtCa16f9dboU5/nuVjlYzwtoIDWHdxwzaf
 5ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268735; x=1736873535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FzFnlzkuRqAIG729x/b7511sIkBqkjnI6qfjXVG1TA=;
 b=kJAExlF+/ixT2swqSI+RPaugbLoEpI01jdJFSBXk274UkfJeydTlz+SNE22JDbbX+y
 S6qfwSM3DUuZMNmDWb3+vS3u/3fXBh0S/VlgNRqluxJ6VF1xs1ygVpP4i0TMbbkLbxfX
 rk5p2huSReT9uLwT8EfkkBOTUnEPSGnHYqDrN7nfz8UwqgYxjUYBgAteiWqyFyaxMDOT
 YU/A3i6vA4nraiEfbfM7h9Kyvkb+Pl2iqIttWkNjQoJHQnlTVEzXvJyMSNfUvLKZ2pS2
 ZexumDwWAyBnlU8mTeAFt0UBhvg+6T7bezk3X0lhpQYw6YrJZpw43xHYMiQQC/3W417P
 g/mg==
X-Gm-Message-State: AOJu0Yws08iu8e345v+taLMxa7WVBtLAckhXurhsLcZU5VzJB7r7rm/u
 nL4KNx7+a6IabYVePe0bk2zz36hT7W/ctMKyj/5uJJcFgSfsEYOjVwm7GsU5rJc=
X-Gm-Gg: ASbGncsgTus52lkFE9H4+XyrBlhMvqBdFjJ8CufGFzBVBvgodEiSWvkCaJc0L6+aUND
 IVueWyzIbDK/Jw7BE3oCNbN+j5dduhUNjT1DBk63jyCaYLrt1FztU0BSSyCEjemHFZf5k9ZOVnT
 PrvLk+E1RCaRj3B8k0fBAT5md5QK17JiphgzloZRxQaojPg/Hd70wy9pEZx1c7EsWGZgv5XGBJG
 VR4DSI4GoxfNge4mGfSiPYZIyp4S4kha6KTHuqDjsqFfP+2c3pv6lg=
X-Google-Smtp-Source: AGHT+IHr8FvuMDxn27uTX6Ray6vggcKJfli2Aqj65zcld+gPiFlnDckk5RO1WtN/ECLelse9kkybIg==
X-Received: by 2002:a5d:64e2:0:b0:385:f979:7664 with SMTP id
 ffacd0b85a97d-38a2240019bmr55034696f8f.58.1736268734730; 
 Tue, 07 Jan 2025 08:52:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474c2sm50198301f8f.55.2025.01.07.08.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9605D5F935;
 Tue,  7 Jan 2025 16:52:08 +0000 (GMT)
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
Subject: [PATCH v3 06/29] tests/functional: update the mips64 tuxrun tests
Date: Tue,  7 Jan 2025 16:51:44 +0000
Message-Id: <20250107165208.743958-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
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
Message-Id: <20241121165806.476008-27-alex.bennee@linaro.org>
---
 tests/functional/test_mips64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/test_mips64_tuxrun.py
index 54af1ae794..0e4c65961d 100755
--- a/tests/functional/test_mips64_tuxrun.py
+++ b/tests/functional/test_mips64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64Test(TuxRunBaselineTest):
 
     ASSET_MIPS64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/vmlinux',
-        '09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/vmlinux',
+        'fe2882d216898ba2c56b49ba59f46ad392f36871f7fe325373cd926848b9dbdc')
     ASSET_MIPS64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/rootfs.ext4.zst',
-        '69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/rootfs.ext4.zst',
+        'b8c98400216b6d4fb3b3ff05e9929aa015948b596cf0b82234813c84a4f7f4d5')
 
     def test_mips64(self):
         self.set_machine('malta')
-- 
2.39.5


