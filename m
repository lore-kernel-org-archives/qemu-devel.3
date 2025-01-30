Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6632C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRZi-0002wO-Se; Thu, 30 Jan 2025 05:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdRZf-0002rE-Ox
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:15:03 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdRZf-0007eV-C5; Thu, 30 Jan 2025 05:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=lyV6YgttRJBb5YHwDderePSq5iKczKbhkg4lRXS5fhI=; b=MefbM+z9/A40iNuPtK9X
 HuFJN5M+I1Pj3w3yrEhVh7iVImk3eL4PKnwuGPsowu5oMx/iY4qM6iDl9FIbCPVHxZYZ93t0Z/LwS
 Z+73+chrd/9Bnvg2KmEvFNmqz4rtCzJm8Bx9QP6ZfNbnNec8MCxRQHXfCFpRjwyhTpQY4DU51QES+
 kF7azAQDAPwIUy2AxkQUrAPfiXnUpccgB3PdnVBekmlT1QfkSjO0gp7KfkJp735yG67aeJ/DIKjdP
 0khQEbVl7X1MYmSwuNIaQBXgzejWFdl3vU771ULvDvUjibtzNPiF+bFTOsibGVHgKlqoZQkZhU3gd
 ntU7qIrSazY0Hw==;
Date: Thu, 30 Jan 2025 11:15:00 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] net/slirp: introduce slirp_os_socket to stay compatible
 with libslirp past 4.8.0
Message-ID: <Z5tRJM6WI52SqQtA@begin>
References: <20241005070753.1328079-1-mjt@tls.msk.ru> <ZwcMh1Vl9VsTbIRq@begin>
 <Z5rgUDDB0X58-XZt@begin>
 <36e2ee26-89ee-442b-85fa-015d919cc86f@redhat.com>
 <f6b3926b-1328-45c9-a355-9ab732842dff@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b3926b-1328-45c9-a355-9ab732842dff@tls.msk.ru>
Organization: I am not organized
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

Michael Tokarev, le jeu. 30 janv. 2025 13:12:39 +0300, a ecrit:
> 30.01.2025 13:09, Thomas Huth wrote:
> > On 30/01/2025 03.13, Samuel Thibault wrote:
> > > Hello,
> > > 
> > > Samuel Thibault, le jeu. 10 oct. 2024 01:06:47 +0200, a ecrit:
> > > > Michael Tokarev, le sam. 05 oct. 2024 10:07:53 +0300, a ecrit:
> > > > > libslirp introduced new typedef after 4.8.0, slirp_os_socket, which
> > > > > is defined to SOCKET on windows, which, in turn, is a 64bit number.
> > > > > qemu uses int, so callback function prorotypes changed.
> > > > 
> > > > I have fixed the code in upstream libslirp, to avoid breaking the API
> > > > and ABI, and instead provide new functions & methods so that
> > > > qemu/libslirp can upgrade smoothly.
> > > 
> > > It is now released in version 4.9.0 of libslirp.
> > 
> > Seems like 4.9.0 breaks the CI:
> > 
> > https://gitlab.com/thuth/qemu/-/jobs/8994301595#L4373
> 
> Yes, it's because the old method used by qemu is now deprecated,
> and we build with -Werror.
> 
> The prob here is that apparently we don't have a good way to use
> slirp on win64.  Because the new slirp callback uses SOCKET type
> instead of int, and SOCKET is 64bit on win64, and qemu main loop
> is based on GPollFD which uses int.

? GPollFD uses a gint64 on win64.

Samuel

