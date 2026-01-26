Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F9FCF65D6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJjJ-0002Ej-0B; Mon, 26 Jan 2026 05:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJjH-0002Dz-DN
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:21:55 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJjF-0000CY-Qe
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:21:55 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso531482666b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 02:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422911; cv=none;
 d=google.com; s=arc-20240605;
 b=WHOPT0/4sinoDIa/DeM4Kg6EySVp+NXtvHEA0Fz3+TY+kx0VJcKqfKPEEXEyImSABS
 rmpD4LgXpQGCAf2zFev3KaE3h4xxtFkgmLfNiqjP9rmoWcUSYGDNQe01MRc18Fnp+BIt
 0Lu1Jp5yvghcT8cqcKie3Ni+2PW2OCx4up33xV7GpKgSn8nZ9lEvhM/X9nWhCER6CiQt
 rUWoArUQ6UjA6PscD7jTg0QuJIaYV9t9jIFWhNH2kzUrl7JT3Gh6Rd44vWato4WsGMVG
 OUHAo/Q7KaHoqVR32bZamYe01sabGGKXbvQu2lXG+XJX7n2jgCci723x6gj10hwySQbO
 4kAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e49LoQ1vw7j/ARsi3ikkqzxRYUJGIm8ZChiGnkODM2w=;
 fh=Q60oc1Mwo+n6KVl0/HzulOCo07LbH2MP95czanFwixA=;
 b=WPjgnxZ3Zh2eiHL05BB94QcLE3iT1NQST3yKGHI6ONbc+BF7+7X0zhM6HeyKanalz9
 yaziHVQO/Xr/gmQLIh0bGnOT6ao8ACTo4f3wRfb9eWFosNYYqXeMfIqmNYsTiTrc87Zy
 CLeKmyugLqWoZs8qDT33fOTYNCUNHfGPDOQAegvTOfUnsTPXAwwymOB9EFL3wzQ3PHQV
 vTooylCVAZ+NhaXSy6O2l8/JG4rdotx7hFMB+zSATDWEj9H/RpPe9DNg6eCNCaBIAEVl
 Gshx4pUUDVNUAkHxx47DdcgkJNQpQ4ZkCcbAqZ2x5z7Wifh/nRsEANYE2kseOlmwZxOv
 q9RQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769422911; x=1770027711; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e49LoQ1vw7j/ARsi3ikkqzxRYUJGIm8ZChiGnkODM2w=;
 b=I4dyYbunDsoOgErnFJiBLIqaguleu/AAPzIDE5gB4aJdwAjTHpRuisSymuVwK011MP
 A87C+2wxLNTUmQ3zVM3oG5ofOkm6stVWUHmDfGwRqMtJsd3L+AHWw+kbvpMH967AAZyN
 lqturau/Gkb4rOIZoL3ucxzkeG/wnwbH4JMW/DcH5Uz2qHkCNnPBxdy6AXCJjsyVxy2D
 LSbSu49jdJ6EBuuYRJtePEMFf3raIe8zPLjZWjvmyzy/NbDM8D5XOIUcYbLLftiloa5N
 G+HrPIVFseCkOI7ViBpEV3bIeh2ygvEzQjD0fj8n37l1mfxFbazEiBJqU6a7/DMZsUqw
 pqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769422911; x=1770027711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e49LoQ1vw7j/ARsi3ikkqzxRYUJGIm8ZChiGnkODM2w=;
 b=xNtRB/IBC3Aay5akLF6oqFoUoKxR/IKXHvXsKFILJ4XOWdtjSf2vjkzL5pHCjp/vpD
 ovWCjS2RjUTpJmtFE4CF1S5ev5GJPlhJ99Ys8HlULSJsv2zX3g9QN4LiZ4yZLu+J5PYZ
 8UJhJ46XfaBG4PsVj0cT5l9fUgBXp/bM74i0BaVfB1g/2/RHzrqTFYXhFFmLLaLldjDG
 R5bmxMdfOBEiE2M8oVfuqlvaGx8UFpMIR6VlaBrNXxqCzOviw//I+cUuU3PncIIDsXNI
 PTMEtg8RsDIlTke7x5e48N7nR3q4gqdyt3kJWIKkGv+EjCdxbDXQaUmU+7I06yRtEBdb
 cZzg==
X-Gm-Message-State: AOJu0YweaLE8DsQaYobzqgrQ0e+DCEDJKTb6Jx7QA7rvHoNOzXz+G4Q6
 T3+OtsHZ7KTCdLjI+pIUaB1Ns7rCyGX7mWLejQQAHrynP+79cPBnd+vjRkYJYbSGvHKbgdAgICf
 HRMKvXYH4BdzaS1F93HsD9jIUGlSNQcw=
X-Gm-Gg: AZuq6aIVhmZDS1CYRgFKhKKMH3KNGEt4HphAySPiHsjF5YpNpTA/4hnP0et8T/SfpeD
 yiFiQKkkxHHQDcAH0aWhBS6Ms+m2V2hB/SDoV+OLJHnmwgcw+LROEvY3/e5b27GasG1TD2oOMxn
 vLxxnWhz84A/eExxBcj0WxBOEWFSPd4Mo6Zlrqqxh+6xAIca2bxPHCRxo9lvZvVFtjSM92/7cQv
 AItXz4OScF1KOjhq/nq1Ca5T/tiKuuIp526CtD7FdwlF4ZUYZvpWIMRcT3STMn2UrWNYW3E
X-Received: by 2002:a17:907:3f18:b0:b88:7431:3942 with SMTP id
 a640c23a62f3a-b8d2e71276dmr308101266b.33.1769422911205; Mon, 26 Jan 2026
 02:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-8-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-8-ae926ccd8eae@web.de>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 26 Jan 2026 18:21:10 +0800
X-Gm-Features: AZwV_QiXCiumxFV1SMqtZIWXgr--6X4kW5rRjUdvlxQUBImOw04UfcrBmlKi4wc
Message-ID: <CAK3tnvLohfapCAXg_+L5W_foVXzLtkDQ7bFhY-8esbo+LPUd0A@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] qemu-colo.rst: Miscellaneous changes
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
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

On Mon, Jan 26, 2026 at 4:40=E2=80=AFAM Lukas Straub <lukasstraub2@web.de> =
wrote:
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

It seems this patch doesn't offer any major changes and merging it
with the previous patch(7/10) would be more appropriate.

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

