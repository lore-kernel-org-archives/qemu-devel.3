Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B5EC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkJA-0003da-4h; Thu, 12 Jun 2025 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkJ8-0003cy-0g
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:57:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkJ3-0003IX-M7
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:57:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6Yt027zz6K8kL;
 Thu, 12 Jun 2025 23:55:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C573C1402EC;
 Thu, 12 Jun 2025 23:57:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 17:57:25 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 QEMU 0/4] cxl/plugins: Hotness Monitoring Unit with
 'real' data.
Date: Thu, 12 Jun 2025 16:57:20 +0100
Message-ID: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RFC v2: Think of this as a WIP posting. It is useful for OS driver and
use case work but not ready for upstream QEMU.
- Integrated the previously separate CXL server with the plugin to
  avoid one hop.
- Many more control features emulated - still a few to go such as
  transaction type filtering and filtering which part of device memory
  is being tracked. It 'works' but my test set is fairly small today.
- Interleave handling.  This was fiddly given the interleave set position
  can only be discovered by walking the heirarchical decode path once
  all the decoders are committed.

+CC some of the folk in the hotness tracking Linux kernel discussions as an FYI.

Depends on: https://lore.kernel.org/qemu-devel/20250612134338.1871023-1-Jonathan.Cameron@huawei.com/
[PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
as the interleave set position discovery requires the fixed memory
windows to be devices we can search for.

I'll push out a refreshed staging tree at gitlab.com/jic23/qemu cxl-<date>
shortly but changes from tree already there for these patches are superficial only.

Performance without the patch:
https://gitlab.com/jic23/qemu/-/commit/8aa244db9490f5326f6ec07bceac27f12eea2fd2
or with interleave is slow so I'd recommend playing around with it
with that patch in place and no interleave. It will still be fairly slow
but cup of tea level rather than overnight.

Thanks to Pierrick Bouvier for suggesting squashing plugin and server.
All comments welcome!

Updated cover letter:

The main aim of this work is provide a 'real' test platform for
development of kernel support for this type of hardware prior to ready
availability of devices + later to provide a test platform everyone
can get even when devices are available. The main use case is driving
which pages to promote from CXL memory into faster local DRAM. It is
real in the sense of approximating some aspects such as the influence
of the cache hierarchy and a very simplistic model the tracking hardware.
The fidelity of those aspects can be improved but that may not be
necessary to drive design decisions in the kernel.

This is an RFC mainly to seek feedback on the approach used, particularly
the aspect of how to get data from a TCG plugin into a device model. The
approach used here is an adaption of that used in RFC v1 with a socket
between the plugin and the device emulation. That is used both for
control signals that set parameters of the tracking and indicate the
end of epoch (when to grab data).

The code here is at best a PoC to illustrate what we have in mind
It's not nice code at all, feature gaps, bugs and all!  So whilst
detailed review is always welcome I'm not requesting it for now.

Kernel support was posted a while back but was done against fake data
(still supported here if you don't provide the port parameter to the type3 device)
https://lore.kernel.org/linux-cxl/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/

This should apply more or less to upstream.

Thanks to Niyas Sait for his suggestions on how to make all this work!

Background
----------

What is the Compute eXpress Link Hotness Monitoring unit and what is it for?
- In a tiered memory equipped server with the slow tier being attached via
  CXL the expectation is a given workload will benefit from putting data
  that is frequently fetched from memory in lower latency directly attached
  DRAM.  Less frequently used data can be served from the CXL attached memory
  with no significant loss of performance.  Any data that is hot enough to
  almost always be in cache doesn't matter as it is only fetch from memory
  occasionally.
- Working out which memory is best places where is hard to do and in some
  workloads a dynamic problem. As such we need something we can measure
  to provide some indication of what data is in the wrong place.
  There are existing techniques to do this (page faulting, various
  CPU tracing systems, access bit scanning etc) but they all have significant
  overheads.
- Monitoring accesses on the CXL device provides a path to getting good
  data without those overheads.  These units are known as CXL Hotness
  Monitoring Units or CHMUs.  Loosely speaking they count accesses to
  granuals of data (e.g. 4KiB pages).  Exactly how they do that and
  where they sacrifice data accuracy is an implementation trade off.

Why do we need a model that gives real data?
- In general there is a need to develop software on top of these units
  to move data to the right place. Hard to evaluate that if we are making
  up the info on what is 'hot'.
- Need to allow for a bunch of 'impdef' solutions. Note that CHMU
  in this patch set is an oracle - it has enough counters to count
  every access.  That's not realistic but it doesn't get me shouted
  at by our architecture teams for giving away any secrets.
  If we move forward with this, I'll probably implement a limited
  counter + full CAM solution (also unrealistic, but closer to real)
  I'd be very interested in contributions of other approaches (there
  are lots in the literature, under the term top-k)
- Resources will be constrained, so whilst a CHMU might in theory
  allow monitoring everything at once, that will come with a big
  accuracy cost.  We need to design the algorithms that give us
  good data given those constraints.

So we need a solution to explore the design space and develop the software
to take advantage of this hardware. Post LSF/MM the discussion continues
on list and there is a biweekly sync call - see linux-mm for details

QEMU plugins give us a way to do this.  In particular the existing
Cache plugin can be easily modified to tell use what memory addresses
missed at the last level of emulated cache.  We can then filter those
for the memory address range that maps to CXL and feed them to our
counter implementation. On the other side, each instance of CXL type 3
device can connect to this server (in the plugin) and request hotness
monitoring services + provide parameters etc.  Elements such as
list threshold management and overflow detection etc are in the CXL
HMU QEMU device mode.

How to use it!
--------------

It runs a little slow but it runs and generates somewhat plausible outputs.
I'd definitely suggest running it with the pass through optimization
patch on the CXL staging tree (and a single direct connected device).
I'll be posting a new version of that tree with this series on it
shortly.  Look for acxl 2025-06-xx branch

Your millage will vary if you try to use other parameters, or
hotness units beyond the first one (implementation far from complete!)

To run start the server in contrib/hmu/ providing a port number to listen
on.

./chmu 4443

Then launch QEMU with something like the following.

qemu-system-aarch64 -icount shift=1 \
 -plugin ../qemu/bin/native/contrib/plugins/libcache.so,hotness=1,missfilterbase=1099511627776,missfiltersize=1099511627776,dcachesize=8192,dassoc=4,dblksize=64,icachesize=8192,iassoc=4,iblksize=64,l2cachesize=32768,l2assoc=16,l2blksize=64 \
 -M virt,ras=on,nvdimm=on,gic-version=3,cxl=on,hmat=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
 -kernel Image \
 -drive if=none,file=full.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 \
 -device virtio-blk-pci,drive=hd,x-max-bounce-buffer-size=512k \
 -nographic -no-reboot -append 'earlycon memblock=debug root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
 -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
 -object memory-backend-ram,size=4G,id=mem0 \
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=0\
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16,chmu-port=4443 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
 -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
 -numa node,nodeid=1 \
 -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
 -numa node,nodeid=2 \
 -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \

In the guest, create and bind the region - this brings up the CXL memory
device so accesses go to the memory.

  cd /sys/bus/cxl/devices/decoder0.0/
  cat create_ram_region
  echo region0 > create_ram_region
  echo ram > /sys/bus/cxl/devices/decoder2.0/mode
  echo ram > /sys/bus/cxl/devices/decoder3.0/mode
  echo $((256 << 21)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
  cd /sys/bus/cxl/devices/region0/
  echo 256 > interleave_granularity
  echo 1 > interleave_ways
  echo $((256 << 21)) > size
  echo decoder2.0 > target0
  echo 1 > commit
  echo region0 > /sys/bus/cxl/drivers/cxl_region/bind

Finally start perf with something like:

./perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
hotness_threshold=635,epoch_multiplier=4,epoch_scale=4,\
range_base=0,range_size=4096/  ./stress.sh

where stress.sh is

  sleep 2
  numactl --membind 3 stress-ng --vm 1 --vm-bytes 1M --vm-keep -t 5s
  sleep 2

See the results with
./perf report --dump-raw-trace | grep -A 200 HMU


Jonathan Cameron (4):
  hw/cxl: Switch to using an array for CXLRegisterLocator base
    addresses.
  hw/cxl: Add emulation of a CXL Hotness Monitoring Unit (CHMU)
  hw/cxl: Provide a means to get the interleave set position for an EP
  plugins: cache: Add a hotness tracker for cache misses with socket
    connection to device emulation

 include/hw/cxl/cxl.h           |   2 +
 include/hw/cxl/cxl_chmu.h      | 187 ++++++++++++
 include/hw/cxl/cxl_device.h    |  24 +-
 include/hw/cxl/cxl_pci.h       |  20 +-
 contrib/plugins/cache.c        | 434 ++++++++++++++++++++++++++-
 hw/cxl/cxl-chmu.c              | 516 +++++++++++++++++++++++++++++++++
 hw/cxl/cxl-component-utils.c   |   4 +
 hw/cxl/cxl-host.c              |  72 +++++
 hw/cxl/switch-mailbox-cci.c    |   4 +-
 hw/mem/cxl_type3.c             | 117 +++++++-
 hw/pci-bridge/cxl_downstream.c |   4 +-
 hw/pci-bridge/cxl_root_port.c  |   4 +-
 hw/pci-bridge/cxl_upstream.c   |   4 +-
 hw/cxl/meson.build             |   1 +
 14 files changed, 1363 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/cxl/cxl_chmu.h
 create mode 100644 hw/cxl/cxl-chmu.c

-- 
2.48.1


