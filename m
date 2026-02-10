Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03567EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuov-0004Dd-3F; Tue, 10 Feb 2026 15:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpuot-0004C0-1T
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:58:51 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpuoq-0008Mx-SQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:58:50 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EE4645969FA;
 Tue, 10 Feb 2026 21:58:46 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id WG02CfWkoeyg; Tue, 10 Feb 2026 21:58:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DF2B75969F6; Tue, 10 Feb 2026 21:58:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD2F55969F3;
 Tue, 10 Feb 2026 21:58:44 +0100 (CET)
Date: Tue, 10 Feb 2026 21:58:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
In-Reply-To: <cover.1770753117.git.balaton@eik.bme.hu>
Message-ID: <6fadf912-a556-1e3b-b606-54056d311a41@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 10 Feb 2026, BALATON Zoltan wrote:
> Our documentation says that memory regions are automatically freed
> when the owner dies and the reference counting to do this is also
> implemented. However this relies on the QOM free funtion that can only
> be set by creating objects with object_new but memory API only
> provides constructors that call object_initialize which clears the
> free function that prevents QOM to manage the memory region lifetime.
> Implement corresponding memory_region_new_* functions that do the same
> as the memory_region_init_* functions but create the memory region
> with object_new so the lifetime can be automatically managed by QOM as
> documented. The memory_region_init functions are kept because they are
> useful for memory regions embedded in other object or managed
> externally and not by QOM for some reason.
>
> v3:
> Based-on: <cover.1770753117.git.balaton@eik.bme.hu>

I mean
Based-on: <cover.1770253186.git.balaton@eik.bme.hu>
[PATCH v4 0/8] memory: Remove most _nomigrate variants
series.

> - convert xtfpga from nomigrate as this has no migration compatibility
> issue
>
> v2:
> - rebase on master
> - update documentation
> - use these function to fix some leaks (there may be more, e.g. in
> hw/pci-host/bonito but I leave that for later and/or others)
>
> BALATON Zoltan (6):
>  memory: Add memory_region_new* functions
>  memory: Update documentation for memory_region_new*()
>  hw/ide/sii3112: Use memory_region_new to avoid leaking regions
>  hw/pci-host/articia: Map PCI memory windows in realize
>  hw/pci-host/articia: Add variable for common type cast
>  hw/xtensa/xtfpga: Fix leaking memory region
>
> docs/devel/memory.rst   |  21 ++---
> hw/ide/sii3112.c        |  30 +++----
> hw/pci-host/articia.c   |  22 +++--
> hw/ppc/amigaone.c       |  28 ++-----
> hw/ppc/pegasos.c        |  13 ---
> hw/xtensa/xtfpga.c      |   7 +-
> include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++
> system/memory.c         | 181 ++++++++++++++++++++++++++++++++++++++++
> 8 files changed, 407 insertions(+), 74 deletions(-)
>
>

