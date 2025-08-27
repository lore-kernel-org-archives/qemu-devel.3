Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E0CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNml-0002NS-Cz; Wed, 27 Aug 2025 17:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNmj-0002LC-84
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:34:25 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNmd-0003X5-21
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:34:25 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b49cfd967b9so220971a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756330457; x=1756935257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VvwoSf59nDpGXrvCz+xJ7L6tpjfTCVPHiYvGGXw1r+M=;
 b=I3sINiPzTERqRd2zwe5yIBfoKeWtHc1Rzqgzj0Ppy2q53j97ckiWQVvFlX9rzDyOrX
 o0WsWbWBm79j9w1yrIGAPD6wkSBHt8MB/xpel4J+hfYJ5qEj6EaOW9zaQrryZRAx+fP/
 BakzYUZFsVp0UEhGOtRE1Cdhsm4rruswHaCSJiRB4mb3jaIwR3Bsnlw2lLmQYeSEXHt4
 OX1d9ZifgRaUIlZgonZ4ElhMRxmwgOOxcIHeVPa6TxP6YnApH7g2ZJnQJNlIGE2tpfNO
 KYLy9y9msgDoI5ezPdyGIVfa6k1qxyuPlnus/mqFzUcECbFwUoe+TVGPKTjmzTtPfxTg
 YU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756330457; x=1756935257;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VvwoSf59nDpGXrvCz+xJ7L6tpjfTCVPHiYvGGXw1r+M=;
 b=vhac81NHjZ1RRjK64X0y8s0xdYVC7V2HZOjfRmS6aDar9lbNoFBGs5UvNGW7kbVX9k
 JCW8JtSmeL+WpWrF4PbJdwmEijAvtZBpRIs7Z896NcFnjKPpCpDeUPNvM1Mx0U9wxGvp
 cphFygZcB0ZSY2eXyWKUvAr5aS/8GCnqbHVP/dTVTVHFHRYIOIExVrb1hZGftIaNXZOf
 CqbCq3oIYqlJsyBNzRjOdw2cRKnsD4Z2BuBfSVUVtm/Szan64F60EGG+IcQ9BW7V4gKz
 MsbQvkHnTmbXXtkHUP6tN6mLmRUSkgAl3mI5Ai/tB6JuYnCOOPtmzLVM8gh05WAjdwmF
 U3hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpN8mrXVtdz9jAdoEXquzUu+MPPA+3yOX+qsiDKrqLhNEEjyduSMHHjWpMW9q08Snynek42CrsiWM9@nongnu.org
X-Gm-Message-State: AOJu0YzE5ujI+L/Dg4s+ygivGACUvgLEZWnMHggKhrd4UaoTAeGnCXXn
 oBsPUKCBS64cW/IHXlkVfIPKmPp0CpBQqW+N6JQYZMAAvpotv4i7CCwTcApIcntXNo4=
X-Gm-Gg: ASbGncvUVOPFME3TkeoXVSRy0vCFL1D7v8Xw+7tjMaznFBhyqq1ZSfrCdf5LsIFKdKa
 ztr9LuB9dXtIOdo5A5Uk3iXu/xNzvjTwTbpybHowWoqjF92wfZh+5r05KYp8yHRuh9oRDJGEsjr
 IupWb6HgnOOwiiyWWKrTDf4IjxhzKIA07IDsbYEhz+e57+OD+EFX7iy2A6HGkRDAJdsD8hpXx27
 jbwCXLZx9luhm1OkJ8nHbuH+ExarfTiMuUZSGDw/SQ7i7xVyzZZYvhSZYqxqh2ytj4K8E0/n3rR
 YSH4jFCWJOUYYUkaIDhr89jsVuFNAJJSZavhz4Z4b3hbJGMTNEWcHRmm/9HDjLLzVpOxKGmqGyk
 He9TaQBhHaVVgDMSCrk4W8kErUCBL/cdRf4fH
X-Google-Smtp-Source: AGHT+IE/K49dErXBwhLULfUXcO5yUywgEdxQUyrnJMyFgserlcVdruh6KG/TP5hrWo0YdCgUGmW+qg==
X-Received: by 2002:a17:90b:1fd0:b0:327:a638:d21 with SMTP id
 98e67ed59e1d1-327a6380d31mr1237986a91.0.1756330456456; 
 Wed, 27 Aug 2025 14:34:16 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276f4c7345sm2973854a91.0.2025.08.27.14.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 14:34:15 -0700 (PDT)
Message-ID: <4ba73402-0549-4044-861a-93ca12e222a5@linaro.org>
Date: Thu, 28 Aug 2025 07:34:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: do not print IP socket options by default
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 qemu-devel@nongnu.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee@eucas1p2.samsung.com>
 <20250827095412.2348821-1-l.stelmach@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827095412.2348821-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/27/25 19:54, Łukasz Stelmach wrote:
> IP protocols should not be printed unless the socket is an IPv4 or
> IPv6 one. Current arrangement erroneously prints IPPROTO_IP for Unix
> domain sockets.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>   linux-user/strace.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

and queued.


r~

