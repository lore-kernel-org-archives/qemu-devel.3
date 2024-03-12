Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C031C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Gj-0000TR-Kh; Tue, 12 Mar 2024 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk2GB-0000QP-TS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:33:41 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk2G8-0002SM-6R
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:33:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4499ef8b5aso408694966b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710250412; x=1710855212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tulGImYAKbkM3PWZca+XxlhTDJ4g0IYyAeDIOzR7nMo=;
 b=lob+Qq2E1hI83BNsGzkb+L5lXv9dlbFcp658EEi9lZDKggjA0sRJh1mSQow3RpPJqG
 JAsVC9WhhWhQ2VQR4URp393sM2a+xfUgGH5W6Lkw4G26PVDds3rIP3uk9URj4ME+mZ17
 QuZp2HaHCalzQ5QG+FwtPPPNbzkSd7lONkA8iyMtUgA2dPdobQgnxGJjPlOxpOztidCt
 cI/jP04GQQha2zcLjHE7FDDpQUJil2rc8AH6obcNGZeMDHvuLgOp8QntFl6BvNy30eFo
 XIKxUqZDgRKhmKAfmQNYiOamaEHhQnh4rg9AI7hvv6QtzPBNG4ba6sx2mImS0912Vuww
 95RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250412; x=1710855212;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tulGImYAKbkM3PWZca+XxlhTDJ4g0IYyAeDIOzR7nMo=;
 b=LmVpYqySEac4eqZ+y8QTBnR1gh9EadRR/nsCxogYsTmOkeT7naW1yW33o8HkSD+Kw2
 t02ydQUBqVKU2OPImgU6g99V5WpigshDdwz/uSAHeylsstA7ua8/l0GhPxsTlaSLIW/+
 /oamgYHpwfh9DdVnRaHRYqkl80qT86jHV+GnMYv7ggIsZsNoZOhEPjuqhrT2QzCOUUTA
 3vz4zsnWzLaN5sMKHppe1ideCEqOwDp2aKyHN85jRpj/rpD9HWPF9WXP/kRUkjseZVZc
 I7fnenBdggT4uF25Tb69HrWhZfDQMerpN+43dyr0+tgDK+BkQ9D4c7+Mq1pdWo5+hbDW
 1eKw==
X-Gm-Message-State: AOJu0YyTim7J0KLgXERLVkhN4WSyNm9iowaS8NfumVjrGxw3Kd1lyW8c
 W6lU/XlRv3N9cqSWsjbX+dP4Aq9NiOD5H6yfNWcwGjTKIrfyI3QI/PRNQ5mGiFPqMD/PQF0NGwi
 N
X-Google-Smtp-Source: AGHT+IEnXRLxaokoG127tg4zBEdwJE8tDxWmFj5ma7BscvQaT3Oj5YY27WYSXR+f9OYHcLEHqBEfAA==
X-Received: by 2002:a17:906:3994:b0:a3e:da6:85f8 with SMTP id
 h20-20020a170906399400b00a3e0da685f8mr6708091eje.30.1710250411987; 
 Tue, 12 Mar 2024 06:33:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ku14-20020a170907788e00b00a44ce0671b1sm3868896ejc.108.2024.03.12.06.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:33:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F07FC5F885;
 Tue, 12 Mar 2024 13:33:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
In-Reply-To: <20240311174026.2177152-6-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 12 Mar 2024 03:40:07 +1000")
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-6-npiggin@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 13:33:30 +0000
Message-ID: <87v85ro9qt.fsf@draig.linaro.org>
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

> This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
>
> That commit causes reverse_debugging.py test failures, and does
> not seem to solve the root cause of the problem x86-64 still
> hangs in record/replay tests.

I'm still finding the reverse debugging tests failing with this series.

> The problem with short-cutting the iowait that was taken during
> record phase is that related events will not get consumed at the
> same points (e.g., reading the clock).
>
> A hang with zero icount always seems to be a symptom of an earlier
> problem that has caused the recording to become out of synch with
> the execution and consumption of events by replay.

Would it be possible to still detect the failure mode rather than a full
revert?

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/sysemu/replay.h      |  5 -----
>  accel/tcg/tcg-accel-ops-rr.c |  2 +-
>  replay/replay.c              | 21 ---------------------
>  3 files changed, 1 insertion(+), 27 deletions(-)
>
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index f229b2109c..8102fa54f0 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -73,11 +73,6 @@ int replay_get_instructions(void);
>  /*! Updates instructions counter in replay mode. */
>  void replay_account_executed_instructions(void);
>=20=20
> -/**
> - * replay_can_wait: check if we should pause for wait-io
> - */
> -bool replay_can_wait(void);
> -
>  /* Processing clocks and other time sources */
>=20=20
>  /*! Save the specified clock */
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 894e73e52c..a942442a33 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>  {
>      CPUState *cpu;
>=20=20
> -    while (all_cpu_threads_idle() && replay_can_wait()) {
> +    while (all_cpu_threads_idle()) {
>          rr_stop_kick_timer();
>          qemu_cond_wait_bql(first_cpu->halt_cond);
>      }
> diff --git a/replay/replay.c b/replay/replay.c
> index b8564a4813..895fa6b67a 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -451,27 +451,6 @@ void replay_start(void)
>      replay_enable_events();
>  }
>=20=20
> -/*
> - * For none/record the answer is yes.
> - */
> -bool replay_can_wait(void)
> -{
> -    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> -        /*
> -         * For playback we shouldn't ever be at a point we wait. If
> -         * the instruction count has reached zero and we have an
> -         * unconsumed event we should go around again and consume it.
> -         */
> -        if (replay_state.instruction_count =3D=3D 0 && replay_state.has_=
unread_data) {
> -            return false;
> -        } else {
> -            replay_sync_error("Playback shouldn't have to iowait");
> -        }
> -    }
> -    return true;
> -}
> -
> -
>  void replay_finish(void)
>  {
>      if (replay_mode =3D=3D REPLAY_MODE_NONE) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

