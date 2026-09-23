Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA21C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JtN-00051t-QN; Wed, 23 Sep 2026 06:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x9JtK-00051l-K2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x9JtI-0004Ey-3F
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790158070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ra5RUjWdnMl/abxneUrPKaq0j3GRsv0frFHj2zbjVmA=;
 b=fMbG9imHMQhAXnLkUSrN3H6sE0hz8CPud37/pe3GvU9piaHbrtLy3jbuK18hf2pN3h9aWv
 oIYx2Cyl81Wv/BYdGGLTXOy+DZ8JgKiiwO72LREpzOHswqJ09Up2ChsMBF3xHZ+SeM5YoW
 u5LA/faNhfIviUAoiSAruTuR81euuII=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Zcc6x_ZoM2SypS_wnlr9Sw-1; Wed, 23 Sep 2026 06:07:49 -0400
X-MC-Unique: Zcc6x_ZoM2SypS_wnlr9Sw-1
X-Mimecast-MFC-AGG-ID: Zcc6x_ZoM2SypS_wnlr9Sw_1790158068
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1028780a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790158068; cv=none;
 d=google.com; s=arc-20260327;
 b=NY+gJkwN4huTkli2fpLifrQUM4AzDMYr2YPFgNBdtLfS9dcXZuf95wN+XFHgyw9uxN
 mva0LuJX5feikeuCyKDvqNy63gjcKtSm3F4rAisawnHbiAnlZ8Dw7KNA/A3LgBO0hjeN
 bIq+p7JHqPo99zulOJwFGD+a+bvBvLOI4Lplq3HvMb5f2w0TNS75PFPCZle6HdLNofpR
 24/kh3pL2RBhq7yjYlG4dwz5Dkn3UnLHI0bAz4Z4XjJuW3SFYj0zRnmduxNJqUgMe0Mm
 QFXW3orikZJUKZ8J+5BmvX+w+CO8jWz+glP6p6LW2agAkausS99aygmvGbaKYI1kQADq
 qA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ra5RUjWdnMl/abxneUrPKaq0j3GRsv0frFHj2zbjVmA=;
 fh=49Wtxz7v3rARopLyA6AD8Myutdx5VOOPehhHc0rlmmc=;
 b=dhm8/3rq+Aw31/WQH7r2sdTAc48Shdb5960T8XTmMH9++AYuxZIMmyNFVR/0jBT8Pp
 dPKBmOfo6usAkGBVHoTcTcj4HcHhNMBIOSoO+HsMTGT5JPaKxqvCW0bIvcainm33Q0st
 H8qjrH1dDNYypYuv4CQTjIt3jUhnP+m8ebK1/FWkyHk7ZZtNII2VLMoulGoFZXYruYaq
 Nd+BPROOKXeypDf3G7dgcC1bk/hOtxE2+Pwz9DGQ7U78DmJhKoX6NKMv8hk0rnemamb6
 orqNS42oeQ95apdR0mzaMlCCiZOjVjwa8fiLemBOsnrD+sz3ojldh6QiA8/80lrGA/cr
 DN+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790158068; x=1790762868; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ra5RUjWdnMl/abxneUrPKaq0j3GRsv0frFHj2zbjVmA=;
 b=ISV2ihv6S+rr+jO42bClj27POMDYuhB6oz1WnqLprT3vuhZyiCjyJ9YvWhS+rat42n
 7S/l/5qJ+Yw1R9leZPPVIoPSaSXp4zvizInFtmHMrW1iDlh2J9rwuMDFWhTVj8ssSZo9
 yCIA0jrw0WCIYpN+9hCUYocBVLqvELfPbh+lMSiEFV/J+3DeBxSmw0r8NdrhYvTtJ4RS
 +B0CUwjQqH7avEmC5T/M9OrhVT0xyH6Vy6nguwxdNh5V4KwsxUkwW3xl0z+y10QY3YEO
 M9Eb+YFhkrGrycrjl+SNztlSS7UqhwnI8I68+CrN39GPjSpNdlgcx1aLhKrCLluUYl7O
 9mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790158068; x=1790762868;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ra5RUjWdnMl/abxneUrPKaq0j3GRsv0frFHj2zbjVmA=;
 b=wR+iKlz2svkNRtSiC9q/zkRcydi4nr4nIvMjaIxmzTcrU4nZWb51Q/n2m70rt07dRf
 yvfObxIhzqPRzO7V+AaQPise2KT6G01bV749qMSq9OJqoR58Rz4E7RkO0FXifuItNJ86
 YHiDWJJJwRCoNtpi01j9/7Ig+fIEj5tlel4Q3Ygwr+FM1WsYf0Mtbn7pCW5ZZAPqnVgn
 c5MHIUAhSeGghsyywtN67KqdT85+tWujantK1vdlFH6OQyvAYA/dRE7bxDcz/+iqpzlj
 D63X1KctG/JigIiU1X5nRNcShHmNTEMQokNzrSh5+1RNY1YCE/4sGeUTjiHGykmnQy0y
 kqhQ==
X-Gm-Message-State: AFuF++mDfXHi39rsOklehwcmJJkqcGRlyfjzHrL/Y3p6IjyDhugH7Som
 Fd8hXxEUCdj0re/PTfK+p7LaT1oIIp8mwoZIsKed148UnHj/0vrAEJJFpr0QMQ8nDSXa1d18OZ1
 teZX63KFxApYdKuB7zEpCD9jT1bhfdGUrviZz/LcmbNW/yYhPIB+10P3qt1Uk8nibhXy2XWlkyB
 7s4a/7XCyAfBF0ewEyquh/Z9jgChkwWhE=
X-Gm-Gg: AYBFou2XdmyL+AS6Emomp+cZ3sIGi5ClhyYJKk502uYjU+DcW3W46ocdVabPKZDCRTV
 sXWZtVgvcewYMuO5XD9gv6epNz/w94s7AW9tseM/p2TAYecLJuA+809XPuS76lIMCBRUj5oB0IO
 XIYT41rBfsQdtEIR/prx0XE/WwByyUakP3riI36m4Elqf2uEdl1QScOBQ9i62pE12qF5bVp7Lri
 bvKMMuVnvUbErMda7BgtVgrFgKNr2CSBQlc0YXGk7mMrLgNu6kZdBfhgllTh5tW/22h5E5nUv1a
 zA==
X-Received: by 2002:a17:90b:1c09:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-3a07e4a2554mr1951614a91.13.1790158067724; 
 Wed, 23 Sep 2026 03:07:47 -0700 (PDT)
X-Received: by 2002:a17:90b:1c09:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-3a07e4a2554mr1951586a91.13.1790158067145; Wed, 23 Sep 2026
 03:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <arOdsxWtfLiZ6Y80@redhat.com>
In-Reply-To: <arOdsxWtfLiZ6Y80@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 14:07:35 +0400
X-Gm-Features: AcwNN1WTDlODIxC9TMq0f1oA-Hw_mXUs0ZZil1LF1PsOJVq8MdJYTwb_HBKt-G4
Message-ID: <CAMxuvax1igoDxo-kdrZc8HP9Mb1U-ctZw+CcsmwEMNT-7Y_Rzg@mail.gmail.com>
Subject: Re: [PATCH 00/88] qemu-iotests: migrate away from HMP ("make HMP
 optional" follow-up)
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 23, 2026 at 1:37=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 22.09.2026 um 22:17 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > Hi,
> >
> > This series migrates all qemu-iotests away from HMP, so that the test
> > framework no longer depends on it and can execute with --disable-hmp.
> > This can simplify the tests, as they don't need to check/grep on stdout=
,
> > HMP & QMP but can rely increasingly on QMP alone.
>
> Hm... Doesn't this mean that HMP loses all of its test coverage? I don't
> feel that's a good idea.

You're right that we shouldn't lose HMP coverage, the question is
where it belongs?

HMP is supposed to be just a frontend to QMP. Imho, testing that
interface is not the scope of qemu-iotests. We should have dedicated
tests for this, and better coverage.

Also, most of what qemu-iotests exercice of HMP is simply qemu-io,
which is the same with QMP.

> Most tests are based on diffing stdout anyway, so I don't expect this
> removal simplifies them much. I'll have to look at the individual
> patches, but I'd rather expect that their output becomes harder to read
> instead.

Yes, if we want "human readable" dumps, it is a bit more verbose in
JSON. But it's often better to have structured output you can test,
instead of bare strings that do not have stability guarantee.

>
> What are the general plans with HMP? Are we expecting most builds to
> have HMP disabled in the future? (Why? It's useful for human users.)

I expect QEMU will keep offering a "human" monitor by default. But QMP
should be a superset, so other "human" interfaces and tools can be
developped with the same functionality it offers.

> I think most tests probably combine testing the HMP interface with
> testing the backend functionality. If we really expect missing HMP to be
> a relevant case in the future, these parts need to be separated so that
> the backend test can run with QMP only while the HMP interface tests run
> only when HMP is available.
>
> Not sure how this is best done without effectively running all tests
> twice. Maybe there is a middle ground of converting some tests to QMP
> and making other tests explicitgly depend on HMP (i.e. they are skipped
> if HMP isn't available).

That could work, but maintaining two variants (or conditional paths)
per test adds burden without improving HMP coverage. The current tests
exercise HMP incidentally, not deliberately. A cleaner split: migrate
qemu-iotests fully to QMP for backend correctness, and add dedicated
HMP tests that intentionally validate the monitor frontend. I will
work on it for the next iteration.

thanks


