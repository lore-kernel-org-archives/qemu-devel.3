Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A708CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5H-0005qF-SM; Wed, 07 Oct 2026 04:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHt2-0007Vw-6u; Tue, 06 Oct 2026 23:00:18 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHsp-000686-ET; Tue, 06 Oct 2026 22:59:59 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsNQiiDIqUEDSHY+4uA1ZVH13QJWea+uOGkjDr+HZ2Z81At3zVLsGyIKQ5HOC7fkQWwGNfHigeoAtFfb1GqmKx/Ty8dPETh8gUL8XndlTE0usrr1OcSwpZlzKCwhc0VQ7WyJi8MPVjDfFF+Iinosg9gndxjwUUhcfrWrkn+Zvzbi9IGbPKMGN1qTth/lTRvM/LL9V0q9KB4QtlTLxL98ygPRv6NWo1Wbvs8hvpiAKuVhCpqjkKruaWUUU861kTZIvyGC2myKXoHcQ1e/BoSRb2vUxSDvxeWJLB7Uv7ef8LVFcZySTGrth39Kg58GHExlJfANWkwKrf/dEZtFRG+m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+gVg7B8z3ZK9k3H8alMNkCWpcX0L9yeJUdc3/KtVCQ=;
 b=oITrX5peUClWtTkk2hV6EAE/mnriGJsxgWsqckd8p+fSf50ojC+uTDBurw67y7kkyZ8wVIpptyyVsXvV6LNPDZvoB4H0n+FXC1bJzp5MSa5B+tCOb7Re0ZnJBJJrsGEwtX1HopGNWW3P5YjPKYgI3uckcKeyL5kxft+5X5ZNGcjVT8m44Y7ble6EfVEc+jkT2n5YGqDpj/jAxMPVCCeBG4/SZG9Q6hEC21ZAw/HVStKNuGXyS/5V5N1bzNlk9GGZPJwTrFO3QgxzR8uGGlcyAnD7fBQ0IzZFz0MkRKyc2+JpoChM6U6qcf1HlGD4G566k/rScPl8WcjJcLPP46bj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+gVg7B8z3ZK9k3H8alMNkCWpcX0L9yeJUdc3/KtVCQ=;
 b=ZwFCAbtuic1ERRqd/kM+z/zdC9Hkxcc0FUBerTN4FLhxw8U+qH35QzpestwKz5OIFFAloeiOBDyaougCS9H0tcCeRBCnfGVvTuJIzczgp7dpsl7SLFbWThwS51vmHE2hdJCTx2B2gppo1v8U39Yxgd4weHCd+EcfLw6TWNYeBwWCb+qqJEaB4zKeb83/ot+TeMlct/osq0yGDQGE5P41lRrqn4FpUg/ilSc8Mx+7XO/88EalnUijhsCaFPLjbOKKMefbOURhw/GEuy28WtzJfgHWN5Vu/UVTCZLyyCx4Cyr/AX7KZBUnQ2Yn5wNT6vTQ9Jq1Yfvxp+y7XtkcroWWvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:35 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:35 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 11/17] target/ppc: Register IVOR42 on e6500
Date: Tue,  6 Oct 2026 17:49:06 +0800
Message-ID: <20261006094921.110871-12-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6910989-f265-40ae-27c7-08df238f4512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /H45FHFJFL92rUf2WQvIrvSZ/ibTONirxD6P6AwKb07ZPXpmpW9GpuYiJ02fhaOZ/V0esOoMCJmF4DpWbDa67ycPP5K4nprBZxKu/zsBPsPU8kab6+MdIkYUaUMPLLq/wBJjKyA5OGbPIHQCTP0PXnBToDSj8sxTmtBD5gikwSa2Jk1CKAN8Fla+CeEPyrMixaEMQaRhvBq38F8h/YP8Jo+LrOl0O2PR4wi4P6l+TngL+SS5QjAGcoa92g8lMMZaRY955Wo0VBO3aalrMmVgdROJybXlbiuQ9q+kRuBVpuFDq2gGV/3P5QUAMYZTRkzFJRqjH+8SabeRnFClArclBYctStSpE8Hj3FRwe1el8R1g/BQiBiFdsFNkC3cRDRaDraGqrzUfYIguaFpFO/YoUrGbHDNoHfW2W8S+gYW35BYJY0JG6jhzFE7R/3+s3TPLm0CIGwl9qbiMt5DZsrsfZGOnYCCBsBM9wNKEyJ8TYutLz5okI0rAt+E4qJpbGJW9bUOhM3YQm+x9wv/y2En724NS/jqSVE8Vb/gAxNJvlocfbb2FCxtdK8ROXKwanRNPf080c1hm1Br14G6s1stPszcLZgIeyKFCeTJpLyGV8LR47CLy6BGRxetaDnVyz0yGaK20gAqHY986EHHybJt6D2lw+v6RNPui7397TddFx80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9W+16QFfp3jtClm+w6M5Fy+PDZtKIDr6+5xph9cYEFSE618n4ix2MMmVc6A?=
 =?us-ascii?Q?kQpk/QQhFV+CdRBpOwpctpLQd0jA7UgjsR7NhJXvUs7Y+uHw0NJbmt1bh28m?=
 =?us-ascii?Q?rr7Yrm/YpReOYPUykYlSkp2hcVrmwPCbMFH5XTqY17+0556D5d2rF7ZGSv2Q?=
 =?us-ascii?Q?cLV1dZ7aZ2IUh7B/nUXSZ0dvr7sv/8jHLVy6OyS8u6VvcDxdGjosrLrtBbtA?=
 =?us-ascii?Q?vW82wlvBjg+KZpnX5o074rR608T6zbaJ5gPiijhs+4LMJvraUAo/ej7kyMbg?=
 =?us-ascii?Q?4XVGtbmJ5rGuxlXtsMf/OpP/Jchtt4Upb2KPXaQ92+470KsPv2+qcmp6Hy8I?=
 =?us-ascii?Q?TqTaemIy/sRC38iqA78XsCUj4VPbaY06xDCTyP+Y7AO9VuwLm7j4OLRMqxWm?=
 =?us-ascii?Q?nQnPC1jPfgC81u9OeUlWbKmuHIQZRVnQbH44voI0bB/0A5ZlOKrPAXuJOtXX?=
 =?us-ascii?Q?SYZprdcmYtLwIvCzli4Di/kqAg45UUpVraevZ3TnAklNU/FrshrXqPLhjxOy?=
 =?us-ascii?Q?GtqQ8Q3uzBp0VAVG1sg8gewezdFOAvo/GefEvT6Ad583BxsmTXeHJjOaoyf6?=
 =?us-ascii?Q?tz5NmLI8tBRxQ+xVUpnM2a9xiI6gqALP0+lX7pyevkGc0JF6eLSmC/XQUuS3?=
 =?us-ascii?Q?LJEXqkNPagcTA8Cz23GLEA8ekPE4RYk72Ji9SMT3aTpPIi6y4W32rPnQJdeP?=
 =?us-ascii?Q?IUTWiccYmubPKWyRkP3N1uxInavzwSEWfA9bRIBoFFtywRhVgKJZexpuA+Ii?=
 =?us-ascii?Q?eXukTDeYzx5AZwZ/Jmy3X0JUuWhXTfzgapR9vLaRxPWKY5PrjpDhB+BbX+Dp?=
 =?us-ascii?Q?F5eSDDHEdyF8tIO5qCGilr75GOnuuA/6NXTGllC77rBvlEdU8dbBO69Cvkms?=
 =?us-ascii?Q?sCYXSE3b0kUSySlB+EC3ZTZ+HWxkkcO5AzOzDJKGbRjgAQF0FpKJ89szC7ad?=
 =?us-ascii?Q?vXPABN7mD3QbLIX9KBBOeHomVITuH+dPl3wJjQ2b05Fyq5at4YrZfY0hXUno?=
 =?us-ascii?Q?UpDv61/PiQy7MvFRrxebtgfcRSuAHFo4ZK10VPVB9B5dcWeS9kihBS0SJKSt?=
 =?us-ascii?Q?WbnGkayljWW3VisixegiRkE43q47pXApb0+rev5ZkfikJBICuHrFODbvKaA7?=
 =?us-ascii?Q?uvcmmHcRMkxdU03LRM9pL5JcCS2Sav2QUr9Rme3eFeFg/UX3ukPAr5fMovqc?=
 =?us-ascii?Q?FqR4MVfwKRr9wvTNIIxTA95f5exISGhY8gRxv5GZWZYDGDug02gR4OAs9Xvk?=
 =?us-ascii?Q?dCas1XsQzf2xgmF6eFODofq0iUlVOt5DXdFmgkVAif/ufpZCXV1v6V80aV3J?=
 =?us-ascii?Q?iW32u2oNToP/KOxHizt6v6vq0dfwtpi17OLq+5UctODkT/epkUN4nKB2310+?=
 =?us-ascii?Q?4gXymPSnJyofHbaYNAWq8UYN4UCJedJICkz6BM17k/AQkn2rcaxD+AgiYrKh?=
 =?us-ascii?Q?TO/VVD3p4yRjd2AyNWrO1+7VckDGS5YRh0QldFEoymU9rR4eLUJ8FpF0TdUn?=
 =?us-ascii?Q?gmy5CH0eWb7jvMxC4WOP/3S0yTGWQQDIEtgoLDkNmr+cp8Jr6bdguip22sG7?=
 =?us-ascii?Q?J6STfl3iUdqFyqP8Fj50smUTQ4iXuZY6IHYF4hAZBUKWiMyCTGGL6o8wQISb?=
 =?us-ascii?Q?FaA3t53Ce3wUXsbCEphsiAQxHSa3EYSiYhqpOnSJDNQ24lgeOZSoQQVOUbJY?=
 =?us-ascii?Q?QOlXQ2/gymjrgtcm7FpsNa6JOTIzwrIvCqBHhiKZO/NoQo8zL/QZZhzBBZHU?=
 =?us-ascii?Q?gmnTB1xKyPffw9WGYCYANfcvA0LLlcE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6910989-f265-40ae-27c7-08df238f4512
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:35.7966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26ffN64JF1UE0mVeoYAEvJfxvk+znpj8x2cX/LHdoazyn/dEozMEGWWogKaLcEOoHCUvANFxJC6Zsut/Rv2nAC7PXRQm3TxW9NUrMGNyx+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The e6500 core manual defines IVOR42 as the LRAT error interrupt
offset register. U-Boot programs it during interrupt setup, but
currently the QEMU e6500 IVOR mask currently excludes bit 42.

Include IVOR42 in the mask so the existing BookE SPR registration
exposes its offset. This permits the register accesses without
implementing LRAT translation or LRAT exception delivery.

Reference: E6500RM (Rev.0), section 2.9.5 and 4.9.22
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 4d12152659..5077f3300e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2824,7 +2824,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
         ivor_mask = 0x000003FE0000FFFFULL;
         break;
     case fsl_e6500:
-        ivor_mask = 0x000003FF0000FFFFULL;
+        ivor_mask = 0x000007FF0000FFFFULL;
         break;
     }
     register_BookE_sprs(env, ivor_mask);
-- 
2.53.0


