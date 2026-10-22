Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB83606A328
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gnu.org header.i=@gnu.org header.a=rsa-sha256 header.s=fencepost-gnu-org header.b=c+6ZqOwa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0wg-00054g-Ga; Thu, 22 Oct 2026 18:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xK0wd-000539-5H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 18:07:31 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xK0wc-0002Gy-OL; Thu, 22 Oct 2026 18:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=7T8cmNW22OSmf19HrXLLhc80bPO7MxZ38tUuDuogmAo=; b=c+6ZqOwavZPTGlkEpdho
 uIp5Fb36wM83Bf1ttx4xGUH5XkfItrG8XwNVeEQBqKjjVcWtmIwTawGJjStL3xOzlmQqIbLWZZc0J
 z8mSFQu2AyAbIHVUrvpk8ON1al8kuHiX6HWql29uoij0XSstVWVn8hAfRJFo3/ANk6BhMvqIqzqu7
 SwjjF/JPBvy0N1rt+PW4FpMIovEF7sIkHA0lIqUhAbJ2urcGifh8khH4xKGcp4QT9c0nx3j8+CfzB
 yMM/kS8Nz9wMtjY0YLqg5JbKWLKrBgll6Xs7dsBIX7xkoUhjVHo+fhtl4nTSckRujUh8M5DUTGh0P
 uQQKp2p195ap/A==;
Date: Fri, 23 Oct 2026 00:07:29 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] baum: send device identity and cell count on protocol
 off/on
Message-ID: <atqJIVegHeKP00eJ@end>
References: <20261021230736.1451533-1-samuel.thibault@ens-lyon.org>
 <179267098536.3250908.6929134299379237877.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179267098536.3250908.6929134299379237877.b4-review@b4>
Organization: I am not organized
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

marcandre.lureau@redhat.com, le jeu. 22 oct. 2026 16:09:45 +0400, a ecrit:
> > The hardware devices do identify themselves when the driver turns the
> > protocol off and on again. NVDA expects to get it.
> > Message-ID: <20261021230736.1451533-1-samuel.thibault@ens-lyon.org>
> 
> Missing required Signed-off-by

Oops, right.

> > ---
> >  chardev/baum.c | 32 ++++++++++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/chardev/baum.c b/chardev/baum.c
> > index ac1e535ba8e9..e60fb628e0ff 100644
> > --- a/chardev/baum.c
> > +++ b/chardev/baum.c
> > @@ -97,6 +97,7 @@ struct BaumChardev {
> >      brlapi_fileDescriptor brlapi_fd;
> >      unsigned int x, y;
> >      bool deferred_init;
> > +    bool protocol_on;
> 
> reset it alongside deferred_init? or document if it's intentional

It's only x,y that are not know before deferred_init. I have separated
them out.

> > @@ -441,17 +456,18 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
> >          uint8_t protocol;
> >          DPRINTF("SetProtocol\n");
> >          EAT(protocol);
> > -        /* ignore */
> > +        if (!baum->protocol_on && protocol) {
> 
> Maybe it should respond on all ->on "if (protocol)"?

I was told that “A real display answers only when the protocol goes
from off to on”.

Thanks!
Samuel

