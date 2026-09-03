Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B087C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wch-000748-W0; Wed, 02 Sep 2026 21:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wcf-00073f-W6; Wed, 02 Sep 2026 21:52:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wce-0003HF-9v; Wed, 02 Sep 2026 21:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400332; x=1819936332;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Bx22QlKMZ2OkfdeJDasDP6YlIguxOpBPHjUSTuwVAIU=;
 b=d3EX/MqYfn0MnCHCzmK0sOBB+/widhtL9fUFuS+EiZoFU97T/XzskH2X
 TqiODiJqzOuj7GgKZ7lEFzS+ip/tKZteMb3tG70p7cep7lshp5/gOxJ4s
 BPbQy03XukOwF42NZbbduryibrCPN9jAbBRw6XcGZlWBbTToszRmFEGxE
 1jxlRMmTyvkpR3926TEMmhXzu42L6c/bThSZZtoflBirdKq22W3HfTJdc
 FnBy9Wc2EgX51TNUP8ReoTilLFzvC0LpiyrnOVfpt69FCJ1Uv+V/yrtms
 NK6IMJQO1zBzi1ri0tsNKInlxiwnv7neV/nl2zRnnrO6Q9huOX5ciWeJh w==;
X-CSE-ConnectionGUID: rfkZ5fJ/TtKpUiiAibPDtA==
X-CSE-MsgGUID: ibkzZbqQSFGwB5vUayuLtA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="154835740"
Received: from mail-westus3azon11012027.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.27])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:52:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUnud8HZXCIJfWCfbgRzsuJ+w2gyZ0iC4mgRi8VfjUG3wq6thLG6KeWHUKxvJ9GKToCDsdtOi/Il7LeDr8A0d50uHkmNZzhee21PbGddDAcUC1hrltM5p0lzlQ15QRdI9lI2YBmsRGDmAGkTTy24HD79LgHKReeQA7ywc/Hpq3BmBiaXFLOVWdBaA+hEcfqO4Tf5DCOmOClTDyy3p/6OhZ13Gh/KqgpQxqEX2GpQDkAqdwl8BwbHjyLW0gBJCzqSPzkDIT4v5fTvlFCJM9k8kWkVad14POAzp94NkxisnG3zDyV+XAmBgLUxcJ/P9ghb+/TQLCTJ+UcARZFN4eCx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx22QlKMZ2OkfdeJDasDP6YlIguxOpBPHjUSTuwVAIU=;
 b=B3i8vn0u5rvyEF/2R0iMQJ1f+3A85NCtdfcMCwDmiS1ruhANU8Y8iWlSgZ234dztLYBq2rvgL4u6fa1q9cgM82QUkBWInRsFPoTy/6yWjAyW548Sn89XCQpaa3YyQF60lEpIYEeDSpsZhDVqD24GSVNGUrKv12YE44Ukq4CKPLDE1jdysOaAJXhtK8bc6hY0UbbrIp9N0K0NZq5gV8TFwqdfFck+/NvZVyf3VBH0zgj2220ivWTPqhcelnjbWq5Zv6NlPUYyRwShtKO+FcVuUVr2YSc2HoUFGfylpzzZVu7CiogeXsK4ijHF73SWqkFryzzuRQ00hN5NhU5F6JlfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx22QlKMZ2OkfdeJDasDP6YlIguxOpBPHjUSTuwVAIU=;
 b=tERIWUJ0N3XT3LX5DjSNed7hPChlTSLjWuzvTk0AIiUPgIup7f8VzfdrI4DUrCPyEYI6KNlv7G+0++f70uJknvoGtCpsOqiLziq04ONukdsaVrn7i6FbV3FrQfMk3XCXYzhT7tm4q1l2f4JOhXZEqZziyi652m/S8FSB8EpFC6Y=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9355.namprd04.prod.outlook.com (2603:10b6:208:515::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:52:07 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:52:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 08/16] hw/riscv/atlantis: Remove unused fdt_size
Thread-Topic: [PATCH v2 08/16] hw/riscv/atlantis: Remove unused fdt_size
Thread-Index: AQHdOO61Q95VHuIz5kioKPcX6TADnba8G8aA
Date: Thu, 3 Sep 2026 01:52:07 +0000
Message-ID: <53605250645a7eae1c02c57a478b47f74fe266a0.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-9-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-9-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9355:EE_
x-ms-office365-filtering-correlation-id: 3e6c14d6-adc0-4c25-0489-08df095df629
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: +GfXoE/PI78BqQ9blD7PAThYAYoabvUbmX562e1Qb5NlJ8l/vXw+QrAXWko/bMRCjiOJuMdqM7gwu9YrEK1FGVp1GwsVzfnOAeogmhWG5uF6G+cMUIi1VB5QgH9R2SpdnkfmdZUKJSHv6U1QmuBFvuH3D8XSvsTVSqg88zQ/vndOwyeXv+AZfUMoPriOGu6+7OqWievoIp//9T81HKqFwrQFXqcORbnxDQcMx0IqRL3ZDh9iyhIgl0lpWPqmxZiXAQBOrSrIQbD0LW904kKqgcF1T2swrNd+cAHY8B8E39F6w7MhyRCHVW3BOxxlKzhdGOvqXn63pDOYQGXt1sPJY3F59Q53OFbzmBpTqruYesg4kT2NljoQLL/sR13cyjXFH617LEnmf2t6IyMNV6bN5aiy4xgNZkPT10/EUgTnOteIOw9ktK5Nhemg8Ri6dLa1dwnQpHux4EYbo15L3wvyWJ/wMDO73gLxGnvnEdoFtHe37rEQb/Bx00gL3sCpwYAzW59BTP7NoDvoT/y1zfQyHKatd9ToSK64CyaBwVvn9lvns27SQdZyoiuE+HTDo5V+3txzGXHzskPvC07Bmwpe7UEi77HeveZzhzAi+dP+FHA0RRmXn+CWB9z8RwUHLadPhDzSvXEU/bQlXOTLS434Ice8IOk31bT8V0XlK0ojopH6KIg2EUrLTEVXFHm9v0iQ6ZxGlDlxwYS34ATHtfi35x9kaZQpXj/kFEO11wDZlYk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE80ZWU3RStIaXliNS9EUmZjMjlRYldOQUNiTGlZU3pSdGJ2TzJkVVRpcm5w?=
 =?utf-8?B?R0lPV2VpbnZnQUtMOE1ZY2dYbmdhanFiYnNISnVjem9FMHplcUpQWHZ4QTZi?=
 =?utf-8?B?T1VnU2lQWWJqcWxWaWhvdUNvUWQydjZwQVREM3BHS3duUFJyUXFTL1FzaW5B?=
 =?utf-8?B?Z2JYd0xuVVFNV2tLRXFGT0pJeXI1cGc2dEJORzg1RlNyYWZJQm56OC9oOTFQ?=
 =?utf-8?B?VU9BUmhRRVRSUjNYbzlKWFFBdkZmVjZQakZtTGNVaFhtR3lNU0tubG1jNkZC?=
 =?utf-8?B?RUM0NzFiSG5IWGZnSzBZYVplS0NuaW83Q3FNcldxQ0FmRExxbDIzSDF2UkZE?=
 =?utf-8?B?MzQ4M2hWQVYrdExTb0Q0U08rS1laVE9ZSmtFNm9FbWxrMVcxYzVIL292Ynla?=
 =?utf-8?B?WmJmU0VITFVqU21BYVJOZ245SVN0NGw5d1hHQUFaTjRpcDlyQ08rY0dSaUg1?=
 =?utf-8?B?Wmxxb3RlZy9QS0pQMndnaFMzV3QzMEdIcWRvSFVMYU56OTloUXlSc0cxRWNI?=
 =?utf-8?B?M0Z0cUFHU3NtcHB2VXZ3ZkxXc3BmVCtRUHc4eFhSWWpiSGh6aU1QRVp2OUxl?=
 =?utf-8?B?cVNId3VuVDJ5WUp6ZmRad1o0ZllsZmFKK205VDc3WTdtR0Zta2VWRGVvL3NP?=
 =?utf-8?B?OG00UTFZKzQycHNIL3BWcWpydC9LNHJYOWJQQmhOMXRaem5qVlA0elRBTTRX?=
 =?utf-8?B?MTJoTXlGM1lIcHZ4Z25NU05BQ252aExydjd0YngwYUtjV09US3NUakh1ME5l?=
 =?utf-8?B?R0hPaDdJK2F6U3RhZmNXcEhrYmUrN2hMWlBvY0cxa1RCcDZROTFxWjQvaHJ0?=
 =?utf-8?B?RHhtY1E3czkzcisrL2N4aVcwQlNvUVZ2ZUFuMHBKakxqTk5FUlhVdmxXaEhs?=
 =?utf-8?B?SU1aYnU0VVozRWxYc0x3U3MxOVVNTjdqOThmS0cwRVZVVG9QeXZUL2pJWkNZ?=
 =?utf-8?B?MTZLcVc1aEw1MXVSTGJYOFErZmVYeHNKSkh5d3h2QmVsaFVRcjI2VFp0aGxP?=
 =?utf-8?B?ZW9GYjQyZ2xsbHpNOVNQWElGMWxwT29VeWpwdUVQYlZiZzhySGtpZ2drK21h?=
 =?utf-8?B?UW01UmV3bGtQT3lSVk0yQjJYQmloM00wMGdNUUFFWnhuc1J4a2ZJYldybS9U?=
 =?utf-8?B?MjlPSXpaRXZ3MXBndVEzSWFwMXNmSy9lclQ2UnB2a05GSUhZWCtQUjRKdkZL?=
 =?utf-8?B?d29zU3gvRU5TcFpZdUc5UE11WmlRaituZ1QwMkQ5QmgzWUNWa3lLamIrQmRx?=
 =?utf-8?B?cGVQUzk1YmFIaVlPQ3FaWG5pZmF1dEQxNGduK0JYdlY3T3I2dmdUbldqWU5D?=
 =?utf-8?B?NlBlaVpseE53VmFGR05CME5tYmcydVlybkNsN0J0elF3azNuSnFTSm1vU1hK?=
 =?utf-8?B?YXFFR2tXVDlZQ2xueDhjWDdNTERFbkR3L1BCZUlabGpLVE81US9oeUliVnB3?=
 =?utf-8?B?dUpxMTZ6Wk1WWTlMY1Zwa3llU2pqSXJ1R0J6c2gzc24xNWNHMjFKdW9tc09q?=
 =?utf-8?B?OXF6WnhFR3ZuY29IbEYrYksrSlh5ai8xUk5ML1RSNkFVb2ZJdDN1SnhLd1Bn?=
 =?utf-8?B?Tk1IbVpsdlJGU0IwQ2x0NFhsV3QweElPblNra3QvajZJUWpCL2o5N0R6V1ll?=
 =?utf-8?B?QnFON0d6WWRPb1drQjI0S3BDaXJYUm8wYUk1ZjBlZjJXSElWSUZUVjRHcGdE?=
 =?utf-8?B?cExDT3RjRXBsR3pvajVFZ3Yzak4yRGV5OXNKSTZXbXJMd0pmNWw4Vi9uQm1y?=
 =?utf-8?B?MlZMZ2xxQWM1QVFYSVBnbTRZQXdyc2NzWWlncHlHOXBSWThnQkVKUTQwZkJJ?=
 =?utf-8?B?dFFMY2VHL0gwVEozLzg1QThlY0NmRHZrdFdlSjZmRXZOOE1NU3JzMUE1QUxK?=
 =?utf-8?B?R1FIM09IMm44WTZKOEU4cWZ1SmNQN2NockxpYksxMWVQbktwcVBFUHdUWEln?=
 =?utf-8?B?VlFITDRYSmp5TGI1RDNZbzZyYjd3eFcrUGlvcWRSdjNVK2xIYWNSVjV4M0o2?=
 =?utf-8?B?MHBodkkxY2VrWVZCek1TbVBFcjhXc2FKb3c4dk5jVGxSTzVOd08zd3ArYzB4?=
 =?utf-8?B?cWYzU3NXcDcwKyswbUNuTVI1V0JjTEFpQWJkM0prT2lvMHpLY1paUmpKUEFD?=
 =?utf-8?B?cFo4b05OMU5hSytWRmVQWWJwQklhaWNQWmxRTGd6SHFuUDRqcytodEhrcEps?=
 =?utf-8?B?c2FVNmwwaUw5MXFEWTIweUNEblNYVXpwVUp0MkFQSzJnM3Bsd2hYajBnZ0ds?=
 =?utf-8?B?MWkvemNmN0JKVVowVFdNRXloQjAzOWlBZ1hrM2N0RHJnTmw4TnhCamZPbmRW?=
 =?utf-8?B?bHVYUHNGNXp1VjhYKzJtSXQ1U29PNlRPcTNUWDVWNGlyZUFQMmhZV3ppakpn?=
 =?utf-8?Q?OJAgzDHftirL1ASPaNLFE/EiuFpUnTIhdXva/CZtG4xCo?=
x-ms-exchange-antispam-messagedata-1: pIKCf8r/wZnqwxcSevOnJNejtgsgX3JRfxA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8C2B41A13D17489451358F6C49E6AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yV/6qIUPQnpoWBgtei0nVqpjUCci7hJ3JdPxOQtkioo9GtBUYHF/TsloSweU79vMvBi/1HGRb2YMCz6OV7OYywKtetcWyLqR3VWr0VAKS4NAqGUx0jQQ18ER0Pcf73MtpID4Jk6jyIcltP9OusBSJpLUuvp51uMZE2aNhUmpQnmF/kEalIbcrmRXkWfrJVaJFHzH2ASFv+wyjBDT4bwrUtcCDO4zrDX7a5Rc4abYYeX1Cu6cT56M6IRvFDCSC92V7DumYxgf7EFjWUn6TdUyPAe9tBnSczjeyTeXiHMZxPR12tZ7MBQ3j4ixTpGVTfmMvduR6QzlIenQePbTWptFOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: joOIfMION0SHvPCoXtwvopyMmbSw12p34iPjDUmXZH8Gw55tVaPPb73mTqJ3dK1IGJxoR8fZ+gqqmsRz5LMTABy+s2s4bmni5cS2gDhq3ggVJE5ackVSWr7ICzm9qK3mvE0BaNtQL1uK+CJH4FJPN8Ga3yDQiHS8fqMv688Rd7cckQ6IXFILWJ6VzCHn7WUJmDLlJ+ytVw34dpXA/SZxPpkgow9+CGY/+dutnP4GqwUPjTY3aAHm/U2yrtQGUyD2YhFU17SJg6AfLLmH1ZuK2gA5vyuwtiyz4ylLQ4VPozLye31IuiPNQWsHupWIi33Z+Oxw4CRkIIE5QPZDopMnBl7FkHEeDCXQE+b8/XnqZKWsPEKDDW13YNhj5bvGFsMtxvfp4seFkWESwGtaG6YBH4G4OssoYC9bE90ajd4dO3bWOy9/k7iBhRTqYAXsMJZqmF2Et18pSkjLybO3AOkdK6C3NbSVIyCnGfnbNNMZuTPq2/PPD0LsqBI8gKQ45K/wgp5NNJP4OrkAZp0EgsVHyWJe8eFjPxRWSkbafwE9DvS6sty9eZPG2ZdYVkbmLfXnDaGimPFGlwtZZp03L/A1anratH5LqLchM71T1hSIRzvchY+FnItoJNRt0OfijWMB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6c14d6-adc0-4c25-0489-08df095df629
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:52:07.6314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju4J2f4B8mWpFFgid0/NFFxsLA1OJEW1QqbXQ4dO6vxtjAUyfR2UJLHLP6ak8Zmv9fyQz5vZpk/aG+8WZDgMx3jL8tAfc+TObf0HUKu/CGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9355
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFRoZSBtYWNoaW5lIHN0YXRlIGNhcnJpZXMgYXJvdW5kIHRoZSBGRFQgc2l6ZSB3aGljaCBpc24n
dCB1c2VkIGJ5DQo+IGFueXRoaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5
IDxqb2VsQGptcy5pZC5hdT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBpbmNsdWRlL2h3
L3Jpc2N2L3R0X2F0bGFudGlzLmggfCAyIC0tDQo+IMKgaHcvcmlzY3YvdHRfYXRsYW50aXMuY8Kg
wqDCoMKgwqDCoMKgwqAgfCA2ICsrKystLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcmlz
Y3YvdHRfYXRsYW50aXMuaA0KPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaA0KPiBp
bmRleCBjOTMwOGFhNTcwMTcuLmQwY2NhM2IwMjQyNCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9o
dy9yaXNjdi90dF9hdGxhbnRpcy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50
aXMuaA0KPiBAQCAtMzMsOCArMzMsNiBAQCBzdHJ1Y3QgVFRBdGxhbnRpc1N0YXRlIHsNCj4gwqDC
oMKgwqAgRGV2aWNlU3RhdGUgKmlycWNoaXA7DQo+IMKgwqDCoMKgIERlc2lnbldhcmVJMkNTdGF0
ZSBpMmNbVFRfQVRMX05VTV9JMkNdOw0KPiDCoMKgwqDCoCBVbmltcGxlbWVudGVkRGV2aWNlU3Rh
dGUgdWFydDE7DQo+IC0NCj4gLcKgwqDCoCBpbnQgZmR0X3NpemU7DQo+IMKgfTsNCj4gwqANCj4g
wqBlbnVtIHsNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMgYi9ody9yaXNj
di90dF9hdGxhbnRpcy5jDQo+IGluZGV4IGFjZmQwZDMxYjM2OC4uMTI3Yzg5YmU0ZjYwIDEwMDY0
NA0KPiAtLS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jDQo+ICsrKyBiL2h3L3Jpc2N2L3R0X2F0
bGFudGlzLmMNCj4gQEAgLTM2Niw5ICszNjYsMTAgQEAgc3RhdGljIHZvaWQgZmluYWxpemVfZmR0
KFRUQXRsYW50aXNTdGF0ZSAqcykNCj4gwqBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFRUQXRsYW50
aXNTdGF0ZSAqcykNCj4gwqB7DQo+IMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5F
KHMpOw0KPiArwqDCoMKgIGludCBmZHRfc2l6ZSA9IDA7DQo+IMKgDQo+IMKgwqDCoMKgIG1zLT5m
ZHQgPSBjcmVhdGVfYm9hcmRfZGV2aWNlX3RyZWUoIlRlbnN0b3JyZW50IEF0bGFudGlzIFJJU0Mt
Vg0KPiBNYWNoaW5lIiwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInRlbnN0b3JyZW50LGF0bGFu
dGlzIiwgJnMtDQo+ID5mZHRfc2l6ZSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ0ZW5zdG9y
cmVudCxhdGxhbnRpcyIsDQo+ICZmZHRfc2l6ZSk7DQo+IMKgDQo+IMKgwqDCoMKgIHFlbXVfZmR0
X2FkZF9zdWJub2RlKG1zLT5mZHQsICIvY2hvc2VuIik7DQo+IMKgDQo+IEBAIC0zODQsOCArMzg1
LDkgQEAgc3RhdGljIHZvaWQgbG9hZF9mZHQoVFRBdGxhbnRpc1N0YXRlICpzKQ0KPiDCoMKgwqDC
oCBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORShzKTsNCj4gwqDCoMKgwqAgY2hhciAqKm5vZGVf
cGF0aDsNCj4gwqDCoMKgwqAgRXJyb3IgKmVyciA9IE5VTEw7DQo+ICvCoMKgwqAgaW50IGZkdF9z
aXplID0gMDsNCj4gwqANCj4gLcKgwqDCoCBtcy0+ZmR0ID0gbG9hZF9kZXZpY2VfdHJlZShtcy0+
ZHRiLCAmcy0+ZmR0X3NpemUpOw0KPiArwqDCoMKgIG1zLT5mZHQgPSBsb2FkX2RldmljZV90cmVl
KG1zLT5kdGIsICZmZHRfc2l6ZSk7DQo+IMKgwqDCoMKgIGlmICghbXMtPmZkdCkgew0KPiDCoMKg
wqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgibG9hZF9kZXZpY2VfdHJlZSgpIGZhaWxlZCIpOw0K
PiDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoMSk7DQo=

