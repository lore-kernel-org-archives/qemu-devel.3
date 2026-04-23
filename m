Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CB3FAD3F0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 03:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFkUp-0005cB-ID; Wed, 22 Apr 2026 23:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkUo-0005bm-2y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:12:54 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFkUm-0008TR-JC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 23:12:53 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50fb4a7d704so21693301cf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 20:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776913971; x=1777518771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A7rftyhxoXaZarufYHH/mlZY2wop184s51SIlAQ4vRM=;
 b=ndE0VzJD60refkAH6yBOVZ2p+Evi6TAJ7I6ByDkKKk7KWP0jZ3kd9qf3Zsec3teIJ+
 zYIFzvqi2R+0FB3ncBK9h+Rno7bL3k+bJp/sTny58ZVDE0RSpQupvITGgrl8yHUaUuUz
 0XzE66KaaMdm+Fq9MMZdjwWgzR1ptXvSEbCIFaeqOkwywusUWbi9THTBNScXZ6G3amzH
 RyT1eE40bRvC/R4GaJvyhjgC1cYU53B34P6wF9Oot/zWl1ZqmD/OoJltqPQtY2e5O6Nl
 VVx+wSguLalPSOZTxLzzg4JdsZRn/4oveCnyb4wt7kgOINbPEAksGQ2/KvtdAZtcePL1
 kO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776913971; x=1777518771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7rftyhxoXaZarufYHH/mlZY2wop184s51SIlAQ4vRM=;
 b=C+dlu23xkJDbTZ1txmyDKyenSG5+v5BTn5C0JimyZ4W+c+FpJ43Z42U5ahYN1VDIRL
 snkLrwPfEym0Zsy/jXGLbn91gAALVBPTEMWV18n0TZdLuXeoxdNC2kPQhbeuSzBbdcQy
 jo5wNMu9iKdxTLMy0uf2FsJeViVIoswsKj3uQOecn0VRnbL4JYRtKa1OHmwYNX5okm7U
 teBDfchH5+mWDo3AxcI4XVmE3DhGCesowXrDdZii2uBASQI7IjTekKClXSlncNBSGlbY
 HvqbZKMhOrsejaMrPKZ1M02/usfwLI7g/i3mcZlYFNjy7oRsLRCb0kzHlcflivfUFzAl
 tKIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+an0F6WzNSpn1q4I88IjA4NTvfpMXtCBj9LuW10z2tjtkUgRqSmakhcXpRv6YGePAJybDwfKpsdHK9@nongnu.org
X-Gm-Message-State: AOJu0YwfzNAsWDgX3K2wTuDr6ZrRAZDZwnceweH4XqODa8Zf96T2Vlmg
 kymKIgo2MICS8cRuoXgxnnlgvOl5O7UtK4NVwUS3YpHG1OWZOd2LUD6kx/d9vmYAycY=
X-Gm-Gg: AeBDiev+wFQNCt3LpfJvUbnUobP58XMk4xcuARB2ygoGB30IiigxaxxPZAiUPgP9dBX
 stx1j1qxS33UgGXhPuPW7qW8oBYGDyAsPy6B4V5MHS8l0Ky8/T/Kx4a7oSVg1KZ2bRBuftYHyoZ
 FRPNNc60cCDfAjGWb+vN48s6jTyb/LQpRLqbPCFrtOasCUab6ZKBhWKXNH7qdno14cz4bX5VFM+
 TvuffASIblo6BpV1om6M4H625GL8K06l0QqWsgIfXfHWI2Rv9LpQLyYSFyP3a+Nhm9Wb6xB76To
 BPrWcacrI8BCXCnXkJNrT7yi7GyqLzdrm3qcDcZZQFilzsgZfMHdoHGiSBomKlh79ksfGiA6OvF
 /b57SnDnJKLysmPEKJ5xJHJrTGu+yqRdbJNPHjzADVXn/R9stuQ2UwAsYh2ju7+QgsmUW5uTgey
 vyciVcxB3wmLXA7JLSR0+5v/WehxcA6TB5LAyFLu3tu2KsbTr93iJWU0pd3Z8nNo2qR7nKhj9qD
 fc+wnvzvj0CJM2aMi7ytSpzUFyu
X-Received: by 2002:a05:622a:258d:b0:50f:bb54:d3d2 with SMTP id
 d75a77b69052e-50fbb54daefmr128285041cf.51.1776913971316; 
 Wed, 22 Apr 2026 20:12:51 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fbe22130fsm45155541cf.15.2026.04.22.20.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 20:12:50 -0700 (PDT)
Message-ID: <44df274b-6179-4e63-aee4-1e29ad5f4b23@linaro.org>
Date: Thu, 23 Apr 2026 13:12:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] target/arm: Implement translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/18/26 03:31, Peter Maydell wrote:
> @@ -3935,25 +3936,30 @@ static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
>       GetPhysAddrResult res = {};
>       ARMMMUFaultInfo fi = {};
>       bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
> -    *attrs = res.f.attrs;
>   
> -    if (ret) {
> -        return -1;
> +    if (!ret) {
> +        /* translation succeeded */
> +        result->physaddr = res.f.phys_addr;
> +        result->attrs = res.f.attrs;
> +        result->lg_page_size = res.f.lg_page_size;
>       }
> -    return res.f.phys_addr;
> +    return ret;
>   }

Inverted return value.
This would be obvious with s/ret/fault/.


r~

