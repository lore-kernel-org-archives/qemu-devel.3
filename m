Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E2BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeSC-0007zc-It; Mon, 11 Mar 2024 08:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeS9-0007zI-MK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:08:26 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeS7-00066M-D4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:08:24 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5131c48055cso4351129e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710158901; x=1710763701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwEAI0o3BpNcEgF5D+kX153KwlRCErXDO5hpEVso+tA=;
 b=mmw00F4bEI6T1nlfD/mpdGyvV+Xap37gHFeEBSrSmum/6fQEBTzIIAcTcQXkrmuygy
 W1/HyEegVQZizxp5ct9+JpBlBYhVM6VDaSMlqZixyZpu0nClNzY5jnIK7hNAUOsShnBF
 ZmiIqTYVERXAkBwochfU6ckTYAWiOsL+Iy3MJaRrK7F4xcQbhAQ9BShsiMBPOiPfES5L
 ZzQlGJ7FMwUfw0bhMW5XyokeNS0Df8add1k+h8HHvFxVKdND7dQy+bFgbw341I2pelK+
 cOPECd+t5yCbzyJyherw5+MT1Jzaup04SpmXrkVYWZVt/Ql+A9SIC/0XDvb82p+CMaM3
 9TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158901; x=1710763701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwEAI0o3BpNcEgF5D+kX153KwlRCErXDO5hpEVso+tA=;
 b=raxygkVDwtydjvV8t0wTAdVxOFFjBxgT9eFN1we+qKUawaD4aYxXn1d1I0kPNlfKY/
 /eJDOMRjCiDKw76I3aDMa1D3dtBF8xRDB4Yfw/DPVbh4+NIu0DOVIUKRMxDc6D3/1E9a
 CWmFSt84FrTUU5wFtEouD6jQhZHrpDG8tlo1c2BsRjfWCa1SU2JRGTXzlGbhRYhcAWs1
 REajzdtYfpCSmHDc3/M6Ot3rgi02cgB0y1XFzCsGl5wUbAFnsjSgOmCenDF7+kMpwt8o
 8/Qj80m1mqpH5i6V4mbHuoeNyBmHp4cvqzk68iot9s8dqNo+wpD4+j4f7KcybdgaDOrS
 aDFg==
X-Gm-Message-State: AOJu0Yz7Pf19qrOMq9NciMg7PY7oWxIaEE6PxqTDKfU1kOtJC62/IP6f
 4e9GbsHfi9zX7PLBnXLaXxfcH8xdjKOaMyDWSxWHvbtUI7WszMAXNrSnm2Fmbdf4fcdw5wsFwKl
 g
X-Google-Smtp-Source: AGHT+IEx6cyK0JwqipxIIVzBxw3Lz1TURclzmRnzZtQidB2ba+Jy6FY38sAQT4qQ5cg1niqpf0AtKg==
X-Received: by 2002:ac2:5a1a:0:b0:512:a371:3b27 with SMTP id
 q26-20020ac25a1a000000b00512a3713b27mr3761509lfn.13.1710158901596; 
 Mon, 11 Mar 2024 05:08:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c350c00b0041312d21a35sm13802953wmq.7.2024.03.11.05.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:08:21 -0700 (PDT)
Message-ID: <b04ef6ef-1e1b-49d6-9184-16474ad32dc5@linaro.org>
Date: Mon, 11 Mar 2024 13:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] docs/interop/firmware.json: add new enum
 FirmwareFormat
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
 <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/3/24 12:46, Thomas Weißschuh wrote:
> Only a small subset of all blockdev drivers make sense for firmware
> images. Introduce and use a new enum to represent this.
> 
> This also reduces the dependency of firmware.json on the global qapi
> definitions.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   docs/interop/firmware.json | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)


> +##
> +# @FirmwareFormat:
> +#
> +# Formats that are supported for firmware images.
> +#
> +# Since: 8.3

That will be 9.0 :/

> +##
> +{ 'enum': 'FirmwareFormat',
> +  'data': [ 'raw', 'qcow2' ] }


