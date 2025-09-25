Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B0CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kDU-0006Un-Ql; Thu, 25 Sep 2025 07:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDE-0006R7-To; Thu, 25 Sep 2025 07:32:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kD1-0008Hf-SC; Thu, 25 Sep 2025 07:32:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P6KwnN2477769; Thu, 25 Sep 2025 04:32:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1VpGOOEXOppIP
 KIwtLxCAxMSkRKMRSW9EriRWFuFaq8=; b=cXAq1YeevHtP4PHz/yzoVjCaA7yd1
 wf9WLfpjRQqTxY0VQ9+AczB92hQ1/M8ODcgI0YuCJlI2axPhqx56PdllDVZASScq
 zw/siPg3bIcqprgVTHN9VVhoqOWwmbDEdbUpHnHxaaKvyaCbaFUmjdrZpQFoB3TO
 /lfbFWSMnrXUbsXUTVFCTfGlMoE4ugD51e1iH/Ku3wK6TscwK1d/t7yWusrHUtWr
 qgAFSsu/Js5jq3WtYZCB7DpSJXWo7AxKKsXcJnnXCzaZ2s/7c6BtX7AQg9krhgKQ
 9T+yNlAfTp9UpGpwGgdTnjI6VNIEsfAjgbQ26BMfRzddY3lMffe0yvmVQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022139.outbound.protection.outlook.com [40.107.209.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49cmmuj5k1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHJP7TZvNWGa27v5yLvoaH5icvuvQ5MbI0UGYAOeDxzsdfCS5CJXdAm2IyXxv5hkrIMtA7mYU0wVwJ1HBIYi2j8ry7FakoXvzE9pYOqgvKgnP8iShAmRjaiZhJbilS8M5uIemS9mjbXjRjNHuhnvxSOezuDqdDOWSHVVk1gsc9mc05ITrtjjXYeFokYNPInef4dv/TY9BizC45JoiJiayQJJbAIWqr3sM5hVsqbvm8fvJa/pJC5lzWqeRNq3UF2RR9Yv433D9dGSxBEKyCtVIVjd2sBaTgRCoh3RNgik64HCuhkAXcUGGnlWYd2XuCzPDuLhyueHrXXyllCkhQ3EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VpGOOEXOppIPKIwtLxCAxMSkRKMRSW9EriRWFuFaq8=;
 b=w2AMk18lxAXg0L3O4SbcefWDvDGAgVH2/M43km8c4CFnXoG9J0jbHaGfP3P/pxgHj/KpnlMDTm5kFArIkAQI6/fHWgiXuhZaFpMbOlqGj0ElGDZO2V2Gu/vMjqI4JHBoK0HEfCmMKfglQfFuQY8mRbHqBRdRyRoMoMqKA8e2gbs+9LAV7nZcNMJMiOZx4Jrk9+8BrokF7D7E/o47yGhCc4ZxYx1hSC4AHtDF0XE1TdcXfBzBV2GHF7PksqsqokqwIgTV12o416jx7qi9I4rONzmIbFNQNMqGCpqhUMAcs3VZhPvbR5aOK4JOnbbfJJ29JSxhwRLRvdQw471faNyD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VpGOOEXOppIPKIwtLxCAxMSkRKMRSW9EriRWFuFaq8=;
 b=nGl0n1r1kEYd2a9zwI9uSna8od/9h9oJ1Khdw/FofIQUfGNSPxNcZv4m1qY86+Cd4obtjlQi30PC/JDI7MPPwO4bBvCQZt2/H8VNWgu5LWFOdVDv/cDyCmq4hozVjfsKYxv3oX4Y4/yWtnppaQRhW5j+iMgGwR6s4nmgz5PzxCwRF3k12fsc9WrVssz5ix8lZU60eCcV+gfaO32Eahs6iOrKQ9FRZEvDf9i4qINH+y2qP++h33sFcFhxOvKz1VwDYk5zYEFGgGKebLpvDFkwh28lpScI7foN9/eeDjaNknR+vt/gCIHArTR/svdedrKKZU+I89/Z/04+Oux07YuDsQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 00/28] vfio: improve naming conventions
Date: Thu, 25 Sep 2025 12:31:08 +0100
Message-ID: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: b25959cd-5e4b-401c-a386-08ddfc2725ca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDA5OXduMitkMGRNcXlGMU5JQ2J2Z2FmN3hPK085Vnd6SVBTck5CMk5yUUZU?=
 =?utf-8?B?SFpiS2ZPdDdjemZxNHFtSVNyMlJ3OHlIVks5Qk5lMzJ2SUUrZFc4NXJtc0tz?=
 =?utf-8?B?MlBlNGVac2tZVjdsL0VCeWdnMVdidVNmYkhPbFQ5cTA1MlJiUHF3aUdmMWtF?=
 =?utf-8?B?bUo5M1NsMFNQSW9JSU0vaVhQNTJYdkF0cHZsTTBNcjY4OXJ6ekhWVnpaMWYv?=
 =?utf-8?B?T2lpK1Nza0w2VGs5MldpTTAwK0Zac0NHVFNYRlJrMlMvTHFYL21HQys5TmRM?=
 =?utf-8?B?WldHc1hxSHlWa2I0NkJnaGI0S0xsWmJ4a3VoWWR3UStGMlozaUJodldMTG9E?=
 =?utf-8?B?RVE0VktOMm05K2Vwa2JHTnlKZTNWZkd4YldpTEFLUUhVWXNOeGdBem5pQmNW?=
 =?utf-8?B?MDgvSy9DWisyc3REVmVCTjhPRHhoanAxWnlTNGhxcmEzdEhrTSt6dkloS21X?=
 =?utf-8?B?dHNrNSs2WjgwQ2NRbWx1Zk1VNytua0cxOXByNkkzMUdXUzVGTHNHRmNlclA1?=
 =?utf-8?B?MVNmbnlyay9PS0VuREtOR1F2bnQ3RkpDWFlScmNxNlh2cWxvZllDdXFmNHBj?=
 =?utf-8?B?UGdadlo0Unc0N1dBWUE1WWFiTTNYL2tFMStqMmd3N0hQZUx6WkJmOHp0R3VB?=
 =?utf-8?B?WUR2T0tRRVMzWUVmeElaOFcxOHdYcEk4bmwxdkw0ZUU3ZkI5NWYyZHVGRzZF?=
 =?utf-8?B?SjI4K3lzY095SWwvbE16M3dYQTBYZXRVVUJteUV1NC9XU2dzbG5Vb0VxWURW?=
 =?utf-8?B?Skh3em8xcGRnNkt4Vmx5cTVvczZ2RFpsOXdGT3ZjWnhVblBUN3lEdm8wNVRw?=
 =?utf-8?B?Q0FkMWVJMW1kcE8vbjYvN0xSYmJsSllxRysvYWVSRE1GM25TY3dWejR0Z0pu?=
 =?utf-8?B?Skw5ZnJEMXhhODNRN2NFRkFXY3Q2SFJLMkJrRUlKTE5GbmQ4SThjWGVJeWtV?=
 =?utf-8?B?a3orbVhycEh5S0VOZkx6cE5ZTnJ0WmhVbUNCYk9qTmRMMFRYMkw1QXZCSUl4?=
 =?utf-8?B?aFcxTjhvUnIvNGRQakpMdXl0bGp4c0ZXRnJ0VXdjOTdGaE9UNUxJdlhOV2x0?=
 =?utf-8?B?aGJqejZlN2U5ck9uTVV3ckpEdVViZGtQYXdKKzEwRHdNK2piZHYzQXJwK3NI?=
 =?utf-8?B?Y216eUJhdWw4WkF2bWpoUlp0dldXS0xBaGRwVUlhZmZwV3BKYmR0RGw1U1Bi?=
 =?utf-8?B?UDcvSmxMZVo2YWphd3pFS3ZPUWw4c0x5QXp1L0FoaWFZbTdjNDRFcnJNMnRY?=
 =?utf-8?B?RUJmcXhBbWxCb05ucVNPVHlNUVd4NjZxc0JkQWNHVGlLd0VCb2NOU3ViZ2w2?=
 =?utf-8?B?WW94dGNkRlZQZStUN2UycGNiVTFxZElOaGJYSlRkRnFRcVIxSVBwZko2dFV4?=
 =?utf-8?B?WWl0RklsMG1pR0pRbHFvVUc1Y2c1VTJQNk1OQTZVZUxtVVVpN1pnV3FlME1y?=
 =?utf-8?B?Tm5ERCtSbXZWU0ZRSU15SERkeEtMdEhMdU1ZKytTMisvWFBoUy9MQU1Ha3ZY?=
 =?utf-8?B?MktCdVY2eEpBQXZ0L3hNTWRSdW96aFJYbVBOZVd2aXd4Q0V2bjFRbFVrNUcz?=
 =?utf-8?B?ZFBsRTQxaFhUeTZETnpBUSs1bUlTa3V5UnJsUkUzU0xrbnUveFE2c1ROU3o2?=
 =?utf-8?B?N3JnL3gvSmFDR0JtV1hvMis5NVZaTHpxT3Z1RXRnV3Zmc3ZCNDF1TmJUTFF3?=
 =?utf-8?B?RW5SREpxZ0U2NUl2VmhrQUZaTlFyYXFPbmd2bnVBU2hyaDBldzhLVTBXSTRk?=
 =?utf-8?B?UTZzckk4d3ppM0J6a0N3alRFbUdlc0xvQWsySnY0WUYvMVlUSnNXOU5Eelc2?=
 =?utf-8?B?QXBNeGo3Rksxb3lHSHJCaDZKZGdwc1A5Ullyc2E4RFJxbktnZjdxby9QUmdK?=
 =?utf-8?B?WmZGM1hJWGF4c01OV05tbm84ZzdmYjM2NXRja1BIQXFFbjhEUE1KNHNGYjNS?=
 =?utf-8?Q?COs+XyNEs1pc3X8uLm31G6h8VMDkngoq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElNODNCWlQzU3M4eXdMVFpIYlNTV0R4V0FOeGNldUlOMjkwWFVibEc3dWV6?=
 =?utf-8?B?dkE5c1I1N2pwbmh3L1hFSlpzSGZZNnEvby8vemJjZHF0WTN5YmpHOWJYNGZo?=
 =?utf-8?B?Vll5UkYzNFFDWkloWEtjdXBwcFRhY05NeGFEUFNpejV6M0xUMHY1Y25Fditl?=
 =?utf-8?B?dGhiRG1XYzF1RXpPcUo0YmdLbXVIaXFDTUY4T05tcEw0ZDE0TzF0VE5ZcDQ5?=
 =?utf-8?B?dGVEVnp2bGFrL1RTT2U1SGhKcEsyeVRIQXowNjd0Y05zNWtqdytxZGpOVjE0?=
 =?utf-8?B?TE9vMWpsdjc0aC9TMzNZbERmRUJwbXFmQVN6L2xubWdKRmMyZzRNekhiMGZu?=
 =?utf-8?B?dU92dmswamE5Y3A3M09CL1BTQWhwSUU4eXVRZkJqWGQ4dTVxaHZpWlh0UWY0?=
 =?utf-8?B?VTZ5TEQrR1VWMDUvR1pvcE1yUWcrNzlnTExjN0xRV0RoVmRIcGNlTmFYQ3lj?=
 =?utf-8?B?SEdFdER0ZjRiS2F3dytCVi9nQUtaRkZDMHhTZk9rZnRNMlhyZmlmd2xjMEVP?=
 =?utf-8?B?Rk45MEM3ZDl4ckM3ZktIL1JsQmdaNEZ2aVNnKzlORkFuNG9YOGFZazRRejhV?=
 =?utf-8?B?NFJEc2pNOWswV3J6dGRQSWpmT3VqSWg3U285T0NHTVczaXVqWnhGTnhZWmw4?=
 =?utf-8?B?Tk5FeWJLUEt1TVhiQTFib3oxeVRNLzgvRVovWWVMdFNvSDZHRU5aK1ppaVhQ?=
 =?utf-8?B?S1I0WGNyN0g0V1dJOG1mSnAyMFM3bkJiaEJyQ0l3LysxY01scTJ3M1dDS3V6?=
 =?utf-8?B?M0h0YUVvM2M2aGFRRHUyc2FRYU5Fdkl0bXNydjBuWGRlcG1HMDAxMW9tRVFF?=
 =?utf-8?B?YktWSnNIWjV3NVhOZktkQjJJa0dpUGZZckNXV1BsMTlVZEpqeWJXVm1VSG1G?=
 =?utf-8?B?SURJZDF6YksyaVJJc0hHaTRJQWhrVmdPZWtjbEd3bGIxUFNwOGZhbnU0VnBJ?=
 =?utf-8?B?ZmpJVnRYY2JTalZUeWkwc0lEVkxXaWFIdWhpWnJKQ0FrVk1NVzdkK3BuajFG?=
 =?utf-8?B?N1hKUkhKNHlSQjlqczBMcTduUGkxYlVWL1pjQzcxWDhCTGlpQzJUNS9xRHJj?=
 =?utf-8?B?WkNuZGFDNnBKVVc3b05ZN1N1UW1Ta1g5eldDMlNSM2kyeVV3WFdNZ0NjS3kr?=
 =?utf-8?B?TFRBYjd6Qk1NNjJWUDZsRW5TU1hwNEJyM25QbFRvOEd5L3JhcjBGZzBtTVl0?=
 =?utf-8?B?TlFnWS9jbXJDd3lxZXdLZVgzRFBPalFtMS8wbTBBSUVqakRyNjA0czBHMW5P?=
 =?utf-8?B?b1BZYkJ0ZjBYcHRueUxPeHZYT2N0QWxOTXlCcWZUa3ozYnNqUzNZM1FqNitV?=
 =?utf-8?B?eUwxdEpsa1ZsSjB2R0hRN2UzcFFWUVB0UmhzbzdUcVZEa01CTXB3ZDhjbFBl?=
 =?utf-8?B?TlZVcmFvUE9sTHBWaGtWQzdlZi9EVitBRDBFcG4vYVphdHd0R2xvc3VZanps?=
 =?utf-8?B?cU9iZTZ1L1ZhMVRGa2NWOWJjYldjTmltTis2bEUzcnd4U2d4VzFDUHFhOVkx?=
 =?utf-8?B?OWVuNm4rOUxkOXlEOXM0enBYbjM0U0hhQUgxbmxnamFVV2EvNHVYNUNIZUpm?=
 =?utf-8?B?MzZQQUVHcEFkMmQzUnFDWm1TT280c2NNN3lXdG9HdnpSOERzalR1eFhOTlBL?=
 =?utf-8?B?dndqaUVpb3RXWmVPenh2UW1tVVFzeEgxcnZVNVBadFR3T1YzNGNpTFY0UGJZ?=
 =?utf-8?B?Q2x3U1BqbksvMWNNbG52NDg3a3h3U1cwaExJZXYxeU5aY0I2aW13RXBhRllP?=
 =?utf-8?B?UEVPaEVKcjhHb2xnVFZlWEIxYWxWYWNYRGMvLzEzVnJMbWVrd0IwOE9BVHAx?=
 =?utf-8?B?TTZwbUJiMmtJMFZBR3gyOWNyK1VLa21jV1hBRW5iVGZ1dDlFWFJTa1RwYlNW?=
 =?utf-8?B?WHQrbGp3SXhEc2hmL1poQXMvQjJmK3hiN2FhVlVZZXJyb3JGa0pOSTdBcjVx?=
 =?utf-8?B?REkxNkZxSG1ycXBpMXdza2syVzk1ZkxsRk9WQnBBNVlUUWU2TExZWUxHUU5x?=
 =?utf-8?B?Q3hXNS84QlhScSs2bVZ3clhodnkrbVI5V0YvdmFqdjdTTHJDRDlQSFo4ZlE4?=
 =?utf-8?B?YWpoZVFoT0UrYW5PWVNtbmpYK04wcVVnV0oraXFQbFd4MGJLdnh0ZFVISmc0?=
 =?utf-8?B?bExCZWVEeUZ1RXphVVoxZGtqMldjbTE4YXpYSGNuYld0U0ZuK0I5MWlaN3lu?=
 =?utf-8?B?LzlFcTY0TWpGZGNVSzFzbWo0QjV2RkVrcThlWnpxY2VhYm84R2tyZys4SGhE?=
 =?utf-8?B?bFp5NHpJV0NxUlk4dnFlKytaNVRRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25959cd-5e4b-401c-a386-08ddfc2725ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:02.8672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzscOj3la6eFY+Ri4+G/AdNNMQ2v+wSI1kJtjp24VqniDzd0c8Tg4LxHj7tS6Acyk7tPFwPLDG4qT9PEwI8n44TBiOG3belAEqDl2RPhNV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Authority-Analysis: v=2.4 cv=RpTFLDmK c=1 sm=1 tr=0 ts=68d52836 cx=c_pps
 a=A91p8pFdSY8iZOlwlHItIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=Fe0q--kK3ZfkNOsvHwYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Fy4muWR0x7xQRZZg9aRGGEM8VNJ4UzqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX4p3Bu/gWf8Y5
 WWh+k39+IPFGqoCxK6qMWLDXKceKMW3I8+UWgL1QT7PCU11vRCgyQ2xvSyrahpOEAJ+1TyGIu35
 msFXjl+fNPYImArK0Uc7nXJpmgKH+0tKtwP1VAX4khZKqdF0fZpXCqiaB+4m8RbhGzbmR8lTBW3
 FlXNi8J1YngmVbC1z59r9TB4kbuthttNB/Lu1F4kKdtR6wdYNgH49WsBM1FfslNcouoOUB/flu0
 BX6W+OQfVgAZlBB0wmRr3BrKCGtg49RIrbHu4G2IWwVI81YlX2bIgl0Rq4NLMUfKko7IInMgqsm
 1hQPVUHCzRx6JaUVUVuQH0ysmeumzlhngywiRIW7OJ/ngny3FSNbeQ/BeR5onE=
X-Proofpoint-ORIG-GUID: Fy4muWR0x7xQRZZg9aRGGEM8VNJ4UzqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series aims to further improve the naming conventions for some
QOM-related parts of VFIO so that it is easier to understand the
object model.

The first part of the series renames VFIOContainer to VFIOLegacyContainer
as the existing name is misleading, particularly in the context of classes
that are derived from it. Following on from this the VFIOContainerBase
struct is now renamed to VFIOContainer as it represents the parent of
other VFIOFOOContainer types.

The next part of the series adds some extra QOM casts that were missed
from my last patchset, which then allows us to rename the QOM parent
object to parent_obj as per our current coding guidelines.

After this there are some more renames for various QOM/qdev declarations
so that the function names correspond with the underlying QOM type
name: this makes it easier to locate them within the source tree.

Finally there is also a rename of TYPE_VFIO_PCI_BASE to
TYPE_VFIO_PCI_DEVICE since that allows the QOM type (and cast) to match
the name of the underlying VFIOPCIDevice struct.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

(Patches still needing review: 28)


v2:
- Rebase onto master
- Add R-B tags from Cedric
- Update patches 3 and 4 to also correct the include header guard name
- Add patch 28 to correct the include header guard name for vfio-device.h


Mark Cave-Ayland (28):
  include/hw/vfio/vfio-container.h: rename VFIOContainer to
    VFIOLegacyContainer
  include/hw/vfio/vfio-container-base.h: rename VFIOContainerBase to
    VFIOContainer
  include/hw/vfio/vfio-container.h: rename file to
    vfio-container-legacy.h
  include/hw/vfio/vfio-container-base.h: rename file to vfio-container.h
  hw/vfio/container.c: rename file to container-legacy.c
  hw/vfio/container-base.c: rename file to container.c
  vfio/iommufd.c: use QOM casts where appropriate
  vfio/cpr-iommufd.c: use QOM casts where appropriate
  vfio/vfio-iommufd.h: rename VFIOContainer bcontainer field to
    parent_obj
  vfio/spapr.c: use QOM casts where appropriate
  vfio/spapr.c: rename VFIOContainer bcontainer field to parent_obj
  vfio/pci.c: rename vfio_instance_init() to vfio_pci_init()
  vfio/pci.c: rename vfio_instance_finalize() to vfio_pci_finalize()
  vfio/pci.c: rename vfio_pci_dev_class_init() to vfio_pci_class_init()
  vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
  hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to TYPE_VFIO_PCI_DEVICE
  vfio/pci.c: rename vfio_pci_base_dev_class_init() to
    vfio_pci_device_class_init()
  vfio/pci.c: rename vfio_pci_base_dev_info to vfio_pci_device_info
  vfio/pci.c: rename vfio_pci_dev_properties[] to vfio_pci_properties[]
  vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[] to
    vfio_pci_nohotplug_properties[]
  vfio/pci.c: rename vfio_pci_nohotplug_dev_class_init() to
    vfio_pci_nohotplug_class_init()
  vfio/pci.c: rename vfio_pci_nohotplug_dev_info to
    vfio_pci_nohotplug_info
  vfio-user/pci.c: rename vfio_user_pci_dev_class_init() to
    vfio_user_pci_class_init()
  vfio-user/pci.c: rename vfio_user_pci_dev_properties[] to
    vfio_user_pci_properties[]
  vfio-user/pci.c: rename vfio_user_instance_init() to
    vfio_user_pci_init()
  vfio-user/pci.c: rename vfio_user_instance_finalize() to
    vfio_user_pci_finalize()
  vfio-user/pci.c: rename vfio_user_pci_dev_info to vfio_user_pci_info
  include/hw/vfio/vfio-device.h: fix include header guard name

 hw/vfio-user/container.h                |    4 +-
 hw/vfio/pci.h                           |    2 +-
 hw/vfio/types.h                         |    4 +-
 hw/vfio/vfio-iommufd.h                  |    9 +-
 hw/vfio/vfio-listener.h                 |    4 +-
 include/hw/vfio/vfio-container-base.h   |  279 -----
 include/hw/vfio/vfio-container-legacy.h |   39 +
 include/hw/vfio/vfio-container.h        |  286 ++++-
 include/hw/vfio/vfio-cpr.h              |   15 +-
 include/hw/vfio/vfio-device.h           |   12 +-
 hw/ppc/spapr_pci_vfio.c                 |   14 +-
 hw/s390x/s390-pci-vfio.c                |   16 +-
 hw/vfio-user/container.c                |   18 +-
 hw/vfio-user/pci.c                      |   35 +-
 hw/vfio/container-base.c                |  347 ------
 hw/vfio/container-legacy.c              | 1277 ++++++++++++++++++++++
 hw/vfio/container.c                     | 1325 ++++-------------------
 hw/vfio/cpr-iommufd.c                   |    4 +-
 hw/vfio/cpr-legacy.c                    |   43 +-
 hw/vfio/device.c                        |    4 +-
 hw/vfio/iommufd.c                       |   48 +-
 hw/vfio/listener.c                      |   74 +-
 hw/vfio/pci.c                           |   68 +-
 hw/vfio/spapr.c                         |   52 +-
 hw/vfio/meson.build                     |    2 +-
 25 files changed, 1991 insertions(+), 1990 deletions(-)
 delete mode 100644 include/hw/vfio/vfio-container-base.h
 create mode 100644 include/hw/vfio/vfio-container-legacy.h
 delete mode 100644 hw/vfio/container-base.c
 create mode 100644 hw/vfio/container-legacy.c

-- 
2.43.0


