Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194D1C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAb1-0006FG-1n; Sat, 21 Jun 2025 22:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAaz-0006F6-Ix
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:38:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAay-00060s-0q
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:38:13 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso3683392a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559890; x=1751164690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kqy37Ck226xeMR96muH7nbiknorEdBg2NCi6Mgisofg=;
 b=iF8PYgHjscpVo3d3Zj0BfG1gpcX6fWPS7PPGMlFnr6JsskGlVrEy96mNX8u1wB/mC+
 KPFssO2KLFRzHHlxz5+bnPJpBXIoDDXUZDHZDeWcGSeuyfoMpy05PRHZ5QL0mtc2p3KE
 AEYh/0AutENBKypPxBPKRWrMtUGYEgAs09tHrHOcjFqeYPqBPlEZIWczo/YD9d47Elq5
 NrhuOLTcwGJ2Bqr3tk4tCzcfq9FiIO8fcxKbQu5U4lsN6NmUPvo+F/zZ9dir70yEvOWl
 V+hzP4rDzOAqe0zoUbIxe89SWgDh7GlgCXpr366vKAkM7IIVgJXvsDrRi4yNG77DyNnP
 6w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559890; x=1751164690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kqy37Ck226xeMR96muH7nbiknorEdBg2NCi6Mgisofg=;
 b=anm5KTL2lBwvVQGwhl36UzEUTtH6NfYI+FC+2y7dWKHaeiPr3dPuwKeZGXS6S78O1R
 6/wzBnkihEldIUQGN1oHWo+4ooMYNpluq4cgW3pQnyLqdrTcStwARM0XfjZzRtptmBWq
 MTdXkJbB34LdiCN9wnXXp00QkFt51TTgQ4tMfKu0O5AAol3okTcIMKrgtpYHkavfefHK
 ExD0HixHqEC66nokgRvb/ZYCTwi4hG7cmW+bx6QNq69VZTyLPpkQ+SZD4RmV5QH8qBJj
 u9+G/5YwF1KkGGNduF//WA8vTIBK7delzDe3zG9hAqPeCb/k/KA9C8L+tVqu0C8qeZGk
 5e8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHP9s+yp87VWMYVoQehr8MxQJIwO5Kl6Zc43EEmXpws7HGxUuLdD0ghC3RusVwUI4Zlh9clZhXtD02@nongnu.org
X-Gm-Message-State: AOJu0YwYDNq3rU29sZ5dVsPLjNWdPd691hc8gYaRilkdAm2pMsRNgB5b
 3iuKrZAHA93Qm9QoEAAqA76193K2jG6Kx4FLmALaRkCv6C0CXjUL0MbJcrR5+Lt2vvFNz0ozTW5
 YFhsyMok=
X-Gm-Gg: ASbGncul8oeJBYIPyZjQmIcU03hV29ZMKkXBAvY9PFb7Q82hTDjSLADyIIH9RlzsdKN
 xXUhilYvg7xo5jWhEqsbZFt5v4MGkYpI/HLtpF8UiKmyBHxJps0yvW0Ad1anvZgKtSDi5zCBplA
 RnYp0+zGf4n9iPCHehXaTS3hZ1jZXVzH7Zia0Tvrkoy/Yc7dVxoB2P+JWFizdMQ3bXzYDJGuFXQ
 ElzXDVWpYpDqPXXaIEtBeAi0rwEKvlbgZ1EDe/X/1ucxNT/lty/nVUKxzud5xtL/9Z9TVv1aLYY
 BbwwGWc2LmJjjYmWWCsBupsGllfnK6/XvMou+qWuwxizj4oESucJcCcfEEnMV9RIj/RWHd8Hq0Q
 KJlSICbO2k34J1nxUQu6mKuvydIVs
X-Google-Smtp-Source: AGHT+IE1US1pGJIi+XFeUDA8NCLiobcX51qZsNLyU6bhv6i29KeenKCahnFD1NfKu6wDujlSyKu2nw==
X-Received: by 2002:a05:6a21:7014:b0:1f5:8eec:e517 with SMTP id
 adf61e73a8af0-22026d6456bmr10154964637.9.1750559890647; 
 Sat, 21 Jun 2025 19:38:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12583b9sm4739963a12.53.2025.06.21.19.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:38:10 -0700 (PDT)
Message-ID: <363f2fa8-aee3-4cba-ab19-b6634bd5564e@linaro.org>
Date: Sat, 21 Jun 2025 19:38:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 11/42] accel/split: Register MTTCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> FIXME: Use sw-hooks?

I'm OK with hard-coding tcg for sw, especially for now.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


