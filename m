Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6AC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRli-0000O6-BY; Tue, 20 Feb 2024 10:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcRle-0000NE-Hv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:10:46 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rcRlb-0004LL-Nk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708441844; x=1739977844;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=MNul5Z8YS8ETylWhyngw23B0/F5Ht+fLakLw7oSXUeU=;
 b=gzvxin+NpsxEF/HWNaRQOEPSwUeiIddG8lpguMsDJpe87ihufPlXjO1r
 BB1wbUWJPN0wDM761Iheiv6TusJndqYe4BqwomfrDWoMNQm5w9bKMDb8s
 AwFXc3DaSxkymYQH1/rwYRZjoWA2Eqaxn4eci/5ZaZM8rbZbPcp1FtRz9
 lSaVk0lFJwRuYkOoFtQ1omVdbNlaOru3wp4G14RRlfWCC42uqAOHX42IM
 TMeEVrgTEcZfHSw/3KJe0xzYKENnvG4HTUKDCABvjRtBEtzGiWwIAPgkS
 k1zuNk+a0rtXl9MoG886MTtCIdeIiLjrSwS68ztoQUj15MpomHAr3+IJQ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13960864"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; d="scan'208";a="13960864"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 07:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4845066"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 07:10:33 -0800
Message-ID: <cf9e91ea-825a-444c-9625-a571fdc3265a@intel.com>
Date: Tue, 20 Feb 2024 23:10:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/66] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-30-xiaoyao.li@intel.com>
 <875xykfwmf.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <875xykfwmf.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/19/2024 8:48 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>> can be provided for TDX attestation. Detailed meaning of them can be
>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
>>
>> Allow user to specify those values via property mrconfigid, mrowner and
>> mrownerconfig. They are all in base64 format.
>>
>> example
>> -object tdx-guest, \
>>    mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> ---
>> Changes in v4:
>>   - describe more of there fields in qom.json
>>   - free the old value before set new value to avoid memory leak in
>>     _setter(); (Daniel)
>>
>> Changes in v3:
>>   - use base64 encoding instread of hex-string;
>> ---
>>   qapi/qom.json         | 14 ++++++-
>>   target/i386/kvm/tdx.c | 87 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |  3 ++
>>   3 files changed, 103 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 2177f3101382..15445f9e41fc 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -905,10 +905,22 @@
>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>   #     be set, otherwise they refuse to boot.
>>   #
>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>> +#     e.g., run-time or OS configuration.  base64 encoded SHA384 digest.
> 
> "base64 encoded SHA384" is not a sentence.
> 
> Double-checking: the data being hashed here is the "non-owner-defined
> configuration of the guest TD", and the resulting hash is the "ID"?

yes. The "ID" here means the resulting hash.

The reason to use "ID" here because in the TDX spec, it's description is

   Software-defined ID for non-owner-defined configuration of the guest
   TD - e.g., run-time or OS configuration.

If ID is confusing, how about

   SHA384 hash of non-owner-defined configuration of the guest TD, e.g.,
   run-time of OS configuration.  It's base64 encoded.

>> +#
>> +# @mrowner: ID for the guest TD’s owner.  base64 encoded SHA384 digest.
> 
> Likewise.
> 
>> +#
>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>> +#     e.g., specific to the workload rather than the run-time or OS.
>> +#     base64 encoded SHA384 digest.
> 
> Likewise.
> 
>> +#
>>   # Since: 9.0
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>> -  'data': { '*sept-ve-disable': 'bool' } }
>> +  'data': { '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
> 
> The new members are optional, but their description in the doc comment
> doesn't explain behavior when present vs. behavior when absent.
> 
>>   
>>   ##
>>   # @ThreadContextProperties:
> 
> [...]
> 
> 


