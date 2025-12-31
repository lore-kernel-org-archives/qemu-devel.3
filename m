Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C470EE642A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 11:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vatwg-0000ON-LD; Wed, 31 Dec 2025 06:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatwW-0000Gx-AR
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 06:00:42 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatwU-000219-ML
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 06:00:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi4fpdScP+toGizFQS7XCvPeDNh3FxjJGdCA12eCPRGvPMSQ58czburMlqI7f+Hpj3pi8MOhQgVQolL2v2bgwhDuTzEN51h4GLRXoakVbX8XAAXIe6rthvc2f+G6tF5JAPmycN94rlmbk0q+IZPXzgQrunL8Lft0H3Dl4kbANNZLRSJkvllhwHkMQ2zE1TNO84BATYFQD/NTL+6tcZUwfiKK02I57d/8oo59lLYvXftPBqAK7ZGNohkfR8L3QLECxpovsh+s1/cJWHQ0V30fonMOb/6br7rvWo4Sn7bpjnIvNHTAKPzm3FN8P9pgCOJP6HLr/uTW9KVlrkOPkFYMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aTf+fJlgLtVmOWsCPVUpLYxVmZvSJ/2WiQAM55Xojc=;
 b=OHk1DVyAmo9xNYaz2unp9SQiTGqWa+bbdwNEeJ2q06kjTdDp0HHYqvFifu96Wj0Rks/xAgARMkO5xraJSIk2+4iwGX6pNk1dhFxllkO6zmUxFLIAcn5qko1sn+jppII4/x/zjRdJEMXgZuqYI60P33OqP6V+acknYQ22AGs63KyiieZZ/m4EaVn2MtCt7VB/16nx6eNdg629fJqWX4Fi0egcogN9ntXdr6blGF8ouBRmGnV/myj/SG3gq7yZuf1PB3iEPJbMBvuujwQni1nWZfN5ZQ3hP24sTT11zqKMyF99JO4Aj9lojPomoi28e/6pMiizhJAUQuIY08fw6NDmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aTf+fJlgLtVmOWsCPVUpLYxVmZvSJ/2WiQAM55Xojc=;
 b=I0Zyx+sDbOC1B55MUViqAcJkiRcU8Hf/3y62Bjn6yk05DIzTNGSzw8aLbycCoqhtYwqf+N5O7UPaOYh1y3y2UgJ4dSlQCKVgxH0YrR5SoLhKJc1PRUGTrOSZAC7HFWySq+rxX+EDCUAi56Xf3ZbrIRhyQ4I6XkuN4xm4qVqR35XIOm7AJ3l0bV8napICw7K8vM4zPYc7bLXv2OxhiWVj0a8ovIvQAGbozLa9egeh5uIlaivbHocqp40p/t3lw+pTWuiD6DNLZpv2YaIZL6E7cFRhxXuuKFxpr56/8pDTPR+/9YtwTcJVstmxv2BarEnhc0fC5cVm1NeDycjEjxPARw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6920.apcprd06.prod.outlook.com (2603:1096:990:6b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 11:00:35 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 11:00:35 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v4 3/4] vhost: SVQ get the indirect descriptors from used ring
Date: Wed, 31 Dec 2025 19:00:14 +0800
Message-Id: <20251231110014.18099-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|JH0PR06MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: cab4e172-6f2a-4246-e308-08de485bd2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WERHUkt3WXlHaFJvOG9sdFcxa0hONWZqVjBQWXY0UVlvTjNvajNEZEpmZkhT?=
 =?utf-8?B?bmsxNnhkSU9aUE5QQnVpSWFuTFZnTVVGc09XUzRUZDNhSm9ZcGZqQUZXdzRR?=
 =?utf-8?B?d05lZGNvTDJoM0F3bE1IUUZ3eWluME0vS2xQU3JNQzFYRFk2SC9MSlpJaTYy?=
 =?utf-8?B?QmYyMlE4MlBIK01NVGtPMDc5VDRIZHp4ZVZhZ0ZlSUU0cnRQbHQrL1dTQ29M?=
 =?utf-8?B?eVRjMTdCMkNZbDI3RVJLSWd1KzFzM3VpaFFmc2JybTQwamJOancvZFJnVzNw?=
 =?utf-8?B?Zmp5ZGwzK0d5RzU1ZWRsS2lENExXUWkyRDcrdGdSajYyME50aGJGY2wxZTNJ?=
 =?utf-8?B?bGZMbWl2dndXRHlPb2tMOC9HQVgrd3k0eVFDZWRWbFJWL055dVFEcWw5UVFl?=
 =?utf-8?B?SVNyU3dGL2dySjhIMnJldUZUdG4zL3U3MTJYQ1lCQXRWSklYcFZDTXlhbCt2?=
 =?utf-8?B?aXlnbTkzT2lhVkhMYWlwTlhzRHlGUGJmbDVTSTg4cU1GUDA4cnUzV2lmWUli?=
 =?utf-8?B?UWQxelRDdGR0QWdkVjh1SjVsa1BBVTB4SkJwNkhmRFRLdmRtK1VKbUdyYlh5?=
 =?utf-8?B?MjhQME0zVWVaNG9LK2tMVXVmZytmaGsyMnZ3emNBUU9SS0pWZlNZSFNuNWUv?=
 =?utf-8?B?ei8zTlNyWlV0S2ZZQW9hNHNXVEhYeGY2dkRIVjVTTWdiS1E5MkNmcldkRmQ2?=
 =?utf-8?B?U1Bqd3FFYXV6eXQ1RnpoYUpUVXdsZktLdjlzRFViZ2ZGa3V1aThGVE5jTko5?=
 =?utf-8?B?Z0dXdUxKRGNPeEdJVnJXYWZvL09nL3BGV2lGK3NWOWRuK1cyZHc5QnNrZ3VM?=
 =?utf-8?B?M3M5SW81aFgxTFhjU0RLWmhteU5SVVFmZEcxdWFHenlMM3ovSi9WOS9IK0pT?=
 =?utf-8?B?TWZXd0xzOXJuTDlNQzN3MkVXNXB0c2lMZllVaDFMZ2dRNk1DMGhqL0k5NHc2?=
 =?utf-8?B?SkluWDIwTzZqd3J0WC93Nnc2UktOUnU4Y050bi9CK0l1K1lHVkhNbS96UGZl?=
 =?utf-8?B?UHljYmlxQmQvSmZQL0FBN1UvTGFZcWhSWHJURWtoRzloOFg3Tm0zdndhQzh4?=
 =?utf-8?B?Vi9tUlhlWW9CK2lOL3lnOW1ZTFJldTFLbE1IaE1UZUNHeFVtRXkwcldrck03?=
 =?utf-8?B?dWhaZlZSSFVMT21sQk0xV0FyYWQ3WXRVU0FuK0QrS2dyMDF6bE1tV0YyaXhI?=
 =?utf-8?B?cGIwUFpMOU5VVnowVkdWL1U2TXJRZGxCaklRLzRMcGEyY1dsME0rTlBqRkYr?=
 =?utf-8?B?YnpHckRjUXNhNzRXZmRPZHJ1YWpaVVhaOTJWL211ZUlnRGZQOUd6ZGh2UUll?=
 =?utf-8?B?cktGN1kxWHAyOHBaMFRzMHArK3diNGxRanBxSjdLclpKUU9ReTNkY0tGS2cw?=
 =?utf-8?B?c2VxZUpyb0NCM3ZLZDBURU5aYnlRdDZEMmVCcWxNUXJHa1NKem1SWjlZVWhw?=
 =?utf-8?B?bGVrbk5yR1hkT1VVVWcyU2NpVUdPRFVlanN6elJjeHRLZ3hKa0JEOUZicURE?=
 =?utf-8?B?M3ROZ1NxRmd4aEN1WGNYUVFMTVlpTDJiTjIzbCs2eDFtTUZVQXF1MnlEWkZH?=
 =?utf-8?B?WkU3MlNKbWRMTThxQWdsUS9ScVZiQ0kvR1QxMzZHQmF6N1dBblZaYTNRSWJt?=
 =?utf-8?B?RGE0d3dkZUJBUCtWM2oxd3BZdXIzQkViKzQrdDhwbXFjQm1ValdWWE8yM3hz?=
 =?utf-8?B?TXlyRVVWaStqNWFKZ1grZkVDcjFEQkdGaURhOTJ0ck1hT1FqN21nbTVoWXln?=
 =?utf-8?B?Y0hONVNCYThjdDZ6YkthbCtTR0FIZGQvd0J3d01KR2pKQ2diYkRGZ2c3eWVl?=
 =?utf-8?B?aSs0eSs5YVVqKzZHeUJYWDJVM2FBZ3hYRzYrbHVOV3FhU25Iazg0d0RjQyts?=
 =?utf-8?B?bWo1OW1TZVJGZlJIOEtoNVBiUjFiUGVJQnRCTG55cGl3NkFiTFdwSmVieWNl?=
 =?utf-8?B?QkpJSkE3VlpOZERhZ281M0E4eU9yVDhEYWVOcUovek13cDNVOWFoTkgxQlJi?=
 =?utf-8?B?OG5tRnU4NFdjMjluTEhtMU14c21PRHdBaENEK20rQjV2TlRUQVJBMUJ0eTZu?=
 =?utf-8?Q?1y8Jtj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBuNDIrc05teWNBbUlQSzlBU21jcldab3pYbHVZeHY1em5IcFJZTit5a0hO?=
 =?utf-8?B?OWJiNGU2RnJYa25DQkp3UGJybmhGOVhURkMxaW14eXpVMWlCRUVXUmVvSU1k?=
 =?utf-8?B?cE9tYlBUeEhMMGRYVWJxQTQzcWh6dmtPNlh0VERVWURFdW1EUzVVNnI2WTB5?=
 =?utf-8?B?Y3BDK3RRUjNucnd5NXdYS1hOb1lvTjdLVldBU29hVVhtNXF4dUtGTWNseElQ?=
 =?utf-8?B?WkxKVTJQa1VEL2RHbGd5dWxNbkxMbG9rdk9qWG0zbzhpWjBTMExqUUNRTy82?=
 =?utf-8?B?cEFCeDdGZTRVaG9YV3poREpwK29DcndaWTJYbXNMa2loSnczOVRadXZaU0p4?=
 =?utf-8?B?aDQ3VnZ2OXFNNmRvQjRnU1NqOEltSXFLK05odWlFNEtVM1k4RVpSZVkzM2w2?=
 =?utf-8?B?bXdHVkppazBXNW5QZUVsbGZDRTNpWE4rVVZ2NWtTVmpLdHpkWVdNMG1Sd1J5?=
 =?utf-8?B?Y1RXNmtDWFc0WTBjTkNYVW14U3ZpZ2hZV2Y0N2JvbFUwcUpNOEMxUnpZUEdD?=
 =?utf-8?B?c2hiQjdhOVB1anR6Q3dEQXR4M09pU3RSc2t2UG9VU2hxOXAva1hZRms4Y1N1?=
 =?utf-8?B?dnFDSTBPQ3lQK0hRQjR1MzFmb0pTSGRTWktaTzQ4VXErckZ1Um1vYXN2dmdQ?=
 =?utf-8?B?Vzd3WW9ZNnpPaVpDQTRrNnBsYkJaRVdvdXlJQ1BZQ0t1b1JRQy81ajRrQnhq?=
 =?utf-8?B?V09TSWREQndEcSsxVUNSL0V6amVkRVJtYTdjWndOUmQzQzRSNmRkTEpPd1lq?=
 =?utf-8?B?cjh5QlpEMDZENmVRZzhEdm9lTHM3d0k2TWorRkxkZno0MWt2V0pXcDZPallh?=
 =?utf-8?B?V3A1TjByQ25LMXdtaUFHRUhoMzhHOE5WSUx2Smd2VjExamdUSEc3L2daa0Y0?=
 =?utf-8?B?NHBsdzllNEtTM0pZMTFRdlVkazVHK0xVTVBTVzJRcW94RmU4cFBPV1k1ZzNn?=
 =?utf-8?B?ZzZXQkdXZFNXUXE4MnJKL3ZqSElXNGhyWUE4QXhrMjJQanVydi9QbE5DR3BD?=
 =?utf-8?B?ckF2RXl2bnNpbXVrUFNHMkU4eHg1UytxZmtuVGRLTGxZK01HeGFDS3ZJdkxE?=
 =?utf-8?B?YmlHRjNzWWdFNDhucTE4YmYyNzJibW9ERzhtUTVPbytxbHlQa1NiUjRnYURz?=
 =?utf-8?B?ZlQ5QTNoK0hLbDNWK3NMbThFMm5YeE8vZ3F4U0JWeHdUaG16VUdDMEJPM3JU?=
 =?utf-8?B?KzhCUkNmRkNWcVRqNllMOUk5MFR5cHFId2lubGE2S0g2MHFpRG5RSG00Y2Ft?=
 =?utf-8?B?aUgrdEYwaUpxVUxWQjdYNmVCcElabkxQa3JqRk9hU2dKSzluK2VvVjR0Z0pu?=
 =?utf-8?B?UTFCWEJ0YUdmc0VMZVBSTnB2NitzaGtqcURSK0UvRUFtSGNTM3ltWWZxQ05n?=
 =?utf-8?B?d1djNzdhUExJUnpCWkZsK0ZzdDhyM0xVSlFPZVU3cDVsMzdNc2hJTkJqZ0g2?=
 =?utf-8?B?aEg3TWdBNWt0RGVDaHhtZTFQRW9LdDErMnkzSFRiaUFYRGoyaUQ3ZW9xaGpx?=
 =?utf-8?B?U2tid0FsRnFzV2FwR29WY2szWm9OM3VDdlhMZ3FoejE2dVhweEc0R1MwKyts?=
 =?utf-8?B?YkdMYWxGU1lGQ3dUQmduQno2bS9XM0poL0tDbjBCejFUemxJb3BJZ1VHTDF2?=
 =?utf-8?B?K0ozR3MyK2FzejBxK0d2SjYrVEhoendVU2QzdE5qdUExaTczMHk5QVRvK1Zn?=
 =?utf-8?B?RjloZFhvV2hwVVZxTDBwOTUwdXR5TXIrZDNITlBrM3Q3dXIvbjB1WmliVUEr?=
 =?utf-8?B?NUI4ZlRNNE1YWktzdkRwSlljT3ZaR2JXYlBDeHdKV2lCMWtza09Bci9RM1k4?=
 =?utf-8?B?RWlXclZmY2huejFTZG40UDUyUWlYN2QzT3dvZnI0dXk5c2xoZ2tyWEZ2R1hl?=
 =?utf-8?B?UmpSWkp1b3liNlMvVnVCL2pJT3NCTmZ4a290cHZyQ3NJM0gvdzBvRTNNM3ZW?=
 =?utf-8?B?NWJNWEV6b2FYNVB3MFpuU1lWbCtRRE5NOXNwUGlJTDM2VGQvMnZxcGgxbFVZ?=
 =?utf-8?B?aEUwaVhhMVQwWkN1SmJsa25yYnBmOEozR21VVzdGRk53b1RYMmxCenpZc1hw?=
 =?utf-8?B?bEpIUk1TOGhOMnpXMmQ0RE5aU2RxL2FuMzJzTXdXdVZyVVJxdmU1bkJTOWxV?=
 =?utf-8?B?T3VPaWxnUlJucGhOK2xYQkY3dWNraTVEYm9xNUNraHlmVkgwc3ovZExCOUlO?=
 =?utf-8?B?M1NaOFRKa0l6cGdGcXcrUStUa2k5M0MrcnhLcFFWQUtDRjNsdmdJUmdtY0NC?=
 =?utf-8?B?U3RiZTNUTTJidUZBVmVESTFGT0h3d2dnanpKWkt2TEVqMlJ2MXMyeDF4OCtI?=
 =?utf-8?B?NmwxZHlrMk9uMFgwYU43NkYvOTMweUc3ZEJmbWhRTGpkN3B4Z0RMUT09?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab4e172-6f2a-4246-e308-08de485bd2d7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 11:00:35.2256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 106RfuRzow5pK+LHNytqDJZrJ0cfp0hq6g27GefTDVYQYIZ2mdJ40WYuL3lOtkOhykKPpaPotsN9rfG76NW9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6920
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: wafer Xie <wafer@jaguarmicro.com>

For the used ring, based on the state of the SVQ descriptor,
if it is indirect, retrieve the corresponding indirect buffer by index
and then increment the freeing counter.
Once all descriptors in this buffer have been released,
update the current buffer state to SVQ_INDIRECT_BUF_FREED.

If the current indirect buffer borrows descriptors from the next indirect buffer,
the borrowed descriptors must be returned and the corresponding borrow counter updated.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 64 ++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index f80266fc03..4f564f514c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -443,7 +443,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
 {
     const vring_used_t *used = svq->vring.used;
     vring_used_elem_t used_elem;
-    uint16_t last_used, last_used_chain, num;
+    uint16_t last_used, last_used_chain, num, act_num;
 
     if (!vhost_svq_more_used(svq)) {
         return NULL;
@@ -469,12 +469,70 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
+    /* Check if indirect descriptors were used */
+    int indirect_buf_idx = svq->desc_state[used_elem.id].indirect_buf_idx;
+    bool used_indirect = (indirect_buf_idx >= 0);
+
     num = svq->desc_state[used_elem.id].ndescs;
     svq->desc_state[used_elem.id].ndescs = 0;
-    last_used_chain = vhost_svq_last_desc_of_chain(svq, num, used_elem.id);
+
+    /* Update indirect buffer state if it was used */
+    if (used_indirect) {
+        SVQIndirectDescBuf *buf = &svq->indirect.bufs[indirect_buf_idx];
+
+        /* Increment freeing_descs for descriptors returned from used ring */
+        buf->freeing_descs += num;
+
+        /* Check if all descs are accounted for (freed + freeing == num) */
+        if (buf->freed_descs + buf->freeing_descs >= buf->num_descs) {
+            /*
+             * Return borrowed descriptors to next buffer first, if any.
+             */
+            if (buf->borrowed_descs > 0) {
+                int next_idx = indirect_buf_idx + 1;
+                assert(next_idx < SVQ_NUM_INDIRECT_BUFS);
+                SVQIndirectDescBuf *next_buf = &svq->indirect.bufs[next_idx];
+                uint16_t borrowed = buf->borrowed_descs;
+
+                /* Return borrowed descriptors to next buffer */
+                next_buf->start_idx -= borrowed;
+                next_buf->num_descs += borrowed;
+                next_buf->freeing_descs += borrowed;
+
+                /*
+                 * Adjust freed_head only if next_buf has already started using
+                 * descriptors. If freed_head == 0, the returned descriptors
+                 * are at the beginning and freed_head stays at 0.
+                 */
+                if (next_buf->freed_head > 0) {
+                    next_buf->freed_head += borrowed;
+                }
+
+                /* increase the borrowed num */
+                buf->num_descs -= borrowed;
+                buf->freeing_descs -= borrowed;
+                buf->borrowed_descs = 0;
+            }
+
+            /* Reset buffer to freed state */
+            buf->state = SVQ_INDIRECT_BUF_FREED;
+            buf->freed_descs = buf->num_descs;
+            buf->freeing_descs = 0;
+            buf->freed_head = 0;
+        }
+
+        svq->desc_state[used_elem.id].indirect_buf_idx = -1;
+    }
+
+    /*
+     * If using indirect descriptors, only 1 main descriptor is used.
+     * Otherwise, we used 'num' descriptors in a chain.
+     */
+    act_num = used_indirect ? 1 : num;
+    last_used_chain = vhost_svq_last_desc_of_chain(svq, act_num, used_elem.id);
     svq->desc_next[last_used_chain] = svq->free_head;
     svq->free_head = used_elem.id;
-    svq->num_free += num;
+    svq->num_free += act_num;
 
     *len = used_elem.len;
     return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
-- 
2.34.1


