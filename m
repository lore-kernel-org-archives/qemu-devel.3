Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB4EC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NXO-00044f-VB; Fri, 04 Sep 2026 02:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1x2NXN-000448-1g; Fri, 04 Sep 2026 02:36:33 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1x2NXL-0006Y7-Ek; Fri, 04 Sep 2026 02:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=hd/jOcPgoUsd+CCaPHU5hbage09TmXRYNElOc6TqwbI=; b=aNiU6xfgi44quC7k6hkz
 V0DQdQ8gI05teXZ99qjL20q/S3pi8266WDckrPK4kE+TBA3vvwFvHzRI9FIl14YP+Efb6f4v49lx0
 08cWr/I+G7Kts7ONH4ksYYNKRXjEt/JPn3Bos0gtO/aGcaDsVNIof32aU66jqZUavcD2lIK+XX6xV
 HfYoFjRU/3dCD3sb7RtjKoP+2La3+NU/Eo1iPto9fRrqP15lrczOtWKgzMwkrbk8J7WxibV9B3iF5
 UEqBh7RTEOU1kad5U4Kbb/Pz67WiSG3MSLdmNzKNxPr9a5gotb4O7AgjF8Tsg0rv6V9fl2c+V1UXB
 DgAWx9/Tz5HO9g==;
Date: Fri, 4 Sep 2026 08:36:28 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] chardev/baum: unregister the brlapi fd handler on finalize
Message-ID: <appm7D8eXhWVvH14@end>
References: <20260904033055.413-1-getshell@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904033055.413-1-getshell@seu.edu.cn>
Organization: I am not organized
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

Hongyan Xu, le ven. 04 sept. 2026 11:30:55 +0800, a ecrit:
> baum_chr_open() registers baum->brlapi_fd with the main loop through a
> raw qemu_set_fd_handler() call.  The chardev base class does not know
> about this handler, and char_braille_finalize() only closes the brlapi
> connection and frees the handle; it never removes the fd handler.

It should, indeed, thanks for noticing it.

The other brlapi__closeConnection call at the end of baum_chr_read
should be doing it as well, could you add it there as well?

Thanks,
Samuel

> When the chardev is removed at runtime (QMP chardev-remove /
> object_unparent), BaumChardev is finalized and freed while the main loop
> still holds an fd handler whose opaque points to the freed object.  The
> next time brlapi_fd becomes readable (or the connection drops) the loop
> calls baum_chr_read() with a dangling opaque, dereferencing freed
> memory -> host use-after-free.
> 
> Unregister the handler in char_braille_finalize() before tearing the
> connection down, using the same descriptor that baum_chr_open()
> registered, and NULL the handle afterwards as a belt-and-braces guard.
> Only do so while baum->brlapi is valid: baum_chr_open() sets
> baum->brlapi_fd from brlapi__openConnection(), which is
> BRLAPI_INVALID_FILE_DESCRIPTOR on failure, and that error path already
> g_free()s the handle and returns before any handler is installed.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  chardev/baum.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/chardev/baum.c b/chardev/baum.c
> index ac1e535ba8..6d9df70c7e 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -671,8 +671,16 @@ static void char_braille_finalize(Object *obj)
>  
>      timer_free(baum->cellCount_timer);
>      if (baum->brlapi) {
> +        /*
> +         * baum_chr_open() registered brlapi_fd with the main loop via
> +         * qemu_set_fd_handler(); unregister it before tearing the
> +         * connection down so a later chardev-remove cannot dispatch
> +         * baum_chr_read() with a dangling opaque.
> +         */
> +        qemu_set_fd_handler(baum->brlapi_fd, NULL, NULL, NULL);
>          brlapi__closeConnection(baum->brlapi);
>          g_free(baum->brlapi);
> +        baum->brlapi = NULL;
>      }
>  }
>  
> -- 
> 2.50.1.windows.1
> 

