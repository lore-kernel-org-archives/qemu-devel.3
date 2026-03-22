Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B250FC72C4
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 15:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4KwV-0007jF-K8; Sun, 22 Mar 2026 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1w4KwU-0007is-1K
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 11:42:18 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1w4KwS-0007MB-4D
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 11:42:17 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4680a2493a2so240047b6e.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 08:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774194134; cv=none;
 d=google.com; s=arc-20240605;
 b=TXJ/9cysZrmJBQsqtjHBiIr9xvExic256ihljS13D3TS2ZPHzhlR1Ie9eDK94xJUR7
 vRpRsaczEby2W2cCLHP/eD73Yz9aRcbOrndmIo2eECVbwfzgvcykYkN0FhfYEP/0/4CI
 zI83pNdVS0mzN2bdAwoUxkVu1C32qbu4YcEkFFRC/7ZThyZbBw+0TeI+LwYgq1VgkRQv
 Wx/sWnB54rsltOyTTKrjDLbgFDdhWEXVCE2CtQjmLXU4URNi4juyuRmRDT0JBVLhj9ld
 tLvkQXplXwsSDc9qupGROv6Pe5gku2B6w4inLZD4id7lisv5u5xiwHQrGSolx0P+eNTW
 vOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CDfk9uTIFtF+Db0kQJ+vICUC9fj+8HtySEf/eFTaj9g=;
 fh=LqFyDCn18dhAJw+gpkoDMxqMqspxmWzq5pbrPRkZ1fo=;
 b=ErYknRgencRQ2ij0nC24Tedidme7U8d3EjKZ8x/21ZmnJfaGiQMVUuVj337x+974rw
 GvuBufsHwgs0GqcB1KQ62qOUdrXj+ErKFupFMIEszAcKE0xLAdTqoS15OdneLK4f5jMr
 belSed5LngSyGM03NsngpiCHf0Dkx3FxxJ+nURGl9jX9HDutmQE2j6R7tuyd1fEMLytJ
 3NdJYtElUQuxGteafcrWK0/CwqRoaTHTdC1WUlLdsXZ86Qt7mP6pEWamxTWO8lRUcl0F
 PbA9gCNBt8hn6RPGoEdYIlSRFomx9S/TUJeyMVdGk6BPTcSf4UKNQE0Ijnjz8fWXoMoh
 jrmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774194134; x=1774798934;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDfk9uTIFtF+Db0kQJ+vICUC9fj+8HtySEf/eFTaj9g=;
 b=l2YziBZejEijiTJ8BQhw53BfnQUWYB2xUBlLMJh5VDjWodWIw8jiUBiK2/7qacitOW
 B6NeLgOibpORcGEaqVRFIdECyeUIxbrKoDcY/9f6IRUASErkOJf5aOUpsYyjqHfQBQem
 OC44FQB7P3JprCkZfN3gfuXAQOb7C5BPcXt8Ahx1buapyGY+JneTr9XVyH8xntnFV6Aw
 4Gdm5jK+tMWL4obh5yNTxHWgknchzVe/GZ8dMefn0flD6heZvsyKk84Ji70+WZ7XE9Q6
 q2EFj+yzpa61T4wfF4w/0CUGWA1qIQtfJEK6pE1b7NDianqxn/Xl85pY3hB/vKahn7xm
 UDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774194134; x=1774798934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDfk9uTIFtF+Db0kQJ+vICUC9fj+8HtySEf/eFTaj9g=;
 b=a9sBUbwXBXFddq00z52zEhD3Ld0FTf9GywF2VUMXFs6skgwkgoNl1TxKLuM6oXGJM/
 RiExtY2ZEJKoGSADfSwF0zTx8Trhny59unz338iIz/ZQLMk2dH6SlMDWApdS1w+WwM8m
 FZLdxIXxfwDRy1oBrPEPH2LfmeKrQsXpxnkRA6JRW4J24LWErMW4Qwf3UlsFb9ofgleG
 ttIvQpcvfVNZgBMB1wAHKlFndEnAFnbi3YreULREioNeW3Tpzhjl+3T3U0A1BOwHzc3Q
 2oXbDsLSYoCrAGAhqd9ONzvzR8V8PDrdqe/DvhpDlIMsFZ8G3daHojIMy5ilUvtoWzZY
 iTlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWZYmkZiQuJazo8dukNDP9F1bxO98zrqreUTy0GTQlkOnfT2uu4xcjDR8aaekYPVL2XZfXk9m6ewSS@nongnu.org
X-Gm-Message-State: AOJu0Yz9cEmWVnic9cZKAAaX3LbvjRK/FE8+xi0jYy1mLGoOR9ZvKIio
 MBV9MwyPcTNecXzhY0G0yk+eI0TJEXjY1EtzpOSw6W60d6kRRkdfo92+GqXdaSF4pXqi3oQTJER
 hvMsASs7b7wyr7KGCJuw/F16Meda7c1mb3Ept3E8swA==
X-Gm-Gg: ATEYQzzatLSC/Nni4e21qmDyLbZXbEJjjXM90CiOWpupmv8/EzsCVEl3qQe4vpTEeAh
 WvTdMsJHY0I6HLpkGpm/PYbXGwqchbR1Tj9sUwfexERkZvejzpD3i/XNcjsesub1RVlVMBY2cnR
 n/Sl/XZSjpJCcN6gPKXSGFYbd7MtmwxAk70y5Bs+eSALyCjYxBsfwgQYlz7WYSKCL+RvyYCvwiI
 hFihafLPH3BrQGLi1BcI8D/J2VJijrReiDAxMm+pA6GZhO+jlX2Yd93Pw6/oLNfWMln9RLLdFch
 76lq3Uea9IabCwBuONLC3eHEbx5vF9vIKNwAjN4u1fULE/zZcQoerWcAsH8ClDcglsNeDK/Qxow
 yt1DCxpTJSiQ7s68LM+QvRIhl/A==
X-Received: by 2002:a05:6820:198b:b0:67d:e29c:8d86 with SMTP id
 006d021491bc7-67de29c8effmr2431772eaf.6.1774194134423; Sun, 22 Mar 2026
 08:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260319110005712RbJuYoQlyLGr39EPL4uH4@zte.com.cn>
In-Reply-To: <20260319110005712RbJuYoQlyLGr39EPL4uH4@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 22 Mar 2026 21:12:03 +0530
X-Gm-Features: AQROBzCxVAOeV2TM1QN4_6nMQpfPVn1JN1kkjmlWWpaj90P-Epo-nLaNSmv6YIU
Message-ID: <CAAhSdy1YMw1qDP9VSpi2YpXoNURaJb8pTngNFcNCCqNRiXiezA@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 0/4] hw/riscv/virt: Add acpi ged and powerdown
 support
To: liu.xuemei1@zte.com.cn
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 sunilvl@ventanamicro.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=anup@brainfault.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Thu, Mar 19, 2026 at 8:30=E2=80=AFAM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Add acpi ged and powerdown support for riscv
>
> Changes in v6:
> - Removed unnecessary condition when build ged aml
> - Link to v5: https://lore.kernel.org/qemu-devel/20260204182041057hohVHgm=
aAJborE1DrghXH@zte.com.cn/
>
> Changes in v5:
> - Added a new patch to allow DSDT acpi table changes
> - Split a new patch to support ACPI GED
> - Introduced a condition for calling acpi_send_event
> - Link to v4: https://lore.kernel.org/qemu-devel/2025111309270952219AjKpV=
EnbJXB7fcGTE4g@zte.com.cn/
>
> Changes in v4:
> - Added modifies of DSDT blob in another patch
> - Link to v3: https://lore.kernel.org/qemu-riscv/20250723113739751COZ5PkR=
zx6aXEuKzsHhm_@zte.com.cn/
>
> Changes in v3:
> - Added missing param to virt_is_acpi_enabled
> - Fixed failure of bios-tables-test
> - Link to v2: https://lore.kernel.org/qemu-riscv/202506201130099861lTkD83=
9Hh6oko8Jo2W2H@zte.com.cn/
>
> Changes in v2:
> - Unwrappered acpi_dsdt_add_ged function
> - Modified base address of VIRT_ACPI_GED
> - Added conditions for function calls
> - Adjusted code formatting
> - Link to v1: https://lore.kernel.org/qemu-riscv/202506191556260735QxWC8s=
xRwFURYEvlD24y@zte.com.cn/
>
> Xuemei Liu (4):
>   tests/acpi: virt: allow DSDT acpi table changes
>   hw/riscv/virt: Add acpi ged support
>   hw/riscv/virt: add system_powerdown hmp command support
>   tests/acpi: Add acpi ged and power button in DSDT for RISC-V
>
>  hw/riscv/Kconfig                  |   1 +
>  hw/riscv/virt-acpi-build.c        |   8 +++++++
>  hw/riscv/virt.c                   |  37 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 ++++
>  tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>  5 files changed, 50 insertions(+)
>

The problem with supporting system_powerdown HPM command
using ARM-style VIRT_ACPI_GED MMIO device is that it only
works with ACPI and does not work with DeviceTree.

We have the system_powerdown HPM command support working
for both DeviceTree and ACPI using RPMI SystemMSI service group.
The corresponding OpenSBI and Linux drivers for RPMI SystemMSI
service group are already available upstream. Only QEMU RPMI
support is pending to be upstreamed.

The RPMI v1.0 (ratified) specification defines System MSI service
groups using which QEMU can send system events as MSIs. These
system events include poweroff request, reboot request, CPU hotplug
events and much more.

For QEMU RPMI implementation using libRPMI, refer to
the dev-upstream branch at https://github.com/ventanamicro/qemu.git

Regards,
Anup

