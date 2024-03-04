Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2816C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBK5-0006Ze-Qm; Mon, 04 Mar 2024 11:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhBK3-0006XP-MI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:37:51 -0500
Received: from cat.pear.relay.mailchannels.net ([23.83.216.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rhBK1-0005Q2-Iv
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:37:51 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 17866941A52
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 16:37:47 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id BE9249416C1
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 16:37:45 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709570266; a=rsa-sha256;
 cv=pass;
 b=sMcgfBgP+DOqpuvi7uTbz1b1eZboDtjuV4zU3xZm34pdJarj6vsxKIC16mNz+wa1mww1La
 X6OOK906CTqc+eEG9tW75OQ1w8H5kHL+FQKvatNI6yCkv9I4asBTAfOhObQzZo+1GyVj1C
 YRRdbhhuLILk79eQ2uF0krqwTNxeOduxAYQBHUPiJR2xXVWuVyvlR3Gooqjvk14uJxzSqj
 gt8/2vucUw3vOeBi7tscdAlXLEkSq4utwJgAbPMISWUfwHUUuwHIvxokm16EJZz2rr6cMI
 LjjX5ZoZUR0ba12PFaDNfinzivkrdSwlYX3wj91jDJjSb//5kNotiu1kGidm9g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709570266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=gB0IhY9Ao3jP3YQjuX0HtP6VZjD249KqUdRf+X9XPAo=;
 b=UOb34Qx+Hb8EHrKdEViscc81uNtRYdKcPb3Rn9f+Yf4tGWAM/mdlERG+c4BL63mBeLNWQL
 zVVTs5bHyyWahZDRIeh63d1aE7Qyi4rSb8N4voM/eSuu6/O4lifbniJS7zLQCMkHooPLMp
 7i0F/Av/YZN8D8ZkteNA/dJ3P3+p1H+oJ9svP7/cYK7KMv22Cr2G3uxvlOilF2quoKQqys
 DRh34Po8gSMpm2zJVwSormq3aC+MObMvApdI+utBpCDY6furMrTs8Plgbp/k/+NGE7/5Bp
 2hvXs6aszJ87oz7DpSqm+PKk6gsL3T0kKFzJenMHRAp5+xZivEwJhRbLSYqYFA==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-t8xjk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Blushing-Daffy: 2795bfcd4fa4ba84_1709570266325_1946002481
X-MC-Loop-Signature: 1709570266325:2442786242
X-MC-Ingress-Time: 1709570266325
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.192.177 (trex/6.9.2); Mon, 04 Mar 2024 16:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709570230; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=mDiRdVUpUG/LpdYeFZCAEWlBKW35UggDJ5bR7nREvV6YVi+pGbk4OjU3TstAJ3WspRHrB8PvDNXIt
 arGVl6I9cPjh3Bhh1XX2jCRV9GRRdV+orfgZBppGf5JusxXq3bHy9knAUrtSBgdk1vK/vqwBYiQ032
 Nn2dZVyVR039L5/HZYISJnZvieVIk4GU1grDvygQnhcKUYqo7XARuXKRVEzrU+YjNj3XoEpgPYRfrQ
 N0bIi6tIXN4MNsXiSE+uoKKw92+co/JMJf64x+6hdyAID71rFIuTuzs73Dw0XTmKrFpbh79aD7Ydu2
 cQlyfgzb3k0SF+KkKmjrH0RmSyKe/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=gB0IhY9Ao3jP3YQjuX0HtP6VZjD249KqUdRf+X9XPAo=;
 b=S/IZE9Mxb8Ai5CFilemmiuvsMe+e8xZ+9Fw4ojzFr+cMgtmddHFB9verY96bAr8sCEFCPuTo+yp42
 RUkaR5LNKrIOUP6gtUAt4S2HAf8tZh4hw1VmAB07QYos5x/Dmp/vOBEEmYDYqfYezqT0ccPA2Xo48X
 xmZOMUUZM8sQIZNKXH8vk/+hGjiGLplz3d6b5gl+6aXCcdLZY5H5FRC8azEV2+oPoad688EL0eOVB8
 0FMA+Iy0IxkhyIf77mw5uMzUmtE6nJcXriAH1DaCHsJdfJtQ6lt5zw3nEY1gaYcg4JNdAU99tG+wRk
 Be6Wn74sVt78Vgvtt8HBrTrEV0xNRMQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=BfQYzLsf; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gB0IhY9Ao3jP3YQjuX0HtP6VZjD249KqUdRf+X9XPAo=;
 b=pbu+yf6PyeIem97Ep4GT3oJ3p/v7hA40atvuxtbYWBZW77fKjJ7km36xdTzaoZkA+w0MuMIYvxw/R
 ylkzOpFJhwu3kM9b+ISXb1iDQdygDt55PbyMShY6EvpJ4UBjtOnXf0w9C2ksfA4WcCFhjf2cBAfzFB
 Qt60wxTN7W31g0gU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gB0IhY9Ao3jP3YQjuX0HtP6VZjD249KqUdRf+X9XPAo=;
 b=LMB+pFJbtIclF3NPhSj/K8FbL8n8QXijospG9E3zvZLxDa0/Q3Z5rpZlktSJF3L+e9Rj5CNx4Ghbn
 64E6DQuQMdDToHuChCenVrZoWGOg7/p+qim6X4h5zAInK5l+yEaOKAgJjHh/QzLXi74qzWeXa4U31Z
 +7Q461J6G9MPCZWmVhgZZyBWVdY8IZGZVZ7KaiAQWTxLoOuO72BVwJnzkFv0zTLHsP4fiI4l+Oy5+B
 8a9paZ8Fefevd/WYwPOU70gMEiSz4N0Xk9owK1MCwNcsOwg2NnKrFC/4ymGrNLtT3kN0hlqLz+DTus
 hWxVegPhF4QFjjS7SFZf1YM9BZ1P4/g==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 6f60aa10-da45-11ee-b017-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 6f60aa10-da45-11ee-b017-eda7e384987e;
 Mon, 04 Mar 2024 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gB0IhY9Ao3jP3YQjuX0HtP6VZjD249KqUdRf+X9XPAo=; b=BfQYzLsfun3oBAbLzzDUQniOAL
 LXeordbThuOl9Jh8KIr7d8KxZoaNvUOrIQSTiQiwG3qtw+2JTSm4vTrB37srQxwIX2zjhJxuAvUqD
 q+f6arp8i5FeAkIOfo3kHaxxxD8D1fHUJULl1wfg05b0ZNLZF7gV7bsentVIHDa851fh3CrydVMC2
 XlBvO/iuKLaOflMYfOK4zHi19GCq06FvMGE5TjY78rjDxc9Duu2ABxHlmvQGJq3nmUTe4vfHrHDYB
 WXhYsP6wfch14BZm46Fg9XC5TYnJXUPEsTt0QzVnZcHPavVf5pguImey8uIyVgNVHqnGO/iWzRb9s
 pemA87DQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rhBJi-0019h9-2N;
 Mon, 04 Mar 2024 17:37:30 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, BALATON Zoltan <balaton@eik.bme.hu>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3] hw/scsi/lsi53c895a: add timer to scripts processing
Date: Mon,  4 Mar 2024 17:37:27 +0100
Message-ID: <20240304163727.2320861-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.31; envelope-from=svens@stackframe.org;
 helo=cat.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
under certain circumstances. As the SCSI controller and CPU are not
running at the same time this loop will never finish. After some
time, the check loop interrupts with a unexpected device disconnect.
This works, but is slow because the kernel resets the scsi controller.
Instead of signaling UDC, start a timer and exit the loop. Until the
timer fires, the CPU can process instructions which might change the
memory location.

The limit of instructions is also reduced because scripts running on
the SCSI processor are usually very short. This keeps the time until
the loop is exited short.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/scsi/lsi53c895a.c | 43 +++++++++++++++++++++++++++++++++----------
 hw/scsi/trace-events |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 949b2bbd10..3b5e76bbd9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -188,7 +188,7 @@ static const char *names[] = {
 #define LSI_TAG_VALID     (1 << 16)
 
 /* Maximum instructions to process. */
-#define LSI_MAX_INSN    10000
+#define LSI_MAX_INSN    100
 
 typedef struct lsi_request {
     SCSIRequest *req;
@@ -205,6 +205,7 @@ enum {
     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
 };
 
 enum {
@@ -224,6 +225,7 @@ struct LSIState {
     MemoryRegion ram_io;
     MemoryRegion io_io;
     AddressSpace pci_io_as;
+    QEMUTimer *scripts_timer;
 
     int carry; /* ??? Should this be an a visible register somewhere?  */
     int status;
@@ -415,6 +417,7 @@ static void lsi_soft_reset(LSIState *s)
     s->sbr = 0;
     assert(QTAILQ_EMPTY(&s->queue));
     assert(!s->current);
+    timer_del(s->scripts_timer);
 }
 
 static int lsi_dma_40bit(LSIState *s)
@@ -1135,6 +1138,12 @@ static void lsi_wait_reselect(LSIState *s)
     }
 }
 
+static void lsi_scripts_timer_start(LSIState *s)
+{
+    trace_lsi_scripts_timer_start();
+    timer_mod(s->scripts_timer, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 500);
+}
+
 static void lsi_execute_script(LSIState *s)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
@@ -1144,6 +1153,11 @@ static void lsi_execute_script(LSIState *s)
     int insn_processed = 0;
     static int reentrancy_level;
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        timer_del(s->scripts_timer);
+        s->waiting = LSI_NOWAIT;
+    }
+
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1151,8 +1165,8 @@ again:
     /*
      * Some windows drivers make the device spin waiting for a memory location
      * to change. If we have executed more than LSI_MAX_INSN instructions then
-     * assume this is the case and force an unexpected device disconnect. This
-     * is apparently sufficient to beat the drivers into submission.
+     * assume this is the case and start a timer. Until the timer fires, the
+     * guest CPU has a chance to run and change the memory location.
      *
      * Another issue (CVE-2023-0330) can occur if the script is programmed to
      * trigger itself again and again. Avoid this problem by stopping after
@@ -1160,13 +1174,8 @@ again:
      * which should be enough for all valid use cases).
      */
     if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
-        if (!(s->sien0 & LSI_SIST0_UDC)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "lsi_scsi: inf. loop with UDC masked");
-        }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
-        trace_lsi_execute_script_stop();
+        s->waiting = LSI_WAIT_SCRIPTS;
+        lsi_scripts_timer_start(s);
         reentrancy_level--;
         return;
     }
@@ -2205,6 +2214,9 @@ static int lsi_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        lsi_scripts_timer_start(s);
+    }
     return 0;
 }
 
@@ -2302,6 +2314,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
     .cancel = lsi_request_cancelled
 };
 
+static void scripts_timer_cb(void *opaque)
+{
+    LSIState *s = opaque;
+
+    trace_lsi_scripts_timer_triggered();
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
+}
+
 static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
 {
     LSIState *s = LSI53C895A(dev);
@@ -2321,6 +2342,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
+    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
 
     /*
      * Since we use the address-space API to interact with ram_io, disable the
@@ -2345,6 +2367,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
     LSIState *s = LSI53C895A(dev);
 
     address_space_destroy(&s->pci_io_as);
+    timer_del(s->scripts_timer);
 }
 
 static void lsi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index d72f741ed8..f0f2a98c2e 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -302,6 +302,8 @@ lsi_execute_script_stop(void) "SCRIPTS execution stopped"
 lsi_awoken(void) "Woken by SIGP"
 lsi_reg_read(const char *name, int offset, uint8_t ret) "Read reg %s 0x%x = 0x%02x"
 lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x%02x"
+lsi_scripts_timer_triggered(void) "SCRIPTS timer triggered"
+lsi_scripts_timer_start(void) "SCRIPTS timer started"
 
 # virtio-scsi.c
 virtio_scsi_cmd_req(int lun, uint32_t tag, uint8_t cmd) "virtio_scsi_cmd_req lun=%u tag=0x%x cmd=0x%x"
-- 
2.43.2


