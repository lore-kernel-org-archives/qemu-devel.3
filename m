Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EEBE6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP76-0005o4-8b; Tue, 03 Dec 2024 04:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP74-0005nV-FF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:34 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP71-0002hv-Nf
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:34 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53dd8b7796dso5610668e87.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217750; x=1733822550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKNytw/ebCVRIpsQ9YAUBfkaMh3JJAq/QjBPjtgiz7g=;
 b=C4ES/bYd6CIO8uWhG9jWpVePaXTZZq2eN9nOGUP8DL/8HnrM+Wj9fCOsfBiIzZsKE8
 GB1J3Aem2YBIPebnZUlMENgLt+HMgSpTVk2q3SDW8In3QMI7xV0+gdFJOsdQ6uw0+WcX
 y2Qp5MUddxt7+LSsEftfszqEH3k5bOWm59hyCWR5sppvy6+KmwQ1Fz573LWT9O1AQOrZ
 XGhMJ5Lj96HRdS8pk/0xGGgGN2klsK7VR41jKSuxbdda31ZPLBtqwLeWIT2AGl3qBZJf
 qveoX0NKHtFowIeLcCGApOQrodsDZ/Xvou1wpjMrQpFjyZfLGBjRhtWcxyOYOKfQqmEW
 Zosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217750; x=1733822550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKNytw/ebCVRIpsQ9YAUBfkaMh3JJAq/QjBPjtgiz7g=;
 b=uIuFiAHO6NAU56guFW4rba27OXOKguySnzrMcHo/H2D/x9Pid2L4a6K77EA4ekyibq
 ZQovNjKXSBBWZfk0zSjWiNizwXY3ydaetoWvF19Tk3NkGvXNhQ/JGDzJLfUNq5ct2AXs
 GYrXehenvGYeOmclrFWqKUr/ruslGylx4ppxZc/TobewEg8EnuQ3UQ5rcZatpNFSJnST
 mTSDiQvXJ5hwN6HeCKUmkAVpIyav+1hfCXlhj8VxpPc2c0QNcK9dwM/PTzDTQ/azZAaa
 R/LGCEkkQ3jlw6jmwwSZDs/KJa5Lu77BLRZmFVA7EAklPEXTcmYHUzpNw91zV+XhNvYH
 o1XQ==
X-Gm-Message-State: AOJu0YzkHjb9aBrpOHmDfjQG5+R8O/U3xCjA2yr6tvvvx12xS4oiVE9i
 nN1MQn6dGHsa+x9ijLQmeuLYfuivtf77tI5bQxTXNWThxmGh56hDQpg2qNwNMZIB9qsIZsIziTW
 /HGU=
X-Gm-Gg: ASbGncu0RvfdHJEfvcpzAPSh/cwtNMnI6aE3kGrSEUpSHSxk6ZdYPe1+HToLRlzTTlk
 u/gmMnjEhSTmmuBz8WRP9xWYSp3si32QUPAWSj7NRSXVL8QcsUcB5a9SJPTTBw/pByN7a/FAYOT
 6R9eGJ/7DXMVaTA75frdCHcyTWm1f9ry2YrlIYqjpd+uSuyah8owt8DQFIzGlLveqCk5sB6fsPf
 Lztm/BVTfOSAAurXdOei4upzrFdaMQOXWacmm4tzH2ckYisW8PzWcAR+olDiA6YQMfzaWQ0
X-Google-Smtp-Source: AGHT+IFcpj6QzfB53oly3i7BN3QSlvt4/aDJxnH7tiR3CcVRsSurQ5wh0JwIqkBOrHoycPMN8RfEuA==
X-Received: by 2002:a05:6512:3096:b0:53d:a273:7da6 with SMTP id
 2adb3069b0e04-53e12a290b4mr863155e87.57.1733217749670; 
 Tue, 03 Dec 2024 01:22:29 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6a1asm591445466b.98.2024.12.03.01.22.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] accel/kvm: Remove mentions of legacy '-machine foo,
 accel=bar'
Date: Tue,  3 Dec 2024 10:21:52 +0100
Message-ID: <20241203092153.60590-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

Update the documentation when KVM is referred to.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/bypass-iommu.txt            | 3 ++-
 docs/nvdimm.txt                  | 2 +-
 docs/specs/tpm.rst               | 2 +-
 docs/system/arm/cpu-features.rst | 2 +-
 docs/system/cpu-hotplug.rst      | 2 +-
 docs/system/ppc/powernv.rst      | 2 +-
 docs/system/ppc/pseries.rst      | 4 ++--
 scripts/device-crash-test        | 2 +-
 8 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
index e6677bddd32..2ef0e0f6a65 100644
--- a/docs/bypass-iommu.txt
+++ b/docs/bypass-iommu.txt
@@ -51,7 +51,8 @@ And we got:
 x86 architecture:
 
 qemu-system-x86_64 \
- -machine q35,accel=kvm,default_bus_bypass_iommu=true \
+ -accel kvm \
+ -machine q35,default_bus_bypass_iommu=true \
  -device pxb-pcie,bus_nr=0x10,id=pci.10,bus=pcie.0,addr=0x3 \
  -device pxb-pcie,bus_nr=0x20,id=pci.20,bus=pcie.0,addr=0x4,bypass_iommu=true \
  -device intel-iommu \
diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index fd7773dc5ab..d589c3a9b77 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -228,7 +228,7 @@ which allows the platform to communicate what features it supports related to
 NVDIMM data persistence.  Users can provide a persistence value to a guest via
 the optional "nvdimm-persistence" machine command line option:
 
-    -machine pc,accel=kvm,nvdimm,nvdimm-persistence=cpu
+    -machine pc,nvdimm,nvdimm-persistence=cpu
 
 There are currently two valid values for this option:
 
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 1ad36ad7099..c50bb1cec01 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -329,7 +329,7 @@ In case a pSeries machine is emulated, use the following command line:
 
 .. code-block:: console
 
-  qemu-system-ppc64 -display sdl -machine pseries,accel=kvm \
+  qemu-system-ppc64 -display sdl -accel kvm -machine pseries \
     -m 1024 -bios slof.bin -boot menu=on \
     -nodefaults -device VGA -device pci-ohci -device usb-kbd \
     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a5fb929243c..4aed91a987d 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -329,7 +329,7 @@ SVE CPU Property Examples
   3) When KVM is enabled, implicitly enable all host CPU supported vector
      lengths with the ``host`` CPU type::
 
-     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
+     $ qemu-system-aarch64 -M virt -accel kvm -cpu host
 
   4) Only enable the 128-bit vector length::
 
diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
index cc50937c36c..64314ccfd6f 100644
--- a/docs/system/cpu-hotplug.rst
+++ b/docs/system/cpu-hotplug.rst
@@ -12,7 +12,7 @@ vCPU hotplug
     allow vCPU hotplug)::
 
       $ qemu-system-x86_64 -display none -no-user-config -m 2048 \
-          -nodefaults -monitor stdio -machine pc,accel=kvm,usb=off \
+          -nodefaults -monitor stdio -accel kvm -machine pc,usb=off \
           -smp 1,maxcpus=2 -cpu IvyBridge-IBRS \
           -qmp unix:/tmp/qmp-sock,server=on,wait=off
 
diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index de7a807ac76..689f9c81a02 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -63,7 +63,7 @@ powernv. kvm-pr in theory could be used as a valid accel option but
 this isn't supported by kvm-pr at this moment.
 
 To spare users from dealing with not so informative errors when attempting
-to use accel=kvm, the powernv machine will throw an error informing that
+to use '-accel kvm', the powernv machine will throw an error informing that
 KVM is not supported. This can be revisited in the future if kvm-pr (or
 any other KVM alternative) is usable as KVM accel for this machine.
 
diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index bbc51aa7fcd..3b18d2ee1ef 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -164,9 +164,9 @@ Currently, there are two implementations of KVM on Power, ``kvm_hv.ko`` and
 If a host supports both KVM modes, and both KVM kernel modules are loaded, it is
 possible to switch between the two modes with the ``kvm-type`` parameter:
 
-* Use ``qemu-system-ppc64 -M pseries,accel=kvm,kvm-type=PR`` to use the
+* Use ``qemu-system-ppc64 -accel kvm -M pseries,kvm-type=PR`` to use the
   ``kvm_pr.ko`` kernel module.
-* Use ``qemu-system-ppc64 -M pseries,accel=kvm,kvm-type=HV`` to use ``kvm_hv.ko``
+* Use ``qemu-system-ppc64 -accel kvm -M pseries,kvm-type=HV`` to use ``kvm_hv.ko``
   instead.
 
 KVM-PR
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 2b139e29ba0..2c6fd7c6f6e 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -147,7 +147,7 @@ ERROR_RULE_LIST = [
     # "spapr-cpu-core needs a pseries machine"
     {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expected':True},
 
-    # KVM-specific devices shouldn't be tried without accel=kvm:
+    # KVM-specific devices shouldn't be tried without '-accel kvm':
     {'accel':'(?!kvm).*', 'device':'kvmclock', 'expected':True},
 
     # xen-specific machines and devices:
-- 
2.45.2


