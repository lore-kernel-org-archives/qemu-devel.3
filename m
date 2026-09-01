Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AD0C624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1GyN-0002SL-BY; Tue, 01 Sep 2026 01:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1GyJ-0002Rb-60; Tue, 01 Sep 2026 01:23:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1GyG-0005rc-6f; Tue, 01 Sep 2026 01:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788240224; x=1819776224;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LQdjWFOOTaDxz5pKUYSFBChgPQi9+bOMHfkRQQgW2CA=;
 b=qt2JpBBpy/JD965f/01HSuGeHlZbPICkVw4dGzp4JGRDFdGVvA0HgOgc
 kgiyN8jmEaTdE31dM1PbF75eBQZsUWXjvJWItrxkEIykHXXd+H7e++44K
 gxyLwvNKzI5DDgvN45RlCM4UrnfJzOyOKJu9dajH+9nEntocP07KBwkw2
 zCgrz6gUhBneKs6W5i6iDSdj5DhnjSi9WM9ziTgp2j/COGvNbqVJ5mw4J
 N7iJooy4/q98i6y8tyaQ+6CmrgPfJGQs5w4ZoixMF1XDMxGumtkgLQzhd
 xd9enyrABIzH2gUCEXbVKeB6VWbkN/5EauaFwMEwAVUAqZdgB8/wijtBi Q==;
X-CSE-ConnectionGUID: S3Bw/5MnRy6KWJdTOgc3gQ==
X-CSE-MsgGUID: Kjkyqtw8Qv6kh0T3ahCxlA==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="154456652"
Received: from mail-eastusazon11011035.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.35])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:23:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8K8/7UVQgJ9YfDQNxV/23dKq5b9FjMQXpwM3pOazqfFJLhJ9qetJiidl4cANbd88u4GbCvEr3aia9KztD5D5UAnEaTDhMIlBGRBt5c7sOJHD8SI3AMu0xeOub/Mhbg2HOIcQoTxSRKY3i8Fb7HWmOo8ZYFuV/vck50PQ6XeZiBSPbXXsrHt4dBkpQeH3BbrnbP4BQybWrWKbyE/xnZLPPsTNjLAmqXlp1wYc+qEI4Mf+HJNeEK88abBdC5wk6bwrcbzSHa9tPHkNfi5YqHwXQ05cLaSDGsd1p4Tuf585cU3rpSACBjsuuT9CP6SJdkym2tbJ5k2FntoZpXg4gwSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQdjWFOOTaDxz5pKUYSFBChgPQi9+bOMHfkRQQgW2CA=;
 b=Qi8U4ZRSTuRtDulmC5F7eMCLTYGi9YbeBG1/5W2u06oxAV2DRKJj+Wq8rjYIfIc0ZEzQ5K4JNcGErhl26itcAJnycPjHlcqBks8dikZAPjT8s4Txl0nJ1r80xSx898B5XrX0So2m7uK5z4/KjWLlEOrTbUOYuIF5cKLmWGf3OI7OWdlwypfPwH1FlKjRbJh+pgEU/BTTEqOhq3U/LXHVjqhT2FKt46pV4ti8uBnjMdSfzRgxgIhHV9Px2/M/jiV5/XVgtrh7gaJfzdQkHAoxJatW5f6NnZgixCyKk3eVJmUPjr/sg1dfj1+fT9DinKjqsrXouTj+1V1Wq7Iz81sptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQdjWFOOTaDxz5pKUYSFBChgPQi9+bOMHfkRQQgW2CA=;
 b=tX3eKb03GUzDiJrf8K3jipY+Gmo1tZ+bLMRM8WCLGJEEelmhs7h5cKHhYzYqT4o8jwRn2K8rwOl6UCOJIVvvddkDLk3Snu4GdPQ97sEq8GdoUU/DJEJe2AnCxANRJnjNVRneP7W2hkzRLhVqyysuX4/PP4T6fkc97X0ur5ixzi4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:23:39 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:23:39 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 11/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_rtc()
Thread-Topic: [PATCH v5 11/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_rtc()
Thread-Index: AQHdNy1mHnXMiwVLj0e3FI6mHSTpgba5NbmA
Date: Tue, 1 Sep 2026 05:23:39 +0000
Message-ID: <644adb1218066080e385b0949f0a084165a1b11f.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-12-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7302:EE_
x-ms-office365-filtering-correlation-id: d15ce0e9-6110-4d60-6689-08df07e92e06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|19092799006|10070799003|366016|38070700021|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: PwDFpbrzD08fpH6kp7DSNXT3CHGIhaVWpTN32SeF2uCjhFWLkYq2Svbqkz/d2k2B8dsmMJ8QAL4sA705OomD05PrM4xqSx+GXscbWGx9UOJar4R2o9Qu0qqE/6nkK35JUFBrleyp3jx15yto5+i1khoiaX5DJCJUfAh2BF0p57T3QBG/h5lBHc2eZpYSXbyuIkBiyig61zx5lj5o6NK6woTdi4GaViozrYXXTzk7g9RwIW9RtZ4Lun1nX7YK2fzaX7df8zGQnroz2aMXxuPrc0jULoEiRtpBHju4KWJhguA85u4xIENjebjugmv+yFyQiRNBor9HvIyve7kA1sP/E5U0y9NDHpBB4FsC4mgUZ9Dp755FUBER7uJMGfRKOxnRcG6UhLd4AryDFKxkjrYT2fdk4kR19bc/A0r/O/lre85S5vy0tOCfpivV4j+ZFREPw534Cv46XFrFQuUf1jRoArrDUPZEpjsvMy+I+/crQVQIoRe/fwbMyZv6Mx+ouofca55pe9kbHWZ9EQaJ14pe5n0nVNFyHviu7CFy8IwsFGFSDTLiyreO0AsuuOwsCr7tZ6uJwYmYZAxz40yN5B0W9bEFC634v804qxfHzn9UgtWMu25NiEPwG+BjaAnF3DtWCEOkt1p+7dtg5L09lKCw96pzlT/jZDrF0mwt3Xj2SnsHSoxoi3YhhgVwB6kHH67lJAwpC6SnnbGHpt0HGazn8HHMde+75Lck3/sCcZLZA2w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(10070799003)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1B2ZktUcEJCV0FGQ1RCSUUxN3k2dGpMZTlSd1dETEVtaDZaUE11dUswWTds?=
 =?utf-8?B?MU85Zm9JT0FKMDAwOXRLSFlYV21xWUxMZExvTFVQWEd2NGwwdWkzVzJDV0tx?=
 =?utf-8?B?c09GdDcwclg2SWEyMHBaSkQ1cUFOaWVFTi9rZHozQmVESWJQeGJPa3NVT3NE?=
 =?utf-8?B?aHQ1SG1RZXBhL1dXZ1JId0Q1ZUdXUkZMRDJDNDBPUDZLTHlPUk03TVZCZzlD?=
 =?utf-8?B?T0VoRDBvSTIxVmV6MjZQdmJGaXZtK0tWbUdIUjJZaFNNZmJieHNEcjlTU2tX?=
 =?utf-8?B?RnFIY0syczBZSVlWWTFzTmp6Q2F1Z1NrcUhQMGUzcUM2N0xJV0lNZlh4a0hM?=
 =?utf-8?B?djFvUm1XMHNyQzE0YUZZd2o0Y0NIS1FzOWtZQ0hUNlFRMnAzM05BQTZYTWRj?=
 =?utf-8?B?V3lYVTZzSXdYWS8ydGZKWmRqWE9UK3dtcmRlR1VLamYrMkxoVGpzZFh4cnJw?=
 =?utf-8?B?djNKR0hORnBja0pTY1RSSUJRSDBpL3dMRVQwVWk0cXFBZFpiOEVvWXZFZ1dN?=
 =?utf-8?B?MnpjKzQrQkV2N3FMRkhRMzQvcmlTY1Bva1JjZ0VkV1pxWHliK0w5VThPQU9Q?=
 =?utf-8?B?bXVXeVkzd3M2a290VlZ3ZWY0eUJ2YmxYSG5iMnRydndRMmhUeWQwVGxWS0tG?=
 =?utf-8?B?TWtBeDIzM2pXWFY5RWFTK0M5RWlYSEgxOWdYYlJrN0gxK3NHbkhYNHJOVjBE?=
 =?utf-8?B?NXVQemo3enUrTHBSQkFaYVZ1cHYycjNrb0lKSnZDV3BmK3dXVm4xMFVlaG8r?=
 =?utf-8?B?TkthaHZTUmlpRWZUejNzd29ISUN0TUtTYkErejlqbWRrbGN1cFZPUC9WZkRt?=
 =?utf-8?B?SHlvT1JiU2pZSGFWRnN4QlpaR3BVa1gvb3FpVjh4dnZlT2RtcmUrU2ptNWFD?=
 =?utf-8?B?RmNRMi9qaGdWQStzV29FTDVhbjA1L2tqeC80a2pGUVorRHhLK1BXTkNlZDdD?=
 =?utf-8?B?YzZGRWtveVdqcEpYOVRRMGdtMG4zYStZNGVaRjhVN0pwVHBMM0pQZnlLT2pa?=
 =?utf-8?B?NjNKS1Q4aTJkNmM5dUJob1N1N05Cb00xcm9EeVVLaFhVTGJNT0VQRDFaMWtN?=
 =?utf-8?B?ckNwSTRGTkdUa0NvQmN2NzM2cHRFZ0tmZ2dJUmFuR1hOa1paUE5MamJEYkNF?=
 =?utf-8?B?QTN4RElVbTNucms5ckhZQjRkcEVMRk05Ny9hY21kNGdwM2E2QmpQZWVkaDVL?=
 =?utf-8?B?RG1acVpDQituOWtyN3FCMTBQOCtnNjhwQ3RQT2h2TVNoZW14bzQ2Mi81U0p0?=
 =?utf-8?B?eVNiUnRMNUVhSlNTWEk4K3QwU0lDcTVlbVZXMXJOZnFIWS94TTV3YkZQcmps?=
 =?utf-8?B?RGxEUDRwWHd6cDk4SVhXOWZkcnNlQXdWbU9OckRyQlZHOWZBOEhWdGMzY3I5?=
 =?utf-8?B?ZEVoWlZmNGxidnpDSDkyb2J4Mk1jaENUWmNXY2ZGamR4dTdoR1Z2YWRnWVpW?=
 =?utf-8?B?dkZLVFhyZ04ybnBwSW92KzlNQ3JMZzRNRHd2dm1JenhPamplcG5TazljMy9Y?=
 =?utf-8?B?VHFSYUxpTTBqcWtaOExWZnh3MnlTNE1FMkJLVXA3Mk0rRHR3NTFRaEExb1NS?=
 =?utf-8?B?Y2FQaUFDNUZ2VHkxNkJUc0EvVThvR0xDNDlwVEFzbkFNTlRHNWRUY2cyblJs?=
 =?utf-8?B?aVNnUWdKZGUvUFh2eGZ6ZktRUVF2Vm5nVnI4RWNabmpJSnFYWnpqaS9aN3p5?=
 =?utf-8?B?elprRitoZTRaeUx1WW02ZnZVZ3BIWUlobXR6YmtyTmZDSXZuY21QdlEwWmR3?=
 =?utf-8?B?RGtCbVJZd09oSXFyMWM2Y21iUExhaTZSaVFKSVVnTk9UYldQYmo4QUQ3d2xC?=
 =?utf-8?B?S055QjFVRm4rRml4WEkwc3RMangvN2lCOG9ibXJxY0hrQmhiQUlFaFZIS08w?=
 =?utf-8?B?Ym1lTlJoT1BxcERuYklXK2h4aEFmYXIycVExWitkUU02OFBCeHpwRWlpclhv?=
 =?utf-8?B?VWUySkZPRTNYOU5zTWsyL251UkR0a3lzY0V0WHhYbkIyWXV5RlVsSVdXQmdF?=
 =?utf-8?B?ZUpQWGZnVWtHZXRpSzlQUVQxZS9RbklHTmtGZEozL3h5VHRiWjgvUmJQRjUz?=
 =?utf-8?B?U2JTU3ZYcjFsS3hqVVN4WTduMUtrVkY2bVR6cW1UeG14d29HNDRwK0VsaS9n?=
 =?utf-8?B?VGwzVDU2Y3ZCaEJpNjByYStmUnJHdjFoRVIrTFVhTXpqYW1oczFyQ0pJRThU?=
 =?utf-8?B?Y3VzMUh5SUVIanFkQXlKVFpOclZPK1lwdzdmR1hNeE9mamYwbWNRdlNubXR0?=
 =?utf-8?B?VGRDNVdmRm5PZ1dsbzlOUzJsYlM0YTljSGxscjNuNDlRZzhpalh3VW13NUFO?=
 =?utf-8?B?amZlYXhFU1FXcldQYUtIWjloT1NBOTFDLytHc1FUQ09SMlpOcm02c2lMRUlV?=
 =?utf-8?Q?q2AWikhbpgHj2LOW2e8LfARzGneXCo32QSkMMY1LMcHbW?=
x-ms-exchange-antispam-messagedata-1: 4vxAYw5O3N3WlOoedhmIttTbb9G6F3b1wVo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61241FFB40F0054EAD8B3AA3135EC16A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iDNySz/jE2j3lWJkkxITHudcO+XwawSTBA4WLC3UHLv3iWbWUZ4Vaq66nzdeBj3gJMfkSuLC06rigmpgQt5RgQ47u8epYGIChKy8h+Ddz7uqQCKtiLxfJVocwLNeHT9YWpvM70G+oXllK1l4h+01G34QVvlgWE48mcIMt3plJnTbAhkw5Xe0+TisnzMDcCm5EYujlCRON/OXfuiRjZFweYHVg11p6oSDornFMTilMpb1CD3L6aZ2urxU9dgOxepPRzDOoplLRhiwpsysBO2CfDlaDfXsNPVQf/AXZO8IZgHiHUdcwBAKIO6F2ZbGwQ+hRqps0TnlUZ8r0elVGxUIzw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jAe4b+EqMmOkeYbOwsqTTAGW2ZvSf7wcLPcOirxgobB4QB4cZkQrQSDB6mWaA6R1e07nWV3mHnmPNPvLB8lnefTf/Mj8G4nD557/qLkTZ8ikCZeXFjEsBONxT1huTJcYg8/geg96vpgGd5Ee+arROtV2LWiK0AZ5tlFwMFY1eGFq+nv/dSY+F9DXXGbO9Gyhxg/nC+h2vI5i9v0Rjo+8JPwt3ilP5PMUvBSOGNFG8FWFhUvzH21Kj7SogyAHgozKitgCZbSV597huk0X5I/TLc924HP2cdzwn32a2vLPiEOIMVJknhpxvVRzDyeLNfAvM1VzEbSN33n745I9jofytlYi2tKAwbQlibGaoH7qlUnM0f/LWfzblCxL2It+X64xNxyVfbMhHscTLQKedeJtVnwf5LXmy8zE3ejcfr+1xAfyEm3UE2T91/adjdpifHqeh+lou++5GI4UMlRX5JUiDZyqhlshY+i9Re7uCjFK8Mgz+qFzgdy3rASHi8FmdlVJ9FrYGsj2OYD/Cb0lM2BSHxaCSCzx0Tbzl+XFiU+jfNj8MM7i5bWRpFrva1/L6CUauMoBggLtbOrrVf5SL4s9ybEnIqgD5WRw1blNt0zHsO+P4hfxW31f6uIPftkYgTQF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15ce0e9-6110-4d60-6689-08df07e92e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:23:39.0643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSf4ERtTTmCMXLowNJNe65C0n+4RWcQsv0xkEiFEPlbroJYJ5dPibsXSisFdP7SJNKfOauwymelKdPzj8/Gnz+jXVtjM2VcynzdypE+H63g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBUaGUgc29vbiB0byBiZSBhZGRlZCAncmlzY3Ytc2VydmVyLXJlZicgYm9hcmQg
d2lsbCBhZGQgYSBydGMgRkRUCj4gc3Vibm9kZQo+IHRoYXQgaXMgc2ltaWxhciB0byB3aGF0IHRo
ZSAndmlydCcgYm9hcmQgdXNlcnMuwqAgUHV0IGl0IGludG8gYSBoZWxwZXIKPiB0bwo+IGF2b2lk
IGNvcHkvcGFzdGluZyBjb2RlLgo+IAo+IE5vIEZEVCBjaGFuZ2VzIGludGVuZGVkLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRhbmllbC5iYXJib3phQG9z
cy5xdWFsY29tbS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAb3NzLnF1YWxjb21tLmNvbT4KCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlz
dGFpci5mcmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L3Jpc2N2L2ZkdC1j
b21tb24uY8KgwqDCoMKgwqDCoMKgwqAgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPiDCoGh3
L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNiArKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+IMKgaW5jbHVkZS9ody9yaXNjdi9mZHQtY29tbW9uLmggfMKgIDMg
KysrCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9mZHQtY29tbW9uLmMgYi9ody9yaXNjdi9mZHQt
Y29tbW9uLmMKPiBpbmRleCAwMTA3YWFkYWFkLi5jZTJkY2I0M2I0IDEwMDY0NAo+IC0tLSBhL2h3
L3Jpc2N2L2ZkdC1jb21tb24uYwo+ICsrKyBiL2h3L3Jpc2N2L2ZkdC1jb21tb24uYwo+IEBAIC04
MjgsMyArODI4LDI0IEBAIHZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF91YXJ0KHZvaWQgKmZkdCwgY29u
c3QKPiBNZW1NYXBFbnRyeSAqdWFydF9tZW0sCj4gwqDCoMKgwqDCoMKgwqDCoCBxZW11X2ZkdF9z
ZXRwcm9wX2NlbGxzKGZkdCwgbmFtZSwgImludGVycnVwdHMiLCB1YXJ0X2lycSwKPiAweDQpOwo+
IMKgwqDCoMKgIH0KPiDCoH0KPiArCj4gK3ZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF9ydGModm9pZCAq
ZmR0LCBjb25zdCBNZW1NYXBFbnRyeSAqcnRjX21lbSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IHJ0Y19pcnEsIGludCBhaWFfdHlwZSwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWlu
dDMyX3QgaXJxX3BoYW5kbGUpCj4gK3sKPiArwqDCoMKgIGdfYXV0b2ZyZWUgY2hhciAqbmFtZSA9
IE5VTEw7Cj4gKwo+ICvCoMKgwqAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL3NvYy9ydGNAJSJI
V0FERFJfUFJJeCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBydGNfbWVtLT5iYXNlKTsKPiArwqDCoMKgIHFlbXVfZmR0X2FkZF9zdWJub2Rl
KGZkdCwgbmFtZSk7Cj4gK8KgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5hbWUs
ICJjb21wYXRpYmxlIiwKPiAiZ29vZ2xlLGdvbGRmaXNoLXJ0YyIpOwo+ICvCoMKgwqAgcWVtdV9m
ZHRfc2V0cHJvcF9zaXplZF9jZWxscyhmZHQsIG5hbWUsICJyZWciLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIsIHJ0
Y19tZW0tPmJhc2UsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMiwgcnRjX21lbS0+c2l6ZSk7Cj4gK8KgwqDCoCBxZW11
X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBuYW1lLCAiaW50ZXJydXB0LXBhcmVudCIsCj4gaXJxX3Bo
YW5kbGUpOwo+ICvCoMKgwqAgaWYgKGFpYV90eXBlID09IEFJQV9UWVBFX05PTkUpIHsKPiArwqDC
oMKgwqDCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbmFtZSwgImludGVycnVwdHMi
LCBydGNfaXJxKTsKPiArwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHFlbXVfZmR0
X3NldHByb3BfY2VsbHMoZmR0LCBuYW1lLCAiaW50ZXJydXB0cyIsIHJ0Y19pcnEsCj4gMHg0KTsK
PiArwqDCoMKgIH0KPiArfQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNj
di92aXJ0LmMKPiBpbmRleCAzZTQwNTEzZGMxLi5jY2VhNTc4NGYwIDEwMDY0NAo+IC0tLSBhL2h3
L3Jpc2N2L3ZpcnQuYwo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IEBAIC00MzYsMjkgKzQzNiw2
IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfdWFydHMoUklTQ1ZWaXJ0U3RhdGUgKnMsCj4gdWlu
dDMyX3QgaXJxX21taW9fcGhhbmRsZSkKPiDCoMKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX3N0cmlu
Zyhtcy0+ZmR0LCAiL2FsaWFzZXMiLCAic2VyaWFsMCIsIG5hbWUpOwo+IMKgfQo+IMKgCj4gLXN0
YXRpYyB2b2lkIGNyZWF0ZV9mZHRfcnRjKFJJU0NWVmlydFN0YXRlICpzLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGlycV9t
bWlvX3BoYW5kbGUpCj4gLXsKPiAtwqDCoMKgIGdfYXV0b2ZyZWUgY2hhciAqbmFtZSA9IE5VTEw7
Cj4gLcKgwqDCoCBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORShzKTsKPiAtCj4gLcKgwqDCoCBu
YW1lID0gZ19zdHJkdXBfcHJpbnRmKCIvc29jL3J0Y0AlIkhXQUREUl9QUkl4LAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1lbW1hcFtW
SVJUX1JUQ10uYmFzZSk7Cj4gLcKgwqDCoCBxZW11X2ZkdF9hZGRfc3Vibm9kZShtcy0+ZmR0LCBu
YW1lKTsKPiAtwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsIG5hbWUsICJj
b21wYXRpYmxlIiwKPiAtwqDCoMKgwqDCoMKgwqAgImdvb2dsZSxnb2xkZmlzaC1ydGMiKTsKPiAt
wqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc2l6ZWRfY2VsbHMobXMtPmZkdCwgbmFtZSwgInJlZyIs
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMiwgcy0+bWVtbWFwW1ZJUlRfUlRDXS5iYXNlLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIsIHMt
Pm1lbW1hcFtWSVJUX1JUQ10uc2l6ZSk7Cj4gLcKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX2NlbGwo
bXMtPmZkdCwgbmFtZSwgImludGVycnVwdC1wYXJlbnQiLAo+IC3CoMKgwqDCoMKgwqDCoCBpcnFf
bW1pb19waGFuZGxlKTsKPiAtwqDCoMKgIGlmIChzLT5haWFfdHlwZSA9PSBWSVJUX0FJQV9UWVBF
X05PTkUpIHsKPiAtwqDCoMKgwqDCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQs
IG5hbWUsICJpbnRlcnJ1cHRzIiwgUlRDX0lSUSk7Cj4gLcKgwqDCoCB9IGVsc2Ugewo+IC3CoMKg
wqDCoMKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5hbWUsICJpbnRlcnJ1
cHRzIiwgUlRDX0lSUSwKPiAweDQpOwo+IC3CoMKgwqAgfQo+IC19Cj4gLQo+IMKgc3RhdGljIHZv
aWQgY3JlYXRlX2ZkdF9md19jZmcoUklTQ1ZWaXJ0U3RhdGUgKnMpCj4gwqB7Cj4gwqDCoMKgwqAg
TWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUocyk7Cj4gQEAgLTU2Niw3ICs1NDMsOCBAQCBzdGF0
aWMgdm9pZCBmaW5hbGl6ZV9mZHQoUklTQ1ZWaXJ0U3RhdGUgKnMpCj4gwqAKPiDCoMKgwqDCoCBj
cmVhdGVfZmR0X3VhcnRzKHMsIGlycV9tbWlvX3BoYW5kbGUpOwo+IMKgCj4gLcKgwqDCoCBjcmVh
dGVfZmR0X3J0YyhzLCBpcnFfbW1pb19waGFuZGxlKTsKPiArwqDCoMKgIHJpc2N2X2NyZWF0ZV9m
ZHRfcnRjKE1BQ0hJTkUocyktPmZkdCwgJnMtPm1lbW1hcFtWSVJUX1JUQ10sCj4gUlRDX0lSUSwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmFp
YV90eXBlLCBpcnFfbW1pb19waGFuZGxlKTsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIHZvaWQgY3Jl
YXRlX2ZkdChSSVNDVlZpcnRTdGF0ZSAqcykKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9yaXNj
di9mZHQtY29tbW9uLmggYi9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC0KPiBjb21tb24uaAo+IGluZGV4
IGM4YjI1MzQ4YmQuLmViOWRiODI3OGQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi9m
ZHQtY29tbW9uLmgKPiArKysgYi9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24uaAo+IEBAIC0x
MzMsNCArMTMzLDcgQEAgY2hhciAqcmlzY3ZfZmR0X2dldF91YXJ0X25vZGVuYW1lKGh3YWRkciBh
ZGRyKTsKPiDCoHZvaWQgcmlzY3ZfY3JlYXRlX2ZkdF91YXJ0KHZvaWQgKmZkdCwgY29uc3QgTWVt
TWFwRW50cnkgKnVhcnRfbWVtLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdWFydF9pcnEsIGludCBhaWFfdHlwZSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qg
aXJxX3BoYW5kbGUpOwo+ICt2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfcnRjKHZvaWQgKmZkdCwgY29u
c3QgTWVtTWFwRW50cnkgKnJ0Y19tZW0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBydGNfaXJxLCBpbnQgYWlhX3R5cGUsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGly
cV9waGFuZGxlKTsKPiDCoCNlbmRpZgo=

