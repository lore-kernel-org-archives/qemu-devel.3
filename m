Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95096FAD3EE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjaq-0008Pr-Lc; Wed, 22 Apr 2026 22:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjan-0008OZ-9a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:15:01 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjal-00060H-T5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:15:01 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50e63771d91so42413001cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776910499; x=1777515299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVNsxBXMNh53Gc88sSJAHX3ztS+XpBkjeAO2PVoie+8=;
 b=vxc5zlZulB5QIBg2273oGMGpWILE9kBXxASYeSf6WbRnKrGE8MQKZYh1/AwPJwFGok
 ThuRaq5SbgvQhJpIkYyFiY0sr0KdcPWFR1ELFw998l5UyvgU08uk3yKhWXL/VLJV4XFB
 Ig4xTOrP6VifqoliZ3vuZEphZUw20mF7f4RxoY/oA0K5GxMc3qTrAue11UQjweu/YdnI
 UJimP0RjukfVBYKDkDVnLLEMcdy2XvU3DX4Pc7svOuMi+LW7sG6I3+2t9aTwxEoVfPAL
 QS9SkR1GyWSrqlIz08EvflPzCDdpfJzQBK8A0pg60dWM1B0NfLbJu0XyfjGtw+yqNl0r
 nWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776910499; x=1777515299;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UVNsxBXMNh53Gc88sSJAHX3ztS+XpBkjeAO2PVoie+8=;
 b=i7mqLr3x7whIVcqGO0Bjuj2qou5XGOlD/3PAExw7LONz0iJT7afQUjPBad6OBUebgc
 fmVmkF2zZBHfWLWOUfdO9yQQmgZWeWVy+4lw7SMPpJhgiovzJrOI/DbLSoKq913uAKEF
 2g511lw4iRf/MsJkzlF05SKU0t7JcN9DwthPRwU8HOC1AcvKjVH57MYK752rcR2a9tPm
 4MA29uyk9Ig1hwkQ79GcC9mh199B6sVEWNOoOZYurer+4ytfbKuRV6uF88t460CwC2Hh
 TVGjv9KJt0SCYBQLeIVAKk2y4M5WGdvyA6LOG06njcD8iwXWoPpEXyUPCxXpAJ3aZ5Nt
 eEvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EhRHDVhGbzpXKsbFGAVUrr0pwWikO9bN6lIORCWXv2mh6syh1MN9vuHzrApieXc6byRMLTpQo/IhF@nongnu.org
X-Gm-Message-State: AOJu0YxnlBqNM7ZPHZqf3tbh0TmW/ZaEHITDChmCaJvRN2ntjZ+2ABnT
 uB2/nWPkZrMPLxoF3d5H8boxFxwN35uJX4T7TiU6LrCL2DURxWPINRDX2IvFo2Tl/Uc=
X-Gm-Gg: AeBDieshOwJDtv2LcK7nAXgFea+T5+iTTnPP/YCsj9+2g+0XpxZbxMyMm7aKtuuqydE
 N0XYD+1C/iGJ9CTYpThj7q8hHgVTyP8AqJWaF2TEZfTpCbTNGFhkUp14Cro42M6G76dGX3+WvfP
 GvUrUBuaYbczOnoxjFJ+M+y4xVjpLVpgAr4BxImFFqSr8XajzWT2ETKoK3bEulEb6nIlUn5Kwsz
 ILtyAh+nt+eayz6QCV2FV+nqtU/n9AZR9pogPveTj5M3I0nFtXVZ53DyX84T9PUjy2gWHfaAaNG
 OJdpaWHcWy+zE3ojVr4dbJkaOFYB2d/fYD7nT7FxyfGzHmWgDuy7QB7yVAMyUP+nIzKwnUiw8id
 wWs7ETMiM7gdtYbzqXfk9Tiu30pAxdxwotmFbV5llvGqgPZwfRMHLme4VGnKj+LSiw5LnMRvLg5
 J93F/hVjD7cWijO1gOhWFFlRPXi9d7HrnxlIYgLOJ8sMSd8zuvxoRDP8kzqwCAL+iv4J9u25ytY
 YLn47oOKNqtEQIYkBpFulxt9JQN
X-Received: by 2002:a05:622a:22aa:b0:50f:b7f6:d626 with SMTP id
 d75a77b69052e-50fb7f6d943mr131425061cf.47.1776910498759; 
 Wed, 22 Apr 2026 19:14:58 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fb80a5636sm50730851cf.6.2026.04.22.19.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:14:58 -0700 (PDT)
Message-ID: <002fbc44-3b74-49b3-8add-a8b1d95316b2@linaro.org>
Date: Thu, 23 Apr 2026 12:14:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] target/alpha: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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
> For alpha, the get_physical_address() function accepts arbitrary
> input addresses but may return an output rounded down to a page
> boundary, so in alpha_cpu_get_phys_page_debug() we OR the within-page
> offset into it before returning it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/alpha/helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

