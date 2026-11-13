Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973A606A8A2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=P7jD30Is
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrj4-0000y2-2q; Fri, 13 Nov 2026 08:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPk-0003a8-8r
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:41 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPh-0006NS-Ls
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:39 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id D42178ABE;
 Fri, 13 Nov 2026 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794557612;
 bh=a7pf0IShNlT7VA/AFClMo0aZbBcHuo+nIrfYIGSmQXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P7jD30IsRUTlOF3af5TJi1dDZqmmv/F/VYiV06SeEn26lgSHrXrSLNMK9rY7tq/Yp
 QvarP0ZbnTU390WjV9grFV/e6jjKCDbbNp4kwM36aUKMxySqtSotIlfumvCXCalZSH
 5daG2/pURTRKnQLymqrs2RPvj63TCKczjn7m68vlE8ZWLJXu4i2Zrca5JJkaQcsQ1p
 MblwJ2pThogoV2cdjLAgEssfNNIHKRJA0GcRIW+YuOsxONSpPJhKaxa8HM6zwOyd5v
 diya9TRzSeCkib1pZBl5Pt8P6B+XskN0zfz82FzNPKHtujip29UeBACOL17D8HRQkT
 QGld0PM2mPxJQ==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id 5F79C1DE4A;
 Fri, 13 Nov 2026 08:13:32 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Dmitry R <rdmitry0911@gmail.com>
Subject: Re: [PATCH 3/7] hw/display/vhost-user-gpu: reset the console scanout
 on device reset
Date: Fri, 13 Nov 2026 08:13:19 -0000
Message-ID: <179455759968.604939.8707111457391137880@taktcycles.com>
In-Reply-To: <20261112-issue-4848-v1-3-aeba1cfe2c03@redhat.com>
References: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
 <20261112-issue-4848-v1-3-aeba1cfe2c03@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marc-André,

On Thu, 12 Nov 2026 15:48:46 +0400, Marc-André Lureau wrote:
> +        qemu_console_gl_scanout_disable(scanout->con);
> +        qemu_console_set_surface(scanout->con, NULL);

Thanks for the quick fixes. I tested the series on top of master
49559567 with -display dbus,gl=on, vhost-user-vga backed by
vhost-user-gpu --virgl, and a Debian 13 guest.

With this patch QEMU aborts whenever the guest resets the device while
a D-Bus listener is attached, i.e. at the virtio_gpu probe on boot and
again after a reboot:

  qemu-system-x86_64: ../ui/dbus-listener.c:625: dbus_scanout_texture: Assertion `tex_id' failed.

  #2  dbus_scanout_texture (tex_id=0, backing_width=720, backing_height=400)
      at ../ui/dbus-listener.c:625
  #3  dbus_gl_gfx_switch at ../ui/dbus-listener.c:904
  #5  displaychangelistener_gfx_switch at ../ui/console.c:242
  #6  qemu_console_set_surface at ../ui/console.c:799
  #7  vhost_user_gpu_reset at ../hw/display/vhost-user-gpu.c:692
  #8  virtio_reset at ../hw/virtio/virtio.c:3454
  #10 virtio_pci_reset at ../hw/virtio/virtio-pci.c:2355
  #11 memory_region_write_accessor (addr=20, size=1)
      at ../system/memory.c:493
  #19 kvm_cpu_exec at ../accel/kvm/kvm-all.c:3547
  #20 kvm_vcpu_thread_fn at ../accel/kvm/kvm-accel-ops.c:54

(line numbers with all seven patches applied)

The reset comes from the guest's write to the device status register,
so qemu_console_set_surface() runs on the vCPU thread. The placeholder
surface reaches the listener without a texture, presumably because the
display's EGL context is not current on that thread. virtio_gpu_reset()
runs the same work through reset_bh in the main loop when it is called
from a vCPU thread.

Without a listener attached the series passed all our tests; the
results for the other patches are in my replies to them and in
https://gitlab.com/qemu-project/qemu/-/issues/4846.

Dmitry

