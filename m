Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F14DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXo-0007Ny-25; Fri, 11 Jul 2025 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXP-0006a4-LC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXK-0004w7-6H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:26 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7eBCR024640;
 Fri, 11 Jul 2025 02:59:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+C2StQJlnhWCYTDUl2nS3SX0b1JDV031vxwB5QhlZ
 AM=; b=L0/KKUAX7emscj/wzV4ZXrTPou9SEfKvJJt4kh3az7qRkeW6gl5aKozZn
 EOv+0t2Qrd+zF6mTNoZXPrkiMcjeX6Aa4Xb+Mn89WAOFvVzwZVKOFc6fhylD2M/A
 uPw+DWrl7J+snHEjhyuY9rzLQRv3dYJ1qdyxGKtc8C68sGWvHDz9zB+3wZGeHvA6
 DSr9d0oUveCsUVXetxJU6xJmv4UeLs8dnoqBFU6AsNB53Cl5aYqom7F5PwEBzJbV
 f3bLfV7ef6DFZb/5Ouzf7Mht1a4Usn27ZOHVphZBBBK3XsmaAu5+9SDksTc07Obu
 +viELKyCb4AEUfr0yRwI9rNzvkBMQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3cf11aj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKaEKBVwf70fDzGYBBGh+bEM9NRiSzBd6lRGUsQZh+IvqRsrcpXOb3G+EuoCSjmXwBvsjgd3qZgEeI53U9vM74Gy0Le4QZDtiAUm3zWZlufXa3wuklt9DmsdNY5E4BfpLKaBauMQzj4bSJ/yCev3XLr1eGIW5mmfZ2wxjruTgzyqNqRj7+8ppGfwePXvFFlN4bMLbXDFSf8S0SvWk/lgmodJKw3JBkoqadLgyKd4BmHNZvlUtiTE8XksLc6CHEG+f6AF18Ouu1Up9KzmZtFKOvLvSeOaju5PHUD+hn/a3FmKB0JGKsvZCLv4+52pUSY2f0tjcwWWyeYJavfMnny+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C2StQJlnhWCYTDUl2nS3SX0b1JDV031vxwB5QhlZAM=;
 b=AtGed0r5sOEmnUdjqlTD2CJN3p85or15BgIK0KKkWz/oLLLvX9aqn7zG3p2Gj3P5ond2CvWbuO6Vv7UsuG0qFhze3OJmfMy+njd4oune8n003C6eUvGnPzfQPvOnEiNupwX1vsRz+Y8mrW6d+u9wPvtQbhiL+uyBSDxaWj1u6Suh87ll9QlQ1RUAE+tlSlDJ8JYekbD+b15BuyD4gSB/MfuXZiCiOQr4AK9bGdU76Mpj+gE12pCJCDbnUzobpM/k1nP2HBInN/l45KctW9qaFnqWh+wyxNaow53DnK981Y+0Dfm0/5kWN4Q95HRajxVncPuF5eFbegPilN0gsnYngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C2StQJlnhWCYTDUl2nS3SX0b1JDV031vxwB5QhlZAM=;
 b=N+cXTVbiIw4S6pZGNox6pDIe4/yxzIUjr1eiKtdcU9PqQ8JHwpmbVUoC4qG9JSPzOLmXuRVRZw4T7uMUtEiJTizVzsf4YhbhlDK5mQzFArR4hTS1OBjPJiG/aLrDngPe3P5NI8s/HqK508RvtLE1lInE2B1IlXGwIX89yvZJuowYgIM+z8UbbS3i2d1TSaNjWa3car74fdEPDnRHb81G9ZH591XnNBjXVEiFjBErZUuKmFF9a2fA1zs16xADxu1zLnkx/ml27OOWs393KHYFIUiGvtP5dqDoRgNCnTiMOWMgJQHim2jR7TJPQOHPVWWKEjpA6RbKkxWRr/uhzCOaZg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 17/19] hw/i386/pc_piix.c: remove unused headers after isapc
 machine split
Date: Fri, 11 Jul 2025 10:57:19 +0100
Message-ID: <20250711095812.543857-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 02336774-01d0-4743-956b-08ddc06197da
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEttVC9IYXRVZkh6aDh2amUySEZ1eWJHVzMxbk94am9CR1p3ZWlZcTJod1Nl?=
 =?utf-8?B?N1FkYnIvbVZtcWUyVWZjYWhOQ2Qzc1NGOUhKM2hCSlZFQ2E4VURTSWUrVlBa?=
 =?utf-8?B?M2MwaUZ3Y1p2YU5IRTkxM2ptOERIOHQ5U1ZYeTQ5ZFpOY1pQWHhkN0VrYk1C?=
 =?utf-8?B?T0pOMXpQcmVsSnVBekkvMi8wQmVSNGt4WHgvY2NETmFkclRycGljaHBPampj?=
 =?utf-8?B?MWZsbjk1UW92dHI4US85QlZ6ZUcyR0hlSS9BeEl2N3RFamkzN1NuZUZUcnMx?=
 =?utf-8?B?L2VLdEJmbkZIWUYyQTdaQXZ5djY3UUt3bStIZXJ6MURUTzZIZFZKb3p3RVQ5?=
 =?utf-8?B?dWc5cWdFM0VHejBBLy8velN0YmtvUGZXdXhralFlNklqZUZORmRqTjRZZ25C?=
 =?utf-8?B?a1dnY3hLZG4rd2Z1UnFUeS95OEFobVh0b2IwdGw5STNGNUF1SjBZMUZSZk95?=
 =?utf-8?B?LzRYNjE4THJTQzJXWXlET1ZPQWorTzNZbHdBYVRFTUNqZG16ZjNpVjdhMmFv?=
 =?utf-8?B?alEyb25udjlqS01mOURGNVRUay9FYXZYMXBGamp4eVVLVFY4N0tGc0t5aDFw?=
 =?utf-8?B?anVDSTJQeVFSZGREdkFmNVhuTkFnL1Z5eFFUdGdWdDRLd29vc3U0UGpnMnFU?=
 =?utf-8?B?TFB1SHp2TzNtUFF3UWZMbGhNb3p4SzZRak0vL3NpZzg4UkJsb0ZSL2p2WUsr?=
 =?utf-8?B?RVpJcm53TTJvVTg4ODlBSjdMUUNNQzBUS3cvU1NpSUhuNlIxMldQR21ZZkVa?=
 =?utf-8?B?c1dpNUxnZnIyUnFEUDB6YXl1c0lEUEJTTW9ZRkZxNFpJM1hGeFNIUC95UDhI?=
 =?utf-8?B?TlJ3U1U0V2dMMWNHQThaNjVSV256ZXd6bHBmK3FQWUpQWFM2bEp3Y3EzeDEr?=
 =?utf-8?B?aE1tNm9WbmVwSk4wM1Vabkp6Q0xIbEI3MTBCVnlhMnIvcGRoanJhYmVlM1lk?=
 =?utf-8?B?eURoK2gxeFpxT3JEVUp1SHJIN3RYcU94V29PUjdGa0FUbW5uQkFwdkFWc2pw?=
 =?utf-8?B?Sk5XMmdER2tYd2Z5TmJFUzUwN3NiNmdKQWdIWXV1a2N4MjdxbEZIZVU5TTFO?=
 =?utf-8?B?eExpbWYzWVovYlZKL2RPeVowekRJYitTL2hIbitGMC9jMXk1TlN5QTExL0dl?=
 =?utf-8?B?MnArOXhyRmdwSWxYd2tMK3loVDZHcW5tS1dHNXByU0JScFhKNW1lZHk4dkgv?=
 =?utf-8?B?RGpKYzdhb2RFRGpDbE9VS0FvdUxaUVYwZktuTitKS0t0QUU0b1RTTnpXZ0dN?=
 =?utf-8?B?bWRvVkR5NDd2ZzRBV0ZCelFLd3QveGpzUmFBa2pDZ0hSZk53L2JPU3ZBeE94?=
 =?utf-8?B?VTNXejNzSzV5MmpkMkUzaXB3cmNxME0zYXJqczk3L3pla3I3OWFMaG1LZmQ4?=
 =?utf-8?B?T01mUWpLTDhFdE1jb1VDVXRqMFQ3RVpROW5nbDNkRFFUSGpVcGo2cmF5ZXJJ?=
 =?utf-8?B?d0VCR3d6aFUrTXFJWUo4dUxwL2c1czVoSWFmWGk4cktkWTVZSXNwY0RucW1C?=
 =?utf-8?B?K0UydWF3WTNyUWUvOWlhQStyckdQelI0T3dmbFNFcFFocm9Hamg1SVZtOTVl?=
 =?utf-8?B?V29pVlpuOTdEQm9NUlYyclZGQmozVjNDTUl1RjAxN2J4cWo0RzdxWHpad2h3?=
 =?utf-8?B?U1RXMjg2VTFtcEwzZG5WYitjVWRJTmYrY1pzVFMrc3ljdHZ1TmdscHhvajZJ?=
 =?utf-8?B?dytZblh5YlBQMkpmRUJyNFAxVVR2czVZQ3NDRmp2d1RkaFhENGNQYWRSWGZU?=
 =?utf-8?B?NlovdlA2WHUvQUE2Q3RIcjZJUDFiZUtwU0tWVVVHRDlBazY3bjQza1JiSFJE?=
 =?utf-8?B?cXhYeSt0OEhqd0k4aGhFLzhtc1lndlN6RTg3OGIxbzh3aDd5MmxoRS9BZjJ6?=
 =?utf-8?B?Z1FmSzBsbnY5TGJKTmJ5ZVVFZU9TRUFEajI4NTlVVU5aSUpFcFZuNmtJTTJ0?=
 =?utf-8?Q?QfBX5fULzEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VDQ041VXJKZ0QybGhvRFZITGp1ZFVISGtXTkttQmYwSnluMmJaakNCOXEz?=
 =?utf-8?B?ZW1LTnk0SkRtWmtvVzJRck9FNXhkalBsUTdlRmxXUWpPSDk3WVdvL1ZxTm1i?=
 =?utf-8?B?dElMemRrLzFIUjk2VUROWjJha1lJOVA3UVl6N2JpbG1LVFErcnpCMGlPV3dl?=
 =?utf-8?B?OUlkajZCOWJpNVVLR2U0WnluSTFRZFYrV2ptRlhaTFplQnRzeXhRMjIzU1BD?=
 =?utf-8?B?WmRaR0pSWDJXcDkwUkg5VTdrN0QranF1Tk54Q2JiWG05US9OalRPekJqelZM?=
 =?utf-8?B?Ui9yR1QzNzJLbnFGU1NEUEVYd2szUW41UHJ2bTFsWVNhYlVnejNvNVNpWjN4?=
 =?utf-8?B?cE1Va3lYR2ZyeXRQQzF0azFkeng4VzlLR2FBakZiNzM2MGRLS3ZkeWkzTjlu?=
 =?utf-8?B?STY0NVk0STVBZkdudTEzbDVPOUhOMjJYVGQvYko2ODhVNzNSMjJzYXluWE5I?=
 =?utf-8?B?RGxFa3dkb0pyWVp2YmIvSk9LcXlJc3VvV2NJYXM1RVdKaDN2eXlRMjUyYjlH?=
 =?utf-8?B?Q1lLT25yR1JGa0tRb2lUaCtGSnlCVVBBdkNmK3lTdXhscnlQT3ZEZStISHZN?=
 =?utf-8?B?d2t5Uyt3ZkQ1YUdkZXJKcXhLbENhamc5UTNnSXRNVVZURUhmaU14WTY2RitC?=
 =?utf-8?B?RG9JQTZ0Qmp1QTVQYlBlbUNPdVNMYnpmVmU0NDkxQUV0SlZHWEZMeGdSN0ZN?=
 =?utf-8?B?Z1YwSU9KakUyZFhCTlFIMUR0dnJDa1ZSZEExYUx4aEl1TUU0VVVGNURxRGFo?=
 =?utf-8?B?ZHZZaVN4d3ppVm9CUWtENSt2aHdvd1JtMit5cnZrYkg5S0xCdmFFbEUxWDRj?=
 =?utf-8?B?Y1RmYjdZZ20xZVRFend3cVpJR2hiRkpsb3hjWk5OVFBDWmtnRDdrdWdIZHBR?=
 =?utf-8?B?YmdDUDFSQUtkMXFlc0pSS016aUZBQ21EMDNPNzBnenB6SDBZeDk0R3c5SHg0?=
 =?utf-8?B?aDFCZEJXWWhVRDg3QTREcS9RWHZLVk5kT0FwZVZIME5XbUw1ODF5eWdLc1M3?=
 =?utf-8?B?YU5PMUtvUmtBa2NPUGNBMDJ4ZjBZMzdTWHlsRWh6bnMrUjBLN041azdGeHFY?=
 =?utf-8?B?YnNoQkIrU2hCdlhZQkp4clJVVlkrMjNoYUZQb05KbTNrQkJKM3ZMcHFLWmhr?=
 =?utf-8?B?WS95ZWI1MWJrOUxiQ0ZPbzVjazJqclhEVjV6czl1TmE4Mks0NThOVHJRdE9s?=
 =?utf-8?B?OWxEUzhkWXZBMzRvMEdEa2dRR1p5d1Zqd2MrbFFCNVJTMUFGclhwTVVMZStu?=
 =?utf-8?B?bURJemNLUEVaWG80QlRYUFgrbHJoVzNDTDFFUW5UeHVrZGZmWmxvWVFlMUxM?=
 =?utf-8?B?K2kwaDUvcDBmODF1MHgvWWhORGgzbUk4MDE4c2lIekRVeW1HbmQvVXR3MFpL?=
 =?utf-8?B?UGNnbnRPWkpvTWVoN0NJMnBYa2lmcUd0cDBnNEhpOTd1b2VKR3dCdVlrdGk3?=
 =?utf-8?B?THgxb1ZBUXhob2lhK2pJdXh2MlM1ZjUvYTM5MlFoQXpZdDRIVGR3T0diUDIz?=
 =?utf-8?B?akxpaklKVk9sd2tGTnRFbDZmRWc1VVVCcGN5RGFKVDBDN3lHSDJuSWJ1ai9H?=
 =?utf-8?B?QXRyMkZHSUYra2Vpa0gvbjlRam4zN3M4dWtTMXJIVFM1MFFMMlllV1FORjBL?=
 =?utf-8?B?NHAyUHR0dEpaV3M3OXozTkc4QmN1N0hRZUdBTFdRUDRUdkY0eC9SSitXWG9z?=
 =?utf-8?B?cmdRaEd6WVMxLzBpWVdnMytCU1FJMGxYSHlaUm10MFkway9jdUxybmlEQ1Vn?=
 =?utf-8?B?MFRCMDB6dkZxUkdIMUFQUkg3c0p3MmdIZGd4OVk2Zmc0R2o0aDFZci9TeHhw?=
 =?utf-8?B?cVR3Q0hMajRhaDVpbGNEVHNvSmkvaS9LY3V3M2ZpOENNU0UzbC9adXFMK2FO?=
 =?utf-8?B?UnovV2pwdENRS3VYUmdqZExCd0toZytubElYMUloRnVzWGdQL1JsOUhjTWJX?=
 =?utf-8?B?blFoMWEwNnpxSUVzeHBXTk5hbk8yKzlSbnlBcDNNR2Vlc1hDT2hnSjJ0ZU91?=
 =?utf-8?B?RGxwdWNaR2JwU3FaWHZIVUcwR0hsTmlhWnZveWZBZzJUT1dGdVlpenljeTd4?=
 =?utf-8?B?RFF5cEFRc3FoK1RtT1dHUTNpcVpVVDhyNmdkK0FZTVp4N0o5cENBZUxSOTVB?=
 =?utf-8?B?UzI5d3A4T1QvQkFzU3NZakJaeVhGdGQrbGF0TFB6K0UydlQyeUJxSk5LU05j?=
 =?utf-8?B?cUdWOU5LbitkYjJOS3lpR1YzYkMrdkgwR0cwL3ZNUFNwdXRqckR5WVhHbW54?=
 =?utf-8?B?dUdYeXFVYW1vaEZYdk1wVTNzTFdBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02336774-01d0-4743-956b-08ddc06197da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:14.9296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zx+Wu2wq/XmF8VbNF3YhFDwtAUsioSHe2BMP3gwVLES0OwuQu4gEzeBCYn00C/wMxRYf6epaISQqN7LViIFKJBRLiaC9+PCvSGHVxyFWak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Authority-Analysis: v=2.4 cv=U9SSDfru c=1 sm=1 tr=0 ts=6870e074 cx=c_pps
 a=Gqw+4yJV85EtGHpvYtJK2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=W95sc-WnjIl6KLOMV5AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Mkxuhsq2XemCVhll_PbGN52yzKkjqk2I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX+yCvyfDbD/YF
 s80Y4beu6R9YoIa72PT21YtD/LM/DgPN9HEDTRk2uJKzLha8Dic5ue2RQYTLFkFEuHT7g/xXx8T
 J09f/EqHA02MOnEsqijPaXSLkDy7Oe1AgkPhxxIqQMt21igO4AGYE7HuoPxY8T+RwadPFVMm9+R
 DT4RR5A+6HEFWni0qsG7Hdm2l1zb81D1BsV3HMzzRvnjf7iFKZ3yY5VtkQg+nbkchjaS9Rj5uKn
 H0hJM6EIji29Mf4hFNrTUV2ZhNxGYJXUVfgTx+P5hep+yv/o/9+v2RZgeX/CZBz8x2HUZGT9yc2
 CxCRgLlcD+A9k0B1vx+l3nxxnL73+5lQaXmlUUOktiQ3bTBL074o3EYkBycNlN8zOShPmBwK9J1
 uwL6At6YZGAkhJW4KxNQnj+Js2fj4Q5i7BZLbdx1CHJpBG1n48hMWbgyUqgn3sSiy4FXK/or
X-Proofpoint-GUID: Mkxuhsq2XemCVhll_PbGN52yzKkjqk2I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The headers for isapc-only devices can be removed from pc_piix.c since they are
no longer used by the i440fx-pc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4c7da53943..17975ba0c4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,19 +27,16 @@
 
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/dma/i8257.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "system/kvm.h"
-- 
2.43.0


