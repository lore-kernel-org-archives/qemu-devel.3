Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988CC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 12:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpp3r-00007r-FL; Thu, 28 Mar 2024 08:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpp3V-0008Vz-JO
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpp3S-00016R-EO
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711629625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aOrjgk8gwqxbTbPOZmyM+QDSdSLbPDZfce1uCJaJbeg=;
 b=eGD2/NmFcgs2qwGwV4/RFXmvfBaTbw3BwrnqIheuDrH6QuIQWHU/PPA+saT9mBLZDoib1n
 8N3Z2bJ8e5MhHUX3fknVlGDUrKC69pslN2TEZeLXBsMQK+2/WZ7Rn5YqLN8Lmgij4nxVeN
 szujAc2pGOIjE3n8px37hxYMwRCX0JA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-1lToV2qQMCiZ7ZxvpZmviA-1; Thu, 28 Mar 2024 08:40:23 -0400
X-MC-Unique: 1lToV2qQMCiZ7ZxvpZmviA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F2EA84AEC9;
 Thu, 28 Mar 2024 12:40:23 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5F81C060D0;
 Thu, 28 Mar 2024 12:40:20 +0000 (UTC)
Date: Thu, 28 Mar 2024 07:40:14 -0500
From: Eric Blake <eblake@redhat.com>
To: zhuyangyang <zhuyangyang14@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 luolongmin@huawei.com, suxiaodong1@huawei.com, chenxiaoyu48@huawei.com, 
 wangyan122@huawei.com, yebiaoxiang@huawei.com
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Message-ID: <dv63ec4btdz32schwrwjebce4m7xbu5tt6fncebi5hzxnmctdy@xflzv6tolvrm>
References: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang via wrote:
> If g_main_loop_run()/aio_poll() is called in the coroutine context,
> the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> may be disordered.
> 
> When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> some listened events is completed. Therefore, the completion callback
> function is dispatched.
> 
> If this callback function needs to invoke aio_co_enter(), it will only
> wake up the coroutine (because we are already in coroutine context),
> which may cause that the data on this listening event_fd/socket_fd
> is not read/cleared. When the next poll () exits, it will be woken up again
> and inserted into the wakeup queue again.
> 
> For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
> in the coroutine, and repeatedly wake up the io_read event on a socket.
> The call stack is as follows:
> 
> aio_co_enter()
> aio_co_wake()
> qio_channel_restart_read()
> aio_dispatch_handler()
> aio_dispatch_handlers()
> aio_dispatch()
> aio_ctx_dispatch()
> g_main_context_dispatch()
> g_main_loop_run()
> nbd_negotiate_handle_starttls()
> nbd_negotiate_options()
> nbd_negotiate()
> nbd_co_client_start()
> coroutine_trampoline()

zhuyangyang, do you have a reliable reproduction setup for how you
were able to trigger this?  Obviously, it only happens when TLS is
enabled (we aren't creating a g_main_loop_run for any other NBD
command), and only when the server is first starting to serve a
client; is this a case where you were hammering a long-running qemu
process running an NBD server with multiple clients trying to
reconnect to the server all near the same time?

If we can come up with a reliable formula for reproducing the
corrupted coroutine list, it would make a great iotest addition
alongside the existing qemu-iotests 233 for ensuring that NBD TLS
traffic is handled correctly in both server and client.

> 
> Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>

Side note: this appears to be your first qemu contribution (based on
'git shortlog --author zhuyangyang').  While I am not in a position to
presume how you would like your name Anglicized, I will point out that
the prevailing style is to separate given name from family name (just
because your username at work has no spaces does not mean that your
S-o-b has to follow suit).  It is also permissible to list your name
in native characters alongside or in place of the Anglicized version;
for example, 'git log --author="Stefano Dong"' shows this technique.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


