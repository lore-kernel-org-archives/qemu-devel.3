Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB809CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54g-0006Mx-TH; Thu, 04 Sep 2025 04:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54a-0006GC-8n
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:12:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54J-00041e-O4
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61cb4374d2fso1072226a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973501; x=1757578301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j1jG2MY/WGcH+crz7CtyaM5tw55oKFFqSyUb2OGtbM=;
 b=xNT+gtAKGeol2h2GXBI9/QpScgbWnH/9lYAyf+ydexCHyJR3MbG6diaU1f4RciO8i3
 J/+j5W9wYbqQvWrjCoDcHJqpvZPD0GcTDdv0kRK0WMjAvFUPR6PMm4p3df1Z+G9n7Lpg
 GAWIXEsoQTLL5qFU68EUiRf8yDlPBYYSF6AwIecc3Vai9YtQjXnIESEVREzinjxeaZq8
 nXqqaeLLmrkBHC3ufD6qGwmZYmdRetEhVicmqw5UpaNMDp3BLiL7mk9X952FgozqcShp
 2aFk6nMDm2h8l4C+O7RBouylyPQBeujvUEt50j5P8RZMxB/Gqs9IP+2B9KGcLO8fLjw5
 e5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973501; x=1757578301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3j1jG2MY/WGcH+crz7CtyaM5tw55oKFFqSyUb2OGtbM=;
 b=XmQ8aKLpPYwMii9Nn56b2dcwW3xhDPDFVhG+Sn7mYTDcjt3eqy+hVeuR+OjVAISEsh
 2Z4T++yZ0FSGx0Y4ugEJmBbsVGRcKzai2E58eneNCT96UDJR0d9JXmLL5u128FbrFdeC
 SfZv1GyEDpIhVHkTg2W5Kc+lyyo4FKj7UUgkC2mxVEJXSNjxxGTM0E1pIgeuhqTrDzcb
 cWhQSy2IFBYj49mC95WeIq05ovuQTuD8C3ylwl8aAHwYA9Hi3a/zNCXGyP/BxUBXBdJa
 f5+m4GqePRJQ3kpW69QpNY5ywKnZRbYnCTKT3/xmDeZGoKZ6h+boLN1Lcf1i0QwU9tYh
 2cXQ==
X-Gm-Message-State: AOJu0YxODD4XGRh0VB2R5To9jo0mMJfTkPoJ57fwF+8F5xrMRXI7tQJQ
 Oljp7l71yLwwLDCjZk9OF3b2y/A/fMP/wUjyjuPER2loRyOy/2ngjqFjys10vRm+mtU=
X-Gm-Gg: ASbGncv1eWLWiTVtIGWrQEVGojNI5ADgSOp7EEdJWjOQOFsnUjFpRsrUtcrFgRPtmQJ
 xpQLN6v3O6XRwAvroZJXg6zrbMP0Ycm4vP1s1alKYQjHa3ryHPpXNwrGt9zQrkLnQFklL/LvReJ
 3ZISD3Oo8hHjQJqIRPuDpyoiZHEuYoLb0O5wlJY1T3DMYq78qi4Q6RgftUd0oS7mZRptZy/0kYg
 taIv1UoaQoKsHnWCGx6ZWHamdjEFjpplIYozYciSVJcTgqhwJCjMDu3vhVDVAaDeNf3l6lXAhwf
 +2LuSmnnfOMIRWNAkDvxJ3rhNFpovJ8YA6A4WZv/kQ5nOGZuT1NfKUqY0gxRpMjibBctbjQNp0n
 dHqaqNYkLWhKSyF/FT26Zz0RlH9U9PjxJ0A==
X-Google-Smtp-Source: AGHT+IHtaOAptd/dOyrxka90iG+Ickwt+7m6mDEjwCXtB/2x+x0WNk1ZvG1BgsoUzoIQQ2o03oW8Ow==
X-Received: by 2002:a17:906:4789:b0:b04:1a1c:cb5b with SMTP id
 a640c23a62f3a-b041a1ccc38mr1426344866b.7.1756973501036; 
 Thu, 04 Sep 2025 01:11:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b03ab857474sm1225662366b.89.2025.09.04.01.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71DFF5F9F7;
 Thu, 04 Sep 2025 09:11:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 011/281] tests/functional: Fix reverse_debugging asset
 precaching
Date: Thu,  4 Sep 2025 09:06:45 +0100
Message-ID: <20250904081128.1942269-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit fixes the asset precaching in the reverse_debugging test on
aarch64.

QemuBaseTest.main() precaches assets (kernel, rootfs, DT blobs, etc.)
that are defined in variables with the ASSET_ prefix. This works because
it ultimately calls Asset.precache_test(), which relies on introspection
to locate these variables.

If an asset variable is not named with the ASSET_ prefix, precache_test
cannot find the asset and precaching silently fails. Hence, fix the
asset precaching by fixing the asset variable name.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20250827001008.22112-1-gustavo.romero@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_reverse_debug.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
index 58d45328350..8bc91ccfde7 100755
--- a/tests/functional/test_aarch64_reverse_debug.py
+++ b/tests/functional/test_aarch64_reverse_debug.py
@@ -21,7 +21,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    KERNEL_ASSET = Asset(
+    ASSET_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
@@ -30,7 +30,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-        kernel_path = self.KERNEL_ASSET.fetch()
+        kernel_path = self.ASSET_KERNEL.fetch()
         self.reverse_debugging(args=('-kernel', kernel_path))
 
 
-- 
2.47.2


