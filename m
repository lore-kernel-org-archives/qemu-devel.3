Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EBBCA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5re-00052a-6O; Wed, 30 Sep 2026 21:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5rb-00051O-J8; Wed, 30 Sep 2026 21:45:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5rZ-0007Fe-RX; Wed, 30 Sep 2026 21:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819133; x=1822355133;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=i5ABcaI/qHW4eI+mXe1gEFRMMuaOvygj0aGfgos6ojg=;
 b=JozQmypc+TuWwA2eycCbs6EKx/UJkb6xAa5rbdpzQJy+0IlsSXIaKB+v
 Ag84FeKIfG8IeJzrBqJPxXbnuiSChw6FXDmGDIaBxlo+dkBZGEr0qn0hl
 DjTk0gQ3NA4Ueae6RzY+MqnMntw6sx8bsU15qVq6OuEjSB2YouF1ctpMF
 eMKwaAF6i2H6eXtfMF/0jMFfJZJ2ygOu0XoT8QbHHceF2veIQPJCWgo5c
 /9cx0bfBJedkxBDQbxyQpo65EWzf5bWaqddCeDqN5rYYtK/bnSDYEs8TS
 xk/a6z7MkYUatsdmvlyFkcgIZclokJIpDM4YrEYt+UBkSHjamSupb4rC3 Q==;
X-CSE-ConnectionGUID: q08MnDFtRP+HyRytHNIjzQ==
X-CSE-MsgGUID: k+TSyRLYRvKlS8ywnzSp5w==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="155393047"
Received: from mail-eastus2azon11010039.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.39])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:45:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqMVcwkuxFc48r2N+ZJ/wGYFmPkBqCUKHudYCs8XgIHug1xHQpB2RRIOATVlaNRHcBFosaCsNkOGUPWLVNw9jilujw/PSICOmDv0wXF5egk4MM58ilwZkiLpDHcdgVV6X2K/Nfk537W0vepFS7owPyoCg20EdK3AMR60+SRDUSnGsaKwcOfgAY5kfcIOnwNshANuhkEh/sgtoi511NB5NGzrMAXq7rDXinuoBeBzCPXVXjcz/T+LI+jPcOq7jtijKJV38ubY07R7chDyZ2RUKmn4Ps3Tspe/B1+vlwCyLQXzbHIfN9egJZibSV9MsiE6Bn9ZWTVarB3iQd39d8KY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5ABcaI/qHW4eI+mXe1gEFRMMuaOvygj0aGfgos6ojg=;
 b=OMUbhDuywoLazQvuTDYtYSgAcZ5vj9oLtCttnQBq7Cw4e6R5sVIECYAn8UC6tdqpxwSmRifAFOj2HoxBH/8Xcaay3GJVzn2KqdbxAKor31hsQK6tsAYU/QRBp77WUa3m4u9UbVIdTcVVoo+c+I4xBZSDpKDQQu1wTVGjFWFY58t6Y8DU7nn+BDuW0YnUzx2ljitM+wLafMmo8qd6ZUilDao7D/hfxIIFtPPVtSIVi/TqlWzcY/mSsOCe+XgU0FTNzyMsKTrFkd+PhpysTwlpMyRO4GI+ztKQoLVWL6cKDMGDvnNinOFU74nYcRbhAyaAlDQJ9/BQO14RDC2CrtsM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5ABcaI/qHW4eI+mXe1gEFRMMuaOvygj0aGfgos6ojg=;
 b=Pqx1pk6rXmM9G8XnJXeVuZmIm7hckbN/YigchnFsu4/z/xQRwEtk5wpV6sd0RN3swDiYp4s+npmKkp3yvwp8q4oTD4kLh+Ai4xfFz2PrnHPi24qdektMQdb0Z7WDVC5sbVBJRBtwxkNPatQ0teS6ToYqJhMbKwupA5CtB9/0Nes=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7811.namprd04.prod.outlook.com (2603:10b6:5:35e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:45:28 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:45:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 2/7] target/riscv: Document kvm_riscv_set_irq()
Thread-Topic: [PATCH v4 2/7] target/riscv: Document kvm_riscv_set_irq()
Thread-Index: AQHdUQOEtUSji+IAO0qYk7um/g0ho7bn6wmA
Date: Thu, 1 Oct 2026 01:45:28 +0000
Message-ID: <e7b373d4f12fe8a5a05509b55eec75ed304aec94.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-3-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-3-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7811:EE_
x-ms-office365-filtering-correlation-id: 714b2cb9-909f-4e8f-c0d8-08df1f5dabc9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fLzr2kYP7MU5dQ72XXHxCcBluvQ6aCoK23lvR5RC2v/7u8C03IWkz3GHpT2yUOvWW8qc6yb42wB6itONiLcc3/BRMJ0juniQJdAyXbzipwsyVrngN/gXD44uFkQkW28KMA8dKGMZA35rilTGQZHe7lBuTjAtqvQ/k6BD0nDORKgDpX3spJQUQFHMqVTIHN5L6Uy/mB64AqBrH6R1n23WG0kajr2pVdgaBhStu2ZP6BGrmUqN1eV5Xz3cJ38ZMBpru6UvFa+mSnMeJ+uXsq3VRcE9o18IWLEq0AlNfYmMzWWuR0rKFPpG0AanCOD/+Dxbs8kQ8yWh5ngPLuoGqGT4lEKbHKN6l1Nv44hIktN/D+Gzr1aZ7h3P0uo6UdPiB23amS2mvFRSDyAxUuOlxagF039rH0a5LfooTkFc6MSkYPVJlbmqXsNmyd3N//g8YedfBgsO8aYaizmb6M/xUdiOTIxw6xiHDeJKlAw5nnSDoc/m9muJoPJ3MaZdN8w3mWVbgIrEHxaG1nWLA9Ya8irDQJwg7xnykbv4AvBUyMfiObQW3n9nEhN1bjThzG9SK7PSOFjComrJpjRog0vsg9k+3xRHMcDFi3hVFzkT5oz8Dc1Xp4QTzwN6Gx+jPLWL7qY3RBnuYJVYrvQh3ZrsjlgM2ePp5J7xWuz4PN+BfwOrLyuAHn6HXc6tmATU3NLhjKt2dCCm7VZCXS97Bw+ghfdxrr2O262RjvSdtr1dTLkEYy0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkMrZFcxSThveTRWd2NCY0J6dGIwdm5wMEFGUVlHYmVVNHkzTUpWWENjTCta?=
 =?utf-8?B?Z012eFBOQXVGTFRTdlBNS2Rsc0dvR1NUejBOVHhsV2h1Um4zTWRNQk9PMDM5?=
 =?utf-8?B?ZUtMV3BxR1lqY2dTSHZ2NGRYOFRlWmQ5TS9ZQ1pQNVZhTFVnbEVjbGd0TXh3?=
 =?utf-8?B?YTJEckJmbitIUllkOWQybGJPMXlwbTY5T1VnN3E3azNsNGk0dnBHbjcyZFhv?=
 =?utf-8?B?dGtNTkJUN3IvRFhlRmhRZmZ4V2gvSUN0OHYwaEE5c1ROU1FBWFpBRE1FT0pl?=
 =?utf-8?B?YW1zVExXb3RWSWw5T1lUeHlBQXdxQzlIUU5hS0o4NGtwaFhsZS9qVklsNzU5?=
 =?utf-8?B?VFhjUmR5MnN0aUhoOXpZTkwxZXZGSUk5WG94YWZGejZZZjdpZlRJNjRiWUc0?=
 =?utf-8?B?alM1VmtRR085dTFYSGxzbWVzYll0bUhtbk45dmtBOGtnalhGVzBrRVgvclA5?=
 =?utf-8?B?cGZ4cjNoWDJlRUJCZkNIQ3lSWFNIN2RSUGdMQ2VVeExyZW90cURLRldJNzRN?=
 =?utf-8?B?Z0pBT2xPVmZlY0hYODhqeGJFMnlqUGV5YVlIUThPOGRmTGJPbm9mRk03Tld4?=
 =?utf-8?B?bVNsM3pVT1haUHg0ZGU5OFB3L1dDTEo5Sm92UWY5Wk5VdDJHZW1kV0dFdk85?=
 =?utf-8?B?ZjZIQS9BRTI2L0duVUZIYVBsZjN0b1VBTThhN0tuMjdzc3V1WU1YdkFybVBz?=
 =?utf-8?B?elZ3czZ4SWUvRFhqM2p1WS9FMzJBL1ZneXc2bjVLWFZKeDZmalNSQkFSVysx?=
 =?utf-8?B?L00yZ1NZVU5MNlY1WHdPRFN4RjZER0M0eW90RHJxV2kvV0o1YktQSU92VlFR?=
 =?utf-8?B?ZDRDdWN4SU85WEIyV2VNSGFTQ0R1elNnZllrdFVydENUZ3NWd0VQZ1F5TEwy?=
 =?utf-8?B?S3QwYzVQWXVqY2FyY3FXNE5FaTlhMlUyTkdMTk5ubUh3QzBjY0pNQ2JTcXlk?=
 =?utf-8?B?VDNxQzNzVkM4RU9qTmVOcXYrVFovT1lDZitDRlZ6VklpWEIydUdxeEMxcUM0?=
 =?utf-8?B?MEFsUHZkZnpieDFzMk9STFJyUVpxQkJLM2hTWXF4UWY1Y2o0L3NvQUFLLzJn?=
 =?utf-8?B?N3ZEUit4YmtFeDdUSW5vTUwxblZuS0U5NGo1YUZVakg1Yk5aSS8zK3c5NjR2?=
 =?utf-8?B?V0oxYmY0aklQZzFRbVl6ckRoVy9YQXU3MzIrdDlxcEJZZHhVYXplTEwrN0Zr?=
 =?utf-8?B?L3cwOERnbFZIaHdxaWdMWkhMbVpkVXZ3Sm9yUWY3UHo2bzlHVEkzeVVRYjEr?=
 =?utf-8?B?SXN5SThla1lmOFYvYURtaUtUV0Q2TjVUQ09mQmRBYlBsdHMwWCtmTVpYNExu?=
 =?utf-8?B?Slk3eTN5Q3c0SENiL0xpeW14dnlGck5uU1JsNk1xYzhaWmJ5UWlYWk83NFFM?=
 =?utf-8?B?K2ZLQWVHaXBZZHFzczRCUUY0VGVYZURBTDZsU1FDUWlEeURRRlFsMUVKZnBP?=
 =?utf-8?B?VzY4ZjYzVWw2OXhaRllTczVTRUoyUDhxbHZXbmk5clBaNXRWSjNIMWhlQ0JI?=
 =?utf-8?B?NXI2akdYSDV2T1hkam9IYmY1c1B1d1Nabi9kRjBmTDlOUDdnYjhteWQrK1py?=
 =?utf-8?B?M3RUeC94TXgrNHZFbHNwalJXVGZIYjdsR3I2TEJSRm9PN3NFeVlZWk5pc0VE?=
 =?utf-8?B?cE1BajlZVjVSZ3RwLzZMWG43N0twWU5vRE93ZzRpYmNIMGRJby9rR1VMQjJr?=
 =?utf-8?B?ME9sdUlkaUd2VC9SWkVTQ0NENTE2ZmJvRHBqYUdoZkZZM1d6VW5xcHMzS0VP?=
 =?utf-8?B?OFFDOGs5N1p0SUtwNkZ2UGtBcXI0K1FDbkl1clQ2V0JXUVVVcmJJSkwxNVo3?=
 =?utf-8?B?eG9QZVNZTVJXOVV5anFVVEExeDdPUmxWSkFKMkpjSm5pZ1hvczJJVFFROVY1?=
 =?utf-8?B?VFg3RXpFQUJnSWFaZTBDRUsvS2o0aisxUXdKYUIxOHY0ZXhPbHpOZFE5QmZL?=
 =?utf-8?B?dEdiWFZZRTJRTFFBSml3MWQ0OWxVREFLVGc2elRiMXpMZ2VqdzEvMlJpUmpi?=
 =?utf-8?B?SVEyQjA4aEY3NWhQdW04d2hpb2tla3ZZQk84TFZQNDhQckJaai9VQ1RJUXVE?=
 =?utf-8?B?d2ZxWlFEWURCUy9YSUxrM21QdXZhQi8wWGo0UWNRb1VJeThWR3pLZDhjaGlV?=
 =?utf-8?B?RVI1ZG9aazVrR0RZQlFSSGdXczcwb1FnUzZDaFF5NEZ6VG4yY0ZSSFpCeG5o?=
 =?utf-8?B?ZFRuOGt4Y2ZEZUYwUnVDcVpLcDJ4TlJiMnpZWUF1VGtqaFdnc2hsa1d4ajFZ?=
 =?utf-8?B?UFJXWGhzUWtwczJjaHN5WENhUGZpMTc1SW14OHFsU0UvUXR0MjlPWnNvNzhW?=
 =?utf-8?B?NUlhQlNQWS9sNkQrTWVIbEpESGc1bXI0azF2eFZ1NyszY3ZXOVlXZXNydWFl?=
 =?utf-8?Q?8s9yLpIGpZyadW7TKqrQBehjn8vWA36FazZGQ4qXABl4D?=
x-ms-exchange-antispam-messagedata-1: TmNsPyYOOGId5y9bEcP5GX60vjHDOkqa+1s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3158593C2D57FF4488B40214E25F60C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5zMUfHq6RErQKign5fx29Hrsvz1VnrQHfwXCT8SeHgz0F1QQA29shUbeqEUnMENNU+z//ul/LZIIumCqme6EuZePtTuBRLOV1JFlI9KTH4UIFPSWeOKhNKu5m8EuN+CVj2pYGiG/Al0GuY10n2vMjzkirzDomqxUV/Z5EYpBPv2zGYVm8P5N9llkIpjHBbwUL+4s6Et99M6mRg3gzinp7VPY4dvKwdtd4IBCoWo4Hy2VXlSurJJRafS/O+FOZkd+rMCo8zzsrj2bEtgh+CzqqDhrSZiEzKG2hgGl9Wvr66qWJDoSz6sKC8Kr80pzRbNi2UUAbNrT/cge2neB6z+MwA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oaKuOIiDik3bXInGCRh6oT77EOz723RfIZ77s2CTHm6eXJJkSj99T6UtcUsywFHsodofyMM/vamOQdRkPnAvxx51C1CnXrq8bb6guC9EcyijIvKMBL5cL95MO7Q+9RLO9qxMsTKDgFNr910/x6sym85Ch8EA3zE8uyFFeiTw1XYehETEThkUVHM69C+/kqIBoKszNiw4dZBplUIbYI7fssiScyf3+1ow1FTxLwyL08FGw7yzrOXmQ9o/DUXI0AtW78SXkxH8q+FaMOd4N5fzR17MVEuHJsmce60BHtn1B1wHKPGGneXq0nkhkIRnPqgUky3dmsXGTlWcjZYh1eBd3oCqXnnZ5+lfHuj90eBG6ruCFHhMsCXTUsXoMsL5onMRUg2uN/4rb3dUjZTD1uQQYU+iIQFrJvYlTytNtn2e/hqI+qk7/g3jzsuLFWhHynlUJDfqjUgY4DH6zaxIipJpz3jE3+kyMiRcW6yeGRC3fCfXNY//62txhyUWl+giTj+L/OyyMM4oSfItCsbWlwuu4FqPSAnGubT+Xyn6lixruOy/XS8UfZSPbcTp961d3XEGJgXMk/Q4dNlC2byovvz5hGmbdjhrGF3XynHb59qUkaJ5GwpDpvk1SV2D8f8/ga0T
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b2cb9-909f-4e8f-c0d8-08df1f5dabc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:45:28.4285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaVEmPFsGJENe2JCtsm5efRj7fFPVYDGbGNJrsOymWHczXlvw6f2dLBiHR6lUx4loGd4bpTzgzEYN83P89yjCrj+y288pQAnXDSed7k5Mk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7811
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gRGVzY3JpYmUgdGhlIHN1cHBvcnRlZCBpbnRlcnJ1cHQgYW5kIHRoZSBlZmZl
Y3Qgb2YgQGxldmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDC
oHRhcmdldC9yaXNjdi9rdm0va3ZtX3Jpc2N2LmggfCA2ICsrKysrKw0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3Zt
L2t2bV9yaXNjdi5oDQo+IGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3YuaA0KPiBpbmRleCA2
MWVhYTEyNDQzZS4uNzMxNzI1NWNiYTIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9rdm0v
a3ZtX3Jpc2N2LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3YuaA0KPiBAQCAt
MjIsNiArMjIsMTIgQEANCj4gwqAjaW5jbHVkZSAidGFyZ2V0L3Jpc2N2L2NwdS1xb20uaCINCj4g
wqANCj4gwqB2b2lkIGt2bV9yaXNjdl9yZXNldF92Y3B1KFJJU0NWQ1BVICpjcHUpOw0KPiArLyoq
DQo+ICsgKiBrdm1fcmlzY3Zfc2V0X2lycToNCj4gKyAqIEBjcHU6IFJJU0MtViBDUFUNCj4gKyAq
IEBpcnE6IEludGVycnVwdCB0byBzZXQgb3IgY2xlYXIgKG9ubHkgJUlSUV9TX0VYVCBpcyBzdXBw
b3J0ZWQpLg0KPiArICogQGxldmVsOiAlMCB0byBjbGVhciB0aGUgaW50ZXJydXB0LCBub24temVy
byB0byBzZXQgaXQuDQo+ICsgKi8NCj4gwqB2b2lkIGt2bV9yaXNjdl9zZXRfaXJxKFJJU0NWQ1BV
ICpjcHUsIGludCBpcnEsIGludCBsZXZlbCk7DQo+IMKgdm9pZCBrdm1fcmlzY3ZfYWlhX2NyZWF0
ZShNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIHVpbnQ2NF90DQo+IGdyb3VwX3NoaWZ0LA0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90
IGFpYV9pcnFfbnVtLCB1aW50NjRfdA0KPiBhaWFfbXNpX251bSwNCg==

