Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EA2C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFK5-0002TW-AX; Tue, 08 Jul 2025 16:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZEHM-0007yr-SX
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZEHJ-0007Cn-3Y
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752004014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PXEUJaJoLOcFk5/zGLBDJcNh/IQkmnqiwNrVd3lV9k=;
 b=bDh4gOAnoX7NdPPgSVANPCKT7g3+Dm3j7hfFXokuAl0aNPMDtGItlCBmDx0lIcJKs3l5lV
 gP/Wr4MZlyEoAOrP+Fla4cbS1gYK0hhM+EqULjRLXZ4VYPTn6juaWwdipeO6usz9qUqeiq
 YUsViSyxHMUn+DVa8RbNbh0PG44kQvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-1RbpygK8PECPSqVj3kRgoA-1; Tue,
 08 Jul 2025 04:17:46 -0400
X-MC-Unique: 1RbpygK8PECPSqVj3kRgoA-1
X-Mimecast-MFC-AGG-ID: 1RbpygK8PECPSqVj3kRgoA_1751962665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 124D1185BD44; Tue,  8 Jul 2025 08:17:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F800195E765; Tue,  8 Jul 2025 08:17:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6F9421E6A27; Tue, 08 Jul 2025 10:17:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  qemu-devel@nongnu.org,
 eperezma@redhat.com,  peterx@redhat.com,  mst@redhat.com,
 lvivier@redhat.com,  dtatulea@nvidia.com,  leiyang@redhat.com,
 parav@mellanox.com,  sgarzare@redhat.com,  lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com,  Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <face37ee-9850-448f-914b-cd90a39d3451@oracle.com> (Jonah Palmer's
 message of "Mon, 7 Jul 2025 09:21:36 -0400")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
 <87o6uau2lj.fsf@pond.sub.org>
 <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com>
 <87frfcj904.fsf@pond.sub.org>
 <face37ee-9850-448f-914b-cd90a39d3451@oracle.com>
Date: Tue, 08 Jul 2025 10:17:33 +0200
Message-ID: <874ivnxfj6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Jonah Palmer <jonah.palmer@oracle.com> writes:

> On 7/4/25 11:00 AM, Markus Armbruster wrote:
>> Jonah Palmer <jonah.palmer@oracle.com> writes:

[...]

>> So, total time increases: early pinning (before main loop) takes more
>> time than we save pinning (in the main loop).  Correct?
>
> Correct. We only save ~0.07s from the pinning that happens in the main loop. But the extra 3s we now need to spend pinning before qemu_main_loop() overshadows it.

Got it.

>> We want this trade, because the time spent in the main loop is a
>> problem: guest-visible downtime.  Correct?
>> [...]
>
> Correct. Though whether or not we want this trade I suppose is subjective. But the 50-60% reduction in guest-visible downtime is pretty nice if we can stomach the initial startup costs.

I'll get back to this at the end.

[...]

>> Let me circle back to my question: Under what circumstances is QMP
>> responsiveness affected?
>> 
>> The answer seems to be "only when we're using a vhost-vDPA device".
>> Correct?
>
> Correct, since using one of these guys causes us to do this memory pinning. If we're not using one, it's business as usual for Qemu.

Got it.

>> We're using one exactly when QEMU is running with one of its
>> vhost-vdpa-device-pci* device models.  Correct?
>
> Yea, or something like:
>
> -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,... \
> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,... \

I'll get back to this at the end.

[...]

>> Let me recap:
>> 
>> * No change at all unless we're pinning memory early, and we're doing
>>    that only when we're using a vhost-vDPA device.  Correct?
>> 
>> * If we are using a vhost-vDPA device:
>>    - Total startup time (until we're done pinning) increases.
>
> Correct.
>
>>    - QMP becomes available later.
>
> Correct.
>
>>    - Main loop behavior improves: less guest-visible downtime, QMP more
>>      responsive (once it's available)
>
> Correct. Though the improvement is modest at best if we put aside the guest-visible downtime improvement.
>
>>    This is a tradeoff we want always.  There is no need to let users pick
>>    "faster startup, worse main loop behavior."
>> 
>
> "Always" might be subjective here. For example, if there's no desire to perform live migration, then the user kinda just gets stuck with the cons.
>
> Whether or not we want to make this configurable though is another discussion.
>
>> Correct?
>> 
>> [...]

I think I finally know enough to give you constructive feedback.

Your commit messages should answer the questions I had.  Specifically:

* Why are we doing this?  To shorten guest-visible downtime.

* How are we doing this?  We additionally pin memory before entering the
  main loop.  This speeds up the pinning we still do in the main loop.

* Drawback: slower startup.  In particular, QMP becomes
  available later.

* Secondary benefit: main loop responsiveness improves, in particular
  QMP.

* What uses of QEMU are affected?  Only with vhost-vDPA.  Spell out all
  the ways to get vhost-vDPA, please.

* There's a tradeoff.  Show your numbers.  Discuss whether this needs to
  be configurable.

If you can make a case for pinning memory this way always, do so.  If
you believe making it configurable would be a good idea, do so.  If
you're not sure, say so in the cover letter, and add a suitable TODO
comment.

Questions?


