Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750ABFC97EB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 19:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6vUJ-0003Bc-5Q; Sun, 29 Mar 2026 15:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w6vUG-0003An-Vx
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 15:07:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w6vUE-0003cS-Nz
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 15:07:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 778755969F2;
 Sun, 29 Mar 2026 21:07:44 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id d8mP16rD8pph; Sun, 29 Mar 2026 21:07:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 727175968DE; Sun, 29 Mar 2026 21:07:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 703E85968DD;
 Sun, 29 Mar 2026 21:07:42 +0200 (CEST)
Date: Sun, 29 Mar 2026 21:07:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: VGA default endianness (was: [PATCH] hw/display/cirrus_vga_isa:
 Disable global_vmstate by default for new machines)
In-Reply-To: <20260326154850.301609-1-thuth@redhat.com>
Message-ID: <30981a1a-b895-3829-0f9c-7b22e72bd0fa@eik.bme.hu>
References: <20260326154850.301609-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 26 Mar 2026, Thomas Huth wrote:
> In the long run, we would like to get rid of the code that allows to

Not related to this patch but there's another hack in vga that might be 
good to get rid of similarly. At hw/display/vga.c:2263 it says:

     /*
      * Set default fb endian based on target, could probably be turned
      * into a device attribute set by the machine/platform to remove
      * all target endian dependencies from this file.
      */
     s->default_endian_fb = target_big_endian();
     s->big_endian_fb = s->default_endian_fb;

I think this does not make much sense as VGA is little endian but since 
this hack is there since forever just changing it may break some guests. 
I've tried that changing the default_endian_fb to false at least breaks 
OpenBIOS and its QEMU VGA NDRV for MacOS. So at least those might need 
some backward compatibility property until they are fixed. I don't know 
what else could it break but maybe it would be a good opportunity to 
change it with new machine types with a property that could also be set by 
users if something breaks just to find out what might need fixing and 
eventually be able to remove it. Anybody wants to make a patch?

Regards,
BALATON Zoltan

