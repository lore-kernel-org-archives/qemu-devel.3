Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F151CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ovs-0001pJ-Fr; Thu, 02 Oct 2025 15:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ovq-0001oP-NU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:25:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Ove-0006G2-LH
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:25:37 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so1573097a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759433121; x=1760037921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TOcCSorcywNyDXGmorJiCORuKFQaML6OL9F1NluDqMU=;
 b=uKmoBXHxAuOoea2XUgRnscpdeeWE/n18WWzL9oxEeLthPfD6v2h1q6jQeIiLRegzm2
 /gwWP5jFpCarDNG19ZxydtAOgeT2yRyR6ibqO0hal/k48XZVxrFMTLo0Ar3Ig7fNAxxz
 I20YmX1L/8kbTVWOmoGoTgSHC/F2AcdQavVPN+1AtGJ21razKGBP7iP6TBgdNel/4EKw
 VgzraXpmfqWzf4+r730XONHg4m9Brrk+vHTjnA8Ok82gdSiw3p2olbI7UeuXOXA9ieXa
 CDBGfMQ9C+tg0QJzKFvo8RQj62ay8Ja1JUdRZ3Ig5rZdblupH6ult747owTGdKQ9/SuJ
 flfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433121; x=1760037921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TOcCSorcywNyDXGmorJiCORuKFQaML6OL9F1NluDqMU=;
 b=Uug2f9JXFLRg1CRegxiFsR8AyR5j5ub5zdahLJlmbTYNGCKJ+VXcvWewvENZ187sEw
 6SMoY6d4xqu9fmHFkrK+Fu1LkBEAldgxbtO/1MJ1eCerBvi3kGIDMu+oGPN8YeY8ODGr
 jWymvqvM887HJB5ncSMPAgTuA+LFsZuMTYG16RX3rfF4eBbVjLP/WQlE/JLN1iAiHNx3
 ju44WytQJJPfcRWZMhxJ/hGUanZH40ElK0uEFR282WC72AapoOERSMRS0P2MWiOpmrYS
 Z4eXELoEif08mE0ZAqOKPTyfN8fZekCdXAVXfUdE0GDZ7SnlyiUDM8zMyr8YMnQwPw98
 cJNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpMGmCesCRNCeAICsy2NzKqIH0XJOZm1GZuNADgJ7xt3YIZ7cuouEEwckBSYNOva4DmHul+iEaoyyX@nongnu.org
X-Gm-Message-State: AOJu0YxjWaaHOx5dbkRue/HBoBVhoGINYHNGJXVdrmp6w2k/cGKidgFL
 UBJsVvmKIGDBCTwYXtn3ddE0b5Yc9q4raJHwppJovWf/0amz/QXGeUFHXOe3JyZJjTY=
X-Gm-Gg: ASbGnctKAKaiq7siGukc7qiFdqy/urrxemmnu4bmC3wZT+Y2VmrlEXSco8CQ/NehWjr
 H2M8ZUDSt/Sbz+2ylpuKY6ZtmDhqRp/apg2GFGgsOgFzDVtq0FK3aGzMByP3Vo/9MHovhSISoIP
 wXx6NTqkpF7refgeWXTYdxjoEOWaoxhHclScwoQOWCg+/RkZ+8C1Mtol7eCm7GC6hRTnSe6IHUi
 EKbWDQBufL4Cq99rlI4icdAaGCFs5RQ/jh665b/5daE1CFs+uUVgrta+VzQRjz1ITvwOU/ZMCio
 LuylLtP4KzYLOq+vHTTHGKcKehyKuNeEdHVMGBqWa+NcJ3gG1dmRlc3JDJNbzHISLdxi8Cv0W87
 /Izld+iwFMEWdCSdJRqd4kUa7fWAoBEMI4sTSh/fUfAvrTdFmi+2EvQgXl4kCdXs=
X-Google-Smtp-Source: AGHT+IE3wmEZdLNP8FTAe3Qc3pDlRkBNx7yV3VI9lfPcQ/ELOXfIBqUoF/n9qxvn2LaEiQSkqu03eQ==
X-Received: by 2002:a17:90b:4d0e:b0:32e:18fb:f05f with SMTP id
 98e67ed59e1d1-339c27973ffmr519797a91.20.1759433121454; 
 Thu, 02 Oct 2025 12:25:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339b4e1976fsm3106684a91.0.2025.10.02.12.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:25:21 -0700 (PDT)
Message-ID: <60922c63-363c-4c0e-ac8b-c65145ef4095@linaro.org>
Date: Thu, 2 Oct 2025 12:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/33] target/riscv: Combine mhpmcounter and
 mhpmcounterh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-9-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> According to version 20250508 of the privileged specification,
> mhpmconter is a 64-bit register and mhpmcounterh refers to the top
> 32 bits of this register when XLEN == 32.  No real advantage is
> gained by keeping them separate, and combining allows for slight
> simplification.
> 
> Note, the cpu/pmu VMSTATE version is bumped breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     |   8 +--
>   target/riscv/csr.c     |  74 +++++++++++++--------------
>   target/riscv/machine.c |  10 ++--
>   target/riscv/pmu.c     | 111 +++++++++++------------------------------
>   4 files changed, 70 insertions(+), 133 deletions(-)
With assert being fixed,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


