Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2960C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubg2b-0001BZ-34; Tue, 15 Jul 2025 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfZy-0000Al-2j
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:20:25 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfZt-0008EQ-0N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:20:14 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73a4c557d47so2544764a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752585611; x=1753190411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1QsSvqOjwJsdilLVGl31JHgTIQ+7+hMAReSPvPs8hQQ=;
 b=pZbt9rrbu+LudXOazXh9L/SZBdmEUHbrRjhX7M5BexRA7rkw5PdBs9jjKkkU/Cq/CS
 nc54lXzF9lJ2R1knN5v7dIKImlMtd6Th5dafzM6k/H3YhPsObZG0wqw+FAfH28aA09nu
 LYEtDBM0hk2VZPUUurPWO/7MP/y9bZ2qMlLDb7d/jMDRN8fPFwhUFzFM+AeKw5vWVqUp
 vDIkP1A26n59I6EiJRzjBpm6UmnjTSV69G4NgY9uG9Bh5IROzvCjMedPGk/VmebY33di
 yhX3mW81nZPDM3b6tCwawUY3ZKCI53C4WghYfjw1JWcaKa68sc3WphunAUByI40RtEIr
 kOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752585611; x=1753190411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1QsSvqOjwJsdilLVGl31JHgTIQ+7+hMAReSPvPs8hQQ=;
 b=q/+A/a2yHvzH6yNwr87cTOtNu6SUFpKVgyAGk0tLeDR8DtfdLISqIvPBxP/yv8Q6PM
 QQaj1EAbQfuSG9PA47mFESED3Pjrlf/NFwj74qD0ev6EkNAWsTfrRgj4nEzmuVXLiku2
 ZAILZSJJgHxs5Dspjp9We1gOUYJL5oE8lcc1x4WnYWObrLk+ZxgfSYQbEG+vcyUO6XHI
 Kns51B2H2ddlLDb7cBQrtxdQFRrGUMiswrW7Zye4d4JEiiTddVvnuCrdvxskx7Fwd/Ez
 Jd8IX5rA/9fg6mjlZrQecVVM/stP+Y+1c8ttnsx896f0GtSlAggnv7IEz1KCwnOZHibS
 PzkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzYOD3fLvX0bkJvCa7qL6dr20KSltByE4KjjSzhHKAGWHdzUuPXT6tvXFHl0Pr23G3y38YFG386O3b@nongnu.org
X-Gm-Message-State: AOJu0Ywgg2GaN6JlLg2a8jUZSEy653v5AhH+I9xAc9y3DqV44nuNPEtl
 LWo543Otvt5CKvgUz14SxhZD7O0E/rQyr2DVGBgo8FT2apjmMOz2Vr8EfKHsL9q08EE=
X-Gm-Gg: ASbGncuz61kdryTQZLyl7NgKGEhf2iarTNnJI9iEo1rQ4lU4E3mDCvlOosQGL02URKe
 oocSFeCki0o2AuoNGkaPUr+z4hSDbI6P5ecyyHcSJjCSV7MnWQLr0ThKsQwWP71xGOMrmI49rxW
 leDl7/L9ImxbGhsQjMnkh/dBpZgorfOH1RBcCRNkV8ifi0XY6oHS0TcsLAVncxPIQzOvkGan6yg
 6wNASc/U7Igm1rRQOEVh47YouZzqY+G53IFXxxljHQMOymeYNBfUJw67TdCT+PXODlsQx5Pn+Ws
 Ut7TtxgGHF9AixV6jkIRdjIsHxnV4t1Znos7scQYWIL8LumsBSCpEZQIMK5gpXFc9QU5ZPeYCCg
 maL/dOPqNm5yAUyAlDMdJUHwcme6jsIRBk210eGVUXQ2JiCp/OlARMsmFrW+yO5o80fZO/CCfaa
 SJ
X-Google-Smtp-Source: AGHT+IEZ6BPFTT+gqD70xeuPON77FDF9crQZmZzL2bxJPcvajgdBkycLcAwAZkOxe+nOXMQ/y8DjWw==
X-Received: by 2002:a05:6830:2b12:b0:73c:ee05:a51d with SMTP id
 46e09a7af769-73cf9e90a17mr11845888a34.11.1752585611125; 
 Tue, 15 Jul 2025 06:20:11 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e56024edasm580101a34.34.2025.07.15.06.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 06:20:10 -0700 (PDT)
Message-ID: <372f1f1b-4233-49b3-b2fe-a97bcf8371ab@linaro.org>
Date: Tue, 15 Jul 2025 07:20:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 5/7] accel/tcg: Propagate AccelState to
 tcg_dump_stats()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715104015.72663-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
> Next commit will register tcg_dump_stats() asAccelClass::get_stats
> handler. Since we want this handler to be called with the correct
> accelerator state, propagate it along.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 +-
>   accel/tcg/monitor.c         | 3 ++-
>   accel/tcg/tcg-stats.c       | 7 +++----
>   3 files changed, 6 insertions(+), 6 deletions(-)

I suppose you could at the same time rename to tcg_get_stats to match the accel hook.  But 
either way,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

