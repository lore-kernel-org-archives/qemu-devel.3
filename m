Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095EACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4Cq-0002pB-Fv; Thu, 21 Aug 2025 08:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up4Ck-0002oa-Nw; Thu, 21 Aug 2025 08:15:45 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1up4Cc-0005OV-9E; Thu, 21 Aug 2025 08:15:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:5cc1:0:640:c8e3:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2DF038060F;
 Thu, 21 Aug 2025 15:15:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b25::1:17] (unknown
 [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OFSLle0FquQ0-FwOQtoxH; Thu, 21 Aug 2025 15:15:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755778525;
 bh=4sGoX1RvD/J79X9e0W9OVAFOyK82ZtZm+brDgGFNcWU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pBrxiKJ1ebbsNuYs4nikxXjvJRoqRC0llj29lfKxeEGZ04grHMx1axpI+zkbXRuVf
 +IIgn0gBPkzqlNrvz+kmF8lzC5FygiFzsor2MAVqVQoTDzMQt+RgQv5UScZhNjbDVj
 8RJI71OqohqLY8wyDto6sOsIiy2HD0ey8aULfiYw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f52081b6-bb8b-4d2c-86f4-1c0b1fa5ac57@yandex-team.ru>
Date: Thu, 21 Aug 2025 15:15:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] migration/socket: keep fds non-block
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-28-vsementsov@yandex-team.ru>
 <aKXN4bykrOFE6_cX@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aKXN4bykrOFE6_cX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 20.08.25 16:30, Peter Xu wrote:
> On Wed, Aug 13, 2025 at 07:48:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> For migration channel keep fds non-blocking property as is.
>> It's needed for future local migration of fds.
> 
> It is pretty risky.  This changes the attribute for all the iochannels that
> migration incoming side uses, including multifd / postcopy / ...

But for now nobody (except CPR-transfer) really pass fds through migration,
and for CPR-transfer it's obviously better to preserve the state by default (see
my answer in previous patch).

So I think, we are in a point, where we can chose the good default, and
document it.

> 
> I left comment in previous patch as a pure question trying to understand
> whether the feature is needed.  If it is, here it might still be good to:
> 
>    - Above the line add a comment explaning why
>    - Only apply it to whatever channel that matters.  In this case, IIUC
>      only the main channel matters
> 

I still think that preserving non-blocking flag "as is" is good default for migration,
please look at my answer in previous patch. However, in this series I may adopt
to any approach.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   migration/socket.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 5ec65b8c03..9f7b6919cf 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -129,6 +129,7 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
>>       }
>>   
>>       qio_channel_set_name(QIO_CHANNEL(cioc), "migration-socket-incoming");
>> +    qio_channel_socket_keep_nonblock(QIO_CHANNEL(cioc));
>>       migration_channel_process_incoming(QIO_CHANNEL(cioc));
>>   }
>>   
>> -- 
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

