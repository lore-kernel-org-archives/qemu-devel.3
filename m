Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F90F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg3F-0000uV-5Q; Fri, 17 Apr 2026 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2v-0000ZO-MA; Fri, 17 Apr 2026 06:03:35 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2u-0006gN-7t; Fri, 17 Apr 2026 06:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pceza5DiQJWkGH/uaPcsyi5Y8wV/Tr42Bq1iQpO6ZejA1R6xsEnL/jI5nwLYJ1PC78E7fajCPgEGtW+dP505+m9B8vQuRhJfE3dw67wAQKL+CzO0giFHJ7B4x0uTmQgx4OidkMR/nUBuZRtA/aQvkxs/iSMSUJ7hr4Th8aXh3Z/l8QzaUn0aniuvvya37heohlMTKcryJkuMitrdKHeuHXHh3Jjg7W4dI8JJnu8wlQbwu1l8ZFRVt/jnCjaU+dKU2leK0Y0uKw8ddGuDbTs9dYATP9ipttvGvVZYE3hQMNUasYo0BjE0kUvat1nrNGK467iztpgIP8r+23jesl+W7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=jlor9PwaoXwDvUFu+1CUXMef9g1guTU/OfBiLm9tVbYYGtvaRDveZJDAoIL7ZihCv7be9xHzxTpaTKlXpgIW7CRzCdzmJt3HQhjXCgRu3SYoeQAgr8403zYTTLel9VfoX2vmJ23BE5iNraE2XROVF+j8xXQcCt2qVzadM4wFMW3CamVGyzNLBJzzcKFcput5NI93AgcxwYgIzRCKSJsGaSvtHjAUB+NNal+moe8Qct8yvwKnvCgmu8CqSJGFn2ee8VOxWFAc3rygK72s0ZLnENAH/RWXium8eJ6f+MXAY4GuQsgU+XoYZxIds6TD/vKA2TS1tN1RSuE77zahQuRdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVlOz68TH6Rn29Kd8vfhWLfqyIhG54uGQnnB6efYGDo=;
 b=UQhLG9bETkexVOFWnNNi5kOcjlN4l3ynDR57jegTogWUHRZ49P5FLUXJJUd/J/jT6bMRemeErsb0b6GihP1OlN2JBeHlPM9LTCnJS5i1oNq3Kf68bwRwE7VDwbf/txdQU19Jv0jNN0Cp/ZnZpDs2GinCWZ35GLA/dP/DMKVtwYdMZ2NyKi9ooRMvEvPbjuQ4V/czBw80Qf8wheb1Z9XzS7zklJvCd36rU/GSSijE5hvqUwvzfXUfG1KE8XyjDl28GXmUu3myHtGQttiAijJbd0w01JXM7nFNGNpTsWAOoUkQJgAdGjJWE1wouoMHOicfPCwfeMzGMPn5FOVBJNCCEg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:12 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 5/6] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v7 5/6] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHczlFm29KjLkBtMEC71rRluHeQhg==
Date: Fri, 17 Apr 2026 10:03:12 +0000
Message-ID: <20260417100302.162260-6-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: e1e73f3c-4639-4800-e9fe-08de9c68891e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: AK8wTKZcu7S8rGYmsE9MO/L2oKJo2Z4IxZc4piLhYeMPHuvQmemMQM+4h9f5tq9wxwZyQLrbgHmCkPxPHV/3du3z9DUKi1U2feQDIO0h+lOITwSoBnTJw87qEqCDovjNY3KUjn0HiPo2nBpbfGe0E/2f1veqyQ5Hd5sWCPV6/mc6/hKbR0xUD+m239mWMEsNOD8IDhTesukPrPTDPUO9mUDl0lipZW1A+1Nr3dh6quY9N4WM8itGrKRW5z9KZSE6EjEo/TUctqL5mjNvYRUOHQQBn0AFznf/w3Yw75WN0buhGqARREwS9GVgL84pKIPT2CdedHk/UjcPSw8lGAbJrVUI3ul8Sy4M9zXJz2twMBqo8XO2p3wt6nXE2CBOpsXUs84qPOiG0E98vIiSdcFRP8H+egIZ1AhIMy3O/kG3EYa34K4XgQWG0lrJ6xs1MQAhtIfNWePzJVefjYe9YiCI2HrSRRd7tyRysWPptOU4p2x1c2ZA/nresGUmEV/OwgMizonlp3A6t3R4IwCO2ZoUogG670sXEXXMFcSsr7Rwn5WWJL08xa7rg9vgg7wtdW+QCcR8zDVSAYV1yNCafo/ZXr7Oyc9R/RLqrNHXNmnvtY1NjD7yh+nYfu46/Ol2Sx3zuaeX+luYHyXdQwmFqBLnk0BQ0VFkP13l46OHhM0ZlDxfomF1+iFSMTBk/WeNAU2Mbnx5DkDtBuRXLYZFrkmFNZCVpID4LXZ+nUx7KXawg9VtIpuCHzmPot5JOdNH27CzAy3uOXn62+6m3L104D0gpLN2bx4OcoZom1ba+R2h/v4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEplcHhVQWhsVTdnUE9wRzMyZlFzUG1aTU8yVm1SVm83ZlBCaEhZTGlBaUF0?=
 =?utf-8?B?UDMrQ29KR2tleWgwZDdyb3A5NXc3dWo3ZithWHEvRmx1VU9UNldKWHVzWFow?=
 =?utf-8?B?aXRVK29UZzVXOFArc2FKRE5uTjhqTjVtcnIzUnpDUEF4Sk5WSXQ4aDZ1MWF1?=
 =?utf-8?B?MEgzRTZCMzVUU2dMWElqSUN4OGErZFhhT2ovTDJ4TEwwUVAzWStIdGtHdVQ3?=
 =?utf-8?B?TURXNGRWVDREMnJmVjRtMmxUUk94UkxrY2RTd3RDdmdGMnczRFkrQSt2b252?=
 =?utf-8?B?ckJlbnIwb0FWcGhSckNSM1NGUldGeEhkRVliQ2RhcitKTlZZRnQxUzArRmx2?=
 =?utf-8?B?d2lnVWlnT1JjbStxK3lraGxJYkU1WFp4bFc3VmZkVE9HcWYxTXQxVXhQY1hu?=
 =?utf-8?B?UTIwQ0FCN3RjcythV1FZZXcvd1VzNmFsWkZzNVNHaHlXc29GZ2prb2Jrc1BW?=
 =?utf-8?B?YXpocVpudzJib2g2aU92eUY1clB0YXFMaWY1bFRVL0ZZMWE4enZnYU8yaWE1?=
 =?utf-8?B?TXY2SndwNWo3WjY4V1E3ZThYWHVOdjVRZnJGckxZamRxUjdZdStBYUFYcmkz?=
 =?utf-8?B?VldueVBrZzNNd2ZVWUt5VFZMZGpjMTZ2OW1tbmZhWFhGUWF5S3NPMnZOVnNs?=
 =?utf-8?B?VTdhVGZraXFyb1k4cWFUTUVJUWtRcXZERmV3YWVNYWtNd01FTXRURDlqeE92?=
 =?utf-8?B?eUZKcmU4ZzZwc2hRdUphUU1hMGxxbnpFcnAybmRNQmhmdHFTT21pNmMxYzZM?=
 =?utf-8?B?MUZoTCtGL1FraXdDN3FndGtDaXVYckxPakxYaEh2WjRPNjltNVdpeDgrNmo3?=
 =?utf-8?B?V2R3cHhwNnJKeTBuY1BzTmhTODVxaFRUNjF0SDlxSmtGNjYzM3BHcW9IQmox?=
 =?utf-8?B?S09JbVVWMnA0SXU1TnEwNnRnaHAxcEdIclVkR0orSlhqeEV1WUFlNkFVcUNO?=
 =?utf-8?B?ajVRYmVpVTlRb1BYTVJISnNxQ29FUGRLVzNWTHNMMGVRZkRmZ3NUSkM3cnFD?=
 =?utf-8?B?QXJQRE1UR045RDVxczZYTmxhbm5CeXNnYlViVC9ETjRZdnY1RW1Jb3RYdllN?=
 =?utf-8?B?aENjVzF5K1B6TG5paTVWSXZBRkFDM05VK0lFMDcwM0phY2MwMFBHNE1NNDQ5?=
 =?utf-8?B?R2U2cUtvVWd6bEhGRDR0Vm0xZ2lpRng5TVV4VG9RUW5ZN3F3Sy9JNjNwUDVJ?=
 =?utf-8?B?VU5vK05kN083OE5VUWh1clcxKzdUTEtVTjRYTDdEOHNKYkRGVUdZKzVXcUZl?=
 =?utf-8?B?bExJa1RwMjJTZ0swV0tEY2JuUks3Yy9wbnFJTFV4VUFBeENNeERaNlhLMkt4?=
 =?utf-8?B?bEZqYXZ0VHlVZ245ZTlyTzV0MGlYdEt0ZG5IaTUvb21BSUpocnFrOEYrWDJI?=
 =?utf-8?B?cWs5OFcxMTZTSEVOYVFSbVBabTBCUXVaeUlxSUcvaFFXNUpCMWwzMXhxaDNM?=
 =?utf-8?B?WFZaditRMk13WVBSQzZ2SUZXUnNwWk1uVjN3YlFhaHhJTktPYjRJL2RRUzdu?=
 =?utf-8?B?RWNsQmx4ejdKV2FCL0FSUkEvSDNjRVNvYURLbHZrWndLOTRyZ0pJbERNUDNk?=
 =?utf-8?B?b3dZZ0F6MGVRM0JrZnRJVnE4RVk3K0hqSjZHM1JaMzgxSXpucHNXWHE1M3l0?=
 =?utf-8?B?RUNDbEl3OGxZNi96NzF1WjRIRThYc2xTK09UckN0YWtjT0xkNGJNSENGdUxT?=
 =?utf-8?B?UXRwN1pLVmFGOEFLN1JkbFF0SDBvS253UVM0MVVVbXdNc2o0cVI0a2RHYVVI?=
 =?utf-8?B?d1czZzYrMVZTaFp2ZkdCR3N5UGpidktpODBGOWk4aFdORnViZUJ4cGt6QmMy?=
 =?utf-8?B?ZDEyZ2hjUlNjbDhvWmpBSnBSQlhsOGlWYnFVZWpzeGpnZW5ZZU01QnJiK0pN?=
 =?utf-8?B?dFJhSWNrTGV5TWpEMkpoTHQvckJFcVRyY3d4cGRZU1NLYmwzeHUwTGhBaERG?=
 =?utf-8?B?Mm1IS1ZFd2Q5cDRaMDVML3A2R1o0dUZHQ0ZpUGhSL29tZThVdjJlelUzbUlm?=
 =?utf-8?B?eWwxbnNwMzNMOVBJSGlycW84TC9oWGp3ZzZTM25yRW5OeG8yM2UrM1dUWk5z?=
 =?utf-8?B?bjJXQkxXYXdTVnhEWFJCdmVUak1qVmVOSDcxMWdiQzlOMUdQUFlibTZ2SmRi?=
 =?utf-8?B?MEphUUp0SFpoUEYxRzJuRngvbDA3Z2xHLzRkOUdZNnVIQ1lROC8xNTcwNDlK?=
 =?utf-8?B?VFFmZDlVVDVCcWI3Y3VuUnJyWTFSYkgxSkZ1VlhLdU9DTTZZZkNveStGak1B?=
 =?utf-8?B?MnhqTFU5VXlMZk5hdmc0SVlpK0orTFY3YkZHUTZDT3lkNG9vMlhuck9xNzdY?=
 =?utf-8?B?UXZwUkFvZU5telI5RlJzZ0FjbitUTEFUa0ZVVHlPRXhLdnVDMzg0aGtXRzZH?=
 =?utf-8?Q?e3YLTlTZ6mziF1kNhKmL6t0uj7gsrtfbwVz79?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B29EDD0532054DBFAE269AA540B1B4@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e73f3c-4639-4800-e9fe-08de9c68891e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:12.4169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: admQbpv6/q+phs/gX5yWFCdx5js7YFQ4TXchmwO1JG9q8h5ci044VM/Hd+9x9BEGtAHmxw2NaYIURTxwi4l0F13A4IxfqLutPZNlRh8O4mg=
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IGMy
ODgzMmUwZTMuLmIzZDMzZGExM2UgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTM2NSw5ICsxMzY1LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTU2NiwxMiArMTU3MCwyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

