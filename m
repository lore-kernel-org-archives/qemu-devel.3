Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB42CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5CG-00024h-Q8; Thu, 04 Sep 2025 04:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5B5-0001BU-VZ
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:45 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu5B1-0008Dc-Sn
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:18:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61cdab7eee8so1085101a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973916; x=1757578716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ompVlJELO9ntgp7NqWovDalEEm5jaDFBaNVePh2Fg+k=;
 b=lqYpu8iTmfnRDkPsYPfWztkOHruSw/9HDNGJXi2AUKgD2QshF8ZVZgxVfo5/ciCepf
 rKV2iawkbnU1xvxO8tHX6k5Rj7eRU2cLG1LTxzQ6lLDWG9JpA6bJxjYSdl+njg0sEHyn
 QBxAtAho0yliqPYWp9QMmnoxYQS/rz0y+IIUtlqmxVUgl1x74H+07Zua3du1gvee1brZ
 H1Wkj7mBGshRf5sELwH7eSJ9rXk/kB4NO0CNSAGdt9nEQLlbEVtMXY7/o4I+7f+0VJGa
 rgJwcHqh1YDPejeLnAanrDnUdOtdEpYTdT/00WOnqVxxQWn1rHTjhmrUWqkbMl2V0cHc
 RNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973916; x=1757578716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ompVlJELO9ntgp7NqWovDalEEm5jaDFBaNVePh2Fg+k=;
 b=rNAHfDkyptGKnuql5HvqjbWK0H/+7otq6tvKRQrd4YIhZSXeJuOZpyyx56/lJit/KI
 C+/ce9GAlMDBHkw9b9EoLJGremhgu8pyez1+PO1/lagScDu5xCTp3so4xj1HGQoxlgvX
 PfojuawdC00NHdsbRtDR+R9+BQJw93MLJeo89f9CmOIDtcOS6wd2/ffQvhL9JW8aS41w
 zAnESJRJN6Wd9mFys5Vny6/2eqGc8hwumFCmUt0X4K5eVTcRZBKLzc3TU7FiQyynZlMy
 5VtpPcAPvAYrpU6G0tcPH4Y+3iAvqggziOWdgT0aXzpACrmEOjrmgNYyEBNXV+n3ZlX4
 wRiA==
X-Gm-Message-State: AOJu0YxCk3l4k9xovJtLSpuws/0bl2n01i3Rqj0y8osyATMmIpFwadKm
 rxFbSIzJk0vo5Tsw7ubxOZ3xEX1Ho4VFp9JTZkjuyeIn6zY/F6YuEF26cWcOwO/hjaY=
X-Gm-Gg: ASbGncuePWiHlK54Gp1SlURbXDIOp2uKEVhlRVWOEJVi1kAE2vfcbWBcJhgViWQeR5j
 Z2ilJ6TEp21Ro/WoU04+0/FzfIXFr0ZkF4y19cvBrdx313kHM4QvF4sIv1Vw9nmKm/z2k7H2Smm
 NWLKjMPhk/L16O8oJ1qhgT5dTWP2aRSF/xg5lL8J00rufYPZxFrrRHLdHFGxQlPJ7eAF2KF8Kfb
 z3wFFtb479UyxuxQ0xzL3s+hK8EmIdIrkaAtcPUe+IsIaRkUsp7jS4lmu60b/NtUGNESgSfkDvQ
 kbIL3Z7fbCYxZJgI9hBDfwt8xGBBvgbIabVRVrorzjb+xb7OXaILlCmof8TcVuRhtzMZWn8cp+V
 YW9CIZ/fHYdBLmCdpBAj9dq8poQ8Mc9mT+w==
X-Google-Smtp-Source: AGHT+IFXKnqgaKsY2aRYlcO4LSLsCuART/SZSEUFpFcB1viH9haZ5yBXysPjsYR6aV+gJtHba4UXNg==
X-Received: by 2002:a17:907:e916:b0:afe:ae6c:411c with SMTP id
 a640c23a62f3a-b01f2113c64mr1656930766b.64.1756973915989; 
 Thu, 04 Sep 2025 01:18:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff138a8c1dsm1395320766b.99.2025.09.04.01.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:18:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58E905F9D0;
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
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2 010/281] tests/functional/test_aarch64_virt_gpu: Skip test
 if EGL won't initialize
Date: Thu,  4 Sep 2025 09:06:44 +0100
Message-ID: <20250904081128.1942269-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

If you are using the Nvidia drivers and have installed new versions
of those packages but have not yet rebooted the host kernel,
attempting to use the egl-headless display will cause QEMU to fail to
start with

$ qemu-system-aarch64 -M virt -display egl-headless
qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
qemu-system-aarch64: egl: render node init failed

together with this complaint in the host kernel dmesg:

[7874777.555649] NVRM: API mismatch: the client has the version 535.247.01, but
                 NVRM: this kernel module has the version 535.230.02.  Please
                 NVRM: make sure that this kernel module and all NVIDIA driver
                 NVRM: components have the same version.

This isn't a problem with QEMU itself, so reporting this as a test
failure is misleading.  Instead skip the tests, as we already do for
various other kinds of "host system can't actually run the EGL
display" situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20250826123455.2856988-1-peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_virt_gpu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 38447278579..4e50887c3e9 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -76,6 +76,8 @@ def _launch_virt_gpu(self, gpu_device):
                 self.skipTest("egl-headless support is not available")
             elif "'type' does not accept value 'dbus'" in excp.output:
                 self.skipTest("dbus display support is not available")
+            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
+                self.skipTest("EGL failed to initialize on this host")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.47.2


