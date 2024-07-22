Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F44C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVq8Q-00082j-6u; Mon, 22 Jul 2024 06:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sVq8O-00081j-Ao
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:19:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sVq8M-0001kf-8P
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:19:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LGwmve014848;
 Mon, 22 Jul 2024 03:19:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=LOFVJaoGIIMSv
 Q+BzYToPzbUmTkTk6rvuXUdvxCT1ZA=; b=sPkE2sfYR0Sr17+3fr3DMq8gy8D2D
 osc3rT7yGAvon5Wp5ccf6SHwKMltZFBLtdeWlSfs1VgYVXULveaWrGWy0kzk4QeI
 sATvhcYnV+ldlWbfNM3docCNz5vjdgKYURezd13e8QaqNWtT7blt7h925bknEm0L
 GLKgRBExc87mHjyNgSEDGrVXk4F2Taov+HjlAZ9r72EAdMxHA6RxXyGdHWPu7oBQ
 tHHY6yXnZTHS22OaOWP/TqVEOGjuMA2ekNzdh+k+aydy1mOQRYnPRelQKAwcQ2jP
 192+vVi5DNFRtRihFQRELIhXwGd2c+I5EwtF70HWWsTkMaaqQS7ACYigA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010006.outbound.protection.outlook.com
 [40.93.20.6])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40gcsv2qan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 03:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df2jslBOXCZIH9sP66cLfT3w4T/ck2StCDOfG3U0huI3dBaHaSLdbkTiFWePk3ud0ezA+ppB90gy849BIGN6e3TymgqdN/PetXQwGKj/hjVO0EahkUroIugMvfA8IwtmNmhBHujtf+HPqts0hpEscMwJQ74097ZdOkSpYpn5MkSXb/ydDRFWXLZrYSlgPJaOYv2OaVbNO1UMmM+rAiB78n63N04hPscH+YarfjEr0GHxqn8Axhf3LuoEjNR048+2nDWeaHXeeIjlAVR8iSjtb2fd0b9FWG9Cugpkbg99taPaVPudvESVDD5GLxQchWrIpIwnbHZ+BT6T2fHbWzw08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOFVJaoGIIMSvQ+BzYToPzbUmTkTk6rvuXUdvxCT1ZA=;
 b=xIDX/wOQiKHk6xdaE6HbvIKIQdXgxB3sQ7zs5Z7eISnmDxjJvnJuXCt7YQOVk+maHwWDcQ03iCVTDMjUr+9W/CwpWriGv0V+Y18FoBry/EiDA0+5wJIcIUPBEzt1DKNt8F7dhN0PQsXJkij7Wx7t55xNmK7uk5S6puw+SJHwpvLDhwMeznmuEuVa1urfUZOIE2wyuJvWiaW2UR2pWhYCPl+8Ul9wtAybSsdBur9jcO61K05Ta40MV1q+3E8TCWYlZpQEMTTTs6GCmmcusEkHSa3cO+GlMWXjB8IPuKG5VGgiTM2b953RoM507+/x5QBcBrDTb8Uj4hkNSOB96ZoE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOFVJaoGIIMSvQ+BzYToPzbUmTkTk6rvuXUdvxCT1ZA=;
 b=W66Q4ITLzaqgKTnWnF7FL5QK8uFJKjQixwVP8Oo9j+dYNo2hedaLn/9sQZrUQExzjyBUo0agBO1UyL0pAidBWPsCHnIQFA7Kba+mqjNWwVgJUgZb9zqbDCtfqD+n3/QZTXnxg4aZYwgGV115YAguGWWFneklUQs7xnQHPOGdfFXBuTAIp3tEfOWUKSOkseSiHFp69UU+B2l5s/fRB65NOFmZjc8SKqfyyRG/tMNBBdBhYrjK9ilnFL1BWek/Fbn+RHtbGM5xiaamCF0uUqVJZNIZGYjxgC7LxQFcOZdzBRF3V6RM1YpD1ZpxyZY4BQs784/11gQssYQRPJepJ9nm5w==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BL3PR02MB8017.namprd02.prod.outlook.com (2603:10b6:208:358::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 10:19:03 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 10:19:03 +0000
From: "manish.mishra" <manish.mishra@nutanix.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com, "manish.mishra" <manish.mishra@nutanix.com>
Subject: [PATCH] target/i386: Always set leaf 0x1f
Date: Mon, 22 Jul 2024 10:18:59 +0000
Message-Id: <20240722101859.47408-1-manish.mishra@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|BL3PR02MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 698907a9-be05-456b-bd6f-08dcaa37b5cb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XlgbBN674wKwSsWnoY/H5i4tjM4m2uMI1mSD/eeSccKzpbvUcBc0AZfGeaFY?=
 =?us-ascii?Q?4zcHTLDPQT1aGP6oGbV7wFhPTmKSJVMTFkNNWDZNCJvoi1E9dO3F11Og2ChS?=
 =?us-ascii?Q?ByeiMrUZ+MbbrMHJx2xIwWr9crkrteQneWhO9b3AuisdsMUWHBY/V/BhknTu?=
 =?us-ascii?Q?PrxohJioYDTVt6glXl0zCV4WrHaHmRGMaAcEYuZeZ9g4QpL2wMabB+e8RdMN?=
 =?us-ascii?Q?O16QvVjTywaMGNB/enz3z+DVbLcU4P5Pol3aI+Y3vNJ6jBuxJRshklU4PCwy?=
 =?us-ascii?Q?FaHpEDXBLatclCFJ6v493opZ9G32b76LCE789r85fxsuoIRPdswn5IPCnUzF?=
 =?us-ascii?Q?bbrd2CpKuomk8DNIzeVPVU5kUowdr3vGWcFA8DA3yfEpyNIX4W0532bcc1rg?=
 =?us-ascii?Q?HCcNZmPHt5P5Bf/ri57Cu2/boWw4B7VK9u9f28J77ub+L1fz2UkmRvvTeX5N?=
 =?us-ascii?Q?eOvHQpOEkAcoaus1F89cBbRgw6jIRuInXlX1u/tUaZ81bHhcyEWNRF5X+p62?=
 =?us-ascii?Q?bxNPUY5YpGOaw8pn9u23qvOAyNk1yUZ5w/sb7KMUhKMM4Qs57DgS/+BM9gfo?=
 =?us-ascii?Q?kpIHYhEp0ZQmNqZ5lPE9WwJBARd4NCUVRjBfGPGhhdH4YihaFLq/11haRfw5?=
 =?us-ascii?Q?cz+EbSndQfCnmYk3UaWyjYDZX8CfqBYSC0tjFZv/Y0u7BvKMmKlBnKMuOXqW?=
 =?us-ascii?Q?3/aIXN9wwOpQuSIZq7a6YWN+vc6G2mukTwpHAuMmoh7kf4Z9rFPMck/kQqw/?=
 =?us-ascii?Q?mQCIOl5fYzSchngB6jGA8cbqbveQ5no2ypqjV7fSwzRugH6JuhSf+OOC9GWc?=
 =?us-ascii?Q?f7zLTYihFJvsbWiRqJNrsgjKFwNyf2d1NCfxStxrna6mp98/Ma8KSVIm7huE?=
 =?us-ascii?Q?6ymFGMpTra5dNtCD+2/rzU6LSpi3jiiZ8Dpd+mi0aR9YONmaqQKAApuRpvMF?=
 =?us-ascii?Q?DqSWHN8ciLM4AyyuT9CMSvH1b9MFJ9s8szaM162ksDPpVrKKfy+G4H10wfCH?=
 =?us-ascii?Q?/7DIrxYKi3tmTiBAY0pbG8QnOOJYLtoPQWB/+sQK1WqEaVTvkQet4l+cbJ0L?=
 =?us-ascii?Q?x1qoUBBu+CnQOWIzZI0QHZJkKg6VO/oLtUxG0kc+JngLrcK9iEFMd5bvMJvN?=
 =?us-ascii?Q?h+f5MXe4O2RFe6fpDbws076eUFKTtZuU+cHJCUxebeYTHpBL2kjjbOOKlybh?=
 =?us-ascii?Q?PMjsYf3udKrHUdL8oV3VgqBukPcisa1EXJNGLU/yE50F/1POIswTlX5LQ5ag?=
 =?us-ascii?Q?nT6fnelIAr0sCj/2ezzZNNYubpKLYk14ckiz/c8vgU5mCSyvsbRVye8dC5cd?=
 =?us-ascii?Q?ultoxawG31teLtQgQy0ubGvx8O8JYw8NR0xpH0xouU0A/OCk+VYdBHMrauCy?=
 =?us-ascii?Q?qWmG3SnAWeq8rsQT6d3wurjfcD6dU9fy9Mc6FiJX+s1pFxKO9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2KsEna+HylnWgpfIsTFLfubuYje6jTvgsZVC9jssirdJgyp4CKTdxlU8rq/?=
 =?us-ascii?Q?UPDuTut4YvMoAt53eYSPcCiVgI5ynjwUNIEa0eVABCCZ1zRsId4+ZCNf4WFZ?=
 =?us-ascii?Q?4ibtKRgfXZWnk1E1Qdp6rjtoFyoq0atTb8Y8LL+U3TfG+IiU9f8QLz4gDcOg?=
 =?us-ascii?Q?gu1TJkagmTQW1LG53WB8rYavz2G1/3rPn1RINPrfR7WSYSCr0GvSe6JzhYFG?=
 =?us-ascii?Q?QzOqKn9nD0u9GPoj3FJIJMDWC6IwXEa+UVqqn4NuCRtzbJmdCA8vQJQURPqR?=
 =?us-ascii?Q?6VKHuLg7qOeF85/s74puo7TnVSn795wklcKmkcWvbDRhNggpnnwzG7m0ruNw?=
 =?us-ascii?Q?YgCA0EHAyA+kz4qO76GWwiHSXZ/jqd3k/pZED2BqvlviAhVV7VuzE8gt9aE8?=
 =?us-ascii?Q?v5o+DjvkcEim5EXX4/ehZ6aVg7/GRXAzmb4X7EpotL7MDYxwKvFBQHkrNX0n?=
 =?us-ascii?Q?Tyy1KOLavrmN28V87uLSA0H51ToZ+dwV6L1ACx2+OPgevid6DDEQ1ikGeeFe?=
 =?us-ascii?Q?UpOuyZrHAoqW0R8fytAvYXiBUVZE3Tsu2tlTNc+TqRVGjtbDk9R4+BX4cfGJ?=
 =?us-ascii?Q?VEOih19APMrcWPAw93zEa7hAgtwhF3cQi3tfVoMB7H4yj102dl8iZXfF9LFE?=
 =?us-ascii?Q?AaY6jvMrlQFh3dSBgo/L+vqxZxSoj7/1a3Ol7CXIzEGumDMt7M/R7S3y4fNi?=
 =?us-ascii?Q?WwLatgNX4iCbazOO+HuVnldp1mBRGJHi1fYrfBRnMzNI3EJ+bfF6/zmz6TB1?=
 =?us-ascii?Q?fnVeR5hEoefKGEy6UczhvlGPFaBz8+liEjyGmv0o/diu8SpKdza+EnEgklpT?=
 =?us-ascii?Q?d1iGpziAmCEbFEYrk4kTRKMZ9hdG/cPaXRzhZ6lig0padp/4EqW1Xg7t6urb?=
 =?us-ascii?Q?2175P3l0yEvQPI+QRfz6e9KbWFxBE8XA6Ygqk6FpIPRTwWvwFCfIxzp53LFA?=
 =?us-ascii?Q?t4mVftT80VhuleGKbWz3TM4CAtTO4qbuqv7/oIP0ytV+sHU2IrkZx7dXJqS5?=
 =?us-ascii?Q?fvEzgT+sASRh61dCpPNywHljQyROqXuzs4hdgrRrOmtk556wKyE83UyQHMm/?=
 =?us-ascii?Q?zsmwTEpYONmZzUxKYmPDGnuCTO3lrHIwdG/R61LQbaKdOW7DCEWKUEsJnF+k?=
 =?us-ascii?Q?EIqhh8xEZXhxdP2p5sH1ql7sNQtX7hQAmbliWOcQ1jQksujZR4Q8BoFq0Qg+?=
 =?us-ascii?Q?INhWsI3SMSEhUKFbR76/+UoPoHUCNwbn9GD9yNQ9FF+eV29nKqaL3tonPOGK?=
 =?us-ascii?Q?tf52rHwi2JcenEEuWZWqTrDJsthS2lOPjfFkBUUxXBicAcN0ZB3ke4C4eOCi?=
 =?us-ascii?Q?u8Gh65+/B047ric5h3ABjvxVkQ5DUVXsSZHdufQNb73L0rbu4Xe2ql9Azgn+?=
 =?us-ascii?Q?ZQ7oSif8LQwiZv23+mVmJxMyvaFWQ/QAoyRUAb2yUc2iuENBMniq04TcxXO6?=
 =?us-ascii?Q?npU7/TClgxMH64mGO0WQqwqYVzBnWlYv6Oz1Re34wK2tyaAGT3tOyVuqord4?=
 =?us-ascii?Q?uwSeq6QGuCtcQcOdX5nQu5QjdTlr1qTYDKyI+fpJjRp2TcE/6jlC7GdZEVFK?=
 =?us-ascii?Q?UjIdgKIeImy/6iWLgs3Shcb59H2P9y1VSvaZGyNCjO9i1HgCFDy195452g+u?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698907a9-be05-456b-bd6f-08dcaa37b5cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 10:19:03.0727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp/NTLywpQthIGBlqgfcNqyg7lSuvcwtbzFhjLguZemFGSsQhvo5JiJNhQE7p5RPgH5COFfHBbkh56oMtglg1TTeB7VSX5wUKoug7Fj+AvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8017
X-Proofpoint-ORIG-GUID: d1Brm0Rg96J5k_t0dOftz-labNsAFSv_
X-Proofpoint-GUID: d1Brm0Rg96J5k_t0dOftz-labNsAFSv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QEMU does not set 0x1f in case VM does not have extended CPU topology
and expects guests to fallback to 0xb. Some versions of windows i.e.
windows 10, 11 does not like this behavior and expects this leaf to be
populated. This is observed with windows VMs with secure boot, uefi
and HyperV role enabled.

Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
to 0xb by default and workaround windows issue. This change adds a
new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
case extended CPU topology is not present and behave as before otherwise.
---
 hw/i386/pc.c          |  1 +
 target/i386/cpu.c     | 71 +++++++++++++++++++++++++++----------------
 target/i386/cpu.h     |  5 +++
 target/i386/kvm/kvm.c |  4 ++-
 4 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..4cab04e443 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
     { "sev-guest", "legacy-vm-type", "on" },
     { TYPE_X86_CPU, "legacy-multi-node", "on" },
+    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2..f89b2ef335 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
     assert(!(*eax & ~0x1f));
 }
 
+static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,
+                                X86CPUTopoInfo *topo_info,
+                                uint32_t threads_per_pkg,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    X86CPU *cpu = env_archcpu(env);
+
+    if (!cpu->enable_cpuid_0xb) {
+        *eax = *ebx = *ecx = *edx = 0;
+        return;
+    }
+
+    *ecx = count & 0xff;
+    *edx = cpu->apic_id;
+
+    switch (count) {
+        case 0:
+            *eax = apicid_core_offset(topo_info);
+            *ebx = topo_info->threads_per_core;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
+            break;
+        case 1:
+            *eax = apicid_pkg_offset(topo_info);
+            *ebx = threads_per_pkg;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
+            break;
+        default:
+            *eax = 0;
+            *ebx = 0;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
+    }
+
+    assert(!(*eax & ~0x1f));
+    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+}
+
 /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 {
@@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0xB:
         /* Extended Topology Enumeration Leaf */
-        if (!cpu->enable_cpuid_0xb) {
-                *eax = *ebx = *ecx = *edx = 0;
-                break;
-        }
-
-        *ecx = count & 0xff;
-        *edx = cpu->apic_id;
-
-        switch (count) {
-        case 0:
-            *eax = apicid_core_offset(&topo_info);
-            *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
-            break;
-        case 1:
-            *eax = apicid_pkg_offset(&topo_info);
-            *ebx = threads_per_pkg;
-            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
-            break;
-        default:
-            *eax = 0;
-            *ebx = 0;
-            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
-        }
-
-        assert(!(*eax & ~0x1f));
-        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+        encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
+                            eax, ebx, ecx, edx);
         break;
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
@@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         /* V2 Extended Topology Enumeration Leaf */
         if (!x86_has_extended_topo(env->avail_cpu_topo)) {
             *eax = *ebx = *ecx = *edx = 0;
+            if (cpu->enable_cpuid_0x1f_enforce) {
+                encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
+                                    eax, ebx, ecx, edx);
+            }
             break;
         }
 
@@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1e121acef5..718b9f2b0b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2102,6 +2102,11 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Always return values for 0x1f leaf. In cases where extended CPU topology
+     * is not supported, return values equivalent of leaf 0xb.
+     */
+    bool enable_cpuid_0x1f_enforce;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index becca2efa5..a9c6f02900 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
     uint32_t limit, i, j;
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
+    X86CPU *cpu = env_archcpu(env);
 
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
 
@@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
+                !cpu->enable_cpuid_0x1f_enforce) {
                 cpuid_i--;
                 break;
             }
-- 
2.22.3


