Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F6C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOw7d-0008Fq-SO; Tue, 10 Jun 2025 06:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOw7c-0008Fc-IC
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:22:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uOw7W-0006Oh-Iz
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:22:24 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A5Qc7E003503;
 Tue, 10 Jun 2025 03:22:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CrX4DrcVekdoFt/T4RolEG9EzrX2Zx0Ggi9mzRfxf
 SM=; b=sGLhSC2lEXFwpVDOT5MfrtaEI5R0DCyWo+fKKPX2YSRaps3s7rzE0FevT
 BFt0FVbkJdbwun7LLfQfKkMkWJxpjj675hptBu5DtoAD8u8MACaflELtKb0bG7Ks
 QFQgJYZIqsq8Bt1AdWLQZecUjhiLNgFupNgKwbwByJeLQbDh5r5Vxdy5e0VS95us
 aUrLJsYQnUf+WzJH1uqlQmZiAVU+3jWLtmNDzCNF5mPWjapMIUIVi7nxoOdJIj78
 Of+Uo2nfMod4O5j/CbPmOj5Bf3VE7Gg2Sck4b7r2Oc5dBbE03pRXLcrFxHheSjOo
 cSiLrjTwAuGuDOTbPjPea4/q5Spgg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474sdgdkw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 03:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2gP3BKRer6V1A2/Vj25WABuNGeHYQ+pwav0S4PbK8rDD8PqDR7anWaHq5Yw1+umSX05kHTZ+88nD0vGcwFlTdBkvXftlJQNmtiNa/9LmVMIDld73VzsVvzc0FwRtcebQjl1ansklSbRFMwcefMtDnpLHyM9hNlEY4o1EIH4gzpga/E7a8HOVjSQpV3F9LUEdpIzSZuCDMdIDBN7UrbFM/ltiL0XGgj83HHBGGvjTJ40/Mbi7gNDXJYa1+WVWHjaDHKkmkmisNPfv2PqQtOPmQRnrx9yO3T4H8Aej7WDgQ8+P0akNYDntp3t9rXI6DU84N6gtsBGp6u6BCDwTL4lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrX4DrcVekdoFt/T4RolEG9EzrX2Zx0Ggi9mzRfxfSM=;
 b=VNk3fmv9a7XxVrjCHc4ptKbd7uCSla4PpV6V+UihS0Qme7U9kjuhVZ12ev+cYSOL9pKi0bcQO14MYDFzEJhF4sCrnKeWZP5/icf9s+u70VbXnqF2zMF9R5OWnA4NyOF66oWe0jMS3O2Max9yXcfE9k3eONyHtAn+uWNSO3mEC64rJeoGUHHEBwfTtyyb44uqktMW70rsj9rLc9B352I/GtEa2MnQQJ2nQYIg2fy9369vbdzwip86RruJATw23xe4qb99GmhZ5XhR4KlEhtIZb9VlkitggiaaFhIr8E+ywkL0VRzp7QavH4oyxCM7SU0ape0Z2L9l4LRrfduC9uQT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrX4DrcVekdoFt/T4RolEG9EzrX2Zx0Ggi9mzRfxfSM=;
 b=c6i/G90+FBdsNr8O/b+PUJeuSwnX+JBOpnpTv0LwAglSaEfayKqNMVBKvDn5ELcaMfj/QeqiDQVmj4MIihk4tx1/kXMaDMCFGzzRDY9k1WxuyQJ1jqQMetEHZ/QFD16ihAUCE0iR6pgnK/PmSEYz5Vn8fG35GZhYBO40kRcsvXDRUHTIin7laDq8YRm91/fxc9yzb8jj030vf5N1eFy7IFw6pVSRM1T+4mL8VnouGd8Oc8A+9c8CShFWt8IwjnyjIMjeXf/rXKPz8hu8ibc0gFWGxu64sGdDYAVH3E0lqubtsc22VKpm00SK1qZUBHqF1TNugds22bD5tONLF9YZlw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6781.namprd02.prod.outlook.com (2603:10b6:208:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 10:22:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8813.032; Tue, 10 Jun 2025
 10:22:05 +0000
Message-ID: <fecc3847-02ed-46cd-9be0-900d39fea5e7@nutanix.com>
Date: Tue, 10 Jun 2025 11:22:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/23] vfio-user: introduce vfio-user protocol
 specification
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-6-john.levon@nutanix.com>
 <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com> <aEgA_U5SZiYWs__7@lent>
 <4cb65486-7443-452f-8c82-da16576c7e47@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <4cb65486-7443-452f-8c82-da16576c7e47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 97178e5c-3c10-46d1-1fc2-08dda808a5fd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDVYVHBDQThlTDB3UVF4U0FUejNzaTJ1TUJ3SWlaQW5tOS9Zd1Y1ejVoRXBT?=
 =?utf-8?B?R1I5d0VjMVZIclhLbjYwNUpkczdFMkRRUHdtREdvUmhjSnNQQ1VMNWduUUpD?=
 =?utf-8?B?enU0RHQyYUNSL0JXNWpFcVhWajJxU3BMdWRib2N0a1Z5Tkw2Z01jWDgvc0Zp?=
 =?utf-8?B?UFRYc3lYNkkwdHROMGRIOHZuNkVRSHphZnFUcXdOZVhpVHd4cjMrblFqbSsr?=
 =?utf-8?B?aGUyWDRPMmt2TGNwZjVFQS9uTHUraWhYeGxrRTl1UERaMjVMTnRTYjFxVmov?=
 =?utf-8?B?R0gveE1GaVVmS0JBRmF4Uk9Wbk5tTDRYWXFqTERkUWJacmo1b1ZwalpJNEtp?=
 =?utf-8?B?RmRRaGxBSjVRMWNGSDZPY0drNVJMSG01eHp2VjdSbXJuckptbEtxQm0wSllY?=
 =?utf-8?B?TmwxVWk1V2RYb1lHd2JNZm93OXdVd0RTWmdHdGY4ZDBvc1pGYTJHWXdTYk91?=
 =?utf-8?B?U2V2OHpmRTBuWlZNTlZWQ0x2ekxsaXl0TXM2d2w1NDByM0RiWG0vMStaMWNw?=
 =?utf-8?B?NGlhRGJxVXM2Mi9UMWgrUzVjQ1U3dkplYVprRkx3Z00yajVyTHM0aVBoSVgr?=
 =?utf-8?B?Z1publY4TEhQNGs2QlFNR1dnbmdFK2JwUU9hc1NQQkk5S3g4OXAxQitrc2Iv?=
 =?utf-8?B?WkRiNnNuL2Y1OTRzc25MM0doVFpDdEpTOEZKS2NDSDRXdk4zUWdpNW5kVU1L?=
 =?utf-8?B?ZUdxSjMydXhEamJOSHBrQ2xjVHdyRnlFS3pMYUp2T0RqME1qOTRmckVIUEJy?=
 =?utf-8?B?T3hPQ3NnbzN5YnhNVitwMjc2cUF3VXNTU2g2QjZxazZzSE1TYUNCa0RvT1NV?=
 =?utf-8?B?Q05HME1EVE5nc1UxN2MwOHd6aUZpS3QrZXdmcDQyWlFyajI3RDdzVWtFNkpX?=
 =?utf-8?B?R0hwdkNGK1RMZkl4OUJKSGdzSk5sZk53ZC9sNmtKUG1EblVSQk9tOGVtMXBJ?=
 =?utf-8?B?MG5jandtL3IzUTVFY2JXUGRDL25La05PdG5KcUhGdHF4Z2Zxa05ab3hyQTBi?=
 =?utf-8?B?OGhPdW1hczZUa2Vud2ZlWjhsRGNYb2w5c0s2eDhXbjZBcmI1SGJPUGdIVEpr?=
 =?utf-8?B?cTIxR2x4ZUtwd2VuNlNsUzFlM0FRUUx0YkNvcFZEaUJwTWgzTksxQkUvbEVY?=
 =?utf-8?B?TVVlenBGSjAwTWtaYzYyVUREUWdWcFJIR25HZ1NYR21nRVJvMTdFcXEwUUNv?=
 =?utf-8?B?elZIOS9hOUVPZzdXWU04VEtzemcwOVBoRGF2VmJ6WlBtSGl6YUxPUHRVRkRB?=
 =?utf-8?B?UEllOUI0QzJLb3JGbnJXcGh0Z2JYY1BVSXl0SE1xK2MyeEErUm8rWlFTMVhP?=
 =?utf-8?B?NkgrNXlEOVM2aThXSUZhQlpTYnF0Y3pkNjhzTjNWR240S0gzRWNQKzRXTmp4?=
 =?utf-8?B?Z3l1SjhWclNmM2tiUTlncm52OHF6YVhEUXVtYlZYaG01UVB2QTRpUDlJS28z?=
 =?utf-8?B?OVVmdlBLcm8ybG95VFhsVkZxZWNIOEFBYmRmYTZxM1NTUW52WXdlUTd2YXNm?=
 =?utf-8?B?QjlUVU5ucUM2WDArbFl5SDQzbTdaNGVsWmtaLys1MWxWSGVEY2pLd3F2eWdB?=
 =?utf-8?B?OURSRy9OUURlRkZHYXNUV0lvOFVaWVdOZTNJZm0wVGlCemxIYjI2bnFuczZE?=
 =?utf-8?B?UzJIQ2FHbzlOeTE1K1dCcUZUREdETDZDaHpSSTNFT01FaFl2eXRvTlArZ0tD?=
 =?utf-8?B?RnF1Z0hKZFdTNDQweEp2MWI3RmMyUzVQQmVpNEVQSHlSMU01SHNHNDJKR25p?=
 =?utf-8?B?ZlpCVHZJazFjbW9SK0hhdUNhUHQzdGMyUDcrWFJTNjdhYzJmU21nSk1QUTlX?=
 =?utf-8?B?aDNPVEJVekhDT0NIcFZLK1B1QkpMZXBMSUk1d3gvQ0tSdER3RGdIK2R6MWtp?=
 =?utf-8?B?WjNVQ3FTczE0L2s4R3FsdHJPQ2pxT25HWlJxT1YzVlZyM0pVRm5wMnFZR0hw?=
 =?utf-8?Q?UAgKyPoVgVY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZqN09GNUs3LzV5cm5rME9haXh2TUhoUGU5akw2M3N5bFFxcEk1NTQwRE9B?=
 =?utf-8?B?NWNqWE9qdHJtTVh6cEtRVGpFekVYQ1I1eGNVaEVoN0lMQk5vMDZhYllGRitR?=
 =?utf-8?B?d3ZTQWI4MnVkc2VHRGx2RVFXMWpXY0JtUisweFRIRitEbW1ZSmlXcm5pNC9h?=
 =?utf-8?B?YU9jdURBejFDaVFjcmdnemdic2JwRXBSSWNlQlovWHBqMFByWFBJSTZTS2JO?=
 =?utf-8?B?aEc3N0VsMEpOVkVmWGwwTS82Vnp5WkFSd29UTzdmajZiODNYOTU1UXozZUVH?=
 =?utf-8?B?MkJPTnl6YW02dyttM3hNb2FIN2NOU3F3dy9CaGNOVjRLRDAvMHBmcThZTDVn?=
 =?utf-8?B?cVFqcFJEamhORVdzQk5TakoyS2Z1Q1pramppZFIvYStZREg0N2ExQVByYVow?=
 =?utf-8?B?Q2pHUFZhYXh0akxpU0dOMUJEdXVlSWdjRHYwUVptajloZkI1Syt4am4reHFx?=
 =?utf-8?B?alRsS200QXVUWngwREc2bHEybWRrdjV2Y3BKUE9JL3EwM1FYVnRoUmF5UDdx?=
 =?utf-8?B?M2NTVXR1cDZUZStDY3c3b1Rzb3VvUldwdEdsVnlyNjBYRDM5UVdEcWMvVm4r?=
 =?utf-8?B?bGV6VUxNeDJndVNHK2JYYW9pOS95SUpMOFBTWlAyZXpQaXl3SXFMY1V0YVpD?=
 =?utf-8?B?TkNlM2xPT0w2NlNaakxrc1dYczhOQjVXZ3plbW9USFcyQVc5NmxYdXBud3lT?=
 =?utf-8?B?WmhUSnZFdFNDdGxvUUhIN3kzeTkrRWt3VDdMNWNJZVVVa2NYazYrNGJuR1pw?=
 =?utf-8?B?Z3VGT1pzUjA1NkRBcmdyT1BCUG1USVQwZDQ4ZENUWDB5REl5Z2dhZFh4N3Na?=
 =?utf-8?B?VWl2WGVRS2ZmM244dldGYjhJRVlxaElJdGxHWmFtbVlheEV5ejlmdFJmbmFj?=
 =?utf-8?B?NDFqN0M3Z1RaTFduWGFqNkpXUys3bEZlODBkbjNzdk9OVTgrYm5FWXpnY0pk?=
 =?utf-8?B?MGN5VS9Vb1psRHJDa3JWRUJFdGliWTZTUlZHaytNWnBZbkROWFc5Y1FtUjlF?=
 =?utf-8?B?c0VyTC9qS3BBbDFGdUpOZlZZZkZKZmFXNjNRMzNHazNIeCswU3I0MWVRU1FJ?=
 =?utf-8?B?cUVpUXlFTVZzOEJvY1F3aTVvamVVeEdWcmgxY0JGZ3NyQ2VkRUdxNkEvODVo?=
 =?utf-8?B?aVh6bFN0ZHVkd2lHOW82U3pnQ2JpbWZnODY1ajNlcGpTMElOaUFjbHkzOVdP?=
 =?utf-8?B?NDE3WmtIeENnUkhDdWtkRzYzZ1NWWldJNkRvMW9OSHJyUnZST1RCeWRvclJy?=
 =?utf-8?B?Y1d0ejlHM0VBb2RQVkR4dmkvQjMxUFMxd1dLVmR1dkJmdVBjNGZORWYxYmF3?=
 =?utf-8?B?bzZQRVlnNUV1SXdRcmw1a2h2WC95RlNhMVN4K2ZFUG0rRFRoRWZlaUhUcGFq?=
 =?utf-8?B?dElDM1ZzQlo3RkdwcHgrdXpJT1BtNS9yMldWOGV1Ujk5cThYZWpiU0dmbzRY?=
 =?utf-8?B?VUQvYnNkcThKNUs1TXlkT2N4d21GWXNhemZsQUVwNEdlOTZxVGd4eWJtcVJq?=
 =?utf-8?B?NmJYRGtvTnR1TmoxLzhZZWpiSVFvL2s1L0xwQlhPSldnRHRTVDFNRGF2d1BW?=
 =?utf-8?B?REZIUE90a2tZcit6L0tRNmVEbEdkNVFlMklkV2lQQWlUUkxpa0JsZDFVaTI3?=
 =?utf-8?B?WitKZ3k0K3Q1bzlObXE1NjJ4WDArSm91Vis5K2M3ZmNVbE9qWDVUUDZmdWxO?=
 =?utf-8?B?ZTZyb1E1TTdmZVNJY2pXN0tvUXhxRGFkUHFKMktEWTdhUHZ4Z2tFOExyQ1ZJ?=
 =?utf-8?B?N2gyQVZlSVZOZGtMV3dBRXoyKy9qdXA1UnVvODZQZ2w5SlpsRlpMNGNoMEJt?=
 =?utf-8?B?ZzVEdkJBeFRuRDhQWnI5bm1UYUZ4ZWxVajRITnNpTnY4NkdkdEtDeWdPR1ZR?=
 =?utf-8?B?TzIwRXY5aTM1L21sU0t0dXNEcmdOeFA3RWF5M2N0QUp2VVRUbCt2YktLRUNV?=
 =?utf-8?B?b3VKQ0ZWYjJscUtTenU5R0NHcHQza2NuSmEzUlBlT25XLytDRFNIenp3bTZ0?=
 =?utf-8?B?aHRDQnF0d3ZOMVNZREdPaTVYZGF1eGRvakdrbHoxRjFVcEQ5cVpxdkprZGkw?=
 =?utf-8?B?TGtuQ2hxK1Q0Z01tUHI0SHBkelpjTGtTdHJrc0h5MGE3cGd6Q29yOC9Ebk9u?=
 =?utf-8?B?ZVFJMmV1cTY0SkdrUGZwSHpJMWRUbWhlLzFiTnBXMjV2QVZjOCswc3E2aEEx?=
 =?utf-8?B?ZUdLZnJ1ZzNuaUFKK3prQ3R2Y1dwbWpobHZPMjh0dEZSS3l4QXNHa1l3bklY?=
 =?utf-8?B?TmZWWFZYekxTWDRpTzhoK2hkcmJnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97178e5c-3c10-46d1-1fc2-08dda808a5fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:22:05.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voaoHT8F6SiGIDZ5cvZsll4ao5+MPUCHInl5tErlJo8bVV/6NH9wV6pnxEbPexxjbkT/8PEEgiy1wMp8jIP8iowhf3BZjNxIxAAr0QYYPa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6781
X-Proofpoint-GUID: AaAoW8m2UMKrahZ_3uj6d4kIK8PTZ9-Q
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=68480750 cx=c_pps
 a=NE+w6TL7qZ80L3NA32co+A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=ziDZjbnpxu3plzmcov8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AaAoW8m2UMKrahZ_3uj6d4kIK8PTZ9-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA4MCBTYWx0ZWRfX2bL07rcBeJs0
 podDepviOlsIs41kho0X2m4xybnY9WeykZCuM1xNpu5S0J5rZwhezbtoAwsoSry6EaJDCzz1QD0
 LCo52gLyJlzm/c2aZWLBQLK66NTXWn8bZFbQ+6ee+sKTWVe7RnsnjEAv0/6R1pP94l6+zHjgnyj
 75CjPqgPDORQzRrIsKSNiCMjLCKkU3JG9fwojK+6J7mItJSqQt3DKwEHACz6IFjsKYl4AA5D8xh
 x3OBOJs0y67IHToyUOnJJp4ussmaHAvPjeIVquJwKN/5NI0g/tVHjlgfjQGsWF07lihu5LLKjgG
 bXB/5Ahs9jVa9LvT6jI2oj3LswZade6ZL04mZPv/eemfNvnpMVNKehk92RhCxWgOaXKJA0V/z90
 moUol2whzFwv5V1UKaeH5j4IVpwrKu8jzO7vYwwjZWXpHaLzkIjXzsodLrMUW+dyYxmHa/ZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 10/06/2025 11:12, Cédric Le Goater wrote:

> On 6/10/25 11:55, John Levon wrote:
>> On Tue, Jun 10, 2025 at 11:38:29AM +0200, Cédric Le Goater wrote:
>>
>>>>    docs/devel/vfio-user.rst       | 1522 +++++++++++++++++++++++++++ 
>>>> +++++
>>>
>>> I think this file should be split in several smaller files. The
>>> protocol specification part belongs to "System Emulation Management
>>> and Interoperability" section.
>>
>> I can move it to interop/ sure. Why must it be split up ? It's nearest 
>> analogue,
>> vhost-user.rst, is one file, and I think that's better for a protocol
>> specification.
>>
>>> We already have a docs/system/devices/vfio-user.rst which needs some
>>> care.
>>
>> My series adds this file. This is the user docs, including a device
>> example, so independent of the protocol specification.
> 
> ah yes. The QEMU documentation is a bit messy. Not your fault.
> 
>> Please let me know what care it needs!
> 
> sure.
> 
>>> (and functional tests)
>>
>> Mark is working on them, there are some difficulties...
> 
> Which kind ? This is important to have and I will be reluctant to merge
> any support without tests. It is OK to merge a dummy device implementation
> for the tests since they provide a good example.
> 
> C.

I have a bootable test image available for testing basic functionality, 
however there are a few issues with the functional test framework: in 
particular the test framework doesn't currently allow logging of 
multiple VM consoles correctly.

I am continuing to work on this in the background, and hope to be able 
to provide an integrated functional test soon.


ATB,

Mark.


