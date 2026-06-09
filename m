Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD35CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX2OB-0002U2-ME; Tue, 09 Jun 2026 15:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX2Nu-0002SU-OB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:45:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX2Nr-0002vd-6I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:45:14 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso9545185a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781034303; cv=none;
 d=google.com; s=arc-20240605;
 b=M1IpgEJZlhGgMbgZj/3gjXNJQSL3w7WWpYQAzp8NTmjRYm1nvGvyzK9ASS7eZlxJ/k
 tzyrfOC2Gl89G81KI3ayLtkrwM3LBeSzLj7/B3b8eHNWHUclGQvUP2URzRT8/j9Sj4u2
 nX/BJDptMy3vFmlYH3/YDY5bjQOX97KWDcxW0stLVoNvOHEtfNZnKR0bTFItHf6KhsiS
 VQ5oK7sUiRvqmwhO57nxNsXG9OF39rCsmqj5eyCpVscLduueo1FUOs/rros9NYFn7oZ/
 DdpaBGp6SSkcn2eLPfXQemRIIk+X7FdtCnlLdfT8etCdPyni4DZjehDQpckYO+AnFTxL
 Nfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BE7Ko1oGowdeONq1GamB/EWpz/mRKOMtMNEs4H2sugs=;
 fh=vqrzZycoj7Zksn5GnGKdCDZ4+QtX1xf4W5pl4Axwslc=;
 b=luSltoYFZbG84VwoClCBSpC7/1FXSRFvA64bJE2GfLAUPPqHSxFiRQhsOpeUV4H2fs
 YBeDMAA3TJ8+OseL8NKSTiAQGppRJIqqu+VDskXOk7Age7vW9i4vOPOoTnBIqZszO9S7
 a6KQr/JWKZLulURyIESOFx0Qq0IzAKfUoGGi5Bwfuz9kerc3KFAJIDZTNnE0Y2kTYyIs
 3fl9+2jNSpgNyY548ZahW7bd/91x13pWmiX/qtsUCZRCktOC8xA0WwUl+itNM0qZU9u3
 qy9z4VIQyt+NWP4Dadr0OrmTGlSX7Lg55kQGw+zcFVYVBQuKhu/b/oXsh2le/Qxtn199
 KB1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781034303; x=1781639103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BE7Ko1oGowdeONq1GamB/EWpz/mRKOMtMNEs4H2sugs=;
 b=I0015rtdMg/VcnOJemhwo+C4J2sGRluWCIfJWOv1wCH8NiLWqWbmxPnTYfKvfT/cgI
 ovKSdiBKiHWbxJ9kuwpnl1cQKKyiQA0KdPTSae1sqkIBCOGfbiURj63wlzLkSiP+GU0K
 UTPITeNMkuveHioF7u+ft+ma+iXOCgg90gOM70fXtFZoD6VTNOaHIMOQfSuvpMMGTPuN
 4oRqpZatSxKUSOqQTIuGX3UbNGyTlFj/6EfLrxvrKuA+V3gT1Vdget/qO9VzCOiQjGI5
 Qs81BDIiJ21FCbwqX7+N8O1TdpOtyJncCtmbIJezqIxgbGghIL4ivHzK5wxoCfVBRX/c
 DVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781034303; x=1781639103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BE7Ko1oGowdeONq1GamB/EWpz/mRKOMtMNEs4H2sugs=;
 b=Y7+M5Li4C4CVaJhDSYYeCFkqoIoQeuUw6gVWUUsa0VKla7NIH5jWOF/FHayY+VBpvL
 wv87DKcGJSwbwCw2mprWl9RmQoeGeDOjNceMG8+dzgkbVt0FrFEkH2Y1z0YobPvvIDKl
 gwjk9N8/x4+2J/+mMx/NATXlyt3wPmKlUPqWTmTJ2Q/WPfWyeQFBUmYi95DnFFSqeKgJ
 CDheiqvvMgFbFYRDlN/5VOgAtSndzsdRvl9a0OF+JwRJKH54vAfEyxznboucEHShYpJX
 bvvS3lqpUBBFyfi2lBqi+fiaC3+hGuwtM0lY+yxLKsL/MSnV5V4qyz6IePpcqw8FLMHG
 ZhIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w9AEHbWyjroYLsHa+JBOcx/xF1ZuF7tvXVU/uGKh1royPcZG6J9UfzLpzHRS61lshnT98kkDV1JOL@nongnu.org
X-Gm-Message-State: AOJu0Yx8pKT0iilmZXhBv2ofAzsLMBehg9oQ5/rVU8oXDXCvr+Uj3P21
 k+mnU6NiwPqyVEY1OliIDIANaqtkedH+zFm0962D9j4OUmupQfQW75oPZzAElmSq9gEPiYX/jut
 l2olCoGHAt6LqA+FPP9Yu3DRfYCAv4Qw=
X-Gm-Gg: Acq92OGO2L3O2OUQLMixd+TRcOtqnKevL737wwhtloz3nCALm/iTAZxLTLickdChS4V
 7jTwOnHRkEXSoScfHmoW2HkZnLDrmpzOXoiVAyL3HDG6bY2Xpq5CS+5qSqOMejSwwAXr1IX2Spq
 F8wDwRpxEcpSZsAbRuCVafeOW8vteihh5ELm2PXX5Zv4hLMfbObQ8IkYKmjDgipGfijuBBernUK
 DwAseYMUyrkruxFsKQ7RvSPk7Ouys0ur77su4rWZn350OYFA+eqaJRvZgllaG2RX+H8DvCLl7Ow
 Ot401uTlUWycksCdPA7w3XOulZt6alwYlAgCjQFhH7uiJarWGFBm
X-Received: by 2002:a05:6402:1f4d:b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-68fa514f190mr9485302a12.19.1781034302882; Tue, 09 Jun 2026
 12:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 9 Jun 2026 15:44:49 -0400
X-Gm-Features: AVVi8CeOU_UjeX8pKpWwxfHWlT6xWKtHGFtnqCyuy53gNj7KSf-xnTNXUyj0Zfs
Message-ID: <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > I'm not sure if anyone brought up this topic on qemu-devel and with
> > Michael before. As I mentioned in my reply, there are ways to avoid
> > blocking vhost-user spec changes when qemu.git is frozen:
> >
> > The simplest approach is to keep merging vhost-user.rst changes during
> > freeze since it does not jeopardize the release or introduce
> > instability.
>
> I'm not enthusiastic about having "this one document is an
> exception to our freeze and release process". Because it is
> only documentation, it is in the same "we can be relatively
> relaxed about allowing in documentation changes" boat as
> most of the rest of the docs. But docs changes can break the
> build (e.g. if you mess up a rST syntax thing), so as we

CI prevents broken rST from being merged (there are multiple jobs with
`--enable-docs`), so I'm not sure this can happen?

> get closer to the final release we are going to get more
> strict about "is this change really necessary or can it
> wait a few weeks?", and they must at a minimum continue to obey
> the "no changes of any kind between the last RC and the final
> release" rule.

Why is the final release candidate special?

> And definitely if a patchseries has both
> QEMU code changes and documentation updates then that is
> going to not get applied during freeze if the code changes
> don't follow the freeze rules.

I agree that code changes cannot be merged.

As long as the vhost-user maintainer is confident that the spec change
is implementable and stable, they can merge the spec change on its own
without code changes. If they are not confident, then the spec change
isn't ready to be merged yet.

Stefan

