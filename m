Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44535D5B85E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCpK-0003yI-Ft; Mon, 15 Dec 2025 12:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVCpD-0003wh-Mn
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:57:36 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVCpC-00085U-6z
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:57:35 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7f0db5700b2so3319132b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765821451; x=1766426251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qW4AF0ByCAqJuDeoFXWb4Pw8hfXOu8UQaZdMMLtYDVc=;
 b=n/K4BisslSTbwNXwOBzLqe9+ENe8Jo4F6Smj7Cu6469mKLWhq/8iJXYlO7gPACnYd3
 Q+uBTDQrFB00iKFnMczNiU/+OrgEnJyztxEpfdK8Cw+GqeZFTbZl4U4Fp9iJxjwCgfm1
 C3oj9Op2pqV/irzhF7jr8f+329f8ZdAq/LryY/yZk/1LXWHjcDNI1VFz3p1mYnafyn0i
 mfVs3tAITNQ6e85aGdITFCgP7Q1vcupn1jLZASsXKQ06EbajXdClSVy0RSpkeAAXSqbg
 cxKCSctGcO4bwUDPNNQDzuLemNw6nSBk5R55wDM6yOCEezPDqahvsFKGRff8Hp+BU9GI
 yX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765821451; x=1766426251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qW4AF0ByCAqJuDeoFXWb4Pw8hfXOu8UQaZdMMLtYDVc=;
 b=Y0HbHAjwvwe46w9kSBgf1ucKSC7w8LzhxypxNy7kLZ2czEp3DS6Ls1UZm/3S2wIqGL
 ndKQKKkBWp1hF3z0tQ6QPtwi04MrjhwpnI1bdW2/EGVH8cXZYOPYNyQKb494kOWc0TKh
 v2ClRo4E3ePFH1PJSoi1JTXB2srNxPI+LttjWugAgGraid2DIrTh/vJbFwCMIFK4D6TS
 duRnQjt53ie2sHhJtXYZDob9qpg+GJP1u36PjAvxhvYKPBksyJSVtdG3YhcsmkV7d+jZ
 wO41YbFVn7ktXqEly8CffyWJEFb37ay7BTzskW/Ivd4lwwfK7k4Q0AhO/8GfIzwNTk8p
 ooRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbAOBPExBaulCSuMhUOlosdtloRDWW9KV6cjmMnMvl24bsFU8QYJEW8BlJeNP8ALGgrmj6bIOkuCeS@nongnu.org
X-Gm-Message-State: AOJu0YzSIwy9m+lfkx7Wkxos+i5f+3HCVj1Z12sWCUpqMyz4iXQZuDAI
 68M7c/f5SYZKMTBnUgj87LPVvi8DqXr5RRRCH5/u/2PUtWTIRzqDIo8KoxzFGsd13M8=
X-Gm-Gg: AY/fxX4t8Tsis36cnciaA1f6KO1xQWzD3H0jl3pHu5QvQ1Hykr0qdKp0+wb4n8qg0VY
 wYLxF+hPXUsAX0B1hfhtuhn8MOdnyAsa+jniU7hgfBgmZ+DWF42Tlxx7sr0iQzbWRiOB8rzfXbR
 2JbJnV5CMpyxnG2MB4SJ8mxi94gic25fXx7AdPHpoWGzoTpG4LOLqx4trLuxRQz9i56SppnDiqj
 KHcKNMVeaELPEThuelgsdsEe21RMCCKijxSVkfmLEvHoz7PfaGhkCn8Sk4LlAU/fAueoV6qMqtq
 CxOh38yjey0gqamThuSoc3kiQgxuLhL84JHMglWK/tAp2PPsJ7G5d9Elvivl32QBDJnPRADL3mO
 I/UK53UNwxErs288sHay2CM4rMhlq02j4+whvfVp9CpXxApGR8n3HIi5LneTJOGYYMfd97WVh9n
 cSzFmtQckTWmF5knvZ0YURSZxfYBWdE7l6hrloPTU1mlG64v/gR5x/U1E=
X-Google-Smtp-Source: AGHT+IFyEfnz9BJDzk504HwrLYYA46MWnO7rYU8W2oq3qOSFGYF3VW3xEnEXxFZFdRNHQi1v9T/MuA==
X-Received: by 2002:a05:6a00:4107:b0:7e8:4398:b370 with SMTP id
 d2e1a72fcca58-7f669c8a7bbmr9280906b3a.67.1765821451407; 
 Mon, 15 Dec 2025 09:57:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c2379e40sm13242607b3a.5.2025.12.15.09.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 09:57:31 -0800 (PST)
Message-ID: <7e11df05-4592-4fbb-920d-7fdc9db665d3@linaro.org>
Date: Mon, 15 Dec 2025 09:57:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tcg tests: add a test to verify the syscall filter
 plugin API
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20251214144620.179282-1-functioner@sjtu.edu.cn>
 <20251214144620.179282-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251214144620.179282-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/14/25 6:46 AM, Ziyang Zhang wrote:
> Register a syscall filter callback in tests/tcg/plugins/sycall.c,
> returns a specific value for a magic system call number, and check
> it in tests/tcg/multiarch/test-plugin-syscall-filter.c.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>   tests/tcg/multiarch/Makefile.target           |  4 ++-
>   .../multiarch/test-plugin-syscall-filter.c    | 35 +++++++++++++++++++
>   tests/tcg/plugins/syscall.c                   | 19 ++++++++++
>   3 files changed, 57 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


