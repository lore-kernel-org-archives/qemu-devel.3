Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F63CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGzUw-00089E-Ky; Wed, 14 Oct 2026 09:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGzUl-00088p-53
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:58:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGzUj-0007iI-6n
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 09:58:14 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E7wO9p3014631; Wed, 14 Oct 2026 06:58:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bMjWdRXxtjv4GFn65tABCCzXTinBZVZXyMVJ/CljQ
 8U=; b=qJ931WmHysASO20LE0mdkczIdZS04aLfWroSJOM1t62oVDD3Nng0Aztxy
 QLBoElTXNr1ms7x4PI5oHBBi7w10kl1m3FggBNW7WeEzDpVSY6cEMqmiTBQ6ICTW
 7ft17K4O9bzEt/Dhs78zivRbK29y7GAJmwEQ8CvVdZH4HiI5SjPbxSkQ+NubF/I0
 GX89BxR03AR0XXucTCxZADxJsNySFGgjMnn7KwnWUzEOpVXwpZtQEMwPHf4sHwPL
 moBp2sLDgpqTe5Xf57d7TEhQObrbLR07w5zQ6KjOrxeVKv+R13BxqA4Add0mJAWS
 BwS5ZlKyAKbRMaZl6GBnQbQKM7wdw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021074.outbound.protection.outlook.com [52.101.52.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9pvvu4jp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 06:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYgWnoniDCEscDx4VTpjnlnVamlYOf9HMMxYEXg77J5FcleCSZr1zNRyX3LYxLfsAqfvyI0y8wQzYJcuTfxDLb24RRtUjWxB0au2O2wQ3LKxVZYOSATxO19oz495GbyvcX+Q7B4QsZL7NrzrZyxN6bQaFSduSnYyMfkKGFSwbfRLa5Ark2ERRYZLDdLvFswuHtCYkeN+0ROeOOaK5F7HJzpAaXG8Ub7Ce2KQ+ciIFEMr1Pzg0iSitRGppUeYPQBw3oSUZRw6y9/Sq76r0wmQlxxxDfsNXe8+gHQt5u+1n8RWvqcV3vWb+/z0ZXkF8WJiu7owIDQ3v1ZOy/lLFTUMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMjWdRXxtjv4GFn65tABCCzXTinBZVZXyMVJ/CljQ8U=;
 b=PpAaXgFmIXluqyDOwb+6ons4wGSNxgrXPM1RcBit0KMkSFmFdeNTZFKk/CCarZN8a6M7Zt+tD4c+X/rfUF9kjkcRy/nsuiH4W/coRuFVWD4yfTutY/BxVu26fmbFYQxaKii0whkEbKQ67w6MXz66Cl+gDCzUSGW7O7Tt2Pf2ccH6TgMzbrFm1C8KpCSX3YfcaYaGyJKbiiaUjDQW9AJSn+Au6LNci+wX3TF8yi4NN0chkqt3f9E04hOyPGAPg3ZyiPTVUVC9qExSX/YI2ktvGNu6qUSOpG1Nbgd71cn9poxLPwL4jLhpLmXiQJfevZilHsBVMFPLJxFusRKWLoz3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMjWdRXxtjv4GFn65tABCCzXTinBZVZXyMVJ/CljQ8U=;
 b=prlflYA5xKbQXY4uXcpyrpWa3MeoRN4GB0FIK0Ve/RX42SAZe9BSoJYv1Fpz/9xeCrnrQTpYWC1zPwrbhdUtfXIzDP7Ky3w1qaxCnAmiIChvqyhLvRDzlJyLcU/Gv57Lt+wZPDfeU8p7y2w+tj4m/Ns8oozYzCbhzdFmqaLJjIzp/Q6KDhon+vBjTGiBo2qXJxC/Iuakc5U75C12evuhaVCx348DZCAfH3zHT7f8MRU8h6d9lxUlKLYfe1IVnBI6PeOQmERtMCWaV7bPr9EzFi0wTrXGTNfxPwfaP8NAP3oGPuX7taiAT186y/xHJtud+I88d6YdnoO8Tnns817yZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS4PR02MB11308.namprd02.prod.outlook.com (2603:10b6:8:2fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 13:58:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:58:03 +0000
Message-ID: <ca07d55b-3a6b-455c-b456-8944459f051f@nutanix.com>
Date: Wed, 14 Oct 2026 14:57:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] i8259.c: move parent_realize from PICClass to
 I8259CommonClass
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-6-mark.caveayland@nutanix.com>
 <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
 <876b66cd-0ea6-4943-9a0e-c0abf2ad6e26@nutanix.com>
Content-Language: en-US
In-Reply-To: <876b66cd-0ea6-4943-9a0e-c0abf2ad6e26@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS4PR02MB11308:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d88314-ac09-45cf-0f59-08df29fb2a6f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|18002099003|22082099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: DiFS4kpry1GkAWUTN2v56O5lYV0OrhIJ6fixToVLMqjTdjkUCrTia2rIHJ27aTmRakIadydFcvxpxGkPsr5HYx1y/rPNEqbak4ffVOmmbiSiAWolc3XciWM/tfzAQ1n9tDSu1sjE2a70TJKGl7EkvUkMLqN7xvzLFkL6O1rDCVhlARb+g7sJj72RZXkYmw82MNARCwmubWJK+EDUw7Tskm/AVVK8jprfswGpDFff3TtaGLe5bMuS6bKolW4kTjAOYf8wZ8WetmMywwGDb5/3gOVbmwrZfe66sFXj+jHGigb2g2MAm6jiY5m8swh1y8Y4dmvNjqHuqDUi31FfX9Ywi7wJitYCckhsT8KY97BYL9KQIfZRt/+kR6pL5G+alwlhRCeT0dXJTfUbtJm8nI5P7uQqnge4LQWbH7E+BQk+SLhu0uKWPgO6PeFPX2V7G1MXb7lRdFEDIdXaMh1TcD+yNMUhIrSbIBNSWL1VL9z4U4iVl2g/GFwxqBRXiyAKWlATPeHwCy1+f7kGImg4U2b1GxXMoBwaKq8tcqtCgVDndj9tZLccgopdQGxSLFGObXEoGBEdrckh7eOxubSuUF3fpirqWHmUTNdWKlZOn2+3Ohw60BDiSzLAdJTwZSzG1BkswXjB5pFFJ5N6I7AaCt2CcnR9WM/4T1vdZCwdx8yGcOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXQ2MUxuQlVJTFlkZTZ4WW9hQTY3MXdZY3VFUitvMXBjRzUxclNuNDVycTFS?=
 =?utf-8?B?cm5RNXM3U1FmUHRLWDk1dHU3QmtTOFBhajdKM1lGMjlvTHdIT1QyODlOSFdm?=
 =?utf-8?B?cUpKSTNsS2g2NFRhRzAzUThJZ0NtMFdkVkw5eHF0QTFyUWx0bGxRd1A2RVJp?=
 =?utf-8?B?TkQ0aHltdkRHQnFibmRUcmZjc3RZZkUrcUdMQnloVlpDZ1dxWjBjM29RdFJL?=
 =?utf-8?B?bnBvMTRkTmpvaFNyYWt6UFk1azMxYVF5OFdNeWJEeXJ2VDVTVXF3aCtDREdB?=
 =?utf-8?B?YzVHbFBjZE1hd3FMYkJobTBKRHF0NGxneGZkcjBPa25qd2VPNVdNYTd3TGFM?=
 =?utf-8?B?dk5zTUcxZ2srbEwvQ2lVWitGUVgzTVh1MDFJZkJOalo1azIrSDRaYWErL0RH?=
 =?utf-8?B?cGpUekRXTXJKVnVSS1hlOG9IMzUrZXF4TDMvMk0vVVJoTFNxQW0rbkNza1Nt?=
 =?utf-8?B?Z0pLbTJFOXpwY2lTQ2RGdHFUYnBrTDh4L1lFUWs0NUdKakZUblEzNFRRbjgw?=
 =?utf-8?B?QXcxaG1SbGsvb2lYUmhEZXFjT09mUXkyblFTZXNwNjAwUEpFc0ZPR3JDZ2pN?=
 =?utf-8?B?NVVVWGFteithSG5pUE5vUHVNVlVNUWFHOWVQUnRQNFFVVzFTbGhmSTNIa1Fh?=
 =?utf-8?B?MkN1c0h5UzhtTW4zUWJweEV1NjRTWjFlWTNJek95cUUyS3FjOXhycGtvMmZy?=
 =?utf-8?B?UllsSytsY2RUY0d6MnpqbDlkT0ZLYnZxY0pGLzNRTG5CQmVBTlM3Y25nOTMy?=
 =?utf-8?B?V1pxTmNnQk9ET2U1QkJxSkNjWFhJeXYycXhKTHBhOHNSUDFzWkszZnJzSlRq?=
 =?utf-8?B?VXdEanBuSS9sUjRRYUtsdWdBUlZXSWdVcGdFVllTTVJGRkRVUXV5QnROOUUz?=
 =?utf-8?B?cWgxcjBzRUlnQ0d5ZUxWakdTeGoyL013dEI0YnRWVVJGL2FrVzBBSU9DZHY2?=
 =?utf-8?B?Ui9LeW80M0RMTCthclU4QkpZOFRNUm93R3NkNWd4YnQzUVB6RWE4UUVhVXp0?=
 =?utf-8?B?U1dTNm0zYU11aTUwaEFNVFNFYzRsRjJoUDJvdHIvTEJRZDVndGdPcDVzZDhN?=
 =?utf-8?B?TUROanEzblUrNWRURFlaSmxrS1c4Z0tlYW9kZGpOcmMvckhObjM5aUJYdGRk?=
 =?utf-8?B?eTdTQ1dUU2lVa0VZYUhneW83cGRoRHNOYTRWamtXZ25lNnU3d0ZBT3VBZDRX?=
 =?utf-8?B?T2xTOFNzdlVVb2N4US94b3pVd0VRSFBVQ2dPV0lWcWtEZ0pycW9ndDl5N3Uw?=
 =?utf-8?B?NnVqcGZKWjJtRmZpL3Q3ekZtdDBsTkdDa0NOYW1TcW0xTkRycWVPOGJuQUdl?=
 =?utf-8?B?cEVuWHprS3JlVE9NQnJtNmNGUHhkTnptTklXMFpqUk9IZ0l0b0NhbHQySk1V?=
 =?utf-8?B?Q1Y5U1F6am9rcTRia01JUkQ1VjB6OUJDb2pCMkhNbVJubjIyQ3dGbHhKQWN5?=
 =?utf-8?B?dUNBd3BBQUFlOFBHVjVuUitOakNHNGZTQUpXZ1JRZzhNQjhPY0kyWmtDVzlQ?=
 =?utf-8?B?dlFtazExSjRLcTdSL2FWcHhoaW9pL0FpS1htY1RqWDgrVnVoQkozUUZabHVi?=
 =?utf-8?B?NmIwb1p5Uk1RWUVFOE1EZTdycjU0bGtLL3RKaDZDalY0MEtLNWYrQWlmWmRu?=
 =?utf-8?B?VFRocjFkRFVteGFnT0FMQ3NvcDhDeU1kVUVod25ydGd2Vkl3YzFVZEFscVpF?=
 =?utf-8?B?QitDNTJYN1hvdG1VMjN1NUY5eVNUOWg5bUxQeFpmMFFTZjQ5NVdieWsycUJJ?=
 =?utf-8?B?cWxRTW5SUTRjd3N4SUQrWmR2SVdwclBZamVVaUVTR3ZXM05iR3dlSytxRm8w?=
 =?utf-8?B?VDJrSEpRNG9NWjFlVnVicjlTd2FWQmpUb0U1UzFkSmR3c244QVVvL2lpNGhZ?=
 =?utf-8?B?eTdXQlY2b2tSSlpuZVQvNlBFVUNEZ3JQUXlPaWtndGtsL096UklOYWQrWi9i?=
 =?utf-8?B?bUxMZmZpak5nQ3QyVHZoQ3RYSmVrV2l0VlhSUFRCa1NNeURydU8xTERmTmJs?=
 =?utf-8?B?MDBoR05BdXdRQlhucVptRjRDQlVsSDM3UjBYSy9LU3drdUhmb09YUXMwN1FI?=
 =?utf-8?B?c0VWTzQrT3BXQjVCSlNDemxsOFNDS0VkZlhTQXBEak55V3JmQWhnQVh6QzVB?=
 =?utf-8?B?YlhFbkk5Ri91VlpzT1doU0lWeDdRU1ozWlJBaVRRZks0UnF6aEtmdWg4dXlM?=
 =?utf-8?B?dVBuNXZjZU8zZngzM005d0pmY0psbDQ3aGZrKy9RWEZJZTk3U1dDN08wdWlO?=
 =?utf-8?B?amV2Ui8wSVE3clk4eXg2NEVhdjczdVlveG1Mc1cydHQrNkVMM1kyVlZXRm1G?=
 =?utf-8?B?cGJ2Z3VrSGs2QndVS2Y3NVRKQjMraWdSYVdjR2pzeUF5QTlaUUptellmc3Zk?=
 =?utf-8?Q?Y+akJqVJcVcCJQcU=3D?=
X-Exchange-RoutingPolicyChecked: HsefsZCZT0YDPVzxWznzQTyeLmtq3EkxY++FAmAgE4D1RBCOExgIntOvJFv0te4zjmvm/2ii5UAmHMdSU3PeTmWq4kKRwCjBD7UT99+9kScdPeNUVmFzpBGbiTop6cGyiBLFZql6I5vTcsGp0iFeh0LXan1voDUAbdYRSOtIZsc3d/684ts7FdHIa3t0bKjA3nt6fWu9m3qj446AARcaZ2XTrO3npvyj+bCIxkK8CPm081jSXcj8keAlhmt8eTJxquaaaD8+GgxpqiiPm3o1U+uslw5alMkZVJ/vRN91q1FNkZBle5b01bIyDvFEXuqNQdJ72K4+a8noLP5ziNb+nA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d88314-ac09-45cf-0f59-08df29fb2a6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:58:03.7332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zzzIxIe6kZSPa/ZUous/AMhsfwdbppoYtpvsw7R9u9lOSuHUnC7JGL3pocfBG2zXG8MYlBt+EOscpkRM7NnY1alJiPFM7B3zemTywpWOvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB11308
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX9GzzQXRgQJV2
 hOxZSvxT8CZPBSRbFIoZqQ+KRbW9qMt5ou66054SZ9u+UBVAiRFKDYbWtA5xPW0Qh4J0Dm/aC2r
 DC4W8C5Lg/4fJKQ/zbhkhFV0D0dmacA=
X-Authority-Analysis: v=2.4 cv=dfgVTnXe c=1 sm=1 tr=0 ts=6acf8a6d cx=c_pps
 a=b/aSlx19e507fu+kRueGxg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=bD7yre_yaOKMDD93RBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WWEwIOaM9Ilu-JSXUqNjNVxZXw3aVIx4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX9/JFe+Qn0YG8
 rDvXLsMPKMLMSPbPuj4tcMuug8eO3xtIz4SWTrMhm3RRbKuRPWUZcooJv/bVC5RChkAULI1eDqJ
 pZLCM3fx49A2YmJhj4oeoDz7ZbhFIRWXQ92q404dfzv27DlFK/PDvjxbPB9LdO9k9cU3yfc4N/L
 SZvccj+MdvImEiwNzd6nNu1aFjwVMUEqiGwSXsyvGSPp5n5phtjbIpMYD0a5M4rhq094V4HGdo/
 0c5oWgNtgu1oLtxrl3axkKZacteLi8F3yNlS8j/M2Lu4IfW/wJWja4VqFuciXkhqJK25AKosAYU
 hYerJ07XXV7s0GpIFGg7AcgAUGgGxfJismkJQ7M2q4BdvfOKyRtTtlOJDeFJC1maLTyYN2yKNcL
 wBfseGTqVdqPFCEJD2Vecg5tb8u0T2kVcdp7I+y9/yxa4bAs2Ftn/TyyFMyvVxK7R6QvIK13e9m
 YgOJMn3wc4iRxmzuVzA==
X-Proofpoint-GUID: WWEwIOaM9Ilu-JSXUqNjNVxZXw3aVIx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/10/2026 12:00, Mark Cave-Ayland wrote:

> On 13/10/2026 16:54, Peter Maydell wrote:
> 
>> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
>> <mark.caveayland@nutanix.com> wrote:
>>>
>>> Both the emulated and KVM i8259 implementations store a reference to the
>>> parent_realize function in their respective classes. Start by moving
>>> parent_realize from PICClass to I8259CommonClass and removing 
>>> PICClass since
>>> it is no longer required.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> This is one of those things where I think we're not 100% consistent
>> about whether we think the parent_realize field should go in the
>> child class struct or the parent class struct. The name "parent_realize"
>> implies it ought to be in the child struct, though, and I think we
>> do that more often than we put it in the parent class. This also
>> makes some kind of separation-of-concerns sense too: it's the child
>> that knows (a) that it exists at all and that (b) it wants to have a
>> realize method that will mean it needs to chain back to the parent.
>>
>> The docs for device_class_set_parent_realize() claim the parent
>> realize ptr is stored "usually in the instance structure" which
>> I think is just completely wrong.
>>
>> I could be persuaded otherwise. As usual with QOM/qdev, I'm
>> mostly interested in (a) consistency and (b) documenting what the
>> "right thing" is. Realize, reset and unrealize are the three
>> methods where QOM's lack of convenient support for "child
>> implementation of method will need to chain to parent impl"
>> is most awkward.
> Yeah it's a tricky one. This patch was really just refactoring what was 
> already there, but I'm open to moving it into the instance if you think 
> that is better. I agree with your point about the child instance being 
> the one that knows it needs to chain back to the parent.
> 
> I'll have an experiment and if it looks good, I'll move it to the 
> instance in v2.
I did a search over the codebase and checked all references to 
DeviceRealize, and they are all stored in QOM classes and make use of 
device_class_set_parent_realize(). So for now I think we can say it is 
the documentation for device_class_set_parent_realize() that is wrong, 
and I will leave it this way in v2 of the series.


ATB,

Mark.


