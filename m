Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D031ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmUM-00020M-OV; Mon, 09 Sep 2024 18:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmUK-0001rF-BT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:04:00 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmUI-0007TX-PT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:04:00 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so176626266b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919437; x=1726524237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fpD3r1yyFRrexFfOqBa71bOKPJulwhNvAyWmiR0uBNA=;
 b=ZbXpLeBPwwsLz3gvyQ86KkZweLJqyRRqlxKr9BCGrqn86/y6ysWBcweY6TlDNc2Ta7
 ChVR/WUZGmwW0o6uP11bHxM7EwtadEKPOSS4A6BqsimwG6xE61bYEkxjqrj1RjMwThcg
 VFirDTpb9J4IgiYeVmbHyKfTx+oZHZDKFQo2slKooxzgN4dfODCSyRZVSQLaLoMQufLh
 S7EuLByQsBBm9mIuFTEbjWt4tbQRg97Qru5VGSv/yy0i+8IK9cN6+7ub6qE/wVn7dHXx
 npLbyg3dYPpRfsEn6o8KKyHgZ7rW/B3jEcX1YizrcpUaLC7Lzb9RC9tSvScWpQgZRlpa
 CXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919437; x=1726524237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fpD3r1yyFRrexFfOqBa71bOKPJulwhNvAyWmiR0uBNA=;
 b=uQUK2SXfzKCkLjqf5fRFHcI+aUvjD9jyBHT3cGVzP9iO/v8CTxQffG9OUWNKFcURi+
 E3QGDA2hHLuvElDdgBXufj88rGJQIJpCQTgvVUp2LnuKLE+XzTD2+VYHm1VajR4VMbM1
 jAtf40jI1k2D2IGcqUFg1CyRV1DVOZmW9DSm2DZ+OhbkOnEaec0tfpOofrcYqcpV0OQ6
 o3zeYqg4q1Hb+aN+zYG6U6jMOAJwe7OKZmbKHMgIMvTMufa3xin8XmTPrV5nftGFb46T
 MYM5Ks9fhyOALwIdOq+/xqSDUUwbwsbevjEqGEN7t7hocDI/x0S0W7EK+puwGzZMjKe5
 DOpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8xoAnmB4V+5asOHVt178OXv85QodEtj/9Rf3iSRKl2nPYM3dvFKnxuci48gFKIl086McXRJ7GLfca@nongnu.org
X-Gm-Message-State: AOJu0YwXXPL4CjbOaZhV/DtVItcLSaBDK+LqXebtMdc3W/peWOPmY2rr
 GZCYY8kghRigfQF86ojADAej6JyRrykpJQOVgXxc1uQUW+agcVncpM41GLOkuJ0=
X-Google-Smtp-Source: AGHT+IHahkH8/FuFNXwVIdGQV3ZRXjjO/9q/L5EnK3ZzL7wbmfHRhiruwL0pUsdBwzAImsy9/LqS9g==
X-Received: by 2002:a17:907:2d07:b0:a8d:5351:bb22 with SMTP id
 a640c23a62f3a-a8d5351bc81mr558502966b.65.1725919436873; 
 Mon, 09 Sep 2024 15:03:56 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25950cdcsm394674366b.58.2024.09.09.15.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:03:56 -0700 (PDT)
Message-ID: <4ea0a5ee-7536-439a-8baf-a926f9359b28@linaro.org>
Date: Tue, 10 Sep 2024 00:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/26] target/m68k: Use g_assert_not_reached in
 gen_lea_mode and gen_ea_mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> The mode argument is extracted from 3 bits, and all cases are covered.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


