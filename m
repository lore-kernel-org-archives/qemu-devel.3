Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93A2CED602
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJG4-0007yz-4A; Tue, 18 Nov 2025 05:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vLJFx-0007xk-2r; Tue, 18 Nov 2025 05:48:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vLJFt-0006bp-90; Tue, 18 Nov 2025 05:48:16 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9hBq2WkjzJ46jK;
 Tue, 18 Nov 2025 18:47:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 71001140277;
 Tue, 18 Nov 2025 18:47:57 +0800 (CST)
Received: from localhost (10.48.158.191) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Nov
 2025 10:47:56 +0000
Date: Tue, 18 Nov 2025 10:47:55 +0000
To: Gavin Shan <gshan@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <mchehab+huawei@kernel.org>, <gengdongjiu1@gmail.com>, <mst@redhat.com>,
 <imammedo@redhat.com>, <armbru@redhat.com>, <anisinha@redhat.com>,
 <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <wangyanan55@huawei.com>, <zhao1.liu@intel.com>, <peter.maydell@linaro.org>,
 <pbonzini@redhat.com>, <shan.gavin@gmail.com>, <zhangliang5@huawei.com>
Subject: Re: [PATCH v4 0/8] target/arm/kvm: Improve memory error handling
Message-ID: <20251118104755.000024c8@huawei.com>
In-Reply-To: <20251112172535.403042-1-gshan@redhat.com>
References: <20251112172535.403042-1-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.191]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 13 Nov 2025 03:25:27 +1000
Gavin Shan <gshan@redhat.com> wrote:

> In the combination of 64KiB host and 4KiB guest, a problematic host
> page affects 16x guest pages. Those 16x guest pages are most likely
> owned by separate threads and accessed by the threads in parallel.
> It means 16x memory errors can be raised at once. However, we're
> unable to handle this situation because the only error source has
> one read acknowledgement register in current design. QEMU has to
> crash in the following path due to the previously delivered error
> isn't acknowledged by the guest on attempt to deliver another error.
> 
>   kvm_vcpu_thread_fn
>     kvm_cpu_exec
>       kvm_arch_on_sigbus_vcpu
>         kvm_cpu_synchronize_state
>         acpi_ghes_memory_errors
>         abort
> 
> This series fixes the issue by sending 16x consective CPER errors
> which are contained in a single GHES error block.
> 
> PATCH[1-4] Increases GHES raw data maximal length from 1KiB to 4KiB
> PATCH[5]   Supports multiple error records in a single error block
> PATCH[6-7] Improves the error handling in the error delivery path
> PATCH[8]   Sends 16x consective CPERs in a single block if needed
> 

Hi Gavin,

Just a quick head's up to say we've had some internal discussions around the
kernel handling of broader address masks in CPER and think it is probably
broken. Rectifying that may at least simplify what is needed on the QEMU side
of things and maybe even handle much larger blocks (2M and larger).

Will keep everyone informed of how we get on with resolving that.

Jonathan



> Changelog
> =========
> v4:
>   * v3: https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00264.html
>   * Pick r-b tags from Jonathan
>   * Add compat property 'x-error-block-size' for migration     (Igor)
>   * Code and commit log improvements                           (Igor/Jonathan)
>   * Use error_fatal in the memory error delivery path          (Markus)
>   * Use APIs from registerfields.h                             (Philippe)
> v3:
>   * v2: https://lists.nongnu.org/archive/html/qemu-arm/2025-10/msg00372.html
>   * Code and changelog improvements                            (Jonathan)
>   * Fixed GHES error block status field and improved error
>     handling in the error delivery path                        (Igor)
>   * Fixed ACPI HEST table and document                         (Mauro)
> v2:
>   * v1: https://lists.nongnu.org/archive/html/qemu-arm/2025-02/msg00897.html
>   * Send 16x memory errors for the specific case               (Jonathan)
> 
> Gavin Shan (8):
>   acpi/ghes: Make GHES max raw data length dynamic
>   tests/qtest/bios-tables-test: Prepare for changes in the HEST table
>   acpi/ghes: Increase GHES raw data maximal length to 4KiB
>   tests/qtest/bios-tables-test: Update HEST table
>   acpi/ghes: Extend acpi_ghes_memory_errors() for multiple CPERs
>   acpi/ghes: Bail early on error from get_ghes_source_offsets()
>   acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
>   target/arm/kvm: Support multiple memory CPERs injection
> 
>  docs/specs/acpi_hest_ghes.rst     |   6 +-
>  hw/acpi/generic_event_device.c    |   2 +
>  hw/acpi/ghes-stub.c               |   7 +-
>  hw/acpi/ghes.c                    | 127 +++++++++++++++++-------------
>  hw/core/machine.c                 |   1 +
>  include/hw/acpi/ghes.h            |   8 +-
>  target/arm/kvm.c                  |  72 +++++++++++++++--
>  tests/data/acpi/aarch64/virt/HEST | Bin 224 -> 224 bytes
>  8 files changed, 153 insertions(+), 70 deletions(-)
> 


