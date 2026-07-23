Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD4CC531D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtEF-0005Od-79; Thu, 23 Jul 2026 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmtE8-0005O0-Ph
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:12:41 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wmtE5-0005qS-TO
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:12:40 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38de693676dso437889a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784812357; x=1785417157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e14oAFqp0QPnmbZkkpDTCbFv4Sax90xzZ/Ndu7Tq1tY=;
 b=FNBQ5ZPDBGEndefcVfb7a3/gA5kFd4ii+PFSFsX3d15kTL6Yc797Y7qP2lOlWnt5HV
 rtFgci/ZmD/JYBOsfRCta5Dey1UGm1I5YTvfNkKqepdSVQoi8vLggk8cUNlBu8EZWf7L
 A5j3ygEjg/hQKl3LqZd1YWFSH50zsBZwz4GQWOHLmxwasVuJxRHoCO2yvnG67DQao//E
 ukKmr8hT9bLXmWMaNBbdwAYGHraO72DGT2QBAMYj4KqzVDPt5X8djoC7nkwPeANuTs0d
 wLUh/TVjui4P2Q5HrbwC45STBiok7GJmVhMvTDF0Cjbz/+yckfz84/UezyjGqtPEp55K
 KRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784812357; x=1785417157;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e14oAFqp0QPnmbZkkpDTCbFv4Sax90xzZ/Ndu7Tq1tY=;
 b=Wl23ZuLR2763MQjUEdZLmBesvreEahaatwzMAHGXIMuLSTwTkbfVBcMUrbH3bEJEy1
 jZI6ku10OFiiZa1CziXpZEWgTU3OMvQJcUFB9aCEYlPKOzqy9TVmxM68dpz3XVtUqGkc
 ejwOWUTqTYOutBguVa17a8yDVUkCB5M0MdPWRKxF/OowjDQV95/lP14N19jvMZRLHYz8
 mRY9y9PQrWEVAKZAVzWYp3493f+7pW0sV+tXQAcIlwAMsLo0pHv9LO9SJ0QE0LgXIAns
 vB4eO+T5JrDZXAEzVBoRyChfRFjslXfs/rQo2BvHBjEFblOHdshpkg/28zXXKoT4vrqi
 hTUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiMQ3B3gky4Kr2wt916xRT7VsDG+rkzokIvnP4hp1s5/MMKQ1T1d3XH7Rlga6LBnJMrtxhJMpsv5/k@nongnu.org
X-Gm-Message-State: AOJu0YzwckJIhDev4U90XSOP6cKFvqD7I+DQUVqhGdFbFya6d4ahLrhx
 5lZR0VBK8MJTLMGyEiRmmg0I5Yoeg379C11HEQhA0v6hC2LSPixu108=
X-Gm-Gg: AR+sD11H+ZszQ2lf3Ka9foDJgmGcdzD4FsjYWdPW5lxsAmAPZUrRpJA1RLcm2y3XR1M
 BtwJbB3ywAKGwCNRCtjvcQjBY4g94PRPSHaHFsON8zy7IdPHQhcktuHaizmJXIJIPvCLyzuHQ6/
 f5l3LtJr5QmXvZ+HH5wUdKts2VrDROxXzFuPMrIQC3ns5iqidnusemrf3sAzDSab4/uQMMwombW
 QtUXO0Oz6LHIH3BnTBekJbiHixQ/I0Iz3fRKjCkgl0qZ2V6hGIQgrthB79xfrtwSpDlRpHPlM+V
 bldY1nqwMcYYUWI0d8EHmIG+yCZ6a6E21oHwZE76ZxIzzSIBqttX6GxtzvB85tgtC47kKdoh1aJ
 V4D/0OUjcLxiBFM2GeK8qCJE+RAIGcB/Jie0s0t/vI0QqogrsvPM5Qyf1TMDL1QjGv7flOi7uin
 SQLvXkiHZOnFLrBBjrZWR/qjfsRqZblsTpvVSpw3ul+50SBsyKUpGZNjtCi55hhOATuBV+
X-Received: by 2002:a17:90a:c2ce:b0:382:1aaf:4bab with SMTP id
 98e67ed59e1d1-38ec65ed795mr3150984a91.27.1784812356230; 
 Thu, 23 Jul 2026 06:12:36 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a?
 ([2408:820c:8ffa:c0f0:e439:d3f2:d7e2:d97a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm21840163c88.3.2026.07.23.06.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 06:12:35 -0700 (PDT)
Message-ID: <f722320f-205b-40d3-a727-753506ba5473@gmail.com>
Date: Thu, 23 Jul 2026 21:12:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] xen/igd: don't register rom bar twice
To: Chuck Zmudzinski <brchuckz@aol.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
 <20260709183517.25866-3-brchuckz@aol.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260709183517.25866-3-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 2026-07-10 02:35, Chuck Zmudzinski wrote:
> This also fixes a failed assertion in pci [1] for Qemu
> version 10 and higher when passing through an Intel
> IGD with an option ROM to the guest.
>=20
> [1] f6fc01c ("hw/pci: Assert a bar is not registered multiple times")
>=20
> Fixes: 881213f ("xen, gfx passthrough: retrieve VGA BIOS to work")

Please follow the QEMU standard way to reference a commit
`<at-least-12-digits-of-SHA-commit-id> (=E2=80=9CFixed commit subject=E2=80=
=9D)`

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-me=
aningful-commit-message

> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
> ---
> Changes in v2:
>   - get 'pcibus_t romsize' instead of 'PCIIORegion region'
>   - move definition of romsize to the top of the function
>     and make it constant
>   - add stable to Cc list
>=20
> Changes in v3:
>   - fix Cc address for qemu-stable
>=20
>  hw/xen/xen_pt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 474606e..8b30b61 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -459,6 +459,7 @@ static int xen_pt_register_regions(XenPCIPassthroug=
hState *s, uint16_t *cmd)
>  {
>      int i =3D 0;
>      XenHostPCIDevice *d =3D &s->real_device;
> +    const pcibus_t romsize =3D s->dev.io_regions[PCI_ROM_SLOT].size;
> =20
>      /* Register PIO/MMIO BARs */
>      for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> @@ -495,7 +496,7 @@ static int xen_pt_register_regions(XenPCIPassthroug=
hState *s, uint16_t *cmd)
>      }
> =20
>      /* Register expansion ROM address */
> -    if (d->rom.base_addr && d->rom.size) {
> +    if (!romsize && d->rom.base_addr && d->rom.size) {
>          uint32_t bar_data =3D 0;
> =20
>          /* Re-set BAR reported by OS, otherwise ROM can't be read. */


