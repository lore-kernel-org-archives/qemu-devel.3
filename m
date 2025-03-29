Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FE8C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 17:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyaD7-0005MN-V7; Sat, 29 Mar 2025 13:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyaCz-0005LJ-Cp
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 13:43:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyaCw-00013N-Iy
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 13:43:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so23322855e9.1
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743270175; x=1743874975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mu6F53k+sRJXMBjrtV59HJm2oKuw94xXvTjdcGnK3ag=;
 b=RTG1YeRjleEh/bf44ooPmujanahofPb/6ka1s9R/hv1cKVCc8Pzkdb2O0DqkjY7EAF
 v5g6nLobWMF2WKdxERCmIAxYVtWg52udoj1HxjJiJXb+q6RUCZFvn6nJqjXihhmDVG3C
 wn09aysXlyfox8EeEFmQNa0nZLtr8NzuerRG39hUfY5LMI5ct5jdgp4NluxxdTaJwFGs
 9EtSVPmrpXa0j3CqET89MaAPUUcgUZrPszbEXqaa1cWb53rGBctbDioVQRMW+fJuBc94
 B8tppMlIPd4SaPpGPmx2sRu+rBWppBmhZwlppm2ttMemnlx3aUI5dA5jF3Zu+pfL4uUb
 cTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743270175; x=1743874975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mu6F53k+sRJXMBjrtV59HJm2oKuw94xXvTjdcGnK3ag=;
 b=N8/BfFCErwlQzAjDjWFZRtpTvM/z0LQAW+27eD78vHX32pAGt148BaWVGrAFIWikv3
 Y3SXwH25pbLa9L0bBe9wtWiv9LCOHacAEBILHgVvJqXcMXdH4IQfV5bTolDRPc/2UCp6
 nzO2wjmXlZABVtd3iggjaS6l/KYkcqR4kz5BQvW2brj6GW8Hk9ZvBjDog3ZJmooxABKc
 sNqy7MJt0bfM94bih3x5/ZgQxyuo0fWMBl1wX0f8CxXkfZckjr4g7xlnrs5e8hxgpQRb
 TSKVQNi6AcaC4hU7Z12VO0LSNnp7dMMF29cZ7tuqAStxugmJgb47FMM0sfUuG7r7YI/p
 9KFQ==
X-Gm-Message-State: AOJu0YyGghzvm5cBLtCsqwvC0pabKEhuDYn6BnBAN7OxHHneqT0vsAd/
 5Bfd8Rcz4cM7wXmmog8zAUCCTWlKymjLVypM7wsyIQKsUz/4hNC19t+ZHmZlMHvXwMRcBfgv2NY
 rPb8=
X-Gm-Gg: ASbGncsUld9nrE8k7SSGhwNYHE5EJ6Z1lzqosPg65FAclGJNg0NspIHLeCfH9uB41T7
 ay1EZM6mkxv9zVL5LsZ4BGOcuyl2h+W5mzdmlX7GWTPsmVZS5sGHVzwnPUs4LR7JdYSXfl0gy5s
 XjWhPX3DDhiZm7HY0hQ8ETIB1jrVfHhA3Z10tsB73devxY7uKM2WLbHRC9BT8uOMTFqdA7MtVXg
 EI4TsBuB+8r1jE5LzfMiaubUVAd9bjRzYF5Why746NNt/ogTzLw2fOrfnrBJW47lyonTBOFI5TZ
 jTtiSDcBCoaO2nwFLdrC1pQ7pp3uw2TT5kaMCkeNe0tTkMVOBqCh7ug=
X-Google-Smtp-Source: AGHT+IE62imiRtZ5eXMyhOYzfc7Dny1jqoZfsa+HoWsnH94+6U8ihuIGeppC0wKBqMcD5Ff3/2T+lg==
X-Received: by 2002:a05:600c:3552:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43db61d05f7mr34014875e9.8.1743270174644; 
 Sat, 29 Mar 2025 10:42:54 -0700 (PDT)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba3e44sm70961425e9.4.2025.03.29.10.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 10:42:53 -0700 (PDT)
Message-ID: <050f086b-be7c-4ec3-a67d-f2b183750ef8@linaro.org>
Date: Sat, 29 Mar 2025 18:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250329142641.2502003-1-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250329142641.2502003-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Aditya,

On 29/3/25 15:26, Aditya Gupta wrote:
> Power8E and Power8NVL variants are not of much use in QEMU now, and not
> being maintained either.
> 
> Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
> 
> Deprecate the 8E and 8NVL variants.
> 
> After deprecation, QEMU will print a warning like below when the
> CPU/Chips are used:
> 
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
> 
> Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
> --cpu ?':
> 
>      $ ./build/qemu-system-ppc64 --cpu help
>        ...
>        power8e_v2.1     PVR 004b0201 (deprecated)
>        power8e          (alias for power8e_v2.1)
>        power8nvl_v1.0   PVR 004c0100 (deprecated)
>        power8nvl        (alias for power8nvl_v1.0)
>        power8_v2.0      PVR 004d0200
>        power8           (alias for power8_v2.0)
>        power9_v2.0      PVR 004e1200
>        power9_v2.2      PVR 004e1202
>        ...
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> Cover Letter
> ============
> 
> Power8E and Power8NVL are not maintained, and not useful to qemu, and
> upstream skiboot also has removed support till Power8 DD1.
> Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> to be exact:
> 
>      commit c5424f683ee3 ("Remove support for POWER8 DD1")
> 
> No direct way to deprecate the pnv chips, a field like deprecation_note
> could be added, but felt not needed as the chip will only get used if
> the user requests corresponding 8E / 8NVL CPU, which will print
> deprecation warning.
> 
> Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> which will throw the deprecation warning. So just deprecating CPUs should
> be enough.
> 
> Changelog
> =========
> v2:
>    + add mention to docs/about/deprecated.rst
>    + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
> ---
> ---
>   docs/about/deprecated.rst |  9 +++++++++
>   target/ppc/cpu-models.c   | 17 ++++++++++++++---
>   target/ppc/cpu_init.c     |  7 ++++++-
>   3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e2b4f077d453..d6b39db2aaca 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -275,6 +275,15 @@ embedded 405 for power management (OCC) and other internal tasks, it
>   is theoretically possible to use QEMU to model them. Let's keep the
>   CPU implementation for a while before removing all support.
>   
> +Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The Power8E and Power8NVL variants of Power8 are not really useful anymore
> +in qemu, and are old and unmaintained now.
> +
> +The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> +be considered deprecated.
> +
>   System emulator machines
>   ------------------------
>   
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index ece348178188..6f2062e2c484 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -32,17 +32,22 @@
>   /* PowerPC CPU definitions                                                 */
>   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
>       glue(glue(glue(glue(pvr, _), svr), _), type)
> -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _is_deprecated) \
>       static void                                                             \
>       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
>       (ObjectClass *oc, void *data)                                           \
>       {                                                                       \
>           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> +        CPUClass *cc    = CPU_CLASS(oc);                                    \
>           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
>                                                                               \
>           pcc->pvr          = _pvr;                                           \
>           pcc->svr          = _svr;                                           \
>           dc->desc          = _desc;                                          \
> +                                                                            \
> +        if (_is_deprecated) {                                               \
> +            cc->deprecation_note = "CPU is unmaintained.";                  \

The CPUs deprecated in this patch are indeed unmaintained, but maybe
future deprecated ones will have a different reason.

Maybe use s/_is_deprecated/_deprecation_note/, so passing a NULL
deprecation note is OK?

           cc->deprecation_note = _deprecation_note; \

> +        }                                                                   \
>       }                                                                       \
>                                                                               \
>       static const TypeInfo                                                   \
> @@ -63,6 +68,12 @@
>       type_init(                                                              \
>           glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
>   
> +#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, false)

        POWERPC_DEF_SVR_DEPR(..., NULL)

> +#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc)                   \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type, true)
> +
>   #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
>       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
>   
> @@ -722,11 +733,11 @@
>                   "POWER7 v2.3")
>       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
> -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
> +    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
>                   "POWER8E v2.1")

        POWERPC_DEF_SVR_DEPR("power8e_v2.1", CPU_POWERPC_POWER8E_v21,
                             POWER8, "POWER8E v2.1",
                             "CPU is unmaintained")

>       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
>                   "POWER8 v2.0")
> -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
> +    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
>                   "POWER8NVL v1.0")

        POWERPC_DEF_SVR_DEPR("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,
                             POWER8, "POWER8NVL v1.0",
                             "CPU is unmaintained")

>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7decc09aec8f..fade53f7e2d6 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7143,6 +7143,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>   {
>       ObjectClass *oc = data;
>       PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
>       DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
>       const char *typename = object_class_get_name(oc);
>       char *name;
> @@ -7153,7 +7154,11 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
>       }
>   
>       name = cpu_model_from_type(typename);
> -    qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
> +    if (cc->deprecation_note) {
> +        qemu_printf("  %-16s PVR %08x (deprecated)\n", name, pcc->pvr);
> +    } else {
> +        qemu_printf("  %-16s PVR %08x\n", name, pcc->pvr);
> +    }
>       for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>           PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
>           ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);


