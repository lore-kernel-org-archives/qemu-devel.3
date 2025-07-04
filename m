Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4478EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh80-0000rW-Nu; Fri, 04 Jul 2025 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7i-0000jY-Ec
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7g-0004fS-CS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:42 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564CWIIp020776;
 Fri, 4 Jul 2025 07:10:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jwOGQ7HAm25/lGhZ1Ub4PgLdheLV833Lf7acnvPZ5
 qU=; b=byIji8aZav9eirgG2u1OMrX9bqIetF5pGoZ7Mf9/cz+l5uiD1cY5GFoQq
 SJykZ5jUmyfnoGr/y98yJFO41WQHs9Mo96Pk63qO8mSTVMgmyiUlzR6xKFcemcnL
 Vx03LOwS+qOViriLM2dBSnqOCCwuSOb9OFKbCcz2XCf0NtnfKorU6H407UYwwNcI
 pWCiPebsrxJtDD7pIGppjJuif0dL3lcDJNioXUHQgno5YoCy05FkpyNfQqyLvneh
 CZIDASV983E/nsMDYmF1brcL3wCvz2GOSvAecjY2qQu+A02H2W+RYsU4Wtm9iERx
 7f2blSjvgDafiU0ZiR87niYMLkEvA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47p2epsrqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APufDK3aDojOW9fHmvo6wZJLh6WYmohhsnf0sNupBhIfjhVllATJTTZ7JAjbIbUBioeBJjWrffahzdOOCj5tgAA/8I1O8TOSmt1BboVqBhu3/xA3HcrSR3hzRVPjm0PzBVl0k7imfaGcXZfQAgHcb0uNljrpAJsWheaMEGzjB1VBVSjAebzLZ9Tb4dfsydVoyMzI9Nq5EvoMBXRXCKFX3JbPCy9JOJhE1Cy2K/rucaYY7Ry+5OfZ+wuwrxk49RsVpII2hh8MyTKEihoelW0bxd0nRrzbw2RMXoFfCyZdl8Z1TtWiaB9bIzhDcpFvITxDDrMIMfMlK5yyKkH4oogE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwOGQ7HAm25/lGhZ1Ub4PgLdheLV833Lf7acnvPZ5qU=;
 b=AzXrSKwaH5xZEuvwBhpCHynyeX3hn/+ivqffLt2hTL8BtG+TIuF36YkyTWDcKHELikMoC8KavXohI3ogizhhRGOE3/uDa9Y2aQVP698a4OoNqasaHJGm7Cp/rdd4qZOhjmrK7MXMaEPWYnBF1KyQv7CD//9gVYS3k0lwI2lZD1LvKDoCIgRMnaHabBypiCZU1+0OHvgqtZ8NmtTKPfWue2PcK8qixMmU6LOLknLgS6VCLrI0TSr9+fYDHOajhHcPwABi2R2zwGNok30YV8EXpAtg3UObiA5CKvROnu+s2drGF89JhuEIHKl8oKjLFkOG3j3FVs+rnWQEH9XYJYuZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwOGQ7HAm25/lGhZ1Ub4PgLdheLV833Lf7acnvPZ5qU=;
 b=QnO/WvH7g3MZdIuPqS3NdRwL5+tLPgS8AYd5gybsr7iXXtH+6mRd91DG4/zujvHMQk/z3RlozH8PPp/f4npI/Ya7iMzB8Cioj01Tp3xJ1GJDF1aNYPhRAuH4+m4ali4rWl8mVQd71MU0yi1Te3sz/zMw3aUERIR2u2h2y+RYyubdWqZQWZ2FBIgj7qmeAHgB9tOVJZVzVylsdnN0UyK7rLtOIXFiVYRS622o/49E67/WYY6fPDWUaOANMT+fX22eKlE5BFxyKBPrWzpeMiNYNE3ko4gxUgRrJFW5TiKxv1PqFwDNz0X4hHo1F/4uQ0by1H650KCxmHjLp7u7lwXzrw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8045.namprd02.prod.outlook.com (2603:10b6:408:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 14:10:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 04/14] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:31 +0100
Message-ID: <20250704141018.674268-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: aec9dc5a-cbe2-4725-0051-08ddbb048bd5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE41WFZ6eklZMEhVU0owYmt5eEVYQ3VVRjFrWVBsTzg1YTVYcHFCZWlMWmZM?=
 =?utf-8?B?L1RwaUNhbjhQUDM5ME5FcGhUc2pURGVXRUJlSUVxK2ZBN2pBdVB2R0tiei9Z?=
 =?utf-8?B?ZGVvVjFrU2RzVVB3bEJkR2xjLzRmbHV4YkQ3RURKakp5dTA1c2huZ0cvdC9h?=
 =?utf-8?B?bXFPZk1tVmVHM3pvMHo0ZWtCOEQzQkJFRS9RSExZVy9BVmkyS1dpdDVjU2Vl?=
 =?utf-8?B?ZGZSN3hQUEwyREFveGpWTkdpQmFJSHNuNTA5bHdMbzZ5WkNoWmFSdUhJT0Ft?=
 =?utf-8?B?TEVHZVlVM2NnSTYzbm9qVFdYV0ljR21SOEtXTjhkYno0b2ZxNE9yTjBGWGRB?=
 =?utf-8?B?TTN2Q0lqTEpPUGdJN2Mrcmxuek1neFpKOGwwbE9Qc2p4VzJXK3kwOHZuWlRj?=
 =?utf-8?B?Y05mT2d1Mi9pUHp6YVpIQVBtMEpUWENFMVJwTUNFa1BWelVYeEt5dVdHSVo5?=
 =?utf-8?B?bVVlaGFEcjU3S1VaRWYzS3UzSDFabWNBRWg2bTQrelh4R3AzVVFFUE90TFZJ?=
 =?utf-8?B?NWgxUWo5YUNqSC80dmF1MU9SOU1Bd0NvaEpyZjFESDhGQlRRZW41akttWEZz?=
 =?utf-8?B?NldITy9Kc3hnbUJXcVc1NktxZzRGaWR2K2x6KzE3WFdmeEUwZWN6eXlUMWhz?=
 =?utf-8?B?Ni9uYlkwT1VrUFErNWRkeUNySUhWayt2ZGNuL1lTRkVoV1lJWCtOUk03NGQ1?=
 =?utf-8?B?c1ZCMStnMW9vT2VHRzVmWm03SElPaVQ4bWI1a0ZHcFRKVDZvb29hSjV0cS9N?=
 =?utf-8?B?NkdURTAyV1MwS3k3QWtkd2xRakpuZ0lrODl3dUxTeU1UYWFHUWJjdG10YW83?=
 =?utf-8?B?WUZyUFlLZUhsQUlWblJXS0Z1dnZHY1UyZXo3N3ErRUc3eTM3T1JJbGZKdkly?=
 =?utf-8?B?YVlwbncvMzREQkducFcxN2I5bnlrS2dwWTdlTWtDNUhRZTFydlVveStxV0dn?=
 =?utf-8?B?dG1tczRrU2tmSVhNNDBWNVFwaHdIbU9hSmFCUXV0U3hwRVVnMUhFVVhMUVBD?=
 =?utf-8?B?ay9IeFVZRVFXS1IrZU94VktNVXA3bnFhcWxVSlFOenZ0MTI4R3NySzBSUHdp?=
 =?utf-8?B?QlNLWm1kVjJncU10YjBnakR4T2FZL0loM2J4S2dnOEhRUGlKZEM0VERkQzJN?=
 =?utf-8?B?SGVGbTJZZWRiSnJnZDZVUFNKQnplSlZFQm0ySHF5ZEZHU0FmcjFkeXBVV2tK?=
 =?utf-8?B?THZpNHhtNWNRUnBuRUVCb0JCK1BXclVWbDArbGMwZlFpcXhpakdjTkVYaDlC?=
 =?utf-8?B?RUE4WmZyVGttc0NaZ2hLa1NHL1FMR0FjS3VUZjU1WUZiTFdLSW9kMjhpQXk5?=
 =?utf-8?B?Q3RJQnJtczZDWkhQRE8zSjdhT0VmNHhTYXpiK21Ba3RUSmZUUlJEdlQwL1FI?=
 =?utf-8?B?S3ZCNHNROERHME55MzdkWmJhVE9CM2xkTmdaMjA5bzA5UWhQL0FrSzJ2a21J?=
 =?utf-8?B?a0c4dkNHaHpKbU8ya2VKRm1RcjdkZ3E0V2pkNGQzRkZRaFhDVFFDVHo3WEx0?=
 =?utf-8?B?Y1hsakQxbUZOdkE5T29SQUhJb3hyQmlMZUtYbEIvMWlObExRTU1GendETjBG?=
 =?utf-8?B?QzFDM1RDTlpvUHBONVVLZlZYbmJzUDgyWCswSjNBRmMyZWJSbk54NkZhS3Fv?=
 =?utf-8?B?K3A5dzB6aVo3b3Erak9MSzJkeGVwZU8vZ1Ixc0hvSmNKeWpKYmQwaVExaUMz?=
 =?utf-8?B?L3hjMjl3YTFFUFVONVJUQlJJc0VaUGRnQ0lXTmJ3UTJvakFTMGpxcVNvbzY4?=
 =?utf-8?B?cEpJRDBKcTJSdThycHBKWllDMUNWc21vUzJsNll5WUkxTU1uZEhDSDBkWXdT?=
 =?utf-8?B?YzZNeVQxclJYWnZlY0VKL2JFbG44ZXMzT04valRwSzBBWTZFcGFCYzNqbGJ0?=
 =?utf-8?B?enRUOTRybVo2VllyWFQ5bWpCWW5ONkt3K2dBbkpHeW1vd1FkbkhhdEFMcDky?=
 =?utf-8?Q?P0ZgdjbmCps=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dLeExoUlFnNnMvZ1A1Z2Z2Y0RTZzNzbVZRdTYrSDJyTFZTdWhLTS93Q2pq?=
 =?utf-8?B?NEF3YktEL0x3ZnFUSFRBdTc3L1JrS3IrS0owcTdVWmdKY3NSaXIvbDRRdzNa?=
 =?utf-8?B?VzdSVWQ1L0kxL2xVRGpyYUdublhqSnA5UkdIZlJTM1VwemVIanU0RmdVb1Jl?=
 =?utf-8?B?V2tEa00vN1BYcDZqWmZyUGQyNDNpUGNNZ2xLOEZLcFgwZnBMQzI4aG9iUCtN?=
 =?utf-8?B?NFpscGJHZjJjaFB3WS9OeEF2NXdJRjRQZTdBWFJrYWFtTE55QktLazE3bmJo?=
 =?utf-8?B?bGdYUitKWEJOYmUxN1JIUDI3eHBzbkszRzlBM01VVUlCdlBPeEVtMTFNRmMz?=
 =?utf-8?B?Z0xaSS9NbWtKa1pxL2Z4d0xMd3pjRVVqRVRQdk8yQ2ZpenlkbGQyUDdIV3Rt?=
 =?utf-8?B?SDIzVzB4NEo3Z2s4OC9Rb2IwaW1SVjhjVnVEUzFzYUZEaWtDVmt3cllJbHFi?=
 =?utf-8?B?TDlHb1BVZjF4bnp2YzlLVThINlZUNWpQRXRNcm55eDNiNEJPRUJVTzFTcldJ?=
 =?utf-8?B?Y1hrTk1UcE5aMkxYNEhRK1BwazNUQWdkODk2NlJpNFFWbTJGUTBBdVplQlcv?=
 =?utf-8?B?elpGZ1E3d2ZIbHgyN1lkQnhyT1ZlbWhhaktCU1NpMC9KcjBIS3NaYVIxWGt5?=
 =?utf-8?B?d0FBbVJCOVZxQktlcm9DYmtCSE0xbzI4U002UE44a1NoS284TkhaM0RZTk1q?=
 =?utf-8?B?RGl0anFqSFlBRGliR1lWMys1TkZaeW9LeXlRazM3UEdhOVhxeEZGYjJwM0w3?=
 =?utf-8?B?MXl3alJXYjJOOHQ3QXU5NDFSY3NMN2JtUERHZDlYVnVRZk1OMk9ldmdueDJr?=
 =?utf-8?B?TlRCNUttaHZic2MrMTdTME56djE2bUY3Z0xiOTNyMnFwTkx4U2hGbTlYZ0g2?=
 =?utf-8?B?NTQ4d0YybTcrOFlxVlhScHY1Mm10bkpWdzRudkZUYlFJckcwdjFRQzhpNUt4?=
 =?utf-8?B?aG4zMU1UZDlUNzdpdmJhSzlrUmcwWEs3QTRYS2UvZHcvMlBNSHA0cEJjUzYx?=
 =?utf-8?B?cWFUMmF4R040ZExLbDZUWVFqU2tjUlZtSUtnZjR3OXlTOUd1NG9VbW9XSXVs?=
 =?utf-8?B?T1dGNXFwZTN0amZ0TjZ4WmpEcm5wZDRDVXUyU0FsTHdXZU1iczdYdW5nNWdH?=
 =?utf-8?B?bXdQV2Q0WFR5cTFMc3Y4c09nRzZyU1dCcnlHU3NYUTlWOEtYaGJwbWJDZU96?=
 =?utf-8?B?VElyem92ZTE1N3FHUWYrbTZYQVRYWjVuS2hiTWdsay9vSWJRdVF3V1NLdCtr?=
 =?utf-8?B?NG05RE9pb1l0OXBWQkY0endWa0RubVA4ZXBHS3NLNUhYNURFZytOTk9nMndB?=
 =?utf-8?B?MHlnUFR3SnJ4L1hCNGxKRUlnb0dRazdoZGFqekJHYkczYkxpNFYvUHN6RU96?=
 =?utf-8?B?ZTF4WGFDOEZDZGZWbytPK1hqSmQzMzk0MUNwSHB5S3lNbHBrckxNTWpKcUV3?=
 =?utf-8?B?bm1lWWJkWmZVd1VjY0FOcXFXbTlJc0VRbzAyY2F3bDlVZURaaFNWQUJsQ1JN?=
 =?utf-8?B?RDM1c3h6NG1YWDUzTFhlcEo3eS9CUFAxTlJYTGg4MVEydnh5V0NKWDJUbmpU?=
 =?utf-8?B?UE51WXRKd054WWlRNEhlL3R5c2Y3R2UyQldpWURtdGRTOFo1WE1hdUgxbzhy?=
 =?utf-8?B?QkNjaisvY3RQaFdYVDNZYlZwU0tZdTgvdkF5ZTJnckxHN1pvYjRXeWVHTStH?=
 =?utf-8?B?UDBlTDVkWCtYU0luV0llR05DYzN5cmJrdnNMSkhSZndkcVRtUzJCbzZoNW9Y?=
 =?utf-8?B?ckpza2xROHI5a28rQzNxMitBc0kzQWxJQU16K2VIVWNYQU9IRFZMd0hwNWQv?=
 =?utf-8?B?am1iV2JycGI4cnJYaHc1OU9yc0ZjQ3ZzTHRnUFp1K1lIc3BXRURYeTZmdDUx?=
 =?utf-8?B?MjVaTW9qbDVDSEZmdmhZTzdTTWRhZ1gyd1o2WFBLekRwQ2V1Nm9wYnFxYlBF?=
 =?utf-8?B?K2FoVTZHc2Q3ZGVkcndlUmlla1BsRXZHUmdwUjBYUlNQb0NKUkRyTFBaRmlP?=
 =?utf-8?B?aFE5SmxZWWNUSG91Ykh0cEs4YTJKa3U3MkwzdW1Lc1l2Y0hCMm5NbzJRMWRV?=
 =?utf-8?B?R2tvcEJ2OEVOQ1JTME1PSXY0amNubUVKWlR6M3hPeHNrcktEcE05bEI4bVZk?=
 =?utf-8?B?K1FkU3l4aEQvQ0ZGeGV0R0plR1RyUmk0ZXRySjlKdGd0eW1QU09naEkzTTRZ?=
 =?utf-8?B?RkJLNmppMDdtalExSXRzVnMvVVhZRVJUWWVGYlJ4dldSSDRPMkhuK1JmSkpi?=
 =?utf-8?B?NXdqV0xITERKSXNneFdRaXB1SkV3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec9dc5a-cbe2-4725-0051-08ddbb048bd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:35.7549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR/Pc21jeUCHKjc8ULhxcHaFY8jiE/WWT9ouDA1iHWwpRpAq8CsRt1g3yEa1CZKsEZqxybQcBWHMqcuYqEdQOc5ee8DfSSzbJSzPMWKgDA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8045
X-Authority-Analysis: v=2.4 cv=NozRc9dJ c=1 sm=1 tr=0 ts=6867e0dd cx=c_pps
 a=PPhwdAdCFl3D9wfqO/a9tA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=F9lpminiuFHZMRiaUDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: O-eTorcFoDKhycviHA1JmF9S_xVdWmrT
X-Proofpoint-GUID: O-eTorcFoDKhycviHA1JmF9S_xVdWmrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX8DFEnJqxDubu
 UkEVWtV/66sofq6jcFGAsztwk2pr5OOVaiS/4aSClTyb8kG8aby9/0dm/saExc/PVtvjWvLrZRC
 n6ZYux9XIt9/25h6T+KHqiDx6xTX9pn7rmMzhbp10J9//LBPftdiC131EwFt6uuAZ9BCPRTlDEO
 bg7G29LLXbBcUauZlcdA2g+ubTkCQYkyLAm7+GX/fv2hdpB5nVRkGo+P6JJTcgrRClKdS0YlCc4
 hnUzG4ThZqY1X9MtMVrf2kZUglnsUrUz3YsyrHMXWa+JrTtynx1DN6yWv+hjiRLv/M86SOEcOiL
 3PdPFm7tfYGv/F8R25KgvAOei/DDNSLIGdw17OE9RAk9cO6LjJJIq95Q0UlGG/+loNktC1S9mWJ
 OK4McsMGmRcyjHGwY5r1oQWbdPEH3uHCtsIouvWXja44hh8/QIaLOuaWyDFNyiTBpUTdpeNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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
index 5d59cbde09..baaf744edb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -424,8 +424,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -579,23 +577,6 @@ static void pc_init_isa(MachineState *machine)
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


