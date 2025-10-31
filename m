Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEm4Q-0004Lx-Dn; Fri, 31 Oct 2025 06:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm4M-0004Jd-0I; Fri, 31 Oct 2025 06:09:18 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm4E-0002V6-IJ; Fri, 31 Oct 2025 06:09:17 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cycBp4ZJ8zJ46Dd;
 Fri, 31 Oct 2025 18:08:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C76E140373;
 Fri, 31 Oct 2025 18:09:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 10:09:02 +0000
Date: Fri, 31 Oct 2025 10:09:01 +0000
To: Gavin Shan <gshan@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <gengdongjiu1@gmail.com>,
 <peter.maydell@linaro.org>, <pbonzini@redhat.com>,
 <mchehab+huawei@kernel.org>, <shan.gavin@gmail.com>
Subject: Re: [PATCH RESEND v2 2/3] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
Message-ID: <20251031100901.00000ccf@huawei.com>
In-Reply-To: <20251007060810.258536-3-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-3-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  7 Oct 2025 16:08:09 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
> errors, injects SEA exception or aborts on errors. This function will
> be extended to support multiple ACPI GHES memory errors in the next
> path.
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/kvm.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 9a47ac9e3a..c5d5b3b16e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2429,12 +2429,34 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>      return ret;
>  }
>  
> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> +                                    uint64_t paddr)

Why not hwaddr paddr?

> +{
> +    GArray *addresses = g_array_new(false, false, sizeof(paddr));

As in previous I'd just have 
	hwaddr paddrs[16];

rather than bothering with a g_array.

> +    int ret;
> +
> +    kvm_cpu_synchronize_state(c);
> +    g_array_append_vals(addresses, &paddr, 1);
> +    ret = acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses);
> +    if (ret) {
> +        goto error;
> +    }
> +
> +    kvm_inject_arm_sea(c);
> +
> +    g_array_free(addresses, true);
> +
> +    return;
> +error:
> +    error_report("failed to record the error");

I'd just do this inline at the error case. In the next
patch you add a more specific report of why to another path
that would then be followed by this.

> +    abort();

If you do the above with the message, just duplicate this in the
two error paths (by end of next patch).

> +}


