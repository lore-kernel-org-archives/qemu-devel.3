Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B9CF9EDE0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYoT-0006yI-SB; Wed, 22 Apr 2026 10:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFYo0-0006vA-0T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:43:59 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFYnx-0006ya-Ma
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:43:54 -0400
Received: by mail-ua1-x942.google.com with SMTP id
 a1e0cc1a2514c-95687f6ce13so1684253241.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776869032; x=1777473832; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6hUqjuPBOwTV7aRtg1D/Aaz0ywRpW/RZH075cWVbCTQ=;
 b=ZRmW4Xo1WckL6cyrTXP0hnEbO3M13me40q1lPuWuZJEBP0lT86gTG/PBrxcLriDTkt
 kPKFW/j6d6oX+g2wOr2neMDcIJQ6wH/gFIjHf9ZuMYsKH23SrvaDRfFmgRRZ6TWlcHMI
 R3eN+SdTGUokQHMiMAK4lPwBO9zmg4ug9myg8JvMuNf8uJDEWd72UrZgIakJ1mRI6Ddm
 aRlVASVUak4NGo/i6SnLGPiYWv/ywgj0W8imgMD2zvReBv4GBHlLcgzduvtPZn2KJXv/
 zU4dCFsraFJYgYsF6xoNCIdwM0S8hJCKJWy1s92b+0Na8ykKi91L5KxKXTAnxUuDdyjX
 xIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776869032; x=1777473832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hUqjuPBOwTV7aRtg1D/Aaz0ywRpW/RZH075cWVbCTQ=;
 b=YGNzBoUnWaZwa9NDflCVyqSzGS3OakU2fF6N2UCx9OpujvwTlv1Mtcl9mX6s5HjX3g
 uS2ZyFW2lwv74xI645LjyKMTN7LukQDXpfFeGl1MY95dybHQVpxsk1Xfw1yw0JQg6cNq
 3ODefmRAfE0A5QOhoB7lH+FYQEeqSXB2Y84lyCqcJGvkrL6XKe0/9IjAvfxoODzpEWvC
 N0RgkUr5Evnb5diIEBhzCetdymXZSaydxgz/TBq0JrjC9u8lfhcvm3JMjONlTAjZmYuA
 ssMKV4uwgT7WdO6y/8e675gbjwM0/CutQge7ySEkpmvuNyA28mEKQRPRbcKcoE6JU1Z3
 kXYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9ynzZoicke0REZUOYBg/6pD8iD1WzAbtlMrGkt4zoTQje+pHos1gCApfnNT1q1BXAJdH75Uv6ofwk@nongnu.org
X-Gm-Message-State: AOJu0Yz/LV9ZSIMvRsoTPbGpBlN5y+zmj48cRM+tlxxq84GNZ40311DX
 fKSZ8h9dhuxnv1RFkgjl8ZQYtMoN9ImG+AX+4TeoAgCwGxxVU72bXNU0
X-Gm-Gg: AeBDiet260vypyzc6olqK8Qrh3Zqn5gixRV1Ftqmy9WlPZq1Dl+TdblJB1xP0bkIZHw
 csGpJgFk01pFbOnoSR8/ngnbqxphkuUWX3RC4qRxF2v9yU3zcbC2FY1WPfaWsiT1z+6mDZXxkDt
 gtuX9XYZX9qjPmecpGt+hpYCjlOiCs0y2iG84jC8vwBQ8eG/turoLh9O35k35evfm1ehUYxVgVC
 SJNDOUYsHbKwTpI4VTrSKc1J2SPyQywWCraHxneqrkFnp6F7vT4/hUc2iXdYOmJCcfTjhEeYN3g
 GHCL/XiII/PxQZ72TYvjf5gel/8gDEzWrh6MfOYFcTMgYQEJTcf9qVT5o8LoRQ/t6SwBddnmcyh
 /9yUBogWcVFSfMxyf7RMQIPnOMD6Q+Qz4zlvPV3BE152Dczh9//vB31fDC8CvP3+0SQfKDQXpaK
 avRZhr8B7lXCEiCkdB7Pin9xn52uePjB53lQNfpZOI1jfPsWYxyxLNifOJxm+o3md9iWCfHy5e1
 0CHcDjwwIg=
X-Received: by 2002:a05:6102:160d:b0:602:b037:4de8 with SMTP id
 ada2fe7eead31-616f4538273mr12057303137.4.1776869031803; 
 Wed, 22 Apr 2026 07:43:51 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-958909c5642sm7838570241.7.2026.04.22.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:43:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:43:37 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/14] target/riscv: rvp: Add option defines and
 dependency check for packed simd extension
Message-ID: <aejdNdwCmaJLjLvU@ZEVORN-PC.localdomain>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-2-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417104652.17857-2-xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-ua1-x942.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Apr 17, 2026 at 06:46:38PM +0800, Molly Chen wrote:
> Co-Authored by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-Authored by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-Authored by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
Should be 'Co-authored-by', other patches have similar issues too,
please check.

Thanks,
Chao
> 
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>  target/riscv/cpu.c         |  5 +++--
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f1..c630faa892 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -41,7 +41,7 @@
>  /* RISC-V CPU definitions */
>  static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>  const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
> +                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
>  
>  /*
>   * From vector_helper.c
> @@ -1172,7 +1172,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>      MISA_EXT_INFO(RVH, "h", "Hypervisor"),
>      MISA_EXT_INFO(RVV, "v", "Vector operations"),
>      MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)"),
> +    MISA_EXT_INFO(RVP, "x-p", "Packed-SIMD instructions")
>  };
>  
>  static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c0676ed53..e08f57d282 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
>  #define RVH RV('H')
>  #define RVG RV('G')
>  #define RVB RV('B')
> +#define RVP RV('P')
>  
>  extern const uint32_t misa_bits[];
>  const char *riscv_get_misa_ext_name(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f7808895..4545ae721c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -601,6 +601,11 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
>      }
>  }
>  
> +static void riscv_cpu_validate_p(RISCVCPU *cpu)
> +{
> +    /* Enable sub-extensions here. Do nothing for now. */
> +}
> +
>  /*
>   * Check consistency between chosen extensions while setting
>   * cpu->cfg accordingly.
> @@ -619,6 +624,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          riscv_cpu_validate_b(cpu);
>      }
>  
> +    if (riscv_has_ext(env, RVP)) {
> +        riscv_cpu_validate_p(cpu);
> +    }
> +
>      if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
>          error_setg(errp,
>                     "I and E extensions are incompatible");
> @@ -683,6 +692,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (riscv_has_ext(env, RVP) &&
> +        !(cpu->cfg.ext_zba && cpu->cfg.ext_zbb && cpu->cfg.ext_zbkb)) {
> +        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
> +        return;
> +    }
> +
>      riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
> @@ -1413,6 +1428,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>      MISA_CFG(RVV, false),
>      MISA_CFG(RVG, false),
>      MISA_CFG(RVB, false),
> +    MISA_CFG(RVP, false),
>  };
>  
>  /*
> -- 
> 2.34.1
> 

