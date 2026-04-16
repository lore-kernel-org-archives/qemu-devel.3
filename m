Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92A3F433CC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDASM-0004Ve-JU; Wed, 15 Apr 2026 20:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDASK-0004V0-Pm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:19:40 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDASI-0004H4-Va
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:19:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so3452214a91.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776298776; x=1776903576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UKm0urRhCWEb0CaMVpRTveGJe3wNsDBaxLtHvvM75lY=;
 b=TRiPwhnd5LLEU/TyUOJyWYQOFVSGlI2RGKB9AYH0/S0OX3HBCoFN8KKzCfsYZlXEVp
 aFxtILKf1fL3AJBV0fHE2R3pu3QsnmI1QECAk4TJLsyG2tkK2A0RjISbKY8+vWY+XaZI
 pVPGAso+k6cGmHdi60jfOKsbej0YgJ/FfV38dKkqV790DQJYMNpDAqY5r7enxD7spOrr
 qLL1Zaw/AMiGOSErO0QVOcyhU3JZIp8jmI2NcYkm7lwbqzNGou6Xq8vd+fg5GgSOsJjF
 kF6NifcJGwEs/4y+ehSvMMnxXdUzPugWHDhlWEGXzyBBSDfRNBjtXPX73K/zsGtMTXNO
 83RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776298776; x=1776903576;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UKm0urRhCWEb0CaMVpRTveGJe3wNsDBaxLtHvvM75lY=;
 b=Gw1DLAVu7SVBnH1ggcXkGsJDO0p8J3K13AB96wD0NbDT3bt6qvuAtrf83f4aZ94rv2
 +hY+revKpVCmm9Jla211kq0SKGLDiO4ew05zHco2SYJXDiDymDFgmHIRM9d63660rfeP
 IdcBgRS0srCC8GPGg6S+AhIsjw2QwhctWiG3uC5mW4DJ07hHXqWoNmwK7l8WRBjJ9Bnf
 3wgkiZ64sBiNMSmv6YzxrWrjaG3cBdLq7Zz1Udvwb2NoB5V6E6QAFuZP2I7Q67YL1d+Q
 eSJ/a0J/h9BSO5BGKCC6Br52aNwWo8pONen157geZNY/9IPwZLhAy3eXSBX/TChhRRtR
 cd2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D8hKWvgRNlBdQV9gw7E0TkY/aBWV/rKeLuJv4R5gNgAtnFZ7GBhl1VOaelK8/7rX/svlUkmjcv0eb@nongnu.org
X-Gm-Message-State: AOJu0Yz+e0VPNH0GZvZ82CApKagzpNhNHcFwFgKyPOPXSB87hOIolIMP
 aIw5oPsmXPq74H2n4u04cdP7Ga/bJyK1c7q52OqxlZMbZjGtqDEoxc8o4ISYUhUTAWY=
X-Gm-Gg: AeBDieuqE7h5FQkcUDrf1BiirZbWqFhhanKraroj8F92RHQNA+BXXLArAUKtgrZZOpm
 R+mQ7XXvK+ofioeqhGvtn3L28ROsbQzRP8NoRcPvFKrXmK9ErEGq9lZy3U2brfzRehSnKJPZ8NF
 lY+6R+YwYg2U11V9O/26Q7Bg3Hr+lZfPdOxVt35/tbmuHsNZmi8ylbNXc27MCrUEix/59CTbkAT
 NIoeLJFWgqoywJ5VWuO0AGR9Wj4rMPIDuk3LgoZ436IfZ4HlrmvPGz3Es/xF8p9ukXj/oeFdSaK
 z3BByEawGoZQ4j9PAYrZq+98beODZnpbJq0/ulbuekVisKuTZPqFLOyxoZ/OuZ4tnfEdJ+WSpXN
 DHJkmu5HOOCe+A2npLYcZTyxVp+ue6Rpnx4Q5z01ZriQUNMoq5adE6mUOgX0BNJUu5QI4cY4n9Q
 uYmRdWhpX9fulDkFvQjIUqPtMZr1Fk42UJM0KUe1GePJjIbNBU1FhnovXsaPyRMXxIQLrbtVAky
 Tdmf5nqCiQzlZgjUllgmIwU
X-Received: by 2002:a17:90b:1d8a:b0:35e:30bc:96ed with SMTP id
 98e67ed59e1d1-35e42781abdmr23950450a91.10.1776298776461; 
 Wed, 15 Apr 2026 17:19:36 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:31f2:aa94:4389:37f8?
 ([2401:d002:dc0f:2100:31f2:aa94:4389:37f8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132c8bc5bsm211121a91.2.2026.04.15.17.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 17:19:36 -0700 (PDT)
Message-ID: <3d3e8e68-ab67-4da7-8463-618722b941e8@linaro.org>
Date: Thu, 16 Apr 2026 10:19:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Prefer MO_128 definition over magic value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20260415220358.93063-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260415220358.93063-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/16/26 08:03, Philippe Mathieu-Daudé wrote:
> The MO_128 definition was not existing when commit 6d841663be8
> ("s390x/tcg: Implement VECTOR GATHER ELEMENT") introduced the
> ES_128 definition. It was added 2 years later in commit 4b473e0c60d
> ("tcg: Expand MO_SIZE to 3 bits"). Since it is now available,
> replace the magic '4' by the more explicit 'MO_128'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
> index b53e9e52639..447641df25c 100644
> --- a/target/s390x/tcg/translate_vx.c.inc
> +++ b/target/s390x/tcg/translate_vx.c.inc
> @@ -50,7 +50,7 @@
>   #define ES_16   MO_16
>   #define ES_32   MO_32
>   #define ES_64   MO_64
> -#define ES_128  4
> +#define ES_128  MO_128
>   
>   /* Floating-Point Format */
>   #define FPF_SHORT       2

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

