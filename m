Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA44CE8D67
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 09:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srDoc-0007i5-4M; Thu, 19 Sep 2024 05:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srDoZ-0007hR-MW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:51:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srDoW-0000ae-BC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:51:07 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53661ac5ba1so646311e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726739462; x=1727344262; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHdxZ00VUY93W8YQ38IceZwsDA+dPnLqiCccveS2RNA=;
 b=TIEEefL8RXG2Hj6rFy7dsamjWLu6HAvsJvBBM1qFx368WpdKTQc+ANNNVZ546f9Wrk
 +rlUi9ow00cT+mD1daCFPYtrPAnFNeFM9YBHSy7C9TfEkAZPCDY9UYkHj3rMtm97KAQw
 VNhR5LBVYBbcrCT6w9ESjHHjYqq3EoeznaWbIomqfcZ5qn75yst3Ky6ly2wY7B67x0C4
 X1VK05s2hYqsrvs1ouD8GBytNLbsi90mfQr+Zg9Zt3Vflx9mr9K/GeH+2RhNjca3umxk
 CQYfZ2wRWFX6MymUTC5sfKrYpGANefbodmC69GwT5aCOPhxW/qwNQzELX0bTg25FMKBL
 d7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726739462; x=1727344262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHdxZ00VUY93W8YQ38IceZwsDA+dPnLqiCccveS2RNA=;
 b=Ankv5r79c57js8C9R1wK1cgrPL44OHZ4Odzn8ykm4nam9NUyJXRqaErdtlzcX+GhM2
 F0DLsgmei1DzLOzwxtCSSS38BtN81XoxN0CuOP93EcVdMF2jpddCVReRNdbuxIIY0Xe3
 37WYbZt3usK9/I8HDCIZ5jHxOEzMfCAe4lVKjR262P0TKejJPRmQQUt+ZtGAfLFoUecv
 riBtuhILodmviMnA8O/rAXLhY/7ZszKJ4DzpVPCH2Dv/76eaj+Khhgts0Wmv5HZq1sWL
 T+dk9jWfBZMwLOCl82cdSYHdA7Muy8Lk5emvlgZR1BwjwaQ1qRQTBTv5P0ni+we9YMmg
 gNPQ==
X-Gm-Message-State: AOJu0YwyQJmDCqjQbrJvWyL1l0gBfHY5xhse5lV62syH4IFT/ZBpuT9x
 qKOiq0Ebom9H1yl7IWfJBcLQOwaFRJ6rFtnntlSAyiFyDqU1ULJa809nX/H0dwEX3KR6KQ3LG25
 D7+KIIMWZd5ZITH6t3D7EFYSyXw4IQ2IHCR9hM5DSUMrHFJen
X-Google-Smtp-Source: AGHT+IEyqkLlnUtu+DBzHMDT1sLzgSHxyIF2nBtcE1NMq1LgTjSBmjOcbDbNwLxSj5gNOCLLgiwxn+I3vGx/ltmCLzA=
X-Received: by 2002:a05:6512:3f0d:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-53678feb0f9mr14944844e87.40.1726739461989; Thu, 19 Sep 2024
 02:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 10:50:50 +0100
Message-ID: <CAFEAcA8tdyELui0=jYFObZO1=O_isJ-c1e0s4ZCbMVyfsrY=9A@mail.gmail.com>
Subject: Re: [PULL 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Wed, 18 Sept 2024 at 22:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22b=
d5:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into=
 staging (2024-09-17 14:02:18 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-tcg-plugin-memory-180924-=
2
>
> for you to fetch changes up to a33f4871e0a0f4bf1cb037ab29fae7df7f2fc658:
>
>   contrib/plugins: avoid hanging program (2024-09-18 21:02:36 +0100)
>
> ----------------------------------------------------------------
> TCG plugin memory instrumentation updates
>
>   - deprecate plugins on 32 bit hosts
>   - deprecate plugins with TCI
>   - extend memory API to save value
>   - add check-tcg tests to exercise new memory API
>   - fix timer deadlock with non-changing timer
>   - add basic block vector plugin to contrib
>   - add cflow plugin to contrib
>   - extend syscall plugin to dump write memory
>   - validate ips plugin arguments meet minimum slice value
>
> ----------------------------------------------------------------

Fails to build on macos:
https://gitlab.com/qemu-project/qemu/-/jobs/7865151156

../tests/tcg/plugins/mem.c:12:10: fatal error: 'endian.h' file not found

endian.h is a Linuxism.

While I'm looking at the code, this caught my eye:

    case QEMU_PLUGIN_MEM_VALUE_U64:
    {
        uint64_t *p =3D (uint64_t *) &ri->data[offset];
        uint64_t val =3D be ? htobe64(value.data.u64) : htole64(value.data.=
u64);
        if (is_store) {
            *p =3D val;
        } else if (*p !=3D val) {
            unseen_data =3D true;
        }
        break;
    }

Casting a random byte pointer to uint64_t* like that
and dereferencing it isn't valid -- it can fault if
it's not aligned correctly.

I suspect the plugin needs to define versions of at least some
of the functionality in qemu's include/qemu/bswap.h.

thanks
-- PMM

