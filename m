Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C268F105A58D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0etk-0007HS-3u; Thu, 12 Mar 2026 08:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0etf-0007Gv-9U; Thu, 12 Mar 2026 08:12:12 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0etd-0005KO-JV; Thu, 12 Mar 2026 08:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tU7DcSzG4xVxL0xHH4T/2iO3kkKBW5rQZgAh7fCGlKI=; b=QvtxGYKZeBkrDh2fydifh+qceO
 6wPwoTY7m22M51Hilu+lAbFYyMpAgV8VNnPjrQh3+53Q4KK5J3XSDhVPhEB3KQ7rgYfcQmAtBYboc
 He1gXP5Z/qCwFysmQcD1l6sY2QBHDEvEP2MBMfQ/CWOa3Sau7u6Hjlh5bcrqAPEiMUm9Q1MaDl3pb
 fyNajgaEND3Z/g2RZZ3qnYVhtcQTyTYDBWGfFv3+Zv5LjDlgLi3eayYbKVrx3iXboAwXstMVNKXCv
 bEI6b0MkbRJEidJTiSuxRRqbS56XVDUXy7nCrS2v2bg4XzO283OJwSN18MK9LoquBqilL6/aKgw3y
 FzUKrbig==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0etW-00EUAL-9I; Thu, 12 Mar 2026 13:12:02 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1w0etW-00000000Lq4-0hu4;
 Thu, 12 Mar 2026 13:12:02 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>,
 Jorge Merlino <jorge.merlino@canonical.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH v3 0/1] Fix race condition in throttle_group_restart_queue()
Date: Thu, 12 Mar 2026 13:11:59 +0100
Message-ID: <cover.1773316842.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

In the previous patch I forgot to relax the assertion for case 2.

If we're restarting the queue when another tgm has a timer armed I
don't think we can guarantee that when the timer fires it won't set a
new timer on our own tgm before we reach the assertion.

I think that the assertion should depend on reset_timer_armed:

- If it's true, no one else can arm a timer so the assertion holds.
- If it's false, it is possible for the other tgm to arm our timer.
  The assertion would fail in this case, but I think it's harmless
  because even if it would fire at the same time the logic in
  throttle_group_restart_queue_entry() is protected by the lock.

Berto

Alberto Garcia (1):
  throttle-group: Fix race condition in throttle_group_restart_queue()

 block/throttle-groups.c | 79 +++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 19 deletions(-)

-- 
2.47.3


