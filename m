Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F455F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg2l-0000UW-RH; Fri, 17 Apr 2026 06:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2f-0000Tm-E5; Fri, 17 Apr 2026 06:03:18 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2d-0006gN-S5; Fri, 17 Apr 2026 06:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XA2hhc0lSCtyOqbwOngNkWZbCM7X+bCHN1oVNMIsXTgfI4kH9NC+yqRJgmXV885efVZqEl9zAPqLFykeqybad2wLiZFhBDdtbI9CFmdQGMG/8cLlikq1/l1BlPieoh29naST7CmrtQ49ejc0jw5ysufOwJbqBHIogCj9pabH1OEMSDUoGLa4gYQayekqsMutKBSdhYanfzY0WO9ZxCje/8qQp8s5ZUvplYi52EhXjXv/sOQM8JTlDaGyMpKURiWQFkjwsYtnI3HbpVygZ/ko1sBP+nkH61ZJQUj7N6hetPVKp85e9suC6VkQ6YdI+uzpmK8dMSks/fkdfc85njDpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=hhA6DCcQ7rr1rmLRZPLDf458EvCdyvh9N43Zzeo2KBz0Cl5+8XBUlu91niHOWRsGEpNODAssnQJd9oIRITjN+eQ3UWnFnK+jvA9gqXLXumRqLPCB6TUYw67ZsOfm90dWfDqH5bH8gf7cIB1qFqkAo/JiUy3hlbYr+WgLY1Syj5vIYdniQPIMznCnsZDZjG5Cefwuii6gUh63/Bn3L0PkzQKdqvNQWYNqwGJ2R9mnofVs4neCo4ZFKpePlceuF62gWmaGX596J5h3RXytPLEBiSDBlzz5j5X/NUcyRZJBVMRKHtBXVtAvAgnz82WYTpzTZyNCot3V9rf0tkr/WZdRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=uBBE5XxeTg7ErMelq/W5O6FyqP/GNkl/xHcYP0RyHkKg08bGyv3y7JpmXS1XUkNXqfP9YRxbOC4wFySV+J2IHq8SNpcjgSTtGtX6LriKxENRQpwgUVQJVsMNLVebwUMXO/MQO9LcFarhozGeprulz8EimodHJT+rApK1e9pyvbJYYydMUEA9Ko9c9UkoIaIfCFVBNWECSP+tCuQRqOxJftckym8kPg8wCDGLPeWs4XqwuzA4YdwUgGSrNNISoixSd47U73RW/W7kS6WK0yyoshUp7pJuYWe4HEDNmF0UaEBdGnItvTlzXM2HH/xCehQluXu/DoX5RblbK6o7/FzCAw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:09 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v7 1/6] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v7 1/6] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHczlFlmldkxMXfFUSHMi8S6Z7mEA==
Date: Fri, 17 Apr 2026 10:03:09 +0000
Message-ID: <20260417100302.162260-2-djordje.todorovic@htecgroup.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AM7PR09MB3736:EE_
x-ms-office365-filtering-correlation-id: fb62abff-982b-49cf-dae6-08de9c68878f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ttC5+2Lf5FOKzOx0VnFtxsUNhs6AlZcdAIngj0mxo3NgjC+FxFvT+8DuxD+U+kVsHq3Tl4LH7EhOiVnJbDQJmSTu+DDNpqhegWXObUSy3X8qNzUihEKk8aXmwnQ5pgl3nUkBYc0lk7xrXjWtfLiAM1qbAyunKYuXERBw03wp9t54Bd+m7+4NZl56Y1MaMALbjoflguIAy0xQQyXJnzzNerYHzAYqF9TsD9GCLzVGBnvNO5F70WQdiIM+zv24YeIifAeAe9Z3Su9zGI65MW+loDb3oo31yX5nB8lPNfL3I/X5jlubNzG01AFgd529zlGpAl7Hcg1CdWqP//yCTTE4L1NpOPbIO48U5D61P49/H3dKCLdsxBJgVLVQ6gxsNZmlvHC+urB08cSALu6DqF8mgdAv323IakDvTngHAimUB9UQZGZhSuRTCtOEBtss54UTJ7K3peNlvtiGWIvVVfgbCyLnOF9oopzHNU9Ey6fBpyikkSOfARZ5UykdZJr+JYgSOOWWijpFTdb0wghsuk4Op6+pSI9joANtzKhQRIcy3NXxCm8zYtRQdUQCf9LCSIuyfdpy47qK1fnApDHBJvZW65rDqYLNAEyj9pvDPjMIHmdniLhanhnLKlcuF50gQuN1iUsffKpB9lL314Wj1ZLesOObv1rsuhPmTyedOfSqiOmwCTLsubphcJOWXTxt58uOXMgdQWmrYUteHb0b29JM1wyCI+U7GJ6MfkvUQ0OkHPApk+1mhxAMqhfQ19JbTsnVGvZ+WDRbLq3BJZ4AQbwVAiOLvf4dt+S1TWZNsf5smhg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGU1aUZoYXZaT2plVTFDZ1hKaW5CalBlbENWbnZzZmhlMHZDU0NuSGREWkxj?=
 =?utf-8?B?UFRpUUtCKytuSEFqZ3JoMzlVU2ZwbHJJRFNTeEJxVEc3ZDZSYmtkTDVsQWh1?=
 =?utf-8?B?eXBlcDRucVRxU3N4MDQ4L0gzSU9JakkxZmxaWEtlMnZjUGZqSzdYcGFEa0tI?=
 =?utf-8?B?YVZaUTIzSWlWd2VQS2xhSnFTZWhCQzA2eFAyRVF0STFTM0wyN2FpM3lWZ0tz?=
 =?utf-8?B?dkhhSkpwclBmQ3hFS1l2Q3hJaFc3aUMrUGhjLzkrL3R6WnZ5djM2VGJxNlVR?=
 =?utf-8?B?WUU2MitOQ0Rscnp5eGVqaVZEZTQyK1B1RXB2WnF2cU9TUXdnWW1xcDdRSVp4?=
 =?utf-8?B?aG9RWFBtc2p2STR0d2xGMU15c3BEeDJSaDllaEpPSXhidDZzOUpOUVI2WTFH?=
 =?utf-8?B?U1hUaEd4amk2U01hc1k1R3lpaDhYTXZoVXNQYy92YzNoMWVMOHVTeU92MGVO?=
 =?utf-8?B?bTdSbSszM0FWdVJEc0c5T0VVTk1iNUp4U0lZR0NPZFBvSUhEb25yMm8vSElr?=
 =?utf-8?B?U29xSS9vWUJUU09rTjRuYWgxVEN4TE8vV2QrY2YyWEdPZnZJeXFtNTk0dEFQ?=
 =?utf-8?B?VWlzcGZnRHEwL0I1UUV6NU54SlZRNTZ0aWt2WE8weG4xclBEMlBoSE1DcTI2?=
 =?utf-8?B?QXAyWFFOZWpIRjBLdWdiTFRxK05sSGczK1QxZ0JSUVBhaEdsUEVnbE85eGtt?=
 =?utf-8?B?Qm8yTXhEOEZwK1FLNVUvclQ2U3RRQW1SZkFxNDB1TlFZcFdSaHFiSGJiRys2?=
 =?utf-8?B?VSt3VTkvZ3RTaTJvVmwwQU9ITzA5WjB5ZTYrUW5qQmN6RmhXZStKS1ZVcXpO?=
 =?utf-8?B?a0F4N3hnQ0l4RVUrcmJZZHJ2L0xRQUVydzRwdlUzR2YycWFMNU1XRC9QcTNV?=
 =?utf-8?B?UTAvRGs1dWVsL2FIMEpHaWNhZ2hTTmtXN1FGRXNxN1QyM2dJa2srdlJRUm1t?=
 =?utf-8?B?ZUF6cEZvS0RKbDE4QUJkWVIvcVpqSGdhY2RSYTBrbWlwdzdncndNb2hjZGU4?=
 =?utf-8?B?akUyTW9lajJ1M0NVN2NTbHRvUHpINHJEaVlRWHBzcittczZWZ1pjSzc4blV0?=
 =?utf-8?B?dUt0THBTMkprTWowZ1lFeElFbDFzRjZNajM3NC9XMjRwTXVoMXVhTWpkYUFh?=
 =?utf-8?B?b1VhY29QQUtLZjRmdC9seVkrdTJsSzlJSmg1TUs2dDdIa3RUK245L2JCSVIx?=
 =?utf-8?B?TURFTEdWSnVwT09kZUx5YWkyTVNmcDl6aVFWaC9aNzZsQUdqM0VwaWlNMmdr?=
 =?utf-8?B?eElSSHA5K1NmeHJxQUxscUJYMWE4Qm9qaTUyQlRrVEdUc1A1aEtPVXBDZzUw?=
 =?utf-8?B?aUNEdjl0YURoU3FLdUJTSVhPRGlPdTBZU3dxMGdLVkhpVzdJZ2szcnFlYjl1?=
 =?utf-8?B?SVBMbmVzMFNDR05nRUFMSGI4VUVUTTZ4bGdHbWY2SDdwQ1paL1pjcFB2ajF1?=
 =?utf-8?B?ZjV0QVdwUDRSRlFHWVJqTTZORWx1STNlNnFHV1lKY3JteE5TSllXVlRiSVZI?=
 =?utf-8?B?dkpZQk9yM2o1WlhkUzJLMG1tY1ZSeEgxWE4vd1lOQUFJMjFVcHlnOStrYTRW?=
 =?utf-8?B?aVpyaVdvMEJPUjVMUWlsR213V2RsUVh3RHI2Q1pxTFdOYTZwVkVNOXJkYll5?=
 =?utf-8?B?bWZPbFIwb0xKdFk3aTg2bTJzNVcvYUJJWlNjazZ5a1dPeUVvOFVhTkljTTYz?=
 =?utf-8?B?RlZYS0lIcFVRMitGQ2pLd2hmU3g0c294Y1JlQk5FRXpWRjBHZ3QrT0x6QnpL?=
 =?utf-8?B?TnN3eW9tcWdmenlYZ1JkTTVaOVcyNTNYSFZDdTdnMC8yampYd2g1R2VmWGtL?=
 =?utf-8?B?QWpESVN2S3crL0p4SkRSbDN0aEkzNGNYeUtJRlhSTEFNdVFVTmI3VVp1Rlds?=
 =?utf-8?B?b1pJbDNQR2l1cUJhbGUrYzVXUkhodE1sc3U1bGZzcTlMWEZmOUZla29weGVj?=
 =?utf-8?B?R0NYSzYyd0R1K0lscU4yVWRQNmRBQ2xGZlFwdThWcWVmcnFYcEltY1EyM1VJ?=
 =?utf-8?B?cU9Lc1M4YVZYc3E4NS8wVldWMzZwb1dQWWlBeDZVVUU0bXR3K3hZV21xWjd0?=
 =?utf-8?B?Q25IckZ0S01YeTFURXpWT3dtNU91dzFHL0VBdWFBaWRoM0pQRm96NUJOWHFJ?=
 =?utf-8?B?VWtaUHBmbnBnYURqT1ZaM3dNQkw3WWVYd3dpenBDZklGQUxkbkJUQ1pIU1ZC?=
 =?utf-8?B?YkhramhYbnNFNzF6ZVQzMUM2VmdLOXM0U0lTb1d0WjZGaGJ5SVBSZ2JxN2VC?=
 =?utf-8?B?M1N3TW9OaDVnTk1CdktVT2hnTGl2dFArRmVWUTRUTnF6Y3ZBWFRrT0UwNndE?=
 =?utf-8?B?Q1pSOERvQ3hkYktneGxuRGQ1c3IyYkh3ZnNUSjM3T0Vrdi9GSmFMNmVKeEhn?=
 =?utf-8?Q?/7PtolKYM9y1kYeH94qBhguypqHbMQlcXz/eU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43350B6259C884EAA156EFD6EC7F26F@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb62abff-982b-49cf-dae6-08de9c68878f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:09.7540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QynxzFamSlt+tqQU+pvqzmfWoUNW7wSk3tl6GoLX1GodulKTCeF7Rx7ALxSVqn+x8xpCifdA9/svLnWM3SwQXyVO8RXjJJ0lyCKS9Xzodds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3736
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

QWRkIHRoZSBSSVNDLVYgcHJpdmlsZWdlZCBJU0EgZGVmaW5lZCBiaXQgcG9zaXRpb25zIGZvciB0
aGUgU3VwZXJ2aXNvcg0KQmlnLUVuZGlhbiAoU0JFLCBiaXQgMzYpIGFuZCBNYWNoaW5lIEJpZy1F
bmRpYW4gKE1CRSwgYml0IDM3KSBmaWVsZHMNCmluIHRoZSBtc3RhdHVzIHJlZ2lzdGVyLiBUaGVz
ZSBhcmUgdXNlZCBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nDQpNU1RBVFVTX1VCRSAoYml0IDYpIHRv
IGNvbnRyb2wgZGF0YSBlbmRpYW5uZXNzIGF0IGVhY2ggcHJpdmlsZWdlIGxldmVsLg0KDQpUaGUg
TVNUQVRVU19VQkUgZGVmaW5pdGlvbiB3YXMgYWxyZWFkeSBwcmVzZW50LCBidXQgU0JFIGFuZCBN
QkUgd2VyZQ0KbWlzc2luZy4NCg0KU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZy
YW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVf
Yml0cy5oIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgN
CmluZGV4IGI2MmRkODJmZTcuLmMyYTNlZTRiZjMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaA0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC02MjgsNiArNjI4
LDggQEANCiAjZGVmaW5lIE1TVEFUVVNfVFNSICAgICAgICAgMHgwMDQwMDAwMCAvKiBzaW5jZTog
cHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1NQRUxQICAgICAgIDB4MDA4MDAwMDAgLyog
emljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19TRFQgICAgICAgICAweDAxMDAwMDAwDQorI2Rl
ZmluZSBNU1RBVFVTX1NCRSAgICAgICAgIDB4MTAwMDAwMDAwMFVMTA0KKyNkZWZpbmUgTVNUQVRV
U19NQkUgICAgICAgICAweDIwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBFTFAgICAg
ICAgMHgwMjAwMDAwMDAwMDAgLyogemljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19HVkEgICAg
ICAgICAweDQwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAw
MDAwMDAwVUxMDQotLSANCjIuMzQuMQ0K

