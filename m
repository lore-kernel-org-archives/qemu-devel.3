Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E9F3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuun1-0006UA-DR; Tue, 24 Feb 2026 10:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuumz-0006Tn-6i
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:33 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vuumx-0000nt-Ed
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:57:32 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5688b639a19so2204347e0c.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771948647; x=1772553447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rm1Joy5Gd6XPfUlX1lJyX5EUsREqGJkWxY0WBpBmIiM=;
 b=XFEN12HVkjr9maoNCJFLMWb5a/gv4ZZ6xK0SadPaW59xkCf/YMQjQUbZ67IogidI72
 4kanNMmdGb4agqb5PScM0wXtgJ7Z+T3Nzq4GDF4BDR/orV2xRnFnukuwAptv41ppUqj3
 pPVPD9S2AEgcFZ5AjlmGr9qaegxZWbgdehpEdvFndcqiFNFjlrNZN9GOAI1wqEh7Uwrq
 wPDuwyq1xK4TkMfDJ+egjMzLCjheFtspDky+K1A3g9iC8B5FIlb6gw0lsEbr+Z5joKjj
 cRpEhr/rSLRZC+iArt4PUM9mJDHsGDQ9z3ugUbvKKYnBq4d4eD1CXdzMTaJxcFy7jTN8
 7jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948647; x=1772553447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm1Joy5Gd6XPfUlX1lJyX5EUsREqGJkWxY0WBpBmIiM=;
 b=BcveEKv2NA8YhjtTXh+KxuZAVXhKoyy6WdguSB/1QHAd8DgpLKBfZizbUMhjEcqjyK
 jRSg5vVDDEjGAxsLAo3XgyMCSNyp2Yb2mvowPohijhSPLDw8I09pTJhiPX9/0FXqbxPq
 Ae0CIaXiHeunsT7S0SQAS2xt/Y9SqUNiz+vdAiy8V2lQOQd+j823uGCY0FBmY+Ay1uJS
 usjhqyOLeeIXH4PG2Q/a4qGy6trt1fXyL+ddiIR9DX2Cqo89PlxMIQdCYdolkVJ40aL2
 nlb238tvfPBcfIa7W/X/bg9w3MeeUxEZnwfczbtOFcmLmv4NDYn5W7ZYRZ/BpGvyQ02O
 mYJQ==
X-Gm-Message-State: AOJu0YzEyEZr7xfpg4IdT1JYrf03LT+IA++9WVYdSfWBlIMoCCrbIW7w
 FHJ3ev374dao/u5S7AWBREGYX4+gButayLEfu0qKMnTjLaZ4XZMyUwN4zrF9ssdW
X-Gm-Gg: ATEYQzxm3T7QacH4Ii/CNuSnUNr2IVM8N2WuHx2Wi4OfBx90ZcmyX2RQcX1cUvN7GIG
 APPCMfU7hiuWcx5e31K4ayPozoimzRm3lwXawOhelSlhBENy+PQN0ANR5MZM7vLJzh3TngsHMYG
 E9w1n4r8bi48ovxMKhT+bYYusUrqeVvyo0KL2eADMu+4mJFurzaRfBqzEf+ylzxMaAkhgJ0NbHE
 m5kWSRx3mQHnGCrLVS8R20gYPECoroRw8tsiXVN4Wn7OIU+uYQgr2vtAh4AvzS+xDS//P9tYqIl
 n83qGmipmCHYc6Z+T1/Pdbp60650AA2zJQi+OHfHsaUTjLr3j9nHzfiZ8lIcoOvlgUUDITbp4Qc
 hvItZ27/b+VQGxJFJAVtSWo8I/8TT6WzNMkVxD2VIDbm9OkqvaPeAoIA/TDCpJhxxYPi87y/vhY
 Sff+ZtsrpKjSgf84JeYD/ZWWO4JdfyszpQhVt5xBmGQaNKpPaUWONf6mpUrQ==
X-Received: by 2002:a05:6102:c4b:b0:5fd:ee19:8b30 with SMTP id
 ada2fe7eead31-5feb30d4a33mr4684882137.35.1771948647462; 
 Tue, 24 Feb 2026 07:57:27 -0800 (PST)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5feb6204a47sm11185716137.2.2026.02.24.07.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:57:26 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: [PATCH v2 0/4] virtio: Add the virtio-msg transport
Date: Tue, 24 Feb 2026 16:57:17 +0100
Message-ID: <20260224155721.612314-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This adds virtio-msg, a new virtio transport. Virtio-msg works by
exchanging messages over a bus and doesn't rely on trapping and emulation
making it a good fit for a number of applications such as AMP, real-time
and safety applications.

Together with the new transport, this series adds a PCI device that
implements an AMP setup much like it could look if two SoC's would
use virtio-msg across a PCI link.

Current gaps and limitations:
No support for SHM regions yet.
Temporarily uses PCI Vendor Xilinx / Device 0x9039.

The virtio-msg draft spec:
https://github.com/Linaro/virtio-msg-spec/

QEMU with these patches:
https://github.com/edgarigl/qemu/tree/edgar/virtio-msg-rfc

Linux with virtio-msg support:
https://github.com/edgarigl/linux/tree/edgari/virtio-msg-6.17

To try it, first build Linux with the following enabled:
CONFIG_VIRTIO_MSG=y
CONFIG_VIRTIO_MSG_AMP=y
CONFIG_VIRTIO_MSG_AMP_PCI=y

Boot linux on QEMU with a virtio-msg-amp-pci device, in this example
with a virtio-net device attached to it:

 -device virtio-msg-amp-pci
 -device virtio-net-device,netdev=n0
 -netdev user,id=n0

If you're running on a QEMU machine that has virtio-mmio enabled, e.g 
ARM virt, you'll need to specify the virtio-bus for the device, otherwise
QEMU will connect it to virtio-mmio. For ARM virt machines:

 -device virtio-msg-amp-pci
 -device virtio-net-device,netdev=n0,bus=/gpex-pcihost/pcie.0/virtio-msg-amp-pci/fifo0/virtio-msg/bus0/virtio-msg-dev
 -netdev user,id=n0

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Clamp get_features block count.
* Remove virtio notify_queue in favor of per queue vectors.
* Enable NOTIFICATION_DATA.
* Drop unpexpected responses rather than assert.
* Fix msg handler bounds check.
* Guard handlers against missing devices.
* Respond to bus pings.
* Add BUS_GET_DEVICES.
* Fix use of uninitialized var in virtio_msg_reset_hold.
* Fix EVENT_CONFIG message length.
* amp-pci: Fix fifo offset computation.
* amp-pci: Don't notify when dropping messages.
* Document virtio_queue_get_rings.
* Add virtio-msg-amp-pci.rst to index.rst.

Edgar E. Iglesias (4):
  virtio: Add virtio_queue_get_rings
  virtio: Add the virtio-msg transport
  hw/misc: Add generic virtio-msg AMP PCI device
  docs: Describe virtio-msg-amp-pci

 docs/system/devices/virtio/index.rst          |   1 +
 .../devices/virtio/virtio-msg-amp-pci.rst     |  92 ++
 hw/misc/Kconfig                               |   7 +
 hw/misc/meson.build                           |   1 +
 hw/misc/virtio-msg-amp-pci.c                  | 361 +++++++
 hw/virtio/Kconfig                             |   4 +
 hw/virtio/meson.build                         |   5 +
 hw/virtio/virtio-msg-bus.c                    |  89 ++
 hw/virtio/virtio-msg.c                        | 986 ++++++++++++++++++
 hw/virtio/virtio.c                            |  16 +
 include/hw/virtio/spsc_queue.h                | 213 ++++
 include/hw/virtio/virtio-msg-bus.h            |  95 ++
 include/hw/virtio/virtio-msg-prot.h           | 949 +++++++++++++++++
 include/hw/virtio/virtio-msg.h                |  56 +
 include/hw/virtio/virtio.h                    |  14 +
 15 files changed, 2889 insertions(+)
 create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst
 create mode 100644 hw/misc/virtio-msg-amp-pci.c
 create mode 100644 hw/virtio/virtio-msg-bus.c
 create mode 100644 hw/virtio/virtio-msg.c
 create mode 100644 include/hw/virtio/spsc_queue.h
 create mode 100644 include/hw/virtio/virtio-msg-bus.h
 create mode 100644 include/hw/virtio/virtio-msg-prot.h
 create mode 100644 include/hw/virtio/virtio-msg.h

-- 
2.43.0


