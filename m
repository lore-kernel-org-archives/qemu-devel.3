Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA3DC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8QY-0007o2-9f; Sat, 21 Jun 2025 20:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8QW-0007nj-Fi
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:19:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8QU-0001qY-RY
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:19:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-313910f392dso2135392a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750551553; x=1751156353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rqZoUr0AfZ0uIJi1UmtaQj4tBXkV1ojDJ0gfb7ipJWo=;
 b=TdXLKBN1/qLk2u3j5Y6VScFXHBSPRkIkWWcRsCVLey0/th+rIjKcEUTsi5xt7BQSSy
 SlvoJ0ftXmDnFAj1pBowoBxH+/vukdudGeI8OcnMmX4ecpAesGHNxzFXiGz15zdCrEcz
 6zgfde9XYKyzK4sL5RtTEc7mCC69OBhkmtz69XaDzmpA0Lra0NRoOX0XeHXirQBHmkt8
 6y+kFDVWOA2kCO/cFTQF/TtYDb8+C57pkwN5YbZf+94UrgXB/Zp2oBFXgaHgmR0SLxug
 6XePDbbInZ29ViSxliml8OBzSEmDA49QbhmROMKPJ78PHa7yP4eF4hn9SSp3pM8VVW7w
 5qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750551553; x=1751156353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rqZoUr0AfZ0uIJi1UmtaQj4tBXkV1ojDJ0gfb7ipJWo=;
 b=j+VgOldZn/6ea9TcWGemfqBQKQVaxKWF5/rXQRybZNn97qpyHE9zRx7Y/pIx2/YKPZ
 d0yjq5bW4f4gyiFY+BAgnbJpNiUJntSyzq3kUqsyt6OQQgzzBvokaYwJDm6EHZzef+L1
 E9T4oBp2MpMWOkIKMXsViB3WUW7Cyemnq35ztZdfWevfzh1F50YbNncl1zKEaN2StZyo
 dAak28ddZ+8min3GxjLUdajxH/QBk39kJtmV3TeXIwxg9t7bKPvAHubX9TnWfTN9jLqZ
 TVnsFb0r7OYRekA/7jFbhhBiIv2oxvN6YfFyHedGJnDk+0OeDSwgcc9ROl+EPUHpJpp4
 27Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlch9tyxoS2GiD09Sevfpg60HEayXWPJj4Lc9Y3WIa4djYJqanYwCe0XYSbHn+E5oF34c6EueIGuN2@nongnu.org
X-Gm-Message-State: AOJu0YxSpp3oRE3xD31qaV3hTtZ5SVV2ndNOesbgf9XLqkbsSZIoS6bY
 yvia3D57m/wtAJN//O8yrCv4dOV0etjEsM+doSopXxQXfGX/ETc556NyukxUoBmlBMl1fu63rNz
 kSLQoEPQ=
X-Gm-Gg: ASbGncvLqOmri9coFVD+wV+gIZLsd6bpG0dRFK+E0bvk97vVJeZKOx7JBHKNHJpwiWH
 1UUFbcmFaZhRENluEjYBcTy+JxlS2i3NtwmSOFr8RjBlCKaC851+oZ4WtRCVJlA5Bhm83+s9f2M
 ST74gJENC7ORLkcB+64xVYtl0dpfT9MLuxfP/kBL1+2zRaK7KZ2mgqkC7guu7GB142J0409V1sq
 9Yo9ZC8IsTggYZjEh56hFQbwEmKs2/MTQardHPyKKaJDyPVZ135+cHe9z55eZ9s//aSLZsSU90/
 GJ0UQGV450vSxNU8rLtPpkVftX6umWvBh1qQw79u88k9N5qkanLILibvw24fPuPH5mSal2xNHwu
 dJPCXWA7o4atTA1PW+Cr5RKcjiXUf
X-Google-Smtp-Source: AGHT+IFubbnbSddrjtpcthq/fVwQ0PPyUDG7xAMz9JkmhLOILEwC3sS3ckK3kENBz8c5TdsSusrcUw==
X-Received: by 2002:a17:90b:3d4d:b0:311:d670:a10d with SMTP id
 98e67ed59e1d1-3159d8d96f1mr9903243a91.26.1750551553164; 
 Sat, 21 Jun 2025 17:19:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83959f9sm49598955ad.50.2025.06.21.17.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:19:12 -0700 (PDT)
Message-ID: <30eed42b-9591-4bf9-85b5-d53175adbfa0@linaro.org>
Date: Sat, 21 Jun 2025 17:19:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/26] target/arm/hvf: Pass @target_el argument to
 hvf_raise_exception()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 6/20/25 06:06, Philippe Mathieu-Daudé wrote:
> In preparation of raising exceptions at EL2, add the 'target_el'
> argument to hvf_raise_exception().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

