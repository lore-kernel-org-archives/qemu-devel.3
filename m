Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9524C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXY7K-0005gi-O3; Fri, 04 Jul 2025 00:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXY7I-0005g8-LE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:33:40 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXY7F-0000A4-Ub
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751603618; x=1783139618;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=4BzuLV0AyQXNeAdSMs5WNJTQFht5U7OJu7ONR9aXnWA=;
 b=ImcRwh1QCBGIvtA6f8wH62sk6PiQei5uWR0dBy7FhEXY5MamcrsF5Tdi
 lrYqpNrjOUiZ4e3sepK0ZeA6eutqhGsXw38ZPb98HxVoB/yTPZ0czJ7Xh
 zG4b3LAIq6ck9/4HMyP/E6nR0rFDrAq6CUXBl0jG/0RcKrwnwy8uHDaCv
 2QCDLcae1WLtkyhlbWhyRBuBawbHYwEfNju07bkNXpPOH2lGkuxpkzuHC
 +Sv0IDM1YWNxOa7sTiiLjBXTWp05KHpsOUCSTqgrtvydzaK5cgLyYkUCb
 SL4VJfNp+2usEl0iUVQd4ksrbjPw5cOJ5zR5zyD5YpjM6j0NhZwGjowjM g==;
X-CSE-ConnectionGUID: b2aCnQbLT1yCL/cct3tpUQ==
X-CSE-MsgGUID: pVNkOXeITbmdy9W7q5HNUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64629678"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="64629678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:33:35 -0700
X-CSE-ConnectionGUID: SlKwQExhQZeDSlKmd5twGw==
X-CSE-MsgGUID: h/au2Dr6TBCdNZK+qwGUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154627055"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 21:33:34 -0700
Message-ID: <3d294ef8-78d3-45be-9652-0c61246aaccc@intel.com>
Date: Fri, 4 Jul 2025 12:33:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/39] accel/tcg: Factor tcg_dump_flush_info() out
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-10-philmd@linaro.org>
 <300d66d9-20dd-47c8-adeb-bd917cfb3d08@intel.com>
Content-Language: en-US
In-Reply-To: <300d66d9-20dd-47c8-adeb-bd917cfb3d08@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/4/2025 12:27 PM, Xiaoyao Li wrote:
> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
>> ---
>>   accel/tcg/monitor.c | 27 +++++++++++++++++----------
>>   1 file changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
>> index 344ec500473..6d9cc11d94c 100644
>> --- a/accel/tcg/monitor.c
>> +++ b/accel/tcg/monitor.c
>> @@ -141,11 +141,26 @@ static void tlb_flush_counts(size_t *pfull, 
>> size_t *ppart, size_t *pelide)
>>       *pelide = elide;
>>   }
>> +static void tcg_dump_flush_info(GString *buf)
>> +{
>> +    size_t flush_full, flush_part, flush_elide;
>> +
>> +    g_string_append_printf(buf, "TB flush count      %u\n",
>> +                           qatomic_read(&tb_ctx.tb_flush_count));
>> +    g_string_append_printf(buf, "TB invalidate count %u\n",
>> +                           
>> qatomic_read(&tb_ctx.tb_phys_invalidate_count));
>> +
>> +    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
>> +    g_string_append_printf(buf, "TLB full flushes    %zu\n", 
>> flush_full);
>> +    g_string_append_printf(buf, "TLB partial flushes %zu\n", 
>> flush_part);
>> +    g_string_append_printf(buf, "TLB elided flushes  %zu\n", 
>> flush_elide);
>> +}
>> +
>>   static void dump_exec_info(GString *buf)
>>   {
>>       struct tb_tree_stats tst = {};
>>       struct qht_stats hst;
>> -    size_t nb_tbs, flush_full, flush_part, flush_elide;
>> +    size_t nb_tbs;
>>       tcg_tb_foreach(tb_tree_stats_iter, &tst);
>>       nb_tbs = tst.nb_tbs;
>> @@ -182,15 +197,7 @@ static void dump_exec_info(GString *buf)
>>       qht_statistics_destroy(&hst);
>>       g_string_append_printf(buf, "\nStatistics:\n");
>> -    g_string_append_printf(buf, "TB flush count      %u\n",
> 
> side topic,
> 
> is the "TB" an typo of "TLB"?

Please ignore my silly question. It's TranslationBlock of tcg.

>> -                           qatomic_read(&tb_ctx.tb_flush_count));
>> -    g_string_append_printf(buf, "TB invalidate count %u\n",
>> -                           
>> qatomic_read(&tb_ctx.tb_phys_invalidate_count));
>> -
>> -    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
>> -    g_string_append_printf(buf, "TLB full flushes    %zu\n", 
>> flush_full);
>> -    g_string_append_printf(buf, "TLB partial flushes %zu\n", 
>> flush_part);
>> -    g_string_append_printf(buf, "TLB elided flushes  %zu\n", 
>> flush_elide);
>> +    tcg_dump_flush_info(buf);
>>   }
>>   HumanReadableText *qmp_x_query_jit(Error **errp)
> 


