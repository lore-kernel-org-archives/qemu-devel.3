Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525BECA101C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuW86-0005pi-SS; Fri, 05 Sep 2025 09:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.kral@proxmox.com>)
 id 1uuW81-0005oe-3b; Fri, 05 Sep 2025 09:05:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.kral@proxmox.com>)
 id 1uuW7t-0000SW-Ca; Fri, 05 Sep 2025 09:05:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C70D545CBA;
 Fri,  5 Sep 2025 15:04:55 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 15:04:54 +0200
Message-Id: <DCKVZLRURSRN.2J420LH4UWMIS@proxmox.com>
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU
 address space width
Cc: "Alex Williamson" <alex.williamson@redhat.com>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
From: "Daniel Kral" <d.kral@proxmox.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.20.0
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
In-Reply-To: <20250130134346.1754143-9-clg@redhat.com>
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1757077476965
Received-SPF: pass client-ip=94.136.29.106; envelope-from=d.kral@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu Jan 30, 2025 at 2:43 PM CET, C=C3=A9dric Le Goater wrote:
> Print a warning if IOMMU address space width is smaller than the
> physical address width. In this case, PCI peer-to-peer transactions on
> BARs are not supported and failures of device MMIO regions are to be
> expected.
>
> This can occur with the 39-bit IOMMU address space width as found on
> consumer grade processors or when using a vIOMMU device with default
> settings.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Hi C=C3=A9dric!

Some of our users are running into this with Proxmox VE, where they get
vfio_container_dma_map(...) =3D -22 errors, which are likely caused by
this issue of the mismatch mentioned above. Setting the guest-phys-bits
in accordance to the iommu aw-bits seems to fix that for users, e.g.
[0].

Before applying this downstream for pve-qemu, I saw that this patch was
dropped in the v3 [1], but you mentioned that this is addressed in a
later series. I couldn't find a direct follow-up in the archive, are
there any updates on this?

Thanks a lot in advance & have a nice weekend!

    Daniel


[0] https://forum.proxmox.com/threads/169586/page-3#post-795813
[1] https://lore.kernel.org/qemu-devel/20250206131438.1505542-1-clg@redhat.=
com/


