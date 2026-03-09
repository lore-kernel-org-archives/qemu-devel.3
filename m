Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF4CF3C269
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbIk-0007EJ-6P; Mon, 09 Mar 2026 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbIg-0007AV-M0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:09:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbIf-0000VC-2z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:09:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so16339845e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773065372; x=1773670172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHCvg+v3Dr6fcxDd3qO4IfR7UNHcUP6yU9x98MxABjY=;
 b=tYuiH3hPLwM/4Y6EXj+T1Zd6ptoLUbmEeFv/L4i/uGZFnxOWQ4MHeyiUNMvMJIcfCw
 GXKh5umhu/jYQWlj9+0W/9dZoF4FHXuQRGTgn9oHqlEKa/fcUegmZAei7gPp/ahY80xn
 cl5QEcMiaKEJUXWvqdMnRMWQeV8FRWJzeatEEiOMLyyyoHDGtUT9f1dsMpxCuPRJCcyz
 wSOU82Lsazb2hkR0coTUOiM3x80Ldr99fGH9rTXnbC9Xnw+FE1qhrtIEL0x8rNEtWpkA
 O72NSLx/mboVE+tB3ayKwdQpsAVhhJn4ZejjOcjOt8em8MsxADI8JyXNux/WU51YXPe/
 1+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773065372; x=1773670172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHCvg+v3Dr6fcxDd3qO4IfR7UNHcUP6yU9x98MxABjY=;
 b=qRJoYbzKnPR/8c2WEPDpaZdbPyt2XLi17wEONcaARMKDu9tm6eSMiTPnlgyiG5fyXq
 hRxHkt6AaKV26WF8CjNHglZtp1uqdDzOVR+YFcGXiY6+KXWpQPELBABvOVXt+L1HqLpT
 8cioP+yMHcGyCGzgxyO4uFifPT6O/ojU/YJfQh6rRY8KGS8a+lkMZ0addEgozqxkl4nS
 l2m4JYL/cxRhPk8jOlX13+dzdw/fnTILnga2DnbsvBG7Tiy6d70LhLsOH/kxW/bnycpv
 nx1Ky1hHRjy+A3iCmepHr13StdSwp9q7CMVxCf4n+Ui2GUq9kIb520wd2qQKsevWKykX
 mdQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIgK0caZ1+yqsubf6myr4NyHEiwrGYXjtsFRAuSQq9rsaqmJNAvK6G4FzIHwgInXpMWvxT9pOQlTvz@nongnu.org
X-Gm-Message-State: AOJu0YxhTjqzWsfJyXDfXpNmjdu64J9/TYs9M5kfc2bLKCmqCWyIur2I
 3MqSO5YPDwzTml4cJzEuI+5yim9A09nhMbeWIwrZOO5hB2gq0Y7BBqlos6arbCsbA/c=
X-Gm-Gg: ATEYQzxy2htQgBq9TMabfOgrgpKEBdfdO3mg4MJP/sE/CkMJghYMP5n+qFOlV22rVXu
 G9xcqHWwEMvAqjCch4iLEBhtmjX4JCaw+xOLbEspPlsKE7Q10eQIEsNgyvx6TWrKtPxzjPMWZYu
 NW1bK8luFQ5XtU344MCmlHQW6thEkhXwaIAvuV98kpcAPQE5vTwng2ermKOBd/WHRWLFCc31yeN
 ccLy0ybRSlOA33zT3IInbRpU4PnH2Lm7F2nenuSPcLhrOhl+Ru94BL5w1386KlFWqyheGoJI8r2
 yI2fDCj+inldp+MIyziFmDlDJGT8drPy3UjS4MdmLC16IcQQrasM6/mEgOVp/kWS/RuZStGqTgB
 FckyXH4QXnE2bR89clie3mvC+gwBHGluKF5zAGwzjnYD+bl0NmI2PN2VIlnjiQEpMsbCSyh/cb1
 ydfT5Mt3D4wXtSxlWii+4v7TAFyrfjIF9fKbJZEC1lc70nBYFVwCMty2eCEj1XrABG8kFQdJ3hb
 Pb4Jg7hHQ==
X-Received: by 2002:a05:600c:c0c3:20b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-4852a85e711mr117151045e9.2.1773065371591; 
 Mon, 09 Mar 2026 07:09:31 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485244b6e9esm152954795e9.5.2026.03.09.07.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:09:30 -0700 (PDT)
Message-ID: <be3a816c-ef01-4aea-ab1c-72814c4f3e47@linaro.org>
Date: Mon, 9 Mar 2026 15:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sparc: fix minor memory leaks
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307112931.3322532-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/3/26 12:29, Peter Maydell wrote:

> Peter Maydell (3):
>    hw/sparc/sun4m: Don't set up dummy cpu interrupts
>    hw/sparc/sun4m: Use qdev GPIOs rather than qemu_allocate_irqs()
>    hw/timer/slavio_timer: Free resources allocated in instance_init

Series queued, thanks.

