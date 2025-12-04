Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FD9D1D893
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4S0-0003rN-MY; Thu, 04 Dec 2025 03:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vR4Rz-0003rB-43
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:12:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vR4Rx-0002oG-JD
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764835948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=42WQRcYeqPiStTpaBb8rmWxj1RoC8VP0VgOnEfM3szA=;
 b=gGiNLqWfZUo44NggjP+2haWvgFbeZZYUdd6hT7+DtLMW9hOx5ZExZWRwo0q9KyY62NGXax
 tcuIIbAoM8VXl/I48m4SwsmrFCt3tLT8sQ5mNZiZK3L00i7JKDRbZI+RZfsltp8s9q4Iyd
 N8/9DzxYsZeTWhmSEKrF1JaeOU0huwE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-HlCPnvXnORK9pMHVVN2nBg-1; Thu,
 04 Dec 2025 03:12:25 -0500
X-MC-Unique: HlCPnvXnORK9pMHVVN2nBg-1
X-Mimecast-MFC-AGG-ID: HlCPnvXnORK9pMHVVN2nBg_1764835944
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CD0C195606B; Thu,  4 Dec 2025 08:12:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B73300F965; Thu,  4 Dec 2025 08:12:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D5F821E6A27; Thu, 04 Dec 2025 09:12:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  eblake@redhat.com,  berrange@redhat.com,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] error-report: move real_time_iso8601() to header
In-Reply-To: <69a68b6b-0bd6-4295-930f-bd9486c732f4@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 3 Dec 2025 18:05:25 +0300")
References: <20251128200536.207344-1-vsementsov@yandex-team.ru>
 <20251128200536.207344-3-vsementsov@yandex-team.ru>
 <87h5u7odkh.fsf@pond.sub.org>
 <69a68b6b-0bd6-4295-930f-bd9486c732f4@yandex-team.ru>
Date: Thu, 04 Dec 2025 09:12:19 +0100
Message-ID: <87zf7yll7g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 03.12.25 17:16, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> To be reused in the following commit.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   include/qemu/error-report.h | 6 ++++++
>>>   util/error-report.c         | 7 -------
>>>   2 files changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>>> index 3ae2357fda..412b705898 100644
>>> --- a/include/qemu/error-report.h
>>> +++ b/include/qemu/error-report.h
>>> @@ -74,4 +74,10 @@ extern bool message_with_timestamp;
>>>   extern bool error_with_guestname;
>>>   extern const char *error_guest_name;
>>>   
>>> +static inline char *real_time_iso8601(void)
>>> +{
>>> +    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>> +    return g_date_time_format_iso8601(dt);
>>> +}
>>> +
>>>   #endif
>> 
>> Reasons for inline?  Because the function is so small?
>
> Yes, seems, just this.

I'd prefer not to.

Actually, I'd be tempted to just duplicate the two calls and call it a
day.  Up to you.

>>> diff --git a/util/error-report.c b/util/error-report.c
>>> index 1b17c11de1..20618640e8 100644
>>> --- a/util/error-report.c
>>> +++ b/util/error-report.c
>>> @@ -169,13 +169,6 @@ static void print_loc(void)
>>>       }
>>>   }
>>>   
>>> -static char *
>>> -real_time_iso8601(void)
>>> -{
>>> -    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>>> -    return g_date_time_format_iso8601(dt);
>>> -}
>>> -
>>>   /*
>>>    * Print a message to current monitor if we have one, else to stderr.
>>>    * @report_type is the type of message: error, warning or informational.
>> 


