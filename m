Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78ACC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 15:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFF3D-0007zc-Sq; Thu, 06 Jun 2024 11:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1sF9v7-0005RL-SI; Thu, 06 Jun 2024 06:00:34 -0400
Received: from mail-southeastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c401::3] helo=SINPR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1sF9v4-0003eU-MY; Thu, 06 Jun 2024 06:00:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICr8sTvCRKgALtrJMzqlq7wHH2FoCHbYx38JImlgIy7dLG/uuACtIzlRlZppfp+WaLlGffUmFhvFEj6D4voKdkWGeHUBEmVyNZiy2MgK0YpOxnRfNjn0VXCX+PoIg6tGjrZwKU2gE27hxhrhCCn/xRu75bJLKiugIxY5Ssb/gNabjnLCh5cG0hzS3h9aH/h6AlGnV9nU6gLpg8Rq8P5Bj/p9N0XM7eocl6xckPHLPcNTNY3w7DsSHSb3sN/3Jz5Hw5natn9/QnPivWrXB4/djmaUp4h02x6OTdi32+YbkGC8Mw7WScPe/iPCDxtVk30ymjEyOuwXT3TOVBVqvIEJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=148R7X1ib0+yDIg1UtkggluQAb02ZWf4CIi13gPlxvs=;
 b=b9PpHG7kU10kBTScESW3x8WlPysAo/uKeNoxrX9jeWs1Rwv/c3OlvOuyrPxcB33jJHeBqYBveZ7GqOTDueeEEd2zplgMnd14lY8TNr5gh+q90lUyrqztcGV5DMvFJ6S75n3GTW684n0bD0QAztJrao1O/3H8/w5mRSfzHQxTUJAgIc9Vpjiv2evqOcBPDPk6hrAxG6oWywXhB9FYbmCa2yVIofqKtb21k1zwslfoKWv+6H+RFS1l9qjuKQeEi4HphOVVoTZuBH1F0yBwnjBR8PdSw4rHruG8yatJCwK6pMwwpOe9LqJ47pCv1rhIEVC6iBU7MxOzOPYcbZFtJx6HoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=148R7X1ib0+yDIg1UtkggluQAb02ZWf4CIi13gPlxvs=;
 b=p02ZqQzc0MlR0GfTvy55mNojsrJfM8/ZsAL/2KE2ctfahI/tl3G53pvLRFw2+jLB8ogTrsekFItWmwYdS7jmTqReDxmM5rG2wzsYy9HrcbQ8jgjKAC7YUcX+GBjrqBIYdeF70c8RcKr2R49x7OcaLEpvRu9uscetobHUbPe54gNqmvLjKr0I8eKz4diNryiyAwYnL1awVbv54r6v7exKObJjAy/pb5iVqfE7nPBbh6UM7neoqIhXRy1iEs2XehV9+lLmevZx40yAqBG4uPlnDNKR4c0e49etzVYc9avI2jvXFAFMit+X1koiq6wflooUjmu0N36UC0ay1Wrdlrddqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com (2603:1096:820:ae::7)
 by PUZPR06MB5433.apcprd06.prod.outlook.com (2603:1096:301:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 10:00:16 +0000
Received: from KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2]) by KL1PR0601MB4891.apcprd06.prod.outlook.com
 ([fe80::8950:42de:2354:91b2%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 10:00:15 +0000
From: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
To: luc.michel@amd.com, edgar.iglesias@gmail.com, alistair@alistair23.me,
 peter.maydell@linaro.org, jasowang@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
Subject: [PATCH]     hw/net: cadence_gem: fix: type2_compare_x_word_0 error
Date: Thu,  6 Jun 2024 17:59:52 +0800
Message-Id: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
X-Mailer: git-send-email 2.37.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To KL1PR0601MB4891.apcprd06.prod.outlook.com
 (2603:1096:820:ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4891:EE_|PUZPR06MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 79126536-ceff-43d0-280a-08dc860f7695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTZCcFJ0WENvVEEybEdDRVgrNWI3N0tOcDl0Z1JxMG9iRVMzL2VKUXlVbEdp?=
 =?utf-8?B?cldOaGJ6MDgyY0FFbUFNM2tHU3krUmZZTU5nWFFFVWFuR2xFQXhKRWxKc1Fl?=
 =?utf-8?B?cGVPNjBhazBtckp6UTZuV2xMTzhuQ25lZVp6QnUyWHRFY3Z5bllVYm50Qnk2?=
 =?utf-8?B?VVkwSEd6QWovS2ptNkFYY3hHbWlhSFNNbzJXV3o5dzQ2TXAwVG5LL1pKV3Yr?=
 =?utf-8?B?K2FTejdhS0g3cGxyR294QWl5TUJlSnJGMDNDRGRXMHZIM1hNVEgxQ0FKb1kv?=
 =?utf-8?B?dnEvaCs5NlVtQTh2c1F1R1hEaVB5ZkxTYSt0UzIyRWZEZ29aQnFmbFlveHE4?=
 =?utf-8?B?dFJDaEgyR01hM3ZxMnJlZHVvSFJSY09kSnlIMmdjZ2t0ckQvTDk5MHc3dnBE?=
 =?utf-8?B?VGYzRGxLZWRoL3JRNFlrYjFsRUhQTXlFSWhzTGlvVTR0d2tmbGxLcEp4OTZm?=
 =?utf-8?B?bnB4TkYzRHlyVzdMc2N3REMvb25TdWxXYWJlNjVZRmFNMG9ya0xLNXo1aURR?=
 =?utf-8?B?U1dERU5jemEyM3k2U3BLdnhmRUdjbUU2VzExWlljemd1UmV4NmowNThvOUdP?=
 =?utf-8?B?WkVqUFVJU2Z5RWx2czNyZVoreFdRYWIyZDRqQ09CWGZ5bXJlUEs1ODhKdXJT?=
 =?utf-8?B?TVA2cGNWWGhXUStRWFVLcHJSbXJJRms3STJLSEwrcEhNVFNPMElyYTUvdGFz?=
 =?utf-8?B?VjV6eW5CdHEzRU5TeDhVMERySVZRMGM4eVdjeDJvRG1aSk55NEwzZ0szRU94?=
 =?utf-8?B?U0JxeDNOR1lyNHJRWVV2VThRVmRuNTZ2Y20wQlEzRTlrbnkyd0VuTkVWajdS?=
 =?utf-8?B?cUxVekVzY2VKSEszM0lmUHJTSEk3dDJmZnFUeTlqajMvS3l1NUFENU9xd2Q1?=
 =?utf-8?B?czh4M3JRZnBLc3hadDhyNXo1Q3NlbjhDa3lPek9JVDF5bFpFY1BOaVB2T3dI?=
 =?utf-8?B?K1FDV2FiVUV6bSswc0wxSGduNTBTdjNBeURWaCs2WTJ4dzlVbW5FWnRmd1dp?=
 =?utf-8?B?RXlsVE9WdGdTSXR2NjZpRW1wLzJWcWxpeDgrdE1oK29OaUpHTzBQeXhhSFFo?=
 =?utf-8?B?cHB4bFBWVk1KOVJBU21YM1FWS3NWU3BPeWdNc085anFRYTl6bUh1OGQyTHQv?=
 =?utf-8?B?U3A1MkVBZUMyOFZlc0JKWkNyUDBNd0ltNnhzR2FTL1FhV1M1Q2tTdXlRb21C?=
 =?utf-8?B?ZEhMVW95SDVVMlAra3NENlNKN1FEQjZZVktxNzBiaFNieHMyU3NBcnc2bk9Y?=
 =?utf-8?B?ODBsZGkyTTNLcVc2eFFhQzE0Ry9VMHFELzRKVmI1eU5nZFU1OVZtSndDMXhy?=
 =?utf-8?B?ektoK1AvTnRyemlqbmtDMzA4SlplZTlJWExhSENHQ0pIRUowNXkvY1lkS1Q2?=
 =?utf-8?B?SlRrOTRBSktOQkFCMUE2U2tqZ2FQR0dvc2ZVOEh3VHZBU3FsandMUHFUL3l0?=
 =?utf-8?B?SHpKU2R5YTBSTHh4a2dYYVNlczBycndlRVlrNnhwZ0FPTy9GTXlhRFpEYkp4?=
 =?utf-8?B?OU9PNVdLajJLakdFTmExYWhCSTZrTXhiZ3pJWWhsd0swNkxoekp2UUIxYkZR?=
 =?utf-8?B?L3BCRGRud0kyZWNiVzJKeG5YUk42L01Ob0tINUNDYnN4d1JGbjZ3eStYUWFW?=
 =?utf-8?B?OG9IRkZLV2ZMN0p1dHlGWGlWUEYwaGttaFZKeUQrSWduNmtydTV6R2p5eWZh?=
 =?utf-8?B?dHRmczE2WXdZLzV0OWFtdkZnK2YwZVJVOWs1TFdsWGhHcWZPZk9TczlXR1Jw?=
 =?utf-8?B?cDlQazlSNmMzbzFndGpXZXp5dXJYSG9xbDE4bDdNWlRsTnhadWVVdEZuOGZK?=
 =?utf-8?Q?NakciuirR10whZMFsCxmkqkZjoE4sk2R06HBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB4891.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkRBVExvcEhBb1BFUUhQeVh6dFR6WkJmMUZOQ1MxODhyZWpHTklGUzJLaERH?=
 =?utf-8?B?akhPRFRIK3BaN3lWVFF1d1lUaTRqRmkvbC8vSzB0WmlDUko4cGRKVTJhQUNq?=
 =?utf-8?B?YWF5WllyM0ZOMjJxaFhQdlU2TDFQdWoxd210aWZscDhUR3BpOW5hRklRU3B4?=
 =?utf-8?B?K1FvMXIwMWFQeFVZYm04SGl1VkVHNVJBdDhhOW1EL2QyRG02Y0pxdzVKelVV?=
 =?utf-8?B?c2twbmh1aTNKbVZJcFpsUWJ3K2UxTURKZUJKYnpVRTVLMlZISzFicHlSbkFO?=
 =?utf-8?B?dDNKN2hWWGp5UVVNVnRKSUNxaTg0TFcrckhhYUJzaXVpZGJRWlFXWDk0empo?=
 =?utf-8?B?TDhic08rRjdndUUvbXVJOG9QT3JmS3lybzlOWTh3NUV2SGhqcGJhNGJBZk9v?=
 =?utf-8?B?b29xTHpqa1RmNlI4bmJTZGhjQzRJVDRQaDVFUFBSY1U2ZXA1dHRUd0xOcjRC?=
 =?utf-8?B?eVhuMjdNVzczc2JLeGtOVjYzb2I4WWQ4elMyRGdXVEZkRERXeDh6WG9UMThZ?=
 =?utf-8?B?d0pMNHU3M1I5QkorbGxZS3lwa2NQNmhqdTJkRFgxNFBHTCtCZ2FzUk5yU0p6?=
 =?utf-8?B?RGw5UFRQWUdIVWVJQVdHbWxFLzl1a0R5VVNtT3Z3ZDgxaWtlZExUVjRqanRZ?=
 =?utf-8?B?REl5bDM0M08xaUM3TFhlam1DaStwOFdaNDU0SUFPaVVEOWo1Y05MQWlUaHhT?=
 =?utf-8?B?Rk0zOXkvYURJMUl1MnhUWjJHaWdaU0Jac2NwaHlMVFlUV0JRdHNWaTdyaE1R?=
 =?utf-8?B?ZlVYVko1VG9GRlpRUlVaMEhpT2JHcHUvQStwVWd0QTl4Q2dwSG1lbXZYbGdz?=
 =?utf-8?B?dmNpSzBST08yZEdhaFRuT0JLdDdoc3dxTTB3YWF4KzVLMXo4R1YvR2FzYXNl?=
 =?utf-8?B?VWR3MGNtQzlWcGJnNTlhcXYrbmFWUEdkeHZrODJXbWc5Y00rTVFMSUl4VlJD?=
 =?utf-8?B?MXRUcnlCdEoyZXM2NDh1KzYycnA0MmFtTGpwblhzOVJ4TDFEQTVET0llaVhn?=
 =?utf-8?B?MTFqRHptaWRkUFBtOGs5dkttcUt1cmo0akFPaGJCRlhxK2FDaWFSZk9nczc4?=
 =?utf-8?B?ZkVKKzI2cDlqM25YUlJuVU1pRlBTR0hHSXBRYjJzL2graGtKaytUSWgrVzVB?=
 =?utf-8?B?NUh1Nkt4STArMkNrK2RTKzJPeVdDVFVSZHNVOGtnakcyZ3Z3N21kdlN4VzEw?=
 =?utf-8?B?M1hBdEpPNTFrZE5rQ3VyV2E2SytZL3pEeEh0eHhFSXFSZ2h4UFk0QjQ3L2ha?=
 =?utf-8?B?UXBUYW5XMGJNQWhJNFRhVDlHcWhoMHpCZkxwYzJOaUwwV2ZEd3JEU0RDSW5X?=
 =?utf-8?B?RVRnZ1k3Vm0rWlRRSWVJcHRvS29zMU91Wk5zcW45U3h4SVlFWllNeU5Felgy?=
 =?utf-8?B?MCtVS251RmZlZm1lcnRMbUJhTVpwRWZBSHpzWGtjS3RHbjZGMFRqelJBcW1K?=
 =?utf-8?B?N0ZFMEpyd2tVY3h0RHR0aVhucExDUm5rWGViVnUwVWw2VlBtK1JQQVlvWU5P?=
 =?utf-8?B?eGQyS2g4OTA2NDRBMjhaUU5BdCt6WXJPeGswNW1BZEx5Y0U0emRKKzBvZUhX?=
 =?utf-8?B?dllVOUdMdCtJcCttUit5TTA0SmxyNDlCSFNjMm9rMGk3QVdhY0ZmN2RRVzFO?=
 =?utf-8?B?Wjdpek1vc2JYT3kvenp1OUFHZ2h2MWJicWJUQ1VFVXlPSDQyZllicWtQQmhl?=
 =?utf-8?B?Sk5EV3FXUURnOXdsVktzUmprUVpPOUVEMCtrNXBudllHNjdDbElTQjhjVXF2?=
 =?utf-8?B?UncxYkhtcWdGeTlBS2dxN2RUb0NVdmFaUHVvUVpoOE13S1JxODdoL3Y4QWJw?=
 =?utf-8?B?TS9WWEZxYmFSazFiYlhidERra0JwNy9kN1hDYndwT0xTNlJrTnNSd3FkVGVp?=
 =?utf-8?B?b0RZYVlqRkJvQXIzNXZZbXZQVUVYRjBpcWFJb0xCNy9LOFVHdjd0WkVPSnpO?=
 =?utf-8?B?c3ZYV0J2dVZRQnlsQWJTVWd0Ulovam1KUUlubEJOdlVBdVUyeVRBd0dZbm1i?=
 =?utf-8?B?QVpVaDZ0NEFhVHZEU3pQdEp1ZjM4ZEF1YmcyQXFiS0pZRnArUDcrejNKcFBt?=
 =?utf-8?B?bFdCUEtUYlNrRlRJbDUyVmpIWnYrQW9EcmdKaDU1Q01pQ1MvMklMbWlZOXg1?=
 =?utf-8?B?Y2ZCQjZPcXV2UHdaZVZab25tTWtqenRKUjZ6UXRmSkxQUG85QktVMkgyMGVj?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79126536-ceff-43d0-280a-08dc860f7695
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4891.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:00:15.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF3M+LWaBsONC82Ttl2K9VkdJgPBJ6CcvphAO/PBUbm7cIBy7iEsqn070r7NVjnU9pWFyQfQtVoLcDNDUmgWw6VU//xUDN8xTOJh5+X/w54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5433
Received-SPF: pass client-ip=2a01:111:f403:c401::3;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=SINPR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Jun 2024 11:29:14 -0400
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

        In the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide, the specification for the type2_compare_x_word_0 register is as follows:
        The byte stored in bits [23:16] is compared against the byte in the received frame from the selected offset+0, and the byte stored in bits [31:24] is compared against the byte in
        the received frame from the selected offset+1.

        However, there is an implementation error in the cadence_gem model in qemu：
        the byte stored in bits [31:24] is compared against the byte in the received frame from the selected offset+0

        Now, the error code is as follows:
        rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];

        and needs to be corrected to：
        rx_cmp = rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];

Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ec7bf562e5..9c73ded0d3 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -946,7 +946,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 break;
             }
 
-            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
+            rx_cmp = rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
             mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
             compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
 
-- 
2.37.0.windows.1


