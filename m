Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09067C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 16:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiy1u-0005sG-4r; Mon, 04 Aug 2025 12:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1uiwYl-0004ge-Oq
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:53:09 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1uiwYl-00052J-GC; Mon, 04 Aug 2025 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=oDV3/rL11uexFk7zXSPaMrBB8WIn4F+jyITwUI+KMqA=; b=PQ9Ub95+EvPVL0QMVcDL
 6GV+DgRYZ3daCM7XClmhQ1qVemgw7HT1qq0nf39Ss+18c4JE4plP4JmZFtI8P5rgNbpPUvl+zr5h9
 e3vXJJYRNEs+/DiqLkl5AZI32Hmz9TMGgQg/tPcMiuv3cYwIEJlayfQgOr6OTovKoSn6P4QGYdl8O
 rLRNUeuWyetr9FdF8XIRB/IsbQnr78nNCyO/Kr/7uJJa2RNb2htMEnhhAQM9i3DgXtV1JQ4su0WST
 iEAMTjGgOUfWFI5bnfJv8iOLITRQueklIlTVT3SEzTZaxkKdi4XwWWNO2dhgheUxd+ZfbgbP6u1b0
 BoRUWM9jh8Z94A==;
Date: Mon, 4 Aug 2025 16:53:02 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Viktor Kurilko <murlockkinght@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] Add a feature for mapping a host unix socket to a
 guest tcp socket
Message-ID: <aJDJTqgYxOpbGZs2@begin>
References: <20250804141125.313313-1-murlockkinght@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804141125.313313-1-murlockkinght@gmail.com>
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

Viktor Kurilko, le lun. 04 août 2025 21:05:01 +0700, a ecrit:
> > Does that not behave oddly when given a path?
> 
> I didn't quite understand what you meant. If you mean that we try to parse the
> host address despite the fact that it doesn't make sense for a unix socket,

Yes.

> then I added a check that in the case of using a unix socket, the host
> address should be empty. As an alternative solution, I can suggest
> specifying the unix socket
> path in the host address place and omitting the port initialization in this case.

-serial uses:
              tcp:[host]:port[,server=on|off][,wait=on|off][,node‐
              lay=on|off][,reconnect-ms=milliseconds]
                     The TCP Net Console has two modes  of  operation.  It  can

              unix:path[,server=on|off][,wait=on|off][,reconnect-ms=millisec‐
              onds]
                     A unix domain socket is used instead of a tcp socket.  The

So I'd say we'd want to follow the same principle, i.e.

-hostfwd=unix:hostpath-[guestaddr]:guestport

BTW, your patch needs to update the various documentations of hostfwd,
so users now that it's now possible to use unix sockets.


Samuel

