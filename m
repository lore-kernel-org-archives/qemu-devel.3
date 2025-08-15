Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739B3CA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 10:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umrSU-0003Ub-9X; Fri, 15 Aug 2025 06:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrSS-0003UD-CI
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:14:48 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umrSQ-0003ks-L9
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 06:14:48 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e931c858dbbso1745497276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755252885; x=1755857685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3oV2vQ6BKAvPk5eLwDcjsevWufkwgaz/XWOSIbju7lk=;
 b=kfS4zYPGJE8ni2DmC56YmGg73i43V/x7TEfy6wZ47Ec9t6aQpvFRrq1SvZyRcE4Eq7
 uScNAcJTlOH4dOdKGd5lQ3YOmmaLho5eaTmD+HNYPcxcl5bscQILyaukI3HU0bHSYzx4
 8g+7a/PB7kAxzkyvzzRk3JId7Bbh/yXtVR7HZVGyeNRt6+N2R6pL4TffegJSfmDtihjB
 jmsuu28vrStvwU+ACvsFyMyjsiJQZwptq6zH3KDNUWBmRHIgpWHUHcytJ3UdCI/pbpGN
 dv46ntapd4sBxYilokwh9XWueZU0uXvzzGCH4gt3n12ENfzMFCbAm2AEg/8/sQdr6dg1
 WOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755252885; x=1755857685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3oV2vQ6BKAvPk5eLwDcjsevWufkwgaz/XWOSIbju7lk=;
 b=cyTBW6Bji9H2Jc3CuZC2vucHumiQSN/hha3ubhttX1b4dybsq9+O/Tl5rHNu4QeVFh
 KZFKszmbROZW5hxEgEG7ojRO64Fo9oEgSSAVNjUwHbX0tww0dTJGg36YmHeAondmtlZ1
 R0Cb7unrq1S2vzRTlPgpGvTeoL0z+De9ysqFQ2MsAG2WImobJ6gGyBq9KueF69EiTk22
 pxEK8wnNrX2OWqUW2D0X/6MFKzmmwCLUHduBbhKwS/FMipYxxGoFvLL0DDEkaAVSFQRJ
 7p+8ucGKE7tAkDjzx+Mwj78QKrAg2170uj7gdb6wgl+YRK5fud6BFjAZsBhxWyxPFiqi
 PiiQ==
X-Gm-Message-State: AOJu0YykqPiImK2xzuvk2AxFVWqtgmjxZFgvYOTwRUJdHNzyuuUSocf6
 yDwTiksUf4twjb/pnrYsfdFPHz1lBsUiYMSKL5goS6l+i6K4JaotSHBRYGIg9N5qCOdd1xEA9kS
 xjvfGruaCtFVuYAjr8tj/pKqWQeOKgw4GTjobcquOYg==
X-Gm-Gg: ASbGncsDiVjEqWt/MR/LYIICeDeJKKVamBLKEjtYHbO/1UtfV0Ia+KQopAnBe3VXDjV
 kayrhGhhpLwyfEzSQK1nf++UH/Wq6fSJPfSRJrFBJxb3MHobqSGWVkV5rLuC3q/837rYq0fCbDS
 qnXIZva02yIZpynkR9tGQzh4zy3Nm7WWuQQrzLH7U3h8LSajPxUmu3ZCqrfmmB6Tamd41AwB/7U
 nREC40m
X-Google-Smtp-Source: AGHT+IE0VnDOgnQA7ArlDvnF9W3adv1KljmC5bNABlOA2nsBHEWKcJhU4IijMjgVbhk55mFwjfKX7mSzta1+x7MGciQ=
X-Received: by 2002:a05:6902:188d:b0:e8e:29d0:ddc7 with SMTP id
 3f1490d57ef6-e93324cef8amr1826050276.44.1755252884823; Fri, 15 Aug 2025
 03:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
 <20250814171324.1614516-3-peter.maydell@linaro.org>
 <20250815115132.4af17dfa@foz.lan>
In-Reply-To: <20250815115132.4af17dfa@foz.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 11:14:33 +0100
X-Gm-Features: Ac12FXy1UiaXE0o1eeF4SC0mWNdUB0zkqos7JAC5nql5GYqebClEBh_L5qbOrEQ
Message-ID: <CAFEAcA-2d_n-fu4XXssq+xD_nxiozVtBORqVEgZ7RwcNrJ97KQ@mail.gmail.com>
Subject: Re: [PATCH for-10.2 2/8] tests/qtest/libqtest.h: Remove stray space
 from doc comment
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Fri, 15 Aug 2025 at 10:51, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Thu, 14 Aug 2025 18:13:17 +0100
> Peter Maydell <peter.maydell@linaro.org> escreveu:
>
> > The doc comment for qtest_cb_for_every_machine has a stray
> > space at the start of its description, which makes kernel-doc
> > think that this line is part of the documentation of the
> > skip_old_versioned argument. The result is that the HTML
> > doesn't have a "Description" section and the text is instead
> > put in the wrong place.
> >
> > Remove the stray space.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> LGTM. Even the previous version should have handled it wrong here
> (if not, it is a bug there - or perhaps QEMU version was using
> a very old kernel-doc.pl  version).

Yes, the documentation comes out looking wrong on the
old version too -- I only noticed this because I was
examining the diffs of the HTML for before and after
and the exact way it's rendered changed, so it showed up.
Easiest way to reduce the diff was to fix our markup
error :-)

You can see how the old version outputs it at:

https://www.qemu.org/docs/master/devel/testing/qtest.html#c.qtest_cb_for_every_machine

-- PMM

