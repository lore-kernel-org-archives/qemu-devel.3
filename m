Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F73FFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdBf-0004hm-No; Thu, 26 Feb 2026 10:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvdBd-0004f2-TB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:21:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvdBb-0004EN-UF
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:21:57 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMFWf2tVYzJ46BS;
 Thu, 26 Feb 2026 23:20:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 6B08D40086;
 Thu, 26 Feb 2026 23:20:39 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.30.19) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 15:20:37 +0000
To: <qemu-devel@nongnu.org>, <lizhijian@fujitsu.com>
CC: <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <mst@redhat.com>, <nifan.cxl@gmail.com>,
 <peterx@redhat.com>, <philmd@linaro.org>, <ppbonzini@redhat.com>,
 <venkataravis@micron.com>, <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v6 0/3] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases
Date: Thu, 26 Feb 2026 15:20:31 +0000
Message-ID: <20260226152034.1523-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.30.19]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hey everyone,

This is v6 of performant CXL type 3 regions set:

v5 -> v6: 
          - Use object_unparent() in the third commit when deleting alias regions. 
          - Thanks to Gregory for the suggestion and testing.
v4 -> v5: 
          - Fixed some minor patch style like missing trailing white space and such.
v3 -> v4: 
          - Tear down path changed, given that it is done differently than
          setup.
          - Dropped Gregory's tested-by tag due to tear down changes.
v2 -> v3: 
          - Addressing Zhijian Li. Thanks for the feedback.
v1 -> v2: 
          - Mainly rebase.

==========================================================

The CXL address to device decoding logic is complex because of the need
to correctly decode fine grained interleave. The current implementation
prevents use with KVM where executed instructions may reside in that
memory and gives very slow performance even in TCG.

In many real cases non interleaved memory configurations are useful and
for those we can use a more conventional memory region alias allowing
similar performance to other memory in the system.

Whether this fast path is applicable can be established once the full
set of HDM decoders has been committed (in whatever order the guest
decides to commit them). As such a check is performed on each commit /
uncommit of HDM decoder to establish if the alias should be added or
removed.


Performance numbers:

For a read/write test with 4K block size, 256M region size, and 1 thread
with 100 iteration on TCG (it should do similar on KVM):

  - Non-interleaved region (fast path): 25-30 seconds.
  - Interleaved region (no fast path):  Never finishes within 10
    minutes.

Tested Topologies and Region Layouts
====================================

This series was validated across multiple CXL topology configurations,
covering single-device, multi-device, multi-host-bridge, and switched
fabrics. Region creation was exercised using the `cxl` userspace tool
with both non-interleaved and interleaved setups.

Decoder and memdev identifiers were discovered using:

  cxl list
  cxl list -D

Decoder IDs (e.g. decoder0.0) and memdev names (mem0, mem1) are
environment-specific. Commands below use placeholders such as
<decoder_span_both> which should be replaced with IDs from `cxl list -D`.

---------------------------------------------------------------------

Region Layout Notation
----------------------

CFMW (CXL Fixed Memory Window) is shown as a linear address space
containing regions:

  CFMW: [ R0 | R1 | R2 ]

R0, R1, R2 are regions created by `cxl create-region`.

Non-interleaved region:

  R0 (ways=1) -> entirely on one device (mem0 or mem1)
  Fast path: APPLICABLE

2-way interleaved region (g=256):

  R1 (ways=2, g=256) striped across devices:

    |mem0|mem1|mem0|mem1|mem0|mem1| ...
     256  256  256  256  256  256  bytes

  Fast path: NOT APPLICABLE

---------------------------------------------------------------------

1) One device, one host bridge, one fixed window
------------------------------------------------

QEMU:

  -M q35,cxl=on,cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12
  -device cxl-rp,id=rp0,bus=cxl.0,port=0,chassis=0,slot=2
  -object memory-backend-ram,id=mem0,size=512M,share=on
  -device cxl-type3,id=dev0,bus=rp0,memdev=mem0

Topology:

  Host
    |
    +-- CXL Host Bridge (cxl.0)
         |
         +-- Root Port (rp0)
              |
              +-- Type-3 (dev0, mem0)

Regions created:

  cxl create-region ... -w 1 ... mem0   (Fast path: YES)
  cxl create-region ... -w 1 ... mem0   (Fast path: YES)

Layout:

  CFMW: [ R0 | R1 ]

  R0 -> mem0  (Fast path: YES)
  R1 -> mem0  (Fast path: YES)

---------------------------------------------------------------------

2) One host bridge, two Type-3 devices (via two root ports)
------------------------------------------------------------

QEMU:

  -M q35,cxl=on,cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12
  -device cxl-rp,id=rp0,bus=cxl.0,port=0,chassis=0,slot=2
  -device cxl-rp,id=rp1,bus=cxl.0,port=1,chassis=0,slot=3
  -object memory-backend-ram,id=mem0,size=512M,share=on
  -object memory-backend-ram,id=mem1,size=512M,share=on
  -device cxl-type3,id=dev0,bus=rp0,memdev=mem0
  -device cxl-type3,id=dev1,bus=rp1,memdev=mem1

Topology:

  Host
    |
    +-- CXL Host Bridge (cxl.0)
         |
         +-- Root Port (rp0) -- Type-3 (dev0, mem0)
         |
         +-- Root Port (rp1) -- Type-3 (dev1, mem1)

Region patterns exercised:

2.1 All non-interleaved:
  R0 -> mem0  (Fast path: YES)
  R1 -> mem0  (Fast path: YES)
  R2 -> mem1  (Fast path: YES)
  R3 -> mem1  (Fast path: YES)

2.2 Interleaved + local:
  R0 -> mem0/mem1 interleaved  (Fast path: NO)
  R1 -> mem0                   (Fast path: YES)

2.3 Local + interleaved + local:
  R0 -> mem0                   (Fast path: YES)
  R1 -> mem0/mem1 interleaved  (Fast path: NO)
  R2 -> mem1                   (Fast path: YES)

---------------------------------------------------------------------

3) Two host bridges, one device per host bridge
------------------------------------------------

QEMU:

  -M q35,cxl=on,
     cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,
     cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,
     cxl-fmw.2.targets.0=cxl.0,cxl-fmw.2.size=4G
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12
  -device cxl-rp,id=rp0,bus=cxl.0,port=0,chassis=0,slot=2
  -object memory-backend-ram,id=mem0,size=512M,share=on
  -device cxl-type3,id=dev0,bus=rp0,memdev=mem0
  -device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=13
  -device cxl-rp,id=rp1,bus=cxl.1,port=0,chassis=1,slot=2
  -object memory-backend-ram,id=mem1,size=512M,share=on
  -device cxl-type3,id=dev1,bus=rp1,memdev=mem1

Region patterns identical to section 2, and fast-path applicability is
identical per region mapping (non-interleaved: YES, interleaved: NO).

---------------------------------------------------------------------

4) Switch topology
------------------

QEMU:

  -M q35,cxl=on,cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G
  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12
  -device cxl-rp,id=rp0,bus=cxl.0,port=0,chassis=0,slot=2
  -device cxl-rp,id=rp1,bus=cxl.0,port=0,chassis=0,slot=3
  -device cxl-upstream,id=us0,bus=rp0
  -device cxl-downstream,id=ds0,bus=us0,port=0,chassis=0,slot=4
  -object memory-backend-ram,id=mem0,size=512M,share=on
  -device cxl-type3,id=dev0,bus=ds0,memdev=mem0

Topology (detailed):

  Host
    |
    +-- CXL Host Bridge (cxl.0)
         |
         +-- Root Port (rp0)
         |     |
         |     +-- CXL Switch (upstream us0)
         |           |
         |           +-- Downstream Port (ds0) -- Type-3 (mem0)
         |           |
         |           +-- Downstream Port (ds1) -- Type-3 (mem1) [optional]
         +-- Root Port (rp1)
               |
               +-- More devices/switches.

Fast-path interpretation in this topology:

  If only mem0 exists:
    All regions -> Fast path: YES

  If mem0 and mem1 exist:
    Non-interleaved regions -> Fast path: YES
    Interleaved regions     -> Fast path: NO

---------------------------------------------------------------------

Summary
-------

Across all topologies, region creation, enablement, and HDM decoder
commit/uncommit flows were exercised. The fast path is enabled only when
all decoders describe a non-interleaved mapping and is removed when any
interleave configuration is introduced.

Alireza Sanaee (3):
  hw/cxl: Use HPA in cxl_cfmws_find_device() rather than offset in
    window.
  hw/cxl: Allow cxl_cfmws_find_device() to filter on whether interleaved
    paths are accepted
  hw/cxl: Add a performant (and correct) path for the non interleaved
    cases

 hw/cxl/cxl-component-utils.c |   6 +
 hw/cxl/cxl-host.c            | 224 +++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c           |   4 +
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |   4 +
 5 files changed, 230 insertions(+), 9 deletions(-)


base-commit: 6593154e7d65f61d8f9dbeb98224731b7137c53e
-- 
2.43.0


