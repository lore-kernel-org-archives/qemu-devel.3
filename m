Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57867C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vidrW-0000QD-3U; Wed, 21 Jan 2026 14:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrU-0000Mf-6E
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:28 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrQ-0001l1-13
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 461D280807;
 Wed, 21 Jan 2026 22:27:18 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d28::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HRhSvR2A7Os0-1UgtljRV; Wed, 21 Jan 2026 22:27:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769023637;
 bh=3247OufLvc3Fru1FSNsjlVGWAXMqm0MKGeQKTofmyJc=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=rParVtushIaYBepWwP09jGeCvdlcCeJ7lc7C2h2oL6xKh8nhPXID+I6whj69o+9pa
 XOc3AhbPjEmrbQyjcI5jrAcoaoTXas8J4FxZU6S8TrTkO51UdgV4D3SJCMr2d2Rr/j
 bzrQj4QdzSKC8H7kWJV+rPfbnzhjnNPcaV7T4/xw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 0/3] net/tap: a bit more refactoring
Date: Wed, 21 Jan 2026 22:27:10 +0300
Message-ID: <20260121192713.133470-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi!

Here three more small enhancements, based on my
"[PATCH v9 0/7] net/tap: simple refactoring"
Based-on: <20251030164023.710048-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (3):
  net/tap: net_init_tap_one(): add return value
  net/tap: net_init_tap(): drop extra vhostfdname variable
  net/tap: net_init_tap(): refactor parameter checking

 net/tap.c | 73 +++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

-- 
2.52.0


