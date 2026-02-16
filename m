Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A1E7BD8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvyW-0000XD-D8; Mon, 16 Feb 2026 05:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrvyU-0000Wk-SS
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:37:06 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vrvyS-0000D9-1Y
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:37:06 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso2781362d50.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 02:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771238222; cv=none;
 d=google.com; s=arc-20240605;
 b=TY+8s0fANZB/biVj4G7q+CysCuG9Za1il1bhGKyLv/d2TG+rth0QskK5Jr/LPlgf4X
 KHDAWVX8nHMmrgbEylF26cXu/P4Z+/T3qNz/xW+tW7GHHBh3ZBGyz3qTgFPP2OsEhKU+
 xtHhtvoIdpm2Oc7Skf2DbtEABYGsbdgjskti74j3eW559nG/4/REONAnv3mDKXHuqGIl
 WQu31UhTXNHfsqMiza9mBbu/uyTAlaVEbqbSn8n4n0zYw5ULduCXC1Qiz8TTq4WlNMRu
 JpMf6eCn8b5WK/0jOlKTdkiaN5iMBikuyuDpjcDq7DOSWwSFDgXwgN3KkHh+dJZ4Gxxs
 oPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PNFM5+6c5CJRXmjbExY3p8bIi5a/JqFYyA3oNTdf1PM=;
 fh=NGChoZ1bmBrWvMvDQXymT10GjEUEb+u0oNkbbIH1InU=;
 b=DmdZ0s3YbLibG28KtJ+eXEdieIvlnk9S7WMTh6FeWSdgDePzoS0Nxx+db3vJWAm90O
 Gg77tvvkAIRF577X4sV225se8WeaFhgysDqyYvH/y7DeVWY6/FwusEGAyR3UphXib7PD
 wJ1BJPmF1XG52D2hygIelvZT05T1ih0V3yiw2RGtUIMhP9R320xapLONYezdBCFG82Qm
 FOufRO0c3W2182oPWk/VxZaD/mpMZ7ewkIDUu0ltwlvwIpWStdOfhplOhqFJQtNSecAk
 n+kdsOx/iEogqiO8ZSeLlDg6i9KnRo6zEN3QizioEF4b00s67RoaId2fhwE/YwpwcSIx
 tisw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771238222; x=1771843022; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNFM5+6c5CJRXmjbExY3p8bIi5a/JqFYyA3oNTdf1PM=;
 b=H+iZzll6bY1AWkolcQNb763j1DUxjQKX/9vyYcQyVoL9vOP3VTq3MbdpB2urH1EKLA
 KcE63lKyoFmQ4+q2IzD9HJpr7OTXgzcz4WxhWH6aArxvA61oz8SWAPCnAF6IuLMrYJHB
 DEwBHnySqVOo3fsezyAycFgbAx9dJC7o3AoTquI89fZiexnqt5WZ+cvC5uFN3/YJvtn8
 dQSR2TQd4lN1gs+zu72ogiG2kDrMogLrW/3/Uri/jEso97oO13ATeqsKRcMG5JJ2xLgZ
 zYrIJfJuP7Yv2g4wOqsvk3u1WFS59wIL4mLg+3vgn7RmGjCmfBD7ASh9RogGCba/+wOE
 I6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771238222; x=1771843022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PNFM5+6c5CJRXmjbExY3p8bIi5a/JqFYyA3oNTdf1PM=;
 b=sWIyQtTqvBD4cm+5S/92gcGic7HmQodCuOV2QQeOR9amLd4ABJOLagzQaxINwCvBor
 RnWmGrWIW/CE7hAGW/H79jCfuJClDicIDQRFo++3WM26w+yFG/1pT/34Hgm1TG1wxq3b
 4OpC4+qVijw4ty66Rs0cThiMtp5PajLxcXEiYnEEhFGdvKJoqw3uEoouUGbfSWMZVSz4
 Oy/UL5FFGYQHWah+x4gzWaAw5bXmFvXtYChlwhPnq86O0/Qvhws6NJZH+h/C9dO9bDnX
 5cAGcDjd1aqd9k25ge9s1IgxWYYCv31pJiyA3Xs0HlVKm2thA+/fSIGsy/vx+UGXk8BD
 8/OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcL8MOaJvsFuqUMvpoWDAMV55yoH9Rag4RYb49BHzCGxpKt47IwC/D1pwWyq2JZTgC7UMB17r4Pdk9@nongnu.org
X-Gm-Message-State: AOJu0Yy8iIMDo+foUFXhvo8ngX8JXiDSJCsQF73O90X+aQGVyHXwuJJP
 uIbG6JeJGKYcBmOEBpxtBWwHo7IsMkAHGqvb4cRAiTBL7NzDAyRhXmHHKVmFWR3fwHpbIlKk9Np
 SVWjcsT7OOBqUuKOC63vJiM/B88Qd9hPxcZ91sGdpYQ==
X-Gm-Gg: AZuq6aJ/gckZX8h9FUwODhotFO3EDzB36FHDrIOyCuN9S06mQYohLL1mrXUgfyyIMVH
 AbawL6lSaaKwtlmpLLHMzHtJ1sqT3vCC2tJiQ8tm5ztAIOSzrFKaPC7YQf3vGsEjuVk//niN0kd
 TJHmOsWxvKxr3po/4lSjkxeILagC8CbkH7BmTbst17b3MjYW2lYtYA3Z4jALkrNPSfNB9i05FKW
 AdR4VjkOW2qjJiHGlBIKu/tN7d+/H6/KRy++Et7CTNxQgRZpD36szSeco+J/5T7mlIVcWcqoLe2
 g2jsd8NYdfTKHJhghf7FXjMFyQVlSCpCrSHv7yHOZhDPLHI+dQV+FcJKmafiPkWgrBk=
X-Received: by 2002:a05:690e:4196:b0:64a:d8a7:10ab with SMTP id
 956f58d0204a3-64c196ca092mr7148795d50.0.1771238221620; Mon, 16 Feb 2026
 02:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-3-peter.maydell@linaro.org>
In-Reply-To: <20260202133353.2231685-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 10:36:50 +0000
X-Gm-Features: AZwV_Qh5IaWmpdWSKuuluBDTjBAfoDJ_U_nOJA82vaKyeF311NPaVq9yHKDKG8g
Message-ID: <CAFEAcA8SNQGp+96ZWTqcss6za3ibtQRSf4cA8JKfusfz17yyJQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] target/arm: Report correct vector width in
 gdbstub when SME present
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 2 Feb 2026 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> Our gdbstub implementation of the org.gnu.gdb.aarch64.sve feature
> doesn't account for SME correctly.  We always report the Zn vector
> registers with a width based on the maximum SVE vector register size,
> even though SME's maximum size could be larger.
>
> This is particularly bad in the case of a CPU with SME but not SVE,
> because there the SVE vector width will be zero.  If we report the Zn
> registers in the XML as having a zero width then gdb falls over with
> an internal error:
>
>  (gdb) target remote :1234
>  Remote debugging using :1234
>  /build/gdb-1WjiBe/gdb-15.0.50.20240403/gdb/aarch64-tdep.c:3066: internal=
-error: aarch64_pseudo_register_type: bad register number 160
>  A problem internal to GDB has been detected,
>  further debugging may prove unreliable.
>
> Report the Zn registers with their correct size.  This matches how we
> already handle the 'vg' pseudoregister in org.gnu.gdb.aarch64.sve: we
> call sve_vqm1_for_el(), which returns the vector size accounting for
> SME, not the pure SVE vector size.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> We should make sure we have agreement on the gdb side about
> the interpretation of this bit of the protocol. See this
> gdb mailing list email:
> https://sourceware.org/pipermail/gdb/2026-January/052056.html

I'm going to take the cc-stable line off this commit, because
we're still not completely sure we have the SVE/SME remote debug
protocol nailed down, and the one case where this commit really is
useful is the "SME only" one that we don't permit in the stable
branches. So I'm happy to put it into current git (with the
possibility we might find some extra change is needed on top),
but not to put it in a stable branch right now.

We can always backport the commit later if we need to.

-- PMM

