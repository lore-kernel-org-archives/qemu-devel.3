Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ADAE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdk-0006W9-Kr; Wed, 08 Jan 2025 06:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUda-0006Ud-Iz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:15 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdY-0002H1-BK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:14 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5087vtsC007169;
 Wed, 8 Jan 2025 03:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rqQUfPiEIG3vNuWWU3K9p5h0LL+Eh6YNnsaGhJGGT
 ks=; b=fgqMGyNcbbHLt2xtXG9LoWzGi7u6VSlRZUk4nFCG/EEN1BW3yJcvDwxud
 c3KVfMkSJl4LVaoK/kcFs/cQIm6SJo/Et/3mX98HpyLqH+m7TWMkguzCC9F11p4n
 LzxnBwbDVLUZSlUMla0EaZk8x46u4Uc3cYj1KErCFRSQED5PHqBHfDN5/P3Zr1Kx
 UjGz3XEFxoSO/iNYP8eFOn3OqFOgkrHgr2bK85h7FFkPt5ZyB1E6evLX8VeuGycg
 WQYso5XnX0+iGKMHGe4/pH3bHj3Aa7+IZX60iwmx+J9xl8z7aAf/CmtoteV3gERp
 Xx6KzJu69afcRuo2P5X3BcwDPg8Xw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y56eryy2-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD9Gciz/6gwM8ej+ZbteU/pvr6Y2QNss9w+ADa1FTPbmr3ukpApw0K6ul8NcyB8V4i9c9JeHRkFsaHtB/RyjuhJmQlo6lVVywhOsMLoySO1jPIj9roGLUteHUSwVDfgl4zz2cLujcNzCri66SppbyL0CzZiYN+NV3Uv5TW8TSJ/8a67xA5eDK4IdHpjOPP3Z2Vt8ohi5szJkb1UecyMgbYT8QmEvECOX8nJkRC/dHPAKf7yjP7RWm7M2JKC+uXBDCsjJwCqk6c2p6zLWbazmqUucDU9r1pB3ho0/rGItXDvMU3dilTDqJAApK9pDWMebmOmFiQiPPc41jHuzAw9Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqQUfPiEIG3vNuWWU3K9p5h0LL+Eh6YNnsaGhJGGTks=;
 b=r+DfaNUVfgGzdW8QH+ydgOzC3hRUpr6/v1Y72EuabmYX+KpNeY7tSn+F9yqt973vuW9tnlSMEm4Lsfs+P0Y4ZcdgVAEduI1zZgtIjoFHcj+ghDAmg/FNK4MSk6hYG2pQterMSBxpfhKmjQt7daYbMW0OOqgXPHMyr5PNoKlqpS9H3JaH+YI78sXv5QutAai6ep06lH9Ev4PC1LV2zK3TlIkwdjfw9oKMp7PhbMVnaebyw04aKorYpe5qj2a90JJaALfLp9xbS8dl5KjV4uYwqqeYk955uHyBcMVvGg/gWKSKHkQtiUCEi1o5C3Ukq+UX0FV9p8jNABJjzhoV26sL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqQUfPiEIG3vNuWWU3K9p5h0LL+Eh6YNnsaGhJGGTks=;
 b=hXgRNu5ut02fVR03MhGEfs4G/39ZoTyiaEVyCsnmayNXoYAFT0thVIsNzKTM9+qbqzRkkl3Ov0Z2J3zSNHtuQXFvmu8Z+dKHZgL2YwmpY3zIDBZvxZWtdrwC5i1Rx/1DzRI7BoTRbM/5mSVD6kLzmBSUUng9JlSKA5xJASBLpJey5IqK+6dN85GYLNMIx9DYHgj7pJXgTzXMs26SyALz8v/CpeiRQtn3QMu38HNbIMNsB7xBTkfTvfv6pGIzX7fb+ZbLP9CHdDIq1YC1JboQd1TZ4jdw7G+kdqPimkhWGURjxiDjuggyxZ1oCDviNuUIcpu5BIkqKF+Dk3Yx+cUgAw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:54:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:54:00 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 23/26] vfio-user: dma read/write operations
Date: Wed,  8 Jan 2025 11:50:29 +0000
Message-Id: <20250108115032.1677686-24-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: dd42aa46-b14a-4ca3-47e1-08dd2fdb23a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xEETUyC5k27ZPXtPcbwWR/bI9An4XH5jAiKPn7+mAWpVHRT1ULbFEoeAWtmB?=
 =?us-ascii?Q?UkOv8xI4sR7a954cPVE77i5+Zs+JjbpNMY3u4xKtLnk4qvFrjVwTCuIH0GA8?=
 =?us-ascii?Q?LU0r07t8nX8H/ud7BiQO6iWrNMTeLv/nsFz8Ib4oBolX1qJABK4GEynccP66?=
 =?us-ascii?Q?z+gIuTvZQKX0zwTHcc7bp6VlNEvodZowRrYG0y/gqZI74PiY7RPFPJa81rwx?=
 =?us-ascii?Q?NLLbEyXiah9joF0d58nBLVdRP/BAu+nDlTBZDlPYKVuJTeCtl7ntgE/h7i08?=
 =?us-ascii?Q?XXTS24ONrl3IvvgX4QsaNLVblFnugvgDUJuzPUhvJ6eyCg9rXf4qzDSAvMjE?=
 =?us-ascii?Q?bP/rCT4AXtQxoGDpJhgfsDKGQaRvW34trP+KP5QCXJ0cJEYT+a85K5BJCGhC?=
 =?us-ascii?Q?OL46eolXNQV7rzKOQ90x/WHiJOnXxar3D3a6tKOIvbN2FZdUufzwGh8dqtOb?=
 =?us-ascii?Q?fzaokfNrmsumITeYP5qRN2fTvvJvOD/0tMzka1/XGfX5KDTaLcOZyMB7onD/?=
 =?us-ascii?Q?gS6NJcKxC1xVjFAVlGb0v6e+G6v8Rf9t9HoEK/WfQ5sTrismHdNo0zKkMpJ7?=
 =?us-ascii?Q?pYPlWF15mRQW3NetEYjFbFXU8+7ZqtkCWXHb+HUxtdSKaybmOivAm6ZjmUKq?=
 =?us-ascii?Q?haDbM2yTTBv+J1D6PWVyzCpAwAARys9WpdLEjvEonTPV7VxOcdsrcC6iYFc7?=
 =?us-ascii?Q?RMOCsVdm2kj8LPvZaW4y9khQRiVBgU7hAx1X+D6cMVfquCXRk/HIz8RWNsT9?=
 =?us-ascii?Q?1lOnhlQzT0e3wsLj4KgFDZPBRr+p3qaftBLf/BRqSReqrr0cNcnu0GGo57fE?=
 =?us-ascii?Q?d6UbNJzaNlws7SWEaoNSvG9oHBzFanzlJEzj21t5428DWvfKp8NAikpfzYNY?=
 =?us-ascii?Q?gf3HFc94gqU4l6x3WaLE1YxvZInkogBVlVsHMXhp4ItGujHotTJh8YSeQ5Tb?=
 =?us-ascii?Q?5mN0I8d87U/RgwvdtJk5+kTexYdah4+B42B4rU36Dalcstx5PfXCeW6vz0GB?=
 =?us-ascii?Q?1UY9jK6KVTX1lBIr8ryl1vhl6QoslH3YYXrO0mrtcU7D1D9iLO7mYtiE1HM4?=
 =?us-ascii?Q?eSOeeox7sVmW7QefGdoLqxaBj0zkNOg4ZsEAVQW40DqpsIMG3xvWxYTwNx9n?=
 =?us-ascii?Q?8rJTzfr2OuC5ArFmiASpzf450EV4ZwK9qr1JW/cF2Rpjxa2MApu2RXofsB7M?=
 =?us-ascii?Q?SWUYQwKCDlprc+s16Y1NwEK3jZL/yxhwMNgml0CWXwpIOfJcAYOmnkfwaNIs?=
 =?us-ascii?Q?rrEa6N6gaIjrA5m+IHaBKeo77voPmGCRhoAx8G+8SHHobn/dUz/JmWZSJ9Nl?=
 =?us-ascii?Q?XbredfcPLQ9HGG3553AI5qiGFASzhkumsVBlSWIya7yv/SNYd/6SuyxBV8Wk?=
 =?us-ascii?Q?dMJYaDdPV0/bJ8R/TaKIoSY4CY13?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGsyeEQx4JI+SD+iv9TPcYKisv/6l1K/SRHruzxh005xOGauMC9Bsz9EWDOC?=
 =?us-ascii?Q?6lFVXeP4xDtp05fYSqvOvbmPvp71zX1DoXnKYfpQZkQSav/FwyzborfFwLPX?=
 =?us-ascii?Q?fRVdbuWL0PRQxoR75+wIfLRxjmwkG4zUoBcMZd6UbQUCUmNXa9VS4+ka+0j5?=
 =?us-ascii?Q?AYs8xKxhZtSc7j0eeFQRILMZ2dGLNg5K5DcfTukHR3n3LG2DwDgwdY8xv6yB?=
 =?us-ascii?Q?eBK0cEJYrVs19MdmoZFvSM2MPwkX5HlA79x21kh1UCOf5NA8UIP84XIBl8Aw?=
 =?us-ascii?Q?6aEUpLECZI5YHipJyXlzuRdua7I00AkgxK9kxM5DzbaPXFUDFmE9Hu7BgoxG?=
 =?us-ascii?Q?BXft863RzAIx+9o7U0u9QR2mWGAaCd04SwgHVL9KJznP10y0lSebgXHWGJzd?=
 =?us-ascii?Q?vpzYsQEn6qngsQZOXntt+M2aeD6UnG4nOWVZaMZOUOxcy0Kni9ZWaHj2LPYF?=
 =?us-ascii?Q?ppFMJJTXaXA6pgaC2wDUnKjvPQUvazipmsgja0cI/PheCpNrO9PFoAu26F4c?=
 =?us-ascii?Q?ZAbXd4rHUGI+lrTGRP/VTEVPpOQltlzETtX+5ZBBOXwwUR/UK1TxC0l1V48y?=
 =?us-ascii?Q?vIu+i0omiSDCMgLOiNHJGG7uCsbhdQ8RV8RhFE6bOYG8qnsHzoWGrqkV5+Fi?=
 =?us-ascii?Q?QztbjVLwlIOh9wL8gI1aOvZOKctjxbZyZ6Gyaz2JkpDacnn7fUCAtv2xQ5Y0?=
 =?us-ascii?Q?iDb52daa4LpvgcR6Tcy6qL/XuwszsqFESn9kk/45DXKnpAF8YYTt1pvW+bFu?=
 =?us-ascii?Q?5MrPbbz4lBv5Jb6UwyiK0OR6W6+1G3EhIkzztnLB4XpFnmLtZYpyV9WdBTsb?=
 =?us-ascii?Q?2P713x5pb7VJ4doZzB7tKQMoKipbnmXqdNnt6B9NEZfijBFD2EHFRZRdXhYS?=
 =?us-ascii?Q?Xq0SgznRvFvaWxLOehUzU2cq47JE8uMnKFb6AiCo5iSVv88Dhu8KI/jW5Co5?=
 =?us-ascii?Q?P1OMc1OwbNSIg1+vwShVe/WfLKZuwgsqVel7q+Vr2HjL5AmVaKKBLAUU1mnO?=
 =?us-ascii?Q?vTuhkep2gKVzGUWMvkOyK8NTbbtzcJRQZSgJWkjzzwGxjWB/aP7Gluwkah2h?=
 =?us-ascii?Q?FBWz0/Kit1CUq5RrUjL2Qcay2p7t6dgT4i9LZAGx/EQH/Ua6u/vJeKNI09nI?=
 =?us-ascii?Q?JwE/d497guXJdgNHM0mMOcuWYHdWuRZBr2IfOG82K8fro3eXEKYfK3k8AlSC?=
 =?us-ascii?Q?zMCukaw52cLEZFCxy9M33dIrcK21gcaUZvvRuTwTo1AVnupZ6pPxTgOD081y?=
 =?us-ascii?Q?jIcgN7+A6FpE8g6SQICvbjBwXdMHUaCWuNDPkQkT75RwpkrZIKWzZpeBQWx2?=
 =?us-ascii?Q?biEwZ+eaXPAjEufbh6z69BS9zXYorSEWwaf0JYXQhv+K38PBdYHWH+igGHcE?=
 =?us-ascii?Q?EHiI/iUwwlqNTWViX9fs7C0VCu9L+6mWW6H6+0xL16zBVdh25XP5cD5uS7ai?=
 =?us-ascii?Q?IsVOX/SKo/1FOK5TiHDTGJ1aEtU6wBK+aw+YlgMiFjqw8fsDWIXr3W0uxLHD?=
 =?us-ascii?Q?YJOv5MIVD0sixgwQ7rIPlhMVbJFrvIVjeva5jYimGtcnq3XfM3peLun0Pn1P?=
 =?us-ascii?Q?wnKOXpoohnPC/OVn2Yz+X3Ys3qpYMEiBoJU79IHr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd42aa46-b14a-4ca3-47e1-08dd2fdb23a8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:54:00.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4uhXi1hc5uF0M9t8ffghuKWysYz7ElRXR1wuQA61u4TFGYSZsu72cIORBeHSg4Pf8I4o44QzRuz0p94MQsXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=A6aWP7WG c=1 sm=1 tr=0 ts=677e6759 cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=O9TuWlIcgd8LY38MkVwA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: GunQU1rTu2_KsHnbFw0KMMHnkB7dkVlj
X-Proofpoint-ORIG-GUID: GunQU1rTu2_KsHnbFw0KMMHnkB7dkVlj
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

Messages from server to client that perform device DMA.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-pci.c      | 110 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio/user-protocol.h |  13 ++++-
 hw/vfio/user.c          |  57 +++++++++++++++++++++
 hw/vfio/user.h          |   3 ++
 4 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index b1125f7403..8cd397b75a 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -100,6 +100,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -107,7 +196,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 9b569156fa..607e0f4b7f 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -203,7 +203,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index ef644848ed..6f0358bd8f 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -380,6 +380,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -765,6 +769,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index fe24a881f2..fa6bc9a9d6 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -116,5 +116,8 @@ void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 #endif /* VFIO_USER_H */
-- 
2.34.1


