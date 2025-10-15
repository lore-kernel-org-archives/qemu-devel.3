Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6DCCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wGX-0003DX-J4; Wed, 15 Oct 2025 03:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8wGW-0003DP-1C
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8wGT-0004hB-4k
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760514576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=209SPIqSN3v9lT+ktBqCQwf8SocoS3T27DeJ7bLeSPI=;
 b=VpTqG6RN5vIkUJb1KnEoByCm82M0puiC+7zk/+GrhiFDdBJSvM7ahm0utbWtKuAIjGRb2N
 kTgoPrJq3X2lyBiNH8sE6UzrBQBXjItF14HXUfrzPlGxmLvtVxpCitH0PI/dIcauZ2dsrr
 x1uyg4KN9tXd8VY37hFKIjDvL2DhV0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-y7KCTQX0N0amfAp90oUtwg-1; Wed,
 15 Oct 2025 03:49:32 -0400
X-MC-Unique: y7KCTQX0N0amfAp90oUtwg-1
X-Mimecast-MFC-AGG-ID: y7KCTQX0N0amfAp90oUtwg_1760514571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFD2519560A7; Wed, 15 Oct 2025 07:49:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE7BA1800446; Wed, 15 Oct 2025 07:49:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 578B621E6A27; Wed, 15 Oct 2025 09:49:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
In-Reply-To: <76945924-ed5e-4365-95c8-a8f752d7ad03@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 15 Oct 2025 09:58:39 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-6-vsementsov@yandex-team.ru>
 <87y0pcirp0.fsf@pond.sub.org>
 <76945924-ed5e-4365-95c8-a8f752d7ad03@yandex-team.ru>
Date: Wed, 15 Oct 2025 09:49:27 +0200
Message-ID: <87plaofvug.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 15.10.25 09:50, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>=20
>>> We'll need a possibility to postpone connect step to later point in
>>> time to implement backend-transfer migration feature for vhost-user-blk
>>> in further commits. Let's start with new char interface for backends.
>>>
>>> .init() takes QAPI parameters and should parse them, called early
>>>
>>> .connect() should actually establish a connection, and postponed to
>>> the point of attaching to frontend. Called at later point, either
>>> at time of attaching frontend, either from qemu_chr_wait_connected().
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> [...]
>>=20
>>> diff --git a/include/chardev/char.h b/include/chardev/char.h
>>> index 429852f8d9..ebadaf3482 100644
>>> --- a/include/chardev/char.h
>>> +++ b/include/chardev/char.h
>>> @@ -63,6 +63,7 @@ struct Chardev {
>>>      CharBackend *be;
>>>      char *label;
>>>      char *filename;
>>> +    bool connect_postponed;
>>>      int logfd;
>>>      int be_open;
>>>      /* used to coordinate the chardev-change special-case: */
>>> @@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, =
const char *filename,
>>>                                  bool permit_mux_mon);
>>>  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write=
_all);
>>>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, tr=
ue)
>>> +bool qemu_chr_connect(Chardev *chr, Error **errp);
>>>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>>>
>>>  #define TYPE_CHARDEV "chardev"
>>> @@ -259,10 +261,28 @@ struct ChardevClass {
>>>      /* parse command line options and populate QAPI @backend */
>>>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **err=
p);
>>>
>>> -    /* called after construction, open/starts the backend */
>>> +    /*
>>> +     * Called after construction, create and open/starts the backend,
>>
>> What to do mean by "create and open/starts"?
>> Maybe "create and start"?
>
> Yes, sounds good.
>
>>> +     * mutual exclusive with .init. .connect must not be defined when
>>
>> mutually
>>=20
>>> +     * .open is defined.
>>> +     */
>>
>> Suggest to use @name to refer to a member name.  We do that elsewhere,
>> and it's easier on the eyes than dots.
>>=20
>>>      void (*open)(Chardev *chr, ChardevBackend *backend,
>>>                   bool *be_opened, Error **errp);
>>> +    /*
>>> +     * Called after construction, create the backend, mutual exclusive
>>
>> mutually
>>=20
>>> +     * with .open, and must be accompanied by .connect.
>>
>> Is it okay to destroy after init() without connect()?
>> If yes, "must" is misleading.
>
> Hmm. "should" is OK then?

"Should be followed by connect()" would work.

Or something like "The backend still needs to be started with init()."

>>> +     * Must set chr-filename.
>>
>> What's chr-filename?
>
> Type. That should be chr->filename. Or better @chr->filename ?

There is no member @chr.  I figure it's CharBackend member @chr.
Perhaps "the CharBackend's chr->filename".=20

[...]

> Thanks for reviewing!

You're welcome!


