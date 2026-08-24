Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF86C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOwD-0006nA-UH; Mon, 24 Aug 2026 03:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyOwC-0006mT-CQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:17:44 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyOw8-00085U-4a
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:17:44 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so3199714a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787555858; cv=none;
 d=google.com; s=arc-20260327;
 b=oMF+6KXJOHJ/AZ3/Q8nMsxYHbnnWzcluEc5EcBPtrie4lCgy4lu8t/9otALCIe4BFP
 VYHFb5ItV/0PtQz5J1ujDF7BRXR+iMah7qaOdXzzLaZlQlrwImZOuK7j8M81GSi96fj2
 zvY7efl5AOmPjSI88Mrb+LXSvcHyLAc0Lx82NJVnzBpvMEUrSSHfHFWdymXUFpryMBng
 +yFe9NUK5YLW9cpCejOE1fGTFb5mfxmsN1rNnXSLy4W7D+cV1ODflk5c2HyjQZV+ZC+V
 EjiU1V+M+GZimttGBdEQmbQ0fTm366OUxfbrtjQ6UNHgmo6sXBPgM4qQ2sZJMTzNyUne
 1DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mpPEEbA9UdYrgd5wh14VBht3tJdhjuUSena60ew66w8=;
 fh=S+TFf4RlsShEBsiqu+cL9TbfUJ/AMqpSjImLM4CJ5CA=;
 b=S0c2wbVdapgiE4AjsUrXiIMkD3tx99XcsR0EEXCkQefhD3t2vzs50DwqhgP+A6HHp6
 ParPBUBT+tpvnfevfZLvnxs6Aca7FpiU5sYVNI/P4bY2Xr7jNkuZeQCDxP5FHPX9n8gV
 4vqg7swFe8Z0Ns/95kLRN6IhDGWtKijmYbugaBZD1ADlI0cePm5nI0Xqh64AFXb/K5TO
 tTwpx21a75RjZibFRRXtnJvN8FDoVEYeuz0/g8w7XhyFh6Wx8yT1mORTreE6l+MHm9jc
 jEf1CLpx2TI1jYorOOS2xo4rj2aJmoBXpG74+KtuwwTOrzCVLnbjX6sY8hvfGzbxc2py
 xDIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787555858; x=1788160658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mpPEEbA9UdYrgd5wh14VBht3tJdhjuUSena60ew66w8=;
 b=Heowsogq5Z9GJ5uvvvkj9ktwfM1mhCfdtY9KGP+qSD+HGNWgH2EWVYT28oTnZNdDZV
 IwRGkJhafOEZx0TI2fn9mMxC+gJvJMZQWVMyWO716u3Ht1AHnLXNqLhtgActjv9qP4pZ
 fQ2/KbY9gX2SAwU4/IC6cp5bRhZ2UhDD7A6naVU7thkpbDoHx5dzU6UUWe23e5pQdTqC
 9r0MFc5qUuBdpmVqI4x68phggYHtS14jGAh7n2+zos1lWPJ/2ZA15WQD6p37z5gJDqpU
 341S2f1gU71C88cm4hJT6M7jv2IYyP9hDfW4A9pCOqKO5umemTYOSCyklz2WTWEORVjU
 TIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787555858; x=1788160658;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mpPEEbA9UdYrgd5wh14VBht3tJdhjuUSena60ew66w8=;
 b=PdP66erNVHNtM/I8HeKN5b7quZkZJ3Ik+Qi/XLttsgtbu+OhtfLycKakuxUa4WNzuJ
 yn3lmZkoAazi3s9FBgASfDCsAiVhR7PgMBqaPPVk4NPCZw9czjmnKeMGoSjcWr/kNTx5
 EdurgsVWvQtQK5GaVI3lv3eM+xA+a8Ba3y7Lpxr4zcBv3R0+C0B9bc9FIFqe1rxK8RDs
 9Ov5f6MV9MDCkDmscSPRpKZr0pTRIVGo50gDOMMXyBVYKK+jOjvg5oTT4vqDqShXG3/F
 Bdm+jQG7uJ4XwECoMOf6E8QTSo+Vu9GjfSiHFZ+vGIL1Dq+cNgPrZcUsBkKS480LKZws
 UcYw==
X-Gm-Message-State: AFuF++lramrZFYNjR31QXa0tFvz0a70+oD2aHXijjukdTJMsIXYNPFBp
 wKTxsBGOXo0ckLsnaatN/zixIBSrxf/ZwH9pEEBeiUNSThaoyXQ+MtMLP28JThURjaUtUyrjm5a
 KBfKaKIt/q6gGRZxcmhmVAnJIYfoE9tQ=
X-Gm-Gg: AR+sD11sUl5axHl5hXkQtuPQgXVWRPOoNBikc75sLjI4XUSFpwXh635nEH6QQnmB4hb
 /vpKIfVyZXQgyotj3hubaGCXYHxXL3RU0BQPpcJkDs8/RodWX7Jwnyf7FSIxtL5XtPCVp/TPQnW
 JMe0GxDNi1i4Nhtd9az9uRM+vwHv/MUN4EeG1L2FxMh7WNMAAklhUznXlLQYt+efvYB9aYL5ITB
 IvVRiA5ngay+BpXUseoKWpyY5OsgvTLooEkMeoZ8MKyfs2iZ1to4RKGf3AXKMT/8uD9ab40sGpm
 ttVvj1rk2NyHMmltCLUVnjpOGQKmMl0qYRQhTG1iIK3E5kkKxLpUUvPYgXImlN5DTojT4vi/ynD
 IhZ8QTlHRijoe
X-Received: by 2002:a05:6372:a744:b0:3cd:7bb1:1183 with SMTP id
 adf61e73a8af0-3cd7bb11219mr5903728637.18.1787555858014; Mon, 24 Aug 2026
 00:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260821083925.2008135-1-pbonzini@redhat.com>
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2026 11:17:25 +0400
X-Gm-Features: AcwNN1XJ_SV97XWkkJXgMQZF6DMMxth-kS_V5mkqVwxBA2bSWrUQCGUJeZTNRJc
Message-ID: <CAJ+F1CKyUghQ3r3aOm6zPdHNLUCCsmJWrf18qs4zuf8FfjnYHA@mail.gmail.com>
Subject: Re: [PATCH 0/9] scripts: introduce script to update cargo .wrap files
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x531.google.com
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

On Fri, Aug 21, 2026 at 12:40=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Another small piece of the usability puzzle for Rust, this time
> tackling dependency updates.
>
> Extend the existing scripts/get-wraps-from-cargo-registry.py so
> that it is also able to use the versions in Cargo.lock.  This
> makes it much easier to update .wrap files after running
> "cargo update", though manual work is (intentionally) still
> needed when the semver of a crate changes.
>
> It's possible that this functionality will be moved to Meson either
> wholly or in part.  As usual, introduce the prototype in QEMU so that
> it's clear what is needed.
>

Series lgtm, but I wasn't able to apply on master (patchew neither)

thanks

> Paolo
>
>
> Paolo Bonzini (9):
>   scripts: print build.rs diff
>   scripts: rename variable in scripts/get-wraps-from-cargo-registry.py
>   scripts: do not assume the new version of the crate is present
>   scripts: prepare for introduction of CrateSource class
>   scripts: introduce CrateSource abstract class
>   scripts: add functionality to update wrap files from Cargo.lock
>   scripts: add the possibility of a quick update of the pacakge
>   scripts: rename get-wraps-from-cargo-registry.py
>   rust: update crates
>
>  Cargo.lock                                    |  48 ++---
>  Cargo.toml                                    |   2 +-
>  ...argo-registry.py =3D> update-cargo-wraps.py} | 198 +++++++++++++-----
>  subprojects/attrs-0.2-rs.wrap                 |   9 +-
>  subprojects/foreign-0.3-rs.wrap               |   9 +-
>  ...sys-0.21-rs.wrap =3D> glib-sys-0.22-rs.wrap} |   9 +-
>  subprojects/libc-0.2-rs.wrap                  |  10 +-
>  .../libc-0.2-rs/meson/meson.build             |  20 +-
>  subprojects/quote-1-rs.wrap                   |  10 +-
>  subprojects/unicode-ident-1-rs.wrap           |  10 +-
>  10 files changed, 207 insertions(+), 118 deletions(-)
>  rename scripts/{get-wraps-from-cargo-registry.py =3D> update-cargo-wraps=
.py} (38%)
>  rename subprojects/{glib-sys-0.21-rs.wrap =3D> glib-sys-0.22-rs.wrap} (1=
3%)
>
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

