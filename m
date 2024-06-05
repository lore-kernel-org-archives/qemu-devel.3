Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7659CC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvdA-0006g6-Hm; Wed, 05 Jun 2024 14:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEvd8-0006fM-Em
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:45:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEvd6-000887-JX
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:45:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7025f4f4572so958564b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717613098; x=1718217898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tcOmwl25xgyO5ShuOA8ptWqUFBki399cE8e0KvsO5no=;
 b=ey87M4B2XjOh3sjwweg8lje+bRuu1lL0pAL6hWCN5gmhNre0z3PszW3y4spGGxrhRl
 WykW1rlzLRn8mBokvOd8nvtbI9UPURQ6fsAPYW9oKicbQrZWFwnpX7o9cJEAO7SQoK1d
 kUSqjcz6X6s4FSmzE/o42qkJ1Omo47Uz6dDrwLya+GGd4+UdHwiFjfsJtWH2IlTKM15m
 dWIuNdG6dzjg/q7lvMPHgXLYy93FjkodBjKgez77RbUAnkW13UlBNAyPeVkTEPpB7Atn
 cyXC7eqsfnT4ISseFu4YcBluDRMy2XZeemyule0beGoKG4RNwcZ4eCstb3Dm2AA6K1CI
 D9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613098; x=1718217898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tcOmwl25xgyO5ShuOA8ptWqUFBki399cE8e0KvsO5no=;
 b=NesrmLb0yhE5EL8JXsFHLmPtJcTLHPr76Dl9TTeCIt89gJ8Wsq5nJDN0K4nLZZFDZE
 A59uHCSu67Cyfd4gNKJtBfUOGvTeip+Bfs4bOu7fx1P/JiXgBQgQsB/RGpt5Bt/S2V2x
 c5pf3boTLYaDwicmi2Hy75FlNfXeI5PJDygY2f9EL4NuVGhhx8C/52tajvldlmP2i2S0
 lJF9l1PppTITd3zhinCo8/4OTRdaOPrJz0LIob1l6kn03UtQparKY9Hhza7rkm6n750/
 OiK7uC18gxgo3ylgpogdUrAmjH2L194+EnSTOQmrJha7m+sQ9Vgawmabs4F5f7Z89S7g
 OSpA==
X-Gm-Message-State: AOJu0Ywc2jAsK8thMBVCnQ4zWdFLqWG8hbWXk1Ixn2jub8vlniio0BVl
 k+1yjwhQrCOi3A1+yg1C0sL24IQ1VtnktLiLJ/v5hv8xjgmwYu1KYpr6ie8K9ho=
X-Google-Smtp-Source: AGHT+IG1SGlehWROs+0p5VhXrYUZ5cMXpIBwf3MobDosRt5cCl84WWhI+PagNnwVtJodJJa+3nzyMw==
X-Received: by 2002:a05:6a20:d412:b0:1a7:9b0e:ded3 with SMTP id
 adf61e73a8af0-1b2c55e5954mr493295637.11.1717613097728; 
 Wed, 05 Jun 2024 11:44:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35a88c70asm8660295a12.91.2024.06.05.11.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 11:44:57 -0700 (PDT)
Message-ID: <e914d69d-9088-4c4d-bb26-cb64d5cbdce2@linaro.org>
Date: Wed, 5 Jun 2024 11:44:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Convert 'info tlb' to use generic iterator
To: Don Porter <porter@cs.unc.edu>, "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-3-porter@cs.unc.edu> <ZlncNh_GHoEfXMPB@gallifrey>
 <1f862dbf-0f25-493c-a94c-0ef42531f8ec@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1f862dbf-0f25-493c-a94c-0ef42531f8ec@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/24 13:35, Don Porter wrote:
> 
> On 5/31/24 10:18, Dr. David Alan Gilbert wrote:
>> * Don Porter (porter@cs.unc.edu) wrote:
>>> Signed-off-by: Don Porter<porter@cs.unc.edu>
>> If this changes the output of 'info tlb' could you add a before/after
>> to the commit message please.
> 
> Thanks for the advice.  It should not change the output of info tlb.
> 
>> Also, have a look at glib's g_printf and friends, you might find they're
>> easier;
>> https://www.manpagez.com/html/glib/glib-2.52.3/glib-String-Utility-Functions.php#g-printf
> 
> Thanks for this tip too!  It isn't clear to me that converting will substantially simplify
> the patch at this point, but I'm open to it if I'm missing something or this is the preferred
> project style.

sprintf is deprecated in the current MacOS version, so using it produces warnings.  Once 
we convert our existing usage, we will want to poison new uses entirely.


r~


