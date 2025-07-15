Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03692C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbS-0004Z5-QD; Tue, 15 Jul 2025 01:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbM-0004S5-6G
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbE-0005kM-Ru
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:12 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIJDoT017405;
 Mon, 14 Jul 2025 22:53:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BgM/wEYY7v3KNm+iON0ySMM0cj3s8PbjuudkqoSzx
 7E=; b=sqrH8rJISsXAZUYCfDZU4cBlNMeM5HYqo1go/Hi1bK2+EaO/83ycn3Ate
 q2hHRib1k8/bke1P9TMiGBMsS9y0bM9x9AlaHZTxE+fndi0PP0KEyaQUmJuKrRuN
 ze7k28Rgl6c8u3ORBrE3iCz25XYQTGhdXtwqWZMHP8RdYSKR20My54fUvcLLI5wk
 qUaRKuHhEMZ6bU2frPeC3W5TFtS6Umbx1XgGVjdJ/DOO/KuFtZlmpBWIe02KqGY2
 S/oKp9NQoSgss2K+vfHqnlCe9nwXFIL8crZHjzBZMrcfubHF1T6uD7Bj4xgX3wbH
 kZJqAPWEmqVUgqju6MbzfSwfGkjVA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2134.outbound.protection.outlook.com [40.107.236.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81d9qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q75ZdwtP1tqnwDmen5xb0DhnKyRWYuWpDMzy9OPuWVIsW9MQwb1X1zoxs6Ads8liZxgCoiSlL/PdbvCGoKMSHy7Xv2B6SHPOJ88NMUtIgvYoFTuUimkHiLoQlqKAhMwjEFqkcYedk/0A06y3c7r5u1O+j4IuczV86tHQK3ZYjNVHjtCUmzMgkj7u6wx1ooN0HVFkSTkrmmbK1Uj/aVI6gIAfIUoyJHkokf507KoGO/KptmogFQJKTQoqmKxxLw2OGJIC6V6q8uLStL56Yh+rXd3lJEVUyhQMSR8IQEySE9BSOIhf9YSbq9U9hi5U9GvDpkSeJltp6ilJUCzMYTSf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgM/wEYY7v3KNm+iON0ySMM0cj3s8PbjuudkqoSzx7E=;
 b=c4IqoMCdNnegqwWn6mkWHLVlBFB7z52Shce9+nyw/t00hl77gaDZGUkqXnQXEIZw9B9xFfcnea/1sM5FIVJAPPAGjj9UbpVRWKx3IQc43NGCeUdFu7YLS4J3hPLzZB7btRtEkWle7DX6I+SIqEa25XZ5fsd8JLu+EE9XjFJPebxUv6wranseJ4dthLOySyvSTVgk5vtjiewXmK+0M7pMhnxcEMZgNmaOZ+ua61LCezXyh3zuhmLnD5hTG6YKzmUq8Gnxg/hHryqoxaOPmpfWtKQ8kaZyPUpNBABhmA0QRA0FQH1CE9tQsdKdUYN2d1LEG/9uUya3Dgv17jMKtWOHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgM/wEYY7v3KNm+iON0ySMM0cj3s8PbjuudkqoSzx7E=;
 b=iYRSaw3UyIVJCXsKEDlE1lL84gevP3w0GPEagTknKSoQRJ1bXJT0yQ1Z+RCv8yoj8n4nDAeaDYmGlJPuD/hT6T82n70KlNg+YJ8NIhckmkj8vMQk4Ow4XLhhXG+hJM0/nK3XQi+Xkm6+lwCIxlDEEDqqpEqx0MPeXFaH/ZlN9tt5g6p/GKQaMGv97BQ14Yx/HCqjV9/Ps9lOVhMxTlVQ+0WwW1+yeSCui4BnEnvqCgiKcmfR/+XL2gLhdqilOUX7cGD9cn5XJ28x3vdu2cjXybaDO1DmWOnrd9nOIHmJdFTswiY741F4J9mtI8l4+e64Jph4Vke1d5ScJEjU8T9TvA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8841.namprd02.prod.outlook.com (2603:10b6:510:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:53:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:53:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 4/4] hw/vfio-user: fix use of uninitialized variable
Date: Tue, 15 Jul 2025 07:52:46 +0200
Message-ID: <20250715055246.422834-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715055246.422834-1-john.levon@nutanix.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 013edc05-55e3-4906-869f-08ddc363dd48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1dwVkVmMFNLamJCNTI2ckNpeldSN3JwZ2tMS1FNcWRFVFZTVEtBSW01QlJ1?=
 =?utf-8?B?ZW9NWkJ6NFkrMGR1OEQ3OFErU3BCNHhqZ2J2NENKMVV3Z3JUVGM0bSsxYXp1?=
 =?utf-8?B?ckt2UnJld2ZMMXUyMWhHc3VScDdONWFva1VpNlBRQjZ3OFNwdUprSFBxcnlL?=
 =?utf-8?B?VWFJZ1d0blk0MHdJdGJUNkp4SFpJdzVmQThEUTFQM09lTThyZUlDMTlnSC96?=
 =?utf-8?B?MGJpKzZJcnpSV3E2QWp1U0h3VGNQSitweEhwNm9yZUpTUjlwdXpYU0NHVGwr?=
 =?utf-8?B?QzNFOEhJYTlGZjdENTJzSUwxdDZLcklqaFdGbTZTaUswRFAwM1hiUERpK1F3?=
 =?utf-8?B?SDlvbGJ3eDJ2YjYvWllHbVVoWkpWaGltdGs1OVVyb3lGblh1WkFISVQvWXFP?=
 =?utf-8?B?aDVoR2ZiSHpYTkRCbCtzeVRHclpxVUpyQllsRGJrZWtDZUVLR2Y4WEZ0TnJQ?=
 =?utf-8?B?bGVxa2dsUWVyWlFpYS9OYVlzSGxyRmZIcnBSZCs3MDgzdkFtZmh0TVBMQjNY?=
 =?utf-8?B?b3FEd2FucEQ1TkcxOFZsQkhjY3M1S0taWXJjSDZlRFJnQXBPdGZ5UXBRclJx?=
 =?utf-8?B?MkczbTk5dWszcGZLYkFYWGFJMDdXQjU2OHR3Q0dmNVlodkU0VnRhWElicFB4?=
 =?utf-8?B?NnRiWUJMNjlQNlBXeXZ3MjdlNVVRT2gzMGlhK3BndkcwNGJTdlVGWWsyVHZp?=
 =?utf-8?B?RVJNMkJhazZMb0Y4UVFwL2FzSGN1VEJ0UW82V2hVN2NiNUFLRGo0R3hvQ0lU?=
 =?utf-8?B?RVlaSS9XN2tvR092TzI0bCtkdER3K2UvTDlOTFIyN3BvME1HUXNSUFJGcXFj?=
 =?utf-8?B?SExMYkxlUENUQU1GWDRXUkxCTTZSNE5Yb0E5bE5WRFBRNEhaczQ4WmNja0xR?=
 =?utf-8?B?ZFBiSnI4WmR5eTFkSlAxUFhQZzY0Kzd2cjA0VTZ4SnE1NmZLck1lSk50RGhD?=
 =?utf-8?B?U1BGVXY3cFZyUjFtdC95cE1KYkxMZndQRXlKZWpsUzg0UzM0WlcwczAvQWdx?=
 =?utf-8?B?cEhwYzgxYVgyMG5PRFRCNDNmWWJPejhNN2xqNGtnK0d5anJsR2lGckJjSGtx?=
 =?utf-8?B?VTZMZmxOMjFqUkwwOWo1dlpzVkNzRm5XWjJndlcxak54aE9UZFBKMXpwSnE1?=
 =?utf-8?B?MDcxZlFDSi9heS9WcmEwNUc5VENxQ21GTnFTdkN4ZVlIRzhZTUIxWjNkYjJR?=
 =?utf-8?B?aWg1ZGZnYkJCZ1ZMdEVsZ25TSnc2dE0zcFpCc1ZOUmZ0Ri9HbWljVkFRZ1A2?=
 =?utf-8?B?U3Y0TUpvd0Vac0dWWXBtM2FnKzhMSmhuN0E1MHEralUvWnloSTdNSm9IU2xR?=
 =?utf-8?B?WUllQXhSWnBIVURTZmF0SkRvS3owWEtLUS9YZlNOcXBZRWN4Z2ZIUDJsZTB3?=
 =?utf-8?B?QllKdldhUmRMcnFmLzBmbFF6YmhaREtDcldEdk5OSGE1UFI2eXRKQUxzSlVF?=
 =?utf-8?B?SUNCMjU3cXZPN2dzSHQ0RDhsM2Y5ZjVwcExkQ1d6dmJFamxjWXUrcmFJNmlm?=
 =?utf-8?B?dmFQUVVMck9XYnkxMXE5UExLQVVpZFZmbnl2YWlDbzVTdzI4MXBPcmdZQ0tj?=
 =?utf-8?B?c2xtQzROcnVUeXl1ZmdNb09BZWlhblVER1VtYXByeFlyaXR4WmRXSE5WTFZG?=
 =?utf-8?B?eElIejgzdVlic2ZraWQzNE5ydHpMaWxGVEZxTUNTU1lRNEp4WU8xbHpHYUo0?=
 =?utf-8?B?UE5qQXlsaERidHJTeDA1NUh1SVZrTUtkbmRBV3lhN2J3SExhL3ZIcmJJOTVt?=
 =?utf-8?B?b1hJbFpvRVhrN0FYeW9jTTJ2NDNhaFpybU5sZDFka09MQlZJcXJacHVTWDJx?=
 =?utf-8?B?VUlTYTZBVGc5dmltMnNnbW5UM2RGYzBpWHFMQWtrc2lHeGVqZ1d5WW82NDhI?=
 =?utf-8?B?MmZxaWF0cndMOEt6dkNBNHFOemtiMjJXODhaRU5BcGV6UFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkViMHFrTmF3VUtDR2tEZzN3N2U0UkIxampjQWEzWktDeEI1RWtFZ0gyMTdX?=
 =?utf-8?B?bEx1QVAydDdjN0g0aEZUMGZ2Q3NTVEdYdjdPcjByUGkrZVdBUlBoYVlxOUJD?=
 =?utf-8?B?MGhxdnZTeDdSZFJVYWpMRklWUm1mMUFaSmY0VEN3TFcvZndVcUkwQVFHZlVl?=
 =?utf-8?B?RDQ1VmorR1NVOGNKVW5VQ3Q5STRqa0VDWkVHWUZDdFBQTVlCekFqdzFDRnlq?=
 =?utf-8?B?VFRBRjA3OXd3cncyQjdWTExpcEYyWGZhd0U4Tys3UjVqVHpUbnBna2Iwc0dz?=
 =?utf-8?B?NjdPOGJEZ0YzWVBwYVFxUWhBaXhLNDBVMjd3VG5GRzZCRkRWNVhYdEhhZnBk?=
 =?utf-8?B?b2xGZTBNc2hQVDBBVEFPdkNldTNsR1U0b29oaVNhOFVFSEFCaU1CMU1VYWpD?=
 =?utf-8?B?eVY2cUkwOHQvcjk3Q0VUYmhHRGRmcTl3QzFmdXc1d0VQaDB3ejIvZGlZRTBj?=
 =?utf-8?B?SGd5UnlXQXBEUnB4Q3dyQkNKMFhPZXNPT0c0Vy94aytmR3Y4cXFrN2pkd28x?=
 =?utf-8?B?Z2d2cDVSa0t6d1ZpYVJheUptZGF3c1paWWpKUEo2VjdPL0F2anZnTVUvQTlu?=
 =?utf-8?B?dkZvVXRXclRVZERFVEtjK1MvYjBiVW5PSjRrTWpCNGZiUjlpWXZsSmhaa085?=
 =?utf-8?B?NFQ0aTRZUzc4TjZHNHNicEo1amtJMzA2bzdqdVpUVlc4VlJNUG9YZlA0cTJp?=
 =?utf-8?B?ZG90MHdCUFdyZVVkdStLalFoUzN0YjA0aTNCVER4SUxSVzMrbzI3ODhzb2t2?=
 =?utf-8?B?NWJJUUlWSDhaQk5xVTNOSU4rQmlzckRucklaZ3E3M1hwTisyb2R0RW5VckV1?=
 =?utf-8?B?c2RpNnZ3aVRSTG50TytmUWtXMHg5cU9nWk5NTWlqYjFTKzFmK3VqSW1CZnBt?=
 =?utf-8?B?Z24zMFlKOHFDSm5jdWtpcDRuWHU4TVVqRzZ2K3RRUW1ZNVZJeElVQVhhTTZ5?=
 =?utf-8?B?Z2p2SGZOYWRFL1hQc0JzVWxqRnlUS1hmMERPd045NTRqVUFpQTVBZFh2S0ww?=
 =?utf-8?B?Z1pJYVdHa1hyVHRYNnlPaFpGdFd2a21taHFBblpuN01KTlhpTVV5dE8yTkNS?=
 =?utf-8?B?dDExbFJyS3RqV1p2Zm9EbXdMNGFmUFpGbU1QUm5WK1BoNDRJV3FWK3FTRHpK?=
 =?utf-8?B?QzVjRlgyZGhYOEQyUlBhY2ZNRm1JenJNeWNMcUJHVS9uanJiNHJ1NTlrQTBE?=
 =?utf-8?B?TTJhaXZ5RFRSL0pDWTZIOHlNbStmdjM2a1cvYkV2TGpYTFUrSlpTZ01uT0lt?=
 =?utf-8?B?UFdkdkpOL2tTUFhGY1pzWXk4d0R5UEwvUFNaMjhlVnMrcml5SEtpcnFVL2sz?=
 =?utf-8?B?WkpHL1B6aG5yTjNQK1RpMFpEeGpYcHdVUTkzQVFjN2MzQ1RYWWRORVRzVU9Y?=
 =?utf-8?B?YVVnVEt0LzBrL0NRYTBoVU96bG1pTkF3K1BYL3pVMisydmNGSlE1MUZVZmFO?=
 =?utf-8?B?RWJSZEdKQkxmTC8zYU1qRFNBQXhHeGFTbWo4dFphV2ZqR3VXekxIcllLNDRO?=
 =?utf-8?B?cWx2cUFkcTY4TDlMOTg1MVFPTEIvajRieWwycXNkYUQrL054azFUYVkybDlY?=
 =?utf-8?B?REt1Q1FBTElkRGsvNWFmcVJzN3FkTUJCbU43WFN1SjZ5cWpKYkVYMU5IV3JE?=
 =?utf-8?B?K3d2ajY5SlB1eXhuWjNUbjdScTgwTzh1ZTVCNm1RdzNoaU5KSDZVWnNVaHNB?=
 =?utf-8?B?MDJaZGNSd3luR2szS0ppeUhUcjhjckhxQ1ozSFlCS200UzNJaVUwbDJaSzhr?=
 =?utf-8?B?aWxSTXlVU25OV3VJaHZLUmM2U2RJZ0VJZUlwRU1kVzAxUU1Oa3dkd3ZpeHlo?=
 =?utf-8?B?aUwxdzZZaGk4S0FTMlZZQ3JQa2IyaDlQL0tYU3NLM1h4dzIvS2FEdjJxUFAw?=
 =?utf-8?B?TnNIbGhKUzFRY0FVZm95UEJ3R3FNaFpVSVFGRGE1Zm8zZ0dDL3JBM2hZOTJ0?=
 =?utf-8?B?S2RSODRSNWpkR1NEZXhmd1MxcEwvdzhDb1RTTVV0UGxiOW0xQWtsSVFJT0FI?=
 =?utf-8?B?TC9obkN2bkNNUVJpWFpNSkl0NWFqWkkxa3NPQVNEaHJBR2RvcHpwNm5wcGVM?=
 =?utf-8?B?US8rdE5aTEk5U3R0czB3OVRNL3oyUGN4eFFlcE1ISVNCRkpEZVdDWThmbWVO?=
 =?utf-8?B?RG16Njg2K2dSUlY0Zy9TalFRbkdaSlpzRnNDa2w1OVMvR21ZdDVSSytVblNr?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013edc05-55e3-4906-869f-08ddc363dd48
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:53:04.1746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxmgXupbdge6ot7D5nsQwaqBfqcQF8SLEj5WlAA7mLhaoqznC38VQv26wKUsAfLoKywSFW3XMpnEf1enzopBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8841
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=6875ecc2 cx=c_pps
 a=9as0x59oiNjQ6UJFME4EAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=ElJsUu_2Y0o_wqdk4xsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VxQ3ISNatGyaagU8HQE43aeLWbepBQF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MiBTYWx0ZWRfXyK6P5yFxDgom
 QaCuvmjOBKkxZe2vPx18kbzsKkeSooHvepgxkWy4RCfy5PumwSiyoEkkKw3DmdrDCOW/8vm6Ruc
 YW492zKCDBx0yXG/cdb01gsxAEDRaIamCJ37hd/RsqKrmE3C1wje9i6OTl4lIcK3kAM2SVYoaeV
 mC3VlT9I1UCmseUeZwrxgZ2jP1IXsFplFqdlGqwNH89OoPmE7MaKpchlNzq6atkYsU7HuY1by6X
 VKx/eMyODhbMBod4/3aYJhNyItV8mDp9zzSN/QjsaOPkx14q2Uq+hc02RZ9TYRwd9Yd2sqQQnCX
 wnZBjr07tjZg/osWpV3WJCmYobf4Zt2wzIokaHl9ZPWfcO46NQfGSi9DIG4guIK2CbnTAI6M+/Q
 RjHJw8B5pgM2yX/krBDxwtOBtCmi1zN7Xd8OGS8G9Pa8gYJSucBFLqEwzIxxc3aMxym33c8J
X-Proofpoint-GUID: VxQ3ISNatGyaagU8HQE43aeLWbepBQF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Coverity reported:

CID 1611805:         Uninitialized variables

in vfio_user_dma_map(). This can occur in the happy path when
->async_ops was not set; as this doesn't typically happen, it wasn't
caught during testing.

Align both map and unmap implementations to initialize ret the same way
to resolve this.

Resolves: Coverity CID 1611805
Fixes: 18e899e6 ("vfio-user: implement VFIO_USER_DMA_MAP/UNMAP")
Reported-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index d318e6a339..d589dd90f5 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
@@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                                 bcontainer);
     int fd = memory_region_get_fd(mrp);
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     VFIOUserFDs *fds = NULL;
     VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
@@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                               0, &local_err)) {
             error_report_err(local_err);
             ret = -EFAULT;
-        } else {
-            ret = 0;
         }
     } else {
         VFIOUserFDs local_fds = { 1, 0, &fd };
-- 
2.43.0


