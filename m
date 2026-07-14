Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6757C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjj37-0006vU-A9; Tue, 14 Jul 2026 15:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wjj2s-0006vF-HY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:43:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wjj2q-0006Nt-T8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:43:58 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15e592da74so574392666b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784058235; cv=none;
 d=google.com; s=arc-20260327;
 b=dKPz4LJwRVQyhMMp4javzQbSVAtbfRuQLxAGApws0kcXI5mhKklblYF8PI0ko9GTMG
 i/oYNxMLcK+a1OsjTscJp1YrrYVfAeQsOHZRxy6ufv7VgYQ0ANTaZwPbqRn1N2zs7GKy
 OcHvhdIEKOfNRMdQAussAgszpivxIid687AI4xD3JYHDPXTJcNoZZZRHy5myC2GpOFcR
 B68byYFX5ckrYFVoXutQJD2zw1pCYxUXxpI3AI/3iv9sjtVemLfm3gZ7uhpR9tcUTgGe
 4NuNiTlgyi0tRjyMiVdeYPYZWcmTL+tsiqNPhqg6u6JRRh+P4eRt8mq2ItU6DjKvbE+a
 HuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pm5ixxD8gOc3WBQVaqDzdRIYVGkQMmS/s5edVsJOu4o=;
 fh=b2Eibd1OHw82WfU35b+k07FEE4a8hvE9hwE9j5kkJQY=;
 b=iNqQ0GKC1JYf2X3EMBroIqAUxadNilDLjHV8Q8OzVQshoXv33pErniPy0gveKMqCaq
 IGdbFcSyRrlY2GwgTM7TgP636CG7P129Vr6lmjeahKDQ/ZnKF2kRBdFDGCRPgQlfscWu
 3xJx3Tqtu/18XRF+Mo+w92u4kkrvPDhp/01kqW2d4bR9IzLjrIALa6JdWZkJXG/3ORol
 ZxGVwChQw+n9XRT1Bhduz5Kb7URGyx1eRIqxTe3QWMBaxx8lpk85bkzyVhXv+w1acTv4
 a1328UhjKo5lciM9UZtok9hewS1tU1ixrOscwyQeEe7umE8tHoH/YqGXh7NMOip/wFtS
 zifw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784058235; x=1784663035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pm5ixxD8gOc3WBQVaqDzdRIYVGkQMmS/s5edVsJOu4o=;
 b=miZNW2yzQTm40OxWPGr4lUFe5hnTLQ/KqNhQiJfdt2o5Sp8WyjFvRFJ/oqV7UmiLmn
 FnN1GShOKOPN3SYgfa1AMUPzxrozrU/5VyI4O5AKZJlC3onzhAUBEUUz+6quFv1V+m8s
 baT0HQhRPsZpc6Ita8CgPp46R3tdN5kP581BNiySkixQ/TiS0cBvd4qA3YyHq+s+u1tH
 mV/K2ldup3EbvGtiPy07ZsmGi6mLWGGodpxGfxfZdP2wYDmegDkA+DKVJGJuyHOqytja
 lITQFoecaj6S+4qOTOIvTVFD/3u+l3FcksE2ViZtued/bpgl5k+MwYyRUTMQ6sLS577s
 Lzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784058235; x=1784663035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pm5ixxD8gOc3WBQVaqDzdRIYVGkQMmS/s5edVsJOu4o=;
 b=oZ6fHW1H1Tf/vgfKRNb6Uz4vJSP3kwT3k2axKzh+Q8vZLqODMUdxuHQZGVMZZhZu8k
 MDEntiRhL8zkZtGIJHDPpsA8CF8WIxFW/0aDqRebqF8QDfYbmvik6ApGUGrvfQdX9sal
 wIRv5so4uGSDqiyKGaNVDYnakG2gTYfp4Xc4hqmbjv/qAGjDGMaacf6wHAymvbauc7Qg
 fXnQ4fBdVECp6Jgzo9FI9OswyJu6HjI8g5fu5NcLrtQkX2iKhbySbTGHlkgvURvZRhNj
 ivN8Gd0GVDXy0B1Zm/pJ9NnVsiBFmm9+QQKFI2EMHWwmmYR+lvzA5M7AgBy5dnaW84p2
 z2Tw==
X-Gm-Message-State: AOJu0YwqpHNOZ9kNCvJneLgI3MhHVlh3b6lgLhEmauLRrMew2WOQlEzc
 5WO3JdgpBBWsMYNc5Bb6ruIm1LTT5fuCkikgZj78yYLc7m7bin4YvGJy1Zk21yObA38HI+1jWnC
 3rkK897orCzB4EDA/hppeLLnVzerm7bU=
X-Gm-Gg: AfdE7clvgqi9/EvDcpaYy/+78IdIFM+VmLk1RRF2HLyIvCVx3Djeautev1mA/wMasdZ
 D8Dxh9jcupZKKyiHO3kiBNEKUQY0oxEYeWhDZ2J5ov+EHaj9i/qujd35tQZXb9WtEn5EymfPibu
 onodvhHZF7+dU2WVexd9xd9q2VOTOAvNcR2JxpCdakWZ+IIIrZEb2ZU/iEjsk3er2NSCuQVuf0/
 cjBXzRNwgiTVxBbacimtsXA6WYF+OyVC4xHgdIKR1rQ4hJITzuWIJa26w3xA3B4HldTlXttVmrK
 dKWGFTl5ByFRujbf4DcvsTue9+hivg==
X-Received: by 2002:a17:907:3e12:b0:c15:c6e8:21c with SMTP id
 a640c23a62f3a-c16792c8935mr8742866b.20.1784058234664; Tue, 14 Jul 2026
 12:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260714091700.3797064-1-armbru@redhat.com>
In-Reply-To: <20260714091700.3797064-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jul 2026 20:43:42 +0100
X-Gm-Features: AUfX_myEOyV0zwLcsJs4YMv6jPE1ahMQAYoEd6kFDYFNzcEb8OBImKEYc_obgYI
Message-ID: <CAJSP0QXmodMY-66xPS_8JfkGxySLTJSEs5Xe=eeDXo0xV3P=2w@mail.gmail.com>
Subject: Re: [PULL 0/4] Miscellaneous patches for 2026-07-14
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x632.google.com
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

On Tue, Jul 14, 2026 at 10:18=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f=
05:
>
>   Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu int=
o staging (2026-07-12 21:49:04 +0200)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-07-14

Hi Markus,
repo.or.cz is geoblocking the UK where I'm currently connecting from:
https://repo.or.cz/uk-blocked.html

Your pull request will make it into -rc1 and you don't need to take
any action, but I wanted to let you know that this pull request has
been delayed temporarily.

Stefan

>
> for you to fetch changes up to 87f608e3c20677e57fc1c854085218dab8a45946:
>
>   json-parser: fix formatting of comment (2026-07-14 10:59:58 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2026-07-14
>
> ----------------------------------------------------------------
> Markus Armbruster (3):
>       qapi: Fix misspelled section tags in doc comments
>       qom: Fix device-list-properties & friends to show legacy-FOO props
>       MAINTAINERS: Regularise the status fields (again)
>
> Paolo Bonzini (1):
>       json-parser: fix formatting of comment
>
>  MAINTAINERS              | 2 +-
>  qapi/machine-common.json | 2 +-
>  qapi/qom.json            | 6 +++---
>  qobject/json-parser.c    | 7 ++++---
>  qom/qom-qmp-cmds.c       | 7 -------
>  5 files changed, 9 insertions(+), 15 deletions(-)
>
> --
> 2.54.0
>
>

