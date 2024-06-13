Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo4r-0007jL-RF; Thu, 13 Jun 2024 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHo4q-0007ii-GJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:17:32 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHo4o-000508-Lp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:17:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so171526866b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299048; x=1718903848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Tq6k/P8sj3apWueJ7BowwJEvNn9S3ULw4LNW86ZuZw=;
 b=bIEHa0kLogyMFPgvluo8Cd5pUwOc/Ex1mCwFwSqZtB+NljodX7CRkF+YqSodRusarN
 YKUSiIufu1sbmk9p34MrRdxCGNCMkWeb+C+yFNnfRjhQefHKDqF0yIGDGwf08DQPR5SY
 wXzC6rQO0Cc3dqP/NNCjAi4Iow4dYVZzVDfZwNFCYbWwHgPYn9HYDm8baYIOrhU7Ahv3
 X3NQt+VHO4WL53jqYQTrTV/uUdEJx2qdW1VK7KlaAHrYyTkI4Y5u2O+WXAXDO4YzenSt
 StIgXypwauSOtQ1StDi9UmUYtmh8tqGlw8fowpZr71jkeTwDAlrqsSqVmwKn0V8KqCOE
 SLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299048; x=1718903848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Tq6k/P8sj3apWueJ7BowwJEvNn9S3ULw4LNW86ZuZw=;
 b=GwKWLWgaxR3rwfNmwRjhSkLy8Sr8CM70n+B2rEhTSTeWWt/MqrzI6NTnmu1MDwA+Mo
 KbdfeUe/T7nJRZlxARW+XgoElT36P+plPERyyBer8/bjCd5kv5DkzjvdmU6l7jamj5He
 lVUQ6FMBCZtTsEM9Ec2oz7Qk9GyYXYHtxNWT2T1xWvK1Kjz22Nqdvl2Ssr2O9d6aPaHQ
 3VBfX1otQrvx0o4m9IrBw2PYupN9LMrmCXps05+E4iSSpH2K0Z/c949ZxuKk4Q7hKPb1
 6IbRbasxS2inl4CVMON24rcGspyUavF4xiWJiQ/ZUZx8d5j6J8QoCilWoVAasgNCCVY6
 4b0Q==
X-Gm-Message-State: AOJu0YwjhvrvkQ4HMc1DCiF8YWE+1VY/INNpN6lByvyT0tE6rddHH3pu
 nSU5L2UngxZywJhUb3aV6L4IdtJYkU6fD0qrgmaBVg+6v6EvBBWsuSCAbYKxfP4=
X-Google-Smtp-Source: AGHT+IFC3Cs/WrEFLW1lbMkP1SAeeb7124my62Hv3YkR5Y23eeXXXcTU1Ol36AJihYVZyR7Qk/UAnA==
X-Received: by 2002:a17:906:f2da:b0:a6f:5562:167 with SMTP id
 a640c23a62f3a-a6f60d42710mr28697266b.38.1718299048503; 
 Thu, 13 Jun 2024 10:17:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41700sm91291666b.152.2024.06.13.10.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 10:17:27 -0700 (PDT)
Message-ID: <856c9c4e-8e8b-4d63-a897-ee80fb7ed92a@linaro.org>
Date: Thu, 13 Jun 2024 19:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240613170702.523591-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613170702.523591-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Thomas,

On 13/6/24 19:07, Thomas Huth wrote:
> Old CPU models are not officially supported anymore by IBM, and for
> downstream builds of QEMU, we would like to be able to disable these
> CPUs in the build. Thus add a CONFIG switch that can be used to
> disable these CPUs (and old machine types that use them by default).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   If you're interested, the PDF that can be downloaded from
>   https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
>   shows the supported CPUs in a nice diagram

I'd add this link ...

>   hw/s390x/s390-virtio-ccw.c | 9 +++++++++
>   target/s390x/cpu_models.c  | 3 +++
>   target/s390x/Kconfig       | 5 +++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
> index d886be48b4..8a95f2bc3f 100644
> --- a/target/s390x/Kconfig
> +++ b/target/s390x/Kconfig
> @@ -2,3 +2,8 @@ config S390X
>       bool
>       select PCI
>       select S390_FLIC
> +
> +config S390X_LEGACY_CPUS
> +    bool
> +    default y
> +    depends on S390X
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index efb508cd2e..ffae95dcb3 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -22,6 +22,7 @@
>   #include "qemu/module.h"
>   #include "qemu/hw-version.h"
>   #include "qemu/qemu-print.h"
> +#include CONFIG_DEVICES
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/sysemu.h"
>   #include "target/s390x/kvm/pv.h"
> @@ -47,6 +48,7 @@
>    * generation 15 one base feature and one optional feature have been deprecated.
>    */
>   static S390CPUDef s390_cpu_defs[] = {
> +#ifdef CONFIG_S390X_LEGACY_CPUS

... here :)

>       CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
>       CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 900 GA2"),
>       CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 900 GA3"),
> @@ -78,6 +80,7 @@ static S390CPUDef s390_cpu_defs[] = {
>       CPUDEF_INIT(0x2964, 13, 1, 47, 0x08000000U, "z13", "IBM z13 GA1"),
>       CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
>       CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
> +#endif
>       CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
>       CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
>       CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3d0bc3e7f2..7529d2fba8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -47,6 +47,7 @@
>   #include "migration/blocker.h"
>   #include "qapi/visitor.h"
>   #include "hw/s390x/cpu-topology.h"
> +#include CONFIG_DEVICES
>   
>   static Error *pv_mig_blocker;
>   
> @@ -603,6 +604,8 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>       s390_cpu_restart(S390_CPU(cs));
>   }
>   
> +#ifdef CONFIG_S390X_LEGACY_CPUS
> +
>   static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
>   {
>       /* same logic as in sclp.c */
> @@ -623,6 +626,8 @@ static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
>       return newsz;
>   }
>   
> +#endif
> +
>   static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
>   {
>       S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> @@ -989,6 +994,8 @@ static void ccw_machine_6_1_class_options(MachineClass *mc)
>   }
>   DEFINE_CCW_MACHINE(6_1, "6.1", false);
>   
> +#ifdef CONFIG_S390X_LEGACY_CPUS
> +
>   static void ccw_machine_6_0_instance_options(MachineState *machine)
>   {
>       static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V6_0 };

Should we deprecate machines up to v6.0?

> @@ -1272,6 +1279,8 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
>   }
>   DEFINE_CCW_MACHINE(2_4, "2.4", false);
>   
> +#endif
> +
>   static void ccw_machine_register_types(void)
>   {
>       type_register_static(&ccw_machine_info);


