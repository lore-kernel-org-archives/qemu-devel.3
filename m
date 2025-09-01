Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADBDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyL2-0002WG-0Q; Mon, 01 Sep 2025 02:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyKf-0002H0-RX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:48:07 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyKY-00037r-TP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:48:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d758so1498116f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709269; x=1757314069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5mND2Ih5boPMlP5WPeTVivTllEK1Hsc+aO5g8E5ayPk=;
 b=ezdv/qYUFbdbwF2pUj29M0ZAWKNXY4Qt0MFfem2C3x9ctJMPod2gyXKhtM52AGrnyo
 lRidgU3VhC1/5bs5fncTpqWEAFnOT8PLgF2lpjZ9l31wJdsjeb/heaHWRdlLXn2aOzsE
 gVTlRR6GEG1Y0AZJHNqEKmcpL6ESJ0qc/qOBT2S/QiF9k4MFDL0AsZ0/XDcsBbYwTF+8
 xvIYUwRtWMCxMW76X+H/7ILtuwEqUNubBhX4mU1bcPfS1JBYQrRUpU5H0Xg/nNPh5wEJ
 1lUVyyXlt1Y9mlKvahQaTRIQadxLwFHrMZqY3T+g9ngrptq4bCf8POeHr/Ygei1ZmP5X
 NjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709269; x=1757314069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5mND2Ih5boPMlP5WPeTVivTllEK1Hsc+aO5g8E5ayPk=;
 b=h9eefAT2o+wuxUPgWM/nMS2Bh3BL+ykVUeSxNth/SnIDwAboi50clEIm0mXAwDA2n2
 Dm9ZC01ule35jUQJfFpcZkCUj6oTjFKqFbvGwg0BSIfsFo3RyQUQw8OLEklSrC1ISJ2+
 +YrY3jcuxTfv9eR16aAmjuSWYuHhlzftWUGZ7VPKwiHnJ5JX963T5Zn4cgn3ah/JzA3Y
 j74DPOQDS0Q9vJLwrC/E5JnrBd+bWWz+wDeTieOmrprNcqdRvkEpQdthlGYtU3HkQBlq
 s27M9wDLNiRPQPaXUKz1Je2UWlK9lKCT5gw+Gj6yqxIGDrq+igke8kNGhdFGdPyWZ11n
 iRzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygfnGGjx2zYxh+8TIOvAgD2PM8WlMDaCDQrHRpFgozLdmR/lw5E7ufe0STbOUAxTMLyj6bMAZ2kQq@nongnu.org
X-Gm-Message-State: AOJu0Yz2hZwUgMrnDPnpD1gPFFstToln2DTL/BnxBqbQ8e/1Nhn/dK8L
 ro7/KFo+VgPb9NlxA418pboRwLrfuDU2Pn2MiFYG+SkEA/iRorPVY+VuA5mS+3PP9m8=
X-Gm-Gg: ASbGncvg1iXIr2PIajbkbeG5LK1/8GbaRtV1Q91oE3M8hbtxVcXMbNxkKJh7L5yGQHF
 NCgaS59RLA4BD9/h3Uc5nbMhWvmNuxoXE9SfC+7TdPqq+Fz3YyuMkGNjvWmbPMYx+g+1gd2Mdpk
 Wy+dAqUHbxe2evsNvlVaU6NRjE0yIDP8JZ5RrnU6/LSTxYfA3r6oYKyhQaRap8qfyFtxGhEwZ6Q
 cHRyfNLW6ZGTyLllpSGR69YrFq9/RuecMYoNZu54brxL7wLSk10Nh8Z2sO6FYePMCwP/JBNT8xH
 e7ITR+h2GsZbgX41rrVRMzdunEWYt0/I3O5aRznqNa2P7v9soeu74Gwguc/+oLj85Q5qM0i5/U5
 iILqI1EYYIaLXkPrB1tOkM2MR/HEng0zbhknMUu7tt+5XRw8ySYD7LREZF4Bwu6V7meWS2lFXXZ
 IG
X-Google-Smtp-Source: AGHT+IF28WK8+IxMHExjE354vOoikf+j7ZQqHeChFd+K/JPta72+nnEmgMIgBAG2O/K7K6KRMQiGxA==
X-Received: by 2002:a05:6000:400e:b0:3ca:a70d:5710 with SMTP id
 ffacd0b85a97d-3d1dfc07359mr4717388f8f.41.1756709269326; 
 Sun, 31 Aug 2025 23:47:49 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8acbe982sm28588735e9.6.2025.08.31.23.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:47:48 -0700 (PDT)
Message-ID: <960d2126-fcd6-48e0-b1f5-9e31a7c33f92@linaro.org>
Date: Mon, 1 Sep 2025 08:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/19] target/loongarch: Add enum type TLBRet definition
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-6-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730030202.3425934-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/7/25 05:01, Bibo Mao wrote:
> There is mixed usage between enum variable TLBRET_xxx and int type,
> here add enum type TLBRet definition and replace int type variable
> with enum type TLBRet in some functions.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h           | 27 ++++++++++++++-------------
>   target/loongarch/cpu_helper.c        | 26 ++++++++++++++------------
>   target/loongarch/tcg/tcg_loongarch.h |  7 ++++---
>   target/loongarch/tcg/tlb_helper.c    | 16 ++++++++--------
>   4 files changed, 40 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


