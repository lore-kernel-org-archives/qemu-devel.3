Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE131E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCp2-0004PP-Te; Tue, 07 Jan 2025 11:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCp1-0004MJ-Aq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoS-0005rX-WC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:52:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so178797155e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268735; x=1736873535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=xKMp93gEVruUadhTZftwuS1KhNk9z2b3Vh9Z9czFOwmYLranALWCioOkXoKw5iVdcs
 ybH9Zrj3N96z5/l09PVFDzoe8S5Fhj8YAdPNNrJ3BMT8XfE70DJ/wtl+1LSRDef7zUPv
 KWfrhjO3gbYvDVK4U29d/oCXprWPnjMcXeEYeEDk/afbhaIOHgR23cInu7Q1NMwdQHCX
 CJx0k4j1YkjpEd1CpwVMFK5+TNlkjMdfSOC5Jl7zSaqzkRSkZrmd4WghED61WgEL0AAM
 01kr7gWhNFFUqF2J5iak0pAXFbhO7ldOYq2Hcbg/7X0z244EI7Y3j+oJOfGBWJvIjSJs
 wCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268735; x=1736873535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=dPM0wP+ll9CzT1Ff20IdOQXqRQaBONF8O2Mw8xokQvm3bq8x1C/hiFi+1Y3+tcaSDb
 cSpclkQFSrAWpnUHpILPvZGdwZ8VHnL4Nkw/IrPZLHjtOQ6SHXUj+sSaVoYWpjoLKN50
 AqGt/QaPpv7qtspuo8e/02QLwaxuPSwTGCocMa+EOBY2p0ctef8rRYJfgy4yRsKIwJ3+
 Kzb6zMwiQoooiFkLJ+5uDoo8faBp91Sk4DVOdkGA9wIOuCpOxMK/DVbTArI2lUoNLvk6
 dBq5XYQrlr3IU3awtdq31SmBtuXqUmy+eBX04gBk0ZB3sF7rF3eBXIDoY6BEmPOiIJ7y
 OU/g==
X-Gm-Message-State: AOJu0YxiP7S+SWkeUMwHjKcuwQtDHi89CdRuL4+ITyNEXSoBA5Bh0lzf
 0tdulzJx5g9tHN1STAN9eW+teTvrEafchgjgAv+SVfRSMd+fLzCLq+GQ2dpa6rY=
X-Gm-Gg: ASbGncsC2YI1YU/I8oshHos55okHocmedKd5bl4xyQn4Cw3qtbqWFwbLqfR0/Ly9bhv
 kUclbh0AxqwmFgBbzUQ36l7iDoZAhxQQqyvLRpoEAzQ+VK1MBFqe4eROsvhYO5m/hQL2METQJUj
 zCdXXuc8F7PdeN6qnAWtD2IusgYuWj3F2cIBGO+yst1cru5+yyppNpfCoZBpo8vSXNVYPwzRBFF
 8sz6Hpw3GsvmqIn7h3cbbml83mK45lw54NW2GAQPXPv0bN45UORq7I=
X-Google-Smtp-Source: AGHT+IGJaMVN357lzD+88ol6Cqialy1zG6i3hgUTu42T6mKwSA+1SdTSP+i/ovxXPWbAC4GdSUKqgQ==
X-Received: by 2002:a05:600c:a0a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-43668b93ca2mr556772955e9.30.1736268735426; 
 Tue, 07 Jan 2025 08:52:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm51517269f8f.84.2025.01.07.08.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFA365F9EC;
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
Subject: [PATCH v3 10/29] tests/functional: update the riscv32 tuxrun tests
Date: Tue,  7 Jan 2025 16:51:48 +0000
Message-Id: <20250107165208.743958-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Message-Id: <20241121165806.476008-31-alex.bennee@linaro.org>
---
 tests/functional/test_riscv32_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/test_riscv32_tuxrun.py
index 49b57cd428..3c570208d0 100755
--- a/tests/functional/test_riscv32_tuxrun.py
+++ b/tests/functional/test_riscv32_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunRiscV32Test(TuxRunBaselineTest):
 
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
 
     def test_riscv32(self):
         self.set_machine('virt')
-- 
2.39.5


