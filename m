Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEn8Z-0006oH-TJ; Tue, 13 May 2025 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn8X-0006nx-RF
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:45:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEn8W-00031o-A7
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:45:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0b308856fso4011378f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747133123; x=1747737923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PQV+7dB2bIIgAZan0TAPV10yQXx671Pd1FMs0t1F1F8=;
 b=rb/iMEMjQSMkAp1C5peoKszTrF76ymkPksK54yj3j9Y2SHSifMqh/sX98ZcG7ZBRjJ
 FTsJ3ggkgFCkm2391J0mL4XYxkGA+RRkAwxJPa9+M5krZ+UM4agHb3VClo3hhyEdiFoi
 lyLm3/oBjuS0RXRLU6rZpcqedT2gS/1kVcREiy33x1eHJ/NlacMO1AMUd3BlgssRl6At
 DyrzdFOXm73WPwYNP5xlwGJg52Mx0xrlbh8XlGBXng6ItPm0EhxCMGOoG1tkOcJLl+3h
 CZFMCZZCkPM0K2NDoBKBGkFSbHyRXTJWsa8u1CSJ+W1QBohvMSgH0oCVrv7dPmMtuHgK
 3QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747133123; x=1747737923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PQV+7dB2bIIgAZan0TAPV10yQXx671Pd1FMs0t1F1F8=;
 b=hHktni+7GVHwVqHAFHU8x9HTjZwWPG7WhX3VyEUhEbjMcUKF539Pu9T9vStcZqjy4J
 KMH29AGGraYqHJuZe2CttThilRopJnMmyhN7raSjXEhizZjpg6aDtXsvVUiYd+AZzrz6
 DObgv4v6lZdjBW+2kJ4IzcA05H9QJ2Qe2vlDs3blcu3gftKx6swKu247v3plv8drg50w
 TxPcSiziDzaz73kHGHGiig75vU8AN7z/e7VCaXTE/EX0HNNEDbP8gxyTjLqmdoyMVmz/
 99oawoZVQQvVRC2pLIxpDonc7fpV3QPU75STDjdpUgT6u+SasFYCLcQgJkOR8nkjJGWd
 ESSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+tn69BNc6JSHr85RCf+j+tHmekFao6+m6WqSqdHAslCdg85QTDtBs2TCg62w9OU8YL79IP2Eb8hnF@nongnu.org
X-Gm-Message-State: AOJu0Yy13FVr17enZL3+5rge/ApvdpgM0ZbhOdMoGRam5S8/Ua6LPzOm
 wqTyc0ZEejrEU3ZSM1QLtseV3aWiBBOcDdaGIxsvLZcHsLNA5E9IAMH55BXmiZ0=
X-Gm-Gg: ASbGncs2ZZyD6XHRVjfM4fCu00UWRAlBwe4lqDsN0eVMNjOupvkaAf466+JJwmj4mZe
 2bCBqNacNlUKQDO7uOPYtJew7/33L5yRUjS7wV8sIkluZg+zLvYPIKLviiE8aW3xcR2HHjoBP7U
 SzrI1o0VB/lGCBCDqMUTiQbGTBnnULH5GzswAXpDE+TiDs9MpAcKOScrKVLl7EQvBeG3n4E+Jlj
 Km3SVFaySADYcbc2Z93e+svgt9mz1zoTEzo28claFmk/KJxeA4+xxm/sTjrOkR4nqxhhnNL/dfT
 t6DvSmwzsR0UMukvU5IYnvfr3T6SqWOyhT/T6mwdtu9oIPMvW+jdX3YtTcH8r5smKiLumZt8F3J
 QbxE+y5KL+5nE/XJ5cg==
X-Google-Smtp-Source: AGHT+IFw3reMRUBDNST3NUnjyeu+5GloTdANb9TuZA9BtpnHKd4htSDtQ4ZnlvnFdVWLpaXAtu6R8Q==
X-Received: by 2002:a05:6000:420f:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a1f64ae792mr12932586f8f.50.1747133122641; 
 Tue, 13 May 2025 03:45:22 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ca31sm15852338f8f.65.2025.05.13.03.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:45:22 -0700 (PDT)
Message-ID: <7c4e1607-98d6-4040-ab78-317fb6a58e68@linaro.org>
Date: Tue, 13 May 2025 11:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 36/48] target/arm/machine: move cpu_post_load kvm bits
 to kvm_arm_cpu_post_load function
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-37-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-37-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h |  4 +++-
>   target/arm/kvm.c     | 13 ++++++++++++-
>   target/arm/machine.c |  8 +-------
>   3 files changed, 16 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


