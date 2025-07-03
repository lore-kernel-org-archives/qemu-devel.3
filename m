Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054A6C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXL9U-0003Bo-O2; Thu, 03 Jul 2025 10:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9S-0003BI-Sr; Thu, 03 Jul 2025 10:43:02 -0400
Received: from mail-bn8nam11on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60a]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXL9Q-0004DF-0F; Thu, 03 Jul 2025 10:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHFdReBYJfaLOwXTg/KwXAuI/w88KN3qlLkyEwkMfxIxJqBgnCpwkMfzwFAvUSj7vaOPmVJw5O51uRYuWIcV3fKH55tJxJ2Ti6l3I5WXQ4X91cIkQtLMsEeDTUVuWGfXezQqtulJD7CKsdHnPbhr4O8LM12OTcAEF1QIMS/0neQTdOq3+JtGuSN9ltxEHu8hKmC9RsOcChOsTC6DB57fJEDzJi06aWQAsj8W9UorptoSk/6TCjQZWupcSo5u+Vq5/DzAwYfYvye3KFns/VPg3WOp6dKgAP0wPa4ysI6P5cJTWT78dDKBtEhVWx8eVEdw1f6nQMR/CNZql6HfF4hEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx4cSoqXDpdBqEfhYlImKuh1cXRJw76WpuK2PeLnSvI=;
 b=y0iHFt/gtK4ZPcMpXVUgc2ERDpbOsI/DgajpK0A6ZfwU/zKI6horb513ZQWpEAjj0gNX20RyEqDBpKhmZ3+BJXRDMwEmJhTYSjDHJiNDXMInBEeuerSjBGsbIJ31EaEkdcc/os4drFp/Cb47+OqeSEX8H/vmbU8qi+W+o7rlOmQsnfOxnyHAnwn29tU/NTE/kOOFNVgpAse8E+oD9gSdp3Td2ChK4Og5Rpbv+5a7qEKWUNgQleym0YEQGSq6+F4IksOAvz+vFjGYX6tqZ5TtRF7HNujwetTmVY7EY+NfHqB5SZbgYByedOQFM3DEE912ajbvhol+xo6u1IEjOIEtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx4cSoqXDpdBqEfhYlImKuh1cXRJw76WpuK2PeLnSvI=;
 b=bsDdyF4TgFbOHwicficbdLNezg/pkwUFtrHCh9mB5EKrPrQrTTf7bdfCixu7XO1DKuyqS9Xpuv2np4RTqVOM8GB2vN2StBQB0hVnAWybJgfYOkOHV8SO1OPt17bSoWkDxpr6PZr7UFxPpBozhhkopFYmh2F3DOWkyDDqgcDRXElPMKvorXANgL9ZlGhXOxvKF3MRGmbisO/6WSic9LkKa3U2keNhX134GFlJmOJFn+sgvDupQnGSzTYdekfmvCDqIi2zEJIb0qdUMd+EWgdNATaSDXgUBNzMGdhBCF6w/6JtPymwmWYMQGVp1Xwa6ePBWY7y3huerWapajhY7hPCGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 14:42:51 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 14:42:51 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Tanous <etanous@nvidia.com>
Subject: [PATCH v2 0/4] Add support for gb200-bmc machine
Date: Thu,  3 Jul 2025 07:42:45 -0700
Message-ID: <20250703144249.3348879-1-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 339fa4d3-5118-4fd2-2a46-08ddba3fe320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2NMbW5JTStyM2FaaTV3RmljVHhwMGsvRmJvNDF3b1ZDalNXUFh0ejFJbFNZ?=
 =?utf-8?B?SkZOT1FOdkZ4b2NBeU10VFdOZENrVDhoOFJPcFZNSTRDbndFQnNyd3hnL3ZI?=
 =?utf-8?B?bnJBb0VmZ2NmRDJzSGV4TG1xRVVYb1F3RjdZK25TaUtRbDZDVXJucVZwN1Zo?=
 =?utf-8?B?QitralpQd3J1T2orbU00bmlHUDJHUWt1anBIRWNIQTFWQ1dmTTJDZjZNbUky?=
 =?utf-8?B?ckdpQy81ZXh0ZGhYQnl4Q1FCVk9zQWRZMks1Q1VsZVN2UkFoRTFEWGpYUkJI?=
 =?utf-8?B?RnBGOHBtSlMvUFpYSW0xa2Y4RlhONmtGUTZqWFoyM3J6QnJWZzZhZTNOTjhu?=
 =?utf-8?B?MjkzOEVUUWsxbUdvR1h2Sk5rcUJPaXlqRitKMTVpeHVGam8zd0d1ajc1Y2ZC?=
 =?utf-8?B?UWlBTVRtTHBlam81VGNYRUFMcGE1K1M4SXVpcVFuTmp5Zi9yQjNKdW5jMnVo?=
 =?utf-8?B?ZTBoTTFnNmFrNDVlTEpsaUZIV3pNQ1BFU1pKWXgyc2lxVEgxV0w2ZHhyMG1h?=
 =?utf-8?B?d2hzRkdPOTJVbVEwbG9yRDJ0UytwdW5TY1Z2WWdWY2ppYzBxWE5Tc1l0VWow?=
 =?utf-8?B?MFBnc25hUnlleVVhdy9Xcy84NU0zVXlkKzRmTGd2a0lidU9PTkVKQTFPaUtI?=
 =?utf-8?B?bTFWSGlSL3g1eDhodUtCMndzazJZblUwd1pXSFVESEtIdFhsM3d0UmRJQk94?=
 =?utf-8?B?ekZ6OVFxc2JPSHF6K0NLUFdnek1VQmlGWUlLWlVGUk9sMy9uTXpvWGQ3MlNF?=
 =?utf-8?B?QUxrWUVid0x5SWNMNlFFc0xaQm5aQ0lVMlczNFdOQlozTmpvQ0pTTCtvWHZ3?=
 =?utf-8?B?NjQzbXNwOUU1ZXJIZmE5Wlh2a3ZZME9Xd1A5Z2NiQm14U2tva2VpcXFrL1hB?=
 =?utf-8?B?blFDZFpSYjNVYlR6WDFJSnBnVlp2c2hvSlhOc0FjTWpDSUZpMStQOVlaNjlp?=
 =?utf-8?B?Z2w1RFp4V1QyMXNMNHU5ZFdxVjdoc2FQQ1NybTJ1S05iUGNoZnJ1MStzUk11?=
 =?utf-8?B?OVRST2NDOVJ3MElkRWp1SEtRQVl2bmhZcDQ4WHp2SnI1SExIczRzWUZDYlFC?=
 =?utf-8?B?SlJYRVloOXJ0QkhIdWhiRUUwTVg5MFI1MnJwc3ZzVjNrU1RCU1FlbDE0SGRk?=
 =?utf-8?B?S1lJbkpOanAvdGRUdEpzRlBySTFlYldobmFLY3FBVDdlK1UzVERCMlR6S2ZO?=
 =?utf-8?B?TGd5dVB4dXpBUlJ4ZE53cGpaTVFvYUxYZFpaWFBBa2dqcnUwdTMrblpyN2dW?=
 =?utf-8?B?aTA5ajM2N3hoRWlWakxnS0Z2ZllWZGVWU0lPZ3NFQlBSbEptVmZaUmZjcHdl?=
 =?utf-8?B?SXRJR2w0K21OWDN5NkNTYkc5cXVwSlVORDlUY2VjUE1qcmFCbXdRQUhCQzB1?=
 =?utf-8?B?SURDeS9JT25QTWhaYWlDS1lRVlZXTGlMd1pBRDZSNmtuSFdhM1FsWTMydXdp?=
 =?utf-8?B?bXM5N2xyYlc2SHVJY0dWSW4xV1Z1ZnYwMGNDUjFJeC9DQlA5bWdiTTJaSTJV?=
 =?utf-8?B?V2gxaEJPeXpSRVpUNG9PNUJsQ1Z6TXdSU2dYL3ByUUMveEVoYnY2NjFuVlgz?=
 =?utf-8?B?M0RON2lHTUVmRUJPUTZOZGQ1RXhLWjgrR3ZUUU9zMGdsL2Q2cG1LSUh6OXBX?=
 =?utf-8?B?ajRHd3V0aGorYlpkTTA4dnpOTk9PUjdnc2JRU29yajEwZW9ta2RZa3NGL2Fy?=
 =?utf-8?B?N1ovN3RzUWRaSzlwZjZpV1cxU245dTJJektvYndwZ1ZsOEdRTVhHZ0t5Wjhy?=
 =?utf-8?B?NWF3RnQvTk5PaHJzSVpLa2ZGcFRIM3hpNW1kUS9HdlNtdndVdCsvRlZiR3dT?=
 =?utf-8?B?UFl0Nkc4ak9SbGswM09XSkQwMTM5emFtaUFQdlIyUzQxcWxNb0Jva0NncURw?=
 =?utf-8?B?VndsNW92R0Q0R1FWeUNuRzB1OStWdndYSzlOTkRyazhPTGNIWGFGSzd1Tldz?=
 =?utf-8?Q?wVMq+C1LD8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9CNG5zdHpLbm8xcmRFVlFNd1Ewa0RDeGZXMXJCVWFMVWo2enBweXlKQUZC?=
 =?utf-8?B?cVFLL0lBL2VHTWxCaWY0WEwvajlrNXI5Z0hRUzhKSHlIaFhoTzJJa0YyNlF6?=
 =?utf-8?B?N2pDUnI0cGlLV09zQ2tjdndRRUFpc1JaM3hPZzcwR0hHdFZNMlgveFRBaEhR?=
 =?utf-8?B?ZVVLanR3REFPa29UQ0liMkRQaTNYbk5nc1Rod2hoV0duQkVLb3BYczJKZ01z?=
 =?utf-8?B?WWcxMEhpK2xTdmFSYjBHVUJPTW1iVTBhRDVlWmtaVjNRT0ZoMmJXK3FnSmIz?=
 =?utf-8?B?TytSekRQenVCUldmamtoZVVNU2JQc1hxVGlXZmx2NnVlVC9oZUgySDJIMXc3?=
 =?utf-8?B?S2lmc1lKWWRnbDA2L05Oa3R5eTNiSWtuR0dFRVBhZ3N6TFdXWC9YQ0NrdDZ2?=
 =?utf-8?B?R1dOYm1ic1JHSU5YYjk4SzJha0lYdFQ2a0RMVGpNZ3l4ZWRlOU0zdFNwOE9O?=
 =?utf-8?B?WmtKMkxkTUUySGFmYjRtSCs2MWh4OUVOYkcyVkY3ZzZ5Q0gvZEZSVDQ5R3dC?=
 =?utf-8?B?T3p2dGZvYzFSS1Q1dEc3djZxWmFjSGdRdG5lODYyRUU2VzVENEYwdm9RUC9D?=
 =?utf-8?B?b2w1c1JZd3RwVzUrREtVVlhKMWhhYWY2NGtrTW14T3c3TG5XVVUxbXQvbFJ5?=
 =?utf-8?B?NlgwSDMvSXArc3dLTWRuMWd6MFgxWmpQaldNdnNNSGxTWm9oZnFRN1Bna291?=
 =?utf-8?B?enF6SW9WdnVKbVBIMWNCUjJxM1pzOWJFQUFvaHBWZy94WVlxaThrdWdpem4y?=
 =?utf-8?B?dVB0d0E1eGtFMHFiajNybWgxKzJ4MzZubVpZS05ueGE0Z3A3T3pYanlDb3FE?=
 =?utf-8?B?VkVEd1BzbzZISG80Ti8xbTAyelIwM1I5bEt2dGVxeVFPTEZtUUhOZzdvbysw?=
 =?utf-8?B?Z083SFNwTFd0U0dtVExwbkZiRkJKRERoOE9JVWlUeS9lamRxMHk0dGthV1hJ?=
 =?utf-8?B?STZFeFFiQnhRRUFIU1A0TUxhQjVtczJXMzBNa1hvbnFKOXBBVXNQNlNEZ1lC?=
 =?utf-8?B?UlhTSFVXUDUxY2Q1dXFFTVlZN2R6bFMvMVA1M2pJeEoyWVNyZUN2NWZ3WFR3?=
 =?utf-8?B?Z0hzT1VvVitDREZVbE5uV1dZMWw4TTUwRkdnYkU4TmFrQ2JBakcyNnZUbTlN?=
 =?utf-8?B?OXJGNzdIdlRoaGN0U1lKbXVFNmhJeDB2ZkNrZ0xWUEt0SUxHcDZFVDVTN2l2?=
 =?utf-8?B?a0EwdWk2SFdxVUVoeWc1MTlXNjVNRHUyKzJhV2pKcVdWZkFnSmEvNHRUWVBG?=
 =?utf-8?B?MHQ5ejBJbk9Ja2lYMWFkZDlVVUZSMnlIT1VqbkwxeUdBS21KbHBUMURtOHYz?=
 =?utf-8?B?S0JENmcyd2dZUE1Sb0NoVml0S0lROTVzREM2dnFqRWxuTXlXQ3hJbHpoOXZV?=
 =?utf-8?B?VVJHa28yNkdnQ3RVV3prN05qNzBsOHZpZUVYQ3Y1ejc2Nzk1eDRKRHVlb1F3?=
 =?utf-8?B?VUQvZTg4U1lKdTh0QU9BSDlEWDVhb2pIUDVXaE1jYzkyL3BiaS9ySWpXUkJr?=
 =?utf-8?B?aWlJNmpVdys5QWtQdk5zRkxybFpWUm0zVmJkbFNuRzVsRnp0MG04QlNib0Ri?=
 =?utf-8?B?U2pERlZpVDdQV2Fsak5pM082UnFNd0p5UHZiYnZBYmtFd25qMHNQaHNQdEw5?=
 =?utf-8?B?c0JqMWF5TmYxOHA1OVVWRDlFR01ZeXIwZVI1OHJjd0NHNk1xemdQaVhKOVg1?=
 =?utf-8?B?ek85VzN3amR1MERoQ25yakFKYXA3ZzBUV3lZbjZSNG5hSGQyYUhudHVuMXpW?=
 =?utf-8?B?NUl0NlR4Um9IUlZRSTNCeExtR2tTSE5UVE12YUVHeDRMbmlNVDArRmlORllK?=
 =?utf-8?B?L3RjenpXVFV5NytjSEZoRnFlcFhobUxZczVxVEFqSnlpWTEwVGJ1aC8wMjIz?=
 =?utf-8?B?NmdWUlJWQXA2RHc0SFdCaVpVTENVN0puZ0w1cklxMFQ1U1RMV1FTakRUeTJ4?=
 =?utf-8?B?cDlXbEdvNlEyN3ZEYU1EbEZ0UDcwTG1rWUVmQVdSb290NmtqdEhvQmdkZmlB?=
 =?utf-8?B?UU5mQkdLM29rL0ZKMGFGTWxwUWgrSW9Za01zTHlJdGhjcjBhblUvdlJNT2ph?=
 =?utf-8?B?eGJ2OFlYdHFEQkpxdmVHSHFkbzlHKys2NmQ5enBNM29lYTEyekN1YmJwZnJC?=
 =?utf-8?Q?3Ox5pvn8M0sH7M9xyWrw+rs/w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339fa4d3-5118-4fd2-2a46-08ddba3fe320
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:42:51.5202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEYptnwO9lpofS0fiF6A7J5MHme4nh2nTyQptJdSi2+U5ZexNIHp6que9v5VGzcAlKsmiXdc9tBg2sJaxpVB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
Received-SPF: permerror client-ip=2a01:111:f403:2414::60a;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds support for gb200-bmc, a baseboard management controller
module based on an Aspeed 2600 SOC.

v2:
- Rebase on master
- Drop duplicated patch for enabling PCA954X
- Updated commit message with source information
- Added functional tests and example openbmc image

Ed Tanous (4):
  hw/arm/aspeed: Add second SPI chip to Aspeed model
  docs: add support for gb200-bmc
  hw/arm/aspeed: Add GB200 BMC target
  tests/functional: Add gb200 tests

 docs/system/arm/aspeed.rst                    |  4 +-
 hw/arm/aspeed.c                               | 81 +++++++++++++++++++
 hw/arm/aspeed_eeprom.c                        | 21 +++++
 hw/arm/aspeed_eeprom.h                        |  3 +
 include/hw/arm/aspeed.h                       |  2 +
 tests/functional/aspeed.py                    |  9 ++-
 tests/functional/meson.build                  |  2 +
 .../test_arm_aspeed_gb200nvl_bmc.py           | 26 ++++++
 8 files changed, 144 insertions(+), 4 deletions(-)
 create mode 100755 tests/functional/test_arm_aspeed_gb200nvl_bmc.py

-- 
2.43.0


