Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92BDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszxN-0002ym-N1; Mon, 01 Sep 2025 04:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszxK-0002xe-TG; Mon, 01 Sep 2025 04:32:02 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszxD-0003Zp-SO; Mon, 01 Sep 2025 04:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4MyMYPUANzDwzdQmhuCm+wXQUTZ6Hrz3nvokVutil6XlbCajg2Z/PSEe6nwEeYH0ZDCT28h8h+JPjBEy15ybY0snnOm0icZX41/LunTJ1cWmdHF141r8ufYJTpP+64KD5v3oTK5Z8xfGpX2WUAqCnH6dsylOj7+4U1Nvsr0sNQ7cX0n+nrg3Mql+bwmugieGjs4BcQmZyHmqqqhQJhuKVH5WyP4FXXoxO/pzieRW+kYJeI0Cxt/tgwFobELjbTQsdxLLqpRHXECJkKaxIACP0PmNVE4nNFfX3Psk8VAVBAhq16m5RT9f9A1gruYvtii/hdYVXouuNJFt009uPqS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJdEVFq8E8wtAF5NviOKyCX/oE+oQxok/QSTL5ZwyG8=;
 b=rq71JZ3aVprFM/4fMPY0xwSLgNTg7r3dzmGMbsrfYhrGnnJELcr4KFgBBajePhhmJ1OvA9vG2S+SFWkHaNvhvqbWKXICLAL8Irxb4Tusv4rLNS5gEc10J2n8ch533WnfcM3EesrQUPEbO0plqXSxRJPs2rsZmVWbwZXPYl0mxIYSX1dk9Vl3x3IkkOdblWQkxu58s1uh4xPzOqIL7IJlUOJVCF8wjfm9T7DIxyTC5xg+bivfvsa/xR2DDw/M6B6GPRC0/UAVYFqKvwZPcfjs8Ey0/KkwZYnA3YfrjNI04DW6QCXO28Q+PiwDVQ+j8w4X5JRKGzWcYw5KDSEsuhQoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJdEVFq8E8wtAF5NviOKyCX/oE+oQxok/QSTL5ZwyG8=;
 b=DBr+mPd2iqy0NSBwPleIlPt5egVLzKOR6c8MYIFOdQX31J8es62VlgT9VnsyX6FccRUGBS36V08/s10788CrQgkTjVbmsDqpf/dfafifwsKnV9ICPwiy6XJOWgFEMDQX6TkdZi/c3zRcXDQZ3f2KF+dwR0kUiPtro8HaU+GvTQ69lmt4Q9ECfG8W4CQH2Aw4RAe0UGJSI9gxBu2iPNQgvDv9iw+oV778SZHXWnkGfL6pKhEUY2M/4gkxTlGoUfqAXgpiC0UueiwVIsVB+9G8KLgE6PjP3bNJwaLEeKusseuLBIrANubpG7klZa2saNLYvjWInpkwYfWiVGeUsqLARw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4074.eurprd09.prod.outlook.com (2603:10a6:10:127::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 08:31:49 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:31:49 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v6 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb9v6XjEBVch1nWE+Q3So8hAVSf7RZFS0AgCUyjAA=
Date: Mon, 1 Sep 2025 08:31:48 +0000
Message-ID: <08dad207-96ac-46d0-bdb3-99caafd73df6@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-13-djordje.todorovic@htecgroup.com>
 <89d0c3e5-9a86-4230-936b-9d3b3d53ffdc@linaro.org>
In-Reply-To: <89d0c3e5-9a86-4230-936b-9d3b3d53ffdc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4074:EE_
x-ms-office365-filtering-correlation-id: 2b620a07-7587-4ea0-0f5c-08dde931fe9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHdKSFQ5QndlemtCWEZLM1NjU3d0RUxPcmkvNkh6WU8rWFhSb0dWMWlodWI0?=
 =?utf-8?B?bkovWjkwaTZlaWkvMkJHNENHNnlGNTk1L2JjSFpoak1GbjY0UmpzalovY3R5?=
 =?utf-8?B?NzAvYzlpMWZSdFN5SWpUMG95NUxEYnlxcnN4RVBGVHhtd01xeDl3WldFQnZF?=
 =?utf-8?B?YXlSRTNYMW9iVDAxQ292MEVVd3JOWkliWGpmaTZQaGF3ZEs3S0ExM0JLa3Ji?=
 =?utf-8?B?TXFmSTZmTjJZOUE1Y0hENi9kYnlzV3Vodmd0aVZYTlI5aitRbDA2dU11aVo2?=
 =?utf-8?B?YmZhak00MFdHeGlSem5WUml6RUREWEFyM3FpNFhGYW1EYU94bXNLTWU1WkZw?=
 =?utf-8?B?SEF6RTYyVmlPWW9Qbk5mTlRlUG9sS1daL2JidWZWRUFaOHJtbVRFQWhsSUlN?=
 =?utf-8?B?WVVFeVkrb3kya2U4c2trbGpjSmR2Vm4vNlR6OU9WNVdqL1Z0K3dtTGdtc0tP?=
 =?utf-8?B?clRoZzBZMFlpdHVDdUtBV3lLRC83bjRPQk12dkpTbHlvMFJ6Sjd5TkdoMThM?=
 =?utf-8?B?S3h2SzZyVTZpV2U4YXg1OXZxNFc5R2l6cGM1eXRTSmxBQ1JyMEVIN3lCQXZz?=
 =?utf-8?B?Q0tqUndaVnNUSjBtNGVaQ2dlajdmYjFDUzMxNDBXYWNMcjlvSmpmdjJUM3Fu?=
 =?utf-8?B?NFMvTWVFQzRqc05TRks1UGhyaXRSZXNnZXFlRWswRnB3S0VDa1RRRkxISHU3?=
 =?utf-8?B?THRhWDdYbkJRRzVZTFBlK0xaMVY5ZE1Wd0tkdld3OW5DZlpHQ0dpYUx4alNQ?=
 =?utf-8?B?QWloQ1pZRHoyVWdTVUIyc1E4M2NmQy9TSHJBNXlqc2hjbnBPS0lvZmZrVUdS?=
 =?utf-8?B?VXRNY0UrN2krQW5XSjNNWWJoRnBlVVBmSFI2dUhDOU9CM0FTV01ReHRtTnhU?=
 =?utf-8?B?MTBKNnQyOUNnNHdIMXBuZCtpVm00WFlKRmkwUWViOHdRRFBqSURVUW1EZzRm?=
 =?utf-8?B?bi9JUnFCSjhKQ0hyeFhFRkZOQ0hYR01TZmp2bzR1RFo0Ym84QzZQZFZOWFhJ?=
 =?utf-8?B?dVRBNWhKbHIzYnRHZzRaRFhVa0RleHN3R0ZjSFhWWC9NTEN6Z1VNelVpS2Nn?=
 =?utf-8?B?N2FTMFNkY3Y1bUhEUVorL0RoVmpDNU5ublRwZ0tvRWxLbUFvZ0ZkZGFXWXBU?=
 =?utf-8?B?QXhMaVUrVGMzcHlnMVNpcXQxbW0zZXcrUlJxTlhzTy92cDh2RXdjZDh6ZXlY?=
 =?utf-8?B?Y28vdHVSS0pNclJ2UlFLSUhlQXIvMWxpRDBaOUpzQSttYjBHOFhTRVFBQlA2?=
 =?utf-8?B?TlJJaFZOR3dCeFNSZTZwV1RaSlduR2dpLzJZK1oyWGpUT0JpUHphOFlxRjRX?=
 =?utf-8?B?STN2TGg1YkpWcW1wem1lZEU4T0w2ak1qZ2dIK3EzVEd4RWVtQXN0M2JDY0l3?=
 =?utf-8?B?a3hiMmZZbVN5MVNwSXI1YXMxTWNZMkU5L1dsRkpsY2ZKS3RSNVQyejJLUUsy?=
 =?utf-8?B?WFRrRXFTNGpZRzNZZlM4U2NRYlFOTkNDa2x4dUlucVBnQ0RMTzRoTWp2RXI2?=
 =?utf-8?B?M01hR1gySDVWTEEvdDF5bGtUV0s3NzJhRmo1OUJCUkwwUkZ6M0owa25IaWtw?=
 =?utf-8?B?Z3lRelJsNFZYSjlmNFhIeGZJVTJ3VE1IekZMNFdJa2F4RWJYTWZLd01CTmpx?=
 =?utf-8?B?dTVuT0JCdjFsZUxvTktVampsQTFxTUFnK3pYK0N6S3htWmFiWSt4ajVGUytQ?=
 =?utf-8?B?WUtpdXV5eldqdmpDTmo3UDJJcHM0d055NERHRGo1TklOZ2xNVVEwU3ByNkYv?=
 =?utf-8?B?Y1dJeDNyRENiUWhjbUo4R0RuQXB3bi9keVdzUkxsMGYxa0Zlb1pRdWlleHRu?=
 =?utf-8?B?YWd5dngzTnNhUllibGlIU1UzNGNWWk9xT1VLekdiQlljVW82SlNyYklpYTg1?=
 =?utf-8?B?WUxzWitXVWVnS082V0dLbHlTa3NRVzFmTkIrb1kzcjFSeWZzaS9BdzlGK2wr?=
 =?utf-8?B?Q0J1TnA5a1FKYzIwUFU3bHlha2o5Q0lkbXFEdWQ3REs4VmUyMmpua2VydG1s?=
 =?utf-8?B?T2NPQ0lQYzhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHZ1c1NBU2plTWJxMnh4aUVKenRFODA5QVR2cUJneDhUeEp2R0cxcGxyOXdI?=
 =?utf-8?B?UGRsalg3c3NuRXlVaElXTDlwL1pRKzkwcDh4U0VTa3lkY0U2djZGQTYrTG5G?=
 =?utf-8?B?cjFsUUtsakRJUFhvL1ZoYzVqSXpVb3BYc1cvS280T1loVWYzaGVjeU50NlVh?=
 =?utf-8?B?NnpFSWlNeTJhVy9ONnEvVU0zUkV1MjQ0bVZ2MFBFNFpYZndtSEZKSjJVYVVL?=
 =?utf-8?B?V051R0xQSmF1eitpMFpLUDh3TEppM05Obi9rc2NwWTYwSVN1dG51aDFheEw1?=
 =?utf-8?B?SVY1aFloZERFNzIwTkVDYWxqUklydEZONCtWYi9HWlRlUWJOWWtWRXdjcHFH?=
 =?utf-8?B?aDdpMnlFWWc4MEwxKzd6bG8yankxanMrdnB3M3JPZC9CTlFCYWsxaG1xV2I5?=
 =?utf-8?B?QkQrQnVEUmNjOE0xdlF2N3F3OSt6UUkweVlSaFY2RVVwZFlMRzk2VnFZTDJj?=
 =?utf-8?B?Uis2Q0JOVTFzYzQ4VzlsRnIzdy9TSC9MNGJLTUtiQkVicnoweGtXVkFZUElN?=
 =?utf-8?B?aWRVV3Fia1g3TUZlcVkrb0k4L0RyeXVBR2QxNzQ3aWZ3ZEY5YVdITWdISEUv?=
 =?utf-8?B?NWIvNGhsbTV5Vk8ycFd1Q0xkN1BHNEx6bXdjRVRHV1BpbDBpR0d4RUM4ZUVK?=
 =?utf-8?B?ckF6SHJBSzRLdnBUOXJic3NpbmhZK1d6OFdqRjBLWFlWdGdaWjVOcUQ3Vmdu?=
 =?utf-8?B?UXJZTFY2Q1dOZlFORzlqTUgwM05ORXpjVFlJT1JVR1oxWHNWZnB1amtKa2lU?=
 =?utf-8?B?cGp5alZwaDZJd0FKM2kxNHNnS2RhQ1o0b1lySTA3bTV3b1ZvNis0UHZwTVQ4?=
 =?utf-8?B?bHAwTmIrd0xCU1ZiTkF2d0pXdnMwcWxmalREMXMrWDcvZlI5OWJkUmxqK3d1?=
 =?utf-8?B?enBOWkRvd0grM3VTbFhKZk9haHdQOVVwMUUzaTdIa2JVQTdQajJBUFVmWlN3?=
 =?utf-8?B?eEQzcjdFVzRJdlZLRFVlNWRvY0FFamJiYVlWcm5lTlBjUkR6bUVlcEp4eVJt?=
 =?utf-8?B?R0lxcU1meG1iKzdjZFpNbCtsLytMWUNSV1Y2OGJLTmJGMTE1L1JYa0M3L1RJ?=
 =?utf-8?B?eTNlUnJLNnUrb2dIVnVDcGl2OXpaMUE3Zks2eXB3VE1TOGJ0YjBGT29CaDNK?=
 =?utf-8?B?Q3ZZYnZ5NW1SYWswU25ZWm81K3Mva0I3OUE3RGdESXJ4L3Z1Z202SGdIaERJ?=
 =?utf-8?B?OU81R2RwYVFjK3FMTVkyTkZrZERmNk5IMk5MdmhIakZtcVdlU0NiTjBhL0RB?=
 =?utf-8?B?KzkzcTBuNGJSWU5halZobW81TnVEZzlWdUwwQ3RJSVF6ZDlKRXRHSlhUYWtQ?=
 =?utf-8?B?U1ZEenBNOVZrWlNUbmVYKzdOTzJLMDVGRkQzYUg2ZCtMSWtxSVlCWC9XQ3Zh?=
 =?utf-8?B?SC92MllzSTZCV3pwRVBrcytaaFk1WG44anNSaWFKaUlkU1hwUGNMR2Rpejgz?=
 =?utf-8?B?SWFkUTMyMGw0em5rcm5lbW9jeGN2LzF2Z004RGtqNkx5K3hQS29za1UvbWJ4?=
 =?utf-8?B?clpwMlgzaTlvSWJJM2JxNFFzOUJGQ29VakJEc3h1Y1Joc1E4dFFTcjJ2Z01m?=
 =?utf-8?B?QU9Vd2FyaE9sSklxWGRvWE1DSVdjeFNmTDhwOGFWNFlCRjRnYjZlbENMK1NQ?=
 =?utf-8?B?WURobzZpVXpsc2NBMGFBQkFCRGZRZnZpWElZR0V6ZnZvWnVFT3dINm92VDhI?=
 =?utf-8?B?Mk1RUjJ1UmxVMzhzT2Fsa1hVVU9LaUV4NGtWUXpXR09WUFd3TzJtaDBjSUtZ?=
 =?utf-8?B?RnNzL21rRE5oNXg5TlFmZEFESUNCbllZd1hiZjFkNWF6UHg2YmZ6SlI3em5t?=
 =?utf-8?B?Mkppekt6NFhPdkRkOHAzWUZscSs3a2drZlJicDRVTllwMHp4NnFEbCtPNW5T?=
 =?utf-8?B?ZzFSbHY4eW1yRnVQTXA5dXhkSTNwUVg0cDdQYnlacERIRUNpUElqbmFKdkda?=
 =?utf-8?B?eXdMT3ltMmFtMlhoMVZsaTMzUGtCaWxOajVRcEtLQXB2QllJTm9JcFFOczhx?=
 =?utf-8?B?eUFRZ1dwcHFya1l6T2pITmU2azd2WTYyeGs5ZWJRMFViMEhLeGlmM2FKNkkz?=
 =?utf-8?B?aDYxNzJLY3hZR2kzdm10VUhvWTNZRWVZelVpb0JhVXFobks1YU1hTFFGVkc0?=
 =?utf-8?B?a3F3QjUrdzBocEp4ZG9vb0taa1dlNnBxa2lBRWZwSjBFd2lCTW5JbHhJT2hB?=
 =?utf-8?Q?dmMxPwHYVRNc2VRGPsGed90=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB316A96BB042F42BB751779B22A9FE7@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b620a07-7587-4ea0-0f5c-08dde931fe9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:31:49.0391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrO8S2eeBK5sBx+7HuZ0pKBVSmZU5GnV2m+fBAA7fuTpTidTlVTQ9K2B0c3O1Wnd2OxsGkQjwdzirfuEAkb8d1jB7IWjWSEJh4lo3ixVM8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4074
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

DQpPbiA4LiA4LiAyNS4gMTg6MjksIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiAxNy83LzI1IDExOjM4LCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IFNpbmNlIHRoZXJlIGlzIG5vIHBjaF9nYmUgZW11bGF0aW9uLCB3ZSBjb3VsZCBiZSB1c2luZyBm
dW5jIG90aGVyDQo+PiB0aGFuIDAgd2hlbiBhZGRpbmcgbmV3IGRldmljZXMgdG8gc3BlY2lmaWMg
Ym9hcmRzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3Jvdmlj
QGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+IMKgIGh3L3BjaS9wY2kuYyB8IDE1ICsrKysrKysr
Ky0tLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3BjaS5jDQo+
PiBpbmRleCBmNWFiNTEwNjk3Li4yM2Y3ZjAyODM3IDEwMDY0NA0KPj4gLS0tIGEvaHcvcGNpL3Bj
aS5jDQo+PiArKysgYi9ody9wY2kvcGNpLmMNCj4+IEBAIC05NzQsMTQgKzk3NCwxNSBAQCBzdGF0
aWMgaW50IHBjaV9wYXJzZV9kZXZhZGRyKGNvbnN0IGNoYXIgKmFkZHIsIA0KPj4gaW50ICpkb21w
LCBpbnQgKmJ1c3AsDQo+Pg0KPj4gwqDCoMKgwqDCoCBzbG90ID0gdmFsOw0KPj4NCj4+IC3CoMKg
wqAgaWYgKGZ1bmNwICE9IE5VTEwpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoKmUgIT0gJy4n
KQ0KPj4gK8KgwqDCoCBpZiAoZnVuY3AgIT0gTlVMTCAmJiAqZSAhPSAwKSB7DQo+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCplICE9ICcuJykgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC0xOw0KPj4gLQ0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBwID0gZSArIDE7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsID0gc3RydG91bChwLCAm
ZSwgMTYpOw0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChlID09IHApDQo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKGUgPT0gcCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0x
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZnVuYyA9
IHZhbDsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gQEAgLTIwNDUsMTMgKzIwNDYsMTUgQEAgYm9vbCBw
Y2lfaW5pdF9uaWNfaW5fc2xvdChQQ0lCdXMgKnJvb3RidXMsIA0KPj4gY29uc3QgY2hhciAqbW9k
ZWwsDQo+PiDCoMKgwqDCoMKgIGludCBkb20sIGJ1c25yLCBkZXZmbjsNCj4+IMKgwqDCoMKgwqAg
UENJRGV2aWNlICpwY2lfZGV2Ow0KPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBzbG90Ow0KPj4gKw0K
Pg0KPiBbKl0NCj4NCj4+IMKgwqDCoMKgwqAgUENJQnVzICpidXM7DQo+Pg0KPj4gwqDCoMKgwqDC
oCBpZiAoIW5kKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPj4gwqDC
oMKgwqDCoCB9DQo+Pg0KPj4gLcKgwqDCoCBpZiAoIWRldmFkZHIgfHwgcGNpX3BhcnNlX2RldmFk
ZHIoZGV2YWRkciwgJmRvbSwgJmJ1c25yLCAmc2xvdCwgDQo+PiBOVUxMKSA8IDApIHsNCj4+ICvC
oMKgwqAgdW5zaWduZWQgZnVuYzsNCj4NCj4gRGVjbGFyZSAnZnVuYycgZWFybGllciBpbiBbKl0s
IG90aGVyd2lzZSBMR1RNLg0KPg0KPj4gK8KgwqDCoCBpZiAoIWRldmFkZHIgfHwgcGNpX3BhcnNl
X2RldmFkZHIoZGV2YWRkciwgJmRvbSwgJmJ1c25yLCAmc2xvdCwgDQo+PiAmZnVuYykgPCAwKSB7
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJJbnZhbGlkIFBDSSBkZXZpY2Ug
YWRkcmVzcyAlcyBmb3IgZGV2aWNlICVzIiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRldmFkZHIsIG1vZGVsKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBleGl0KDEpOw0KPj4gQEAgLTIwNjIsNyArMjA2NSw3IEBAIGJvb2wgcGNpX2luaXRfbmljX2lu
X3Nsb3QoUENJQnVzICpyb290YnVzLCANCj4+IGNvbnN0IGNoYXIgKm1vZGVsLA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGV4aXQoMSk7DQo+PiDCoMKgwqDCoMKgIH0NCj4+DQo+PiAtwqDCoMKgIGRl
dmZuID0gUENJX0RFVkZOKHNsb3QsIDApOw0KPj4gK8KgwqDCoCBkZXZmbiA9IFBDSV9ERVZGTihz
bG90LCBmdW5jKTsNCj4+DQo+PiDCoMKgwqDCoMKgIGJ1cyA9IHBjaV9maW5kX2J1c19ucihyb290
YnVzLCBidXNucik7DQo+PiDCoMKgwqDCoMKgIGlmICghYnVzKSB7DQo+DQpUaGFuayB5b3UhIEkg
d2lsbCBhZGRyZXNzIHRoaXMgaW4gdjcuDQo=

