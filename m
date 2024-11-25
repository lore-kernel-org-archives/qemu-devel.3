Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D11D58062
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWt6-0008Do-PQ; Mon, 25 Nov 2024 06:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFWt4-0008AD-Tw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFWt2-0007TZ-7G
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732532650;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gi7ElT6tWExl4Bp1bOqkYkXyXXF4Mj7bhc2dUqiJxSw=;
 b=P6AFWcdiTXT2FJ/vj3CudBTpdAZhPEUtr2CW8asKoCyEkjlW6SQLFLiEzFLF40HGybIFj6
 qfwwj5GnOW+XByX88F/p4wZlic8Nz57BI4z4pC8jx6Ipj2AX4BG2YyafEVPtagVbSx6KI1
 QMZBwHKeYU8ZU9nUDvx4r/KZz/xJtk0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284--zFnrxdjO0GJoe-FW9ZB5A-1; Mon,
 25 Nov 2024 06:04:06 -0500
X-MC-Unique: -zFnrxdjO0GJoe-FW9ZB5A-1
X-Mimecast-MFC-AGG-ID: -zFnrxdjO0GJoe-FW9ZB5A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E7A31956089; Mon, 25 Nov 2024 11:04:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D2571955F40; Mon, 25 Nov 2024 11:03:57 +0000 (UTC)
Date: Mon, 25 Nov 2024 11:03:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC PATCH for-10.0] include/hw/boards: Optimize the booleans in
 MachineClass
Message-ID: <Z0RZmfjJmaHsfmWy@redhat.com>
References: <20241122084923.1542743-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122084923.1542743-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 22, 2024 at 09:49:23AM +0100, Thomas Huth wrote:
> While looking at the QEMU binary with "pahole", I noticed that we
> could optimize the size of MachineClass a little bit: So far we
> are using a mixture of a bitfield and single "bool" members here
> for the boolean flags. Declaring all flags as part of the bitfield
> helps to shrink the size of the struct a little bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  It's just a micro-optimization (the size of the struct decreases by
>  eight bytes), so I'm not sure whether it's worth the effort...?

Given that this is a QOM class, rather than an instance, we'll
only ever save memory once. That's an unmeasurably small real
world improvement. We also have no ABI reasons to use bitfields
for this.

So if anything I'd suggest we take the opposite approach, and
eliminate that bitfields in favour of just using 'bool' for
everything, on the basis that a bitfield has no reason to
exist.

This could become useful if we aim to institute a general ban
on the use of bitfields in QEMU, as a way to avoid the struct
packing differences on Windows.

>  include/hw/boards.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 36fbb9b59d..c6946bd319 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -285,8 +285,16 @@ struct MachineClass {
>          no_cdrom:1,
>          no_sdcard:1,
>          pci_allow_0_address:1,
> -        legacy_fw_cfg_order:1;
> -    bool is_default;
> +        legacy_fw_cfg_order:1,
> +        is_default:1,
> +        auto_enable_numa_with_memhp:1,
> +        auto_enable_numa_with_memdev:1,
> +        ignore_boot_device_suffixes:1,
> +        smbus_no_migration_support:1,
> +        nvdimm_supported:1,
> +        numa_mem_supported:1,
> +        auto_enable_numa:1,
> +        cpu_cluster_has_numa_boundary:1;
>      const char *default_machine_opts;
>      const char *default_boot_order;
>      const char *default_display;
> @@ -304,14 +312,6 @@ struct MachineClass {
>      int numa_mem_align_shift;
>      const char * const *valid_cpu_types;
>      strList *allowed_dynamic_sysbus_devices;
> -    bool auto_enable_numa_with_memhp;
> -    bool auto_enable_numa_with_memdev;
> -    bool ignore_boot_device_suffixes;
> -    bool smbus_no_migration_support;
> -    bool nvdimm_supported;
> -    bool numa_mem_supported;
> -    bool auto_enable_numa;
> -    bool cpu_cluster_has_numa_boundary;
>      SMPCompatProps smp_props;
>      const char *default_ram_id;
>  
> -- 
> 2.47.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


