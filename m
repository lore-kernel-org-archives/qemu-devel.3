Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A16C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 05:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrWXd-0000HR-W6; Tue, 02 Apr 2024 01:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrWXd-0000HD-3B
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 01:18:37 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrWXa-0004Oh-Bo
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 01:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712035114; x=1743571114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=a6bnAqZ/zGfCMaNUzV1t5rStfNtq24srYe5v7W0pon8=;
 b=H+yCDLkeQMBWUdjKGYi1Xcj9YzzRoidE17b8agFnKavMQUZcljXgV97F
 qgUo4lsNsg+tAC4ZDYUBLNKRU0DZJo6geYGqLAFmVSV/KbIxn3+BmFMTH
 P2UHSjML3f6csh+0SWUIpzHRa8YUgGaaER79ts6yyABlO+Mru8KqqZkYY
 b4ICCGGCajCkb9l5Wy3swQcYx64ymJ0ZDG59Pf4+w3wXjKtLeBO+m+W/I
 90Ex8sh7vprLD4/Sy8sW1R+Tu83cs18dQVITZj42QAfppzXrwmEBWHpIj
 bLleZiCjIFt3YQMvxPk/JUExFUiGvMNFfvhWzN7I328cFHsEaxnK9MMDI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="26740295"
X-IronPort-AV: E=Sophos;i="6.07,174,1708354800"; d="scan'208";a="26740295"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 14:18:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwxkqOkM9cgRxPpmuWKAdNg4P6rt5HCdLq9xSZ816dcVupWnRqJ1OHQa+KwpUZx3feHAM91HUxmTdoyDtY3u5e1DtNxr0Q2LsLqiPPoOs34cLndM6Al28UcxQ/Jgwhny0R9+QqMD5+w8CQ+Wb3Eu9Alh0rOuupdj7gNeYUF4oVJn/KOj7ohJ1m6UzxWbWLvszn8JsB+oDBBfluU8uPSSAL66AeHnLkyv8giUMznbStKs7EGXUXtgSmbkekXLCqoRX9y+SIU3oJXeGoes/IYQYO0m/vvP/myH3qcFPaYAkXywJEckG71hEHo9PfUp1fmYBb2pyaavA9UwnvaEeJrOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6bnAqZ/zGfCMaNUzV1t5rStfNtq24srYe5v7W0pon8=;
 b=YNBL1Tcv3tOjXvSkZw8XlHKmGTq6S29xNLraBcCJI9p/4XBnuotfDvBul5sJsLng4/Ct1QnzQErSKlHFlcmkcF1uaEoD8DPZLeb/L+2Lmms9L17npUpjPHn0co15K8TtqjVGP47rPY0DkZB96eb95gv4zA0L3O9/o4ix+i37TQJbkeYSiYsJgxEocY9NjdsrNcw0alTcab8D30mQgoBNLMCcVZd5XAcbWTXeokMjL1QrP0WMI0uHW5EyRc3CPr7pbqITu8vdwkclqnz93Y7GE2sp7j050rtKeulh/DV36KAAEGw//qjYR6n+Xgfq+hG5hIIZzHSerfCvP9kZYUHXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB12012.jpnprd01.prod.outlook.com
 (2603:1096:400:387::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 05:18:24 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 05:18:24 +0000
To: fan <nifan.cxl@gmail.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni
 <fan.ni@samsung.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] CXL/cxl_type3: add first_dvsec_offset() helper
Thread-Topic: [PATCH 1/2] CXL/cxl_type3: add first_dvsec_offset() helper
Thread-Index: AQHahJ+i9jwOQv1MmkSk6z1oAj9PPbFUXb+AgAATXgA=
Date: Tue, 2 Apr 2024 05:18:23 +0000
Message-ID: <f9ed2ab9-5efc-4f85-ab24-5f64aae687a8@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
 <ZguE3-oGTzMPlFyE@debian>
In-Reply-To: <ZguE3-oGTzMPlFyE@debian>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB12012:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkN+JWSe7v/egOR9L+TQIVtWSOVs79STkzUJiSlmpvBgqny5pOpBqMaSduzenorecjO5/yXASJwWaWg0PTtK+VnWJFYxCSnTmfLiVz0f3xBmeRU3tHh/cG7AS40917R5mDwTvYk67QcMTQjiR6ZkLibWYt1FslO/1W6tyfe+VargnYXFeokZkIAi/8sLqAL6aP07tDIFZJhcLhLP0F/fxsQrGfV6sknl372Cwd/qBeXvFLZQf6NV3u49lTYli3+ZvvZhP3qguHIpol7zsBUBzRX1yw2542JI+86Mn8/dBeZBJpWDLTf6N9XbACOT7h9QjrV6YNOEQG8HPnAd+vOePHNh3h7r19Nel5R6DSu1UEA8dFWLg8uTj6SZ4uBbWCej/CTFLVsurFZa461COZX51wW12/UwUMFlpchnjv2dZCfZFRTSNnTf7sSSnoMXkXZQ81nKYlvmWNS0xgyoFnavNO1Xj66TKCQuzyLJWr7dpXX61kn0YTqJHJxiM+XXwpY1kKu34xOHQfNThfmi5xvt20hLnlOrDnTxwkExpWN3abCyLBl1u3oPhjJo/OwyhhyXHxGhSSvBMTyLrkaUL0oq8xIPbaSQkqCynWmT4ymywxRU0hFOcfU8L/yfuIWW5fk8xaGJKDr3LF0p5DFPkJq3v1stx6g6b4iiE7wDhjlMVflTbrCSF17kallROGR6T5kcWnc/X5dMU4xzIzuyp/Q/iA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(1580799018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERreU5rYVgvVTEwK25hc3VLdi9kNCtadzUxWC90d09IL2l4OHJ1bUNEWFNK?=
 =?utf-8?B?dnRNODZYd3FrNURCbmVEU3hzcnI4M3kySlVBcnY1U3JZcUV5OC9LNWUrUUIz?=
 =?utf-8?B?d0hVUTJpaGpUaUYyRXcvU25OZzRWdUl0MWZUYlk5aXdPbDVTOTE1MHhGNDJy?=
 =?utf-8?B?ZGFFSFh2L29NQkJHNzhmRVM5b2JDOSsweStadjZ5SE5sR3RFWStaRXNSU3Iw?=
 =?utf-8?B?NzFEMWZ6Z0k2dHdQaUVHbEE5Nk9hMmF2c2F5TkRKdFp3VlYwKzRQYjV5YWpJ?=
 =?utf-8?B?dVcwV0xwZ1JTOEFwUjNld1hmQkhWcEVlYUtqaEs4cHdTWUFjNE5Ybndpa0pT?=
 =?utf-8?B?VjJqZ282ZFFJMGVTUktUV0N2QVBudXJHcnpuK2Y4RmROOU00bDM5UDJSa0JG?=
 =?utf-8?B?c3NUbkt2TzVscjVlSDNBOExNSUtYaWpxN3FNQlFxcHduKzZWTC83Q1F2Y2xI?=
 =?utf-8?B?Wnd6aGRvMHhXM01yakc5aytGUU56Szh3Vnk3MzQ1TEM5a1c2SzdLaThuSkxj?=
 =?utf-8?B?ckI4OUhDMDJQREw4cEYxL1ZMdHRVR3RUNXRZMU9FN1pReFV1QVlYcXNJRlcr?=
 =?utf-8?B?TmxJMU8xRDFPMEhuZmMxdTA3RWI1MVlJK0RGY085VzlOc0g4dkJjMElQbnRD?=
 =?utf-8?B?R0FFTitFanVVTUJnRUdFM092MjdOMG42NytYL3JsdE9wT2Npdmx5Mi9DQmZW?=
 =?utf-8?B?Y3VHNDcwYkFHcHZDSmNDbW11UGFidFQ4WFFDOXZKbXVWb0NCVG5Pc1kxdHFX?=
 =?utf-8?B?N3gwbjFteTBaaFg1emF6NGVXRVFOU1cyNFZiUmI4RjJTZEZwdHp5RnRsaUY5?=
 =?utf-8?B?QWpFOHowbkR1ZWt5R29ibXRHOGRwUjBBajh6OGt4aUVielpoVkpTSTJwSjFG?=
 =?utf-8?B?S1p2T1doUkhPRlZTS0tSMVV2TUhXVk9raUNicmxpQUpZZytBeHRhNUlGOXlN?=
 =?utf-8?B?Mm9pSm1tMVF6aE9DTWs2ajJPL2NLSlZaRU5DcXhadWRRYkdLY1dvdTk3VW1M?=
 =?utf-8?B?akZucUQ2TUdnclJqQ0hQQllodTF0ZEZWV0daZWFYWmpIM3VuMXZLWHl3S1pD?=
 =?utf-8?B?OGdwNzMzdE1Lb2hqdmcwOE10V2R6bWFRVmZvemVTZVNzQVg3cytVM2FPRWM2?=
 =?utf-8?B?T0FDeFZlZGJiMXFPSE9VdU1sb3hUNHhuY1NYcTBVWGRuV0lJUG15RUxvai9Q?=
 =?utf-8?B?RXBlRkVHSUNzRGJCeHhjT0pzNXkycGlWOTA5ZnJldXhtN1dNeHBVT1hpcjI1?=
 =?utf-8?B?RXgxZi9OdkY2TGF2VGRvZFpudTVzL2ZwN1VZYVRtS0RRczYzVXUwQXRZVmoz?=
 =?utf-8?B?cXNjOUpVcTN1UjZSWlk2QlpyTEg2eC9KMEJtQVhBVXQ1dUQxalJvZkJoL2E1?=
 =?utf-8?B?VzhVV2dmN0xjc2hIMTk3TXdNdU9sT01WNWFNbVMvNUNNMXNYNjF3emQ2eHdZ?=
 =?utf-8?B?UFh2bVVoTCtTdXlXNXFBM2xwOGxHNy9waUNLcnpSM01CTHRhWkI4T3pubWdi?=
 =?utf-8?B?NE9aNU44ZVYwWHVaZ2lKaE5OTmxyOWNWckx1UUlmZHBvWmtoWnZyc0laN3RC?=
 =?utf-8?B?MDNWSm5ndmhiaWxjSlZaY0RzUWhzTTVjSmFGWDNlYzAxeWJsQmdVVHNDQTRi?=
 =?utf-8?B?Yjc0ZTM4VDJ4VGYwMGJ0dkVEeDJMbGttRUhOQzExZyt2U0NReHNPSzBlSXFw?=
 =?utf-8?B?ZlpMWGNyaUlIamJPSWlVcWUwMDFGWTdWZTBCdnIrSVM0d0FUbjlZeUZVSjhs?=
 =?utf-8?B?Z2oxSERZQ0EwQlFxd0JzclU3aUVMRlhZSVY0cDNDNCtDbm5WTDg0VUp4OFJi?=
 =?utf-8?B?ZDc0enRiZmRsYWN4SXgvUHZnQm5RaC92VDBHU2c3N3Q3eVhySjJVMEJ5Q29U?=
 =?utf-8?B?eFBteGFaeUtMdkVxS3lqdjduL2UwM2I1SDRiNmJoQ2JtVE9KdDJwTUN2c082?=
 =?utf-8?B?TkR6K013dko1UmFDYVEvcU9pNi9xYmlGNWxHZDk1VWxjUk9hMmRWcDFFTk1k?=
 =?utf-8?B?T08zZktpWVlXSWx1RHE2YUVzWW9ZNGFQdjduK1BSR21UbVVHZ0pxTTFUb00y?=
 =?utf-8?B?SDUwaHhjNHVJbmQyeTVPSmpuWUVqV2FPL0F1dHhua2x5V2w0UmlYNFNXNHdM?=
 =?utf-8?B?V3hydVZhbHI0SVc1ZzZ2VWQvbGU4akNFZTVZS2hTTmEwaThMOGR1QXRxMXNq?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <982374D514ABD0419B4D8B214FC79DDF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4elatjTXY+BRhrbjmRlhK/EZp8rdLSl20fExi6m/mPMN0T0v9sYmfznexlY3PQ7yjeyv8+yTMf8WUNAkCUepYAthzB5R59hkBw+FH7EKUFxRarL1WoZ2hSHXiHHZLF/CnJLDNtFyVTLipV/FBZc4gFe/Ix+ZojcAoaKIxfYK6ZxDsX5/95ZDhhNUMZCFM4ZpwC7BCXm3AOYxdw3yygKtNv0vgCqi+72lbm5wtAet+7IhPMfU0zJtpqF8TjaBlEx2Z3+8/jf2hjh3IQ/ep3CZ9MDG57gN7UCIGi2LSOBQyIbEQvtSfHhJodwR5/0gjo3NzVZ0/5PKasXKphk9VvJSqQ62290Mr6ateX14g60Edz1WsqONg8E+JAvYY8GuKM2hWgTmsowv/sChYGyRGB/XYCTq7/pWrQSa1hc+1XEoBbd562ijhnb55DzsSRgKx0Kad83Su4VGEufDTs//219DH6FRKR79F5EZ5BD38bfkosZhSA0o9bEoX4+JiLZb6hSNpUcG8FGxoccV6CHtoNloirO4qdCkvyLpXDGO7ty6puG53w39L79hywxgX6157HYP8aXuNtwnJtGTP4Jj4qYfjYu7/a6qTMdNmuObvBYIBi37sImcmp+7Wa5xhd0qJ8zC
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a3ad8a-7141-479b-ff31-08dc52d451f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 05:18:24.0382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4htMDz5N7vsbCwy9vKsJ8sior9ccn7GMX2HLlGE2Tt3Vhm6Zj44+FYEE7fEM9r+cWRUvgJYMyG/HI3C1z/pqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12012
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDAyLzA0LzIwMjQgMTI6MDksIGZhbiB3cm90ZToNCj4gT24gVHVlLCBBcHIgMDIsIDIw
MjQgYXQgMDk6NDY6NDZBTSArMDgwMCwgTGkgWmhpamlhbiB2aWEgd3JvdGU6DQo+PiBJdCBoZWxw
cyB0byBmaWd1cmUgb3V0IHdoZXJlIHRoZSBmaXJzdCBkdnNlYyByZWdpc3RlciBpcyBsb2NhdGVk
LiBJbg0KPj4gYWRkaXRpb24sIHJlcGxhY2Ugb2Zmc2V0IGFuZCBzaXplIGhhcmRjb3JlIHdpdGgg
ZXhpc3RpbmcgbWFjcm9zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBody9tZW0vY3hsX3R5cGUzLmMgfCAxOSAr
KysrKysrKysrKysrLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9tZW0vY3hsX3R5cGUzLmMg
Yi9ody9tZW0vY3hsX3R5cGUzLmMNCj4+IGluZGV4IGIwYTdlOWYxMWI2NC4uYWQyZmU3ZDQ2M2Zi
IDEwMDY0NA0KPj4gLS0tIGEvaHcvbWVtL2N4bF90eXBlMy5jDQo+PiArKysgYi9ody9tZW0vY3hs
X3R5cGUzLmMNCj4+IEBAIC02NDMsNiArNjQzLDE2IEBAIHN0YXRpYyBET0VQcm90b2NvbCBkb2Vf
Y2RhdF9wcm90W10gPSB7DQo+PiAgICAgICB7IH0NCj4+ICAgfTsNCj4+ICAgDQo+PiArc3RhdGlj
IHVpbnQxNl90IGZpcnN0X2R2c2VjX29mZnNldChDWExUeXBlM0RldiAqY3QzZCkNCj4+ICt7DQo+
PiArICAgIHVpbnQxNl90IG9mZnNldCA9IFBDSV9DT05GSUdfU1BBQ0VfU0laRTsNCj4+ICsNCj4+
ICsgICAgaWYgKGN0M2QtPnNuICE9IFVJNjRfTlVMTCkNCj4+ICsgICAgICAgIG9mZnNldCArPSBQ
Q0lfRVhUX0NBUF9EU05fU0laRU9GOw0KPj4gKw0KPj4gKyAgICByZXR1cm4gb2Zmc2V0Ow0KPj4g
K30NCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgY3QzX3JlYWxpemUoUENJRGV2aWNlICpwY2lfZGV2
LCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIEVSUlBfR1VBUkQoKTsNCj4+IEBAIC02
NjMsMTMgKzY3MywxMCBAQCBzdGF0aWMgdm9pZCBjdDNfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9k
ZXYsIEVycm9yICoqZXJycCkNCj4+ICAgICAgIHBjaV9jb25maWdfc2V0X3Byb2dfaW50ZXJmYWNl
KHBjaV9jb25mLCAweDEwKTsNCj4+ICAgDQo+PiAgICAgICBwY2llX2VuZHBvaW50X2NhcF9pbml0
KHBjaV9kZXYsIDB4ODApOw0KPj4gLSAgICBpZiAoY3QzZC0+c24gIT0gVUk2NF9OVUxMKSB7DQo+
PiAtICAgICAgICBwY2llX2Rldl9zZXJfbnVtX2luaXQocGNpX2RldiwgMHgxMDAsIGN0M2QtPnNu
KTsNCj4+IC0gICAgICAgIGN4bF9jc3RhdGUtPmR2c2VjX29mZnNldCA9IDB4MTAwICsgMHgwYzsN
Cj4+IC0gICAgfSBlbHNlIHsNCj4+IC0gICAgICAgIGN4bF9jc3RhdGUtPmR2c2VjX29mZnNldCA9
IDB4MTAwOw0KPj4gLSAgICB9DQo+PiArICAgIGlmIChjdDNkLT5zbiAhPSBVSTY0X05VTEwpDQo+
PiArICAgICAgICBwY2llX2Rldl9zZXJfbnVtX2luaXQocGNpX2RldiwgUENJX0NPTkZJR19TUEFD
RV9TSVpFLCBjdDNkLT5zbik7DQo+PiAgIA0KPj4gKyAgICBjeGxfY3N0YXRlLT5kdnNlY19vZmZz
ZXQgPSBmaXJzdF9kdnNlY19vZmZzZXQoY3QzZCk7DQo+PiAgICAgICBjdDNkLT5jeGxfY3N0YXRl
LnBkZXYgPSBwY2lfZGV2Ow0KPj4gICAgICAgYnVpbGRfZHZzZWNzKGN0M2QpOw0KPj4gICANCj4+
IC0tIA0KPj4gMi4yOS4yDQo+Pg0KPj4NCj4gSGkgWmhpamlhbiwNCj4gDQo+IFBsZWFzZSB1c2Ug
UWVtdSdzIGNoZWNrcGF0Y2ggdG9vbCB0byBtYWtlIHN1cmUgdGhlIHBhdGNoZXMgbWVldCB0aGUN
Cj4gcWVtdSBjb2RlIGZvcm1hdCByZXF1aXJlbWVudC4NCg0KDQpNeSBtaXN0YWtlLCBhbnkgb3Ro
ZXIgaW5wdXQgZm9yIHRoZXNlIDIgcGF0Y2hlcz8NCg0KDQoNCj4gQWxzbywgcGxlYXNlIGNjIGxp
bnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcgaWYgdGhlIGNvZGUgaXMgY3hsIHJlbGF0ZWQuDQoNClRo
YW5rcyBmb3IgeW91ciByZW1haW5kZXIsIGRvIHlvdSBtaW5kIGlmIEkgc2VuZCBhIHBhdGNoIHRv
IGFkZCB0aGUNCiJMOiBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnJyBmaWVsZCB0byB0aGUgQ1hM
IGVudHJ5DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQo+IA0KDQo+IEZhbg==

