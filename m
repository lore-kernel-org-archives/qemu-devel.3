Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C24E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu2-0004m0-2a; Fri, 10 Jan 2025 08:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtp-0004eB-BV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtn-0004ij-7o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385df53e559so1626384f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515081; x=1737119881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nww2x/16ova9wOscWNN7dGV8zOcHjOMR1T1dgwUW7Zs=;
 b=xX6J+WQK/2iBiRfxhIhlrSEEp4eBZf4oysuxP/NpidFIFYKJuCMTd9PjC9xIrYAdwb
 tb8d/OU4k1H9PzBtXlIgNo5iPZ4vGTEHkMuCqam+xv0xs4xnORBRBq4g0EIjAsQBwHP7
 Lc6D0/ivn5IBmituflTQ07mN3PnUtTHCZfyAcwGdJ4Jpa5KhOxefy9jdmZMz4yNjzIYc
 FwisgXG+KoGhtKbTnnu3fHkwnpFvWn5OnSX7Um64NovRIReBhu1qzrIdvtjXwQVlC0X6
 tMilgAlIFNUJJtW3qkTzD758DJF06j6WIvFpeddPhYVomLS6RAWTcBI4zasqW1XFWFrd
 ihRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515081; x=1737119881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nww2x/16ova9wOscWNN7dGV8zOcHjOMR1T1dgwUW7Zs=;
 b=dBwF8qLuj7x3fLQpvH3usZk86qJ3DIveAx7sgG/khxWC7aqh4FWj18FIah9TbZsFo/
 lLUafsr8CSn+e0SysTK0Z4eMJPl42ujzumWgu0Fo4c0cb8K4Mbmrxd9TA9sQQn1LA3nZ
 t6oA7kXUZlyxunJFTIQf0S1eqthpWojiJyQ564OYOqlMg5AiEHdUIF9RmHVTZgrs4tpi
 QAH/fdiZGbKG+Uwz0ZZFXBN4nxv2hRBeVnwwOMCn2CoDNGV7YoLt5rDX6qbPljA1SldL
 0Dtfd8Fq2TuRwcKE5ykjOE1qd+orkRpu53g12xWHnOJBfnh7a575bXusrwnzOJgqSG5x
 6tLQ==
X-Gm-Message-State: AOJu0Yx9rXf/dkUwVFFQkwZXEbibEjdcrCZXI0JKiVs2MgWK4oMgf62F
 xgVH69iSAjUTTg1UNKjod7hrZWJV+khEo6iEcJ66TA5oVmLa03AShJLG5k5YjHo=
X-Gm-Gg: ASbGnctfb0c5jlux+IYQC4ySPO9bLvNynqSdeifhFAwIruYH/68ygyoni4y4W44sDZW
 C5K/fgxPU7hpPpSXjsq9tqPOY59PByX+7YBwQR2gs6FpQMvsn1ZzvKzBWMjE3gm3/i3EaP826eo
 bwxkg+Pdcgmsf2KLQj6kQH48FRk9nSeKj95748KlozsiE92uVnvRwtGUD+BBEZbaZtpJFlKMYxo
 ACxYbadlE1rUBdvGytISkgu1lrlCeZDAvIkJ6WYvlbAKJhJj34QpS0=
X-Google-Smtp-Source: AGHT+IGZkTjA4JjmqTdD0RlZhXtylIocfA2IuJiQ2ENMx3k3u0LnbwBrBcuOOf0sjH6p0hnOsqm35w==
X-Received: by 2002:a5d:5847:0:b0:386:407c:40b9 with SMTP id
 ffacd0b85a97d-38a872eb4b9mr9990738f8f.28.1736515081414; 
 Fri, 10 Jan 2025 05:18:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dd1cc3sm51648125e9.14.2025.01.10.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08DFE5FEF9;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 10/32] tests/functional: update the riscv32 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:32 +0000
Message-Id: <20250110131754.2769814-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Message-Id: <20250108121054.1126164-11-alex.bennee@linaro.org>

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


