Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BDBD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQPgh-0006sW-Lk; Tue, 02 Dec 2025 07:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQPgW-0006ra-9r
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:40:48 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQPgS-0007bG-Gc
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:40:46 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e7e57450ceso1669371fac.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679243; x=1765284043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQjiP5lxbp5clAlFhaIP+NvjZ7IzBGaX1ittV1CGTww=;
 b=vCfFXiYXYwEq7B7Dk06Vt3IgwMePQ02lKTMVqLBXhI2OVABQp1OE2a7ZBxQrijw0Qa
 mRZCesf+Ff0L8+6OMe4GWVAcrhvWl8Mg91kRNtLkh8yEcc1eUE9W/R+qxTJzl05Coosc
 ajbuxDUkrV8WbuDDiGy/pyelsFIqq0lXB4E+D1zkX5yGZZi3lw2+8G9eSjqup3kczo97
 9K2q+sByGubPTG/44ZOx+KtJyAVYhPdzw5EpR1wwBN1Lt8jx0TrziS8+MSmurvInt3Iz
 oHuA3OnxufroMx0A0zK5IP+orBU9SV/Kj14XArZFCO0sMBZHUD7YzfhcfQUAN6oUtI3C
 U/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679243; x=1765284043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQjiP5lxbp5clAlFhaIP+NvjZ7IzBGaX1ittV1CGTww=;
 b=HLWbQgPTnD1QTTBkvtdPBANN6+5u8cfYGNmEP7Dxj+wKFmkLA1n+Gp1f0VkSEpH/op
 skBTJK2JUgCpJvf6Mrz0h+Db+VZO0su7WoUASZWqMqDj+BRhmNLJGAYnoIhN7pKtU0Tc
 oULdGle6s/akN7l09fOR7mZ8P3DP71C9OLwBePkGDbIoGFZjzNtYvRZz2mDmOuGztcXA
 i/vtxi2RKgymy0+61vy5OMVu8e5ri7W/YL7iric7UGuNaK5L6XgF0nO38tIvZQ6UqaQw
 jODYFtP+Kjhf4g/qYlGXJFi40Y5Hq5OPeN25+zKfdIbbVkWF6+mbhKmXSbL16tPFrcyD
 jYxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/yeYVUwvP7jhYo7BhvlJHox5eBt6jPF2Fm1DVvNRVkjnbuHeJHdPxlauwyOmmlfkmfNIU4beve7Rc@nongnu.org
X-Gm-Message-State: AOJu0Yz0WA5k8O+zsXDh21eic0YjccGAlGTMs0/sKshXKnjIuAX+zHdd
 rhBcUEwlU4T+HO+mv+bRn91gpsQtqRhVpjEMmA4X5VK+sHj8Miiz/jFPJTK7kNxAh3g=
X-Gm-Gg: ASbGnctRA4VncdkFzKY8j950UM8XGpGZCVVlIJiw6myP193KabJ8PhyNvbjdwHAvczS
 T54KiovPJmKIHn7i8RL/IcQ4Gk5VrztCWL+5m8vq7kPZHojmtWFjv3HOwh63GgA1npHNrJHw4nM
 ajl3UGuFdPAkqkCKJ5kQG3VKDfYSle9FC6kI5hellGgCKTLqf3yF3TItV4ZdcSlAPn7FK/X1p6l
 WgWGK8JPoYMzThVfT7L4O99k8khWR9GtxE9SGoa12pdlpJYfD2O/x5JyZGKWzEAVqtlY77bCuxJ
 hbr7AlYyFX+AAwWsnZ+z+9rDRZPn+l7MjPXIZIvxvMLTpKq/RZu3fRJ/7ZAXR85s+j8dME4Ru7/
 PjfxnkmlwWl5qPPhe82yoCpu2enBZ93gKyBhJD4tKU/ubV/Sf1HyiK+L+k738AWVqRroxkL37jh
 ec0Em42drgZohY0XToo53tt5Qr
X-Google-Smtp-Source: AGHT+IFa+vEY+QEWjmS+1h0wzW+np8+zSpqcUXSe6nOMigkYGUras/8SMoOObId0bjxcsWgwa+JovA==
X-Received: by 2002:a05:6870:648e:b0:3d2:590b:8d12 with SMTP id
 586e51a60fabf-3ecbe5863e7mr20326123fac.45.1764679242938; 
 Tue, 02 Dec 2025 04:40:42 -0800 (PST)
Received: from [172.16.93.54] ([201.144.25.11])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3e8a5sm7546552fac.7.2025.12.02.04.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 04:40:42 -0800 (PST)
Message-ID: <4fb4bbf8-b7dd-4130-a4b9-4ab08fd478da@linaro.org>
Date: Tue, 2 Dec 2025 04:40:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20251201160943.1342099-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251201160943.1342099-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 12/1/25 08:09, Peter Maydell wrote:
> Hi; here's an arm pullreq for whichever rc we're up to now :-)
> One easy bugfix for an assertion, and one docs-only change to
> update a URL.
> 
> thanks
> -- PMM
> 
> The following changes since commit 9ef49528b5286f078061b52ac41e0ca19fa10e36:
> 
>    Merge tag 'hw-misc-20251125' ofhttps://github.com/philmd/qemu into staging (2025-11-25 14:22:39 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251201
> 
> for you to fetch changes up to ebb625262c7f9837d6c7b9d8a0c1349fe8a8f4ff:
> 
>    docs/devel: Update URL for make-pullreq script (2025-12-01 09:39:46 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * fix assertion in translation of BRA
>   * update soon-to-break URL in docs

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

