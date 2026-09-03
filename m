Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDC6C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wXa-0005D0-0g; Wed, 02 Sep 2026 21:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wXZ-0005CV-6Z; Wed, 02 Sep 2026 21:46:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wXX-0002h6-4F; Wed, 02 Sep 2026 21:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400015; x=1819936015;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dQ+hRqujg/96UvNa2muvesTq5Qo2ElY1Ffn5/9EOTBA=;
 b=GLek6g/6gu8RMkxyMkQiGgzAIo3EKBG45LwQmNMYyGJ7fWCHkwv1hmEK
 PT6YodkPYOvp/zzS8RjGCK/Ms48miRGg8CGmOs7DYXDMz9TEdHBbgD4fU
 pDRScUr3P5q9hERi+FfaXpVYM2xsoCHrYJyxfn/Tx078PWA/IFEvsLzXe
 Pi0O+TY+0aYcSqV569iteVBV6TNnhAWGtB/tztYLaFqtHM7ak6o0FjMnb
 A238K5HC6bIO/jmYYe/GK5YYkuMPBBlNdbVo9IKPGAGimLWf2Tsz8Oebf
 kjhvnb6lilNsSeWaHV6ZMqxhd5voQ/SX9gVA7Us6z4T23ODvl/5niBkrG w==;
X-CSE-ConnectionGUID: cfX3jgUAQ1GPphYaNYzb9g==
X-CSE-MsgGUID: eNiyvo7GRN6KcigLrmpf4A==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="155756085"
Received: from mail-northcentralusazon11012023.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.23])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:46:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbp0tmD8mzSgWjoxPfAy0zf4ijli7eHUolE8Skha9v25gz9+tlPTvNulpXZFbXhsc04oYVLg7YqKyKujEewnDF9Z9yjz6N5FNrNNLO4Li7FB7DsZzg6Mifx5ntRaL21dYMbj/J9aRfuPiemDIclpfi0zluY31OAYD+GYN7/rkg/uytWZEL3cDRpj2vMDt70J5zxq9cLSeSTJ035SEGCLqiOP1L913QBIPzxUXly5s8fYO57NNZiZBKAt9eM/aWUW6ADLTBKtSXPJt0CfwtvAE1iXQ1FYmG7nMCBr2IaOcD711A2KK7ZnXXWRvOknE/mZRbaLW02QjGzX0nObianCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ+hRqujg/96UvNa2muvesTq5Qo2ElY1Ffn5/9EOTBA=;
 b=upsNimJOeQxSuzzOd16H+oUGR8HJ2+r5scyRGrkwNPQ0+wz9BZiRpz0ODLQCj1qt0Ib3qc90nOTyiftsZtA1SbvPwwnqHjniJyOgrT64w8DeVTygJ2wWqH7ysDmmZOgJvgh5sPDlE91KqWbG97ZqF4T2lCUnVpE+G17wPV8xtaNOPg86+TUsKr6wTAosA8CFjSRqw73QwPcTHGcj76y2xKZbnzD5Q8bOrBuzEjojq9GWlnW0OCTejQrhHkS3vltX31Q+hVqx6RJWxsE9pZ89+wKsR2Y0DG+GskYQH7MMG/OY4qiYSn6N13TH7/WxLESh00VM9q16h5C6kvQczZCsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ+hRqujg/96UvNa2muvesTq5Qo2ElY1Ffn5/9EOTBA=;
 b=Fqp6vla0uKCyQqUIuV443dILqCd4tGHztMCzetxsf6G00TjAqG0cxJml4OO8UCWGNYKdVc/UoBJeXALp6r1NtwYTWopHJUYvAYY4gLk+VbGxSCdWqNU/1bQaiPhMpN0n0XewN7ANI0aGFwgb4kFUfHQovYWlx2ph5o8yiX8Q8bE=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:46:49 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:46:49 +0000
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
Subject: Re: [PATCH v2 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
 created device
Thread-Topic: [PATCH v2 05/16] hw/intc/sifive_plic: Take a MemoryRegion for
 the created device
Thread-Index: AQHdOO6rsraSXGYRj0GYyhKh/kUYK7a8Gk0A
Date: Thu, 3 Sep 2026 01:46:49 +0000
Message-ID: <652e7fdbf4c5c29fbb811cbc757c5752fedd3db3.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-6-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-6-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7640:EE_
x-ms-office365-filtering-correlation-id: e94b2d29-bf77-4866-ac79-08df095d3844
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: 0rHK5iKZKgQTiOUGokpJmKZYK3ocvde31UgfvNwQPZ09WI9CbXyIAZD4uzaac/YyDsqbh9OsOguPYAzYsIrSwGHapG1W9DxdNB2Xe+napJ4d3xyGw+Ijuq54Jdrs2UdHb/Xf7AvdoxG4O66BZRVRj0bSPzViwbFLvbTC7TCOUu00VTjwFfUO6B+BJgpfWTtOMme58A0sJZ6ZUnt+g2yctTPjM27kyGaYAErc+c5EPV7/2tTX1QG0Ku2tvve+fzOnlPZ0VqEAmzgGN3AISeYOXzi/NXCusruPLjimNIYNnz5pZjXDU5TWQORCboNvphyK3eCNv6dW6J7vHdmCUV0HsWkMj+PxcC4x/+pOJwfwdIH/T+WBBMNEPWHCm7TAvcRZda2KV1VJxUmQOFPu2CXiefXw7SGB7+sRVetIM1YvKU37uhEWMgQe2uVr6+1q2dLmQ+wg6bXecsZR/eMQXj2IBBF/Bo1Q7V28z7U/KyJYO5k26Uj6Damvom25Z18aevHCm7O/rnZg/ql1z7aob+Ki9GvrR0wo89gY/L44D35Kt7F0EHTx2LLMZfr+U1DGQVZ0R6FYbNNZgh/F/ox+Z+HzKv3bNr4X8OL6fiu51b8FK0P7MpXiVbnJ1c+nChLzHNkseynwzYElBTL6vMrcySJyFUYTJ0xRBxC+LxHpbbfFW8U4LUTDvFLPmMHKxV1dDwGPuKxtKIeR2WTRyACu1SDl7uUCWPP/vDeMNeel8ovmEo4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWd1VVhJREUzU0JLMDgrQnhVR1daRkluRExOTElpR2tiQllJMWxScTcrL2Y1?=
 =?utf-8?B?bDJFWUZJbGZxYVppVjFNSGpnZG1TZjNLZzVrdXNhMC9aaXdLa0krNzljQUlS?=
 =?utf-8?B?b2tRbmVzTDhSQ2lPWVoxeTR3M1dIRUlkRkw4NEtSMDlHS2VGQmUzdGpQQ2xY?=
 =?utf-8?B?NWVTUVZuclV1V0NtTWFETnFqWFpUakFQQXhWVE1IVytKczQyNHVlOHA5UDV2?=
 =?utf-8?B?L0IxWEZTMVpqOGQvdERlaXVPYWwxMFhtcDc2aDJIRmtIWStob3pUbHpKR3pK?=
 =?utf-8?B?K0FNWjl5SEpqN2JhMXRLaThHSmtqVWN6M3YyRmRTbnNsUTFHNlN3TGlOd3Vh?=
 =?utf-8?B?Z2tSRHN5czRreElVOVhTVExucGRDcGJWQ1JXWG9hMHRXTFI4Ykt6NjBUN1pW?=
 =?utf-8?B?UkhWWUZyd2FQQjNZSE1BK1NSQTY4MDh2WWRtQzJvOUNDR3dJWjJwMEp0blA2?=
 =?utf-8?B?Ri9ET3BETTZuL040aVQzOWo1WjNHblJ6dmdCR0RwaFlXV0w0TnB0Nk9VNk9p?=
 =?utf-8?B?L21xN3k5SHM0Zi9adEUzd0VQTjBVK3ZKZUEreENxZzliSkd4bCs3QjBKd1Mx?=
 =?utf-8?B?d2RzdTQ3V0d3SW1pNjhDeGJXaGNEUzNFVjJoMG8yRHJtODdSRkF2UE5NRWVV?=
 =?utf-8?B?Vzl1R3ljcVR2MjQ3NmIwbzJ2d2sxN2tpQnJLUFlCQW1ELzAvM2JUaVEwQnhN?=
 =?utf-8?B?MGFieGxzSm8wZjViNG50VUVEWHRybElnbnRhQitSUlFJSlc1SFE0dUxXN2xK?=
 =?utf-8?B?K0dTR1RveU1xMjZVRFhSUmZxUVdQL0lMZVhMNE5oc0Q5VzVDTlgwV044S1Y1?=
 =?utf-8?B?WVY5VVN0VitucW9ZczFjVjBWblNKeWQ2d1M5ZlVqdGt6Q3R1MlBITmRkaE1M?=
 =?utf-8?B?RDV1cDVGb2RSaEdYR0QwSVNVS3hRVGEwcUFyalo0NDdpcUdCck9kMzlVNDhB?=
 =?utf-8?B?UXJZVDFIZG5GNG1NUmpHR1pOV0h2K0IrcVU5NEhwOGU5bHlnVFVKdGc2S0M4?=
 =?utf-8?B?eU56eDEwVmlnTnVzWDBka0djalJibHZiQzZ0WDdxME9ZL3JQY3hlVWhQeDFk?=
 =?utf-8?B?M0lqZHlZb2dTcVo3bkk3RnNOVjA2QmZRVS9MQjhVenpQcElmQ3ZwWTB3MkNr?=
 =?utf-8?B?V1dhdDNQdHc0eWFrMzVnOEZad2tCcXNndWlsZFB5dFptUFVpSGtxWS9XQVpV?=
 =?utf-8?B?aHd4RWJrblpOY1FRVUI0UW1jYWN1N2J4K01qWWoveVQvdS9xNWxGKzlhL05Y?=
 =?utf-8?B?K0wzTEltUFBpWkRVQ1hqODBReXJtMGFnQitCTWxoQnN2K0NCMktESFQrWE16?=
 =?utf-8?B?VFRPUXdQbFliU0xMcDNVbXN5akdJbFk2UmxDS1VtZnNDRUtBL2FYalRKRTZC?=
 =?utf-8?B?em11RXJZN0wyemlsMFRubVJib2xVdXZPbzRBQ01QSjhlZW5KSXIxNWFGM3ZE?=
 =?utf-8?B?TVZzMHFUOHNFZzVreWgvYUZ5alNLUlVISTMzYkxRUy83R29lZzJMSzduK0x0?=
 =?utf-8?B?VlRpdlBUWWdjQkJnakNTaHpobDdyMWQrL2ppM0NFcW9jTEtuS2FIN0wwaStK?=
 =?utf-8?B?aituMEJvM3JKOXJLNTYzZHgrandLN1hkU0lFdFhRUzViWFozY2dIYjNNSzZJ?=
 =?utf-8?B?b0RDalJEb21DT09FWmJoL0tYeHo4elgyQlMrRHlHSVoyb3FwSC9QWnY1bDM0?=
 =?utf-8?B?RWRQSHZoeTd4M2lkd0JMQjdSSmNrZmVhd1M0NExodlZVci80eDNhS01CZFMw?=
 =?utf-8?B?TTM0MWF3bHMrMnlqWjlENW5MMUEvb1lEb2dEbFhuYkVadm1qVmU4cjZmRVN2?=
 =?utf-8?B?ekRkNHlBMkNuQWpadDBTb3A2NWEvakVZRjBFTmJPOFhPNTlGald1eGI5WnpT?=
 =?utf-8?B?azhEK09hL2hRdTFveTUvSnZsQVgxMDBaUDdLTXI3ZkRIWUVPR29FNFNhVUR3?=
 =?utf-8?B?Sm96ZzZiUmZnTGd2cUZkS2tHeXY5Yk0xQ3FhaWxDZzVEdWU4Q3c4R3MyWURo?=
 =?utf-8?B?Tm1RL2N3aURRS3lGeDB6MStQVnNCVTUrUE1sSmoyV3I1MmhvWmU3WkF2Zm9o?=
 =?utf-8?B?UUtOL2xwRmxFVVVsZGVmMWozVVBqYTF1aFF5ek1zVFBseXlZODFQdER6dTQ4?=
 =?utf-8?B?MFJoZnNDNGpYNk9jbndoTkZiRzMwQklEeURPQ3RPQXhJMkVnMUtnNytPYm1M?=
 =?utf-8?B?aVVIcEd2cjlaOW9rQ2U1NjFZYzFBclpuZjBnVFZ3UmFsUkhWTWVwQldoZmIx?=
 =?utf-8?B?b2FydVdCbkVhRUczbEt0WTF3b1Z3alZvV0lUcEVSQjRHaG85KzIva29OVWRJ?=
 =?utf-8?B?YXhSZU0yVEFYQzh4QnB4c0wyL0RZTlEra3N6cDVxWHErb09lV0p2UkdsUWVH?=
 =?utf-8?Q?r+N2rPnDPJPHqxL/UL9aSVH0+yKq+cWc7rw7UWGHJ8PgJ?=
x-ms-exchange-antispam-messagedata-1: u06EEeM3YBPVLLMq2qLuaTK+3OovyQbr1oo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28182D535EEAE144B13CD43AA59DBEC7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rYXFwL28np6Nn2pygZtPXrAOfosrZktlptjY8nPbqJ56gAUE2nVnz3Heg21elxYCYJFB2KTT3h1mknHomwr3b4Feu+5U591ueXqtDt90BOpq3/HHmAPGKEcE1sMPJ6Xc5BPhFhfhmfyaaLkSwAYPy+NyZdS6F8Qce6ODXWhYYTrVghZ338UMgA14ZkdjX/K/eDIjBCh+i22jxhLoMhm/6KYX8mI3nwuaqxQV31dyf1tF32HR9EneV4WyKZwm6x5RqEacljyZXb2Eu6qioE07iZoJbxOKIHh2FjKbTdYPlGLmKdEglsPZobL0jHFOubdMvMSf/Sdw2Cs3bIXgfMi8Qw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b+blfet22aCDvQkBk0wFH0bWqmB4g5pR9jBLc74txyU3toVh/MdBXTNOpzhLLlAsWrWS+t0VdpPyi32MlUhSkgI3KP1By31YW6vgSVMu6FTaiflH3G3/mpZUM5i0oFH68bvk4duDKPNDUuI55bNKfh7DQabgiFUR+kfjgXwwQKFjMO7Gj8gXBvpeUyyogq1CJZxGwSwDSri6MT0gF3bZ7xfSIgQAr/xl9mzu7H9J7P2wl2g9tci1ZYON5Eei9/SWbPwZSqBXp0WjQXkSh14xJMYB6rJhpNGYdDUUSS+bEPiraPCa8EzsVUYKk19NrCp2CFlHTeLKGib3uYZlPAwjYQteeha0YLXC5JWPUZ/oVqjdw+hw2Im+ZhFXgkOMHJ8pf3CF7Gvlt4uGbO8O1R9UtOwiHWQDCW+TzB1PDjDISFNEi3T2+rxCLc1/D1xqCnggKhhoGd8yHd9Op8svvEbv04KtwSnV6cCibVNt0AxwajAldc3dqdOr/dAwif8gqOCYPUT6BLDFkkOC+lU9d6T+bRUhR4UjLCNUxSgU+RwoknueoRwedODcWrUHj7zK046lha7qVV6oWMpTnk588zQ5eRhnaZOL7g08/sx8ED00xq5aBldj6CGr/HR8GZCneVjd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94b2d29-bf77-4866-ac79-08df095d3844
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:46:49.0392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13iX3A374MawcwaXZru0m6ePjuFvZCKEFTbqsLABhO2aEIS0kOSa5lsRE76XrC9j4uwRFj01xgN3g0d+MUkj2phOmZGPb2d+vQEVr04uh+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
IHNpZml2ZV9wbGljX2NyZWF0ZSgpIG1hcHMgdGhlIGRldmljZSBpdCBjcmVhdGVzIGludG8gc3lz
dGVtX21lbW9yeSwNCj4gd2hpY2ggcHJldmVudHMgaXRzIHVzZSBieSBTb0NzIHRoYXQgbWFwIGRl
dmljZXMgaW50byB0aGVpciBvd24gbWVtb3J5DQo+IGNvbnRhaW5lci4NCj4gDQo+IEFkZCBhIE1l
bW9yeVJlZ2lvbiBwYXJhbWV0ZXIgYW5kIG1hcCB0aGUgZGV2aWNlIGludG8gaXQgaW5zdGVhZCBv
Zg0KPiBjYWxsaW5nIHN5c2J1c19tbWlvX21hcCgpLiBBbGwgY2FsbGVycyBwYXNzIHN5c3RlbV9t
ZW1vcnksIHNvIHRoZXJlDQo+IGlzDQo+IG5vIGNoYW5nZSBpbiBiZWhhdmlvdXIuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1i
eTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFp
cg0KDQo+IC0tLQ0KPiDCoGluY2x1ZGUvaHcvaW50Yy9zaWZpdmVfcGxpYy5oIHwgMyArKy0NCj4g
wqBody9pbnRjL3NpZml2ZV9wbGljLmPCoMKgwqDCoMKgwqDCoMKgIHwgNiArKysrLS0NCj4gwqBo
dy9yaXNjdi9rMjMwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4gwqBo
dy9yaXNjdi9taWNyb2NoaXBfcGZzb2MuY8KgwqDCoCB8IDMgKystDQo+IMKgaHcvcmlzY3Yvc2hh
a3RpX2MuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4gwqBody9yaXNjdi9zaWZpdmVf
ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+IMKgaHcvcmlzY3Yvc2lmaXZlX3UuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0NCj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMSArDQo+IMKgOCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaW50
Yy9zaWZpdmVfcGxpYy5oDQo+IGIvaW5jbHVkZS9ody9pbnRjL3NpZml2ZV9wbGljLmgNCj4gaW5k
ZXggMzI5NzNkYmYyODFlLi4xM2ZlNmIyOTA5ZDIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcv
aW50Yy9zaWZpdmVfcGxpYy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvaW50Yy9zaWZpdmVfcGxpYy5o
DQo+IEBAIC03Niw3ICs3Niw4IEBAIHN0cnVjdCBTaUZpdmVQTElDU3RhdGUgew0KPiDCoMKgwqDC
oCBxZW11X2lycSAqc19leHRlcm5hbF9pcnFzOw0KPiDCoH07DQo+IMKgDQo+IC1EZXZpY2VTdGF0
ZSAqc2lmaXZlX3BsaWNfY3JlYXRlKGh3YWRkciBhZGRyLCBjaGFyICpoYXJ0X2NvbmZpZywNCj4g
K0RldmljZVN0YXRlICpzaWZpdmVfcGxpY19jcmVhdGUoTWVtb3J5UmVnaW9uICptciwgaHdhZGRy
IGFkZHIsDQo+ICvCoMKgwqAgY2hhciAqaGFydF9jb25maWcsDQo+IMKgwqDCoMKgIHVpbnQzMl90
IG51bV9oYXJ0cywNCj4gwqDCoMKgwqAgdWludDMyX3QgaGFydGlkX2Jhc2UsIHVpbnQzMl90IG51
bV9zb3VyY2VzLA0KPiDCoMKgwqDCoCB1aW50MzJfdCBudW1fcHJpb3JpdGllcywgdWludDMyX3Qg
cHJpb3JpdHlfYmFzZSwNCj4gZGlmZiAtLWdpdCBhL2h3L2ludGMvc2lmaXZlX3BsaWMuYyBiL2h3
L2ludGMvc2lmaXZlX3BsaWMuYw0KPiBpbmRleCA5Yzg0ZmYwNmE5ZmQuLmI2NDcyNDQzMjc2YiAx
MDA2NDQNCj4gLS0tIGEvaHcvaW50Yy9zaWZpdmVfcGxpYy5jDQo+ICsrKyBiL2h3L2ludGMvc2lm
aXZlX3BsaWMuYw0KPiBAQCAtNDczLDcgKzQ3Myw4IEBAIHR5cGVfaW5pdChzaWZpdmVfcGxpY19y
ZWdpc3Rlcl90eXBlcykNCj4gwqAvKg0KPiDCoCAqIENyZWF0ZSBQTElDIGRldmljZS4NCj4gwqAg
Ki8NCj4gLURldmljZVN0YXRlICpzaWZpdmVfcGxpY19jcmVhdGUoaHdhZGRyIGFkZHIsIGNoYXIg
KmhhcnRfY29uZmlnLA0KPiArRGV2aWNlU3RhdGUgKnNpZml2ZV9wbGljX2NyZWF0ZShNZW1vcnlS
ZWdpb24gKm1yLCBod2FkZHIgYWRkciwNCj4gK8KgwqDCoCBjaGFyICpoYXJ0X2NvbmZpZywNCj4g
wqDCoMKgwqAgdWludDMyX3QgbnVtX2hhcnRzLA0KPiDCoMKgwqDCoCB1aW50MzJfdCBoYXJ0aWRf
YmFzZSwgdWludDMyX3QgbnVtX3NvdXJjZXMsDQo+IMKgwqDCoMKgIHVpbnQzMl90IG51bV9wcmlv
cml0aWVzLCB1aW50MzJfdCBwcmlvcml0eV9iYXNlLA0KPiBAQCAtNDk5LDcgKzUwMCw4IEBAIERl
dmljZVN0YXRlICpzaWZpdmVfcGxpY19jcmVhdGUoaHdhZGRyIGFkZHIsIGNoYXINCj4gKmhhcnRf
Y29uZmlnLA0KPiDCoMKgwqDCoCBxZGV2X3Byb3Bfc2V0X3VpbnQzMihkZXYsICJjb250ZXh0LXN0
cmlkZSIsIGNvbnRleHRfc3RyaWRlKTsNCj4gwqDCoMKgwqAgcWRldl9wcm9wX3NldF91aW50MzIo
ZGV2LCAiYXBlcnR1cmUtc2l6ZSIsIGFwZXJ0dXJlX3NpemUpOw0KPiDCoMKgwqDCoCBzeXNidXNf
cmVhbGl6ZV9hbmRfdW5yZWYoU1lTX0JVU19ERVZJQ0UoZGV2KSwgJmVycm9yX2ZhdGFsKTsNCj4g
LcKgwqDCoCBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoZGV2KSwgMCwgYWRkcik7DQo+
ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKG1yLCBhZGRyLA0KPiArwqDCoMKg
wqDCoMKgwqAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRShkZXYpLCAwKSk7
DQo+IMKgDQo+IMKgwqDCoMKgIHBsaWMgPSBTSUZJVkVfUExJQyhkZXYpOw0KPiDCoA0KPiBkaWZm
IC0tZ2l0IGEvaHcvcmlzY3YvazIzMC5jIGIvaHcvcmlzY3YvazIzMC5jDQo+IGluZGV4IDFlZjQy
NjBjNTM5MS4uNmIwZjA0NTNjODBiIDEwMDY0NA0KPiAtLS0gYS9ody9yaXNjdi9rMjMwLmMNCj4g
KysrIGIvaHcvcmlzY3YvazIzMC5jDQo+IEBAIC0xMzQsNyArMTM0LDggQEAgc3RhdGljIERldmlj
ZVN0YXRlICprMjMwX2NyZWF0ZV9wbGljKGludA0KPiBiYXNlX2hhcnRpZCwgaW50IGhhcnRpZF9j
b3VudCkNCj4gwqDCoMKgwqAgcGxpY19oYXJ0X2NvbmZpZyA9IHJpc2N2X3BsaWNfaGFydF9jb25m
aWdfc3RyaW5nKGhhcnRpZF9jb3VudCk7DQo+IMKgDQo+IMKgwqDCoMKgIC8qIFBlci1zb2NrZXQg
UExJQyAqLw0KPiAtwqDCoMKgIHJldHVybiBzaWZpdmVfcGxpY19jcmVhdGUobWVtbWFwW0syMzBf
REVWX1BMSUNdLmJhc2UsDQo+ICvCoMKgwqAgcmV0dXJuIHNpZml2ZV9wbGljX2NyZWF0ZShnZXRf
c3lzdGVtX21lbW9yeSgpLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1tYXBbSzIzMF9ERVZfUExJQ10uYmFzZSwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBsaWNfaGFydF9jb25maWcsIGhhcnRpZF9jb3VudCwNCj4gYmFzZV9oYXJ0aWQsDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBL
MjMwX1BMSUNfTlVNX1NPVVJDRVMsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBLMjMwX1BMSUNfTlVNX1BSSU9SSVRJRVMsDQo+
IGRpZmYgLS1naXQgYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYyBiL2h3L3Jpc2N2L21pY3Jv
Y2hpcF9wZnNvYy5jDQo+IGluZGV4IGE2MDI2Nzc2ZDRkZS4uMWY2ZDlmNWFlMWVkIDEwMDY0NA0K
PiAtLS0gYS9ody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuYw0KPiArKysgYi9ody9yaXNjdi9taWNy
b2NoaXBfcGZzb2MuYw0KPiBAQCAtMjgyLDcgKzI4Miw4IEBAIHN0YXRpYyB2b2lkDQo+IG1pY3Jv
Y2hpcF9wZnNvY19zb2NfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+
IMKgwqDCoMKgIHBsaWNfaGFydF9jb25maWcgPSByaXNjdl9wbGljX2hhcnRfY29uZmlnX3N0cmlu
Zyhtcy0+c21wLmNwdXMpOw0KPiDCoA0KPiDCoMKgwqDCoCAvKiBQTElDICovDQo+IC3CoMKgwqAg
cy0+cGxpYyA9IHNpZml2ZV9wbGljX2NyZWF0ZShtZW1tYXBbTUlDUk9DSElQX1BGU09DX1BMSUNd
LmJhc2UsDQo+ICvCoMKgwqAgcy0+cGxpYyA9IHNpZml2ZV9wbGljX2NyZWF0ZShzeXN0ZW1fbWVt
b3J5LA0KPiArwqDCoMKgwqDCoMKgwqAgbWVtbWFwW01JQ1JPQ0hJUF9QRlNPQ19QTElDXS5iYXNl
LA0KPiDCoMKgwqDCoMKgwqDCoMKgIHBsaWNfaGFydF9jb25maWcsIG1zLT5zbXAuY3B1cywgMCwN
Cj4gwqDCoMKgwqDCoMKgwqDCoCBNSUNST0NISVBfUEZTT0NfUExJQ19OVU1fU09VUkNFUywNCj4g
wqDCoMKgwqDCoMKgwqDCoCBNSUNST0NISVBfUEZTT0NfUExJQ19OVU1fUFJJT1JJVElFUywNCj4g
ZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3NoYWt0aV9jLmMgYi9ody9yaXNjdi9zaGFrdGlfYy5jDQo+
IGluZGV4IDg2ZmY4ZjhmY2FhYi4uNjIwNTJiZjdjNjFlIDEwMDY0NA0KPiAtLS0gYS9ody9yaXNj
di9zaGFrdGlfYy5jDQo+ICsrKyBiL2h3L3Jpc2N2L3NoYWt0aV9jLmMNCj4gQEAgLTExNSw3ICsx
MTUsOCBAQCBzdGF0aWMgdm9pZA0KPiBzaGFrdGlfY19zb2Nfc3RhdGVfcmVhbGl6ZShEZXZpY2VT
dGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+IMKgDQo+IMKgwqDCoMKgIHN5c2J1c19yZWFsaXpl
KFNZU19CVVNfREVWSUNFKCZzc3MtPmNwdXMpLCAmZXJyb3JfYWJvcnQpOw0KPiDCoA0KPiAtwqDC
oMKgIHNzcy0+cGxpYyA9DQo+IHNpZml2ZV9wbGljX2NyZWF0ZShzaGFrdGlfY19tZW1tYXBbU0hB
S1RJX0NfUExJQ10uYmFzZSwNCj4gK8KgwqDCoCBzc3MtPnBsaWMgPSBzaWZpdmVfcGxpY19jcmVh
dGUoc3lzdGVtX21lbW9yeSwNCj4gK8KgwqDCoMKgwqDCoMKgIHNoYWt0aV9jX21lbW1hcFtTSEFL
VElfQ19QTElDXS5iYXNlLA0KPiDCoMKgwqDCoMKgwqDCoMKgIChjaGFyICopU0hBS1RJX0NfUExJ
Q19IQVJUX0NPTkZJRywgbXMtPnNtcC5jcHVzLCAwLA0KPiDCoMKgwqDCoMKgwqDCoMKgIFNIQUtU
SV9DX1BMSUNfTlVNX1NPVVJDRVMsDQo+IMKgwqDCoMKgwqDCoMKgwqAgU0hBS1RJX0NfUExJQ19O
VU1fUFJJT1JJVElFUywNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3NpZml2ZV9lLmMgYi9ody9y
aXNjdi9zaWZpdmVfZS5jDQo+IGluZGV4IDBlYTQ0NGY0M2JjNS4uODFkNzk5NWRkY2ZiIDEwMDY0
NA0KPiAtLS0gYS9ody9yaXNjdi9zaWZpdmVfZS5jDQo+ICsrKyBiL2h3L3Jpc2N2L3NpZml2ZV9l
LmMNCj4gQEAgLTIxNCw3ICsyMTQsNyBAQCBzdGF0aWMgdm9pZCBzaWZpdmVfZV9zb2NfcmVhbGl6
ZShEZXZpY2VTdGF0ZQ0KPiAqZGV2LCBFcnJvciAqKmVycnApDQo+IMKgwqDCoMKgwqDCoMKgwqAg
bWVtbWFwW1NJRklWRV9FX0RFVl9NUk9NXS5iYXNlLCAmcy0+bWFza19yb20pOw0KPiDCoA0KPiDC
oMKgwqDCoCAvKiBNTUlPICovDQo+IC3CoMKgwqAgcy0+cGxpYyA9IHNpZml2ZV9wbGljX2NyZWF0
ZShtZW1tYXBbU0lGSVZFX0VfREVWX1BMSUNdLmJhc2UsDQo+ICvCoMKgwqAgcy0+cGxpYyA9IHNp
Zml2ZV9wbGljX2NyZWF0ZShzeXNfbWVtLA0KPiBtZW1tYXBbU0lGSVZFX0VfREVWX1BMSUNdLmJh
c2UsDQo+IMKgwqDCoMKgwqDCoMKgwqAgKGNoYXIgKilTSUZJVkVfRV9QTElDX0hBUlRfQ09ORklH
LCBtcy0+c21wLmNwdXMsIDAsDQo+IMKgwqDCoMKgwqDCoMKgwqAgU0lGSVZFX0VfUExJQ19OVU1f
U09VUkNFUywNCj4gwqDCoMKgwqDCoMKgwqDCoCBTSUZJVkVfRV9QTElDX05VTV9QUklPUklUSUVT
LA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc2lmaXZlX3UuYyBiL2h3L3Jpc2N2L3NpZml2ZV91
LmMNCj4gaW5kZXggNThiNDc0NDMxOGY4Li4xY2M2YmU3NDRmMDggMTAwNjQ0DQo+IC0tLSBhL2h3
L3Jpc2N2L3NpZml2ZV91LmMNCj4gKysrIGIvaHcvcmlzY3Yvc2lmaXZlX3UuYw0KPiBAQCAtNzcy
LDcgKzc3Miw4IEBAIHN0YXRpYyB2b2lkIHNpZml2ZV91X3NvY19yZWFsaXplKERldmljZVN0YXRl
DQo+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gwqDCoMKgwqAgcGxpY19oYXJ0X2NvbmZpZyA9IHJp
c2N2X3BsaWNfaGFydF9jb25maWdfc3RyaW5nKG1zLT5zbXAuY3B1cyk7DQo+IMKgDQo+IMKgwqDC
oMKgIC8qIE1NSU8gKi8NCj4gLcKgwqDCoCBzLT5wbGljID0gc2lmaXZlX3BsaWNfY3JlYXRlKG1l
bW1hcFtTSUZJVkVfVV9ERVZfUExJQ10uYmFzZSwNCj4gK8KgwqDCoCBzLT5wbGljID0gc2lmaXZl
X3BsaWNfY3JlYXRlKHN5c3RlbV9tZW1vcnksDQo+ICvCoMKgwqDCoMKgwqDCoCBtZW1tYXBbU0lG
SVZFX1VfREVWX1BMSUNdLmJhc2UsDQo+IMKgwqDCoMKgwqDCoMKgwqAgcGxpY19oYXJ0X2NvbmZp
ZywgbXMtPnNtcC5jcHVzLCAwLA0KPiDCoMKgwqDCoMKgwqDCoMKgIFNJRklWRV9VX1BMSUNfTlVN
X1NPVVJDRVMsDQo+IMKgwqDCoMKgwqDCoMKgwqAgU0lGSVZFX1VfUExJQ19OVU1fUFJJT1JJVElF
UywNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBp
bmRleCA2ZTRiMzkzMTVhYWEuLjZkMDYxYTgwY2E5ZSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3Yv
dmlydC5jDQo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtMTEzOCw2ICsxMTM4LDcgQEAg
c3RhdGljIERldmljZVN0YXRlICp2aXJ0X2NyZWF0ZV9wbGljKGNvbnN0DQo+IE1lbU1hcEVudHJ5
ICptZW1tYXAsIGludCBzb2NrZXQsDQo+IMKgDQo+IMKgwqDCoMKgIC8qIFBlci1zb2NrZXQgUExJ
QyAqLw0KPiDCoMKgwqDCoCByZXR1cm4gc2lmaXZlX3BsaWNfY3JlYXRlKA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdldF9zeXN0ZW1fbWVtb3J5KCksDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1lbW1hcFtWSVJUX1BMSUNdLmJhc2UgKyBzb2NrZXQgKg0KPiBtZW1tYXBbVklS
VF9QTElDXS5zaXplLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwbGljX2hhcnRfY29u
ZmlnLCBoYXJ0X2NvdW50LCBiYXNlX2hhcnRpZCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVklSVF9JUlFDSElQX05VTV9TT1VSQ0VTLA0K

