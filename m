Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2632EC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Pm8-0006sY-Fm; Tue, 15 Sep 2026 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6Pm0-0006ra-4r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:48:20 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6Ply-0004BE-Dq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:48:19 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a64c7cdb46so5415024a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789465696; cv=none;
 d=google.com; s=arc-20260327;
 b=DqCZr9aPethm1hfxMek59Cw+0dF/wlX/lGl1VaJ4B/mzH/1/j069p32yewIwU6iDZN
 g74ZyqHo0sYz6FzHYviRQ2EoQOUSTVdJ1whumm/LJ2cBSgVhzYqareBjEsYxvGsY2GFo
 jZq/BROXdXJ3wz+eAd9QLKKXuem743zhf0+yV+Mf941IFHI7gw6Hjpv4+aXpwF8NDhM3
 2fjCvC71ke/Uz77jBI1LyY1UWkqX800+XtlLxlpTqOvgc+udu+Etvnf98pu1/3/uA4TJ
 BUQuDZxxMFRbbHgvHBhENzhn3JDPWorXH3RJcN6T6vAxtcHdU9k1zlmTxS2loUCEBwqw
 0CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SsBu4YyLp/fkKiqQ1bArvw+tc+teEBF/TycxUn6SOHg=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=WTKCWn6cvY22+G6/sLvkBk1KKo1vkgqTKNMQhKFspJnko9p9Yh8RLqrxBHwETeJAYI
 vsbKk5AzEKRGNtLcmDGHMXqaOh6t0mzcS38Gu4iljABVj32Vuy5DOP7hQ0nkiflSRVh3
 bEUoYiquqL8K+VsyC1HTn0WhkhvH5X5PWdJ3X4YrjNvDNVYHMeXbQRSKM8Jq5OT0Rg4b
 xwYTue+P/FkORsKRyAQLP3witxRnKQ/lnWx/VIQ2skok4TFLxHDnfXY1IRDziogI2prH
 eheOy+0cdupuxKKoHkSWuBzK7KZzcChryZp7tMJG3/sTy8BThwHCaCm568lVSjuNqGp+
 k6cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789465696; x=1790070496; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SsBu4YyLp/fkKiqQ1bArvw+tc+teEBF/TycxUn6SOHg=;
 b=axz6ceo4e58ntT21hjCF7OZLdTr23MU3GeS+hy0vvQc39PblegV6Bxo0+3ysXxM9LX
 WPxKD0w8DsW7diHF6iKdAJXxtrCaLFTvOJhqyg9DwMkQo5SdH2+4gaWMW2nbKoxYv0EA
 +I9cROIDe0KJ1yuj/joThuEb66eb9RiLP4hfdGv3uvcOLii8FmfSWcD6EYgdSMpiGAcm
 ADZH6vgiw74T0pecTlVjXTmrE6gMuI9Xej5xxSlPyvoVB2ZrxCbyChVbzbi2Zavh7WL9
 vx1dG0zGSMmkkk7b0pdEtk2keebr6t3dVdhAHXtZTC122jCNHip9Xd14YfKkSZdx3xnO
 C1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789465696; x=1790070496;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SsBu4YyLp/fkKiqQ1bArvw+tc+teEBF/TycxUn6SOHg=;
 b=JVUQJx+AOUALwLdO0ckXZ2bIHgysPmivxhgiqSEpN/UQziCXqIc2evQRhH4/5eF/tf
 eyNLORVuwsHEllAr99bx5fFdPV3UL2Az6+srSz+Xc99wMxnAINeh8vYzi9llb3ijRmfS
 jHyVYyolIJSBJHpOkJ0o47WpCIN3r7SWSkqcL9yXANO0bBa7c/IzdkZUUhaI7iE7GhcN
 NfHw1ecWnO0/rUQrMnIMKeaDnkeSvb9IN0ZTmnPO/onBZyfY1e0MGBrmffc2n7kQe9ho
 lvpxJrb3q75wb8by8vwnrnpF7onX3GoA9f+22tdcKGDyztRoZwjZJE69D0n6gPq1CdaJ
 q6PQ==
X-Gm-Message-State: AFuF++lOBP8FFaY3ta+vKKSfOrJchhvxYWIs1yYaJAulOvkpPjO214c8
 bTfTQ3rM5r2ZDp4tQqlC8KqbyoWzLdLZmsZ3YG/OJzrJuuUjFL/m7SZWSCr7GmBH6kIZWYYnvmw
 59LC9QplxwJGhsHG9Y4KgOSryXxTPJ7Q=
X-Gm-Gg: AYBFou3inZP6+l2uAKQxIfktoA51DdHbgsCiXrqm7bf7F9HLvqntLoflUoQmxYwvljJ
 oBm3ihMuLh2Dr+9tawU/EXV1DO62INuuVYHRcVXUm+Pn4rfG9Rpc8doid5nUqY4mfckGmQBXmI4
 nPbPlrEDKG+K8STLfPsvqsxoYkMocncmv95QAZNVxmLt3wgTr/qRqL63T1GkRsSUsx5+VxpZxp+
 MNSxd1+n+JCDrofIShFRyYU/Uvde1C6yu2ryNf6/3v8InQXtcEK2Bl5u4y1w2X+52Cpxnkylvid
 d+dFqwjwNxznalPLMeidGSLnT5lSeF3DGHd0LWLUHCbP10fFWPPAOSz7
X-Received: by 2002:a05:6402:210f:b0:6a7:ea53:f62c with SMTP id
 4fb4d7f45d1cf-6a9f641ad45mr4703487a12.43.1789465696175; Tue, 15 Sep 2026
 02:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260911100709.726366-1-zhangckid@gmail.com>
 <87wlss6owr.fsf@pond.sub.org>
 <CAK3tnvKXv+HdK4d5KXXNagUCODj68A1XRuP7VTpZNyUFoMTQnw@mail.gmail.com>
 <87pkyfrmsb.fsf@pond.sub.org>
In-Reply-To: <87pkyfrmsb.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 15 Sep 2026 17:47:39 +0800
X-Gm-Features: AcwNN1V2YxlCTCqxGJV7iPuv2d656XuhzH6Meyr6XBwHbbag-H3QdfdvPL3Wzeg
Message-ID: <CAK3tnv+D-nfjU5n_5xQ=z73PCUKTAK3xhSFdbHp1uC_7FHrjsg@mail.gmail.com>
Subject: Re: [PATCH V16 00/13] iothread: Support tracking and querying
 IOThread holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
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

On Tue, Sep 15, 2026 at 3:34=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Fri, Sep 11, 2026 at 6:52=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Doesn't apply to current master.
> >>
> >> https://patchew.org/QEMU/20260911100709.726366-1-zhangckid@gmail.com/
> >
> > This issue caused by the dropped patch 1 from V15.
> > https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg02947.html
> >
> > I assume that patch will be merged before this series.
> > I forgot to mention this earlier, I double confirmed no other problem h=
ere.
> > please continue reviewing.=EF=BC=9A=EF=BC=89
>
> The patch in question is now in master (commit f10977073c qapi/misc: Fix
> missed query-iothreads items), but git-am still fails for me.  Could you
> kindly rebase?

Sure, I will update to v17.

>

