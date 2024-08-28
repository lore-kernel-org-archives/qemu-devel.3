Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F11C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGUk-00033g-BB; Wed, 28 Aug 2024 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjGUi-00033C-VP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:05:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjGUg-0000zz-Jv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:05:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428243f928fso72580835e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724843140; x=1725447940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AYc6usIYVIvzjxvAk2//vW70APLSefm3py0Yt5FtNYc=;
 b=YAfockCZig5l4be8hPbUM7cOiqDq/RVI5F4a6MJKgRVVaHY/jalszlltr5tyJt2Pud
 gHTCwr1KdNnTT5SSjrgaXWCfrKPNy4Hju5Q6tgc9UaPiLx2vAG2lWGwZkKgTn8nZtJEu
 vVjLgme9qQ94k6MW1h+1s6VH31a0OZrt1AYLnwgP3pYyWCMGEkJD3mQry8yz1MU75wUW
 Wya/K5qA0xCYgJDfCm5oDgs0qGbhry4K97Gt7Oah6HcjWzKLLGUUkcIFqdqbT9CDXGKH
 DJDRBJkXZ4GgOTXXX6SZUfR18SOoWdbvaHfu3zOPhneP8ChrDjEFWlN9aRIt/9qa2s5+
 y/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724843140; x=1725447940;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYc6usIYVIvzjxvAk2//vW70APLSefm3py0Yt5FtNYc=;
 b=itZOoYIAbXS1Dltsaw18/vmxn/Xui+HPLlAAEoTZubNafhiT+DtrMqTs+ShAZ7rs5S
 9847uAnLogmhyn050hjv6NW1A8TpIKkLfX/t0M4g61AgaCBd4pMX5NY7d6Slzm+onBGu
 tejcXiA2JAtm4CEjv+LHtYfsaZ8iAeqPA5R9XDmLFKanoon6PFzIU0sUeev6+I9ES14P
 PQ1Xxauf0rbvJj23eBHv+XmxD/bArvWWuh5esL9UM822Hmho99uLpOeFkLC4h7rTpoFL
 M6wBglESHg8CitIafC4MtCzGUMFjJZCpqsaslQ1fLkX1hXQClglKnpTY6rPUUEegY3IS
 R0cA==
X-Gm-Message-State: AOJu0Yw4EOymyXSMVYQ4auAViql3ygA7gD5j9fHhLzLor0bM3cs3aGTp
 UXgmiy0pKaEuod0lVbCMvBUU7QKs9SUqyKSUwJ4RPMAKB0PxSIHQcZPJp8YXHHY=
X-Google-Smtp-Source: AGHT+IGjOci3jhA1BXAGw9K6DJ7K9YayGcUKQr/Rpt609tt0zngwgJgBe17pMDY53X4pfVMFi+SPKQ==
X-Received: by 2002:a05:600c:2316:b0:428:29e:8c42 with SMTP id
 5b1f17b1804b1-42acd612f08mr153939565e9.9.1724843139785; 
 Wed, 28 Aug 2024 04:05:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6396700sm18757825e9.10.2024.08.28.04.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 04:05:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4444E5F796;
 Wed, 28 Aug 2024 12:05:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
In-Reply-To: <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 (Elisha Hollander's message of "Wed, 28 Aug 2024 13:36:52 +0300")
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
Date: Wed, 28 Aug 2024 12:05:38 +0100
Message-ID: <87h6b452m5.fsf@draig.linaro.org>
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

Elisha Hollander <just4now666666@gmail.com> writes:

> Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But
> probably I messed something up...

Are you using an older QEMU? We should trigger an API warning if they
are mismatched but maybe thats not working.

>
> On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.com> w=
rote:
>
>  Oh nice, I didn't know that
>
>  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>  Elisha Hollander <just4now666666@gmail.com> writes:
>
>  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>
>  What is the use-case for this patch?
>
>  If you are simply looking to slow the emulated system down please have a
>  look at:
>
>    https://qemu.readthedocs.io/en/master/about/emulation.html#limit-instr=
uctions-per-second
>
>  which uses the plugin system to limit the run rate and sleep if its
>  running too fast. The longer term goal is to deprecate the icount clock
>  alignment feature from the core code and leave icount to just provide
>  the deterministic execution needed for record/replay and reverse
>  debugging.
>
>  > ---
>  >  accel/tcg/cpu-exec.c      | 4 +---
>  >  accel/tcg/icount-common.c | 4 ++--
>  >  2 files changed, 3 insertions(+), 5 deletions(-)
>  >
>  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>  > index 8163295f34..4c2baf8ed4 100644
>  > --- a/accel/tcg/cpu-exec.c
>  > +++ b/accel/tcg/cpu-exec.c
>  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUState =
*cpu)
>  >  static void print_delay(const SyncClocks *sc)
>  >  {
>  >      static float threshold_delay;
>  > -    static int64_t last_realtime_clock;
>  >      static int nb_prints;
>  >=20=20
>  >      if (icount_align_option &&
>  > -        sc->realtime_clock - last_realtime_clock >=3D MAX_DELAY_PRINT=
_RATE &&
>  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>  >          nb_prints < MAX_NB_PRINTS) {
>  >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay) ||
>  >              (-sc->diff_clk / (float)1000000000LL <
>  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>  >                          threshold_delay - 1,
>  >                          threshold_delay);
>  >              nb_prints++;
>  > -            last_realtime_clock =3D sc->realtime_clock;
>  >          }
>  >      }
>  >  }
>  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
>  > index 8d3d3a7e9d..f07f8baf4d 100644
>  > --- a/accel/tcg/icount-common.c
>  > +++ b/accel/tcg/icount-common.c
>  > @@ -46,8 +46,8 @@
>  >   * is TCG-specific, and does not need to be built for other accels.
>  >   */
>  >  static bool icount_sleep =3D true;
>  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
>  > -#define MAX_ICOUNT_SHIFT 10
>  > +/* Arbitrarily pick the minimum allowable speed.  */
>  > +#define MAX_ICOUNT_SHIFT 30
>  >=20=20
>  >  /* Do not count executed instructions */
>  >  ICountMode use_icount =3D ICOUNT_DISABLED;
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

