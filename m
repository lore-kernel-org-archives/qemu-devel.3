Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFEDE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLnGd-0000oo-1y; Thu, 12 Dec 2024 12:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLnGW-0000o3-AQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tLnGT-0004LV-QX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734025575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBznrJE56VRWhrBvxk3/sZkoRE2CzrKK9JIJqvtRp14=;
 b=GLLVdX+nrfzWjWkfYrgi3h/7m0U8Y4IoxQyZPqFTE1mwdeqZ4Iinq1cP8X64rC6+jjwIER
 fwVbkVsHZGf/yqiUtfWZDFbUqizayb8LfF0ZOWMjP/7df4Tg1Nu0IzYkrOYQFZrnLdLrFR
 8kPBFB0se7lXpEqwBYDWx479WpER+Jw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-T8KPEP2UO4qDi2V7rQX3mA-1; Thu, 12 Dec 2024 12:46:14 -0500
X-MC-Unique: T8KPEP2UO4qDi2V7rQX3mA-1
X-Mimecast-MFC-AGG-ID: T8KPEP2UO4qDi2V7rQX3mA
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4675670e56dso30547061cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734025574; x=1734630374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBznrJE56VRWhrBvxk3/sZkoRE2CzrKK9JIJqvtRp14=;
 b=lOMpwifroC5uve0h1jC3z15K2LvLtwGd5p2MR+HKGO9ugG9K3vcO4nD8KH9hp72fkW
 DSQA/o598Bu+/O64Y1AJ2ymq/ANEWGWoxXg2vY+b0s844aleRoLPdtI2mIQKS5K1rPk7
 pUaKdFnu9GG2Yb1+CkVZyGDPh+CIhelZ3MJZRy6CCdWyzIcGGHv+HSQBIi4YUAfNE5Wq
 Ha8e/ubrewhrxXhxhy81wgea+H4+Xca+uwfkJ2NQ2ZGxiSOvw6NLtEI3D3+x+HB5/Bfu
 lTKlLMOWjRg0AVRUGgmJjmFNdYVXCb1BzPc9lGujpxyjsbaGDbUDzHfulIILcp2ndbTn
 Luww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZMO0vbelFdgtBwcANzKQs4ftnfiW4ul5zoBtnnQ8tIkKiMTZIRUAnry1KS6R3aJZCn9ICH0bXGcB+@nongnu.org
X-Gm-Message-State: AOJu0Yw4NvxtBQ8jcLxD13P1HOIn98QT477VG+QUJf1PhGgKGah9ptVB
 46wDj6lvU843tyh+Xbdz42MMuOiyIhxdYD15f6lMEM07p4MNFZl+JyqgNqcYTMHStfGJ88XwrDt
 RXSkq/0OoLtZHRtevRsnc4CiO4K1dNKWMQut/fUSlXMZZ+hb4SnxS
X-Gm-Gg: ASbGncsD82hYIkD966RV8739NEqByLWSVcjXJDNsTZwIe98ngUrBZky6XKkvwi8FbYW
 CXCazag3/8SaSRo6xOfOA4wsFlfV1SarT0V18hxFUX7JzAvt80+6E/3m7v6qv1bYCfhfCxhgbn2
 xg+4TLOvt3kxoyO0NNa+1I6IoqlEyqOH4oiKPht+OvmEwUSFoVCqBJpn7/geoRMXt5oC4urJHu6
 /VoL5v/lyIfAo64RZ62DuGYQH4bINFo8YdDMt2jryTS3RxmgrJSyTdY+LEjJnfHp8PygIWJB8uf
 6HmVLRtQyhZc3gjrHmrXyjOFMuss
X-Received: by 2002:a05:622a:1481:b0:467:6486:beea with SMTP id
 d75a77b69052e-467a16d8d82mr17250391cf.38.1734025573773; 
 Thu, 12 Dec 2024 09:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESjabeM15BdQhC8Wj8b+Ah/nkx1/l8WK0j38QBKEhg2gmiHasG+E2HVEBwie5+liQCRSqa5Q==
X-Received: by 2002:a05:622a:1481:b0:467:6486:beea with SMTP id
 d75a77b69052e-467a16d8d82mr17250071cf.38.1734025573505; 
 Thu, 12 Dec 2024 09:46:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4674feaaab4sm59534911cf.18.2024.12.12.09.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 09:46:12 -0800 (PST)
Message-ID: <12a2ef7c-0ba3-49d9-9e08-733b8ca6a753@redhat.com>
Date: Thu, 12 Dec 2024 18:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 02/20] arm/cpu: Add sysreg definitions in
 cpu-sysregs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-3-cohuck@redhat.com>
 <2a83a49b-6863-4fb8-b5de-c3eacf3cdb77@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2a83a49b-6863-4fb8-b5de-c3eacf3cdb77@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Richard,
On 12/12/24 15:37, Richard Henderson wrote:
> On 12/6/24 05:21, Cornelia Huck wrote:
>> +#define SYS_ID_AA64PFR0_EL1                             sys_reg(3,
>> 0, 0, 4, 0)
> ...
>> +typedef struct ARMSysReg {
>> +    int op0;
>> +    int op1;
>> +    int crn;
>> +    int crm;
>> +    int op2;
>> +} ARMSysReg;
> ...
>> +static inline ARMSysReg sys_reg(int op0, int op1, int crn, int crm,
>> int op2)
>> +{
>> +        ARMSysReg sr = {op0, op1, crn, crm, op2};
>> +
>> +        return sr;
>> +}
>
> Not a fan.  Why take 20 bytes to represent these?
sure we can optimize it
>
> Our existing ENCODE_CP_REG and ENCODE_AA64_CP_REG macros seem much
> better, even if the argument ordering doesn't match the column
> ordering in Table D22-2.
>
>> @@ -841,6 +849,51 @@ typedef struct IdRegMap {
>>       uint64_t regs[NR_ID_REGS];
>>   } IdRegMap;
>>   +#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm,
>> op2)               \
>> +       
>> ({                                                              \
>> +                __u64 __op1 = (op1) &
>> 3;                                \
>> +                __op1 -= (__op1 ==
>> 3);                                  \
>> +                (__op1 << 6 | ((crm) & 7) << 3 |
>> (op2));                \
>> +        })
>
> Ah, well, this answers my question re patch 1.
>
> It seems a shame to use 128 slots to represent all 9 id registers in
> the op1={1,3} space.
wouldn't it make sense to use a hashtable then as we don't have
consecutive indexes?
>
> Do we really need anything beyond the defined registers, or even the
> defined registers for which qemu knows how to do anything?
what do you mean by "defined registers". The end goal is to be able to
tune any id reg that the kernel allows to write. So I guess we shall
encompass more regs than qemu currently handles.

Wrt op1={1,3}, tbh I initially sticked to the KVM API. Now looking at
D22-2, effectively we have very few ID regs there. If we were to use a
hashtable we may be more flexible in picking up the indexes that are
relevant for us.
>
> I'm certainly happy to replace ARMISARegisters fields with an array,
> but more like
>
> enum ARMIDRegisterIdx {
>     ID_AA64ISAR0_IDX,
>     etc
>     ordering arbitrary, either machine or macro generated,
>     but every register has a symbolic index.
>     NUM_ID_IDX,
> };
>
> enum ARMSysregs {
>     SYS_ID_AA64PFR0_EL1 = ENCODE_AA64_CP_REG(...),
>     etc
> };
>
> const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>     [ID_AA64ISAR0_IDX] = SYS_ID_AA64PFR0_EL1,
>     etc
> };
>
> struct ARMISARegisters {
>     uint64_t id[NUM_ID_IDX];
> };
>
> This seems trivial to automate, and wastes no space.

Sure we will study such rework. As long as the key (ID_AA64ISAR0_IDX)
can be matched against the index used by the KVM API we should be fine.

Thanks

Eric
>
>
> r~
>


