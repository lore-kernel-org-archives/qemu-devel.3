Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE9CCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBUJo-0007bA-4C; Wed, 22 Oct 2025 04:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1vBUJk-0007ab-1K
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:35:37 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1vBUJg-0005kE-El
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:35:35 -0400
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 54D1557B8B;
 Wed, 22 Oct 2025 10:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1761122129;
 bh=Wfyi+unLoX9/MhZx+rkE3veRMcEWHccBptfOxuebbIY=;
 h=Date:From:To:Cc:Subject:From;
 b=U0CMSWUznptktlHupVVNR8sQzGlUAPU43CT0ykcFHlEIv1pvrNX2oXDCvB27ypQOf
 PzGcwmUEkkXHjPAk68i6uYvpKyPyLpWTR9UqyArD9IALCqM9teBBYHkyoBsIuOf82l
 9LHbkl+OPPMkT9dAigxUhmAjxsGrQ7jNTf5ASvjjvl2MluoP9jVmrxKT8xNvu/5O7a
 xuWkEKxDSeioV/S74ZWegYRX5rTC3xVyAELoyJM10Z7G/qUhjNQVspQul5/aPefH/6
 sRoHtSeklkh99kO3FZozU2p9Vg4BxIsbS+wIBExNzPVXZNFz9jiEs+h2sBkaAASgmI
 8Yf+g3CQ6d0CA==
Date: Wed, 22 Oct 2025 10:35:28 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: coconut-svsm@lists.linux.dev, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas.Lendacky@amd.com,
 huibo.wang@amd.com, pankaj.gupta@amd.com
Subject: KVM Planes with SVSM on Linux v6.17
Message-ID: <wmymrx6xyc55p6dpa7yhfbxgcslqgucdjmyr7ep3mfesx4ssgq@qz5kskcrnnsg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
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

This morning I pushed out my current Linux and QEMU branches which support
running COCONUT-SVSM on AMD SEV-SNP based on kernel v6.17 and the original KVM
Planes patch-set from Paolo.

The branches are here:

	Linux: https://github.com/coconut-svsm/linux/tree/svsm-planes-v6.17

	QEMU: https://github.com/coconut-svsm/qemu/tree/svsm-planes-v6.17

I know I promised that to be at this point by end of September, but things
didn't quite work out that way. Apologies for that.

The intent here is to show the current state of the work and let everyone try
it and provide feedback, although some fundamental changes still need to
happen (more on that below).

I also decided against sending out patch-sets, as it does not make much sense
to foster review of code that is known to fundamentally change still. If people
see value in seeing the patches on mailing lists, please let me know.

How to run it
-------------

The code can be built as usual, QEMU needs to have IGVM and KVM support
included in order to run COCONUT-SVSM.

The most important change is at the QEMU command line. With the branch above,
the skeleton is:

qemu-system-x86_64 \
   -enable-kvm \
   -cpu EPYC-v4 \
   -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
   -object memory-backend-memfd,id=ram1,size=32G,share=true \
   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
   -object igvm-cfg,id=igvm0,file=coconut-qemu.igvm \

Please note the changes to the machine specification:

	- `kernel-irqchip=split` The code I pushed out only works with IRQ chip
	  in split mode.

	- `device-plane=2` A new property defines the plane which controls
	  devices. This is important so that QEMU can send IRQs to the correct
	  plane. As COCONUT-SVSM currently always runs the guest on plane 2,
	  the value of the property must also be 2.

Known Issues
------------

During development of the KVM changes it became pretty to me that having one
`struct kvm_vcpu` object per plane causes several problems. The problems all
boil down to the fact that this approach introduces false unsharing of state
which needs to be per-VCPU instead of per-Plane. I worked around these problems
where needed to get things running, it can be seen in several patches in the
Linux branch.

But my changes do by far not cover all state which needs to be shared but is
now factually unshared between planes. The result is that people will likely
run into issues with the code above once leaving the beaten track I tested.

The changes on the `struct kvm` object are correct, there is still one for all
planes with a separate per-plane structure that holds the per-plane state.

Next Steps
----------

To turn this into a stable and upstreamable feature the first next step is to
update the base patches to use only one `struct kvm_vcpu` object for all planes
and factor out per-plane state into a separate struct. Then the SEV-SNP
specific changes will be rebased on-top.

Happy testing!

Regards,

	Joerg

