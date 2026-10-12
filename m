Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F870CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSN-0005kR-R4; Mon, 12 Oct 2026 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRS-0005FC-7f
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRL-00076a-QK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2045657f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824632; x=1792429432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0EjCsLzxCc6Z1J6Avt4waW7BwoDGH1cC4bpSsprV0z0=;
 b=mNyEWVVoIpS7oUyL4IWGoD8iYJFetqgVQG6FfWDiNkNWdPlpDMB3b2GZ6ZIGNPiJZJ
 X0NUU5RRmHfIk/M5kSNLPEOBRHpVXxWaNlyHKPRClei9NG4bsCP4OSxL+zVsMt6MA/Sa
 B8qpYpejC5NipjMct8gNY9KTQf+QSt9IutG9t3Pr+PrfoBm/djwxtQg8FQ55tblgJnVF
 wpMQWyZYk45k7J/oFT/kamq+Ik/4hQgib6TBK4W2WMJWR5AzDjRUdFNG8ZWQtS9OYll+
 h1Zrd0fi4BHmWm4hbRgTQXg1g74Pp6Od0+wE+Cvaa8aIptBEcegbZZGQFD/QbWw9gzwA
 +tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824632; x=1792429432;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0EjCsLzxCc6Z1J6Avt4waW7BwoDGH1cC4bpSsprV0z0=;
 b=jAWdC1Dv0m6dPNfOovSSbS2VkFPYUXB3riNL+8T6LitgXmEt++zJQHwCsipwhJMXYJ
 9OQQ9wyPlOclNmbfl/yHP3Dmx9bR1LAR3SQZpL7B9Px8LLmGxiR7J9Xv0Us7/wiuhzj4
 OKTq5UP/kKe+j/X9YLV5rUXVOQNP8ZseTW6qv6Gcg/aWpwytzgQpanVbYwxKV1icKmlc
 TatB7Fhi/bCSEhr7iHFTmMr5vvYinVeS+DHZqfpHs3/UMZkEaPbRjfS53TR1UWw20V4Y
 BMUBXKw8TN08oYjvDEdBUxtyGlHFHS947ZMb5xUoRmzI8hZHF/3CeCWskjeZ6RIVO8Ah
 dkug==
X-Gm-Message-State: AFq9FYKBb5FdtaQOTSokdESY8WeWb4bE77bXw16U+ssjxEskRqnXccIY
 Zp9iD+Ak+mEDz1MyHYZIzNuR4HxB/lf4+5HDwuE/1Sm47JBE9Jm/L2eHCTvECGOkBOg=
X-Gm-Gg: AYBFou0vjqXCm4OS2Z/A81oEmDOQjX4Cc/YrgfE7ixJMzfFhl/+7OmWOQr/l7ySYhIR
 vJp8IGptErKAmjgAv2yY27WFgw6WsLM5ztnMDKS0nK91wnrsQLFsm78bez7rgczKgmSmtu5k6AW
 GXWDlwiqL6bUAqB4JZbvbToGDwCZ5stbX+ZNaeR5UPQ5KjzZax08zOusbvk36gZhxmFcBUqExnV
 UvS7qcbN/aPc3NZbJaHitmXxkezGL/SDGaipPHpAdxUwb4WM5Q2VVEuoNT6eQP9Dhk3FKKKVzuS
 WieBdXARifv1qWlbMLbwOLB4frXk+eAdgKDUvj+cTyd2/XuMbDy7aDCqAwfvcMeXZh2uKurucR+
 hU7l8qHot2sSuAYksgrJWyay+Dt6wjdR4JqiY9hqvGfSa5igKc+8Wu0jZzaAqEXKxts7//K+Ifw
 UNydPAkwh8wJzidIi3fYdBJuxs1D7zVQauxQug69mRyGT18ihakTUW5/ypMXOoEgVqNWi69Q==
X-Received: by 2002:a05:6000:4a15:b0:48d:bc33:fa82 with SMTP id
 ffacd0b85a97d-48dbc33fd9cmr16827434f8f.11.1791824632001; 
 Mon, 12 Oct 2026 10:03:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967acasm391114f8f.2.2026.10.12.10.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C62F5FD9A;
 Mon, 12 Oct 2026 18:03:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 10/16] tests/functional: add tuxrun kvm gdb test for x86_64
Date: Mon, 12 Oct 2026 18:03:24 +0100
Message-ID: <20261012170330.1144446-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With all the bits in place we can now exercise the KVM gdb interfaces.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 026b373accb..1a1138d16ae 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -11,7 +11,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfMissingEnv
 from qemu_test.tuxruntest import TuxRunBaselineTest
 
 class TuxRunX86Test(TuxRunBaselineTest):
@@ -19,6 +19,9 @@ class TuxRunX86Test(TuxRunBaselineTest):
     ASSET_X86_64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
         '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
+    ASSET_X86_64_VMLINUX = Asset(
+        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
+        '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
         '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
@@ -47,5 +50,20 @@ def test_x86_64_kvm(self):
                            drive="driver=ide-hd,bus=ide.0,unit=0",
                            accel="kvm")
 
+    @skipIfMissingEnv("QEMU_TEST_GDB")
+    def test_x86_64_kvm_gdb(self):
+        self.require_accelerator("kvm")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun_gdb(kernel_asset=self.ASSET_X86_64_KERNEL,
+                               vmlinux_asset=self.ASSET_X86_64_VMLINUX,
+                               rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                               drive="driver=ide-hd,bus=ide.0,unit=0",
+                               accel="kvm")
+
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3


