Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E9EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfm7R-0007qj-KS; Thu, 29 Feb 2024 14:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfm7I-0007q8-Pr
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:30:58 -0500
Received: from snake.cherry.relay.mailchannels.net ([23.83.223.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfm7F-0002Ve-QX
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:30:52 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9C14DC300F
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:30:47 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B4075C2C35
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:30:40 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709235041; a=rsa-sha256;
 cv=pass;
 b=hwDRD1oPrNmm5qaYKFKZiD9fxvIszt4tFEl6gC2a6JIeOr/TiQ+AXo0ke2dz88A0+nK3bN
 flHSJHV0ZyY0KBJQD/jQhjjzaTNjZGQnmLVVX1tCA8RFcdVwIpAhEt9N8be+z1m9lCW8V3
 z0TIMOFVPwf/v0DQi/WSawVYgiL88j2S9IgT9v5ymtzzKbsT8xT9NRbWlLtcx9JYriPQ0z
 5R73ncFvYNZOXdpkINOOqKp/fan9Mnem4wjuUknHdhXn8xEl1rOGvZffyQ0PGs3VL0hlra
 zpAMyprREBGwU21sn0sfZGRqNH1TGE5N1Wt4rMuAdLQ0k8ciN9WJJUnL2gOdCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709235041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=2kmRW7tu2HS6nqr1LWKCPqT3oAZ0UKCuhb9H+LVLpds=;
 b=GJqeq/emJnLE7OuLUMoT6Ot0jBYZZS4hkUhXTLZsf4f1//y+W20QeKFPQiOIwpR0PdhH4P
 zd0eNVZsp0Jz2b0U02lUTz5IYG5eLmL78O6++bYKexMv67J/Bnurs3qNqLOYTMtPImkruN
 Tanb2ZS4qUHjRl9eJs3p6+OG07J8ooeuGEPKsQpXWXs1jHueEtd0si2X4e1uTgGS0uNmp4
 NJ1XdK9CaaWk9hev+AiXzwRKCQ6C9+IWp/AFwMVioEGSH4L2bbxxS2TVeAzcaG7k8KNp/J
 CjUd1P3XfWT38y4mSMTXN3pGpk5qDeMBdHMPhyUh9SOomLwgprEC+ofxrzQSLw==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-x7ntb;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Macabre-Unite: 24af3bd252bdb797_1709235041228_3012698333
X-MC-Loop-Signature: 1709235041228:1344621473
X-MC-Ingress-Time: 1709235041227
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.104.192.87 (trex/6.9.2); Thu, 29 Feb 2024 19:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709234949; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=mo92Repts2IfyVPl5oy5PvqTw6NTDwXq6KboMcx4mNsHX8qBgaVpto8ugRq/Ht1emJZ+3qVN+xa/P
 3JG08hULEs6eIImdfmdQfoiaEmlQwwcdUIDQXlLHI3mT05GyZVXMGrz43ykxU5T+yZjca4cwJUyhp+
 9hPBDRn6f3zTKU84qLjinAZiw8/KuOknNLIbXYoRl8hd00nq5CoL9Dn0D2U9PstAa9UPCqZq/D4SW9
 lGtKEE+Ev03ieAswJVvRFNemCBkQYt6OHK3IZI+YWlzsVXHfhMEC4O1mQZdj+My6LeBlJPvsmByFg9
 DE+qhmsZ1eJfidEMHcyEzYTudUBXFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=2kmRW7tu2HS6nqr1LWKCPqT3oAZ0UKCuhb9H+LVLpds=;
 b=quj/uqziApRMLkemCYuMKGfdk4TndhCxDEDXKPd5y3OoB4/ROJqkRXIyN2TzNoM+KgIArQG2mJQwu
 7CbByTZTGqX71jh4PQDJtBJkYlyI1zgOeGEMTe4ZckH59M+0yzDAgQyZL+Rdj3dLhvpLVH7ctpOKfb
 Lg+ugZ31Dx23a+JsE+uyJzI46vuD3DH5TK6VIwgDdUdUZ4oIo6SErzMJuLpEKBbKo9isvZ85b+k3Dx
 DA/Miv/eAc2QRBWjWRIVkGxblBawCEHFjC3xLC7ZnPiSBXPvlZT8gZ/Cfc+Ap4YWTAHPCNfpjhhMhh
 hXOLVStz52VNHISe1LzwbByICcZJsTA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=S0pXWcLy; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=2kmRW7tu2HS6nqr1LWKCPqT3oAZ0UKCuhb9H+LVLpds=;
 b=snb1zCbHevk9tBN+QmVd3P0GovzrKun4xGYRO2KGQQoBQcdcFVdxrwNqSIstEEmGVoow2YVccTwuE
 0BIOQ75h1oqeVnLBhp0b5Fhpxh6HkHdgCJD8qm/4U1HpP3TNmw9RZwPzwS/l2Dz/VfRM11y7uvCx3S
 ueV8HR9L3c2YOYok=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=2kmRW7tu2HS6nqr1LWKCPqT3oAZ0UKCuhb9H+LVLpds=;
 b=d9kL0uc6ov4WJtcMmLSOeGyCmLbO01lU8bAyLoMLnhmSWNvD+hTlp8zRsBNVepIT0bxRY74CltrY1
 v4xrs2fQjqqK386eXhrBbgnUCjQrP3SeDaByj9ycuxaoIGgqCJVe/8njP6mMNXLk5QAPmSqPrbmlmz
 eZhUfASLyT0co1dzEoObW703hgMRVqkG75LWEwL+Y44tCtElnYjETHCtKB3pgiaNoZX0zEIjebZZK+
 bdtXdasK97uQD10GhxrGgG6yfvQTKd8glFum4BkoTNGo+q3S5Qr//26iE8f6RE9lZFXOk9V7vxorlY
 4YvqdkFAao9UA5hMLQOV9WpkOAe2HjQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: cd4380a2-d738-11ee-b660-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id cd4380a2-d738-11ee-b660-9b9d9be6ef2c;
 Thu, 29 Feb 2024 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2kmRW7tu2HS6nqr1LWKCPqT3oAZ0UKCuhb9H+LVLpds=; b=S0pXWcLybObbQXHFBR/JqdBYDI
 gzF8t7Gr+qSCEFy6W9rVZG9Y0Cvur5CjA7LXNjBz9olDaEaj8uDr7g4/wNMiWsr2gkaGYTsmYjTJ1
 qQkwewUIz7nf9ZmMtg8N/rteFe5/kO5taC3Z2YU310pPoEKFvwOlY5atJIMo+Qf8nIc9E9gDz2LFA
 1cpoW73tmRsbxEER+2KWSKfLLnSy7H0Qp6gl1d+d5Z5c+cakqQ2Zm2oPZBOPefwrCeczs55NJhKQQ
 ZzX95H07iQEMC05Uz5w9h9G7TVQ+YBPfPgo7xpQEKzfwRIMQ0dTEi5CnKr1uzAbJi/9JGDQ2xwWpL
 y8P6zBeA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfm70-000NYU-0Z;
 Thu, 29 Feb 2024 20:30:34 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] hw/scsi/lsi53c895a: add timer to scripts processing
Date: Thu, 29 Feb 2024 20:30:31 +0100
Message-ID: <20240229193031.1677365-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.171; envelope-from=svens@stackframe.org;
 helo=snake.cherry.relay.mailchannels.net
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

Some OS's like HP-UX 10.20 are spinn

HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
under certain circumstances. As the SCSI controller and CPU are not
running at the same time this loop will never finish. After some
time, the check loop interrupts with a unexpected device disconnect.
This works, but is slow because the kernel resets the scsi controller.
Instead of signaling UDC, start a timer and exit the loop. Until the
timer fires, the CPU can process instructions until the timer fires.
The limit of instructions is also reduced because scripts running
on the SCSI processor are usually very short. This keeps the time
until the loop-exit short.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb..0b6f1dc72f 100644
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
@@ -1152,13 +1161,8 @@ again:
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
@@ -2197,6 +2201,9 @@ static int lsi_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        lsi_scripts_timer_start(s);
+    }
     return 0;
 }
 
@@ -2294,6 +2301,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
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
@@ -2313,6 +2329,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
+    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
 
     /*
      * Since we use the address-space API to interact with ram_io, disable the
-- 
2.43.2


