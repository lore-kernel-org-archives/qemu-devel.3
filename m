Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EE1E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEuB-0004rY-LD; Fri, 10 Jan 2025 08:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtp-0004eF-MZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtn-0004j4-PU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436202dd730so15170075e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515082; x=1737119882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gnAsVuaYD+iYbCg1dbnY623A4xZ5emqKXVcVqjxUvo=;
 b=sQwbaT9DVN/tFy17XxnepEDfw9POl+xBUaTW8KEwmq/ci9mzb0vIuI1Gxfm85fopaN
 rWHfqs/ApZrQUEzfyyDHlYAJaO6ieLFN0yQDL8UKTd4thlSHMDE5OEBjGqlSCIjWZCXR
 YRyBYQ7jQvI3gZLxIoZpht3YpTlkWcTJGawxwFdumkuMMGrdaE/+ak17lru5gLKlvOIs
 Xv8ChkdZIqBrlPxnrdYqOJ5L2acB+ZWM3alY8Ws1ZD3IsRulSvFJPSDu7GtkKLOwu5Vf
 Nj4kIJvlThttsYl5zTL4bvHqtojye3o5ZsRknMvwRlVzHOnHIxHaFlxQrzHBMcXUgtgt
 n/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515082; x=1737119882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gnAsVuaYD+iYbCg1dbnY623A4xZ5emqKXVcVqjxUvo=;
 b=ttjxIP04+paEMRFvU6qc8Ff2yA3yX4ap0f8bbL7o85mB0bljC1aC+425S6hdhXDmsz
 xdGvzvnnxT+sjfTvciAd4EilLqWpPTcbTDMSRddZ0luID+sWtqEYsM+MfUACWjGXo49q
 m3x+b9Hw4ptOK+6/e4Grul//Cc9TVQh8yE0HhyDJUA7or8i59xKeXRyQH9cGYR/qqPDr
 gwmeiZomsRn3mvGg2NF3J9Ii7XeRs9neG7R9qExKE42o8qOXpUkHhVM2aq0lmjulTSrT
 6jEC/7LrFpQkRwSr4VLZxTHp0bUon8XNB/xUn+r9/Um2pwfwpti8UN9EiXvbFsUm+osc
 6SNw==
X-Gm-Message-State: AOJu0Yxa7pxr3/8PW8wpQS3pkQvO/4FeiFI7XW4v5/Ffc4rwzpYvQRH+
 ZAgJ2jDZ0yZ82CEZd+nv1KVhWe1YfBFWyXDgv0MWiT3E/IlllTwI9eMX26jbeF/zqH2I/ZSXbbj
 wBuU=
X-Gm-Gg: ASbGncsBjLjeyjzeC6kvEleZx6g8U1lIxZFS8v0fA1ip5qMkoF5jBrGul7QGVOmxcvU
 pOOEcd8KDdtwC4X6mvTeGQS5DBLtKcJT2Wv44qEAOaDMGAx5SC5SHIEQoCbIf6WIF0WO63RGcto
 Joyzzla+gxBFZfZEopwaDECN7ANBXMsalsqrnn96s71PsCdiFMDZQOMDv5oxtKC+NQXbbLh97bY
 bmlJhsVQLoEXPOlNLcxeuDtcZIpuDWz5TcXtMQC6MCHfemugcsUBn8=
X-Google-Smtp-Source: AGHT+IGTJNkcBuCzNh1ACToW0T5PlsBO9MZ1abCEMdvWIOSSkzW9wu7l2KbGk3SH9G8SyxsahT0g/w==
X-Received: by 2002:a05:600c:1386:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-436e26aeb43mr106184455e9.12.1736515081959; 
 Fri, 10 Jan 2025 05:18:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d3bsm51784935e9.31.2025.01.10.05.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B43660030;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 11/32] tests/functional: update the riscv64 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:33 +0000
Message-Id: <20250110131754.2769814-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
Message-Id: <20250108121054.1126164-12-alex.bennee@linaro.org>

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


