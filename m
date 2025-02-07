Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E61C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 02:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgE4i-0002DB-0e; Thu, 06 Feb 2025 21:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tgE4f-0002Ct-QM; Thu, 06 Feb 2025 21:26:33 -0500
Received: from mail-sg2apc01on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:200f::71e]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.yuan@jaguarmicro.com>)
 id 1tgE4d-00052o-GV; Thu, 06 Feb 2025 21:26:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc9G5XtmOj+xFUl48KY8VF9SNko6wV5H4HbyYiojnN4BwMDP8dWabuBIFjD4HfJYV1VmzYt/kf8p/QCekNvBmDygT1XH6elX2gKHtNefeH/p+7npbTr4gAZTSBj4vMdYmSpTxBdRpyjXrcQ2oLg/RpZ54YBFOo0RKgiYvSxQXypGmczep8IQpIMewUR5BDUolN8/tySdU7o521v15X4tVIM8Zyp/srySaQAADGuoOKzLaeHQ1C31agzhtC2iCnq6A0vU9S7puPPmiOzLww01Xmi/XWqOWZU4UeaigzyeWHO2/nOz3ofqx1EdK82Ra4F3VZvEpVZDXlW11Y76hIk2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKWh9OGpIzZfinVz5OBpUj6MNNyqt7CgCzulNQXuSiA=;
 b=gwz7RUe5YLwmNTYHnZioTsLkFInjGSGzz/qCtYYQ64h1+3I0UlroMQFlIWkbOZProDnHksp4Z3DnY3Kv+/K43X+93ruduzShdQVem/aY+YLpf27lpSvICdCFaL9EjCkYT2qQEYSHZb/iVI/dC5YXahxelUWnWl6eOdn3V4nXeKmzxfZ3sMv1UKsaMwhRL9NfgAcgCyQ0RfSGqgCPVvLAMjt561oZos//I78dh1Z56ZGSPy7QTNGElc6SJErkuI+3/cjiGz6ZxkfvxL1taULdHkS5s9uAW2vkSV8MTsWlcoUeM1y1UVKNhf2BO+R7UltegAEUBaCMH6/40V92hzcGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKWh9OGpIzZfinVz5OBpUj6MNNyqt7CgCzulNQXuSiA=;
 b=I1RV0k4Jtbbl+MSZVwohnEpXvj4qSqTzDdV84yVaYQ4OtxGpud+7JXgC91xS4aiE9VEmWfeQ0lcxcmA9xF/uFWCPg9a+pCduawyhcUrMcJV0UfoA+dHAWtVw30GuoWYBAI0iPgk+Ba/Z5YdEm788rsmnv1ygpWxo0rJ3Q+7XjGgOdSuokqN92Te8JcAIuOZBHu4bHsmAOc2cttqToRf+UVzhzSO3zipUwHaavEmQo3bJVF9tVSUhCeslQUeVIq7bgDy9Y+Rk/nC3jj7qF3ICcyJ7Mo0geRX7GSxjPlsoDyxCI0zUm37ixMS98SENo08W7VuCpNYZDOncLsbbXxuNyQ==
Received: from PSAPR06MB4888.apcprd06.prod.outlook.com (2603:1096:301:ac::6)
 by KL1PR0601MB5799.apcprd06.prod.outlook.com (2603:1096:820:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Fri, 7 Feb
 2025 02:26:17 +0000
Received: from PSAPR06MB4888.apcprd06.prod.outlook.com
 ([fe80::e46a:2bbb:7b01:1bf0]) by PSAPR06MB4888.apcprd06.prod.outlook.com
 ([fe80::e46a:2bbb:7b01:1bf0%4]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 02:26:17 +0000
From: andrew Yuan <andrew.yuan@jaguarmicro.com>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
CC: "philmd@linaro.org" <philmd@linaro.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjNdIGh3L25ldDogY2FkZW5jZV9nZW06IGZlYXQ6?=
 =?utf-8?B?IGFkZCBsb2dpYyBmb3IgdGhlIERJU0FCTEVfTUFTSyBiaXQgaW4gdHlwZTJf?=
 =?utf-8?B?Y29tcGFyZV94X3dvcmRfMQ==?=
Thread-Topic: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
Thread-Index: AQHbUd2kxzq5y1zzu0+ipfiWCOLV+7Mq7yEAgAU6nACAB1cUgIAD6gAQ
Date: Fri, 7 Feb 2025 02:26:17 +0000
Message-ID: <PSAPR06MB4888F9254618C8644FE8D3A8E3F12@PSAPR06MB4888.apcprd06.prod.outlook.com>
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
 <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
 <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
 <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4888:EE_|KL1PR0601MB5799:EE_
x-ms-office365-filtering-correlation-id: 99a30384-61f5-4e1c-d625-08dd471ecd07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmFJYXUzU1dDZnJWaVRtK3JDbFJFZHRLcmZ3UW83S1hzRUgzd0RNSFB3dzNK?=
 =?utf-8?B?Mnh2eUFCNjFIdk5nVWdrNmphSXZrTkpXaEJQUG4rZ1k4QnY5bHZmRlB0VzU5?=
 =?utf-8?B?ZmJlM3NZUVlZWEZMZHNWNGUxWDhYSzFjYytkTFlYQTdQTExIdHpTa2ZRMFh0?=
 =?utf-8?B?ZVdCOXE0eXcyNW5zaVlXYVI3UThTU0ZpcHhYY1NkSHdqUXYyZU1rYUE1bFN4?=
 =?utf-8?B?MU5nd0JpSmxhMHdUUHhOUkpPUEQ4NXRYSHlmaVBWbkg4M0FkZVhmSTd2RUpN?=
 =?utf-8?B?b2xGWEtPOVY1N3hYcWhsR1g1bTdXaWpkQktzVXhXS0JhL05FT2YzbytkNzFv?=
 =?utf-8?B?c3B0ZlNkcXQ1UERpUS9UTUtRT0I0MWFsYjVRWkM4VE5BaUZLVnh3SnJGVTRN?=
 =?utf-8?B?dmduMHNQeVVCdWFoYzA5bzJwUHZtQWxPODZzUldFNkRqQnpEY1lldC91Wlcv?=
 =?utf-8?B?TWVoaHFhZXZpZmUzWXd0dXd0Q1U5eDV0L1pTeWtWZC8xa3hreTlWazdLU3Vi?=
 =?utf-8?B?dFRGSll0aVhONkpKNUcwdmt0ZFhROHphMWpZVDFzcHdkMHhsQVc0QURkREM1?=
 =?utf-8?B?MHdqYkF5dFpQRXJuS0JYRUdTaWxNZ2IrbCtkZjM5ZTFxR0QzN2xVcnAvanpq?=
 =?utf-8?B?SGxZT09SaDh2RHpXa29CemxiNFNFeUwxR1lBNzNVSGhkbVkvZld4R3l1cmxv?=
 =?utf-8?B?dmREQ0ZxdERnTVN2TUxhejZldnNwNnB5UlgvaytIaGR6VkpuWVRzcC9ndkdS?=
 =?utf-8?B?eEIwdlBCVVNOSlF4ZkN6bUdNa2cxenJ4SGZmS1F0eVM0SHpUcVNMMFAwMTJl?=
 =?utf-8?B?SGp3aW5wSHJXdmZ5bEFvQmdqYm9vMkZxbCt4aFFIL2o2S1R3VFphSWhHYUdt?=
 =?utf-8?B?c2VGUkFhT3BWTHRVV3RTcGhKY1FibnRFMWJabmhzMFhkL05LK0krUnhROHNP?=
 =?utf-8?B?ZDhJc1NDdTdWd1BNdWdGZkhRQy94cGNvNjhMZktNRk5LVmVsZUJqTUlxSFR0?=
 =?utf-8?B?VXNqMzJVNHN6OFFibm9HOG1FczVpbEc3aTFEZWFCNnJHNWpQNVlnVUNmdjJk?=
 =?utf-8?B?UXZybnZ6Z2ZMUGxXK3Q5VDJCYTRiTnV3UkgySEtBRk03ajEvWWI2L3lES1NG?=
 =?utf-8?B?MmZZVjRGcHB3Y2xIWGFDdldPTGxPMDdEWjZOZmtiWHZSTjBWQ094NXZuRlh6?=
 =?utf-8?B?WUNTVHgvT1BYb0xwWkI5eHRVYndVQ2pFRVJSaGVSbTJvU0loaVZBZk40T3hl?=
 =?utf-8?B?eCtacFZ4UnYwclg2aUtsNnY0R2lmd0JjMWVkWVAzUjV3SjA5clVZMlQ1TmFQ?=
 =?utf-8?B?ekV5b3NqZXh0YnlNc0R2THMvNGttVDE5SlQvTmlxQ3d6dEZPcDhDSCtPTWIv?=
 =?utf-8?B?UDc0eDBwTGlnU0JnRzhNL0hja0xEbFRaeDVQOXRlRnBzYUlCRURYY0tGUGVu?=
 =?utf-8?B?dFdXa3R5T3FXdHZ4R0pSeU5KQ2IvZEpyUy83cFZmN0NVci85cEE3K3dnbkVV?=
 =?utf-8?B?aUNFUy9KTnkwbkM5REFPdlVPcVRpeEhERHNUS0NyRUVmc2pUWGdxNUh5SXFo?=
 =?utf-8?B?MmpVNVpHa1l1YW5HWmhsUEZKNElKeCttZ0dsVFFTczZ4STBVd3l1dUE3Lytp?=
 =?utf-8?B?bGdNandkak5aZzJHbXJqNnZScWJFbG9STlYxNXdOTDJrYWRFdnNzaFVtd0lr?=
 =?utf-8?B?ZmpaOFdyN0w1bGd5aHdVcTRzRG5hRDVrdzlyWG1VUjlseTFqL3B6UTRaeDBU?=
 =?utf-8?B?WVRPSnNSN3AxcGxZTnRpanE1SE83Q0RJb3crYW9GQmpMZHYxeEdOb21RZC8z?=
 =?utf-8?B?MURINzBVNlg4a00zVUtRZUlCVVlCaEtwNXk0dzFZWnh4M2g5RmZwVmF3czFi?=
 =?utf-8?B?NldmcWxFZ1gxNVZVbHBwMmRBaDdUTHpsMU5ZdGhlTGxnZ3NGdlJwMmw3V2Qz?=
 =?utf-8?Q?SFF+s8Fhveed/Zm1cjjrk4eqt+ErRdZp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PSAPR06MB4888.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGZETjhQWGhMWHlYRitoeXA4cXdXYzE3aG1McXk1TG9VN1hEdzFlOW9JSVFR?=
 =?utf-8?B?ZzdaUHY1RXZ1c2dJbVRYdWt4N3VZR0Z3WWRCbnUrRVdpS2pkQjhpWFNCQTR2?=
 =?utf-8?B?U2ZGYTIwUGdYNW1rZTNNL3VuY0JNRHVWK1VKN3c3UnlHZjVEMlliUG9YdDMr?=
 =?utf-8?B?OXY2ZDBLM01JQUVnejBYdGlSUERUZzZzNjJIRWFWMk93RTJJR2pHVE93ZXNv?=
 =?utf-8?B?NDZZNlA2THRmYnhQekRUR1N5NmE5UHdPTnFtT3NNU1VvN1VqcnVMSHpkeGFo?=
 =?utf-8?B?aXhyR3dvZTBuOUNTL09RSHlIdEtPNFJhTzVzQjZVd0VSRS8yQ1ltUkt4WGty?=
 =?utf-8?B?dFFIeUZGKzJxNThOTkFSU3R1dVh5Y0oyTmhtcHRXdXl5MHFxQ0VoN1Y4U29r?=
 =?utf-8?B?L2NWTS9JaEYyblFKVVZpOGNtK0U0WktzbWVlbHZabitrOFVSZldiaE42MGNi?=
 =?utf-8?B?bG5tUlVQbG5wTHpFU0psSVRCRk9jWTd6SWZsdFBLNzFBTG91QmdJRkYvWC9C?=
 =?utf-8?B?eFZJQkY1ck9Wc3VQWENzSFVKYzVLaVBwNlllSXZraVdZL0k2ZnVCeDZFTngw?=
 =?utf-8?B?MTRPaTIzSXF0dDVzYXMwUXl1NTBHMnI3dmVVRFpJRktiK2taYlVPZ05XK0JR?=
 =?utf-8?B?WnJxTVBvb2d2QlZ2NzRlWDl3UGYzKzA4V3grOUp2d1lXbU9WVkMvVm5qSjM1?=
 =?utf-8?B?eno2WVZtNk1adUozV3g3b2pwamh2NDk4SDRDZUVuYS9tQmtBZXNNV1prL0pa?=
 =?utf-8?B?aGdPaTdyWEV4cEorTGFTdFZadjVKVm9kTGRId1lJeU80T1E5QjdVaExJZE5P?=
 =?utf-8?B?NGNoYy9HQ1BOM3V1Vi9xVWNCTWxqSHJmcGJlSDdmaWx2R1IwaGFJWmVnNnAv?=
 =?utf-8?B?OWsxa1pDd2VQNWh6TElTUmtnaXhzUUhidVFhUFY2cCtRK3FhMFVoRitjc0hj?=
 =?utf-8?B?WlFKRWw5aTBkL1IxY2dSNUp6ZlczcDFLRFJlQVRDUDBGK29lRFZiUkJuT3Rz?=
 =?utf-8?B?TjJOU1pzeS8rbHBYS1Z6S3d2cFNuY3QwVnVtM3hpenhMRmJwNlkzREErd3ha?=
 =?utf-8?B?bEZ0SHVFUEU1VWM2ZWhkTEFCRmlrSlVUVFBxelQ0aVJCdlFHaUVTcVRCdzE5?=
 =?utf-8?B?aG5leVJpbVhMOFVkazRJSkpwSFNOQVllbmlIWWtHZ2NLaFlhWlMvVmJ3NUlx?=
 =?utf-8?B?VFZGWldNYjc2YVRoMU85cFpVM0xON0IxdXBDeHQzamxYOW9hbm5sZ2dZdXlq?=
 =?utf-8?B?MmsraUl2SUY5Syt1eHVkNWJreGpEM3FVelJHajMyTUlBYnpWQmlwR1lTV1Vi?=
 =?utf-8?B?cE15SDEzYSsrbDV4dENwb2xCbmNOZVF2ekxGZWRuWHN1MHpMRFd0aDhGQ0Uz?=
 =?utf-8?B?WUtBUDJuckozU1I4bHdaMHFPRU1WOWE2N0RiVHpybjViaUhDV0xSTjFEUk1H?=
 =?utf-8?B?VEpLeEhob2JvRURLSXQzYU5JZHMvV3JDT1JWd2VzODRFVFRtT3k1WWxpYWt3?=
 =?utf-8?B?ejd0cUdwYUY0TVQ1dUI3WUFYZ25OQ0ZlVTdPbXZ5M2wzWnFwUjE2MmJrVDJs?=
 =?utf-8?B?VW12aFF5K0hVdVovelJIbEQxZnRDRVIxMGYxdVdjYXhMZjluMEFReVllbG91?=
 =?utf-8?B?UndUcDZETEU0SVNKdllrbmVOTnNlYVBIcEVvOEhXTTRkZVFiY0J2WkJuY0JG?=
 =?utf-8?B?M3RKN1hRWnBwNC9qcUtRNWU2cW8yU2d1T3ozelNKcHBKdUpsSUNIK2ptSDBW?=
 =?utf-8?B?NnQ0dGdRLzNYMHROMHJjYkhESWpTYlNjQlkzRlhMRmdOOUVlTzZkODE1QjFu?=
 =?utf-8?B?bHhkNFNQUGJqNDdORlNKc0ZvMm9zamt4d0tNWmlWL3M0Sm1BUWQwM2plSEph?=
 =?utf-8?B?d3hIUlEzeU8xWkhMbk80M0JxRkMxSVBoOGRsRkpHNlllL3pNTFExQ3preG5N?=
 =?utf-8?B?di9iL0h2Tk5HVnJvalVJRldKa3RueGU1Q1U4UUhYOHUxd2cva2Vqb05FOC9B?=
 =?utf-8?B?Q0l4MzhOR0s5U2FReEs0WVJldUZGczFwVHF2ZVcwS2xrVlFwaDdUOTJSb0JS?=
 =?utf-8?B?aXNSR2FyNWwrdU5CVExxT3EzZ3ZFeGI1YlJMMVRNbVovWnNSWnAzU1ZGT3B6?=
 =?utf-8?Q?ypLx0rAVsBe9OZ3m9kDcQcxXN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4888.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a30384-61f5-4e1c-d625-08dd471ecd07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 02:26:17.0858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFMprXPQF3UaV/WinOUS3bjrD14Pw3spnCZedFqXDs6d6PEc2NyoLxSg1fV7NSLbSGt5FFPLsCEwyzod8ng672iEZi8fshvgzbOuBC7IhSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5799
Received-SPF: pass client-ip=2a01:111:f403:200f::71e;
 envelope-from=andrew.yuan@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

T24gVHVlLCA0IEZlYiAyMDI1IGF0IDIyOjM3LCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc+IHdyb3RlOg0KPiBPbiBUaHUsIDMwIEphbiAyMDI1IGF0IDIyOjMxLCBFZGdh
ciBFLiBJZ2xlc2lhcyA8ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBN
b24sIEphbiAyNywgMjAyNSBhdCA4OjQw4oCvQU0gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPiB3cm90ZToNCj4gPj4gT24gVGh1LCAxOSBEZWMgMjAyNCBhdCAwNjoxNywg
QW5kcmV3Lll1YW4gPGFuZHJldy55dWFuQGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6DQo+ID4+ID4g
LSAgICAgICAgICAgIHJ4X2NtcCA9IHJ4YnVmX3B0cltvZmZzZXRdIDw8IDggfCByeGJ1Zl9wdHJb
b2Zmc2V0XTsNCj4gPj4gPiAtICAgICAgICAgICAgbWFzayA9IEZJRUxEX0VYMzIoY3IwLCBUWVBF
Ml9DT01QQVJFXzBfV09SRF8wLCBNQVNLX1ZBTFVFKTsNCj4gPj4gPiAtICAgICAgICAgICAgY29t
cGFyZSA9IEZJRUxEX0VYMzIoY3IwLCBUWVBFMl9DT01QQVJFXzBfV09SRF8wLCBDT01QQVJFX1ZB
TFVFKTsNCj4gPj4gPiArICAgICAgICAgICAgZGlzYWJsZV9tYXNrID0NCj4gPj4gPiArICAgICAg
ICAgICAgICAgIEZJRUxEX0VYMzIoY3IxLCBUWVBFMl9DT01QQVJFXzBfV09SRF8xLCBESVNBQkxF
X01BU0spOw0KPiA+PiA+ICsgICAgICAgICAgICBpZiAoZGlzYWJsZV9tYXNrKSB7DQo+ID4+ID4g
KyAgICAgICAgICAgICAgICAvKg0KPiA+PiA+ICsgICAgICAgICAgICAgICAgICogSWYgZGlzYWJs
ZV9tYXNrIGlzIHNldCwNCj4gPj4gPiArICAgICAgICAgICAgICAgICAqIG1hc2tfdmFsdWUgaXMg
dXNlZCBhcyBhbiBhZGRpdGlvbmFsIDIgYnl0ZSBDb21wYXJlIFZhbHVlLg0KPiA+PiA+ICsgICAg
ICAgICAgICAgICAgICogVG8gc2ltcGxlLCBzZXQgbWFzayA9IDB4RkZGRkZGRkYsIGlmIGRpc2Fi
bGVfbWFzayBpcyBzZXQuDQo+ID4+ID4gKyAgICAgICAgICAgICAgICAgKi8NCj4gPj4gPiArICAg
ICAgICAgICAgICAgIHJ4X2NtcCA9IGxkbF9sZV9wKHJ4YnVmX3B0ciArIG9mZnNldCk7DQo+ID4+
ID4gKyAgICAgICAgICAgICAgICBtYXNrID0gMHhGRkZGRkZGRjsNCj4gPj4gPiArICAgICAgICAg
ICAgICAgIGNvbXBhcmUgPSBjcjA7DQo+ID4+ID4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4+
ID4gKyAgICAgICAgICAgICAgICByeF9jbXAgPSBsZHV3X2xlX3AocnhidWZfcHRyICsgb2Zmc2V0
KTsNCj4gPj4NCj4gPj4gSXMgdGhlIGNoYW5nZSBpbiBiZWhhdmlvdXIgaW4gdGhlICFkaXNhYmxl
X21hc2sgY29kZXBhdGggaGVyZQ0KPiA+PiBpbnRlbnRpb25hbD8gUHJldmlvdXNseSB3ZSB1c2Ug
b25lIGJ5dGUgZnJvbSByeGJ1Zl9wdHJbb2Zmc2V0XSwNCj4gPj4gZHVwbGljYXRlZCBpbnRvIGJv
dGggaGFsdmVzIG9mIHJ4X2NtcDsgbm93IHdlIHdpbGwgbG9hZCB0d28gZGlmZmVyZW50DQo+ID4+
IGJ5dGVzIGZyb20gcnhidWZfcHRyW29mZnNldF0gYW5kIHJ4YnVmX3B0cltvZmZzZXQgKyAxXS4N
Cj4gPj4NCj4gPj4gSWYgdGhpcyBpcyBpbnRlbmRlZCwgd2Ugc2hvdWxkIHNheSBzbyBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQo+ID4+DQo+ID4NCj4gPiBJIGFncmVlIHRoYXQgaXQgc2hvdWxkIGJl
IG1lbnRpb25lZCAobG9va3MgbGlrZSBhIGNvcnJlY3QgYnVnZml4KS4NCj4gDQo+IFRoYW5rcy4g
SSd2ZSBleHBhbmRlZCB0aGUgY29tbWl0IG1lc3NhZ2U6DQo+IA0KPiAgICAgaHcvbmV0L2NhZGVu
Y2VfZ2VtOiAgRml4IHRoZSBtYXNrL2NvbXBhcmUvZGlzYWJsZS1tYXNrIGxvZ2ljDQo+IA0KPiAg
ICAgT3VyIGN1cnJlbnQgaGFuZGxpbmcgb2YgdGhlIG1hc2svY29tcGFyZSBsb2dpYyBpbiB0aGUg
Q2FkZW5jZQ0KPiAgICAgR0VNIGV0aGVybmV0IGRldmljZSBpcyB3cm9uZzoNCj4gICAgICAoMSkg
d2UgbG9hZCB0aGUgc2FtZSBieXRlIHR3aWNlIGZyb20gcnhfYnVmIHdoZW4NCj4gICAgICAgICAg
Y3JlYXRpbmcgdGhlIGNvbXBhcmUgdmFsdWUNCj4gICAgICAoMikgd2UgaWdub3JlIHRoZSBESVNB
QkxFX01BU0sgZmxhZw0KPiANCj4gICAgIFRoZSAiQ2FkZW5jZSBJUCBmb3IgR2lnYWJpdCBFdGhl
cm5ldCBNQUMgUGFydCBOdW1iZXI6IElQNzAxNCBJUCBSZXY6DQo+ICAgICBSMXAxMiAtIERvYyBS
ZXY6IDEuMyBVc2VyIEd1aWRlIiBzdGF0ZXMgdGhhdCBpZiB0aGUgRElTQUJMRV9NQVNLIGJpdA0K
PiAgICAgaW4gdHlwZTJfY29tcGFyZV94X3dvcmRfMSBpcyBzZXQsIHRoZSBtYXNrX3ZhbHVlIGZp
ZWxkIGluDQo+ICAgICB0eXBlMl9jb21wYXJlX3hfd29yZF8wIGlzIHVzZWQgYXMgYW4gYWRkaXRp
b25hbCAyIGJ5dGUgQ29tcGFyZSBWYWx1ZS4NCj4gDQo+ICAgICBDb3JyZWN0IHRoZXNlIGJ1Z3M6
DQo+ICAgICAgKiBpbiB0aGUgIWRpc2FibGVfbWFzayBjb2RlcGF0aCwgdXNlIGxkdXdfbGVfcCgp
IHNvIHdlDQo+ICAgICAgICBjb3JyZWN0bHkgbG9hZCBhIDE2LWJpdCB2YWx1ZSBmb3IgY29tcGFy
aXNvbg0KPiAgICAgICogaW4gdGhlIGRpc2FibGVfbWFzayBjb2RlcGF0aCwgd2UgbG9hZCBhIGZ1
bGwgNC1ieXRlIHZhbHVlDQo+ICAgICAgICBmcm9tIHJ4X2J1ZiBmb3IgdGhlIGNvbXBhcmlzb24s
IHNldCB0aGUgY29tcGFyZSB2YWx1ZSB0bw0KPiAgICAgICAgdGhlIHdob2xlIG9mIHRoZSBjcjAg
cmVnaXN0ZXIgKGkuZS4gdGhlIGNvbmNhdGVuYXRpb24gb2YNCj4gICAgICAgIHRoZSBtYXNrIGFu
ZCBjb21wYXJlIGZpZWxkcyksIGFuZCBzZXQgbWFzayB0byAweGZmZmZmZmZmDQo+ICAgICAgICB0
byBmb3JjZSBhIDMyLWJpdCBjb21wYXJpc29uDQo+IA0KPiBhbmQgYWxzbyB0d2Vha2VkIHRoZSBj
b21tZW50IGEgYml0Og0KPiANCj4gKyAgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAg
ICAgICAqIElmIGRpc2FibGVfbWFzayBpcyBzZXQsIG1hc2tfdmFsdWUgaXMgdXNlZCBhcyBhbg0K
PiArICAgICAgICAgICAgICAgICAqIGFkZGl0aW9uYWwgMiBieXRlIENvbXBhcmUgVmFsdWU7IHRo
YXQgaXMgZXF1aXZhbGVudA0KPiArICAgICAgICAgICAgICAgICAqIHRvIHVzaW5nIHRoZSB3aG9s
ZSBjcjAgcmVnaXN0ZXIgYXMgdGhlIGNvbXBhcmlzb24gdmFsdWUuDQo+ICsgICAgICAgICAgICAg
ICAgICogTG9hZCAzMiBiaXRzIG9mIGRhdGEgZnJvbSByeF9idWYsIGFuZCBzZXQgbWFzayB0bw0K
PiArICAgICAgICAgICAgICAgICAqIGFsbC1vbmVzIHNvIHdlIGNvbXBhcmUgYWxsIDMyIGJpdHMu
DQo+ICsgICAgICAgICAgICAgICAgICovDQo+IA0KPiBhbmQgYXBwbGllZCB0aGlzIHRvIHRhcmdl
dC1hcm0ubmV4dC4NCj4gDQo+ID4gT3RoZXIgdGhhbiB0aGF0IHRoaXMgcGF0Y2ggbG9va3MgZ29v
ZCB0byBtZSENCj4gDQo+IENhbiBJIGNhbGwgdGhhdCBhIFJldmlld2VkLWJ5ICh3aXRoIHRoZSBh
Ym92ZSBjaGFuZ2VzKT8NCg0KWWVzLCBUaGFua3MgZm9yIHlvdXIgdGltZTsNCg0KPiB0aGFua3MN
Cj4gLS0gUE1NDQo=

