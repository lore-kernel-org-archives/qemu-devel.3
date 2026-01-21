Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0405EC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWBb-0005cv-Ek; Wed, 21 Jan 2026 06:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWBR-0005XI-B9
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:15:41 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWBP-00049m-MR
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:15:33 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60LBE7hr465699; Wed, 21 Jan 2026 03:15:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=hMg0csJaEL9e0/5
 hdOPNqjl6PlNa97xXwJqBtsXX6NM=; b=gJpHzcLUSvwzff98/KOUhQUUdADWvpQ
 jXIDI6hAfPd6U0xYtgRAEB5V8kzq3nV8NC4JyjrKgGO1mMJYrhZqcvSEdQh/A9ih
 p5mHFURz/NBqXqxxwSmmbWUXWrHKdxMKMIe4plPtxvcP8zc5KSSjZnFyPPBTSmHB
 O2gMu2h+SYBAex8a9Rs8NH73zgfRFQ0dI2S8mpT/xo8tyEZ3WYPlLXX90Ab3k2iq
 FdeXkJdMO/spInmxCBhjv5FCQXIBi8GFzrdyXJ3o39GqJnwmlJ6bSp5tuN7dMTCE
 CP64/bW15ZUsQX5jJzHYoN9Nj3dMoQ42UgnIYSPf2T0Pz/wOriDST3A==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020128.outbound.protection.outlook.com
 [52.101.193.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4btde6aepc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCBPwYGY+XIlAB086x8Dw+tnbQNN9FZAJA5IIxMjfMgVqHx9Y4x1Twxyb9q8vJcb9bwU09BqqUAtreKeCt7lXuN85BI7r1RMrF21i07zgMXEvXzYsJ1E+CU5xhyTs2gGnP81YE9pOAngpaSaGsWZ9GBNg1dLdtzUkE6Y7q2K1XIFt6CL3yK70QyVc6KzAPwEo/tXRbMGkbxsQkcnbFOqK1U08iPWsf7/Ml7sdJFlzdS8OapjauqNPeHtpujaPCifBz5yMw6iqFtsC3ZiUabzRq3OaGGA6+XvOHeocMEHSTsoS3U8dyvxJZMSX5BDbg8TDtC5hDfV3HU9OtKYtvrHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMg0csJaEL9e0/5hdOPNqjl6PlNa97xXwJqBtsXX6NM=;
 b=oD2tuqQ+DzxhoSQ9U14BvcsdLgmVdvnMEUvaxoaQOE63WddV2yGnmY+BatFyV4JxPzcNSIzlCTWb4nFBN3eMn0yRzKf5lC5T0pmDmyuVMf6eHaUoen/aRcnMk8owFGEp1rh1HWFaMPaWvJUgXEmNA0EjWEbfuy6ovqYB6DPvjBX7uZeDU8yaeanM8O+6QwrxpNTO8ejDH6YDDtqn99B8hJx3YFdLJemqO9BoN+TUiznr5nbjWBoK5o55XBSRbRmxoy32dNd7JFrqHRr0uRi/iqfD81/a69j3HZP9KWtD3r6VFFHZYyTp+fUtOsXs2oPXHYh7ncLYl4x7X4At2RXKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMg0csJaEL9e0/5hdOPNqjl6PlNa97xXwJqBtsXX6NM=;
 b=JgGdtusx64jlASNcd2/f7FEsccZ0fpRhmbxRVmHsv4q6CXTBmnV7BAOuQE4OXUOrCnGFrP0x5wCPp+Ahfns4CXGDScJBPtut75SdlH4JVnXdpcRHfD8VzHU9x7MmyIHEJjYTkuJ63cMATrnsmaMuUWVvckFrc+lp635s3IfHam60uxdaLrYkt8+YfujRhdZ9dURkkVV1aNfTtp56wXjlauR7D0Almf12eBlMDUyDvzF5/VPhQmXbA7HJ2joseuT1QC4y6AKLmNm3ZGlFkvlSvJpxSvETFX/mvbbpDDIDr4mQC1t/nWq3g9SOfdUM2Z3rJawSU0T4X8b03aGq2TzVsA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8571.namprd02.prod.outlook.com (2603:10b6:303:15b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:15:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:15:27 +0000
Date: Wed, 21 Jan 2026 11:15:24 +0000
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: clg@redhat.com, thanos.makatos@nutanix.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio-user: update VFIOProxy flag constants to use
 the BIT() macro
Message-ID: <aXC1TOlMApjZljDt@lent>
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
 <20260121110055.2333711-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121110055.2333711-3-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: e6761e8e-b178-4cb5-6b7d-08de58de6151
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFmfRIYCC6tvAXIvTkX9bYDMcaQdCcdlJDTj4P5IvBsihnIOxNkTS4dRAFX1?=
 =?us-ascii?Q?81jgYNgVmQ59rl1X7t7QJZid4R0Bnzv2k0xdza0Zbeum7d6s/I90cwssDVEQ?=
 =?us-ascii?Q?4LS2oiGPY1/RLUQs+1L0GWPSL4/Rb9L6GS5BqN0pF3vpL5MzjbodpYGHFHdY?=
 =?us-ascii?Q?lONDpTlCfCXtCSiyR6yNZ9n+VcQsj2PvZrR/ZmftuxIxvMz6LuIXqTHbNDmy?=
 =?us-ascii?Q?Y/xrJlXLjk6v5BuU4mfIB/5i5kq/qvQYawWyqlbwtSCW5NkI/PsHX4sUzW4V?=
 =?us-ascii?Q?+2C3CgDf6Ipdj7r/7RPdvu9K6VSgBO3GXQdzrvT0t85bk5CDdXY+uh8/jjNc?=
 =?us-ascii?Q?NEyf3gmO2Kp+IR6nxM4py1iX8SQPtPyaZ+YmN44G0YgroDB49z0FcF2fz7nz?=
 =?us-ascii?Q?6SRZnTLLELIARCeD4X5agCONocZ8qRm03hukaFxaMANcTa/4P8+kmp6Ce1cb?=
 =?us-ascii?Q?ZKYi9JNopn1xPMYp5HThkM30Gyi8S7GtyiGR5Bj6Jms12U8gpB+e6M+Ffmvm?=
 =?us-ascii?Q?eZeM1SGt6c5SktYvIna2mdLg2afCrt1cT+h5oOz9WJdef/86pjdsMyHDzOxk?=
 =?us-ascii?Q?W2SBT+88JxP0kA+wQv842gh5z6xNHUFfhByUXfvQ5+bx/+j2n9rnvkcgQUq8?=
 =?us-ascii?Q?TciD6ZFIFHE4o8g9dTZ8ybDJX3n7N5g7mSm8yy0TuALZ4PLzyGM0XCFpbtxe?=
 =?us-ascii?Q?58X4Es9XhAqs8RNKEtvOSZak/MUHm+5zM8Mx1x6RUivtARfrqX6O77R64yQS?=
 =?us-ascii?Q?O34vTwJifmNP6DMbh+d8HntB22Gj13o+lm2POkbZqe6qSVEsqtqxxKEZeHFF?=
 =?us-ascii?Q?d2XXaQexmcO4uoNnoa4Q7RVSrubmSlKWPnvYUE3mZPUvfVhbsEMmcym9r99U?=
 =?us-ascii?Q?WstE6J1SD35sXex8+mWiGz10/i9RIAKLvDSxP+9Z8WftYwVuaK7rFpCtftoM?=
 =?us-ascii?Q?sfP8Q7c+0uQ6Sm+qpcRognJTifIWeMu0pkNlirWmqgXDn8UpHbJM5iAQZ0D4?=
 =?us-ascii?Q?kd8KasJQajPG+RPGgJ6dPcNmbVARu7wTVEuDXb0YmoClOmHc4wd5Wa9n5JpV?=
 =?us-ascii?Q?wwfbD1xjN1hOSLzKbzrijN3SvRr9fVQslAIpF6rCgUThDiVEpQqoEY1D4Bu7?=
 =?us-ascii?Q?gZCZjXlCZyTZ8TaoNgf4Yaf8fxwz3Ld8HZPBPhk2FMufJNTIwCGJM4LZbOgs?=
 =?us-ascii?Q?Mqa+5ui3RH6YnKe69OyV/NMcatJipDyroXfFXLbOOPghbNvYmyZQwk4Dwp6K?=
 =?us-ascii?Q?WMyCYkTLoIezoAWOu9anF03mFcXgQIwQDmXBGAgBcY9GHG1JEsflpwOwSVRC?=
 =?us-ascii?Q?0FsrZItyIlOWRzl9O56IGQiEf52feBf25XGoR2USoWwxeKaY8ZIcrPOlQ/Ex?=
 =?us-ascii?Q?t1UP7qt3BxylangYNTaeld/jH8ur1DXyN7fF8cosARxiJ3x2IesQcwdjNvKs?=
 =?us-ascii?Q?KYf7+Acu4FB6MZsvJEgkMBvrDje45GLcJ8hptcbfN0SiRVfffgV4gv9+VU+W?=
 =?us-ascii?Q?p1GYsq43oIfsCTAE2gV5LviOCTqj3QHM45IpMJaAhBgOFw2YR6WeBtvjpOMf?=
 =?us-ascii?Q?MQ0jmhFrxWxsO+86byI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bzsisw2gg2LJgX5lbWo0ymrLhrw8dzcDP/F2c1SrqC6Y6W4/dA7FMdpYytmo?=
 =?us-ascii?Q?vkUGbGHuJuqzdwWmcbozWoX2ObUnrcMeIiNb2OJsrvNBXYb23Im1A3HG/v66?=
 =?us-ascii?Q?GpRSPGiMxH5xq0Jv+h458d+YneN2x/RA1Qcc/qQLXMn0/Tvytk3YI//XOhLp?=
 =?us-ascii?Q?Z9nUSngbzl07MIBX+5Hi4kiAqkcOZnywkI2mP1aA3rRg4NcaIMNNn7bkw6Yk?=
 =?us-ascii?Q?QtFfLxtThfC+uOyowBCyT66QjCZgYxJOAEa7hgdr6wIDpyemHTgDabCGqoGD?=
 =?us-ascii?Q?ikoQU9unjOY+tUUMiGXnpY5HVzoGFPclzNQvFJI+WSsKgtNCm7pCwdwC+uEh?=
 =?us-ascii?Q?7WiidscP44v6cBXsv7EwMRWsNbVr6vMczDvaAUJOEBSXkJaYzn8IIYyoouTy?=
 =?us-ascii?Q?Foe35YpIm1F5K0MNNx/g0oXEKOpfcBjWWDdUUjaYEIgp32TpjRBOT+I/1hp9?=
 =?us-ascii?Q?vLJaiMkgENRL3eiaLpb1UfCU0OcEtBGZE5o5goDu14TkAzi1UNgE/3Llmm6b?=
 =?us-ascii?Q?UdGdsKyPs6HG59ygo+OW4s1p8aXY5izS0XG42LbzCy+4xNer5cj6/zA5H+t/?=
 =?us-ascii?Q?yXDkWejqVZ6TE8cE3GdEyOxNRS8cW1+Rbp6QKW7tHVHcFyRVD8dU5+WmxvRT?=
 =?us-ascii?Q?idYnOni8JkfiXcHxO0+NVxONJ/xlrExqRVpWuwxlTtrfbM6vP6Sy4vRHgH8U?=
 =?us-ascii?Q?awNuk2pOzGc2oTP8zxNeCZT42mN356ERxLhcARLuH/ONmgxGn7Uz8QSsdv7V?=
 =?us-ascii?Q?8XkZiCdi+uewoQIhYinhtQwBpbNMZVGyQzKT+VEuT2n+wbE4zSyvpNLWVued?=
 =?us-ascii?Q?vz+FWV84Be1NMeLMKr3/VPQyYDgBQn5ZmF7MYc/1jWPzb8GpymGYO3us2Isq?=
 =?us-ascii?Q?fmobXJc8l/ML9fhnYZIngYbrad+s1RBPwMAbc1DEm4VZS+1XtabmX8RWkDU/?=
 =?us-ascii?Q?3AimIk/WHhySpHzglehQZN+o2zjpHS6AOtddhH/cFdRQ/w5LgzvrG8ArbzuF?=
 =?us-ascii?Q?wncsdGNMW+BrCwLof3FKIjbvWonxrGf5DYUWua+iFD/STq24JZ2zub5Xy9sS?=
 =?us-ascii?Q?DTX841BJ35aErHd8NCAGuh+BoTzRtb8S9TwJDS46uhf6IdKKCY5mHPo1uBI1?=
 =?us-ascii?Q?U0MDPq9GDPTTitYMzHJ8j0IPrpSlbARxga0B93suzdpq/Uxm7qic5Tc/XIXP?=
 =?us-ascii?Q?++0jaULkbqxPJDahYYDjFuGGbg4d8dTFMKqpeWEOe3bPcPzrZ1qwOzSpPX5E?=
 =?us-ascii?Q?FU6R0RPOmsf8puTY87sCIm9Xx94rvtU8OrgNbo4yEhkjFYy/bV/VbzzquQVs?=
 =?us-ascii?Q?rHGWGZerE2wNT1s3vYoYXotCVOqfLLS3ti22w/TSveKcY9QeGq2lvFT1u8Y6?=
 =?us-ascii?Q?+p2vW/8THgWW8HqcA86Fi+agGgN2sUrsb+gOe9PIo5OAFBfgC+uCfxSHrJBr?=
 =?us-ascii?Q?Vk4LoU5Lrqhg/Sv+j6B5JS3dcNdCKWLoVHVKqaxunvsce2tZdGqYtRgEc01d?=
 =?us-ascii?Q?tUWFwZDJK/tVgFzgkC5VfQSNnFcz+jIwSEkhPmBZFl/ruFaJZNfCbaYUrmwB?=
 =?us-ascii?Q?03O5+q09BcUob2PnUk0Q2bFU+HafO6KahHOoA7tKXkn0rART6vlB3lTJEBfE?=
 =?us-ascii?Q?9LeRfCdNxc0mTZzNYZkQ02Fvkdi92iFMjgpMapRw2YyY61G+P9mpLSKu+QjU?=
 =?us-ascii?Q?6P3draxkS2cW8I4GqxWcbiNbrylyX/kllIPE1x/nCzCfaZcl8qzE6e4eZRCO?=
 =?us-ascii?Q?LC0jX1VQNw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6761e8e-b178-4cb5-6b7d-08de58de6151
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:15:27.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ6dIdoFyUTzcZhd6K95DMIrfw8PN2cpHyDXfn9ZUokSFgDpcW69gtTI1yKPdywuPPgd7+opdW+DUeNxhUyHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8571
X-Proofpoint-GUID: xFVrA9WB0-frJg7WlUVnONbW1UvpLhIl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NCBTYWx0ZWRfX7wbAqGF6NTwr
 c7qao2WrXyg4UUKmrK/fzvq4FY0otSo+wJwljWdLSMGr9zgH48hVQ9dVrcGKqHffC6n8GVGDf3K
 x+UPbZJcWXvh7FA8XovLKbGGUS+qnSsmJYhWUKjWzKWdZ27H5hMH9IYBXuouQoLmdCQRratENX+
 ZOnAMj7kVx1zIbXdessQiz26tryrduuS+Hdbkm+UkOWeHegE9TDs8V6pn5K9MLhKZz0tWESc/h1
 zmkCyDaQTEg2L/wcrd9fB+D8pl8GpSjxKozQPkvAM5qyb47u6D7OIIu0IODgw0RSyu6OTWewkMX
 IXxr9mUbrgbbnCy9VEIUIbz1+xklkfN639fr75chRDJbf8OzVbGZ5F3NSCtgJsQ5zIOkOwtGRN5
 rnwU/rFacTLyEhP/OkyPkuqljZAOv+Dzp/uOz22LaGFwX1PY4rxuyTvsPwzSdznhKENCkQIf/FE
 2h2NjaYVs3dqxesLPVw==
X-Authority-Analysis: v=2.4 cv=bJ4b4f+Z c=1 sm=1 tr=0 ts=6970b551 cx=c_pps
 a=b6gE1lhLBDvdjrMy7UbAIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=-52Yz-3lBU6Bx9nO_DYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: xFVrA9WB0-frJg7WlUVnONbW1UvpLhIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 21, 2026 at 10:59:46AM +0000, Mark Cave-Ayland wrote:

> This should help avoid incorrect constant values being used in future. At
> the same time we can remove the gap left for BIT(1) which was originally
> intended for the VFIO_PROXY_NO_MMAP feature which was removed from later
> versions of the vfio-user series.
> 
> Suggested-by: John Levon <john.levon@nutanix.com>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/proxy.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index b09fd886f1..7b97460cc5 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -91,10 +91,10 @@ typedef struct VFIOUserProxy {
>  } VFIOUserProxy;
>  
>  /* VFIOProxy flags */
> -#define VFIO_PROXY_CLIENT        0x1
> -#define VFIO_PROXY_FORCE_QUEUED  0x4
> -#define VFIO_PROXY_NO_POST       0x8
> -#define VFIO_PROXY_USE_MULTI     0x10
> +#define VFIO_PROXY_CLIENT        BIT(0)
> +#define VFIO_PROXY_FORCE_QUEUED  BIT(1)
> +#define VFIO_PROXY_NO_POST       BIT(2)
> +#define VFIO_PROXY_USE_MULTI     BIT(3)
>  
>  /* coalescing high and low water marks for VFIOProxy num_outgoing */
>  #define VFIO_USER_OUT_HIGH       1024

Reviewed-by: John Levon <john.levon@nutanix.com>

thanks
john

