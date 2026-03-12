Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A3B103E302
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0WH9-0000yw-1G; Wed, 11 Mar 2026 22:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w0WH4-0000yP-RX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1w0WH2-0000oP-HC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773284382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sansw5eWhN9Qsw1wOXiRv2rrs+/lBSApzRtWcaGoGpw=;
 b=e2EUmwUiiqKrki98xyMobmEZDiLMzHbbmSrvUug4Jv9P7bK9kRzEBkPhxz8mkPEl2BtF39
 YO37EWNaUJtPJFl8PP0nTGSkBLnlo4UCIsqBcepMkmfYDZLVINWiIRDT5OWMd9HdCW4YPS
 QndXVvoFXEbszQMbxV09a97pTNxi+6w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-nKlDI7gpOyydVWsgI026nQ-1; Wed, 11 Mar 2026 22:59:40 -0400
X-MC-Unique: nKlDI7gpOyydVWsgI026nQ-1
X-Mimecast-MFC-AGG-ID: nKlDI7gpOyydVWsgI026nQ_1773284379
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354490889b6so2202963a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 19:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773284379; cv=none;
 d=google.com; s=arc-20240605;
 b=XIC1dv9J+5rYDALYUCwwF/eYas8YOqg+oVTpU23Kzw7T5eSmif67g3WnqecWLIlvxV
 w8BchO3laN+B/NdybtDqQ3GIjruXn9qqku81uZAnSH9wlUMXGElZNYRyWdNByy5E0TSm
 mTtp3CqxTbqYqRiF39fxDvLYaA96LU8vj3AstUDNW5KYFdwtT5C+iEPHvKWOxU55kQoV
 DhYPBlbICHM0RFiAwOS95J6R2HBVUtZDMhq74NaZMyV9ppgvTz0T8+YkuDxQGOc8cTFZ
 on0tCObwybGvXIJIndEe/PdCBSmCaqvbwViif0bCLjJWNJRy5c3iFP3sWSuhM73gv0Rk
 OgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Sansw5eWhN9Qsw1wOXiRv2rrs+/lBSApzRtWcaGoGpw=;
 fh=86GryG2tK9OpT0a2/osdZAyaZ9z2seA38PMDS0NS0sA=;
 b=KBuBTX0WGvKUymHfFbsm7aF1nK6Xo6d1X92xpIsRTM2ZB5+eL48WMs1lqiBskdARSm
 foixciS/fpDEk0gGqBtvR6hXWRKm/Vncu1x67TVmWyVNForbfSYYrNynZ+MS2s3CcHee
 V0lnpcHTACPtxvk9aeKjG+SGfCtVKuY5LSV2DpIdu9xmp75oqLUawTUpzP+nOp3+1Fg8
 yz9NKTlFIYMv1tvMfV3vlsFEcO38KYH1GpIDkTVO1HURlhDhP2kEVpYiAXhNZh3aEHTc
 BHAVqCuWJ3JRzZJpkOwx3bklqyT0mI80xZd51BPbnG6ymodRUasmah1hV6k0kx9Ww+jH
 Gt5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773284379; x=1773889179; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sansw5eWhN9Qsw1wOXiRv2rrs+/lBSApzRtWcaGoGpw=;
 b=Zaef/AmbtoN+OzJd51qnxmT+57PzLK4AHkxp6VIQyf0ARL+ZJ3VJywBVJSVsMBMr3E
 aPDV8gWoq3g6CeOG/TDue7nKC5CzrxvOjI09AuJHPELLhvq6Ks1UepHP6nyuiOnmKRji
 Y+E8Ep/WTdm5fljImskVAnK+w5LK9/aeczpLvZGy3l1IX50NS0rsgSFmSKC1Bmivu/ii
 2LYXxlwM7blV1IcBUEG7UWfCcDFysVty0CsQJuK4C1yhVdIc88uDdPNQ7D9/3EAJ7pbi
 /a6Zffb4v1lRaXUuWyHZIAK+HWU6wEgFFxEmCz+EnDlazf3P8C6rlCv7qS438x7axWoL
 fEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773284379; x=1773889179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sansw5eWhN9Qsw1wOXiRv2rrs+/lBSApzRtWcaGoGpw=;
 b=oWEmJacgS1ZCsv6yevuT5HuLYU0s3PipaBDvkMSmwxUOwZqbqcB3Q2wIRIocCgrk4J
 VgklCKseMIHcurNISKh9GB6iznzG8yzKevDYrV/wYh7j8lKv33mvJtA2DORJIdnGVcL2
 QmJLWRpJOoh1r7UC6/wLmslwAPljcxfLWHmEh03d/Xgm+1VdVnuOLUXelvFUoTjHVejf
 4A/brJueIMZEh7K288j3+rPQewbm5xZSUkBic7Hf5EXCQitHKxwF0vnLFX5Q0KNzuzk5
 CasoF/lLmPUGtZkO913Ydwi6WsU7fJpxmf8+95tjiUbmyB6QhQ+bZospSktwGEgeoEwN
 9wQg==
X-Gm-Message-State: AOJu0Ywx3WGfOxNkqXWrWHZTgc0y7chbpSGqR+cfd5liFhXAL0KNc7qN
 fGK4UGMbyQyxVcHNzwfrZfpc6rYyX/ZS6L+96qm1vxlmEbLhYi+M/Ka6XH9rk+2KIvfI6BC6cZC
 bWHDzQ+0nJmlcXM8O9T6ViDov95vy+xVHbPmqUiorEF7RCqaPKhBZXG2Y0Bu5YkXzbATAz/nlBc
 CeJBxXMBo9N1xyqvCFeWrXpMUWTc+wZII=
X-Gm-Gg: ATEYQzymIWScrgX2e/P7Gx3c7xl6EoSFBRLT/+bNveI18B5oKCmPWy+wudAsLjv3ybR
 Qf2Kb/5I7DO45tNC18S3Yarcw4maCfPdD3t3qssaF+VXrWV39GRntaGnf67sHb/f9izkk7qujBH
 YMQdkhRbmwUzDSKldwnL7nkvbDFaN00Q4tL69VeO12oCKOCoIy5Q03NyfXGs5DMXvVbN4RXuvtn
 vEJv+5J
X-Received: by 2002:a17:90b:3a8c:b0:353:e91:9b38 with SMTP id
 98e67ed59e1d1-35a0137aa83mr4608031a91.34.1773284379421; 
 Wed, 11 Mar 2026 19:59:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3a8c:b0:353:e91:9b38 with SMTP id
 98e67ed59e1d1-35a0137aa83mr4608016a91.34.1773284378998; Wed, 11 Mar 2026
 19:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Mar 2026 10:59:28 +0800
X-Gm-Features: AaiRm53VtAd6ytI2WwLkTqpV7KZRaj_V3GdhzsQn-lBawq6Og2bAxpAXtwGJ3HU
Message-ID: <CACGkMEuE3LQGmSK6tTa7xhYCio1nHQcAf0Fw1uD=6ipiUGtAwg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] net: refactoring and fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru, 
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 4:28=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here are some refactoring and fixes, mostly in net/tap.c I'm making on
> my way to implementing TAP fd migration (through UNIX domain socket).
>
> v3:
>
> 01: fix checking, switch to int type for queues
> 08: drop MAX_TAP_QUEUES constant
> 09,10: prefer int type for queues
>
>
> Vladimir Sementsov-Ogievskiy (12):
>   net/af-xdp: fix type overflow
>   net/tap: net_init_tap_one(): add return value
>   net/tap: net_init_tap(): drop extra vhostfdname variable
>   net/tap: net_init_tap(): refactor parameter checking
>   net/tap: net_init_tap(): common fail label
>   net/tap: net_init_tap_one() refactor to get vhostfd param
>   net/tap: net_init_tap_one(): drop model parameter
>   net: introduce net_parse_fds()
>   net/tap: move fds parameters handling to separate functions
>   net/tap: fix vhostfds/vhostfd parameters API
>   net/tap: net_init_tap(): merge fd=3D, fds=3D and helper=3D cases into o=
ne
>   net/tap: net_init_tap(): relax QEMU hubs check
>
>  net/af-xdp.c |  44 ++-----
>  net/tap.c    | 319 +++++++++++++++++++++------------------------------
>  net/util.c   |  50 ++++++++
>  net/util.h   |  14 +++
>  4 files changed, 201 insertions(+), 226 deletions(-)
>
> --
> 2.52.0
>

If I understand this correctly, there would be a v4 for this?

(https://patchew.org/QEMU/20260218202829.1322088-1-vsementsov@yandex-team.r=
u/20260218202829.1322088-10-vsementsov@yandex-team.ru/)

Thanks


