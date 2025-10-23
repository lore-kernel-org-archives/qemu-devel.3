Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF279CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsIb-0001LH-HS; Thu, 23 Oct 2025 06:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vBsIZ-0001Ks-Fi
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:11:59 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vBsIX-0004Nu-7G; Thu, 23 Oct 2025 06:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=qDLc6qImHaO2orESoouuY+84axYYEucTlsN5Wb9G9Tw=; b=UW3nZnL0hWSLhggl6R0F
 kieDcPbQ2pMLqoQNM+bji0MfC1JxorH+k7Pf/NECUuPhYBwWXdOh4kvLwyHf4zoBqjCIQfXDvxsgU
 QKTZboY2OUKHMmp6Hnal8TBcceuZpiak3bdMzP1KvsIe4yTwVPqiqG13OYGD6CYM6nu55tZyXbe9o
 gdFxVjL/7NJ+lxRp/cMrB8TTS4YXHC2Kw4jAnaVIPdAS2mX6gf7cWx1pOAgvpqR6AV/EYAeW0F9TX
 R0qK+1gaWmx50N3ce3F80MEp/CtQYuU5x8+pyYh2X+sLiwq7TxWcmvdlguPreyMJ9+8p2G+hnEVYB
 4LF+SYJXeH5Bcw==;
Date: Thu, 23 Oct 2025 12:10:46 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Viktor Kurilko <murlockkinght@gmail.com>,
 stefanha@redhat.com, jan.kiszka@siemens.com
Subject: Re: [PULL 1/1] Add a feature for mapping a host unix socket to a
 guest tcp socket
Message-ID: <aPn_Jtkj9PWHkaQ7@begin>
References: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
 <20251005194734.4084726-2-samuel.thibault@ens-lyon.org>
 <CAFEAcA_P2=kv_WZZP7k_5TRvTmzo1NMUq8r+sMFCRBApORXkKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_P2=kv_WZZP7k_5TRvTmzo1NMUq8r+sMFCRBApORXkKA@mail.gmail.com>
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

Hello,

Peter Maydell, le jeu. 23 oct. 2025 10:58:10 +0100, a ecrit:
> Coverity worries here about a possible time-of-check-time-of-use
> bug (CID 1641394). This is a heuristic that tends to fire even
> when there's no interesting attack possible, but I don't
> know what this code is doing so I raise it here:
> 
> > +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> > +        struct stat st;
> > +        if (stat(buf, &st) == 0) {
> 
> Coverity notes that we do a check on the filename here
> with stat()...
> 
> > +            if (!S_ISSOCK(st.st_mode)) {
> > +                fail_reason = "file exists and it's not unix socket";
> > +                goto fail_syntax;
> > +            }
> > +
> > +            if (unlink(buf) < 0) {
> 
> ...and then later we do an unlink() if it's a unix socket.
> But Coverity points out that an attacker could change what
> the filename points to between the stat and the unlink,
> causing us to unlink some non-socket file.
> 
> Do we care ?

It is true that an "attacker" could be pointing qemu to a symlink to
a socket, and stat() will follow it, and they can change the symlink
into something else (a symlink to something else, or another type of
file), and we'll unlink() that (which will not follow any symlink, so
just unlink the given path).

I don't see which harmful scenario we could have here. Either the
attacker has control over the given path, and we'll just unlink it, too
bad for them, or they don't have control over the given path, and they
won't be able to change it to their liking between stat() and unlink().

Once thing we could do is to use fstatat to pass AT_SYMLINK_NOFOLLOW,
(when fstatat is available), but I'm not really seeing it worth the
effort.

Samuel

