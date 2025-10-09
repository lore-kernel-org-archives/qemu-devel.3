Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2F1CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6u1V-0004OI-M2; Thu, 09 Oct 2025 13:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u1O-0004KS-Qf
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:01:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u1F-0007ip-73
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:01:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so1575533a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029288; x=1760634088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4SCxbunFZbmCEtwka90YGCyjRG0MAyk31Os3cnonfs=;
 b=kZl+Zsi2POULuZdvN9FYBxLnPw+jr7vhqLhhzBxP4Nej3uaG9db98nSamYn6lRgB4T
 /Nvvg4RqBdZBpfbLesSVjj8d8P8RDlul6zS3sx0w+wAKUu5uJ2Eb552DN6UqU9kjHrv4
 +OkLlpA2FJ7n1a5iNvvmi7k16OAEJka2m5EkwVJGc+kXQ2/Klke6PnvZ5giD5LxvF4MT
 Ne7V/NqzQ8doNxzPOeiRW2OwAPphOjVjzbrWxfBSRAnxSbCDOpWzpmlZPpWGes26ySSf
 wvAPnZjwQHLuc3FMUjukv9AeQwmajh+QNL2gtkCFY2FmibrmLvghmK/DkjQmgJARF4Yg
 XFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029288; x=1760634088;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4SCxbunFZbmCEtwka90YGCyjRG0MAyk31Os3cnonfs=;
 b=Zglmh79GUJwFIAiSYn74zv225Q6H7Kdddq4/cQvaYCGJNIHetrQ+LGf6HQqnhvEry5
 jMfJZlpTo2yICgwcdCCHrUusrj+eSqIeOkdE6fmEQZ4YTfFmoRymoOcX0gsqVoQePZzk
 z8OzxWeFypm6D5lQguq8xKJi5NHiYUzGpZA0BrMqP0r7KIElLb53bFF5PgKndZwYPAD2
 hNlw1AWayCA88Nwm0JQcPbJMQFmJDxY5gGNN1mNAHvEhvkOk3aQUsRYECGfZB7u+m/uz
 XxRZ2Q86RXbPEoAr8Njn759N53vAZ87CWOZ/0+0lcX1ec7F0Rp0pAHzLWdyV8Eh49G8Z
 UgQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUszv+z0Y30Va+ccAZu4BYtX+5UbmdZy36vO76VS4D04Gf6nr52tNOkOEHru7PFeWp0cTlEEW+WJu5i@nongnu.org
X-Gm-Message-State: AOJu0YyQtZvrLm33afcPsINU7BLBU3Ga8cn3W2l7MkdExx1H0YZeimLk
 F6wKjZDHIouUenULnsKELq+kKbRsxoivKWP3UzdSuBcWwFe2NLlBDl8zhK2weBJ5hW0=
X-Gm-Gg: ASbGnctY5vwrZzHgozMfH4erS1mVrRAQlyyQ57je6m6xMWdRwaYzvnEjbpZfEx3HFa+
 xO5PYfKogzgm+BWXNs198w+g7zsLuwR55x7FoOR2yR+7vnfbxA2YTO65HRFT3FyioBgV4KFmEMw
 eqLL2GG9SYt2CW5HG9gJ0Dv9iEavcXUy/bX2DqbAV1KmXPq/xvXG6C9zF03MySV+5NS75Qybw8J
 gBLf/Yr7KeRHEXPL5SUi4AR1YIF0eQk+l/Kx2I4gDhV647gMR0CMpJLeBZMENzcW9KMhfoothCd
 aKvuky9O2y4kwL1P6jW3IZ14on3lvAbKhlQuL5Wl9IPCTkklT/3rkPDw4Fn3kT0tFhn9R4s2UPu
 doFU9Tw1zudW6yLXmNuVsGDIaU97HZVAmVLPeCgVaj//0qdfCuIeadvT9bScGFTlr
X-Google-Smtp-Source: AGHT+IHCqezlLK4enmVQYSDO2QEpoWlBLXBU3BnVZ4mOKmrFihJRr0kqC/0l67XhjwfVoL7bSlFx3g==
X-Received: by 2002:a17:90b:38cb:b0:332:906a:85cd with SMTP id
 98e67ed59e1d1-33b513757bemr11301885a91.19.1760029287450; 
 Thu, 09 Oct 2025 10:01:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b52899a7csm3521418a91.0.2025.10.09.10.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:01:27 -0700 (PDT)
Message-ID: <cd587174-c719-424e-aaf6-72ab027a3beb@linaro.org>
Date: Thu, 9 Oct 2025 10:01:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/hppa: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> mo_endian() returns the target endianness.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

