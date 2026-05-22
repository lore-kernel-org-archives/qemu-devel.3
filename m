Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC0CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 14:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQQmS-0005Ic-N2; Fri, 22 May 2026 10:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQQmQ-0005IN-SL
 for qemu-devel@nongnu.org; Fri, 22 May 2026 10:23:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQQmO-0006qN-9q
 for qemu-devel@nongnu.org; Fri, 22 May 2026 10:23:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6049D6739F;
 Fri, 22 May 2026 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779459790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzfB3K1RYDEqI7M8Eax5BIJz7dIO8XaAnjkcDleRME=;
 b=vXo+d9qp5/+Tmbs7+EnMU97d8Ua9L5fUsz8ELB1JQTfpkq/5DkR1/i2Rf2BehXvUh4AZ1l
 xYBIUc8K7h6uOFkr/wJLZ3kGmt5Z7gvYS8jcLR0wuvoPxXjsyBVLjWksEWrTaQHTNvED7Q
 VS9wRq9O1n7TyVysvXHNTqQxY5n63bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779459790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzfB3K1RYDEqI7M8Eax5BIJz7dIO8XaAnjkcDleRME=;
 b=AxAikJOcu4HoHZfcwQMZT7veL5P+DnBP1Lmh7TxqDwBjwnCevi1PuzGLMc+PMvnCxG+myi
 nKitm6nEgeMzIyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779459790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzfB3K1RYDEqI7M8Eax5BIJz7dIO8XaAnjkcDleRME=;
 b=vXo+d9qp5/+Tmbs7+EnMU97d8Ua9L5fUsz8ELB1JQTfpkq/5DkR1/i2Rf2BehXvUh4AZ1l
 xYBIUc8K7h6uOFkr/wJLZ3kGmt5Z7gvYS8jcLR0wuvoPxXjsyBVLjWksEWrTaQHTNvED7Q
 VS9wRq9O1n7TyVysvXHNTqQxY5n63bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779459790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzfB3K1RYDEqI7M8Eax5BIJz7dIO8XaAnjkcDleRME=;
 b=AxAikJOcu4HoHZfcwQMZT7veL5P+DnBP1Lmh7TxqDwBjwnCevi1PuzGLMc+PMvnCxG+myi
 nKitm6nEgeMzIyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB018593A8;
 Fri, 22 May 2026 14:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i5ZjLs1mEGrXZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 May 2026 14:23:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, Markus Armbruster
 <armbru@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, "open list:Incompatible changes"
 <devel@lists.libvirt.org>
Subject: Re: [PATCH v7] qapi: net: deprecate vhostforce option
In-Reply-To: <20260522121549.81248-1-vsementsov@yandex-team.ru>
References: <20260522121549.81248-1-vsementsov@yandex-team.ru>
Date: Fri, 22 May 2026 11:22:59 -0300
Message-ID: <87jysv5xrw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> This option for tap and vhost-user netdevs doesn't make sense
> since long ago (10 years!), starting from commits:
>
>  1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>  24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>
> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
> some specific kind of guests (that don't have MSI-X support), you should
> have set vhostforce=on.
>
> Now guest type doesn't matter, all guests are equal for these
> options logic.
>
> For tap the current logic is:
>   vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>   vhost unset : vhostforce counts, enabling vhost
>
> So you may enable vhost for tap several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
>
> - they are all equal.
>
> For vhost-user we simply ignore the vhostforce option at all in the
> code.
>
> Let's finally deprecate the extra options.
>
> Also, fix @vhostforce documentation everywhere to show the real picture,
> and update vhost-user test to not use deprecated option.
>
> While updating command line options, drop "experimental" word from
> "experimental in kernel accelerator". vhost-net is in production for
> years.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/about/deprecated.rst     | 11 +++++++++++
>  qapi/net.json                 | 18 ++++++++++++++----
>  qemu-options.hx               | 13 +++++--------
>  tests/qtest/vhost-user-test.c |  2 +-
>  4 files changed, 31 insertions(+), 13 deletions(-)
>
>
> v7: rebase on master (on top of "[PATCH v16 0/8] virtio-net: live-TAP local migration")
> 01: update version 11.0 -> 11.1, keep r-b
>
> Based-on: <20260522120534.77653-1-vsementsov@yandex-team.ru>
>     "[PATCH v16 0/8] virtio-net: live-TAP local migration"
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 95bf7613295..2c79cdb4eeb 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -384,6 +384,17 @@ Backend ``memory`` (since 9.0)
>  ``memory`` is a deprecated synonym for ``ringbuf``.
>  
>  
> +TAP ``vhostforce`` (since 11.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option is redundant with the ``vhost`` option.
> +If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
> +
> +Vhost-user ``vhostforce`` (since 11.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``vhostforce`` option is a no-op.  Do not use it.
> +
>  CPU device properties
>  '''''''''''''''''''''
>  
> diff --git a/qapi/net.json b/qapi/net.json
> index 82ddbb51cd7..70a749a0e64 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -418,7 +418,8 @@
>  # @vhostfds: file descriptors of multiple already opened vhost net
>  #     devices
>  #
> -# @vhostforce: vhost on for non-MSIX virtio guests
> +# @vhostforce: enable vhost-net network accelerator.  Ignored when
> +#    @vhost is set.
>  #
>  # @queues: number of queues to be created for multiqueue capable tap
>  #
> @@ -432,6 +433,10 @@
>  #     @downscript be explicitly set to nothing (empty string or "no")
>  #     (Since 11.1)
>  #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.  Use @vhost instead.
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -448,7 +453,7 @@
>      '*vhost':      'bool',
>      '*vhostfd':    'str',
>      '*vhostfds':   'str',
> -    '*vhostforce': 'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>      '*queues':     'uint32',
>      '*poll-us':    'uint32',
>      '*incoming-fds': 'bool' } }
> @@ -688,17 +693,22 @@
>  #
>  # @chardev: name of a unix socket chardev
>  #
> -# @vhostforce: vhost on for non-MSIX virtio guests (default: false).
> +# @vhostforce: silently ignored, exists just for backward
> +#     compatibility.
>  #
>  # @queues: number of queues to be created for multiqueue vhost-user
>  #     (default: 1) (Since 2.5)
>  #
> +# Features:
> +#
> +# @deprecated: Member @vhostforce is deprecated.
> +#
>  # Since: 2.1
>  ##
>  { 'struct': 'NetdevVhostUserOptions',
>    'data': {
>      'chardev':        'str',
> -    '*vhostforce':    'bool',
> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>      '*queues':        'int' } }
>  
>  ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 96ae41f787b..f5a1ad6c577 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2969,7 +2969,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>  #else
>      "-netdev tap,id=str[,fd=h][,fds=x:y:...:z][,ifname=name][,script=file][,downscript=dfile]\n"
>      "         [,br=bridge][,helper=helper][,sndbuf=nbytes][,vnet_hdr=on|off][,vhost=on|off]\n"
> -    "         [,vhostfd=h][,vhostfds=x:y:...:z][,vhostforce=on|off][,queues=n]\n"
> +    "         [,vhostfd=h][,vhostfds=x:y:...:z][,queues=n]\n"
>      "         [,poll-us=n]\n"
>      "                configure a host TAP network backend with ID 'str'\n"
>      "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
> @@ -2985,9 +2985,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                default is disabled 'sndbuf=0' to enable flow control set 'sndbuf=1048576')\n"
>      "                use vnet_hdr=off to avoid enabling the IFF_VNET_HDR tap flag\n"
>      "                use vnet_hdr=on to make the lack of IFF_VNET_HDR support an error condition\n"
> -    "                use vhost=on to enable experimental in kernel accelerator\n"
> -    "                    (only has effect for virtio guests which use MSIX)\n"
> -    "                use vhostforce=on to force vhost on for non-MSIX virtio guests\n"
> +    "                use vhost=on to enable in kernel accelerator\n"
>      "                use 'vhostfd=h' to connect to an already opened vhost net device\n"
>      "                use 'vhostfds=x:y:...:z to connect to multiple already opened vhost net devices\n"
>      "                use 'queues=n' to specify the number of queues to be created for multiqueue TAP\n"
> @@ -3078,7 +3076,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                use 'start-queue=m' to specify the first queue that should be used\n"
>  #endif
>  #ifdef CONFIG_POSIX
> -    "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
> +    "-netdev vhost-user,id=str,chardev=dev\n"
>      "                configure a vhost-user network, backed by a chardev 'dev'\n"
>  #endif
>  #ifdef __linux__
> @@ -3978,12 +3976,11 @@ SRST
>      for insertion into the socket map.  The combination of 'map-path' and
>      'sock-fds' together is not supported.
>  
> -``-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]``
> +``-netdev vhost-user,chardev=id[,queues=n]``
>      Establish a vhost-user netdev, backed by a chardev id. The chardev
>      should be a unix domain socket backed one. The vhost-user uses a
>      specifically defined protocol to pass vhost ioctl replacement
> -    messages to an application on the other end of the socket. On
> -    non-MSIX guests, the feature can be forced with vhostforce. Use
> +    messages to an application on the other end of the socket. Use
>      'queues=n' to specify the number of queues to be created for
>      multiqueue vhost-user.
>  
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index c8b5f8ff714..ebeebde2281 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -46,7 +46,7 @@
>  #define QEMU_CMD_SHM    " -m %d -object memory-backend-shm,id=mem,size=%dM," \
>                          " -numa node,memdev=mem"
>  #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
> -#define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce=on"
> +#define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s"
>  
>  #define HUGETLBFS_MAGIC       0x958458f6

Acked-by: Fabiano Rosas <farosas@suse.de>

