Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBD3CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t011z-0005nw-VU; Sun, 13 Oct 2024 12:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t011u-0005hv-4T
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:01:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t011r-0003Or-PW
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:01:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c767a9c50so27592125ad.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835270; x=1729440070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPUN7VMafGKxNSdMtRtYrAPC+IapObciko40x+nTUl0=;
 b=vLfOpKdTQb13aaFaEXylM2zMBKAqJqCdNiK9z494wBoGavTHUTqmUqJMuv1dVqM4Pz
 gY1juH99X8YuL0An2p15r/jkKvaYKsyzltazNixeiIH7DJVYtVl3T7IrGGEHKoo9mjcT
 Bm6I2+is1UpEPt9MNeo4d7lVWaUcjt+Y2xUR1Bgz0QhNRn9lQUfUga+kIpzxi2jxNU8B
 /OXEY1kM5pSvZurWeuh7FvhnE+woxrsJIE9YlG8IJFdIltwKg9gjYNbcVxPyY8m5GCMH
 IzEpdjQv+U65nC3nz5jA4/4Y7kR+iSkTvvLAJ/HfItTOkd3Vk0ps6bNCdN4AqF9Ktmoe
 WJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835270; x=1729440070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPUN7VMafGKxNSdMtRtYrAPC+IapObciko40x+nTUl0=;
 b=LXBpH1hb5DOPgwWM396vyM0WbARvCzfE7a6i4eu9IKYX99TKOpQa5MnakPZyC7mW/s
 r/QTDU3vC02YbnltWN0HDvHRnAeZMZ6TZQ5BorUutD0UhIi/lFyAGso3Vd+xeNrsh7UE
 iLL526VAm+wV+02R9bZsDJmYqO/9JvRbZtN+Tf5BShMxjyFbFGxwc5A/RUra92RiguPd
 C5dpMRB6x2WYbtX+RskVy8skHR/McW77x3PKM09EV3Bno0MVAVx8JL1w/fGYUbsdjkKw
 7+CIwltp9NN4pfKqGxBL+D/a+9ony6N0um6DHlHslUPAYXp0KTGIawAAM0DFf+eMB/F4
 UQOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmJbZ8jQMF4lZc6UCNtQuiLzcG7zFTt+Xdy48SOUb4Pnk2hejBovkQPUF5kAu6T3cHcFNvDOTB7lq@nongnu.org
X-Gm-Message-State: AOJu0YyO4Yc0qg5hGN4FmWoGQ5vRm0yaOwl18c3/RrMT7V0vtsq53RAP
 ODMYdSHT3TMD6rVtEFlukI9uC3EtJn1c5rqdgLscAzjkYg6hYMODtiRqlTXdJE8=
X-Google-Smtp-Source: AGHT+IE92+WH6XB240yH1DRigD+Obc7hgEFdYFInePf1+8Y23vJRNkEw7dDhsoONEleO0mbj/rVARQ==
X-Received: by 2002:a17:903:32ca:b0:205:4721:19c with SMTP id
 d9443c01a7336-20cbb240c51mr71239295ad.37.1728835270573; 
 Sun, 13 Oct 2024 09:01:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c31be11sm51434935ad.212.2024.10.13.09.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:01:09 -0700 (PDT)
Message-ID: <e4026760-fe74-42a0-97e8-7ff7647c0ff1@linaro.org>
Date: Sun, 13 Oct 2024 09:01:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] target/mips: Rename unused sysemu argument of
 OP_LD_ATOMIC()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> In commit 6d0cad12594 ("target/mips: Finish conversion to
> tcg_gen_qemu_{ld,st}_*") we renamed the argument of the user
> definition. Rename the system part for coherency. Since the
> argument is ignored, prefix with 'ignored_'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

