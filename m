Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EC1D59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6Hn-0007sk-M5; Fri, 12 Dec 2025 11:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6HX-0007jK-AD
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:46:15 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6HU-0006I7-FY
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:46:13 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7cae2330765so913140a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765557971; x=1766162771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WFjz0rUu0KtJBvRydhd/IEdhKUw7aZgWuOBQis1bNfs=;
 b=ZFixm9PbqAPUSlEkNXzYEApJ/t7zpWTUU64luYGGLJISXOaYJhkrBK9scYCejo9rmW
 mlR3fH5ECzjBQthfWZ6EPV1YVl+SnxJQucqAYVtuTyvhf25R8w6xTG3/dtlF7bYitEBO
 oaNxiLefwGkgit2n08DPjfiTZkXxmdEpMLbxqrzLukwZ96zfoqr7MeQnuN+6OYSjeQ1g
 beDG2/OUjtcf7IjbgtdDJ+lmlfW9Cxo3w7CH1UHKj3TYsiKipfo40ThPLta81g8HUTH3
 Ep9jjY9PtR6wEWEzN6Y4c+qpm4tRG01j4+rNgzlQyEttLWJcWm27eQ7otVzAzyeecle6
 u8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765557971; x=1766162771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFjz0rUu0KtJBvRydhd/IEdhKUw7aZgWuOBQis1bNfs=;
 b=Kz0N/UI0M6sjYKgZNjbyeQbctX47LKz1TKg3awRjRzX2fHRJIa3gc2EHVpMenWVxYX
 BASwxk/PSNb+SCVoisBXDlWHI7pEUys594/Q398P3hUVdXKzgwJNWckazaQ61kbBqHG2
 R419YkmxfDanu11XYzYzR1AFryAjhag8oKdlvTp+cVLd7Z0AeOVO7pv+ofmV0TSqqI+i
 9UccbffEqOd7N++BIH0Wd3lEKAx+OGarBO5LwpPXD9XJ5s5VHiuyUXWKW2PJwe2fUEsn
 GOeruL10M4JkQJeptFfacFLUDo8AXJANrQQ2q1MIb7a9BgRZylJ+3pKIeugcx9Zmazny
 zeuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOp2W/lCmo7WH/NphC7iKLM0V0wDyFNjr+mhf2fQgsjdmukz9mz/K0yJYMmHGHy1s2heuGAmjAEgSy@nongnu.org
X-Gm-Message-State: AOJu0YyhuTnIQ7VXU+utQhNgNhD9dLGSV3+2Lj9bZPfnJRMlx9h/QbJJ
 qZ2adaJmcZPOH8wKscBt+9FqfMGW4bDuxVdsLFYD0zz5OWGHK2XAlRPNOWb7ZuhDEeQ=
X-Gm-Gg: AY/fxX5wD03X/tjpyMHYZjsip49hZpoj4g4rRNUFRum2rQPYSGmK+O0ZzTSWjKnlTJF
 bs+tg/Ki4Vz9Wp3BwTL0KgqNx6B+aAhgYCDWVBmC0lWa4oajIyMG+ADlafAoWlD8bOxFBzIpA5Z
 nPwJpgQ0CEY2E5A3nwttDN/5vhdIrBDD7ME1v6soH42tZqnaWZkksWBIIeABz8dk0DqUWmgmMPF
 7VcpV08MJe8A8F6nGD1KumE3AvGlxOiHPxhIvh60O4GHECLVQLQarOJZPm2y/PHxiSc0e0Vf03/
 JjRxxJ/nFlMd25uY3XEZf47msMx35rwxdaY2C051I0M93PvKxOBRaSxPEyjokWVlxNvIHwtKApO
 /0+QroWmyzMfAktXns+HPlikJDikB4MFRKvo5GI6tovvgfBceZM+gGwRek7kPW4oqTZzC9i8SKC
 /OIIq+nGZ0zWeAVJTxHal5kWm4mw7c
X-Google-Smtp-Source: AGHT+IGeyVfCoRLo9zKUP0CseoOIH215RsnVpVGdaOaHpmVfC41+KlnAygMIdMDLXKsCn8BJrSFhzw==
X-Received: by 2002:a05:6820:221f:b0:659:9a49:8ee6 with SMTP id
 006d021491bc7-65b4523ee89mr1183272eaf.26.1765557971285; 
 Fri, 12 Dec 2025 08:46:11 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b4a581cf6sm766531eaf.5.2025.12.12.08.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:46:10 -0800 (PST)
Message-ID: <60ab6764-1748-469f-8597-2bfaef749ec2@linaro.org>
Date: Fri, 12 Dec 2025 10:46:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 16/22] target/mips: Expand HELPER_LD_ATOMIC()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> Since it is easier to maintain a plain C function,
> expand the HELPER_LD_ATOMIC() macro as do_ll().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 51 +++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 20 deletions(-)

It's worth looking to make sure these functions are inlined in the -O2 build.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

