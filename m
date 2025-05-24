Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EE8C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsKF-0006m8-TN; Sat, 24 May 2025 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsKB-0006lv-G2
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:06:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsK9-0005NI-I1
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:06:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a36e0d22c1so564586f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748106376; x=1748711176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GnIZQQfOPki/LIcNAdH8XsHj3R00VCI5wGwUgflHcRI=;
 b=spzA+zJZNyduZnipgHVxkCqQbDBVqlLLN7aID3ovarnXS0ZqiZ9CYq0GWLzXEmw5Bw
 paUNehR7c+k2VtNqWV2iSvpTNQDrFcOX3MfDJc0Hvej8MA/vgip0QhmlO+uSjLVIhESe
 Mc7/ozksEzHF2RZU/vV2ofZaLJ2H3mUp/u1ib578GQ/n0jtFit8cBWgq15Z7SV9WWcBT
 9Ro8YXg88Rye4b02d4qDzWwFRj4aOqTeSvoI2Ow3PinvHVHPmPQdVJHYTSrqnBGkSWto
 zx++7RrosuRFUZonMslT8QHEQIdXEbKSMHAXeF/yQYHGHnB+kWpYxSwHyNeIAxbRGBAj
 H9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106376; x=1748711176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnIZQQfOPki/LIcNAdH8XsHj3R00VCI5wGwUgflHcRI=;
 b=lPegDVF1Sz88QcZXtVqP8tF8+Hk38vi5uXWpQdg+UW5k5nlrndiPe86iBs6t2nwDz1
 cbrWktrcq7kEg1VrAtKuPWo34VD5+qm6XJ25SWjkttv7msQ2aSloid4Eq1BYo8TlbfId
 LZHSybMAuJan2cM3h1vBq+AZJeuN3wVibqFV+6pc9p2zBRE58Kq7qUQpnHxxymQpND/o
 e9qxgVcF7u6nOEFjhBIv/H/jak9zs8dBh3tTDACWTrhvHUpSlIHzMh0L2UKIjlcaQrmP
 fVL2eaV5I4xPnwDW1aRKf+BEH8qLS53Wg9WzzwSKo0483qgVFEhsqqUT8++7hG5bJYoG
 dXZA==
X-Gm-Message-State: AOJu0YyJphi6eBsuWF+pMIqmm6YmeIg7q3zRAU71Jjn1vN6LPCJ2DY7T
 gQaENaSC8RioNlAQPVkg6KlF26DtYcxTnWE9u7gkLSfRFvE6vv0l5OIBH5S560UOu0nUVjKc4Mo
 dCRqrOFAvSA==
X-Gm-Gg: ASbGnctRVNo6k9jQ4Tu2+cP3TWNm0u3DghvcAuHvngUjYHhs+q2aubQ2PbUYr7rJ/gz
 5D+/CxARQtViNyQRxQ7zgsoc7lj2jfKYvZE/Lb60OA8rnMRzvO8msBkZ+7fbUuGM52LJYWr9ttY
 7xz/5iX2/hZ03fTO7PbsyeqagjHKZ/z7UOhb24X73KOyhI9Ma9IoQf0fV4dFwn6VeVaxo0agZTh
 gFUSvArYggdIHYbfXARf84JANlKt5cWikg3SUPiWj8gkXLuF245j6uP8MbUcexgbk5ipfQcCLeh
 ZTKGbZpD3WwNVc7qLC8zajHIWBP+oTX4JD8TQTq3hROOSrDS48rdy8VIfEH2ItwQhA==
X-Google-Smtp-Source: AGHT+IFb399zh7cwpKVouIAzGKZEZWZQ6pVREXm81mb+h8EztMCktqTL6QD8GHhTuNmIaJ3FtF4hGg==
X-Received: by 2002:a05:6000:22c3:b0:3a3:75d7:585f with SMTP id
 ffacd0b85a97d-3a4cb47e818mr2634173f8f.55.1748106375924; 
 Sat, 24 May 2025 10:06:15 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cd0cf5ccsm2467794f8f.8.2025.05.24.10.06.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:06:15 -0700 (PDT)
Message-ID: <3f5274dc-728f-400a-819c-afc686aea5ec@linaro.org>
Date: Sat, 24 May 2025 18:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/25] target/avr: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <57905b1779684c65f526b7554df14483aff58494.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <57905b1779684c65f526b7554df14483aff58494.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for AVR targets. That architecture appears
> to only know interrupts.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/avr/helper.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

