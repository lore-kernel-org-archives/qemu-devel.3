Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B395C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSJ1-0003JP-H1; Tue, 20 May 2025 15:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHSIz-0003Hb-8i
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:07:13 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHSIw-00089k-Rz
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:07:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4300449F5F;
 Tue, 20 May 2025 19:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FB5C4CEE9;
 Tue, 20 May 2025 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747768028;
 bh=/ttkvxK3YWZha+cg5ICtPxg3cYJZPLDZfSM+VXz1VKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BI5yvxfuRFbb+uXdgZ4gHtLCWi5UTcSvPS1pN381vCdGhkFDvk08xoxPVi8aZIuWy
 R5h+OGKQhCCDOUGuv4i47+3mrYDJiwsvKWu63Jx73JPMghVToRlbfE4oI0b3eufrvu
 v9wDE7os3qHdHNxe8tduysvDdF+dfEQiXgFQNHCnVQ1CjV2gD/iVkOk9oVP5w3Qm3w
 TFH8xvMpAbSYZIDFeqIo59O5heGhF2TLJmLzym03YPF0U4IYmx4ZXtBOzJ3K3QlbGf
 BzooKG80du1NYUMX4bx48df7/Au0X/ZSUyNect8nydPctLZA3vvOGtws+JNzOWqEW0
 kXsU+mW55pZTA==
Date: Tue, 20 May 2025 19:07:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Message-ID: <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> Create the MSHV virtual machine by opening a partition and issuing
> the necessary ioctl to initialize it. This sets up the basic VM
> structure and initial configuration used by MSHV to manage guest state.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 63b0eca1fc..95f1008a48 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -48,6 +48,178 @@ bool mshv_allowed;
>  
>  MshvState *mshv_state;
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
> +static int pause_vm(int vm_fd)

I feel like the name of this function and its counter part is too broad.
Pausing the VM to me means not only freezing the time, but also making
sure VCPUs are no longer scheduled, all I/O are quiescent.

This is not blocking. Luckily we can always change the name later.

> +{
> +    int ret;
> +
> +    ret = set_time_freeze(vm_fd, 1);
> +    if (ret < 0) {
> +        error_report("Failed to pause partition: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int resume_vm(int vm_fd)
> +{
[...]
> +
> +static int create_vm(int mshv_fd)
> +{
> +    int vm_fd;
> +
> +    int ret = create_partition(mshv_fd, &vm_fd);
> +    if (ret < 0) {
> +        close(mshv_fd);

No please don't close it here. This fd is not created by this function.

> +        return -errno;
> +    }
> +
> +    ret = set_synthetic_proc_features(vm_fd);
> +    if (ret < 0) {
> +        return -errno;
> +    }
> +
> +    ret = initialize_vm(vm_fd);
> +    if (ret < 0) {
> +        return -1;
> +    }
> +
> +    ret = mshv_arch_post_init_vm(vm_fd);
> +    if (ret < 0) {
> +        return -1;
> +    }
> +
> +    /* Always create a frozen partition */
> +    pause_vm(vm_fd);
> +
> +    return vm_fd;
> +}
>  
>  static void mem_region_add(MemoryListener *listener,
>                             MemoryRegionSection *section)
> @@ -96,22 +268,54 @@ static void register_mshv_memory_listener(MshvState *s, MshvMemoryListener *mml,
>          }
>      }
>  }
> +static void mshv_reset(void *param)
> +{
> +    warn_report("mshv reset");

What's missing for this hook?

> +}
> +
> +int mshv_hvcall(int mshv_fd, const struct mshv_root_hvcall *args)

Please be consistent and change mshv_fd to vm_fd.

> +{
> +    int ret = 0;
> +
> +    ret = ioctl(mshv_fd, MSHV_ROOT_HVCALL, args);
> +    if (ret < 0) {
> +        error_report("Failed to perform hvcall: %s", strerror(errno));
> +        return -1;
> +    }
> +    return ret;
> +}
>  
>  
>  static int mshv_init(MachineState *ms)
>  {
>      MshvState *s;
> +    int mshv_fd, ret;
> +
>      s = MSHV_STATE(ms->accelerator);
>  
>      accel_blocker_init();
>  
>      s->vm = 0;
>  
> +    ret = init_mshv(&mshv_fd);
> +    if (ret < 0) {
> +        return -1;
> +    }
> +
> +    do {
> +        int vm_fd = create_vm(mshv_fd);
> +        s->vm = vm_fd;
> +    } while (!s->vm);
> +

This loop doesn't make sense to me. The create_vm function doesn't
return 0 as "try again".

> +    resume_vm(s->vm);
> +

mshv_fd is neither stashed into a state structure nor freed after this
point.  Is it leaked?

Thanks,
Wei.

>      s->nr_as = 1;
>      s->as = g_new0(MshvAddressSpace, s->nr_as);
>  
>      mshv_state = s;
>  
> +    qemu_register_reset(mshv_reset, NULL);
> +
>      register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
>                                    0, "mshv-memory");
>      memory_listener_register(&mshv_io_listener, &address_space_io);

