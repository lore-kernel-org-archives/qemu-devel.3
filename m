Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38917C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHud-0000Kt-Kl; Thu, 20 Mar 2025 11:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHuU-0000K5-D1
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:34:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvHuO-0002gj-8K
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:34:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2255003f4c6so18956645ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742484849; x=1743089649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xjALbgMqNqih695YBi5zBDkSlE/JueqZNLrq8m4qqg8=;
 b=wF+5fB/aZ5BPZQVO4MIqo4SItWCZQmnDnaqj1p2/KiOsrvy6cN79yPE3D+Ugs+/TEc
 IFmpEWuO4pmCDVj2DZNa1agC6wypEBjCI7g+Vds8AyjkKM/A7Xe4jmlULLAzA6kpTZ60
 9OLIuikp+KKPS5zU9hLuz+zmH8AeV4ordbnLg6Yy/dhYJb/gGHvyrG3Ph+x5W9Qg8lRL
 p82AXDFnQo46RAmwSp+Pa19kUsl/SXN03cdIWn63SFpRveKSw+kf4ORiuoqEgvbzigZ1
 2UBOYJj/Q0WLLa0Iy2haHwr9iJ8DVbQno4PCnCPP4QI3T1yjtDp14d5QcxawMj2bAMG/
 OGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742484849; x=1743089649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xjALbgMqNqih695YBi5zBDkSlE/JueqZNLrq8m4qqg8=;
 b=SwCjd2smmOEI2gF/g9vw2JI32NzN+Q710aRU/0Ms77ugptaHedc7Hc4EvZk90d33Ld
 lxKdaukI1L5BzsH01nbHKZ2ocE+mrL1vSKapmQ+E+rAc1ukFictkx0CvOeakeRYVOTw8
 4Tx1GUXtmwLdxAH67leYG0CMjf2WYKamTwEAwbLdjbLy7CfaZp/G2WshKM5Bvs62mL8/
 TO5ugKhSM4Qlau7gHGhyqFGeWBntvAKf4BW7lYZ4/tnfOqcOXdGZGIzgbrSewtmzK+74
 Di+RpYq9CxpXftFAIikmrDVjqIogPBaWdMUJpWgaElK+xp9kyNdf0tjEcDuCbEFNOMFK
 XjRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfK9mmsnSWZ9AvugZQLToK65t4mAzhQ4UB0t4Gyg+TFwpO07eh1ALtJJYwPF+Mm/23OWEhoaAG02C1@nongnu.org
X-Gm-Message-State: AOJu0YzK+U7SgapG3Pe2+M0Ydr+92uG/NrpEmrXsUKGhUBxMIVWUWAI9
 IxN3IVO2V15CnWuGZV5kc8F2oUZa0tTTWaVf4exlzBQvgUvcy+KxsW0vHlPL/q4=
X-Gm-Gg: ASbGncswB2v4W95V/lGFsL1gqJP73ulBJvvg0Uttrd1eAQgyqu49UX6jb60OHBJ9u64
 PUp4Sl9DFiH+R74UfjxCmPhCs1krAXqGqV4CI8fQXf4pFLEFMRjw441o5QPdqb/wbrDOYqhrTL5
 cYp1Ul3wIaggXLnyic+Z61jj8E6I9ZapxEQX7A3Wy7DorRh1iGuBiV99LOh0rOBKuSCY7RDZ/5v
 X7pZ7H+JL37Hj1VRNxptOlU/E3LlkD/+JaI6RxRSaIqdAyVK2ApEXVBVso6oIubEwVrT86oxKH5
 gxEO0jwaeiNVl/LLJLOixw0qQgQpvQ8LlIKZk1bMaV62Zm2o+z8RwbMMUZNQrazE
X-Google-Smtp-Source: AGHT+IGsasqzsv6uFEn73fkHKiEjjEPmBBKivd9TSeAfGviCLzroYHedxKe9ygJcRI4ha+nbIt/pOw==
X-Received: by 2002:a05:6a00:3d02:b0:736:ba49:97bb with SMTP id
 d2e1a72fcca58-7376d5ea36bmr8630600b3a.5.1742484849146; 
 Thu, 20 Mar 2025 08:34:09 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711559fb2sm14420165b3a.61.2025.03.20.08.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 08:34:08 -0700 (PDT)
Message-ID: <52a6fd90-bce7-47fd-bb93-aa88f8f3bb82@linaro.org>
Date: Thu, 20 Mar 2025 08:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: Sid Manning <sidneym@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 =?UTF-8?Q?=27Philippe_Mathieu-Daud=C3=A9=27?= <philmd@linaro.org>,
 'Brian Cain' <brian.cain@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "Mark Burton (QUIC)" <quic_mburton@quicinc.com>,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
 <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
 <008601db9448$601bc370$20534a50$@gmail.com>
 <e1216ec5-c542-4a7d-a3d7-880e7e57130e@linaro.org>
 <IA0PR02MB94864DC1BE7E60105E66EC09BED92@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <IA0PR02MB94864DC1BE7E60105E66EC09BED92@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/19/25 09:08, Sid Manning wrote:
> 
> 
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Sent: Thursday, March 13, 2025 2:07 PM
>> To: ltaylorsimpson@gmail.com; 'Philippe Mathieu-Daudé'
>> <philmd@linaro.org>; 'Brian Cain' <brian.cain@oss.qualcomm.com>; qemu-
>> devel@nongnu.org
>> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>;
>> ale@rev.ng; anjo@rev.ng; Marco Liebel (QUIC)
>> <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark Burton (QUIC)
>> <quic_mburton@quicinc.com>; Sid Manning <sidneym@quicinc.com>; Brian
>> Cain <bcain@quicinc.com>
>> Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>>
>> On 3/13/25 11:47, ltaylorsimpson@gmail.com wrote:
>>> What we are trying to model is an instance of a Hexagon that has a number
>> of threads and some resources that are shared.  The shared resources
>> include the TLB and global S registers.  The initial thought was to tie the
>> shared resources to the thread with cpu_index == 0.  If we were to model a
>> Qualcomm SoC, there would be multiple ARM cores and multiple Hexagon
>> instances.  Each Hexagon instance would have distinct shared resources.  So,
>> you are correct that using cpu_index is not going to scale.
>>>
>>> What is the recommended way to model this?  I see a "nr_threads" field in
>> CPUCore but no clear way to find the threads.  PPC has some cores that add a
>> "threads" field.  Should we follow this approach?
>>
>> I recommend that the shared resources be modeled as a separate Object,
>> which is linked via object_property_add_link to all of the cpus that use it.
>>
> [Sid Manning]
> Hi Richard,
> An example of shared resources would be the system registers.  They are broken down into 2 regions.  Each thread has its own copy of system registers 0-15 while registers 16-63 are global.  Right now CPUHexagonState contains a pointer, g_sreg which points back to cpu[0]'s state thus keeping one copy of the global registers, accesses are done with BQL held to avoid race conditions.
> 
> Your suggestion is to create a new object to represent the set of global system registers, I tried this:
> 
> #define TYPE_HEXAGON_G_SREG "hexagon.global_sreg"
> OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalSREGState, HEXAGON_G_SREG)
> struct HexagonGlobalSREGState {
>      SysBusDevice parent_obj;

SysBusDevice is more than you need -- Object is sufficient here.

>      uint32_t regs[64];
> };
> 
> In our virtual machine init:
> vms->g_sreg = HEXAGON_G_SREG(qdev_new(TYPE_HEXAGON_G_SREG));
> 
> and
>   object_property_set_link(OBJECT(cpu), "global-sreg", OBJECT(vms->g_sreg), &error_abort);
> 
> to attach the global regs to the cpu, but the above doesn't update cpu elements the same way calls to qdev_prop_set_uint32 will do, object_property_set_link doesn’t error out and returns true. 

Did you add the DEFINE_PROP_LINK to match?  I'd expect something like

     DEFINE_PROP_LINK("global-sreg", HexagonCPU, g_sreg,
                      TYPE_HEXAGON_G_SREG, HexagonGlobalSREGState *),

Beyond that, I guess I'd have to see an actual patch to work out what's wrong.


r~

