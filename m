Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE330C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 05:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwEdU-0002Vi-2C; Mon, 15 Apr 2024 01:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rwEdS-0002V8-7m
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 01:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rwEdQ-0005Zj-Ml
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 01:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713157922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Piyv/7X//Z540ppLRDPUf3c9VERD7QXRfeH/BhjqEEM=;
 b=RmFBB+q0hQvgU9SNVdoAD8X35Depl+MAbozsYsxA3Lqmj9vPMnBdWiZSUFXTAvQj3rhcmk
 GjCcylKUJC6/ZZnrbetsmNBkwnipygUBKNXFxKNtb3vrqwrcaN3btIp/SLKF+UrpK0ifbL
 5Y+wlPnXDFVURWOwGji7LVQoPyDiy3E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-BNNHMwKlPiWeFxSTjOKlnA-1; Mon, 15 Apr 2024 01:12:00 -0400
X-MC-Unique: BNNHMwKlPiWeFxSTjOKlnA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41828dd7c29so2479125e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 22:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713157919; x=1713762719;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Piyv/7X//Z540ppLRDPUf3c9VERD7QXRfeH/BhjqEEM=;
 b=ou/sN/9fxmwj8bKHLPLXB8noQYK/VTwxQ1fvhieRBjVpK1tb+bLTMzgmjoY7MtxjfF
 ewCZyo6LFdP5p46LwOiEo+7hUJJ1XjoZo0cHrUscn8GLOM7Cdvl6r+pMldqfIZ4P9z3M
 BYemfEyMOb8nSPqZoJ6FyDNR3iHYeO4Znh3buH8DPkU72FJoYjcwmx7ls+Qai+S0PWyb
 b/jUH74uclgrHlNhZG6iEWasU0H0/dLuRkjQF2am8UccmOtWU/9Eo10U1r5SMCMQGD+i
 PnCSQYUPG+9drRJWkbZ0F90ARO4k13HQjUCHyQK8AgB/2mrj3/qiB70KmrBmJgzpvUOd
 whAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4JUrqj9eS+rRGeXlOB46a9QE1oF57PubqPMxvWAuLFNexeIaL8sKMerRvxL9lhM5JPKpudCv9Hj6U78wXjZfE/018n6I=
X-Gm-Message-State: AOJu0YzFHkBJUY4CMgVPIotDnvYvcqS9oBjtSYOxSC8SdA+WOVkTiyPz
 +C++IS+NTTlkFTwqOprP8RxGC2TMWP+G/0pVDrD0ckwvIZWSaQwgr2QB3ZoqRox3pfDAv3IAJfm
 0g/Vvkvi8lkYQ1piOYYez+Q2qUhZFzK+LAwvGuvre0SDqtoKP5Jxc
X-Received: by 2002:a05:600c:450c:b0:417:e090:4772 with SMTP id
 t12-20020a05600c450c00b00417e0904772mr5935280wmo.34.1713157919275; 
 Sun, 14 Apr 2024 22:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAXZHYjhT9yPTfFzD/q3ChBijZ8nnpeTLC4Y8BFHKNxkWgzyjYQUhxfMFemq9XBQ+xvnQm7g==
X-Received: by 2002:a05:600c:450c:b0:417:e090:4772 with SMTP id
 t12-20020a05600c450c00b00417e0904772mr5935272wmo.34.1713157918941; 
 Sun, 14 Apr 2024 22:11:58 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de.
 [109.43.179.142]) by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b004182b87aaacsm7208822wms.14.2024.04.14.22.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 22:11:58 -0700 (PDT)
Message-ID: <034118c4-55e2-4f89-82f4-129978974696@redhat.com>
Date: Mon, 15 Apr 2024 07:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tests/qtest : Add testcase for DM163
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-6-ines.varhol@telecom-paris.fr>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240414130604.182059-6-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/04/2024 15.05, Inès Varhol wrote:
> `test_dm163_bank()`
> Checks that the pin "sout" of the DM163 led driver outputs the values
> received on pin "sin" with the expected latency (depending on the bank).
> 
> `test_dm163_gpio_connection()`
> Check that changes to relevant STM32L4x5 GPIO pins are propagated to the
> DM163 device.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/dm163-test.c | 192 +++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build  |   5 +
>   2 files changed, 197 insertions(+)
>   create mode 100644 tests/qtest/dm163-test.c
...
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 36c5c13a7b..2c6fd4ebbb 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -207,6 +207,9 @@ qtests_stm32l4x5 = \
>      'stm32l4x5_rcc-test',
>      'stm32l4x5_gpio-test']
>   
> +qtests_dm163 = \
> +  ['dm163-test']

Do you plan to add more tests to qtests_dm163 later? If no, it might be more 
straight forward to inline ['dm163-test'] in the hunk below instead.

>   qtests_arm = \
>     (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
> @@ -222,6 +225,8 @@ qtests_arm = \
>     (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
>     (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
> +   config_all_devices.has_key('CONFIG_DM163')? qtests_dm163 : []) + \

With qtests_dm163 preferably replaced by ['dm163-test'] :
Acked-by: Thomas Huth <thuth@redhat.com>




