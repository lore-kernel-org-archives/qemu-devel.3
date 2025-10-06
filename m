Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F0FCCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5og3-0005kZ-K7; Mon, 06 Oct 2025 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5ofy-0005ee-Hk
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5ofr-000170-4q
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759770409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JugOti6sGb/wwZTfygNWyCVaRtzwbXR3jna4M8QfqIc=;
 b=QZAYzGjzxgBpSedcTa6x13a3XnLjRxwEUE+TD7S3UuquXR5a9iUdAd23gGV3O3m299hG/p
 xWzkiQMXbmaiM4eAugHABasbZ4u7R2OaA0yZuyfb35qD4InK4X0Uv3bQMSmXPhQnJ3iBGw
 qDsUcunW931YsjYr18gdLRImGVm1UnI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-HO7ugVI5Moaxp6S3HUBtxA-1; Mon,
 06 Oct 2025 13:06:44 -0400
X-MC-Unique: HO7ugVI5Moaxp6S3HUBtxA-1
X-Mimecast-MFC-AGG-ID: HO7ugVI5Moaxp6S3HUBtxA_1759770402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 429E3195608E; Mon,  6 Oct 2025 17:06:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 181FD180035E; Mon,  6 Oct 2025 17:06:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7533821E6A27; Mon, 06 Oct 2025 19:06:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org,  philmd@linaro.org,  thuth@redhat.com,
 eblake@redhat.com,  michael.roth@amd.com,  farosas@suse.de,
 peterx@redhat.com,  berrange@redhat.com,  jasowang@redhat.com,
 steven.sistare@oracle.com,  leiyang@redhat.com,
 davydov-max@yandex-team.ru,  yc-core@yandex-team.ru
Subject: Re: [PATCH v6 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
In-Reply-To: <20251006105159-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Mon, 6 Oct 2025 10:55:31 -0400")
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-17-vsementsov@yandex-team.ru>
 <87v7kskvut.fsf@pond.sub.org>
 <20251006092735-mutt-send-email-mst@kernel.org>
 <878qhoksd3.fsf@pond.sub.org>
 <20251006105159-mutt-send-email-mst@kernel.org>
Date: Mon, 06 Oct 2025 19:06:38 +0200
Message-ID: <87ldloj6xt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Oct 06, 2025 at 04:38:32PM +0200, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > However, QAPI_LIST_FOR_EACH can potentially be used to implement
>> > QAPI_LIST_LENGTH.
>> >
>> > #define QAPI_LIST_FOR_EACH(list, tail)                    \
>> >         for (tail = list; tail != NULL; tail = tail->next)
>> >
>> > and
>> >
>> > #define QAPI_LIST_LENGTH(list)                                      \
>> >     ({                                                              \
>> >         size_t _len = 0;                                            \
>> >         typeof_strip_qual(list) _tail;                              \
>> >         QAPI_LIST_FOR_EACH(list, tail) {                            \
>> >             _len++;                                                 \
>> >         }                                                           \
>> >         _len;                                                       \
>> >     })
>> 
>> Yes, but would QAPI_LIST_FOR_EACH be better than the straightfoward &
>> simple for-loop?
>> 
>> [...]
>
> Well I don't really remember off hand how QAPI lists work so for me I'd
> have to otherwise go read the code to check this is the right way to
> walk this list.
>
> Which reminds me, why are these custom like this and not just QLIST?

Beats me, I inherited them :)

A linked list would not be my choice for representing JSON arrays.
Bigger fish to fry...


