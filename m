Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A95E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwo2-00082P-GJ; Wed, 18 Dec 2024 11:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnm-0007Y1-W2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:35 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnT-0006p4-Hf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:34 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so10921574a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538874; x=1735143674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HRwD3Xk/RE1GAmonVu05a0HKbmwgTGs+7B2YTG5x8w=;
 b=KDNp1DY5itnPu3CcVEaYt99nGKNMm0WC8xyIrRAlhrW2BOnpcaNtIPmxPSCPgSy/Lu
 mgmFFbwI2LUTIWBG/IwSUt+J1vf6ktPCSbZ0yNk/lIIZmnGFpSbh5OVsqX0ueneYFEeF
 pmdjROZfZIPWCPKYq644daBgrM2yQux1vPU5BRui8Mnu1lduTaKez+MxTZj9FZzuX5eK
 RgEcbvRwBK04xDhgsskMJXtB90HBo9PNrAL3sG0Cy3FeO72OK68/TCVDr6oUQQ4mmic1
 Y8VkvGG5dgt1EBwlgEaRfh9hJiPShomusTmZfokd41HywoNijiQ47JqY3SmwdlNKrBpb
 PUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538874; x=1735143674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HRwD3Xk/RE1GAmonVu05a0HKbmwgTGs+7B2YTG5x8w=;
 b=Y5vc1aDMpQ83F3Nxw1dqYouSYB97fhL7genrKu6VO1+l3Y3EJXAhkkxUvxlt4WqtQm
 0J+yeO/YIObZP54u8581/HW9QrIx+1ePnMeWAhs1AmMKf8jAGZkE8sxZo/FVDS1GUhO0
 xhZMrrru6SIut1mAazKSH1MSCIChv+HPUq1gGVwzsz1PJX4rphgeZnTd5kuV0rAk3wbV
 8G1xCJrwexi+n/2cgFUmqmEDH7fK2o+8IZ3kmbM3cOVEXVpsXZKW2M+Rw357kTRty7Kg
 //rWgMqMMElE8Ic673Msak3Xb6Rlxnc6fYf3X2xOwkqc0xBiIo4Gx+shyiSMAjomoKha
 yelA==
X-Gm-Message-State: AOJu0Yz9UywguWKMYzxzMC6fgB0Xl5nH4TCsDkQ2oxkURMs8Fb70ovtO
 B9QpVwOD/qL8dXeIi2291+aWKbqpuvIUV5CPl6TkKfcxSwWNLaHyMzO8Kbpxk8E=
X-Gm-Gg: ASbGncuYGgqqQmz/oc/ywpxYsOUyGqTx82J5/zqNSA/dI+mgYUScoLhs6eTTpK/xknH
 U+Ckmb9tcjRPcfMGAiNLhfDNp468CKo+yTnwBEZRT1fvoe7t/iCcqB4P/9PYMxpwvrsyBjfrCXF
 I0QGuF0v+/4e8arj2rjK1zUnuuQZU7uTfx9Jj0PLFTgZczTRb98ognozelUkPuBywaalOoiTMQj
 NGT3+LWaUnHJZ90yWX7Y2nOCs4GyRjwbK4mmntwmKsEnq1fApkcTa0=
X-Google-Smtp-Source: AGHT+IEh+95lUxRrjAwbeRZF/j46rVTO0+jZqOHm2oFmxVKTZoYoHvy0WibwIuzW7SZgUJPoOgaBDA==
X-Received: by 2002:a05:6402:5418:b0:5d3:c4a8:d259 with SMTP id
 4fb4d7f45d1cf-5d7ee3cc788mr3062655a12.19.1734538873709; 
 Wed, 18 Dec 2024 08:21:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ad15bfsm5627948a12.19.2024.12.18.08.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C61D5FD7E;
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
Subject: [PATCH v2 11/27] tests/functional: update the riscv64 tuxrun tests
Date: Wed, 18 Dec 2024 16:20:47 +0000
Message-Id: <20241218162104.3493551-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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
Note we re-use the riscv32 kernel and rootfs for test_riscv64_rv32.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-32-alex.bennee@linaro.org>
---
 tests/functional/test_riscv64_tuxrun.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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


