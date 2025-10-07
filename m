Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737E7CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v665c-0008Mi-TP; Tue, 07 Oct 2025 07:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v665b-0008MD-7E
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v665T-0008V3-AZ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759837350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=76+8Crx9Wb4rjK3yDdJE9XdAx9LS4KN7k6AV1VWA5xU=;
 b=PLZ3fbccafP7BnecApH+lap8MK/lIDZEO4dD493OADNU+MfiJSc/u4dCRftfylW2X3d1G7
 eLic2NFSbnXiy0lVVdAXYU64Ptej3LHpBf4ME3M3O/GaetepPc9Lz8Z0tpZi7EGRi7EdRa
 2zfVqVaL24tm2NUx7gFaeRjNdqAQTfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-km7Ltt9nPYuQAr2WF2i9KA-1; Tue,
 07 Oct 2025 07:42:27 -0400
X-MC-Unique: km7Ltt9nPYuQAr2WF2i9KA-1
X-Mimecast-MFC-AGG-ID: km7Ltt9nPYuQAr2WF2i9KA_1759837346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DD2719560AE; Tue,  7 Oct 2025 11:42:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12EE21800578; Tue,  7 Oct 2025 11:42:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 50CCD21E6A27; Tue, 07 Oct 2025 13:42:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  qemu-devel@nongnu.org,  philmd@linaro.org,
 thuth@redhat.com,  eblake@redhat.com,  michael.roth@amd.com,
 farosas@suse.de,  peterx@redhat.com,  berrange@redhat.com,
 jasowang@redhat.com,  steven.sistare@oracle.com,  leiyang@redhat.com,
 davydov-max@yandex-team.ru,  yc-core@yandex-team.ru
Subject: Re: [PATCH v6 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
In-Reply-To: <cea1ebb9-2a14-486b-a016-2378c4b4ffa4@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 7 Oct 2025 11:57:41 +0300")
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-17-vsementsov@yandex-team.ru>
 <87v7kskvut.fsf@pond.sub.org>
 <cea1ebb9-2a14-486b-a016-2378c4b4ffa4@yandex-team.ru>
Date: Tue, 07 Oct 2025 13:42:21 +0200
Message-ID: <87jz17q6oy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 06.10.25 16:23, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> To migrate virtio-net TAP device backend (including open fds) locally,
>>> user should simply set migration parameter
>>>
>>>     backend-transfer = ["virtio-net-tap"]
>>>
>>> Why not simple boolean? To simplify migration to further versions,
>>> when more devices will support backend-transfer migration.
>>>
>>> Alternatively, we may add per-device option to disable backend-transfer
>>> migration, but still:
>>>
>>> 1. It's more comfortable to set same capabilities/parameters on both
>>> source and target QEMU, than care about each device.
>>>
>>> 2. To not break the design, that machine-type + device options +
>>> migration capabilities and parameters are fully define the resulting
>>> migration stream. We'll break this if add in future more
>>> backend-transfer support in devices under same backend-transfer=true
>>> parameter.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>> diff --git a/migration/options.h b/migration/options.h
>>> index 82d839709e..55c0345433 100644
>>> --- a/migration/options.h
>>> +++ b/migration/options.h
>>> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>>>  uint64_t migrate_xbzrle_cache_size(void);
>>>  ZeroPageDetection migrate_zero_page_detection(void);
>>>   
>>> +bool migrate_virtio_net_tap(void);
>>> +
>>>  /* parameters helpers */
>>>   
>>>   bool migrate_params_check(MigrationParameters *params, Error **errp);
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 2387c21e9c..e39785dc07 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -747,6 +747,18 @@
>>>        '*transform': 'BitmapMigrationBitmapAliasTransform'
>>>    } }
>>>   
>>> +##
>>> +# @BackendTransfer:
>>> +#
>>> +# @virtio-net-tap: Enable backend-transfer migration for virtio-net/tap. When
>>> +#     enabled, TAP fds and all related state is passed to target QEMU through
>>> +#     migration channel (which should be unix socket).
>> 
>> Suggest "are passed to the destination in the migration channel" and
>> "should be a UNIX domain socket".
>> 
>> docs/devel/qapi-code-gen.rst:
>> 
>>      For legibility, wrap text paragraphs so every line is at most 70
>>      characters long.
>> 
>>      Separate sentences with two spaces.
>
> Ok. We do lack this check in checkpatch

Would be nice, yes.

>>> +#
>>> +# Since: 10.2
>>> +##
>>> +{ 'enum': 'BackendTransfer',
>>> +  'data': [ 'virtio-net-tap' ] }
>>> +
>>>  ##
>>>  # @BitmapMigrationNodeAlias:
>>>  #
>>> @@ -924,10 +936,14 @@
>>>  #     only has effect if the @mapped-ram capability is enabled.
>>>  #     (Since 9.1)
>>>  #
>>> +# @backend-transfer: List of targets to enable backend-transfer
>>> +#     migration for. This requires migration channel to be a unix
>>> +#     socket (to pass fds through). (Since 10.2)
>> 
>> Elsewhere, we describe the same restriction like this:
>> 
>>                                           This CPR channel must support
>>    #     file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>    #     UNIX domain socket.
>> 
>
> Thanks, I'll copy this phrasing to be consistent.
>
>>> +#
>>>  # Features:
>>>  #
>>> -# @unstable: Members @x-checkpoint-delay and
>>> -#     @x-vcpu-dirty-limit-period are experimental.
>>> +# @unstable: Members @x-checkpoint-delay,
>>> +#     @x-vcpu-dirty-limit-period and @backend-transfer are experimental.
>> 
>> List members in alphabetical order, please.
>> 
>>>  #
>>>  # Since: 2.4
>>>  ##
>>> @@ -950,7 +966,8 @@
>>>              'vcpu-dirty-limit',
>>>              'mode',
>>>              'zero-page-detection',
>>> -           'direct-io'] }
>>> +           'direct-io',
>>> +           'backend-transfer' ] }
>> 
>> Forgot feature 'unstable'?
>
> Opps. Interesting, how it compiles? Usually, inconsistencies between
> QAPI comments and definitions are hardly checked.

You found a gap in the checking.

[...]


