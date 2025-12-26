Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F7DE8FDA0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2bG-0006pY-70; Fri, 26 Dec 2025 02:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vZ2bD-0006pQ-Rs
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:50:59 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vZ2bC-0004J8-88
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:50:59 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b7b737eddso8482439a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 23:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766735456; x=1767340256; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dunF8xl8O0FoPQukDs/fxVjMs6SfkbPfOoSuePTJvFU=;
 b=jmRAcF7uDtvfzFex9+sU73jDLSGf718pyNWPRMr4EzfqtTr8m+icQnabB3eGMhc6Bn
 JtJPUkdCi//AGUMbwFUECXhNE5XogjFjdZ9ihc0CgBW3MnJ82ScJ99gnkltFSUdDD6Y3
 hEOKsCzZL/wE/GheofADUWrqiTYuKVwquobDncQ6mtRWA28b2UGoQb4i+uL87TyFtUMJ
 56nuqThF7FaJqk6cQuv8L/nOqnEK2yv6e3yRNn+e6mTlvuwSserrrgXy9dZNzDX+JkPH
 fGeJVgFOG2GggCZNDfbxGnwjoOEf8ACT85ALfVu4Nt+eNaKwdEpXjHdw+i1J2i1oPskJ
 xrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766735456; x=1767340256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dunF8xl8O0FoPQukDs/fxVjMs6SfkbPfOoSuePTJvFU=;
 b=L6XFV/ykjSsg3Tk8M6UUns/2Yr3ocPkO1TZlID66PkEWhhFQYcsXjoD0E1Bk0PcVIb
 xZ7E6gb/w4WD9eHtuQhrtTYty1hLsH2boFRbW+LCAU/i8R/1tOaKHiptHNf9Wkmswh5T
 8yazxgmdAwiLEMCM2O/3iApCTQ3kRuzNHDkv41nZfGpxQfBLJQ3KiRC2cy2TTRpiwkkN
 lr/7rIW/BP+Sd3JYKi7i8MOeO0E/yriBMNQfzp0q9mYezCeQXj82sw6dCm8yBp0FeCvh
 AWOdZaJllwESjLxaLOEL882OiiFoRkBCcZaH+MC+hkZelS8AR1bLb2ugHLiUitEejkaN
 M3eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2D+DGw0aBwz6yLDe4tgdWNhALOLtfzQJ+xKRfHK1l+1fi6qqTUaPL0wjVcAfqgPDxXjdBb9tNLzI@nongnu.org
X-Gm-Message-State: AOJu0YyH1ClTaFHAARh3j3NRp1Vd0RUrMKTqden+X2seBNDR2ZLq9h8e
 T2hY4NVIVePC9/PBhZ/6PbdTAbHhwjFkBRNrvML1jLOV+E0uWdfcpWrhPrreLnDxuR00RF8y2J0
 r6YjtMs9Lbyj5C0A3+pM5H1hZeFhPrfo=
X-Gm-Gg: AY/fxX7wvwaXpOjqSu40qSUz+geEi2mPr2MWkzohvT6q9mNMVMbr5zve14OfeqI628H
 mOwiajOKJXBxuZ3q6odB6f/oPf6EWZR3WDu+NXa6+XUadzPZmARS6otM5nGu92Npc7IggyjEOSW
 U30R4NQMymaGcb334voMVV/nhUwIKRgI315T9y7A9SwjiLQkwOT7fcleta8yDfs5MeYRqsm18If
 j7CTnoyc+TLl7dsD9Yvhj4blS2fcmprhKMGVz/sNXC/QiWBkC+MOyt5D+TajmJvB2Sxyvc=
X-Google-Smtp-Source: AGHT+IFkQBhlGolm1K3AyN1IpcjvFok9EENtqGiHubif8GDMX+jiMYe+HpSFmrx0iajHF5+aQ7bNp+P+bcz8xNE/jD4=
X-Received: by 2002:a17:907:8e95:b0:b76:7e90:713f with SMTP id
 a640c23a62f3a-b8036ece45amr2249715766b.10.1766735455256; Thu, 25 Dec 2025
 23:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
 <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
 <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
 <CACGkMEtTCXTPB2oE9mwEOgSuSJfYoyA803w-yYcyojxBJRDHNg@mail.gmail.com>
 <CAK3tnvJ+L-XJ6yRiKUTAy0FJV5bTfgNFJwZuGzJ2tEfs9QQDVw@mail.gmail.com>
 <CACGkMEvvE=Wyga7+tScUXW=VG7OEL7i240e+1FOYX0a1k4Xeeg@mail.gmail.com>
In-Reply-To: <CACGkMEvvE=Wyga7+tScUXW=VG7OEL7i240e+1FOYX0a1k4Xeeg@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 26 Dec 2025 15:50:18 +0800
X-Gm-Features: AQt7F2qWvOEXGChcl_Ws40nLqUgNa1z59yJ8hJ8WuBRPhQB3i2qSSyDSQQoah00
Message-ID: <CAK3tnvLe7XODwWUXz8U9OMpiQCZ7qfbQ9SN5AmRp8ve5BoN=8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
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

On Fri, Dec 26, 2025 at 3:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Dec 26, 2025 at 3:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > On Fri, Dec 26, 2025 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Dec 26, 2025 at 2:26=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Fri, Dec 26, 2025 at 11:15=E2=80=AFAM Zhang Chen <zhangckid@gmai=
l.com> wrote:
> > > > >
> > > > > On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@g=
mail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > Add test_change_interval_timer to verify that modifying the=
 'interval'
> > > > > > > > property of filter-buffer at runtime takes effect immediate=
ly.
> > > > > > > >
> > > > > > > > The test uses socket backend and filter-redirector to verif=
y timer behavior:
> > > > > > > > - Creates filter-buffer with a very long interval (1000 sec=
onds)
> > > > > > > > - Sends a packet which gets buffered
> > > > > > > > - Advances virtual clock by 1 second, verifies packet is st=
ill buffered
> > > > > > > > - Changes interval to 1ms via qom-set (timer should be resc=
heduled)
> > > > > > > > - Advances virtual clock by 2ms, verifies packet is now rel=
eased
> > > > > > > > - This proves the timer was rescheduled immediately when in=
terval changed
> > > > > > > >
> > > > > > > > The test uses filter-redirector to observe when packets are=
 released
> > > > > > > > by filter-buffer, providing end-to-end verification of the =
timer
> > > > > > > > rescheduling behavior.
> > > > > > >
> > > > > > > If user try to simulate network latency by filter-buffer, the=
 accuracy
> > > > > > > of time is important.
> > > > > > > Do we need add some note about the first buffered packet time=
 not
> > > > > > > equel to dynamic
> > > > > > > changed time (default interval time - new qmp cmd effected ti=
me +
> > > > > > > changed time ?).
> > > > > >
> > > > > > I'm not sure I will get here, we can't forcast when the first p=
acket
> > > > > > will come. So the behaviour is always that the filter-buffer wi=
ll
> > > > > > flush at a fixed interval. Or I may miss something here.
> > > > >
> > > > > This case same like this test, before change the user target inte=
rval time,
> > > > > filter-buffer maybe already buffered lots of packets, for this pa=
rts, the user
> > > > > external measured time did not meet the expected settings.
> > > >
> > > > There's indeed a change of the behaviour, but I'm not sure if there=
's
> > > > a user that depends on the previous behaviour.
> > > >
> > > > Or if we really care, we need a new attribute.
> > >
> > > Btw, the use case is something like these (out of the scope of COLO).
> > >
> > > Mgmt want to buffer the packets for a while and release the buffered
> > > packets immediately when something happens.
> >
> > Yes, I know that.  And back to COLO, do you think we should change the
> > colo-compare module
> > to a general network comparision module? Any comments about it?
>
> I don't see how colo-compare could be used out of the scope of COLO,
> but I do see buffer, mirror and redirector can.
>
> Going back to this patch, are you ok with this or expect something else
>

Yes, it's OK for me. Thanks for add the new qtest.
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

Thanks
Chen

> Thanks
>
> >
> > Thanks
> > Chen
> >
> > >
> > > Thanks
> > >
> >
>

