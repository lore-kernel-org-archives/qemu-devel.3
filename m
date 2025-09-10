Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64859CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 10:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwIHw-0003ny-26; Wed, 10 Sep 2025 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwIHs-0003nT-LP; Wed, 10 Sep 2025 06:42:53 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwIHk-0007by-Pu; Wed, 10 Sep 2025 06:42:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5937E808C8;
 Wed, 10 Sep 2025 13:42:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id egH2DB6FleA0-bJhnKd3w; Wed, 10 Sep 2025 13:42:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757500960;
 bh=4++AjFLcJo5It728uKULo6xpk6lRXR5yQYcvbU0jfWs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dMs+fraDkDN6AT4HyG6u1HCqe7gXg4suos4Z85jqH0q4+KSxj8scE9ampz6pEMfMI
 dY4RRiIMiyP3DREuBGL/xB2RZeMY0rZ7dMC4HSCqRROOU9NFVoM/n+yQ3aZFvkIrrK
 p2nozJDjTJO1hpbppRt/rgneSBUAUn0eJu/unk7k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c601a8ef-c721-4e93-845a-cdb885378f7f@yandex-team.ru>
Date: Wed, 10 Sep 2025 13:42:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] oslib-posix: add qemu_fds_set_blocking() helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-9-vsementsov@yandex-team.ru>
 <aMFKUcHVxB9q3of6@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMFKUcHVxB9q3of6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10.09.25 12:52, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 12:44:08PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> And use it in io/channel-socket.c. This simplifies the following
>> commit, which will move this functionality from io/channel-socket.c
>> to the callers.
> 
> Looking at how many callers will still want the current
> functionality, I'm inclined to add a flag for QIOChannel
> 
>    QIO_CHANNEL_READ_FLAG_PRESERVE_BLOCKING
> 
> which migration can pass to qio_channel_readv_full and
> thus avoid adding this method and duplicated calls to
> it in (almost) every caller.
> 

Yes, I thought about this too, when preparing the series.

I'll make a patch, and make the fds-set-blocking refactoring series to be the separate one.

>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   include/qemu/osdep.h |  7 +++++++
>>   io/channel-socket.c  | 24 +++++++++++++-----------
>>   util/oslib-posix.c   | 12 ++++++++++++
>>   3 files changed, 32 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 1b38cb7e45..dde98d588c 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -689,6 +689,13 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>>   void qemu_set_cloexec(int fd);
>>   bool qemu_set_blocking(int fd, bool block, Error **errp);
>>   
>> +/*
>> + * qemu_fds_set_blockinging:
>> + * Call qemu_socket_set_block() on several fds.
>> + * When @nfds = 0, does nothing, @fds is not touched.
>> + */
>> +bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp);
>> +
>>   /* Return a dynamically allocated directory path that is appropriate for storing
>>    * local state.
>>    *
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 4f7e86f72f..96098b5bcc 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -472,8 +472,11 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>>       *fds = NULL;
>>   
>>       for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
>> -        int fd_size, i;
>> +        int fd_size;
>>           int gotfds;
>> +#ifndef MSG_CMSG_CLOEXEC
>> +        int i;
>> +#endif
>>   
>>           if (cmsg->cmsg_len < CMSG_LEN(sizeof(int)) ||
>>               cmsg->cmsg_level != SOL_SOCKET ||
>> @@ -491,20 +494,19 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
>>           *fds = g_renew(int, *fds, *nfds + gotfds);
>>           memcpy(*fds + *nfds, CMSG_DATA(cmsg), fd_size);
>>   
>> +        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>> +        /* TODO: don't crash on error, just handle it! */
>> +        qemu_fds_set_blockinging(*fds + *nfds, gotfds, true, &error_abort);
>> +
>> +#ifndef MSG_CMSG_CLOEXEC
>>           for (i = 0; i < gotfds; i++) {
>>               int fd = (*fds)[*nfds + i];
>> -            if (fd < 0) {
>> -                continue;
>> +            if (fd >= 0) {
>> +                qemu_set_cloexec(fd);
>>               }
>> -
>> -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>> -            /* TODO: don't crash on error, just handle it! */
>> -            qemu_set_blocking(fd, true, &error_abort);
>> -
>> -#ifndef MSG_CMSG_CLOEXEC
>> -            qemu_set_cloexec(fd);
>> -#endif
>>           }
>> +#endif
>> +
>>           *nfds += gotfds;
>>       }
>>   }
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 8891d82db0..8589ff21ec 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -262,6 +262,18 @@ bool qemu_set_blocking(int fd, bool block, Error **errp)
>>       return true;
>>   }
>>   
>> +bool qemu_fds_set_blockinging(int *fds, int nfds, bool block, Error **errp)
>> +{
>> +    int i;
>> +    for (i = 0; i < nfds; i++) {
>> +        if (fds[i] >= 0 && !qemu_set_blocking(fds[i], block, errp)) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   int socket_set_fast_reuse(int fd)
>>   {
>>       int val = 1, ret;
>> -- 
>> 2.48.1
>>
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir

