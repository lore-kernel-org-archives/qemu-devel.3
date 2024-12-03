Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26497E6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPE8-0003aG-O2; Tue, 03 Dec 2024 04:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPE6-0003ZO-T3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:29:50 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIPE5-0003Vs-EC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:29:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385ed7f6605so1290006f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733218188; x=1733822988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUfwTfUP4L1om2jRfG39T/GQKt1AH0QtOiGjBnI0NhY=;
 b=uOhBHWXTcwxwparEKXtzzeYAWwT1DQslWzFG65Kbl7v0S+5nan5ozWjvhXFCLwlm85
 +Z22yKdZwz/y3eQ9X+wXkmHVksgjScthorPBTIv2Qd1qz9xdZnuaiPuA+aDR0U6O9VHu
 81iCcfM+UEfyNbmyMfMG+QFoD8tuPbYsgqfX5eBZGOjTJEWqUaoYYs67V0pPy+wAJzsn
 wevXmlr0s9SMgLi6yDmliHNjvsnV8+c03mUqrOJ1p8sQgx3SzvtDIw2JHLo4/+I4Qfwb
 Eu0DddSMRf0E89sZgSgDEdzjlh/EzaLp6Glu1Zx3VsStC6pVpFC2DanOn8RB3pbdch8q
 NAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733218188; x=1733822988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUfwTfUP4L1om2jRfG39T/GQKt1AH0QtOiGjBnI0NhY=;
 b=ozKD6H1tDCVbyhHtWclkWBkoP0Ux6k4jDgk+7JJyyHQoRyiH/VsrvPwFCIYc1vuKGM
 HjLJO6kkPvQIzubnUHBe8FQH58HC36Mn+l7Zg0HTDkMa0q0qRUUNqCDkqqyFkaxxB95g
 mtbUtViwj6pAnwHf44nWLkPGwkcSrOZUqVDlAX2peIw7lcJp46klkb+OltZ3Tuy5SdQc
 cHrQ43f2KXd2YhRjCLSodevDzunR7yUn14xItuY4IDLjvQ4VoozPAMvQNePcSkwjNliU
 s6b24O4IqrBvtocGAVRz+HY374s9t40Hvxf1AvmCbZVeSBRsbKrE7aaFlU+xGa5po+TW
 yNAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQM+ZX0SIepJM7ukir3zx5+P7MIWRxKE86zYT6jfkco4fPXNBaGrQ6G/Ee8HEvv/J2oBfYocNhcvKu@nongnu.org
X-Gm-Message-State: AOJu0YwLxYrsNa/3OxGwivEfbAAUkmwvvjUddRuWO9E4Db7qazF4X4kh
 87XqTw6q8DnAhuWMaHUs7Ap+12czFwERQnHZNlTI7ORsowcYOpf1xWskltFiQ5U=
X-Gm-Gg: ASbGncuRUJPbZHfHcjRD2OaiKnJb+SK+Fc4wFQw1BJtTvZI73jPTSZ3z5Vc0XwpDORF
 EgV0KEW99QMntdtnJ6Au9dW//9rbxxVTUSvawKTq36AEM8kyX3Je9B06UOIBp12r/+LK+bCdD1F
 +VtngPmerglj+RLldpbBn2uuXlOL8+2ded7xzGP1WwLlE5wB6QK3NEgmzuk1+kRF4xoa2RKyv5a
 84+DUojYO32ogJvgIHbuZvRjdVIEqMAkreoX0pE/XTVyVlQAep5JhfX/6W+op/aQw==
X-Google-Smtp-Source: AGHT+IF+FolsDy6TRl8IG70daL0klQCpBEhpqLwubvAx7xTlMAuxI7bl2UMrenlpAY0jVC7TFodlYA==
X-Received: by 2002:a5d:6c6d:0:b0:385:fac7:89ba with SMTP id
 ffacd0b85a97d-385fd43734amr1395324f8f.47.1733218187733; 
 Tue, 03 Dec 2024 01:29:47 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f8448d32sm3405121f8f.96.2024.12.03.01.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 01:29:47 -0800 (PST)
Message-ID: <86e4b6d7-aaa1-423d-958e-28cf37022b8a@linaro.org>
Date: Tue, 3 Dec 2024 10:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241203021500.3986213-1-jamin_lin@aspeedtech.com>
 <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/12/24 03:14, Jamin Lin via wrote:
> Currently, it set the hardcode value of capability registers to all ASPEED SOCs
> However, the value of capability registers should be different for all ASPEED
> SOCs. For example: the bit 28 of the Capability Register 1 should be 1 for
> 64-bits System Bus support for AST2700.
> 
> Introduce a new "capareg" class member whose data type is uint_64 to set the
> different Capability Registers to all ASPEED SOCs.
> 
> The value of Capability Register is "0x0000000001e80080" for AST2400 and
> AST2500. The value of Capability Register is "0x0000000701f80080" for AST2600.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast2400.c      |  3 +-
>   hw/arm/aspeed_ast2600.c      |  7 ++--
>   hw/sd/aspeed_sdhci.c         | 72 +++++++++++++++++++++++++++++++-----
>   include/hw/sd/aspeed_sdhci.h | 12 +++++-
>   4 files changed, 78 insertions(+), 16 deletions(-)


> -DEFINE_TYPES(aspeed_sdhci_types)

> +type_init(aspeed_sdhci_register_types);

Please do not re-introduce type_init() calls. We want
to replace them by DEFINE_TYPES().

