Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53735CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyVq-0006hO-Dz; Wed, 14 Oct 2026 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvain.combis@atempo.com>)
 id 1xGuzQ-0006lp-US
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:09:37 -0400
Received: from mail-swedencentralazon11023117.outbound.protection.outlook.com
 ([52.101.83.117] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvain.combis@atempo.com>)
 id 1xGuzP-0006TG-7a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:09:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHhpnsCOg72718XB98JyhAxOFa1M2TofsPsq3hJvtWsNqFvlzMidhphzXPnMUF0CEukaw66rgebmCaaQanAFO0ZxELxFpIbERJWOJqcNnjmcmmh+CUfnyHdKgSPLbvs6/3N3CLQJneeRiLnkCmQ6BX+rNzXJ2vLpuQ8K6CheGfbsHTh7Mo6oFsRu6b9nj1mi0J8S/vYCbgdN8up2rjWRe9L5kDzCmzPE5ykAiH5xrADG6eI603O6tWMcjDVbhzmvQXIZWYersl4i8bXPcAaeplSZ5QA2e83NE9HWWVEHjBcHf+1OXTBFhTWeifKlPN9L3h8iM7YhdIhvkXc814M+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JatgZ9zdgd4P/x1+obBq2t1QDltwWQJ7VSVZEkbc63M=;
 b=yq0RIYdXFtTJ4wtqAKwBDcm1Uhtn/t4eMN92oFs5K7Z3fJ43A6B60Ff4uFueUVONkRf6taV7CPOPb6RI4QeW6fAcTFSSLdEfZBpi6D6eTzh3hUMA+3DWJpGiXclS0zeyupHdTrG3ASghMgWNj8GMxXYFRQRl3gPKwSw33XdSTYJQYsoIc3b/xWeEXFVej9R1wyMCf+K8t1rUjq+mi9DUpTbT/ZCGLpyt5WUSRqzqDveFVjLE+gda/lncx5RjfrwCDJedIQUGEpDaeKCkp2p1kgepk8jwprw8tDmGsDEAuckehPmp3esO/RbheoOZezaxFsf0kUDUfi80xuSXMzxXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atempo.com; dmarc=pass action=none header.from=atempo.com;
 dkim=pass header.d=atempo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atempo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JatgZ9zdgd4P/x1+obBq2t1QDltwWQJ7VSVZEkbc63M=;
 b=esRA25jlpGTRxdwsSE17ZXjyNX8LfuKSPMUA5CCe85SSfJ8qQNeNCZbpOP/GwjcOHKdYEG2L4tBwpNkCqNrHql3ql8fVi1pp6x2exMlTV98F+8pIjSCbt0uNAusTgVVBjh3Sqnwspoe19D64UKnVeG2VAhMK5ulfpXRhNROzeHc=
Received: from PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:364::12)
 by PA4PR10MB5657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:262::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 09:04:28 +0000
Received: from PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b7b:a04f:353d:fb5c]) by PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b7b:a04f:353d:fb5c%4]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 09:04:28 +0000
From: Silvain Combis <silvain.combis@atempo.com>
To: Elizabeth Ashurov <eashurov@redhat.com>
CC: Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/2] qga: Fix VSS provider GetSnapshotProperties return
 value
Thread-Topic: [PATCH v2 2/2] qga: Fix VSS provider GetSnapshotProperties
 return value
Thread-Index: AQHdW7sEqIYOWOYZcEiGwAu3vVZaqA==
Date: Wed, 14 Oct 2026 09:04:28 +0000
Message-ID: <03F64005-1106-4C2F-899F-A15684944F7C@atempo.com>
References: <20260211101744.757548-1-eashurov@redhat.com>
 <20260211101744.757548-2-eashurov@redhat.com>
In-Reply-To: <20260211101744.757548-2-eashurov@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3901.100.1.1.12)
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atempo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB7847:EE_|PA4PR10MB5657:EE_
x-ms-office365-filtering-correlation-id: 0426da3d-8194-48b4-e84a-08df29d22731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|22082099003|18002099003|3023799007|10067099003|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: ORuBOBqZKfr/j/XtU0DxAJ+kQG/HQBW1Mk2+aCrtcr6/b3OqJCVIkn2uGKmt1ayc+DRH83vDgfMqttY3txqHoaymro9MyPHkQv4axlpf80fM1BFfPkAKWye/gW4POPEUbrxo4p4rY2HVCOC95hmycHJxWIciT+F/jO9Q88TAtvsQ96w2I/tyNIBAlXMHvhhNxV/eOqDQM9pDlI78ERKqzRRDA9EQZVaIpY8OiYckSJ1RSgSVXv/SjXIOK3XAfPuCbedUKuuRqgbxT8VuT4aaqRKrzb5EUvybhbcXgkqZXRyTV8CdETf08uzBw6iiLebOuznSkIUhpdK/xgfjSLNa+6TJaNbJtzzvwOKv7nr4C6K0Bm+cPMCGDo4aML0lQUyfR7Hhjmq8GzSt0zkA3tIsPgQZNm/g1X0Arbug24skR+WJvaXREJ2iDYenTjo5emmKZdq4JpVTYfnpZ6TkyzBhS8oMwLolTVc6lcMcgnCPEPQpwSHL6G3PZ2ZCI5vwRhpMKUb3ClD8Piufl7X9LxretfNNciAtH4uAtKagnEHNhnzCWNGa6bnVmx1KswdKhKu7rKGtrA/SaWXE07HpwSkEEJszkO3/zUWB5oOIv6r6nrVndb+2/JrAM2/SWyLX1SOIuCwX1OyCKFrPPR1EgDcbSqQjjdQl02RmdFv+W4cAAdI5t+v8hEfA7X4qEKyA0+cS3CwK3b3AC2DlI+sgZ9tNhWYKdRvj0ydoHMnrJ5A4MiM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVdPMUcxWGNFSGRHY2g3R2ZDTlo3M0pFUWs1Z21vSlBwR20vV056STFLa2ov?=
 =?utf-8?B?QmY4b0xGRFd6aDk1cjVZOTM4MG5haElvamdDNVBUQzZBUGdvaHpncmU5bEE3?=
 =?utf-8?B?V2cwbWEzMHo2YnNUMERwZUo5REFzRmdweGsrcTFnUCs4aFlibnBsSU9pelZY?=
 =?utf-8?B?b3daYkdKUWNQTWlidXVVK2dFRVIxbk9lbk5pSGNyTkZOaXhkZS9BR3J3QVF2?=
 =?utf-8?B?R3NuQWROWHo4L1VmRm5NRVVsQXFzSVUxMmZFaHJGeTIyMHlzWjNQZmZmejY1?=
 =?utf-8?B?N0NJQ2ZqUEh2M2EwQlJZdGtpT1JCYVIvOEJaWmQ2Z3pYRFlZK0ZGQnpnaHRX?=
 =?utf-8?B?TGN3ZkF4T3ZQNTFEM05EdTRjdFlrUDhQeHJOUTNvZTU3S3NjUzBOUGhQY0F2?=
 =?utf-8?B?eklYeTcxaVltSVNpZnBOTFZMNCtPTy9aVEQ4cU9hTk5qQkVEbGxJVVFqNCtH?=
 =?utf-8?B?TUFzckRlUlBtb212MmNwREhOUW50WWVIanlRM1Q1S2ZZbW9MbUhzeWVPWms1?=
 =?utf-8?B?SzNjL1hCbXE3S2VybDVUNy9MOE8vN3ZxbDFlSmUvZkprMCttWFhTNGMyaitj?=
 =?utf-8?B?S1BHaXlPM05hZ1Z1ek9MRmp3RWRPdDNhOCtyMmNhOE9haDYyUkZBc05ybGV0?=
 =?utf-8?B?TnFnN05Ha0I0cktMNzc0bFI4ek53ZnpSb20wcm54Q1JnSmRvdi9oKzFOMENl?=
 =?utf-8?B?Y0YrR08vMG14T2FCM0lGYXl4bjdFNXlDZUtFUlVzbnpJOFJ4R3c0b1JBcm1T?=
 =?utf-8?B?ZnZLNHdIeDJsYmxPM1ZZbkxGZitQOHJtU2RjV2JEUE8yTENKaWh3YlFvVHBG?=
 =?utf-8?B?ZnBWbXkzbHJ4SnNldzA3NVRDNFdRNHc5SFl1VWdoS3pXdHptRnd0RzFmZjI3?=
 =?utf-8?B?dUM1WkVpMDNNMG9kY0NvS1dqVFRlNHJBR1NLWExWM0FkU3R6YWF3MDdKb2c3?=
 =?utf-8?B?Y0pPN3ZlbHh5bW9jN2ZkRHRab3BXWnR2Z2pwWHpxa0M2SndhWmdRaU9NalF2?=
 =?utf-8?B?eWV6czBqc3o3N0pJYWQ3elFWalRLZWw5NzhPOWcxUmh1YVRiTDJtbW5GQnht?=
 =?utf-8?B?eXVLVWZOcllDZjlHdUZWNEMzS1c1RjBubGtiN2ZiblBtWUo0NzgxaU1GOHV1?=
 =?utf-8?B?dWh1K0JJS2IwSWdPaGJEbDZPQjYwTWh6SldjY0drZmpqcUdyTERvWlJnbEd5?=
 =?utf-8?B?dmZvaHBjaDd1L003TVM3NUdFMUZlMWdnRE5CWkJZOVFCRjkxMkFRNnExM3lR?=
 =?utf-8?B?YVdPR0VqYk1rWnlEWExhWHV5cm1uY2pwT2FWVGRDYy8vUlA4eGY5RTZZcGJa?=
 =?utf-8?B?RDY0TWFNcjdxQlFvNXRuazJ1OVAwcXp6dUkzY2JiMUlmY044ZDh1b0JDVTV6?=
 =?utf-8?B?TFdZQW04NHhhcU91RVUvZzhzN2Y2WVNJSjkydHN0b2hGMWhBbUtQUzEwRTht?=
 =?utf-8?B?OS9kN0hzWnpwdU91VFhGb1ArbVovdkFoYjFRWXVrRytieDk4ZEZQYmlsR290?=
 =?utf-8?B?YjV6Rkt1c3RFK1RSK1pNRnIzblk2bGxhRlk2VUt2RkZIb1p2eis2cjNKTU5l?=
 =?utf-8?B?a3dSUUhXWWE0aGdJUk9Ra2dUWGlmZ3IydkpkY1dwSm9uM2RremE0UWFIaTN5?=
 =?utf-8?B?WEdwblY4TkRORUU5V3puY0ZRUDVOSUo2YVNSZ3lFbEhsdDlOamVhY3ExRUdU?=
 =?utf-8?B?WWszMWpmVC8vYkZKOVBpaml6TW5HZG00ck9MVmN6TGlSR3l6R2p4RElmWi90?=
 =?utf-8?B?YWFWTjRyTSsrY0pNa0lNdzNGZDZKU3hsYzlZV2V0ajQyWm16VUhYSmJQSDBW?=
 =?utf-8?B?YTA2MWZib2FqQTY2TWFQbFZhT2NWSUY1V05GVE5nUW9palJpV1Rtam1ib1ow?=
 =?utf-8?B?MG1veGZheFRpRVFiSDR1Slh0RTdQUlRkSHRQWk9kd1UvZjljNHVIaFlqQWNl?=
 =?utf-8?B?dHJXMndTNUVzMjRNcW5nZFF3TW11MnM4bzM3b2RUQTJiVm12Tkp0K2hxcGVX?=
 =?utf-8?B?djlyZ01xYWFQazVMYmcxRGpNZ3dVWjVma003VkxibHR4OEh0TVRqNkVxR1Y2?=
 =?utf-8?B?MVVQc244cGhXa3RVdjNCS1g2R25mVzRrZmxBa2lSUW1NbEtqOWNxRjQ4OS8v?=
 =?utf-8?B?dDdaU3pmVUtGY1N4RE9ZcC9XZFlLT1pEVDVHdUdOb1FZbkVRZFUwYzJNbEpo?=
 =?utf-8?B?dUpvT3N6YjhyN3ZTbnhaWE5oajNJUytBa1h6R0dKVWJjb2lMSk9tYmV4RGJn?=
 =?utf-8?B?dFJOK0U0ZXFTa0N1eUlUNm44WDlac1JHMFZvRXYxcFpJWjFjNVh5dWljemlI?=
 =?utf-8?B?MURPeVYrWlRBNE5Kb3FxTFZ0RkhuVjJhWmc4OXROaTZLdFU0VldrNzlyTU1N?=
 =?utf-8?Q?zv6RokLHnsR1EvHFjI+qT2wdA30cURky1+4QpYPHsT7Lq?=
x-ms-exchange-antispam-messagedata-1: f79kTYd7fk/bNY3RJgj47z8WkJeqQSkxNOM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6C8C9BD7770B4493768A8043E8B9E2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: atempo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426da3d-8194-48b4-e84a-08df29d22731
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 09:04:28.7143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7f54b932-c1dc-47cb-9ea7-f539e4729524
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+e2Ao+BAEXs8bxaLxmJd9KnUXJjt1fbY4am8Qgkew2YzC/glF1vZf36B5DKltbB4oZqHXiSdV/cfF2anRZQHjG9fiHWEfprhPEJPXWGh/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5657
Received-SPF: pass client-ip=52.101.83.117;
 envelope-from=silvain.combis@atempo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:55:01 -0400
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

DQo+IExlIDExIGbDqXZyLiAyMDI2IMOgIDExOjE3LCBFbGl6YWJldGggQXNodXJvdiA8ZWFzaHVy
b3ZAcmVkaGF0LmNvbT4gYSDDqWNyaXQgOg0KPiANCj4gR2V0U25hcHNob3RQcm9wZXJ0aWVzKCkg
cmV0dXJuZWQgVlNTX0VfT0JKRUNUX05PVF9GT1VORCBjYXVzaW5nDQo+ICJTbmFwc2hvdCBpZCBu
b3QgZm91bmQiIGVycm9ycyBkdXJpbmcgVlNTIG9wZXJhdGlvbnMuDQo+IA0KPiBBbnkgZXJyb3Ig
aW4gdGhpcyBmdW5jdGlvbiBjYXVzZXMgYSBzaW1pbGFyIGVycm9yIGluIFdpbmRvd3MgVlNTLA0K
PiBzbyB3ZSBtdXN0IHJldHVybiBTX09LIHRoZXJlLg0KDQoNCkhpIEVsaXphYmV0aCwgS29zdGlh
bnR5biwNCg0KQ29tbWl0IDM3NGY0Njc2Nzg4YyAoInFnYTogRml4IFZTUyBwcm92aWRlciBHZXRT
bmFwc2hvdFByb3BlcnRpZXMgcmV0dXJuDQp2YWx1ZSIpLCBhbHNvIHNoaXBwZWQgaW4gcWVtdS1n
YS13aW4gMTEwLjIuMSsgLyB2aXJ0aW8td2luIDAuMS4zMDIsIGJyZWFrcw0KdGhpcmQtcGFydHkg
VlNTIHJlcXVlc3RlcnMgdGhhdCBuZXZlciB1c2UgdGhlIFFHQSBwcm92aWRlci4NCg0KQ1FHQVZz
c1Byb3ZpZGVyOjpHZXRTbmFwc2hvdFByb3BlcnRpZXMoKSBub3cgcmV0dXJucyBTX09LIGZvciBh
bnkgc25hcHNob3QNCmlkIHdpdGhvdXQgZmlsbGluZyBwUHJvcC4gQSByZXF1ZXN0ZXIgdGhhdCBj
cmVhdGVzIGEgc25hcHNob3Qgc2V0IHdpdGgNCkFkZFRvU25hcHNob3RTZXQodm9sLCBHVUlEX05V
TEwsIC4uLikgZ2V0cyBhIHZhbGlkIHNoYWRvdyBjb3B5IGZyb20gdGhlDQpNaWNyb3NvZnQgU29m
dHdhcmUgU2hhZG93IENvcHkgcHJvdmlkZXIsIGJ1dA0KSVZzc0JhY2t1cENvbXBvbmVudHM6Okdl
dFNuYXBzaG90UHJvcGVydGllcygpIG9uIHRoYXQgc25hcHNob3QgdGhlbiByZXR1cm5zDQpTX09L
IHdpdGggYW4gYWxsLXplcm8gVlNTX1NOQVBTSE9UX1BST1AgKHByb3ZpZGVyIGlkLCBzbmFwc2hv
dCBzZXQgaWQsDQpvcmlnaW5hbCB2b2x1bWUgYW5kIGRldmljZSBvYmplY3QgYWxsIE5VTEwpLiBJ
VnNzQmFja3VwQ29tcG9uZW50czo6UXVlcnkoKQ0Kb24gdGhlIHNhbWUgc25hcHNob3Qgc3RpbGwg
cmV0dXJucyB0aGUgY29ycmVjdCBwcm9wZXJ0aWVzLCB3aGljaCBpcyB3aHkNCmRpc2tzaGFkb3cg
aXMgbm90IGFmZmVjdGVkLg0KDQpUaGlzIHdhcyBmb3VuZCBpbiBwcm9kdWN0aW9uOiBhIGJhY2t1
cCBhZ2VudCBvbiBXaW5kb3dzIFNlcnZlciAyMDE5LzIwMjINCmd1ZXN0cyAoUHJveG1veCBWRSkg
c3RvcHBlZCB3b3JraW5nIHJpZ2h0IGFmdGVyIHRoZSB2aXJ0aW8td2luIDAuMS4zMDINCnVwZ3Jh
ZGUuIERvd25ncmFkaW5nIHFlbXUtZ2Etd2luIHRvIDExMC4wLjIgZml4ZXMgaXQuDQoNClJlcHJv
ZHVjZWQgb24gYSBwbGFpbiBXaW5kb3dzIDExIDIzSDIgbWFjaGluZSAobm8gVk0gbmVlZGVkKSB3
aXRoIGEgbWluaW1hbA0KcmVxdWVzdGVyLCBpbiBib3RoIFZTU19DVFhfRklMRV9TSEFSRV9CQUNL
VVAgYW5kIFZTU19DVFhfQkFDS1VQICh3cml0ZXJzKQ0KY29udGV4dHM6DQoNCiAgcWVtdS1nYS13
aW4gICAgIEdldFNuYXBzaG90UHJvcGVydGllcygpICAgICAgICAgIFF1ZXJ5KCkNCiAgbm90IGlu
c3RhbGxlZCAgIE1pY3Jvc29mdCBwcm92aWRlciwgZGV2aWNlIHNldCAgIHNhbWUNCiAgMTEwLjIu
MyAgICAgICAgIFNfT0ssIGFsbCBmaWVsZHMgemVybyAgICAgICAgICAgIE1pY3Jvc29mdCBwcm92
aWRlciwgZGV2aWNlIHNldA0KICAxMTAuMC4yICAgICAgICAgTWljcm9zb2Z0IHByb3ZpZGVyLCBk
ZXZpY2Ugc2V0ICAgc2FtZQ0KDQpOb3RlIGZvciBhbnlvbmUgcmVwcm9kdWNpbmc6IGFmdGVyICh1
bilpbnN0YWxsaW5nIHRoZSBNU0ksIHRoZSAiUUVNVSBHdWVzdA0KQWdlbnQgVlNTIFByb3ZpZGVy
IiBzZXJ2aWNlIGtlZXBzIHRoZSBwcmV2aW91c2x5IGxvYWRlZCBxZ2EtdnNzLmRsbCB1bnRpbCBp
dA0KaXMgcmVzdGFydGVkIChuZXQgc3RvcCAiUUVNVSBHdWVzdCBBZ2VudCBWU1MgUHJvdmlkZXIi
ICYmIG5ldCBzdG9wIHZzcywgb3INCnJlYm9vdCkuDQoNCkRldGFpbHMsIG91dHB1dCBhbmQgdGhl
IHJlcHJvZHVjZXIgc291cmNlIGFyZSBpbg0KaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVj
dC9xZW11Ly0vd29ya19pdGVtcy80Njc1DQoNClRoZSBJVnNzU29mdHdhcmVTbmFwc2hvdFByb3Zp
ZGVyOjpHZXRTbmFwc2hvdFByb3BlcnRpZXMgZG9jdW1lbnRhdGlvbg0KZXhwZWN0cyB0aGUgcHJv
dmlkZXIgdG8gZmlsbCB0aGUgc3RydWN0dXJlIHdoZW4gaXQgcmV0dXJucyBTX09LLiBXb3VsZCBp
dCBiZQ0KcG9zc2libGUgdG8gcmV0dXJuIFZTU19FX09CSkVDVF9OT1RfRk9VTkQgZm9yIHNuYXBz
aG90IGlkcyB0aGUgUUdBIHByb3ZpZGVyDQpkb2VzIG5vdCBvd24sIGFuZCBTX09LICh3aXRoIHBv
cHVsYXRlZCBwcm9wZXJ0aWVzKSBvbmx5IGZvciBpdHMgb3duDQpzbmFwc2hvdHM/IFRoZSAiU25h
cHNob3QgaWQgbm90IGZvdW5kIiBlcnJvciB0aGF0IDM3NGY0Njc2Nzg4YyBhZGRyZXNzZWQNCmNv
dWxkIHRoZW4gYmUgaGFuZGxlZCBpbiB0aGF0IG5hcnJvd2VyIHNjb3BlLg0KDQpJIGNhbiB0ZXN0
IGEgY2FuZGlkYXRlIGZpeCB3aXRoIHRoZSBzYW1lIHJlcHJvZHVjZXIuDQoNClRoZSBhbmFseXNp
cyB3YXMgZG9uZSB3aXRoIHRoZSBoZWxwIG9mIGFuIExMTS1iYXNlZCBhc3Npc3RhbnQ7IHRoZQ0K
cmVwcm9kdWN0aW9uIHdhcyBydW4gYW5kIGNoZWNrZWQgYnkgbWUuDQoNClRoYW5rcywNClNpbHZh
aW4gQ29tYmlzLVNjaGx1bWJlcmdlcg==

