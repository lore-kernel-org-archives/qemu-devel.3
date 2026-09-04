Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5D7C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QNM-0000Q2-82; Fri, 04 Sep 2026 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x2QNJ-0000Ps-FE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:38:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x2QNH-0005Dd-AX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:38:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a5ebf75d62so1177354a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 02:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514698; cv=none;
 d=google.com; s=arc-20260327;
 b=p84wT2pFm6kvWwLtzNUQ6jZGT0lQvrbWEFYSUNGuNRWDAjJ9i17nXkRpldhCN2GNSr
 13u0vDPCP1jtpw+S8lAnH+ETL4hJzO3bjP65/yXhYxqX4IkZUrZcOmPautVHQiQSZZxe
 BypFarnGBZ4KofOVBCYwDgi9PKpBG2NuYpzojX4W0bD643CQh2+y8iHq/Zy2r2rejR+V
 g4CP4+6T9tW3zpDR2I3mb+WRYDRmbUu3mI3Rg+BVIo77fyfq7JJRVHxADjfbhA4q7Uwu
 rA76TcKdQCxsg6R1J7zQ31/iQF4YNhrPBZ7OgMosi82vayuc2u4bbX04fkr1gxOZ4FoC
 DhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KuuCug3HHTEIsuAXB5NYvwn6sUbinDT56Oir6fzjZ3s=;
 fh=++v5ZdTrWEvmOA0hZ+M5Kkv+R215xTnLZagbbOGjP0g=;
 b=RGqvppt8hQX5eMW6gWzsKiEYp+RI9sPo7CnsulWpNIBUrBVI+NeqEVCEJDi0CJL/w2
 49GCwB4ZNBenvLQECQwWHHLPqRFzey7ZVIr2ICdA693C119A7uVHJQyJTG9ymrvr9ZoK
 DTYZuHlLCReAQsTSrJD6iyWvBGiGWVrv4SxnxQsgTifTu+ViLdsuXO1guG9r7332lPpQ
 ZoMgzju5OSdHYx7nQj38BL/ztQEsQ3CsgVT4Ag6hd2fg/73cpva4x8n8fe50ixlIESNF
 rDMJOi+cFnkN4OCFaMUg4MwHlozO1Qc0UTIs92C1bl8QJmlypDIpre+/1AfBIM7XvuII
 px0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788514698; x=1789119498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KuuCug3HHTEIsuAXB5NYvwn6sUbinDT56Oir6fzjZ3s=;
 b=LmCBT5Gg1eTIGqtvCGIa6OSrCTEcoOmxmNqjByoU/W788/se4cYW5zPYEUWtYMpMPN
 xoP1ltvwe3cAWDBSeYifDlEDKRhG2EumnywPgea2mN1uplR5zQ/LPERyt1uRGXWJzcqv
 ii5qzjGyFli9nVtEVECJrVecrjhdBc2X9oAhBNFsa2YCtnPFg67X3jkYlezDW60SB1mJ
 KUqPUB4Bwt/sK9sSpevnC+AOu/DFBSsdxLw2Gy6dQJGh9JD6b6EPbrgJ3bdBO0C5gShf
 Ny7cXxmUCs8t2H0zpLqnHz9yJamW91Txfh4iA07eYVJnBE6KStHjQgz5nqRdvUk8R7qx
 EpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514698; x=1789119498;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KuuCug3HHTEIsuAXB5NYvwn6sUbinDT56Oir6fzjZ3s=;
 b=PIjjVaYPLGV4EXSi/8zAavp6kvoOXrD1oPnvPk5XVvjB5E8eNPHsO5uRm5C4iHEO32
 GtgezUsJlzvyqiyPbmu6/X5/AA62YCebfIJNt5Qs9v/nH6poQtCj1SYqQhGkZDBlMfZJ
 z5bRWpD/LJbQ5eaXwmu2z+1+ezHeEDD/kK1SEGEeV3NVUQe0r3pRvPg5hUIDgWh3gkAg
 VfWwqQSMtBGEzv7wqIH0EPLGxDukomMML5TOLzpJk/GWm48jyKxByqWzRcdZeTyaDoB5
 Ey53lvHIyiBN1DDjkVIM7lgym8CYt+lz5iyOJGw85I8fFBymh4xXde6ysFTbx2v+GiHU
 pK2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6P4yhlYRhx51+jU6VniTwS3G/et5X5YhOxYrp/8Nw93yn1oCRI9oMVOoWvgoatV9BjlfezsVBsLI+@nongnu.org
X-Gm-Message-State: AFuF++k7X2qJQYDLw3MW4FhzpA3zfhoctO8bm4v+hjv4DBR+yL0BTTaJ
 OlVDfXppEWwEs5BDW29hqAn/L4LQ7I1FuT7xxY3Gc9qjPU9Yvw3pOQu79BIhGFsDVsyTRT3fmpm
 u+mp4dbhbfnuBfK7/2g/XxTzx5Med5y4=
X-Gm-Gg: AYBFou1SEqN8hcfsjOBSpbQwreimD+7Lz3NKRyU0ue7YtbVuUOjuUOg0HObjqbZLFJn
 oOpnS+W3y0nB40fGCyGckxcMe/OPK0TJoaQR3aOr+MMiV0s1rc+ODLBOEidR/tmSKBBM6gWTrM9
 jQY7T4fXE4ffORKumwGQuFox2CjfAvP+RB2jW52odWQY+a/H/C4sRKye2nDMaLSmGqNTfHjnU9F
 MXyEURHAZyPq6CYmbYQKcqrII6F6jlW8tXNZT9Qjg0re3EoAS6CuvItdO9KEbgyCq0X2jy6RCnS
 0nJOxY0j8gehed1MGHqy9L1DbaB9HmFSjctOyS61wTNNqg==
X-Received: by 2002:a05:6402:460f:10b0:6a6:b2b9:7663 with SMTP id
 4fb4d7f45d1cf-6a6b2b976f4mr2587595a12.16.1788514697316; Fri, 04 Sep 2026
 02:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <8733vtbk16.fsf@pond.sub.org>
 <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
 <87qzjb3nf6.fsf@pond.sub.org> <apgONqZ4sWaenjVG@redhat.com>
 <87jyp31zyf.fsf@pond.sub.org> <aphL_rrAVYq8D7ie@redhat.com>
 <8733vph0vl.fsf@pond.sub.org> <apqIEAIVvouwxSQN@redhat.com>
In-Reply-To: <apqIEAIVvouwxSQN@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 4 Sep 2026 17:37:39 +0800
X-Gm-Features: AcwNN1UDk_upvxb4Z1YYVMPxrxb6sV5VESrQkRaiw3vG0Ds29OhuQRhcNIP_RKc
Message-ID: <CAK3tnvLBboyOLgOFxd6vpS56-Jio2AWQ_6Mhm+RkdWnjP18eNw@mail.gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x533.google.com
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

On Fri, Sep 4, 2026 at 4:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Sep 04, 2026 at 10:33:18AM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> > > On Wed, Sep 02, 2026 at 04:37:44PM +0200, Markus Armbruster wrote:
> > >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > >>
> > >> > On Wed, Sep 02, 2026 at 01:25:33PM +0200, Markus Armbruster wrote:
> > >> >> Zhang Chen <zhangckid@gmail.com> writes:
> > >> >>
> > >> >> > On Tue, Sep 1, 2026 at 1:47=E2=80=AFPM Markus Armbruster <armbr=
u@redhat.com> wrote:
> > >> >> >>
> > >> >> >> Zhang Chen <zhangckid@gmail.com> writes:
> > >> >> >>
> > >> >> >> > Monitors that require an IOThread share the internal mon_iot=
hread.
> > >> >> >> > Account for each monitor explicitly in IOThread holder track=
ing, using
> > >> >> >> > the monitor's canonical QOM path to distinguish holders.
> > >> >> >> >
> > >> >> >> > Acquire the shared monitor IOThread AioContext once, using t=
he monitor
> > >> >> >> > QOM path as the holder, and reuse the stored context for lat=
er
> > >> >> >> > operations.
> > >> >> >> >
> > >> >> >> > Release the holder from the Monitor ObjectClass::unparent ca=
llback,
> > >> >> >> > while the canonical QOM path is still available. This covers=
 every
> > >> >> >> > object_unparent() path and avoids duplicating the cleanup in
> > >> >> >> > monitor_cleanup() and monitor_qmp_prepare_delete().
> > >> >> >> >
> > >> >> >> > The internal mon_iothread remains hidden from query-iothread=
s, as before.
> > >> >> >> > Management applications therefore cannot use it to determine=
 which
> > >> >> >> > monitors are using the IOThread. Nevertheless, track the mon=
itor
> > >> >> >> > holders so that they follow the same explicit holder and
> > >> >> >> > IOThread reference lifecycle as other AioContext users.
> > >> >> >> >
> > >> >> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >> >> >>
> > >> >> >> I have a question for our QOM experts (Paolo and Daniel).
> > >> >> >>
> > >> >> >> This patch takes a reference in its UserCreatableClass method
> > >> >> >> complete(), and relinquishes it in its ObjectClass unparent() =
method.
> > >> >> >> Is that correct and clean?  Or should complete() pair with
> > >> >> >> prepare_delete()?
> > >> >> >
> > >> >> >
> > >> >> > Add some background information in previous reviews for here:
> > >> >> > https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05318.=
html
> > >> >>
> > >> >> Aha, Stefan asked for monitor_finalize(), which doesn't exist.  Y=
ou then
> > >> >> moved it to the unparent() method.
> > >> >
> > >> > monitor_finalize() does exist as of about a month ago. It was
> > >> > introduced as part of my series that turned Monitor into a QOM
> > >> > object.
> > >>
> > >> I was on an old branch.  Sorry for the noise!
> > >>
> > >> >> My question for the QOM maintainers remains: is it okay to pair
> > >> >> complete() with unparent(), or should it pair with prepare_delete=
()?
> > >> >
> > >> > In general most things done in complete() can/should be undone in =
the
> > >> > finalize() callback IMHO.
> > >>
> > >> I can't see a finalize() callback, and I *am* on current master now.=
  Do
> > >> you mean unparent(), or do you mean monitor_finalize()?
> > >
> > > Sorry for the ambiguity. The latter.
> > >
> > > When I wrote "finalize()" I meant to say "instance_finalize()", as th=
e
> > > generic name of the callback field in the Type, which is
> > > "monitor_finalize()" in the specific Monitor implementation.
> >
> > If I understand you correctly, the code this patch puts in
> > monitor_unparent() should instead go into monitor_finalize().  Fair?
>
> Yes, unless there's some constraint I'm not aware of, it feels like
> it could go in the existing monitor_finalize() method to avoid having
> cleanup split across two callbacks.

I chose unparent() to keep the implementation simpler. The canonical
QOM path and mon_iothread are both still available there, so we don't
need to store an additional IOThread pointer and a copy of the path in
Monitor.

Given the current teardown ordering, the monitor has already been
quiesced or the IOThread stopped before unparenting, which is why I
considered this a reasonable trade-off.

However, if you prefer the stricter lifetime pairing between complete()
and monitor_finalize(), I can change it accordingly.

Thanks
Chen

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

