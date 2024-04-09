Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29B5C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru50f-0003wu-Nx; Tue, 09 Apr 2024 02:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru50K-0003oX-FN; Tue, 09 Apr 2024 02:30:49 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ru50H-00068T-3s; Tue, 09 Apr 2024 02:30:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:14ae:0:640:157e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6F712608F3;
 Tue,  9 Apr 2024 09:30:40 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b66e::1:3c] (unknown
 [2a02:6b8:b081:b66e::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dUSjpO1i2Sw0-6bSY8LRZ; Tue, 09 Apr 2024 09:30:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712644239;
 bh=r4evT4I1HLDZrYHL56S/UzK0D99bX+H2uOT/aenLSrU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MmSXl7ZouuHrbR93MO7y0/WmSYxHHC89EMzY//2kLTp1oB7rGVacnz3g9ogESaZzC
 vUtkIXJcC86owdcCD33Z2zXVNxElpK2XFAYmRGecTvvhye77lkv6DXU7wZjZ0o90bD
 NQ8WzI25nDST5QMlu4bsJnZRpC4O+naTurkp7jSU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f00ac999-fb9b-4429-b5b9-be27153f77a5@yandex-team.ru>
Date: Tue, 9 Apr 2024 09:30:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nbd/server: Mark negotiation functions as
 coroutine_fn
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240408160214.1200629-4-eblake@redhat.com>
 <20240408160214.1200629-6-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240408160214.1200629-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 08.04.24 19:00, Eric Blake wrote:
> nbd_negotiate() is already marked coroutine_fn.  And given the fix in
> the previous patch to have nbd_negotiate_handle_starttls not create
> and wait on a g_main_loop (as that would violate coroutine
> constraints), it is worth marking the rest of the related static
> functions reachable only during option negotiation as also being
> coroutine_fn.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 102 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 59 insertions(+), 43 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 98ae0e16326..1857fba51c1 100644

[..]

>   {
>       int rc;
>       g_autofree char *name = NULL;
> @@ -755,7 +764,8 @@ struct NBDTLSServerHandshakeData {
>       Coroutine *co;
>   };
> 
> -static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> +static coroutine_fn void

This is not, that's a callback for tls handshake, which is not coroutine context as I understand.
without this hunk:


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


> +nbd_server_tls_handshake(QIOTask *task, void *opaque)
>   {
>       struct NBDTLSServerHandshakeData *data = opaque;
> 
> @@ -768,8 +778,8 @@ static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> 

[..]

-- 
Best regards,
Vladimir


