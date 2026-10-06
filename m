Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14249CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7N-0004D3-4M; Wed, 07 Oct 2026 04:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4D-00017j-Ie; Tue, 06 Oct 2026 23:11:50 -0400
Received: from mail-koreacentralazon11023094.outbound.protection.outlook.com
 ([40.107.44.94] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI3n-00009c-N3; Tue, 06 Oct 2026 23:11:32 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcGha5h3xIcoVvidRbwTkq6feciBWxVWfa+YTWqqIREiwBMiN/Pk5bRK0MQgk5RBVcnqtNu1+CZJ25HU5QdekwNNxcPzs8oxuvwl/60HsjdJXCnikPVWIk0PxvjPs3Elz9r6vsCrm8yHJNgx/ctMP7r4wNkhT/JWHigjz3+JrN7QmSHDm40F3CGNYATXRNDIcFjvl92cNssQAwpLUx1h41cz1Clh/KspVKwyTFyHHHHvP6WkAtTxvmaZ1Ba66uzl5xHAL1CkhmmLk3vk76mh2lKy6iynJCxCpDXUbKZmls3j6Jm3DqPtI7XDT9yzRzM0KHxVwTj/zgJk7TpnU6JV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v+niDQo6V0yR/sTOGueyFWiHgFjAmGxV1lI3FaBEn8=;
 b=gxoUjEzvu7Kz6UZmgXN+Kxsl9CdM7NiSy81wpGMCX9r6cviOEeldyh+Mq5bRiM75kHz7iB/dFhVvdrcS49KAyWepw1+thhaCjGfAIMCZNvKGoGuWAoaNZwa2WaduO3CUdIDqyE2YbiRM1G2scF3pkoRUU67rHuZaUkMudhKKNjsYsyRCyeQdkmYV/Wqq7rEILfvwIpMPacP4jzdkGwaljCi7sHShoow1y8e6855jdmU4T9uX/I4aCVnrBa2bx1lCJCxcj07OABElwNKVGWKHLd1NfbGxDrKcHX8M7TUsKw79OZxHnh4ut96p4R/AxMK3hQg2pOtBCvyYH9Rq0B4p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+niDQo6V0yR/sTOGueyFWiHgFjAmGxV1lI3FaBEn8=;
 b=FqZ6+w+vnX/p/a0ReVRYctKozt8N6YjJmXulOGmGx4ccuXnrBBY3TqqQ9x7nfaBTyBodeco7QXY3my5hWkYJ6G1j0PhIa8azKNI/9VsPz+p5FfxkYvCOJ69GFRfuNxlG+hv3uTvm2zGheBwiqGWZqDSsZZSFYCdPoo7n0utPHdyAWAsVvAJ3Na3DbO0tfyJgWwg/mZVhZj4pIyZlPfG1MTeQLEUQ/0pJvXy0zfkXf2Zyji5lZJTqvZhgu8r2VjMG6fERvZg9MioUcE2qZHLKmL2oQZRiIE6b2OeiUXacIYnqUnkgIcVIR1JtcHbaowWMdHtDBgs63SVvrsYst/GTzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:24 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 07/17] target/ppc: Register L1CSR2 on e500mc/e5500/e6500 cores
Date: Tue,  6 Oct 2026 17:49:02 +0800
Message-ID: <20261006094921.110871-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9990f6-c5ed-49ff-82f1-08df238f3e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: RQP+FhsWuOZZ7w60REYZBt56GWpoKqGTr1lqRx/6xHksd19Boa6kC3hkayfjkxN+jgV682EXNoDECeV5Bj2e9kI9WfdKVP7TfDXUU0A8HXQsydKBD+pvU8mfdwOUrwA93Bs7OHR4s6zqKCtG2SSAkq/4tGJlQzBUqeV1bDi3JSYobo47ttwAQd4sG7OsC73nqedLlT6ypz0PAGHxH5ddxSc1MUUDx98xfHOqb3OekvthxoSziB/e+Ud+h8piOH5eaGvPbZk4cMSqgqpqlHBBsRv9YM8s+CFlPbo5Q2JD8y4fMXDZbhGaHYTFQz/seTvlW1M8FehQgZSTcGFEAOm5BtmxZT07npu+ab7Wyjz3g5rzw/qA2Evl8BSeX2El8AP9dEVMjabXlBwGM3HsimidjtBIzadaRm93E7OCIZqZgp6PxcXMS+RYMrQLFuSwzTeqZR7yCzqlWf/pb++hlOVwe9RCwRpZKbNfAaphKfVYbknnepaN4id9KYlmxQEowBhBR0dLW7M7GsoXQDC0kCKW23vzHNigUUC1gsDEZRxTgQw8FmooLJ7ToUss18bKKvvMV8UV7TbiWpwbJPpoyFkAIaC+/4oFnkCkcvMjdvW0bM2vwpMc3WDjfa94CmxpY3T5z2ITP9ZJDYLqukZ5R+koiTRh72Eh2G6dCLByJ5B69KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+srESbU7MHbFDWxrs/9EwhzZ8Txw36lAWUPF8YZuuymD7yLNT3fF6cD1GVq?=
 =?us-ascii?Q?PvInahY4eAzjNjXmE6WSCEyAGLNovnLq7dgxlh1frw/CWU8Z+f4z7XoHeicf?=
 =?us-ascii?Q?gY4miGy/2R/kdw9zrgGXc3Fev6d2JgVkwF/REqh2KIQb5uwbvv1Iy0fGmc1R?=
 =?us-ascii?Q?3K1Tsy0PvsJIrzLF3eG2g+ezMfU6d9u4aouLx6cDkJ36B05pbMF4qBL9C4S+?=
 =?us-ascii?Q?R5KGAyOjDnNdB8Mq0t26IcMSokxLGzz04zAMxPEi+w/CTbKvivyBgvVaX+U3?=
 =?us-ascii?Q?3EgC4nv2S3AKIYuVtxDP+VFXmGxCLPahxqWlmoiyKesWJj0T4IWob0oHoU2t?=
 =?us-ascii?Q?+PtJ0w2X9i8B5qsy6Fhzi7MvvdELWt3RVwFoiITYDjoxT+JT7ws3WbK16Wec?=
 =?us-ascii?Q?iKfJavz5EaXfBHgI9TtjkX0woVjlxzxjXQUY66zbXmqgKdGaQ7j4rKRh949e?=
 =?us-ascii?Q?lp/45p7t+jtbwE+c1DghnHQh0/31k9nfKHpU6Mvp7BEBl0JbEhBa7vfuCLhv?=
 =?us-ascii?Q?DhqFHnQVhTWyYPs7Dlza02GodW0YUzHP31PtLlzc9dNDjIQJdtqTOGy/sHhy?=
 =?us-ascii?Q?2/7/pvl2KmzyzSijjum7FbyPSPdsmkuHlqj9tr/Cc9tsX7QOK0GBrw9BuLf7?=
 =?us-ascii?Q?TeMvWY6f5d0XQrYpQj3dgIUBhH/OrTxqvFIj21Q9MBmVtX+cS0/L0idokonl?=
 =?us-ascii?Q?kWF7yfPBXy+MGu8yI/fF9KwPcp69ST0ayxwG5YkXMmcBuzIHX691S24qXAXe?=
 =?us-ascii?Q?j5dj8CeP+3tH9b/CFTv2/fQeT+ToIaWAOQnwmXYzhnRvShY7yl1PffGHTxAq?=
 =?us-ascii?Q?EKqDIN8kaNHZtHQotnBLdxuSbjy4CMF1ec+s08tcJ8iUfAsgs8DiwEtil3xt?=
 =?us-ascii?Q?UkICHTpBrNjG1iDmBzT6TQYdaZ+ByVXiADYvHtklSHdr2e1JcjPYsKX8Fvmy?=
 =?us-ascii?Q?dcIEUdelEF6ZUc5VlEo3FKefkNEuTcac1ndGFoyAcpE9zey1SSC3gqsT3iZI?=
 =?us-ascii?Q?SBcWiQP/4w+f3TSz6doxorNeTroG5zYPWR1JxUc5csvXayp1PTl7MIBIt1Bs?=
 =?us-ascii?Q?X5Je0gR2kX0CndZMdX/GdI72E7o14RZhMbucxtri73tIPZYu5iDEBitGIBBN?=
 =?us-ascii?Q?Cm4BnUObvgUVDbWxJ4Lu0lbPeKZSZ1AdUmyudtupq5MFsVykisa5t+cXJDs/?=
 =?us-ascii?Q?r6JPq38M7opd/+KWCVLJ+QFmL8eTb2zFs+iGIUoBRijxi2ZZ5ZDgfrT1gXvL?=
 =?us-ascii?Q?qsebRwUVU7ISk//0QE12AQFN9duTgar5i7gzc+A2GZ+9OL0/JV5Eps2+S+FX?=
 =?us-ascii?Q?fxQ1ABO+sV7tNVMEnEt1rr86JvXSov12MTeCJpXgTZyVwjuVnQujr0N+wwHB?=
 =?us-ascii?Q?1caaxw2f6ogCm82kG2X5+gue1IORfGdDxxmdp89rFLQiqVmktKe9QY29trox?=
 =?us-ascii?Q?s9dgWeyMROTYXhoKj417v0ah1gd9ko0sDIAxKjWoEUVFq/SMLSYYQBY4D4Jt?=
 =?us-ascii?Q?U/C2Qww2gZQ0FtoO82lELe6GpydehywMijhEgbCZRFOI92bPoAhIrmahpqL0?=
 =?us-ascii?Q?hmLvDX3buraPC4awYqKpI5les8kIRj3WBvK8NG+7lx+Ch4WftFKvPGRYf3CW?=
 =?us-ascii?Q?OMn3j/NBQKaLO21RSQatbiVLR2kF4IHLAZQwfji7trn79kNHK5yyvYBojnf+?=
 =?us-ascii?Q?SjriBZ8/30QMNgtqC1CBlFCADutmyHtRkRposASygxQgXNH3VTPSyuZ9oEUQ?=
 =?us-ascii?Q?MvaGGSJGwgs+eC6f+odrTYlpQvN0FEA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9990f6-c5ed-49ff-82f1-08df238f3e7b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:24.6211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CtsJccaiaUCNyHXczY7DAbqZCfs+H5O6drv/qcphdC8ZX/R3doWNMCgnXQSSuLS1CCVoo6vdJ1Whsiqu0LxIlEDmzhABVIcj0p8Bt4D3N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=40.107.44.94;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

U-Boot programs the L1 data cache stash identifier before entering
its C initialization code. The e500mc, e5500 and e6500 core manuals
define L1CSR2 as a 32-bit SPR with number 606 (0x25e) and reset
value zero.

Expose the register on all three cores, excluding e500v1 and e500v2.

Reference:
- E500MCRM (Rev.3), section 2.14.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.11.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index abcbcf3c18..d3f1c82730 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2038,6 +2038,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_DSRR1       (0x23F)
 #define SPR_BOOKE_SPRG8       (0x25C)
 #define SPR_BOOKE_SPRG9       (0x25D)
+#define SPR_Exxx_L1CSR2       (0x25E)
 #define SPR_BOOKE_MAS0        (0x270)
 #define SPR_BOOKE_MAS1        (0x271)
 #define SPR_BOOKE_MAS2        (0x272)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23f25a56c0..e5856b5b1d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2965,6 +2965,10 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  &spr_read_generic, &spr_write_e500_l1csr1,
                  0x00000000);
     if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_Exxx_L1CSR2, "L1CSR2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32,
+                     0x00000000);
         spr_register(env, SPR_Exxx_L2CSR0, "L2CSR0",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_e500_l2csr0,
-- 
2.53.0


