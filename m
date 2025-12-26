Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A54E8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ26n-0006Wn-Fx; Fri, 26 Dec 2025 02:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vZ26k-0006VX-6L
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:19:30 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vZ26i-0005qV-L4
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:19:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b736ffc531fso1279047166b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 23:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766733567; x=1767338367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WbJjZpTDamFQx25omm6ncfZJUhSvFih/fJmF0iVng8=;
 b=jALu8IgPNXAtjLjbppy22cgfNE4e5FvMiZoQW24AsBAAye8cVXfpGtBFJ2eSi1mEno
 58gHEiC2vNejLoBrpNfDQT4RBNaC5SE49OFST0LqW1JuWCUCd9blYSDoDppnsexiZKLo
 Q91KaE8tXiuHbg7MmiZtp+mWo9AJ97du7qeRMYRfzOLNqOJr0WQ9YrQpavQSmMrgDb14
 iwhdP90pAUCik0j+fNpaqoXrR3I/G4k8n6QnnDiD0O/erQaXSoA8ehWdGeerQU1/E4ZO
 8eqzlnYYHGNMUQ4k4Fvv2XIJVKCnoobSEoDZvRPbMQf7lsjt+YUQYCSNVjqZ0ZdKYW30
 bK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766733567; x=1767338367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3WbJjZpTDamFQx25omm6ncfZJUhSvFih/fJmF0iVng8=;
 b=DFz1PoqqBoCvFH5zJbaxMS//fNcBDxeKZ+JCWuEjL7+SgrAoUJrK/ty8DGLrvh1/s9
 sCJHDlUNKXaJ9QsydBboL4+Bl9dUOhuTsY92nZbqd6fcMUe/UVTrkW/SoFpkw4nQc9uB
 KgIuz9ry9dNN/Xyr9wlqhix/BMfpnLwwTOvFfj+v2buxVUDuTouCX5Py7eux02592lFP
 nyXhl4eynAJBjjirNw7S0WPuQQu0n464fHcDHyEZKl4VvPwVdW8NQcexknEHE/XoUPTb
 3MAO1pZpzlbPEvwHw0HknhbzlBWa1ZVjHQsxSoH/9tXKMtveAz7cvkRrPqrorh2fquSe
 ivBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmVltOA0I1x7ERgLe6vnPAsStJEAdjnCNNMQ3QvdOdrAqtgWRihdzy1IsFnGYFiC1KeCLKOl+o+k53@nongnu.org
X-Gm-Message-State: AOJu0Yw5W+fC9wbc1eFPDhyB+EZDTBDiByFBjVS5TS/5I9Y9NCaylo3e
 xuR/yfC96Gm8Y3SAjaV8y6DTBcUj6CsOpdLtwo7S7PV7PFkT9TZM/fqI7vrIzNM6RtRA4urlRZm
 2CsiNYuJV1N6diVJMXK4aVNE6Z+iqGMFkNiv9
X-Gm-Gg: AY/fxX4dXoyw73Jr8PpFhmFyV2b/bEmVJDwbdt/QxgI3PF/kyf0KmjxGRYFGk97r3Ue
 Tcwxkcw0OaXIcKqbIlR9h1ZgMXE6C02XYTGOX3MGvJmgkkgwB0zv+sOKxecVSif/69Eb04TuRA6
 KzbGiDfTa3Gt0hn8Sf9dA4+FvJgf8KXrAFqpqHRFC4C3xB8Q+Anp01VfxYDErOV3sEbudmwgS10
 BnRzEbiOoYiLNAO2Q5JYAaEeeP3QI746pdtttx5H3FreKUIlLYtlHzri2jGwIIhui7eluxc
X-Google-Smtp-Source: AGHT+IFYXrpBAtd9iwpwURqBWQzwRV514C6zhOeyhYKRrWQ1VKo/CPp7STB8cNBUcQW0jtVZXDresb4vWJ3NBT4E/vg=
X-Received: by 2002:a17:907:9809:b0:b76:5143:edea with SMTP id
 a640c23a62f3a-b803705dd87mr2264589466b.30.1766733566750; Thu, 25 Dec 2025
 23:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
 <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
 <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
 <CACGkMEtTCXTPB2oE9mwEOgSuSJfYoyA803w-yYcyojxBJRDHNg@mail.gmail.com>
In-Reply-To: <CACGkMEtTCXTPB2oE9mwEOgSuSJfYoyA803w-yYcyojxBJRDHNg@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 26 Dec 2025 15:18:50 +0800
X-Gm-Features: AQt7F2oyaGErjUMZtFXb36IXW-tOS58vZOboZ6kJNHYqVoD-BAj_ApGv4Xo2lXw
Message-ID: <CAK3tnvJ+L-XJ6yRiKUTAy0FJV5bTfgNFJwZuGzJ2tEfs9QQDVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
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

On Fri, Dec 26, 2025 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Dec 26, 2025 at 2:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Dec 26, 2025 at 11:15=E2=80=AFAM Zhang Chen <zhangckid@gmail.co=
m> wrote:
> > >
> > > On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gmail=
.com> wrote:
> > > > >
> > > > > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > Add test_change_interval_timer to verify that modifying the 'in=
terval'
> > > > > > property of filter-buffer at runtime takes effect immediately.
> > > > > >
> > > > > > The test uses socket backend and filter-redirector to verify ti=
mer behavior:
> > > > > > - Creates filter-buffer with a very long interval (1000 seconds=
)
> > > > > > - Sends a packet which gets buffered
> > > > > > - Advances virtual clock by 1 second, verifies packet is still =
buffered
> > > > > > - Changes interval to 1ms via qom-set (timer should be reschedu=
led)
> > > > > > - Advances virtual clock by 2ms, verifies packet is now release=
d
> > > > > > - This proves the timer was rescheduled immediately when interv=
al changed
> > > > > >
> > > > > > The test uses filter-redirector to observe when packets are rel=
eased
> > > > > > by filter-buffer, providing end-to-end verification of the time=
r
> > > > > > rescheduling behavior.
> > > > >
> > > > > If user try to simulate network latency by filter-buffer, the acc=
uracy
> > > > > of time is important.
> > > > > Do we need add some note about the first buffered packet time not
> > > > > equel to dynamic
> > > > > changed time (default interval time - new qmp cmd effected time +
> > > > > changed time ?).
> > > >
> > > > I'm not sure I will get here, we can't forcast when the first packe=
t
> > > > will come. So the behaviour is always that the filter-buffer will
> > > > flush at a fixed interval. Or I may miss something here.
> > >
> > > This case same like this test, before change the user target interval=
 time,
> > > filter-buffer maybe already buffered lots of packets, for this parts,=
 the user
> > > external measured time did not meet the expected settings.
> >
> > There's indeed a change of the behaviour, but I'm not sure if there's
> > a user that depends on the previous behaviour.
> >
> > Or if we really care, we need a new attribute.
>
> Btw, the use case is something like these (out of the scope of COLO).
>
> Mgmt want to buffer the packets for a while and release the buffered
> packets immediately when something happens.

Yes, I know that.  And back to COLO, do you think we should change the
colo-compare module
to a general network comparision module? Any comments about it?

Thanks
Chen

>
> Thanks
>

