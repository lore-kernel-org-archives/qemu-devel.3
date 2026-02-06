Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF309EB28DE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGeN-0008My-VJ; Fri, 06 Feb 2026 02:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voGeM-0008Ma-6N
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:53:10 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voGeK-0004Xc-HQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:53:09 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-658034ce0e3so3060943a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:53:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770364387; cv=none;
 d=google.com; s=arc-20240605;
 b=PCPf5+Hw6kTfMdThioIPK8y5Fw1uU6DEVDdbvHu7V+cAI65prcWvt65FcNkqTzwadW
 Ppkx/HCh+qxPgOdmskSZ7LzAhIILa/dB8q3xefLsw65vObf7BpvoDLCSAbAdn3BsS96k
 xKWnCw9aJh+tGAd02iImQELB1/326RP7RxQhPKDg2YcSDADCJKmZNIbKhBNi8blOHift
 MG4j78qQiVRvJR0d8GZSlexklpYvlVt2HsK1wS814eFcp82R34Qiz1j842yw/tt9LTcP
 HzlpQksvRFwNTQsbwen1pniuHCnu7vlBoXrrQk5U8R6DmUnCE17iIptYIHYkgMXNXTOA
 f8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qz+O1RxwsCl2DFXQTb/qqa4Jg2AOFdVRPjtNDenk+go=;
 fh=Q60oc1Mwo+n6KVl0/HzulOCo07LbH2MP95czanFwixA=;
 b=QkqQbUzbQVxIzPAT64csQareJ2gty4WV/ZxFZdBsY1zLzGbfkvtUYTx68FFOFa5h7N
 7JCKdqFmuuJxaodN93qVoy0I2dlxU7/pjNK1mi0zhxswdrzO7+/xfrUmnQlJtd0c/ezk
 7W7Tq0KRBMayRtPmWsqqOoxkpRwzhfx+glYh4Xun00hHSAdvy0po695eYGEOWhXgFFmI
 dkhLEeJjpp70MaJVN0mmv0IITDPlSo/Igvu+dAbL9azXt8w4L0c0gSf+/NGIEGOYzO9w
 AUdv0Kee0FhmlZdYXeerHtDvMn/+sKEFPOxsGk20iEFuoFxoSRurSeheuFmOWypak+3Z
 ejvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770364387; x=1770969187; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz+O1RxwsCl2DFXQTb/qqa4Jg2AOFdVRPjtNDenk+go=;
 b=AKeO8OWkbNvWXdsR1QKwYY1Ax53fZp3j/+tZ28xYhMrkdH927IjRYby48mXR/3uxRV
 B+rxM8/S0+IerdOX3Kbxm+iyc6Px306HhIvWEcE27MP9Tsl9p4R+5LAJBJLc54e0HWGx
 i9DFjcYtkHU6TvlE88U9G0JZJgyqXk0Vxmwhl0qvBNgY6MH+h//0B5r3au5G/ka3lXKm
 FU6kZ/8BteGRw9KKzW1FZA/wICDa9+119rIC1yM09YwKEScqRJTjrkt6hsnnxCMDMmI4
 TlKO/DBy+SMTd83Veu/GdmxXVFuPFvRGdvrHPHP9TJbtwHmFmG4Y0vdeZ/7+KAYlvGGM
 dmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770364387; x=1770969187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qz+O1RxwsCl2DFXQTb/qqa4Jg2AOFdVRPjtNDenk+go=;
 b=vZp5Qgja9z0XiKPcDwvy7t2yrA22eiE+2Y4CdYy5FftHSjjDHhwSXXIsthUItXXxUi
 xbQhe+0wMeMhE1HLuy7tyN+z8iHU6z+nzvG8Bczqsy1uWeWk8UPaGKMxzoI8GJgNBz0g
 9Jl7CDXCu7IIsO3DDVomRFkwvxItkVSJgTxfJOfeHWTEkm2rL8BaRXY3YfD1Rf01hc86
 hSzt3oriKlzue4sdmiTMZXRN71f3dlKudZGoQFXFltN6Ww/Z5/eYB1GfvY18ZabfQ7oJ
 dc+BQ7BFKqe8xWvlDLUEjpBDfm7VwrQ0JwRMotGY1OkuUBV3U7MskUdEvDDDe/jLQNwN
 +sjw==
X-Gm-Message-State: AOJu0YxkzRyGz5I/Q+roj9sXLtOwrNd6y8cjpkUdJNswwhgJD3DJmlVc
 0OxNz8Bb0RNvv9NL1rROmYV52gVLnhcb9yyQR9s+klYPpdvleXXpUYWnoZe0HeycuYPDV3njjxz
 yZH0UxEX0+YF5hKFWZ7ZtC+ygE3fVLF8=
X-Gm-Gg: AZuq6aJqeaOjiU6WNzTLDz/OG/I2UbIq9chfGrQl0/AXQ0Sr9ZNfRuae5A7SARq20LV
 8TAlePuGq7I508In/88pLZsSQts/Ps+RH6XfgqOgZ29hpVO8XlbxBYrsMYTAcxIpbeyg3d+B6xr
 rScL1ZscCBG1Qg/2/uDWA6N/fUto7B8kZT5MtDz74OCQj3ZNzubOBiBm3v06nfoVaB/40LHTLU4
 7QyCevWoX8fZGON4t0EyjMYZIwvRQLh/2UD02S91KahNpuhafUWxwOV8H5RvAD4lSpwMmKV
X-Received: by 2002:a17:907:940f:b0:b87:298a:da9c with SMTP id
 a640c23a62f3a-b8edf174393mr79673166b.6.1770364386514; Thu, 05 Feb 2026
 23:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-14-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-14-57508b7389f6@web.de>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 6 Feb 2026 15:52:30 +0800
X-Gm-Features: AZwV_Qg1aH6Zgm5Fxp3Feb3-UNM7-RvQ8YUQK348LFWKQxq1R2fSZGlkP6vNFLU
Message-ID: <CAK3tnvLzy9CW3jEqTOuhjMLph_E+11GETr=o8kkXoUOzA2pM_w@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] qemu-colo.rst: Miscellaneous changes
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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

On Tue, Feb 3, 2026 at 6:16=E2=80=AFPM Lukas Straub <lukasstraub2@web.de> w=
rote:
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>


Reviewed-by: Zhang Chen <zhangckid@gmail.com>
By the way, I will move the docs/colo-proxy.txt file in this way.

Thanks
Chen

> ---
>  docs/system/qemu-colo.rst | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> index 4b5fbbf398f8a5c4ea6baad615bde94b2b4678d2..a70e61aa09391cda933031535=
fa982d27cf6654b 100644
> --- a/docs/system/qemu-colo.rst
> +++ b/docs/system/qemu-colo.rst
> @@ -1,13 +1,6 @@
>  Qemu COLO Fault Tolerance
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> -| Copyright (c) 2016 Intel Corporation
> -| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> -| Copyright (c) 2016 Fujitsu, Corp.
> -
> -This work is licensed under the terms of the GNU GPL, version 2 or later=
.
> -See the COPYING file in the top-level directory.
> -
>  This document gives an overview of COLO's design and how to use it.
>
>  Background
> @@ -82,8 +75,8 @@ Overview::
>          |   Storage     |  |External Network|       | External Network |=
 |   Storage    |
>          +---------------+  +----------------+       +------------------+=
 +--------------+
>
> -Components introduction
> -^^^^^^^^^^^^^^^^^^^^^^^
> +Components
> +^^^^^^^^^^
>  You can see there are several components in COLO's diagram of architectu=
re.
>  Their functions are described below.
>
> @@ -157,14 +150,21 @@ in test procedure.
>
>  Test procedure
>  --------------
> -Note: Here we are running both instances on the same host for testing,
> +
> +Setup
> +^^^^^
> +
> +Here we are running both instances on the same host for testing,
>  change the IP Addresses if you want to run it on two hosts. Initially
>  ``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Hos=
t.
>
> +COLO uses double the guest ram size on the secondary side. The Qemu vers=
ion
> +should be the same on both hosts.
> +
>  Startup qemu
>  ^^^^^^^^^^^^
>  **1. Primary**:
> -Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to al=
l hosts.
> +Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all host=
s.
>  You don't need to change any IP's here, because ``0.0.0.0`` listens on a=
ny
>  interface. The chardev's with ``127.0.0.1`` IP's loopback to the local q=
emu
>  instance::
> @@ -192,7 +192,7 @@ instance::
>
>
>  **2. Secondary**:
> -Note: Active and hidden images need to be created only once and the
> +Active and hidden images need to be created only once and the
>  size should be the same as ``primary.qcow2``. Again, you don't need to c=
hange
>  any IP's here, except for the ``$primary_ip`` variable::
>
> @@ -353,8 +353,9 @@ Wait until disk is synced, then::
>      {"execute": "migrate-set-capabilities", "arguments":{ "capabilities"=
: [ {"capability": "x-colo", "state": true } ] } }
>      {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
>
> -TODO
> -----
> -1. Support shared storage.
> -2. Develop the heartbeat part.
> -3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
> +| Copyright (c) 2016 Intel Corporation
> +| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> +| Copyright (c) 2016 Fujitsu, Corp.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later=
.
> +See the COPYING file in the top-level directory.
>
> --
> 2.39.5
>

