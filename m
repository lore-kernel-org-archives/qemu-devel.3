Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D29CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEh-0008HI-MA; Thu, 28 Aug 2025 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1urdvx-0004No-5L
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:49:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1urdvs-0001hv-IU
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:48:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b4d892175so6650685e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392532; x=1756997332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20rhRhSoCiq08+MNEHWT6JrwnW53MD1cP6RaKUG734A=;
 b=gij/tyVJifwGUUE8c+nd6ZAdF02zbFUf9MTzU9hT4+EkVK9Tq7EB3P92TsFDA0caCg
 TdAkgeNVayRZA+ZLDU4l3cRrLZIPuzceL6fTAH/FMCI9HG48PzTy1R9Ih+B+KEBslihg
 DhfGtsmqkO9C26Sz6q6sIFxN5lVoVRZxsHw51diu8s1vJ5sy399BDJiZB6h0ldY7fe1D
 0uAAC+sDlrnc5C8umTrqk5VwZECP0aA+PHhq80esskcUpQKWoU5FnQ8ONICpid192VSo
 b1yQBjrGwsDE/wI+Vfhdri2Pve9zBGDg78SBPJLcMBfnC6x7leyYKanaRVK6wbMRMnwI
 l10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392532; x=1756997332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20rhRhSoCiq08+MNEHWT6JrwnW53MD1cP6RaKUG734A=;
 b=UBGQeylvmwkRDRKFtFybbEP9MiFJdNgN4PUaj+2iSyLeNSvliUS1h86rw6ZM11PJUO
 d5f+leKuCTpcvJi4qgq90lDOWxdeI7uCFxj7NERAHw5DNq2UN2ilcurykhE/l3Iln7st
 V4ht2XkjeA9dKLpUd/SBMzb5aVuJMgq0ME2WY7ynBmshi597zEwVjJ2Ka5A6hKzSy/62
 v/kPM9QKzBMi6r1eUGbo1zeDfHH3qapMFcXefwGC1jj4KI8mCC1aEvrZ8GMSXNG/sy8B
 0PlOMYeNdaT25Up/VHYJO9jwcuBUCpiHfbPRYl6cjGwZpjaQlAc9ar9/X5vEkL3Z/Mwk
 kN3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtZPXHfTRK9xlQ+rLq/qY2FRzJbCdw+0c1yJkBsXSOFi0aSEV4sAccaC/etFKoFwRO17RmiaS9fC6k@nongnu.org
X-Gm-Message-State: AOJu0Ywser8wHWAa56UEAC1NOiZNBn0s5acbpugFOwFPBBvdwOT/UYEw
 YLhS5d1iSLqcXixx/tm+SMTkgSaGfxsSWRrBvT0i+k8iGZQrJS3GwDjy/+TU9zppzCI=
X-Gm-Gg: ASbGncuBA2Ega797G4ANRyERgJ00pUBzxlajx0WSWqil/kIg/KL9yn3CRTn3o2Aq357
 nVz0b1hYrLQJAyxl7onVHvMgXTBiopS0xvriEGv+4BQATZKGXWNrid2OHhjXnNJEilDqGb9YQju
 XFCHL2ezXVFqSPCJr59yAzEvVDuGz3CIELCQrerwHlWT15R4xcVb6mkzYk8HO3I8B0S8DEuzk19
 oJ1c9MuYVMIn5dcgmG+g9k9+9Sa4oNkSZnmvSWXumjr24XjRbGy8PQllJ8M7h9MIeS6k1eNT+C+
 uz8AkI7Erit3py/tNjOdCEGbpPgAiVi1Uezg1qGNUn4zggZMkejZgGkkSMhHcXA3aFe1sZclJWF
 dQ6hGGJAZMe8lZjqN3CFM37rVlK8hN2qvJLUITJoGlZECSv78DqlDYpdebyp+ET/qjGqKf7K97N
 6lzx/ZRNbvmSw9cK+YWBo1aFqilMIeQDewuP81PSbNvppuOsKHZONQpPX9+NfWi5ZMSdUPS9om0
 6Iu
X-Google-Smtp-Source: AGHT+IE8pe3cBB23s7tvDc2YMVQTUYgPcgRXpRtS3nilMPGrpwaJPJmJvTp4kImNXK3QpuAf56lkYA==
X-Received: by 2002:a05:6000:1acf:b0:3c8:c89d:6b5b with SMTP id
 ffacd0b85a97d-3c8c89d6f7dmr12451511f8f.48.1756392532177; 
 Thu, 28 Aug 2025 07:48:52 -0700 (PDT)
Received: from ?IPV6:2a01:cb09:d021:8fd6:94b3:f1b:6ece:2fef?
 (2a01cb09d0218fd694b30f1b6ece2fef.ipv6.abo.wanadoo.fr.
 [2a01:cb09:d021:8fd6:94b3:f1b:6ece:2fef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797d1a67sm40618515e9.15.2025.08.28.07.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 07:48:51 -0700 (PDT)
Message-ID: <76ee9b6c-1bbd-4a77-8b00-bdfda7dbf870@linaro.org>
Date: Thu, 28 Aug 2025 16:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
 <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
 <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
 <e946e0f7-cc9f-40fa-bd41-3044510ce261@linux.ibm.com>
 <cee8e481-8cfa-a86c-bca6-10ac3fbcffb6@eik.bme.hu>
 <9b0253e4-a906-4be4-ab46-df41bea0f054@linux.ibm.com>
 <62de0cb3-c4de-fc5a-e770-1bebb4423628@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <62de0cb3-c4de-fc5a-e770-1bebb4423628@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025-08-26 14:12, BALATON Zoltan wrote:
> On Tue, 26 Aug 2025, Harsh Prateek Bora wrote:
>> On 8/25/25 20:03, BALATON Zoltan wrote:
>>> On Mon, 25 Aug 2025, Harsh Prateek Bora wrote:
>>>> On 8/25/25 17:52, Thomas Huth wrote:
>>>>> On 25/08/2025 14.08, Harsh Prateek Bora wrote:
>>>>>> On 8/25/25 17:28, Thomas Huth wrote:
>>>>>>> As I said, qemu-system-ppc64 is currently a full superset of
>>>>>>> qemu-system- ppc. The ppc64 binary contains all the 32-bit code, you
>>>>>>> can perfectly run a "g3beige" or "bamboo" machine with
>>>>>>> qemu-system-ppc64, too. By disabling the ppe42 code in the ppc64
>>>>>>> binary, this would now introduce an execption to that unwritten rule,
>>>>>>> so I'd expect that we'd not rather want to do this now.
>>>>>>
>>>>>> My understanding is that above holds true only for default builds which
>>>>>> builds all targets. We certainly do not build 32 bit ppc code when using
>>>>>> --configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 bit
>>>>>> though)
>>>
>>> We do build 32-bit machines in ppc64-softmmu but leave out 64-bit from
>>> ppc-softmmu so it's only one way.
>>>
>>>>> Just give it a try:
>>>>>
>>>>>    ./configure --target-list=ppc64-softmmu --disable-docs
>>>>>    make -j$(nproc)
>>>>>    ./qemu-system-ppc64 -M g3beige
>>>>>
>>>>> ... works perfectly fine for me.
>>>>>
>>>> This would work because the respective code is not restricted with #ifndef
>>>> TARGET_PPC64.
>>>>
>>>> However, there are instance like below in hw/ppc/mac_oldworld.c:
>>>>
>>>> static void heathrow_class_init(ObjectClass *oc, const void *data)
>>>> {
>>>>     MachineClass *mc = MACHINE_CLASS(oc);
>>>>     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
>>>>
>>>>     mc->desc = "Heathrow based PowerMac";
>>>>     mc->init = ppc_heathrow_init;
>>>>     mc->block_default_type = IF_IDE;
>>>>     /* SMP is not supported currently */
>>>>     mc->max_cpus = 1;
>>>> #ifndef TARGET_PPC64
>>>>     mc->is_default = true;
>>>> #endif
>>>
>>> This is only because the default machine for ppc64-softmmu is different
>>> than for ppc-softmmu as the 64-bit machines don't exist in ppc-softmmu but
>>> ppc64-softmmu had different default machine before machines from
>>> qemu-system-ppc got included in qemu-system-ppc64 so it kept that. (Looks
>>> like the default used to be mac_newworld before commit 159f8286b760dea but
>>> wasn't changed to match but to something else.) The default machines are
>>> arbitrary, we could make "none" the default and always require users to
>>> supply -machine but that would break existing command lines so this wasn't
>>> done.
>>>
>>>> Similarly, we have multiple instances with #else block for #ifdef
>>>> TARGET_PPC64 which doesnt get compiled with ppc64-softmmu, but only with
>>>> ppc-softmmu meant for 32-bit targets. See target/ppc/excp_helper.c for
>>>> example.
>>>
>>> This is again leaving out 64-bit code from ppc-softmmu but as Thomas says
>>> 32-bit machines are always included in qemu-softmmu-ppc64. I can't find the
>>> commit which changed this, previously we had these to be separate and since
>>> some types are different in ppc64-softmmu it wasn't clear if that could
>>> cause any problems for 32-bit CPUs and machines so ppc-softmmu was kept
>>> until that's cleaned up which never happened. There are also some
>>> pecularities in some machines like mac_newworld that behaves differently in
>>> qemu-system-ppc and qemu-system-ppc64 and the potentially lower performance
>>> of qemu-system-ppc64 in emulating 32-bit machines which is why we still
>>> have ppc-softmmu.
>>>
>>
>> Ok, I see. So, if we wish to keep the 32-bit machines supported with
>> qemu-system-ppc64, we will have them co-exist with run-time checks for !ppc64
>> and/or "unlikely" operations in the hot path routines, which wouldnt be
>> needed otherwise. I hope we can deal with run-time checks for !ppc64 if such
>> ops increase.
> 
> I guess this will only get worse with the single binary that will also add
> if target == checks and removes some of the optimisations that assumed
> endianness and word size. It would be good if somebody could do some tests
> to check performance issues which could be made part of the test suite so
> we at least notice these changes. I'm not sure what would be a good set of
> benchmarks, I've used STREAM to check memory access and exceptions/MMU and
> lame some.waw some.mp3 to check FPU and vector instructions speed before
> but maybe there are better tools.
> 
> I've also tried adding function pointers to CPU class for different
> exception models to remove the switch from the beginning of excp handling
> functions that call out to PPC64 specific versions but I found that to be
> slower than the current switch at least on x86_64 host.
>

Having performance tests would be a great addition to the QEMU test 
suite, whether it's for the single binary or any other change.

Concerning the single binary, we have no plan to modify ppc target code 
for now. As well, most of other architecture already handle 32 vs 64bits 
and endianness with runtime paths, and it has not been a problem so far.

I still think it's better to write proper code and eventually optimize 
parts identified by proper profiling. But impacting architecture and use 
preprocessor heavily before any proof that is needed has been found is 
premature optimization IMHO.

Regards,
Pierrick

