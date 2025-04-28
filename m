Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1983BC369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9LhX-0006f9-QV; Mon, 28 Apr 2025 06:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u9LhR-0006Ep-LX; Mon, 28 Apr 2025 06:26:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1u9LhK-0003Fu-Co; Mon, 28 Apr 2025 06:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNlomZgCGUpDHI8c5YHXYVL5sr55QrhiI6dtIyeHgi1UBHfQHQNGcpmjJW5GcOJiiZsnJM/OPo76b+qJopgWEwbNsTOMZvHJ/rB4egus3Nmdy6W7bSQG7w7n9bytkiUd3Gl4p6Dehkjf6l57cS+pJtXWCWEUTHIxz0JbSgNnnrfYemPrdNzkjYUbThjzY4si/DdJOAo3Nfxyjx1Z+vo78UiiEI14oQ7GnZ7nNb4ng6pPGU3GUzLkx9Z+Zm84Ik0O+S2vlDdEDIEC/6Ag/whsK9vQMUPZZbc6Js/PahwvIDwxcFzgIzVTypR2Xhtx80TjTd2CfCgsW3x+AwgpXfm3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXH5ahZmdjHmgmDZKNaNKfqBsVDlh2lsPdH5+flF/58=;
 b=ZGbzRcv0ppAc6UH3SOiRTZ7L7IkC9Wx/d+HbNiXHJ5q7MAu+O9Rd3sDk0VFYscYk90p30UwJMef4nRdtMvS+xBkey2cN8J7yJ88n5Q20WShf5pu7RB4jqUkgk16LYeVOag+2aSEcC/c79NFewd11/gQMjR4vqEizHXcKBKbjVG6wlwVdksRrI1zOLhop80cOuJZu+7VpDGJamDLVAM6+4TO21fOvtcAtOvoAbpqRIfnNT/ikO+zCoufUuAf+ZrIguj9/BdhBjfUnY68binuCktpi16YgDEgDXwp+/AzKUtfSKRL7YPNkbXKqq/E8n2UUnSMXOSICdRGOWM08gbe6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXH5ahZmdjHmgmDZKNaNKfqBsVDlh2lsPdH5+flF/58=;
 b=hs2+tTArEfjYtfxvix+Xx1AlZfEord8UxCClSIaPVgpLF3/sCKe3GUuqvFpGhrIVvfJAQkhwGsg36OWzhnnz3nn8QWDaGVEtc9VB1DI3zLubYMAQ4jQV7oMaWYGSYHRRZpbRGljaNAeu7/WHyIc/2GuVGV900+AahRFLA89ridcwnypZAupnNN1VswIKEdzmClpY+gLdADzsHmVPpeIRyYJYonMiaU4YJv9pWJ3HqkYdz3Ltq9J1n+FBomVBLgjxrF2JZSz48ZT5dnwyLU5S5NGmdeAtRqjnPxLvxMeF9+gtBBTKNubSb7cjkxVhG6ZlvVFjLm973FlxofUeXQdS5g==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6332.apcprd06.prod.outlook.com (2603:1096:101:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 10:26:42 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 10:26:42 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Topic: [PATCH v3 3/3] hw/arm: Integrate Aspeed OTP memory into AST10x0
 and AST2600 SoCs
Thread-Index: AQHbs/tcXU6vRffvC0+zacS0f0KZJ7O4ueyAgAALyLA=
Date: Mon, 28 Apr 2025 10:26:42 +0000
Message-ID: <SI6PR06MB76317C8FAC3EBF18AAF632ECF7812@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250423025651.189702-1-kane_chen@aspeedtech.com>
 <20250423025651.189702-4-kane_chen@aspeedtech.com>
 <e3d35357-de8c-44da-b54e-7ec2761f513b@kaod.org>
In-Reply-To: <e3d35357-de8c-44da-b54e-7ec2761f513b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6332:EE_
x-ms-office365-filtering-correlation-id: b244c1b2-cad2-4c12-2f87-08dd863f2b2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?LzNBL3RTUXJ6WWFvVVNLSGw5ZDNwUS9YL29vbVk0RjVERXdNR090NEVoT2Uz?=
 =?utf-8?B?RXRJTlQzeG5RTytndDA1cWdscm9Nc3VJNjhac0w0V3U3Zy9GbkVJbEVIOXI2?=
 =?utf-8?B?dVlUNmZ2TC9idVJsbzFURXlyRnRMdmp5WlNVVjY1c3c5Y1FsRHlZQnZ3YVU1?=
 =?utf-8?B?Z0Y4L0h0aGhvcVgyU2xJdzhyQ3BOVGZYOWtlcDhaMzFRQUdCK2g2eFVlUTdN?=
 =?utf-8?B?SWJjc1VDL3JnQ3phNzZ4OTBlYkFKZ2FvV2xGblF3c2ZGMHFpa1dQeGhrdmsr?=
 =?utf-8?B?eUtoQklJN0U3VmpQcnIzMWVFWGIxWmYwT0JWUStYV0RaZUVMUmVIRXkvTm95?=
 =?utf-8?B?UDNVQkJpSEY5ZzEzV2hsQitOYURSZ1lpYU5YUC9CN0NEaWF4UENRaEh1TzEy?=
 =?utf-8?B?Vk5yYWwyRmRWOUtKcWpZQ294dWUwM091WUhhNGV4Zng4VThqVGR2UmdGL2xW?=
 =?utf-8?B?UmlTSTN2ZFdpNUEvblE5R0FPMnR0ZXBLYmJmbGZQSGpsVlVEeUxqVW5VVHln?=
 =?utf-8?B?Y0VieENJd0hrRG1BRVhyNWJMbnRRcnlCNlEzNXZTSXBHRDE1eENqZWpYcGcw?=
 =?utf-8?B?K000WDBQc21KTzRwVHp1TjRQT0RpbWR3alNzaUFsUzFERVJlWEtHZHJnZ3JU?=
 =?utf-8?B?cXZlWnRhYTlpVWw3Z2JwbmxoMW5xTWlVNys0RFYwOHc4TUErNThGTFZBaEl1?=
 =?utf-8?B?SlQ3dmdGdCtIQy9TODlvdmMrMU9yWWRUclE2a05ESm92QWpTWUdjQk1iMElZ?=
 =?utf-8?B?am9yOHVaVUM5UmNyS2w5Y204MG1wYklsamh4QlZHMkpQZS9kdkUxSDRqSW5r?=
 =?utf-8?B?ZFhUbnVaUzdBUmhuZW16ck1aVGFrSUZwWVFoNTRtSDY5V0U0dm5JMmYxVTYw?=
 =?utf-8?B?TlQvdE9wMFNNeXE1NHRQaElxYllUTGVlUlZocGxGSkZNYnBiVkZ6MnV1SWRn?=
 =?utf-8?B?ZVZFNytjOW03ZkQvbDZwWm1nRTNKM0lLWXpHSWE1bDlEOFgrTHpFamZTR0hU?=
 =?utf-8?B?bGNsS1BGa2w5UGJjV2RpemViRGM5S2RhWW5FREZnU3EwaSttVFZrTXZKdmRn?=
 =?utf-8?B?N2tNbXJlZThGYTRpQUYzMVBLY1lGRk0vdUx1ZG45akRsTytHeGQ3Q1oyRzkx?=
 =?utf-8?B?R2lLTVNhczlKUnBwTXc0OWpyUUk0Zjk5aFM3VVFaYjlnajF6a0x2RkZFS0pl?=
 =?utf-8?B?T2lURWc1MGtKUGcrYmd0RjF0cFV1Q25hRG1MQ2syL3AxUzBQUXJwcWZZTzVk?=
 =?utf-8?B?d0ozVmdnK1FiZk9VYUVhTWo0eGo0L2hWWEp2a1hVbUVha3A3YktGbWVZcHJ0?=
 =?utf-8?B?S2o3MUsxYm9TVFpRZUFLYTQzczBvTVRxalozK0gwODFCT2xNZy8zN2lnaFJq?=
 =?utf-8?B?OFhHSllaeHNvT2pxenY2NVo1enkyclpiMEtuUkwyWFFOL0VCbnNxcUgwdmZa?=
 =?utf-8?B?eEtwcDJFaG50bkt4VGxXZXI2cmd5N2JLa29pSlozcDllQUhncllGaXhlR0tL?=
 =?utf-8?B?VzZKa3hXTDlHVHNJQTZuSUpVcDV4VGNZejg0SXNYWjZCT0lIdDZUSUVUTDFq?=
 =?utf-8?B?SXJiaVBhZkdLVGE0amoxUWMvamRieFkvUTlsMkwvMXRzdDNTajRWdFA1QVEy?=
 =?utf-8?B?TzVtdHRtdmVkaENJdkIyMDYvVGlFZ3QxSWxqeDlTVFNwWFFYYk9Zc1dWUEVh?=
 =?utf-8?B?aDFJSzhqcGlyTVpUdmpXbzZ5a0x5VCtBM2pZN0cxeUhyYS9uSkpuRmw1a1Bx?=
 =?utf-8?B?NVIvSWp5bWI4Wk55M2d4REtKNmg0ZEdYckU4RlBUUDk2UitoeUFkajlMbEJP?=
 =?utf-8?B?MnIyWGozR3V3ekpzank2WFg0aHB1RDJvc3VoTjBkMWhTY0pJNndnWXFYVlRh?=
 =?utf-8?B?bkRjYm5MNzMrQXNaQmdUVzd6djIvZ0lyN0x6dFBYR1ExN2t4SGVrSVB0V1ky?=
 =?utf-8?B?NENWaFRqZzlWN2lta2ZMQWNOTGx4cGJray9VM1ZFZGo2NW5NNDdPb04xditU?=
 =?utf-8?B?d0ticzhRVTJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXE5ZTlPZng3OWYwVVlzdmtxbDh0cVJXbXQwRmRDYWZneWJkamI0VWEvYndQ?=
 =?utf-8?B?UysrZmlWQmZMQUhmQUM3QW9YQWI0UkdxbWwvNnlTbndaU1FOQzJHOU5JYTNt?=
 =?utf-8?B?UlZFS3owRjJmWEZxWklhV0hSblVGTEtVcUE4YVVUTDJ1bythUGNqbWRyZkRj?=
 =?utf-8?B?d1dtVXlEVkhLaXprQzA4NkUvKzM0MU1XWjB2WVNLYVlXczJWOXBGMVpVMkdj?=
 =?utf-8?B?ZUtCZ2kwc09WTUNBeU1Eb0R2NHg5anhJcnE5cWNySHNoZndnZVZYR0tlRE1C?=
 =?utf-8?B?NnQ4S0tjVjZ2TFZEeEhPMEd0dVZxcUN3U1ZvOXIxNE1TNFgySUVHTUtUYmc1?=
 =?utf-8?B?bDZsajhnRU1ZbHdUNlN0VlNBb3I4MnBGMWhOc1ZXa2J0aTZxRUpUWHRMM0Rx?=
 =?utf-8?B?SW1DTVRoU1h4c3M2eGhoV2xmUENUNEJ0bTRnSUFmYjRNdjdhS2JJOVE3MTE0?=
 =?utf-8?B?UC9CNXp2cnRwR1Qwb2xXa042ZThVNUV0VkY3V1hnQ3krekFnb1JNZmhaejBF?=
 =?utf-8?B?Z1Z6YzFpY25FY2gxanV4S3hSWjlnNXlDRmYxUk1mZTRMSFVpckFOWElXalhM?=
 =?utf-8?B?N2dQem0weGsrQkwvcENGY3R0VlcyWUNwOVZSdVhzUzkrWFhUYW8rRFk1cjZK?=
 =?utf-8?B?Z1VOVGJvVG5IMVFGR1o5cDhVVEtVb1lJUWNNWTR5UW5RbExOMzYxNnpiQ24v?=
 =?utf-8?B?R0Nodk9QZ3diazczOUpzRC9JdGJ5UUNQMlZ3UlBmYnlrZVpBVkZTcTQxcXNH?=
 =?utf-8?B?L0pzZ1h1OWZwd3I0RDdVQXArN0lwTWJkY3FjY3BXeFpjUXhXdGVUOGZiTkZH?=
 =?utf-8?B?QXhZY1grSGxiUk9weHkwU3JUQStSNFNUaXJlTzdJaTUxV1FwWlJVRTRidCtI?=
 =?utf-8?B?cXhHSnR5N01YbldFOVdTUzZyS0VFZ0QyaUNhVWFwanBEbi9BaEY2NFA5U2NU?=
 =?utf-8?B?eUNHSVA0aFFKVnNCSDdXU0FjcjRpNEhVM2NML3JxK2xOMytQR3lINlMzVFJp?=
 =?utf-8?B?bkJ5MzVNU09PREJDb2ZGcnIrZXJ2b1ZkaWZIMnZXb1RNM0tVOXN1cjErTFpx?=
 =?utf-8?B?K2xSV0tyaVNTc1RITjN3RWJ5K0ZUU3NSRmpleFJKa3g1RVZKeW1mNHNGSEVv?=
 =?utf-8?B?d3A5Sm9MQXJtMDNoNmtPSDJ2c1pVTE9vSXNaMHBOTHFRTVBXUkVBNXpRRC8x?=
 =?utf-8?B?TDRTaTRMRkFYL29UcVZPb1Z2alR5TTU3Yll3Z3g0aTFEWXVldmtoZ09Mb1dE?=
 =?utf-8?B?MnlNZ0c0b2FvbmhXN1FLamtNdFhyWWl4alF5S0kzTENQc24zZ0ZHekc1ZDdI?=
 =?utf-8?B?dHpCL3dYSm1COTYzUC9wNkZMY3hCZk9zQkJNK3JXMmpxQ3Jucy9odzNJRXB0?=
 =?utf-8?B?RU5kNkJuYXdOc1pyMlpJSmtUWVVzczlkOG5pdDN5cDAxZWR2aFZZeDNqMVBD?=
 =?utf-8?B?d0ZURWpwemF2dWU3ZGl0Qk5kWnQwQUFWc2U2MDN3eDJuMWJpc0htdCs1bVMw?=
 =?utf-8?B?dFJQVW5veXZWSUduclcxRi9LaGtGcEZQMnZxVjBmcy9LOUdCZjZlZ1NrM0o5?=
 =?utf-8?B?eTlDcnlGUCtibCs1ZThLY05DeGNVdFhUZi9iN25wRnMwRUV6cmtIWUgyMGgz?=
 =?utf-8?B?OWQzMmlwVU15U3VOYnpKbDB0K0V1ZmE2d05ESXIrUGg3UU1qWkVsOUhpTDkz?=
 =?utf-8?B?QlMyZy9tYnY3QjJRbHNPSSs4S2NrZW9nN3ZBYnM4ZTEzSm9YaTM1bTJrUzgv?=
 =?utf-8?B?QTJPakRocVk5Si9ibi9PU3ZCTWFLYTBXUEdaTDkyM3JMc2FERnpicjk1dzZF?=
 =?utf-8?B?ZSs0Rk84YndFUlZNWFJlSFprMnp1YzJjYXFnUmFyeEV2SnhMWEJlTFNVUGxQ?=
 =?utf-8?B?dnRHdlZmMXNWWCt2ZWNyTCtIZ1p0WjdVN1ZneG9kZjFvbFR4bmx3bTJTaTZt?=
 =?utf-8?B?QnpjRjNUbEcvZkx4QmFpcTJqQVRGUWNzcEJZTG91MlNydEpDYjJOWGxSbUtD?=
 =?utf-8?B?R2NYM1JQRTF3ZGN4V20vOWZsWkJaL09NOWRVOFdxSC80QUQ4aUtvYzM1MXNT?=
 =?utf-8?B?anJBcDUyTTRwUTZwVFY0SEZlSndPV1c2bzFUb3RSNzkrL2hjQmJkdHhpMHV1?=
 =?utf-8?Q?iAbH9WibnwhOcnzAqi6iGGT0K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b244c1b2-cad2-4c12-2f87-08dd863f2b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 10:26:42.1845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yF1/74DFs9wbocCIMAiOoDXJco/gNL4WHOwsfWtWIrU/Kxkjez8/cxWMbWEyrvfJwyeJ+AFkIa/+YHs03fcKomLWF+kfu3usVqXr83Zh6LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6332
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI4LCAy
MDI1IDM6NDEgUE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8
c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNv
bT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZl
cnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMu
aWQuYXU+OyBvcGVuDQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBv
cGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0K
PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDMvM10gaHcvYXJtOiBJbnRlZ3JhdGUgQXNwZWVkIE9UUCBtZW1vcnkgaW50bw0K
PiBBU1QxMHgwIGFuZCBBU1QyNjAwIFNvQ3MNCj4gDQo+IE9uIDQvMjMvMjUgMDQ6NTYsIEthbmUg
Q2hlbiB3cm90ZToNCj4gPiBGcm9tOiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggd2lyZXMgdXAgdGhlIE9UUCBtZW1vcnkgZGV2aWNl
IChgYXNwZWVkLm90cG1lbWApIGludG8gdGhlDQo+ID4gQVNUMTAzMCBhbmQgQVNUMjYwMCBTb0Mg
bW9kZWxzLiBUaGUgZGV2aWNlIGlzIGluaXRpYWxpemVkLCBhdHRhY2hlZCB0bw0KPiA+IGEgYmFj
a2luZyBibG9jayBkcml2ZSAoYC1kcml2ZSBpZD1vdHBtZW1gKSBhbmQgbGlua2VkIHRvIHRoZSBT
QkMNCj4gPiBjb250cm9sbGVyIHZpYSBhIFFPTSBsaW5rLg0KPiA+DQo+ID4gVGhlIGRlZmF1bHQg
T1RQIG1lbW9yeSBpbWFnZSBjYW4gYmUgZ2VuZXJhdGVkIHVzaW5nIHRoZSBmb2xsb3dpbmcNCj4g
PiBjb21tYW5kLg0KPiA+IGBgYGJhc2gNCj4gPiBmb3IgaSBpbiAkKHNlcSAxIDIwNDgpOyBkbw0K
PiA+ICAgIHByaW50ZiAnXHgwMFx4MDBceDAwXHgwMFx4ZmZceGZmXHhmZlx4ZmYnDQo+ID4gZG9u
ZSA+IG90cG1lbS5pbWcNCj4gPiBgYGANCj4gPg0KPiA+IFRvIGxvYWQgdGhlIE9UUCBtZW1vcnkg
aW1hZ2UgaW50byB0aGUgZ3Vlc3QsIHVzZToNCj4gPiBgYGBiYXNoDQo+ID4gLi9xZW11LXN5c3Rl
bS1hcm0gXA0KPiA+ICAgIC1kcml2ZSBpZD1vdHBtZW0sZmlsZT1vdHBtZW0uaW1nLGlmPW5vbmUs
Zm9ybWF0PXJhdyBcDQo+ID4gICAgLi4uDQo+ID4gYGBgDQo+IA0KPiBJIHRob3VnaHQgd2Ugd2Vy
ZSBnb2luZyB0byBpbXBsZW1lbnQgdGhlIHNhbWUgbWV0aG9kIG9mIHRoZSBlZGsyIGZsYXNoDQo+
IGRldmljZXMgb2YgdGhlIHEzNSBtYWNoaW5lLiBTZXR0aW5nIGEgbWFjaGluZSBvcHRpb24gd291
bGQgc2V0IHRoZSBkcml2ZSA6DQo+IA0KPiAgICBxZW11LXN5c3RlbS1hcm0gLU0gYXN0MjYwMC1l
dmIsb3RwbWVtPW90cG1lbS1kcml2ZSBcDQo+ICAgICAgICAtYmxvY2tkZXYNCj4gbm9kZS1uYW1l
PW90cG1lbSxkcml2ZXI9ZmlsZSxmaWxlbmFtZT0vcGF0aC90by9vdHBtZW0uaW1nIFwNCj4gICAg
ICAgIC4uLg0KPiANCj4gV2hpY2ggaXMgbm90IHdoYXQgaXMgcHJvcG9zZWQgYmVsb3cuDQo+IA0K
SSB1bmRlcnN0YW5kIHRoYXQgdXNpbmcgYSBtYWNoaW5lIG9wdGlvbiAoZS5nLiwgLU0gYXN0MjYw
MC1ldmIsb3RwbWVtPXh4eCkNCnRvIHNwZWNpZnkgdGhlIE9UUCBtZW1vcnkgZHJpdmUgaXMgc2lt
aWxhciB0byB0aGUgbW9kZWxpbmcgdXNlZCBmb3INCmZsYXNoIGRldmljZXMgaW4gdGhlIFEzNSBt
YWNoaW5lLiBIb3dldmVyLCBpbiB0aGUgcmVhbCBBU1BFRUQgaGFyZHdhcmUsDQp0aGUgT1RQIG1l
bW9yeSBpcyBwaHlzaWNhbGx5IHBhcnQgb2YgdGhlIFNlY3VyZSBCb290IENvbnRyb2xsZXIgKFNC
QykNCmFuZCBpcyBub3QgZGVzaWduZWQgdG8gYmUgcmVtb3ZhYmxlIG9yIHN3YXBwYWJsZS4gQWxs
b3dpbmcgdXNlcnMgdG8NCnNwZWNpZnkgdGhlIE9UUCBtZW1vcnkgdGhyb3VnaCBhIG1hY2hpbmUg
b3B0aW9uIG1pZ2h0IGltcGx5IG90aGVyd2lzZSwNCndoaWNoIGNvdWxkIGJlIG1pc2xlYWRpbmcg
Y29tcGFyZWQgdG8gdGhlIGFjdHVhbCBoYXJkd2FyZSBiZWhhdmlvci4NCg0KVGhhdCBzYWlkLCBp
ZiBtYWludGFpbmluZyBjb25zaXN0ZW5jeSB3aXRoIFFFTVXigJlzIGRldmljZSBtb2RlbGluZw0K
cHJpbmNpcGxlcyAoYXMgZG9uZSBmb3IgZmxhc2ggZGV2aWNlcykgaXMgcHJlZmVycmVkIG92ZXIg
c3RyaWN0DQpoYXJkd2FyZSBtb2RlbGluZyBmaWRlbGl0eSwgSSBhbSB3aWxsaW5nIHRvIGFkanVz
dCB0aGUgaW1wbGVtZW50YXRpb24NCmFjY29yZGluZ2x5Lg0KDQpDb3VsZCB5b3UgcGxlYXNlIGNv
bmZpcm0gaWYgeW91IHN0aWxsIHByZWZlciBmb2xsb3dpbmcgdGhlIGVkazIgZmxhc2gNCm1vZGVs
IGZvciBPVFAgbWVtb3J5LCBkZXNwaXRlIHRoZSBzbGlnaHQgbWlzbWF0Y2ggd2l0aCBoYXJkd2Fy
ZQ0KYmVoYXZpb3I/IE9uY2UgY29uZmlybWVkLCBJIHdpbGwgcHJvY2VlZCB3aXRoIHVwZGF0aW5n
IHRoZSBvYmplY3QNCmhpZXJhcmNoeSBhbmQgdGhlIG1hY2hpbmUgcHJvcGVydGllcyBhcyBkaXNj
dXNzZWQuDQoNCg0KPiA+IE5vdGU6IERvIG5vdCB1c2UgdGhlIC1zbmFwc2hvdCBvcHRpb24sIG9y
IE9UUCBkYXRhIHdyaXRlcyB3aWxsIG5vdA0KPiA+IHBlcnNpc3QgdG8gdGhlIGltYWdlIGZpbGUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jICAgICB8IDE5
ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MjYwMC5jICAgICB8
IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2Mu
aCB8ICAyICsrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDEweDAuYyBiL2h3L2FybS9hc3BlZWRf
YXN0MTB4MC5jIGluZGV4DQo+ID4gZWMzMjlmNDk5MS4uZWFhNzBmZWI5ZiAxMDA2NDQNCj4gPiAt
LS0gYS9ody9hcm0vYXNwZWVkX2FzdDEweDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0
MTB4MC5jDQo+ID4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPiAgICNpbmNsdWRlICJzeXN0ZW0vc3lz
dGVtLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvcWRldi1jbG9jay5oIg0KPiA+ICAgI2luY2x1ZGUg
Imh3L21pc2MvdW5pbXAuaCINCj4gPiArI2luY2x1ZGUgInN5c3RlbS9ibG9jay1iYWNrZW5kLWds
b2JhbC1zdGF0ZS5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L2FybS9hc3BlZWRfc29jLmgiDQo+ID4N
Cj4gPiAgICNkZWZpbmUgQVNQRUVEX1NPQ19JT01FTV9TSVpFIDB4MDAyMDAwMDAgQEAgLTE1Niw2
ICsxNTcsOCBAQA0KPiBzdGF0aWMNCj4gPiB2b2lkIGFzcGVlZF9zb2NfYXN0MTAzMF9pbml0KE9i
amVjdCAqb2JqKQ0KPiA+DQo+ID4gICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAi
c2JjIiwgJnMtPnNiYywgVFlQRV9BU1BFRURfU0JDKTsNCj4gPg0KPiA+ICsgICAgb2JqZWN0X2lu
aXRpYWxpemVfY2hpbGQob2JqLCAib3RwbWVtIiwgJnMtPm90cG1lbSwNCj4gPiArIFRZUEVfQVNQ
RUVEX09UUE1FTSk7DQo+ID4gKw0KPiANCj4gVGhpcyBiZWxvbmdzIHRvIEFzcGVlZFNCQy4gU2Vl
IGJlbG93Lg0KPiANCj4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2MtPndkdHNfbnVtOyBpKysp
IHsNCj4gPiAgICAgICAgICAgc25wcmludGYodHlwZW5hbWUsIHNpemVvZih0eXBlbmFtZSksICJh
c3BlZWQud2R0LSVzIiwNCj4gc29jbmFtZSk7DQo+ID4gICAgICAgICAgIG9iamVjdF9pbml0aWFs
aXplX2NoaWxkKG9iaiwgIndkdFsqXSIsICZzLT53ZHRbaV0sDQo+ID4gdHlwZW5hbWUpOyBAQCAt
MTk0LDYgKzE5Nyw3IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9zb2NfYXN0MTAzMF9yZWFsaXpl
KERldmljZVN0YXRlICpkZXZfc29jLCBFcnJvciAqKmVycnApDQo+ID4gICAgICAgRXJyb3IgKmVy
ciA9IE5VTEw7DQo+ID4gICAgICAgaW50IGk7DQo+ID4gICAgICAgZ19hdXRvZnJlZSBjaGFyICpz
cmFtX25hbWUgPSBOVUxMOw0KPiA+ICsgICAgQmxvY2tCYWNrZW5kICpibGs7DQo+ID4NCj4gPiAg
ICAgICBpZiAoIWNsb2NrX2hhc19zb3VyY2Uocy0+c3lzY2xrKSkgew0KPiA+ICAgICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJzeXNjbGsgY2xvY2sgbXVzdCBiZSB3aXJlZCB1cCBieSB0aGUgYm9h
cmQNCj4gPiBjb2RlIik7IEBAIC0zNTksNiArMzYzLDIxIEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVl
ZF9zb2NfYXN0MTAzMF9yZWFsaXplKERldmljZVN0YXRlICpkZXZfc29jLCBFcnJvciAqKmVycnAp
DQo+ID4NCj4gQVNQRUVEX1NNQ19HRVRfQ0xBU1MoJnMtPnNwaVtpXSktPmZsYXNoX3dpbmRvd19i
YXNlKTsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiArICAgIC8qIE9UUCBtZW1vcnkgKi8NCj4gPiAr
ICAgIGJsayA9IGJsa19ieV9uYW1lKEFTUEVFRF9PVFBNRU1fRFJJVkUpOw0KPiA+ICsgICAgaWYg
KGJsaykgew0KPiA+ICsgICAgICAgIGJsa19zZXRfcGVybShibGssIEJMS19QRVJNX0NPTlNJU1RF
TlRfUkVBRCB8DQo+IEJMS19QRVJNX1dSSVRFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAw
LCAmZXJyb3JfZmF0YWwpOw0KPiA+ICsgICAgICAgIHFkZXZfcHJvcF9zZXRfZHJpdmUoREVWSUNF
KCZzLT5vdHBtZW0pLCAiZHJpdmUiLCBibGspOw0KPiA+ICsNCj4gPiArICAgICAgICBpZiAoIXN5
c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5vdHBtZW0pLCBlcnJwKSkgew0KPiA+ICsg
ICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIC8qIEFzc2ln
biBPVFAgbWVtb3J5IHRvIFNCQyAqLw0KPiA+ICsgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
bGluayhPQkpFQ1QoJnMtPnNiYyksICJvdHBtZW0iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBPQkpFQ1QoJnMtPm90cG1lbSksDQo+ICZlcnJvcl9hYm9ydCk7DQo+ID4g
KyAgICB9DQo+ID4gKw0KPiANCj4gVGhlICJvcHRtZW0iIG1hY2hpbmUgb3B0aW9uIHNob3VsZCBi
ZSBwb2ludGluZyB0byAiZHJpdmUiIG9wdGlvbiBvZiB0aGUNCj4gQXNwZWVkT1RQTWVtU3RhdGUg
b2JqZWN0IGluIHRoaXMgb2JqZWN0IGhpZXJhcmNoeSA6DQo+IA0KPiAgICAvbWFjaGluZSAoYXN0
MjYwMC1ldmItbWFjaGluZSkNCj4gICAgICAvc29jIChhc3QyNjAwLWEzKQ0KPiAgICAgICAgL3Ni
YyAoYXNwZWVkLnNiYykNCj4gICAgICAgICAgL2FzcGVlZC5zYmNbMF0gKG1lbW9yeS1yZWdpb24p
DQo+ICAgICAgICAgIC9vcHRtZW0gKGFzcGVlZC5vdHBtZW0pICAgICAgICAgPC0gbW92ZSBvdHBt
ZW0gdGhlcmUNCj4gDQo+IFRoaXMgd2lsbCByZXF1aXJlIHVzaW5nIG9iamVjdF9wcm9wZXJ0eV9h
ZGRfYWxpYXMoKSBpbiAyIG9yIDMgbGV2ZWxzLg0KPiANCj4gICAgIG9iamVjdF9wcm9wZXJ0eV9h
ZGRfYWxpYXMoT0JKRUNUKHBhcmVudCksICJvcHRtZW0iDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE9CSkVDVChjaGlsZCksICJkcml2ZSIsICZlcnJvcl9hYm9ydCkNCj4gDQo+IFBs
ZWFzZSB0cnkgdGhhdCBpbnN0ZWFkIGFuZCBsZXQncyBzZWUgdGhlIHJlc3VsdC4NCj4gDQpJIHdp
bGwgbW92ZSB0aGUgb3RwbWVtIGFzIGEgY2hpbGQgYXMgdGhlIGFzcGVlZC5zYmMuIEZvciB0aGUg
Im9wdG1lbSIgbWFjaGluZSBvcHRpb24sDQpwbGVhc2UgaGVscCBjb25maXJtIHdoaWNoIG9uZSBp
cyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IuDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANClRo
YW5rcyBhZ2FpbiBmb3IgeW91ciByZXZpZXcgYW5kIGhlbHBmdWwgZ3VpZGFuY2UuDQoNCkJlc3Qg
UmVnYXJkcywNCkthbmUNCg==

