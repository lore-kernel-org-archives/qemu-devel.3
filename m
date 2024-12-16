Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D9E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGkW-00069v-Et; Mon, 16 Dec 2024 14:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tNGkM-00067C-2C
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:27:16 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tNGkK-0004th-AG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:27:13 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a815a5fb60so17315ab.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734377230; x=1734982030; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kt2ekZ+m6agASaky/ZkTIEt1cQqO9LQiurCTfFqV0XU=;
 b=zYbyONKc82q5JbpxQTyBGrr3qkKpsasXJJGhnTTIPLfG6crq3JC1kY4pxIPc5Q5OJy
 0KcmpBUCYk2VWj1inebFXbZfydg3CFHlKDzGqJ1R3OXCrnlwUgxhsiYPhAmOmCTX6C5A
 iUXa6y6k4gcY8XUBL+1WzcorMt2FiMOoJBJAv2PAbECpGUqTIw47twcknSJ2JIzYMfTV
 tJqHRf1mEBhJ+RWamkHyaRaI0VnocJd1/CNH+QZEviV7y6a1T/+JdVcsQYvMQ0PJJHY0
 y3D3vassQzwR8DqeolJy5HvHmFr7mYQ6gD6gP6rLZz4DGN1HfgJln76wreBuiWT4XoRB
 Lfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377230; x=1734982030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kt2ekZ+m6agASaky/ZkTIEt1cQqO9LQiurCTfFqV0XU=;
 b=Fgk4bqpxkIDJdyvKiHFRUld59qerulvwQaNu9doQBoZT2m7vYhSg+UgjsDsGGRAEgq
 +fLHwiZJNP9wCgfncMco1xtVhsXo6iCw9nfH7TlZyCgaTAk/Z0Fqr/GaIP1oRslB0U8u
 4ziVTFc8SVuDyCM0xdhUYDnKWDScQMaAvXwufcyJMyvLyPfyXScJkUwVgdmB9OyoKqQm
 rkeXIsnkJ+8Ab4yhtnJMBmsPdSKkOjtmcW7X3YY5Ars11BzdWFrUlb4dMSOpb2xhKxEZ
 P4tvcmoCfPktLg5LNFiX680P8Urlz0QRTU33in+FUHvf5KjKYWLg2kAx/2Vxf9ISIL0o
 4Xyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpKbyuw5cDwD8P0cHIyMs0A36pVJr4aSB0Ew82A2Msh1eEKjlbV/xeBlIRpIdMH8/9khPbtudJW1mX@nongnu.org
X-Gm-Message-State: AOJu0YwyBgyRNhoIAgso9B7lp3cW3xKyb545CT1TPnVW8+O/QoSpG8ml
 5HU15VsFyKpWxpce/DTEhzO783nZ1dfm4vmo3n902I2ITVpar/CNeaktodz9ew2S4E+PkyvXs8A
 vPsv3x+Z+9h009m11ZDVy/MnPAKcnr13Tf1rk
X-Gm-Gg: ASbGncuu5xKEmi86n/wVnw3seCfZ9y+nnNRP8yQFhMgKr2tD+LHhqiEeHhMIXWii16F
 TJ3tDpUDnaLsUP6fAJ/8J1NQHFCRMHmZ+M0szNzhk9KfMP7VLmFAuH0TzG4/YZWgVckLi
X-Google-Smtp-Source: AGHT+IHWbxBMkbD2xXs4yAWRl0CeQbVI7ENInJBF6vSuZDKyKQrzA/4JwcFLR7WDgNBzACvXJ8Ce2pn47Yf3OejztVE=
X-Received: by 2002:a05:6e02:1ca4:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3bb3ebed447mr69075ab.3.1734377230499; Mon, 16 Dec 2024 11:27:10
 -0800 (PST)
MIME-Version: 1.0
References: <20241213224020.2982578-1-nabihestefan@google.com>
 <CAFEAcA_MR86C5+jV9=uQsZZ905w7+OgHozfQZKYXx+=Xdv_xqw@mail.gmail.com>
In-Reply-To: <CAFEAcA_MR86C5+jV9=uQsZZ905w7+OgHozfQZKYXx+=Xdv_xqw@mail.gmail.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 16 Dec 2024 11:26:59 -0800
Message-ID: <CA+QoejWYCMYRnrO9JnN9pEiJt0gLDUu8g5kkVenzp+xJeJp8Qg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Actually after some more debugging with the help of Roque (cc'd) we
realized that this patch doesn't actually fix the issue, it only hides
it behind the watchdog.

The root issue comes from
https://lists.gnu.org/archive/html/qemu-s390x/2024-09/msg00264.html.
The function `qemu_clock_advance_virtual_time` is broken with that
patch and the conditions of the sse-timer test. In the test (and other
tests) we run `clock_step_ticks()`. This function calls
`qemu_clock_advance_virtual_time` which now has a check with
`qemu_clock_deadline_ns_all`. This returns -1 if there is no timer
enabled, making it so the virtual time in this test is never updated,
thus leading to the failure. This was surfaced by the INTEN fix in the
watchdog because now we don't have that timer running free out of
reset. Once we enable the watchdog timer, we make it so
`qemu_clock_deadline_ns_all` will return anything but -1, letting us
continue through the test. My theory is that in other people's local
builds (as in one of our local cases) there is another timer being
activated (which in our case was the slirp timer) allowing the test to
get through this failure. This patch only covers the bug, not actually
fixing it. We shouldn't actually merge this, we should instead fix
https://lists.gnu.org/archive/html/qemu-s390x/2024-09/msg00264.html.


- Nabih

On Mon, Dec 16, 2024 at 5:40=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 13 Dec 2024 at 22:40, Nabih Estefan <nabihestefan@google.com> wro=
te:
> >
> > V2: Removed scripts/meson-buildoptions.sh.tmp Extra file that slipped
> > through the cracks and shouldn't be in this patch
> >
> > Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519=
)
> > updated the CDMSK APB Watchdog to not free run out of reset. That led t=
o
> > this test failing since it never triggers the watchdog to start running=
.
> > No watchdog running means that the timer and counter in the test cannot
> > start, leading to failures in the assert statements throughout the test=
.
> > Adding a reset and enable of the watchdog to the reset function solves
> > this problem by enabling the watchdog and thus letting the timer and
> > counter run as expected
>
> I don't understand this. The watchdog on this board is not
> an input to the timer/counter, so whether the watchdog is
> running or not should not affect whether the timer and
> counter can run. Something else must be going wrong.
>
> > Also renaming the reset_counter_and_timer function since it now also
> > affects the watchdog.
> >
> > To reproduce the failure at HEAD:
> > ./configure --target-list=3Darm-softmmu
> > make -j check-report-qtest-arm.junit.xml
>
> This does not fail for me, and nor does running just the
> single test case in a loop. (Tested on ubuntu 22.04 with
> gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0.)
>
> thanks
> -- PMM

