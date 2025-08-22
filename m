Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C99CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQew-0001bK-Oy; Fri, 22 Aug 2025 08:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQer-0001Z8-45
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQep-0000fW-0o
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:12 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M84BpX703317; Fri, 22 Aug 2025 05:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9sTPWbzOqodGv1XXh1UzXSeIPVVlneSSNU9XQz3Wh
 Cs=; b=f1WAgPByi1zsdaPLuHwA23j2icX5DVQ8/a7xgxRiMybokCYAAsyxi2FT0
 CbVmw998YNWVuF4q1KpPH6w59jea/ygh13sv4+fmd5cz/2loDg7RM+euz6atEP5W
 yRrNZ1xBJLe6+9Ua6MDc2eS/SCRmz1htg4CZxt8bl+/9jglMHRaznJLG9xOTukTE
 zVEYioZCIN6Ojp/KGU7DGxcguWO8vrJb4ZSBaCFc+5uX1PeLAuwT5ITzOaO544Dt
 GXukrtiqy3dOj4dRLzRb2eekAOuhaBKRN0KQ+cvJSS2UGJrm6Pcd2TllZDSFdMsC
 GIl9nnS9iW/Vc2GZ7o6Id/4bo1qCA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48p6uaa6g2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVO8SJ/wa0sq/AksLrFaAmdHWQW9vkv6buKfvBwsLd7zYlg7qxHw0h5epmrG/M/iN2tIzTFEFJNIivSWaMZGStdo7855W7bvKnxeWMn2qIETunQyVNfOymCSxjQeZDgyO+5XN0vjvjsj1aZvrtHJ5IOOzXwL0oTtpgICNAGG+hcCRT627WHzj+xAHUc/PR+UT8Onz00Oub4OnE+e7p4f2lTMB/EsYV+L+W+w4v8HmR/xAlcSOggAHzTGYtrQFtlDCKoOFTtlQCjQ2lrn07Nlrla7r1zRUOVO5WICw2l/8P+qbM4f29Fkywm9gKFNb9cvAI5QZy4wXFMnJq15RaX5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sTPWbzOqodGv1XXh1UzXSeIPVVlneSSNU9XQz3WhCs=;
 b=Y2lQkw/wfFzVW1/5YRIe2PCHX1660Jkm/oQxGoobAUvIX0ilT/94akurSjIUaSekL0FGAjrGDe1/m0whn6Drv7D/Vs0ZfkPHt/k0Vc92wIpD/mjrqqoEOTr1NXX6fvEIoOJcnXpxs+zZzThl70M46Kea0cvLg4ydtu1m4v72IJ/JR9m2DEfNraleEyb2d+tVgow1RMQ4bb8ntvKsYozS2AG5rywVo19MTAxULIbIaWVNt8u312NzgrN/kOqfRZFhFs9pTv4+isAxzZgMR1sGF7Kf9ktnge+SXDd6YtKBmgLh7HQ6n3BHzekapavxB7mKn4zzDSRoIwvon5zPTXFaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTPWbzOqodGv1XXh1UzXSeIPVVlneSSNU9XQz3WhCs=;
 b=NvPWQJ0qyFLTgAAbXfbi2MPGGt31AgP0FPnfpOr/zziY2z4C8L4+cZMnixAB1YYci5hsogveJV/2a002sI8CTvgJFykUhexcdUfiTDED6abgtXz8/J4xFJfvIPXi9nF53kPGoaNdYqu09OTEZa0fVWxJAAuE4Sd3MLXY2FJGfteP9YNzhexds4ou+XyHaHnzPYWs1XO6mtWoMCK8yt/qPzN0QfXfifiN2oIaQ0zy0oRHLKCRXthaeCjtr6x8ZoOoWH1g5n7BNcmr6PFfAoM5xpMhd+mrq13KG2CNUoAnOq2Ck83EVqlBZ0zlXd6Lan/qB4Rkuuf4Wr36O03NEwJiiQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 06/19] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:52 +0100
Message-ID: <20250822121342.894223-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ff153-0641-4b9d-ab0e-08dde17564bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVp6WkZ3bC96d28rV3padEJrSlZKTDhVaTBKaHNEaUdpU0p1WWhlaXdRSnZp?=
 =?utf-8?B?ZmRtT2lTRVlQTjBWc3BhaTQ0K3hJRFE2TDlGRmMyWjNzcUU5dFRVK1U1TmNO?=
 =?utf-8?B?aWlueC9obERyQWFMU0MwVWZWNnpHTmM5ZEFKVFlmMHNTWmlBeHhzUnhUbytP?=
 =?utf-8?B?VGFjL04zbDBMVDE3UkszU1lpOE5mbG5hSDdQRmQ3NzRvTkhGeHUyR01Qblhm?=
 =?utf-8?B?ODdERFR1aFU0K05vZER0SnczbjN0QzVXWVgxUDU5LzVhYktjN0xHNGU1M0NL?=
 =?utf-8?B?bjF2UEttTlRVVFNVSFRObDJKcGZVL01yZUl4TFlhSFB6dityT3BSd2QvMGlE?=
 =?utf-8?B?ditPaG10QXVGSm9zTjB0V3VlVFhPSnpQTVR0OGlRcmtVbjhaQXIvUGVIUWcr?=
 =?utf-8?B?bzhEQnJrZm5lWlEzMUxNVzVwRFhCVGdTK0s3NVN3RStCNTF6U1FSTm9PTE1n?=
 =?utf-8?B?VUNndnJ0UU1QUEtpRFdkS0R0V3dTR01ZcEx0TEJDOHZKSk44TnNFSmI0aDlU?=
 =?utf-8?B?WmhabkpuQW9MSnRJNzVwckZPUEZrbE1lWktSb1ZVMHNWY3RzZUY4NnJPUklz?=
 =?utf-8?B?dVBlYWZkOE5SUWZ4NHJNZG1nRUZ2aXVXWnFyNGhEcGczbkV3QmtyQ0NOc0d5?=
 =?utf-8?B?WnA5ODZjTzRiUlhUZlpCV3Q3MFo4ZzROdnpLUlFUME1QL3dLRzRMTDFXS0V3?=
 =?utf-8?B?Y3lMazhXRkJwSTUxc0VDL2lEcjQzY04vcG5hb09RSzRnOWQzdEFqU3hNTDBs?=
 =?utf-8?B?WHpPdnRFc0drcXBrdi84QTBvdG4xTFgrY0ZBUTIvVDVGUjBqdDdwY3FKUFFX?=
 =?utf-8?B?R3pHQjJQckRJM2srTy9aYWJISDRwTkhBUXBjdmJaU0FYT0ZiZE9GTFZNUnIw?=
 =?utf-8?B?SzRkWnFVU1ZhaUZ2ZUhrRmViUk1CdlJyc0Mxd0ZTWWN2OVFodFBhZVJXQkwv?=
 =?utf-8?B?c0lnOEMzaHcvcFRyNkNVNVRhMlNybiszOXNMSjI4ZnFKVVkvOUFuSVZxNitD?=
 =?utf-8?B?OUNtZFE3NXY2ck1ITDVLcjJTMzJaOHhFZ0V1MEw4SEl1TFZRTzZaeGdEYk5S?=
 =?utf-8?B?blI0emRMWGZKVkNCKzZVNDB3SUxwTU9QbEdORVdkemZUY1hSMi9HUCt4N2R2?=
 =?utf-8?B?aHk1TzYyY29oa0o0clk3ZGFja0t6RWNtYStkSkpXc1lqdjF4VzVibHR2ZmZo?=
 =?utf-8?B?RFdtT3VlckpkZDg0TjBrNVNZMTUwbTNCcVpLcmMrbTlSYStjZTNXMG5GV0Ew?=
 =?utf-8?B?dEI2ZURBVW5zOHBmU2s1am93b3JPc2dwajhuQllja3BCdk9FZVZnbVlnRU96?=
 =?utf-8?B?bEt0UDBBckZpZ0lDQU9ZNnE4QitqRWNjbG5yWkk5bmp5QzhhRXc1eUZ4MmFI?=
 =?utf-8?B?SFUyU3M3bmpuMDRURE1LdzNuVGI4NWQzRmJWbnRvWXRTR3RpWERBWGJHUU40?=
 =?utf-8?B?eGxEeE1ud0ZHTGNYZnFvVTgvQ2Q2bEFTc2VkRFJUUDZQUWp6NzQycE84N0wr?=
 =?utf-8?B?WjVWUGhsVUs2TFJEbTVUZXEyRFlvMGVkUmVhaS92bG1xMVdieDdRd3BLUE1s?=
 =?utf-8?B?WE9TUTlLZEIwdndUQUJZbmc5RUxYSDVDMXlseCtJL3VRVVVWWVFUaXNLZmtj?=
 =?utf-8?B?TVMvZjU1dGZlbEF1WGRHS08yV2tsemJZVVA1SjNRT3ZlWXkwS1dmYmUvYjN3?=
 =?utf-8?B?SmFtMlBsS05YMTdUS2hjOU9Sc0szcklnTlRYZHJleTdSUEN4VnphSEV6MWRz?=
 =?utf-8?B?K1R3U0lOOWxQbDVOb2l5QjhzeDB6dTdmL1QzY2NVQ1Nsdmtyc1R1c0pQNnlI?=
 =?utf-8?B?ams3c25UYVpGY3UxWi9NclpIMExuSmgxMzVublA5OFBNRVpNdi8vWjgvSnB6?=
 =?utf-8?B?bXhMRXFVY1VPWW9qL2VtME92NEJxL2hEb2drOW51LzBwc1hzZDFUaVpKY1Jn?=
 =?utf-8?Q?YRxbmLvwNSg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNkcklwU1Q5QWNRbWhBZUwwOXI2Z0pyOHpRZzU3SmI2U0hUc2h6TFVQMUJQ?=
 =?utf-8?B?NE1IbHhOZVU0NjlJOVoxVDVoRDMxdVdNYkQxOVRKTGxUNnUxMUY3bld5Witz?=
 =?utf-8?B?RDM0RDM1YytlWisrUzFCSnlDOVVrL3FlbTNMdGJaTzgvTGtRcDlvdjdpanZX?=
 =?utf-8?B?YWFTZlJOMW4rZ0tZaVlGS2VyRHFuREhEdjM0VEdnaG5teXVrOE40R2lRM1JV?=
 =?utf-8?B?WktnSGJUeDc2N1ZQbzBidjVRNkhMQmZTWWFEcVEvOForSDdwVjdJWVJ1bitE?=
 =?utf-8?B?NU84U1oxNE12RFMvT1N4cW1acktxWXhRdG0rcGtYSy9yNlMyRmxxaHo1bVBG?=
 =?utf-8?B?Nzd2WEd6WHRwcTZVU0h0cE1GWkdsSHFma01XVnBjd1B1dmRkbmxYYjBMY0Ur?=
 =?utf-8?B?b1Fub3JMdVlHcDNaVlV5enUrNk90ZzRrSENjcGJnK05GK2VyNTBaVk1zMXV4?=
 =?utf-8?B?ajk3U3BkTVpkcmFKSkN6VFF3a3llV1o0ajNJNE5yYVExcTNCelpYNDB2QnFk?=
 =?utf-8?B?aEhldTRGYStQbm1oakF0cXNDWGw4ZkxqcmJTdVFGUWQxZ1ZuZnFEZHY1NVZ4?=
 =?utf-8?B?NlY4bEFNdEZkVGpZMXI5ZTFlOUZqeVArWWx6VGxCZ3lOdFlZM0NTNnFpMHlK?=
 =?utf-8?B?SEgxc2xockZtNDFydUNWd2Y0bWtWSzAxaTh6NUhrQ3planpweVVDVWhFeFRu?=
 =?utf-8?B?ODJ6cXZOTGNRN3NBbXNSVWpDS3lyTHEzZ3dralVINDVwcVl6ajd3aGJKSW84?=
 =?utf-8?B?WDc4WHpGSHQrbkxuSW5YOVVGZTBkUUdQQ3FQRVByK293VE40U2h4QStQYzRv?=
 =?utf-8?B?OWEyamhWeTBMOTdnMitSUmJXQkNmZGZ1RnJWQVR1M0Y1cnUyNkRUTDdDMVJx?=
 =?utf-8?B?cXIyZFFuNXhYNUd1YXdrSHdIemtpWitvY1Vsd1ovYWk3eC9PS1hpd3MvdUZm?=
 =?utf-8?B?cHdEUVByeGo4aGZ4dmE0bDIwNWM5TlZaTEhVVnpFMFVndUVsSE9nTzc2ZnhV?=
 =?utf-8?B?TUliREpOVENHczRqWGpMRmRLSUpTVE5xSGxLTUd2a2VmcGRTYWovMWJOYXY1?=
 =?utf-8?B?NXB3bVM4M05pUFZWOU9iajdqTktFSzVMQ21LbEZ0WHNhcHhFREV5Z2grQThy?=
 =?utf-8?B?RHkxb0dvZDdaVnNsa3VOalh4NFRPZzI4aVhBbkxQbnY3TklhZ29hdmdkYnpG?=
 =?utf-8?B?QlpHMGQ1TnNVR01EaGViN1FBODArdEgvenpXV0Z0RnVsQU83Tm41K1MwOTNE?=
 =?utf-8?B?YklGaGlJWklaWFBJY1dpOHNvRUZJaytwM2JEZDJEZmljVThJbE1KbUc4dTBG?=
 =?utf-8?B?anBXbkhmVS91ZUh1NjVnTHZnUjNBZjRBNDRjL1pXNGw3QzBDTlNwR3JuSkIw?=
 =?utf-8?B?RTVPN09vdGJGdTlLMDRvaGd6Yk9tQU1WMzErWUtQOGVFSlk1Smp5YkpScGl4?=
 =?utf-8?B?MFdUWHRoVHpRaWN1ZTA5RTZnazdCUTFFcnhKZEYxcUg4TVZuaitZNG9nbkU4?=
 =?utf-8?B?TmtOc1pNUlRaK3I3KzI4SFMzYXJGRWZxRDcxSnhHRWs0RjlycjNCUTIyN2JH?=
 =?utf-8?B?bjhYQ1ltcElGYzNLQW5mVHozSmN6blNXL1RzTlpCNlZwWG9reGwrcC9ERjhy?=
 =?utf-8?B?d01aNXp4djZZNnJWVHJIcFlDcVB1Y29Pbjc0MVJ2U0hXenFaeDA2cEt0WGEr?=
 =?utf-8?B?SmlDTFVEZDgzNkRTMHIrdzZqQ0RiYTZaeXJWajJIa2swYU11cFhUT1dYL3h2?=
 =?utf-8?B?alVCNWtFMlk5b0xhaFZpbmNIWmpwYlhRWXVWUXUyaC9nRTFMVzltSlhLQndw?=
 =?utf-8?B?SEVCL1pOTExnMHZnV0JYSVdHaWFxWHZ6blFBQ2s0Rk9vOVE4Y1FKZUhrNENN?=
 =?utf-8?B?eGhTWHZyRmZwTkVscEg2UExwU3dUaVk4ekZNRllKNFA3WW54YklBb2gwVUJi?=
 =?utf-8?B?RVIyVnF2SnFTbzdXTGdybG8yQ3NiQmZsWFJOb0NxakFKTVVuSktOSU9odGZn?=
 =?utf-8?B?blhPc05OUHkxd0dzbVQvT1pGWVE4NXhKYTdFN0xzeFUvcm9ZOG9CUUFrWDla?=
 =?utf-8?B?eEI3OUNTYnJ4R3lFSU9CZHRmbHYvUFp4c2QzV25uVWhDYURvSXNZL3ZwRlFG?=
 =?utf-8?B?bERGVEt5V1dXNHhmTlNmc05waEdraCszVkhLWFBzUXVMTnZIQU1zbWNzd2l4?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ff153-0641-4b9d-ab0e-08dde17564bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:07.4665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXvjKEQYSsKORiWh6xtYZGaaR75RC3rvLUfBrs5bRElK2LfuRPebP/wMyJpoRcHSJ7cSEP20sCAeXrN0KIYBdnKXwpRe5SQCYqtpYc4J0Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX9LRRAVrRS6d9
 J4xoDRCZY9J0/NByYLg2L9IEMKbQ+AT2dbILrW93aQo0ZaZJqSoRnYx/pLb6HpuOEU+6H8KqL/i
 ZSb3gAWiaf4nWwy3qq3vZ6oHFC/vReYBwluIVWygoSiwLVocVYfJ5lqxfhoXYu8w7w5lnfOsILP
 8mbqavgolgKJJtLCSnWSI2ZyucXZtBNCBpq8ncvpFDatEKuqbb1yQhmdjXKXSn+eJ45y+SuIvMu
 Ck+r//a8QjkDkniKBT6VVNOGQtSTeZPXK+ZakPbJ+OTHAxD6kdQhJ+Y3MqYRBP7+uBbYmegyYoN
 PrjgG2RjitxWHmnOXfP4moF4NQuLmt9CKUReh26Q+KkS8Oh3MfSYi7LNa8ln+ka3FYYbR4FubKg
 p1GQLqolegwNLTfOXEikhNI6BcQ2lA==
X-Proofpoint-GUID: OBtpBhWQOYA5n2a-KGJxuDOCj-x1qapf
X-Proofpoint-ORIG-GUID: OBtpBhWQOYA5n2a-KGJxuDOCj-x1qapf
X-Authority-Analysis: v=2.4 cv=Zsu0697G c=1 sm=1 tr=0 ts=68a85f11 cx=c_pps
 a=DmRYdR+pfzj2fdMzxedsIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=F9lpminiuFHZMRiaUDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index da2de88383..e58a7b3977 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,8 +441,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -597,23 +595,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


