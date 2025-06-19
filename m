Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9713AC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNa-0004DE-3D; Thu, 19 Jun 2025 09:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNU-0004Be-5R
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNP-0008Ce-AU
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JBwK8n024158;
 Thu, 19 Jun 2025 06:32:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9Q5nBE24YdOu0GO4vEHibcU6YfrjdcI9DciSr5HUb
 +4=; b=z8lv4uXkQTPHLmmW7+ijy7ch5/wJHMF2asz4VzLbdH9UgH1kU6rViGjfY
 FnaUK9+4J8PvWBXl2LMRDNZuoM48NzWNonOX4/af/w/oJhdLPkPiQHvAE5wGyJhp
 g2J1YVSsZCCZPnko0+yJoPK5h2tnLpgTK0IRTYr8bl5yhrqd1HuCOGz51/EnZzBV
 Dn40DFjc8u5yMubbt2odCYQ01hJKN9NBv1lyTCpg7oFwJp8gP/ZG8Yx/XITILVkM
 /qNfM8J5OlizFuCnSJGlz9EvtMclSDw7YHy7EHDAl/SbJesy/YvjCEez8222dNo1
 ED5Bx1s2q1SisBXT5F/L7i18vnv9g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020080.outbound.protection.outlook.com [52.101.61.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47c0vfjedr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcS1vPVV+Hmh1pU50zWhlCwOHLxv7QUf+hYHIdDmjCkEA6TN9xQf4K7RroalYE+T4ZHMKYCndHjHO5xSk/rgmjwX4XCFcobLRogGxxFhDXoN193OweOhULsNLbTWp+Ml2aSUp+7UohxtnLkSNtIfIQkYrKMHqYQxspXQKsBIjR0T0TN7RxLQ5eugpAmF07I8JzdbkKkk8uUnSnOEmNsKMvBkvPCsr3rakn8evI4S1OqIG7x4t0LH8VDR5UPFMacPcl7A9FbrbYaZG+j1lB1Rj+nY0JXBPgTVgnRY1E0n3U/1e8yXN8gYIi6fZHgzNTo10A0vDCy9MPNUbIRMSh4TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5nBE24YdOu0GO4vEHibcU6YfrjdcI9DciSr5HUb+4=;
 b=g0QY65JHWmYuexdGfDVqcN47sFzMSxFtE9YT/YVJ5LWAyxSwaFsedx9vyy58CSu525CSH4hwVGqMzU8VjayVdKX+jwmAIOfJdHB2Oj7vEm53YEXYgVRhTvKlhq9Q27DD+lGuZpdwrcRjxJP0jDSjNLyzacSR5dbUU5Wu7bZn/E6Xub5hQytvQyr1ItFV/2PF0bKPaCU5MSnEbds+awg4K2vyIZwC+nZh0lx1P6O0B6VBeAlu+embw5PyLo6TiPDzYVY0t6jdKLtIAJactsPgqNYEliliCD5twBThSELzs4g1PCiJsbBJp5ZyefOZM7nUpKhDr78Sf2I1d3MzIEW5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5nBE24YdOu0GO4vEHibcU6YfrjdcI9DciSr5HUb+4=;
 b=eMXhTpLoKDItzb2CaqbUFv02b1xAWyOEfIp/uct1RX19PBoKKtOP4EtKtsj2eiVg/NccfnGSCKvU7r1vYs2YrAxsXnLy4erS4RVW7X8IC3rdipfbako58FBumzAv3Q7TlBEmDG4TO41AljrpCK9QDXQutk+InEXW4hnHwudQeJPrRXnwOhf8k/898glkaI9znQ5VNzYN5dA1sr9UcPwQW4kHznnKlLAkymJQBrxgZ2b/v8xQqtQXB1lymALEupXu4M5Y2pygHVj+HAkmnOP/GZWLauWkg1tfuHgf62JgnlZvXLtxDAsWiWVyLaYYOXId+1kxEhv6PuGbqPc58KqCmg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:06 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:06 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 03/19] vfio-user: implement message receive infrastructure
Date: Thu, 19 Jun 2025 06:31:37 -0700
Message-ID: <20250619133154.264786-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 745a96cd-5ee7-4db0-7921-08ddaf35af30
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWpSenJVWGRNWWx0bUNOMVF0VVkwWjhOOUJ3OHJ3ZzZsMUxmbjREVU5ycHVR?=
 =?utf-8?B?Ri9KZzhZOFh5MjdIN1RhSG9NMjIvcysrbE1ySDBQQUZKb29RMjEyeEVyNUk0?=
 =?utf-8?B?OTc3L1lxeGVCcS80enpBTUViaURjbzA0OTZVcGFHSUFkMThqTUJxOVhadFZF?=
 =?utf-8?B?VG5Za2RFSVhwNitKYmtoN292YVoxK0twYnF3N2Rwak9telJIbkZ5ZW5yVGdu?=
 =?utf-8?B?ZTBoeCt3RXVla1BZOHNnR3F1TGdBMmN4NHAyQ0RreEJEVW8rVTlEaGR1cEYv?=
 =?utf-8?B?Q3laNXdoU0dvaFBpMEw3Z1NKU1p6UktHSVBoVUZoK2xTOEZObkhnR3lHN2tl?=
 =?utf-8?B?Skw4QXJjNGc0Z1hWbnZpVTBBZ0pmUDliYmJpUkNUdXZabUt4WG9aM3VYVTBj?=
 =?utf-8?B?SVI4UXh0cVBWWTJJYmh1QW1wakhSd1BjcTBDQXZBdVRPRGk4T1VOT3oybFNY?=
 =?utf-8?B?TWlVVEZMVzVHSWFzZHlZenJ2OE5tdEZxS3RJeENuQ0U0QTMvL21ncDg5RUFq?=
 =?utf-8?B?N1YwK1J6akh1cEp5V1FscExoUnQwZjBrYUtyTStmT3hSYUN2b3VEaXBUS3pT?=
 =?utf-8?B?cG9HSGRVWDlUcitMejIva05WaVljMCtYWTIxbDFmdmhFQXl6Y3VBaktSWW4x?=
 =?utf-8?B?VXVVWjRFNGtrdS9FRHUxUFp2N0syd3dmVUQ3TVlENG1Fa0wxVkFjN1lSWWh1?=
 =?utf-8?B?VG1tYWk5R3BJbGxGVFU4d3pqcG96Q2ZvY3h3YnRwcmhvMkg5ckkzNGpwMzh0?=
 =?utf-8?B?eVo0WmhBdWFOdXBpZ0FYL2w5Qm1KeWEvMzJvalByQzlJcXFsUWFQQTc5cEtx?=
 =?utf-8?B?bnRaeXNvRmlPejMwVk50STdSNEloanRVcWZ0QmFENm84SlRkUjFqYjdGaVZ6?=
 =?utf-8?B?RVZBMlFpT0FROUtiZ2pFUzQzbVFWUE9WL2IrQUJ6THN3VnJ1UkxXQndZWGdV?=
 =?utf-8?B?REdHR0VMMmhIRERWbXkvelBMR1JselMvazlKN3NQelErQzhmaXg5WWlwU2w0?=
 =?utf-8?B?SGtPeW5GOC9ZREtxSklZenhuTFZZbUdCVUM4Wm5tUlhya2hCTmM1a2RLNkFK?=
 =?utf-8?B?SitoaE5tNUs5VGI2ay9sd3lEWE16S0RleFMrbk9Scy9GQzBiL2ZCWWh2eVRq?=
 =?utf-8?B?cEJTdk5rdjBJOFJqeHpta3NDbFl5akRxRXY0dklMWlcrLzVFcjFpcHhVWEJQ?=
 =?utf-8?B?QXpITlZqcTIrZ1BJWUpCMVFKc21XbHBuK2tGVzdRaFVSTm1XMFpPdXloZXJS?=
 =?utf-8?B?ZWtFL3lJb0tFLzY1eWhvaHpQNnYyOUZiQWxlb1JSRHpSNHFqaVpYdHdqZkhI?=
 =?utf-8?B?OGwrdHJwdXovRUc5SnpLWEN5R2t6azRFZ0dDVWFjcERTencyYlZlZVJWYzVm?=
 =?utf-8?B?QWhVWjJmUkE1Wmx3UkpvaTl3N3Q5ZEJzVUVoc0dFMldwVVlwV2FMY3JiRUJH?=
 =?utf-8?B?Z0diY2U3R3dTRW9kNWdPQ2JqUnQwQk1PWGxWdlpreGd5cXNpckJOZEkyNjJN?=
 =?utf-8?B?Y2FTVDZQQ0wxcVE0R0d1TGF1WGRibHlDRFV6ekhqdExQdWJ2ZTYzVnZoUWpN?=
 =?utf-8?B?M3lXZ3AwQlc0R0ZxRmxyaHBzdWtwRGNMYXhvMDRLb055YmFXeWh5czRlM3gv?=
 =?utf-8?B?aHlPdDBDZHh4WEhJa3FXbGp4RzZ0R1J0aldVbTR6VzhOYVZsSU1SV3p5ZFlH?=
 =?utf-8?B?b01qRlRYSmFkd2x0TUpTR3UwR3pKY25Rc1hZMDhjcDgzQ2xEcjdsak5wcUEz?=
 =?utf-8?B?S0tneWpLYzlCZ2pyeWhKTUlXTko2TnRWd0Y0TklhS3QwS0lla20vN3NIcUhu?=
 =?utf-8?B?TjdnRGo4SHYwOTFHc2VSMkVsZU1HZVVlZWlFNzFzL294UnBCRmd6cUc1U0t6?=
 =?utf-8?B?RjVxOFRkN1hSMXI3Y2M2T3htZ01OVEJiQWplR1lGWWZaUWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REx4YnNUbk9URk1obWlxZEE4L2FrVVRqWVQrZjJFeFNwcnA1TUw3RTZxdFF2?=
 =?utf-8?B?SGUzN1NlTmx2YzhIb2llVG1nV2VZc0lWZndKVjBlanBmNDVxSnRJRzhHbWx0?=
 =?utf-8?B?dURtWDEraUREZXYvY1VxUnpwaHZCZ3hHS203dm9QdUp5TXhMd2IyTEZ4cXpt?=
 =?utf-8?B?K21ISWRKY29DbUZKeHhnOWpXS2F4VHhNbkppMmx3aVpwU1hhNXE1ZzNEZEdo?=
 =?utf-8?B?alA1QWZsNEhIY0E4ZnVHa29CM1RldVJ1ZkFMdDhhU1dCdEtabEs5OUxPckRM?=
 =?utf-8?B?VmxKblc2QzFYTktsQ2U2ZnBDMHRURkhaUDIzSDlqcFVSYmZwMkNSOTZ2SElq?=
 =?utf-8?B?TWh1UFU1VWcyMWkwV0VGU2FCckVSZm9TQ3BPWFZIbDVWdjJKMFVjTFJyOWh0?=
 =?utf-8?B?MlR5UTFGeFhqYThrNExsRU43Z1kxZkMwL2pneU9zNVU1c0hYMldVTVVvdVk3?=
 =?utf-8?B?a2xjT3Y1NnhQWHJXb0RPUUFXTFJicVpJNmY3OGJFS0EvbWpaQzYvQnZGZ0JP?=
 =?utf-8?B?REN1dGVvbUhOVXFLSENxeHAwcDFtbFJSK1NKZU8xSGNmOVNsdVVxQVFqQXVO?=
 =?utf-8?B?c01hb0o4SXc1VncwNC9idXE3dng1ZXZVeStFSmxtMUsvdytTY3pCSHhXSjY5?=
 =?utf-8?B?QkEyQXdkSTdUbHdXTmlPRy9nbVJacktUanNmWXpJcU5PN3pTNE5aeGVXZjFU?=
 =?utf-8?B?cm1Zc3N3ZmVKNEdJTGg3d0VYd1FweDJoNHlGelNzM011L1VQdlJSbUNoRk5C?=
 =?utf-8?B?YzdKUDMrczN4VlE3TnFwU0FIdjI5aDlYd3pEK1hDdkhzd3EwT1ppWCsrRmdn?=
 =?utf-8?B?SmpycGRSS3BualJEbEpTYnhNVjhQNS9mYWVRNUNHMThkNHl3Nk5BK3ZGSk51?=
 =?utf-8?B?K01wSVphSFpuK2NlU0hJVHR2MXNEUXhKYnpqalFGUDVPd1ZJcmxFTVM3V3V1?=
 =?utf-8?B?UHlCa1RkbitncnU3eFRTMjdMKzRGaEtYNmpZOUN2Wm1uZVh4UklON3VvRlo5?=
 =?utf-8?B?N0xURjVWZ1JFdnZmZmNOelp1T1dBNlkrMFRjOUdDb3lIbjZuRkVsYkxEaFBE?=
 =?utf-8?B?eG5lU0lRMFdNcU8zbndWOERrOTh1VTNFS1JqaUZaZnZiWHhWY3YrNXEzOFNJ?=
 =?utf-8?B?aEthOVpOMkQrWmxpNnVrY055bzRpM3lnbVhTSEFKUER2bGVLYjZzSThjT0V6?=
 =?utf-8?B?Ung5M3YyejBBNnVYNkhkT2crL0hHN0JDQmxoemVmZ1g1WVg5Q09qRkJYT2Vu?=
 =?utf-8?B?UjBPVloxeUhRc24vTEZia29RSUNlQ3l1REEyNHFuUTNveGFsR3F3RXFZTlBP?=
 =?utf-8?B?TjdxVG04OE1aUllHNUt3aGxSTkpBWHNVczM1NVlnTTV5R3Y5ZWdkL3VvZS9T?=
 =?utf-8?B?ZG0yOUlMSU9yeVVrZXh5cDBMYzVQaEpSeHd1UWtGcmEvQ2pKZ29BeXhVRUxY?=
 =?utf-8?B?RlZXRGJ4WjBqNDRzNEowMzBTanRoRmdOdERGVzZSdUVocUJmenc5L3VmWk5Q?=
 =?utf-8?B?YVYyLzJYZFZZOFlabll6eGRDT2d2Q3B5VXMrSm1uMzJrU29IWkVHQWovemNh?=
 =?utf-8?B?ZkhId1kzMExFNG5YVFhKalk5dk83MXFTUWRSS0QwUzFhUXlwTUFsdDJXL09I?=
 =?utf-8?B?VGpaTmhsT2diUFRMUk5oZWdpQnppNTU4d1ozZURrNWwweEVFa0p3UFE1dURV?=
 =?utf-8?B?OExoRWdYSko3YXJET1NqRElPY04zRXRXS01pWFFWeWNTNUdSb1N5RDdxVTg5?=
 =?utf-8?B?d3Z1b3BUWVVZYVc5MkVoL3dHTVM3bkJFSUxVeEMwbkNOMmJTbk5LVXZ6MFRZ?=
 =?utf-8?B?ejVZUFBxUS80NWgwT2hseFJLd0d5Rzk0eFdiWU1MVy9LNlAybGxsRjY2YWJC?=
 =?utf-8?B?UUt6KzJVa2lWQVk1ZmpONTJNd3NEdEMyRGtvYW5yS2wzWjNMMmhNNjExRW55?=
 =?utf-8?B?RkNHbHRSMXVCeFQzTTFJQ0xYMG04eEdJTFMwcDJScTdwWGdKV282emozajht?=
 =?utf-8?B?bDlkR3pTTXVrQTNpRlpBbHJILys0ZHJjVnFMWUFpYmFVRzI2TzAzZStxaEIr?=
 =?utf-8?B?L3dlenZwMEpyODMwejNxTU9MQmtLNlRQVmNzL1dLNE16RVg4VHJ1SjRHZ3Yy?=
 =?utf-8?Q?umf/lzNV3cM5n7WbWi85J5Q6w?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745a96cd-5ee7-4db0-7921-08ddaf35af30
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:06.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR4i4KP4NpCR2EFNujl1O5lheIvMmMbzd6g62/e+h+YEF5NBuqsg7w62WswwzaWjZdoppmdnk5AlevxIkwm70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-GUID: y-M5g7Z8NQ0ocgwF93S5v6x9ta9mZpOx
X-Authority-Analysis: v=2.4 cv=Tc2WtQQh c=1 sm=1 tr=0 ts=68541165 cx=c_pps
 a=UMsKb9OrGFB5W2EpWsGVZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vXCtUE0a-urccVGwgxAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfXwqlbUVDVxnUt
 +2LbvIZ2yXXJvcJvqDjD7gmsC4/UGwZ3+5L+2MpS36E7xLs8tDUSoY5D08v4GMdDp5z9273U1IH
 NoudcLh7m7y80vnJdy3pE08It12qi5r0VXB032afCuT6osSe9WKu1Hdb0iuJ1QkBwjtlNmkLDe1
 v1dWSu766/NZdCSz3yFr0S+uW1lnWdekBkCV+mAs5FPk0LpX9kJps7veYyoQ7LnsssKEAop9ol8
 zdWjJjpWGcOOi49XNBN3u7qGagHM9k2CqGtnbtmjc7ypERDb+Gu9ZckzfvQFpe3WEA0AdZMsdiv
 KQm8nqtFgMAiCgqGKxIvvxeHWfnENRFvXRdNxVBLMIgQv5KcFzO45Y7+M0Mt38CqOl/fWg5cj2W
 OWbolGhdC4wC0OdOJEzjVjooHjPUwxQZw+7IL6UIBzrPkxuGJWPH/9zGcXdfg6BhDxBNMAcq
X-Proofpoint-ORIG-GUID: y-M5g7Z8NQ0ocgwF93S5v6x9ta9mZpOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  53 +++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   1 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 409 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   6 +
 7 files changed, 492 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 34729c2a3d..3d2d8c97dc 100644
--- a/meson.build
+++ b/meson.build
@@ -3686,6 +3686,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..4ddfb5f222
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,53 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index a9bce82239..ff553cad9d 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -12,6 +12,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -28,6 +31,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -67,13 +71,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..574b59aa89
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 642421e791..bad2829f5c 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -22,6 +22,16 @@ struct VFIOUserPCIDevice {
     SocketAddress *socket;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -80,6 +90,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index bb436c9db9..31e08cbad3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -11,15 +11,32 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -32,10 +49,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -51,6 +398,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -89,6 +483,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -99,6 +494,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -114,6 +521,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..89d6c11c4c
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.43.0


