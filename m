Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D3E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 17:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCyW-0004UQ-Dl; Tue, 07 Jan 2025 12:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCyU-0004OZ-8X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:02:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCyS-0007cx-8u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:02:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso114383505e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736269354; x=1736874154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwJuQalGALESTiy3usL6E8NGBbd5s9w+iEiGcWxwR6c=;
 b=UDirQcXPjvp3TfcwtYjf0ZNfv1YoLdXGDFaF9D1Pe/b/utg7PhCKWPJ3kHXZWpbvOZ
 dc4CJMajL9ArJaOY33Xl2UL06IXQVOok3IFpOcoVujSuZtH+JOrhLIOgAIHBsdw7dwMU
 kLoHiT9P6dfdSkqYU81ekwcmD0ZtQbEFog23urB5x+JNUBiidWqcA3jf7nKfx3E25t8J
 49RsASLl9Jly2wFAQOP5cwHed99T3Ycb9f1pgieH7kpfxNlaciQX1I5DgwNcJFy/3KVC
 7gdnXKriBWjTT+NGZ+RHlIng1qWojEWwdRhlPwRV6rN+QltRLZTKE7eCPRvEDT4yu6wO
 ugWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736269354; x=1736874154;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VwJuQalGALESTiy3usL6E8NGBbd5s9w+iEiGcWxwR6c=;
 b=swZz2ZM0V+duzxYwH4VGkQCF62QfHurZ7lyK93E5r3qmY7Bhq53x8MCfGw7zaXshlR
 iu0bUFba4zoK1iJtpuFGOB1a/Q/W9c0Pn1f6aBivtQqAcaLYsRDZxPTjYcrqaLd2vnEn
 M3wdSrxgjaPk7dzw+u7ac2Mwh1WZk5a5Ty9Yi2Za51K3Z/BlE018HCNg9GZIWE//Yzn2
 c2qeXUEcBcX1wsXp3mfQ3IntM/sjES2Kd5gLz6fO5fqhwRzwNKDZtvhbqcWJj2rLv4gV
 eXZWbmfvWrNTvd0iCWckeBkMA/QuYCuf4PgxeLe2+3m+1PB3V5odcHrfhNi6+b1g7Mau
 Zm7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBuw5AewHzF8yH6+WsarkngvivUl6WnKd5VNvCMFb9qBbgwLD0GeeGpabEfnTuPxjaPwCOKUzbVtiY@nongnu.org
X-Gm-Message-State: AOJu0Yw3XH4LFhmikzVZzbFhgvmpBoj/PrhYucvijiCd3Lt+hD7pkFfD
 mlpgG3P3Lhk7TTpdJdHHxhicBuA4T4vyolAazodQ3L01syOZZswutsPqBJ9Kdx8=
X-Gm-Gg: ASbGncuWDJTyebLviceEBPivG4bnRi3/vium1AJ38RZFxfu46GWQ51/h9yuZz0moDWt
 sdfOEuhWTjhOogDri511/hH8uK6MTa0aJKP5g2Ezmn/9Uf+t/J4/zlCMHuVmj72sB6HLuHkD5T4
 wzuI65niaihlu7YsqduVMCvhdxN6TvF/InPQVB1C/lEPw7VoY4vwvdfgYGxoe+M7PSYn8jgAiDl
 XPBO/q92PjO6AmCIVHz1r5pL8TNo6mHKe8xSCuAhIefv3HSTITyuuA=
X-Google-Smtp-Source: AGHT+IGSnfxVwWpqw2133zVVt2HgrFW9nfTPn39uUbDnne3UJz4GjySzPF4UJDeU1ilCHWQAREjRxQ==
X-Received: by 2002:a05:600c:4588:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-43668643348mr559184655e9.12.1736269353835; 
 Tue, 07 Jan 2025 09:02:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm605671245e9.14.2025.01.07.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 09:02:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56E3A5F869;
 Tue,  7 Jan 2025 17:02:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  philmd@linaro.org,  thuth@redhat.com, Bill Mills
 <bill.mills@linaro.org>
Subject: Re: [RESEND][PATCH v3 0/7] Add ivshmem-flat device
In-Reply-To: <87r05e8zv4.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 07 Jan 2025 15:25:51 +0100")
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
 <87r05e8zv4.fsf@pond.sub.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 07 Jan 2025 17:02:31 +0000
Message-ID: <874j2ad0bc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Markus Armbruster <armbru@redhat.com> writes:

> Gustavo Romero <gustavo.romero@linaro.org> writes:
>
>> This is a resend of the series:
>>
>> https://lore.kernel.org/qemu-devel/20240222222218.2261956-1-gustavo.rome=
ro@linaro.org/
>>
>> rebased on the current master. The series was sent about 9 months ago and
>> remains relevant. Besides addressing the longstanding issue:
>>
>> https://gitlab.com/qemu-project/qemu/-/issues/1134
>>
>> it has generated interest in the community at least twice since its last
>> version, from different contexts:
>>
>> https://lists.nongnu.org/archive/html/qemu-discuss/2024-05/msg00003.html
>> https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg00374.html
>>
>> This suggests the series is being used out-of-tree in various contexts, =
such
>> as experiments with heterogeneous architectures.
>>
>> But due to the fact it relies on sysbus, which is marked for future remo=
val,
>> some maintainers objected to accepting the patchset, causing it to be he=
ld in
>> the ML.
>
> Actually, I inquired about the use cases, and was told it's for OpenAMP.
> I challenged the use of ivshmem for that purpose in some detail[*], but
> got no reply.
>
>>         However, given the ongoing community interest and since currentl=
y there
>> isn't a better way on QEMU than using sysbus for the wiring needs of this
>> device (e.g. to wire the device to a CPU IRQ input line), I'd kindly lik=
e to ask
>> maintainers to reconsider its acceptance.
>
> [*] https://lore.kernel.org/qemu-devel/87zfth4psf.fsf@pond.sub.org/

Yes the principle use case is modelling asymmetric set ups with two sets
of CPU cores attached only by a piece of shared RAM with maybe a
signalling an IRQ. As the CPUs are doing the work we want to test both
sides (VirtIO device and driver) rather than provide an emulation.

Once we have a single QEMU binary that is dynamically configurable and
supports heterogeneous setups then we can model it within QEMU itself.
However until that point 2 QEMU's and some shared memory is the easiest
way to test such things.

This is currently being worked on as part of the larger HVAC project:

  https://linaro.atlassian.net/wiki/spaces/HVAC/overview

where we are working on a new VirtIO transport layer (virtio-msg) that
doesn't have the issues associated with lack of trapped configuration
space.

>
> [...]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

