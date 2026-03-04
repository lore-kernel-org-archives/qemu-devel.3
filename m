Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3600BEDEBFF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 02:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxc8x-0005kR-FJ; Tue, 03 Mar 2026 21:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxc8p-0005jy-5a
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:39:15 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxc8n-00021t-38
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:39:14 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-5fdf71f3327so5126053137.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772591951; x=1773196751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T2Hy5vODgk0ZornaPFlnwaS9qH3Awx2gy0GqbKNWQqc=;
 b=hdXoF0p0W88HxcqcUauKfOp++FtmfS/GSHuxq7Umue3I1W+RrlZqjrCYtUYFHg+eMa
 S3S50CjFysDZ8ak3HmwqhoQvCuNJGTZxH2IYeCgvlqPZnszYPjNiyvNShIe3CXZRQvaq
 GbC9LZLacULBh3XGWKoIEVthviDtN+KEZ6GI3r7l1SOE8/LjEW/E5ZX91QWsjMox2Gvp
 SXamYBvt6AmO4PWDZdV5c4jFXc7rUMtKcZY6yui0JGe8NBAKkZ+kS8muyxp5CXwoexuN
 XhsWy6uC71NmLDNcsXKOlpIEezHA1sDH7C4BpyjbE8Y5oBJFw0QYWpW8iN8rFu/uS2rm
 inzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772591951; x=1773196751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2Hy5vODgk0ZornaPFlnwaS9qH3Awx2gy0GqbKNWQqc=;
 b=UEUpjAf7poTX9fI6u0HNelfKiWrXf9/j8O2AblCiZGpi2niXndJ2eP+0uLhnU9FbcY
 fiarQrY2IPR603G9BXQzfNLUZACGR7w7SktuZd0mS/i/MCfKd5YeokI5MFGg9e8LGVD+
 LOrYRrGYV17FJlPNuQ86H1YHUBylDFlYeD3AI214X3+t0ajsmLxzUBXCgCRLE5UQgvUX
 KlOfr9I/uQm/sTwQ7a69/bYkpJ9yreSvCrKq/SCzP90kgGr/mR2wHUgKr5v+8vL1sHat
 JQ+RXnXpiCt9XbhLMk3GMDXdb52jJBpUgP3hCSYMYNptKU9CM23T3wi0yb1GAQFHeqom
 DDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2osPNv7r1UkChCTflj0Wbsj8Wh0EOWAHwklMmlOLVqh2nESnd9LB4lny337OnPSHw0d3W4H9UZNiQ@nongnu.org
X-Gm-Message-State: AOJu0YwmSl+VkSb604f9COwb5BKV0ywoO8c77mm4EdIY1Vfes6SaPsZp
 QEsWzVp5hDnVT9/ejxukm30qSCuabG4i4VziqPyoxu90ZjXHhDfXR1iBWsiJ75KAN54=
X-Gm-Gg: ATEYQzzKO042kaZ5oylJ7HQgz55qHI1It4JHTZWeWzomfYJo0RZ8OD8jVGnvJ5eRNxS
 eBhYaGYrleQfsrp4oz9lFWDXtPXMpQLHTPAJ7vea2svLPhIFkqFVqBOl8mPfordkYhGYRnlKMA6
 8epV4wQOXDhwmWQzkN3f5VQnnZF2FlD2caoIdQ4K+wOom4T6GrxDZCQP0mHjnUoj1EB6Bt8o/lW
 oEMXf3SW0PAKnIU6qjhXUCGcsTdyAUJen/Aqz2rqH8S2v4nDrJAA+PgRsW0lr4vfLund7cSPbu4
 ylaPTQq5l7M39TBPrVTomPI2eOJNSDrktcyx6YBqoMriW2XAbHxbv+RkderePFdd0Gk6Rc0XQCq
 8NxFX/f03jRPmrO7ctlafInBqEojBH6urnAWl3miY+vOugYhr0ElMTT9PordPM7Q+IijmUpdKhI
 pLUJTVILBVldaaC3Bz8aaUd0XtElbGAbLC
X-Received: by 2002:a05:6102:c04:b0:5f5:3739:100d with SMTP id
 ada2fe7eead31-5ff8f555c1fmr2036577137.0.1772591951183; 
 Tue, 03 Mar 2026 18:39:11 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94df645b877sm16831501241.8.2026.03.03.18.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 18:39:10 -0800 (PST)
Message-ID: <91570f1c-3579-4b82-8252-6d29bc7d2f6e@linaro.org>
Date: Tue, 3 Mar 2026 23:39:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/8] hw/core/machine: topology functions capabilities
 added
To: Alireza Sanaee <alireza.sanaee@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
 <20260220141128.789-3-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260220141128.789-3-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2b.google.com
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

Hi,

On 2/20/26 11:11, Alireza Sanaee wrote:
> Add two functions one of which finds the lowest cache level defined in
> the cache description input, and the other checks if a given cache
> topology is defined at a particular cache level
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   hw/core/machine-smp.c    | 52 ++++++++++++++++++++++++++++++++++++++++
>   include/hw/core/boards.h |  5 ++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 189c70015f..bef04aa2d7 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -406,3 +406,55 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
>   
>       return true;
>   }
> +
> +/*
> + * This function assumes L3 and L2 have unified cache and L1 is split L1d and
> + * L1i.
> + */
> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
> +                                                   int *lowest_cache_level,
> +                                                   CpuTopologyLevel topo_level)
> +{
> +    enum CacheLevelAndType cache_level;
> +    enum CpuTopologyLevel t;
> +
> +    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
> +         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
> +        t = machine_get_cache_topo_level(ms, cache_level);
> +        if (t == topo_level) {
> +            /* Assume L1 is split into L1d and L1i caches. */
> +            if (cache_level == CACHE_LEVEL_AND_TYPE_L1D ||
> +                cache_level == CACHE_LEVEL_AND_TYPE_L1I) {
> +                *lowest_cache_level = 1; /* L1 */
> +            } else {
> +                /* Assume the other caches are unified. */
> +                *lowest_cache_level = cache_level;
> +            }
> +
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * Check if there are caches defined at a particular level. It supports only
> + * L1, L2 and L3 caches, but this can be extended to more levels as needed.
> + *
> + * Return True on success, False otherwise.
> + */
> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
> +                                         CpuTopologyLevel topology)
> +{
> +    enum CacheLevelAndType cache_level;
> +
> +    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
> +         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
> +        if (machine_get_cache_topo_level(ms, cache_level) == topology) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index edbe8d03e5..af5fd9f3cd 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -60,6 +60,11 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
>                                     CpuTopologyLevel level);
>   bool machine_check_smp_cache(const MachineState *ms, Error **errp);
>   void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
> +                                         CpuTopologyLevel level);
> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
> +                                                   int *level_found,
> +                                                   CpuTopologyLevel topo_level);
>   
>   /**
>    * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

