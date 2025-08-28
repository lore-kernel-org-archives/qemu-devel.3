Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717A0CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXm-0008Mj-D7; Thu, 28 Aug 2025 07:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXi-0008Kl-8E
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXg-0005KD-Ga
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57SAsHOr3583439; Thu, 28 Aug 2025 04:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6gCBPmKb6BDo+hi4fwxAhnQKMn1ewxL0KMetUel2l
 SI=; b=iEGmm5pBBcRCITySu+gF3QzS9vmGrdaWReG+yyFXNF5EuE2zuLZQxflan
 gtofgpKPKoVuU5+nQa6qY8CYAWp2Ddx3K2innzCguLqxA9a33SHJdrErmUmm8ZoR
 E9EidTNG3ap3f1vbqVSP4Z9/Hk9ceUTTA293qNZsh0lbTvfv1LysypMhuiSX2V/M
 S7OrPTr+YzL8DhFT32RvyLKb2iMLb7W7U0L6vHwAGv+oRXi2a+AbY0O9zvbDZOmU
 sfRsO5KxOKYAgpDj5zLz11ErDvIDP5pb+q0TARxCQmW0RBk96XTuFJbxqf/hAKHt
 fGPZ5WJ54MjuJvva+Otc7i1sr9OHg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021077.outbound.protection.outlook.com [52.101.62.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48tcc316ke-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ9TcL/XPQAKdzi9CC6yI1dQWvQcF9WNZ+6z9pUZbjDD+SSIGJzncQmTC/ZSdXtygofW1U+A4+Xtx/+scP6wDhqhZt9NlLHJlwaiY7V2qX88TXmKpCMShm2FtMK9vIVdBjxHkz/HNplbp22WDLbZE7Zvpvq8XEX1Bt+wpWTUnNlaqg5VF4c64GcOtjMa77JoKTAvRTiODHK7f/qpNP3YUwdYaVDyyNLwCQRbpRSe5TURk6ki8SKit0fZ8ml1oBWKYx/ZHKwDLTkgO+MyBkqA0TQQa/vKoBaBCw+Re1wFWTgLu2DzZK7ahkvEzH4lZrU+dK/XhlydsCjQiT5Um01w5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gCBPmKb6BDo+hi4fwxAhnQKMn1ewxL0KMetUel2lSI=;
 b=jjNAcs54R06/uiGByb6itJRRyGTlcyZFFpWA4Is2+JyrAUSsISIotYi6AQZ+60oaJH+bUKr8e045Z7hMzbLRL0Xn9hGOpDBaJXPPfy3KODKOA82w8HKcA0wyIme9A/1J1B5kd5wtiaAFvEBhefzMlcuhSn5LNnGFm5aSDvhxZVlO/IgfPUZLtiw+Rh2gasfi/Q5uNRIY7prDfmBO0CtXCPciRMzR/OdBw9IJ0oJ4P7r+8ECIjxLeCUauuoBdbU9iuCdfmBK8n+FSJEloFQfS2CE6fo6PZ8Mq8y0URs8eTLu4BxxxaVCE7YZVooqpvRybiPUeh8zr0etEcZSwBK2yhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gCBPmKb6BDo+hi4fwxAhnQKMn1ewxL0KMetUel2lSI=;
 b=Q/SqIn3RReaTKaa3ubLwgURXzXYwp8OSsHFUZOffHSUEhdF3RVVSLmOf8aeleumSJHaPi5Lg7Zxl41FA/JHiiLFENlYIkzOzpWDLzB3+x33eLGbCIyBT093iPweWj2QX7O4Q525v9ByBK6MbzWkPMyPXOV/poBl4xg00JM4XCtCjlX23Jx8JzcuHYenM7oegD6BqdtL40SwB0xamiGgB39X/IRKI9O6fFrdmbltKP4ZgNlb+oNFhn6lyTR680vhAgvDIQLIcE5MZMjTQWkuZFSYTeQ/gvOqst52X/tDUnhO4Guyi2OucoD6iV6aHnCAm/IRTh0f/P91+7t5pUUvaqg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 11/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:54 +0100
Message-ID: <20250828111057.468712-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e543af9-78dd-4d26-ed7f-08dde623a7bc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1JxdkRjSE90enNOdWNxY1B1bU80elpyY3RhT01SRmhIeEl0eWRXcy9JekM5?=
 =?utf-8?B?cnlraWtEbStiRy9YMXlOeFdhUkwzeW5PaFBOMFFqYmgxcEliL2c4b0FIcjlZ?=
 =?utf-8?B?T3RQT1diN2NwTjZIMWZ2b2JZazI4OHhEaXR3STh3SXhMTmZHclJlNjNKRkNX?=
 =?utf-8?B?OC90Q3NLeW1DanAvOUdJUCtVSU1HYnljTmtaeU5DcnRyeHdwck5KZ2o2WGg2?=
 =?utf-8?B?MjJ1QmQ5Rno4NG9BTEZsR2xnaHRXdFQrVVBWa2J6ODJxa2ZSNnNJVVZvNThH?=
 =?utf-8?B?SDFuc05aRk5Hc0hsR0Q1VjRacmluUE9VMGNRUEtRSTMwMHlUVEtER3pTNmVE?=
 =?utf-8?B?RUxSSVZEZG1PUVNWUFkzSFNyaTY5TW5MQldYYlArc1FaZU5LOHhHRXlONlhR?=
 =?utf-8?B?Nlc3Qkt5NzY1UktEbk91MFZEUXZzbjZOdnJFckFJTTJVQ1F5WHZlVTdKazU5?=
 =?utf-8?B?WUFRM2hsSGJzYWV3bVVtdEJXZEVOeUlxK3VVdkNrcHgzc2plQkVJZWJtcUdX?=
 =?utf-8?B?ZEl2K0czdnJxb3JmRGwvRUNpajdNUEhhQnRQNktnamIya1ZzMzBKQnRFbGNJ?=
 =?utf-8?B?TDYyamlhUm1XSTk1MXNkK3JUM1hBWGd4WkdRaXgwSGg0WHhkTlN4aGRFYytL?=
 =?utf-8?B?VVF2c29lUVl1SDM4bjhVNGJFaVJ1NXJFSjVHaXlZUXdNbDRZb25IL2VDYUxJ?=
 =?utf-8?B?R05tOUhERE5ld0w2NjZSQmhHTmRCamtSK21nbk44UmFlcTdzcFdmRTZFVVNn?=
 =?utf-8?B?a244NEthQUZzVjZvdzdLc2Fnd2FRQzlwTjluNTlqanpveUwwZEwxZDJUYmUz?=
 =?utf-8?B?OUN4dERSZTJqRGdVR01yVytyUDA3VVh3dnZObmN3a1FiWURFaXNvQ0Jpd1pV?=
 =?utf-8?B?Q3ZTKzZRdFJBU0hCck1LSnVGOUpVSFl6WmlJb3RHNzBkVjk5SWhMcW1mbStW?=
 =?utf-8?B?WTU1TnlJTzJMdXZyU1J1eFd2M0NHT2ZBMTBKVDJsUGdGZTR4U20yYVV0Ynl5?=
 =?utf-8?B?Vjd3dE80ZzJGQXBOL0c5ejZOc1lZVkFxbnQ3V0x2TTlBZlRXS0N6aXR3QktL?=
 =?utf-8?B?S3hUOE5Yd0NQbFUweS9LSWV2SlZ0OGJEaVhDMDVFelI2SVJ0N1BieTB3R2NC?=
 =?utf-8?B?cjQyY2pnUVp2YjdzTmxrRGVOczNFVndETXd4UTd4NDFmZERhT1phMyszc01z?=
 =?utf-8?B?ZlphemdWR3k4b0VIcC8yZUNMa3VOVWZZaWw1SkdETFNrTnhZWHdLSEdTWjQw?=
 =?utf-8?B?bVMvMkRMMlE3UGxCbW80emNZclU2OFVNZkV1eTBIMENtZ05CcS8wNTBkUDk1?=
 =?utf-8?B?dVkxcFlod1FlT2J3cmhxazdEb2JFSFMvYVgxVUNKcXQ4RUt1N3NoZ0xPWFIy?=
 =?utf-8?B?M2N3bnF0b2cvS1pmOStHbi9HT1ZneXlUWlRXaHoxdWJYMStGZEpiaTQyUGp3?=
 =?utf-8?B?TUJYL3Z5R0pYWE1wMzN6SUM0UmpjWnNHQlhwVkhHT2Y4L0EzeTZwTEF5a0RX?=
 =?utf-8?B?b1V6aVl0bWpzZDZTUmlyZm9HM2NFN08vcTRYSlpsTE1HenZzcXpKRUd0ZzR6?=
 =?utf-8?B?dVgyeUMwZDVzRUMvQnBGS0NhTkZqbzFYblBBcWZlaXBUblpQbnZRQ2xnQnpF?=
 =?utf-8?B?VHBFRkgwaE9rT0pLUlhaT0ZVRUErZ1M4Ryt1a1liRCtrVzFITHRQaTg4NHRO?=
 =?utf-8?B?U0cxbUhWQk1XQTh3VmRNeko3UjVhWlRicWEreERDekVVZHk5aFZuejlYVHBa?=
 =?utf-8?B?ZDRCcklGbFdpZE41RVVqVUduMk9LTmZIVmhpOXJTSGRYZDFqZ3hIbDV6Z3g4?=
 =?utf-8?B?Y081YlhsQ0RkWTFXZjBGRzBLekJIaXFlOVh4SHFtZmVUdW9pOUg5YW05dXZs?=
 =?utf-8?B?N0J1OHEwV2RoS3VTaW5uWEltdEpqV2duaS9uajF4WmthV0xxUnlScGRTZktH?=
 =?utf-8?Q?Gdi59spa5+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRERGhLNmM3UllQa2xqOE5GL2tyczRlbnpiWExaTy9aMzF2YU5oQnovQU5s?=
 =?utf-8?B?bVBxMXNqMnErSDh3OEdMUUNxY1pDaW9JdDB6cjMzZjZFVjZ5b1Q4bjQrQ0tv?=
 =?utf-8?B?Zk9wak16WmZqbUwwMnI3dkhOcDZ2L0x4ckc2UTBOZ2lmakNCR2RkalYrQm5l?=
 =?utf-8?B?aDRrRjI5YmhUUC92OTU2aVVhR2tDeEFFcUlrUGNFUFZhcndBelhSTGt2RlFk?=
 =?utf-8?B?bzNHWEZBcVhreE5ZUnNENVUrTmRuSmIrdkFucHFYczhLR3UvZU5xV3Q0OU1Z?=
 =?utf-8?B?c1NFSEVBOHNHcGNtbExzU2l1MnBzNEdVTElwZE1WUGd5UmxrMFVZbFNyOEYv?=
 =?utf-8?B?c1lrZUxudGtnY2R1MGV1a1lzczJDVmVTTG5VVmVTdjJvT2lRdSthdGRRRkxm?=
 =?utf-8?B?dFI0SGV2azR2T1FjRlo5MjB6MW5aTVhaTGZYUHRPdTlKZmtoaUk0Vmg5SDhq?=
 =?utf-8?B?SWk0NFE1bHlSK0RvVnJUVyswcWFrUnBJVjhpcHhhTHlVNHRPTW5lWmZxTEhO?=
 =?utf-8?B?REZCZ3FoQzdWT2cybFEyYmc5bldtWFRodnBKbmN6eDFBb01jSmJnRzBIbjE5?=
 =?utf-8?B?RFJ4ZmllaWJwdHZ3eFlob09xVXRjK3NvZyswZDFocDAvNUJiOEVFalgzU2tC?=
 =?utf-8?B?c2pNZWRvc29sWTVjQ3V6RTNSdnJuQ2FKbGFqVXkxc29uK0ZXNHZodTZ1R1Js?=
 =?utf-8?B?OVJURjRPa1ZHUERhSlQ5a01HVVpUdStWRmNPQ1pjeGZzM0NrK3VzdGlHVU0v?=
 =?utf-8?B?T05IVEZoTmxrd3lsU0JwaThzTDQyTEUwK3AvNHNaQ0YrRVVpZ3Q5RkRQZDhS?=
 =?utf-8?B?Z2NXWGZBZ1dzTTJXNi8rQ0dqZHd0Qm5Wem9VOXlsenU2TmY3YTdxMmYrWHk2?=
 =?utf-8?B?SlBhUmV6N1hQSnJtWjVVYXFQWXVJUzRnN25keWFjWTFJaGZpaHMrbmhiRllj?=
 =?utf-8?B?dmtEcUxib2czTDdjOEpSRksvMWF5aUs3TXl4M0U1c21sS2FlNzVzQ2w0Z0Rx?=
 =?utf-8?B?cGw4T2JpdFRXaG5Ra2FzU0RJS25OUWpKcGpiN1VFdElVVWgxcW9DK1ZPOVh6?=
 =?utf-8?B?bnFrL1dmQ2xRQ1lzT2QxZjJjNWFucEo5NTc3K09RMzZiNnkyYlJPZVc3ZE9J?=
 =?utf-8?B?M3RGOWRaQWhlYU5ZM1dIRlFNOVIvY291djBtVHQrdEVQUjErTlJCMWlNRnFL?=
 =?utf-8?B?RXhuYS9udlFuN0tST2tuMXpBd2Fod0dLU3E5NjZSQXAvQkFBSVVXM3VOV3U4?=
 =?utf-8?B?RnZldWN2ZjNJMngrYVdhZHdZTWNHUm1qWktSODI1WDAwdTFCRDZZc1VTL3dG?=
 =?utf-8?B?aVQ2bDNIOUJDY09uTlZhVGJ0S1pXemV5TmNYaFR6RU1NTld2NFlxOCtVMUpJ?=
 =?utf-8?B?TUJlWUxXc25KajJxcVhma2JObkY0ZTEvMmdOYktKUys3RU45eGZBbkpGWkM4?=
 =?utf-8?B?VXhVOG8yK0pjQzlnR2N4VGxTQVVTaUtrUVV2UlFRaG1IVlVWdXk3UUZhS3JX?=
 =?utf-8?B?UElLYi9MTVI2Njc5dDVRS0xQWDRjMXNNeXdYNnlJMHdTMFFPZjc2Yi9kZjBU?=
 =?utf-8?B?YVl3M3FadnJmZzh2ZlZMZnR1bFRydE1xZk1nUDdDV3JENkQ0UnZaT2QwU3di?=
 =?utf-8?B?eDVXbmJralQzeVQrcmF0QkZkNXhkelBGYzNyV21QTUJoK0Z6cWpXU2czUWV2?=
 =?utf-8?B?WTU3N001MGYrWlRNaU5KMFZtSytxWXFGcTZXUkRpSkdsMjB0R1NPQ3pNLzZ4?=
 =?utf-8?B?TVVlalNGa0lBekVwMDAySDI5WjJKd1BTbEU4SzZCbE0zUGtyWis3T0E3MVox?=
 =?utf-8?B?Z1VDN3hXV3JjYWE3OXU2aW1pc2V2YnF3aVRaVEc1NGZQVGgzeE5XRDhmMWJX?=
 =?utf-8?B?VnMwc0NscHJRYWRNeUtyaWszS1JVcXNDMkV4Z0RmT0IwVFVVTi9rckZncG5Z?=
 =?utf-8?B?VFRaZVJLNkJ4d1FTTkVnSVFzS0JzWk5IOUZ6VHQvTzRsYnAzQUNNWWF3bWcv?=
 =?utf-8?B?bDlyejQrdTBpaWhsUHVtUG9tbHU2NGxqMlJSZVdEcUFlRkNlT21QOUZxbjVq?=
 =?utf-8?B?a092eVFaWTNTek5VbFQrclowQ3JvZ3BySUUvdEZnaDFYYkFaUUhmMHlWZ2Fa?=
 =?utf-8?B?OEpkaGhvT2VTWCtac21ZQm5oSmd4aDM0YXNTeDUvaFF6QTltWGR2aGRVSGx0?=
 =?utf-8?B?R2tQeDlPdWxrZm5JTElNRXhLYldtTWlCZVRVSTlISXFPa1pzZlkwVWV3ZkI1?=
 =?utf-8?B?Um9xcTBmSy9PL3Boei9pd3Z3Z1pnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e543af9-78dd-4d26-ed7f-08dde623a7bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:37.0772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moxcwZ11rFNdhALBTN8+xLv3/YMvzFcNYHFB5mAxV/HF22Ies8B36/vcHzyKFWmB0GZt/q3DJlI5CPH5okLvDVZ+AnQUY1ur7HQgXGj1By8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX3BXrVL4jxaY2
 nRCDCUHjnNHos0EXMw+2HQ+Y9dTM/zhbDtlh7aYAjlCSb07awJWALIYxpXkGk7xBW2MPzBJrk9R
 ywTXTLXVJjiasF4tcBoGJFKtgKAQGa9qvygNOIVElnYbmgCbPmWQ1xP9lHdHKp68hOJVVMn9vGp
 95ZUHHxN/VcaSv116J/la5pSuYl+kY9PGiR1sQUX/4+iZ3or/WNihB8qUuxLllKpSbvgL7tA+mI
 Fc6N/D1Bydba3ScuE30MUIXaeHgO5bdZk4fqpoXOVcv46soI+3ZBi41Pr+U/dCDiIeJgvWUqblt
 9TSH0SjDQDVldRtOPHNb377swWuvoriy9pl2xaca2SGyOkW3b4IJ7BmRgbXffA=
X-Authority-Analysis: v=2.4 cv=JaS8rVKV c=1 sm=1 tr=0 ts=68b0396e cx=c_pps
 a=Qy130IFfx9qnCPISBCfGtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=6UsSGvHFbd2T1CAoJbIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yddBwrHaM7pBgPuwDbQVB1lg07LZDqaI
X-Proofpoint-ORIG-GUID: yddBwrHaM7pBgPuwDbQVB1lg07LZDqaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index daf63a326b..0bc033943c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,7 +445,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
@@ -480,65 +479,16 @@ static void pc_init_isa(MachineState *machine)
     }
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 3.5 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
-- 
2.43.0


