Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D459DC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgCK-0006Tz-US; Tue, 14 Jul 2026 12:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wjgCA-0006Sk-28; Tue, 14 Jul 2026 12:41:22 -0400
Received: from nx208.node02.secure-mailgate.com ([192.162.87.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wjgC6-00080G-U8; Tue, 14 Jul 2026 12:41:21 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wjgBt-001unu-Ru; Tue, 14 Jul 2026 18:41:09 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1784047265;
 bh=OOw1Fz0VfX7aTOl0nFc4il+pOlDJV9sdhzW7OhU6t1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ijGrQUB58xyoF+MsK3QcB993MyvQZigIoFzYJeCrMFx+dt2NfyPWdyNCDP2uTqyjd
 fZmebDCJ91j3tFpIVqUJhHk4toPme87zZVkjHh51PH6ZmANgrIkADMGmBUJnULkWkR
 N0gVOxzDoQZD2IYq7qWR4JraZ6B/lwzK5Qcls2EY=
Received: from Zeuss.fritz.box (p549f1d24.dip0.t-ipconnect.de [84.159.29.36])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id B8C6B2806BC;
 Tue, 14 Jul 2026 18:41:04 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, PC-DOS repro <chrischaan66@googlemail.com>
Subject: [PATCH v2 0/2] hw/block/fdc: do not claim a diskette that is not there
Date: Tue, 14 Jul 2026 18:40:29 +0200
Message-ID: <20260714164031.60551-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710113134.43012-1-christian@quante.one>
References: <20260710113134.43012-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178404726537.1135137.7079258033067140975@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuULvOrRKVOH3ofFq13Tch0megdoZLxLHfqn
 XA6pcVWBQCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4a4Fjcsg6u4JppWJK2Uh/mBS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMPx4XSOO6RFTrifNgKO3ZgdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEnjS7CALmRCUzN1QVE+RGc0Ax+BZkzd
 0e13WD/4AJ+qkmBCbv/w938lGtitCqpRMafFwQQlDt/i6O8Zpbeo/guQB/Jm/zuH5596gXQY4EwB
 Mg5sP70Pkcele6RoJz34v/d+q6Mn2LZgq9YxI8osFzBUIf83kAX3VL/apPEuhGFzBolcBcPOxqSh
 pVghpKAbaoYvxN9o5EKBpRbZ1PeH6C00A+GqJcyRcsUAEFt4SlkLplAKkEeH4f3QNjnZQsMBDjES
 iGwGc/vrQ4xTev5VIB3HhgtMHRiJdxALHfqhoDl+AzSzAAEMaOD+eGvSvDbuQdjIaqO8eKXgYpAe
 iTquxVtS38rA8G6FzAzSCibTPhHvFpMWoMak8txHpbK39gB4pai832B37txLjX+Sz4et2UwdbhnI
 dz72F3iGUxr++IPfgzsfVGqAlo7ptXB7NVqLQn374O4hBSz/kkmPgL+fgIgu0529JQguXQXgFOfK
 fPSBLUOshrr692fsy3FYNQKs/4GmK74MtjKZrxq1HX5jRH99SGLgv7FlJUh+NgTpoEMlHvJE4bHW
 BPBgKMaSdHatRvh4Acy0Hpqm8JcLJGAjgWpovNZ9ccbbFJe5+shHNs20GfGrf5qToqzuAI+yu6Qn
 OyIuQIYsA93ZgAK81Z06xvgYpGfDmXT2btvSDS9bsLuFRo5bFKNDK9b/r35PdnhQG2VLX5h4l94o
 Elym1aJkxA8y5SC0zqxMk7/P6Ossq0YblyG7X+t1TW39Ja77LGPpOwBFtErRvSogDGJnUgH8EfYq
 sPTnEEwP9TLRZ2UpTHzOlQCPq4MaK6dkURo35JGgOUnbtKdNW6UEYS5UIVT9F9GCeqiaveUQ5zC0
 K+z79TPpZOAQGodDd6jxMFMmDPl6FNKDmU3Z0Jkm2iCWngRL/qssKUi7MuB+q0EyTXC9q9hdEM3A
 QzXln0WtCuRDejr7TKcxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.208; envelope-from=christian@quante.one;
 helo=nx208.node02.secure-mailgate.com
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

From: PC-DOS repro <chrischaan66@googlemail.com>

Kevin, thank you -- that was a far closer read than I expected for a floppy
patch, and all three points were right.

  1/2  The SET_CUR_DRV() omission you spotted.  It is real: every other
       handler latches the drive from fifo[1], READ ID does not, so it
       answers about whichever drive was selected last.  A DOR write
       normally selects the drive as a side effect, which is why nobody
       has tripped over it.  It goes first because 2/2 checks the medium
       of exactly that drive.

  2/2  The main change, now with the fd_seek() return code you suggested
       instead of a second blk_is_inserted() in the caller.  Nothing made
       it harder than it looked -- but it does drag fdctrl_format_sector()
       along, because a new return value would otherwise fall through its
       "default" and let FORMAT TRACK carry on as if nothing happened.  So
       FORMAT on an empty drive now answers ST1.MA as well.  I could not
       get a guest to reach that path: DOS gives up during media sensing
       and never issues the command, and a hand-written FORMAT TRACK needs
       the per-sector data phase to get there at all.  It is the right
       answer semantically, but it is untested on a guest, and I would
       rather say so than bury it.

       The test comment is fixed too -- it claimed the preceding tests
       leave the drive empty, which is exactly the dependency you object
       to.  The two tests now stand on their own; the wider ordering
       problem in fdc-test I left alone, as you asked.

Measured, empty 1.44M drive, INT 13h AH=02h on A: (SeaBIOS 1.17.0):

  before      0.11 s, AH = 0x20 (controller failure)
  after       0.21 s, AH = 0xC0 (no media)

The extra 0.1 s is SeaBIOS working through the data rates now that READ ID
no longer succeeds on the first try.  Booting from a hard disk is unchanged
-- the drive is not touched at all -- and no guest changes what it shows:
DOS shows the same message for 0x20 as for 0xC0, and Windows 3.11 and
OS/2 2.11 show exactly what they showed before.

A SeaBIOS series is on its list [1] that probes the disk change line before
media sensing; with it, the same read takes 0.11 s and answers 0x80 ("not
ready"), which DOS and Windows both render correctly.  The two are
independent -- neither waits for the other.

[1] https://mail.coreboot.org/archives/list/seabios@seabios.org/thread/K2QGADPOTAEEZRQS5T6PKZLDQUBO62HY/

Christian Quante (2):
  hw/block/fdc: select the drive named by the READ ID command
  hw/block/fdc: report a missing address mark on an empty drive

 hw/block/fdc.c         | 54 +++++++++++++++++++++++++++-----
 tests/qtest/fdc-test.c | 70 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 15 deletions(-)

-- 
2.53.0


