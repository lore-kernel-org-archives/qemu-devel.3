Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB14CCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7R-0005Gn-EM; Sun, 18 Oct 2026 01:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7K-0005FX-US
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:31 -0400
Received: from nx244.node01.secure-mailgate.com ([89.22.108.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7I-0000RE-V2
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:30 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7F-007Sg0-5a; Sun, 18 Oct 2026 07:07:26 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 5C30A28249E;
 Sun, 18 Oct 2026 07:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300045;
 bh=y7aKdl6bcJ65SzFuNLTMYbUr5fWCRCMM+QujLhMKn4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JbGSAKa0NYtu1xkwP9a1+qHnyfCcqWKLP57tt1DDn54rKqyLiCc8Rq3FKpOEf8oeq
 wreLXhVJ3uznumgMTLnRnN8s7R/N8jwtuV6oK58yOtzSEjUyppipKT9rgY1fyVeAOl
 ii5uxG4tKPOxMmj3VuAJ7ouGOYl5kxYsSRXPJ4c0=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/display/cirrus_vga: allow a zero source pitch for
 color expansion
Date: Sun, 18 Oct 2026 07:06:39 +0200
Message-ID: <20261018050643.9288-5-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018050643.9288-1-christian@quante.one>
References: <20261018050643.9288-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004489.350469.4318212911775297300@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWGtT23HaGabxKUFDNb9gVc5cXphpG3q+Io
 QC8RsdtJ2yu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4a+4+3tKfzkMI5eEXc895tcS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9dwVQOvQDAu0j1lWbRUnFLa86GAO38LUYomBaWJiGeaRPFPlsNwIEW3NK+ERUy
 VlEF1GGlhZVmIXQ9yRY52/AOUNajOgnyG49cHXrfXNCdkxagxqTy3Eelsrf2AHilqGAJUsGkiX9p
 nLLp9ipqVxozPuHcArodRAPA4GpBiyiifOlKRGVSbUqHNBE5RvuLCfvg7iEFLP+SSY+Av5+AiC4O
 kD+PiVGEaS3l/oNDuDtwZmwWPuALIZF8Yr837xKlqbHn/8HJ4gJhwHkEiz+DPkNk24FpRrr227/4
 WdvfheWFj9/jJzejnm6DfFR5Y2NqPZ5SKztf/xEq+WccjXvWLPu81n1xxtsUl7n6yEc2zbQZ8at/
 mpOirO4Aj7K7pCc7It7M0BeNcjKlgO6G3s/AZZZkg1ObUHtEfHVEAI/Q+wksCpzwZQOg2V2O/Kq5
 tEtQFl9fEZU8CSQ0vuHcjO6LZzjzwKJtK7Oq7d/qp+/cxt5UIbtf63VNbf0lrvssY+k7ACm5OdrJ
 neDw5nGUT85QJA56jvJsmaZpbKRZNsABnVcYYo7nDw+/+Xvf0phT65CN5MWcxP6fTfjYjs4lNimJ
 +IXhHybVHWnukQ5J3NZf3Sto4BAah0N3qPEwUyYM+XoU0gPKPpjFSmnirfv07lDyNv3Z9gjPYs8T
 OOI1p+50WdIyJ84MPqAerJyLyS8xGYvhuzEvuGslKTrRIXcXpFg5ivY=
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

For a color expansion BitBLT from video memory, the source pitch has no
meaning.  CL-GD5446 Technical Reference Manual (November 1996), GR30
bit 7 (page 5-11): "When the source of color-expand data is display
memory, the source pitch is ignored."  Page 9-20: "When the BitBLT uses
color expansion or pattern copy, the source is considered a linear
string of bytes, and the source pitch is a don't care."  The raster
operations for color expansion in cirrus_vga_rop2.h do not use it
either.

Since commit 4299b90e9ba9 ("display: cirrus: check vga bits per
pixel(bpp) value"), blit_region_is_unsafe() rejects a pitch of 0.
blit_is_unsafe() uses it for the source of each screen-to-screen BitBLT
that is not a pattern copy, so a color expansion with a source pitch of
0 is dropped and draws nothing.  For pattern copies, commit
95280c31cda7 ("cirrus: fix patterncopy checks") moved the source check
to cirrus_bitblt_common_patterncopy().

For a color expansion, check the source in the way the raster
operations read it: a linear string of bytes, one bit per pixel, each
line starting with a new byte.  A plain copy with a source pitch of 0
is still rejected, because cirrus_do_copy() divides by the source
pitch.

Fixes: 4299b90e9ba9 ("display: cirrus: check vga bits per pixel(bpp) value")
Signed-off-by: Christian Quante <christian@quante.one>
---

Notes:
    Seen with the Cirrus driver of OS/2 Warp 3 (isa-cirrus-vga, 1024x768,
    16 bpp, TCG).  It keeps the glyphs of a font in off-screen video memory
    and draws the characters with color expansions from there (transparent
    ones for the text of the LaunchPad).  It does not write the source pitch
    for these BitBLTs.  Until its first BitBLT that needs a source pitch,
    the source pitch is 0, and the text that the driver draws in this time
    is missing.  In the test VM, these are the 45 characters on the buttons
    of the LaunchPad (the OS/2 toolbar) after boot; only the underlines of
    the keyboard shortcuts are there.  With this patch, the text is correct.
    This guest needs "hw/display/cirrus_vga: read back the cursor position
    bits of SR10/SR11" to start, which I will send after this series.

 hw/display/cirrus_vga.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 6f1f9ac82f..4ed624bd84 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -248,6 +248,17 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
     if (dst_only) {
         return false;
     }
+    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_COLOREXPAND) {
+        /*
+         * The raster operations read the source of a color expansion as
+         * a linear string of bytes, one bit per pixel, each line starting
+         * with a new byte.  The source pitch is not used.
+         */
+        int64_t len = (int64_t)s->cirrus_blt_height *
+            DIV_ROUND_UP(DIV_ROUND_UP(s->cirrus_blt_width,
+                                      s->cirrus_blt_pixelwidth), 8);
+        return s->cirrus_blt_srcaddr + len > s->vga.vram_size;
+    }
     if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
                               s->cirrus_blt_srcaddr)) {
         return true;
-- 
2.53.0


