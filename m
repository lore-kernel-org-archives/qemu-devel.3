Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E01D2B92B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jsr-0004VW-3q; Tue, 05 Nov 2024 08:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jsp-0004VG-G4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:46:11 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jsn-0000pT-R2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:46:11 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9eb3794a04so120216566b.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730814368; x=1731419168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C01sQZepssAiHMS9P3hgHMNUhV2RhwiyEJQq/ppB3JA=;
 b=DQqw99VTmWG1VHZ6Sha6OhOmF+S/KXufqRKYG85bM8Mxh+FGIIS+qOanAXaF/W07VT
 72MEkv/g7kuyBHFIKMCg6V5x6TNoCnbCsWSrq3tp7lF+wirqcWxphqX4fqMVxrtlmqjG
 AoxIBUbXen0QN0Zvdd6D/h1dMiFTV3CkQzVevjeWxrAicH0W/xO976a1JAuilT54lSZI
 PaUygdEzNVVwJ3pGtwt3soqt6RVlE7lkJJnS/gc5+0H9REjV94/DWgSUbcBOTmTWV9pS
 8IdMvPlgdMk7+T0Ki1eyOEF9/QXgY35cpHkNfiVLX1AbJeVKoRoExaSe53cLkLghJo5s
 agcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730814368; x=1731419168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C01sQZepssAiHMS9P3hgHMNUhV2RhwiyEJQq/ppB3JA=;
 b=Hpzjb+/ugSBWW3NFEvjA63tHVJwmgncXvza6uYNI+3OzOxhn9bD+J4uWUifffOtCVf
 iejnpJtjocqJE3HdppCFw+pSLU9YPc43Kx2Fe7HqS0UlBy0GjUgESrSrcMDE7P1bZ3Rz
 zb99ZHxD89INn0wsx7k3UhT3bi0YEPTjpWSoBKjympUHeqNMMxKv2Olcm3Ko3eVwuWyu
 m4pgZzPJcXwdOw6oSWbtT9I8jIJgx+eK7rxvROH9V7fvRtpULSGffaZkLT+fkoQG0QWD
 3TJX44UpKxNV0iC31ThgtMQEY/NqUsDR74kiSyigC+borCsrEkDVvDq7CH5sR0irSzeX
 rUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjMbHJP+ramebDiIC/iuBRHSwT+TDRWShKG7bGXlQrWkeEFmETZyqyPtHXOj5Aftgrx5OWR2t54iS/@nongnu.org
X-Gm-Message-State: AOJu0YwUxRT1hM/wiYV64anaZdWq2QWwHy3OgNEMnLzCKuGG1ZH8gqap
 fZwV6HPcrwf7KEx705vTAe5hEz+soEqiBvNebc/tJ5lpr6Kowe50KTamiSv01vc=
X-Google-Smtp-Source: AGHT+IHzfkUB10svZFQ0cFyk66TqDQUxG//nT+4pxeYnl+GZgrX1CSMNOWWzqBpvB2y4iiOE6Gw4+Q==
X-Received: by 2002:a17:907:72d5:b0:a9a:3d7f:a8de with SMTP id
 a640c23a62f3a-a9e3a61c5eamr2355344766b.27.1730814368158; 
 Tue, 05 Nov 2024 05:46:08 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17cf8eesm134490766b.92.2024.11.05.05.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:46:07 -0800 (PST)
Message-ID: <28cdd5d2-4152-40a7-86e7-d6abae333209@linaro.org>
Date: Tue, 5 Nov 2024 13:46:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] tests/functional: Add microblaze cross-endianness
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> Copy/paste the current tests, but call the opposite endianness
> machines, testing:
> - petalogix-s3adsp1800-le machine (little-endian CPU) on the
>    qemu-system-microblaze binary (big-endian)
> - petalogix-s3adsp1800-be machine (big-endian CPU) on the
>    qemu-system-microblazeel binary (little-endian).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Clever refactor left for later
> ---
>   .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
>   .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
>   2 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

