Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C298C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtmB-0003ng-8L; Fri, 02 Aug 2024 11:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZtlr-0002WI-JH; Fri, 02 Aug 2024 11:00:45 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZtlo-0000qj-BR; Fri, 02 Aug 2024 11:00:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E5CE960C3E;
 Fri,  2 Aug 2024 18:00:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id W0aU0O0g1mI0-Z5qqMZc4; Fri, 02 Aug 2024 18:00:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722610833;
 bh=m4E7kAHh9RbOu9ZiZlLmYuoRjWBUkXKIkNEfWm6z+GU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=M4C8V4PYk6HhKJ1KHs0WyhIgbbyEBJocpKAPmVUM8XEgbu4z5AW3hFPsGF+mzOIYH
 sivgt4tJj1WhLgePi8bvDGzFsENtJzmwwKPB1HoPAykAjPczF944RW6eFPgClJxXSQ
 Xw6bXvy/6iwcfJG1cToG5JtXI88C5QDmpEsID6Jk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b91052fc-0286-4161-8a3b-10bd45c3485a@yandex-team.ru>
Date: Fri, 2 Aug 2024 18:00:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] nbd: CVE-XXX: Use cookie to track generation of
 nbd-server
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
References: <20240802014824.1906798-5-eblake@redhat.com>
 <20240802014824.1906798-6-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240802014824.1906798-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 02.08.24 04:32, Eric Blake wrote:
> As part of the QMP command nbd-server-start, the blockdev code was
> creating a single global nbd_server object, and telling the qio code
> to accept one or more client connections to the exposed listener
> socket.  But even though we tear down the listener socket during a
> subsequent QMP nbd-server-stop, the qio code has handed off to a
> coroutine that may be executing asynchronously with the server
> shutdown, such that a client that connects to the socket before
> nbd-server-stop but delays disconnect or completion of the NBD
> handshake until after the followup QMP command can result in the
> nbd_blockdev_client_closed() callback running after nbd_server has
> already been torn down, causing a SEGV.  Worse, if a second nbd_server
> object is created (possibly on a different socket address), a late
> client resolution from the first server can subtly interfere with the
> second server.  This can be abused by a malicious client that does not
> know TLS secrets to cause qemu to SEGV after a legitimate client has
> concluded storage migration to a destination qemu, which can be turned
> into a denial of service attack even when qemu is set up to require
> only TLS clients.
> 
> For environments without this patch, the CVE can be mitigated by
> ensuring (such as via a firewall) that only trusted clients can
> connect to an NBD server; using frameworks like libvirt that ensure
> that nbd-server-stop is not executed while any trusted clients are
> still connected will only help if there is also no possibility for an
> untrusted client to open a connection but then stall on the NBD
> handshake.
> 
> Fix this by passing a cookie through to each client connection
> (whether or not that client actually knows the TLS details to
> successfully negotiate); then increment the cookie every time a server
> is torn down so that we can recognize any late client actions
> lingering from an old server.
> 
> This patch does not address the fact that client sockets can be left
> open indefinitely after the server is torn down (possibly creating a
> resource leak, if a malicious client intentionally leaves lots of open
> sockets paused partway through NBD negotiation); the next patch will
> add some code to forcefully close any lingering clients as soon as
> possible when the server is torn down.
> 
> Reported-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[..]

> -static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
> +static void nbd_blockdev_client_closed(NBDClient *client, uint32_t cookie,
> +                                       bool ignored)
>   {
>       nbd_client_put(client);
> -    assert(nbd_server->connections > 0);
> -    nbd_server->connections--;
> -    nbd_update_server_watch(nbd_server);
> +    /* Ignore any (late) connection made under a previous server */
> +    if (cookie == nbd_cookie) {

creating a getter nbd_client_get_cookie(client), and use it instead of passing together with client, will simplify the patch a lot. [*]

Hmm.. don't we need some atomic accessors for nbd_cookie? and for nbs_server->connections.. The function is called from client, which live in coroutine and maybe in another thread? At least client code do atomic accesses of client->refcount..

> +        assert(nbd_server->connections > 0);
> +        nbd_server->connections--;
> +        nbd_update_server_watch(nbd_server);
> +    }
>   }
> 

[..]

> @@ -1621,7 +1622,7 @@ static void client_close(NBDClient *client, bool negotiated)
> 
>       /* Also tell the client, so that they release their reference.  */
>       if (client->close_fn) {
> -        client->close_fn(client, negotiated);
> +        client->close_fn(client, client->close_cookie, negotiated);

[*] passing client->close_cokkie together with client itself looks like we lack a getter for .close_cookie

>       }
>   }
> 

[..]


Hmm, instead of cookies and additional NBDConn objects in the next patch, could we simply have a list of connected NBDClient objects in NBDServer and link to NBDServer in NBDClient? (Ok we actually don't have NBDServer, but NBDServerData in qemu, and several global variables in qemu-nbd, so some refactoring is needed, to put common state to NBDServer, and add clients list to it)

This way, in nbd_server_free we'll just call client_close() in a loop. And in client_close we'll have nbd_server_client_detach(client->server, client), instead of client->close_fn(...). And server is freed only after all clients are closed. And client never try to detach from another server.

This way, we also may implement several NBD servers working simultaneously if we want.

-- 
Best regards,
Vladimir


