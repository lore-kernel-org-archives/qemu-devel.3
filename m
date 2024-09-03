Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A843CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSgJ-0007qj-JP; Tue, 03 Sep 2024 08:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slSfx-0007lm-Kt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:30:32 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slSfv-0006BN-Gs
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:30:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so1585679a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725366622; x=1725971422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFzyvgfY8c6IcdQy4tKyErKBZg8IMW81gHDJ+gljST8=;
 b=ugpodlV/TXp5cW/xF2io6BbuzAPxVfnXMDNP4DC+PRxdPS0GBz6yj5e1J54A96yugv
 hlboucCs3DCJ+7fA2kKV26PtO/YfrhsoM/vGvimzk+ID8q+Cm04fhlK+2NhOZIdu6i79
 5xlcGT8bu6PORmSY3kHSXaClDJwaXiL8KWq3sPIEVm2J3oFOwzOmwFhNER4awY6jqWuS
 L2LOUc5ViGrZHS79Bq4oGY4+dUtqzG9iTj7puhzN1xpv0XAIWCTF15eyGfPB8dN7+Eed
 8YKKBRbXgqZyqQ8Y/Y3Z4W69t+BYk087pJ6+9z4SPtdy2kcZV9CaPLOkbmerQ9/x2pHu
 IVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725366622; x=1725971422;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RFzyvgfY8c6IcdQy4tKyErKBZg8IMW81gHDJ+gljST8=;
 b=tbrn6SzP0qixT9L2iUoE9jCA3luGug6bLQv+ZFqdKAjVdtWgqr2w6+3w11/FbkFATd
 MO3TOrhdooAokLMu2g3DLgsF7kC9YOFcmOg5cKKjgmwqcMgFI4y9IqwOueRVLemk0+wg
 aIuPd+TOgKy9adrOxAwpqPZvgb252/GLA4jFd2seAXNwqUGxgbVNQaiBD0m7BG7EFGxu
 dkfGqIMrAVt77haX7pLskLmFSfLWrPwwp2j4ISK43Hv6E/pWYMqx1j/EXFuNHUnICK+r
 mUXltSeWdPPz2XHnk82RdyTA8G6xuAQoZS9Yj0h19ujoVzoMVg16ji8Z2jZs00wS4MjH
 21bg==
X-Gm-Message-State: AOJu0YwZ0exJEd+Fsd+PwkrEYQ/x2oirCNvMwt5LuwZyeYJ+po+xYmYI
 zOynavkUXunZQ7U1oDOuSIs6QFJDP+jaTNU2WxRUyyrL63IDKripv7HxmxIbJ419jr7iCJK0DLs
 9fvk=
X-Google-Smtp-Source: AGHT+IFNtNUxcVnEw4xj6fnYUKsYyV3bbyusBOK/9Oo34F2UEJg8RpwEmd4ylWOAoYFEpBdOU2s71g==
X-Received: by 2002:a17:907:7253:b0:a86:7b71:7b77 with SMTP id
 a640c23a62f3a-a89d8848dfemr590741466b.44.1725358920109; 
 Tue, 03 Sep 2024 03:22:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f62fsm665523766b.63.2024.09.03.03.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 03:21:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A537F60A67;
 Tue,  3 Sep 2024 11:21:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
In-Reply-To: <CACkyd_YpxVdGC04cEEPr4O44P+FQ9P51T32AtBxCmOVV1b9f-g@mail.gmail.com>
 (Elisha Hollander's message of "Tue, 3 Sep 2024 10:06:03 +0300")
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
 <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
 <87wmjudwyp.fsf@draig.linaro.org>
 <CACkyd_YpxVdGC04cEEPr4O44P+FQ9P51T32AtBxCmOVV1b9f-g@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 03 Sep 2024 11:21:58 +0100
Message-ID: <87jzftdol5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

> Sure!
>
> `build/qemu-system-i386 -plugin build/contrib/plugins/libips.so,ips=3D1 -=
display curses -bios bios.raw`
>
> Also, I just tested with 9.1.0-rc4 and it resulted with
> `tcg.c:3167:remove_label_use: code should not be reached`

I can replicate but it seems to be an edge case with ips=3D1, try a higher
number, even ips=3D10 doesn't trigger the crash (but 10 instructions a
second is very slow to do anything).

  ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D1 -display no=
ne -serial mon:stdio
  **
  ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reached
  Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be=
 reached
  fish: Job 1, './qemu-system-i386  -plugin con=E2=80=A6' terminated by sig=
nal SIGABRT (Abort)


>
> On Mon, Sep 2, 2024, 16:08 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>  Elisha Hollander <just4now666666@gmail.com> writes:
>
>  > But for qemu_plugin_update_ns
>  >
>  > On Mon, Sep 2, 2024, 15:38 Elisha Hollander <just4now666666@gmail.com>=
 wrote:
>  >
>  >  Just checked with 9.0.2 it it still gives the error...
>  >
>  >  On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>  >
>  >  Elisha Hollander <just4now666666@gmail.com> writes:
>  >
>  >  > Although it gives `undefined symbol: qemu_plugin_scoreboard_free`. =
But
>  >  > probably I messed something up...
>  >
>  >  Are you using an older QEMU? We should trigger an API warning if they
>  >  are mismatched but maybe thats not working.
>  >
>  >  >
>  >  > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gmail.=
com> wrote:
>  >  >
>  >  >  Oh nice, I didn't know that
>  >  >
>  >  >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
>  >  >
>  >  >  Elisha Hollander <just4now666666@gmail.com> writes:
>  >  >
>  >  >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>  >  >
>  >  >  What is the use-case for this patch?
>  >  >
>  >  >  If you are simply looking to slow the emulated system down please =
have a
>  >  >  look at:
>  >  >
>  >  >    https://qemu.readthedocs.io/en/master/about/emulation.html#limit=
-instructions-per-second
>  >  >
>  >  >  which uses the plugin system to limit the run rate and sleep if its
>  >  >  running too fast. The longer term goal is to deprecate the icount =
clock
>  >  >  alignment feature from the core code and leave icount to just prov=
ide
>  >  >  the deterministic execution needed for record/replay and reverse
>  >  >  debugging.
>  >  >
>  >  >  > ---
>  >  >  >  accel/tcg/cpu-exec.c      | 4 +---
>  >  >  >  accel/tcg/icount-common.c | 4 ++--
>  >  >  >  2 files changed, 3 insertions(+), 5 deletions(-)
>  >  >  >
>  >  >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>  >  >  > index 8163295f34..4c2baf8ed4 100644
>  >  >  > --- a/accel/tcg/cpu-exec.c
>  >  >  > +++ b/accel/tcg/cpu-exec.c
>  >  >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc, CPU=
State *cpu)
>  >  >  >  static void print_delay(const SyncClocks *sc)
>  >  >  >  {
>  >  >  >      static float threshold_delay;
>  >  >  > -    static int64_t last_realtime_clock;
>  >  >  >      static int nb_prints;
>  >  >  >=20=20
>  >  >  >      if (icount_align_option &&
>  >  >  > -        sc->realtime_clock - last_realtime_clock >=3D MAX_DELAY=
_PRINT_RATE &&
>  >  >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>  >  >  >          nb_prints < MAX_NB_PRINTS) {
>  >  >  >          if ((-sc->diff_clk / (float)1000000000LL > threshold_de=
lay) ||
>  >  >  >              (-sc->diff_clk / (float)1000000000LL <
>  >  >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks *sc)
>  >  >  >                          threshold_delay - 1,
>  >  >  >                          threshold_delay);
>  >  >  >              nb_prints++;
>  >  >  > -            last_realtime_clock =3D sc->realtime_clock;
>  >  >  >          }
>  >  >  >      }
>  >  >  >  }
>  >  >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common=
.c
>  >  >  > index 8d3d3a7e9d..f07f8baf4d 100644
>  >  >  > --- a/accel/tcg/icount-common.c
>  >  >  > +++ b/accel/tcg/icount-common.c
>  >  >  > @@ -46,8 +46,8 @@
>  >  >  >   * is TCG-specific, and does not need to be built for other acc=
els.
>  >  >  >   */
>  >  >  >  static bool icount_sleep =3D true;
>  >  >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
>  >  >  > -#define MAX_ICOUNT_SHIFT 10
>  >  >  > +/* Arbitrarily pick the minimum allowable speed.  */
>  >  >  > +#define MAX_ICOUNT_SHIFT 30
>  >  >  >=20=20
>  >  >  >  /* Do not count executed instructions */
>  >  >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
>  >  >
>  >  >  --=20
>  >  >  Alex Benn=C3=A9e
>  >  >  Virtualisation Tech Lead @ Linaro
>  >
>  >  --=20
>  >  Alex Benn=C3=A9e
>  >  Virtualisation Tech Lead @ Linaro
>
>  Can you give me your command line please?
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

