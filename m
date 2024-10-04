Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B1DCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlMn-000871-4Y; Fri, 04 Oct 2024 12:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlMZ-0007hy-C4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:41:08 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlMX-00079D-0c
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:41:06 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fad5024b8dso28411071fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728060063; x=1728664863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+y4+WYkreFGHAipSsNLpz/IDl/XzNgj129dRN6RJI1k=;
 b=UuVdwDrq9aG6QYzXZPe/EQStU5lpuvxeBB0gHFHnNpHsFbBFj0Cd4M9oXfgHF0huSc
 iVNG8Kpv8Z7rO71tkAaJycvf7OLVURFOTxygf6DsUqbXDw3nCrxcoadzwoO/akqWCRtQ
 Pdk02kkXmlFv0LldiPDV3Prx13h+5JOGgKX6LkBfgs2JcrG7tzZm7ZXpYv10tkKthXPT
 BDjemhE2rG61LScnSjN7cghNH6IlOR87AyFU0eiiurIFYw7uV2Y/lno+6e/bXLpQnG0o
 XEaBbxYWcz3rxbTLi4RL4v1ti36ngrLimDEogRuEkZYGxhspsjeG4zRMmDTzeCkiT/wD
 jnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728060063; x=1728664863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+y4+WYkreFGHAipSsNLpz/IDl/XzNgj129dRN6RJI1k=;
 b=QJIc1NRGoiFZPbN5cpYZTFEHFNjKps7AQp3HzBTYZQliWA+tEAXzuklYv6H8uCVGEK
 dfHtPxQgjh3js6OpQQ0bFMBxt856yf09KZ7S1TlmYoWXPJ3jx2Xuhq/0I3ypdSqQYHJw
 cRl+aga6ZbGZODQbDhP/Gt4jKS4v4em/RsAcslls9ogEpbwXyH5/PFZQF/dWYZzA6pik
 cOLwVOHrWBQOmP0Ms/pYT77YyLUvavu64g6wSI6QNGinZRNkwCMDIvlDvsAppSe8Q4SA
 Oz6iA2KPlKpc0GSW2i++M5WAyalfsnvj5Iv3Ua/nLbrsODHzOX+prwMzv6fnUCgNzldT
 ej/A==
X-Gm-Message-State: AOJu0YxXt+pJ1sLzhaXGwWeUUpOyAD7BF/a6K+8yggducwWa9ybQfvhV
 KMnR0bVq8a6KF0ZeZR+rDY9Vsb0+kQALkmUoF84NWcordFUebbNB6jhfOMcTBniQspDSLK2HKSL
 BZfY8rQ==
X-Google-Smtp-Source: AGHT+IFd4mvKK538yi30/uW/twLyYYuPM0cLQRrdchENWoswQePkmv4W3XcwowF3ZKy231+PqqoBrw==
X-Received: by 2002:a2e:4e12:0:b0:2f6:2b51:ee3e with SMTP id
 38308e7fff4ca-2faf3d6e85emr15481781fa.41.1728060062665; 
 Fri, 04 Oct 2024 09:41:02 -0700 (PDT)
Received: from [192.168.132.175] ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b32fe7sm217111fa.112.2024.10.04.09.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 09:41:01 -0700 (PDT)
Message-ID: <ad6a021c-6a33-4b87-ad2e-e4e33d992ca4@linaro.org>
Date: Fri, 4 Oct 2024 13:40:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] hw/m68k: Use explicit big-endian LD/ST API
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-18-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241004163042.85922-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 4/10/24 18:30, Philippe Mathieu-Daudé wrote:
> The M68K architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=be; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' hw/m68k/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Per v1:
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

> ---
>   hw/m68k/bootinfo.h  | 28 ++++++++++++++--------------
>   hw/m68k/mcf5208.c   |  2 +-
>   hw/m68k/next-cube.c |  2 +-
>   hw/m68k/q800.c      |  4 ++--
>   4 files changed, 18 insertions(+), 18 deletions(-)


