Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29D9CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHip4-0002x5-1F; Fri, 16 Oct 2026 10:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHioh-0002UG-1y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHiof-0006hd-9Z
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:50 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5MK73333355; Fri, 16 Oct 2026 07:21:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NJy3zo1QGJbOmTC9Nz3fMdmhP79c69OYBgxpmQByO
 zg=; b=0UeB+o5JVvwAIHNsTp/bwwTAtkbmqTIGkcCYXMH2oF1KW+5ZtE601mUbf
 qMQG/lFr05axS0orvAhw44yQStcy1KGyL5HxlFlAcsFNwHX6w8T0wE5RMpLMayAe
 2gE2UwB4bicOnITPntqzbwyuU8PUbwcnm5UhZmA6OdTkPZcIPKvWR7Z3Bo9nUnCm
 a4T99fSM1vwjE/8beflO3TRDSbZLFOlvnlLqBmDl3fbwPYg04KceFfkOFelcLCxR
 hcd6Dfpt2qkU7FDyIbDhnGGa3Pz9nzwyOWOCFkLVv1uyzDP/Y47Ea3wPrWBZKF6u
 BylspXXHToL9ZADKs0+nOdbpQCJUQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020128.outbound.protection.outlook.com [52.101.61.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4haukukqe3-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ3oWxJwhM7Qpk5pMWpgYbfLduSldIv3x8R2T1mkLAyyS6/ikYmLeEp9UbbtmVFaPheDTzcj3XOILtIwr2ovjQvaofWaHS/3H4eaus2CamLxz3uK9wia/pGvbIyJp2+zXTkSc8E/qCkwslyOjy2yo98OFYY4Vr3BYKcAUSF2lG9KUGeZG+5NvdEmT0PSHr66FO3Jv8CNHVj2bmELoMgBz6v0N7fIF08Fb7luIEI2XqU7HymWNgK7duD/hgo6wTzBDoBbEPj1tgQWtnflyrkMDAE9vNGRBqarfUF4LwbVvHfcV8qYX6KeNyacLHFD4Ftt1ti5FfMvjyNioEPfmV0BVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJy3zo1QGJbOmTC9Nz3fMdmhP79c69OYBgxpmQByOzg=;
 b=IzG/nmENbPwLD+VoOPjvLEJ0SJ9sH+72O3XIeiqFj7I82dzHBvVwOROi3242f9rYdV8NHQDwChw+CVjMf9vTQD8PdjeqO4XvGGA5FDMgQ+f4exx0byTsyspDHg7KpAi9Xe+G+L9mMHyUiL+5M98FXsl2zQoibOcY/Tw94S0yD9zZUshfgNPJ+Pn93bC6uRoUrOFospOrGr1PXs3d2L1qujYj1p+HmTl5GqbSHFEuK7jA70+UETWeY+TcejYOsKHZfzy45KkUQtqaeNM1bG+Ubmxd+CRhkLUAVgDe7LRhHVAzMM24b2wUV7lednYA9xOmYpjHBMXxygjjgilOaPrI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJy3zo1QGJbOmTC9Nz3fMdmhP79c69OYBgxpmQByOzg=;
 b=I2iXPb2qdYDyKMraw1+TUbpfz/Vm6rofJmMmNGTihDo4yOzenXaFZQ7wx66auG17++23dChhhLykwcEId/5NlrupudzQVWg7ufPWH22KQX+MnSxklcfPmL0A688oHbHoFa+xYLHj37LnJ+SOETLh3Ib7D00xfYuzFexJgl268mZ38Gyz/IhDmciCyF672jezrlU/QAeWTNVVMpEfnaGTbYqGSDRe31C3iZ7KPskfj5xAzL0x1rUFuNQ6tzsueXXDNqRK/mJEunouaCKVEbltLXIbkz7mZdhVEJIjwIjyuHS0RKp7t8Ek4CD5/BoBow4QnZI0tPZMYNwNzJFcaiaDSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:21:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:21:09 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 08/27] kvm/i8259.c: rename KVMPICClass to KVMI8259Class
Date: Fri, 16 Oct 2026 15:19:14 +0100
Message-ID: <20261016142031.1204281-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 33373cb9-e483-46b1-0bcd-08df2b90b90c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: dxG6F1OPyUm8vdw1mxIx9MuDKm2OlcMJbI25AM7B9M+3t0Ts+uTzQtoiJjWKT0lMHQap4rhfCMYxUpXMGuzdneGK2lJ0iVN9fJ54xR+W/PBEakxwkzI7cvpOb/2T/4ucWbc+zxUkbQCz3dRx2mq8DwDCVUlkHsP4siJk9TGE0NLXHT/F8S6s4mNF07yhJ+zu5TOAUseD2t1VYwfAtT1EGhdBsQoPcnHaojPAbaVJhbHc1bGuYhT9A5aBMMRN5s1LghuTEFkZmnuUGtifsPD6SWXbWHDwjw51A8dSlnvEis+32eD0d+5dz7Cg1z37u52zWN2nA3VqgCKVqvvro3uIFHLRwKE/x5NgdFy2U8uwuefzvEO6h7kq+OVxDG3s+hpUFIl+AvS3xyPPS185xzwMvgzQVZSbIZOnqbPhGPQFmipRE+JBVOmenm2FjYKdJtmRONNJiCw0s2xP8hRwH7eyQNOzXkhOcVufGBB8iiy8ISDDWmshSHZa2QmO59JHW2ulKjiSzkZNHXlz30cTfhjSLkxIS85z5BPh7r2kATOzXMitMAgvgzI7f7r0aPkLnF85Po6ieXXujWmCxNEfStf/beaoaxWpPKtDoyzpEnxCgzlUmRSN8kW5RXGHPW9rUIdWQWG4sCOAMm2LgqZHRdP0z0z3MucGqerVz9eSEmO1Rc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcDceF1y/RcQWF4yFla/XU/ejOIMte8Prx3wjVSbkdgrgj18mrD+6jdv8CgY?=
 =?us-ascii?Q?/1JIPFwlRpW6lSX3379JnMSGrhBRXMczeSWmlag1qHEZ3xBzLeZH9iXdx+1m?=
 =?us-ascii?Q?0qLF0rC1KGS3u+04W+q86UDHTvCO0OZ/JFuiMRp/QH6CrupGzYlCHZXV0PxA?=
 =?us-ascii?Q?ARMIMTKgsvIsB99UqM9ltgXEU9gRelPiuLcnCtlVX12m+2P18zQoCCs82FXB?=
 =?us-ascii?Q?XR/o1oXIZGZgWS1RtSqAccKMrnTANu6eg346Ug2JRvnF5Wa274nnfqgi/+zM?=
 =?us-ascii?Q?B7QHFgNKfc3IabGNKAzp1d4CYLg5XspAdx2GmO+nWMK4D2tpPjtRe+Vp63NM?=
 =?us-ascii?Q?WYOFjwXoaNNEdXdXarf3syMar1duDnrZvNEk0FHOCYl5G5jOto40XzmgIcrr?=
 =?us-ascii?Q?ZjT/FH7IU4aQBU/oLr5aEXwLjt+X4E5A2ZGZdQ/+W4xskg8T8622HLDm3YEF?=
 =?us-ascii?Q?EfCnBE+EW4zQ6J+fDe/O1QxbaIpsW0TMUJ6ZSVEgQ7+a8UFIGMe+qU1i6xeu?=
 =?us-ascii?Q?oHugqOBca+rnV20r3ilpLotNEjbGZoB7o3jHJj7IbW92z63UIAiqnP9NVOUb?=
 =?us-ascii?Q?UrZ/+Ee3TCUezmrkHvaRp++xC32ArxaCDbf3CxT20mvaqaB5uS1nC1pLUP+p?=
 =?us-ascii?Q?JhRWFnFqmlJyzCBG395Fyterbr7cOF70PD7r1KyazwQH5KiAPV2RNpqrnTUZ?=
 =?us-ascii?Q?IYRGoj4y1Ze2XupTXP0GfI1zqE9Iofss/BeZEBFu4lBGWWNmE6ukG7Agi03K?=
 =?us-ascii?Q?pbiR1bEcJ0IeSI9RTG9rAPrqZKn2lUNmevKJX8qOBsDIFgnIXK1GwfW4318d?=
 =?us-ascii?Q?LDEExSJgurodf/3Gh+zml1kg6jnTHLUrPq7fAdQJJvHL/9cLPRuMOtuG1W8E?=
 =?us-ascii?Q?Y/eF1vERdnNzZS/hVvfPrZHXxPxxoFYH830NRU7fNL/S9PoVY5bMLOyWlF/c?=
 =?us-ascii?Q?oLRBJQ0QE/SbrvQW8WYSiNVV1fpmzGjtW7TqDgBAYZQoIcYUwEd4NfMLadMa?=
 =?us-ascii?Q?rN2XS3kznezF1sta0POCJ0Rdeu6BOtpNq0Gpuw7qahycWCxDxOOwxnN9MBAN?=
 =?us-ascii?Q?ksWpNVc6JjThKhIbXXDgHwXmscxKDp+O6CrjsJi1+ooZm+DGRA1cAKYzONE4?=
 =?us-ascii?Q?S5UFq351gU9WOGVb60vfIzox5oE/bDsBza/E9fxUgQLqvmRsRt9qrzgxTnqJ?=
 =?us-ascii?Q?EH6GpUPcbsPt/eXhhjhPFZgAjh5czDY+lWEKcTnvBrlEB1LxgjxdFlgcO3di?=
 =?us-ascii?Q?aiGPWDVL6s1xclxT4Zuqvfj/rKBIVsrxOsLKThDhhvD4ywaUwsgf+dMjBl5B?=
 =?us-ascii?Q?+jnDLBPPR+D6vkligq+Lc1VYtwZc7DUctVYElxa0wypN0r2n5pqjltXAm0yk?=
 =?us-ascii?Q?rfpxsDfxHIwely4/qsQvsYDhLZwuMcV4+qolQmQTxEZMwYsJ8pN4yFw9EMIS?=
 =?us-ascii?Q?os/jPxS13nKWwKXNjHu5z7OHoyS0j0ZOWhc/byY2gvYUZjqWzdsnEO1Tqoei?=
 =?us-ascii?Q?HkYcrZ4Yo6Kiz74BI8gpW8CKBxdOsuhcs+N+nOuUE1fLHFE/a5biS7TjTV2t?=
 =?us-ascii?Q?flDPgzzi3mnp3TaP76V5S1wNLH66FE9+XqJhVXQqzEHYr9/4JqooOLZwMyZd?=
 =?us-ascii?Q?BMG9sHAxTf+O3SIdv0aCDcE2Pt0SEA7GcZn+busKzf37o42qXkAykMUpve84?=
 =?us-ascii?Q?1kVW9+kvN/obYcpvS+EKiLkiPrRwQvObfSZxtivjMx/9I1GH7awawlrBvNQr?=
 =?us-ascii?Q?+yOzaD69YJu5rChT+Ca8ZtCxuDqSN0w=3D?=
X-Exchange-RoutingPolicyChecked: DxotLSV1wYoOMBc6yNX2b498simAzzY/b6GkpptsQzuKxELPQuRJ02wq295wh3hh8TKont7wSBhaYdDxIc+bOsmsp9wkGJaXk4SRFSouNfpVj3MuIz6kP5QBsWy09kqS09vkJ+1W4yHeqhQVpzh3Sl95nTFxAOGEDqTnf8QObvz7VhHVfbHnUnxl7qNLG2hqhHTxikNu/d3HOnLNxgjfsKMPio2KfmKcGCJJHlr3//u8+cOGxERbTXF4nQJucRv0raynBZn++BADYcsiN2v1OpugnDx/zcp/oZoiY2k+Ut1A3hB09UnYArEJAYMhO6v/AFPGtpfRSmwMiVWTVkTtJQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33373cb9-e483-46b1-0bcd-08df2b90b90c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:21:09.1562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcOVAGq0RjaA5g4auKjoAwpD9xleEjYgHUTzFzJQ7+04c9+1/V2ksSe3qPbRr/Z+gW1DzMCD5o/D/YtykahWcD13EAEINc6L9kUq+aVvAeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXxiTgefN9ZXso
 E1acuOb9DHwNv7amlXTdsEcnch3GkzsY4EdYT3XbVIq+oByaP4DnJptlx27VhvxQJc39ET3PSzd
 IbwxkHk7pE1bL39KP37WfIQcdPUXpaw=
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ad232f7 cx=c_pps
 a=8h7WK4dQWB09CNKj11a7yw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=7JMAGyXtUfIWgoDCk_YA:9
X-Proofpoint-GUID: JM1mcf9Op2tkbYiwHg0N6XWVK3PZkNfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX9yMTf9Ef71Z7
 gNW1utxQvVR/cyIwy+GykxaPqdqS1s41f8t9rcG5KHv7/31ECDzXZmdrYsqPYWBPd0ETNY6xM5m
 iVhtF9vo0xiGtXtTIv9KRq1PpGan5Tcw+KZKlfsyTIHR1sOzISQ3aOIkwBdut/siD9WRC5KiBcY
 wnAOU0QyIJqhsJIq3VZUHnlvW1GR8iPIYQh6Qt5fr7Nw2ZcIg8XJ4JWUsW/rSswdlvo7dKbLLq+
 hO08euZ5t5xsA9tmN0YloFjvKZqqL9+sBxKtz46U52g0QxvE0A/Oylq+055wUXRTCU6PD+n0ICV
 aTVu7rll7TpTVsIGbGQor8B8tFw60maHMlKJLTfMHgdQjCHmOFtL4iLHvzbtAvk0RAC02lmxSRp
 EqGoOmMuVXPgDwSAbUCffMb6bKG+tISizeCfabrUKelR+yi3b7cZyRoMhtwW12vSPcBEDgadGnr
 YTXFgIVzvp4Py3u5HTg==
X-Proofpoint-ORIG-GUID: JM1mcf9Op2tkbYiwHg0N6XWVK3PZkNfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This is in preparation for its use within a QOM type presenting a single
KVM 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 68607d721d..85176dcf80 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,15 +20,15 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMPICClass KVMPICClass;
-DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
+typedef struct KVMI8259Class KVMI8259Class;
+DECLARE_CLASS_CHECKERS(KVMI8259Class, KVM_I8259,
                        TYPE_KVM_I8259)
 
 /**
- * KVMPICClass:
+ * KVMI8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct KVMPICClass {
+struct KVMI8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -123,7 +123,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
+    KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
     memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
@@ -141,7 +141,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
-    KVMPICClass *kpc = KVM_PIC_CLASS(klass);
+    KVMI8259Class *kpc = KVM_I8259_CLASS(klass);
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -156,7 +156,7 @@ static const TypeInfo kvm_i8259_info = {
     .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMPICClass),
+    .class_size = sizeof(KVMI8259Class),
 };
 
 static void kvm_pic_register_types(void)
-- 
2.43.0


