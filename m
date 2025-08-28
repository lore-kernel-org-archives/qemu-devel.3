Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903FCCA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXl-0008L0-Sh; Thu, 28 Aug 2025 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXf-0008K3-VG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXd-0005Ge-Qf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:43 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S6aJVM2725983; Thu, 28 Aug 2025 04:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ro2PcbKiDRS63Cm4YqhBmRjd9WzcxE5GFhsJMGBFE
 qA=; b=rC7i2+vuHfuP/YdWTmddptWbrnejJFrj6Ni35mlV42yp5FQeOU+KM7beT
 Y9N/1fSlko8F6ckQ+j8DpZR5Ashqi5bHNc2YzUwwjdlf2f10a11HFTLBArPo726e
 BO0LX3jXIxLYQRLZB9rL3VEhafD33GT/L12p6PP9ScpoBG0weahn/4BhPKJrQet9
 wSMwa775dnTwgT2GEfFVW7UyHoBWwebl+hbB7zluGVms81Ukhw7I5eXChYiUxETC
 1Yq8rDvNfmWtRJlQiJU9e6P6vnSlloliOHMGkHJ1Zk42Hd3vlvHLicJQe5Gj1QY/
 ZO9NcWI3DqwbuXoEkzEEnQm0Iy10A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021096.outbound.protection.outlook.com [52.101.62.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjswg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYAC3yXivCf8Wys0ucdVo7n7HMEIppn51yrHndMlgFidGkv9zeMaaH38cmJCRuLQSCqCynvuIgDKZwzRZzgXtlx2pL0eiC2bN4QZxaT1QrUwB8c5hWcqKAH56j4z6+6LgDwOfHlAlaoQWVF051GYZmRpE4knPh0d3PXnZh9uABxZc5xPk/KINXEFCrYoK8H0GW6vf2lu9lpgHaq9OcnEWfkOZjRorobJK5O7B+1jhCJfw8xULnHlUQ6iMLAfoT03BcgBvqENFjmvYPsW5fcYIuhH4S2xP3mLLs66nZw3J8RFY5K/wQu8+d1XUMXTSpb5dCRTRdDn2WyDyXi/EyYBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro2PcbKiDRS63Cm4YqhBmRjd9WzcxE5GFhsJMGBFEqA=;
 b=sqkwacG//lrGvXa25dwY3/gSeFTmOdNFvJFxnK4AH4tdGWJNtovH1rlWf/gaSbw/2gr1ltIv5E+IVmU9i17IfqplaSbMhvfNQ/CA/+ZM65AXTWnsEM95YK9RRpRY92qUfiIhY9DesWvKeCG7HQKYxDeGymPvAMRU08R8CJmjI6jpX3uuMmaW6HBhjc13UGWZhERG7PwvpLAU+eallAe2cm+5uomAyKpBFE0Ze356/8+qujUMwzBdrqiJpyywRRTzX5UCanBln36cam5XmyboV7ypp4/caxO+QF0Iamx/BtbrYh7UVf5Bi73iytdddlvcUvekpyM5Kdr9lQt6MPbWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro2PcbKiDRS63Cm4YqhBmRjd9WzcxE5GFhsJMGBFEqA=;
 b=pXGxIhbzDfyrWnXGbjHh/zDaXUL4sq56TjaVpZySsD26iuQ8T6iEs0uYUyZNW4h33kt00jdrAaqRyC6Qb84KOy6w8y0MgHyphiD9csN58PfeP7sbHb/OkAJ2oKto7S4yel3uc2+kDDIPa8HNvRhG1TGaNcr/XN4B/Jwf/QpfeiO7IxKrVNmX3C7BRrOdmdMP5VfCQ6wJk5K5aEDj2Z5HiVPXbXC8IAc76zx5Z1ibLTEJedboLDG+y/UU1iJ9EXdLqEiOLU4fEAyb4oerQdpXgr9vuxAWITGhZ01dmx9Juaj2/V878M0n9g4tDjdFCrjZFWRhQFJTMRPdIEs8Rky1Fg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 10/19] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:53 +0100
Message-ID: <20250828111057.468712-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1c8d56-9929-4911-5a08-08dde623a603
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUhvdTl0akRWK0g5V1FObERDNzV5d0l2OEI4YzY2UEt6cjRTZnBOa0xXM2xU?=
 =?utf-8?B?Yk5VTGxzMzV2Ukc0QXpCSEhHM0JJemlmRFpXbHZIcmhmT21PUS94aW85YklO?=
 =?utf-8?B?cXBDY2t2Y2VlMHpWR0xuRG91TXRGRk0vQ2pLSFFBYmF3dUw3MUFQbWRYaXQ0?=
 =?utf-8?B?VjZ2MGFPUUNkcFY1R3REdGVPUjhaRGJPZE5LOXE5N2YvNUhEZWZHUjl0emVt?=
 =?utf-8?B?YzkxbUtxQ3N3NkJMOVlDd3AzbXJJK25VeWtjU2dqZGZDUkJrV21UQkpGSUdN?=
 =?utf-8?B?YUlxSmNHSE9rZ0VnTHpRaDZqdUtVNE5mVEhyK2dlT3pEakxNd20zNmpJOFJU?=
 =?utf-8?B?Ym54ZDlJVndmOStDVTVickRsbGZwbWVRSXdlZGQyR1VWMnNBcE5nb1pyWmw5?=
 =?utf-8?B?U2ZBZW1GUFRlYjQvUEt5cjBJQTZQWG5XNkJYeVZLYUlCZ1N5a2tEUks4VE5o?=
 =?utf-8?B?Mk1rWlBoZzRqOUNwMnFOdlo2YllQQzhoRzVOeGdiaCtWY1d0OWo0ZUxocFp6?=
 =?utf-8?B?SklxUDR2elE2ZnBqbFpqY3dIMWo0YlIwZ0lJWCtsNXlXR3NHRUVOTEJMMVdl?=
 =?utf-8?B?V2ZxanNEU0JJOEJ1eWx5ajhSaUNtdXhSVVpER2htL3pET0JYUGdHTG9KcWRQ?=
 =?utf-8?B?RXJVZ1d3WDlrNFpLeVRCZ1ptRHlpdSsrTzZvdjB2SmNIUVlsTFZaMkJIVGlK?=
 =?utf-8?B?ZjZuT3VjaW9ocm5rUVluMjhhMmxQNG9iTFptS2NIb1ZIdU9oZml5MURxdVZl?=
 =?utf-8?B?eExNeEtPQnhBK2txSzRlQmVOaVVNL2RsRXNKY0tlWHM5VldzdDRtNnMwdTJ2?=
 =?utf-8?B?ajhPcnY2dndUeGdOZkxWUUJ3dEFjUEFlNzZ1WGg3cG9BUVZsTHFYT2ZSMk44?=
 =?utf-8?B?UTc5Q1dGQ2FMTzdqdTcyTXpScUpJSEIrQjhNVUNadGdqbXZxcEV0UUtZdXEr?=
 =?utf-8?B?VzNnVENqTzRhY2VXSWJyb0F2OUJxT1BIMlFLN1BwbVB2RXNsaldZbkl4VDA2?=
 =?utf-8?B?WXJsU3lUTXpCYkdhM3JtbExjajJnU3JINmp4ZnhReEZHdzFrbWdlR3k2Zitw?=
 =?utf-8?B?RW1jWEdNNUN4RThBblNhcVVEemRaaFJ0OHlsZXRtVEZNREFqNnphYWxNQTJr?=
 =?utf-8?B?M3ZBeDVYMllSRnBPK0p1endrZ3RWV1FFOE9XL1VoQ3pUb0tMeUUyWWpmN1My?=
 =?utf-8?B?WkZQVldiZFFLSDRnS0VkU0VieVRXVURnRjB0OUtXQjNORDI4amVNYU9MdEZx?=
 =?utf-8?B?R3VUS0RkUVlGdmEvellGKytWZGsvc3B5VjVsV3MrOHdseXV4T3lrcDNkSjhv?=
 =?utf-8?B?dFhYbllMQlJ5dUhORFR4Mk9zdVUxYUVrUEppeVZGYkJLemM2VWFDWmlPcUg5?=
 =?utf-8?B?VXoyMWVxbDVYY3Mza3lzM2ZLVGtGb3lzMWNvU3c0aUJ0SXdOckVwMVVwNUN3?=
 =?utf-8?B?S2RRU3RwRFFhdWdBbU9oK1RCc04vUVlIMTJFZkRTMlYxRExGRTJPNk5hbjFn?=
 =?utf-8?B?SFlZODhLZ2tlN3ZSeUdSd1dkZnNRYlBid1owSVhaY3hFQ0cyU0Z2aWhZOXNw?=
 =?utf-8?B?cFMyS1FNNFVjdGtBWUZxbFlkMmM3TjZXNXRlakYydXdidFNnR1ZxbWtFMWNj?=
 =?utf-8?B?ek53eGorN2xCUFBrNEF1UmFkM1pXRnAvR2NRT3VCME5jZnQybWxUNXp1UWdF?=
 =?utf-8?B?Mk53QlI2clFMa2NCRjcwTGVFQUhWOU5GVVUrcmxYemg1THhERWVzRlRHL0gv?=
 =?utf-8?B?TExDdzY2Q3RKMGtBME9zNXZjbm9lVlBSK09CREdxUU03akVDQ2p0MEdxbzNl?=
 =?utf-8?B?U2g1N2VvS09TbmdhMUU5TVpLTDZoM0k3dXErK1RzTGh4cnpZTW1YUmk3RW5K?=
 =?utf-8?B?RDczVE4xWHdXdWxyUlRoTjhOWnpPaVo4UVZLcmkycjZ2VTJpUENldGVYV1lB?=
 =?utf-8?Q?9fgLVvk3B4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRUV0s2TUlwUzZWeHJBeHYzeWsrMERBV1VCVjAxZ1M4THBOK3pGT0hpQWtG?=
 =?utf-8?B?NlZ1VnNCSmV4T1RycWp4eEU2MjNNZ043OE5VeVJJNXhCdWJ1UTgzQjg2V1FQ?=
 =?utf-8?B?YTZTaWFBTGh4b09zbnNCdlFUZjZNcS9KT1dLRzlWT1UxbXpyZXJ3T0d2b3VN?=
 =?utf-8?B?WWlHS0NpczNPTlR5aERib2RGSGFhVFUvd3VqblFzWTZwUnRNK2pjNGNiZXJD?=
 =?utf-8?B?UWNHeHd1b1JYcmg0aU1panl1T3ZiV1ZWeUNMWmo5bGptYXRzTGVsWm5aSm9u?=
 =?utf-8?B?Vk5URmVOUWxYeS95c0M2ZjRhUUVidlI3WjhBaDFYM1NncEtXMkRVWHNNWlRP?=
 =?utf-8?B?V1NsSVVBejduTWRQK2R4MDQrTXlUdWNXdklGL01lb28rdTg4a1ZCZlVnVjB4?=
 =?utf-8?B?U1JzeUp3VlZkTWVVSmZiYmZyYjBsaGxPdGEyR1pHM0tIcThQdXJlRno2SHB4?=
 =?utf-8?B?M0Qwa041dllxTld4ZnZJd01CRzVTSk01NGlXMTRRcU5Xc2lFRStYUjgyQjRt?=
 =?utf-8?B?ZEM4MzVoYUdSOTVTWkRlOWRva0l3N0FNaWpHV0o3RVBhVk42S1dwN0JDUy9X?=
 =?utf-8?B?WnN2bTVPdmIrcWIzY1RvNHpHendMN1NlWVhBU2RJZ1lMaUw1cDhwcjRCNGNG?=
 =?utf-8?B?WjdjQWUxSzN4dHF0Zlp2VEtENTlzcVRhVWFYUEhhOEwyRndRUmpvaVo3c1h3?=
 =?utf-8?B?TUF1Vy9JSFFoRTBRSjVGbGYxaXBZV3UzU3hGNHk0R25kSmlVN1NxSG0vSzdr?=
 =?utf-8?B?b29jckcwNVJuYXI2d3FoRlRVRlVpUFQ2eFBYSW1MUXI2U2Y1Y0lUOFhvd2F2?=
 =?utf-8?B?OCtGQStGTjVZZWwrVFpPT0c4aFBwKzVvQ3F2ejBSMFhKcVRhcS94RGt0NUll?=
 =?utf-8?B?YWpyRXgwbThWN0tiWE4wTjlhMStZMkxiZ3o4bXljTnN2bkJnWWI3c2MzTnZF?=
 =?utf-8?B?Y1N5N3RZUTFoaDN6dmNMdGI4R1l3VDQ2L2pmamVWNU8vS2ZGQUYvRWRkS3Fq?=
 =?utf-8?B?a1BSMHpNbTFzYmJzTXJ1bUZWSU9nOEJFSGNJa0RuRGJEVVNNTkFhQitWM3BP?=
 =?utf-8?B?cU5PbGhBZ01ML3B0NW9yZ0VuY1JTNFF3NVhPeTZpbjA1Q050Q2t2U1pST2VU?=
 =?utf-8?B?ZURlMGVyZnovOVVXSmlhSFZBZVVSNVlOZHZMQzNyaklHa3pCblRaU3BycmRx?=
 =?utf-8?B?MGNPdjY4bSt3L1pxUTZHNlRJZWEvQ0xrUEkrT04xZHVPZTZNRy95NnR6SG4z?=
 =?utf-8?B?ZFdaNlVnQXlSOVBmeHJKVm1EaUZKZElGaUJyS3hjeVdNMzBLdlh4UDIxeWFD?=
 =?utf-8?B?eHlDSWFoOVdHVXR3a2wxOXRWQTRJVTBIc1J5OVVjMU5EK3MzNWNodXBaeXZ0?=
 =?utf-8?B?bmZuVitmbVc2bVdQMGtZN3NURHBIcUtrS3F3OXoxN0NWZkZwRURZTFpkcWF6?=
 =?utf-8?B?bHVPKzhuWWZkdFVjMmw5QnhXenM4QWZ0aVdTUG9FbmZHSHVXbnBxeURmQTJW?=
 =?utf-8?B?OTZVcTd5S2pvWWNEZ0hkYnV2cnVob2ZpUXRCMHZHeUxLSUhXSGV5cHRHdEtT?=
 =?utf-8?B?azYxQzRvRUJ2bXlScEpZRHh2TnU2QUZCcytxVEw0ZlRxUjVwajdCU0dmaThp?=
 =?utf-8?B?cjVGUTJneU9jMFBqQkdaQU9sc1ZlNERyanh6Ukl2T0VpblJhcEkxNUxrS0tp?=
 =?utf-8?B?RDZNNE5xRnB5NTdmRFFVM2RMV05Hdk8yQWxjaHBaS0h0ODB2NXNvU3lac09O?=
 =?utf-8?B?N3lOUjY1UUp5ZXg2cWR3U1FWSkwyUE5qd2k5Y05xMFBzNi9wTmRBbnIwZGg2?=
 =?utf-8?B?ZXFFNnppL2VDcTRhTnlweXcwWHQ4NmpLRW9WdjdNT3pDMkh4S0Z5Uk5hVkk0?=
 =?utf-8?B?dmlObXNOdXJHRFM2WkxNUDB1QUVoOEhKOVpJTmFzU3ZRaUZjNlRydG5yZ0ha?=
 =?utf-8?B?REt4Z2EvSXExK3AzL1RZNVFTYXVsVW5qUnJ6MFA4TUtPRnp5aHRydnFyT0h5?=
 =?utf-8?B?c1pWUzNSTitldDJ0Z2I1QlgrOE9pM21lODMxME5WSzlWN283L09telBzQnM0?=
 =?utf-8?B?Nys3UlhSQ2VpK3o4ZUtLcmtjbStKbGtHejNwbm9GOTBHdldMR1Nhb0dFQ2Uz?=
 =?utf-8?B?d1lXWVhGM0pNajFRQmtaRFBYNGc5blB0N3FQRXFKdjVUc3dNb0ZBWmkwZUdr?=
 =?utf-8?B?WWtwcEFmS3FXT3VFMktqMHFtYlB5a1ozOENRMFMyd3ZuUmdTa1VlV2hBRlli?=
 =?utf-8?B?SStzTzNsTGtVam8vSkJmVUdSem1nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1c8d56-9929-4911-5a08-08dde623a603
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:34.0850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saVlwoxUwJ2bY1bfN7e/4EJOOsLaM0sVawG1mUIE1J8AechW0/5MxWFus0kwkMbJy0bUOXIqkg8pj+Jn/ZxSSoDHOch6t/tm3dqEiNczUOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-GUID: GEi--rgy-7byQxDVxvTYi7kHuEp_VCMi
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b0396b cx=c_pps
 a=kOv5NEUV9vKuAQ6k4lCurw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GEi--rgy-7byQxDVxvTYi7kHuEp_VCMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX6qsJnUHWCeQm
 YFhz2LEp0s548P3P7ls/vU1wNVnCQZdD82dNjyox1m4csMGVYxahu2/nYb6AQ++F6qCBSCR7Zr2
 WVtC6XqgA530tMBrU1I6klWjTX1S+91PZ6Z+R/RNgor46oZ4qDUhHYTbOGWrSgW4JlbVXcSxjld
 BO0zlhVDnRYFdrVuHbgtKo2J+Rfw7hv0N0PnBqnIDC137WZYag+EZqk5NmefGJVUodoQRtV4F+l
 eaYFQlzEKBomrD7vpwvO8Wbe7yWkkVGQ5pzYsqYnZetCVdFDnpDhuIzjMldSpOSCbnxxEDPG54j
 r/20LFKYNgxTsLZuKW6+RvhlF/+ajwkeIkAOMZwLgChMtILSmdCrSDHvZB2WM4=
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9a2eee8ab0..daf63a326b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -614,12 +614,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


