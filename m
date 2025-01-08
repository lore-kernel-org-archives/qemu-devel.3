Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0833BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdO-0006SL-Oa; Wed, 08 Jan 2025 06:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdE-0006Pn-4N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:52 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdA-0002Es-UL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:51 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vts6007169;
 Wed, 8 Jan 2025 03:53:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=XQDDwFQyZm+cONjGQVEFxxSms0Hyy119B4qDMsr8z
 84=; b=IKqPA2YsnTVU+NmsV3iCJmAJjVcDk/XCg0eLRMe0wzzgJNeQ8+1cL4CBP
 10SJlqnVHx7jROml22oGjOOZVZ4D2xYKYgL5dL/RtBsH6bhYIGgzRVSCAxq62TSx
 Np+sjYPiuQpfOpvWrGvxrStBDIW3fIHp1qbRmWwpWBFWzWe5tY6uYVdl+lxlF29+
 UEjbNRZ0ghITdMEdvPpFiSs8aoTWUpZ+6m6Snp++8Lfpn6CNis1D8NheJgsVgbYG
 yVTZGoloxZwVPD5tZ7lYqckrM31mxLL3OelLa8jhxocOcSwgBdFqQKsXXBUQPv+M
 aiyY3gaXhnDtplFeXRtLgps7O9u3w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryxp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZN5crZp3dWJWVL0RC2aUIhBvm4tzY+jdccczkP5STDot8RPbqPAnS3to3oix3ZYSHWv4uAQv1+/RZcGygi8W57cUilZz3DQ9bBbszwudi1akQRUmafFABiUHORetZ6OQUxDr8tmMlD6JJ6zPlto8BkYbKjt9f+csOdJsNiWbSVRiNyEUyI5RzSV+3OpMimgSmfI4UjbJWZIaWTmTgETeGtH4H9z1wKziLHOUiow3mTfFmryZHNK6R2P+muiuJYUubpQ5cYJqTimSQAl1acx/kIp6/rCsTR1aR7hedTfd9niUyPHniUwehgKPcqVmhtQy4bOC+i32zfec4AY880IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQDDwFQyZm+cONjGQVEFxxSms0Hyy119B4qDMsr8z84=;
 b=kI2LMtnSVJeR6nJjcSgWh1EjpvG8+53OCVrfLGF9mgmoBjpQZ6Zd83tk4vNylrdwdFB/hQnfgZyrlkp/cQiXmiv7xIOY/bRX/oC///phESDt27SqlH7K5OdFb4dnA3nRsCPvn4X4p5ntHN+QHTWXh5wRE9EyiYqjf/yQPH1HOIApR6FfVdg5fWRkSrZn9KPmE/ch9GqBA2Q0DXdd1lFb94/xlyK9dbxcHJF6JPKDha2lzmlYI5seLO5ZZieapDrV7os/5iWz7gdM6cG6RfCUUhvtfuwcHFyixMALRwEx0Q51lP4gcSKSJnV4BvRnawPFRn0poPu/AjJC/23+N2fofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQDDwFQyZm+cONjGQVEFxxSms0Hyy119B4qDMsr8z84=;
 b=n0EgqI1DlTANzqjtbc+HsAdoTFD++6GdINERPo7jtVljsS6pv/e6vxZm9bEfIoVM9aXsJsQFfvbCprnFmvEEnulIldV52ggBu5sqsFz4O5WQpuMeqE7oDQabW5MY2gqg4xy2Y2MSuvzabivpzs7XNEouS2OgKKPEI/c+35Z8K3tY12fKT/IQbKF9dU3HMUwQfeX+hkyU7vs/c4AqO8/z831LkFMXkIevdgiz8E0CXECalxXRFCYmeuN7eb+X6qnUA2l9+t6CswBr9RM32cNBKERxYTeFroO8g2kJSJ5FbkwJfQOkNGxYl6swCLAv9HAXAK2+aNqCYoVi2YoVBAeRgA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:42 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:42 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 10/26] vfio-user: add vfio-user class and container
Date: Wed,  8 Jan 2025 11:50:16 +0000
Message-Id: <20250108115032.1677686-11-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb175cd-acc5-4104-26fd-08dd2fdb193a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXhwMkhXNllHNElzSUpyZkx6a2FFWktQdnZqaGpmc0tBaUJ6SmE5S1N6NnZr?=
 =?utf-8?B?QldmWFZidDBNMDQ2NEwzVjhNZndvNDhaQ1J1aERKcEFOd0tUcmVtakVNTEhR?=
 =?utf-8?B?YlRMVFFEWnlBM0dBT0VSN0E3dW1jUmJjc3JOL2htZmovRG5ndisvRWc2cGtJ?=
 =?utf-8?B?czk1NThiZjIxMHlZV3ZNaXlkRzZEaENnYVhGWWJ4WWFVNEs2SU1hMDRXYVFC?=
 =?utf-8?B?QUtkL21WNHVNZmY2QTRXaFJuOXhaSnpQbVhoa3JXNDJNOU5lcWVWWFQzMms4?=
 =?utf-8?B?Vy94QmcvMmFlcmZlUkxXTFdiOEpTV0txeXY4QUdhaENFMG9LQ3BtQzk1Ym1W?=
 =?utf-8?B?SFczS0dGVGJNZGIramRXTzNvMUxLNG1mTXRRckhFd1FLNXJpc0lOQzNyRjZ1?=
 =?utf-8?B?aXM0bC9WclJSb1VkcCszOEE3KzBpODJLbVBGMnZhbVFtZTBDNGNSWWZqK0hE?=
 =?utf-8?B?bGxpbmxjYmE2OCtNZUlDdWJjYWtRc1BJaVpTdlExOGkzSU9ibnFLUnYwMHlk?=
 =?utf-8?B?MnJSZkxCS0YwamdpbWZ2Zkl6Qi9SKzNqS3ZYclFENWJ6NWQreFA0d1k2eW1L?=
 =?utf-8?B?eGhxQXljdHhLTHJpbzRRNTdaVFBmYitrYzVRTDRQZDZ4bkZoV3pEbVVldDZl?=
 =?utf-8?B?emNjVTZZUXNtc3RnV1Bzd1c3c09seHVpeitjeWVqUlo0N0VoL21YejNUNTBx?=
 =?utf-8?B?NFNXOHp0YWQ4b2d1MDlOZS9mWWRoZDVwNm1zcVNxdTJYaWR2SmI0RXNlNGht?=
 =?utf-8?B?alc1T2d5MGN5cDJHdkJXTnFiVFRiMkc2NkErbzdBRW10Rzhuem93ajJ4aWxy?=
 =?utf-8?B?YTRaVXJDRndIb2hVWVJIWEk3a0QrVVVwNHB5M1lWUnNxNzkrYnR3LzFpeEN2?=
 =?utf-8?B?MDJOTXdteFNXTjltRkRFUVRockU3MDZFak1FeVp4bVk5cFNLZ2dLaGRZV29s?=
 =?utf-8?B?NnpQQjFHaFh6Sy9yTG5Kd2UzeEF6UkdONlV3aERzZE04blRoYmQzNUU2bmlY?=
 =?utf-8?B?NWdJRXRLV1AvcW1YUmFFZDQzTlhKYkxyTmNsSUdUdlFXUGs4SjBIenlNcHRX?=
 =?utf-8?B?L3MxN1VLWFpKOHF6alRsUXFEcTIwY0xYSDdQWEhOY2prbUhNRDVaejBUVVA4?=
 =?utf-8?B?a2MzbjlXV3dxRDltQkUyKy9JVmFsdGlWY0kxa0U0Y2ZkSHlhcW1zRVNZTSt4?=
 =?utf-8?B?NlJWdk5HMjNjZGxlN05YWlVvUlRqT0dkWUpJWGdvZDRKVXFZenFhNk84MStn?=
 =?utf-8?B?YW1jWEtkTmFTUVZIQVFIbkZZRFFnaTg1Mnl0Nk1ldGxxR0VDWWFKNUhEbTlM?=
 =?utf-8?B?S1VXS25qc21IUTlsK2l1K2VTYmRWTmlrNDYvdGJmcFVBS1JhVHJVZE9SOW9R?=
 =?utf-8?B?blowV21vQXBKUDBKNWR3czR6VEdHUkh5eThwbnpDc2VhdEpOREswSCtOVDVT?=
 =?utf-8?B?STh4VEQ3SkZ2UWIyRkxOVGd3Y2pzSVBYL3NaSWtzMHZCRGEzcEdqVHNtSm1a?=
 =?utf-8?B?OEtQTHlYa0lneEx0VGJ2S09zSFd3Mm9nWU5qMXVRYkVCUTR0UFFUT21Va1pR?=
 =?utf-8?B?Sm1LVVowa1VGM2MxZE82eDVPTlhOaFRGWS80ZGpSR3JDWk9SMTY5N3pveXNk?=
 =?utf-8?B?aDRwZlBEa2hrMWRKaWh1cGdlZDRqTnE1TGJZb2trU2dQQnJZeE5HZkthTm1y?=
 =?utf-8?B?WEFySE1SL0tDa0F1a3ZWUzc2SzZyRE5Da0dVRVNYdzFNcWc4ZzlMT2pZVG5I?=
 =?utf-8?B?elUxd1poQTViMnMyWmVSS0F5dzlpMy85OFpua2o1bkJCNjRBNW9DMENzSVNi?=
 =?utf-8?B?dkdpTmIyZ3BEV0ZrZzFDUDltUmF5SkpFZU9sb05kUjNiSHkvc3NzUmNRVktQ?=
 =?utf-8?Q?cp2MgBuwJUCgr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlQUCt5dW8yLzBSbXUxRndPSGlXSDQrVDhROUF0NnZlK095RXhtYXNKU1Fh?=
 =?utf-8?B?Q2s3bkpMM1NrV0RkVTRYV2J2SC9YTFI2MFlFSis0STl3Mkh3NDZoeDlyaTJx?=
 =?utf-8?B?OGtMZEJVQ1ZqbHZVUVl6Qlh0RVpMQXlDNXBjZlFlWG5DWWNHNm1pSktEdXVq?=
 =?utf-8?B?VjliZ2p4RnowNFBGZk5lTGdhc3hZVUZBWmxFM3h3VmhDYUsvcEFSaUVrQ0NE?=
 =?utf-8?B?ZUNhcjhxUVpDOStUMENyajJTOVV2VkVZa3h1MzZVMXk0bVdxRjB4cStNbjE2?=
 =?utf-8?B?dm1MUDdPckxreVI0OVAyYk93UGFjUTBWQzR0UjZqUVlveTY3SXlrZ28vajNq?=
 =?utf-8?B?NDNWbDZoOFE2bTZrbno4Ui9BUVdxcDUrVXJyaFkyamdYR3RZR2pwT2xYbFVi?=
 =?utf-8?B?cjZMZUtLcWY2aGVKU3I0Q1RmOWp5TGdiQ2lhVHdlRmMyWXk0OWx4N1FqRzZ6?=
 =?utf-8?B?RktNdUc0S2JyK3NiQjlDd2pCajl0N0VNWHptU3BqWW8rbVR2L3pmUWgwUXNv?=
 =?utf-8?B?dllWQklOR0xNS1c5RCtkeFAxMUdZY0tNM25Nc3ozSWI3NnJmbXNMNXViT3Zx?=
 =?utf-8?B?NTV3MDlOMlZacHpFdmRxT1pwcE5VdVlzNkRvdWR1Ky9WUXBVMDg1WkhYV09C?=
 =?utf-8?B?QW9PS0pJbm44cGFCbE9YdDFMUkw4bnVPbFBIbWQ1Vm1UQytlRm1iN0RaNE02?=
 =?utf-8?B?Y1JaL1NzVG9YN0NRS1ErS3ZqZ2I2VFdLL3lIUkF3bHloQmN0TVZWK0hLdFJR?=
 =?utf-8?B?b1g5a0NEZ0UxU2VDYWcweEJ1TzZ1OTN3N0lXN3BWemFLRDc2em9PTDI1ZUVX?=
 =?utf-8?B?VjZtQzNCLzM1VDlFejc0SHNYYmpQOXdkUm8vN2k0bmZlT1d6b252Nys3bkFK?=
 =?utf-8?B?Rzg1M1BaN2pPR2ZxUlUxUWRlZElvMTlwZDdxY2lZVVoweUdTWFBvN0dwRDVP?=
 =?utf-8?B?WmZ5ck9tNnFRTVAxOFNPcDR0RU1TNWdqZ2tVZmlIdmx2ZGxnaUppMWtJOHoz?=
 =?utf-8?B?NDJ1MVR1U1czUFRxSWRNY2t4emtVeXNtN1lvRzdpSlpKTHhlbGdiRXQ5a3dk?=
 =?utf-8?B?bEJGQTJQK3NOT2VQQzFPWTlIQVMvaUVlVmRaZVIvRUcwUjN6Uk9WclJlR2Rt?=
 =?utf-8?B?TmJHcU5qMkVva2x4c1hRaG5TOHZBb1hma3E0TnVkNlRnbGN5N3RFNVZ3RUR1?=
 =?utf-8?B?cy9JVE8zcmVnUWMrQWNhZW9NOEVCaUxQS0tzSnQ4aW5GWE55eUJGbU1VWFVo?=
 =?utf-8?B?M2F6T2RZcTdTTWNuWXg5NktCQ1ZHY0N4WURKNTVsOEhoZXRZeDNBY1BNSnZT?=
 =?utf-8?B?dTJRS0VXZFNWZlRJTFZXL2ZzRVFjWkZFU0w1MlJXZjBDK0dpUzl6NGpnQ09W?=
 =?utf-8?B?TWNqUjE4UkhyUEhOZjM3T1BGVENnTVYxWDNRQ3NMeVRJSDZkWkg4WXJSRTdP?=
 =?utf-8?B?TVlyV2UrRHlUZzF6QXRNYUIvdUhMUys0c1RBajh2RVJqWVNLVFVDMWVBQmlk?=
 =?utf-8?B?ekJTaktzeUF1WXNjSlltQmhyZjhWLzk5NzdVVnhJb3M0V1g0RUpFdlc4VWFm?=
 =?utf-8?B?YTFQbFkva1R3V1ZJTDJUUlRmNzZZZDBpcW9SUTdrZE5TT2FOT2RidHpsR2Zz?=
 =?utf-8?B?bGd1V1pPSDlKMk5GM3h5WGtqVVI3aXBBRndxblg5VDJJaHpZNHk1NGVKWHU4?=
 =?utf-8?B?ZzcrcGR2QUt4bkZyZ0JxdHZ1REpENnVLV1I5TkdBcHRMdWI4WnlRbmxEdHJ4?=
 =?utf-8?B?clZ1d29Kb2hsT1Q2SlFXUEprUmYyOElES0R6OURUQXZnZHdYUTRseEVtNzZQ?=
 =?utf-8?B?bWtkN0U2K2l5SHhYOG9qZ1FqMk9sZjFwQm1qbEZBRG44WFkyM0dZUmg3UUNS?=
 =?utf-8?B?ZEZ5ZW5kdUM4aTlwTmR5SE9DajdlL1lxckZ0SnZsekZEbGllQW9INXJUeEht?=
 =?utf-8?B?QUhHSTZNQVZGYzY5MWl6ZTRiK1NiYWk2SHY3UUxpdFVvK0tueHo0L1J4SS9m?=
 =?utf-8?B?ZlZzcUo1L05CNDVTbW5Lek01cmJENkdYT1BwdUxRSHdOd2RiQXFXY1FXeTVH?=
 =?utf-8?B?RTIzbVEydEtNREZxQ21JRytlcWlNWkNrcDNMZysvWlI5TXdrU095MFRxaGxU?=
 =?utf-8?Q?6FWZp5sbVgPphX4dwDM/cDioJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb175cd-acc5-4104-26fd-08dd2fdb193a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:42.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FApeuEw/dKsyI4MZKntihB1/9JqEwfNZvZc437ZNM1h6lniauVxM2o/YQagPwPa4tAkGOI8AJU7ZlPx0mnSlvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e674b cx=c_pps
 a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=8KKI_yEfhvF2PQQ4fRUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: zI8TUMC2zhI5APiQcCJeo_e1lrZbcj9W
X-Proofpoint-ORIG-GUID: zI8TUMC2zhI5APiQcCJeo_e1lrZbcj9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add a new class for vfio-user with its class and instance
constructors and destructors, and its pci ops.

Introduce VFIOUserContainer for handling container operations for such
classes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   2 +
 hw/vfio/container.c                   |   2 +-
 hw/vfio/meson.build                   |   5 +
 hw/vfio/pci.c                         |  12 +-
 hw/vfio/pci.h                         |   7 +
 hw/vfio/user-container.c              | 222 ++++++++++++++++++++++++++
 hw/vfio/user-pci.c                    | 158 ++++++++++++++++++
 include/hw/vfio/vfio-common.h         |  10 ++
 include/hw/vfio/vfio-container-base.h |   1 +
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 11 files changed, 418 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/user-container.c
 create mode 100644 hw/vfio/user-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f60f0a4dd2..b0f9b54500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4139,6 +4139,8 @@ M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Supported
 F: docs/devel/vfio-user.rst
+F: hw/vfio/user-container.c
+F: hw/vfio/user-pci.c
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e0fd5a153b..039241c9c5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -886,7 +886,7 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     return true;
 }
 
-static void vfio_put_base_device(VFIODevice *vbasedev)
+void vfio_put_base_device(VFIODevice *vbasedev)
 {
     if (vbasedev->regions != NULL) {
         int i;
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bba776f75c..f897c5b81a 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -16,6 +16,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
   'pci.c',
 ))
+
+if get_option('vfio_user_client').enabled()
+  vfio_ss.add(files('user-container.c', 'user-pci.c'))
+endif
+
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c6d7ebfd9b..27f82d6517 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -109,7 +109,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2585,7 +2585,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2641,7 +2641,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2649,7 +2649,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_detach_device(&vdev->vbasedev);
 
@@ -3367,7 +3367,7 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
-static void vfio_instance_init(Object *obj)
+void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 8e79740ddb..c0f030f4db 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -213,6 +213,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
 
+void vfio_intx_eoi(VFIODevice *vbasedev);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+void vfio_instance_init(Object *obj);
+
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
new file mode 100644
index 0000000000..f0e2dc6b6b
--- /dev/null
+++ b/hw/vfio/user-container.c
@@ -0,0 +1,222 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
+#include "hw/hw.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "pci.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, int flags)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_create_user_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_connect_container() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_connect_user_container(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_get_address_space(as);
+
+    container = vfio_create_user_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+
+    if (bcontainer->error) {
+        errno = EINVAL;
+        error_propagate_prepend(errp, bcontainer->error,
+            "memory listener initialization failed: ");
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    memory_listener_unregister(&bcontainer->listener);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_put_address_space(space);
+
+    return NULL;
+}
+
+static void vfio_disconnect_user_container(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    memory_listener_unregister(&bcontainer->listener);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_put_address_space(space);
+}
+
+static bool vfio_user_get_device(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_prepare_device(vbasedev, &container->bcontainer, NULL, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_attach_device: attach a device to a new container.
+ */
+static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_connect_user_container(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_get_device(container, vbasedev, errp);
+}
+
+static void vfio_user_detach_device(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->bcontainer = NULL;
+    vfio_put_base_device(vbasedev);
+    vfio_disconnect_user_container(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_attach_device;
+    vioc->detach_device = vfio_user_detach_device;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
new file mode 100644
index 0000000000..a06115cd55
--- /dev/null
+++ b/hw/vfio/user-pci.c
@@ -0,0 +1,158 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "hw/hw.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "system/kvm.h"
+#include "pci.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
+#include "migration/qemu-file.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+    vbasedev->ops = &vfio_user_pci_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
+    vbasedev->dev = DEVICE(vdev);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_attach_device_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+type_init(register_vfio_user_dev_type)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1104ed63e3..50afa944ae 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -80,6 +80,7 @@ typedef struct VFIOMigration {
 
 struct VFIOGroup;
 
+/* MMU container sub-class for legacy vfio implementation. */
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -106,6 +107,7 @@ typedef struct VFIOIOASHwpt {
     QLIST_ENTRY(VFIOIOASHwpt) next;
 } VFIOIOASHwpt;
 
+/* MMU container sub-class for vfio iommufd implementation. */
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
@@ -115,6 +117,13 @@ typedef struct VFIOIOMMUFDContainer {
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIO VFIODeviceIO;
 
@@ -284,6 +293,7 @@ bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
+void vfio_put_base_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 24e48e3a07..1ce93c5b9b 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -100,6 +100,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5..ba9bc07fcf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab03..6ee381df8c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -201,6 +201,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -529,6 +531,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.34.1


