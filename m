Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486CBD0C856
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcRr-00009X-0Q; Tue, 13 Jan 2026 06:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfcRn-00008f-JH; Tue, 13 Jan 2026 06:20:27 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfcRk-0001Xr-Sj; Tue, 13 Jan 2026 06:20:27 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5DF8048402;
 Tue, 13 Jan 2026 12:20:13 +0100 (CET)
Message-ID: <bf18287e-0f32-4138-95cd-5a7517ec7854@proxmox.com>
Date: Tue, 13 Jan 2026 12:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vdagent: add migration blocker when machine version <
 10.1
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, peterx@redhat.com, farosas@suse.de
References: <20260112104454.54225-1-f.ebner@proxmox.com>
 <CAMxuvaz0AKCcO=nWUc_U39wcdHn0w_3N8WDncT0Fbc7aWM=nAQ@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAMxuvaz0AKCcO=nWUc_U39wcdHn0w_3N8WDncT0Fbc7aWM=nAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768303167910
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc-André,

Am 13.01.26 um 8:39 AM schrieb Marc-André Lureau:
> Hi Fiona
> 
> On Mon, Jan 12, 2026 at 2:51 PM Fiona Ebner <f.ebner@proxmox.com
> <mailto:f.ebner@proxmox.com>> wrote:
> 
>     In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
>     added migration support for the vdagent chardev and commit 42000e0013
>     ("ui/vdagent: remove migration blocker") removed the migration
>     blocker. No compat for older machine versions was added, so migration
>     with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
>     will result in a failure when loading the VM state in the target
>     instance:
> 
> 
> But you can migrate a pre-10.1 machine with the new binary.

True, but I think it violates what a machine version is supposed to
encapsulate. If a QEMU binary supports a given machine version, it
should be able to load migration streams originating from other, newer
QEMU binaries when the same machine version and commandline is used, or?

>  
> 
>     > Unknown savevm section or instance 'vdagent' 0. Make sure that your
>     > current VM setup matches your saved VM setup, including any
>     > hotplugged devices
> 
>     Add a compat flag to block migration when the machine version is less
>     than 10.1 to avoid this.
> 
> 
> I am not sure this is the right way to handle this. There is already
> this error when migrating to an older qemu, I am not sure we have to
> block earlier and prevent the above case.

I would consider this an internal/unexpected error. I feel like it
should not occur if the VM was started with the exact same commandline
on source and target, but currently, it can. It happens at the very end
of migration when the source is already in post-migrate state, which is
not nice for users/management layer.

> 
>  
> 
>     Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>
>     Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
>     Signed-off-by: Fiona Ebner <f.ebner@proxmox.com
>     <mailto:f.ebner@proxmox.com>>
>     ---
>      hw/core/machine.c |  1 +
>      ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>      2 files changed, 47 insertions(+)
> 
>     diff --git a/hw/core/machine.c b/hw/core/machine.c
>     index 6411e68856..9a5241ce17 100644
>     --- a/hw/core/machine.c
>     +++ b/hw/core/machine.c
>     @@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] = {
>          { "vfio-pci", "x-migration-load-config-after-iter", "off" },
>          { "ramfb", "use-legacy-x86-rom", "true"},
>          { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
>     +    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
> 
> 
> Is there a precedent where such compat property was added to block
> migration?

There are several ones where migration is turned off for a device or
certain properties, e.g.
{ "ramfb", "x-migrate", "off" } for 8.1
{ "pl011", "migrate-clk", "off" } for 5.1
which is not quite the same, but I'd still argue:

I guess those properties were not migrated, so compatibility means still
not migrating those for older machine version. For the vdagent chardev,
the previous behavior was blocking migration, so compatibility means
still blocking migration for older machine versions. Or does that not
make sense?

Best Regards,
Fiona


