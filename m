Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 22:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2IBJ-0005Vm-TY; Wed, 01 May 2024 18:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2IBH-0005Uz-Ox; Wed, 01 May 2024 18:12:03 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1s2IBG-0006aR-2x; Wed, 01 May 2024 18:12:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 128006199A;
 Wed,  1 May 2024 22:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF35C072AA;
 Wed,  1 May 2024 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714601519;
 bh=oczYVEObSp0SwvIKnSVleIAmfuVMgFghBTCjRwOLx6c=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=MDdirIhwF+icqMf5tLMx7XIap1CCkJDe5s4NqlnhZk5fHNP8QzgcxzmTfZtujatuL
 /50f+4OCUDA4ZYnQZChhv53/l9oD2Ij2UYYcsiWPDLzqnmCLYH0IYys5gexQBQ3xVW
 9Km/gIkzVAGi2YmfuKUn1NyvSQmIuq3qsCCgX5kXq+434qFYUrLf/rHi5bAQbz2jar
 odrJ0WbcnNW+0UCSYxinTvax7bXxpKZWUYVIRAYdYKqIQwrHDKXcoBA9OQwIiQMop0
 VehvLlhR/24R+ruQSLDTr5SSPuUSTiT0p0XT0yhhhBD8yg4w4SgP/EaGSW07tsFnq0
 uE6kHxu+Qjlsg==
Date: Wed, 1 May 2024 15:11:57 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 17/17] hw/arm: xen: Enable use of grant mappings
In-Reply-To: <20240430164939.925307-18-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2405011511040.497719@ubuntu-linux-20-04-desktop>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-18-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/xen_arm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 15fa7dfa84..6fad829ede 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
>                                   GUEST_RAM1_BASE, ram_size[1]);
>          memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
>      }
> +
> +    /* Setup support for grants.  */
> +    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
>  }
>  
>  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
> -- 
> 2.40.1
> 

