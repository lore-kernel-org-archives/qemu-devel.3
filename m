Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34478C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7sU-00054z-7H; Wed, 31 Jan 2024 05:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7sS-00052S-4E
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7sQ-0005a6-Eu
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706697090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wX1BORCLp8QvqyzYMDRrFprLilWf5t970YHgNY15AKI=;
 b=fBGa02Ye3NtuQ1BtXvTYBkkqQTjfTGubi1QWySkfxCw436UG/BqD95wn0ZXCAO2YVzdwot
 +RpJ7C1hHECUJ0PBiGjAZUCQkmnrOMtjt5+dBsLKxmAei7D0VAQ16lTrUNtVqk7/vMaLLN
 YwUqcyRMx/yF/hcZDLzIcTn8PwFkz1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-Bv9sepM6MfSGCTSEPauRNw-1; Wed, 31 Jan 2024 05:31:18 -0500
X-MC-Unique: Bv9sepM6MfSGCTSEPauRNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63410101A526;
 Wed, 31 Jan 2024 10:31:18 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2A83107BD;
 Wed, 31 Jan 2024 10:31:13 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 00/14] migration/multifd: Refactor ->send_prepare() and
 cleanups
Date: Wed, 31 Jan 2024 18:30:57 +0800
Message-ID: <20240131103111.306523-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

This patchset contains quite a few refactorings to current multifd:

  - It picked up some patches from an old series of mine [0] (the last
    patches were dropped, though; I did the cleanup slightly differently):

    I still managed to include one patch to split pending_job, but I
    rewrote the patch here.

  - It tries to cleanup multiple multifd paths here and there, the ultimate
    goal is to redefine send_prepare() to be something like:

      p->pages ----------->  send_prepare() -------------> IOVs

    So that there's no obvious change yet on multifd_ops besides redefined
    interface for send_prepare().  We may want a separate OPs for file
    later.

For 2), one benefit is already presented by Fabiano in his other series [1]
on cleaning up zero copy, but this patchset addressed it quite differently,
and hopefully also more gradually.  The other benefit is for sure if we
have a more concrete API for send_prepare() and if we can reach an initial
consensus, then we can have the recent compression accelerators rebased on
top of this one.

This also prepares for the case where the input can be extended to even not
any p->pages, but arbitrary data (like VFIO's potential use case in the
future?).  But that will also for later even if reasonable.

Please have a look.  Thanks,

[0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
[1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de

Peter Xu (14):
  migration/multifd: Drop stale comment for multifd zero copy
  migration/multifd: multifd_send_kick_main()
  migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
  migration/multifd: Postpone reset of MultiFDPages_t
  migration/multifd: Drop MultiFDSendParams.normal[] array
  migration/multifd: Separate SYNC request with normal jobs
  migration/multifd: Simplify locking in sender thread
  migration/multifd: Drop pages->num check in sender thread
  migration/multifd: Rename p->num_packets and clean it up
  migration/multifd: Move total_normal_pages accounting
  migration/multifd: Move trace_multifd_send|recv()
  migration/multifd: multifd_send_prepare_header()
  migration/multifd: Move header prepare/fill into send_prepare()
  migration/multifd: Forbid spurious wakeups

 migration/multifd.h      |  34 +++--
 migration/multifd-zlib.c |  11 +-
 migration/multifd-zstd.c |  11 +-
 migration/multifd.c      | 291 +++++++++++++++++++--------------------
 4 files changed, 182 insertions(+), 165 deletions(-)

-- 
2.43.0


