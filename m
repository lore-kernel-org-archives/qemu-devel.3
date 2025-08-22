Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFF8CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQez-0001cO-QT; Fri, 22 Aug 2025 08:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQew-0001bO-4J
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeu-0000gb-4s
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8KHZ7714386; Fri, 22 Aug 2025 05:14:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=N+qiT0nqUmdJhakAAc3rDiADkBdYEZ9eTC0ZLEQgr
 fU=; b=Q5kDOf3ToaO3OwzdKN84QmxDl3EnjA7pEXxVNaMib0EWg9dUSEruTsX/l
 h4zINbYNMnpfoUB9N0UmXGjXXJ9WRfOtmQ7Gt3tBnFc7O0btFCT3vkQZNGPdPxCk
 GEEgbTvGUi5NYM9V9gda2W+CPenffGkyGvpQE5z5fteIS99E3xA2C29Cjr/03OK4
 pSXljPn4+DErRnaZtB1Paki7G/u3BbGErNbw3jmdGbxeAGUF+cwkEp4QMSyHc6uW
 itDiRiSq/urzqZkoGrOxyN8P46Tv/tR4irHIgO5+6OSPGZXQJxHIlOv7PJa1NGcn
 RNqkVAayjZT1RamsYG/ojJK63aL+g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2109.outbound.protection.outlook.com [40.107.237.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye6qgdm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI+bWCtUjrJDfJlK1N6wP6iNVQwq8iav9Nhrq0DIlJrPeRr3uR6qCSF58TiXO+Wmvre3ij/7JIQVB0VYux8mPHrby5enlbypBF/Z+OUvHEiyafCkdBS/AA+79p/PBgV9Mngv0yRE3tlocus2m2jWYk1jyGJGZJSp9bD/ytiBunnSMf5vgRF0U2WnY29flPLrzu2VsmPtqB/2W4pXBj9zzJV0bDzqSGTPS689dPZBsJDyos2Ztrcwv6Q+1tghluQiuqbs6AkDMT7GaGpzRlgp3WxJpHgH0AtJE9HR4VthfhO/st/z33BlAXQx0uVsjRai/3oPqn40OwjcHtbrrLLeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+qiT0nqUmdJhakAAc3rDiADkBdYEZ9eTC0ZLEQgrfU=;
 b=S1JJ04uSfFtCBJBicR4FX1SEpUutYxZlxnkHDOeL0hmB3d0CLOvk/Xcd+1R1vQ7JHuLSjoI9UhZ38IAGawOTA8ocxN7nwMj6i9lv7C15TvL0gJR/IAYC1LhuIatY8Y177cCYM+5GOg4yzfpZ1soyY1U/GjvSJD0vqSv/95Aq74uyt9lXMChi9VEj8jPMiz5wGHBsUXSKTvsx3vaJ7vPxQJBdbfGs756sj2BmRBsaEb4pJMTo4tOWu4Ts2TAj+QjeyEcENLRU8HcLD8gurzb3xfPhijMA86BENSFQTV91MJZA1/mZGXCBbazAMFWV23P56LT4wyDOmouRqcLnGhogLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+qiT0nqUmdJhakAAc3rDiADkBdYEZ9eTC0ZLEQgrfU=;
 b=PAEPvFgcUwn9RuP0JfYAw5z+gZpno6zkNmBV9qPS91hN2I2FjpW8L/y2lBGRKk/CANdNXfWwEXLttjoCW6FLJ0OBksjiUAcVu32tO/hw6VEX5JuObeDEOPaOrqnwVazUKkKRN8nUm8tHsMO6adLjavdnOs5trvS6FYV3KsoZA1BgtrSfAPHc0D0+dSbiHVclj9lwL4GBtCHeA6gXv994tgHTNUgkltRi4/MVviLOhX72pfBYzKOJ5UwmQ3YgAJ2FeXOdwT+WFNaiw9Iqv7FzJZKae2VjQP0yd5Dzr9jMvb96dvLMnnoZeGDfw72VzLS7gKe7Bi1tezLs4nS/j1iJcQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 07/19] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:53 +0100
Message-ID: <20250822121342.894223-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d01d1a-afcb-48a8-c17a-08dde1756720
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfQCKdQpH87ig5S174oSTUEb9x/sY6P65p8CbPF5P7vfXapyuKpEj8rIEsEE?=
 =?us-ascii?Q?sewFvLQ18WkBoQEc3dM0ox+HncoxYc5s1kh2WIHTC1wBhMA1g0rsUmw2wMV0?=
 =?us-ascii?Q?mKmlLH/MQSgmLbtxoUqS51ET1Cqqvo1RPrbDjw27lJd8QpuiCrCCxJ5CmAsN?=
 =?us-ascii?Q?ujOq/O977P50eiFLKEx1zv4OAsro8hx/oVTsFvA3+osqSLDgPe2UbPbvuhMy?=
 =?us-ascii?Q?AYhZqfQgRUvPW2ycgsC0XYB4hnp0q10KvOxSVbaMdwiWMfWVvzNCswc5kJIQ?=
 =?us-ascii?Q?KVjvv32Ia9S+9kBPPL1Qm4+PrB6ZN0caNDp4TDSPyLPNJSXcKXjgJCusS952?=
 =?us-ascii?Q?ews9eY856678Kfkrn1s2LeqTaPIgVnUTGDGh0pWfi8ljR0SszSbzWxsWPO9s?=
 =?us-ascii?Q?HmLp2Ftd3SQuEaTO3vNUOk5noYO7U70THsuZI5+Mkbz71vMIzn3Uqpi+q3E7?=
 =?us-ascii?Q?z8dm0bb1wveMQKTXS5Jroez8dHWd0PKa9D4WWH6B6SdlKFz6m9JoBDjaW3Su?=
 =?us-ascii?Q?e9La4/AuP/+M5rFhl9sUTPXSplfQT6PU17xRnnGZsq3sAK0T25YT+PCztz99?=
 =?us-ascii?Q?gMpsbvbtL+lM56VzLRWC7obJCD+gVzIRcWxG9HtUo5tGEaEI5VkkhibN5w3r?=
 =?us-ascii?Q?9o4JE1fMOH6dlvbapYke8hr6MLnNSL9IDjLRq/8YZeI/qMdzQrYQHttMcOP5?=
 =?us-ascii?Q?u4GYa6iHdQZFBJCvhluvXmacFcLjE40l0k69wJAkdMGcSVEJmWcl4cn/8dy5?=
 =?us-ascii?Q?dMPQInL1YnbSzd5PM4dkpTRz+BqDyU8enEOiIYzPVWkZrAUM1OXPlElKr1OQ?=
 =?us-ascii?Q?l8qoo8VlH7lR5ffOELnLFjvf4vB8X4PkwUSrBy8hOSkdCmswQ0OlSWO/KD8c?=
 =?us-ascii?Q?AwWQMHjFE3TYQyGbYUw+DFlYy6yr2T7CykhzGt1/n/X2JYBI+iOezSDvZTiL?=
 =?us-ascii?Q?o3mHrWDKExS6IfdfbdmaexxDucpQ0EaWewjhNTMMY/k324mWar/iUfzdvgzo?=
 =?us-ascii?Q?hJWSnGYebWbwCMfKScHFl7kezXahUw7Ul5TwplSz7/3TwnHAJ5cVw9+QztAq?=
 =?us-ascii?Q?LDWfulL0XzK7vpIhuYazUkTYpXQet8K4mFhI4xAwQ79fqlrKlg0KfMOK1fOS?=
 =?us-ascii?Q?dEy+VzFiSlvLLhAZ3ZK2j1RwY7Nx6w++5dJfsIdoU4azBltd2oSq6X6AvxNW?=
 =?us-ascii?Q?lFU2GuEEwfJ885eogN04dniRNksXGiUefsEH4D2FQWfyn6of7iS+Bh92F4vG?=
 =?us-ascii?Q?ISeP3huUa7g04CxcBVyYNpcSAKM+C2BDLCmredDlwFLsLkAQKVbl7YZTO6Yu?=
 =?us-ascii?Q?RK3Qvmzs5xjqLhEV2KEC7EOropZGiTPElA111XFmG4inKsSlG7lTnCIAiPsU?=
 =?us-ascii?Q?sM4x+Bjn9rPMq6RMVpy6tpDuvz0L5ERBJ7UTlbsfFTYpuJUgcZK1f0IF8H6R?=
 =?us-ascii?Q?jKeH2lKIxrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GulMMRJOpBVC9cS311nzzccFEijBusPpEM3Uav1iJi29Y3OpU16kgT1ndSb9?=
 =?us-ascii?Q?UjnzqZQlJdItBujdA40tP1OVGbDf7IdUrLNHr+8DIkeCRnC6NS2uUTx4a1Ml?=
 =?us-ascii?Q?iqIy+XvH3UTOgKvfTPkP790S7wY9Z6fhY+VQ9i3oODJ07pw27LdToZdkqC6X?=
 =?us-ascii?Q?rzLjiOo9Tyxiloma4aVYIj+DMzEwdcZUD/+eZCfazuL8YnBlo4JuUkwf+dSs?=
 =?us-ascii?Q?LdgOpEKlBEjIPKuXNrZyfkU4ib+ZnOcvtrHrg1foiNG6mf338BcCw+VKztBF?=
 =?us-ascii?Q?C/sSksjcauyEKOYlqgGbCzdrFdW3V9LvVW5K7QdYXoufI7Z4j7ICXMlnxMmv?=
 =?us-ascii?Q?fAxic4Jw+sEYU02jfGgwcP7P/6fqO68VUazs3rniaMgZrj1BAFnwCYky6g9p?=
 =?us-ascii?Q?6rZxgzz4kO7WzGCZfnriNUga+f4r1DEc/hSq1ugVdyfmSYF4zXy30t9hCcsH?=
 =?us-ascii?Q?BnW+XJgQvWLAmU9nGpJcqrH/m//27z24uQ+4nnDXeTDySOfr66ySMHjbHn2R?=
 =?us-ascii?Q?A1wJCr1wz13O8h/gsaKPuu5bGPJsPZc/Y0sw0V3XgcNEiITNjHa7OUzIxOBt?=
 =?us-ascii?Q?VfHCgeB/zr37rPGXzJHlObQUBJ1CT/Q2HS2g/tzIQTCkN5EG0LK8Ivzq0wmT?=
 =?us-ascii?Q?TL0UKI2UWI7qiNgfvNLZ1p82AdzqsIisUibj/spu8qRwvE3g7HFX0+XDktCz?=
 =?us-ascii?Q?7w+ggR0hJfFnHEIQ99Imn+eEbtUCgX27NRmgcB3HUm2anVSGTgpjA8JxeDm2?=
 =?us-ascii?Q?vwR6YRA/r26bmMhcwB3stvgDAWM48j51UHH1LDLF9jTg3V8ofUKETpbRRX6M?=
 =?us-ascii?Q?owTAwuRR8uqHQP3DL8CuvSvt2ClBjUrchZYjJdmJIRcnSS+UHwAElZWadMoA?=
 =?us-ascii?Q?qrb6KceZq+LHMU7x7KAHsi9P0Wej4FSrQJ3s2nXAHEqv4ETSQynXMGDlcXom?=
 =?us-ascii?Q?W5+gx8NGKDiDGr/fr/PcCIIMbo5d8gwjN5Ei/SKO9BFeqhzBBEkHnbNzNxLd?=
 =?us-ascii?Q?cZ7IhQTPr1zwoQw5SAPutgu2nWW7sZf6aK7ZRXTFVQiYIL3po46mUL9qyiby?=
 =?us-ascii?Q?S43Xl+lSH4cmlg9nZxTh1ju9DpYMo3K4aSKrzJYV/HDrpBIjERBoIkauP4Pj?=
 =?us-ascii?Q?AmpZz76cMJmBvVKfk9FHEM9KcQ32mmuSCziz44bdiTnVNAQIA5syfGIDfrvQ?=
 =?us-ascii?Q?TzbvogKd3xPd1EFBdX73TJthdUJNaKSjMPqPEr41tNMYamF3nhGzdA/+ilWq?=
 =?us-ascii?Q?nKZD5KO0VDEMxBFPyoFqiyisp3aDFvI5bbq/TipesjNx4Nu3lCblRZaAxjiz?=
 =?us-ascii?Q?a53p7bdFucUBh6ZG0y5WzyQrRcOPoxTqsNSq+CoFDUMOvM52+3YXdq50RbK9?=
 =?us-ascii?Q?vKT7tuUppkzy2cFqe+lYTekXThtH9j8zbAgqPcKtTFiIez1miNx6wN6rHWqB?=
 =?us-ascii?Q?u85f+wFvRt/Oij4ysl0NCkeWduPVd8p7u+LYGdfzZ8fXBFeybHXMQAv7x83q?=
 =?us-ascii?Q?HM+jaUwKX3hNdvzQmuH99ufqviuJpnUmKWvBYJxkk2b7sVl/RqHQ/qyUazYq?=
 =?us-ascii?Q?EpGBFSjkbUXFKXksegwFKz1j7OLkYGUusQNr3zxtcGHol42cUU9BJzNY7DOo?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d01d1a-afcb-48a8-c17a-08dde1756720
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:11.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UIGel5KroYwrwXSyn51GUO1v8SAvIyVf3LRXk9KbRxv4O2jTjJekO+E6fTmiEGKwictoTjY8Y6fylJYJDif/b8sGscA04iJSOGEtmMPoJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-ORIG-GUID: iqPVchY2hmTX1Q1dOsdiKHvwtAilS_Yg
X-Authority-Analysis: v=2.4 cv=QLwxhgLL c=1 sm=1 tr=0 ts=68a85f15 cx=c_pps
 a=IZtX7zTm26LBIsBaguIpxw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=yiTRickECGlooSfTVXsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iqPVchY2hmTX1Q1dOsdiKHvwtAilS_Yg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX3YU2pwwhbBe3
 zv8bsLxgqdG1VpIS1yl/l4L4dk96WPkUufiMFs7r6jfl7QQdN+pTZ3V1ef46I5sbQZkaSXiljq6
 vHfIGdGWbhm0Dlab+bG/54ag7Y04djMdpdFqkbrJZJUYqswCdHEoIZ5aJ1fDc0S9e7Eo7/NAukR
 Fj0xofBa0HMWPgnTjYNUnourRkr5mY3u1gxxXoGvBqTsJjacLfriszw0uEx4VsdKaU253e4lOtf
 7GVDkRQeBGkTXeVoC4tZbfyW7Kv8YY5I+sq4HBWIu8ni/PsqB+XFoZosabUEz/qwvO2PSn40dhk
 TrSJp1+K/EpdxjnsFpiCY+CwqKdnZ0vJN8gUXY52yX9g4716i1SXNzTSgPddmZ8DB70Hr+nEs4J
 /MQ7khQB+aijGa1Deb4cWAWz45I3Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e58a7b3977..129a3e2524 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -509,8 +509,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
-
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
-- 
2.43.0


