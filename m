Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB695CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43lo-0004e0-0f; Wed, 01 Oct 2025 16:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43lk-0004dC-37
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:49:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43lZ-00022q-Hb
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:49:46 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b554bb615dcso221757a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759351763; x=1759956563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Op1UVyd9mjX/RHrQJgTTpvDA5vEALC31y913MF7uvR4=;
 b=mcqC9LOD0LZKfz1j+bI2tebpzBHAhHtWintZGw37Z/6JOH6sqXKxj6i1rry+GjgDmF
 sUQVRtz/fsLDeM1HyIqoK/1dK7MwJSUSAxQFkttqwgx1ZSVbm0xztBGJVQozUCc0G3km
 GXtthWr+nrLWGqAnxiXVbJD0/WW4WR9TtvSrKsIL+f5kal46nblGWkOByoUnhYXQlme3
 WdPVDwY68HGU6biwep/pILtlpsXXnaOpcDz+e4BYk9xROUwQXAj3Z375ukmErUioJKg/
 DdKIo161vJNELGx5cRRN4ec7vrI1jAA/XD+5oUiXjfK+x/eXbmlLHVQThCFLbouEjg06
 gCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759351763; x=1759956563;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Op1UVyd9mjX/RHrQJgTTpvDA5vEALC31y913MF7uvR4=;
 b=PMV79hiaXU7b3YIFuRYqyVIsLiPz4S+RjCUG8muGOpULO+o68KOUkfenaCSdjT6FcK
 vZ2hs+KvYjFMmVn1502Is3Muo1b3umLpP9+Lb423H3YjhmcEdQKkwJd34tWeGm1y+EPz
 1dzbQ/vciHzOlDe9SQ8+b9gRBjwYDx7V0XGu13NKfb/RELbEadx88Kje3KzaWMC0RLrT
 SOBvKkAXgHA/yTvHL/h3T5+7fFSUDxFP+ZHXE1qZwBJl0LYAD0MrVqttOQWrMMKl/8dA
 1tyqbvE9IOBS7yCSQsqZZETb1Nn22occtKE/yScHZ+Hd7ePE5CFtJwB8xIjRauIxXze2
 vwZg==
X-Gm-Message-State: AOJu0YwMIzedtl4h0MiegCPjKatxgfEfboM5EzGNUhP8KSAGlZq1CrJP
 PbIb3jP+Rgoj7+46868+XjXkyYkjbofYBJNt+h+x4Ey/kBVP77WCMfRO2U1Vbjs3rQRgGPCv3Bz
 6fh/LczI=
X-Gm-Gg: ASbGncticZN4nWz78sleBhLezQZVdwp7NeHsC2jUTtbt4f0L563hQCPWlMs6amMdbY0
 wBt/90Dv5UFvaPhEclLbft5gVFvJes1OPntXtmZ5EF+zc1dwFM7MTUN42ZIgFBYquhcUI0sAIvw
 McwpNbV9CqFIasqWjkZ32Fr2u2gmIyruUopn8eC5W3oEZmpZJeYYE23XZAJ3Vifr6gYxP8kRqsw
 LfJAr7SIuhDpSaBk1tLNLQquATu1CW5nuKRvHELiYg1lR3ZT85CK60liuHS/4+qPiC9DHq7+L5C
 G9HTpM+q44NNrBFrnVX2HjTRtay7lzo6bjzCT6kHcRL/BJ5ADFPIRGm44IbD1GoJ4LmTQNzxLPq
 auPMOl3K5VGWtEGxuwuzJ3sRi9cF4kHNJGoRBq8idYRbjz2VuUdGHj8ed1NFf
X-Google-Smtp-Source: AGHT+IGQSEqtCqrnbYJ9tXLDHgXM6o0M7QMvCT66mfWMMD6cqt8l6g98ph4Z/aBboqiMXyE1hqtnQg==
X-Received: by 2002:a17:902:d2ca:b0:26c:4085:e3f5 with SMTP id
 d9443c01a7336-28e7f328c06mr59758845ad.50.1759351763568; 
 Wed, 01 Oct 2025 13:49:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1ba024sm4760405ad.68.2025.10.01.13.49.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 13:49:23 -0700 (PDT)
Message-ID: <d03fb69d-ff65-4707-a3e6-8c6224d411f4@linaro.org>
Date: Wed, 1 Oct 2025 13:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tests/lcitool: drop 64 bit guests from i686 cross
 build
To: qemu-devel@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001170947.2769296-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 10/1/25 10:09, Alex Bennée wrote:
> With only TCG available we can't support 64 bit guests on a 32 bit
> host.
> 
> Fixes: 5c27baf9519 (docs/about/deprecated: Deprecate 32-bit x86 hosts for system emulation)
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
>   tests/lcitool/refresh                             | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

