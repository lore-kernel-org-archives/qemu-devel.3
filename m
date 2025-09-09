Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167BCAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvt8Q-0001D8-99; Tue, 09 Sep 2025 03:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt8M-0001Bj-Ei; Tue, 09 Sep 2025 03:51:22 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt8A-000594-Dl; Tue, 09 Sep 2025 03:51:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6D96A8066F;
 Tue, 09 Sep 2025 10:51:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4pDiKb6GuGk0-HMv6wFof; Tue, 09 Sep 2025 10:51:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757404264;
 bh=WDkgfhXw6p8dBd6w9PYgemsE5KhRjM8le73mcVMol6c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SX9xBQ2/J5TTbCoMxEuk7XTSSeRlM0uGliLxv8klvOuJFvniYHXx6xlGR1VqR4CLu
 rDz2t4spODnOIH6Z1iQakpj3SKAtLtIG/nW/ZG4nqhWi34KBcVn3hlzdSSVutOGoXd
 96utFcTkP9nPPnqH/7lWj5junGJ4/8KFmc+jwfH8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b4d801db-7999-4298-a82a-9a14afe0d4f8@yandex-team.ru>
Date: Tue, 9 Sep 2025 10:51:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] util: add qemu_set_blocking() function
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-4-vsementsov@yandex-team.ru>
 <aL9SZr8uU4lp0o41@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL9SZr8uU4lp0o41@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 09.09.25 01:02, Peter Xu wrote:
> On Wed, Sep 03, 2025 at 12:44:03PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> In generic code we have qio_channel_set_blocking(), which takes
>> bool parameter, and qemu_file_set_blocking(), which as well takes
>> bool parameter.
>>
>> At lower fd-layer we have a mess of functions:
>>
>> - enough direct calls to g_unix_set_fd_nonblocking()
>> and several wrappers without bool parameter:
>>
>> - qemu_scoket_set_nonblock(), which asserts success for posix (still,
>>    in most cases we can handle the error in better way) and ignores
>>    error for win32 realization
>>
>> - qemu_socket_try_set_nonblock(), the best one
>>
>> - qemu_socket_set_block(), which simply ignores an error, the worst
>>    case
>>
>> And all three lack errp argument, so we have to handle it after the
>> call.
>>
>> So let's introduce a new socket-layer wrapper, and use it consistently
>> in following commits.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   include/qemu/osdep.h |  1 +
>>   util/oslib-posix.c   | 12 ++++++++++++
>>   util/oslib-win32.c   | 18 ++++++++++++++++++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index be3460b32f..1b38cb7e45 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -687,6 +687,7 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>>       G_GNUC_WARN_UNUSED_RESULT;
>>   
>>   void qemu_set_cloexec(int fd);
>> +bool qemu_set_blocking(int fd, bool block, Error **errp);
>>   
>>   /* Return a dynamically allocated directory path that is appropriate for storing
>>    * local state.
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 4ff577e5de..e473938195 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -250,6 +250,18 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>>   #endif
>>   }
>>   
>> +bool qemu_set_blocking(int fd, bool block, Error **errp)
>> +{
>> +    if (!g_unix_set_fd_nonblocking(fd, !block, NULL)) {
> 
> If we want to do the best, we could also pass in GError** here, and convert
> GError(.message) to errp?

Hmm, agree, will try.

Interesting, why we just don't sit on GError..

> 
>> +        error_setg_errno(errp, errno,
>> +                         "Can't set file descriptor %d %s", fd,
>> +                         block ? "blocking" : "non-blocking");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   void qemu_socket_set_block(int fd)
>>   {
>>       g_unix_set_fd_nonblocking(fd, false, NULL);
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index b7351634ec..03044f5b59 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -177,6 +177,24 @@ static int socket_error(void)
>>       }
>>   }
>>   
>> +bool qemu_set_blocking(int fd, bool block, Error **errp)
>> +{
>> +    unsigned long opt = block ? 0 : 1;
>> +
>> +    if (block) {
>> +        qemu_socket_unselect(fd, NULL);
>> +    }
>> +
>> +    if (ioctlsocket(fd, FIONBIO, &opt) != NO_ERROR) {
>> +        error_setg_errno(errp, socket_error(),
>> +                         "Can't set file descriptor %d %s", fd,
>> +                         block ? "blocking" : "non-blocking");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   void qemu_socket_set_block(int fd)
>>   {
>>       unsigned long opt = 0;
>> -- 
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

