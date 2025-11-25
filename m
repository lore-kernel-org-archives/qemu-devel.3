Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF1ED0EE13
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyyd-0002Yj-Hj; Tue, 25 Nov 2025 14:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vNyyQ-0002P5-VO
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:45:14 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vNyyP-0006Tj-FJ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:45:14 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8486260121;
 Tue, 25 Nov 2025 19:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80D4C4CEF1;
 Tue, 25 Nov 2025 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764099903;
 bh=1xhSXrATP9gSRtTTLPrhqTW96NgA60v98mr94JOJBb4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HUXxLOcOPDRkgIgd1qLIT7kenx95by3IAeZFxkFKPihWnu/EfKi6rou5/EOOyIsa6
 91LYCAKQcB3AFmDilAKzcXIEAaZwWTtEclmGaSz10qYIPYXKn1M1beT/4AO6XHjIAg
 GLPIdRcpu01OXjXjF6pzqfQYN/dEn+kONfz3BwskvFsVBmyGQjX0q04yiCam8AMXnE
 nz/XlaQea+1gQhKAH69JYHCourpDP16WcceyH3BPV9N0JT3uhLvnSVbne1c3argCEj
 H6tN+Blkogk3L3ne6/aGCe+nwz0fIoc/cOtOUvbJPjLgGLXlT7DfP/hwqondlablb3
 EG1PrAaTgrnqg==
Date: Tue, 25 Nov 2025 19:45:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] target/i386/mshv: remove unused gpa txl optimization
Message-ID: <20251125194502.GA1073416@liuwe-devbox-debian-v2.local>
References: <20251125120852.250149-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125120852.250149-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Nov 25, 2025 at 01:08:52PM +0100, Magnus Kulke wrote:
> The removed parameters are remnants of a prior attempt to optimize
> gva=>gpa translation. Currently there is only one call site and it's
> not using it. So we can remove it as dead code.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 1c3db02188..03ef085d5e 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1189,7 +1189,7 @@ static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
>      remap_result = mshv_remap_overlap_region(vm_fd, gpa);
>      *exit_reason = MshvVmExitIgnore;
>  
> -    switch (remap_result) {
> +   switch (remap_result) {

This indentation looks off.

With this issue fixed:

Reviewed-by: Wei Liu <wei.liu@kernel.org>

>      case MshvRemapNoMapping:
>          /* if we didn't find a mapping, it is probably mmio */
>          return handle_mmio(cpu, msg, exit_reason);
> @@ -1374,23 +1374,19 @@ static int read_memory(const CPUState *cpu, uint64_t initial_gva,
>      return 0;
>  }
>  
> -static int write_memory(const CPUState *cpu, uint64_t initial_gva,
> -                        uint64_t initial_gpa, uint64_t gva, const uint8_t *data,
> +static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
>                          size_t len)
>  {
>      int ret;
>      uint64_t gpa, flags;
>  
> -    if (gva == initial_gva) {
> -        gpa = initial_gpa;
> -    } else {
> -        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> -        ret = translate_gva(cpu, gva, &gpa, flags);
> -        if (ret < 0) {
> -            error_report("failed to translate gva to gpa");
> -            return -1;
> -        }
> +    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> +    ret = translate_gva(cpu, gva, &gpa, flags);
> +    if (ret < 0) {
> +        error_report("failed to translate gva to gpa");
> +        return -1;
>      }
> +
>      ret = mshv_guest_mem_write(gpa, data, len, false);

Not entirely related to this, but you should be careful with cross-page
accesses in these functions.

Wei

