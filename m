Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76FED5C0E6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Qaj-0002Pt-8g; Fri, 08 Nov 2024 10:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9QaW-0002OH-F4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:07:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9QaU-0000IV-TZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:07:52 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so1584792f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731078469; x=1731683269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdVJK+skN3puiJ7nU645pMIhqPtlDTNMSBqXn2QS3MU=;
 b=YHv4c1rtn9HGmPEibuDcsee7/anE7UGA6Yf+fIrkZfLz03tb4oTT57FNw+tTRDifrg
 hBKlbateVkj1gDOZBDhI8ZSdD+3o+BsmbL29sFCwDX7GruR1oP9Xo5tnslfspNUks6NO
 0DrK5KDgIOQ/U76cEWonhbwJbUXPc6Mojn4H4V9P5E9AuohM05WhkoTwPj66kIEZmrsW
 DEHKUQMpo/aFSawrVQ9ACTeDceCtBAHJJURQ5zNldRGtPvmhDL4/aQvPD1Cykhs6iAt0
 3PMZd/iFRE9/cB4tV2GDoIvDroRex7H7/vwcu0vofe+MTN1N5TZy9XU9AOSjaHXgX9O8
 IbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078469; x=1731683269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdVJK+skN3puiJ7nU645pMIhqPtlDTNMSBqXn2QS3MU=;
 b=ZQAF4lZG1qjLASPjhCPMTc0JCjA+g/tssmLhBt+uk9CT2y5At2ic9b9DfEKcNX6CnE
 7FEhIU7TCN7gr3G+wRf42q6Bjqs11LqxkfbVjXc/xHhWqUPNSvlJ2DF1vPBiC3uOEYvC
 a0SdogzDIu0ZpyT5GjWk1lyvQUZcFxCHm7MKo8IPL5fjgk/uDbSHyw6skxff+7FqA4kA
 aDA1xYNcahjXm4j8yGsBy4ajywFpPphKJ+En+0s6pn1v0A+h4e8NHyMf+6h101IohwIH
 cbbSPNqu9tqvjZJoNIP14RtwT1fvhP/ZYghs45USJqATsSNODOs5eOthgqBD64bxiZ9k
 nk/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXodQ2NZcsG0QRjI+vSSi9ZEFU26Y0FgkQkFsb5Ns4fi0AK9ebmXBxbUrdIM0jIRJNIg9dvVgAz9G2R@nongnu.org
X-Gm-Message-State: AOJu0YwIqRAQuDSrI/iT5YEH+JN70zGvF1ph2/SvNtX8XAfMU6naVkkO
 q2YiNsGPQQHNPN7t0r8qoYPANv8AQJtG8byV7DeiX4WMa9MMnQS+HJfk6XUnZ+g=
X-Google-Smtp-Source: AGHT+IF91Szv5OWZysZVLh16jVHqlhN66Pw77kjV+6r5uXdanVbMWkhKZapkBNTtH55u6fBZHXpazg==
X-Received: by 2002:a05:6000:796:b0:37d:3a2d:8577 with SMTP id
 ffacd0b85a97d-381f1872fd5mr2908690f8f.33.1731078468995; 
 Fri, 08 Nov 2024 07:07:48 -0800 (PST)
Received: from [172.16.22.241] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970e23sm5126426f8f.18.2024.11.08.07.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 07:07:48 -0800 (PST)
Message-ID: <5eae8356-ad71-4b6e-b3cc-025ec23a0846@linaro.org>
Date: Fri, 8 Nov 2024 15:07:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] hw/ssi/xilinx_spi: Make device endianness
 configurable
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-9-philmd@linaro.org>
 <4b678b54-0f1b-4b3e-8201-fb22c7cd7cd5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4b678b54-0f1b-4b3e-8201-fb22c7cd7cd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/11/24 11:01, Richard Henderson wrote:
> On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
>> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
>> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
>> Add the "little-endian" property to select the device
>> endianness, defaulting to little endian.
>> Set the proper endianness on the single machine using the
>> device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/xlnx-zynqmp.c |  4 ++++
>>   hw/ssi/xilinx_spi.c  | 29 +++++++++++++++++++++--------
>>   2 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index ab2d50e31b..e735dbdf82 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -714,6 +714,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, 
>> Error **errp)
>>       for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
>>           gchar *bus_name;
>> +        if (!object_property_set_bool(OBJECT(&s->spi[i])), 
>> "little-endian",
>> +                                      true, errp)) {
>> +            return;
>> +        }
> 
> How might this ever fail?
> Despite xlnx_zynqmp_realize having an errp argument, I'd be inclined to 
> use error_abort.

Yeah I also noticed that, but this is the pattern this file uses, so
I'd rather clean it up in a separate patch.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


