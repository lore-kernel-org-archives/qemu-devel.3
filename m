Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F8BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TsC-0006sy-Bq; Wed, 24 Sep 2025 14:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ts6-0006qi-Fn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:05:43 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Trs-0000Ek-VE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:05:39 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so133936a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758737120; x=1759341920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RR6c7z/907+Ux+dKjvLVHtysJ2mXizG1JgKCx3kPjvE=;
 b=UuF3l3qTzRmpXJ3ZVGjpSti+pkTJU5d+od9aahXdvDYi9/vIrJAORjVzuu1mX0B8TY
 1ew1mlHW1M09iFaPrkuh1i0KAj2IDheErGqbkn1v1+BY7gZBCPH9pYyhZjhiohBu0dWD
 5o5cG7IcUy2rfyJgvMotJoQENcr1ivhmZICjpPcvfQtf7w5r5gvnbYOXCnjEbAwPyUGx
 iOJMV4FfjiqmLvAtMzc6Yu/HrK+nnwyh5lBiA/JaC9rhvO4/+LEaF/YWPi19qWo2O1HL
 YLKvO4zyxX3b40iFZCDDdGTrjaYoUN5/F09CbqmAkMZ51GTZ2b50u1CkKauucxP+srRR
 B9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737120; x=1759341920;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RR6c7z/907+Ux+dKjvLVHtysJ2mXizG1JgKCx3kPjvE=;
 b=OJW/SP39zRz6j3RnS4fZShDho/oOQQzPQqzmQu5onhNQeKXTWePVf4BdgcXAlgqiO7
 BGEgbeRSWkP7sD8gjcwWQZffrw8aUxVJ/e4Zv+BEVjJiNJGO3QBS/XuwwRXePdwvWqxy
 EEV1tbbh3hdNWGvsXEtntAVb1pWeRPX+BJ59w7Ril4VAC1p6Chws5nfnvRgNyN4mtEnH
 YF8BQ9TFqScvS+yGquFooyIJK4GvyV8WH4lTbGf1R1mSFBtzI04BCnkxbb7HCfM5yAIH
 enLTL4D/iLARthr3oGl5UTAMQMKgt/+M0MkVl0qbw/N1zxuUB/O8jFe7roPE0+CYnIEq
 gPZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4j/67KR/weidq3yOGQ1xMe26E55jv8mbvOkJjY2RQgmd63n0IUwnzCNyVVa6l5V1LjS/eDwEiPlUG@nongnu.org
X-Gm-Message-State: AOJu0YwbZBefuFPEvzWoXaLtWu2lhx7cRie42emndez7WojWG4otos0m
 1eAVOgfccqwLPHqgHlBIFhkVpmwZEiaA7SJB6zCYlkJPu0Ja4x4W2lfVLi2o9Sr70Mg=
X-Gm-Gg: ASbGncvbJOnvvFIg0TcfpuYfqKgwxAZeXDqyAKUdqvuimKAu8kC0tTyzkq6j/t8sDAd
 8zTaYufON6wM9P5iVXGhhob6ZQH60sSiSCNQubXSVq/6nA3EQSROQ2tLUxIOQfuS0Keh33dbQ/6
 0OEDDGpmKbLkcyqjkMi0Ph0+vAW6Tj/gIGFwyZk+c1yBQjCeFzsCsRlCfF52YK2p72PPN/eyCHp
 UWwLUn4ilvxnt7/FJ/R+DKIWZoaUxvsx610molZKpUKyfnuP906oWq6RaiWkPj3YMrMnCLBVRp7
 KNMD6qKOp/5nwZSqLvreoqvL3fNc2JQyXB4XGVXcAJNrcD8ttxIAaIYLGEiWAuRBcYwe6zNrY2S
 5/YPWyG4OasUi/R0XtBO8zlAYG3+ge8b6uHK/
X-Google-Smtp-Source: AGHT+IHhuYallVNF0EV1yHyDwLuuYFWsxB6/ZsL08oXL/Z0Q2IOMa8S/4TXLJhlpwo2+6krkyoBMWw==
X-Received: by 2002:a17:90b:33c7:b0:327:ba77:a47 with SMTP id
 98e67ed59e1d1-3342a28b8a3mr644242a91.15.1758737119653; 
 Wed, 24 Sep 2025 11:05:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b55156734a4sm15673071a12.4.2025.09.24.11.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 11:05:19 -0700 (PDT)
Message-ID: <e1429df0-72ff-4897-9f48-e7bed057aa92@linaro.org>
Date: Wed, 24 Sep 2025 11:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Re-use gen_pause() in gen_wait()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924173028.53658-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 9/24/25 10:30, Philippe Mathieu-Daudé wrote:
> Avoid open-coding gen_pause() in gen_wait().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/translate.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


