Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C18C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpx-0008CP-1R; Wed, 25 Jun 2025 15:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVps-00088R-GG
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpq-0004FW-EJ
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:31:08 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEqPsu011321;
 Wed, 25 Jun 2025 12:31:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qc32R3rTh5shTasSV1D3ldFs4qlCdmIFa6pVZyoOB
 bk=; b=jgaNHDvr7SoToBaxm49B7h7tFW6fSPSOsUZV7wfDkzhsnRTJyCZqicGTu
 LX6/RyCcJ5DQoPpNh5T/DtbaYdAfJVUp12kqYzuWACYdAp8bmufu3aFT0UbtCyhx
 mjZGuIWaESxa4IqjK1zjCZV9ZcjjT00nMRpVHZoIl2dC24vbJ98EmNDBpwT+GmqP
 PVOzBL098wqRgMHuSt1Hsw1a61K7+E6RFdN7JmQ9Gp6K5v48IR2W7APHgz4f2cKG
 S6UgcUz3M1lqDRYwSiO0JbYLep35RGS6+dUbpW1O2vtO4lSH51E3H6P/PlYFCBjT
 tmgwI3JIvOswVEkqgbvmeX5cele1w==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2135.outbound.protection.outlook.com [40.107.100.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47gjbh0r9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyZV2DHStmmYij64w9IMw420zLw0M0slZzoS6vk6CU3PeXp5FSOtOT718iw3qFNK8x9BXdZJ6oOrGr0Ab+tMPvtyjFV/vcLt38bXEAg0iDAvr4ezZ10L+48mYjYtcNAzKfyWYm+fb01VzIIS42Wp9hhiRnZRCqirNy7Ipn15RBYg+O7o5ahroRoJWNx3LIahoJrz0lgj/VGBjumiGnMAjSW1T5j2TiNKt7j7uPgLsqb/qaKZWR/QwZ6LxQuE6Bxw4DbBKvQmAp+geC+8WR+zSUHpsv1aqUCdQRU2ZzMrao5AV5HwXcxf29qgAbI0DQcjqil3O5e1x12GpOns2LQfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc32R3rTh5shTasSV1D3ldFs4qlCdmIFa6pVZyoOBbk=;
 b=nINR4UJo2k0DTxv62PA0l+Umh+vqdh/WMEGDVY2PDrL82FqN4seLoA5WpbQexsLFUpcQ7pV69PWAVEsyQx+H4FP0uW1UJ5FMFKkM0ivS901hkvbbzknqlaPvUpHe6gpUxgmbr8rfT2/d60OvXHNRBr76zyC7XZ1zOT6YjaoLQUNiNqouH46tZqZomxb8emsyn5IKdmSJLcGscBbah/Q2fc23v+mutjYFfPBDVca4tRujjI7o9nKRNK66O3wkxsqfsPHslGc8LPfj47bZ/AEfmXZn5PJOC34jlH5980OfKssKFwWEPCvFrOmUc74eGT9RdHhoRPi9VhHZUBxUPBtKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc32R3rTh5shTasSV1D3ldFs4qlCdmIFa6pVZyoOBbk=;
 b=fKJv39Z7NKK7zU6PVHp8i8pKorPmg+C4v6PgpuDj0xqkIUAxtvdAvKOCk8vOGK7ZCzN2DrL//PSauPLR0N5teIT+XQ1v83EpOJuJQdK/giltaGYbPwVGXcRBuM6fioDsSCUIAIRasQzh+9+m9r1TUwATFV3Wt7UIb1D46w6ydSLrzWYP9URCBr2AkzhSFRRLKexZv0NJLzrIduYIhMyvZcZS/2KjnO/nYUjO9ImEKcJW2x3+Zg0PXGgkqcgevDlZP107GKx6aHy3N9UAL7hZUiMF+z+9FNJ7F9q3amq9P3CCmdUPBjK3mba7DeYzi1M4/FAHDoD6gdWvyd9QCg0pSQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:31:01 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:31:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 16/19] vfio-user: support posted writes
Date: Wed, 25 Jun 2025 20:30:08 +0100
Message-ID: <20250625193012.2316242-17-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4034be1a-242d-407f-8b62-08ddb41ed17b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLyf3wfXjMc9h4S04o/rXuTDuo3bqa2DiV8EJiUfZIwKQ0KSCjKWJqkeIwXn?=
 =?us-ascii?Q?hwyE/NDcyCRyKQROWSByMkXyQwU8MOxJ4T73J5VWBDLJwGx34y5rHtaMlg9z?=
 =?us-ascii?Q?pVLwQVdl9Ezv7cn7u49IeFaG6XHrEJZDWyFogKx804kiWYyNRNO7XY40T2cC?=
 =?us-ascii?Q?nzlCLuaSkyzWIdETcT0SYeTvjdUiB4wcvtfuhmkhRjckk8SowWMztilfGkJF?=
 =?us-ascii?Q?6hr+KnuyImvfVTz5Liy6U+SEqr3vyOJJBrNFOFiNUOES79bsiYPuRVv0drYm?=
 =?us-ascii?Q?W6E8Cty1hNaPU0Nz67xtnOFzUs5kx901ERG2ZLq9XqvDho3qcLaREeMUgve0?=
 =?us-ascii?Q?h3qkOTROx6smEGIcXRpCDNrvg+1MP2SB1jfPLLp5jt/Gf8xhWi2xra3JAYVy?=
 =?us-ascii?Q?72ic9CyZPbL/9mCLkx7ijBPAxHt2/sIr5GKAISN0NpYQoNq8YEHSDtyd9vtz?=
 =?us-ascii?Q?ZC/jN9V6UN1LoUssbAz0iRzzlHbxojsoQZVAppP6mYvKmq0hZsnivce6A3ay?=
 =?us-ascii?Q?CbNuCdtTOhhx4Is9SiL1tPIRqDqADRSL/o/5RuNuSOBSWi2lRow4wuxZ+4fN?=
 =?us-ascii?Q?AYB9HguEThQT04ub4qnB90NEvSZIqIkCAYPTE+3Qr/60FAa5O30DImlR5cXR?=
 =?us-ascii?Q?OeTs4LtFMVufpDTNJ0sjWnCnSyBXU8zGVNr5M4ZmEQ1ruGENidYqNzm2iUAH?=
 =?us-ascii?Q?uZp5sB0t76NkExyFlsK6MQacZ89zOhnq45DJTG8YAmVPKm7ubSkpnP8o+YmB?=
 =?us-ascii?Q?I69x8ArW8FepDiSW1W5u1TALug10A4flOr7PFZRo7Uh7zIvAB4uCfgR47lbg?=
 =?us-ascii?Q?8NFiuI45nsQh16vKAdmP4WnNJkNIyI2ONbRCAhq7zgPdrxws5sgJIsgANx5x?=
 =?us-ascii?Q?CmCDJghcUUyUcsGxyLKIFZG6SalweiwLjQhqdZ6TANkCFgtyy5Vi2u8UvzU7?=
 =?us-ascii?Q?P2F0ugT6i5MNlqHobpAboG6nzWgZkCfpKRdiG2kOhqH9vMz8iO9cWvlSWko7?=
 =?us-ascii?Q?eSavhBB/oPE6RB8VpN1lA+ojOSr8oOfMfUj/YRoOjgiZOYfBVpiTfybLYHS4?=
 =?us-ascii?Q?8AH2c+Xgfn3qTWubL2OBx8cG5W1efPbMDaAz/vMpYBXpqU2kvwlz1A8sMNl3?=
 =?us-ascii?Q?r2HDFx33K9olhmHfOeng5gl0e1EfnMo8249+Bpp+N1GdYfaToxRfnNAH50m0?=
 =?us-ascii?Q?3kOM1RQ4ggqd/14YLYNd9Dzq3l8coT+kit8gsKJ4y7fjMnv6ufpMosUJmKgy?=
 =?us-ascii?Q?ehnaWVBnSDPA7NBtfIQhvbSBnBhPBEr3kvCBkYY/wZcy1PTpV+4dz6BDleNY?=
 =?us-ascii?Q?akWI0IGxa+5cIa1WYOXuUSl4jPZKe4v1bg9E/G7h5xZeSlUwmVl+4uJkjUrH?=
 =?us-ascii?Q?Vn/J6vimv063CAg5fFQN93tIF8iwRNfxvM8HOApMtkQlbWAhqi6CpNVRWyUj?=
 =?us-ascii?Q?SWY8kb6yCwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9TkEnettePSEuTNmmHj/NRT3pDxWOhcayN7wwaUK2gSAX0vfbdknrOl1W6E?=
 =?us-ascii?Q?dJnlPO3iNtpe6m3jnIVC14AZAl4soyBagV4wx211QTjNI8/ZFB7fxX0Tmv4t?=
 =?us-ascii?Q?AiOP6errQpt5JjcUyiqcHb3tFBWRN+x0FOw1EZyq+4Y/mTxDuEq/QLQjTUB3?=
 =?us-ascii?Q?KDCy1MGH5O3w6n1jSVnajYoBB+IRVV8/k4P8lfqy2HrdNviQ7JZntul414yW?=
 =?us-ascii?Q?7okFTHl3FcL34vy7j9icVIFaDTlV/WQabKi3Vr1ejAYsSQTBEEEBUbjQrLKS?=
 =?us-ascii?Q?4LfWz6JlEoRHRrQxtfy98myXKo8HBS4AAHWk0FLyQnTFMz+l5rOf38q/Z9ZU?=
 =?us-ascii?Q?A7NDIBFRusZGGM4qBzunKMhbBg7wTnekBAxPpB1BePsEcm76KWw2Rm3CExa4?=
 =?us-ascii?Q?DqeK1mBZBuprZmFVtbb4OI6z80IWcYmloYYx3eKlfsfUezXIIOn7nQvNCGJV?=
 =?us-ascii?Q?0oCDp85STYitxsawOwWmH3SHARqO17DGNj1IdrzRRWgkWRpEWKraosNFeNWh?=
 =?us-ascii?Q?WdaC5xzeKx/1Vuqaiix0KSS3N2QMs3Yihm24NHojPTwrqQTk0E+URR11hl9Q?=
 =?us-ascii?Q?rYDzrBCbCgnM96zhfJRUl5QozRfUZ48zVinyTemLAqrIkHSLaZ6luBZZ+iUt?=
 =?us-ascii?Q?qyzOYL6CniG4onZgV1PTEtPgwT7c9dMjvK1Jao/hZzcjCR9k+bjhnKLA8K/4?=
 =?us-ascii?Q?k4HcoqHapwsFruYoalWXqkhOBZvY3Nc/NpuFLHp0kdVngGlXge6v8swA5gYb?=
 =?us-ascii?Q?WmYpmPWFeKT+pGb7TuW0Be5v/Vx2ShacHBIZuaUE7R1pocAlX1dThGCaHKUI?=
 =?us-ascii?Q?Xw65HZfNpNEIkL+QDAggE0sEq5q+2H/gwMkCq1cQuSyGvhTYJRHJaNvTDT2u?=
 =?us-ascii?Q?MBKos/A5tEWmsPrHBO/S3seFeKLK1X77C5hc4g/R1+mDtpjXTYAGXrBI3vOP?=
 =?us-ascii?Q?9htZem39QBxb/fitFf53wXHhej/XWeshVubiH+QEbmhIFV0sZCXQF0UT6UL/?=
 =?us-ascii?Q?R1Kupqbpgw+Dv7qVS9uYMLEtZPYQ7cdCrXwCRxfxA5Vd0cRbNB9pCBcq/XYV?=
 =?us-ascii?Q?0Oo1CrkF5dG5jA2sgDUcFbWXLkpcGNhmLcoXsIToLgTscoq7AGY/nCYRsIpd?=
 =?us-ascii?Q?Y3AqS6qgQ+gVaUr7MZPSrISCf5hu/xbrcebRNKLZ34HWnfhg5pxGSVPdgs07?=
 =?us-ascii?Q?RcatpRlUtlRwU1hwfQbzmT09Qqagqt69shymuTci+uBwGXff1/VtZiw+b226?=
 =?us-ascii?Q?eEUST8l9Ya+Jvl9g750O5VddNbezG6wGfg6NlB/E+xC8ITed1nlIGoC8uNLL?=
 =?us-ascii?Q?Yq9sdVWN+H2ihMwFETLmqQRj7M69FgPyVQ3q4H8iFXLdvGmkEG4MoaGx/MEF?=
 =?us-ascii?Q?RB3/Da9Yz7nvEOKVzlJ5+f0C3gR9wQ+FD5q5P9k05DMuyjl9gZ4WPzpflLJt?=
 =?us-ascii?Q?JAcH558IcnpHQp8KFeFzZAIoHDxXtKDuwojj9M6c7qtOA+exwc4pGIEQIfvP?=
 =?us-ascii?Q?8idtytIqRU4WkAaunHRZkuMruKC0n9rgj3VaeGA42uMq28z6e8RoO1n9XHd3?=
 =?us-ascii?Q?W5/sjpvpiy+kxfCb152+P9n0GtzymCGow+8sBDve?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4034be1a-242d-407f-8b62-08ddb41ed17b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:31:01.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G9Yhvx1Wgb+KmYxtKRFLQgrJ2VjBPYPzhkISHr9jn4WHCIWbrcY86eEqGDllAwNQKboHEDleKGQuwcptg6OBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX7st+P78Vil2x
 +S8cncpbJ1wnVtBLYMP71Sh5FghInWc83NGgVByVeaEcx9Prb6V2zwS7iC6p8Ndr87XU/euRkfi
 MXofbUdSbQQpT5ajPxSGQHN75Figgk0DPcDC4mygr31akyivkF5NpeHIc+9NMTDfg8hjU2qjpIl
 Kvh8jCcdGs9fFCHgePUhAoHFZccqWx4+3ID1eYhlUx+qa6bBbQDlej+w2WMkB+OT/iZdVAnaxJV
 EZO3gqW4a0Eykky6doq1Xig1EvIOgXLW0WpycbH3zult4bztUm/vbO1OQE+fsLyZLv2SRav7qOd
 4fCbdwDgyNnj2S475G5/FfVZm0ru4+Oq2V38eMewbArtbvwtnbDvDWmdzaXFBt11xf3bP8cr9kz
 vjVbMNnzGeaw9714iAmvYBo8EAv0KvXYXEPrh2JPFnDzxiRnJs7frMeo8ZAwznw6aGiOnBed
X-Authority-Analysis: v=2.4 cv=WMl/XmsR c=1 sm=1 tr=0 ts=685c4e77 cx=c_pps
 a=pKTBGjKhDztqafJ6BpA6Kw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=5Eg6v1c09lA0JFFDL-8A:9
X-Proofpoint-ORIG-GUID: UmhDkEglbGqBcy-BzXe4A7e0q5i13_4i
X-Proofpoint-GUID: UmhDkEglbGqBcy-BzXe4A7e0q5i13_4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Support an asynchronous send of a vfio-user socket message (no wait for
a reply) when the write is posted. This is only safe when no regions are
mappable by the VM. Add an option to explicitly disable this as well.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h  |  6 ++++++
 hw/vfio-user/device.c | 45 +++++++++++++++++++++++++++++++++++++++----
 hw/vfio-user/pci.c    |  6 ++++++
 hw/vfio-user/proxy.c  | 12 ++++++++++--
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 6b29cd7cd3..0418f58bf1 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -91,6 +91,7 @@ typedef struct VFIOUserProxy {
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 #define VFIO_PROXY_FORCE_QUEUED  0x4
+#define VFIO_PROXY_NO_POST       0x8
 
 typedef struct VFIODevice VFIODevice;
 
@@ -104,6 +105,8 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 VFIOUserFDs *vfio_user_getfds(int numfds);
 void vfio_user_putfds(VFIOUserMsg *msg);
 
+void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
 void vfio_user_wait_reqs(VFIOUserProxy *proxy);
@@ -111,6 +114,9 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize, Error **errp);
 bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize, Error **errp);
+bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds, Error **errp);
+
 void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
 void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 3a118e7361..aa07eac330 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,10 +110,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
     memcpy(info, &msgp->argsz, info->argsz);
+
+    /*
+     * If at least one region is directly mapped into the VM, then we can no
+     * longer rely on the sequential nature of vfio-user request handling to
+     * ensure that posted writes are completed before a subsequent read. In this
+     * case, disable posted write support. This is a per-device property, not
+     * per-region.
+     */
+    if (info->flags & VFIO_REGION_INFO_FLAG_MMAP) {
+        vfio_user_disable_posted_writes(proxy);
+    }
+
     return 0;
 }
 
-
 static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
                                                struct vfio_region_info *info,
                                                int *fd)
@@ -312,33 +323,58 @@ static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
     return msgp->count;
 }
 
+/*
+ * If this is a posted write, and VFIO_PROXY_NO_POST is not set, then we are OK
+ * to send the write to the socket without waiting for the server's reply:
+ * a subsequent read (of any region) will not pass the posted write, as all
+ * messages are handled sequentially.
+ */
 static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
                                             off_t off, unsigned count,
                                             void *data, bool post)
 {
-    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserRegionRW *msgp = NULL;
     VFIOUserProxy *proxy = vbasedev->proxy;
     int size = sizeof(*msgp) + count;
     Error *local_err = NULL;
+    int flags = 0;
     int ret;
 
     if (count > proxy->max_xfer_size) {
         return -EINVAL;
     }
 
+    if (proxy->flags & VFIO_PROXY_NO_POST) {
+        post = false;
+    }
+
+    if (post) {
+        flags |= VFIO_USER_NO_REPLY;
+    }
+
     msgp = g_malloc0(size);
-    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, flags);
     msgp->offset = off;
     msgp->region = index;
     msgp->count = count;
     memcpy(&msgp->data, data, count);
     trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
 
-    /* Ignore post: all writes are synchronous/non-posted. */
+    /* async send will free msg after it's sent */
+    if (post) {
+        if (!vfio_user_send_async(proxy, &msgp->hdr, NULL, &local_err)) {
+            error_prepend(&local_err, "%s: ", __func__);
+            error_report_err(local_err);
+            return -EFAULT;
+        }
+
+        return count;
+    }
 
     if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0, &local_err)) {
         error_prepend(&local_err, "%s: ", __func__);
         error_report_err(local_err);
+        g_free(msgp);
         return -EFAULT;
     }
 
@@ -348,6 +384,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
         ret = count;
     }
 
+    g_free(msgp);
     return ret;
 }
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index f260bea490..be71c77729 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,7 @@ struct VFIOUserPCIDevice {
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
+    bool no_post;       /* all region writes are sync */
 };
 
 /*
@@ -268,6 +269,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    if (udev->no_post) {
+        proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+
     /* user specified or 5 sec default */
     proxy->wait_time = udev->wait_time;
 
@@ -403,6 +408,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
+    DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c3724ba212..7ce8573abb 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -714,8 +714,8 @@ bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
  * In either case, ownership of @hdr and @fds is taken, and the caller must
  * *not* free them itself.
  */
-static bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                 VFIOUserFDs *fds, Error **errp)
+bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                          VFIOUserFDs *fds, Error **errp)
 {
     VFIOUserMsg *msg;
 
@@ -844,6 +844,14 @@ void vfio_user_putfds(VFIOUserMsg *msg)
     msg->fds = NULL;
 }
 
+void
+vfio_user_disable_posted_writes(VFIOUserProxy *proxy)
+{
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+         proxy->flags |= VFIO_PROXY_NO_POST;
+    }
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


