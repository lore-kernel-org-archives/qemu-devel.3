Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA0CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UF-0007II-Io; Tue, 23 Sep 2025 09:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13U2-0006hD-Pk; Tue, 23 Sep 2025 09:55:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13U1-00045z-1a; Tue, 23 Sep 2025 09:55:06 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5O4Ke3995710; Tue, 23 Sep 2025 06:54:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5G5sFxtY/12luN/jaHGoYr3YXnudcPxropgwGCPuW
 qs=; b=RMdvBP9P3J8w/tce2+Dobb4NThk7IOYtUDF3Ylw4Cs3AH1DNyl3v5OImp
 zjVCLP1Osf3ULQdLNsZBM1bbDSgXhUq8FB0bV59q9VRq2D3A2h31DFM3GKI4qOc9
 b0TXbauhAfnnJ8OgTpkUEP1oBAqSiNXonOAF5xJl3F4hfPk2CPyk2LnTdksqZIUO
 KEHtfS0aJ1XmbkJDh2Nh++qqbhPvJ4MW+0lEOwtHPxWTLn1Nfiwa0e/yiZClNyBs
 S7oR/be+amV1lW2EJCJYZJNYo5brISQl5b67+19QUUYLMEC4eec+Xwqbt+G+Wq73
 Ssg7Um0k26/m5p3mTr5tdVzZegPCg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020115.outbound.protection.outlook.com [52.101.201.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjfc5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeoasfvH1kqyGaXFAfDB8jIH20XVltFryAW2G9Mzng0TCc4h7Fsvqxs6Mbq+mbIxAA7ta5hYW1JVOjld/PHtZBOR2snPJx7+EOcK5GeBxLKsKG38VjkaSxtAPvLhGkR8ZenPMv47w2UwME4Re0RwvO55F5AW4YXrRiAqf+XuywEGwqZe+/o8+GRqeZ07v8F2LOKxV2ssx/WbEGtXliBzBMW2ZAZYaYwlsRK/aSi64Td/vQZSwePhbgRh5rlLocDik2BoCPl+aCelrWUj/4SiQWz7F1pkSGKGInFc6pDYyHhrLPGylqUtrZO/Q0EQVWvtOXAmtIvPZZ1UTH+2zt1kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G5sFxtY/12luN/jaHGoYr3YXnudcPxropgwGCPuWqs=;
 b=h9S9CZ4Wux3MOrfjWy7wd8G0I2A1t1ygCLM8m7iMLUWkZcKPQ5mm8VR4vR8rKoCgQRwNkL1C8C3ZceniBZ5U3MUC4n3wI3cKVXVwbeJfXDpo98MygCyUMYnO6MzGYMMdCVusGnULSPq4HbjXDy9usCvKRI4mSyht5BfC3ro0lUj0h3+TROHIKHRxUK+Tt3dnh/twgGAB88wcM+HzHLMbAil+iztdBrA2av4q5mG82WbYVuoSaw+earpX0ZvxHNCL1og88UbDfkbspnzF6kgCpzxnkdIq0oPByuw/yKtq7G1WAVpBvQpQHklFegIv6M5vsRjVnktmOsEtRB3gSsevlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G5sFxtY/12luN/jaHGoYr3YXnudcPxropgwGCPuWqs=;
 b=OcfLm316pLscKlVJgTlTGXb3ya0+YL9WNSkX6Z+iD445B7EHgGu8TKyxdOiPVzMcXh2p9ctWZivsCihLvI2EFV1hshVOyEBlXOWto91MWx0me5oLruN3oZ8RW1iKCyz0OeF9WvfPvtvFRVGnZ7VCgDN4GII9TGEXS/AoLTPt+szsk8gcw3GqCX9b71kNDiPIUrFIErfFrSSYHT5PIGO0TzMVe8JwPfXjudKU76S+YaqHS0gTTU6mi/awQOpL/LJLtY17O/OTBNtRuv97cPiYtV8XdtONjO9hToGc7BXSULpl3eb2ffv26LdnSO2UcFJpZH0GL/kKqQal5IoujOP10A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 17/27] vfio/pci.c: rename vfio_pci_base_dev_class_init() to
 vfio_pci_device_class_init()
Date: Tue, 23 Sep 2025 14:53:23 +0100
Message-ID: <20250923135352.1157250-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9ac46e-3122-431d-7120-08ddfaa8c876
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S2GNgDbmhuRBuf/+XgvgrP07bHYMvPpsGB0vk/EfG6aSggbXkrogbRbd8hyF?=
 =?us-ascii?Q?Pz2PDQDcEOpyKoMrHhxR9k8bLK9bUDvhCcz623E76LIio6Klrxr+YuZbWgvV?=
 =?us-ascii?Q?N1fYFlJy6qWCIrBqVrnwZBUCDGnVcp9XmQMuN51CdO4mA4ANa1TMg60LvL4G?=
 =?us-ascii?Q?811bPXLOWB5Vvl2pMg3cESScjaV10QyyM0iw3ius3G+Qqmni+2FuOAtEPBM8?=
 =?us-ascii?Q?HEPfdb9xtbGrqhAKhBvS6A7ykAhCjKLBw5iToKgX2mBUGIu2Kt3iv2P1cW9X?=
 =?us-ascii?Q?PlzeREHePGL+4YhU/u5FFruz0VdXHhgBJyqkBed/2c3p/osioMytG9P1sGEU?=
 =?us-ascii?Q?BPCJsRSENONXnJ430o/cnTMcN1aYsqD8oqhMbmJNdjOrWstpCz6Qf8JHEg7U?=
 =?us-ascii?Q?GLNB+5e5CNmUVe7SSmAuxmdx+xOGJZHpN2e9q8gJZCly5rfdH///jIl69vGd?=
 =?us-ascii?Q?MUAkxL161LtzJPqm3xBXThdfhKq7b2bqlWmD4Jd94mTaW+PW/P4pmF5BS/eV?=
 =?us-ascii?Q?rpG0lCfWbHTZFLEIsi8UAlyCtW6bz4LehEi22GB5l44fCGCKkemMUgU0KQSb?=
 =?us-ascii?Q?c+jvsjtiaIF5gU6dRwXyjuerDQXXBwrxrANRfsCmKywprQBt1bnzMhn3MKkm?=
 =?us-ascii?Q?6rCCj6tZFJh8mRpBdjl7CdwX/ljSHg10hD6a1xXfxYSYNAiIblor/yoD2oF7?=
 =?us-ascii?Q?4AmI/aJHD9Od699axfaeouhd8kwGfKVQ0EUsMuwDxIkXBK9Mpq5NT/+MevIo?=
 =?us-ascii?Q?Y4+Z1SIQwIuiAoTJrxVAX10I8scrg5StNWuycl7rBM460hxdvVLDNDPJWy8S?=
 =?us-ascii?Q?t5E8IP1M2WmOioJ7/NN2n6DiNHOPoMfwU6ZKMLlBsVoMJ+mq/xw0B9gLRnpy?=
 =?us-ascii?Q?DlOy0bG+dDEBOVAWhr4MVMPQpw710bjghU0HSv4+0LIOuZfretgwxllgH+BB?=
 =?us-ascii?Q?mBYiClqIDzKF0+urKC1GbeGQXxBpAtX2sddsdUMBM9afJrZ8VVPY1iremOGn?=
 =?us-ascii?Q?hSsTw4bXoD26Tr8eTEXasgXhbuvclBBUHiqWyyOCdnLo44Q+XaNfZRXIGYup?=
 =?us-ascii?Q?qFrkHPz76can3lG/uaxBRlKmxtyh+Pv9PBXkb3B+7VdnOPtPZO5dAemPGfoJ?=
 =?us-ascii?Q?cgVLCj4hhMtwJsLbKpR+Hfln9DKPQZQGd3qN5qkzMTaW/uCVzdBmMC3GbiXZ?=
 =?us-ascii?Q?cg3SSBAEIwL36+S1oHCMMkKcws3rnl8lutQNtcFtEOuz6EZXqHLm3crZfAtK?=
 =?us-ascii?Q?IgWHZKkJgWnk+SdBmNwOF1T5P85AvfgODkIra+0liAaOnkRuwoxF3PqJww0x?=
 =?us-ascii?Q?2AQrah3F4fD2aon7AxKRFANGH+XswDc2abYg38IDr40pH3MNOoeIiZN5/204?=
 =?us-ascii?Q?qhgYSHuhnZmdhjmRWEdCD8edOZUEV0VYkTPen2sFfX02GT96l3pjtyDRG21/?=
 =?us-ascii?Q?Pzp9rASfngvagPh4EQMTEpEnWVWPE96so0Ya0qqunLJpYq8RILidbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dt3Z8efm1o6J+eSqkVrx0thJ1+5dIDhbU2YnPtPaN2SqVEII4zInaaY9Hx5f?=
 =?us-ascii?Q?vMHTX58BADJ8fJPxeSB881emZfcwwXJRjQJB2fa89VMHEu6tWi1EvdBqEf/a?=
 =?us-ascii?Q?UWh3uAmkE/IO7CXfT4voBCCufEgyXhpyJSWqqcfM+DvMpKesUS8Zzf7v/T9s?=
 =?us-ascii?Q?/DvIbLskLMqOjzO5AvcUI+6OLXyB2nr+gyhRNt5kezeb8god6PZiuktev1O8?=
 =?us-ascii?Q?G1oIPCGVABMwFtJLSzqupjR2GC+3N6hXQHmenlCW7XnIPML63ZLKl/TsA0wS?=
 =?us-ascii?Q?7vzMiVRsInDLGO28/ue0xVXJLbcgv1ZRMRlj0/kZ4tY07lYCAgXEO581Xp0G?=
 =?us-ascii?Q?HOXDeCt31tUnR2dj7wcGqSgLHiPpEIYinJ0Eef7LeR9Usl7zUiV/Fs0A3Em6?=
 =?us-ascii?Q?NEfC8eH+5f1b/hlrCvik6FehopPCMIr/VP/+xBG2Gp6l9wfo2VJ/MeNTGnQs?=
 =?us-ascii?Q?OUJvapdh2sF8KHbmKV5EU4mNbw8hec7sugBIOJBKYgS8dO2093SKU2cPzYQy?=
 =?us-ascii?Q?ZDHZIP8nGl5iNE7rdjzgSXwD5IhJdPFhL34/eukeMTt4cC/cfaemYFOIu4Tk?=
 =?us-ascii?Q?G09fEATg8oYfDi46fOznIzZ3jdD9Tsm919cfSpMqfXC66dDFllS2uhTogRVd?=
 =?us-ascii?Q?6OEft1vVkgqM3j6jFpilw2+kT/lDsNG0WJt2abwZ/sYdEO/0KSB0Ju8gamdk?=
 =?us-ascii?Q?r9GOmutjOWd0a5m4FWRk1abA/YuKB+8akLrTC6+wXxB+JZXnLnkTD031oX7d?=
 =?us-ascii?Q?Hq/2XA+bRS3gq3DlzsDjLxsJ93rFbPKtM+petHf40drrJCouD57n1mKIy0RR?=
 =?us-ascii?Q?7BIW9yszo2RLYLMa0miZ2GGy0nMHEoP1k6OTvMO1a2VfZMxgzx7SvvJR8XVI?=
 =?us-ascii?Q?zldzMWT+/wZX9fVG5NjNeot2rjbotTLaiy/zbV/DPDQg101fFwJt2ikA0Qom?=
 =?us-ascii?Q?qMF7qmcA8LNNPRqTengQGpRm+aI22kV4Mnrlk80ORc0iKTLIJmNZ8l2loNgg?=
 =?us-ascii?Q?is8OdYBN7rhzXXbirBIl5JE69SpxSalCCbIUz1yl/gXIdMaKI5DW7jdSYBU0?=
 =?us-ascii?Q?VLC7Rat6HpG6WjmVqgKpY1p8o9dy2r1SNQz9tdk8q+F7JMyTV+rZXbT5Jejg?=
 =?us-ascii?Q?CajNwbLeLNtBcXgYEyJzIgxSzN1PNNHF4ycdiGdZtXh7naSkuR/lm4DChbls?=
 =?us-ascii?Q?oISlElngxcevecr9JnpfvpzjOuW81Kgc92OWxWHZoeJTksJeugyRwbkHu6RY?=
 =?us-ascii?Q?ml6Rq6Tp92MTkCm6OEvuizAGgtdaFsDiuPaT/vv7qXc7e8RO00oPANyHvGTl?=
 =?us-ascii?Q?a3k0IOdiZS8FGhQjF8hIhuCSUqDgQ1Z4JMqLkonASNF91p2u8EbR/A6YTIu+?=
 =?us-ascii?Q?EK0zbldAibYe3LZEQZwX0LHcpTcGqE65nIuA/dF9Nr4WDogHoq7UbgHVm0dr?=
 =?us-ascii?Q?pFDL51sQNz9tQxFOP4+25b7oa79Nf13opTk/qSL2wgi7XKdA1uI6yllZm71Q?=
 =?us-ascii?Q?3ZrwFKf/1OjynVBtInMS+jyBZsq0erl8ZXYPmWOWyjgPot/yj66Hj0208/Vf?=
 =?us-ascii?Q?32ND9NXp3o5n+NSNnzlf+LxBdlKjgbrFWErId9kL9S1Ar+XYjCNqlVDS/HUv?=
 =?us-ascii?Q?bjBOg/93KP0j95ICBXZ4St7EoJnYoRGE2IGnqOJ0SY7StZKyENze8ZMzvzN0?=
 =?us-ascii?Q?0j5TOQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9ac46e-3122-431d-7120-08ddfaa8c876
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:58.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuhYNznBYUhjN9Z3aIfUppHHmlANQiYzFVY3hsrUNVxqqyFXpbq15p5ZOaIMOfoNoEu0UDGzZ/s4a4YZKv+W7LKgQDGc7bTENbcbZlBDeDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX/H75XPzkf637
 tNJJunrE0vVXCcjzJYoJs9KGedqIHkfHXqONWijXELlIXo8q6CXnkAnAAz4qpwK5ceIFh3bSCCC
 qriEH6fZ6imabK3c8kg7eCw4NrAAlmrLR2JCYikBRPq85/FZ/o5ockNXoaONVz3BBEPMgu9zKt5
 7N/QmxXawPGS/of4EUx87jOAttRdAZSzt8nsvVsXzaQxpWYe0gA+GmbRMUJXyTj2DpftGWQ/MxM
 sXhaEQ1Wf8ToQUmlFdTlwutGkJdnJw2jZiYgC/eAwMDARHsd3fmqJqyAm+8N0miWYSn6uhsXvS/
 nV1oIIXBgzzc9fLMXmoRBNCZNTKGgkT/DZwt+Dq1d67+Zj4ZiVEahnq49q7/zk=
X-Proofpoint-GUID: QwpREAIHYGmibenOdIrJM-rgmqVoLHO4
X-Proofpoint-ORIG-GUID: QwpREAIHYGmibenOdIrJM-rgmqVoLHO4
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a6b3 cx=c_pps
 a=i9AYdY+muJfbJY5DtBkDBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=udP_5BOVWkZL6ct6w7QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6d2ca710c8..a511f99a2c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3660,7 +3660,7 @@ static void vfio_pci_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_SKIP_RESET_ON_CPR;
 }
 
-static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -3677,7 +3677,7 @@ static const TypeInfo vfio_pci_base_dev_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
-    .class_init = vfio_pci_base_dev_class_init,
+    .class_init = vfio_pci_device_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-- 
2.43.0


