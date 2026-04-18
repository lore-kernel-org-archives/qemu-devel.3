Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1DEF99C74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 03:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDwae-00076G-CG; Fri, 17 Apr 2026 23:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDwad-00075m-L8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 23:43:27 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDwab-000230-8n
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 23:43:27 -0400
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56a857578a8so503408e0c.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 20:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776483803; x=1777088603; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gf+jNGWsKroQLTB6YzgFMpQGPeobJncLTcLFEvWLsr8=;
 b=i2YAv9ksxfhA20oQPB1uMpinHbrmJeNnAQee+Na1rt3Bq76OM+w9gl2buiK6M7EpSy
 MdNGoaw9yHBPpKuSVpRKJFeYekSIh0q4eFICO7/BtSw0+3mGbe4e0L007Y8/RvZ/cJFN
 K0A80bHKEIL/OWT2581QxwEpq9DI/n7LHE2gUR1sAJQZUkaB8eOpYcc6m4uxXwxrPxyc
 xx8di6EtxZKdugiZFjwnpBNO+g4Y9hadnMW+iWRvNoQdB6aCnR4kFUi5G2LwDe/zDtz8
 g0LcDhEzjzul+Jrdv+jKZje7XT5rYz5mH7sX+mk6gI+wLoAkicocQa1rPtjRyDzeFSqq
 al/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776483803; x=1777088603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gf+jNGWsKroQLTB6YzgFMpQGPeobJncLTcLFEvWLsr8=;
 b=Jn+m9dL0bdnGAokt1RIz0vAAGwx6IImpT4HVfnr3dVu0lPyv3eBJdnWxeDwFwAEFbg
 ngnuXK2tUqWslW7b7/no2UKtbODTUuII+HR6/35MDAEX+hGW68xdXwlWmHnFEOcFlWij
 ud6JSlSlkaxEZCw1gY+NieJzkmLYjka3VvY2NOaWy9FZePN0UzDSlfGVCDY8zLlmzDhM
 j7NhHk1LMWSfKlsHsR6c6Fr4UKuY2MVIrE1bRPl1c/S3c6QQv/TY1N6GLACzoQIe0QFU
 oXHTJr7Olbuq0yAspFfWNY/mQ1hsjGsSFeHULA+zC6uHWOOGCsOyk4z7uyTpjsTYWaig
 wipg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qV5rYhFyrYJRjR7sMFek1dGs4OQrHT0IltX87zc2v33K9zWQkVYL4nebz7Hz3U6vXv9uHbPV3dg+r@nongnu.org
X-Gm-Message-State: AOJu0Yyf4/BN9JInun6xr15s9X+gQz+mm0Hi0Olb3I+k1o4CZSYJc1Bj
 ApeIedigSa7nzIqCMBpGzBd6G0qVwdmNTnJU21Ygks7yzT6ys7kKLXjT
X-Gm-Gg: AeBDiesCLlG8EOrccSqJkzW2Ki4UD/s0NIQGzWxktBKA5eEPQswc7YqXXEMEPEAzlYT
 DFOePLVBR2SVV51lwSKd1YA9udegb/4W88odD9RLgo2BDYq9PL0JYArizu03v9vD0yAGcoGoiXA
 3qjS6ZBB5ijmxw4NrdueAbhnNoxDrQr0mBinEPyINe8w2seKxaHcHtKjF+G5hdPiAdvRHcQWTG1
 r8sIt7Jj8zyj9KT7cT6r+MJtFU02bcEzX8DMjSTOyWraeQTs/2mou0+qB7218XPEiao7ARPgfwM
 omdVugVqtZ5Vs4HSnXFHlvZhLnKRUyaya04n6noex+bCZ6pEIGZZ9LuIl638fynDvol3LbZ5S/S
 70NxkNa24I4MM9bdh0GV0YfgqlyyCew7nfN26cetrI/qSfX2KUdbL291kfB9DSX1EYdU30hOUwF
 dtMZlQvDqibm8v8Coc5N7l2G2/JioUdr+w0Au4Lzcl4akfKW6rdDlXYFUL42WA5vc3ykXQa6z7/
 /I8aaqkFZA=
X-Received: by 2002:a05:6102:2927:b0:608:9a34:c8ea with SMTP id
 ada2fe7eead31-616f68d7618mr2747367137.10.1776483802867; 
 Fri, 17 Apr 2026 20:43:22 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9589097ec5csm1719242241.4.2026.04.17.20.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 20:43:21 -0700 (PDT)
Date: Sat, 18 Apr 2026 11:43:00 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 01/17] target/riscv: Make get_phys_page_debug handle
 non-page-aligned addrs
Message-ID: <aeL9to3kuG2L2dKC@ZEVORN-PC.localdomain>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417173105.1648172-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa44.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Apr 17, 2026 at 06:30:49PM +0100, Peter Maydell wrote:
> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> The only thing in the riscv implementation that we need to fix
> is the place where we explicitly round the return value down to
> a page boundary before returning it. Drop that.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..475e9cfd57 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1677,7 +1677,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>          }
>      }
>  
> -    return phys_addr & TARGET_PAGE_MASK;
> +    return phys_addr;
>  }
>  
>  void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> -- 
> 2.43.0
> 

