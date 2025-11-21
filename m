Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA7ECF2564
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 04:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMIMS-0000nH-AC; Thu, 20 Nov 2025 23:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vMIMQ-0000ml-1m
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 23:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vMIMN-0004YF-Ms
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 23:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763697776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRr6W8diSd59J3YABzUjNB7wJzD3GQ6WHK20PczeJIs=;
 b=SbeSvgQR/L/iY6s02fUtiqLmeKz04PRZ9esB9YDq450MmjR1pdqhspPxrDAnYFUBViwYbh
 8vaDncFxV1o0oictnDF2wxok5POH3pvtgx4YK80Wjj0xsHahSDPh5Lkju6Cv7ICg4EqNGe
 nojRfWiBhG9Sj8PU9CUXwAxmpbQTRJs=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-65y1rm8aNlWRktaORM78bw-1; Thu, 20 Nov 2025 23:02:54 -0500
X-MC-Unique: 65y1rm8aNlWRktaORM78bw-1
X-Mimecast-MFC-AGG-ID: 65y1rm8aNlWRktaORM78bw_1763697774
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-5dbcb1740daso846317137.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 20:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763697773; x=1764302573; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRr6W8diSd59J3YABzUjNB7wJzD3GQ6WHK20PczeJIs=;
 b=WwbB/wIyPJRsL1ewduGjHqnqT43i3dOpqyiarzOG1/HX0+Gnie08P7rbyvOmIgNw3V
 hCW2cU4TKK+LqVRl2GNiErYaHUPdYD0ERZZ5KJQhS1cAz+VCkrDHtMB7tn2kYoyT9qaf
 00cteUH9sryCIBvZijS2T/Ka/V3l/LHo/OqkN2HNHW3C8xq9JubIsGkZhkh4ZC95tjfy
 TGR6BYAxNza79WPcU49AUvPjnhV5sQ8+UwfOC2vTxR5McFuIOzDwiaEsotszVNYbCd86
 qSrXQrsLpibXcJBLhaDGW3QwNo+OLlNjRwfBoenZd267RHATyQDxPt3Q/AZkV9nhnd5K
 y6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763697773; x=1764302573;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hRr6W8diSd59J3YABzUjNB7wJzD3GQ6WHK20PczeJIs=;
 b=J/3N7sKCkQu1T3dyFI4+aysQL4dTtlP4ESHcqqPa4YeaBtBE/Q3+8B992MWJwdhKBR
 cqgSnM3luQpwF8u823mB/JTUR0+/0go50GRHnTn05Ggq97DAs52Bf3Q90+xEwiRPJlh3
 fXCTY2vpNou71dxl9FcjzqqOwCWMC3hiC4jYyRV0Mz7MNfZHVxoim3mSSvMZ5JbW58zB
 11yb8mAAl8DYF7N0W1Xj5Li9XuLVI1hicStZNt6QfXD97O3zxQVOxiv9tVXOtM5h+uOw
 kcNWaWh3D8rFeipGnCEkJsqUf2op6AqZwiCjQ4Cctur1NCJgvLq84dCtYWoybrFU5H/i
 n3JA==
X-Gm-Message-State: AOJu0YzdwCaHv377l2+h1zEbXDRSUv1LzovqbDiRN6p+tgJR9vOWofq+
 w7Nb0V7TnQ0+ZxgKtAqhyeYAGDoEue7iXbipAuUVQrDmD00iv1MXzulYbR+vybKnu2sIFmgDg79
 ybs/f/KSFCHv1EFEdmHYr3/rYjEXo9YI22Y8EOTU9Cu6p3d4kczIgC7EOsQVCmI46Rkgu7GoN5E
 0+v/YiiTyf99AwUGfp+3EydojWuqojOYHj2SqW7wY2Fg==
X-Gm-Gg: ASbGncvG8os9pF+wPe4sPpxooWIRxsg+vFVNHdwJmi22dfp+MYkg489CFo86M4F0BZG
 14ZaeJYPhH2Qb+bqRMufTEdpzK5o2HDDS/Gj82T+3k6MEe5GDV0lj4T5cb46cA3iI80yDHW+rco
 29EunSIW6a/egsCGRINooTTqgpDQfy5vz+hQntCcMUuZlUZJvszTzrpNCzeewhX47FeWU=
X-Received: by 2002:a05:6102:41a5:b0:5dd:8819:e68a with SMTP id
 ada2fe7eead31-5e1de3a6b22mr232038137.36.1763697773281; 
 Thu, 20 Nov 2025 20:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBFExOfqNUf6PNOuqEjnvQLikir34VNbbi/trER/3N7JgdGHLHLuQ++GV+IDcrcKrdnja9d3reKYSAHa++nXI=
X-Received: by 2002:a05:6102:41a5:b0:5dd:8819:e68a with SMTP id
 ada2fe7eead31-5e1de3a6b22mr232034137.36.1763697772889; Thu, 20 Nov 2025
 20:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20251114034806.2440-1-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Nov 2025 12:02:40 +0800
X-Gm-Features: AWmQ_bn7_YbRIRux9nd2erRevkvnt1BPH0n0uDcg_WaKZr1aG6xmnlRLQp71Ryc
Message-ID: <CACGkMEvmuwGC_U3wW51v=qyuvU8qt5R-xx-jf5OR8gB8Fc3XOA@mail.gmail.com>
Subject: Re: [PULL 0/5] Net patches
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
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

On Fri, Nov 14, 2025 at 11:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> The following changes since commit 9febfa94b69b7146582c48a868bd2330ac4503=
7f:
>
>   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging =
(2025-11-12 11:47:42 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to a01344d9d78089e9e585faaeb19afccff2050abf:
>
>   net: pad packets to minimum length in qemu_receive_packet() (2025-11-14=
 09:59:55 +0800)

Ping.

Thanks

>
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmkWo9EACgkQ7wSWWzmN
> YhHargf/Uf801PmKskryVENF9sVe6u5NxJZlT3BUJVsSTGitucBIHWZ5J7MMR1lw
> If4tfMho3BX5Wrtl5GuCEzolk9pCz3wmSN6nyOU25C5tKaoJ/uR135K25D0CwVmD
> eTOyg+gKktVfogXxJ/zwZpRHMq4XXrk/C2ZP41r/CdcLyaeuDS9GIbd/q4N7f3vv
> bEsVqECzjEwWr2JBY9SD0xlIRp3nWwEvRsgRZPzBiQzfjSTlImqGLUsxIpF5V2LV
> 1BU0V/FShWyrwckBXSqCWBUh6uBUGgEl6qKnK4vH7+ed4Kd9giyp1vWAFEjHgIg+
> gZtPaT/MJQOtLyCuzfuSdUpAzz5Sfw=3D=3D
> =3DIs8a
> -----END PGP SIGNATURE-----
>
> ----------------------------------------------------------------
> Jonah Palmer (1):
>       net/hub: make net_hub_port_cleanup idempotent
>
> Peter Maydell (4):
>       hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX de=
scriptors
>       hw/net/e1000e_core: Correct rx oversize packet checks
>       hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers(=
) assert
>       net: pad packets to minimum length in qemu_receive_packet()
>
>  hw/net/e1000e_core.c | 85 ++++++++++++++++++++++++++++++++++++----------=
------
>  net/hub.c            |  8 ++++-
>  net/net.c            | 10 +++++++
>  3 files changed, 76 insertions(+), 27 deletions(-)
>
>


