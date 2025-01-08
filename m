Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA90E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV4q-0007AH-S5; Wed, 08 Jan 2025 07:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0h-0001Uy-PM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0f-0002QV-3L
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385df53e559so13031773f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338683; x=1736943483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb7xH3yqos9lFAi/HcOIGn+1EMSfay7/d3nkjMNZ1pk=;
 b=IEa+u33YioinDNU6VgHz7ZuD+4TA4tOTgzbBgi8S0y5JBNTIWEyMm6PECRmnJ+ALwz
 7Bk/D6f3FqDQorTwxZeK/P6fLbbHSbItv6knkQVc8+fcDtX4VvDvBsi1ellu+59r0o/9
 DdB6umbItAusNO6VklVSG9hKaEXR/d1Wp7AcLtAWjrgJ30llopFOl1oGKiVLJXSYLW7X
 io9VNP190riC02dXXY8FprMSxSEPD+G4B9Qi+WYbv3N7xkBX6Jw7a0djlnFrt46o3LUi
 oI1qb48iSeuho+0zEmgRj/PDoSsbr4orIKmTFj8xhF/rrwIYtN66GXNoVbRAwJo4Z33y
 /dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338683; x=1736943483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zb7xH3yqos9lFAi/HcOIGn+1EMSfay7/d3nkjMNZ1pk=;
 b=tKBfMsXvWPagjUJHOJ5Yo7RIREpCW9nxLnV/LRL89FcNpmTAKUx/n1dhbch5RtMyUI
 Z7RlYuJFCR82DDXqJ+MbcT7iQWO5pv8UeyufMsKdp5H+gGyTHNIoSszlN0KBXdLqPcMo
 FGutSXxieGbU7HHb7rel85nUmGxgbzeRP49KKljIeVlrbkVO4CWoDxPLMYzh7+udaFDq
 EbinZFIWUuy5vt153f6tRHIIWrdI7p7jjVPamfog1aW+oQkp1cXDYzEW1Zdkbf+ms0aj
 IAyVo1BQEzSycJ8tiLkfOfVNu3mJ0O1rB1iE+UzIES/YFHCMuYv/D8dU5vGEEFLl8KPn
 D8rA==
X-Gm-Message-State: AOJu0Yx/JaCWILeIInWkGtFOT3lC7aqubQazXEzdOTdK8hO6zNnCONK0
 rAGDor5RG3CSTuOK2aOaMbe4Fo9CKPbcPzIWWJolz18JQnPyTADYtAnQCNB4igk=
X-Gm-Gg: ASbGnctaVD8wpUWlPUaX0gxZa1FeHePhv4EXggpNasV9WIVRxHlnMUfZ55Lfrv2mPMN
 AioiU9DbH+C5KiKDa9hvi08vJTywZ2hK6qRELvlmW/gpqXtmQxCbqo/Bu8FnrUMkbYyk2nKaqv/
 JC3jf/GKCqvBlsqNG7+xzpyDdg+BvWhoZdZB8frOgteJSYZ8pV66iXyHYrp/9N5V5s2+moJTyED
 9PIpkAnMszPXEKa07Lj4j31ggHPWRGXgp/WNj/TcmxUgyhi0eEJs1E=
X-Google-Smtp-Source: AGHT+IFJaDyc9PdIvlMp1Qb/fCGUrgwK5l9RHvUq8sdZnTNPVlPw8v8AQSVFUQxNasg1nuKuQub+Tg==
X-Received: by 2002:a05:6000:4b04:b0:386:4a24:1916 with SMTP id
 ffacd0b85a97d-38a87317c6dmr1854219f8f.55.1736338683262; 
 Wed, 08 Jan 2025 04:18:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e21e1esm19018945e9.38.2025.01.08.04.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 878CA5FBC2;
 Wed,  8 Jan 2025 12:10:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 20/32] tests/functional: update tuxruntest to use
 uncompress utility
Date: Wed,  8 Jan 2025 12:10:42 +0000
Message-Id: <20250108121054.1126164-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
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

Use the utility functions to reduce code duplication.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/tuxruntest.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 7227a83757..41a4945a14 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -73,17 +73,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
         Fetch the TuxBoot assets.
         """
         kernel_image =  kernel_asset.fetch()
-        disk_image_zst = rootfs_asset.fetch()
-
-        disk_image = self.scratch_file("rootfs.ext4")
-
-        check_call(['zstd', "-f", "-d", disk_image_zst,
-                    "-o", disk_image],
-                   stdout=DEVNULL, stderr=DEVNULL)
-        # zstd copies source archive permissions for the output
-        # file, so must make this writable for QEMU
-        os.chmod(disk_image, stat.S_IRUSR | stat.S_IWUSR)
-
+        disk_image = self.uncompress(rootfs_asset)
         dtb = dtb_asset.fetch() if dtb_asset is not None else None
 
         return (kernel_image, disk_image, dtb)
-- 
2.39.5


