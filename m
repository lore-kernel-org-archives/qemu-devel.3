Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E5CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqJH-0005By-1S; Mon, 20 Oct 2025 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqJF-0005BF-Is
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:52:25 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vAqJB-0004OE-7Z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:52:23 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c27a099d61so1477457a34.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760968330; x=1761573130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vGaptLZdRXQmNub+MDMzGPiNrFK3okAxxPEwkBCT91I=;
 b=PlXa6DuzB1pdM0b2xbGa2PBbxjo0rHA3UCRdDOM02aYWr7sQ0fe44pJKS8z1UReXGg
 OGRAVq66tZqKAlIYDkIrPbXKIN0W3xvNqL130kf6poMtLwTOWOMJZU5UjnsuC5e/GGkc
 RKljZeYp+RWYKAlxg3N0nwI3PmbapoiCCCyjJ98L/uDX4ssl6hwFzjvKE5Hm+iv+ch/S
 5kPQj0/dbXZuE6FVmwRIF0XhH5ENiKalNR2dakVQwJRTFGRzFdv9bU1mi3eISN41IFvg
 oGOnaX+ARtamPjcV//Ree0foGSMkw2v1ZV2f+bMYnBfcObElf3Fi2DcojGZjTPnlKtj7
 GK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968330; x=1761573130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGaptLZdRXQmNub+MDMzGPiNrFK3okAxxPEwkBCT91I=;
 b=l8pQuEy8aivpZkPMgfkJc1WWVSE1U7FCYP2dAAmdQHAs6Qo21XiJnVKRMC8/ZZs1eo
 iu8PIvG3o+NmGZ1LhVRbxldKwn7fuyFBQhxV46CssPoNwb6VNo84pt4kSnLZB5+PGXBZ
 KWE1zewiE8VcW/KS0u/zQXwBImoR9bCBSV4rE6J0elWxF7IWqG0PP4u/VGWt9XtGvvFF
 +vejmojS6kJorln2h2hTYYr7IAHAzdETLC7PpHv32KbvB8e6C9aB5TXZtdGhbox/9CTg
 GjPDI0UcGqdqqur0TrjhZ8PUS0+AqPEcAoQEV3zRVaoVVLXgD4vukab7m3Is41wsucNX
 e5fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsNs3V6QQ/diGt8bK6b1Dj9teK0ReD7xXAotzSxl3l1jXuueyVVH/gS2oHBH7+HhVtgO+fqJE+5DoJ@nongnu.org
X-Gm-Message-State: AOJu0Yzq3I+qwUE8ck+m4UyJf07ylcUKIHPoXR1b/skv/qT1svMkcGN5
 LlQGIZgm39MyudKZWXFJKhzpckFOEthi1YtKRipfi0SS3n3gf5suQaHCp1SG8ZDalGE=
X-Gm-Gg: ASbGncs3IxX2NEad1wDW0OSPRyrFfWoREFjr73E9pdkxoKH8/gb8EqWrBHT7sw/FlLO
 Zt6nipdYvhhIzFKTp4ij18w2YkBFR1G3rYTPWgP71nWATU8YIb1bVeUyX6I0BUy8NNyIeJHorV2
 zj+8mtg8CX4ksbz9PXVDRHtCuT7yVzS6Igv9V/yTI0ilR6QWuottvUvu01pRBMxckUbgaFGQQnq
 8VXXhRkqUFnQVsro5+mlF3gmm4D5k+MjXDG7TV7pOO7epSSRX9zpJVZWK+uTNrJbEZejeNL2YqQ
 hmPuDThe+nYfrrDhBetyItwAClS31qYFRG/RdV/pFgjArLdsfx464q6bVL8E9x2xY1d/pRPPMHV
 QQvwkEqseRjZCYkj2yK+OxVimHi6NmRXXPQZDZ3Lem+hyZsDmEcTzsfgCxpoGX90vDZ+3BemgW9
 fb0Ix5D7FKE4RRgTMMQSSGunxHICItvb53Y/8A2XZDvsllYIhjlZ/9Qw==
X-Google-Smtp-Source: AGHT+IGVEwkJ3+8W+SQyb8/gUDqT8a5q/fx5ppLFGYyb4DGPwDCrA/bXnPrKuhmiecnKbTIl+lOF4w==
X-Received: by 2002:a05:6830:388d:b0:7bd:2e41:32d0 with SMTP id
 46e09a7af769-7c27cb00a11mr6190556a34.16.1760968330065; 
 Mon, 20 Oct 2025 06:52:10 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:5a7c:524e:bcac:abea?
 ([2804:7f0:b401:1d95:5a7c:524e:bcac:abea])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2887a1a3csm2681882a34.2.2025.10.20.06.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 06:52:09 -0700 (PDT)
Message-ID: <34d24ef9-6617-46b7-8e9e-631c49f4994f@linaro.org>
Date: Mon, 20 Oct 2025 10:52:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/8] hw/core/machine: topology functions capabilities
 added
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mst@redhat.com,
 mtosatti@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, shannon.zhaosl@gmail.com,
 yangyicong@hisilicon.com, zhao1.liu@intel.com
References: <20250827142152.206-1-alireza.sanaee@huawei.com>
 <20250827142152.206-3-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250827142152.206-3-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x32f.google.com
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

Hi Alireza,

On 8/27/25 11:21, Alireza Sanaee wrote:
> Add two functions one of which finds the lowest level cache defined in

Maybe s/lowest level cache/lowest cache level/?


> the cache description input, and the other checks if caches are defined
> at a particular level.

Maybe improve the comment message with smtg like "if a given cache topology is defined
at a particular cache level"? For reviewing this series I'm sticking with
the term "cache level" to mean the levels as in L1, L2, etc., and with the term
"topology level" to mean "thread", "core", "module", etc.


> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   hw/core/machine-smp.c | 56 +++++++++++++++++++++++++++++++++++++++++++
>   include/hw/boards.h   |  5 ++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 0be0ac044c..32f3e7d6c9 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -406,3 +406,59 @@ bool machine_check_smp_cache(const MachineState *ms, Error **errp)
>   
>       return true;
>   }
> +
> +/*
> + * This function assumes l3 and l2 have unified cache and l1 is split l1d and
> + * l1i.
> + */

Please, let's pick a form to write Ln cache and try to be consistent using it.
I prefer L1, L1d, etc. Here you're using l3, l2 form but in the comment on
machine_defines_cache_at_topo_level just below you use L2, L3. Also to be observed
in the other patches in this series.


> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
> +                                                   int *level_found,
> +                                                   CpuTopologyLevel topo_level)

"level_found" sounds a bit like a bool? how about "lowest_cache_level" instead?


> +{
> +
> +    CpuTopologyLevel level;
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
> +    if (level == topo_level) {
> +        *level_found = 1;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
> +    if (level == topo_level) {
> +        *level_found = 2;
> +        return true;
> +    }
> +
> +    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
> +    if (level == topo_level) {
> +        *level_found = 3;
> +        return true;
> +    }
> +
> +    return false;
> +}

hmm it's a bit unfortunate that the cache level structure we use in QEMU
(actually it's a simple enum) doesn't allow us to obtain promptly the cache
level itself. Maybe, although just a slight enhancement, would be better to
iterate over the cache levels defined in QEMU and just set the cache level
for the separate cache levels, like:

enum CacheLevelAndType cache_level;
enum CpuTopologyLevel t;

for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
      cache_level < CACHE_LEVEL_AND_TYPE__MAX;
      cache_level++) {
     t = machine_get_cache_topo_level(ms, cache_level);
     if (t == topo_level) {
         /* Assume L1 is split into L1d and L1i caches. */
         if (cache_level == CACHE_LEVEL_AND_TYPE_L1D ||
             cache_level == CACHE_LEVEL_AND_TYPE_L1I) {
             *lowest_cache_level = 1; /* L1 */
         } else {
             /* Assume the other caches are unified. */
             *lowest_cache_level = cache_level;
         }

         return true;
     }
}

return false;

That won't avoid adding the separate caches in this function if new ones
are added to QEMU but will avoid adding the unified ones. Wdyt?


> +/*
> + * Check if there are caches defined at a particular level. It supports only
> + * L1, L2 and L3 caches, but this can be extended to more levels as needed.
> + *
> + * Return True on success, False otherwise.
> + */
> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
> +                                       CpuTopologyLevel level)

How about using "topology" for CpuTopologyLevel var. instead of "level". We use
level in "cache level" and in "topology level" currently, so I think it's better
being more specific here.


> +{
> +    if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I) == level ||
> +        machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D) == level) {
> +        return true;
> +    }
> +    return false;
> +}

How about checking for all the levels defined in QEMU now and in future? That looks
possible, like:

enum CacheLevelAndType cache_level;

for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
      cache_level < CACHE_LEVEL_AND_TYPE__MAX;
      cache_level++) {
     if (machine_get_cache_topo_level(ms, cache_level) == topology) {
         return true;
     }
}

return false;

?


Cheers,
Gustavo

> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f94713e6e2..3c1a999791 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -55,6 +55,11 @@ void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
>                                     CpuTopologyLevel level);
>   bool machine_check_smp_cache(const MachineState *ms, Error **errp);
>   void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
> +                                       CpuTopologyLevel level);
> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState *ms,
> +                                                   int *level_found,
> +                                                   CpuTopologyLevel topo_level);
>   
>   /**
>    * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices


