Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D424C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwR4y-000753-ED; Tue, 18 Aug 2026 17:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwR4l-00074Z-M9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 17:10:30 -0400
Received: from mail-westus2azon11022139.outbound.protection.outlook.com
 ([52.101.48.139] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwR4j-0005eK-1E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 17:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhLS09IG83qJxZX8cYtyThlMClCPZyqxVR8S2hr7nWjWrIFReDeC+QbaZVnhM95yduXtbsOLJTHgbdMjAGNFjxO9QVEiMf0u5VHl8A5SC63ZdM9h+D9K0fi+ZDE2FDOT0b99pWRsAI0zwD6eOayFu9O886sO6MUm2UYPKoSckSx91Nu+4as5hu/r5X+KMTlO0xcYRQ+mARZIyrZtaief4APsthXV+9qUeUDxhKO827QbPWUcjAbYeQmE2avsCTbmQqQqzMbOvs22sCj0XBQKfVt6xRm7ek2fDq7/xeMnm+xDIU1D8Q/cyK9cUZA/eub3n5UJyVsjxuHGXhrZ4Akp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HJJbypk+G2evfLEb36lJDcDkiSRno6E5dvyESU03Sw=;
 b=ff2RiQGYM2aV+9/84WTXdCSS//+j3AkEYFLVBrSNUAKTyS/2s60IoZwkI6k7s9kMfrZ8/tEkr6tO+90gomyd6pe9L5W1XAECAz9AUYTjKGwJk+x9E4YaRjwCAramhzpBR+E9u+J4aF6EJFcB54W/qPRd0ZPzP1DOsuuef+5BZZ0v2cYsMRB26TGOsoA0q8iGXnSfj7jY4LK07+s0xU34sUUKHku/Y0TxA+uU2lOhdIRGcZ7AYnTc60Fw2FB8ZtwUVRRvXYJwsESHDgF1NSdygT8I2KFrg9CRMeSKvU9ueCOWwqzeE06qtNR9Xo/uoVdeaoMVPrrhbrnUEh6sJLnAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HJJbypk+G2evfLEb36lJDcDkiSRno6E5dvyESU03Sw=;
 b=J/vEG1ib8blSr+/7zNArQtY2kEZ+Sfhy1OBgdh+Ha4Z3t23NI/78HNJG0y3ifxBVwzP62EWShzizlHtxMRwqy3y4x+4iu1H71QmAqDr4S9X1+GZj0Wy1cRGVRxyU6fZ6OXWGAPp+np57pNAMWYek4jPqBHCqtNcu7aP3u4t5XKY=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV9PR21MB5047.namprd21.prod.outlook.com (2603:10b6:408:2bc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.5; Tue, 18 Aug
 2026 21:05:19 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Tue, 18 Aug 2026
 21:05:19 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pedro d'Aquino Filocre F
 S Barbuda <pbarbuda@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] target/arm/whpx: fix whpx-arm reset hang
Thread-Topic: [EXTERNAL] Re: [PATCH] target/arm/whpx: fix whpx-arm reset hang
Thread-Index: Ad0vQr38yYpRE3OHS9q9z76IXmdvXQAEHJOAAABRHMA=
Date: Tue, 18 Aug 2026 21:05:18 +0000
Message-ID: <LVXPR21MB7009AFFB5732AC523B0BAD36ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
References: <LVXPR21MB7009095A64089AACFA91DB10ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
 <A5E79D0D-C177-4B7E-9C5B-CB015E11A1C3@unpredictable.fr>
In-Reply-To: <A5E79D0D-C177-4B7E-9C5B-CB015E11A1C3@unpredictable.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=072c14c8-fd16-49e0-ac6b-88976c93d75d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-18T20:59:27Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV9PR21MB5047:EE_
x-ms-office365-filtering-correlation-id: d8201d9c-3648-4248-2468-08defd6c68cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7146999003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: pCECojil7B0jZIULOEGHnfhDadpK3N+8E+CDGeocjFMZGcutshyumaqPBw1MkOLrYuopTgi9u5GQMCiOhzf6Alb07zffjg8bSktq7SMKUmYCimIhD5RYdPVwEEExHjhXqqbT8xEJ0jRCe5vSaOiW7DAV1gSDgmTbfFMJhdbbtXesRgLm6N5u3tDXs2y2DxiOOrEcCek+9Hq65GC/cVxoLx/45ZX98ceAw+sP0Pgg5sV2UnLFdcD7sRWWZP1ZOnm3PuzZomi8Qw2DxIOK+RGMC6oMcSVo1I4W61zUmPcrbfrMAWqU75nmv0EKZSUu3pv3tKuOGO0ahXotrtNRZRf1G5wbOFmZYyBhIwuYO3e2ZE3oM2BfbofAPzbQHeTESiBIV+NNmmHYb09OGylD6z2in6ZNpzmVFBUo+qbxwloj6rkDG4b4lk7GJktO0RVpwcxNlJOLCNMU08zamorSWuUd5satpjHIbgCSwmONi0sUV7mVFni6kDyv+hxQCIXOq+9P9d66In6q65SbBupsGLDWeUgOEpLZYJCZP4e/VZSUvHj+DhJKEP+ZgVNSbBSYDnyGR3qawws6zzcH91aV/urnS/S4CREjWAg/0B6B04ZzwQIfhlmcuUJlfSP2eua7SHLk+jz87O+pBNmipNnSgtAv/jflKPxi0SkBdY2MB66ji1yfTXFvV/0PPLKuICKXa8PUnle+Z+VTM5vPBgncf4XrCIACsXGhiCEOPTjUh4WVFXU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7146999003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1Izbi80NDNNUkVEK0lNNTBBUGJ1N1liOUd0S2VGV1gwV3gvOGJ6K1VoV0Ji?=
 =?utf-8?B?NmdxaVlLY1NTTlJSOUVKQ2VtOGppTmx6NHBndklrV3pUeUtQcmlUQjNQZC84?=
 =?utf-8?B?SVBIQklweU9LRG9rQWMrUVVPeGZINWZKeThzYnE5WEZsRmtCRCtXNU5HM3p2?=
 =?utf-8?B?SVYxbUh0c09uNTlkK05wZVBkNFpFa005d2JJL2R0cWF3OFZWSStGcG5BaU01?=
 =?utf-8?B?ZFpod2MvRm42aGdWYWVrdTQyNDBUbVZkV1NpZW1TMlIvZS9SZ3ZIRkMwbzAw?=
 =?utf-8?B?TnlERDFvdFFKRnhPWGdPUmJVWHEreXg3Q2IxcEpmS2VzK0wxb0g3ZXQzbXBa?=
 =?utf-8?B?eFc1RlFsblBoRDhybDc2cVBLeUFaOHoySitlT2ZCeVZhREY1YTBvNlo5aHJ4?=
 =?utf-8?B?d0pNTzVrZWtMNXZBL0NBRGo5U3lTUDViUU5LTVlxOGZzaG1NRWJZUHVYRjlz?=
 =?utf-8?B?SWJLdk4vWlBlQlh2UC9IM1N6TXZraXMyU1llV1FsM0JKSlF0bDJJWG1jQXBF?=
 =?utf-8?B?OHVoTGdFWU0zOHBDY2RlT3B0bllTWHE3MkdsVW5rclhRaENVZkxzZklQV1NO?=
 =?utf-8?B?TkhReDNxZ3ZZSy84UWRCQzQwUjduWlJxWWQ4MlQ1Y2dnKzA0K2ZmL0Uvd0hh?=
 =?utf-8?B?V2xteHBjVjExSHQxaDIySkQ1YzFlcUdtZGl3ZUQxWGsyRmZaS1ZSQUtYaWI1?=
 =?utf-8?B?SDdPTnhoalE5TXBwMjBZWmZiWHgyQTZEYzNIMTNMNTlLcUorWEJxTllRM3Rr?=
 =?utf-8?B?RmQrNDlnOWM4QXZ2MmhTNXRPQkNKNW04aFRXT1lXb0xFNm5QUllqbG1CL0hK?=
 =?utf-8?B?QXZEdFBiOXNSMHI0V2dEU2JmQTRocmZUd0hjaEVaWW1QaG1wVHM3R3E1SjVD?=
 =?utf-8?B?TVd4dmU2aUUyMGw3UG1yUmR1VDhwVXZBWjVSZ05OVDUwczVDZzVIMXgwMWVy?=
 =?utf-8?B?cjhEUmRSWXZ0VmlEK3M1djJpMHJtcmdxbW96VEVFeTU4eWFMOW9hd0NJZXpR?=
 =?utf-8?B?SVFvSW9sR3E5SFk4aFZkaXYzV1JNUklNNUpLSTV2Y2FUMWZ0TDRSYzFnc1dW?=
 =?utf-8?B?dTZjYlcvckpicG5YZVhXdHZwWWlmZm5RdndxSUFKUnNXQ2FWYnFRdTBUcWhL?=
 =?utf-8?B?UmtZdDlUUFFNaktOMjh6WncvblpmaUp2OFNrbnBzS0toZU9mdXRTMCtRV2xs?=
 =?utf-8?B?UW1abkFXa1lkS0gyR1V0ZUFFOGhKUllCMW9kOFVDVXJ3TXhNZmV6Z2c0aTdS?=
 =?utf-8?B?bXJabVg2bUFCK3lmV2J5SUZzR2tnUVcyc3ZxZW1wMTFMMzFxM1ZEWmIzWWlR?=
 =?utf-8?B?dVZEYll4OGc0Z3JGYXhTaUJkL056eStGVm5DVGZ2azlkRUpMT2hkdkpMS3dL?=
 =?utf-8?B?Ukc0VnZUeDl6dlJzSFFrRTQyZGdmQTdQeXhrL1ZpOGRrc1poTC9CeWxpZnd4?=
 =?utf-8?B?RkhBbG5pcTVocFA4NmhZYncyNzVNc0g2LzN1QlovcE1qR25mVDZpai9TS0tN?=
 =?utf-8?B?bFRjY0dPQkkzelRsTVQrQzFuSjkrZ3ZaM2dMcHpCdXJoUlZ6d0pWb2pSVlpM?=
 =?utf-8?B?cG84RmxRVGxDRHRMRllWRkdNajBiMXBObXpLSDBRaExHdjlCYmFIY1JGdkxt?=
 =?utf-8?B?azQ1M21pcFU2ajRqcDlBVW00SjRnbWRwNG9zcW9lMjBRZncvQ3ZLaU9uekN5?=
 =?utf-8?B?SE9mTEdGVTQyVi9UWjh1UWYrTGNoQzZzN2o1cUU0QmdQa0s1RFZQRDBPZzRU?=
 =?utf-8?B?QVlzemNFUVVMcTZZVTdNODlqQ3BUSWQrSjFYUnBlMDFjZVNCSDNnY2NTdEZZ?=
 =?utf-8?B?RjZnL1ZpTFhmRVZEbll0QXdHRzNubmJadTM5eURyY2s0SnZYOTFqZWl6Y2pQ?=
 =?utf-8?B?WmNGRHNNOEdOYzBuVFY3K0FHdUJDRCtCNnJNWktSYUpOK09zTnJZdGh5bkdv?=
 =?utf-8?B?WXd2d1JyVVFRb3JJVEhOL3M5OHlYanllL0svdy94RzZqZ1BCVXErZUVXaVlm?=
 =?utf-8?B?SG9WbW9QVTFkWmtFNFdWZE1hS2REb3ZCYTlVK01lNkYvdm5LKytVWGxRRjlo?=
 =?utf-8?B?dDNJTm11Nm9haDUzN0tiUWNLbW5IT25IY0lFZTk5YVRlWjV2ZjQ1Snoyb2ZQ?=
 =?utf-8?B?eEI0dlpkMW1yVVpXS25zeWhjVmVKRCtGd2hjR25FVXFNT1h1SDJiNTFGa2JR?=
 =?utf-8?B?ZHVwQVB1VFdldXc4dTVlNnRhRGR4azBwMklFZHVrMmNObWpFbVBPcXV4ODRp?=
 =?utf-8?B?SXA0cGNYSGJBWEpwdVh1dTg3YmQ2eWdJaWFxNTdKQXBRQURjc2JEdXptVk5G?=
 =?utf-8?Q?6vq0cleE9vRajX0yci?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8201d9c-3648-4248-2468-08defd6c68cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 21:05:18.9630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLOKALwClqKuynQJarqDvuOHcQnvn1ekeyaTi77qFIlVkJG+CYjq8Jv0LBh1pXGPBJdPHEoTBWhlnDTTmzRnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5047
Received-SPF: pass client-ip=52.101.48.139; envelope-from=dcook@microsoft.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

PiA+ICsgICAgeyBXSHZBcm02NFJlZ2lzdGVyQ250dkN2YWxFbDAsIFdIUFhfU1lTUkVHKDE0LCAz
LCAzLCAzLCAyKSB9LA0KPiA+ICsgICAgeyBXSHZBcm02NFJlZ2lzdGVyU3BFbDEsIFdIUFhfU1lT
UkVHKDQsIDEsIDMsIDQsIDApIH0sDQo+ID4gfTsNCj4gDQo+IE93LCBjYXJyaWVkIHRoaXMgbWVz
cyBpbiBmb3JtYXRzIGZyb20gSFZGLCBkb27igJl0IHRoaW5rIHdlIHdhbm5hIGtlZXAgdGhpcw0K
PiByZWFsbHkuDQo+IA0KPiAoc3dpdGNoaW5nIHRvIHRoZSBFTkNPREVfQUE2NF9DUF9SRUcgZm9y
bWF0IGFjcm9zcyB0aGUgYm9hcmQgd291bGQgYmUNCj4gYmV0dGVyKQ0KDQpJJ20gaGFwcHkgdG8g
ZG8gdGhhdC4NCg0KPiA+ICsNCj4gPiArICAgIGlmIChsZXZlbCA9PSBXSFBYX0xFVkVMX1JFU0VU
X1NUQVRFKSB7DQo+ID4gKyAgICAgICAgLyoNCj4gPiArICAgICAgICAgKiBXSFBYIGtlZXBzIHRo
ZSAidkNQVSBpcyBpbiBhIGxvdy1wb3dlciB3YWl0IiBzdGF0ZSAoZW50ZXJlZCB3aGVuDQo+IHRo
ZQ0KPiA+ICsgICAgICAgICAqIGd1ZXN0IGV4ZWN1dGVzIFdGSS9XRkUpIGluIFdIdlJlZ2lzdGVy
SW50ZXJuYWxBY3Rpdml0eVN0YXRlLCBhbmQNCj4gdGhhdA0KPiA+ICsgICAgICAgICAqIHN0YXRl
IGlzIG5vdCBhZmZlY3RlZCBieSB3cml0aW5nIHRoZSBhcmNoaXRlY3R1cmFsIHJlZ2lzdGVycyBh
Ym92ZS4NCj4gPiArICAgICAgICAgKiBJZiB0aGUgZ3Vlc3QgaGFwcGVuZWQgdG8gYmUgaWRsZSB3
aGVuIHRoZSByZXNldCB3YXMgcmVxdWVzdGVkLCB0aGUNCj4gPiArICAgICAgICAgKiB2Q1BVIHdv
dWxkIHN0YXkgc3VzcGVuZGVkIGZvcmV2ZXIuDQo+ID4gKyAgICAgICAgICoNCj4gPiArICAgICAg
ICAgKiBTdGFydHVwU3VzcGVuZCBpcyB0aGUgYml0IFdIUCB1c2VzIHRvIGhvbGQgYSB2Q1BVIHRo
YXQgaGFzIG5vdCBiZWVuDQo+ID4gKyAgICAgICAgICogc3RhcnRlZCB5ZXQsIGFuZCBpdCBpcyBo
b3cgc2Vjb25kYXJ5IHZDUFVzIGFyZSBwYXJrZWQgdW50aWwgUFNDSQ0KPiA+ICsgICAgICAgICAq
IENQVV9PTiByZWxlYXNlcyB0aGVtLg0KPiA+ICsgICAgICAgICAqLw0KPiA+ICsgICAgICAgIFdI
Vl9SRUdJU1RFUl9OQU1FIG5hbWUgPSBXSHZSZWdpc3RlckludGVybmFsQWN0aXZpdHlTdGF0ZTsN
Cj4gPiArICAgICAgICBib29sIHBvd2VyZWRfb2ZmID0gYXJtX2NwdS0+cG93ZXJfc3RhdGUgPT0g
UFNDSV9PRkY7DQo+ID4gKyAgICAgICAgV0hWX1JFR0lTVEVSX1ZBTFVFIGlhOw0KPiA+ICsgICAg
ICAgIEhSRVNVTFQgaHI7DQo+ID4gKw0KPiA+ICsgICAgICAgIGNsZWFuX3dodl9yZWdpc3Rlcl92
YWx1ZSgmaWEpOw0KPiA+ICsgICAgICAgIGhyID0gd2hwX2Rpc3BhdGNoLldIdkdldFZpcnR1YWxQ
cm9jZXNzb3JSZWdpc3RlcnMoDQo+ID4gKyAgICAgICAgICAgIHdocHhfZ2xvYmFsLnBhcnRpdGlv
biwgY3B1LT5jcHVfaW5kZXgsICZuYW1lLCAxLCAmaWEpOw0KPiA+ICsgICAgICAgIGlmIChTVUND
RUVERUQoaHIpICYmDQo+ID4gKyAgICAgICAgICAgIChpYS5JbnRlcm5hbEFjdGl2aXR5LklkbGVT
dXNwZW5kIHx8DQo+ID4gKyAgICAgICAgICAgICBpYS5JbnRlcm5hbEFjdGl2aXR5LkhhbHRTdXNw
ZW5kIHx8DQo+ID4gKyAgICAgICAgICAgICBpYS5JbnRlcm5hbEFjdGl2aXR5LlN0YXJ0dXBTdXNw
ZW5kICE9IHBvd2VyZWRfb2ZmKSkgew0KPiA+ICsgICAgICAgICAgICBpYS5JbnRlcm5hbEFjdGl2
aXR5LklkbGVTdXNwZW5kID0gMDsNCj4gPiArICAgICAgICAgICAgaWEuSW50ZXJuYWxBY3Rpdml0
eS5IYWx0U3VzcGVuZCA9IDA7DQo+ID4gKyAgICAgICAgICAgIGlhLkludGVybmFsQWN0aXZpdHku
U3RhcnR1cFN1c3BlbmQgPSBwb3dlcmVkX29mZjsNCj4gPiArICAgICAgICAgICAgd2hweF9zZXRf
cmVnKGNwdSwgV0h2UmVnaXN0ZXJJbnRlcm5hbEFjdGl2aXR5U3RhdGUsIGlhKTsNCj4gPiArICAg
ICAgICB9DQo+ID4gKyAgICB9DQo+ID4gfQ0KPiANCj4gTG9va3MgZ29vZCA6KSBBbHRob3VnaCBw
ZXJoYXBzIHRoaXMgaXMgYmV0dGVyIGFzIGEgc2VwYXJhdGUgY29tbWl0IGZyb20gdGhlDQo+IGNo
YW5nZSBhYm92ZS4NCg0KSGFwcHkgdG8gZG8gdGhhdCB0b28uDQoNCj4gQnV0IG5vdCB0aGlzIGJp
dCwgd2hpY2ggc2hvdWxkIGJlIGRyb3BwZWQuDQo+IA0KPiBUaGUgQ1BVIG1vZGVsIGdldHMgc3lu
Y2VkIHRocm91Z2ggdGhpcyBiaXQgYW5kIHJlZ2lzdGVycyB0aGF0IGVycm9yIG91dA0KPiB0aHJv
dWdoIEFSTV9DUF9OT19SQVcgc2hvdWxkIGJlIGJlaGluZCBhICNpZmRlZiBTWU5DX05PX1JBV19S
RUdTDQo+IGJsb2NrLg0KPiANCj4gVGhlIGZvcm1lciBjaGFyYWN0ZXJpc3RpYyBpcyB3aGF0IGFs
bG93cyBmb3IgZXhhbXBsZSAtY3B1IGNvcnRleC1hNzIgdG8gYmUNCj4gdXNlZCBvbiBXSFBYIGlu
c3RlYWQgb2Ygb25seSB0aGUgbmF0aXZlIG1hY2hpbmUsIHdoaWxlIG1hc2tpbmcgb2ZmIHRoZQ0K
PiBuZXdlciBmZWF0dXJlIGZyb20gZmVhdHVyZSByZWdzLg0KPiANCj4gPiArICAgICAgICBpZiAo
cmkgJiYgIShyaS0+dHlwZSAmIChBUk1fQ1BfTk9fUkFXIHwgQVJNX0NQX0NPTlNUKSkpIHsNCj4g
PiAgICAgICAgICAgICB3aHB4X3NyZWdfbWF0Y2hbaV0uY3BfaWR4ID0gc3JlZ3NfY250Ow0KPiA+
ICAgICAgICAgICAgIGFybV9jcHUtPmNwcmVnX2luZGV4ZXNbc3JlZ3NfY250KytdID0gY3ByZWdf
dG9fa3ZtX2lkKGtleSk7DQo+ID4gICAgICAgICB9IGVsc2Ugew0KDQpJJ2xsIG5lZWQgYSBiaXQg
b2YgYWR2aWNlIGluIHRoaXMgY2FzZS4gV2l0aG91dCB0aGlzIGNoYW5nZSwgd2Ugc3RhcnQgZ2V0
dGluZw0KYXNzZXJ0aW9uIGZhaWx1cmVzIGFmdGVyIGZpeGluZyBFTkNPREVfQUE2NF9DUF9SRUcg
cGFyYW1ldGVyIG9yZGVyaW5nLCBkdWUgdG8NCnJlZ2lzdGVyIHJlYWQtYmFjayBub3QgbWF0Y2hp
bmcgYWZ0ZXIgd3JpdGUuIERvIHlvdSBoYXZlIGEgcmVjb21tZW5kYXRpb24gb24NCmhvdyB0byBh
cHByb2FjaCB0aGlzPw0KDQo=

