Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EAEC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTux-00089H-77; Mon, 29 Jan 2024 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUTuu-00088u-AB
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:51:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUTur-0006Wa-Rh
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:51:24 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55eece07a75so1700469a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706543479; x=1707148279; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YOHrhrtWvSSQBnWW7AYsrDCygVBx4ub6007RWrUVjEw=;
 b=lKuXC8p1aOQKsf88SBl1ovq5kuEVta1loQVyRBcP1Ova0fAiaEOTZ3C8w33QKnY3iq
 jVqbID/wVZ4jhBIe6yNKr2fAf6YCpb6hIdguq+6eAHnk6ixn4lpcdmxfKqCGVMtalsMQ
 9vCwLOWXRgG5Hs0sdr0bWa00Ie+zMrWn61cOad3p1d31eXx9YvfW1yMHlZhiORPv2+XM
 8o8KXoIXN7yz825A7EYJlpwRk7MECOidUYd7LtVWgshnjH5hGFhGXYqOgQ+tfBLDXZYf
 e7EbspxvaRJdjT9oz8A+G+pBffChv9GcMl79g8rItBZxWcrSRF4FiySCgTXkQB/MyFeo
 VU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543479; x=1707148279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOHrhrtWvSSQBnWW7AYsrDCygVBx4ub6007RWrUVjEw=;
 b=FZHoVU3C7zMIYIOM1uJjpu9R/T/Fd5JzuAxNs7lYP8iAsHQve4JwbWob2Mqo2DM4Ac
 eWPpSm0+gZw7PLRa2CikVtlX8L/SnMUlxukIyDFhaG0krvUrr/fi++VZ2nuTXI6LCq1M
 MS5eLvqXhm3BwaB68rm81/MY1PX7jAgqejCn9lW1cAy1ZkiUfBIvSkDHJHfPmdNIav/5
 VPEPZINSGJrDvOtqpVKTO6htuVYpwkQhxxfpC0T5naWlUTS6uxzBifAVmioZjQA82UoL
 kYK9BF0mfAvf4hkn6bUc66QlFHkeupCtxz23po9OBsKbXTW5u6/52tDblWOjAuQZZwHH
 QgQg==
X-Gm-Message-State: AOJu0YyMwkbQDfHO+cwLTUmE2B3ayRWfeCYuOMg1RIhPKPIZepsybr48
 G1stJ+qjapPyheX65Y2BzSDDA4eEnisxnGTOGdBlO88jHvRtOiOjzsF2GxR8yCNz7SNJpTdPM2d
 X6m8mgWfO1Rf/f4dfnGtx95mwtELXypsPKkNmkQ==
X-Google-Smtp-Source: AGHT+IHNNeP6vDGib2KxrGcIvqHL3I45NdMd00cVrT79zHu+xPLh9uNma++3iySvhJZJh/KeTXHXrb1tvAZI9dzZr6k=
X-Received: by 2002:a05:6402:27d0:b0:55e:dba9:45d with SMTP id
 c16-20020a05640227d000b0055edba9045dmr3251285ede.39.1706543479625; Mon, 29
 Jan 2024 07:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
 <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
 <CAFEAcA_uzJKuvY=iTnbG-xAjLn0zHRevzvjoyhjqqiBThveO3Q@mail.gmail.com>
 <87a5oodv7k.fsf@suse.de>
In-Reply-To: <87a5oodv7k.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 15:51:07 +0000
Message-ID: <CAFEAcA9Yzihj1dds3H=fmQZZ24ERDwGPkrxinb4tQHw2Ev5nYw@mail.gmail.com>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Jan 2024 at 15:18, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 29 Jan 2024 at 13:45, Fabiano Rosas <farosas@suse.de> wrote:
> >>
> >> Peter Xu <peterx@redhat.com> writes:
> >> > Fundamentally, IMHO it's because QEMU as a project is used both in
> >> > enterprise and personal emulations.  I think it might be too strict to
> >> > always request backward migration capability if we know some device / arch
> >> > is only used for personal, or educational, purposes.
> >>
> >> Do we need migration support tiers? =)
> >
> > We already have them. The tier list is:
>
> Ah that's good. Thanks, Peter.
>
> >
> >  * if the machine type is a versioned one, then we maintain
> >    forwards compatibility for the versioned machine
> >    (i.e. can migrate machine-X.Y of QEMU A.B to the
> >     machine-X.Y of a QEMU C.D which is newer than A.B).
> >  * if the machine type is not versioned, then we do not make
> >    any guarantee of migration compatibility across QEMU versions.
> >    Instead the aim is that if the user tries it it either works
> >    or gives an error message that the migration failed
> >    (e.g. because the version field in a VMState struct was bumped).
> >    Migration breaks are generally called out in commit messages.
> >    Often for machines in this tier the user is really interested
> >    in state-save snapshots for debugging purposes, rather than
> >    in a true cross-host-machine migration.
> >  * some machine types do not support migration/savevm/loadvm
> >    at all, because of devices missing VMState structs. This
> >    is not desirable, and for new machine models we try to
> >    ensure that they have vmstate structs as part of the minimum
> >    quality bar, but it is true of some legacy machine types.
>
> Hm, does this mean in some cases we're requiring new models to have
> vmstate only to never look at them again? Or do you mean some versioned
> machines are currently broken?

New device models have vmstate; we don't actively test that
savevm/loadvm works, but as with most device models we fix bugs
if anybody reports them. Some older device models simply omit
the vmstate struct completely (which results in the guest not
behaving right after savevm/loadvm); a few at least register a
migration blocker. Usually if somebody's doing a refactoring
and cleanup of an old device they'll add the vmstate while they're
doing it.

Any device which is used by a versioned machine type is supposed
to have the vmstate support.

> > AIUI we, in the sense of the upstream project, do not support
> > backwards migration compatibility (i.e. migrating a machine-X.Y
> > from QEMU C.D to QEMU A.B where A.B is an older version than C.D);
> > though some downstreams (read: RedHat) may do so.
>
> Here we still need to make a distinction between migration code and
> vmstate. If we simply ignore backwards migration then it might become
> impossible for downstreams to provide it without major
> modifications. But luckily this is the easy case.

Yeah, there's no reason for us to make our downstreams' lives
harder; the "not supported upstream" part is a mix of
(a) we don't test it so it probably doesn't work and
(b) we're not going to insist on patch submitters tying themselves
in knots over trying to implement a level of compatibility for
a device when we don't advertise that it's supposed to work

thanks
-- PMM

