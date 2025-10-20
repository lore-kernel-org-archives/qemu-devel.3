Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB0CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoMX-0000kN-Au; Mon, 20 Oct 2025 07:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAoMG-0000dJ-BQ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAoMD-0002Ol-Ez
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760960838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4YGESw/ibqfxXTMzH0fkWaglNB4PRk7JXBNfrp+Bg0Q=;
 b=Vtkc9mQ/74OWVIWJRt3/avib0wQdGbdms0ND7qqtSkqqrI2w1RrIgl+aDZS/cf6N5YiTM2
 Sp1VDIZI6AGk3YAPn1o4N9/nQfsfDgwX13T/lvgDMgv38NK7s4Duhf+175pDV1r6qrHB3+
 xyaUp8L/HdWqOKqk0S9yYsyf8jPRjNw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-bo2_RdnyMWSXMjeEe820lA-1; Mon,
 20 Oct 2025 07:47:17 -0400
X-MC-Unique: bo2_RdnyMWSXMjeEe820lA-1
X-Mimecast-MFC-AGG-ID: bo2_RdnyMWSXMjeEe820lA_1760960836
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B22FE195609E; Mon, 20 Oct 2025 11:47:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D04FB1800451; Mon, 20 Oct 2025 11:47:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29A2821E6A27; Mon, 20 Oct 2025 13:47:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
In-Reply-To: <d6cf9c5e-52da-49b8-ba39-2909a00f28eb@yandex-team.ru> (Alexandr
 Moshkov's message of "Mon, 20 Oct 2025 15:34:03 +0500")
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <878qh599tc.fsf@pond.sub.org>
 <d6cf9c5e-52da-49b8-ba39-2909a00f28eb@yandex-team.ru>
Date: Mon, 20 Oct 2025 13:47:12 +0200
Message-ID: <87frbd6bi7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:

> Thanks for review!
>
> On 10/20/25 14:55, Markus Armbruster wrote:
>> Alexandr Moshkov<dtalexundeer@yandex-team.ru> writes:
>>
>>> In vhost_user_blk_stop() on incoming migration make force_stop = true,
>>> so GET_VRING_BASE will not be executed.
>>>
>>> Signed-off-by: Alexandr Moshkov<dtalexundeer@yandex-team.ru>
>> Your cover letter explains why this is useful.  Please work it into your
>> commit message.
>
> Ok
>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index be0f3fcc12..c9fea59515 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -517,9 +517,13 @@
>>>  #     each RAM page.  Requires a migration URI that supports seeking,
>>>  #     such as a file.  (since 9.0)
>>>  #
>>> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
>>> +#    region for vhost-user-blk.  (since 10.2)
>>> +#
>> Any guidance why and when users would want to enable it?
>>
>> Is it a good idea to have device-specific capabilities?
>
> Hmm, maybe it's better way to make a parameter for the vhost-user-blk instead of migration capability?
>
> What do you think?

I think this is a question for the migration maintainers :)

[...]


