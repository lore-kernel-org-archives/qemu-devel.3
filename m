Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C308C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RTL-0005Gq-LJ; Fri, 25 Apr 2025 18:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RT0-00052t-BW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:24:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RSy-0004MR-IT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:24:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1767580f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745619854; x=1746224654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UAdFV5EgY0DcLQsaiDziWDHGl+k2cCf5iTdE37WRRbg=;
 b=BHG13CUt1XD3HHCP30rU8DN5lnl5Qwj8LJaXbQlUy9774xJqX2nWs2WNvect3OzGix
 iuG8rLbIeeBITvxfMC+L30JTR2oskXGWYdGZQqyWDU5fVS2BXh1GKZp3cTf8I0LKMz6S
 4USyWQPk94W1GOUWaUd73u2tuuD21UA4DfUEjKUXw2PeNolcxbvmaedsl5QwbtMRQB3M
 MBhapBJp0aF+Oup3+1PtgGrbq3qmNR5FvaOaIWRa/DQNc35RdPY9dQwmyYQcvWG3iL+s
 Yxe4asi36IZ7d1zq6mnXK+nwGkDuHewzJaRG/dyeyOCDhV9stz68DUlv1PG1w725J9c/
 TdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745619854; x=1746224654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UAdFV5EgY0DcLQsaiDziWDHGl+k2cCf5iTdE37WRRbg=;
 b=J+BXmwuefzFro78chAZjNcNrhRVPP7DkueLkFnqzJqwVl9VT5DNUIQEmsjYxLbvz68
 cFJLHnfZT06JjeaxJR7bTOwFC7C8Z9ditDgcpIh0zZTGctDpb9RlJYFd+v4CkPdpa2UT
 +QPrHZmyfefRV9RDAJOLSN9iwYkgBrYGKXRAp4guY1JRZ9GLVNLPPoZK0buV5xD8Fp+M
 oqWapqt6CiO25YhW+8u6BKf4Rdxrc2ieTd3XJieUBJQX+jcVKkYrRGcKM62o0yoTP/pZ
 pw9XI9b9I38feGt6BvG6D+2BMwMbCyMQfguOtGrDZk94sx0HDppu0c/ZbUMw5NJXtZ2R
 s+xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYAJcewC5mxYwL+2VhKWzXPZS50F5zETKs2O/oylJT9nsxTVxtYcgdaeMcCzqIMGH/NCV7f3Sdw+zz@nongnu.org
X-Gm-Message-State: AOJu0YwLBKgugxW839dJnteI3yGq9cf+fEHLlINpl4nA22uN4UzdtWHG
 ulNrEiJ22KI4CFbJXdI4m52OovJDAYMW2V9Tg/R0+ODbOv6BhgfN2beXpXk8+ue04+Igmze4Gp3
 7
X-Gm-Gg: ASbGncvjyWgPXitcBmkX4oi5EtLkXw0xcKQPPl/z0Nbryv+36IlmQsDI15V9uJLuHWN
 fORIdlB3LWRRN9D7MIMybUYOlZXClQVzYwAHJZvSCj/1D365ZpZJr6AvKevAWstkHbVi8CQmXeM
 /88a4daWCt1rGV686b9eTwNVFcVscmoAS0r0uo8tDM7cWx4I66udijNp7FfDQyyBL0U+pOFpSsE
 MlK7kIuPWQm/oW3tBD43wIW1R255TpfTNk9ryllg/WKuBzpZHhjFZnlDI3UyCt4PSmp9+MjCwmK
 UULb9i3EMKAsZvw5fqUn8sAfPLpqjRwvsYNqB2o4Q3/W74jWtbvwvnAHcO3m0iV2hgYAeEEVkub
 kC0ZCerU6
X-Google-Smtp-Source: AGHT+IGxzJxrRDchr1K0oSV8PQ/7DzdpYenOCZTObdyUFl3Bdg2X0fBXUdBkRPEpTJCBnnpo2/a5XA==
X-Received: by 2002:a05:6000:248a:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-3a06d66d0ebmr6702861f8f.15.1745619854174; 
 Fri, 25 Apr 2025 15:24:14 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e01bdsm72033555e9.38.2025.04.25.15.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:24:12 -0700 (PDT)
Message-ID: <31c2dec5-70be-42c2-9e93-aac053b8dab6@linaro.org>
Date: Sat, 26 Apr 2025 00:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg/sparc64: Implement CTPOP
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250425200024.853260-1-richard.henderson@linaro.org>
 <20250425200024.853260-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425200024.853260-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/4/25 22:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


