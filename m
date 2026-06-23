Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE71CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc49d-0005JC-HZ; Tue, 23 Jun 2026 12:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wc49a-0005Ik-Ty; Tue, 23 Jun 2026 12:39:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wc49X-0002R0-Su; Tue, 23 Jun 2026 12:39:14 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65NGcWFL077965
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Jun 2026 01:38:33 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mod5a9BwBqEYV3/l4MBLapyvK6ee6qpd4nIARuXfM3o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782232713; v=1;
 b=Y9jarTDQeVbm7UwE2ZFU2pVcjWHumaa/+oSEn4SsX/BcoNo1rwjCWoVuPIwvIRnx
 f2JdN1VMN+aAvaRw2hr6tOsgaRDYNhjhycYUMVQouZgGyrtXyOMVGpdW9tU+M10m
 mGJzL2/gS4mMG2ppb11JN4n0CG3teJaitW6c1mJFywEbaKSuXEjlzuC1lt1Dq6Z1
 NWaT1nrGpHBLCMoh0LMs4aLio13fdSQ+L+APP55F99MgsB8BzGcHmL1Cf4Odg3Zn
 uZG0zNClk1p1diCnFSSlWeVoU60xcVW3zvVEF8T+n44g6GB17GRlFcxEwVms7SwS
 RkZedM/QbLC94BOIbyXctw==
Message-ID: <377d55cb-b239-40d8-b6c2-79e25cdeab1d@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Jun 2026 01:38:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
 <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
 <ajqqBBA3Ynxqgu_S@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ajqqBBA3Ynxqgu_S@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/24 0:45, Peter Xu wrote:
> On Tue, Jun 23, 2026 at 09:05:22PM +0900, Akihiko Odaki wrote:
>> On 2026/06/23 5:23, Peter Xu wrote:
>>> On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
>>>> Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
>>>> ("[PATCH] system/physmem: Assert migration invariants")
>>>>
>>>> ram_mig_ram_block_resized() already aborts migration when migratable RAM
>>>> is resized. Extend the same handling to other unsupported changes to the
>>>> migratable RAMBlock set, such as removing a migratable RAMBlock or
>>>> changing a RAMBlock's migratable state.
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> ---
>>>> Akihiko Odaki (3):
>>>>         system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
>>>>         system/physmem: Notify RAMBlock migratable and idstr changes
>>>>         migration/ram: Abort on unsupported migratable RAM changes
>>>
>>> Thanks for looking at this, Akihiko.
>>>
>>> I understand this is a protection to the system to trap error use cases.
>>> The question I have is do we have any possible way to trigger these.
>>>
>>> I worry we add a bunch of code and notifiers, and then there's zero way to
>>> trigger, essentially add dead code.
>>>
>>> Logically we could already add assert() on things we don't expect to
>>> happen.  This case might be slightly risky, but still I think we can also
>>> consider things like error_report_once() instead of introducing slightly
>>> complex notifiers just to cover what we think shouldn't happen.
>>>
>>> Or do you have way to trigger any of these notifiers?
>>
>> I simply followed what's already done for resize(), expecting resize() does
>> the correct thing and following it won't introduce a regression.
>>
>>>
>>> PS: today I went back and I wanted to try how the existing resize()
>>> notifier would trigger, I can't even reproduce it with David's example
>>> here:
>>>
>>> https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
>>>
>>> I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
>>> so it didn't really notify a thing.  I don't really know how to trigger
>>> ram_block_notify_resize().  If you know, please share.
>> I made an LLM amend the reproducer. Below is its output.
>>
>> Regards,
>> Akihiko Odaki
>>
>> LLM output:
>>
>> A synthetic but effective variant is to add custom ACPI filler tables so the
>> initial `etc/acpi/tables` blob is just under the 128 KiB alignment bucket,
>> then let the normal boot-time fw_cfg ACPI rebuild push it over.
>>
>> I tested this shape:
>>
>> ```sh
>> truncate -s 65000 /tmp/fill1
>> truncate -s 50600 /tmp/fill2
>> ```
>>
>> Then add to the original-ish command:
>>
>> ```sh
>> -device pcie-root-port,id=rp0,chassis=1,slot=1 \
>> -acpitable sig=FI1A,data=/tmp/fill1 \
>> -acpitable sig=FI2A,data=/tmp/fill2
>> ```
> 
> These lines should inject some sections into ACPI, but I don't see why the
> acpi table would change: that should be appended right at QEMU boots, so I
> expect the ACPI table to grow indeed comparing to when without these lines,
> but not resize during VM running.  I wonder if below is hallucinations from
> the AI.

The resize happens because the ACPI fw_cfg blobs are built lazily when 
the guest firmware selects them. acpi_add_rom_blob() registers 
acpi_build_update() as the fw_cfg select callback; after `cont`, 
firmware reads the fw_cfg ACPI entries, QEMU builds the tables, and
acpi_ram_update() calls memory_region_ram_resize().

Below is the reprouction case (LLM-generated):

#!/bin/sh
set -eu

QEMU=${QEMU:-build/qemu-system-x86_64}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

qmp_migrate()
{
     printf '%s%s%s\n' \
         '{"execute":"migrate","arguments":{"channels":[{' \
         '"channel-type":"main","addr":{"transport":"exec",' \
         '"args":["/bin/sleep","1000"]}}]}}'
}

truncate -s 65000 "$tmp/fill1"
truncate -s 50600 "$tmp/fill2"
truncate -s 256M "$tmp/nvdimm"

{
     echo '{"execute":"qmp_capabilities"}'
     echo '{"execute":"x-query-ramblock"}'
     qmp_migrate
     sleep 1
     echo '{"execute":"query-migrate"}'
     echo '{"execute":"cont"}'
     sleep 3
     echo '{"execute":"query-migrate"}'
     echo '{"execute":"x-query-ramblock"}'
     echo '{"execute":"quit"}'
} | "$QEMU" \
     -S \
     -machine q35,nvdimm=on,accel=tcg \
     -smp 1 \
     -cpu max \
     -m size=20G,slots=8,maxmem=22G \
     -object \
     memory-backend-file,id=mem0,mem-path="$tmp/nvdimm",size=256M \
     -device nvdimm,label-size=131072,memdev=mem0,id=nvdimm0,slot=1 \
     -nodefaults \
     -qmp stdio \
     -serial none \
     -device vmgenid \
     -device intel-iommu \
     -acpitable sig=FI1A,data="$tmp/fill1" \
     -acpitable sig=FI2A,data="$tmp/fill2" \
     -display none

Expected markers in the output:

/rom@etc/acpi/tables ... Used 0x0000000000020000
"status": "active"
"status": "cancelling", "error-desc": "RAM block '/rom@etc/acpi/tables' 
resized during precopy."
/rom@etc/acpi/tables ... Used 0x0000000000040000

Regards,
Akihiko Odaki

> 
>>
>> Observed via `info ramblock`:
>>
>> ```text
>> before cont:
>> /rom@etc/acpi/tables   Used 0x0000000000020000
>>
>> after cont:
>> /rom@etc/acpi/tables   Used 0x0000000000040000
>> ```
>>
>> So this does produce a real RAMBlock used-size growth during boot in the
>> current tree. With migration started before `cont` using a stalled `exec:`
>> target, `info migrate` moved to `cancelling`, which is consistent with the
>> current resize-during-precopy abort path.
>>
>> The key is not the root port itself; the key is making the ACPI table
>> rebuild cross `ACPI_BUILD_TABLE_SIZE` alignment. The filler is a bit
>> artificial, but it is a good stress variant for the exact class of bug.
> 
> I did have a closer look on this whole "MR size can change" thing.
> 
> We have two users: ACPI (rom_add_blob()) and other firmwares (most of them
> rom_add_file() users, very little used rom_add_blob()).
> 
> AFAIU, the real resize should only happen at the 2nd user, not ACPI.
> 
> ACPI seems to be able to change ROM size (PS: this is tricky to call it ROM
> in the first place: I believe it's only a data blob in fw_cfg) when e.g. it
> scans the pci bus and things changed, only happen during reboot, but it
> can't happen during migration because qdev_add is forbidden.
> 
> Device ROMs can really change size if dest host has newer firmware packages
> than source, but that's another use case and I _think_ we support fine,
> except that firmwares can only grow not shrink, guarded by
> qemu_ram_resize() check on max_length.
> 
> That's a pretty niche use case and nothing I can think of that on change of
> flipping migratable and so on.  So IMHO we will need to understand the
> problem better before having more notifiers.
> 
> PS: I wished ACPI three use cases of ROM can be part of device states
> already, then it is out of question on MR resize complexity: the max size
> is 128K as far as I know; it doesn't need iterability... we migrate devices
> sometimes much larger than 128KB on device states.  It can be a VMSD field.
> 
> Thanks,
> 


