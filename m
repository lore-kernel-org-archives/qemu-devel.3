Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C9DCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7T-0005H0-Ep; Sun, 18 Oct 2026 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7M-0005Fy-F8
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:34 -0400
Received: from nx101.node01.secure-mailgate.com ([89.22.108.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7J-0000R1-1o
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:32 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7D-007SYI-0r; Sun, 18 Oct 2026 07:07:24 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id DE73F28249E;
 Sun, 18 Oct 2026 07:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300042;
 bh=sLumoPCNx3w4msV4H1DVAECrtEfpjsklvCNNXbL76Ss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lbfr2YAZuP0rjiFQR3mFUSk8DS3U6Wqn5aFx3p+gaJTRMkNc7kqxJUgu5qLVjrTLO
 4gWIa1WvIp7kgeTZvOfLCMd0PCIHe2Ugg+7vmAZm45Y1HZ7xBokY0vd2XR0umpnxRh
 PWvnT2w+DeByek+a97Pr62PZQKobuZ8gWQDq8Kao=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/display/cirrus_vga: keep the first pattern line of
 pattern copies
Date: Sun, 18 Oct 2026 07:06:36 +0200
Message-ID: <20261018050643.9288-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018050643.9288-1-christian@quante.one>
References: <20261018050643.9288-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004254.350301.13491900774536336594@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00847495000297)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUYf7D5RrFHKCCGOd9eAuRo4npbykwg+Hw5
 lsIpQih3biu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4YUvRt+4fVzO4T3YJSqWrgRS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+u/6qIuBtLkUxxV/USyR/jsPP/MCh2vuy1qkC9R2Zq1
 OIxftLFiIG/X4GfHDaa3wC7khuxzFU2bz86WcStZ9QDBWBV+VvfCWXzOFA86fiNrdzMm0SdkvtPi
 +Iq6MyMtFurwZq5jIWjWaWrcrm6J715pRUFUU5/JtLKKEUu4esXRIHI76+ca/5h6FPCn2NRyv+0S
 joXDm2V1p5BMPuhfQhsmM/DC/DhXrp3X/X+gfREw6g1HPUZN+/YDk1iDa8+ZxxSD72O80aZymZQ6
 saaeLqKzk+1FWQ+vJ8qzoMDtBircbQfpeuvl6KSFHsYhSuAb84SayjpolrWTGg0Av+kj2J3N97Xf
 AMjOQomVJmutBSifOApbHKd03ZB+qAOqT4n/dInV2uoHT6Dm0GQ6r7K5ojRWwyPW8g9J7yY4N5Ts
 aRvkTyUSJMk9tcqbKhjVPIwqdohMEvROmHCsrGB54/25AlYqt40VpHjmmImp9HqkmCpM13LYM3A6
 BXfvel8OEFDbU51jSannrGt99/u9tTmLLSzXBBVweHe0r89stuxGFeu80GpAnro7wkLz+qqKVK/b
 25koCP9WDMcj98RpkTKo8yhtOAzTa0Q8K7yJ5sEoHdAShzei2jS295YZuTF+Fa0pfd5S1IJp6mFV
 PAC/2g1mDXLy2Elbx0EUnn3hiOC609jGD36MJUDkyKfV9QiUGsZMVVj2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.101; envelope-from=christian@quante.one;
 helo=nx101.node01.secure-mailgate.com
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

For a pattern copy BitBLT, the pattern starts at a multiple of its size
in video memory, and the three low bits of the source address (GR2C)
select the first line of the 8x8 pattern.  CL-GD5446 Technical Reference
Manual (November 1996), page 9-28: "The patterns must be stored beginning
on a boundary equal to the size of the pattern itself.  The vertical
offset into the pattern is then programmed into the three low-order bits
of the Source Address (register GR2C)."  A monochrome (color expanded)
pattern has 8 bytes, a color pattern 64, 128 or 256 bytes (GR30 bit 6,
page 5-11).  The table there asks only for dword alignment of a
monochrome pattern, but as the three low bits select the line, the
pattern itself starts at a multiple of 8.

Since commit 95280c31cda7 ("cirrus: fix patterncopy checks"),
cirrus_bitblt_common_patterncopy() rounds cirrus_blt_srcaddr down to the
pattern size in place.  This has two effects:

 - The raster operations take the first pattern line from
   cirrus_blt_srcaddr & 7 (cirrus_vga_rop2.h).  After the rounding this
   is always 0.

 - For a monochrome pattern the rounding uses the size of a color
   pattern, so the BitBLT can read the wrong 8 bytes.  For example, in
   8 bpp the source address 0x4b073 (pattern at 0x4b070, first line 3)
   becomes 0x4b040 (first line 0).

Keep cirrus_blt_srcaddr unchanged and give the rounded address to the
raster operation.  Use 8 bytes as the size of a monochrome pattern, also
in the range check.

Seen on OS/2 2.1 with IBM's CL-GD5436/46 display driver (version 1.14)
on cirrus-vga: the gray background of selected icon titles has a dotted
edge, and so have some window frames.  With this patch they are solid.

Fixes: 95280c31cda7 ("cirrus: fix patterncopy checks")
Signed-off-by: Christian Quante <christian@quante.one>
---
 hw/display/cirrus_vga.c | 44 +++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0a8c74e137..67f08b84b1 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -659,25 +659,36 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
 static int cirrus_bitblt_common_patterncopy(CirrusVGAState *s)
 {
     uint32_t patternsize;
+    uint32_t patternaddr = 0;
     bool videosrc = !s->cirrus_srccounter;
 
     if (videosrc) {
-        switch (s->vga.get_bpp(&s->vga)) {
-        case 8:
-            patternsize = 64;
-            break;
-        case 15:
-        case 16:
-            patternsize = 128;
-            break;
-        case 24:
-        case 32:
-        default:
-            patternsize = 256;
-            break;
+        if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
+            patternsize = 8;
+        } else {
+            switch (s->vga.get_bpp(&s->vga)) {
+            case 8:
+                patternsize = 64;
+                break;
+            case 15:
+            case 16:
+                patternsize = 128;
+                break;
+            case 24:
+            case 32:
+            default:
+                patternsize = 256;
+                break;
+            }
         }
-        s->cirrus_blt_srcaddr &= ~(patternsize - 1);
-        if (s->cirrus_blt_srcaddr + patternsize > s->vga.vram_size) {
+        /*
+         * The pattern starts at a multiple of its size.  The three low
+         * bits of the source address select the first pattern line; the
+         * raster operations take them from cirrus_blt_srcaddr, so the
+         * aligned address goes into patternaddr.
+         */
+        patternaddr = s->cirrus_blt_srcaddr & ~(patternsize - 1);
+        if (patternaddr + patternsize > s->vga.vram_size) {
             return 0;
         }
     }
@@ -686,8 +697,7 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState *s)
         return 0;
     }
 
-    (*s->cirrus_rop) (s, s->cirrus_blt_dstaddr,
-                      videosrc ? s->cirrus_blt_srcaddr : 0,
+    (*s->cirrus_rop) (s, s->cirrus_blt_dstaddr, patternaddr,
                       s->cirrus_blt_dstpitch, 0,
                       s->cirrus_blt_width, s->cirrus_blt_height);
     cirrus_invalidate_region(s, s->cirrus_blt_dstaddr,
-- 
2.53.0


