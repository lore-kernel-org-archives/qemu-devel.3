Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073EC5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSA4-0006Dn-J9; Thu, 13 Aug 2026 05:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9u-0006Ch-1x
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:39 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9q-0005sZ-6X
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786614903; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=IzkPYZzZrVAczldITxa5lsdVHt8dfwYdNuDBYIXSf7o=;
 b=hVlLaQ4Og8bpziO+XZY+hwtYqeJdX5jNbDFJWEfka4Si2hdAC7uskjM3GJAYUwjcV69+cBtlkEupBItnk506XXFiLqwr3KDuZGXELryZMx48WSaMYSM2qgURnKCrSClHz2soGE5MGUWcTqxAa8myGTm8eqpuzZVyVESHH6vBOLo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X8u9fNJ_1786614902; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8u9fNJ_1786614902 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 13 Aug 2026 17:55:02 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] libvhost-user: fix postcopy shared memory faults
Date: Thu, 13 Aug 2026 17:54:59 +0800
Message-ID: <20260813095501.20282-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

These two independent bugs both sit on the libvhost-user postcopy path and
together make postcopy migration of a guest with a libvhost-user backend
fail.  They are only reachable when the backend negotiates
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, i.e. it adds memory regions one
by one with VHOST_USER_ADD_MEM_REG instead of VHOST_USER_SET_MEM_TABLE.

Patch 1 stops the backend from panicking on the "all postcopy client bases
received" ack, which QEMU sends as an fd-less VHOST_USER_ADD_MEM_REG.

Patch 2 makes the backend return its mapping address for a region added
that way, without which QEMU cannot translate the backend's fault
addresses back to a RAMBlock.

Reproduced and fixed with contrib/vhost-user-bridge as the net backend of
a postcopy migrated guest: before the series the destination backend
either panics or QEMU reports "Failed to find region for fault"; after it
the migration completes.

Bin Guo (2):
  libvhost-user: accept the postcopy client base ack in vu_add_mem_reg()
  libvhost-user: return the backend mapping address for added regions

 subprojects/libvhost-user/libvhost-user.c | 34 ++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
2.50.1 (Apple Git-155)


