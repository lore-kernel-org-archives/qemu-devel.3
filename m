Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61687FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFk1z-0008Bc-9F; Wed, 22 Apr 2026 22:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFk1v-0008Aq-Vx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:43:04 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFk1t-0006bc-N3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:43:03 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50e594413c2so30159941cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776912180; x=1777516980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiFy9XwJdeh234xin+KfomtT2Bss6NRDUdl5pm5WMBg=;
 b=kLVOgW6ymd8XDwiyBxpJXsGza0MwNtZtng5LdrnC1AKyatIzSaRZVhhDad9IAViipz
 i1+3RWI3EUZ4PLe4DGAgsrsS58c7eQmUJhuEN+rV3BkLzpCSblbUahto/rLFY03G8+RJ
 5o1YXHriiBmiLYjPeaJEomjbu71ruaApWY5HMwBHsSbbvdp8IAwZUIAW0y4sebSD/MN/
 4pigblBdjlV0IuKZEDkELbiDMkhuLxSNBmFt71H63evN84H2/4tgKx4L60kaH005/+VF
 25QcTWzzzIjPTGwplLRnaPnqpejXlxseLjgcL+UjZfPKpSUsCtWJX9HzDm1iOmF4Qvfv
 UxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776912180; x=1777516980;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiFy9XwJdeh234xin+KfomtT2Bss6NRDUdl5pm5WMBg=;
 b=gfK8Y4t2W6pbfCYoSpqNJ9yVqf3W14KhT0L0EiEHWEnaQLyCF9JAMwF9a1XVwCqOBh
 9kHnTlYe1ZTookzJU2hp1OYB3UIlSYFLMo0Uvl4pmydQFeHStKdcnweduy4JLVpf1sJ3
 uQrjSbG9IMwjtvCi2TtyC7p5/8tewwLokhQT7zyKTKBoxBKBs+Ztlgs2Zbq87zd/12pX
 r3r52ErKxMJBRw8kzbj+IPKeZKoVoaSIp1q3uHjBqMpXL2WI87QLUQ6CTDeuJJeXiI8m
 wv2NhpO94WwQphXMhodaVhqz7CbHEWZmaiFTsMHF/7ukSbTmhHW0Vfc57aEABjV9fA/5
 nQ+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dDB4NeXNrCIGsDz5Kz0PW6yjKGm8exXP2WCA8PgUTJ37Nx1v5MMr0aliZAjiCyQfgWRjhVo31NnGo@nongnu.org
X-Gm-Message-State: AOJu0YxArVSr+FkIsJloiDVGspeWbXXPUoRR+fUWVaRzMxKAkAWXQGen
 dIvQXaaCf6DPY1AKkuk9lktuSQ2++VSVGoNldTyIUWEgscBZoR7tAk27Z6TBFFAYhNM=
X-Gm-Gg: AeBDietToUV6WHDj46OHwCv7E/zY5biR1wJ5U0UM1ZjiBJzO/fISCJF6EKfJudtgj4l
 3aKZBCyb276aYm37j8BE8o07o1wXYvy2tANuJbOLn2Y1Z8A3keOL0yFxwE69+kCbbqmR6sYXDJZ
 qwKiqnpIvSPh07/ZItbvt2h9Ng1vPK48EpfbiagjwikAGqrvXzsjpSPQWqSzfRzqDPtm1Z+s/wI
 /g6GVsDXrjBmyoMVj+dFjcsl1FWe0kQdfidNsE4TULu5oM3ZjSaU0vW+TqaZAmaG6rSfA2Tlj5Q
 8HV4dHGtsyLhtQ3HdzG3XZ1pVcidMIxDGyENdDd9A1Xod0f0/fEac+wfrvcnNXO3P8L9w6Kqrrp
 qvGX2Y/Yj4HkB9jZtIFu4p+YVpTYYb7S4UgKtQtV/hM+l5xcw0VDohkYbQ1Zu4WMposJmlivkzd
 8aaaFhM7YHoRcf6XvyfTYJV2dmtgrEcGtUXGsprW0pAlesL5QLi4PMlpXl9PH2ytpwFcvPyeZh8
 mJ24Uh0n44rX1EgY3NeMdlLtf3oVnfqRQxkHok=
X-Received: by 2002:a05:622a:145:b0:50f:340f:ff35 with SMTP id
 d75a77b69052e-50f341004c6mr165560231cf.26.1776912180060; 
 Wed, 22 Apr 2026 19:43:00 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e5d5ecffdsm95552371cf.29.2026.04.22.19.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:42:59 -0700 (PDT)
Message-ID: <42c07a1b-ed6f-4343-92ad-a500b9efc954@linaro.org>
Date: Thu, 23 Apr 2026 12:42:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] hw/core: Update docs for
 get_phys_addr_{attrs_,}debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Update the documentation for the get_phys_addr_{attrs_,}debug methods
> and wrapper functions to state that they can handle non-page aligned
> addresses and will return the corresponding exact physaddr for them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/cpu.h            | 16 +++++++++++-----
>   include/hw/core/sysemu-cpu-ops.h |  4 ++++
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 6dedad535c..0941757c55 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -746,15 +746,18 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>   
>   /**
>    * cpu_get_phys_addr_attrs_debug:
> - * @cpu: The CPU to obtain the physical page address for.
> + * @cpu: The CPU to use for the virtual-to-physical translation
>    * @addr: The virtual address.
>    * @attrs: Updated on return with the memory transaction attributes to use
>    *         for this access.
>    *
> - * Obtains the physical page corresponding to a virtual one, together
> + * Obtains the physical address corresponding to a virtual one, together
>    * with the corresponding memory transaction attributes to use for the access.
>    * Use it only for debugging because no protection checks are done.
>    *
> + * The address need not be page-aligned; the returned address will
> + * be the physical address corresponding to that virtual address.
> + *
>    * Returns: Corresponding physical page address or -1 if no page found.
>    */
>   hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
> @@ -762,13 +765,16 @@ hwaddr cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
>   
>   /**
>    * cpu_get_phys_addr_debug:
> - * @cpu: The CPU to obtain the physical page address for.
> + * @cpu: The CPU to use for the virtual-to-physical translation
>    * @addr: The virtual address.
>    *
> - * Obtains the physical page corresponding to a virtual one.
> + * Obtains the physical address corresponding to a virtual one.
>    * Use it only for debugging because no protection checks are done.
>    *
> - * Returns: Corresponding physical page address or -1 if no page found.
> + * The address need not be page-aligned; the returned address will
> + * be the physical address corresponding to that virtual address.
> + *
> + * Returns: Corresponding physical address, or -1 if no page found.

-1 was useful as an error result when any valid result must have been page aligned.  We 
now need a different method to signal failure.

I'll grant that it's *unlikely* that (hwaddr)-1 is valid, as hwaddr is uint64_t, and most 
64-bit guests only have 40 to 56-bit physical address busses, but not all.  So 64-bit 
guests are less likely to make use of the last page than 32-bit guests, but we shouldn't 
leave the API broken like this.


r~

