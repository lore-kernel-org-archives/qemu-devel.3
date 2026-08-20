Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49E6C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2MP-0005NK-IC; Thu, 20 Aug 2026 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2ML-0005Mu-6S
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:06 -0400
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wx2MG-0005Rb-5V
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787230729; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ekq1fgGdR0wUMCUsKnUeYI3hkzurmu4w5XmF5T/r8+s=;
 b=nkWPvrnem5HYBoXbqPBXu2NhCLq41uZobHeNmO6uYNCf+05dZAzQA90OaRcL2r0WAZlMWb
 33Iknrz/auNsHLFuEJHk86jSuJarWa1Mcd/xxV7X4fb8oQazEON2u8dOv2GOZxLOKIRAmf
 WBPFKdJOLkGZk9qHM4q+UcVdVKFZI4C7KCVcj63/hzPYgPegXGq24LErJszsS2nDsI6xkk
 ZTwzFxB6mGQO8VIoVjX5uq+Kv+z0CdkCBiHu+c/rm9FLAbay+Mr+Rjs4xz0KShXuma11ND
 M08SH6f/Kg1ELq5JBiBO8JWXiWdmGqjMV2RGcgCfAIGlwMqKxWrM6SjsIEc7PQ==
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <isyanfei.xu@gmail.com>, <jinpu.wang@cloud.ionos.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [RFC PATCH v1 0/2] migration/rdma: Allow multiple writes per chunk
Message-Id: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: quoted-printable
To: <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.20.1
Date: Thu, 20 Aug 2026 20:58:31 +0800
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a86fa07+41f1f1+nongnu.org+yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.115;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-115.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

My understanding is that within each iteration round, the HVAs carried by
different WRs never overlap, so serializing WRs within the same chunk isn't
necessary. This patchset builds on that assumption =E2=80=94 please correct=
 me if
I've missed or misunderstood anything.

This series improves RDMA migration throughput during the iteration phase
and iterable stop-copy phase by allowing multiple writes to the same
registration chunk.

RDMA tracks RAM in registration chunks.  During the final iterable
transfer, workloads always leave many scattered 4 KiB dirty pages, with
several pages falling into the same chunk.  The current code waits for
an earlier write to a chunk to complete before posting the next one.
These serial completion waits can leave send queue capacity unused and
limit RDMA bandwidth, increasing downtime.

The first patch replaces the per-chunk transit bitmap with reference
counts.  The second patch removes the per-chunk wait.

rdma_registration_start/stop functions called in each round synchronously
drain all in-flight WRs with cq, which can serve as a barrier between
rounds.

The test configuration is:

  RDMA chunk size:    32 MiB
  Guest:              32 vCPUs, 128 GiB RAM
  Test runs:          10
  Max HCA bandwidth:  100 Gbs
  Workload:           idle

Average results:              Before       After
  pin-all is true
  Downtime                    396.7 ms     345.7 ms        ~12.9% improve
  Final iterable bandwidth    9952.0 MiB/s 11639.10 MiB/s  ~17.0% improve


Average results:              Before       After
  pin-all is false
  Downtime                    248.7 ms     191.1 ms        ~23.2% improve
  Final iterable bandwidth    5605.1 MiB/s 9826.0 MiB/s    ~75.3% improve

Note: Final iterable bandwidth actually means the bandwidth during
qemu_savevm_state_complete_precopy_iterable(). non-iterable data doesn't
use RDMA Write.

Yanfei Xu (2):
  migration/rdma: Track in-flight writes with refcounts
  migration/rdma: Allow multiple in-flight writes per chunk

 migration/rdma.c       | 65 +++++++++++++++++++++++-------------------
 migration/trace-events |  5 ++--
 2 files changed, 37 insertions(+), 33 deletions(-)

--=20
2.20.1

