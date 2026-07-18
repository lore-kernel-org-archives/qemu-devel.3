Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F25C44520
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 01:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wktfR-0003Tj-UL; Fri, 17 Jul 2026 21:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wktfR-0003TP-0s; Fri, 17 Jul 2026 21:16:37 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wktfP-0004Na-Cv; Fri, 17 Jul 2026 21:16:36 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19D9B402FC;
 Sat, 18 Jul 2026 01:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D611F000E9;
 Sat, 18 Jul 2026 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784337393;
 bh=KHg02DIbUTKS6NQg6D6XkUWG8UnTwJZwxWKhXo5hQLk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=LYWC45lYYN0mRmDAhGncgqU9iboDLKoEJHUDS+I/ueC+P5Eah3qyrUIk0elcjec4D
 XZ5uD0efly5O8vAN5X5fEXxxi3VWNwzSv/o8JeW5T82YdtYI2o1TwPCp2HoU8+fQyM
 hq+JOFj9YWW+1NtzJns10L/npkBFj1jtEM/1lFxuYbGx2VPibh7/yNP6xBfUKr4U+u
 XJ9fRGFnoN5rBWGo2X85qeHYLYdSTt84Ldd+mnD20nQOeSZigs16kWdCEPg1WB9rbS
 6pcbrnIu3ojR5XAOXyOwrTJYRKkK7hM7O1OTTB7R27KphM1ODYz4sulYVnDdyBJXvS
 18xpprJ3+GNIQ==
Date: Fri, 17 Jul 2026 18:16:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] xen-block: Fix BlockBackend leak on unplug of empty
 CD-ROM
In-Reply-To: <20260716170923.2125858-4-Mitsuru.Kariya@oss.nttdata.com>
Message-ID: <alpine.DEB.2.22.394.2607171816240.16921@ubuntu-linux-20-04-desktop>
References: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
 <20260716170923.2125858-4-Mitsuru.Kariya@oss.nttdata.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=sstabellini@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 17 Jul 2026, Mitsuru Kariya wrote:
> When a Xen CD-ROM is created without a backing drive (an empty CD-ROM),
> xen_cdrom_realize() allocates an anonymous BlockBackend for the empty
> drive with blk_new() and attaches it to the device using
> blk_attach_dev().
> 
> blk_new() returns the backend with refcnt == 1 (the creation reference
> owned by the caller) and blk_attach_dev() takes an additional reference
> for the device.  The creation reference was never released, so on
> unplug blk_detach_dev() only drops the device's reference and the
> BlockBackend is leaked.
> 
> Release the creation reference with blk_unref() right after
> blk_attach_dev(), matching the idiom already used in set_drive_helper()
> in hw/core/qdev-properties-system.c ("If we need to keep a reference,
> blk_attach_dev() took it").
> 
> Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/block/xen-block.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index abf9df2eee..e5e14e47ee 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -763,6 +763,7 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
>  
>          rc = blk_attach_dev(conf->blk, DEVICE(blockdev));
>          assert(rc == 0);
> +        blk_unref(conf->blk);
>      }
>  
>      blockdev->info = VDISK_READONLY | VDISK_CDROM;
> -- 
> 2.43.0
> 

