Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CECA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumY2-0001AI-6a; Sat, 06 Sep 2025 02:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumXz-00014p-BS
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumXw-00054R-O6
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3e537dc30c7so724804f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140629; x=1757745429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8XdyY0WgYY1AXu6fJ6djSJBrBECJ7Yf6Jz8VR6FC5U=;
 b=i1Gjw6iQzrRZoJFOF7UcK/PM/3vXzSPMXvreoTVbar6uE3q2BVSL9z7zpMvZm8n1+Q
 IAxD5l4UjPMbRkJlac+9oekEz/GQrYH6NSQbuDJVl1hXnuW1u4WHBKzE7J14CdMu0kbG
 ZzSfs8sCREsh8TMywrWlIsOPuF1gF/7Wey/iY+KpBXuC/AUvtBskJpEpuZlX8/hTzFzk
 5gk3lcBjxovpItowjPfRVdUaifdjpnY8EOlGtcH3QK/Hy0LkwabE6CgtfjkF1k0b6T4U
 +gO+atdFHkhgy1+efG9q1epHBqPhjHn6Jj5084dI3pWGJpqolv+DRiz9xUtU7u3ILD+U
 7OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140629; x=1757745429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8XdyY0WgYY1AXu6fJ6djSJBrBECJ7Yf6Jz8VR6FC5U=;
 b=NrqNKeqHBgyxpv725TAufmVqmLpN6rk97cecSTKoKC043riY32BMvgvh3on5wCieUJ
 VeGgN6+GHmH81/XiZ5oexrbMr1nMQNplvq30CGb4nxrnOPRqnF9lHedV6NYTzVgeadbL
 IdJTAsXF+jw/7SBobdp0EhZRug8hEal8uNfeYk3GFQNt915MNyRgqQIqGgu3pEJGGEbw
 ibtpum7xfJgQ3kW3JTPZatCB2tLe0dlsDTzdphjiq+836VjNKXCWlwA6VkobywjHqpiI
 5C7Kqo8zBTC1wjUbVICfuBdzSKzLl4ZBsI8r4BAz8cYm+3eSc5w9WDjzXztOD6tJhXUA
 /0AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTf4vw5Mpah7a1SClx65V0gkB1va6F7jTXPk1krJKXlbzHOzGFtfXxGy+1nWHz2GV59NEnbgkPIAFM@nongnu.org
X-Gm-Message-State: AOJu0YyCgdfTMTJKrEPLxwx1EqJk7YY7UzR3AVVkjtfbB41pEVimHvCb
 /lO3Z3koAe+I8K6oDoOPTwOTMBNePLHs1YhXOJG+E61xDSakz9IJT0zN0qRrgrRtSIk=
X-Gm-Gg: ASbGncsJVxxjmIIKwDZd5FruKPJVYDceY5bCMaFh0Nm9ohQDfEbisctP9oDY+/7BoSO
 Qk7mheOKt+79WrQlm554q/Ju6afWnAHhwW0A+v1fOufQmclUqtQmrrlQkyxC+uRlJe9n6FYGkvq
 NcZS1hIKNuLpOxg1DWOHvdrLxvRWW+/4VkDVw0ZnlVWhGVMQZqHF57lkyTv15YygCra36TP1vse
 KG6q/f7nrteGOHi7pLNZtEOuHywEjYfszpzjEs6v1YtRrKBvdUdB7YeUEiJ0Y7cAtHKrwgE//eB
 Jxd4HrACqva60QTwF14yAG6+ZSnlwyEVWNDpcyPN+unTgDQT/TmdDMHU9D3eooYxnyWz/zDfTo8
 5VWxCyYfDu6405m7IIGDYX9YfUsDHqimcSzy4vLQ=
X-Google-Smtp-Source: AGHT+IHiBQ1XHm16noOEJIdEA36XFpH8JWAD8uoOOq9dUfHqRtG6xU83nTV4xdJSOffL8zBDapZvDQ==
X-Received: by 2002:a05:6000:2584:b0:3dc:21a1:8c6a with SMTP id
 ffacd0b85a97d-3e63736b322mr802323f8f.11.1757140629313; 
 Fri, 05 Sep 2025 23:37:09 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm61111985e9.17.2025.09.05.23.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:08 -0700 (PDT)
Message-ID: <dc027db3-2776-4dae-834b-d8f93ed2e8e0@linaro.org>
Date: Sat, 6 Sep 2025 08:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] gdbstub: Remove tb_flush uses
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 2025-09-06 07:18, Richard Henderson wrote:
> This hasn't been needed since d828b92b8a6
> ("accel/tcg: Introduce CF_BP_PAGE").
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/system.c | 4 ----
>   gdbstub/user.c   | 3 ---
>   2 files changed, 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


