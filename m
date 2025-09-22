Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D92CAC5AA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hOx-00070y-L5; Mon, 22 Sep 2025 10:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0hOs-0006vy-AY; Mon, 22 Sep 2025 10:20:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0hOj-0006nq-Qt; Mon, 22 Sep 2025 10:20:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5EE50C014C;
 Mon, 22 Sep 2025 17:20:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:128::1:39] (unknown
 [2a02:6bf:8080:128::1:39])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uJXxak2FvCg0-JX49YaIP; Mon, 22 Sep 2025 17:19:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758550799;
 bh=ZTjKdl4STmXb8aQJ1kiFEBlnB4Q2Te3uwMwSRKMzg/E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MBaRzLnpC896rV89wbM9knfdVDcNGpHUM0+AFmGj2wH7K1nyguBeFePC833KVVlhx
 TNUqjMbDC74qD+YeXHJznMi3fxGYwwTRhzIdUo8nbjdcl8Ji3/Jq4eVym5FGVjYSxE
 i8WnUamvlu2EpjAt6gMjsymS9g5ORHflE5X6pm30=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e9a86cc0-977e-4353-867c-35a1ed361eac@yandex-team.ru>
Date: Mon, 22 Sep 2025 17:19:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/16] treewide: use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-14-berrange@redhat.com>
 <CAFEAcA8cdGC7j1WxsuZ4K0yR2i7t8=Zq0gDq6wczoBSOO_vifw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA8cdGC7j1WxsuZ4K0yR2i7t8=Zq0gDq6wczoBSOO_vifw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22.09.25 16:40, Peter Maydell wrote:
> On Fri, 19 Sept 2025 at 12:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
>> QEMU wrapper qemu_set_blocking().
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> [DB: fix missing closing ) in tap-bsd.c, remove now unused GError var]
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
> 
>> index fe4be6be17..e83e6c6ee9 100644
>> --- a/hw/misc/ivshmem-flat.c
>> +++ b/hw/misc/ivshmem-flat.c
>> @@ -154,7 +154,8 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
>>        * peer.
>>        */
>>       peer->vector[peer->vector_counter].id = peer->vector_counter;
>> -    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
>> +    /* WARNING: qemu_socket_set_nonblock() return code ignored */
>> +    qemu_set_blocking(vector_fd, false, &error_warn);
>>       event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
>>                              vector_fd);
> 
> What is this WARNING comment intended to mean? Is it a
> TODO/bug ?
> 

In my opinion it's a bug (preexisting): we ignore an error. We want to unblock the fd. If we failed, most
probably it means that fd is invalid and further use of it will fail anyway.. Or something
will block on blocking operation which should be non-blocking.

The function doesn't return a value, as well as its caller, and its caller and so on up to
qemu_chr_fe_set_handlers()...

On the other hand, at start of ivshmem_flat_add_vector(), we have

     if (peer->vector_counter >= IVSHMEM_MAX_VECTOR_NUM) {
         trace_ivshmem_flat_add_vector_failure(peer->vector_counter,
                                               vector_fd, peer->id);
         close(vector_fd);

         return;
     }

probably we can handle fd-unblocking failure the same way (and move call to qemu_set_blocking()
to the top, to avoid any further modifications ("adding the vector"?) in case of error.
I can send a patch, it seems safer then blindly continue using the fd.

-- 
Best regards,
Vladimir

