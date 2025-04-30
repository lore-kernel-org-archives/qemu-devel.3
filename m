Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE5FC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIE-0007kr-B0; Wed, 30 Apr 2025 15:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADI8-0007jt-1Q; Wed, 30 Apr 2025 15:40:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADI4-00069e-7f; Wed, 30 Apr 2025 15:40:23 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UIoP74021932;
 Wed, 30 Apr 2025 12:40:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=RXzEoxr0jR+Zz
 WY2b+LLpmFOLrXJdRLXnPQ2phR6wRA=; b=hTxy9WV3h6abj3eH53FAICKh1ze2X
 O8gBuPzMPWVF9KJeQxpemLwN6/t083bpm64HgHav1tq8VaNyJ9mtuNY1UhMU8+1h
 x4nqlnspVt/RUOM79XpuI5gaU2/s4vIMyjdzGGzNtmHxa3vKzOndoaZXpORdUH4V
 30xcqitFq486+FcOHRR7fXzapho9bn0Uo6aZjteJYx32K058/1+NQS86Xl/T5Ady
 1PyjwVkCsJXrVHnez+JnQ80uHdf6YO63bIM7A/tkIDe4XROuwIprEj9Qd0KLRL7X
 RkPEbN9GRAhNE/8v6c1Ns/AgOxgMNt5sIVrJM7JqdR5OxHSld+zcxN5xw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8hue4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZAZSkF5c3ZIW4bQ/9YD3HMxyfPNS5QTXgOs3z+HgPpGKRUaW9sO64Y4v9TBl1hALuxwOxbMgW7EuwpYhnRZCu+oLdki9YJxGa/dxZhmAuBE0xGhHroFf4Z3u8WU4N/sa6AaUh2VfyZs2la0/co0TuN2pzABifbuO5kcCtcSBOyJQ7RBlGWGMQ0O7u2zq6UhzymcZmI49Xe1S+/ZMAsjVJdQR/BVJuKuco98/YHUho+9PxPjyDQ8lDeqaQuHm+raijCCUMhIh3I3r2SkT7khxhhi17C+/TFJL19lcnKgT2/4t6qnRQH6NFkSOuK+gzIEwtY1ypHEZpjF5SQdgNHG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXzEoxr0jR+ZzWY2b+LLpmFOLrXJdRLXnPQ2phR6wRA=;
 b=DIyrsiRZNWx2GZto/s/7pLLuZ8xPeXTPlXhD3a/7x6z1JEcYdrIjBVXl5xrzd40ng4wpduZE8Kx51GQfygoh2QdMInzqx9MLO/FWHghnWUwWAktNb25v2aebqsG6OfyzlmNLE5VboIIS/atp1mGQ2ZAMh81gKb0qqerKjMVICh/BarMgRRwmTaMLFqgQnT+3UWbG1d1HyOdhi+I3jMEmW4lTlCmsQyds39E2q752WLF7pgnZhHOFfVxtreliOSX2bHuchrdZ6lFJ+8zDoopOMTWE6O2avybpllITZWF0NPajJAR5/fDSiUbVlMnvKwedY+8FiV2ZmBCYwFYTfESD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXzEoxr0jR+ZzWY2b+LLpmFOLrXJdRLXnPQ2phR6wRA=;
 b=aLMidrDcuds1V2+hyhvVcfl2NXv/e+aBHnHTLJYHD8LV47f+7eKtcNO4AW6+Yf3vR/V7HwdqPnodxzY30euX9v9c840GesJzX/xIzKn2sYyhY1eDlDsTQLHdfGIrYJEwYkrCgmMfZSGk7R+rb/znFyYyxPCaN0nw7cL1apQtaVPAl7U4ImFPBXTJOVYlgGhyCB6xYETqr8exLKk0DBg/mj2W87r28DKeHz6g+VGSOHOgdqzehGwkGJMSSiT/ibG845elXZRLnlPfgmTxDtlZqrFojT9H5jCxHVAd0z2IidXd7DC0m067+qtgSvAhq8TE9rueDM1Lr+LgXnp0XAH15w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Wed, 30 Apr
 2025 19:40:10 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:10 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 00/15] vfio: preparation for vfio-user
Date: Wed, 30 Apr 2025 20:39:48 +0100
Message-ID: <20250430194003.2793823-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV3PR02MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd0c928-c7f1-4ce2-1c66-08dd881ed168
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L01acWI3bE1FTUV2ditVODI0WFJBZUpyU0kxRisvMnBtTXd4WElVT2Q1RVh0?=
 =?utf-8?B?NWJSOGdSUEdMWStxZ05Zb3dQdnNGWVo0MEZFRWFjYTloUDZNN2k3MGR1RnJI?=
 =?utf-8?B?YTdwUW1QYnFES1g5TzhLaDdIK3VabmM5UXR0RjZyeEZiSjB0NlZSQjF6TjMy?=
 =?utf-8?B?L3NVR0U5Smpqb1lTQlRPSVhQVFlBT2prdGh4R2dKcng4UEF4Vks0d2I4V1Ri?=
 =?utf-8?B?Wko1M2NlY01qTnJxMVdCV0VKZUJnb3FJMkwxOUdHeXZJQ2xhNlVvUVZqb1ZK?=
 =?utf-8?B?S20yYTZIMFRNaG9DODA0czFSZnd0eUlmUkRCcVVqbHZQRk9BemdBTDd4V215?=
 =?utf-8?B?cGdCeXV1REZySDNsZitLd21RbFRLVEY5cGNYa2xMalpuL1VtaUZtSDBJSmRX?=
 =?utf-8?B?WjVpTHZTeldtNWIxcldISFZNbGFjMkVNWjRMeUZXWXhnUjVyTnlMemREbWd3?=
 =?utf-8?B?SHhLTEFnTGc2UTYrczFoN3JseDRGT3R1TGpRQkRvVWlnNmNONzZyVHlQZkEr?=
 =?utf-8?B?Rko2a0xWSFI3eTQ3cmVMSFkxTm9hc1lHb0hxWUp2OGNjU1dPdi8zU0tVcnR3?=
 =?utf-8?B?dUFsdjRLcGVWYlBGZkdiNWxwYkkrYmJkWFZ2RHF4bnlpb29yWmk0azdrUmhF?=
 =?utf-8?B?eXdVSU03aCs2Q2NJTnQreDlGN3hKcXZ5UGt4QkgwRmJ0ZjAxRktIZHhMdjdx?=
 =?utf-8?B?OVVreS9LcnNpcW14K2ltVWF4VWtJUVpzdVNUT0REMW8wRHVFRmlGS0owY2l2?=
 =?utf-8?B?S0JhM0lCSFdQQkk1LzlReGpkV2llMGdMaXVjak5zYXhNTitTeitlckR2QURq?=
 =?utf-8?B?YXFOcnJLTTJscGIxYWRrQVJpTldtTGxQL1dIOEQ1ZUpLdWJIaytheHZ0ZVY0?=
 =?utf-8?B?clJrakdYeTRmRC9VRDEwd0RVejJpaDZ4bHlIM2tRMndlTnFpQnBlSHNzUHp5?=
 =?utf-8?B?V1hZRTZVYit3WHJUazFoWlpEWlAyNWpacGVCZnRGMXppQUhpRHJTUWt5dFVp?=
 =?utf-8?B?aVhxaWtTRFgwRHdZTWs3RXhJT21UclJZSEEvS3BCSWpXd1FiN3l3RVFEVjVk?=
 =?utf-8?B?R1QzdE5leEFMdVdEZHZpL2ZFQStrdVhZaDFLOURzYkp3MDkxM2xuNmFpdVJF?=
 =?utf-8?B?OFVITlhzcEU5NzAwb0VxS21qVFhTR2NYdjVmWFJEZ0VzL2tyUW9VLytrVUo0?=
 =?utf-8?B?TkNCOUVTVEpqdFJYNlFmRkgxVmFhaUZCbG5OdVI4NVFzMnI4dEl4MndGbW8x?=
 =?utf-8?B?SzBiUTVWVXZYTmNsSDdrMnR2ZDJpYUY2TDRqeUZWamlSQ1NNSzBxNmp2L0tw?=
 =?utf-8?B?K0tzZEZOVGg5ZU1iVnEyWUNjajVRZ0lZUmxvdXVZNXdIUWl1LzlkVlVVaUY2?=
 =?utf-8?B?QnkySGtSUlRQQUxVM2cxeU1ZQjlJWHNCSk9NQldJcGtDYU5SSHBtOGRja1Jo?=
 =?utf-8?B?RzlOZjB0S2NiZmdkRVAxU0c5YUtxRFplb3dxZmU4Yyt5MUVuc2U1NlQ2dGIv?=
 =?utf-8?B?QkRxZ3pnU2pQNkNBdjFYVXNpSHJnL1RTYlczRUc1VHMydVlVNk03UTlqUEJx?=
 =?utf-8?B?S0krbmVIai9zeFJaTWpod2RyeGdUT2hOc2c1YnVTai9OaHRwMml4cUl0YlYw?=
 =?utf-8?B?c20zWUNZZ2swUmlIVlpVUVBNelRKcTBXM3M0emdHc2dSNDRoUzB3Z3dMT0tp?=
 =?utf-8?B?UkpYZEg1bHlXcGFMSnR4cElqUHp6MnlxWENBN0o5UGpIeFhBRGdrUys0bVZ6?=
 =?utf-8?B?V1BJSm1rZUUrQlNIV05weDNRRWdKbmJpbjFoYmVSWWVSWURFWDRqQ3lNVElz?=
 =?utf-8?B?ejNXSUhzUjBISjN2d1h2ZHBxNWxMR0Nua0dLQ3A2b051NGlWQUJiSjEzVSs2?=
 =?utf-8?B?c2ZvRy9LVkhCQ2pKK0x2QnZKVFpGcWpGc2VFblgvTjF3MzRlakVrZVQ4bG5X?=
 =?utf-8?Q?G8mZm7e2ykc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmc0blN0RHBZSXFGVFJGZm05WE5qelg3Umt3dWRmQmJ2S0dQSzdYVFFacTB4?=
 =?utf-8?B?eWxTN0ZaUmF4NUxlZ0Nld3VUMDRZRnJQYld0ODExTGxpU3BkYkhLV2lrQ3Nu?=
 =?utf-8?B?bTE3c0gzOTBqcnVaSnIzajRHWU5nY2huYytEdktEcEM0ZHRUTEhnZm9ueUZV?=
 =?utf-8?B?SEtqaVpUaEIvMzE3emRadElTNDczZDZvMDFaZzJZUHpKdTA4aWlycVRXQ0Iz?=
 =?utf-8?B?cmxFcnFoWVpLK2JUU3JLOERBN2lDVlZPTmdTV3o5T2VhQ2FRT0pWYjdaVjAv?=
 =?utf-8?B?REplZmtIMG1wUWxCY1VwRDkzTEpWbHRPdUdjVWNMeGRPM21kZ3RwYUpyV3FM?=
 =?utf-8?B?R0hjQW44ZWRyWW41dHJvOEJheFpma3phUVJ0QjFBNVZIaFQ3TXV0NGRpcHpG?=
 =?utf-8?B?c2FWdHFCM0hUU3IwWE5GVExRQTVBR0ZRUHpxRlhpd29rNWp3bktjeWFsOHR3?=
 =?utf-8?B?ZExvZkIwOFlpMnFEMXd1eldvZ0dKSzBaUFVEZWJnT2JhUkxhakNKbVpNU2RV?=
 =?utf-8?B?S2Y3ekhQUU51Mzl4dkc1Zy9HVXlzVHdFcVBMblc5VDhFSnpzbWcxdTAxbmVL?=
 =?utf-8?B?VWMzSUxnMlpzUUpuT1RKZHV6RzhTcmEvS1hnTU1aZjd1UDZ4dHlPTXVHODhR?=
 =?utf-8?B?OEhJa3lXdzdLL1FVamgvbnNDZnVtWlNaU3ZkQTBNS2Q3VmVDUjEvZ01ZOVdp?=
 =?utf-8?B?YVNvZktNajFQcXBpUUZWb2FhZHhQaXM2YUFrNFlCaCtacFRCQWlPbnN4ME41?=
 =?utf-8?B?R2RNcWtQaFhJNFF4eGtxUGhCeGZ5dmRkbHNSbEt2Z2dZd241bDhibFJXNmp6?=
 =?utf-8?B?QzVmeFdGMG9KQ1ZWSDVIYU9DM0NGek5zL25nYzB2UlN3VmdYdjdFd0QvZEhU?=
 =?utf-8?B?YUMxNEt0QTIvWFozWnM0bmtFL09nSmxhaWVtL0hqZGVMNUY4RHR6VzEyR0Jq?=
 =?utf-8?B?OHYxdUZibjFUQU9XTzZIMG96OUJENlpaTy8xNWtRQWtlN2o2QU1jZEM3Y2tS?=
 =?utf-8?B?dUNzZWZZR05GY0psek43WC8yeVpmbkkydzhXd3ZNUE8rMkFHR3ZUMFIvaklo?=
 =?utf-8?B?Ukc2NzFuTXRJMGNhSVljUXNIUFFPV29VNk9sSGxtKzVhWVFmSitoWGVSamIx?=
 =?utf-8?B?Zi8xNktwc2F3ZzJESExVZ3VDbElpZ1hSeksrUWQzWEduQWpiT1hDYVFPWnBD?=
 =?utf-8?B?azhEV0JOTW9HQWcxd0Qyd2F1L0xBdlk5OGxkTHdseWNiWndQczlPTDV4cHVh?=
 =?utf-8?B?cS9XbDIwQk54blZQcWpTN2ZpbUtZRHRoQVQ4SVZWekwvZFlTU0c1dGM0V1hz?=
 =?utf-8?B?c1FHVU9Bc2czTzZVTWlkZjhnR212aVpQZzBRTHBQMnBYUU8zYWdnV0QyME5V?=
 =?utf-8?B?Vms3enYvR2RsSEo3UFN3YlNQdGorc2szdittM3B1TndKbVNZc1V6OEpHb2RI?=
 =?utf-8?B?WWRvRlJwZGJMdXMwZ0xHUjA4eTNhY3c0c3BCMkZpY3V1MHJENkVIUURYUllQ?=
 =?utf-8?B?K2VKUzJGdUJNakJudUEybFJyQkxHVktLMk5VdDVDQWdGRFhZZDBPdTBjSHdF?=
 =?utf-8?B?MStUY2ZTWTRMTlUzZjl6WW00ZnQ5QjhjdFNMRDJQaVZraGhwZGtsdmFJOEpC?=
 =?utf-8?B?S3VQeGJPeFRKc3c1cmd5ZklCUFc3MTRId09TL1NHb0tkSk5aR21WZk95Kzdr?=
 =?utf-8?B?MDlDQmVvNmlyZVJWeFZGREdQRHlNOWF6Qy9Jck5EV1pNUlUvZ0ZtdExicTVv?=
 =?utf-8?B?SHJXSit2b3MzdXVyWXJGdy96ZnF3VmpTSldUcXBhWHFyWVFmNTR6elJCY2I2?=
 =?utf-8?B?YjJVY2NIZEZ0a2lXS1RYQTFQUDRCM1ZtQjVVSS84L3laOERDS1gvUTJVMXhv?=
 =?utf-8?B?SzNwZEgrN1RjcGVwdXJLc2xoaUhKK2FGb1dxbml2T3ZVQlBjU0xjNFZqQ1hv?=
 =?utf-8?B?b251L0pmdTE1ajI4YzRKRm12c1hhOVBndEtCc0gveUJudVZKVFNJQ2Fkd2E0?=
 =?utf-8?B?aUVBUXBlV3FYUmRveXpqWTliV213WmoyS21abG1nZmhIODNCNDBQVFZ2NUE2?=
 =?utf-8?B?MTVDNUhqL0h3MVBlVVVLYUVtdDRyMGlCWFNnNVRYWWZ5V2lrdEFzTjFTQVEr?=
 =?utf-8?Q?AGs8pqWxlp4XyXXiharCkLzO4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd0c928-c7f1-4ce2-1c66-08dd881ed168
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:10.2090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63jBJl68H3AcJN8ocKQzcfWEwnE6UqSIS9XRz0bF9cuLgxxqBAdaWRRIyBo50ZgDnjzLKTV9nyfe7bY/diGO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054
X-Proofpoint-GUID: T9qrwWMAt5RWW_BpEIN_750KX4q_RohL
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68127c9c cx=c_pps
 a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=wpC-zHkb-u0RuRR5rtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX0YzQKYHt8m39
 /OzcsJHRiioEmnLN3bsYGP7w2t9yYpxXfFeveFKN9bmmWqviKpP78qr1BIbIzVXJxwjguiMoxHR
 Nods11/NceTyTOWplUckvWE6N4r4Kn/1XxVLqHXrZNQFMZNB2o0AgTZLOt868rmEiPbSZJ0Cl65
 JpzZ8hZryBliLHSwQr2Rwh5dRXKqWCAG6J1tzRaIXrbjHpY1RO3Ky3CmHW18BPBtCj3TYyb1wxy
 d2uUaNR1QlOAOESpFi2NlrKXPhkDfQkDC627jCEtumbwAMg+hsy/NRHzba6GThhCsgtQZihpI8O
 yEyM2Ta4kFbA4MSywHtjOwiGCQDLchcWmjE+/FIaF9noS8IN+Pzmi9TN4mciLy2WQJ9k9T6/4gL
 z+mzjfxIOvXAFgmAoqIiX6hRmD3wDr12KK5vr1ZmQCIDoHrzcFznAc7WasbxWnYF5Iwt0jJl
X-Proofpoint-ORIG-GUID: T9qrwWMAt5RWW_BpEIN_750KX4q_RohL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Hi, this series is against the vfio-next tree:
https://github.com/legoater/qemu/commits/vfio-next

The series contains patches to vfio to prepare for the vfio-user
implementation. A previous version of these patches can be found at
https://lore.kernel.org/all/20250409134814.478903-1-john.levon@nutanix.com/

The changes have been rebased on vfio-next, and include changes from previous
series code review comments.

An old version of the full vfio-user series can be found at
https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
("[PATCH v8 00/28] vfio-user client"). Please see that series for justification
and context.

thanks
john

John Levon (15):
  vfio: add vfio_prepare_device()
  vfio: add vfio_unprepare_device()
  vfio: add vfio_attach_device_by_iommu_type()
  vfio: add vfio_device_get_irq_info() helper
  vfio: consistently handle return value for helpers
  include/qemu: add strread/writeerror()
  vfio: add vfio_pci_config_space_read/write()
  vfio: add unmap_all flag to DMA unmap callback
  vfio: implement unmap all for DMA unmap callbacks
  vfio: add device IO ops vector
  vfio: add region info cache
  vfio: add read/write to device IO ops vector
  vfio: add vfio-pci-base class
  vfio/container: pass listener_begin/commit callbacks
  vfio/container: pass MemoryRegion to DMA operations

 hw/vfio/ap.c                          |  19 +-
 hw/vfio/ccw.c                         |  25 ++-
 hw/vfio/container-base.c              |  14 +-
 hw/vfio/container.c                   |  66 ++++---
 hw/vfio/device.c                      | 192 +++++++++++++++++--
 hw/vfio/igd.c                         |   8 +-
 hw/vfio/iommufd.c                     |  35 ++--
 hw/vfio/listener.c                    |  82 +++++---
 hw/vfio/pci.c                         | 257 ++++++++++++++++----------
 hw/vfio/pci.h                         |  12 +-
 hw/vfio/platform.c                    |   6 +-
 hw/vfio/region.c                      |  19 +-
 hw/virtio/vhost-vdpa.c                |   2 +-
 include/hw/vfio/vfio-container-base.h |  10 +-
 include/hw/vfio/vfio-device.h         |  67 +++++++
 include/qemu/error-report.h           |  14 ++
 include/system/memory.h               |   4 +-
 system/memory.c                       |   7 +-
 18 files changed, 604 insertions(+), 235 deletions(-)

-- 
2.43.0


