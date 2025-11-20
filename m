Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB60CFA447
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCdo-0003tO-9W; Thu, 20 Nov 2025 16:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vMCdn-0003su-95
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 16:56:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vMCdl-0007gq-LR
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 16:56:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779a637712so9276595e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763675791; x=1764280591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LL2DTHbodIBf6lqIpJo8S1q5w98f4/R5/KorevxL0VM=;
 b=Evs4cDaa8fKIFTHgEKYq/jiNW48ZhAJAqPfCda+DGV3MhQmwxeYLBpct6VzPwVb/8+
 2rSo5HIbx9eqL33fimDIVeBZJdiZ8DtWWLKvVe2mbF4TKKOmm4/Cb+WOY6SoUU+nHQqg
 sqOGS6if0ghQpg/aSja5g9oNHgciP+pCgVF/rktFAHtmv4+GaJ/d+pDgFHjSK9EEH7cx
 Efz7hD5m/OJATlHHV7MeZRmm3+HZoHuJhjmQLtblgd/szXScg/wG5wlZXuQlzI37HE1u
 iaeHAadxEDJowir9Hjsl7VfHAOZP8L/zpMXwe+6IbF+VysKKM2Cpi5PvKBPg1VKSEXpr
 zsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763675791; x=1764280591;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LL2DTHbodIBf6lqIpJo8S1q5w98f4/R5/KorevxL0VM=;
 b=YfzLnAnfhpx0Offp0GiAUVhDgM6ySoD8D3rxjQEzVkiYIn81rRWgXa+OZLSFmipEpB
 U6nR2AuJz+/2ZKnFl1vS2n0f5uq25BEIXzlW0fAlKRo9iLlvgYkXvsvYCxrD3p86xrth
 KGAtFL6gJHz7AJWGo44+toghKcb+1CgboSve0pNjLAj17e8SkDC4cD3oBB3wsfQGTdjb
 ju5ARnLRjZYhC4QfYtldnoTPR0khjGYJDXB8AZCwgr4TThxh+uJAsIB4bkP4aGcyANrd
 u/5g905zNSlVFwOsb8b/LxnRanJsQmbE4GYYip4qIRJNgiqlIu5ZktxcHNAsKS8QwZdP
 +L1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtP00LraTidfnPgZnwd/5qBIqEm6jZszacslCo1MvcB+W+k03VQ3ZIj28FNFvF7yNMC+FbGPt7soaH@nongnu.org
X-Gm-Message-State: AOJu0Yz49/07YsYRV2quyDPB4YpoQMSN7ATbEPkPLoJu2Wp7ow0wElex
 JQMbGkO/jUM6cExf0RPOo5PgC4c+1iOradCC3aQYwYikvKGHSn8DBJNFFAlZFmGPCWE=
X-Gm-Gg: ASbGncuX/NqNnTgi2Jvy3BrZywt2fvTd0gfPKVEkJ+dPkMc6pMFYIZnAEWXKbikeClN
 /ibje3m7aAb7ieO195VAJ/NIhaJnp6nAVhLDscWYLPMG3WaswapP6qSeg2mlkli8NWeGq31L5pm
 w6H6ei4a5snvVItonU1kQ7MCvFWqhhyVRry/QyTkSB9/xtQJyD65+4Kxo4mZXKASlqc1K+lnz4I
 mSPx6xsbbH2mqAOfeMj+gtDZ8TeDu+KuFNPTcD9dEFCpGRGmKAEHEAWZMnTCSZ7Z4LJvWJc99T0
 5KuCi5Ajgtg4bSAkb+iyrldHYPyfT8EbeHOT54v7FkzdAh7uAK2+8pEySyy9hyFTn6C4RNfjw4C
 y3hAo9tuceW2PVN7mlT5TDzWhpoy0No52bIM9kJnRJnAymshokurgoRvhLv8WVRSPzoqCNeH9ls
 XuFoXMwb2d6C87fJLT3hvobZmqtEL1O+MalyJAy4UZ94IPgPkowXKI9nX7i0huIQdb
X-Google-Smtp-Source: AGHT+IHDtMpkkU66VmqH3E5xcDnS52D2TrsjSwbSqfPoC6MotYSyRjzfQcrZD7PYWcusvCqVlVHYpA==
X-Received: by 2002:a05:600c:8b16:b0:477:94e3:8a96 with SMTP id
 5b1f17b1804b1-477c01b512cmr1781945e9.20.1763675791425; 
 Thu, 20 Nov 2025 13:56:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:33b:f1f0:3d98:8de:36a8:e1ce?
 ([2a01:e0a:33b:f1f0:3d98:8de:36a8:e1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf35f976sm10151145e9.4.2025.11.20.13.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 13:56:30 -0800 (PST)
Message-ID: <f402ffcc-5af6-41d6-8db4-b04b593259e3@linaro.org>
Date: Thu, 20 Nov 2025 22:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] x86, mtest2make changes for QEMU 10.2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251120001649.1085913-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/20/25 01:16, Paolo Bonzini wrote:
> The following changes since commit e88510fcdc13380bd4895a17d6f8a0b3a3325b85:
> 
>    Merge tag 'pull-target-arm-20251114' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-14 17:59:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 58f88d0bf7c4c0676b54f97ba91eecccbca968c9:
> 
>    replay: add tracing events (2025-11-19 09:24:01 +0100)
> 
> ----------------------------------------------------------------
> * i386 fixes
> * mtest2make cleanups to enable per-speed dependencies
> * record/replay tracepoints


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

