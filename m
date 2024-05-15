Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53574C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rj-00061D-Sa; Wed, 15 May 2024 03:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78r7-00050u-Gg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:20 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78r1-0000oW-4u
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757311; x=1747293311;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=79+D25oBaPoMjf9fMPZ/2SPwoo4FJ0Jwk2KUD7UjEb8=;
 b=fC7G19JzEFXngo+VZWeTHNBnnTE1IbrvYGdXYPqpz4syONn/arFzJZE1
 K6lv7/uDcamSLXloxkRgYOvUyoXbkMoc87PPrDoYk3bQ2ZB6v331IYqeR
 JOf/D/zZDUnzdlH+aXbCzSRWSrJMV/Eo5FHdLQFiFD2GPMgYk35GB0dbQ
 s4z5be39j5jyl7Y3TKqgZ83o24u1cAGJInCsI2N7/2J7BshHYqhXD4K2/
 1G1JSUFabsonYt3yf3kH+iq7c10nLUWRtOTUihAevo3ol9CYj24Kw3qPE
 FgFYnyZq4gjyUeT4h3EhVIXD0XZF1ONwqdQunPmJdERdMPayn4b/rXc7k w==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581815"
X-MGA-submission: =?us-ascii?q?MDFTp6OHjzhp7RWTi6kCZkZIr7fko7SNmiFLnY?=
 =?us-ascii?q?kt26F6eX4XPMeK7jcdD+I2c8NMHf8bQHrSZ6qcZnIHQihBzwZfNkyGTX?=
 =?us-ascii?q?lWqAsP2r53CdwHrnx933P1oXxQV1imgpkL/MVxfVtAKJyjNeMIqzZM9G?=
 =?us-ascii?q?iS9oHXa31XvUb/WQlsOWEjrA=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzsEFt9xqQzez0PC6HbpLtIiGmMMH81J2Bj9MbUGAV3ul2CMVWk3Y8oCck6ufDzimRqpv5qtdYXUB2S72NCZIxNGWfacug0gy1h7m0KqznozYHOAcmu0xsbO51iwCIJP36oaM1EBT29nUZpBijsVZOktVQhJ8ar9wp+Z3Kio1F5DtWbCxqlRWAqdFxTBNFybtbTL0RpDC6LsVkrPXH/yXrx9ZRmYRAqot8O957rtSkCugJVcsBH1wNW9ClDVjToFB8XwX7yw/PAOwrpZWA3llweHwFV3JQotJI6k1myDPNN+fJ9l8hNAMoogIhrIm1ooUwGpE7V5GextXdNMN0sdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79+D25oBaPoMjf9fMPZ/2SPwoo4FJ0Jwk2KUD7UjEb8=;
 b=Hydo3OwMvt6h103LqJc8DhdkAL1eqtqR0A8vRvVZOTPqg7J5BgHH7l5NSdnkCizUbfwlzgj3wmLYDQfuvW1ErDqhTaHMsZf368svj4adZy+PfRZyp17bBZJ1nDSTBrBoFHc7sFUm96EMXiz51q3MDZibBzwBqgMGeOdxkAbUPYuvJEIgvV7JGDkkiyza/OlpbhJ568tKp7itBjPIGWVxeSASvBoVCRNQQHg8N23lzdBTGeNWvtDVVAvgH7zAVMXvZbQu4gA9LszwF4O9bFlB54NvSHMHV5lgDaBMkBrQ+6oaziBGU8sEOzDEQKvUSWrO9fv5rSR224oKJd2Zs96b6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 24/25] intel_iommu: set the address mask even when
 a translation fails
Thread-Topic: [PATCH ats_vtd v2 24/25] intel_iommu: set the address mask even
 when a translation fails
Thread-Index: AQHappeCe/bWBpU6GkuYFT4q/AqGqg==
Date: Wed, 15 May 2024 07:14:21 +0000
Message-ID: <20240515071057.33990-25-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 9a4ebdd6-92ea-40c5-8986-08dc74aea4c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZzNmbkpoUGJjZitHM0xQeHVXeXd6Z0tFN0tFTE53QTNYbEQ1U0tVclpUREVk?=
 =?utf-8?B?Y2x1YmhTR0ZrZFBuVStxcXo4cjdJT3hYcHBZTitaWVhiUkNZMVo4OXFTV3NY?=
 =?utf-8?B?Q3hkb1NjR2xycUdzRkRVYVY0MGtLMUxrVmFxU1JYb2JpdFRybXdvNDBFSUcz?=
 =?utf-8?B?MnJ6aWtHTklaR0VkOHcwU05GNnlsaTAwREhYek5kOGVmZFhwUG5vakNETTRO?=
 =?utf-8?B?TjFRRjY2VW5uY2RqN210NDRreW1wN3NXd1RnUkVLdlhxWFR2eEUyWEYrYS8w?=
 =?utf-8?B?R2pQQnJpa3FkNGlrUU1ZUHdTVGFuUDM0L2ZjSEpSY3JRY1I0aUlWYXdRbmRt?=
 =?utf-8?B?aUpwSkR2UWIvSWttWHNseEpCSWk4ZHM2dUJLNzlnTjUzd3ZBR2Q1V05ReG55?=
 =?utf-8?B?WW1JZFI1SlpWWTNaazR6dG5ieXpHNFpGUkpBSExwTWRVSHFWeWprRkM3a096?=
 =?utf-8?B?OC85TXNmam93K3NFRTRiZ0ZtZStKOWN6Um5sUEFFQ2JXTHVVcmg0V3VpRFpS?=
 =?utf-8?B?VFBUaFhHR1FrbW01S082U2g5MzZQV0l6YUtXamNjbHlkNXIzdktzclI3K0tE?=
 =?utf-8?B?bVIvdTBwT3kremVGYUVjUXBUOWRKY3VxVmkxK1QwdW8zUWFUQ09QYVErbEJT?=
 =?utf-8?B?ZEgyMDNCQlpuQTRSS3FBS2NYUlFwclRCRnpJMUJ6VHEydDNIQUM5UXBQaGRL?=
 =?utf-8?B?djcweHpxUTNWbW8xL3ZvOXlTY2dBTlhBMWl3UjF3K0ptUkhyM09KcitQVTM3?=
 =?utf-8?B?eDdHLzkwb0pmVXNxT1d5VDVrL0NkTTVPNEJWTG13M2puNERTQjdlY0I3cVdK?=
 =?utf-8?B?OERleE0wQjlUOG1nTzh0RXFrQmhBZG56WUFnVk4wS0JyV1lQYmhwQjhiU3ZR?=
 =?utf-8?B?T2RRQzBQODUyK3VwUkR1cU1DQzFSZVlFdHpYOTRnNGJrdklDWFpQWE1FK0JH?=
 =?utf-8?B?ZkxCS0lWaEhiNWIyd2tKNWdycFYvUnhIb0JwYzB6dEZDUlpKbnpKUDkxejlE?=
 =?utf-8?B?M0R6TlVtOERWMHhvajRsMkxnZ3BicVN3LzRTbDcwT2VSQmNTYm9LZ0NSekJk?=
 =?utf-8?B?elpyYUloTlpjWWR0NHQzdXM0aEEyT1JidjJMbnIvSE95NE1MTVA4MlNNOVRp?=
 =?utf-8?B?MFpweEkyOVQzRzhhUGpQZWppeVFzSi9MMjBBQThpY2duK3QvY0N3d2pQWXRh?=
 =?utf-8?B?aWN1RmtzRVpGY2M4UzNOSU94dVNpWDlkNWFQMGFXZm9oVDJnajNFcEhoSzh0?=
 =?utf-8?B?eUl3L3pYcGk0bWdwYkh6akQ1NEoyVFk3SittUk5YU0plVWxHeDdFMzdCNWIy?=
 =?utf-8?B?cWV5d3FhT3ZYa092cFU0WVpsUVFJOEVyVEVNNm4vTEpIbk5IZ0ZFQzhSanN0?=
 =?utf-8?B?MDdmWTJqc2dLaTJOUm05WVh6MHZRODdjdkQzMUptMG1wK3NSN200SVJLdFdQ?=
 =?utf-8?B?RCsxTUxjWkpqdEZUWkdTVU0vZm9tWmxEQjROMjBVMmpVRkIwUXF1dEVtSEV3?=
 =?utf-8?B?aEtvZmlNdGhxOHhCMndpK0NaTjdLU0VBRHA2NkdDZG5kaG00NEdrNHYrcGVJ?=
 =?utf-8?B?TkxYU3FKU3BjVFJTTnFnUENEdGlvWWN0NTc2d01PcVZxZkdOaUpJOTlDSHJv?=
 =?utf-8?B?ZXlXMENhMHljSzdDUVFjVVFpWktYZWx6K3cvdW1hbjRzY3Noa0M4MURKSUNz?=
 =?utf-8?B?TEdZaUFBNU5jektTOGtaeHRzZTB4bjlwVi9RVkZoVWNRL1NrbkxabFo4T1Z1?=
 =?utf-8?B?eVk5bTdJRVJrL3JBWWQyQ0dpSFdKQVBuZnBjM3pNLy9GemVtUGh2d1J1amZQ?=
 =?utf-8?B?aUQ4akRTdjBrSkpPdXM5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTF6TDBhZG1jVUE3SFF5Z2EyWTdtNEpudnBDVG80dEwzNEg0NS9WdjNSdThy?=
 =?utf-8?B?RWJFOUM0M1p2eGU5M1BlbXU3aGlBdi9vaVlvTTJQMmVXQ05IT3hBeXJ6cDI0?=
 =?utf-8?B?d2dnUkpualI3SWpwbWxpZUpJR1pYUDVoVk55YWduMVJNVEUvNENLSDRoNE9H?=
 =?utf-8?B?dTZEcDRnV3BOUmxyeng5eGs3ZUFhRXFldG5ldEYvMmRtWVRkTEpqOUpINzNu?=
 =?utf-8?B?Ny8vZnhYc2MzbHFuZUhOcEg4SFJOdjZEOTN1dFd3ZDRaUlZHWWhHMDJYOTQ4?=
 =?utf-8?B?Vm84bmxFdUQ3bWdPWVcwWXlmQWxYS3pTejdGdkhjYUczOHR6S01RK0RWMnFO?=
 =?utf-8?B?Zlp5QjRxY2tsQW1nOCtRQ2JLSjQzVDBwR1Y1bkRDN2E3ODJmZmw4NGxhRWRa?=
 =?utf-8?B?VlAwWnluNmVibWZ4QUVRRUR3L1RxWVZ2RlhJeTMySnptVUxRRFV5ZnlQVC9h?=
 =?utf-8?B?VXBBY2hJS08zR0p4UERTWTgzd0xEbm83Z0FnMjhPelF3b256dGRKN3ZDRWF6?=
 =?utf-8?B?TENLOGlKakRXZXV2NGMwS2d3WndFSWJUQVJ0NTdYdDJCek0zUjRrSlJTcUtB?=
 =?utf-8?B?LzAvVi91TUJvQkxaM29LZlBVaDhIWUhINHhDUHM2MFhZaDF0K09RUUw4Nmpi?=
 =?utf-8?B?U0tTaVRmeDIvSks5dmVVdkovNG5aTHRwOVBwS1RBQUdTWE1iZnZJY21qQWpY?=
 =?utf-8?B?SFc4V1ZYOC84bUxzaFMwZytTZXh1RjhqM0dhMDMyNEFBY3FTV0VOVFBNeVJY?=
 =?utf-8?B?TzJUNHhLMjJNU0xlb2taZk5RdnZySnkxTXFZVHhLdXQ3VjVjT0pMUXlFRDd2?=
 =?utf-8?B?NVVtNHBqeC9Db2k1S2owaW5ZSmtmRkloWm1aQU5Ca1BsOS85SlNrRVF3ZHRV?=
 =?utf-8?B?b1dvYjY4elhjejQyeWh2SU9GL0pFM1lHbWlkL1N4SzliYVJGT3YzVVRmcit4?=
 =?utf-8?B?cG1TMmNVZGlOVUwxVy9FVDZ4bVFQdFhHZTFoQ3VESTlWUmdCR3FWNW81T1A0?=
 =?utf-8?B?SDB1dCtMa09ONHNjMWVnUmxlOUtLQ1N4Tk0yS0ZJQmxjbUIweTl5K203NzNS?=
 =?utf-8?B?aGZWcHRmVHhaYWozMGxVY1NqenFEckQ5RjRGYStwM0FONFJFM2NIL2dLeC9J?=
 =?utf-8?B?c2R3WUdSZzB4eWV1WkV0V2hSMjJwQlovZXBubDRFelpsMEQ5NXhCRGhhR2w5?=
 =?utf-8?B?TUFQWkw2QmcrVnFPMWhHZGdlTEJhSW16NGhNbUNGbzNwNFdpakJidUF3a1hB?=
 =?utf-8?B?Zm9IZW1HTllFSU9oVmsxT3ViTlBBZjZEVlZUNjhSREZ3cDczKzdJWVRYWnZj?=
 =?utf-8?B?RlV3Sld6RVJ1S1h3bjc0Tkg1VkF2ZEZaRUFibjFJYzBYcTNobExyYUxCV2hP?=
 =?utf-8?B?UXB1WW9UaU5OcTl6dzgvOW82cnp4MW92MUc0STh3RkFPT3ArSkZUVTZBRjQw?=
 =?utf-8?B?NWtWRWRGWThIRHllckIwVkU0Si80QUw4bll6cmlZUWUwVGdRdUlGRi9Yc1Jt?=
 =?utf-8?B?NkwrMXRSWTRqV1lkcDlxU2I1SGZ0WGk3Wll4aytSZTRVak93UXVOOXc4TEgv?=
 =?utf-8?B?RjNzdTBDUlNTMmdZbVdxV0hYckhsV2haRTVIZ3I3anFRM1N4RlhVbFFoT3NZ?=
 =?utf-8?B?R3dnTU4wMm8rajhlaERrSnkxa25CVmhVOTZ6SHArTXFXWU9yc29rd3JHbndp?=
 =?utf-8?B?MHpJYVpsL00vVmVtVG1qY0ZjRVltMVFOb0dBSUNPQlF3UmxDdjd4cm9SUEtZ?=
 =?utf-8?B?eHVvdUtFVUJTNTVRV2J3MDN2aFVEYjgxWGhMdzZXWVYvY2t3dTFiOXFVc2Y4?=
 =?utf-8?B?REFGKytoOFBScmpVSDZBakI2YnBZU1VnemhVNG1MVDd1WFVxNzQzNFArOU5t?=
 =?utf-8?B?eXE1aXNGWW55aXBPTzBsYW5qck5lcGo1NWRxcDhMMDRnU1llU3RqZ20wNmEr?=
 =?utf-8?B?MFd6MDRKalNFNENqVFJZakNMSEFVUWF5bzE5YkJKZDVVcWlUWTF5QW1rcGE1?=
 =?utf-8?B?cytyaWxETUtCSCt5ZitxNXZLR0cyc0xuT1hFckQyNHlvblptYUpSTW5KNVpV?=
 =?utf-8?B?VXd5VTBkYmk1b3gyZ3FDUHV1VVArY1lXUytSQi9yTE1qNWhmYnhwUnRSM2x6?=
 =?utf-8?B?a0lKbGhuVTJ4ZTZJZXBxR1NRWFRNOHlyNlVHa3ZkUUxmdkZHN2RMUUt6U1Zl?=
 =?utf-8?Q?spbVf9DSbPLODzSvrDTbG6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5C2BA33C186E349BC56BC66970F9DC4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4ebdd6-92ea-40c5-8986-08dc74aea4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:21.7498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSP6vqeGcUIS+0oshk5R82CdDQ1wDHpl0NxLfhMAijAAKB6FAZwpPVYA46DInuCc5i8eh/1y8xBAHdwmK9SryltsalYJ9QeV018bZNGutvGyXoKXTD4DynBPMy+52o6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SW1wbGVtZW50cyB0aGUgYmVoYXZpb3IgZGVmaW5lZCBpbiBzZWN0aW9uIDEwLjIuMy41IG9mIFBD
SWUgc3BlYyByZXYgNS4NClRoaXMgaXMgbmVlZGVkIGJ5IGRldmljZXMgdGhhdCBzdXBwb3J0IEFU
Uy4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxMCAr
KysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KaW5kZXggYzRlYmQ0NTY5ZS4uNjdiOWZmNDkzNCAxMDA2NDQNCi0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjE2NCw3
ICsyMTY0LDggQEAgc3RhdGljIGJvb2wgdnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQogICAgIHVpbnQ4X3QgYnVzX251bSA9IHBjaV9i
dXNfbnVtKGJ1cyk7DQogICAgIFZURENvbnRleHRDYWNoZUVudHJ5ICpjY19lbnRyeTsNCiAgICAg
dWludDY0X3QgcHRlLCBwYWdlX21hc2s7DQotICAgIHVpbnQzMl90IGxldmVsLCBwYXNpZCA9IHZ0
ZF9hcy0+cGFzaWQ7DQorICAgIHVpbnQzMl90IGxldmVsID0gVUlOVDMyX01BWDsNCisgICAgdWlu
dDMyX3QgcGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KICAgICB1aW50MTZfdCBzb3VyY2VfaWQgPSBQ
Q0lfQlVJTERfQkRGKGJ1c19udW0sIGRldmZuKTsNCiAgICAgaW50IHJldF9mcjsNCiAgICAgYm9v
bCBpc19mcGRfc2V0ID0gZmFsc2U7DQpAQCAtMjMwNiw3ICsyMzA3LDEyIEBAIGVycm9yOg0KICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KICAgICBlbnRyeS0+aW92YSA9IDA7DQogICAgIGVudHJ5
LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KLSAgICBlbnRyeS0+YWRkcl9tYXNrID0gMDsNCisgICAg
LyoNCisgICAgICogU2V0IHRoZSBtYXNrIGZvciBBVFMgKHRoZSByYW5nZSBtdXN0IGJlIHByZXNl
bnQgZXZlbiB3aGVuIHRoZQ0KKyAgICAgKiB0cmFuc2xhdGlvbiBmYWlscyA6IFBDSWUgcmV2IDUg
MTAuMi4zLjUpDQorICAgICAqLw0KKyAgICBlbnRyeS0+YWRkcl9tYXNrID0gKGxldmVsICE9IFVJ
TlQzMl9NQVgpID8NCisgICAgICAgICAgICAgICAgICAgICAgICh+dnRkX3NscHRfbGV2ZWxfcGFn
ZV9tYXNrKGxldmVsKSkgOiAoflZURF9QQUdFX01BU0tfNEspOw0KICAgICBlbnRyeS0+cGVybSA9
IElPTU1VX05PTkU7DQogICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9OT19QQVNJRDsNCiAgICAgcmV0
dXJuIGZhbHNlOw0KLS0gDQoyLjQ0LjANCg==

