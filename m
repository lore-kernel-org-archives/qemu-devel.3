Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11D8C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBMd-000503-Lc; Tue, 21 Jan 2025 05:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taBMa-0004vw-6p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:20:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taBMY-0008Q5-F0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:20:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so62475345e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737454800; x=1738059600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no0yvH98L595YAUEdxmFxgwtbGpcQklEje6VcfVUYUo=;
 b=ybMh4ljFAseZQJkGN7Vmto3w6H5heguZahsHyDVLZ3vfQtzYD+G9xAX8cd+L5wf/+6
 sLA2rFde/0gKoc/9DoPRh02G251Nmb4zSEGvUSAWG8zi9rceVtrIdLKV2R1UIWsFlbZi
 jXqskwdQIn1eGR3yNmSeujagiUpdcMU87NVoRtCZOWhZgQ06H1eJ7kp3oYyACeADivlu
 dwCKZCj0UJWblwngGunYo5YQD8Yz+1zBMRrGHumVnKUZhYXGEcHh5YR1SbEr9KdaEKWI
 uULyNAnNKCbVp8i3sydGsdohluPeLUmEspPIcy//ibvh2QWqtPEcvFf9pBBGGqEMaNep
 OL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737454800; x=1738059600;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=no0yvH98L595YAUEdxmFxgwtbGpcQklEje6VcfVUYUo=;
 b=SOSvdb3IDr2ZaKWjKz9miUUoB11WoyCCUD6IdXj+e2MjGJWs9zGC9x2ThiVbETdcd2
 kkK6yBfinV3lMCOhPlcITWXuhbnew7KupKAVaBIJg8s0Txx2kkeYZcQjytm2JhbFUaMb
 8fkCvmxGzsfTE4t7xT1vwA0qCWMhmn4T//JJwL0PLJjdMeCv28s4fVO9gPZ1wUs8vl3z
 KrCjNFEZ2Am8MkdiQPhEN7t9tY68iD36V9WdTz4rkn+Jd6pdT5HiEejxKiIbFpSMbiJP
 VSjCbvBxXzRJSKZJMK0doy4B8JcsSCDH5acyxqOTSWDAI0qbIzHGXWdb4lb86/i4oqiT
 6RaA==
X-Gm-Message-State: AOJu0YzYP9qXc9UfxMS12tXUWxWxedMEmq4sSYkn8BZBX5qpBouFG5Og
 /OQ9YhCr6uWHf1RBMvVRUHbCLoR2MQnuaMxDmp6RjbvMNe84COl9lMf0nCgghsU=
X-Gm-Gg: ASbGncs1PC54qhXaVwguIbxDJdM/qKz1hr5RWSTXKq1pqu14mNdAlyNjLmGQ7m+Txkk
 Q5p8TNQsRsmlA2ayATqmgtzsKeu7Re7GCB6dOgrEll0745jUWmH1YWiTXcewZYJsFKFjWLHEdqW
 Ov8zifNpLri98Cn/ePGzjRciV+1IOtQ8fxFiweboYIXMzXxLOoiLnup4nMyezErLznRiya7Y/d4
 AHSpMOsFG3CZ3JirX+NKDKkuqEZkSkDssOVmnjG2TelZEKtRQSUzOsT0AL4GLGtIsWk
X-Google-Smtp-Source: AGHT+IEJh3JYaSl8WITTV8eH3PcSeAAvccrqtTs9UEO2Sb23qS884If3XfZ+ytCVSE02ihRLiokq2w==
X-Received: by 2002:a5d:5f8c:0:b0:386:3329:6a04 with SMTP id
 ffacd0b85a97d-38bf57a957cmr18816791f8f.39.1737454800136; 
 Tue, 21 Jan 2025 02:20:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904084e7sm173320705e9.6.2025.01.21.02.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 02:19:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 845935F937;
 Tue, 21 Jan 2025 10:19:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-devel@nongnu.org,  Tyrone Ting <kfting@nuvoton.com>,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
In-Reply-To: <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
 (Hao Wu's message of "Tue, 21 Jan 2025 07:52:22 +0800")
References: <20250120150049.3611864-1-alex.bennee@linaro.org>
 <CAGcCb10gHVZdN6CbUm02w7jTaUUoBH4-VTohmy+yiP1OLWFBxg@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 10:19:58 +0000
Message-ID: <87ed0wpiy9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Hao Wu <wuhaotsh@google.com> writes:

> Have you tried that the test can pass with this? If I remember correctly,=
 interrupt won't trigger properly if not advancing the
> timer

Yes but the IRQ has yet to be enabled at this point.

>
> If the test passes it's probably fine to remove that.

Of course.

>
> On Mon, Jan 20, 2025 at 11:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
>
>  Until there are timers enabled the semantics of clock_step_next() will
>  fail. Since d524441a36 (system/qtest: properly feedback results of
>  clock_[step|set]) we will signal a FAIL if time doesn't advance.
>
>  Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  ---
>   tests/qtest/npcm7xx_timer-test.c | 1 -
>   1 file changed, 1 deletion(-)
>
>  diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_time=
r-test.c
>  index 58f58c2f71..43711049ca 100644
>  --- a/tests/qtest/npcm7xx_timer-test.c
>  +++ b/tests/qtest/npcm7xx_timer-test.c
>  @@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer te=
st_data)
>       int i;
>
>       tim_reset(td);
>  -    clock_step_next();
>
>       tim_write_ticr(td, count);
>       tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
>  --=20
>  2.39.5

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

