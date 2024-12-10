Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45345E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75p-0007Oi-7I; Tue, 10 Dec 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75T-00075S-M0
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75I-00020o-Pm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:07 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2569559f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863435; x=1734468235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=DZo2R3AiX2zuOs7SEzcX00H/VZKr6K2Nc7IH67jPi3LJirhXadWPFqPlv7vEo86ZcZ
 Vx1GG8Ov+3UB511qXrgvE+M1Fgc2Zqkae4Zr3/ev0/28RtH3PyFoUYEz7eazMMEb36kU
 uLG4VJ8ydcJuaTYXC/ALhLHiKJ3YRChbqTORcnZVRQ4/MwKxYRszFVsffpU4qp8dtCPh
 VRKp4k5UB8dOO1xGTMoqfBGXCLG/pHYZvD2xlldyRTqEA0t2lx3y3uAMJwlLcxkhr1ss
 opppSwmboO3Wj4gbQopnNynAN+Wl/GKGXKObwTaqJugCDt8huozRxTcafUMGpQbU++Ul
 UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863435; x=1734468235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEl5ZxIur5QRWg63f27lDW4UGnFwRWpUXbJtYvdKy8I=;
 b=AZAUgg9pf/iyNz1fIzS6hRfbtfryPbnKiODGv3qHX6zrmngykBJ8XyEW9HA1QlB131
 E0gxFFqLfHUc7SAgR9NeQ7FYvoEVLPIVKUK1phhSTeFznaJfihlTQwttTepj4wldg/qG
 Eubo+mfiVRuhlySHej+vHIUMcBvT72xdqK6IZgsjTBH3Wz1aoyWsVfIUlo1qsjDbVgy0
 9z8k8cfIr6f0nJyXU7JAPCsYqzW4OfeaEt+Wlfv78qtlRaRqSFtSQ/fHAw6QydNN68HX
 uC+mGEn2DI0Rf9/G61tqu961htW5M5jItjMm942o/3cN6YLiYUMd5WPAv4K2BgEwr13T
 ugdA==
X-Gm-Message-State: AOJu0YxguLwyZBDozHYkhp72oe9Sx2LyOZVv5C27ZgXdt/auGn4sdvwT
 5dbpPVemtapl2ofCMUmaUcKyyw08FIAR5VvQS0Ls+NWe6xxv3Q/zH9heTqSCzXk=
X-Gm-Gg: ASbGncuEhHhUJsqmiItwxsDiA9Wvv0cNy2Rl3/rlJbkY2sYdUOqZW/TNZh/5KHTUgTn
 fEtj7ku2afxRbGI09GpNvcUrslYIA9uW7p/v6182euJoo698xfzO6Q/zxVgrvWLAioQ1AJ29XQw
 WtF0PNp8nJCvnQAKiG5cbhQBSk0MYR0geLQCkblZcapjydPK0JyaSAkENOXG+9yKe2kNn5Btm65
 kBmR/yc6faT0vqWI/9HcXjWxjRzedHC7qc+CKAIgFqNGK3/x7Nr
X-Google-Smtp-Source: AGHT+IEBHhpLlOFQFbhq8X1TdDZ3+EwLyNxVW+ftlgnHPRmOGFVvkDULP1UX9X1fOMA85iXBf+BmUQ==
X-Received: by 2002:a5d:6487:0:b0:385:f349:ffef with SMTP id
 ffacd0b85a97d-3864ce93b84mr394132f8f.41.1733863435197; 
 Tue, 10 Dec 2024 12:43:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf3efasm16623919f8f.17.2024.12.10.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 077C05FCD8;
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
Subject: [PATCH 07/20] tests/functional: update the mips64el tuxrun tests
Date: Tue, 10 Dec 2024 20:43:36 +0000
Message-Id: <20241210204349.723590-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
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
Message-Id: <20241121165806.476008-28-alex.bennee@linaro.org>
---
 tests/functional/test_mips64el_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/test_mips64el_tuxrun.py
index 819549a27b..0a24757c51 100755
--- a/tests/functional/test_mips64el_tuxrun.py
+++ b/tests/functional/test_mips64el_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64ELTest(TuxRunBaselineTest):
 
     ASSET_MIPS64EL_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/vmlinux',
-        'd4e08965e2155c4cccce7c5f34d18fe34c636cda2f2c9844387d614950155266')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/vmlinux',
+        '0d2829a96f005229839c4cd586d4d8a136ea4b488d29821611c8e97f2266bfa9')
     ASSET_MIPS64EL_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64el/rootfs.ext4.zst',
-        'fba585368f5915b1498ed081863474b2d7ec4e97cdd46d21bdcb2f9698f83de4')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64el/rootfs.ext4.zst',
+        '69c8b69a4f1582ce4c6f01a994968f5d73bffb2fc99cbeeeb26c8b5a28eaeb84')
 
     def test_mips64el(self):
         self.set_machine('malta')
-- 
2.39.5


