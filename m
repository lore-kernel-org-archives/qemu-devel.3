Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC7FC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xEY-0007eR-2C; Tue, 08 Sep 2026 10:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xET-0007dw-Kw; Tue, 08 Sep 2026 10:55:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3xER-0005tf-TZ; Tue, 08 Sep 2026 10:55:33 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EgWQ73513451; Tue, 8 Sep 2026 07:55:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=2G9+D0pF6kBavKP
 zpXqwZdS6u0heXz1vFCC5x6BnZFs=; b=wdjT3nRozBoN+/799Komb0GVaEtIjol
 YfqGF+63ZBIqHh2GDwUP0hEIbVH/FTjKpazjXlXKr9v1wtMf2hHyb7ZZB2x5bCLK
 cuVqAuXQp/KKo6YDHPuKxWaa/PKDdIQfwZ7RKHlWmRBlMnkmo8Q26u44uP79bFsc
 YTVFlT4uT6C2ore04GkRL6uFvac1SYz1rX87Fc1R4Fn0I4www7I1mz+wv5Rkwx4T
 Mcmc1n6i7waPaDlOJr5IcycAOOApx7VCF0w6HGdHdEuuX9Re6FwdrGOOXaqJ1gXv
 l1jf9mg+yXN4fV7hdXdAMyB4CyNDFtm0tN2gKm+iD2DQgDqvzjYTAWQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020108.outbound.protection.outlook.com [52.101.56.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ewu6x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsoYlLR6L2K7tc7xU3zsYN2SdXsWXHSV5zn8j0Djhb1Jq2aHFNRn3DFeaK9rPtX7ks5PoZ1+0PTF2LSJOP2sJQXOF0hpBuft6cggBW92iOZqwQpmuCi/d9H+AAyaz5jrxqNky90iofnxhZCKVIsiiTipVEVpFJgGxPMD3rr8lJ8YvGDN1LZmQWBRMsacRuvldA54FpgG/BePV4OzmuxbPit7E57FkC5YQY6ym6rYUka0xa8RRmnuScvW379sLKEBA8/0wxFl2xzMnhImqxT9bwK1XkMHqO55jGsdpGouwN+2FlpbuzcYW500W+klRvNvTN960/JrrPf5Ntyqld8RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G9+D0pF6kBavKPzpXqwZdS6u0heXz1vFCC5x6BnZFs=;
 b=e4jrtMFyZLY2NH0VnePKTM6a4JaZOSRDqJBpz6QIsn1Xh+wb/+2bWemTks2hJ3/YSArmk6BoQnSydrZggqnDXxRe9kFH2OYTKCqv3VcFYg63Th3go2BW4/z3EGgjvjsJd94C6lM9bzV9N14FZ0kgGtTZYLUfxV5XqOUJPIliMith9EKo0G5W+dnTvNVrHBg3L/CigMdvWGTHA4umZiu89NxSJAGK5VFsEuyTZjEOZIrk8a0o01dO8Vpie9chPM+utLiE2qEApzEaad/xCH4nIzhXp+CfnBAP5UZdLCYjZoc6DCOs4yaZZizg99sA9cplLha/7w0RGR+O3QEIRJTCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G9+D0pF6kBavKPzpXqwZdS6u0heXz1vFCC5x6BnZFs=;
 b=uwRyFwEkSROrD18zRrTsgmPGldv8VAraFsTl71Kg6NmQ5eB9cPvG/a791lk8JLnsVwf+VyQ0lt9oKcQc0FDL7JHWXIrvA+XO9sML+50HkH30wugOi2N7+ljhI0bZXkw1DysZSErEwZ7YwAal9De1dXECuilQl5l+LqCh/SM+/bBbG6TuGZZqls+rTPmiQlRwHa0YNJMzgTO3ypkewIi9HwHSJX17847ywy1++P7v6Oeu2JDH3E75Zk90fONozwBOZeobA78d6iCtNxZ+gfPxnTpL70Br306JZy207hCPUQTVUDuGSey5PkbfOyHYthyAFf9imaMt+VtSmzlXpA3luA==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 IA3PR02MB11200.namprd02.prod.outlook.com (2603:10b6:208:545::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 14:55:19 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:55:19 +0000
Date: Tue, 8 Sep 2026 15:55:14 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 7/8] vfio-user: implement mig_data read/write socket
 operations
Message-ID: <aqAh0q28kQ8ble2S@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-8-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130833.1437632-8-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To DM4SPRMB0047.namprd02.prod.outlook.com
 (2603:10b6:8:6f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|IA3PR02MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: 7203ead5-b7ba-4806-845e-08df0db93385
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|3023799007|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: +tNVD+WFVthyh3E5mCxyrg1iURFSOI6uw4XJVwN5KgTZNOxUPb2O9F0b1fzdNCB3qWdp282+aKZSWrlSBSrGkx2zMYWlzR+CSvxDOhzuFRgLltRwyWaMv/MDcCEPs7UlikyLnGtKCT26MfdICM20PXTOmEk6Yb2AHq2JBoD+f+eLiJCpLheNRM4Ca7lGvxEM66+swdK19SpR5fYrZWbMGoKtd4Xqin1ebt5VhEpCdsDiUvnhhygZzERqKaMzxvghbIGZh5QypRiZzpgEh0EO/F010VuTrTktFGA0quTneM3JuG/LDjvE41865qarojDWHrcYSfUwokj3EXgkfHxbm10bp7RcxnmacY4IoX4L9cm/ka1Gn+lZEGHgvgzx1K2yeAztXBUIG9CtBrtjm2+oDdkxCvNsL67EuWb4bPEUMLHAcWIn7J3ziigkNU2hiJfbB6KPXU7JJRWHB427AzvCEHmn0YxVejKlsP4MFC/hUwD6BxRA4TXhbIXHs1pwUO4xPQ8wxmXWYu76+sBYd/5eTBRZwzH1u8kysRbEfLZ2qjnzbpnXzx+K6te8yW6X8ScOkmyR63YYvUMlZLQoynbM6Wsh0FdQEDs1IjpJzFd1WJYY4YnTCPUDq5nb7AH/U0jW8zukvtJNyGagfzjWjZLhAj12U9JTu/qOYACYUzo1Jcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kq4PuAZh/7eDt9hzePL2Rqlgbg184mhQicE2mCfwoGlD+07vxm05AypfIoAa?=
 =?us-ascii?Q?/6VahWmlhEQGp9Uz9W5BnS7DuNjrGmdmVfo++CZc/HgUcbBX9rXwyoHKgZ7g?=
 =?us-ascii?Q?IcSMImnTeEYv8DmuiixFc5SQ15AUMrEhEe5dYvwwV1IJ3nFLHnOAiFHi16B7?=
 =?us-ascii?Q?nLfmqMR2d8kU2FdDgcdcCEcdPSZE+f0uNSFuX6Mq/V0LMdSrMVMwDDFeZOKm?=
 =?us-ascii?Q?4LMIreYjBXMfK8tYS7AMVWCu/eGoocSb1JT3KBvWPdn4kfVifBHT0DtbOoT8?=
 =?us-ascii?Q?q1UWIaEJVlSMw8DVGbC6Ljc3xmhuskZwi9dys/cLbFCohVO7E1SEVwYNvHBV?=
 =?us-ascii?Q?y8ZIYIUz7XhbMS+qTFicaDH+hY2vkgTvraBoRlKTZtrFDs6+ajvH0ekAmMIv?=
 =?us-ascii?Q?H9/1x+KWnGAoOcWHRaE481SQTGuVcmqljiN4x92SvvUXQEx5WoZVnBLbTF+0?=
 =?us-ascii?Q?xyv7zyByu1iA1xTTRkFqiRhyVo1Mkr0LT85bRktCBhrtX/SwdPMKSmYv4tkd?=
 =?us-ascii?Q?N09d29cug1mJJGJDCcVwhdQ1Jebn8A+NaX0E3JIOmMy4HKOcxHL8rvHz6mBT?=
 =?us-ascii?Q?JmKu0KqR05xyqZQ92YiiLwuqXFLd00vl04I1r7RfHtF11x3zoj0Vk+gk4GB8?=
 =?us-ascii?Q?Jc8BPVF3IuA+n/psBFpMy3dsxv/R3WKwGwKCPNKDk9oBleWyEYKSC2OmU7i5?=
 =?us-ascii?Q?23T4rBpiHqW/7tseRETE+OdBOI1HjcMSYkrJMK0wecvlaN1Pdb4HXvqHLKZh?=
 =?us-ascii?Q?Ei1mfbXu9rFtXAQkslVN1wt2qXRBj3ZQ5h5S5bJfM1ARtnX+ys0S0r41IBL4?=
 =?us-ascii?Q?VykytOwQGJi4WFvP/3Dwn+gEfbIVEKHp/UMA4/Iqjg5sjvhcWqxEPCVtZB1s?=
 =?us-ascii?Q?oNeH2JlQFeeG2jPiV54vZOBEi6JUVq3fWUb8YLMrDLSrgygBCc2pyZhGYQ0O?=
 =?us-ascii?Q?GQKjfDlddo9cus9KyKQVeZWLkrO4i0I/861u4nNsCGm9UEIoPxm1rWwLIpQf?=
 =?us-ascii?Q?SIb54qkwNn6ac4MSZ5xq4bMHkvvGWQLZyl2TjkUoIYCMCLEQFssFhsJ0PnG9?=
 =?us-ascii?Q?LwWwWQk7SLaOmBU7IvTpDhBCMtpYaDYTLpED0PDYYU2/MQ8FPTaGb07N0Yin?=
 =?us-ascii?Q?WrREELzYU2VjTu8k6o0SyFORuPW22ir42hYZRoh6rcBR/ZZW466dDSpcPbUQ?=
 =?us-ascii?Q?hVFcKbRUHCbkit3V9guNkL7Gs15+9uaRgJe/Xz+Hm3+5RPJOoi9W/M2fgWND?=
 =?us-ascii?Q?YS50e34sJmrDW/In9bS4+IatVmPzdCBCXrVgPj/dBSVHJ3cyozNb2Rgb4BSK?=
 =?us-ascii?Q?9qyf7fT9MFF4ddjqLE0pomRj4VRZThnQqvfpv4mPNicGFzwwgFae22wscMSL?=
 =?us-ascii?Q?LIDUI3MBrbMRwm7pYdPLFavad4XzYnC5ov83os+WA9glEXA3DhMyBQDUaYWz?=
 =?us-ascii?Q?2oInYa+kqtwf1VXMAoVW2iUi4qHb75BrTA9kHNAPipfY7FwxQ5rJ85sYqdh1?=
 =?us-ascii?Q?okM07N0/M2dNchLrePjTQidWyF2X4xVcv3R6d/trJN5Q5W9Mi5k9hg8bxHSC?=
 =?us-ascii?Q?Cgq8lB0hE2ZWM9QaN6iatMZVbyInUYnWVp1wUPAPzvbhjmjYYDs7W/hLYi7w?=
 =?us-ascii?Q?nE0glJ+T7GtxAsUeMKZ2TUjJwTXHkZYZAXKQgK47fNHKCYqohl67ZhM8Pzbx?=
 =?us-ascii?Q?19jTk7VHZ5A3whn5YG+oZ6pvaLehuS+QBFWDwfku4BNj9qsYBRK7F8a8p/uy?=
 =?us-ascii?Q?XHdq2vhrFw=3D=3D?=
X-Exchange-RoutingPolicyChecked: CblI+ZAithQ2fuLIYC+iBwYWqnR/9VJSQmW0Qz/b8vyEVYETo5Xn5p2nju5ova/UxjKRGO7cWem6VRlprSPZy53eMjUSmijhs+HCYtLY4yppQR6TmfHfo9bzHYGhs7f++Xhp9k2RYI39PANoTfvY1DLAw0BxUBLbvezDJ28g7zu+9XNnl81j+xDtxD4vXU9VrwFbahZ74l7oqog4cmrBGFBIXC7XB5G33Maq7ZZ0Wpo8uAOrG5LBboTREU7Zzcxn/6ZgB2YZHjCORnLgNfuAWvQjHxGdyhqrETaUtqbHzqDr/3TJZChiZqMD5FtdwfF5tFdeDdghoU2Waabh7abQpA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7203ead5-b7ba-4806-845e-08df0db93385
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0047.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:55:19.5870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny4wYSKMG7sJOP0h7difagUtXLJq5IIUBAWO6sFK/Z1L3rleM6dQVh7f2I9dSl1bK6aZ5LLQrk1mMI63IAIyOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfX57XSp0M1ARSj
 tpfi/v9ApbXtNXhT71tkr53kOr1NOMD3rTbjELxcoYevEpzrR3mOcpiVwmicwcaNrp20q8QCRn/
 cdt2WxbWkL/8uMsr97nanJasBu+wn/bHrk34PTvUFT5VUAtxdxmg+Abdda8r7CjV7hIOsWWvJ3X
 xBzII1o2Ajsybw9PBHX9ClOU/WD1ad0IHpeG6Zyep5+vilwTg44JOZSBMBv2bNpgJ8CoXVaq0uI
 DRmpZGXKZB7phRvfEG8oTH3/9WKry3ZrfLS423OML8S4FOzHfJitykptXBs8m/dWWJD0B5s2iHz
 gybEeS1xnA0jnDk/EnDYpE8K4zZvRln4aNjkCxhiLVCV4K6de1Gek/beZLijPxc90l9yZ+psa08
 dIaKlbuK7womMnQ9PbbGAtvXST0LdQzHy9LaCE+tYHw9QbU4hpoO5rFHYfLa/hTBeAKCHUQJlr2
 iRdTCfkClyZLCUe5Ahw==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa021de cx=c_pps
 a=BYyRvCY9Lsi29fIAjJxbIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=xWvuJDCIwCrgvhbMgKgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bm4t8gVc3FgWt7ykiZ2mAHc7wSLrQbWz
X-Proofpoint-GUID: bm4t8gVc3FgWt7ykiZ2mAHc7wSLrQbWz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfXwjJ/e5BvJgtv
 jqy2HoN9/giijssdSwm+1Gnkb+e02xgu9Z8nktZD9jNL51YSwlqvy0rsT6isD2nf+ezSqoqlGxn
 Uk+jsYAEODTLi1yMJRl0MkP+YmNuTp0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Thu, Sep 03, 2026 at 02:08:51PM +0100, Hugo Komatsu wrote:

> Implement the remaining vfio-user (socket) migration io_ops:
> device_reset, get_precopy_info, mig_data_read, and
> mig_data_write_from_file.
> 
> Add the wire definitions (command numbers and message layouts) to
> hw/vfio-user/protocol.h, mirroring the kernel structs so feature blobs
> can be copied straight onto the wire.

Reviewed-by: John Levon <john.levon@nutanix.com>

