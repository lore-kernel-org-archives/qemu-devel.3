Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4610AF36B9A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 02:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB1KP-0001cU-CH; Thu, 09 Apr 2026 22:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wB1KN-0001cL-Vm
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:10:36 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wB1KM-0006nr-9X
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 22:10:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso861933b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775787032; x=1776391832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K0Vrk8P+efqDxb52ticYDuHDNcPgXUDIOcGYeEVKT6U=;
 b=e0NqSodXg+kFCiyM9CAbrYxu/uDrLnuJ/FCaLIpTxs84iqYxUN3iH18U9go8DysXHd
 w9Dbuw9YQX7xy4epzyp8wEvQ1YI+IZGp7Iyxr0acgQqxEroZ4fFdw/87CAvHTENmbRh7
 hqGEnZBv3I9mbfdKtIvI3To1h0ihnTURewmzE89MmZLjSnViHVO56uXC2CcqaYjyBBPI
 5kafUs50NS3IlxsgLWnd9xV1SnvTMSEh6ky65uxFmSAdjCgUU7Y3RkYK6f+RQn7cOsZT
 /zNhdRRK6L16zqZQp6Y/CerSUDEJRamA6XE0I34wr+NNZRTE1FXZAoHGeNlS4KkL2i/N
 kBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775787032; x=1776391832;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0Vrk8P+efqDxb52ticYDuHDNcPgXUDIOcGYeEVKT6U=;
 b=R+YvsvYIbjR3xRKfIL8kJou7/HuSNgA90FRPOgCa3rNGGYy+Vf9nMBFCuANZflRnLQ
 qRB4z5w3aiSf+GzFItVKYV/D7QSAhRnVmMP5DqrVWgXHQmVRZ2juy05w/sNgnJj7chIv
 MvUReAtabJuT7P0PRPrJnIkqGVWfvTCi7stnd/5nc0aWt//n+i61I9y6v8+3PBdW7GUw
 tErv7NsjnqfvXkRVDlWCrgxAryjraeQkfCQA7R1oIPZ7+0PA6E2GPhQqD1q+EVFd70Oy
 vJ1b7PpNlWtWzbMHWSq9BqSrKHzTygRPD8uu8mTf7NK7d8PnQddKEhjcslWoL7ytE2jv
 P96g==
X-Gm-Message-State: AOJu0Yybv8ALPgGJqCU1NGFObIa3NU0B3IgPulZklhBnzBSeVKJGZKTL
 apnv2Z3IEVbO/Jc3gTBQQ5OnNkTjAJHttle+iXHgB52EbB9gkz7GWcGlpItGGEhFVhB+/fGOFZH
 xTgmS
X-Gm-Gg: AeBDieu5137jUOrATe65eL+46NuCyyuciblkWY4Pv814WM/GSLCbJnJiyqh1FtOIddz
 l4kruPDhkb0RueC1mlZw+ImsNIgRVAQUGT76gRLbvVaET9xM90He+WZsQaJrABXuOIXEGBei7uC
 mWvD+3a8bLqTl7kRbehcIoIeu3g9JiVHFYk4nrSr6C6SbVsJidaJ3rLf5fY6FJdhHIWlYU4LrNe
 OUQUHNRWNeGFa4Kz0a7kAWR8duw67a/O9IOkXDRifxO8PXQuu+x7VxF9E4SCzLT/uczBL9uOCJe
 R7lRKamkPvZk6ALXqEXzs4YMfxjP6DYaBuP0uyxEvG59IRn8QPYgW9beR5067qgVXj6bY6WZQCU
 d90MUv3TpzqcadwhJqbL3O9m4zsdOi7z54ASyc6JAXqf6VF4ujacQWrQvG3svt6RBxTimuPZKZ+
 xQ9ICPCcFAnNJZQ3cLZhZrc762Kt/WHgBZP4CUSsriv3J5Gk8MiQ85OgSpLdnw+sIe+TcC7E1/p
 IE6OQ==
X-Received: by 2002:a05:6a21:6d94:b0:39f:7183:b1ee with SMTP id
 adf61e73a8af0-39fc93791d3mr6120808637.15.1775787032158; 
 Thu, 09 Apr 2026 19:10:32 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7921a3e6d2sm664340a12.32.2026.04.09.19.10.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 19:10:31 -0700 (PDT)
Message-ID: <00b95efa-81de-43e1-811a-0ca63fac4449@linaro.org>
Date: Fri, 10 Apr 2026 12:10:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] linux-user/mips: sync k0 TLS for
 EF_MIPS_MACH_OCTEON userlands
To: qemu-devel@nongnu.org
References: <20260410020012.98778-1-james.hilliard1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410020012.98778-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/10/26 12:00, James Hilliard wrote:
> Cavium Octeon userspace is not following a generic MIPS Linux TLS
> ABI rule here. Older Octeon glibc uses the k0 register as the fast
> thread pointer, while newer Octeon2 and Octeon3 glibc variants use
> the normal rdhwr $29 path.
> 
> linux-user already updates CP0_UserLocal for cpu_set_tls() and
> TARGET_NR_set_thread_area, but it does not keep gpr[26]
> synchronized. That leaves EF_MIPS_MACH_OCTEON userlands able to
> complete set_thread_area() and still reach pthread startup or
> pthread_self() with a stale k0 value.
> 
> Use the existing MIPS ELF machine flags from linux-user/elfload.c and
> mirror CP0_UserLocal into gpr[26] only for EF_MIPS_MACH_OCTEON.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - only enable on EF_MIPS_MACH_OCTEON
> ---
>   linux-user/elfload.c         | 3 +++
>   linux-user/mips/target_cpu.h | 5 +++++
>   linux-user/qemu.h            | 1 +
>   linux-user/syscall.c         | 2 +-
>   4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 59b543f740..0e757787d2 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1476,6 +1476,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
>       /* Usual start for brk is after all sections of the main executable. */
>       info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
>       info->elf_flags = ehdr->e_flags;
> +#ifdef TARGET_MIPS
> +    info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
> +#endif

Note that we've just stored e_flags in info->elf_flags.
Better placement for this is in mips/cpu_loop.c, init_main_thread.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

