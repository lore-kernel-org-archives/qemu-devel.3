Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3327CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHO4w-0004ew-BK; Thu, 15 Oct 2026 12:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHO4n-0004Zq-Vq; Thu, 15 Oct 2026 12:13:07 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xHO4k-0007hu-V2; Thu, 15 Oct 2026 12:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONeNcxWYd3RUv2FIrsrea0iVPVh73MfYI9z6FZk+gsc/pQBSXNYOuJHQsFynWXT97drVGVzns77WSHDpgW4LYxTZBufNQ5yvFk79rVQEuMCRMUDV4c5Gr0gZUp6IpqwW7bpGpibHhBk2s9Meb9vXiPN8vhHzfbyz3yc9aaDBTS4UzM/5NqYNazB/Daun0GJOuamYwgpETkL5ZUiJ0Z1jbekjbJL0lxT+7/5LIHIjrmXpZVuOed3ssoP/8zrozIEjmoM4MDpLglLI0lkmHwQ2M91HWXduC8GevUONd9eOlP7PfwKeePGCWVteD9fw2UIJPrTRSyD70wSrSHQT/6BA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPiHjz72tk/pXKp+gb8L0IzNVHZTbLVx6mibQhRGhAQ=;
 b=qNiCuvKuHF/QGv7Qi4BxeI7IX/KVa67tYpNK/iPGIsr3swSXAyIlKVD/1SLCXfIdV+q/LGEUV/5ezMyQseN2ik4r/M4G55154ULP9/SYp1Fq+nc5aQl76leSaBoGyEZjX8027e1J7wQjh36+bjiAxCOGkmhnkeavkKNznPhafDFsQ8ufGBEGfZuydGtMQfe584OGgBnH8Ovlt02oQ9Xe+WXc5t3zzUGhujMaVtA7CgAxNVZb20r6+y6DDUV8vDQgGpxqIYoigK1oDQlkpMsNa2Fu7QzHgD5L1UjSoLXNGJLjE2G7gjF95vnrYjxf2U51mQATjR2HdMAYFNeX3nlG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPiHjz72tk/pXKp+gb8L0IzNVHZTbLVx6mibQhRGhAQ=;
 b=q1NbImQpAHSxz/+Z0rwotEfCcg7RtWTwileyGFwo+vJ+wrlDKCYa5iP4tkJdPCpgGx3BVNfZXPSB617ySW0FJsNSXaWzYJPeo3UnH+Mrmh5eTILK3LBu3ryH8XokG8YYlk4HN8SjxGyawsXioC4cSOB0II5M1zSlSrMbI+PZ41L9tM9WMIc7vta/hB5XGtElAVyxirugJ1g1XYxpKMUuIQIfDF5Q7XFR1X0OnbGOWPzTQjPHhpt4TbieTQSQ3TMeAv8/Zw/eHrKilO/XN3C1++SAw1Tf4rNYA8QHbpXE5uws0fmc1rnsdp0Vgh/QoybXi0f3WmlZs09qc7AxmjoLnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7968.apcprd02.prod.outlook.com (2603:1096:101:225::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 16:12:57 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 16:12:57 +0000
Date: Fri, 16 Oct 2026 00:12:52 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, richard.henderson@linaro.org
Subject: Re: [PATCH v4 3/3] tests/tcg/riscv64: Add Zvabd extension tests
Message-ID: <atD7ct2OaRoF-B4B@MacBook-Pro-4.local>
References: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
 <20261015134337.3354723-4-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015134337.3354723-4-liumingliang.dev@bytedance.com>
X-ClientProxiedBy: PH7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::9) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: a27d60ec-0263-41b9-78ef-08df2ad72d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|10067099003|3023799007|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: EjhRJFy8iQoQ8UostZeDw3vAZEOwf2zJtpwKcpiUBLC5Go7hAo459B69uosu03YAv//H0hSPJrJXuyqHcT0712cdq6MAt/2LdX4KAoCVtznjyCx+bloMk4HMjkUc/d7MsvyuUAAHQDU/1kbmsE8s6cCUT43BqCWab+9E+kapDPQq2IfymdF4pm4Q5RdqwnNuQpV1Uoz5zAjkhdEYCvP2xFEc2w2N0ybu8gzal0eLAIDWPD2PRygTD07mqFCrxgm8SbdNHYTL5+RsfoL535lccQu6/iDc2+T3vJOWMeMsr21Pr3yXyafL4Qg3ZNXV0dYPj42mklX1pFrbGUOqD73ROZcih2ChYFXihcuxzWr+Ar96Mkh9Ae3w6syoSDbgOj/PRx4tVKxTjqHsEDQEQ4xLgRvh3BO3j7g1dwBWJyihdqHCkpgM2V7C9+6iz0KwKJqKz5wc2EBzhD4hkwsaEc1CWVgw5Uhe2MsAtydPhw1N9X0xkQLPo7SfaT7FWTsbTSBbpH6wMAaRTk65sEi3nXN4DTd58FNHgNV6eJlbxjed0XwOIenGhbR7dnKN+Ib129ptAWtMiTO1HNLrtokHkOZ+JLIIwVvgqAWxtc3m3biNjyyEdThkiTVLqy8L3ntv6vgv22TWPXFsGR2NDd8aHK+wdrKsSTMHabcb8r7+iOq9mRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(3023799007)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pjTKEgooyZBd8DjEreWFcw1c2bwFchVX2aciiDJvh/uFs5KkTr6pfQp3H2NW?=
 =?us-ascii?Q?dw2f+Fk6ws8/e5mi8kfFZFmlgE/XndVWKCoc2W6yhYGH98e0CZwRFvSSzAQt?=
 =?us-ascii?Q?mg7F0W8IiIU6Ek/kwqSekxL/RI6LjUOmeAWXvZCRO/6+04PaZx7CX40AS2Bf?=
 =?us-ascii?Q?ICWbuSzlB2YX27VAW4zMI3Z+Vlmy6ydcx2721xOkHCqj7oqdHtcZmyjvsLXB?=
 =?us-ascii?Q?CYMkXRmFcq3ne2QHTM7k7JLxuljMpLTy9kt8Pdz3bbz0hy11yeiO9SKz+ah1?=
 =?us-ascii?Q?Y/PyIF2Pl/mi5h3zPYIbfOJG+jYk4ZeUNHd0yHgKtDI4EFsgwsniCea5QYuY?=
 =?us-ascii?Q?+B6bjGyzC1yELnqRTNxxhAfNy/sWF43vc6QWtZGgeO76J2NAftO2TJ8JwaiC?=
 =?us-ascii?Q?CtwHPY76bKKkBfM2gL64okeYhZKRAaPCUi30qbimcgVEDHmAhMUkDGJV2hkz?=
 =?us-ascii?Q?rc1mb0lj/KMAL1O/sgzzEIZ/kfZvfqTdS/AUEOwTSBVNf7hMB+xKe0aPYrmj?=
 =?us-ascii?Q?H4t4t0OAb5qvQt+CNZ6Co6Mv9Ky0kw0qEe+0tvumQUZzEzsf8PKx/mLpVOrD?=
 =?us-ascii?Q?ENRzK/dK9UvqvohIOD1LcUBCAZ/tirh48zBhFYWt19NoDvsBEHrZS3PBa78N?=
 =?us-ascii?Q?IeciuGMuoiIi8024DZGnDFxmFkCMZmqSCFjHjY82Wh1/oyqmYGxkiuj7baLx?=
 =?us-ascii?Q?mktqNIXqe8GpYWy+9aKayvmYq+dqyYyBf/VJxZHMC/X43ZY9VESPJX+1Wt/o?=
 =?us-ascii?Q?MlbSdVg8z44O/mYIi0H2Th6WSZaL+8kvh74/cDWaa0ONXzszGv89SK7/hORD?=
 =?us-ascii?Q?1EX2PDIJ4AKIKYQVF+RFq9nk1CfrK6R7KYO1cMgwfcoR6WwqmM5KVPEaj5UL?=
 =?us-ascii?Q?O2Mc25Gn3L4rDzGylAMYkYm8DjoE7WIe17qYhGvwC6GLBQxqZUpcYqR7Jtvu?=
 =?us-ascii?Q?3tP1drxfzjQW3ntIxjIxB+OwAlJ37iR8TCArnUYwALQvK22wrgqMSH0h6bN0?=
 =?us-ascii?Q?5z8EcteKXIp1qNwoyk8XRhbMyUkCY0iVYKlwNugnTij6+G6I71HRhplNtkTM?=
 =?us-ascii?Q?KBtYOwTAiZHpJKFEyHZtwAmWhD9juVLFAYsjMa6Xpy1qhlc3CGFWpzBbSG9F?=
 =?us-ascii?Q?qvFaW3gd/Wlmad2KNYUgUbRToj3UBmUBnkWUYdQuNoDHG7RnfR+wMgk0zIab?=
 =?us-ascii?Q?VYQK0JJQdqrvbQvMB/zeX07jysm+STg2n7aU3kGPEjc9VX/Onc56au/Uxn85?=
 =?us-ascii?Q?OtScsdu/X0Bvq5nA5RMeCMzre54xeDURsx1mv+ivORVsb/Zpx7PZ5g6HW7BL?=
 =?us-ascii?Q?VsZVVAEpe33VQU+Qamzym/mjcpPxvG+toG3vxh0a4LjHqCnF75G8cDOxJ/D9?=
 =?us-ascii?Q?ptk3fc+7gKjAGUlP+gK6yHyKxt6zdJ4OCcmTTOUG7ia7G/IK/UHEFDE1ap0P?=
 =?us-ascii?Q?1b2MHbnJht+qz6hfHrEbEghAiGRURZHli/ClRYKy8MbMnPvcLTr+wZyFvWji?=
 =?us-ascii?Q?H4uqup/DKj5nz5KdcGtf3Dq8AlUREQ5fS62IBNcPw7/zskCFTDPRWQUeE0iD?=
 =?us-ascii?Q?/+bzekSa2Jp86fI1T6DoVTh/YCJyEKE/our1Nl1E75MRtzu1e5axFw8z5+6j?=
 =?us-ascii?Q?fwDlsYMRUmMVd6BRDlAF2Q0P6O4fOaB4OBAimW7TPCUwuSclTtIQTld2/uQQ?=
 =?us-ascii?Q?fT0oijEfJZLF350J0qMYigwUZrLBWPPEyNYkqk5iqILtFpabvtpNpQtkPE8O?=
 =?us-ascii?Q?CmgtGhfgcg196Wi7D4K/O9uZqRm4oFE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27d60ec-0263-41b9-78ef-08df2ad72d05
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:12:57.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: necsRoVpigm50YI+Qh+FC6Wjr7x0pCc9e0Ar1OPQIWw9tBDJxXhQyBOhXI0W96KiDnQ2wAHfBrcADTZ7HlXjlaWZLAbFTQXu2CTLJD4gwKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7968
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

On Thu, Oct 15, 2026 at 09:43:37PM +0800, Mingliang Liu wrote:
> Add a RV64 TCG test covering the masked and unmasked vector-vector
> and vector-scalar forms of vabd, vabdu, vwabda, and vwabdau.
> 
> Assemblers do not yet support the version 0.9 instruction mnemonics,
> so the instruction encodings are hardcoded for the time being.
> 
> GNU binutils 2.47 supports the incompatible version 0.7 instruction
> encodings. Therefore, this test must not be built with that version,
> even after it is converted to use instruction mnemonics.
> 
> Co-Author: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  tests/tcg/riscv64/system/meson.build |   1 +
>  tests/tcg/riscv64/test-zvabd.S       | 659 +++++++++++++++++++++++++++
>  2 files changed, 660 insertions(+)
>  create mode 100644 tests/tcg/riscv64/test-zvabd.S
> 
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index c2d7d09887..4ab0529da4 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -24,6 +24,7 @@ tests += {
>    'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
>    'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
>    'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
> +  'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
>  }
>  
>  tests += {
> diff --git a/tests/tcg/riscv64/test-zvabd.S b/tests/tcg/riscv64/test-zvabd.S
> new file mode 100644
> index 0000000000..4f91acea0c
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-zvabd.S
> @@ -0,0 +1,659 @@
> +/*
> + * Test the Zvabd vector absolute-difference instructions and the vabs.v
> + * pseudoinstruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option arch, +v
> +	.option norvc
> +
> +	.text
> +
> +	.global _start
> +_start:
> +	/* Enable the vector unit (mstatus.VS = Initial). */
> +	li	t0, 1 << 9
> +	csrs	mstatus, t0
> +
> +	/* Route synchronous traps to trap_handler (mtvec direct mode). */
> +	la	t0, trap_handler
> +	csrw	mtvec, t0
> +
> +	/* Run each test function. */
> +	call	test_vabs_v
> +	bnez	a0, _exit
> +	call	test_vabs_v_mask
> +	bnez	a0, _exit
> +
> +	call	test_vabd_vv
> +	bnez	a0, _exit
> +	call	test_vabd_vv_mask
> +	bnez	a0, _exit
> +
> +	call	test_vabd_vx
> +	bnez	a0, _exit
> +	call	test_vabd_vx_mask
> +	bnez	a0, _exit
> +
> +	call	test_vabdu_vv
> +	bnez	a0, _exit
> +	call	test_vabdu_vv_mask
> +	bnez	a0, _exit
> +
> +	call	test_vabdu_vx
> +	bnez	a0, _exit
> +	call	test_vabdu_vx_mask
> +	bnez	a0, _exit
> +
> +	call	test_vwabda_vv
> +	bnez	a0, _exit
> +	call	test_vwabda_vv_mask
> +	bnez	a0, _exit
> +
> +	call	test_vwabda_vx
> +	bnez	a0, _exit
> +	call	test_vwabda_vx_mask
> +	bnez	a0, _exit
> +
> +	call	test_vwabdau_vv
> +	bnez	a0, _exit
> +	call	test_vwabdau_vv_mask
> +	bnez	a0, _exit
> +
> +	call	test_vwabdau_vx
> +	bnez	a0, _exit
> +	call	test_vwabdau_vx_mask
> +	bnez	a0, _exit
> +
> +	j	_exit
> +
> +test_vabs_v:
> +	vsetivli zero, 2, e8, m1, ta, ma
> +
> +	/* Load .arr_neg array in v1 */
> +	la     t0,.arr_neg
> +	vle8.v v1,0(t0)
> +
> +	/* vabs.v v2, v1 (vabd.vx v2, v1, x0) raw opcode */
> +	.insn r 0x57, 0x6, 0x2b, x2, x0, x1
> +
> +	/* Load .arr_pos in v3 */
> +	la      t1,.arr_pos
> +	vle8.v  v3,0(t1)
> +
> +	/* Compare v2 and v3 into v0 */
> +	vmsne.vv  v0,v2,v3
> +	vcpop.m a0,v0
> +	snez    a0,a0
> +
> +	ret
> +
> +test_vabs_v_mask:
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	/* Load .arr_neg array in v1 */
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +
> +	/* Zero v2 using .arr_zero */
> +	la     t0,.arr_zero
> +	vle8.v v2,0(t0)
> +
> +	/* Load .v0_mask array in v0 */
> +	la     t1,.v0_mask
> +	vle8.v v0,0(t1)
> +
> +	/* vabs.v v2, v1, v0.t raw opcode */
> +	.insn r 0x57, 0x6, 0x2a, x2, x0, x1
> +
> +	/* Load .arr_masked in v3 */
> +	la      t0,.arr_masked
> +	vle8.v  v3,0(t0)
> +
> +	/* Compare v2 and v3 into v0 */
> +	vmsne.vv  v0,v2,v3
> +	vcpop.m a0,v0
> +	snez    a0,a0
> +
> +	ret
> +
> +test_vabd_vv:
> +	/*
> +	 * Test signed vector-vector absolute difference:
> +	 * abs({-5, -7} - {5, 7}) = {10, 14}.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	/* Load the two signed source vectors into v1 and v3. */
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_pos
> +	vle8.v  v3, 0(t0)
> +
> +	/* Execute vabd.vv v2, v1, v3. */
> +	.insn r 0x57, 0x2, 0x2b, x2, x3, x1
> +
> +	/* Load the expected result into v3. */
> +	la      t0, .expect_vabd_vv
> +	vle8.v  v3, 0(t0)
> +
> +	/* Compare v2 and v3 into v0 */
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +
> +	ret
> +
> +test_vabd_vv_mask:
> +	/*
> +	 * Test masked vabd.vv.  Element 0 remains 9 and element 1 becomes
> +	 * abs(-7 - 7) = 14.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	/* Load the two signed source vectors into v1 and v3. */
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_pos
> +	vle8.v  v3, 0(t0)
> +
> +	/* Load original value into v2 */
> +	la      t0, .arr_init
> +	vle8.v  v2, 0(t0)
> +
> +	/* Load mask value into v0 */
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x2, 0x2a, x2, x3, x1
> +
> +	/* Load the expected result into v3. */
> +	la      t0, .expect_vabd_vv_masked
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabd_vx:
> +	/*
> +	 * Test signed vector-scalar absolute difference:
> +	 * abs({-5, -7} - 3) = {8, 10}.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	li      a2, 3
> +
> +	/* Execute vabd.vx v2, v1, a2. */
> +	.insn r 0x57, 0x6, 0x2b, x2, x12, x1
> +
> +	/* Load the expected result into v3. */
> +	la      t0, .expect_vabd_vx
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabd_vx_mask:
> +	/*
> +	 * Test masked vabd.vx.  Element 0 remains 9 and element 1 becomes
> +	 * abs(-7 - 3) = 10.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	li      a2, 3
> +
> +	la      t0, .arr_init
> +	vle8.v  v2, 0(t0)
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x6, 0x2a, x2, x12, x1
> +
> +	la      t0, .expect_vabd_vx_masked
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabdu_vv:
> +	/*
> +	 * Test unsigned vector-vector absolute difference:
> +	 * abs({0, 255} - {255, 0}) = {255, 255}.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	/* Load the two unsigned source vectors into v1 and v3. */
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_unsigned_rhs
> +	vle8.v  v3, 0(t0)
> +
> +	/* Execute vabdu.vv v2, v1, v3. */
> +	.insn r 0x57, 0x2, 0x2d, x2, x3, x1
> +
> +	/* Load the expected result into v3. */
> +	la      t0, .expect_vabdu_vv
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabdu_vv_mask:
> +	/*
> +	 * Test masked vabdu.vv.  Element 0 remains 9 and element 1 becomes
> +	 * abs(255 - 0) = 255.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_unsigned_rhs
> +	vle8.v  v3, 0(t0)
> +
> +	la      t0, .arr_init
> +	vle8.v  v2, 0(t0)
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x2, 0x2c, x2, x3, x1
> +
> +	la      t0, .expect_vabdu_vv_masked
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabdu_vx:
> +	/*
> +	 * Test unsigned vector-scalar absolute difference:
> +	 * abs({0, 255} - 128) = {128, 127}.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	li      a2, 128
> +
> +	/* Execute vabdu.vx v2, v1, a2. */
> +	.insn r 0x57, 0x6, 0x2d, x2, x12, x1
> +
> +	la      t0, .expect_vabdu_vx
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vabdu_vx_mask:
> +	/*
> +	 * Test masked vabdu.vx.  Element 0 remains 9 and element 1 becomes
> +	 * abs(255 - 128) = 127.
> +	 */
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	li      a2, 128
> +
> +	la      t0, .arr_init
> +	vle8.v  v2, 0(t0)
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x6, 0x2c, x2, x12, x1
> +
> +	la      t0, .expect_vabdu_vx_masked
> +	vle8.v  v3, 0(t0)
> +
> +	vmsne.vv  v0, v2, v3
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabda_vv:
> +	/*
> +	 * Test signed widening vector-vector absolute difference and
> +	 * accumulation. Start with v4 = {1000, -1000}, and the expected
> +	 * widened result is {1000, -1000} + abs({-5, -7} - {5, 7}) =
> +	 * {1010, -986}.
> +	 */
> +	/* Load the 16-bit accumulator before selecting 8-bit operands. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .arr_signed_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_pos
> +	vle8.v  v2, 0(t0)
> +
> +	/* Execute vwabda.vv v4, v1, v2. */
> +	.insn r 0x57, 0x0, 0x7b, x4, x2, x1
> +
> +	/* Select the widened EEW and compare v4 with the expected result. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabda_vv
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabda_vv_mask:
> +	/*
> +	 * Test masked vwabda.vv.
> +	 * Start with v4 = {1000, -1000}, v0 = {0, 1}, and the expected widened
> +	 * result is {1000, -1000} + abs({-5, -7} - {5, 7}) = {1000, -986}.
> +	 */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .arr_signed_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_pos
> +	vle8.v  v2, 0(t0)
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x0, 0x7a, x4, x2, x1
> +
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabda_vv_masked
> +
> +	vle16.v v6, 0(t0)
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabda_vx:
> +	/*
> +	 * Test signed widening vector-scalar absolute difference and
> +	 * accumulation. With scalar 3, v4 becomes {1000 + 8, -1000 + 10}.
> +	 */
> +	/* Load the 16-bit accumulator before selecting 8-bit operands. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .arr_signed_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	li      a2, 3
> +
> +	/* Execute vwabda.vx v4, v1, a2. */
> +	.insn r 0x57, 0x4, 0x7b, x4, x12, x1
> +
> +	/* Select the widened EEW and compare v4 with the expected result. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabda_vx
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabda_vx_mask:
> +	/*
> +	 * Test masked vwabda.vx.  Element 0 remains 1000 while element 1
> +	 * accumulates 10 and becomes -990.
> +	 */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +
> +	la      t0, .arr_signed_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_neg
> +	vle8.v  v1, 0(t0)
> +	li      a2, 3
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x4, 0x7a, x4, x12, x1
> +
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabda_vx_masked
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabdau_vv:
> +	/*
> +	 * Test unsigned widening vector-vector absolute difference and
> +	 * accumulation. Start with v4 = {1000, 2000}, adding {255, 255}
> +	 * produces {1255, 2255}.
> +	 */
> +	/* Load the unsigned 16-bit accumulator and 8-bit source vectors. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +
> +	la      t0, .arr_unsigned_acc
> +	vle16.v v4, 0(t0)
> +	vsetivli zero, 2, e8, m1, ta, mu
> +
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_unsigned_rhs
> +	vle8.v  v2, 0(t0)
> +
> +	/* Execute vwabdau.vv v4, v1, v2. */
> +	.insn r 0x57, 0x0, 0x7d, x4, x2, x1
> +
> +	/* Select the widened EEW and compare v4 with the expected result. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabdau_vv
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabdau_vv_mask:
> +	/*
> +	 * Test masked vwabdau.vv.  Element 0 remains 1000 while element 1
> +	 * accumulates 255 and becomes 2255.
> +	 */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +
> +	la      t0, .arr_unsigned_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	la      t0, .arr_unsigned_rhs
> +	vle8.v  v2, 0(t0)
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x0, 0x7c, x4, x2, x1
> +
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabdau_vv_masked
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabdau_vx:
> +	/*
> +	 * Test unsigned widening vector-scalar absolute difference and
> +	 * accumulation. With scalar 128, v4 becomes {1000 + 128, 2000 + 127}.
> +	 */
> +	/* Load the unsigned 16-bit accumulator and 8-bit source vector. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +
> +	la      t0, .arr_unsigned_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	li      a2, 128
> +
> +	/* Execute vwabdau.vx v4, v1, a2. */
> +	.insn r 0x57, 0x4, 0x7d, x4, x12, x1
> +
> +	/* Select the widened EEW and compare v4 with the expected result. */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabdau_vx
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +test_vwabdau_vx_mask:
> +	/*
> +	 * Test masked vwabdau.vx.  Element 0 remains 1000 while element 1
> +	 * accumulates 127 and becomes 2127.
> +	 */
> +	vsetivli zero, 2, e16, m2, ta, mu
> +
> +	la      t0, .arr_unsigned_acc
> +	vle16.v v4, 0(t0)
> +
> +	vsetivli zero, 2, e8, m1, ta, mu
> +	la      t0, .arr_unsigned_lhs
> +	vle8.v  v1, 0(t0)
> +	li      a2, 128
> +
> +	la      t0, .v0_mask
> +	vle8.v  v0, 0(t0)
> +
> +	.insn r 0x57, 0x4, 0x7c, x4, x12, x1
> +
> +	vsetivli zero, 2, e16, m2, ta, mu
> +	la      t0, .expect_vwabdau_vx_masked
> +	vle16.v v6, 0(t0)
> +
> +	vmsne.vv  v0, v4, v6
> +	vcpop.m a0, v0
> +	snez    a0, a0
> +	ret
> +
> +
> +/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
> +_exit:
> +	la	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.balign	4
> +trap_handler:
> +	csrr	t4, mcause
> +	la	t5, trap_mcause
> +	sd	t4, 0(t5)
> +	csrr	t4, mtval
> +	la	t5, trap_mtval
> +	sd	t4, 0(t5)
> +	li	a0, 1
> +	j	_exit
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16
> +trap_mcause:
> +	.space	8
> +trap_mtval:
> +	.space	8
> +.arr_neg:
> +	.byte -5, -7
> +.arr_pos:
> +	.byte 5, 7
> +.arr_zero:
> +	.byte 0, 0
> +.arr_init:
> +	.byte 9, 9
> +.v0_mask:
> +	.byte 0b10
> +.arr_masked:
> +	.byte 0, 7
> +
> +/* Unsigned input vectors used by vabdu and vwabdau. */
> +.arr_unsigned_lhs:
> +	.byte 0, 255
> +.arr_unsigned_rhs:
> +	.byte 255, 0
> +	.balign 2
> +
> +/* Nonzero accumulators verify the add part of widening operations. */
> +.arr_signed_acc:
> +	.half 1000, -1000
> +.arr_unsigned_acc:
> +	.half 1000, 2000
> +
> +/* Expected results for the unmasked and masked forms. */
> +.expect_vabd_vv:
> +	.byte 10, 14
> +.expect_vabd_vv_masked:
> +	.byte 9, 14
> +.expect_vabd_vx:
> +	.byte 8, 10
> +.expect_vabd_vx_masked:
> +	.byte 9, 10
> +.expect_vabdu_vv:
> +	.byte 255, 255
> +.expect_vabdu_vv_masked:
> +	.byte 9, 255
> +.expect_vabdu_vx:
> +	.byte 128, 127
> +.expect_vabdu_vx_masked:
> +	.byte 9, 127
> +.expect_vwabda_vv:
> +	.half 1010, -986
> +.expect_vwabda_vv_masked:
> +	.half 1000, -986
> +.expect_vwabda_vx:
> +	.half 1008, -990
> +.expect_vwabda_vx_masked:
> +	.half 1000, -990
> +.expect_vwabdau_vv:
> +	.half 1255, 2255
> +.expect_vwabdau_vv_masked:
> +	.half 1000, 2255
> +.expect_vwabdau_vx:
> +	.half 1128, 2127
> +.expect_vwabdau_vx_masked:
> +	.half 1000, 2127
> -- 
> 2.39.5

