Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB19CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 05:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHF2B-0005S6-RV; Fri, 07 Nov 2025 00:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHF1v-0005NY-2D
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 00:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHF1s-0002Mi-BG
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 00:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762493334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Udek/+NhnnxfGQTPckglFAvbIW8E9dBndmGo8Mq+TiM=;
 b=BSXu+CNi3DkiWIn9ZNmU6XsNsm6enxKCg+/BET2PnVM/XZ8fM2Z/fV8p1I7vkT0OEMZC4B
 fPySOYrG1IgZSzDdVEu5w6hEwLuxmUXhrdKDZ7GZqPl/R8BhbU8TnweiqDY93CcH8j1djO
 UqBzHOSu9XBb0krSeYc2RAEOUeKRSJE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-P360yNThM8yoYVxR-wmIzQ-1; Fri,
 07 Nov 2025 00:28:51 -0500
X-MC-Unique: P360yNThM8yoYVxR-wmIzQ-1
X-Mimecast-MFC-AGG-ID: P360yNThM8yoYVxR-wmIzQ_1762493329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7888C1956067; Fri,  7 Nov 2025 05:28:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9D081800451; Fri,  7 Nov 2025 05:28:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4646121E6A27; Fri, 07 Nov 2025 06:28:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  jasowang@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  peterx@redhat.com,
 farosas@suse.de,  eblake@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  zhao1.liu@intel.com,  qemu-devel@nongnu.org,
 leiyang@redhat.com,  davydov-max@yandex-team.ru,  yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v9 2/8] qapi: introduce query-backend-transfer-support
In-Reply-To: <75cd160f-2f70-4522-aaa0-6e8a2a3b7c01@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 6 Nov 2025 22:27:36 +0300")
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
 <20251030203116.870742-3-vsementsov@yandex-team.ru>
 <87jz03fab2.fsf@pond.sub.org>
 <75cd160f-2f70-4522-aaa0-6e8a2a3b7c01@yandex-team.ru>
Date: Fri, 07 Nov 2025 06:28:44 +0100
Message-ID: <87cy5ue7hv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

> On 06.11.25 18:30, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> We are going to implement backend-transfer feature: some devices
>>> will be able to transfer their backend through migration stream
>>> for local migration through UNIX domain socket. For example,
>>> virtio-net will migrate its attached TAP netdev, with all its
>>> connected file descriptors.
>>>
>>> Let's add a command to list supporting devices (no one for now),
>>> together with necessary infrastructure in qdev code.
>>
>> Use case?
>
> Will add:
>
> With this command management tool can query such lists on source and
> target, and get intersection of them, to now the set of devices, for
> which we can enable backend-transfer for given source and target QEMUs.

I like it.  Would it make sense to add something similar to QAPI schema
doc comments?

[...]


