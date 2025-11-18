Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AC3CEE345
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLPjy-0005KO-6I; Tue, 18 Nov 2025 12:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLPju-0005B5-Bn
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:43:39 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLPjs-0002sj-GL
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:43:38 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AID0WCR1915545; Tue, 18 Nov 2025 09:43:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=v9cQ776NRJDQNWbal2IvVIl5VnucLBaHpxXTSB11N
 Z8=; b=oAqe/8NCnpGFm237mNIc+MQocgX4SB9L0v2G9BYXW+Ns/mkRUqvvMEuUh
 7InkmORRJdTBbioOyqJ1KbonOUAvV68/6daPAuNmc8eAxPOVJhdI8TA1ZLsc1gWF
 2h//GgGeM65Dwj+W5hP2AV//KRpxTc8Rj0cDVNXViKahyhuzlAEF2DxY2xLv6UAW
 YFJ7igxBMvqYzvi1oef5TwGM6vsnHlHGgk+b0EggTs8NHpRC/u6tjBgn2cFnfe2B
 IVGS3HpVnB5gjYGcGpKhS9OtiXP3tmyaPPTBPOtqiUDFj5yu+X/7CXyE2rQv2aV4
 QWLJi9vGniDkw1abJuKv6alxu8UdA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020117.outbound.protection.outlook.com [52.101.46.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4agsab8nmk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 09:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKftkjHF1hrdotfulEfXDFhtIp2tBTnDJYy+aZljBMht2qX20JCQumwUgOFwHPK259p36cA6eBOe3D8Is5HjJgFNxzx1hyPm30cVsFvuLjXQETFqhywI6CdhTgVdAn3ptb2HMhAIoaXss4eAWcPeAQYqYiqaNmjaBVrrPDdTFIyC1oy6trzgeRs0dMmxs1oproTOXHEkEV6qvIeRdaXuHC8NfduQm5GhLrZxJpOEtkAMHvQ4/mOp3NneH0sGp78KfWsxbrurI7Bc8L0SVx8UoGbOwdlXlbGovaym7wDoOoO/4mqbxXJk4Yi83p3Uk3KGJ/dTyRKk+3G6yeyeEUK3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uh4axYBIrjpUSLOhZG6oRXyD/gxNymTOmm43D7Hi3I=;
 b=QXnOD8qUR7iYTrh8Smk//5vfljGn4dmv1yajFSq68QHxYpvP58/WQ4tIKuDom+xLR00Bhz7rqVkxJi7jCYjj62nm5ouBBJjyg8Ql8StJuqJM9B6TiWzi/4KKQk5y4GEEk1Ek/1rD5IsyohmDbWGUHvg4HNYI06sl5yXxg0X+e8Uzz0b8Q5fWjWQaJKKV8NVLve9JLXg808zQ+8c+UZSr47AX/GYHs8DG6si7nagPm8tlR3nQlTDWSRt2EUAtyDYZcNZuedc1Fn6LOs/NIEHUlETnmygPP2aWhmqqIhm7sjdMagfjUWvEUoDRIp2yDCyVqbBMpigc2LI6Nb6PIUs7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uh4axYBIrjpUSLOhZG6oRXyD/gxNymTOmm43D7Hi3I=;
 b=HhZ9c0nccfXMU0haOAqFf06YpMZteU0u+l/31AjdGM3MRJXaawBWb5LkPxsqZU/tNHLFE7UTfTYkHr6LH0gjXwM29RdNLNDyBAITpL/RzAvNMQVMmJ3YTeVC5F6jLV6ozVN8rf1P9QoN4sut7bcRTi6QlUjiG6qnMFYr24114C6xlh/j0VBpgGnlu+DkJYapjF7h9EhRv7dvmhTMArdPMa3TCOenrXIT4ijg4sArrZGwZd8OVWa2cy3MvqI3xti6mMkIzSVIilE/oZqsQSGpCKS7rm699i1ddZDE2NeVIDk6xJgVRJaLDiK9c5hMIt9GBDA+E+/G8UNUi7PRny9R5g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB9415.namprd02.prod.outlook.com (2603:10b6:a03:4c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 17:43:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 17:43:25 +0000
Date: Tue, 18 Nov 2025 23:13:22 +0530
From: John Levon <john.levon@nutanix.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/5] vfio-user: recycle msg on failure
Message-ID: <aRywOoqdbN6lP4mj@lent>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-6-john.levon@nutanix.com>
 <aRtGN_Ji-HJDcXAC@lent>
 <4c7c7be5-b1d1-49a8-9a46-89084adefbc2@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7c7be5-b1d1-49a8-9a46-89084adefbc2@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a6edd3-6352-4c86-8e81-08de26c9f9c5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ft8LhkGT2BECAi7n1MiJB4yIpudbXApQuvrK1pe/WEHMqN8yKiHv3wuZLp?=
 =?iso-8859-1?Q?88YtN7sgM3423u/tWlaLybGG8U/E1Q1rTJL4UVvhkj0BmWSmBUNcqHPkYM?=
 =?iso-8859-1?Q?Z3sh8oNAIivpX2iJ1w2AWPoPGsZNmZVSWNxOq/kYMunDsJJ9aw1MjiCXtH?=
 =?iso-8859-1?Q?SqzRVIV42VxLrCXT7SvKryYqUY5HdGKLmE+PP0QfbZn0HQ8jjPAd5BfT9s?=
 =?iso-8859-1?Q?X6xejMNyP1TzeARJrFnxqMFdGAS2DA5A3Y+LLG+DfP2+er+9P2XRs4a1M3?=
 =?iso-8859-1?Q?3o/S+kQC/gkCGy6zk6GSGxL8zXPXpVrSGp0t74Y1Vcy+OULmdUDKFVNc1+?=
 =?iso-8859-1?Q?mlGtCMpGqms8ORjWYk9SoPXB2YBtxe5X1SljEaPaVEDuIkaalHHi/zR0Nv?=
 =?iso-8859-1?Q?dW2mNadX64RqkgFUWL8qgwjQ+Mmf813h6duDKhiysamd2CcN67WbxdwZuX?=
 =?iso-8859-1?Q?P2N8jdYLthv1UzPIqiYaNZrXYvpBGWEC3vnbWlfm1dQHAJhL/TrjxQoIHz?=
 =?iso-8859-1?Q?NIi3NoyUlRNe4EQ2xarjzKjNjKJBO+/d8FkFRSk5NZyvXmY8ERXgo+hwln?=
 =?iso-8859-1?Q?wYvZBkcHoX3pSagNAGT207V15zuOFT1LLWm0Z13aZ85D9vbWFPzsOU9dMf?=
 =?iso-8859-1?Q?LCg0PDdjlNYqpscYg9I1UR3xwO82AzvjI4fCuXrDVcD4Er/6dhoOMpJ0jo?=
 =?iso-8859-1?Q?1IyjWPj7fDV3MT0Met/Qs8254iPHnsDcZef9HrlBv2fd0zmwNjdXT8udFH?=
 =?iso-8859-1?Q?ElOiV43edBbDPej2MSxNjPj70eN5aHmBhlXDYYiJgyDnGv1VCqWeiGOdbG?=
 =?iso-8859-1?Q?ZbP9nkbxlOiyYM5ls18C4bRGmkExq77jxtr0K3NtgLQ4CK3tkuvnNUHJvn?=
 =?iso-8859-1?Q?+/Vl2k1GxOJhu96gYOHTgifAkM4Xim8YLjEpZrZMULc58pimwxe13mG9QT?=
 =?iso-8859-1?Q?M1YzBkvMWgubcU3T6gEneA1nW/A9tLt11YwhuGCgYYF+4gCiD+SJvPxdKT?=
 =?iso-8859-1?Q?U0LoquU/NxmNHRmw+rebBMXxQXkGjWV8If9AlbuyzYuiSHdVIcn2oZJJaA?=
 =?iso-8859-1?Q?FM0HlUnP5hvt9jAc5RHBIqnRCp+g+kiujZugB/laCSvDSqIDoUE2/Gd0eo?=
 =?iso-8859-1?Q?ewpR1HOUDkwnmFhjIKiWpYfOl4JxokAPlvIQoO2w3noHuEs5OtjWS4TsFN?=
 =?iso-8859-1?Q?i96jYakSAPnlI8cIXowLtFBxE8NZ6eNnujmJZXikKnXj0TacCMc/1I8LDp?=
 =?iso-8859-1?Q?UrZsOVuansOLtQg+xcMnLPXvvyTnJNy+il1kOErakuIQ42IUHG0GwVCaSr?=
 =?iso-8859-1?Q?0xqIMRM1xZWQkhF7mjRYP410uKIYjnWSfCXSNYosAYu7jNaBiYR4vAp/oi?=
 =?iso-8859-1?Q?DYuray+sSW0vj1suI/lSnmtiqcowVZfs2962kXtpSj+CAz7j68N4PVK+kV?=
 =?iso-8859-1?Q?dv4poiKOJwE7kQcUT8YDUWkpJGs2EvnKQJ1LXFzhdxDRk7gFDsZJ00TNZY?=
 =?iso-8859-1?Q?esJt9QbnElHYNnBc1rnafv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?54GEqcx8BZiJWjRiVISdQOmYmoojr+imVG8T7InAwyuNa9k6G+6D6chaES?=
 =?iso-8859-1?Q?PUT7iz33GJXYVws3n/l7HTckCHTsilJGYil5/4K2cqzDyOFF4XbTPo8tse?=
 =?iso-8859-1?Q?8YjHH72wBQZ6v9TfJvbS0pIeHXJ8adw1bVOBw0G6CJ50mFIbt+8eXBLZ/j?=
 =?iso-8859-1?Q?Uibzk78t9d9tWmGUbXfOF8olUeI/hrzHRgWGOo7uOvd68RFDMcJJR+j++b?=
 =?iso-8859-1?Q?qtPYXuGpOWhKh5J3ivTbC+DEImSekYcb4zWpASrko/MpZZ6NXT9Q4YN+TR?=
 =?iso-8859-1?Q?6GY925UWs7tEUE6wnWtCT6ptM0bDf5zvXSbvQkMwaazDMnkgtFN3w9r5yY?=
 =?iso-8859-1?Q?ADfSgKxS/Cv11gRBv3sWxB7NqD2ldaGfg0xTp3/RjaiL7vx3YRQTXl51CG?=
 =?iso-8859-1?Q?2HPVffzUL5Cp6ksGt9rRW9Fj2Vu4QWd1wa00k/DtiL01NLJInqONfFTjwQ?=
 =?iso-8859-1?Q?8MM52C9JQ7WP+QSNLOrQdBxACWMNGglqu3ucqcBN1iiOf56AUR7ZUlZWhA?=
 =?iso-8859-1?Q?fR1Kgzm64hykUeyUebDuFSi6treUCetQjnN8wDEd192PYLEOconipyBPpQ?=
 =?iso-8859-1?Q?X28Yz3F7YI+vukze7TpJG03JWiTKz8Q3IjWZh+QRKgMFLxflqqPhAIJnK0?=
 =?iso-8859-1?Q?v7b82/PrSzzDYeA8HWTaaIZVzPJfqQgMiuIHNzVyc1rSosGAl5j1NjMLLs?=
 =?iso-8859-1?Q?L6gADQWuZ2u4gnQ+cFHsrcxUGX47eP0YoniyB1VxucZQO9s5Y9jW8p/nxY?=
 =?iso-8859-1?Q?/tNVFDxVJw8wMSv5DZGeEgQpXc5ZdXedBbR1L9SfnBAf2TQCzCgYQ6lhdg?=
 =?iso-8859-1?Q?abWGYb/QYWGNr5d25IwyFoP7tW+zhaixzg8hHcppUYN+ksPZPl4sUHpw2X?=
 =?iso-8859-1?Q?f/gf1n/u+xtnLeGTvAvi1XZURRb153MOaqiU0z2jsX9JFxNZCq2XtlUSbU?=
 =?iso-8859-1?Q?Z2RLTnZbxNjqSNNxq7uY3i2YTJAqdhBxZ0JyQeBOOUUVgujpd53G+gw5yT?=
 =?iso-8859-1?Q?kf/3lHCJmLUeM1ZhmOFWnni/Ld5P0duQzVeFZXJUjYdcBIRbtssjrS3HHy?=
 =?iso-8859-1?Q?gaGy1Xolzz3QXaPt+bJQAUbv7zlAuNPQ/agZydQPsrIvH9zT2sF38iW7sN?=
 =?iso-8859-1?Q?1EK3wsPBMaNGh8iYFs5CRGKen+AI3YA9B884CeF6v//p4JCM/JtiCLUGsg?=
 =?iso-8859-1?Q?3quj6yg0HtMsVOaCQsYQnRrAggpXyeP6CF90OG0X0FawrnAdWhW2kzt492?=
 =?iso-8859-1?Q?zsBKpWST2zvVbFDBf2SrBfQdMr4PD1JGusoICvcXPr/qUqU9gLwWYe4ql1?=
 =?iso-8859-1?Q?zkA41eBRKSrLSIdWyeor99Sza4XXbid70BFfz+adn/tA/pc2tNDJU7CNrM?=
 =?iso-8859-1?Q?GAbQ85V+uCFlPdqUItQOsROdBtN9kmMkmqCG5wzrjqJpy3Xat8tZ4mCEmL?=
 =?iso-8859-1?Q?A4b1fnjDdjDjjKcBGg+Mpui70SP/9y+hD9K0PQyTNXikrSqIemedJH38BW?=
 =?iso-8859-1?Q?j0evLpbtjOBIUXApor22371z0zNN3eGq05rPOf9ukVkpzaAQlZWH3iS5dZ?=
 =?iso-8859-1?Q?mAR9v53Osn/tbZFyxwnc3dC95SjPZRzEu7h4l070rMHY2LTdkPGhMQHfQv?=
 =?iso-8859-1?Q?evPKhVbRag0dKBKzdRRXcjQUBRoLj0PMJl?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6edd3-6352-4c86-8e81-08de26c9f9c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 17:43:25.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwcOp22C+WOcp+jOmsVMn4KxjwoHFYSIP5Evwqyv0SCD5h2vpLkodPi6vbrFW+ubiLLUYXwofou2CIk9iKEDSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9415
X-Authority-Analysis: v=2.4 cv=S9/UAYsP c=1 sm=1 tr=0 ts=691cb03f cx=c_pps
 a=RrdOQlmmxp+bQeXV/0G7LQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=I4YnnOQuxGNpCDoEsK8A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE0MyBTYWx0ZWRfX/J8N721c12q0
 iRvzFUElpjVJXLC10UNXMqEhHw5+vbOKoStec3N+467HhWME+K0wxeahAgSqMp5qgAKpqk2ooud
 fki5TDPQkKjeoxHRIGJl++t7pL4yagfCjgXYXF665oeo00mYdObdI+eY+6ODEAX6M/3n7oqKsIo
 U1UCTwcJbBFTEvcxtX9i4c1gJvrAbzbu05cOywsMBcsIqkb5cqvNkQOFgM+dyKEw/ABKJfjtvfn
 j3FWPer5rZwJV1iXXtbwQs4OpBVY+j3BOvBPUnrz7QFdevARhnznWUfasUI7iVYSI6euL0vaGxW
 1hSbBPk4mm+CEtYy2Uy5GtVnbdaD1snksu8noRI8WpOSxXS1YIc8ctOZendqKBbUjYD6TP8hFmj
 lSRtoLCDwWdSHatfg2YCmKwZ91qOUw==
X-Proofpoint-ORIG-GUID: pM2wDwJJugitd_l8UZptJEpGaO1LtB-u
X-Proofpoint-GUID: pM2wDwJJugitd_l8UZptJEpGaO1LtB-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Nov 18, 2025 at 04:18:00PM +0100, Philippe Mathieu-Daudé wrote:

> Hi John,
> 
> On 17/11/25 16:58, John Levon wrote:
> > On Mon, Nov 17, 2025 at 09:26:56PM +0530, John Levon wrote:
> > 
> > > If we fail to read an incoming request, recycle the message.
> > > 
> > > Resolves: Coverity CID 1611807
> > > Resolves: Coverity CID 1611808
> > > Signed-off-by: John Levon <john.levon@nutanix.com>
> > 
> > Peter, I did not hear back about a coverity account so was unable to directly
> > test this; could you please help out?
> 
> IIRC you just need to

Thanks - sorry, but not clear how to submit my patch for a scan now

regards
john

