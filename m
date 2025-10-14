Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D518ACCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8b62-0004Oy-AJ; Tue, 14 Oct 2025 05:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8b5v-0004M1-Fg
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:13:25 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8b5s-0001Du-I7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:13:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id F407180818;
 Tue, 14 Oct 2025 12:13:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FDLOTI3FoSw0-31wLyGo9; Tue, 14 Oct 2025 12:13:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760433196;
 bh=CopMfirbw4Ji03+4yyARmoX2JWPJcaxWw4w77F6IrPE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gsQVxMq6ZV8g27sjhyuwfHsLc2SLC1Wj1oz5Tp2RGXxRM7s3KxTvAB8dapcHx0bAn
 WOZZfE8qldCaAgsNLg0B0rnXCLadhWpfWMyx+x4X4xe88ErFgw/9e9110llBAttgOo
 AebbGSFRFr/plh9Ixg/YrnGlQvAqQ1uA8uixKpXU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f4470541-c41b-406d-b099-f995502fbc21@yandex-team.ru>
Date: Tue, 14 Oct 2025 12:13:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] chardev/char: qemu_char_open(): add return value
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-4-vsementsov@yandex-team.ru>
 <CAJ+F1CL-wvyP3cVGAWyy_avQxzwPQcVJ+YtyxpRVY8HmKDNjkw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1CL-wvyP3cVGAWyy_avQxzwPQcVJ+YtyxpRVY8HmKDNjkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.10.25 10:10, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Oct 13, 2025 at 5:40 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Accordingly with recommendations in include/qapi/error.h accompany
>> errp by boolean return value and get rid of error propagation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/chardev/char.c b/chardev/char.c
>> index d5a2533e8e..64ec60c0f2 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -246,14 +246,20 @@ int qemu_chr_add_client(Chardev *s, int fd)
>>           CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
>>   }
>>
>> -static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
>> +static bool qemu_char_open(Chardev *chr, ChardevBackend *backend,
>>                              bool *be_opened, Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       ChardevClass *cc = CHARDEV_GET_CLASS(chr);
>>
>>       if (cc->open) {
>>           cc->open(chr, backend, be_opened, errp);
>> +        if (*errp) {
>> +            return false;
>> +        }
>>       }
>> +
>> +    return true;
>>   }
>>
>>   static void char_init(Object *obj)
>> @@ -1030,9 +1036,7 @@ static Chardev *chardev_new(const char *id, const char *typename,
>>           goto fail;
>>       }
>>
>> -    qemu_char_open(chr, backend, &be_opened, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> +    if (!qemu_char_open(chr, backend, &be_opened, &local_err)) {
> 
> You meant to pass errp instead, since you dropped error_propagate ?
> 

Oops, right

>>           goto fail;
>>       }
>>
>> --
>> 2.48.1
>>
>>
> 
> 


-- 
Best regards,
Vladimir

