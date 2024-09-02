Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6C1CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl6nh-0003u6-Jv; Mon, 02 Sep 2024 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl6ne-0003gM-4k
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:08:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sl6nc-0004y8-41
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 09:08:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a86883231b4so508154966b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725282529; x=1725887329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9h9TdizzpmIEOqEs3tv5NtRfv14tQJArSoIkBX9s/dk=;
 b=thl7ecznDHZOjTGxF1UZaqCPk9OeMp6PVlYNQq9Db4/55LsSPk5AJsjBdb70jkXk7K
 ZH9IIGhSD7GrRM1BidZwLLJOyXm5nibRp/YIfAGu77frOtvSLaqO9IEqBoDRUf2Up7/w
 G7vGM7Ano4WNd7i/R2S1ivgyGZKo5qFblE1Pl3CxkF4mIn0OgnWE7A/ybUYj1a+IVCei
 1xbm4zYN4+3lwWRv1xuQ1sz1hb4SMY8CnydHCrqpFcv5r3GOla3SfBxy9uXFcOLQ2RuX
 I396W2QFbv4leAeGrYCpMKd+HSLy2xO4b+CEStFLS88O8lhvJuZ4YieZdFEmxf9UAzPI
 kLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725282529; x=1725887329;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9h9TdizzpmIEOqEs3tv5NtRfv14tQJArSoIkBX9s/dk=;
 b=KfXhOs+yQG2+CVAzRx83ekCB3w6/Ae/DdnriMBrQ3W4Kj5+vDlHl7EE+URlc/D2OWV
 vs+GAFw0JTNQOgtQcxo6So3pm3dQOIyrzhh+YFFoot9Po0DXK7mmRwFnmcexDf9A4JZ1
 IMZ9BAxxU9pvnkVllF/CRcF5cCcCe2l5f7B0eBwPZ+E4goNgVOm0V8MYy2YNmBbKW5gl
 KZQ2bKHzILpXKY1VLQlGW5G6RutYe3RSqERTVNuYy9BhFThfBu6nfXydu6LjeZa/2fqu
 CjVFeMPAdmy0aGlPL651UgBomDsrfYIBTqKofsLwDEOVVRBGilKuOQd3ah3SHGyCTgO+
 Cn5g==
X-Gm-Message-State: AOJu0YzYMhknHAA9a1egrReVb7m3hZgIKqRjBfETv2a0K2rih6KuyuvK
 AQVPSdenz8ouGrCzpq+68auphAi4R6eKRn2nnLXs40UrrIeCvyaXRwEweJL90Tc=
X-Google-Smtp-Source: AGHT+IHfLD0Tlu2+IZMXbYXHI2uz4bM6AVj4z4lHIk9SbgapubIsDpdJmccCFJ9+ETDdcn9oDqDVKg==
X-Received: by 2002:a17:907:7e85:b0:a7a:aa35:408a with SMTP id
 a640c23a62f3a-a89d87821c7mr522519466b.25.1725282528240; 
 Mon, 02 Sep 2024 06:08:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891dbf2csm548686366b.186.2024.09.02.06.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 06:08:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB8FF5F835;
 Mon,  2 Sep 2024 14:08:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
In-Reply-To: <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
 (Elisha Hollander's message of "Mon, 2 Sep 2024 15:38:48 +0300")
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
 <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 02 Sep 2024 14:08:46 +0100
Message-ID: <87wmjudwyp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

> But for qemu_plugin_update_ns
>
> On Mon, Sep 2, 2024, 15:38 Elisha Hollander <just4now666666@gmail.com> wr=
ote:
>
>  Just checked with 9.0.2 it it still gives the error...
>
>  On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>  Elisha Hollander <just4now666666@gmail.com> writes:
>
>  > Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. But
>  > probably I messed something up...
>
>  Are you using an older QEMU? We should trigger an API warning if they
>  are mismatched but maybe thats not working.
>
>  >
>  > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.com=
> wrote:
>  >
>  >  Oh nice, I didn't know that
>  >
>  >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>  >
>  >  Elisha Hollander <just4now666666@gmail.com> writes:
>  >
>  >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>  >
>  >  What is the use-case for this patch?
>  >
>  >  If you are simply looking to slow the emulated system down please hav=
e a
>  >  look at:
>  >
>  >    https://qemu.readthedocs.io/en/master/about/emulation.html#limit-in=
structions-per-second
>  >
>  >  which uses the plugin system to limit the run rate and sleep if its
>  >  running too fast. The longer term goal is to deprecate the icount clo=
ck
>  >  alignment feature from the core code and leave icount to just provide
>  >  the deterministic execution needed for record/replay and reverse
>  >  debugging.
>  >
>  >  > ---
>  >  >  accel/tcg/cpu-exec.c      | 4 +---
>  >  >  accel/tcg/icount-common.c | 4 ++--
>  >  >  2 files changed, 3 insertions(+), 5 deletions(-)
>  >  >
>  >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>  >  > index 8163295f34..4c2baf8ed4 100644
>  >  > --- a/accel/tcg/cpu-exec.c
>  >  > +++ b/accel/tcg/cpu-exec.c
>  >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPUSta=
te *cpu)
>  >  >  static void print_delay(const SyncClocks *sc)
>  >  >  {
>  >  >      static float threshold_delay;
>  >  > -    static int64_t last_realtime_clock;
>  >  >      static int nb_prints;
>  >  >=20=20
>  >  >      if (icount_align_option &&
>  >  > -        sc->realtime_clock - last_realtime_clock >=3D MAX_DELAY_PR=
INT_RATE &&
>  >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>  >  >          nb_prints < MAX_NB_PRINTS) {
>  >  >          if ((-sc->diff_clk / (float)1000000000LL > threshold_delay=
) ||
>  >  >              (-sc->diff_clk / (float)1000000000LL <
>  >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>  >  >                          threshold_delay - 1,
>  >  >                          threshold_delay);
>  >  >              nb_prints++;
>  >  > -            last_realtime_clock =3D sc->realtime_clock;
>  >  >          }
>  >  >      }
>  >  >  }
>  >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
>  >  > index 8d3d3a7e9d..f07f8baf4d 100644
>  >  > --- a/accel/tcg/icount-common.c
>  >  > +++ b/accel/tcg/icount-common.c
>  >  > @@ -46,8 +46,8 @@
>  >  >   * is TCG-specific, and does not need to be built for other accels.
>  >  >   */
>  >  >  static bool icount_sleep =3D true;
>  >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
>  >  > -#define MAX_ICOUNT_SHIFT 10
>  >  > +/* Arbitrarily pick the minimum allowable speed.  */
>  >  > +#define MAX_ICOUNT_SHIFT 30
>  >  >=20=20
>  >  >  /* Do not count executed instructions */
>  >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
>  >
>  >  --=20
>  >  Alex Benn=C3=A9e
>  >  Virtualisation Tech Lead @ Linaro
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

Can you give me your command line please?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

