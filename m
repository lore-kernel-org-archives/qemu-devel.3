Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F36C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8qc-0001WZ-8w; Wed, 12 Aug 2026 09:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wu8op-0007Fc-Og
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:16:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wu8om-0007WE-PO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:16:30 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so1248995a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786540586; cv=none;
 d=google.com; s=arc-20260327;
 b=Ifkvo4U53pUOOyXfTP3qimYcdIoTma9FGQ7uRN9udTPcasomg38/s6hgmKMvXJ+zSE
 Z0QuBtvJr5QIMtqkily0kQ5gsPumGYM+EXUVu6TmEW8QiMi4czDqOzHeAPnr9q8udtdn
 X0u16pm02tyZr00f/5KQEV5tL8NlPqw/4kLBgYtF3/vW3FWg2a9pLcPTcis/ZSSrKXhD
 iJo6xKMOaQBEXSQ6rLfqBe3pnAVoZwKCmXb/lM1Bby7s00pgV1TRtEXIhQooT5+5BKjW
 oX3HoQQwPLWpkCrzTcsxL5egk/V89EFcF5AmfwvxTDZ7G+R0XFW5TKoI3nmtFca2ZO+U
 /SRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PQGv/LogH5Qu9sCpmkwq06bJmi7m4v8cuZy/Ye215Yo=;
 fh=Y3e9Bd+knjFMomx6LEwhk05aNuQRrOwpoJOAF/P1AzU=;
 b=COMyWd/jp7Z+79FF+rv0rw3XnJ6p5eR5M8OEOe8sgGibJJ3I5Nk8pUuH2kI2q/ONVb
 oONyMcRZBFxrcvqEtwxfc6y9cSKmVq2dsn3/Lttmg8b+NXNDCb5hV/QQCMO6RPWtp+Zl
 U7Ykg9pB9wzCRjzT6u0XTN/XBC6Kf3KvdDPTz1DiSQ0SSA8FR2j4Q34AjRayWXvj/Gz0
 lG98JQ3yOgMCI3m8khrS7tC4DPKYL/4LuICJ6VlJXnmZOM76/WncEKZ8NsLWroBpwjUE
 yQWveqR4mDdmggcWytmnv92m8d1ZqtRmvq2JkDH45/bHEPkBNvicGYLLCkoslGpL1iSM
 t8og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786540586; x=1787145386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PQGv/LogH5Qu9sCpmkwq06bJmi7m4v8cuZy/Ye215Yo=;
 b=cbfhIHmNliHyvu6i2RbBlbey+69NKr2Od0/dTi+riuTp/nboXZYns+HHnnD1iZ/Gk8
 ToVdkHiygOzx5KM8PEgk+3ShvuVuH/f+6tEkVaq5AhRUdAChaP4jgdv8Nw7EXMmi2Skj
 EScUtQPenSWvqo9vT7OvbxUYg92+CU+o2lbcx/SW3UUnaewvAdhuBD0bdCr7hPyfbNCj
 gihVwjxryxHTMbXuOGfwwiTWiK6TKkNRAfZF5Lsey+Tpzg+uROj8QQoeXcp/lfYXuh4S
 KSVoq/aaYAKzw9DxhackhQ4Pd5L7Y0AjrOWHn+3SsPBnc+xb3vbulr97M/LVJHQDHXxf
 wNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540586; x=1787145386;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PQGv/LogH5Qu9sCpmkwq06bJmi7m4v8cuZy/Ye215Yo=;
 b=APq02+8Qusu7ehnMOzjd1snUoLY0Er2supqsm4MeHDWsBQ3Nll2rqL8lyM/xgSJcbq
 ozllPXWmBAlW6I54C0kdRJJEM5rVT/N8NU5TYSm46b3XqK7dMKU7IEs0CI1TDM6Ttrn3
 7Lu+0KOdaOs92T0WGGX1xwmYcUFj5WBK+p6WdgrI5tXysBg/vIVZ2v2qkcAIxD8bpa3T
 ZPIh8DNlBEIFbahp5v5TZih2f/oCNNLMKPpV3+6xmiTDl6mUuEORW1YKhyosUC55fJrl
 wZkIA7V8SvA9KRZFch+lvJ6veZpkdyC8eHEfXSoXJMaGGB0Gk4qtzct+NMryomSkhWQY
 gpNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1XoQSsZve7DsBXC7TP2hTGefI4wlsURzvv3jfsZCW0npfCS11YL4iBi9Z4T9/JhWPEuwQg7UF5WjN@nongnu.org
X-Gm-Message-State: AOJu0YwlRdWmMb51ameAhLy2moltX7G79rthULN6vrOmGT2ssSU3zF+9
 WfScjEgmOnvpmcYfKMuAF/vKWE++4+b5V14SMEbjgu9Lx/Vra47v2ltbzkQo+xBySuvZg3H/ucn
 g1ItT7j6TVbwPPDAVS0pTv+3RCBu5z/c=
X-Gm-Gg: AR+sD125xMZQDBYV+44urYrURHpY9gsxK6HdAbr99Jx2YlLzChPWCEZi4tonvS1HBmC
 xP2D2HCEsv4gp6o1no43xKcryAkWiqr/CIlR1+yTOy99ElOXLitK/gN5WSadKwjFROTHOm2pbzY
 azh3nMDCto+0mLJ1K2Egxf58aIPc2k+NFPGCeWtjg2oQ5xszecpPF6r+QGY7OZidvTtknaG42C+
 KwWZK5qrcbNiZXDQ4X09Tp5g/ol6SbEgLdHwTW1blplXRhJXad6fPsW2WP8dRa7HigjdF7XWb56
 0vMHgwshwQNvAcEaYsc8vjqCXxvXrWDiK17UC64i561fsI3UBDguFBk3Ncsk5utKWlLRKwgj0ar
 x9HMJvum9KhE4
X-Received: by 2002:a05:6402:e07:b0:6a0:6978:bee0 with SMTP id
 4fb4d7f45d1cf-6a375ed7d05mr2334100a12.9.1786540586120; Wed, 12 Aug 2026
 06:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260811183144.190135-1-stefanha@redhat.com>
 <1c83a42a-0579-4606-89aa-ee1df66ed309@redhat.com>
In-Reply-To: <1c83a42a-0579-4606-89aa-ee1df66ed309@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Aug 2026 09:16:11 -0400
X-Gm-Features: AUfX_mwiQfDkFmlpY-E4TDxIUqojGvPlSZHtOe6bMqf67bPWXOowyl8AQ9k3QYA
Message-ID: <CAJSP0QVLrLVnsgnna4xFqQj9a8qme528XHESVKWXmBkxbs1-VQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.2 machine
 anymore
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Aug 12, 2026 at 4:35=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 11/08/2026 20.31, Stefan Hajnoczi wrote:
> > As of QEMU v11.1.0, the v5.2.0 machines are not usable anymore.
> >
> > Use the latest x86 q35 machine instead, otherwise we get:
> >
> >    $ qemu-system-x86_64 -M pc-q35-5.2
> >    qemu-system-x86_64: unsupported machine type: "pc-q35-5.2"
> >    Use -machine help to list supported machines
> >
> > See commit a35f8577a07 ("include/hw: add macros for deprecation
> > & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> > cope with dev/rc versions in deprecation checks") for explanation
> > on automatically removed versioned machines.
> >
> > This commit message is taken from commit 9eef3854d309 ("tests/qtest: Do
> > not use versioned pc-q35-5.0 machine anymore") by Philippe Mathieu-Daud=
=C3=A9
> > <philmd@linaro.org>.
> >
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   tests/qtest/fuzz-virtio-scsi-test.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/fuzz-virtio-scsi-test.c b/tests/qtest/fuzz-vir=
tio-scsi-test.c
> > index e37b48b2cc1..102a5ccb67e 100644
> > --- a/tests/qtest/fuzz-virtio-scsi-test.c
> > +++ b/tests/qtest/fuzz-virtio-scsi-test.c
> > @@ -19,7 +19,7 @@ static void test_mmio_oob_from_memory_region_cache(vo=
id)
> >   {
> >       QTestState *s;
> >
> > -    s =3D qtest_init("-M pc-q35-5.2 -m 512M "
> > +    s =3D qtest_init("-M q35 -m 512M "
> >                      "-device virtio-scsi,num_queues=3D8,addr=3D03.0 ")=
;
> >
> >       qtest_outl(s, 0xcf8, 0x80001811);
>
> I wonder whether we should rather remove the test completely instead? Tho=
se
> tests based on the fuzzers rely on a certain way of doing their MMIO - if=
 a
> newer machine type has a slightly different MMIO layout, the test basical=
ly
> does not test anything useful anymore. WDYT?

It is likely that these hardcoded MMIO registers will continue to work
because q35 won't change its PCI host controller or virtio-pci
register layout.

But if you feel strongly about removing it, feel free to go ahead. I'm
not 100% sure either.

Stefan

