Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14070C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFR9-00028n-J9; Wed, 12 Feb 2025 11:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiFR3-000287-SK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:18:02 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiFQz-0006lb-Ls
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:18:01 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4885A612A1;
 Wed, 12 Feb 2025 19:17:47 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8111::1:1d] (unknown
 [2a02:6b8:b081:8111::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jHS6JE0IbuQ0-vre3HGjM; Wed, 12 Feb 2025 19:17:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739377066;
 bh=r1yU3oK//u/e/iLARpqvYzc70wRbKLYxnw2WIFVuoo8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eyY2X3IjMPLVOoaVnrmcatI5XJzP9HVJihG7ivfCOG2dWVCd2Vyq2TiK7dyLdoZj5
 Ypvve6DFmYnG4QHrrec+sRwr7CnC/ftzvHiOC2hLi4KxYNVWt/EsIXGtjR0Py3hsOs
 P7lu0e1ZL8Atk5aSIHOzqgyVwbDeEc7VPRcP4xWM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c78c911c-d7b3-412b-a6d0-b4bcca070a6b@yandex-team.ru>
Date: Wed, 12 Feb 2025 19:17:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y-jdFOCVz8mEXo@redhat.com>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z6y-jdFOCVz8mEXo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 2/12/25 6:30 PM, Daniel P. Berrangé wrote:

> On Wed, Feb 12, 2025 at 05:39:17PM +0300, Daniil Tatianin wrote:
>> This will be used in the following commits to make it possible to only
>> lock memory on fault instead of right away.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   include/system/os-posix.h |  2 +-
>>   include/system/os-win32.h |  3 ++-
>>   meson.build               |  6 ++++++
>>   migration/postcopy-ram.c  |  2 +-
>>   os-posix.c                | 14 ++++++++++++--
>>   system/vl.c               |  2 +-
>>   6 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
>> index b881ac6c6f..ce5b3bccf8 100644
>> --- a/include/system/os-posix.h
>> +++ b/include/system/os-posix.h
>> @@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
>>   void os_set_chroot(const char *path);
>>   void os_setup_limits(void);
>>   void os_setup_post(void);
>> -int os_mlock(void);
>> +int os_mlock(bool on_fault);
>>   
>>   /**
>>    * qemu_alloc_stack:
>> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
>> index b82a5d3ad9..cd61d69e10 100644
>> --- a/include/system/os-win32.h
>> +++ b/include/system/os-win32.h
>> @@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
>>       return false;
>>   }
>>   
>> -static inline int os_mlock(void)
>> +static inline int os_mlock(bool on_fault)
>>   {
>> +    (void)on_fault;
> Is this really needed ? Our compiler flags don't enable warnings
> about unused variables.

Hmm, I was not aware of that, thank you.

Peter, do you want me to resend, or can you squash remove this as well?

>
> If they did, this would not be the way to hide them. Instead you
> would use the "G_GNUC_UNUSED" annotation against the parameter.
> eg
>
>    static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
>
>>       return -ENOSYS;
>>   }
>>   
>> diff --git a/os-posix.c b/os-posix.c
>> index 9cce55ff2f..17b144c0a2 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -327,18 +327,28 @@ void os_set_line_buffering(void)
>>       setvbuf(stdout, NULL, _IOLBF, 0);
>>   }
>>   
>> -int os_mlock(void)
>> +int os_mlock(bool on_fault)
>>   {
>>   #ifdef HAVE_MLOCKALL
>>       int ret = 0;
>> +    int flags = MCL_CURRENT | MCL_FUTURE;
>>   
>> -    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
>> +#ifdef HAVE_MLOCK_ONFAULT
>> +    if (on_fault) {
>> +        flags |= MCL_ONFAULT;
>> +    }
>> +#else
>> +    (void)on_fault;
>> +#endif
>> +
>> +    ret = mlockall(flags);
>>       if (ret < 0) {
>>           error_report("mlockall: %s", strerror(errno));
>>       }
>>   
>>       return ret;
>>   #else
>> +    (void)on_fault;
>>       return -ENOSYS;
>>   #endif
> Again casting to (void) should not be required AFAIK.
>
>
> With regards,
> Daniel

