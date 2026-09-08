Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7g-0000ie-Ms; Tue, 08 Sep 2026 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7e-0000i2-Rp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7c-0008Ep-On
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Eh6it3514602; Tue, 8 Sep 2026 08:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+LRlt2odqa2LYTlePZq3/3nHiT2YEOcd07D16IRHZ
 1A=; b=Q+bUwWXns+8bphzilKHv79BljuCZx47q+0X80OjmDq4BXJ5ptMpn+hqgs
 bzIpC0ufeQvajv69GoPSZDTVdBuoaqkeYOMksg0UJstf0YSRGcoD2Mqq6dw9k08r
 5nXh8zDZ8g69ZFlEVXNhryQTmDoZKp6qhb8hT/KzHq7ozSeB5dVMPKOEV8X+DgmG
 eFm8TOUoqodega4EnZfw+/tnh6pU00slh7jTobbAegXcsphU4nOjpytb3GKTZalM
 UcRY/IDX8MPCrzqIR6J3fKeabsyoD/9XIJAYTrtM4kYHkHyGmn9j8FVns8i0IFi1
 4H5SYPhU4/qiKMlaN21QkQvRliFPA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021081.outbound.protection.outlook.com [52.101.62.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ex0sq-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThD4H0KK9ggnIw5wa0qOBbVL0ee/OmTL9Fi9Q1FZOPBoDil7mN6KAfcV6SJlE/ME4YG2bzy1HftUZCQAv37DBdmh9dY0oCdSlehCEZ6rtr2zETfo0K0MVZzW609mxrQY/3y7JdQhb/gXw2cxypif4gEnFhIseCnrkIUh8e5ASYa3+TLgNlGKywwD/SzP7/BAyKxQMjDZBBQCz4KmlPxcewVv08XuTh4jssPyu6p0YICvzcuEmInJ/oaJO+zLHbJIDLtHBUOMv7lKzsNfcdJEBEarm+vOIcp3Zg2K+GRsCgF6D+ESKArGzfbvSA+lsgBw99fY/RmZxvldTO/8aoQWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LRlt2odqa2LYTlePZq3/3nHiT2YEOcd07D16IRHZ1A=;
 b=wgJl6rPqsHO/CBXP+rjf66+w6s+4npFFXIthYw4AZNkp7dKTLnh0X3mnvoKc8JbejqJjKoJCfbynTiqrizMMoco0NTcMgM50VYppmYP/nQAKWcE5uO2AqQIwi6oFeDeOYvTm178wL4c4M+bYZYGe2BH/EwCu5tja7cJYF172YwvhC4GEoxOljlDlTxd+BH/F2VDfGcu+vm5E3sqyjoJC1mlmEtwwyirP5KPWHQnto/joqFNMAuwaunifU6f1jc0J9xdkNFndLKdJp9RScm/vPQDkf46BUPSPK66ZdGJoHj/YnKskDbTjUT3uagPmgVJANwWqaCCIRd7PtEEvpekodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LRlt2odqa2LYTlePZq3/3nHiT2YEOcd07D16IRHZ1A=;
 b=ONnbnCKlA2lZaFxLSyBsPyoklnmrkLd4eFMPtBTLrGdBiyNybGO6oJy7PQfWSz7Rvn9aJ+gW7PlBtUvHIUM2K1o/jsbdpyeL2G4me1cDhfTGKE0NB2UsRQGGucX4QlUtuTUgN94AeHIKe4sNLhU8qKcy+FR1Dckl+ipu+B/D+3tAd5wPN0bW2Gn0HA73rzGPiCU+Wke9DOJwyaUdtflUYUdzHdc0NSEbPEJly7Afz4LjIwJ6Tc/Ga2CCp+qttAQd5o1+o74ZP5tNmONjfyMYFf/MvlSJcieosB9FJ1fcFSGbCdyCR5AwGWmxeCciDBBcc1dfswDrXKtCwdc5eVchOA==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by BN0PR02MB8064.namprd02.prod.outlook.com (2603:10b6:408:149::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:52:26 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:52:26 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH v2 2/4] hw/pci-bridge: Make speed and width for PCIe ports
 non-experimental
Thread-Topic: [PATCH v2 2/4] hw/pci-bridge: Make speed and width for PCIe
 ports non-experimental
Thread-Index: AQHdP6oLwHQa+tJpwka5vcOpmDca9Q==
Date: Tue, 8 Sep 2026 15:52:25 +0000
Message-ID: <20260908155223.164787-3-david.vrabel@nutanix.com>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
In-Reply-To: <20260908155223.164787-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|BN0PR02MB8064:EE_
x-ms-office365-filtering-correlation-id: b3d0d18b-78cf-4206-7f56-08df0dc12dfc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: jblzAHdc7CRhGZXi3QROpdQjy2+0m83gKBHu+0fPvv+H2T+ngy/nwvg6TuwyhJPSIKkCy3lSP+S9X+u7Cv48/Eno+yX+3nBEhTio/ABhswIBKKJM9cJEDNXLbJjOY3jricKJA1gZxO+m129uwKoFlCfl2Z9jRi2h1gGa1sb1X2KMZGs7JSXgfGVurUl1XS/MWRNrBgLMPAiOITapahRcum0z6eSMFjVXK8hGIAtjlVqO4oHUtcyGG+v3tvYWp1yAqfjvfF6RewXDI6uuOn5EXEHOoIFQdE+PQh5HCS8U92+kRt9hEaSmQcxA8Fv8Wgl1vGUccfMm1XzdHRJdDqtqersieY2kzALSr9aU3BwcT1In70kOr1bLIV3o2hHCsTeGU1x4353IHQH8s1kOqI7gvnXJVWT+INW7TX3SQ391hNqjRWHlDIIqVi1VwfA/RZ+fMNE6HNPOHQyL17wix9Ns9ZE9J3sXZfeh5Uk9d6opCakKvjGjNE/Gxy3DFkLnoHv5Hfbz93lPCQYeaHeOy+V7L08pQ8QZ3SZ+wuuVTQZnWaXKjowq6uqYiYirQIi/Y1hSoGnfUJq5pDzfzqs6JyNsdQgq/tzHE7iRQCB0DMvOKWdXqjM2v7/A0mWlPau+cpbgFEzQmfpII7g3LYlCEkQYr5uBjqNDIjuAM4DOJWCYd7FHfjpZSU0QGFyDMlVtJBrC4siUobye8PCijWPNehPRqZeG1aoP4F6XmPuGKsLXcm8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bnRvjVis62rjiApM9PGZJ6OQmW7+1vMWcdBLP+fSCiNTpGXzbzsSKETMbu?=
 =?iso-8859-1?Q?dZA4EWe7Sm9jPmRwPZiVaphFFlwTO/aXSFSVR8XBVBWoWE8tpBjbXPYPjW?=
 =?iso-8859-1?Q?Gy/Du73GU7u87R+AMD6j2pUZBLaJk5kmJDrPDlyC5iBSCSLY3JFN67ANbU?=
 =?iso-8859-1?Q?m/O813+r/ntC9b1jA/DJYLJ4iHoN+KKNM9O4YrKs7at2sfsrbR8Bwy//FG?=
 =?iso-8859-1?Q?UGS9BNIJIqe9M8ZacGXrsMStGw4ohppbdBcuQOkLfmQXV5V3j84EnQhJxO?=
 =?iso-8859-1?Q?CGjVadCzRG8HS14iOLyr0ebwpyyPe+QQztd8dTyioDkIuGYGeDB6v3GZbS?=
 =?iso-8859-1?Q?8LrKiSs/kUJ01xkCDKIx2VAUuVmdOTYY2QO4vnyRNSM1LhV5RLlSDx0Z9F?=
 =?iso-8859-1?Q?FmfcyoNJrvlGqiwjQ7zT7tfNx9bI7YKN4UonYx1X6FHQaHiSaZvDPs4qQV?=
 =?iso-8859-1?Q?E/14qCuZ6Et4nCOgIqAXb/NGHWDAQLNziF3KSHfdDLOR7zzj55K9+TlwZo?=
 =?iso-8859-1?Q?trJ6KA0zKfOuptNTL8utIobV6FFlEDQLqfy6CMRSQXjjhXM9Dp+hwgJKK3?=
 =?iso-8859-1?Q?/204+yRfC8c+c26uR6VZIKs1PzLgtXTxOhZtr3zhW3JWIfWe8Oe4U8JRj1?=
 =?iso-8859-1?Q?kXbFjOTyuhyyOVwkcxyEyXffLR4xtP+moYKKhkKt5QMOBns7CZQZrMHXyL?=
 =?iso-8859-1?Q?Iu8lcxjgQBhrtbTISHD0RI0oMJkfKf2g9OIZRWxbvAWMioTAolddt5oUR4?=
 =?iso-8859-1?Q?C7dZ0B+PihAdNMRSMGVY3+amhgCSQihdoYjQC+cCk6mR7QyMGYF7NbKMhn?=
 =?iso-8859-1?Q?aw9v/Yyqf2tWyo0XI2BwcnzxRlhc2EJ5UTfequIN+0stXVFIXekHAi2sc1?=
 =?iso-8859-1?Q?GN1HK7fA6lYAevY3Hxzpf/zLojzm0XK8xoBoNKySLBy526l0x0G03iNFry?=
 =?iso-8859-1?Q?iv07w3X7m9pb8mAMX0k/KSbcbMgmWxQ2gmmWNCAabVrz2xobPKq9lklcLm?=
 =?iso-8859-1?Q?ZuJTy+SOrIdAIhg8cEXHBoeO6y6pdJneVHSatdU1SbB/u3bUSBSCGgjPXA?=
 =?iso-8859-1?Q?ht7n0Favg+iChVNiYMTqRdLuvPvW4vja4Ht3z6Qk9H5PHARxv8Ea/xuH5U?=
 =?iso-8859-1?Q?CUQD3dcSJn6wtnaZiENl5+Ogxmv2f+JI4addka9QhG6COcD34adYzNMO3I?=
 =?iso-8859-1?Q?QYqZKgieQbDdPBfWtMSIj8XVFXRLsoW9o7xApRwE3hChw/Mzhgx//OlvpI?=
 =?iso-8859-1?Q?C4yMHsqyU4Oczpxc1/GCt7aJbohpPGltacZg3q5VrKSCNCV0RQ1KmYrjAK?=
 =?iso-8859-1?Q?ZTdmurHxMYmQsu/mq2pXrdfil2js7gLcORZvz5kKnJ7ZOuoKJQIp1pgNgG?=
 =?iso-8859-1?Q?qxV93BFsX/T02j7gB1ah0A1UROVT2dmS54b2bwjPgO/E3XmOKQ4euZITDE?=
 =?iso-8859-1?Q?W+2o5xsBN+z5xPCC82cO9SFw1wjRVovCngJFqZSJLkxvrgH5ih8znPV88y?=
 =?iso-8859-1?Q?nQhWz63yYHGZUkg6AzuJJSIDLos0tARLLO4etGGspe8DRdflgNkTvWpyVr?=
 =?iso-8859-1?Q?NnYcrSylV7QFf6OCllisdg0wEBjNhaZ+I9SK/Iq0ggvnqmAImuLCss/vDL?=
 =?iso-8859-1?Q?t4s0i1548K6XgzV2Ezjxyms3wKGg9iEtNiI2fB2hDsokkzEsKaGkGQStot?=
 =?iso-8859-1?Q?CpsuCtk23pUYCpvV2DtyE+djgOq6OluzUpXKCVd7HRHtkPeLlk1ozlpMi+?=
 =?iso-8859-1?Q?ae/a/JmADpJy4XbNjf09Sd5J7a4E+FilN+Cgcm8O5d9S71UJEqNd4x+JGD?=
 =?iso-8859-1?Q?EsmE2QC/or7cpzp1wazrRm+o3oRQcXo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qlmeV19/WZK4TfnJgzktL8BchHecMJegDBAZv+1/05sx+el25iDnt3+z8ACrtvxPAwEFxplPxq3ulTMAvKkh2pzEQlVSBdIKdiCC1EylWcE2n5FijVhdZ5EOHOsrWBqQcvWIfhKx3eTW6HTek26UDq2i6N5ZZ3PpmAYLHXak0Obp6WghqKDbmXC8MstYWkT2YmkuVITDLTMV6cHbB3p7tf/EQE2x2yhoAwynkRP2D8KReSWO5cLbj9l/U4blWEtj/vXelz+1InAbEyITFR2KIFkp492cVlXQQ8zqm5mj1p3G4craszZeOTudre5f0D1vJtM6FMbX4cWFBXay7sF4sQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d0d18b-78cf-4206-7f56-08df0dc12dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 15:52:25.9619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FezhIsl/aNy5g7Lr9nG23mp+QamPF2wRpic89wZ0Hjo4jglHpvfRm26JD2cGOnNg6hnd/2lBcmu4oAFsPx963+Ya8fDpRe6nFLiHhcVTW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfX2/Y4MiD/aUV8
 BzIjJayPcvv9nlk5foyfgaHcXhBFv7PwYNFabsYK9CdgXqWr84cEoaNF2fJWbRNJ41/c/l3MGeF
 sxB8NwuCjhi+NdtpuRUMklv8M7hrN/dPE+alqTMfrmguYhM8p8oX+VpYa5yiCclcZSlnUY1qMA+
 Qk44FhrEko6grl0sx33j9m+LJz5Bl+kHftx3pFwe/wd18T1y5No2P/DS8IY0+nkWRHy9/VBK4PW
 WrFQIhU7MUDM4OxLbSx/bNmHrB2rhvIyATsxW1BwjR5bcXsVgFaNMF1jplc1Tb6W3j228Hr9dwq
 G40k57pLV0Vf/7cFKeoentjg4BJmjQdDzlAsMe5FA2FcraQZ/QbFfbrW+znvvFOe9XDyqHL1Jqu
 wAqILfXOBlLh9fij8wiVnvCCsuHgmLV9zgmsHMHSKW6eCtEPuN5EzMlL3Npq1COjXuw9g1weg89
 iJL7oa9B6e3WHLf/OWw==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa02f3d cx=c_pps
 a=7ywGlyDdJUFJDTdbuALIzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=Ttky8AElcTD8thzn_3UA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: vajVlrBTr1xs1BMGGjqsEzCcCb7s7xm-
X-Proofpoint-GUID: vajVlrBTr1xs1BMGGjqsEzCcCb7s7xm-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfXw3lIXSzUu94Z
 co9QNUaNHH+76wL97MNQy7+wZeD/SlZq9HV72F5Q6X+gtKrvYxLT3aJOAdVbSoSdFz/Xi6m5C+O
 /HArXkpHJs2nJddUV7tiwro99QGtG58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

For guests with passthrough PCIe devices, in order to make the guest=0A=
PCIe topology have the same apparent bandwidth as the underlying=0A=
hardware we need to be able to set the capabilities (speed and width)=0A=
of the virtual root, upstream, and downstream ports.=0A=
=0A=
Promote the existing experimental `x-speed` and `x-width` options to=0A=
non-experimental `speed` and `width`.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/pci-bridge/gen_pcie_downstream_port.c | 4 ++--=0A=
 hw/pci-bridge/gen_pcie_root_port.c       | 4 ++--=0A=
 hw/pci-bridge/gen_pcie_upstream_port.c   | 4 ++--=0A=
 3 files changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_p=
cie_downstream_port.c=0A=
index d593846ac1..8fe71382aa 100644=0A=
--- a/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
@@ -163,9 +163,9 @@ static const VMStateDescription vmstate_gen_pcie_downst=
ream_port =3D {=0A=
 static const Property gen_pcie_downstream_port_props[] =3D {=0A=
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,=0A=
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
                                 speed, PCIE_LINK_SPEED_64),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_ro=
ot_port.c=0A=
index 5434d693d9..d3ace7f0db 100644=0A=
--- a/hw/pci-bridge/gen_pcie_root_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_root_port.c=0A=
@@ -129,9 +129,9 @@ static const Property gen_rp_props[] =3D {=0A=
                      res_reserve.mem_pref_32, -1),=0A=
     DEFINE_PROP_SIZE("pref64-reserve", GenPCIERootPort,=0A=
                      res_reserve.mem_pref_64, -1),=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", PCIESlot,=0A=
                                 speed, PCIE_LINK_SPEED_16),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", PCIESlot,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pci=
e_upstream_port.c=0A=
index 57d7e09485..edd5bfcafc 100644=0A=
--- a/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
@@ -139,9 +139,9 @@ static const VMStateDescription vmstate_gen_pcie_upstre=
am_port =3D {=0A=
 };=0A=
 =0A=
 static const Property gen_pcie_upstream_port_props[] =3D {=0A=
-    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("speed", GenPCIEUpstreamPort,=0A=
                                 speed, PCIE_LINK_SPEED_64),=0A=
-    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("width", GenPCIEUpstreamPort,=0A=
                                 width, PCIE_LINK_WIDTH_32),=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

