Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913CFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 04:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3q4d-0008Bc-MR; Mon, 06 May 2024 00:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3q4O-0008Ah-PN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:35:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3q4L-0007er-Lk
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714970114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/IrMaIZ7x3lgENYc9ugl9JIbOOi1yXjgWO0ZkwOSlCU=;
 b=SJfoY/rpGu8+AEoUB6bJLw/a0fdu0GlNWkiJ1ww0Pd0csdlx2tiPhkAsFVBn9NkQgIzOyw
 rfoZGesfQ8oUSq5LCdVvjnyVlL+QXwdn8CczPC7ldO/OeijEmlxrmCyU/gtANS7EemdrcB
 /oK/X3FQFEAGincdganobEHE4fn3FoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-y0HFMy22Ml-aqudyjiL9ig-1; Mon, 06 May 2024 00:35:09 -0400
X-MC-Unique: y0HFMy22Ml-aqudyjiL9ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E4F1800CA2;
 Mon,  6 May 2024 04:35:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF337210FD25;
 Mon,  6 May 2024 04:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0153621E6680; Mon,  6 May 2024 06:35:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Joao Martins <joao.m.martins@oracle.com>,  Maor
 Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
In-Reply-To: <3d6438e0-550e-4f66-8932-45191ff64b8b@nvidia.com> (Avihai Horon's
 message of "Sun, 5 May 2024 10:48:01 +0300")
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
 <87msp88nrg.fsf@pond.sub.org>
 <3d6438e0-550e-4f66-8932-45191ff64b8b@nvidia.com>
Date: Mon, 06 May 2024 06:35:07 +0200
Message-ID: <871q6ftv5w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avihai Horon <avihaih@nvidia.com> writes:

> On 02/05/2024 14:19, Markus Armbruster wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Avihai Horon <avihaih@nvidia.com> writes:
>>
>>> Add a new QAPI event for VFIO device migration state change. This event
>>> will be emitted when a VFIO device changes its migration state, for
>>> example, during migration or when stopping/starting the guest.
>>>
>>> This event can be used by management applications to get updates on the
>>> current state of the VFIO device for their own purposes.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>
>> Can you explain briefly why this event makes sense only for VFIO devices?
>
> VFIO devices have their own protocol for migration and a unique set of migration states.
> This event holds info about these VFIO migration states, which I think cannot be described in the same accuracy by other events such as run state or migration states.

Would it make sense to work this into the commit message?

[...]


