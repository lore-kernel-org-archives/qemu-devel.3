Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB4EC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 08:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhlBW-0007nH-FO; Fri, 01 Aug 2025 04:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uhlBU-0007ku-Pp
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uhlBR-0000n2-9O
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754037126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZI2Zc4X0XkpaY0Ev3aUpR8Gjtsi7WiqIHtlSAleBW8=;
 b=S5crpO1ERNF8QoHwSTcWeiOM64aurJrQqHm7iILTMKLcXsLkDy2hgXNO81MY/mxEdlZy8o
 f91sCS3bkBHDYbTlhtSxbFyaVO4htQL469Pkv/CoKuHd7o5lSMoA9cHgGubPXn3iaAICqc
 MMZJjTM/RvQnWNe+89ScO37GQghxInI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-OmVkWA4-OY-UPtuhR9E30A-1; Fri,
 01 Aug 2025 04:32:00 -0400
X-MC-Unique: OmVkWA4-OY-UPtuhR9E30A-1
X-Mimecast-MFC-AGG-ID: OmVkWA4-OY-UPtuhR9E30A_1754037118
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9460E1800876; Fri,  1 Aug 2025 08:31:56 +0000 (UTC)
Received: from localhost (pixel-6a.str.redhat.com [10.33.192.205])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 174E719373D9; Fri,  1 Aug 2025 08:31:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shameer Kolothum <shameerkolothum@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, sebott@redhat.com,
 berrange@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 armbru@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, yangjinqian1@huawei.com,
 shameerkolothum@gmail.com, shameerali.kolothum.thodi@huawei.com
Subject: Re: [RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
 Implementation CPUs
In-Reply-To: <20250801074730.28329-1-shameerkolothum@gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250801074730.28329-1-shameerkolothum@gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 01 Aug 2025 10:31:51 +0200
Message-ID: <87freb4f48.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 01 2025, Shameer Kolothum <shameerkolothum@gmail.com> wrote:

> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>
> (This is my third attempt to send this series to qemu-devel / qemu-arm.
> Previous attempts failed with the following errors:
>
> qemu-arm@nongnu.org: connect to eggs.gnu.org[209.51.188.92]:25: Connectio=
n timed out=20=20
> qemu-devel@nongnu.org: connect to eggs.gnu.org[209.51.188.92]:25: Connect=
ion timed out=20=20
>
> I'm not sure if the issue is related to my setup, so I'm now trying to se=
nd the
> patches via my Gmail account.
>
> Apologies if you=E2=80=99ve already received this series individually, an=
d thank you
> for your patience.)

FWIW, all of your mails have made it into my inbox -- let's see if at
least my reply shows up on the lists :/

>
> Hi,
>
> On ARM64 platforms, many errata workarounds are based on CPU identificati=
on
> registers, particularly MIDR_EL1 and REVIDR_EL1. Some of these errata
> require corresponding fixes in the guest kernel as well. This becomes a
> challenge during guest migration between hosts with different MIDR/REVIDR
> values, even when the VMM provides a common baseline feature set using
> the recently introduced writable ID register support.
>
> To address this, the Linux kernel now provides:
>
>  -A mechanism to expose implementation CPU data to guests via KVM
>   hypercalls [0]:
>
>   ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_VER_FUNC_ID
>   ARM_SMCCC_VENDOR_HYP_KVM_DISCOVER_IMPL_CPUS_FUNC_ID
>
>  -A way to override implementation ID registers (MIDR, REVIDR, AIDR),
>   which were previously treated as invariant [1].
>
> What this RFC does:
>
> This RFC enables the virt machine to specify Target Implementation CPUs
> via QEMU command-line, exposing them to the guest via KVM hypercalls.
>
> Example use case (hosts with differing MIDRs):
>
> ./qemu-system-aarch64 -machine virt,gic-version=3D3 \
>   -enable-kvm \
>   -bios QEMU_EFI.fd \
>   -m 1G -smp cpus=3D4,maxcpus=3D4 \
>   -cpu host \
>   -M impl-cpu.0.midr=3D0x481fd010,impl-cpu.0.revidr=3D0,impl-cpu.0.aidr=
=3D0x551,\
>    impl-cpu.1.midr=3D0x481fd011,impl-cpu.1.revidr=3D0,impl-cpu.1.aidr=3D0=
x551 \
>   -kernel Image-6.16-rc2 \
>   -initrd rootfs-iperf.cpio \
>   -append "rdinit=3Dinit console=3DttyAMA0 root=3D/dev/vda rw earlycon=3D=
pl011,0x9000000 kpti=3Doff" \
>   -net none \
>   -nographic
>
> Highlights and Notes:
>
>  -This is based on Connie=E2=80=99s series[2] =E2=80=9Ckvm/arm: Introduce=
 a customizable
>   aarch64 KVM host model=E2=80=9D.

Hm, I *really* need to do a respin of that one, at least to bring it up
to date with the code that changed underneath...

>=20=20=20
>  -Currently, no validation is performed on user-specified implementation =
CPU
>   data. It=E2=80=99s assumed that one of the entries reflects the actual =
host CPU.
>   If needed, a check can be added to enforce this. All other target CPU
>   definitions are treated as user-driven with no internal verification.

Should that check rather be done by management software on top? Although
I assume that this is the part that in practice will come up with the
list of possible target cpus.

>
>  -For now, only the DISCOVER_IMPL_* hypercalls are supported on the QEMU =
side.
>   See patches 1 and 3 for implementation details. These are loosely inspi=
red
>   by Salil's vCPU hotplug series patch here [3]. This may require a more
>   generic approach if we have to support other SMCCC hyper calls.
>
>  -This series uses macros and definitions from the kernel's
>   include/linux/arm-smccc.h. I am not sure whether these should be duplic=
ated=20
>   in QEMU or moved to a UAPI header in the kernel. For now I am carrying
>   it in the test branch here,
>   https://github.com/hisilicon/qemu/commit/8f583c76a2a5f60cf0f9616d61d086=
3e524ef388
>
> This is lightly tested on HiSilicon ARM platforms. A complete test branch
> can be found here,
> https://github.com/hisilicon/qemu/tree/arm-cpu-model-rfcv3-tgt-impl-cpu-r=
fcv1
>
> Please take a look and let me know.
>
> Thanks,
> Shameer
>
> [0] https://lore.kernel.org/all/20250221140229.12588-1-shameerali.kolothu=
m.thodi@huawei.com/
> [1] https://lore.kernel.org/all/20250225005401.679536-1-oliver.upton@linu=
x.dev/
> [2] https://lore.kernel.org/qemu-devel/20250414163849.321857-1-cohuck@red=
hat.com/
> [3] https://lore.kernel.org/qemu-devel/20240614001510.202991-1-salil.meht=
a@huawei.com/
>
> Shameer Kolothum (4):
>   target/arm/kvm: Introduce helper to check target impl CPU support
>   target/arm/kvm: Add QAPI struct ArmTargetImplCPU
>   target/arm/kvm: Handle KVM Target Imp CPU hypercalls
>   hw/arm/virt: Add Target Implementation CPU support
>
>  hw/arm/virt.c         |  66 +++++++++++++++
>  include/hw/arm/virt.h |   3 +
>  qapi/machine.json     |  34 ++++++++
>  target/arm/kvm.c      | 187 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h  |  20 +++++
>  5 files changed, 310 insertions(+)
>
> --=20
> 2.34.1


