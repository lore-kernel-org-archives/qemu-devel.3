Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350ACC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9bW-00033W-7B; Thu, 06 Feb 2025 16:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9bT-00032Z-LI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:40:07 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9bR-0000V5-6X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:40:07 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so2220183a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738878002; x=1739482802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9FOVl0qr0vk2SnInYf1fGjI43YtY9Sb1L/XnT0IhLC8=;
 b=bE/FNfvBg8qvejs5qx0ErVPqbuFYAPj+87smqTyuo3Qfh9DdOJOm8TMzuxc6QXseCP
 6yLui80HSqOMdUiJUOWv+fYbAisw7+NKEkaHyIGHm9GBiiog7u87RXnjBnUumqKWByZY
 0qa04x74pITmk+agBdFCDstVdiw1vgLjmQLwRxIaz7fZ4zR2U+c/DO+03jBHAhMvHmfB
 HX9PxsAoeKd7LLcBIj2baD0XAybS6Tvn884gCBzrrAnKMJCRZm/FpxNh+xDaKNTuqVYX
 e5WNLMBvhsTzRzn+thnIjRktbgSov0/xQ8ie9adWZqA51cXyia6CbiiD+47bd0NfHJX9
 3ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878002; x=1739482802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9FOVl0qr0vk2SnInYf1fGjI43YtY9Sb1L/XnT0IhLC8=;
 b=ANEYykcfvQJEYmSUSX0zcIdz91ezBgf4KmHv7yIeSHTVv48NtZ6n+Sdhzz6113ztzI
 1PaWhYZLAum4mshObilw03ULLUAf1jjAicj3fuELg0x2Z2wmLPdPGLSx+YTdndCyUQpl
 JFFGkrmezSjA4qBAXr/Q1cfzQX8ImcYbExHno/tX3eip+ZdYhmB0PKIqBhfSI/qOoeJz
 1x6ooYNdiXmHwhmnH1XKZBW9YxSF6dJh/tJEcwOqMCYL2N2Hc6KZikc2wVUpNDfwKs4u
 d9B/PHQZTZ6xSi4ORnf0UqKAj0MaiqGOe+oo2lgBdUon1dh73KKD2BnZ01Mk5j71CKkT
 5yyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7BJPjsgp5eNEGWiR6VNX0ehs+boxqkRhpn1f+HNCsrna69CocbrtgSp4U6i22PVAcsLhHB/e5Rmf9@nongnu.org
X-Gm-Message-State: AOJu0YwJN9gf0y2Xbvnc3vDSPM7TOM+RK9UvBY5Oa3jNrJHqfrs1aytP
 /B/4S+wOUONHAv6gKfDKpRMG1UfuqXm3+1I5NeF56KA5pkRByadWMTmgQNnTzQ0=
X-Gm-Gg: ASbGnctl17DowcsK6LR7hQ52zD+HUzgJ7wxW8ZITdlw0t8HrszTW1/Vgc3HPzKBeASW
 GSZUQxDFIE+L1eC5crzwF3F32AiPDmObCDv0NBPOpgPS0t94MhlgB1vpitwa7HQIW97iXqAv3+m
 jgfit62sKaf7uIHpU2euYR2SvjvyymU4ZgrySJHwC7igwuNXzcs02MxMb+GEziq0srexXX+XQHW
 4DNWYautYGGRJajsPHltTFkvxOwhE71y/A0/3vZ0IiYtNI2qPcMmMx7c/gM9nFCwofiO3SDxDp7
 VN1RMVkhcYf8SzFsgOlP4nY9op7vEI03YdXWR7iGvugGSdaFPUfpcoU=
X-Google-Smtp-Source: AGHT+IGohE9+YKuG75v4um57BTuRCBy/bzOwqdmdFGlsrygdb0spsRa7+AlKVgvsWu4dtn1tvlDZKA==
X-Received: by 2002:a05:6a00:1d25:b0:727:64c8:2c44 with SMTP id
 d2e1a72fcca58-7305d4ec73emr1332991b3a.19.1738878002568; 
 Thu, 06 Feb 2025 13:40:02 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ad27afsm1753796b3a.43.2025.02.06.13.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 13:40:02 -0800 (PST)
Message-ID: <5671c7da-324a-472e-a8ca-b6a1a9ea769a@linaro.org>
Date: Thu, 6 Feb 2025 13:40:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] tests/functional: Remove sleep() kludges from
 microblaze tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206131052.30207-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/6/25 05:10, Philippe Mathieu-Daudé wrote:
> Commit f0ec14c78c4 ("tests/avocado: Fix console data loss") fixed
> QEMUMachine's problem with console, we don't need to use the sleep()
> kludges.
> 
> Suggested-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/functional/test_microblazeel_s3adsp1800.py | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

