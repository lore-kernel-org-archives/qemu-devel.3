Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD855C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 13:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2rZS-0004GL-Sp; Thu, 10 Apr 2025 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2565@phytium.com.cn>)
 id 1u2odI-00070x-DE
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:55:40 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liucong2565@phytium.com.cn>) id 1u2odE-0006Zc-1B
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:55:40 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHaWJlfdnRQUCFA--.793S2;
 Thu, 10 Apr 2025 17:55:21 +0800 (CST)
Received: from liucong.. (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwA3OoZulfdnzCtlAA--.11211S2;
 Thu, 10 Apr 2025 17:55:06 +0800 (CST)
From: Cong Liu <liucong2565@phytium.com.cn>
To: dmitry.osipenko@collabora.com
Cc: Jiqian.Chen@amd.com, akihiko.odaki@daynix.com, alex.bennee@linaro.org,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 gert.wollny@collabora.com, gurchetansingh@chromium.org, hi@alyssa.is,
 honglei1.huang@amd.com, julia.zhang@amd.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, pierre-eric.pelloux-prayer@amd.com,
 qemu-devel@nongnu.org, ray.huang@amd.com, robdclark@gmail.com,
 roger.pau@citrix.com, slp@redhat.com, stefano.stabellini@amd.com,
 xenia.ragiadakou@amd.com, zzyiwei@chromium.org
Subject: Re: [PATCH v11 04/10] virtio-gpu: Support asynchronous fencing
Date: Thu, 10 Apr 2025 17:54:54 +0800
Message-ID: <20250410095454.188105-1-liucong2565@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
References: <20250310120555.150077-5-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3OoZulfdnzCtlAA--.11211S2
X-CM-SenderInfo: 5olxu0lqjskluv6sx5pwlxzhxfrphubq/1tbiAQAQCmf20lQETgAAsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=liucong256
 5@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF1fJFy3Ww15XF1rtFyUAwb_yoW5XFyfpF
 W3ZFnYqa1UGFy5Awn8X3y8uF45KrZ2kw43Gwn5WanYgFsrKasa9r4DKr98uw1YvrsrCa1F
 qa4vk34DGryrZFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=liucong2565@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Apr 2025 09:03:36 -0400
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

I discovered that on an ARM64 environment, the 'virtio-gpu: Support asynchronous fencing' patch causes the virtual machine GUI to fail to display. Rolling back this patch and using virgl allows the virtual machine to start normally. When the VM screen is black, I can see some errors in QEMU. I used QEMU's -serial stdio to enter the virtual machine's command line console but didn't see any errors inside the VM - the graphical interface seems to be stuck. I would greatly appreciate any suggestions regarding effective troubleshooting methods or specific areas I should investigate to resolve this issue.

Here's my software and hardware environment:
- host and guest are ubuntu 24.04
- QEMU: https://gitlab.freedesktop.org/digetx/qemu.git native-context-v11 branch
- virglrender: latest main branch 08eb12d00711370002e8f8fa6d620df9b79f9e27
- Mesa: Mesa 25.0~git2504031308.ff386e~oibaf~n (git-ff386eb 2025-04-03 noble-oibaf-ppa)
- Kernel: Linux d3000 6.14.1-061401-generic #202504071048
- GPU: Radeon RX 6600/6600 XT/6600M
- CPU: phytium D3000 aarch64

Here's the command I'm using to run the virtual machine, which displays a black frame with "Display output is not active" and fails to start the graphical interface normally:

    phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display gtk,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0

    (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
    (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
    (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
    (qemu:46029): Gdk-WARNING **: 16:43:53.715: eglMakeCurrent failed
    (qemu:46029): Gdk-WARNING **: 16:43:53.716: eglMakeCurrent failed

When using SDL, the error messages are slightly different:

    phytium@d3000:~/working/qemu$ /usr/local/bin/qemu-system-aarch64 --machine virt,accel=kvm -cpu host -smp 4 -m 4G -drive file=/home/phytium/working/ubuntu24.04-aarch64-native-context,format=raw,if=virtio -bios /usr/share/AAVMF/AAVMF_CODE.ms.fd -netdev user,id=net0 -device virtio-net-pci,netdev=net0 -device virtio-gpu-gl -display sdl,gl=on,show-cursor=on -device usb-ehci,id=usb -device usb-mouse,bus=usb.0 -device usb-kbd,bus=usb.0

    vrend_renderer_fill_caps: Entering with stale GL error: 1286


