Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95723FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI22p-0008Iz-3U; Wed, 29 Apr 2026 06:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wI22n-0008Ir-Im
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 06:21:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wI22m-0005Bl-Ar
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 06:21:25 -0400
Received: from example.com (unknown [167.220.208.81])
 by linux.microsoft.com (Postfix) with ESMTPSA id D7ACB20B716C;
 Wed, 29 Apr 2026 03:21:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7ACB20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777458083;
 bh=2hRgn57ucZhX/HmVmq5A/dok+6CpOS0yLW+Nl+yhg6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ADngnGGAGiETuPK45W4/DdMtZFkFY+QrNsKZ2XbCBtKd9/tHEd5Uf68tdf34O2yRl
 iODrIvx3S/WHsDSwc6CnFf+eD5lxC1fL8GeyVTNi9XE98TZ7+CZ5GuudnUZtN5OR65
 ZRY2Qnc0gzt6qQy+LrzR4UR36UZXx9EarY6Dn6bk=
Date: Wed, 29 Apr 2026 12:21:18 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/6] accel/mshv: move vcpu arch specific initialization
 after vcpu creation
Message-ID: <afHbnvhwcAoMESn5@example.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-3-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428135053.251200-3-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 04:50:49PM +0300, Doru Blânzeanu wrote:
> Call mshv_arch_init_vcpu after the vcpu is created to ensure a valid
> vcpu fd.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 58af674bd9..e3da583f21 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -415,13 +415,14 @@ static int mshv_init_vcpu(CPUState *cpu)
>      int ret;
>  
>      cpu->accel = g_new0(AccelCPUState, 1);
> -    mshv_arch_init_vcpu(cpu);
>  
>      ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
>      if (ret < 0) {
>          return -1;
>      }
>  
> +    mshv_arch_init_vcpu(cpu);
> +
>      cpu->accel->dirty = true;
>  
>      return 0;
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

