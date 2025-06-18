Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A327BC7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoOO-0001L7-Gs; Wed, 18 Jun 2025 04:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoOA-0001H3-9i; Wed, 18 Jun 2025 04:43:22 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoO7-0004Ys-FV; Wed, 18 Jun 2025 04:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srR9eLxJ2cAaLk1LkxUlYf3ZnFhTmAphxkHGM1LxgvSfwrrZsAPUw6TH/lXm8h6vVml9F5x++X5U6iaZc9jbCBy8ScPO3N5QnponZ621nwleMCAXmFt3aie1pWKhu9Vh/+zFRkxbblumhru6nZRE1VoDaqYriteklke6T2Acb9C5Y6JN0M0Sc4oRcPKSIVuBD2Dt6BKgC4efBZMKX6roIO8HlVqb+0AE8umE0JGBQvXgIxxIPlXOtQjeLwFFihwTqLQcRjzbkA9XG9qKp/Ze8+o9gadMrAuStMXWilVWiEBnKaGMDcNzksflgagCNK1QvoYEa4uXeDqladdlHFWoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTQBBvAOvi62raL05D5FaDEHg9lJ8ra86FSBfIewXDQ=;
 b=IwajC43TYnVed0AzMzdIMH636gnzdH7A+OETtNK8Ul1cCi9zeiE6HFBZ1gq3gO/hu26JgWKvMKzBbv6By4p8HjGIhj9ZImhAbtF277oUTtUZK8EcIc9JaZYRAxVL4Bdw/ehE5YU3jXhMR+G24k/C6+k2XVtQFE2DDrkX6JQiFUA6HXE5G0IDDzjAx0MGp8SeA7kNhPd5Io6ZMwGLoTPH3McB7AibJJNJ9wy/Xf+FU4MAV0POUMxNzR2aGKEnFy2AYr0oqCo5hYTGJ8eXL7TdcT90HL3XcD1VVMHGUS2mHeN+Gp9blc7CSoP5ek6DCoeW6zgqU9PqlUej9FofUS/Nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTQBBvAOvi62raL05D5FaDEHg9lJ8ra86FSBfIewXDQ=;
 b=tqGm0G+8sboQmRGAD+obaMU+8sdysPdTONv94o5n8cMy8SZ4g9P2FF+434QJkT4EI5EUOCLIOEaNDq3A/LsXk7ZdPEPy3VTSn58P/U69+NL37QlsvNL3JOSB1w5DuG/ZmNyKvmGcM2cSkSZilmPK68372QXt8Qkvml6zrAbv2wKABMw4ekbUDaXyl6CcGkhZ/wzt7znH+iGQh+CcBzBQQdir2ln9dASok//GJRX45tgilPLM69hAwVJpSO+RcO/OhBuhkngYAUDRltDLg3P8E+LTnsrTUnrQIizak9hMDj1gu/AKxoSrL4UWahcgWz7GqbMhYeUwVTa7L8yZhchlJQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB7909.eurprd09.prod.outlook.com (2603:10a6:102:4b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 08:43:13 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 08:43:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>
Subject: Re: [PATCH v2 1/9] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v2 1/9] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb08ABPHR9vHZGW0yKLO8lTfD9E7P8DK6AgAyl3YA=
Date: Wed, 18 Jun 2025 08:43:12 +0000
Message-ID: <c3ffa395-250c-41b2-9287-bec14cef1855@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-2-djordje.todorovic@htecgroup.com>
 <2b5cd757-5440-43d5-9415-6f2ccb5f2ea6@linaro.org>
In-Reply-To: <2b5cd757-5440-43d5-9415-6f2ccb5f2ea6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB7909:EE_
x-ms-office365-filtering-correlation-id: fd7ba5db-e12b-449d-aa27-08ddae442941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmFDYnUwVEk1OTNCaXMzL1pkTXlXZVY1UDNXMVNQY1YzRWF6MWd0NnI5UVlF?=
 =?utf-8?B?OTVoZWxzZ2R0ZFNDdkJLSkZSQjVrazZNb0diRkZCSjE2dE0wbDROYW5WOEdu?=
 =?utf-8?B?Q0t0R0VSZ2FObktGSFF0QWJaTWtDZXVLc00vNFNNbitJTk1RQ1o2Mk1SRStq?=
 =?utf-8?B?SVhhdDZiUmJ6QWJzUmdDSk1UaVNxUmlmZi9jOUk1MXZxMk9WZS9hN3A1Rmlt?=
 =?utf-8?B?T2lzWVNCMmZNeWpRbjk5TExybjNnQjhWQlE4NE1mZndCUUJmV1ljWmJBZXJZ?=
 =?utf-8?B?S1VyY0Zwa0tRbUtYSUw5a1NadkJLNTFScU9LcXpjQVVZNVdrQ0hwQURFMXVT?=
 =?utf-8?B?OUhYMVNrTTdSbzY1eHJId2cvQXBRNVJTd0lSSXhyNE9MUTZhTXp3TldTWWVD?=
 =?utf-8?B?cFZQcTdDZld2ODBSOGs0RTQ3Ry85Y2RvTzhKREJ1OTlFcmwxdG9oVnkzZWpU?=
 =?utf-8?B?ZWtITndrU2lqQXNqQk9ZbjdSdmNZZVBnVTZPRUZoQkxaZVkzQjRYb0ZmZFNv?=
 =?utf-8?B?dnFGUHlMTm9CNkxtaTRVWGhJQnU0K3hJN29jZEU5b1J0YTNwNkw3clc4bDE4?=
 =?utf-8?B?QkwwdTgwdVEyMVJQSDdJWk5sanY5dHhmbWM4b3duRUlYZXdhZmdPaUNqdmJX?=
 =?utf-8?B?a1pjQktCTUFmd2R6eWNmUFk5Vi9XS3g5VzNoczlIRktmbUM4eXAyUndUeng1?=
 =?utf-8?B?NkpvRjIwckR0VUdxUFcyU3V6Z29Sc0RTTGhPRWdLNE5Fb0QybWNheEVXUEpT?=
 =?utf-8?B?dEhGSU1pazN5djZWTUZlc0dlOGcwRmFVc2xjVVZSYm9leDNaZENKVjJrSVJT?=
 =?utf-8?B?YU9PT3Jaci9iS2RCWDJwaG5kMkxSUVl2S3Byejh1M1E3VHUvakNrM1R6TnRN?=
 =?utf-8?B?dGQ1dWRFWDBPb1d3V3d1ZFQ1ZFdwVHJLMlVoVFR4NHZuMWVUaDFLUWVBU2Nq?=
 =?utf-8?B?MlRFNGJ5b2JsZjBzbFhjTFpCTDQwRFk1cXFPWXJuVGwwdTViMlZlcDVVejFt?=
 =?utf-8?B?RWNiSFNBSzhPZi9kSXZNMi9kNy9HZGpndGUvWmVSbUo2NlpQaVQ5T2VsVUVJ?=
 =?utf-8?B?ZlZVZmNDSGV4MjBmQ2l6VHNaQnR5V2cvdHM0TGlSME90WXhRYS94YU9JclBy?=
 =?utf-8?B?c0hiSHhjaTZkRVlUZW1GRGRGSTlVMUFDTjdQbEFQMkJ6QjZ3NHQ4cnNJWHR1?=
 =?utf-8?B?SjF0WnNLR2tVYTdwTU5GS2JuR2hOT09iTFhHMTdyVHpwbkorV00zR01qR04z?=
 =?utf-8?B?MnZoQnArNUF0eklsOVZmK1JBeXpSY2pkNVQxMWZ5ZnRUK0VoUlJpdnBoK3I2?=
 =?utf-8?B?SVVOS2lKcC9Vc25rOGZTdWowcCtXNnpnbEFJZE00OHJvSUk4T3lodXlaTVhS?=
 =?utf-8?B?UDNMa1RYa2RsNldwM0NlMHdoTlNld1VXSEdjQUZRRFpZZ1ozWHJSc3B3eWl6?=
 =?utf-8?B?WlcvY2ZpbjNSNzFFY09CRFQ5aG1VdkdXcDZHOTR5TjlJN2xNMlBvakNLQzBN?=
 =?utf-8?B?WmVMdlhDaTZabTY3RzJjNkg3NXhvNXV2dWx5eEFKL1cxbDIwdzNReVVpNjl3?=
 =?utf-8?B?dU5JZzVqQy96cys4UENsZDd1ZlRkUkJITXF2L2gvbXZMelVUY2xSWENYd01Y?=
 =?utf-8?B?UDU5UVQxaTFSaWZLaXZpdEhjZWNyYTNWaFh2ZnAvZUw0MGdMWEg4Y0tjdWVT?=
 =?utf-8?B?cHpBYnZPaitUWU5VS0hnelZjV2MyT0lOb2xZblkvQ2ZVeW4zd29kVFZFbGFR?=
 =?utf-8?B?dHM2eXk0eDdRWHZVMkt2RjVWRGE0Y3kvU2VpWnBzK2ljSmRpUnNXRHJtQXJs?=
 =?utf-8?B?VzlsTytsRzFOcHhZYklhWHo4VnV2bmZWRUlLRWl1ZDZ3TDhnUUNDOGtuckkx?=
 =?utf-8?B?WkJkeTZKSm9RZmlpL0NpeGMzN1NyNVgrZnp0cDFNQUY4SzZrZkpLWEdZM3dH?=
 =?utf-8?B?Ujl0UlUrVGVtM1MyOWMzcVorMCt1eHhtbjd3TmVuVzMrQk1IbmpSL0R4MmZZ?=
 =?utf-8?B?Kzg3QXg5ZlFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkNCd1FCQzQrMkh1NTh0MFZDTHZFdTVMNnlidVU4eUhkQ0tucGVHczViMHVY?=
 =?utf-8?B?ajNGRE9hdGhMems2T3ZGM1VVN2pONmtUakt3ai9mY0xlbmtYUTVaNElhN2JM?=
 =?utf-8?B?MG5BakMzUEhsbmc2Tm5XWlp2dnFlRFVqZjF5NWc1TDJkSDQrNm9WRlcvY2RZ?=
 =?utf-8?B?SDVBZGRHS25KSEg2WUY5QWpqZDRhNDZ4THVXUG5GY2RyQ2hXRjdSamowRzl4?=
 =?utf-8?B?ZmJHOXE5WCtLaTZVVDJSRTBmME9QbW80Q296TzdUYXhBT0JRN0VvOFg4cmtm?=
 =?utf-8?B?L2ovODBxc1Fva3VpNVM2RThoUFU1aEZrRUJvckd1bStqTDdZUUY5OFJTRnZ0?=
 =?utf-8?B?V3NWd1p3T01CSFF3S2U1VWwzdE9XVDZ3MGdLWGZ6SXhTM1VJWTNiTEZZV0xU?=
 =?utf-8?B?WjRpYS9mbjN5d2VuSDVNclp5V0dnWUZodDFWTmVxdGRFaTFOd01xaUg3SFVD?=
 =?utf-8?B?bVFEMmFqMUVVVmt6UFRCK3h1NXZrNUJIL0IxaG1tNzd4bkpDUmxxbUZKVDA0?=
 =?utf-8?B?ZndCUFg5Z2VPaWZuZnZ6dU1hV3d5YURFbnRJLzVJQm5wNStUMkJHdHFweFlo?=
 =?utf-8?B?T2pWRDV5KzA5bVQ3UkNUNHVORE0rd29VRXZxdnBiaDc5YXlTWXdxY0pudlVD?=
 =?utf-8?B?eGE4MmNDQW9ZVHpsYTcxdnhqem1sT3NZUSttdWNDV1JqN3MvdlJzS3dZZ1JO?=
 =?utf-8?B?OUFrRThPUlpRVk9zMm42dkhmUjU0UDUzQmMrd0VPSlJialZCV0VWM3B3OW00?=
 =?utf-8?B?TXdFQ0FDRkNmRkR4MmV2V2M1aG1VMGNrWjg4R3dtMFVZbkxvbHdsYldhREwv?=
 =?utf-8?B?bzI2WnRWMGhaUU9mQUV6ZlFGVjh5TUVkS2ZiTzg1NWtiOWcxcjdraHNMdS90?=
 =?utf-8?B?ek9zK25EOVU0VzREc1lLSEtxU1pqTjVrZUl0NCs1L2ZaMmZ0bWZVckVGY0tp?=
 =?utf-8?B?WUVESVJhQVdzMXVCY283NTRUbHdRYXA4N2g3K043M0lSd1B0ZS9sU0hOVENo?=
 =?utf-8?B?VlpyajBUbmp3RnJGejJZNEdYWUFsRWZXOHhEbU9YVzI1c3ZrbFhDckwwR1dB?=
 =?utf-8?B?NjR5cXZwN3o0OFpFVlNJVFltdXpySGsvS2t6L0ZhSytJZlRsMjVxMjFkc0t6?=
 =?utf-8?B?R0RjREJvYlBhUlIzK1ZHWmxZMnhtS2VDTFpPRzJqdGhaUUFJbWw2Yk12Sm1E?=
 =?utf-8?B?enZTbGpzenFFcmFPNmZjMXBXNEFzNWJPcGVCM0NNU2JkOVlyOG1qRk5SUnZt?=
 =?utf-8?B?NlVGcGN4eVkvTmI1Q2RsaUVCQnl3NHFaQWdtQVJZMHdPTTd0VjVUNEFScktn?=
 =?utf-8?B?aGhLbmJnc2dKci9GMDlCTjZ1Mi9FenhTNHc0K0lsbHRYSkJ3YXVaVko2SW1t?=
 =?utf-8?B?elJnTldtVVI1ais0bUlvL2tqWWpLWkszVlBRVjlHZGlvTTZyb255QjcrVEdo?=
 =?utf-8?B?ZGNGSERQL0hDQ01OTEtPbk9EcG1qTHIvT05DQytkTFBNbERQeHVObXNuSXA5?=
 =?utf-8?B?b0tHenZHVk1hb3FJejBNVk9VUmhSWW40OWJqampWRVdvVTVlZTZxdTZSaVVu?=
 =?utf-8?B?d2FocmxoUmNESzlnRGFiSEphNW1GYTl4SmxqN0Rlblp5MlJ5bmFXOTJySTlp?=
 =?utf-8?B?aXhaOHVlbXlBdGs2M0VRWlVnemRoR2FCVWhGazE0a2JTemNCbzJzVUNScmRt?=
 =?utf-8?B?RTA2VmkxNTUxUG84Qk5iVWxrOUZmMGN6dDNCU0grL0o5VWppanhaWmIzY25D?=
 =?utf-8?B?dUxVVktQV3VCYWtQMFlWNjR5VWpMWGxpTldaZlNqY3oveWdHUXJ6eWVPSWxU?=
 =?utf-8?B?SEx6ZmFSMVE4SEF2cFgwRC9UOC81MENtc25BUjdKTWlPQWRBMHhlKzR0di9m?=
 =?utf-8?B?a3FjREdQUmQrTjFJbXhxdjVsNjQzN3phdlFTL05mcmNRL3hySGJ0QnZIZS9E?=
 =?utf-8?B?VTFGTmdYYllEOTR4RVJMS3l0cExMY2xtSFhBR0p2Qnc5VDJlaWp5UkhDekI5?=
 =?utf-8?B?RU52M2UvYTZ0bDUvaGtJdGw3bXVxTVZKNUNpaDFMM2dMK3p5aTJ6YXpLNzNo?=
 =?utf-8?B?VzE3RlllUlRXSG9heHJpc0srYXdFYWtYZDR4RTExZTE2V3VhRGlPa1AvekxQ?=
 =?utf-8?B?L1piV295UGR4djFsU1phYlphMi84VDhMbmNJY09lNTBJMitVRWV4VWZuVHBI?=
 =?utf-8?Q?Ky6ts6BCoXxhiL/kn3mCfNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55D36EB2E9A33745B47BBA725089DBED@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7ba5db-e12b-449d-aa27-08ddae442941
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:43:12.8903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6uOSHwPitCPVQ1U3n5A8uoAYzM+sHJ6oYL+owRmWJf6C1c4f9gY/bnkV1+4Hn+aPkZbOM9s2G5y5FQq7gt/mXyOzZAtEaGdgfh+mls7mfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB7909
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

DQpPbiAxMC4gNi4gMjUuIDA5OjM0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4NCj4NCj4gSGksDQo+DQo+IE9uIDIvNi8yNSAxNToxMiwgRGpvcmRqZSBUb2Rvcm92aWMg
d3JvdGU6DQo+PiBUaGlzIGlzIG5lZWRlZCBmb3IgcmlzY3YgYmFzZWQgQ1BVcyBieSBNSVBTLg0K
Pg0KPiBUaGlzIGp1c3RpZmljYXRpb24gaXMgbm90IHJlYWxseSBjb252aW5jaW5nLg0KPg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5j
b20+DQo+PiAtLS0NCj4+IMKgIGh3L2ludGMvcmlzY3ZfYWNsaW50LmMgfCAzMyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4+IMKgIGh3L2ludGMvcmlzY3ZfYXBsaWMuY8KgIHwg
MTAgKysrKysrKy0tLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pbnRjL3Jpc2N2X2FjbGludC5j
IGIvaHcvaW50Yy9yaXNjdl9hY2xpbnQuYw0KPj4gaW5kZXggYjAxMzlmMDNmNS4uNWJkYTAyYTE3
OSAxMDA2NDQNCj4+IC0tLSBhL2h3L2ludGMvcmlzY3ZfYWNsaW50LmMNCj4+ICsrKyBiL2h3L2lu
dGMvcmlzY3ZfYWNsaW50LmMNCj4+IEBAIC0xMzEsNiArMTMxLDkgQEAgc3RhdGljIHVpbnQ2NF90
IHJpc2N2X2FjbGludF9tdGltZXJfcmVhZCh2b2lkIA0KPj4gKm9wYXF1ZSwgaHdhZGRyIGFkZHIs
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGhhcnRpZCA9IG10aW1lci0+aGFydGlkX2Jh
c2UgKw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKChhZGRyIC0gbXRpbWVyLT50aW1lY21wX2Jhc2UpID4+IDMpOw0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIENQVVN0YXRlICpjcHUgPSBjcHVfYnlfYXJjaF9pZChoYXJ0aWQpOw0KPj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChjcHUgPT0gTlVMTCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIDA7DQo+DQo+IEl0IGxvb2tzIGxpa2Ugc29tZSBtaXNjb25maWd1cmF0aW9uLiBIb3cg
ZG8geW91IHJlYWNoIHRoYXQ/DQo+IE90aGVyd2lzZSBwbGVhc2UgbG9nIGFzIEdVRVNUX0VSUk9S
Lg0KPg0KWW91IGFyZSByaWdodCwgYXQgdGhlIGxhdGVzdCwgaXQgZG9lcyBub3QgdHJpZ2dlciB0
aG9zZS4NCg0KSSB3aWxsIHJlbW92ZSBpdCBpbiB2My4NCg0KVGhhbmtzIQ0KDQo+PiArwqDCoMKg
wqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIENQVVJJU0NWU3RhdGUgKmVudiA9IGNw
dSA/IGNwdV9lbnYoY3B1KSA6IE5VTEw7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlbnYp
IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLA0KPj4gQEAgLTE3NCw2ICsxNzcsOSBAQCBzdGF0aWMgdm9pZCByaXNjdl9hY2xpbnRf
bXRpbWVyX3dyaXRlKHZvaWQgDQo+PiAqb3BhcXVlLCBod2FkZHIgYWRkciwNCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBzaXplX3QgaGFydGlkID0gbXRpbWVyLT5oYXJ0aWRfYmFzZSArDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGFkZHIgLSBt
dGltZXItPnRpbWVjbXBfYmFzZSkgPj4gMyk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgQ1BVU3Rh
dGUgKmNwdSA9IGNwdV9ieV9hcmNoX2lkKGhhcnRpZCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGNwdSA9PSBOVUxMKSB7DQo+DQo+IElmIHNvLCBwbGVhc2UgbG9nOg0KPg0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiYWNsaW50LW10aW1lcjog
aW52YWxpZCBoYXJ0aWQ6ICV6dSIsIGhhcnRpZCk7DQo+DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm47DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IENQVVJJU0NWU3RhdGUgKmVudiA9IGNwdSA/IGNwdV9lbnYoY3B1KSA6IE5VTEw7DQo+DQo+IFRo
ZW4gZW52IGlzIHZhbGlkLCBzbyB0aGlzIGxpbmUgbmVlZHMgdXBkYXRlLg==

