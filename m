Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233FAEB28D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voFus-0005O1-9i; Fri, 06 Feb 2026 02:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voFup-0005Hh-Rc
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voFum-00067m-Qx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770361562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JmzUQ7QKPFZ4SPz5eboQokKM+bAxKpQJeacZJwjtv0=;
 b=g/RE0ZvcWhHZ3bNf8isduLuuLkasTWNzNSdlusL1unNzaXnw+K7LOghiO7xbte1DtxIWlx
 KFIalZG+bA+xxht7gesYWIle5g1KRHQ3dYRJKXpIlkyCK9aKqDs/yyNFvaCkU5hS9eAZxY
 RU5043eYxwScebHjuAQ2/fXu8U1fYzY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-JfGEhah7NseidB5CIFVNWg-1; Fri,
 06 Feb 2026 02:05:47 -0500
X-MC-Unique: JfGEhah7NseidB5CIFVNWg-1
X-Mimecast-MFC-AGG-ID: JfGEhah7NseidB5CIFVNWg_1770361546
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27341956089; Fri,  6 Feb 2026 07:05:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31D6B19373D8; Fri,  6 Feb 2026 07:05:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B462121E692D; Fri, 06 Feb 2026 08:05:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Honglei Huang <honghuan@amd.com>,  alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
 qemu-devel@nongnu.org,  Ray.Huang@amd.com,  qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [v6 0/2] virtio-gpu: fix error handling and improve consistency
In-Reply-To: <39541134-0c64-439c-b270-22e59dcbe994@tls.msk.ru> (Michael
 Tokarev's message of "Fri, 6 Feb 2026 01:07:07 +0300")
References: <20260113015203.3643608-1-honghuan@amd.com>
 <39541134-0c64-439c-b270-22e59dcbe994@tls.msk.ru>
Date: Fri, 06 Feb 2026 08:05:41 +0100
Message-ID: <874inuxsfu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 1/13/26 04:52, Honglei Huang wrote:
>> This series addresses error handling issues in virtio-gpu and improves
>> code consistency across the virtio-gpu subsystem.
>> The first patch fixes a critical bug in virgl_cmd_resource_create_blob()
>> where an inverted error check causes the function to fail when it should
>> succeed. This is a standalone bug fix that should be backported.
>> The second patch improves code consistency by unifying the error checking
>> style for virtio_gpu_create_mapping_iov() in if-statement contexts across
>> virtio-gpu files, following the preferred QEMU coding convention.
>> Changes since v5:
>> - Reverted changes to virtio-gpu-rutabaga.c to keep CHECK macro usage
>>    consistent with other error checks in the same file
>> - Updated patch 2 commit message to clarify that CHECK macro patterns
>>    in rutabaga.c are intentionally left unchanged
>> Changes since v4:
>> - Split the single patch into two separate patches for better clarity
>> - Separated the critical bug fix from the style consistency improvements
>> - The bug fix (patch 1) can now be easily identified and backported
>> - The consistency improvements (patch 2) are clearly marked as cleanup
>> Changes since v3:
>> - Extended consistency improvements to virtio-gpu-rutabaga.c
>> - Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
>>    CHECK(result >= 0) in rutabaga functions for consistency
>> - Now covers all virtio-gpu files that use virtio_gpu_create_mapping_iov()
>> Changes since v2:
>> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>>    feedback on preferred QEMU coding style for error checking functions
>>    that return 0 on success and negative on error
>> - Updated all similar usages across virtio-gpu files for consistency
>> - Expanded scope from single function fix to codebase-wide style consistency
>> Honglei Huang (2):
>>    virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
>>    virtio-gpu: use consistent error checking for
>>      virtio_gpu_create_mapping_iov
>>   hw/display/virtio-gpu-virgl.c | 4 ++--
>>   hw/display/virtio-gpu.c       | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>> 
> Is this a qemu-stable material?  I'm a bit confused here.  The first
> patch looks like it is, the second I can't decide.
>
> Please let me know if I should pick this up for qemu-stable or not.
> For now I'm picking up the first change.

I think that's fine.


