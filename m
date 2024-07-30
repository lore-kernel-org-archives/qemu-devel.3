Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0989DC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 07:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhiL-00009S-MI; Tue, 30 Jul 2024 03:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYhiK-00008U-4f; Tue, 30 Jul 2024 03:56:08 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYhiE-0007I6-2Y; Tue, 30 Jul 2024 03:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722326162; x=1753862162;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=iVM/lNIx9FLDzrJYFZIa7VB1NWYVO1TqB88lag6oSu4=;
 b=jzgjhr+4tZinSKNxDkjdPbF6M/7n+JJaqZeKQdlUObsZVww2d+o++kGv
 hVCmjW/92PkXwWTQd8d/KYbwyx+UYg4rf+QW+c7mbQOCImyBtl58ZkA1s
 N9iWSRaMdO/6aR6aW84YgnnwpjKLNzu0Xq0TH/jBQrX4JOQMO0W703MqX
 HAqo8iaFRtP9C6pXbwpp5vGgvlniSbxuPvDcJ94aaMfYxxiiV4zRFoRlM
 n3ku2MSL9T7QbBnbpKw3OScCQ7S8RTq9S7OGeTzVqGBow4xnrtOXXpraK
 s8qZC7JcJzaP7hCgMojO9+hXjeInBUqBjKGnyr8Ix8adNT0kvr7Noq6eB g==;
X-CSE-ConnectionGUID: HqeuuRFsQGynOOAqwB/ibg==
X-CSE-MsgGUID: 4RV1vAsRQG2kQKKRc6JV9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19967178"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="19967178"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 00:55:59 -0700
X-CSE-ConnectionGUID: Q2E2GV1PT1aKj92KyS1elw==
X-CSE-MsgGUID: 1+APfD/eRfyG89D5H4OylQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="58393322"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 30 Jul 2024 00:55:55 -0700
Date: Tue, 30 Jul 2024 16:11:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <ZqigPgTl7quJ553J@intel.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mauro,

On Mon, Jul 29, 2024 at 03:21:06PM +0200, Mauro Carvalho Chehab wrote:
> Date: Mon, 29 Jul 2024 15:21:06 +0200
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Subject: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
> X-Mailer: git-send-email 2.45.2
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a Generic Event Device (GED) as specified at
> ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> with HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the bios via ACPI APEI Generic Hardware Error Source (GHES).
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> [mchehab: use a define for the generic event pin number and do some cleanups]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  hw/arm/virt.c            | 14 ++++++++++++--
>  include/hw/arm/virt.h    |  1 +
>  include/hw/boards.h      |  1 +
>  4 files changed, 40 insertions(+), 6 deletions(-)

[snip]

> +static void virt_set_error(void)
> +{
> +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> +}
> +

[snip]

> +    mc->generic_error_device_notify = virt_set_error;

[snip]

> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 48ff6d8b93f7..991f99138e57 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -308,6 +308,7 @@ struct MachineClass {
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
>      uint64_t smbios_memory_device_size;
> +    void (*generic_error_device_notify)(void);

The name looks inconsistent with the style of other MachineClass virtual
methods. What about the name like "notify_xxx"? And pls add the comment
about this new method.

BTW, I found this method is called in generic_error_device_notify() of
Patch 6. And the mc->generic_error_device_notify() - as the virtual
metchod of MachineClass looks just to implement a hook, and it doesn't
seem to have anything to do with MachineClass/MachineState, so my
question is why do we need to add this method to MachineClass?

Could we maintain a notifier list in ghes.c and expose an interface
to allow arm code register a notifier? This eliminates the need to add
the ¡°notify¡± method to MachineClass.

Regards,
Zhao


