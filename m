Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907B0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75o-0007Nu-AR; Tue, 10 Dec 2024 15:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75S-00074o-Fc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75I-00020S-O7
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862d161947so2934014f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863435; x=1734468235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=QvQroJ6N7oGTL9Xpv5Hg96lWMsoz0+vowWu4KdhsM4tGHXOMXHRMV+zHCC9agshUJ8
 eyPYIw4kj6xrRBUBQwte2v9iZKM4CeU9YO2M5vnid8UTI7sACY6bvTdq0EhRA9oc0Z3D
 JV+4uOT8R85m7TmBoHsIxAQWB0Gda6xkWEbyftHcLjL54lIl5li+TAv7rpywlUuxvhuL
 +FfoTQR2X+jHxNkH1lSruFsMFNUq+HCevY9VQkSKnRhmc0AvCXudXiWMc3JUXTGDYEBL
 jCgyexxSBIgnC0TK6mU7T+wcWkk/K7PDMJMaa1eYivfYMSfY3ajDRlXndEWHHZnrJtcf
 GMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863435; x=1734468235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=s7PoMTgBNpBm+DucRjScfiqqFUD2GwM/vQRaIeoQsB/83MfiWu/9Cf7b9Ocw0cJ/VD
 0K1XfuFQ80j4GdqETlXZ/UHIQMwQCsoE+V1fldajHxl5tG6qAzX9QMkQfDivbaZlmIHP
 anV1OPi0G3AKd0O55P6pH3ViVW3pNLp3w+NkLVh57FOkQJ4Pyd5zAg/THeienOwG7AMO
 T49o81bMhGMkJLs3nqXiHZbxd6Sc11l+y4hDJOAEwko7Tw7t20i1/yloT0PzJ8Ssp0ZZ
 vwUoiWBkgwk8fd8j1C+wkbF2FVdYWUMu14N9dNc+3D9JVR0E7dWoCk+CGU0Yv3oIPMi2
 hIHQ==
X-Gm-Message-State: AOJu0YyNcS1srA9/s+aJKHYK8YDDDGfG50yk+iAbB4EITahsgMOQ4mGG
 1MloMX89VFE/gvnaLIjO6HpzpZElUy13dMa665xg2jRH1yok7JBomPINLQIiIvs=
X-Gm-Gg: ASbGncu01O5jhtH1waVWWN23YNAomNKets1/6gCLTh074LU3YqPtXQ4GnwFoMvd8sVM
 VOC7Tp47hr0CiItCtogayszm8gSp8UUj4FKJ+xSJ6bODrsNijE7FjAu8fu7ztP+S0ktG/xOirdF
 VeAbiIo4MNy9BuXeRUMHEDJqkNBwSOV8bUr0crrBa8A8O6CSnmtvRjllctMbQ1tg86mQJ2C6UlY
 AkUC7mjowAVWZqqyGc+nYOK4cvxhcZ72oFVIA43he3YoBkAG5k1
X-Google-Smtp-Source: AGHT+IELup0DkqbwWAfx5Wrg+LModdBAQX/HYN40KMOjTNWi2OqrgOg1NF36ZqsCmAHuV7yeDvpyuA==
X-Received: by 2002:a05:6000:1445:b0:386:4a24:1914 with SMTP id
 ffacd0b85a97d-3864cea3a2bmr387389f8f.37.1733863434885; 
 Tue, 10 Dec 2024 12:43:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38637072adasm11021748f8f.81.2024.12.10.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 44DE15FD45;
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
Subject: [PATCH 10/20] tests/functional: update the riscv32 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:39 +0000
Message-Id: <20241210204349.723590-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


