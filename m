Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982BDD65537
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzgb-0003gs-L9; Tue, 26 Nov 2024 12:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFzgU-0003fu-Ds
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:49:10 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFzgI-0002lb-9v
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:48:59 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21260cfc918so41634525ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732643337; x=1733248137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=py3bas/inOsUM5HDFYSzz+yH9/NOPOso45ep82zMtR0=;
 b=Bo7ALbK+NBDONexfA9KsV//W71Zcov+OF1quMTNFTrWra2NGD1+p4hwIhxPMm/dGcO
 UdKXJWKOcYyNoc1snuZbOnCxvf5iO7qk8uL9M0WOBVFJI+CRab6gD+ASHuk46I7RU2bg
 RWaCz7LxTV6pTJ/gvWnYvV/8TtsIjYhN75OK7bYIDnfWAnCjYHIKsJvfkmD9Is3qOriq
 gy5R1XS7Nf8MOAevYwZZgfQAQjeFxbnd0Kjg0hQft8p3BQ3dgbhwSm/g9D+iCSAjBll+
 GypGsyxZ+RQS10O5HHFgDYNIiaD49sIs+v+T3/xnFUEE6NIrEfI0tJ0vFYvOGc6Lydw9
 cy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732643337; x=1733248137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=py3bas/inOsUM5HDFYSzz+yH9/NOPOso45ep82zMtR0=;
 b=gJycw4S8x6l7NlMmhqCjOOYWryHkgXCqZZW2Dk2WyliposVw9Jc3oJXjIMyl4OqDt/
 HS2cRj4g0eXLwp1YMngeWYzT7kddwPfookvrN/im7hzWLR4qx47HiiWme901t7jxLNpE
 jPVkYV9JfDS1k9psIknKClyeDsDxYY9Ka9lPlUVMG+o+gnmsikISK8VbJzIxU1KeJAu1
 rwdcpTk5+XjMjj6sEN7Nfa8YftRmypBvJf/ZTFljB4u/er2AwbpcbUjn33MURe1r+5UD
 CSJ1LpTyjhi71Y/oohTu1FUnSAVohCoi0araJVX3uOMgTFgjPhmp6v5zU3hBH3j+0IBI
 Q52g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXilteh9paTp13jyiucoh841h/sm5631DdBvLR//wpqg9JqpsKtQUV0/s96DTPkY3xJMP59F1bn9h/@nongnu.org
X-Gm-Message-State: AOJu0YzI9MNYR/NeFlMbN5+lev6F9fdeAk5lfwh8NXdp33FOh4vD8mZI
 4aZOPyWh8dXmN8rIdwYqcYyAy7x03WX3+k9wW+GsCis1jeTlBmMgIbKQIaTnLvGFQhjnF2337pT
 47UA=
X-Gm-Gg: ASbGnctO81fxmJ+qJZAhvCO9JU85kOE5QkZUocKzzqZhQLXtyagYkG/wETekcOk0TyM
 XnFxyX0FVtkRV+hiskQ3kIPsxHXRbWoNLUdywRT8Bl53Km/GGU2aKpeKwNhCStCMN8Yn3aBBJf3
 OOwTvbjyPlROK56vyo0wFfCiuumJONGp0PVq+Cc9rsqT1kRzozZbgJKDpx4Xb5izVBUsgagktgp
 qZtSSfrz+p9I4nZVhwJNzqUq2mtlz//i/b65vU6wczSwpNIA19peNXDFwq72CqPAtqOERkRNAoQ
 5BeaaYd4oZsM8KzTFrNmTA==
X-Google-Smtp-Source: AGHT+IHZIiwgigkNUSfV9FwIbhNSG80IMasr4sFIE48U2Fxa8cj72ENEXU6mBUFfULjkV7EsTuqr4A==
X-Received: by 2002:a17:903:234c:b0:20c:5e86:9b5e with SMTP id
 d9443c01a7336-21501086e0dmr687825ad.3.1732643336863; 
 Tue, 26 Nov 2024 09:48:56 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dbff549sm87492285ad.130.2024.11.26.09.48.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 09:48:56 -0800 (PST)
Message-ID: <8da5c689-3116-42c1-b215-fbb50f35f49c@linaro.org>
Date: Tue, 26 Nov 2024 09:48:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Dmitry Frolov <frolov@swemel.ru>,
 lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20241113094342.282676-2-frolov@swemel.ru> <87bjyij0q2.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87bjyij0q2.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 11/13/24 13:13, Fabiano Rosas wrote:
> Dmitry Frolov <frolov@swemel.ru> writes:
> 
>> Some tests need more time when qemu is built with
>> "--enable-asan --enable-ubsan"
>>
>> As was discussed here:
>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/
>>
>> TIMEOUT_MULTIPLIER enviroment variable will be
>> a useful option, allowing non-invasive timeouts
>> increasing for a specific build.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> 
> Tested-by: Fabiano Rosas <farosas@suse.de>
> 
> and queued for qtest.
> 

Hi Fabiano,

will a PR be sent for 9.2 release, or later?

Regards,
Pierrick

