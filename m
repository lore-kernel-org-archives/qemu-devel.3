Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA2FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5NX-0006qb-2R; Tue, 07 Jan 2025 03:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5NU-0006pC-FK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:55:56 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5NT-0001Po-0K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:55:56 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so9126148f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736240153; x=1736844953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwoR00q6P4jTmeclDoarmXj+/W/w5Z9JhyH5kgrduX4=;
 b=r9pwA24iELZrZoLxzQY9uVYpqUoSeX+ypPGUyUk9Q8Wu/9yXRwWsTFjQyI5V95nY++
 5QDf+bFuEPs3y6h52pTvDDLPQYFRv84CLdBun7QFrpdSbGKEjoouCW5m5HVwDZ1IhNo9
 4qHzoGDz5kZswAGyLR+DoiOtXai4qn09LhqBbVl3k0qvdxlal3CrOuSQ8y8TayRHFUol
 7ZjiVCtPwNqcmngOiBYz1sHWsO5req6CM3Sd5ik1atsPlKfdk/PIJ0ypyXqynI6kj0BM
 PhpClR0HfhMpgrL4hayvyyiufZb7WgyB3daPrgQsX7NdoPWNsIFoNmAfHiTAYT3CgypT
 MO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736240153; x=1736844953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mwoR00q6P4jTmeclDoarmXj+/W/w5Z9JhyH5kgrduX4=;
 b=t9V6FCqWlNmaW73ZcX/ddral1zK31lfFAuZXPcRB+KHOLn0WO+GtcLuG4mUPnxH5rr
 ZYfsdTVtlvi8VivDtDKijns/aMQPcltybzGRdNQ8vy9l8sJTkg4z+P/CQ0UFEjc7FbOa
 feGpZhQKNGa1gSCeXLNR5w6rSXVLGYtsJkvKwv3EnB6pVkF9iA2Qu+yCRSBliekAzw7B
 +UPlWahLuIejhgKin1Rf/7ADa7hyE72pnKUhMEnlosygb+e88lyOO8mK8RvxzAhmqnsa
 IiOGgLYYn37iOiccRajx60yf/Vo5PLMjmAKGWYWeVbC3TQboY6vdmaBOtHsOvoki5UgY
 0XcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbIvyfZfOVSxGq5AnBZhKr9I1Ivsn+w4m2g2S8liefr7MnrcRIAJO0n0Hedu+dd/XjEAU5eB9KbX0D@nongnu.org
X-Gm-Message-State: AOJu0Yx6KKGyWYq6c0RZUfIZkjeV7bDdu16KDorzyMGVOFL4/gHOdNBX
 qFW43dObwQd437tA1MFMi4xiSr7frFG8pWDAASRH5C6efI/vpW8//Fzj5VLBSqM=
X-Gm-Gg: ASbGncssuw5AzARr+vKdEaigsZK48MO9mZ4525+D/+FeqvXrGkAOFeRGS5jqVVeqR3e
 x94PWoHki8zdKBk5fpqeDEDta1YMjOnn33cNJ1Or0ZsoY/BwpjDatQMqB+BeMYeB67n0hh5HLjj
 YXwPimt+mxS6RAk/JqwdI2FzE0WkqxJuMNiJ0zpNtbZHqVUlBG2HdoCS8fqnYQuIZcBClH8pZLO
 JfQVNnfryZMeLp3NDVBhiqQHEjKHZKr3LxoLgeziRXCS+PozcXfF1vAYN+dkT0vvV4BQ1ExfbdM
 pwdbRfwnYu3aot/GarY/138R
X-Google-Smtp-Source: AGHT+IFY4JaGD9zslmdbhZNB5Q7bIeMnNNJA+CjfbZiEDsIDW4TDkw48fCn4u6SEnS6fgTS9xsMLUg==
X-Received: by 2002:a05:6000:1faa:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-38a221f9c14mr49211771f8f.27.1736240153206; 
 Tue, 07 Jan 2025 00:55:53 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac97fsm49216034f8f.92.2025.01.07.00.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 00:55:52 -0800 (PST)
Message-ID: <d97cbd45-7f7e-4c03-9cc8-5f3ad280d804@linaro.org>
Date: Tue, 7 Jan 2025 09:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/81] tcg: Move tcg_op_insert_{after, before} decls to
 tcg-internal.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> These are not particularly useful outside of optimization passes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h  | 4 ----
>   tcg/tcg-internal.h | 5 +++++
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


