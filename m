Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE981CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bAi-0006TH-Lx; Tue, 14 Oct 2025 05:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8bAg-0006Sk-JF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:18:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8bAd-0001fo-LK
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:18:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5CBE780730;
 Tue, 14 Oct 2025 12:18:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8a::1:35] (unknown
 [2a02:6bf:8080:a8a::1:35])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9ILhgS2FwmI0-w2DW7FcN; Tue, 14 Oct 2025 12:18:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760433490;
 bh=Sm0nUU2l/FWjIPrjENoYRg18cEtDV05tHS5LLI6SQsI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bAog8qkCA4PxrZZRsX61McRKJAif8yGllJHQiDA2fqaPynRyhMRwILgF55wfnCPO1
 bkoElN5v5QSXLIDU2NZcdv0j52JlWWPHAwYJ9vY/n5v5GdFOQ4S0qznYagv0ckdFJi
 jmcWViGt3BINqFtAoACFamsn+KEUoArxOy2oVvEE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7adfd95b-4236-4182-bf15-c5a063d2bcdd@yandex-team.ru>
Date: Tue, 14 Oct 2025 12:18:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] char: vhost-user-blk call connect by hand
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-8-vsementsov@yandex-team.ru>
 <CAJ+F1C+E6Q8V2_Qn14d490+qbLZTEf08hStC5w6=vV5ebNcvoA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJ+F1C+E6Q8V2_Qn14d490+qbLZTEf08hStC5w6=vV5ebNcvoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> Hi
> 
> On Mon, Oct 13, 2025 at 5:39 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Give vhost-user-blk a possibility (and responsibility) to decide when
>> do connect. It will help us to realize vhost-user-blk backend-transfer
>> migration feature:
>>
>> For incoming migration we'll need to postpone connect at least until
>> early stage of migrate-incoming command, when we already know all
>> migration parameters and can decide, are we going to do incoming
>> backend-transfer (and get chardev fd from incoming stream), or we
>> finally need to connect.
>>
>> With this patch, we don't modify vhost-user-blk.c: it already
>> do call qemu_chr_fe_wait_connected(), which in turn calls
>> qemu_chr_connect().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-fe.c                | 21 +++++++++++++++++----
>>   hw/core/qdev-properties-system.c |  2 +-
>>   include/chardev/char-fe.h        |  2 ++
>>   3 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
>> index 973fed5bea..9e2c658cb9 100644
>> --- a/chardev/char-fe.c
>> +++ b/chardev/char-fe.c
>> @@ -189,12 +189,20 @@ bool qemu_chr_fe_backend_open(CharBackend *be)
>>       return be->chr && be->chr->be_open;
>>   }
>>
>> -bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>> +bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, ObjectClass *oc,
>> +                         Error **errp)
>>   {
>>       unsigned int tag = 0;
>> -
>> -    if (!qemu_chr_connect(s, errp)) {
>> -        return false;
>> +    const char *driver = oc ? object_class_get_name(oc) : NULL;
>> +
>> +    /*
>> +     * vhost-user-blk wants call qemu_chr_connect by hand,
>> +     * to support backend-transfer migration feature.
>> +     */
>> +    if (!driver || !g_str_has_prefix(driver, "vhost-user-blk")) {
>> +        if (!qemu_chr_connect(s, errp)) {
>> +            return false;
>> +        }
> 
> Why not pass a bool "connect" instead?
> 
> DEFINE_PROP_CHR() would use "true".
> 
> + Introduce DEFINE_PROP_CHR_NO_CONNECT() that would use "false".
> 
> and wire it with a new PropertyInfo and modified callbacks.
> 

Will try, thanks for idea. I don't like this checking by name too, just design it after
.check_peer_type in net/ code.

>>       }
>>
>>       if (s) {
>> @@ -218,6 +226,11 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>>       return true;
>>   }
>>
>> +bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>> +{
>> +    return qemu_chr_fe_init_ex(b, s, NULL, errp);
>> +}
>> +
>>   void qemu_chr_fe_deinit(CharBackend *b, bool del)
>>   {
>>       assert(b);
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>> index 1f810b7ddf..35eed17d4d 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -297,7 +297,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>>       if (s == NULL) {
>>           error_setg(errp, "Property '%s.%s' can't find value '%s'",
>>                      object_get_typename(obj), name, str);
>> -    } else if (!qemu_chr_fe_init(be, s, errp)) {
>> +    } else if (!qemu_chr_fe_init_ex(be, s, obj->class, errp)) {
>>           error_prepend(errp, "Property '%s.%s' can't take value '%s': ",
>>                         object_get_typename(obj), name, str);
>>       }
>> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
>> index 8ef05b3dd0..f1c05cc5ed 100644
>> --- a/include/chardev/char-fe.h
>> +++ b/include/chardev/char-fe.h
>> @@ -34,6 +34,8 @@ struct CharBackend {
>>    * Returns: false on error.
>>    */
>>   bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
>> +bool qemu_chr_fe_init_ex(CharBackend *b, Chardev *s, ObjectClass *oc,
>> +                         Error **errp);
>>
>>   /**
>>    * qemu_chr_fe_deinit:
>> --
>> 2.48.1
>>
>>
> 
> 


-- 
Best regards,
Vladimir

