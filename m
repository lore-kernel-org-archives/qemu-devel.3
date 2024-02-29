Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46364C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjfr-0003e6-W6; Thu, 29 Feb 2024 11:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfjfq-0003V2-5Z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:54:22 -0500
Received: from khaki.cherry.relay.mailchannels.net ([23.83.223.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfjfo-0005zT-5C
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:54:21 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 9C0C23629CA
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 16:54:17 +0000 (UTC)
Received: from outbound2.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id E3A8D3624D7
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 16:54:16 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709225657; a=rsa-sha256;
 cv=pass;
 b=1shaI0/2HyCKpQVf95gAbAt5nrZN84k2MtbVSLLUjnjDenGC9KttMafD9umLYz/naRPYNm
 WNNav/jbrT12mb2yyadxtu0gZqsHGa9nVk8XIbq+qEDWssExi+KSXUVBF0KXMHpbZBa7Q1
 EZHBXBKaTfYt//ecEvR3ze7zCAsTNVBGY61HK56EAasztil6YXgkooMdyXbDZzz+rbk6mN
 HdlIW5zZIKwFx09ssYktauHUWycUxrwSOefNhY0KZHFoGZGy1HGeDzCvLEGbMqT2j2/3q4
 Hq8a7878M+JcEwEm6w3yY8XWKplxFRFuDk8QVRqVA9Yrh/4643p/lxoJ0qziUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709225657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nA2xkDuqCCgz0FfbxhW9l31Tfc4Ww2nLCHcUmt0s7jc=;
 b=Ox8mG3bu9UJY+KDNuWcY0PHjStVZ74EgxlOBV9/8ExTuQodErIg6vnb02U5MBn+EK8sU+7
 DMOQEvpeuO4z27Bil3AjjX7/RMZHUp6vGAXWEf8f/xjc+xxwkRczJG/tvuqRcp0VhDimB4
 fyP3jTOgR5Ioq0vEbv5/woK39pgFKctuhIwAlL+XBUopS761Ow7WFCZAtsAbuWdI7yL9cI
 C5hXWJxq9GU1K2radGuzTQTZTR4rouMiJSPDyWISQZ/mONCrF6B7ZyiyhJcusrD+RgaBz9
 5YO4Uq6xUWjCYXBySw/a21dTRLywOW+vcDz9/oKZHUuss/wXwAZ2Wjkf8owumA==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-9l492;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Juvenile-Bubble: 0896042a42aef846_1709225657432_1650489422
X-MC-Loop-Signature: 1709225657432:3975064172
X-MC-Ingress-Time: 1709225657432
Received: from outbound2.eu.mailhop.org (outbound2.eu.mailhop.org
 [35.157.29.171]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.101.14.227 (trex/6.9.2); Thu, 29 Feb 2024 16:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709225566; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=XIQ/ZkhU46cii25I8nh0NKB6irxvQDhogyrsx+tVVxcYZLWhbCqJupDTWWk2/liJxZeiUDxXn6IRh
 wUwD5t2NxKUapYilenhRyaCERG611Ns3QJKuOIdcK4dngv9hQUDdEyUD355pUzxRVIdMRjGZZgFDWA
 VTkG1vGgJdnqA+TaA5pqeU8G/UoCYgyqAPFz4oLlaj87XW8Isq1EwWYXjK2+v0o2xJXSkPgE6tOseX
 9CsM0Wf/YSlchiOZT7AMfSAQrQkBCQ1s0yBRUz8KqjVd/qXiU78TWDKCW12M4y7X4xvcVJrf4q4Ndy
 LsKSZGnKc2ln4lThNlsMKcdmZoz93Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=nA2xkDuqCCgz0FfbxhW9l31Tfc4Ww2nLCHcUmt0s7jc=;
 b=mZtLb8ozR7zd3dZAdWvjb8sQbo7OJjmsxebPeyk8Je83OSn0SAjZeOtZW2I6R06GN6qJjEd3z2O04
 p9tk4jA2NASWw3e1MRChMFn88ABLvNVQOsFrNQIoXW4So4SSe4dc65yw5XZE9AUBjZi2ApoxE/AaEi
 Ee+/1/FwVpU9mjXsStMnvLusjBMu4x3VU+dhZETnpFz6yGE0HehF0BXj3ZTueLhjoG3/+uZRmSWvYU
 lBEhIZBl1kScPFNJE9VR4A9Wc+BJgi9xgvosUfR93X1icFUkYj+BY4VIRTwO1pkYt+4VHp4x/jJ+9k
 MuwguV1ylf0iI+EpzcE9fF389hSnWAQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=ezHgkVNq; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nA2xkDuqCCgz0FfbxhW9l31Tfc4Ww2nLCHcUmt0s7jc=;
 b=UU+l5CE7OGIlvu974YoGtgE2z2uY9HA9fBBV33jDdI6qKFPvpzT5vbs/r3YHLthk2yHF1Eae3oTB4
 HfaodS/d/8pXjCmVIXmmn2umXl/V7LHODRDSjcOeuNlRCjeiKwkHND8FOdYmboIUxm++mZ9wIoEiX2
 PgqmVMxqOCd6vtBE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nA2xkDuqCCgz0FfbxhW9l31Tfc4Ww2nLCHcUmt0s7jc=;
 b=eA7UQjkGzQDPDhW850I21G0MNNXBCK32x7u8105ztZ63iYOWbsGV+BK1fAKJESX8jPzZtO8GdyLfa
 SfQIGAddLmrmmWlF3Krca14VOGKX2cLAVpUFpZOLdH0iAC/72N31n9KIogJ8HGlASJNvXIo4WRfDKP
 y5GfjhSqXqE9t8ilqHrQF9jTISLZcPw9+xF4DNWXL9ONO/b0laBoIEKVtehwyPfi4QDoAoKc785DD8
 EWm71Gg+W8/mTAJE0tqsndGFx86fZKnllXRkp+PnzpkRtqWmjBvh/pgBGhYOBpnMamy5Rxh+hecIPf
 p9FBZN7yvNRtML5uwfJ8MytviXBUILQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f39ef256-d722-11ee-b65e-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id f39ef256-d722-11ee-b65e-9b9d9be6ef2c;
 Thu, 29 Feb 2024 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nA2xkDuqCCgz0FfbxhW9l31Tfc4Ww2nLCHcUmt0s7jc=; b=ezHgkVNqhUjJVhJpNVhydhcgu2
 rn/hJGRdAtSFFDW0SbW9d2fbJdU91rp/zTmAsUgivsxBu5c3S7cch9gxigwddXXIBvRSRj6Y9Ph84
 nkzzRBBGzLt7gJtUjPTY/VjJiOp/jwLRi3BgHoCa+xl5KD/crWrxAjMaTqSo8U8yhrH+IoqFGMCSx
 VFAecXyNidXzFmVGSnTcDyQHxQNxuhlGyQYNNiLRh732zo8zx5pD0/phzxB4C/YOx3rkEjtJN8ygo
 Fc4fcarJyjzgkNUU3LLs50FeHhY+T85ukMBtVWMy3Xhs4FJ5F7nn0+1X14KoXwqlt9aQGCp0Qdpdl
 LYn2Dm5g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfjfd-000MVz-2d;
 Thu, 29 Feb 2024 17:54:09 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add hack to prevent scsi timeouts
 in HP-UX 10.20
In-Reply-To: <CAFEAcA-KioRCJ97dbaiSf0f5uM0=+nAb=oLbFiRg=EPGwd57sw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 29 Feb 2024 09:36:38 +0000")
References: <20240228211149.1533426-1-svens@stackframe.org>
 <CAFEAcA-KioRCJ97dbaiSf0f5uM0=+nAb=oLbFiRg=EPGwd57sw@mail.gmail.com>
Date: Thu, 29 Feb 2024 17:54:09 +0100
Message-ID: <87r0gvxlce.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.96; envelope-from=svens@stackframe.org;
 helo=khaki.cherry.relay.mailchannels.net
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 28 Feb 2024 at 21:12, Sven Schnelle <svens@stackframe.org> wrote:
>>
>> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>> under certain circumstances. As the SCSI controller and CPU are not
>> running at the same time this loop will never finish. After some
>> time, the check loop interrupts with a unexpected device disconnect.
>> This works, but is slow because the kernel resets the scsi controller.
>> Instead of signaling UDC, add an option 'hpux-spin-workaround' which
>> emulates a INTERRUPT 2 script instruction. This instruction tells the
>> kernel that the request was fulfilled. With this change, SCSI speeds
>> improves significantly.
>> [..]
> I see we already have a hacky workaround for other OSes
> that do something similar. The ideal fix for both of these
> I think would be for lsi_execute_script() to, instead of stopping,
> arrange to defer executing more script instructions until
> after the guest has had a chance to run a bit more.
> I think setting a timer that calls lsi_resume_script() after
> a while would have that effect.

Thanks, good idea. So something like this?

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb..9931799d44 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -188,7 +188,7 @@ static const char *names[] = {
 #define LSI_TAG_VALID     (1 << 16)
 
 /* Maximum instructions to process. */
-#define LSI_MAX_INSN    10000
+#define LSI_MAX_INSN    1000
 
 typedef struct lsi_request {
     SCSIRequest *req;
@@ -205,6 +205,7 @@ enum {
     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+    LSI_WAIT_SCRIPTS, /* SCRIPTS where stopped because of instruction count limit */
 };
 
 enum {
@@ -224,6 +225,7 @@ struct LSIState {
     MemoryRegion ram_io;
     MemoryRegion io_io;
     AddressSpace pci_io_as;
+    QEMUTimer *scripts_timer;
 
     int carry; /* ??? Should this be an a visible register somewhere?  */
     int status;
@@ -1152,13 +1154,9 @@ again:
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
+        timer_mod(s->scripts_timer, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 500);
+        trace_lsi_scripts_timer_arm();
         reentrancy_level--;
         return;
     }
@@ -2294,6 +2292,17 @@ static const struct SCSIBusInfo lsi_scsi_info = {
     .cancel = lsi_request_cancelled
 };
 
+static void scripts_timer_cb(void *opaque)
+{
+    LSIState *s = opaque;
+
+    trace_lsi_scripts_timer_triggered();
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        s->waiting = 0;
+        lsi_execute_script(s);
+    }
+}
+
 static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
 {
     LSIState *s = LSI53C895A(dev);
@@ -2313,6 +2322,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
+    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
 
     /*
      * Since we use the address-space API to interact with ram_io, disable the
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index d72f741ed8..4456a08ab0 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -302,6 +302,8 @@ lsi_execute_script_stop(void) "SCRIPTS execution stopped"
 lsi_awoken(void) "Woken by SIGP"
 lsi_reg_read(const char *name, int offset, uint8_t ret) "Read reg %s 0x%x = 0x%02x"
 lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x%02x"
+lsi_scripts_timer_triggered(void) "SCRIPTS timer triggered"
+lsi_scripts_timer_arm(void) "SCRIPTS timer armed"
 
 # virtio-scsi.c
 virtio_scsi_cmd_req(int lun, uint32_t tag, uint8_t cmd) "virtio_scsi_cmd_req lun=%u tag=0x%x cmd=0x%x"

