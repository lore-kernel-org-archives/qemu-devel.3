Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE4AC36013
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzLB7-0006VE-OK; Mon, 31 Mar 2025 15:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzLAw-0005mL-Be
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:52:04 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzLAs-0003qR-WB
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:52:01 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fbaa18b810so1531990b6e.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450716; x=1744055516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj9UE9/gUBJGaROADIL+FFbD+SsDQ8BehufltRmIE74=;
 b=Vv3JvyTB1HheCg4pUl5/P8BNkHoj7A7HbWjlLrniqRL5tdl7g4RF9BflPyV4e91zJM
 hDs/MmG+UVCGiCgvK56FwnqLwiCc4FMb52EzwEpxIitqAeyJugXtlR5sZXJrmgeY3Vnv
 Kf2p0b6Jtw779Z3BeoiQN2QdZ1NCXT4O1q/I6SNlkZvy4609C7XLtqBkIPmaWxzZJMg6
 i0roxIkqU5el7heFI09ccKa9AI6fC6QM7HULBJqkZxlaSuL6BSQw4x3+8qiaKFDFxcQe
 i18gHFFRPZVeFV2kkqxkf2rX3vE/dYu9aVzZ/MAdVczL6d4EM6rBQO3O8Kbg/YtemYC+
 IH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450716; x=1744055516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yj9UE9/gUBJGaROADIL+FFbD+SsDQ8BehufltRmIE74=;
 b=Lpu0PiIumV2mRaL8N//lzwQp1JUotBIfraChJGbubz4/Y6mjY87UhLc/+FoTJY83Bs
 c8N2yEXAoyjwCgit1JmK/E83+oeUSwKBUWx5zPqmCf05Vu6Iiuy58K+T/6+im2NNF4w3
 VlKCeF0P1DkNrX1tgA5afX/MkSG5W/5cS2eHdzxulfyEPMMhtssJ+VSjP5tRJHddHToO
 vm/bXl7euuMq22Cy41sjvoEXjmX3D+vCzLWtgTJVP/RuQ0stR8bksimDHiSoIpiVA/eW
 9T6k062avzUonC5T+EDRQ66yNZzwLnXdkX4SwRo7qkZPlg9hazcanp/It1voD1Yckrcd
 ZPsQ==
X-Gm-Message-State: AOJu0YzAraz4IRRdugF7arPRj0NrqPGrFcqFjDhganFr7bspb1/JrVeq
 Mz3uloSu3Msm2N3h7Odtk7EdxKNp3/LbE0shf7Z/pGHjk5J039UfxCpBdd+WPmo=
X-Gm-Gg: ASbGnctNj724AjDcdRMsh7CpSTq8IBUs5K+Q9K+stJdqQvuL/C+ZGJ20SZyY8VDwiFa
 knULFIpnGPU/lGdB3bTWBmueqfaAPrTldQMz4M3LQxwzlyH1ZMsXToDHKGSyIvcDbcqjXfDxYCz
 /WfmO0JV2XXUtRs3QddBxCucRmz3BOCoHY+TiySiDB/vsqQIVAr8dfGkIGXMHGxqE5qaE9BHHnJ
 8GyvcIRM6vNOPvZ/NjsmRVxVwFwvGGS0VQYI5InFffr60OTC4ECr/gbZeomM1BEkqhbmQ22kH6E
 +LKkg+o7rMZJuOtzrzrxS1sQEt4bHBLccpctwWqnUr8vwqPz4QEYtLaj3hMmQvNiCmacFp79rKD
 7RvzRe0JQs0RVRmbPgh20ig==
X-Google-Smtp-Source: AGHT+IFTTc+bb9X4gaxXoRajlZs0w9P5LFAKE4vubScb880rK+dTn0dFadQ/Skz1K8tTXeB3sgpzhg==
X-Received: by 2002:a05:6808:2121:b0:3f9:8b5b:294c with SMTP id
 5614622812f47-3ff0f6100c8mr5222095b6e.31.1743450715827; 
 Mon, 31 Mar 2025 12:51:55 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff0516733csm1645298b6e.2.2025.03.31.12.51.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 12:51:55 -0700 (PDT)
Message-ID: <baa70d58-d599-4b81-9333-7982b82f1167@linaro.org>
Date: Mon, 31 Mar 2025 14:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] accel/tcg: Option to permit incoherent
 translation block cache vs stores
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250331155423.619451-1-npiggin@gmail.com>
 <20250331155423.619451-2-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250331155423.619451-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 3/31/25 10:54, Nicholas Piggin wrote:
> Add an option TARGET_HAS_LAZY_ICACHE that does not invalidate TBs upon
> store, but instead tracks that the icache has become incoherent, and
> provides a tb_flush_incoherent() function that the target may call to
> bring the TB back to coherency.

We're not going to add another target specific ifdef, as we're working on removing all of 
them.  If we were to add a feature like this, it would need to be done another way -- 
probably via TCGCPUOps.

How much benefit did you measure for ppc for this?

> XXX: docs/devel/tcg.rst says that this is not permitted because TB must
> be coherent with memory to handle exceptions correctly... I'm not sure
> where this is, maybe it can be worked around and is not a showstopper?

I presume that note was for x86.


r~

