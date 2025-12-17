Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B38AD6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 11:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVq72-0002wY-5k; Wed, 17 Dec 2025 06:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVq6x-0002vG-7R
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:54:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVq6u-0002dy-MI
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:54:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42f9ece6387so2235269f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765972467; x=1766577267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luyfPV7/4t3yR5VyywUCSGML8Lsm0XovtUElboJKuck=;
 b=NCsVhVZ97I3r8dfsUyR+7KBPAoYQVgtOjwnijwiRVZEcsksdbzXljQeGz0iBkb4pAy
 ssC8bLD7+oquU8QxnxlCANGBjhzpCzcZy+FD9VcdjNEa1rTUFmYkpSIPKjwwMVtFyUkf
 2tWlwtMDgzGSzXhwlmd8+eALIBoslLrebMpP9A5LbexuCdXNDEtgLXI5xZVs3zdkDLc8
 IXbu2BusiGzgUcw5Z0rqd28Z3SFqNq8BXbqJ6obQgaWWH8dt28EneNdYU9EehDo+FVFq
 DkG/sfWRDzULElUPEmQHgmM0/gagVecDvbF3uE0Ir7fyFE7U26cAc/7S6ASD/QWRwgTw
 RT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765972467; x=1766577267;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=luyfPV7/4t3yR5VyywUCSGML8Lsm0XovtUElboJKuck=;
 b=fduBfzSNOX6NmWpcPDPXYMwo/okCZKuuFNejLz3xjkxiODO43Gk3VSfDTvObesiSg2
 JnSM28Jbnp7cFtodIaNze5OkM3Z8bveKQfyRF1TQkL6IiQeWf7a1tkgMAvvPxboRUVjy
 Ghm92z8yBxacKddAHSUiuk/senKtMMnZmjz6Cz/SwQCoEDqNRYQCw9ZUdfUNk9bqdtdj
 45rAQv6vGcOg77tGkOrDS/bFdbmYWtUSFJUoj8b7lIPu7E/AJWpL07n7wgsyIS0RuAnS
 U1vXDlmxxYnq12pcpCVqo5fuUT3XmmHZzKP/LNAC1zb2VXTSSH4OySIHI1vVPVfzQmXE
 1KnQ==
X-Gm-Message-State: AOJu0Ywl1xszCVw5AjQdzlS0H35SYU/9KEvfvrh57Hsq+kin0pdeOrs7
 pZAmCcMu3P7qk8TnVvXSTc9Gm+VO/RBrUEafvz5SvXK4SZMS6oqTQiNh6T8qg4oyB1XfmZhvJqW
 pYbHD
X-Gm-Gg: AY/fxX4W98PDVxZbXJBEzdImlJD/hCawTK5Z1MOHdyTLc1FcZGI3zeGU7GCUVRHGl6a
 s7L4mIFbrsGvTA3VjO8ivwP16hN5aeRwY+BYut1OGvYFrthTPVCTPGyPyZmDqkww0AWbX7xbiLU
 aiB+fJTDqDwG2pBoJw9e+hklMWl3DJ/oRnwoAMh3dSNXyi7vF+Wd1zPZJJgcWymOGdwmvDnMnrD
 oxpb0oZ/ypkkeCy6Pg+yxeR8b1n5WJaWN0u4Wq7I792YbQ3aPK3K60gE0mm5RW2qSKg5LajQMoH
 ICTX1IWEaRaYC/yOuIxFk0M8WrXlYOXTeGX2wcLQ34HIqfHi+XYOkhgbZkNChORe5R4mPD9KdE9
 4//04HFh6CgbyV58ccN+6N2OKrps+G1jL2NzY9R8Tgg5xq6xzyAjiWseAtkbOqYTAvm+KpgLGl1
 QyunYRNlryC0FTcIjbuDs5OA==
X-Google-Smtp-Source: AGHT+IHv5zaFrjfetTCL2cL2vVZD30JmPCDOb0TCX9TO69Orz7TijJ7dqlGRhtMHv4yJJjiLtbGg/g==
X-Received: by 2002:adf:ff82:0:b0:42f:bb4a:9989 with SMTP id
 ffacd0b85a97d-42fbb4a9a60mr13120396f8f.28.1765972466659; 
 Wed, 17 Dec 2025 03:54:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade8063sm4385439f8f.23.2025.12.17.03.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 03:54:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27FE15F828;
 Wed, 17 Dec 2025 11:54:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org, Michael S. Tsirkin <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>, =?utf-8?Q?Cl=C3=A9men?=
 =?utf-8?Q?t?= Mathieu--Drif <clement.mathieu--drif@eviden.com>
Subject: Re: How do  i know which "iommu" i used on VM? qemu emulated or
 hardware DMAR?
In-Reply-To: <e29aa4d.52b4.19b2a89a442.Coremail.13824125580@163.com>
 (tugouxp's message of "Wed, 17 Dec 2025 12:20:22 +0800 (CST)")
References: <e29aa4d.52b4.19b2a89a442.Coremail.13824125580@163.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 17 Dec 2025 11:54:25 +0000
Message-ID: <87ecot2uj2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

tugouxp <13824125580@163.com> writes:

(I'll preface this with my not-an-expert hat on, adding some iommu
maintainers to the CC who might correct my ramblings)

> Hi folks:
>   Hello everyone, I have a few questions regarding the QEMU device passth=
rough feature that I=E2=80=99d like to ask for help with.
>
> Both my HOST OS and GUEST OS are running Ubuntu 20.4.6. I passed through =
a dedicated NVIDIA MX250 GPU from the HOST to the
> GUEST OS. On the HOST, I installed the VFIO-PCI driver for passthrough, w=
hile the GUEST OS uses the default Nouveau driver from
> Ubuntu 20.4.6. I also enabled IOMMU in the GUEST OS and checked the IOMMU=
 group layout from
> sysfs"/sys/kernel/iommu_group/xxxx/type". The passthrough MX250 operates =
in =E2=80=9CDMA=E2=80=9D translation mode,which means the translation
> really work. Thanks to your excellent work, the setup process went smooth=
ly and everything runs well. However, I have a couple of
> questions:
>
> 1 Is the IOMMU (DMAR) in the GUEST OS emulated by QEMU, or does it
> share the same IOMMU as the HOST OS?

Generally the guest IOMMU is emulated. You do not want the guest to be
able to directly program the host HW because that would open up security
issues. However for simplicity the IOMMU presented to the guest it
usually the same as the host hardware - whatever the architecturally
mandated IOMMU is.

There are fully virtual IOMMU's (e.g. virtio-iommu) which completely
abstract the host hardware away.

In both these cases it is QEMUs responsibility to take the guest
programming and apply those changes to the host hardware to ensure the
mappings work properly.

There are also host IOMMU's which virtualise some of the interfaces to
so the guest can directly program them (within certain bounds) for their
mappings. I have no idea if the intel-iommu is one of these.

>
> 2 Given that both the GUEST OS and HOST OS have IOMMU enabled, when the M=
X250 performs DMA, it should go through two-stage
>  page table translation=E2=80=94first in the GUEST OS and then in the HOS=
T OS=E2=80=94with VFIO-PCI assisting in this process, correct? If so, are
>  both stages handled by hardware? I understand that the second stage is d=
efinitely hardware-assisted, but I=E2=80=99m uncertain about the
>  first stage: whether the translation from IOVA to GPA (IPA) within
> the GUEST OS is also hardware-assisted.

I think this will depend on the implementation details of the particular
IOMMU.

The guest will create/manage tables to map IOVA -> GPA.

There are two options for QEMU now.

The first is monitor the guest page tables for changes and then create a
shadow page table that mirrors the guest but maps the IOVA directly to
the final host physical address (HPA). This would be a single stage
translation. I think this is how intel-iommu,caching-mode=3Don works.

The second option is for IOMMU's that support a full two-stage HW
translation (much in the same way as hypervisors have a second stage).
The initial lookup would be via the guests iommu table (IOVA->GPA)
before a second stage controlled by the host would map to the final
address (GPA->HPA). I think two stage IOMMU's are a requirement if you
are handling nested VMs.

> Those are my two questions. Thank you very much for your help!
> some information about my env:
>
> 1 Qemu Launch VM command:    qemu-system-x86_64 -cpu qemu64,+mtrr,+ssse3,=
sse4.1,+sse4.2 -m 4096 -smp 4 --enable-kvm -
>  drive file=3D./test-vm-1.qcow2,if=3Dvirtio -machine q35,kernel-irqchip=
=3Dsplit -device intel-iommu,intremap=3Don,caching-mode=3Don -
>  device vfio-pci,host=3D02:00.0
> 2 vms@vms-Standard-PC-i440FX-PIIX-1996:/sys/class/iommu/dmar0/devices$ ls
> 0000:00:00.0  0000:00:01.0  0000:00:02.0  0000:00:03.0  0000:00:04.0  000=
0:00:1f.0  0000:00:1f.2  0000:00:1f.3
> vms@vms-Standard-PC-i440FX-PIIX-1996:/sys/class/iommu/dmar0/devices$ lspci
> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Con=
troller
> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> 00:02.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Con=
nection
> 00:03.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev a1)
> 00:04.0 SCSI storage controller: Red Hat, Inc. Virtio block device
> 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Contro=
ller (rev 02)
> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 =
port SATA Controller [AHCI mode] (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (r=
ev 02)
> vms@vms-Standard-PC-i440FX-PIIX-1996:/sys/class/iommu/dmar0/devices$ cat =
/sys/kernel/iommu_groups/
> 0/ 1/ 2/ 3/ 4/ 5/=20
> vms@vms-Standard-PC-i440FX-PIIX-1996:/sys/class/iommu/dmar0/devices$ cat =
/sys/kernel/iommu_groups/*/type
> DMA
> DMA
> DMA
> DMA
> DMA
> DMA
> vms@vms-Standard-PC-i440FX-PIIX-1996:/sys/class/iommu/dmar0/devices
>
> BRs
> zlc

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

