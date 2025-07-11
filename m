Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A3C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWe-0005ZP-BR; Fri, 11 Jul 2025 05:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWb-0005TF-Pq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWZ-0004mN-FU
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:37 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B79cbe032134;
 Fri, 11 Jul 2025 02:58:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lAQVDGjhApLT3KTNAQprgusBIJzB0rhCV+T42QEq9
 qE=; b=BaG/D0Y0nIFzM+AqFMCOVa1hCiIRiFczyi9ibFHT21OPFSr0q1UoiDrge
 ipis32ygy0A7CXQf0ZziznlP69vF/b9uJwivl5lt7G+6vVGJjgfiSajNVNl+x8vr
 a6smVvHe0HZuFJ3I1gPYK9pPiVB+fD/tp/of4s6hCxdtkybdfpID3EJHLl8aQtnQ
 OksguaGYDvOFP2f9TDwEj30nXINt/pZDxk9uDkEuQcEiseKpT9cJ9V7UjUu1XO7I
 1OFGr3upJ46di3oo4M8tP2b/+TT4Dl/KFQUdK9BOEkri6PBPaFsWMaHSZhX8Mk/K
 mRj3ConSAqod2KlQ8ote3ixiwRiEA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkKNWJkAjqUJsQlJbAQIFOb89h7V5MdPhozrNrYqbS4MtmMySDv4p4G3xPME1CcuDPAB0REo5lo3Z5jjT6x/50m541HN0hi6792QQonyzVVhbPJ2W32jQw0YtjtRGpo1NS8ZF72laX/eAKxVvFOyquiuffv/VT29n46Wg0nTPOX8rnKYRFulILSXRuXlhFgMVdOMRA6Fc6Lvg2veGVxSFkan7v32f8d5slg05agAo1XRjLFO+gZN69z76ivX/HbP5s2L0fU/1WOGfNd7roQIJVrwtYsb/DdTPfncjBqBwXiY5UNreRK2tQ+W3s73TDGKz1iBtc2MeO1nWGtrP1qG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAQVDGjhApLT3KTNAQprgusBIJzB0rhCV+T42QEq9qE=;
 b=wQJOt2xkKjRexqdYT2i/Kx3vN7M8uuKNhrUKVRn92DinSyDBXQx7A2btH9LIvCX7o+nWThqB5ef5Vj1KqbIGP4TXTJ45yMXIleoWI3Bl2gMD+EHZcQ2NWQ6MZnaLXxs2Y4eiVWPLSdHlDzVRm3yRDDC9ZX8bGVy3JDGtWTbUHr2laZUBSn44B/BNY5OpX1ttWWPVa9dydH+uutlo7vGFnItST6VhnrwHiHTNxEbaUYcrpcvSSVS4cPw8fU7L7PoxtcyaUQ5WoT2vOzCKuxQuIBJdovaIEfuYSkcsN2xTHOTikZl/iyTftaX53revoM5UTXgVj+GvSRrKURaHxyXA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAQVDGjhApLT3KTNAQprgusBIJzB0rhCV+T42QEq9qE=;
 b=QutVg4iKuk+bf6n/wDCkByQYc69lFebnEsbeA9+tDaWq/GNWo/OANjEcETtXBRP8+eiNFqvKmfet3g+wsXmOEZv6QFEK8RuvxlW5go5BOVW9EEn34jRjjawPAG6cSQu4COc+SS+KcvehpKTXudRhDgOcUh0818QliP6PwnOpHmR3Vdhop87TFU6adWUhC2PRGYxzARyQ8sQqa1a4RWHzMKhsDTC9J6WFgmBFlHdekK/4WlWOD6sNm+hkFGzc6jPX2taL1LcofqE7dKv+xfgIzOB82XPslNN62pZH7hMEThR6i6uGELCW9DYWOnvO8GHEDfogn/D4bEs14T32RzzU0A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 04/19] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Fri, 11 Jul 2025 10:57:06 +0100
Message-ID: <20250711095812.543857-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 98041530-421a-476f-ffe9-08ddc0617dbc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTJRNE9sQU9BOXBQY1BVMUFOaWdFVXhCVkpRZ0lnVFFhV2xQSG5KZi9NRG50?=
 =?utf-8?B?STNEcTFvWnREVTVwQTF2SHJPZG5Geko4RWc0cThXdStDbEJDZG82T2dWZ3d6?=
 =?utf-8?B?aXNvRzNyZUlXNXNhakt5ZUdXdWEzWmxaYUROYmgzZDlFQml6YVIwVzlqMzdV?=
 =?utf-8?B?NStuSlBWSGFIVFd5QVEyb2dTY3FMOFY1Nk0vM3dDc05Md1c1NTdNOTFiYXdv?=
 =?utf-8?B?Tit0ZUplT21aU1YwVWkyaTlRODNlT1ZObHFkZVVicUh5V05GcGNKSXlxcEtr?=
 =?utf-8?B?ZXNZemJQSE9aVmlkYWhyYlR1QnVubzVhS1JvbTNmeXZvbmxVT1pxTW93aDBM?=
 =?utf-8?B?djA3ekhieDlzY1lqWW9ST3YxeksrOCtFbUllOE5DVWtPR3pSRUUxZWY0Qjcy?=
 =?utf-8?B?ZnFPSmJhWTVCMS9IbHF1ZS80QUptcGRkczh2SmdQeGRrZm9jK3dOajNESUNB?=
 =?utf-8?B?akhZYlFvWkhoTkw2cVYwQlJiamI4UFhtSlhwMWVPMDNOMUpmNEhWYjhvb1dN?=
 =?utf-8?B?VzlNTE43TE90TFgxZS9GcEdTc0lyK293YlEreUJXL2R1SjJYbUlBUkxLRWh6?=
 =?utf-8?B?TXk5NjFxU1o2U3dQdmxacnRiSjluWUFqaWJvVUgwZnB3UURmRlY4c3NabHFD?=
 =?utf-8?B?R3VnMndXUnZsVnZKOGNJckx5ZExQQk9YeFE4RmRkVmtxMWgyRXFUL1Y3Y05y?=
 =?utf-8?B?NG1oc1ZiUUV0eEwrbGZVYUJVb09kNFFJVithcVErWGl2YU0xQUhZUXdBanhP?=
 =?utf-8?B?bktTeVVZcTdqWXNrajhtamRmTHVpVWg2S3NPYmY1SHRNa1hJS2U1TkVKeHJq?=
 =?utf-8?B?aFFScklTckQ3bWdUT3AvNHdsWWR1b2VaaXVtNkhFWHlxdEd1NitYamZnT0tU?=
 =?utf-8?B?bWMyL0NzVFBSaWRoSG9lam82REZaZnNablJITmJzbWhqV2d3c3g1Q2twM2JD?=
 =?utf-8?B?a3IwQmJlWkt2am5DRldCcVJMYzNrRHZuT0pmT21MZzFyZmxBTHdWbTZmWkFq?=
 =?utf-8?B?MzBPSXI1ZWdKcWtKSEE5ckJSWEFUNGFtcUZQMzBHZnFDZjJGVmFyNWhYVFdP?=
 =?utf-8?B?ZkFHekp4WWxZVmRwMHV6WWYwSGpMWE9Ic21mY0lLZDhHMnhXckNoZTJ4QStR?=
 =?utf-8?B?QnVHcXd3ZHlkZTJJVCs2UVRteVQ4VGtwekx1R3dIa2lPbUEzTm9NV21Bd0F1?=
 =?utf-8?B?bDZlbm10YWs4bldXdlF4L1poNzRyYXRKSDdMVnpzeFpSc1MwR1lzeFNtVmM0?=
 =?utf-8?B?OGV1NTZ0YnVVTVpKVThiTm1OcFpHcVpubW1SK1Z1Qnlpa0g4a1JuMU43ek9x?=
 =?utf-8?B?bWE2dEdubUoxWGxSNkNGNHZpK2FiNmdiaDIzTTlsYkUzVVl6dGN6em5Ld3FZ?=
 =?utf-8?B?SkRsLzk1RC9welZJbkVrTHAzNHFOOCtKRjJNSWlzVnlBOEcrb0sxdjFyYTNq?=
 =?utf-8?B?VEV6d1d4UGJnWDBveThiNnQxOEswV0ZVZ3BFQlVKN2Nad1l0bGFhUEUzY0xG?=
 =?utf-8?B?RzRpczJFS2h3d0YxalBrYTRDU0RyT0Z4OWxWWGh6N045a3Z1cnlFL3BhZG5a?=
 =?utf-8?B?VlN1YlJQKzNaYjZJVHZBbGJZMi9ZSFIwVWVod1kvSHRVdlBWRHRiZmVKUWJC?=
 =?utf-8?B?eGxNQUhGUWZnZ0VabCs1OXFQTVA1TVo1Y05NelE2L2FaMkVXNVo1MVBrNEJT?=
 =?utf-8?B?VVJwVlNVdy9MVWF3Nnkybk4zVWFtM3RYeXZ6OTgvdUZveDlobEpIWnhlaVpN?=
 =?utf-8?B?djREZ3NscFZkSFJQVkVxUTlDVm02VHViWHg1QnhQazRNYVVYYmNsNGt2dURP?=
 =?utf-8?B?ejdTYTgxT0lGMHAxOVl4ck8vT0MwMS9ObTltNmd4SUM5L0E1bThzR0ZJSDV0?=
 =?utf-8?B?K1J5WjJCNWltc1BMM1NXaEpucGZXKy9GZXdwQzNtbXIwYnRxTlJaV3lha2N2?=
 =?utf-8?Q?kf3M452ZgTA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZDQTEvNUN3T1o0OHR3WGJYaFhhR2d4Y3VHK0tuOTZ3Z1N2bEJZS3NxNys5?=
 =?utf-8?B?Q3diMkwvbnhSdnArZEZ3N1ZBOXF1Vnk4UFVYTTZFQkx0VTNvWjdSQ0ltQlBx?=
 =?utf-8?B?TnJhbFdkd293UTJnZlJKYlg4M2l0bDlCeS9HZFovelJDb2t6cmtSTmhqcU9o?=
 =?utf-8?B?NkJvbDdmenVUb3NlWWkya1ZRMHpUYWt5VjJWVVZpUk14NTlYMkVobzJxaG45?=
 =?utf-8?B?TWZ3Rll6d0l3WlkvMklTTTNSR05mTHFNUXhuQ3hUNkE2L1dseUFGS1lnQ3B6?=
 =?utf-8?B?Z0YrQ0ZhUGtuTDIwWkVrTlkvZWo2ajltUVA2bmhwSjRwb2lnZjVQWk5GZUk5?=
 =?utf-8?B?bkdIdmNkay9YRm5NZDlWSFlOVGhNNklKbnBJV0dYZ1BCZWFiYnZQQmxIbXA4?=
 =?utf-8?B?ZFBzdnA5T1pLV0NzM20zSGVEekxERlR2bmxFUjh3eGcyK0RmS2k3aUdQWGVx?=
 =?utf-8?B?TVVyUnNxS2EzUDBlNlR2V3l6Qm9HNGcwU3FINS8xRUwrR01xbDBHaXVsS2Z6?=
 =?utf-8?B?RzFHdkZuRHZVYW94bzA1VWlSQ1pqcThEc3JadXlIekR1dzhPanBFKzVTZ01H?=
 =?utf-8?B?S2JwYTF2ZkN6SFNXbXphS1VGSDg5Uy9sZlU3MTdLbzlBYTIzZFRRS2R5eGNK?=
 =?utf-8?B?c3ZRSXFhRDQ4WkZyVnJ0T0JBdEVHK3diZUhWMHJvaVJqbk5DUXZ5QXRmYU1Z?=
 =?utf-8?B?Q1NQZFJxTk5XZElZYzZVT3pxU1g1eHJ6VW5vd2Q0VUxxbk9XcDhNVUtLd0U3?=
 =?utf-8?B?anZFRzZxTnN0UzgwU2h5VjdZL0JONHIwNUFNNEQ1a1BWMUpxVi83Q28yNi92?=
 =?utf-8?B?M0JsTjFxK2xIcE9aU2NNeG9Ubm5oRjNDNDJvVWl6TWRWNUVaK0JKY0NxU1Rj?=
 =?utf-8?B?YXZlVXpWd0ZIOUQzZ0F1WSt6YzJhUXhucHk5OW45elQ0Wkc0RXJNYzFrbDBB?=
 =?utf-8?B?SFFIVUFGeEF0d3BYdkNHbzdxRVcyeHJjTGZVVkxsR0lMR0FCUnp4OWhoRlVG?=
 =?utf-8?B?U2QrRnFpMGRJd3ZzZkljcWdydlFvY1FCaGNkaXRGQ05IamgvWmNUWGFzQWRv?=
 =?utf-8?B?eVlzK0VJL2U2WThqZlB1cDViSVNIZk9QSzZyNEYxOTNRaWJ2MGZWTHpBT3cr?=
 =?utf-8?B?eUtNUHpQaXA0VSsvREVqTjNNWVpSQ3BzMUcrN05FNHRwbzh4UVBoVkNXOHNL?=
 =?utf-8?B?c1N2ZEtjbUNES1djK1BuR20vMUtZZ3lPTTNzc3F4RFlienJRcVk1SDUxaGxr?=
 =?utf-8?B?K21tcDAvNEZhYklIOVZ1Z29lTkRUS3p3aU55UWNYV2NVNFA5b01MTFp4ZTFt?=
 =?utf-8?B?L1NCcGNkQjJJbGNQckNmejNGYVRsSXFlMG9PN0JLbUNVcXhGNUp1bHBwdGcw?=
 =?utf-8?B?OFAyUCtjcHBtVTRnSkRzbEV6cjlHcEZCQVMxUEFQM0hhWGY1d0RJcHlMM3ZF?=
 =?utf-8?B?dDNidVgyZDRZc2M0azhmdE1IVzFnVlVQRjM2MFlFei9MYW92dzhwNTBnbExY?=
 =?utf-8?B?QTQza2hMK1NZQ0hxRjVRNGV3QUsrR2E2SGlsWmRVRm9SMmhpdjdMUEVLYzZT?=
 =?utf-8?B?QVVjQ0lkcWE4KzNhc0cya3czYk1DT3VGbWhEMEIwK2VOSVRCUE9ZU0RBUUNC?=
 =?utf-8?B?UDBaY2l6RGhMcXRhVHhUem92T3RTRlExVkNNZlR2SzVSNHBBYzR3OXBXM1Br?=
 =?utf-8?B?ejJ4MkxGcW9ZNTk1YkVnSVZxLytOZ0QvTGVPelMyekN5cjFHMjZaK2FiS0V1?=
 =?utf-8?B?bk9KOXorcm9FbmozOHkxV1VFdkhGMHR2UUZRNGM1clFaZSs1c2U2UE9mclZk?=
 =?utf-8?B?S1lvZXZVc1hoekx6TDhNdnZnZFdHUkZ1YjBBOWcwT1NKVm40UVR5T0NCK1VV?=
 =?utf-8?B?QjNZRjFHTWFWNktMWnpEeVZ6WmZLbjZiYWhwMFU4SDF5T041WXRPMlJxTTN2?=
 =?utf-8?B?OWpVQmEzSGtwa2k3eXJ2TGY2WVQyNSs0aXh5UWF6TjhCb1FpVlcvZ3krNHJN?=
 =?utf-8?B?NFM0N1I0VjFlenJ5dHBHRGlLUTg0WUxXblA0YnI1eHdyVHJYUzdjT1JvY2ZE?=
 =?utf-8?B?eTZTbDJsR0hsQVlSN0NlamJoTmtXenpLZkpkbFY3ZEZpQmRCYm1OR1RyNi9Z?=
 =?utf-8?B?UEl2eno4aWh0RFo4ckxSVUV1eUt5b0JOb213NmRDU2tRK3FQam9YT0tzZjlq?=
 =?utf-8?B?VjVjelZpQWlOcXNWS3M5TVlWSCtPTzdTT09YVEZzN2VsMWJNM3V5Si8vLzBn?=
 =?utf-8?B?aXdmZWYyQ0JUd0srK21XN1BQRlZnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98041530-421a-476f-ffe9-08ddc0617dbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:31.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAw8BJ65ZreCRpA2fxG//Cn7oWgYibLEtk7Uuc3X+9cCRdKApR9RZVSieLAAgnmp9+Ddj9iL6GZ6EhfEPG6rXo9KWV9ehYm4ycT69MS9o2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXwCd4VXeC0Er9
 D2I3v3cM2NBaZcM7hB2LUPtbQyoc+R4nAlzvL4/GpX4mrJGtwjsyl/xagDNFABZTPO6AysD4VdF
 dsobFg0LJJdZJ2nZgea2ynCITv6JTTmpIE1ujHnIZdxESySsV29JFd9RlnCip+FDIXAZwAvUAOr
 AkghE2T19WrzXf+LmDj/JuBbjOjDIpAKieKlYsi49nfNA4YY96o5IellLqMRqCEeiIPVlhH8om7
 azuw1fzu6PXNnFgFoXXIx50XAP54W65JPKGdrWapm9YWft+N26qxorVcv7z8CCwSP+Djne/5C7D
 r9Jr2MH8vpye+Rw7CUcWmZ7DuJFeHwXxflBl+yTQUNOZ+mTkQhkFcs3x92YDi5DgtNI2ryhBtim
 KjS+mdVy2tX5D8jRNCk3xOso4h0Lw1vRILcfaMA5yTZTwg0a+67VsYNqsoWWWyxH34JSHaqV
X-Proofpoint-ORIG-GUID: QxHaBjf-kOLXTBzQqYSU78ppme_W0_hA
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e049 cx=c_pps
 a=VPmHu6eXMPg+68oZcjUWEA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=EScErfUSVzH1iicdKiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QxHaBjf-kOLXTBzQqYSU78ppme_W0_hA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b33480e203..f576e98727 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -417,6 +417,87 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
@@ -430,7 +511,185 @@ static void pc_init_isa(MachineState *machine)
         warn_report("-cpu max is invalid for isapc machine, using pentium3");
     }
 
-    pc_init1(machine, NULL);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
 }
 #endif
 
-- 
2.43.0


