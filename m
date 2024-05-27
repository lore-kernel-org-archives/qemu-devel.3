Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EBDC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYWU-00023E-Jk; Mon, 27 May 2024 07:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBYWJ-0001wP-1n; Mon, 27 May 2024 07:28:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBYW5-0000k1-Kb; Mon, 27 May 2024 07:28:02 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bf5baa2773so2639704a91.0; 
 Mon, 27 May 2024 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716809265; x=1717414065; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7bLJ0XjhNso+GIkr6uRi/5/OkZcqZK2jiRSJ58+fYc=;
 b=L1T2mG/IwP4sxj5iVk+iQbiUGWxcv87qKJ4gL+3smLdjnby+hPQcG4/t/2zZbnZXXN
 QJR5v2rkWooI6xSIiHCt3PUoAnUYnO9zzS8MBpBn0VggzfIcmFsUElYeGVmykIY0Pta3
 R+LQ5w+Ggavdh0TNMuKT1cqls89e1l5dA+bZalDpYcnc2IVX9sc5VZ08PGmbX69SUs4k
 U/XlxmsDlTBXS9HvaNYmhBo6cUfNsLAQjjcQXYlTeiW2XjY1OHv8d8zfdolVYdXAaNm/
 Ntr6OEp4kuV216ktHz2vnvpWNKmF3sngczPPKdSuxqr5z0AlPK38hSi/GRLZYJ6RfdN/
 Ikbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716809265; x=1717414065;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f7bLJ0XjhNso+GIkr6uRi/5/OkZcqZK2jiRSJ58+fYc=;
 b=mvgEq8v3pFItx87Ofac8tOXuT1oKGhzMmpXpQnC4+CYVrC90QvowI+BGHyZ5E2Xzuj
 ux4/wC+LhtkCHX6OFZmP2mdJbjICSUZZ/e5phW58aHRf1qMNJVScNTaJZA5VE4lzPMek
 ZMKPr0YAdVZ8RfKGbIXmAWnDut5l6OeAQTGWLvB/6PSP5a9xEnfBkZqmJVw8RA/HwBjt
 Fy0ASrJWkBoZmygD8ujLZBdFFxDZvU07aleRB/0Q0ut6J82cLeG6FE0wlO1dTY/EHo9m
 qrM8s3JlOCMiQ8iaXC3kndSJEhwr2F0fMikVWFQytPSWyGaQGDwKNpCsXwXp3ruSBAzp
 vDfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFG7qCzXj49ayc3xiNYhCa1IdPXXBHYZum+CBewnY5o/XN4s30c5P6tmEMHeVA75ic7lHomxSvY8t3+aoWMJ4VKAawYxg=
X-Gm-Message-State: AOJu0YxZYxCYzQFU8yxu5oIBPvltKJNrJziJzcXo9/wF/qffTL1tlJYA
 rFRNsL4vGqcf2/OjC2Km7yn5vDJSzpQOebHqeelfk00zcCa5gzk2
X-Google-Smtp-Source: AGHT+IFwYHCjaavF24QZrKY1tyhcQMQiz5p9rtNIswRAqzPDlR+0/QrsIGuvvcMHFAIpZixLNFa7Dw==
X-Received: by 2002:a17:90b:ec4:b0:2bd:e8ca:d302 with SMTP id
 98e67ed59e1d1-2bf5f51ad84mr8859307a91.37.1716809265242; 
 Mon, 27 May 2024 04:27:45 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f9b4359sm6154363a91.50.2024.05.27.04.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 04:27:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 21:27:40 +1000
Message-Id: <D1KE3ACAV55M.2RI2CBTR9I1EJ@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, "Fabiano Rosas" <farosas@suse.de>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/3] tests/qtest/migration-test: Enable on ppc64
X-Mailer: aerc 0.17.0
References: <20240525031330.196609-1-npiggin@gmail.com>
 <20240525031330.196609-3-npiggin@gmail.com>
 <30aa8e56-bb43-4a1f-83f0-02324fb680e0@redhat.com>
In-Reply-To: <30aa8e56-bb43-4a1f-83f0-02324fb680e0@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon May 27, 2024 at 5:35 PM AEST, Thomas Huth wrote:
> On 25/05/2024 05.13, Nicholas Piggin wrote:
> > ppc64 with TCG seems to no longer be failing this test. Let's try to
> > enable it. s390x is still hanging about 1 in 10 runs.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/qtest/migration-test.c | 16 +++-------------
> >   1 file changed, 3 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index c13535c37d..b8617cc843 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -3454,19 +3454,9 @@ int main(int argc, char **argv)
> >   #endif
> >  =20
> >       /*
> > -     * On ppc64, the test only works with kvm-hv, but not with kvm-pr =
and TCG
> > -     * is touchy due to race conditions on dirty bits (especially on P=
PC for
> > -     * some reason)
> > -     */
> > -    if (g_str_equal(arch, "ppc64") &&
> > -        (!has_kvm || access("/sys/module/kvm_hv", F_OK))) {
> > -        g_test_message("Skipping tests: kvm_hv not available");
> > -        goto test_add_done;
> > -    }
> > -
> > -    /*
> > -     * Similar to ppc64, s390x seems to be touchy with TCG, so disable=
 it
> > -     * there until the problems are resolved
> > +     * On s390x, the test seems to be touchy with TCG, perhaps due to =
race
> > +     * conditions on dirty bits, so disable it there until the problem=
s are
> > +     * resolved.
> >        */
> >       if (g_str_equal(arch, "s390x") && !has_kvm) {
> >           g_test_message("Skipping tests: s390x host with KVM is requir=
ed");
>
> Since you've identified the problem on s390x, you could maybe adjust the=
=20
> comment in case you respin ... OTOH, it will get removed anyway once we=
=20
> merge the s390x fix, so no need to respin just because of this.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks. I will respin to at least fix the subjet "Enable on ppc64 TCG"
so I can do the other minor things too.

Thanks,
Nick

