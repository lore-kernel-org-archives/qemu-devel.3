Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C1AECD6C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCkY-0002p4-TF; Wed, 11 Feb 2026 11:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXl-0007D8-3g
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:21 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXj-0003Pc-10
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:20 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id A158C20B7167;
 Wed, 11 Feb 2026 07:54:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A158C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825255;
 bh=b12IWzWaAGfGWHSTneMNEouN9cjQ7w/64qtAbAwZrMo=;
 h=From:To:Cc:Subject:Date:From;
 b=EIIQF3UuwFnNZvSllSEgYxn0HcSNXIZYD3DN5H3xBzFnpmvr1GZ34IvjQ5e8e+miI
 L7UiS1jZDJ/hDJgUlIBm38t2P7tIUhcBOUR8974LetCkMjrqdAr3WXd17oobT28cPh
 8vJo31hnFEvH/SYZ54sA0xB47Q4uEgi5lq2xtqOU=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 00/10] Support QEMU cpu models in MSHV accelerator
Date: Wed, 11 Feb 2026 16:54:00 +0100
Message-Id: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:28 -0500
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

Hey all,

In the current MSHV accelerator code passing CPU features via the -cpu
flag doesn't work as intended yet. When using the MSHV hypervisor we
either silently discard the specified model/features and leave it up
to the hypervisor to provide a sensible set of features or if the user
selects -cpu host, the hypervisor might refuse to create a partition.

This changeset introduces a more comprehensive support for passing
desired guest cpu features to the hypervisor. It's also a prerequisite
for Live Migration support, in which we have to roundtrip CPU State
explicitly

Known issues:

We will probably have to iterate a bit more on this, since recently
support for CET_U/CET_S xstate bits has been introduced in QEMU, which
doesn't harmonize with our current approach of configuring the
hypervisor with static responses to cpuid queries.

Drive-by fixes:

- tiny fix in MAINTAINERS
- adding packed attribute to inlined UAPI structs

best,

magnus

Magnus Kulke (10):
  MAINTAINERS: fix magnuskulke email-address
  include/hw/hyperv: add QEMU_PACKED to uapi structs
  accel/mshv: use mshv_create_partition_v2 payload
  target/i386/mshv: fix cpuid propagation bug
  target/i386/mshv: fix various cpuid traversal bugs
  target/i386/mshv: change cpuid mask to UINT32_MAX
  target/i386/mshv: set cpu model name on -cpu host
  target/i386: query mshv accel for supported cpuids
  target/i386/mshv: populate xsave area offsets
  target/i386/mshv: filter out CET bits in cpuid

 MAINTAINERS                    |   4 +-
 accel/mshv/mshv-all.c          |  35 ++++--
 include/hw/hyperv/hvgdk_mini.h |  39 ++++--
 include/hw/hyperv/hvhdk.h      | 199 ++++++++++++++++++++++++++++-
 include/system/mshv.h          |   3 +
 target/i386/cpu.c              |   8 ++
 target/i386/mshv/mshv-cpu.c    | 221 ++++++++++++++++++++++++++-------
 7 files changed, 438 insertions(+), 71 deletions(-)

-- 
2.34.1


