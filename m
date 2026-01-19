Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F502D29C32
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsv2-0003BH-Ec; Mon, 19 Jan 2026 12:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhsv0-00039k-C8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhsuy-0006Je-8J
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768843194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZWyAsBGP6nJLhcouzi5Luuz27Zs34MPcP8bVQRe5uk=;
 b=Qvo+tTaAYqRg65om9tYd7Wi6ZDiTTsWRstMlkEaUtkdSdqNEgPx38TD4Oq/nL5csmoOdFC
 wSW5xUEncYjllUxU0k7vjBBe/oGk7nFmAOhp8X3GrgP6YvZugBVOrFS77zRyVsl2w8YiYQ
 +llkt4qfuNyDzHXzo5lhkDPd/sR+C6A=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-4XCjHNdVMpOO9vmbeHLqlw-1; Mon, 19 Jan 2026 12:19:52 -0500
X-MC-Unique: 4XCjHNdVMpOO9vmbeHLqlw-1
X-Mimecast-MFC-AGG-ID: 4XCjHNdVMpOO9vmbeHLqlw_1768843192
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-78f92e123f5so58775687b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768843192; x=1769447992; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZWyAsBGP6nJLhcouzi5Luuz27Zs34MPcP8bVQRe5uk=;
 b=fIIPch/JazOS2OuXNhtNFQ6f2wtfZMMSzLLE5acemA5RO8Br+5r0ErMbBlbJiC0ZvN
 FiM6ihLt3uL4DXftiXVpm2BwJBh8BWzLvVk2xm7z7afw0B9MuNglQLvs0IRjl3kG9tpw
 6D8GAD2j2ZnuNifDWB/819GAGNb6YuGTZY3ioVB+sgTi4wJetbVcF3ot0FzVm8jstbSn
 MauP9USln4yDmpPiVnhKsYXoB8I3NopHGA4rY3ec52vTrcMVqz0ghJipHSn40kn6H9u1
 owZ3SO8RPBE5oFvjgxRiVipfncCiuxg76TWUDcP+G1F0QCrwuZ2YREW9YaZ5sIs0vx1z
 dFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768843192; x=1769447992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZWyAsBGP6nJLhcouzi5Luuz27Zs34MPcP8bVQRe5uk=;
 b=ScRjZem+hbWbnnvhN0S6iqZ5avzJax86TynyjthqZxu0yCk4XZm8gfxXy6BqSTP5g4
 u4TYImuhjnZ6JpUwLT8x36muwWRtogzVeQvIt0CC9NQ6Sbe/kJG7fL/Zsz8fsBse6/H1
 usdmlI+XJpp3zKUGynOFHZcgQbuUTlk/73jHp/A4ieUv5rKS+atnyblTl+hOE1EjT8ng
 hjmeNDU2GeMOvRJ7nS8FhdLVlbLQwvxWYx0rMS9e7GjByfKVug9tWvRH+R6jCUMyQYOt
 75BivMtIwkQDAyIurHO3jQrvYo/WURCtv7v3FD1zY4veJUhwt8QUbfY6/yzwZTvP9web
 APww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV38Y9ufifgwaNvOQBoxkp5grCsIRY1sbIo2kHNuepTGOjeoQ4m1GcgeJQ9CzVvjv5tYDZuQ3nFr9OP@nongnu.org
X-Gm-Message-State: AOJu0Yzu/CJm6M7LDtmJlyFB8dwdSXTRwyzaYl2P9b3nLpJFY2wooUOK
 fj95QAqJJkP6+3Il8OzAlFKgX+SHL8QXbrCKCJqTfIuV4z5PR78Li+Si+oT8YRAMbVAn6haU28o
 8lWY5cyIWtihVdm8zw7Yfc/lFdUO0ZMST3ruP39OHOkrJFmjHGnEWH6K9e4ynyBuo3hKSne+ICh
 HjcSi6NvUnQQL1PntLYeGy64hoDj53vPU=
X-Gm-Gg: AZuq6aJ1f+GETbjyd/VgcuOvTGrkUBycCCLuJe8R2x9aNnW2fA5Owz3V3M2Lf0oBj7I
 p5JWtMA3YlkODTAKNuO71RRexv4HB9q0vTIlVB2EXR4jdPXdYRVYnTk5CJJi2WlvgHV5fE0HA0b
 N2m3PHk/I+lYUvOXAiBloWWUrviuzgddNR7U4T2vXJLY46YQupFoZahSNxPICjQWl/AikLpRpRH
 NlEbpKgPMMB311RQkHTcoRYSg==
X-Received: by 2002:a05:690e:1483:b0:644:60d9:7508 with SMTP id
 956f58d0204a3-6491650817fmr8411258d50.88.1768843192276; 
 Mon, 19 Jan 2026 09:19:52 -0800 (PST)
X-Received: by 2002:a05:690e:1483:b0:644:60d9:7508 with SMTP id
 956f58d0204a3-6491650817fmr8411236d50.88.1768843191933; Mon, 19 Jan 2026
 09:19:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-YHkDpE62N_gn0MAqDaLfuOxrj-5jt-MUDTvE=1ZopC_g@mail.gmail.com>
 <87h5slmct0.fsf@suse.de>
In-Reply-To: <87h5slmct0.fsf@suse.de>
From: John Snow <jsnow@redhat.com>
Date: Mon, 19 Jan 2026 12:19:41 -0500
X-Gm-Features: AZwV_Qirq4-MGuLeni5bPNyDy2qWD1UqPjcpvrk7VM-HbQIPgX995aLWbR8GZhk
Message-ID: <CAFn=p-afPwc2WTE=wqnJji2boDPPi9m2S__FH1AAnfNfbAL74A@mail.gmail.com>
Subject: Re: migration-stress tests
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 5:07=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Heya folks:
> >
> > I'm working on a series that removes the qemu.qmp package from the
> > qemu.git tree and notice that
> > tests/migration-stress/guestperf/engine.py makes use of the
> > QEMUMachine class (which depends on qemu.qmp) -- Can you please let me
> > know which test(s) utilize this code so I can ensure that there are no
> > disruptions to these tests after the pivot to utilizing an external
> > library?
> >
> > If they aren't executed by "make check", could you please give me some
> > instructions for how they are normally run?
> >
> > Thanks,
> > --js
>
> Hi!
>
> This is a little benchmarking tool we have. You need to first build the
> guest workload (might need to install a couple static libraries):
>
> cd build
> make ./tests/migration-stress/initrd-stress.img
>
> Then:
>
> ./run ../tests/migration-stress/guestperf.py --debug --verbose --output
> output.json

Oh, fantastic, you're already using the new runscript. That makes
things an awful lot easier for me. This is soon going to become
effectively *required* for you to run this script; I will add a little
error message into the script that makes this obvious in case you
forget it.

>
> It starts a guest and migrates it, but with the --debug flag you'll
> already see lots of qemu.qmp debug messages flying past.
>
> Beware this is poorly maintained, I just checked it's working, but it
> might bite you. Let's us know!
>

Thanks!
--js


