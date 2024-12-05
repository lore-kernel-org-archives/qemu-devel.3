Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E86BE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJApk-0000lk-5t; Thu, 05 Dec 2024 07:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJApi-0000kf-PH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJApg-0000YV-RM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733401186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3S0PrECbr/RY4aa+yiO56EwlH1b4a4Uh9YSU8HMfEMQ=;
 b=EzIFcNjDOEUjUOA/NHuDrbJ3K8EL8JoSgHEM/D33QheDhqRY1hh/RzLtjh5BA1MGNaK439
 Kep2Jk4wmvLm3TQS9W5HgaDO/x467gyKSYHQOoJN7nv9m3W1Nx79h56Mu1MdrI8BSzRyrn
 Qe3WRGOQB9VQzOpq9R/aBp/gKuGxxKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-CGYuqSrDP8yxDTrslbUAfA-1; Thu,
 05 Dec 2024 07:19:43 -0500
X-MC-Unique: CGYuqSrDP8yxDTrslbUAfA-1
X-Mimecast-MFC-AGG-ID: CGYuqSrDP8yxDTrslbUAfA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 397BA1956054; Thu,  5 Dec 2024 12:19:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7B1F3000197; Thu,  5 Dec 2024 12:19:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92D0E21E681F; Thu,  5 Dec 2024 13:19:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
In-Reply-To: <87v7vyfi2u.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 05 Dec 2024 13:08:25 +0100")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 <87v7vyfi2u.fsf@pond.sub.org>
Date: Thu, 05 Dec 2024 13:19:39 +0100
Message-ID: <87ikryfhk4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Steve Sistare <steven.sistare@oracle.com> writes:
>
>> Allocate auxilliary guest RAM as an anonymous file that is shareable
>> with an external process.  This option applies to memory allocated as
>> a side effect of creating various devices. It does not apply to
>> memory-backend-objects, whether explicitly specified on the command
>> line, or implicitly created by the -m command line option.
>>
>> This option is intended to support new migration modes, in which the
>> memory region can be transferred in place to a new QEMU process, by sending
>> the memfd file descriptor to the process.  Memory contents are preserved,
>> and if the mode also transfers device descriptors, then pages that are
>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> [...]
>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index dacc979..02b9118 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>>      "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>>      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>> +#ifdef CONFIG_POSIX
>> +    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
>> +#endif
>>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>>      QEMU_ARCH_ALL)
>> @@ -101,6 +104,18 @@ SRST
>>          Enables or disables ACPI Heterogeneous Memory Attribute Table
>>          (HMAT) support. The default is off.
>>  
>> +#ifdef CONFIG_POSIX
>> +    ``aux-ram-share=on|off``
>> +        Allocate auxiliary guest RAM as an anonymous file that is
>> +        shareable with an external process.  This option applies to
>> +        memory allocated as a side effect of creating various devices.
>> +        It does not apply to memory-backend-objects, whether explicitly
>> +        specified on the command line, or implicitly created by the -m
>> +        command line option.
>> +
>> +        Some migration modes require aux-ram-share=on.
>> +#endif
>> +
>
> I get
>
>     Warning, treated as error:
>     .../qemu-options.hx:117:Definition list ends without a blank line; unexpected unindent.
>
> Putting the blank line before #endif works for me.

Actually, #ifdef does not work within SRST ... ERST.

Elsewhere, we document build-time optional features unconditionally.
Simply drop the #ifdef here.

>>      ``memory-backend='id'``
>>          An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
>>          Allows to use a memory backend as main RAM.
>
> [...]


