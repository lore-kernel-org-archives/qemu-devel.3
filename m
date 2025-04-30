Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08517C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIK-0007oA-Sz; Wed, 30 Apr 2025 15:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADI8-0007ju-1b; Wed, 30 Apr 2025 15:40:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADI5-00069m-30; Wed, 30 Apr 2025 15:40:23 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHdkq0028201;
 Wed, 30 Apr 2025 12:40:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BYtCtFYOuat60rVCiRSDys1XNxLglKwaD7uVDHmVv
 ws=; b=pVEM4k18MZIUu6siWqNkmUh8V0TRgk0pdb08vHercWW/WYQZi5232qDqL
 DcRYTbbxQRmxtHTnS3qDXKRjcFYvEb01lo6UWicJVMBeJoKLRJH7jo7B7FLzkaRp
 KUF+2U6S643XuA6FKlIV9Jz5+bQdl7mlSwhjS4erBHLg6hAiks0yneJtPvEAFLUd
 q3w6OFPL+Mjz+RK/qjgq3xuyU+2JGu0OBjQbWIMF259X7ANJ2J2JM/t60YBuuZYY
 1Na0bJ8tgBwKmf/G4M3bBNPji54bS/DYeMocgqjL+82NOHljbwxgz+QRKTXiUuEd
 84RNyf7QT7vesi6dZc+13KJJ+koTw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utu9tpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABrozOICY/yyccDvieHSQX3XZloqhoD3K+ex7V4RdC2zqM0B9lCtpUZeLbZTC2EN6m5KGwOtbFNmlBGUWn4zI+hfviJuJI0OuVLZ522IohSWHw8dketW+7903hcmAD8/bSZGnZrPlnl+Dxbhn39LKPO9LIOh0l12qDPr38nNqfvgJylSKuvZbxXKBkUqMaVASOCndHxxpHn1PcAxeaYWI1Pg1OMwVbKl3Q5uoqpCYiDUE8u/I5Bh5vRr40gbLoaptnOuO+csUQQFiB3zYUnWGerharogIZHxmWrom5oIHQXjI6PGyFqVgHX20CKiL7mDgDElbvNri2vg/9aLtuJDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYtCtFYOuat60rVCiRSDys1XNxLglKwaD7uVDHmVvws=;
 b=b1w842BECxPw65D2fBZtalgwNIs3u3J+O0iU0ASiQ8G8pN4ddXXJuBHyVrxwmGsihPFd6CVdR/iX3CchnmIAahZ62YT0S8VioZQZC40oTrukFRDFWs1V7FIrUMXDlAzyuLZgt8y01sMptacLotlrUIaZ2nK1azs+mkWUV9WzUbcMSqMNmhdIH/QCtIR+MfT7CLZBsoHoFZDRkZ0rr11xBT3ab02bN0KG6TbIbrcPCHyV86sbQ67PKRfgtkhW1sfWaJr+sLsCF3jO4WpflRTlacuspkRmeJfZeS/25/u5AVx/alrj6fG1RnlEg1I2eZaJLdVlLaSaOd3lgut81p9zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYtCtFYOuat60rVCiRSDys1XNxLglKwaD7uVDHmVvws=;
 b=fnEd9UxDi5wEis6IWJ0aOgticX35BHwTtIjhb9RJMFbArrWplSKtDfC9TywJdLiN1clKAvQ9WzerKl2c8XboxQfzuRx8EKP5kaDMNE9NzhhClubThECF3h05fnZaPtWv6E7YLv8LRGRbbRkB3bIwrAJaRFylgmxbIdKd8g34JOuvtkeCfU0ZodHnGlHEm+tD0Jlm6fC+50soLNDQZqEDlWtxaJUcdlajtrXqdfxS5Vgjm693UANU21Tgbd8K5pF3McyjRalVjP9ZxC5MIfLkQLQLOXGTwcZtEt+q1uFOZsWxwmkr/XX2GRZg339aaWG6X/wnWMQfNN0OsEio8LIEhw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Wed, 30 Apr
 2025 19:40:13 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:13 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 01/15] vfio: add vfio_prepare_device()
Date: Wed, 30 Apr 2025 20:39:49 +0100
Message-ID: <20250430194003.2793823-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV3PR02MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e21e03-5ec2-4865-2097-08dd881ed351
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlgzMEswalFycmt3amdRK05HWUxNcjBpVEFsTkZ6Z1ZoZ281WGlKK1ZuVDRa?=
 =?utf-8?B?TW5CbHkzUGVnSkk2VVh5S0J4emVWTzdJWTh3Z0ljWTROTENONlZYRmNzcjRY?=
 =?utf-8?B?by96QnRSUDBtZThLQ3hlQ1NMYktmbU9TSDVocGNEb1pNaUxvMmtSUGZtV3Fr?=
 =?utf-8?B?ZHBkanJOM01yQ1ZkNVpSajJNMzk2UUlTTFNRSk52RlFiMm4xVXZTTGFUeEZ2?=
 =?utf-8?B?MTB5Vk0zcFlGWEJtb0VOS1g4RU5Wa2lwN0lBMHlkcXJMc1d5VGNVMnEyV1No?=
 =?utf-8?B?cFFRVW5vVHl3QTMrckxYaHlUb3dxbzVsNVJLMnlTaE5zcy9Memlwa2lab014?=
 =?utf-8?B?K0QwYll0aHhSNUt5RDdFdURvdnR0TTB5d1Bxd29BYW83b2FNMFZIUW1UNWox?=
 =?utf-8?B?SFJWbHdzV1BYZk0zY1FtV1dTZ2FjQWdSYzRIUlNaZEg0MG14MHNHTjhMTjJr?=
 =?utf-8?B?SlBadXRhK3BiTkk2UWpXNktaUmVzZFU4MnRFc2pza3VOUTJzSU5wQmNZNXk1?=
 =?utf-8?B?cHBTVXdKeUxkaUg1Z3FHQWRXeXEzaHpGRFFveXNNN2h4cStKazdFZWdpbEt1?=
 =?utf-8?B?UVBBUVdNNzVCcVdQVnRPWHpRTGFnQ09uRmpBcXlBaEJ3d1Z3aldrWHNOOCtp?=
 =?utf-8?B?SS9zUW80L2x4aEh4eHNKcmxibkRYZkw5TmNpbzdEYjMza1lTNUZabS9pYlQ0?=
 =?utf-8?B?ZFhtWjNUeE15U1dQVnNvT0RRSFUzbzREemNxWGVNNDQ0UXlFdXBvaTE2NUFO?=
 =?utf-8?B?L0FRMVF1Ty9yZmd5ZElCYmRYRStNbEJIN2daMVBJbTFSaHF5MWxRb1Z3UWwr?=
 =?utf-8?B?VnNSN0M4djQ2MTRTLzFrVmkwaGZGVjBqa0I5YVZqc3IweEdqUFlQejFxdXk2?=
 =?utf-8?B?bEFkdm5zM1NoRk5IMUlrWTFyM0NHcTFmTFI1UE1JWXdVNWdLYkNVZUJWaTJw?=
 =?utf-8?B?WjRBeVBUUW1sdnZ5dkJzbmJicExlMGpoN0FIdkRyRjI1dDJOeUxCc2U5SGlk?=
 =?utf-8?B?RSt2SzJvdUdqMjJiSnlKaHhNVTJsZlc0V1hZN3VFNW9tamhaSlhDT1RMYkc4?=
 =?utf-8?B?cGpQVjhQaDdyV050T0lkZk13UFVXTUZDcW9pYml0RTBkRGg2bjFWZnVwc0hp?=
 =?utf-8?B?TDdjRzViMVdicHgvYng2U3ZrNjZCaEVzNWJ3SEs0dElHN2pPdGxBeFAzOWxv?=
 =?utf-8?B?T3h1QkFrMldQMVhSRmJyR3VUang2SGxFWnprdldsQU51bFJpTUFsT0svaW9z?=
 =?utf-8?B?THF1RjY5OVRYSm4xNkd1MDI0ajByY2Y2UzBKL1dnZ250QlJ1c210a1MySGNU?=
 =?utf-8?B?WU1EVGE0YXdwUUhsWlAyNXRLUURHV21jU3lOMEdyNExjckFIbExxTFMybldE?=
 =?utf-8?B?cWhsNGcvV0RmVERGSlpNdVc3R0xCSFp2ZjlSNk9DVFFTaFk0TmxjcVZDdms0?=
 =?utf-8?B?V1cwQk5tYTJFaUVrenk0YjJDc2FXWmdmTHB3UlFod3czUWd2VUNWZG9QRlRt?=
 =?utf-8?B?N1BnU3FtWVVFeS9VVHA3L2xkaVV0TXJSM21vWWc4Sm5OY093S2Vxa1kyRjFQ?=
 =?utf-8?B?RGk4WTJrZHJOeElTQ3BHT01uZU04b0FoL0UrSVRNa2tyNHF4SVdMcnhGelRt?=
 =?utf-8?B?ZDBZY1dtcExqdG5id3E4WUdWNnB6ZnJFc2lQeGFjQk9NUm9Na0gyUTYvV0dZ?=
 =?utf-8?B?WTdPK3ZNUEFRSjhKdkUxQ2twRXpUb25aa1lZVFBvNUVCcHZKNzRTbnJ6VU9J?=
 =?utf-8?B?ZlhsVVhNZ29abXVoM0pqSEpNNUxlTGR2U1BZZnJpOTQxSytJVFdDS0ZhZGZk?=
 =?utf-8?B?SFpieTNiVW1PLzBrU0FWR3lzSHFjLzYycXZpVmV1WDJ6TDhoSlQvMWVhWFE2?=
 =?utf-8?B?MXVNb0MrR0pQWkRyTG9FRUEyeVdmU2lENEVvOGVNVHVMZW1NaTVubkhOS3Vl?=
 =?utf-8?Q?/FvXpETl0w0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5EVmFKaTdKY2lYMllMQ0RPNU9ON0s4aU5Db28xZzN6bjBDVTFPMGduZXB1?=
 =?utf-8?B?QlZvbXNWU1NLdnJDN25ndE4zTlVoaXZKMDRsUmxuazdVQ09GS0tGRjVYRW9B?=
 =?utf-8?B?NGc5eG9VTkFlWG1PNmVnM3d6SHFRM1kvTHpZS2k5L25rNEkrM05HUm9tY2hr?=
 =?utf-8?B?T09KeXBoZGpPVHVtbTlacjU0ZC91b0phbEpyVXNhcVo1bDc2TklUQUdKbGRx?=
 =?utf-8?B?RFdFblV4YVl4S2VwRkxQbW5KalNWZEZrdndBZjYxYUdTRTVsYnZVOUNpWFlI?=
 =?utf-8?B?blQ4VlNKelF3WlVzQWpzbU1QSDR4QnV3c2w1eWQxTHd1MVErZnNBbGN5bW1h?=
 =?utf-8?B?cWR3MTNxbGRtdHM0SVgza3htR0FvaFFNb2dxVWIwU2RyeXVCaC8vYlVCbFB6?=
 =?utf-8?B?ZUMwR1UyM2VkUU8wK3VBMmlFME1wOUZiOFVWM2V1V2t3T2hDbExlTXhOWmxk?=
 =?utf-8?B?R0YzMmJGMU9PWnhKcGtzN2pWN3RpRWNTd1d5OGZwWGpiako2MTVxQ0VYWUxH?=
 =?utf-8?B?NWllNUZzREdLTEwvOFFPbFlaaG5Gc2FMeitsdWVES1laemlKSzBnV3I2eW9q?=
 =?utf-8?B?aW02OS9semltY3hOVndvMUQ3bGIyRVlMRmlPV1p2NUJmeW1QN0gzUFdwNVhL?=
 =?utf-8?B?VEs1eWl5MmdBSkNES0V6M013TUxWMXhZQjd5aXpjNTFMT212dWhtcUpZbEJt?=
 =?utf-8?B?QjNoYTFvMkdUa0dlL3JrN1dYOE1Id0E0WVg5SS9jMU9zaCs3RmNFK09YWlE4?=
 =?utf-8?B?V2ZvSzVDTmpZWkpQR2Q3Y3Bzb1hZbDNQakdpVHdrK2NPWFBhVHVQcEFqbk1k?=
 =?utf-8?B?SFMyVG5Ia3RxbC9sLzFtZmcrWU5rT0taRUxSZ3M0WkVCTmxKWW5IQXR2S1Aw?=
 =?utf-8?B?eDE5TUFKSFJTRkJvc0JJRy9vdy9jWjlPeE5BR1hRSDl2aTJWSTZlSUxqZnV0?=
 =?utf-8?B?VGJqQVh6eEZWQ2pqeFRpeHE0OTJjaitiU2t5dVFxTzZRWHpqV2xldEpkMFlO?=
 =?utf-8?B?VUFtY2d5Nmowb2F4UVd3SUJFcEFpUW50WXpYTW5sZkswSElpQzN3YU5mN2c4?=
 =?utf-8?B?dlQ2NWFCQ3V5d3YydmhuZzRKRHpwbU9oZHI0bEMyQkhGTjc4RTdhTEJsY3Zt?=
 =?utf-8?B?YVg3WE9WcUlRQVVBWU5HVGdtbmNhakVsc05LSUhiRVRUT0JGbXlKWVJuM1V2?=
 =?utf-8?B?Y0xKU08ybmhCWUx5MmlTREpSUS90ZHo3ZnhhZGptWVVxZ1FsaDRqejNTdFFj?=
 =?utf-8?B?VWdkS1BkMW5vcllzTHVOTS9KWDlPYUhDM2M0VXVqOG40VTArYnQ1UDEyTndW?=
 =?utf-8?B?ZG5KNHg2azg2aW1mQkVKU1dya25YVWduTStzUnFKbFFiWjczMm9oVkdUWFl2?=
 =?utf-8?B?WW8yc1lvSE9acUxqYmF0bDN1OXB2S1hNOTY1R3JCR1Q4WHphUjh0b3RSU3Fu?=
 =?utf-8?B?bGRKZWF3bU9kNFQ2VXVQblhta0JPNzJNc0M1K3JFLzFGN3FhZU9EdUZPaG84?=
 =?utf-8?B?ei9oaVdSUjlCak1CemdhUnJWUWhkcDhkeFRRV25mdWpnMDNONzRwY2lRUVlK?=
 =?utf-8?B?eHJydHExTzJoRTlmYnVDMWdHRGI4VG9GMjJzVkdlOXNPeml2c3JMdGFoelM0?=
 =?utf-8?B?bWppdk1mMVo2Tk9SSHV6Mit5bDlsZVdQQVdOZWJBMHh1SEp0dkVCTzA0Nm1J?=
 =?utf-8?B?cVlzanpWODBVLy9iN2lBSFdUQlptWjFiVWc2cDc4Tk5tdXVWdE1VcFV2RTls?=
 =?utf-8?B?ZHJ2TFFqN3U2dWZWYnFSdHNEU3BYL0hYNW1mdXBTdk1hay9uOVF6d0tHQjVM?=
 =?utf-8?B?SGVjTTQrOGJnWmc3bHo0cVNCVmtJc3Q4QmFFNUh6U2NLWjlyK3lZaG5uclE1?=
 =?utf-8?B?VVJmSnAyKzMxZUY3Y3R0TnVRMTVzdFpnMHliTTV1U0lQVVhydTZZaDdSbFp4?=
 =?utf-8?B?YmZqSG1rSWhscTRVMWZKR3orYzV0NG9hUjQycS9BeE9RWnpSbzJXSGQzL3dI?=
 =?utf-8?B?a29MaW5mWEdJL2Vrbk5BTGNmVWNDR1NXMFhkS3N1NjgxR25xUHJ3L3NRZE9T?=
 =?utf-8?B?dUlTMUlKZXVjUEpUZ2htNjFEY1FPVkpwMWFENXd3Y1FtRG1MWDFrM1RBSkFz?=
 =?utf-8?Q?bGgK6DiCJopUR4wMYSLIkLqSF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e21e03-5ec2-4865-2097-08dd881ed351
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:13.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKFMDnwaEjoCgfn1f4JzHMydernl3rUJtzUzJY1u0t3FcHGWvd3v6t+I09j+4SR6IUeXQL1V30IKgAz0N8MKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054
X-Proofpoint-GUID: t_ovXdkYnQbpuYFdo1YGgZoddWCA6GRE
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68127ca0 cx=c_pps
 a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=PEtKgAuwMexoxjSetS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXyPLvDpcvNaSS
 ITpys4qHUlA/7DJ/DoBDQKJ5UnhCm0KTIDZqzRUfwSlk8iAsK2BKuMFGciszPsxJYZSjXuM7CTD
 8+ZZhpdMPlT7Pv9X97dhKJ/Iw77+0HQyGm2+fLlenpNH030ivnIwZ5/9UPfEsQT24rJmVqO3ya9
 gkQJAgnNj0AqDgw2Y9G3aQCKU03xbIyhRU2vY4v0ci7NnlkUO4WyK3mogC0appU0uY9ZCh/fjMK
 I73tmM69p9Q5OK8GAqlSMYjbIphzA+b19fvuc3zkGK7vlsHxXGqVyJQO/kVh48DVy3mL0mpfS+D
 JL0k5Qu1F9mHLX35prL2+5+7eazEWHHSrMdktEToelG3CnHoWitQr0ipRWuZoC4WJG4hhv1Oydz
 1Aq8L2bLucMwvqRHkrDv37jJ/6EuiFSqBmuulUtPihUUlR4JOKzmAfamPYMaZSpTRzmU8SkO
X-Proofpoint-ORIG-GUID: t_ovXdkYnQbpuYFdo1YGgZoddWCA6GRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c           | 14 ++------------
 hw/vfio/device.c              | 14 ++++++++++++++
 hw/vfio/iommufd.c             |  9 +--------
 include/hw/vfio/vfio-device.h |  3 +++
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77ff56b43f..aa9d5b731b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -811,18 +811,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
+    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+
     vbasedev->fd = fd;
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
-
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -875,7 +871,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -904,11 +899,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 
 device_put_exit:
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d625a7c4db..f3b9902d21 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -398,3 +398,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
     }
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
+
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info)
+{
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 232c06dd15..83033c352a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -588,14 +588,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_device_prepare(vbasedev, bcontainer, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 81c95bb51e..9cb5671ab5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -130,6 +130,9 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info);
+
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
-- 
2.43.0


