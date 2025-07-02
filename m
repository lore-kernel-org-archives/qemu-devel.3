Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF15CC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWulL-0003Ri-HQ; Wed, 02 Jul 2025 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uWulI-0003PG-Iq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uWulG-0007Bm-KL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751452335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LQb5nTgBOAPOGtXpC8/7T3areirBPs5Gy5IkAVVVeI=;
 b=eLlOaPXIl4LkBa8MSrthAILyLRm4l37VzGTBSt+WjinyCGpoCAc0T5cNqw23cEWHax+E7N
 UgteT0rWEUFzHoAkOVAHc1vXztVKcS+XfIjJFQeSPj4ukVSgXaVgrcpjqnVFpeVinSLz1T
 TxGlZQscKTK8erq7aWS0C9oH5hBy5uE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-D4aZePgXN0O0-nFG7AE_sA-1; Wed,
 02 Jul 2025 06:32:11 -0400
X-MC-Unique: D4aZePgXN0O0-nFG7AE_sA-1
X-Mimecast-MFC-AGG-ID: D4aZePgXN0O0-nFG7AE_sA_1751452330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 941EB19560AD; Wed,  2 Jul 2025 10:32:09 +0000 (UTC)
Received: from localhost (dhcp-192-236.str.redhat.com [10.33.192.236])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAF40195608F; Wed,  2 Jul 2025 10:32:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, Phil
 Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Wei Liu
 <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu
 <liuwe@microsoft.com>, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus
 Armbruster <armbru@redhat.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/27] include/hw/hyperv: Add MSHV ABI header
 definitions
In-Reply-To: <aGUF28/7HAMwZEpU@example.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-6-magnuskulke@linux.microsoft.com>
 <8734bfq7n6.fsf@redhat.com> <aGUF28/7HAMwZEpU@example.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 02 Jul 2025 12:32:05 +0200
Message-ID: <87zfdmq3x6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 02 2025, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:

> On Wed, Jul 02, 2025 at 11:11:41AM +0200, Cornelia Huck wrote:
>> On Tue, Jul 01 2025, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
>> 
>> > Introduce headers for the Microsoft Hypervisor (MSHV) userspace ABI,
>> > including IOCTLs and structures used to interface with the hypervisor.
>> >
>> > These definitions are based on the upstream Linux MSHV interface and
>> > will be used by the MSHV accelerator backend in later patches.
>> >
>> > Note that for the time being the header `linux-mshv.h` is also being
>> > included to allow building on machines that do not ship the header yet.
>> > The header will be available in kernel 6.15 (at the time of writing
>> > we're at -rc6) we will probably drop it in later revisions of the
>> > patch set.
>> 
>> The right way to handle header updates is to split the linux-header
>> updates into a "dummy" update (that just adds the header) and replace
>> that patch with a proper header update once the changes hit Linux
>> mainline.
>> 
>
> Ah, that's right, the commit message is not accurate any more, I'll change
> it in the next revision. The driver has been released as part of 6.15.
>
> I was following Paolo's advice to include the headers in
> `linux-headers/linux` and add an entry to
> `scripts/update-linux-headers.sh`
>
> https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg04791.html
>
> I might not have completely understood the process though, do you
> suggest to run `update-linux-headers.sh` on a current kernel (the other
> headers seem to be updated from 6.16-rc*, so I assume the latest rc?)
> and include the resulting changes in a seperate commit?

Yes, if you need to use headers imported from Linux, you should add a
separate commit stating the release (rc) you used, and update *all* of
the headers. As you import a new header, I would update the script to
add the header in the same commit.

>
>> I have not looked at the contents of the series otherwise -- but if this
>> is a system header (and not something that defines the kernel<->vmm
>> interface), how do you make sure that your system has that installed?
>> Maybe I'm misunderstanding.
>> 
>
> The kernel header does define the ioctls and ABI for the driver, albeit not
> completely, some hyperv-specific types and defines are shipped as seperate
> `include/hw/hyperv` header files.

I would have hoped that the Linux header would be more complete, but we
have to work with what we get.


