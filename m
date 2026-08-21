Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA0EC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxQx0-0007JS-Uy; Fri, 21 Aug 2026 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQwz-0006zn-6o
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:14:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxQwx-0002s4-Eb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:14:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso10477915e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787325270; x=1787930070; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=adGmy8qXmAl6RskfAe8QbGdkDI+/EDItJvt6xFnK+ic=;
 b=huq7JzrgBgmrRiB+Bo6/Rc2DslI8zWoRlf2BhHdK22F55G5AsahQ+HvvOgu5tGYycW
 X4r2H78wRWtY/eqE5EUTbudZg2PJWHmvAOb7m557Ym8nPTxJeePGD75WnVKGCEfPCPv/
 AfEsQiFmUpGehltv5TCoriVC7I+n4SQajyK4UG51BqJS8RPwZujEVPcT3KZUAWarkLaQ
 rFhSdpkPPHeSLa/5MJpVpu37Y7mUDoB3hUQsPKWfr8AS/W/4XKLM/dQMs9SPEKWAqQ8r
 SyuykXZIDaYXq1l2DKPlJZRbBPSR03gmOhqDiGmGX/QchwBlmZCskAtlADXKlGeQoL//
 Mzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325270; x=1787930070;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=adGmy8qXmAl6RskfAe8QbGdkDI+/EDItJvt6xFnK+ic=;
 b=DP8Ubodc7+SjdHYAJzH9Emp/T6URI+40ve/1m7Dm9wz0+R8QKoRU8/uSXz3p7m0ZNm
 6spPW13LrPSxEeB516rwKmruUZmqabI0BrJ63Uscnye+cl9cT3EHfUn2jxJ4sShWMBZd
 vsXo7327hxUgD2J26QT8PVg2ST+YaBRwXBrokq4SY9tmnzfkPsbsjJXrE7RXjlOWQYlK
 AcnGige1C6Kot16CHyWNYpM+B2tTqZONDTcFt50hrEHnUhE30Rs9mNNyU7FZmBAg4kd9
 M3MU27rN8m7w5duEMeLwQoIIs0WMOpxtj0zithiwuvf0M+6W7p2tM6IK0CvrXqhl3jwa
 5BsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rql/bVUnV4rkIam1yqcClS3bg1nSpTV1ODf0zDMI9wueojkhxNeWFLMOrC1CgODqxmfrkVrdem8+ack@nongnu.org
X-Gm-Message-State: AOJu0YyK1NsMxrKf32m9uN9YRnSDvfhX76sOmGIYfSoR1o9cx3yG2wBI
 bPvkjypUYwZJ7zBwjFEfh7s0toyqirin3N9m8ZKGYHjEzs+YG8/a0tg9HGPhWMBxDKs=
X-Gm-Gg: AR+sD12qHeexCfNANzcDSHd0/aL3VpqXBs+2KwM/kRasDdIWWkB2oyDWaghumDTj4C5
 Id9ZH1i9ge5QnpCV5aDroDeewSutG0qd1Q60h3eZh2mws6D7w5G+7BuePxvBGGmVWEFgF8JMk78
 mB4OBx8Nq+Phf9HIR3NJoJrKFVRgAocXcDyBcDvArqYazN2+hEhHx4jrA+i8JQIQqMEsoiQ7fNl
 cjgZTzrWRqWMwW2431MDRC9UlzQc2xW6aKG84km2QJyCPkRaVC6e7hxZ2Rx446zIohJHL9oIs+S
 Bsm9HMyJMSPNawgJyfe3Jp2T2MRBOpXLlujMxiz7VThz1RUzH09X8G37qTWqyHMwWFj3r2Ml8xN
 tmU7x9oBG2VS+/sxXgVOFZg50S+PHxGsY9K3y/5cDn9MLpK0iBBLv8LlRapKr5uu3n1HkmzYhT5
 w1Co56u3KSGgg9fwYdKwseYeTVF8TLLgKh/hKc97yhnD7XdcR/8zQeEJSg/p9s8Do=
X-Received: by 2002:a05:600c:4f06:b0:499:a5fc:207e with SMTP id
 5b1f17b1804b1-499b8340754mr122434025e9.8.1787325269481; 
 Fri, 21 Aug 2026 08:14:29 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b916a250sm31102825e9.15.2026.08.21.08.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:14:29 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:14:27 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 09/28] hw/arm/smmu: Add PTE NS/NSTable helpers
Message-ID: <aohrUzydTPBEC1Vo@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-4-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162446.2806393-4-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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

On Fri, Aug 14, 2026 at 12:24:45AM +0800, Tao Tang wrote:
> Add helper macros for NS and NSTable bits and group PTE attribute
> accessors for clarity. No functional change beyond the new helpers.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmu-internal.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index d143d296f34..004abd58bca 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -58,16 +58,27 @@
>      ((level == 3) &&                                                    \
>       ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>  
> +/* Stage 1 attribute fields in VMSAv8-64 Block and Page descriptors */
> +/* Non-secure bit */
> +#define PTE_NS(pte) \
> +    (extract64(pte, 5, 1))
> +
>  /* access permissions */
>  
>  #define PTE_AP(pte) \
>      (extract64(pte, 6, 2))
>  
> +/* Stage 1 VMSAv8-64 Table descriptor fields */
>  #define PTE_APTABLE(pte) \
>      (extract64(pte, 61, 2))
>  
> +#define PTE_NSTABLE(pte) \
> +    (extract64(pte, 63, 1))
> +
> +/* Access flag: defined for both Block/Page and Table descriptors. */
>  #define PTE_AF(pte) \
>      (extract64(pte, 10, 1))
> +
>  /*
>   * TODO: At the moment all transactions are considered as privileged (EL1)
>   * as IOMMU translation callback does not pass user/priv attributes.
> -- 
> 2.34.1
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


