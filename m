Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB12E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3or-0006LM-5M; Sun, 28 Dec 2025 22:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3oo-0006Cy-Fu
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:21:14 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3om-0005eQ-Ay
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:21:13 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6447743ce90so7756355d50.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978471; x=1767583271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+wwBlrxQrq2I8JF3JkvL7vK1GKM4YEuNyUpWcb9QbI=;
 b=ejGIHxWLbxqQD9DessE6t34RSGQ69x+uJZO+HSSssv4dA6mNlPMRKQgFtT2p7CzEaa
 pQH1TVowf8LlFIeQpyrKpQvcvX6Pojl4wfV5Yg8sloBTcawsDoyEW5QQn1aKWLkBAlVw
 sRX9Gze7iwvICZTDczaLiEN6aHxrHEHdJIsmYypOEUs0poSDAdLvFfm3RK4cuPv1v9CI
 9DoVPSaJR2EfP9TsskhoXbMJMTigAqLOaAnQkE3JDxOOJPD8iVHhI9wUwqauJbD2KOwg
 DVlFciTIahv7S/6XMUjgLCSEDe5jDXCjqCCimIIEX02IGn4pJpla9V9P7evpreXeEEaX
 SZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978471; x=1767583271;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+wwBlrxQrq2I8JF3JkvL7vK1GKM4YEuNyUpWcb9QbI=;
 b=rhtb28nIrkY2VBFdprH7G3f+cISKjAc1Qq/P8RYCpvxHAXeM9FPZddfsLaQWddhu5X
 LE5bRbVBGym9e1wzE6ft27Lf/sMZZVMLveTzis1uD6PliUeZgjx5u+ICyI/K4q4JxvIb
 pvT3Pm2sAlZXMBD77wAVkQOGUbrs3LrrL3Y+eI4MKoxxqo/z/z1+9EM8BkyW3mbB6pCG
 lSxeIB/B410hxb4F1xVd3ACh3PQk+RS80Bgw2LcXcD2V+zo0cY/SGzxv1bY65yDfO9G+
 0d98GR/q3FySfLjAkk8SUGVIRC9cEyEZSnUqyxpZ+WQ+HkWounUP5g5/ZR9oKrGwQ/po
 F0dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0PJK8CN9IK2S4gI9kzKi2Ip1klo191mfpNFkLoERnRxLAYIFjOb4sadzTy54Vol4g5y93edbrx3XS@nongnu.org
X-Gm-Message-State: AOJu0Yw8pbZCCx4QSeQIoxM5fEPQOymIQRwEFtt1zS04A2V4lfZ7X/TS
 QBefAhHafgko1N04UHjuJKANDW4AClINvEve01M2ltFMaST7cqQ54fkPaAFXm4F1Wyk=
X-Gm-Gg: AY/fxX5ugSRvEmxvOSP3NTxxwqyXWAqivz6Wzat0PqSsMDnWUWtt3AMJ6T3VFOUmcr8
 S4EKPSG0YBb6PbafPItV0bk0W72QmDudE57mSNyyJhzjsrO9JOOYh191DEvEolq4Dkug+ptoX5g
 fKVABfNHtcxPAciDipwTC65N/M9Ayz156m6Jp6wIc5IWxAGgbR96WB8AS40R2LxeXU7xvI/oPeo
 3FxekEH/UWu8qqYeBvS2b83FwnIrrR7OK55UM07WY81QJlLK8n0S5+M3+1CmqN7afabV0LZMLti
 oTAg1bS3kLVPcr7Lufzg7JEEQZ2Qz0sYoEw1RK4/92Cokz7FT6Esj9nOrgeeP9BRmO2irqZTFxR
 2vhY1w/fSyYv0PKocz9sscpqwg+cswY7dThuWq3eYSX5fcZHgZiuHkWJDb+u2Uopxy9DXL4WNlB
 B9YJNdOh5YJbxkrtvPrdBeBKxroA==
X-Google-Smtp-Source: AGHT+IFvAH0vPV6l5CDOOBfkJ2jTAsPS+oHOelznsEnNfvac2plDtsIIeWKjvHBOppScLGjn98u5vg==
X-Received: by 2002:a05:690e:bcb:b0:644:ca2b:b659 with SMTP id
 956f58d0204a3-6466a8b55e7mr22213028d50.64.1766978471304; 
 Sun, 28 Dec 2025 19:21:11 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a8bd6ffsm14357945d50.9.2025.12.28.19.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:21:11 -0800 (PST)
Message-ID: <537edc7a-0e99-49fc-a016-c3c3834c4ec3@linaro.org>
Date: Mon, 29 Dec 2025 14:20:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/alpha: Replace legacy ld_phys() ->
 address_space_ld()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb136.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> Prefer the address_space_ld/st API over the legacy ld_phys()
> because it allow checking for bus access fault.
> 
> Since we removed the last legacy uses of the legacy ldst_phys()
> API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
> hide the legacy API to alpha binaries, avoiding further API uses
> to creep in.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/alpha-linux-user.mak |  1 +
>   configs/targets/alpha-softmmu.mak    |  1 +
>   target/alpha/helper.c                | 29 ++++++++++++++++------------
>   3 files changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

