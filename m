Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB7FC83033
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWLM3-0002CG-I2; Mon, 30 Jun 2025 16:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uWLLx-0002Bj-4Q; Mon, 30 Jun 2025 16:43:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uWLLt-00077a-IR; Mon, 30 Jun 2025 16:43:48 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so9902053a12.3; 
 Mon, 30 Jun 2025 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751316223; x=1751921023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHQPlHoIQU5jw3BtSgHJsEIjR0WisF4fqWjRimEzoiA=;
 b=VitUWICUMy1ggyFQw8gH7RQqBqi4vKKcQipJ435EMllAiqlVXINra3IYQe0/n/AqaD
 YnOmSP4Iz156/C8hsDB/ui+0Rp9dpRciZ1W+6SuLDsCJyl6eIwpv9qG3gFJVO5iwLwju
 lUewu3DKi6Vip0chm2wI7yFDOH3j4FQF+pSP65irF7u53noMNzBLc+sj8Lv1bSVX3116
 EA08RietCAOOi+B7byo75dQiDcYp7G1MorNn07jfuhMbE2Rhet/1IGur2My4X7YAFs/G
 FETYbb1ukWbLlkugz6mZzpS/PFK1OysBiQq/ADALP2AgPAMzy6uGH0QYokO1fn/PHtY+
 WhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751316223; x=1751921023;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHQPlHoIQU5jw3BtSgHJsEIjR0WisF4fqWjRimEzoiA=;
 b=otvHrDhq6JKWzQzxSxLAsU1E1aupkDdtP22ytgnW56UPVFrNnI0/PFeD9i5e7oKqYy
 LR1cQ9FqsCh8+Sp9LGKrsldFkeKqdAFyHO1mg6YfH0Vwls26CCVu8N98arBeWl0Tk0F3
 hKN4BgCPEuaIoy3wzhy0MkC6UqCVqv9MivVwbn47mRH3CFmC8H1QEr1yTmdd8bOBKEv8
 osMRJpSpXo/+B3cHFpJYAfU5o47mRLQTN40+2C5M3ONImsNT8rM2SBybhWF/gPpT3imd
 Bjkl2ZGDxCondMEpNE3o2f9uSeTRstFgxWxQlWGPctUkLoUvsbBBu/NGZ9/gTMQnSvq3
 UWxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi35PQ1/hHvtRi/cwGvIyaXNa18Qu9d3wDfKPkQjUz1ogXuJGUAFi9U89AohbKG09nceTzkPs57SzK@nongnu.org
X-Gm-Message-State: AOJu0YxjCkqu6P1kuGm/wYU21uS1P5xeH1nMUsVlZaRm7rtoYLyZPNft
 eqCH4V4At+25bbFC6r1qo8e9usX5j5CCDk554iK5ev2I+MbxZM3daXys
X-Gm-Gg: ASbGncsFTTCj2PMevEh7rU8TP16vJ7tteblwjLkE5b3fCbeKU1u2Dky89OSYIVlhSOe
 yk9aX+r6ZxfaocM1qkRM7B1YnlpAeW6gmgcwXiKiEmnbfXu4XlsMb8gXEcacDxebJVkGPDs5u2T
 npO7es7RAK3QT1VGw8Dev5S2uKG+dLjoROgV0Sj45RHIKSocRaf1OMlwI5vfjK9Sr0AFaRxOPjk
 K3/LSP+JPJfu0lVN56jBA0hhDP5LA1Uctlpr823BfsrOVNvECc7ylc28UhdUoY91hy2cEwFn1hH
 9+jZZvNTReeQME3XgoWXxLZKgDJJ/71aFfAxrHjnmyB/PLZjO8q+e2ABMoCMHkK55PTzL1qVCTX
 ZFghs4VQ1VQGQ4KC63gwJ8ame9Q+lQicQyqAcof5m9TdwUrwH9AJwk9dvO+Vd87WRbMTFKA==
X-Google-Smtp-Source: AGHT+IF9H5VLFtoOpid1agE+FPFow2HeNv8/QvsxyMM6+WSWeKbIZbqZuYXiOWXzMp96cXefRPZaPw==
X-Received: by 2002:a17:907:1b10:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae34fed6bc2mr1463563966b.27.1751316222817; 
 Mon, 30 Jun 2025 13:43:42 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2c1e-5d00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:2c1e:5d00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01201sm751679866b.97.2025.06.30.13.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 13:43:42 -0700 (PDT)
Date: Mon, 30 Jun 2025 20:43:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <44960792-ac07-4b93-af85-643f2f438798@linaro.org>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <44960792-ac07-4b93-af85-643f2f438798@linaro.org>
Message-ID: <FC295A79-159F-4DBC-84D1-930CEE971EBE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 30=2E Juni 2025 08:58:22 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>Hi,
>
>On 29/6/25 22:48, Bernhard Beschow wrote:
>> Allows the imx8mp-evk machine to be run with KVM acceleration as a gues=
t=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>>   hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++++---=
--
>>   hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>>   hw/arm/Kconfig                 |  3 ++-
>>   hw/arm/meson=2Ebuild             |  2 +-
>>   5 files changed, 49 insertions(+), 7 deletions(-)
>
>
>> diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>> index b3082fa60d=2E=2E30eb57318d 100644
>> --- a/hw/arm/imx8mp-evk=2Ec
>> +++ b/hw/arm/imx8mp-evk=2Ec
>> @@ -95,9 +95,20 @@ static void imx8mp_evk_init(MachineState *machine)
>>     static void imx8mp_evk_machine_init(MachineClass *mc)
>>   {
>> +    static const char *const valid_cpu_types[] =3D {
>> +        ARM_CPU_TYPE_NAME("cortex-a53"),
>> +#ifdef CONFIG_KVM
>> +        ARM_CPU_TYPE_NAME("host"),
>
>IMO 'host' should be kept for 'virt' machines where we want the cpu
>type with the maximum features possible=2E
>
>For this case where a real SoC is virtualized with KVM, I'd keep the
>SoC CPU type=2E If the host misses Cortex-A53 features, KVM will fail,
>otherwise it will disable the extra features and only expose a A53
>to the guest=2E

I tried `-cpu cortex-a53` inside the `-M virt -cpu cortex-a72` machine and=
 this resulted in an illegal argument=2E This happened even though the virt=
 machine was using the 6=2E15=2E3 kernel which is pretty much the latest=2E=
 Given that this very recent setup didn't work I added the 'host' CPU optio=
n as a fallback while cortex-a53 is of course the default=2E What about adj=
usting the DTB with ARMCPU::dtb_compatible?

Best regards,
Bernhard

>
>> +#endif /* CONFIG_KVM */
>> +        NULL
>> +    };
>

