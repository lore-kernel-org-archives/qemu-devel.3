Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EBCCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrYZu-0000tL-Ug; Tue, 02 Apr 2024 03:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYZs-0000s2-JJ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:29:04 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYZf-0004E7-BX
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712042931; x=1743578931;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9dvp8iow08bQOjXQY2sFqws89NagzWZ3YmjimA13qtg=;
 b=QRPJfpRl1yeVFkHIBxwWaLtknET6rn3GpXfnCcEdUpffqmniuLRy02HU
 C5k8z7/Jk33+Y9hHghxaCnxx9E3CdociRIR5RcDc3NO2sPmaUdq8haEAt
 JP33CysJZ5HW9wUSklQkJpUD8XFyck9nAnilXiCf3wXQe94vPW0fOPu3Z
 QmNB6hGqCKgSsoZXzr5jprOIGVvb9fxaeDuxQA1aLfsTcUYFrELvizz0b
 ut0r/SCkAlZuazSt4fl9ajI/J3ZZLIphuGBtg7ePvlMR4i/J0o6Ga4XCC
 HnqwZnlHC6cT2Sb/ygLqUfRzDtOc/9sBZIXwak4xPmlDA33R3E8RCrEb3 A==;
X-CSE-ConnectionGUID: XOXexr3kQVCBKwQmSQ11Lg==
X-CSE-MsgGUID: VYpD7YKOQmKUTozU33qruw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7063827"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7063827"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 00:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="18434379"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa006.jf.intel.com with ESMTP; 02 Apr 2024 00:28:46 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH 0/1] Solve zero page causing multiple page faults
Date: Mon,  1 Apr 2024 23:41:09 +0800
Message-Id: <20240401154110.2028453-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1. Description of multiple page faults for received zero pages
    a. -mem-prealloc feature and hugepage backend are not enabled on the
       destination
    b. After receiving the zero pages, the destination first determines if
       the current page content is 0 via buffer_is_zero, this may cause a
       read page fault

      perf record -e page-faults information below
      13.75%  13.75%  multifdrecv_0 qemu-system-x86_64 [.] buffer_zero_avx512
      11.85%  11.85%  multifdrecv_1 qemu-system-x86_64 [.] buffer_zero_avx512
                      multifd_recv_thread
                      nocomp_recv
                      multifd_recv_zero_page_process
                      buffer_is_zero
                      select_accel_fn 
                      buffer_zero_avx512

   c. Other page faults mainly come from writing operations to normal and
      zero pages.

2. Solution
    a. During the multifd migration process, the received pages are tracked
       through RAMBlock's receivedmap.

    b. If received zero page is not set in recvbitmap, the destination will not
       check whether the page content is 0, thus avoiding the occurrence of
       read fault.

    c. If the zero page has been set in receivedmap, set the page with 0
       directly.

    There are two reasons for this
    1. It's unlikely a zero page if it's sent once or more.
    2. For the 1st time destination received a zero page, it must be a zero
       page, so no need to scan for the 1st round.

3. Test Result 16 vCPUs and 64G memory VM,  multifd number is 2,
   and 100G network bandwidth

    3.1 Test case: 16 vCPUs are idle and only 2G memory are used
    +-----------+--------+--------+----------+
    |MultiFD    | total  |downtime|   Page   |
    |Nocomp     | time   |        | Faults   |
    |           | (ms)   | (ms)   |          |
    +-----------+--------+--------+----------+
    |with       |        |        |          |
    |recvbitmap |    7335|     180|      2716|
    +-----------+--------+--------+----------+
    |without    |        |        |          |
    |recvbitmap |    7771|     153|    121357|
    +-----------+--------+--------+----------+
                                                  
    +-----------+--------+--------+--------+-------+--------+-------------+
    |MultiFD    | total  |downtime| SVM    |SVM    | IOTLB  | IO PageFault|
    |QPL        | time   |        | IO TLB |IO Page| MaxTime| MaxTime     |
    |           | (ms)   | (ms)   | Flush  |Faults | (us)   | (us)        |
    +-----------+--------+--------+--------+-------+--------+-------------+
    |with       |        |        |        |       |        |             |
    |recvbitmap |   10224|     175|     410|  27429|       1|          447|
    +-----------+--------+--------+--------+-------+--------+-------------+
    |without    |        |        |        |       |        |             |
    |recvbitmap |   11253|     153|   80756|  38655|      25|        18349|
    +-----------+--------+--------+--------+-------+--------+-------------+


    3.2 Test case: 16 vCPUs are idle and 56G memory(not zero) are used
    +-----------+--------+--------+----------+
    |MultiFD    | total  |downtime|   Page   |
    |Nocomp     | time   |        | Faults   |
    |           | (ms)   | (ms)   |          |
    +-----------+--------+--------+----------+
    |with       |        |        |          |
    |recvbitmap |   16825|     165|     52967|
    +-----------+--------+--------+----------+
    |without    |        |        |          |
    |recvbitmap |   12987|     159|   2672677|
    +-----------+--------+--------+----------+

    +-----------+--------+--------+--------+-------+--------+-------------+
    |MultiFD    | total  |downtime| SVM    |SVM    | IOTLB  | IO PageFault|
    |QPL        | time   |        | IO TLB |IO Page| MaxTime| MaxTime     |
    |           | (ms)   | (ms)   | Flush  |Faults | (us)   | (us)        |
    +-----------+--------+--------+--------+-------+--------+-------------+
    |with       |        |        |        |       |        |             |
    |recvbitmap |  132315|      77|     890| 937105|      60|         9581|
    +-----------+--------+--------+--------+-------+--------+-------------+
    |without    |        |        |        |       |        |             |
    |recvbitmap | >138333|     N/A| 1647701| 981899|      43|        21018|
    +-----------+--------+--------+--------+-------+--------+-------------+


From the test result, both of page faults and IOTLB Flush operations can
be significantly reduced. The reason is that zero page processing does not
trigger read faults, and a large number of zero pages do not even trigger
write faults (Test 3.1), because it is considered that after the destination
is started, the content of unaccessed pages is 0.

I have a concern here, the RAM memory is allocated by mmap with anonymous
flag, and if the first received zero page is not set to 0 explicitly, does
this ensure that the received zero pages memory data is 0?

In this case, the performance impact of live migration is not big
because the destination is not the bottleneck.

When using QPL (SVM-capable device), even if IOTLB is improved, the
overall performance will still be seriously degraded because a large
number of IO page faults are still generated.

Previous discussion link:
1. https://lore.kernel.org/all/CAAYibXib+TWnJpV22E=adncdBmwXJRqgRjJXK7X71J=bDfaxDg@mail.gmail.com/
2. https://lore.kernel.org/all/PH7PR11MB594123F7EEFEBFCE219AF100A33A2@PH7PR11MB5941.namprd11.prod.outlook.com/

Yuan Liu (1):
  migration/multifd: solve zero page causing multiple page faults

 migration/multifd-zero-page.c | 4 +++-
 migration/multifd-zlib.c      | 1 +
 migration/multifd-zstd.c      | 1 +
 migration/multifd.c           | 1 +
 migration/ram.c               | 4 ++++
 migration/ram.h               | 1 +
 6 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.39.3


