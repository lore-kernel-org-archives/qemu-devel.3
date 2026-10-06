Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4FBCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN3L-0003Vg-B3; Wed, 07 Oct 2026 04:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHiz-0006A7-CG; Tue, 06 Oct 2026 22:50:02 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHin-00043A-Ro; Tue, 06 Oct 2026 22:49:38 -0400
Received: from TY0PR02MB6981.apcprd02.prod.outlook.com (2603:1096:405:c::14)
 by SEYPR02MB6548.apcprd02.prod.outlook.com (2603:1096:101:16f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 22:23:10 +0000
Received: from SE2PPF27A9EBFF5.apcprd02.prod.outlook.com
 (2603:1096:108:1::80c) by TY0PR02MB6981.apcprd02.prod.outlook.com
 (2603:1096:405:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 16:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icq4jMLyOMRoSveh+916purtqdHeoTlFL70aZ044U7J7e1w/mmUuPa8wsc8fweKsEAXZ2sF+FkOlrwHleynOzRv++tTLKVg6OMrLxIJOfezA4fkte0RKL5l45XhgduTPOyiOqZQRRU8x1IojtBuTn7+wWm3lL9FiRhzqaojR+lbVk/gKAsPziN+I0TMiUKSooyciyjfQXkAqNoS0y+SOks+dgUy0bFILyflqye0WJjcS3w4j1hmgDC+HsvjOq7Kr8UIlZiJOTdKvXZaF2OMNxiHicOxZ47ftM7AmZ2eQaWQwMnRfsVd8h5cb5lSgUzVoK/MD4dE0sUMvCW9XA4jV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffya+uplZY52b1L/i+ORXMXqd3oBTdc6l5jfa0aSWT0=;
 b=J64c+SOVQAadYrxN3IaNqj5sozlOHNU/+x8HaPk63UH55CsJVM01t8SSJnL1//0Zff5/ByNBAaDpc+l8acNWwF2p3KrlzVB1hZTCu4zKxLnqjK1G8rqb3GwMJX1wkekKqN+adht86Ux9TlBL8veB9zspBoDj42Q+piAr5ceHBDQtnmvLcIXSzS90uTKSNsB5USWcI/Q3041HfqwOk+Z3CsLp+AN/JDhSfx/t3d3L78feJ58QzUbyUz6P3WYOnjg8w3uCKQ75ypEcy684lnxp+M+Lm3pCWNqHlO5CGhMXZAFv3wZXcr8UXsMSbzbtIh7faH73QAXYX8cWpbne2zzXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffya+uplZY52b1L/i+ORXMXqd3oBTdc6l5jfa0aSWT0=;
 b=sRfYlZ9YFquuYjPHn0v6PPtM+oZuQG3BUgpjROiuE5l+uzUH6DNb2PRHlqZcW91BbI46xKjnXcYCdyDy/eqKBcaxj0zV6SbtfN/svtehJBV+Ukk3CFC0WSNQiz2/mJQu8EoF+NptpYVJUbK+IPh4tACzDtNnj0R8rzVq8D1XjLuX8EG0kecaKINete7TnpGUkdBr2DO7A6CoA6uOMKnp40JKpuhA7I4LR+3UT9tYO/owE8Ppz+MUGG7vdbyfRumFw0danq5uEbsj6xE2Y1VC0QijYg/+lGDOm4iEML0n+UOtz/XnnYoRS1fsR5G0xb+GZ+ehuVJg7Zv8J8DCGs5PRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SE2PPF27A9EBFF5.apcprd02.prod.outlook.com (2603:1096:108:1::80c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:07 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 01/17] target/ppc: Correct PIR write access on e500 cores
Date: Tue,  6 Oct 2026 17:48:56 +0800
Message-ID: <20261006094921.110871-2-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SE2PPF27A9EBFF5:EE_|TY0PR02MB6981:EE_|SEYPR02MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b63a2a-3015-42f8-1379-08df238f343e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SAupuuR62GZnuLUSZiwzCH3kipD5IxtKoh6H0D8LagRiNSxVrAHMCgForNxN6fPljbq/f1HVxZRkFWdvL8Gxk211vU8W91LkRE0hVdW3+kJ1w2DaK4mDguNp9qZM7bth5eYlaVTL39VrkesHEf8VEiWWId+ZacZ2788dKHwH0ScolRbox7F81RvRrlk0K+DIBPR4YpB1qFSWzYlgQjnasbDhQA7JUEtrcPtfGqRy84RMYySd+80WifAwfYYFi4K1BmbuJ0h2AheohaUqrHNgKu8+TiEBmGvmf7aEi/70FPDNhcJUjvnSybFc/08rlkpTTHO8sKuSQCD23msZMQKdK9iRzfrMQZuGrjIS96k7jY9wZ20pvxwe0TXoQs3PnKR2X+wJYEnoEFd2E27/wJQBWRRW9HthohZRJ+1BIFynNz0hOWwr/mmZc8IikrfYqACvazOx/rmSRs60tJRylzILZlCKoCvw91aZ5Tz3TFj7QTfy6TKhfGxyNw+kafETRe2ADmLNu50CuY+z3y+RHIHx3FTuH48a1YkemEqyhHBPX2lpjQpawVAV6IIF/5s2qab6BC/OjEIzWm7X7wY8zJc2bJWTSqQtrPykizLgg/G28bL39l56P7UYeLxsr6+x06KiBq+msfcH4+PyrjiIQOM9O+vS8oIPlF5jXk4piSnWbCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ii/O6eZ9FKahtEwth1x8bDoGVHCGQJpwPaWhg1j5IhiZvpjOXSEqAzWVeNYx?=
 =?us-ascii?Q?1cFOac3zpmZkaMdcFOVSTfZ8RLtL3Gu3i53E18MjRIWJUDcyfVmFlvONz4wP?=
 =?us-ascii?Q?wG+WC3DgJnLKuz5yPOnn90KWdpgo8wqW3mCkoY0qdMq0YxP1mK3DwTi94azZ?=
 =?us-ascii?Q?WaH6PN5bDMtaxdYlzXaGUJLjeLAwWWlGMExBWPLl/1m4TFZsXA7rR0dt3wFt?=
 =?us-ascii?Q?PQEYk+8jjGi4rnH3C1qJeeCAIUcadI8eTCIHs7lFhJ/LINcslQZDRUwsxA5+?=
 =?us-ascii?Q?pRTcg4goA0sHCaZDp02jlBB/LVMZFJjN+WR+hyNCxKEqPL9EGumfUmyEnE6C?=
 =?us-ascii?Q?5RgbiqE2XCHbyd9rkWHIuPwPemoxRHYXd+KuWsU2Xm3cN+eoCAhk4RskbyRY?=
 =?us-ascii?Q?1YUsNAzXri6b847r2eCAktK4npjHb+tMOnUrdWkM0MGXmsByuraE4AO3UDXp?=
 =?us-ascii?Q?DZ7cn+Ig6NTWB+UPnZ/1YaOUlGErFrAVWFnHuOJcTYc+7NdvnCvPkDP1rkHZ?=
 =?us-ascii?Q?8gfP23Hk9sHNkZiChyG2Fmx2ZaM8a6hVzeSeUF5+TtDO8tYriE5qSmFmupyw?=
 =?us-ascii?Q?rYT7oyHRnylnFXirEyEvge+18FvT+J5URvK9k/H+yIFqWhkkNTQCvzem4Qcr?=
 =?us-ascii?Q?EhqTPi2aowY/cSpUXsSrx1njqip5EfvDtoooZoCAyY0l2VVchM0wt3n+S+Zs?=
 =?us-ascii?Q?dLXnvydxg6AFDKQbm8xqNluIawQFN58lE/VU+Xdro/ktSHkKrZXbb81V20cr?=
 =?us-ascii?Q?pn+RBHqyJP+xGTX4q540uk2+5bGrApo4kAt+tw/HSJAGPXZR/sxEhMiB7VEV?=
 =?us-ascii?Q?Mt0HL1Zcp5Dp7kWPPWLmD1AKNfgGtfcC0GD0cITu9bwDJh1c1nbBSYVoDFjc?=
 =?us-ascii?Q?kVYST2rjhvfb7NUAqUrPAVmCI4RGNPJ4r/EL2Ddy68D+NwmTXKgf33ZPtl4D?=
 =?us-ascii?Q?kEE/3By+xmDeQ5pbqjv1C6uvOp71Zn10bVPoywLw4nGE8nBmx7HWNwUffUgn?=
 =?us-ascii?Q?Dm05oOFTNMJoPFzYET57DMhnU+K7342ouwYDm/oT+QhjLBopX67axrZygUo6?=
 =?us-ascii?Q?XApABgVsDyhXc0RCwkYlIwoqSKM0Yy71ak3Ptl3PIjEjmq1ejqhv0ft1i7C8?=
 =?us-ascii?Q?G36SXB3gvBEJH3xsy0DCfTMYLIi0sWa9QDImdTAVR8j3LkXrl+eI247+zbcw?=
 =?us-ascii?Q?efORnDs304Aw821Bg4Sx1S1r2sLMnIdDJa3lIJf21x3kjTxIB74UlNb63v6o?=
 =?us-ascii?Q?g+QvehLeJ1D49S3Pn2Rm4wYRHSb8MENhEN6d8iYHgj7+seQkYPJTjTd3yWwB?=
 =?us-ascii?Q?+TWehGjgUaxnov4WQyvNguhI1BdVQtnmmn7I5dJV7xgfQSKyybWgKJCFoSgh?=
 =?us-ascii?Q?obV8wwqNuAkbiXFE7R6jFH4I7mEbzTeau4vo9kPW12fw0awQH0a/SBoYWJug?=
 =?us-ascii?Q?lLx6Eo6j4I2vgqJsgf4IJFkBRAGLuQXdWOSJ17yE28WyFsq9Sdc0+mJ//miE?=
 =?us-ascii?Q?OuBGRyPP5LrtkXRcA5sImVo5eM/h4+BNhzrbm0fy9crnGBkBGEnGdIze4vCN?=
 =?us-ascii?Q?xKiy2GmuLt7J/SNJJCLlAJKv5O7cwmwlhZYYUP30FJ41CDcc+gcL9+t6Jrxw?=
 =?us-ascii?Q?aC1OWYKkY8NLB2pJv07LcKUFSG3ptCNqFQan2eePbJRfqxUwpwCc2NF4XS2R?=
 =?us-ascii?Q?s8y32p7yD+Cn8CBhtSlXxBUCh3AfCqaAbf29/8C3S6uVV93zSIfqQ1+oKCIm?=
 =?us-ascii?Q?giYtakWS2Pv9AMNheUtOCFaNKuU5Joo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b63a2a-3015-42f8-1379-08df238f343e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:07.5165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfhNMYb09WbjuOkz36JAbo1pfWF8dvG7WDIaotybT+6cbjQVTG84lyDUNVg2LeymZpBsJVcwGsw3PmgWpihDiDRL3d040mkArTkntJjMDRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF27A9EBFF5
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
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

The BookE PIR registration reuses the classic PowerPC 604 write
callback, which writes SPR 1023 and masks the value to four bits.
BookE PIR is SPR 286; on e500, SPR 1023 is SVR, so a PIR write can
corrupt SVR while leaving PIR unchanged.

The e500v1/e500v2 manual defines PIR as read-only. The e500mc, e5500
and e6500 manuals allow hypervisor software to write PIR after reset.
Reject writes on e500v1/e500v2 and use the generic 32-bit SPR write
callback on the other three cores to update the correct register
without the four-bit restriction.

Reference:
- E500CORERM (Rev.1), section 2.5.2
  https://www.nxp.com/docs/en/reference-manual/E500CORERM.pdf
- E500MCRM (Rev.3), section 2.9.7
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.9.7
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.9.8
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Fixes: 76a66253e5e4 ("Great PowerPC emulation code resynchronisation and improvments")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a8..96bae6a6d1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2837,7 +2837,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     /* Processor identification */
     spr_register(env, SPR_BOOKE_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_pir,
+                 &spr_read_generic,
+                 (version == fsl_e500v1 || version == fsl_e500v2) ?
+                     SPR_NOACCESS : &spr_write_generic32,
                  0x00000000);
 
     spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
-- 
2.53.0


