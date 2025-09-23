Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF51CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Vj-0002T6-1V; Tue, 23 Sep 2025 09:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13VB-0000cj-Pz; Tue, 23 Sep 2025 09:56:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13V9-0004OQ-Eo; Tue, 23 Sep 2025 09:56:17 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N82Xl9069647; Tue, 23 Sep 2025 06:55:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=c9z5xmH6YCYy3Z5Kt4IebbLIcxhTtA/Ni9GCd3mo2
 uw=; b=Vg/CHzaOKVYcvMO3CyKlpGLrTCmOPLbudKicHtnRZlA4usbydLiLO+yd6
 gb5R66HRBJlheuqB8LQMzQu4T8IsfV4aeHy+hktojYhe0pOO0G3eze7Gr0g2CAar
 fQuHTl8WKWWSGamANEbcCQ+7vd2WRXxffHMoW+F3cqhH85o2ICvuXLDUD3H23NwT
 C2BM/djX53pMWc8+KVYUF1c+JHXzzfhn3r3clGN2/kQF7OZDOUQktPWJ9u2r1he3
 FzuBdumoxrmPB8E3CXW07pknqeNvFPhxKL/pzZjHm6ASrH2gZ4szeRpQ524zErBq
 cWqJNKKnLBOvcXpI2aTyhE098gPuw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020110.outbound.protection.outlook.com [52.101.85.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49bc9vj35n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/SHfK3Qve1vGuy6Cd4QTN9qdiu1L2F2doO+WJvoxIp2rvtSL62OKSurNyK+WlXlFRkf0hZM8VhGAcskuICfzuj6Pk0yaE6W/3BXzLE7pIftgwoolwz8Eu/Rct07OuxW4wPY6WSSdJXovtK7Pa1ctDFrnIoUBZttwuDx5ef2AYTk/MPbGoJzWSn290Q0Ords+AI4wtnkNcGi/LDRny6HLR+83DytjOSWO8SpvJijAvD8JyUSb7J8EZ/fjhKJwKtRAmbNkarg5uFNZV7lJrp+KaP9hGhGQQXN6xtrQ0Ri7q4BNBgsTOyR6qkJilILSGDm+f2u4c9Fg8JHxwIoZumPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9z5xmH6YCYy3Z5Kt4IebbLIcxhTtA/Ni9GCd3mo2uw=;
 b=U/yuVe4MaOYWS4t6cmd+5VeB/kP6OX2qWIEpIY8xEXTOsET3elTKk7Z3vWsCiiyPY4b8Hlmwmq6vtqO22DdLk976KdCrBwtffHM0a+91Vb+xn+ESSTUhzaHPgRwjCDARssgxdWGJclh6E+NEccX10/W9emTNDktJu+kLg4YY+a0qt1+TXjvxOhHiXUyLfqMje7HsTv2tIgDu/8gOWbxZjYnqWj8A89YajlsJAao/fA47iFrHtDea8SSwCsPD8EqrH5Zp7uJVAC7icf2FEibUeHZXyghaXrMhZ0wj4JzdVi95gUX522ydUDoULi+kHoZYYR4Zc+tgyjvHMSFzabBHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9z5xmH6YCYy3Z5Kt4IebbLIcxhTtA/Ni9GCd3mo2uw=;
 b=ugfzLz1slgiB9aokaNw20/MwBEvQ67AOe9DY7FwaJjUK/9ksVKf9fg6BWZv8q03pTtdMOkAqXGSCk/KrudM5Lr8CrlIvhdwT6nptceu/1aRdyB279FSWvEABn6IPvdq0uc2mDi7yzk9Hte9ZQBQLKu4uMQaHWRPUPlKeU2K+NlrbNLG0ue3FSB+akrPS/XQoB8wmEa+mRWjQ15qhSXJSmCNyUiVTIU1ApcGzCTV5oyyoOtbAqw2EfdxBvQz6roqfks50r4YPqTJGK7X7dHPz8SlseuMww9JmvnrhWoWz3RpJ8F3AhsXn4hzIWS579eyMcXmNWWZHM9iortb2kbKBOQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 27/27] vfio-user/pci.c: rename vfio_user_pci_dev_info to
 vfio_user_pci_info
Date: Tue, 23 Sep 2025 14:53:33 +0100
Message-ID: <20250923135352.1157250-28-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0a4460-b3eb-403e-3edc-08ddfaa8e3f0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvs/v3I7Jn2MHChkDtlkxdkrCc5upk9WNQKu68qQxtnHoymIOC4MFbFbRI1F?=
 =?us-ascii?Q?T+dRAp5d/+rNdOrNMHlQ/otzEVyyCFs+Lxd+JtwCdeDetHT2WksA1Y8zU3AG?=
 =?us-ascii?Q?jhBDk2FlpAUnMAob13HBvvaB7IqCn1HF22rSKrXklKWAhE4pyuOZMmtUgi+W?=
 =?us-ascii?Q?TuV0Ba0950V0K0oWlXCN8Cj9xgYKn42b27HxQgq0c1FxRK/X9JkVOu68COCv?=
 =?us-ascii?Q?xzk8TNfDkJP4ZPgHa+PVMSUfbsEqSH6B7edmNF2nFq+0EtVJGJwA7A8goXg8?=
 =?us-ascii?Q?DjR+gbgxxsfIkeLVCulhSVhPPoh8yMzwMKfizVADtPacG9Z2Qa0v7slIQ0O9?=
 =?us-ascii?Q?tOJOclmDj058nYIOs/hL6L1r8KAj5yB/tUYi3CRvN2v9wnRVhsZXBubhvXI4?=
 =?us-ascii?Q?TEh0sBLGUBJdqqye48LBuHZyC6EwdAtp4w9tUp9FehdKWPmyUHMOgUETZsHb?=
 =?us-ascii?Q?bYr4Y3rsxIBmtgJakbClJqFoVuLBafFm0VN6DbHKRCvEo09Dq+rblAjV0MrW?=
 =?us-ascii?Q?XhdQCTiSaYkSc70t3pUxc6r6GMAmD1qpWXRRkYpGWZ+qlxvvxAGmRdjmBNpO?=
 =?us-ascii?Q?XzB1PXT9vXvl4AB9Uf+HGb9mstj/Ft4pg/UBYE2QALpWmUZnyuYOdWwGUOMm?=
 =?us-ascii?Q?oG4iOa2kep7mv8vXtnKTJqnmuFXQPo+rZHOVHzqMTLgaUrwPEK6YQkRut9gp?=
 =?us-ascii?Q?XJKZHHbVv62/6qGVJj0dLIZ0AG6ACoiZruoA0hW3YUuCMoLdTk7pV1zlT8iV?=
 =?us-ascii?Q?wOP4gsS4ZivMhXsYrxqBcBP1MbAig/DSHx4CdJL/2i48bam5zg8S0u3ntiD+?=
 =?us-ascii?Q?YLif36kZT2i+uSbZmJ/fydu3vkejVuvfLM8xs3+SfxCca8IVGV+xBgQuNI8E?=
 =?us-ascii?Q?PNH1eyB1K9qrkDQPq0MotPrMQqVh0gQPE8GmhOvPGizqvhGnefuR0D8CChuT?=
 =?us-ascii?Q?gpNWAr4+7Ij2mfov06us11OJbsWQRVGiPkCqNZYau0Ejxfk8MqJjWPiL060O?=
 =?us-ascii?Q?vFg6Fslp3fAAwBUADHLdQ9Kj2oIP1m+77YJD/aPlPhRNULSnN/0XoryjfbQp?=
 =?us-ascii?Q?iIP+gTac1kyy/7qMdlwCf1Gcm1yfSn4ssqZJgxuzT9KS0ypL5E55sBDZ3DVm?=
 =?us-ascii?Q?Xr3JPSCgkLy88C+3IMXBVRgO6Du93fWDzmMS1IoabkRvCeV0aMdGe3qT7r0q?=
 =?us-ascii?Q?6XgJg8+T1W+QoBv0yx5G9005lIyR5efN0lNR9HdzQbLZ3G/sVemiRcDNNv1T?=
 =?us-ascii?Q?kUnCr03//TZrFiouy7gqD7Ce06ldxWXBXNkfE+E/tEgGfP4YWwighkncsImS?=
 =?us-ascii?Q?Mj0ZUHeo4pbu5rHj6zrP/8HzG473BmxMXrjU++mSWkFaVFV8wSBYx5JT+q8L?=
 =?us-ascii?Q?UcugQBAM7U847jk6PRHPkgj6AxHkuwl6ghgKE2W3V9zbLAvwZ5XIWLQffbc5?=
 =?us-ascii?Q?Nqof7V8FKmF8B5C3fIBW0sIL37+hfmnIMjukMX5PUAkYg4h8bnua6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqjCr5RlanvG23XE/uVTCJVfofQUzwf3pAosZLkREDTz/IQuALYtk0hkRGZD?=
 =?us-ascii?Q?3rtQTzIz1Q7pU89+0iG+/yD5BV2qcy4MPO90fTrL7GJ1ib7mMDNIFJJvAm/0?=
 =?us-ascii?Q?/yPnSn511It83Vv2nvvSBb/JyH/TJDqdwPO/XdWHvWPzhgbGtKdbjLagB6vF?=
 =?us-ascii?Q?PZj6rT6+Y8bZhDbYXWWBmMfZp7cQ/u2VqdQ1WzMFHGKmQBZh5GCaAiYFDrEd?=
 =?us-ascii?Q?3fZtQ4jz/DKfUdGMqZlpQdUsjaw+Ydavk4Cl7vgbW5cqXrnGm+jof3XJU0ts?=
 =?us-ascii?Q?eTrfNzWox3RWHvJDR0Qczzv9dsH04er61WtxIOD91WvVUk196AjFeWL9DcB7?=
 =?us-ascii?Q?Jguwh/nFxbKRktQ5gq7bEHbTceW+2Ad+bzfoTiz1qEkkbnw+YHOxlW1+mOY+?=
 =?us-ascii?Q?XhwvXIGNyIHOklB1/YodYtuA3dVYGEIkoSLEeRXBHxx/vN4aUaF6HTTtqf4i?=
 =?us-ascii?Q?Rx+TYpYjtaBQxVynMeZuxrW7YaKaGEgia4fv8fX7aaCwTk9UV6G14nZ4v6D3?=
 =?us-ascii?Q?1nMkz4YyE/nDrLxLYfUv/PKkJFkLectjJjD88xR5rI/PenhAiSbC1HsdKQxW?=
 =?us-ascii?Q?daEz2A6rRyG1OQ0NQL+dEu9esKBA5ZvWFDqFJ5l7bcEcyVESUT1DqH7Kgp+Q?=
 =?us-ascii?Q?yRPBHsGyUmyJ1Yz/ZySOXEZeBBBxCDY1BbFKh7ELHi5Ma5sBzr321ujk9LKt?=
 =?us-ascii?Q?//q9HkMzrPW2YwT2nk/UENuhbtMSmrTwYxXBHh1HPZazPR0J5Zi+O3SfYV5B?=
 =?us-ascii?Q?/2dQ/DxI0C1KHhcyRfz2QNt3GdanES73A0brZ5oOw12pUZxtoFQSnWEfEsCW?=
 =?us-ascii?Q?WRSzCUdd28gfuOIWHeY8Kq3bqnUDhRqBUbPacncYbkEIbpkzmIY1sgYOMWzW?=
 =?us-ascii?Q?Ozz/3VwStDQ2KeDDp4LkpRq6TN+E3BxxfyQisndTHDOUR9u3a20UO8OFbUW4?=
 =?us-ascii?Q?K0orxE45fi8UHeF1ruTkZ2OWMGC/cnNEItuB7kKMhkIX3ykToOqY1hjwcsVA?=
 =?us-ascii?Q?Wm5ct3APRgPS2q8HSbhrhzOEt1rZ7GUyj841Z8Wr+reD2ZdPe1pprFwbtRWI?=
 =?us-ascii?Q?kOjoDPDBKfTjFFM9D8yvd/dPXm3q8o4IbL2HFonO+l1ZfnGsi169fGjKSnpX?=
 =?us-ascii?Q?AuKHv8M95jyiOTxGFZcGpTFtie8MqnGFvC034BciY1sUBxzgy/84/bmbhSyh?=
 =?us-ascii?Q?tZEK+0e2a0YoquJx2v4h8xTnUtJP9WfYqC6nK49drAvyHyL8IxjXBNuJnZUL?=
 =?us-ascii?Q?dXs7bhI7wxiBvIaU6oq5D6TBodXU1ilXdHmuIKVRkpMNgcSWhxBleIBLV9rD?=
 =?us-ascii?Q?hi8sgtUEo41MJkRHZLTZywIRH4eHTrVZYhqS7b8kXpgeDEyFzwpX9BWk8iaZ?=
 =?us-ascii?Q?zE6LpUTcPpMGswdlrvbz2hm4qUp81BWMp7iRQlf+ziE3BjmYzR/83cGo4B52?=
 =?us-ascii?Q?Zd0GVr87PaDzHfCAww5Sjp7XrbFS0Gj8qt23poRY1NxKLp98mLIicl+BagOs?=
 =?us-ascii?Q?C7FlgTZVLB3k8xc632huDY3Kygz7dqi4aIhx60uiGX03YtWeZL0BvA8sNOBg?=
 =?us-ascii?Q?SYUNJ3VhHTkQX+c9r6EMPaoGDqmQMgkp9FkedyOhyzZI6RZT6AuXBmbxUOLO?=
 =?us-ascii?Q?9YL2KRlwdD/7qme2f71emdDhIwLvDTL1YlXrWMi5lPbdHacbc5J2LaYM8MWX?=
 =?us-ascii?Q?4sJ1fw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0a4460-b3eb-403e-3edc-08ddfaa8e3f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:44.3281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKplgUPZD/YjoSGiSFJhfmFImza89xnrybZOCFE5sg7hSLnyKqe0QiR7I7cgdbyAgC94oL7x5pm8aOv+U6QeEnBRkFR+0/dYVjcoH8XE4yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=dYSA3WXe c=1 sm=1 tr=0 ts=68d2a6e2 cx=c_pps
 a=54yuESksmrMaP3RwvbuPCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=sLdYhChum70qGmeBGo4A:9
X-Proofpoint-ORIG-GUID: FxiA2MLTwzoKpnWlb2AQO7tDHAfAWsdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX+twzbEQJlf8W
 y+4XXI9GThlHmDlxcbalmvuu44gGJbPhwOWazkQg+/CvGHqzymr2+viczw8+aCbRG4ZgxHCInJo
 niI+3C7DWxcD+NIy1Z41SU3SoLFDgRZjBuQdOfgOp3PKB6Eeq8p0HhKMxBX3hosZbC/TqzvKVMi
 Ge9wGrAFF/XDgf2sOzF6uLx8US2H0gnJUrAIYzfJqouilq0OZfe5OY7Z4UOmOSwikmL2vUTakIW
 Rq9LUV8uM7vTNFo4qkRnn711kIRLGyLvS0S6AXJmk5x7ZitX/9GUlifTQuZKwO3nRD9DfGcD9BB
 7zo3xQCoxh5yZTh3XDGBiV2/CFTs2Oe60jREMrzuaNC1vKJYlN+47CJc7dRjkU=
X-Proofpoint-GUID: FxiA2MLTwzoKpnWlb2AQO7tDHAfAWsdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index d4f5c7b9d7..b53ed3b456 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -463,7 +463,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     pdc->realize = vfio_user_pci_realize;
 }
 
-static const TypeInfo vfio_user_pci_dev_info = {
+static const TypeInfo vfio_user_pci_info = {
     .name = TYPE_VFIO_USER_PCI,
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
@@ -474,7 +474,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
 
 static void register_vfio_user_dev_type(void)
 {
-    type_register_static(&vfio_user_pci_dev_info);
+    type_register_static(&vfio_user_pci_info);
 }
 
- type_init(register_vfio_user_dev_type)
+type_init(register_vfio_user_dev_type)
-- 
2.43.0


