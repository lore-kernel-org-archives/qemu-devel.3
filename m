Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D67C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtM7-00063q-Vn; Tue, 10 Jun 2025 03:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtM1-00061B-No
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:25:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtLz-00028E-B1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:25:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so52900395e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749540300; x=1750145100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3MEwu1G24RAH8qykiYRrWXw5DqJbL4XZ+JYFstXA6J4=;
 b=s3Y6dIVeih9Z12Zj+AeTdpxkcs3CVC4cgM4wWmzubb7Crv7UAZcI/Cuuolp+XGEoJv
 W1PTQu+KB7+4/CR+a69bcIXDikjDWmo9LppV2bYF0y6AyJziyaeJ3boi0t4b8k4EH6+6
 d+UO3EAHvZ83RwvKHDdJ7J1n0R2asZsy7LjLREuUJ6JgKPdIvfXTBkNMW8Z6ylzRVBE6
 fzNMCi41XLKLNo2uB9sLq32NR8h5raDuOeHUmhheSafQ71vIv9vA53Sr+/amSjIIDLjE
 FKOzNroL2FUmRC2v0FkgkM2ccsi3HZ0Gs0nwjKXgc0NB2se/SxbTwqMviNw6qTitXoHv
 Q5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749540300; x=1750145100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3MEwu1G24RAH8qykiYRrWXw5DqJbL4XZ+JYFstXA6J4=;
 b=IlvbUyiPYvZWFyTZQU5TjtgEKl9hTpnJlGoiqb+EnGKZKRUHrUAsdSFokV9CvsNEJc
 RjaGRV8DuExVqxlno9iMExPCgOxzpTQSzlBKuETklInzSRjUjSomVKkYXm5JxKM+Ave2
 u8C5n8JObEMCB3K+hOa5jtjjKHq58ITisx2/HNfSVuQqS+2FhBEBxNSA7ZI7n6LTWupR
 gaczsUsrT31SG7sahhD81Ev23GgJQeTHnwK0TlALbEoczXStPjUPaEn0PaRc5NmI8JK9
 4pm7GOCTaz/Ts8Vjq6IBIgJM13BX0aWrWoDsbW1jcWk60k3vLeh65RRNmuo8rpVZng9Z
 V+4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/h1+PMWvJjBYOtHl8MCkX1YhO43Ua3eE9Xl10g3cCb6W2FsvpL2fhHuN5MjS/vrP9hbjgHc6+hNj@nongnu.org
X-Gm-Message-State: AOJu0Yx1NiacJ9EUEgyo371Kj47EgrQJ57QXz/hQ/teW65MYay4VAewc
 LdCg73BTm8WYddPIWDLvYn2qAnJYSZjkvh2r5wCQssrVmvlVYUXuke8jaNDg/74w3GE=
X-Gm-Gg: ASbGnctYhHSqI2E/P7f6lYEmyl14AlPJzdcjlQPw2kY9ii5ljtRTUrFoMaNwYleDivd
 C9eWBNEHpQBzJ/i2PoKoaCM4VWZOPuMZnl7L/jkPajUIRXot1YdEMThVevBPNjxc7ygR5CZppgw
 3OzFEQ69LwYWvOyAmtCZEtwWXqg+bu11bGWHMgEJAGMxc9s9SLg/WoaESahUq+0ksf+CP3Sci1L
 rVH8aGmAbYeXEgIIt8JIQLlwjLOFgfUfmTnHK4fin87JKNAnUDE5tgFN1suCefO8q4lf0OEqZMV
 SqrG6oVw+ovdHyRDVB8MdLqG216PXzHmr7tq2cFIoiX5P+lZvcWI/FH7sPQpnVuUQ+Or4XVAYRc
 LWR8fdFH7KzgwKMwRw1BN5rR8eMO64MQpW9o=
X-Google-Smtp-Source: AGHT+IF7XUBTgy2q4VmPEkXUy/A4mdI1XYBWWzH/lPhfRwcq8IdgEBubOz9hVuXynlcjxM+xP9zhdQ==
X-Received: by 2002:a05:600c:34c8:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-4531de8efcbmr11332975e9.27.1749540299887; 
 Tue, 10 Jun 2025 00:24:59 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e0563cesm134479425e9.1.2025.06.10.00.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:24:59 -0700 (PDT)
Message-ID: <6b7aa048-bdb7-40a4-995a-9257afc99708@linaro.org>
Date: Tue, 10 Jun 2025 09:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1746139668.git.balaton@eik.bme.hu>
 <ad355178b2a3fe285854ed2e25b288baf0fd6e05.1746139668.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ad355178b2a3fe285854ed2e25b288baf0fd6e05.1746139668.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 2/5/25 01:20, BALATON Zoltan wrote:
> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
> versions with less parameters based on that. This is inspired by how
> the OBJECT_DEFINE macros do this in a similar way to allow using the
> shortened definition in more complex cases too.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   include/hw/boards.h | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 765dc8dd35..6e52d4d10c 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -744,7 +744,8 @@ struct MachineState {
>           } \
>       } while (0)
>   
> -#define DEFINE_MACHINE(namestr, machine_initfn) \
> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
> +                                machine_initfn, ABSTRACT, ...) \
>       static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
>       { \
>           MachineClass *mc = MACHINE_CLASS(oc); \
> @@ -752,8 +753,11 @@ struct MachineState {
>       } \
>       static const TypeInfo machine_initfn##_typeinfo = { \
>           .name       = MACHINE_TYPE_NAME(namestr), \
> -        .parent     = TYPE_MACHINE, \
> +        .parent     = TYPE_##PARENT_NAME, \

As it doesn't save much, lets simply pass the full PARENT_TYPE,
not PARENT_NAME. But, do we really need it?

>           .class_init = machine_initfn##_class_init, \
> +        .instance_size = sizeof(InstanceName), \
> +        .abstract = ABSTRACT, \
> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
>       }; \
>       static void machine_initfn##_register_types(void) \
>       { \
> @@ -761,6 +765,14 @@ struct MachineState {
>       } \
>       type_init(machine_initfn##_register_types)
>   
> +#define DEFINE_MACHINE(namestr, machine_initfn) \
> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> +                            false, { })
> +
> +#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
> +                            false, __VA_ARGS__)
> +
>   extern GlobalProperty hw_compat_10_0[];
>   extern const size_t hw_compat_10_0_len;
>   


