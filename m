Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F830C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9h-000319-MQ; Fri, 06 Jun 2025 20:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9g-00030o-Gz
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9e-0006QI-DJ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:24 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Lu6GA022566;
 Fri, 6 Jun 2025 17:11:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNav
 zo=; b=G3hZSBhd47wkcnLR66KPStQAwYsXXpkuhzDkNdRz2eZDOafaFkr8sHJ7J
 LW22aSg8md8JKaPvbPsAcWzeRoH9IQ5eddJq56b0NVn5bOVnjVDs8k9nhGAmZyJc
 PEadgiIno1ZEiI2asKCMKq2nQuQhd3zekWTzBbnnZ/txE3RIjKm0b99bL1ljRJQR
 QXYn9CxLxjj4hwAk28mxTPToPB9H5GhWhjl7zeB0NL9JYvHb09fgS3bix4F+GMCH
 V4v7cCqb8PmTXWxlS4jtWROg1aGbo9qIBHb//YQgSqmhoFYXZQ4xc8zJ5dhD2rw2
 Q6sUFfSTA/Dwv0LpWRIR2e1Ez8hAQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWY7qLc5pCu3q9H9Fq3RDvBgjdC4y+1UW7cft6psOY4Kz94ns90LNj+GlwVOowmkCTHvDkG8TRak/iHNgx9cam/4lVbZs4SxA9LZwu3r5RNbMIlxiVeChodvu0UkF0Tp9gq8WwcqVfkVIbkJ0XpGQVjPw9V7gPcD4D5nOp1alxjTlPVCJSqtESC1TbCtzPz3UQ8tP7H9dJhqn7Q+9LJv6v95N82Nmr8IZTahXMpYD1As+o9i0GVlw04+3bIjW5zvjt/QiaiUD/AQxAPfSh5Xv/dIAX6Gb+ppTubgShc4+v8rHt8Hma8owpI11NUWQ/GLlQNmWWSdBwH/5Tfzxghi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=LNndGCXvdM9VA533DeGZX6wYJFp8h43ZUu9XU76tXKlbdX5NaKe7m7igInRz4ndB9ij6O4aEJAkne55XGi+Wu9M0MRBLBmp50xQhmaE7efhw7XNpygigjSCZCD91/aJg6ka4Szf7bBpfj3ULjswCF5CgNS6y0TP8gNjuCclhZHheubU+Wvm5JXKIx/6Ce7MDjYoKO5sHc4TRXuUw1MgszN9nMYcCNfsyqJeAeklC9AAUGqTcCnXrFKy7KGNOkTyXYTiu6OgZUkn1B+WBLQqoRWyLmAnTRUd/pSFhZgP9oz6MG6gOPLq5Jr7qVFjiwRuRUHh0ZeDZE7tCS8Njs8GKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLSKAir9CownbVZp50Jw3pkCn369NuhHnd0TmbNavzo=;
 b=aNd5DShztgv8qNmebAwUqN8/mK/2l/fyf9jHLU0d8VTMMYnURi4kZAlz8SPkV89ywDz2AR8bJioLmgECfOc18/bYn+Nj8GAIQCmyURUkvoS2b/pRzmOTYoUF1aFA/In9mutYpxICup0FLzSubrhhjlUGdEdMjbcqlyUD/ntz+t4FWRF6RJxzAm52t//WzwKcvx8uH1Y8NfTwjxajLcXpZFHnUFUa8UYUSQeueDTlOmVkO89P2iZebgfnuxNJ1TO/suA4dQXw4jZK506A86/PYqw3kVB0mmqbGn6WFKu1BYbfLyuGwnX5BEr5XEOAQ+/0qZh1Ysrs3UYerc7pvkN3gA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:19 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 14/23] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Fri,  6 Jun 2025 17:10:46 -0700
Message-ID: <20250607001056.335310-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cabdbca-4645-4725-e6e9-08dda557d3a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vbWPYsarFo0gRCRcuYwwi++T1r8SSvrgBtU7wVmGtNVYWsdx30hRVy5ACAeb?=
 =?us-ascii?Q?QqR/jag0YNAPHcJkkM2ZAaZZ88feVQQe5cZj1lsV0QCfjHzcPHd/SefsLMYP?=
 =?us-ascii?Q?C2TAs7w2vsFWwHEVZenYmBbN3iNJG+evrPfM7S58qXeM4y7wZVX8bPGIUg8Q?=
 =?us-ascii?Q?r3DkkU1rt6s9aSr1xOi5IzaP9U+AD4zkSbm4nWnl47HBHdO4aGvImNQNE3Y7?=
 =?us-ascii?Q?W96MqNw3pMBA4S1Nb5CqtPjr9W2ZdL+3O5WaC3H28qWyxO9qHDc12tr75K6i?=
 =?us-ascii?Q?EmUHWiIJMarHbaJJiUrQa6yAg+i1iyHopE8eIHl2gBBQaeFGUaguM5+uB0Yk?=
 =?us-ascii?Q?jjhdKOcqUSclwnLN7PrgjyxoJHpYLtMEOrwmokxsn0Q0y0JaGjJyUZdcW3Pt?=
 =?us-ascii?Q?Iiyx49d/++9+sbSYoGZ7+CuLriGfLjNNPPx3Iq2zWODCgORD5Ak8G9ljUkJM?=
 =?us-ascii?Q?++6JWvSsTXZKkKTfd+DcShalKE9uxxbVNMVJH6T/U2QYHuixY4zdX9D+mJnu?=
 =?us-ascii?Q?NXrJzdy18gHsswz7utmzX0cICSSeELhWwAlxZUlyB4vRBHmSwtpHZOyobd/C?=
 =?us-ascii?Q?dNhTqF+WhCWGhKUVdnWzVeKy2d92XiR3GkEhsezAA6N4q2ssKM0l+zHAKw2o?=
 =?us-ascii?Q?TKQAZZ9jORJeBuxkaIrcFZO2yD06MSJZmwYKRBCia739+rytTIIZV64zumHg?=
 =?us-ascii?Q?AE0+/GrKm+XcBSy0HB+6RcTpMNI7+KaJEeMoNlwmtXYPMI8Rp5+nFKvXRHFe?=
 =?us-ascii?Q?lbnHApKaCpu5zVhndrOP5IPdtI2/RuuEYympt4Ezz9jM+MazScn3vYf2IumB?=
 =?us-ascii?Q?PZFnDUdxtNHXnRzePeYMt3G8U/eILRebI2EZ6SdGWu8+ZcIFK8wCKaOwwYwQ?=
 =?us-ascii?Q?9nhDOCI7WKaMpgJdvRv9oDz9VN7jSXwnrkz23wGzS6TCszdjirTxUrqaWJnI?=
 =?us-ascii?Q?TK4Wixr0i2J3XM3I3Oq5Sq22KsUrDUe06klwyd7L5G9YG7mOWJTe44K0LKaI?=
 =?us-ascii?Q?aZrJ8tK2v0Xp/d5/aKDynFDHvbcR1wiC627LI4Pp3qeywzg/SrVcnLAnfPQE?=
 =?us-ascii?Q?PlU8TR4m1iXUgTtscUliulxG7wQ0rn/riGNx/RzkzWMAg3zjYE8OZz496Nre?=
 =?us-ascii?Q?VFh6uEqh9Hdt1FUlnEA5gFqkmiYbxlyq9IQVl7GEi/e9/oP6gqL7i+2uP5MG?=
 =?us-ascii?Q?EigjvDqiYlv6FCRUGG2O+jE49CrjYhGv8nTh4J4lqnT+4jIOPhqBrhVH35J5?=
 =?us-ascii?Q?iAvo3iZ4Jcl2QyhZHiM2kgAT3o1qJVEpDcYswFgMVztaplKHLRUwO9epSxeT?=
 =?us-ascii?Q?fb4r60rvdo4wioPLM1zhIojJcwkyKA1bT5Y1Tk7zuPxG7G2v0AYCQk4nu/pi?=
 =?us-ascii?Q?VcNs14pAN0LTIP8HfrKLrJOBHd5hS1d7slNu0z9QOwRXtikYqatwh5/kaxK8?=
 =?us-ascii?Q?G4MQRl11pdw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a1m3emT82LtMQ7N94rrCfZYJnYK8X8wJpGjByLYAjHZw/4LrSYCPfZhxDLbx?=
 =?us-ascii?Q?WLUwOBsFC/n3ma53KmcyCQ8wd3qDxBBwxVXiKoIUCfTTefGwEd0ckrxWb63z?=
 =?us-ascii?Q?FWHvFVVAdySQgBneA0hf6G+q1yChPkB23vDILUhxbro9lCp/2sVq+ufrXrND?=
 =?us-ascii?Q?FSD8mTpyVK/K8jNOf1HpzpMCWuuOHn/HO0HS6dQobN2SXaAQM3iHKR3TWc9f?=
 =?us-ascii?Q?0HODYGSiuPjO2VgnS5sTNz0AfbJlvC4kDsGQzqLcJSvgLQ5kAJilWXEtpYlW?=
 =?us-ascii?Q?Y01yp9wpyvjcrXFsSoYw0+ep6ddL+gsIkQFTwM8iQ7uw+xndDGyMvw799ECc?=
 =?us-ascii?Q?+UtsbFIoS1q7Xu3Btqq3zsnCwcIg/cxLwPs8c7vO9TigRslH5qrXFfECcyjQ?=
 =?us-ascii?Q?2UhpF8MNMru5cxDYlUvyk0VSyOidxT8Sg3U0RlcmpE9gYhDYMa45vbcYErbr?=
 =?us-ascii?Q?kcw0JjG22UGcVbWtUr8VEZFOwKzCqphxhNh8U20hvsfHH33zbJBrnFnY/1iz?=
 =?us-ascii?Q?b7epfopfyvs+vqeCAz9nmyqXt+X2n1ClwLuzByRUX0xl970sqfNjd26OEUbK?=
 =?us-ascii?Q?8+/8OjRJa5Yh6bqrgL0IO32HNUtzRfg3jXslmCXiGk4fgTIc3uwUHQQGnye7?=
 =?us-ascii?Q?lpZ0iwObT37wfpB0KERS3baQ2p1Na0MEJJiU0lInWCcrR0PNZW0PENqC7Jot?=
 =?us-ascii?Q?lrj96LBBVrcJ4vXlrdyxap32bgTAK039FW+GJGb+KIeWb/tJ+lDxGs+emC25?=
 =?us-ascii?Q?1siw022w4wAktFa3dj7XtjUCPcd7uP8JYCUL94uFKF1ntbK0XQork+KAjD61?=
 =?us-ascii?Q?UXdsovm/dOdUMe84hzxPhrbTLqA7jIuKo5VxufNzAxtljCT5Wzfr5YQCHlFB?=
 =?us-ascii?Q?Rlg+Uf76BphRnAOvNvD+ajOOIhx4jOtNtBSVLhPrzk6Zwf9bsM37AI/OBe+z?=
 =?us-ascii?Q?EisXQsCg8D7Rhl5/6DOY9DW5TZSmwgCtJ9/Au8jAnbjgqFGLMzgt8wqS8Hqo?=
 =?us-ascii?Q?RYYMxtv+pFbR33taQOlFV7MgTx3Q/7aOLVuPlSFaYE5L4toaa37ayQTgm8r3?=
 =?us-ascii?Q?B/9oILYcK2AxFLcOHKcAMWHEgepgKBnM0Owd8yRDsySh5WSnWdn5sBrTOvVx?=
 =?us-ascii?Q?37Rw2LW70/4RAsq9ASITXsRvZidkqXiVTGFUJjDpZemCNNAPgpJJGBhVWhGz?=
 =?us-ascii?Q?Vj4chwUw65868VcX0pL1Lvna3nri1k5GawjtdyR8yL4RAbYwuaVC5B8PjrcA?=
 =?us-ascii?Q?n9j9klBhFZk9w2rZYIFCrGCMiD88Xo0EtwqlAXH9EmBOdTA+QdCA43GioMqz?=
 =?us-ascii?Q?NMwjF7sJNDvORhhqjSUSKvAA58h4FS8U7T1N1gnX/KCTHhQYWMnGiMdR0W1T?=
 =?us-ascii?Q?0vc1qkn7Fsm8zImyf/UAsk525CNUhd9bOfBEM/DaLR0afVT3Zv7T09zmndOJ?=
 =?us-ascii?Q?aQAJ3WS39ioL6H/jni24TBsMPodaTBbrN84tI1fHQfE4G7bW5jiTdqWyPjJD?=
 =?us-ascii?Q?pMWGrIrBsW9JK78O30Y6NNkDday6ONfVwBuBFHpzl+41a1B3eiuuzzb+g7o7?=
 =?us-ascii?Q?Vspo0zeDbTA383eIgtNlMd4kLAEXI+t/vWZor9uH?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cabdbca-4645-4725-e6e9-08dda557d3a9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:19.0109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFHRoWoN0PW5tP90A1JG233ktJCZiH08KcDdYBc3AfJi2JRzq0FQMF23nUs1SM2Fxud6X9+4DcUQCVq7UjEa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383a8 cx=c_pps
 a=/VclOIiYbL64yKigy/WxPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=03k_OfxykpieI8sgW_IA:9
X-Proofpoint-GUID: hDBCO5W3rPPIH1OdKb1SCZoxIRdWkhU5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX8z3QcqNcxwMz
 eT3ALa0GT3//Hv9UJfk+kfPkAAwGosFze/66AfPuEIKqCT8Xhouu5QYPbCadTl+zJpcaQ0dN/LU
 beCbsfGpv9/mlH0rD5mE8StmyyY1r+WPPvW0lzU+Mp2Lyv24tdyVaGiifJkF0zjQRpXKKgdT15C
 kQHd2W+6cDX7f+pqPtWK7VNVSD7zBPaRYBWQcbyW6b8s6IYG5mWhflE5qZCIhb1lGCq3f2nERED
 5BPD6JoqrqEgo72ISsTvfwNDxmceex7NPyZp0YPEOuSVNVu1XTZaxWiDZrgo8qijs1JDZ/Vc3e4
 E1hgvPXy4y3twrVVae8uM6qmQVh/K8OY0/i3pPxkfnffSIrI+72S09iRyHBZHvGuGpAWCS7REZ9
 DdY47FkGrLZpRWDtTEeXUB6IOmjn86rCVeVfzdk4+d5s1gjY8UwQzK41gszhGnMYvWUp8vwQ
X-Proofpoint-ORIG-GUID: hDBCO5W3rPPIH1OdKb1SCZoxIRdWkhU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  25 ++++++++
 hw/vfio-user/device.c     | 121 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 148 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 8e6ccbe9e8..920b9c44ec 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,6 +141,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index a767e4fb01..45b91d22f0 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,6 +110,125 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
+                                            struct vfio_irq_info *info)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_device_io_set_irqs(VFIODevice *vbasedev,
+                                        struct vfio_irq_set *irq)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                            off_t off, uint32_t count,
                                            void *data)
@@ -179,6 +298,8 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .get_irq_info = vfio_user_device_io_get_irq_info,
+    .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 3f5aebe7ac..053f5932eb 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.43.0


