Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8796C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 12:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSxFN-0005Cs-Eg; Sat, 21 Jun 2025 08:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSxFL-0005Cf-2z
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 08:22:59 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSxFI-0003I2-Ic
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 08:22:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LAGcOo018081;
 Sat, 21 Jun 2025 05:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iT4K8jF+d73c+dTjOViFeZdGmb4rDsxLNy4ocYUJv
 qA=; b=ctdEJlgwt8KVF0b5aLvCW930ZJauzfHk4eFG2kG2w70jU6folDeGbu3w0
 rdGzcHf7eqKHCzb8mekcgSJGSg+jyAy78kYy8U+mnygsKPmGdWV+9/Awqv1A+waT
 FG5IkH3Imv1YAAmrqjefDIayJ2jZcpaI1V6nUY8YXR1LLC8Rj1T+ZDI8hws+wF17
 xPWGxdQInmFavqSRGrwPdzyh1ogRibwdx1vyhz70bsbZxY9/Bi9FEevoF1RlT7T3
 RWkcIJAZLtEL90qvi/9ItTCnd0veXpy9LOe45ae2iwIWXHS3hC7v1b3UJMBGoywi
 fIOEglcS8/my1SRIRF95hUjDs9r3A==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2113.outbound.protection.outlook.com [40.107.101.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dtuh03y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Jun 2025 05:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0g/2nd11HR/e750BW44/SkzlRxJNP/Hgr8Cwq0ibB0VObPCmF46GvnD65MAmriH/mIWc+RCVmLR/gyjVM1jkwLDcrpmOMgU5OnbBYzed0PFfoBiKau7SNzmtkytZ/oMFmWUk+lPs49HN+ep2NZaxrZN//MYt5MTK8mdUrNlbL4cHvOnRXNL1PIf7pC+0OAFvDxfpRAPJw0OXARp4/OLSWFIwl6SQMQ2i+di3QmPynFqsiL8a1jVn+Biz757QZVb9AZQshxCM8dDSlhPrRKL9wJUfE4NrhTSO2Tc6QHe00FM3asZumYH2P71E3Ih6D9CL+bsUqSV2EIzld1EwLPxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oylqa0ja3hmqdtLaHxeR45DVhw7oBIa3NWGv14Tkmww=;
 b=VkDWFP6LB/4X3e5I+c8/+wt5hdGdZqB+gaVObs7DrtwT/A511QlvkjXTXl2nsHs9yGgJ0WCNBgxSjY50lX16g9HQt1QSGzOQLgqnNbSpTQsgDuliBlLmU4805PhtsnG0xXrEx9sXzzr96D9H4xR1WVrMI91epHtfU3w7MUFEoQk2zX65oIYyCjqDk/SHZA0OQtire5LfaC6XRDVkzsKQhd3oUNzgGQFLRcKKtUbvtN/OyM9zrj1jxyssrQDPyWliPLwNYiNe75VzqBSZsztgnjtDryJSkC3SMaP7aUyz+mGve36j7Dnf5fgOlCn36nT8e2PExKh6UBjOjHfN80IXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oylqa0ja3hmqdtLaHxeR45DVhw7oBIa3NWGv14Tkmww=;
 b=nEBnxwFUUlB65Ydu5JevkLvUC4u+0roHdItdH33ejVITbcAgseCaNT0RPGvRi9sEDdGAY/b3IGkXFUdnJHY+nn4UYQe1UeXXnu4NiVvFc3INb3sEp9Q3Tcw8gCy6nua7z0a6cQg1GoEXy4wgI8Fm2j2CsBZ9ATbHYVr50JyY/Ah6E5o/DjPYbynd4cvNbQndiCZGRWXJWYmhev5aICFppYj/C3Fbqh/kR97QQJWJuAz4AnBPdAdC9d3fGG2f13TqF4coz8guH8ulx3z6aO+7LK+zEeDaH/88WL++oprW3qKrFkDBreZoILRYhkgOo9+v1mnEiZ2xUlGqKvSR6N+ekw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA3PR02MB10422.namprd02.prod.outlook.com (2603:10b6:208:539::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Sat, 21 Jun
 2025 12:22:51 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Sat, 21 Jun 2025
 12:22:49 +0000
Date: Sat, 21 Jun 2025 05:22:39 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/23] vfio-user client
Message-ID: <aFakD1PqE6Ew8whG@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com>
 <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
 <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
 <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA3PR02MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f854b8d-4a5f-4c5d-1943-08ddb0be55a2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wqHyIJNvZMfnw3nEv/oChfxJXlg9vAYIzon1Yrau1827ZXJJ3ObCwdz3ME?=
 =?iso-8859-1?Q?/Fypry/ydQgcbg9SKavkdxy/lQB7OUXVoSYWciPmpIRbcsqrFrhBcrTh5c?=
 =?iso-8859-1?Q?BsY/Cbd63fikft0hJyfqs7JIuJ6LpttwDYF/CAiWxw3IsUrLA2zk3QU1Dt?=
 =?iso-8859-1?Q?FQi49aP/w2h6DVqjg+N71dSQrMg7fdy8wGw4NjqDN+udgkJCJTRgKTvOr0?=
 =?iso-8859-1?Q?NsLfJ4vDE3dkz/PjUr4FQ5uOh3iGrmsCoG9Ps+zX1Dz8rrh/R4LjDyMkbE?=
 =?iso-8859-1?Q?cOxbH+K0ZoHBAAJQz7SrPrGh8DjiFGO88bMDzRYN0gFFL23c9G/CY5JhWs?=
 =?iso-8859-1?Q?u826SEtneyzrZSJaAtmaaBEPOtfdPokFMjELFe+bngloQAfbAqX8M9BxVu?=
 =?iso-8859-1?Q?BWIEDcfeIlOiQ/uQlIv04/2EDPvdlxBu+qfcGWpFl86bl8iHOEvxcob3Ap?=
 =?iso-8859-1?Q?tWOFVlBqvy3ISUvc925bTFNEueuo1R7XT3UEws/vPST+xpCsMi58vxUd7N?=
 =?iso-8859-1?Q?BDwnqyVPOet+6KGYqH5AsDm9SUTsGbmV8ltif7jpwT3G5jNIsssZRDv0/n?=
 =?iso-8859-1?Q?psenSayFTit7YpTRKwCM9FWhCzMof8xmCeWmJaxJTD2pthC6Mb1OtAGXtM?=
 =?iso-8859-1?Q?DnTeVc+8GiRhjBFayuc5fbXIcI1qvKsxonzPu/sWXLAIk86HU0ibK43dO5?=
 =?iso-8859-1?Q?GkgJbrANjmpaFWXtZykh675KO1ab134Sql4+LdnHeOW1gZsnLft2w72W4S?=
 =?iso-8859-1?Q?yqF10O82JCpC/hquUTAgcOO6iUbiSe1Ny0uIQqbM14L719exmkA1WMD6Ll?=
 =?iso-8859-1?Q?D2gcPt6QyRfB2ou87D9OP6bq8wQ4WaYjARBS7FVB57vYbJ/6nPew5eNKkJ?=
 =?iso-8859-1?Q?EeJuHylwWnYTwZxD0VPLpArKFsyWTvgVArgQGHNEsRtcHkn2slNkghnfhM?=
 =?iso-8859-1?Q?PCeJnXGkZuUZXM3++1q/H2RJtrIwTYCB+iaQGVatNCOUUI7ATyfyPWDoz3?=
 =?iso-8859-1?Q?Q/+oo2S5qoflDXAtJbV5MYO9aM5GezW57yOywm7Q1F0iA76HUTWU/Zap04?=
 =?iso-8859-1?Q?FLvF3UoaRF4dlLZuYYcQw/Mq5VeYVpMykNrNJjYuRwmS03hBY//jBkWwhJ?=
 =?iso-8859-1?Q?s9iU2UZ/6lOSvOeuk5ESS9xwGSI73z7AWMI8VB/1fhpc0TsA8XiXUrd4dr?=
 =?iso-8859-1?Q?46WtHPkgehbFarok8Nho/nvw/BP8JYFga8sbYX1nMi/9ynS8guZKgOPB0I?=
 =?iso-8859-1?Q?oUpJ6TVKvmEVr/7futxEuHI8MN849WhfZe6Dx4z/a9Gb/ov3X6H2WbkSTl?=
 =?iso-8859-1?Q?sArn1z1Dv5Ih6P1qHCIRhX/aNszvQr9YkVUhpAap/RBVndBhxIqvsNulx/?=
 =?iso-8859-1?Q?lH/4UvQoWqWgR/lsNVfxEGvbNJ26uleaLpW9CwDZN7tMkV74jLOV3lKgJH?=
 =?iso-8859-1?Q?aYEGQxQDYJ8811a2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?iaGdxF7ybY+1GukifJ4N5qNLYJMR8wfKykZdcGbW0XWwUty7kfrTp5nhV4?=
 =?iso-8859-1?Q?sAuy5jTU2REsBnYRe/UNY52+cLGVj5jOVSM52f/cMN/7OZsqJAuVT/R9Rx?=
 =?iso-8859-1?Q?gQ0SyNezKblJmIdGwWX6Gb2U8mMywNVBf+tCBKagfecf2wuOOVY/Czptfo?=
 =?iso-8859-1?Q?HxanyXHUQPRWPJPJHqAW47Y0tjRO2GdL3B6vsxRX8KXsxey5FjDN/45wSV?=
 =?iso-8859-1?Q?C6nIAYorkqkj86RNFxwEP2gdlIxDy3xn6HazuvZUfx/7A8FBO5ptSXmWTM?=
 =?iso-8859-1?Q?g9/Ohrr6ETMx530NfVmVCwVWNHKu2y0ca20qCyNJzav42Cu9ZT2mmF7u5C?=
 =?iso-8859-1?Q?hssyybwWMOZXs27Pv0n7Spa7EdHGZ32Wk6doGtqyocaAK2AliehXfwbj1X?=
 =?iso-8859-1?Q?oE51GoyT1Nq2gNBG7eBBElU5HT+TIxVL3lNHDd04XG1HM86QtwVicxveJs?=
 =?iso-8859-1?Q?s/0UCzU+64RnIrPfFe+LNH8FgQ0vU/2HNg/y7BRtMEo90ccJ0BO9G3+48Q?=
 =?iso-8859-1?Q?3rg02Squ4McWJngp8uoXOmDqrGdx/znwgMLF3NfTvRqv+UzRXLs1/KoODo?=
 =?iso-8859-1?Q?AbNOdZL0rNiA2h88okl8aotLRC4Yk/5u0w2ZpZWvxTecE1KXh9eUfWef3Q?=
 =?iso-8859-1?Q?i2J+/MFxhs8m9yuKjzQOAwoEsocutJzmsWWyZe3a4tGvWlACDeHmTdIfES?=
 =?iso-8859-1?Q?XihY9XWSugqMx3EbkQegdvExSD9BfcPyP2INvEX/hTXoV2w7kemKaDgiQc?=
 =?iso-8859-1?Q?j7f4hNDqwA/FNYSLciPH1DqQK0zRuRXzsjKdKDjkcND2tL5V45LRKOwXVg?=
 =?iso-8859-1?Q?Z/NrROgROhc2LYatwmRUK2jbBp059oY54m5d9iYG203ujr4iqmsgHoRvXA?=
 =?iso-8859-1?Q?SU+VqbgNrmzzwI1m90lvkDYzNs5WVhyNMy+EaIG4NpEZKCnfn8LSvB0Shl?=
 =?iso-8859-1?Q?EZIMH0t6w1xc9g4oZSHg6KILrLgQ0lelARcRXvZFJoXAXV0jT9fAcLMrKT?=
 =?iso-8859-1?Q?r+BgsENaCSG1kfyjW1veqbRU6JPpXX2AAGJRBAuXog/D9qtmKFalRGa5Fh?=
 =?iso-8859-1?Q?OVSvLwsPx5PI26zPQAkWEKIFnEprDIdCeQkBuY9r1cuRWO/VVefqT/YOP2?=
 =?iso-8859-1?Q?wPUmi8ozmPDXcmgfuP7/7vsKCPuarh2eIRXDAiSjVZZK/g0RQj0B6Rdu7j?=
 =?iso-8859-1?Q?dGG0fE4p3weZZStOqh/98bI7o9YCbLEW6mXZidNBq2LLhUUoLR6CVOX8Ot?=
 =?iso-8859-1?Q?RhnEnVACzfWnfQd/FHF7uBP64+uuXK03dJIJNTxjXeed932A/I3tAMT4ZN?=
 =?iso-8859-1?Q?yQG9EnpuoPdK88M64yRqFgJwpO1j6zdu/AFHqlcvrKqpzYGZo3+6eX2QL4?=
 =?iso-8859-1?Q?frl0wO/N2OMMmlDW74BpTujd5RbN9LEvBJBfs7JJdE+kR4rbl9pV82jVAS?=
 =?iso-8859-1?Q?JNjw9jp17YbAJ1coROOZ3PnQ87mV26umaHEUpzV9a2Ig/3749A5PPqFEcy?=
 =?iso-8859-1?Q?Mw02zIQH2qeEJEQW6eKXNMWXGcj8LZiEn/Gx//WskYnRR35VTK++j+LTrp?=
 =?iso-8859-1?Q?05AZMp0HvpdBITQ6KoXURvfVL2ptXXzNzLlNxQeHHfArAHAx0rGTvhA7ju?=
 =?iso-8859-1?Q?aCEFvA9np2n364xTtZP8N/V0BmcYLNxFpp?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f854b8d-4a5f-4c5d-1943-08ddb0be55a2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 12:22:48.9375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHxMJoWi/qTYdXyYyNB7SQXWyw412oBRhdZnsespuO2+jC/4Js3gFPLEZw93o7Aax68tlX8TGWwa4IQYgdQdLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10422
X-Authority-Analysis: v=2.4 cv=UK3dHDfy c=1 sm=1 tr=0 ts=6856a41e cx=c_pps
 a=Ztrme8kyfIlQy6zXeYdROA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=NEAV23lmAAAA:8 a=9ErZgv5H5NYlPQ3hHzYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: AnWPWtSis0uzANgY0_vnSGao0y2LyaK8
X-Proofpoint-ORIG-GUID: AnWPWtSis0uzANgY0_vnSGao0y2LyaK8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDA3NCBTYWx0ZWRfXz6z9YV+LP/Xc
 RR+Szdyb8x63z26H8u2RYEkmk3TgX3pao4Wg2lPhJKfUuKgf6bdsW/i3HXb6mNb+CGh9pJE0ONi
 OQwy/JBSxYVEcGM1ikTLBla3n//CxUjk6GGtH+M8V3jX0ncyasAgxM9cBAW7arHfOlJQeq2kf1D
 x7qYpfIHYBUmXNow1X7BpDdtO5PeDCy+TNBvq7Ux9xce4Z6KZLNtWcEXD0lBANDHBm4FZAEnDCI
 Eem40Cnm1uiQjZKAN3w9uS67O78KwCKJUfi4OmmoG+76y8zcXyexXFd6NGIL6ugBUAqNsVrhytF
 SUzN8NaNDgaNKdWSCcRNdYJoOHCCPc7P8ck0TzMKlNQh9X9u19oMhypAuzPCXSUTT/SfHY4TRpw
 9fHyabnnnvWvZ4mLLGGyoQATzMZnmXyKOS7BAKwy+YH9dwOnkEiBNRGUlMTwNZtrq1XIWLdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

On Fri, Jun 20, 2025 at 10:32:10AM +0200, Cédric Le Goater wrote:

> Before merging, I would like to be able to experiment a minimum.
> 
> Does a dummy device (server side) implementation exist ? and a
> GH repo I could pull the code from.
> 
> John,
> 
> How do you test ?

I use these scripts for smoke-testing:

https://github.com/jlevon/grot/blob/master/tests/vfio-user/run.sh
is easiest - you just need to compile libvfio-user and qemu
and you should be good if you have a suitable Linux image.

See https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
if you need an image that has the relevant kernel module, and for some basic
testing instructions.

https://github.com/jlevon/grot/blob/master/tests/vfio-user/spdk-run.sh
is a more complete test - covers mmaps both ways etc. You can test this by
interacting with the vNVMe device inside your VM.

See https://github.com/nutanix/libvfio-user/blob/master/docs/spdk.md

The qemu and live migration sections there are obviously stale.

Please let me know if you hit problems.

regards
john

