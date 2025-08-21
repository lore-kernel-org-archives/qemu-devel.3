Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B92CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up46C-0000Oe-K3; Thu, 21 Aug 2025 08:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up46A-0000MV-Q9; Thu, 21 Aug 2025 08:08:54 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up465-00048d-IH; Thu, 21 Aug 2025 08:08:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3693D883D2;
 Thu, 21 Aug 2025 15:08:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id e8SYH11GhCg0-BbwirLgS; Thu, 21 Aug 2025 15:08:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755778121;
 bh=lv5LYBcPRZfhq4mbh8UOvRuzzBWKTR/P5JLdzb4N2nw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZwCE0Vy9X+i3mtzpIPI+dGB6TyYbvw5cu9lzP6FuFVPt7/39dkK0Ot/HWwYuvrS3H
 tQHvyIn3T/iXpMPOU/l/H1w0YkxJ1uAl8YWeqOd6X+x34FnhezO8Rpdd5fWVazgZea
 mv6D64SUugj4xlCza3rN/AmcHD/O6XXJvPRZl6fo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1f6e92f1-8ec8-44b2-9047-afe38856e607@yandex-team.ru>
Date: Thu, 21 Aug 2025 15:08:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXPsvfldHD1RYhS@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aKXPsvfldHD1RYhS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 20.08.25 16:37, Daniel P. Berrangé wrote:
> On Wed, Aug 13, 2025 at 07:48:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Add a possibility to keep socket non-block status when passing
>> through qio channel. We need this to support migration of open
>> fds through migration channel.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   include/io/channel-socket.h |  3 +++
>>   io/channel-socket.c         | 16 ++++++++++++----
>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>> index a88cf8b3a9..0a4327d745 100644
>> --- a/include/io/channel-socket.h
>> +++ b/include/io/channel-socket.h
>> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>>       socklen_t remoteAddrLen;
>>       ssize_t zero_copy_queued;
>>       ssize_t zero_copy_sent;
>> +    bool keep_nonblock;
>>   };
>>   
>>   
>> @@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
>>                                          size_t size,
>>                                          Error **errp);
>>   
>> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
>> +
>>   #endif /* QIO_CHANNEL_SOCKET_H */
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 3b7ca924ff..cd93d7f180 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
>>   }
>>   
>>   
>> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
>> +{
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>> +    sioc->keep_nonblock = true;
>> +}
>> +
>> +
>>   #ifndef WIN32
>>   static void qio_channel_socket_copy_fds(struct msghdr *msg,
>> -                                        int **fds, size_t *nfds)
>> +                                        int **fds, size_t *nfds, bool set_block)
>>   {
>>       struct cmsghdr *cmsg;
>>   
>> @@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>>                   continue;
>>               }
>>   
>> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>> -            qemu_socket_set_block(fd);
>> +            if (set_block) {
>> +                qemu_socket_set_block(fd);
>> +            }
>>   
>>   #ifndef MSG_CMSG_CLOEXEC
>>               qemu_set_cloexec(fd);
>> @@ -556,7 +564,7 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>>       }
>>   
>>       if (fds && nfds) {
>> -        qio_channel_socket_copy_fds(&msg, fds, nfds);
>> +        qio_channel_socket_copy_fds(&msg, fds, nfds, !sioc->keep_nonblock);
>>       }
>>   
>>       return ret;
> 
> If this is needed, then it should be done by defining another flag
> constant to be passed to qio_channel_read*, not via a new API
> 
>   QIO_CHANNEL_READ_FLAG_FD_PRESERVE_NONBLOCKING
> 


Ok, thanks, will do.


-- 
Best regards,
Vladimir

