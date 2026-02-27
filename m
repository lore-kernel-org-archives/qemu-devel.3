Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848DFFEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvysL-0008G1-KZ; Fri, 27 Feb 2026 09:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvysC-00088g-JW
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:31:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvys9-0005Jf-0h
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:31:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48318d08ec2so53275e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772202670; x=1772807470; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7t70c5yCnUVrPN1M20H2ZzeIsX//ZNTm9WFwFVy1xhw=;
 b=HCfDJ/wQBKcPwTVkx+nYntxhOhMxSR+ak6WiFzXhJLpcory7AlcLgFtOM/kkhfNJQF
 gMlHLydHZxpWkiq1K8tn+j8esXZTXZPyFYB/VqLHV827/tkTT234+o80nMkI06/DoWZQ
 zCfxxqqXNmbxuxXEljP2tSgpPOYYch6G4vbQ1JKA4jVeLBMey5oR2ErSAFtsFqVFkXQ7
 s+y8pMQKwlLX0iytmUKEk0JtGw0vEfqayJrXRex8zclvnu1ZKUii2U/6b1UKUf1R2SVo
 a3vLb3zKHMslTqJdS3r2/tmqc1qOQJitl9BkoVOxjZM4ifE24wCWy3hN2C8P5DsAuUJa
 v/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772202670; x=1772807470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7t70c5yCnUVrPN1M20H2ZzeIsX//ZNTm9WFwFVy1xhw=;
 b=pWFQpq/5Y6mfR18KbcxQJ4kTWWNP6hP9wW5br49hzs/G3Rr20eik4ioGpH8uknr1Ds
 YMK47G6LdOhpL74qNsWqwvFej3kOBbWS9T3vNCdudDqYwBJNPdnhDCaUs9ZV2lhGYrN4
 GIarPnF/47O5fkX1Iq/QLT0hgZBvIrTewsuZHswItOJxGK7zdAF63kM0Yr4FAju151Hd
 Sd+N66vuwqu6/TwpMLtMykS9skx251Ql/seuj1eKIu2MMIJWQ+UctmYu/rnjBHETES45
 UBh7hl8vWuFhqd1aU+4m2LZhjN4sXzSy9sNvY6q+NVYOruFnA4Db30a3ls/6OCZHy3G/
 mKMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5y/yKPOC9cNmlQ4sdc52Q0TOwdakKZ8/eKR3fnB5pArXymeDz0DNlUum6u2oNZCaCVqIobX+SRDP2@nongnu.org
X-Gm-Message-State: AOJu0YwQKtW3BV0Z5VK2bwC0Z/eEU+omGSRC3Od5JCsjuWYKvyYIE1j/
 dPGpgR1z88wjPKgtjNsYX2iO8o9t5s/0I0D2HSb9iHT5HgQlcLhBbgRUYBlojhN6Xw==
X-Gm-Gg: ATEYQzwp07mvicSPfHtGG7lmgrmRrRBP70Ttb91Hk6QQM3S4f4hZReL4G/qetvnhmu4
 EAHs85R4W+0T3JdA2OHPRlKmBIcQs9y6ohxyatmHz/s4XWqPDmD2BK+AYRR1LATcyTqurYkUeES
 /RK44gqYFgNnzVd+507om20m6OI5MyVljOmu6T+THIIM7+37Dl8DDDm/ne6hDgOx/aXKDRy4dUw
 YxpPiScCE9U4ZJnvBG8M8BOhgbp5GubhRmfT4mUQsOMC3egptlS29QrLun0yuhEd44kpSMmIKTV
 uX3WXYMCVl6Y4bKc8HzvaWHcZiOzO2B5W1ZLU0z6C+pCLaGaThVAeCMdvb90/EeaR4BHLQLrj84
 pDkNLzjYMVr4vlRfjP9GdoDwSygTPxSKFbzZm/KJjq0kYz7kkEtYxKjEGpxbbES6S4QOJhxHaeV
 yRuUKEeglRC3e0tMipkXeNwjgp9JZ9/+oOGNfE6rl9s1lYYrb5gJMPxTXNd5SeEgNJ
X-Received: by 2002:a05:600c:154e:b0:47e:d9e7:1c12 with SMTP id
 5b1f17b1804b1-483c31a96c4mr2321145e9.6.1772202669842; 
 Fri, 27 Feb 2026 06:31:09 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm7922957f8f.23.2026.02.27.06.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:31:08 -0800 (PST)
Date: Fri, 27 Feb 2026 14:31:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 01/31] hw/arm/smmuv3-common: Fix incorrect reserved mask
 for SMMU CR0 register
Message-ID: <aaGqqcW6qo6jnp7_@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-2-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221100250.2976287-2-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:02:20PM +0800, Tao Tang wrote:
> The current definition of the SMMU_CR0_RESERVED mask is incorrect.
> It mistakenly treats bit 10 (DPT_WALK_EN) as a reserved bit while
> treating bit 9 (RES0) as an implemented bit.
> 
> According to the SMMU architecture specification, the layout for CR0 is:
> | 31:11| RES0           |
> | 10   | DPT_WALK_EN    |
> | 9    | RES0           |
> | 8:6  | VMW            |
> | 5    | RES0           |
> | 4    | ATSCHK         |
> | 3    | CMDQEN         |
> | 2    | EVENTQEN       |
> | 1    | PRIQEN         |
> | 0    | SMMUEN         |
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lists.gnu.org/archive/html/qemu-arm/2025-06/msg00088.html

I think fixes as this, should be separate, that would make the series
smaller.

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  include/hw/arm/smmuv3-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 67a23fbeaae..2df54ba60f9 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -355,7 +355,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, EVENTQEN,      2, 1)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
> -#define SMMU_CR0_RESERVED 0xFFFFFC20
> +#define SMMU_CR0_RESERVED 0xFFFFFA20
>  
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)
> -- 
> 2.34.1
> 

