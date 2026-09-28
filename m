Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13DDCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDDi-00013b-BI; Mon, 28 Sep 2026 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDg-00012m-6o
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDe-0002k5-6v
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEflLx1869208; Mon, 28 Sep 2026 08:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=proofpoint20171006; bh=wE
 kJlUoNEVBhmIPwOCYPnKIRkaj3g8TKZwyVjgDIAns=; b=hKrBaqCd9NzFmUoOz6
 UQLj/8FbGAHbM75ttkJC+TNI7Fh+7UWkpHSgnr0MICA0NbrVuMob6S6ZYBesO2GR
 /PObyrhso1coxKtr4NWWuQpWBXxnQVuvdbNuCws5+eNI5Py42L2SBlRbHafB64Mm
 cWFLBmEBZpLBhrFrF7HGpAoP9rQb83bNNCsvbvfwnU0JHnOMqa8H8E9TRSPjVJvp
 dR6RW+P4mVM5w3Ndc1lrSFyX0gWimlR7307axpv8QBmm3lk/kht71fTkJ8cqeJgi
 m6CkBBda7FWfSAhJyR/8KSvF2bA0LC348Z6jp0s80iORaoCKF1e5h/H2f87leR9l
 koBw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020126.outbound.protection.outlook.com [52.101.85.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxbk5kr4c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ7suTow8p0r0cdMXXiEzgeM1A+6p8sqp+7DStYLKZHqlJrHLybZIZz2LLTOrdfDAGhO003kK4wuKRf4vRf243b+k745y1nBsYF3Pxd89v8bW5sZnZYEoNSt22M8sjjJp8Xg53+ocFYISRXp4STMPcTbjXgCtTbRxQkATSe4goBhZbLJvNsspH17ZDYhIfzzO7u6s0x7OyJ/Q4Xmc2DA9AAyOHEqOp1qBy+I4BQ/SFZK7b86IS/BpUOOH8sxNtWe6RYwrwxJMbnn8bk0HQIIDmnFrwOStG4LmGZlDePvDn8RnZ6GeUV8ZEmc5AWJEN0yWFQ/ekG7Sd4il3m+Wu7cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEkJlUoNEVBhmIPwOCYPnKIRkaj3g8TKZwyVjgDIAns=;
 b=IRuwWfs/GD44Wc9j7n1o5EEZS/2nRmI5Ey5ZIxU9nwj3gzJ4N0MNFbwT6aC44iQtYoRy2bh46u3CB0zYfDv9AKGTyLxVcx7C+eH4b/tEcN/o9mco9JLatDVAyKRtF6a7p6iB1Lu8VCiYdgSdI7DJiiR4Qka4nctECdnR7ZOtYzsZFomr2b3E8GOSaAK5yi61OdNYYDCB0TMGpa7RA6C4e8SIenlqes5zVvceuscGS84jt3tonerTC2sBrnJcmaZ36EetYhXfqC2BtTQR5GKOQJBlckrcRL80H7R4/0J/hY/sPByPKS6EZPNLOQJzL38OCuasoWaWcdcQgcJwUynkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEkJlUoNEVBhmIPwOCYPnKIRkaj3g8TKZwyVjgDIAns=;
 b=AAirIXrtCaGmOcmRfhIE+Df/aP6NPackSrIItHq02Hc5eoyp8Ty1m8rO0N77HBu9TJ9IQmCCe9ukbF6A9TCayZyM3U3hTbk+bvG31dgNmSFc49F7figUPPeJ26AqzQo8YsjZl+BRcXnnETIXfTVB83br8nm9Q19P8DdnA6oiVn7ytyxLqu3MebzCq+PyX6nf6tqgy7qObKc6T1htcG/Ur8Q0t2HcurKlKATjfE61D2Q8hCMr0H1UAowIikVtAN7TGznsdv9aHff2k3nBniqESOCuULHfo9ODxF8olujpw9ZEeKH2nug8xEtEF28J2eHW9Lk1ge/co3gaI0EKFIUECw==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by PH0PR02MB7301.namprd02.prod.outlook.com (2603:10b6:510:1b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:24:32 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:24:32 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth for the
 PCIe topology
Thread-Topic: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth
 for the PCIe topology
Thread-Index: AQHdT112eBNNuLObFkizLwxslyr5iw==
Date: Mon, 28 Sep 2026 15:24:32 +0000
Message-ID: <20260928152431.310363-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|PH0PR02MB7301:EE_
x-ms-office365-filtering-correlation-id: 3275c806-57cc-4476-b890-08df1d7498be
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|6133799003|10067099003|5023799004|38070700021|18002099003;
x-microsoft-antispam-message-info: hne/RHM8gH1eQvlxohQaG/dfcbUN99XMraZ1Ez9B8vBwooxrndsZiSX0Xw0ZEXI0qeyCKomcIuN5nfQN6rSzo5hTJ2jImSVGTPMVT1x6vwUfMfCekBHi6u5W1CE5qZbiit1Ue4Uo8jwt3wiyrAybu/4B0BFmJ+b2NjqDL13CpAmq17H5BMlCkzfheflNhfuvMCdQ2Eixf5f+Xg6xcvCqfJfKsjSF9njWYpx+nOVxlCCqEPRpV3oRdUyxrEwqT6JFKb9GMRvQO4eOkj5K86GCmBcCE+MbjBHFaWQKl632hoRgZDXeCpvaLkDSU5BYvIuldMw4/nW96lk6itCWgaEDbkYspc22d3IrUdry5kbJF9OBo0qm7QjkCF9eaL5KzihsH96SEL1ZGGWqbynPrra792G005CI5sy4e/JGiYW4lPOnvRQWgH2GAu+ArBCdjvWeijKqlIOyI/PLkuVTvKKLuRwt+y2goQ/X7or+223IZ06dqp+0zaDjqhIqL6tjRBeHcPBWqE1u0dvCR9t8b4Sfz0TG2fuX+jkA6qtB7gPnb11GzUm18mzbOOfNotrHj0CUx3SrrsXh+gdfuckEAXiF3YOCSUFaiX3k/t7U9oIA2GtwnZoyGfuhu2vnFrck+ITNx/NLDuRE6RMwADN4OplDm48xlX9tc12DsK6Kr/yoOVlrgcdEpsO1amUnUOFnA2To7GjkPqnA6Z9P0j9lMaakGTnKF8CtT0tGM3YB08WAP2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(6133799003)(10067099003)(5023799004)(38070700021)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFlMRm1YT1VFYTU1REJPWGJJdHNndW1HQ09yUGRSNWV0SUV3ampBVTIzV1NM?=
 =?utf-8?B?RHhvSDh2U0lzT0lwYk5MNGVBTlZ0UzNTUTdxejkxWCt1d1YrRXUwc1VmRXdL?=
 =?utf-8?B?Wmt3QnM1eHdWckd2dk5OWWk1Z05Xb3N1a21xSTZKTVVRWU1TdEhqVk5lVFpt?=
 =?utf-8?B?TG1Rc08xS0xEa1JOdXNSMGIxOUx3L2RjMk9qVEprOVlraHRzS3lZT1BLcXY5?=
 =?utf-8?B?dzJFeE50MllUeUE5R2IxSnhLWmhwWmlZUTZwSllobVhOWjZhZ0YrUEU0TG9v?=
 =?utf-8?B?RXJ0cjJiZy9COU4wdldwTlV6MCsxaXNYSm5VSUxoT3NKNi9STS90UXlGcmNi?=
 =?utf-8?B?eVArWW1tbFFmWHpkNk5KZFVSRkNVRUUyVTh6bW85RTBkZ1g2VXFaNnZYU0lv?=
 =?utf-8?B?R05Kd0xJODYrRWcvelF6ZkNvZ1d6T0FYaVdJMkYvSGFzWXhhN0dCYnE1VTRM?=
 =?utf-8?B?TkxTaWlDSmxEV21uNjJaNHkrejNRMmpjdGdROGdVUWJZSk0yQnZnOHJGaWNH?=
 =?utf-8?B?eDNTQ09JU0RvdHFaL25TSlpsbDFwZEhnTFBDVzI0WTdGbGsrK1VIVkNTTERo?=
 =?utf-8?B?MWs0RkFuZUJzbTZYcVp6aE5YdGZKMDlSS3ZxWGtPcS95NGZDYm1xUnlPMlpr?=
 =?utf-8?B?alVXOW1CdmZLSmVuMjA3Mng1bkxISGJkSDJvTUNXZG8xNUxDY3UzNFIvUitM?=
 =?utf-8?B?ZTVLNjl3MDZYYlE2Q0dOVm1IK29zUkFsRWJySXBZQ1B2dlNQTFNxSi9Lb1dn?=
 =?utf-8?B?bU5ncmJTRUxqd3VFUG9XdHZKN0c1VkdNc05yNTRtZ2pKdUNaeFU5eHgyRjJm?=
 =?utf-8?B?Njl5WWJIaVlEeE9Gc3FYREExUTJmUzFCeElGY2NYYmFDallCOGtaM1J1OU00?=
 =?utf-8?B?RmlZZ0J1NnZ2akpSb0NFaHVhNmZycC90MW1qa3RROElpcXN1VHJ4eTJJMjVV?=
 =?utf-8?B?V2E1YklnemdWSG5GV1lnV2JOSGFkTzdrdlY3N0h6R1ZMRnNTK2Z5TGc5YXl2?=
 =?utf-8?B?OXAwQ1dsY1N1UzRPaXdBVHMyY2RleWUxdW9QQTNGZ3p0Z2xsRGxpSjQ5dTE5?=
 =?utf-8?B?b1hVVEw5cVBrVll3eis3L3NmMzZkbStBZEhWalJWRk50M2tHajNEbXpyclF4?=
 =?utf-8?B?THErS2xEMjRCbHhEcWRQcEVNY1RVZVlOME9ZU0M3UnYvM21oZS9hNzN5SDM5?=
 =?utf-8?B?REx3MEExQ1VQQWpyRGUvUzdXWWJLZm5wclBoR0xOVDZpZVNsYS9UQVprRTZk?=
 =?utf-8?B?Uldmc2lLYkJSand4cjRqYXdEb0F2SnJiLzh6VGZRWWNtOTlwdm8vdVZFYmwy?=
 =?utf-8?B?YlBLMVRNeitKK2t4QnZld2N4dnNnOG1QdGh0WWl3YXRsWGJlbWlXOUpISmdm?=
 =?utf-8?B?dmpQczladFZPaFBaSnlwUFVtN25Ra05KVm1SWHRxVlNsTWExNVg4Y1JpcmFS?=
 =?utf-8?B?dGpSdEVwUjlmbnNtQk1ocEwwUkFlVGxDTGUrREtSNGJWLzhRRGZhOHJTRmZ5?=
 =?utf-8?B?dGlRTUpoZ0pQTCtEQklZOFNTelRZdHM1VCtjMHpqV1hNS0tUSmdFY3BkSjM5?=
 =?utf-8?B?cWhRUjBuZWZUcDM5TEVuZHdtQ0dOT3ovUlRzWTNVQ2IranJaT0V1TVdna1Bp?=
 =?utf-8?B?aCttaS9ybU1DemsvV3BZRU1ad3ZpRVdNbFdnQ3ZRc2tNclduNGYzM0pabTAy?=
 =?utf-8?B?K2E0ay9kVTAvRDNIMWFqUHpCYjBmejU2S2FWQ0FQN1RqdnUxNGlCN1hzQXNx?=
 =?utf-8?B?NkptZmIzcktsZlh6VkpkWHowMmc1SlkrUmVWTU13K3F4Y21tSkhGaFlvamkr?=
 =?utf-8?B?Q3UrZW9mR05oditGNkNYcy9CWHhOWVFpOHdoWEJ3TFVGdmt0T2oxdGxXVnZO?=
 =?utf-8?B?eDN6RGJ4Z0JTVWgvZDd2cFlkQ25CNHJmazMyUXVZSllVWXh6a2VIZE03WjNI?=
 =?utf-8?B?NHkzTjM5K3JYNktFek9kUk9LS3pibUJVeFhLY1dxQ3VNL0ZVZGVkV01RdEZG?=
 =?utf-8?B?eHV6M3MybnJZRFduVVlYcTJQeWJjMk5RNGp3T3RrY0tRNWVaN0o2R1l4Y2ZL?=
 =?utf-8?B?eDA0VDdORWc4NjRYd1pIdWVMSk1HNnhDYVF0clFWb3FwZngwODdMSDRGSmgr?=
 =?utf-8?B?L3FyQ002Q1QwVG0vWUNYSHFoa3lZY0NWenI4WWpuank5dWdHT3NCc0hBZDA1?=
 =?utf-8?B?N0pQNmRIME10MjZMMExKR2thUmg2ZDVNUlJPTHlxakh3eitMdmpTa29ZdFBJ?=
 =?utf-8?B?YnBDRzVwTVdMK3NzZHhoWVhmS1l4ZnZZUVhNbkNPeUtpZmozSDhyWWpOWUdl?=
 =?utf-8?B?UzRnQ3dza0MvbG9RWWVGblRwZjdOeWdmN1d5WkNGczdZZHFPRVhIRnhNNlhv?=
 =?utf-8?Q?KICOFTtf2AorpnoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE87F86C0E8BFF46AB794EDBCFA9DBD4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RoFmG6GLlJACXwEM2hOIt6rLTqTpkIlYH/N5tvK/iOole5Qlx53RoF8W6xMMxzjqPgPnA713JB1QWXbTH28NWFzVNxHDlYYgsCoeRsUu8ooBG3MLaNKa2SophKUqh9sMSDqMbjeEYkQ0SJB4nz+aQQpBOb3+Yx804/+hTIp5ZObkIEtKGBFPQfE1v8ucK1FzxsYmaRpSApJVz+oIRq6k0WKxErW0sAGvNhnng3wWxhHFIcm+F8BvX47WyJpTA/F8dOj5z3vk04nWz3izsnJpcDInIdrKHbLvqPf1MTYFFhHkSWbxbWu04x7bYgNyMECJBaj2nNAUj3eqhcD9lg1k/w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3275c806-57cc-4476-b890-08df1d7498be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:24:32.4710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/DNOJgE6rI9X03YVi1RRb9E995luWKS8BDlbCseReJ/lcyhWQlQEJMxyNqpx5/JIA6k0jzCTEGaLgKYeQbEdpkGoZL1a6C5bUAHAdcGRZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7301
X-Authority-Analysis: v=2.4 cv=T6EZ3PKQ c=1 sm=1 tr=0 ts=6aba86b5 cx=c_pps
 a=w1Ugl8llyohtshnQLMHy5g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=Ikd4Dj_1AAAA:8
 a=pZpcXEuzcdaDib_rDisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F4V0YpKF7MF8HG6x4gW-dxv1lEbtCg4f
X-Proofpoint-ORIG-GUID: F4V0YpKF7MF8HG6x4gW-dxv1lEbtCg4f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX0mUz/2seAH7i
 df+xo4gPrB2SSKfQ8gm2yzZmqHRqLAvTocRWuaU3jNgr3sld5rMAANSSulRskzyWxtliW6SkZ3/
 dC/rE5YwWagd5XPpETf/DmOncRWhBWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX0sXb0iTgJTsl
 pA/lJMrIG7/nnkbsFDCgQonR6SphK8rCoR7GR6Z5KjRf9I0ek31T8e+0XGRKXjdVb4EoHU8VT6U
 iAtJ2x4bRrtv+3cO5vo60RlDEpihqFGB0G9Mq+eapPeXxsipLoq9nZy18piPxgkUxBa37nfYdWv
 CUYDcpo+jvKMAaoBbvez9eZJ+WZ7WQSJqSUGUF+VAN/P/YJ0hBNFg/p79vWkdlc8jWmsosDo2Ft
 znLr3L6N8KqllKQCa3NIUg9oEGgRr89XDZvVGAN6m+Qr0j6cvV59XoVekhmhYlTWHxwohluWZSV
 EdJrXliPaV2msJGAdknJ8wjA2nhBaLcRxPfw89RR4jDxEdC3jFkJcNnFPowT34lH43daUptLcXy
 +QHWE5G3T7NjtfMshV0C0UQvx0IP6tfoC3a9TNyQI7JqI3HXc4sNQJ17WZOtrocfItW1OFFvyeh
 NXNjdJRWvskdlhamNmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

V2hlbiBhIFZNIGhhcyBiZWVuIGFzc2lnbmVkIGEgbnVtYmVyIG9mIFBDSWUgZGV2aWNlcyBiZWhp
bmQgYSBjb21tb24KUENJZSBzd2l0Y2ggYW5kIHRoZSBWTSBpbnRlbmRzIHRvIHVzZSBwZWVyLXRv
LXBlZXIgKFAyUCkgdHJhbnNmZXJzCmJldHdlZW4gdGhlIGRldmljZXMsIGl0IGlzIHVzZWZ1bCB0
byBiZSBhYmxlIHRvIG1vcmUgcmVwb3J0IHRoZQphcHBhcmVudCBQQ0llIGJhbmR3aWR0aCBzbyBp
dCByZWZsZWN0cyB0aGUgcmVhbCBoYW5kd2lkdGggb2YgdGhlCnVuZGVybHlpbmcgaGFyZHdhcmUu
IFRoaXMgYWxsb3dzIHNvZnR3YXJlIGluIHRoZSBWTSAoc3VjaCBhcyBOQ0NMWzFdKQp0byBtYWtl
IGJldHRlciBkZWNpc2lvbnMgYWJvdXQgd2hldGhlciB0byB1c2UgUDJQIG9yIG5vdC4KClRoZSBl
eGlzdGluZyBlbXVsYXRlZCBQQ0llIHN3aXRjaCBpcyBhIHZpbnRhZ2UgVEkgWElPMzEzMCBhbmQg
b25seQpzdXBwb3J0IDIuNSBHVC9zIGFuZCB4MSwgc28gd2UgaW50cm9kdWNlcyBuZXcgZ2VuZXJp
YyB1cHN0cmVhbSBhbmQKZG93bnN0cmVhbSBwb3J0IGRldmljZXMgKHBjaWUtdXBzdHJlYW0tcG9y
dCBhbmQgcGNpZS1kb3duc3RyZWFtLXBvcnQpLAppbnNwaXJlZCBieSB0aGUgZXhpc3RpbmcgZ2Vu
ZXJpYyBwY2llLXJvb3QtcG9ydCBkZXZpY2UuCgpUaGUgZXhpc3RpbmcgZXhwZXJpbWVudGFsICJ4
LXNwZWVkIiBhbmQgIngtd2lkdGgiIG9wdGlvbnMgYXJlIG1hZGUKbm9uLWV4cGVyaW1lbnRhbCwg
YWxsb3dpbmcgdGhlIHBjaWUtcm9vdC1wb3J0IGFuZCBwY2llLWRvd25zdHJlYW0tcG9ydApjYXBh
YmlsaXRpZXMgdG8gYmUgY29uZmlndXJlZCB0byBtYXRjaCB0aGUgaGFyZHdhcmUuCgpUaGUgcGNp
ZS1yb290LXBvcnQgZGV2aWNlIGlzIHVwZGF0ZWQgdG8gZGVmYXVsdCB0byBhIEdlbjYgY2FwYWJs
ZQpkZXZpY2UuCgpGaW5hbGx5LCB3aGVyZSBhIHJvb3Qgb3IgdXBzdHJlYW0gcG9ydCdzIGJhbmR3
aWR0aCBoYXMgYmVlbiBsaW1pdGVkLAp3ZSBhbHNvIGVuc3VyZSB0aGUgb3RoZXIgZW5kIG9mIHRo
ZSBsaW5rIHJlcG9ydHMgdGhlIHNhbWUgbGluayBzdGF0dXMuCgpOb3RlIHRoYXQgdGhlIGRldmlj
ZSBJRHMgZm9yIHRoZSBuZXcgcG9ydCBkZXZpY2VzIGFyZSBjdXJyZW50bHkKcGxhY2Vob2xkZXJz
IGFuZCB3aWxsIG5lZWQgdG8gYmUgYWxsb2NhdGVkLgoKQ2hhbmdlcyBpbiB2MzoKICAtIENvcnJl
Y3QgUENJZSBkZXZpY2UgSUQgYWxsb2NhdGlvbi4KICAtIENvbXBhdCB2YWx1ZSBmb3IgcGNpZS1y
b290LXBvcnQuc3BlZWQgZm9yIFFFTVUgMTEuMSBhbmQgZWFybGllci4KICAtIFRyaXZpYWwgc3R5
bGUgY2hhbmdlcy4KCkNoYW5nZXMgaW4gdjI6CiAgLSBJbml0aWFsIHB1YmxpYyB2ZXJzaW9uLgoK
RGF2aWQKClsxXSBodHRwczovL2RldmVsb3Blci5udmlkaWEuY29tL25jY2wKCkRhdmlkIFZyYWJl
bCAoNCk6CiAgaHcvcGNpLWJyaWRnZTogQWRkIGdlbmVyaWMgUENJZSBzd2l0Y2ggdXBzdHJlYW0g
YW5kIGRvd25zdHJlYW0gcG9ydHMKICBody9wY2ktYnJpZGdlOiBNYWtlIHNwZWVkIGFuZCB3aWR0
aCBmb3IgUENJZSBwb3J0cyBub24tZXhwZXJpbWVudGFsCiAgaHcvcGNpLWJyaWRnZTogRGVmYXVs
dCB0aGUgZ2VuZXJpYyBQQ0llIHJvb3QgcG9ydCBhcyBHZW42IGNhcGFibGUKICBody9wY2k6IEVu
c3VyZSBQQ0llIGxpbmsgc3BlZWQvd2lkdGggaXMgY29uc2lzdGVudCBiZXR3ZWVuIGJvdGggZW5k
cwoKIGRvY3MvcGNpZS50eHQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0K
IGRvY3Mvc3BlY3MvcGNpLWlkcy5yc3QgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogaHcv
Y29yZS9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiBody9wY2kt
YnJpZGdlL2dlbl9wY2llX2Rvd25zdHJlYW1fcG9ydC5jICAgIHwgMjAyICsrKysrKysrKysrKysr
KysrKysrCiBody9wY2ktYnJpZGdlL2dlbl9wY2llX3Jvb3RfcG9ydC5jICAgICAgICAgIHwgICA2
ICstCiBody9wY2ktYnJpZGdlL2dlbl9wY2llX3Vwc3RyZWFtX3BvcnQuYyAgICAgIHwgMTc3ICsr
KysrKysrKysrKysrKysrCiBody9wY2ktYnJpZGdlL21lc29uLmJ1aWxkICAgICAgICAgICAgICAg
ICAgIHwgICAzICstCiBody9wY2kvcGNpZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDI2ICsrLQogaW5jbHVkZS9ody9wY2kvcGNpLmggICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiArCiB0ZXN0cy9mdW5jdGlvbmFsL3g4Nl82NC9tZXNvbi5idWlsZCAgICAgICAgIHwgICAx
ICsKIHRlc3RzL2Z1bmN0aW9uYWwveDg2XzY0L3Rlc3RfcGNpZV9zd2l0Y2gucHkgfCAgOTggKysr
KysrKysrKwogMTEgZmlsZXMgY2hhbmdlZCwgNTE1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3BjaS1icmlkZ2UvZ2VuX3BjaWVfZG93bnN0cmVh
bV9wb3J0LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9wY2ktYnJpZGdlL2dlbl9wY2llX3Vwc3Ry
ZWFtX3BvcnQuYwogY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1bmN0aW9uYWwveDg2XzY0L3Rl
c3RfcGNpZV9zd2l0Y2gucHkKCi0tIAoyLjQzLjAKCg==

