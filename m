Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9211C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZf-00048y-DB; Fri, 04 Sep 2026 12:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZa-0003wX-6C; Fri, 04 Sep 2026 12:15:26 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZY-0008SI-JR; Fri, 04 Sep 2026 12:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAdUWR1AiTVSF53mLsPBR0pVtR3JbZNbKxyhRm+a+yl0avtQZO940OqFMvIcb0+NTHvH6NSvxPThqJzv+FvEoNncx8lPzvSOSdtUI+k5APKJryzHRiXCKr/GrlTemTfvKvDLPfBtmrfpKi36MmmMB6YrjXIvTg8v3jtNmZJpnyetYkKdglmLzJPZevljjtFQ1ycw242XMMbwt4f0iv0DEyYk52MMT/qf98QN5awWYXrKkjSi0f5euclXZm0eLgI8fW4JkN2pTOzdcnE4CoKUDMRIqgXLIfxYhexTzFFzXK03qqDu6d70xiSsxJZTzLiArkTs5InA6nXJOnSYjWpAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=448LSnGsOuaQhRIV01J8Jh9lGSyaHvhtnr3YI3xzEDo=;
 b=I4f/7A7KAGCwKSevI5zAT66O6EiNNc91NM46Yi5AtkWiqPIklJcji7kYTkaKpU90/SU4c/PrCtL8n4FcM9YkLyQUWdI3sgqGyQxeO3/fFdSs8Dp96DOknnHouIrseZG3agkZrEV2DRTH04ONpKpNUyNCGBG2jTDWwJk4VEygyCOxZ2VmshLxoXXlziALYW4HqkXCRGhmHNO5eHHNjEKYzbtBqHTpi6V0ICjRMXtxTZZrCsn9GUolU1GOCMpKqNoK0VCU8YH4nKkrRCXV/t5wzEcDyPolMM/EFFY2lhCt7hobF0UaVs4qdYn7o6aM84l4tG8ZGhfQvssHFg0c+6FMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=448LSnGsOuaQhRIV01J8Jh9lGSyaHvhtnr3YI3xzEDo=;
 b=TnxSoA7ZL/Hz5h3+2lzTkct5jHm2PxgU8bPp389tXmMxEo1zD5tBtjlOIb8rs00EHze3qYj7vXSGzRzF5lb8638OT55Da/gQIBR0Jjv67pSG18AkRAV1laz/LFvguqI8hpZRZbt8MLpq9DhwldrAgiDI/FPtZhfB7jNOB2RupWGTYxYMC4FUYv8ktnwB02r81+rgfo7QFy6yR1VTZIx4ml1jSmfsFfTFNGD5ScfSDPEapwz29hrIO81elQ5ih6IkD5EoB7jKA0ofzwtw+MrnL59Vo6Nui/Q8Xxv+FL5GhZtsrv9BCCNdxTUmqwTzh+vosIjRb/MHUTr83vj1i9/GmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:19 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:19 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PATCH v2 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Date: Sat,  5 Sep 2026 00:14:28 +0800
Message-ID: <20260904161438.3838261-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb718f3-cb57-4e58-96eb-08df0a9fb683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 9UM0iND+SMwz7kopSx/rqUsjRg9F42coxBxa06EzQGu1pkEAt7oLreSaKZYhSn77PT8W0noMC1B914Apv4bST+PkZoCt9ftrzj99df4X+rPTd5M2nFn2J7fkDASEB9njgHFys/HFg16CCRRqv4elsWzJXU+Z9uWAHz8fF5ikU9+KRBilkSKgzIk4KJb+W8QNpByiEUisHeWEiGrA6LkahAqMOn910xDZqQ7pSrEExwPhDO+nKfX2N2mN0/t41lgQZCM+5mrqkgUUVScz79G5Z9BmxKAmouw17wGqjW90KlJRGfi1Qmo+pt0CfKaZX81AxhDqrb6qHqXe/WZlj+dC3i2kys1UYpnJ1We8IRxSHBpuij8eIpuVRAhN3K2IM+K8jExH8hu11r5DEm32/9GWki/OwmE2/oyMXc2bvOLVRiJLtBUZ7nLm1BB5w+GCYP22fQxnAoe60Kbn/8KohixnueaiI47i3AFqVB7MvZyBApSn0RNd6/3JF0aVQBRSzxDtVCSOrhwT8XWxl9pTVUTeVoLUNRaFS2t6LL+N6EBRb/1h0wIuP1quvNZnlsZ1EfCSnS3CTboCgXEQnV1TtXC1f4nr7p7WzsCXLPY9+mTj9NYF/LYczRybFg75hB77dd4iMr4yUImG37ao7tdTHY5Iq4ArBdOIsL7unkAGOsgrsGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z21lbERUTUpjMzVCUEdMbDZYVXhaOVg5RCswK3pJeDR3QTIzTUxpbndvNm5y?=
 =?utf-8?B?Y0E5cjBrYmMvTmtjdDVCS005NEg0WjdnbTBqQVI1SDMrZmhxMWlHeDh6ZXM2?=
 =?utf-8?B?YThEd3N3MXRFUTlaTnVraCtBRWtoUXZmbzV5cmFRYkIwOUJOWjRpVTc4WkxU?=
 =?utf-8?B?VnBqTWs4dEtOWkc4enFQdFdDSmhtUGFFWDhaMHo5V3RZSWRpWktlalNFM2Rq?=
 =?utf-8?B?bTREOFVWSTNRcndJbHZMVEx0VWFFNXI1bVJLckQyL0ZZQi9JcW13VHpmV2d5?=
 =?utf-8?B?ajlxUnFFTVRDNkF0djJKSjRTaWhnOTlMODQ3a2tRNGd4d2NMUnRkZy9jMVl5?=
 =?utf-8?B?T1hFRXE4VXNVKzBBR2JPWjVZTHc4STRzeFEwS2VLRlF5UmdZYmFzeXEvSnFK?=
 =?utf-8?B?aExVeWZ4NXFtdnRKWFg2czN1S0tYR1NJdTlqTExGRE9uRE5xMXFoenlOT2lQ?=
 =?utf-8?B?U2l4b3ZDUE8xYmdVeUhyNkk3bFZnWGJEWUhaRVJSbC9saFFZQ21BM20zTkpy?=
 =?utf-8?B?SjkzajdvRVhiWGRpTE9LcUQ4d1BpMFpvZ3o3U0RreWM0cFpOL1NZQzZ4bUN6?=
 =?utf-8?B?Z29jb21GU2xFUW5sSzg5aWxCZEx0aktZTzAzWVNFMC9EaWc0ZmxBak83UVls?=
 =?utf-8?B?Skg4NmtvMHRTS0VxN3VBVko4aC9XOTFGZWFQS2MvSzVpcFgybGpVN0xNS0lr?=
 =?utf-8?B?Z3pGQ3RjTUp2QUpVU05xZGNFOVo0eHhzZlVObklYSzNYVWFVNEZUdURKSUdJ?=
 =?utf-8?B?alpsUEhjT1ZSTDZZd2I2azlOMlpJRlNNUC9IYzdFakNySTFMNk5XeHUxOERG?=
 =?utf-8?B?NmZZK1FheThXRE9SMWs1MlBIYmkwajFkQ0FzOE1ocUtPNEIvQWRwZjlrSG9E?=
 =?utf-8?B?a2ltM3hNeEttQ3NlSnhiZFpwUno5d2V0K1VtS3BoK2w5MWlDaEJsSDJwSnBk?=
 =?utf-8?B?SDBTSjdXWlU4NS9GRmNlVWkxWSt6RG4rcGJHZXJ3WW5WQ0tDWS9NZ1p2M2Rv?=
 =?utf-8?B?RE1aZ3VVejd4bi9iVWZYRUcrbEQ1bVBQV2M3OGREbFRHSUc4aHpOaGQrZDQy?=
 =?utf-8?B?bStpZjk4YStBUTFMdUxsTnQzWE55YmIyTDkzcFQ0QWJjMmdJODQxUlBpODEv?=
 =?utf-8?B?K2RFZWN2M003V2RHanVndXBDL1E4eFJ3NytaNlkzWDFlQmNwOU5ldjFrZlc2?=
 =?utf-8?B?QlZXbG16TmdoU1IwYm82c3hadmVIOE50WFRDREtxYUZrblZGNWlJVjhtNGJU?=
 =?utf-8?B?ZHVER1BRZzg3YWd3OGNkMmF2QkFUZUZscGtHdjVEQytvOG1ndGRIcGJVVjh4?=
 =?utf-8?B?SVVEZ0UwZ2ZkZDRMRkR0ditwUDBYdG1Uck5zUEtQcmU4UC9aMnVDbDE4dmVq?=
 =?utf-8?B?VEpLeldzRnRKRnpHMFV0R202RGl2SENzTWd1UjY0SWNnV0xpd2tnV01EODVl?=
 =?utf-8?B?VkZyWDlHNTBRWnE4ZWNraVFxNVZFWFZuRkFmRWZvN2Y4eTNVYklYNHVrS21N?=
 =?utf-8?B?NEZHUDJvT0tuanhnTENSby9jZFR0MHIyWDNWYkptcmwwMU5aZTMrcEhwUVdT?=
 =?utf-8?B?ZWdwSFgyYWhZbERocElzWnhuaTN2Y0VzcTFOdzUvUjJldXh2bUxSdlluWUNX?=
 =?utf-8?B?SEN5eUY5QWdvZ1BWcVpJV1FYcHUvSkJSUEsydm1jRUp4REtQbFhRQjJFV016?=
 =?utf-8?B?SVVyaTFuK0pvU0JnR2lYYmRIRGRyWCtNWDlXSXBicnpOeTRudlJKemdpbWU5?=
 =?utf-8?B?VDZOUFZIOWtEUldXbTdibHRPVGd4YkJOalBrMm8raVNFSFRZZk5vNEhTNG1i?=
 =?utf-8?B?Rm4yWVAyQzZGaDQ4YUtLeFY3UmdieFhzempmaWREaWQ4Tjhla2FONDliMTdj?=
 =?utf-8?B?WVpYRmllYlFFTG9ZSFRmNGtmS29RUmdIUHdEMzhaMys3OHpGSytvT1UweTds?=
 =?utf-8?B?YlRMSUZzdVhVNjF3bEtyeFhyVGhOU3hZOTNWdGUyajRTME9TdGhLVEFSajUw?=
 =?utf-8?B?bXh0NFYyY2NLTlVhNDdYa2F6aGZpNHRBOUtxdXJjbmtYNFRxWk4rM1Fqd3Vk?=
 =?utf-8?B?VW5vSFZJYTNvMk53SjZWVFh1ZG00eHQyY1EyUnMvNlNNNWVQZ0RnMmhlRjhN?=
 =?utf-8?B?Zmh0cERSczdLNjZQT09laDh4cDNaVmNtZEVNZllZcXBBbmJQR25ydXhuaHBN?=
 =?utf-8?B?RllVSUR0a1MwYm1CRjMxMEhIMG9aVFlpM0UxeFdsZUd2R2NaT0twdXFCZ21H?=
 =?utf-8?B?Z0EwU0hPdXBjR3ZzTjF3QjRlMzJDZVNzUXBJWU9IcTMrV2xJcTBoaEF6TkFN?=
 =?utf-8?B?dnJhRWZnU3BySmZhc1NLOCtIbUVSS1QxQmlGaTV6K1piTkhWelBzRlU2UW13?=
 =?utf-8?Q?h9aai+NBUr5Xx6Xc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb718f3-cb57-4e58-96eb-08df0a9fb683
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:19.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj+lin3QW+ND1Kw7gsMo+/6FDz3auaWq3mR/GL0hsEmANmKPZCgxaE02FfSEAe41jQz05zP7j8vug6QX+lkEeo77KhQmMJVgXooQZKmaCFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
unchanged. The quirk mask is internal to QEMU: it is neither visible
to guests nor part of migration state. Mirroring Linux therefore
provides no compatibility benefit and constrains local allocations.

Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
its own namespace.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---

(no changes since v1)

 include/hw/sd/sdhci.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c485277744..2d03e37653 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -111,11 +111,8 @@ typedef struct SDHCIState SDHCIState;
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
- *
- * NOTE: This definition is taken out of Linux kernel and so the
- * original bit number is preserved
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


