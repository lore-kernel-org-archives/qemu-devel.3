Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04564C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnARN-0000dP-WE; Fri, 24 Jul 2026 03:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnARM-0000cL-98; Fri, 24 Jul 2026 03:35:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnARK-0003Xi-Jg; Fri, 24 Jul 2026 03:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7440bwLdBu5aInfxm6Skx/8EERF/lLkHI8z5y7lI2H0=; b=oFDVesDLz9wRtQ7/0VrpbJoS5q
 T+k1TIbsyWqPIJtpl+uxTYc1L18AZsg0vQrkQA1pW/YMDOJkafrtN5U3LG99Lc2d+z/SrnDKIrVoV
 BwgrGWBg2JHSq0xMMZpJiV2dTDTx8OL5PB1eJB+5tvhJVvkdV1AVQfEM6fn+KTfoLylQdykcHAf+3
 Lk8Ojn/WA7Mc1iVYdtJM0USj0ye+ixGlEaZK31ylVF0Pm7NLasajTZ9O1Q6Kk9HfKXXOg4gRz3Kbe
 lC5vNKnaTwfnqA82EV8eL/mkCx/iBaNTlm0mC2xS5HOdpnErBZtlUctipnswtc9rtWY6jTr9bhY/s
 kA8cYDLmFVI6t/IasnGhWdQTWfND2XWlEHC0lZW2C7Pxg5kq2BOfCyEchnYtW2r09atosRp4QmsRd
 0ubcV2A7C53XoKNZk618iQ2qluF3cnhNHpXFVc/md61uLRc7BaDNx/uOBqWUpcyaN5YopW8DDw53c
 VB5CqFFrAsfQNyIT9y1nRRRFdSuHONX2VyGtIEYdA3eEPplvMirrYYLM3qFHSkVvDRymgXwWsyAI+
 FpnoNbxDzjux2ehOj4GC0dDUQcZXo7DzOSd9w+J4Lg08L6hy5AA5K6aG+amVyrdiaO6tSIKRapZte
 81HXXffYOe+7U0GHYRmSIOjHXi3TSpSBEhq2Eu3Xc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH v3 0/2] 9p: fix guest-triggered Treaddir/ACPI eject UAF
Date: Fri, 24 Jul 2026 09:35:22 +0200
Message-ID: <3960698.kQq0lBPeGt@weasel>
In-Reply-To: <cover.1784809978.git.qemu_oss@crudebyte.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thursday, 23 July 2026 14:43:24 CEST Christian Schoenebeck wrote:
> A guest can trigger unplugging 9pfs server's virtio-pci device via ACPI
> eject. As a consequence the device is unrealized, server's internal state
> is freed while pending coroutines would still have access to them, causing
> a potential heap-use-after-free.
> 
> Overview Patches:
> 
>  - Patch 1: this is the core fix, that drains all PDUs (i.e. coroutines
>    that handle individual pending requests in parallel) before freeing
>    server state.
> 
>  - Patch 2: fixes a similar identified issue with the Xen transport, even
>    though not triggered via ACPI, it is also prone to UAF, plus a resource
>    leak.
> 
> v3:
>   - Patch 2: set s->transport = NULL in v9fs_device_unrealize_common()
>     and make the idempotent check just guard the v9fs_reset(s) and
>     v9fs_device_unrealize_common(s) calls in xen_9pfs_disconnect() to
>     prevent a NULL pointer dereference.
> 
> v2: [
> https://lore.kernel.org/qemu-devel/cover.1784392605.git.qemu_oss@crudebyte.
> com/ ] - Patch 1: Make Jia the official author of this patch.
>   - Drop prev. patch 2 ("hw/9pfs/virtio: disable hotpluggable property...")
>   - Patch 2: defer explict xen_9pfs_disconnect() call from error paths of
>     xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal().
> 
> Christian Schoenebeck (1):
>   hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
> 
> Jia Jia (1):
>   hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize
> 
>  hw/9pfs/9p.c               |  1 +
>  hw/9pfs/virtio-9p-device.c |  1 +
>  hw/9pfs/xen-9p-backend.c   | 17 +++++++++++++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



