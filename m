Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D18C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 05:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZjsw-0000Xq-0g; Thu, 10 Jul 2025 01:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZjse-0000Up-Rp
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 01:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZjsY-0007aa-2M
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 01:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752125488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=489ojv2XPS0VBvvpj3mZRJIjnGi5tzYd+qBFkgsD6H0=;
 b=KPUr0h7br7fuVpupEemf27XGHSM0ecrO4A8uqVjWGProNl6RIWX7qH72MWGruEjy+6+kov
 srex/EMchQS9EENKoBNfj+da2krHqI8wMrRqsjir9ndTyS91Q2DBvptq0DhOyYJOD5tTyE
 W6J1P2oXuS1tMxIef0dYptOzN9+00Kk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-iQvU18BCNFSs-LWodQzX6w-1; Thu,
 10 Jul 2025 01:31:27 -0400
X-MC-Unique: iQvU18BCNFSs-LWodQzX6w-1
X-Mimecast-MFC-AGG-ID: iQvU18BCNFSs-LWodQzX6w_1752125485
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5293E1956077; Thu, 10 Jul 2025 05:31:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9DD1180035C; Thu, 10 Jul 2025 05:31:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E255421E6A27; Thu, 10 Jul 2025 07:31:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  qemu-devel@nongnu.org,
 eperezma@redhat.com,  peterx@redhat.com,  mst@redhat.com,
 lvivier@redhat.com,  dtatulea@nvidia.com,  leiyang@redhat.com,
 parav@mellanox.com,  sgarzare@redhat.com,  lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com,  Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <71ae1a0a-a697-4199-ab57-426f6252e224@oracle.com> (Jonah Palmer's
 message of "Wed, 9 Jul 2025 15:57:52 -0400")
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
 <874ivnxfj6.fsf@pond.sub.org>
 <71ae1a0a-a697-4199-ab57-426f6252e224@oracle.com>
Date: Thu, 10 Jul 2025 07:31:21 +0200
Message-ID: <87ikk0ipcm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jonah Palmer <jonah.palmer@oracle.com> writes:

[...]

>> I think I finally know enough to give you constructive feedback.
>> 
>> Your commit messages should answer the questions I had.  Specifically:
>> 
>> * Why are we doing this?  To shorten guest-visible downtime.
>> 
>> * How are we doing this?  We additionally pin memory before entering the
>>   main loop.  This speeds up the pinning we still do in the main loop.
>> 
>> * Drawback: slower startup.  In particular, QMP becomes
>>   available later.
>> 
>> * Secondary benefit: main loop responsiveness improves, in particular
>>   QMP.
>> 
>> * What uses of QEMU are affected?  Only with vhost-vDPA.  Spell out all
>>    the ways to get vhost-vDPA, please.
>> 
>> * There's a tradeoff.  Show your numbers.  Discuss whether this needs to
>>   be configurable.
>> 
>> If you can make a case for pinning memory this way always, do so.  If
>> you believe making it configurable would be a good idea, do so.  If
>> you're not sure, say so in the cover letter, and add a suitable TODO
>> comment.
>> 
>> Questions?
>
> No questions, understood.
>
> As I was writing the responses to your questions I was thinking to 
> myself that this stuff should've been in the cover letter / commit 
> messages in the first place.
>
> Definitely a learning moment for me. Thanks for your time on this Markus!

You're welcome!


