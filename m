Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EEF105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dum-0001sL-V6; Thu, 12 Mar 2026 07:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0duf-0001rh-V2; Thu, 12 Mar 2026 07:09:11 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1w0dud-0005gG-8F; Thu, 12 Mar 2026 07:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N0oVq7enY0AMcRDpOdeUjlw7EnBG7mi9n1D8h16P66o=; b=arLk2/nKmwRJh5TjwyxkySwyrY
 +9+6XOCgU8WlBHbNo9vBoi1bz10MCVK0YWeR6J0TK4SKldS0UrEL6Gs7lfM/zmHFvqsMrPP69p5id
 qRraC1jSHqdPRynuUL4TTTPTscBUJ/yBo3d4YPO7P/yZ7aKRba+I6prU9kV7Zf4Qs9LFNuchHbegH
 sWxHe6jiBt0Uy+7ai5pzfhUYJwoFZVkj25+0xDxJIEW1U2Qd4kb3Xn7z5YVgtSzm5RDQhL7E+FrAl
 Gqrth9hGRZFcUWRUHMebuq9/XEQWZzQLJEKQQCoUs1szeqV3wEF77MKP+PrcNOE4Z5Wf86DwF7Gbn
 f3nG3Rbg==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w0duW-00ESkC-0E; Thu, 12 Mar 2026 12:09:00 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1w0duV-00000000JZJ-3QsZ;
 Thu, 12 Mar 2026 12:08:59 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>,
 Jorge Merlino <jorge.merlino@canonical.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Subject: [PATCH v2 0/1] Fix race condition in throttle_group_restart_queue()
Date: Thu, 12 Mar 2026 12:08:41 +0100
Message-ID: <cover.1773313028.git.berto@igalia.com>
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

here's version two of the patch. The important change is that now
throttle_group_restart_tgm() is protected by tg->lock and there's new
logic there.

Note that in case (2) it is theoretically possible for two different
tgms to run throttle_group_restart_queue() in parallel, but I think
this is safe because the actual restart of the queue is once more
protected by the lock.

The alternative that I initially considered (doing nothing if another
tgm is waiting for a timer) is probably not a good idea because
throttle_group_restart_tgm() is used by callers who want to drain a
tgm so I think that the requests should be processed immediately:

    if (qatomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
        throttle_group_restart_tgm(tgm);
    }

Once more, please test this carefully to see if it solves issue #3194.
I have only run the basic qemu iotests and I haven't touched this code
in a long time :)

Regards,

Berto

Alberto Garcia (1):
  throttle-group: Fix race condition in throttle_group_restart_queue()

 block/throttle-groups.c | 70 +++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 16 deletions(-)

-- 
2.47.3


