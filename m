Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62939C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 07:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ3M7-0003zV-EG; Wed, 31 Jul 2024 03:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZ3M2-0003y0-UZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:02:34 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZ3Lx-0002Px-CN
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722409349; x=1753945349;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tFcaMWnp1Awrg3A50K8+ER6rz36OBJRtVM4vkWnWJzo=;
 b=P/UMoWLdEaS0fBzfjkLNghxsd2nLCsjnFOjrzJYXuXnzdkl9CA/UV6Rg
 O73UuBr7hTjRXLDlgTXP95hsP49C/vSUJdXMIK2ntQvKb4cc9KyWCRZBc
 7ZLJ6UvIvPXIpFngfi6tOuw6zhlDWbx1ZJ+FUdp9694+GJjI/Yb5GIs+3
 K1kouB/KXqBYYyD6JDiLx1Xrw2pY0dtnPG6F+s88V/wl4c9wenr02qX0f
 R8T35xLvyy8btwQ8Lh97N0TNb1Cg3x80v80kJxkENblx5EaOvI8N9j37G
 pVY89nPzkWJfz2s3wVFJmh0mR5cP9tGFTk6ddoKBayNqgmJZG95ft14kz w==;
X-CSE-ConnectionGUID: zM6GmWaNQkeZ1yVZIs1E5Q==
X-CSE-MsgGUID: mQp+TpuCT6Wn+D/TESL5PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="45685577"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="45685577"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 00:02:19 -0700
X-CSE-ConnectionGUID: abT8NU6DTu6bgGmsXhpLPQ==
X-CSE-MsgGUID: EEoDCRl8Qoy1EtxJKni9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="85512040"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 00:02:18 -0700
Message-ID: <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com>
Date: Wed, 31 Jul 2024 15:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
To: Manish <manish.mishra@nutanix.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/24/2024 6:29 PM, Manish wrote:
> Thanks Igor
> 
> On 24/07/24 2:30 pm, Igor Mammedov wrote:
>> !-------------------------------------------------------------------|
>>    CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> On Wed, 24 Jul 2024 07:52:26 +0000
>> "manish.mishra"<manish.mishra@nutanix.com>  wrote:
>>
>>> From: Manish Mishra<manish.mishra@nutanix.com>
>>>
>>> QEMU does not set 0x1f in case VM does not have extended CPU topology
>>> and expects guests to fallback to 0xb. Some versions of Windows does not
>>> like this behavior and expects this leaf to be populated. As a result 
>>> Windows
>>> VM fails with blue screen.
>> BSOD usually has error code displayed, it would be better to specify 
>> it here
>> this way whomever searching for the error, can find this patch/commit
> Sorry for earlier response, i do not see blue screen it seems to be 
> falling in uefi back quickly and i do not see any details here. I am 
> attaching image.
>>
>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>> to 0xb by default and workaround windows issue.>
>>> This change adds a
>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>> case extended CPU topology is not configured and behave as before 
>>> otherwise.
>> repeating question
>> why we need to use extra property instead of just adding 0x1f leaf for 
>> CPU models
>> that supposed to have it?
> 
> As i mentioned in earlier response. "Windows expects it only when we 
> have set max cpuid level greater than or equal to 0x1f. I mean if it is 
> exposed it should not be all zeros. SapphireRapids CPU definition raised 
> cpuid level to 0x20, so we starting seeing it with SapphireRapids."
> 
> Windows does not expect 0x1f to be present for any CPU model. But if it 
> is exposed to the guest, it expects non-zero values.

Please fix Windows!

No guarantee from Intel that leaf 0x1f should report non-zero value when 
max cpuid level >= 0x1f.

Please see SDM.vol2.CPUID chapter.

INPUT EAX = 1FH: Returns V2 Extended Topology Information

When CPUID executes with EAX set to 1FH, the processor returns 
information about extended topology enumeration data. Software must 
detect the presence of CPUID leaf 1FH by verifying (a) the highest leaf 
index supported by CPUID is >= 1FH, and (b) CPUID.1FH:EBX[15:0] reports 
a non-zero value. See Table 3-17.

