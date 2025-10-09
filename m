Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0E5CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nfq-00022Q-Dd; Thu, 09 Oct 2025 06:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfo-00021Y-7o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:15:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v6nfj-0007i0-5O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:14:59 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5998S3X4413600; Thu, 9 Oct 2025 03:14:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vKGXmFs/I1LYFH+5diugRASHgmHw41P7gseEJWiQz
 uI=; b=cF+F7IEqEY/yYQdSAuphCCnOSq88EVnfG91ZkBPQKhTEBDqdkzSdleLc4
 dBv5RrMTOgHtbPpCcm7I8Y6IarhWDKNRbfNUBxlC+js+yWZnHxqhnDMlPX8BpwbF
 jJt/VoyUtqpFvAt6CveyUgrohOl16xls8v//r1KbLrh2VPd/+lgjTNflA6sfLWC5
 mfhfWqe6VoaAvsV4z8wrBEg18xaWYU5xsEop8n3j/pKkPPGWW7na+s4ZoxWOL9KT
 70NM/8+u29zk7iZ6G/ng/0lOsTIn8Gp8xCGQEJ3oHh8h/gP7sS6/RubB762aj8P2
 i5hvD4XkNmT5J9gu2J0T/V2P6uAKA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022131.outbound.protection.outlook.com [52.101.43.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1qskc8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 03:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ7sHKABHtxdnffvxQt5h2PhwDCmiW/RdcQlN7MXHYfVjgGOIupCQ9JwAFirvryJ70YIv9PTFYMmTt2795/lWDkCFxqu9uTJB8ega9cgsxgTdH9UaclRoMtpL6bJN21Oo8pZDI0sLgTLYkb5JGQCgSABprHDL6mfYNCsPvWiji20MZb7vKFmDIthC3cRpYyA8ngDsmYY8KAjcMpvUZjlZMg0hJesH+e4CKpZcUNvM8DM18V66x/FXTDXtqk100KSRfUEfcn+fGbzwejf7KISUwNEH6BVwNOdu7uas4i7nFwkxkBg/iDuCwapWVeVONWPgRgRxhYoSZeXOIH2A12D+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKGXmFs/I1LYFH+5diugRASHgmHw41P7gseEJWiQzuI=;
 b=LakD242hFArc5zmwU6MAsRAfCcwxjCAiEDfypQLLxZUpVqkGiGsfefinWnfE7rbXmxjdVR1yvhMZPcFgmnch3XvGFITdpe09Pm/wEX8V0ai7Oti+p7dLTifoLNe9+y8Vq5MRXYa+xiEu529nwmgm4Ky2x6SDwxpaptc/gPn8sNbUlNrMk5cjWPXdj8j95oc8iigTfVLqkqg9GYERgsBgW8UrEpi0JQ6epcPW9Zr6LdI0N/ICLsC5u2CX8YsoatmuXYsxt4IP/q86YCwQbBc0tf0phpNV0S5MReNKiYZhZuRpu++V35YebE+Ze7ocIg/LwVnXy9EtKYZbxa2ybbbFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKGXmFs/I1LYFH+5diugRASHgmHw41P7gseEJWiQzuI=;
 b=C6sJfAL8eDOnY20YASvo9Trm5freJ304MdvPmbtcTf405Mlp+EjswSZ3ONWCz1kKcpWxOLQz0jd+ZnDhkt6WCjAqxhweYsXPkrF7iFnY6XGNLHh3yCgGGrJX4UMwwwK68RWdGjIDKmsF4DkKbOGLriFgABJdhk0/LPtM6Yr6kSC9Vfqyp62uYH5rrzpfowhjNcuNvhZKZU0iRyk0BFqUHsXDvK/lRDEA7302A0k2GY4zm2ezURPScIUjLTPjnWEKTHd3E1Qwt6JysHA/NXiNmfDytk9OXFu7srVlcCgN6iRohKYa3UhyuNHAWeQ++pC36KWRNX38Xtg97gxT755gQw==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by MN2PR02MB6973.namprd02.prod.outlook.com (2603:10b6:208:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:14:49 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 10:14:49 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 2/3] io: add a write flag for partial flushing during a
 zerocopy write
Date: Thu,  9 Oct 2025 10:14:17 +0000
Message-ID: <20251009101420.3048487-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251009101420.3048487-1-tejus.gk@nutanix.com>
References: <20251009101420.3048487-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|MN2PR02MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d70454-5ac3-41eb-f640-08de071cadf7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WUVLxK+csn2AMOlflm7XegAE+KWpnXE0c22qGiEtzXycqQDaqTrfVwZpCpMQ?=
 =?us-ascii?Q?GVx9txUc5bZ8ijufE9k+YoarZ+3Cw+uDkeBH3pk0rUh16lVn8mpE24ruLO0s?=
 =?us-ascii?Q?B/zkXGqfyErkQGKzgy7uE2pSOBnSkyNvHkf7v1nAjuPsYG4NvpSsE5fCz5jp?=
 =?us-ascii?Q?+NSxY9/6Y/b+A6luywqPX9DFqGpy+0x5K/KIZeWuJ/rVWTZpI7jjxdrcEbif?=
 =?us-ascii?Q?hNRw+ayJC5ltrGb+LEVRFW2qtK93SuBN9JmzCey4bV2HMcy1TxYkgoHfIisf?=
 =?us-ascii?Q?Qg3WaNroesLH0G+s+3eT00ico17DzLiMk0ofaFNjSp2H69Qt6mX/dgJt6IGI?=
 =?us-ascii?Q?BR13uqzJ2eGUtEnGntFhOFxQy/n75M8p1dNR3uNUc2jlPPa3/LAZLZ7kZCNL?=
 =?us-ascii?Q?mIgJNSHqPeA7lD+m9M6TEU9qlvjiB7iOfhuV1LuiNNkcrjv1RZz0+j3yVgc8?=
 =?us-ascii?Q?DTOXHacRrolGvpTACHrv7dAHVzjn3tDeq2Si7xtalF4SJndkevr3vQjQmSTT?=
 =?us-ascii?Q?lwKPCYfl9+XVfFc6RMvPgdB5MW16hAQegodTaGhZ0zcqU5QgvveV6XqnEBW1?=
 =?us-ascii?Q?jY6GoFOP/0up8ucaan/ch4AC5c8UR+287uDiEtpiXVe+0F+ThbyWsCpBqzBa?=
 =?us-ascii?Q?/KWXMARz+d8zaAenZky4yeGSKomuYXBBmN5mDJWorgzn69+PiP2k5hmoGjxQ?=
 =?us-ascii?Q?WQFuSp4PQbIry+J5Bb+wYoWj0w1jPYTgzVFwPqN+wLQB8GzWAAHCAA4FAhJc?=
 =?us-ascii?Q?kqudMrBkzXtqRIV8fceXQ3kyPL58pWJQJeI45vA8ZcmoHpPEHhf+WEXPrVPm?=
 =?us-ascii?Q?6ZikxWlAARocmXOeVQBdUvO0aqsO/GLYJKz5RtprlR6DBEgPrLH4lH09nFiU?=
 =?us-ascii?Q?jXaHd7lWacHNQwosYVyo1EHkSntbPdi1Y1Tc0/C0G5G2XoHZTcNVosxSWTOn?=
 =?us-ascii?Q?5Hnn4JB2hQQqw3Fa1JoaSGLWfVVWo0wgzallX6xTG/QeAtWd8PrIIHuPw2xn?=
 =?us-ascii?Q?dYMTCAYoneSfMTRNLAnEuEk7O30NT3G5cMnXZmt+Yohfx8YNY2T6vAbt3JN2?=
 =?us-ascii?Q?omToF/B6q69ZvD0FdprE4mzRHIjnzI4YGnNyIvQATRzshhaTw60k4IqfMkow?=
 =?us-ascii?Q?LseauuZPIv4zJa/Fdrdvz7C2mFVHVJJCj97WZq7nRbr6Z7EvJa3Djs+GQq6V?=
 =?us-ascii?Q?K1TtieKBDJ7lChj+9RxrzbB/4KPzfaRDVu8xa+Mf5TYjNErFb2n6Vgy53ISF?=
 =?us-ascii?Q?fuI71Nsbb1a+c7pGExlbV4NwpsdQaSj0Oy0YZ157YXcyYfv6IPz93tztwwur?=
 =?us-ascii?Q?zQFsuDMTdRZpUdb7UP+6L8lkQWiNEP9q/CRCuCARjzROo9qOl+DnlyjKCQ/Z?=
 =?us-ascii?Q?kVbfQG8ThNWXFACx9eEasVzWSIb/iV1cUTOTzio9Ur5+sJUQZD82SN2ZaQit?=
 =?us-ascii?Q?MhJnGY7xcxaTyyiKkSerAkXw2WMMbSgAn7bsiSmJkuNq1tTDNKsh/q9Jca+e?=
 =?us-ascii?Q?vLhdHRNikzNCFQRiNHMxNVzn6FUcgsLGXLS7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VKTUzF388jpdnGT1VjkQh8SkeC4az56eLScrtLPrMeKduSwBuA+SWzuyOfO6?=
 =?us-ascii?Q?y1AR5UODeuxIP1o8DTOgEtIrI6+jhBsCxzzb7Ece0O4frs3MmLM5W/YUEskW?=
 =?us-ascii?Q?t7Pt1zYiNe1aGQSmFWyxHvtK6jke/BtVVMmrtTIyg20nioa4nA3S22Se9RlE?=
 =?us-ascii?Q?9U1rcTMnLML/GppSX56NJ/pyFICpK2hC0/jw5lSuVIXALuBARsMkylT10/2L?=
 =?us-ascii?Q?dvERG56LDKfMpaulMGH2u5lZ7a+Oy/rtzNNHwkZylVG2OuSoR9OrdkY8UdPV?=
 =?us-ascii?Q?rtnoH+j4PvIq2EdhGR+PjhE//TIz2qRcQ8fFe9rbLgR/30cS5qeU5oSZg+uf?=
 =?us-ascii?Q?NgS1NYFVOLVxxY6j0cwbK+fNLx5O9apbEznrRi1td4p+U8fDOnfk6ICaftE5?=
 =?us-ascii?Q?X+iXK/XCYG0b2Kew+066ZZNetZNi7zDRZuiB6q0jbYpDdr8qqUvsdyDNGpmX?=
 =?us-ascii?Q?LFm/wKmeontUDGQQpy2UOiz/CoPk7RHxnRlTfNND/BHxHKgOmUyUSsB3L8Ct?=
 =?us-ascii?Q?qqKehta1IDZwzhIDS7ki4EpkcMQff+tHPVLMNWgIEltXXFBnKAnpmEBF9uP6?=
 =?us-ascii?Q?MogHG4ge2TFugKI6lt0SkdCqz9G0HZIdSGwrK4ZoJlFXa+UFMvMzxhLAPq0X?=
 =?us-ascii?Q?oSaCo8R+xi4c9SC96q7FGAODiDEQ2P/Z9fn/HtmGwuoKpOZlbdZEJRp7K5TP?=
 =?us-ascii?Q?ekZHUih7YpVCBEbTWEKDQz8OAtgqNhNmKt1f3C1filyTnN8xgtOSpcvKr0qE?=
 =?us-ascii?Q?Ckt2KWSVCSV0uWxvY8e31XdlJgwLVw3QWvQGWMFgN6YF0DJoxAD8sezRhbYJ?=
 =?us-ascii?Q?F+Zn93HT7Tmqc9IE4XVZTFXAuBYrWoba0GSu9H9CnRi2rVq5F+ao1ISdbV/t?=
 =?us-ascii?Q?EzhsP9wYFPSooECe9LjvMszRW4TpzVcm5XJ+UfaeR1IN20xIt9qrBI3BAyQc?=
 =?us-ascii?Q?lRnx1SldF764yL5u6jZSSxosic6v3iIpm6AHF+bortcdiepllT+qRMPuPkPX?=
 =?us-ascii?Q?YRMsBW+XngjYKOKfPlOwlrDW+/7XvIhnsLdRwP7PoJpSZ3YnZ9+BsHRxTvlG?=
 =?us-ascii?Q?N7PMB2yEWmFXv31B8gnl+XxAYu1ZIVrsXqf7a9a62ocLukZaV/BsXwQx1dtw?=
 =?us-ascii?Q?eR9rLlw4FzZuM53Hq1J/feUlnBE1ceJGupPTS8qQHKAZGQoJQn3IHMVVTtxH?=
 =?us-ascii?Q?wBnKSU3v3ZHprnn15tZ+F6OfDjrGFyXaGfTImBS8ds/aQI7uA1cObVyDqYYF?=
 =?us-ascii?Q?zz1t+v0FOCH0cgYhQmQX2+BfptN1zmlJV8zmRfioi+LC5gv8LAqmTcUDKBEw?=
 =?us-ascii?Q?079mctNhuCO5k1Um1OHdGKFJ2vaHkr51hFsEur/bhYN6SMPOQQ4KxT1nnfos?=
 =?us-ascii?Q?pv7wPXIqMIl+n/4SQQAe+nYdTmPjwJeawbuApLov8imVeuw21ZAvTVFK0gfJ?=
 =?us-ascii?Q?dMgX5Nhe3f1gWcK0oIxPPHyEZto/+aSUpoL4690g0OXWqWi9VAXjy0jVP3oz?=
 =?us-ascii?Q?MG1n3UFAtyt4zMJD+CSEZbh8MUeoqpJf2A5mhAeoh3zbdA/lKBrk2h3snE1I?=
 =?us-ascii?Q?Sx+egQnet1J/Hs6bdVNo7VN/BJfC6MFqi71+Vdfoo0U7Krs/w7O6n3qTtHXu?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d70454-5ac3-41eb-f640-08de071cadf7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 10:14:49.4160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogtpd7KMU3p1S+8ZmRLBIfvomXBS6b6vNeV484q4r03wUu8V0xCcrWb20jBt/HSEzJ0gS/x0WOryPUlshF+liA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6973
X-Proofpoint-GUID: mslZCmZtVPtQcjYvsK0SeZcaQGvNSg4C
X-Proofpoint-ORIG-GUID: mslZCmZtVPtQcjYvsK0SeZcaQGvNSg4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA1OCBTYWx0ZWRfX0fFneAzzQWWb
 IjYWF/3OJmO3LjQw+AI8ai+3o1UGP/ALsNjO5Wu3EM2cDVJkOrY2zaClUZyD5dVs/tETWd+wOl8
 TUNfYkC3JKLsq/FFcebYbQSbPS3yp1h1nb15Q68VjQ33uc/ANrweAqvIYqTSUQVBR/SP9EXUo9k
 0+tUkzgf93ImdT2ymLmq8eoP0t38nFMRMk/Q+0+6bXLKZFSwMlBW+w4Sq4lteYoah1QbX2dw6G5
 9YepbUNeyO3pRl0c2xOfHxxRRzHWlax095m57GGlys0QWxZBDj09mgayrJrOeO4g3PqzM46jfWB
 Y8VlJKKVMnl6R/sSdmX1z5Su1ZYFt71M1Fyp7YyaqfZLpTO5CLQ4IiMfDv2DUPyDJdF4n51d8p1
 svNXrDjbpOLRp+q8kbypaqTGnznajg==
X-Authority-Analysis: v=2.4 cv=ecswvrEH c=1 sm=1 tr=0 ts=68e78b1b cx=c_pps
 a=WiodiXt0wH02q4ozJLtFAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=8jqYjq4I6fK4l3GpjcQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While doing a sendmsg() on a socket with MSG_ZEROCOPY enabled, one might
encounter an ENOBUFS, due to the socket error queue being full. To get
around this, the caller can pass the QIO_CHANNEL_WRITE_FLAG_ZERO_COPY
flag, which will try partially flushing the socket error queue once, and
retry the sendmsg().

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 0f25ae0069..41b903d104 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -33,6 +33,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 #define QIO_CHANNEL_ERR_BLOCK -2
 
 #define QIO_CHANNEL_WRITE_FLAG_ZERO_COPY 0x1
+#define QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE 0x2
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
 #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
-- 
2.43.7


