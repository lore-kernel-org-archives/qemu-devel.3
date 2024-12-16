Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1459E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGpv-0008RO-Rp; Mon, 16 Dec 2024 14:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNGpo-0008R0-WB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:32:54 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNGpm-0005u3-3p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:32:52 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so606349966b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734377568; x=1734982368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2lUwdGoftU6oM5Lb/Vy4IMMYQqPQ4QWM0Yrb7geUso=;
 b=zbyoiQcQpKDglHbQ/oFY0GnTu7kz/wjNZwyADAlGTN2HHknsIXq7gltGLQHu039iTl
 RX6PxcczFauRoHObsthtd/eOA/yQIU3qzZfD0e2sIxZUdAMjFlGYZ31g/uudf5XlTR4e
 7Z9Mw1ZFDOqrFcqOCozUZOlKHIr1xsVTTMi4HCzxk2xCdY1MKt6UEEopsjlQzRyjBmrm
 9zmTJN64860+TjbLbV4mdQBuBuCkOA2mxkeYD/8xIMcJdcLg61RqxIA0jEDlJUL7TuDt
 dQPrLUZ7CJSp9Eedvb29NcwNM+AEg1bzUX/ymYWH0jrD+Ut6AOM36L+78RgXT7Ao1gBR
 oitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377568; x=1734982368;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/2lUwdGoftU6oM5Lb/Vy4IMMYQqPQ4QWM0Yrb7geUso=;
 b=vlm98VHdGvwdxVr+CJBdEUvX5VIZPDEtVe6B6QNkn4OkPXCOMnxx9u7vAcKZXIwdEk
 ybrsgnN66C2pnWwvcNnkiGGgMrA62FNqpaoHyasNW+gmEuTB1tCRrE7Fpn7kxkUGsWQL
 k610qPbMRUH8NcXyjcMy9/b6E6Ou7hZhBVpmavSDHriyfbVQfd5qbIlEooZP2ETdM4lP
 uGlChU7JAgoYpjZ/0wtCVCAfxA3EUEidJoNMhIpoBKfXMZMh5XVus1wt8KglOcuS0mVy
 NBpgUxIBh8oocRX/Bgv0yP3qj5tczkArJM7L4XDSxAmg5x7mZU2dADbMkKZHH7/07Dfb
 7k2w==
X-Gm-Message-State: AOJu0Yyi+6zjNHzG1QdDo3od4KfeDD9JT6H75q+ELmfK3Ij52k+9PTq0
 SfOZAWQ6jwFIq4LknADCrIwZC0EfKezMPCQHxNIkmvgZp8Y7dehIdbx0h9UjX871R6Jon3CVip1
 1jtw=
X-Gm-Gg: ASbGncvTB+McS27EEFmKvwQ310/hy3HlWkqjT+yMmm4gOdcHqZL6uC3aqzyPHVfFIhw
 PfH7ccpSm35snWMo+gwn7W7WrtUggolXLlHVlw7JT5ksQV6+6qM7qlWDGZ70MPpXDCimVSUGM8B
 9NDk1cqp5lfelYYi7ehAgwyb5RSaA6q8gGSFWaMc0JbLor8+DN4+Psej7zYwbexicmwDk912Jue
 N9+bVCg4/dq8k79G2h6cUt8bgIlKPYTjZJb/nxHzljjFiY9VY+SzN8=
X-Google-Smtp-Source: AGHT+IFWsXIy5DuUgxEPaevPcSyUJqhtvLrXNJPzKA/hbxrAckGgqpINi4WoWYj83UOKDGV9I6LA3A==
X-Received: by 2002:a05:6402:35c3:b0:5d2:7396:b0ed with SMTP id
 4fb4d7f45d1cf-5d63c31e814mr34895439a12.14.1734377568172; 
 Mon, 16 Dec 2024 11:32:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96359b94sm367255666b.106.2024.12.16.11.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 11:32:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3A705F952;
 Mon, 16 Dec 2024 19:32:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Radoslaw Biernacki <rad@semihalf.com>,
 qemu-stable@nongnu.org,  Andrei Homescu <ahomescu@google.com>,  Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@google.com>,  =?utf-8?Q?R=C3=A9mi?=
 Denis-Courmont <remi.denis.courmont@huawei.com>
Subject: Re: [PATCH 3/3] target/arm: implement SEL2 physical and virtual timers
In-Reply-To: <CAFEAcA8mi=gTBvh9FqyMFeyqAHqirkah84sW4m8axKPqwMZDkQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 16 Dec 2024 18:14:55 +0000")
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
 <20241206160239.3229094-4-alex.bennee@linaro.org>
 <CAFEAcA8mi=gTBvh9FqyMFeyqAHqirkah84sW4m8axKPqwMZDkQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 19:32:46 +0000
Message-ID: <877c7z1l0h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Dec 2024 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
>> shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
>> actual implementation utilises the same logic as the rest of the
>> timers so all we need to do is:
>>
>>   - define the timers and their access functions
>>   - conditionally add the correct system registers
>>   - create a new accessfn as the rules are subtly different to the
>>     existing secure timer
>>
>> Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> Cc: Andrei Homescu <ahomescu@google.com>
>> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
>> Cc: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
>>
>> ---
>> v1
>>   - add better comments to GTIMER descriptions
>>   - also define new timers for sbsa-ref
>>   - don't conditionally gate qemu_timer creation on the feature
>>   - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/g_tval_[read|=
write]
>> ---
>>  include/hw/arm/bsa.h |   2 +
>>  target/arm/cpu.h     |   2 +
>>  target/arm/gtimer.h  |   4 +-
>>  hw/arm/sbsa-ref.c    |   2 +
>>  hw/arm/virt.c        |   2 +
>
> I would put the board changes in their own patch(es).

Won't that break bisection?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

