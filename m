Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE28CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPycq-0000qK-4S; Thu, 21 May 2026 04:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPyco-0000nG-3i
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:19:26 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPycm-0004Gg-EZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:19:25 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-3042a388168so513956eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779351563; x=1779956363; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8p4IGkQJ4Op+eDfuGg0yE+8nDVRo7EO2Ko24Y4vcmeI=;
 b=d+ukkjgyor46cSQab5tzhWDHGm7d+9LenO9ZBA/hcd6J/pcT9IUbjKovkks4511iUl
 YfSl/v4IKKr38kEUhvMySqfVHj9lbh53bp+/k/EVOkti/j8wReaJriOMWnIvhLuI4JY4
 dJmuYLHJLiLdl7qgWqkibSN3j//wUIZZkqi9SQiK6upvCTLlHOtxTGuYkAEt3aIoperD
 LOHTw2U4nw9viISdDQATmh8nZBwbWtTXl35SZyN4Wc7EERMaU9MDwUEJsr6ij5Ki4SH8
 eKxdM7fgwBNk+b38uSAaP/t5VN0dGL5UvhmaXll3d+PqTTTGqgWdcbUiFK9mGUfeT1NF
 6QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351563; x=1779956363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8p4IGkQJ4Op+eDfuGg0yE+8nDVRo7EO2Ko24Y4vcmeI=;
 b=FDUC5nPBzpU6vxIuikcje4CM7jN10uPM+aW363oFY2XVYgfp1wiMot015KC05NQ52I
 c/qqZbU30PehkHPgVUhuOhY0jajrB2md6Lwzu9X8u1BmKVc8N19W4QZuG2NPdcg8hzyF
 EG07vY8glvyjB8LuLMRumyhvYe5fRzWbUJxZkXBkZTxgQOS/6Q/QbcMZtSWLJ0rTCDcf
 L09+ZcrjTNjlWvOnnzXpstS52DohuDAGd9EDuYLEBkkWYpCBWSfQp4mmgL4cOu2hRkkJ
 CoXhB+5GGmIh1O/9IRwDHmB2zWIueg7IXEUM2vboa/W0HrtZVtAcb+LziAIvN8+IL+eV
 EbxQ==
X-Gm-Message-State: AOJu0YwyeNrjguOXx6ryVCDNW15/AiGUhtr1+sjbogAT6oDw5rM/2DVS
 o5wVIMJaYRKDO5xeVtMWeCZNbsTpOAneVe5dd/t/qO2EO/q+fbDEZKY6VOiWjirDihDOjyMU
X-Gm-Gg: Acq92OGDuIvclWAYY9YscCDrp2TsrGpWxtRkvyhu9n78XiS2uYPwffNQzPmPrYmxih2
 Ji/5jUO6feSCsQJi3BlB/xKmnYF1O2ArWRCmrL8aIH4QuBc0OW8DD5HZWT0ACSjG+HN0/M+iey3
 iMzF/j25v/RSPCZPswdfGVZzk+CALzf1xAaTQb7SvEVu+O3wBVaKqzc6kSqw8FmxQuiGzIqqdfg
 ZDBuITUi/USSS5gKZIlOKKcV00EQ2oL4MqbNVuht+bT/S56WvgUx0UiWsBEUUeQqwvJk2CYE5/O
 /rc5zCyGMTiEgbYBKI9IRMLnr/8JBaMUza80It0a9M8P9ElmapfqJJIYHvE++Z4K6CyMErN4uto
 KmxaNfcduFyeUa18zi8BSQ3geENxNhAxd0koIJl6yw3lZE1ZyxxRQQzEXEB8nx6K9u3wjnYCERD
 PFhjR1QI83VIYoiFpquIIkIJ7Tvc/UMzOBnwmYwfLNldDD6/sb4SSAWx4qY8k+eFK5LvTHtg==
X-Received: by 2002:a05:7300:a907:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-3043207b0eamr741499eec.12.1779351562692; 
 Thu, 21 May 2026 01:19:22 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302977a9474sm20774549eec.25.2026.05.21.01.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:19:22 -0700 (PDT)
Date: Thu, 21 May 2026 16:19:18 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH v3 06/14] target-info: Add target_riscv64()
Message-ID: <ag6_aQE7WW-BWFnB@ChaodeMacBook-Pro.local>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

On Wed, May 20, 2026 at 03:12:58PM +0800, Anton Johansson via wrote:
> Adds a helper function to tell if the binary is targeting riscv64 or
> not.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  include/qemu/target-info.h | 7 +++++++
>  target-info.c              | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 23c997de54..6c5b714288 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -99,4 +99,11 @@ bool target_ppc64(void);
>   */
>  bool target_s390x(void);
>  
> +/**
There’s one extra * character here; otherwise LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> + * target_riscv64:
> + *
> + * Returns whether the target architecture is riscv64
> + */
> +bool target_riscv64(void);
> +
>  #endif
> diff --git a/target-info.c b/target-info.c
> index 28c458fc7a..04c69c41f8 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -93,3 +93,8 @@ bool target_s390x(void)
>  {
>      return target_arch() == SYS_EMU_TARGET_S390X;
>  }
> +
> +bool target_riscv64(void)
> +{
> +    return target_arch() == SYS_EMU_TARGET_RISCV64;
> +}
> 
> -- 
> 2.52.0
> 
> 

