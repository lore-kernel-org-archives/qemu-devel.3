Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB32CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5mMb-0000J1-7P; Mon, 06 Oct 2025 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5mMX-0000IP-TL
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5mMQ-0005vY-LM
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759761519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=id32b6E5CHy3+VImQOCaafclOiYny7pkAzCH7qyeMyU=;
 b=jVqIcpY2RpEI1oP1CInS6lfYr66//vkSjs2UD4Nd6GiBYC6j7pmem6yewywnEypvUe1Prb
 JtCDms/O6WZeldiCS7GlFyTHV4uBB5+t/gxd/o6FFcnKAW88HVlKCIJ4kfylPPTzS5OAK5
 YBtYTruqzCGijqgtdMMwpijEFTXBxA4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-2Dltu2KGOcix_w2lBt6eBw-1; Mon,
 06 Oct 2025 10:38:38 -0400
X-MC-Unique: 2Dltu2KGOcix_w2lBt6eBw-1
X-Mimecast-MFC-AGG-ID: 2Dltu2KGOcix_w2lBt6eBw_1759761516
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D56891800451; Mon,  6 Oct 2025 14:38:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC2FD1956056; Mon,  6 Oct 2025 14:38:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A1CA21E6A27; Mon, 06 Oct 2025 16:38:32 +0200 (CEST)
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
In-Reply-To: <20251006092735-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Mon, 6 Oct 2025 09:33:28 -0400")
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-17-vsementsov@yandex-team.ru>
 <87v7kskvut.fsf@pond.sub.org>
 <20251006092735-mutt-send-email-mst@kernel.org>
Date: Mon, 06 Oct 2025 16:38:32 +0200
Message-ID: <878qhoksd3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> On Mon, Oct 06, 2025 at 03:23:06PM +0200, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>> > To migrate virtio-net TAP device backend (including open fds) locally,
>> > user should simply set migration parameter
>> >
>> >    backend-transfer = ["virtio-net-tap"]
>> >
>> > Why not simple boolean? To simplify migration to further versions,
>> > when more devices will support backend-transfer migration.
>> >
>> > Alternatively, we may add per-device option to disable backend-transfer
>> > migration, but still:
>> >
>> > 1. It's more comfortable to set same capabilities/parameters on both
>> > source and target QEMU, than care about each device.
>> >
>> > 2. To not break the design, that machine-type + device options +
>> > migration capabilities and parameters are fully define the resulting
>> > migration stream. We'll break this if add in future more
>> > backend-transfer support in devices under same backend-transfer=true
>> > parameter.
>> >
>> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> > ---
>> >  include/qapi/util.h | 17 ++++++++++++++++
>> >  migration/options.c | 32 ++++++++++++++++++++++++++++++
>> >  migration/options.h |  2 ++
>> >  qapi/migration.json | 47 ++++++++++++++++++++++++++++++++++++---------
>> >  4 files changed, 89 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/include/qapi/util.h b/include/qapi/util.h
>> > index 29bc4eb865..b953402416 100644
>> > --- a/include/qapi/util.h
>> > +++ b/include/qapi/util.h
>> > @@ -69,4 +69,21 @@ int parse_qapi_name(const char *name, bool complete);
>> >          _len;                                                       \
>> >      })
>> >  
>> > +/*
>> > + * For any GenericList @list, return true if it contains specified
>> > + * element.
>> > + */
>> > +#define QAPI_LIST_CONTAINS(list, el)                                \
>> > +    ({                                                              \
>> > +        bool _found = false;                                        \
>> > +        typeof_strip_qual(list) _tail;                              \
>> > +        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
>> > +            if (_tail->value == el) {                               \
>> > +                _found = true;                                      \
>> > +                break;                                              \
>> > +            }                                                       \
>> > +        }                                                           \
>> > +        _found;                                                     \
>> > +    })
>> > +
>> 
>> Not a fan of lengthy macros.
>> 
>> There's a single use below: migrate_virtio_net_tap().  I can't see
>> potential uses for such a search in existing code.
>
> However, QAPI_LIST_FOR_EACH can potentially be used to implement
> QAPI_LIST_LENGTH.
>
> #define QAPI_LIST_FOR_EACH(list, tail)                    \
>         for (tail = list; tail != NULL; tail = tail->next)
>
> and
>
> #define QAPI_LIST_LENGTH(list)                                      \
>     ({                                                              \
>         size_t _len = 0;                                            \
>         typeof_strip_qual(list) _tail;                              \
>         QAPI_LIST_FOR_EACH(list, tail) {                            \
>             _len++;                                                 \
>         }                                                           \
>         _len;                                                       \
>     })

Yes, but would QAPI_LIST_FOR_EACH be better than the straightfoward &
simple for-loop?

[...]


