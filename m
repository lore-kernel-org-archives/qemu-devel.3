Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07113C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSj6-0004iY-Lv; Thu, 16 Jan 2025 11:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tYSj4-0004i9-EA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:28:10 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1tYSj2-0008Us-K2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:28:10 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D349849044;
 Thu, 16 Jan 2025 17:27:58 +0100 (CET)
Message-ID: <f49b2c63-33aa-446a-bf47-a59faf49dc2a@proxmox.com>
Date: Thu, 16 Jan 2025 17:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pci: acpi: Windows 'PCI Label Id' bug workaround
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com
References: <20250115125342.3883374-1-imammedo@redhat.com>
 <20250115125342.3883374-3-imammedo@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20250115125342.3883374-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 15.01.25 um 13:53 schrieb Igor Mammedov:
> Current versions of Windows call _DSM(func=7) regardless
> of whether it is supported or not. It leads to NICs having bogus
> 'PCI Label Id = 0', where none should be set at all.
> 
> Also presence of 'PCI Label Id' triggers another Windows bug
> on localized versions that leads to hangs. The later bug is fixed
> in latest updates for 'Windows Server' but not in consumer
> versions of Windows (and there is no plans to fix it
> as far as I'm aware).
> 
> Given it's easy, implement Microsoft suggested workaround
> (return invalid Package) so that affected Windows versions
> could boot on QEMU.
> This would effectvely remove bogus 'PCI Label Id's on NICs,
> but MS teem confirmed that flipping 'PCI Label Id' should not
> change 'Network Connection' ennumeration, so it should be safe
> for QEMU to change _DSM without any compat code.
> 
> Smoke tested with WinXP and WS2022
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/774
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Fixes the VirtIO NIC issue with a German Windows 10 guest for me.


