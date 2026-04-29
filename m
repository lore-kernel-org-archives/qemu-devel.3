Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F95CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB82-0003a8-74; Wed, 29 Apr 2026 16:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QP-00083w-Gm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QM-0007gD-Oe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso98068085e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471075; x=1778075875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HSyR30y14N6Go6z0CTh+z8a0vdIoiDWRnE1Zhp/jpmg=;
 b=phTaGqOC7mMdlTiXyf9poCzZds+Qf+rcbmzG/3FaFLyMH2QHFLssMzLCBxgBZsSSJN
 WKldGGA1SgPBBQJL7vcpiejUBqD7/58TcWf/iW+uwsOuGyScXiKOpCVA5z1nYidzVobp
 qMGFaZjBzELKIf3gKj+twLxk/xC/+AANiFX9+rWSdmYihRNEQD7vrOktRhqZoGl043Nu
 fDdJSrsA/Wkm6I9A91I5mQ2hy2+uAuvmNjkV3eOCRbbvA6Dd+TW3U6M1vC9n72qh7vx9
 V1DE+ICvla/wykQxhN/OZkRYKBv9jGVf1NtS0Jgy9/mvVgRz74oOgX6Su81uCoGIQAR6
 B98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471075; x=1778075875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSyR30y14N6Go6z0CTh+z8a0vdIoiDWRnE1Zhp/jpmg=;
 b=co6rItFw8+xEuZgdBRuTRwg0I5vc/gNlbjBWzUb31BTL5Fi0yWdxZH+9ztwCvpn0fu
 GPIs7Qu7wMfgGERu5ZFQ8ABRWhR1bV0Ps3IlMFPVzAKWaX88mPOkQQImP2ojJtw7FsyB
 z7tS0M31B4keNlvHw1vWeQDaZYqsrMmmzNkWcJXOYfWKg6WPNTqPnYBtTo+UZKl2NMjv
 F609yGzPc1Rl0XwD8aNqBINoUuYNP6hZnhk6uEA+mM9VJIbrMtZ0O6HS3iw0Rr5+Ad5j
 F0NoJU3sP8vPENSC7wKlWklcAP178ENM6mBMMB6CsheIs7fwAdHlTVtULaiXXj5B9ENb
 TcGw==
X-Gm-Message-State: AOJu0Yz+7qUCfXswvHtl9ClJIfAbETPQQBRGElbO3LZ49wh6oQGpRpCT
 31QehTMdxHTyHcDhxz2/0pPOXxs0J7bkqh4o+dbfX2ck1VeA9WSJRl2J
X-Gm-Gg: AeBDievsc9OvQH99p6Xr/QHa9oFH/Sx6Fu4dnZKFII100rnKPjJdIQl13qU3Cp3yyuW
 2JNhfUH1U+L6e/eDVU2nKma1F3SrtjwaNKeLj/ivo08J6XAPrhPheZafPDA3Ac0IVzbuLb8tgrF
 eGCjT6xORhdNolpVVNNyUg3i41prEC0yD2D7EehGFPtHRAJz/hjNe48fSGcHyvYMaj0KJ45Izsc
 9OCIlS12ttbz/CQ15KscM3ql1hgWO51GcjJIu8jk7PQi5oBEYiBwgCqRa36/EdgFfjxSJQJ95A3
 eXmKSPy3q+e2MXwdYV4GUyQuTfEqe7zhuL1GaFkjrosPMhQz5nHYalIfvEVkJHFjHkS117FK3nB
 8jqO9n1bbzlSXgCdWjdtxeGXK/WYlgZ6PHCv5vpeWGHfR0l7KprtoBgDHjIiVzUrsTf3+7Avdsu
 s2PrHsE4gaT4nUxEdd/+WqTuuA7Lkij+3hwUach6083NxGw2w5q+Z7XWmsA+2zUYSIeMpWZeuV
X-Received: by 2002:a05:600c:1c20:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-48a77b241admr129709105e9.23.1777471074474; 
 Wed, 29 Apr 2026 06:57:54 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:57:53 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 00/10] Initial Support for VCS Switching
Date: Wed, 29 Apr 2026 14:48:34 +0100
Message-ID: <20260429135717.3048713-1-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

Hi,

(All references to the CXL specification here are made to v3.2.)

VCS= Virtual CXL Switch
PPB= PCI-PCI bridge
vPPB= virtual PCI-PCI bridge
SLD= Single Logical Device
FM= Fabric Manager
USP/DSP=Upstream/Downstream Port

This patchset provides basic functionality for emulation of an FM-owned,
multi-VCS CXL switch (7.1.3). Primarily it adds a new object defined
in hw/cxl/cxl-vcs-switch.c, and supports the FMAPI commands vppb get
info/bind/unbind 0x5200/0x5201/0x5202 (7.6.7.2.1-7.6.7.2.3) to be used on SLD’s.

It is posted as an RFC since: 
1). There are several limitations with this work and I would like to discuss
how to proceed.
2). There has been prior discussion on potential restructuring of the CXL
cci/switch code[1], which I suppose will dictate how to move forward with parts
of this series…

-------------------
VCS Emulation

The VCS command set should ultimately allow for multi-host sharing of a MLD/DCD
device through the same switched fabric, with a single Fabric Manager/CCI-mailbox
endpoint for configuration/management. The work here is a stepping stone toward
that, allowing for SLD’s to be bound/unbound to a local QEMU instance by the FM.

The cxl-vcs-switch is comprised of one or more VCSs, and one or more hidden
endpoint devices. A single VCS is defined as a single cxl-upstream-port
(meaning a 1:1 mapping between physical upstream PPBs and number of VCS’s),
and one or more cxl-downstream-ports (these form the vPPBs of each VCS). The
number of vcs-attached endpoints defined on the CLI forms the number of
downstream PPBs the switch would have. These endpoints are hidden on boot, and
connect to one of the vPPBs upon bind. This means that there is in effect
no real downstream PPB in QEMU. The vPPB device effectively becomes the
downstream PPB following bind.

When the topology is initialised:
- Upstream/downstream ports instantiated as part of a VCS switch are realized
normally, but additionally register with the cxl-vcs-switch object, which are
then referenced by the bind/unbind FMAPI commands etc.
- The endpoint devices which connect to the downstream PPBs use the
DeviceListener functionality for hiding devices (see the reference in the
commit message of patch 2). The QDict from the CLI is stored in the VCS structs,
which are then realized/unrealized on bind/unbind commands from the FM.

All this means that on boot the guest sees its upstream port and all downstream
ports (vppbs) enumerated (as is described in section 7.1.4 and 7.2.1.3), but
none of the endpoints are seen.

The cxl-vcs-switch itself is implemented as a user creatable class, since it
does not fit the single inheritance device model of QEMU, which would force
association with a single PCIe bus, which will not work for multiple USPs.

The cxl-vcs-switch uses local-fm=true/false CLI option to dictate whether the
object will have a CCI mailbox attached. VCS state information will be held in
the local-fm=true instance, and the FM will communicate directly with this
instance only. IPC will be used (in multi-USP, multi-QEMU process environments)
in order to maintain correct state information in the local-fm, and to
bind/unbind devices in remote QEMU processes.

Currently only the “managed hot-remove” flow is complete (Table 7-34) for the
unbind operation, notifying the guest of removal and awaiting signal from
the OS for unbind completion from the unrealize DeviceListener function.

This is tested with the topology below and some additional libcxlmi test
programs[2]. I am able to bind and unbind correctly to multiple VCSs, see the
updated switch state, and see the delay in the unrealize listener callback from
the delays in OS notification.

-------------------
Limitations and open questions

1. Unbound, but fully realized devices (allowing proper MLDs/DCDs)

The current method of hiding the endpoint device and storing the QDicts works
for simple devices only. But ultimately the FM should be able to tunnel commands
through the switch to communicate with the device, whether a guest is bound to
it or not... We need a method of fully realizing the device, but on some sort of
dummy bus that is not seen by the guest. I am unsure how to do this currently,
since AFAICT it goes against the qdev model of device realization, being
inherently associated with attaching to the guest’s bus (please correct me if
I’m wrong on this). It will require a way to properly realize the devices, but
bypass automatic association with the guest’s QOM tree? I don’t know if there
is any precedent for behaviour like this in QEMU?

2. Integration with Physical Switch Command set.

Currently the physical switch command set in cci-mailbox-utils.c has not been
modified to account for a VCS target (i.e. using those commands with a VCS
target currently breaks things). This is where the discussion in [1] comes in.

> - Move the call that caches state to the cxl_upstream_port reset
>  to ensure downstream ports are in place before it is called.
> Also will make it available from whatever CCI.  If we ever support
> multiple VCS switches this will need to move an appropriate structure
> representing whole switch information. With only one USP that is
> a reasonable place to put full switch info.

Since in my implementation the CXLPhyPortInfo will end up being associated with
the VCS object and not with the USP, further refactoring will be required for
this patch series to generalise the physical switch command set functions.

3. Distributed VCS control

Since the ultimate aim of this is to give the FM control of multiple VCSs in
multiple QEMU instances, some method of sending FM commands between QEMU
processes is needed, since the switch state will be distributed over these
processes (with status kept in the local-fm=true instance). Does QEMU have a
standard way for implementing such IPC or shall I just add some simple sockets
communication into the cxl-vcs-switch.c?

4. Unimplemented commands from virtual switch command set. 

The actual bind process described in 7.6.6.7 shows how event records must be
used, and the FMAPI command should return success without waiting on binding
completion. Further work is needed to completely emulate the flow as described
in the specification, and implement the remaining FMAPI commands.

5. Tiered switching.

Currently the downstream PPBs are nothing more than a struct, and only endpoint
devices can be hidden. There should be some way to implement another complete
switch below the downstream PPB of the first switch, as described in
section 9.12.2.

-------------------
Testing

topology:

-device usb-ehci,id=ehci \
-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/$LOG_DIR/t3_cxl1.raw,size=8G \
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/$LOG_DIR/t3_lsa1.raw,size=1M \
-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/$LOG_DIR/t3_cxl2.raw,size=8G \
-object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/$LOG_DIR/t3_lsa2.raw,size=1M \
-object memory-backend-file,id=cxl-mem3,share=on,mem-path=/$LOG_DIR/t3_cxl3.raw,size=8G \
-object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/$LOG_DIR/t3_lsa3.raw,size=1M \
-object memory-backend-file,id=cxl-mem4,share=on,mem-path=/$LOG_DIR/t3_cxl4.raw,size=8G \
-object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/$LOG_DIR/t3_lsa4.raw,size=1M \
-object cxl-vcs-switch,id=vcs0,usp-ppbs=2,dsp-ppbs=4,local-fm=true \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
-device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
-device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,vcs=vcs0,usppb=0 \
-device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,multifunction=on,vcs=vcs0,usppb=1 \
-device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=vcs0 \
-device usb-cxl-mctp,bus=ehci.0,id=usb0,target=vcs0 \
-device cxl-downstream,port=0,bus=us0,id=swport0,slot=3 \
-device cxl-downstream,port=1,bus=us0,id=swport1,slot=4 \
-device cxl-downstream,port=2,bus=us0,id=swport2,slot=5 \
-device cxl-downstream,port=3,bus=us0,id=swport3,slot=6 \
-device cxl-downstream,port=0,bus=us1,id=swport4,slot=7 \
-device cxl-downstream,port=1,bus=us1,id=swport5,slot=8 \
-device cxl-downstream,port=2,bus=us1,id=swport6,slot=9 \
-device cxl-downstream,port=3,bus=us1,id=swport7,slot=10 \
-device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,vcs=vcs0,dsppb=0 \
-device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,vcs=vcs0,dsppb=1 \
-device cxl-type3,volatile-dc-memdev=cxl-mem3,id=cxl-dcd1,lsa=cxl-lsa3,num-dc-regions=8,sn=101,vcs=vcs0,dsppb=2 \
-device cxl-type3,volatile-dc-memdev=cxl-mem4,id=cxl-dcd2,lsa=cxl-lsa4,num-dc-regions=8,sn=102,vcs=vcs0,dsppb=3 \
-machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G

libcxlmi:

See [2]…

1. Setup MCTP communication: e.g.
mctp link set mctpusb0 up;
mctp addr add 8 dev mctpusb0;
mctp link set mctpusb0 net 1;
systemctl restart mctpd.service
busctl call au.com.codeconstruct.MCTP1 /au/com/codeconstruct/mctp1/interfaces/mctpusb0 au.com.codeconstruct.MCTP.BusOwner1 SetupEndpoint ay 0

2. Build, then run libcxlmi commands to bind vcs0:
./build/examples/vcs-bind-mctp 1 9 0 0 0
./build/examples/vcs-get-virtual-switch-info-mctp 1 9

3. Demonstrate the CXL device is usable:
cxl create-region -m -t pmem -d decoder0.0 -w 1 -g 1024 -s 256M mem0
ndctl create-namespace --region region0 --mode fsdax --size 256M
echo "HELLO WORLD..." > /dev/pmem0
cat /dev/pmem0

4. Teardown the device, and rebind to vcs1, and check that it maps
correctly:
ndctl disable-namespace namespace0.0
ndctl destroy-namespace namespace0.0
cxl disable-region region0
cxl destroy-region region0
cxl disable-memdev mem0
./build/examples/vcs-unbind-mctp 1 9 0 0 1
# wait 5s for the hp notification... see lspci/dmesg change
# bind the same device to the other VCS.
./build/examples/vcs-bind-mctp 1 9 1 0 0
cxl create-region -m -t pmem -d decoder0.1 -w 1 -g 1024 -s 256M mem0
ndctl create-namespace --region region1 --mode fsdax --size 256M
cat /dev/pmem1
# See the hello world originally written by vcs0!

-------------------
Build

The patches are applied on the upstream qemu 10.2 release, on top of the
following patchsets from various branches of Jonathan’s fork:

1: [PATCH qemu v5 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/linux-cxl/20260205112350.60681-1-Jonathan.Cameron@huawei.com/

2: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
https://lore.kernel.org/linux-cxl/20250917143330.294698-1-Jonathan.Cameron@huawei.com/

3: [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
https://lore.kernel.org/linux-cxl/20260102154731.474859-1-Jonathan.Cameron@huawei.com/

4: [PATCH qemu v7 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit mode)
https://lore.kernel.org/linux-cxl/20260204170936.43959-1-Jonathan.Cameron@huawei.com/

5: [PATCH qemu v5 0/3] hw/cxl: FM-API Physical Switch Command Set Support.
https://lore.kernel.org/linux-cxl/20260204173223.44122-1-Jonathan.Cameron@huawei.com/

6: [RFC PATCH qemu 0/5] hw/cxl/mctp/i2c/usb: MCTP for OoB control of CXL devices.
https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/

-------------------
References

[1] https://lore.kernel.org/linux-cxl/20260127152350.00006447@huawei.com/

[2] https://github.com/joshualant/libcxlmi/tree/vcs-testing


Many thanks,

Josh

Joshua Lant (10):
  docs: Add documentation for cxl-vcs-switch
  qdev/qbus: Allow hidden devices to be busless on QEMU startup
  cxl-type3: Properly unmap the memory-backend on device exit
  cxl_downstream: enable power controller present capability.
  cxl-vcs-switch: Initial support for CXL VCS.
  cxl-upstream-port: Add support for targeting a VCS switch
  cxl-downstream-port: Add support for VCS switching
  cxl-cci-mailbox: Add support for targeting a VCS switch
  cxl-mailbox-utils: Add support for VCS bind/unbind commands.
  cxl-mailbox-utils: Add support for VCS Get Virtual CXL Switch Info
    command.

 docs/system/devices/cxl.rst               |  90 +++-
 hw/cxl/cxl-mailbox-utils.c                | 207 ++++++++-
 hw/cxl/cxl-vcs-switch.c                   | 524 ++++++++++++++++++++++
 hw/cxl/meson.build                        |   1 +
 hw/cxl/switch-mailbox-cci.c               |  33 +-
 hw/mem/cxl_type3.c                        |   3 +
 hw/pci-bridge/cxl_downstream.c            |  13 +
 hw/pci-bridge/cxl_upstream.c              |  20 +
 hw/usb/dev-mctp.c                         |  23 +-
 include/hw/cxl/cxl_device.h               |  10 +-
 include/hw/cxl/cxl_vcs_switch.h           | 134 ++++++
 include/hw/pci-bridge/cxl_upstream_port.h |   2 +
 qapi/qom.json                             |  19 +
 system/qdev-monitor.c                     |  10 +-
 14 files changed, 1055 insertions(+), 34 deletions(-)
 create mode 100644 hw/cxl/cxl-vcs-switch.c
 create mode 100644 include/hw/cxl/cxl_vcs_switch.h

-- 
2.47.3


