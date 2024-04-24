Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1D7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzcQJ-00026R-Kx; Wed, 24 Apr 2024 09:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzcQD-00025x-VI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:12:26 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzcQ6-0003Qn-32
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:12:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:220a:0:640:7faf:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id AE32760B55;
 Wed, 24 Apr 2024 16:12:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8811::1:29] (unknown
 [2a02:6b8:b081:8811::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8CLuUA2GcuQ0-UY8hSfWh; Wed, 24 Apr 2024 16:12:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713964329;
 bh=bZ6Pzco41QUQVhmUO2uieeTKc9sUpxrWtVhrPVFmdH8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GoFdDxorG63hz74jWQiYX5q1eQyYCdOHjN6kJ3l8WRo7eoaxz0sPd/T8ObSbw/CBG
 fAAWw77HwWaUQJWgUN8E0mHZNRvVmceCAAh4HrsHa68yjF3RDE4S96nYlW+AKY0O2/
 kDbsflxKuLE1AgxMUV5FnFoMAvOzqiy142mX8ZFc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f9b07115-978d-4ff0-9404-f3ebb424930b@yandex-team.ru>
Date: Wed, 24 Apr 2024 16:12:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] util/log: add cleanup function
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 groug@kaod.org
References: <20240417183333.39256-1-vsementsov@yandex-team.ru>
 <20240422192923.GA118554@fedora>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240422192923.GA118554@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 22.04.24 22:29, Stefan Hajnoczi wrote:
> On Wed, Apr 17, 2024 at 09:33:33PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We leak global_filename, and do not close global_file. Let's fix that.
> 
> What is the goal?
> 
> Leaking global_filename does not cause unbounded memory consumption. I
> guess the goal in freeing global_filename is to keep leak checker
> reports tidy?

Correct. But a bit more interesting: Coverity think that filename is leaked inside function. But that's a false positive (and marked as false-positive), as it is stored into global_filename, which is freed before next assignment. Still, looking at this, I noticed that global_filename is finally leaked at the end of the program.. And decided to fix.

> 
> Closing global_file doesn't improve anything AFAICT. It might cause
> problems if another component still wants to log something from a
> destructor function. I'm not sure if the order of destructors is
> defined.

Agree, that's a risk.

> 
> What about qemu_mutex_destroy(&global_mutex) to balance startup()?
> 
> What about debug_regions?

OK, I tend to agree and don't care about)

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Interesting: seems, nobody is maintainer of util/log.c
>>
>>   util/log.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/util/log.c b/util/log.c
>> index d36c98da0b..30de209210 100644
>> --- a/util/log.c
>> +++ b/util/log.c
>> @@ -85,6 +85,15 @@ static void qemu_log_thread_cleanup(Notifier *n, void *unused)
>>       }
>>   }
>>   
>> +static void __attribute__((__destructor__)) cleanup(void)
>> +{
>> +    g_free(global_filename);
>> +    if (global_file && global_file != stderr) {
>> +        fclose(global_file);
>> +        global_file = NULL;
>> +    }
>> +}
>> +
>>   /* Lock/unlock output. */
>>   
>>   static FILE *qemu_log_trylock_with_err(Error **errp)
>> -- 
>> 2.34.1
>>

-- 
Best regards,
Vladimir


