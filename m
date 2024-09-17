Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4814C3601E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqYyE-0004kY-Bk; Tue, 17 Sep 2024 10:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sqYy9-0004f6-6v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sqYy5-0007ub-Ei
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726582451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7udBV8DnjjbmItnUiBGZDt0GCsRhaSBO2B9+CYpHhU=;
 b=JOamBvdxIK7zCto9XDUtGddu86G50bwQFwfhGgrzXfE4vgtRfYCN+64DxJir/4ugZJiOsX
 z4+x0rDH2SUwzq0TREh8kIyTupDwl73Yrf9ZhyCmKrG4/0JZ0R2BfBEgrM/lImm2lx5CsI
 XtOPwnTRNfGKs/8SiS1nLM6Z4Da1lI4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-gfyGS6tBPumbdqOMsW6heg-1; Tue,
 17 Sep 2024 10:14:04 -0400
X-MC-Unique: gfyGS6tBPumbdqOMsW6heg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A301955F79; Tue, 17 Sep 2024 14:14:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.239])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CDBA19560AA; Tue, 17 Sep 2024 14:13:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 gustavo.romero@linaro.org, alex.bennee@linaro.org,
 darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: Re: [PATCH V2] arm/kvm: add support for MTE
In-Reply-To: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240912091616.393685-1-gankulkarni@os.amperecomputing.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 17 Sep 2024 16:13:56 +0200
Message-ID: <87bk0mtljv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 12 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:

> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
> Changes since V1:
> 	Added code to enable MTE before reading register
> id_aa64pfr1 (unmasked MTE bits).
>
> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
> and default case(i.e, no mte).
>
>  hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>  target/arm/cpu.c     |  7 +++--
>  target/arm/cpu.h     |  2 ++
>  target/arm/kvm.c     | 59 ++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h | 19 ++++++++++++
>  5 files changed, 126 insertions(+), 33 deletions(-)
>

(...)

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 849e2e21b3..29865609fb 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ghes.h"
>  #include "target/arm/gtimer.h"
> +#include "migration/blocker.h"
>  
>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>      KVM_CAP_LAST_INFO
> @@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>      if (vmfd < 0) {
>          goto err;
>      }
> +
> +    /*
> +     * MTE bits of register id_aa64pfr1 are masked if MTE is
> +     * not enabled and required to enable before VCPU
> +     * is created. Hence enable MTE(if supported) before VCPU
> +     * is created to read unmasked MTE bits.
> +     */

Maybe

"KVM will mask the MTE bits in id_aa64pfr1 unless the VMM has enabled
the MTE KVM capability, so do it here for probing."

?

> +    if (kvm_arm_mte_supported()) {
> +        KVMState kvm_state;
> +
> +        kvm_state.fd = kvmfd;
> +        kvm_state.vmfd = vmfd;
> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
> +    }
> +
>      cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>      if (cpufd < 0) {
>          goto err;


