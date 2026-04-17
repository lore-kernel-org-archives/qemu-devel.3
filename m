Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C352BF8E4AA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbNl-00053u-HD; Fri, 17 Apr 2026 01:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbNU-0004zs-2y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:04:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbNS-0008Et-Jg
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:04:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso2481165e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776402265; x=1777007065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z8dxhqNjde42xCFjygpnI5gYTGKi/RMuEz/YjAzqBpw=;
 b=vQ7ehO8Il1Hu/WzoIn5C0yrBfENitwzFsfM9xgj3PCfZs7ne1fPNPSMYmquNbI9LSD
 /ajjkk4VWKGNSRCvJxROzmw9P8nJDJlTnX6g3j3wetuifsnwuVfKFDoRf9B6YyelZBS9
 PT7rKly7LXmkrrax3sLvCAsLsK6l/KHVBc+zTm+Oo/9ysFVtI1laOY96w6OPAWjj9u3K
 Okntzmq+OFwL9ZwwdlPw/l3pOi7L4tqQbijE6e40IusBybgKG5KNjVIJsupO7p96R47X
 uvrRr6vKrOzEFeCmnDSujsINuewJ9VKWkOj/ENLxZkWfrneM2pF+eXpSWN+o+bw7TcHU
 MceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776402265; x=1777007065;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8dxhqNjde42xCFjygpnI5gYTGKi/RMuEz/YjAzqBpw=;
 b=S8j6XAbiqdo8Yc8bnfiFD1rpdSBMor8oV+WBQd+V8Axp/9cctpJNtxBRDUzGZQ74nE
 32eijytMROSoqhM6NAeqJjZJwAIU4WN+NchZGbKsp3WsSIkvh4F4Q1WYv3JrK35ejoLB
 Dgsow//jo0R8mJSCGuWPWM1tlH3faWh0I3B+o72wNKti6vLiqrj/WKxiwZcxKgb9meJy
 617rm2sruzTJvBqL/tWWkBcT8uCRrulWIzSbe5mhbx5Lo9AY+1TfciaW3vMs/loF2KBV
 KtWI3vC0rDv3gJfQT4hYf9jr4trU2GwXjgCXfHflmhoijsRGEUFWgX8IMwb6DZ3Gl5G/
 yhaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3wu/2XqOUWB+UO88lmuFXzDGTtsjkSYu+7V6AJCk4JN0iGI9KYh2CSIOdBIMA7tGEliRkzrdJZN5R@nongnu.org
X-Gm-Message-State: AOJu0YxzFi5oKKWXISd4fDvUS7DAWi9IpVM+2sDMIA4HV4whiInpqhaK
 SuPa8PM0Zuc2F1e3gS00Rj/3n1IU8R3fmKreMvau1uZsNycKfvokpVb4PprqPEw3cSA=
X-Gm-Gg: AeBDietMJj8Mdw1dLRNA1hlH+SrPOWEgQ37J7RWHclQy1PYc5kuTKQV9C5ADTaMs7LU
 Pb/AOLwRXbjA03X/y7cBeEhkxPKCZvtbNpYJ2es6kz9S7+HKtRGV9CCcQrTGUhoqvYTJdY56vv4
 XtXcbPqG8NUDV9g7umsfk8PQah85/+Cf0k/tKuUoS7Am5kydEv9FbcoAVwXs5Tg6JtE1bmhyLcu
 plKbhl/7vBrEsGYYXIox87q1n7MKJSD8OqeNMCn46eFZpg6qcKVmQ2J8+omABAPNHssXcQdXtaA
 I1x+nxWnpZWj7TJOsQF1iMqqY2ms3O7fpfjHOJF3v6YVt0Rtru2ar2YbrAtP6A5HVmVbgTb6BGJ
 +yz01u3445+hDCBv74A0SBejPWzJGNnmZJMIiP+OO0u0Gu+M1gfsFKid0R8zjs0P5ozJlfZucxN
 wXIWAZtGhiz1zu8rMwbqsra79OjLMRsmxraG/1JHuS/5KtaSpbqwDUf2dSDL+IDRGLgLu1eu2vr
 BN2
X-Received: by 2002:a05:600c:4fd1:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-488fb782a04mr14283205e9.22.1776402264994; 
 Thu, 16 Apr 2026 22:04:24 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc100162sm17362975e9.5.2026.04.16.22.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 22:04:23 -0700 (PDT)
Message-ID: <2ab50796-2750-4ab1-abe5-6c4f2c809734@linaro.org>
Date: Fri, 17 Apr 2026 07:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/4/26 03:49, Jamin Lin wrote:
> Replace legacy DPRINTF() debug logging in the EHCI host controller
> implementation with QEMU trace events.
> 
> The EHCI_DEBUG macro and associated DPRINTF() definitions are
> removed as they are no longer needed.
> 
> Trace events are added for:
> - packet submission and completion
> - queue head execution state
> - periodic schedule advancement
> - ITD error conditions
> - port state handling
> - skipped microframes
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h   | 10 ---------
>   hw/usb/hcd-ehci.c   | 49 +++++++++++++++++++--------------------------
>   hw/usb/trace-events |  9 +++++++++
>   3 files changed, 30 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

