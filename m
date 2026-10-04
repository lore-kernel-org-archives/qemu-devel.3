Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA4FCA5FF5
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJNk-0004SD-8g; Sun, 04 Oct 2026 06:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNh-0004S5-9I
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNe-0002sS-PV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dNewNuKHpRQK3Y6eSbvQ3Yn2TJoNLVKvZCmZqr70iWk=;
 b=Lu63uZn/PpuYu48myo36kRixXiTY0cu0T0JcLDXc9g0fqAzIMXmiEIzYG8syK13iyjtk7r
 0MMifelSi4XcwjocbWwRED7rV7UnU9mGG66tFfG05nKuBn7I8VykD0Dl/2OBqHKDQtA3+D
 bzuJkLe3tpqJhr8uJ9Xh5QXsrx0AA8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-MkABn85_N-eWqpzRw0481A-1; Sun,
 04 Oct 2026 06:23:38 -0400
X-MC-Unique: MkABn85_N-eWqpzRw0481A-1
X-Mimecast-MFC-AGG-ID: MkABn85_N-eWqpzRw0481A_1791109417
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DD0E180065F; Sun,  4 Oct 2026 10:23:37 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DBD3180034F; Sun,  4 Oct 2026 10:23:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/63] Various audio, chardev, ui and hw fixes
Date: Sun, 04 Oct 2026 14:23:14 +0400
Message-Id: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDUZ9dNwFbGgpowF0kEk4u6K5
 bd47wIhzyRQRRd4Olh4mQOSOAI7tvNAivtg0KiLBFErFtlJZXmBqjWY2dJZkxoHIVg9OT6/Wd3
 8lr2byG7vAe77AcyDloNuAAAA
X-Change-ID: 20261002-issue-4560-a704c9fc737f
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6607;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tWtP3LRGcFq8ml/QMLERuoKQv788ELojNmPsjaA3X+A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikgw8PHogFc8RXYB0Q+LRS2qNq1IUWzRwxrF
 Jh5l1vRIWCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIAAKCRDa6OEJdZac
 5ZS0D/41M3BNi7daThmyEp9GicNtMsw0UsntCoiEfJlXKy1dt9BEWGHr9MoYBKMdma/B+ZtC5ur
 i0nRWL/unH0ozBsp04R5TLq1pDyq3E5+Q/onxYpRbV+zGrngCmgtUyb5hUW+al0uSKAF46cWy2y
 xwu6MW9BiHdu2VlZzZatAMsaXXpXzLH44dnynErMEXh70kVNZDkofZcbD+xHewJp1Q2r1vNnmyd
 qIee6HczFqMvT6FnmPcDHQaG4SRQS0zny0qaGd+tSuWUaHXsE7AYZxVNJNK7QOPdDPl/5gpH1pC
 TqAJvRWprDrjx1TBRx5eMn3494P6vaGsbp9XM11XXlL9/lTNbpd7qylnObfVhxEK+nHdrnXrAuv
 L3Lb7vitezjuguS5rbnpPcSjv0Y4rEf9Zxnj95tMbgDgIIj909neZsW+8Rk/i8Ex4OD8ZlvqAqj
 W3HiS5SLpkjDVhTl6is15L9GFvec7qNNssnbsUE76n0lPtZKDWt3UZfNC9SWXOM+It0auiZxVSY
 Dil12mLFYNZFyZwFekM9Z3uFpKyUm+fA/86iO3c9did3bfwhGHY9TrAM9xRx9iij+XMbtVR3MBm
 xvlScNwwQ/V9EWlEYvsGhMRcvp39XK+TYpPvJ0PjtTJxa7WbLtx8dI/nxJM41NvoRG0ilwXSHXr
 dcJGhyVTAgoWreQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

This series addresses a collection of bugs reported by Pavee Hui at
https://gitlab.com/qemu-project/qemu/-/work_items/4560, most likley with
AI assitance. None of them should deserve a confidential level, imho.

I reviewed each reported issue against the code, and wrote individual
fixes, using Claude as a review assistant. Several reported issues were
dropped after review as incorrect or already addressed upstream. The
remaining fixes were split into bisectable commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (63):
      audio/ossaudio: fix ioctl passing address-of-pointer instead of pointer
      audio/dbusaudio: fix off-by-one in volume channel assertion
      audio/ossaudio: fix off-by-one in mmap buffer size assertion
      audio/paaudio: fix server string in PAConnection
      audio/paaudio: avoid pidfile path truncation
      audio/pwaudio: fix capture buffer leak on early return paths
      audio/pwaudio: clamp overrun writes to remaining ring buffer space
      audio/pwaudio: fix integer underflow in qpw_read()
      audio/pwaudio: handle negative avail in qpw_write and qpw_buffer_get_free
      audio/pwaudio: bail out on underrun in qpw_write
      audio/audio-mixeng-be: add upper bounds to audio settings validation
      audio/wavcapture: prevent freq overflow and corrupted WAV header
      ui/clipboard: clean up vm change state handler on last peer unregister
      ui/console: skip empty update regions in qemu_console_update
      ui/console: use QLIST_FOREACH_SAFE in dpy_refresh
      ui/input: fix integer overflow in qemu_input_scale_axis
      ui/vnc-enc-zrle: propagate zrle_compress_data error
      ui/vnc-jobs: assert rect coordinates and dimensions in vnc_job_add_rect
      chardev/char-pty: free pty_name in finalize
      chardev/char-ringbuf: reject zero size with is_power_of_2
      chardev/char-ringbuf: use actual read length in qmp_ringbuf_read
      chardev/char-udp: clarify read_poll return value with pending data
      chardev/char: fix use-after-free on mux creation failure
      hw/audio/gusemu_mixer: fix integer overflow in volume ramping
      hw/audio/gusemu_mixer: use unsigned literal for IRQ bit shifts
      hw/char/cadence_uart: fix RX FIFO overflow handling
      hw/char/cadence_uart: use correct interrupt for TX FIFO overflow
      hw/char/cadence_uart: validate FIFO indices in post_load
      hw/char/cadence_uart: fix post_load return value for invalid baud rate
      hw/char/escc: validate channel register index in post_load
      hw/char/exynos4210_uart: fix baud rate calculation operator precedence
      hw/char/exynos4210_uart: enforce 32-bit MMIO access size
      hw/char/ibex_uart: prevent division by zero on baud rate calculation
      hw/char/imx_serial: update interrupts after status register writes
      hw/char/serial: clamp zero baud rate to default
      hw/char/sh_serial: fix RDF flag clear on FIFO reset
      hw/char/sh_serial: use rx_cnt for available FIFO space
      hw/char/sh_serial: fix break detection flag
      hw/char/terminal3270: fix output buffer size for IAC-escaped header
      hw/char/terminal3270: consume processed input data
      hw/char/terminal3270: fix pre-handshake outbound data check
      hw/char/virtio-serial-bus: validate scatter-gather state in post_load
      hw/display/ramfb: validate guest-supplied stride
      hw/display/ramfb: fix map/unmap region size mismatch
      hw/display/ssd0323: mask SPI data to 8 bits
      hw/display/ssd0323: fix signed modulo in column/row commands
      hw/display/xenfb: fix 24-bit pixel read in BLT macro
      hw/input/adb: reject zero-length requests
      hw/input/adb: validate devaddr on migration load
      hw/input/adb: report error when too many devices are registered
      hw/input/adb-kbd: validate WRITEREG request buffer length
      hw/input/adb-kbd: validate ring buffer indices on migration load
      hw/input/adb-kbd: check for errors after parent realize
      hw/input/adb-kbd: guard parent_unrealize against NULL
      hw/input/adb-mouse: validate WRITEREG request buffer length
      hw/input/adb-mouse: check for errors after parent realize
      hw/input/adb-mouse: add unrealize handler to unregister input
      hw/input/hid: validate queue length and key count on migration load
      hw/input/hid: fix off-by-one in pointer queue access on migration load
      hw/input/pl050: remove duplicate class_init assignment
      hw/input/stellaris_gamepad: deassert IRQs on reset
      hw/input/virtio-input: free VirtQueueElement in error unwind path
      hw/input/virtio-input: document queue preservation on device reset

 audio/audio-mixeng-be.c      |  4 ++--
 audio/dbusaudio.c            |  4 ++--
 audio/ossaudio.c             |  4 ++--
 audio/paaudio.c              |  6 ++++--
 audio/pwaudio.c              | 22 ++++++++++++++++++++--
 audio/wavcapture.c           |  6 ++++++
 chardev/char-pty.c           |  1 +
 chardev/char-ringbuf.c       | 10 ++++++----
 chardev/char-udp.c           |  4 ++++
 chardev/char.c               |  1 +
 hw/audio/gusemu_mixer.c      | 16 +++++++++-------
 hw/char/cadence_uart.c       | 26 ++++++++++++++++----------
 hw/char/escc.c               | 11 +++++++++++
 hw/char/exynos4210_uart.c    |  6 +++++-
 hw/char/ibex_uart.c          |  8 ++++++--
 hw/char/imx_serial.c         |  3 +++
 hw/char/serial.c             |  3 +++
 hw/char/sh_serial.c          |  6 +++---
 hw/char/terminal3270.c       | 15 ++++++---------
 hw/char/virtio-serial-bus.c  |  6 ++++++
 hw/display/ramfb.c           | 10 ++++++++--
 hw/display/ssd0323.c         |  9 +++++----
 hw/display/xenfb.c           | 19 +++++++++++++------
 hw/input/adb-kbd.c           | 29 ++++++++++++++++++++++++++++-
 hw/input/adb-mouse.c         | 23 +++++++++++++++++++++++
 hw/input/adb.c               | 17 +++++++++++++++++
 hw/input/hid.c               |  9 ++++++++-
 hw/input/pl050.c             |  1 -
 hw/input/stellaris_gamepad.c |  3 +++
 hw/input/virtio-input.c      |  5 +++++
 ui/clipboard.c               |  4 ++++
 ui/console.c                 |  7 +++++--
 ui/input.c                   |  8 +++++++-
 ui/vnc-enc-zrle.c            | 19 ++++++++++++++-----
 ui/vnc-jobs.c                |  1 +
 35 files changed, 257 insertions(+), 69 deletions(-)
---
base-commit: 2a0ac9c8ac2d303ca515dc819043409aef18cab5
change-id: 20261002-issue-4560-a704c9fc737f

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


