Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC6FD12D77
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoQF-00029d-6D; Wed, 03 Dec 2025 10:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vQoQC-00025T-5Z
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:05:36 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vQoQ8-0000iU-Vk
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:05:35 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A81BDC02BE;
 Wed, 03 Dec 2025 18:05:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:856::1:37] (unknown
 [2a02:6bf:8080:856::1:37])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P5mnpE0FluQ0-n9JRvXo3; Wed, 03 Dec 2025 18:05:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764774325;
 bh=+ajjnOFTWZMm8bnmH9AfA8H3x8zcJGUYX9F9w6Tc9Yg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Oo93TYjgvuTm3RgxwLfK5qmfnM/udDyez9zWC1ewOTcZvhjUdk1B0eJ+4HONsjSkb
 4fLrj1HHhM18kaIU7wBwXG7Z1lds0h9ylgG6pJPUjJwqntIIshopPo5f/gziSt/0Fo
 xFCOtCuHppWyuTy9VdeE0rKCXTLw9VEVb2u+3uM8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69a68b6b-0bd6-4295-930f-bd9486c732f4@yandex-team.ru>
Date: Wed, 3 Dec 2025 18:05:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] error-report: move real_time_iso8601() to header
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 berrange@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
 <20251128200536.207344-3-vsementsov@yandex-team.ru>
 <87h5u7odkh.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87h5u7odkh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 03.12.25 17:16, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> To be reused in the following commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   include/qemu/error-report.h | 6 ++++++
>>   util/error-report.c         | 7 -------
>>   2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>> index 3ae2357fda..412b705898 100644
>> --- a/include/qemu/error-report.h
>> +++ b/include/qemu/error-report.h
>> @@ -74,4 +74,10 @@ extern bool message_with_timestamp;
>>   extern bool error_with_guestname;
>>   extern const char *error_guest_name;
>>   
>> +static inline char *real_time_iso8601(void)
>> +{
>> +    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>> +    return g_date_time_format_iso8601(dt);
>> +}
>> +
>>   #endif
> 
> Reasons for inline?  Because the function is so small?

Yes, seems, just this.

> 
>> diff --git a/util/error-report.c b/util/error-report.c
>> index 1b17c11de1..20618640e8 100644
>> --- a/util/error-report.c
>> +++ b/util/error-report.c
>> @@ -169,13 +169,6 @@ static void print_loc(void)
>>       }
>>   }
>>   
>> -static char *
>> -real_time_iso8601(void)
>> -{
>> -    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>> -    return g_date_time_format_iso8601(dt);
>> -}
>> -
>>   /*
>>    * Print a message to current monitor if we have one, else to stderr.
>>    * @report_type is the type of message: error, warning or informational.
> 


-- 
Best regards,
Vladimir

