Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A516ACCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8F-0000d6-2F; Mon, 19 Oct 2026 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm84-0000J1-I2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm82-00046R-Cd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:12 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OsGS3282325; Mon, 19 Oct 2026 05:06:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO
 9w=; b=UX06c5Exv78Kz4BBZsi3VCAgmIcrm0jMNL6PDWjTVdvwggpUPzYyDzqHe
 +Av7ZnNTv1qisV53N/7x8VIQqSA4glAla7HetAQ4D2yuHrhESugC23UPVAwxaY9q
 5RbJivJbf/fyWK0HhM+tr7DgNEBhFEHtLZWVFpmbGqRLjsNxthhr2eTQukUo+qJO
 zRJ06JOPNqtOSAmdwnA9ljXOeRrUleFBvi1S4bCmyGw2BirvWQ0Vftrji9HCnRxC
 N+YhukL3Qld5sX6vLSnGjPYH8vc6+ZU8bbr7GMfT87hkfh1O5LJobWbfLgR6D4to
 yGERG27FeQ/ix60J//Gyn8O4QvGqg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020080.outbound.protection.outlook.com [52.101.61.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc74ekje3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcznPsKCUpX7oX0KmxXT1gejoNKCxbGD9I3jH8WOmBVu5E4OWYXi6rKGSBKr/jTXwFKc2Vm1j4nA6dk2cd/7xJwCavGCFECTlJ2HDKLNki+XS/VXTcxlhufyrS/WmYOq/J1LtSzlMGlrKGV3q0YF7bQotL4nrs8LmVFrcs9+h6/AYTEZkMUCgE/2yLEAdZ3M5+k4pRrkQvJY/1VUDgmMVUUQG30BxuOHttyMwSAltx6uLEdThyiHVMnX6cBeYvI+0y41LFCplttnLMzfZ/qOSWNHhG5xg4bXxLZME1HZpOU8trzy7U+/qbUeAB3i61l6vD7bTnURdzzbV5XbKGk+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO9w=;
 b=b4cWFd8bDgSp7S2z3pPRvgxrR/q8krligYplH8TC1rGsiEL7EcYuPRBleKXf353WWsrM2AQKN2j3Q986Azz+/0zAgPQAe0yeZWPCbPtQEZY1k0S7GJuQuXi9xoxBTd/NGwYXlJQdmI9vVG2GPLo9l1r5fFTUiAzJjVEoj5tog9SZ7/mP8G0tnA0+91iyyw1Lt/YSX/hXl88oxRs8NVuBvjuO7t8P15FQS/pQNtHFzpYKquH1A3APepwnpUdz3cdGVcegs34mgzD1Pwc8sJwn3MWyqlwpWsWiExSXHbJgz0sNiZ3zmNPO5vvPDRswBAb7Oa6jtvH0AD2aZr59O3b1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO9w=;
 b=q6H7EO7PLEhAxLsyInNuVLrbpvDfXPu3kqsFF50H0Bur+j7ufbN5XhcW6v51nEN8r5l+mgfi+7wAsQDD6JsKrRPUQn7AGOG2OWP2vYyf1b02LygWCyFw3Tz8EcyjE4bj6aOD9ouSHY3FUIYLbdPuts61tWP4WvqQPj30JMP50tHLUUqBUgtDor9w8i7LVjMAPCxVTvWZT9JEUlJ0E7RfOI5VKS5kiXdN/MvL1K5T/zFKZDi7QwLLhzFUn2OGgRtdwURfS6Y1ihaCXEDJVq3UZcSd311jlU++mbs4NTFBRywFKx5ZfVJqafy/yxV4k+SeFp5UJh6DkAt4U+9GxIVJfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 13/28] i8259.c: use i8259 prefix for functions
Date: Mon, 19 Oct 2026 13:04:45 +0100
Message-ID: <20261019120517.1448687-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: fa172ae7-49cb-48e7-8556-08df2dd958a8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: S9UH6dCrkwI3HZcxqr+AD6jPGOV8sSHPTvF+M8OsuvVroaOSzrxT2qLsqeOkEr909+azhOw5dC5UciKYnUsZCi8UGqfA4aVLUTW0lP+zhPSF+3ANtQdCZH4A0+5U+Q9YGat75t+Qmo7KSvEMPxZnSwj/WOpKGnhg27aBwSo8eFQGx8beNglQ7EsE9zSr/mlnYyRD7BZO+8ewImgnoBR9gMfxlaOTyDINYrUlypGHF75iXC94DjaR2axaNZluzz910Vhpnk6XZ3aTXStzb+8czssT8ZV94s02JPaKfilDBZ6/RZFN3ikFR9QrKIcM6ii4cBZHHwbH9fGWIKNM/vrclPuYWRUOO+KP9G/FpyS9MzDTTGzJfMVyopyhMYOXHLuvsEil1zu4nG3ALwoT3YKkEnm58fw6LjO+kjpYRKYTalshqrvvXya+i1/gWBKKZxmUZhv53JwBqAVp9R2F/C7KuudAyKBHgPUx42yyymDTpmA7BUl4vIuZnLPuqfaHmHtVkBO5KQr119Hu4hp24S3qCq+smwGk+AUZl334qwYPm2VUPLuCMp577xAaVrCk3PjgUUr6A8ijKjcalfdrRItP2IAXFH/+YXwzQZQYmlALbHOCBBMuYo9HFMff1KXzW2I6CgPqUZFkg4HCZ0AvnKPNkGqVGmFcB/186Tw1G5Q8DPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o49tzVnSU/f2U/S7RZNlh96lrT63f4Vxn0eAAuM/wz+R7VNmRmWUdKOeQdqG?=
 =?us-ascii?Q?w7aMB/rZ0TopY1WRPXIcZCM/A7J4or4aBhHgJDZef2qQsrSpFSzBRlDWQT7p?=
 =?us-ascii?Q?B8O6U2cryJm0pgTPguEdGhqhFReRTurU2CO2STTYT+KyhBrj1qvKFNqj1Yn9?=
 =?us-ascii?Q?SZa6QfQuTrXnB2NxxGoPQ6txNsKd2cEpLIx1a4dYxgdrr/uwPOtdmMUa4+VG?=
 =?us-ascii?Q?S7XGSEf/8xYHl1UTsmy8ThpgdUpr4qWDS9lJSfooBhp8OZLwRTjWmD3oq0al?=
 =?us-ascii?Q?Hob6aP6eaghq1TCB71un73bmjP3Qz5747wbY3kD25+YSpIPAqO1Xvj2IspMT?=
 =?us-ascii?Q?06QKFWA/upKkKma3BUZJXX4NDCS/IYFWengZ57nTbjSmgnrv8i8LJPlVlkzC?=
 =?us-ascii?Q?64TyR5640EGQBiixkZLziBwdjF2NJmSmURLrRcXqoMwHhQl+2mwYbXvO2ODj?=
 =?us-ascii?Q?h14BQtu91e/H9nLdYoAnZ4FOlEjchp3XJs8UfX9fHwT8wmtXiSqb/owo639f?=
 =?us-ascii?Q?idqgCjjTYMf7LfjzO5/xMYEBTATeI2WP2gIGnvX0jCWbk85FtxOlYEGFCOmh?=
 =?us-ascii?Q?DAjr/Zq2Hcb0jDhjU+rXBPpaYjrml5iRt4XSKj+wm5uJt9jY5v6ghEVt582P?=
 =?us-ascii?Q?/LhkLOHWkDZ5phjeh4LN5HeGEdO1i0WJjMd1ayIWrHLjvYBG5qFpDZSnefMs?=
 =?us-ascii?Q?8m0ZUCQ16Q0/BQKeN+QbzdSdIiztpAlxmz2w1XuRLdEbrp+jmjvRd1M9fTyM?=
 =?us-ascii?Q?O4EGKj5nOb+glHSCcbFzW06LARzkRVdljzzyD9I+bSSY1kVlS5s8h+DDq7Oy?=
 =?us-ascii?Q?BsCfsqeEaHoWzPQ5JtBmCapmJ2yZ47mFjEbgAoPQtBwVT9N84fRu90stJqiQ?=
 =?us-ascii?Q?/iV0qSM+N0aBnrppehMofjFS3/Qnm/eEdwcCdHNlU82j8GLjvNzchlo9hVA4?=
 =?us-ascii?Q?Eu+f4sEFZycVm7w9BeVZ6Cxov89TD4scDrD+Rj0bqjQHadPjhVQ3JF2RFtMr?=
 =?us-ascii?Q?5shpqSUAFOhP5CszlPTgapxfzkjj5QnY+xL6AcDVezpK/qhTK62H+dyVzPfu?=
 =?us-ascii?Q?f7LDvLMeFoPB1ymUYvSZHKyPdPO+3xlaoIVpPMj5g4cxG/MDO65XEH6jkMSJ?=
 =?us-ascii?Q?BNW+1LyFFTBGMuSEVQaA5FZ9UzXrwvDMMhIX78WOFhcVuGnm4opKQw6zudxL?=
 =?us-ascii?Q?z9uv62pl7sdhCXcwnOSI24u/zmbuAGieqPFXC01zQB9Be0gFQlp7jsY4wCTW?=
 =?us-ascii?Q?5sObi3Smx15bab13q7A5oeJ11s6PH6cQwgBDxANj/47dz2KCz+XwPEwPNtz+?=
 =?us-ascii?Q?TbjWFdyV8Vt8RFPhspSjz3h6y+dyF1+UjA2XA3JGE7luCI/7JlI3Fklrr1mh?=
 =?us-ascii?Q?X+WRi4nKg4B3nNNzSSUsAkjgB1mMi+7pp2xkR1DN4XsuCDOWSqIHIHUZm5a6?=
 =?us-ascii?Q?koqTJ111NCvPVKAkr/p61mCe9340d2Rx8iGqY3YniKpxRsf9a75dVPjDnY8p?=
 =?us-ascii?Q?izOsVqhqcmlcWX1AM2NsXfRird3EbqDGc+Z5gi4p0w1/a2vu7CnTCXxoPK65?=
 =?us-ascii?Q?InVXyL49AOkaIrQJ2775d4xz3wcDeYcrbei1PvtA5ESOzJA+29U9wQnFAgvr?=
 =?us-ascii?Q?Oa2pW38MklrejSlqyL1EFZWORXOPTtpAp+dXm3iieOgBnJs1c7U//VbDty63?=
 =?us-ascii?Q?h6qkmezhv+HFnybzWTafC0Y6VLbQL4o5oZprOc+rbjYI6WGyGgl1nXLXBIvT?=
 =?us-ascii?Q?baWIxre+vBCJR6aqHZB4h0ylUECE9M0=3D?=
X-Exchange-RoutingPolicyChecked: YVOXh0uhQgbO+a3nnP7N3wisbshtVwvbd/yJgjn04a9M+CMfhXm9hEl9olyd/MF/o/RCJoQnzJCKNHZPTTOWy6ANqj8+ho1zV+pFqVc5sT+knN8rrMK9DW7P+Kle6VHf/Ef9bGHmRmbZY0yznn4hx4gOy4BfACoSPIuyZFi4kDn5NIHmgo15dJBm+1N1yU5ezkh92+Utzo7yyvKDoZwgbQ1RozkWLi/0/MpXXECmHhi3kOHSbVXV3b69WXNCVASk4LFPdHZsB3wAFRJv5yvesi8qcQI5f1pB0xLnQnQfK3/eqT5WHaCRaOJBMMJIgTJXovFpFyz2uHgR5kqgdy60/g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa172ae7-49cb-48e7-8556-08df2dd958a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:03.3880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DIaaox02iSbIzzkLpokkHo9OA2sRiBlJcsKu9szbB0Jqt6lFY7lEhCM0wQeCywsyfk4ZAstJUU1i/TO+XE8+r/AUJCikQWnxdNbj/JAZF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-ORIG-GUID: 22aMbDFpKLGza0VF2G0YpVzTwkjh4taC
X-Authority-Analysis: v=2.4 cv=HYGB3SE8 c=1 sm=1 tr=0 ts=6ad607ac cx=c_pps
 a=UMsKb9OrGFB5W2EpWsGVZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=n0Z0T_akzs0uib7mm64A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 22aMbDFpKLGza0VF2G0YpVzTwkjh4taC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX68bLQwx4fDo1
 zi7Fqep6djWcZNVzZj/rfW0D091wXBmZCb0BFMwqhNUFNE5oKIHyaIGFhlN2yJJJKDfSwnVRCg2
 4lAHfqBZ9eR7ZahkTm1c2CyE/puRBHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5wGbXOkLUYjs
 alq9f2fU11C0jzhOLDgCpRmgCvyzeF9s0ZIrYUpbYps7iMAdhHe8ZOVa88taxJ19HKEuVMVOGWf
 XX0UKPxNs92YLSRKX1cjfsCnhilbQYIh3mEwBaq7AdU2sud3b28SHooBv7aAgc8GIPFkqcEaZ2Z
 ahR5i/L2/ACrSG//ci+rIWFT4Wo/JqHS9agAee3YTnTVSa9leaNu2dF5n2INvRJVA0Zh1T7IrIj
 nigov5FMfFZhMO6bs53Lob82co50bsPrsi+VFuihumR40peQ0xFBH/KRLiawCJixNCfNZvDmYib
 l26stBNbGc5DHqYlOhR5WNVE6jESsNrR7930p4Bt9TiMu9g7PC+Jv/XWWr6fXwIq6iivAwRai++
 ewE7cku3scNKnnhEQ9wX+yEgEJ+veZs9+ZNJEQ5s8GDBl7JW/ZMrgCJS+2CVZzU/Rne0CKD0PpO
 K6H8u8AY0RPLzg8Iayg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This ensures consistency with our normal QOM-based naming convention. Also
update the trace event names for those trace events that originate from a
single i8259 chip.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/i8259.c      | 104 +++++++++++++++++++++----------------------
 hw/intc/trace-events |   8 ++--
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 97ecb77407..4b34e5a649 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -73,8 +73,8 @@ static int get_priority(I8259CommonState *cs, int mask)
     return priority;
 }
 
-/* return the pic wanted interrupt. return -1 if none */
-static int pic_get_irq(I8259CommonState *cs)
+/* return the i8259 wanted interrupt. return -1 if none */
+static int i8259_get_irq(I8259CommonState *cs)
 {
     int mask, cur_priority, priority;
 
@@ -103,13 +103,13 @@ static int pic_get_irq(I8259CommonState *cs)
 }
 
 /* Update INT output. Must be called every time the output may have changed. */
-static void pic_update_irq(I8259CommonState *cs)
+static void i8259_update_irq(I8259CommonState *cs)
 {
     int irq;
 
-    irq = pic_get_irq(cs);
+    irq = i8259_get_irq(cs);
     if (irq >= 0) {
-        trace_pic_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
+        trace_i8259_update_irq(cs->master, cs->imr, cs->irr, cs->priority_add);
         qemu_irq_raise(cs->int_out[0]);
     } else {
         qemu_irq_lower(cs->int_out[0]);
@@ -117,13 +117,13 @@ static void pic_update_irq(I8259CommonState *cs)
 }
 
 /* set irq level. If an edge is detected, then the IRR is set to 1 */
-static void pic_set_irq(void *opaque, int irq, int level)
+static void i8259_set_irq(void *opaque, int irq, int level)
 {
     I8259CommonState *cs = opaque;
     int mask = 1 << irq;
     int irq_index = cs->master ? irq : irq + 8;
 
-    trace_pic_set_irq(cs->master, irq, level);
+    trace_i8259_set_irq(cs->master, irq, level);
     i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
@@ -152,11 +152,11 @@ static void pic_set_irq(void *opaque, int irq, int level)
             cs->last_irr &= ~mask;
         }
     }
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
 /* acknowledge interrupt 'irq' */
-static void pic_intack(I8259CommonState *cs, int irq)
+static void i8259_intack(I8259CommonState *cs, int irq)
 {
     if (cs->auto_eoi) {
         if (cs->rotate_on_auto_eoi) {
@@ -169,7 +169,7 @@ static void pic_intack(I8259CommonState *cs, int irq)
     if (!cs->ltim && !(cs->elcr & (1 << irq))) {
         cs->irr &= ~(1 << irq);
     }
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
 int pic_read_irq(I8259State *s)
@@ -177,24 +177,24 @@ int pic_read_irq(I8259State *s)
     I8259CommonState *cs = I8259_COMMON(s);
     int irq, intno;
 
-    irq = pic_get_irq(cs);
+    irq = i8259_get_irq(cs);
     if (irq >= 0) {
         int irq2;
 
         if (irq == 2) {
-            irq2 = pic_get_irq(slave_pic);
+            irq2 = i8259_get_irq(slave_pic);
             if (irq2 >= 0) {
-                pic_intack(slave_pic, irq2);
+                i8259_intack(slave_pic, irq2);
             } else {
                 /* spurious IRQ on slave controller */
                 irq2 = 7;
             }
             intno = slave_pic->irq_base + irq2;
-            pic_intack(cs, irq);
+            i8259_intack(cs, irq);
             irq = irq2 + 8;
         } else {
             intno = cs->irq_base + irq;
-            pic_intack(cs, irq);
+            i8259_intack(cs, irq);
         }
     } else {
         /* spurious IRQ on host controller */
@@ -213,34 +213,34 @@ int pic_read_irq(I8259State *s)
     return intno;
 }
 
-static void pic_init_reset(I8259CommonState *cs)
+static void i8259_init_reset(I8259CommonState *cs)
 {
     i8259_common_reset(cs);
-    pic_update_irq(cs);
+    i8259_update_irq(cs);
 }
 
-static void pic_reset(DeviceState *dev)
+static void i8259_reset(DeviceState *dev)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
     cs->ltim = 0;
-    pic_init_reset(cs);
+    i8259_init_reset(cs);
 }
 
-static void pic_ioport_write(void *opaque, hwaddr addr64,
-                             uint64_t val64, unsigned size)
+static void i8259_base_ioport_write(void *opaque, hwaddr addr64,
+                                    uint64_t val64, unsigned size)
 {
     I8259CommonState *cs = opaque;
     uint32_t addr = addr64;
     uint32_t val = val64;
     int priority, cmd, irq;
 
-    trace_pic_ioport_write(cs->master, addr, val);
+    trace_i8259_ioport_write(cs->master, addr, val);
 
     if (addr == 0) {
         if (val & 0x10) {
-            pic_init_reset(cs);
+            i8259_init_reset(cs);
             cs->init_state = 1;
             cs->init4 = val & 1;
             cs->single_mode = val & 2;
@@ -271,23 +271,23 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
                     if (cmd == 5) {
                         cs->priority_add = (irq + 1) & 7;
                     }
-                    pic_update_irq(cs);
+                    i8259_update_irq(cs);
                 }
                 break;
             case 3:
                 irq = val & 7;
                 cs->isr &= ~(1 << irq);
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             case 6:
                 cs->priority_add = (val + 1) & 7;
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             case 7:
                 irq = val & 7;
                 cs->isr &= ~(1 << irq);
                 cs->priority_add = (irq + 1) & 7;
-                pic_update_irq(cs);
+                i8259_update_irq(cs);
                 break;
             default:
                 /* no operation */
@@ -299,7 +299,7 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
         case 0:
             /* normal mode */
             cs->imr = val;
-            pic_update_irq(cs);
+            i8259_update_irq(cs);
             break;
         case 1:
             cs->irq_base = val & 0xf8;
@@ -321,16 +321,16 @@ static void pic_ioport_write(void *opaque, hwaddr addr64,
     }
 }
 
-static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
-                                unsigned size)
+static uint64_t i8259_base_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *cs = opaque;
     int ret;
 
     if (cs->poll) {
-        ret = pic_get_irq(cs);
+        ret = i8259_get_irq(cs);
         if (ret >= 0) {
-            pic_intack(cs, ret);
+            i8259_intack(cs, ret);
             ret |= 0x80;
         } else {
             ret = 0;
@@ -347,7 +347,7 @@ static uint64_t pic_ioport_read(void *opaque, hwaddr addr,
             ret = cs->imr;
         }
     }
-    trace_pic_ioport_read(cs->master, addr, ret);
+    trace_i8259_ioport_read(cs->master, addr, ret);
     return ret;
 }
 
@@ -355,53 +355,53 @@ int pic_get_output(I8259State *s)
 {
     I8259CommonState *cs = I8259_COMMON(s);
 
-    return (pic_get_irq(cs) >= 0);
+    return (i8259_get_irq(cs) >= 0);
 }
 
-static void elcr_ioport_write(void *opaque, hwaddr addr,
-                              uint64_t val, unsigned size)
+static void i8259_elcr_ioport_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
 {
     I8259CommonState *cs = opaque;
     cs->elcr = val & cs->elcr_mask;
 }
 
-static uint64_t elcr_ioport_read(void *opaque, hwaddr addr,
-                                 unsigned size)
+static uint64_t i8259_elcr_ioport_read(void *opaque, hwaddr addr,
+                                       unsigned size)
 {
     I8259CommonState *cs = opaque;
     return cs->elcr;
 }
 
-static const MemoryRegionOps pic_base_ioport_ops = {
-    .read = pic_ioport_read,
-    .write = pic_ioport_write,
+static const MemoryRegionOps i8259_base_ioport_ops = {
+    .read = i8259_base_ioport_read,
+    .write = i8259_base_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static const MemoryRegionOps pic_elcr_ioport_ops = {
-    .read = elcr_ioport_read,
-    .write = elcr_ioport_write,
+static const MemoryRegionOps i8259_elcr_ioport_ops = {
+    .read = i8259_elcr_ioport_read,
+    .write = i8259_elcr_ioport_write,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
 };
 
-static void pic_realize(DeviceState *dev, Error **errp)
+static void i8259_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     I8259Class *k = I8259_GET_CLASS(dev);
 
-    memory_region_init_io(&cs->base_io, OBJECT(cs), &pic_base_ioport_ops, cs,
+    memory_region_init_io(&cs->base_io, OBJECT(cs), &i8259_base_ioport_ops, cs,
                           "pic", 2);
-    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &pic_elcr_ioport_ops, cs,
+    memory_region_init_io(&cs->elcr_io, OBJECT(cs), &i8259_elcr_ioport_ops, cs,
                           "elcr", 1);
 
     qdev_init_gpio_out(dev, cs->int_out, ARRAY_SIZE(cs->int_out));
-    qdev_init_gpio_in(dev, pic_set_irq, 8);
+    qdev_init_gpio_in(dev, i8259_set_irq, 8);
 
     k->parent_realize(dev, errp);
 }
@@ -443,8 +443,8 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
     I8259Class *k = I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
-    device_class_set_legacy_reset(dc, pic_reset);
+    device_class_set_parent_realize(dc, i8259_realize, &k->parent_realize);
+    device_class_set_legacy_reset(dc, i8259_reset);
 }
 
 static const TypeInfo i8259_info = {
@@ -455,9 +455,9 @@ static const TypeInfo i8259_info = {
     .class_size = sizeof(I8259Class),
 };
 
-static void pic_register_types(void)
+static void i8259_register_types(void)
 {
     type_register_static(&i8259_info);
 }
 
-type_init(pic_register_types)
+type_init(i8259_register_types)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7512c6e600..003924ddb4 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,11 +1,11 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # i8259.c
-pic_update_irq(bool master, uint8_t imr, uint8_t irr, uint8_t padd) "master %d imr %"PRIu8" irr %"PRIu8" padd %"PRIu8
-pic_set_irq(bool master, int irq, int level) "master %d irq %d level %d"
+i8259_update_irq(bool master, uint8_t imr, uint8_t irr, uint8_t padd) "master %d imr %"PRIu8" irr %"PRIu8" padd %"PRIu8
+i8259_set_irq(bool master, int irq, int level) "master %d irq %d level %d"
+i8259_ioport_write(bool master, uint64_t addr, uint64_t val) "master %d addr 0x%"PRIx64" val 0x%"PRIx64
+i8259_ioport_read(bool master, uint64_t addr, int val) "master %d addr 0x%"PRIx64" val 0x%x"
 pic_interrupt(int irq, int intno) "irq %d intno %d"
-pic_ioport_write(bool master, uint64_t addr, uint64_t val) "master %d addr 0x%"PRIx64" val 0x%"PRIx64
-pic_ioport_read(bool master, uint64_t addr, int val) "master %d addr 0x%"PRIx64" val 0x%x"
 
 # apic_common.c
 cpu_set_apic_base(uint64_t val) "0x%016"PRIx64
-- 
2.43.0


