Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A256C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLvx-0001tA-Gl; Sat, 02 Aug 2025 19:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLot-0006vn-PR
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:19 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLor-0006Wi-9R
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:18 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8fe929b147so1303879276.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177956; x=1754782756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w3HQj0uQugwNY/q3lKzRpUuD+MAh2mwqDvVFwmHi++A=;
 b=oKllchGLEwXGUenIOXkom60ZAmE4JMmIPjQjQz8Aa06Q2j5mshDNdlyQk+B5XP8289
 nIoRrOn6sPLWUQVMKCp7Gu69imOrquctJ5nZdX/qscsfPtqB9aCYvwQMpIjWOXm4mVFE
 QPRQKfNNi2M9mExo880y7RETEisxv2eb8k3V0u/K/1nTzgGKl/10cApobubRdpBv4276
 Cdn4SizMjk3bZKfrRYvboG7H1JHVrBcaj9v8MavGhsXvGXl6BiGMlXGS0MaeKTIUA8+q
 lOYNeM3B1ALLI9BB935bNwPo/UMAzPBWPHllAJQRVSUKQjlXV5vuHJTYqtfiTJI11p0e
 CyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177956; x=1754782756;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3HQj0uQugwNY/q3lKzRpUuD+MAh2mwqDvVFwmHi++A=;
 b=g3Re/aOUzIhPWoSbHyBU7/iMVdWj96xMlgCEbbqnDnbCk/DmjZ+TeQLHrMlYMeyDQE
 5Hs6TnZqY23tovqVIp8b0ssN0gJ7tz5I73rRWEDNvqV8ZaQFs/4/PnJev+iRJw4s4bsL
 oxPBX7CXVE06hx1WpPNlBd8pekkj+zOm0/FaTLZTayOxQhaDp6Daa29rJFZE1PviC9rn
 7U6Wd94XFTH81jj8kROmxmagDEuYz8feScXxNNiKwicm9x5Mh3ocs3Y8WzCxOy0sVJeU
 nT3GU+A6CrpYq3qmSIRyQh2zJUOIjqezMNwEf/h9HIsTbYbdiGsuNV9lBb1os3eprmTh
 I6WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1T5CQJ1crqtXqK0MpdTYHXKLXmgPoFFyO89HUy2UMRBI5CtC9FXMvCsYUqEskl2WwWnlpFojrCJYz@nongnu.org
X-Gm-Message-State: AOJu0YyD2ucCzaaohW88f2P37nyFDGWEiwACy9AYMZuLeBYtOjr4FaBo
 8kMsqrBAJIpRa6HU6HZQQktQkVVFF9NfCdhsYuUPSSPxBewDGmDWvUma21SEBXz4RKA=
X-Gm-Gg: ASbGncstmTKeHWzeAdh014ORW7fkNi1v9JD4xlYfJaVL0ovos8h10ttZqCPdG8cbp3h
 050bfYPQ8aFLfgsrPUjufb43jm1jHp9pzA+PQEm2AvjQIrOuyZDoHWhwzTpjtKqaYRVU5yaJ8pE
 Uuo67jat/bgKxcI4J/4CwiwIZM7I/f48iFJFycj5XvWlfCUWdupZP5nNRmn/gS2v0vRY23ZFuc+
 RH8jw6ncKoRA2mz0QVHMeEbCZCpza0bSmMS2+Ix80vmpmHLEfeks3iobBba9+9FRYsuhJbwfmAz
 Qv7BoGIU1lupR6ss1CnaH6t9BD2tGnL1tZ+1FPvAYPfKKNZS4aP4/oJ4w2N4mMCzP1Dfpj4LTBY
 YNV5mf0STZhz6/fcMTXNQGoyz1Nqhsut1ZccNFI7JtnEZ9NUxP1GbEl227FAMQ8m4+HkuyC3dw4
 M=
X-Google-Smtp-Source: AGHT+IFGznS+Hw8McaLjAA3gQO64P49RYXazhR+8mKLSQxLYWFjg8xh8UdDAfaWzpQalAw0we1iUKw==
X-Received: by 2002:a05:690c:660c:b0:710:e81b:f7cf with SMTP id
 00721157ae682-71b7ed716bbmr61813197b3.13.1754177955755; 
 Sat, 02 Aug 2025 16:39:15 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3a9b89sm18231637b3.15.2025.08.02.16.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 16:39:15 -0700 (PDT)
Message-ID: <2ab7fe7d-e2e1-41f1-b4c9-13de6306d75e@linaro.org>
Date: Sun, 3 Aug 2025 09:39:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] semihosting/arm-compat-semi: replace target_long
 with int64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
 <20250801232609.2744557-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250801232609.2744557-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2b.google.com
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

On 8/2/25 09:26, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   semihosting/arm-compat-semi.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

