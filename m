Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FFECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCW9-00038t-AV; Thu, 05 Feb 2026 22:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCW7-00038f-Rf
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:28:23 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCW1-0003VW-Qx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:28:23 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-823f9f81da5so880862b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770348487; x=1770953287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTL6KXhNH+QShVvRatmYtKYKxbLzuUf7npXgiM+XTZA=;
 b=qJpGORmi44JlSTStPQ0tBehjLT0lOYwGYXJowsPTE37Nun6O9kFoFQxoOjYDEZmsUQ
 tYJSA/qyoa3jGlmKxwCEjd56WyBJ0vz9d64fVPQGS06/V/mwbUy1tKGb1R2Y8QaIGgE0
 z78cvjfgIbJv89UDiiL6jp+YIfdjVoWoPjrT8Ni5TXspSn5GgypD+N/tpvp4I8Di9NtP
 +bKF5z9njS3+pYyhpReh7vNv7743jmcojw7a5uV/tcoojVG1Mw7GPL8VbhX+/hmXQRR/
 cj2TWTmzXFmn+9XZFiVqSTm3kaTfX8k7Nbi644nXNZB4kar2HAe/ZE3JEZmkDyyVadpz
 2koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348487; x=1770953287;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pTL6KXhNH+QShVvRatmYtKYKxbLzuUf7npXgiM+XTZA=;
 b=hsiUmyZCtjEtO5VbdFsFijTl58WXDzR5VVFpAtPb7rhPML5pYgrOynRxyL8tQTTcJl
 cuUEMk5KTPHrQXi91u5rIdxs7nxLbbCe4HZGsEYYmXkO0J/99oejfhAKrUaJDx84lU28
 T4g2Q5URudL9p0v++a9T0nRCPxtDjlhFY3F59GrlyRFReULpAU40x+y+5OswSgWKQLKV
 1+xcziijCd8G8aoyJ3Aaf/pkbNvkMLuNSsFI3+Z6mnKK8jQKU3AxEBTJ8/YtmWiaxNk+
 T47F3QKhNWcWaTM3wUEtZ5fdgSoHo+EnQNu+5F152yPr9w3gJycfn3b5foaOJkWokmyr
 ZLgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzr4kFQ7SxJlwq6rkJ08uKBvdTQQjoyio7jlFTlwyVrFm2PIKWY1mogaEYz+uS70NSTn+JVnIRBI3E@nongnu.org
X-Gm-Message-State: AOJu0YwwDMFB3o4+zsXG4wccWHVMV9yxe3mO13RXaYd8xBj0LMgxZD1d
 Cuh0YJTSmdbwMU/IDZ/tHj6FYITJ8fdsZbvM0FYxfSGAa4p62617mXJC0l1ISv7Ex1U=
X-Gm-Gg: AZuq6aJn+vivAO2M9OgBqFbg2Rt3NcUm59asj6Q9oXi9l+mCIqkZMYefVLPHMu6UGqj
 wNNlbHZZxUG8BBmbQbRKP6f19I/y87y0OHf2TcWt7fBCwCOPGan8Wm9+qEfcv5OzsasujKSSsuS
 TCrOy/byvPHzsYaXx0g+xcZc8+ygsIaEhfg75BrRzK3bNaVk27XWJAy38NRFMFl1lOSomZg2cWr
 23tQZc3yd71q3BS0GJg5B6Vs/RKsE193P3XKxax2qpdWEjDLfCaHQnN9o68SB0bXmsmWKjMYdqE
 iaNNzxrUR0zlL/veBJ3CP2mE50Dh8lf8jmJ8TC9iaCelcGlJ0IU8J7f+7u7lzwMGePz0TZW7rup
 zAXtGMbJzuLhref9zM0ON4axjRIpcbruzj3KlIJ3P/ra4SANkwHs/ZPhmPlXWJJxXNO2hU7XqBK
 Vv5jYKdlpO0Ar9tH+6Xe4GM2lMcbbr/RfC2yYBqs+v8i5qJ+Z9SL7Mc4OtrftmWwqtRZgPEuZhT
 R30eoQSIipx+lzlXKsoYxK392GoVV+TtkmmrCBPd0U=
X-Received: by 2002:a05:6a00:2989:b0:7ac:edc4:fb82 with SMTP id
 d2e1a72fcca58-8244160a783mr1120723b3a.5.1770348487085; 
 Thu, 05 Feb 2026 19:28:07 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244166f269sm784259b3a.7.2026.02.05.19.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:28:06 -0800 (PST)
Message-ID: <ed395e40-f3c4-493e-b73f-883fa37cb608@linaro.org>
Date: Fri, 6 Feb 2026 13:27:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] bsd-user: Add message queue implementations
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-20-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-20-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Add implementations for:
> - msgsnd(2): Send message to queue with size validation
> - msgget(2): Get message queue identifier
> - msgrcv(2): Receive message from queue with size validation
> 
> Includes bsd_validate_msgsz() helper that caches kern.ipc.msgmax to
> validates message sizes.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

