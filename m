Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6930EEB107C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzU1-0001Vb-Ur; Tue, 10 Mar 2026 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzzTy-0001VK-OE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzzTw-00087H-7m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773158330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDcFndgyRHcEEIFW3vC0+IzBJgpzyzuoXT0o7j401UE=;
 b=G3COqgj48Agnnf5dvyVHPkgaEHGit2wnw7kEVBGNxHGfaj4awBPmf6EUPdkJXEfGK9ZG4N
 97s7/WZ6HgjWTlHTosfxEkNO4aTw7tDpUKaovk2jo4DlJadPSqiDm90/qANa8uBr0p/DAC
 YW73IU2bY35FACLryeyxa2w0Tvk6fHc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-2HKrOhyrPOKEEQ4z7gtPhA-1; Tue,
 10 Mar 2026 11:58:45 -0400
X-MC-Unique: 2HKrOhyrPOKEEQ4z7gtPhA-1
X-Mimecast-MFC-AGG-ID: 2HKrOhyrPOKEEQ4z7gtPhA_1773158323
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 006C519560B3; Tue, 10 Mar 2026 15:58:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5428F1954102; Tue, 10 Mar 2026 15:58:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB04421E6614; Tue, 10 Mar 2026 16:58:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  jasowang@redhat.com,
 mst@redhat.com,  thuth@redhat.com,  eblake@redhat.com,  farosas@suse.de,
 peterx@redhat.com,  zhao1.liu@intel.com,  wangyanan55@huawei.com,
 philmd@linaro.org,  marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com
Subject: Re: [PATCH v12 3/8] qapi: add local migration parameter
In-Reply-To: <76aff934-3740-4c95-9cd4-da458e7e29f7@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 10 Mar 2026 18:46:31 +0300")
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-4-vsementsov@yandex-team.ru>
 <87cy1biyeq.fsf@pond.sub.org>
 <f3ac4e30-60ee-42f6-99a8-d43f8e4c3587@yandex-team.ru>
 <87wlzjg14q.fsf@pond.sub.org>
 <76aff934-3740-4c95-9cd4-da458e7e29f7@yandex-team.ru>
Date: Tue, 10 Mar 2026 16:58:38 +0100
Message-ID: <87o6kvfzgx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On 10.03.26 18:22, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> On 10.03.26 16:53, Markus Armbruster wrote:

[...]

>>>> This needs polish.  Let me try.
>>>>
>>>>     # @local: Enable local migration for devices that support it.  Backend
>>>>     #     state and its file descriptors are then passed to the
>>>>     #     destination in the migration channel.  The migration channel
>>>>     #     must be a Unix domain socket.  Also needs to be enabled per
>>>>     #     device by setting device property "local" to true.
>>>
>>> As discussed in v11, we don't want to require neither concrete property name
>>> nor even the existence of such property, that why it was worded "may have an option".
>>>
>>> https://lore.kernel.org/qemu-devel/aZyS4UizvDq1Wnpq@x1.local/
>> Scratch "by setting ..." then, and maybe replace "also" by "usually".
>> 
>
> so,
>
>   # @local: Enable local migration for devices that support it.  Backend
>   #     state and its file descriptors are then passed to the

Perhaps "can then passed", to further emphasize the need for per device
enabling.

>   #     destination in the migration channel.  The migration channel
>   #     must be a Unix domain socket.  Usually needs to be enabled per
>   #     device.
>
>
> Sounds good to me. Will use it for v13, if no more comments.


