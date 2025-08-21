Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C859ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up45p-0008G7-Bg; Thu, 21 Aug 2025 08:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up45c-0008BS-Jt; Thu, 21 Aug 2025 08:08:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up45T-00046G-Tm; Thu, 21 Aug 2025 08:08:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CB761C018D;
 Thu, 21 Aug 2025 15:07:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id v7SJr31GsGk0-AHAwoxBJ; Thu, 21 Aug 2025 15:07:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755778078;
 bh=Vv4jjPQ9IhBWYQ2oHcIsefiA2GShovVU2osacxptJ2M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sZLsFy7gR843jQ74GU9oWbYfnO60rrinrogplC0gMjXl75zoB10VsG86o4LW7RM8m
 F/Emyj8Z8mwOOLxikofonhKWYonj0zk5rua2R1wi2as5g11QWD9QtVQ1qyD7NsDSvQ
 FR8WFmuRkTB/D4tV4lEiKHj2+N3LMxnPzVWBmKYw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e3c67e47-8a5e-459f-8d76-a00032b7e013@yandex-team.ru>
Date: Thu, 21 Aug 2025 15:07:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXNLfKWzHKUhGaz@x1.local> <aKXRGiDQlyPyhNsh@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aKXRGiDQlyPyhNsh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 20.08.25 16:43, Daniel P. Berrangé wrote:
> On Wed, Aug 20, 2025 at 09:27:09AM -0400, Peter Xu wrote:
>> On Wed, Aug 13, 2025 at 07:48:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Add a possibility to keep socket non-block status when passing
>>> through qio channel. We need this to support migration of open
>>> fds through migration channel.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   include/io/channel-socket.h |  3 +++
>>>   io/channel-socket.c         | 16 ++++++++++++----
>>>   2 files changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>> index a88cf8b3a9..0a4327d745 100644
>>> --- a/include/io/channel-socket.h
>>> +++ b/include/io/channel-socket.h
>>> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>>>       socklen_t remoteAddrLen;
>>>       ssize_t zero_copy_queued;
>>>       ssize_t zero_copy_sent;
>>> +    bool keep_nonblock;
>>>   };
>>>   
>>>   
>>> @@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
>>>                                          size_t size,
>>>                                          Error **errp);
>>>   
>>> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
>>> +
>>>   #endif /* QIO_CHANNEL_SOCKET_H */
>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>> index 3b7ca924ff..cd93d7f180 100644
>>> --- a/io/channel-socket.c
>>> +++ b/io/channel-socket.c
>>> @@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
>>>   }
>>>   
>>>   
>>> +void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
>>> +{
>>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>> +    sioc->keep_nonblock = true;
>>> +}
>>> +
>>> +
>>>   #ifndef WIN32
>>>   static void qio_channel_socket_copy_fds(struct msghdr *msg,
>>> -                                        int **fds, size_t *nfds)
>>> +                                        int **fds, size_t *nfds, bool set_block)
>>>   {
>>>       struct cmsghdr *cmsg;
>>>   
>>> @@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>>>                   continue;
>>>               }
>>>   
>>> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>>> -            qemu_socket_set_block(fd);
>>> +            if (set_block) {
>>> +                qemu_socket_set_block(fd);
>>> +            }
>>
>> "keep_nonblock" as a feature in iochannel is slightly hard to digest.  It
>> can also be read as "keep the fd to be always nonblocking".
>>
>> Is this feature required, or can this also be done in a get() or
>> post_load() on the other side to set nonblock to whatever it should be
>> (that dest QEMU should be aware of)?
> 
> Either we preserve state of the flag when receiving the FD,
> or every QEMU backend that we're receiving FDs on behalf of
> needs to reset the flag when migration passes over the FD.
> 
> The latter might actually be a more robust scheme. If we're
> migrating across QEMU versions, there is not a strict
> guarantee that the new QEMU version's backend will want the
> O_NONBLOCK flag in the same state as the old QEMU version.
> The code might have been re-written to work in a different
> way than previously.
> 


What I dislike in the way, when we reset to blocking always, and set non-blocking again where needed:

1. Extra fcntl calls for nothing (I think actually, in most cases, for fds passed through migration stream(s) we'll want to keep fd as is)

2. When we reset to blocking on target, it's visible on source and may break things.

In these series it's probably doesn't really matter, as at the time when we get the descriptor on target, it should not be used anymore on source.

But for example, in CPR-transfer, where descriptors are passed in the preliminary stage, and source is running and use the descriptors, we shouldn't change the non-blocking status of fd on target. Probably, CPR-transfer for now only works with fds which are blpcking, so we don't have a problem.

So, I think, that better default is preserve state of the flag for fds passed through migration stream. And backends may modify it if needed (I think, in most cases - they will not need).


-- 
Best regards,
Vladimir

