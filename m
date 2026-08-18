Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31822C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPIe-0004q9-H7; Tue, 18 Aug 2026 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwPIc-0004pG-QY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:16:38 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwPIb-0005VA-DL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:16:38 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8200ca16f26so4084897b3.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787080595; cv=none;
 d=google.com; s=arc-20260327;
 b=nnyF+Y3iSHjpWOC+0dFfRiO9/YPaE5WdTiWLwbO1Z/ZfpBdThnGEe83QDdLjz+b9ip
 TF7kRy1Ua6E4qlQA+2vgjCfFcr2Gwvsm9X/ap7sUTbiTHFcxYito+eY+FuhnB+EIGtjj
 d1ejRndZl4xqLhXZ6vZuMz49VQBJ5Atd9rKWoRn1MOLhL7GvoKr2hmAkUZ3lcuoPQucy
 ux30bWq/YpyKeQHeVx4C85d4c9DRPfXIrcPpVP+rh+wD4Y5Sr7T4y7qS0l2R0Gmehuzl
 YAEAHHJ2SVI3H8pZzOXFQCwzY27PXWiswhpfva1GegpOH3CIsFbaWMPuENpSFFQopyMg
 5sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gfo1fcQMOG0fs+7GAP6s5UlMBuoaL/60+LuEPass6K0=;
 fh=S+TFf4RlsShEBsiqu+cL9TbfUJ/AMqpSjImLM4CJ5CA=;
 b=WUruxB+A7rAjnb2JaxadrLqu2R8BoSEBQJ3zNQMdinF98zxNL8CsVbMEverYYPlhIW
 Vff4l+BvP0WdKSOck41yxWmJ7Yxgc712dwX4qTiUrh4cQs8XGfKLVPaxAjBUo61iYFPa
 twfnQxBu5rtd2Ldx7TvPvRDi1y7X3R141kx/SVO5NIgkT3ZqmTMfA63bmztgZPXjULBV
 zm9aBp8lGmMO5qcoKN/3Q8N1fUgWOW9ev+SZN4rYde++d6nrhOaDluXAmT5jf6rMoz+z
 oW521sRJ1ILKchrJ3/zrdD41UJ7gedovQg3CxqZxq/Pkcqr2jrYvYJCBPBh4Gj80wKDt
 Wqwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787080595; x=1787685395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gfo1fcQMOG0fs+7GAP6s5UlMBuoaL/60+LuEPass6K0=;
 b=rTExtmUnBCj5q5+DZrFKdbNqXYsF05tHyClH18cP6zQJK+GK5w3BuWJuS+bgmuxX/G
 atCXtS/+SBWWh/ogc9AhLozdZ2HH1NFaahpkYazsgRPIV4rZ8P68gXE1O4LxEhpWiZ/Y
 IgG6F5AUf+UHV+51JqA0zIYCliV8vmGC/v7aN7ztIC94oe5NnVqbK65gpKgZVgIppTOt
 Q0al1zDccKzF5L0J4c3N/ddeA0yKkC5JRNryRXnnedjyg6/Ihbj7/SJ3IN0zPq28tbTD
 qL9DLJ464Ni0EehJV14cm6eh8pzpSXMnhdW0oJbRvQLC0Xesayp4r0F+SdMKcGUF6S/9
 4t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080595; x=1787685395;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gfo1fcQMOG0fs+7GAP6s5UlMBuoaL/60+LuEPass6K0=;
 b=anJIipRuRRYzLsDL8WXKXIia3b3LlByUb1/Iy/C3ghdQFdk2sEUr5xnPgCc9iKtgP1
 aokeW1xSx6fjn11525K/ftWa5jU50KM2zM5Sb4W3BXITjh7y35IXlkkyBHyMIM0liwe5
 upX8Y9ky6nksrdelYkQPYxqKlzeJsFxUoXf/wmcR3hNhxOvGT+M+P03Aj59YyDJKnUSr
 /h8dqZ01pq0TFEB+LxNsUoU1QTFKoYbPj8c/7rTtqIh8Ayn/ALOqYHDMoOWwTsM0Syn9
 /HKeB0QEuBmaaR830qDsQMptxadi9q5/Ir6ON6m4bZKg1ohjEpshUgv/jDXzCh90IrUj
 ykxw==
X-Gm-Message-State: AOJu0Yws2EmjKureODG1FXST7A2NT6JZaoGNus2l/nuNMSRQAv0NOrSg
 6tSf3YVOjFaPkTIJ7/119xjOfG092uRQMGWTWgLnSOxqZmNAKe5VXNPLvHVcqI+3dNQhcJyF8Sd
 mC3IjLfteBmd650YaXNxrueme41IcSr4=
X-Gm-Gg: AR+sD1348wB9pS5kmwZB2e8AmKleJACbdSLlQnqWAH/ZUfpL9Nf9y9EP3Yl3/YNM/il
 WBb+xhW+0ylUDTCkM8TOtOcLYy01Rtd1dG/rG022l6o0qDgeyyOhFe9jHF3kMiW0+Q5fIVaCgDf
 af2r4zuEsY9hMgWtM693a0CrR6ruyyGkU6E/W8maLfv4N2aJIUeTef+G5stD8BXHIOytWz/K+uI
 8JrAjaoDVHLBpI8oCg7sEtSHiVG3/Pnq5iZZ5eqqpD9cizex/JL8PaDDRWBjQrH8Mnp9ZleyDhN
 BwTsWF2jihk/oWstv5tInoDnlQmUj90HFGKKLVKkesiLJ1Of23FRMHyorzB5IZnfY0xGAcap0+x
 B
X-Received: by 2002:a05:690c:30c:b0:81e:695b:585c with SMTP id
 00721157ae682-8412cd49515mr54982197b3.4.1787080595258; Tue, 18 Aug 2026
 12:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260817141559.940844-1-pbonzini@redhat.com>
In-Reply-To: <20260817141559.940844-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Aug 2026 23:16:22 +0400
X-Gm-Features: AcwNN1XvwW5YMXhVYoMrWB9w-axezlKHZiNO1hb9DW3ncIntMQJGlkIJJDlPhCw
Message-ID: <CAJ+F1CLWDU+o1jPkPtotn_LfhN=r+yKAMoyYACaM6hz4NjRkxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: switch from bilge to bitfield-struct
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 17, 2026 at 6:17=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The bilge crate is heavily reliant on traits and, because trait functions
> are never const, it does not work well with const; also important is
> that bilge's support for the zerocopy crate is tied to an older version
> and has never been updated.
>
> The bitfield-struct crate, instead, is built from the ground up to
> support const, and has much simpler code with fewer dependencies.
> Its use is pretty much the same: device code does not change at
> all, only register declarations do.  So, switch to it before it's
> too late.
>
> Paolo
>
> Based-on: <20260817134538.924615-1-pbonzini@redhat.com>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Paolo Bonzini (2):
>   rust: pl011: switch from bilge to bitfield-struct
>   rust: remove bilge crate
>
>  Cargo.lock                                    |  71 +-----------
>  Cargo.toml                                    |   1 +
>  rust/hw/char/pl011/Cargo.toml                 |   3 +-
>  rust/hw/char/pl011/src/registers.rs           | 108 +++++++++---------
>  rust/migration/src/vmstate.rs                 |  45 +-------
>  scripts/archive-source.sh                     |   7 +-
>  scripts/make-release                          |   4 +-
>  subprojects/.gitignore                        |   8 +-
>  subprojects/arbitrary-int-1-rs.wrap           |   9 --
>  subprojects/bilge-0.2-rs.wrap                 |   9 --
>  subprojects/bilge-impl-0.2-rs.wrap            |   9 --
>  subprojects/bitfield-struct-0.13-rs.wrap      |   6 +
>  subprojects/either-1-rs.wrap                  |   9 --
>  subprojects/itertools-0.11-rs.wrap            |   9 --
>  .../proc-macro-error-1-rs/meson/meson.build   |   3 -
>  subprojects/proc-macro-error-1-rs.wrap        |  10 --
>  subprojects/proc-macro-error-attr-1-rs.wrap   |   9 --
>  17 files changed, 71 insertions(+), 249 deletions(-)
>  delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
>  delete mode 100644 subprojects/bilge-0.2-rs.wrap
>  delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
>  create mode 100644 subprojects/bitfield-struct-0.13-rs.wrap
>  delete mode 100644 subprojects/either-1-rs.wrap
>  delete mode 100644 subprojects/itertools-0.11-rs.wrap
>  delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/=
meson.build
>  delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
>  delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
>
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

