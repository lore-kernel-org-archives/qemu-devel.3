Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B37CAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvt6Q-0007aG-Kq; Tue, 09 Sep 2025 03:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt6I-0007WN-NS; Tue, 09 Sep 2025 03:49:15 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt6F-0004iI-08; Tue, 09 Sep 2025 03:49:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 360E680453;
 Tue, 09 Sep 2025 10:49:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0nDVIb6GwuQ0-NDtQv1Bk; Tue, 09 Sep 2025 10:49:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757404141;
 bh=07aKuwVXoDyI279zLk5825bYoQxa7gxLvN4f5LK59FI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tTM00iZRIQiRcICqsLcfB90ej4bHrKuDTAIPfdoE+F5ukYJG2LrsjYSQIbEKQsmsB
 X02S3G2H+8lRbtDtvQf3D5eA/umUHPF8uaeYSozt0wnzSg/QlfW96YpVurn5YEStrC
 TYPOGvMQ9BYXXxWtJqmAUlnmVT9oUoDxieekPeWs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <55b44b25-5b6f-44e8-a549-23b54eb28ec8@yandex-team.ru>
Date: Tue, 9 Sep 2025 10:49:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] char-socket: rework tcp_chr_recv()
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-3-vsementsov@yandex-team.ru>
 <aL9QT9T2QTCA_tks@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL9QT9T2QTCA_tks@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 09.09.25 00:53, Peter Xu wrote:
> On Wed, Sep 03, 2025 at 12:44:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> First, qio_channel_readv_full() already guarantees BLOCKING and
>> CLOEXEC states for incoming descriptors, no reason call extra
>> ioctls.
>>
>> Second, current implementation calls _set_block() and _set_cloexec()
>> again on old descriptors on failure path - we fix this too.
>>
>> Finally, handling errors exactly after qio_channel_readv_full() call
>> looks more readable.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-socket.c | 37 +++++++++++++------------------------
>>   1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 1e8313915b..5b9b19ba8b 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -293,6 +293,18 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>>                                        0, &err);
>>       }
>>   
>> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> +        errno = EAGAIN;
>> +        return -1;
>> +    } else if (ret == -1) {
>> +        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
>> +        error_free(err);
>> +        errno = EIO;
>> +        return -1;
>> +    }
>> +
>> +    assert(ret >= 0);
>> +
>>       if (msgfds_num) {
>>           /* close and clean read_msgfds */
>>           for (i = 0; i < s->read_msgfds_num; i++) {
>> @@ -307,30 +319,7 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>>           s->read_msgfds_num = msgfds_num;
>>       }
>>   
>> -    for (i = 0; i < s->read_msgfds_num; i++) {
>> -        int fd = s->read_msgfds[i];
>> -        if (fd < 0) {
>> -            continue;
>> -        }
>> -
>> -        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>> -        qemu_socket_set_block(fd);
>> -
>> -#ifndef MSG_CMSG_CLOEXEC
>> -        qemu_set_cloexec(fd);
>> -#endif
>> -    }
>> -
>> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> -        errno = EAGAIN;
>> -        ret = -1;
>> -    } else if (ret == -1) {
>> -        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
>> -        error_free(err);
>> -        errno = EIO;
>> -    } else if (ret == 0) {
>> -        trace_chr_socket_recv_eof(chr, chr->label);
>> -    }
>> +    trace_chr_socket_recv_eof(chr, chr->label);
> 
> This tracepoint may still need to be put into a ret==0 check.
> 
> Looks reasonable other than that..
> 

Oh, right. Will fix.

>>   
>>       return ret;
>>   }
>> -- 
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

