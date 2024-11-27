Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712B0D6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMkz-0005s5-F8; Wed, 27 Nov 2024 13:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMkx-0005rw-Jh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:27:19 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMkw-0000pB-14
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:27:19 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ffdd9fc913so56441fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732732035; x=1733336835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjjLTWFfYhX4qE0rmG/LT3vdJZWAaM+yej3ATYtxulQ=;
 b=LFZsMqBsHZTZq+g5kBehUylQD2mW6nIB4sHibJUz1Tj7gnjcBKn4+1sTM1MweVJqv9
 UT5c5OTS3rv5yIGRxgqChwFs+rBR38zHpdi5Bl1llBPzLse+4/YH2+W/3a1eEuNPOV0m
 5eHOqtvRHI52T4ildt4fp8d9NULsiaFi7C3VYrEZ00br5QaJYcw1hWalUFr9sg+ei5lH
 Rt6px8GHVLtl5eKaR93cD4/Z5CGuCdziqMwlissl2pOyUyCS1frkGdi3CCAeMV+H2vC3
 3csAKzRhTyGekCS3RGzL//lPpLfqC3BMzBOzPzOuUz7dk5GVijoLomPoD4lzWWH0xDDY
 RF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732732035; x=1733336835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjjLTWFfYhX4qE0rmG/LT3vdJZWAaM+yej3ATYtxulQ=;
 b=nqsJmPWHAPfxkbS6iv45S/1i6VsHIwGcWMu+ra+QABnsNej/niH3CuochgCl9DDPOi
 q6iPdPtNuzhbyHFxMk/ahcdHVdKDdEpC+BFg9t0O1zZLKiWwj3xJ1uUvrDgQCEM/X8nm
 H+10Jel7zgCyL4IGUthSof4HM5uBBaIweo43LcPFJpCZLr+Eu56s6HHqSx3B21Admc3S
 gFzyHNBgO9i99iLtx3wcZVBD1vCprEwKiSXXZcV5mIDJ8TVoCUXa8AzljYe8O5CpunVi
 /ANlNKptMfTYu4c4VGOsCLiuIjIbYvyAKmrCEeftFLVgNoZVuskpVm9Dj1OdSEjIhWH5
 XV5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdwByAZI+RrQhlEDsOdANc4c0P5HiETJIrtQSTxn9rqCJ99lcr6GeiM5mNdCwCrRkAdBmggY6r0rAi@nongnu.org
X-Gm-Message-State: AOJu0YyZf8zIzOEiJDa9lIyNO1dWrYvM/bO7Io8nCueGx6i5y6HWOkra
 9EiG6eFjaoVFnXKEnFe3WK3ZOHiobZUAefWeUsfO3JslkmiZFAwI6HEbGpSx9B4=
X-Gm-Gg: ASbGncssyA1FTTqCTkC6dzy2v73ifNblCXD7ZPBLbP3EBenR8pU9XzUyy6axqybtWuL
 sJO4wtNgq7+rJ0ISKeIKcu72RV8PhjMjHBXaf6h0d573qYYb/PQHCqWHD+bddnExir2GsUsTJLL
 1dAw8c3Oc25B1gSDBKmjv+9O31hd5UEIf4W1UahKtidTFNjyX96YT1wBSxEd/o13H/hLXIjAr5e
 q8t84NWnobyOBn8qQZCbqwTy/VVgWrq1KQYWTqqPNOcqRMNDmyG3ERcRHDJyud25lzf
X-Google-Smtp-Source: AGHT+IGQXlRgsOgvfB4IezprqUtFtkQ93W4zEaQhq7DXlDSjgXRkfXxZZn96n1UsF5eaa/ef/Ztvvg==
X-Received: by 2002:a2e:91d1:0:b0:2ff:cae1:2297 with SMTP id
 38308e7fff4ca-2ffd60cfac5mr22980711fa.26.1732732035349; 
 Wed, 27 Nov 2024 10:27:15 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.72])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffad150436sm19114211fa.56.2024.11.27.10.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 10:27:14 -0800 (PST)
Message-ID: <c6f0b85c-a72c-4341-9df8-9d3046b135fd@linaro.org>
Date: Wed, 27 Nov 2024 12:27:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: optimize cpu_index code generation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
 <e5c7e738-3650-444a-bfa0-af6fff4e586f@linaro.org>
 <7355ede4-390b-4870-a59a-a611350e9e3f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7355ede4-390b-4870-a59a-a611350e9e3f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
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

On 11/27/24 11:57, Pierrick Bouvier wrote:
> I noticed that it was redundant (for user-mode at least), but it seemed too implicit to 
> rely on this.
> As well, I didn't observe such a flush in system-mode, does it work the same as user-mode 
> (regarding the CF_PARALLEL flag)?

Yes, we set CF_PARALLEL for system mode too.  We do it early, because we can tell the 1 vs 
many cpu count from the command-line.  Thus no flush required.


r~

