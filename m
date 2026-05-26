Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE8ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1Al-00052Y-Ko; Tue, 26 May 2026 19:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1Ac-000527-Eh; Tue, 26 May 2026 19:26:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1AZ-00043Y-VW; Tue, 26 May 2026 19:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779838004; x=1811374004;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+RI688xH/jkeTjvmGwUjR0LVEVPfiD/LP8l1mXQ2Mxg=;
 b=H7ryNhB1uzuG/kTvbblVUMaDzKvJXOuLQgefLXNijTRuhMepyfzcgVro
 +Z27h2Nh7/parRJ+SRRG4AZH5NHuBzqTuuhkTfJY6xQDx84HXy2bQIO7P
 RjFngGSzBjoNwIKhWEpR/+sofuYKET7YMRcY52zb8PzpQ3JozC2E43NNe
 0kfLHeNftsNPomLu0ZU8AAMDDgw8y8/DHcmckGt3VwbTD2dHbqgFkeOTR
 Qp0iHagHKJx2H0Bl3U+M0NRGQ/czcilhRcm8MpaRHwz1xmGBoO6Q9gdaK
 AiLTcg8Lk9qs+0YO45sdupX7A6PPDUshZbvg8iP2hySx9oADpAZ1hZo7h w==;
X-CSE-ConnectionGUID: NfQ+vSNMT2maPh6+RIkGFQ==
X-CSE-MsgGUID: xRDEXb0xRPS2Pviuq3I7Tg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="143711818"
Received: from mail-eastus2azon11011001.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.1])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:26:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/Dlgl4VFmogmhWwbLGHmT8MZ39RdXmLaaoSqG+f1a2gzyw/Y6/ARLnWt58L4LxLo7tDCsq0z2adhdB74TZXsissyzPM5wJxg8PU2jsX2CJSkOWpiGif7cLuvFcUF6vA3UZdKCSOM0OGQ7jo6TTuT57bI96XfSCpwusQHT61BoC/9CJr/oxMa/+J5eu6vYlsJ/SCq8A7EYwT2ACDN41TtDAf9XVdbfFKJRSTS/Tj0fdI6DxY6TmQBSTFDPhgbtaKumcmKoRmHHzgaJ6XRZ9u8FFK09KIz6jK50kVtyS/Q4qfLoSnh+FxCAdFmkBbAHw3nwvCcb8HFVWkTT7MawxZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RI688xH/jkeTjvmGwUjR0LVEVPfiD/LP8l1mXQ2Mxg=;
 b=tYACbzdTfsq0nLMqsGewYb0fEcFaaaahWiGPiMMnoCT1Pp3Nvqq+kTGCsVnRaGGtc3MLg+dCj0dzsEnHWR9VR/UCG0lnjvRYrVU5q6aIu9m6fGJbQB15o2AIgOrAuM0UtUCw35sb5pGf9X4Lc2INtkw9oJlrOvRBbUpxc82J8+Q4wlzMqLVfuW9ZZnA5t5a7UmPLdvat962SkIeTntnoXEvcOib/LUbtcyGAY1nVQQK8S2O2KtxlmwAZ06NlCUemTDxSRjeooD2YuplqGOZ9b6CUyi0Zg6naNgnadFKg/Uf0lpise1Iacb4tmsHegK+xsyunHR5/d7+VNrpQ2Pcvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RI688xH/jkeTjvmGwUjR0LVEVPfiD/LP8l1mXQ2Mxg=;
 b=q8dLV3tgDjLT1CEQqmwjJEGF5KpbVh1r3TsJoyyayfUZ5xRAgF7lelx7rvvaJTuN/uwbDh+7GU7/sAH6onfZCMPmc3QBZaKiq8eua6IpYolQFF07zZY7iUcAnow8y/Oref/vls1wpYXylCLqx2Ci7mEVMU2jKfrqIzKHqN9p/xg=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by MW4PR04MB7346.namprd04.prod.outlook.com (2603:10b6:303:65::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 23:26:37 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:26:37 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "anjo@rev.ng" <anjo@rev.ng>,
 "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by
 default
Thread-Topic: [PATCH 3/4] hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by
 default
Thread-Index: AQHc7PYkndpcFCwr3kaXO1Xb7ik7WLYg9EQA
Date: Tue, 26 May 2026 23:26:37 +0000
Message-ID: <44d3e4eadc031734aa089827c6bbcf660acfee15.camel@wdc.com>
References: <20260526095731.63525-1-philmd@linaro.org>
 <20260526095731.63525-4-philmd@linaro.org>
In-Reply-To: <20260526095731.63525-4-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|MW4PR04MB7346:EE_
x-ms-office365-filtering-correlation-id: d0f2ef78-75fe-4b6a-b3e2-08debb7e3b82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|10070799003|38070700021|4143699003|11063799006|22082099003|3023799007|18002099003|6133799003|56012099006;
x-microsoft-antispam-message-info: fCQWd81tcjaYBTMRX2/9rpMDMZ779+BvIIvjXMxBcSM0LVDpojhj3GaqQXZ7xdRZTdKb05RHSX3RfJxghCEBGZ0tePW3Xk+Wjuqspgwgb5vjWXaNHAAp5ImgYsDs4VHtBZCKgxRjGtKR0aKM+AmRsVSzW4Dr6i1eYoO6YEl6DF7PQM0HaZp6TnFrhRGPZKDBxaxhQWV6T8fzSlSPUFToYY8xZygDUpcsiQ4pf+angeSJkk14kFFgFiRXE8l7/WIWix3mw5ouqIG+Ch4BYF5KInMgOmV6/vOBn7vn6Ww/5WKkvO8DdqmYcUnwNJZiIx65/cXVIHJtqNcz1Ha0kTxo35NRges52TIpYI0CAiYNTalXbM13Fi6zzA+fPF9qP/ZISwLrpryXHkSsjpIeHy3zHs+9jQfWZAqHS9hpaOjIS/rfzPY3PUY5XUrLxXM6KjzsUgnEmBhaD5yCc4F9XROSfrP9Adg0M3CSWrdcRS2TEIp858tGVoczUHjArMzRjDJA89DmCKLx7558RFZAHOQHf/nFAMzf9IXooqNb44CMDC7pIFZjG+/nYryogvxQ3xj2KPK31E7rc8dRy5EENIKQt2j7z9Zg9dAbvA4Ta2iRp8ze7PcxvPRZQ5CLSYbSFWa0MsUb9ZKcrHMxupIxoSWT+TBmFnpFTMh5i3DfXe2cK/p+woOQuQsyyliOmHvIeUr/p3YTEvgTERV+FD1bV+bSSIEAEv1V8Okeo9XgCziM1KndMTdbMSPprlwNj+H6uvK5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(10070799003)(38070700021)(4143699003)(11063799006)(22082099003)(3023799007)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVU3QkVwYXV5Rno0NlBjOXg3empGK1JXQ3hvVlI3SlZHK1J0aFRkdFNiSVl6?=
 =?utf-8?B?bEF4U24vRHFNUm94QitMUGljd1NYdmpKeVViblI4MWdaWlRqYUJRSGx2OXE1?=
 =?utf-8?B?dGp4cjR3MTJFMnNzbVNQYTFady9NQ0VNQkxrMzF3eDkrY3BKa2VFSlNtWHYv?=
 =?utf-8?B?S2NiOGRHVVpIR3dsMytva01xcG9oZys3OTNYOUlpT1N2ZVNlZW1VOERWZE4w?=
 =?utf-8?B?Ly8vYkhaUVUwY0MzUkF0SjFCYkRZd3dQNVJibmRxSis1R1pyajZJYi95MGR3?=
 =?utf-8?B?d1h6UU1JMk5QSFZZTXd0TjBMUytQRVY5TWxSVnphODBRRDBsVFI1bmEyQ0Rj?=
 =?utf-8?B?S3p4UyszNEtKWWNwZXpJV3ArU1A2cXJYcnRnaklpbFNna3p6eWZCY1NsMzJs?=
 =?utf-8?B?NjBySGR4OTkvcVZaZjdhVWlTaGVWYjFvMWxHSlpndTZGeExoRU95Rm1uMXhS?=
 =?utf-8?B?aEMwQ2VCWWVySHpPWTN6SStZRnFJQ240MURGZkZ4N0crdTJ6T3JmK1ZUUDlI?=
 =?utf-8?B?UW9VOHpnSURnQTNLWGFvTlVyL2FldmtmTU5IR1A0WmJ5UVpPb0Z3YkJVT0Fl?=
 =?utf-8?B?UldkbkViTHNCTHRPRndTeVhBRVNwQUdMN2NlV3BXUFR5M2lZVzBIZVVaV3Jx?=
 =?utf-8?B?S1JwUTl3c2dlZS9QQjZaai8wQVVEWW1ndUtuL0Y0dDZrMVZvWEhiWlpIeWp0?=
 =?utf-8?B?YktJbXphOEVaMWhhYThpcDgzVWRkdUo0Y0RvMzNYU2FqLzhFY0x2Njc1Q2x0?=
 =?utf-8?B?RThid1hyYU5EemZYUWk3b1E5VmE0d3lVam01dmxWS1FVeW8vaGwrUFlCV2gr?=
 =?utf-8?B?R0dzOGlFbWZ4ekpoVUVFUWdDVFNJOEd4ZWlJYVA0UU84NDlXdjY2bFVBZG0v?=
 =?utf-8?B?YnJ4blBHcjY2OWdIaXJXNDdJZkREcmxydHpkOTVaVERwTGdWbUhZaHR2a0U2?=
 =?utf-8?B?M2UyVXE4UEJPYWkvOHRqQXlaV2hRb3FZeGNOblZuK0hyTnJQZmZ4Qkc3N21Y?=
 =?utf-8?B?SFdiNVQ1V0xpZ0NScEQweWhkL2VqYnFEN0dlSmJ1blNuR1FCNHc4Z2JzL0Rw?=
 =?utf-8?B?cmtkendmQ2lwRnI4eUtiU1JSVzcvOGF1UDBZbXp1aGplYkQyMzAzM3crbXpq?=
 =?utf-8?B?MFcrUFEyc1QyMnlIL0d0MmQ2ejNyNFExcjdzLzVoWUNRNWxnbFVEbW51S3dZ?=
 =?utf-8?B?SnU3TDcyY3NuRk5EYll4Z0VqUDBTcUNWQ3J2ekVJUTR3VExVc1ZrNENlakN4?=
 =?utf-8?B?ZGFnOEJ1bmNDcHgzL2h1TENjeDJ1ZjhBQU5zYlJWNkQ4MWUxTG5aZFI0Mmd1?=
 =?utf-8?B?bVA2cFVNVk0zYWdWcGx1cUErdHlKZkcxZCtMZitsb2Z5Z0JzcG9vajVOUXUw?=
 =?utf-8?B?U3lKUS9qMnFTelNsU3U0YTZvNXJ6V09xcy8rdmxvcXRpb09SZWdkTEc3ai9L?=
 =?utf-8?B?ay9HeDRvK0lkQk11S1ZHSmg3eElkd3VQb3RDQlB0ZTNQT1I4VTlUZjhsZE41?=
 =?utf-8?B?eE5VdGhFNCszd1NJVWFXaVFqSDRCMkUxTG9mTGhzOHljdm5PUnNhTldVUTV0?=
 =?utf-8?B?Q2Q5YjFRRXVPVGNvcUY1UW93SldJTTh2Ym1XbzRqTFZpcGJOYVFyeElkZFo1?=
 =?utf-8?B?NVFVNGlQdkVyOHlOakk2eVd0aFh6R3F3WUJMZlNadXZ3d2xRekxSSlE1enQ5?=
 =?utf-8?B?NGd2M2MxemU2OWx6aXZuWnhTQkRXUkVRVUJ0L1dwS2J5Z2wzNm5qeVMwUjlY?=
 =?utf-8?B?Zk1wVGNtb1F5bDZoS2xqRHVrTTIyRXRSaVRNeFVKZmo0K1hrZngwTC8zKytS?=
 =?utf-8?B?eFFWMDNGRkppY1R3Ylh5WjFvWjdtN2EzWi8vQmVuSjVDUXlJWUVveU53K094?=
 =?utf-8?B?QnFiSHN5L2RBSHdhQmtaeU1oelFuYU9hbUI1QWZYQ1Rtbkg1b3lONnNxNEJH?=
 =?utf-8?B?TDA0UVVuTjUvMHRnZk9QK1d6bGZodDAvWEJjMXJjNHdTZGFoRXcwM3AweUR0?=
 =?utf-8?B?eU9UcmltNTM2SVBmQ21YeDU1WkpZc2NoUjFvNWR5SVJlM09XZ0ZIbTZMQVll?=
 =?utf-8?B?c29PUmY5ZHd3UTR3QjU2VFNKbkxSWWVOSjYyc2VERE9vUEIwZWhCVFBqVGgx?=
 =?utf-8?B?aTMrVyswMGJoUW5uQ1paRXU2MjJzU3ZNSmZScHlPVEtGUEFzeGtJRElxSjk2?=
 =?utf-8?B?QTNmVmEwMjBqN0ZiU2FCWVc0bmg5R29lWkdTbnkwU1FaQTVJWnE0bnJYTHdT?=
 =?utf-8?B?d2FHZ3VEYkRoRThycWtDdzgzRXk4cmxZaEV1S2ZHMWNNZzZZckd2NlZGa29s?=
 =?utf-8?B?Vng5elVEcEhyZTAwUFBQL2U2VkVQc1B6NHRoTUViWlE2VkpBMkNFWlFuVDZR?=
 =?utf-8?Q?lEx5lfidtnn7OvAOXEDjon8nDjvXNfTK7iqjCZ12QfohA?=
x-ms-exchange-antispam-messagedata-1: U1R/E4d3yzZQkmbgIa9EXjyDeRML1LvZiAM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A42AFCB18241848B26D6FF946EA3573@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lrKWL+o08rsQT0e/a12gmb+mwJP9nqEN8qEecO9wHJju9gDNw/6RCPWJkc74ha36E6aKep/HDlbghWj98l031wzAudNZPOQlGLZaBTEtGmfrXrjYfBOMWruIlOPrmYGgkKuLtraeQtYA/upMEXWLSCitw7DpD03dQSTpNXqxhZgDHFC1zQdu3+nY38dR3lRMEIyIC6qdoxvW8azgxsgoq5exxwQ0JqROmWhfOG0RLcKBhtzuRJQc6cjlmoNRn1PSsf1sbaS6GUA/XxnDkyGhR6M/2er1P/xoYnSfnp8faqBsE4tzbsN33F47gxjh8lQwvnVsh85Odk/mBoPwMquCgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N/m+cPIVS3uah2BO41GUWSjX6saukGjyn2husVBkMDeVqLULWSUZAVzxWbAACASpDzAK3Ho1RBcy3jL9ZS2g19yKRc8iRswjom991SfVeiR5OdjO3nQE7zK1f8atbc3ZkBMb7KZcjmxcQscJjosKFujB4ei/5GawT33DdfU183pjUyFxtcYnd5Mu2zNI5mtSmdcPLHLOcg5ePetnxQX2hvDmOM2Zw7fGJJgrsqBIaO9O7WFEoHp6BJ8V9V5ose6smEPW6YB+WTg7wvRQhfxoe5tyUun12CeQ7g8QVlmsX3/KpHHNmwL/QQ0OlcEwku7QoDKa86GwXauJHFYEpuSnmwX4HAR2euJ8/gv1MeHdfpriwoM7QhOd6FbjwkOSswY0J3ox7B/6cxI0BdSykkKTqoZL3b1D1+dumj4q+X8drzEraoLZ4wCHs3aH1MzsUH65TcH5EVh2eS38Nn8fytCj9H5NMGiQ0IwhqKb+zcYAe2/nO5rjgekrBexckGH8vwKIMOxtUcbE2jXqJyU1xJsY7K9Bv7latykVTn903OieoZU/lnXAzZ1zX4EuNUsM4RAWIxlLqZ4SKjz5GgSnrQ7lRhAk1nyLM3QzCmDynkmxGverZTLlUnQ+GYjqDOuEqBWC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f2ef78-75fe-4b6a-b3e2-08debb7e3b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:26:37.1420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW/SrThuNtBpPHuA16BjqSfJFGzFqPRKiWjiZrX+L12XxpagyTYwpAzoOTHcVA+BxWzpMY3ixfgULRuwbV5L5Ia5CC1Wiv6UYUpYlaI8y3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7346
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDExOjU3ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gUGVyIFsqXToNCj4gDQo+IMKgIEFNRCBNaWNyb0JsYXpl4oSiIFYgcHJvY2Vz
c29yIEtleSBDYXBhYmlsaXRpZXM6DQo+IA0KPiDCoCAtIENvbmZpZ3VyYWJsZSBJU0Egc3VwcG9y
dCBmb3IgUlYzMkkgYW5kIFJWNjRJIEJhc2UNCj4gwqDCoMKgIEludGVnZXIgSW5zdHJ1Y3Rpb24g
U2V0DQo+IA0KPiBbKl0NCj4gaHR0cHM6Ly93d3cuYW1kLmNvbS9lbi9wcm9kdWN0cy9zb2Z0d2Fy
ZS9hZGFwdGl2ZS1zb2NzLWFuZC1mcGdhcy9taWNyb2JsYXplLXYuaHRtbA0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAt
LS0NCj4gwqBody9yaXNjdi9taWNyb2JsYXplLXYtZ2VuZXJpYy5jIHwgNCArKystDQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L3Jpc2N2L21pY3JvYmxhemUtdi1nZW5lcmljLmMgYi9ody9yaXNjdi9taWNyb2Js
YXplLXYtDQo+IGdlbmVyaWMuYw0KPiBpbmRleCBiMDQ5NGIxYWM1MC4uMDRhMjAxZGNkOTUgMTAw
NjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L21pY3JvYmxhemUtdi1nZW5lcmljLmMNCj4gKysrIGIvaHcv
cmlzY3YvbWljcm9ibGF6ZS12LWdlbmVyaWMuYw0KPiBAQCAtMTQsNiArMTQsNyBAQA0KPiDCoCAq
Lw0KPiDCoA0KPiDCoCNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90
YXJnZXQtaW5mby5oIg0KPiDCoCNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+IMKgI2luY2x1ZGUg
InFhcGkvZXJyb3IuaCINCj4gwqAjaW5jbHVkZSAidGFyZ2V0L3Jpc2N2L2NwdS5oIg0KPiBAQCAt
MTgyLDcgKzE4Myw4IEBAIHN0YXRpYyB2b2lkDQo+IG1iX3ZfZ2VuZXJpY19tYWNoaW5lX2luaXQo
TWFjaGluZUNsYXNzICptYykNCj4gwqDCoMKgwqAgbWMtPmluaXQgPSBtYl92X2dlbmVyaWNfaW5p
dDsNCj4gwqDCoMKgwqAgbWMtPm1pbl9jcHVzID0gMTsNCj4gwqDCoMKgwqAgbWMtPm1heF9jcHVz
ID0gMTsNCj4gLcKgwqDCoCBtYy0+ZGVmYXVsdF9jcHVfdHlwZSA9IFRZUEVfUklTQ1ZfQ1BVX0JB
U0U7DQo+ICvCoMKgwqAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSB0YXJnZXRfcmlzY3Y2NCgpID8g
VFlQRV9SSVNDVl9DUFVfUlY2NEkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDog
VFlQRV9SSVNDVl9DUFVfUlYzMkk7DQoNClRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIFRZUEVfUklT
Q1ZfQ1BVX0JBU0UzMi9UWVBFX1JJU0NWX0NQVV9CQVNFNjQgYXMNCnRoZW4gaXQncyBhIG5vLW9w
LiBXZSBjYW4gdGFsayBhYm91dCByZW1vdmluZyB0aG9zZSBDUFVzIHNlcGFyYXRlbHkNCnRoZW4u
DQoNCkFsaXN0YWlyDQoNCj4gwqDCoMKgwqAgbWMtPmRlZmF1bHRfY3B1cyA9IDE7DQo+IMKgfQ0K
PiDCoA0K

