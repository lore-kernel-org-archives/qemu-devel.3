Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E39FAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjm6-0003Mt-AO; Wed, 22 Apr 2026 22:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjm4-0003MY-Ce
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:26:41 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjm2-0001g7-Pp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:26:40 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-50e97863425so35913801cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911197; x=1777515997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QePx5738wCk18mlQmkLFTPIgFp2M78yLG5M6lr6Truw=;
 b=LbRZS+F6T22+vrQBN/+nEXGZPzoSvSCct9Q+CSOxRINZNX2IA/QZMfe1XQg2h0KJ4Q
 eRAs3j2o+uYJYBbZ+1fki6gl3YI8toll2I6JAWOecL9wYhsaEFn/IzFupsaWz9Xz19Ai
 gNUc2acjIw0aEFIEltSFMjjGiL8R7sjcNHn7EcMPw69tTGn4k6EsXsXD2vl1svR4FUZa
 yPbPT+eyOASMd54gUvBTcyo4a/FL+jwNSOUq48eUcreCpu/upaK83x8NsKr5jTcrQ1zg
 Iga5RrBOZ5rcLUFcYrEjIMHSADL3Q9ylha9IiAJSeSY0KsrMfZp+6qtHTCvenXbqzl6g
 YcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911197; x=1777515997;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QePx5738wCk18mlQmkLFTPIgFp2M78yLG5M6lr6Truw=;
 b=ELyfiqxoUMZrA+KxWEJwbZUl2/tqEODZSkuGBZ+3Tj9XiB/mP2BA5oJRRUOY72ePFT
 trWozYujwmRyVOwwbUONmbL17b7FDnqAmqedNvQX/Zg2l08DG19VUfBjg11ofvGoVvsJ
 iWLQZt8EkGHui7ycp3I1QM9bHSwqpgvm3houTHGkdMwwSAF+tsdb0sxQZQh+Og6sYxVn
 VpnmarLgPLQq6il2D2mfhFjMz3+dWZhuIQ2ATpyql40Nq81c5qyz351syqUpVPl8jcU7
 SLcctfC6XsngfcWequ1UFsccQ2SW7rwZiJR6w/6ahK1Fcu0np2Ke4pRT9497f7CMTLtr
 BnBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u+RWOb7LwzrUxrc5Wi1H4gBHFCKKHjlTKa3Yd8e+i6GEhQNyHNUnhFk64CO0KdlbTi0+XLcOxrieR@nongnu.org
X-Gm-Message-State: AOJu0YyI59DTcjGL/UvFoI0JAQKFsB45Mxgrbem/oiKkZfv5s77Gmciw
 mJqBX/3S8HDIbrEfNo2IFUBP+JX7NINURmDyMKTv145pRdqeF9NPDI+IW/hKAGz6Z9I=
X-Gm-Gg: AeBDievejtK1pcRcgqqPXiFGZhIypcjdIaleMsN3sQ9g6xpApXyuBfFTRrR1J8pHOHM
 smVBEMeB3NbUvDcQDutnJyrB14g5fLZzD5g7iY4gEMYsupTjgVY/6A5BdzZ8eg3/rIsHkyUl5zL
 SViTqs9KVfYvOxUPfGYWRTbhg6t0K5nLg0YYCmfK+HuXQdmJuOmWf1ucuoDrNgorAl6ZIcNGJh+
 +EXHtXMYvUygci9C7sArt9VPmQrD/oO8hMUB0OqBtg/4HkXaDsT9tQb5YPSb2CvnN4SmN+TH9iW
 IKS9P4uDhSg8bAbPHI+NLa4FtN05DJn7tWaRauqh83F59cu3OO4X0GfnHSQI6R7rs/CA1VTJKw7
 gMJViFlyZFt4VA5ktOM0UMW32alI4SFS3yCGfsqZ65mJSR2RtLJYst2J3i0zopDm2YO46KgMzyz
 +Z5+e+VD/CUYskvYB8wZ0Y5lmqW7nBT+D87fNZJGmMz+iVgG4js0h3kbB5snCtEQgH/rgq2aNnw
 43iujHn93kJRHqabrFi86U6BVS9
X-Received: by 2002:a05:622a:5805:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-50fbb77a4d0mr140873251cf.25.1776911197606; 
 Wed, 22 Apr 2026 19:26:37 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c44esm146469026d6.27.2026.04.22.19.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:26:37 -0700 (PDT)
Message-ID: <4d4ee9b7-8f2a-42d1-9685-4d56a339ccac@linaro.org>
Date: Thu, 23 Apr 2026 12:26:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] target/sparc: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Currently our implementations ofSysemuCPUOps::get_phys_page_debug
> andSysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> The sparc TLB lookup code can handle non-aligned input addresses but
> will return page-aligned results.  Rather than attempting to change
> the internals of the lookup code, we take the simple approach of
> ORing the page offset back into the phys_addr result.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sparc/mmu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

