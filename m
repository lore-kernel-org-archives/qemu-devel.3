Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A8606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W+jyeFp9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQr3j-0000zL-3v; Tue, 10 Nov 2026 13:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1xQr3g-0000z2-Ka
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1xQr3e-0006X0-PH
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794337141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlKyGDNFRRRZeLD1H+tAlDyIS2cpLbINa5wk2zLoKXo=;
 b=W+jyeFp9KPEFeO1SS6/aD7EYF/czYG0JcWgAXWB5ZocbDE5DSBWC/wt+Cjjj02vZk75qoZ
 wErh3Rxk+62mdC/91/1YmQbnhR0jcGMOfm138vE78ycuR0PYOsKRBaVAxciKdc2CFG0gSq
 MWeu2tDmOz00C2soiNRixCd8BfYujwk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-HuHUPwHtPvOpMdkdJ1t2Ug-1; Tue,
 10 Nov 2026 13:57:41 -0500
X-MC-Unique: HuHUPwHtPvOpMdkdJ1t2Ug-1
X-Mimecast-MFC-AGG-ID: HuHUPwHtPvOpMdkdJ1t2Ug_1794337058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E003C180133D; Tue, 10 Nov 2026 18:57:36 +0000 (UTC)
Received: from [100.91.40.236] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E3CA19634EE; Tue, 10 Nov 2026 18:57:31 +0000 (UTC)
Message-ID: <6e957095-2a66-4441-88c2-8027c4a99c26@redhat.com>
Date: Tue, 10 Nov 2026 13:57:31 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Dongli Zhang <dongli.zhang@oracle.com>,
 Sandipan Das <sandipan.das@amd.com>, zhao1.liu@intel.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
 <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
 <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
 <84b5b038-e32f-4765-9d23-9f6ecbf382c0@amd.com>
 <d0a22994-1a01-44c6-8a79-12470ee8dcd4@oracle.com>
Content-Language: en-US
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <d0a22994-1a01-44c6-8a79-12470ee8dcd4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/6/26 8:51 PM, Dongli Zhang wrote:
> 
> 
> On Tue, Oct 6, 2026 1:41:05AM -0700, Sandipan Das wrote:
>> On 01-10-2026 16: 42, Sandipan Das wrote: > On 01-10-2026 16: 35, Michael
>> Tokarev wrote: >> On 10/1/26 13: 43, Sandipan Das wrote: >>> On 01-10-2026 15: 
>> 30, Michael Tokarev wrote: >>>> On 10/1/26 11: 54, Sandipan Das
>>
>> On 01-10-2026 16:42, Sandipan Das wrote:
>>> On 01-10-2026 16:35, Michael Tokarev wrote:
>>>> On 10/1/26 13:43, Sandipan Das wrote:
>>>>> On 01-10-2026 15:30, Michael Tokarev wrote:
>>>>>> On 10/1/26 11:54, Sandipan Das wrote:
>>>>>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>>>>>> ...
>>>>>>
>>>>>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>>>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>>>>>> it starts showing up the rotating circle (which shows boot progress).
>>>>>>
>>>>>>
>>>>>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>>>>>
>>>>>> With that, it boots fine, just like before this patch.
>>>>>> I checked current master too - same, +pmu fixes it.
>>>>>>
>>>>> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
>>>>> it. Linux runs a basic sanity test to determine this. See:
>>>>> https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/
>> x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!
>> PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$ <https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$>
>>>>
>>>> So.. what do we do with all this?  :)
>>>>
>>>> I kinda see the intention of the original change, but it results in
>>>> non-bootable systems (linux too, as I think you demonstrate above).
>>>>
>>>
>>> Because of the sanity test, Linux will boot but not register the "cpu" PMU.
>>> Perhaps others should also run a similar sanity test on PMU hardware rather
>>> than making assumptions and failing to boot.
>>
>> After looking at kvm_msr and kvm_cpuid traces, I see that Windows is indeed
>> getting #GPs upon accessing MSRs 0xc0010200 and 0xc0010201 but it is not at
>> fault here since it expects these MSRs to be available as guest CPUID
>> 0x80000001[ECX].PerfCtrExtCore is set. This feature bit should have been
>> cleared by QEMU when "pmu=off".
>>
>> It boots up when "pmu=off" is combined with "perfctr-core=off" and
>> "perfmon-v2=off". The missing pieces here are the following:
>>
>> https://lore.kernel.org/qemu-devel/20251111061532.36702-2-dongli.zhang@oracle.com/
>> https://lore.kernel.org/qemu-devel/20251111061532.36702-3-dongli.zhang@oracle.com/
>>
>> Dongli, Zhao,
>>
>> I see a discussion about compat array at
>> https://lore.kernel.org/qemu-devel/aUEXkDDOba+oZ4v+@intel.com/
>>
>> Is this ready for the two patches above to be pulled in?
>>
> 
> Thanks Sandipan for analyzing the issue!
> 
> Hi Zhao,
> 
> I noticed that the machine compat arrays are now available. Would you be able to
> send updated versions of patches 1 and 2 with the compatibility property you
> suggested?
> 

Are there any patches to test here? I'm seeing this on two different AMD
machines with libvirt cpu mode='host-model' and win11/win2022+, bisected
on fedora-45 to this exact commit. Machines are 10 years apart too so
very different vintage. host-passthrough (-cpu host) seems to work. But
virt-v2v spits out host-model by default so for me personally this is
causing some testing pain.

- Cole


