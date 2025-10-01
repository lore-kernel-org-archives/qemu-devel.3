Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04D1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tZT-00050K-EP; Wed, 01 Oct 2025 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362a73bd3=wilfred.mallawa@wdc.com>)
 id 1v3tZI-0004tM-7d; Wed, 01 Oct 2025 05:56:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362a73bd3=wilfred.mallawa@wdc.com>)
 id 1v3tYy-0008HB-5e; Wed, 01 Oct 2025 05:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1759312556; x=1790848556;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JD/PlIkSb1TybE7esYNzpJg7EkpDpZmWLb4TVflSDiE=;
 b=D2uGbe2KIjUkB5KYA00q+MJOBG3jHexqH8lJNCvBaxCD6jiYD6nRVkyY
 xwOAaLof1e9GTzoLnqGXNeRbQsuhZWVeRRppZPZjia9oEy+LkauSa1QCx
 Ec2AzCm3M8HQZnk68wWz3+Q6vwyfUkTxNp6YgCyvNGox5cP9hq5/htsp9
 S7fTYdX/HBqh2c6GZZ5O/Wd99puAZ9nL6uyY2G9AOKNB8DgfQFw93zt0N
 IrJB10rgKwze4+Aki3a0TVqyyBrLOIGI70TNRPmNZ7S2qodbu+Hruog4R
 pFNeKlW8NpXY0YxYSYMvkcuEnauP6OuUvtnsX+p7r2hT0EjIGMNVo+Ceo g==;
X-CSE-ConnectionGUID: iYdlrySkSX+XHdqy+zijUA==
X-CSE-MsgGUID: Ha6nhv97STiMl4JOa1dV8A==
X-IronPort-AV: E=Sophos;i="6.18,306,1751212800"; d="scan'208";a="133322763"
Received: from mail-southcentralusazon11011036.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.36])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2025 17:55:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjaE1DBYa/BDMhXcZDc9TtL8neX8XEpRJV69z7wEsaoIRt4ToGQWOJW14DDIuNX9ttJ4eduwF3840ZkmvDCCjumO1j+QWE61E++ottPmfz/gaNVn0KUFJAS6uMFi09IVTKF3COTqmTmfhRccfJoXl6qq1PVDJGcPkbNaLEBjy/IR7jhNYnrZcWNDnMqSBF0L4SAGOCMDrTHFpTbEULkCUcUAZ2KGU7pPLhpklhT6vSlG9kZdIL8s2NxqUxxT1pzNMFsG/v6K/XaPPW0p2glo7VWMEd+a9IquJZaXWChgYTM/xfKbqtZwpq9Ig4pEYwse49w4eJp5ifXRkV1lonu6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD/PlIkSb1TybE7esYNzpJg7EkpDpZmWLb4TVflSDiE=;
 b=wh/aAmgPUkuydoL43bwtZ3BldHJjqsi4UTXZ5GmoHBsuABEAay+2iZf0ders3q1JyoRFvwUmHvRVrq62wvJofWaKVAMUDV4ZZmhK3GW0dBq39UtKiQyvKfCP3LYUrSQ7TsFT7YhisrDZm49oDYyxL3EpHzTxwY6tqkQ6mE8H74fTh1Lax+jY6HUjHyDdStDjWJ4fkC5qaT5wSjrXIAfCSqEx8XzuLqEervesB5wjbOoS3WRZVZL06CnQMFdVBU2+kWLlzGFUvZZtMQeSRM/kD0ID5YDMZ69o/HZaODbFplpCuyGJsg0GNgBXbEru05K8As0Im/eMlATsl0t5SNz32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD/PlIkSb1TybE7esYNzpJg7EkpDpZmWLb4TVflSDiE=;
 b=kir41QiIE3kqz5qapVF5/Xb1DHuVIesZW8b7GYW75AUVA164v/wZDle/ICikF9BsLnIGQuNJI0T7ZLdgFjwmr3sjieGYZVVYC60rrNe7EuwcbSyShr/hJGiTwtZ9Dd385fjoq9kU3tpHKjuDYAqVC0IAK6tUwty7vVXgYTPeduk=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BN8PR04MB6417.namprd04.prod.outlook.com (2603:10b6:408:d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 09:55:41 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 09:55:41 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Thread-Topic: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Thread-Index: AQHcI4qtv0XdpU+L30SCZvTDvk+rlrStG5KAgAAQcIA=
Date: Wed, 1 Oct 2025 09:55:41 +0000
Message-ID: <14f6c715e681789589f3682be4ec9b50bbd55660.camel@wdc.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-3-wilfred.opensource@gmail.com>
 <20251001095651.0000576a@huawei.com>
In-Reply-To: <20251001095651.0000576a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BN8PR04MB6417:EE_
x-ms-office365-filtering-correlation-id: 25531c1b-080e-4265-c44e-08de00d0aebc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dFNSeVh5NUxoNVBNQTJ4NDdhV0h5Wjl4RFpZNmtyNlc1cC9YYytUaUl4Yi9E?=
 =?utf-8?B?clZ2ZnpWQjA1VTNsYVAxcmNzY2NWS1g2NzNJQ3VsN3RXZkQ3NVBKY3BPdGQ5?=
 =?utf-8?B?WlIyaTNQUFRpMWpacnc3bWpIN1lUeFJISGtnWE1GcVMxWTZSRWVjTjZaMEYx?=
 =?utf-8?B?cjVBQTA0L3p6NFdYZHh2T24yTFZsYWc0OThBenRBYXFVWEZOR3dWeE9CclZR?=
 =?utf-8?B?dUZkSzZ5YUZVSlNiRi9pL2FCZlFJajhiOVFka1VpNml1eDdML1JsT2pwQnBM?=
 =?utf-8?B?MmRMMXJRZHFzVnRLZkdhdnd0VDZlZTBhYjljZTJBaE0yd0lybjYwdXZmeFM0?=
 =?utf-8?B?eFVVNWJrejhoUzA4cVNzb2taWml4MFRqazJQMTFCTldCbVlUUWtrSEhtVnMy?=
 =?utf-8?B?YmhmRldjbDJoclNXdXYzUERBeVhDbmNraG5qTUszMlFBc0hNUlFlSkdQQlBj?=
 =?utf-8?B?WjUwY0ZJS2pOOVAvRnE2S3IxeVRXYWdYaW10T3VVMy9VVzBvdFZKR1NrVUta?=
 =?utf-8?B?Yld2bHAvQWdObGpVY3FIYUtxNGdqWGc3V2FOMFRSYmk2MlZCZlhublpBeFU5?=
 =?utf-8?B?akszSHlHTjQ4RDU4bzZxSjBYb0R4VkJ2RndhN2E5MU5pejVzSEs2M3REVHJO?=
 =?utf-8?B?OEFQZWI1bXVIeXEwazJvNmdwRzViN01hRUhWeG9VeWlzVituanV2REcxSnBm?=
 =?utf-8?B?QWlCTnZKT3JwZGw4c242bkR5QTVxK202bFJiWHg5U2tjSmJWZk1YQVRaU1BJ?=
 =?utf-8?B?NXJZMU04S1d1M1NtRFJBMi8wUEJMRnlQQllYYnZiaWdMeGJxT2oxNzM1NWdH?=
 =?utf-8?B?MndRQ3dkZ1Fici9ldnpGMEd1SC9mdEwxZ0doTkY4QVpUT1B0Z3VhY0F1Skp5?=
 =?utf-8?B?dHZHWmFLMzVTSmRTMmNDeThCLzg0MStKcG9GUTJLV08zQzhpYmNQdHVFNVpG?=
 =?utf-8?B?bGo4aDlnZmpneE9YWTFCaG13Rk9EWFd1UzNDWjIwWmNyTDlCcGRhcm9RMWV4?=
 =?utf-8?B?SGF2MlpvTHdDclphdHdPblBkVWt4S2s5TDVEdUdEZWZ6VGVhc3FWYS9zZFJC?=
 =?utf-8?B?ZnFqbVNvVk1ZUzBoczZReFN0SVlIeXZWQVBSaEVoK0VNd20yd2F5dEVXYTJZ?=
 =?utf-8?B?T1hjWTNHOUpYMlBFQVBVOUlIdjdleFNtWCtnd1BjVEFLdnRCQS9abDdMbU8z?=
 =?utf-8?B?Yk1TbDVQcEI4OTBBQXVPb1h1NDN3QW9PSkVHclM5WVk0TldXZG1NZmFoNm5G?=
 =?utf-8?B?YnZzMk5PcFU1dzZkYUJpOW05NEh5UWowcDlDUTlXK0pNWDQrelVXVkJHRzBm?=
 =?utf-8?B?b1pZS2VRMnZsSzM4dVpITzg5b3dOQ2M4MFNSOVR0OVJlSGRnNWw4VDNCcHBx?=
 =?utf-8?B?OTA4WUtja05hL0pZdkUxM0hLS0puem8zSmxsT1FDQU9wUGtUNEFrNDRmYThZ?=
 =?utf-8?B?YTVjRkVmL2ptZTB2WW1ETEd2dFdjclR5VE9oNnBsOFJ2UWFtQ2p1MzZmbjlx?=
 =?utf-8?B?TEZ3Q0p6Zmd3aE5mK3lzajdWaVgxaEdNZjcwbmdFZjF0ZXFjZ2gzTWpaV0Vj?=
 =?utf-8?B?U3IvM25EeDBORTVCRG5DNllPTE5aSGdzQlVoclZlVjJVd0tKZ1IrZytpUXdW?=
 =?utf-8?B?a1JUclNaK3EzYUw0UmV1WndQd1RSN0hadE1adTRsUi8xUUhwVnEwa25LalBF?=
 =?utf-8?B?dm5EaUVvSjlqOXdTUW9Kb1JJeVkvUG5adTlRcElWK2VNakpMVlNGTlRpK0Fz?=
 =?utf-8?B?bVpKQnpRRDRFUWR6bEFpeEhPRkI2MHVkb0tnVS9NMXZXalpFTUhPb3krLzhB?=
 =?utf-8?B?Rkl0cS9jRW5ES3VFTHBGTEhwRjFaSHIycnZESXUwMkVvY1NTaDMxZW9MejJF?=
 =?utf-8?B?b1ZRMmREZGQraGo0MTB1cC84dUhpLzdXZytiUlhhdExFbjgvTkI5UHIyWWJ3?=
 =?utf-8?B?TjFUbnZ3WCtKVzJLOXZXTWNXd2NrdHVGbU13Mk0yZjVWNEp1cmk3LzRBT3ZP?=
 =?utf-8?B?RGZMTjJNd2dyRjU5R0tseTdXNjRTaG1NWGUybVo1WktUZVYzT0RsRVlFRGJZ?=
 =?utf-8?Q?SoenYA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek9HRlJHY3dIS2kwZG9wQ3FFUlZxYTRqN1A1VjROa1NYdUVPSGJuL1ZYNlA0?=
 =?utf-8?B?VG1SNkxDOVhJWTBlTFpRRy9pYkpzYmRRcUFIYVJGTWVCblFJbngvak50ekEz?=
 =?utf-8?B?M2I5M1hiMUw2bnBISkVEVVEzVGE4WGFYYWQxZk5CeEFiT0tUY25SWGd2eG9O?=
 =?utf-8?B?Y1M4NW85UThCUHZueXpmSVRYVnVmelVkY1RqbmV5MStYczljY2I5clFkV0VG?=
 =?utf-8?B?OUlySE9jR1pkSlRiLys2cWJkOTlhNERNNDB2bHZJYkUybVI2UHdYUzd0aE5H?=
 =?utf-8?B?ellKbVRLanNuZitKQTNJandSSXJXeUlWaVQ3MDlGOVptWHk4V0VqWUNadzNv?=
 =?utf-8?B?T0NUb2lrRnVSeVdxK1FGZ3ErV0FKR3VwaUp4NGl2QmxpaXBqL3ZkbFdpUzJs?=
 =?utf-8?B?U0FzUjhQZzVQazFMcndQZWJJdlgxa0JMbXlPNmR1eFROajVZanFIaUR1UjZw?=
 =?utf-8?B?WTJRVmZjaTlRY3JqNEJlaEtOSm9EbFh6MnZvMnBUYnorTE5lWldacit1T0xk?=
 =?utf-8?B?S2s3N0k2QXE5UGRlQlVYamsreHZ3eVZ3eHFxUE9CT1RTeXZoVCtiUjdSUUJK?=
 =?utf-8?B?ajRwb1hSZlB5RnhBaWE0ajd0TVJ4dldJdkUyYnhlYnFrOEFCNVBCMHN4WHJi?=
 =?utf-8?B?ektEYVh3M3V2eWxpOHlNcjdOVlBtTVlwMFVHbkJMMy9NRUJCbDZaUHdIelV3?=
 =?utf-8?B?NkVUWUxoSHh6TUg5Skl3ZFFIbkVaZm9ETm1lNFpHM0RKM3ZwQ0tqUXp2UWlO?=
 =?utf-8?B?bzJ2RENOR3FUOVRpK1ZqbkMrems5WmdickFNS2dTdmtVRmNFd3lKWEVvblZV?=
 =?utf-8?B?R0xGZWMvR1FlZEcwMVQxUm5iR1M3SE9EWnMzb01YdUQrcThyR2kvbEltcUhq?=
 =?utf-8?B?T1FmaGwrYU16Snd1NzhZUEMxeU03OWdxMTdJVHhpRHhVUFB2YmJYSTFSNk9y?=
 =?utf-8?B?TCtIRDk3V3d5dTN6ekp3aGNQa3lDTk4zd2NBdWNxdFFaMkRXZVhDUUVyVVBQ?=
 =?utf-8?B?OUdLckRqZXhJTmpSWUR0ei9CajFBWktMcThVay85a3NzZWdwTkRpbmdiR29N?=
 =?utf-8?B?WGlIaHRqSFR1bVNtdHBTZmFPOUFhek5maVdXL01uNjFaNEdQcHdqN1FVdENF?=
 =?utf-8?B?WXdIYkFPQWRCZUxLQnAwTSsxOXYycm1UYUlSenQyd09JVXRWNmhicDJyT04v?=
 =?utf-8?B?WWRDbk0zSGVkU1NTam5JYyt4aWhheDBWSFNEbkltN0FBMDBDQUhlU09LbWFh?=
 =?utf-8?B?dmVFV3VtZFlrUERtN3dMVzhpaTFKUVZiZHBwdSs5VlArVXUxVkNTNGNjRzdD?=
 =?utf-8?B?YzBPc3ZnUXJ2dnJEOUVYSC80WHZEWm5tV1Q3V0dsc0R4dkcyNmZFN0VTRS9Z?=
 =?utf-8?B?R3FMd0U2Z2FvTGFMY2JUbmZ5dlNaNWxtdDdKT29WQVlSQWtYSE5wemNoSDFz?=
 =?utf-8?B?UktIZnNBLy8xMzN4UVlTMmMxV0J6emxSS0ZFRmhKS2lrQTQ3YXRnTm5Cc0Q4?=
 =?utf-8?B?N2NzUm5wZVgzTXJheGU1TzhzTDdJdVhOUU5LN3RBOFI0eHNMZ05vWmZPR3ln?=
 =?utf-8?B?QTgyenN4TjZQYUJIY3JOK2p6L1h2RzltUmZVWVdua0ViK1d5ZGRMdlBtRFkr?=
 =?utf-8?B?ZEorUFBueUl1N3MyUmVKbjZObnZaalUyZ09nSERWOExuN21jSmtweDFGTFQ2?=
 =?utf-8?B?V3JMaGVwQWFWQXVrV2tNdVNaR29TTDRhSFJrdFY1OTZBZ0NVRzZHZG1Fck1Y?=
 =?utf-8?B?enJkZXl5VnNNcWRnQTU5eWhiMDFlL3RDZ2tCVWdRWEhzYmpCc1lrK1YwSEJD?=
 =?utf-8?B?ODdDYWZiYWg0d2tIak5sbWZCV0NSak5peFBrUUZMOXpKNTd3UEthSkRzaDNu?=
 =?utf-8?B?cURBNHZheFhzZ051eGZJODRsNlZXZzg0OWtWbmxweDYrMmZIdzkzSTBybFhP?=
 =?utf-8?B?cElDb0R1Z1hoQ2ZQNVJCT1pTZXF0NVQ0WDNXWUdUcklzKzB4MjEzL29yeDF4?=
 =?utf-8?B?MlBXTWZPTW9MSjJQTUhHaUhEYmhleHZ2RWQ4Q3JGZTk1MEJ0OUoxNDV1b1F5?=
 =?utf-8?B?QzlQMjVJYkl2VUhRMUlndmx1dU9lVnlGU0s5ejFxUHBwVzBOU3ovVFM5UUNH?=
 =?utf-8?B?R2FtUnVxOXZRVTNxMnEwbUFlTnZiQjlNU0dlbnhrNVhOWHBYSmc0ZUs0Z1Jo?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDBD01EE56F14643B58CD7BD52F130BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qL5Zs9kcnRKuE+p57aNZekVUGIRLI+NrqbutkpGfP7JkWy4urEeuWyizqImeg4uSraz+EGaqoreIPgfoo+RAJvO8LpvMxY9RVvPgjPYQCJrePUfNRk3f42gUVi35CkUYxPODRLARoQSoKi+94aP3yhZwDIEF9DSIXuCt8miJXCJEUUBpjjPs9P2maogVUum2AkjL6CIHXHQi2RfFjzc2dhDM8uOS0+6Jbt9M3py8VHcGKFxWqoeaFKve4x0/XPBxHceBQAZhGnjMklAEQ9jGr8U7ANBoawO7Um//GTATKnyTQuzy7OYR7ktbUl1qt4b7Yj+nndwKwCAjKiNz4P391zRUCm9EYosLdwerFvPWi53lWefssZLBhLINht6zRYTPitWJanWSEoaZhqxWP7LiSjuetrMPf9lv+x09IIw6Hq83dSDAdl2iCo4YRWVLXX8MpoyXy9CkK/8ZZNt9+5XFS9MV6ZrSwBCCNTdpCGqD96BgE6/Y5lIIv4vpE8QU0Zt9dEeiwWTMexO8vV7dtKGCV5/kb14iYfo6vwyIoxeWi9f7hiuGPg1XtaUZMLQc++Dcz16nKloFGf+G7VcXh0j9p0zkjPiLuGhlIBFQ0lxJWAiAi2QLeALHPFHAYu9LB3Do
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25531c1b-080e-4265-c44e-08de00d0aebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:55:41.7918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyASRcq/zYrP/gTqoH7PPwcRZEwqjOyHYkTfjGal5wA17SR0CT7ywu521OJcYLrgfJ8xqZ28d6yteabM4LYx2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6417
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=362a73bd3=wilfred.mallawa@wdc.com; helo=esa3.hgst.iphmx.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gV2VkLCAyMDI1LTEwLTAxIGF0IDA5OjU2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEyIFNlcCAyMDI1IDEyOjExOjQ5ICsxMDAwDQo+IFdpbGZyZWQgTWFsbGF3
YSA8d2lsZnJlZC5vcGVuc291cmNlQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFdp
bGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+ID4gDQo+ID4gVGhpcyBo
ZWFkZXIgY29udGFpbnMgdGhlIHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgYW4gU1BETSBtZXNzYWdl
DQo+ID4gdGhhdA0KPiA+IHVzZXMgdGhlIFNQRE0gb3ZlciBTdG9yYWdlIHRyYW5zcG9ydCBhcyBk
ZWZpbmVkIGJ5IHRoZSBETVRGDQo+ID4gRFNQMDI4Ni4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiANCj4gRldJVyBJ
IGNoZWNrZWQgdGhlIGZpZWxkIGRlZmluaXRpb25zIHRoYXQgSSBjb3VsZCBmaW5kLCBhbmQgdGhp
cw0KPiBsb29rcyBmaW5lLg0KPiBJZiBpdCdzIHBvc3NpYmxlIHRvIGdpdmUgbW9yZSBmb2N1c2Vk
IHJlZmVyZW5jZSAoc2VjdGlvbiBldGMpIHRoYXQNCj4gbWlnaHQNCj4gYmUgd29ydGggZG9pbmcu
IEZvciBleGFtcGxlIEkgd2Fzbid0IGVudGlyZWx5IHN1cmUgd2hlcmUgdGhlIHNpemUgb2YNCj4g
dGhlIHNlY3VyaXR5X3Byb3RvY29sIGZpZWxkIGlzIGRlZmluZWQuwqAgVGhpcyBtYXRjaGVzIHdp
dGggd2hhdA0KPiBsaWJzcGRtIGhhcw0KPiB0aG91Z2guDQpJbiByZWdhcmRzIHRvIHRoZSBzZWN1
cml0eV9wcm90b2NvbCBmaWVsZCwgdGhpcyBpcyBzcGVjaWZpZWQgaW4gdGhlDQpTQ1NJIFByaW1h
cnkgQ29tbWFuZHMgLSA1IChTUEMtNSkuIE5vdGUgdGhhdCBldmVuIHRoZSBOVk1lIHNwZWMgYWxz
bw0KcmVmZXJzIHRvIHRoZSBTUEMtNSBmb3IgdGhpcyBkZWZpbml0aW9uLiBJbiB3aGljaCBpdCBp
cyBkZWZpbmVkIHRvIGJlIGENCmJ5dGUgaW4gbGVuZ3RoLiBJIHdpbGwgYWRkIHJlZmVyZW5jZXMg
dG8gdGhpcyBmb3IgVjguDQoNClRoYW5rcywNCldpbGZyZWQNCj4gUmV2aWV3ZWQtYnk6IEpvbmF0
aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IA0KPiA+IC0t
LQ0KPiA+IMKgaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCB8IDEyICsrKysrKysrKysrKw0K
PiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCBiL2luY2x1ZGUvc3lzdGVtL3NwZG0t
DQo+ID4gc29ja2V0LmgNCj4gPiBpbmRleCAyOWFhMDRmZDUyLi44MGNkNzAyMWMxIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL3NwZG0tc29ja2V0LmgNCj4gPiArKysgYi9pbmNsdWRl
L3N5c3RlbS9zcGRtLXNvY2tldC5oDQo+ID4gQEAgLTg4LDYgKzg4LDE4IEBAIGJvb2wgc3BkbV9z
b2NrZXRfc2VuZChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdA0KPiA+IHNvY2tldF9jbWQsDQo+
ID4gwqAgKi8NCj4gPiDCoHZvaWQgc3BkbV9zb2NrZXRfY2xvc2UoY29uc3QgaW50IHNvY2tldCwg
dWludDMyX3QgdHJhbnNwb3J0X3R5cGUpOw0KPiA+IMKgDQo+ID4gKy8qDQo+ID4gKyAqIERlZmlu
ZXMgdGhlIHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgU1BETSwgdGhpcyBpbmZvcm1hdGlvbiBzaGFs
bA0KPiA+IGJlIHBhc3NlZA0KPiA+ICsgKiBkb3duIHRvIHRoZSBTUERNIHNlcnZlciwgd2hlbiBj
b25mb3JtaW5nIHRvIHRoZSBTUERNIG92ZXINCj4gPiBTdG9yYWdlIHN0YW5kYXJkDQo+ID4gKyAq
IGFzIGRlZmluZWQgYnkgRFNQMDI4Ni4NCj4gPiArICovDQo+ID4gK3R5cGVkZWYgc3RydWN0IHsN
Cj4gPiArwqDCoMKgIHVpbnQ4X3Qgc2VjdXJpdHlfcHJvdG9jb2w7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogTXVzdCBiZSAweEU4IGZvcg0KPiA+IFNQRE0gQ29tbWFuZHMgKi8NCj4gPiAr
wqDCoMKgIHVpbnQxNl90IHNlY3VyaXR5X3Byb3RvY29sX3NwZWNpZmljO8KgwqDCoCAvKiBCaXRb
NzoyXSBTUERNDQo+ID4gT3BlcmF0aW9uDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJpdFswOjFdIENvbm5lY3Rpb24NCj4gPiBJRCAqLw0KPiA+ICvCoMKgwqAgdWlu
dDMyX3QgbGVuZ3RoO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogTGVuZ3RoIG9mIHRoZSBTUERNDQo+ID4gTWVzc2FnZSovDQo+ID4gK30gUUVNVV9QQUNL
RUQgU3RvcmFnZVNwZG1UcmFuc3BvcnRIZWFkZXI7DQo+ID4gKw0KPiA+IMKgI2RlZmluZSBTUERN
X1NPQ0tFVF9DT01NQU5EX05PUk1BTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAw
MDENCj4gPiDCoCNkZWZpbmUgU1BETV9TT0NLRVRfU1RPUkFHRV9DTURfSUZfU0VORMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDB4MDAwMg0KPiA+IMKgI2RlZmluZSBTUERNX1NPQ0tFVF9TVE9SQUdFX0NN
RF9JRl9SRUNWwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAzDQo=

