Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArYP-00050N-Ni; Mon, 20 Oct 2025 11:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArYH-0004wX-Db
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:12:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArY9-0007vN-GN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:11:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso24923625e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760973110; x=1761577910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sURWjTK3z0LOJOs12PmtW7Dl8fQD/klG4fMg9vsLUac=;
 b=K67r/LUb1/T20FllTbvQbA9jRtww/1Bpgo5JfgqRKxcb7u8v5jv6qBNJtvLmX7LZyv
 rFBIvdZrS0dchYPVoPvoEnX5zJ4SJdR1JT2u4iGUtSIJ/Dyh0nZwuiTYzsoXO/2reikY
 /zqfuOFjL8UDz1+eWGaIrUKrvzR7fPSQAWb/db7GUGQXbOYDYvXj4XWpuVvWYArWidjo
 elvd38YM8YOvyUkXLsmHgG987PjMlEi0AWEp86zQGm3/4N716KPEc75FxNXJEsDZ0led
 2hoS57Dcu1TfWZPBfg35TnFnhpPl/yVApbK/CBlEq+oTA6AMYz9YEKRjje/8AQTEIZMn
 bMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973110; x=1761577910;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sURWjTK3z0LOJOs12PmtW7Dl8fQD/klG4fMg9vsLUac=;
 b=oyLFXI55jYgZqj/VZ2p0RiiukjGApWt5BAsoAtDL4a6FwU9mjC2jA/zGxjwKNvEo9n
 5r6tJwOh9/eXHSr2///FPBDMM2I7RANiBFB0bKas6IQPJfg2mQz1DLfxilYpnKcAZ2JC
 BH9GwJh5lCNVAtbUAKPEs12jmhd9QSAYc1D10Fh9vH3BERQSEAowxfoRUtxzjllUeuVA
 H6Qy3lJLTI6LWxwe+Ql0AsMdMw6KV2w2sX2uW24NvOR2mCz3pKUy5IBz3ctko4cLuqjn
 7TgnSWT+pW/SsEMELYtiPiPoP4yViTt8Y0bK6/WicF3wxV3qHgcOyQP/VTJ/jyr53AVy
 7Ijg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaF/kXBM+PZYQiMDjhUmFvQ80mtu+/zQUAM6DqRAlflgUTOacDwY4paot1Sf8MaVMDBg0EwqhuWvKY@nongnu.org
X-Gm-Message-State: AOJu0Yxw+Tx5cHdPvyV4DF4vyBK5HgImEHIVDbqYWZzdIWhn2xRFnFgI
 QZxyGI2Hijhq2xgvMAQmPkAkI/sCAMQ6Rbg52WODA9I1RnH8q2kS6ztD9rITsMfSCR0=
X-Gm-Gg: ASbGncsggFqzXiBu85OsnTqLNmW7sa94P4HbT7oHHhhRzvvmirwJKnTT63gdplDMNJu
 7Zh1S8yCvYaWCATKeptebB9JkkCU+OymxYjZE4JvMeeU2x69/BDPCMzqquMh+j/AqeSUCqa3SAG
 uc65v/PQOqUwblGux9FEYXrijc02QA4o+Lau7YHA6DglJ2oJPi3EACWS1icPtKDMY0gAD2Zg4q1
 CtWWp0DjnPAQM1hgo3oe5U8Hrh72x7ptSiid9QPuuF1yx7HT6WVbIZWwCE0vU7gRuvKGyYdXPTJ
 VbFxPXRruZ84FulI9yMRedqYSXLrkhZ3b0upsD1eFZ3/nf/8cH8kHEABwVBEH4RZz+4Qj2Zr2//
 ub5KltueBcvW7CfKRNxcucWXCwyNtvcOW9AD6gxdRrYWnVRbCjllNTHqBjVk8eGmgJBw6Xro4A3
 XTnaxyxHwAC0c/T0nGX7cGuq7+o3cTAA+PSYr32HSv7jwh8Ax+7PvvsA==
X-Google-Smtp-Source: AGHT+IEHj/p4ud4ZbYvErpWFQIIJaaOOE77zLb+lbdxkU6J231lo5Mp7SRgCGe9WFVV7aXDE4ATBCw==
X-Received: by 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-471178b14acmr96210405e9.18.1760973109895; 
 Mon, 20 Oct 2025 08:11:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715257d90bsm150371385e9.2.2025.10.20.08.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:11:48 -0700 (PDT)
Message-ID: <00108467-9f4f-4078-a430-0f18297da94c@linaro.org>
Date: Mon, 20 Oct 2025 17:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
 <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
In-Reply-To: <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

+Pierrick

On 20/10/25 17:05, Philippe Mathieu-Daudé wrote:
> On 18/10/25 17:11, BALATON Zoltan wrote:
>> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
>> versions with less parameters based on that. This is inspired by how
>> the OBJECT_DEFINE macros do this in a similar way to allow using the
>> shortened definition in more complex cases too.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   include/hw/boards.h | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 665b620121..fd3d549ff5 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -762,7 +762,8 @@ struct MachineState {
>>           } \
>>       } while (0)
>> -#define DEFINE_MACHINE(namestr, machine_initfn) \
>> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>> +                                machine_initfn, ABSTRACT, ...) \
>>       static void machine_initfn##_class_init(ObjectClass *oc, const 
>> void *data) \
>>       { \
>>           MachineClass *mc = MACHINE_CLASS(oc); \
>> @@ -770,8 +771,11 @@ struct MachineState {
>>       } \
>>       static const TypeInfo machine_initfn##_typeinfo = { \
>>           .name       = MACHINE_TYPE_NAME(namestr), \
>> -        .parent     = TYPE_MACHINE, \
>> +        .parent     = TYPE_##PARENT_NAME, \
>>           .class_init = machine_initfn##_class_init, \
>> +        .instance_size = sizeof(InstanceName), \
>> +        .abstract = ABSTRACT, \

IIUC we don't want to have abstract type with interfaces, but
only QOM leaves. So maybe better always use .abstract = false in
DEFINE_MACHINE_EXTENDED()?

>> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
> 
> IIUC Richard asked for array argument in order to save .rodata?
> 
>>       }; \
>>       static void machine_initfn##_register_types(void) \
>>       { \
>> @@ -779,6 +783,14 @@ struct MachineState {
>>       } \
>>       type_init(machine_initfn##_register_types)
>> +#define DEFINE_MACHINE(namestr, machine_initfn) \
>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>> machine_initfn, \
>> +                            false, { })
>> +
>> +#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>> machine_initfn, \
>> +                            false, __VA_ARGS__)
>> +
>>   extern GlobalProperty hw_compat_10_1[];
>>   extern const size_t hw_compat_10_1_len;


