Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F971CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xITiu-0007Cn-7w; Sun, 18 Oct 2026 12:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xITir-0007CU-W5
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 12:26:58 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xITiq-0007OT-49
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 12:26:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id BD009A0316;
 Sun, 18 Oct 2026 18:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792340813; bh=CW35xCRf0LDzsrgyKkIXjR6SPhPWKKY+GzWVIOeSY9Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SoUuIKlGMlJ4JcX7dvZJToD7TmX5VhXoN2Clxts79M+iaj1SBV1sFigzSFvDgLoRN
 Kcs3jjIwz2hx0ybTr1SUpoALaUaAN3fGBWI39nuxPODGEyuSxlgGXEpN53Uo3MwO2N
 I9zl85iVPD829b9M/l9L9WU3TWRt6ONiXuqBXVuy5RMA/0LECp57N8Ch/JWKBG/DxM
 fuUaxpq4MGYW7C4JPzQl3FoJMUZa8uxgbyuLiQ6aicTq/vwPLkz7UvwXEGrH1KPOEK
 vl+i2DVcRiIp8iDl7OyEbn86RmAS0Ggo5tghiEHOJMagkEpwnHVisOpAFRhhrotAAs
 VmM64ya46licg==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjEKGlA4e8L5; Sun, 18 Oct 2026 18:26:53 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 7F5DBA0288;
 Sun, 18 Oct 2026 18:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792340813; bh=CW35xCRf0LDzsrgyKkIXjR6SPhPWKKY+GzWVIOeSY9Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SoUuIKlGMlJ4JcX7dvZJToD7TmX5VhXoN2Clxts79M+iaj1SBV1sFigzSFvDgLoRN
 Kcs3jjIwz2hx0ybTr1SUpoALaUaAN3fGBWI39nuxPODGEyuSxlgGXEpN53Uo3MwO2N
 I9zl85iVPD829b9M/l9L9WU3TWRt6ONiXuqBXVuy5RMA/0LECp57N8Ch/JWKBG/DxM
 fuUaxpq4MGYW7C4JPzQl3FoJMUZa8uxgbyuLiQ6aicTq/vwPLkz7UvwXEGrH1KPOEK
 vl+i2DVcRiIp8iDl7OyEbn86RmAS0Ggo5tghiEHOJMagkEpwnHVisOpAFRhhrotAAs
 VmM64ya46licg==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xITin-00000001wlR-0IIb; Sun, 18 Oct 2026 18:26:53 +0200
Date: Sun, 18 Oct 2026 18:26:53 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexander Epaneshnikov <aarnaarn2@gmail.com>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atTzTVaSxUy5r95x@end>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atPIRr46KvMoiCti@alex-pc>
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

Hello,

Alexander Epaneshnikov, le sam. 17 oct. 2026 22:13:26 +0300, a ecrit:
> Sorry about that. I'm adding qemu-devel and the BRLTTY list now, and
> quoting my original message in full below for the lists.

Thanks, that will help to get advice from everybody and agree on things.

> > Alexander Epaneshnikov, le sam. 17 oct. 2026 15:23:14 +0300, a ecrit:
> > > For serial ports it detects the display by sending PROTOCOL_ONOFF (0x15) to turn the protocol off and then on, then waits for the cell count (0x01) and the device identity (0x84).

Ah, that is a requirement of the protocol? Then we need to do that
indeed. What is the value of the uint8_t protocol field when it expects
to receive 0x01 and 0x84?

> > > 2. Sharing the display between the host and the guest.
> > >
> > > My prototype adds a small grab notifier in ui/input.c. input-linux fires it when the grab toggles.

That part needs to be discussed with qemu.

> baum then changes its BrlAPI client priority (BRLAPI_PARAM_CLIENT_PRIORITY, local): 80 while the guest holds the grab, which is above Orca's 50 and the 70 it uses in flat review, and 0 (disabled) when the grab is released.

I'm a bit surprised by setting the priority to 0, but maybe that's
because of your setup, which is not described enough. Are you running on
the linux console or X, actually?

> Under libvirt, QEMU has no controlling tty, so I also set CONTROLVT in the environment.

But then how do you access the VM to get keyboard/mouse access?

> BRLTTY then switches between the two clients on the same tty without reconnecting, and each side's last content comes back straight away. 

What are the two clients you are talking about? Is that two VMs run by
qemu?

My crude guess is that you are using some sort of front-end. In that
case, one would rather need to teach it to access brlapi itself, instead
of the qemu backend doing it. That way everything will go just smoothly.

> > > - Is client priority the right BrlAPI mechanism for this, or would you rather do it another way?
> > > - Should it be opt-in, for example a chardev option?
> > > - Should other grab sources (SDL, GTK) report to the same notifier, or should it stay limited to input-linux?

SDL/GTK do not need a grab: provided that the window id is properly set,
brlapi already switches according to the window focus.

Samuel

