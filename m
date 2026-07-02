Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF28C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHmm-0007T7-BT; Thu, 02 Jul 2026 09:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wfHme-0007My-Tn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:48:54 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wfHmc-0006MO-1n
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:48:51 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id C0F8F20B7167;
 Thu,  2 Jul 2026 06:48:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0F8F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783000125;
 bh=yMA3sSp65J87TwsF+u847ppjjlwy3Mk1KyzGUVvOf9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bcCr2iW9YK2wZz8nvECbOBO0a74CJBBJyZpzd2ixfY7nXbcAKOBqjnf4m3rutLtOo
 vRvtb2HFImjuc4X2RbzidiU9xq18JJPJc9sLjR2X/ZwBuw3OD0M17/tlu5gLcI7OHz
 XaCdjcxBd7LJae/5RK5tYHE4aegPiNSrn6lDcd5M=
Date: Thu, 2 Jul 2026 16:48:35 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] accel/mshv: Fix pointer to proc feature bitfield
Message-ID: <akZsM5Je3Pn8OnYq@linux.microsoft.com>
References: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701130335.418156-1-magnuskulke@linux.microsoft.com>
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

On Wed, Jul 01, 2026 at 03:03:35PM +0200, Magnus Kulke wrote:
> Processor features are stored in a union containing two "banks":
> 
> union hv_partition_processor_features {
>     uint64_t as_uint[2];
>     struct {
>         uint64_t sse3_support:1;
>         ...
>     }
> }
> 
> get_proc_features() to retrieve the 2nd bank was passing a pointer that
> steps over the whole union (+16B) instead of picking the 2nd bank _in_
> the union. This manifests in mismatching feature bits for the 2nd bank
> and possibly other side-effects caused by writing beyond the union.
> 
> We need to step over the first bank (+8B) by using as_uint64[0/1] to
> correct this behaviour.
> 
> Fixes: 2f6da91e8a ("accel/mshv: store partition proc features")
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 9452504ac2..c8b7f10294 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -167,7 +167,7 @@ static int get_proc_features(int vm_fd,
>  
>      ret = get_partition_property(vm_fd,
>                                   HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
> -                                 features[0].as_uint64);
> +                                 &features->as_uint64[0]);
>      if (ret < 0) {
>          error_report("Failed to get processor features bank 0");
>          return -1;
> @@ -175,7 +175,7 @@ static int get_proc_features(int vm_fd,
>  
>      ret = get_partition_property(vm_fd,
>                                   HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
> -                                 features[1].as_uint64);
> +                                 &features->as_uint64[1]);
>      if (ret < 0) {
>          error_report("Failed to get processor features bank 1");
>          return -1;
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

