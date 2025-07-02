Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A96C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWw9E-0003iw-Oj; Wed, 02 Jul 2025 08:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWw9B-0003if-P5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:01:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uWw96-0002R6-S4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:01:05 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5626YXJ8006410;
 Wed, 2 Jul 2025 05:00:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=sZAVwEPXvvaO6
 4g/r14rw6YZ2vNSRS1D2vEgfK57guE=; b=FUTFRu2m3ByosqqqRfviBceR1yMrQ
 XGrXmAykbBqKvf4ki/Rq6RQ/wzcmAXt4TvxDtleK0rN5AGPGiHHNetjLY1g4wk+l
 xVhZG7X0ImaAhopvIuFGsRVerIAoyRIpoEHPrPJgC46D77P5r+/dhinh0p+A2qc5
 cfx8EdbdCGoSJAN56gsh7p8c5pWWLKS68TJF4mBmQn3zUJFVD4I/veujULb9g9zA
 daO1iv1AUUb9kzcOYFKyiC9BXwY06jsZR3GpGQbs/WVNMD3M7W5VsNgccGZCD7Pn
 Ynua9h6xMPR1kfPD5DzqGhvMIX/FWDga7aqg71Egy1uxuo3YBpku4hpww==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2114.outbound.protection.outlook.com [40.107.244.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jfx0t94n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 05:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSM/Nf/3Ozq8en36gzjpnRHW1sQcRxskym8yi7ohcqF0eRDCPXCCeylIqNKQ2/QApuagM6p4MH8WaQVjvzbeqN5vaG4TxtqabsldmBC1Z5Ygl59hAYYFiuHEVwdAE3evZSgk4Sbwmbix1rkz4nhga7RbIe5190KQrQ28t/ZfwIiWAkLAFGj3bwPrsA9Rrg8nTdeA+TAvxIGltf1+fqHKAgjPip9XLX4bxoFPeogBaFOoRzNNfORu+9nepFhFRUXKpMrpAErxoCYXk9qzS4EdyHg/p/LgRVb8WmgOvQyH2mcOQZfwb3bTHqY1CbBzQBJLz4piegPVDNnGJA6vCxC1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZAVwEPXvvaO64g/r14rw6YZ2vNSRS1D2vEgfK57guE=;
 b=LrxFAIRt3bz+wflOwqthwtLXfJ8dt2xrgwgyLQxfGv/6rSkUKGrN+JBVxmUwNBz6HS9AKEKqvNVHJtpPwI9Jsr5XqYZovGyhay+b11U38hDWT8bw61v6uZvXEXtP+TN2et3JAXKI2rAitVqVMpMwgGFd2+8qukBtzmdAQAxSSJd6qRlOCIX/tSZdfTie7IuAPWtbD0plNbLh6NRkD+uRvNXT68HKNFNGcRy2BRGP9dOq1wEUgn/JP6kJbfi9wHNaOulRs77ZZreAtc/pM3DEatmIXnDLkLaati0ERtH2j1LGgS4Mp3rvX0llgrnDsFoOab7Juqg234OsMtCZAmq2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZAVwEPXvvaO64g/r14rw6YZ2vNSRS1D2vEgfK57guE=;
 b=B2ziZp+lX/F+M6PEWnPCbNJZSgI2kJ9j38yIFGCP3DpW+cPHnWiCjeNWEA9H/zLpsXovwBVAxYzVvPa6zwTPgiM6g/JrLBhc/A0mMaYzaIHuzmw5BKoJaQ0d+6eC1PWBLCG85PB2WxQlWsLcismqB/wqOjQj+QkYsA0PHzp/uF7Ino8z1nttRXb7qgiTfzQlH1kk85DyI7ytUTMHw3BNfQWKlqPfrzPfzyFWKbLJEk92E/lC3UqMECSvw/x9ItnR3/5rQeZV4+QRZZbBPpDaYd5UaSdPX0v8jPXZo7dxUeCkzuzeZjU53DdXA1vLYYIrY7ZCGBSJ/mee0q9S7zHjyw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7488.namprd02.prod.outlook.com (2603:10b6:a03:29e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 12:00:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 12:00:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: clg@redhat.com, john.levon@nutanix.com, steven.sistare@oracle.com,
 qemu-devel@nongnu.org
Subject: [PATCH] vfio-user: do not register vfio-user container with cpr
Date: Wed,  2 Jul 2025 12:59:49 +0100
Message-ID: <20250702120043.267634-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: a880ea48-3af6-4ada-0c25-08ddb96016ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ure1NWiHFu0UBGsRPAOt//8Zht5a2x6LEfj3tfGtQnXDnWCbYS6TJXE6jnRx?=
 =?us-ascii?Q?0rXbKOG/xnhanXsfZjD2kUelZa7oEFwTOuSf9GkTTS7rXn7EKmuoxp6t7+CZ?=
 =?us-ascii?Q?B2eAq1P3DHGjDZeOqlo5dVRDA2JKLowoz8op11uD+M0FUKYWO8/tntwHbOTM?=
 =?us-ascii?Q?lGuaeZSKhuml8yiUk/GnertKMozu4f5oc+Tg8yh8lzukrBQCfy7mYOiE1ln7?=
 =?us-ascii?Q?gwEq8bjdzXfU4azfI1mCuFDMZDMqV0WnrG71WvHg/Ew4IDjkXZ7L6fGauHg7?=
 =?us-ascii?Q?yiuGZCW1Bui/wt+1XYxnGuSSAV7wsyL+AKSaEU9o5VUNFwETvgE8Dx+h1D4+?=
 =?us-ascii?Q?MoxwzJuj1wx7LfpW/LcIL+zF+mRE552OO1zHYEdqFjqvXL2bvGe1f5eiJAfF?=
 =?us-ascii?Q?GrAyTUNAwvYy4o8vu5cKPMSxg1gtx2EpVgvUu+PD0YPt4qyUovh4coeoLVb1?=
 =?us-ascii?Q?f6LPFejY5LnEFgp8NcKLerJW3uOt8sssAfPMRk1BpEzGp7b22/sg9P1qv7Sk?=
 =?us-ascii?Q?IIY4/nfh31uoGR8i5PKP6Bpg0ONgXMnEOY7638vhZg2VQwAZEnAalqKIdiBO?=
 =?us-ascii?Q?4l3yUtOnKvDwqM8EqqX4RQytg7djgBGEORTvB+blfIkTnJL8yi9uhKrQ6uhe?=
 =?us-ascii?Q?QxnpfgsPguJ8GEcFGJnvZ1xypaxj0/W694nr9LQ9GbBFV94Zjj1RFIqvjY9C?=
 =?us-ascii?Q?4rqBPPnv6yq/gV2/N5DJW6sxQvTxa0BUSW2Cp/zOlrHhBi/iMwD6cGnayh0n?=
 =?us-ascii?Q?KCTmyY2cYZkqXjIJCzhubnC8RPXP55yIJdD9rsVC7u62vbEx0bRKhhzRWX3z?=
 =?us-ascii?Q?yfscmI/wndhiPXq2JwH9sIqNoIfMHqatE7eSOjJN8rw+L9W2QwGnHGC8Q172?=
 =?us-ascii?Q?wH4CN0yIdfqLq4dSrzlBPA4f/iiluOzU4LFbxrJSvVQPp6G+P/Rxc+I5NB4r?=
 =?us-ascii?Q?WEbhoHBkQmfP4Ty76Cl4XXHfrlxw7mPFQ8jmVG61STab5FzJM0RT6EA8A6Xt?=
 =?us-ascii?Q?e8Da3UXWcdjJzqg7n2rr0Ke05Arq1baR2xV9T0LwWfJlLPwptcqm/9aHUcYW?=
 =?us-ascii?Q?YlfVC7BVUqwrEOll9VAoa4BOXlqdADsCwjpi5oEEWITaGghbVsp8KLUUf5Fo?=
 =?us-ascii?Q?NlOSfCq4Fxe6MxhRLWenqEcMhL6vpgE95XgYka3hdbmhv4PIucs1CP9vWsFa?=
 =?us-ascii?Q?dgWa3Q87ScrBCu18gv9SxRFfvoZOW1tG7ALBBqlWaTCjDs0NkbUBXDTLANRx?=
 =?us-ascii?Q?sHHV+ac/DKJzfpNUs9ANtPB40Yz3C+MT+t/04b1Chrxi8eBtQeIO6mn36YpF?=
 =?us-ascii?Q?RPIhQalrnXKqp9DQvIaC6nq2yuYTBLkDnlbt32IgdnKF8FtKBG1IDmgyHFgs?=
 =?us-ascii?Q?6WPWZ5gXMuAvNozh6XHzTlNxXci9Y39k2KrbT9Qk4H8x6ZqXAmcLAPx8/nvZ?=
 =?us-ascii?Q?uaZLfImmcOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gbdb3ym+1t0MDeTC8c0l9bEaS3Urg2TJMtFObM1Uro3S9MNdpl9jXr2ELNN?=
 =?us-ascii?Q?iNYamPUUR2rY3QwCwvbYF8v15M0b/qE9LdMF1EvtouBTwV1gJl24eKSVOLKl?=
 =?us-ascii?Q?5+N/q7EryzDsp09ZXlOKvmDsnQ3dOJfTMA7MjaHVZmAAVq4D99gpSo7ZgSuX?=
 =?us-ascii?Q?gr9bb5x65R65Ali5W5JNgYljgeNgQ7xuWqxBYD6zeHkTtqWamqTuBpOvYBjz?=
 =?us-ascii?Q?FlpCnDsy8nW5zI6j8+3g2C4goj/cVIStRlKig8xrofZrBairJfUM9kFHvoM2?=
 =?us-ascii?Q?BBKbQYWY2E2mgEe2Xxq/ubkg7/y+4yz5nYVJDdJmmiEKBpWPVC1X1sZRXTM7?=
 =?us-ascii?Q?QrnK5scqSGhtqpCyk6GTYfPuBtT0sSNUrtnVn/o+hdnDGOIbYx9NbEFoWLBZ?=
 =?us-ascii?Q?/cSUfxWFGpKQPGoKndWfe+50MPb2rDNrIWBkctUliayiZQoAU24q5jS3gNUD?=
 =?us-ascii?Q?LZ4y5Og3LcJOiRzBOq/w7/q4fYehuPJFi2rV72jFmp6uCB1OOZsMBaAmclfk?=
 =?us-ascii?Q?4VveltzFtcETjKbEHvfQsJX1zxM/C0Tam2vpBaGeA60kXyQNB+N++8MKKdKz?=
 =?us-ascii?Q?OmYWGvPSHs+qTgpxNcFRhacCBvMkCYQail7bJfXJXYDzwj1rbGeoL/g213FB?=
 =?us-ascii?Q?9QDNTxxldKCRweK+eR3OrPEBpY2NpklAf5+mg2sm0UoKFl09OX1+EoMC6giM?=
 =?us-ascii?Q?enJz4r/mfR35eYqjFL71KiN2dhhvHq/LPgViSZFVZEOEru9RbiF9xWGiTXBQ?=
 =?us-ascii?Q?mdOV24+bEbBHsWCvGGtXD9U8VCHRds4hzlA83CKUR+XAeIQhI+MXg7uSElOw?=
 =?us-ascii?Q?rp5Mi4QGj07Yg0EttacER2Y3gVEHMh0WXnyPfuCVSDJ79sdCz1flw3NM0ukN?=
 =?us-ascii?Q?WOK4a4LpjAjHmTmdLSM9AwgqIJWKPxRm+Ws6t1om996GO2MeYBwsctoY0BVe?=
 =?us-ascii?Q?7BoME6ocYmY97mw4kNXQgzkL07eu0Wy3q+aa6hklSfrCKwNsRcbrlN2d/491?=
 =?us-ascii?Q?Xpv8QGZzSfQTWqgzwPrIQQviVrlASDkmNN9a7fidSZQPPajTUeA7TdimcI2D?=
 =?us-ascii?Q?dWulrVjmQfolitgIfLcLkihdoJ4a3dGQ/L8exzdXn8y1U5FHtMAndW/1LHqg?=
 =?us-ascii?Q?Y8j6Jxpxl5HTpN41Cd8tHZzqyqz35V/rYnXg8poeZdIJeI8lmmPzOyGdMAWg?=
 =?us-ascii?Q?5MUKdcp2UFRBOW5B4QXgXVCfkexFEdXpQQeau305+kAd8PLrYCY+QUvXk+A2?=
 =?us-ascii?Q?cx7PbJTyQCO08O78uicwuvhzgev2Vtrsfpnx4y5hMVyDc29tUOCdvQ1R/UuP?=
 =?us-ascii?Q?q8vyKOciS8tiEWBb/MpngykAPTAzceSQd7vs0QaXRotoSMpwcEGjg7eDQjag?=
 =?us-ascii?Q?NNKVzmsCnkX33cSW3xb9QoiyIxl4Xvz9SvrS2fwp4xbbfCQuwDTfZeCSX109?=
 =?us-ascii?Q?QC6qxBjZ+0pM6mI7TjALvXlOtdqRcamzig85LbEY43H7JaSY9rkbWuCtBNHN?=
 =?us-ascii?Q?rFh4BZ/anhpceVSSxVMZV/2mrHvI2j3vu3nCPaveCyDJkxtpzi4Y6+798kqK?=
 =?us-ascii?Q?nraMD96C7y64br4d3fIcvYXw4RAJIkBJukR9NSKG0lA2vRN//2FDSvn36mNE?=
 =?us-ascii?Q?Qx84KWqmFVMxXnBbOdgfqExAjxccDFeS77vEX6neL1pz1muNmtzD3WgJaZ6P?=
 =?us-ascii?Q?uff2Tw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a880ea48-3af6-4ada-0c25-08ddb96016ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 12:00:50.9778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRIVoD89OOxwCzl4kYDapLEqAkIVr3xhqsEiD5dC+hsEByq3XGKDIMT9dSvvo7VRBcOT0NEYjUgfpal4X7bxCTH7W+uqglydSeRs2kC/HNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7488
X-Proofpoint-ORIG-GUID: xUWUvApmpCnUqkPg_W84K-VIaiEf2hWT
X-Proofpoint-GUID: xUWUvApmpCnUqkPg_W84K-VIaiEf2hWT
X-Authority-Analysis: v=2.4 cv=c4qrQQ9l c=1 sm=1 tr=0 ts=68651f75 cx=c_pps
 a=got6q7fWVU6QhM/OxcbtWg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Jr2KPkH3oQdrFsWpY2sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5NyBTYWx0ZWRfXwI5H22XIUw1c
 21sVFgWTvTozSwHN6yH5YkSnq5Rh3oLhmOsxGm+EPFhUYS6k8muU2fpMeIO3lrFEKlM8L41yV0x
 /QPnnnCNO/1JMOu1bcq+oQiHcSg/tmTq8FC7Mtm99kdnDDCqWk5xGwgqY5ogNYHvSBdhq5HHbSH
 xLz/WiULLtrEMMHktE7OuMvE2sWmynChFE1GIhsO6K5aZhxSHOOJvTr8suaofl8GtP1edMdZJ6f
 kPK9+JlEO+fysCWAqP8NWrB/SGy4UEK7Ay8IpYmSxzlDSb4PMB/9S2m9ErsA6lENgcqpuPIIzVv
 QD9UKDp4nEDgmkRnApCUVnyqMJ28KvsGbuyn1sBFcZSSkN9id4rn1JlKa7BPknTMGCT16W5uMbE
 YktuePv97nyDoKgdFhnP8xBCNh4rcw2cKH+nu9LZZhChet2MiUE1Tusq/POe+clYb8cpaGrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

As the full cpr implementation is yet to be merged upstream, do not register
the vfio-user container with cpr. Full vfio-user support for cpr can be
merged later as a follow-up series.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/container.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 3133fef177..4ee99fc2cc 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -225,14 +225,10 @@ vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
 
     bcontainer = &container->bcontainer;
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto free_container_exit;
-    }
-
     ret = ram_block_uncoordinated_discard_disable(true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto unregister_container_exit;
+        goto free_container_exit;
     }
 
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -261,9 +257,6 @@ listener_release_exit:
 enable_discards_exit:
     ram_block_uncoordinated_discard_disable(false);
 
-unregister_container_exit:
-    vfio_cpr_unregister_container(bcontainer);
-
 free_container_exit:
     object_unref(container);
 
@@ -286,7 +279,6 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
         vioc->release(bcontainer);
     }
 
-    vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
     vfio_address_space_put(space);
-- 
2.43.0


