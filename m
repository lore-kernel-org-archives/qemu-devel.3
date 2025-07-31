Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB59C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbGV-0007zY-Rb; Thu, 31 Jul 2025 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb8A-0007Qd-T1
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:48:06 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb89-0002Ow-GS
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:48:06 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so1581559a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998484; x=1754603284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kuMjHlOeZhhwC3TcSy8An1vQavgStkC69xUsoTCnTlU=;
 b=vkU0fevpdbUP7XdmIFq9MEiVmogX0zZJJmMwZJS66fugTuwQOKiGJqveiGlmYmtaLa
 GXSyDBHWvBrEEoBw/OX/sY2c18qlamvP/BG6V537D/f3NCuTZmMFW+9B7+SKOnmFLMq9
 Co9RO3hNWD407/i/3hh4UPTcX+LmTn2TyL0HV6X463xMnsVxKZJSWmUJyZ9AQVh0Nwiy
 Pl81nuWXNQuV51XzM0bfVdg/rDkKal8JAHZR0gvXP2iaAkgH8ftZBWbCvCMgA+dy92Tt
 QcwxpHuEFFQzlN0GYX92MfKmwNh1SXCn4OOTCRaBWJmMbiejSfrx+HFRwewhb7N2lLbc
 uC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998484; x=1754603284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kuMjHlOeZhhwC3TcSy8An1vQavgStkC69xUsoTCnTlU=;
 b=hZeLu3VIu5oY91gn2mCaqUfbE7Zg1F+wNgtk8xgflKLC9VKgqzLraFuz0m459NA4n8
 Qp+e53l1aDyvXsSt6t3W9WMzUVthHhncLq9mFqQFxBT5mlHWt7vqM4v8loNMysxkMEYb
 sAaXmAAQxvhCBDclLHSawhg9Gd8qYu4n20lefNSAEh3o3td4mpybW5geqCuYaptdfVbv
 SC7LEIptgAUfJ8UbwyiEOtAb5v4/l7zhj82TRqP6qxFFPsYxZAldXXIwwo1cuLddZ3BH
 vXVV34SgR8wf0ZNwjPTXZwLOEhNmpzpPO7Q25agxl5/q6zdgtnBjcRDucTE/49/G3iVP
 nRUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNSJR/4W3tY6ZNjXbNrIrPOY4VJ8TdlqIPAlOfrYO7amqt0adTM6t4tq5e4hbT21WapLybmghA1Wz4@nongnu.org
X-Gm-Message-State: AOJu0YyoREeAVI8uqXz/fqY4WUpXyRrwtv1TGQbzi5oRd53+JBUvef04
 Nwc9qLuepfqvj62erVay4pLxPtxSnSXua6SxibZX8dvYFXILji8AYjPey+d1MinFJw0=
X-Gm-Gg: ASbGnctMZU1P/JS0CPZFYtOXRfy01oC3RNr/aGKTo8mi3QIaibOChapEUU5uTMyIvRa
 9je8SYH30sV4G2k3B7DG5Rqsjfdhhe6qrJgmmfN9EnVPEihBYSsvFpcHxM2CaqOlxEEjiozH5p4
 DLfrTAnvuiy9XOS6lIvV5XP7zpAaEjKB9+sbrfInYJDOC+AINqREPdzn1mIA3I2ZL1ei8AfhNyp
 o38pwqeAKV6NQUpHZuWNKfZrfB3zhD+NW+JCt1NVDHzjoxgMwlejhRQK3nfzYdQdyTQnCgvrHVv
 G1QlsHOzPJiZlLX06Zf/1kXBkhTVVdsXbeld8NwZfZnEZhjtO5UVpVMoUuXN1zU6aNSMXiuLW32
 2i4bEu1C60qbGBusdomSw+Gbxg1Sf7SLNnOvSHWoI+3PKoA==
X-Google-Smtp-Source: AGHT+IGdp9KgK1ThxLW+NO7LDynj2Vms+mJoTZOz8DTnw5jrpypz4AhYuOWf9p/dCwjgMXevhkaDsg==
X-Received: by 2002:a17:902:ef0f:b0:240:3e98:8edf with SMTP id
 d9443c01a7336-24096ae6953mr124335525ad.31.1753998484261; 
 Thu, 31 Jul 2025 14:48:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976cfdsm26123645ad.101.2025.07.31.14.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:48:03 -0700 (PDT)
Message-ID: <957f9869-4638-4e29-ad14-9940ee41f519@linaro.org>
Date: Thu, 31 Jul 2025 14:48:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 67/82] target/arm: Load gcs record for RET with PAuth
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-68-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-68-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


