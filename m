Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114ACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBc91-0003TI-GF; Wed, 22 Oct 2025 12:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBc8x-0003SX-4f; Wed, 22 Oct 2025 12:56:59 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vBc8s-00063D-1m; Wed, 22 Oct 2025 12:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiqtg4BoGvghkDuziHi4xSY3wA+cBumAofZN4tk0HGVXszko6+512eWo/LFq1ao3tE7LuBbF071tpxfRm4K2lDrhMfedYmns1tcKVLCEVR4GOjWL4j9Z1JUTIxguNjJdtS+v6tKNVdto0dnmi9uAwjrvsBYIrxDZHCNfDIIJP8xcbRg4hC15y7DsEOCSfrhPhvDboo7aocSGlMFe6BRf+VyqP8jlyqD2C/z39Qgy6XrZCGhrqGyEH/CUnEOZH1cD06DKhX4T32dSLnsZCP185tOHB2X2sY8WYKpExWDFPTmt4l4xem1Ra96lnTYLOatgkfHDCNfFXsfcmFQCjQ0bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ymd8z3LMXPM0yPg6WpufFR8luixMN5qT6Kba9/AH5c=;
 b=s3yajevzltqK7ruOKwX1CwoajRDJJfmhjlUgcQn0eUeWjSl37pIxROy0zTtCaUyXWNIiU0BDuipkE+8HWa/6INkecW4qaDCzWSNEdZ3jwnyKHND9N+cXxSIfj9XQGz3U95pJNgf/ail5IzQYy8VWoWwW945Hs/r0rideQETlVzZ44J+hrIdJIqj1PNlIqD7TlPMvshfesMA99O8FmpQmlGEk5WIXMVXB8yX9ae5bowEJvdY9sdNREh5tMlyY+yr7utzm+R8034jBPMe255tFRq8//KfOYBGdIHdxNBvv/r0RNO6vp7LKmz38wx0A45CgO+EuK9zm+NAd6WcFrgINcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ymd8z3LMXPM0yPg6WpufFR8luixMN5qT6Kba9/AH5c=;
 b=OmUT210FpaDXcKX6ZUbZ5DtxRX/dRCyee5FAz3g5a1M8v92t7PwCruVmvoHSDvMbpbhcmGYAJkMyBSsvFPbTnff768aaUk/AjX5+EK7pOPLiLR4jF3h+tHyN/fGdC+1PWquk3icVXhxXeXGFdVeuFUZZOiW2Xwo/zsoBAV5+Lo1iir0uAvZFbLXK8c8kju4DVdg5kxYYqfEtYgd3SYd254PGwEodUkYNSpeASBEr/LXkWXDt1G8gKii1wV0/GnFJym1zQWO0uVJl1NDB+T7nRO/K8fpTqTkO9t3Lq9rqDaVItNmxncpmv8623KMkd5+hwCzlniSDqWO11zx2LDhZxw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 16:56:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:56:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcPuxqe+DDJPdOuEOlF5uaJh/2rbTLO2WAgAAdj4CAAXgngIAAKdcAgAFoKQCAAAdlgA==
Date: Wed, 22 Oct 2025 16:56:46 +0000
Message-ID: <CH3PR12MB754834276B67565854CB973BABF3A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-12-skolothumtho@nvidia.com>
 <aPFx7Egdny+JCO9U@Asurada-Nvidia>
 <291fe8be-405e-4ea3-acfb-d090f6a7cd15@redhat.com>
 <aPZ4tcsMfN+2puGL@Asurada-Nvidia>
 <add07edd-3652-430d-b52c-cb2bdbc7f587@redhat.com>
 <aPfXWKE70OuumOQD@Asurada-Nvidia>
 <8cb2101e-6699-44c9-bb51-d092e0024cd9@redhat.com>
In-Reply-To: <8cb2101e-6699-44c9-bb51-d092e0024cd9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PPF7646FEBB5:EE_
x-ms-office365-filtering-correlation-id: 611be56d-afa1-430d-08b1-08de118bfc50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QkdYVm1zS0RLbzJmT2g2MDNSdFRYeTVEMzUyVGwwcHlNY3lRYlhIdjdTdHg3?=
 =?utf-8?B?WmZSTHFRRjZ2WmVDZ1ZaRTRVcUlsVk0yV2xiSW85eFpJQzkyYzEvNU04ZGVh?=
 =?utf-8?B?T1o0VEU3NHlYbjZ0U2owZkFYZksxSVRzSjdUdlhjbHRocnFKMDBaemVoWUl1?=
 =?utf-8?B?TldlRkw3T1BjK052R0k3Z1lOYXg0NDY2ZklqVlZMeFU2YXBrNVBYdlFZM1dq?=
 =?utf-8?B?Y004U0ZWYVVzVHUzdy9OcUVtQS9WR0kxZE04R29vdFdkV0pCczNCcE1uTGdJ?=
 =?utf-8?B?dDdKb2kxQXp4SFNvT3FwYjd1bFFyOEZEbitxTjZQVHFvOVlZWlNYZkxmWHlZ?=
 =?utf-8?B?aUFKR0pHK040MEpLd3pJNHk4cUZiNHdNU1h1L0NLOHNIbStZUm82RE9Zdmxw?=
 =?utf-8?B?eTArQ2pxaFU5UlNhL3p3Nkt1NjRMVUhFWWNuM1hjVUNmdUtWb1lISXcvUlFw?=
 =?utf-8?B?MkRYSGFIQm4va09xSk5QOTlZT3JSNVNYMEo0ckttVUVSeWw0YzY2UHR3YVB3?=
 =?utf-8?B?THVRcnhuaDFLR0VnY3hIczBRdHNVeGxNd1hsWlNBTmk2VEdIeGFMUVQzWUh5?=
 =?utf-8?B?SUVBOUVzSzJ1STRwSDFWSmRGUUJkMytQb2RUdHhpYkRCSE5ISkd2Rk40QnE1?=
 =?utf-8?B?ZldkdHRkclJYMVpVRDRGRktvK2VXdyt5MStJVDRDVUhFODhiOTJXQTF4ZHBR?=
 =?utf-8?B?OHpuclorUTVKZ0E3bWxvV3RFcGNtRmk1VzZqZWJORDRJU3dHdU5adHVnZUlk?=
 =?utf-8?B?MFRJTVVzR0Jyc1JScUZrMmk1ekJFZjRnaE5UYW5YdzNFakdUYTVWTi9ZWFM2?=
 =?utf-8?B?WW1ya2tDVEFvNEJQamNzQXJBZmc4b3pKK2M5alh1NVhLMDgva3VDVFlZRk5I?=
 =?utf-8?B?ZndVRVNnZXUyVDcxTUdWZTNrckx5MW1JenR3QkpCSGY1aTBqWk9LbXpqN3Ju?=
 =?utf-8?B?MndJNi9FNFMvb0tMYWl5QVk4ak4rZlJDam9uK0o3TmF3NGg4Q3hJTTZxSldP?=
 =?utf-8?B?ZWVOTmJhY21Da3U5VmJCdUJWcyt1OFJSWXJ5M3ZPS0k1T3ZrVGRZbzZ4QTFn?=
 =?utf-8?B?ZlJEOFBvSHBoQWZaZFRUdjNoVGNTcHRORXdOMk11Nm1XNUZJMzh3bGpoSm0y?=
 =?utf-8?B?eWZmaXVWWWlEK1NFNm5Mb2tabkxkVHhpa2RUdXVNOG51c1czQUxxbHFGcXpT?=
 =?utf-8?B?aUYyQTZvbXJkazFlaHhIT0xLMzBmNEkySytPVjB0MW9MSEkrZnVYKzJYTnJH?=
 =?utf-8?B?dEo3THJqMnBNcStBdmRvOTdzL0hhNi9YQWltb3NrWWFRT2hYWXRtYVdsNlZk?=
 =?utf-8?B?cldqbnQ5SmZHdEdvbVRtWG5NM2pPTGpiOFJ5V05Za3M4dklvV3RDVDFJWFdF?=
 =?utf-8?B?cEZZbUJieDFWajNyQVNBQjJQZXI5dlFQZjFMT0h6d1BmZm1WVTYvMUMrSFRX?=
 =?utf-8?B?bFZhU0ZKYUc4dWFiem9GNHBHWDBycDFKYnZSK2hnWjQxVWcxTVVmaDFzbkJr?=
 =?utf-8?B?YzhxZkdoRllEWEZJT0RjdHNFaldsbkQ1WTRONzEvNitGWmhvaFZGazVzY081?=
 =?utf-8?B?R2x5MzdaNG9ybFUyRVUzREJNSlVxK2o2MFRlR0cxSWZhOEx1Sm1hZ0RUdFNP?=
 =?utf-8?B?ZVRUVHAxVUcxTWFtS2RvUFhSY01JMHU0RGhBN3c0eUpXaWV4cjh2U05nVVly?=
 =?utf-8?B?YjY4a3RERzNzYmdYc01mRWtTY3F3dHk4ZFhJM3BwWnY1MVYzYlN3RVUzOHU5?=
 =?utf-8?B?cXZmQVprMGtYZDMra2FhZEJWU0R4eE9SS1VJd0U5aWM3d1N4dS9rcG9hL08w?=
 =?utf-8?B?ajUrakUvWmxNREFUaUcvR2RROFVBQnJUZUJxdVYySzl4Vm5Va3NZb1ptdHBN?=
 =?utf-8?B?QkNmbkR4WFZGS0I4NjZRYVRiVnd2T2JlL2gzSlF6d2ViN3NRLy9rUXlDeW1m?=
 =?utf-8?B?TEhsdGNWZG9UWTJ5c0hUenJyaVlxZGYrTjhzVDZrVnJMSk5mMFRlR3E0b1pE?=
 =?utf-8?B?M1JubldKMnllZ2dqb3I1bTR3ZUFzL0p3d0lTbkhPajdxa295djYwSFNFRzZl?=
 =?utf-8?Q?RSSZgi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01oejlXSTlKRmFGU0oyWlJoOEU2Q2hUNFVnK3FhM3BrTko3VkNaRDB5dE1q?=
 =?utf-8?B?K1Exd204MGpmeXdZTnNYQ2dNcHJZdFV0SnFRZ1dDWkJsc0pYaC9sOVhFUmNB?=
 =?utf-8?B?RHZWR0JlelNRdmJUd3cwd0szbktlbEo5UmlSMkYwdnNzZXB3MENTcUZrOFM0?=
 =?utf-8?B?TENpMDFXSXVjc2hJMER3NW1qd2hQL29lMmpHUlpnZFhXODBaYXdvUVpIK2RK?=
 =?utf-8?B?Z1Q3YkVGVWthUXFNQW5OVEhJeCtOOTduUkZjZC80S3BvQ0N2UkQ4MnJ6eHQ1?=
 =?utf-8?B?d3d2ZmlidmJvYVBXN3JXVkhsUUZDZWlZcDVGODhiMkdlWWh1SnlSQnYxbWRs?=
 =?utf-8?B?V1FnMlI1dWdkczAzYWZ0VlQ0Nk5nTkR3RllnbjBhRjc1SEc3NHBTUzdCaUpT?=
 =?utf-8?B?SWVFbkZnTmRreStsbTBBalQvU3FvREszYkJvRGVoZzdINHZ0Y0RrTXNxMVVl?=
 =?utf-8?B?NTloUHlUdGF5b3JuUGxZclBCY0dFMWYrUFVkMk5Wd2tOOUtMMjZiQVdaNlJK?=
 =?utf-8?B?WVQwSTc0dlFSSldWeG9KOGU1SWRFWjNCY2tjVm02TkJ6UklqYm4rR1lEU0xh?=
 =?utf-8?B?aWloV0hVY2lNNVlyMzNRZGkzZ1duOUg3dUhXbFdXT1RMejBBVzBVSkhXZFZy?=
 =?utf-8?B?TExQL3BDNmFRZmpZUlFwTSt0K2JmMlJaUktYbW9qV3pMNHBYY3hka0R0WURQ?=
 =?utf-8?B?QktQWjVzaVJGaVdRdk96c0lndDREWkphVWxuOE1zdzNGYWJFYnpzY1hDMTRn?=
 =?utf-8?B?MUFCTXUrVGVjeUpqREhlL01OZ2VrV2tFYmtHc2R2Q2ljTzd1Vjhkbi9TNlpk?=
 =?utf-8?B?L1hkT1d0elM4dTZoTmtLYm4zeEFmbVdrKy9rbXdDUm1IN2FwSkcvRkZGbS8x?=
 =?utf-8?B?OHZyNWcyNFhXNlN6TVBFUHZLT2wwMG12cDJxN2VsTFdlQnVEVk9wa0UzbVQ5?=
 =?utf-8?B?dzJjRUpVb1Y3WWsvSGp2VDI4N1pHZG9sMzdtaGJkMGxQa2hVNXhLUm04UDlT?=
 =?utf-8?B?Y0hPWnBaV1hEaGJ1ZHprVU9IdVpGR0xTR0VOZVJQWHl4Mmt6U1RFaHhEeEV6?=
 =?utf-8?B?T2V2dWs3YXNxQnlDRmxUNGwveko5Nmh4UVJLWWpPMEFITWo1VGthWXZYdFlS?=
 =?utf-8?B?TUhtSTVDYzMvaG9BQ2Z6cW1wS2dvakxUNkNIUGx6V3luU1puR1JEN29MZXBC?=
 =?utf-8?B?RXY1OFArcFNiWFV2Y0JCeEVFbjV6a0hrTkIwVDg0SDNHOUVqRjlLbVRNd3lk?=
 =?utf-8?B?TUxpOTc0U3QxT2ZTVkpBZHJWRUtDY29YU2VlWHh3b2kzd3grWE5pOEdMc3Nz?=
 =?utf-8?B?b01rNEsyVVFVRWF6dkpRZWkrS284RkkxTDBrbjF3K2w3djJ5R2xjNmc1Y0pj?=
 =?utf-8?B?ZDBoU0hsNUVmNS8xcnhkdDdHQUxpNi8vNUFRdXdYa2U1UkRINngrYUtiNHls?=
 =?utf-8?B?TFRZS1M1ZVRKbnN5RkV5aVM1dk40NENkelhRQ3MyalA0bFZJR3F5UHlWMjFl?=
 =?utf-8?B?cldTZnZGS2pvQjVaU01KU1o1VU8xNC9BOXZiMTNLRHB0eFk2QVFnbDBSaWlY?=
 =?utf-8?B?aGlkUW5GK1Vxc2RmS3dqN3NjUGI3WC93Qk1vc2h5d295bWxVeWVwdFpSRmgv?=
 =?utf-8?B?LzdyUEErOFp0NDdROFFnOEZxWSt0OG9jVkJXN1dRdVlpQndWSWdLWEQ0THRy?=
 =?utf-8?B?Z3ZxTFVOZGtzSUFzR2gzVFdxcjBHZmtPUlJndlNVWi8vZnpTaUVPMDNyMGhL?=
 =?utf-8?B?YUw0ajJYc0swVVNOT2VmT0M2NXNlbkdSMHFiYUg2MGhoeURZRDRyOENqZm9p?=
 =?utf-8?B?TCtiWnU3dkdKbURUeTBJbHpkYmUrVWJNbWJ6eHVIWE41dGtDbFJla0dQaFV3?=
 =?utf-8?B?RElEMzhGSVBZdzVIL3F1M2hlSnhmbUNPTzVFWnZjTlU0dFZSSWsySG01UFVX?=
 =?utf-8?B?NU5aa09TaENKZmgyd2Nibi81SGc0bzJqM24xYjFtbnJJS3JFTGYvbi9zZ0Ri?=
 =?utf-8?B?VHJDT3NhZDdNSmhybkhJREFpMllsL1RkK05QcG15QWFWbVljMTRJOTlaVUh3?=
 =?utf-8?B?MGtSK1J5eXdYNHFRWGw2YUZFWEVDZnZhT29oZ0M5RlVDV0VNM2lwbnF2UE5w?=
 =?utf-8?Q?ri7T2eQwXGoNq8KoC+Kyx8DUB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611be56d-afa1-430d-08b1-08de118bfc50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 16:56:46.3812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88i/a3eN9p1v+GpzgtsMwVGsE6Qx4yxm4huIbvq4qFBMee7n0BmDtU4uiJKQv+DTaVuKuQS1NcVi2YWO72uf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyMiBPY3RvYmVyIDIwMjUgMTc6MjUNCj4gVG86
IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IFNoYW1lZXIgS29sb3Ro
dW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBiZXJyYW5n
ZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
DQo+IDxtb2Noc0BudmlkaWEuY29tPjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhp
c2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFtZWVya29sb3RodW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTEvMjddIGh3L3BjaS9wY2k6IEludHJvZHVjZSBv
cHRpb25hbA0KPiBnZXRfbXNpX2FkZHJlc3Nfc3BhY2UoKSBjYWxsYmFjaw0KPiANCj4gRXh0ZXJu
YWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+
IA0KPiBIaSBOaWNvbGluLA0KPiANCj4gT24gMTAvMjEvMjUgODo1NiBQTSwgTmljb2xpbiBDaGVu
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgT2N0IDIxLCAyMDI1IGF0IDA2OjI2OjM5UE0gKzAyMDAsIEVy
aWMgQXVnZXIgd3JvdGU6DQo+ID4+IEhpIE5pY29saW4sDQo+ID4+DQo+ID4+IE9uIDEwLzIwLzI1
IDg6MDAgUE0sIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPj4+IE9uIE1vbiwgT2N0IDIwLCAyMDI1
IGF0IDA2OjE0OjMzUE0gKzAyMDAsIEVyaWMgQXVnZXIgd3JvdGU6DQo+ID4+Pj4+PiBUaGlzIHdp
bGwgY2F1c2UgdGhlIGRldmljZSB0byBiZSBjb25maWd1cmVkIHdpdGggd3JvbmcgTVNJIGRvb3Ji
ZWxsDQo+ID4+Pj4+PiBhZGRyZXNzIGlmIGl0IHJldHVybiB0aGUgc3lzdGVtIGFkZHJlc3Mgc3Bh
Y2UuDQo+ID4+Pj4+IEkgdGhpbmsgaXQnZCBiZSBuaWNlciB0byBlbGFib3JhdGUgd2h5IGEgd3Jv
bmcgYWRkcmVzcyB3aWxsIGJlIHJldHVybmVkOg0KPiA+Pj4+Pg0KPiA+Pj4+PiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+Pj4+PiBPbiBBUk0sIGEgZGV2aWNlIGJlaGluZCBhbiBJT01NVSByZXF1aXJl
cyB0cmFuc2xhdGlvbiBmb3IgaXRzIE1TSQ0KPiBkb29yYmVsbA0KPiA+Pj4+PiBhZGRyZXNzLiBX
aGVuIEhXIG5lc3RlZCB0cmFuc2xhdGlvbiBpcyBlbmFibGVkLCB0aGUgdHJhbnNsYXRpb24gd2ls
bA0KPiBhbHNvDQo+ID4+Pj4+IGhhcHBlbiBpbiB0d28gc3RhZ2VzOiBnSU9WQSA9PiBnUEEgPT4g
SVRTIHBhZ2UuDQo+ID4+Pj4+DQo+ID4+Pj4+IEluIHRoZSBhY2NlbGVyYXRlZCBTTU1VdjMgbW9k
ZSwgYm90aCBzdGFnZXMgYXJlIHRyYW5zbGF0ZWQgYnkgdGhlDQo+IEhXLiBTbywNCj4gPj4+Pj4g
Z2V0X2FkZHJlc3Nfc3BhY2UoKSByZXR1cm5zIHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFjZSBmb3Ig
c3RhZ2UtMg0KPiBtYXBwaW5ncywNCj4gPj4+Pj4gYXMgdGhlIHNtbXV2My1hY2NlbCBtb2RlbCBk
b2Vzbid0IGludm9sdmUgaW4gZWl0aGVyIHN0YWdlLg0KPiA+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFu
ZCAiZG9lc24ndCBpbnZvbHZlIGluIGVpdGhlciBzdGFnZSIuIFRoaXMgaXMgc3RpbGwgbm90DQo+
ID4+Pj4gb2Jpb3VzIHRvIG1lIHRoYXQgZm9yIGFuIEhXIGFjY2VsZXJhdGVkIG5lc3RlZCBJT01N
VQ0KPiBnZXRfYWRkcmVzc19zcGFjZSgpDQo+ID4+Pj4gc2hhbGwgcmV0dXJuIHRoZSBzeXN0ZW0g
YWRkcmVzcyBzcGFjZS4gSSB0aGluayB0aGlzIGRlc2VydmVzIHRvIGJlDQo+ID4+Pj4gZXhwbGFp
bmVkIGFuZCBtYXliZSBkb2N1bWVudGVkIGFsb25nIHdpdGggdGhlIGNhbGxiYWNrLg0KPiA+Pj4g
Z2V0X2FkZHJlc3Nfc3BhY2UoKSBpcyB1c2VkIGJ5IHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19z
cGFjZSgpLA0KPiA+Pj4gd2hpY2ggaXMgZm9yIGF0dGFjaCBvciB0cmFuc2xhdGlvbi4NCj4gPj4+
DQo+ID4+PiBJbiBRRU1VLCB3ZSBoYXZlIGFuICJpb21tdSIgdHlwZSBvZiBtZW1vcnkgcmVnaW9u
LCB0byByZXByZXNlbnQNCj4gPj4+IHRoZSBhZGRyZXNzIHNwYWNlIHByb3ZpZGluZyB0aGUgc3Rh
Z2UtMSB0cmFuc2xhdGlvbi4NCj4gPj4+DQo+ID4+PiBJbiBhY2NlbCBjYXNlIGV4Y2x1ZGluZyBN
U0ksIHRoZXJlIGlzIG5vIG5lZWQgb2YgImVtdWxhdGVkIGlvbW11DQo+ID4+PiB0cmFuc2xhdGlv
biIgc2luY2UgSFcvaG9zdCBTTU1VIHRha2VzIGNhcmUgb2YgYm90aCBzdGFnZXMuIFRodXMsDQo+
ID4+PiB0aGUgc3lzdGVtIGFkZHJlc3MgaXMgcmV0dXJuZWQgZm9yIGdldF9hZGRyZXNzX3NwYWNl
KCksIHRvIGF2b2lkDQo+ID4+PiBzdGFnZS0xIHRyYW5zbGF0aW9uIGFuZCB0byBhbHNvIGFsbG93
IFZGSU8gZGV2aWNlcyB0byBhdHRhY2ggdG8NCj4gPj4+IHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFj
ZSB0aGF0IHRoZSBWRklPIGNvcmUgd2lsbCBtb25pdG9yIHRvIHRha2UNCj4gPj4+IGNhcmUgb2Yg
c3RhZ2UtMiBtYXBwaW5ncy4NCj4gPj4gYnV0IGluIGdlbmVyYWwgaWYgeW91IHNldCBhcyBvdXRw
dXQgJ2FzJyB0aGUgc3lzdGVtX2FkZHJlc3NfbWVtb3J5IGl0DQo+ID4+IHJhdGhlciBtZWFucyB5
b3UgaGF2ZSBubyB0cmFuc2xhdGlvbiBpbiBwbGFjZS4gVGhpcyBpcyB3aGF0IEkgYW0gbm90DQo+
ID4+IGNvbnZpbmNlZCBhYm91dC4NCj4gPiBZb3UgbWVhbiB5b3UgYXJlIG5vdCBjb252aW5jZWQg
YWJvdXQgIm5vIHRyYW5zbGF0aW9uIj8NCj4gSSBhbSBub3QgY29udmluY2VkIGFib3V0IHRoZSBj
aG9pY2Ugb2YgdXNpbmcgYWRkcmVzc19zcGFjZV9tZW1vcnkuDQo+ID4NCj4gPj4geW91IHNheSBp
dCBhaW1zIGF0DQo+ID4+IC0gYXZvaWRpbmcgc3RhZ2UtMSB0cmFuc2xhdGlvbiAtIGFsbG93IFZG
SU8gZGV2aWNlcyB0byBhdHRhY2ggdG8gdGhlDQo+ID4+IHN5c3RlbSBhZGRyZXNzIHNwYWNlIHRo
YXQgdGhlIFZGSU8gY29yZSB3aWxsIG1vbml0b3IgdG8gdGFrZSBjYXJlIG9mDQo+ID4+IHN0YWdl
LTIgbWFwcGluZ3MuIENhbiB5b3UgYWNoaWV2ZSB0aGUgc2FtZSBnb2FscyB3aXRoIGEgcHJvcGVy
IGFkZHJlc3MNCj4gPj4gc3BhY2U/DQo+ID4gV291bGQgeW91IHBsZWFzZSBkZWZpbmUgInByb3Bl
ciI/DQo+IGFuIGFkZHJlc3Mgc3BhY2UgZGlmZmVyZW50IGZyb20gYWRkcmVzc19zcGFjZV9tZW1v
cnkNCj4gPg0KPiA+IFRoZSBkaXNhZ3JlZW1lbnQgaXMgc2VlbWluZ2x5IGFib3V0IHVzaW5nIHN5
c3RlbSBhZGRyZXNzIHNwYWNlIG9yDQo+ID4gZXZlbiBhZGRyZXNzX3NwYWNlX21lbW9yeSwgSUlV
SUMuDQo+IFllcyBteSBkb3VidCBpcyBhYm91dDoNCj4gDQo+IHNtbXV2M19hY2NlbF9maW5kX2Fk
ZF9hcygpDQo+ICAgICAgKiBXZSBhcmUgdXNpbmcgdGhlIGdsb2JhbCAmYWRkcmVzc19zcGFjZV9t
ZW1vcnkgaGVyZSwgYXMgdGhpcyB3aWxsDQo+IGVuc3VyZQ0KPiAgICAgICogc2FtZSBzeXN0ZW0g
YWRkcmVzcyBzcGFjZSBwb2ludGVyIGZvciBhbGwgZGV2aWNlcyBiZWhpbmQgdGhlDQo+IGFjY2Vs
ZXJhdGVkDQo+ICAgICAgKiBTTU1VdjNzIGluIGEgVk0uIFRoYXQgd2F5IFZGSU8vaW9tbXVmZCBj
YW4gcmV1c2UgYSBzaW5nbGUgSU9BUyBJRCBpbg0KPiAgICAgICogaW9tbXVmZF9jZGV2X2F0dGFj
aCgpLCBhbGxvd2luZyB0aGUgU3RhZ2UtMiBwYWdlIHRhYmxlcyB0byBiZSBzaGFyZWQNCj4gICAg
ICAqIHdpdGhpbiB0aGUgVk0gaW5zdGVhZCBvZiBkdXBsaWNhdGluZyB0aGVtIGZvciBldmVyeSBT
TU1VdjMgaW5zdGFuY2UuDQo+ICAgICAgKi8NCj4gICAgIGlmICh2ZmlvX3BjaSkgew0KPiAgICAg
ICAgIHJldHVybiAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxk
IGJlIGNsZWFuZXIgdG8gYSBoYXZlIGFuIEFkZHJlc3NTcGFjZSBhbGxvY2F0ZWQgb24NCj4gcHVy
cG9zZSB0byBzdXBwb3J0IHRoZSBWRklPIGFjY2VsIHVzZSBjYXNlLCBpZiBwb3NzaWJsZS4NCj4g
VG8gbWUgcmV0dXJuaW5nIGFkZHJlc3Nfc3BhY2VfbWVtb3J5IHByZXRlbmRzIHdlIGFyZSBub3Qg
ZG9pbmcgYW55DQo+IHRyYW5zbGF0aW9uLiBJIHVuZGVyc3RhbmQgaXQgaXMgImVhc3kiIHRvIHJl
dXNlIHRoYXQgb25lIGJ1dCBJIHdvbmRlciBpdA0KPiBpcyB0aGUgc3Bpcml0IG9mIHRoZSBnZXRf
YWRkcmVzc19zcGFjZSBjYWxsYmFjay4NCj4gDQo+IEkgd291bGQgcmF0aGVyIGFsbG9jYXRlIGEg
ZGVkaWNhdGVkIChzaGFyZWQpIEFkZHJlc3NTcGFjZSB0byBzdXBwb3J0IHRoZQ0KPiBWRklPIGFj
Y2VsIGNhc2UuIFRoYXQncyBteSBzdWdnZXN0aW9uLg0KDQpPay4gSSB3aWxsIGdpdmUgaXQgYSBn
byB3aXRoIHRoZSAiZ2xvYmFsIHZhcmlhYmxlIGluIHNtbXUtYWNjZWwuYyIgcm91dGUgZm9yIGEg
DQpzZXBhcmF0ZSBzaGFyZWQgYWRkcmVzcyBzcGFjZSB0aGF0IHlvdSBzdWdnZXN0ZWQgZWFybGll
ciBpbiBwYXRjaCAjNiB0aHJlYWQuDQoNClRoYW5rcywNClNoYW1lZXINCg==

