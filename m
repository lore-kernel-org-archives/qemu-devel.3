Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A812D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjhs-0004V3-H3; Wed, 03 Dec 2025 05:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhq-0004Tr-V5
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:30 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjho-0002ya-VY
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:30 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37xXUX834742; Wed, 3 Dec 2025 02:03:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Q1/AHynZsPpO+
 eLxfY0F0ypTV2KKOFwjkoRqe3U6nfU=; b=GLIezZO0ZPX9qGFh9vi1LHB9e2T83
 dtEiOeYrAM/r+AWdU8rzvumvEaLH/y3EmeVoYc22tcayOY7o4PNTox53yMWssjQg
 X1JpfgUelt/tMobMSXriur1l3zFoVLuRNrTJcctuI5spx3pMM9aKpYIcPGYkVLkp
 gWVezt89kSF/9jutMaB2REcuiqME4O7NSnzyuI+kPZvjranjaPkofyeHZugkz0I3
 vCyI66xVB30TKZUbdjTfXOnipL8aJ3za6ahXWvqr6TKYirgrOQEgfT1fDVDhGC1Z
 J4YXh1pv9OMBNHL8Ogf3GJfVBUyi/MeeoGzifVoPE8qOm1cHGhR3OZvGw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at4909wwb-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ6L7b2fyYXbrIUBuilT6mQu7Jq1n1L+MQhBNl3+VTh1wEnXX+o7U0B+fDI8o97qe1dazGjFm2FORF+60yb0H7Olf46cKRr8JrL7VIhhKS9fUjWLdWmZUMslQV6yZYde4vST4SH19vtxSR1zK+nZvHfpgAmBwPd9k9rPZ29KfihCbkD2oj/qL1bTqrvtoIhcqz4jx1eTJFhm+PHZu4yAnC/ZQ84uabya9pCcckR+I0+OnbbbtNa2BZCWStIId7XUVhuZPxp/0l7M9RDAXxZfFqGvrRMJmXH+F8CYW6u8tB8dh/namPBEn9sGmcUQz1TCQfste1TSnSkEKAYgZJok8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1/AHynZsPpO+eLxfY0F0ypTV2KKOFwjkoRqe3U6nfU=;
 b=Gwqwcqc+0UqvnTVAy8L1c2L6Wh7IvyzLQDL1LHJg5zjovlq20h+f5W02tTqAD3sy+LxP47A3xveS4QgaoRP+/uadtxY03L9gMp8E/2tP+qgyMHTpySutQ4iRKxLn59XeXdr5uIa/RhbISVBkxWdmT/MFKy0o8xJjr3a9+RqiUMrOjZSihg/BrJZTaHyuyHMRvy0O3O68xK3SNbRotrrfjdF24KZMukgAT4VzB8WFhAL8aMik9xSGg32d2yx/7Qf7AvFCaz6sw7yImAhqZkx6pzkoZxTTYAVIPYc36YkEtWhN5EJ7lVMrU7UbXUaNe8mBR3Dxb9HBGUm6nH2CtMS6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1/AHynZsPpO+eLxfY0F0ypTV2KKOFwjkoRqe3U6nfU=;
 b=a20IOGbdGkAsy2/koQYz7jSkq0cfv2Avh9ia7rCv4yaQx3CC3JDmpeqNg6nrDwP1JbuSd9PEziPLpmCah5JfAOTIaKih6A4BFFesp6MIiqy1a7mx+jyT6BffjwzkgVE1d1nu85261pQ/6OXAA5EIC7e/5RampA7AjdHWKI3gTGDXixL7fhqXN6nDhbBuHhC/f+Wi2BmZpRaTAHj4t7IKMRwYEaFAcMIh7Gmk3VjkbrqF2sbUjzqNexC+UEVLalKoSc1dlfxJc/OBTIcpaZxeYFJFtYqs77ArKAzYnmvV2ZeYkJbp0ujllL4Ib5yA71PKQ3o3Oi8RuCOi7iJkOsJS3w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:19 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 0/5] vfio-user coverity fixes
Date: Wed,  3 Dec 2025 15:33:10 +0530
Message-ID: <20251203100316.3604456-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4a4c28-8abe-4993-baf6-08de32532f56
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEZHWTFVc3FMM2xkUHp2c0FSalZrYUhYaEJaVjRqWFQzT2R5elJrYTJYU1Q3?=
 =?utf-8?B?K2hhNjRycy9tSkpISkNSeEl6SFowZGlhVGkrSVNnZ2JUSWJKWWh0bXBsRW1X?=
 =?utf-8?B?VjdlRXNnb3NKUGhCNWIwR3pwa3U3OUh3QnFPYzA3Y3B5WUh1c3BrMFdYeTRF?=
 =?utf-8?B?djdEZmhwUkcrZVNHWDhKVVlUemtZUEMzYjAzR1dLZkNPR0RuR21ZVW95MDJX?=
 =?utf-8?B?NmtyUk5JeElXTWdkZ1dJRE9FTVNlUmxCRnVBamZMeG1NeHZrcGtkQVZHZHFY?=
 =?utf-8?B?c3kzK3A4N3VtTCt6ZllrWHVzT2EyU1lndFhNNXRpSThBb2lNTFY1RXBubFFq?=
 =?utf-8?B?RHZzN25sK1c3K0w2ZzlDV2lmYlhYTjBQRFpHOGRoVTJEcSswNElRTzBGallX?=
 =?utf-8?B?ZzhQNnRLZWo0aHhSNUFVL0VxSS9OeGdrNFpDT0VINUw1ZUp0NUoxd0REL0ZI?=
 =?utf-8?B?RGd2M3ZDejk2blZkVE9rNlF6N0N1RFdoTG0vNnlsbXJQajVTTk9vdDBndytR?=
 =?utf-8?B?emNGakMyOHJJMGpLSXhIakhtdHdmOU5kcGVzRWhjYVFkK29oOGFJN2FGdGVM?=
 =?utf-8?B?RVNYRHZFL0JldjluRE84YklOQ2NmRExkcFRhbnpCUGVGeHhnN1NDRURRektC?=
 =?utf-8?B?bmhSVFpyWWZXMzl2Z0pmUkZpczlrQ2NSRERDbjZKM2I0akk4WE1JRFliYVZP?=
 =?utf-8?B?ZVF0R21kclJLbVZoZXpNY1hEUWt5ZTM1MGxUWFBZdzY4NHpnUmNFUkNCWU01?=
 =?utf-8?B?cTFPOFVDRHE0dzJDNE5UbkNCbVkxZGRLRnJYUjY5TWF3ZG8vMVNRK1k0alVn?=
 =?utf-8?B?K3drZmU1T08wNmVtS3dWWmpJbFdoaUt0UGQ0ekNJN2k1L1ZQTzlQNVZyTFlj?=
 =?utf-8?B?QnY0Z3dYTllBUUo5VHJrQmt1WXJ5V01yejVoa2NUK3pVdW83SXhqOTE1Y1pV?=
 =?utf-8?B?N3FqczBnNnRLQ3dVSldpcDdidDg3ZVlUMVo1WlFML2dZM1MzWWdMYThRWkJi?=
 =?utf-8?B?Zm1ncHBRS0VXeVEwZkM1MlIwRGJqeVlRM0czbWFFRHBpZHNzSDJ1d1BCUk9J?=
 =?utf-8?B?bXh1YTBUQ1RTNi9kUGw0djhwTk5hQ1ZvY25aSzdqVjBqWFpwWFR3WXptTDk2?=
 =?utf-8?B?MWtNM05lc0dOdlFNM1FYRXJOSXdma202eXRSRlVFTWNPREJLK25WWGxLTTFt?=
 =?utf-8?B?OXk1NXQyKzJhSHdvYm8vMnVqcTZMMGZSa3Fmb0wxNmRjOHpIdVFxNjI3UTVP?=
 =?utf-8?B?ZzJPTEs4Q2VqdXl0NGJSK3VXTUNIdGJrdkVqeDdaZ1UyZndrdkQ0MTVPSml0?=
 =?utf-8?B?OGVsUFVnMko1ZHJkRzlqUVAzdHF5a21sN1Fydm0yRkF6a3ZDNnNpWXpDY3Nz?=
 =?utf-8?B?OVpKdVFCQ0MwTjkxSlZGVCsyaUp3cTV2aE1zeVNIRCtnc1cveHRLVW9CSWZl?=
 =?utf-8?B?Y0IvaCtydlRvSTNJcjBtTGpvTjF2ZU9qeVpIL0JUVU44YzNEZ1Fma3Q5aHMv?=
 =?utf-8?B?Mis4aUlSaDNtZmZOQ3lBQ2ZYbnlnTFFCaHZRYk4vYzZJb21JYjdFNmp1OGty?=
 =?utf-8?B?eHIzejdGSFNRN3I5aGxtSzF6WnJZZGlEVHZuMzRNVTZzb2dkUDd4MXZJK0hP?=
 =?utf-8?B?MUVhYktkVFordHJZOTBBUG9rYjZsWlhwbUJFeVROYTZacEZNM09nZVBVOGlT?=
 =?utf-8?B?NHlPUjY3K0RhVll5OEpyZVF0OHlqUTZJVWpJSjRyRnJUNXJWTG96elNiTElk?=
 =?utf-8?B?bm84QWZRV0lXM3lNTVZoQWpGRktWQnR0RTB4Qmd2TzFqZy9WbUdLTU9tNWhB?=
 =?utf-8?B?Wi9sUVVTVEc5Nm4rVkxHSnY0cHMrNUlmRHI2aGEwM2xiMmZ1VnVGNFVFYmJ1?=
 =?utf-8?B?SmxySjZCWjM0ejFKVHVJZGVIeXFHdUxyWFZEUEYwRnpROEplK2JRZTZrS1d1?=
 =?utf-8?Q?dKGnZX5w9uOwuhjeUut403yZrT61Ffmv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZGSXdKNEFzdWg2TkFka0h6di9jVklJL1NmcW5yNENLTDR1ckF3amdmNytq?=
 =?utf-8?B?TlMzczFVZkEvbE1ITWVqN2cyTjJ1OE8xOHJqZTFxZEV5LzdCSCtWMG9NbW4z?=
 =?utf-8?B?ckV2VHBYRVJ1SXFsYmFSWTg3aWVLZEdHcFcvVUlZSEJHYjBlR0lyK0tsK1dB?=
 =?utf-8?B?YjdzdzlINzZacEM4ZmtzMWtwQzJYSXlCVHBpRm5lQk1aSlZyTVp6TU11QkxZ?=
 =?utf-8?B?Q3UrbFhxdHI4MDJJclRidE1xaFZoUnBzRldCOE9udHo1MzJ6S2k3VXIvYXJ2?=
 =?utf-8?B?YmpLNW5nQlJ0QmdTQXdlczRvVytTakRMWC9rSSt4ay9oWEEvdnpvU3VNMzgv?=
 =?utf-8?B?MnBZaW9GMDc3TEllazBCdXRNcmN5UGtJbldhWmNKbnBXSGxBa2dyTkg4d2pj?=
 =?utf-8?B?WVJTdXVOb3JuRmhITFN5N3VBeVZ4Y0Y4bzM0bDk0VkpvMU9Kc1plWVErNzIr?=
 =?utf-8?B?ZGNtc2pSTWkzbDlBOS9kVFBtZ3ZaaGxhU0ZUSGM0N1M1N0wwekRndFEybk0z?=
 =?utf-8?B?QTRJTjdPblVsbUxNaEFYZi9PZ2xPSC9sZEhBQndYQTBiM0J5OTFDS0FUdlBh?=
 =?utf-8?B?YWNjUGgyUDZuMUYyLzY5aGY0ZmFTRUEwN0JKdjNqVFM1cmFEUDlzcE9BUVRs?=
 =?utf-8?B?RzBBUXNiQzJKdTczaVdYZzdkNzU1RkZTNDFCdWF4N3QydlNwSk5YVVNQVXdt?=
 =?utf-8?B?YkdSS3RCcWZ4ZUZmeVlkMTBSUVd2NW1YWldtTG5lblUrQklrTlMxaEZFdUFo?=
 =?utf-8?B?Y2F3WDA3ODZOV3VQRjdidzBMSVhQNHJUTkZnbGVvR3dPd1dERENBc3c3K3JN?=
 =?utf-8?B?cFR5M0Zudy9LUUlEay90ang3ZmlRbFNGR1ZuVUswdkk5cHVtYVZjRDVsalht?=
 =?utf-8?B?VHpOZjlLbVluMncrNDdsMnUyWHVpRG41SmNoZ3hkZFoxNUEwYUpMT2ZMMjlC?=
 =?utf-8?B?UERaMFZ1YmIyMTRjVkluQndLUzhQU0xvNVFOMkNOcnFLWWwzdjh4MXBURm1n?=
 =?utf-8?B?SUFoMUloUnVhM1ZMNUl5cUcrb2ZKYU1Tb3dzSjdoeXlMNmtKVkpvZm5kWE13?=
 =?utf-8?B?YUtteWJleHV1bkxGY3YrWTV4bkZ1NWJvd1ZVNmxVTmE2Qm01UWplSWMwT2Jo?=
 =?utf-8?B?VTBOenUxVXA2R1IrZDlZUk1MenVWdENQQ2ZlWGo4TExJUjdyUG4yeUp3dVd0?=
 =?utf-8?B?RDZIZWNEaDg1UEwwZzNKOStUZ25YWGN4R2xtcEQ5SitZUWkvVlo3d2tRdFRC?=
 =?utf-8?B?QnIrMjJKanpWaElsNXB6QSttckhWV3VCMFFDL1FnblIvMHVjcFF0M1pBY0xt?=
 =?utf-8?B?SXRVQ2Z6U3hZSEJqdUxERkxPTnBmdVYrRWpLTHNIa2ZaK1VMVkVwdTNYaFJ6?=
 =?utf-8?B?MjczQjVEak9sQ1pqYXM1L2VSRjA1VUV4QUxCdEdjZWFYazVtN1diQ2x4cmVT?=
 =?utf-8?B?STB1ZXBvUXJNTFVlSXFoOGhDQ21lN0VFOVI3clUwaFpWaVIwNWRLTFA3WEZk?=
 =?utf-8?B?dEVUMVdzeXdjMTBZWURRaE5XRWpuRzJheGcwWXNlSE96cEYvamxyUnVVUE51?=
 =?utf-8?B?Q0tESFRTSFQzYWtYdlg5dzNXNVNILzNYMTlzWklFS2RVOC9zdUE1cWQ1cXZq?=
 =?utf-8?B?RERFamtNZ2NTbFBoSXdFRVg3TzFpOFRnUVlITSsxeFZLWTA5QUxUaHE1cThD?=
 =?utf-8?B?OUFxaHd1aDRLUVBTckJUak5QTytldlkxNDRpMkpMT1d5Y1ZWUDloNTVyOVo3?=
 =?utf-8?B?VDlLOUx0NFE5azhDWlMzOE1CWFhZUzBTNDdsZHpCZm1nYTFuem1GeCs5VERO?=
 =?utf-8?B?SHpTNFR3LzNNWWxvbFJUNEYrYWFhUHZDN1FvdWd1UFlpQzdxdlpNdWJmU0lI?=
 =?utf-8?B?aHk3Ti9ZczcrdE9KZnMyL3BCU0ZXcENZQmxwd2NZRjdaTm02N245b2k3VUNU?=
 =?utf-8?B?eThEc3MvaldIdEdEY3JzZUltU3dWNDErTmFKZUFQTnJYV1BzRkdmYXlVVFRV?=
 =?utf-8?B?ejhCTlhKbnV4NjhtOTc4a2tJU2duMVJFclRldjQzYWFjdW1WeEp5bmczTnFk?=
 =?utf-8?B?bnYyZ281eklyTzdibzJkTHRSMm52ZWhyVFEzd05LYWhyWk1DRjkxS1hqUlQ1?=
 =?utf-8?Q?jgyhFxExDozwNR84g7eM6/+US?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a4c28-8abe-4993-baf6-08de32532f56
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:19.3877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9F93EoQqp0vH4m4eogCpwI9Xu/Lxj0wVEiBxHVmfUamN9iVosafsSuH8D3mfKVKUj9eiOrd0oqkzm6868H4zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX87IX7KWcPW0h
 VwPsjZaFbE+hEfPRvtsvhNm8knO0Y1JB348FW3EbPzR7ztaiSQXeg2S2nUQcK0vKYaL08dSlqdG
 4dt5JCaJ/U2EZugv20nE3xFp2LRjpH3lsUeBUNbw9LUx5gKhDZ8VJrpIaAwwqRP1pXFMsslAi30
 QEzmROb7rFw5+hhtLBDlsd6EuDujvobG4BtQMBSpiwDeb1WueADW4DKclnKtscbIRKN5wmWT24V
 QmHCtPQbRcsdUnm0G+OaPl+Mh5fE7kDcl9OkgCRio8rS3YSojINsMFdDF0PwMZ7cd6Wpdypkmf0
 /xtpD2gj8Dl/ReKuwcLHPCkyueI5x3KDzTYk1MJOY5Sx3Go/4KRVpI1zHu7Y3CuzjQ1zVyEB3F4
 K8mPoQmL5HGWwRcLru5/Z9uB4sUq8w==
X-Proofpoint-GUID: 7teevPLZwAgLui0SfVrtvvC3G6P3VrX1
X-Authority-Analysis: v=2.4 cv=Gu1PO01C c=1 sm=1 tr=0 ts=69300aec cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=61wL3NVAMDne11lxUa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7teevPLZwAgLui0SfVrtvvC3G6P3VrX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Fix some coverity-reported issues with error handling in vfio-user message
processing.

John Levon (5):
  vfio-user: simplify vfio_user_process()
  vfio-user: clarify partial message handling
  vfio-user: refactor out header handling
  vfio-user: simplify vfio_user_recv_one()
  vfio-user: recycle msg on failure

 hw/vfio-user/proxy.c | 206 ++++++++++++++++++++++++-------------------
 1 file changed, 114 insertions(+), 92 deletions(-)

-- 
2.43.0


