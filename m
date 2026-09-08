Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81A0C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tyI-0006eM-Gk; Tue, 08 Sep 2026 07:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1x3tyH-0006eE-C3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:26:37 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1x3tyF-0006CB-Fg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:26:37 -0400
Received: from example.com (unknown [167.220.208.41])
 by linux.microsoft.com (Postfix) with ESMTPSA id B6F9520B712B;
 Tue,  8 Sep 2026 04:25:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6F9520B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788866753;
 bh=AgQ+i7kxtChkdfDmCLravFvGLzlV3QyZi6tXDdpaFC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rbVrBj5+2uwpcZoz4JV4URG1Oc7WeDBUKTSn8xJReiXbZJN/4536Hn0TglXIOh8aR
 38mhFNBQEd1n/beQXVdWb8E3Uhj4IuUqRkt8XhbcX+BDA9n00/kYE6Ts95DNLlWKoO
 o2/SlyT8Pbl0xI+T9Wxc3GNz9LSHRbM7LLDNlGFM=
Date: Tue, 8 Sep 2026 13:26:28 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>
Subject: Re: [PATCH 1/2] accel/mshv: size XSAVE buffers from the hypervisor
Message-ID: <ap/w5P9ft9EXNcoK@example.com>
References: <20260907142355.141033-1-dblanzeanu@linux.microsoft.com>
 <20260907142355.141033-2-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907142355.141033-2-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 07, 2026 at 05:23:54PM +0300, Doru Blânzeanu wrote:
> Query MAX_XSAVE_DATA_SIZE at vcpu creation and cache it in MshvState.
> Introduce a new trace event for the xsave area size reported by the
> hypervisor.
> 
> Also fixes a leak of xsavec_buf on the get error path and switches
> qemu_memalign() buffers to qemu_vfree().
> No functional change on hosts reporting under 4 KiB.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 21 +++++++++++++++++++++
>  accel/mshv/trace-events     |  2 ++
>  include/system/mshv_int.h   |  3 +++
>  target/i386/mshv/mshv-cpu.c | 34 +++++++++++++++++++++++++---------
>  4 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 5921ce693e..725ccd0511 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -162,6 +162,27 @@ static int get_proc_features(int vm_fd,
>      return 0;
>  }
>  
> +int mshv_get_max_xsave_size(int vm_fd, uint32_t *size)
> +{
> +    uint64_t value = 0;
> +    int ret;
> +
> +    ret = get_partition_property(vm_fd,
> +                                 HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
> +                                 &value);
> +    if (ret < 0) {
> +        error_report("Failed to get partition property MAX_XSAVE_DATA_SIZE");
> +        return -1;
> +    }
> +
> +    /* round up to page size */
> +    *size = ROUND_UP(value, HV_HYP_PAGE_SIZE);
> +
> +    trace_mshv_xsave_data_size(value, *size);
> +
> +    return 0;
> +}
> +
>  static int create_partition(int mshv_fd, int *vm_fd)
>  {
>      int ret;
> diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
> index 859e8bfb0f..9473530140 100644
> --- a/accel/mshv/trace-events
> +++ b/accel/mshv/trace-events
> @@ -12,6 +12,8 @@ mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" P
>  
>  mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
>  
> +mshv_xsave_data_size(uint64_t required, uint32_t allocated) "required=%" PRIu64 " allocated=%u"
> +
>  mshv_handle_interrupt(uint32_t cpu, int mask) "cpu_index=%d mask=0x%x"
>  mshv_set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data) "gsi=%d addr=0x%" PRIx64 " data=0x%x"
>  mshv_remove_msi_routing(uint32_t gsi) "gsi=%d"
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 3dffe3c5fb..9d0957a65b 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -70,6 +70,8 @@ struct MshvState {
>      unsigned long *used_gsi_bitmap;
>      unsigned int gsi_count;
>      union hv_partition_processor_features processor_features;
> +    /* compacted xsave area size rounded up to the page size */
> +    uint32_t xsave_data_size;

maybe xsavec_data_size to indicate that it's compacted?

>  };
>  
>  typedef struct MshvMsiControl {
> @@ -107,6 +109,7 @@ void mshv_arch_amend_proc_features(
>  void mshv_arch_disable_partition_proc_features(
>       union hv_partition_processor_features *disabled_features);
>  int mshv_arch_post_init_vm(int vm_fd);
> +int mshv_get_max_xsave_size(int vm_fd, uint32_t *size);
>  int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
>  int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
>  typedef struct mshv_root_hvcall mshv_root_hvcall;
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index f528dd2b9a..7ce05bfb17 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -157,9 +157,8 @@ static int get_xsave_state(CPUState *cpu)
>      int ret;
>      void *xsavec_buf;
>      const size_t page = HV_HYP_PAGE_SIZE;
> -    size_t xsavec_buf_len = page;
> +    size_t xsavec_buf_len = mshv_state->xsave_data_size;
>  
> -    /* TODO: should properly determine xsavec size based on CPUID */
>      xsavec_buf = qemu_memalign(page, xsavec_buf_len);
>      memset(xsavec_buf, 0, xsavec_buf_len);
>  
> @@ -172,11 +171,12 @@ static int get_xsave_state(CPUState *cpu)
>      ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, &args);
>      if (ret < 0) {
>          error_report("failed to get xsave state: %s", strerror(errno));
> +        qemu_vfree(xsavec_buf);
>          return -errno;
>      }
>  
>      ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
> -    g_free(xsavec_buf);
> +    qemu_vfree(xsavec_buf);
>      if (ret < 0) {
>          error_report("failed to decompact xsave area");
>          return ret;
> @@ -196,8 +196,8 @@ static int set_xsave_state(const CPUState *cpu)
>      size_t page = HV_HYP_PAGE_SIZE, xsavec_buf_len;
>  
>      /* allocate and populate compacted buffer */
> -    xsavec_buf = qemu_memalign(page, page);
> -    xsavec_buf_len = page;
> +    xsavec_buf_len = mshv_state->xsave_data_size;
> +    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
>  
>      /* save registers to standard format buffer */
>      x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
> @@ -212,7 +212,7 @@ static int set_xsave_state(const CPUState *cpu)
>      };
>  
>      ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, &args);
> -    g_free(xsavec_buf);
> +    qemu_vfree(xsavec_buf);
>      if (ret < 0) {
>          error_report("failed to set xsave state: %s", strerror(errno));
>          return -errno;
> @@ -2125,6 +2125,24 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>      int ret;
>      X86XSaveHeader *header;
>  
> +    /* get the xsave data size */
> +    if (!mshv_state->xsave_data_size) {

I assume we are doing that here to not do it for every vcpu? if yes,
maybe we can use the `cpu_is_bsp(cpu);` to make it more explicit?

> +        ret = mshv_get_max_xsave_size(mshv_state->vm,
> +                                      &mshv_state->xsave_data_size);
> +        if (ret < 0) {
> +            warn_report("failed to get the max xsave area size: %s",
> +                        strerror(errno));
> +            /*
> +             * Use the maximum size for xsave because the partition is
> +             * provisioned with every XSAVE component supported
> +             */

do we expect the call to fail in some circumstance? I'm not sure a
graceful fallback is a good idea, the max size will vary depending on the
host CPU and failing hv calls should be a strong signal that something
is broken and abort the guest launch.

> +            mshv_state->xsave_data_size =
> +                ROUND_UP(mshv_get_supported_cpuid(0xD, 0, R_ECX), page);
> +        }
> +        /* never allow a zero-sized xsave area */
> +        mshv_state->xsave_data_size = MAX(mshv_state->xsave_data_size, page);
> +    }
> +
>      /* sanity check, to make sure we don't overflow the page */
>      QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
>                        * sizeof(hv_register_assoc)
> @@ -2149,9 +2167,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>  
>      env->emu_mmio_buf = g_new(char, 4096);
>  
> -    /* Initialize XSAVE buffer page-aligned */
> -    /* TODO: pick proper size based on CPUID */
> -    xsave_len = page;
> +    xsave_len = mshv_state->xsave_data_size;
>      env->xsave_buf = qemu_memalign(page, xsave_len);
>      env->xsave_buf_len = xsave_len;
>      memset(env->xsave_buf, 0, env->xsave_buf_len);
> -- 
> 2.53.0

