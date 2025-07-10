Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D85C83F18
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2R-0007wo-7G; Thu, 10 Jul 2025 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2I-0007n0-CS
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2C-0003XL-39
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569KL7Mk029252;
 Thu, 10 Jul 2025 01:53:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kcHZDj46NFWtrB++QFLSi7p9tdLrMqQM+6qLzGoix
 Zw=; b=CTGS7jySJ2VcRTrmSIAsCgE5LDHU5F+rNppz02lXJ7iDepLFaoC1VLLxs
 nq+m87d5AMkNCO+e+c2hMDCnJQpvA/GXAsMPalMISq+V8QKz0S9zEqRax4KENz9K
 iAxElHY5HT4H69bH5v/nZcnLadxo2y+uLB5KrYmTz7FlQe6usqgTfPaQbVUB39aC
 pXrOQQiPn1xMMmtmB8zfXdZ6KLvDkj9NijmP5K3ifAs4cE3l/sznWa03Mvneji5y
 PYMTksbVrNTLkSV3vBGWmoMhq8PQ3K5b4h3I0XZ5kN6pKyqfD0RERxl24LYxIAMT
 2ypEQXEMqC41tQY8epivF65q032Ng==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2136.outbound.protection.outlook.com [40.107.236.136])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn284-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ7VyPlaHqynrHQOZPYSyvI3NpIYkc0nQB7WMYg/oF6UXuL78RqMXPtPlr2QHikUlJqDKvarNAT7J6+SkGDr3u6z5ic007JIEYtoGisP+bG86+pgKEX8EWohFDy+vTQVVH4VX+58boiworlR20AYZHtPu7imjT3j2bQu748SRYRvo/C21qxmBNxh5fty9N1b8g9a4V2s8bqKo+MPji127Dl9gMovgKteRibemDzsOF3ME/TjeRyc3mdTrl2CIc8OMe+YM4SflHrQ9jyHp5J7IleD8l4LlPUwlk1SOheZOkJjTe6R/5KVNx/mCLD+bJ8ElouPtw5BAax4gFGdLVE3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcHZDj46NFWtrB++QFLSi7p9tdLrMqQM+6qLzGoixZw=;
 b=bmG/0nuXD2+pjt6lD3mfHdu+nNGu+nelHFROFzQoYNFmcurlc1I6lYyeosKvZ2H5XGhBgaTpY9UuWLA85Ww+ZOQn/+54fXZD9TLov8HYbv257l5ucUpgDwx0dWykcZyS+JUmWekTK/VQLPQrhsmrDqkiDMRGTAV5ASRYK5OYXD1nMEr8fYBmWHFdhDdR8D7+RHbiDmeQYiITMFI7iJPipnMGMZbv0cW04cSkb0efjNbtYwnbThgAdZ+UaTQZ6wNA/bm5UDeNiIwYFd065hOGRt9SQGYLzUk1ivNhsgrsX3+jIoSHFREQzehMTkPGqmlOeb1W60tzvGhvcVnwCHC7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcHZDj46NFWtrB++QFLSi7p9tdLrMqQM+6qLzGoixZw=;
 b=dtriEtFwbrzSWtkUVPGgjEvn6Pm1RmOj7zNN5YkeKDpa4EZZ2AqDp7RPfMcU2cY55XSVaENVhV+EbGqyeGbmRHrUOJ5VlPTdCpgsP/43m1N202fC6ZsLGr7uPIfkSkkImbxfyyCLC+AjiOPvoWOC9iEnvYUO/rG4yQ0Ero2dn0flax5aVN3y68CaoLw4gr/8L8EgfSjTfhlTfecs/fhn/xPcD1Jp6bwjJoLyFm+ud8DvrpGUbxOPoe3FCfFZo7V6R7cKcLDYTl/K6wGEstLgXaOoBxv5F7aOBjPYwmkupITFwGJh86r9YUNChUPfYqsX7IjboY65hBDWM6lIWyLNbQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 06/18] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:21 +0100
Message-ID: <20250710085308.420774-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 65adc7ba-f2fe-45bb-afc2-08ddbf8f4127
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HDjfStsYsCfucBW31qh12zvSBYA5OEz6FVuDHKowI8blxTDrAxu+I2nyD/GC?=
 =?us-ascii?Q?Onsz4NfcPVOWvcylNVIKm8W9K/1FdHuKUbBIQ464wWS57YzrXlvk9qd/eL7m?=
 =?us-ascii?Q?CiMFIqmXnuQugWHVbgwX3qmkU3Vq5fxiWmtFWsCCXKHx6pXo4nT8VqpUL5ox?=
 =?us-ascii?Q?eGMDt1glRPeuSPHqmS4m/PFu1r2chcNs78gry+Kbb+6ibrgR9TZyVTnXxq6f?=
 =?us-ascii?Q?zoGE3P5vSgcIn49JHEFScc/1gfa3X7O+qn6SCPFuaqW9uNtKyDGzZJ8JYrhV?=
 =?us-ascii?Q?JTw1LoPuo7ZzzKpIVF/W8jwpcepFwYae323j21aF/zxkz+1PW/REGbSz/2i1?=
 =?us-ascii?Q?+r2aSF305D9RzVqhjke9Nk1fTWCfBgBFrjBrSk822t3tFqfCw7on8n8S9BiO?=
 =?us-ascii?Q?tSSYlwbXLs9IdevkHyoliVqX6ex1/byAUELgNBvTeV6SoO0dagB9GmRYZtjW?=
 =?us-ascii?Q?lt5YPEQCaQ73Y0QVNdUH5GtcsbppdJlixTiFGSd4jKREy4yke7eNrI1r5pqt?=
 =?us-ascii?Q?Q3fVY6uvo1LwOw7HUpSxXgaIC9WHqNhxqXh6Z1TCUtx1CL/GGTROz//5hcbU?=
 =?us-ascii?Q?W/CLsdBCQZ33T5U6zJANFUgBfXRTFZ68iepNBgPg87Mbk++BxlhCC8Aph4f+?=
 =?us-ascii?Q?PBT12/5Eq10lmMnhEbKNtOleRIjB4R5z5lsdbqIEnJ8foSStClggPIXacNqP?=
 =?us-ascii?Q?T1KSFJRS/hwYvwpXQaNDGrG/Ed1YaesqMe9tpvTAJ6z/QwZdqt1D+CiV7uq9?=
 =?us-ascii?Q?ujxFRDEmdJMTl2yHtn5CO6MascxdPFpaB9lW+FA1R3cMoJEg7V8vbM8THerX?=
 =?us-ascii?Q?ZtQt0GpHR1WYsVu+sv7Hc9lCQmDqsZ45/pmWT0J+gJS3a4Bfhb4kuVfj9oUP?=
 =?us-ascii?Q?6dgBU7WnVXzekd9yChRW4ep1Egt/QlrGNnm0ai1AJkH0WHjhwGYpmJcaOAoY?=
 =?us-ascii?Q?mQDSt/tx2LEq5itWpjpn5oGbYqU2UbdQe5RFZYrU+o1cG6piZrp/Mn9fPOXO?=
 =?us-ascii?Q?3xhQrPmlayMZV6ZJefqPnHWKvyttIxdb09VvxGAUNGou8yT03cKQTEIT+bKf?=
 =?us-ascii?Q?woSDhcwxrIP6BRC4qozyykdzMDdaiDcGAyXtfYUlbfPEJ3BbfuZdb2foICNQ?=
 =?us-ascii?Q?cOhQ9RnEGMru5zURNBx1df9iJLJ8Abn48sNey0Q2sWn+RrJuShZO3mS2JPKl?=
 =?us-ascii?Q?Pz1SUj8dJrxwdPDFxUA8OEUwULKIVYjNuvW3xdFb5igbArLn7EofG3llCw0w?=
 =?us-ascii?Q?C3EqxZpBdmYMy4mqLQi3WFcySRvTJcPJ0ymYIOsOeTF4YliOPPMuwsNFfxFF?=
 =?us-ascii?Q?XeibqjITb0i2oIWhzp+502t4oV87lrumVrlQfxL9ESwHjR3wAJtA8tp6i8Ea?=
 =?us-ascii?Q?ZH09K2l6LknQRjZoE5crQTAMlpnSrEIn4mG3/HLjGOzpcISsLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BKCvcnD8qdoM4Nfx5FDaazJNDln8FJNIUTlDm9RZpbTFrwRJaLDIpkFj79lv?=
 =?us-ascii?Q?TpifcHceuZO1H3Ka7Ul9YZFdH4lj4DB6lItX3v79pifdKDD62nWFKuaeolNS?=
 =?us-ascii?Q?sMBPqynGRpDei+U4zp39uom0w9mNgQnoTUav0pNV/gvXxB5zkIJxvTZw+DwV?=
 =?us-ascii?Q?ch+IM/dx3oa4rgcnmTNNpejMCduJulDOtqPKvlK56NCAyAyNZZLF8Z9qaKl/?=
 =?us-ascii?Q?eaFwvD3+LLf8CBmOZZyiDOVBXZrDFzJu27m1Qplcr10tS1qCGJyRNqfWy+nT?=
 =?us-ascii?Q?gjInoZsH76QnlKlyKotQo37QFZ+O1HFjG5Oj1p4pv9eotdXrGDi6DH7/RrWl?=
 =?us-ascii?Q?8tR5MsnsZ++KMYWd/Dv3jM8j2hG1JGQdNMiNaSdIBJruIKmV+WHqkdSTf2li?=
 =?us-ascii?Q?6/bNkS56ic6+nGNUTCk3rrmqplUSaAqCrlGMq7uALD7T2BRYhiIpRSETplDl?=
 =?us-ascii?Q?b9rPwDIU93/JV3gnUO8IjxmYhsB+FGy7mk3kG+RiGAmFBkvEO/HAFkJD1QQG?=
 =?us-ascii?Q?9D9YYbhswePx160nsndKbMswctg1p+SssOxURiV/LsCimiQH6wj2Hb4yFX7p?=
 =?us-ascii?Q?xkYiMJggGCVQRgGmt1ZD+EqcNWPvZanQoH9So16RR07rdDbMnBgh4NUf5hr2?=
 =?us-ascii?Q?RyKOxMJn3QhfFZ8a0flKqL2bN0fwwpb0h0GYsQaNNEwN86XlMyfmJkklO6aM?=
 =?us-ascii?Q?NiZBDvuEnON5d+4inMQflpqQPMbBns8P6TPvOVQAb0JMB+lAifT4/ctFwSJn?=
 =?us-ascii?Q?+kdctCLBPh/rTDZMlS33vECpDo7eNB/yW4pjOGBJzbvKpJ4KOvk0humIK6fg?=
 =?us-ascii?Q?S7KQaQTQHOVMWPo8L25bcTwNfeEQNfGcgDgN+2CRY04VuXL2POqAqt3pcPa7?=
 =?us-ascii?Q?t5SJKA7HREYTML6zxMJ3fprG0wlXWLNU+4UBa7iesCjQVrPf0EQPeIqTm4q3?=
 =?us-ascii?Q?L5vDPEsQpAT4Gj4Ur8M1tZS3isiNej+IkbFmp2Lk5/Axyc3BOm0sD9JWqLlD?=
 =?us-ascii?Q?eo+6Fwcy+LbPXEQis+6UWM2H2f5QP+dStp4ug28Yv+g4H0F0uZWXw2CGWlot?=
 =?us-ascii?Q?pmFZU7DflrdskoTJfZ6F7s2aSkzMtJlC1HpFPboRDOsW9EdnKobbMyBrMRBn?=
 =?us-ascii?Q?2zzDr8RoonSaAfJDnbznMAfmUQyoN+CQN8AgtLCyLLiUEIy4bhsKI8/A8NrM?=
 =?us-ascii?Q?RPFOBsxRQ0jo4iyZUx0wo94M+KLWtCwroC3g/pJ5gW7MlbxrmWQ00N3QUvED?=
 =?us-ascii?Q?uqGhyng/1P5kOBsvSpztBiYC7t4gx+e80QRP4r/HNPEem/n2F7qepA3hnO10?=
 =?us-ascii?Q?3kj6zp0xDe0e6jARRjomCbfZLRi09wqMnrVhflUjbcuicVMUXs8bn0uzKtIz?=
 =?us-ascii?Q?+4SiR4gqxu5VzeoWipbbbTtZyK7Sh/dO9SKzxazmrb0BFXe0BKUIheHL/vG6?=
 =?us-ascii?Q?/Tg+iAKL/aeHR6p17I004Fkj4OGBa211DblCzpT5EA29ez506GAGQUZhG1Bh?=
 =?us-ascii?Q?zJI+EE5dhoGoey10/ocL550XP+i2qqc7wrJRxHQXVUp//c/THygMhdakN0RB?=
 =?us-ascii?Q?10NYbsrYtWZmIFJSJ4aWYd11RW9gerWvMUM56X8AcLoY1MKjK/EFUsETwBLJ?=
 =?us-ascii?Q?CoxgVo5jmI66uV5jMROzM9EaU9oltW1Jk4kLDDq/8d6EQsfOnxbuobgew5L1?=
 =?us-ascii?Q?ycMvKg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65adc7ba-f2fe-45bb-afc2-08ddbf8f4127
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:35.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SEkVJIfuoSh/Vt+MRpQgDgOj3SoZj0tBKZebEAGHmwzteieRyz/dPdywW2oPKiAG9kk6Pf8O7QHMXfXhEEYxuRy74Y3D8dyarRSbeogyTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-ORIG-GUID: T3iWIxdhfZs7nYUuPseIrmRCCr-wc7Uo
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7f90 cx=c_pps
 a=DHuqkZ/VLdBH1VweqxBGCQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=yiTRickECGlooSfTVXsA:9
X-Proofpoint-GUID: T3iWIxdhfZs7nYUuPseIrmRCCr-wc7Uo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX1rKWtIQN8oyv
 F5+1EliCm5gXvch7dCCxPHSpIUTA/JIB2hoUUpOkqwKfaV5Wg/F/T+iJJofzQKlptCXxQK/e+9h
 aP4yfQjKmA/x+mNyMjnMyIvAUZSpSGNbO7UHdNO0ekdrDH6O0vzvXzQdVqhMrpeXoJtCCLwo37O
 I5WYw0djlWrrHW5lSVlIPGmFi22vd+qdo486vK9WqX6WyP6sGsZbu4KLUM7iataUBhhepgcJT1q
 eqI2zFkN8Aylf4j26CjIedYGRYUhCrHsrEBPHMIU1qYap2+HFhaQiLljrbjiZz8LRwRFmOe3Nun
 TpOkSx7t/XQjvOrkrexBJNb0P1ivsvQVxfChqsYQ1kwbZmvvzMsnHBzsJlItFrhQiAtXzP8WBfE
 d3LcH71jq6IYEYvQ2Hajw85ACkHQ32HeJV98s1DtfCWkP7meMESCwFBtegQqR2aJLCNxSMlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cf451d1cb5..cbe4b33ba4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -491,8 +491,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
-
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
-- 
2.43.0


