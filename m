Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1448CCA463
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWqm-0004wV-0Z; Thu, 15 Oct 2026 21:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHWqh-0004wB-UZ; Thu, 15 Oct 2026 21:35:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHWqd-0007Nq-KP; Thu, 15 Oct 2026 21:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792114503; x=1823650503;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=obV1AM9o3wOoUkef0bvtj0PQ8aSU+XZLBa8VHCFzhnE=;
 b=pKBPuhupiWUq1Zs9UDUNZRhA4vNhnm8yV5g9BSYG29Id2Rhtp3roFdPD
 0r9nf0Rr+zvyV63gU873O9JfJEjJ6Axk3ZjX84WqyfV6G74okL68KIDF4
 23N+UEPVe2KjfRDOx/oak2K+/pPtI6g9Ogb/TwqxwXb5Azs1gmSIWQDe9
 XNd0/HEhkZlQCdYEMGA/AK/VfsTWQOkveiB46DatRpzPy8RbfajSdEVHC
 6X8GJovFEd6YvEaj1JLEZ63DHqSRZREWaM4a13adVdB33gwzZ2SWXjQHH
 jyCqFcYQ883PJunQz1avU+lCn84ZTqQpMReymlfHmVdpA/OxuIxqf5ejP g==;
X-CSE-ConnectionGUID: G86DyI5jQraF+hfPSMu+OQ==
X-CSE-MsgGUID: IYP6ISUzSqikTZrex1qlbw==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="154001711"
Received: from mail-northcentralusazon11010059.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.59])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 09:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFs1b8XirEuJmfW9WHPmPHB2n/BHOkaTn0nPZ+YuC4fRTACcJg7G7kucbT39kJdc6O9AoXc/0oLpG4uii4oR+myT3H6oY6A1o/uacvNZ93uowk2pFUrTPy19XlvVDxZyD3dvjlHU3R1m20AK6FysasPRh4bauUR8YiZvzC86f25D/ahoPhpAzc0mYtU3Th1M+omLENtLeHcdERUwIoBjqcnE9QXuUUJr2FNyN/zqRD5BOoUHpi30MeMQjxrUIuShK/UYSJbIcOGU9hDdbpVGho3OJUOph0ujxx8y2PmboRyLzxKedPjcavtq7chJvfgZjLRYhXpUYh41J4Ktd3iGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obV1AM9o3wOoUkef0bvtj0PQ8aSU+XZLBa8VHCFzhnE=;
 b=FmUhLD3EGk+7OmFWQosvcSe6FrW7etYFqtcQar64502JbkPBniacGoMVQ6F2AAYxj6DyeV4wdH4+jrhIsFz2Kmwty8PFrVMcJeDDCr1vATWN9+An9UXBQwy65FzHa7kMwQXF5UJ8eh8tanmCHjtks51C9t5obDgxNVNeUs+mW5SlM6WqqZSK03297rgLySI886BmpX0/6Xg9TmtZGMGADrNNdlZqExmRcYdz27lquSR8Di4S+Yq7ZaDiiIleRXZBEpJh1Aokte9Xvdzoe1AXitcleg893VcAvT4Z9AcEwTLlEOoE5uLgpMRbMqFwKiWh19fIWC4UHhnERdKmEE9hRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obV1AM9o3wOoUkef0bvtj0PQ8aSU+XZLBa8VHCFzhnE=;
 b=rBIZwt4cJkCIgcNWXOOsWSUYCMaxZI/TsHHEQhfApzRpt95yfZUr+5T5UEVlRgaoR9vhnfAjI87xWzaP8heeEc4BFd9LIUzL+JSG1j17uOJiYTu4ilxeUHN+o8G4A6N2y/xkHDOyzMfYpWsUwkFt07TO0gx8kwzPI7D32EPMHRs=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH2PR04MB6677.namprd04.prod.outlook.com (2603:10b6:610:95::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:34:58 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 01:34:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "deller@gmx.de"
 <deller@gmx.de>, "wangyang25@otcaix.iscas.ac.cn"
 <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>
Subject: Re: [PATCH] linux-user/riscv: preserve rs1 address for cbo.zero fault
 reporting
Thread-Topic: [PATCH] linux-user/riscv: preserve rs1 address for cbo.zero
 fault reporting
Thread-Index: AQHdXAgcR8sY8rwX4ka3iyaIOcnldLb9aOGAgAH8JwA=
Date: Fri, 16 Oct 2026 01:34:58 +0000
Message-ID: <a59d8a445e284dc60c7d2d5a99650b76aa4036aa.camel@wdc.com>
References: <20261014181559.1567-1-wangyang25@otcaix.iscas.ac.cn>
 <b498ad7c-99aa-4aa0-bb18-a09646cbfe70@gmx.de>
In-Reply-To: <b498ad7c-99aa-4aa0-bb18-a09646cbfe70@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH2PR04MB6677:EE_
x-ms-office365-filtering-correlation-id: 52fb8eaf-5e08-415f-ca7b-08df2b25b048
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|23010399003|10070799003|6133799003|18002099003|22082099003|18092099006|10067099003|3023799007|4143699003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: IazeV0F6eYXTX7AtQgJDQ+5ZSbAXRA1tj+8Z+2L6jw+5zXF+RGt+OTnfoW1NFQYeY6Mf/xwMJd/RFj668Vopgyp3JojS9h1c6kHJCBQeV1vN3Su2/jzw9oeb+HA2MY8aNEiUvRBushahIkD9g9jOQAdVamzwnelKi819XEQM8Ckcs0CSTO3FR2QuYv/xUNsCMjWdUUX0v420lcVNX+b113ibkR14KzHPFs+T06BVUyYAswYZL4EDmUjCuXgBBgc+DDjPcERybV/g2BJpzkTObfiPReDfrtfF0+nsmbcNPthxmLm6swvEdbs9WdLpkNs4Ou8Mz+pJ9PQYrzHf9cE5E41IAGnvIxVf3YHFB3DRClNkFQu13AHdVacEr2FbUTj0Q+/z84UUBcrZKnKLNEpAo4IPNzXOPHVWfiEMEFsBCn7syPGqTpqUE7hDhcRKkaIKqqzHbMsFRIJbENzVLPYtehk0YcbhrrXB8EKq9nKYtZUAVewh6yU7bkPHDA5iEzXRYTVbf0pVf2gDEVwJeeQahbbnywGkz8e7OotKDm2ulM7vrDqlytHmlUSjeRAjmwWnEH0kDKVz3MEpdQ1R1mfIOTzAuc2ZjBRq4UZHamkt5VlYmDQeRo0z6q40NLEUG4BYn7CE3oiXBNJ00PByG6cb4adX7Y6fyOZ3vXWd6ISZpYQDryjivMJymgzhJXuzM7YmJEDdSpuZaxWbNv5g1bhBgXS9fUnozMALWoPJ5sPCM0o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(10070799003)(6133799003)(18002099003)(22082099003)(18092099006)(10067099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnpwUjBuVU5jS3I3NmRsaXN0MzVKZ0UvVkN0ZHBsL3h4VzRXMk9iSHk0ZHU4?=
 =?utf-8?B?dVFMMlcwbDBNbGpSclF5MlJHcVBvT3V5WGdsbHRSRUI2amFsR2lSL0VlRXR5?=
 =?utf-8?B?UWV5cFNuMjJpUjhRK2lLNzZYNzdyaE85cWNWa25vSmVKeEp4R01YVFJsZ2dw?=
 =?utf-8?B?RXlSVjdsRTUyTm1iaTlWdE4wVnBWYnFHZngzSittam1XQlFQY29QNnF4MmZu?=
 =?utf-8?B?bkFrb1pKUy93M0cxM2RTdWkwLzlkYkR6VzZremZUMFFnQmtUNGJjQWphMXB4?=
 =?utf-8?B?U25VcU54MU5OZWU0R3hkUEo1WDBKMHM1T1BUSGltMlhwRFgraW1FS0J4ZkFX?=
 =?utf-8?B?VTEybEE5VHR0SkNYSnZ2ODNQSnQ2a1pxUHU0dGUvMm9iS0xwZURIQ2JqNDF5?=
 =?utf-8?B?WEl2WThDLzllcDRQYTRFN1JINTlVS3NSS2ZvUGpqS1JmMHBlNWh1QjNqYUdZ?=
 =?utf-8?B?UCtyWFJjUzVRdFlobmdMWlNWK0lIZ0pYc21LNDJwU2QwNHVVVnAwOCtFMlFG?=
 =?utf-8?B?aW5UdjlsdnJvTitZTm5BbmFHZkZWOVBaeWlqL3FKSHVESHM0TFlaUEt2WER4?=
 =?utf-8?B?TXRFWENwNDZkdjd4R2xtWVl4dSs5VjVvMXhETDM2eE9UQ3NMWWhOa2VMVzdC?=
 =?utf-8?B?M2dFN3Z5SE1xSlJYa2NGQUkrS3BudVQ4NUpMVUQrUklvQlRDbG1aZW1nNGhz?=
 =?utf-8?B?dEFlQ3pvbUtLTSsxZGhBaGRaOUYwYzJYYW8ybEpyRUhrWVhKeTVESEpmOHNp?=
 =?utf-8?B?UXZmQnFnN3FoMkowdy9NZXF4eE5SaFBmZE8zQTJaNlpqbkg5d3pmQm4vMStj?=
 =?utf-8?B?c3VMdW5sN1NJU1hORjM0VGN4QThva2c5VkhTSmFWcTVFNmViTkxEZnJZVXpv?=
 =?utf-8?B?bkNubFA5WXBoVzVRaWh2dVUzaC8rQjdoVk1rdVRVMXoyRVdWVjU4cTJLOUlw?=
 =?utf-8?B?UTNpZUVjMEt6MjBXR3loazZzc3Z0MFZ5ejljcUFIeVlnTjRuTVp4d1NSVkJF?=
 =?utf-8?B?eTNyR3dFS3BoV1FHQkxsamFGRUpEL2FpSnh3V2xvVFo0ZkJYRm5RUDRTZHl5?=
 =?utf-8?B?Q2N6Qms2RXlnQ3RZOEtTdVh3a3RrQ0FmZVNHYlAyUVFsV2ZpZjRRR3NsWk1r?=
 =?utf-8?B?TGRGT202aDNBY041dnRDUXViT21UWEE0Z2J2eE9DeGJwQlhtYlZCSlpZSisr?=
 =?utf-8?B?bUtwNzRZTHJ5TWF4YzVKZC9hS2pFY00rNG5hMEhlSVZoanJlV1VxbUErQmRu?=
 =?utf-8?B?d0N4Tkd0N2l0NmtKUWs2T0FoN2JkTGtVc3hHYllpU0lhcW1ielhld05rekNr?=
 =?utf-8?B?alVPSEluWGM0ejdzK1pZTnJweERxK1pwWFFhaEVSR3N1NnZ0YmlScW1xTUdQ?=
 =?utf-8?B?N0Z0eDduejBpTk95cEJ6VjJlemZCL1g0RG9qeXRIYVpCUWJoQklEMjB4bW8r?=
 =?utf-8?B?aUltM2dlTjRDai9oMmlJSStrU2w0aTFUWmJ1ZzhMVUJrakl5SkViUkFyM2ZL?=
 =?utf-8?B?WVBFSFl0M1hQQWU1ZUJJWUUySFlRbnVWUkhIM0ZGKzVIMWVndHloemFiTUJl?=
 =?utf-8?B?Skh2Ykdsejl6QkgzTk4zRUhCMXlqdGFEYmdBb2MzTFNXbXQvK2NpcXd6Kzdp?=
 =?utf-8?B?aE5UY2R0bStkRTVoSUNaSSs4NEVDQTlNazFRUk9zUHgzOHg5MzNlM1hlOHNS?=
 =?utf-8?B?dHF6bkgrYVdYNWhZdzZLSHVNdWVRNGpGc0lwTUFGQWlSS0RiK2J1a0dhdWor?=
 =?utf-8?B?VVFucWx1eEM2NU96QVo1bm51aWRKaDdreWtoNXJOVFp3QW41RXUvb0tZUHhh?=
 =?utf-8?B?V0QwMzBPUGxQZkEyTy96bXJaRkMzVkNyYW5nQk5TVUhBa3FJdU1TekdINkFv?=
 =?utf-8?B?bUQ4dmliQk1NNnc4VnZpeGhLUVJLcHJSQVZmUW5Sck01NHJvYUVFb2t0bWFl?=
 =?utf-8?B?WjUyZ2xneUwrTkxvVXRxTnUyWG9LTjEvOTJqZXZ2bDdIOUhUUU5WUUw5cE9V?=
 =?utf-8?B?TTBhdW9hSFZudzVTMG5tdFN4UDVaRWZ6M05McEw1ZlVDckRPVEIyYk5UU2x6?=
 =?utf-8?B?ZkN1N3pIVGNrZG5VQzJSa0RkNFJWV0l3YUFjd1NkSnVLUzAyVVR4UDNIYWtt?=
 =?utf-8?B?b0N2SDFycUZPdmpIVFF5cTdkcUtxZVdRUUZzUTVSQmtia3hSOHkyMWZGbmxJ?=
 =?utf-8?B?Z2xYRE42dVRzeFJvZVVzeVdJVmcwZWt6MlBaS096NjJwbG5JUVozazAvVWlH?=
 =?utf-8?B?aUlQckgvb0dsYkIxUGpMRmg0M25MeDl3VDBlSEVnREJSNE53NkJsSzVEWDNN?=
 =?utf-8?B?WmJ2MGJNZSs3ck1Zc0Q2MTc0OW9zb0VRTm5WZG5hUmQxeGxSZlBGQklscDFU?=
 =?utf-8?Q?+ZwFVlR51bLjcneAjd5NS2vDKLfhIJ1GZmiOGyo/N6yLr?=
x-ms-exchange-antispam-messagedata-1: HklZHj/TdL0+HouWMME8k5l54Eo66UjPM1M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FABCD54418E9F4478F129C83A5644A44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lTQGlgMdCewYdbpDYjf87k8RB8d2TOcISk2Zp/q4e0Ca4laZE2GXbkRmCyRxKgfun+WlI/omITGAtNHRNeWEWQAi0Bow+PugVNWXVrKob24Rg68vyzNkwxOL1U/GP1zCPqbZ2faIDPNqTy0FOTegJ/PjMiPsA3in+qGVOOtp7+UYxoans/7K12x8xMLIUjFbckvA9lvQUGPiAqujX6bCEAZf7KzfqyF3PiCaunSU2Q/54TmnwV4xqgDF9UYOolZHSfGTIRq1JNT0T9sKrPrifHm8TJkMh4ChMS/UCPTHFs+QxWVn0VsnYyhv2kUyn0vfvufu9tjl77tfUOB2zSHvHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LYUOppvZt5NNuTeLl1CqyETUly+l3vrm2DGGIksW9MwBmbE0w1zZRxW9/I1Ab4jpBEMSLFw5OK4czCDY/3sr9IR1RI1pKFOeZreV59Yo3Z4A5TuCgqySvLGc4+JBrKWIv02LqT/aQ393iXPgI4DjpvnOct3bwWNyGMB4zS2g60GXS9GiLkVmxRby6ncTh1OmQXD+cHlJj0qSi+V16Vz9aDQFx/xpXNxBriLfOiRInpnXz5jQlCx4dPsEi+42zH3e4SJpSw2nqi9r5yLNGQp5yx2TzxLxPmAUMi7B/Bzu/k4zWA37dxXASD8WszZZo3vs3ym1J1nw+D68o/ha+yZ3MpjcH2xuXNWFWd6DG1tR4DsRgikqkoXx5GMbnzuSB+XBz6EL1Bkj+ZFC4JOtq+ZLYt7G75qyPPtBf/J+K11iK3EizgJ/PZ3koYgMOdhGbEHjITLwhAUIqwxVIUkWdRrZ6PEUPnvW48VPEp15jKAG0VxwVegXSCX4INMpM4hvCOCqKpvsgenuHYp+zBWbQ8n93etAfdiDsS8lOzzjhI7+4mLVrMC+8MzvPudz4tetBb5nIkqVFJeBAVrlhBmiNUFJsaBd5fLDEub2JgfBJqaUXzeA7+R772ajwh27MAJec4be
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fb8eaf-5e08-415f-ca7b-08df2b25b048
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:34:58.1064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR03cuiV5+2WTJOansWTi41+NwH3dSFnFi6fa5Wp9RnrwKyt62qcCUBsVe0ODAVpf6qQwAKh0aB3N2r3iNVgq9ltdbeFPfI+PTNrMYJnHjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6677
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDIxOjE2ICswMjAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6DQo+
IE9uIDEwLzE0LzI2IDIwOjE1LCB3YW5neWFuZyB3cm90ZToNCj4gPiBoZWxwZXJfY2JvX3plcm8o
KSBhbGlnbnMgdGhlIGFkZHJlc3MgZG93biB0byB0aGUgY2FjaGUtYmxvY2sgc2l6ZQ0KPiA+IGJl
Zm9yZQ0KPiA+IHByb2JlX3dyaXRlKCksIGFuZCBhY2NlbC90Y2cvdXNlci1leGVjLmM6cHJvYmVf
YWNjZXNzX2ludGVybmFsKCkNCj4gPiByZXBvcnRzDQo+ID4gdGhhdCBhbGlnbmVkIGFkZHJlc3Mg
dG8gY3B1X2xvb3BfZXhpdF9zaWdzZWd2KCksIHNvIGEgc3RvcmUgZmF1bHQNCj4gPiBmcm9tIGEN
Cj4gPiBsZWdhbCBjYm8uemVybyAoZS5nLiBvbiBhIHJlYWQtb25seSBwYWdlKSByZXBvcnRzIHRo
ZSBhbGlnbmVkIGJsb2NrDQo+ID4gYmFzZQ0KPiA+IGFzIHNpX2FkZHIgaW5zdGVhZCBvZiB0aGUg
cnMxIHZhbHVlIHN1cHBsaWVkIGJ5IHRoZSBwcm9ncmFtLiBOYXRpdmUNCj4gPiBSSVNDLVYgTGlu
dXggcmVwb3J0cyB0aGUgZXhhY3QgcnMxIGFkZHJlc3MuIEtlZXAgdGhlIG9yaWdpbmFsDQo+ID4g
YWRkcmVzcyBpbg0KPiA+IENQVVN0YXRlIGFuZCB1c2UgaXQgd2hlbiB0aGUgZmF1bHQgaXMgcmVw
b3J0ZWQuDQo+ID4gDQo+ID4gVGhlIHNhdmVkIGFkZHJlc3MgbXVzdCBub3Qgb3V0bGl2ZSB0aGUg
aW5zdHJ1Y3Rpb24gdGhhdCBwcm9kdWNlZA0KPiA+IGl0LiBUaGUNCj4gPiBoZWxwZXIgYWxvbmUg
Y2Fubm90IGd1YXJhbnRlZSB0aGF0LCBiZWNhdXNlIGEgc3RvcmUgdHJpZ2dlciBvcg0KPiA+IGJy
ZWFrcG9pbnQgb24gdGhlIGNiby56ZXJvIGFjY2VzcyBsZWF2ZXMgdGhyb3VnaCB0aGUgZGVidWcg
cGF0aA0KPiA+IGluc3RlYWQNCj4gPiBvZiBvbmUgb2YgdGhlIGZvdXIgZmF1bHQgY29uc3VtZXJz
LCBhbmQgYSBsYXRlciB1bnJlbGF0ZWQgZmF1bHQNCj4gPiB3b3VsZA0KPiA+IHRoZW4gcmVwb3J0
IHRoZSBzdGFsZSBjYm8uemVybyBhZGRyZXNzLiBBbHNvIGRyb3AgdGhlIHBlbmRpbmcNCj4gPiBv
dmVycmlkZQ0KPiA+IG9uIGV2ZXJ5IHRyYXAgZGVsaXZlcnk6IGF0IHRoZSB0b3Agb2YgcmlzY3Zf
Y3B1X2RvX2ludGVycnVwdCgpIGFuZA0KPiA+IGluDQo+ID4gcmlzY3ZfY3B1X2RlYnVnX2V4Y3Bf
aGFuZGxlcigpIGZvciBzeXN0ZW0gbW9kZSwgYW5kIHJpZ2h0IGFmdGVyDQo+ID4gY3B1X2V4ZWMo
KSByZXR1cm5zIGluIHRoZSBsaW51eC11c2VyIGNwdSBsb29wLg0KPiA+IA0KPiA+IFRlc3RlZDog
dGhlIHJlYWQtb25seS1wYWdlIHJlcHJvZHVjZXIgcmVwb3J0cyByczEgZm9yIG9mZnNldHMgMSwg
NjUNCj4gPiBhbmQNCj4gPiAxMjk7IGFuIG1jb250cm9sIHN0b3JlLXRyaWdnZXIgcmVwcm9kdWNl
ciByZXBvcnRzIHRoZSBmb2xsb3ctdXANCj4gPiBsb2FkJ3MNCj4gPiBvd24gYWNjZXNzLWZhdWx0
IGFkZHJlc3MgaW5zdGVhZCBvZiB0aGUgZWFybGllciBjYm8uemVybyByczEuDQo+ID4gDQo+ID4g
UmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRl
bXMvNDE1MQ0KPiA+IFN1Z2dlc3RlZC1ieTogRGF2aWQgSGFycmlzIDxkYXZpZC5oYXJyaXNAZ2l0
bGFiLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiB3YW5neWFuZyA8d2FuZ3lhbmcyNUBvdGNhaXgu
aXNjYXMuYWMuY24+DQo+ID4gLS0tDQo+ID4gwqAgYWNjZWwvdGNnL3VzZXItZXhlYy5jwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNyArKysrKystDQo+ID4gwqAgaW5jbHVkZS9ody9jb3JlL2NwdS5owqDC
oMKgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiA+IMKgIGxpbnV4LXVzZXIvcmlzY3YvY3B1X2xvb3Au
Y8KgwqAgfMKgIDMgKysrDQo+ID4gwqAgdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMgfCAy
NyArKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnL2Rl
YnVnLmPCoMKgwqDCoMKgIHzCoCAzICsrKw0KPiA+IMKgIHRhcmdldC9yaXNjdi90Y2cvb3BfaGVs
cGVyLmPCoCB8wqAgNSArKysrKw0KPiA+IMKgIDYgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gcXVldWVkIHVwIGluIGxpbnV4LXVzZXItbmV4dC4NCj4g
SSdtIGhhcHB5IHRvIGluY2x1ZGUgdXBjb21pbmcgUi1iIG9yIEEtYiB0YWdzLg0KDQpXZSBtaWdo
dCB3YW50IHRoaXMgdG8gZ2V0IHNvbWUgbW9yZSBleWVzIG9uIGl0IGJlZm9yZSBxdWV1aW5nIGl0
IHVwLiBJdA0KdG91Y2hlcyBtb3N0bHkgUklTQy1WIHNvZnRtbXUgY29kZSBhbmQgMSBob3VyIGlz
IG5vdCBsb25nIGVub3VnaCBmb3INCnBlb3BsZSB0byBoYXZlIGEgY2hhbmNlIHRvIHJldmlldyBp
dC4NCg0KQWxpc3RhaXINCg0KPiANCj4gSGVsZ2UNCg==

