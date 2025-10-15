Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6040ACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vTT-0008Uh-D7; Wed, 15 Oct 2025 02:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8vTR-0008Rx-DW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:59:01 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v8vTG-0007IX-8j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:59:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5BC118088E;
 Wed, 15 Oct 2025 09:58:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dwJMSj2FwW20-fwYNnLKS; Wed, 15 Oct 2025 09:58:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760511521;
 bh=AWva7CvcgzvjLxJ+E8EC+/HvGgqGpnKjUl7LOZG1C6U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BvRNg4Oz+7gd3fHZRm+Wg/E2pw97tvlL1X2TYa277w9foGdgkHPcxiqXLgcYxIEV7
 o75cc7B037RA84dkFZU1qHIMReAQo7B8tMvahag7Em2WHWYUwT2FkWJ8VgJyy9lMrz
 b1bcmJXcIENbpWF4rDkq5Cek92yTzWhWPv2SHP0E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <76945924-ed5e-4365-95c8-a8f752d7ad03@yandex-team.ru>
Date: Wed, 15 Oct 2025 09:58:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org, raphael@enfabrica.net,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-6-vsementsov@yandex-team.ru>
 <87y0pcirp0.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87y0pcirp0.fsf@pond.sub.org>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15.10.25 09:50, Markus Armbruster wrote:
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
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> [...]
> 
>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>> index 429852f8d9..ebadaf3482 100644
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
>> @@ -259,10 +261,28 @@ struct ChardevClass {
>>       /* parse command line options and populate QAPI @backend */
>>       void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
>>   
>> -    /* called after construction, open/starts the backend */
>> +    /*
>> +     * Called after construction, create and open/starts the backend,
> 
> What to do mean by "create and open/starts"?
> 
> Maybe "create and start"?

Yes, sounds good.

> 
>> +     * mutual exclusive with .init. .connect must not be defined when
> 
> mutually
> 
>> +     * .open is defined.
>> +     */
> 
> Suggest to use @name to refer to a member name.  We do that elsewhere,
> and it's easier on the eyes than dots.
> 
>>       void (*open)(Chardev *chr, ChardevBackend *backend,
>>                    bool *be_opened, Error **errp);
>>   
>> +    /*
>> +     * Called after construction, create the backend, mutual exclusive
> 
> mutually
> 
>> +     * with .open, and must be accompanied by .connect.
> 
> Is it okay to destroy after init() without connect()?
> 
> If yes, "must" is misleading.

Hmm. "should" is OK then?

> 
>> +     * Must set chr-filename.
> 
> What's chr-filename?

Type. That should be chr->filename. Or better @chr->filename ?

> 
>> +     */
>> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
>> +                 Error **errp);
>> +
>> +    /*
>> +     * Called after .init(), open/starts the backend, mutual exclusive
> 
> mutually
> 
>> +     * with .open. Must send CHR_EVENT_OPENED.
> 
> Must send CHR_EVENT_OPENED when it succeeds, I guess.

Yes, will add.

> 
>> +     */
>> +    bool (*connect)(Chardev *chr, Error **errp);
>> +
>>       /* write buf to the backend */
>>       int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
> 
> So, a ChardevClass either provides methods init() and connect(), or
> their fusion open().  Correct?

Yes

> 
> Perhaps documentation becomes simpler if you put init() and connect()
> before open().  You could then say open() needs to do the work of both.
> 

Agree, will do.

Thanks for reviewing!

-- 
Best regards,
Vladimir

