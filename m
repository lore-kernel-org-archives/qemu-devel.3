Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHoc-0000vI-IY; Thu, 02 Jul 2026 09:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wfHob-0000uN-7v
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:50:53 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wfHoZ-0007lN-UV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:50:53 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id C6CA420B7167;
 Thu,  2 Jul 2026 06:50:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6CA420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783000248;
 bh=Z5huA6aEcLNU4FzaoPC/2E1/3MNGQKlEIcR/2axjyRk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HkSr5er9oNp+HA29+Z7AdU5fZ3aTE0Au5TGLfu+PZubrHfX/G9KmotyWLVs53PHN2
 0TZqKUyHQwFCwqQL9Ud1JgwVK6WiiOxu65Flksw3E+EJIkab1ASCrOLJiuBIsUnEEb
 NVK5GpK8gD3zCtwRcIevf7JdQ3fvE8ws3VOAZwvk=
Date: Thu, 2 Jul 2026 16:50:44 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] target/i386/mshv: zero-init msr hvcall args
Message-ID: <akZstNFMGpCmJDDO@linux.microsoft.com>
References: <20260701134214.419806-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701134214.419806-1-magnuskulke@linux.microsoft.com>
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

On Wed, Jul 01, 2026 at 03:42:14PM +0200, Magnus Kulke wrote:
> In the current code we leave the argument arrays for the get/set hvcall
> unitialized, setting only individual fields. some fields will be
> populated during the hvcall, but in any case the arg arrays will contain
> unitialized data (e.g. in reserved fields), to which static analysis
> objects to.
> 
> Fixes: c38eb12c85
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  target/i386/mshv/msr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index 8c220a9942..a35415ed9d 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -326,7 +326,7 @@ int mshv_get_msrs(CPUState *cpu)
>  {
>      int ret = 0;
>      size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
> -    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
> +    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };
>      size_t i, j;
>      uint32_t name;
>  
> @@ -386,7 +386,7 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
>  int mshv_set_msrs(const CPUState *cpu)
>  {
>      size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
> -    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
> +    struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };
>      int ret;
>      size_t i, j;
>  
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

