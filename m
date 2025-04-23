Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0E2C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7a0j-0005MC-L5; Wed, 23 Apr 2025 09:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7a0d-0005JQ-V3; Wed, 23 Apr 2025 09:19:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7a0b-0001fa-AS; Wed, 23 Apr 2025 09:19:27 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N9YXg7006283;
 Wed, 23 Apr 2025 06:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BE9NSF0DcBrSbzhDnr2w0rKwriQ2CSiW4sXNVro8l
 RQ=; b=Qz6NMI+XV6DPLl7jlEIl7Zi5YRlEPKCK2ZFW5ZBLvO0DnjBIivnL1O/dS
 0PIXChIiQrD1OgVBTxV0SNLMevo3n1jUgOVIbAJsy4jsb7VVhFPVWnnoZKm0PeQf
 rRAfa2sojHo6Xe1VsZRSOV+OnGRscur2RTQXkg8gEh/OI3Kbe4VQfAkk3OFsnR0d
 Xi8lEt7V7W7SK8vKQ2SIp0X1j80r8hjnj7mwJBR7a0ke7duCYMZSnMfxRYPqPmQx
 +5c2V0KjKL3rbU/EJl5VlnVWhw0yvf0Nq4YbyJEw+xjidAinVLxVVC60vMZ/uRIZ
 knOQtOhfHFMPaeEI30tvbeTTqBiVA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhq1urw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 06:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZtFZkeMxmtZgKlEUw0jKV94ccwwa9I/YzfRsvucK+DUzwvCl4dA8O7LN4zSe+bC0PVOWHO/aSXKwuj+TfgB1QStsgc8KUkY4/PWcOaOyoOhkcOh+MF0uG/WoXPzheVZyqv4GcaMT5Z9a29xGyI1y0MEZiXOoRvnzhkNRxh4J79iMS7xCuj70e/0QUoIpKDNBge7HWt2Ma6XiVaxuZMc691TOqKuwFlQ2ciM/h/QpAq1V/NM+nKEuNH3ApCNSDQcIxO11tA2byx748/3vq6vxEB0b1ZDcaXMYAH1XWX213U24rFUkPkeA3YoL2I1gPvOohu21PrzVxLsLwWv2+ikIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPo8zcPmO03eZ4MEZudQICX7A5IMWF7p7jMgTPBkhgo=;
 b=Az+f78sKEsMiwQew0Ja+KjSCu5cIFBVIQI7O8zmRlVUvsCmgEeLLNhBPPXg7IDvMy1h/fVow/3ArB1OxHHTl6C26nak4MqjaxXGBj/8nkP87dhgB6B6E1KUqyWDtUgY5W9yflmllMAO1+skJKfesvv9Vgo5WFrOLuEZPQOeQYChQXqV5/5LnZOHd/tfOQoxu+Ou03W9GS+XDoPjhLgEq7LZvd8NhpvL2021aCMr0u4SL6cARXaGjf4k/oegMUl4b5A/N/7uGx47PDUF+B4V8rKyi+EXBdHZ3aILPtcc1ShFRb7veTO7eIfYTNOry+FTjrbkKqNPWQ0fdqTD2YB6JRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPo8zcPmO03eZ4MEZudQICX7A5IMWF7p7jMgTPBkhgo=;
 b=LnhzzD/C4g+IXI9Q+TrAiR8k8C5WoKqGFwQ6A3Ecc2EYPc+Cc9doDIyx4bOVqgY+xaqN/Iv+uoqh5RNHYMvFu3kK4ke28JE+L4SyFxCKuHa2FpsQvTIuLdrH07998/m9s2728n+bH4sVC4tq5NdgD+OmTVK6Xr4rzbJBSxNyEiYAvHyFC40RDkCkxRp7RL4PvZ1Nct4/HpiA5Djg/QR7saLAoxVakw27/pwktTPcsYSBFpPYYjl+OpmVqqwDb+sd9l4mkSSZH5bQ41NWkVDKpNPFlhFydU/YJ24R8dBEgHIcsH2526LgDQPYzGELKsJRNdlRWgZnIqwzsQfECRhwVA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB8816.namprd02.prod.outlook.com (2603:10b6:a03:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.12; Wed, 23 Apr
 2025 13:19:14 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Wed, 23 Apr 2025
 13:19:13 +0000
Date: Wed, 23 Apr 2025 14:19:09 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 03/14] vfio: add vfio_prepare_device()
Message-ID: <aAjozV5cuw_vO9LM@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-4-john.levon@nutanix.com>
 <599c9722-0fa1-4f37-aa1e-d801986ec6e9@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <599c9722-0fa1-4f37-aa1e-d801986ec6e9@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c94a892-751d-4e73-8dd4-08dd8269710a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F8nCc6rVJl8AGLyOxsRlF5mj696r+BFz7xCbyNsVsE5gQUMxQ8+WBdYO1E?=
 =?iso-8859-1?Q?ezUgm+NhyHegXe6yvT09KnFBRgWBzxatPoyekP9b1b4YsyprV4yszue3Sr?=
 =?iso-8859-1?Q?i3PBb6egDalUl5amL2I6QUrc3E9EMERPiKWYvpRGXIur+xShduhgek+tDw?=
 =?iso-8859-1?Q?VaqwOITot2gt6qpTRFHnzgQ4FaxheFBiLzBlQrMOWvSrMuqCVYd1xTg8rv?=
 =?iso-8859-1?Q?L4D2T2A2zh/BFO3uyad2RC8TxK9k/S0K79qGZHHzQWjcxI7aRARk+q5M7s?=
 =?iso-8859-1?Q?irUmoG7+Un5W1fSh9100179y0p040why0T84QvS8qBVd9ktSkTowepIAU3?=
 =?iso-8859-1?Q?xPtCqenMdYSFSatF3yv3pSSejJuhfNcXrLV2HeTFVleJy22UpjgNFhJcxK?=
 =?iso-8859-1?Q?pM+moiLkFJj3iJrikcwh7Ft4ICrel1B8fsTnRMTjH1H64c6gQzdImrfh9S?=
 =?iso-8859-1?Q?5pZNtZtQP957cWP/Y1VQ1bCQmrySptpxEBPU14EgQ+Ir+nkNIB+QwPOj6B?=
 =?iso-8859-1?Q?0VHZW9UDNGb5cmeUszgxYRXOKzWPgqkOVdKJIY/15EGbxYvDCzWfoCrPP1?=
 =?iso-8859-1?Q?DZOq3aEXRIPsC7yRBFDqc/7K2JV0WtDuNw1q3KNq9WOJEB1n3UMkNNUPbb?=
 =?iso-8859-1?Q?MWfe9clVD7Ob/VBcs+LXDLsB6f8MUGy3wtJmVeCyAfUh2ntG3HXpHI3ZUV?=
 =?iso-8859-1?Q?Yt133UW8Q+UNBzlD007TrcbJC/h6RDHy8DKzUOppIrUoKmtmPphNq38ynR?=
 =?iso-8859-1?Q?euFGyz+2sNArr7bVdDIN9UVQV5XZf3gt5hhQWZlz7l0EwY4cfaXdAb+Z5N?=
 =?iso-8859-1?Q?0d6w5nyYxYTkuEhHBiOCX3S4Xu0/iymFQPIdeRTIEinspI6eR2mX+2ltaZ?=
 =?iso-8859-1?Q?JHDjIcKKVeHJ6UK7aDrFeNvwCPsuW8pAe5DC2TPNEYjVwuyGaMfFTRMk4X?=
 =?iso-8859-1?Q?n2NvxerIfyWmJMsA14pCtNv/TkOs93gOIJsxDqrXQ+DL/M6weUX2WsLmKE?=
 =?iso-8859-1?Q?1DG5zxP7IzBAk2tfE9ppwvPc2nGALhoCNUYpexYABje/Dj9St4KBZ0oPJb?=
 =?iso-8859-1?Q?g20YKszMLKK5NcodfMR01RnHPvcNmOnPm6GxNoiRztnh/P3fN9PDXpxPzL?=
 =?iso-8859-1?Q?sUiOSz9lXd8LPx+YaFTFfVyCZ4zDiQ0EVCNSrYvXzp1QD1haxKPLjg3jCI?=
 =?iso-8859-1?Q?wTpGiqDOb2IjukgR0m9aDD5s77fU6Hvab7eAsS5Waw3dt7a1MJlBdfdiQq?=
 =?iso-8859-1?Q?oxVdM0QS5AFB7u0DYZqHyXEhOQ40VhyAXKHckoDmw7f+9sCxMGxwQN8xU3?=
 =?iso-8859-1?Q?P+y/3mltb0YgnekAFGsGn6FnTPxLX1yopUU4nT87biHXAuKwCRXqW2MhkH?=
 =?iso-8859-1?Q?3PCb+fQ2l0RVk7/+2Z6HPR8YOMmT0UxQDWm20aqTo2J2pJibPi58ILVADX?=
 =?iso-8859-1?Q?bQbz3kas3+EhmriIEySBNsZyX+hrc6EMdMkSB4pqkLExlsUJuKq95cM9H9?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IAmMpxcicykdEIZsqe2hf2/jdrJ7hK0ttGIeVI9d4EjuFoLCxIUgWrOeQN?=
 =?iso-8859-1?Q?oEoE3zAxUBSbgh8aAu+IF8XJPJwQI74XZpTsMKmopSz4+8pQ+HnwG5TgmN?=
 =?iso-8859-1?Q?L3eBQDR+/pLJd092eIHzKRqPH02tVeQ9Z4yrm3fWqGf94EWHhh+nqyB03H?=
 =?iso-8859-1?Q?PLm2+LmhISLj8/mYXYgFGAra4Fz0RDxXcuaxNxGvYbsiOzVlhgaEbHcvTW?=
 =?iso-8859-1?Q?Kif3BavC/Df/qrAIwyw3rYfUn3PDHrKw+LBvurBqOpjA+EjVXz/2E4oEs1?=
 =?iso-8859-1?Q?FnwnbVPwZZiY5X21asoZbU1DnkCByxBcMYvHlmzQlqKGacyepeJetgeuiG?=
 =?iso-8859-1?Q?yiysHYzCiXxyr8JUrfhqGzwZWQntMAbwbVZbxOyQgfxIRBDZFjk5fnwy+d?=
 =?iso-8859-1?Q?t15frWwfcshNO820v6BQ1kBNDdw748hsvipNuN41UHXHy9OC7bE5V3aS+I?=
 =?iso-8859-1?Q?zxTN4GLT5lepfa1ULLD/odM1BejHXsnEe4oNpwMVjwkOk2xB7yUfiKnW+i?=
 =?iso-8859-1?Q?n1bmqy/n/fuCRtJNw0qo6um6Lvmo8jikcAiLmmN8dG7KwiKEuyWyLhlZHB?=
 =?iso-8859-1?Q?Ytu/jKWpD/vnIEmhqVtu8QptrGumhqZ2hiepPaRCIOVGMlvaXudOfECziO?=
 =?iso-8859-1?Q?I67DePqvWoAfDwbvMpAHifnGONV0j2pILfv6Rc6sYiVVr9jO7eiK5Pu9o7?=
 =?iso-8859-1?Q?zf8moZNsEfaySCREHdXUiLCILSjPB9vphewFOwHff1krdZE0tgCTBzS618?=
 =?iso-8859-1?Q?HxMO3b3lDx/JpO2v97uSUypcbj9mNL7nbzUmLPssiPlIuQtlyOr/C2ogIp?=
 =?iso-8859-1?Q?WJjnL1fQB4dG6r+tS+MLZ1lxvyQhdrjFZyhHeyKNAKh1GumNrKX8FRWYs+?=
 =?iso-8859-1?Q?GVjdTFRnmuGNWhVn/4tF0XKYo7fIDx5aPb6UMitm1ViE4G1m8iqR5/Kr5E?=
 =?iso-8859-1?Q?gvq2fI2z10S9SDjPueBgvbLgvsnfGzb3VACv/1Bjw8WhFJIZt2O1CZ6gcU?=
 =?iso-8859-1?Q?i6Ym/d0OA+4+2CY1W+Wxhf6LS4/gigiX0msezmJ5pze5mqaZbkXJgCglEu?=
 =?iso-8859-1?Q?dk+hkprvrLT1EJ+ztxVUMT5Zx2jc5spzVisZ5UKMnEDTaeSi1tAbqbXUA1?=
 =?iso-8859-1?Q?yFeX/ozjUZIH2E/OsU3Nhf7DVWTuMzbsq4F7kttyyk93L+YIwr2G1BRPRN?=
 =?iso-8859-1?Q?WavrrnbqEKnQ7RfiDtuep5hHiBNqeRGdK1/aP7WxZ609bZnE5rmiK8l2gL?=
 =?iso-8859-1?Q?oo906SqJ2mVOBmMVCtueY1iQjsrjUYUngX5mswCEFN2Y2qUNPCQA1iFc+f?=
 =?iso-8859-1?Q?lNDKOmZIUmNqNworSOBNrmPi0NZjwvoJX5wihkoFsMRTZKPFakOKUv8Mfn?=
 =?iso-8859-1?Q?oa2zlgUiXEsQjbWpjzOukLWj83kRJi8Bm5FPx/4uWOVnC1GazftfqP4Tyf?=
 =?iso-8859-1?Q?ZpCqMyFyCkuoDEHEb1iBtNZSDKNkeCMPuWPxCIjWI+PbGbpmdOMoI21odt?=
 =?iso-8859-1?Q?j8Uw8ervd74crSwdM/ytH0H0lASMdaLAZmYQXBTJrib8KpNLKTFB67CvQY?=
 =?iso-8859-1?Q?z0JmepE9jYemjNcEqE8/VBsSpj+GjxXZmqwtA+zNKasdwN5nU5gBBiCS+m?=
 =?iso-8859-1?Q?8t2VEO6KPodmT7YhTptORQf6jctx/h0THc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c94a892-751d-4e73-8dd4-08dd8269710a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:19:13.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0RR3tud5iYpB8ujWPLcM/DShs4FTOMKWizlKHxTF79Os3Y9stLqfEpNq2rsmfewOeOY3CMObjM+uui4QuqRFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8816
X-Proofpoint-GUID: u6l4SiwWsSm2h-YgbH-uBtWbqOUgbmMn
X-Authority-Analysis: v=2.4 cv=fNo53Yae c=1 sm=1 tr=0 ts=6808e8d4 cx=c_pps
 a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=J4015kxiTKtahP-Zg44A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: u6l4SiwWsSm2h-YgbH-uBtWbqOUgbmMn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MyBTYWx0ZWRfX4gXRoy41uivQ
 /ClY37wVADl9cnhhy8a3mF0ZtqZuO1lW8yUWbW86Wihc9lN09t/o2b8Hh09qTSLnSN7vUQPUNFA
 KwVQfHAEPOkLr7V2mLt0AQotpfIVWRgYQ1NO7nrQiI2tYrRpWwGAO+xb3vclq1eSV/aXW8+mo55
 4HtNCuyIVsL989VyGeMO82PMKd2TOfT6iCQy0rMilIqVeJRJQbHoC1mKaSdCX4iwLAoSp6USMWl
 1LB89UaSHd6OsWOZO1L1RN0/ybV8oHhIk4Xy8FSplXAeMfHJzQHqqiIyouAtAiyuvJbiTRu2BgQ
 Zt57TQu38XwQH1qqIsKAMAs7L52YyksxGeAPFcv8xFB3ll5C/b7wbqtGH6VT0Sn9yVse8wtwDde
 eQGXSTBT3Hiza0GGofGOSJuog7bMf1tGT6JUtJ7NJYQxdWF/Gi+VP2T5A9CDUQK483wySMxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Wed, Apr 23, 2025 at 02:45:41PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> Subject needs fix.
> 
> On 4/9/25 15:48, John Levon wrote:
> > Commonize some initialization code shared by the legacy and iommufd vfio
> > implementations.
> > 
> 
> May be vfio_device_set_info() would be a better name ? Anyhow,

As we're adding to lists too I think set_info() might be confusing?

regards
john

