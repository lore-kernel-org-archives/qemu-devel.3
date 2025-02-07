Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26786C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgT6d-0001Ve-F6; Fri, 07 Feb 2025 13:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgT6b-0001Ug-Eg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:29:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgT6Z-0001Dk-O1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:29:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38daf09d37fso1679315f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738952969; x=1739557769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qa+8QPreo97hCCs72YmxS4/+dUpv7h0uFIWD03F6yQk=;
 b=FQ71gR8U1Ehx6k+dYjm1haqHWthwfTiKPriBWvx3TO2sBFBe0ScWnPxAwWkzkuFHm7
 25bMiFv8zIfyZGHcVBVpaBf9aVkJrr/lZMjfCvYj/PxZfO5pnHJDrTGo56YQ0D2M/Nry
 DtmoTPJevmaL88dX+RHPW+xQ+vcZtphcvYF40MiRRxw3PkrTqKBlsFNlt4k6w0cGJy2x
 CCAMBA2EdsKh7tigmysx1mDNXIfugOFCcQ8gzA3+UctF5jZC3+yJYcqalxJ0FGl5pRv0
 b2nRMg+HdKtxQTgaOSL2fSj4zgaprkp6tP9r5d3vlQZiAxfgBlfCGVd/9dGbeM9Sx2im
 45/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952969; x=1739557769;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qa+8QPreo97hCCs72YmxS4/+dUpv7h0uFIWD03F6yQk=;
 b=BbB8KamkmCIZ+DfAu9Uf7T9v2FyCWgFmzhh+RdL/xGrAKlTkImxJ9asdzu388r/Ihw
 ECA8rug3KFfleuyLh0y+5SjVN+QBwFI9TpISsEusoVqO5zw7QlLbA3z+yYmay1QZnRlQ
 M5yZ+yQD7U1eKvBCHUAkc1sqxBzj6+wy6kl4FA9ncUWSswf2tb/muPRokiKzDmKPOM4t
 Wnax/3oLiCvNIYCPKkKqAmdRmgKzbkxY+C+LynejtdMOGdCGpWXybr/m35IPYl6ExRW7
 0PrHi7pAQSRG+ydc4ZagIunVWy5Sut2e/x9fQ1YK3zEzscK5iHGcGH6DK5gnEzNfTjhq
 nulg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqGrJSjdMnFGsbvtaf70pbHZ2t8iUnehKYHnS+8S0bE3kloB79ownwiWeVgHzTyfRscw90GCrmrBt@nongnu.org
X-Gm-Message-State: AOJu0YzmihUZ9rb8cmL/dnwPh7QgDZTaR1RiQg0manI8ES7CKhBFxARf
 sGBK5uhgSOV3CQExvS3ckDPbc1FAtlU/4YAeI3o/E68z5ZsVWojZ1/td5pwgN5Y=
X-Gm-Gg: ASbGncta0QX9nI7c+DB1N9USkINf5NcWZy/n1jGa34fwSlYqOj//2e9t5DBe+Llx1xQ
 5JSzVQBTehOKXZFnzLDCpRbC4RAZ0zhmx83XQE9RRUk0SblW131sENyRenh8PuINZ2fALEHrpxe
 2Of6+hw6Vzv2FEBm5Niw1Hye+MFtJkT5JUO0st7oVG6n+RLfRtkWRTVJpLvU01t4NFE66NHM5DK
 pRaRhO1k8FHfiSvO5VrvZrzfjSDbjac9TurI6/HfniWb6hp0JQXnbvyQeug6ciS4x4uHquUhSYz
 oBv2FleEv6W7Y48mzQ==
X-Google-Smtp-Source: AGHT+IGV46iXB30dl6xI+3wjMUwGo8GQzLwB28Os5ixWOvMX+xuDQ7FuUJRzeqBqGwCMtFWt2oMQrg==
X-Received: by 2002:a05:6000:1887:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-38dc90edfecmr3248853f8f.26.1738952969200; 
 Fri, 07 Feb 2025 10:29:29 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc17e278bsm4443919f8f.48.2025.02.07.10.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:29:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C224E5F76B;
 Fri,  7 Feb 2025 18:29:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>,  Florian Lugou
 <florian.lugou@provenrun.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
In-Reply-To: <5ee77b8c-e6a4-421b-b729-a6535fdf1e6d@linaro.org> (Richard
 Henderson's message of "Fri, 7 Feb 2025 09:22:17 -0800")
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
 <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
 <CAFEAcA9c9hbpsdyc7+=QEOZGrNY2m-urk6VrWdwCdfk9ipkwpw@mail.gmail.com>
 <20240820113024.53tmzejw2omm6bbx@flugou-latitude5401>
 <CAFEAcA9X0w5QW2qnnhF2k72ZrS8SALWiXV7uNr1e=jQnZvrQ7Q@mail.gmail.com>
 <CAFEAcA-MrouAPdwpsyojMC-bx4aFtuL=tYZD=2pBS1vP5iicaw@mail.gmail.com>
 <5ee77b8c-e6a4-421b-b729-a6535fdf1e6d@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 07 Feb 2025 18:29:27 +0000
Message-ID: <87a5axr4l4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/7/25 07:45, Peter Maydell wrote:
>> This is where things go wrong -- icount_start_warp_timer()
>> notices that all CPU threads are currently idle, and
>> decides it needs to warp the timer forwards to the
>> next deadline, which is at the end of time -- INT64_MAX.
>> But once timer_mod_ns() returns, the generic timer code
>> is going to raise an interrupt (this goes through the GIC
>> code and comes back into the CPU which calls cpu_interrupt()),
>> so we don't want to warp the timer at all. The clock should
>> stay exactly at the value it has and the CPU is going to
>> have more work to do.
>> How is this supposed to work? Shouldn't we only be doing
>> the "start moving the icount forward to the next deadline"
>> once we've completed all the "run timers and AIO stuff" that
>> icount_handle_deadline() triggers, not randomly in the middle
>> of that when this timer callback or some other one might do
>> something to trigger an interrupt?
>
> I don't understand timer warping at all.  And you're right, it doesn't
> seem like this should happen outside of a specific point in the main
> loop.

This has come up before - and the conclusion was we don't know what
sleep=3Don/off is meant to mean. If the processor is asleep and there are
no timers to fire then nothing will happen.

It was off-list though:

  Subject: Re: qemu-system-aarch64 & icount behavior
  Date: Wed, 22 Jul 2020 at 11:21
  From: Kumar Gala <kumar.gala@linaro.org>
  Subject: Fwd: qemu-system-aarch64 & icount behavior
  Message-ID: <CAFEAcA9DnBQFnOc1HJav2DyLwsQu+YYE5RyZp5wrLxyc1gZqOQ@mail.gma=
il.com>
  Date: Fri, 24 Jul 2020 17:25:51 +0100
  From: Peter Maydell <peter.maydell@linaro.org>

>> ... But I don't think there's any reason why
>> timer callbacks should be obliged to reprogram their timers
>> last, and in any case you can imagine scenarios where there
>> are multiple timer callbacks for different timers and it's
>> only the second timer that raises an interrupt...
>
> Agreed.
>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

