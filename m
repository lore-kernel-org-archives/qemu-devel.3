Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8043C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC5V-00088X-GR; Mon, 16 Jun 2025 11:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC5S-00087b-2l; Mon, 16 Jun 2025 11:49:30 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC5P-0003E4-OM; Mon, 16 Jun 2025 11:49:29 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei A9E86737C
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750088934;
 cv=none;
 b=EsndBWjnfNAy91qG3IOcy5qqZceA3UIia6rJaJsywa1R9+b5Np59BOvMSj45UWMWi0S1msaU7w/d/hMrS4l5acxgb/CdBPrK+Hpw8e5yQf5S778S4el3T+FYF8lJlvAmiC2tFNvRS9Q6vlo6TeL7wB8GI1YNHJO0b1vFpeLVl94AqciKgxgpoJkSXGLjHzPry1fDAgQDibIdouT7QlZ7DWu+aOR9MzlC0hblKYgR6tC6G05JRPNH2Pso1riRuJlpvGCkleZnYq4YflBVQ+B+d6q5orUDjs7lq1ZJaIhzkAUcLM/ynZ0y0yjQq7J3zSErtVX/pUoVme1Rlvjya0CC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750088934; c=relaxed/simple;
 bh=TzOP3c4SD9Aw5fC96ocSZykbTKAK4gpli+pUnnod8U0=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=CekFJ+oopLOPSZzHS8sPhbfx+TLYDhEy6trr50XIANB9Jm9w5ek1JYeMFWm2CyT+I2D8DFgI9iwyTaQ4VAZY8/ALvmMQFISDJBKSw0Ty8SawGGOI0Nh1+Lw4unE7wJ2zIweg1tH72xBiJGdCfRabSPPldYz4d/s6WKuQNpjcrtrXlEb5k4Iu2p3matF8oh5ssXFtc9/WieR2yGRJgzUN2F818KzwLI9K9UOCpS4fEWDU/3UOCmdoxiqC4yfn7bpLONoCmQQsynTT26JOyclbYxClDuT1zvdVPJkkHy0Ov0u0dUm1/8y+0FSXbGw/cPVNDhhG3yTG5Tew3OC3snl68A==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750088933;
 bh=TzOP3c4SD9Aw5fC96ocSZykbTKAK4gpli+pUnnod8U0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p6bmoSjmdsA5Kay/GuxCJ3axmPkwU6ma0D9Pc0QT/EgiZpWkgEW25G68WgaXy4hV6
 JuIGMly5SH4EoP8e3slnZZIOdLpVWWS7UTixRB3dNMSBNSIm/a0M+2jwPlukqQqoBt
 D7d4SNgfVqiEpLPU0uuEz9RGafjwvHLBK+nimt5sl892W0GvRQbg+4+fhIN+5Dj+cm
 2TmcehtdAO9jmfEKafOSEL1n/hTdTO1i9H3U5iXnqrkXHDbsPmL2LuvsEtCjk+/P1f
 EKO6MHUdU2v8t6OcnPpnw87QKOT90NzXlNf0rRe6NmQuWOBU3Egsix6W2C/IgB14ca
 TeYYiWy4iZTqw==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id A9E86737C;
 Mon, 16 Jun 2025 23:48:48 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 2/6] MAINTAINERS: fix paths for relocated files
Date: Mon, 16 Jun 2025 11:48:20 -0400
Message-ID: <20250616.qemu.relocated.02@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Several files were renamed in previous commits, causing their entries
in MAINTAINERS to reference outdated paths.
This prevents scripts/get_maintainer.pl from correctly matching
these files to their maintainers.

Update the filenames to reflect their current locations so that
maintainer lookup works properly.

Related commits
---------------

  c45460decbd (Oct 2023)
    hw/input/stellaris_input: Rename to stellaris_gamepad
    Rename  include/hw/input/{gamepad.h => stellaris_gamepad.h}

  4faf359accb (Nov 2020)
    docs: Move virtio-net-failover.rst into the system manual
    Rename  docs/{ => system}/virtio-net-failover.rst

  89857312f32 (Apr 2024)
    hw/usb: move stubs out of stubs/
    Rename  stubs/usb-dev-stub.c => hw/usb/bus-stub.c

  f2604d8508a (Apr 2024)
    hw/virtio: move stubs out of stubs/
    Rename  stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c

  2c888febdfa (Apr 2024)
    memory-device: move stubs out of stubs/
    Rename  stubs/memory_device.c => hw/mem/memory-device-stubs.c

  d481cec7565 (Oct 2024)
    migration: Move cpu-throttle.c from system to migration
    Rename  {system => migration}/cpu-throttle.c

  864a3fa4392 (Jan 2023)
    monitor: Rename misc.c to hmp-target.c
    Rename  monitor/{misc.c => hmp-target.c}

Signed-off-by: Sean Wei <me@sean.taipei>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed8619874..0477e124d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1002,7 +1002,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/stellaris*
 F: hw/display/ssd03*
-F: include/hw/input/gamepad.h
+F: include/hw/input/stellaris_gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
 F: tests/functional/test_arm_stellaris.py
@@ -2163,7 +2163,7 @@ F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
 F: tests/functional/test_info_usernet.py
-F: docs/virtio-net-failover.rst
+F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
@@ -2214,7 +2214,7 @@ F: tests/qtest/sdhci-test.c
 USB
 S: Orphan
 F: hw/usb/*
-F: stubs/usb-dev-stub.c
+F: hw/usb/bus-stub.c
 F: tests/qtest/usb-*-test.c
 F: docs/system/devices/usb.rst
 F: include/hw/usb.h
@@ -2469,7 +2469,7 @@ F: hw/s390x/virtio-ccw-md.h
 F: hw/s390x/virtio-ccw-md-stubs.c
 F: hw/virtio/virtio-md-pci.c
 F: include/hw/virtio/virtio-md-pci.h
-F: stubs/virtio-md-pci.c
+F: hw/virtio/virtio-md-stubs.c
 
 virtio-mem
 M: David Hildenbrand <david@redhat.com>
@@ -3187,7 +3187,7 @@ F: hw/mem/pc-dimm.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
-F: stubs/memory_device.c
+F: hw/mem/memory-device-stubs.c
 F: docs/nvdimm.txt
 
 SPICE
@@ -3228,9 +3228,9 @@ F: util/qemu-timer*.c
 F: system/vl.c
 F: system/main.c
 F: system/cpus.c
-F: system/cpu-throttle.c
 F: system/cpu-timers.c
 F: system/runstate*
+F: migration/cpu-throttle.c
 F: qapi/run-state.json
 
 Read, Copy, Update (RCU)
@@ -3249,7 +3249,7 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
 S: Maintained
 F: monitor/monitor-internal.h
-F: monitor/misc.c
+F: monitor/hmp-target.c
 F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
-- 
2.49.0


