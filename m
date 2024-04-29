Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C704C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QSX-0000zR-I8; Mon, 29 Apr 2024 08:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QSN-0000wu-IT
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:50:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QSF-0006NG-JU
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:50:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so4119113b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714394997; x=1714999797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pa5Mjg7RY8R4a+9SASv9UG7iIsh7/I5tnwEgJCu15Ic=;
 b=Xn5d0D5ah0allsokYIGORggyygTRXWgoqUZfXNEXLwSwvimd5akZlvD8pSKo9V+/iU
 cX5y+hZd+n4NwQP2P7KySUdEUCnJtB1Wo2LhywefGodet31lrFocF13sxoHaooEHPhLP
 hzAjrAneVCH1JnD9ZIZzjCbHT2E3o2KytQfL/kYQrrkhVH2WP48AEdFwitkBJ/C/DSPg
 l7RbNSHMoOm2OezaPlCcAt1z2eJX7vJ1fU1QpKxelsYPjUv7tyNfiG4zYBBZ5QjuRHTc
 Z418OyCE5molU3C6HwadsBaKb6n1S9fhyeuiikKyrgYueQXGkTCbOrOOcWk9MIczD+G7
 Vy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714394997; x=1714999797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pa5Mjg7RY8R4a+9SASv9UG7iIsh7/I5tnwEgJCu15Ic=;
 b=EqTWjhx3Hy/NkBD6tTVB9uo+zrccFqmlLl2Yw5pFMD4AG7Tv21hB24GcBVe5mECDmq
 AX17JcoPMpSmxv+iKNOx10uj4pZ1CRLQhWMVselokMpLzmS/26IGxTmgcmweasjoMSKs
 tawkthp5rjj0lm9NPNWl+6DK6F53jCqNK13SczdQ74USxlGym8anWAqhi4wBANDu3nzc
 drhYx9ltyEWrK13pEovlGSuG/FN23HxCB7v7CwKExQWC0cJ3Hnr1Fi/JPzZ89QKrNwV6
 4alH6fHjCY/20AtwIiYJcKfQLdV/evMBHI54aQz83uzRySMvLhbMvMs7ETKv6TOTcn+I
 YpHw==
X-Gm-Message-State: AOJu0Yym/giweOJbPa0g8bGC7LVes41+RCXtmzEi/n4yDPLdQ9SWmhd3
 AOV4b85mS9CLfXfJBMWWRpL75eIHp8FZQFD6aoMIty2hHXNbtouH6dhft/p6OW8=
X-Google-Smtp-Source: AGHT+IEcYbGhxGTrX/Ku2IJIc8C3amWxbw5lsei23ozY/e3chfLWmdv+986LkziXz2sw4mDpRYOvew==
X-Received: by 2002:a05:6a00:3d13:b0:6ec:ff28:df5 with SMTP id
 lo19-20020a056a003d1300b006ecff280df5mr8773281pfb.27.1714394997110; 
 Mon, 29 Apr 2024 05:49:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056a001b4700b006edcbbff2b0sm19213374pfv.199.2024.04.29.05.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:49:56 -0700 (PDT)
Message-ID: <3ff36bf9-1318-4408-8afc-2067351f058d@linaro.org>
Date: Mon, 29 Apr 2024 05:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Move VMX integer max/min instructions to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240429051317.289426-1-rathc@linux.ibm.com>
 <20240429051317.289426-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429051317.289426-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/28/24 22:13, Chinmay Rath wrote:
> Moving the following instructions to decodetree specification :
> 
> 	v{max, min}{u, s}{b, h, w, d}	: VX-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode            | 22 +++++++++++++++++
>   target/ppc/translate/vmx-impl.c.inc | 37 ++++++++++++++++-------------
>   target/ppc/translate/vmx-ops.c.inc  | 16 -------------
>   3 files changed, 43 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

