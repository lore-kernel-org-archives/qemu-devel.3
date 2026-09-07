Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E6C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aBU-0003lf-5z; Mon, 07 Sep 2026 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3aBS-0003lP-7F
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:18:54 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3aBQ-0006CE-Ph
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:18:53 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-46ac24346b1so1851269fac.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788790731; cv=none;
 d=google.com; s=arc-20260327;
 b=TrUKME1ix0kHrbdlCFqYlXVmssgdBFp0RG913//axATWKwAuemuU36b0naJGNkwx07
 WKysYPMn5JV2QFunm8Lk0bOXvQN4xIgQeLct4ZWPupe1HlkhlqbAmOFadSFW302xPDs9
 rKs7kQE7KiJbdYVuLiHguMO2cWy4ZISSHhl3PX3znY3ZMnY05y41bJy0dfzAND9PHBR1
 nK2XIQfPZO/nWLnY2fKs4ew4qj6XBjPe6yXXbdaOcOp73dJg6cZzSjH+5gFSgkP6VWBu
 GCB8nqzSO7nwDp/zCAmRsLdtCT2wwt1ogFGnvQIgFZFNHjzea5k8DYtoaqTEpMo/UuOi
 6MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3ouYeEiLceIoH/4GedoqJUwHuwYoX+5AWsjtNoIjyN0=;
 fh=6zHZlHg5avvrGU2k4EamLTgQ89WZNPR6HUrDbm/nC6Y=;
 b=IHb3W5HOujSUElu1UWdJrSomnkDSybYQy7KoRnjlVPVX6QqArFmhW1MhzkxVc3Ek+Q
 i/B1uywVMJw4zdW6s+ZfbdVuhKkAiVL6FSkLRJSzsuSP3gR91XjMxI6NXEZyJYN8tMCZ
 qOoYHAU6E9de5r7+zTtNwbEVJ4QCKNT2wnQG+k7rNm3clffO+z9y/wRdIbAe48ONa5JR
 Vh7ti5kZWvUyg3AcoNHM2HCx6lp2CTfiFEpqvGE3LENaXhfafQiGI2xuUJWBgHguxaLV
 XYDSJaaynMVnZQF0HfwFSk45M9LThAl5LcW2Q3HwT6ZPnGkwq+Fuw5gLGtImZ/lSIebM
 EaDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788790731; x=1789395531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ouYeEiLceIoH/4GedoqJUwHuwYoX+5AWsjtNoIjyN0=;
 b=t/Q4f3UF79nni4B4k5Le4l0SB0DZfi5hqoTJVEnun8pq2Yih2/K5efEyz/sIRFIjQR
 64TdT/OCd28gP9GyElaJGQj2k/XJgbjQ0uVI7GnSAjUbbSf8jYYgM8a4/JkDd1oAFHn4
 jtYVVUtOg/y9LDld5jhhdW9M9v6M5YzJQKuut6WoVDWArvLrc9KRmw2UqZNBprvu+4eo
 wjK2bAt7I3Z3XOiIXqPAEDcBALEIAlNQRNk5lVf3+X/oTBQ/Ib+/eKjvJY1SkF0hR3GX
 RM7Ml/khYoJ+mGq9vrvXlqqVbQs/rQJqlWQSJ4FMQcjfnVhWoG2hKSVHJz4sRYNSMowO
 kRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788790731; x=1789395531;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ouYeEiLceIoH/4GedoqJUwHuwYoX+5AWsjtNoIjyN0=;
 b=bAKMP1h/r9oWu1mRGJkYTFqq0C6sBz10BhRqPjrNaTy/x5iIElATANor2WKIhtxRTA
 H0768GjSP5c3ifpJs812sp9KdbPF4vv0ua3xN/bdfw0mLyPDTdYByfPbtuPvccb1Rrvl
 dJH1k+debcaV1EkH4JzGYcPRV0qjgwtuYhSn6SyBl1nwk12+iV7JqjwYe+zUHOKMyRst
 ZYIv/WHBtXGjd9pcfxSzy1Go9mreZqDpa8rNAi3k1tWaZINgQo8eFw7jBtv+S7lFFbuS
 bFprJhuylRpGLkTP+SVlh33dnfkfybDseRWQX5GPMnCkrApVB1ATkElwCd1OEP8Q6DuJ
 x1GQ==
X-Gm-Message-State: AFuF++nkL1213QhmMHdSEAxU5yKDTTAPD84Se5Af6aTFyUq9ShZh7jV5
 IesEjfkoMZvWIgE14ESEMGaz65HFj3IjIChRcmwmLP4NHWA+/xHIez/DgQPdlXggjU2cxdyXA06
 zOWDF30NAJ0wRQPaj1lUMM18v+XFLS4c=
X-Gm-Gg: AYBFou0kQvDaXmdbcmCdBWhHtByCEBWsS2uHCR+wIPLvwS2ldk4d43CC7WXnVSvZ2h6
 YqL1Ct0h1c4kenppRibGaTDwG+5HMMSUtEcD7P8/ryq5R6AU0o9NOYVrieJxnh2RII4SOseW5Ev
 yo+6GPuKgvrBZZSxv8DGrnJ1/TdAW/0gALDWsBwHGhys63kE0v/37C3MnUbhVCJuh2fKUFDWzGI
 h96iTxgqbHdPNLnurWQGsy1nkEXFW8goQSEla+3EXbbbVyG5Tz0MPh1UEqJ0+oPJdO2N2vQOOZ0
 Az1iZHGDjepwQDfmYMnR6VLRIOZMH0ngVSlS04o2XrUymN5+d7evR0fCumKFp+bEZL+aPsZjSZz
 x
X-Received: by 2002:a05:6820:f034:b0:6b7:46fa:16a0 with SMTP id
 006d021491bc7-6b746fa1a27mr12596936eaf.53.1788790731111; Mon, 07 Sep 2026
 07:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
 <20260907093319-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260907093319-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Sep 2026 18:18:39 +0400
X-Gm-Features: AcwNN1VP_yBlofHT6lqkFb-QdWaVMCUy9kOXjpmtbgfCrRwPwqxxf1FpOsTqeOU
Message-ID: <CAJ+F1CKiUFGqJbWuxNM54bPJg1AicBKK_i+AuXttSCy-JRr8xg@mail.gmail.com>
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
To: "Michael S. Tsirkin" <mst@redhat.com>, Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 7, 2026 at 5:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Sep 07, 2026 at 05:22:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > maybe just avoid stdbuf completely.
> > > i don't remember why we use it, but it looks like merely to
> > > disable buffering for stdout?
> > >
> > > If so:
> > >
> > > setvbuf(stdout, NULL, _IONBF, 0);
> > >
> > > will do just that with no asan issues.
> > >
> >
> > That requires modifying vhost-user-bridge, not sure that's what we want=
.
> >
> > thanks
>
> why not? it's not like it's a facility useful outside of testing qemu.
> If we were we'd probably disable stdout printout completely.

Since the test redirects stderr to stdout, I guess the log is
fully-buffered for stdout and unbuffered for stderr, and we see stderr
log lines in the file log before the others. If we call
setvbuf(stdout, NULL, _IONBF, 0) early, we probably will get
interleaved stream output, but probably broken lines... Tbh, I don't
have much motivation to check or fix this, I would just like the test
to be green or skipped when built with ASAN. The current workaround is
quite ok. If you prefer setvbuf() in vhost-user-bridge.c, I am okay
too.

Yodel, wdyt?

