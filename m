Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA069CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7T-0005Gu-AB; Sun, 18 Oct 2026 01:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7M-0005Fs-6p
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:33 -0400
Received: from nx38.node02.secure-mailgate.com ([192.162.87.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7J-0000R0-15
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:31 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7C-00HSSv-81; Sun, 18 Oct 2026 07:07:23 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 04ACB282B06;
 Sun, 18 Oct 2026 07:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300041;
 bh=Wxp02GPiWufi1iRsth9nCIrOHn3tisYg0wtscBRxng0=;
 h=From:To:Cc:Subject:Date:From;
 b=mwev9Ian6V77n+3Q6qjZULfm0thuFpDX7nWS1RkVdw7OgVe3gbNsfAY+qq8t3khIw
 4coKbHgOJJVJrK+BInRyteeFUhQY8MrdG1h59oi1Z1eojJ3T3pHUck8dUjRe1nyeJY
 1lxCEd250NslsBEsDzCmjUX0ga8VubRFdAEsEPnY=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] hw/display/cirrus_vga: fix four BitBLT bugs seen with old
 guest drivers
Date: Sun, 18 Oct 2026 07:06:35 +0200
Message-ID: <20261018050643.9288-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004166.350229.16044753432417921918@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVm6VbyMomcAZbA6/PGG2F7P8iAWtONcjyX
 Qq2vVkmk7iu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4aoUWCAP0EKIaHqMkSJnBz5S5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KNy9dwVQOvQDAu0j1lWbRUnG7JwrR4wH2HMsaHgTS1WsQCCIIfAL71ivBiYgYAAJB
 M1AKkEeH4f3QNjnZQsMBDjHQ/WbGsq65QLNMSAJ+ejkBAD5p5bCft1Gtn1j43P/iuYRsMvAzVDjD
 c3PAhsXgzWh18CteaO4Ze17Oken/alveaVmvroGDNGyizVFVGIWqiJMWoMak8txHpbK39gB4pahX
 g2vG10nj2SEw9qiwY9HOgrsGF2tnHvb06P5VOLeI1KOnwOx3ylluR4Ij3NyoB8b74O4hBSz/kkmP
 gL+fgIguye/vZHFBRRuwz9Kqu7ieZfl0SDRZh2d4JViFrSKDiTaKy6Tft670yp8en0U1kIm9jBcQ
 cwNbUfh4VIKSGnGoXdRsa08FYz9HVbKb1i1TMOf+iN7HRGd9wPNXsZMAGh84vNZ9ccbbFJe5+shH
 Ns20GfGrf5qToqzuAI+yu6QnOyJlwwpVsjTdEAPVMrxe1sTmVWFbxfriDglPUYiqu051HX8+rae1
 GQAub/kNXvFxsY4XFoejV3638R16SFpZdH5/TL0tqQiQZNkgs7nYwvCHoSG7X+t1TW39Ja77LGPp
 OwDAYEA/cthTRP/SMwmX2WDIkxesplAGr2nt2ldu3TOUDcNuA+GQI4RoNKxZNMHIvZpL6FaqeIwl
 ajzGtEN2rIGmz7dFu8KIAIZ6Jdjha92XJOAQGodDd6jxMFMmDPl6FNJBszycCwGDwiygJYy+d+F8
 Z9pxJAIQCGgHOOdnYQuvH+3OZLWYrfwOlBrZeFjmSGExL7hrJSk60SF3F6RYOYr2
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

These patches fix four bugs in the BitBLT engine of the Cirrus
emulation.  Three of them garble or hide the text of old guest drivers
that draw text with the engine; patch 1 breaks 8x8 pattern fills, for
example the edges of selected icon titles.

Patch 1 fixes a regression since v2.9.0: pattern copies from video
memory always start with pattern line 0, and a monochrome pattern can
be read from the wrong address.
Patch 2 fixes the source pitch of color expansion with DWORD granularity
(GR33 bit 0), which is wrong since the BitBLT code was written.
Patch 3 is for KVM only: the writes that start a BitBLT (GR2A with
autostart, and GR31) must not be coalesced.  The other BitBLT registers
at 0xb8000 stay coalesced, so a BitBLT that the guest programs through
these registers costs 12.8 us instead of 8.1 us (26.0 us if none of
the 256 bytes is coalesced).
Patch 4 fixes a regression since v2.8.0: a color expansion from video
memory with a source pitch of 0 is dropped, although the source pitch
has no meaning for it.
Patch 5 adds a qtest for the BitBLT engine, with test cases for patches
1, 2 and 4.  Patch 3 only matters with KVM, which qtest cannot check.

Tests, each with QEMU master (a19f59a72d) and with the patches:

 - Installer of SuSE Linux 7.0 (XFree86 3.3.6), -vga cirrus, text of
   the language selection:

                      TCG           KVM
     master           mostly dots   X server hangs, most text missing
     patches 1+2      correct       X server hangs
     patches 1-4      correct       correct

   This is GitLab issue #988.  Issue #1211 (closed) reports the same
   symptom for various Linux distributions of that time; its workaround
   is the XFree86 options "no_bitblt" and "sw_cursor".  I have not
   tested those.

 - OS/2 2.1 with IBM's CL-GD5436/46 display driver (version 1.14),
   cirrus-vga: with master, selected icon titles have a dotted edge;
   with patch 1 they are solid.

 - Windows NT 4.0 (without service pack and with SP6a) with its Cirrus
   display driver, cirrus-vga, TCG: the desktop, a selected icon, a
   console window and the output of dir are pixel-identical with and
   without the patches.  In my runs (I traced the BitBLTs), its driver
   did not use the paths that patches 1, 2 and 4 fix, so this is only a
   check for regressions.  Patch 3 matters only with KVM, and this guest
   does not boot with KVM here, neither with master nor with the patches
   (STOP 0x0000000A in ntoskrnl.exe).

 - The new cirrus-test (patch 5): with the series, all five test cases
   pass.  With patch 1 reverted, the two pattern tests fail; with patch
   2 reverted, the DWORD test fails; with patch 4 reverted, the source
   pitch test fails; with all of them reverted, these four fail.  The
   fifth test (source beyond the end of video memory) passes on master
   too, and fails if the bounds check of patch 4 is removed.

checkpatch.pl is clean, and display-vga-test passes after each patch.

Christian Quante (5):
  hw/display/cirrus_vga: keep the first pattern line of pattern copies
  hw/display/cirrus_vga: fix the source pitch for DWORD granularity
  hw/display/cirrus_vga: do not coalesce the writes that start a BitBLT
  hw/display/cirrus_vga: allow a zero source pitch for color expansion
  tests/qtest: add tests for the Cirrus BitBLT engine

 MAINTAINERS               |   1 +
 hw/display/cirrus_vga.c   |  74 ++++++---
 tests/qtest/cirrus-test.c | 317 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 4 files changed, 374 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/cirrus-test.c

-- 
2.53.0


