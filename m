Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2BC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyijh-00071n-21; Tue, 25 Aug 2026 00:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyijf-000717-0h; Tue, 25 Aug 2026 00:26:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyijc-0004e9-LS; Tue, 25 Aug 2026 00:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787631964; x=1819167964;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=65q8CMYoEymtUy96xUbVikAIeA3rFixBi71aONj+7D0=;
 b=bmF3ZRa0yPfnaj7q+bK3Dxabf1CHPJJ9u6fnQAImpJx/2PdFlQm2U6Qs
 J/Po7p+N3RBzPm9/VQufJvvVEQuOk/tU2sGc9LQnk1ur3o70Ga1LohuZ5
 QG66GiVXZEP8DMad2HdFEoCCv3JOnxGSQUqwEya1jtIPiFuvgstKubk/7
 xZQasFFCiq/SbLZE5xwvXcjqpevF7rqAj6L6uOb32kC9ZkVnsujGuE0jp
 vKUdAGWAzSB7fWJAev74td9b5G09rVbGzHfPsSHdZUiSqCuFFeR/NoeMo
 mrfS7XxDvIVPCQd3OpoYSGq9XAgwHGLZVznPTUx6mQsUWRPranPvjQW1W A==;
X-CSE-ConnectionGUID: RdbB/OXtQsifyUhbgOz3FQ==
X-CSE-MsgGUID: woT/KLChQCiTxdTZ95D/Fw==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="155117237"
Received: from mail-northcentralusazon11013044.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.44])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:26:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBmJMljtJ+KJPucHiz8HpJoDZLKaIFeurxRjT/CYxRQeKc1G7/iMtTs00gy8UOgHCACvWwLNjGV8Ejn82NESYz+yTor6docFk/iFsG8suwwixTKB9BsgFvESl1Jd1mHb70aCLJy/wE4q2cZTY+lQncWc45VXKKbky6G647MzzxR52dmkMQCTd9wMCSGwThx+DqoWJKy7StxwLHbzrjhgww5sUhvhG23GDVCWMiSNgdN6Ql/kuvF0EEAQsAw3jlNZ7SR3FwIiAua9VVBmC8wVzUonwggOhiow3r2Rw27HaqCqiZt70glcmC94a28un2GIwFaiwsrWKCRf17mwyRWgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65q8CMYoEymtUy96xUbVikAIeA3rFixBi71aONj+7D0=;
 b=ngr2AWov78rRr1Tsjk6kXYIDiFxXigj02+Mi72vGi29e9hBh81tNEj0bKwI3IPPvTtHeuER8omR6TV8AONUaslOukD2gBc7ZGM1ClFUJeANuMtJSTBvbn2GdlH8Bg3hzPPs3C+WxxRam9Vb7MP5nO9Fm+IwRn1HV1fH80qaGtoVe2oJs6N9zVkbrkrg6LBzltdle/2U/E7iha+Azv53vQwgELtNQo8BasuTuectyZMmqDD4Q/HvFVE/iRkHJU2YUaZt7Xb8bOWU+33VnOhsprc+zIMR4lLJm55XK5Cj+Tf/fRqrz2iZsMmFeu4DpkH63gGcxM8PXYtuOecj4YSSTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65q8CMYoEymtUy96xUbVikAIeA3rFixBi71aONj+7D0=;
 b=aF0YN7jS5vmbweL+m/aBusy3+GfQhGcjaxh5HNCu1Cez+SOPbqtf5AlA+O6K5ydUEeb3sqAgsmKzXRG0AxWCHI70A3MtWcHNeCn8Owl2IGD30++TdvBgV0wTKEyQ5e+qPrBUmkARksdc7QkrwnhQ6v3dOYUrOGEDdYFK3IV7zyY=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MW4PR04MB7203.namprd04.prod.outlook.com (2603:10b6:303:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:25:59 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:25:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "max.chou@sifive.com" <max.chou@sifive.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 2/6] target/riscv/cpu: List one implied-ext rule per
 line
Thread-Topic: [PATCH v2 2/6] target/riscv/cpu: List one implied-ext rule per
 line
Thread-Index: AQHdKoI97I7o191T8UGevqHQAQMIJLauPqIA
Date: Tue, 25 Aug 2026 04:25:58 +0000
Message-ID: <d8bd978c0eee62e9f7654c2bb1699dca09bb664f.camel@wdc.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-3-max.chou@sifive.com>
In-Reply-To: <20260812174417.2468981-3-max.chou@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MW4PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: db02d120-fbaa-4a2a-7f06-08df0260f6b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|23010399003|366016|376014|56012099006|10067099003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: XAFbCMXYgbMlJxxnPrpK44kf3Uw5SwNG5F80Q6gb7CSztsJQ6eRkwcmwQ21CAG9vuKNw+ATxRmbrQMK5nLi7GYF/AXQKZHpRKKRxKK4FtHaFmmCBCdBcNjQ9lHtwPmDykJuKjtVA64toC83O99FjiqwYGyXOWKzo+7Ik5AMdD9oUdc2cEgaJFd7brsCQEJZu7iYfAMV3qUHaGxxPGht8st9nZH05CjPNvirhwJkhbi+i1xqRtN0Est0RY5Zj/qJhDXkBaZXpDaiV9/tiZZxFDpqdubd5W7j/DFri80BrSrpPEb1zOFheNPUZQTPt2xtvqcH0UA6atjHpvBhepSDgzJL35EA/AdgtxuEPnvTRm9sFQkFbJZgOjWzvIby1HDiE48JH9kZQZAMdiIEukJ+RUKfcmjIoUz+ClBeDR059PSluWoKkPu6PtTIVNzMsZ6fevEqe6I5hNKzO7d3s+j7H36E0wD9q9qu8MDNG+gbnjvpc2tjN3rUYjMQJCLTMdz2TFRWIcjRwG4hOTCcDyDwg2S6TvyMzOv7gucJ+KYEhUUXuc1JFlN9RkVzMjVaDjyBbL8mtZesN70JrRtO69Xrs6451SdkiFGChxIO38CDczuylo3HV88zoTxfsOyJk7M+WdbKB9BnZalye+/3rbFfm2vUfaPu854c6uC5K6UW5Z1g0zbhuv3Zt8/LWNqHY2DzrL8E3FYFT70EJ+ucLVjcNcj0MRn12lQFOCH7mGoBMrLo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDB5dUhQTnBSdktaSFZ0bXdwZFhscE50SWJKR0dKZ294SVhGR3JaaVp5VnNP?=
 =?utf-8?B?SUUxZlQ1d3dYTWRoWGJmaDdXSHN4cUZKa1VzaFEwbmRCU29NNXRLVmxvQThE?=
 =?utf-8?B?RWxaUG9MSitTK2J0U0RzNzdXUWIycXU0eGs3YSt4MnhweDNSQkRldmd1YWsy?=
 =?utf-8?B?M3lNRWFyMWtIMVFmLzNCTWhUMkZLRk1neDlFSXNlUm5kMHcvYVRCL1NPNWV0?=
 =?utf-8?B?b3ZEc2JBczFIWXpKL0xqN3J0a3c1M0hKd3REb1JGeUdVOHFDWE5GYzBlaUpD?=
 =?utf-8?B?dEtmMjUxTGcxNGVDZWtPblVlMk5jSlNhYTZ3bkVIUmVyRFIxZ05kMVRtSC9y?=
 =?utf-8?B?REZOVms1UjAwMkgzNUw0QUZ5RUxMZWlzRU1jdWhkYkN6QmYxYWhtci9pYnpM?=
 =?utf-8?B?Y3IvREh2ZXhmdU5UeWkyaGZnQVpMcWRITmFIQzcxc3VCdWtTN3B2Vk5WSUs0?=
 =?utf-8?B?OC9MdFpOU0RvNU91TFNrbmsvSGhWODlzbWwvUVR0Njl5VGdUVkYxUkpRRWt2?=
 =?utf-8?B?Y1hBSnlranR6SWxPUlYwVm44L2d1dGVvVmwvUldLNDJESDkvUTVkSTllaTV2?=
 =?utf-8?B?TXVWbjdLVlNGVi93WEdTZjJLN2NzYkNyMjNtaG9oalkzYjNOak9vSE4zWDBv?=
 =?utf-8?B?b0RBN2UrVUxDY1lsNi9DOTZpd1RDbnFINmhMc2JmQ2VBWmVVSFpEb0lEM2xM?=
 =?utf-8?B?VjB5SDA0Slk5TmhWam04QTVXVXZ6bGp1L294a1BiRVZ6UWluSjhRbWsxMGsy?=
 =?utf-8?B?clVnUzkvN0szQjBMT1FORHRZa2VjL002VFVobTVLdDEzTm54T0kvWWVoYVdT?=
 =?utf-8?B?ZENYbFc1SkhvQ2QzVFRPcVJDeDcwYnl5Z0ZMbG1BZXd0Z0sraDRrOHpkdDhK?=
 =?utf-8?B?WWdJOWNxbFdiQVg3OUpwN1Z4OVNsdjZZY2Q1SEJQQ0N4djlMNGwrT0RXdEFQ?=
 =?utf-8?B?WGtvZHZRZ3lkNmdVdHdTVG5HSW14YUlRbHVncXRLdG9IM3hFV21hOTRlN2xT?=
 =?utf-8?B?bW9EdUQrajFGRnpnS1hJbzJMUTd5WFlMTTlFMXdWdXp0bzJaaE1uZmdSS0pR?=
 =?utf-8?B?enQ5cmZ3NktvMWVHZGZkM096a096dWxZNGFEQndXNk5TZ0N4MHIzVVNieDN6?=
 =?utf-8?B?cy9WMHp2NjB2Q1NRVklCVzJiTDJFNkZnSitZWGhXVDRtb2FhL3dRY21aZC80?=
 =?utf-8?B?dDhDZGFtTi91QkFuZjRHUHhpRmJpbThqQ1h1WVc3NWpINngyNktVbjdlSGZq?=
 =?utf-8?B?ZHgrWk5HWHhLWUFPcHkvTzFUVFZOaC9rMFJ0N2VzRWRaUDZjQkdCTENIRi9r?=
 =?utf-8?B?S05tSjR1VkJTNWtCK0dkNjhaeVZVRWR6R3pmYzBzMndNeEJZMDFSM1JJQi9L?=
 =?utf-8?B?dlJ0Z0ppTTdSK1JCV3hITGZYWE5JK2pFbGdzazEvb3lZcXJpdjMrVzUwN3F4?=
 =?utf-8?B?N0lnWDNET213LzFVWHFLL0ZxZ3dWQno4elgzdFZ3UC9HemI4MU9DYUNqQnRh?=
 =?utf-8?B?aks0TmkvV2tQbndWbENnRVZTaDBqczY1MVdEVHdTWDBUTUhzK3NTTXhldmxS?=
 =?utf-8?B?aUlmSmc3U1l1OGlTTWRId2YrbHRSbUxIT2RUM3RQOHdFZ2VqL1hsakwrekZx?=
 =?utf-8?B?UmhwcXhDUUJqOWkwODlMMEEwNHNSUkVyRFY3bUlTK1UvdGw5SUJTb2dHV0pE?=
 =?utf-8?B?bkorekRQR09OQ0J5RGNRL2F3VXFVNTc4bGgrL3NHcTI2djJkeHNXN3RUVlNO?=
 =?utf-8?B?elRnc2VUOEsrTkhldmdJQ3hINUR5MzV6NkVyQVZPQW1nSzV1YlNicTFoR0Ra?=
 =?utf-8?B?SXltWGEvNTZ3YTlxYkVYODQ0UUdNSzJ3MmV3N1IwYWM3TlVsVVRyTzgyNUV5?=
 =?utf-8?B?VUhOWS81WUp5Q0t0T3NMQVlvL3pQN01TYXBmcFdqWU94ejRTVzdWTFlEWHU4?=
 =?utf-8?B?U1J0cm9ZTUlhdTlRVDhOaittRHY1OHNLU295cmZKcW9iQU95TFFRSldLMDND?=
 =?utf-8?B?WDVrYXpOSU9qaFlHbDJRanpBL1h1RTN3dGtCK2IxNFJHNU81WlI1amRaajdX?=
 =?utf-8?B?LzJWMStTU0w0U3hxTGZhaXFyOTk4aFliMG1QRVRsMlBkZXdtWHFGalF6NTFK?=
 =?utf-8?B?ZG51aWJtck8xUk5ablRnWmg3djR3WGhPMWU0Q0I3TWs5ekJrZGlITmdWdTVV?=
 =?utf-8?B?eXpOSHErbS9wN1pVZzZtSlBMQjdHUDgyakRBNStKNFZrQnBMSzR0MjJmWDhK?=
 =?utf-8?B?SzV1K2pEb09Qa01BQk9teWZacHZ0d1lkcFk5RnE0aWd4a0lBZnUwci90clFH?=
 =?utf-8?B?V0poRGpOaEtCckRnWHY4aUUrNWkvclJWK2pER2xhTkV5NXdoeEdCYXJnTVI3?=
 =?utf-8?Q?eT3CzBwEWtn85ZGemiEPkL2RaaTcs13kTFh1E4x1SG78v?=
x-ms-exchange-antispam-messagedata-1: bA6EBA5RJkY0GXBiitNIsNmnOyYq8K/yUGw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B9005ECE9AE564EBA814DD92129180C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o6/k5k/WsLwRX/eQPU8Dk2juU77Gz6ZXMeU0gggE3xhGe+GGtmZb7HtQS9SG+hBhTKxgAJAsCouhSCaD89+4YoYJtaWx/ECn+WwN+kD1/1+6dut3uK5ioadiBnrfxkbv1gz7GfRKObhUff07/kA+DzWHACR4o3+bZYXKgsCjit5u14BCf/1rR3ScIidRSRlKAI0ZLuj9SbsvEmpQ5IilvhDibQWDAXrAqjP12qfaD/dwU48hP0Oa3e590DwnPb/vMW5MyovzilbAqCCi820JlwpSov8Lw4lMrAtF+wZ34y1XsUK6rIAfbLPsLniYaIar/ZY9q7NBAbnqIymiXmkgtA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0c/hHkKnlAFjq0no+OgAWFiK0X+eKfogl6QY+j8bU+wZsPX2Wc+bBCZiRXKrAdkvddR0C0AoGIjmCs6Q7i5gh2ToTqIRmLoU6LNLfnSUxMRhn1auTfd2tUE4pX2OkZmG133Y4zVUofXQ3jmfWLVMF6Lml9cQ6AsOA/Z7NJv9WETkdX6ZWw0QVk40rLbEmCMCjCNp/a0R6A4HuWQsaSpnGV6Grr86r1h66kGPos0/shl8ACm2vQqWDZ22cY5kpXVJxLk76qm3XPLdWNeIaZBdaSsGcQ6d/+REET78RNcLNBrxXISNZIW4/7a9GWhhOVs/OQtrYPczrtzMDa9HkGlfCQLBwrEHQHq7GthSps2o13lcTjCMbC1OROxdImr3RMRxd2qzHU0rRO9WJfUooTWRHBq0o3Ixfg+O0VsdKrWsja4WjYXp2YqJ5EsPKfr05qdqBhpFmg2M+VvYRSRAXSjpBq7qK26cdqAzsbPzd9DywWDngm6BWyPFkd0itap4I/TnpTiKLqOO6xXIHkvnl4CKyCrlNvsJ4Kdf2w5UtkwYAWgkGAdjGT4h16Yb9i4vLiNH5LtkQTt5JcBl7BTtwlBIDcsxpekIRrA0Z05bkuXeFUw09A+53NAAeJxHhuv4wdOc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db02d120-fbaa-4a2a-7f06-08df0260f6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:25:58.9127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u518a3i90RbCx522ZsFTKls96jeNbZMh1hPnPs8PlgkEHQolRDHMSDrH5oTIaNNbxfusMw2jXCzuG7RETV7r6v/tQkyKKpg1Pe43J5S5S5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7203
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDAxOjQ0ICswODAwLCBNYXggQ2hvdSB3cm90ZToNCj4gRXZl
cnkgZW50cnkgYWRkZWQgdG8gcmlzY3ZfbXVsdGlfZXh0X2ltcGxpZWRfcnVsZXNbXSBjdXJyZW50
bHkgaGFzIHRvDQo+IHJlZmxvdyB3aGF0ZXZlciBsaW5lIGl0IGxhbmRzIG9uLCBzaW5jZSBlbnRy
aWVzIGFyZSBwYWNrZWQgc2V2ZXJhbA0KPiBwZXIgbGluZS4gTGlzdCBvbmUgcnVsZSBwZXIgbGlu
ZSBpbnN0ZWFkIHNvIGZ1dHVyZSBhZGRpdGlvbnMgYXJlIGENCj4gcHVyZSBhcHBlbmQuDQo+IA0K
PiBTdWdnZXN0ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96
YUBvc3MucXVhbGNvbW0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggQ2hvdSA8bWF4LmNob3VA
c2lmaXZlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvY3B1
LmMgfCA1OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAt
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1
LmMNCj4gaW5kZXggZTY0M2Q3YzdhZjcuLmZmZmI5MmZmMTEwIDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvcmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IEBAIC0yODE4LDIw
ICsyODE4LDUwIEBAIFJJU0NWQ1BVSW1wbGllZEV4dHNSdWxlDQo+ICpyaXNjdl9taXNhX2V4dF9p
bXBsaWVkX3J1bGVzW10gPSB7DQo+IMKgfTsNCj4gwqANCj4gwqBSSVNDVkNQVUltcGxpZWRFeHRz
UnVsZSAqcmlzY3ZfbXVsdGlfZXh0X2ltcGxpZWRfcnVsZXNbXSA9IHsNCj4gLcKgwqDCoCAmWkNC
X0lNUExJRUQsICZaQ0RfSU1QTElFRCwgJlpDRV9JTVBMSUVELA0KPiAtwqDCoMKgICZaQ0ZfSU1Q
TElFRCwgJlpDTVBfSU1QTElFRCwgJlpDTVRfSU1QTElFRCwNCj4gLcKgwqDCoCAmWkRJTlhfSU1Q
TElFRCwgJlpGQV9JTVBMSUVELCAmWkZCRk1JTl9JTVBMSUVELA0KPiAtwqDCoMKgICZaRkhfSU1Q
TElFRCwgJlpGSE1JTl9JTVBMSUVELCAmWkZJTlhfSU1QTElFRCwNCj4gLcKgwqDCoCAmWkhJTlhf
SU1QTElFRCwgJlpISU5YTUlOX0lNUExJRUQsICZaSUNOVFJfSU1QTElFRCwNCj4gLcKgwqDCoCAm
WklIUE1fSU1QTElFRCwgJlpLX0lNUExJRUQsICZaS05fSU1QTElFRCwNCj4gLcKgwqDCoCAmWktT
X0lNUExJRUQsICZaVkJCX0lNUExJRUQsICZaVkUzMkZfSU1QTElFRCwNCj4gLcKgwqDCoCAmWlZF
MzJYX0lNUExJRUQsICZaVkU2NERfSU1QTElFRCwgJlpWRTY0Rl9JTVBMSUVELA0KPiAmWlZFNjRY
X0lNUExJRUQsDQo+IC3CoMKgwqAgJlpWRkJGQV9JTVBMSUVELCAmWlZGQkZNSU5fSU1QTElFRCwg
JlpWRkJGV01BX0lNUExJRUQsDQo+IC3CoMKgwqAgJlpWRkhfSU1QTElFRCwgJlpWRkhNSU5fSU1Q
TElFRCwgJlpWS05fSU1QTElFRCwNCj4gLcKgwqDCoCAmWlZLTkNfSU1QTElFRCwgJlpWS05HX0lN
UExJRUQsICZaVktOSEJfSU1QTElFRCwNCj4gLcKgwqDCoCAmWlZLU19JTVBMSUVELMKgICZaVktT
Q19JTVBMSUVELCAmWlZLU0dfSU1QTElFRCwgJlNIQV9JTVBMSUVELA0KPiAtwqDCoMKgICZTU0NG
R19JTVBMSUVELCAmU1VQTV9JTVBMSUVELCAmU1NQTV9JTVBMSUVELCAmU01DVFJfSU1QTElFRCwN
Cj4gLcKgwqDCoCAmU1NDVFJfSU1QTElFRCwgJlNTU1RBVEVFTl9JTVBMSUVELA0KPiArwqDCoMKg
ICZaQ0JfSU1QTElFRCwNCj4gK8KgwqDCoCAmWkNEX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpDRV9J
TVBMSUVELA0KPiArwqDCoMKgICZaQ0ZfSU1QTElFRCwNCj4gK8KgwqDCoCAmWkNNUF9JTVBMSUVE
LA0KPiArwqDCoMKgICZaQ01UX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpESU5YX0lNUExJRUQsDQo+
ICvCoMKgwqAgJlpGQV9JTVBMSUVELA0KPiArwqDCoMKgICZaRkJGTUlOX0lNUExJRUQsDQo+ICvC
oMKgwqAgJlpGSF9JTVBMSUVELA0KPiArwqDCoMKgICZaRkhNSU5fSU1QTElFRCwNCj4gK8KgwqDC
oCAmWkZJTlhfSU1QTElFRCwNCj4gK8KgwqDCoCAmWkhJTlhfSU1QTElFRCwNCj4gK8KgwqDCoCAm
WkhJTlhNSU5fSU1QTElFRCwNCj4gK8KgwqDCoCAmWklDTlRSX0lNUExJRUQsDQo+ICvCoMKgwqAg
JlpJSFBNX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpLX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpLTl9J
TVBMSUVELA0KPiArwqDCoMKgICZaS1NfSU1QTElFRCwNCj4gK8KgwqDCoCAmWlZCQl9JTVBMSUVE
LA0KPiArwqDCoMKgICZaVkUzMkZfSU1QTElFRCwNCj4gK8KgwqDCoCAmWlZFMzJYX0lNUExJRUQs
DQo+ICvCoMKgwqAgJlpWRTY0RF9JTVBMSUVELA0KPiArwqDCoMKgICZaVkU2NEZfSU1QTElFRCwN
Cj4gK8KgwqDCoCAmWlZFNjRYX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpWRkJGQV9JTVBMSUVELA0K
PiArwqDCoMKgICZaVkZCRk1JTl9JTVBMSUVELA0KPiArwqDCoMKgICZaVkZCRldNQV9JTVBMSUVE
LA0KPiArwqDCoMKgICZaVkZIX0lNUExJRUQsDQo+ICvCoMKgwqAgJlpWRkhNSU5fSU1QTElFRCwN
Cj4gK8KgwqDCoCAmWlZLTl9JTVBMSUVELA0KPiArwqDCoMKgICZaVktOQ19JTVBMSUVELA0KPiAr
wqDCoMKgICZaVktOR19JTVBMSUVELA0KPiArwqDCoMKgICZaVktOSEJfSU1QTElFRCwNCj4gK8Kg
wqDCoCAmWlZLU19JTVBMSUVELA0KPiArwqDCoMKgICZaVktTQ19JTVBMSUVELA0KPiArwqDCoMKg
ICZaVktTR19JTVBMSUVELA0KPiArwqDCoMKgICZTSEFfSU1QTElFRCwNCj4gK8KgwqDCoCAmU1ND
RkdfSU1QTElFRCwNCj4gK8KgwqDCoCAmU1VQTV9JTVBMSUVELA0KPiArwqDCoMKgICZTU1BNX0lN
UExJRUQsDQo+ICvCoMKgwqAgJlNNQ1RSX0lNUExJRUQsDQo+ICvCoMKgwqAgJlNTQ1RSX0lNUExJ
RUQsDQo+ICvCoMKgwqAgJlNTU1RBVEVFTl9JTVBMSUVELA0KPiDCoMKgwqDCoCBOVUxMDQo+IMKg
fTsNCj4gwqANCg==

