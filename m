Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52388C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 09:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDHR-0002iG-Nd; Sun, 09 Mar 2025 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1trDHN-0002hW-T9
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:49:07 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1trDHM-0005wN-3u
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:49:05 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so501625866b.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741513742; x=1742118542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4xd6Ir4Wx21YW59Ig1VfzJLWzIWxmse+MUK5JEbCCU=;
 b=PjHLggOggoSJFUCMrn8huoFj4VTMwEQioSfBHR27PM1H6yGMaaF+lrwDamVyI3UEDl
 e7iHq9w/6sy2Xl8zErQMpTS9EPKPdQqnsw0CCS/2RjGiOLX6LLPE8Hafq2GIqeP2mvf/
 Ur+XLMrtk4hB1knw7G0yGouoi9CTwciGXEgzgrGfBf8kIb2WMOKS28GWBYhLLoH/TUK6
 iPbn4fae2/N5sKQPm141YQ88BtxWoZ3S3yxnyXEkUqgOBDbZOtdKNx9b/z5EuwQp40n3
 +cKpggqBthffGLDHu+A+72uZcbBFSzlz6ErZY13iHgeuXfEda/jAPz8a/lhL1gO3wotC
 kXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741513742; x=1742118542;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4xd6Ir4Wx21YW59Ig1VfzJLWzIWxmse+MUK5JEbCCU=;
 b=hQFX15aTGVOmHegTCEhPX7ODLPo0wixJYFnGUoiiXWlaKpTIgTFhChQfy+tdNyu3WS
 5TynXY9B2vg9t4Ra+9cwlVcl6PfvGwZQhx14OSvX7rTKlF6YmMUR2VUvVmNk16OPiaJ7
 Ixtv28rYwChleeQp+Pdck04VA7WnES1vJshxzECEvR/WqIvO5/cerD4XemnA1ObKbJ+r
 2j6Osw4zYboCOuSINuFxuMu8UHjyx3gBlMr/94b1A7YqyIYMtvN+xyo07t+qZjFqXfGm
 4tCj8/uxaIqyNrOEfIXQGbJOhWy7AGlP5EokVQEyLI0B0M21n29YG8aT9vnxZ8N1Dt8U
 J8dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+a3LCpDzAS4nwgd3WukVN4z2MdklJxIPECbAughnEjXNYlCRzy7kgjrAD+g6dGGfO5HZR8Wlwafk@nongnu.org
X-Gm-Message-State: AOJu0YywLF8vUmtceT+NXiGavyYHHG7u5qrPxKbiUPHVspcr66W24YIi
 mksS5Ru/EjuHchuB9UYZUoo+6Amo/u1vg60dh/fb/Hc54+yWDkz8gpfAiQ==
X-Gm-Gg: ASbGncu3JnBeXKTub/w9/h/LSF2ZblZhN55g/zPLcTv3kRqzOAE310jl14xrTMlF6+Y
 dFDtw0T9sAL/KqQ+Kw7YBwpc1nWv6uJAQltxtrf62ilhRrpZEu3RQODUZxVPHqV9c3OOWzVKoFk
 nEPenXZw3FpRmA818XwnXNzvnh1CjIM5C5pEwXu6qZeLo+WYI611s26HqRmJJVJvJXX3ZY9mhPQ
 xzgO3pgIE/liE2FTaieVmpud4KQP05C8xXUdZY+1ZsOvI0MwM4mIpRQy+zgOKSdRMGTPxknKd52
 LFwqpVsFZMuRds3xDptMX0qfC8hw1POa5n8v1Yyqm6pgmbt11EhfSU9tfDBG6jOoc4Ol3Yb+jQJ
 iPGhhoa0orx/rYU0g/v8cQhAftSTAPBmeMRlKF2T/k+ZRYfzRINjQ
X-Google-Smtp-Source: AGHT+IGoPF0MeF+CSYG4JaNJM+3JfXmvMk9ttRdIURqawaZ6R0N1sJCCkZQggNIXRQsZsSAapH0I1g==
X-Received: by 2002:a17:906:794f:b0:abc:b96:7bd2 with SMTP id
 a640c23a62f3a-ac2525dce7amr1236204366b.11.1741513741956; 
 Sun, 09 Mar 2025 01:49:01 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1a10-8c00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1a10:8c00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239438955sm577956766b.19.2025.03.09.01.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 01:49:01 -0800 (PST)
Date: Sun, 09 Mar 2025 09:49:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
CC: Thomas Huth <thuth@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_tests/functional=3A_Requi?=
 =?US-ASCII?Q?re_=27user=27_netdev_for_ppc64_e500_test?=
In-Reply-To: <20250308071328.193694-1-clg@redhat.com>
References: <20250308071328.193694-1-clg@redhat.com>
Message-ID: <B2FAB7F7-B42F-45C8-8ED5-72BB2F89EDAF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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



Am 8=2E M=C3=A4rz 2025 07:13:28 UTC schrieb "C=C3=A9dric Le Goater" <clg@r=
edhat=2Ecom>:
>When commit 72cdd672e18c extended the ppc64 e500 test to add network
>support, it forgot to require the 'user' netdev backend=2E Fix that=2E
>
>Fixes: 72cdd672e18c ("tests/functional: Replace the ppc64 e500 advent cal=
endar test")
>Signed-off-by: C=C3=A9dric Le Goater <clg@redhat=2Ecom>
>---
> tests/functional/test_ppc64_e500=2Epy | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tests/functional/test_ppc64_e500=2Epy b/tests/functional/tes=
t_ppc64_e500=2Epy
>index 9ce7ae6c4798=2E=2Ef5fcad9f6b66 100755
>--- a/tests/functional/test_ppc64_e500=2Epy
>+++ b/tests/functional/test_ppc64_e500=2Epy
>@@ -20,6 +20,7 @@ class E500Test(LinuxKernelTest):
>=20
>     def test_ppc64_e500_buildroot(self):
>         self=2Eset_machine('ppce500')
>+        self=2Erequire_netdev('user')
>         self=2Ecpu =3D 'e5500'
>=20
>         uimage_path =3D self=2EASSET_BR2_E5500_UIMAGE=2Efetch()

Thanks for taking care of it, C=C3=A9dric=2E

Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

