Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C70F4BB8A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzSn-0003UU-AN; Tue, 24 Feb 2026 15:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vuzSB-0003Dh-F5
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:56:31 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vuzRQ-0005xc-Jm
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:56:14 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98.2) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1vuzOi-0000000DESC-2xFT; Tue, 24 Feb 2026 21:52:48 +0100
Message-ID: <79f110e1-b217-4a70-81f7-d596f822dde5@maciej.szmigiero.name>
Date: Tue, 24 Feb 2026 21:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Configure proper KVM SEOIB behavior
To: Khushit Shah <khushit.shah@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sean Christopherson <seanjc@google.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20251126093742.2110483-1-khushit.shah@nutanix.com>
 <F09B2DC7-6825-48B4-94A9-741260832167@nutanix.com>
 <C1DC0AAE-AE34-42E1-A15C-E03D1EE4D770@nutanix.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
In-Reply-To: <C1DC0AAE-AE34-42E1-A15C-E03D1EE4D770@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10.12.2025 06:23, Khushit Shah wrote:
> Hi,
> 
> I wanted to follow up on this patch to see if there are any review comments
> or feedback. I'm planning to prepare a v2 that addresses the following:
> 
> 1. Move the SEOIB configuration code from x86-common.c to KVM-specific code
>     (kvm_arch_init()).
> 
> 2. Refactor as per the changes on the KVM side of the patch.
> 
> Before proceeding with v2, I have a design question regarding the scope of
> the fix:
> 
> Currently, the patch sets the SEOIB state for all machine types on new power-ons
> based on the IOAPIC version. This means that any new VM powered on with a
> patched QEMU will get the proper SEOIB behavior.
> 
> However, I'm wondering if we should instead:
> - Define a new machine property (i.e, "seoib-policy") that defines the SEOIB
>    behavior.
> - Only enable the new SEOIB behavior in the latest machine type version
>    (10.2?), keeping older machine types in QUIRKED mode.
> 
> The question is: should new power-ons of *all* machine types set the SEOIB
> state automatically, or should we scope this fix to the latest machine type
> versions only via a machine property?
> 
> I'd appreciate your thoughts on this design decision before I finalise v2.

Now that the KVM side of this patch is in Linus tree are there any plans
to submit a v2 for visibility and with updated flag naming even before
getting the questions above answered?

> Regards,
> Khushit
> 

Thanks,
Maciej


