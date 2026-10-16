Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D67CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHioe-0002Mz-2P; Fri, 16 Oct 2026 10:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioY-0002EY-M8
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioW-0006h9-CT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:42 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5SsA3051509; Fri, 16 Oct 2026 07:21:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO
 9w=; b=nVHU/uZ/k6wzYeUzzKAhspVyR3gH4w8BxIgzOKadhg8ChwS5mHSCnAl79
 MBQzKRDJMljEaBRYQ5gnUuwAHrLMbFzbPrFkefN0cg3NjdB+/9SfECp0cOpUNOM6
 1OYt1UQZsFIQTvIpIrwdDTW9V7ASUY3BrhRxyzrQUP6WSqN4V+JaQs/ve3cIrhxD
 WnbNFhvQfNZXwzlppbczZVjU0vNTHhjPGggTVOxVklk/PKDSsnfu11R/CxrY72K+
 wApPIZP6G8xJVkR3se+w5mD/i5cURAlLCoC/tDDm3dt923cLlhr7PlPeBgQvrbx3
 qx40B8eOR2RCL2Aq7oVv5FolMjEDg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021106.outbound.protection.outlook.com [52.101.52.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb7t19qru-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHL4fRp+/OINWHJ2XUxKvMwx6O9MESv/01/vEyRCysHa6edqzgkZelYbuTiJKTDbcq7y6na8dJawDuTqNlnIvhizOn8ZhQ8KgmIuE3o2hEJ5c/T3mmG/WjaAqtijhxVvMEDg8yZ+JPfd83rOo441X8WTZs5feZUnF1eDTt60yAFxjf2BX/vTKzyEXF+y2+mqGnFEwZT80opa0nH3/GDpzwOt/P+dDm64Uwgw/0WUiJYrzQerHxM0GPSuUfIESGVbuW8Rn0OZjaTrxS8hpCyWG6E2AzQXj9JX+wihpUi88L8emHa/RxICguGoDlHj/bO7TzbNfwSY4wfdWkn0EEy23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO9w=;
 b=PWdKimvN5PReHp3RmfsZO9ZnFESQ2+HZWUcE9afABrRMAMx8PNmlBCIAtipgCPWylJa62CEUw3o1QHFRP0AhBK8ru4IotgjfLwe3+/lpnxvRPWfgNi5JGYUFnJM7Gxs1zKSrFdXMFM8enxgkyxDV3lQ/lUo8aSmw0D9O2/QXd39r8p0OlaFvJf/Am0C2UHkO3k8/c0Sm4LYwT0mWRFKoWYxptiU03aIBb2lClDvvHmTqSelEwzqa2inaQevlvyZGZxuegAb3T2QrO70bIlGoVuuIDBNznQTMHzfpM9fcBMLI/1Nv7vBG9t6M6Ww+rFI4LbWj9QUcEG2xP+RI3ziQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oPkk2OhFpF/vtiHULlP+3P3BHO9YE69TRweo9UeO9w=;
 b=UrmfkAlSEZ/mQMaGnQOXNlXd5Q1zXQszRTwXpaBZxn0IHHIrxmUsJA1vtAr46dolDVRYkpRXwzAx6H5x9VhqSbmQqdV5OzsRfYGhT4/Y4LFS+uuH8qSnO7IIu/9Y8obkTNSZHgW6RAw8OrfX6ekKii1delPjgMq5UsXAHQxziCPSxyIVjRW2HBsyPhiSFeGzEEQMMJoH/1/bLrvUJworA0q4RogLGzTTlr5Q17LOGbHi0mV9s10FLyqvIbq9VJDI7eqKMyBQTqcq5rFIdC9ccJ6jClCUDmfESY9tQ1yKR2NCCaxKNio1HA4ICFIHPLZkgASf+kmrONj1INSdNImuAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11424.namprd02.prod.outlook.com (2603:10b6:8:352::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 13/27] i8259.c: use i8259 prefix for functions
Date: Fri, 16 Oct 2026 15:19:19 +0100
Message-ID: <20261016142031.1204281-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 424be368-939f-48db-7e1d-08df2b90c5ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|10067099003|18002099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: j1Ex5O91InqcCLfAOdfnZU4BEzrn2pOGdARiJ7M/g0s8Ag6xhSp8ogu2HXCjkL0GuqRjCdMBghPmxhuqS3ARIyaa6+5zKKOCIrJ1lROev3QSovGlC+pxUx/STVyFHWUuFJUvpT1OsZfbm0qCtJGDqN5jxzQ4q4L9WYhXexUB6tKeY5cnh2KUjhVWI3hrASwqpgYe78LDDNddcWLK0n6YLWUGBW8kBq+zKgcCOSFrp2KwtZXw8lfrckVuLFurIlirkXiyqb+cISeqbLsuU4vgivmYm/xxO0W+67HUMHc513dMpvY5MDOcZ/kHbTKPRKs4bFFGIMsR5KVJj6jg5vEsz/KgOyiYFZcd5WRTtJME8iLQMbQfEaTlQYf8vIg3pgucBVxKQD4SVhtfm7i0sPe6LHYx8VI/DU3ri8HQv1jy88ol+a2Q86MyCwRQ6XKT4SFdG4rBwEK/oY6Udfo5wVYVDBBcJrpDuSaxj9u0uNCR4k+STINK/u8TTFLo4rbxl/BhZBIO5zM2uT4UsbQyJTnH1SR2UOeFiXv+kHZDX/Xqcs2y/5e/89+XB+sGGuTg/FuFelE3y5xeKdaV0spvwb5JmqH1uuW1k57CN/qZ+oG9PRbjbqzStCPxF3q2+lG9eOdw2XNrI+qu6lvMRyunp74yIGDGESEB6BQZjua0TPzw9l4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(10067099003)(18002099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzOPBLTtIwyiMcfg77Cm9s85fmfW2S13q5SsJSA7HOm7GSNb1RNj0dUY2NXI?=
 =?us-ascii?Q?S7kmVZioK/SHqgzLwHNhsATFVaM5Nd2D5zdqBhTBr00YxPjtudShvMew0Nup?=
 =?us-ascii?Q?bypuwLBdRmtvjUpkuzf/5P9heVaqVnlEo5ykDFpviTXvmeHsdQrdlg14c8OF?=
 =?us-ascii?Q?1AG+QGczhLWDD/4ecf2oW4k7hND/t0KDVdy7E6cP6VUyFDqOkjE2Jp648wbk?=
 =?us-ascii?Q?5PgUSqlWMadv/KVm7rqcbPiq0v3eptQW3srlxx4jeYJE2qq//R4KifQiRph3?=
 =?us-ascii?Q?oHSo45xOJTEATVQu/ClASG8cKTObpVWGL/ixuYww8b65ji0eTcw2THzv/nDl?=
 =?us-ascii?Q?+o64H+cwfvt4hO22QNc5DlXQDzdo7eNs2BPpoSzDDXRdCJpDaAB/wT6lz0AC?=
 =?us-ascii?Q?ODC3spfxwQItFkduPl2e7CwW5q1PojKQNOSIjGJ5BqmDMsdZ2mEd/EUXX+b3?=
 =?us-ascii?Q?JiLL80Mx4lgTaYggkqH24OXntwFKH29XebfILL6kzsDYkrL0jGHkkNeYBn3d?=
 =?us-ascii?Q?ypxpLTTeJFXfyJfhkZu3Bf4NJ4KrZWIlN5ACbGPUaoIhoG46sm0ntkjOYPlO?=
 =?us-ascii?Q?C/EOPdbPJmBCv72hjTyAFpl/bf5AejnNiUsRpXE8sBcmugRJurX0xMQ4WU2Q?=
 =?us-ascii?Q?Whq/YLeJgWLUH02mdy/LzHTWmleQaB4ZwPcjmZbAmtbvaS6ZFd8Ykioyxjc3?=
 =?us-ascii?Q?fXyVa1XgAf6/+QJk4olhaZ4GhjCk+bWbzlbPM+uivg0JxKBNyKLuUp1j3KUs?=
 =?us-ascii?Q?xqOhXxvYc4rtPtKEQOMMZ3e3aQghVX1yEtGxi6hT1S/rmHeGxWXc5YZ/Rpoy?=
 =?us-ascii?Q?uPV2gFoewyVHiWl6/tH4sYve9luua/FSzony0MlW/WovewNjDsKEbzoeVFdd?=
 =?us-ascii?Q?RFqXntwAOUKRuM/SKngVWdwMpp3jDSpUaLe5E5hjOky8sZhNQfvteN9dBHZX?=
 =?us-ascii?Q?QT55ArMnYwrupmIUB+lO2KPwCwPZmQ/uYkVP/Whw5xlzmzZYLZ5d9oOoohaW?=
 =?us-ascii?Q?kGYN0TnXxB/N8ikDjpIiJkl/uUbzhoSj4cvAWh7aP8PRLuQhM785nAIEv8IV?=
 =?us-ascii?Q?8q48T4zF361dFaF0ca5w5Hdn9NwhwPChHvXwV5Aht8XrTe3m6Ee/SLgOhlTn?=
 =?us-ascii?Q?m9VEQ60mg8XOIoMIB1IF56c4E63y4WOD6CAt2hmTeGJbTz/YZTbZYn/4gJTD?=
 =?us-ascii?Q?lNZB9Y3mmQvbcR11+GLz/Pgre7jwn55C0pQIPKg/ZTvhJbw+irkdoZ4jJMo+?=
 =?us-ascii?Q?OcuWETkFK+3tUVeF/ENmLcAPdcH+ElBpDkOiZwaIYAbAPxg4M7CddTaDtcwI?=
 =?us-ascii?Q?ry3FLyt+93n17ZJIImgg1J8jNae4bUlBSPRoOdt3/Ejn3gSuMa7ievSgQMeg?=
 =?us-ascii?Q?GhfbcCilWoH4eevArMbDSCt6kjPtdqrEN/QGX3JdjDz2DktVJBK/tkgcPPHX?=
 =?us-ascii?Q?3+3CPYNGdIelkz5Do560R4ZCGuRrzEZpSyq9q3vAsgYqyz5EKClzyerM/FJ+?=
 =?us-ascii?Q?BWxL5MBMCxJfrZGkxdSJ4ifyf8rfqIuYt1U85RH8P7Xu2+o46qEbWHPMCFzU?=
 =?us-ascii?Q?6K+7+Eo3qw7gKRQISFO2RC5t4brvMDUm7Hqz1Qyx6kpVgPCkcEGlPfwjEIHb?=
 =?us-ascii?Q?3AtBolTazzn7IGIlSc54cUMm4MNMNbrzed9JjSBogGOADS4MJK0oLE9e3+Jp?=
 =?us-ascii?Q?JW6TGZ2r598AhemMLOOuKVRqk+6cH9yfVSm5zfX5UWYOslfqjQnQZ99O24/8?=
 =?us-ascii?Q?+P5dPu9juhNt6O+EZJPZmqbk8qk+/CU=3D?=
X-Exchange-RoutingPolicyChecked: ZTFXE+YVpusadaHtyUigg0DjACaxaNZn+rHOeiozzG2YArW3SNpefYR71kUw+PhiNrjYAxc3ukHkT/fzdCH8hCQg1nf6zNmHXegEpCbcUDPNbMREYmCXNIzhuP9ByUQNywX3OTkewURfM7y7ohbRyifrUc8D2yesygD1o7hQm/YEtI2z7bFZqE4eCicLJu/HfMGxffL65vpalvC1p0KBPujAlyzSfOFBHdVe9kfAoYN5CYrUnHOHrPvu4V13uZB4ldZ12R5BqXWMJZNacGAz4asxy3XEmvz/CiepVCaXf0+hdwduY138Pqm8vf3EfHk0qwdIoxmEOkZrRZeU9N8vag==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424be368-939f-48db-7e1d-08df2b90c5ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:30.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ+cinOpoF33AbFzib4L3bWxfF14UWZTBSmJ0Yiuzql7kfcK8my6L9j/EHmB+8d49DzZaogJbW6vCgPcqrmDRHLsNUfqvSCE9WQT6RB9jYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11424
X-Authority-Analysis: v=2.4 cv=LsYHWXdc c=1 sm=1 tr=0 ts=6ad232ec cx=c_pps
 a=8AR2Or5FcovIRbB7TUUKGA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=n0Z0T_akzs0uib7mm64A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXwF9U38xxOIQ3
 IUmLvf8WR4oFzzCkPn2xth+5iYhBVTaLNJ7QnDJxeqqRAZNovMrPghDz+wiKoAIwantd5FUTLT5
 5un6vuQxhtkEF+RwTntdAtXiTFxvMmc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXyBgXEhGivSi8
 wYdxRL9AfQsEO3A7+YVYYmBkEFf32k1sVdGGEBi7852MEsSNyNOs0LnL9O1OjwnKsBM5Lxrcb9M
 BNQ+YVpNeVh9LJ1nAsQW2C4f1eBOF2Zd6N33+uLAP32fLUS8rD7Lmm3Syih9rcaUgVcB8pONbnk
 fDfivFr7xreWVk+jkbAUUm1sxby5Ubtte5A2HtHoa7Hg0WQTsTnW3DRLeo5DzbXZgarSQJ2Svyj
 pmmNFnyWHiJOz0Kq4uOa69GTf4edzOo6NlL9BwW80lurLmWYHIQtjptj1lUDenKx1myWEWF3VQ3
 mHKYcojysKC5j784CKDN9Ii4lyQLE6kfXHja8f/ZHZI6G5kpqbIkK9u1kqs0zZItlnOcgt0Ky2K
 2vJU9S/EvtoXe+0zpX/MSl6gZTWhV9bQ6A3OnOv+RTdiu+rsQdHeDWROK8OVnqK830CqArQuu7R
 TK+g2bU0Bcf0IDVDbmg==
X-Proofpoint-ORIG-GUID: MQyD3F78r8y8kcFQafJ-1_OmIYvtdflG
X-Proofpoint-GUID: MQyD3F78r8y8kcFQafJ-1_OmIYvtdflG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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


