Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D716CFD4F0A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00Yq-0007tP-AD; Tue, 10 Mar 2026 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w00Yo-0007rl-AE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:07:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w00Ym-0001qx-Sr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:07:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso1320155e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773162475; x=1773767275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ib5erO2BBy/ha/8254UaBJ7zefW4MaIsLWTIpgciiEQ=;
 b=rPXpJAPTCMJ1c7CkzXhT1Ljc/PRaSKXRZ4W5ZK9tJ7ih3z3v/bYMXttaTfe/DQmMis
 HqlZVKT5aGdq6pr9M6EDqx44uuiJqCoxrPtn7C+avze35vVQ0Q8tCJ3uSR6aRvClZjcC
 MnFVnA4PtMAuFARduJJhBAV77L6FwqOMiLr0XRKMEeSAQAxl3wl41sudg0hnwvQ6WGDP
 m7ikbnVC/jRzkUWfcKzqoEvrPkwgBbxPsgGHZVUpvOKFFqib+yGlQPc1cZmdK4DBCGbW
 5zhzOBTjf6TPQR1QMCYPmwi7dcPY+uRKJP2YyZ06G8q0JrelFYtS/NzbC79slR6CAznB
 vXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773162475; x=1773767275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ib5erO2BBy/ha/8254UaBJ7zefW4MaIsLWTIpgciiEQ=;
 b=DhOdwxgcHiLmKcgP6yJEEOqSUKXxrtzwMbn4UiFL6FNR9lWqtz85aekr+ydu302HgH
 7JllMjfBvSG4KczsMtnOqbht8WOZukNiB10kuVlaid4IN/WcmeekMjMKfpSIforPuAOF
 F8z0WE3tuGDpbAT+Xjp0NYEFghjPsvNIQEi9j5yP7h1fCoTVxIAsBLxbO1hgBkVB+lD7
 OoDs7H3Q8gxsamTjr/P4hSp2ZtJyPIMgkqZ+tWhcVZqSGZlhsLd/Arno+OXIjg2JFf5x
 IzdxvwmKzIu7LL+mkcpjhwnJlaEeHjqorg4k5XWRZAziobW7/RA8rBcCGAJdeaHKJm+N
 n6CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBHG4+BRKPwO5DHJP2gLhkuIWPpGtvEQ2jzVS2ly7y4gpowJaIomDtKKUTZVFTfoVtTwUAKtYnATaI@nongnu.org
X-Gm-Message-State: AOJu0YxGuaNHNjv9hWzVgfZ/KeTYeNccV91q9pYaoitK80Z1CjHCgM81
 qla6GtTnwx4kLkGF1grWFSgLIud9LrNlsT9g15GlvGuod98HN1qRvkQ57sz2bBK8opw=
X-Gm-Gg: ATEYQzzuZyj8yx2IQz2BAbdHFj15MXD6LB6FaeDV5O/O2suZbyi+CTXJ6iWDXP1NhzK
 /Rnp7zfj2RNF3kEiS1kHdIUkC3e1MHCOse1PxBYERs9IysSon51bS0mE5AXNKPR1ssJZgwgTDq4
 N7zYPhAKUdT8gTaopWs9ZuvI8bhD+Czy8AOay6v3YC6QxnMO95tiMbBi3NpE/SbjbdIO17xN7jS
 E1WJWJg3+11/WxjJkyDQDLNfckd+aYRxwOt0MozE1aRyf3G+MEEz6rxkryZzdPxDTCyblOYJler
 UZkTkQ+27bFRv8NowfR6NaLBFdxIP33YKcIpNJEYefhqpNiJrO5XdTRlrNP1M5yEW8u4lUof44c
 C/QmY+2Pgnqq3b3HWS+MekWEWC3KlDdvVICZ+UaBKxLo16+m4g3g3OjGO+hv9pQApUbvlATl21h
 61FzRAmmNBXhocJ6oQ/y79mIOa3bW9oH81yswYk+mge/H9kNjPUil0DJnePCUpiwGeT8KFvNaOl
 UQf
X-Received: by 2002:a05:600c:4f8e:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-485419cc0c0mr58808515e9.8.1773162475085; 
 Tue, 10 Mar 2026 10:07:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm148960285e9.8.2026.03.10.10.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 10:07:54 -0700 (PDT)
Message-ID: <ecf33730-030c-4f69-be38-831ae740005c@linaro.org>
Date: Tue, 10 Mar 2026 18:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest/ast2700-gpio-test: Use g_strdup_printf()
 instead of char arrays
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260310153334.3063224-1-peter.maydell@linaro.org>
 <20260310153334.3063224-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260310153334.3063224-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/3/26 16:33, Peter Maydell wrote:
> Older versions of gcc with -Wformat-overflow=2 don't like the usage of
> fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:
> 
> ../tests/qtest/ast2700-gpio-test.c: In function ‘test_input_pins’:
> ../tests/qtest/ast2700-gpio-test.c:54:36: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
>               sprintf(name, "gpio%c%d", c, i);
>                                      ^
> ../tests/qtest/ast2700-gpio-test.c:54:13: note: ‘sprintf’ output between 7 and 17 bytes into a destination of size 16
>               sprintf(name, "gpio%c%d", c, i);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This can't actually happen because of the limited size of the values
> being substituted in.  However rather than require readers to check
> whether the arrays really have been declared large enough, we prefer
> to use g_strdup_printf() for this kind of string work.
> 
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/ast2700-gpio-test.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

