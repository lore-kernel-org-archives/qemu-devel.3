Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C872FC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbZq-0004vp-6e; Tue, 15 Jul 2025 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ubbZm-0004r3-R8; Tue, 15 Jul 2025 05:03:51 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ubbZg-0005M6-IZ; Tue, 15 Jul 2025 05:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH7o1oVp5I/ToNC31y0DV0888RNgT1r3xi7Hv3Se+LDLyMRIXbQ72y+Rur48+6ctgNzz+CYXz2lG3HqBPfLNahk9cPxaOG2uxPAlyiz8VKQYA11ZeWQhkoPGvWdPz40/YvSjkmob2I4GVnkZbDmkE6rPr5cncKM+iT1OlwLdt1YMIyn2JFekYz3CTBp0RpS0PWv3mMY87fb7xnMb61JkVauxI+J0Zfm7ZO0DHVVNagpMo8aAfVAbLI6JElVAyt2l71jgzrLEjcqEP7dgNTBPPZ5SoJag4BoMByhPBqnaIp9fZD5j/7ZR8orMkQ9p5VCDliI8dOmVGlxBYM96FtUg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d2e9a8gUfGriPZh+GAOzkIsxsEAV5rtbKhYl232mBI=;
 b=NYiNJIQoKejIPuxnI5dK/HR4pzCzM8Y2KJX7AS4V656xW0QUT+55l1eDtq/15tqlkEeSLu9Y4sI+PJ+HdMgKt3mqUyLWGiCqB+OkaUwYs0PNHBhRdA9D43KOwSyH79ONS++Fv/9vKYTCxzKICHsi/cYVx9ov3N+JGHZzGCVq1pIVgJGKA8+K/eSn8hOaq65zEylBalSMfL4bWa6FibhmXRYbCM4sdyMtbkhvW+73YHpr9wRpJvUIRVX5SR4ACuljWbm9TXcTLZgKOmyvEWx5SrzbX+PAg84awNTZESCtWDSIERJ+4TqTogkeyQNiAzH0ndUWNPwDoLeTIoUbx06u9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d2e9a8gUfGriPZh+GAOzkIsxsEAV5rtbKhYl232mBI=;
 b=djdIj7kxttAN7Q1kR1xUzPwgVZkkPARJMVXxQc3qUvQtv6L1QaCWFW75Jhqeg8WZhHO1bVyvBtU99i6u4Ftt5/lsH1NfbfowxON73uyHI9MGMnjcUmbV+F8f3gRcqgmFIghr7RofHwacEiXZ7r4Tdx+LnFELSv/pgQG98rKvy9hiZLXqeCdb7L5Gle+mTCk/P0crKTvXVd6UCiaD9QdCxzGm1sf+VOckfDOP+btb3+nGYwHFFNI9gGUWKtzk/TjjgWKQk2YX7qQG+KeAxm1eBiukzmABFXEE0liv8V2/XfQVVy0nzhaf5+EoOnfBfm4v5V38XOE8ndSNdNEZ880KZw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4280.eurprd09.prod.outlook.com (2603:10a6:10:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:03:35 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Tue, 15 Jul 2025
 09:03:35 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v5 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v5 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb7AgpOz4by9o/RUanTsqAM0rtNbQy9p8A
Date: Tue, 15 Jul 2025 09:03:34 +0000
Message-ID: <0ad9a41c-f612-48c7-b895-de1e4214ade8@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
 <20250703104925.112688-11-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-11-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4280:EE_
x-ms-office365-filtering-correlation-id: 2429f0c3-ee02-44d9-0bde-08ddc37e7ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3RCVDIweGU2NWRaZUJHbS9uK21tdUM4UXBaWUp3QzVUKzE0YnZYMStKakR6?=
 =?utf-8?B?dFFYNGE5YmFLeVdqNjNjRU5waVVRUzlQMHFQTVlvK1kwdFlhZWE3Y2s3YkN0?=
 =?utf-8?B?TjB6YTFmVmVhK3NoQU5UVGtHZlFvQ1c2RXFCdjBoZnR1OElRRmhqdHQycEZ5?=
 =?utf-8?B?TldXUjhrMCsvSUhMSnh3Q0lrcEF6ajhaRmlqRFJuMFMxM1pneXRteE0zbnlw?=
 =?utf-8?B?dnNBSFRWVXlPcnYzUHNEMStvWlpPSi9uME9yUU11aTRtVjVoNUFBMGF0dHY2?=
 =?utf-8?B?TXVaSXpRTFRzN2VKbUJpOXpFelE1UzAvUGhGWjRCbW16Qjh5RVQ5dm5Jaksv?=
 =?utf-8?B?dVYrWVZzWkthdElieWF4K2RYU25ROU1mekJvdldueTRBZHYrRlI4UWxGSVdT?=
 =?utf-8?B?MWUyM0QwSWo4SmtaSjJiZ2hMdG9NNWxjTytsaWRsUHpydzZhRW1Wd0FNTHpX?=
 =?utf-8?B?Zkgwa2JEMWxGcHNxb1A2aXN3TlYrWW02cXUveExkaEZ2OG1PTk02NGVQcDlZ?=
 =?utf-8?B?SFh6SmlrOVhLa1lvZ01RNUVUNCsvVkpieUVZMXhjYTBtZ1lNelNlckdsVzF0?=
 =?utf-8?B?UGV2QmNERWo3TlhZUldiK0dONndhMEZ0VVNBVGhIb1IyUVpFNjhJWEFQNDUy?=
 =?utf-8?B?dWVZK2Jza0VDQmFFREl4MkZTYnpRLzNzaitJbnh2WkZldUVrNnpVcnQ0MTNz?=
 =?utf-8?B?dEk2d0E3aDlIQ2NsSXNLYjFkZDVaY1p1eEFoMG5jQU5ZZER0MDhRNk9XaFh0?=
 =?utf-8?B?L2NrTm1zMDhpU3BuODdCbDlRZHlFRzAxOHZkZ0JqeG1nNVYwYXM5Z0pVOG9E?=
 =?utf-8?B?NFRMcG15eTI0aEwxZ1A1Qit5b3lVZnV4SjM4NFkwdURZU21uWlAxd0xBVXZT?=
 =?utf-8?B?UVRjRU9tcU0vRmxKSGZuU0QwYnRJUGFGUnBaTFNEanNIVlo3c3NVaDEwV1c3?=
 =?utf-8?B?NmZxM1pYS3lZWWg4eEFWM0gwdUMrcmVQQzZJL2loNTgzVWpkM1VsODlRZjg0?=
 =?utf-8?B?a0tZNVIydXRDOUYwRTB3ajcyUGQvWUNOYW11WXRHcWJZRDAyZ1NwZEgrNUVL?=
 =?utf-8?B?d0pIRG56SFgzdlMvS3RJbFVxVHJabHY0eHI3TU1BdTB2aCtrQ1cwVFAyWURN?=
 =?utf-8?B?Zk1NZCtSbjc2YjJVbzMrUzEwSlZhdDRUVVZMQ1B6Z3BaeXAvcjNJUGIwNlVF?=
 =?utf-8?B?VjJSYXhlRjFlL3YrdnlEbmdjSmFUREh2N3c1TmlnNDRIZUlmZWdwR1RTTUwz?=
 =?utf-8?B?OCtldnN4WW1YYW1iVjFRSzNBZTI3ckprdVBOYno3VmM0RWVINXVuSFJCVEJP?=
 =?utf-8?B?OWlOcGdEdk9ZcU9QKzlTajZnM05BUXFRTWJ3eTdNa2dLQWNoTXBxNlQrd2k1?=
 =?utf-8?B?NkszdkNjTlM1NmJrdVJ0VnJyQm5qQjhZUWJib3AwUkd2Zm5weGJPL2Q0Tmd6?=
 =?utf-8?B?QUdsdHlDMWsrcG4zc2pPUzE3QTFrNWdQa0lJTHdXcDhLMEJ0d3lmcFlIYjRJ?=
 =?utf-8?B?d1p5V3NsU1Y2NFBaK3VQaThWaHltZXRQRE9XMDlCenVNVXpDYTBmQk1aRVA2?=
 =?utf-8?B?OVVMdFRuTndOak9yMlV2cnQwYXMwdVhoS1orVUNDcUQvdUJHQXplSHZuakcz?=
 =?utf-8?B?M0k4WkFHdXpiWTVqLzU1KzZVZDE2Y0ZaR0lzalljbWcwa05Ib0hVV0M4NElm?=
 =?utf-8?B?aGs0UmxlVWFRM2lKUG95N0s3V09oeGFwcHh2Ymsyb1BHcGhXNFVyQ1Y0V3Fx?=
 =?utf-8?B?Nk1Obk8rcUZsTURwblhGMExZVy83ejJoM0g1Vi9BTllqb1ZmOVY5MlFYYkU0?=
 =?utf-8?B?R1NXQ3pNeUx3cTdDZUVRZXM5Q3I5VzcvM2xRQkFJWmdqNGx6dVc5MjQ3VDNt?=
 =?utf-8?B?YmJoR2ZURUY2MWF0T0hZRmxjN0tJUkVhOXBWa3M3RHM3aU8zcTRQS2RjOUMv?=
 =?utf-8?B?WGNKSE1ITHhqZm9xUTNyaFV6MmNXdys1VmJXaFptL1N1YUlaMXIyajlwbW5K?=
 =?utf-8?B?WUhGQjArYVFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlpMDFaQkR0RDhqZTlwSEo3cGZGelRQb2RSaXJZMS9VWGI3Q0QzYWNUZ2xN?=
 =?utf-8?B?QmtQdDF2bGhuaTBGSmZpNE9BYlFGMXBaVjV0ME9JM3NhUmRXdU1BbmJWaUlO?=
 =?utf-8?B?TUxlT1ZqUzRsOFBLaUY0VEhpRFZPeXVVS2VGZnZlQUx0QkJyMkZvNG41R2Jw?=
 =?utf-8?B?cTAxZk5BeExwNlNNSnFRK3NSTjczY01tQTVLakFrZjJlNFBkT041MnF5RVFS?=
 =?utf-8?B?dEtON0grVmQzMHRHbWg1bFJ0eUpSeFV0RW0raHhPZ0EyS3BwQXlVZHRDdjNR?=
 =?utf-8?B?Tnc2aWEwQ0NuTE9wZnpYaWI2cVhmckl4Q2xYMUtDSlM1aGM3cU42Nk1vbmJa?=
 =?utf-8?B?a2xjbXhxTnRCbjhzc3orTzFtV1RacTk5K2U5aTlERm12dXM0ZXl3SzVTc1lS?=
 =?utf-8?B?dUtvbC9ORnRIbnoyd3hKT2h2TFgybVRML24zaTlUdHlPQkVaUzZQUmZjenRl?=
 =?utf-8?B?MDRlRUFjdy85dnJzVmxYZzhGU1VKOVNiak0vQlFpZHB4NGhWRVY0R0xLRzFL?=
 =?utf-8?B?MUx6TmlZSEx4V05wSUFZVGVTNmVzWlVZV0tIVjZqTzhhYnlSUTlKTUFjZkNm?=
 =?utf-8?B?RURRTWZhY3lUb2dJTkxxYmQzR24ya3p6cnFWcWpiNHh4MW5ydWRyaVB2d3Bm?=
 =?utf-8?B?RGs4U1BCTUtzbkJkY1VBWXVQYVRsOXVRbzZybDV1Vjl2YTVNY3NJSHRlSTFM?=
 =?utf-8?B?Vy9CZnpyOEpsY3JjRk1xUm9HS2d5MXZOa1YxMHgwcjYvMk5vTXVqOGpDSnNT?=
 =?utf-8?B?UDRtRndVM1o1NG5yOFh2dks3K0lRTytHZWExQ3NYUGh6N1lULzNwYWphWXpT?=
 =?utf-8?B?MTRWak1TdFIxcUVrZ3Z0MEhmSWRJSENRaG13L1lVQ2FpQ2F2MEVZVlMwbEV2?=
 =?utf-8?B?OXZ4bVVrWDlVUjc3dlJ5YkE3U2lKVU9hTlhoWEhYVGYxcENPSVhSN0JMTENP?=
 =?utf-8?B?Y25xOWJxSkEzODRQRE5LU0dpemlBWXFuMzJQMlhNSE5MVEFPOGVablFKTU5X?=
 =?utf-8?B?S2ZIOXFadzdLa2NFZnFwdHZ3eTArb255RUpqR1VKNi9tVUdtS3hZQTFNV2FG?=
 =?utf-8?B?cTY3Ykw1bStvS1RSREswUFlJUHdLTFZvd2h2Yzc3cWtFSy9VeXdSdmlKZFZM?=
 =?utf-8?B?RFdxUDgrM1lOejZKOTJtRWRKWVJsYzY5dmhHeGdqOHo3NGJKeTc2UHd5YWdt?=
 =?utf-8?B?LzM5OFBabDBodXJFdzZzSGNpOWJaOVBqdmV1TXd5QnE4cHA4aFcrMitkTzY2?=
 =?utf-8?B?K1dIY29qUjRNU2lrNVNZS0tDN3hEZklTZVgrbkFBajZvdGdQZHN6c1JCSUp5?=
 =?utf-8?B?VHp4bkdsdENwUmlKSlJTVWdlVWl1anNLS1RhSElwY25FL3ZiRGFOTmI4QkFW?=
 =?utf-8?B?dHAwbXFKZXZsSkhYdXE3TmhmTXZLb2R4ZGpWdlVRUGpvTGVvaExQZUV6a3dl?=
 =?utf-8?B?ODdNd1lnNDJ5V0hCU2xmU05ENXZnSFBIaFJYQ3BNZzZ1c3NHUldySXFMeWRN?=
 =?utf-8?B?aDBOalUwTEhYdWg4eFVDMzVNRHBaYTg5eGFBWVBPNEFyRUNXN2NQaU91aVc4?=
 =?utf-8?B?akE5d2FhQVFrTS95Y05sTUlIeTVmMVpWZ3NQQnNOa1FhazhjVlpodW5KTWZm?=
 =?utf-8?B?YXpnWjdrTW9kSjU2Tk9CUXYzUGFYYTNmN3YvMDRrSWVKVVlMb3FmRjZ4eWEv?=
 =?utf-8?B?VmdlQjNVR0FVTnZMV1dvNjJ0dUZPNEE4ZDdDWFlMN3NyeUw0U0NTcUc5VTln?=
 =?utf-8?B?bXhzbmtUdHJpdW9zMDNNRXJ3RWI0TU1YQi84YXB0S1VzV2VuMzM3czd2SVRL?=
 =?utf-8?B?OUFTK2t0QnRiVCtrT2pFeGRhcGZrMEFBUFJzTWZqcksxV1N1TC9HUjZDOG5x?=
 =?utf-8?B?cUlkS2xaMEFOdWIzSWsrQmRIK3hlS0ZKWFU5QUNzZmlNR1B3Ti8zZmxQSlJE?=
 =?utf-8?B?Ry9pYyswYnpCNmF6d0FFR0h1am8wSVV4dzlnVW1NUVRVWDZTZVI5eG1XcWRY?=
 =?utf-8?B?dWtYY2hnZ2FwV3c3RjRZOUhuUFRURzRicDFZOUlxcXRpYnMyWDNXdWVHaDFO?=
 =?utf-8?B?elhmSUtYSVFqWmRZZWtXOFRORkJKLy9qRzkvU2RRWUYrRjdidW5VNzd2dmsw?=
 =?utf-8?B?L0ErK2tuQ29iZk05dlVsUFMxWWtjNmFSZVNIbDBkTWF5d05JUXZKNlN6d015?=
 =?utf-8?Q?oiXEkHV/tM3rHPMBg6UYbeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5AC6CA3F59F344AA79F4F1DC40F0FB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2429f0c3-ee02-44d9-0bde-08ddc37e7ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 09:03:35.0214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsS9NKuTehC8EuaZndpcUkCzjZcTXgYXce5CbrWB6HWO/ZNjTC089Wze9UZ8jsnqGUAY0fpVhkywaVOM3SPfEafCxmrmx685h9yOo2EQnvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4280
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

SGksDQoNCkkgYW0gd29uZGVyaW5nIGlmIHRoZXJlIGlzIGFueSBjb21tZW50IG9uIHRoaXMuDQoN
CkJlc3QgcmVnYXJkcywNCkRqb3JkamUNCg0KT24gMy4gNy4gMjUuIDEyOjQ5LCBEam9yZGplIFRv
ZG9yb3ZpYyB3cm90ZToNCj4gU2luY2UgdGhlcmUgaXMgbm8gcGNoX2diZSBlbXVsYXRpb24sIHdl
IGNvdWxkIGJlIHVzaW5nIGZ1bmMgb3RoZXINCj4gdGhhbiAwIHdoZW4gYWRkaW5nIG5ldyBkZXZp
Y2VzIHRvIHNwZWNpZmljIGJvYXJkcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1
IDxjZnVAbWlwcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERqb3JkamUgVG9kb3JvdmljIDxkam9y
ZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KPiAtLS0NCj4gICBody9wY2kvcGNpLmMgfCAx
NSArKysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIvaHcvcGNpL3Bj
aS5jDQo+IGluZGV4IGY1YWI1MTA2OTcuLjIzZjdmMDI4MzcgMTAwNjQ0DQo+IC0tLSBhL2h3L3Bj
aS9wY2kuYw0KPiArKysgYi9ody9wY2kvcGNpLmMNCj4gQEAgLTk3NCwxNCArOTc0LDE1IEBAIHN0
YXRpYyBpbnQgcGNpX3BhcnNlX2RldmFkZHIoY29uc3QgY2hhciAqYWRkciwgaW50ICpkb21wLCBp
bnQgKmJ1c3AsDQo+ICAgDQo+ICAgICAgIHNsb3QgPSB2YWw7DQo+ICAgDQo+IC0gICAgaWYgKGZ1
bmNwICE9IE5VTEwpIHsNCj4gLSAgICAgICAgaWYgKCplICE9ICcuJykNCj4gKyAgICBpZiAoZnVu
Y3AgIT0gTlVMTCAmJiAqZSAhPSAwKSB7DQo+ICsgICAgICAgIGlmICgqZSAhPSAnLicpIHsNCj4g
ICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+IC0NCj4gKyAgICAgICAgfQ0KPiAgICAgICAgICAg
cCA9IGUgKyAxOw0KPiAgICAgICAgICAgdmFsID0gc3RydG91bChwLCAmZSwgMTYpOw0KPiAtICAg
ICAgICBpZiAoZSA9PSBwKQ0KPiArICAgICAgICBpZiAoZSA9PSBwKSB7DQo+ICAgICAgICAgICAg
ICAgcmV0dXJuIC0xOw0KPiArICAgICAgICB9DQo+ICAgDQo+ICAgICAgICAgICBmdW5jID0gdmFs
Ow0KPiAgICAgICB9DQo+IEBAIC0yMDQ1LDEzICsyMDQ2LDE1IEBAIGJvb2wgcGNpX2luaXRfbmlj
X2luX3Nsb3QoUENJQnVzICpyb290YnVzLCBjb25zdCBjaGFyICptb2RlbCwNCj4gICAgICAgaW50
IGRvbSwgYnVzbnIsIGRldmZuOw0KPiAgICAgICBQQ0lEZXZpY2UgKnBjaV9kZXY7DQo+ICAgICAg
IHVuc2lnbmVkIHNsb3Q7DQo+ICsNCj4gICAgICAgUENJQnVzICpidXM7DQo+ICAgDQo+ICAgICAg
IGlmICghbmQpIHsNCj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPiAgIA0K
PiAtICAgIGlmICghZGV2YWRkciB8fCBwY2lfcGFyc2VfZGV2YWRkcihkZXZhZGRyLCAmZG9tLCAm
YnVzbnIsICZzbG90LCBOVUxMKSA8IDApIHsNCj4gKyAgICB1bnNpZ25lZCBmdW5jOw0KPiArICAg
IGlmICghZGV2YWRkciB8fCBwY2lfcGFyc2VfZGV2YWRkcihkZXZhZGRyLCAmZG9tLCAmYnVzbnIs
ICZzbG90LCAmZnVuYykgPCAwKSB7DQo+ICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkludmFsaWQg
UENJIGRldmljZSBhZGRyZXNzICVzIGZvciBkZXZpY2UgJXMiLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgIGRldmFkZHIsIG1vZGVsKTsNCj4gICAgICAgICAgIGV4aXQoMSk7DQo+IEBAIC0yMDYy
LDcgKzIwNjUsNyBAQCBib29sIHBjaV9pbml0X25pY19pbl9zbG90KFBDSUJ1cyAqcm9vdGJ1cywg
Y29uc3QgY2hhciAqbW9kZWwsDQo+ICAgICAgICAgICBleGl0KDEpOw0KPiAgICAgICB9DQo+ICAg
DQo+IC0gICAgZGV2Zm4gPSBQQ0lfREVWRk4oc2xvdCwgMCk7DQo+ICsgICAgZGV2Zm4gPSBQQ0lf
REVWRk4oc2xvdCwgZnVuYyk7DQo+ICAgDQo+ICAgICAgIGJ1cyA9IHBjaV9maW5kX2J1c19ucihy
b290YnVzLCBidXNucik7DQo+ICAgICAgIGlmICghYnVzKSB7

