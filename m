Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F7BC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmagR-0004TB-DR; Mon, 24 Feb 2025 10:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmagM-0004Rg-Gm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmagJ-0008PV-GN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740412061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tR8pxWpzprSygwJkljGxUMlwMi9Y+PIqp8zbW2yLLUg=;
 b=flfc5yhagUyehavc7DB2DwQqxGtaEa/NWxErBdPB4Q3Sp+pd8j9SeEFq8mp9INRo9FE5F2
 +sTb6CDcNQRF4Ug6NVHEOgQuWjgz8gr7zk2F/572suz/CfPg/+Os5BPJlZKQfFVPylvz0I
 k/xr8HzFUEjniZ/RYofzPst1U8VAq/8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-7awcnkxdNkKYHgmTpHCLZw-1; Mon,
 24 Feb 2025 10:47:36 -0500
X-MC-Unique: 7awcnkxdNkKYHgmTpHCLZw-1
X-Mimecast-MFC-AGG-ID: 7awcnkxdNkKYHgmTpHCLZw_1740412055
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C5218EAB3A; Mon, 24 Feb 2025 15:47:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50696300018D; Mon, 24 Feb 2025 15:47:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CCA2A1800098; Mon, 24 Feb 2025 16:47:31 +0100 (CET)
Date: Mon, 24 Feb 2025 16:47:31 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <xhprkjs2yj5yli65opi7md7gfylqxgdkiwap76stcxcx7jdpub@fauqiqm5giyi>
References: <20250214153443.159889-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214153443.159889-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 14, 2025 at 09:04:07PM +0530, Ani Sinha wrote:
> VM firmware update is a mechanism where the virtual machines can use their
> preferred and trusted firmware image in their execution environment without
> having to depend on a untrusted party to provide the firmware bundle. This is
> particularly useful for confidential virtual machines that are deployed in the
> cloud where the tenant and the cloud provider are two different entities. In
> this scenario, virtual machines can bring their own trusted firmware image
> bundled as a part of their filesystem (using UKIs for example[1]) and then use
> this hypervisor interface to update to their trusted firmware image. This also
> allows the guests to have a consistent measurements on the firmware image.

Works nicely for me.  Test case:
  https://kraxel.gitlab.io/uefi-tools-rs/seabios.efi

> +Fw-cfg Files
> +************
> +
> +Guests drive vmfwupdate through special ``fw-cfg`` files that control its flow
> +followed by a standard system reset operation. When vmfwupdate is available,
> +it provides the following ``fw-cfg`` files:
> +
> +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitmap of additional
> +* ``vmfwupdate/bios-size`` (``u64``) - Little Endian encoded size of the BIOS region.
> +* ``vmfwupdate/opaque`` (``4096 bytes``) - A 4 KiB buffer that survives the BIOS replacement
> +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is disabled.
> +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded guest physical address

This is out of sync with the actual code (vmfwupdate/bios-addr does not
exist there).

Also this adds five fw_cfg files.  Given that the number of fw_cfg files
we can have is limited I'm not convinced this is the best idea to move
forward.

Alternatives I see:

 (1) Place everything in a single fw_cfg file.  ramfb does this for
     example, the guest writes a struct with a bunch of values.

 (2) Go for a mmio register interface.  The EFI variable store I'm
     working on does this.  fw_cfg is used for hardware discovery,
     via etc/hardware-info file (which can carry entries for multiple
     devices).

See https://lore.kernel.org/qemu-devel/20250219071431.50626-2-kraxel@redhat.com/
and https://lore.kernel.org/qemu-devel/20250219071431.50626-21-kraxel@redhat.com/
(v4 has a double-free bug in patch #1 which will be fixed in v5 of the
series).

take care,
  Gerd


