Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYml-0006A6-NG; Tue, 16 Sep 2025 12:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyYmf-000691-R0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyYmd-0005tZ-5B
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758041037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldRKioNtr38YyudBKX9urW+fjxnP5yE9BhYynvXtATk=;
 b=V7NF4JWlfToaNbEDqTkWTBeCjqzwcwG9kcj8IlUmaU1Nm9bktssV0JmEfJXcFnf/0srypc
 rlGiv33HER2z7HBxFwCDE3oiBhzQXmJiGf/Pu1KOrG68HVY+AqxKyknzgiqiKBhY4PZC4g
 eSGnfRabLj2rEfvTZAL0uhB7FDl30ak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-LSJEv8pAMuCEh93OfdsoQw-1; Tue,
 16 Sep 2025 12:43:55 -0400
X-MC-Unique: LSJEv8pAMuCEh93OfdsoQw-1
X-Mimecast-MFC-AGG-ID: LSJEv8pAMuCEh93OfdsoQw_1758041034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B944219560B2; Tue, 16 Sep 2025 16:43:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 429F11800451; Tue, 16 Sep 2025 16:43:52 +0000 (UTC)
Date: Tue, 16 Sep 2025 17:43:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH <RFC> 00/15] Encode object type security status in code
Message-ID: <aMmTxNB2eq6hSS9o@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping: anyone have thoughts on this idea of annotating security
status of our code against QOM classes ?

On Tue, Sep 09, 2025 at 05:57:11PM +0100, Daniel P. Berrangé wrote:
> Our docs/system/security.rst file loosely classifies code into that
> applicable for 'virtualization' vs 'non-virtualization' use cases.
> Only code relevant to the former group is eligible for security
> bug handling. Peter's recent proposal pointed out that we are
> increasingly hitting the limits of such a crude classification:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01520.html
> 
> Michael suggested that with the increased complexity, docs are not
> going to be an effective way to convey the information, and we
> need to re-consider embedding this info in code:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01566.html
> 
> This also allows users to validate a configuration's security status
> when starting a guest, or modifying a running guest. This series is
> an attempt to start the embedding process.
> 
> It starts with QOM, adding "bool secure" and "bool insecure"
> properties to the TypeInfo struct, which get turned into flags
> on the Type struct. This enables querying any ObjectClass to
> ask whether or not it is declared secure or insecure.
> 
> By default no statement will be made about whether a class is
> secure or insecure, reflecting our historical defaults. Over
> time we should annotate as many classes as possible with an
> explicit statement.
> 
> The "-machine" argument gains two new parameters
> 
>   * prohibit-insecure=yes|no  - a weak security boundary, only
>     excluding stuff that is explicitly declared insecure,
>     permiting stuff that is secure & anything without a stetement
> 
>   * require-secure=yes|no - a strong security boundary, only
>     permitting stuff that is explicitly declared secure,
>     excluding insecure stuff & anything without a statement
> 
> As illustration, I have added explicit annotations for many machine
> types, some accelerators, all NICs (all insecure except xen,
> e1000(e) and virtio), and all PCI virtio devices (all secure).
> 
> Example: TCG is explicitly insecure, KVM is explicitly secure,
>          qtest has no statement:
> 
>   $ qemu-system-x86_64 -display none -machine pc,prohibit-insecure=yes -accel tcg
>   qemu-system-x86_64: Type 'tcg-accel' is declared as insecure
> 
>   $ qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel tcg
>   qemu-system-x86_64: Type 'tcg-accel' is not declared as secure
> 
>   $ qemu-system-x86_64 -display none -machine pc,prohibit-insecure=yes -accel kvm
>   ^Cqemu-system-x86_64: terminating on signal 2
> 
>   $ qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel kvm
>   ^Cqemu-system-x86_64: terminating on signal 2
> 
>   $ qemu-system-x86_64 -display none -machine pc,prohibit-insecure=yes -accel qtest
>   ^Cqemu-system-x86_64: terminating on signal 2
> 
>   $ qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel qtest
>   qemu-system-x86_64: Type 'qtest-accel' is not declared as secure
> 
> Example: isapc machine type is explicitly insecure
> 
>   $ qemu-system-x86_64 -display none -machine isapc,require-secure=yes -accel kvm
>   qemu-system-x86_64: Type 'isapc-machine' is not declared as secure
> 
> Example: devices which have no security statement are allowed if
>          merely excluding insecure devices:
> 
>   $ qemu-system-x86_64 -display none -machine pc,prohibit-insecure=yes -accel kvm -device i6300esb
>   ^Cqemu-system-x86_64: terminating on signal 2
> 
> Example: devices which have no security statement are rejected if
>          requiring explicit security:
> 
>   $ qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel kvm -device i6300esb
>   qemu-system-x86_64: -device i6300esb: Type 'i6300esb' is not declared as secure
> 
> Example: checks also apply in HMP, rtl8139 is explicitly insecure,
>          virtio is explicitly secure
> 
>   $ qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel kvm -monitor stdio
>   QEMU 10.1.50 monitor - type 'help' for more information
>   (qemu) device_add rtl8139
>   Error: Type 'rtl8139' is not declared as secure
>   (qemu) device_add virtio-net
> 
> Example: checks also apply in QMP:
> 
>   $ ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 -display none -machine pc,require-secure=yes -accel kvm
>   Welcome to the QMP low-level shell!
>   Connected
>   (QEMU) device_add driver=rtl8139
>   {"error": {"class": "GenericError", "desc": "Type 'rtl8139' is not declared as secure"}}
>   (QEMU) device_add driver=virtio-net
>   {"return": {}}
> 
> Some questions....
> 
>   * Is using '-machine' the right place to express the policy ?
> 
>   * Can we change '-accel help' to report 'secure' / 'insecure'
>     as we did for '-machine help' and '-device help'.
> 
>   * Should we have 'query-devices' for QMP to allow the 'secure'
>     or 'insecure' status to be queried for every device.
> 
>   * Should we have 'query-accel' for QMP to allow the 'secure'
>     or 'insecure' status to be queried for every accelerator.
> 
>   * Should we enforce checks for -object & object_add too ?
>     Easy to add code for this, but do we need the ability to
>     exclude some object backends of dubious code quality ?
> 
>   * Likewise for -chardev / -netdev / etc which are
>     conceptual specializations of -object
> 
>   * BlockDriver structs don't use QOM, so we can't mark
>     'vvfat' block backend as insecure
> 
> The first one about '-machine' is probably the main blocker
> from a design POV. Other things are just potential future
> incremental work.
> 
> This series has had only 1/2 a day's work / thought put into
> it, hence RFC status. It has been compiled and minimally tested
> with the examples shown above. I have not pushed this through
> CI nor considered tests yet. Still it gives a good illustration
> of what's involved in recording security info in code.
> 
> Daniel P. Berrangé (15):
>   qom: replace 'abstract' with 'flags'
>   qom: add tracking of security state of object types
>   machine: add 'require-secure' and 'prohibit-insecure' properties
>   machine: check security for machine and accelerator types
>   system: report machine security status in help output
>   system: check security of device types
>   system: report device security status in help output
>   hw/core: report secure/insecure status in query-machines
>   accel: mark 'kvm' as secure and 'tcg' as insecure
>   hw/virtio: mark all virtio PCI devices as secure
>   hw: mark x86, s390, ppc, arm versioned machine types as secure
>   hw: declare Xen & microvm machines as secure, isapc as insecure
>   hw/core: declare 'none' machine to be insecure
>   hw/net: mark all NICs as insecure except e1000, e1000e & xen
>   docs: expand security docs with info about secure/insecure markers
> 
>  accel/kvm/kvm-all.c            |  1 +
>  accel/tcg/tcg-all.c            |  1 +
>  docs/system/security.rst       | 41 +++++++++++++++++++++
>  hw/arm/virt.c                  |  1 +
>  hw/arm/xen-pvh.c               |  1 +
>  hw/core/machine-qmp-cmds.c     |  2 ++
>  hw/core/machine.c              | 66 ++++++++++++++++++++++++++++++++++
>  hw/core/null-machine.c         |  2 +-
>  hw/i386/isapc.c                |  2 +-
>  hw/i386/microvm.c              |  1 +
>  hw/i386/pc_piix.c              |  4 +--
>  hw/i386/xen/xen-pvh.c          |  1 +
>  hw/i386/xen/xen_pvdevice.c     |  1 +
>  hw/net/allwinner-sun8i-emac.c  |  1 +
>  hw/net/allwinner_emac.c        |  3 +-
>  hw/net/cadence_gem.c           |  1 +
>  hw/net/can/can_kvaser_pci.c    |  1 +
>  hw/net/can/can_mioe3680_pci.c  |  1 +
>  hw/net/can/can_pcm3680_pci.c   |  1 +
>  hw/net/can/ctucan_pci.c        |  1 +
>  hw/net/can/xlnx-versal-canfd.c |  1 +
>  hw/net/can/xlnx-zynqmp-can.c   |  1 +
>  hw/net/dp8393x.c               |  1 +
>  hw/net/e1000.c                 |  1 +
>  hw/net/e1000e.c                |  1 +
>  hw/net/eepro100.c              |  1 +
>  hw/net/fsl_etsec/etsec.c       |  1 +
>  hw/net/ftgmac100.c             |  1 +
>  hw/net/igb.c                   |  1 +
>  hw/net/igbvf.c                 |  1 +
>  hw/net/imx_fec.c               |  2 ++
>  hw/net/lan9118.c               |  1 +
>  hw/net/lan9118_phy.c           |  1 +
>  hw/net/lance.c                 |  1 +
>  hw/net/lasi_i82596.c           |  1 +
>  hw/net/mcf_fec.c               |  1 +
>  hw/net/msf2-emac.c             |  1 +
>  hw/net/mv88w8618_eth.c         |  1 +
>  hw/net/ne2000-isa.c            |  1 +
>  hw/net/ne2000-pci.c            |  1 +
>  hw/net/npcm7xx_emc.c           |  1 +
>  hw/net/npcm_gmac.c             |  1 +
>  hw/net/npcm_pcs.c              |  1 +
>  hw/net/opencores_eth.c         |  1 +
>  hw/net/pcnet-pci.c             |  1 +
>  hw/net/rocker/rocker.c         |  1 +
>  hw/net/rtl8139.c               |  1 +
>  hw/net/smc91c111.c             |  1 +
>  hw/net/spapr_llan.c            |  1 +
>  hw/net/stellaris_enet.c        |  1 +
>  hw/net/sungem.c                |  1 +
>  hw/net/sunhme.c                |  1 +
>  hw/net/tulip.c                 |  1 +
>  hw/net/virtio-net.c            |  1 +
>  hw/net/vmxnet3.c               |  1 +
>  hw/net/xen_nic.c               |  1 +
>  hw/net/xgmac.c                 |  1 +
>  hw/net/xilinx_axienet.c        |  1 +
>  hw/net/xilinx_ethlite.c        |  1 +
>  hw/ppc/spapr.c                 |  1 +
>  hw/s390x/s390-virtio-ccw.c     |  1 +
>  hw/virtio/virtio-pci.c         |  3 ++
>  hw/xen/xen-pvh-common.c        |  1 +
>  hw/xenpv/xen_machine_pv.c      |  2 +-
>  include/hw/boards.h            | 18 +++++++++-
>  include/hw/i386/pc.h           |  5 ++-
>  include/qom/object.h           | 24 +++++++++++++
>  qapi/machine.json              |  9 ++++-
>  qom/object.c                   | 40 +++++++++++++++++----
>  system/qdev-monitor.c          | 10 ++++++
>  system/vl.c                    |  6 ++--
>  71 files changed, 275 insertions(+), 18 deletions(-)
> 
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


