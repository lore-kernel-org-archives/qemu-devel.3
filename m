Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7DEC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPK-0004EQ-22; Wed, 19 Feb 2025 09:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPF-00041K-Oc; Wed, 19 Feb 2025 09:50:34 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPD-0007bL-Ga; Wed, 19 Feb 2025 09:50:33 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBKnF3003929;
 Wed, 19 Feb 2025 06:50:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=95DOlyGBkcQkytLouJyPHU0w/0KpUKHO+DZafAk3B
 Y4=; b=WSlxmbICgOIfwDkR+8AFUBhFsxwWpieLFrVEvgxs1Qe6Q5cWAswrdrUS0
 1yyZ5J5XWmuMl/y3q7k7NSfjh+bSG8GObC7PCpEXJJJAr724ghvgF4QSUUC/x/Qh
 9cSX74JRt5gt7sHWVKvg6HMX7otnCAhrPhzuy4nW0ReaTpCEWorIeL+8+om2hXwY
 MQqCp53kkaJ04MM02ZWP566BjmMM6AlH7+X1YYsrnJdy+xPgUDHQLyiM5uZXKD35
 0ZYp3Uhiarm9civIMCpHJgAjCvMgc9lLEhxYd97CZshCF7ShgNINQI3ZfJTAI3Ac
 /lBjLZHa8954sLxW2CFUw11JWCQGw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012055.outbound.protection.outlook.com
 [40.93.20.55])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXq+JORqf9ni0x5HjJJpnZQwZjUAd3nfPEhFlBLwqQ7UYMSlqqYnMrONdOZahh8bGruI1YURK7irpdSz4fFBqFr8ZDOneFGhohDjB0lZ8DPJh9prMWCtETA3n6kqpSI/XCZzr17bNZaAJBl/ChPSlSuLDRDfJIBABz+YIdaXisjYgGH2RMq4+A9lM5aDaqxjisZe9u/5bArK7AR0OfhM9voyrcL8TkKVy6pvPCKgG5la0B4vd3oEcj5+F5guLpPhA1Pf9G9ru9eR2xw49aSMjlwqIaoh6MkvdRjwQCB0TB+yKe90G4+yNTDQv7Nz/MHQNuQEWVJ1oVzO6Bp7bY9+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95DOlyGBkcQkytLouJyPHU0w/0KpUKHO+DZafAk3BY4=;
 b=seX+yk62dxkgEwHgwAHuRTg99SAJco/4z9n7+FJ8QZpSaaMOpNu49sKCLMlMmePvA5S+wN6L8oFBJnYdQIiDyKpCFaWZtxP4ZJC9OeZvaPp78l2oB/UwnlGrB8S1lCdmUxXyxHwXf/P+1qtKSAbXpJoSYZ+4ItRCONuXI5ZeftpkTQOZ2+KIByGk+31T3EAjE7uIYIVzzMi734QQoDmktS5Z+VqIi9YAa1DfrhCepv2qPvJ7LiIQ6CuD7tV6NX1tcIKMZS0oiMBUgxo2Ne2kTGNwxEY72dE1aa4ocVZmk9fx5NQphsq0Xs2n2nN4Z9N5xSM+S7JdYwH/V8fPUv8E/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95DOlyGBkcQkytLouJyPHU0w/0KpUKHO+DZafAk3BY4=;
 b=RUz99GoaExPJTDAspNq0qfI4Q0PzK420M5x0H57DcvQNDTtl8VZ/SKzHhHnnIz6r3IufOKma4z5PV9rQfzRRq1mayY8eo7AvxXq+Md8FQSbj1ZYPPOhA9SsVRA/q41Re/g5fdCIsDiDCadQ3/WBeKJeT4+GWKepnj54nvlty/zQvfrgM0FrXMbDAH9GY2MsM3hVTjtWw3f2rIss6iIAS7xwZoNp7IN4zlgD+Ry6JyflAucZyN1BzzvzlSdAOMR78Y+2SaRbsS8TTCasYn3ljxrSb156UEZOWUt4TiqaQKVI3DL5b2xBpfmQaJWey+ezd41jLTDL89p1gvjkyP86v1Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:50:26 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:26 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 22/28] vfio-user: set up container access to the proxy
Date: Wed, 19 Feb 2025 15:48:52 +0100
Message-Id: <20250219144858.266455-23-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd78521-4f85-48d6-5753-08dd50f4bef9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLsyA4gHbTcbn/kPUUbFNMdAhoieChIzsK/x/rS74iJQWRMrz0Cr9gaZv1Zm?=
 =?us-ascii?Q?uz056CYbKiVpKzTvfoSepgV0faUqu3q8RHmaCpBYwnN2wnhmNTP/19DrYdws?=
 =?us-ascii?Q?TkbHG2QSln+xFB/fWoHszFZRMHWuBePes/YVDy5z+Sibuga0TNTD4zJR8Nle?=
 =?us-ascii?Q?UtqsFuJSx5dCbWwBb7PJDFKxme91abmVqlQ0nsnrtp2Uirxk3jGkSkXrPVsL?=
 =?us-ascii?Q?TEh0djt/hfHicJP1gYaPOQFq8Kt1lPrShM0TGfIpQ8p2uUPWKvYhU4QvnJ/j?=
 =?us-ascii?Q?zqa/yDfTja6kJWz8ph7rqIA9TDf42vmPYrKSC2XsIt22KiNPx3LKnosYsQcN?=
 =?us-ascii?Q?N2pqPIB3sd4Vsud8XUjqlHyfBRro9Ku+Ne2PLc/9/b/8e9oQiY2IU2aHTgpC?=
 =?us-ascii?Q?TpvlPPhLz2WANKtL5F9VzReM9fdyfrWpjUaEz5nW5AOVFKukRs7S7cOExvaA?=
 =?us-ascii?Q?w9LMBuRPSq48zgkHplcWSVH5Ml5M6Pk6hnn7QR8jr94+ZFd3s6keKbMnpPyd?=
 =?us-ascii?Q?dq84bhftCwXWuwcafsNxiAZut8k7Ij8XUxx2OS0r7kxbHCGkRhXPJXi2aF1v?=
 =?us-ascii?Q?otOe5gWKw9BZt064kih24yMwHtTxcg86xF692B2MVKv/4sw/LcJJ9xyTsb0L?=
 =?us-ascii?Q?i9YPY7/lyobpV5SSH60d7mF9VG0czNrF5q+yBDnnZxFcEK4IjF/3dfVG9TvM?=
 =?us-ascii?Q?9OcCokcnozZ5oRitV43T2+8yioFXmLZkLspUqjNHH7wR0V2A+pZTdhu3TG6F?=
 =?us-ascii?Q?W84x6mQdtgUlnAm4QKY8Gmh9xFl/cTOli40ExlpMOGtW2qrO864r6C1RqUht?=
 =?us-ascii?Q?NsjT784sr3qSRly8Y6oCMQt8dzibCsqqvMhuzGcETBnIn5d6N0CKgr2ixOMb?=
 =?us-ascii?Q?li4dAkjylII89wSynhTwykSJBdRqIBXI9EeZRGG5zMvKuD8MGOnGWiePu9gO?=
 =?us-ascii?Q?AwAPQHaAEbOhfeO7wd5qRBCXtce3bQP5K37tcIRCmRQX/Y2gz2ulum4mvcId?=
 =?us-ascii?Q?9G/IH6if7UYAZbNNrxuzO4eWvKq3GsEhFrIjwfJbcBE1+Isl8M/3e63se+Ve?=
 =?us-ascii?Q?zyS+IbOwkiMiIUzdI5DThnX4L8kjNOTNnGa2XfLs8bDNcb9JEgyqH33poFc8?=
 =?us-ascii?Q?sviJxxLLjVXGMDVWSGYBSSv5/n4B1NvAUNbeQMWwy4Iha+WvQCTJ6fk+EZ4a?=
 =?us-ascii?Q?ukyeeikANvL875IHo+6xeqWb49+YYd/cSUL03ILy5W0elHtJpm37ZBx7za1k?=
 =?us-ascii?Q?ufYXhmK0VYMBsdskQPf0J9YyAgYNb13QcwP/P+VJUH5areN5xOJ9Ma08m/mY?=
 =?us-ascii?Q?6faM+ES5+ozNFZ7RpTOD1zAr5iPTItLctW6Pe/de8uL2Q0bcmyaStMRSSpfa?=
 =?us-ascii?Q?fOFtUqpgTGySiZTEuf5xS914JaPu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sG3jOJtuaYnNj7Wh4g3rjc/0fNGdgTbTOcAhG6VFJA31qRBtPj7ojKzOUVSx?=
 =?us-ascii?Q?SyOLV3eOlrmcbzgUikrBg6OMpIWw9ubjy905IAysJoOg0uLjjwG10UiubAoM?=
 =?us-ascii?Q?0garGkoWkImnzsXBTq+79UGZCu/CbvWwMJz3yRoGk1UPoNs5oMwHx9v8BZtp?=
 =?us-ascii?Q?IPntjs5+BxBuN6l6MZlrt1tVdbqkppJhhYaOvlWF6hp5plAnYM4OQrf+dPoy?=
 =?us-ascii?Q?fkGGpj6eCyXBOf4mn98+uLGzTdXtVBTNimnFhp+vlwd/r5Z2QO3kHin+YROS?=
 =?us-ascii?Q?P+uSSVTBaAh3Hhe2Co5JrczYYt8m+b5pm4+7ZHEg/tNDlgNYds1xX0Q+CCc/?=
 =?us-ascii?Q?i1V9sU6Dcm/z9QUuSb9vfQ/sItn8MczF7Ha+MkFcxoroCkt3vYzmdOKCcNNr?=
 =?us-ascii?Q?XPELvySDIeRldlpkky8sbtfFfLW13CDCeHZJY9MwLjBShFubxeoUYBRMhb0E?=
 =?us-ascii?Q?ozcRL4+yd+QV6c9PBRBuAq69+0rs7atvUJVNNOd3yft5PmMi3djbK2cY3zhm?=
 =?us-ascii?Q?9qWaWRomGEQzMRS0DkhG00/s3zGOmSPPhSBoLPslIi36ZHB7SQ5tMYcNQfLz?=
 =?us-ascii?Q?PeOPsFDAHFyuK2czTHW9KzNufmCTJ+ZBal5PMVpKToG3FOiYAiGy7xAi53jr?=
 =?us-ascii?Q?3fNj3Tftl7y4MPbHcRTXPdFjmFZ0IrcBh1U3KfBD/7CEdyKMkEt2ElJ0ke3y?=
 =?us-ascii?Q?Z7f+n0YrRcxVWKX8MumKq/3T2LljQxBwjMA92OnxJ9qOtFRLS0veN4OIUzdP?=
 =?us-ascii?Q?pvB/8ltQUK2wnLb+gKvTNmfB385b3UnuJulaejOElpo0p8CT/ZzGddFaU/9m?=
 =?us-ascii?Q?ypfKWv0xyKSkpvhMjuUilhID5C2NBcFfILfi/9ufaUzFspzp7weDmJSieIQX?=
 =?us-ascii?Q?6QJhrfIXC/S0Voq0o39ap2DWEH5OJax53OX0zzOoAj3Y2na+OYv9YiqBBHmE?=
 =?us-ascii?Q?Eo8I/lhx0vH8piD3DCBPyfjDYPtl5ymkuExxSJwTjzJtxiIGMcBPG6/Ybum/?=
 =?us-ascii?Q?IrMlZr3dWMnCZpMd28cY6LF3m9ye8aEdgsDwgXJsrbBlFDdcDLR/FzRXRxZv?=
 =?us-ascii?Q?wykqPRKGHNpmU8X87KYlh4FsHGGdxU7rRn0fzkDjpNfnPevz+V7q9O4rf+nG?=
 =?us-ascii?Q?5GeeJrJP2b9UPSRdCiNb1CtuCfnAOdNO1J8Sk1euI85fCaBlRoapgtRGsKpM?=
 =?us-ascii?Q?ISxG1AIXbroaFhZ/ebN58LxQDiNMj5gq1Jboa1MD1ZRkD8WpEB3XoxdMELhe?=
 =?us-ascii?Q?Jxjc3E4q4m9hOCeOWEbybn/bja3xACH9ofKkfLgKNR5gQc6DlqwQOwPjDtqO?=
 =?us-ascii?Q?OyVE75/NX/gUsXH/pkPCUDKuUaVLwY/IG8Nvs7/9Gz229ZQhvnyZmoZWbqcY?=
 =?us-ascii?Q?MrSKqdO9sNqCcFt1MNQrYrZMs+jwVCqZwrxOOB6RHQSVvkeBIE4M8M6fV5bp?=
 =?us-ascii?Q?JI9RpfWeOuhq4GRRCE3cCJS0DizdqGuXxND7Uaz+hESelY4Vn5+utK4y5a8h?=
 =?us-ascii?Q?COTB3Se1W5BtdV+9v4QF9Vi32vyWKaAUUmZSHiFLHbD3+/2+fvWKlY5oTHEY?=
 =?us-ascii?Q?5DtzVJe9/o8kAqzeO+5vEanMkq4hTlDBlcKcKKVC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd78521-4f85-48d6-5753-08dd50f4bef9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:26.4414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVEUPDGti3PLOpWikE9sPxf6j2Dou/niS+y33VWvNyIXPjZkGWEYY+a5tF14x5ciuR+41o3rRKQd+Dt4nR59+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-ORIG-GUID: m_VuRw4OiAVLb7yJorMzZH4MGmazD0nF
X-Proofpoint-GUID: m_VuRw4OiAVLb7yJorMzZH4MGmazD0nF
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5efb4 cx=c_pps
 a=qdevHIbYfAzI1c5gbp2lUA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=z6ziuncRFgQoj_6Oz7YA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 hw/vfio-user/container.h |  1 +
 hw/vfio/container.c      |  4 +++-
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index c079d6f89b..0c487dbb92 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -55,15 +55,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_create_user_container(Error **errp)
+static VFIOUserContainer *vfio_create_user_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -71,16 +84,18 @@ static VFIOUserContainer *vfio_create_user_container(Error **errp)
  * Try to mirror vfio_connect_container() as much as possible.
  */
 static VFIOUserContainer *
-vfio_connect_user_container(AddressSpace *as, Error **errp)
+vfio_connect_user_container(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_get_address_space(as);
 
-    container = vfio_create_user_container(errp);
+    container = vfio_create_user_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -91,11 +106,17 @@ vfio_connect_user_container(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -120,6 +141,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -136,14 +160,15 @@ static void vfio_disconnect_user_container(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     memory_listener_unregister(&bcontainer->listener);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -177,7 +202,7 @@ static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_connect_user_container(as, errp);
+    container = vfio_connect_user_container(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 24ce13bc2d..8a033d5598 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -16,6 +16,7 @@
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ddb86edb65..797707d0fd 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -909,7 +909,9 @@ void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
-    close(vbasedev->fd);
+    if (vbasedev->fd != -1) {
+        close(vbasedev->fd);
+    }
 }
 
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
-- 
2.34.1


