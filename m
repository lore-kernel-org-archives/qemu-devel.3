Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC4DC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3mSw-0002QC-Mn; Mon, 07 Sep 2026 23:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3mSv-0002Q2-UD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 23:25:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1x3mSt-0001on-TB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 23:25:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Nmqqf109775
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 03:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=KP2usCOTmH0VO++77k93roTUtED5ix/GG4eF7d8X76s=; b=Md
 pQ0ua4Yh8SofCu7UTyya/VIZR8hTX7Cf7+oVj9sdPFrg12+AVOgcYl07gfq9PPWo
 QB8VUOM5bzSH+CgnLDKEfLWzBXOP8pe+GHSw0L9SS5sJk5THKn3+ceYRn/vwKXin
 UxsK/CfXL8/gPYB1D5F60O/7wYSvHB48PRyVIjMW5Jkv7f4b0GgSlE83Wu1q42Vb
 nV0jJNBr1kbWkVtPLcjtjIo5KnfP7E9euFjBiny4HRmBr4GOrsCWiBJRZ9JleHag
 CXIlUryi1jpBGPPcJGySoz9yXG7FYIAjdhPwuVOqLXkLeO+z5+Tu2qgDSVWAo4qK
 aJo55lYzJDlIdxW/1QmQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty32x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:25:40 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66f8701bc37so4458132d50.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 20:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788837938; cv=none;
 d=google.com; s=arc-20260327;
 b=qrrlBm7/FBDYgEy9jucoeLUU6W9RC8q8j0t/dDvJTTcGMZRwG/3i6np4lqvdesJEy5
 vhob1leSyZSxGIMMC3PYpyks/u2Ew1E9NqZd8neqdPMNDJ5NOSiz7Ol17uiaAbtjjSLg
 dy6qW8XJp39a602cIjm8m5ywl6P4EZURXf/NEWFw6x3GruCQhtycphAg+w6ReyraraF0
 rPJABEBOnZ5UoHs3aJBUMYlhEiyhcju/bfSBs76GzI1QvvIsoiOWtWPcJI71+fuOyrj8
 5T0ScEI57wGnM77N152OZDQchxgLpiBfREtNtQvkFWl51hKuNYC9J5x6oiHBE123yhKM
 2+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=KP2usCOTmH0VO++77k93roTUtED5ix/GG4eF7d8X76s=;
 fh=VSzHxPbHRmSNZwdw6rn8QGPxfGx15VOXOYS1bPz7CvQ=;
 b=VYs/3yA6mCIAfcunZiX5kOlL5e04RPO3iUA4Dl71b/4wvCOWeZDzCfpNlyjFKYWHWm
 xbCuAfXB3OgRpDx+K4eem6HpBPAisP+XQfBm+59u/4o9YHzDY4V5tNtLSe6M4X5I6ncW
 8lUZ/sX3qSmb3NfL97Ip1YL15uvdonz8nNkAnP6VuQo0fLBUr/yy6VA8+0l5zjB3an6D
 XxbF0lsA2BBxRiLOVKSQwncQLMOoPRm1e1akl+Z/fvWv7AF6vFKxxHqL+V5Dqw/37pGZ
 yxfnVxpIr2Iqa6ZrAbHoyVBKds6QHc4SMRI+v75iTMCPZkGHR1s8s9ltR/wqooeXXFYz
 l/aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788837938; x=1789442738; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KP2usCOTmH0VO++77k93roTUtED5ix/GG4eF7d8X76s=;
 b=Xm/fYpLjcBCisBDL/3VMOXdsFrSII4JfZ4jxycIXWQWAJ74a+c4Kazv4F3qQw1ktdX
 cmbuxGFQZflX+Kcv1jxT50YCLL0oS3Cu7PmOYKXq7k51q154KfzpbbR2OzDr/xSYDm3U
 iI/4MZpCzaQuoyJ52oyOVQQp+WFfqQAOpussNHuLV4nudJB0cV2nbKKEZGW3TnpuQm+g
 nIJ1Cjjcup9qcixbMJsx1D5R5PuZoDQqsXXnKi9IcdqO6qPgR7yFMsxn+V87moZ+gp92
 LcaCTUE3sxuZbuwpHlvGOe86BQPU/KgVtOz+QuYajyINqP6nz89V0E3B20ya8/AFGTvB
 83WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788837938; x=1789442738;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KP2usCOTmH0VO++77k93roTUtED5ix/GG4eF7d8X76s=;
 b=YhsSgSAT8Q8GfQHJL5iPIBxdjlXtJ+353+xAFP1JQN+4zapxu6mCwEBauNJeK0mxen
 zC5L+42ngRN29H8sXyu4EHLkn7sc4P4hKYsXlMHvT53X30R4LMA2hONsI0kgy4nPdr2+
 Z6lN3RHSirLP+UVOOP5Yvc1Xmir8X/3Q7sopBqKRSEgkEH0xP5MvSWJ1AaNKsBGUup5M
 DP/5QMPpAq0SPAdn5IGYzV21O6Unw8mhah5tOaVdP7HHjmDueGZiS/dGogSoFpG4v04L
 0epSk452M6yzpq8SqySm54XHpCEBGj1B7E/iNwiaZCy1sNuhTBBVzqNypaUyL4GHGNpl
 9meQ==
X-Gm-Message-State: AFuF++kh1KYF8BWGhqhOCfFSk5c7P5sd1bmDXoL6aJ/HS9n4DbsQm0a4
 3S6UgnPxR6MekBKNw4TbKXPbSRSPF32Neqte9PMTm2/SAm4bz7vRKSrJJG5pQ79px1fqzb9gT3n
 AAx9keCG0s7zIMYTvUpiG9HLX0O1Wafx5VvpCMB9AoCxVYi/Q/dPTfI361nyIaPAazznzgx2yD1
 mjNZK0skCHz3t/Y9FhnIY9Af2XclODR8tl
X-Gm-Gg: AYBFou0IJ3uuHMT81+lolV0zPJivYE1OP0g6Kl5apOSI9RMpUTI8Cut6CuSjKhtaMpQ
 vp5fX/59q8uTIuWuydKjquMalj8t7iJZbLj1Gy9paJh76e8JY+eHVYasOYTVNIj558WL3WDrdP7
 eDfop9b+6/VxQTIxAGdRLblPWX5LAcTaaY2w26c6PvZMx4jQ6K+G5YJxWVs40=
X-Received: by 2002:a05:690e:303:b0:66f:c1bc:8802 with SMTP id
 956f58d0204a3-66fc1bc8aabmr4131944d50.91.1788837938457; 
 Mon, 07 Sep 2026 20:25:38 -0700 (PDT)
X-Received: by 2002:a05:690e:303:b0:66f:c1bc:8802 with SMTP id
 956f58d0204a3-66fc1bc8aabmr4131941d50.91.1788837938018; Mon, 07 Sep 2026
 20:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260904195610.964829-4-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 08:55:27 +0530
X-Gm-Features: AcwNN1UpP4p94Nf0S2-dGuE0Ozhv-R0Blkf9LtQQWoAvF_rbUPL-9S7IgJls-zc
Message-ID: <CAB19ukHt--R2yOYY4Hvgt_WivUra_5__UQ2iR4L5ThtkDqu0rA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, Nutty Liu <nutty.liu@hotmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9f8034 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=FRSEYCzRAAAA:8 a=3-jTmmn3dq_RgqUApQoA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=F9tHCgz3TLBaZgltkx5D:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: fseAYSBbcUSOmMKyQrROyHeH4UZr5n3B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDAzNCBTYWx0ZWRfX4KRoLQIndx2b
 cSYfmkkmHQaVdEO+apEy9BbdmNiKA5tanhLVLnCZuY6z9DEVT+T+Tuef6LfYIJ5/WY+xwHJEq3z
 wGkGX2IN6OQO5a5m/iBT0dO9u55cZwg=
X-Proofpoint-GUID: fseAYSBbcUSOmMKyQrROyHeH4UZr5n3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDAzNCBTYWx0ZWRfXyDqGm3ksQ9jX
 hqxO3xIcUasTN3lu1+O8UbujefIN8ZYAQVVtgksmT2zzLP7j79i3oPmXYtr+msCVCE+EzWxmqXn
 3q13jSFAO/SJPSxKMgSG8BW8aqBWHjhGk28DVTj0gIqstLfvFu3w+9ls+X6BW7M4zqZY7WnWYZ8
 CrSEz191CgM/jUS5bJLepwYcAx9OoeC8vRYfrPbnokb9G12ofwOYqik4I3cwJJdZTQg5RiAm0PM
 tfKX31YFv8wZ4vfwXxEbsEbQBegXSydUKaEeeXXtZGW0YCMLGMZ4ybNG0tEXppN58ZgDQAzbpQZ
 G7hOe9hrvvDvNvclPpoZMWkxYnWC4/HwJtpikQsEPPDbqKMSu5RfjSklMzSZ3JTBN9Uca/pp2Qp
 8+HFT/pYsYQV+A5pvOuKHfBOOEJz/e7PfHvvaeBfqs39GvGVH6vPgusIQW9hRDV9Wzx90HHe6z0
 BsAyEcdyh6tFUeDef3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080034
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 5, 2026 at 1:27=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> The main features included in this emulation are:
>
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;
> - No fw_cfg device;
> - No ACPI table provided;
> - Only minimal device tree nodes;
> - a platform bus for TPM support.
>
> A note about TPM support:  TPM devices in QEMU comes usually in two
> flavors - emulated or passthrough.  A passthrough device requires a host
> TPM device that the QEMU process can borrow and it's usually coupled
> with KVM acceleration.
>
> To use the TPM emulator we'll need help from an external TPM emulator
> called swtpm.  More info can be found in [2].  For our purposes this is
> a process that, if running Ubuntu, can be installed via 'swtpm' package.
> We'll go back to it shortly.
>
> For now, adding support for the emulated TPM device 'tpm-tis' (other TPM
> flavors might work as well, 'tpm-tis' is the one tested with this work)
> requires a platform bus.  Adding a platform bus will open the door for
> more devices to be added in the board.  This is ok - a reference board
> isn't a restricted board and users are free to add devices at their
> leisure.
>
> Here's how to use tpm-tis with the riscv-server-ref board:
>
> - in a separated shell/term run 'swtpm' (--log is optional):
>
> $ mkdir /tmp/mytpm1
> $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>         --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>         --tpm2 \
>         --log level=3D20
>
> Then start QEMU with:
>
> $ qemu-system-riscv64 -M riscv-server-ref (...) \
>         -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>         -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm\
>         -device tpm-tis-device,tpmdev=3Dtpm0
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
> [2] https://qemu-project.gitlab.io/qemu/specs/tpm.html
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/riscv/Kconfig                            |  16 +
>  hw/riscv/meson.build                        |   1 +
>  hw/riscv/server_platform_ref.c              | 769 ++++++++++++++++++++
>  4 files changed, 787 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

