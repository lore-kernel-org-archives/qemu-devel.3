Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68C6CFD313
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 23:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNJUp-0002hw-Rv; Sun, 23 Nov 2025 18:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUn-0002gt-GH
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:53 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUl-0001cn-Se
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:53 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-343806688c5so3179516a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 15:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763940470; x=1764545270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyFLaRKWpXzuxK3TF82M4uOrvyCct8pzr6KKjChlHwI=;
 b=hfoQiCf/6gjqZCj8teZWeB6YR4qzUcr8qya7Byv9fSEto9Mb0ue3gBdp/xF80TsY7f
 JOkPqsxziSK5AK8vbV/StVGv0nVYS+EUfLXSIW+9waCazi63CHVf/xRT0Rg48VhEVgvV
 eUWF+o+bEn9QnuRiYHlAPh2ElgqOx5PdlQ1yku6Ak/raF0iid5B3J01/8FzK6SJ4d1aW
 vnvfDm8Wp1TJiSRMVU3TlPeLG83TunZYqfTDzV/zTFOcW2MMUSjIdGGp0OQeN1Ez+4k9
 NYZTcMxZdU1eHRvRjkn3g/i3hJGQfeqZNlLs7A9eMlTIBATgRAbrEa4+bX6hhcgXLz1L
 SH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763940470; x=1764545270;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyFLaRKWpXzuxK3TF82M4uOrvyCct8pzr6KKjChlHwI=;
 b=Vt73hEAvh156dBWs8GROK/5BlYjt0IAwuUPFlroq7VW828V5ehF7ZARhYeFrsIj31K
 CYdeA4ladAyyuLo2Nd8mmg3al73ihKX6hF6VApZuPeZ4hc6FzMfaJQrqf/jXddAdHGQ4
 azz/8qY8JLv6hSCfJQy2disjgDdARXBt1x7w/7O1+Kgjqo7FXWQnIKGbsNnpSYgWhmI4
 1JH6L6XuiqEmHnHkBMByAE1azi6xPknI38rpVcs0qjs2frTbKtmZKM68PH/LxpYJjECw
 udBKhAm3B9ZaFu7BGzS9diM6kyYKmN2pbC3KK5XZAs3ffAf3HXLey499816wv69wxjxg
 W+5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuoOfVMokTrmB4guZCIa1Vh6/mUUbTiziG0LcPJl2DFfrhereRHKcSSF54SqG7FnO+5mr814Cn6I3t@nongnu.org
X-Gm-Message-State: AOJu0YwaCX1xSf1czt+oBf2IrmolAuwG5lCM8rNqS+b//GU5Y8UjhQKE
 zKchzr7YEYWNkttohLv/AIcwao1EUtbuhxYRcpxzpGrao1VQycAOAEc7whjvjkg61610ApVUufV
 tcqJG
X-Gm-Gg: ASbGncvQuuwj/F86P2IBcyZe941F9rRT2bU9Rh1qIv0TWnCD+Xt8KuRNZATl6JqzF2h
 w8/wlj204zYnopLgzN+YRSupH63fe95dMUTz7nd4JNbD2U5idP9oe7yFZn4nkgfiOH+st9bLkV1
 EAADoGypAibwqOk7UQJViNDsVVXgeYrWbrquBpaBojk1bxpGX7X1LprA3RuK4kNVog9tW2AZMUb
 0ugCJ0pIMoIPI8eeK87Advs760AsvGLzX9Lu9uV5DEE3zqzsA7tXqk50wUq0l3y7I/6wlw+6P8E
 Jrhw81ptAdkzMCzE2aY1TP07utcTa421TtmUn2Jm+U3gDdm8ukArTbAjFjibBUU1UWTg4Grqyek
 4lGt5kwjGT4wPC5IiF4UONb9ZH7w5FQ9lRDA7l2k4lBX74eSB82a294oLN8EE/Lbg3BlXNHOCGQ
 DnijpNug7IeJd1RD36t5W3KcS6TDUQGHi/DnVkaieCu3tzITbT8g0qqN8=
X-Google-Smtp-Source: AGHT+IG+eGxnOK4vcGfMOz713MQwRv4ig7XQZCX0gA5qjnZ0gkmRHKYMcXKlEuU4J+g53mchAEx2qQ==
X-Received: by 2002:a17:90b:4c48:b0:336:bfce:3b48 with SMTP id
 98e67ed59e1d1-34733e5b1d1mr9000165a91.9.1763940470501; 
 Sun, 23 Nov 2025 15:27:50 -0800 (PST)
Received: from [192.168.0.4] (174-21-128-133.tukw.qwest.net. [174.21.128.133])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-347267a10b2sm11600663a91.5.2025.11.23.15.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 15:27:50 -0800 (PST)
Message-ID: <10bd744a-69b6-4245-a481-1248b067a632@linaro.org>
Date: Sun, 23 Nov 2025 15:27:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Trivial patches for 2025-11-21
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20251121125455.1108509-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251121125455.1108509-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 11/21/25 04:54, Michael Tokarev wrote:
> The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 5f9ac963735598c1efbdce9c4a09f0a64e13d613:
> 
>    Fix the typo of vfio-pci device's enable-migration option (2025-11-21 15:53:06 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2025-11-21
> Just 3 patches so far, but since we're reaching a
> release, there's no point at waiting longer :)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

