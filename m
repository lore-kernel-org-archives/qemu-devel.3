Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34F5CCFA05
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKOI-0002rS-HA; Tue, 04 Nov 2025 12:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vGKOC-0002oy-TM
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vGKOA-0007Bi-SJ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762275607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DSmoM0v5fBi9YU2R3+x5NPUgw/PQmMTdUB2A1/rLjbs=;
 b=itXidHU2lzLN839Kob4DCWW9PQsgnxhSg6j77cOoWVO++rtpwDyVMYOz4ESD5Mry/mzP2M
 odUOyTMXwOiA41pasvzYVPkIRiEJjPrmZMNscNCMvUPq1UAtfc0V1zGfxQ8RKxREleQ0X9
 uMKgmHsN6Kv+fN5P+gVDj662P3YsKLw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Q_qbS0idNh6eI0ZtITnXJg-1; Tue, 04 Nov 2025 12:00:05 -0500
X-MC-Unique: Q_qbS0idNh6eI0ZtITnXJg-1
X-Mimecast-MFC-AGG-ID: Q_qbS0idNh6eI0ZtITnXJg_1762275603
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7178ad1a7dso193277366b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762275603; x=1762880403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSmoM0v5fBi9YU2R3+x5NPUgw/PQmMTdUB2A1/rLjbs=;
 b=F2RFc9G1g5SDRXikHcOmvk1esAoyXSyH5o9dzcIuhO+46v5u3CrY23VQiqu1EP0Ap5
 DLKlttysKuY5s5RK1bDusBDk60EQkhpNB8c39nAhZnk/Kdvki4YIooBZ7aU7CYzr6pJU
 zUQHLImkmlTYrjU6yyvAHWu3jZH1dTgrRJW2ZhZSldQvcuLgcId90/bQW1W5lEM2wB4A
 GDZmV9V9e3Y3wER3huzSpjk+euRPE6ANzskm2MEg+YpJPGWHjUE02iSJfqYukGKmQhsx
 CGtFFOzBo1gtUJLLSt4L4wYxwGbX+ZqW/4OlRFscy6c0M/PtsZdh+7iiGHSds5Sy/gND
 spLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275603; x=1762880403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSmoM0v5fBi9YU2R3+x5NPUgw/PQmMTdUB2A1/rLjbs=;
 b=FqdXc9pJBfuy61fHP0Q99d8f00AWyB+0Ng9g1fjHFX1VBDHhScjqg2TLGugSkrbael
 aS5wi11Dbp2KfPar3hgFSh1qkB2AFNovNtmW0zSDfvwJx/hMJVnMbU5xUVvO3TBDSTvY
 6d/7vHz5C2h08EroudmrEzuKtwPxLbhy1ErmIGDNUduz487/KWR6e9uLVG23cf6STPk/
 iL3TAUpFdNsCcJvQINNTGSYpo90SZAUaIQnz28XbVEd6pmdgAJJNzG0hrjzwFLbiLLUi
 wo5JDrKN838ImZEr3DtJnXkJEGY2PXeF3nMNHbqKhEhSI76mRaaxPqiL7wiPyj5k40ug
 mi5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoHf9uayj6sFK9vz+lu79jt2cQgZckra6Pey+OGIZr6MC1V1pOx65WRDk4KEkqt7nd+7oQCC9K5v/I@nongnu.org
X-Gm-Message-State: AOJu0YyU5fSL7Ky1Jx68adiZkPRYJdmO84/gCmu0xAlp8tqVavmQlexP
 KO2fjEwwgrbSK99AVvwACST7T4Aq3RuZ8xutDrGKSJMsiVOICdL7A9CUNZCpu0nWtpFR7jDRa9Z
 FWBJWlflyQfCqGAl3z/CM/+G+Dt9Cw+6dnxaoQygp9cFKylB2fBXduQ4kWfGVYcd87WgmXy79MI
 B2UgCp/fEmTY8icTv3+bUvN2dfYhp06TQ=
X-Gm-Gg: ASbGnct7JaRN2afwxqtnFOdTvFjZI4Q5fkvJixI9OEHC94+yZSGd22FxfcCAtgIXQhe
 C6pri4IRZirjGzcZd4BfY5pU1qMhSRg8cPGksCVd5ySRRox9nAqIeuWfyg3TIGVtLAj8qUHo8WI
 v36S2myzCkwe8YZBS9yj9/mBLCfsTCotlgVPYU8GV2spDdAqMStSCBKEzY
X-Received: by 2002:a17:907:3f87:b0:b6d:6832:a9d3 with SMTP id
 a640c23a62f3a-b70704c3e70mr1739086266b.39.1762275603202; 
 Tue, 04 Nov 2025 09:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGo+aIqoCh0CGkRVeLPpWLWePtmkFX60YOSeTYcLnqWSE8kewv6haeFTCDxYeGyrs7C1kbliLEEupai6EGFqI=
X-Received: by 2002:a17:907:3f87:b0:b6d:6832:a9d3 with SMTP id
 a640c23a62f3a-b70704c3e70mr1739084766b.39.1762275602801; Tue, 04 Nov 2025
 09:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251030164023.710048-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 00:59:26 +0800
X-Gm-Features: AWmQ_bmqjlv1u6I8MHYmjfmMIMHeCwBNypgIj9KSYpGvSCrXf7EmOF6-xGZhng0
Message-ID: <CAPpAL=y0wGssg_g-S8ndr57F2qu2RD_Pg1mbTHE8PK5sZs0egA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] net/tap: simple refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Oct 31, 2025 at 12:40=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> These are some refactoring patches, extracted from
>
> [PATCH v8 00/19] virtio-net: live-TAP local migration
>
> These patches are good in general, even not considered as
> preparation to the feature. I hope, they may be queued
> in advance, to simplify further work on the rest of
> the series.
>
> The (reworked) rest of the series is coming soon and will
> be based on this one.
>
> v9: Mostly unchanged, so keep r-bs. Still, drop t-bs, as there
> were still some conflicts due to commits reordering.
>
> Vladimir Sementsov-Ogievskiy (7):
>   net/tap: net_init_tap_one(): drop extra error propagation
>   net/tap: net_init_tap_one(): move parameter checking earlier
>   net/tap: pass NULL to net_init_tap_one() in cases when scripts are
>     NULL
>   net/tap: rework scripts handling
>   net/tap: setup exit notifier only when needed
>   net/tap: tap_set_sndbuf(): add return value
>   net/tap: rework tap_set_sndbuf()
>
>  net/tap-bsd.c     |  3 +-
>  net/tap-linux.c   | 19 +++-------
>  net/tap-solaris.c |  3 +-
>  net/tap-stub.c    |  3 +-
>  net/tap.c         | 94 +++++++++++++++++++++++++----------------------
>  net/tap_int.h     |  3 +-
>  6 files changed, 62 insertions(+), 63 deletions(-)
>
> --
> 2.48.1
>


