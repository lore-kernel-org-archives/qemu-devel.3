Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB14CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcZT-0006in-TL; Mon, 08 Jun 2026 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wWcYt-0006By-SI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wWcYr-0000P1-Hf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780935048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw/Zlg2kKsHElmqY0RSlpzEUxJBz+r0l0AX25v84Yqw=;
 b=Xjm4xDT2tO1rx/R2gfjNtr7BCgW/fPR6SrDf9dSecVwLRR4BC/vtZ7PlIkdf6Ha7CNZrf/
 ll6CLnxeS8nzQEKdmXfy2SKKIhzyEDSH5aZjTAGHqzAKLFLviU84KGBtzVviKzHu++vt6I
 7AfIbADlhihfpcq6rZdlhQMSDS55teg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-m0yLihRkM9GnrQiR-hemmQ-1; Mon, 08 Jun 2026 12:10:36 -0400
X-MC-Unique: m0yLihRkM9GnrQiR-hemmQ-1
X-Mimecast-MFC-AGG-ID: m0yLihRkM9GnrQiR-hemmQ_1780935035
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8428419982eso3847072b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935035; cv=none;
 d=google.com; s=arc-20240605;
 b=cZOaWaM3xJgDZo0oIQLWJ7hQwTHqjLSkITkEcMP/SQ75gLNQoVq/AU/n1zz3BrTXcx
 G1F21XztLsA7N6qoY2yn/r4Q+bHdz7+0V3Wzpr4nX/gZeMObPNxSrmdIMhnVSlWou0k0
 /TcZkJ/SiycAqDTO6UmPunblOyA8iifTCgNBIetQVMKq8faBVVpLWPLA8xKiQBbz1OdE
 u2yYc6sPty70u1mLPiL5qBIGdQ+TH46pKSmnShLG+Lf2v7Z0aNtAarUgyEx1sGxvh3uY
 erYOQdicYY6//CKZNlLCiv1GlwqD+k1sEWI/on8W+7QY/oQsntgVipWcWtN4VIUJMqh+
 0WsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dw/Zlg2kKsHElmqY0RSlpzEUxJBz+r0l0AX25v84Yqw=;
 fh=/7u6kWjSJTv3U77d8Tt3ruvRubiPIwzyxEw6EJeEfRo=;
 b=CILS7rCyTShXV1Sp5C01/fS3hs8PLqO+bTIHqdfl/gI4Do3ZG/AyVSHejo5GSd17zp
 sPJB27P+tBzmpMzXgcreVwmbuhHsmQcgH3HwsClafp40jSUyBGfYVvwfCyH4z2L5iCWq
 f7oitfSp71aP2rtvzUl0Z+9FCrxA2WQo3/mr0/zt4BENmKFAVnBg2jMt9uCN0OaAMbUK
 F+LHnky9MkPMaFRALo4+USpQceRLJwnHNQ0iN0a4v4BRYyQmuwbR0C/sJ/oSVISAPiI1
 FDfF6X032qLebl981WKGudvtDQhSY5ts7L1RbZfya4w6Xw8nytLEfjcK9RJJhJG2Ebt2
 ue0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780935035; x=1781539835; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw/Zlg2kKsHElmqY0RSlpzEUxJBz+r0l0AX25v84Yqw=;
 b=IPbJK/cz4L7ezbYmlcQx0Ehy2YrYBXFkCRrDw5vRa42cxECSaNEgdXEU+xXdhSUUR+
 /DHaZygylp4CF+yZgCpaZLtq5e432AerWhM9PuG5cTcpRgP53+72wVC+2dBvObzqP/N8
 Ao6B+pAKdNYbuQsZEbjw1LBlLRyKe2niwOIgff+qf1gqWTDDq14TwzlC1AEO/Kxw+TTT
 g2n1c1nQPVIy/gG1zqKOH/IcxI+k/ddM0tK6UR+Z5v+l1rw1duYKzTLU1p/C3N79ki8i
 gaGrRhVc3TgCJmiIxMFWKIEl7oNiRzUHYWC/OUPhKbFVKKPM6DhzBnBqb4qCcRY2+aEN
 Lvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780935035; x=1781539835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dw/Zlg2kKsHElmqY0RSlpzEUxJBz+r0l0AX25v84Yqw=;
 b=phFHkMVUQJNgjGAov991xrPXuts8eYy5o6x+H2cQeV2OtJPrJxATSySNiXGzi+Bupo
 eBUtOvWnzyrel5X55x4d0HuUcsQ45yoTPh6tKjwHX9d71XaKgeKkaHvsCJHQdyD3+AI+
 5+7qUj48iwVJTamseVcVlQmXCBLFyBLIGD6ANTWXcmiuwSYQP3CRz2Vhv0/ygIz/Ahso
 7RxNvr1PCVuxI3XFilmuzQPftRTXOu8fikpIPHHGnNY1q6TNIM9e5TRH95sFVXV3Fsjc
 2XygwGMHQVN6D4g+S8c8oMRjHacedckvsPOWm1XciiR24TRLH+Q55S6p2CdsQbBRIyzm
 sT1g==
X-Gm-Message-State: AOJu0YwbjvJ4UZ1wh8sxO+53GibqzCpmW9j5v0AviA8J6ASfgasXerwE
 C6UxBx3jBlNKp3t+3UwEtcqQK8Q6f3L45XfOUsH+FTHWeBWqAuExx6h9EGqRdKrerAGTQ2p0F0Z
 3LJX2lMjAexCMb1dR9hdCUnDqhHusb6c6zrhM7K7siHi66dFsKo+7Id8kAIKzXiorEY2nNdMBMJ
 2lQ3QCdeOI5XD2XUd48sAdNXvCs0bF2FA=
X-Gm-Gg: Acq92OFeBFiHg8W+NXPIs3CyzGMwxDWsCluI9W3kNAFNVpw/V59f3x79nHsPOJKDZEP
 n6k/qy++s6Nr9m/nvo8Lq4o8LVePHFFvJ7wyNVrS6pd1xN0CYVM5uzYOM8LVflq31zLzTcA4IIS
 YBA1qqfZPRpl7KOCV1YkZOPvzsfkKExpIOTHbDLzOheUx7M8grlOMhiM74dHB/7bSgKkehi9FJo
 eoYdsxv6SUra1M=
X-Received: by 2002:a05:6a00:2d10:b0:842:4a39:6047 with SMTP id
 d2e1a72fcca58-842b0f514c6mr15725357b3a.29.1780935035152; 
 Mon, 08 Jun 2026 09:10:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d10:b0:842:4a39:6047 with SMTP id
 d2e1a72fcca58-842b0f514c6mr15725323b3a.29.1780935034605; Mon, 08 Jun 2026
 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260604165048.457860-1-berrange@redhat.com>
In-Reply-To: <20260604165048.457860-1-berrange@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 8 Jun 2026 18:10:23 +0200
X-Gm-Features: AVVi8CduJleZgFyB_oggVAtsXvvZp4YIivOmwOBXl81xZaWKvs54md-q57ZRoVs
Message-ID: <CAA8xKjVx6Da3SHkg-bNewk5yZFUSrrHpxMr2EViP87v=_zDN=g@mail.gmail.com>
Subject: Re: [qemu-web RFC 0/3] switch to GitLab confidential issues for
 security disclosure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Jun 4, 2026 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> I previously raised the idea of using GitLab issues for security
> disclosures:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04582.html
>
> This patch proposal formalizes that into a concrete proposal:
>
>  * qemu-security is entirely discontinued
>
>  * "confidential" GitLab issues are to be used
>
>  * The priority is to have a low overhead process that is
>    as close to normal bug & development workflow as
>    possible.
>
>  * No embargoes will be accepted, beyond the time needed
>    for a maintainer to develop a patch, unless extenuating
>    scenarios apply. A vendor's/user's desire to delay to
>    suit their arbitrary software upgrade schedule is NOT
>    an extenuating scenario.
>
>  * All confidential issues will be expected to be made
>    public, either when the patch is proposed to qemu-devel,
>    or sooner if a issue is low severity and a patch is not
>    a priority for the manitainer
>
>  * Eliminate dependency on any single maintainer/person to
>    the greatest extent practical
>
> Some open questions
>
>  * I describe using "cve::required" as a gitlab label to
>    track issues that need CVEs allocating. I'm unclear what
>    the best way is to actually do the allocation. This is
>    where it is hardest to eliminate the single person
>    bottleneck / burden.
>
>    Traditionally I would email Red Hat product security via
>    Mauro (CC'd) but that's still a single point of failure.

I'm totally fine to remain the designated PoC for CVE assignments. To
mitigate the risk of a single point of failure, I'd suggest directing
all CVE requests to secalert@redhat.com with me on CC.

>    I'm personally not willing to sign up for QEMU to be a
>    CNA, because they have unreasonable expectations for
>    volunteer projects. I'm not going to give them my phone
>    number nor agree to any SLAs for response to query.
>
>    From a selfish QEMU upstream maintainer POV, I would say
>    that CVEs are largely devoid of value. The people who
>    care most about them are the downstream vendors who
>    ship old QEMU versions and track bugs for backporting.
>    If we want to pull a security fix into our stable release
>    branches we can do that easily without a CVE.
>
>    Thus one nuclear option is to say "not our problem" and
>    no longer assign CVEs at all. Instead assign a unique ID
>    of QEMU's invention "QEMU-SEC-nnnnn", and let downstream
>    vendors take the pain of allocating and mapping QEMU's
>    identifiers to CVE identifiers.
>
>  * We have >100 disclosed issues to qemu-security
>    that were classed as non-virtualization bugs which
>    I asked the reporter to file gitlab issues for.
>    Almost no one followed up to do that. I don't want
>    these bugs to go into a black-hole as they are all
>    basically valid, but I also don't fancy bulk filing
>    100's of issues from my own account.
>
>    There are also more non-triaged issues some of which
>    are valid security bugs which ought to be tracked
>    rather than sucked into a black-hole. Again that
>    implies more bulk filing of bugs :-(
>
>  * Moving away from a small dedicated group of people
>    handling security reports, to a distributed
>    responsbility has a notable risk - every maintainer
>    may consider it "someone else's problem" and ignore
>    security disclosures. Some poor sucker then gets to
>    run triage across an ever increasing set of issues
>    and try to encourage maintainers into responding.
>
>    Based on our experience with normal bug triage work,
>    I'd say it is a near certainty that this will happen
>    to some extent.
>
>    I don't have any answer here other than even this
>    bad outcome will probably be less bad that the status
>    quo with qemu-security email disclosure. Personally
>    I can/will not continue with the email workflow any
>    more.
>
>    IMHO this mostly points towards the downstream vendors
>    needing to invest more in QEMU if they want to have a
>    guaranteed security SLA upstream.
>
> Daniel P. Berrang=C3=A9 (3):
>   contribute: reformat/restructure bug report guidance
>   contribute: add automate tool disclosure to bug reporting
>   contribute: switch security process to gitlab confidential issues
>
>  contribute/report-a-bug.md     |  63 +++++---
>  contribute/security-process.md | 280 ++++++++++++++-------------------
>  2 files changed, 155 insertions(+), 188 deletions(-)
>
> --
> 2.54.0
>

LGTM. For the series:
Reviewed-by: Mauro Matteo Cascella <mcascell@redhat.com>

--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


