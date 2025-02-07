Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69335C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgS3o-00029H-2l; Fri, 07 Feb 2025 12:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgS3c-00025H-Mn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:22:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgS3a-0000Mb-Jb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:22:24 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f5a224544so9644795ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738948940; x=1739553740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuI9ezYBAeHIwgM6VLS6Ioe0cLgcltuopXziKm5PBHw=;
 b=yE9e2YxN2stXQ8aqcWwxOMDxaRDoHWtMT0JSK5bZag7O2/WcxYIZ+OqSFCN963yrbw
 5j0DW4I4sldUxybRS2+r5WUs9iZMDOaU5vSOD8em0qJYFS1iCI5BwySPhCW5ENToP9AS
 WE1ozFK135tA5CCLx9jcLpU9Zi//EwGws9KZvHIYMUrWQ0RVXcDerQ8jeGS1CWzWy7Ln
 gt407bPkeSaQh9rEnzFxLLY3jqx58DMek6EWRIf6UISt+qLmpXL5vJ9nUFMw/CQ01v75
 NKXXIKZ9U97ZPqL6rwZARc+2BGx5PwqQjSeqJyR0FsvBA0qLogMHzssFYqDuzaiDTQQa
 M7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948940; x=1739553740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuI9ezYBAeHIwgM6VLS6Ioe0cLgcltuopXziKm5PBHw=;
 b=aISeztUrb8kF0tH9mG/W0Ua9UWNd3PQODo3e9fz3JjPQItZ9MVLraJby90yqivchRX
 z2WWgD8rnsqytV3wA3rMVENGhsLp1kaME/b2rTmEoKhl7iiUPc75TtX9WtVavGCb+EcX
 3bM/hBle4c4H2IwDwTDfdKpt8R0PjkOAdXdJI8hHoqyJw8hbTVNWmN0yxp7kTLnWa981
 8dpHEx7TJ23gLnZRwa86yvXppLMYXA7VqFxDY7GM5Aw1h2zzZTBIkLCtr5a0VhyTpc94
 u87dsJsBG/qVw5KdzgjKI63tXj+eryBj16q1rpC1keCFcWdYWArFyFkgvYGliAexoU5e
 piEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzl1+ybnVPPIQibGyrSoTkphMBd4rUPyRPzfW8cw3Jmf1n1FcVgn5jSIpM6xmmBZ8YitM9f7rn6da9@nongnu.org
X-Gm-Message-State: AOJu0Yxz3j21xd9YuBc3DR1uEfljgy9cvCtyQV9Kbd5HCdZ6fGv96MYx
 PtLkcDlif2GYPVwO/B1hpXZIyNccnCpeWNVi4dDiMM9Nm9iCiEN/KAbODA+Ds9k=
X-Gm-Gg: ASbGncvceZuZE0rOzaWBt2QrlWP/KmNtbnB4buSAnmrdwyGKGS4CAQcxzzByGRliFuM
 c+GniRHDEFFHOneAzg1TF8oX6Z+PUCkPRbXjsXD5rKm5Kh1wFIECgwYYTkMBfn09+cXWKu2j4t8
 oi2oCS6rZDOvN/RTpSSPgpxnMtkwcVZlzSNS4ERavMA7CZY9ZGGWrn9i2FtRLHeXKP63nKisaE6
 DI+NmUABZhl4E9fj4mnkMZYvNjXScG8bAGaJ831QX5yQmu8e3OF4pnpyd9UueIJPeeS1b+KR/t3
 o7Bws1fNjqcNJYH7kGGIewkBguCvgSh14cOWF850uI5bwkPVWciK7I0=
X-Google-Smtp-Source: AGHT+IFH65CDDp7tP5xkPhrzS7K+EByWPF9bO0ure/lihhPD5d4Cw3JSMGTG2j77BjsC2FVvWZ9cCg==
X-Received: by 2002:a17:903:2311:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-21f4e6e649dmr71243065ad.19.1738948939645; 
 Fri, 07 Feb 2025 09:22:19 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683dc55sm33238375ad.125.2025.02.07.09.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 09:22:19 -0800 (PST)
Message-ID: <5ee77b8c-e6a4-421b-b729-a6535fdf1e6d@linaro.org>
Date: Fri, 7 Feb 2025 09:22:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Florian Lugou <florian.lugou@provenrun.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
 <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
 <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
 <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
 <CAFEAcA-MrouAPdwpsyojMC-bx4aFtuL=tYZD=2pBS1vP5iicaw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-MrouAPdwpsyojMC-bx4aFtuL=tYZD=2pBS1vP5iicaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/7/25 07:45, Peter Maydell wrote:
> This is where things go wrong -- icount_start_warp_timer()
> notices that all CPU threads are currently idle, and
> decides it needs to warp the timer forwards to the
> next deadline, which is at the end of time -- INT64_MAX.
> 
> But once timer_mod_ns() returns, the generic timer code
> is going to raise an interrupt (this goes through the GIC
> code and comes back into the CPU which calls cpu_interrupt()),
> so we don't want to warp the timer at all. The clock should
> stay exactly at the value it has and the CPU is going to
> have more work to do.
> 
> How is this supposed to work? Shouldn't we only be doing
> the "start moving the icount forward to the next deadline"
> once we've completed all the "run timers and AIO stuff" that
> icount_handle_deadline() triggers, not randomly in the middle
> of that when this timer callback or some other one might do
> something to trigger an interrupt?

I don't understand timer warping at all.  And you're right, it doesn't seem like this 
should happen outside of a specific point in the main loop.

> ... But I don't think there's any reason why
> timer callbacks should be obliged to reprogram their timers
> last, and in any case you can imagine scenarios where there
> are multiple timer callbacks for different timers and it's
> only the second timer that raises an interrupt...

Agreed.


r~

