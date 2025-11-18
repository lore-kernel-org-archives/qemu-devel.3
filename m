Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEBBCED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 05:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLEXN-0007SS-IF; Tue, 18 Nov 2025 00:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLEXK-0007Qt-Ux
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLEXH-0007xP-Nv
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763444749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QIey1evpGwk590ZWrlsxF2PPuT93keXOXvXAVejk/pg=;
 b=AimOBys5OPiyAV8Qm4pv0UKO5MIeUzpMkJPaDyDHPqHq/gszIMlyenJfcCMEDrLjJ06lNM
 6KxBfKODJJN9bVAzGl4RQvGhkKMvs9Oj7duNrScwif1naLdYbBEPbA3bqOUwL2sCJQOmJe
 DBnnFKuSIWTkLakJubs7dFlcHJV+QrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-ccwVu4JvOH-sJTPqTjVckw-1; Tue,
 18 Nov 2025 00:45:45 -0500
X-MC-Unique: ccwVu4JvOH-sJTPqTjVckw-1
X-Mimecast-MFC-AGG-ID: ccwVu4JvOH-sJTPqTjVckw_1763444744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 415FC1956096; Tue, 18 Nov 2025 05:45:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A99E019560A7; Tue, 18 Nov 2025 05:45:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E064821E6A27; Tue, 18 Nov 2025 06:45:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Honglei Huang <honghuan@amd.com>,  alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp,  mst@redhat.com,  cohuck@redhat.com,
 pbonzini@redhat.com,  qemu-devel@nongnu.org,  Ray.Huang@amd.com
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
In-Reply-To: <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com> (Dmitry
 Osipenko's message of "Tue, 18 Nov 2025 04:48:23 +0300")
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
Date: Tue, 18 Nov 2025 06:45:40 +0100
Message-ID: <874iqrnbaz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 11/17/25 16:22, Markus Armbruster wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>> 
>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>>> index ed5ae52acb..ea2928b706 100644
>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>>  
>>>>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>>>                                          cmd, NULL, &res->iov, &res->iov_cnt);
>>>> -    CHECK(!ret, cmd);
>>>> +    CHECK(ret >= 0, cmd);
>>>
>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>> see how this change improves anything. You now saying that ret > 0 is
>>> okay, while it shall never happen.
>> 
>> Please see
>> 
>>     Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in virgl_cmd_resource_create_blob 
>>     Date: Mon, 17 Nov 2025 08:49:42 +0100
>>     Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>     https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>
> It's a rather common bug when errno isn't negated by mistake and a
> positive error code is returned. Ignoring positive values when they
> aren't expected opens door to unnecessary problems, IMO.

No convention can avoid *all* possible problems there.  I know which one
has created more grief for *me*.  Your experience may be different.

virtio_gpu_create_mapping_iov() returns -1 on error, 0 on success.
We could change it to return false on error, true on success.


