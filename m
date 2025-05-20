Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60964C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 21:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHUrP-0007FZ-DL; Tue, 20 May 2025 17:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHUrO-0007FR-DF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:50:54 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHUrM-0005ej-KC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:50:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1AA455C5ACF;
 Tue, 20 May 2025 21:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D69C4CEE9;
 Tue, 20 May 2025 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747777849;
 bh=DOosrfF8fIjhWIinlekVAsETDayOVvwoUM1wsqQFXTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hilc0BRz+DI/c3qX58wOcoi8CKqlY3VUzj0yX1XCrU16dwvX6X+E2gj36htQCrm/D
 xkVDrYC1W77uE5AmXpKcWTZOMdzfKEhdxdh2eYIrYeRVbVBtWbkrivQg6WrE6ekVuZ
 SRVc114GRNsmSoS7T+tfeZW8SdoIjUscvma66BLDddUI/Hk1evrpXdDTHo57pw3Hlz
 gBKxunttr8+7MW2IsBrFt+BkduyNEtwir59qQFLDjwx8igpKd3QAHXUIIjJ8hPGdzV
 Z9AgQnpZ8tE+RNSk0bNrTq0kK4GBA4jCRDf5I6jJspBuM4J1Huz83s/Gjn1C+wfNTL
 72GYSM8K2ybzg==
Date: Tue, 20 May 2025 21:50:48 +0000
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
Subject: Re: [RFC PATCH 14/25] target/i386/mshv: Add CPU create and remove
 logic
Message-ID: <aCz5OHYVRnYGcH6a@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-15-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-15-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=wei.liu@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 20, 2025 at 01:30:07PM +0200, Magnus Kulke wrote:
> Implement MSHV-specific hooks for vCPU creation and teardown in the
> i386 target. A list of locks per vCPU is maintained to lock CPU state in
> MMIO operations.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 61 +++++++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index c4b2c297e2..0ba1dacaed 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -14,6 +14,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/atomic.h"
> +#include "qemu/lockable.h"
>  #include "qemu/error-report.h"
>  #include "qemu/typedefs.h"
>  
> @@ -30,6 +32,36 @@
>  #include "trace-accel_mshv.h"
>  #include "trace.h"
>  
> +#include <sys/ioctl.h>
> +
> +static QemuMutex *cpu_guards_lock;
> +static GHashTable *cpu_guards;
> +
> +static void add_cpu_guard(int cpu_fd)
> +{
> +    QemuMutex *guard;
> +
> +    WITH_QEMU_LOCK_GUARD(cpu_guards_lock) {
> +        guard = g_new0(QemuMutex, 1);
> +        qemu_mutex_init(guard);
> +        g_hash_table_insert(cpu_guards, GUINT_TO_POINTER(cpu_fd), guard);
> +    }
> +}
> +
> +static void remove_cpu_guard(int cpu_fd)
> +{
> +    QemuMutex *guard;
> +
> +    WITH_QEMU_LOCK_GUARD(cpu_guards_lock) {
> +        guard = g_hash_table_lookup(cpu_guards, GUINT_TO_POINTER(cpu_fd));
> +        if (guard) {
> +            qemu_mutex_destroy(guard);
> +            g_free(guard);
> +            g_hash_table_remove(cpu_guards, GUINT_TO_POINTER(cpu_fd));
> +        }
> +    }
> +}
> +
>  int mshv_store_regs(CPUState *cpu)
>  {
>  	error_report("unimplemented");
> @@ -62,20 +94,37 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>  
>  void mshv_remove_vcpu(int vm_fd, int cpu_fd)
>  {
> -	error_report("unimplemented");
> -	abort();
> +    /*
> +     * TODO: don't we have to perform an ioctl to remove the vcpu?
> +     * there is WHvDeleteVirtualProcessor in the WHV api
> +     */
> +    remove_cpu_guard(cpu_fd);

Can you just park that CPU and never schedule it again?

There is a DELETE_VP call but we may not have exposed that to user
space.

The code as-is seems to be leaking the cpu_fd. If it is handled
elsewhere you can ignore this comment.

Thanks,
Wei.

>  }
>  
> +
>  int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
>  {
> -	error_report("unimplemented");
> -	abort();
> +    int ret;
> +    struct mshv_create_vp vp_arg = {
> +        .vp_index = vp_index,
> +    };
> +    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
> +    if (ret < 0) {
> +        error_report("failed to create mshv vcpu: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    add_cpu_guard(ret);
> +    *cpu_fd = ret;
> +
> +    return 0;
>  }
>  
>  void mshv_init_cpu_logic(void)
>  {
> -	error_report("unimplemented");
> -	abort();
> +    cpu_guards_lock = g_new0(QemuMutex, 1);
> +    qemu_mutex_init(cpu_guards_lock);
> +    cpu_guards = g_hash_table_new(g_direct_hash, g_direct_equal);
>  }
>  
>  void mshv_arch_init_vcpu(CPUState *cpu)
> -- 
> 2.34.1
> 

