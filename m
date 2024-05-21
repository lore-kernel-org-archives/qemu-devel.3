Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0091C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 07:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Jca-00016P-N4; Tue, 21 May 2024 03:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s9JcX-00015y-Sn; Tue, 21 May 2024 03:09:13 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s9JcU-0007y6-V1; Tue, 21 May 2024 03:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716275351; x=1747811351;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Pvz7MwSyLrso6mVoQ+oMHX6flK5vwhKGpZy9yfr2v4g=;
 b=ItTfN3MHsVT5Ogqlq/2hQJpI3vlvA2BDDhLyWezOVQto6YsPLf5bHItm
 vpQCnOtCir+Jyeo+TnX4F771VormmFlbrjnSoG0xrV7fccbuV2HvHzxoa
 tbtTwZMlHI0Vw2zWnT8SOwuhs1ZHmx42L9t7gkhwkBv+K+MqAdwk8nu2h
 VBoOoG5JyrT20oTp9Jz3ZQLRnyz5poaRuuJ71qcMZkxngblG0D+Bu8PRT
 P8f1lrdxA/+BkB0YRVPEr7WSuhBpoUVqQRs7tbZGbX81y5WzNSIo6JAdd
 X/y2XIcmvpew501KGPB8p0hA1/OfaN0M2ZLSmgf1waIEXzo2vnc28cMHk w==;
X-CSE-ConnectionGUID: 8Vhfzc0ZQR+HRv6ZetmLDw==
X-CSE-MsgGUID: G7zCWYnKRu6+RgEb6cZBag==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="37824370"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="37824370"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 00:09:06 -0700
X-CSE-ConnectionGUID: ZWknJowKQB2OV9O07QuR3g==
X-CSE-MsgGUID: 2ZA/SjucQv6SNNZRGIyJ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; d="scan'208";a="32681251"
Received: from pkrish5-mobl2.gar.corp.intel.com (HELO [10.98.172.235])
 ([10.98.172.235])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 00:09:05 -0700
Message-ID: <310b54f1-e0b1-4cdb-a187-5014976bc946@intel.com>
Date: Tue, 21 May 2024 00:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vl: Allow multiple -overcommit commands
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240520174733.32979-1-zide.chen@intel.com>
 <20240520174733.32979-2-zide.chen@intel.com>
 <7b6bb859-acbe-4fb0-a8d5-c1698f597ef7@redhat.com>
 <342858a6-c8bd-45fe-8b91-8e0a444eb2e6@redhat.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <342858a6-c8bd-45fe-8b91-8e0a444eb2e6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 5/20/2024 10:16 PM, Thomas Huth wrote:
> On 21/05/2024 07.08, Thomas Huth wrote:
>> On 20/05/2024 19.47, Zide Chen wrote:
>>> Both cpu-pm and mem-lock are related to system resource overcommit, but
>>> they are separate from each other, in terms of how they are realized,
>>> and of course, they are applied to different system resources.
>>>
>>> It's tempting to use separate command lines to specify their behavior.
>>> e.g., in the following example, the cpu-pm command is quietly
>>> overwritten, and it's not easy to notice it without careful inspection.
>>>
>>>    --overcommit mem-lock=on
>>>    --overcommit cpu-pm=on
>>>
>>> Fixes: c8c9dc42b7ca ("Remove the deprecated -realtime option")
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>>   system/vl.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/system/vl.c b/system/vl.c
>>> index a3eede5fa5b8..ed682643805b 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -3545,8 +3545,12 @@ void qemu_init(int argc, char **argv)
>>>                   if (!opts) {
>>>                       exit(1);
>>>                   }
>>> -                enable_mlock = qemu_opt_get_bool(opts, "mem-lock",
>>> false);
>>> -                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm",
>>> false);
>>> +
>>> +                /* Don't override the -overcommit option if set */
>>> +                enable_mlock = enable_mlock ||
>>> +                    qemu_opt_get_bool(opts, "mem-lock", false);
>>> +                enable_cpu_pm = enable_cpu_pm ||
>>> +                    qemu_opt_get_bool(opts, "cpu-pm", false);
>>>                   break;
>>>               case QEMU_OPTION_compat:
>>>                   {
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Ah, wait, actually, this is a bad idea, too, since now you cannot
> disable an enabled option anymore. Imagine that you have for example
> enabled the option in the config file, and now you'd like to disable it
> on the command line again - you're stuck with the enabled setting in
> that case.
> 
> I think the better solution is to replace the "false" default value at
> the end:
> 
>         enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
>         enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
> 
> What do you think about this?

This is great! Thank you very much! I will update it in V2.

> 
>  Thomas
> 

