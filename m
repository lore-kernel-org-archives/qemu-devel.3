Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05141C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0Di-0007cX-Vb; Mon, 02 Jun 2025 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM0Dh-0007cF-CG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM0Dd-0008CC-Kr
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748851707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bUpC5LIZy7c8/oWUe4OiVU3Gk97eiqh6K84Ta7iy1Y=;
 b=IDGO8V/upMSE/39rfsSaEzd9XPDwL2uf9WLdA65b98NzhsB+7+bjXFumHZN5QIYET2UpC1
 s2GjH60kuetQvCkkxQsmbam6ZMdAtjCqmIftXGe+vkRrLoUwINkVyV6gUEoeZPwWLsYpWZ
 K82Qr1bcM1e1GboS0ejbyF/I/axhk5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-Kv1n7RTkOy2GJhK_0Ikm9A-1; Mon,
 02 Jun 2025 04:08:24 -0400
X-MC-Unique: Kv1n7RTkOy2GJhK_0Ikm9A-1
X-Mimecast-MFC-AGG-ID: Kv1n7RTkOy2GJhK_0Ikm9A_1748851702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8992D1956086; Mon,  2 Jun 2025 08:08:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D46861800368; Mon,  2 Jun 2025 08:08:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6728621E66C3; Mon, 02 Jun 2025 10:08:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  Jonah Palmer
 <jonah.palmer@oracle.com>,  qemu-devel@nongnu.org,  eperezma@redhat.com,
 peterx@redhat.com,  mst@redhat.com,  lvivier@redhat.com,
 dtatulea@nvidia.com,  leiyang@redhat.com,  parav@mellanox.com,
 sgarzare@redhat.com,  lingshan.zhu@intel.com,  boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com> (Si-Wei Liu's
 message of "Thu, 29 May 2025 00:57:30 -0700")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
Date: Mon, 02 Jun 2025 10:08:19 +0200
Message-ID: <87o6v6muq4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On 5/26/2025 2:16 AM, Markus Armbruster wrote:
>> Si-Wei Liu <si-wei.liu@oracle.com> writes:
>>
>>> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>>>> Jason Wang <jasowang@redhat.com> writes:
>>>>
>>>>> On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@ora=
cle.com> wrote:
>>>>>> Current memory operations like pinning may take a lot of time at the
>>>>>> destination.  Currently they are done after the source of the migrat=
ion is
>>>>>> stopped, and before the workload is resumed at the destination.  Thi=
s is a
>>>>>> period where neigher traffic can flow, nor the VM workload can conti=
nue
>>>>>> (downtime).
>>>>>>
>>>>>> We can do better as we know the memory layout of the guest RAM at the
>>>>>> destination from the moment that all devices are initializaed.  So
>>>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>>>> while the workload is still running in the source, so Linux can start
>>>>>> mapping them.
>>>>>>
>>>>>> As a small drawback, there is a time in the initialization where QEMU
>>>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>>>> 0.2seconds.
>>>>> Adding Markus to see if this is a real problem or not.
>>>> I guess the answer is "depends", and to get a more useful one, we need
>>>> more information.
>>>>
>>>> When all you care is time from executing qemu-system-FOO to guest
>>>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>>>> won't matter much.
>>>
>>> There's no such delay of an extra 0.2s or higher per se, it's just shif=
ting around the page pinning hiccup, no matter it is 0.2s or something else=
, from the time of guest booting up to before guest is booted. This saves b=
ack guest boot time or start up delay, but in turn the same delay effective=
ly will be charged to VM launch time. We follow the same model with VFIO, w=
hich would see the same hiccup during launch (at an early stage where no re=
al mgmt software would care about).
>>>
>>>> When a management application runs qemu-system-FOO several times to
>>>> probe its capabilities via QMP, then even milliseconds can hurt.
>>>>
>>> Not something like that, this page pinning hiccup is one time only that=
 occurs in the very early stage when launching QEMU, i.e. there's no consis=
tent delay every time when QMP is called. The delay in QMP response at that=
 very point depends on how much memory the VM has, but this is just specif =
to VM with VFIO or vDPA devices that have to pin memory for DMA. Having sai=
d, there's no extra delay at all if QEMU args has no vDPA device assignment=
, on the other hand, there's same delay or QMP hiccup when VFIO is around i=
n QEMU args.
>>>
>>>> In what scenarios exactly is QMP delayed?
>>>
>>> Having said, this is not a new problem to QEMU in particular, this QMP =
delay is not peculiar, it's existent on VFIO as well.
>>
>> In what scenarios exactly is QMP delayed compared to before the patch?
>
> The page pinning process now runs in a pretty early phase at
> qemu_init() e.g. machine_run_board_init(),

It runs within

    qemu_init()
        qmp_x_exit_preconfig()
            qemu_init_board()
                machine_run_board_init()

Except when --preconfig is given, it instead runs within QMP command
x-exit-preconfig.

Correct?

> before any QMP command can be serviced, the latter of which typically
> would be able to get run from qemu_main_loop() until the AIO gets
> chance to be started to get polled and dispatched to bh.

We create the QMP monitor within qemu_create_late_backends(), which runs
before qmp_x_exit_preconfig(), but commands get processed only in the
main loop, which we enter later.

Correct?

> Technically it's not a real delay for specific QMP command, but rather
> an extended span of initialization process may take place before the
> very first QMP request, usually qmp_capabilities, will be
> serviced. It's natural for mgmt software to expect initialization
> delay for the first qmp_capabilities response if it has to immediately
> issue one after launching qemu, especially when you have a large guest
> with hundred GBs of memory and with passthrough device that has to pin
> memory for DMA e.g. VFIO, the delayed effect from the QEMU
> initialization process is very visible too.



>                                             On the other hand, before
> the patch, if memory happens to be in the middle of being pinned, any
> ongoing QMP can't be serviced by the QEMU main loop, either.
>
> I'd also like to highlight that without this patch, the pretty high
> delay due to page pinning is even visible to the guest in addition to
> just QMP delay, which largely affected guest boot time with vDPA
> device already. It is long standing, and every VM user with vDPA
> device would like to avoid such high delay for the first boot, which
> is not seen with similar device e.g. VFIO passthrough.
>
>>
>>> Thanks,
>>> -Siwei
>>>
>>>> You told us an absolute delay you observed.  What's the relative delay,
>>>> i.e. what's the delay with and without these patches?
>>
>> Can you answer this question?
>
> I thought I already got that answered in earlier reply. The relative
> delay is subject to the size of memory. Usually mgmt software won't be
> able to notice, unless the guest has more than 100GB of THP memory to
> pin, for DMA or whatever reason.
>
>
>>
>>>> We need QMP to become available earlier in the startup sequence for
>>>> other reasons.  Could we bypass the delay that way?  Please understand
>>>> that this would likely be quite difficult: we know from experience that
>>>> messing with the startup sequence is prone to introduce subtle
>>>> compatility breaks and even bugs.
>>>>
>>>>> (I remember VFIO has some optimization in the speed of the pinning,
>>>>> could vDPA do the same?)
>>>>
>>>> That's well outside my bailiwick :)
>
> Please be understood that any possible optimization is out of scope of
> this patch series, while there's certainly way around that already and
> to be carry out in the future, as Peter alluded to in earlier
> discussion thread:
>
> https://lore.kernel.org/qemu-devel/ZZT7wuq-_IhfN_wR@x1n/
> https://lore.kernel.org/qemu-devel/ZZZUNsOVxxqr-H5S@x1n/
>
> Thanks,
> -Siwei
>
>>>>
>>>> [...]
>>>>


