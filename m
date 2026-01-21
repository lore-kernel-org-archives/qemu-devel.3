Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33134D262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 05:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viQd6-0004IP-MJ; Wed, 21 Jan 2026 00:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1viQd4-0004IB-Lt
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 00:19:42 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1viQd2-0003ku-Hn
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 00:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768972781; x=1800508781;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=36eUIuF0FMwRHHdfsmDn9x6uLIz/x6CIt7c8I/nawr4=;
 b=lsJ1HVDD9ZCGojxVssluBEXRF4YgN89rq5RtV1Ir7xr4ggONLYE8nHPd
 sMMfhDFCKU6AoWcURCkUm38hbG66NKe5BuiaieaIcXXb6V5mcwZJqwMKd
 HbNnItdfjpFe2fPt/GGCp6MJKPn+iMMnDb5JjTdLvWTmd1M1qZxjB28rJ
 30059Zq3pBY2RYMkfl/5twjUkuMSjmfokUJ18WXLNn9/FCFwTRvK6KIc6
 keUqKovap+WsNsSFgT71aZlKbaWhDhJCxXytrhvNPFhtlfjqQDyQBKxdu
 Ey6AYkBEdXYDrAUH2NYlKvgBhRQwCNweT5NdbwXnC11XP3rTxDcKXdAK5 Q==;
X-CSE-ConnectionGUID: TMLGyFFoQFWsMNwdyQ0BRQ==
X-CSE-MsgGUID: EgJVBRYKTGGDgt6mb6FDvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87606695"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="87606695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 21:19:36 -0800
X-CSE-ConnectionGUID: lx9zVxU/T6e1wqxPpYZklQ==
X-CSE-MsgGUID: n5SLNxg+TUi9wrdEumSwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="210788675"
Received: from unknown (HELO [10.238.3.254]) ([10.238.3.254])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 21:19:33 -0800
Message-ID: <c87ba875-5708-4ef9-8e75-5558d8b49b14@linux.intel.com>
Date: Wed, 21 Jan 2026 13:19:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/i386: Make some PEBS features user-visible
To: "Chen, Zide" <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260117011053.80723-1-zide.chen@intel.com>
 <20260117011053.80723-7-zide.chen@intel.com>
 <56dd6056-e3e2-46cd-9426-87c7889bed49@linux.intel.com>
 <513c6944-b80a-46f2-ad6c-4de77dac4b09@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <513c6944-b80a-46f2-ad6c-4de77dac4b09@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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


On 1/21/2026 5:58 AM, Chen, Zide wrote:
>
> On 1/18/2026 7:30 PM, Mi, Dapeng wrote:
>> On 1/17/2026 9:10 AM, Zide Chen wrote:
>>> Populate selected PEBS feature names in FEAT_PERF_CAPABILITIES to make
>>> the corresponding bits user-visible CPU feature knobs, allowing them to
>>> be explicitly enabled or disabled via -cpu +/-<feature>.
>>>
>>> Once named, these bits become part of the guest CPU configuration
>>> contract.  If a VM is configured with such a feature enabled, migration
>>> to a destination that does not support the feature may fail, as the
>>> destination cannot honor the guest-visible CPU model.
>>>
>>> The PEBS_FMT bits are intentionally not exposed. They are not meaningful
>>> as user-visible features, and QEMU registers CPU features as boolean
>>> QOM properties, which makes them unsuitable for representing and
>>> checking numeric capabilities.
>> Currently KVM supports user space sets PEBS_FMT (see vmx_set_msr()), but
>> just requires the guest PEBS_FMT is identical with host PEBS_FMT.
> My mistake — this is indeed problematic.
>
> There are four possible ways to expose pebs_fmt to the guest when
> cpu->migratable = true:
>
> 1. Add a pebs_fmt option similar to lbr_fmt.
> This may work, but is not user-friendly and adds unnecessary complexity.
>
> 2. Set feat_names[8] = feat_names[9] = ... = "pebs-fmt".
> This violates the implicit rule that feat_names[] entries should be
> unique, and target/i386 does not support numeric features.
>
> 3. Use feat_names[8..11] = "pebs-fmt[1/2/3/4]".
> This has two issues:
> - It exposes pebs-fmt[1/2/3/4] as independent features, which is
> semantically incorrect.
> - Migration may fail incorrectly; e.g., migrating from pebs_fmt=2 to a
> more capable host (pebs_fmt=4) would be reported as missing pebs-fmt2.
>
> Given this, I propose the below changes. This may allow migration to a
> less capable destination, which is not ideal, but it avoids false
> “missing feature” bug and preserves the expectation that ensuring
> destination compatibility is the responsibility of the management
> application or the user.
>
> BTW, I am not proposing a generic “x86 CPU numeric feature” mechanism at
> this time, as it is unclear whether lbr_fmt and pebs_fmt alone justify
> such a change.
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 015ba3fc9c7b..b6c95d5ceb31 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1629,6 +1629,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .msr = {
>              .index = MSR_IA32_PERF_CAPABILITIES,
>          },
> +       .migratable_flags = PERF_CAP_PEBS_FMT,
>      },
>
>      [FEAT_VMX_PROCBASED_CTLS] = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1666eff65300..de4074d6baa7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -421,6 +421,7 @@ typedef enum X86Seg {
>
>  #define MSR_IA32_PERF_CAPABILITIES      0x345
>  #define PERF_CAP_LBR_FMT                0x3f
> +#define PERF_CAP_PEBS_FMT               0xf00
>  #define PERF_CAP_FULL_WRITE             (1U << 13)
>  #define PERF_CAP_PEBS_BASELINE          (1U << 14)

I can't say if this is the best way. Maybe @Zhao can give some comments.
Thanks.


>
>
>> IIRC, many places in KVM judges whether guest PEBS is enabled by checking
>> the guest PEBS_FMT. If we don't expose PEBS_FMT to user space, how does KVM
>> get the guest PEBS_FMT?
>>
>>
>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>>  target/i386/cpu.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index f1ac98970d3e..fc6a64287415 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1618,10 +1618,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>>          .type = MSR_FEATURE_WORD,
>>>          .feat_names = {
>>>              NULL, NULL, NULL, NULL,
>>> +            NULL, NULL, "pebs-trap", "pebs-arch-reg"
>>>              NULL, NULL, NULL, NULL,
>>> -            NULL, NULL, NULL, NULL,
>>> -            NULL, "full-width-write", NULL, NULL,
>>> -            NULL, NULL, NULL, NULL,
>>> +            NULL, "full-width-write", "pebs-baseline", NULL,
>>> +            NULL, "pebs-timing-info", NULL, NULL,
>>>              NULL, NULL, NULL, NULL,
>>>              NULL, NULL, NULL, NULL,
>>>              NULL, NULL, NULL, NULL,
>

