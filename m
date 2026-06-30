Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847AEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec8a-0003OP-5K; Tue, 30 Jun 2026 13:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wec8L-0003M9-5R
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:20:29 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wec8F-00067X-OX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:20:25 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so2234338a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782840022; x=1783444822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jTDKMKqm9o63gnN1BUWZfeIuQiPMMr5RVXJOk3oO43I=;
 b=trWARW+cQPP7gK1nyO52UG39UZcZDA8g78HIZwfpjjo4CupB6Vu4Gwik8DrYcvroZ5
 m7PNJ4RNcOthn5JZSM2JcxP54A+ArHG7zuELY4mgak93KrkEMZgNGH0AHSIid0skJ51P
 KV0xD3Xv7bls1i+yCZw2G26xzU9Q7j3oX4rGC7xOfOMaNqoCDC+GIdkOF9iQkIISXC4d
 PtoV9VuAo1iLi9VzZECuEwqWjSnEdnwlWEgowolXw1d20aT4JY+GwnxIDHTvTblaROVG
 csoTrxMgAJBBBiUBRFrwl2hOZVrjzTp9h5UCi2HVqTWx6hTVa9eFdtjaLAiUQrg4dnz7
 d4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782840022; x=1783444822;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTDKMKqm9o63gnN1BUWZfeIuQiPMMr5RVXJOk3oO43I=;
 b=G628otNsndQ3l3UrKIC7BS//PIS+J6foJEMgM/6DdRG1kcqQOyUrdJMiuJkPEvsSIj
 bhkvjJmjuoDZmyZ+b5b0P6bjrkbaBLSZ/V2POgP06wzlGVRSyV1jVdAL4/BiAQfzK08j
 oksC/o7UCRXg1ocsWZ58xMWQ1+FhbXKxfmuJLIti7F12vzB/jwBfsVvuq+iB6pwTyPWQ
 HOd3LY7DG+r0jF2gILN44V0oH5Wx2AZySfsD8OA7itzlDXbYk9oTlfHR7ylibtyn5BqL
 W3cAfu9oWWwt8aKHrfAO3SM3v4iYyPF3LRzUsJKnqRaXnIf+0XMQljfn3IkaCaBPbnqE
 scEg==
X-Gm-Message-State: AOJu0Yz4WS1JEz77jeAE6nnNBUOS1+tEuEM/s3VrY7Nzii0iB0d+gx8H
 4XxhhFON7DQVJw2t3LRKgKUAC0WNzsG8PYSFyNx/R70dQt2L5Jh2O1N6Brrh0++eGUL8zSBzN7m
 JwVcd
X-Gm-Gg: AfdE7clwtev09gLGJvduGoex5VFoRXdxHhIy6Ix7z2ukHMGDs7VG6QTWQB/seM2nCAC
 nb/jR4BkJdULQDqUtge2JFHA2CmfRB+VAdRKWjUm7l6sPsRVbtpWLLjmIaCkOmsPAwJlw5WqYpH
 KjF/DZTSTLsKE/TSo1Vto35tVG9dXbcPSdJjq2GEIo9CXqbrCK7DiKvgpTANK+ooTrhl11wIbkt
 rB4qQyjiDU/v6XOwGTOb2HeinnPvehKul/huhnWf2hztGiySB5M+0j0XDVHKBt5+uSs5ew4b7sX
 QZFUMylC+dmVSrvNvj4i2nzVgPnMcI8WZ3/akZ0dQEK3sRwOjDpmIP4YPX9YVZAdl/Y83axheL/
 IDatmeJYVg4GgWjmgGHHQaBxlegHovcd3jHvXXeE5Fq+PzG8IkynTw7DGbj1MrRA71DqTecqJPA
 0OKd5TDQNz6Sjso5qSijdGmrW9YaVk9Q8mAgtOUj6nZYXWmfHAR3MkAGapOA==
X-Received: by 2002:a17:90b:4d85:b0:380:8bba:f8ae with SMTP id
 98e67ed59e1d1-3808bbafcebmr1156063a91.4.1782840022022; 
 Tue, 30 Jun 2026 10:20:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d29965sm266494a91.1.2026.06.30.10.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:20:21 -0700 (PDT)
Message-ID: <7901f56c-4ac7-4f45-98cc-938a3fc0f39e@linaro.org>
Date: Tue, 30 Jun 2026 10:20:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] target/arm: Implement FMOP4 (widening, 4-way fp8 to
 fp32)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-8-richard.henderson@linaro.org>
 <d7f02bdb-4096-4f29-b479-dc10e119aab6@linaro.org>
Content-Language: en-US
In-Reply-To: <d7f02bdb-4096-4f29-b479-dc10e119aab6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 6/30/26 10:16, Richard Henderson wrote:
> On 6/25/26 15:31, Richard Henderson wrote:
>> +FMOP4A_sb       1000 0000 011. ...0 0000 00.. ..00 00..         @mop4_o2_s0
> 
>                               101
> 
> Oops.

Double oops: 001.
I'll definitely re-post this series.


r~

