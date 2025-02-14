Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A97C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tisOq-0008NL-8u; Fri, 14 Feb 2025 04:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tisOj-0008Mb-2k; Fri, 14 Feb 2025 04:54:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tisOd-0003fd-UH; Fri, 14 Feb 2025 04:54:10 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvS4G4LgYz6M4Zs;
 Fri, 14 Feb 2025 17:51:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A28C6140A78;
 Fri, 14 Feb 2025 17:53:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 10:53:54 +0100
Date: Fri, 14 Feb 2025 09:53:53 +0000
To: Gavin Shan <gshan@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <gengdongjiu1@gmail.com>,
 <peter.maydell@linaro.org>, <pbonzini@redhat.com>, <shan.gavin@gmail.com>,
 "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 0/4] target/arm: Improvement on memory error handling
Message-ID: <20250214095353.00007afc@huawei.com>
In-Reply-To: <20250214041635.608012-1-gshan@redhat.com>
References: <20250214041635.608012-1-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 14 Feb 2025 14:16:31 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Currently, there is only one CPER buffer (entry), meaning only one
> memory error can be reported. In extreme case, multiple memory errors
> can be raised on different vCPUs. For example, a singile memory error
> on a 64KB page of the host can results in 16 memory errors to 4KB
> pages of the guest. Unfortunately, the virtual machine is simply aborted
> by multiple concurrent memory errors, as the following call trace shows.
> A SEA exception is injected to the guest so that the CPER buffer can
> be claimed if the error is successfully pushed by acpi_ghes_memory_errors(),
> Otherwise, abort() is triggered to crash the virtual machine.
> 
>   kvm_vcpu_thread_fn
>     kvm_cpu_exec
>       kvm_arch_on_sigbus_vcpu
>         kvm_cpu_synchronize_state
>         acpi_ghes_memory_errors         (a)
>         kvm_inject_arm_sea | abort
> 
> It's arguably to crash the virtual machine in this case. The better
> behaviour would be to retry on pushing the memory errors, to keep the
> virtual machine alive so that the administrator has chance to chime
> in, for example to dump the important data with luck. This series
> adds one more parameter to acpi_ghes_memory_errors() so that it will
> be tried to push the memory error until it succeeds.

Hi Gavin,

+CC Mauro given:
https://lore.kernel.org/all/cover.1738345063.git.mchehab+huawei@kernel.org/

is more or less reviewed subject to some requested patch reordering and
whilst I haven't checked, seems unlikely that there won't be a
clash with this series (might just be some fuzz)

Jonathan



> 
> Gavin Shan (4):
>   acpi/ghes: Make ghes_record_cper_errors() static
>   acpi/ghes: Use error_report() in ghes_record_cper_errors()
>   acpi/ghes: Allow retry to write CPER errors
>   target/arm: Retry pushing CPER error if necessary
> 
>  hw/acpi/ghes-stub.c    |  3 ++-
>  hw/acpi/ghes.c         | 45 +++++++++++++++++++++---------------------
>  include/hw/acpi/ghes.h |  5 ++---
>  target/arm/kvm.c       | 31 +++++++++++++++++++++++------
>  4 files changed, 51 insertions(+), 33 deletions(-)
> 


