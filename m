Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C88C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUMFg-0008TX-Kh; Wed, 25 Jun 2025 05:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUMFC-0008Pq-1l
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:16:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUMF7-0003h9-Uu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:16:37 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P787I0008364;
 Wed, 25 Jun 2025 02:16:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uJambiQzdQepmbqP+JpwTxBDm/CTNlW/feap/V2Gv
 3c=; b=cQwb4/2p1cB3iHBp6ICgSN8u9T+gv3AWBCnwtuOKpsyeyVkyq7yijWZzn
 89UH+zFQoGa1/HYvYROYy3eCgp1vqCf8/hnZQjt1iJCPH5rXqL68/CiWIiJtzt0L
 kNgq7z1/dq8i0OQcPCoOsQNI2XtzLkaSsR3qVZTda0cAiUxfudGQYUMdF/nL8eTj
 Dadq6QEgbkXciENfYEydeQNiZHaSoV+J4oj6hH+5U2U+T2CHWumGWCYBhJhFPh7Y
 /J4boHbQtxybpX+eVQGfPV639KNDo2otQ2Z6RhsVPUMQ4OxvAAoSUcJNyJU0FQOM
 sG28fQoMMsKFDiUuY33YQMDy27ssg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022130.outbound.protection.outlook.com
 [40.93.200.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dt9c999r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 02:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwaBQrb5xsawEZzM7dnCPXvNLNTywjzKIVrpoYQQ+TDZj7nJf+XX4g1Uwiz/Vij5cfPR2aK6+9pdtcA+aQj4QorDna5VdRI/E/200Jndua+ny/HV+Bz3Y7ezoec53N3cuxmTbqW1N0qWBGKlImqrW6QLTkLezSJ3bpxMi0+vOEK8M4BingQ3AcfzD7XyNogB8G9DbrFD0Pd1Q+P79IZpQOEyVaQZahanEmkPW8nMteDnihCrlZhGjlEp9no78Azm0FpffyXjNtP3K5rK0jZNHl36xnDsw+cAKcp6LH4kNDJN1fQ+vmqUE7/LiTJpTU2YbvrGSbr2wnvP71I8UNDmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOBosaY46XN71eZdDbMJKMzXzcVM99vrQg6hRycKWMQ=;
 b=i9q8fkLOIXk/vbqeWzop2QJm6uP0eODiUhzyRt5c0QswTysSGrx7+Ujd8e7sbeu//RpPxV+dNlSxhmhtjo9WU4H+ShFD0C4SPDDdCdFAk0qFM4ouJwQjay3K+Dts8KGMGt/w+8x+wF9xORRkDN/kipEGIs0zYZSnwxZnOn6Y3ETQ3E1KMOjRRznNRipR7/AolMF8rcNGtXPzslrHR6sSHZM/aN+vzhFgH987+C7RyJIm7ZXlarmJm9IW/kmmwWbA4giv/4rWhgglVzAbfaWeOWi9uU0sqiedtOT3aH3t8WnuDg3BF9sLe8a4VzkhbkRNrODdHRkEKbUK3PJ7cyTvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOBosaY46XN71eZdDbMJKMzXzcVM99vrQg6hRycKWMQ=;
 b=DlNcn7+pCFiYdf9zQHGVs43CaaXU9Z6WhhSwcvEfcv2+0PG/bPMoNDo83iAoCRjd0w5XIYp6Ngfg3zTqA6FsbINzfqRpwIz+mm0Z07NODEKdZjEasaXn5wcnOWRswH/XIVoWW4lozt/OAdyMWTZWgJD9WjaRbUlyb28BmSVRa3tQXGY3Gpz8C6G7rbx4xmJkX2HlH4I78hVTnCskYi4VwOIqldyMh7GCooJ4gSyTZH73VSqGcqj49h5UQTwb5H6J8E7kB5ZIsVIWBXKjV6IDGho78USvWvg8zhGJ434m6jR1/1taP2kVpaZfFWEA0WxpjvaRBTL+/dhzH+UbPf3UMA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV9PR02MB10856.namprd02.prod.outlook.com (2603:10b6:408:2ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 09:16:16 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 09:16:16 +0000
Date: Wed, 25 Jun 2025 10:16:11 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v4 03/19] vfio-user: implement message receive
 infrastructure
Message-ID: <aFu-W1mpmGaZByjZ@lent>
References: <20250619133154.264786-1-john.levon@nutanix.com>
 <20250619133154.264786-4-john.levon@nutanix.com>
 <4b2bd5c8-0353-4603-8b66-b0c4b7517c96@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b2bd5c8-0353-4603-8b66-b0c4b7517c96@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV9PR02MB10856:EE_
X-MS-Office365-Filtering-Correlation-Id: 260c35bf-4d64-4ef8-efe3-08ddb3c8efe6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?QHT90lqqyMosy5shnAE4RtHIq2stj5TAubPVkxqco/PGdSnckQKp0g2kcm?=
 =?iso-8859-1?Q?Ef0n0p6phWkB403EGZDJXM/JOi8NOqcR/lKdaAxz1T4Egq2p/ggcEtVsoi?=
 =?iso-8859-1?Q?So6pH436lBmNp3IVt/5Vd73f44gdRuJhCN8PeX1S025Ds6/GOx89JsPyLd?=
 =?iso-8859-1?Q?pSIpLfGaUg5k8gA+M2ZtJUAPYtGYvhQyFf+DHiZLtTnbC47+zBKtmujEX0?=
 =?iso-8859-1?Q?ubj8kC00AOfLByizjd0XU96d2oskjGcbn0msQs513mVqs/dBySy+NRHvge?=
 =?iso-8859-1?Q?LCTQffAgCgrzIVaxwrO6RjZGSzbT4DYJFrdUV8nQtEI6WeeFfZQCV/NKGK?=
 =?iso-8859-1?Q?7qpA3l+ySsEo5dWhndzFpBnmR8w/o4waUnjHNjb0D3dkf8cHMOd8tdEGhH?=
 =?iso-8859-1?Q?UQqSOZhjHcXdbDyfyQzL4NKRsZe+D+7XWf90S7iT5VuabK10DnEuHEfdSS?=
 =?iso-8859-1?Q?fZV93R45O9n5+5bQaVG5yQumIJpUQSJBmUH7sePdmXQ5qm6Cc9DknuerJV?=
 =?iso-8859-1?Q?WyqvhZRxvR4syIcXegJKFqFAeYpgYnCV6FUHxIL0RPx0IAs9iUxxkyUKdA?=
 =?iso-8859-1?Q?5BUj5LZaEGmaxUHTdLGLnwSYY+N4bF7AYfexQqY1nn1r4xJChJ1AxH0EoS?=
 =?iso-8859-1?Q?W7gcXhSUch/n8B02pX8HqIsuS+HlNdepY7DVDf55he1FS1M+buE6RAXcww?=
 =?iso-8859-1?Q?WqtZjS5Ql4d5wUZdIkO+DkSPdU1sAs6MsRIVEy26r/u22EDCgcJdrdhs19?=
 =?iso-8859-1?Q?reb9Aqtbw5mSoU1/AUOJb9e0kpqGtlWCvtjAjF9pNNcSt04J/NfUoBrgL5?=
 =?iso-8859-1?Q?OY4bURzuG86tzShRVT5Spdr2dUBaj9BUkONl6SV76bIBA641m8f2yA0PjH?=
 =?iso-8859-1?Q?SGpUafJDcf+SCVZhneNzS7IW3SU/H5MGwsX1CrVXO5YLNQ7+7Zd26UbPUG?=
 =?iso-8859-1?Q?jx57vGFp7dyp47XIEFjPCC9r3XV7rvBmFfA7G9HNiwkzXejG0LNN8HvVzD?=
 =?iso-8859-1?Q?TlK0hkDXDv+M91qky8OJPWm6/4FWGymokWD/xJsQmkrEE/Un4nTxsJ07Lu?=
 =?iso-8859-1?Q?37wOkgAJjYrrN4/H2DMSy4O03IM9ShSfmJRUK/frmvcLmKGTXGj+z2UD43?=
 =?iso-8859-1?Q?/n0djx5RrJK4Vt3LqlcLN0LZP8cCSBtjnmmDugBhqnN62R1U7A/i5/vr4x?=
 =?iso-8859-1?Q?HRRYuRX+I5Uo9XSdpl75Y3KeSMCiP5GPhz7mFQZhkyB54mMzQfg0497KDD?=
 =?iso-8859-1?Q?uVov4PXYfYHNe4PBwhTLsw+9M9iiKe2Blj/Q2N3dDYw7K+HvdF8DidJmmF?=
 =?iso-8859-1?Q?se3FqOUFHeNvgRskmM/0565ZXY57Oc2jljbdtURvYR3zUJ6OGN1jryp1JO?=
 =?iso-8859-1?Q?xfNIYuO7wg2NpBDLzERe6kpam/98QusEV0wbRazpfn3rfVPtrPBgOhrJ1k?=
 =?iso-8859-1?Q?+UY3BezLDhxDFjrTH1RwwdunwiwI7Gr63T8Nld9iNZfobdoQiorO+UqUEO?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cW1oSQBHB3p3KBOL0xmgkSm031+MilhZjjYgi5/pkS2n1MJVCC9AkK+bw5?=
 =?iso-8859-1?Q?bGtZEyBrALzwbMTaylWSPZAX1vpTfFxHdWf5OUAtmBpXHNahBIIH/iFWqe?=
 =?iso-8859-1?Q?qsH+ZkIKhvhFFS0Bq0MHpTQAv5EskeuuXqXI4tHiWFXzoU07Qvb1PK2vH0?=
 =?iso-8859-1?Q?7lg9o0Rv0h5P4r2EQVmznb6klvnUpP4DF0Hay/DcFpflZWr/TzM/Os2m6T?=
 =?iso-8859-1?Q?oERY42lu2pGczMKHMFWf71OPEuD0xtLuxzwNqe0gYFSMGULFl3e0yr2IgQ?=
 =?iso-8859-1?Q?G2rH8VGGUxJsPM2yoj4BZ+hFl0PE5JLEeqIm3yTjnAxh4TwXwmmG9ULXsz?=
 =?iso-8859-1?Q?1JcwMcN3OyZOuyrurZuCDPomwNr4UfN8SIG4PAiJ3xPmtuJwzAGDjZZRjt?=
 =?iso-8859-1?Q?rbXxuqq0jNmMWe0rrsgWEX9W5J/7JUR1I2T6ParOzNxftMFfKhf3NE+bnU?=
 =?iso-8859-1?Q?h/7dJ45KKlv/0tgdZ3MI8w6eMnRAuwVCNhOi1YYJtrVnhX2sjMiiZ1uDPn?=
 =?iso-8859-1?Q?tGCvsnx/64wcEHxRVw0OuZ00zp5jdqXdNfUFcWFR8/g5SdBph0r8zQ84Js?=
 =?iso-8859-1?Q?zFCjdbfMyIYumz5pVijqZ3BLt4pOVVkn716Toh4/bLbqqhCnSqkbAHAbiW?=
 =?iso-8859-1?Q?cmDciN3OxCruG2zZooSzkpKpitXRnceIxVGk5l7iQJ4Ex7lKTEqaQ2M/xK?=
 =?iso-8859-1?Q?ZZ3nuo4AylNtd9IAMAS75vM+ZZYkBYkU1QVF72utkZcdhISm2HqENxfqb7?=
 =?iso-8859-1?Q?yp3bMz8kbPVuYieGFQmXnBwhZc019r3DiKIUBXWsRuyBP6uJ0KYknojCWx?=
 =?iso-8859-1?Q?CZL72dJIy4XcfI5MyLIjqedMpMGw2bBrlL6M664DJoXNKVW4FeG69OXpwV?=
 =?iso-8859-1?Q?pCGl6X74IJKVR36u/3Dpq6KbA7wNEjOh9HlVhSXON3I53HdAIKvPUvBc+O?=
 =?iso-8859-1?Q?KAGViIKSIct2T0lppq1fPf8nsccaX/AkY/9XFdIC48ElsNI0Lv3X1Ci29b?=
 =?iso-8859-1?Q?gTHIttiSGntAg0yL1wSB2+Y7+0wwyBLWr8K563Spd+9SrIMcqINHstvzAd?=
 =?iso-8859-1?Q?2etBYBjlo4dVZblXohut51X8bOL3RKMze31L76+b7GYC6WJMfO0Z4H20ro?=
 =?iso-8859-1?Q?JLg9+b7OVcx+LbN7ZD2jbgKfymXQqYtlOJ/EEh5Mqbph7Z5/4rO3kBTpcd?=
 =?iso-8859-1?Q?jcfhI3wowywX+Yv7NunxDCuF8zCe4BpiW63gvmDTyV95Pf5let5+CNX+fp?=
 =?iso-8859-1?Q?GZfukWa120YPRZGnj6sF3B6xnl67xG3d6WBfhj70SV+LIBJY0QCEkBZwTS?=
 =?iso-8859-1?Q?UabmhNippdmVKO74nYndwDlEuEHuXuuJydoDeBXU/iuHgcb/0y0ZBRpMkK?=
 =?iso-8859-1?Q?Fk9hfNbWbv37OifEV0vtd6WIO/LvzeSisYw7dlfXFoJ1GZMhFYjTBlRPAn?=
 =?iso-8859-1?Q?oxInOuyiqAqoKKNtWQNygP28lq5FNIMUuwVVD3jW3tQQU/firT0itL0EbF?=
 =?iso-8859-1?Q?XWAzvA3oTcWexZ2lHWuTRD9FpdSuAStZ2OwespCUJQIdZOYR0UMqiVMFMc?=
 =?iso-8859-1?Q?Ho6vMdcxFEom6TChB+j2rPrGg2hCdENvwx641JzSbw3BTViprV0SqU5hz8?=
 =?iso-8859-1?Q?vdv0XnObfysIbcFb6YjxN6wKvVvU4IPGc4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260c35bf-4d64-4ef8-efe3-08ddb3c8efe6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 09:16:16.0002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kppkRmHMxHOjw2lZR6emJLNeRwgVDEjd0YSnf/+FZlnPwJSaTCeZij8MbYIYA0/1F4lFk+pTwoD8XGKYyBYyMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB10856
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA2OCBTYWx0ZWRfX6IX1zpmm3M61
 p8OEgps2dS8sq5hiX4oFTxOetONIIKaAwKmGZLP/2NCng7QD/bFswfCz9vtBFn8tdMQTU7jHX79
 rwl9mp+sRlCQR1L1v95P4LGT1o9vB9FLjYTcOzlR1HRyrcAF0qrNNRJ31kykCyWG3Hh2cDFbaY5
 oCJ+vRzhD3O/FracWPixzb3TI3ewdappQektYODBmom51sEYnZdOLAKF3PKhc4Re19bpBloOs/K
 37AaQ5MDfxnbwP1yF43fxaFfo1YsC2HAIC8wQCXUm9Cn/EEm8Tz7cTXxlxbRVn1vA8nRAjTOW/Q
 oucn4Qmc3s8XlgJ2IOv299dQxp6pQ4ndwQe5v6nhoZz7CpV0jIjYRSIyQ4uQWgbPTRN2K8nWdAq
 eIfNvjGSTUDx/ls2lIen6rrHMaY01fXC0Q5ugU/QCYPZJAJclVV2KieL4Ni1JgH8ELvGLyXu
X-Proofpoint-ORIG-GUID: rOfRLRwVbAPsQEh_bNDLIJmd6F484Ocz
X-Authority-Analysis: v=2.4 cv=MeVsu4/f c=1 sm=1 tr=0 ts=685bbe63 cx=c_pps
 a=MsdpkMvdvAEChcjpy8/EVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=3TieqMpZLfHyRFu3cqYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: rOfRLRwVbAPsQEh_bNDLIJmd6F484Ocz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Wed, Jun 25, 2025 at 10:02:50AM +0200, Cédric Le Goater wrote:

> > +/*
> > + * Process a received message.
> > + */
> > +static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
> > +                              bool isreply)
> 
> This routine could have an 'Error **errp' parameter and avoid the
> error_printf() below. Can you fix that please ?

I could, but I think the current code makes more sense actually.

vfio_user_process() handles a single message. If it's a reply with an error, we
want to report it, but we don't want to tear down the device altogether. So it
wouldn't make much sense for this particular routine to pass the error back to
its caller?
>
> > + * For replies, find matching outgoing request and wake any waiters.
> > + * For requests, queue in incoming list and run request BH.
> > + */
> > +static int vfio_user_recv_one(VFIOUserProxy *proxy)
> 
> I would add an 'Error **' parameter too ...

This one I can do though

regards
john

