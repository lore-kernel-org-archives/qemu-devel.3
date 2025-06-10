Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF10EC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 09:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOvhf-0003IH-RT; Tue, 10 Jun 2025 05:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOvhV-0003Gi-Uc
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:55:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOvhP-0003KU-II
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:55:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A94KK8003424;
 Tue, 10 Jun 2025 02:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=n4PPN86zL8fq8JQ1iuYw1gHDsnRU//S9gvOHVG4MK
 9A=; b=It6GQB0wWAR0QomTcQTBUmsXsrxvXl23yufV691ZCJIpUC2x3aWLrB87C
 1ZA/GcHPN4LoHxAEJ3xvPaj+H8r20Q4c7ySfH0Zl14gPFon4KVaKxZ2oUKV7Ma77
 NGWWsoKBo/s8uxvOhFexs+z4oufNEvlf48AsVlJORceKUm2vMQHKKJvA6Zi2/WKl
 e+Df6ig0HJsPv1Ky1UCKeqQLm0cDWjsoK0kLBJFl/JN+0nOozznvFbKEL4SiIRvy
 VVEels9aGjg5ZgXS202WdtY0JjacZ5VRNd+Ad8YSgorkI6p3CGkA42SYoi5vImZq
 zfxZGKMAnWY3csln4THwfsUr3d+OQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474my0wphh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 02:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPAvRvLehSA1VHfxeEt/2Vkz2DCNQKndTqIlE452nja4U190UTxWSwpwuRqnvNFRGlzJ+VCfNPz40/O+DSaaTLg0CCKFE54Smr9KhMHK6cSn/9VASvdiIcCrIKe5se0wPH3v4XN86ALn+O2ojsb9MevdG3P1jncMDkaX36iY9EUpyGGZ2OlgZxMGvPEEoukAcOemiN8I1l8Y9ZiZO2+y5sd0V8Ny95fPd1zHWN1AX7QawpwodK6tHgKzZt99XN6ufPd2w/aLwq1XPLu+optulw5UKMOejnQ3ci0ARfV74Tv4kVvarngw8QEYQEmOsBJDUGCam4+r41Jytn/UR9GnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkqG3ONNGzsAngt6qEtnvR5C9nDd7pDHp8vhlPWdFzc=;
 b=QMYekTmxBK6J7bVVy4BArXSavbJs3hOW+YQU+JYvtyGxw2FZNkOnHINoveHB1mWeLDm3zGQescbC/GLIfZbxQSMXj7BXC8WjgZ5rKivGDD46Wreo+PJ4D3hDchvfqenE4Hd2PYOx3M5QLA2tjvMpHp/PDVIYfGWRXOpaZyVl+J8txnKqLQcbP+S2aDo/kNv/VcZttdlgZG2Ge7EJwKWU4sBj+SlDEyyhaQmZvhUuWHb+H5Zc5JyRMx+N7Y048LjOm1xyxJK5xjoAR6iTnaHM4KnWUY1GFqb6P1BMkiUurx7K9nkRZ+ZLrXNYEGiSGMQqukwzGCk6IwyatHzPZ2vJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkqG3ONNGzsAngt6qEtnvR5C9nDd7pDHp8vhlPWdFzc=;
 b=llTgF7S4nPcagy7uwgvG9u4LV2fVl6BiAtHaflX8fzJWW+lVyo2bvtQDJF6/BhcuiXdEHgktVUNTvQmbyVOXx2yQDDPrEm5qD4HQhhCqPVHatmYHITgaU4lKMAkJ6Zx0MTB3kyntPZILRs8m9XJRRj8MdUMoA2lOHztz2yn8xDBZ7JdhzkYLGg4gdiYOMppv8aIvrrV07sWSQhiSb+gr3XNOcN3dMtS8CLuT0ywHs1WXE648ek2ZML1QTzMAwFub3/VhS/y1w3gsFaVdE3WZhSHLAfr5cs4pDQPH0ySksmyv3jeLow9Pwk5O+Dv3nPjlhisNVMVCI+G0tQdH0RtYjA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO6PR02MB7729.namprd02.prod.outlook.com (2603:10b6:303:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 09:55:14 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 09:55:13 +0000
Date: Tue, 10 Jun 2025 02:55:09 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 05/23] vfio-user: introduce vfio-user protocol
 specification
Message-ID: <aEgA_U5SZiYWs__7@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-6-john.levon@nutanix.com>
 <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO6PR02MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2d7996-28a9-47cc-04ac-08dda804e4d3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/kIplzgwt92Vk5ESzs9lG2x3+dMpXkZcPS1rhPOADhzNTQa1TO4w1rUsID?=
 =?iso-8859-1?Q?xurVhNt5eN+8ikrGbH7rZEaYzwv3jzOcMQ0GIlHNp4xmF9k7W0wBjTT3sY?=
 =?iso-8859-1?Q?DNehA6LjeRuBKGAEBi1Nn848aaEtUXsZyOz7h8OMFGS+oO+TH0se2fgoMk?=
 =?iso-8859-1?Q?wMnFauAiW2mWCmsGwDDFs/0qGZLbIBVPoP4ICPekA2gsNrNO7O8NFPXUie?=
 =?iso-8859-1?Q?lLA/SmD9IzQwOnbntQbLN50ig/SxxdWLUMFteOKeuscePl9M+34ZCHheGt?=
 =?iso-8859-1?Q?QZqbEEzrhe40plhpf2XNAyGhxEmvU5rpVxpBQATmMKceS3QLlk/92ZmGuR?=
 =?iso-8859-1?Q?m2c0U1mgDd0c0OWTGqRju/b/l7BN3SOCvwfYEGD0vxPTz2tn+eJVtuLvCR?=
 =?iso-8859-1?Q?m8gbju05zGlbOX/G3rl0sZ+grWMo9+uOAziKT1YEt1lmwALnrT0HI2uxYN?=
 =?iso-8859-1?Q?cjE14Si2DIQngE9G8ncxcQ79vivoK+AxyQfgtqZoSK4Pkfh0uuxG53vPPe?=
 =?iso-8859-1?Q?b5y4etRLxXwlL4N25VSgWBwaI6W/Pd6FqCQB+NE5plbLvvKB36qssEunui?=
 =?iso-8859-1?Q?xZ7eY6bPj2UW1hEc3Vottm4Ybi5uThKUss48DA0IjKIptFrZmJY5SvpwSc?=
 =?iso-8859-1?Q?gyxmwOXOZW+bmfnnKjFNycZDyYM9GJQ1oozNu83ZrJWGkUvgRMFz7w9Mal?=
 =?iso-8859-1?Q?sn1cfNcSXEcyAq7SwG0b8XxXxhP7Zz/iaWPjC1QaxqjQHvviELFP+GzN6d?=
 =?iso-8859-1?Q?hEIMsemopfn4ehjdaliPfMzJv+pusVd4x/C4d75W4Ng05kRoudZceDekO6?=
 =?iso-8859-1?Q?hHWhaMl8tOlTKTHkMRq+EdMVoqAJ//Di9fwGQsv5UmgvBHLzDfF30CZHkk?=
 =?iso-8859-1?Q?mTQJ/ehcQhP3xqwPBiM4jMTFE2Wma8NGA/4XYGm+OxSIojO7YTUZNcxW6t?=
 =?iso-8859-1?Q?t+jRjlEH2ACHMspcFywiwbIHeTbD++RAQCjpfCe50B1zBlGAUdNnf5l6gJ?=
 =?iso-8859-1?Q?cEuo6pYYpUqiUG5K+82TJfje5wVt5FXXUzrCBieby7SVuZ2zLK6w3VjYiC?=
 =?iso-8859-1?Q?v11gHFNXptwrsWQItv4tYwV7iEVqSOvGhG0Joa+oIVQx0tN0+xQqGBofab?=
 =?iso-8859-1?Q?WnnSMBxFL49QDhOS05RUuXES2GClZW6KBQv8FmglUDx6kkbsPB8m+h1Yat?=
 =?iso-8859-1?Q?wofhn7HmAztwxCLND9ubA6Spgrk4UTFL3zz9mxqk0q5jU1Ww2pxGlrOm0+?=
 =?iso-8859-1?Q?rDCxqCfTxgMkwC1cpv12jQ6pJzq01/t5HcCNggAh0a0YwMI2dFc0KiNzaT?=
 =?iso-8859-1?Q?9ZTwS/sOSr9zWxbvnDWZgayjc4eGrwJs5mZ3k44VSOP+P5/M7R5w7OPR3i?=
 =?iso-8859-1?Q?7HkbdzSIUrZ1bgiiCpGbw3HqbY+B8VIiKlDPYC7kt1ezgZ0AkBQCU+Sc0h?=
 =?iso-8859-1?Q?3Gz3ixVcPROv0JVBq9OesDS5hBC+4nrfraJnJhK+i9VnY2S2OXrmWAtny/?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LvX9NnNYPqVU7NaAgHkLC99Ok6IexWJAXhCmiwBLwMqjtl/vSJPYdaj6ks?=
 =?iso-8859-1?Q?14XV8CADdtD3GxQGXJUR0hVB3mDMy+FhMe6G1rKDNmyh7sCMv17wA2eSoq?=
 =?iso-8859-1?Q?ONd+CriJi7Bzxt4VexjwxM/ELgtSFy2+B202ZWrRDJ24/EiuF/Vx7vjyAj?=
 =?iso-8859-1?Q?4X9nlwJhW6LCk5EZ3URUgegWZUMA4XyIuPKbWSwPfo4yVXj5McAe6EdQAN?=
 =?iso-8859-1?Q?v96k+76s/iCIH3XjmPzLU6ssl7BOyqkADOdcv26IQaYe/LYLre4QVJX+ax?=
 =?iso-8859-1?Q?FofLOxSkLOPAwy6kHqziEoSOaLL7AkH2sNsgMGKXHXbZ+Zgz2ZgYss9b3Y?=
 =?iso-8859-1?Q?Ggwgc/SymQ2Elnn9gzfFZYLFXaOmR2TTTTD78/HIp61vHivihsK81aiAlt?=
 =?iso-8859-1?Q?O2t2vKiZOAu4H91RJs13Jk1wXMO4+Wi346hQ+QpCv/hmWAIldFGcVz/0l8?=
 =?iso-8859-1?Q?JQhE3QC1FSVUxWue9LWge2WahV63+HQNdZWyN5Ft78QY8QTvCbOfLxtGXc?=
 =?iso-8859-1?Q?L7h6oIYttPm2UxXVnY1fR3b3+8YpO0WALqqhGmqq8m9nk0LC2E4tykcqGi?=
 =?iso-8859-1?Q?yJL6CWNg2DOuODHhCL1wNw8qisALuG076N92Ru4SM+g6j0KW5xXgLHseCA?=
 =?iso-8859-1?Q?4san6LOFNzW66Uvvd9LBM4EdbgTtq+dYH87MPuXPokMd/cZ1A0tmbOtKJY?=
 =?iso-8859-1?Q?894srMEliosFktS8NibwLNTP2kxYY15JTkn/ENDc51ugkgYyZzyGxgQQtK?=
 =?iso-8859-1?Q?mO93cPTk+BCuNkPqR8iuOVHdMJ0zKbPmcd6G8W29UiOXzKTiyMAbViRgAe?=
 =?iso-8859-1?Q?Y/hOb6qaKzXiRnf6ccDa2atz3CxAZk/XNZqktTNwl7meGQjF8Ttm0h0+5G?=
 =?iso-8859-1?Q?x8kyLHhTPM6pCiMgMxXx/iYBm4XVMN+o+dBIKMa9fbBhrhZwF77AqWBmbe?=
 =?iso-8859-1?Q?RjArdXe0zBz41U+brsbiWkGdnleP1d76lHTT6M0tHr05Pm5di/zf81jqkg?=
 =?iso-8859-1?Q?mhe2dyQ7Z/WWnfDaCreSyP30Ue5ReOaKfVLRaiGz5sMXacbjbVMMyY2Bt/?=
 =?iso-8859-1?Q?WEHHYhcbvobWxR+8E6nV2T6UboR9VF1vE5pvFBLzybqBjNKZdbwNlSSpBY?=
 =?iso-8859-1?Q?y3k5TvA9NhWZ78G+IEDgRT/Ry2gebR8DRHiuT2cWrktvh/kWvuPg0mhMQC?=
 =?iso-8859-1?Q?StpVG7EFh8lCniqQIMp7cFs+aldW8pIumeDf1LUeywcQXTD9t3EQiXZ2Qm?=
 =?iso-8859-1?Q?64tGkvbqYWWiGGAyvmDokQdZqzoJ/aHOiBab6SWA127JW6Ckcyp/xBwTNN?=
 =?iso-8859-1?Q?GOShWCp68Tl+XG9/ZK6Eob+tVl+kHbHK2qat7pnrvAddVq6EY+ZKfd4KrM?=
 =?iso-8859-1?Q?wAwO57wxI5lFHzXhgXiy2OY5qFmlaNWZ3mgYd/Z8cR1nMFje3+im+GGhMC?=
 =?iso-8859-1?Q?eFQ/lfT/vpujlY0qBzwmm/h7U99rK39Oq0iUGVWmVc88wGfOV/cnjfDNtH?=
 =?iso-8859-1?Q?aSXWNYXSkuUWkCTZUULQU4fd53fZQqy8RSljeV4fMmMTdPdlcBa53iN7qZ?=
 =?iso-8859-1?Q?LgPnl2+0YrHe6zkH0XO5RIBYAMN7Hu1j+NcL6CF1CB1ugimzf07MgT9Hhc?=
 =?iso-8859-1?Q?Sun2rQk0RDKE3CeWPTjfzxy0TbPb2MMLaP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2d7996-28a9-47cc-04ac-08dda804e4d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:55:13.1503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK0+zXpUm+7hdeELTHSA+lbHDaw2FScdr7sT2vdK+D3Xh7AjYeaS1WyLobB9Y96XecpRn1F+sdRFx4l5dj8oTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7729
X-Proofpoint-ORIG-GUID: OiPeym7nfEpXCSMqsb1Z0pe6umgwFVvx
X-Authority-Analysis: v=2.4 cv=Xt/6OUF9 c=1 sm=1 tr=0 ts=68480104 cx=c_pps
 a=SWO9grYKeR/AU/Iit+pPqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=N0FpcSZkMYmQBFJp4F0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3NiBTYWx0ZWRfX2owbi3YEMF04
 Tzrx8eOrlq7r1Vw2TAubteSONEuV5ZcZJPU6a37fYMqdrDpdsEA0tUwyDHQv6BHbKjKVH0NsZch
 fcee64fJTIFrzS5cwdxALJTppL/qrrpbeiXq5IRFvyH1AV48cZ0MDqFpGdfiUV7HiFZuKUws1mz
 HIF1K/ZDS5xmeQfnW6Y6SI8YWaSz+wGw1a5sLZs9JeMb9beNhzUyjuOlWaTleYyhtCsq73QUEVQ
 QaGbxUEkwBN+NInww0w88XTut2+6azeRXLEEEswOBeoW3vhGgbWrRJtyfpQ/1AGprbba4MAaC5v
 SSRCvx7sbrjyLgG6zgnCrG9/5ETGalizz+5HZCAQLBALEaHOPYmwlfLZedwt6HSrhJIU6D0olWM
 PYHBgppqUVDp5MyFfAyh9mq8Qa6HIgSqH66vI8LOnEOohilAVvdCfTFqrwXrbecJ3slvWQ6a
X-Proofpoint-GUID: OiPeym7nfEpXCSMqsb1Z0pe6umgwFVvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Tue, Jun 10, 2025 at 11:38:29AM +0200, Cédric Le Goater wrote:

> >   docs/devel/vfio-user.rst       | 1522 ++++++++++++++++++++++++++++++++
> 
> I think this file should be split in several smaller files. The
> protocol specification part belongs to "System Emulation Management
> and Interoperability" section.

I can move it to interop/ sure. Why must it be split up ? It's nearest analogue,
vhost-user.rst, is one file, and I think that's better for a protocol
specification.

> We already have a docs/system/devices/vfio-user.rst which needs some
> care.

My series adds this file. This is the user docs, including a device
example, so independent of the protocol specification.

Please let me know what care it needs!

> (and functional tests)

Mark is working on them, there are some difficulties...

regards
john

