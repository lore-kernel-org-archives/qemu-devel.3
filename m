Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186C3CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhih-0005id-Nj; Tue, 28 Oct 2025 07:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDhiO-0005eN-FD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:18:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDhiE-0002MF-80
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:18:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710683a644so48956505e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650277; x=1762255077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=buMMJCYiw5u8FqSVy/nR64fQUqX4QZ2XteO388mH1Sw=;
 b=SnfpOunjZ2PShydkq1K7FTQd9FK948i1ybp/U9GsRpDYgX7TeX+Mxnp1grgUQ0yDsg
 Cdz3ivgCqBNLakBAWIe6ZQiD+Y9wGJ8JfqvaY3MKr0u332PpxN87O9iGImasg4ANpeI7
 0pb2txjOYfZhjQgH/d2vVPxpTVzAl47iiFTutPYsRCHzqqEpGT7iX1qflR2o9UWrh6wx
 2t47Al9nis3MXmQBb+N6vMIPzCrITc7UOwymjCMzcffMlps1bmKw+HvUe1NrQ6rNbuXf
 pMzsnYUPL6KW6DIFw3D5oiB0MrPBt/o2Re+kKfvOHz+y7vOG5OtmACppWcZxytfRQ791
 rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650277; x=1762255077;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=buMMJCYiw5u8FqSVy/nR64fQUqX4QZ2XteO388mH1Sw=;
 b=A8ZrDkZYRzheBP+lR0SgrNEnaBOHGAI+7c6UtTXjCXqTV44dcaapHmhsMYkFLW8+sG
 GEccGciOTb4cVEaLID1zWiky+FYjublAFVNjn4uvo7+nq9A/wZZpu2t8E2ye1Lzq6Bh8
 xFach9nmlP1qGmHpaVmKCPxQFPcv7J7scbzPTiXd8342QPo0l7Du8b1dL4dG0T3YQ7xV
 ckg6iBW605lW5CVSEc0/twcslM25Mqu9Ezrb4DgocWTCL++I6p2lQCzSTuflIbwCgPIm
 Jnw2iKJddkqnL/NzqGrc1TQdz9cZ39WQFql1Q7a3oEs3wU9kJ9F+qSC+Ej0V757mbtWD
 ZXnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeB2KTf/HSZbd5y1auwgCiSYvbdNU9i1cEC+OJ5Lxt6OEvW66lQk4IwdyAU4CygI1UOYzsc3lsjkGF@nongnu.org
X-Gm-Message-State: AOJu0YwqTo2EQi2YsS5GVvdsRsA7nADyG0iQz4djEeM7desiZUtm87eE
 T/REkX7GRhiBa0W97zyGqNC9yYXXIOD1jhdjbjsK6/pxb+csUuH12/g6AfoiGvX9Qtc=
X-Gm-Gg: ASbGnctrgfTFzTn/zGZW3/slKqro8bBJmg99xEZtPZq+SvN+KF4P46me68kxvsQv91t
 WxDXofzCELOP3rKTaLkoU1Dt0mKEuz+MKvH7c5XdMK78eHVp/ZejkF5dtW2Mui6BjrU+UcReON/
 mZiyMphL6t/HtWpUFRjcyJC8KMwIS6uJU9gE+4Dm4QMOj4c4A1/qQgZ00qO8t3QGoj19aZzujFG
 0x+ope1XSmQetes+b7OR0f8WjwqNw4c0inPTcBFmUtk56W2tlYXND2ElMknupws85xy0MAXYZXg
 XYkEf0S6thEiaeFdIRzODSaLxRVrwBBxSGO4BcxGsoQTqfoQOpwYysRXSwawAurpUeJIBDtO8yf
 rWKYkQ4OX8K5Z91W53dKlR6ti11xTAe5CB81tjUUq2jZUnNk2+XczXyhEAkt0RODE5j45yRMMfj
 NJ6fIUvMHAd5tB/DzZ
X-Google-Smtp-Source: AGHT+IE27veOXHISJlLcKPt+uyODB6907+Z0ljBvxskoEFIDknVqX+TqkdSx9qlmLRYeZnu/rVswFg==
X-Received: by 2002:a05:600c:861a:b0:475:de75:84c6 with SMTP id
 5b1f17b1804b1-4771816e9f7mr15013455e9.12.1761650277043; 
 Tue, 28 Oct 2025 04:17:57 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm20006032f8f.13.2025.10.28.04.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:17:56 -0700 (PDT)
Message-ID: <0359cbb1-d6ec-4d65-9ef1-2dc9fca6c038@linaro.org>
Date: Tue, 28 Oct 2025 12:17:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 1/2] linux-user: add a plugin API to filter syscalls
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 alex bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 Yun Wang <yunwang94@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
 <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
 <80029288-4571-4e5a-ab99-b3c5c8daf8b6@linaro.org>
 <881d4aaf-2a75-4941-869a-076334650bf7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <881d4aaf-2a75-4941-869a-076334650bf7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/27/25 08:14, Pierrick Bouvier wrote:
> 
> Thanks for the review.
> Beyond the code style, are you open to accept such a functionality as part of API plugins?

Yes.


r~

