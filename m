Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38FAD74969
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWNu-00035A-0R; Fri, 19 Dec 2025 04:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWWNl-00034a-UY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:02:44 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWWNk-0001Cl-CD
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:02:41 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so9583635e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766134958; x=1766739758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=adpDyaQvxXxXu5Lo/MFb3/3B2CYGte2+JVXQOds1J6s=;
 b=g4REVI9/bmeVYC50cOARo4Qa8Q8M0/cLPXBp1JvKx5dpLX8pJrQQQzSOzQiB5pMkMo
 3ntocjN4Plmkwqw+UZZRXUWM5xxq2tVsrPQDZx3ZCdutRzXJAwyIJ2Hg+g5CGNrA+RoX
 57Aneerw070/t3nP7EtR5vCC5GT3Uesk/3yjAGkSkagt6hCFujNY8EO5OkZ8v6uBYTig
 gfr/qXsEMhEJrvbSja3MTBDMLyVfCwkckTPFGuBNBnJ6nP6X97LKD5d0kqpw7N9JidIw
 /h0sdMSebFJqdn4qLvZhE1XLR/LQEr31TTiVGUNCnkIjCulaIDfRKaCxyTJ7qtmkKdXh
 432g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766134958; x=1766739758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adpDyaQvxXxXu5Lo/MFb3/3B2CYGte2+JVXQOds1J6s=;
 b=UrvkqJxkoQb2zO38NRYS9+au30FoHFekK5OYctrWLvettXo1KvpDnT3AXsfs6zFFj6
 OokZ9mWC12Ssk6Tt2l+4bPsl9aU8rZizzJFjHhL/eyW0c9ibLOQ2uC/uKwbBhQF6yWdH
 /ra/pJfHQ/LmYjSFZhZyRY5xUrylEVr7CB6mK5tysuvq76vqu1qOwF+6w5MTbLch2S/H
 KT5IiZMiXV0ZmvqPmm8af+cznKUOMLH+NM2zUXZkxF8LuuNaTXVa/rS6quNcyDJ6LAH/
 AMctgVL7EBWwEjqQaHH5dfk0+4XJIZs3jcj1g2iui56Rum/7WcFftDnNzZcRbp7JstTr
 TJ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHei5vLLH0obYo2Ut5F1Z6qvhsEQIPJfrCTbWPDhTgWhrOgJJ8KZUKgo/MLBZ3bMkKCZSF+nK2r/8E@nongnu.org
X-Gm-Message-State: AOJu0YxC8yGiND8wM1ZEV7XZgBf+dGCm94O0BgDXfIslWefTrK9R884i
 78ASxCgzHERWJJa4RuLRa4ns8YFZGZRkQMoDEyaofkGqNyyc6JzZ+oIIHF4FAKmKOBE=
X-Gm-Gg: AY/fxX7vDplvbv8FEkALegPiEqT0ojouc7grewr626X4p2Cj0ShQvkzcHv0FXWZKMzm
 BDgHQC9y6aUtBEYPTOgsNEEFbnDZy4iBHYxxVmjKTvnUop1E65dB4NY6lll2rWbBm3hB3yiz4fd
 YKYdvxNuy9vLTyX615xfwAo1m711SIzd2agWpci1gTH7Fzmj9nDZ8mELtvJCokj6Qe52zEtfY0F
 EYZtCGQceJAmiFPnQF+f6s99Avix+JLtZknYzGlTMwiObHtFtUzM7bKjrZ0iakkGz/AjmQgY+H5
 kpHsJ1DEYRHrUpzTXTAfeB/2EEZqthxQKi+dnYokSA92iFwvhuBo+U3ujRGHAg1ZJogffVGyPWc
 Y30HXxoU5pMnceboYi9E7QT57yHpoQKCgiUhih7Puobe0AShnXIdGGqI7Fu5l3O64+2vmbMrTI1
 HqzZvRpJK0AcfWKIvsiK0MBZmvwMW3v+7iCiISENr0lRqlkjtnYs+yKA==
X-Google-Smtp-Source: AGHT+IFdSJF/v0mWL+Sx+p12JveJPevH0b93ZRvGCWuF0gGXigP2FtBdaoNUqK0iHaB8DQHvzQbtZQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d19546487mr18032695e9.12.1766134958098; 
 Fri, 19 Dec 2025 01:02:38 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346dfcsm41828215e9.1.2025.12.19.01.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:02:37 -0800 (PST)
Message-ID: <a8a2eec0-f458-40e6-bfcc-d51be9333799@linaro.org>
Date: Fri, 19 Dec 2025 10:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
Content-Language: en-US
To: Jackson Donaldson <jcksn@duck.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20251218214306.63667-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218214306.63667-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 18/12/25 22:43, Philippe Mathieu-Daudé wrote:
> Unfortunately while rebasing the series registering the
> ARM/Aarch64 machine interfaces and getting it merged as
> commit 38c5ab40031 ("hw/arm: Filter machine types for
> qemu-system-arm/aarch64 binaries") we missed the recent
> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
> Correct that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248

We have a functional test for this machine
(tests/functional/arm/test_max78000fthr.py)
so I don't understand how we missed this.

> Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/max78000fthr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)


