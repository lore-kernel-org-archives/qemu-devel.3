Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110FEE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75r-0007Qz-Dd; Tue, 10 Dec 2024 15:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75U-000770-Vf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75K-00021k-6Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so26180585e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863436; x=1734468236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gnnOboOf/0hyHRkIZm1r+Edttpq+V6vfS59OPkMcZA=;
 b=fq+MvMSKkYg/GQwoLTPY+l72J2muUtlY4Zjb8ev2rVNMO7cwMPqtJ95SpuUpR2A5fb
 UhZbhsq4lvrCnO/FnckV5esBPIbtBvrc2fgDWlix6l59pnp2zi3EJ2YgO4iQzaUOoaIz
 zOmAth2NjIW4OYaXMVinHshYEPLPhElA2vj9C1723VgCxtJcVZiykNyKtT2KJzw4Epye
 sVZ0ShTvvtEfKdMjgf+CZts2y92S6majk9z509q6ZhcIx1kmeO8FUYoVtq770//Ahns7
 GhI8QcRcdWJllcPTsPMURCG3bb5dvqUmmAE2nEtomhcP3qSASUVLl5LQKMgM+PEGhq50
 pnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863436; x=1734468236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gnnOboOf/0hyHRkIZm1r+Edttpq+V6vfS59OPkMcZA=;
 b=YtFcMoTSM64ISDUtSMJTl6Je/9SYWtArk2hUyvXdyV2NWVxAEuU6D+AqLuShdCGbBF
 4RHE8j1obPD/oCcsesS0o7aCjwh5sHLA6npdGh6UR5xzaJxKDv8KMHk7KK0L0TCXTjQn
 rh8JYM9FCBXqj9kPjjstp8SZg8L6Ecn0nY264c+4fTySVRF+F7zsJLmownzB2CnGqBZP
 sXNJCQGbblkwnUsdA44KrwkuAKG2pWaYmx069cGP9TlclLTdhcyY79rhowJxqZRSb5s1
 r6xZBeu4R2YgkXXkvFBC5ftyDjUxBRF7QMoe38lSHMaHr8ZTvh9ISGFjdnIDx6I4qT6w
 s/fg==
X-Gm-Message-State: AOJu0YwTfFWDJ0ohmuxIajHOIgyAcBlGMw6P6/zJZaU5ZfX+wZAbw173
 vzWpFKjn/jPGcV7jsK+rBWukk2qU+Nq0g4mYZU2TyXSb8q8am2kcuD9NhfL+Vp8=
X-Gm-Gg: ASbGncvmZyPkm6mD/x3COk5CaiLJSWknzmuSl5Z+nLd10I5LguzcwpzV7LmW/BNS4GQ
 dnYc/AhBl4G+AVI0S9r3t4tVT6HCdldJWZoUQSC7NJ10spTe3+Frh7BYD8TJSbsHcmCrNToCzSf
 EcaxgA3DMR71VxeXD+NsmvVjwHQo1TbB2YyYU5paZ3wMgEcFwsdUr1rV/SFe+DNGRpYhsGWfdrL
 O1oUWRv0KhRNsYLryUTNI9KAfLLf73tQVE0BEAJpCZDNxbLob1+
X-Google-Smtp-Source: AGHT+IHcmWRNzTkqVVmlp7vI55c1y4kSQH0oB2l8XAs3h6e4W511DGLsZgs0xBzEhciVb/iL3jD6gA==
X-Received: by 2002:a05:600c:350c:b0:434:a4a6:51f8 with SMTP id
 5b1f17b1804b1-4361c2bbb02mr2583845e9.0.1733863436538; 
 Tue, 10 Dec 2024 12:43:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3863dd5d09fsm7299689f8f.83.2024.12.10.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 309925FD22;
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
Subject: [PATCH 09/20] tests/functional: update the ppc64 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:38 +0000
Message-Id: <20241210204349.723590-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-Id: <20241121165806.476008-30-alex.bennee@linaro.org>
---
 tests/functional/test_ppc64_tuxrun.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 03b47e07f2..aee67f5e90 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -82,11 +82,11 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
                                drive="scsi-hd")
 
     ASSET_PPC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64/vmlinux',
-        'f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64/vmlinux',
+        '8219d5cb26e7654ad7826fe8aee6290f7c01eef44f2cd6d26c15fe8f99e1c17c')
     ASSET_PPC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64/rootfs.ext4.zst',
-        '1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64/rootfs.ext4.zst',
+        'b68e12314303c5dd0fef37ae98021299a206085ae591893e73557af99a02d373')
 
     def test_ppc64(self):
         self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64_KERNEL,
@@ -94,11 +94,11 @@ def test_ppc64(self):
                                  prefix='tuxrun_ppc64_')
 
     ASSET_PPC64LE_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64le/vmlinux',
-        '979eb61b445a010fb13e2b927126991f8ceef9c590fa2be0996c00e293e80cf2')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64le/vmlinux',
+        '21aea1fbc18bf6fa7d8ca4ea48d4940b2c8363c077acd564eb47d769b7495279')
     ASSET_PPC64LE_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/ppc64le/rootfs.ext4.zst',
-        'b442678c93fb8abe1f7d3bfa20556488de6b475c22c8fed363f42cf81a0a3906')
+        'https://storage.tuxboot.com/buildroot/20241119/ppc64le/rootfs.ext4.zst',
+        '67d36a3f9597b738e8b7359bdf04500f4d9bb82fc35eaa65aa439d888b2392f4')
 
     def test_ppc64le(self):
         self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64LE_KERNEL,
-- 
2.39.5


