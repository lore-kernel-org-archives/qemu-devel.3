Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09A3C636E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjM4t-0001IO-1r; Wed, 28 Aug 2024 13:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf54ce.v1-e832e1df9d694d8dac74261a755d2d7c@bounce.vates.tech>)
 id 1sjM4q-0001HF-NS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:03:24 -0400
Received: from mail187-32.suw11.mandrillapp.com ([198.2.187.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf54ce.v1-e832e1df9d694d8dac74261a755d2d7c@bounce.vates.tech>)
 id 1sjM4n-0008HI-Nw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 13:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1724863694; x=1725124194;
 bh=8NvK91ipe60HCoJYurXZDNDoH6ucf6ji/cyjBADJiGw=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=qylCvrzJLY0ccwpvzEV0owT4LCWYcvLo7Z/pGojFryzVVjmwiKkAfUfIezwV5an/e
 DhSkQ0T3guKUJwJb9cacSQEMtDTWYPBKlNhdLR6jXzUg85kZOokG77V+/Oblmt3o+C
 LcvGib4CYw1kD2vT+Zh9RCvdm7Em+qCzwEoEC+yBbDXK7LDMrCwP1+d74XMxU5zhGA
 eCfMpmnHp1arBe/hoSEJOJgD1YvBWyGE97gyu9sO7Gq3MEfJdHc7MqKKVhhoIB3CqE
 6zwEd+DiKF0MrgsFmWl8baVLezVc+L4dy0IPIxoq0QpTO2dMWC4IN7DhryBIGWzF29
 x6I0yFx0l2CXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1724863694; x=1725124194; i=anthony.perard@vates.tech;
 bh=8NvK91ipe60HCoJYurXZDNDoH6ucf6ji/cyjBADJiGw=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=bTYaD2hnMc+BbPzw3L5NyKUg16FRWTeVRoejFBUdz+ouasejtQwSKMpxHEKEwK3Jo
 ww/trbe3j/07ehlpdigWRLRXM0bEjOaQclumiJNM5a3saF/fu17fUduJPaz+GikWhi
 o3vD3xKt7IhvPkeIe28fzt4wg+IYYRt3Mdwm3KnvPZKx6gerXOoYfesPEmn0ZJ/AFL
 gw6HXYpEFF76BHGQhf0WFOwJ78htw8tbuPp7wQEW1ViuKQ6yYiyD1A1AqJ5S2gicFS
 UrdI6fQk3tSJp2Puu76mC+ipJ3DW4JP6/oKAqKpK+Lffezji4sP2bpLauMYoBrvhtP
 lm9ZWywd/+6Hg==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail187-32.suw11.mandrillapp.com (Mailchimp) with ESMTP id
 4Wv9Mf3dhCzQXgCsr
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 16:48:14 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v3=203/3]=20Do=20not=20access=20/dev/mem=20in=20MSI-X=20PCI=20passthrough=20on=20Xen?=
Received: from [37.26.189.201] by mandrillapp.com id
 e832e1df9d694d8dac74261a755d2d7c; Wed, 28 Aug 2024 16:48:14 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1724863693032
To: =?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Message-Id: <Zs9UzJVsjKU0/frk@l14>
References: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
 <ebeb8c419feedad9fe0e9f39d3ed3a9ff0f4c49b.1714955598.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <ebeb8c419feedad9fe0e9f39d3ed3a9ff0f4c49b.1714955598.git-series.marmarek@invisiblethingslab.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.e832e1df9d694d8dac74261a755d2d7c?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240828:md
Date: Wed, 28 Aug 2024 16:48:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.187.32;
 envelope-from=bounce-md_30504962.66cf54ce.v1-e832e1df9d694d8dac74261a755d2d7c@bounce.vates.tech;
 helo=mail187-32.suw11.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 06, 2024 at 02:33:22AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index 09cca4e..836cc9c 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -493,7 +501,12 @@ static uint64_t pci_msix_read(void *opaque, hwaddr a=
ddr,
>          return get_entry_value(&msix->msix_entry[entry_nr], offset);
>      } else {
>          /* Pending Bit Array (PBA) */
> -        return *(uint32_t *)(msix->phys_iomem_base + addr);
> +        if (s->msix->phys_iomem_base) {
> +            return *(uint32_t *)(msix->phys_iomem_base + addr);
> +        }
> +        XEN_PT_LOG(&s->dev, "reading PBA, addr 0x%lx, offset 0x%lx\n",
> +                   addr, addr - msix->total_entries * PCI_MSIX_ENTRY_SIZ=
E);
> +        return 0xFFFFFFFF;

If Xen advertise XENFEAT_dm_msix_all_writes, we are not expecting QEMU
to reach this code, right? A comment might be useful.

>      }
>  }
>  
> @@ -576,33 +593,40 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uin=
t32_t base)
>      msix->table_base =3D s->real_device.io_regions[bar_index].base_addr;
>      XEN_PT_LOG(d, "get MSI-X table BAR base 0x%"PRIx64"\n", msix->table_=
base);
>  
> +    /* Accessing /dev/mem is needed only on older Xen. */
> +    if (!(xc_version_info.submap & (1U << XENFEAT_dm_msix_all_writes))) =
{

Would it be ok to use test_bit() instead?

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


