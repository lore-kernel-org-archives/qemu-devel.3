Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5119FCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6v3D-0002HI-Tm; Thu, 09 Oct 2025 14:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6v3C-0002Gt-3u
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:07:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6v32-0000MF-6N
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:07:37 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b554bb615dcso822164a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760033241; x=1760638041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OEaeQKPIB7FV/TcqxYbuUO3MTeQ9nNgkw+rNGbqxasw=;
 b=ywBEaMh5MTfqBflv2fhHqoCnjYESQ/5wFVZ31wDoE+64fljHOe2lbuQ210Obw9hGin
 KScGz8UIL92MGst93F41LgCidZJHbmKy5niiywSjwYXxPOm8SAUTbqk6qliCRGo2FveJ
 fB9lR5D7OW8S2JtiHl40kPcCPcnY4VEQF9ZCwGD5Q3s91SC4eW5W8brEQY89bvdgSYjl
 jRJifiTdz7QS9mwzNftZci9ec4WPCe1/k3CSgLAekt0Zs+/uBPuUYoo+pEsC1KDn1djI
 OVNp1pVsbhH6n0YeowPp4ECozVZ8xQVbBVYr7zoEQ8a1O9I+nEHkBUiWXz4ajti2CJl3
 2Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760033241; x=1760638041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OEaeQKPIB7FV/TcqxYbuUO3MTeQ9nNgkw+rNGbqxasw=;
 b=UP/y8MMihKZLncqINNB/Hc5x8AxPSC3ZTCBfLv1dPt7ofabgA/l44QrCrNpCX5e2XR
 bZn4tFemGAFnePky6CE3et84N6WkwfMlDwniGZ0L5xoVl+azRL93vqq1mYK7aNWC2pC5
 pQskjNaDpTgPzAe2T7WC0wn+UQwWH+VFAUR8hiqObXJW9gqJKBXF4Yg0N6XchOok35e+
 2XszPfAaR9WVwxi/HSozyBefms9k0eqfT/yheQ/gjCOB7USoOLUO8Wee5raJNMzSVZQF
 vIxrX/mU41PyBSSUjCaY9JkfONWhxc7xcoEpcOU9DuAU9WB0tQfTQ6UXeLdSZCVG2tCj
 Pa5A==
X-Gm-Message-State: AOJu0Yxj4EC1bqjM/qidI+Acy835Q1hVCkA2QJ18MjABpj6xb1hZ0JLd
 fLKD9tPTL18K3BTA3bNIEJDs0UBP7EV8L9W2XklvkrBTfgbP6RvMN/h5gkH7OFkzYVI=
X-Gm-Gg: ASbGncv3okUdeZRwpWxE3rUh3ns7GADJxL290ip6pWfute8l5PA5pG09TvWlUqSEa97
 M1tpins20UF6k/5+/0/387Qmxs8RGJZ5bdYQ1WrqLjq4fUZIGmDE0cEtOKvICI1HFChjixsHvQd
 CdPMAJ9y+hJMEyTLwwOEP0XJUkBL2T572gMowxcARRUBQ3Py6IDhiFhWMtFM7bkr6jNF6FFVwaP
 tTaAtRqcoPJr1qga0Vtdxkw/tzGDdNy2FuSNZ8WK7gPKM8dWWwg1vfyD+xZR1bXiMR8CnqmWbnG
 6ROvAjAOsROOZIiqFQpbYLQRFRGrTA+94ofI4kh4HChn3yh9+4M0VEYXI8DJowfHPiOP9ed2zlC
 pQqDkYJBLCUCjexBlmD2/x+aCBAjjg1/kYgD5FbgDRdXd0+1MHNQ4HcZvIK7rhPE=
X-Google-Smtp-Source: AGHT+IHVlCDhBPdlZeo/pmPsdy+LWfunvstEDSM/Rs9kyVTRudRvWdnxZm7bcO4cPBCmvSk/6omUug==
X-Received: by 2002:a17:903:120c:b0:26c:4085:e3f5 with SMTP id
 d9443c01a7336-29027391377mr103344525ad.50.1760033241353; 
 Thu, 09 Oct 2025 11:07:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm34695995ad.126.2025.10.09.11.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 11:07:20 -0700 (PDT)
Message-ID: <0138de27-04af-4ec6-83bd-db917f867aa5@linaro.org>
Date: Thu, 9 Oct 2025 11:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MMIO through IOMMU from a TCG processor
Content-Language: en-US
To: Mark Burton <quic_mburton@quicinc.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, peterx@redhat.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com,
 alejandro.j.jimenez@oracle.com, peter.maydell@linaro.org,
 jasowang@redhat.com, pbonzini@redhat.com, tjeznach@rivosinc.com,
 steven.sistare@oracle.com, clement.mathieu--drif@eviden.com,
 joao.m.martins@oracle.com, ean-philippe@linaro.org,
 jean-philippe@linaro.org, sarunkod@amd.com,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <1C343F6E-05E2-4EA0-A338-0C48A97FF263@quicinc.com>
 <db2ca904-5d1c-4c96-8950-d3d943940d64@nutanix.com>
 <D7DA7B85-2439-4CC2-A852-604154ABDC99@quicinc.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <D7DA7B85-2439-4CC2-A852-604154ABDC99@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Mark,

"recorded section therefore seems to be incorrect".
do you observe a crash, or on assert failing at execution?

I don't know in details the code you mention, but after investigating 
and fixing https://gitlab.com/qemu-project/qemu/-/issues/3040, I can 
share a few things.

Overall, what you describe looks like a race condition exposing a 
lifetime issue, especially when saying "we 'loose' the address space 
that has been returned by the translate function".
A value was not updated as expected and is out of sync, or was freed too 
early. Memory regions lifetime is something definitely tricky in QEMU, 
and when you mix that with RCU, things can become very obscure in 
multithreaded scenarios.

In the bug above, the solution was to stop duplicating this information, 
and get it from the same source. The overhead to read such atomic data 
is quite small, thanks to use of RCU.
At KVM Forum, Paolo told me he introduced this copy precisely to avoid 
issues, but the opposite happened in reality, which we both found was 
quite funny.

Additional questions:
- At which time of execution does it happen? Is it during pci devices 
initialization, or when remapping specific memory sections?
- Is the bug deterministic or random? If random, does increasing the 
number of pci devices attached increase the probably to meet it?

Additional tools:
- If you observe a crash, build with asan. If you get a use-after-free 
error, it's probably an issue with RCU cleaning up things before you 
expect. This is what I had in the bug mentioned above.
- If your assert fail, I can recommend you capture execution through rr 
(https://github.com/rr-debugger/rr), using chaos mode rr record --chaos, 
which will randomize scheduling of threads. I don't know if you're 
familiar with it, but it allows you to debug your execution "backward".
Once you captured the faulty execution, you can reach the crash or 
faulty assert, then execute backward (reverse-continue) with a 
watchpoint set on the (correct) value that was updated meanwhile. This 
way, you'll find which sequence led to desynchronization, and then 
you'll have a good start to deduce what the root cause is.
- Spend some time making the crash/assert almost deterministic, it will 
save you time later, especially when implementing a possible fix and 
prove it works.

I hope it helps.

Regards,
Pierrick

On 10/9/25 2:10 AM, Mark Burton wrote:
> 
> (Adding Pierrick)
> Thanks for getting back to me Mark.
> 
> I initially thought the same, and I think I have seen that issue, I have also taken that patch, However …..
> 
> For MMIO access, as best I can tell, the initial calculation of the despatch is based on the iotlb reported by the translate function (correct), while the subsequent use of the section number uses the dispatch table from the CPU’s address space….. which gives you the wrong section.
> 
> I would very happily do a live debug with you (or anybody) if it would help… I’m more than willing to believe I’ve made a mistake, but I just don’t see how it’s supposed to work.
> 
> I have been looking at solutions, and right now, I don’t see anything obvious. As best I can tell, we “loose” the address space that has been returned by the translate function - so, either we would need a way to hold onto that, or, we would have to re-call the function, or….
> All of those options look really really nasty to me.
> 
> The issue is going to be systems where SMMU’s are used all over the place, specifically, in front of MMIO. (Memory works OK because we get the memory pointer itself, all is fine, the issue seems only be with MMIO accesses through IOMMU regions).
> 
> Cheers
> Mark.
> 
> 
>> On 9 Oct 2025, at 10:43, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
>>
>> On 08/10/2025 13:38, Mark Burton wrote:
>>
>>> All, sorry for the wide CC, I’m trying to find somebody who understands this corder of the code…. This is perhaps a obscure, but I think it should work.
>>> I am trying to access an MMIO region through an IOMMU, from TCG.
>>> The IOMMU translation has provided an address space that is different from the CPU’s own address space.
>>> In address_space_translate_for_iotlb the section is calculated using the address space provide by the IOMMU translation.
>>>> d = flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
>>>>
>>> Later, we come to do the actual access (via e.g. do_st_mmio_leN), and at this point we pick up the cpu’s address spaces in iotlb_to_section, which is different, and the recorded section therefore seems to be incorrect.
>>>> CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
>>>> AddressSpaceDispatch *d = cpuas->memory_dispatch;
>>>> int section_index = index & ~TARGET_PAGE_MASK;
>>>> MemoryRegionSection *ret;
>>>>
>>>> assert(section_index < d->map.sections_nb);
>>>> ret = d->map.sections + section_index;
>>> What I don’t fully understand is how this is supposed to work….?
>>> Have I missed something obvious?
>>> Cheers
>>> Mark.
>>
>> What version of QEMU are you using? I'm wondering if you're getting caught out by a variant of this: https://gitlab.com/qemu-project/qemu/-/issues/3040.
>>
>>
>> ATB,
>>
>> Mark.
>>
> 


