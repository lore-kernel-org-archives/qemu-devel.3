Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA20D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAeZ-0001g2-NJ; Thu, 21 Nov 2024 12:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdg-0000OC-QF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdR-0001bu-Ql
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3823194a879so760858f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208788; x=1732813588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ/BEIUZxqH6xjJjY5CC1Irgebs8pwBzHUuWnbPyaKg=;
 b=EcFXxTYe7mtJp07OasdOjrHr+YS2Gu3m9P6dSHEF6BYzBAvBp0GEJxtmh/ps8JuASC
 A+E5dI2QXV0y6BIZxcrU8lrElJWmIbKu+I4o0Okc93gZOI2heOdLH13vpzIY1m6SHx8j
 4O5N5txgm8Boctmd2p57AkkmAD7S7C2rqK+If4GDD9zNi0gln6CzdS74aB2a+iIsJlpC
 BdWBzjEhp1+78CR5l5crFvUqfwBIimlsf5vWLGgRJvoWi1xVfT6pDGFt7y1lcyVUzWh0
 +ejNWXL7qM4WTfq9v+jCWNMIIqK4gczsdiVFkdQd0UfYhm6b3AsX4B4lPkqEY4RR5+Qn
 XC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208788; x=1732813588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ/BEIUZxqH6xjJjY5CC1Irgebs8pwBzHUuWnbPyaKg=;
 b=jKKAz1Q8xN2WET0RoeRvx4RVf71Uvf8kU8I/Glm0joqC2aGmT+cLm7E45XIOlgcgnq
 BT8rXCc7Lr7nitZAHsG/2+HYcO0AT0GnxR48m71uBN/G3EkzLpYshnsf3MmStZ63XZu0
 6pGJNnZDUlIknrjBdc4BSVns2w3eg4eREONA0kLdYV/ioU7Nmt6eS07EwKSIgOFpkpKj
 BpT+syXUsJSDgk7Pw8m9dR5iCzaYGmew92Io/u9a9hifUacL3NDj4oN3gWsBYM+uGBxn
 UEvWCV9kiq5RPKx68m4I2rqSPO16XjFi3rPx+aAYJacVMLrv8eiVDR/6pu/k2e24+D08
 YLKQ==
X-Gm-Message-State: AOJu0YwwN0DInGqKtB9iVZgL5dXJXsAc8zOavCiiryXdYhq1g8ew3yCl
 xViCIl+q6wSQEN6da3t4Myzb7hX5/4B41779c/2HR8vCuSC3KbWeequWOBHlMAk=
X-Gm-Gg: ASbGncuHLZ9ZA9IkVqm7B1VTRrI37tFsVrsCPT9MTxKPQRr4C/mMqMg3SZWFfRR0d22
 O4db4/fLj73OGQXWZ/w/1naiKgNFM7knB6NantR4YxD/JFHMyy4MdlfOFLIqNw4xdHi50wWPgyC
 mpTGIRanTMVMey5gzRKVbo8W3cKKrLqVd7QE32Wttp85p7HF31OFw88+tehwJO7DjCux/FA7ZeG
 7aEIw1mCLKlyHcXNpNOD8E2LykuEbk7MjmBNyzOjfR8BIdg
X-Google-Smtp-Source: AGHT+IE4EjjgwVtMMaYGhp3H4uUck59/R9PMG4XNXoKs5UjMT+KGwmfr5DSEI3LaG7Qt/qfjENhHvw==
X-Received: by 2002:a5d:5f86:0:b0:382:33b3:5f7d with SMTP id
 ffacd0b85a97d-38254afa706mr5547618f8f.27.1732208788259; 
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2679dsm49665f8f.45.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1FAF760484;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 29/39] tests/functional: update the ppc64 tuxrun tests
Date: Thu, 21 Nov 2024 16:57:56 +0000
Message-Id: <20241121165806.476008-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Now there are new upto date images available we should update to them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
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


