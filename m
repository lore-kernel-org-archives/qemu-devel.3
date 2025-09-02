Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E80CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUNg-0001No-3N; Tue, 02 Sep 2025 13:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUN6-00014G-4z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:00:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUN4-0006jn-Hw
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:00:39 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 582EvPEk985517; Tue, 2 Sep 2025 10:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IdoqGZIwukaAMahZoNA5d87oXUlncS92iJ4nKCHcR
 j8=; b=cnJEavbCq9+KGltH7RZ+njknSnrM4TABLjlL4UcTVJWHr3+hhmBumQMUR
 Fb8p8P0pV0RnuMheaz6BTML4dgdj+LmUGlLL/Vt6g4zSH4n3jK7OnFXsRlLgu9gI
 8RytHJC99cHVwJxmGWqqa+Is27gd+wwvk6+hr9KJdeCM+ewfFj/evxC08HKlTD3g
 hD43gvhw/2BCTMzxZOpXYRGhKe11LCPYhCIh2lon9i24tAbS0I60IFDrs+xVGNBU
 zzprRc2JUPVSFpoWkYfBN5NttIYilXU/LCVsZ5ulCEzA6mpw9BSu1X8r2X9Q1u/0
 S63fmvn1wk4Z6ytXuJfZIt768/R7Q==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48wew4jmcx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 10:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=topJ6JGucw9ntnNulb+KW1QNuTIx3JKUxR5tG1FwMhC7/eJbvViLeAS9mwxqULYI0teoUV/W/nACRNHuJFOXQIy2kjUzLZrar87RmHME5rUSvWtEg4h2rQ8zXseGhQtm+no1fn83h0zNCs4nMVjrAquTd7ib3YU6xBvCj3qTCHjgYipZVxQUK6zhTepU3qHCwx7w5zRWl83+NnIAfgBWN32V8feqV3QqUEpYYjTOfeXvjVccoGqg0Nmgso8y6hJ2sThvKH7kSlc2ID1pueHiI+tIr1uW04U4VgFXpOoqA9p/p5aYxElmMX/d/fjyTtNc6N7b8IqAKneH2S04mJKixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfHe97xBlSAKxZWBy/R3am+joBsKdStlsjAYlN4Pmto=;
 b=i5GxXVAARLh0KOQ94ZpH0Gm7iP66F67yS70N6rXEnNX75I/PCzyJNhJOiZqsG5cQI9ncBYe6RFP/XkOV9FF9bfWrrnthERXGeQ8uj3pziGPX7v+RFoV5TBTOfLXtgk3XgaEAlNZqEDIrn/JtT4hUQrSGK9tfAJsEesCcGu+Ia/pXIhcFIn2A7if35tG0gd6rRjV3NZC3kBTesodqlwbDqVL3iERkfG7iruDBQwzzsde/kuw0HpG7Doq9YaGiuy0Zr1mh9eUET96wH4xAjW5R+PiIpaofl0CBTFQfZG2J6bl8Kwc3XQQFAY1HsUWIQtjDKixC44Gq1zc1cEctgnGDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfHe97xBlSAKxZWBy/R3am+joBsKdStlsjAYlN4Pmto=;
 b=gfuvikdU0yB0es1X5Ny520lrdvAXD26844mj5Vp+rNDF+oOjAPrDdlTkkfuWYYzblQHAlts0e9T0B7GOBlCQusXddCvdhsgfBtOL5oYwHXt3MecU1gH3evWOchBL2buXOva7wJkxhzwEzsjqxbceKyggNd1BrfHx3LdYDp0Tok/vfTRmdZS20wFthywB5+Ibyui11P/ea4LCh2JQhzGjD9emhLybZyC62EYHaZExrsdx4IFYW02FNEEJh3TP2hfJHNpPMGiPSmwPwkFpsv09SFSP3GNB4+WVGxQE23hDDukxR5ejX/FqyTx5dCuBNPdNhlGhs78kKhTauBSIj32VsA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7167.namprd02.prod.outlook.com (2603:10b6:a03:297::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 17:00:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 17:00:31 +0000
Date: Tue, 2 Sep 2025 18:00:28 +0100
From: John Levon <john.levon@nutanix.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 2/4] docs/system: unify the naming style for VirtIO devices
Message-ID: <aLcirMAyJCDRjtpZ@lent>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902165048.1653323-3-alex.bennee@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: cff0d0e1-90f4-4b8c-101d-08ddea4239c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3GrN32W4Jn0m1D492t+0v4hFopDgXPP9CiQ+fW2G5uib+oebbKXjLK9LQw?=
 =?iso-8859-1?Q?qsclQ0eiJ+Puzm0PnW4eLFMitx93bb00SdsevkiBZv96qaKdlROUwhmLbB?=
 =?iso-8859-1?Q?/d+zwVGTFSN50CqYvN2kLMcueJkFBRpIrLUFnzfLhNzY19iLS7YNi5MHxA?=
 =?iso-8859-1?Q?FGBDF1O83DVrVf9aXyfKvcAm70RIpDp7ghREk54MLFx2tLI/YWfJ6hoImA?=
 =?iso-8859-1?Q?bgaUwxPgrD16u8FJXCE/gB4AB54cji8xfEkz3AMeOU4t0MLZp2bMbrz3Yp?=
 =?iso-8859-1?Q?5Ltvxd5CZl2GeygU+bK+FbwTdw01Y6P4tq4HLiuwlqOAdhp2bQCPn2CBMm?=
 =?iso-8859-1?Q?MAmZgNVm90vdIFQZ2pCdkPyfXa8xrA4bZRGBLYZO66D+Zu6y+a6MDkNOPv?=
 =?iso-8859-1?Q?VLG5zVWkLJKZFEY/6tnsQVfqhKlcbIkxATuVmpD+AOAkRFJ//P6ZESaGGG?=
 =?iso-8859-1?Q?LRTTxuWvbPK2GOm45mrkBJVv4fS/xnKoWTqjjxzJRw90BfZgJOqA7KwLAT?=
 =?iso-8859-1?Q?AwULBHmYOrZjQIvuNnoVDijvVJztTNItc4TyKV8lryoh+cOzwG4zJDpdIi?=
 =?iso-8859-1?Q?OKF+iXRYaar/KNuWrLLMW3fwjIe767erPGEuqfMvzmimI5PeceQRqBxHNe?=
 =?iso-8859-1?Q?Hueca87VOsAdGcq9oeTez6rlXvxeMt88B1bpriiGv4kgf7fpPDcnNkIz8F?=
 =?iso-8859-1?Q?ukTinpO8tewGkh5+jNcYRO70jCE/FW474cEB0d4W4b50/Ep3Ezoi6tbE9f?=
 =?iso-8859-1?Q?4KXaVEPKGKkatjgYFPK6/yc42lSNcdnhXKvJIm62mueq4eyHU0jJkXBycG?=
 =?iso-8859-1?Q?k3ZofXQvvxfe/BjDy/ZuLijyNhpam9wnp6ubu+LeoaZtRU7mv2Dk2BZY1y?=
 =?iso-8859-1?Q?0WvKlGXP3laWq58Ir7EEMW1feJ23/OK92KneyAL1C9OPUuLb6Ef1nXlwhm?=
 =?iso-8859-1?Q?apxYyAAbvm/Unm0KzWs8PC6kOzBH+1Jk/MvfR4uCrzzPC4Vwus4yn/b74V?=
 =?iso-8859-1?Q?1Xj8ChN2gEZPSQT3tsG2dDcriCMDx5DHwjJUUK0CnZc4qxuiop8sjjOGlN?=
 =?iso-8859-1?Q?4gPmpO27yZSsQ1Rt0bQx3sLnHI7/WqLMd0oL086OCT2GBZx2V47Uig+ywR?=
 =?iso-8859-1?Q?kWxmM5w+xgVvXq/oUynJtigkGV1QswhYp7+hhVZiPsCrc0eNP6fX/Tdz+0?=
 =?iso-8859-1?Q?Z3av7tk3K8yyI7LRgS5VJuTCEjxy8cRvoKHHicJv8C+OSRV9RRfyd9SjW8?=
 =?iso-8859-1?Q?lkih7E9DE8AAoxPpSRneGAx1TR+qy6LZUDRUqIHbriDw5ldoWeSH7AXTVs?=
 =?iso-8859-1?Q?qQ2auR3PHFDQJzBPKABDHVYUzwVfSq8LFUAnr4hHc3DINUxSmbg2TIMAyb?=
 =?iso-8859-1?Q?ZiUWA0Opm3BzLqtqAaoEt5zzRXUmCizNqJvDl8+LCN6xhiJlncETisWbsR?=
 =?iso-8859-1?Q?LcZt4lhCIATkXsbhyoE1Gh8W6nPE5567q8/6jACT2wsIe4dcVKpe2daaJ1?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6OI6K69ZV5VZkgllMrtZuDFwEFscsltqdUzobqGnLNeADDuKXL8qJPmf61?=
 =?iso-8859-1?Q?5jZyqEcqQ96pXdJv6WvjQJHSfmvrX7U/W0w3usoZI2I9Hmjktenv+t9FB3?=
 =?iso-8859-1?Q?ItjyfnHzO+lIhnpBChU8r/LqQWto7YeB6Xfb/AsRPrN/hfFoMZKHx2OGDe?=
 =?iso-8859-1?Q?ncz1Nk6uyhD4kC5Xx4h+rMH7bVqlg4iJYCdvvdubbVqk8Py1ipTh8rw+tT?=
 =?iso-8859-1?Q?OnGS6prsk/SOZwy/TN0CJdB7ux9dQquUuCu6zslBzIkt1TPK1zFGvfXUV9?=
 =?iso-8859-1?Q?NLDqRV5ED1PjHyvvC7xLzIpFevHPkSHPeswANVkc+kF/R5uLg7i1DItQXh?=
 =?iso-8859-1?Q?o1yS1T1Fwqv8UJGxP0rblUoqA2ftEathUG6ZGxBfBFypGHQ0jC0ECGXR1d?=
 =?iso-8859-1?Q?pjb1i+tdr1CnnrUO9fKcrGI936Kxf2uqvIRG7spew6bIko36oZe6ymC8ed?=
 =?iso-8859-1?Q?MQ8km2/wqQFaCZj/VrCt1E63W6ehV4orN+JBczzYfn2oYKvoj+AOK7Su0Y?=
 =?iso-8859-1?Q?M6MrQsW+Gs69AfPbAHJ4yy8V96/Y1tsTQTRBxfzqst6aDBr3uwbldsWL43?=
 =?iso-8859-1?Q?82YPmto6um71sQN8jJHxDyaia3VcTsC+nGJdjDPQslMymSNqsz0ln1lgfw?=
 =?iso-8859-1?Q?coGZzz1v3jeDjvEudYsyHR1T64J1YjdKQ3Xn9XKSkins55ABnGKAC2Oq0E?=
 =?iso-8859-1?Q?1OhdE5VCBsJbdU638fovCeCncoimLyginP6hTp1yNRc874UUIAkoYBzCyk?=
 =?iso-8859-1?Q?B9ha3vuZ2a5Np1QILeRaP9qYSmXWBV/5gmR4n1/5kNRxc9+cWxYtfQlYMl?=
 =?iso-8859-1?Q?v+H4nDjrBc2NXoly/UaEFExabP6z9n6D1CM2qrxE8bOHSoXI1uLVu/BN0a?=
 =?iso-8859-1?Q?YPbbOpxQfuF0a4e+Y28DEMkkJY0jh9+ZI33x0uVsD7jnDTnX3Q5R+XXN5V?=
 =?iso-8859-1?Q?ZW9RcuqJMRKJMF4WXxkdk6dnLl2iZZcpzmICW1QSgtLYYzERblaFWN9DpH?=
 =?iso-8859-1?Q?WZj+AfdS6tBQuHGfY3tl0YsE6rjO1WiVxv9jfS++y3dltzdoWPXay4zgKP?=
 =?iso-8859-1?Q?2sXqsMg30ReEdl9Cqat7mcgnGfwTUkDSkiBcOulpNVsg1z3RnQ8OeVtE0Y?=
 =?iso-8859-1?Q?gZPY1IsYdD10qqHh06VP59Gh4y5/J8DNcTQ9gXRiRmYJ2Cna2w9nHN6HqU?=
 =?iso-8859-1?Q?l3qoPctA0AYLm+mO3ZpDaM7ZAX+9eo/cn3IwyMpRHn0tNnd69PT+VQEz5q?=
 =?iso-8859-1?Q?bCIBM7wE26M0vyFe4iXkdb2HSjowM2cAOJNBtoqU4E+4WmJ6iFH0QNFzbC?=
 =?iso-8859-1?Q?IQoXtvdR4oMqtTXRVRsDN+7oQb+Xpf6ZPuk4yVaGWjR70Gr6/J4pZal+lc?=
 =?iso-8859-1?Q?3xDBcuMNeaBwN8/NScnUq1XFlH5ID6gNwKXq5tlIrjjzCih0fWIo7l3rP5?=
 =?iso-8859-1?Q?eVb+TsKN+7/JeqyoEEnis/2CNI9MVLUOUghkhtOlz3/WVAQTBQasOzYxji?=
 =?iso-8859-1?Q?s3FK8QO82RN0P53g1NWUO0K9SA9fFOmwFqurasTyjCtJSkII2ycqrObkA0?=
 =?iso-8859-1?Q?UA3+gOOvbeDg2h4NjqyAmwZdKK/IKyhkMZwdfMJqy/yY/oQcSJo5004P9t?=
 =?iso-8859-1?Q?/F7zWa3F7lRhOJ9J8PZKyKfm2X3Cx95yYQ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff0d0e1-90f4-4b8c-101d-08ddea4239c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:00:31.6073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: std1kRI2WCDyhDbthrcYhqZlwZGbqD2MDAI8SoxRVjjdr5qB2prTpf6aCV7jFY8I4HfEnjmn+q6Goro16hqKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7167
X-Authority-Analysis: v=2.4 cv=LeQ86ifi c=1 sm=1 tr=0 ts=68b722b2 cx=c_pps
 a=FHjtdqyCv8FnNT4cxF5A2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=ZtwnxLetijaJ9CE5PGEA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=h1q6ZXiXV6sA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 076SLi3wQbBvtxncleI5tDY8lP4cmzRj
X-Proofpoint-ORIG-GUID: 076SLi3wQbBvtxncleI5tDY8lP4cmzRj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE2OCBTYWx0ZWRfX04ayjVXby/ye
 Sicexnrf1LhRIzuxw6lT0VY7gGc1RAf8BzIlYQcsLF69+8uUBgQokDl3C9i7h6OxXC79yfRdl4j
 uYoxxg6agWEHVhyaDfb2jV2kt+8B1o1zbzKgWdW/iprVrFdPbdb00K/S9LEoOPE7TSgGpzmpcnn
 IaqsumwGAeksXXE9U4NjNXXsJwl1aCIL4Dm2U5OIrepJmr5iDMASBBfXFJ4UE46/jVDuVZbL40Z
 x/2sue4TzUzx6+qnhtrH/ulRVAE8a8WjZrfpCVqvd5Q8h9gvMbzltSPLeSfjrl+cmnYy4NtbZhE
 4pG5RNuCa1prCsXB7RmTLpUczoH0WSoECiItA9UzTVsS2rKYFs3S0pqQFOoD+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 02, 2025 at 05:50:46PM +0100, Alex Bennée wrote:

> This makes the index look a little neater.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

