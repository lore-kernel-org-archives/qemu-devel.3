Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58489CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWNb-0003SP-R8; Sun, 18 Oct 2026 15:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWNX-0003Ro-FZ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:17:08 -0400
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]
 helo=sonata.ens-lyon.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWNV-0005jb-VN
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:17:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 2E5CEA224F;
 Sun, 18 Oct 2026 21:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792351024; bh=2AG+kDAVIyTdACMbq4q//oZ5M07NpbIAojZwBt59Xqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RmuIe4KCrdY9l7guhbuZFBVDGRUCTNRX/2jN78Hboh/OPb/VGnMnWBLEkHX+QlyL+
 l+99amnoahWRKDQsZBfQQiLBZK/NNC52zp+SRdYlM1jUEVKjtniGx62jphOq2BksP+
 zQe6GCae3+6Qe+xfhATPeXuKqLM+8umL6Ur2Pb+U2C8rUgtEWkkHGaZEvOyD+mflA5
 3lvJ1bShY1PVZ6M3UWMCrxh0ThzQCSd5J8FreBD93jfALELoJZYhsMkrM2xVDrBE4C
 PPIY9GUJ60+0GwWvI+xUOO/KJ0F+QsRTnospo1qs87OIwiyF7j8wo4r5upL2jgFQ3i
 lTU/+HV93nLDA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3S0wP9ULtbeh; Sun, 18 Oct 2026 21:17:04 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id D6DFAA1C00;
 Sun, 18 Oct 2026 21:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792351024; bh=2AG+kDAVIyTdACMbq4q//oZ5M07NpbIAojZwBt59Xqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RmuIe4KCrdY9l7guhbuZFBVDGRUCTNRX/2jN78Hboh/OPb/VGnMnWBLEkHX+QlyL+
 l+99amnoahWRKDQsZBfQQiLBZK/NNC52zp+SRdYlM1jUEVKjtniGx62jphOq2BksP+
 zQe6GCae3+6Qe+xfhATPeXuKqLM+8umL6Ur2Pb+U2C8rUgtEWkkHGaZEvOyD+mflA5
 3lvJ1bShY1PVZ6M3UWMCrxh0ThzQCSd5J8FreBD93jfALELoJZYhsMkrM2xVDrBE4C
 PPIY9GUJ60+0GwWvI+xUOO/KJ0F+QsRTnospo1qs87OIwiyF7j8wo4r5upL2jgFQ3i
 lTU/+HV93nLDA==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xIWNT-00000002AzV-1sPe; Sun, 18 Oct 2026 21:17:03 +0200
Date: Sun, 18 Oct 2026 21:17:03 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexander Epaneshnikov <aarnaarn2@gmail.com>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atUbL22N4UounO8L@end>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUU4HpVVI59QcLJ@alex-pc>
Organization: I am not organized
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
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

Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > I'm a bit surprised by setting the priority to 0, but maybe that's
> > because of your setup, which is not described enough. Are you
> > running on the linux console or X, actually?
> 
> Sorry, I should have described it. The host runs GNOME on Wayland on
> tty 2, with Orca using BrlAPI.
> 
> The guest is a Windows VM started by libvirt, with a second GPU passed
> through to it. My monitor is connected to both GPUs. I switch its input
> by hand, or over DDC/CI when I need sighted help. QEMU itself has no
> window: the display is "none", and SPICE has no listener. I am blind,
> so in practice I use the guest through NVDA's speech, which comes out
> through PipeWire on the host, and its braille.
> 
> > But then how do you access the VM to get keyboard/mouse access?
> 
> Through input-linux (libvirt <input type='evdev'> with grab='all').
> QEMU reads the host keyboard and mouse evdev devices directly. Pressing
> both Ctrl keys toggles the exclusive grab between the host and the
> guest.

So you mean that you make qemu steal keyboard presses from under your
Wayland session? That is very peculiar... I'm really unclear this way of
stealing the keyboard will work on the long run.

> There is no front-end. The grab toggle happens inside QEMU's
> input-linux, so QEMU is the only process that knows which side has the
> keyboard. libvirt doesn't see it, and neither does anything else on
> the host. That is why I thought baum should react to it directly.

I now understand your situation, but I don't think it is long-term
sustainable :/

> > SDL/GTK do not need a grab: provided that the window id is properly
> > set, brlapi already switches according to the window focus.
> 
> Thanks, that answers my third question. Then only input-linux, which
> has no window, needs to report the grab.

Yes, this is really a situation only for such tinkering.

Samuel

