Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9243BCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 10:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9LNv-00013u-P4; Thu, 16 Oct 2025 06:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9LNs-00012r-JR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9LNn-0002aK-8x
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760611131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N874HbHUUU7TnJyKEhqUOv79wOFms/6Fki3m6zA07mY=;
 b=A7aKgCeuKrWUQR/KbTt8fSBYFvpmZA06xMvM1+DCXUj2EGmpmaszMCUjhFvSBKwjBSTakU
 sccrViSnM0ZZ24vdKuSPKPBvWoaXGl3X/7WclqHKrXzjm5vEjgZPsWfG1JmHrr9GkWMWwG
 /lXH5gx+yzT5gHqjn9TjI8Wb+9B8H14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-dxUhf6ZLNsC8qucGANvAog-1; Thu,
 16 Oct 2025 06:38:48 -0400
X-MC-Unique: dxUhf6ZLNsC8qucGANvAog-1
X-Mimecast-MFC-AGG-ID: dxUhf6ZLNsC8qucGANvAog_1760611127
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA851800637; Thu, 16 Oct 2025 10:38:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B98A9300019F; Thu, 16 Oct 2025 10:38:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E9E021E6A27; Thu, 16 Oct 2025 12:38:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  devel@lists.libvirt.org,  eblake@redhat.com,
 farosas@suse.de,  lvivier@redhat.com,  pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] qapi: net: deprecate vhostforce option
In-Reply-To: <239dc7b4-de5a-4e47-912d-543347d1f90b@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 16 Oct 2025 12:03:33 +0300")
References: <20251015143941.1109499-1-vsementsov@yandex-team.ru>
 <87bjm7teou.fsf@pond.sub.org>
 <239dc7b4-de5a-4e47-912d-543347d1f90b@yandex-team.ru>
Date: Thu, 16 Oct 2025 12:38:43 +0200
Message-ID: <87frbjrv0s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 16.10.25 11:48, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> This option for tap and vhost-user netdevs doesn't make sense
>>> since long ago (10 years!), starting from commits:
>>>
>>>   1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>>>   24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>>>
>>> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
>>> some specific kind of guests (that don't have MSI-X support), you should
>>> have set vhostforce=on.
>>>
>>> Now guest type doesn't matter, all guests are equal for these
>>> options logic.
>>>
>>> For tap the current logic is:
>>>    vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>>>    vhost unset : vhostforce counts, enabling vhost
>>>
>>> So you may enable vhost for tap several ways:
>>> - vhost=on
>>> - vhostforce=on
>>> - vhost=on + vhostforce=on
>>> - and even vhost=on + vhostforce=off
>>>
>>> - they are all equal.
>>>
>>> For vhost-user we simply ignore the vhostforce option at all in the
>>> code.
>>>
>>> Let's finally deprecate the extra options.
>>>
>>> Also, fix @vhostforce documentation everywhere to show the real picture,
>>> and update vhost-user test to not use deprecated option.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 0223ceffeb..35a70096e8 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -2882,7 +2882,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>  #else
>>>      "-netdev tap,id=str[,fd=h][,fds=x:y:...:z][,ifname=name][,script=file][,downscript=dfile]\n"
>>>      "         [,br=bridge][,helper=helper][,sndbuf=nbytes][,vnet_hdr=on|off][,vhost=on|off]\n"
>>> -    "         [,vhostfd=h][,vhostfds=x:y:...:z][,vhostforce=on|off][,queues=n]\n"
>>> +    "         [,vhostfd=h][,vhostfds=x:y:...:z][,queues=n]\n"
>>>      "         [,poll-us=n]\n"
>>>      "                configure a host TAP network backend with ID 'str'\n"
>>>      "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
>>> @@ -2898,9 +2898,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>>      "                default is disabled 'sndbuf=0' to enable flow control set 'sndbuf=1048576')\n"
>>>      "                use vnet_hdr=off to avoid enabling the IFF_VNET_HDR tap flag\n"
>>>      "                use vnet_hdr=on to make the lack of IFF_VNET_HDR support an error condition\n"
>>> -    "                use vhost=on to enable experimental in kernel accelerator\n"
>>> -    "                    (only has effect for virtio guests which use MSIX)\n"
>>> -    "                use vhostforce=on to force vhost on for non-MSIX virtio guests\n"
>>> +    "                use vhost=on to enable in kernel accelerator\n"
>> 
>> So the kernel's accelerator is no longer experimental?
>
> Reading this, I heard the first time that vhost-net is experimental.
> It's about 15 years old, and used in production. I think "experimental"
> is inappropriate word here)

Just double-checking :)

The text you adjust is from 2010 (commit 82b0d80ef6a).  I guess the
accelerator was experimental back then.

Mention the correction in the commit message?

[...]


