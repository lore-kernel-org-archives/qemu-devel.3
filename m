Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36538C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rR5-0005ME-Pv; Thu, 24 Sep 2026 17:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9rQz-0005Kh-NQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:56:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9rQx-0002Nt-CB
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:56:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdkV73462587
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4kmnfe3P100RHu2gPQL9ZkdP0EQjTf58B2qp/c+5T1k=; b=LUmk3Hp32xBWseUS
 yVIDqqohcPFrFuUh/r8h3+dQ2LeIcjlwfid4XHEfCiXoXMTblSg6pC7xjtC0fy3r
 xdGN4z2Qse1ly9NsEulqSxgKAcMy7hxAYerBhim5QaEnBDj447qD5fdi4vp6jcnz
 ogD/qpGvUNq341lv9HVggTPZvaP3J8aWw2vNJ1T7ZdrGnfYKs6sxpi9LHLASoQ9s
 FD2UI9SVV8VJrcC97ZIzHI9A6J41dffEZqG42eQUqWdoEgU5vL44P/2mWBL9/FIm
 8WrkQVDlYMhphZ0KfISKTLmWJcv1R09Z0oAMiEQGh2aWU3994y7BxZLBlKXDCSVg
 /svp1g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjjtvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:56:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7f98bcb9so5388256d6.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790287006; x=1790891806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4kmnfe3P100RHu2gPQL9ZkdP0EQjTf58B2qp/c+5T1k=;
 b=Q2+3qwHeLDGbnA5rp6aHU5c7pUL8XK+Xjefq8zNIriHZVdBGZqc21+HmsM8GtMjdFi
 h2YFxo3zd018A8/3qpuJkkl3z7poGXS85uzT8pRZ84aBZgCa4np9Biqs7FKQUfUhCz7z
 Vc5Ruvtmyo2H0E9yVZ/gHR1/T5nP3ZlhtvhQG9g4qa2K0d2iS9OvDFMJQrtCNbmr1tFo
 ELsEVSlw3pld0uEg4fXJr7tTdWdk1HIN9e7WyWCX055HgvD/OJRo4dafKDXHz0n+Do6C
 cD3kHkMRjsd2mVZ59zxV0ZFgxwIJs0ZM/X4kZoCOQAWIB1E07JdWXBo7l1F1GC6lbX0r
 80fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790287006; x=1790891806;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4kmnfe3P100RHu2gPQL9ZkdP0EQjTf58B2qp/c+5T1k=;
 b=RxuYWk/4auh3gaeoSbRKQ5vB/wwdzCf6WrHEthNQSWHKuj/YJKIn36yVN96dpTev+m
 6OTW9Z7WGqyJI8aFiNIzf+XOV89Ibo7K5QVHcktRgAJf/ljYjFGvEPIs29p1oYCEevqg
 2IE7G3YyKb6iCWJe/6AZU2vogc2NCOQamilz5uBO0o2b6AC7UgRtYehjHb32BMKeNwpa
 1PyXmTC/XTpZIIWVYXGxHPlZDFrb+0dNOtEJrWFAaHaIgE82Xg6yIG4sUlw2K7yIPH4M
 4euSkWl6J+IVBVRCPsKOH5HhnqnJouGeEaBLkr2D5yZxwPEEIPbGAfsXSyiD7aobUCmp
 x+1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRvEKTbdd+6rrcm1PkGQyYQwSbApZln/hzQy0CZUfklmHyAqepjzGGBrdTlCLyUN0/1vu2TI1snc0m@nongnu.org
X-Gm-Message-State: AFuF++kJB8HJW7JdIJFQGlY20BHFuCcBsJ98Yz4xYUvHuo0n8PB8W04r
 16fNHmxqP2z00fjEJGfeYwNBnMJ/iwjiPhhC1Y018dXH0mMvWm9ySoS7S3ixm5h5XLLLgSXA62w
 1+EsOiT1qcf+0aXI6nDpii7lpVumI48ANNe5Epa8Cz1uZcrkj4fW7wHIUOQ==
X-Gm-Gg: AYBFou22wjVnv4ZcUHL/XFHAROEZB+i/7nT0+3yDK0ZtNTX+2eQhgjEXBETj2AxhWK2
 4G6pBJGm9CR9ZeGOYzEyiY4RsgaYgoazh67oc6GUiBzwFMIPekJEZVXpjpjYk6f4/MYXYkC4LHY
 Sh4xVWVjZIPLiCIL91lwCH+/bJH2bjyo1WXTxlTJcO7Gw0DPDEwPUUEIF9n+ATRROJNp1f9WIMx
 1zMxvDrccwxuWHhAVKUtMJaPJmL2krJgnCPcq9mIYbTM3A2Y+7VFaKLOttKq6spgeo/2H5DEOf1
 RKbh7ECvDTqoYCt49Mlbfd0iruzt+W9nW/gi6dmZocyClgAH5kG/+93pqxqUT/iBvRzRYcWHHia
 V9kDNlQPReY9IyGWzn7oCfHuQJx852lx57bMEMrUzsPReORJ7Vqi+MAiSFEDmnRJW
X-Received: by 2002:a05:6214:4a07:b0:912:517b:84a with SMTP id
 6a1803df08f44-9142f969b90mr12599606d6.46.1790287006092; 
 Thu, 24 Sep 2026 14:56:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4a07:b0:912:517b:84a with SMTP id
 6a1803df08f44-9142f969b90mr12599306d6.46.1790287005523; 
 Thu, 24 Sep 2026 14:56:45 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430da85f3sm3206736d6.10.2026.09.24.14.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 14:56:44 -0700 (PDT)
Message-ID: <52d8722c-9f7a-4ff9-9e65-39d32ee589f1@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 16:56:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] target/hexagon: share HVX contexts among CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
 <20260923171516.3794996-7-brian.cain@oss.qualcomm.com>
 <b4ff3bec-258b-4989-adb6-34a18f5ab8fb@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <b4ff3bec-258b-4989-adb6-34a18f5ab8fb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: guIzKW1ik_mvSkA8lUJzj5C8wq5gMKHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX3aVFVU67UYR8
 WztDjgpeKyH2mbyO27GFToi1n+I/ZzJquEihyKEIj2lsO5JEpGJA1Ev9bCMJqIRvx3xlvtuRVJH
 9+00XUY5gniwHj4aot3ljkx8RkseTbUb2JDp6SA33rZABGN106zZ4ooUhAleEcLVucOET4/UpL9
 Rx74JoU/6dyseOfjdcYwUqhinRdfzBjNT1BQ3ZNGTxTmDRBqiddCxDyX0sT7fLIsUiegyuLCRDO
 5FAxW6IKj0NFGWGzV9pD1hiNGxTNSDygaXpdR5EoxCwfgoYAlYW+o0BFh2PdWHCOT75GL89swmA
 nbM31/fS/z4wOmpLcg9ZhglY2Uu3LEZv6Ns/DHHax9Uq2CJ5ooxrO0F8ftV9JqJwItCIV/jyCTS
 Lhqn6cKNvtact86/diXoPDOLltm3YQzSbeRR6xANzcXeB4mwpeewRaH+PRCybzRWw+T/bh4oO1T
 /j1jiTvYCS5hnJ2yIBg==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab59c9e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xrONw2cGAGF1r6EUxD0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: guIzKW1ik_mvSkA8lUJzj5C8wq5gMKHh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OSBTYWx0ZWRfX3Q2apAL6Ogyo
 5iDB2N3Ly99Z9bK0IlEcIgvFDS27zz79q3kC1MlM+CTX7EkXHc/sIyiOO2lKg3DcPdHVLogFT2K
 LyOQoIIs2mBKLFTWrgk7p/EtNWA7eRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 9/24/2026 12:08 AM, Philippe Mathieu-Daudé wrote:
> On 23/9/26 19:15, Brian Cain wrote:
>> The HVX register file belongs to an extension context, not a hardware 
>> thread.
>> Model each system-emulation context as a QOM device, link the 
>> contexts to
>> each vCPU, and use SSR:XA to select the active context.
>>
>> Keep one embedded context per linux-user CPU.  Carry the selected 
>> register-file
>> base with HVX operands so translated code can address the selected 
>> context
>> at run time.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h             |  1 +
>>   include/hw/hexagon/hexagon_hvx_context.h | 27 ++++++++
>>   target/hexagon/cpu.h                     | 24 +++++--
>>   target/hexagon/cpu_helper.h              |  1 +
>>   target/hexagon/translate.h               |  7 +-
>>   hw/hexagon/hex-subsys.c                  | 36 ++++++++++
>>   hw/hexagon/hexagon_hvx_context.c         | 84 ++++++++++++++++++++++++
>>   target/hexagon/cpu.c                     | 17 +++++
>>   target/hexagon/cpu_helper.c              | 82 +++++++++++++++++++++++
>>   target/hexagon/machine.c                 | 12 ++++
>>   target/hexagon/translate.c               |  9 ++-
>>   hw/hexagon/meson.build                   |  1 +
>>   12 files changed, 294 insertions(+), 7 deletions(-)
>
> Now much easier to review :)
>
>>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>>   create mode 100644 hw/hexagon/hexagon_hvx_context.c
>
>
>> +/*
>> + * Create the core's HVX extension contexts.  There are fewer of 
>> them than
>> + * there are hardware threads, and SSR:XA picks which one a thread 
>> uses, so
>> + * they belong to the subsystem rather than to any one CPU.
>> + */
>> +static void hvx_contexts_create(HexagonCommonMachineState *hms,
>> +                                const struct hexagon_machine_config 
>> *m_cfg)
>> +{
>> +    unsigned n = m_cfg->cfgtable.ext_contexts;
>> +    unsigned i;
>> +
>> +    if (n > HVX_CONTEXTS_MAX) {
>
> That would be 'if (n >= HVX_CONTEXTS_MAX) {' but since it is a
> programming error when creating a machine, simply assert:
>
>        assert(n < HVX_CONTEXTS_MAX);


`n` here is the count of contexts to be allocated, so n == MAX is 
legal/expected (indeed used by one of the v81 machines).  I'll make it 
`assert(n <= HVX_CONTEXTS_MAX)`.


>
> Can be updated locally before sending the PR, no need to repost.


Ok, ty, will do.


>
>> +        error_report("machine declares %u HVX contexts, only %u are 
>> usable",
>> +                     n, HVX_CONTEXTS_MAX);
>> +        exit(1);
>> +    }
>> +    for (i = 0; i < n; i++) {
>> +        DeviceState *ctx = qdev_new(TYPE_HEXAGON_HVX_CONTEXT);
>> +        g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
>> +
>> +        object_property_add_child(OBJECT(hms), name, OBJECT(ctx));
>> +        qdev_prop_set_uint32(ctx, "index", i);
>> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ctx), &error_fatal);
>> +    }
>> +    hms->num_hvx_ctx = n;
>> +}
>> +
>>   static DeviceState *cluster_create(HexagonCommonMachineState *hms)
>>   {
>>       DeviceState *cluster = qdev_new(TYPE_CPU_CLUSTER);
>> @@ -140,6 +169,7 @@ void hex_subsys_create(HexagonCommonMachineState 
>> *hms,
>>       hms->qtimer = qtimer_create(hms, m_cfg);
>>       hms->glob_regs = globalreg_create(hms, m_cfg, rev);
>>       hms->tlb = tlb_create(hms, m_cfg);
>> +    hvx_contexts_create(hms, m_cfg);
>>   }
>>     void hex_subsys_add_cpu(HexagonCommonMachineState *hms, 
>> DeviceState *cpu)
>> @@ -151,6 +181,12 @@ void 
>> hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
>>                                &error_fatal);
>>       object_property_set_link(OBJECT(cpu), "l2vic", OBJECT(hms->l2vic),
>>                                &error_fatal);
>> +    for (unsigned i = 0; i < hms->num_hvx_ctx; i++) {
>
> Good style with reduced variable scope, ...
>
>> +        g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
>> +        Object *ctx = object_resolve_path_component(OBJECT(hms), name);
>> +
>> +        object_property_set_link(OBJECT(cpu), name, ctx, &error_fatal);
>> +    }
>>   }
>
>
>> @@ -554,7 +561,17 @@ static void hexagon_cpu_init(Object *obj)
>>   {
>>   #ifndef CONFIG_USER_ONLY
>>       HexagonCPU *cpu = HEXAGON_CPU(obj);
>> +    int i;
>> +
>>       qdev_init_gpio_in(DEVICE(cpu), hexagon_cpu_set_irq, 8);
>> +
>> +    for (i = 0; i < HVX_CONTEXTS_MAX; i++) {
>
> ... but sometimes the style differ, better to keep the same.
>
> (also easy enough to fix locally before PR).
>
>> +        object_property_add_link(obj, "hvx-context[*]",
>> +                                 TYPE_HEXAGON_HVX_CONTEXT,
>> +                                 (Object **)&cpu->hvx_ctx[i],
>> + qdev_prop_allow_set_link_before_realize,
>> +                                 OBJ_PROP_LINK_STRONG);
>> +    }
>>   #endif
>>   }

