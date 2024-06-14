Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD49C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHvLB-0002u8-Ab; Thu, 13 Jun 2024 21:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHvL9-0002rM-Vo
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:02:52 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHvL7-0001uk-3E
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 21:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718326969; x=1749862969;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tFRlYn2K3HB7GCAI89e1+dbTZ6mOUkfUgxVIHYjH+XU=;
 b=bnWjCE55nK0e592GdOuSKYkW96QQvz0WsIEy7DHMnLHslC1v1COFgIo5
 3v9H+ZnSRahg6JF5ppEuEa52y3HNiogpg+zutOLzFnL+todJEMjlyZaeF
 lCO5mdD53K0DCwItbyMV+W2ZqB7gVhz9Czlps15wOyVyIChs1tn6FJIru
 t+YQXEhD5GiGQKf0DL1ALRY2EkVsDkE81otKmmD7JTRhHIA544049akXo
 G82ke4Pv9k0gyAhcMKvpFQXb1LbwpQpODEJzJTEhpca8QF/ekwibVEEs9
 312+tvW4gjQtTM3Jwb+RhuBU/HyznQP919GMDiDAdtkf3kHRaAN1Z2FiE g==;
X-CSE-ConnectionGUID: yf6FN8snRC+8wN0/uwVd2Q==
X-CSE-MsgGUID: ksOKmBsJQUKos7FAsAGxWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15031200"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="15031200"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 18:02:47 -0700
X-CSE-ConnectionGUID: JQOMG1KcRJCFrkc821OyIw==
X-CSE-MsgGUID: ZL1yDBfUSwSK4I0y1Idc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; d="scan'208";a="40446982"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 18:02:39 -0700
Message-ID: <df0a17b0-16a8-44bf-8862-551b81d93cac@intel.com>
Date: Fri, 14 Jun 2024 09:02:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/65] i386/tdx: Adjust the supported CPUID based on
 TDX restrictions
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-18-xiaoyao.li@intel.com>
 <511a147e-bc01-7fab-24d7-4ae66a6d1c44@intel.com>
 <04932fb5-1ab4-4f8e-90dc-4f1a71feefb6@intel.com>
 <SJ0PR11MB67447DFF37D0F1A0EF25F6A192C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <SJ0PR11MB67447DFF37D0F1A0EF25F6A192C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/2024 4:26 PM, Duan, Zhenzhong wrote:
>>>> +     *
>>>> +     * It also has side effect to enable unsupported bits, e.g., the
>>>> +     * bits of "fixed0" type while present natively. It's safe because
>>>> +     * the unsupported bits will be masked off by .fixed0 later.
>>>> +     */
>>>> +    *ret |= host_cpuid_reg(function, index, reg);
>>> Looks KVM capabilities are merged with native bits, is this intentional?
>> yes, if we change the order, it would be more clear for you I guess.
>>
>> 	host_cpuid_reg() | kvm_capabilities
>>
>> The base is host's native value, while any bit that absent from native
>> but KVM can emulate is also added to base.
> Imagine there is a 'type native' bit that's absent from native but KVM emulated,
> With above code we pass 1 to tdx module but it wants native 0, is it an issue?

yes, it will have issue but it's not "we pass 1 to tdx_module".

"Native" bit is not configurable in the view of TDX module, and QEMU/KVM 
cannot configure it. But it does causes mismatch in above case that QEMU 
sees the bit is supported while in the TD the bit is not supported.

This is one of the reason why we are going to drop the solution that 
QEMU maintains the CPUID configurability in this series.

