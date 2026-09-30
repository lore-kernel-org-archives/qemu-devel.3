Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92729CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSd-0001Jb-UP; Wed, 30 Sep 2026 12:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSR-0001Bc-Hr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSO-000336-QY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:03 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so638894f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786819; x=1791391619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mm5yOz3FMOhLwxnWcg4dJcf6/YApzSZu5a2Cjgw36ho=;
 b=PLGtDhDq1fq2RLoWGqJanZHLe09pG59yWoqm6k2b3qDxO9tTUSmA4iW2uuZmiqs23e
 mtQrSZNG7ob8jMnD1zwVXzRbc8LPSG8e/bp0w91xJr0mtDgIMBvTnH5m+8dzR2nHTv41
 FW8EjHx+SXhKIz0z/eb1V5tAGPY+nBsouesXOPvBTTTETEMgkb76Fv+yD9Mr/PpfR2SO
 uO0zQDF/gXh65+Ox9EMLSFYP47/A/Kc5ehCupCvS4IG6uhaQjTOOmavWEy6/ICKHcLE0
 sE7XuaF2it77DvVRo/g4Hn+gWQsNEGamT+fHI5TgM5eGQZX8H/QnOxostQ4sBED8x0wd
 Wilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786819; x=1791391619;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mm5yOz3FMOhLwxnWcg4dJcf6/YApzSZu5a2Cjgw36ho=;
 b=0/LSAWoFL5Co5GAAdbT1AdTNXpzjTJ1kDFssQAahwkRmmoK/YIzQ94Z6SkXqBzl2Yn
 QfJTW7VDxptlyBImReU1s6oqknY+anYJ2HuY1AkzYP12moQzz7u/LnfxyySOwRvXHHNd
 3r7Anu4iXvt55m8ng49tlqwSQ338AFqPG8e2jLHWgXdmmcD9aPuGCUwTPJgjA1Veg1GJ
 x7dcyKgM8O91pxT8/2/HvAeS3bJVFPoQsARCCIaKXneELtVMNC8AAdTZi2z+ZYbPyeF8
 HOydacG+mty98rNhmNyPlvP+1tcGPCa+TO8wXSwmY0lBXc190TfHTyIfvVmTJNAC4n0Q
 7Oyg==
X-Gm-Message-State: AFq9FYJfMjzEYC8T6SEf9saYhYkNgppqKxJTMYht+PC4LWwbdwas/Ryr
 Kme6xoG45t8S0LcF0TBoedVCxLsZvjg4C3dHtfDwLtV/3PVgRdiu9S++MivqBNXo+CU=
X-Gm-Gg: AYBFou0VtqvMJWRJExirxwcIND6j6nqxDW2pMBmjA09Yujm37XEFixSXXY1RU3YGCN9
 4ezFk+i/SDGjyZNPNvLPX0SogiN8I2gPgnxjuXgLCezOP/hQC2qTK6ry5EAgrEIuf93ogspO+Ze
 N54+2uUv0S0X+PKaHVtyqAZUPba+ZLZG2xjR42uPHb/kfCqbifDapP0TuW5u8U6XLoJah3C6faA
 3/8r0PrTb4HpG30mx8NfE/8T/tVDrxZgrN3oibqDcDT2ezgylWM5ro4MUDY1i5TQG+SbkOF3eaT
 sHGgoqkaTB1Cyico6F9WuzN6XRrdsRrEf/E8Bzxrl3OEImUCtUOT8SVj578URJBLAXur8nV0Lvd
 RLZ0mgcV2tNQSl0Gjmrw4aa8e3wmgzefV4eX2jbHFVyXvhr6q5onJ5+rV2sQRXGIfdgk+yinVhI
 JANxKq2wqDJ/Ygau4TxuhvCyrH58lnPzrHgI9CRtxZvPfokfKeztEz60xVeyIiRSbvRQoeMA==
X-Received: by 2002:a5d:588a:0:b0:488:8752:bc91 with SMTP id
 ffacd0b85a97d-48b02457277mr4854734f8f.2.1790786818728; 
 Wed, 30 Sep 2026 09:46:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9b1sm331787f8f.4.2026.09.30.09.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56C5B5F9DA;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 06/13] tests/functional: allow tuxrun tests to be passed
 "accel"
Date: Wed, 30 Sep 2026 17:46:42 +0100
Message-ID: <20260930164649.433573-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For some tests we are about to add we want the flexibility to force
"kvm" so give them that ability.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/tuxruntest.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
index 6c442ff0dc4..ca1589fea37 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -65,7 +65,7 @@ def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
 
         return (kernel_image, disk_image, dtb)
 
-    def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
+    def prepare_run(self, accel, kernel, disk, drive, dtb=None, console_index=0):
         """
         Setup to run and add the common parameters to the system
         """
@@ -79,6 +79,10 @@ def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
         self.kcmd_line += f" root=/dev/{self.root}"
         self.kcmd_line += f" console={self.console}"
 
+        # have we specified an accelerator?
+        if accel:
+            self.vm.add_args('-accel', accel)
+
         self.vm.add_args('-kernel', kernel,
                          '-append', self.kcmd_line,
                          '-blockdev', blockdev)
@@ -118,6 +122,7 @@ def run_tuxtest_tests(self, haltmsg):
     def common_tuxrun(self,
                       kernel_asset,
                       rootfs_asset,
+                      accel=None,
                       dtb_asset=None,
                       drive="virtio-blk-device",
                       haltmsg="reboot: System halted",
@@ -130,7 +135,7 @@ def common_tuxrun(self,
         (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
                                                        dtb_asset)
 
-        self.prepare_run(kernel, disk, drive, dtb, console_index)
+        self.prepare_run(accel, kernel, disk, drive, dtb, console_index)
         self.vm.launch()
         self.run_tuxtest_tests(haltmsg)
         os.remove(disk)
-- 
2.47.3


