Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E834CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyA2u-0001eH-Mh; Mon, 15 Sep 2025 10:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uyA2f-0001Wo-3M
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uyA2W-000799-HZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757945917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5VhXyRPBD3NQt21ViLAewfz4xOMK8HX/nkyO3orKS0=;
 b=iOoy2rMjQNL071zJcdREm+V/cD24e7SnhDXg0htJNdCcmyie7ENqmVWBYEv6kbeQ83rO1j
 Cm7h0IarhC8TYM5gQfnry83TGhU1Ae5Zdfa0H8UqvkXK28bQ0ahN5JdZ2R8t6Pm1zpHpoZ
 K6lpY8TI4Ued3Nei0SyU8COmSmMc0s4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-2qQHIVRmMyKSJpBUbugB_w-1; Mon, 15 Sep 2025 10:18:34 -0400
X-MC-Unique: 2qQHIVRmMyKSJpBUbugB_w-1
X-Mimecast-MFC-AGG-ID: 2qQHIVRmMyKSJpBUbugB_w_1757945913
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-628f17953c7so6026682a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 07:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757945913; x=1758550713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5VhXyRPBD3NQt21ViLAewfz4xOMK8HX/nkyO3orKS0=;
 b=KKLsppTzrPhHEPRB6NHt5dhwibZLQYzNm03Av2I6vqDOnyhaByQI7ozTghqW8rUQYz
 vWnKnGMIKsvT3fe6MSYf0sS71DEmoeHNs0a7qPUMPwEBa7obmZEEtB5XvT36PQUnlhv7
 phbWwLSwjnBx+7Ui99I8GMUVqRBPeDjqhVfC7z+dRZzUuDvNkbKZXlCpMcf3LEB+wZyi
 PPzxpLcDT+BcJm3xxK2/Fy9uC2vnDg/nQgSOBlpeUdGc6wV9xJyZ+qmIpz6BdGmeBzgz
 Jwa31Eg5Dh/ojhHE38FcxFqbD+n1UX7H9uHJOqt6q/6sU45Y40MvRGAXYpEBrnlPl21u
 hSaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsOB+JUG3+ZzRmLSo8tIBsFjWvBnx9K+aVq3aKH7uHMVxsTISviPmCG5Uaxhd2U1p9VEYkB9ltYOR/@nongnu.org
X-Gm-Message-State: AOJu0Yz43QtWBRR2+33dKUCSAeauqIFhV+ElBtRxNZETx2g3YLAJviz2
 /vFHPc/NwJJwznqyyc1ixUybyNNMzGWoc44W03KuRTKjBSz9Im+TYckxOU7HqlQS5yxVS4SlwFz
 JlgIE29iAzVZZLimQRyuC75wPuDsvExI2m5gYBom+CTI1LKoCweC5pa9zU2075u+p8gjv94n+kt
 KhugZOf/BJM8h9gz+SSxyst92kSB7bD4Y=
X-Gm-Gg: ASbGncvj7dFOfoQJRRPTdX152en+jMjzjBR4wcnQNMe0xsULLDuM5sHcTjpnGC0k90S
 UrXLOFNRQjoHIrpXS2lR9zwfIIEafrSUPvgrpqP1ffhS6Ss+k9aaPMzPNp5YYt+8uNOg++Pc3Ym
 lJ3+fNx5oSo74vYV0DxQCCFg==
X-Received: by 2002:a05:6402:5191:b0:62f:4610:ddee with SMTP id
 4fb4d7f45d1cf-62f461109f7mr2471800a12.10.1757945913039; 
 Mon, 15 Sep 2025 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXYI9HulH4Ufp0HbmTM2HAODnWc8EPdGE1e9lrGZqCeK5nH//1avnc7fq/4ySIflXYV0XRj4C94G0R25bERME=
X-Received: by 2002:a05:6402:5191:b0:62f:4610:ddee with SMTP id
 4fb4d7f45d1cf-62f461109f7mr2471783a12.10.1757945912677; Mon, 15 Sep 2025
 07:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 22:17:56 +0800
X-Gm-Features: AS18NWBw9JklGnkTiEftrodOGDjXolL3ZVsJBNJ_zHs7t8-0GRYXw6HuH2T2T1w
Message-ID: <CAPpAL=zPuarvTU2qKgT3Ob3vqPotemr9XOTTu7j4NrO7+0hXLQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com, 
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Sep 12, 2025 at 12:51=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is the simple and independent part of v3. The long tail
> of the series I'll rework and send in separate.
>
> v4: - finally, use bool reaturn value to add to errp functions
>     - rework tap_set_sndbuf
>
> Vladimir Sementsov-Ogievskiy (8):
>   net/tap: net_init_tap_one(): add return value
>   net/tap: rework tap_set_sndbuf()
>   net/tap: net_init_tap_one(): drop extra error propagation
>   net/tap: launch_script(): add return value
>   net/tap: net_init_tap_one(): move parameter checking earlier
>   net/tap: net_init_tap(): refactor parameter checking
>   net/tap: net_init_tap(): drop extra variable vhostfdname
>   net/tap: move local variables related to the latter case to else
>     branch
>
>  net/tap-bsd.c     |   3 +-
>  net/tap-linux.c   |  19 ++----
>  net/tap-solaris.c |   3 +-
>  net/tap-stub.c    |   3 +-
>  net/tap.c         | 146 +++++++++++++++++++++-------------------------
>  net/tap_int.h     |   4 +-
>  6 files changed, 80 insertions(+), 98 deletions(-)
>
> --
> 2.48.1
>


