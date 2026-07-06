Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DD2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgj83-00047y-2E; Mon, 06 Jul 2026 09:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgj7y-00044s-W8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgj7x-0004nw-Hf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783343568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oiMXy+sef7fXIQqddHMLeQSNpkSrRf9gK7M010QxRmU=;
 b=c4UTt940+YNvennYgqm+0EcKSXseKDB9GwB6OV7EaLi8X/ZytRQCsvkKHMIMdUEcWz8Eil
 giOWcEt6vCAR8zUF2CltscoG/TRG2Gv840nPzLGwJEdXBy8Dn66mYE+2TTdphbAoWlDRML
 wdxjF0scaFZ9JjsAMKTS4SCm8gfq7As=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-_luqe1axNJiMgoWRWxIGhA-1; Mon,
 06 Jul 2026 09:12:45 -0400
X-MC-Unique: _luqe1axNJiMgoWRWxIGhA-1
X-Mimecast-MFC-AGG-ID: _luqe1axNJiMgoWRWxIGhA_1783343564
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08A801955DC1; Mon,  6 Jul 2026 13:12:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7607B36535; Mon,  6 Jul 2026 13:12:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 966C421E6920; Mon, 06 Jul 2026 15:12:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~rongyichang <rongyichang@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~rongyichang <rongyichang@xiaomi.com>,
 marcandre.lureau@redhat.com,  eblake@redhat.com
Subject: Re: [PATCH qemu] ui/sdl2: add grab-on-tablet option for absolute
 input devices
In-Reply-To: <178065435170.20548.15372728064868431795-0@git.sr.ht>
 (rongyichang@git.sr.ht's message of "Fri, 05 Jun 2026 17:53:25 +0800")
References: <178065435170.20548.15372728064868431795-0@git.sr.ht>
Date: Mon, 06 Jul 2026 15:12:40 +0200
Message-ID: <877bn8ntx3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I apologize for the lateness of my review.

~rongyichang <rongyichang@git.sr.ht> writes:

> From: rongyichang <rongyichang@xiaomi.com>
>
> When using absolute coordinate input devices (e.g. virtio-tablet-device),
> the SDL display backend implements a "soft grab" where the mouse is
> automatically grabbed when it enters the window interior and ungrabbed
> when it hits the window edge. This edge-ungrab behavior causes problems
> in embedded emulation scenarios:
>
> 1. Mouse escapes the SDL window at edges
> 2. SDL does not deliver BUTTONUP events for the escaped mouse
> 3. The guest gets stuck in a pressed/touch-down state
> 4. First click back into the window is silently dropped
>
> This issue is confirmed as a known SDL limitation (SDL issue #5301).
>
> Add a new -display sdl,grab-on-tablet=on option that makes absolute
> coordinate devices use the same grab behavior as relative (mouse)
> devices: user must click to grab, Ctrl+Alt+G to release, and no
> automatic grab on window enter or edge-based ungrab/regrab.
>
> Signed-off-by: Yichang Rong <rongyichang@xiaomi.com>
> ---
>  qapi/ui.json    |  8 +++++++-
>  qemu-options.hx |  9 +++++++--
>  ui/sdl2.c       | 16 +++++++++++++---
>  3 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index b2c42a7f57..454d9041bf 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1477,10 +1477,16 @@
>  # @grab-mod: Modifier keys that should be pressed together with the
>  #     "G" key to release the mouse grab.
>  #
> +# @grab-on-tablet: When enabled, the mouse grab is required even for
> +#     tablet (absolute) input devices.  This is useful when the guest
> +#     OS uses a tablet device but you still want click-to-grab
> +#     semantics (e.g. NuttX touchscreen emulation).

Missing: (since 11.1)

When would you still want click-to-grab semantics?  The commit message
gives a fairly specific use case.  The doc comment gives only an
example.  Is this good enough for users?

> +#
>  # Since: 7.1
>  ##
>  { 'struct'  : 'DisplaySDL',
> -  'data'    : { '*grab-mod'   : 'HotKeyMod' } }
> +  'data'    : { '*grab-mod'   : 'HotKeyMod',
> +                '*grab-on-tablet' : 'bool' } }
>  
>  ##
>  # @DisplayType:


