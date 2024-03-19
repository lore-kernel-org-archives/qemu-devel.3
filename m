Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED3DC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgGg-0002Fk-BK; Tue, 19 Mar 2024 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgGZ-0002ES-4S
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:41:01 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgGU-0002EE-Mz
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:40:57 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso6880621a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710880853; x=1711485653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbtDOa3NlD/Nf/f3d2LdXd/AGDQOdVk0+twfh8yWUrs=;
 b=IYPfIJ61ZMqkGL2OqkIiFCsR9WTm9wqQpGfDfaPFDZKXUNsZWiZnWIjX/+5PhvsBno
 kIIGsPyzbfU0QhpF3Ekk9S05NvqK5SVbMo3Dm9gBD8PtRHNjHT1BalUgj5w/YL3EQRaW
 n+G/G9ntfPZNW4dlcWG56YYRay+Yalx3+gag132kZW1xA7/1X7jnatagpye8FrHHUyDc
 JQ8MBxQcy6jUZJNTt3IJehWBE5TIuH5iRUObJtsOzOaYpoQDJ0yq+gPhfcOGTUI0MX7i
 yUlAH4OQnHAj3mYxqKamjFzqDa6DyqdZYaP+5Cs0MF5euF7G5L6Fs1GrGdSZqSs5I0hb
 F+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710880853; x=1711485653;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fbtDOa3NlD/Nf/f3d2LdXd/AGDQOdVk0+twfh8yWUrs=;
 b=wE85WRmasuG+jp5zGQh4rhBGsTNaIMdAQ13nu0r7d6HAtsBRsos41ZiRFB6yM0uiPz
 YzstZceHr9imuBSd1wmQ9fw6Z5YMenlqjjbUg5aaiX+QJqakol2gf/zlz0cu7RDZKJNf
 dpP3tDgvBbr2KvQ5wuv2Qwk9cQ+iRfUhxlTa/KISRAuvAdC8igF3frI8HOLbhLGz4n7T
 25Rq03stQ9wH5yPiDOJtM6hrG8t94aIwVBUiI8FMD8M5Aakc8NFakT2q1rHX6pFNGDiA
 RU1XjzBMYVF/5FUyNhlvt0oz/Bz721haquwqIcLtZpKPxd5/lEvO0v545CTapo9ppIvd
 MQgQ==
X-Gm-Message-State: AOJu0Yy7hXmaspMcHmSZ/YwnD/C9n2TxMLugUaEMM4804WvY9GVjWGq6
 lxAhDSdmxK9JDGXhg6B1ERnGrrfNr+CFHvnJbclTAteK7RnAsAjw4wHCVjIzWrg=
X-Google-Smtp-Source: AGHT+IFn+jPANdUjBMbRSI2R5Ks/N0TEgQK1iYJdqw7hpBRUyaeK7pN2qJo/7AqgpQHs9uCMg/lZqA==
X-Received: by 2002:a05:6402:5516:b0:567:23a2:5b1e with SMTP id
 fi22-20020a056402551600b0056723a25b1emr3270740edb.23.1710880852918; 
 Tue, 19 Mar 2024 13:40:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c94-20020a509fe7000000b00568b49389e8sm5123663edf.44.2024.03.19.13.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 13:40:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 29F1F5F737;
 Tue, 19 Mar 2024 20:40:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 08/24] replay: Fix migration use of clock
In-Reply-To: <20240318154621.2361161-9-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:05 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-9-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 20:40:52 +0000
Message-ID: <87ttl22bvv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Migration reads host clocks when not holding the replay_mutex, which
> asserts when recording a trace. It seems that these migration times
> should be host times like other statistics in MigrationState.

s/host/CLOCK_HOST/ and s/host/CLOCK_REALTIME/ but its a confusing
sentence. If the MigrationState is guest visible it should be
QEMU_CLOCK_VIRTUAL surely?

> These
> do not require the replay_mutex.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  migration/migration.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 644e073b7d..2c286ccf63 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3424,7 +3424,7 @@ static void *migration_thread(void *opaque)
>  {
>      MigrationState *s =3D opaque;
>      MigrationThread *thread =3D NULL;
> -    int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      MigThrError thr_error;
>      bool urgent =3D false;
>=20=20
> @@ -3476,7 +3476,7 @@ static void *migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>=20=20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_sta=
rt;
>=20=20
>      trace_migration_thread_setup_complete();
>=20=20
> @@ -3555,7 +3555,7 @@ static void *bg_migration_thread(void *opaque)
>=20=20
>      migration_rate_set(RATE_LIMIT_DISABLED);
>=20=20
> -    setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      /*
>       * We want to save vmstate for the moment when migration has been
>       * initiated but also we want to save RAM content while VM is runnin=
g.
> @@ -3588,7 +3588,7 @@ static void *bg_migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
>=20=20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_sta=
rt;
>=20=20
>      trace_migration_thread_setup_complete();

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

