Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E36E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwnu-0007pU-KU; Wed, 18 Dec 2024 11:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnj-0007XJ-2n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:35 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnR-0006nc-QN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so8421664a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538872; x=1735143672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=q46XlwUuWScDqN08PCYfwACUVQi8hxGPrEL/677GgZEBI8YzyJxSvj71AeIbvtR6x+
 vj6B9Bc8KzUPQvOKuPBVXGFEE+0e/ZhuM1ArZRfr7Dg/TzT+1n/r9ZLJ+SZpkRazqsAm
 ZjWcRfBVJNL7qajO71T1mNF7X53a8aPkD2L29lJ6O3blPdVprO47TNV4fgzAOWt/sZhN
 kjhKXV+rJ9WeSHArO8NajZtlk3dLpKi9vdI2BM2G9lJLLWUrG2M9dpXkFAvQxJOYSS2O
 jz4bholtQxXyDlhy6ZntkEi7ShOjPfG3b65dxHjKY9jksjFrJb09/GFRk+L0m+rVRHLY
 RK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538872; x=1735143672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQa8lE+2zCWqeETwyUKylE9fAVCRJIjj0umvCIZJA8E=;
 b=gxsXlWGWZBxtVVnXT36C8sQgCOXGJLPGIXfq9M3h1zqkkIgAqiUWkXx01gwKDB3x8z
 BCRbGOs+usuvMybTZZRROT/u12ySljVUyrFgaoasrNYCBwpQaEVzGB0yReQesRj7ALtK
 OjIY/w4M/ZqFdR+6JuP6RtgxCyEANNenaX7pNiK5+pY14Cp5uU4iN6y+L83RvPLEIaUZ
 Rg2vzZR+kMVNXnS/NSwn1d9yIj9Snk02kHuFdPoaMHVD9H4iHJr3I66MMyqA/amlpCTp
 63FH/LZT9Wd9keaYjmtL9VbeOrrW1XKr6ko9Zri7e5Ge7HTzWG4BDai1/DUuSMMq8fEt
 AJaw==
X-Gm-Message-State: AOJu0YxZTYUnt2h8mXwo5dNkLTjeaH+K4UknPsaJ807k5leYSpZOc08E
 hciC8BxyiHzD4s5SkMnxWs11t/TBHeQXSurtGJU/1rcl2594NkKKOB7jxutN6jc=
X-Gm-Gg: ASbGncvZx1ai4r1as2ICLDDbYxVmtBYTV7LU2y5RkyALC7vFom2TP5iTaAqPc/Unlpt
 k4+DyiduvztkI8ymHh9Dh8uq1+Yn6vmS1hyRJtjdquGQeA8ll+bEtc5ypKCI2xSBVq4FOSgvRpP
 YKi/t670MMEAc2Yi28x7LBd8Cy2208b9ujtFrD6ElDElh6bnMtJpJ5cefU/E8YktiwBXsQb7jq6
 k2fuxBsDvtLDrNZ3h2u+Lz64aQjNofuUeyMoH9ipvbGohU8IS92WcY=
X-Google-Smtp-Source: AGHT+IFzLeU0E2eZZTGRZdEwEGSQ3c8FYnHNzEQxMzqv4SUFsfqC54n9YHs+GIpk0bynCzNJr9U4MQ==
X-Received: by 2002:a05:6402:43cb:b0:5d6:688d:b683 with SMTP id
 4fb4d7f45d1cf-5d7ee390c65mr7054500a12.9.1734538872376; 
 Wed, 18 Dec 2024 08:21:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96006201sm569571666b.37.2024.12.18.08.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 144F45FD2F;
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
Subject: [PATCH v2 10/27] tests/functional: update the riscv32 tuxrun tests
Date: Wed, 18 Dec 2024 16:20:46 +0000
Message-Id: <20241218162104.3493551-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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


