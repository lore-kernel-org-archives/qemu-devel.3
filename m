Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B5C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDZ5-0003G1-LW; Wed, 12 Feb 2025 09:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDYu-0003F2-32
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:18:00 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiDYq-0002ZS-LI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:17:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 373A660AD5;
 Wed, 12 Feb 2025 17:17:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:2f] (unknown
 [2a02:6b8:b081:b518::1:2f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hHQPg90IhGk0-o2008xOr; Wed, 12 Feb 2025 17:17:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739369864;
 bh=IWhAU3BDWUv+oMdtgRqiz2DXVQ63MdObHAH1Ct2UywU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jV7Dl4DsZHepU334NqmE3OiyVWfiyuYc1iGdgRZYlqXsM5sKkSVw/Fm0p8xHyO2Wr
 u/VBQm9Hh0SEqjTCK5AFCnzf9eBkFhwjxsGfWqLZ0P0c8f1hCJw2zexJg2I09oDQI/
 scrzHoe01P3SFksrGw4e31xq39lx82VtdlrVSYQI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b1309ddf-e1f3-4d17-821b-02cd1b6c36b7@yandex-team.ru>
Date: Wed, 12 Feb 2025 17:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/14] os: add an ability to lock memory on_fault
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20250211225059.182533-1-peterx@redhat.com>
 <20250211225059.182533-3-peterx@redhat.com>
 <CAJSP0QUFX56ePKQ=jD7jMkP6TYPF83zwdnEXCyLG7FMgcjZ9UQ@mail.gmail.com>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <CAJSP0QUFX56ePKQ=jD7jMkP6TYPF83zwdnEXCyLG7FMgcjZ9UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 2/12/25 5:13 PM, Stefan Hajnoczi wrote:
> On Tue, Feb 11, 2025 at 5:52 PM Peter Xu <peterx@redhat.com> wrote:
>> From: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>
>> This will be used in the following commits to make it possible to only
>> lock memory on fault instead of right away.
> Hi Peter and Daniil,
> Please take a look at this CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/9117106042#L3603
>
> Thanks,
> Stefan

Looks like MCL_ONFAULT is linux-only, I guess I'll have to have add 
something similar to HAVE_MLOCKALL and put this under an ifdef.

Thank you

>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> Link: https://lore.kernel.org/r/20250123131944.391886-2-d-tatianin@yandex-team.ru
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>   include/system/os-posix.h |  2 +-
>>   include/system/os-win32.h |  3 ++-
>>   migration/postcopy-ram.c  |  2 +-
>>   os-posix.c                | 10 ++++++++--
>>   system/vl.c               |  2 +-
>>   5 files changed, 13 insertions(+), 6 deletions(-)
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
>> index 9cce55ff2f..48afb2990d 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -327,18 +327,24 @@ void os_set_line_buffering(void)
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
>> +    if (on_fault) {
>> +        flags |= MCL_ONFAULT;
>> +    }
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
>> 2.47.0
>>
>>

