Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E12C636E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjLvC-00019e-8c; Wed, 28 Aug 2024 12:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf5271.v1-5a390a66f00c4585b864185ab6dd33a3@bounce.vates.tech>)
 id 1sjLvA-00018F-7t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:53:24 -0400
Received: from mail187-32.suw11.mandrillapp.com ([198.2.187.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf5271.v1-5a390a66f00c4585b864185ab6dd33a3@bounce.vates.tech>)
 id 1sjLv7-00078Q-AC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1724863089; x=1725123589;
 bh=UOStic/LZX6XVX/sSEGr44o+pPQAQeLXe2Il6UL0+vM=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=nMeQGcfqoNXlb8kZilQFe5XbWN5gbX73lwdYRpxljQRMn4VYTCeLtbMSxH4/Ba9dz
 teupWT1RDUNXZKK25qIYCfYZ0YBmCXvEOGJYQnY5gvmUx7j6ddLBL8Tr53bTj0k5YE
 uSunn1Us2dK2HRRoX5vj3gfve/Ce1Uou7FJOs7XzWPOO37VEvTCkCYuYp9M97wJZ4a
 101rgbGdxFDwUh/C178/Z2p+mMvsj0Emc3i29nZ+ndLkjwmkP2GfSvwngt8lHiwOFV
 wOa9gkUgmNfdL68H1bNI180aiTVyxNk3oTiCsSuV4EYab65Dd6a0fHg+54DKkmdQMr
 Vs8MY03/F++uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1724863089; x=1725123589; i=anthony.perard@vates.tech;
 bh=UOStic/LZX6XVX/sSEGr44o+pPQAQeLXe2Il6UL0+vM=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=HwvKsNv2hXv/f00CpKe/p3tzKiz46cN/bzSaDmWelvfchQ1p9seG4sjN5yV0BFJnL
 L3YLIncSxBFqDksiC//hiek0/NjrFbgutMBW0J+fRoIcoZKaMpkYKgOKvpsyjwem99
 ONdfIcCWg+Yon2JLDpKVFjIAcFg7JmpK9BqxrbIVIuiPrBKQCaZ/WehMCI9AfRnnPD
 0yR/M2/e+SdUhM9Ot77K7uiQUFYzxNYjGDbo51aEwq0wE3WFF5fzszVSIL17n1KL82
 yIlCXxQJ9cLbR11StpHOtjCnQx0RNPPozGHK0ZFS6mM+YzN2SxqZLvTVZLtT2sbWW7
 OYHgLFJA2bvTA==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail187-32.suw11.mandrillapp.com (Mailchimp) with ESMTP id
 4Wv9811cdNzQXgDGR
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 16:38:09 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v3=201/3]=20hw/xen/xen=5Fpt:=20Save=20back=20data=20only=20for=20declared=20registers?=
Received: from [37.26.189.201] by mandrillapp.com id
 5a390a66f00c4585b864185ab6dd33a3; Wed, 28 Aug 2024 16:38:09 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1724863087792
To: =?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Message-Id: <Zs9SbXAJ++8mj/uR@l14>
References: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
 <aa391652c33c8a4a64db8f27ad50ccb65600b293.1714955598.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <aa391652c33c8a4a64db8f27ad50ccb65600b293.1714955598.git-series.marmarek@invisiblethingslab.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.5a390a66f00c4585b864185ab6dd33a3?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240828:md
Date: Wed, 28 Aug 2024 16:38:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.187.32;
 envelope-from=bounce-md_30504962.66cf5271.v1-5a390a66f00c4585b864185ab6dd33a3@bounce.vates.tech;
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

On Mon, May 06, 2024 at 02:33:20AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> Call pci_default_write_config() only after resolving any handlers from
> XenPTRegInfo structures, and only with a value updated with those
> handlers. This is important for two reasons:
> 1. XenPTRegInfo has ro_mask which needs to be enforced - Xen-specific
>    hooks do that on their own (especially xen_pt_*_reg_write()).
> 2. Not setting value early allows hooks to see the old value too.
> 
> If it would be only about the first point, setting PCIDevice.wmask would
> probably be sufficient, but given the second point, change those
> writes.
> 
> Relevant handlers already save data back to the emulated registers
> space, call the pci_default_write_config() only for its side effects.
> 
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
> v3:
>  - use emulated register value for pci_default_write_config() call, not
>    the one for writting back to the hardware
>  - greatly simplify the patch by calling pci_default_write_config() on
>    the whole value
> v2:
>  - rewrite commit message, previous one was very misleading
>  - fix loop saving register values
>  - fix int overflow when calculating write mask

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


