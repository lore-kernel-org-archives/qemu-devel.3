Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2980C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gUd-00054D-NH; Fri, 04 Apr 2025 08:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gUb-00053f-01
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gUY-0001kr-EN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so21635055e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743770988; x=1744375788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHz6QRFKgtp/Y368ONgTwaOUzYTDmLXSDiIxMvjKI0M=;
 b=nmpCtjEGvmYKmgtn5R+DnkRNejRxf0y3pw+Vxtz4+4WlwH0/DTAGaY2BEpXWCh8+Zn
 wkphVLLnLte8ICv7Dm4NTSgCg/RBS7GAi/cI1TA3w1n1RnjMwRb8H98pJyO7Uy3va8LR
 WJ6yjmCeo81LoX2oq6mWWWqImEToSjEI2V9RdU/kwNptpk3twHxnwyQup0nXQWXt60RD
 VHwIejrMA6cyJXOY8VWkPPZ0OUnKGmx9zX6nngMIxa7mb7fTLL1oxxMTKrRflSJwixB9
 KYvYLsIweGgEmzXRVpgZmJlNg6DU9+f+bqOSsGKuUSX2KH3Jz5h57g4wGXqkQ88gJVEY
 0SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770988; x=1744375788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHz6QRFKgtp/Y368ONgTwaOUzYTDmLXSDiIxMvjKI0M=;
 b=oe9iGLvzEheqGqzd2zjUh8Hx/HxddKeM3T2PY/eA507xMOx2L1BwGsnwQj4eDzSZvX
 CvjU6h09M//D+doPByhjrr1VSAeIT2QAZ9p4E0Hy5KnqUH+K7zC0eydpUZ1v+dwo9V3K
 pcNwJG7HXZ8Z+74YwT3V54n9hG1/a3hvptBblZl63eYOF9pWiAaCbXOHkpmDs/mVlKuv
 yPcJXUi1ocUrXaDD7ImwC7R+mvm5gR+3kfsZCrzLF8wPkX/szQ2Z4e6pqCdkdwYeD9jn
 p6z3Ye8NM5bWHFOKWWQcrw4kyqRbgbAgPSdbbQydF5Ll8hcIb2g2v19owk1sw5+lcN1Q
 8IOw==
X-Gm-Message-State: AOJu0Yxfc2ooFh2ANkRApIl5poUaw5irihEs8Ou1q87GodtrnnkajRZJ
 vMec+Onf1t13IxdkiMaiRxpa2r/x4YfTqJ+kcWepIPgXe/dzpmEohiMYn/queFs=
X-Gm-Gg: ASbGncuytFC+XtthL/Rn8WdtaW/AiQzHvTULKB/e60V5JzAdPkVA7Nk0oZgjzjyAufj
 iRCQVxQTAQrDoOA3DWN+Ut1r6LidOCB9hGkTr5BvzbSUX1Wv03Lglj2fHRSp5loX4+389RWfiUK
 lKDsuHn7gODAxCTFLdHqycybrhsgi+sB7zDEH6v7oAS7PGiXSY//iO0Z7XXc7ox1vKkpJzJrjlY
 V4fl6jF87ZvPu5FvPa/jJOGzsH23Bw83YZJ2GATzuJPSU/qYDi5IFXEmdHePLp58wVhm8BjOSea
 lhUdmHoO59EBVAGIGt2uDPNCKOIBvTPb1zMIam1AaKc8MkQWYVGnUfeBLSwYBDkG86erH5p7H2y
 jvBpsL2dsGhdN
X-Google-Smtp-Source: AGHT+IHQMvCvIZAswZgDXYftO25U5IsTcaLWf9G/LfTu2jUpD0e6YsK5TRdiTaas6lhcoPhV5VlhoA==
X-Received: by 2002:a05:6000:186e:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-39cb35a0d4fmr2577194f8f.3.1743770987582; 
 Fri, 04 Apr 2025 05:49:47 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a9da1sm4208847f8f.22.2025.04.04.05.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:49:46 -0700 (PDT)
Message-ID: <6b64af93-f542-4a0e-8e55-5bb235f42c83@linaro.org>
Date: Fri, 4 Apr 2025 14:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 13/14] hw/arm/virt-acpi: Do not advertise
 disabled GIC ITS
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-14-philmd@linaro.org>
 <20250404124110.59c59dc3@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250404124110.59c59dc3@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/4/25 12:41, Igor Mammedov wrote:
> On Thu,  3 Apr 2025 17:18:28 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> GIC ITS can be disabled at runtime using '-M its=off',
>> which sets VirtMachineState::its = false. Check this
>> field to avoid advertising the ITS in the MADT table.
>>
>> Reported-by: Udo Steinberg <udo@hypervisor.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index e7e27951cb9..38a9e6fe0c5 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
>>   {
>>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>   
>> -    return !vmc->no_its;
>> +    return !vmc->no_its && vms->its;
> 
> It's confusing have both no_its and its,
> it would be better to lean this mess up (i.e dedup or rename if something is poorly named)

What about:

class: s/no_its/!its_createable/ or !its_usable
state: s/its/its_created/ or its_used or its_in_use


