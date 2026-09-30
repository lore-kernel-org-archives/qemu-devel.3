Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D296CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpJU-000282-QG; Wed, 30 Sep 2026 04:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBpJS-00027U-Qs; Wed, 30 Sep 2026 04:05:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBpJQ-0006Xn-KW; Wed, 30 Sep 2026 04:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnDGUyzKnkY2DExJncPxTKgSU6MstUwXw15gGUKYCoNq9Y3WLhSqsKktJgGmbFUG1wxZ6knmV7xryIBWvFtH5rHH4mOHC36ngqS/11sd/oBhJDOpArkhCjcDG5tgXHVvOSN5A3lrJp0Nh3uv+XYnuHsQQSrYBowrSA89a+1yZqPv8y45qxki/4VbkZkH8vqHuYuyMgf0/01tw5Aiesss0mvn6LbqZmmpNSd04cUYp3FDidQN+W+1o1DUseunPe98Q+YAAmhNCrCCnPpd0SHQ4PDaSnRLjHgNFxiZ03XksCBSVCETvJZuYmNvBP+RkvRhamlxeF69l+I4VXcrbIqe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smsi656448K970eIB6IIzzATNnRPFTnV3MMud6BgG1o=;
 b=GrT9CujtThSdJ8LDO5aMGGqdbeE7ME1301uNMWUS8ZvwykG3grUL8Qb4863bPaQJY0upJdaCJTMU5raaGgTMBYsy8ZP3mF2PgVyrEIvOuG1NlvjvccqqhcU62jgtmYjyqd21C/eZFnqEzNNlR6Mg8YdAHw6hSeZ371/R3FOJPnwNVV5M5nz96qtVDDsT/NOL8zpkuVNaoR8Gh6COChFbqgHXlOJUlwtpj1MFBOdF+r7BDm2177jUP9S+EtJ43mn2XcCbP2QD8qG/VmzmQr8ywW/TtPhteBwpDKtphAOXOqxnjhg/XWJTK5lc+XeidFxQeBHeqDPtOVL2jvG007BZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smsi656448K970eIB6IIzzATNnRPFTnV3MMud6BgG1o=;
 b=grD+3E4X7aK3R5DsJcd1KAhId0V/rFiuwSOYaOK2M7JAOM7DN2GkrPsy8LKRwsMJ4X7DAYKlsZZrLvpUa229yCmhmDbZZskeCrEXXeItGbrqv6622hAmhOhqp1rSR4U1xlTfYCm24ty9ube+9z6dqzPN0JktWM3pk807o8BH00TdmucN2CUTEGipt9Wdcb3G0+AcDb9g/euxuZ9+lqruIk+gIGpq6/4q4lW+looBysnTsHs2anpaWWKBxg8f+JS/qe74GVmIPy+mnhkd4euXw9kjnEnH4+k/CNx2sSELzK+q8qqLzDs9/OSBbHieosIggaZDskUKnhzN0o+d/TNyOg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8944.apcprd06.prod.outlook.com (2603:1096:d10:88::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 08:05:04 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 08:05:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, 
 "clg@redhat.com" <clg@redhat.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
Thread-Topic: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
Thread-Index: AQHdSnEERPamrUtxCUGTRaU5xPzZPrbmyiMQgAAEIQCAAAGJMA==
Date: Wed, 30 Sep 2026 08:05:04 +0000
Message-ID: <SEZPR06MB736216B99A28F03C48299E31FC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
 <SEZPR06MB7362735328EE335AB120EC9CFC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
 <c5895718-877f-4027-91cb-e1e5b84f3e02@kaod.org>
In-Reply-To: <c5895718-877f-4027-91cb-e1e5b84f3e02@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8944:EE_
x-ms-office365-filtering-correlation-id: c2f171e0-a372-4e34-990c-08df1ec9891c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|921020|38070700021|15866825006;
x-microsoft-antispam-message-info: sWcSILdOQ3indYX/SSGPBGFc7o6fa3m9BRgWJCUTg62ALYYxgxjCeoj+1MS9D+Y2gnSPIt1FoNDbsMpMHMwvbBHjO5g04XMbgAEnUYzyvCpAApiccnq8U5WhAiJ4jPyCApNcOd3CkDVgOTwzr+Ja+YGIWXgkNH+7L755QKAe2AtBp188J1BLOnnxORe0O7meuN2jgvT813apfQm+Jwum9I4ECXkGc8nxPgRt5JpjwMVyZFsy7ILLPIyeLsS3ZB9YNr4wR2zgH7CsXN0ePvLxIHfOI+CD0xLNr5WS2Cw9yN05SQOfs5qN99CYdEv+ycwp0HtaOQ0jv1wohDzuhmZoFS4Gc+zk27YTJS7y4VB6BSpFEFnO0nDXPdOTb/HLpJjE7bX6BlGSq1fsm0T5g2zYrE1BbZXCvmXUkzE8oCp1X5rl+AjOU4GMMAj7kXOu2sJD1MXhGH+dYMMNqyfSmzxEStX26lRR2Uuzc1184FHLxMaUEylrpJN+jEtjQCjGS57pEmN9F/Z0dspuDYwQXhUbYVnNphLX3PHowrMvk6aMLQMeRkq4K6Tn/bQBkiLk1+MKqiOxx/0GUSwVkpdLecuft0M36fdQet+CTY5MsOX3c84UYY0IN+gICnXmTEeKdHmuSAzNYfbuqVHJ4dyHozFcWyC9+PUtybsND+uttCV8XetzB2D0dKXaldyuM1DwTjB4+U01HlHz6lY0QpdmSzyu4QvSG4UlJie1nZt0IChUdS8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(921020)(38070700021)(15866825006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1lHN2g5TEpNdWhtU2dobHZpSW1NUnFFR2tLby8ydHpDNTE1N1RYR1RUSEpF?=
 =?utf-8?B?Z3BiNEFlVVVDWFVrTWRLUUR4L3VVS2t2Q1ltOGc4UVVUL3FBckljRVNTeHlk?=
 =?utf-8?B?aXpGemE2VldReGNXUU1uM0k0VXlsaFJkVW90c2FjbDlRUHFKQTNTMWhIZHVG?=
 =?utf-8?B?TGtCZDlsQk94M2JzV01YdmJ6WVdxQm5lY1J3OU42LzRNemNHSFJQd3VKcWFm?=
 =?utf-8?B?MklzTFFDaEIvbEdEUTZkT2xhUlVaUlFaMEsyR21ncERIR3V1cXFQaDJrei9k?=
 =?utf-8?B?ci9YOHVuRzRxY0Z6cy9XK1lEcTBSTGpCN25LOGRuekJZN0s3TnFIM0twMWJa?=
 =?utf-8?B?anVQeFV5a09rejZmcmEwQitOVWkyMDNJeU5rd3FyaGVoSzRQQVQ3MW1DYm5o?=
 =?utf-8?B?VHM1MnNkMG55cGRGL0J0MUkwZmZxdE16Z0I1bXExVFhTSkhqSVRJOEp6emg1?=
 =?utf-8?B?dXdlMytKWVBHVHBXcHFmdzd1eFJKVHJyelB2bllyZndqTDVDR1NtUnFVVDQv?=
 =?utf-8?B?bDY5V2w2dy9ZRXNIMmRQMmZMVHpMdjVGVVhIUDlrSkd1MFFkdnE5dkNhdVpX?=
 =?utf-8?B?d0Jka2t5bCt1MGNkc01DZm8veVJLQVJ1Mm5SektDSm9iZ1BjRUgraFNvZml5?=
 =?utf-8?B?Q3haSElDZUYvVFZWNnU2UTZNRG9mVGVzdU0xN3RlWG5rRHRpL3I5OVc0R00z?=
 =?utf-8?B?TTFCbysrUDdrd08ydE5naHg2QlRZTEhMK1ZueVN1TUtUYVR3aTZOSlpDK3N0?=
 =?utf-8?B?cFNta2tPdy9Zd0lCbEkvTitZdTkxb01IUHl6T2J3THZHcWVMN1hoTGF0Y1R5?=
 =?utf-8?B?T09jQTBIUVBvSGl5TGVvM2FIdWZ4bmdJNFB5RjBWOEJ3SStDbDFlRmxnQXk5?=
 =?utf-8?B?T3g0UUxCNDhZcEJqckxGdjk5RlIyRnNvOW10Q3UyVjJTSitPcVFIM1dWbnlV?=
 =?utf-8?B?VEZMZHA4cE5lMURZbFBFNy8xbCtEUTM2RXlWYXJ0aVVUcUhCWVFUYmtwM0c1?=
 =?utf-8?B?UzlydGVVRi9CY1dpdm5kNnZvRCt0U3gyZ0VBaXl3Z016ZFo0WXdIZ3F3MlYv?=
 =?utf-8?B?aWg4RHVZQ3k0MStSSFh1Z1N1LzMwY0ZMalNkS1o1OWR6cE5YZHVVa240WW0w?=
 =?utf-8?B?cUZKT3ozemlqYzhqaktYOFoxNkRaV0NYTFQxMmE3T3pIT0ttejE3aGFOYnVM?=
 =?utf-8?B?b0JwUzd1NFZaMldHMTFYdTZUOHN5TDEzNVlRSzA4SnZsV05JcWFLRy9iOENZ?=
 =?utf-8?B?TmJrRGpsbCtlYko4L0NuWUE3L1NzTHg5a2wyL2dQeVdqQk14Rno3Nk0wOHMy?=
 =?utf-8?B?bHRsU1BhVTB1WFdTQ3hyV2lVcC8wTHBxa1ZEMjlrb0VxWkRUUnhhL3ZIb3RN?=
 =?utf-8?B?RW9ZY2xaSktkL2JCa2lqd1lhN2E1U2hjSmRnZ2YvMUlLL1hSamFKQzR3VTFi?=
 =?utf-8?B?ZEZQVmNkbFo2NWs5cEdMemJKVUs3VnZ6eHFnV3hTNGM3dVE3NTNISDV0SU5q?=
 =?utf-8?B?Unp5UzFDWktBWVRvM05zZndsSUcxc1JOMnFhc2N0K2lZS1NTQ1kwUnZrbEhP?=
 =?utf-8?B?am9GcVlrYnZ4L2JLVnlWbXhheGRoVFIwTFQ4SDUxL2xCMzhFZEVSd3Y2emky?=
 =?utf-8?B?QXV3VFNEdmorQmxqaHVRc2JRdDJINkhrQmVuZkp1YUxCQ2xob3hzYWpNMUhi?=
 =?utf-8?B?QTA0YlhlY0ozVHhyOVZBOS8zbkVkS1VLQW1aRW55cHNPalp4K05JdmlZMFVx?=
 =?utf-8?B?QmwxVFJMZnh4ZTZGRS9GL0loVmRGa0NacElVUzBxczgwQlAraGN1NWVHREJu?=
 =?utf-8?B?NTYxeWg5MDhkeW4rKzRJZTdScHFmcm9QcStzVnd4UTlHczJEY2szS0xib29r?=
 =?utf-8?B?TTVsandxejJiV0Q3Q3JtMWlwMWdQbThYcG9MLzUyKzJBUzlZZzRrOG0wdStp?=
 =?utf-8?B?Q2NRSlR2bG9VZEdJR0E0azNkQzd0TVdldmtvTEFlOFpINjh4UjVqZEJZbEtz?=
 =?utf-8?B?SzJ3N09TR1FsTEQzZFNIRS90dVZocEVXOXZ0TTlIRm5RdlpQanZRLzZlNEhF?=
 =?utf-8?B?NFFnUllMVWhtSUZDM3pVRTl4cmVqZ05vMi9QcWZrZGpOcWZ6QnhsUWFVQllV?=
 =?utf-8?B?UFgvVXZWY3lOalIzcUI0Q1REU0ptSWJiVSt3aXFuWC9HKzBTVGk5TEppYjJC?=
 =?utf-8?B?NlQzN2kra2pkdnZ0bTZFdWtFTm84a25wVlJZRUZaSUk2ZlVOYUMrdGh3UnF2?=
 =?utf-8?B?SXJPN2FLUU1XbStDSFVTV3lHSTlYZnEvTTVqQUV3clcyeW84OUNpancvOTMv?=
 =?utf-8?B?RFRRd2FISm8yUFNpNDlZM3ZtZHZtajNkSHFFamMwSzRSek5EbzJBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NCRDNcqz3rTcE0dtH9R+hJh/0Xmov6PaXi0g18MAScgXxXc/y9UH7Uu1BKhQ31kqf8GWgEqjH5kt41SJJMLorOmvy9HW1KXbzxsgT7m9LcxUrk6W+0pCTIPSHj3djXvOt/aOKTaCFwl10jUL37Rbpae6atoPo9mhj7gUzPlfa2dBv5NqiF/815dlgGSIB9k49IqH0Q3vYBkF5ZSDsAtU7Xi7rQNF9uXIR2isQHNq0/AVDcoCdyDaiiBlMhmr3E+jc+as/MzMoTWRBsOGa8n3LdMdXvi0eGrOWJcXN0eTwuaqcVaiGDi+lu7L5MIsT4iTB4alnCzqyr7zewxjtcvNEQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f171e0-a372-4e34-990c-08df1ec9891c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 08:05:04.6973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFGUBnRTGk4RMjeYNMD5TK5epXl67WVS6BiE9NFXkXCEi+SVs1NZLnTrwudZ+SlCtZHyqNhVjrboeiOD0csV7rUXk0cKW6TpstLByRa+6uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8944
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0KDQpJIHdpbGwgc3Bs
aXQgdGhlIHNlcmllcyBpbnRvIEFTUEVFRCBhbmQgVVNCIHBhcnRzIGFzIHN1Z2dlc3RlZC4NCg0K
SSB3aWxsIGFsc28gdGFrZSBhIGxvb2sgYXQgdGhlIE1pbmVydmEgc2VyaWVzIGFuZCBzZWUgd2hl
cmUgSSBjYW4gaGVscCB3aXRoIHRoZSByZXZpZXcuDQoNClRoYW5rcywNCkphbWluDQoNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAwMC8xOV0gaHcvdXNiOiBBZGQgYSB1c2JyZWRpciBzZXJ2ZXIg
dHJhbnNwb3J0IGFuZA0KPiBBU1QxMDMwIFVEQyBzdXBwb3J0DQo+IA0KPiBIZWxsbyBKYW1pbiwN
Cj4gDQo+IE9uIDkvMzAvMjYgMDk6NDgsIEphbWluIExpbiB3cm90ZToNCj4gPiArIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3NzLnF1YWxjb21tLmNvbT4gQ8OpZHJpYyBMZSBHb2F0
ZXINCj4gPiArIDxjbGdAcmVkaGF0LmNvbT4NCj4gDQo+IEkgaGF2ZSBzZWVuIGl0IDopDQo+IA0K
PiBXaGF0IHdvdWxkIGhlbHAgaXMgdG8gc3BsaXQgdGhlIHNlcmllcyBpbiB0d28gOiBBc3BlZWQg
YW5kIHVzYi4NCj4gVGhlIEFzcGVlZCBwYXJ0IGNvdWxkIGJlIHJldmlld2VkIGJ5IHRoZSBBc3Bl
ZWQgcmV2aWV3ZXJzOiBTdGV2ZW4sIFRyb3ksDQo+IEthbmUsIEFuZHJldywgSm9lbCBhbmQgbWUu
IEkgYWxyZWFkeSBkaWQgcXVpdGUgYSBsb3QgaW4gdGhpcyBRRU1VIGN5Y2xlLCBzbw0KPiBzdGVw
cGluZyBiYWNrIGEgYml0IGZvciBub3cuDQo+IA0KPiBJZiBhbnkgb2YgdGhlIEFzcGVlZCBlbXBs
b3llZXMgbWVudGlvbmVkIGFib3ZlIG5vIGxvbmdlciBoYXZlIHRpbWUgdG8NCj4gcGVyZm9ybSBy
ZXZpZXdzLCBwbGVhc2UgcmVtb3ZlIHRoZW0gZnJvbSB0aGUgbGlzdC4gQUZBSUNULCBvbmx5IHlv
dSBhbmQgS2FuZQ0KPiBhcmUgYWN0aXZlLg0KPiANCj4gUGhpbGlwcGUgaXMgb3VyIGpva2VyIDop
IERvbid0IHB1dCB0b28gbXVjaCBvbiBoaW0sIGhlIGRvZXMgYW4gYXdmdWwgbG90DQo+IGFscmVh
ZHkgIQ0KPiANCj4gVVNCIGlzIHdpdGhvdXQgYSBtYWludGFpbmVyLiBJdCBpcyBiZXN0IHRvIGFk
ZHJlc3Mgb25jZSBhbGwgdGhlIHJlcXVpcmVkDQo+IGluZnJhc3RydWN0dXJlIGlzIG1lcmdlZC4N
Cj4gDQo+IA0KPiANCj4gSGVyZSBpcyBhIHNlcmllcyB0aGF0IHdvdWxkIHJlcXVpcmUgYXR0ZW50
aW9uDQo+IA0KPiAqIFtQQVRDSCAwMC81MF0gQXNwZWVkOiBJMkMgZGV2aWNlIG1vZGVscyBhbmQg
dGhlIE1pbmVydmEgQk1DIG1hY2hpbmUNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyNjA5MDctYm1jLW1pbmVydmEtdjEtMC0wZDgzYWQ2MTBjMw0KPiBiQGZyZWUu
ZnIvDQo+IA0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

