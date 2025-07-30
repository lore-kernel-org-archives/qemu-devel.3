Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE3EC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzlN-0005nG-1J; Wed, 30 Jul 2025 01:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzl9-0005Wv-EO
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:53:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzl7-0005eG-ON
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:53:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so2102971b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753854827; x=1754459627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4sSSa1QrbwN7hbS+zwCXiOdwfQCh+I7gq6KP0Y+km5s=;
 b=uxPxeZfHz82rRzNWGlCGqYwMsxuj88DYjqjevBuM0WpGPrg9zHzXtoYv97pge6Xjm8
 CjhMu8kJJpBeSyEj4W/55d7Ns8ajQZBpXIN39lxx6PZzorUfXLMmV/pwTTru9fTkJ17o
 /dmjfrae1HxvMoLI6wbzUxkpfK0zqnThJ6nmGQnGEiOykJMiRyCJ1n2FS8tkkcrmaFzX
 gK9MpBA6BCRO/zNx6CYtnf0MPN03EjpKmYlNYr0R3+d8ezhoELHT1UJYB9OZ3Vq7TaJ+
 Qt7Q5+34T12BstgjksCP7tqHju2hCRJVAXv4obm/4wjMdlij9/FNobUvvjMDFYFe3agf
 dmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753854827; x=1754459627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4sSSa1QrbwN7hbS+zwCXiOdwfQCh+I7gq6KP0Y+km5s=;
 b=uE3vH1gczyvPa3Dt6HkgbCK2U8Yg87msQ3HSJnHwgEyz1horz8FkhWuMhRWQm7ADs2
 RS1pVvvztvnQHUzwJnjXVDElgLoTbZIMCXQDdxkltFJbJ68eIS2Jy7sghYv/JlOY2kZG
 7dQu4F+Uhd7oVNSYf0/+xRvzqmyO3pIu2rj7hgv4l7OfskMhp8Fuf+H0S6hVlYDsVa7d
 NQFY3jowYV7Sh6P4uMg4eUtikAaccDqKvaacjqstr9s3IGf4wp29WHu1gYtVgrHtMZE1
 XnsurjtoPhnEShAOYsdUXCLMZNBNULyszbpQwR2WUaPfmVpKCwo7fB+2Pj2z89SlDeLd
 Rl1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4uZP+LGt1e45ZmZzjumQCcKNRha46oKIf7z+bcpr9Sg0pW7Qh/6zNdB9YakzA4RSmFD3gB6BYIvA6@nongnu.org
X-Gm-Message-State: AOJu0Yya8J4iJFzn7qgv4bGRsmtjlRRSzxx/PDW6Z9SezmEAmogX20W+
 e7n/bsh2uuJhnXkjneb5h+rnzgW0aUUucOo3cK3p3Adt97MeyDTPdiRUXHlhU6TXqsI=
X-Gm-Gg: ASbGnct8shLmJyyi7r/QJSMKA1OFNrK6d1A55uFheLj17FXRUciCyKNoBgowfc3IoDa
 QJ2K8N4yqtLohKyEuzjVYXdkcPr3QrRQ3vw677LBooznbanRvhZUY7TFGWPagppsp8DaxUIz/hf
 36bwWznTtSTbsIr1Yh6UDjAnpCxNiIlvTj3RoRT2bQ6Je3F3PPBrRvTjIr6IIg4wNrdYPeNFTeL
 V8pNLmOBLB0GpLYFMekVOXoBQ5tSMVAOVZC/ENN/Xjzwe6FXkxNIo+4UGHHhwH1VBitjLSsO/VW
 fNQMGtq0N9Z/2znIuJfODRrF1YBVxHfNDzt8RM/jN66fQ6DGLBSuWhDrvyBomXcTH9uYWdQ7kX2
 YfMs4KBg6H9ncHaWQvrDgLY7+52hQ6HVSM5BACi7dIf16uRemed8JzmUUmNru9CM9o38zhegmI4
 K+hw==
X-Google-Smtp-Source: AGHT+IGXQpowwb6z/XbToEv5kJ8vqoawCCtasRUmPyhm4KYP50sLDo+d9wPMLo9mr2V0rGlsdvQ9AA==
X-Received: by 2002:a05:6300:218c:b0:23d:ac50:333e with SMTP id
 adf61e73a8af0-23dc0ef492amr3010671637.43.1753854827454; 
 Tue, 29 Jul 2025 22:53:47 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640882071dsm9020682b3a.16.2025.07.29.22.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:53:46 -0700 (PDT)
Message-ID: <177c5175-660c-4ea4-bd82-e68395ba34df@linaro.org>
Date: Tue, 29 Jul 2025 19:53:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] target/loongarch: Add enum type TLBRet definition
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-6-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> There is mixed usage between enum variable TLBRET_xxx and int type,
> here add enum type TLBRet definition and replace int type variable
> with enum type TLBRet in some functions.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h           | 27 ++++++++++++++-------------
>   target/loongarch/cpu_helper.c        | 26 ++++++++++++++------------
>   target/loongarch/tcg/tcg_loongarch.h |  7 ++++---
>   target/loongarch/tcg/tlb_helper.c    | 16 ++++++++--------
>   4 files changed, 40 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

