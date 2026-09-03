Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF5BC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wWD-0004ad-V2; Wed, 02 Sep 2026 21:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wWA-0004Xk-1v; Wed, 02 Sep 2026 21:45:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wW7-0002aB-TS; Wed, 02 Sep 2026 21:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788399927; x=1819935927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xflfi6sU4Wyag15ELBjFm+QP3Y8ls7l50+2e+SObcSw=;
 b=AV9gpYT5ITUCJS5jx3vNeXF18nhv7CjKXObhCTz5l4eLfy/ihO8nzjij
 QA15TBVMNFIkvJH3GnD2abQPxq/rUNZ4+3B04R857eTXQaqHVeQPcyLbR
 XGzwEd+ElOtdkqnIHm1dTeUMWXW7VJecufU3CbdjfWNUL9UzIHpl80A72
 MhD5LWPdBuC639odAz+5FHrNF43qHbk78grptY7QS7yDsT1kNNIJP6YJD
 8f/htAiJl6Zd+Ta9Acpi+eBk2+6oKVswUR2RNuhkxcIFLbP/Alu04LbMi
 EAYAs91jmZs2gOTDlJQnRarng5/h1Rzcq1loGNz55Zy2Rw9D+VCVnKQKr w==;
X-CSE-ConnectionGUID: qquDQ5lpSB2y/ibdX7iuyg==
X-CSE-MsgGUID: bN5LHodDQGmIWa1KjE8nPw==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153254523"
Received: from mail-eastus2azon11010037.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:45:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSSTYt83af9jqR5UiEUyipDmJy6FUduOgzi2oPXSrXraVe++HFxWhFl/38XjZ6X7YG0OQaAflDSos34ZsxE7OlqTgLxWbW2AvutWLp6fZXC3rDlEyG67Ci6VMAPkpoA9jyqHrs6O53JChML49kJ0CZuMYLTloo3GTaJ64xA62nDegN2Qoff8hQuHa0Rq2HOdgedTmlcr+HGuN5aozbMp6NKpmFkl9Y22kinKCd6UfrgZIM0LjdTYTOWxeps367XeJxDFbBL3MlM979id8CbbZJqXRNIw3+PnAIiwcNQ566QLdjweRbo9hf0KcyuqpzBMR544OsSZBdjJHin8hB2kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xflfi6sU4Wyag15ELBjFm+QP3Y8ls7l50+2e+SObcSw=;
 b=bPjyT4BDTuSPMkddNqH5I0kxI1kzEuTE4+0+x/RYEgsqz8a4kanjBzV2MavpoW0iZfnT/bIoJVZaNJOPVE2IxZ8krGfJ8pciWUTQevA7Z5W6e8o+5IykX2yJ55DL9s/sI716KpUa/2+Ovtvco376sjjIqb43zu5nOlH8XDs3IiSfAFOR1Uo/gvgiEVlgcJTB3pNG0Kcc2P6YDAaURBYc87YJO/qwrSOA8UY/lrAiEZA4P7aF56CdmZRX3tchdVfaVpQ8Q5DmJkmu+lBAJYk349JsSmvE+AjhebYuoeUmM3mSXUvRtpYFoAf2I5R37ve0oSM2PH1/AK7LPoks7TXUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xflfi6sU4Wyag15ELBjFm+QP3Y8ls7l50+2e+SObcSw=;
 b=lt4x/2YJ9pUlpwjXpz3QPa1u3i2ls2Iq7PiCZeLeMYB4Fstn1uCBK6X+BSFFVoMKepv48X64Sp5qdtcohzdn3N71R25rtUouRfIvVTiQ+9/FmP2GoW1yoCivNmmyjs8tboZkz24nO77rxRgxPAufBCtmIF5rCpEC/iXqLNUnbAI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:45:22 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:45:22 +0000
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
Subject: Re: [PATCH v2 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
Thread-Topic: [PATCH v2 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for
 the created device
Thread-Index: AQHdOO6ljJYKrA9ix0ei0yWYywLBvLa8GeWA
Date: Thu, 3 Sep 2026 01:45:22 +0000
Message-ID: <55e6a9e4e2b3557680cdb8afa667ca40ca59dbee.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-4-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-4-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7640:EE_
x-ms-office365-filtering-correlation-id: d4194115-1f08-470c-693f-08df095d046a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: SmtGUSGl2ov7SNrQH02sS8qBgnMkaHaZ6Q4F5b1Ii3+14UnuCK1YoPmDlHNtNGd49urSxn3eiqgOG+pGjYNNP75WziDcaidWVM/makk/bJk4RG+gqCDi7CKwUhvZpJ50mQ7Locve67PxD4kgDwbRuj8iTAYSbuXh3O5ey8L8eAFgvIYTjrhfd1en0IE2s4GRoZgyNJBpe7bqnVNnIctjtxmWeuEWUUApAFbL+MGxsGpmcAfmGh4wLoMWgalrACEQH1qD2OSCu7i4LP3s6dJRIXbhIBv0dJBjU8ejZIgSH+QWf3vEgYVRqqM1TMs5qOcJ3fvT+3G5nEJhEXd0C8FRtFVczFeG/A5lYjFr80xKkPxKCPTexWOxDEcldoTVz/sjGlrVLUWEFQgt5vv7P561xJyGelGtLArTC/YCBneAIfOddpjSOR4BfJawyO7hI2EdUs3bFnT/3bqHHwcSMaBWkcT/T76yrDsEcUMC7rGkZatbzhsjJHs29DRriVVfhxx201Bs9UWpKXrA7NFaAO7HskX9CEBi19XRGVWfs97SEnQVTR8AFQtZ95VvrZ6fk/UqbBYLcTRHE9aahE9LEaWZiEiF6WfAVm0olViN12ceQ++GXf1Md9sJpv+Sghn2RvkkfTy1GC/7qYewcsbrUKiO3uc4ePZZ8K/y2lcff/o0wQ6OOJD5di7JFl0GEyMwed9rCuwCQ+QruHPf82zI2XLS7L2Funwgln/8y83SG2GUwYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2NFcmk5dzcyTnJ0MzFYM24wc1FDR0R3eXE2eHFGUlF5NGFlMWkzdmY0RG80?=
 =?utf-8?B?YUg4aEV6UHpXZUdDM21iYjdzQUlDdENWQ08yclRqT0N3OEdZQU56VEtJN1RG?=
 =?utf-8?B?ajNGQkR4QTNPYTduN1Z4VEROVXFyTXpCNVIwNVRpUmFmb00rQ1pyYU9jRE1l?=
 =?utf-8?B?Y0RrcVpQajBEUTZkRG1wd3hwMDJOUDdHYnh2MWFXUmExQmg0UEtsTmtudURF?=
 =?utf-8?B?RTJMaTNSKzJ1OTY2cm1xZlR4aDBVeDVueDBhNkFtRWc0YnV1bkg2TytlNmFp?=
 =?utf-8?B?N09OaTJhY3ZiOWNrcGNNZ0hweGF3NStKd3FJNVRqRHQybjZPVHYyRGN6UlNh?=
 =?utf-8?B?Tm40eGpuOEFXSExpUXIxSU1VVzlxZzlCNGpPL3ltUkwreGJwZ3V6TGZUSHdH?=
 =?utf-8?B?UHV2M2R6YlV1Mmp6cmh6ci9VUDUzRWZBS2Q4QzZpVTBlUXJRcU5iOHhmbGZJ?=
 =?utf-8?B?QWRQTDdnWko0QVNvdGtRVXZJYVdpc3l4eWZ4bHJ4Vlc1amZjTDh6U1VwOEQ0?=
 =?utf-8?B?ZFp5WCtjNk1IRGZLSFhXb3drMzl1TXBNcHk5c3lLbWlBcUFyeVZ3anFNQktM?=
 =?utf-8?B?RDZpd1FQRkZvUXp6NTk1Y0xhUHlJTjZKejZkZWJDR2c1eXVUcVk3dk9Lb1Bu?=
 =?utf-8?B?T1pkbVNGVVA1OENGUlo0Mm5mdGdTb3pTL0ptSzBvZFpJUWlmWkF4MCtmR0Q3?=
 =?utf-8?B?T09jQ0RHa2c1NVg1dEZCbkIzYUx1NWJydVMzMFZka0trQkJHRWt2RTFkZ1V2?=
 =?utf-8?B?R2JIU1pkZXJCMi9NSXBCWmVSOGsxejl5b2V2UzkxempUREJlNVVNcUhsdDUv?=
 =?utf-8?B?T0Y5VVY3Z085cmtPSE1IUHJyTE9Ga0k2Nk4wR25KWVl4cHUzTmdqMlZGNGlU?=
 =?utf-8?B?ZnBTV1lwRC9DWnoweXp1T3hYUmZYZHZLVitwNWVkUUdRc0tjbzM1M25GVUxG?=
 =?utf-8?B?Kzh3eUhBczUva1pCaGFlbmFMYmFCb2xkRFgxbDRHR3JTbk0ydHV3bEFEMTd5?=
 =?utf-8?B?dWZPcjlOK3N3Z1A1d3FNamp5YlAxazBvYUNKeFBVa0tTQWJYMVZJb1VaNCsr?=
 =?utf-8?B?NkszY1FucXpFL1RRVlVXWktBTGV0SmtmR21sUHNTY1FJVGVQdVZXUmF2WHRJ?=
 =?utf-8?B?N29zMktLUEJYdDVxc2dOa05uSHBpeXNHMytjSGpmM2I4ZXpGaWRmUUZ6SVZ5?=
 =?utf-8?B?VGNtaVIwM3MrQysyVVhpZkVQWk96Q2NVTW52bHQvai9XTGI4NTBIUWZ0OHQ1?=
 =?utf-8?B?VFBXbXFMRDVDWHd2anRDUS9vZmRvenhCVnlJak52YmZScUNoZ1RUS0gyTWM4?=
 =?utf-8?B?d3VVeURqVlRaUzZUSkVyL3RPVnlqWWJ4TG9vRnRlOHpFNC9UVVJua2xYK2xi?=
 =?utf-8?B?WjUrV2ozTXllMG5zc0Vtcmp4dkhMcUJoaGhuNkpqWFhXZnZRRHFXUDczQkRs?=
 =?utf-8?B?QVFGOHNuTUw5TlhkRTMzR09yNnVBNWwxY01rMGQ3RHZaNXZIUFRGT1Y4ZkU5?=
 =?utf-8?B?UEUyYW9YQlR6eVRqY2NlaVBWSjlHVmF2UFc5Z3hJZmNBRFNhMGNvT3ZxN2Qy?=
 =?utf-8?B?STU3WUVJVGZjd1FsKzNIWjhuQUVOTm1vNGszWForNmRwQUlIOU5ONXREOFg3?=
 =?utf-8?B?dHlJanVic21mNG1nTG5ZUk1uaE80c2N4dGFVU0VsaUNRRGlNcFFqTFc4QWFZ?=
 =?utf-8?B?OTJOWjNiSGVSRTZKbmJ1S2w4Wjl0bVRrN3d1RW9MaEtLbnQvbnFZemR4cGlG?=
 =?utf-8?B?c0JWemE1enA2eW9MWEtGNG40azhJVjZGcGJHdXU4Y1UzSDV4WUdFQXZWTy9M?=
 =?utf-8?B?alM3TVJ0c2w5Wk5aTmVtOWFqbFhBbDBndVI4Mk5PV2NUQVZIQmVzWDkrU3lW?=
 =?utf-8?B?cjBnVXVPZitFejlrZThEbWNyUUE1UmhxejF2am5EaVlnbFBCN2dESVlOWkZ3?=
 =?utf-8?B?RDlaMldGeDREVERtQU96V1ZqNUFUQ3FwK05yNWhoTWFwTVRwTTRZT0ZrUHV1?=
 =?utf-8?B?endsSzNOaENhanFBMmVLbHU0TGF1RVFPaHFxRDBoV2c3dHpnZ2hqMmFtbHky?=
 =?utf-8?B?aEl6WlhpM0dCcjBHcXFEbFd1R3g3bEhNbFdaK1h3cWVWaUtTajVGbmgrQkRx?=
 =?utf-8?B?aTMrZEd0Y1ZucXBoblA0ek15RVk4amlIOVNtZU94MG9aV0tLdzFCWmFxTjlB?=
 =?utf-8?B?Qks4dVU2ZmljcEl4WlQzMG5BZGNGT1VDVnJWc3pyWGhScWwwQjRnd0ZQN0cy?=
 =?utf-8?B?bUdsMGhVR2k3dUhtSlpENlRsNHVia1JDTnpUMW9rNGNscDlTZlUza2lzaHJq?=
 =?utf-8?B?S0dQVFNNMDRORUNQazhxRTlKbWdsS1FRY2syeGVIMTZGdlZoemxwUng5K1hE?=
 =?utf-8?Q?OPlJnvev6jSncn73+vtGDeabXK1vvca1aT1fQhMzltiAk?=
x-ms-exchange-antispam-messagedata-1: kns/Tkhewq1A639LKcjKzLDYlXNrufTEO7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5944C7BD403A1C42AA4D700ED5EFF93A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XyLGi2mueiX8wSnwdExzUsNVxPPOwOOIVVQa9alZ3gGdWYvPhwZvHT94uv0YW0RoWpRIQURW234czTADyXdaz5q4leCi6FCc8rS3t1JUPP00FjxeVr2EjLpOW2OlMTMm5sCsjOAAddO5bz+M1gfaiqNaTKw5PG/oULq/rc5SzoCVoex100Q8FM7H7Oqc1Ncccfkv/+Pi/dZ1EL5Kr4kJmykFzBM6vh40ToZ4SrizFwk12aWV7G088MUeyNPbKr26pkU3L0OKi56iC1Ao/XPdv0S2nptAuR2i2FejGV2PdszZYkB24mwePzpLSeKAuh5FYqmKLXrKRZJmgziP/s01uA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3DjM9d+uVcjxXBo2sB1JQyk5PiO84Q4gcyrv9sA2JV+F7T56hxWEfZtziNp/xVvzyYkuJxPHZqJ+DdUOqPlHkbcTyzXOS8McJU535lnuFVbQHM+AAyBCITD6Z5h1Wkk5veLeSCjOBK0sgI3nLB/TrcyPLLJzzy1sjqi4fzfw/pPYxUYjHlbvzl4uq+Allk4AeZVs0xX1/p8yGv0Kcl+iqUlCy5D6cX8BOoIvsoH/FGdxrCugHk7UIgTkRM3NuQtixch50LeQ69cySAkgrl5+ik5x3FSZDY/Q6qqV4EM2BLbPDx6ArpGCCK8LbjZoxt3P0edJNYMTER+2PO/I6X9U8kwNrxr9EdG/+2vuNycHhQ+TOCzXkGrVWF7fabOVDP8bRrdNuzo/NG/uh8ns4Kv+CUCqnvzmAvpHNgnlSsbDCwPLSRMvE3VYkTdaQx0cmyyZwhod80aKJfymognOfycNyTq8ZyiiNFvTTizk/p5Sq4yF3YH0xuBZgT0V480uJS2gmuOWe6vJoWE8sKcwiRQI7FCzRTaMNXGYb8GZVQiEQpemMJM/kBkgzjDu4EELs6tn2PW8tSZkxIdhNWQ2hqwqWKBTQrhwrWUJHaUghKDAzFgr7QKZmTqRe4LXj8Tt1kfs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4194115-1f08-470c-693f-08df095d046a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:45:22.0499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1DWZtaHSX/Ijp+ueRZL7Nt6DXmPnEVaKXNDL6tvG3QTTZfhEwGhigckbAk3AzPFsaBzJGyyanOBwiKcZhnAG6RaH0J1cTLiDFf6A2VPaSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
cmlzY3ZfaW1zaWNfY3JlYXRlKCkgbWFwcyB0aGUgZGV2aWNlIGl0IGNyZWF0ZXMgaW50byBzeXN0
ZW1fbWVtb3J5LAo+IHdoaWNoIHByZXZlbnRzIGl0cyB1c2UgYnkgU29DcyB0aGF0IG1hcCBkZXZp
Y2VzIGludG8gdGhlaXIgb3duIG1lbW9yeQo+IGNvbnRhaW5lci4KPiAKPiBBZGQgYSBNZW1vcnlS
ZWdpb24gcGFyYW1ldGVyIGFuZCBtYXAgdGhlIGRldmljZSBpbnRvIGl0IGluc3RlYWQgb2YKPiBj
YWxsaW5nIHN5c2J1c19tbWlvX21hcCgpLiBBbGwgY2FsbGVycyBwYXNzIHN5c3RlbV9tZW1vcnks
IHNvIHRoZXJlCj4gaXMKPiBubyBjaGFuZ2UgaW4gYmVoYXZpb3VyLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIg
RnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBp
bmNsdWRlL2h3L2ludGMvcmlzY3ZfaW1zaWMuaCB8IDMgKystCj4gwqBody9pbnRjL3Jpc2N2X2lt
c2ljLmPCoMKgwqDCoMKgwqDCoMKgIHwgNiArKysrLS0KPiDCoGh3L3Jpc2N2L2FpYS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNiArKysrLS0KPiDCoGh3L3Jpc2N2L3hpYW5nc2hh
bl9rbWguY8KgwqDCoMKgwqAgfCA1ICsrKy0tCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaW50
Yy9yaXNjdl9pbXNpYy5oCj4gYi9pbmNsdWRlL2h3L2ludGMvcmlzY3ZfaW1zaWMuaAo+IGluZGV4
IGZhZTk5OTczMWRmZi4uODI5NWIxZjE0NDUyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvaW50
Yy9yaXNjdl9pbXNpYy5oCj4gKysrIGIvaW5jbHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgKPiBA
QCAtNjIsNyArNjIsOCBAQCBzdHJ1Y3QgUklTQ1ZJTVNJQ1N0YXRlIHsKPiDCoMKgwqDCoCB1aW50
MzJfdCBudW1faXJxczsKPiDCoH07Cj4gwqAKPiAtRGV2aWNlU3RhdGUgKnJpc2N2X2ltc2ljX2Ny
ZWF0ZShod2FkZHIgYWRkciwgdWludDMyX3QgaGFydGlkLCBib29sCj4gbW1vZGUsCj4gK0Rldmlj
ZVN0YXRlICpyaXNjdl9pbXNpY19jcmVhdGUoTWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFkZHIs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVpbnQzMl90IGhhcnRpZCwgYm9vbCBtbW9kZSwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90
IG51bV9wYWdlcywgdWludDMyX3QKPiBudW1faWRzKTsKPiDCoAo+IMKgI2VuZGlmCj4gZGlmZiAt
LWdpdCBhL2h3L2ludGMvcmlzY3ZfaW1zaWMuYyBiL2h3L2ludGMvcmlzY3ZfaW1zaWMuYwo+IGlu
ZGV4IGQ2YjQ2Y2RjYTIyMC4uMjZkZDEwYTA0NjJjIDEwMDY0NAo+IC0tLSBhL2h3L2ludGMvcmlz
Y3ZfaW1zaWMuYwo+ICsrKyBiL2h3L2ludGMvcmlzY3ZfaW1zaWMuYwo+IEBAIC00OTUsNyArNDk1
LDggQEAgdHlwZV9pbml0KHJpc2N2X2ltc2ljX3JlZ2lzdGVyX3R5cGVzKQo+IMKgLyoKPiDCoCAq
IENyZWF0ZSBJTVNJQyBkZXZpY2UuCj4gwqAgKi8KPiAtRGV2aWNlU3RhdGUgKnJpc2N2X2ltc2lj
X2NyZWF0ZShod2FkZHIgYWRkciwgdWludDMyX3QgaGFydGlkLCBib29sCj4gbW1vZGUsCj4gK0Rl
dmljZVN0YXRlICpyaXNjdl9pbXNpY19jcmVhdGUoTWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFk
ZHIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVpbnQzMl90IGhhcnRpZCwgYm9vbCBtbW9kZSwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQz
Ml90IG51bV9wYWdlcywgdWludDMyX3QKPiBudW1faWRzKQo+IMKgewo+IMKgwqDCoMKgIERldmlj
ZVN0YXRlICpkZXYgPSBxZGV2X25ldyhUWVBFX1JJU0NWX0lNU0lDKTsKPiBAQCAtNTE4LDcgKzUx
OSw4IEBAIERldmljZVN0YXRlICpyaXNjdl9pbXNpY19jcmVhdGUoaHdhZGRyIGFkZHIsCj4gdWlu
dDMyX3QgaGFydGlkLCBib29sIG1tb2RlLAo+IMKgwqDCoMKgIHFkZXZfcHJvcF9zZXRfdWludDMy
KGRldiwgIm51bS1pcnFzIiwgbnVtX2lkcyArIDEpOwo+IMKgCj4gwqDCoMKgwqAgc3lzYnVzX3Jl
YWxpemVfYW5kX3VucmVmKFNZU19CVVNfREVWSUNFKGRldiksICZlcnJvcl9mYXRhbCk7Cj4gLcKg
wqDCoCBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoZGV2KSwgMCwgYWRkcik7Cj4gK8Kg
wqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24obXIsIGFkZHIsCj4gK8KgwqDCoMKgwqDC
oMKgIHN5c2J1c19tbWlvX2dldF9yZWdpb24oU1lTX0JVU19ERVZJQ0UoZGV2KSwgMCkpOwo+IMKg
Cj4gwqDCoMKgwqAgaWYgKCFrdm1faXJxY2hpcF9pbl9rZXJuZWwoKSkgewo+IMKgwqDCoMKgwqDC
oMKgwqAgZm9yIChpID0gMDsgaSA8IG51bV9wYWdlczsgaSsrKSB7Cj4gZGlmZiAtLWdpdCBhL2h3
L3Jpc2N2L2FpYS5jIGIvaHcvcmlzY3YvYWlhLmMKPiBpbmRleCA2NTE1NTJjOGY5NzAuLjQ5Y2Ix
NDM0OWYwMCAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi9haWEuYwo+ICsrKyBiL2h3L3Jpc2N2L2Fp
YS5jCj4gQEAgLTUyLDcgKzUyLDggQEAgRGV2aWNlU3RhdGUgKnJpc2N2X2NyZWF0ZV9haWEoTWVt
b3J5UmVnaW9uICptciwKPiBib29sIG1zaW1vZGUsIGludCBhaWFfZ3Vlc3RzLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBQZXItc29ja2V0IE0tbGV2ZWwgSU1TSUNzICovCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgPSBpbXNpY19tLT5iYXNlICsgc29ja2V0ICogKDFVIDw8
Cj4gSU1TSUNfTU1JT19HUk9VUF9NSU5fU0hJRlQpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgaGFydF9jb3VudDsgaSsrKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByaXNjdl9pbXNpY19jcmVhdGUoYWRkciArIGkgKiBtX2ltc2ljX3N0cmlk
ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2X2ltc2ljX2NyZWF0ZSht
ciwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWRkciArIGkgKiBtX2ltc2ljX3N0cmlkZSwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJhc2VfaGFydGlkICsgaSwgdHJ1ZSwgMSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9tc2lzKTsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IEBAIC02MSw3ICs2Miw4IEBAIERldmljZVN0
YXRlICpyaXNjdl9jcmVhdGVfYWlhKE1lbW9yeVJlZ2lvbiAqbXIsCj4gYm9vbCBtc2ltb2RlLCBp
bnQgYWlhX2d1ZXN0cywKPiDCoMKgwqDCoMKgwqDCoMKgIC8qIFBlci1zb2NrZXQgUy1sZXZlbCBJ
TVNJQ3MgKi8KPiDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgPSBpbXNpY19zLT5iYXNlICsgc29ja2V0
ICogKDFVIDw8Cj4gSU1TSUNfTU1JT19HUk9VUF9NSU5fU0hJRlQpOwo+IMKgwqDCoMKgwqDCoMKg
wqAgZm9yIChpID0gMDsgaSA8IGhhcnRfY291bnQ7IGkrKykgewo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJpc2N2X2ltc2ljX2NyZWF0ZShhZGRyICsgaSAqIHNfaW1zaWNfc3RyaWRlLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2X2ltc2ljX2NyZWF0ZShtciwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIg
KyBpICogc19pbXNpY19zdHJpZGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZV9oYXJ0aWQgKyBpLCBmYWxzZSwgMSAr
Cj4gYWlhX2d1ZXN0cywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fbXNpcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
ZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3hpYW5nc2hhbl9rbWguYyBiL2h3L3Jpc2N2L3hpYW5nc2hh
bl9rbWguYwo+IGluZGV4IDk0ZjlkMDJhMDBiOS4uOWViNjA4ZjhjNTc4IDEwMDY0NAo+IC0tLSBh
L2h3L3Jpc2N2L3hpYW5nc2hhbl9rbWguYwo+ICsrKyBiL2h3L3Jpc2N2L3hpYW5nc2hhbl9rbWgu
Ywo+IEBAIC02NSwxNCArNjUsMTUgQEAgc3RhdGljIERldmljZVN0YXRlCj4gKnhpYW5nc2hhbl9r
bWhfY3JlYXRlX2FpYSh1aW50MzJfdCBudW1faGFydHMpCj4gwqDCoMKgwqAgLyogTS1sZXZlbCBJ
TVNJQ3MgKi8KPiDCoMKgwqDCoCBhZGRyID0gbWVtbWFwW1hJQU5HU0hBTl9LTUhfSU1TSUNfTV0u
YmFzZTsKPiDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtX2hhcnRzOyBpKyspIHsKPiAtwqDC
oMKgwqDCoMKgwqAgcmlzY3ZfaW1zaWNfY3JlYXRlKGFkZHIgKyBpICogSU1TSUNfSEFSVF9TSVpF
KDApLCBpLCB0cnVlLAo+ICvCoMKgwqDCoMKgwqDCoCByaXNjdl9pbXNpY19jcmVhdGUoZ2V0X3N5
c3RlbV9tZW1vcnkoKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhZGRyICsgaSAqIElNU0lDX0hBUlRfU0laRSgwKSwgaSwgdHJ1ZSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMSwg
WElBTkdTSEFOX0tNSF9JTVNJQ19OVU1fSURTKTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDC
oCAvKiBTLWxldmVsIElNU0lDcyAqLwo+IMKgwqDCoMKgIGFkZHIgPSBtZW1tYXBbWElBTkdTSEFO
X0tNSF9JTVNJQ19TXS5iYXNlOwo+IMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudW1faGFydHM7
IGkrKykgewo+IC3CoMKgwqDCoMKgwqDCoCByaXNjdl9pbXNpY19jcmVhdGUoYWRkciArCj4gK8Kg
wqDCoMKgwqDCoMKgIHJpc2N2X2ltc2ljX2NyZWF0ZShnZXRfc3lzdGVtX21lbW9yeSgpLCBhZGRy
ICsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaSAqCj4gSU1TSUNfSEFSVF9TSVpFKFhJQU5HU0hBTl9LTUhfSU1TSUNfR1VFU1RfQklUUyks
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGksIGZhbHNlLCAxICsKPiBYSUFOR1NIQU5fS01IX0lNU0lDX0dVRVNUX0JJVFMsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFhJQU5HU0hB
Tl9LTUhfSU1TSUNfTlVNX0lEUyk7Cg==

