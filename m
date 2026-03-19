Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507AE108E1F4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BiW-0007J3-6X; Thu, 19 Mar 2026 07:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3BiT-0007Ic-2x
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:05 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3BiO-0004aq-Tn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1773920324; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wqboUZ0f6vFFVw5ws29kYKMSNzJiaVUpowo2r2mSgt0=;
 b=IsqhoX0RvLMpa90t0y/rezTTjueZH7CrrEGFqq5IWK/SQgG1S0bFNDX2KufFlXcZQRfcT4
 qx9XZ6h1cSP/F6UXCTW7Qd1JPQwq99R1mqq9fbvvVLmlJH4naTupTNvvHyc5k2okQCMgCU
 dxlEiC4y/US6M3WhQVMvwzMK8368rWG3x6HOBElN+udoPvjUVVnhwXud/ximdent3TExZK
 XmgP+b66S5eLhZInmCe92h4tYp5bknzD/dpKxCztEA8SajxKzPLhwyA7QVj+QUKGFuOhU3
 QnKZjV4yv8WfWROhvBFbRFqFuOoK7SGFpWtOWKXk7p4HmiGoO4S8ql5M0JloQg==
Subject: [RFC V2 0/2] migration: optimize cpr fd lookup using GHashTable
X-Lms-Return-Path: <lba+269bbe042+d80d80+nongnu.org+hongmianquan@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "hongmianquan" <hongmianquan@bytedance.com>
Date: Thu, 19 Mar 2026 19:38:28 +0800
Mime-Version: 1.0
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <mark.kanda@oracle.com>, 
 <bchaney@akamai.com>, "hongmianquan" <hongmianquan@bytedance.com>
Message-Id: <20260319113830.53867-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-112.ptr.blmpb.com
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

Currently, the CPR subsystem in QEMU uses a QLIST to store fds.
In scenarios where a large number of
fds are involved (such as a VM with many vfio-pci devices), looking up an fd
via `cpr_find_fd` becomes a performance bottleneck due to the O(N) linear search.
This patch series optimizes the cpr fd storage by replacing the QLIST
with a GHashTable. The time complexity for `cpr_find_fd` is reduced
from O(N) to O(1).

To demonstrate the performance improvement, we tested the total time
consumed by `cpr_find_fd` (called N times for N fds) under our real-world
business scenarios with different numbers of file descriptors. The results
are measured in nanoseconds:

| Number of FDs | Total time with QLIST (ns) | Total time with GHashTable (ns) |
|---------------|----------------------------|---------------------------------|
| 540           | 936,753                    | 393,358                         |
| 2,870         | 24,102,342                 | 2,212,113                       |
| 7,530         | 152,715,916                | 5,474,310                       |

As shown in the data, the lookup time grows exponentially with the QLIST
as the number of fds increases. With the GHashTable, the time consumption
remains linear (O(1) per lookup), significantly reducing the downtime during
the CPR process.

We choose to migrate the GHashTable directly rather than migrating a
QLIST and rebuilding the hash on the destination side. Since `cpr_find_fd`
is used during normal runtime (where fds are frequently added or deleted),
reconstructing the hash would require us to maintain and synchronize both
a QLIST and a temporary hashtable simultaneously on both the source and
destination sides.
Migrating the GHashTable natively keeps `cpr_state.fds` as the single
source of truth, eliminating synchronization overhead and potential bugs.
Additionally, the new `VMSTATE_GHASH_V` macro provides a reusable API
for other QEMU subsystems to migrate key-value mappings.

The series is structured as follows:
1. The first patch introduces migration support for `GHashTable` by
   adding the `VMSTATE_GHASH_V` macro and related save/load functions.
   This is inspired by previous implementations (e.g., commit 9a85e4b)
   and handles the serialization of hash table keys and values.
2. The second patch refactors `cpr_state.fds` from a QLIST to a
   GHashTable. It defines `CprFdKey` and `CprFdVal`, sets up the hash
   and equal functions, and updates all fd operations (save, delete,
   find, resave, walk) to use the new hash table API.

hongmianquan (2):
  migration: Support ghash migration
  cpr: use hashtable for cpr fds

 include/migration/cpr.h     |   4 +-
 include/migration/vmstate.h |  22 ++++++
 migration/cpr.c             | 129 +++++++++++++++++++++----------
 migration/trace-events      |   5 ++
 migration/vmstate-types.c   | 147 ++++++++++++++++++++++++++++++++++++
 system/vl.c                 |   2 +
 6 files changed, 269 insertions(+), 40 deletions(-)

-- 
2.32.1 (Apple Git-133)

