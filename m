Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0608BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 02:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmOy5-0008W2-MC; Mon, 18 Mar 2024 22:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmOy1-0008Vi-I9; Mon, 18 Mar 2024 22:12:41 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rmOxz-0005d7-81; Mon, 18 Mar 2024 22:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710814359; x=1742350359;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iW4juU0C/8rcjYzYGLt3ayPiS3OyX9+0GN6sc26dffo=;
 b=bMSTHlMFJaWM6+7c+u8rkA7VPV978a44mc4XlmiEI0yh1RgZWXC14cm8
 EZUOsaRelpQF9rjHI5snLJfN//L4XaP1QmbgBQ1w89f0XB1zoI/v7JzVH
 zzeJXDsIvLhOaQW17PIl3bBYkrSGm0+hfQZ7AVhfdDrx+3nj2FSNVi5by
 u1kcBYfZ0ZnVYHFHN7qB7rqfGNIsZ0q9BLilfona57NW7/JdXMRwkW364
 XJm+nz4WquSNR+UocXb1za/dT0GLvxxmslme3YuustCqlU1SSAw1uGohl
 f14QII01ichsBuqH0LVyNhfAInuCMysAQecnl4eJoHhU++Fz+al20Lzzv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9427351"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="9427351"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 19:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="18312475"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 19:12:29 -0700
Message-ID: <99697bba-e1a7-4091-9065-65f4726f2f13@intel.com>
Date: Tue, 19 Mar 2024 10:12:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] i386/sev: Switch to use confidential_guest_kvm_init()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20240229060038.606591-1-xiaoyao.li@intel.com>
 <20240229060038.606591-3-xiaoyao.li@intel.com>
 <CABgObfbJn01k0WM0o6MfuvQctm0U2uX-D4DQKzStj4N9KwLZTw@mail.gmail.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfbJn01k0WM0o6MfuvQctm0U2uX-D4DQKzStj4N9KwLZTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/19/2024 5:51 AM, Paolo Bonzini wrote:
> On Thu, Feb 29, 2024 at 7:01 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> Use confidential_guest_kvm_init() instead of calling SEV specific
>> sev_kvm_init(). As a bouns, it fits to future TDX when TDX implements
>> its own confidential_guest_support and .kvm_init().
>>
>> Move the "TypeInfo sev_guest_info" definition and related functions to
>> the end of the file, to avoid declaring the sev_kvm_init() ahead.
>>
>> Delete the sve-stub.c since it's not needed anymore.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes from rfc v1:
>> - check ms->cgs not NULL before calling confidential_guest_kvm_init();
>> - delete the sev-stub.c;
> 
> Queued, with just one small simplification that can be done on top:

thank you, Paolo!

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index e89d64fa52..b8f79d34d1 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -851,18 +851,13 @@ sev_vm_state_change(void *opaque, bool running,
> RunState state)
> 
>   static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>   {
> -    SevGuestState *sev
> -        = (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
> +    SevGuestState *sev = SEV_GUEST(cgs);
>       char *devname;
>       int ret, fw_error, cmd;
>       uint32_t ebx;
>       uint32_t host_cbitpos;
>       struct sev_user_data_status status = {};
> 
> -    if (!sev) {
> -        return 0;
> -    }
> -
>       ret = ram_block_discard_disable(true);
>       if (ret) {
>           error_report("%s: cannot disable RAM discard", __func__);

It looks good.

> Thanks!
> 
> Paolo


