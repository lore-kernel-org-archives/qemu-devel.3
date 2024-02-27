Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BDC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 19:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf37X-000404-Nu; Tue, 27 Feb 2024 14:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf37V-0003zq-Px
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:28:05 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf37T-0000Ci-VA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:28:05 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d208be133bso72327901fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709062081; x=1709666881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pm+kKQYCjIBYIUu7Qr/Rcwhln8/HSo8G5sOKgvwqWd8=;
 b=mGgEzC+Xq6Doa3SO7HMy2jrp0aSYiQYNPIHzp+4/6B2rDssZqfuX3Z21SWJZFh6h22
 PBYZwslIUC+aAlJZaZdfmOHIYZ0D2xTmBby4CI3qf6AAzDAouIXwHEHbgaqS+TPyUY9O
 mLMFBPNVT2mTuluwI013+Dz6ZqxQ+RWr/NAeJtQnuv9jiPdNZ2Z1ie7+00hP8goumbun
 V2mm7wrP4UDxh6gWVoFNDCh+3MfOxaAigkAO5JV0inZWAg75F/g9jPT0ljqybRunC8sg
 uCT8Q27P24w6Qg1y2Y8/RAiCvUC5rTfmd+58119lWXc6IZovyVsMJ0I3NzsodQpZs6Lu
 n8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709062081; x=1709666881;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pm+kKQYCjIBYIUu7Qr/Rcwhln8/HSo8G5sOKgvwqWd8=;
 b=LEW+uT4s0nbIQNrHwZOa2vIqbEEWtscTMhKBdKScuzZLwSW5LngrW9eSDgp8fKWJ5s
 mIee3ftDwtdQcEFXKQs6apDeafZ+EUq8IZk0LXwGPTM3RAhn2ijIghaK4xDnoQEb+DqU
 Mmu1pyFd9yMDwIlC+uBcKPcEsH5S3magj32FH9nxJJBUzQrkh3XYRlR3NdIsxf9CtbfQ
 f06Rczake72WN+esCYX0CWeLyn3LlBgxCqxUttGiXiXzVVUUruZn2Hk/etbMsKV0FZXD
 jRiw/EKuZjxDrejrcF8IzKJ1/P5fpzaKxTFwrk0dWmTnO19G2hyuyQAFH7kGk7jw4C8a
 nZnA==
X-Gm-Message-State: AOJu0Yz1xy904e5uUqZNI3AVdJIoLuxYGYIzkUDGIEczLykGUKxCBT15
 P4aBvtETnEmARsAv/6l5j9qK5k5ZHO1rs4em+j0uamg1BIx0IUHpHB9cAYiWvPI=
X-Google-Smtp-Source: AGHT+IGOCI/uJBb76AygDbDZGOA4+gZmE0o59JW9HaX1OmM1h/NQzxHz7VSbMfHWajf/shZkNBjSrA==
X-Received: by 2002:a05:651c:50e:b0:2d2:2ddb:28c7 with SMTP id
 o14-20020a05651c050e00b002d22ddb28c7mr8043493ljp.26.1709062080797; 
 Tue, 27 Feb 2024 11:28:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jl20-20020a05600c6a9400b004126101915esm15837944wmb.4.2024.02.27.11.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 11:28:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2074B5F7AD;
 Tue, 27 Feb 2024 19:28:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v3 4/9] replay: allow runstate shutdown->running when
 replaying trace
In-Reply-To: <20240226082945.1452499-5-npiggin@gmail.com> (Nicholas Piggin's
 message of "Mon, 26 Feb 2024 18:29:40 +1000")
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-5-npiggin@gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 19:28:00 +0000
Message-ID: <87a5nld7wf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

> When replaying a trace, it is possible to go from shutdown to running
> with a reverse-debugging step. This can be useful if the problem being
> debugged triggers a reset or shutdown.
>
> This can be tested by making a recording of a machine that shuts down,
> then using -action shutdown=3Dpause when replaying it. Continuing to the
> end of the trace then reverse-stepping in gdb crashes due to invalid
> runstate transition.
>
> Just permitting the transition seems to be all that's necessary for
> reverse-debugging to work well in such a state.
>
> Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/sysemu/runstate.h |  1 +
>  replay/replay.c           |  2 ++
>  system/runstate.c         | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 0117d243c4..fe25eed3c0 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -9,6 +9,7 @@ void runstate_set(RunState new_state);
>  RunState runstate_get(void);
>  bool runstate_is_running(void);
>  bool runstate_needs_reset(void);
> +void runstate_replay_enable(void);
>=20=20
>  typedef void VMChangeStateHandler(void *opaque, bool running, RunState s=
tate);
>=20=20
> diff --git a/replay/replay.c b/replay/replay.c
> index 3fd241a4fc..2951eed3bd 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -383,6 +383,8 @@ static void replay_enable(const char *fname, int mode)
>          /* go to the beginning */
>          fseek(replay_file, HEADER_SIZE, SEEK_SET);
>          replay_fetch_data_kind();
> +
> +        runstate_replay_enable();
>      }
>=20=20
>      replay_init_events();
> diff --git a/system/runstate.c b/system/runstate.c
> index d6ab860eca..bd0fed8657 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -182,6 +182,12 @@ static const RunStateTransition runstate_transitions=
_def[] =3D {
>      { RUN_STATE__MAX, RUN_STATE__MAX },
>  };
>=20=20
> +static const RunStateTransition replay_runstate_transitions_def[] =3D {
> +    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
> +
> +    { RUN_STATE__MAX, RUN_STATE__MAX },
> +};
> +
>  static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
>=20=20
>  bool runstate_check(RunState state)
> @@ -189,6 +195,19 @@ bool runstate_check(RunState state)
>      return current_run_state =3D=3D state;
>  }
>=20=20
> +void runstate_replay_enable(void)
> +{
> +    const RunStateTransition *p;
> +
> +    assert(replay_mode =3D=3D REPLAY_MODE_PLAY);
> +

As the bellow is common to runstate_init it could be
re-factored into a helper taking the runstate_transitions_def pointer.

> +    for (p =3D &replay_runstate_transitions_def[0]; p->from !=3D RUN_STA=
TE__MAX;
> +         p++) {
> +        runstate_valid_transitions[p->from][p->to] =3D true;
> +    }
> +
> +}
> +
>  static void runstate_init(void)
>  {
>      const RunStateTransition *p;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

