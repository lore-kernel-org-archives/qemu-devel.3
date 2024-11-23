Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90146E6ADE2
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 05:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEivf-0008LK-PZ; Sat, 23 Nov 2024 00:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEivd-0008KZ-GY
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 00:43:33 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEivc-00040d-3P
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 00:43:33 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso2401645f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 21:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732340610; x=1732945410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5SLiEGNtParUpdQqTXob+tTfQ1hQU6vL+CHZB9nKXE=;
 b=NUmxjRr36tsjvMgR6HuvSTuh1fbbXj30i5yWHcv23fYZy1kiqwNYkrwd1rax6QLBwq
 ZlhnhKoBoxijiyRwiCzm/1yMtu6k90QKUL92PBg/D3m35kDLugw0uVExxl2/G9r8g3W3
 2mCImde9GkUcSOJ77SYZqgbytq1BTJwS3d6YVbLWEz9XhoCXq3Prmf1fNvLxrO7cyFSl
 PfcymkWW1wHpnFtGH8JpxQ1Ts77L4rY4AJoSYgm+v7how8vDpbaa/OLDHRpRO6jFTA85
 bYPJUCPANzpgxIdwpQRsySUaA4D+3T7HA8nLtunSXYWSJyuK2l0v/8QcBTI9EdYaPq8e
 ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732340610; x=1732945410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5SLiEGNtParUpdQqTXob+tTfQ1hQU6vL+CHZB9nKXE=;
 b=pzQsrjHLJrmXk/61ONzcVS2d4YrLzOdMTo7TrN1jr3NI3OKjb+QP68LJ3j1zAP5332
 iTSCTdSvyHm8dGkOKbpVGxrxsKwYP+0M78qEhP2wwv6qF0WyooHVru14DNsb2+i5Cg9x
 A5yrnmVIGSE3kAD7qGZ2ArEN+z98mUiQsmCemGo1Ju7keprfuWeveyg4hKt5nWpemdep
 ypWyr8Q9x3Binyxx/LaU9Yi7hewRfprlDKn4TXtli28ZMKecAdbB3Ve5LseqBxgeHFb7
 ilD/WhZVZHnCjRgZ6959Jc6/zSjDMAKnlgZaZQ708uNvuoEmnS0fxH4I5LC0dnycPzyz
 GO3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgSIOH2zG0FRiMD69CrfKbfCh4PyevR/Lxg88Jm2XXNMR7nvhgyK1W2qd8xWMr4D+4LFOUzJ03aZJM@nongnu.org
X-Gm-Message-State: AOJu0YzCqI+mC/M5shl3j+o2yRg7Q8oqcFJQHId6NfeEBhLWrgqlUma8
 mD5ggbtGLF3mqIPkRI/mjpTdNrk4iu2L/LEYiFby+A+Wd8jMjAHvx6nq26h1UI8=
X-Gm-Gg: ASbGncsCdUQ3MIgMsNffXLTpsvP7X11Neo913kNmaNspPyK/EqFz0mVKV5lxP3K14g+
 Tht7fTrWkzGgjkfY42UbEhetRvptzgarZUBuMlIdLlFatflQaDQmNMhnTk/PZucc0YznUC4L+R4
 kIGCTG9U07gymuFuo2PvY8SIyfRE95THCLcb92uClbN32dmBV6gbXHbjVHKiTpQVmFwjUdHiiEi
 zOow95kbNka9bfB3e/lizn81oOjXty+ebW71CnGre0hXn3mVOZ3qxm/RFt6Rw1b
X-Google-Smtp-Source: AGHT+IE8Wg57mjIzY0mhnkATiRJGWpn9diflj9MO7BV2LI99tFAQLzLi1Jjalvzf31SupX8Ga0LjDg==
X-Received: by 2002:a05:6000:18a2:b0:382:496e:8784 with SMTP id
 ffacd0b85a97d-38260b6eb06mr4893319f8f.26.1732340610512; 
 Fri, 22 Nov 2024 21:43:30 -0800 (PST)
Received: from [192.168.69.146] ([176.187.206.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe158sm4230401f8f.27.2024.11.22.21.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 21:43:29 -0800 (PST)
Message-ID: <2088d990-eeff-4305-9629-be87e60f1e9d@linaro.org>
Date: Sat, 23 Nov 2024 06:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] docs/system/arm/fby35: update link to product page
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241122225049.1617774-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/11/24 23:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/fby35.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



