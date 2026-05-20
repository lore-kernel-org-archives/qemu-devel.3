Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73280CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfEN-0003ik-0W; Wed, 20 May 2026 07:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wPfE4-0003cd-Gc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wPfE1-0006Ey-VP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779276990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8M+x+8gtyfIl9Vy+LECc3Yh/mB55hd6HcJ06lEoyNc=;
 b=hD+1th8MNs10BLeo3IDpo898Ud6x6YJyT+A4dm9dY2yfbz7bKSFDE5J+idPelqGR7lJhgn
 Y/OPMgCZ1ayhVRbFMrM/+xoJscTSKRHO4MrBL94UM/gv5UvIg9gqpgnutW8dc7lXHai7Am
 C8lwtUE/2Ckihooco8iPSkiE1+CiWFU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-GkCUoTmmMnCGdEgGy2gUsw-1; Wed, 20 May 2026 06:25:19 -0400
X-MC-Unique: GkCUoTmmMnCGdEgGy2gUsw-1
X-Mimecast-MFC-AGG-ID: GkCUoTmmMnCGdEgGy2gUsw_1779272718
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba86e35aa1so81136295ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 03:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779272718; cv=none;
 d=google.com; s=arc-20240605;
 b=P1DB+mEGLlk/fUxsNV3LmZ7cSR+ipYsgu+fugPok/+2V6SEfxpa+zISTJIzeveaCIh
 +hRhOmX71QQXLTNdGRgX6lzgdwEIjvIK8ZHEpNjC5nWYP1nQeU9duiHDmbJj9vE0mvcM
 YoJaFx8C4n710hm75Y2Z4mhCnmRQ8G6QQ71kWgvZhCG0EzCiAL1x3gqDwjtj+yVWjsOK
 XCvPFCuyCSrQAZryN0AQUwmZY/qW5o/C6M1WCIG/GZKTtxs5p6Oi6//KStmQpSG5hRK/
 kPGjxkvKF1WslXMIzHRQSo9NdfLJ0tSMa435Oh3/gdx/VF7sS5P5/pU87m9a94LmIEet
 s/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A8M+x+8gtyfIl9Vy+LECc3Yh/mB55hd6HcJ06lEoyNc=;
 fh=BT63/GmugqRjbhOT5EjOf23nUOTYBVyBX4dCJhLcb+0=;
 b=Zvx5rNttf+dKmG6AGcpvNlxp0jV/O8LpC//C/WH7Ah9v5Y2uSu/HbcKLXl6Bz4NTbf
 gwa0s5tIX/I7fKUnFG/RAdAHymRAEezfNOD98iSJZMCYW+YltzGo6nsncykd0fPYktkG
 grU+VKyEqTSIPcAOzI7E9/fPglRFXRoaI2PJ9UVmZAI7f0v3KSiuSyCJ3ak4yJYVsKfi
 u4Oz1iFx0HbBY94tDsl/6ba01WCpwt67xQazR1meGvBuRPPHN+8VnQMnLbvbA1AQv81m
 Lpo4CzHV7at3ICXEEWGuiVyAl60bRwOmOsqXeAyiWbNYDV5ORodC/m76naGbR3YFCuAu
 AQnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779272718; x=1779877518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8M+x+8gtyfIl9Vy+LECc3Yh/mB55hd6HcJ06lEoyNc=;
 b=gwApY58lNwgw3ksjoCgNxpnJH2iyVHJtPjw+noI6NoFDdQA/s3r5C7ynbvO55CL8iI
 Iy8NTUHWj1Gfoi6qfE3arikyypPzuv2DpSTeoOSX50UiT9sdZomorjxaxmtO7rRqGX3N
 2F/nnDvwwRNeXwJ6fPX03EteBU7V6n1oAfcqa/eo9kv9OJCpireANNGUWMxjoLpUd+ei
 3ER5oFNWV1MnxuYpnlgShZho4gM6lNQ3h+/3H8ln42mkpMtxCc+WKS67IdRpDNgOUujl
 HAGxXQPbsuERIbQk1662T5BlkV/EbmaXcofLLWguTNQEKAOhi1If2OoxAO3dB0a1lmGV
 RoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779272718; x=1779877518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8M+x+8gtyfIl9Vy+LECc3Yh/mB55hd6HcJ06lEoyNc=;
 b=ht7mvUjG3yrvhKxfEH1WL9yNLfS0SUC05rS1mpRPXUWKYWa33CG+nv2l3ecdmqHqrY
 u8RvlaPQUwb0UztkpaZjO8eJfY3Rox+TOGcq45KOMD2dXcLS+G5TGTGNQG+Evq9qGWBX
 XACRLtmosqoMuPCX0tG+sLuEm++uoNGOk/sbzilDr334wzqxWWOkATUe9yPjpHXGV0rK
 EC2k6+0ZxH7tVHjEA5XOacvHKRzpiYPBk6h3XOcOsUUz8zlDDuQbFdDSVodg7hGc8PP4
 EDiCg5eQoSibrXp1J7+C2ZdrAyhLrJbPzdh6KOB9oU4XZmrn8i7sQevS51g9CYtKbfJE
 49uA==
X-Gm-Message-State: AOJu0YwiBj6DMWeAOQxM4RaCBQYgHywmtRGY1zcz/+YklXmjCZT7x5DR
 0KKdIemgQpZHUak/LTUieIepLliBSSlOytf4fVTlucvwSf+8OxI2y4OsplWB7NfBMYc7Pm4slN7
 95l1Dvf7/kd/c/QageWEKqNwBKXYbBvTgha/hrjFdCXFCgFU7W8Re1JA7JU8/8sq0l6dw3/oixU
 qH7Qf5lDfpJ6Cs/Jb7Pr5dMc9h+JfnjTU=
X-Gm-Gg: Acq92OHzfjG5Kf0aIrLgESGICO8JSVKmYv5wlW/PSt/R0ZPOPlRk/VVWOaZGKgunUtr
 WbDk/n5bYe0Pu8/eh9WlUdzR8vtNxaZeYIJlbl5ri3PkyD7UdtQVD8msga8CNno/I31gXA3whiI
 jT0UWH2Dzreh8PuKS7jufMxJ8BeABeL325lVUQJ+ky/bxPj9I60RXb/LqIfaSVRUzpnuKUk8mky
 0/R
X-Received: by 2002:a17:902:a603:b0:2bc:7d1d:b677 with SMTP id
 d9443c01a7336-2bd7e94539cmr180488745ad.36.1779272718208; 
 Wed, 20 May 2026 03:25:18 -0700 (PDT)
X-Received: by 2002:a17:902:a603:b0:2bc:7d1d:b677 with SMTP id
 d9443c01a7336-2bd7e94539cmr180488355ad.36.1779272717668; Wed, 20 May 2026
 03:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <agxzKzzDOJm1EU_v@redhat.com>
In-Reply-To: <agxzKzzDOJm1EU_v@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 20 May 2026 12:25:05 +0200
X-Gm-Features: AVHnY4Lj_gAM3P2xpRq0BD6fpdl6tHAqSSXpfww0TaQTwGCWiv9BRwEAjwEOXd0
Message-ID: <CAA8xKjU1CsB5RVT-qXUHTjtL_rLe9gSpkBxvohBfGC98BTuYxA@mail.gmail.com>
Subject: Re: RFC: GitLab issues for security disclosures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 4:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The qemu-security mailing list was created several years back now and
> traditionally saw 1-2 disclosures a month at worst. This was manageable.
>
> Since approx March 1st, the new normal is to see as many as 20 disclosure=
s
> in one single day, more than 200 in total now. This is unsustainable.
> I was thinking we needed more people on qemu-security to triage, but IMHO
> this won't really fix the problem.
>
> This needs an issue tracker to cope with & email is not an issue tracker.
> We faked an issue tracker with a shared spreadsheet to prevent us drownin=
g
> these past few months, but this is still not sustainable & probably won't
> ever be.
>
> The traditional POV was that security disclosures must be dealt with on
> a strict "need to know" basis until there was a concious decision to make
> them public. Typically that happened when a patch was published by the
> maintainer on qemu-devel. Rarely have we applied an embargo period after
> a maintainer had a patch ready to post, as most bugs were not severe
> enough. Also in typical usage Libvirt has SELinux/AppArmour to mitigate
> impact of a guest ecsape into QEMU.
>
> QEMU is not alone in this chaos, to quote Linus
>
>    https://lkml.org/lkml/2026/5/17/896
>
> [quote]
>   the continued flood of AI reports has basically made the security list
>   almost entirely unmanageable, with enormous duplication due to
>   different people finding the same things with the same tools. People
>   spend all their time just forwarding things to the right people or
>   saying "that was already fixed a week/month ago" and pointing to the
>   public discussion.
> [/quote]
>
> They have explicitly changed their policy for disclosure now:
>
>   https://github.com/torvalds/linux/commit/a03ef333fbd6cd861c8457c3d055ee=
3643a9baad
>
> [quote]
>   If you resorted to AI assistance to identify a bug, you must treat
>   it as public. While you may have valid reasons to believe it is not,
>   the security team's experience shows that bugs discovered this way
>   systematically surface simultaneously across multiple researchers,
>   often on the same day
> [/quote]
>
> IME for qemu-security we've definitely seen the same bugs reported by
> different people, within days of each other, a couple of times even
> the same day. Dupes are not the majority  - QEMU has so much low
> hanging fruit - but they're a sizeable chunk.
>
>
> Because we don't have a good automated way to publish disclosures
> from qemu-security, we don't provide contributors any way to check
> for duplicates before submission. The burden of checking for dupes
> thus falls on the qemu-security triage people, or the maintainers
> we forward issues to.
>
> For disclosures in the non-virtualization use case, we ask the
> reporter to file a gitlab issue or send a patch. They almost never
> do this. We're lucky to have any reply to emails at all.
>
>
> IMHO we need to move to an issue tracker. GitLab was originally
> discounted in favour of qemu-security list since "Confidential"
> issues cannot have visibility managed in a fine grained way.
> They are visible to everyone with "Reporter" role or higher,
> which is 70+ people for QEMU.
>
> If we accept the kernel's view that AI discovered issues should be
> considered public immediately because of the high chance of parallel
> "discovery", then GitLab's limitations don't seem to bad.
>
> It is also of note that we've had some people ignoring qemu-security
> policy and directly filing public gitlab issues for stuff discovered
> via AI/LLM agents already. Those are not getting attention for CVE
> assignment, should it be needed which and can't be cross-referenced
> by general maintaniers to stuff we have received via qemu-security.
>
> We have some options IMHO
>
>  1. Move all security disclosure to GitLab confidential issues
>     no disclosures via email
>
>  2. Move AI/fuzzer assisted disclosures to GitLab confidential
>     issues, keep human discovered issues on qemu-security list
>
>  3. Move AI/fuzzer assisted disclosures to GitLab public
>     issues, keep human discovered issues on qemu-security list
>
> In all three cases, if a GitLab issue is determined to be security
> relevant, any maintainer could send a request to qemu-security list
> to get Red Hat product security to allocate a CVE.
>
> Out of those I'd probably lean towards (2) which is slightly
> more restrictive than the kernel new policy but not by much.
>
> Some key benefits of using GitLab for security disclosures
>
>  * We can trivially make disclosures public if we classify them
>    as a non-virtualization use case, or when the fix is ready.
>
>  * We can formally track the lifecycle of disclosures through to
>    the final fix, for both virtualization & non-virtualization
>    use cases. The only difference will be that the former can
>    request a CVE assignment
>
>  * We can do reports/queries of outstanding issues
>
>  * We can more easily use automation to process issues
>
>  * Maintainers can see bugs without waiting for someone to triage
>    and forward it on their way.
>
>  * The small number of security bug triage people are no a bottle
>    neck anymore
>
> Some downsides/implications
>
>  * Every disclosure in a confidential issue will be visible to every
>    maintainer who has joined the qemu-project repo on GitLab. IOW
>    that is treating every maintainer as equally trusted.
>
>    We do have qemu-security though we could be mailed if someone
>    considered their disclosure to be severely impactful but the triage
>    team can't make that decision.
>
>  * We must NOT grant membership to qemu-project at a Reporter level
>    for anyone whom is not an active maintainer. They must be limited
>    to the "Guest" role at most.
>
>  * No one is formally responsible for GitLab issue triage. We have
>    had Thomas do it in the past periodically with script assistance.
>    We have Alex doing some of it now with bot assistance. The danger
>    is security disclosures get ignored as "somebody else's problem"
>    no one has accountability.

The benefits of moving to an issue tracker clearly outweigh the
downsides IMHO. Given the current industry landscape and the
escalating volume of disclosures in RH Product Security, I am no
longer in a position to effectively support the QEMU triage process.
The move to GitLab seems necessary to ensure sustainability going
forward. Option #2 sounds like the best compromise, though I'd be
totally fine with #1 (no disclosures via email) as well.

Thanks,

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


