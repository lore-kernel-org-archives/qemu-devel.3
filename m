Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40958C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivIo-0008Mb-Pz; Fri, 14 Feb 2025 08:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tivIm-0008Jf-By; Fri, 14 Feb 2025 08:00:16 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tivIg-0000yH-S0; Fri, 14 Feb 2025 08:00:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 38154A42955;
 Fri, 14 Feb 2025 12:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC04AC4CED1;
 Fri, 14 Feb 2025 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739537998;
 bh=b7jEQVxRxS7duBNkhVIGCKZV1lnGUW/SzqQxaUyGNAg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tH06c+WV9rB154/hPW3OP4pVrJoVzM5FKFH73aNMtVmKjxx0z1r5GgMpodwrlTJqm
 kRtUBPxPicxz8x613JG254Ol1AvHOpMa80A7NKWwKIbdJnUf8DhOPHPWt3huJEWV8U
 AeqfYFjh9I6+MwKKE9WHmo0JS77maS4v6NnaRMaNMyJsJngk84oWMKBF4eEKtw2/3v
 iTj4LLMdxF8DjTPdAyW71iQBkytfs14ai+YD7Ii3X12l6nU71XFh4wpDGV9jCjj9Vr
 hi9PCzeqc/POjHfDzlU8UyUy4ZB1N4o+PjdcEkvJ9vH26CMqPHkpuKjWL5P29VKDz1
 PKHmb/NYW8iFg==
Date: Fri, 14 Feb 2025 13:59:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] target/arm: Improvement on memory error handling
Message-ID: <20250214135945.322319cc@foz.lan>
In-Reply-To: <20250214041635.608012-1-gshan@redhat.com>
References: <20250214041635.608012-1-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Fri, 14 Feb 2025 14:16:31 +1000
Gavin Shan <gshan@redhat.com> escreveu:

> Currently, there is only one CPER buffer (entry), meaning only one
> memory error can be reported. In extreme case, multiple memory errors
> can be raised on different vCPUs. For example, a singile memory error
> on a 64KB page of the host can results in 16 memory errors to 4KB
> pages of the guest. 

There is already a patchset allowing to have multiple CPER entries
floating around since last year:

	https://lore.kernel.org/qemu-devel/cover.1738345063.git.mchehab+huawei@kernel.org/

I guess it is almost ready for being merged, needing just some
nitpick changes to satisfy ACPI maintainers. Such changeset already
adds a second CPER entry for GED, and allows to easily add more as
needed. 

> In extreme case, multiple memory errors
> can be raised on different vCPUs. For example, a singile memory error
> on a 64KB page of the host can results in 16 memory errors to 4KB
> pages of the guest. 

> Unfortunately, the virtual machine is simply aborted
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

Having a retry buffer might be interesting for some types of errors,
like error-injected and corrected errors. Yet, it doesn't sound right 
to buffer uncorrected errors that would affect the virtual machine.

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



Thanks,
Mauro

