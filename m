Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECA0CCFA1B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH3QX-00035U-VD; Thu, 06 Nov 2025 12:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QS-00031t-Oc
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vH3QQ-0000tj-ER
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 12:05:32 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6FiLHY1143749; Thu, 6 Nov 2025 09:05:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZZq+u55t6wAhrf4dPhIxJ/8W9iMtcE7Xv9ci89hhr
 Fw=; b=QM5ijSOFz4UovM7/hU0+vSZpwQQfYu91fza79NIm5a4vLIqIGJ7GTx8eX
 if00JbwUDFN+8aLtRh477sCx3E4jOp3m4hwUjLuMQ4F2Lyr0BOs1nx4qFE9kaN+W
 4mU/28ldQyl89IpG7E/nKxXwBduKeDS8ZtnvIC2TCCW2Cj9LGiJ1aJXv2jmygt9H
 5kjxkFWecw1w84cmU3Z7kcz177nkE8BRBvxl1gN9W+3HYbwdGvznvdL6wyOIHW0C
 VEZPFXZ5cHjCYqCTbJDLl8NQIvJLcXIedS1UvubZTnCEqaiQJzdpJsllYJacabC2
 j+Gqn5BIQDMJO0GbZARnwrCeUg9Ag==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bch2y2s-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 06 Nov 2025 09:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQfEFgR57vBox1Zh1P3LRhF/mdLDCNdOcNS2d65weycDByS5tZ39rJ0GWrmtYmXwPonOn6MLJ7dy2eiiHCTqgXh5T/WcwoFqGP+pqIPRQ2IbpZ29py8mH63pDXqtlDT/eE90BAEnnX6oHN6P2ktXCrsBvxlRSwHN4T0cvjfYKw02Jfll4GWYc2GE9EeGGWp/gbSPwX6wVT48M/MkEP0TAM6NF3idyXsHhzAf19lHhBgvJs8sfvDlAczl2ov3VEVX2KI/chfNd5ezkQdEZPjZTBaPg87DiJkDIiPaIg66xAKuwMRgY0/nJgx0fuPD07n9lvI0vfyCXCGGTceEIzkIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZq+u55t6wAhrf4dPhIxJ/8W9iMtcE7Xv9ci89hhrFw=;
 b=V5xk3prueo+JZFRaACrN5ZDitB6TIhSZ+bGvYvn3HLgrRGE82j+9UfJf27N4yo/szJ+Tx7Dm38Bejc9csKLDVZRX/ubio8sVipx5OBUMaySk4i/Z8BIqR21bsLq27NvlhroLdFsNZy/eUt/0LS0v8mFL+KUbqIfRctxKZNxNH98yLulYiPY0YsxXfqhlhln5IjoyooOHKes0UI9u6NirkuGoqm4N2uVuNc23S0SfRY4S7rzd+9EbJCl4tmuN8h1D1hFSPGCrPVDLO+rb9kGko5xnE1EHuuT0Xv6VoAaPerCFh/zps4uOJI+Pw0qAvqCP7pL2d0K8NFoFgFI2vhv8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZq+u55t6wAhrf4dPhIxJ/8W9iMtcE7Xv9ci89hhrFw=;
 b=P8t7oIrPx1BVrH2Xy9rXgPfmMGmWggsTRksEiK3Zh8pIqAuOXXlw35yEK5aVnMDiASqjYJoa31BBEY8rEA7u5d5xjup1d69n0gWFe14YmYk7agMvfpdolARq1RExfg7To2lOPCiF53e/zep8KpHnAw9VLA6FPguJmI3u61wH2d9EIMjlF5hTpQlzLrk7W1bbgF6m4eBmogOLqW5SCYB7Q7AEcMTVZWAnocSiOGEgIqfmp58hEsVXkBhfmTAXYxQvaJK9ZXlvZVr35NAZRTwqv2DU9SsviOdkdWLxCr+4vOrFAcUjrl6o1NXlLkz/GehiHv6e+dHUGaFS7ZnvmQQaJw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BN0PR02MB8000.namprd02.prod.outlook.com
 (2603:10b6:408:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:05:26 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 17:05:26 +0000
From: Jon Kohler <jon@nutanix.com>
To: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 pawan.kumar.gupta@linux.intel.com
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH 4/5] target/i386: introduce SierraForest-v4 to expose ITS_NO
Date: Thu,  6 Nov 2025 10:46:24 -0700
Message-ID: <20251106174626.49930-5-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106174626.49930-1-jon@nutanix.com>
References: <20251106174626.49930-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:510:174::9) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|BN0PR02MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bbb3d9-1fc0-4fbe-f1fb-08de1d56ae40
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IrDhPDnVVqfoQWOxkzaYcin1aYpdKzXGSCvQk6YRxRwIBvMn2NuxpbC3K4zx?=
 =?us-ascii?Q?QtDE8axMJJwi/xoCuq2Ow4yzEks3TkQ1H1wnCu0M43Q+hWGJSzi+01ZKGqVq?=
 =?us-ascii?Q?m174DR3dflOsddHt/wbg8/x/mY+f97R2zNP5P5Sq2KP7733OQWX+Uu6t0NS1?=
 =?us-ascii?Q?dKJ17YE/77BIGmEWsND1bkYSmPaVJywYdrKUA1ppJwpKC8KKjLmwAYhfi8AX?=
 =?us-ascii?Q?5ugJ/5gHlR+reCBFaNJJt3+WzePUW3OOq68LyYk7TdmF6FWO2Ozfbcd+xBTy?=
 =?us-ascii?Q?mbfrA9Cltkn1XXO1pnIyeXaZ5dQPor1U5vFLbhsE1EpjRJ6i3hJNxakrJ9JO?=
 =?us-ascii?Q?4V1V/kdIcX1O4SY9p35R+QSXcabxWUd2M2o+dk1CXmL1vUkU1Idw/3kGcNge?=
 =?us-ascii?Q?qm+++7CbSWrgTzRLjANRi2bYXx76Jh1CjPW8UAcw8w75S0N71qBihVez3qWO?=
 =?us-ascii?Q?v+isDwlwAfQ/hWyqCSMcraIuGKXCRKy0It8KgBbcOFUuJ1PAqWN09C+93/1x?=
 =?us-ascii?Q?5TE342AIKxRmhmRU2R4/xfRilOCyzHVZG6jAr2Ea5WzAknQpWbl90+b2a4xa?=
 =?us-ascii?Q?nzvdGBpXQvK41rljON8DFynR8bBd65mseicgQ1EJcmNifJnNKPifPmpz4IVE?=
 =?us-ascii?Q?2ZJoZXzM2On3h47rL3ywfFLqAbmt4tbRZEWyd46GQ4744qR2N5WEhalguiPY?=
 =?us-ascii?Q?MSEkONaW1hGDRh2r6AXLGVJeDXYrqzuRHYBh4G2sWJfR18/nFZJlSwNqGrBU?=
 =?us-ascii?Q?ebHTTrWn/v8p/Ij+wwWbtA03rVbsMO9YrwOj7wwLr3Q3rVtUegUJQRvbIW+0?=
 =?us-ascii?Q?yTixVWfQxIgfq0aU9hveLMRhrPjo59Ao41Y9qW5QPLWIYwnrZ/e0iis7yOYV?=
 =?us-ascii?Q?2eLOylc3dO69chOBTRanJ0C1KyhD+VLeI2tiDl+8UDaRleqGvoK2wPl3+pE9?=
 =?us-ascii?Q?cFMgVmSRrtsRAVJV47qzX2h4KoUWch+oy9up+IMuz2esEx0iUe5tzpICRuZg?=
 =?us-ascii?Q?otqKi80WCapfaFu8bA1hexS8/mOyeIjK+qStGQWf/qyNrAJqPaqMX7qPhNKa?=
 =?us-ascii?Q?3bMC4FF6+/FOyIAf9gbUeJgK0d4SWnC0kPh6SF7lZ6qjUig/J7WXT7BIyzU7?=
 =?us-ascii?Q?qdPMzuXuTYDd5GnoQJ/T1LYrAdexmJEi+yVxmkAokvRJj5GPVEwpAMzV4gB2?=
 =?us-ascii?Q?or64lZ7fuPEM0fxdF2y6cHxbKxc2/KizEc8+Duw/aQsbfxi/ZA57dIamKIhF?=
 =?us-ascii?Q?Qlw2VKs1nRVM8gawBfp4PZG5DCf3KHkAcFxdf/D61YfqayUn/SMgh3ElpESh?=
 =?us-ascii?Q?YTToRzGm869RTY2AKI63ttp59sy4ZBbc4NIkEqOe8EsYFztLVfwLf00a13n1?=
 =?us-ascii?Q?Z+qEY+2LflXG2fGijmqWKqd1e/1iIxCh1eDua1QtsMj4eJutHohJvBE7hcv9?=
 =?us-ascii?Q?eHFnrzAxx281+EZ68G7iGqBsb84isVkHhjplN8DaoUlwA1A8VHpb4onbo7OC?=
 =?us-ascii?Q?5a3NuKVpM5n16H6037K8M9soHnSPp0cuv+Wm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9W8xjlvSx58xWtmGuDtNxEj62x/GMZQBmuYQ4Uyxwze+mIS4jnvjhs5ia+fC?=
 =?us-ascii?Q?RvK8jfVoYMMn3+Fx+RBMH5ERPnWEeHOo4wXmhrmI7fHB4rZVWArfp0V+9YAa?=
 =?us-ascii?Q?g/CeBkD9b2ryyNNvciSgc8/Xe+UN9Z/Yacs1j6ZS+AS6tvb0kP9b2sTgS0k5?=
 =?us-ascii?Q?FV7nfOB22U9z0QLlI0L8MgdvO3b35zxVzuBsaX95SG8R2w/lPa0QBMOs4gc4?=
 =?us-ascii?Q?Ktc/CdB0zCzhLox/xJ9jVYB0lt29CI7counDPwRNnHRQUF4DZlYjOK0rm0Id?=
 =?us-ascii?Q?jm00yU7eD/nhU9jcaFIaMi0lPt8A8teBo1JmkwyLjq8m8nCoq+vTQYadVC2l?=
 =?us-ascii?Q?GSwQoHw8jJOValaOA6rqdSGGMpyRRZStU5rejvsh1m7FMdfpVMKVhQlHTIxK?=
 =?us-ascii?Q?ZDp/QaXjwBWRaXbqHmHdAmmX5BO82jC0NdXb6PnDXWKQ/WkEP8Yl7ySHE906?=
 =?us-ascii?Q?MEY0WIOYOiA7UNZM4qqGf3dT426KGDZb9t96mKGbiWl6OHAo4rgsZIdD7CoE?=
 =?us-ascii?Q?khRX3pxOAcQUNb8hfejy2sOMDLiIamMeciLwCG8rCcqihh/5xbci38m2iJaF?=
 =?us-ascii?Q?X62JsD3nrkYvqNQVJlepDQeIRL3fh4xHgroB4B+AoRL05pDg5GVLEsx3SVPg?=
 =?us-ascii?Q?03Pi7cHniig0eO6TqaUnwQf97tbO+mFDp+LaJXVeF6K+wHdBthGA4NnadYfN?=
 =?us-ascii?Q?52JiI06vEo6d1Zx1v848XF3brzCOmuxVjBrAFqMahgtCwVonIm6uXRdLXBGB?=
 =?us-ascii?Q?L6qIwNSARdO5X89Mxu9TBMZ31oVVg6X6+nB3l0gUOpclsMdt22h6TieSTpDP?=
 =?us-ascii?Q?t8jK2V4WUYblFxyU/0AeNHvZU6EcPVsLQrRwbi7ObCRZfNRe9bQ+ch/2d+ns?=
 =?us-ascii?Q?yyTZ3U21HNXfxYFrvAXKAnhq92m8WriVfQR1PjQ9KlqUozkEaQ2hJ2PF5pdU?=
 =?us-ascii?Q?YKDpvpZ/HphfL9pRmG4zs0NttEPz9UyauW/5I6Vlj4vJj4bBOnEmzfq0Yl3m?=
 =?us-ascii?Q?/6UiMqe9bbzfCoA7U4jezVgrgfAiH4FgEmjEO0DkFwAq7VBogaEtZgMYM3hy?=
 =?us-ascii?Q?KgmcLTzxdutJnrIqhIZ1eQ2I9f4Y1Go5VYyXEA+l17m0bI/SfNGeOgv1UVRn?=
 =?us-ascii?Q?QAs0vuhUrp0gT8ZI9S7YoW36SuYajRybBpyGLXkb2dHrhuIhxJ92R49AIIsI?=
 =?us-ascii?Q?qt51vwAqLZfSZr3ldFFycbDgsthaSgl9rfR70IN9xpcvd2HNnsnWlv4iGEpS?=
 =?us-ascii?Q?j9/KVxgiOvV+P0fY9PRyf3xtKYGin7S6CCOGmqCVT9Q3fGFpIOLaI/0cEoeM?=
 =?us-ascii?Q?9xqGDNMyvA7gEe+/pVcqcKRIVx5jLbu4ciEtZ5gwg30mRZ7YY9OgL71VgqYy?=
 =?us-ascii?Q?6Y3MGyj5LgWSt9S/VHbj7qTwkL9tBAlx2sjzvXpU0sS/6sDcQUGhG4IGfmKQ?=
 =?us-ascii?Q?ZUlZnOy5s8BBdODwyUca2bhtVTJGZX1UNJxdXdGed2rBwIUE4Iu8Mgd102l/?=
 =?us-ascii?Q?2A0ZqjIn1MzT15DJHQOIEvV4KrcQFmkj36EDWIcbGto6RXCAqWxLIGdkbD38?=
 =?us-ascii?Q?A12+6aM4r1npxDMrPvTQVowaTgJncl11DSjQC6sKyYS9XJf9rWFcVyd9Href?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bbb3d9-1fc0-4fbe-f1fb-08de1d56ae40
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:05:26.1579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeyP4V2iGz1+qfH5RcB7TkKcHpqsZHCw3/WVVDGM4UPc58LAj/NsqXmT9lJoVuSjjBcrnZ4XN8vbihzTjrmAYQuSg1sjgDko3/1p9IX9GYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000
X-Authority-Analysis: v=2.4 cv=OvVCCi/t c=1 sm=1 tr=0 ts=690cd558 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=J7X7g0SFKKtu9_AsvGIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNiBTYWx0ZWRfX4Z1Q6pmBVreU
 uxkh+ExStiWRZIASNZhD3BmVKbC7qfBdprgqEXsgNhguojV1qaOIcgI7OFICAck9oRt9Nz515yw
 5VA0m2S6X8Pnrq071AAFFArcPpJdVltF9nvl3lnLOZULc5cfsatsZ/RvaB1fu75+3QkPACaWFb5
 K4lomTlcQ0IDkDfal9qcdcjIKpF0qzE0VkqtZOuHCtw7sO6AH4/ea9KZpqa8dkBPaTVxh5UR6hA
 0vFDaSubx1gR+Wj53kI24kSL7x1iIpU73RlnjH/a8mFAmB2daL+wlNkVoYFchAqG7HhNgtq/3B7
 t/uKMVWP6pA6nU79bQ/tK6Z4cP0U9Z2lLRrPaJ4OV4hhnuwubY3Av0RUouHgbxcfgsHiFa6MfJy
 3rZrQMwB514HkuujwkSxX17bhSCltA==
X-Proofpoint-GUID: GmG_Ho7AxM-x0i5CFzy9isOuSkEt5LNs
X-Proofpoint-ORIG-GUID: GmG_Ho7AxM-x0i5CFzy9isOuSkEt5LNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Expose ITS_NO by default, as users using Sierra Forest and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

Note: For SRF, version 2 already exposed BHI_CTRL, which would already
mark the CPU as invulnerable to ITS (at least in Linux); however,
expose ITS_NO for completeness.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index afbfe11733..a522805233 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5445,6 +5445,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with ITS_NO",
+                .cache_info = &xeon_srf_cache_info,
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.43.0


