Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8u-0001Rh-A4; Fri, 04 Jul 2025 10:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh8A-0000ts-Rm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh85-0004mj-6A
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:09 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BwILM008977;
 Fri, 4 Jul 2025 07:11:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YYbtmE1+GHQjnULpG/tr/Rcm50r9ACOgbDgPXFNfL
 W0=; b=gUP1TWDBu//y1XyZCkUlgSkiid3XPB1aP/++Jr0kBnbhQBprJOKI5mne0
 lVePKLfYwOvjsm0/AbJakWa/fSKpEIvXVvt5h24Q3CZpdZyDQ6+upnGRLXrtely1
 yeFuOtzmewl6OclDcfB/vdqVfoKLPgveVFaxwTHIzKHhgfFqyQu4XN618qNAnAqH
 KPouDhb9fj0hW1L8gijocdLYZd/xNFZzwL4UFzr0YtM/ODqHswviU3LXT8hyyuLP
 NdFpZN9yNH4VmUZuN6/URFd0LBqUT+7GdmTygoDN2OuVF4MjzGs4Rpx4BoqD4sky
 kl2ugAwQaaAJjHWQPMXsVxrN2a3bg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020081.outbound.protection.outlook.com [52.101.56.81])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47mhw30fua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym0HgYMyPZIGDMpTiOb1DR5d7VD55p7ARL9GfAaDkmhStQ9WI46gpRnMBoPcc7e4zFTX3fyzt6LdEHTioMr55nusOT4Z/HV82rY+a+TSAsdFQ0+4CW098qK2lqh0Q603HSBKG61j1YGGc99jDveY7Dl+jZsl4/ZT47vjpghhMmbLgG0OAH4IcyqLL5Ma8DkU223t0k/DPjXGj3nt3FdVutCB5Akti2dXujrfsLfsyf5FUi8T+r/Ed62m1sFTqImUr2BQmdBve3B32VyMnx/2LZwOAVgFEH6km4G3syQfE/TKvk7JjwTY9kk0H+Z3MNQ3eDuZzUVXRTYW26+rVxnMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYbtmE1+GHQjnULpG/tr/Rcm50r9ACOgbDgPXFNfLW0=;
 b=IufH5XD9THFzGt58odGCoOrtOfg/Zjqt3wjdpX08iF8RjSfdSgG3mmUReo3Hi/NPomcz01/6KhSF28Odh6Px002Tl1C7xUfML/TS4JQsWxYUNU9mB/CYDRT9PJSplfxsnJilbNzt/spwdGbQ1VFwlv4Vucu1VAzU71ytYKNBjEI2C9v06HZwumKMmVJtT4sdYhlN8H+RSlY/GkUQ8+zOGiIoaC4ulOAEIOZQjOAjVCQJqwHd5l+kw5xVSgMbeSPgtPwo7Ik//udeHPPs6s0560d0hg+ATAEJXRUYw1O8/srvYEbnft0GGo90h6EYoef8SPJtHdFlkjvWJ6qlFNkQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYbtmE1+GHQjnULpG/tr/Rcm50r9ACOgbDgPXFNfLW0=;
 b=dtYewxDxFuOTI1apzUNliOXZG1M3PUEefUUCeZs5RD7Jo1Tu0ToUwChp1OfhhH9NSwtKaGuWTtF/cwP8VYslYBpPIZc7ulNr2hoaiChpFizaJ/nVOUkZZrkzJ1lPl437Mvo+NyU97iv4Al27pKdLROC7EFlA8yRG6IdiSXk2nGQigEc6WieHMxlVKHC6De3x2Cho2i5v6p/30yhlGWF7odlpHMnie6KqcDKx4X+g1gqJ3wkT6VICctoNh1PKsl4lwTgTGcyoqPQ62iidvAYDSBKWj/tHfZ7OlFJqlbsDxbH4U3IjQSVxoYtutshFncc48w8y9aSlZkiYKaOuBsg/vg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:10:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 10/14] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:37 +0100
Message-ID: <20250704141018.674268-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0217.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: d6004e13-69b9-4ee9-2fa8-08ddbb049943
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWRBeWR6dWF3RVN3VkJwZkZXbkwzY3dJbUtHTUtaNHE0VkkrNkdZOU84THFw?=
 =?utf-8?B?eWtUMDhVVys5bzdRcUlQS3prZ1IvZXFzVU9IeThISnJJZmRBWkt3WU9kVFhQ?=
 =?utf-8?B?RkhJbkkwVWRGUHU5UkNhcUk0WjVMWHkwNmhlN0k1OGFOYXVTNG9NWitoRmRu?=
 =?utf-8?B?R2ltTFJ3MGF0Vmg3VjZTSzh4aWJENm5tQjBVbzZOS0NCYm51OFJaaGRnK1R4?=
 =?utf-8?B?Q09qdFRyMHNrcnJQa0M4aEVkemdoOVpyVEJZcXIvUzlqRnBlWnVOeHltclFn?=
 =?utf-8?B?SWtTSU9JMGhaMS9TNkRORGhmYzZjS0NFeC9YY1ZneWJWVUJSNFdtUWY1T1Fh?=
 =?utf-8?B?MGJpbGhvNWJnSEp2ZXUvdkNJanhacllScllhc0twYnJ4SWpJQVk2YVdGc04x?=
 =?utf-8?B?U1Q5N0hIVFFzUFQ1VTJaUDVUdTcyVmlGemZ4YUJvVnF6WWtxd2hxcXNtZUdM?=
 =?utf-8?B?dzFXUldRaW5IQjdmT2diSXBaQzk2MDdhajl0UVo2V1NyTjBWelNwWXo0elNl?=
 =?utf-8?B?bEJuczl5b0l4dDhPWU54QzBxUU5QemtzSVBWb092UCthRk9UNXJyRFFuY24v?=
 =?utf-8?B?QkFycGpybUl1WFdVQXZ6cVNBQ1Y4R2lURGhlY0M1MGgyWnRkeXI2YmwvVVpk?=
 =?utf-8?B?T05ubGRwVnU2RXhlRmlXbFd3cFNES1dGeVJrSWxzcFZYR3pHWlNpcmRxdXox?=
 =?utf-8?B?anYxbFFNdVZjUmE3dEw1OXJqYUNFWU1oTGh4Wjd1blF1K0xXYjErTVNXU0d5?=
 =?utf-8?B?VjgzUHBuaC9Rbm5mdEJka0tyUG1jV1RwQzhwY0t0VDVWWTQ1cnNKUGVLUm1j?=
 =?utf-8?B?S3Y4T1FrOVdnemhiZUNyd0xkRTdqM2h1cHlQc1Noemo2SkN4eHRuY21BMWNh?=
 =?utf-8?B?bHdsUWh1TlltT0FoQlNBNjBjd3dPRG1IeDcvNVZhdWdIUkhyT0pmN1NHSEx1?=
 =?utf-8?B?S3hVeFAzRzVaQ0FwQWJpSXduaWJNa1ZHNVlxNnhtY2lxUUpMeXR4bmw0MXZL?=
 =?utf-8?B?bnFWaEhEazAyNnY0KzhQbnBHSzJoeStFS3ZQSjU5R1VQN2g0OE4yQU82Y3NR?=
 =?utf-8?B?NHhHRjdNVHY0WDNHdEwrYi9CYzc0ckdMU2NzVnRZWXpWQVVxOEkvbVRqZ3ZO?=
 =?utf-8?B?VFJWRUJuS0taSXY0NWo0L3VHRUViNkxjMDc5YWsyR3JyVWUyNEtiamlOdVF3?=
 =?utf-8?B?Qk1UY1NxV0VpRVVsMHNhV0MxUDYraEZmdFM5Sm9jL2tzYmk4VjVNdGM3NDNW?=
 =?utf-8?B?ZVg5c1FuaVI5b3V4aDNLNTRPSGJvNWh1Q1htMmdyQmFXVDNoNjhDZE5LVVZL?=
 =?utf-8?B?OXVjYzZIOEJubDJpcG1Hdno4RlVabCtOWkxPSStpVlVWVkh4NkcwNUhnbTJn?=
 =?utf-8?B?a2dhdTJIYXE0VnhGZVdtNzFGM01YRDBIbXNlU3I3d3M5V3FNcFNBU1FmMFBM?=
 =?utf-8?B?V1pGbkNJbUoybUVqdTNBS09WUzRtZnJiQUx5SHM3aHNTdldlYlpwM0p0QldR?=
 =?utf-8?B?WmJOSmJJQitCZGFFZkpSbGFVUm44SlFJK01mYktZdHU3R0tCem54ZVQ3aWRi?=
 =?utf-8?B?UHppZXU0WkVnZ1lRMVpSZjIwdFNCYzBwZkhzeXkvR3ZWQXFzTWVOZXY4OWxh?=
 =?utf-8?B?NEhjbEFBdWpXcU81cVZOamJPQm8vT2R6aWYyRjdMR3hqdjRPdGxad1BjNk9T?=
 =?utf-8?B?blZldUZEMlZBcFVwQ2c3YmU4TlUyK1J2elAxRmJNbWxJL1JJMG90RGJHUzEx?=
 =?utf-8?B?UlAwNVpPaUkvVEIvL3lvQzYzWm90dHlEaHI0MENyM3NKWm1waE5DQXRwSVFi?=
 =?utf-8?B?bjVhTXZhbjZ2UzFOdmlhTGVhRWx5VVo5VXBZYlNsRTB2M2I1cFBka0FHdzRY?=
 =?utf-8?B?MmZXdStFbHJ5bm94dmRvWWJzaE5kcFR2WFR5UDQ1czlycnpjMzhLUERFVFo4?=
 =?utf-8?Q?yVoRT+dfZOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29SaXJxYTE2OXpKakM1TWNvQTBETFNLdmpvUzl6M2htZEsrR0trWndWQ2JG?=
 =?utf-8?B?STg2WkNQZDlLMlp6a1k0a0VFQ25zUHY1NysxVjVJL3d6cFNsVm9CZ2VlLzBL?=
 =?utf-8?B?Nk1CV0wrSG9EdzBHVDN6bmRveHpEcGlRWkhsdzBvaXBlNk5GYW94L3cxUUtx?=
 =?utf-8?B?WXVCNGZWRGV2UnJTUFBVaFhhTHJjckJJcnZmM3lOdXlXNGdyL0JqSjUvdkVD?=
 =?utf-8?B?VFFXK1U0TGxPd1VPQzArUGZ5TmErSmF0Z1BsTVZ4aW96cTQ4cWFVU3RKM28r?=
 =?utf-8?B?d2VLaTVtQnFJR1Vkd0p0N2pQV0FVMzJKYWZoRkY1QzFhWk4wQ25SUWhGVGIy?=
 =?utf-8?B?Smhhd3h5N3JtRnhLRTJlWDV0RmtudEJKZlRlS1Y3UVllZnlIYllXNndxZ3Er?=
 =?utf-8?B?R0EwRUEwS0lnaGR0bE1yQW12VjlFTExrcG9YbDFHWUJ6MndzNkM1QnhaTGRN?=
 =?utf-8?B?WUliMHplWXNneHFYTVBjTTNUMFRBRCtUalFlL0VmTnB1Y2VNMmpGdXl0YXZO?=
 =?utf-8?B?YUM2ZTc1L2VKVFJRaTl0RjluVXFFaERuN3BuZ3VrSWVtUFQrR09Ucmd2YThU?=
 =?utf-8?B?c0xnYUZ6MVpqaEpyVlBCYzdjN1F2bzExUW14RWptUE92dDRWMStjMUlxT09T?=
 =?utf-8?B?MkJzSGkxOHhpN0VuV2JxSVlOeU1kc0hHUEMyd216NGgvU0hoVXkzaWtSc3Ey?=
 =?utf-8?B?ZTh4WFhZWWR1R3YzWWlnVy9MZWYxNWJUbWJhRk9YY2dia1g0TE41UTdpUVNn?=
 =?utf-8?B?ditNeUk3dTVXdmJoN3hnOEFtL0Zqa28vMmh6Vlc0N3pVS3JKOEpiMGlsT20y?=
 =?utf-8?B?bDh1OHc1cUxKZXROcGhSOG9LeGVnR2pTUnRldndCRnZSaTkxRnZ2c1hpUVN4?=
 =?utf-8?B?OTFyakVwcyt1c3JyQldaa1hZQk5sMWEzOHZmZFB4ZlpmT0ZqOXdMQTI0ZUpX?=
 =?utf-8?B?ZnFpcEZFVmdOSklteU9zbXdCK1F1Y1I0eVdnQWZqalVsNDAzR3M3WE1RZkp5?=
 =?utf-8?B?MDBnNkpSdllUMTEreTFKVGZERUtISW9BZkhLUzRVWkFKNjZiU2JUN0hEczZL?=
 =?utf-8?B?K3ZGaklXdlB6bzVoVVVMUU5vNTZTaEdFYzhKNlJMajd3V3h0UDJoVFNqNGFt?=
 =?utf-8?B?S25nYUVEM3RxUjQyNk1XZ1duczA4VWdEcjB3ZXhRVFBiVG5MMHg5bzd3WDBk?=
 =?utf-8?B?aTY2ZzZiUnFnbTU4RktMNys4YXdjc2Q1ekRZbWJEajM4N09FMkFoRS8zQUc2?=
 =?utf-8?B?LzVlTE5oRHgvTVNXZFlGTGN5MHk3K0MwUWVLem1KdG9Ebnp0SlgzNXpRM0l3?=
 =?utf-8?B?dXp1QnpuTWRXdXZvTWw0dDE2RnpVMnNRVEg2MzM5dkVEa0hoakdtT0Y1UjZ1?=
 =?utf-8?B?cmlpMXR3dkVidnNCWU9DS3lKZ2JQdlZVSHMrNk01WHRzbEhYTnAyeCtIVy9R?=
 =?utf-8?B?dkNRQ2doRDk2TTk2UGdJbGMvUmNiQkpjWDlKYjlBbGdnd25yOVNHTFcwR1J6?=
 =?utf-8?B?ejVwM25yNHRLMVBvbERmR1JYYTl3b2Y1RTA1aUNLRmdpeVFRT3J1eVpYRnFL?=
 =?utf-8?B?TFNlWWd4Y3FuNlBPeHRUVEhOK1pnZGg5dW5GNTdJRzNPdng1YVErQUx5Y3BF?=
 =?utf-8?B?UU8vTnczMG5jWHpCbWJ1QWhRdzY2UUdIOEZmQlllemp5c0xReHVzQXBHNXpU?=
 =?utf-8?B?OHBlb2dieWRuRVdNcjRjaU56djh3QVNyTHpkcmtYZ0ErTGV1Ti9Sb0lIS3l4?=
 =?utf-8?B?VkdVQkRpSlZhWm1lNVBVaklVbkxkT0lDWXdxbWk5VFJ0Q1dtUDVaRmxjRzM1?=
 =?utf-8?B?S2k2WGNncjlkRDdKcC9CNHRYcktIakpobzdUU3YwL0p1Z0JCYS9EemFha0Fm?=
 =?utf-8?B?ZENYMnBORXZpY0xjWm5hY09OS094VHVJTzBXbitiWHAxNGQvV3ZDQU9hQTlG?=
 =?utf-8?B?SnZkd2ZpV1BaaC96M1dGbDVValFGaU95N0M0cjhxVUh2R3lmbGk2b3g2L1Bm?=
 =?utf-8?B?amQxQzRQeldOeHd6Ym14V3FCallLelkzeTkxOVp0VGwzWnk1L3RCZExDRzdJ?=
 =?utf-8?B?d3oxUDdrTXFpRnlEVU1lVUViN1FWMjczMEU0SmZ2MXJpYVBZSFBqdS9GRWo3?=
 =?utf-8?B?NGZWWGFvNVRNWFYrM1JQY1JGdHNmWlZac3UrVkxYSFM1MU83dTRVcGtnYzht?=
 =?utf-8?B?UERJNWpCeGFqRWpxcHVWaEl5YnpkTFh2Vld4VW9aNExHc0VnWUt2bDlLY0Jh?=
 =?utf-8?B?ODV5anYvMmJzdXN3Zk9DSVVrWktnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6004e13-69b9-4ee9-2fa8-08ddbb049943
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:58.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIn6/KhpGi3F8ymM61HySrfIelB/QJUJfGPHqiU8bZ8xOl/NAcCh+tZ9AnlpL3f004GN6D4t9u/J09B6T55vbjOe1iEZxsm92pCO91uH+Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Authority-Analysis: v=2.4 cv=ctGbk04i c=1 sm=1 tr=0 ts=6867e0f4 cx=c_pps
 a=H8KQetTyUVx2NtQIo3bL5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=qN5ve3sCTOSH2ZO3jx4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gvwMRx5JKswEcl1QvvHj1hBoVB14ydao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfX4MHx59CSg3jV
 TbNEqzRYV/iAdcpIGXq+PiWT7qb/BHs7/+DXRD09mM53GCfYcAIbZI/32WmRI65W/FNktDqWicH
 xkgQh6LIk4Pgsg1j/YFa5AvIdYAA9lYMHKTU3llNXUJ1TjT9qt97CIlRpJfT6QgQ9BEl1pKi2AK
 MwR7QukSR6zqXtARSn8gPtKqddQaD1DIo06xLKTFS9khSJgukybBi+iXqQb+BITdhsy8Jig5Q02
 rqFc850tljAMDwO/tBHFYIRl8LaUUJ02BIe0pEhruUfduC+edvSBXAXfLIHCLVk+S/HIw9YHy2X
 x+TNGdeqI7ltHmoT58MBeeWLFDZjQePp2wmfhm4yEA7jwnszAjYgzVh1FcWp1UsPloAOI6OqHAp
 X4dYMYO7r9/gA73b9dJNYg1N8EFIjQwWCq4tDKCTXRJTRsgIDFrhkjBZ1oyUr0rkF9WqDIyT
X-Proofpoint-GUID: gvwMRx5JKswEcl1QvvHj1hBoVB14ydao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c3de1d830c..571a8d1ca6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,6 +427,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -501,27 +503,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


