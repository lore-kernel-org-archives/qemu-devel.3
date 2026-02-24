Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249EFE9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 12:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vurVA-0003z0-KY; Tue, 24 Feb 2026 07:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vurV9-0003yr-Me
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:26:55 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vurV8-0000jp-1b
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 07:26:55 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7964fb9ae3dso47898747b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 04:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771936013; cv=none;
 d=google.com; s=arc-20240605;
 b=ZmlZoLZ32fuXvHadxYC/Ljd7wQlP6AoEPd4VmuBeUkXYTCwkjgA4Im6t9siJf+IIJR
 pGGg3etZ2XdyqWBlra78MKudTFlAk2Wh5m62+BBeQXbe1CFnN5UQJiw866po9mo8xsAS
 UJK2g+ZrE57bCPApTWVRl9nrvOMK5vl+52UtJpqxBXkzxxjHZ/tJNhA2R87aTXMCuDP+
 Y54GrsDOOJJhvkCLtfxxS8plM3QB/K+IYov0wT4ESUzUZku32+Cok1hqwi4l9Kb3V6+O
 e2riI4j07rWKT38VmxTAJ2cWtjLilpMB0gkyELlcbdOOfj3QMq/aX0iMLGCjmnik6+8e
 HvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vvoWfGKVGQm9ko9EEIC0W9a0OGkgQTcvXEztcIldwGs=;
 fh=2MtLTr60U2KTqy037VMVnPisBShV//lh5ns59lg5hdw=;
 b=fdJ4WCD/6cN1aQgR4mXo5x5jvOU0xYv5rZYuk4Y1dQvhXgxwjwNUeYJCi46RSPIIFc
 yPrOg+wSLEo8CrI0vrEnhHddgXIXCdzT7kCnHByDOLh4GGAQYWQiQjCUGXgM8w8TWiZN
 yoBUYrWC1bOjNNMA/TDhzEfSvuPpV8zT64CpLor/qH/vAamrA+sc3xGa9q5Kr5hBEbU7
 4X3Tza4NP+66IuQwLgLcb300522gJ7CHtnvGpuZ3JenUwpvPLduofMqavH8WESBQRRis
 9P1Of0DMQZOfuERoAhJAfy3H1gjKGH6ZHoqt7ulnZPMZSg2rhW0AMZapsrFx2ACnsfrM
 pfJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771936013; x=1772540813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvoWfGKVGQm9ko9EEIC0W9a0OGkgQTcvXEztcIldwGs=;
 b=npLAgqE7Peyl3zsXr4kjEA84I8B3ZDBbVBRh0eshebty2/NhJketiEHvlF/JX6/ey1
 HGOeO5dgyvzWgsseH2twdWH8o9X6Yu71xAVZO+8aWg070uJwyvZMpEGjbvLN6Rz147wM
 0uwf9q6kgsyXnA5gHIKH7WdjNX1iPZNaZyDmWfRmfGXbfQrAOnI4tvGGvua1p/gXCdl2
 xoEWmo15G02flNED5Nnu77C9XmWaCmoT6tp3AINxXODIRGtGiHSBmveLnGR+OxLjqDNr
 wdwYu4KBnR333yTiyKD0w/u08sXKdhcf2tTgMScjYJfYpezN4mZdUejCnWQFqD3PRLq4
 YoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771936013; x=1772540813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvoWfGKVGQm9ko9EEIC0W9a0OGkgQTcvXEztcIldwGs=;
 b=KgZ6qg7yaPcXYmuCMeCctXi1nwGNQUOyigWvdg711kUwcR/fz9H/NxX4TndcOA0Jgh
 QY0OT9VQytPQz7TQ8S5MztNpYd/AeYFFF2/gBtsMgyIZxGkS7T+Yoh25/I23d798aojm
 K29OuzRg61TwevTkT0UGkcMNXlC63JmKljHkhTKjRtSizCDIgSSSBVuio/gQk3xRmGoR
 tfwweFBEHDLq5LB4bs8EKG+IWYGDHuFbEIHBddfRBeL3T5oypYlfak5Gjj+vzJnJd692
 JWoJuhSRk8ZPlE6pYxItrtVECsgaVXoRuN1GWecvOxjvgN0LllCTzMRWn8JONObt/Kyw
 Gd4w==
X-Gm-Message-State: AOJu0Yxde/9vd95sBzsP3RqeQ+UsacdVWnpXuJhX8C/wDfW1D/NsKFVx
 HVAOA/59DYJsElquCM9TKP2PtY2zC388+2zlenJ4jluKEtZuNdN1bPMhnvK+SAEGXqLjvCjDt9s
 1pQ5XjNdeTl15XobgGYOZZH/EzTkPLtHt2KfFgdaDpQ==
X-Gm-Gg: ATEYQzxsxF5IG81oe1djOFNu/VZ7xq50CNt3jjvZOivUDgjKU/o90TdKVMpKnC6TpH9
 F/li70NXeLK3kKERWdbtiJpUkaaAX1203T5+AstL2co+tDiF0uS0JgSODeltNsPJjgNiSQwN83I
 sdfoLPm1Y2loqhIV86kiTPqabTJy0mAiyGeEx3ADQc6+xQ7jc3doi9ts/uJjsO6AM5Na15FQt7U
 cUdqVdLKVcELlA5HRaSjSbf4fCQLNYeJ7gGA5a1mTIJUGOAF/oZj+bbb+Jw94T1hG+VOU2Kp4I6
 PQ/W1GCyUbVk3re1RayUJWH6sZlIVT0yWf5U3CBYSWonuRnOhcoC87Ph+C8gbhwNp3Ga/osDOcP
 MFg==
X-Received: by 2002:a05:690e:134b:b0:64a:d716:c8b5 with SMTP id
 956f58d0204a3-64c787d5303mr9314935d50.18.1771936012612; Tue, 24 Feb 2026
 04:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20260224121014.279248-1-alex.bennee@linaro.org>
 <20260224121014.279248-6-alex.bennee@linaro.org>
In-Reply-To: <20260224121014.279248-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 12:26:41 +0000
X-Gm-Features: AaiRm533j8zDX2_W69viuybZop_pjQHvzltY8QSUE_Gekc6F8p7hu_LMlDKkSOM
Message-ID: <CAFEAcA--YmCZ2+BBy1kM_VjeER4vbX8VMBbSA1aqUQ9-jWp5tQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/arm: extend WFX support for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eca <noreply@eca.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 24 Feb 2026 at 12:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This commit extends support for WFI, WFE, WFIT, and WFET instructions
> for A-profile ARM CPUs, ensuring proper architectural semantics and
> full ISS (Instruction Specific Syndrome) field support for traps.
>
> Key changes:
> - Update `syn_wfx` in `target/arm/syndrome.h` to include `RN` (register
>   number) and `RV` (register valid) fields using `registerfields.h`
>   macros.
> - Refactor `HELPER(wfi)` and `HELPER(wfit)` to use correct AArch64
>   syndrome values (CV=3D0, COND=3D0xf).
> - Implement `HELPER(wfet)` and update `trans_WFET` to support the new
>   Wait For Event with Timeout instruction.
> - Update `HELPER(wfe)` to implement proper A-profile semantics,
>   including trap checks and event register handling.
> - Extend `event_register` handling to all ARM CPUs (not just M-profile)
>   by updating `HELPER(sev)` and `arm_cpu_has_work`.
> - Declare WFxT helpers as `TCG_CALL_NO_WG` as they can raise
>   exceptions.

Yeah, no. This all needs to be split out to be anything
close to reviewable. In particular "report the right
syndrome info", "make WFE/SEV not NOPs on A profile like
they are on M-profile" and "do better with WFET" are all
separate things.

Also, this doesn't change any of the places that it needs to
change to implement the places that architecturally set the
event register (see R_XRZRK in the Arm ARM), so it will
break code that uses WFE. Notably for A-profile this includes
generic timer "event streams", which we currently don't implement
at all.

thanks
-- PMM

