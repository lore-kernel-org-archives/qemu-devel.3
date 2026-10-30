Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A7606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cbN+orWC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnTP-00061o-Ln; Fri, 30 Oct 2026 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xMnTL-000611-LZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xMnTJ-0003FA-GK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:20:47 -0400
Received: from laptop.localdomain (unknown [81.196.141.157])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2233520B7172;
 Fri, 30 Oct 2026 07:20:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2233520B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793370030;
 bh=8YYAiKf9nIww5PjS7RNP4RymjOj6pnwOyDgWmUMQLfo=;
 h=From:To:Cc:Subject:Date:From;
 b=cbN+orWCe0A2zElXQdKg39JIkBLKDT+/L+hzSaF6c56qLqFFHUIIEmh+g7Z6ezVjZ
 4uk294PMgJNVBUhPMnXWtMC0MI9xrrj/qGzkdf5Vh98TQl1wOJUnZjVX/qg+zbFcmw
 m4nGbcaxfUUB3VEkHMMhB/lHnruqTv3fPST9Hl8I=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [RFC PATCH 0/3] mshv: Fix soft reboot by using scrub partition ioctl
 on init
Date: Fri, 30 Oct 2026 16:20:34 +0200
Message-ID: <20261030142037.267641-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is an RFC because, the kernel mshv driver changes that introduce
this ioctl, are not upstream yet.
Below is a link to the posted kernel patch.
https://lore.kernel.org/linux-hyperv/20261029062801.28598-2-wei.liu@kernel.org/

This patch series uses the SCRUB_PARTITION ioctl during reset to ensure a sane
state for the mshv driver.

The series consists of:
1. accel/mshv: mask mshv cpus as resetable
2. include/hw/hyperv: Add SCRUB_PARTITION ioctl
3. accel/mshv: use scrub_partition ioctl on init

The second commit that adds the SCRUB_PARTITION ioctl definition can be dropped
once the kernel patch is merged and the Qemu linux-headers are updated.

In short, the changes mark the vCPUs as resettable and run the SCRUB_PARTITION
ioctl on the `synchronize_post_reset` hook for the first vCPU.

Doru Blânzeanu (2):
  include/hw/hyperv: Add SCRUB_PARTITION ioctl
  accel/mshv: use scrub_partition ioctl on init

Magnus Kulke (1):
  accel/mshv: mark mshv cpus as resetable

 accel/mshv/mshv-all.c          | 27 +++++++++++++++++++++++++--
 include/hw/hyperv/hvgdk_mini.h |  2 ++
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.54.0


