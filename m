Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED9BC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 12:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxkpT-00044r-MT; Sat, 22 Aug 2026 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wxkpS-00044f-0H
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:28:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wxkpQ-00044m-9R
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 08:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9hSAFiN9GHgzfT87D7uVaASiH4FxboNXGWyw4Afd5bMSVV9hCUE/jOG8IcICGCIQLguNTcH1LnDIZpO871/RkXBJFq/xabcQajfQQFbMPFYMHxlgh01X2rF9E4eKjPuwL5WaM8yfIJZgujJ1PxWxGhDk3xDX4RoertM9yy971kU9pfQ0X7uElLPSH8JguX4tekIw1qNyKcopF3yiZe5EqNfpTqs0HnO3oLRgjXBxD/B5wZ+G6XrLEHUgtXCNem8WzGPSR2hrndsVDED6v1mOnK70M+Nfp7O81xr8puy+bWPvrYXdO1qQptp+sXd/7VbyBRlO+ZlKIZ3Uy536EXGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7/5W/LESB1bmfGIbvkQbJ7SWfJ9Fxco93CXbFx5pvc=;
 b=LwF7aHffYMZ3eY8+eHf4xGUmg4rJt8JYB2L7uoCjOBWdE2UIy0YiM5+YDdyj+/To2AorCfsIInh2OIyfXxkFDd5QjM3zfpUDFu2JADxOzpe0BnOEb3uY3OvYcvvUxQZu5vWvgtw21ff+7xYT4Jyh5CEp815qOHzTRhWp7lW3aXSEKSsEuuQTXpG2B3hmljI28FH4b6FffeIF4eaOPHfXWEn40CUjyLOj2QaTvj/5V5ILVwntsYcwW8zM2Bb3Q3FJjHpJEC7wOIJ2fhhrSW6ADXBkRPeqIhQxrllRb0d6nMArO8LYpJPlBEEDOs8u1Hj48DiIehDzW76i0UdUTwNA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7/5W/LESB1bmfGIbvkQbJ7SWfJ9Fxco93CXbFx5pvc=;
 b=gma2SafPqYA4VBZWCLWsGA9188XQUWiMU8UdufjkzZcfikvYKbAFYL8zfB9e8XXxM34HYiE1gYpIPcObolmLWheVfkVzrhOm0zFwPVeu3VeSMf30+mGY/9oLTBnH/o+sYMeikyoh545Wvv9HJCIByAZ0nrxxwMewL0f2+CB/kZQUDoRqtg/hn/S/auiiU+qBqtkGXc/SNM97i+AWrg9Yv59XPARr4SjiWxvOQzZ88fvbzi+8rscvo3lGc6Q1QCZmkf/SG30kOOEARibVHefJfJAmSUoXIZoLW0U8jEOk+6tcjjjFCLCzJi59R8z13YazdYcAy/rrMlRcrUxSksCD3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6504.apcprd02.prod.outlook.com (2603:1096:400:363::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 12:27:28 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 12:27:28 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 1/1] system/physmem: Improve guest memory allocation
 failure error message
Date: Sat, 22 Aug 2026 20:27:08 +0800
Message-ID: <20260822122710.3731595-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822122710.3731595-1-bin.meng@processmission.com>
References: <20260822122710.3731595-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:405:370::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7749c11f-bc96-4e52-b61f-08df0048bb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q+sUepdN9/O7D/IIwmx+L5o2GmcbCuSMLCFR3ul69O+iRjqeC/r2P6rjBKPeApf8+cdWluqPTYg2UOvGW4VH0xSBE6OKHfjxi2C2LlG3iSPTCt901dqbmQ3wgeebHbU9ecdiuxtHyv4Sv0zYZiSOm7f/v62y3wmz7y1gww73W6bk04RP+J2i8yBjKLHhRtFvxgw/eNxlW0s9kzhAZlGfHKLpE4Igyhp00ImQyinuOd7NcoZGJXiGvQ5KPB5eYeoGFZ7faFGzG+VLJvxQbxfMwovMKpKNDoYhEOd8o3LudmtVxdcCfJ1cnChFTMh/cbSiici6qiJIX+IaC68rYprfqhDI+CGgwJwSKrWB/Qom2oeCsUj2nq12PACeXvzSc6r8Srj1oh2UlyAb3RnsoDCWp4GbDsmcy492x2f+exuj0fU6hCkrg2gl46C2nwxAfrop46uUtbj1v0RUp7UAsb3y2JgPYV6jeOahTcvye2jzxjZk34spmV0Kvx383wxoJqnXDdXR6ScSPdfLCppsM/nSEfXHSxUa0aCSfGtyTO46ok22O1cJpznb0FuG86h5tiXw3tQxRB3EP+WsyCKO4m8/fzIhWm3kjsT9Uq1RcY67mnSiLPdXzejePP+hr+kXdwMs75nS1lSrvlS3wxxMWsDjenvgxmWuSIYYJc1fIiR95AU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5Pd1JJNlhuM2dTSHptRHhsYjQ2TnpBcVEzbjVUdW93Zi9LT3hQclBTdkxF?=
 =?utf-8?B?eEN1cktQVUFJUjJPOTN3dWZ3VnZGNnNkS0ZKaEpsdmVrQzlvYmhKKzlhZ2Nv?=
 =?utf-8?B?T2VmOWE2eXZNVjFsZEtFNXBRWUs1MTdoWXh3SytLOVhDRjBNVWV0YllQQW5i?=
 =?utf-8?B?bmZnTnEwZEMzRjZvd1ZIVFp0QVkvdVFOamZEY3gzK1IzUFlyK3BrSlZLSkQy?=
 =?utf-8?B?VnlTdmw1ekJjRmZkL2d3MFNZVFN3dGVKc0RvNkpXNC81ZFVPcEFOaTRSaXJD?=
 =?utf-8?B?cGU3bTBacTZrZ201TTJ5T0F0SUE4RzBPbmZ4d09UalhiRG5HWXVkVlNqekxt?=
 =?utf-8?B?S3ZhTVJ0R1VUZE9LTWNhOGxkeEEybXBFNURSbnNWUFZzYVJQYTVJM2RqMzhh?=
 =?utf-8?B?TkZWUjc3MDhGLzU1UWZUalZ5aEFhczBBQWsxNDVzdHlPdWJ3TERCWXBXQVZB?=
 =?utf-8?B?Q1poVnJIQUpyOWd4d0VzSGdUeWRjUi9GUHpjZGVwb24vZ0tobEtlVUVwYk5X?=
 =?utf-8?B?ajNVdzNPOW5hTnFFenFWdXJvQTRRMUJiZWc0ZllHVEFQY1prVHE1WmJ4Q29y?=
 =?utf-8?B?Q1JHUHhnSUEvZmlKbW5pVDNCZDNBTEJTZndqdkJqWU5rbkhoakVBYXh4UG9p?=
 =?utf-8?B?SXg2STljTkszYXhmRUxBV3NkbVhhQ0FTMWVBL2hIRG56K3djSStRVzNkRGpO?=
 =?utf-8?B?NGxhMmJSUkFSODNFL21XdDg3cDcxcHpXZm9pMmNkcXFBa1RKMjdSdjA1b3dF?=
 =?utf-8?B?VklYZ0lUM0RTSnRsMDFMV0dMZGE2RTV6Vm1DNHBuYTltRTNVUmpwOCs1amdV?=
 =?utf-8?B?S1daa1ptVXluMmdVcmdMUW5UTjlEVTd0ZVNOZVpwTDFaNHhEeXhIZUtFVW1m?=
 =?utf-8?B?ZXY4VlBHY1hlazE4NVU4VTlCZGZ2dWFrelQxQjg1UWpWUi9IcThXdHk3VkZI?=
 =?utf-8?B?RGl6VTg5bU9RY2JzK1lJQkVLZUhxKzN3RFhxU1hJR2o0QUVYNERVbktiTzhO?=
 =?utf-8?B?bzdyUE9jZXNrZmlqdFBteUROMGxHOFBaZjlNbWtVYjc0ME8vdVQxcGg5RG5I?=
 =?utf-8?B?bnhMck1NSzhlMXZCVzNSMURidVVkYWMreUlMMFlOOHhsMVMvNVdMQnRpcW5t?=
 =?utf-8?B?OFI1QjJPUUcvSFBXZTVSM2lpMEJ0eXhBakxnRkt4MFNSRTZkT0NRMXdmRm9X?=
 =?utf-8?B?UlMvc3l1VU5jejV4eldTaldtemh3Rk9Ra0hLeHo5aVcwVGVlNGZhTVVPdXJ5?=
 =?utf-8?B?K20xSmsvcU9pUk1KRStHMzlJRlVYZU84eTZ6aFRRanhqNk5wSzdsalJ5OGRQ?=
 =?utf-8?B?bTJ4cHNHTURUM3cwWitBYnZGTnRpSXRIWUJlcFZXTDZWT1ZKT3J4K016TnM5?=
 =?utf-8?B?NHlEWHdsaXp1M0k2UWpVRHRtZXRmc3lZSmx0NEttbXNvRkhmbmRUK3pTSlNV?=
 =?utf-8?B?YWtVU1dmVVoybTgwMUgxdi9HY1hVQmIyQ2NPSHVFMUUxUVRnVCsyNFBDMWlx?=
 =?utf-8?B?TVF1K2dwSnU5Z3k4cDR4WU93SGZvK0xQUFEwNlovclA0ZkRIczNUYVp4RUh0?=
 =?utf-8?B?Nm5lMFFYeVp1dXZQa0luRlZybmRzc2VjVzZtUGxsNmcycy9xSXhXdjlRNVZj?=
 =?utf-8?B?dlhodlhaVk8ybFBjOGs1WEtrL0oyZnM4MWFYLzRRcUdFTHZhcnNPem91OVNO?=
 =?utf-8?B?K3luYjZtZmJXNy8zS3FRYmJVOWwxMEFTY1N1WmJGaE9EcGNjVWJNRDlpY3FQ?=
 =?utf-8?B?bDBURHE1d2xPL0xDZzQreU95c3VMcEM2b2JZZWVzWVVlOXh6NkVHSCs3aGM1?=
 =?utf-8?B?SmttVm5TV3JRNXRYc3prd21uMStzTkRnc1l3SXZOOGsrbVNNdmNiWVc3eTY1?=
 =?utf-8?B?YUZ4QlVuYVFtbDBuNm5KTHcrTzJNU0R3a1ZWOXFXMHZ3NUZwWUZMaytta1pI?=
 =?utf-8?B?UnlXVlFJZ0lHcjZVNVJVL1VvVTg1Vm91UHIvVHFwWlZub2dqZDRqQmhYMmRv?=
 =?utf-8?B?blF5YWlaLzcvNnpKeUdHVEdiMHBCdFlBdTJPeDg5OHROcU50N3VqTTdNZUg5?=
 =?utf-8?B?dWFiSnBXdVJRam50TnJkOXF5aTFGaG5oS2lJREgrdVdidkRiR3pJT24yV0pk?=
 =?utf-8?B?cVIyTTdLN1NLbXpMMWxPN0labUFFOFdHWGZJQ2JBOVhKUzNMUnhrZWZKS1pW?=
 =?utf-8?B?RlV3RFVHa2kyekl2eWRyY1VRd1FXMjBBREJpeDZwdElReDF4YmtOdHhrdE5U?=
 =?utf-8?B?RU8vMjNlcmIyaFBqU2N3S3VyT0YrSDhtRTJnaWFwSHJvVGhXcDJIemlqbHA2?=
 =?utf-8?B?VjFzTFJpQVNTckh3WXVVa1J6Qm1IRGsvSGE5QmNmb2lXV3R6SjNTS0Z4bmxV?=
 =?utf-8?Q?nu9xcELE00gfc9ag=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7749c11f-bc96-4e52-b61f-08df0048bb07
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 12:27:28.6732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOaf0QYvT99XON4N1xU3bEi49P2pXrh79K+xCzkZBJiw/i/3gwhNCOF+81bK2eJC882WhgNVXbAmt02huwgcbwkMaNabq9RMulJq9Zi8eQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6504
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When Linux refuses to overcommit a seriously wild allocation we get:

  $ qemu-system-i386 -m 40000000
  qemu-system-i386: cannot set up guest memory 'pc.ram':
  Cannot allocate memory

Slightly improve the error message, displaying the memory size
requested (in case the user didn't expect unspecified memory size
unit is in MiB):

  $ qemu-system-i386 -m 40000000
  qemu-system-i386: Cannot set up 38.1 TiB of guest memory 'pc.ram':
  Cannot allocate memory

Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Rebase onto current master
- Update the source path from softmmu/physmem.c to system/physmem.c
- Fix a typo in the commit message
- Collect Peter Xu's Reviewed-by and Bin Meng's Tested-by

 system/physmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 362a00f76c..89ce6479f1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2171,8 +2171,10 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                                                   &new_block->mr->align,
                                                   shared, noreserve);
             if (!new_block->host) {
+                g_autofree char *size_s = size_to_str(new_block->max_length);
                 error_setg_errno(errp, errno,
-                                 "cannot set up guest memory '%s'",
+                                 "Cannot set up %s of guest memory '%s'",
+                                 size_s,
                                  memory_region_name(new_block->mr));
                 qemu_mutex_unlock_ramlist();
                 return;
-- 
2.53.0


