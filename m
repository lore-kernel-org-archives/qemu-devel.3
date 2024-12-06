Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942A8E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7L-0004LA-7p; Fri, 06 Dec 2024 17:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7G-0004Kk-6o
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7D-0002P8-QW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+Fkg/7cYOKwyJQydpOJlGtHFlIosoCFOSZD7Yx9UNW8=;
 b=ggnnbHarGxxHVNLP1oKdrnRT4Xw634HiqIv4Y9CHPSp1xGbdG+tnoI38cZ3UiVmzioo63n
 lNU00YADUBdXstPPvLpDfEr6vmgGGtPtpOctS50siMi+SnUQ48w5oRm4ywchCjwNigiO2I
 5O/cvzr9XSm4bIjC0ms5Ev9kGlYN8Lw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-MnYod6qnPXGlfx-8MVr5-w-1; Fri, 06 Dec 2024 17:47:59 -0500
X-MC-Unique: MnYod6qnPXGlfx-8MVr5-w-1
X-Mimecast-MFC-AGG-ID: MnYod6qnPXGlfx-8MVr5-w
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-843e91a4b37so262587739f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525278; x=1734130078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Fkg/7cYOKwyJQydpOJlGtHFlIosoCFOSZD7Yx9UNW8=;
 b=eAX8Sh9wPeQWFY+9/GHY/bzqG6KLywoOmjO39YkLnhgZGRXaFP71oBfRcyo6GRHze0
 GyNZSgrTdSsplRF4cLSdjWkx05IkKONOdeRXiSDCE/qj3Pbo8fPwhAs7zpMgOVb+haWF
 bQRRMg4E6PbdHvS4Ph9gvLVR67HGP3yYGavRRT/bbW7QPwR3aGoywmYpnkU5ZS6WuIx5
 fyOmHWgYrUsZ7+7FZ0IwKZZSyKdFO1FehDrwvxUzohCeQmElNUjRUbgMwza7f7x1uijT
 Y1b5Zz5/XVP5ZGAaMkZCx0ysfhA1FisGABWooMWhIrqrbbGqBUBseCj4YdW53dpUMRv6
 dpew==
X-Gm-Message-State: AOJu0YxbX7A3RWJPuMwGxStuIw4S5KPxsEf7Gl2FlVYMgrpdlu81+o22
 vS7ftIYZOgUbQAnvotd1qPJDYCJxRGVJhs/7V4eND13LxM88n/av8kphadme8SVwsXPTQmU63qW
 eWZ5YmfoIHu4M9CYe6a9RRoAWXcnyv+xBGTLNagKdzeGyOB7Dmytdomo5CcF3tLgEMb5gZX2ygh
 yDWJBikggF65z5B1h9mQcCS4rrC+tgkW1HYQ==
X-Gm-Gg: ASbGnct6TxrXM9MylxnNslswrpryinkYe2L3o+krbJJR/02l/Ln8J9nwfe6PyHnoyha
 PZwycPLXZV+qTgnVpNdT1NjfGUI4BuYRUaE/qDwuUWTzETmajMloEJrEtMjkJqb74pCGzinUkDG
 w//M+dD0hQEm5mIkqGPIJ5rrmzIY3+qEbSyvWN2qSVkzINhOqy9DwKQoFqZe4C7FA0lp12l467z
 0Hk2/NWsGe8PxjKFZhWTY/MrVAPs8/lMFcbQBlY5aOwvklTK2jed8R01cHciTqjOsSY140A51Nq
 XUh62DzLmX3gEAgo71bR0RC+/A==
X-Received: by 2002:a05:6602:6c02:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8447e376d6amr779930939f.14.1733525278450; 
 Fri, 06 Dec 2024 14:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8DSqaxj415LP8wRw0CtLJD/nOFoGNi/rQAvcBgEg8FjnENUr6HA+fY/OPMACjE4aQ2MVY7g==
X-Received: by 2002:a05:6602:6c02:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8447e376d6amr779927739f.14.1733525278060; 
 Fri, 06 Dec 2024 14:47:58 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:47:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 0/7] migration/multifd: Some VFIO / postcopy preparations
 on flush
Date: Fri,  6 Dec 2024 17:47:48 -0500
Message-ID: <20241206224755.1108686-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/1577280033
 (note: it's a pipeline of two patchsets, to save CI credits and time)

v1: https://lore.kernel.org/r/20241205185303.897010-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20241206005834.1050905-1-peterx@redhat.com

v3 changelog:
- R-bs collected
- Update commit message of patch 1 [Fabiano]
- English updates [Fabiano]
- Update comment for MULTIFD_SYNC_ALL [Fabiano]
- In multifd_send_sync_main(), assert on req type [Fabiano]
- Some more comments and cleanup for RAM_SAVE_FLAG_* movement [Fabiano]
- Update the last document patch [Fabiano]

This series provides some changes that may be helpful for either VFIO or
postcopy integration on top of multifd.

For VFIO, only patches 1 & 2 are relevant.

For postcopy, it's about patches 3-7, but it needs to be based on 1+2
because of a context dependency.

All these patches can be seen as cleanups / slight optimizations on top of
master branch with/without the VFIO/postcopy work.

Besides CI, qtests, and some real-world multifd tests just to monitor the
sync events happen all correct, I made sure to cover 7.2 machine type
(which uses the legacy sync) so it still works as before - basically sync
will be more frequent, but all thing keeps working smoothly so far.

Thanks,

Peter Xu (7):
  migration/multifd: Further remove the SYNC on complete
  migration/multifd: Allow to sync with sender threads only
  migration/ram: Move RAM_SAVE_FLAG* into ram.h
  migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH messages
  migration/multifd: Remove sync processing on postcopy
  migration/multifd: Cleanup src flushes on condition check
  migration/multifd: Document the reason to sync for save_setup()

 migration/multifd.h        | 27 ++++++++++--
 migration/ram.h            | 28 ++++++++++++
 migration/rdma.h           |  7 ---
 migration/multifd-nocomp.c | 74 ++++++++++++++++++++++++++++++-
 migration/multifd.c        | 17 +++++---
 migration/ram.c            | 89 +++++++++++++++++---------------------
 6 files changed, 173 insertions(+), 69 deletions(-)

-- 
2.47.0


