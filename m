Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1BFC4450E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJzM-0007aN-MS; Thu, 16 Jul 2026 07:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wkJzE-0007Zv-S8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:10:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wkJzC-0003op-Sx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:10:40 -0400
Received: from linux.microsoft.com (unknown [167.220.197.183])
 by linux.microsoft.com (Postfix) with ESMTPSA id 13FA720B7168;
 Thu, 16 Jul 2026 04:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13FA720B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784200228;
 bh=KkcVHYxSip0qmwW5prctaCYwKzOI3G6t5uyFuXNibNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SSau6gXuXGbnMeU5WqKpdlDqAixNDqzPBP2pItliQsf53PovoMnChnq9VMhbhxukY
 SVKdY9nYVYVSTO29DqqrwRa6gIX3rh2ZPACDqr3buQIThfmpqY32HEM8Ns0+BY5p9t
 spsP41TvkBzUi2RqW4sq0cEHcLsgqK1IAVeg87eE=
Date: Thu, 16 Jul 2026 14:10:30 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 02/12] accel/mshv: introduce SaveVMHandler
Message-ID: <ali8JvUOh1gCfmPL@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
 <20260710101534.664604-3-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710101534.664604-3-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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

On Fri, Jul 10, 2026 at 12:15:24PM +0200, Magnus Kulke wrote:
> This mechanism is used to handle more imperative partition-wide steps
> that have to be taken as part of a migration routine. Currently it's
> just a skeleton.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 5e8756ede2..b34fb34d05 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -39,6 +39,8 @@
>  #include "system/mshv.h"
>  #include "system/mshv_int.h"
>  #include "system/reset.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/register.h"
>  #include "trace.h"
>  #include <err.h>
>  #include <sys/ioctl.h>
> @@ -544,6 +546,9 @@ static int mshv_init_vcpu(CPUState *cpu)
>      return 0;
>  }
>  
> +static SaveVMHandlers savevm_mshv = {
> +};
> +
>  static int mshv_init(AccelState *as, MachineState *ms)
>  {
>      MshvState *s;
> @@ -599,6 +604,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
>                                    0, "mshv-memory");
>      memory_listener_register(&mshv_io_listener, &address_space_io);
>  
> +    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
> +
>      return 0;
>  }
>  
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

