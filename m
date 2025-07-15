Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB56C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 03:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubWWR-00045C-4n; Mon, 14 Jul 2025 23:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWM-00043h-NH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:39:59 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubWWK-0006Qm-0S
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 23:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752550796; x=1784086796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zhKngkI310nx9PU9b2zv40h2kHDRfhghd844MS9S4mY=;
 b=dJ6c05ffXbOt81q7t4NEe7EpPTmjrcFTrrnT9Kj9QKZCI+34FTAsxQGh
 0uXs/t/qZDYWxnT/OpDTKAJZuUMsGuvwISfOAqSBRjxCj47scpW4xwLFl
 J0JB2gtnovuTBT2TCLuD5ztJ9JzLNI1pTyF4GU6TfDf/WgMK6m6lglW65
 GnL35YV3YPC4nxlBvOxd/71ktdOytIuNNweJDMzE9LSgIWLjoNVSxe7Ae
 6mPlUuWvRZgJhzjDhz0sbWxFnsQqVb1rbYVBd4eKXTCQxxt58I3wq2bn4
 c63cND0WCzfXC8v0nhLZYakDa6pF5Kmv2hSX/wvks7ULGgRY3n0EYer0c A==;
X-CSE-ConnectionGUID: 2uS+/c3zTwyz+IBjbOxqdw==
X-CSE-MsgGUID: rWqZSBP/Svam+fTrd9VwVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72334912"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="72334912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 20:39:52 -0700
X-CSE-ConnectionGUID: 7lV0nEFjREiili/VteL1eQ==
X-CSE-MsgGUID: BpnnbOhaSRKnTfEwSDjg4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; d="scan'208";a="180808082"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa002.fm.intel.com with ESMTP; 14 Jul 2025 20:39:49 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 ackerleytng@google.com, seanjc@google.com
Cc: Fuad Tabba <tabba@google.com>, Vishal Annapurve <vannapurve@google.com>,
 rick.p.edgecombe@intel.com, Kai Huang <kai.huang@intel.com>,
 binbin.wu@linux.intel.com, yan.y.zhao@intel.com, ira.weiny@intel.com,
 michael.roth@amd.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [POC PATCH 0/5] QEMU: Enable in-place conversion and hugetlb gmem
Date: Tue, 15 Jul 2025 11:31:36 +0800
Message-ID: <20250715033141.517457-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
References: <cover.1747264138.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

Hi all,

This is the POC to enable in-place conversion and hugetlb support of
gmem (guest memfd) in QEMU. It can work with 1G gmem support series[1] and
TDX hugepage support series[2] to run TDX guest with hugepage. I don't
have SNP environment and don't know how it goes with SNP.

It is just the POC and we share it to show how QEMU work with gmem ABI.

The POC uses the simple implementation that switches to use in-place
conversion and hugetlb when it is supported and it doesn't introduce new
interface in QEMU so that existing command line to boot TDX can work without
any change.

Please go to each patch (specifically patch 3/4/5) to discuss the ABI
usage, potential issue, and maybe the upstreamable design.

[1] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/20250424030033.32635-1-yan.y.zhao@intel.com/

Xiaoyao Li (4):
  update-linux-headers: Add guestmem.h
  headers: Fetch gmem updates
  memory/guest_memfd: Enable hugetlb support
  [HACK] memory: Don't enable in-place conversion for internal
    MemoryRegion with gmem

Yan Zhao (1):
  memory/guest_memfd: Enable in-place conversion when available

 accel/kvm/kvm-all.c             | 82 ++++++++++++++++++++++++---------
 accel/stubs/kvm-stub.c          |  2 +
 include/system/kvm.h            |  2 +
 include/system/memory.h         |  5 ++
 include/system/ramblock.h       |  1 +
 linux-headers/linux/guestmem.h  | 29 ++++++++++++
 linux-headers/linux/kvm.h       | 18 ++++++++
 scripts/update-linux-headers.sh |  2 +-
 system/memory.c                 |  9 +++-
 system/physmem.c                | 40 ++++++++++++++--
 10 files changed, 163 insertions(+), 27 deletions(-)
 create mode 100644 linux-headers/linux/guestmem.h

-- 
2.43.0


