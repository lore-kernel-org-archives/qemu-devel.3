Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735BC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 12:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtnpd-00066S-5u; Mon, 08 Apr 2024 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpa-00065l-2E
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rtnpY-0004oQ-3Q
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:10:33 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so4006608b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712578110; x=1713182910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=su3JXcVewNLndT6lYI2i/gAjWAva3xX2Ao5dVp2OUNc=;
 b=vmmZAHbkdjbqMRVCd0egwIZUVrt3o2l3CqIEhRlcXCmPX6AVcXm597dJpQeEhEbwoE
 pjjf1bDzOmEierHwT+tEnq6EYrWYiyXQ2Ycljg9DbGThd9Y26Jaja2bx+Ar0nVw0Z2RM
 hvgUpzfCktOLot3nQg07/KufXaJCrbttRaGT/D4INXzMW99D4BIXVKV/k9QL05AKmRZk
 FhF+Q1H4cyZPhCjamG452aPBHm/INLoeMAMQFJUWE1ge8XSTb5I7chAxkTMBnCgYMEdX
 4CBga0AlQOZT1oEU/i5PDr5BbnO6Jll89KfdubpSa5/8kmSv7UqvdUNa27444w+3ilxr
 518Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712578110; x=1713182910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su3JXcVewNLndT6lYI2i/gAjWAva3xX2Ao5dVp2OUNc=;
 b=m0UQYJvkpzgyMkjoNAJ1m9WFexIdpiISNUBVdXDfKCvAMpdJADVHAPoWptsNkKUi8s
 cytNxrBz+HBdD0bFu/WPZi+hQO8i9fYXLXIi8lWvjF947LgyxEEeiYEsbhOe/sq8jsOm
 2GraSOPl57gil6IhUU/IDXYY0+uAp1cBIO5EjSvBNKKNFEnqBGrPwqo1IRQt66RAR3PT
 a2wDJvFNVCILan0XkLGlb8Sr7HU1oCZai+x6cA8iSmIRBIOAmJl4In8tDyIgM+zxN652
 1wNnvAVN2aHPpfVF2/wOGcoxVfdPEYSiibYQOjvAXU0kDBjdmN4h4GZt5lamYBL3QP9a
 0uqw==
X-Gm-Message-State: AOJu0Yz5r5jh28aBY95nnom1jfSTB7nfg0XKkDiUDfKsJF+qRy54rjTn
 yb2ajk39Zx1kPps42LPEo/gS+H07an8vtPX6+KZbmNasl56vHfbofH03i65P/2eDMxuyLIrwDsT
 7mSV3LQ==
X-Google-Smtp-Source: AGHT+IGitV7fTdyyCVM1mWpnbVu90J8PRZZyr6IqycFwcg4yS74RQFZvfvsrnY7jOww4okK8KB35mw==
X-Received: by 2002:a05:6a20:9f0f:b0:1a7:96ae:b2d with SMTP id
 mk15-20020a056a209f0f00b001a796ae0b2dmr273690pzb.50.1712578107575; 
 Mon, 08 Apr 2024 05:08:27 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 x42-20020a056a000bea00b006e6b180d87asm6410478pfu.35.2024.04.08.05.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 05:08:27 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH RESEND 2/2] scsi-disk: Fix crash of VMs configured with the
 CDROM device
Date: Mon,  8 Apr 2024 20:08:18 +0800
Message-Id: <2abb4613ef6834de76f1167ffb11c732cc826d2b.1712577715.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1712577715.git.yong.huang@smartx.com>
References: <cover.1712577715.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When configuring VMs with the CDROM device using the USB bus
in Libvirt, do as follows:

<disk type='file' device='cdrom'>
  <driver name='qemu' type='raw'/>
  <source file='/path/to/share_fs/cdrom.iso'/>
  <target dev='sda' bus='usb'/>
  <readonly/>
  <address type='usb' bus='0' port='2'/>
</disk>
<controller type='usb' index='0' model='piix3-uhci'/>

The destination Qemu process crashed, causing the VM migration
to fail; the backtrace reveals the following:

Program terminated with signal SIGSEGV, Segmentation fault.
0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
312        movq    -8(%rsi,%rdx), %rcx
[Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]
(gdb) bt
0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
1  memcpy (__len=8, __src=<optimized out>, __dest=<optimized out>) at /usr/include/bits/string_fortified.h:34
2  iov_from_buf_full (iov=<optimized out>, iov_cnt=<optimized out>, offset=<optimized out>, buf=0x0, bytes=bytes@entry=8) at ../util/iov.c:33
3  iov_from_buf (bytes=8, buf=<optimized out>, offset=<optimized out>, iov_cnt=<optimized out>, iov=<optimized out>)
   at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/iov.h:49
4  usb_packet_copy (p=p@entry=0x56066b2fb5a0, ptr=<optimized out>, bytes=bytes@entry=8) at ../hw/usb/core.c:636
5  usb_msd_copy_data (s=s@entry=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:186
6  usb_msd_handle_data (dev=0x56066c62c770, p=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:496
7  usb_handle_packet (dev=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/core.c:455
8  uhci_handle_td (s=s@entry=0x56066bd5f210, q=0x56066bb7fbd0, q@entry=0x0, qh_addr=qh_addr@entry=902518530, td=td@entry=0x7fffe6e788f0, td_addr=<optimized out>,
   int_mask=int_mask@entry=0x7fffe6e788e4) at ../hw/usb/hcd-uhci.c:885
9  uhci_process_frame (s=s@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1061
10 uhci_frame_timer (opaque=opaque@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1159
11 timerlist_run_timers (timer_list=0x56066af26bd0) at ../util/qemu-timer.c:642
12 qemu_clock_run_timers (type=QEMU_CLOCK_VIRTUAL) at ../util/qemu-timer.c:656
13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738
14 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:542
15 qemu_main_loop () at ../softmmu/runstate.c:739
16 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:52
(gdb) frame 5
(gdb) p ((SCSIDiskReq *)s->req)->iov
$1 = {iov_base = 0x0, iov_len = 0}
(gdb) p/x s->req->tag
$2 = 0x472

The scsi commands that the CDROM issued are wrapped as the
payload of the USB protocol in Qemu's implementation of a
USB mass storage device, which is used to implement a
CDROM device that uses a USB bus.

In general, the USB controller processes SCSI commands in
two phases. Sending the OUT USB package that encapsulates
the SCSI command is the first stage; scsi-disk would handle
this by emulating the SCSI operation. Receiving the IN USB
package containing the SCSI operation's output is the second
stage. Additionally, the SCSI request tag tracks the request
during the procedure.

Since QEMU did not migrate the flying SCSI request, the
output of the SCSI may be lost if the live migration is
initiated between the two previously mentioned steps.

In our scenario, the SCSI command is GET_EVENT_STATUS_NOTIFICATION,
the QEMU log information below demonstrates how the SCSI command
is being handled (first step) on the source:

usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state undef -> setup
usb_msd_cmd_submit lun 0, tag 0x472, flags 0x00000080, len 10, data-len 8

After migration, the VM crashed as soon as the destination's UHCI
controller began processing the remaining portion of the SCSI
request (second step)! Here is how the QEMU logged out:

usb_packet_state_change bus 0, port 2, ep 1, packet 0x56066b2fb5a0, state undef -> setup
usb_msd_data_in 8/8 (scsi 8)
shutting down, reason=crashed

To summarize, the missing scsi request during a live migration
may cause a VM configured with a CDROM to crash.

Migrating the SCSI request that the scsi-disk is handling is
the simple approach, assuming that it actually exists.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0985676f73..d6e9d9e8d4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -160,6 +160,16 @@ static void scsi_disk_save_request(QEMUFile *f, SCSIRequest *req)
     }
 }
 
+static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    if (s->migrate_emulate_scsi_request) {
+        scsi_disk_save_request(f, req);
+    }
+}
+
 static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
+static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    if (s->migrate_emulate_scsi_request) {
+        scsi_disk_load_request(f, req);
+    }
+}
+
 /*
  * scsi_handle_rw_error has two return values.  False means that the error
  * must be ignored, true means that the error has been processed and the
@@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops = {
     .read_data    = scsi_disk_emulate_read_data,
     .write_data   = scsi_disk_emulate_write_data,
     .get_buf      = scsi_get_buf,
+    .load_request = scsi_disk_emulate_load_request,
+    .save_request = scsi_disk_emulate_save_request,
 };
 
 static const SCSIReqOps scsi_disk_dma_reqops = {
@@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] = {
 static int scsi_disk_pre_save(void *opaque)
 {
     SCSIDiskState *dev = opaque;
-    dev->migrate_emulate_scsi_request = false;
+    dev->migrate_emulate_scsi_request = true;
 
     return 0;
 }
-- 
2.39.3


