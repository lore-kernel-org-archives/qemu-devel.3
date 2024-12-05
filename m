Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6226E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ7B9-0001vP-NW; Thu, 05 Dec 2024 03:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJ7B7-0001ut-GU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJ7B5-0007Ef-Su
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733387137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1xn8iZBaLbuNsrD9/fBIbkbW/LFhfvi+btN/FRdYZ8=;
 b=Ntb5C6ny0aDyerokuTQPEjFJvcd1V9XtePC027GnI60ymvTX39E8MvdqEEi0VXHr98XU76
 MJjVyzJV7vOoVDEi5nz6ptIQjxoSU5jTzXpZ1MW9e4T80Kjy1BnZ2esRYQSj+FLac7sncD
 ut44OPjeyMsX5+BuF+q6P4zQn7nGGs4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-0SECbkCYM9a7NAOCD4BiIA-1; Thu,
 05 Dec 2024 03:25:33 -0500
X-MC-Unique: 0SECbkCYM9a7NAOCD4BiIA-1
X-Mimecast-MFC-AGG-ID: 0SECbkCYM9a7NAOCD4BiIA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AE2019560B3; Thu,  5 Dec 2024 08:25:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E431C1956054; Thu,  5 Dec 2024 08:25:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96C3D21E66CD; Thu,  5 Dec 2024 09:25:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
In-Reply-To: <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 2 Dec 2024 05:19:56 -0800")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
Date: Thu, 05 Dec 2024 09:25:27 +0100
Message-ID: <87ikryh6yw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Allocate auxilliary guest RAM as an anonymous file that is shareable
> with an external process.  This option applies to memory allocated as
> a side effect of creating various devices. It does not apply to
> memory-backend-objects, whether explicitly specified on the command
> line, or implicitly created by the -m command line option.
>
> This option is intended to support new migration modes, in which the
> memory region can be transferred in place to a new QEMU process, by sending
> the memfd file descriptor to the process.  Memory contents are preserved,
> and if the mode also transfers device descriptors, then pages that are
> locked in memory for DMA remain locked.  This behavior is a pre-requisite
> for supporting vfio, vdpa, and iommufd devices with the new modes.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

> diff --git a/qemu-options.hx b/qemu-options.hx
> index dacc979..02b9118 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> +#ifdef CONFIG_POSIX
> +    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
> +#endif
>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>      QEMU_ARCH_ALL)
> @@ -101,6 +104,18 @@ SRST
>          Enables or disables ACPI Heterogeneous Memory Attribute Table
>          (HMAT) support. The default is off.
>  
> +#ifdef CONFIG_POSIX
> +    ``aux-ram-share=on|off``
> +        Allocate auxiliary guest RAM as an anonymous file that is
> +        shareable with an external process.  This option applies to
> +        memory allocated as a side effect of creating various devices.
> +        It does not apply to memory-backend-objects, whether explicitly
> +        specified on the command line, or implicitly created by the -m
> +        command line option.
> +
> +        Some migration modes require aux-ram-share=on.

This leaves the one thing users really need to know unsaid: when exactly
should users enable it.

"Some migration modes require aux-ram-share=on": do they enable it by
default, or is that left to the user?  If the latter, why?

Please document the default, whatever it is.

> +#endif
> +
>      ``memory-backend='id'``
>          An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
>          Allows to use a memory backend as main RAM.

[...]


