Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7732C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 20:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfnGX-00063X-4X; Thu, 29 Feb 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfnGV-00063L-AQ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 15:44:27 -0500
Received: from cross.birch.relay.mailchannels.net ([23.83.209.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfnGS-00028b-OQ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 15:44:27 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 1660B4C3C83
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 20:44:22 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 52BB94C3CE1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 20:44:21 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709239461; a=rsa-sha256;
 cv=pass;
 b=4gKxnpcZLLO8SWoXsv8aBn7tep9jboJMJV+mGhPvrZzww9EIG+H/jYDzs826W692eIbe/q
 brXxaQ0X8zqFRKMVKULCBjXZ14B0jltvGoNENx2KvvnWQL6cp/kb/V7i+k6D5+vhoBwsEF
 mvudTHQ4NpKZZMomKdFR751j0mOt3INkmWyh5K0xxED+TqZrYdNdkaJ3VFouL/MuQw/zw7
 9BnGL7613Cem7jMscqiLpna3ZQKJlXC0JpsM0SijoILnrGhOFvNG4+YR+AWWhd42SulupW
 TWt5I1N0ft3Q9/vCiEGifjMTJ9KfYqzUkT4/iz7+6BCRGmWa+VWaHZIOoklsSw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709239461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=azc/tnmZXUBzJN2Uw/DZPIZiJd/8WhUCOFYIKsmNJXs=;
 b=6R4HEqh8demlfuv4rwhCUF16egVNeXEJ4p1bn+rddSPQghx8BdqcEu71sUTvKzyoWkGdm/
 /Ya5cuV6IM9eIRT2PUDf0AKDE/elLZKsrhNlrzq7slY9Vwy2KlVeqreeBhZnQjJR5EC2JI
 BiDUguKyx0Pnvcg3ZMOAeg0ikI9xCc6fwn8UZtlG48479KxnjSgB3e9/kHllV1LHaRpqha
 +ID54Rxiqt5Nf7NdLvLN3E6cjdvksk8Qb7HqJkdvc6cZv2PSeW0tXjjqE9LbinCBVLulfV
 2N/TEuFAaQfj7kBh5G/l8NM6wQgA9M+lF6ShDG+7xAzXpzQGLrOSqwHi8tvx+Q==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-9jm27;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Abaft-Trade: 4bf8c73362886e4f_1709239461836_4089636357
X-MC-Loop-Signature: 1709239461836:2520209543
X-MC-Ingress-Time: 1709239461836
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.116.14.15 (trex/6.9.2); Thu, 29 Feb 2024 20:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709239435; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=IdTWgNO+tjPCaBf9DYmbkwSrJ2c2WqzF6IdoPReTZpkGN/nwasgZ7+QWI90f/vT8Sv+lgeKyeEI46
 8aIUbGW3kkdPPHmKtigg+t7y22+XN4tUzLVj5Xfmvhtt1eaHJik31LvHfwRSlFzpylP9Oyzv95IMd2
 QRC3GQI/7p0ikpn4XE+l6af4PplZU0AJ1JAVz8J8+B4b1EtleiqoBl9/JfumGykkF0wSz8KdgSgZPc
 fxm9dpARG6w4Zfa80An+YgbQP1XOgA8RtCdKFct+hlA/kAXcGjQfEl9nIuVGmgJBUiD0Riu+oXi/sN
 j3ibJNj8UVsn8cwEP6Ve/aJZmwuNeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=azc/tnmZXUBzJN2Uw/DZPIZiJd/8WhUCOFYIKsmNJXs=;
 b=eCwyE1Tkn05VL1e2EJiipx9XoTR7uvU2MnybDEqpdf7DInc+suhs0CUTmq717CDd6QXoMk39cLhzi
 7wEGRb9J/QNsTsGnkWujTDK00gTxHZtKDxvpYWY2fIojdf93bprxx/xl4tUofuwcX4b4xb4xdPqRBL
 lxadCMhVvr91LZ5JHMAiOpD39b71/wMZDwBvowV7aTWQCGwbq/xatQhz9qvC3zAlHiWJsPv19KTVbA
 0VRCJWcJ2DKRsgsoZ2JZzAFWQMocDYftS86d/OEeubD9hH0MQEhvTRNJZWInh7gFn/eYFj+5as2t6q
 8qw3h1mladbaHvGcF9ut5/YlFKaADRA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=WVHijQ7Y; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=azc/tnmZXUBzJN2Uw/DZPIZiJd/8WhUCOFYIKsmNJXs=;
 b=TMpGEGqnIM9Hiqb/AC/kW2j/VxVHgkv/PVCCHl8dnPhbd+lHA7JO1vy8Z0H68GO9Vmk2YQ8dC1RqA
 XbkOCJmrlts2JxkvBQK2nWF4hukHE5b+owQMM7Ll1mRJRG19eedCnw0yo8OMI++kmShbXb2c4KtHQC
 cFbEWLp8VuzR/RP8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=azc/tnmZXUBzJN2Uw/DZPIZiJd/8WhUCOFYIKsmNJXs=;
 b=FULkPHGlazq7BZWpU2yiIcZ/w1T8mPn4iU9nwcPWbpEFwySISSPnfrxklMKvkvsm/JVtDv8wCU5c9
 XoijCH7bHgqIPSooQWEms1Okbj/UxAr1EV38mwK67X6+Slw8viDpuOZmAKw2qfLjAbkkrpTjRnPd22
 AgIJXbFWGVyr6SatEu5Fkfh/ER1ZZhA9KKdF9lwhIhpmwXyeM67zgE5IVCUd1CFjQljfr64w3Drv0T
 pjQ9gxlKMr5cms1mt/kyDphqQmDgYoMGptP37PquXlUL/F+zljBRkzpcvnUN2oQ9Za2/yQcJqIjzWn
 A1pTZ6GG/tE0BwBnDF6Rro6b31L2lGw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 3e30dd5c-d743-11ee-afbe-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 3e30dd5c-d743-11ee-afbe-eda7e384987e;
 Thu, 29 Feb 2024 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=azc/tnmZXUBzJN2Uw/DZPIZiJd/8WhUCOFYIKsmNJXs=; b=WVHijQ7YDS7fn5Fox1UlvRMujk
 1vTQNViLYssw6JNSD4JjDYYFPeWBPPYMahDzuMBHFmk8MDrVtKwrjzcEwuqT9Xt/eTZhnBYyN28zl
 lBM024ScAay6IaWs5268uQJJkTzedZKo0Ks5NqB1eU14N5Pn8yHx6fLCSaunAEi3oYRvbzt1oqROT
 umb22m1ZpKy4z17AAP23hdgoVSjEfo7DGLmvej3fanZL7HgLrt6XFm/V70mDB0ONT+9xwZVSX1SOj
 5NZefOOZu2muSUqBr+mo+qCnWFHSjAgjospYd8GD3/DojWlZ+w5MsI4HjyHuq0C9olhbqazGToEa/
 dkVvLY8w==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfnGH-000O9M-2S;
 Thu, 29 Feb 2024 21:44:13 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, BALATON Zoltan <balaton@eik.bme.hu>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2] hw/scsi/lsi53c895a: add timer to scripts processing
Date: Thu, 29 Feb 2024 21:44:07 +0100
Message-ID: <20240229204407.1699260-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.46; envelope-from=svens@stackframe.org;
 helo=cross.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
timer fires, the CPU can process instructions which might changes the
memory location.

The limit of instructions is also reduced because scripts running on
the SCSI processor are usually very short. This keeps the time until
the loop is exit short.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
Changes in v2:
- update comment in lsi_execute_script()
- reset waiting state and del timer in lsi_execute_script() to
  handle the case where script processing is triggered via
  register write, and not from the pending timer
- delete timer in lsi_scsi_exit()

 hw/scsi/lsi53c895a.c | 43 +++++++++++++++++++++++++++++++++----------
 hw/scsi/trace-events |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb..4ff9470381 100644
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
@@ -1127,6 +1130,12 @@ static void lsi_wait_reselect(LSIState *s)
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
@@ -1136,6 +1145,11 @@ static void lsi_execute_script(LSIState *s)
     int insn_processed = 0;
     static int reentrancy_level;
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        timer_del(s->scripts_timer);
+        s->waiting = LSI_NOWAIT;
+    }
+
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1143,8 +1157,8 @@ again:
     /*
      * Some windows drivers make the device spin waiting for a memory location
      * to change. If we have executed more than LSI_MAX_INSN instructions then
-     * assume this is the case and force an unexpected device disconnect. This
-     * is apparently sufficient to beat the drivers into submission.
+     * assume this is the case and start a timer. Until the timer fires, the
+     * host CPU has a chance to run and change the memory location.
      *
      * Another issue (CVE-2023-0330) can occur if the script is programmed to
      * trigger itself again and again. Avoid this problem by stopping after
@@ -1152,13 +1166,8 @@ again:
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
@@ -2197,6 +2206,9 @@ static int lsi_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        lsi_scripts_timer_start(s);
+    }
     return 0;
 }
 
@@ -2294,6 +2306,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
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
@@ -2313,6 +2334,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
+    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
 
     /*
      * Since we use the address-space API to interact with ram_io, disable the
@@ -2337,6 +2359,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
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


