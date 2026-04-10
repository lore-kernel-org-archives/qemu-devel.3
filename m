Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3166AF459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEYW-000669-CL; Fri, 10 Apr 2026 12:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBEYV-00061s-7A
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:18:03 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBEYT-0002jN-IK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:18:02 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-607f1fac33cso757736137.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 09:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775837880; cv=none;
 d=google.com; s=arc-20240605;
 b=cbILQ8VTr17EQQOycRQEavkqqpRDKPAPfrth/qQY2oITVrrX+t/kDc9h6opTO8+FTy
 MNJTxpy0ENAVOGjags+5w36aNGuc9j9KPMG3xT0883utTpmCMYrCSuClUntVj0v7z2e1
 b0e2aCc7jH4imcYWNQGSqcuSa35TLGHfmCF750z+QunPPCaIVXQrtjttXxl2qGJDTRzm
 rkxUTIGq0fePHkn1X3BvofJKZEw2gXtTvPjx4PmPUxgBmKSKPCkIR9v8afpjsJtNBUtL
 Vf/oQ+oXWZuotUuUIRz/9ZKSefXpDBr8BnFQ0xbR+w7duez8NzSwNDhzpTqWlM6v9HCV
 aMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zb7LYTqGtSCK+gsuBQZ2Dvcd6c15n5rlD6NcR35ZKlE=;
 fh=6WPaczp89kVEvyqQhTtoSourPaOeS62pIBkgOKSIhVk=;
 b=doiJw9zj0B7pjkBRgHF/51KzKMmIAxQKFpsCe12PdhTx7i+26Ry5w1a76RDH+rR/Rg
 b4vMePngxrH5jFMksFh/+02A7S8reU0QwbEExmxLR2QuM4Fm6jmIWeUnthQNo2cNGPHt
 sqP3vFfgKIp/aZRm4rCW7KD6PhvU8+f3i4oBKGly5szlWhSFh5mh6xVp9wG5jVTDoVpg
 y4GkgLF185HIK+Yj+GJFHtGdH5K9NDHrfHZtmFJDK5XBeht62DXivEV282UE3FJw1ki/
 hDJ+S5dYHOFUD7D3fqIjLrWZ+nTQ1RZJ9Bv7juXhpPhq5IoqU7uXpJMJfXWaUJ2Fhz2S
 k4nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775837880; x=1776442680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zb7LYTqGtSCK+gsuBQZ2Dvcd6c15n5rlD6NcR35ZKlE=;
 b=d4xnjBtx7rutJ07mW2BGovqc76Mq/ZQO1JNTG9tmyIKIGaIJelsYYMdgb2aeGcQAXp
 RqhvW8zmadYrpE1+5cIk2Py45xG6ze2IMsfu2ClLWYq9vx2U7u3GMqt9AT9OxX2uXwVP
 Gl3Dft9CVNeNR8/mKklQAA3tIyZwIXxdHNLTBKxAFG2rrrqRArvge4URNpzZTHq+zJ12
 e6gnQtA22Ci5ckJsvIhxF3o6HUYJnY9NhCoOZQEOaKANqwZRqpzOFb79hSoyUYZt1EMX
 KPtX7hLwZCnqxNd7bPsrpswTvxnQHYVPqq05cWYLaOBNm6iki9B3lw5I0vvvljDY8rtH
 fH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775837880; x=1776442680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zb7LYTqGtSCK+gsuBQZ2Dvcd6c15n5rlD6NcR35ZKlE=;
 b=QSlwKHehOxwsbVuV4sTQWhMgcj6/EW9CUFJc743nweVRnvRGPOzywilXNebhVUNyd/
 OCBan+qchmyQUkMDodtK+Wo2MKUZzVJGjaOnq9tEsGKNLt0424Me0NkbPkTAYEMhKSaQ
 /VP8Xox12xDAXSqGykkI9IKbiqhjzUVwi6EaN5QHY2a8GGvo8BbGOCg1VYI/z+vZ0+2r
 /7u3RxMkjxsrI/fF4sR3plNCoCERkuuy1TF4KXUyZ74D34gNNUGtj/bZaqARx+prybiy
 vTM1wq9S+VGPwqXtPBEycCwx5KraVrzQEvI8QWML4+yd9UeRDmqQyBqFo3kF7ZBx1kle
 3OYQ==
X-Gm-Message-State: AOJu0YxD8mNjOgxUAbxXPIJPi5Qqy5qm2s3txZu8KKtPsc9SK15aS15k
 ulp5jpdIfMeZNxGmlY/SUI+5HpqrMIK9dSivnY0/iAHfer527l2WpBjy1t54i+kzBTmZXAlAbFU
 taM9HvC3BQ0dTLi2zInestg0Zd9dP8/Y=
X-Gm-Gg: AeBDieuh1Fvv0zgQnQ2GJOINhuIhfH0tr7oIBOmbrBoS0MJG0D6GcV/tsfJx5lkH8Uj
 og1gfy3MNDCDWDMIJoj8J2vlEhzsNNU3ETjBMAei7vqBPvDqzDb9SLNGtOmlvTKAYC9SJ9+Opgo
 L9gkrnUIGZGN/cIhXKNMp07pVcLJHJIZOGtLtfik50w7kfejhlgmuyFNm5i5j/mqkmE/rkqMNae
 IWVi7yC5OgtfkFA6knsxbxwhffG9Vml+c7TyPOke6Hkx2UM02Z/5ov4esWiqz1avCIV9YWNVrBF
 zw562Duzg+M4+WF5httuXjxE34NDOil6ebSAi1TPYwxRLQf0YgZzpyXeTCONyL7FmWo=
X-Received: by 2002:a05:6102:304b:b0:5ff:fbe4:8a4 with SMTP id
 ada2fe7eead31-60a00629e26mr1639943137.21.1775837880256; Fri, 10 Apr 2026
 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
 <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
 <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
 <CAFEAcA9CT9KeO1qmNg6YaCnjmvDG3-jeSwTjP4EnUqg4Hh8fSg@mail.gmail.com>
In-Reply-To: <CAFEAcA9CT9KeO1qmNg6YaCnjmvDG3-jeSwTjP4EnUqg4Hh8fSg@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 10 Apr 2026 10:17:48 -0600
X-Gm-Features: AQROBzCs8DBFvf3_uEY4GH3sVICM0ANwOMt20BhpJ9HRiLgR_8Rf0TVFmxX1a4w
Message-ID: <CADvTj4rZUm1opV8viEHB-BEuCoyj_+_Fr2UN6SEj=Dpkcg_xBw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Apr 10, 2026 at 2:13=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 9 Apr 2026 at 22:00, James Hilliard <james.hilliard1@gmail.com> w=
rote:
> >
> > On Thu, Apr 9, 2026 at 2:17=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > >
> > > On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > > > So this seems to be something used by the vendor SDK for Octeon1
> > > > but not Octeon2 and Octeon3 targets, kinda strange/annoying.
> > > >
> > > > I also found this:
> > > > https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html
> > >
> > > Ah, nice find.
> > >
> > > > It's in the Octeon vendor kernel here looks like:
> > > > https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.=
14/blob/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c=
#L94-L96
> > >
> > > Mmm. We emulate the upstream kernel, not vendor forks, so
> > > we wouldn't want to set k0 here I think.
> >
> > Yeah, I was trying to see if there was some sort of way to trivially
> > identify binaries that require this k0 support and autoenable a quirk
> > but I didn't find anything, maybe it would make sense to have a
> > separate runtime target for enabling this k0 quirk since it seems a
> > lot of octeon binaries require it?
>
> We didn't add this 15 years ago, and my feeling is we still don't
> want to, because we track the mainline kernel. If an actual host
> kernel doesn't have a quirk to let these binaries run, we don't
> need one either.

I'm wondering, is there any actual downside to enabling this quirk for
Octeon 1 binaries? It wouldn't actually interfere with binaries that
don't require the quirk right?

>
> -- PMM

