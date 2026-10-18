Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3CACCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7R-0005GX-5o; Sun, 18 Oct 2026 01:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7K-0005FW-Qe
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:30 -0400
Received: from nx38.node02.secure-mailgate.com ([192.162.87.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7I-0000R3-Uy
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:30 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7D-00HSX1-Lq; Sun, 18 Oct 2026 07:07:24 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id BBDF2282AB1;
 Sun, 18 Oct 2026 07:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300043;
 bh=Iklw7fQWXSq1SHfnE4m+poSqGQhdEwTVPZ/WQgeULnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NvbYSApe96zbWwmz07TLZ9OZ1pa+f/WBRYgyZOLai3BnWxlXv2bSOUdPJK2rKnwVk
 DnRRL8FVT7otzGVvTmss8rYrBcjU3xlvfk5mYdyNjtk6nRYhIulLq94oY3qMpBMjXc
 uVijA+Ex9PtxqX+PSA34H9bzEQ5Or8eVjS/zn+UU=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/display/cirrus_vga: fix the source pitch for DWORD
 granularity
Date: Sun, 18 Oct 2026 07:06:37 +0200
Message-ID: <20261018050643.9288-3-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018050643.9288-1-christian@quante.one>
References: <20261018050643.9288-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004336.350365.3153587032284518109@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVtKatNhWyh+qJMixbyr+NDLqG6eKxYMh8g
 5kZtVcIjPyu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4YiOKwe4OkQcF8o/vp/2pjmS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9dwVQOvQDAu0j1lWbRUnFLa86GAO38LUYomBaWJiGeaRPFPlsNwIEW3NK+ERUy
 VlEF1GGlhZVmIXQ9yRY52/AOUNajOgnyG49cHXrfXNCdkxagxqTy3Eelsrf2AHilqGAJUsGkiX9p
 nLLp9ipqVxozPuHcArodRAPA4GpBiyiifOlKRGVSbUqHNBE5RvuLCfvg7iEFLP+SSY+Av5+AiC4O
 kD+PiVGEaS3l/oNDuDtw2R0VB+Wa1Hi5lu/dimywHIDoo4KS2zV8wXW4Nyy5moRk24FpRrr227/4
 WdvfheWFj9/jJzejnm6DfFR5Y2NqPZ5SKztf/xEq+WccjXvWLPu81n1xxtsUl7n6yEc2zbQZ8at/
 mpOirO4Aj7K7pCc7It7M0BeNcjKlgO6G3s/AZZZkg1ObUHtEfHVEAI/Q+wksCpzwZQOg2V2O/Kq5
 tEtQFjmrlTIeC9/t50fQ6GKDIe6Uoh6OGJZG7AGpT0SbVAiZIbtf63VNbf0lrvssY+k7ACm5OdrJ
 neDw5nGUT85QJA56jvJsmaZpbKRZNsABnVcYYo7nDw+/+Xvf0phT65CN5MWcxP6fTfjYjs4lNimJ
 +IXhHybVHWnukQ5J3NZf3Sto4BAah0N3qPEwUyYM+XoU0gPKPpjFSmnirfv07lDyNv3Z9gjPYs8T
 OOI1p+50WdIyJ84MPqAerJyLyS8xGYvhuzEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.38; envelope-from=christian@quante.one;
 helo=nx38.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

With GR33 bit 0 set, each line of source data for a color expanded
system-to-screen BitBLT starts at a new dword.  CL-GD5446 Technical
Reference Manual (November 1996), GR33 (page 5-17): "At the end of each
scanline, unused source data is discarded to the end of the current
dword.  The next scanline begins with the next dword."

For this case cirrus_bitblt_cputovideo() sets cirrus_blt_srcpitch to
((w + 31) >> 5).  This is the number of dwords per line, but
cirrus_blt_srcpitch counts bytes.  QEMU takes only a quarter of the data
for each line and ends the BitBLT too early.  The rest of the data goes
to video memory as pixels.

XFree86 3.3.6 (XF86_SVGA) uses this mode on the CL-GD5436/46 for all text
drawn with the BitBLT engine.  In the installer of SuSE Linux 7.0 with
-vga cirrus and TCG, most of the text is only a few dots, and garbage
appears in the top lines of the screen.  With this patch, the text is
correct.  With KVM, the installer also needs "hw/display/cirrus_vga: do
not coalesce the writes that start a BitBLT".

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/988
Signed-off-by: Christian Quante <christian@quante.one>
---

Notes:
    The CL-GD5436/46 display driver for Windows 3.1 uses this mode for wide
    characters; without this patch they are garbled.  Windows for Workgroups
    3.11 with this driver also needs "hw/display/cirrus_vga: add the byte
    swapping PCI apertures 1 and 2", which I will send after this series, to
    show any text.

 hw/display/cirrus_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 67f08b84b1..dc216cde56 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -901,7 +901,7 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * s)
         if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
             w = s->cirrus_blt_width / s->cirrus_blt_pixelwidth;
             if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_DWORDGRANULARITY)
-                s->cirrus_blt_srcpitch = ((w + 31) >> 5);
+                s->cirrus_blt_srcpitch = ((w + 31) >> 5) * 4;
             else
                 s->cirrus_blt_srcpitch = ((w + 7) >> 3);
         } else {
-- 
2.53.0


