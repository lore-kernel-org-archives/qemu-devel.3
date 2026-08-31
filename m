Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220E3C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16MF-0003NB-PE; Mon, 31 Aug 2026 14:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16MD-0003Mt-5d
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:03:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16MB-00028q-DU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:03:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpv7V4152602
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TvRYnW3/+Y/sVleGgbY9Y/2C1m0rwReg+tJ4Tm1kkos=; b=Ppse72AHMexD61g7
 w7wgvp0/hUYXWBD5bOENd0URrR9oJo0Ky79YrZ7I628NbtbXztojZWz9bhNxQnkm
 8ws+8D9zBAQWavNXbsSMxHUsg2XJgkign55ZoX3W2UQZQP6P4O13phnxtjd2cVXI
 EtGOruBahTRfyOAJyKr6l/e4XPp1RAOp+46IRvEcd4TNuT++/3y6VxVoV4ydLiKV
 WXu0N01LnwdAUUba1y9CZnDyy4mFfJXQhwPphCc2GWO8EJ0Qx0h4mqG15EqfyeCE
 2aGSUFxUxKFAnRaBJRv5t1cJhBljgkJG6IQuzLWB6TINF27Rzp1nB8EN2oVi9/y5
 0P5Wjw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h92fsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:03:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so67949015ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199421; x=1788804221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TvRYnW3/+Y/sVleGgbY9Y/2C1m0rwReg+tJ4Tm1kkos=;
 b=OaQ6bTQH8QAnThvssBzjlcveOZNPAk2WFa/1+z9BZccjJe5ERUMmq0sOM+u+8Hi4/4
 44+Jeca/oGQKbNsVSrYWRXe95vo9MbppeeC7VkZqJzPiGwZPGTcoBWbEkWjeYY3Kg/E0
 hnwtyM9eE6Fom/75Np5z7DffxzKr7ezt+Nfh+/Z37u8AabnWJjnJhmoKZm1VO1qSdJZP
 3tIBAn1DA1HBxS3IjkNLYSnOdX/HVy1o2TE+V29PA6mMtjJveLe96QZ8WEkVhaAqzYx1
 aPeS/gj9poNx73MFC41SBpmnreubaEHa6vnDt7aOC3qDMK9vErqq2BXUFpd+7p2ZkoEs
 UxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199421; x=1788804221;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvRYnW3/+Y/sVleGgbY9Y/2C1m0rwReg+tJ4Tm1kkos=;
 b=ghloKgCGyRVu0KUBsf7M0Fm7xxaOYYBTVkkuOa2Yc2v6dBuwLGIUYAlyTrn3+C1fCG
 ZwNRNUCKotf6OOuCJv34n+xCrZIG/dz2Yv3tuRVDWr5I41CjDvW2XF8Cl8JiqLljFjiB
 9WUSxfIlCNAClWVyWi7oXmwjycWSyBIQ0V7Isgd9jVTSSeP9q7LDGqr1LT4nLVQZs1Rz
 b0QRZ3w4CZOCg/PdMfE83Y1Iv97Vzq2rsKgHmaV+L54qPPLAAl5RNTR2rOr1JQmSDpkX
 pgZXJG3uY1bzRKn/fMhnel1Jo6zwJpQvi089JeBJo1WKBXbcOKC/rbn81oc4BmJFqzYo
 B1tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXzCrilU+pzClWLkxDdvBO++JfPyitlBwkmR8WLJZAJZNtWHA+fUIsXAfnw76bh5XFT8SXlltHp6ec@nongnu.org
X-Gm-Message-State: AFuF++lyVqnKHcX3QgoGJPg4tQOHlrqcb/WAjy8SFBt/Su8CHX3Uoo+J
 8nL6A8MopRjYEO1djOh5koIFv43pnTAmrJnuODKMalPOYcBVzVIEKkwTVvscHdBymRJlheARd2k
 NsQsVqMfKtLnH77/LY7SmFg74sgVaetp53uf5sG6vlpJTqZBL7MjfUANffg==
X-Gm-Gg: AYBFou2IYYrdpZ/Fazlv2bc//VHpCqdFsaAIMs1nwmqAysk5jRRJQEoz+laFTTDHjm5
 OEBzg4OhF7j1CjbyNv12mpNLrrB+lZjJbCPI/LwB9PoG1GVOZ74E7tYxLU8iLgFgHF64zZgnTFE
 svkfQ7om0Ba1nJ+taEItrEmDWTNY1UEbYgTOOFGtSE67sy+uE5kHOMVeYJORny8y44rxU0rIK/x
 MMi6yCYvlouFP/2kgfETvL3eNckT16Uab2pCuK/5/LACT1Lymb4Q3a0vPiXKV7hkeSTjRLJBwwc
 o6dxP8SvJtM20UEMB5RnZ3dMkivtUuZeOGuadxVdu1Rt5HGVQ2xv0Rh+AxB2Hu4xunQteKqML0F
 ej7DABf4/G/cMJsQKREF/hwgU/xOGX6yawvzsPoV8iqO19FBVSr6qTmnQG0H3ENgB6kz2
X-Received: by 2002:a17:90b:534e:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-398e6b6aed3mr11642010a91.12.1788199420722; 
 Mon, 31 Aug 2026 11:03:40 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-398e6b6aed3mr11641929a91.12.1788199420082; 
 Mon, 31 Aug 2026 11:03:40 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b49c867f5sm17648585eec.2.2026.08.31.11.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:03:39 -0700 (PDT)
Message-ID: <9f47ab02-a194-4244-a78e-9edabdfc93c4@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:03:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/47] target-info: add target_config_nitro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
 <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a95c1fd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hiKMKSj5LkALjLU77ycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: lEgoOmU81KBOJUP5l7W6M2XaImZO2o0r
X-Proofpoint-GUID: lEgoOmU81KBOJUP5l7W6M2XaImZO2o0r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfX/N7JEO2apRKk
 l8fOhXMPdJgtmU0JhdMuNb9m+CPKH0sYUI0N8IQ6IQwJvV7nE93X4Y3GLwym5j9j2MgfizQpwNN
 lAOLoR7MqiYA0vm8oTHg+T/x+++81Ag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NiBTYWx0ZWRfXzDFpobzVhXW0
 TQ5cnBUAX611x1ViG+fbzGz8LwEd5CkJJh/378E/lylOYoqfTfDDYHNFB+6alskmUVSoPgRsBms
 5SvFKZk+ez0ZRMDrhc6eg3K9fuyvwgu6Ov+S9a5aN6vHNXFslG8LfMe2Z3DAE9gghwDrkFFihDb
 yH88j9rm0RFBbzJ3MyMGiKakOyF0Vmc7La7t23u0JGDDTpFqswwppQ22d7Jrf83R0NCqGeYTGaW
 8mjdU44gOcYdTV/qecPc4ziTp8MBPaAIJQprtSGvtQIbUr/wBk/n4ejMAWTJwOgVAXhbHVkwVyx
 N3NZEGJy/aJJ8ba8h8uxEXVuS+nVHlKfv/npYos8UZUPGAkS/fpfyGaDjNIR3snRnVzBd4pbHgp
 dqOins/f1ADJVUSsBa/u0pNRuBJbLxwr1aKrCkyXSTTIZU1l1EuiIOPZrL8GtPcfrtytn5dqtIG
 LAD6CiC+iLIrg0Bhvog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/31/2026 12:15 AM, Philippe Mathieu-Daudé wrote:
> On 29/8/26 00:58, Pierrick Bouvier wrote:
> 
> Also wondering why we need a special config for a target device.
>

A lot of devices are concerned: basically all those included in
meson.build using 'when:' directive. Beyond host/target/libraries
dependencies, we should not forget that a user is free to create a
custom Kconfig for its need.

It implies that we need to represent Kconfig constraints in our C code,
which is done through CONFIG_* defines per target.

> So why are we listing we can not plug? Maybe the bus Kconfig is
> missing the accelerator dependency?
> 
> -- >8 --
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index cfae85920a0..2e4125f8710 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -1,4 +1,5 @@
>  config NITRO_VSOCK_BUS
> +    depends on NITRO
>      bool
> 
>  config NITRO_SERIAL_VSOCK
> ---
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-impl.h | 2 ++
>>   include/qemu/target-info.h      | 7 +++++++
>>   target-info-def.c               | 3 +++
>>   target-info.c                   | 5 +++++
>>   4 files changed, 17 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>> info-impl.h
>> index dbd7a5a2071..4f6c898c707 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -33,6 +33,8 @@ typedef struct TargetInfo {
>>         /* CONFIG_MULTIPROCESS */
>>       bool config_multiprocess;
>> +    /* CONFIG_NITRO */
>> +    bool config_nitro;
>>   } TargetInfo;
>>     /**
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 579c43332fb..d775c94d1e3 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -49,6 +49,13 @@ bool target_big_endian(void);
>>    */
>>   bool target_config_multiprocess(void);
>>   +/**
>> + * target_config_nitro:
>> + *
>> + * Returns true if target defines CONFIG_NITRO.
>> + */
>> +bool target_config_nitro(void);
>> +
>>   /**
>>    * target_base_arm:
>>    *
>> diff --git a/target-info-def.c b/target-info-def.c
>> index 9d51371f766..96fd1f8c73d 100644
>> --- a/target-info-def.c
>> +++ b/target-info-def.c
>> @@ -46,6 +46,9 @@ static const TargetInfo target_info_stub = {
>>   #ifdef CONFIG_MULTIPROCESS
>>       .config_multiprocess = true,
>>   #endif
>> +#ifdef CONFIG_NITRO
>> +    .config_nitro = true,
>> +#endif
>>   };
>>     target_info_init(target_info_stub)
>> diff --git a/target-info.c b/target-info.c
>> index 5db2a6049ac..67127da16fe 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -47,6 +47,11 @@ bool target_config_multiprocess(void)
>>       return target_info()->config_multiprocess;
>>   }
>>   +bool target_config_nitro(void)
>> +{
>> +    return target_info()->config_nitro;
>> +}
>> +
>>   bool target_base_arm(void)
>>   {
>>       switch (target_arch()) {
> 


