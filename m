Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC18C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbVP-0006Vx-8d; Fri, 20 Jun 2025 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbV4-0006NN-UT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUz-00051V-Kh
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1830208f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424980; x=1751029780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6n2BSSxRh+KStXe1TUl7/blQoxrrxglxVgcpHIzilA=;
 b=j1AbF+saJLwNRwmEmgfXjh/ZCQoVy6jpWeXzoqh2NOxw3ljJA6cWkAoOspcfs3jJOd
 3N5LlMD504rtBBpaHnFfb1DRqejU2sPtHTG4+nfr5W+6Q//v4oMKcSCFDYzYblkJnFZI
 RuqGPyzrDHDQudkdevcJrzCROxnkY7lHGfyhw/Rf4PvA4r4G4at8LIGjX+ASlgJUxvdD
 FXkAFjIAR9Iz8rm4fb+RupopT8VzabE4iQOdpHtY5HNuB7GswXBq0AGzC2hF/n3IcLuT
 Hm+USKnU7lRJhEGWOma8FKl5CWu/bIVu+71vP14ygvV3VVxqZ2PjfUcKA37Ie148eAyL
 nJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424980; x=1751029780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6n2BSSxRh+KStXe1TUl7/blQoxrrxglxVgcpHIzilA=;
 b=FQkdi7hSDi0tuT4XtqebJU5+vW4HQNKz+B77s4WZtI90RuvFNqGi0o7E/odg0ccRP5
 +e5jEJp0qykp7FNwID4WF5HD4chttRbebc4CMU3L1YSikx3v7lCnmB4ywI6DP8/upfEW
 tPhCmHa80bZqb8OzrL5lzYZgOAPMecwJOm/Zk6KLcME/mR6OsDU5JhYs42lQ6lS9YwRj
 yoV8nb252SeGOdWNtYqEc1kZeMZun8MfoClBBDFMpU02OM+VvIwIv4NqelkWdnLnRfdI
 R3cwU7gwX9MZBBGuCgxXcz8MB3wJGKSD3aGD7+ksQV1SbIbTpZRqBqnlR81HdgTItQjR
 UotA==
X-Gm-Message-State: AOJu0YxRoFsa7zV+ECqTuI3BycT6aiinzFtIBwjRzd81ePsJnHvaRfT1
 stwYFXCiGg3ddtJ49oM6yhPjEjPybKhK0rkmEXRDTzuQhhqs9ekRyyiYXfAlyWoiRlK6a+O+Vcz
 Eev+RFVU=
X-Gm-Gg: ASbGnctOFvmX+5jIAkjUPcmXzGqIXKl11BgonrwrbC0+LhbxnlscyQJnFOZhQU2pRnI
 RhPiQAp3n7ug4zDcqD//qXc+J2BpDrHoj68/cCPeJRDdnLkmiQvjL3pAyjHnetBZFUVDCkNXg2M
 fJwaclTdAxtcwEA7HaSzy2VxTV+eZ8YqymLCBNIKpf2R/SKEvAJSNdNSHXjpjqUrY35umf5TFNl
 FgACHbvyZCxDpaAdihH7L3jvA8QLH1WYH3+8V2lGyi7wN2TBQYyf4HfO1fUKuPK8ORg4Pl49NUD
 9nLgS05F+hRmzqlhf8XHPiZuOROgx/yX08MhdVCizo7kurHWz9WC+X2n2xoW0VRQyg7qlcB1lwl
 4wDHA1kETOwsrJ0Bx4vlYWLRSxkOsuVJEXeEi
X-Google-Smtp-Source: AGHT+IGXwFQFfwW7rAMovUtfDAuB9Dz2J3aZxTUZqf2DF7gPQ8T5LAmGCEyFfgo/pTiyQMieyUC1PQ==
X-Received: by 2002:a05:6000:26c8:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3a6d27e16f5mr2027646f8f.19.1750424979716; 
 Fri, 20 Jun 2025 06:09:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1188804sm2015800f8f.79.2025.06.20.06.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 26/26] tests/functional: Expand Aarch64 SMMU tests to run
 on HVF accelerator
Date: Fri, 20 Jun 2025 15:07:09 +0200
Message-ID: <20250620130709.31073-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_smmu.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
index c65d0f28178..59b62a55a9e 100755
--- a/tests/functional/test_aarch64_smmu.py
+++ b/tests/functional/test_aarch64_smmu.py
@@ -22,6 +22,7 @@
 
 class SMMU(LinuxKernelTest):
 
+    accel = 'kvm'
     default_kernel_params = ('earlyprintk=pl011,0x9000000 no_timer_check '
                              'printk.time=1 rd_NO_PLYMOUTH net.ifnames=0 '
                              'console=ttyAMA0 rd.rescue')
@@ -45,11 +46,11 @@ def set_up_boot(self, path):
         self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
 
     def common_vm_setup(self, kernel, initrd, disk):
-        self.require_accelerator("kvm")
+        self.require_accelerator(self.accel)
         self.require_netdev('user')
         self.set_machine("virt")
         self.vm.add_args('-m', '1G')
-        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-accel", self.accel)
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-machine", "iommu=smmuv3")
         self.vm.add_args("-d", "guest_errors")
@@ -201,5 +202,9 @@ def test_smmu_ril_nostrict(self):
         self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
 
 
+class SMMU_HVF(SMMU):
+    accel = 'hvf'
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.49.0


