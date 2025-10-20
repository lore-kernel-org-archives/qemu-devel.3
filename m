Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244EBCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArT6-0000wc-8I; Mon, 20 Oct 2025 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArSS-0000QQ-M1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:06:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vArSN-00071R-Nm
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:06:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4680423f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972750; x=1761577550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgOMJoTicfKsz7xtEuFL3aj+NrZwpfQyJDHlE9GmrMw=;
 b=km9EmnIMWKKZr37aEYYGG2ofXfLC7LiXBH4QqjfU2LztOL04SYURktz28c5u80gVsd
 TAV6xmbU8RO23rT3XRU13u0xhuXCfLimFkm3gIW7rDKBLqCo4hl/ZqomVIDMRL5Dz7bt
 qArnBSDwJBX0yAlEnSCA61mUc5lZiOd7fsYQh+gXqpGHpGHcijVMAKNTzp8vzpQ1GEj0
 GaXHnQPHozaooYzNcbA7Ezr8gMnp1WbAxUkh2m2knPGVZfSGuXzSUiUKAyGFIRjIYWf6
 Ov57HGejzoJ0H3yaydUHRy5J5phtNqcmMIIxS/5vi+v/klUWzv8THmc7hwctdqaLisaI
 UEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972750; x=1761577550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgOMJoTicfKsz7xtEuFL3aj+NrZwpfQyJDHlE9GmrMw=;
 b=OQqIOzYNMY0AxXA6d4C0UvZIyur5YdLapqZlQP1+lBK2iyQGIE1xxrwxQkZMRFOmPB
 B0HcReS0aOexzt3YYJRPjIiFa/dSUaPrRGGjIEnGT20EX964/1NVuxF0kR6sBB4Mcjxq
 kEduBjG4VXL1HokTCbUeoYAAKIkK6e7iQHctTTp+V8iCwgd/1q6b4MEZJzQCo570qNro
 oKCI9FzQ8hI8FHXseYB+oe76khg5Cc0hz2xdji64GIefXLpFfBjhsFNf2HRsUYzgEUvG
 kQZB4lp/ejfkKYQ3Gtg3t7T4GxAp5nKN+lgzZ5Q10veE0bKZpE2BbQnFMEkJqlZy3EuH
 YIHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxzyNDO69oXZp3yHgsfw1qYGBoeR16LspwfNLLZ08YH3URKx13b8POABXUFYnZKWIv/3KIF3COXbl4@nongnu.org
X-Gm-Message-State: AOJu0YxVUqKsIu3iCP17IA8s87GiyENLcZ9WbRxxB3zfFSplo03qaOD0
 +52zXoBK/FKQjt47ka/6L3KczemNmi/ER/3XnFLisgLxbpfeBHfLA4+iNsm5yI9lGLo=
X-Gm-Gg: ASbGncvIn83OZGDKA9wZ/YYxapH2//tCKcYhWerlbc0B18FLEZz7vWslmNOSojb3cDW
 f3WgiCFCWeNwTsLdORP1AzbZF51aQv3DBZf9q2ak1peI+NDbudlEUnaMH5Lyq8zo7lBODFAFGeq
 xQvF9oMw7x53GJG/2MtFaoZw7HIHao5QIBg2HVkxlJYAkQt0ngjHGEEXPXxKXELnSEJmKNTIf7X
 oOjg1lYFvpqpgK0eiYOqDqaPaQFnBupQ2IXVmZkZL9QjO9sX+gOtrLN1hZaEGmtvWb8X3r6exv6
 ORk3uG8++7wkRfhD7UA2HtppIfRxJyAioGb9d9LcvaaGzOyZwtCE5jr0kRz0CmcpHfEY/2Xrmz3
 xP2LTy766et91A4J3+aKzaQLUm9rL6TkYK1ISM+T6wP9i3z1l9weEvmG2SGsZEoa9vHWsAXkjvs
 4s/8W22oidYt6wr3gviN6S+c6oPtmc6aCAQ1RkUGpRc6kh8tXmo950MvTUPEN8Hft3
X-Google-Smtp-Source: AGHT+IHvgSt8zUfZ6EeU41h89FcjQdqHL6nPnxcsCZYm/a51k8W8kfqQYxcUdIkYxl+c3JneAr8l6Q==
X-Received: by 2002:a05:6000:420e:b0:425:72a0:a981 with SMTP id
 ffacd0b85a97d-42704d830aemr7776700f8f.2.1760972749737; 
 Mon, 20 Oct 2025 08:05:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a75bsm16064304f8f.23.2025.10.20.08.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:05:48 -0700 (PDT)
Message-ID: <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
Date: Mon, 20 Oct 2025 17:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster
 <armbru@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 18/10/25 17:11, BALATON Zoltan wrote:
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
> index 665b620121..fd3d549ff5 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -762,7 +762,8 @@ struct MachineState {
>           } \
>       } while (0)
>   
> -#define DEFINE_MACHINE(namestr, machine_initfn) \
> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
> +                                machine_initfn, ABSTRACT, ...) \
>       static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
>       { \
>           MachineClass *mc = MACHINE_CLASS(oc); \
> @@ -770,8 +771,11 @@ struct MachineState {
>       } \
>       static const TypeInfo machine_initfn##_typeinfo = { \
>           .name       = MACHINE_TYPE_NAME(namestr), \
> -        .parent     = TYPE_MACHINE, \
> +        .parent     = TYPE_##PARENT_NAME, \
>           .class_init = machine_initfn##_class_init, \
> +        .instance_size = sizeof(InstanceName), \
> +        .abstract = ABSTRACT, \
> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \

IIUC Richard asked for array argument in order to save .rodata?

>       }; \
>       static void machine_initfn##_register_types(void) \
>       { \
> @@ -779,6 +783,14 @@ struct MachineState {
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
>   extern GlobalProperty hw_compat_10_1[];
>   extern const size_t hw_compat_10_1_len;
>   

