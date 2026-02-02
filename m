Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FB3E7DEEF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmujj-0006h3-VT; Mon, 02 Feb 2026 09:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6493f4f895=qi.chen@windriver.com>)
 id 1vmmlD-000715-99
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:46:07 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6493f4f895=qi.chen@windriver.com>)
 id 1vmml8-0004ZY-1d
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:46:07 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6125UaLH2283870
 for <qemu-devel@nongnu.org>; Mon, 2 Feb 2026 05:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=rvY0xYtkD
 mjjBQuNQZ9rh7SJkZapudAcNhE/5qS/9FE=; b=XL26eQuxDVGK2oCQVTebw8Q2v
 S3GW+NzyEmlkDSjeUfmFcsraGPEE9BshgE2wY4Kr9h5vE/tA6CuoTVSmfAMoNWQB
 Y5yIpTsR5t9RcBLIAUkjBe/Ded6fFOMguGndj0zELPwK3bM1zccNH8Xy7lIbQEGp
 +Clol8B3jY1xzz9rpL+nwIkbhM9nMO9+gKSwwdEl7oW2zyacN6mu1Ws9r8ChqRju
 mu9NI0qJTbf+712WT6IcyWnfeLMAjKiqXLXbENNsvTAzpo3ZcgaKDZdSphP5xJ1u
 ZRMdh1up6uDbe8LbthIQK5U0cCFnvxq3/5TeLyuGiO7PRArQhzdS80OFuTptg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c188jsnmw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:45:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvJyVkkbs8hXYeUqaMViSwTYoQeRDwiqW9SFx5bWyZ67uITBIx0VDmODQidLsUtsn7RHB3DlPjKisxQDNsLMlItK671k6RFs6AA3q3ezw58NEOFjMlVtx7HiOjdLtPu09nG0S4Oq3o9PmXt0Rw+DFOrZzSFH4oGiHAav/n4Cb0MUmKsSQdT12s60ypxN1ih1Er7f7OCdRYmqGvbW6/+IL70pwo5wdP7FGjAB+u7atu2GPv5UWPuDN78Ll5x4bNei7xynXeMpreB9ADN1ZnwxP/ABEN5OMuenLMpaGairUIfHwRMPCYsKJpLsUKRTqn42qoaDXgX6qZC8FQ4GbrORYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvY0xYtkDmjjBQuNQZ9rh7SJkZapudAcNhE/5qS/9FE=;
 b=Q5NZ+FvfMKpR6lxp04+6GJjkBNHj3WsyQP8I9PFKyaV1rhRqK56iBgWaj0lXmdMUL2B8sIscR8Lm3MteRHbc3y5SKFhd6B0nEEAya4JNjBeLFsyB8FNEwXiTO5NLd3+ktwHrH8jiD2jvn5HYDswaj5/atO9BJIQiDlkku3jZ0aS+9i1oJMKouLci9oUYeheNO2PxXy89NRtuEj2qd7sep5JWRZIo24VUo3ZRZN0ArNGc+MP80l6mcFiGeG/uE+mQbh7/Um0VeVZjiWUtc9186nqrUSR7UClzNubiECvtW3lfgNbB5NEzGgsEqUDrLl0oA8a27bQNY51uWoPeDJOXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:45:55 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:45:55 +0000
From: Qi.Chen@windriver.com
To: qemu-devel@nongnu.org
Cc: qi.chen@windriver.com
Subject: [PATCH] linux-user/elfload.c: use get_elf_hwcap2 to fix regression
Date: Mon,  2 Feb 2026 13:45:37 +0800
Message-Id: <20260202054537.2538899-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA3PR11MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f063fb-808e-4ad0-ebd3-08de621e5501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gOr23wojHdaYB1Y2Pog0rBswEqeZf72YMoerdPKNvGssyJxX8aa5uXiXLpuH?=
 =?us-ascii?Q?cf/NIzxizvfL7c9WxjItLaxaF5bXsvXEE1u4VqCdEMQlzGjn26sQTiiDzZCW?=
 =?us-ascii?Q?rjS76rfQDqMD0cCloNsU0F/KOM95BUcoSn52Tux84mfCGj5n3+PbC/gzR2xb?=
 =?us-ascii?Q?V1K2Pux5GJCa3RjZQ0hOFzcw8QabDVJnZSaGJvsh6Xw/Yh2ohkuxUasZPGmr?=
 =?us-ascii?Q?z3AJSeJ7sQxE6ESFzP6I/Zuz3U4s7+mlFWBW6JvqxB0s1QRRPI4sIBZ5Y6Vo?=
 =?us-ascii?Q?aN2PRNQTWo6sZ8sCpZj6uQD9QcuN+PlXBYDECn+CDi39/wgcwTYTFmaQwROr?=
 =?us-ascii?Q?ttbj5Njd6htcfmw1RAopJ2gvxTPgE/AYPe9wF093BRcww//B3UK3PZh6B4cE?=
 =?us-ascii?Q?XDAK2PtMlsDlgoXBlJ1gS6j7NNJJLvziiUYgjG/uIrKl4gFLrdrXsI86kW9k?=
 =?us-ascii?Q?yuOQa+g7QVO+qqyiX20xmYRFVCk6GKUjIa70GhmOM9LW19m4JOdIOstoW9a4?=
 =?us-ascii?Q?yIk9Vtmx313vzSd+RQftITqxrsGhOSMtwwavZuvDVBWM4/T0lVeFgAAFfAF5?=
 =?us-ascii?Q?ZTpgYAiFvbtyPzYKAFLM8cIoDg7dUHh+N0gVTGP842elw/eeAnMQL9lnRuz2?=
 =?us-ascii?Q?lwpzwKDpE/0/NvBt3PxdXWt9JT9TOtFImpfk/EZ1LJ/dQab3SrUqRnIxpLin?=
 =?us-ascii?Q?z1XPr/FzqP0O6kwwQovlUfvXSLV2M3zNBDWSgAEUkdXhMdB4OSkZPPbSOKrH?=
 =?us-ascii?Q?6mzJx5gGMXYSgAG9kStsuCQSYLp7oP/uesI5LeYPveA+psI6RKYBwAjKzcuZ?=
 =?us-ascii?Q?zM1QSuU2q533GajFxR696c2NtWcZ2vHG6nZjQU1dK5w1zO+9jJOSSrA6j1QV?=
 =?us-ascii?Q?uAZM4WhpGM9x44C3gGpWETK3hhnR+aHNgjtkDNb7gnFquF5jOox9buXapuPn?=
 =?us-ascii?Q?ZKyOrdUbq9EQl1kaH1Lw0WYwo8ktcqELlMaEfbiUjKDHx/Lq3wTJYHHCPtkF?=
 =?us-ascii?Q?x0KkdC/AX/xN5zh9PeBjc3rjEIBUCM1WQ+ikWRx5WQckdHbMSdmc9b5Xp6NB?=
 =?us-ascii?Q?ydsVe+rnU0QOO8Re/ZjoxgzChr3F23SXxknjenfEUgCfRHRk0m51Zc3tYMB6?=
 =?us-ascii?Q?ZN3OISmAZ8gELTIqJjHS7J43MmmYYv1WMZMNP/7NUOok2vOfoaRtvGl5X0dP?=
 =?us-ascii?Q?kdZ+Gtj1WaNhfY5fk8vrs1SWhN2uNfqpcnjhjRm+kIH36VlfeBp38qHmQGMU?=
 =?us-ascii?Q?jL4p1A82uVi2a4QAIRR0LE0rtN3jgzvA7xzEajkW5Ua+cRH6gOWP206AQS2i?=
 =?us-ascii?Q?OZbyO8hmEtScPBpdEHKrFGOgq46zHQo4FfdARZiuVJnb5ziKrhDlbV9gyVS2?=
 =?us-ascii?Q?uLbLJ0BPCQgyr1LLCCoefjY1KY1p/tPb2jetNcW5XMp4x36hOuey3EK8zieo?=
 =?us-ascii?Q?xXh3GGJIcMtjInjdgVedhtgrntdoObrwRYHM1qCyCx+jOPlbQo4kHfCcnqvp?=
 =?us-ascii?Q?XmpCrvOtyuJSD/BmKkHiCk6S1sHG4eFpzskMZoZZLWPZSD+hhEqesI3KD1Gi?=
 =?us-ascii?Q?viTib67XZRJNXt4JHaTQW/2W5+88/j+fAzZZbd5xX21Hk0TuuNcIoM5ndeXv?=
 =?us-ascii?Q?6CW/MZFJXAAe0yyyGDhOTmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5602.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G//kSufs5ukdLkAwn6zMEiOPb+G+K2x0TFlnZUolYMuqwyGAOezPWiapQf9T?=
 =?us-ascii?Q?SzslM6ZUBbMSgGdfi5edQOOj0bFT2ttIDPK3r7WhfDHfKbTgCaqZqpRFsW/D?=
 =?us-ascii?Q?t2M4vnypYGaNHQfNgX0orAazKYfc3WM6auGB2kotefFEfMmFiflT7gKT+JOC?=
 =?us-ascii?Q?2rGVsaFr7RLpKshNVM+dV5a71007x7MPxymM3x4C9ppzz8Sj2pXvE7jirchc?=
 =?us-ascii?Q?3gtydItHNPRfgAsKp4aP4I6MPwUeOc4BZuptWiXUwwl6D7nzKEaJKH1xusk6?=
 =?us-ascii?Q?/rG1CupRe+qwFgTTfw13xc/rzJY5MJcjcR66HXB6jYBMWXfZeUZLpxf4kV3G?=
 =?us-ascii?Q?lcpHj1Zg8fzNiYCewzEkhvjEFkLZDy5YaQKmbv3TbwewsE+wPjO1SJXeMWU4?=
 =?us-ascii?Q?j2cOApsuj5xI7C519nNjSLUraJapkvBtMn2KYJAw7HHYahWGGqCcsIUJzH0a?=
 =?us-ascii?Q?Wy50SwDg3VBw+zfFtFs+jVNlZ7OJ7aRqOoBK2Ni/UW3ynXE8LU6DvdYM5KZY?=
 =?us-ascii?Q?bkPAM0/OQLRuvJAnR9df+E27gM+pCj5ehz1x+0G2TMRjmn2UhqGHY97/yRNh?=
 =?us-ascii?Q?7BRNljyYhq0rWNs+hkuQrDB2cI7cpBzuVBArfU+26SZpKDVaFZgFBvItWhr2?=
 =?us-ascii?Q?fDiXo44tV5F+g8Vhzu92MsTG/Qshgy5u4xJXNNrZQBCACT2t8C+nThrZ543d?=
 =?us-ascii?Q?DnbuttQXfi7d30V8QJu5Ax1dXIdfo2D2r2oLoDe9uf9gScqfV1mu5LvaEnpQ?=
 =?us-ascii?Q?3R4SgAPxcUUkqYPaR2gAtESCZxLAvxLFO6gcfrTOyR3BtpbSWMgHk9DtzvHb?=
 =?us-ascii?Q?VWOodXoR7M1f7/MFg11MGYTHD2/51OoFS0HdJH5M/nsiZvrTDKJiNOOxbws1?=
 =?us-ascii?Q?YjernEe2FGqbg8CDmxJCk2BldCRLQhOpxfOwuhnmNZXMUftKj7GJ8otkPgrg?=
 =?us-ascii?Q?sfSZppIuLh3/HqNmLKj+GPRyrpD9ig4FKjjbfCY1rPhYnkEJgY+/Nahtf7RE?=
 =?us-ascii?Q?P2TM8yTedwZaq37br5OFkba6seb6vjn5M02O9OGy2YQjiXCxM+Hyd/qBJe/8?=
 =?us-ascii?Q?4ZHPCnLw6nQjZGqjAzTwQAEhqyS/Vo5V866BUZXQdXJPyq/R6vnKPVEi601K?=
 =?us-ascii?Q?5wsnSDt5YasjRnsI9vXpODmKdIjEPa6sgSvjL4WzYraKCmSgtN3vsSGpSveW?=
 =?us-ascii?Q?xc43YHkM7oQwOPLozlrtY9rOTqL9EgUU4VQhnyVS26oAREKtMi5tVeQQQsNC?=
 =?us-ascii?Q?lflbDUcxWyGcPfkh9AknhZlV7Z6Rl3FTGSrqFxM59XDANwNUQXdFaDcn7FYl?=
 =?us-ascii?Q?7tDTaKuU/nWQve8mR/8azAClYlKMaVLoq21CVtg3zpq27v6T8XORFjE6liaK?=
 =?us-ascii?Q?xaF3VlS5l76Wd9x5BmXsppFIk8hKmBoXsQT3lNVGt/dLd/KJajQKKhJEjwjD?=
 =?us-ascii?Q?GKuaNYsxCXXJRsSVi6FHmFaMpH/N1iCDeEd4YAKDUY5RVsf19Tp6TJ/1ld6U?=
 =?us-ascii?Q?D0EUJsP1ScNANMUtk2qVtY8CdX/HFkluVLiEzkSQ6wAoZEkUtkOSCX8WNEQv?=
 =?us-ascii?Q?AU6aOPm+vBOn9HhdN6Uax6821asPuRGcnIB7sUu7Ya/sbTq7Ii8Qv/mrDr2j?=
 =?us-ascii?Q?hA5njD3RygXQV6A2VRg1WV4CDURZoDQN1kYsizzgpfp2xpRaALdudUNU+h0/?=
 =?us-ascii?Q?dWXZVv7pUPWaGqGATf49HMwZbQWVMxEgsvm7FWHK5SfZr9ve7twO+qm8RVzL?=
 =?us-ascii?Q?QmNfiy8IpA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f063fb-808e-4ad0-ebd3-08de621e5501
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:45:55.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k8JSUoD6Zjcjf8suisibSuBMgwO7IUqNtc6aLE1YeL3xZCK/gk6Qh3zmjSxlqxLVloXwSPTrx6WPxvDXkqgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9016
X-Proofpoint-GUID: rJPZ5mwNWHRBsxDyWAoAOZGweoRbShD8
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69803a17 cx=c_pps
 a=lBUCPINxFTLumcbCLOYEQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=xNDYkTBUKYT3X-vR23UA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA0OCBTYWx0ZWRfX6zcxIAOO26jc
 7lyqByPbF/X7d9hrnSKjKFw06/oR/uWMlptCCVj7djHXEePo+AA0NFHMM2BtvW5Zm7TyX+y3YMB
 L5YrERV7MXTkTKHgyV1UQ87fVgvVf7g2Zx4kuWyuar5ubUtIBXTxwsI7T7LZs0ZFzBJrX0Th4to
 k3wtO7S0R7C8xf7pSdr84GK6/SpU3ewR+GNYufVuZDYo4R0M2V2FHkyKRsRFPOFZtkwgstSmiGo
 wRdbSvx8DZDpjuqkWBbRn1htbZ5ZOlqSCRvHJltRXX896vgIwEU4me+jnoAkixWyrvReJi17p8U
 EbgMyu79FdyEMx7MDpDT4704H4b2ylzzEfiEXynsxFjxJgg3YnjHIi7rm1ZjA3ScZvXIURl88or
 GkCQ2kNOspaJaGFJ5PUr0FKreLpYPEncWTxKd90/AdmQFDvT9cyPUhWJgPw8kgr7b7trNedicsV
 OMN6c2qPRaSiyIn4y8g==
X-Proofpoint-ORIG-GUID: rJPZ5mwNWHRBsxDyWAoAOZGweoRbShD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020048
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=6493f4f895=qi.chen@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Feb 2026 09:17:05 -0500
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

From: Chen Qi <Qi.Chen@windriver.com>

In commit fcac98d0b (linux-user: Remove ELF_HWCAP2), the following
macro is removed:

However, in place of the original ELF_HWCAP2, get_elf_hwcap instead
of the original get_elf_hwcap2 was used.

This caused serious regression for at least ppc64 user mode. The
error message is like below:

  Fatal glibc error: CPU lacks ISA 3.00 support (POWER9 or later required)

This patch restores to use get_elf_hwcap2.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0002d5be2f..35471c0c9a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -708,7 +708,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
     if (HAVE_ELF_HWCAP2) {
-        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap(thread_cpu));
+        NEW_AUX_ENT(AT_HWCAP2, get_elf_hwcap2(thread_cpu));
     }
     if (u_base_platform) {
         NEW_AUX_ENT(AT_BASE_PLATFORM, u_base_platform);
-- 
2.34.1


