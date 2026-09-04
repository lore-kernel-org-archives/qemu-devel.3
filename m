Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA1DC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2OnO-0001K0-IZ; Fri, 04 Sep 2026 03:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OnH-0001J7-8f; Fri, 04 Sep 2026 03:57:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x2OnF-0005Oi-07; Fri, 04 Sep 2026 03:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAFPwGvWBSpDeo4uea8wiAD8btLLohzGQKsRLfDqVACvXG81fo9h4An3CCawYawk1vhoxzgZ/yTG9QfHaeRRiHepD7mZepFpkDowqChOoSeN8bw8m+0FOCXXPX2ghl8P3CiMFCR71m/3AdI/Rx6ztwxiXAQ/CfBgkKq5qDopXs/qLBPJkOxUzbJGNrEmxZ6OZjdrcHyduRz4eY538cPScAfg3rgeLr/HDWtxKfl+hfGI55lpL2RJxnHRxyoOE7sxIrqau262cYo8xveKNnSGUD7lEqpeHM9dH9z9ygZmnoTDKMj+OSvhGPd1XGcX+FyZSP33z+D6bMy+j6JX5bsmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNBfHFCkV6Vz9q5SDzA3i3zsgdMgcDEmmkyVEae30GI=;
 b=S2aj73v8sBd0mB8RyLIDOxqmytbF9P2/rLzaytZ8tPz5c+1rTcnLVSboER6R8J2s6EwZvT2GXhhksD9d5M8hr/RB4iSIU6x9OzYNg4JEimsXAurD0HHeDThlEE7d4uP7M+WLn0ZSsgH3PX/1OH1Qx7eQOdtY3inQF/WZxX003duEMOZsRuGh/BU/axNs4q0GA4K6pW4OYc4odoN2ipYSHkKrdchPGFOO2Val1TsrKzDby3NatX5WJ73trT1vKqVKeheVsf9c/HjLtyaJ4TXQoG4keNALhYNWAtYDUt3SsMr/myXpIlqVsghIbXoNy73dpavTftmiH20F8BpvhfZPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNBfHFCkV6Vz9q5SDzA3i3zsgdMgcDEmmkyVEae30GI=;
 b=M5CuToxdnzMQeWzW8jz14+5gh5kKEk6aYQGr72BufD8Lfoslbb4CLQ3uDHihg9Y2/kSJligV7wiL9Hnjm5qdTGWtXmC9J0nsjyn9/4jMhRdWHIWteQFdmj8OKjv7rtzbygIQIGPrhQ/OmU895W7YXfYMJHaOoYMzYRiKl3SEu+1KDUM5zX2bp3nuTAE4wB/Quv6OqAZmxjRHAdI9MFbpk42s/MC10cpo7gxoHoscRi/uscCroLvKLUvB9Li97jwfmKqFI4TF5sk/wC7awlHoXtenUMlOFifdam4x1thQTTik5tLPMmjSc2rfogXeSijkyj9CU8WtBppSRok6BLAV0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SG2PR02MB5482.apcprd02.prod.outlook.com (2603:1096:4:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 4 Sep 2026
 07:56:53 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:56:53 +0000
Date: Fri, 4 Sep 2026 15:56:48 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v9 5/5] docs: add riscv-server-ref.rst
Message-ID: <app5tdclyWG1MlIu@ChaodeMacBook-Pro.local>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
 <20260903183125.682865-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903183125.682865-6-daniel.barboza@oss.qualcomm.com>
X-ClientProxiedBy: PH8P221CA0066.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SG2PR02MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a6eae8-9962-4f86-3872-08df0a5a1540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|10067099003|6133799003|22082099003|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: yHpS3rqPvBYujQqEXTd3Tuwk7wPE/U6SbgCc1HIqk8FCQG4lKm0OUxtU6tu5uxZ8aAVToG/T1v1Cpp1nH6R7DF4KPHEpbz3NcFvrt2OAUk7mCYm1GPdLdWVwKzUs3GDSafhF/KPRmpFxjAMaZVVuHeX28QYhfxo/BY2k0omE1s8pPrnoKPj1iYVSiekOjHfsGUQrZJM/FRvCTrVQHyfnErSaTcnMJY9NXRHA8pM/RTisUYHo6Ho6pm5yN/IhoONnSOQCqWaJUodMgEsCquWjIR9LI/X1s/PpHOY1z9250ZxB2/8RypxvPhbYUN7bVTW6XVC4MffK9CpSnxQPFog7DUvaH1DRu3hTrW8TXqJGxpVLnJRCzpvJ8Y+f1yxtAfqcBnZZT9ze0vbriEhUBSvN1J/AVjjzT6yUJogis0TQJaiN61/A7tiG1lq2DQUDUiFi7hHvuJTR1U1nwDpDSrDMvqQbFRMd+fzBq62wBCVvCa14IsgWfLuqelhXvIzemFJcfvSxyBa5x0uz6Bo0NniDAVMyXS+V96uUv5aqcaRW1uZ4Tos39d74k6VgO2FXhHVK9usXr+415XJ4/gTqTN6JnwT/y0egocarUcByv1r2BW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(10067099003)(6133799003)(22082099003)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0ErBk1rXhg7vO8VQUy5+zV3Ohbc45ScxK70fRV04nZDu9+UeDnj1NxbKPeA?=
 =?us-ascii?Q?WRGamiSsVJ4r65ZDm7NyfTKxp3626bdozB1Tl1HjtOyHh9wXYU326CfwKum1?=
 =?us-ascii?Q?s+7fzsAA5sq6jJMJ7E/QqhLitwd5ct0YGL8RrB1GT0wyR+kPQDS2yWxS4npu?=
 =?us-ascii?Q?YHz77is+YZ8WxJm0RkQh/oYHOcL8DRQMhKxp4vRbO6T7zB6eqe5dEIhLcl/h?=
 =?us-ascii?Q?YHKguFUwqrH7KfOY8S6NfymWIodBcvn8yJNh1kUy9tqGwm2O1UxOZnBJxDtE?=
 =?us-ascii?Q?Ond/2GtluK5JNZaR08uhNZ6xXjRSJ6X3/xbzvdBejW2/dtS8mU0RydhmoL+L?=
 =?us-ascii?Q?7b/kekMAAlCQEWRpaXENgoqYF/kCJsWRzmm2LnsZzdH4uZX43QP0+5YQinni?=
 =?us-ascii?Q?Xj3pDwgDbi3lls9+L7hPIdU9Vlh1GaaVA0gQk1g8zpMeaNBPc1pg0uQKt/Pd?=
 =?us-ascii?Q?rdof6y2HzMv35zb/7Scv/4/BWKChUuWuKRAYXmIz9WYLOPr08iRXZVuMw2Uw?=
 =?us-ascii?Q?1ZUSlgSAfvKsp8zYRgkbsRlOBUlmCrQbqqB/slVnm8g2sNCzbGEY4b48XBPw?=
 =?us-ascii?Q?LNBDl8klilPjrgoiai4mHZDtGj9fMc47SNhY+QGQSqsVqT2LpBXuvW7dtW8i?=
 =?us-ascii?Q?DuGaevA2i9BOD2g2PknobkPdbN+3jq30prLt4kZKCsOZZ/KjED1Z4bvtmQ6r?=
 =?us-ascii?Q?9FMYZWS9v1FIP+DSgRCzAmXR8nzFe9qLqOEGzPJqrulAFpbqPTNXPcXrXs70?=
 =?us-ascii?Q?vfEYjUIOQ+tU7XQGwvYzDS5YGg8m0t7WqPZMzjjIJzIK2MH7IF9bkR/A/vdQ?=
 =?us-ascii?Q?wBJnS2M9mAOH2Yw+c4JtqdPEV7pzfkWPPOjet4SFUhzTG6N/MhV+gzleLK3U?=
 =?us-ascii?Q?WKqcYJBPO/oh5Hcol1BBwP2MwHulOtg5hbZBetVuPc0/kPpPisKy90uyJNu+?=
 =?us-ascii?Q?orLiQsJRV36l03tjG5d+SDP88jc9zoqBXY3T4pBqsc7wl5MLum77m37zgp+w?=
 =?us-ascii?Q?KYUgzz3nM9F/zXeH2NyC3iamJtvpiAySxo9N7/7toBD6g+UM+KLuAI4ckc5S?=
 =?us-ascii?Q?OztPTgVug4XxY18X9GZqXt3bU1HcU8ZH00HPpnll7s2bSRnDXOiboLch5PGn?=
 =?us-ascii?Q?OqBu7xKAOdIBDfucQn7AwDVbdiiV9/jb5a+EdtGuGOZ+dMRRAI5LbIXm+obR?=
 =?us-ascii?Q?SbI0Xbjbipi14paodLgt3mVfcbZn3INfPnmJ22P5CnC824e/1/5gt9lEt6Rc?=
 =?us-ascii?Q?U7rBuoAj0Lwfnds4HLcE2W3WwZ7DLk3PL5mAtc6qaN2U5m/nLZVF+imrMVVb?=
 =?us-ascii?Q?jTqGyLDLTx8eH3/vOm0oKv7thDFXt11ToBUpYzLbiSAv4xb0GV/GLMnHQCAV?=
 =?us-ascii?Q?SjEUkQqsSBnBUu+30+dtevVy5DUh+JHNqFIFy96ZNlcNI8J6QEiRb/uLxaZL?=
 =?us-ascii?Q?tcNVD/fjq7ePCmXFHM0NTtTexHAkCYY1n1e/Qow/Y3MgvTuvCrsGA+ag530+?=
 =?us-ascii?Q?CxLmvdTHOARK1LuHRMflZPQFWI2++taDWfAwHEH/MKMIHGl4BuYNcliRcf22?=
 =?us-ascii?Q?evQrZ2gIYiWh/Dp+EmKI5rvcKrVmIfs8AcgLp15RkLyS1sMVRud9ABf+v/yF?=
 =?us-ascii?Q?zzCOxDDlBG1Ct1IQRnVIVXdOaq1iEhEtD/dvUpUKoMUjBTk2cukiDSCe6vc9?=
 =?us-ascii?Q?fXxgvRhLgXz7ZMELmWv3denFZm/QME65nvUap7BKzvFiuOXOTyw5gEtmBghA?=
 =?us-ascii?Q?6Tsf0D2482vwQEPM8bM1yr8Q5cNYxyQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a6eae8-9962-4f86-3872-08df0a5a1540
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:56:53.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj/FXMnHu6sUMyvydIc9t7xYI2ijQAp6EQ2P12oxpGsgShQv1WTqWCS6uGWkp7BLrwVJGcDbPAi88JsyOWteBZfwj2bBBuWbB/5z1/7nJq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5482
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2026 at 03:31:25PM +0800, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
> 
> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
> new file mode 100644
> index 0000000000..0573b4e07c
> --- /dev/null
> +++ b/docs/system/riscv/riscv-server-ref.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +RISC-V Server Platform Reference board (``riscv-server-ref``)
> +=============================================================
> +
> +The RISC-V Server Platform specification `spec`_ defines a standardized
> +set of hardware and software capabilities that portable system software,
> +such as OS and hypervisors, can rely on being present in a RISC-V server
> +platform.  This machine aims to emulate this specification, providing
> +an environment for firmware/OS development and testing.
> +
> +`spec`_ is version 1.0 at the introduction of this board.  New spec versions
> +might trigger a revision of the emulation itself, which will strive to always
> +match the latest version available.  In case the emulation changes aren't
> +backwards compatible we'll introduce a versioning scheme, probably via
> +a machine property, to allow older SW to run with older spec versions.
> +
> +The main features included in the riscv-server-ref board are:
> +
> +* IOMMU platform device (riscv-iommu-sys)
> +* AIA
> +* PCIe AHCI
> +* PCIe NIC
> +* No virtio mmio bus
> +* No fw_cfg device
> +* No ACPI table
> +* Minimal device tree nodes
> +
> +There are multiple ways of using this reference board.  The spec compliant way
> +is using an EDK2 image and a TPM device.  The board was tested with the TPM
> +device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
> +to use this device can be found in `tpm`_.
> +
> +To use this board coupled with the tpm-tis device, first start the ``swtpm``
> +process in a shell (the ``log`` parameter is optional):
> +
> +.. code-block:: bash
> +
> +    $ mkdir /tmp/mytpm1
> +    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
> +            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> +            --tpm2 \
> +            --log level=20
> +
> +And then start QEMU with:
> +
> +.. code-block:: bash
> +
> + qemu-system-riscv64 -M riscv-server-ref \
> +     -bios fw_dynamic.bin \
> +     -kernel EDK2.fd \
> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
> +     -device ahci,id=ahci \
> +     -device ide-hd,drive=hd0,bus=ahci.0 \
> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +     -device tpm-tis-device,tpmdev=tpm0 \
> +     -nographic
> +
> +
> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
> +.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 2639866a3e..74e23fa64c 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
>     riscv/microblaze-v-generic
>     riscv/microchip-icicle-kit
>     riscv/mips
> +   riscv/riscv-server-ref
>     riscv/shakti-c
>     riscv/sifive_u
>     riscv/tt_atlantis
> -- 
> 2.43.0
> 

