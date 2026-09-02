Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5F4C61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 00:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1YrR-0006Ud-RK; Tue, 01 Sep 2026 20:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1YrP-0006UK-LB; Tue, 01 Sep 2026 20:29:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1YrN-0008Pl-6Y; Tue, 01 Sep 2026 20:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788308989; x=1819844989;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4iejglTzfoZUJOIas7ZZtFaF5LZmqm0eqwT0ClXK1pE=;
 b=LOjxJgVuyiCQTOK4nfU7oG92N4gdVMzN5iz5JEFUpIyPDpSPt3ThglTn
 PNu+Vkevq+Ioqj4z8TIfO0c0JTGv58/7G2CXSOSNSvpczo1XW/AU+feAp
 7TAeG86ZQkXRgEM18bCFaTodVtuO6ymRks3fsR0NM1QDwXDPFjDRfvnOH
 Bt3wWHFt1+V6R6SxCTVTXsZ9vhL4jN7R3k5UvCDLkhqDr/Yl3JIQSr6HL
 UoDDZAlgRfManAQEI6doO+guFUIvgmhS3XxRDF/2sDI3hUXgr+Ug0EGnf
 kVCmZqPPgjq+I2ueCeWhMsLeB5JbsN57CC4sU3lRAbhyDqiAMwJh6vmeH Q==;
X-CSE-ConnectionGUID: sQG/fQDRSrCVXt7oUT0BCg==
X-CSE-MsgGUID: Kt6qYwf0QfW4MDNZuE7lBQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; d="scan'208";a="150536865"
Received: from mail-northcentralusazon11013057.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.57])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2026 08:29:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3HKBkbgruGVs1uH3uTnRdXs6O8Ali9OIniLjhBUWRd1uZ+Rj9g4nk9Wh88VtjKILKYbzSRH8IrcIB3XxQGexT/ir2t57ssBDULU7VCD1lRX9AcEcO2N4pCzJyz8/5XjL285ps3rF0GoEuVekvR9TPMzrh/aBHhLJlFXVjgqpopHgPRExIaO8rGMPesKBkMVWzL2OFU0m3BhPsQCm47C4K9/DZpnA7E2CZ3wfo9REjUlNUsCW+QvQln1d6uCJFXk1OiuINqrtPs+D50Hbug7HiQpKLfWiEdPgScCfXA7yTssP/sO46nquqHHINGZdcjypDWch7jxRkFm0jqv9Yv0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iejglTzfoZUJOIas7ZZtFaF5LZmqm0eqwT0ClXK1pE=;
 b=Jp3BwRSGh/SQ5wT+O6cGDUmXqWQ8+jmeEfkQ8q0IXZUi4aIwC2gfXDJ1Z3D0OC5GhUvtiUEEeG9Uco0UM8XKnjhqQnsLfIQV8SBMx7YerHTr+Kh0L05QBgTfeyFOuXIgi+8DVMILut2HFCGF7LUOHlnznwodbfnU8M/7dZHpSGIe9777523Ima7bI7zmD0VX75Liemv4cyJq5m7D1n8sEHI2FW7vmcp4j54yXkGuf4ZFIapMyJcaglJn1Nw/muf5IBisIgaqI1v88L7i1WgQNaOXi8vbmfQvRJLOplA2gMPuIQaY6aqpLPAsQYYhr8966eRApPt3PbZBVoP/ub1uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iejglTzfoZUJOIas7ZZtFaF5LZmqm0eqwT0ClXK1pE=;
 b=t2TVsWFE+x1T4ix6xKE4JE5yumyW1TLYpyaBgF6DEYxHyEm+StzRZVq+QlI+phBIxzkqEe4kZR9zOFgsEqE6AqEg45R4Jwh6+BJH/ZSljXeRE5DCNLmC4bpYlzkbcbVD7NLF6VzdGaPZOOfxzjZ+rt5Ag4EPDPLvpLqGd4in8z8=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SN4PR04MB8414.namprd04.prod.outlook.com (2603:10b6:806:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 00:29:37 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 00:29:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wangyang25@otcaix.iscas.ac.cn" <wangyang25@otcaix.iscas.ac.cn>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
Subject: Re: [PATCH 2/7] linux-user/riscv: invalidate other-hart reservations
 after AMO stores
Thread-Topic: [PATCH 2/7] linux-user/riscv: invalidate other-hart reservations
 after AMO stores
Thread-Index: AQHdKTA6B/v3dICkME2qwFWkE2x2Nba6keKA
Date: Wed, 2 Sep 2026 00:29:36 +0000
Message-ID: <34094222dc3ebbafe13d64e21be764319f9245d2.camel@wdc.com>
References: SENT
 0001-linux-user-riscv-honor-zicntr-false-for-base-counter.patch   Subject:
 [PATCH 1/7] linux-user/riscv: honor zicntr=false for base counter CSRs
 Message-ID:
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <f73caf0640c1446db5c566f1bb005966@wangyang25.otcaix.iscas.ac.cn>
 <65afe7aae6364bd5b6bfef05bb6444f0@wangyang25.otcaix.iscas.ac.cn>
In-Reply-To: <65afe7aae6364bd5b6bfef05bb6444f0@wangyang25.otcaix.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SN4PR04MB8414:EE_
x-ms-office365-filtering-correlation-id: 829353d2-1b8c-477d-88a0-08df088944e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|366016|23010399003|1800799024|376014|38070700021|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: RfXQHC5jmNkV2ZvzAXRDIOssqmMxOH1WpxLn+A5JI0mDyDRBfuJ0P71T4+81t1mSps8FOLljGENULgY5vkSTer0Q1wGqNnSCbxnQqFVy7FS75pb45T+76TChTH/MW3nF8bMKcLbX5wvdITmmJXs0Mi7nH4Srv4lhj3190xB6RaKLFVdbmUyPF9NSzpAVQYmSSkJltrvdxCZEYcii24nV5ftaz3tiI13OAuzaf6+BEsRRjxaFBH5vAb7MPvgBhLxXca5EXlmdb3LISnnbOk92fuErBFf2uhGC530ugRMcNOKrFLLSV0sO3CuP4j0yauqh+5gjydjBCTJt8Mc/zZpsnjnbKpOLkc8OwABHsx5Ju1b6YFpyR+uvhI6/UOLFBygAlTqIY608ucedjQxB5hpFBuaQOinuSfma16CqBL62gK0drPHuBnEx7o4sURouMhoVdYXPehGH/dalCE3QDiTEQtoOtJRvkA/VLzvMFFd1FXQz74CkGs7PXYp7oGhj/pdHi/hE9PhwvsDv1N3vj5yaiIaEBO0GxP1i16G66LmkDPCej9JdZ6i6sZILSkyvofXhzoEF5yjNKKuFaNw3ny1K523EZv3FdLXvGIgHMthMinThhk+wZyZgagaOczbnpeawPDuUnknyqGORemMY3L90BBv9K1DWssyAOY3JGVVOmeiyr3vdm8+NjSr/MMk5W5iUIno6Mla78wPXDPz3zN6hVLM9+zIK+rebB8ShVt5RxcQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(366016)(23010399003)(1800799024)(376014)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTY1Tm5lL1A5NzlxMXpnbUxzQ3VvUHliRTY3M3dxUmlCWGdmT1BrQ2RQZSty?=
 =?utf-8?B?RXg3RW1IUEQyeXdKbjVDSE5pSlFNOCtZclFuUHYxSTJqd0JXSkhsYThsWUtE?=
 =?utf-8?B?dGRPOXdPWXVFNnc0WVRod0Z1QUdrck9iK2F2eEphc0cvWXFCdXBEQmU5cURY?=
 =?utf-8?B?MUZUdTMrYnFiMDNqbHFsa3MzeDZKRFVwallXYWNuSFRSS29EMEpTR1Z0U3RJ?=
 =?utf-8?B?Zmt3TnlhblJ2Y0RubWtGM3NxZGllcWRjWk1FN3BSYkIyNVNnU2kyV3dobEg3?=
 =?utf-8?B?QnA1QTlFZCt5MSsvMG5CdU1NcUNibkErUzM2U0xpdllOeXFYelpCWGNUVUg4?=
 =?utf-8?B?ZUZ0N1oreEdJeW1EaUhQSU5EcCtqN1hWSzVHTVpmT0ZIb2FoY0k3ckhMdGFv?=
 =?utf-8?B?ZTZMdEJMYjN2QWFkeVFYSnB5ZmVLR0M5VzFDS08xQ0NpNWo2RjFPQjY0VDhF?=
 =?utf-8?B?UFJjRk9xMmVaUkE0dzYxRXcyS1EyYXIrV3hsclhhWWxKZnRPZ29SR2ZQa0Rq?=
 =?utf-8?B?NG9aeU5GTUQxY0hmWjdKdWdabklOaEFZcThQK1l2amtGVWIxeDFQSU02dXNt?=
 =?utf-8?B?S25ZY1dCcFd3cUpHdFJSWW9CVmxRSmd2dG1hRjFaM0taWHRvRFF4blZ2MUtl?=
 =?utf-8?B?R2xDb25xVE1Pdno1V0ZKT3NhOFRQOHVtektQT0dlZVUrZHpsSncwN3FxMjYv?=
 =?utf-8?B?djJmQncyYWo2ek5yVHBzVVpWU0IyVDBHRW42T1RJM0ptRXlzalhmR3hkelQx?=
 =?utf-8?B?bzN4aytuM2NlbzNCVFcvZTlTMk9FNUNUWmNuNjlrTDFIcW9nUnZJRXB5ZEVK?=
 =?utf-8?B?ZnBUWXRhQXNFbjVhbURhamhLcStGdmFIZlY3VnZIampiS3dZWEt2ZFVFT0kx?=
 =?utf-8?B?L1JKY3d1ei9SYzJmTXI0MUh5SWlKb3I4cWZxN2xjNENXUUlQTER2L2Jsbk5G?=
 =?utf-8?B?UHdaR1J1MjBiaFc2TjBqQWEyVlAvanNKZFB4dUdlSFBpN082cVVURTdlaXI5?=
 =?utf-8?B?Z3U5ck01TFd4N1BQNFVPT2pWMVA3MUFMelVtNGtIWUFKMVF6R2ZyVDFjYTJG?=
 =?utf-8?B?bTZ1TEwyUlA4QWtIUEZDZllpUVFKaVI2bEF5Q2RIMlJNMVY1VjY1RGd3bnBm?=
 =?utf-8?B?LzF2RXQvODd3TEdkSWxwS3JQeCtyd1MyL1pzRS9rMVl4bWFqZFFTWXZpQmxU?=
 =?utf-8?B?U3NmUXhLaWFYYU9CT3plU3VkTjlLRG15TlFYcVpVcXFEMWllWGV2QUw1Vmlp?=
 =?utf-8?B?YTYvY2lhYmUwNTF4Wko4N2pSWW82VWw1TnZnYndmM1YrTE11ZHArVVBrSWdE?=
 =?utf-8?B?VUNmakY5ZERhS1REcHZqZXB6VlJua0svUFF6TmthQ1hPWXBpbktqdnJWN2lG?=
 =?utf-8?B?UkZ4N3FISGRqZ2FaMEdrZExPU2Raemh5YUN1QitJT2EzL3FDNkxJbjZ6YWdC?=
 =?utf-8?B?WWRlMUt6T0IrcndzN3NXMk1UU0tIWmV1bTZ6d1kzUHFJQ3F2Rm1QSGFUOTNC?=
 =?utf-8?B?T2ZuYlJHQXlLUjBaVmdKUHBMMS9LZ1gvZ0FvVkQxcTZQYnVSRVdNSEcwSDJ4?=
 =?utf-8?B?SkVqb3Q1cmYzU0JNcnNWdzR4Tkd1ZjJMT2RYOGtOYjJRYUtETERXTHRWaUZz?=
 =?utf-8?B?OXFqUXIycFh5dmNiV25TYWEyUTUwTzRFZzFKRHg5WmJvVGNkV3JYdHFPNlBh?=
 =?utf-8?B?a240dEk5enVkSFg5d21CU3NMRWdWVE1GaGE5YUVRN0czTWEveVVYdUdZZWlJ?=
 =?utf-8?B?a1F3UlNCS0VDWXJ4a1c1TXBSVHcxMUdsSFR1U1J4bU5GaVVtNDhWd1VuSExt?=
 =?utf-8?B?bjFyQy9EQ3ZXdFp0RDI4d0dNRmEyRDQzNGZqdEZXdVNiSk5FM25CWnljT012?=
 =?utf-8?B?dmFjeGs3ci9DbjJuOUxNWGsvRzRESWpxLzIrMlh1WnBrTjFDZXJkVm02Mk9V?=
 =?utf-8?B?ZXVlTUdNNzc1a0JkbHZOckxiVWFGOGFmeWN6ZE5XQzk4di9wYlJYb0VzazdY?=
 =?utf-8?B?MmZUVXNFUENHV1RBcHdRaDlGQUJKamdUM2luNGsvVTh4dCttL3hlZDJtUS9z?=
 =?utf-8?B?U0hVSURzYklCd20vR3BPeUxyTFNSdlhXL3F2M1FEZ3phNWRNTUY4UEZXNklH?=
 =?utf-8?B?ZVorTGZNbXhNUkFrdzdDb2M3dzQ1NDZscE1yWkIwZlp2SHdTWCszU0JPSlVR?=
 =?utf-8?B?WHg2cFBETm4vUEt5d0lTLzZQaTBLZWlnc1lBRlJLNklGQ0NSejFLQVhBdE5p?=
 =?utf-8?B?czJCTUJwRTdmWGRRckZybjBBVjgxOC9KSjFNSUFhQmxTeTlINmN3a2xMNjJw?=
 =?utf-8?B?Um5Vc08wemZXZVlRRHNSbGFpbDVBWUE0V3ZONmZ2cGsyakxFS3FvMjlKYUh1?=
 =?utf-8?Q?FHBWKgSBlAezNj7frJWLBAAmFpjtFuIONxd6NXouYcmU4?=
x-ms-exchange-antispam-messagedata-1: vkelqrIwnjbcXgz9bUm+OgqIdsmwoCG75eU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4D3363FA9D34748AF8482C3BB493173@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j0t+9tQ5m3hM5/DsKPeenU5F+qhGrkh4fKTr+FsvzaN8ZMpMjqp4X4cdQCLyLZbhwEZirA3uhi7LDHOmnwNomog7urs7WTVaJmLb7kh1nm1SjWAhZl42ip3vXVzqNaMB098rafHgBEGLJVO5PcBtRwU/G9ByrWKe1/lwfRxigDwfh+xs7r8i+c/oikzT1mRd2ZmN+cPML/YCy4qTt7okCY99aIICwp8RzBbXDzT4dOvNkBOlANbTu+TyceLJx8OeXtmiOekhXRtYd5iOmVM4KdblkPeAJ7D6WAfelzNRbiBrw5y3HqxdeW+6/IbIsQnKZNbZeSmti3Q4YokbuLYcEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pX/Xamh74JpApWNnvMEWXcFZhCv1YDUYmOEK9mGi2l/KEaKzKBnHdm1KMoAnMB/ZgI2fF0EGaQzEXvUFfUu1/AXaGpRQuMlUQM9J/b7bwGZPP9HHZMu2uDn8XIRmj12viTbMyEqFqHy11IRDVrfTlRgcZphEgKrVDA9tsVRq/dsYwQHGuPbI5ZZiWGUjS5VJxe7hLOruDv8qVxa6UXmnpRGmbd7e2OFjJGOTc/Ds622ezOgm6R3qRzMnlGhZbdGLhIpHfjtOG/GeYYbH8xcnWDL0CEyXprt/xHbnb4AEZ0ejATuFgX3Nedp3zFQvJ4yotOSaUX3zI9Yg3YZD83pgvCbtq3vZgFtJ7f+A/wVWIP8zUJAgtPWexnhibfqeHo9weYHUc1J4iBS+5nk1r/8ZyvenhJd2KY9ppNW1+uj/7E20gPGNHYj7Bj6rPRSpT7ckuqsiEFJj4zUQ8T+FX54vHhOFcxXdfJoC5hFFy09JRgzA97M6/y8lhY0Xx505tlRk4rPRwq4jngN7oPJ9MlycLONG4sZYV4J+9AJQO8SekXHY7huPuBhgd6y5sT7+UKewz33zCN3tnUD3kAoiq3fMljvBpVvnoiEXkwBQSbj4eWGIsPOJH3qs0DK1egOYE+/4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829353d2-1b8c-477d-88a0-08df088944e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 00:29:36.8920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj/6kWDFI/BZBiRbqW8K5vbocDwyhqo2iZDhFuUxmmhPVDL0ba2Xqzg0lfxQCD4xmF/fD1ZFd7qxXjNo7d3bQSufRF6A6XimjLJQ5rt6jEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8414
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6980a3afb=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA4LTExIGF0IDA5OjI0ICswODAwLCB3YW5neWFuZyB3cm90ZToNCj4gZ2Vu
X3NjKCkgdXNlcyBhIGhvc3QgY21weGNoZyBhZ2FpbnN0IGxvYWRfdmFsLCBhbmQgQU1PIHN0b3Jl
IGV2ZW50cw0KPiBhcmUNCj4gbmV2ZXIgcHJvcGFnYXRlZCB0byBvdGhlciBoYXJ0cycgbG9hZF9y
ZXMgcmVzZXJ2YXRpb25zLsKgIEFuIEFNTyBieQ0KPiBhbm90aGVyIGhhcnQgdGhhdCBzdG9yZXMg
dGhlIHNhbWUgbnVtZXJpYyB2YWx1ZSAoYW1vYWRkICswLCBzYW1lLQ0KPiB2YWx1ZQ0KPiBhbW9z
d2FwLCBhbW9vciAwLCBhbW94b3IgMCwgYW1vYW5kIC0xKSB0aGVyZWZvcmUgbGVhdmVzIHRoZQ0K
PiByZXNlcnZhdGlvbg0KPiBpbnRhY3QgYW5kIGEgbGF0ZXIgc2Mudy9zYy5kIHN1Y2NlZWRzLCB3
aGlsZSBuYXRpdmUgUklTQy1WIGhhcmR3YXJlDQo+IGFsd2F5cyBmYWlscyB0aGUgU0MuwqAgVGhl
IFJJU0MtViBBLWV4dGVuc2lvbiByZXF1aXJlcyBTQyB0byBmYWlsIHdoZW4NCj4gYQ0KPiBzdG9y
ZSB0byB0aGUgcmVzZXJ2YXRpb24gc2V0IGZyb20gYW5vdGhlciBoYXJ0IGNhbiBiZSBvYnNlcnZl
ZA0KPiBiZXR3ZWVuDQo+IHRoZSBMUiBhbmQgU0M7IGEgcHJlc2VydmUtdmFsdWUgQU1PIGlzIHN0
aWxsIGEgcmVhbCBhdG9taWMgc3RvcmUNCj4gZXZlbnQuDQo+IA0KPiBBZGQgYSBoZWxwZXIgdGhh
dCB3YWxrcyBhbGwgQ1BVcyB1bmRlciBSQ1UgYWZ0ZXIgYSBzdWNjZXNzZnVsIEFNTw0KPiBzdG9y
ZQ0KPiBhbmQgY2xlYXJzIG92ZXJsYXBwaW5nIHJlc2VydmF0aW9ucywgYW5kIGNhbGwgaXQgZnJv
bSBnZW5fYW1vKCkuwqANCj4gVGhpcw0KPiBtYWtlcyB0aGUgd29yZC9kb3VibGV3b3JkIHByZXNl
cnZlLXZhbHVlIHNjcmVlbnMgbWF0Y2ggbmF0aXZlDQo+IGJlaGF2aW9yOw0KPiBhIGNvbXBsZXRl
IHVwc3RyZWFtIGZpeCBzaG91bGQgbGluZWFyaXplIHJlc2VydmF0aW9uLXNldCBpbnZhbGlkYXRp
b24NCj4gd2l0aCB0aGUgc3RvcmUgKHRoZSBwYXRjaCBpcyBwcm92aWRlZCBhcyBhIHN0YXJ0aW5n
IHBvaW50KS4NCj4gDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS93b3JrX2l0ZW1zLzQxNDkNCj4gU2lnbmVkLW9mZi1ieTogd2FuZ3lhbmcgPHdhbmd5
YW5nMjVAb3RjYWl4LmlzY2FzLmFjLmNuPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRh
cmdldC9yaXNjdi9oZWxwZXIuaMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrKw0KPiDCoHRhcmdldC9y
aXNjdi90Y2cvb3BfaGVscGVyLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuYyB8wqAgMiArKw0KPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9oZWxw
ZXIuaCBiL3RhcmdldC9yaXNjdi9oZWxwZXIuaA0KPiBpbmRleCA1NDJiN2MyNjRmYy4uZWQ1Yjk3
MmUxYjUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9oZWxwZXIuaA0KPiArKysgYi90YXJn
ZXQvcmlzY3YvaGVscGVyLmgNCj4gQEAgLTEzNTgsMyArMTM1OCw2IEBAIERFRl9IRUxQRVJfMShz
c2Ftb3N3YXBfZGlzYWJsZWQsIHZvaWQsIGVudikNCj4gwqANCj4gwqAvKiBaYWxyc2MgU0Mgd3Jp
dGUgcHJvYmUgKi8NCj4gwqBERUZfSEVMUEVSX0ZMQUdTXzMoc2NfcHJvYmVfd3JpdGUsIFRDR19D
QUxMX05PX1dHLCB2b2lkLCBlbnYsIHRsLA0KPiB0bCkNCj4gKw0KPiArLyogSW52YWxpZGF0ZSBv
dGhlciBoYXJ0cycgcmVzZXJ2YXRpb25zIGFmdGVyIGEgc3VjY2Vzc2Z1bCBBTU8NCj4gc3RvcmUu
ICovDQo+ICtERUZfSEVMUEVSXzMoYW1vX2ludmFsaWRhdGVfcmVzZXJ2YXRpb25zLCB2b2lkLCBl
bnYsIHRsLCB0bCkNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMN
Cj4gYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+IGluZGV4IGJhM2M3ZGEzNzVhLi4x
MWNhYzc3ZTNmZSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0K
PiArKysgYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+IEBAIC0xOSw2ICsxOSw3IEBA
DQo+IMKgICovDQo+IMKgDQo+IMKgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRl
ICJxZW11L3JjdS5oIg0KPiDCoCNpbmNsdWRlICJjcHUuaCINCj4gwqAjaW5jbHVkZSAidGFyZ2V0
L3Jpc2N2L3RjZy9jc3IuaCINCj4gwqAjaW5jbHVkZSAiaW50ZXJuYWxzLmgiDQo+IEBAIC0yODMs
NiArMjg0LDMwIEBAIHZvaWQgaGVscGVyX3NjX3Byb2JlX3dyaXRlKENQVVJJU0NWU3RhdGUgKmVu
diwNCj4gdGFyZ2V0X3Vsb25nIGFkZHIsDQo+IMKgwqDCoMKgIHByb2JlX3dyaXRlKGVudiwgYWRk
ciwgc2l6ZSwgbW11X2lkeCwgcmEpOw0KPiDCoH0NCj4gwqANCj4gK3ZvaWQgaGVscGVyX2Ftb19p
bnZhbGlkYXRlX3Jlc2VydmF0aW9ucyhDUFVSSVNDVlN0YXRlICplbnYsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nIGFkZHIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dGFyZ2V0X3Vsb25nIHNpemUpDQo+ICt7DQo+ICvCoMKgwqAgQ1BVU3RhdGUgKmNwdTsNCj4gKw0K
PiArwqDCoMKgIFdJVEhfUkNVX1JFQURfTE9DS19HVUFSRCgpIHsNCj4gK8KgwqDCoMKgwqDCoMKg
IENQVV9GT1JFQUNIKGNwdSkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFVSSVNDVlN0
YXRlICpvdGhlcl9lbnYgPSBjcHVfZW52KGNwdSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRhcmdldF91bG9uZyByZXNlcnZhdGlvbjsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAob3RoZXJfZW52ID09IGVudikgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbnRpbnVlOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ICsNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2YXRpb24gPSBxYXRvbWljX3JlYWQoJm90aGVyX2Vudi0+
bG9hZF9yZXMpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmVzZXJ2YXRpb24gIT0g
KHRhcmdldF91bG9uZyktMSAmJg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
c2VydmF0aW9uID49IGFkZHIgJiYgcmVzZXJ2YXRpb24gLSBhZGRyIDwgc2l6ZSkgew0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFhdG9taWNfc2V0KCZvdGhlcl9lbnYtPmxvYWRf
cmVzLCAodGFyZ2V0X3Vsb25nKS0xKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiAr
wqDCoMKgwqDCoMKgwqAgfQ0KPiArwqDCoMKgIH0NCj4gK30NCj4gKw0KPiDCoCNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQ0KPiDCoA0KPiDCoHRhcmdldF91bG9uZyBoZWxwZXJfc3JldChDUFVSSVND
VlN0YXRlICplbnYpDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3RyYW5zbGF0ZS5j
DQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuYw0KPiBpbmRleCA5Njg0ZGJlNzUyOC4u
MDA3YTkwZjFlNjIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMN
Cj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuYw0KPiBAQCAtMTE1OSw2ICsxMTU5
LDggQEAgc3RhdGljIGJvb2wgZ2VuX2FtbyhEaXNhc0NvbnRleHQgKmN0eCwNCj4gYXJnX2F0b21p
YyAqYSwNCj4gwqDCoMKgwqAgZGVjb2RlX3NhdmVfb3BjKGN0eCwgUklTQ1ZfVVcyX0FMV0FZU19T
VE9SRV9BTU8pOw0KPiDCoMKgwqDCoCBzcmMxID0gZ2V0X2FkZHJlc3MoY3R4LCBhLT5yczEsIDAp
Ow0KPiDCoMKgwqDCoCBmdW5jKGRlc3QsIHNyYzEsIHNyYzIsIGN0eC0+bWVtX2lkeCwgbW9wKTsN
Cj4gK8KgwqDCoCBnZW5faGVscGVyX2Ftb19pbnZhbGlkYXRlX3Jlc2VydmF0aW9ucyh0Y2dfZW52
LCBzcmMxLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IHRjZ19jb25zdGFudF90
bChtZW1vcF9zaXplKG1vcCkpKTsNCj4gwqANCj4gwqDCoMKgwqAgZ2VuX3NldF9ncHIoY3R4LCBh
LT5yZCwgZGVzdCk7DQo+IMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiAtLSANCj4gMi40My4wDQo=

