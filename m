Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659F7E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6jb-00025I-Pb; Fri, 13 Dec 2024 09:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tM6jW-00024j-5v; Fri, 13 Dec 2024 09:33:34 -0500
Received: from mail-dm6nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1tM6jO-00055j-VH; Fri, 13 Dec 2024 09:33:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJKLq849XzNZL+f63SUIkgGaGD/A3O576hREsuy3dDZazbLxIo5gb7ONO+NiFVQ5SIMIMEagPoB9IAuZOoJ4q+0JXCZCs8O8+H+cKer7ZArQsk56IxiwFUFM2yCfT5ALcG5ebV7ZKek/KWG+6/7NkbmJWGlWRoRFZcYccBhy77Fm7GYMyWjnEKHDs2t6AUlhuKXwAr9wgA+ojh/czA1kyKDln86WiMtXHqEh9+GEzMnjtcEnXHwHD59HWYWvPBxLfBC+iIwd9/lWEXucel6sym4ke7AbKZte6gwNrqRNfKT0SRNa99bTL9BPMIVCwD4c43C3z4o4Ts2rqD1wf+BgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL+IOetdAUW+2aBj0OLqxQ/kzmpCdOUe3Lvk2n6jSTU=;
 b=MWvnIx4lZTpeYwmrKV0jvdBL3IJX9jVj4Nk/W48gxopCyt1iIoE+sqNisuNzVUJw8tm41ILYGFwO/J5hraJQvmSgXg7oPymTWPcuHpXTjMfiPwr+xs9PMBLRR3yutReRukL4IH+fK9fMXiGn8H9+yP7JPME77pRXZeLi9p0U3qc+HpPdry1EI8pDo9m8Eyle5C1I4Shhx02w6Ciin5xjQ9WABKxEHEGlFBHCLtOvMg44klIwwFNBawvLgw4lOZ/CNYHe2nOvTd3sYlRNBcmgFrl2RYQan3K+MPbXNgsdDIjrw1iGpfr/IbXFx4TZ+mHam3sh0sWqkojvajTEjCz63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL+IOetdAUW+2aBj0OLqxQ/kzmpCdOUe3Lvk2n6jSTU=;
 b=NHWUq9Ja4UMi5ndXMQ2L8rHHXujs3ZmlXLf9fAgVrbGu4gLg9buizuCJEun1XYhSVH2QwoLxJGIChRsgzN2Un1/s/fNkVN1B6RR3DZrIzD4HgI++9t4s1mQz6j2ksqBOirosGtWL0kQ6Pd3605XnheCCUvIs9uAMoPUbWKl+DyE=
Received: from CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:33:14 +0000
Received: from CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef]) by CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:33:14 +0000
From: "Konrad, Frederic" <Frederic.Konrad@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Iglesias, Francisco" <francisco.iglesias@amd.com>,
 "Michel, Luc" <Luc.Michel@amd.com>
Subject: RE: [PATCH 2/3] target/riscv: generate misaligned access trap for rvi
 insn
Thread-Topic: [PATCH 2/3] target/riscv: generate misaligned access trap for
 rvi insn
Thread-Index: AQHbTBKJngzQhJcl6EqL3st3E4jAe7LhlScAgAKoBDA=
Date: Fri, 13 Dec 2024 14:33:14 +0000
Message-ID: <CY8PR12MB841137E0E99ECF39F43047EBE6382@CY8PR12MB8411.namprd12.prod.outlook.com>
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-3-fkonrad@amd.com>
 <19c34ee9-f121-4dc2-8c73-2d06333a7d27@linaro.org>
In-Reply-To: <19c34ee9-f121-4dc2-8c73-2d06333a7d27@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8411:EE_|DM4PR12MB7551:EE_
x-ms-office365-filtering-correlation-id: daf07601-bbb7-4927-a32b-08dd1b8313c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjdGU2JGcmhGMEJIemRkQ0p0TzlreVR4ZlNObXlKdzAwZEZYTnZsZ1RpZVBy?=
 =?utf-8?B?dzJLUlJnbURMb0xueE9sZEhaVDRRdllHZVUyQVFWa3ZhaXo1V2NYQXJaM1E1?=
 =?utf-8?B?ckhqVmhBTjdYbW1Nb2dWOXZpK25DaDhKVk04NFNmWnh0Tys5UktWWlV3VzlE?=
 =?utf-8?B?V3B2L3NPNFUxY090VDZzOENaKzlFMzdocEplUGlTRnhESFJFdldUK1RxSWNy?=
 =?utf-8?B?YnBETThLSHkvNFRIMVRnaExaZzJDcVdmTTRHK3RzY1N0T3cxYWo2MUdyTHVm?=
 =?utf-8?B?RGMwdGZITWFhSVB6S1ZLMU9CeHVTdnVteDR4QUZMeWF4QmF4K1BlYkFaMUNp?=
 =?utf-8?B?SlMrR0hoMHlxbHJQdkFRU3RSL2N2RU0xNHB5dmxRYStCSGwxNFhYdUorOVVD?=
 =?utf-8?B?TVZWNVNaY1JHY0lBdzAxQUw2bmVWYlNqTHZ6THg2UjNpbjE0Wloxd1JvMklD?=
 =?utf-8?B?ZXFGMGZacTR2THFCV3FtODhwdnpuUFJOclFQSDBCQk5rMWNuN1p0TVpYbVg1?=
 =?utf-8?B?c3RxL0Zqa3c3YkxFQWczdTJOa0JYN3o4OGh6bnM4OVd6bW95UU15cGpBZ29W?=
 =?utf-8?B?cG8wZDU0WVB6R3o3dlE1Rkt6Y0JVSVBKSDZuS25PTHpVdVNVYnlxcVBTaERk?=
 =?utf-8?B?Nk9uME1QYnhMTmhsdnFCelZrcDMwLzByVkNpbWpWZXZYbVNhL3NJMW5DK0lM?=
 =?utf-8?B?U3A4SlFIWmwwUkxzZE5oK2N5Zy9HTU1xbmttUUF4UXZocVZUcWpQRG5zVG5n?=
 =?utf-8?B?eFJBVFpQdWVDbFdtTmVMUWx5aFdDdlVwY0xqK216Mzh4VVpnNFdFT1pNR1hk?=
 =?utf-8?B?TUVTdjlhOGFZOTZnUDQxUS91Q1MvWUdOOERuUGZHZnRqNHI3d1ZMVStoSWpz?=
 =?utf-8?B?QmhweEV6bS9XQnp4TkNQYUlkUkljSWZiYUVHRlZtMFRGQkpJVlZwZUJuSW9r?=
 =?utf-8?B?VUpnaEpYdVdIYmEvYnRBT0V3SVBHYWRIVHo1dDlXVUZreTBFald2TVJtcjdu?=
 =?utf-8?B?MFJhQi9RdERjcEV3TFZOTkQyZXRvN3R6dGhROFZ4NVNWYWRqU3hjbFhySjU0?=
 =?utf-8?B?cDZFUnZ3YUFBbExLeXJkd0duUXA0VmJ3OGlQTUJTdi9XRFFFMTlkRy93TVVE?=
 =?utf-8?B?VlJZc2diV25PRkplcU44ZGxUSXMxaDBlTVRhZDVDMFhnQnQzckZKdVZ1dE1y?=
 =?utf-8?B?bGtObDNMREI0RWJUdjNhZGFJM2JVdEFzc3dpNEdWbzF5M2MwbjlqMGVKbHpD?=
 =?utf-8?B?YnZ3a2poUmtWZDVtc3c2VTBNVnVRRmlOM1RQeUV4SDMvSTdGTDRUekczRVda?=
 =?utf-8?B?ekZ2Z2FHeVE3MzZMNStJaTN1ODFhYkRLSDVBamw0cjZTbmRGSUYxbWZtdnBz?=
 =?utf-8?B?bE5PUFJXTEdzYWxHR3hPbVJjei9CWEF5NmVEREd3alRCbDN2MUtHaGRybXZS?=
 =?utf-8?B?ZjZ6RDM0bmpGRkxyaFpOY0hEWmt3bVNkQy9reFBZRGh2cUt5Tlc4UTdTN2ll?=
 =?utf-8?B?ekYza1l3QkNGRFhSL1dYSG5PZ0lkWjBBL0ptK3lWU08wM0c5d0N5N29nRWcv?=
 =?utf-8?B?VmxmVTVpcmZGcWpKSExPb00xMWhaRlg0cUxBVHVlTVh6Rzh5OWYxN1d6NWNs?=
 =?utf-8?B?VjdmT3FRaUFSMERUTHBLVUNDalhUMkxEWnFQNmhRMEQ4SXZNakNBQTNlMURZ?=
 =?utf-8?B?QStqSHhjM3ZEWHZvMXI2dzdzaVdLVVkwZVFqUjhoaFdHaDJIKzIwRzFYQ2R5?=
 =?utf-8?B?c3lrWXlwSmZhRmIxSWgxQ1hTMWZBUERMbmI3UVdaSzlrazgwTk9rc2xuc0p2?=
 =?utf-8?B?ZTVXWWp1NW1nNFF6MnFGM2FJTEYvL3VWUGowRWNpRkV3bmJNYXFYZnNpb2hu?=
 =?utf-8?B?ZXlrYW5iNlc4TzdhbUNERDlxMmZ5TDRHamNmM2Z3aVpsMVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0l4LzZCQ3VOWHB0K2pKS1Iyc2tTYlZNdTJXTFFLT0E2M09iNXZlTWFHTDFw?=
 =?utf-8?B?NTY1YkFFamlNQms0RzVjS01GTkExYkdrYVBSbTUxWDJndlVZdS96bDdrS2pi?=
 =?utf-8?B?UGpOR3RlenFXZlozQXZWdjVBVXJCczhIdkJlMng3VXdsMWF1TTJuYWd0TTdx?=
 =?utf-8?B?YlhtVTg0ZU0zM2ZnbGVlWVpFQ2U1b2FHOFcvOFhUR2M0KzEyTDNNR2RHbUVm?=
 =?utf-8?B?RThJMmliUnVlTzZrZXN6eFhvTjRyOFh3TTZMd2UwQlFTbGhtNHhlOU9qck12?=
 =?utf-8?B?RHU1Q2FwMUUxUjNuVytpY25UMUJrUmcwNVhwWDZ2eEFaekU0Y1IxR1dWNU0w?=
 =?utf-8?B?dk9IUHhvNDB4MUZQSm5YeTM2cUQ3emp4ZkVUTkFjT1M5WlpTWWppMmZrU2hX?=
 =?utf-8?B?OHdnaEtIRkFzdUhaclIvMkVRTW5kanNGaEc3bkVqSTVvZVA4N3dFMG5lM1JR?=
 =?utf-8?B?RUFBallqM2VBNStBclFJTmh0UlZ3SWJUdk1jR1VoZmlhQjFnRFVpL2YyOXFO?=
 =?utf-8?B?RFI4Nk1uTW9lMWp1dm5Ca3F6eDdOekFOWlJUUnZVU0NKL3k3T09Za01FdGxW?=
 =?utf-8?B?dmtCbnZaaDN2dHdvMno3MjFKd29Rc1Jla2dXV3VaVmxlcVJlQ0NxQ21ZZm15?=
 =?utf-8?B?Z3pWcFkxdHEyUml4VENTYUpOUk9hdTV2dm1hZ0xjdzViZFluN2hEaUp0WHNq?=
 =?utf-8?B?RDI1NWF4SWJhQW5nOUdQSUJXZFJXOWlnVGxLSVhheGhWYlFIM0ppNjgybVgv?=
 =?utf-8?B?YVJKTzc5V2V6MUFwSGxsUnJLK0VXdGVZSkpmVHFNeExzdlBaeHk5UXhoYlFk?=
 =?utf-8?B?NVg3ajBWRGcvSHgxWjFTUitodXlWc3E1bHp6eXJTVG5YTFF3YkZFTUlheWJq?=
 =?utf-8?B?Y1N1TFFkdDFyT1JDdVRQYWJLNUxFNXUvR1dUdkpUblIxczZsbkFPMHNpcmFS?=
 =?utf-8?B?NVpmbHFucDNKUnk5NzRSRWpiRUxudnN5RW5xZHB4cjZoM1ZhWCtJVmN0MGwv?=
 =?utf-8?B?ZUFDUHhaeEkwcy9JQXZSMzdFaVlyOHQ3alRGY0VUaEJWZlNvY1dyaVc2VHM4?=
 =?utf-8?B?SzR0V25IRlBmTmFPV2pEUk5tK1ZRY2VZZnJXRkpTdlhzaDlYWTdjcjdWRnJs?=
 =?utf-8?B?V2I2OFpoWXVpOGVLTm9ZUUIzdlNVVkxzMlVMdnNvZ0FLbjRCR0I5aEwzNVNp?=
 =?utf-8?B?aHZNYUovTjNkbmFEeEd6ZkRLV0hjTUxnT2tuZ2hESkFrdFNsdHIxdnR1dkdF?=
 =?utf-8?B?cC9tNWJINjBURUxaQzQ2V09JTEIwczgvdTlWR3pUaXNPYnUyTmliNlhOazlJ?=
 =?utf-8?B?azdCWFpNQ1lLTlVzVXRRVjF5YmVuaEFUdmJUQ21LMk9qenYwNzh2N3o4c2dC?=
 =?utf-8?B?bHNkZGlBUzBwQlBHMEFoY0NlS21pU2FidHB1NldqVUFNUFFrbjNmdnpVU01u?=
 =?utf-8?B?WTRkYlRKb2dmK0FCd0F6Tjh0YktKa3ZEK3EwcHppcVIzYkJsVHl3VW5VTnJB?=
 =?utf-8?B?UkpWM3FzN0JVa01kdGszbmcwcWE1SG9pQ1BocXRlNVNnKzRBdktoY3gwaWJp?=
 =?utf-8?B?YWhQTlQ1alRSV3FTTkZjd05oc1RmMTJWQ3JjYU50Z0tvckZBQUpMdEtCNnN2?=
 =?utf-8?B?UHFvbEdTSFZQaHN1V1FyOGRTemswekQwN0FJYzVkTUpDUWh4OVJaemhVaE13?=
 =?utf-8?B?ZlZ2bnYwNUIvbVlydjZvTHkzbFRsWFI1eEZXQXBuVnFXNi9DYjM0TzlkR1Nz?=
 =?utf-8?B?WjNFWWJpTUpwbmN5cmh5Q1g4V0VDMyswK01qZDRNcWNkSkpESkZody9vbmFB?=
 =?utf-8?B?Q1B5VUFCeUF2MXVKSHdyZkVyNXZKcHlWdndUdStzQ05mOGJOOTNuNy83UUEz?=
 =?utf-8?B?cnJHRURYcHIxQUEzTXlWcjBKc095OElqZm5DSmZqelkyYUxmWFJFd1B3N0lV?=
 =?utf-8?B?RnU3Ymw3elVwaHo5K01PVFRvTXhiOFBCWU1sL2ZUZ05lN2ZxT0VuOG1aQ3M1?=
 =?utf-8?B?by8rY0JpNjI3N0hSVWJFVnhCY0xvVVc2YU1hMWhHVndNaUVKZ0s3NU5uTEdq?=
 =?utf-8?B?bW41ZytYUkpVVUFhR2dSZEFBMHY2S0ZjQUhkaDkwczNQeTZtM1g1TTVIa3dE?=
 =?utf-8?Q?Rg3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf07601-bbb7-4927-a32b-08dd1b8313c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 14:33:14.2627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqPl9xC7cKjIKVaWh+7I3qvGweW3PvY9zi+ifpev20/+SqUonnrJl+pXjrS32aPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
Received-SPF: permerror client-ip=2a01:111:f403:2413::60b;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4NCj4gU2VudDogMTEgRGVjZW1iZXIgMjAyNCAyMjo1MA0KPiBUbzogS29u
cmFkLCBGcmVkZXJpYyA8RnJlZGVyaWMuS29ucmFkQGFtZC5jb20+OyBxZW11LXJpc2N2QG5vbmdu
dS5vcmcNCj4gQ2M6IHBhbG1lckBkYWJiZWx0LmNvbTsgYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
OyBibWVuZy5jbkBnbWFpbC5jb207IGxpd2VpMTUxOEBnbWFpbC5jb207DQo+IGRiYXJib3phQHZl
bnRhbmFtaWNyby5jb207IHpoaXdlaV9saXVAbGludXguYWxpYmFiYS5jb207IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgSWdsZXNpYXMsIEZyYW5jaXNjbw0KPiA8ZnJhbmNpc2NvLmlnbGVzaWFzQGFt
ZC5jb20+OyBNaWNoZWwsIEx1YyA8THVjLk1pY2hlbEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gdGFyZ2V0L3Jpc2N2OiBnZW5lcmF0ZSBtaXNhbGlnbmVkIGFjY2VzcyB0cmFw
IGZvciBydmkgaW5zbg0KPiANCj4gT24gMTIvMTEvMjQgMTU6MTksIEZyZWRlcmljIEtvbnJhZCB3
cm90ZToNCj4gPiBOb3cgdGhlcmUgaXMgYW4gb3B0aW9uIHRvIGVuYWJsZSBtaXNhbGlnbmVkIGFj
Y2Vzc2VzIHRyYXBzLCBjaGVjayB0aGUgYWxpZ25tZW50DQo+ID4gZHVyaW5nIGxvYWQgYW5kIHN0
b3JlIGZvciB0aGUgUlZJIGluc3RydWN0aW9ucy4gIERvIG5vdCBnZW5lcmF0ZSB0aGVtIGlmIHRo
ZQ0KPiA+IHphbWExNmIgZXh0ZW5zaW9uIGlzIHRoZXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogRnJlZGVyaWMgS29ucmFkIDxma29ucmFkQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICB0YXJn
ZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydmkuYy5pbmMgfCA3ICsrKysrKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19ydmkuYy5pbmMgYi90YXJnZXQvcmlzY3YvaW5zbl90
cmFucy90cmFuc19ydmkuYy5pbmMNCj4gPiBpbmRleCA5NmMyMThhOWQ3Li4xMjgzMjA3ZmM3IDEw
MDY0NA0KPiA+IC0tLSBhL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYw0K
PiA+ICsrKyBiL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYw0KPiA+IEBA
IC0zMjMsNiArMzIzLDEwIEBAIHN0YXRpYyBib29sIGdlbl9sb2FkKERpc2FzQ29udGV4dCAqY3R4
LCBhcmdfbGIgKmEsIE1lbU9wIG1lbW9wKQ0KPiA+ICAgew0KPiA+ICAgICAgIGJvb2wgb3V0Ow0K
PiA+DQo+ID4gKyAgICBpZiAoY3R4LT5jZmdfcHRyLT50cmFwX21pc2FsaWduZWRfYWNjZXNzICYm
ICFjdHgtPmNmZ19wdHItPmV4dF96YW1hMTZiKSB7DQo+ID4gKyAgICAgICAgbWVtb3AgfD0gTU9f
QUxJR047DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgIGlmIChjdHgtPmNmZ19wdHItPmV4
dF96YW1hMTZiKSB7DQo+ID4gICAgICAgICAgIG1lbW9wIHw9IE1PX0FUT01fV0lUSElOMTY7DQo+
ID4gICAgICAgfQ0KPiA+IEBAIC00MjQsNiArNDI4LDkgQEAgc3RhdGljIGJvb2wgZ2VuX3N0b3Jl
X2kxMjgoRGlzYXNDb250ZXh0ICpjdHgsIGFyZ19zYiAqYSwgTWVtT3AgbWVtb3ApDQo+ID4NCj4g
PiAgIHN0YXRpYyBib29sIGdlbl9zdG9yZShEaXNhc0NvbnRleHQgKmN0eCwgYXJnX3NiICphLCBN
ZW1PcCBtZW1vcCkNCj4gPiAgIHsNCj4gPiArICAgIGlmIChjdHgtPmNmZ19wdHItPnRyYXBfbWlz
YWxpZ25lZF9hY2Nlc3MgJiYgIWN0eC0+Y2ZnX3B0ci0+ZXh0X3phbWExNmIpIHsNCj4gPiArICAg
ICAgICBtZW1vcCB8PSBNT19BTElHTjsNCj4gPiArICAgIH0NCj4gPiAgICAgICBpZiAoY3R4LT5j
ZmdfcHRyLT5leHRfemFtYTE2Yikgew0KPiA+ICAgICAgICAgICBtZW1vcCB8PSBNT19BVE9NX1dJ
VEhJTjE2Ow0KPiA+ICAgICAgIH0NCj4gDQo+IEkgd291bGQgaW1hZ2luZSB0aGF0IGV4dF96YW1h
MTZiIHdvdWxkIGRpc2FibGUgb3IgY29uZmxpY3Qgd2l0aCB0cmFwX21pc2FsaWduZWRfYWNjZXNz
IGF0DQo+IHN0YXJ0dXAuDQoNCk9rIEkgY2FuIGZpeCB0aGF0IGNvbmRpdGlvbiB0bzoNCiAgaWYg
KGN0eC0+Y2ZnX3B0ci0+dHJhcF9taXNhbGlnbmVkX2FjY2Vzcykgew0KDQpBbmQgdGhyb3cgYW4g
ZXJyb3IgaW4gdGhlIGZpcnN0IHBhdGNoIGlmIGJvdGggYXJlIGFjdGl2YXRlZCBhdCB0aGUgc2Ft
ZSB0aW1lLg0KDQpCZXN0IFJlZ2FyZHMsDQpGcmVkDQoNCj4gDQo+IA0KPiByfg0K

