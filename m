Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE1FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BEb-000825-Pc; Wed, 15 May 2024 05:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BEX-0007dL-HM
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:47:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7BEV-0003UA-BV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:47:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34e28e32ea4so4262335f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766453; x=1716371253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2fkCCi5OTlHU++n9KvsFlA4A48en9qPiK/ktEXSDJM=;
 b=vF5PHafiw8coJ2PDsWoR/q1lSmbMX42xnqhYPe549RHlcI2Lo9a2yKCa37k7MQVvps
 ZM4hvO3Cb2FzNC4UJLZmfehWUFlPZ3VcWuj2z+g5kFcnJIjTDTxGSupHNo9aRtQD6zzk
 /HB3Q0SxHw+/nartyjekBpaPccqhY3Xkf5jWUvXLmvxBS46eNjMjmhhMwEwJqReOL3AP
 +jzBW60/12dN+No20Rn+7Ge1pq1VXWWavs6xO8Jsta1OFzq71wrqISvGHSJ3aeKxcLzc
 p5MwI1TC2XhiJ26ogT1nGqUeszuPm2StPfHktYR2JFtHmQa1bMB2ILQswG0hFeoMq2T1
 0ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766453; x=1716371253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2fkCCi5OTlHU++n9KvsFlA4A48en9qPiK/ktEXSDJM=;
 b=Sxbr7ZA7UEivyn4/NBpMtafI2CZG8KU8B1snvmjJo0Z6qQd0vRK85v+I3GmdCCfg3h
 XqEs/6p6JYekhU10cZBunCvXmCB8827+hDFl0qEryWiw3I1DBobwdNix76OysaMhXXx2
 SJXZ2lERRITkmy1sPHm8ecPq5ryTYuEg2NC2qXewCDHt35F+JlywVpuH5Mc72PN7Lr6g
 woI+NIQb81xrNPlSbqDiAb8niKztV/OIv5bcSfLE6sG37farjr7kP6fbdLTA7TLY/kMp
 mVbUNJkEUO5zHseTRFKBTUT6w+jJyA6Gj7miSeL93xJpepm5XGxZ6jn72OgHj3td6Vy8
 LVfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtChopdX2+J1ZzMRYHOpc01u/JBAhLHngJ8fI6Y5H4Po1wELloHZi6SoIcYwoXcVhFsbf80ECbt7eKyjPESit+PqSor+k=
X-Gm-Message-State: AOJu0YxWzb6XkHQ9bQJPVH1Gi8USXcDDJP0pQ2MRtyL5xpRMpoILZ8eH
 YG7zYdZCXPi7Ywsx3o/z8xRbiHBY5u/NRr+hr5NwToQQgCU9EQF0RJUdCgIxlj4=
X-Google-Smtp-Source: AGHT+IE0kuQH5bzp0YecBgnoC7uo/jlGSzN+A29sDXKOoDbwHZ2jvcOWwn6QGw/Lx9y1EGdLmube6Q==
X-Received: by 2002:a05:6000:12d0:b0:34d:bbaf:27cf with SMTP id
 ffacd0b85a97d-3504a96a4b7mr10708705f8f.51.1715766453549; 
 Wed, 15 May 2024 02:47:33 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a8454sm15963982f8f.56.2024.05.15.02.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:47:33 -0700 (PDT)
Message-ID: <28c98f1c-835c-4767-aa8f-44161f5ca744@linaro.org>
Date: Wed, 15 May 2024 11:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] plugins: extract cpu_index generate
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
 <20240514174253.694591-11-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240514174253.694591-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 14/5/24 19:42, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Factorizes function to access current cpu index for a given vcpu.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <20240502211522.346467-9-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


