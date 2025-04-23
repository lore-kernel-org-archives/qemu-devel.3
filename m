Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF01C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZqK-0007Vi-T0; Wed, 23 Apr 2025 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Zq8-0007LE-00
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:08:41 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7Zq1-0008GX-Hu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745413710; x=1776949710;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3VqGwj3+sY0uLWw4JqTBQNg6+lFNIaFJqTbg3MNeBZw=;
 b=VvfJ3AE4YRzctLb2X0x1N0c8PzhC9GlV0bdbyIQO6EDizNLML9pl4M93
 0vvLwrdEJX0SsfklPN/efz2Rsahj0kNb7Sln8L70Kexgn+uq0zoKRiWAS
 AWuBVBSwmcgovZP/QUXfEYqjUJAIiCCJPpBAP3sSZC2kyIaxSvFnUqWkU
 tCEaZkU9KnrvWEHZGyrRkxAZ0TkIv6TrtbkqzOcKV7PD6yEaDplSekDHC
 1N16vhscDXJQl/Jd+HsJ9d/qtTSHGJEjRM+x9MlLs1oAAk0SbNPYYf+2f
 iV5UsBwo9Cy9q+d4fxMuRnhbhCGiKGY/oTxr6tkaV6Zm1c0p7ir1adovp Q==;
X-CSE-ConnectionGUID: jqp/sqqyQMyBEGlVOnIv3A==
X-CSE-MsgGUID: E2HQumV8Rmi/spGC/FFZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="64532035"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="64532035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 06:08:27 -0700
X-CSE-ConnectionGUID: ABK32sNeQxW7E6ftS5OXvg==
X-CSE-MsgGUID: Hk4J5wkESpCOZchnIzJ/hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="163283416"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 06:08:24 -0700
Message-ID: <bb453ec7-deec-42aa-b9b1-ac0f4bf2f967@intel.com>
Date: Wed, 23 Apr 2025 21:08:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
To: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com> <aAe49odpsz108aZb@intel.com>
 <e67699a5-8b62-45a0-8cf1-586440ec85ee@intel.com> <aAjdqiTY/KNB+KtQ@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aAjdqiTY/KNB+KtQ@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/23/2025 8:31 PM, Zhao Liu wrote:
> On Wed, Apr 23, 2025 at 04:11:25PM +0800, Xiaoyao Li wrote:
>> Date: Wed, 23 Apr 2025 16:11:25 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
>>   mrconfigid/mrowner/mrownerconfig
>>
>> On 4/22/2025 11:42 PM, Zhao Liu wrote:
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index f229bb07aaec..a8379bac1719 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -1060,11 +1060,25 @@
>>>>    #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>>    #     be set, otherwise they refuse to boot.
>>>>    #
>>>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>>>> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
>>>> +#     Defaults to all zeros.
>>>
>>> Maybe a typo? s/Defaults/Default/
>>
>> (It) defaults to all zeros.
>>
>> If you grep the "defaults to", you can get a lot of it.
> 
> The comment can be relaxed, but please try to be precise with the doc.
> You can add the omitted "It".

Actually, it came from Markus[*], the QAPI maintainer.

So I would leave it to him to make the decision.

[*] https://lore.kernel.org/qemu-devel/87ttli87sw.fsf@pond.sub.org/

