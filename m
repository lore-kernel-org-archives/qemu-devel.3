Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5E6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTpr1-00017B-3L; Tue, 16 Jul 2024 17:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpqy-00013h-JX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:36:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpqv-0001cQ-JE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:36:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-36786081ac8so3481373f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721165812; x=1721770612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E36nb9RNRMHcoXFUXkldOoxfuaNCYT2EAIpqgRSkM/8=;
 b=KzqjWSYttZia63JERIiXi5MYqSotjiQnnpNKaNK/xoztal2iijlnh5wViuUC9hfRUr
 KKW8YlO1cfx4XyVkVdnTHE4toVEmAXYbNrH2vKDtX+Q0DIUxVpsqZddVripWVpbTvifZ
 P1lJcoIGfjyZ3jVf4wJ585cOIgjqadHlvzEoRM4TvD9qZRw/l2mjnnPifsCn5nqXjLAy
 vZQhMBCIcuwXzIkw0x3EvrqiX+NArtkc+D0zkXzEtjlIxCvF1g6VEGUkZlrhll8/Zgyf
 V6Y+2/UoSVc11DROgR5BK+4tkBLzDn67+epXA4IAOyVmu9KLSpp6aG5Q/2i56DQdu1AA
 G4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721165812; x=1721770612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E36nb9RNRMHcoXFUXkldOoxfuaNCYT2EAIpqgRSkM/8=;
 b=DaICLw6upjMco0SbJq/iqAFG91NLDHUdvpDpYd0z4DSn9DOVdNF+NBt3br72EQznoe
 ACqS0QAysFeB3G9Y7czEZHQaJPUNvDYa51nNsVFG6Yi/zO41nAfYf2NlLFdEpaR208PM
 ikreYHSlOZku65KbcNVZBjRBDmFUA4nBly/sHRestXsrXUy6TXDIZ8Niq1ZmnDfO0o9V
 5oCEspEozjgq2B5AsOoRthClqo4ZBPWTQ0u5l7jsjk88nZ7AbWhaYR+PDWy03hhxcjln
 azN7bQiXvo/HY9ABwyO1jq/axacQkYH3hWru6jWq4nVjSn3aZFAgLevqGNTipVc0W7Ae
 j5Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfsqdZKI3KxTC2r3nM3YAePmTwY7a67M/UeYsaclmilwHp+9J78mZLnGLdHZh7bWxUI9rWBwdqjTRv9kkSF/jXEqxjHJQ=
X-Gm-Message-State: AOJu0YwUI5pf69XrWrGq/g3EVzrzLctSthoax1+YuE2UaYLXFYSinFsA
 UWFX8fwYAVMWMXHgONe8M1RVhqg4QYQUE3zNVfDkHyn5htXWPjsGredS58rvj+Q=
X-Google-Smtp-Source: AGHT+IFVvduDN2JrTOGYpmF/QspfNNjxfzJzeBgfrElKO+a4aaEuoQHaz4QyQVEHprWV1U/WkTcZPQ==
X-Received: by 2002:adf:f48c:0:b0:367:993e:874f with SMTP id
 ffacd0b85a97d-3682614f664mr2499678f8f.34.1721165811722; 
 Tue, 16 Jul 2024 14:36:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36816758620sm7559768f8f.19.2024.07.16.14.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 14:36:51 -0700 (PDT)
Message-ID: <6c2b5a88-aece-44b0-bc10-e0744ebc38b0@linaro.org>
Date: Tue, 16 Jul 2024 23:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] aspeed: Change type of eMMC device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240704053651.1100732-1-clg@redhat.com>
 <20240704053651.1100732-2-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240704053651.1100732-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 4/7/24 07:36, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> The QEMU device representing the eMMC device of machine is currently
> created with type SD_CARD. Change the type to EMMC now that it is
> available.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


