Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6USF-0005Hx-VQ; Wed, 08 Oct 2025 09:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v6USE-0005HV-6F
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1v6US4-0007gx-En
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759931009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hePSVMl4pl78/ciTtyZmNjxbdqyuIaefwx/wN9cTjVU=;
 b=P1dXOKEH1fRGtdpiT6M6U4DtkyBVmEUHZkwYZFplQ3gr1gdDCXxfEqBk0pD58VhLqjm4rA
 LShcGhd8I+WUnJgLtd5ErP5VQ69CXtK78aRXtclxP7Be1e5c8R8Qf7nlRMpZGCJtsSQIRc
 cPp6qGmqX6aq68pwpu430CDb8+/6a8o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-QLNj7EwCPzykDTn07UouJg-1; Wed,
 08 Oct 2025 09:43:24 -0400
X-MC-Unique: QLNj7EwCPzykDTn07UouJg-1
X-Mimecast-MFC-AGG-ID: QLNj7EwCPzykDTn07UouJg_1759931001
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 890DE19560B0; Wed,  8 Oct 2025 13:43:21 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FCD1800452; Wed,  8 Oct 2025 13:43:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com
Subject: Re: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to
 hide
In-Reply-To: <20250911134324.3702720-2-eric.auger@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250911134324.3702720-1-eric.auger@redhat.com>
 <20250911134324.3702720-2-eric.auger@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 08 Oct 2025 15:43:17 +0200
Message-ID: <87ldllv79m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 11 2025, Eric Auger <eric.auger@redhat.com> wrote:

> New kernels sometimes expose new registers in an unconditionnal
>  manner.  This situation breaks backward migration as qemu notices
> there are more registers to store on guest than supported in the
> destination kerenl. This leads to a "failed to load
> cpu:cpreg_vmstate_array_len" error.
>
> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
> pseudo FW register in v6.16 by commit C0000e58c74e (=E2=80=9CKVM: arm64:
> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2=E2=80=9D). Trying to do backward
> migration from a host kernel which features the commit to a destination
> host that doesn't fail.
>
> Currently QEMU is not using that feature so ignoring this latter
> is not a problem. An easy way to fix the migration issue is to teach
> qemu we don't care about that register and we can simply ignore it,
> including its state migration.
>
> This patch introduces a CPU property, under the form of an array of
> reg indices which indicates which registers can be ignored.
>
> The goal then is to set this property in machine type compats such
> as:
> static GlobalProperty arm_virt_kernel_compat_10_1[] =3D {
>     /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>     { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
> }
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/cpu.h        |  4 ++++
>  target/arm/kvm.c        | 36 ++++++++++++++++++++++++++++++++++--
>  target/arm/trace-events |  2 ++
>  3 files changed, 40 insertions(+), 2 deletions(-)
>

(...)

> +/**
> + * kvm_vcpu_compat_hidden_reg:
> + * @cpu: ARMCPU
> + * @regidx: index of the register to check
> + *
> + * Depending on the CPU compat returns true if @regidx must be
> + * ignored during sync & migration

Maybe add some more explanation, either here or at the kvm_hidden_regs[]
def? So that people do not need to look at the introducing commit :)

"This is intended for when we know that we do not use the register to be
ignored, and want to keep compatibility."

> + */
> +static inline bool
> +kvm_vcpu_compat_hidden_reg(ARMCPU *cpu, uint64_t regidx)
> +{
> +    for (int i =3D 0; i < cpu->nr_kvm_hidden_regs; i++) {
> +        if (cpu->kvm_hidden_regs[i] =3D=3D regidx) {
> +            trace_kvm_vcpu_compat_hidden_reg(regidx);
> +            return true;
> +        }
> +    }
> +    return false;
> +}


