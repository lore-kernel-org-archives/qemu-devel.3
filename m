Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E13CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 04:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDa3M-0008AM-7f; Mon, 05 Oct 2026 00:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xDa2r-00089Q-12; Mon, 05 Oct 2026 00:11:23 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xDa2o-0003s0-LC; Mon, 05 Oct 2026 00:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFgTBXey0oM5n754HDXZQUy+1ZGKjsDCV+J0bc2LbEuxRRrd7YgfhNdkayvlQZGko8CKnjqtC+EnD1cRHEmZIz7CmmWqruS4iQRjePbKcIVZIX7+CS0++6tn2YBhuV3GgdaTttfgZVFl2y5cbnhDKHbPHTNo0mpF1vPkT93+M6oIsk8SxPEmK/CN7zRVunujM8kOhHEVSknPuFH8Fb5I1AefCvgMMwMiIOdLb82HAHcKgw65WX6YqWpY/tY3NxuY1MNCgSMSj8tsPi0VkpCBFqwe9zCUtREciZqrk8VXgclpa31LAQ6mT2qmp0hDZKFgslvdlBoCmBiJm4gp8Xyq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmexitn3o8nbtpL6EQrnzyeLFA4lTB+ble6kV7sJYPg=;
 b=m9pyONSDIeYC2fz/tsjjXODeIRG82cq7CQQRS7wM3BDDeJJSysmSAsc7vzjCAajg7RcNyxxOFWUdULwWgiF37F1pusxEr1L1R/uRY9xihPUqQ4gF42dXF8zOWRlsziLPU+vJ9E4K68DXT7d7jdAdIZiFWVOqNIveC+EXuZU2e/kObM+jBLcUICMav6+g2/xTr6DAfM3myIWBu/1ElSUIDGRLNh3u7Zy0MMA9OTEivP3G1XGGFJ5Z1ohcuKTkHVJcy3rxi6k2Bb+x7jizkcWUTFLTWEpJojy0LAO0NpnuGMH1o2OMDxjsk7he9ghCvJApznn2Vx19PfSk3uL8LcodnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmexitn3o8nbtpL6EQrnzyeLFA4lTB+ble6kV7sJYPg=;
 b=d6QPGAu1QtBydl+80e6A3qpjCQWvE8GNr6LpnKSpfrxCjq1UMi4vM81OkkjJwJyS4iSajMzQq8tZwyGX9heMXen/i8lDy2ss+nicikUhQbPH5COTjrLHNAzP+EiQSvTLsnJjXgNtQttHNuknyO0b6XdG8b5iaA7NbkiQwwVUq4IJQo/ug7VF2WXrViM72INN9VbVdAnw27c/sVyELTcL8wZDaAmHhIjf7JkXPzzbcp1VFDhS+tearSJa+VJ4jxn7ltEl8a+eSX8GPISpp5xsunKbTmPtoNLWYGC3Sr7UBEGEDwaomoG0uFRPk66n5a9/vnzlxcR79E4J2z0LhAbYoQ==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:11:11 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:11:11 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>, Jason
 Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Bin Meng
 <bin.meng@processmission.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: RE: [EXT] [PATCH v2 30/30] hw/arm/fsl-imx8m: Fix typo
Thread-Topic: [EXT] [PATCH v2 30/30] hw/arm/fsl-imx8m: Fix typo
Thread-Index: AQHdU/vaVpvMr/AoCkWZmvBr3H8OB7buVsEw
Date: Mon, 5 Oct 2026 04:11:10 +0000
Message-ID: <DB8PR04MB71772DFBE4AC1EBFCC54E48F87962@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-31-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-31-shentey@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-05T04:09:47.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|AS8PR04MB8610:EE_
x-ms-office365-filtering-correlation-id: 0e245821-4f38-4098-8290-08df2296b070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: lTgpJW5EsWvfPH5XYMlYJlyoVFiFKFyoeqx1Geqo7Aq3XyW+lBIFDDFhogt6AGFD20NVobNgoPgI/lGnnyR1snEafM9wRFlqkOZiYHesWGYdlDox0k5newqSCV8MnrrpnBYE4moQ2o+igzrKGgTH9quMXCmvujd8iWcyhz9T1ounc8+sNdmIDC5LDKsLQXf6HedTATcxWjJOP3cYlLwFq8wNj7IWX3mp7zjZ/eyO2x12UcCHUB4MSjOmfolF10d2Zy6zyr4Sdn9gbhBdoZIDpZbASVaFmFCzX4EhV4VyXgyAt2BfCAilPGN1kagzuz9U3MvlFXS1IGCFbU827Yuk9fxFNE98/hzArRqsDLz4dka8n4elhBMBN+ObFJFE0hqBpDTtTxyRj++5J6eRKFmKaLX/yiy1h/7ZzCE2iQMuTeRXUySFVtgQSBIS0vYPICbiqoJgr2apPZlQhjcTyl2kbhJ6aeno7LkCs3gZmlv22AZa+u1oXHK0Vi/MGssJOEb3hPOo5fjh+3F3NXpPaXSwCwI3teLz/mHKAbk/cChGPD1KbfhBl4CSXlw0VByPIf5AP1GHI/5RYK9Enq8WkcRPoy16CJD+mdbMWBTtT23pBq7kMFEIUXJ5TYqZ5ZP2waORYp+GbSm8nZeFB+cM9PWk7m9wNcPDNmRIbNT3eNR/JE4bMx1i9g1hbgWgm4sYt2ZRCTJ6xJXkSlOXPr+P99TcbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SllVMHNYcU5aSDFPaXlmVUR0aWx4cFZhTTY0U2pSbDRHUHZGaEY0ZGhReURa?=
 =?utf-8?B?NjJGRTErNU1XMGkyeHlzK3BKMkExTUgxd3VTdldRMHEydUF1RGUzeTNBVStB?=
 =?utf-8?B?QW9FRHNIOG1rUmhrdnp1Y3FaYm9BcHFsM2dEbU5CQm1MaGpwRytOTE5jZFAr?=
 =?utf-8?B?aU43NWUwZmpRakRKbkNoQlFEZjNReHpmK25FU2FuVTdUc3d2N08xYU9DTGFU?=
 =?utf-8?B?QjVKZlhUcmFtSDVhQmUzKzZIWTVEVlJBOW04V1BsdGpEWWtqT3lJdlRmOURq?=
 =?utf-8?B?ZzRwaENyNVJ5VllwK01ZZno4MUpVcHg3RVhMcytOU2IyOFo4TTR0NXhEWlB2?=
 =?utf-8?B?Nlo2Wm5melNpaU52RE1YQyt3RGF1MTB6YlZINVpqT0hYVTBaNzFnbzZ0Sk9W?=
 =?utf-8?B?bnpnVzU0SS8vNHllZzhSbVVDUFhuMVdZNVJiemZ4empkUjNWQnIrSzFqNEtv?=
 =?utf-8?B?UmlmakFXdmRmMW8rY3dSVHQ2ODh1dlY5bTM0QXI3Mnp6MVI5UzlJREVMcEhT?=
 =?utf-8?B?UDVkSXV4cUtUTThNRHE4OEZpeE1kTHNTeE42dU9TV2c1R3JrZ3JCanNhb3FC?=
 =?utf-8?B?RjhteVdlaExoVjM5Qzk2dm1vZW16SXFvSHV1bk1FZ1hQR2IrSjBNT3dqdUFC?=
 =?utf-8?B?Y0x2dFhxODdWS1dlRGdNaVhOczZDb0twVWJXUmU3L0FBMERjMDFsYjdmZHFW?=
 =?utf-8?B?cm9wNnFQQ0gyV0VMRjRXY3hBZ0FRVmhMTkY4TnhNZ0VMZDVGdjhOdXhRdzJn?=
 =?utf-8?B?aUYrWFRET2Q3NnlMd1NodUsyb2N0R0xrZExmOGFJeVdCVWhnb2VVaEVDbUdk?=
 =?utf-8?B?aHRwYU5lR3NjaXVPa08vWkJTQkVVZVZIckMzSW55MVI5dkFpNk00SEtxRlVz?=
 =?utf-8?B?VzlrQXlDcFdrY1JzdGovaTkxRWlFU3pLTWdFNWlhd0ZCbUxKYnJOMDZrNDJX?=
 =?utf-8?B?QnJJb1h4bGdYd3JVL2VVMVRDV0RiSFlYU0thNExRT2tFWGM4QUdvR1ZjUXF6?=
 =?utf-8?B?V3RFWlNJbFZNUUs1UHE1Z2I0RlY2V0ppRmpwNXhCczloanoxNE4rTHJlMHBE?=
 =?utf-8?B?U2hEZi9ROUxQaFZpS2FxU0tnc3A1S3JLb1RSSkpYTFo3bitZeHVYVU1pM200?=
 =?utf-8?B?UHo2dkl3ZStMQlk3bFZJSkk0U3JMeUVXYzd0bHVIYWVPeVJ0OXVmU21qUlF3?=
 =?utf-8?B?WnVUd0RMS29lUk50L3VucEJJbGZseEtySmU1azU2YVFhTytiSmNhSlhSZ3Av?=
 =?utf-8?B?V2RDc1RBWUJsU3hLL25YaksvM29URC9DelAvWWN6Yld2SmwzNGJWMG52cnlk?=
 =?utf-8?B?aXlPL0JnS05yR01PQWpXUG1pM2hvWElBS25NTWhCMEo2RGVqeDA4ZElaS3Bk?=
 =?utf-8?B?b2YwZHUvR3oxWVRZUjE2ZWpwMUtBdnczTVk0N1dXdmRCUlBwOEpzcWFzamVD?=
 =?utf-8?B?SmdPU1lHeFljbzBLUml2cnROY3lyWStiamVESkdTWW5YWVl0QjNyWDYxeFRZ?=
 =?utf-8?B?L29MVGJEV2pOMTJ3bXJnYU9aMGpwTmVsQ0RRR016WkZYK2ZtV1haMzRMU1JR?=
 =?utf-8?B?V3ovbkV3QTVmcFNkNGJnZW5Qam1rREZWYkZ1S0g2dE5GNXFhVmxlYWJFell4?=
 =?utf-8?B?dGdHZW05cHZsRWZLZlA2cHlxbkRGNXdEU0ppM1g5NW1ZN091SnFVbWpqRGho?=
 =?utf-8?B?RGtaMCtiOFY0QUlxcmhYaGY0cVdOeFB0dlJUYVFzSWZUUlFkREs0RE83V0o0?=
 =?utf-8?B?QVBRbEF2NktwdnB4WWd1aCtmeE1sczJHYzltZTI0NzJESVhqZG1BSjBmeDRi?=
 =?utf-8?B?K21FVGVMNjIwSFhsekUweFBuaUpLTjJkd0YrWWdwelRtTENYQ3VnaFJGV21Z?=
 =?utf-8?B?NnFUaG5QSGtMZVA1azJZNUt6Yi9ib0dGaTBzeVY4SnpBUkRDY3BJR0d0a3lp?=
 =?utf-8?B?L2lmWUo1K2ZMUmR5bUx3TnNlV1B6eDMyNUtkMExXTEwvL2VIQ1RTQjVLb0oz?=
 =?utf-8?B?L0NiUjNEbzlmd3o3aG5lVmZSUlYxWkRRYytzNUpLRGlRdHFud3pOZ3VoQ1BV?=
 =?utf-8?B?WExhVC9ZeFNCbTJsLzl6MlNDSVdCNDBTeEFEb1k2VVZKL0MyelNOZHJEclF0?=
 =?utf-8?B?R3laN0s2RkpEdHRoK0hYekVBajhKN1dSUjg3MmJmSzFEVkEzQU9aRG02VWxj?=
 =?utf-8?B?TVJiY0dvODdDM3ZibGwxTnhCUmRTRitLb2UrVll6R0JxK0NMUnBrbG5iNjNU?=
 =?utf-8?B?TnJBUkNJQ1Jnc0JVNFlWdjZ5VDU0cXpaN3NFaVoydjBSWjhLY09RdGIwQnhj?=
 =?utf-8?B?SlloUmREM0ovWnNFTjRBQ040LzVrY0ZRQm80YStuak9jYjQrSDRBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e245821-4f38-4098-8290-08df2296b070
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:11:11.0096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJoZ69UJJHMlxG6Y/lRGs8OovaTICDwhzv3DhM65JvtUpvXgZdXWnVEC0GKx35NDz3OWFDCnoVcASnCFV2v8Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
Received-SPF: permerror client-ip=2a01:111:f403:c200::5;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdtYWlsLmNvbT4NCj4gU2VudDogMDQgT2N0
b2JlciAyMDI2IDE3OjU3DQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IE1hcmMt
QW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGV0ZXIgTWF5ZGVs
bA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNo
YXJtYV83QG54cC5jb20+Ow0KPiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBhbGlzdGFpcjIz
Lm1lPjsgQmVybmhhcmQgQmVzY2hvdw0KPiA8c2hlbnRleUBnbWFpbC5jb20+OyBxZW11LWFybUBu
b25nbnUub3JnOyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiA8cGhpbG1kQG9zcy5xdWFsY29t
bS5jb20+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ2lvQGdtYWlsLmNvbT47DQo+IFBhb2xvIEJvbnpp
bmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBCaW4gTWVuZw0KPiA8YmluLm1lbmdAcHJvY2Vzc21p
c3Npb24uY29tPjsgSmVhbi1DaHJpc3RvcGhlIER1Ym9pcw0KPiA8amNkQHRyaWJ1ZHVib2lzLm5l
dD47IFBpZXJyaWNrIEJvdXZpZXINCj4gPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNv
bT4NCj4gU3ViamVjdDogW0VYVF0gW1BBVENIIHYyIDMwLzMwXSBody9hcm0vZnNsLWlteDhtOiBG
aXggdHlwbw0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2Ug
dGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4g
V2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRo
aXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBUaGlzIGlzIElNWDhNUCBhbmQgSU1YOE1NLCBub3Qg
SU1YNi4NCj4NCj4gRml4ZXM6IDBjMTA1YjI2MTU1MSAoImh3L2FybS9mc2wtaW14OG1wOiBBZGQg
RXRoZXJuZXQgY29udHJvbGxlciIpDQo+IEZpeGVzOiA4NTc2NzAyMDBjNTEgKCJody9hcm0vZnNs
LWlteDhtbTogQWRkaW5nIHN1cHBvcnQgZm9yIEVORVQNCj4gZXRoZXJuZXQgY29udHJvbGxlciIp
DQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5oYXJkIEJlc2Nob3cgPHNoZW50ZXlAZ21haWwuY29tPg0K
PiAtLS0NCj4gIGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg4bW0uaCB8IDQgKystLQ0KPiAgaW5jbHVk
ZS9ody9hcm0vZnNsLWlteDhtcC5oIHwgNCArKy0tDQo+ICBody9hcm0vZnNsLWlteDhtbS5jICAg
ICAgICAgfCAyICstDQo+ICBody9hcm0vZnNsLWlteDhtcC5jICAgICAgICAgfCAyICstDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2ZzbC1pbXg4bW0uaCBiL2luY2x1ZGUvaHcvYXJtL2Zz
bC1pbXg4bW0uaA0KPiBpbmRleCA2MGQ3OWE2ZTNjLi4xOTY2ZmE1MDVmIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2h3L2FybS9mc2wtaW14OG1tLmgNCj4gKysrIGIvaW5jbHVkZS9ody9hcm0vZnNs
LWlteDhtbS5oDQo+IEBAIC0yMjksOCArMjI5LDggQEAgZW51bSBGc2xJbXg4bW1JcnFzIHsNCj4g
ICAgICBGU0xfSU1YOE1NX1dET0cyX0lSUSAgICA9IDc5LA0KPiAgICAgIEZTTF9JTVg4TU1fV0RP
RzNfSVJRICAgID0gMTAsDQo+DQo+IC0gICAgRlNMX0lNWDhNTV9FTkVUMV9NQUNfSVJRICAgID0g
MTE4LA0KPiAtICAgIEZTTF9JTVg2X0VORVQxX01BQ18xNTg4X0lSUSA9IDEyMSwNCj4gKyAgICBG
U0xfSU1YOE1NX0VORVQxX01BQ19JUlEgICAgICA9IDExOCwNCj4gKyAgICBGU0xfSU1YOE1NX0VO
RVQxX01BQ18xNTg4X0lSUSA9IDEyMSwNCj4NCj4gICAgICBGU0xfSU1YOE1NX1BDSV9JTlRBX0lS
USA9IDEyMiwNCj4gICAgICBGU0xfSU1YOE1NX1BDSV9JTlRCX0lSUSA9IDEyMywNCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvYXJtL2ZzbC1pbXg4bXAuaCBiL2luY2x1ZGUvaHcvYXJtL2ZzbC1p
bXg4bXAuaA0KPiBpbmRleCAyYmUzYzUxYWY1Li4zYWNmZmZkMzBmIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2h3L2FybS9mc2wtaW14OG1wLmgNCj4gKysrIGIvaW5jbHVkZS9ody9hcm0vZnNsLWlt
eDhtcC5oDQo+IEBAIC0yNzYsOCArMjc2LDggQEAgZW51bSBGc2xJbXg4bXBJcnFzIHsNCj4gICAg
ICBGU0xfSU1YOE1QX1dET0cyX0lSUSAgICA9IDc5LA0KPiAgICAgIEZTTF9JTVg4TVBfV0RPRzNf
SVJRICAgID0gMTAsDQo+DQo+IC0gICAgRlNMX0lNWDhNUF9FTkVUMV9NQUNfSVJRICAgID0gMTE4
LA0KPiAtICAgIEZTTF9JTVg2X0VORVQxX01BQ18xNTg4X0lSUSA9IDEyMSwNCj4gKyAgICBGU0xf
SU1YOE1QX0VORVQxX01BQ19JUlEgICAgICA9IDExOCwNCj4gKyAgICBGU0xfSU1YOE1QX0VORVQx
X01BQ18xNTg4X0lSUSA9IDEyMSwNCj4NCj4gICAgICBGU0xfSU1YOE1QX1BDSV9JTlRBX0lSUSA9
IDEyNiwNCj4gICAgICBGU0xfSU1YOE1QX1BDSV9JTlRCX0lSUSA9IDEyNSwNCj4gZGlmZiAtLWdp
dCBhL2h3L2FybS9mc2wtaW14OG1tLmMgYi9ody9hcm0vZnNsLWlteDhtbS5jIGluZGV4DQo+IDg3
NWU5MmJiMzQuLmRkNzkxODhlMGMgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9mc2wtaW14OG1tLmMN
Cj4gKysrIGIvaHcvYXJtL2ZzbC1pbXg4bW0uYw0KPiBAQCAtNTg5LDcgKzU4OSw3IEBAIHN0YXRp
YyB2b2lkIGZzbF9pbXg4bW1fcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiAqKmVy
cnApDQo+ICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZzLT5lbmV0KSwg
MCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihnaWNkZXYsIEZT
TF9JTVg4TU1fRU5FVDFfTUFDX0lSUSkpOw0KPiAgICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNf
QlVTX0RFVklDRSgmcy0+ZW5ldCksIDEsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHFkZXZf
Z2V0X2dwaW9faW4oZ2ljZGV2LCBGU0xfSU1YNl9FTkVUMV9NQUNfMTU4OF9JUlEpKTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihnaWNkZXYsDQo+ICsgRlNMX0lN
WDhNTV9FTkVUMV9NQUNfMTU4OF9JUlEpKTsNCj4NCj4gICAgICAvKiBTTlZTICovDQo+ICAgICAg
aWYgKCFzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+c252cyksIGVycnApKSB7IGRp
ZmYgLS1naXQNCj4gYS9ody9hcm0vZnNsLWlteDhtcC5jIGIvaHcvYXJtL2ZzbC1pbXg4bXAuYyBp
bmRleA0KPiBiY2Q5MTczOWQ5Li4wYjQ2YTQ5NzFmIDEwMDY0NA0KPiAtLS0gYS9ody9hcm0vZnNs
LWlteDhtcC5jDQo+ICsrKyBiL2h3L2FybS9mc2wtaW14OG1wLmMNCj4gQEAgLTYxOSw3ICs2MTks
NyBAQCBzdGF0aWMgdm9pZCBmc2xfaW14OG1wX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJy
b3INCj4gKiplcnJwKQ0KPiAgICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRSgm
cy0+ZW5ldCksIDAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4o
Z2ljZGV2LCBGU0xfSU1YOE1QX0VORVQxX01BQ19JUlEpKTsNCj4gICAgICBzeXNidXNfY29ubmVj
dF9pcnEoU1lTX0JVU19ERVZJQ0UoJnMtPmVuZXQpLCAxLA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICBxZGV2X2dldF9ncGlvX2luKGdpY2RldiwgRlNMX0lNWDZfRU5FVDFfTUFDXzE1ODhfSVJR
KSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oZ2ljZGV2LA0K
PiArIEZTTF9JTVg4TVBfRU5FVDFfTUFDXzE1ODhfSVJRKSk7DQo+DQo+ICAgICAgLyogU05WUyAq
Lw0KPiAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnNudnMpLCBl
cnJwKSkgew0KPiAtLQ0KPiAyLjU2LjANCg0KUmV2aWV3ZWQtYnk6IEdhdXJhdiBTaGFybWEgPGdh
dXJhdi5zaGFybWFfN0BueHAuY29tPg0K

