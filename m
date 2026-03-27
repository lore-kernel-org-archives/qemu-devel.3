Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ADD10ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67hj-0003xI-VC; Fri, 27 Mar 2026 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luismarques@lowrisc.org>)
 id 1w65LT-00019V-8B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:27:19 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luismarques@lowrisc.org>)
 id 1w65LR-0003Z1-59
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:27:18 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-128ebee22caso390887c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774610835; cv=none;
 d=google.com; s=arc-20240605;
 b=gsnuxeXibF/AZL3PkfGWDr79qlCVZGFOq0EUjRukp8diGrmR12+bZ/gv2CQQep3aYT
 yBsGOvPEzsfeyG6XlIdit3bBNg848GJA0eS5j5jwN2VFHP1Q3YlGZ9s/6gqjBMIPtd74
 pJKCEGNgu7GBo7Z4Jd991R6AO3ZzGAEC5kT+1PlOYI/jVClR8AmvK2JRjJgBW0HY5OI3
 idJv7jYKbhuW2w93wuusY5DCC6jPmTDYtb7ZEsz/d2Fr/9DAepVsjcsyLy3PmzK3rVnn
 NVq5O7LL9pv+SEEU/EQFeBMjFoYuPOi6xqrviZjmo7D1Tju7po5LvKi53neoz7K/nKQh
 wYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bsTF+HxqqJSpCl8MmNmXYfPCBW3g6K5jK4AdsusS9qU=;
 fh=nFHkkH4Ez1wM07gueqRDJsWKoXGvZJmq62DwmJ57DWM=;
 b=K25TjRRyiTlTkcdKh2VzjafahPLiRo+ldnTo/R+rttWlJfDUOAowN6iWXayml8R8ts
 0MJlTJcab21vBVO1d0L3HCGUfcrc2Fg9cSm36nAfLg6YgZkEpm85teqG7vBVXVNRlEck
 oOc6YyqMC7SDYw86GXyfzFlplEWinJj48Xj0eki9xZbWEiENCWzOKqEd4EpYRyKG3wP8
 hqMazvDK6jZd89f/plJcg7bCdtBgC/joE+w6f14rh0bAXVUOm9bU/omIJI82VZTg8Vsb
 QSjwVB+GN/96NRA0WsbeFoGH8r2h2esm/fX4z+FllMjni3sSWnvg3ywPqEAXTULVAIVg
 8/IA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1774610835; x=1775215635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsTF+HxqqJSpCl8MmNmXYfPCBW3g6K5jK4AdsusS9qU=;
 b=Nl61UN1HPAUx17eMeLcSf1FsBBl8civdOOvJz5m0KwZq0RCzW3cTrf3MXbirbkztAb
 zlYfHiIq9P3aCx3w+1ehisNqEz9hafy9P9UTk9WZS8hA5dC81UyfdKoQxdxMmdtoT0lI
 OyxqSWVuKnqQEr2vrtHtJgX58vzaTfzXAwmACtjbmbW5a1ambbqn1H0SN+PXa5SXUmFP
 5oC1P3DpDUG6qn2grG78mZPeLH/Jcq5WX94z+/hrXbtoDqtXr0j+u8Pdy4Ow8eCyZTQ/
 SmLCNuIF5yockTR9dRyd/oy/alt1jB19s8I9BsuJeVx7DFZ1zNAvUF8tK6zY6mMwSwHp
 uwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610835; x=1775215635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsTF+HxqqJSpCl8MmNmXYfPCBW3g6K5jK4AdsusS9qU=;
 b=WnEZHemdPHHkA1ZldKGNc2i6nxDkZ2ExkYzEQ5R9zCGAXgkHTKqOUdSt2kDS7W/jiT
 4GCr7Ds0M4ieg8OfS1ecYXQx+rJS548StzNdyoJvybSGCKsclOQAaqcC7c1OHuTvKDBM
 feyUzd4ED562QpQORWrSUq3jlzpCMYPhwCIBvFZfEyQy8piPOHXiE/2bO2qYTHPsYB00
 rDsOzAZ1FBnb0RJP30wV+Fn95lgZHIWuQV/YoQK7ljqYlcs1LwPoVyAXptzfUwu5tXA0
 cdy5DUun8NFm8WrXn23JNAvTpLBRluhHeH5hkVlICCMV+vl+wF75SM0LdVP669OlcDy7
 HGbA==
X-Gm-Message-State: AOJu0YzWidt3BCNqrWULBGLSAPym4yrUBkwrEqRvnpr85Kk7ZWSTRhSh
 tdM3H4HZ/nPaLp21d4X6RnCKLa3Kkbrwany7LTC5ditABwvMWjWPljV2JxmaRZlJWnlxfJFK9+2
 onJ1OTM8GlJoFZ5b6zs2qM0/GCt7vSSgHJEl33erVUw==
X-Gm-Gg: ATEYQzymZALlJQaSP3d2qI/XY8P5q3kMrU1v5g4vzVsULmomdRpNym4uEZPI3ttf/LC
 M+2vY/sJvuU6QD3ySDt2QYutGqMYG2nHYDzi4x0rjpoNXglQsT5fmEAn/dOWPxwB4lGHQl4rqLj
 vOoHgoJzqMBpmqZIDJannfkqVubSaB/cQvlsPgYEIXFARNTrQz0B3qx3daBnBlDO5I1hKOksnz+
 SzL08rIliuXfxOMAtKnnUEiVia2o3tSo89jA6nuk6OvSY9toWge9mf2Qj0ge9pWeOHYqDp59o4p
 wT/nQQ==
X-Received: by 2002:a05:7022:624:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-12ab28fcd2emr1069414c88.31.1774610834616; Fri, 27 Mar 2026
 04:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <177393172713.10003.9577410064303581086-0@git.sr.ht>
 <CAKmqyKPPeHOoHoLJhcf85UPrE=sWxjTrW=njz_pQ-+h8+3nWnA@mail.gmail.com>
In-Reply-To: <CAKmqyKPPeHOoHoLJhcf85UPrE=sWxjTrW=njz_pQ-+h8+3nWnA@mail.gmail.com>
From: =?UTF-8?Q?Lu=C3=ADs_Marques?= <luismarques@lowrisc.org>
Date: Fri, 27 Mar 2026 11:27:02 +0000
X-Gm-Features: AQROBzBJTeD23oxwi33XpiNUSHdoIo7-79KyWRvQmLs7S2fFPT_erA7AD_z0kXk
Message-ID: <CAPhv3nrf1=miF_cwbAM2AZKSGkJCFgk=3crjaAJ3AwttvVBytA@mail.gmail.com>
Subject: Re: [PATCH qemu 0/1] Update opentitan uart (part of supporting
 opentitan version 1)
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-maintainers@lowrisc.org, "~lexbaileylowrisc" <lex.bailey@lowrisc.org>, 
 Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luismarques@lowrisc.org; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Mar 2026 09:58:15 -0400
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

On 26 Mar 2026 at 02:47:48, Alistair Francis <alistair23@gmail.com> wrote:
> So it's based on my original GPL code. So I don't think it can be
> relicensed as MIT.

Hi Alistair,

Can you please clarify that?

My understanding is that QEMU, as a whole, is licensed as GPL but some
individual files have different licenses. Looking at
https://github.com/qemu/qemu/blob/master/hw/char/ibex_uart.c it has
the license text from the MIT license, which I interpret as being
MIT-licensed. That was also the case when Lo=C3=AFc created ot_uart.c based
on ibex_uart.c. Is there really a relicensing happening here? I
thought we were just keeping the existing MIT license.

Lu=C3=ADs

