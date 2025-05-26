Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265E7C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTxB-0007hU-Gu; Mon, 26 May 2025 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJTwq-0007ao-4Q
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJTwo-0002B3-0p
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748251000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/nly/qMJ+0+UJI4bd1qWVRcyddHc8dlfjTlrYVD9Bw=;
 b=Z2f7mUgYBsQ7GK6OhtHiW9uVe0bbZ3gGcwUuohmtTfk36zA801HguEAciFn3ATMRvZM2eT
 izKTKto5s7tsGTmthcVadoV9pGofoEhirRVW5oOT5T63cDTp2X3+nEkzCAYWcMPbJZ8ecK
 nndveWkJB8MnyhOsRN+g0j/gP0kEkHE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-qOnVj3BVMo-J-1fGJBbLJg-1; Mon,
 26 May 2025 05:16:36 -0400
X-MC-Unique: qOnVj3BVMo-J-1fGJBbLJg-1
X-Mimecast-MFC-AGG-ID: qOnVj3BVMo-J-1fGJBbLJg_1748250994
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB55180048E; Mon, 26 May 2025 09:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E81618003FD; Mon, 26 May 2025 09:16:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B375921E66C3; Mon, 26 May 2025 11:16:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  Jonah Palmer
 <jonah.palmer@oracle.com>,  qemu-devel@nongnu.org,  eperezma@redhat.com,
 peterx@redhat.com,  mst@redhat.com,  lvivier@redhat.com,
 dtatulea@nvidia.com,  leiyang@redhat.com,  parav@mellanox.com,
 sgarzare@redhat.com,  lingshan.zhu@intel.com,  boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com> (Si-Wei Liu's
 message of "Fri, 16 May 2025 12:09:42 -0700")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
Date: Mon, 26 May 2025 11:16:31 +0200
Message-ID: <87frgr7mvk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Si-Wei Liu <si-wei.liu@oracle.com> writes:

> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>> Jason Wang <jasowang@redhat.com> writes:
>>
>>> On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
>>>> Current memory operations like pinning may take a lot of time at the
>>>> destination.  Currently they are done after the source of the migratio=
n is
>>>> stopped, and before the workload is resumed at the destination.  This =
is a
>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>> (downtime).
>>>>
>>>> We can do better as we know the memory layout of the guest RAM at the
>>>> destination from the moment that all devices are initializaed.  So
>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>> while the workload is still running in the source, so Linux can start
>>>> mapping them.
>>>>
>>>> As a small drawback, there is a time in the initialization where QEMU
>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>> 0.2seconds.
>>>
>>> Adding Markus to see if this is a real problem or not.
>>
>> I guess the answer is "depends", and to get a more useful one, we need
>> more information.
>>
>> When all you care is time from executing qemu-system-FOO to guest
>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>> won't matter much.
>
> There's no such delay of an extra 0.2s or higher per se, it's just shifti=
ng around the page pinning hiccup, no matter it is 0.2s or something else, =
from the time of guest booting up to before guest is booted. This saves bac=
k guest boot time or start up delay, but in turn the same delay effectively=
 will be charged to VM launch time. We follow the same model with VFIO, whi=
ch would see the same hiccup during launch (at an early stage where no real=
 mgmt software would care about).
>
>> When a management application runs qemu-system-FOO several times to
>> probe its capabilities via QMP, then even milliseconds can hurt.
>>
> Not something like that, this page pinning hiccup is one time only that o=
ccurs in the very early stage when launching QEMU, i.e. there's no consiste=
nt delay every time when QMP is called. The delay in QMP response at that v=
ery point depends on how much memory the VM has, but this is just specif to=
 VM with VFIO or vDPA devices that have to pin memory for DMA. Having said,=
 there's no extra delay at all if QEMU args has no vDPA device assignment, =
on the other hand, there's same delay or QMP hiccup when VFIO is around in =
QEMU args.
>
>> In what scenarios exactly is QMP delayed?
>
> Having said, this is not a new problem to QEMU in particular, this QMP de=
lay is not peculiar, it's existent on VFIO as well.

In what scenarios exactly is QMP delayed compared to before the patch?

> Thanks,
> -Siwei
>
>>
>> You told us an absolute delay you observed.  What's the relative delay,
>> i.e. what's the delay with and without these patches?

Can you answer this question?

>> We need QMP to become available earlier in the startup sequence for
>> other reasons.  Could we bypass the delay that way?  Please understand
>> that this would likely be quite difficult: we know from experience that
>> messing with the startup sequence is prone to introduce subtle
>> compatility breaks and even bugs.
>>
>>> (I remember VFIO has some optimization in the speed of the pinning,
>>> could vDPA do the same?)
>>
>> That's well outside my bailiwick :)
>>
>> [...]
>>


