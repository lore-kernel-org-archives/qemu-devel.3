Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E079ECCFA0D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 02:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGpf9-0001Gy-7a; Wed, 05 Nov 2025 21:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGpf7-0001Gq-Gw
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 21:23:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGpf4-0007eF-Oq
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 21:23:45 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A62NWlR012547
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Nov 2025 11:23:33 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xvHaFHik6aAJRUFvn4mVSkt/90XNMj2Les3UULLY4mQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762395813; v=1;
 b=gX/ul2iDcQfCYAINxqC+PxVF++C997dDgXow3X8cR2MuLjiV8XakLaHkr1jdfnRo
 KwqSiZO/GFSjZ9CSnJxn8dPT8108StwOT2bBWqEJtAItlYazjBuTaOISxvszUEkk
 zEXVxiKRlVW7+bHXly0VQ+4sRM9qkjMfQ6Ok6P6QfGCBcNNfZklIIskGdrULCwux
 7pUTeXtY5L7vgt+pde2zTqeKCbSwacfDl2zsYvS+mcII/K1fmNCJCcuTijhJgKA5
 +cjj3XfIqA3Pm12yp6eUBguYKZK7I6NO1qfHihzvzuaXvUJhDpKBx6YbAtXhX+tD
 MuGu68l5Od0uhgIrYB+J+w==
Message-ID: <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Nov 2025 11:23:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Make FlatView root references weak
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aQuuhSL6rXmyqm8x@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/06 5:07, Peter Xu wrote:
> On Mon, Nov 03, 2025 at 08:18:00PM +0900, Akihiko Odaki wrote:
>> It unfortunately does not work for pci-bridge. It has the following
>> function:
>>
>> void pci_bridge_update_mappings(PCIBridge *br)
>> {
>>      PCIBridgeWindows *w = &br->windows;
>>
>>      /* Make updates atomic to: handle the case of one VCPU updating the
>> bridge
>>       * while another accesses an unaffected region. */
>>      memory_region_transaction_begin();
>>      pci_bridge_region_del(br, w);
>>      pci_bridge_region_cleanup(br, w);
>>      pci_bridge_region_init(br);
>>      memory_region_transaction_commit();
>> }
>>
>> object_unparent() happens in pci_bridge_region_cleanup().
>> pci_bridge_region_init() reuses the storage.
>> memory_region_transaction_commit() triggers flatview_unref(), but it needs
>> to happen before pci_bridge_region_init().
>>
>> memory_region_transaction_commit() also has an undesirable characteristic
>> that its effect may be delayed due to nesting. To make sure flatview_unref()
>> happens with a particular call of memory_region_transaction_commit(), you
>> need to traverse the possible call graph that lead to the function.
>>
>> So I'm afraid but I don't think there is a better way to ensure correctness
>> without a codebase-wide audit.
> 
> Ah indeed, I missed that. :(
> 
> One way to work this around is providing a helper (abstraction from the
> current memory_region_transaction_commit) to enforce a flatview reset
> before reusing.  However I feel like it's an overkill too, but at least
> that would also avoid weak-refs.

Enforcing a FlatView reset for *one* memory_region_transaction_commit() 
call is incompatible with nesting, which require delaying it until all 
memory_region_transaction_commit() calls to finish.

> 
> I think in practise I'd vote we fix pci-bridge only, either with your other
> proposal to dynamically allocate the alias MRs, or something like you
> posted previously:
> 
> https://lore.kernel.org/all/20250906-use-v1-3-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp/#t
> 
> Personally, I don't mind fixing pci-bridge only even if we don't audit the
> whole code base.  The audit work is time consuming, and I'd simply trust
> the tests from all the QEMU users covering whatever devices are still being
> used. We will always get an issue report when something was wrong.
> 
> What do you think?

Generally speaking, we will not necessarily "always" get an issue report 
when things went wrong with memory management. A bug in memory 
management may not cause an immediate crash but corrupt the memory state 
which you will find only later. The end result of memory corruption may 
look random and result in a hard-to-debug issue report. A user may not 
even bother writing an issue report at all; this is especially true for 
this kind of corner cases that rarely happen.

There should have been no such a hazard of memory corruption if the code 
did exactly what the documentation said in the first place. The 
consistency of the code and the documentation is essential, especially 
for this kind of complex and fundamental code.

Regards,
Akihiko Odaki

