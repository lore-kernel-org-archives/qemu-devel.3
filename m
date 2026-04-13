Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259C9EBFD16
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCfU-0006NZ-4B; Mon, 13 Apr 2026 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCCfS-0006NL-Kz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:29:14 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCCfR-0004LU-08
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:29:14 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651c5d525f6so684777d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776068951; cv=none;
 d=google.com; s=arc-20240605;
 b=JFjxRqXp1lyaPyFYdXjaiYdWlVY6dcovsB62UbUVhLeIA+cAsHAnPnga1cdiL3EyG+
 rJHSN8nGWlgCuhUR4rGntQSYmj86ZEBV9Xjwy0INuHUujoOLZwpBIRVeDrFZ5WfC3O9e
 oV1WyBsQQhgFqqeEBTak45qzX4yFUs9SrH/46pg2Zn+Q7wKcJu8wXVEBQ2v6yfyUOfrm
 nR7lLCddv8FrlzGTIyNSOloX33BphtfTqMFyYu5bcLI4hJw/KJXE39BkFTJ4B862OfBl
 ry4jG3Jlh/bsVjQcT2CJffx1MbeyKcY7O6KE7fCAx1PhyUIppCLIPcSlmMCWzYJVqZ40
 TJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wJHI8y+gDWp24u4Gzxo0uGkKfnREB0Tnfr2nLhsLAMY=;
 fh=y4vOU43ih2rnM3bJhr7m9Sb9w8PrXRGcW2u/bhBVBTs=;
 b=KACcjwoB9TNWMvP2SDPtxxkzL8qIHFh+ATsn8z3HqARJyKuN3KLQGONUdjtvhNh774
 jLqtXuthge78eFH+kXtcFl/xSuSzQqMzZw6/L67IUyAYqeGCDxiVaJcahSvrRC/A5X4C
 toufKGowzloxhLss8Ngm3X47Sk/jZl+lOVzfhGfzFRnaT8Np6/an/zbdEOyTTblPLW1K
 46FI6qr2WjLZD7mM2RByoQuI9rs9zskT14GZXxofD7SNRY7CiJZ3VA2/wIiG1KxrO5cW
 NdxCiYl4pxGcQnuV6JoscYNjMFHrXiNPka8IQJQWgUvbtLEcm1FSa2rsybLI57/u/XgK
 C7xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776068951; x=1776673751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJHI8y+gDWp24u4Gzxo0uGkKfnREB0Tnfr2nLhsLAMY=;
 b=wvQLYBNcXE8uMk7uTTbSihPUqqsS17+k0lZRIjpbKbT/DZs/3gshzgAACMkN4k4igk
 X+l5s/kX1jt5b8RqBjL/3XPJjKgGMeo27sRMU5VRqS2PH0cpTpnhZhasp2J82EesE/PG
 RYGp7t6Ue8KqJGH1EU8vfLUH8+xVvrI4ZOMm9kA7BKvQM+fo4cwrjQq7MoVHpaSJL4Jm
 bHuDwCsPLuuv3pmHOU344kxEx+N5U962J0jdOyXw6ICTjrJimzjcXsr+CZJ818pcd9Cw
 6ARvXeq9oeJwaBgYXH1YE4LmFzcHey9iAV2EvjDeS1RYk0n50XmcHXSG2iXanyoxmvWF
 MVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776068951; x=1776673751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wJHI8y+gDWp24u4Gzxo0uGkKfnREB0Tnfr2nLhsLAMY=;
 b=ToVJcmcR+F2s54QYlyDCWzr+KdB3OY+c01ypcpIsUseeCN4MWljr9vwRfdu1WtywhQ
 h0TWBWjOhDMgHZ82C+0xJMgHMmT812mfsbfUEOlo3kAzhvdQwkp5nUe711OajOEw5Cwx
 pW9WrrfNyJDR/495ng9Avzs+c5+39kvstOqmG0WXJatt5RBnquM942Nq+At4vIZshar/
 FL9Z3nHT3MrYJJDf3VXLsyTmtYseWFP6iyZpdXLSiywQDHayTBGnsbcEkWUXAwxrrXtv
 Xy37McmZm4DQJuQ/KKqOceJH8l9WCwBtHDnnn6zh2kcRRQcCsIOy3f1i4CKSMKtpLmAG
 cNnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ns46AEGblU6eOXG2uBL4HriOGQ8B5uUTV5m7e2YXKlGWpyPvg98vkgqRYXcywT5sP758zqivts5T3@nongnu.org
X-Gm-Message-State: AOJu0YyfVrYvbBnUjqTHy0r0LF1Xccv0ECMtAsNG0NnwVv8yKSlyDNA2
 v5RFea0GRe4amPwX1kWbKfKj9bGcNT2xEsvvvzxm37hE3ekJiZ9oAyMGQ+c9Q3167ln9XYbCpOT
 uM6h9oaiw4Eaxsndc6MZSkb50NeBfZC+J+MK5mKfFiw==
X-Gm-Gg: AeBDievb1LCaLTbHL5Ez56ApYkDhmGq4nRkvorBmppjmlKkJQsedA19YQInR8KzaSaZ
 vcPChcRmrnRhnvH5OGN/yvC/RkRikvIJScmMUFmTBn0bOod07LfFM1MLmXnA5mByYjAPxpTgWw8
 vnmgMR0LlSt3+yewxB3impVqI/ruW4Y0PoDJidJq2r4Qrdk575mduK52s2BoAf1rq/5JbhC23uw
 YMlxTMh/PFD0XqPcHKdSG4s5FqPj0ZTrIWBBqEgUveXYhV7EeJRW2IbEBWcGZCXoSrMm6gEI8ub
 bpfJUte9T3CypHguSn31ULBRVl4X8VQ0xSV/Gvi3IMRZ1nWDvgaSNbw0ofJY6Y/Ou64=
X-Received: by 2002:a05:690e:4196:b0:64f:fa9a:9017 with SMTP id
 956f58d0204a3-65198ad042fmr10837945d50.28.1776068951415; Mon, 13 Apr 2026
 01:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <adGTUNUSckx1KrAk@p100> <adTVobzrgl8f6chd@redhat.com>
 <87qzojgvxn.fsf@pond.sub.org>
In-Reply-To: <87qzojgvxn.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 09:28:59 +0100
X-Gm-Features: AQROBzCIqDJMKj6pqPCitGOmDkEbcFmgpVJeRovfMIiGbb_EQ7G30fjlEPsL_Vo
Message-ID: <CAFEAcA8Zk=fBUZ8VFGmfROgF3dRsxBRHUT_4YCBBP6OGU=X4XQ@mail.gmail.com>
Subject: Re: [PATCH v3] Allow building qemu tools on 32-bit hosts
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 13 Apr 2026 at 08:30, Markus Armbruster <armbru@redhat.com> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Sun, Apr 05, 2026 at 12:40:16AM +0200, Helge Deller wrote:
> >> Qemu's tools like qemu-img are often needed on 32-bit platforms,
> >> although the actual qemu emulators have been discontinued on 32-bit.
> >
> > IMHO, the thought behind disabling 32-bit builds was not making
> > a statement about whether the code was useful on 32-bit platforms.
> > Users of 32-bit platforms will naturally always want to have as
> > much as possible available on their platform.
> >
> > Rather it was that 32-bit platforms were no longer considered
> > important as targets by QEMU maintainers. The goal is thus to
> > reduce the set of targets that maintainers have to think about.
> >
> > Thus the commit message needs to be justifying why 32-bit platforms
> > should still be treated as a target.
> >
> > In terms of the impact on QEMU maintainers / subsystems we see
> >
> >  * QEMU guest agent
> >
> >     =3D> util/, qapi/, qobject/, qom/, qga/
> >
> >    Total about 300  C files
> >
> >  * Adding in tools on top we also get
> >
> >     =3D> block/, chardev/, crypto/, io/, authz/, storage-daemon/
> >
> >    Total about 700 C files
> >
> >
> > I'll support the build of QEMU guest agent on 32-bit, as we were
> > clear that we wanted to continue supporting 32-bit guests in
> > general.
> >
> > I'm not in favour of re-introducing 32-bit support  for anything
> > else.
>
> Neither am I.

(NB that although I did take this patch into git, I did that
in order to preserve the status-quo for tools in 11.0, not as
a final answer to the decision of whether to support tools
for 32-bit.)

I think if one of our major downstream distributions wants
to re-add the 32-bit tool support then that strongly suggests
that we were a bit over-eager to remove it. 32-bit
emulation support is reasonable to drop because emulation
really does have to care about the 32/64 bit differences and
things like atomic instructions get much more painful.
The emulation parts are also by far the largest bit of our
CI workload.

But the tools should be "just normal C code" and supporting
32-bit there should not require anything beyond the bounds
of normal write-portable-code concerns. And a test run that
is only building testing tools should be a small part of our
CI usage.

thanks
-- PMM

