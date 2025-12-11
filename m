Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B2D41D4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiDs-00058T-Vl; Thu, 11 Dec 2025 10:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiDo-000576-A8
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:04:48 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiDm-0007kd-Km
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:04:48 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c7660192b0so128067a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765465485; x=1766070285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzMRJ5I/1a9NSNr5L5povHegZzuatzWX47F9oeN9SNw=;
 b=FtsX99by5SJK3/uVXRLqw8ZgO/DFHRNIhyuCfvYyS+fR6sd1ljZBX8A4ZmEm5fbxbV
 Gb+CD5LW4Zz6nRhR2NUlOmQq82HSqto2jfNnsNhvIfXmv+Pr1lgym9IqRpMnPyFqxZl3
 Zsd7bFrUc+s9bs/vEkVDgUcu4ySp3BrK/ORONTlRYJcATiXVkybVdDzfKKkXV1b67UCI
 8N4LFtd9s4JbUX6DwPUaWthUGSTNnWPXA4rLqD1GZMoyW1/aqPlz+Ge4iIz+kd5TlUiU
 nftA4ksL2tbmG+vLWKp2atIQRmwrHxq/z2sd5P0sSenvo0hL+OoRUveLJuedfNXD4ypk
 fujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765465485; x=1766070285;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YzMRJ5I/1a9NSNr5L5povHegZzuatzWX47F9oeN9SNw=;
 b=Y7WDIoAa2a2OYCvaNZheqfdPsAoZEKOCF/+JwxWL/SoDg15ajgf4ocJiceu8uQRe6k
 xAYdHIBKStp2wBlmtLPPUs06JDKiYIvt4FLDqqQVzGhBN2hywnGD+dUiAsXock4bJMrj
 PGY7SCeCiKlALoPXnP88wlA0K5Ta6/m2UmQpBgpNc9c2YGhshvtaI7dVcCob7CiMCW26
 q7cOs4aZoNCqTbnG/tG0z3D/oZyYCJzTgvKlahKwrAmLQOYMBqsgfOTmFyJa9Gfyah4s
 kHsqg6rfAg3HC3ccgCvIZ+TIp+lOdrLgQf4yUrbLk43IOzQCVdYmD02Tyo+7QUY8K6pj
 H6Vw==
X-Gm-Message-State: AOJu0YzLciCVWjI7HHoKAuo4OhhkSESyvnzaUOoYVU1E3juDsp+xlgTJ
 seVwr/7sd7cYvESy3THsP5UIs+IxTjHgIBOJBrX4J0v211mm9XpUj2vI1Vc3imiKPqE=
X-Gm-Gg: AY/fxX4xiZy5h9SIgMGOlAXdM6qw6bJ7U35lU+x1KM2DZ1MZLr/P8jvus0r1C+f8R0a
 6KYltxi/VO7MfwuS6J1DyoN9mZwRfK+ivlWbruvtqi/uPtfasjfRzFR7I8vNZKWbyLJsdL+WlA0
 nvVM3DAYh7K7Vj1GyB055g+xzxH246dLJ4+3S59A7N5Wd3Y89kmYTSSCXfhU0gRGlE6+37rYBge
 M28x2Rqs4WnUv0NqoNpF0RQqjvinwFSZ1ViLZj96aiJWnK4gKQFXc0OMKqT5M+SfFDWKgqZPLa/
 YlirKHVXIiwISWpaW4FXWQYC9uhDxnWkDpNM+fIy8QD/OTaDRidz5JKx/+2rcKz20Hpc9wZFMxk
 DAMIAI+oww4UxX55znhFpyp7ebNmNbVqi1hYI4lNKse+B2z1vOewRL/lS09ayJJ9lBYes9iDKw4
 YFDjT4m6/7qOccA0lDWNifqkFPYmGii4xMAfphhYupSHR0boXDO/Oll/Hsa4Mpu9SnI50/bJasG
 Xg=
X-Google-Smtp-Source: AGHT+IGpZW7Y1ieTolqgnVcW+iFqdaBOl735he9KInx3LnXVoO0kLYPmnCEWIfPdVU0Ks4FGjWC6QA==
X-Received: by 2002:a05:6830:7192:b0:7c7:7fc7:8b9d with SMTP id
 46e09a7af769-7cacec2d9efmr3909035a34.18.1765465483435; 
 Thu, 11 Dec 2025 07:04:43 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2250d8sm1625696a34.13.2025.12.11.07.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:04:43 -0800 (PST)
Message-ID: <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
Date: Thu, 11 Dec 2025 09:04:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Record AS in full tlb
To: Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -269,6 +269,8 @@ struct CPUTLBEntryFull {
>              bool guarded;
>          } arm;
>      } extra;
> +
> +    AddressSpace *as;
>  };
...
> -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> +
> +MemoryRegionSection *iotlb_to_section(AddressSpace *as,
>                                        hwaddr index, MemTxAttrs attrs)
>  {
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
> -    AddressSpaceDispatch *d = address_space_to_dispatch(cpuas->as);
> +    assert(as);
> +    AddressSpaceDispatch *d = address_space_to_dispatch(as);
>      int section_index = index & ~TARGET_PAGE_MASK;

Adding the as to CPUTLBEntryFull is unnecessary because

(1) Each CPUTLB, and thus each CPUTLBEntryFull, is private to the cpu.
(2) Each CPUTLBEntryFull contains the MemTxAttrs for the access.

Thus the AddressSpace is purely a function of (cpu, attrs).

We can have a conversation about where this lookup happens, and whether or not particular 
functions should be passed a CPUState, but adding AddressSpace to full tlb is redundant.


r~

