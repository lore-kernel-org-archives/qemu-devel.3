Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5ADE7E364
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8baJ-0002uS-HY; Fri, 03 Apr 2026 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w8baH-0002tY-Nt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:17:01 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w8baF-0000Kc-Vx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:17:01 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2c4db6bca03so900876eec.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 03:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775211418; cv=none;
 d=google.com; s=arc-20240605;
 b=juLYeVC6dlH74Sc1HmiWo1+H0wh2f0QrXLwT6o4MIfYkrVYcpG5Oa7XrviT+pc9iep
 rZ1Tmvb3xbJhdIH08NNtiRCHIrO+XcaosTefIfVKJuyt6Njln9Q40HYO7GgKTTjw5y/E
 F7wpNJqZ+CusKdt2U7j1euqCnVGLZN6Io9PAi7JkRwcQ9UPPbL6hRBC+VnxurmwD9al4
 6fVAmrWRhAdRyK3Ul/6ZdmfOGzDM0ogYLcxzH+a14czQnBLiaortCb9//0fkXEOtveFq
 aPujXQwU1wrB1huzwOwww5nwCFzMF/5F31AIK8YjFTSTvjUhiR9rhD2rQY5RirGZVjW9
 5ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e2KbeJKI8GcLwgfNJdgfMdr2lrfWkvvxka1iFwz35jc=;
 fh=pljgQb51SI5T8fJjT4f89PH4vuf7hUTqYcKOSXi3vR8=;
 b=eteOHIbsVpwlesE1VojvgIVamLYfK0wI19BlY00o149loWYPhX44t+XjTv0V4Q7+H/
 NkfQsG34BLxFlwCF73bGSnhAm9qRz825vDepV7Db+9MNeTnDS4o3fqe35NzzQOpItrG3
 2z7lgzdYBrQmSUld3iuZbuh7Si3B5rBHdxoPWkKTfyJgIJdH7v5ffGBJwtwl+hViOJQs
 EfZHKF5YSsJx7X1nRQRfn5voTyA2KfK+7Ca+F6wVArlcIlRtCC0tuvf9NBK1gbqg7nZ/
 kSwvZZehnm5oIOqaK11Gr5lDRahbiQekWleuRTwvIdOrM+tKrTGX1l9JFoW5xihhl20V
 JTZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775211418; x=1775816218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2KbeJKI8GcLwgfNJdgfMdr2lrfWkvvxka1iFwz35jc=;
 b=bPOVMyPHvhjXXrvOupgnmzZHWv2+EIT6iOohqLwxLbX1EVaPcIAjoGld/5k7BZHBFB
 MSyq7h0IzEvd/CAjlpyrEiHq7bg7y6Z2LpSb00UcmF2UZ9xfpSbsHvfyK++Urk9Vfs4z
 bDIakzKJmohEnuogD+QXxjZ1vzbAFPsuPiJbL7yeFoXkcGsRB2a0f9PVuEruBM0IDkeN
 InxlAOUjLarYyyMxTNesaFhQHP3yP1T6Ffb7MxOkAR9YcMn8XHhplACvfgiu7NfgoeIx
 ituaKqU2rb5uhtCYwmAMTd/gW6u48Bs90sjbXb3edum7p9mzXneeB9B2fxF+XuZHF2Og
 nLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775211418; x=1775816218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e2KbeJKI8GcLwgfNJdgfMdr2lrfWkvvxka1iFwz35jc=;
 b=MvnzEWGi4KRJ/bXo6137fh9746pCuu8mDITPjANP910BDrfDpWGWHEoEXSw1CPs59O
 +RKLz4kEhdcvSW7fWmgiO6sC7eWB3ndk8f8NSY5v7JJa6GGU35VOc3hY4q4i7Ynzl00k
 AOocSo0cYSlV8fNJ90HDZhGZGW60/znCF1TpJr1/sPpeDQbtobYJRcK1EnSFrfjQwoY1
 hjdT5qlqx8T6Z5cCzm2rSzrtpptv/lOXdPIxEAZ5+V9vucYiz7wT3d0P/U2gTxbtLZEs
 DVIoaHaIzZwMdlBWk6auwOnrZCCSI6kapmubCKfqpduNh+OAP76121L2iUFKA3r3Fujr
 foGg==
X-Gm-Message-State: AOJu0YxLTexWOPyk2hdwBdECxxCFjTKuQeRnQIdNz1nMWVbZYAPWIsWT
 EpgnVNADv4bv6lw74PeW9XkQpJ94DU9TIoERwUCzSW6Yx5Bef5RVrWUrTCjTMF3aa0RCMDppUjQ
 72+k7RLJMTE40JJrr/Cb4LQaPtlx/LRE=
X-Gm-Gg: AeBDietMqbm8bGkN7ZmDw7G0/HP7g6byicgEmyLjGDWVXM4hq1qhVUrSIQy9bTedAam
 Ed0E+4FwWHRTfvB1cKJ6wi9HPGbs1Yi94EwerqbXwM3DJfZCRR/1L5G5ZTvA7iitdeaXAc1xkgE
 hyjLmkTjzAmXwqFzTuHzMNosRQOGUDOHMy1NQH/uVlL/ipVFs14qlNVivlDNzkdShuUCt6udYTw
 AHNIfgACVsd9F+djUXh8u0i9wvA7DcxOoAAqroWLZBHk/XcC1nNUh0l8SR3/T52VapAtO7O03vA
 Bc5uo2IujbuVOga5GDWEhwDUrZ06VeVN47jWnjk=
X-Received: by 2002:a05:7301:d17:b0:2c5:c532:1fe1 with SMTP id
 5a478bee46e88-2cad60cb61fmr2384701eec.3.1775211417574; Fri, 03 Apr 2026
 03:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-11-48eb1dcf7b76@redhat.com>
 <878qbgpj31.fsf@pond.sub.org>
 <CAMxuvayGCvJwyUgrHSGwfLhqAbVC61dEbgbL4Ji_0YQHyv4LJA@mail.gmail.com>
 <CAMxuvazy-_DjAVJN2=ie___VxFMKGyLkEiEP0OBNbipN1nxoSA@mail.gmail.com>
 <87se9dtoit.fsf@pond.sub.org>
In-Reply-To: <87se9dtoit.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 3 Apr 2026 14:16:45 +0400
X-Gm-Features: AQROBzB29Z8xHczePYGgJKPxTONye8B18uXejFJ0NjVev5ADq3mjMvxmKLxlOkM
Message-ID: <CAJ+F1CJEbL+pT984L9c3rs0CMtLoMK+uUi8fhvL5cC_M9tdNvA@mail.gmail.com>
Subject: Re: [PATCH 11/60] ui/console-vc: add UTF-8 input decoding with CP437
 rendering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, Apr 2, 2026 at 6:40=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi Markus
> >
> > On Wed, Mar 25, 2026 at 10:48=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >>
> >> HI
> >>
> >> On Wed, Mar 25, 2026 at 9:35=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >> >
> >> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >> >
> >> > > The text console receives bytes that may be UTF-8 encoded (e.g. fr=
om
> >> > > a guest running a modern distro), but currently treats each byte a=
s a
> >> > > raw character index into the VGA/CP437 font, producing garbled out=
put
> >> > > for any multi-byte sequence.
> >> > >
> >> > > Add a proper UTF-8 decoder using Bjoern Hoehrmann's DFA.
> >> > > The DFA inherently rejects overlong encodings, surrogates, and
> >> > > codepoints above U+10FFFF.  Completed codepoints are then mapped t=
o
> >> > > CP437, unmappable characters are displayed as '?'.
> >> > >
> >> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
> >> >
> >> > Have you considered the decoder in util/unicode.c?  Do we need two
> >> > decoders, or could we replace one by the other?
> >> >
> >>
> >> Oh! I missed it, I should definitely try to use it.
> >
> > The vt100 receives characters one at a time. The DFA is suited for
> > this. mod_utf8_codepoint() works with whole buffers. It's possible to
> > write one with the other, but we lose in performance, and we need
> > extra quirks. I don't think it's worth it.
>
> Implementing a buffer interface on top of a character at a time
> interface should be easier than the other way round.

I tried that, it's not hard, except we need to handle the case where
the DFA rejects early but mod_utf8_codepoint() should still consume
the continuation bytes.

>
> I doubt rewriting mod_utf8_codepoint() to wrap around the DFA would slow
> things down materially.

Quick benchmarks showed -50% in performance.

> I'm not demanding you try that!
>
> If we decide to go with two decoders, do we want a unit test to ensure
> they behave the same?

They don't behave exactly the same, as explained above, and also the
U+0000 case (btw, if you could explain what we need it for, it's not
obvious to me)


--=20
Marc-Andr=C3=A9 Lureau

