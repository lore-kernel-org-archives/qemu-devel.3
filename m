Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D337FC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 04:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWpLT-0007Y0-Mm; Wed, 02 Jul 2025 00:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpLQ-0007Xc-5r
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:45:16 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uWpLM-00030d-Up
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 00:45:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DC66FA52C3F;
 Wed,  2 Jul 2025 04:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22885C4CEEF;
 Wed,  2 Jul 2025 04:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751431509;
 bh=8q+C0ZDihNqVoISkP9duHWUHu55CQiD0OGV+slkfXcc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UQ5v7z7FujTyxqRZMx8LpXN6V1wjaQUkXVz8AdwyYmqrXnLml65EQT1ltjUzmLNVv
 DWBmX1/PclR1EbT1UOxy7nlyiLuUqpjfuM9kgveNBIcBc2tsJevFazwNiV2xjEznKN
 GY27kROrgTWqp7c2W2TG6Im8PPUtmAAtaSOD7OrdCUUTsT+LiuQC0PBXm8V0IDNnAL
 7xjpkme52pD3Na9NPj4l+QGfdO1/Uzw+CFKLA9BLgfIr7BWAbj+zXg9VXBjECzG/sl
 TSkJKkIlGnxtqbgY0cGt6YkgjDXbQl4tPmR5uhL1tktNOX2CSXczJ0VlcdELSS69uA
 IWQBQYz8cCumA==
Date: Wed, 2 Jul 2025 04:45:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 08/27] accel/mshv: Initialize VM partition
Message-ID: <aGS5U-jMUFVnpMpd@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-9-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701172834.44849-9-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jul 01, 2025 at 07:28:15PM +0200, Magnus Kulke wrote:
> Create the MSHV virtual machine by opening a partition and issuing
> the necessary ioctl to initialize it. This sets up the basic VM
> structure and initial configuration used by MSHV to manage guest state.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c        | 210 ++++++++++++++++++++++++++++++++++-
>  accel/mshv/trace-events      |   3 +
>  accel/mshv/trace.h           |   1 +
>  include/system/mshv.h        |  20 +++-
>  meson.build                  |   1 +
>  target/i386/mshv/meson.build |   1 +
>  target/i386/mshv/mshv-cpu.c  |  71 ++++++++++++
>  7 files changed, 300 insertions(+), 7 deletions(-)
>  create mode 100644 accel/mshv/trace-events
>  create mode 100644 accel/mshv/trace.h
>  create mode 100644 target/i386/mshv/mshv-cpu.c
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 9e0590c4f9..712e651627 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -46,8 +46,177 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
>  
>  bool mshv_allowed;
>  
> -MshvState *mshv_state;
> +MshvState *mshv_state = NULL;

This is not needed. Global variables are initialized to zero by default.

>  
> +static int init_mshv(int *mshv_fd)
> +{
> +    int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
> +    if (fd < 0) {
> +        error_report("Failed to open /dev/mshv: %s", strerror(errno));
> +        return -1;
> +    }
> +	*mshv_fd = fd;
> +	return 0;

Tabs here.

> +}
> +
> +/* freeze 1 to pause, 0 to resume */
> +static int set_time_freeze(int vm_fd, int freeze)
> +{
> +    int ret;
> +
> +    if (freeze != 0 && freeze != 1) {
> +        error_report("Invalid time freeze value");
> +        return -1;
> +    }
> +

This is a static function. You know all callers already, so you can
dro the check here.

> +    struct hv_input_set_partition_property in = {0};
> +    in.property_code = HV_PARTITION_PROPERTY_TIME_FREEZE;
> +    in.property_value = freeze;
> +
> +    struct mshv_root_hvcall args = {0};
> +    args.code = HVCALL_SET_PARTITION_PROPERTY;
> +    args.in_sz = sizeof(in);
> +    args.in_ptr = (uint64_t)&in;
> +
> +    ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to set time freeze");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
[...]
>  typedef struct MshvState {
> -    AccelState parent_obj;
> -    int vm;
> -    MshvMemoryListener memory_listener;
> -    /* number of listeners */
> -    int nr_as;
> -    MshvAddressSpace *as;
> +	AccelState parent_obj;
> +	int vm;
> +	MshvMemoryListener memory_listener;
> +	/* number of listeners */
> +	int nr_as;
> +	MshvAddressSpace *as;

Unnecessary changes due to tabs.

> +    int fd;
>  } MshvState;
>  extern MshvState *mshv_state;

Wei

