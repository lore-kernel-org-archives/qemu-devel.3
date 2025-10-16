Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3ACCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 06:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Hfc-0003JR-Uk; Thu, 16 Oct 2025 02:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9HfY-0003JB-Ag
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:41:01 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9HfU-0005G0-T8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:41:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F039A8083D;
 Thu, 16 Oct 2025 09:40:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oeKVv33F1qM0-WXTcLsCM; Thu, 16 Oct 2025 09:40:51 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760596851;
 bh=EUEicfCwv23R5thr2EbKdfyolUV/kGS1ov+cwSUhL84=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=R/FFAuAdNqtp+tPCNv+hZpTgcglE00tQAQzGi3fuGyf8XUswaAS7+7puB7H1hXxsI
 SSxDbAmpn84WT1viTa+QO9iKMgdygjAKDE5ewBNQpfMGDvQFLb47EvfgTvk7C26HP0
 tLvF/CjhaI8aiMnzrrZmDUAz/7pcza+6x5k93n4k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <29851555-f1f2-479d-aa61-7be80289f357@yandex-team.ru>
Date: Thu, 16 Oct 2025 09:40:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org, raphael@enfabrica.net,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
 <20251015212051.1156334-6-vsementsov@yandex-team.ru>
 <87qzv3v03c.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87qzv3v03c.fsf@pond.sub.org>
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

On 16.10.25 09:20, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> We'll need a possibility to postpone connect step to later point in
>> time to implement backend-transfer migration feature for vhost-user-blk
>> in further commits. Let's start with new char interface for backends.
>>
>> .init() takes QAPI parameters and should parse them, called early
>>
>> .connect() should actually establish a connection, and postponed to
>> the point of attaching to frontend. Called at later point, either
>> at time of attaching frontend, either from qemu_chr_wait_connected().
> 
> s/either/or/
> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> [...]
> 
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index 429852f8d9..d2e01f0f9c 100644
>> --- a/include/chardev/char.h
>> +++ b/include/chardev/char.h
>> @@ -63,6 +63,7 @@ struct Chardev {
>>       CharBackend *be;
>>       char *label;
>>       char *filename;
>> +    bool connect_postponed;
>>       int logfd;
>>       int be_open;
>>       /* used to coordinate the chardev-change special-case: */
>> @@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>>                                   bool permit_mux_mon);
>>   int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all);
>>   #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
>> +bool qemu_chr_connect(Chardev *chr, Error **errp);
>>   int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>>   
>>   #define TYPE_CHARDEV "chardev"
>> @@ -259,7 +261,31 @@ struct ChardevClass {
>>       /* parse command line options and populate QAPI @backend */
>>       void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
>>   
>> -    /* called after construction, open/starts the backend */
>> +    /*
>> +     * Called after construction, create the backend, mutually exclusive
>> +     * with @open, and should be followed by @connect().
>> +     * Must set the Chardev's chr->filename on success.
>> +     */
>> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
>> +                 Error **errp);
>> +
>> +    /*
>> +     * Called after @init(), starts the backend, mutually exclusive
>> +     * with @open. Should care to send CHR_EVENT_OPENED when connected.
> 
> Would "Must send CHR_EVENT_OPENED on success" be clearer?

No, because it may start background connecting process instead, which
should finish with CHR_EVENT_OPENED.

> 
>> +     */
>> +    bool (*connect)(Chardev *chr, Error **errp);
>> +
>> +    /*
>> +     * Called after construction, an alternative to @init + @connect
>> +     * and should do the work for both: create and start the backend.
>> +     * Mutual exclusive with @init and @connect.
> 
> Mutually
> 
>> +     *
>> +     * May not set the Chardev's chr->filename (generic code will care),
>> +     * and may not send CHR_EVENT_OPENED when connected (@be_opened
>> +     * should not be touched in this case, to signal the generic code
>> +     * to care about CHR_EVENT_OPENED). If backend care about
> 
> If the backend cares
> 
>> +     * CHR_EVENT_OPENED, it should set @be_opened to false.
>> +     */
>>       void (*open)(Chardev *chr, ChardevBackend *backend,
>>                    bool *be_opened, Error **errp);
> 


-- 
Best regards,
Vladimir

