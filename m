Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E945CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7R-0005Gp-Jd; Sun, 18 Oct 2026 01:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7M-0005Fx-CE
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:33 -0400
Received: from nx244.node01.secure-mailgate.com ([89.22.108.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7J-0000R8-1A
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:32 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7E-007Sez-DK; Sun, 18 Oct 2026 07:07:25 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 996F1282B48;
 Sun, 18 Oct 2026 07:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300044;
 bh=DYyNvL8tDbIAMxbH/3iWlej8cQTmukMMzPn0ya0G24o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=4mkXKox6nXNIdjTOF7l2as+TG68JIwgEWIBwkcblwpWklnN/Gtiv60OZnYyQNBH/e
 WfxgYg/+W2V4agPDtSBLqpPceGaFw/SPcEGHNuj8eo2y8f4xu9gFWS6+BUKGjeGdV+
 zsPTHOWGn/ucxu1YnoCrRLoZ0E2SZFWTPPwfhpH0=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/display/cirrus_vga: do not coalesce the writes that
 start a BitBLT
Date: Sun, 18 Oct 2026 07:06:38 +0200
Message-ID: <20261018050643.9288-4-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018050643.9288-1-christian@quante.one>
References: <20261018050643.9288-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004415.350423.13866190684134073730@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00139839614542)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVUEmWtDgz/yHns/gkOHaf8e0ZHIn1ei4lP
 kS6jdlHKYiu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4Zlp2ux2uZbaMww04XuzFflS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+u/6qIuBtLkUxxV/USyR/jsPP/MCh2vuy1qkC9R2Zq1
 OIxftLFiIG/X4GfHDaa3wC7khuxzFU2bz86WcStZ9QDBWBV+VvfCWXzOFA86fiNrdzMm0SdkvtPi
 +Iq6MyMtFurwZq5jIWjWaWrcrm6J715pRUFUU5/JtLKKEUu4esXRIHI76+ca/5h6FPCn2NRyv+0S
 joXDm2V1p5BMPuhfQhsmM/DC/DhXrp3X/X+gfREw6g1HPUZN+/YDk1iDa8+ZxxTIPlCVU2If9Fs6
 7e67qB3xk+1FWQ+vJ8qzoMDtBircbQfpeuvl6KSFHsYhSuAb84SayjpolrWTGg0Av+kj2J3N97Xf
 AMjOQomVJmutBSifOApbHKd03ZB+qAOqT4n/dInV2uoHT6Dm0GQ6r7K5ojRWwyPW8g9J7yY4N5Ts
 aRvkTyUSJMk9tcqbKhjVPIwqdohMEvROmHCsrGB54/25AlYqbIOk1hoT+kVGe8ZrzHhI63LYM3A6
 BXfvel8OEFDbU51jSannrGt99/u9tTmLLSzXBBVweHe0r89stuxGFeu80GpAnro7wkLz+qqKVK/b
 25koCP9WDMcj98RpkTKo8yhtOAzTa0Q8K7yJ5sEoHdAShzei2jS295YZuTF+Fa0pfd5S1IJp6mFV
 PAC/2g1mDXLy2Elbx0EUnn3hiOC609jGD36MJUDkyKfV9QiUGsZMVVj2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.244; envelope-from=christian@quante.one;
 helo=nx244.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

cirrus_init_common() marks the whole legacy window 0xa0000-0xbffff for
coalesced MMIO.  This includes the memory-mapped BitBLT registers at
0xb8000-0xb80ff (SR17 bit 2 set, bit 6 clear).  With KVM, writes to
these registers wait in the coalesced MMIO ring until QEMU flushes the
ring, for example before the next access to a region with
flush_coalesced_mmio set.

Most of these writes only set parameters, but two of them start a
BitBLT: the write of GR2A (destination address) with autostart (GR31
bit 7), and the write of GR31.  For a system-to-screen BitBLT, the guest
then writes the source data.  If it writes them to the linear frame
buffer or to the bank window at 0xa0000, they go straight to video
memory: both are plain RAM until cirrus_bitblt_start() has run and
unmapped them.  The source data are lost.  When the guest reads GR31 to
wait for the end of the BitBLT, the ring is flushed, the BitBLT starts
and waits for data that do not come.  GR31 stays busy until the driver
gives up.

XFree86 3.3.6 (XF86_SVGA) on the CL-GD5436/46 programs the BitBLT through
these registers with autostart, and writes the source data for text to
the linear frame buffer.  In the installer of SuSE Linux 7.0 with KVM,
the X server runs into the time-out of its wait loop for each piece of
text, and most text is missing.

Commit f65ed4c1529f ("KVM: Coalesced MMIO support") added the coalescing
for writes "if those writes do not have side effects".  Keep it for the
rest of the window and for the parameter registers, but not for the
bytes of GR2A and GR31.  A write to one of these bytes leaves the guest
at once; KVM coalesces only writes that lie completely inside one zone
(virt/kvm/coalesced_mmio.c), so this is also true for a dword write to
offset 0x10.  The region has flush_coalesced_mmio set, so QEMU first
processes the parameter writes from the ring and then starts the
BitBLT.

The two bytes are excluded from coalescing also while the BitBLT
registers are not mapped at 0xb8000.  In a text mode, 0xb8012 and
0xb8040 are then part of the text buffer, and a write to one of them
leaves the guest at once.

With KVM, a screen-to-screen BitBLT that the guest programs with nine
writes to these registers takes 12.8 us with this patch, and 8.1 us
with the coalescing for all registers.  If none of the 256 bytes of the
registers is coalesced, it takes 26.0 us.

Signed-off-by: Christian Quante <christian@quante.one>
---

Notes:
    Two more guests show this with KVM, but they need other Cirrus patches
    of mine to get this far, which I will send after this series:
     - Windows for Workgroups 3.11 with the CL-GD5436/46 display driver for
       Windows 3.1 (needs "hw/display/cirrus_vga: add the byte swapping PCI
       apertures 1 and 2"): single characters and the STOP icon are
       missing, and the hourglass stays.
     - OS/2 Warp 3 with its Cirrus driver on isa-cirrus-vga (needs
       "hw/display/cirrus_vga: read back the cursor position bits of
       SR10/SR11"): the driver hangs while it draws the desktop.

 hw/display/cirrus_vga.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index dc216cde56..6f1f9ac82f 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2847,6 +2847,21 @@ static const MemoryRegionOps cirrus_vga_io_ops = {
     },
 };
 
+/*
+ * Coalesce the writes to the legacy window 0xa0000-0xbffff, but not to the
+ * two bytes of the memory-mapped BitBLT registers whose write can start a
+ * BitBLT: GR2A (with autostart) and GR31.
+ */
+static void cirrus_coalesce_low_mem(CirrusVGAState *s)
+{
+    hwaddr gr2a = 0x18000 + CIRRUS_MMIO_BLTDESTADDR + 2;
+    hwaddr gr31 = 0x18000 + CIRRUS_MMIO_BLTSTATUS;
+
+    memory_region_add_coalescing(&s->low_mem, 0, gr2a);
+    memory_region_add_coalescing(&s->low_mem, gr2a + 1, gr31 - gr2a - 1);
+    memory_region_add_coalescing(&s->low_mem, gr31 + 1, 0x20000 - gr31 - 1);
+}
+
 void cirrus_init_common(CirrusVGAState *s, Object *owner,
                         int device_id, int is_pci,
                         MemoryRegion *system_memory, MemoryRegion *system_io)
@@ -2907,7 +2922,7 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
                                         0x000a0000,
                                         &s->low_mem_container,
                                         1);
-    memory_region_set_coalescing(&s->low_mem);
+    cirrus_coalesce_low_mem(s);
 
     /* I/O handler for LFB */
     memory_region_init_io(&s->cirrus_linear_io, owner, &cirrus_linear_io_ops, s,
-- 
2.53.0


