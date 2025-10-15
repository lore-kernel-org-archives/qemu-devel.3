Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB32CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wMn-0005py-ID; Wed, 15 Oct 2025 03:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8wMl-0005lE-L5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8wMf-0005Y4-PR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760514959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9nv8f8DCeB1cUJjABzO7Z7CSJUt2Z/XMPTp2ytRtLE=;
 b=UzhoUjr6xn2EXEUBHChjogMuf3cMzof4qwA2PaNFN4J8oTRfrNhFp/wmOrkcX8pCm0XHqT
 UuvD22bVgOP7NFGdrn1nCoDyuCnegboYPsYjhU0P8CAw7TZsiGpYdG8vrbFQiegJnW7YFU
 tCCvru6+iLGnHuoNR1iPeUesUlydusQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-wWh6lHvHOleM0BrdCKsCAQ-1; Wed,
 15 Oct 2025 03:55:56 -0400
X-MC-Unique: wWh6lHvHOleM0BrdCKsCAQ-1
X-Mimecast-MFC-AGG-ID: wWh6lHvHOleM0BrdCKsCAQ_1760514954
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EAA81800BC1; Wed, 15 Oct 2025 07:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E3851800451; Wed, 15 Oct 2025 07:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C77B621E6A27; Wed, 15 Oct 2025 09:55:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 7/7] chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
In-Reply-To: <2df28aa4-d979-4659-a1ca-33d9cba94fb1@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 15 Oct 2025 10:11:16 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-8-vsementsov@yandex-team.ru>
 <87tt00irg0.fsf@pond.sub.org>
 <2df28aa4-d979-4659-a1ca-33d9cba94fb1@yandex-team.ru>
Date: Wed, 15 Oct 2025 09:55:50 +0200
Message-ID: <87ldlcfvjt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> On 15.10.25 09:56, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> For further vhost-user-blk backend-transfer migration realization we
>>> want to give it (vhost-user-blk) a possibility (and responsibility) to
>>> decide when do connect.
>>>
>>> For incoming migration we'll need to postpone connect at least until
>>> early stage of migrate-incoming command, when we already know all
>>> migration parameters and can decide, are we going to do incoming
>>> backend-transfer (and get chardev fd from incoming stream), or we
>>> finally need to connect.
>>>
>>> With this patch, we only provide new macro, to define chardev property,
>>> later it will be used in vhost-user-blk instead of DEFINE_PROP_CHR.
>>
>> There is no "later" in this series.
>> The new macro is called DEFINE_PROP_CHR_NO_CONNECT().
>> 
>>> Then, vhost-user-blk will call qemu_chr_connect() by hand when needed
>>> (for example through qemu_chr_fe_wait_connected(), which is already
>>> called in vhost_user_blk_realize_connect()).
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>> Excuse my quick & ignorant questions...
>>
>> I understand ChardevClass provides either methods init() and connect(),
>> or method open().
>>
>> Is a ChardevClass providing open() usable with
>> DEFINE_PROP_CHR_NO_CONNECT()?
>
> Good question. It's usable, but it will work like simple DEFINE_PROP_CHR.
> I should improve it somehow. Better is to fail than go unexpected way.
>
>> Is a ChardevClass providing init() and connect() usable with
>> DEFINE_PROP_CHR()?
>
> Yes, and works correctly.
>
>> Could the code do the right thing based on presence of open() vs. init()
>> and connect() instead of DEFINE_PROP_CHR()
>> vs. DEFINE_PROP_CHR_NO_CONNECT()?
>> 
>
> No, because, the frontend should be prepared to work with new _NO_CONNECT (e.g.,
> call _connect() by hand when needed). There are a lot of frontends, which
> expect already connected backend, updating them all would be big (and
> unnecessary) work.

QMP command

    {"execute": "qom-list-types", "arguments": {"implements": "chardev"}}

shows me 23 subtypes of "chardev".  Could miss a few not in this build.

Converting them all would be work.  It's not a prohibitive amount of
work, though.  Whether it's worth our while is not for me to judge.


