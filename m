Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FD6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 03:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfwq-0007AF-Ia; Thu, 30 Oct 2025 23:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vEfwo-00079b-Ki
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vEfwb-00013X-Sl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761881799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFtzgVRNLzGLJ5CyBSCCqz2aI0GPsU21JHej9RH9ues=;
 b=H6a+IbQLwOpcmy+mT79hjKlnidxWUzhTghxyZrhkBogyj0akvMo+wE28rwQilwQM6Q3CQW
 d9BMTrHJNk+D6COXYb5SnyjYU8P9ASDWEne9J4n0Ml/YVEFgAqooCf4j7ehOjf6Oy8IhoL
 Xap56lu9vDMahueNVqwwLQ51d7Gq/u0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-CAQ1AUdFMZeznSfeJfrtoA-1; Thu, 30 Oct 2025 23:36:37 -0400
X-MC-Unique: CAQ1AUdFMZeznSfeJfrtoA-1
X-Mimecast-MFC-AGG-ID: CAQ1AUdFMZeznSfeJfrtoA_1761881797
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5db9947ab7dso3497579137.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 20:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761881797; x=1762486597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFtzgVRNLzGLJ5CyBSCCqz2aI0GPsU21JHej9RH9ues=;
 b=MG6mrhrES+UGzbQQOK6Bp5uHLLQt3q3J0i6QoVA8T14Ak2/TEvKEEJerO+Q7aNzQcN
 OZJuerFAPnsdAcmfIwGmd1EkTbzr2+v6WhERN2U+o+tasLAWNvsLXhJYhoM4R3YbUzn2
 NyLoJMweZQgcjWP8MpAxjfG5105yn70NgZLonFDknUfAxRIunJmISpMlF0/EGKuF9DPp
 3BvfJ15CPObgCI3UUVAenawcorUYmi0lYFLZ7eGT8xJtNknez01zzuY8COEWwn0OKUtj
 EKWi3o7bEnP5TufyE4YIlwbdFY7+y63bME5R9GANSIyltkwMb4Cct1zsmMJQW4jwPhd/
 xkSw==
X-Gm-Message-State: AOJu0YyvW3Y7SiFBl8S6n907MWDWtINWEJbYJbXq78QwZgxMinYjKQjX
 q71xi6M/AfEBL7dRVzxZwY7pKjoAaLbbmJQqMXw/4PDnkD99Icof7pI+Q48scrTmDDTBd64VVw2
 oVuUCPFD1x/HsqccwesLuTpQH6pvutXOoz5Rc5NUi0fN8VH68cD6jc9JkNba/q0k+iUwCiskL+R
 GjoHnKCKZ8HOusH1+TQXh7E+FmdF4shxk=
X-Gm-Gg: ASbGncueGbQD0Uz4euz/N2Xtf9gHh76GFC6/MAGb/+7D0kL7OSeVuxEYahOBNUit/oU
 v5yXWZ4IcBBxry80oNCiuEua5NvRQFQ5ZGOqm3ylpUv3GO6hLflsQdtp7RvA7l3xRSH/hVD/tmK
 8AtDPGtF40blQg/dLyEZ+05YFndP1llwMd427XemYC3AWYvGSa/N6v7sX9
X-Received: by 2002:a05:6102:83d2:20b0:5db:aee2:9964 with SMTP id
 ada2fe7eead31-5dbaee29a18mr876786137.9.1761881797387; 
 Thu, 30 Oct 2025 20:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgyMDa5BBlm5FrOq97XsTP2Liww0qAxVjW9/aAA5cNDhud5ucgmnNusSJV4jWECeRHj3177mmTVXETz1802tg=
X-Received: by 2002:a05:6102:83d2:20b0:5db:aee2:9964 with SMTP id
 ada2fe7eead31-5dbaee29a18mr876774137.9.1761881796891; Thu, 30 Oct 2025
 20:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Oct 2025 11:35:57 +0800
X-Gm-Features: AWmQ_bnx6fnEK_Wx6dhUrzVX2ppPjuWqgLW2HZzwEbhjfIEiNdKypXAvPwPT64o
Message-ID: <CACGkMEtnSNJ__Kv_9fCGb7zNpTHuL7SFiZBbgGjZiUPkfh7Tiw@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] net/tap: postpone connect
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Oct 31, 2025 at 1:19=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> That the second part of virtio-net backend transfer feature,
> following previous
>  "[PATCH v9 0/7] net/tap: simple refactoring".
>
> Here we realize postponing TAP opening to some future
> point, when we know, are we going to do backend-transfer
> incoming migration (and get open fd from migration stream),
> or we should do open().
>
> v9:
> most of patches just picked from
>  "[PATCH v9 0/7] net/tap: simple refactoring".
> but, 01 is new, and 09 is significantly changed:
> instead of hacking with .check_peer_type and detecting
> virtio-net by name, use the approach like in parallel
> series for chardev:
>  "[PATCH v4 0/7] chardev: postpone connect":
> introduce specific PROPERTY macro, and avoid connecting
> in setter of "netdev" property.
>
> Final part of virtio-net backend transfer is coming
> soon and will be based on this series.
>
> Based-on: <20251030164023.710048-1-vsementsov@yandex-team.ru>
>
> Vladimir Sementsov-Ogievskiy (9):
>   net: introduce backend-connect concept
>   net/tap: rework net_tap_init()
>   net/tap: split net_tap_fd_init()
>   net/tap: rework sndbuf handling
>   net/tap: introduce net_tap_setup()
>   net/tap: move vhost fd initialization to net_tap_new()
>   net/tap: finalize net_tap_set_fd() logic
>   net/tap: introduce TAP_IFNAME_SZ
>   net/tap: postpone tap setup to net_backend_connect() call
>
>  hw/core/qdev-properties-system.c    |  29 ++-
>  include/hw/qdev-properties-system.h |   2 +
>  include/net/net.h                   |   6 +
>  net/net.c                           |  15 ++
>  net/tap.c                           | 283 +++++++++++++++++++++-------

I will go through this but I'd like to see a test for this feature.

Thanks

>  5 files changed, 264 insertions(+), 71 deletions(-)
>
> --
> 2.48.1
>


