Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A54C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmw7C-0002bW-5j; Tue, 25 Feb 2025 09:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmw79-0002bJ-Cp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:40:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmw76-000153-Fp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:40:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso34187045e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740494446; x=1741099246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ND3Zaho/gCO021FTzM5e0cHCQSeRgbzWsTCy4MLBOfM=;
 b=ZSdXLYC2OkE8Aek2s2/W5NM3Amlu84Jh0piW/Q9lmnrj3NGtgKMma10QBdTXslXC7f
 j6Ul6oy+Fognv0Yx6vJJoQUm487CLXdA4itrT6T2jTvIYUoCDEFu96mME/a8cmwwL/Ue
 ne7VA4vwigNm5SSeUGNrOcNdTRtIDSIf61XN4ZnzV/NnlKhjnfE0BYmHxjQ3Wn5Lv0HD
 3wDkl5G6SJ0ycqeMbTMKe+nYwDsnVsHd7meTA+ctufZsfCFGy1SG+PcfuMLo9md3Gioq
 pbCiO69zaedxvrwhhQCNfwZcV/lmwMB5SQtcnjHVLPKegoJ1mQJDo4njjzkk3mA68iMl
 7qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740494446; x=1741099246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ND3Zaho/gCO021FTzM5e0cHCQSeRgbzWsTCy4MLBOfM=;
 b=PVU0GJN54M5XfnxDZRq9Qdo6uJFNTLL0l+EdC0c5Y97apk99oSdlfv/vOXBAapAxpX
 X9R8/JMeFv6JiUF7YOh2Bi278zpghzGj5FtYel2UTAS4VacJmRiIZkUhWe+LnCTZ9lAG
 vLRM7vMJ8gDc3+n1vDYjyFkg7qoKsnHcQfgo0jxP5dNG7qJI3FOW1S4BmrBuhdsUwpH0
 6jjXaVgJT73jRjvlaGkKNNx+EI2UqQxq9Weci1aBX5HHRdMryPGQYfgQdlwaifByKm3O
 mL+wr6OU/paedYQYz9dIfxagGxqTyBbRjfakcGsOdgjOUDlUvzZE8YaueXyXV/j6O42A
 xH4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT1koBrg7mpNRy1TtdSQ3iG2mbmqSWeuki/dSzgsmwXjqBC8naB3PCRKBu0QavBrPVO8b050A8I87a@nongnu.org
X-Gm-Message-State: AOJu0Ywou8EmQtau78K/DYqlmj9fnUz3KcUttzCqx/rR0ShwOnWHKqBj
 4AiwtESxpxkr6/QS//Wa8GivuYKqOAZNtVOkLzVSdbk57/9BHiZMX2s3+bsKQef1FFkMsJ9a+ac
 VC2U=
X-Gm-Gg: ASbGncvB+dXtQSj87GyhA0MttusUTW7trs4TT1D3rlFViBhMbCAlyKDW3pXnCh5DjKT
 SiqT4nMKEJzmZr+feckNA56l/JttEJ8dQz82j5Ayfe96t1CrDRGB1C8GgpDFYcMgXQP+Up0DOeE
 ioInK2Nlt+doK9m2JoPvAh1xI1LCjCNyR4rqSJSUtFnOlDhc+90Mq+caPOa0uHq5+7xbYiHvekj
 Q5GPwQ/tLfuYCnMGSGWmFzhuPH8PEbOnijjj7DvO0pIpb0OavVjcpz522w0RM/7E5Ejv6qEWoq6
 Wy849ACiiSG9oo1p5xo9N2kfFDWqGDDn021FT61bJgdclZd6oPYYE9aZgwW61bJlEv5+xw==
X-Google-Smtp-Source: AGHT+IHHPTDS61KmpcMnoTCXnXcdksYBB0O118t7CV4ppS5kbY8Eql6y/uPy7kPINIJgk92Cm2a8VQ==
X-Received: by 2002:a05:600c:3b1f:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-439ae2eb6c6mr135115485e9.8.1740494445999; 
 Tue, 25 Feb 2025 06:40:45 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0372124sm141184235e9.39.2025.02.25.06.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 06:40:45 -0800 (PST)
Message-ID: <127cd235-927c-441d-af75-1d6e4afe6edd@linaro.org>
Date: Tue, 25 Feb 2025 15:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/loongarch: Fix PGD CSR for LoongArch32
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <20250225-la32-fixes1-v2-3-8ec68ada3dd5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225-la32-fixes1-v2-3-8ec68ada3dd5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/2/25 01:40, Jiaxun Yang wrote:
> As per manual, the source of PGD CSR is relevant to highest bit of
> BADV. In LoongArch32, all CSRs are 32 bits only, thus we should check
> bit 31 of BADV to determine PGDH/PGDL for LoongArch32.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/csr_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


