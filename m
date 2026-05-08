Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B42CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLRbB-0004iC-Rp; Fri, 08 May 2026 16:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRb8-0004hy-Fs
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:14:58 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRb6-0003rD-ML
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:14:58 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d5ff103aso1219655b6e.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778271295; x=1778876095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZeL0Nlg4QmoiwWDyXfMMtEXTtzNVeCbdguDZxGWLfQ=;
 b=genrV6QysuiCtXbPDU0K8BMGI5WnZLh0xxVCk374tD6B5KvFwAhVlnTdeTxIcMm7DM
 txdDCldJWAtd+7ipSELWILeZnj3z9oswqIWkItApTWngEPv9g/Ghh6ZLu++zbWYJ+iRY
 UuRSu64jiDJohoyVCkthax0iXo25HTEY0dXgwK7lsrbNvkL+RWVEyn288K+eI0Q8cfiP
 ExCQrSqxacrF48fTfTeiG7PbrwJyQbWk+T+Byq8u5l/Xu5Xngv3K7bbXr5JT7f/VSklC
 NhVV1JDRvfZuxKWISJYQ8FnKj8oYgpWtr25fDtxLU//nnfAhNu1NHPjEh3W5RmYdoj2e
 gTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778271295; x=1778876095;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZeL0Nlg4QmoiwWDyXfMMtEXTtzNVeCbdguDZxGWLfQ=;
 b=hJ81wXhxmZOrMp2fs7D6XVyS8IB8XcowIGHpDHYfxn5YpUU9lBB80Q5UP8OH5rekwr
 2ePhzVDbgHoALoH9F38R9jHPIqJt14fLMfd8sR/qAB0+FZZIAF0/DbLa+uA9l88HVbHj
 V4POuKccZ7zUCHBNBll4Nm9kEMsX4lJ8QF7s9/MTYapZYhS0jKbpvhVF8Cbv40IUS/lM
 r15lynKkJRe/YUG5MAsP9L1lKpzBgX6rBRJa36jGi90JBc79ghfaAoVjxmvjb7h9Hv5Z
 fdwSOVlieUiWzrhB/8BEhzCXrPEZ+jvYLpAYYwWFJpT00NxG8f6/qK8jZFL6rkJinQOB
 iqUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jU77j4/jXXWAp95feO1ork2GoUw2PQHhlv04GHqxMYO0M9QPY6hrHli60fQb+P0fxRgvzAM4ueCGf@nongnu.org
X-Gm-Message-State: AOJu0YwBltS/PQq1lBxrqcXVoJtgbB/Mz7R9wl2lAqYhPIEZoPGDcx3U
 E+9HP9vB1aPJnHIxl+6VKervFOUVZSmJIYhLt/iiDTLD3aBbKvPUrqLU4lVGce121JE=
X-Gm-Gg: AeBDievMBH3s4tq8MmmzVfLNUhGA17MzR336LUEBHoIokdjlDhL6IURqIC9kBqGWifd
 mA0ObMxPR/JY3ZGB8LVzD5yEt9T6iW3aZMWASKWzlN5h7gwKHYjCe7fB+gEoccEp/VE34ao/wjc
 TD0r0o1xtRIfUmxbNG5r+PAACUODtA9d0VLXujoxOMONYKS1/IEZdiVXxWrWznJd248MLdqAuKw
 SKo1W7pUjMDLz9jJMCzXIfugdUFykVYPMQjNNP6B0hLdxJTDCHNrAZuatpj/Hl2FoGjcQAa1hG2
 fc3VY8H8bt96eN9OqD6JQtTWeXHESQUVchEXbMO6jzFfo/LyKLwKFfuZvklWEoe0dFrT5oTVOeB
 EzGLJleATYM8kI4RSKdQZizA6IVo5tbAcxHmr7os1dVBMRVquaCPI6xNmF8gRzDL74e7sLRCj4d
 rd1DlEKRax6exL3Zf+SVlnN9RGa+dlPmwvzC2b4xan7/PmnANzxMIODzeG6Pcy5YKZMA/z6ZbJF
 pyQurnraEjNFpg38A==
X-Received: by 2002:a05:6808:c147:b0:479:fb10:1299 with SMTP id
 5614622812f47-4807fd39577mr2653053b6e.29.1778271294667; 
 Fri, 08 May 2026 13:14:54 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b33c1sm15358301b6e.1.2026.05.08.13.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:14:54 -0700 (PDT)
Message-ID: <3c379e6b-2009-4f7b-92df-c69c31897279@linaro.org>
Date: Fri, 8 May 2026 15:14:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] target-info: introduce TargetInfo in QOM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
 <20260505224826.2698753-5-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505224826.2698753-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 5/5/26 17:48, Pierrick Bouvier wrote:
> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
> index c781cfc0590..859451c672e 100644
> --- a/include/qemu/target-info-init.h
> +++ b/include/qemu/target-info-init.h
> @@ -12,10 +12,67 @@
>   #ifndef TARGET_INFO_DEF_H
>   #define TARGET_INFO_DEF_H
>   
> +#define DEFINE_TARGET_INFO_TYPE(info)                                       \
> +static void do_qemu_init_target_info(void)                                  \
> +{                                                                           \
> +    type_register_static(&info);                                            \
> +}                                                                           \
> +module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
> +
> +#ifdef COMPILING_PER_TARGET
> +#ifdef CONFIG_USER_ONLY
> +
> +/*
> + * User mode does not support multiple targets in the same binary, so just
> + * define target_info().
> + */
>   #define target_info_init(ti_var)        \
>   const TargetInfo *target_info(void)     \
>   {                                       \
>       return &ti_var;                     \
>   }
>   
> +#else /* CONFIG_USER_ONLY */
> +
> +#include "qemu/target-info-qom.h"
> +#include "qom/object.h"
> +
> +#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
> +
> +typedef struct TargetInfoQomTarget {
> +    TargetInfoQom parent;
> +} TargetInfoQomTarget;
> +
> +typedef struct TargetInfoQomTargetClass {
> +    TargetInfoQomClass parent_class;
> +} TargetInfoQomTargetClass;
> +
> +OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
> +
> +#define target_info_init(ti_var)                                            \
> +const TargetInfo *target_info(void)                                         \
> +{                                                                           \
> +    return &ti_var;                                                         \
> +}                                                                           \
> +                                                                            \
> +static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
> +{                                                                           \
> +    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
> +    klass->parent_class.target_info = &ti_var;                              \
> +}                                                                           \
> +                                                                            \
> +static const TypeInfo target_info_qom_target_type_info = {                  \
> +    .name = TYPE_TARGET_INFO_TARGET,                                        \
> +    .parent = TYPE_TARGET_INFO,                                             \
> +    .instance_size = sizeof(TargetInfoQomTarget),                           \
> +    .class_size = sizeof(TargetInfoQomTargetClass),                         \
> +    .class_init = target_info_qom_class_init,                               \
> +    .abstract = false,                                                      \
> +};                                                                          \
> +                                                                            \
> +DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
> +
> +#endif /* CONFIG_USER_ONLY */
> +#endif /* COMPILING_PER_TARGET */
> +
>   #endif /* TARGET_INFO_DEF_H */

If I understand this correctly, you're getting one symbol passed down as the argument to 
target_info_init, and you're getting another symbol implicitly from TARGET_NAME.

AFAICS, this is incorrect for the configs/targets/*.c versions.
Or at minimum really confusing.

I'm trying to work out how target-info-stub.c and the configs/targets/*.c files can be 
unified.  Perhaps we have one large macro like

#define DEF_TARGET(NAME, ARCH, BITS, ...) \
static const TargetInfo ti = {            \
     .target_name = NAME,                  \
     ...                                   \
}                                         \
static const TypeInfo type_info = {       \
     .name = TYPE_TARGET_INFO "-" NAME,    \
     .class_data = &ti,                    \
}

Note as well that we can use .class_data and .class_base_init to avoid having lots of 
those trivial class_init functions.

Another option might be a .c.inc file which uses TARGET_NAME etc, which we then locally 
#define for the {arm,aarch64}-softmmu.c files prior to the #include.  I can see that might 
have to jump through hoops to avoid poisoned identifiers, but perhaps

---
/* Avoid poisoning identifiers we will supply locally. */
#define COMPILING_PER_TARGET
#include "qemu/osdep.h"
...

#define TARGET_NAME "arm"
...

#include "target-info.c.inc"
---

isn't too horrible, and in the end more readable than a mega macro.


r~

