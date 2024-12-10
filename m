Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08BE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8Wd-0007uw-VR; Tue, 10 Dec 2024 17:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8Wc-0007ul-NY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:16:14 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8Wb-00035w-8Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:16:14 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb3c143727so46104b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 14:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733868972; x=1734473772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKmWHiJG6C87eF9fM3OB7SD4ZdvHbUKlcHgR7wLVDgw=;
 b=FXWQj9jgNQavgSwIMrJV8CiWgcT+GVv1S8sr5p2i6eodJiMC1pqHfe70Gpks+Bmauq
 3ynuS1y0gG3veeEmYijA5WsQrymrvZ4M4J5HwnmUiBp58nO2GP9jKjP1dYOMhagFgKPj
 g1TfnZCJZQ2fvJIOawvUKRbW6Qct6iDDp+IjaYuLe4uOaktYgpATIUvxBStceFK0v7fA
 7Fjmy8ONpyC1GTDB8HxaRoimRdmGby5j27DWWm1LEi4b9tr4OFrJxZJVYYboRmjs3o+k
 OF86yEAuNXAvmUZY6j19roZ+6ydAv3h4ljGVf0IhLzyc+g0qIPMkSmZCIrJwJIWx/7wF
 fcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733868972; x=1734473772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKmWHiJG6C87eF9fM3OB7SD4ZdvHbUKlcHgR7wLVDgw=;
 b=kQ5E0HRs3RIFLPduhHKzaVdGR3jRLJEaVthD4SKamL9ITuYv7U9VAOuLUjFwz3hQF1
 0XE875daP4vL2YI1Su5fQkFOduoJLiX+lLLOb7955aYo0k2ft37aqNqaK1E3owAQnxoW
 3k0siBNhdpz8Z/asaTnFSL+fEdYxMSq1Sv5jly6DIX8hLYXUwsJy7HiNH/w2uprqkaFD
 uxntp5JUQxYRMmedrNnie5JQQfHE7Zds1Gsg9Ktr3ioATc+pkHuWqZttOxdb85ulQAMc
 8gdKEy9fAdWHCrWPLzUtCxXVZqF4HneKtIDxuy6jEsdftXHHAx6CYGOtQCXMRjY3iT/M
 XTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtAmkVWwPBLzvJ5OoFzZZTmkCGyK7CaImgp20DC6gr3Iq99Cv8SJK4TfY1Ao1KfbMs6P78R61Stp2f@nongnu.org
X-Gm-Message-State: AOJu0Yzen7nOOwi8+sl1Bd7zNz8768pb2GyJLsXjww+NL9Tb9Fd6F0Co
 b4OiAzsANtMnS7ZHz5XmNbGFsE3RAC6gy9ftxc/FLYtWyk4JjnFX7TP+WS8o554=
X-Gm-Gg: ASbGncvaK5A2Xpn5lMl+f56jlS5TXu9gZwBLcohFOAF5P1XGBvpH6D3lIKA+quhpVSM
 ASpVK5vadmF1LC6wfPFF5Rz4U44X0Ld+ntKxPYcWadQf/jjalTXoQ+uRz37Vc8iw6rbeuEt/6Gy
 7Oj9gCBxme5U1jvvZMF2ebe4RNqXNpbUEWv8TNd2cjVLYaYLcrilo0R+kb/pm/4SAPWTvXK2mAx
 fyEm3ZBR3zig1akdPRO4zvxQGM8iGJj/Hp4IxV3l4gKviHZPaimrK9AVRLGYJtXY1YjwLN449Y4
 OfD5UB0UTKTSRn92LCFqxfgWYfzk2+Rc
X-Google-Smtp-Source: AGHT+IHjHeZvGP4uptSc4iIrFb8/Qdf6kRfnQ3No2LejRXBJNqBhexcGXR1N2aH+12Z8V8cXi8eB9Q==
X-Received: by 2002:a05:6808:318e:b0:3eb:643b:defc with SMTP id
 5614622812f47-3eb86af7836mr252643b6e.7.1733868971828; 
 Tue, 10 Dec 2024 14:16:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2995940a34.52.2024.12.10.14.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 14:16:11 -0800 (PST)
Message-ID: <a22eb1f7-4cf3-4aa2-b240-73191687c07b@linaro.org>
Date: Tue, 10 Dec 2024 16:16:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] util/qemu-timer: fix indentation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-17-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210204349.723590-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/10/24 14:43, Alex Bennée wrote:
> Purely cosmetic.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   util/qemu-timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index ffe9a3c5c1..7b71655416 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -680,7 +680,7 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
>       aio_context = qemu_get_aio_context();
>   
>       deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
> -                                                      QEMU_TIMER_ATTR_ALL);
> +                                          QEMU_TIMER_ATTR_ALL);
>       /*
>        * A deadline of < 0 indicates this timer is not enabled, so we
>        * won't get far trying to run it forward.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

