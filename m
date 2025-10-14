Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216A3CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ghk-0007I9-4p; Tue, 14 Oct 2025 11:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghf-0007Gd-RN; Tue, 14 Oct 2025 11:12:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghc-0005n5-Cr; Tue, 14 Oct 2025 11:12:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59EDSWk5032661; Tue, 14 Oct 2025 08:12:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=L5mOBG4QdyABn
 0ZbNDP1vDVPMbfJluyln3m2ClSU4YI=; b=RVQzb9ewISLRMPf0EPq2yneceUPNT
 n6cS1E0JtvTMkrYYJYKlr4X3caGx78fij03ZYc8brVlo2NO6ncswRBw183UqkUQ1
 2OK0OHngOR7qdUS3fN9FY0uNpjNfjd2xagCSku15GhSfjV0vWvvZPe4wmbOEHzaf
 OZy/N8tCwmG0GxVPnzNgvE1cezuss27Zj8G+tU+QNQGIETNruLl21F5/lp6KH2Op
 7mCnuBvg8KnSxxZxbaiz/BGAAjVhIXrcnfsNsexGpHQM7MHEOhVGYmWXyIU9cvQL
 rhJ2we2TlyTkBObJCCrcwk0i8Ky1bgowalsJtCzxIp6G1tozmwyYD6jgw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022111.outbound.protection.outlook.com
 [40.107.200.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49sfucsd53-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 08:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGVykGAjWBqauatTfq+Noh5Ru7cIfXHMIXLu/4STciSYrhxl3lxasT64Q39hnKyjSXlRrXw9c3GJh3bo1XIIrDosgSW2ozhG+gInk5a76ey+WFYaxfoUCiHFX9pkYyXO57zHL+VztLomTKqan1CtCxGOZVaNvCmHqWHVOHYkGuAkQtXsZMq36P61Kta0YnnCfRtZx4KHA9tzHVRe572wSWx3CV0AMwTX/2q0SNW0y9zlBwUoVqih6yK1MLYHqJbnr+YR3pEzBU9RO0WPFmOAtjFL+v5Elor2q33PqSRSFOkRFH0stHZrQY333VGPNP0cXJ34wBWSrsH8UurozdSP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5mOBG4QdyABn0ZbNDP1vDVPMbfJluyln3m2ClSU4YI=;
 b=GocgL9/m1LKoGt+9nmqGN+Tr+6pvi6qEkDzKnb0PO96/b+5j8PdvWsvqQWlj78Wp5YLf8N5ocyHZIwbTq9NMQMg7Xr8znB7BBs7lCYRrHLq/9WmdPO+9Zglf10QRnkotszROpdi2zopz3KEtt+pJMuIjvNhaEtUsaVv51yVuHhJUZOh9mCATCCuVbzgt942vPbim6w57oS1m1B6O+wf/vbSg61gnmflWWCNUYlL2xI3PM32w2P+h0sfCvfJUEkeWZCvPn4e3LL9hp7/fnSvHDt1TeQW5xLG9cP6hr6M9xPn2S1HbnSH0kmg/waoRRHcX2Z8MdH+hsCjoIi/GN9ghzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5mOBG4QdyABn0ZbNDP1vDVPMbfJluyln3m2ClSU4YI=;
 b=Bxwz3KYWMG1ztPlqnsJ31tm+j7wJVCoWnUdJYy0mLkUDKwrNbO9bwoOH7MxR47YYdX6oEaUBTbioWfDDggCM+aE2n5XRsRjsZvSxqGIjrZMTYcPfyjkF6pxiYWdKrwUoTpC2C2zaJtQYysr2dKmaWBxRCqRx9prrqv5lZn+ZGu3QKM4GXERkoZGSuU5ViitcWJrDl9NGYMBJMOgy20sF6DKdTkSMp9JV5Fo/JUnM7D5/0MxwU7qmFKEhCaNiDchYs1+ADHkBpsG013c2BQVZjnYK0N54NUTPoFO8D0jQk6q8CwQRtX67rBTx3zcwbWY5ISgg0Pbfw4HBCa56PC2jlw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7371.namprd02.prod.outlook.com (2603:10b6:806:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 15:12:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 15:12:31 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 0/2] Fixes for vfio region cache
Date: Tue, 14 Oct 2025 17:12:25 +0200
Message-ID: <20251014151227.2298892-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c4c1c3-4b9d-49dc-c1a9-08de0b341885
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty96QzhKS2NQa1lVOVVDT1BXVkpJMklEdEdBZUZuVTZMUTdQZXB3OTJKUnJZ?=
 =?utf-8?B?YUFONFVyblZkUTU2L3lUc0V4RCtnenJPSWN6cDQzUEVWYi9mYUxLWW9USWdk?=
 =?utf-8?B?MnVXeVR1OFJ4YW9XYTk3NGQ2NmZhbk1UbmlsRjZXYjhIWGU0dFVUREFMS2Q5?=
 =?utf-8?B?ekZaZ0lkTktzUjRrclRJNVgwS3VMbmhzQzVINm40VTIwcHZ2Y0ZjMDBNM1lu?=
 =?utf-8?B?RkpEbVlCV1dJSmYvM3N4UnpSYWRYOSs1MG44KzIzWjFySkdrdS83NlQwVTBQ?=
 =?utf-8?B?bExKajgxWmY5QlM4anVIdXByY1F0TmZNRUtUL2h2YTRSazJ4OHV5RmF4UTRi?=
 =?utf-8?B?UXNSd25vSkJ0emRvWTdEN2hhaUt6aUhYcWFCQzNLWG9Qdm1nYWJnb2tzclNu?=
 =?utf-8?B?NzJWZ0dlSDBTcHArc213UUVDQkYxaTRsK01wcjl6LzZWU1YwSXBRck14R0VV?=
 =?utf-8?B?c0JlYUkwMGczTmZCbG5FS0txeEF3Q2FFWlJUYXU4VFFnRWJhRTVBQWNOd2s2?=
 =?utf-8?B?Vm54VWhVY0RMTWlONVNYNFdOUHdYWDYvcnk0NUhoWHdublhGMHFIcWlhOVBt?=
 =?utf-8?B?UWtvYjJjU1BRZC9tK0VTYWxXNU1iem5wNUwwVjRaTVVKY1cralZrMWJqSSt3?=
 =?utf-8?B?c2ZHMjBCTitNSFJUWndZdk4zalZCTDZoYWJ3MzdwSkdEU2tKVEE3V3VTTjR3?=
 =?utf-8?B?blA2RlpJZ21UNkdUeXdGT0t5N2F0S0hSM3d2TVVKbXd5UC8yYTNJdEQwRUhp?=
 =?utf-8?B?MTYyUTVZQkVaYTRhbGRjVVd3bHZyeFZhTk0yUjF4b3ZtU0RBcVdROHJkTnFK?=
 =?utf-8?B?T2UrOXluSUFONEJGRHlzNklERVh3cXR5SG1KUnY1TkNNSWJwRm9mVmd4anE4?=
 =?utf-8?B?SnpyWlh6ZkNwRlQ4MEtTYmlaZ3A4VTR5OGFmekIrenhaOHhhTW9pTTRSTlJl?=
 =?utf-8?B?Z3B0ZGpZbERUZlYrSm9mTlB3MmZDaE9jMnhvZWZVc3F0T2s0alNsVDRyNXd1?=
 =?utf-8?B?VzYvZUozOXBRQlNacVdxT3g2RmVFcUZjK3B4UEJ3cktVZWpVeFQ3OEk3RUkx?=
 =?utf-8?B?a3I1N2g5Mm5YbUVUalB5SzlOSEMvYTlWSkFka0xRb3BBbmgvellxOGdla1NB?=
 =?utf-8?B?UjRiSnpWUWhYcWdHTWVMNDcrMlVDUG13eG1BMm5oUjAwOWNMRExOVzVFdWsy?=
 =?utf-8?B?WDB3KzY4OCtsNzVFbVJyWTJDRS9EZ2czV0wvblVQdm9KV1hHd2ZWc2I3SlFJ?=
 =?utf-8?B?c0wrbzVjTnF6dGJGdUp5U291SlQwbjVNdWVpSkQ1NTRxY1ZsMTVWVUg5MnBy?=
 =?utf-8?B?dVVFaFM5N1RlNjFEYk5pLzVZT3VETGpnVGtqdEIzN1A3TkIzbWJhOW5Xb2Ns?=
 =?utf-8?B?LzlHcyt0cEN1Uitpa1l5ZEJJTDZlWURuSFRWS0k1djl2ZmdoMkQ0MHc2anlM?=
 =?utf-8?B?ZWJRZ2NjMitZNFZOS2cvbW5KOTRnenYwZlAvbXVNVzY5NXpibVorQ3VSdzhn?=
 =?utf-8?B?SVlveCt1VkFEQWdkMnM1M3htQmxldStkMGFCdW44NUJ3UVR6L2tncHJlTGZT?=
 =?utf-8?B?NkhwSUxaZHRKR3liaTE0SGJCekRqdURSYjlJZXNoczhUdWJ0b3NmV0huay9t?=
 =?utf-8?B?ekRuZU5Sd09XUG5hTHpmTG8rMldLdmJFSnduZndBTjJQZ2FFRFY2VGhNeXFh?=
 =?utf-8?B?anVkYk1IZFZwR2J0YUZXd3pkVXQ3MElGRjdJektlYzBNTlNJV1JObFZlbU8r?=
 =?utf-8?B?cDB4YmkybHVkVWxRdk5xQjF5c0JXdUNXcnFEUU1FSUE4QUNUUnMvbnZwRkxV?=
 =?utf-8?B?YVRpUnBTUG9RSDlsbEdMNTIvMFdPTGoyTDZIM3NZeU5LT3ZxVE5XNnpCc1gz?=
 =?utf-8?B?alU4cnRpTXJzLzJLUWRlQWJkYkNXazhYOXRqQnJ2MUVhV0Z2RU92aDFqZjUv?=
 =?utf-8?Q?Mise5xAvcgRoB/khywzctZmumQIVp9mm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9BWVRBMXYxMk91bnA3SzhEUWFGNmNEeDlPY3pmWGQxTHFGR2JyTG1XNFlT?=
 =?utf-8?B?eVoraDlGVkVlOFdxNWhLNVYrZ1RaTzhVOWM2cHBmLzFJaEMra3U1SktsdzBP?=
 =?utf-8?B?YzU1eWhNVFhtYm0wUVNQSmNaSFZSTlpmWjFSVlZac05rVEZJRHZvdXpDdzFl?=
 =?utf-8?B?eW9URXN6V25tRzRsZWJrNEloSWpJQjU5dEtGdHhReFZuMDRXRzUybG9sQUFs?=
 =?utf-8?B?MEFyRHI2d0Nmd1YvQkpKMWxDL0RZdmJQb05iR3lHQ1E0VXczZkJkYWZYd2F2?=
 =?utf-8?B?Mjd1NUVnODIxTTU5SU1Ha1V0M2UybzBlcGlHRzBUTWdYdXltaFM1bjk2aVBm?=
 =?utf-8?B?SXd0NWJGQ3lsZWRmeEVJNS9BQWJ3c1pQc216bW9qb2VzNDJkN04vU0IrZ0lM?=
 =?utf-8?B?clVPYmV0QWxUTFpKeXN6R0FsdlFkQ1praE5XNlhvQWowRTl1VUowbGkvODNz?=
 =?utf-8?B?d2pSMzNZYjZBUzJxOTdDdFVSZHAzaUpFRTRMNktubnU3aTBMcUxnM2xkcDhI?=
 =?utf-8?B?RkxLYmNrcVZhL3VqeDlsb0JmcUxHNHhjUy8yN2VYTm5mbVFkYk5OYkNOeDd3?=
 =?utf-8?B?NFhTTThKTHNCTmVDNGE1Y1hNT3doUE1QSHljREhwelQwTXBJMUxON3p3Sm1I?=
 =?utf-8?B?R1FjOVhrdUxEYnBVQy9HN0Nsbnk2bzBZV3ViMjRqeDd6OGdPRFhWTVMrY2RD?=
 =?utf-8?B?V0MyZWdVeXNjUDV0WWZacmlGTklKQmlDRzFBdVg0TDJiRGxjQ2JPRUFpT3po?=
 =?utf-8?B?TGNTcDNodUNwdHMwL1I2VmdCRWVQY1BOZGQvWXE1djg3ZkVxWFA3WUZJK3Jm?=
 =?utf-8?B?Z1N3dERya0hrZnFWbHdRWWJYeU1PZE9tZUtDSXJ1Wm8yQUtyVWxvbmxFczVV?=
 =?utf-8?B?NXA3RjVXcnJ3bkxIRzhmcDBTT2RiUThXTmIxQVNKYWJCS1ZRVmJCZi9xMlpT?=
 =?utf-8?B?alFqaE5MV0RIczg3VG9rdGpNaHg0aHBDdytLUlY5Ti9GUjZGdmZxKzdrMWdE?=
 =?utf-8?B?bzhNQ3BkM0JPTllmZC9UWnVzajNEU1VlSEw2MVhWRHhRc2U1Um0xdHJQQ3hN?=
 =?utf-8?B?YW9jbjNvbEoyMW1sT0VmemVheWFWVG92Qm1tdEVhUG5mZEFkK1dMQkJsamda?=
 =?utf-8?B?R2xnUmhRcmhJY3pPMkdIV0RnRUR6dG1yV0RvYU5ib0Fuc0c4TWduVmhBVWNQ?=
 =?utf-8?B?cUZDc1V5c29BTjlvTE52NW4rTHJqNFYwdzZwL2tteUVka1JuenNkNlRWQ2JY?=
 =?utf-8?B?YjUvTURVL1NVNjVXdzl2RE1mcTEyVDM5OWZCVkRwM2FydTlUZnF1MTBlR2VS?=
 =?utf-8?B?bytSaU5Gb29qZVFvZDJnY0xvRDRnZDVucDQ5czJXM3lQRDB6TVBuVS91aFFs?=
 =?utf-8?B?Kzh3Y3RUVmttaHVncVJZSkNHR1hLZHViUllsY3Y3Q3Yxb2p3QytWKzhyOWhI?=
 =?utf-8?B?S3BHNkdTWlBndEQ2QkJLUnFkampOS0xVR0JIa1pFaWFiaStEaEhLbnpWTUZN?=
 =?utf-8?B?d3RNS2FQKzJOQ1RrRHU4dW9QZkIvdFdLYW45NVBrUGZTMzh0dGl5WDNFVlB2?=
 =?utf-8?B?L0VyL2JZU0xUU1M3WDBsSkM4YkoyU1FpN3BhVHFkUXRxOWdhTUJxdk5LMXBO?=
 =?utf-8?B?ay9ObVRvanBVd3c5eWFmMXF1WHNpVjh0bkI1clZYREFMSjdWVFVtMHV0aTht?=
 =?utf-8?B?cEZnMUoycllHNjlqbm5LNDVUTXRkcXpkRk96YnJSUkZhMGlkVEtlcUk4cHFK?=
 =?utf-8?B?aUc4UXcwdG84V1NQaXVEMk1xclltSHBmOUkvcXh2M21FNURrdDFJNGdrVUtG?=
 =?utf-8?B?eW8wblZQd1JVZ0RtakVmRWFMR0taVFB3TElQU05mdU01UCtsZXh2VU1qSkdT?=
 =?utf-8?B?RGFuN3V1RHVtV2xXd0c2ODVGOFRWT2V0WndYUnI0Q2pja3o2TEFzWFFDaENr?=
 =?utf-8?B?cU9EemNQT2hVQTJrbHNHTkg1bVhhdEFudk9zRXpnWmRvYldmNkZDbkpKL3hH?=
 =?utf-8?B?SmZublRHL1kvTTlTWkNubE5DWEh2d1FyQ3FyVERSL3JxNkxCQnRFRThqSklw?=
 =?utf-8?B?MnMvalN4YTRJRHJKaE5GSERzbStBWWNVZW85d0cyVWlubUFkZXlucm4wMXR4?=
 =?utf-8?Q?CAWIIuYJz8p11afOeOkl6lQ0N?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c4c1c3-4b9d-49dc-c1a9-08de0b341885
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:12:31.3980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kg6sbanZnUJjdMQoDt/grWM3N2J8cu67WImS1Z5GI2K6O1Emln5D0nQtBDtonqdz1OJ6QxD7a08KwJLI/Y4WOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7371
X-Proofpoint-GUID: ignsewJsWgUQdDIpf3j9kK11uQVpjSLy
X-Authority-Analysis: v=2.4 cv=KtdAGGWN c=1 sm=1 tr=0 ts=68ee6862 cx=c_pps
 a=b67Q/1ysVWfJPtmvsZ4wdw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iW_3GZjTRKTWjzHSCJcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ignsewJsWgUQdDIpf3j9kK11uQVpjSLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNSBTYWx0ZWRfX7f6Q8XrcDrdM
 Fe19ywTkPlpQFAE4P2/0BqO6nJsgxmUX7SRz82LDGHwlwOiNdl7qJUsUReUUU18qV0/m1MVCFii
 1IkrFYKS+G6g+AkBX2bBhIB1SnXPJqFRmZKJkonLcQnCbTFQAO8fF/dDgthChTnGK0useojTnGy
 v5eKi+qFR4ywW7Y8n+OVSRoI4f0yhrFguMVFjX1fgT1FrFdU9P20LPPjBtf2wemvRkpXvme5q87
 7uWj+rcZZ55P0sfaEDn1s5wtrOQ4URRXStrdPtR5DNkFivzjNeMirdDj4aZ+V/4sWxM5qV8B9W7
 ELfHWjKgpMfO6rxcYcEpVHSuBSRqlS0Rju2Y0IeOqeRcoCtsDDGh58yARVtmEW0xi+2BhHvhKYt
 mA6QhObX5TI4AAyO6/jUxfc4UW8Ngw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



John Levon (2):
  vfio: rename field to "num_initial_regions"
  vfio: only check region info cache for initial regions

 include/hw/vfio/vfio-device.h |  2 +-
 hw/vfio-user/device.c         |  2 +-
 hw/vfio/ccw.c                 |  4 ++--
 hw/vfio/device.c              | 39 ++++++++++++++++++++++-------------
 hw/vfio/iommufd.c             |  3 ++-
 hw/vfio/pci.c                 |  4 ++--
 6 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.43.0


