Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA74D1F9DE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR8r2-0001EE-RK; Thu, 04 Dec 2025 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR8qz-0001Dk-Si
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:54:38 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vR8qy-0005QP-7m
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:54:37 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A632480771;
 Thu, 04 Dec 2025 15:54:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:856::1:37] (unknown
 [2a02:6bf:8080:856::1:37])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Usk7oU0FGGk0-Lxmk8ZD4; Thu, 04 Dec 2025 15:54:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764852872;
 bh=SQLFTgNY3nvdZqGOj4Rf5Vt6rBTVJmSg2nJ+I4Kkdpg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tAYPaSmFPxNrzl1hZYZ5d2bVAxPbiRcE8AsPZDAdX8n21xonK66Ulx5+Vgnl1B5Op
 4jbgPC8xXkhocdZFqhRRmlM/5UbQbeUQoQrXzEdF0UAZFzp/9fzScTavuMExncDITM
 fsAOhi5IJKht4Y80EEeXQzCRTQL8QTxZ8Gr9zMOM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a19b10d-0f49-4b22-9a67-0d4fcbb16e04@yandex-team.ru>
Date: Thu, 4 Dec 2025 15:54:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] error-report: move real_time_iso8601() to header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 berrange@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
 <20251128200536.207344-3-vsementsov@yandex-team.ru>
 <87h5u7odkh.fsf@pond.sub.org>
 <69a68b6b-0bd6-4295-930f-bd9486c732f4@yandex-team.ru>
 <87zf7yll7g.fsf@pond.sub.org>
 <bc6babb4-9cc0-46dc-af77-d182575b72a9@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <bc6babb4-9cc0-46dc-af77-d182575b72a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 04.12.25 11:30, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 4/12/25 09:12, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>
>>> On 03.12.25 17:16, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> To be reused in the following commit.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>> ---
>>>>>    include/qemu/error-report.h | 6 ++++++
>>>>>    util/error-report.c         | 7 -------
>>>>>    2 files changed, 6 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>>>>> index 3ae2357fda..412b705898 100644
>>>>> --- a/include/qemu/error-report.h
>>>>> +++ b/include/qemu/error-report.h
>>>>> @@ -74,4 +74,10 @@ extern bool message_with_timestamp;
>>>>>    extern bool error_with_guestname;
>>>>>    extern const char *error_guest_name;
>>>>> +static inline char *real_time_iso8601(void)
>>>>> +{
>>>>> +    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>>>> +    return g_date_time_format_iso8601(dt);
>>>>> +}
>>>>> +
>>>>>    #endif
>>>>
>>>> Reasons for inline?  Because the function is so small?
>>>
>>> Yes, seems, just this.
>>
>> I'd prefer not to.
>>
>> Actually, I'd be tempted to just duplicate the two calls and call it a
>> day.  Up to you.
> 
> We now prefer to let the toolchain LTO do its clever job.
> Better avoid duplication. To enforce this style, lets expose
> the declaration with a @docstring, and keep the definition in util/.
> My 2 cents.
> 

OK

>>
>>>>> diff --git a/util/error-report.c b/util/error-report.c
>>>>> index 1b17c11de1..20618640e8 100644
>>>>> --- a/util/error-report.c
>>>>> +++ b/util/error-report.c
>>>>> @@ -169,13 +169,6 @@ static void print_loc(void)
>>>>>        }
>>>>>    }
>>>>> -static char *
>>>>> -real_time_iso8601(void)
>>>>> -{
>>>>> -    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>>>> -    return g_date_time_format_iso8601(dt);
>>>>> -}


-- 
Best regards,
Vladimir

