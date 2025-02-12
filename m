Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE43C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEds-0005x3-LI; Wed, 12 Feb 2025 10:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiEdq-0005wo-E8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:27:10 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiEdo-00021M-3O
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:27:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3e09:0:640:a98e:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0D92960F82;
 Wed, 12 Feb 2025 18:27:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1215::1:15] (unknown
 [2a02:6b8:b081:1215::1:15])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1RRGXA0IWSw0-5pETcqm4; Wed, 12 Feb 2025 18:27:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739374022;
 bh=Ma0z/B+aK3HlyIPOoROdzQB2AE+n3IcaaXT7+r4c9hU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HAbu0FyhlNl4qbltSvWpywZy10oDvWcJvA8p0qmMorE9qUaZPDHKcSBz8hgZOGOod
 Hix/15XKp5zmRImSLr1qfnv0duLr42zpN0zIJLUjkVJDWLRCwF0rM8fAlgdD9uzuxu
 i9vk4a/qta9x+K6PLMvzXG7xPiMvbBerKC/r1Ekg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <86d9f9d1-cf23-4353-bcf7-8f163df658c1@yandex-team.ru>
Date: Wed, 12 Feb 2025 18:27:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y81mXn7yaXy63A@x1.local>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z6y81mXn7yaXy63A@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 2/12/25 6:23 PM, Peter Xu wrote:

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
>>       return -ENOSYS;
>>   }
>>   
>> diff --git a/meson.build b/meson.build
>> index 18cf9e2913..59953cbe6b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
>>       return mlockall(MCL_FUTURE);
>>     }'''))
>>   
>> +config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
>> +  #include <sys/mman.h>
>> +  int main(void) {
>> +      return mlockall(MCL_FUTURE | MCL_ONFAULT);
>> +  }'''))
>> +
>>   have_l2tpv3 = false
>>   if get_option('l2tpv3').allowed() and have_system
>>     have_l2tpv3 = cc.has_type('struct mmsghdr',
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 6a6da6ba7f..fc4d8a10df 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>>       }
>>   
>>       if (enable_mlock) {
>> -        if (os_mlock() < 0) {
>> +        if (os_mlock(false) < 0) {
>>               error_report("mlock: %s", strerror(errno));
>>               /*
>>                * It doesn't feel right to fail at this point, we have a valid
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
> IIUC we should fail this when not supported.
>
> Would you mind I squash this in?

Sure, go ahead. Thanks!

>
> diff --git a/os-posix.c b/os-posix.c
> index 17b144c0a2..52925c23d3 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -333,13 +333,14 @@ int os_mlock(bool on_fault)
>       int ret = 0;
>       int flags = MCL_CURRENT | MCL_FUTURE;
>   
> -#ifdef HAVE_MLOCK_ONFAULT
>       if (on_fault) {
> +#ifdef HAVE_MLOCK_ONFAULT
>           flags |= MCL_ONFAULT;
> -    }
>   #else
> -    (void)on_fault;
> +        error_report("mlockall: on_fault not supported");
> +        return -EINVAL;
>   #endif
> +    }
>   
>       ret = mlockall(flags);
>       if (ret < 0) {
>
>
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
>>   }
>> diff --git a/system/vl.c b/system/vl.c
>> index 9c6942c6cf..e94fc7ea35 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts = {
>>   static void realtime_init(void)
>>   {
>>       if (enable_mlock) {
>> -        if (os_mlock() < 0) {
>> +        if (os_mlock(false) < 0) {
>>               error_report("locking memory failed");
>>               exit(1);
>>           }
>> -- 
>> 2.34.1
>>

