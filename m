Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F624CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 02:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHC2G-0003hn-Mq; Thu, 06 Nov 2025 21:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHC2E-0003hQ-B9
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:17:06 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHC2B-0006qM-DP
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 21:17:06 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A72GufY011735
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Nov 2025 11:16:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/HD9wTbDQ1I3k5RDurFFBparun+t4XVtB+1HKQBuv2w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762481817; v=1;
 b=RpMU1YItJGK26M5zaqeXy09jXtW/kffyF31nQqiZ8STGZBiVzvgen26g2YGvSFn2
 +PHFr0jJnFKRE75wY75rP7Mz7YYixQgUjKz8A8b5pTVoUxzGO4jbZpsZaNM3aQ2p
 wG/bKrGsYlAoJuQpf2aNCZ/oBqJqG55rkK4oXVN+Rgmzsg6peikUxPA2Z5cYoq7h
 /0B42HQA5ed4vV+ijZ7nORu6l7LEom4mcR/kPr1KFIUJ6k/2Ou+HlZc/TNed4aBF
 kZhK7LtsvsB8LXG09vfGog1RVcdpz5ZZnOn5L1DK20DujeLKZX4jwFuSVdw48Vzz
 o4cL9z88Sr1IK5x2PqvvDQ==
Message-ID: <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 7 Nov 2025 11:16:56 +0900
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
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
 <aQzf4F6RgkzYWkeM@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aQzf4F6RgkzYWkeM@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/11/07 2:50, Peter Xu wrote:
> On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
>> Generally speaking, we will not necessarily "always" get an issue report
>> when things went wrong with memory management. A bug in memory management
>> may not cause an immediate crash but corrupt the memory state which you will
>> find only later. The end result of memory corruption may look random and
>> result in a hard-to-debug issue report. A user may not even bother writing
>> an issue report at all; this is especially true for this kind of corner
>> cases that rarely happen.
>>
>> There should have been no such a hazard of memory corruption if the code did
>> exactly what the documentation said in the first place. The consistency of
>> the code and the documentation is essential, especially for this kind of
>> complex and fundamental code.
> 
> Do you have encountered such case before?
> 
> I wasn't expecting that, because what you were saying looks more like what
> Linux kernel would have a bug in mm.  QEMU is still special as it has the
> default unassigned MR trapping everything by default, meanwhile normally
> what is moving is MMIO / alias regions rather than real ramblocks.  It
> means when things go wrong we have much higher chance to trap them
> properly.

When I said "memory management" I meant the methods we use to allocate 
and free memory (the Linux equivalents would be kmalloc()/free()/kref), 
not the MM tracking or unassigned MR trapping behavior you mentioned. 
The unassigned MR trap and MMIO/alias movement are a separate concern 
and don’t change the underlying risk.

Concrete example: imagine an alias is allocated with g_new() and freed 
immediately after object_unparent(). If that alias accidentally becomes 
the FlatView root, destroying the FlatView later will call 
memory_region_unref() and produce a use-after-free. We cannot predict 
what memory_region_unref() will read or write in that scenario — the 
result can be arbitrary memory corruption that surfaces much later as a 
hard-to-debug, intermittent problem. Users often won’t file an issue for 
these rare corner cases.

> 
> I also confess though that I'm pretty conservative on fixing things with
> hypothetical issues.  In general, I prefer fixing things with explicit
> problems, so we know how to measure and justify a fix (depending on how
> aggressive the fix is and how much maintanence burden it will bring to
> QEMU).  Without a real problem, it's harder to quantify that even if such
> evaluation will also normally be subjective too.

Regarding your preference to fix only explicit problems: I understand 
the conservatism, but here are the facts we need to weigh:

- The documentation claims we may free aliases because
   memory_region_ref() is never called, yet there is code that does call
   memory_region_ref().
- The patch adds code to align behavior with the documentation.

The significance of both potential impacts (the behavioral divergence 
for devices other than pci-bridge, and the added complexity needed for 
consistency) may be subjective and hypothetical, but that applies 
equally to both sides.

In this case, the long-term reliability and maintainability of QEMU 
depend on having the code behave as documented. Correctness should take 
precedence over simplicity.

Regards,
Akihiko Odaki

