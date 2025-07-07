Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D3BC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 10:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYj90-0000DF-11; Mon, 07 Jul 2025 06:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYj8U-0008Up-QQ
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:31:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYj8R-0008T3-DH
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:31:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso27856935e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751884296; x=1752489096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=twOIKV08dbtXUsoBbkZ3Rmr5edUTh0VEW2JZsvcToyY=;
 b=rgp3M5EQcZhwWe/t5LQ9jQ6lDkzp+zUB29ODRoq13S5+QVow22OMfh9xDKqm7Bh24j
 uWcvWSJQcxvnPEDh/nTgh5Z27hDyTsoIjBEpRZcBKKJbUbDKMwQ8cX3W2SZGCFLn8syj
 6zlqrX7ScGdq5COnbFAbzuKqvsekru9N6Cqc8f3S0eVsKRfWfC2D2ZvssfeJcwyL2bO+
 WvoiYzvmRoajfTD4gnfc5lxZplccovBasAGN4PAgt1Lhls3sbunOaW4MpK7Z5UCveUwj
 bVUMBkaj3wkqL1pQL6oV8oV8wNdwaQHtwCcU6d2nVAXy//UlZNvOzpy4QgeswDaSk94f
 JyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751884296; x=1752489096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twOIKV08dbtXUsoBbkZ3Rmr5edUTh0VEW2JZsvcToyY=;
 b=tQIZMR5778BEtOGP4qeqApJpeKErQzZpKYC7QVtuP3n3zgKEpA/pYgYXvJtMwkLMD4
 smVoePkjm7u2o4TrSLGsZu0q2FyjOuZXxdshwspMQXdkZzxk7z8KH7soQpyH19XJMGk/
 B40ZDg1oXxZcv5Ol1xSMEh/KknGvP3UHoI8UWWnW/B1XPFsfeyU7aqjAcTZZQq2Urh7r
 NyNV/amYECmA7nzd8TiPPWqMgknTTIbzC800/I8eLrnjPvIbQoD/vq7yCotzAbRkwTJe
 Mck8bczcZS1hh8NZdslcI9R6D6yKArt+PKeCzYiKKi4AUFhD0bIHCYvBjc4ZmrHMPRpt
 d7Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVupl/cGCBw7DPrexzUhqNyCo3vSnaUT0yhqKwyVZvUT860nO/OSn/HSLg9YYvBlsjBMF9uiEab1Kkr@nongnu.org
X-Gm-Message-State: AOJu0Yy7EmC9SE/R7mHczaGL/3dGQ5Nqwj4PRyrT4RCUYkO98ilyUiRe
 MxGpnmTvie6AIuZV4ybIdbBVzryCMjl//obxGc2jYhkoAmO12OTMBg/i7QXg6uFmJ2c=
X-Gm-Gg: ASbGncv7q5CSkWTcHsY3Ngv3Jp8l4QnPycPAxpTGf80mI88OpUUhsIb3yUwMgyYVPj1
 ih1uPkGcuNxUHqUHqLy4adLlHaHYxkenEwK337NW6XIWQjYbnkOwNInVVmkzrpTUAVGuD7qc4kE
 YL9oZtY6zIvomDVDGROnflq7vgEcUKagmu33d3iAA16thOT4P2UyAp3/KKmVldSzDzn3DWePQsC
 woJ6l1F1/ZPmmM9M8hFhARPTMCiIwUfrsOCKZI4tZciX4A3ZQYZfnjYmW0Nacf5XIW/CJ7T/WcC
 QP/mVt7o8DgI+i7iAHTeNfAOAeor/rMa3TAmEDaliV6L76TPY9vfogLzHaAnAMPikutVP4hJyDE
 RNjHKNfBH5HeNj+N27QhVMb4fKKS9Vg==
X-Google-Smtp-Source: AGHT+IHlyBdFUx7E3IrrgEFKiMnXS26n9OToe75P140Q3myzWzB6a5GZO8M+spgywoX1JHCLhfERLA==
X-Received: by 2002:a05:600c:1c9f:b0:453:69dc:2621 with SMTP id
 5b1f17b1804b1-454bc71c93emr71091465e9.12.1751884296525; 
 Mon, 07 Jul 2025 03:31:36 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a2e8sm9749073f8f.75.2025.07.07.03.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 03:31:35 -0700 (PDT)
Message-ID: <e31d1371-ef77-46b8-a431-f4e842782edc@linaro.org>
Date: Mon, 7 Jul 2025 12:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: "qemu -tpmdev help" should return success
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, yanqzhan@redhat.com, peter.maydell@linaro.org
References: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/7/25 12:14, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Like other "-foo help" CLI, the qemu process should return 0 for
> "-tpmdev help".
> 
> While touching this, switch to is_help_option() utility function as
> suggested by Peter Maydell.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/tpm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


