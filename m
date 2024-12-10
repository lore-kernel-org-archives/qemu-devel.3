Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8788FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75p-0007Ok-Ay; Tue, 10 Dec 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75Z-0007BH-Vf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:15 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75M-00023m-Og
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:13 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso3083534f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863439; x=1734468239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=hgs9KQ9b/5VUAQWUrzNbpBiHNEz1RkJdwTCZ0lFdG/i2zfDN3dCg+dNefU8M7EPDTh
 GhbBZcUHe8LT5pxJK4IKfZb4x7bgu24Lg4nhnAFxAsMN6jvJcY15ScFfvOHWGKBeDhUG
 DpKAGEOMhYZUEQSyw9GI50q5oqc1L6dGsvDc0dbldDtwLBSJzpH9IsZ6dsrbUYTm6iBx
 +4tzodJDBG8ssDRUwsPUgM7tjoeipsTmTG7U2vs6VZ75qONF/ac5XX6cYV3XVmqSZ9sN
 bWb3mzGkLarAnYYcsExXEb0L2A7EHBjyM1nzVjkO/wcPxmLntuv8gHvZkADLwASzicnY
 kvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863439; x=1734468239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=unhRJMwU3JNes33w/KPCY7VRthHUhDjrkY8sGcR+Aqd96NSxwItLLzz8StdNOjD6xY
 liSdkBZTKsbM0koMV/11xKIb3HA5wA42mOHzxMXoMP9eBz3ruX2IX2/wKPop3uYnzfVg
 0ithP1OyajYDb25R9tY3szznuyyEPOEm2Ny9tdVqH8wz1/QZ9gJC+w2ZYIHRkpI1+G8C
 G4hVz9fwev3MNyBbMbGoqhCW39aluWeRpe53S9LPlQiTGeHoJk12Rqeb7mglWKgw/vS5
 Yfnr3dAEnII4oMPs1zvSKV95M0G0rmuoCopuJ5OhJ3z0wvjdYRgcNBA9YDvBKvh2yfMt
 qUrA==
X-Gm-Message-State: AOJu0Yz/79hP1NnpPoSwRRz950Zpy7CoexeY4I8i/6xCKyrghtbMy7Ns
 YTGkBJUYOHVHvXcJ9JfnLflMeLOmdsaP0z941u2VZ8pTrRiVUNK/QTLc0cUy5Gk=
X-Gm-Gg: ASbGncs78djuQr8dyBiIbkuwA16D5IIpFpBKoNxU7E+kghkG6GoCnOFsw3CDB3VThWg
 I6kxDOfrdZGk4GDgOQXvnoUmE7AB/jh6FdgGaelHJQslGxs0utqv7nf7mlH/nCsDnnjXehU4lnl
 ZRAW0E7uXl7SO2cZwOASFUH3JqsYflPUVMCRxQznqKWsB22hdfttgUy6tJCBz7XGhZSk+o71Hrq
 nee7NJ2OMp91EbMsihcKGO4rTNLVsy5h7uJzWDirDznB8G5PlQq
X-Google-Smtp-Source: AGHT+IElt0Rn9EAJEbGvjf71qeMc9gX1gSoLdLn7NxdiBTc8QC0HzPZ9E+5ZA4IdKZho5DAtonkEAQ==
X-Received: by 2002:a5d:47a1:0:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-3864cea4380mr360046f8f.48.1733863439346; 
 Tue, 10 Dec 2024 12:43:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190965asm16879470f8f.82.2024.12.10.12.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80CB85FF26;
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
Subject: [PATCH 13/20] tests/functional: update the sparc64 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:42 +0000
Message-Id: <20241210204349.723590-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-34-alex.bennee@linaro.org>
---
 tests/functional/test_sparc64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/test_sparc64_tuxrun.py
index 1c2c005630..3be08d6102 100755
--- a/tests/functional/test_sparc64_tuxrun.py
+++ b/tests/functional/test_sparc64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunSparc64Test(TuxRunBaselineTest):
 
     ASSET_SPARC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/vmlinux',
-        'e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/vmlinux',
+        'a04cfb2e70a264051d161fdd93aabf4b2a9472f2e435c14ed18c5848c5fed261')
     ASSET_SPARC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/rootfs.ext4.zst',
-        'ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/rootfs.ext4.zst',
+        '479c3dc104c82b68be55e2c0c5c38cd473d0b37ad4badccde4775bb88ce34611')
 
     def test_sparc64(self):
         self.root='sda'
-- 
2.39.5


