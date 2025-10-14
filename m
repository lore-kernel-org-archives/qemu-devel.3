Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40278CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bDo-0007za-TP; Tue, 14 Oct 2025 05:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8bDn-0007z9-Ni
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:21:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8bDk-00022G-7t
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:21:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5ED4BC014E;
 Tue, 14 Oct 2025 12:21:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MLLsRR2F6mI0-JT68sfP7; Tue, 14 Oct 2025 12:21:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760433683;
 bh=4aopmKTFFDU0LCRASY32kAXn7zAGpFarLVf0FvLBlaM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Nx32GGufcswEvEUn1Zc5JrJn5Xp5mEmWXodrNQ4uecCH+NFRQib6OA8OB/nIzNDeQ
 vNzvEAfhTmHDoM1v/aKQhPHqRE3tv6gCdjEl+ydi9n8IhdYWcpctqlq/szLXX7st4z
 fL8JVAPldJVzL5/3SbcPqZlcUZBSvvs3iYMx52zE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6c5f3a6a-b237-4352-810e-345eb0f36904@yandex-team.ru>
Date: Tue, 14 Oct 2025 12:21:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-3-vsementsov@yandex-team.ru>
 <CAJ+F1C+W+hUuu--QopWqB14w2VWeiPkOxxGdS-v2K7MB4eye-A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1C+W+hUuu--QopWqB14w2VWeiPkOxxGdS-v2K7MB4eye-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 14.10.25 10:30, Marc-André Lureau wrote:
> On Mon, Oct 13, 2025 at 5:41 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> We are going to share new chardev_init_logfd() with further
>> alternative initialization interface. Let qemu_char_open() be
>> a wrapper for .open(), and its artifacts (handle be_opened if
>> was not set to false by backend, and filename).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
>> ---
>>   chardev/char.c | 49 +++++++++++++++++++++++++++++++------------------
>>   1 file changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/chardev/char.c b/chardev/char.c
>> index a43b7e5481..d5a2533e8e 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -250,22 +250,6 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
>>                              bool *be_opened, Error **errp)
>>   {
>>       ChardevClass *cc = CHARDEV_GET_CLASS(chr);
>> -    /* Any ChardevCommon member would work */
> 
> maybe keep that comment?

I a bit don't follow it, honestly.. What it mean? That we should
handle members of common structure here?

Not a problem to put it back to chardev_init_logfd().. But maybe, it
then should be renamed to chardev_init_common()

> 
> 
>> -    ChardevCommon *common = backend ? backend->u.null.data : NULL;
>> -
>> -    if (common && common->logfile) {
>> -        int flags = O_WRONLY;
>> -        if (common->has_logappend &&
>> -            common->logappend) {
>> -            flags |= O_APPEND;
>> -        } else {
>> -            flags |= O_TRUNC;
>> -        }
>> -        chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
>> -        if (chr->logfd < 0) {
>> -            return;
>> -        }
>> -    }
>>
>>       if (cc->open) {
>>           cc->open(chr, backend, be_opened, errp);
>> @@ -1000,6 +984,28 @@ void qemu_chr_set_feature(Chardev *chr,
>>       return set_bit(feature, chr->features);
>>   }
>>
>> +static bool chardev_init_logfd(Chardev *chr, ChardevBackend *backend,
>> +                                Error **errp)
>> +{
>> +    ChardevCommon *common = backend ? backend->u.null.data : NULL;
>> +
>> +    if (common && common->logfile) {
>> +        int flags = O_WRONLY;
>> +        if (common->has_logappend &&
>> +            common->logappend) {
>> +            flags |= O_APPEND;
>> +        } else {
>> +            flags |= O_TRUNC;
>> +        }
>> +        chr->logfd = qemu_create(common->logfile, flags, 0666, errp);
>> +        if (chr->logfd < 0) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static Chardev *chardev_new(const char *id, const char *typename,
>>                               ChardevBackend *backend,
>>                               GMainContext *gcontext,
>> @@ -1020,11 +1026,14 @@ static Chardev *chardev_new(const char *id, const char *typename,
>>       chr->label = g_strdup(id);
>>       chr->gcontext = gcontext;
>>
>> +    if (!chardev_init_logfd(chr, backend, errp)) {
>> +        goto fail;
>> +    }
>> +
>>       qemu_char_open(chr, backend, &be_opened, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>> -        object_unref(obj);
>> -        return NULL;
>> +        goto fail;
>>       }
>>
>>       if (!chr->filename) {
>> @@ -1035,6 +1044,10 @@ static Chardev *chardev_new(const char *id, const char *typename,
>>       }
>>
>>       return chr;
>> +
>> +fail:
>> +    object_unref(obj);
>> +    return NULL;
>>   }
>>
>>   Chardev *qemu_chardev_new(const char *id, const char *typename,
>> --
>> 2.48.1
>>
>>
> 
> 
> --
> Marc-André Lureau


-- 
Best regards,
Vladimir

