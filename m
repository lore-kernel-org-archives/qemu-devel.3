Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2496DC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0je-0006gN-EZ; Mon, 03 Jun 2024 01:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jc-0006fK-L6
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:56 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jb-00072f-46
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394395; x=1748930395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=G2BzbSny39P4fdizLrh6jG4JjEQ07fIWBaaifb3U2CM=;
 b=F9Jssn0O0FohCKPT7FPC8C7VW2R065u4P8xNNmkMHOFxFopNeNRfpXPq
 VJf3nl7+dKrxt8x4pcb2dGbJyGf8R0hwyn1ggiTCxHNxOom1gZ1AuFoFE
 EVMbnOuGz/gscXuLM9S8HsMDzkWLivA08apuD4Y4RhvOjcrty8JB5YAn/
 whFxP5DLU8ZHJm2inMVDSWHdkxQSxl95efnrJcMbGOqIALCbkKy9UHAy8
 vs0IcjBd0qx3Eh1z/NL3CvCOQK5JqxGIzKC//1PjH0b9wlxkHIX/WuktJ
 0u6PG31hvA5+n6IjOqYD55BZ/wE4btDo3bBM7FwXrR1BohYaoDl3sjkWl Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763242"
X-MGA-submission: =?us-ascii?q?MDHDuGsePGGpHY0LolPAAzzNi8OQip5sUk7vwK?=
 =?us-ascii?q?Vn0NV55XhkoKpXBEnAe+PCifj2WISdn0H3YUus4ESrGGtmccvy/1XGlI?=
 =?us-ascii?q?35hVDVybIdDNw18i7c3cHCiPdxPgpIvtrSsQ73MokrXzSRmLZJCbrU+W?=
 =?us-ascii?q?OztL4KaWKLB1GaADj9BvuG7A=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX1szg+U0Hc3UHbICwpj0c7kt5V+uACviTHPB7Bd0Gzps1i0aYgYFby7we5HdZTTnujTuOCEBtMr0X6HAD3+QwH9FDaHzhDJqWX3DrIt2fGZTOOMxCyqWVTCuM7e/v/snwAoP8Iv1d0jbKIlaTnU3Z/p4f5eBXMYOB/rHc5O0b8kUurlLfcv2MuZpK/bewsDaIsd4yBVEezc2umErcPAAqXSYW+gf0keO85Lz01PCZbpOFM6CphcLJoqEyc8C84LT5TVbTbFGpQddRmpRBM2LaLJuwjfxanLaKECcxUICN2o1/YEJs6zjESQKi8uCOsEBI+RG/n6BF3vSdXm/uTvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2BzbSny39P4fdizLrh6jG4JjEQ07fIWBaaifb3U2CM=;
 b=OuCfMYeu/AImqpTjRpfmMKvOACGmLd8n3aoXfrfVJ2O5khF1rrGROovcrmfWvbSoWgRw7BgFQkB0ePacsMJNcrg5yyXQ0ZHCmc9gF0ooeCNiiAd0w49uv5N74VGracex4HGlyZgVR4CSbYtvPjj15J1obLONaUz4hpx2C/yXWLXGafvoXvdkEuOMIgyvMMahSlGA2Jmuw82fT3REAA0IVOVIFRvhvXurJqRWS3JlNr0ReTobw7YjYnFvu+iyXlt9RyKvA/MPHqN5w5eVU6F4ULjYcIoczE6OL+pR9amOodzaSCQJ2OCtas1ngL6dzZhozMEkGYL3BM+lt2IhuldQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2BzbSny39P4fdizLrh6jG4JjEQ07fIWBaaifb3U2CM=;
 b=OzHF/z9BRGkpq2P4zM1V6gCT/AaNwJ9TM9rp4Vj8ux0IQ44VbATb5Rof+bVxy6DE6Ikn/iHmjplfRfuoq8FDeM0Q8MHqnz3C1lEh6Df3bLKXlu6G2aHM4KbEE+lx+h1iUhwWuQmPyU/ZZto9TL3sRVXvYHTUtxWz9lDFnUN9dZpZD7bs7W5jnGiqoyQkyRPtiM8xn96cpA/ecEiOyDSyt8CVA+mxaTf7MRmn2CKZTL2GTNTNQD/BRApHG1ZalmdMX0xODAFvtDdiTtRO8SDLM3lLK1vSZZfOaH870bR3/IN+B0e4Ny6hPRoC2IQ6W2jXhgSMURuejxR05yegP2EkiQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 11/22] memory: store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH ats_vtd v5 11/22] memory: store user data pointer in the
 IOMMU notifiers
Thread-Index: AQHatXs9nZh6lgkWUUu4ORXkPadJwA==
Date: Mon, 3 Jun 2024 05:59:47 +0000
Message-ID: <20240603055917.18735-12-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 552f9079-c994-4d11-7d45-08dc83925ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bUdaZTVOMEIyeG5vNGsxRktpTDR5ZUlpWWVyR1RrckJ1U3lNR2cyUFhQZC90?=
 =?utf-8?B?WFhZRkVUMWtiMkcyNFQydEtOamhqbFlKYlo0YjNCaEx6cU9oSFF1bEcwRlRJ?=
 =?utf-8?B?cXJVT2ZKbW9mKzcyeWFSLzlTelNGYitabGIxVmhOZms5TUd3ZGswdEZQZTYy?=
 =?utf-8?B?cXZSQkRITmoxY3drTFBLT0o0Q0lVTElucEV5QWFaTlNCSS9NWjVLMml2S2wy?=
 =?utf-8?B?c1hoRG03SUhLZ3Q4NUlGT2hkVDRjMTl4NHFhS0MzOW56Y2ROTDFVNjhMR0Fl?=
 =?utf-8?B?RWU5aVMrYkVwR3Y1aDk4Qm41NHZabFA5ZXUyR0dFRHlwbFNWSURGaUVNL2lG?=
 =?utf-8?B?MXpmWUY1WDh6RmZZMXdXeGRSRmU5QlA4TDZXWmUvZkVIMEJMT2xhemNPdCtj?=
 =?utf-8?B?WEwyUDRxRkxZSytBbHhabmh0L21ac2pJb2U4QVJ4cDB6NmVyRXhCQjk5SGpo?=
 =?utf-8?B?aE1LS2hjS3RVK08wUFRWdkhRSEVodm5rYjNSTnNqWUFRNkJJSUVZNjNsamk4?=
 =?utf-8?B?TnlpbUFzNFU5bWRENUFxR21aeWZGRXVlMGpOZTlqaDJDbjMwbGVTanRjeFV6?=
 =?utf-8?B?WnZmUmRlTE9nZ2x4OGtkZStTTmdUNkh3b2xSNkM4bEJvY0pDREdMc2YrODJI?=
 =?utf-8?B?ZUZVUURhU2pJb09ySGs4YzlSdXlzU2RvSFZxdTFBM1FpWkdpSnFMbHlROFdj?=
 =?utf-8?B?QUVNcmV1MjV5MFFxeDhyY2x6MDdWdDlMaEJIaE5icVpqWjh4UmJDUlFra0hJ?=
 =?utf-8?B?QWVoMzNOTCt0bmFFMndCRWw0c084UVg0MkoveWV3clg3S0tEcXp2V3lwUWp6?=
 =?utf-8?B?R2RIVGlZN05wVk0rTFBBSFpwVThwV3MzQStVU3hMaUdkeVB1UzNnOXVNOHVC?=
 =?utf-8?B?OEdRR2dPYTZCekw0dVJqbVRoN0dsTHVxeXNGanpWZGZ6N3V0UlhaZUwyRi9Z?=
 =?utf-8?B?KzdldHpHalcxZEJHTktwMG1lNDBwdDJXcG5GazBGMEMzandVWGUyS2hNTUtN?=
 =?utf-8?B?UFpHb1BFU1ZVNkRqdUluT3IwSXNZVW1xQ1JXcFBaT3BQZGF4SFpxK3pNS2F6?=
 =?utf-8?B?TzYyVW93RTBZSUlGMTVVdDZJNmo0bm5rTnd2dUxyM29QcjVRN2lKMmlid1Vl?=
 =?utf-8?B?R0pvdGdPbG9PbU1iQjVKOU5BMlpWWlJ6YURQeEF4SE0zRWRHMkJHOVFhZ0pG?=
 =?utf-8?B?MW94MjR4V1AvUE9Ic3hvRFR1MkthZHBROVBkOHdTN0tNaHFjUGpnMnoyN2Ex?=
 =?utf-8?B?N2hKY2ZVOFZZZ2tSbU15ZWlkMWVOWG9Rc3ZXdHloSEo0RjljRlF2VlRvT1lv?=
 =?utf-8?B?YWFBVUg2cUFTcWV6cEk1MUFtbE5jWVh4eFBMR2pUdFYyeDZuRU5EZHFoQXp5?=
 =?utf-8?B?QVJBUy9ZMzR2UDVTMTd0MEZmcUN0anN0R1N3T2pmcUlEVVU0Ynpoa3dvTHhj?=
 =?utf-8?B?RStockoyRXNMNmxPOUR3NksrQTNrTzM2bWJLWlJGUGt6dTVXR1NVdzFXbm43?=
 =?utf-8?B?RUI1eks4V004UHBiUXBPQTFWUVJVZFRsbmRnTTZvcWdnMFJpRVMycm5xWjIw?=
 =?utf-8?B?d0Z3YVJySkl3bGJrQW9vbCtDcEl6Zm5lcGZ4WTlFbHlKZWVDWkEzdU50cVMy?=
 =?utf-8?B?blJjeGQvRVBoWGUrWG1EVnh3dlkweEZVSVA1QVdGbk5Cb0taVDBodmtqNWVi?=
 =?utf-8?B?bWxJaDJOcllpQVpKRU8yb2thcTFsWTdBZVZUVVc1VXprOHFVcW1zRkZhVWhi?=
 =?utf-8?B?NTdSTmkxWWpkNXd4Z0M4a2dqcjZUdTJhaVB5cUI3Umd0Vm1BUGRwN2gxMlV1?=
 =?utf-8?B?SlY1UThRMzFDM25nOXZ0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNKUElBRHp4M3J3UVJYQys4c0s0bERPR1ppZVhORzhsYXRRUXFNZTVqUG5H?=
 =?utf-8?B?YmU5Z0EwUHIwRk1adGxOalYvODBaV1BITUF5TENVQlY0ZVVnMHN6U1V1bWc5?=
 =?utf-8?B?KzdPRzlYcW9ja2RDRnQwNmlZWUhqMmt1T0NZQzVFMHdSRW9VSnFZTDlUcjM2?=
 =?utf-8?B?YU05eVBYaU8rT0U3NWtxUmZYQW9wZlJjTTJTYmE5UjB3K2ltL2Q0QmNVencr?=
 =?utf-8?B?REhsSkV2YmdLZDVHRENDamsrUEtSTjdtdCtPNXdxTkVwR0tkSm16bGdKTFdT?=
 =?utf-8?B?cURSRDZKeGlMRE1FY0dBNm1WbXdjQ3ZMS1hJSkxncERXVzFDd2xNdnV6cTB4?=
 =?utf-8?B?OUtDNjliaUkxcFMzR1ZJaWtYNmd5MUFNMVhuK1MvaEpoMUloaG5GQ0VTOHQ5?=
 =?utf-8?B?WHdKd3FBeWd2UVlSTFIvb2tFaDZrSmE3d1lsZGxZb0hiSTY5Qnk2bldwTVQx?=
 =?utf-8?B?ak9pRnkvajBwTjBCaUJDd3MxdjNYclRMc0hqQWVQMkh0dTBNNWZHL2ZjcnV4?=
 =?utf-8?B?a3drWW12ZEZXNVovNXNoV3p2TVRXR25WL1hoLzZnM3JPMkVPMHdic2REVTN0?=
 =?utf-8?B?czNUYjgxczZ6MGtkYWRRUlFrMTE3eWpzQUc0WDRxbTkzK2haQWx6eDRTVnIx?=
 =?utf-8?B?OENoSzlNOStkSkJQYk43dmljR2JrZUZSNzhIN1FqejVqYnVQRENQT2tUaUhr?=
 =?utf-8?B?NSt4RTFFUkVUR3U2MitqRlRDMjBXYkx3SjlRTlEvMnVZemR3dFZIRzNSUGk2?=
 =?utf-8?B?Y0JacWpuVWJNSTA5RjZXTkp5MjB4Y2diTU5lT2ZIY3pBaHA1Vm0rMlErdW00?=
 =?utf-8?B?OFFSUXBUZUtUbU5qNS9JbDZvN3BUemM0OTc2RGlaUUdyRHFoUEU2TTkxVE1T?=
 =?utf-8?B?QlpEMHA2Wm9VVWNabWd2VGdKd3JzeXRXeUpEVzkxNmZjZDcydy9EcEI3UE9Y?=
 =?utf-8?B?Nkt4b3NSNlZLVjNwcHVrMHNURnBFVCt6ZU1zNXNRcyt0RFJpYmsvQXhNd3JJ?=
 =?utf-8?B?RXhPS1g4ZFFEc1AxYnN4bFAydlphUFVGWDViWjhRditFemZpTktHVS9wUGJz?=
 =?utf-8?B?ZFA0WklyV3pkTnhiUG9XRHByL2RPdTJYYTh2aHdtTnMzeFN3SERhLzNpd25y?=
 =?utf-8?B?a2tESXRxRktqRCt4aTBSNWxGZHVCMURFZ1hjNHhrdnB0a2hsMlZoZ1RqWGlI?=
 =?utf-8?B?cmErZlBIY2FzMG5Hb2FjWWFuMTJJbnExVGt6Y1B3VTNqbU50ZW1YNERUQVNq?=
 =?utf-8?B?MTZIODFJUkovNVlWcFYyMkZqU3dUdW9hM1VPYXMwVGtRTUtwL0N5bzNrSjRD?=
 =?utf-8?B?ckJxaUpKVGNnSFQwZUVnYW0vRTg2MnZQMnpQekQxeFpEZE1neCtYQU5oYnJQ?=
 =?utf-8?B?aU1VNXg3TUJNeTYvMkcwTFlWSHR5T0NIZlpWZGZiUUs1Y1lBbGFwNjdINk5T?=
 =?utf-8?B?TkVJWElqOFkwZUJkTnFNS3k2Q21NR0VCSE1hYVFhWGhDd1pQbGJBeUE2TGsy?=
 =?utf-8?B?SHVJaUVjUllHVjFuUGphRUNJQk03OGhvUzNwS3MvMnBjSmJuWDBUdDZHbjZP?=
 =?utf-8?B?TW9xVEdqU09sQlRVZG45a3hiYW9CQ0ZnaTZZRVFwSmc4SWcyNkpJbTBQK3BS?=
 =?utf-8?B?SnhFOU04M0hmd0FuVGFsSU9PYWNLRGFhbm9DcU1xc1ROYVEzMXdnTEFJS2hk?=
 =?utf-8?B?VllrQkRYSmFzOGNUWUtNT0xjUWpjbHd2RFdRZVE3emdrUkdla1hyUjJxdEpZ?=
 =?utf-8?B?Q1VpYk5KTXRKbm1SdW1aUmZWSGhsYWNoNVRCcFQwS0dtSTRyN0sxWHNYSXoy?=
 =?utf-8?B?TWV4OUVsSXdGSXdTOWJCV1VHc3lMWUZ1dUJZbkNUUWxuTGR3cDhCSUxMZ2ZM?=
 =?utf-8?B?VHlVdWFpMXhZbUtBdCtIQ29hS1Z6eWsrS2hrVndJMzhyQzhxa09OWGFvbVR3?=
 =?utf-8?B?L0Q3UkRZbmpGNnlNM1lYS2NLTnB6M1BZeG5ZZWhXeTd0bXJmVkhmaDhOVVA0?=
 =?utf-8?B?QWlVTi82Rm1acFdUb3I0RnZHK0tpY013U2pKbjdrU0N5RXN6MnBSUWpUS0wv?=
 =?utf-8?B?WWdtNEN0L0VsUnpobElHR3prYjNCMDlSUEJLd3ZmZTVOSy9rQXdnMlYvTy9N?=
 =?utf-8?B?TlR2YUVVaG1KRmZmbTc1UFZ0R3JwQUdaRTJheTQ1K3dFcHROQmpqbXA0OExI?=
 =?utf-8?Q?fKQSIQ3VPIS/mw0bvbEY3Xs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B74A3846C16993468168394DC2ECCBBD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f9079-c994-4d11-7d45-08dc83925ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:47.8062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87vwKN3yfrL0OM1Fk73HaFaVCHbEz38u3kcwiswO4iY6C5ZF1LDHBB74uOIMx91AG/67eYSPPlOqpJPTb7BJDT7O5F/OCmnuR+xUMrbNKGMs961sizfPn85CatU+15FA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBoZWxwIGRldmVsb3BlcnMgb2Ygc3ZtIGRldmljZXMgdG8gdHJh
Y2sgYSBzdGF0ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnku
aCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQppbmRleCAwMDY3
YjIyNjZhLi4zNTliY2EyYWUyIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQor
KysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0yMDMsNiArMjAzLDcgQEAgc3RydWN0IElP
TU1VTm90aWZpZXIgew0KICAgICBod2FkZHIgc3RhcnQ7DQogICAgIGh3YWRkciBlbmQ7DQogICAg
IGludCBpb21tdV9pZHg7DQorICAgIHZvaWQqIG9wYXF1ZTsNCiAgICAgUUxJU1RfRU5UUlkoSU9N
TVVOb3RpZmllcikgbm9kZTsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IElPTU1VTm90aWZpZXIgSU9N
TVVOb3RpZmllcjsNCi0tIA0KMi40NS4xDQo=

