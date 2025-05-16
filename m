Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3714C3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 06:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFokY-0002BS-C1; Fri, 16 May 2025 02:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFokV-00027P-JH
 for qemu-devel@nongnu.org; Fri, 16 May 2025 02:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFokT-00013g-LE
 for qemu-devel@nongnu.org; Fri, 16 May 2025 02:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747377646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAmhHmFlZKbm4zG8jtbPKw1B29lR39Ah9dOo5LrB7NA=;
 b=BI++ymuVV53IxrLSWYl8avypdxHoEfl1JmmSBTpjtc6/ErhXod1IkrHf1AxG3k2kjG+WC8
 DUEKQ693ptrdF6U6Xam6WZ2OXwAzF/kYT1WL6ZSbc+GA29IhI3AOcsGr7WFuR3CF+hBuuW
 8/id+7q0WDKgWvgy13SABoD4QFnxlQs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-lVFSiy_XPoqHHw0TH6-28w-1; Fri,
 16 May 2025 02:40:42 -0400
X-MC-Unique: lVFSiy_XPoqHHw0TH6-28w-1
X-Mimecast-MFC-AGG-ID: lVFSiy_XPoqHHw0TH6-28w_1747377641
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09E6519560B1; Fri, 16 May 2025 06:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E2AE195608D; Fri, 16 May 2025 06:40:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD31A21E66E3; Fri, 16 May 2025 08:40:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>,  qemu-devel@nongnu.org,
 eperezma@redhat.com,  peterx@redhat.com,  mst@redhat.com,
 lvivier@redhat.com,  dtatulea@nvidia.com,  leiyang@redhat.com,
 parav@mellanox.com,  sgarzare@redhat.com,  si-wei.liu@oracle.com,
 lingshan.zhu@intel.com,  boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 (Jason Wang's message of "Fri, 16 May 2025 09:51:00 +0800")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
Date: Fri, 16 May 2025 08:40:37 +0200
Message-ID: <87plg9ukgq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Jason Wang <jasowang@redhat.com> writes:

> On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>>
>> Current memory operations like pinning may take a lot of time at the
>> destination.  Currently they are done after the source of the migration =
is
>> stopped, and before the workload is resumed at the destination.  This is=
 a
>> period where neigher traffic can flow, nor the VM workload can continue
>> (downtime).
>>
>> We can do better as we know the memory layout of the guest RAM at the
>> destination from the moment that all devices are initializaed.  So
>> moving that operation allows QEMU to communicate the kernel the maps
>> while the workload is still running in the source, so Linux can start
>> mapping them.
>>
>> As a small drawback, there is a time in the initialization where QEMU
>> cannot respond to QMP etc.  By some testing, this time is about
>> 0.2seconds.
>
> Adding Markus to see if this is a real problem or not.

I guess the answer is "depends", and to get a more useful one, we need
more information.

When all you care is time from executing qemu-system-FOO to guest
finish booting, and the guest takes 10s to boot, then an extra 0.2s
won't matter much.

When a management application runs qemu-system-FOO several times to
probe its capabilities via QMP, then even milliseconds can hurt.

In what scenarios exactly is QMP delayed?

You told us an absolute delay you observed.  What's the relative delay,
i.e. what's the delay with and without these patches?

We need QMP to become available earlier in the startup sequence for
other reasons.  Could we bypass the delay that way?  Please understand
that this would likely be quite difficult: we know from experience that
messing with the startup sequence is prone to introduce subtle
compatility breaks and even bugs.

> (I remember VFIO has some optimization in the speed of the pinning,
> could vDPA do the same?)

That's well outside my bailiwick :)

[...]


