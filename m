Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED89BC9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9xHA-00019n-Iv; Fri, 25 Sep 2026 00:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9xH3-000196-Ss; Fri, 25 Sep 2026 00:11:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9xH2-00005F-BD; Fri, 25 Sep 2026 00:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790309460; x=1821845460;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lm3QlYTsagzfX9QBKw/O1dAEe0VSptrLw30tTYBOvpM=;
 b=ggGwD9Qm7Hb4ehLuKkQ89t5wwAVgodJiWADXiQUctgs/UPUhv0VJtk9k
 l8SDp3sVpUAydVstyYsHYV/Gfoqu6CViqJqmKhgqK/UWTIPUSnhflp6KM
 r33x+IrUXjnBGSdeeMZPRAoMQ0LZKfwMA/46JUuim72bNzLmzNyPe3fkd
 zruccgK9/+yZ/+f9zkynOfFA7XE6W0eS8u2hpdnla9JCoZUws6J72Oj4d
 qkYhHXB+2aeWoLU04hKBm+N1uGA3GIBuWsdN+zz/TlLiYvcMR7soLIyPH
 CoCzZu/7nJuZHWVbmOWzAvMgPVY9prX4CUiOQTvvvivXD0aw2Ai5aRGnD g==;
X-CSE-ConnectionGUID: zS21B2SMRraKRx42SXBqIw==
X-CSE-MsgGUID: /1Tx1KNIQem4mu4AFC36Ew==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; d="scan'208";a="157452995"
Received: from mail-westus3azon11011027.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.27])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2026 12:10:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBIsdjDz6CA+JgfcgMv8R8VV+BZA5OKmHtHspf+IFU/ERfBE8EzDia8Jxd/B54TmELe4wJRcEkxo2qZ0/maRCezm/8+m8RGAct6nV/isaz1LzRAI8ITymjH2NA/J1IjNua+7WIlX3nrYL+H0Neoy/e+5kIJjYAJGAa/Kgn233qB2vh4AT9YT8uhx/ocWa+Adhnb3dXEde4gQW32KUnxCb4GdRxhLClieQB6JoHNZVpkxPrP+7SoCGg4N9hTI0fo19Sem5+3irW49pRfQVSu+RjTyYgx/CJaAz4c+m2t4hKtlkm63P2dWt7EBKQm4vO60bpv0a5QtO6QKLxsMSBV8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm3QlYTsagzfX9QBKw/O1dAEe0VSptrLw30tTYBOvpM=;
 b=J7ExuUM+mV2ucoC7z8gNXT7n0U7cp9BzkhEE2075mVhiyJO1eXV0ECjuL99x+DjH6M59kdJQn9yj6ssfUgqUm8aBBOYVdQAPKLo+gtUSRy2X1TSMnWhjEBFKJ/pNtqzpRL6+xiCMWnAUGt3g2Ydh4njaibgtnkrsB+21b1EeD5uNZ5Y4p2pPFARJgDP/VkcUBSi02q/lPLXK79SUGE7K1Pj8Kb169/vXxnmPcbEeioJg3Dmc1fWAHrTs65Lb7Z9mPt9Eu4XkaXDXnBQlsfeccIANK1jP5x5QeTgrjQW1gH1ZuZM7DTBsBeiK2E+jXNMBmGmq2hhe5i2uTy5ZoJ2rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm3QlYTsagzfX9QBKw/O1dAEe0VSptrLw30tTYBOvpM=;
 b=csZLfa6o6yAklIIGlffK1mz4QGH+b+vhNctE1P4gxGOAiu6INzsP4yYxFEJa2lBAT+8v6EltRekrOf/aiDGbjQYY8WLdZi4PqJj4atGh0Cagi7j/xYwXytywB/M7tsawK5rV9Q0lacBC/ONRPWUy3RtE+I7fh2JsdD3z1nDEVWw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB6409.namprd04.prod.outlook.com (2603:10b6:5:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:10:53 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:10:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "xb@ultrarisc.com"
 <xb@ultrarisc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 0/3] target/riscv/kvm: Fix a few migration issues
Thread-Topic: [PATCH 0/3] target/riscv/kvm: Fix a few migration issues
Thread-Index: AQHdORw1vBzvFdaqgEmef2CdYWVByLbe1XuA
Date: Fri, 25 Sep 2026 04:10:52 +0000
Message-ID: <865a74d780e65a32b40391cee62d7f63f77f5094.camel@wdc.com>
References: <20260831074106.1798671-1-xb@ultrarisc.com>
In-Reply-To: <20260831074106.1798671-1-xb@ultrarisc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB6409:EE_
x-ms-office365-filtering-correlation-id: 3623d562-d99f-4cc4-3784-08df1abafd3b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|1800799024|19092799006|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: AK2u8jY5S2/ES9NQqcqqBYWEcNm7rkWqGRzku8c/R/kfBb+j89YPgVz3oeX5Q82lRFoidi0rdlijfx2SfEh0Hg7NiDgz/sub0hB8oUXHZ0HM4rfOS4rHfaKok/SoiEGdbR4quOCri07t6us58lYmO6GBxdRjXDFlgKxaIttSzXy1n2wxKQoFQfqHsY+h3hspvif+aNiOZbYcNn98m6Gu/BRIr0djamOHgrfr3zrWr5sE0+MwMVdW6CodBPx1+VJxrCd7zrL/Vdr8dmgo+GuoSECPZstt3rnl1UlfZnNG3LXNugJQ+H0x1nwPf5zz9hM/yRdYc2mzhJpjVNUSaKoP2mn2TM9/eHyioFd5hrClI+zeQcmMiFP/CKHTTaiK9E8hC8bf4ZoqHfv6M1yBYNJNDRh9wLuOWi9Hoj851sd3WlhGa81umpUFUi9NmxZMGVyA7/IbxNTLGlz6QifMFUb0BiErlN2yG4vrSRXXplTXrCDSPVIfqfppJQy3LCXbZeM9lLkyDXdgwjgTSeKiyB/U+lQhuSsIWdG0EgdoDJ9uy51VQawfGDeCB3bQtx4JhkxAHi+UfxCYKBSen6bTg+rW66u1Tywbsd6Yng6Zx9ZsSBRyF0SwKkjTArykIU5zNvEhfSxRFPbj1y/bmPNAaUZwg4hCBYITOFwqvFDpSpCvMtiQZ9EWRujcQUQewniEkkdZO8rCyjRLXEu0EcyZEycCEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(19092799006)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDZ3REtpaXRYelZMeDh3SCtKcXFHcmx2SXlFS3M4RVlWeU9seWZtd0cvWDJt?=
 =?utf-8?B?UmRjQUg3UWpwNXZJK2JrNTE2MEdqbUQydUlwOVpYRTJ6SXlDVXhXZkhYRFhO?=
 =?utf-8?B?OVVKUVBHdE8xdWFXYXhzN21mNlNLWXhpL3Q1NE5KSUNNWFB6dlVCeXlhb1hY?=
 =?utf-8?B?YVRCZ1FZOWRhUnNnRXRhajVqK3JUazduNWE0b0Z4MUJ5THYwdkpNTWVITjN2?=
 =?utf-8?B?ejJOSnliZlFwSWpyeGZWelZ5TEQ5NkI0czI1TmVoVFg1dTRQM1BnV2l6b3Vy?=
 =?utf-8?B?QTVSbjRNWENlUE85SVFDVWxIV2YwRXE5aFQ2eWl0aU5jVnl5RWFQVmRyK2Vy?=
 =?utf-8?B?cFcyWGFsSW5uNzVvbFJXbW5YQ0R6YUVZeUZEeE91eEM0L0dUS1ByWGJUZUFx?=
 =?utf-8?B?TVVTUFdBaGFWMmtXL1E1aVdyeHMzR3dRRDlWNkpPNGhSRHlERGN4dWpJVzFh?=
 =?utf-8?B?U1BpOGp0eXhDU2VqRmxYY01yclJscDUydmZYMzhPaUxBbTZTM2dJcWtsNE9z?=
 =?utf-8?B?ZHhTQ2FnZGVVMzM1WkVYTlJzOGxnNms5akIxRlFiS255SzUzVjNIRDZKc0xC?=
 =?utf-8?B?K21NN09icWU3VUQ0SVZkcEUrbHgrSWlkL3BnUnh4cjQ5QkVUaUMwUGliR2tw?=
 =?utf-8?B?V3JKZEhweC9hZ3RMaktvdGlacTA1U0t5VjFGWERGU3ZCVTdUTWRrZFU2RTFv?=
 =?utf-8?B?R1pKN3piWSt4WDNhZmJhNHhhUS8yWTRLTmtLd3d1aFhGMW1qZmdVa2dtcVZq?=
 =?utf-8?B?WGVkajdObEhaY2dsSWVGcGRiZDhydzJ3dUhKenYzQmhqdkV6Q2VEdGJ2eTdJ?=
 =?utf-8?B?VXorSG9hMHRKeEtIUzlFcUFiSmZKbkVSbEsyTFpJMUxiazVkc1JTdGJMbXBi?=
 =?utf-8?B?V0VOU2MwMjdWNVhRa0VDd3RSVS9VQ1hEUE9NdDVJV0t5dkJjQTdaZ0Q3UUND?=
 =?utf-8?B?aVNSVm5GL2JickNyYWM4UWxFMWVOdnhqVFp6dXk0SVRLdHdyV2JHUnhLbkRP?=
 =?utf-8?B?QUZWc1FsYzVVU1F1ZDg0SVRBQ0x3WVRFOWFKeXlFdWMwT0Z0WjBtMFVjK0Rl?=
 =?utf-8?B?bnducVo5QnYyWWp4aUkxL0FrR2c0UEUvcTNvVGx3UzllMGdTN3VYTjJkQ3dU?=
 =?utf-8?B?SEJPdVY3YklHWEg1dEZBbC96RmhzSU9jak1JQ3czT0pxdXVkWTdvTEt3RnMw?=
 =?utf-8?B?QTdlUGFOUlZuZVRBNU04cFdVS3gyU01Eb0VOWXlzNHliV0ZlL09ELzRUVXRq?=
 =?utf-8?B?SW0rYlhKTnlGZXhRakZCWktjNlh5eStxc1hFTmtPYWxIWXBnRkh5b291d1pJ?=
 =?utf-8?B?emdIYm5POE9IU2ZoTnBLbG9YSnQvdWRQZW5Wa3ZZZHhIQ2xOdHBtNWdiQSta?=
 =?utf-8?B?a2x0UHZMaXcxMlM2L2xYRnQ5cS8wOVloUmdsKzNvUmYrSnh5cCttSzhRcmtG?=
 =?utf-8?B?a2l6MUFTQTB5QVNDZE11d0p5UStBUHkyV1pNd3pXc1Q3bGxhdlZzc3Nhay90?=
 =?utf-8?B?djZNTGhrbDhwemZNcXEyRjZBTGdZTmdhUWlGYm9PK3E4WHowNklkZW90MVQ5?=
 =?utf-8?B?WGpYZ3ZWOVFEWkFpUUtIU0pJV3pjNTZTQjQ0TGdrbnZrK1FPK0JXRERuZGFW?=
 =?utf-8?B?akJvRFF5ZDU5SmcrbmNqTENKVWd6d0pyY3ByNzQ2VjVxMVR4NkI0RWpvRVlZ?=
 =?utf-8?B?VExQdVRsQURyNDZ3SFFnS3QvdlNwVCsxOXZvN3YvSXd2TDRBeFV1dWI4MGxj?=
 =?utf-8?B?dVRQbTltTGRDZVJoVjQwQllOWXVlQmI3eWw5Rk9SNGxheGZ1M0dXUE9sK2FU?=
 =?utf-8?B?M0toTlhKZnRZM3RaVCtJekQxVjVGclN6cjFCem9uWVdWM3VTZ0s2M3lWWkdm?=
 =?utf-8?B?WEU2UUFCMkNoMDRiSk84bzZ4TVh6VU0zSkNVUEU1ckJrQ244L3BNNE5Ucyt3?=
 =?utf-8?B?YnpWNG0ybG0zUVQvZllDOEdNWHA2TFp3MnlTVHlJSnEyYmhSeGthMU5XVmwv?=
 =?utf-8?B?RXVJbzRac1BEWnJYeEM4K0xmRVp4SklKTzR1cm1WUmUyMGtBQjdFNUNDWGpU?=
 =?utf-8?B?ZUJzbTc5UjU1cnIxcmxXSStqcDA3ZjR0Ri9SME5EVnF3YllXVjVjcVE4ZUVu?=
 =?utf-8?B?UTZTQ0lCNXZPdy9rT2hlMmRwdzEzbG94TTVmdFBZdGo3MU1VcGUrcUwzNTlI?=
 =?utf-8?B?Q2g0WHFTYnh4NGZBSHg4Ujl3bjVLQlBjZmovVTVkbWRIMWxYZVlQdWNHanVq?=
 =?utf-8?B?VmFsV2RaMEp3MWh2UzNralkzakhwTUpqU1ZaRXlSMDcxMTNJemZtZUxoclZk?=
 =?utf-8?B?dllrWGFBM0t6UkVVUTVnKzJyOGlnTFYzVWU5RHE0NGNPK3BZY3Bzb1grOXpH?=
 =?utf-8?Q?Ttqa8F+HRQWs0LZfWzZ8bXw4bn6mLfchS6SBynF5k4HQU?=
x-ms-exchange-antispam-messagedata-1: 7+vtbYe9YuzwXS7TgibLynCEqQA+YRLKa9I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1ACBEFEB00C4443B890E644790A2636@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AbarEprqU9e8+DdSweJVQP89ZXq0SH791pr6EjTAptbneSOEOuDwwVmoYg8Q/ejCIMapzqN+oWNLkzNKEh3jNLCJZvsHlI4F5f3jVtk9fArjWn8PbDxqsrpk8mpxozTADGStKhpc1BUA2PcM/U0isqeEQcftcn1oqaP2y71UTwMnzQPlPq6i7uWKZMlPkUo35n9el238N4ygZZHoJEMeplcHWbJy68Bw2S9YOFEY8LiQ7TGHj6zHIIZUJWI6LjOfg89ehphZ0AVotPAVViR6WAy/G4CBbJujk2eRuEsZShlrsk8cYBOm7WbA9m/9zf3Ln/pDRVq67x0ZCxoAn8Itvw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C/BEXLCaJYXH9aUKlISl7HW21T27wN4M9zXaiZ28XPp1IjSYOGhC+fidZKGFnNy2agF4+drTp0kEBn6AZIlxWiw7jg5ot74osF57bzOr1nLwvC9iCYrozxQQdUVVgmtZMwETczhGvOpT0ySCIdSg0e5ja/rqhhMeOJZjlkx46BGQQJSGZdfPtRg23rqGjhnM/oC6UV9/3ADOTj/Z/KXTRyHh4LDM6YNCB0jXUldVnrBJyCdSPhjAcbv1rcgHWFVEaPHcWnJkessEQDQsca8bqtmpSu2Pcv0RJKCHnSuHcf+avdD/HHGiCtcbz3u/yVX3CUOm4kJsHxseYpIxVlgT38QTAfdbtU8ETvVA7XN+CnNE32IWbrc4gw1xtEi5zVdSomf5aFiCFn1efR6Yci1Lffz1hoKtt1oK5EUKb2P/N3Ce7Zi+qQqWEtek6l8UJha3UZlKO4ovrJal4Ji9LS7MUkcAjxzHTRlG7OoMxotj98nHuktr95PjBE3sWTIWGMQDuQdST9s9H36VizHZYsWllHM9qwowA+4SPz7t/RdmCb3+B8jpXKHBVURHWXbgnC1rv5lYBBUaREYW1N74WhBYB42L9CA2dgbDJl8at3yovju2OU8q4VjAxBIjcPBkXjHl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3623d562-d99f-4cc4-3784-08df1abafd3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 04:10:52.4228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57udDVg/v3N5uephwqY0DsTqbVvujUM8o8gtdz1ueRbTQxnjGbNZa8YGbRv/jcoHSWT3TavK33kuJN22Yju/3pEogrVQ3Tfyzhb9d4+lKLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6409
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=721c190f3=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDE1OjQxICswODAwLCBYaWUgQm8gd3JvdGU6DQo+IEhpLA0K
PiANCj4gSGVyZSBhcmUgdGhyZWUgUklTQy1WIEtWTSBtaWdyYXRpb24gZml4ZXMgSSBmb3VuZCB3
aGlsZSB0ZXN0aW5nIGxpdmUNCj4gbWlncmF0aW9uLg0KPiANCj4gVGhlIGZpcnN0IHBhdGNoIGZp
eGVzIEZDU1IgbWlncmF0aW9uLsKgIFRoZSBzZWNvbmQgbWFrZXMgdGhlIGV4aXN0aW5nDQo+IHRp
bWVyLWZyZXF1ZW5jeSByZXN0cmljdGlvbiBlZmZlY3RpdmUgYnkgcmVqZWN0aW5nIG1pZ3JhdGlv
biBiZXR3ZWVuDQo+IGhvc3RzIHdpdGggZGlmZmVyZW50IGZyZXF1ZW5jaWVzLsKgIFdoaWxlIGNo
ZWNraW5nIHRoZSB2ZWN0b3IgcmVnaXN0ZXINCj4gY29kZSwgSSBhbHNvIG5vdGljZWQgdGhhdCB2
Y3NyIHdhcyBub3Qgc3luY2hyb25pemVkLg0KPiANCj4gSSB0ZXN0ZWQgS1ZNIGFuZCBub24tS1ZN
IGJ1aWxkcy7CoCBPbiB0aGUgUklTQy1WIGhvc3QsIGEgZm91ci12Q1BVDQo+IGd1ZXN0DQo+IGtl
cHQgcnVubmluZyBhZnRlciBtaWdyYXRpb24gYW5kIEZDU1Igd2FzIHByZXNlcnZlZC7CoCBNaWdy
YXRpb24gZnJvbQ0KPiBhDQo+IDEwIE1IeiBzb3VyY2UgdG8gYSBkZXN0aW5hdGlvbiByZXBvcnRp
bmcgMTEgTUh6IHdhcyByZWplY3RlZC4NCj4gDQo+IFRoZSB0ZXN0IGhvc3QgZG9lcyBub3QgaGF2
ZSB0aGUgViBleHRlbnNpb24sIHNvIEkgY291bGQgb25seQ0KPiBjb21waWxlLXRlc3QgdGhlIGxh
c3QgcGF0Y2guDQo+IA0KPiBUaGFua3MsDQo+IEJvDQo+IA0KPiBYaWUgQm8gKDMpOg0KPiDCoCB0
YXJnZXQvcmlzY3Yva3ZtOiBQcmVzZXJ2ZSBGQ1NSIGFjcm9zcyBtaWdyYXRpb24NCj4gwqAgdGFy
Z2V0L3Jpc2N2L2t2bTogUmVqZWN0IG1pZ3JhdGlvbiB3aXRoIGEgZGlmZmVyZW50IHRpbWVyIGZy
ZXF1ZW5jeQ0KPiDCoCB0YXJnZXQvcmlzY3Yva3ZtOiBQcmVzZXJ2ZSBWQ1NSIGFjcm9zcyBtaWdy
YXRpb24NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxp
c3RhaXINCg0KPiANCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNCArKw0KPiDCoHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jwqDCoCB8IDc0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gLS0NCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2
bV9yaXNjdi5oIHzCoCAxICsNCj4gwqB0YXJnZXQvcmlzY3YvbWFjaGluZS5jwqDCoMKgwqDCoMKg
IHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwg
MTE5IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0
OiBkMmU1NzBjYzBmOTdiOTM2OTAyYTViMWI4NmI3M2MwZjU5OThiNDc1DQo=

