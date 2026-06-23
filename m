Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085DACDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbztT-0000Kb-G7; Tue, 23 Jun 2026 08:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbztH-0008VO-C4; Tue, 23 Jun 2026 08:06:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wbztE-0000On-8J; Tue, 23 Jun 2026 08:06:06 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65NC5MDm068220
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 23 Jun 2026 21:05:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9icVwESoPEziromrElTWXlq4W6A+7nPEVg5wxcfPes8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1782216322; v=1;
 b=dh2pX73k57bNitgcjzM+naWKr7Mn+CiVA2w1u0Eyi8E3uZ4EkBqjyV40LcPMs3Zp
 G421yHXRFJPMer6h4x+VabcMYOMMW+1McFGt/MCo3BPGdrbACThjlQiLjZNdonH8
 ouHUg4L1dxNiG313ZrDgoriFiRE5JRl5oEYwDa2HoWKshSSroog9NJdU718MtGs6
 1bt+TFiSfpROxOzvm3dINrwBxFjb6G9UHSwk6EHWhWz/M1X4/ikS3lUN04byv7Xq
 Ou9E3yeBLCmjMPq8oEP5s/YkC7F1XZeJ1VTQZE502qMwptrnf/BWvWz+yWLC1VkQ
 Qm15dwUnyeh62sFEHa5ooQ==
Message-ID: <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 23 Jun 2026 21:05:22 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ajmZrT1d0QXCWTNq@x1.local>
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

On 2026/06/23 5:23, Peter Xu wrote:
> On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
>> Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
>> ("[PATCH] system/physmem: Assert migration invariants")
>>
>> ram_mig_ram_block_resized() already aborts migration when migratable RAM
>> is resized. Extend the same handling to other unsupported changes to the
>> migratable RAMBlock set, such as removing a migratable RAMBlock or
>> changing a RAMBlock's migratable state.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> Akihiko Odaki (3):
>>        system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
>>        system/physmem: Notify RAMBlock migratable and idstr changes
>>        migration/ram: Abort on unsupported migratable RAM changes
> 
> Thanks for looking at this, Akihiko.
> 
> I understand this is a protection to the system to trap error use cases.
> The question I have is do we have any possible way to trigger these.
> 
> I worry we add a bunch of code and notifiers, and then there's zero way to
> trigger, essentially add dead code.
> 
> Logically we could already add assert() on things we don't expect to
> happen.  This case might be slightly risky, but still I think we can also
> consider things like error_report_once() instead of introducing slightly
> complex notifiers just to cover what we think shouldn't happen.
> 
> Or do you have way to trigger any of these notifiers?

I simply followed what's already done for resize(), expecting resize() 
does the correct thing and following it won't introduce a regression.

> 
> PS: today I went back and I wanted to try how the existing resize()
> notifier would trigger, I can't even reproduce it with David's example
> here:
> 
> https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> 
> I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> so it didn't really notify a thing.  I don't really know how to trigger
> ram_block_notify_resize().  If you know, please share.
I made an LLM amend the reproducer. Below is its output.

Regards,
Akihiko Odaki

LLM output:

A synthetic but effective variant is to add custom ACPI filler tables so 
the initial `etc/acpi/tables` blob is just under the 128 KiB alignment 
bucket, then let the normal boot-time fw_cfg ACPI rebuild push it over.

I tested this shape:

```sh
truncate -s 65000 /tmp/fill1
truncate -s 50600 /tmp/fill2
```

Then add to the original-ish command:

```sh
-device pcie-root-port,id=rp0,chassis=1,slot=1 \
-acpitable sig=FI1A,data=/tmp/fill1 \
-acpitable sig=FI2A,data=/tmp/fill2
```

Observed via `info ramblock`:

```text
before cont:
/rom@etc/acpi/tables   Used 0x0000000000020000

after cont:
/rom@etc/acpi/tables   Used 0x0000000000040000
```

So this does produce a real RAMBlock used-size growth during boot in the 
current tree. With migration started before `cont` using a stalled 
`exec:` target, `info migrate` moved to `cancelling`, which is 
consistent with the current resize-during-precopy abort path.

The key is not the root port itself; the key is making the ACPI table 
rebuild cross `ACPI_BUILD_TABLE_SIZE` alignment. The filler is a bit 
artificial, but it is a good stress variant for the exact class of bug.

