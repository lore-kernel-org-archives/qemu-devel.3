Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B18C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4gb-00019E-7K; Thu, 08 Aug 2024 11:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sc4gV-00018G-JY
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:04:12 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sc4gT-0002QL-2N
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723129449; x=1754665449;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Xu09/gzc3JKQwsL3qK/UGuFEYcNwHC3fWsI++rs59Js=;
 b=GQX3YAjudIbiX/06i7BZgOdjW/NT/nArdTTbdOwjxzi8GTFDDFkn/Jdp
 LO2Dx10tlYA71iPQ7zdd2VB7rCiGkbbxyFzJMSU3gNLOhlJzHHBgwBoUQ
 IHcJVnEnXA+EjS8Tr6JQJ2VTVvuvmlEYxFObR2qmwoRS8r3DFqATsaBjW
 kPSXsLgPS3dp5ByHsKoZ1mnn7X+YfXK2pMQ0aLr4QbBGE6LINVAI4kCwO
 8I4mhgQnjGUQFqEHYBZkoNvVlqrXO1PFM3vjNa0F/W3L0VbpMhlmr6eH5
 8c2IRBfcRlLbtDYfV0wB1sOEXDecMoE2uw2E/Pess2u2wrMVi+tICv2ZR g==;
X-IronPort-AV: E=Sophos;i="6.09,273,1716242400"; d="scan'208";a="18034640"
X-MGA-submission: =?us-ascii?q?MDGj0TbsKURjHdw9RyMdRLH3IG4LAyfxPbkJ1M?=
 =?us-ascii?q?+kHYL0PUtQ7GqA1OV6Zvo1Cgz8mnUvdKQePXQ/X6vzVMddqOU7SMoFCg?=
 =?us-ascii?q?yx5XvL/HqzPTqAAcKh+vD4UStLt330p8PCuayjKOTO7t5l/UwAJ1dz+l?=
 =?us-ascii?q?lnJ4s3qhPXXSULmYpKOiVAnw=3D=3D?=
Received: from mail-am0eur02lp2240.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.240])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 17:04:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVvNsrpjmNoWU7/PkiKpEZjU2xyMFi2cGxSh/H2cLH/vf+6rgAU9L+Efl9Wu/rmkh+HdmWz4cPQH12drnyuM5TZVxadzoJqB27kltgb18G5QQJAIV/Ib/VlzyZIyyqYdsw6MgiwmR6okA4li0P5ukcVFwBz2Su54vOd9zsfs3n2aYbzq9NndaKY7WIEOQo217ohBKVHmPtPYGZSZKi+CevermO7P+B5v/POEvA7nTIAvooWtB1BqYY4x4o1BsFqympmTJSuZgqEmcH+1F3KH16ENRuW8aYjWjLfWkW6BmIm2NddjVsNkpYeHCxHeWoDoJMjZBVXteH5kxq3ijL8urQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu09/gzc3JKQwsL3qK/UGuFEYcNwHC3fWsI++rs59Js=;
 b=N+BMtbrh86iXXs30slO1CQYKSi+PCm6v8Gg2INzeJq+cbcMepP5LLfrpj6Q7EKAZicNxTLlWoeRX1mQnSsgb6Vj88MpwT01I53LH6BhTYerkFPqU7l9H+f9ravcMnWiM69My/lwYkjPZFWDUDkYdjMxfTaSdXO6eXWg9IeWMO53QDpUUvvgLv/gbzZyKovSIehClARYTIU4tYKHTQChvqrYH9uGd79OGfGh+IBRd6OBPAD39wpWqCLB2zpzCRt9673VcWXfJ42bc0CoSVKNAbIwq2Rc1Olf7EKKn7/qz4x18R4C1da9LR6YtJJr1fWHrOGEXgO6n2KgazQycqWCeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu09/gzc3JKQwsL3qK/UGuFEYcNwHC3fWsI++rs59Js=;
 b=hz2knzA6mImwC90zO+bY3N9eVYchDxceNeQKYXMS8LEwc5KR25avY0/DCOco3PeLkQMdIqosyVJ/DR4FvrWRXu+WjeVYgqFD8LdAvZ5xbAQZxq9B6dAkEW0nH46w7Ii8krqPPBgV65WCIDOMNGiro0JIiYnhz7uy7UViGab870znyYwVTgOf7rRR8Bob1r0qZm4bPEjR88Jn7TxIcstiaNraTrDg4nHOInQhVlqVTkW24o0k6PlV+skkB9tO7pyV+fAmuB/E5LlEji+g8jGonFCONOVfBRey8SBZ9V1CuB0AQKdPp+U2cBJvA+mHT5aE51UNYlluV0t+j/y/Fd1v8g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB7691.eurprd07.prod.outlook.com (2603:10a6:10:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 15:04:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 15:04:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wDz+IzscR3Wh02h51iysT4RrLIZx5WAgAOIVYCAACpsgA==
Date: Thu, 8 Aug 2024 15:04:02 +0000
Message-ID: <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
 <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
In-Reply-To: <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB7691:EE_
x-ms-office365-filtering-correlation-id: e0c20396-f605-40c7-1dbb-08dcb7bb56d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SkRUNlI3VXh1NTBjamhsS2J4TlFDU3F6MUVvbU9qZDdkRThML1l1TFJ1UEU2?=
 =?utf-8?B?d1lUVzVOc3JVNlNhQjBqbzZPRllkR29WTXBkeVZyYVRhZFFLdFpqc2ltMm94?=
 =?utf-8?B?a1JTWUJXMDVOOXBqSXZNOE56L1I2b25HcDN4Q3A0NE9oUTBBTTVkbTkzaExj?=
 =?utf-8?B?TXJRSEk3QmhaOURheUpIdGpuRC9Jd1l1a29kL0ZEVUFtU2d5cTVvSU9oS1cw?=
 =?utf-8?B?UmRrMC9vQ2ZDbTNsMDJJWnBWQVQ3d3dZYjdoVHEvcFduWkFScjk0UjBPK2pV?=
 =?utf-8?B?Z0lNMER6dUcrOE40elBWcVN1Tm11QlRTMWxxdkdpU1RNUGR2cWVTSWVnVElv?=
 =?utf-8?B?ZjZhZys2N0xGRlA5cEpXcktJOHFnbXVZZVh1ZFVKejlVMno5Y2tPU25IWUpR?=
 =?utf-8?B?S0hwNnZyR3picU1TZkJpL2RrQ3VrOU1USWswNUpZTlY2ZHhWQW56RkRpNjJh?=
 =?utf-8?B?SE1zOFNUMythcHloT3RHYjR0TG81TlR4K3JrY0pwRE9hbW5vZjAvU0RhNDVT?=
 =?utf-8?B?eEord3ZjZEhEbkdEaytnR2hSV2xiTzZpTEdnMWNRcVppYmFRckVRNzZXZ2I2?=
 =?utf-8?B?ZWs0V0hUUmFvUjRmOHF2NE8rd1JBekZ1T2hpV3d5THc4TkJHMmM2MjByTnRh?=
 =?utf-8?B?QjN3L0haM2lwa3BEMDVzMEFKV2hqZ01CdWlobVRGT3BXOGZhRmNVMmxyTDdF?=
 =?utf-8?B?NFc2MGdFSTVVTkpBR3FBQ0w0c2Qra3IzZ3R1TC84N29DWnJiMkN2T0p4OFpX?=
 =?utf-8?B?VVJqVUVHZm9RYWxZKzNLV1J4R29GSUsvdXlqZmpTQUp3Mk9zZkF0REZvMHNL?=
 =?utf-8?B?WlZnLzZXeTBNZnduTW5JVXM2UVNoT0g2Sm1nVkVhWld4ejBWcWcrcTR2Y25m?=
 =?utf-8?B?V0JBMVR5dEIvQmplSnA0ZUJQcmY4ejhGcXR4RGJHaEh0ejhabXhVOEd4dzJm?=
 =?utf-8?B?TVdxU3JuSXVZZmNSQXBpbEk1N0taMGdveHVPTk1QZlNxN3Nxdk9Ma3lBMStR?=
 =?utf-8?B?dXN4bTBiOXppaWtQeE5mMGxoZURqbVZob3owN2gxNmVTV3NFcStlcFVIdWxB?=
 =?utf-8?B?d1VOS1BtYVhhSVgrckROTWVsbGNaY1JaN2pDaG4yRm5rSXJkemtyNFB4Z2M1?=
 =?utf-8?B?aTlFZVF2ZzRWWHRabVo2d2tLbVlxNlBDOVhpbHJTc2lXcW9Kd2FOSDltdFcx?=
 =?utf-8?B?R3VOZTlBblNHbzVwQUQzYy8zSktmR0FNZ1N2RW9OOUxyN3V0M1E4WXpZSWFt?=
 =?utf-8?B?VVJyZzQ1VlJTNlpiVWlVcmlvUmJncE0zV0Z6bjBmZ3JOQlJEbjlDYitxUVRU?=
 =?utf-8?B?b2pWam0reHc3alFac0RldC9UK0pWdHlvNGhBc2s2dDZRQWV2SlN3M3pvRC9p?=
 =?utf-8?B?YU1waWRrMmErVkc4UWVNWitVb1FwdVdmdkVpbEdzWVdlRURuemFPZlp6SGFY?=
 =?utf-8?B?WGdJWWd4ajNOV0drZGt5cHJncW5RR000Vm4zRXBJZ3NxS0JiVUJvbWpUNXBD?=
 =?utf-8?B?RGphYWZ3SnFwN25KOE1wTkl2a3ZBelJ5elpxTUwzaXVHTW5aSFV4MGI4bGhY?=
 =?utf-8?B?WDlhMXdneDgyK0VFLzlLaCs3YmxqNlZEK1c2enZmYmg3Tlcvd29IclVVSE1R?=
 =?utf-8?B?aDFYVzVMSGE4UlNERTYyS3F5bTRDeS9Dc0dTRHhNRTRoMFRENGlkV1F0UDY1?=
 =?utf-8?B?NTE2cE1iZExicG1DNTFmSDJjVk90WTVnWGdtRWZ3UGJmTUd0eFFIWGlvS3li?=
 =?utf-8?B?WlVYcTg4Uk5MMUY3MG9jZExET3RXZjIydkhtME1vNk1XY1RkWStPa003L2FF?=
 =?utf-8?B?dG80REw2UEJGUG5zUmUyR2xUZjlBT25KRUpEcStTNUthcGRHcURBbi9Sc0gy?=
 =?utf-8?B?UWVpOXAvQlJyRkhRd0ZDWWlvNVhjYUFjRlFIOFNIdmNBMlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpWQ21xdFFuVk9SK29Zd1ZyQ21nN0NKazVLU0tPbUN3Sk5FSlJacnhLSnFi?=
 =?utf-8?B?YmovRTFEdXlUWjFlZWl4OUxKaUI3ZWNLZEJkVGVtSHoweDh3T3hhVmtYN0Q4?=
 =?utf-8?B?Y0FUOThpbG8zdXIvL2hwQWFyb3ZxVU9sL0tYMTNzU0I2VzFFRzZHM3FNWE02?=
 =?utf-8?B?NGw0Yy9VZDJwSFJ5TTdocHE0UnVlTnJrQUl0TmVvTW5TWjE0Unl5VFgxaXpS?=
 =?utf-8?B?QXgvamxEYnphczZHK1pWNjFVaXMxTk50dGNmaUxhaUk3b3o4UzVCc0FTeHh6?=
 =?utf-8?B?UGlabXFDTVJZTXl1M1cycThtYkc5QVIwaUdpcWNaOCtZeTIwKy9iZVhKaldk?=
 =?utf-8?B?QlFoZDVmaTJkR3dxZVp3RUlLa2k0WHdSa1R1QlUxN3E1K2xUMjFCVkJLVm5m?=
 =?utf-8?B?d1JkZlpEVVlNM3pmTW11YkFwejByMmRkaHRyNWhyRklEMDB4YlZ3RlpXem43?=
 =?utf-8?B?V0NpM3VaK0ZtOWdGMjRuUjFJanNLeC8ra01hd1RkamoyNSt0WFFtUS9VRDh2?=
 =?utf-8?B?YkxKYk52R2hnSUtGd1k4dFN0c0JiYU5jK3E3WE1MWng2SVgwVkl1WTBnM2tm?=
 =?utf-8?B?VDh1c09aL0VmalRwL1EyYnNoN0dxVnE1UUxnbGRwSG9pZDhLQ2o1a2lrTkJr?=
 =?utf-8?B?MUNMRVo1RFN3aDk0SitzcVBLRlNZN2g2WTNSQUFUeWN0THRoSFBNbGo1OE5j?=
 =?utf-8?B?MWo0ZWE2SmtlOFp3Zlk3Qm9sZk5WbllYdUFGVFRPdm5mYjVBc3h4dE9lLy84?=
 =?utf-8?B?UXh4MnJsSlcwRkRXNmVpSTNST1MwVDQ5MXg5TjJDU0U3MmE4b3pRczdNNTBu?=
 =?utf-8?B?cGtRa0VXcStMRStyWkZRWUJST1EranVQRFQ3blFCUWZMd0RkNmRXU1VtMm1O?=
 =?utf-8?B?bHpjTmpSU2NuSXA3MFcyMnIyUWlmN016ZlJQd1BqeWhhallucE9ROGo2S2xT?=
 =?utf-8?B?Q3p2RUxvZk5ueitZS0p6TGJ6NXFwZVFxRU96cnlwaldrVmpjSldWMWhMN0VJ?=
 =?utf-8?B?bE9Wek9ZQzNCeVVYZm1tRW00eGZKNm1RWTVsK2UvNWxNZ3ZTSC95ZjhjSm9Q?=
 =?utf-8?B?WkQwS0V3OHVBMXljZWVOWXhTL1BnK1RyWjNkenpuZ2J2K0lTODdjMzl6T09P?=
 =?utf-8?B?Y25GdWRGTWwvaVhUNWZLMjZheTNDTENwd1VzSjYvQ0ovL2JJcWkrcVBLZWhh?=
 =?utf-8?B?amhvRWc3TzU0ek54N3NHVVlyT2JCbXpyQUtRT1B6N0R2dW1QMkJpQVBOUktE?=
 =?utf-8?B?NDArS21iTzZOejdVSk1IcG0wR2R4RkpNMmZWMk9ZKzl0VkdrTytIb2FZSzJH?=
 =?utf-8?B?YnNOK2kza2w3aXRPT2pZT0hYazVYTDdQTkN6SWJjVlZ3dVl2d2VGN3RCY1lQ?=
 =?utf-8?B?MDJteVV5UHJneEsvMWh6WmFvRFY3emlnWDM1TUIwUHZVQXlYenlBbGNyZzdl?=
 =?utf-8?B?d3Zla2lKeGt2ZHhQQ0VNOFc0WVdxUzVvcGx0ejlZSVhaMTZZMkd4TjBKQkVQ?=
 =?utf-8?B?LzdKTVJrRWhIWmt4TTJOZGZPQjdTam9kcXdmNnYyb3Q0VFphYXZNYVJ4RDdq?=
 =?utf-8?B?MHdZMWZQSmdwcERNbWlCbEl0WktVQ201VEVoSm9rU09iVE9scGplM0IxM0Yz?=
 =?utf-8?B?TDJna1VmVDM1SU5wejBneUFSVTZ2WThwWE04ajZMSzhkSnpON3B2cHlSNTJj?=
 =?utf-8?B?bDBzSWtvQ0FNUzhCcFdBMVVIOWNwenVmdE1udVJpcTB3TzFZajlmakZmRnpI?=
 =?utf-8?B?cEFaQ1hCMFpBSE1hTTZSWDltdUtqR0VMdzdrTjJ3V01XMDdlVGI3K0s5djAv?=
 =?utf-8?B?TjE2L1VFKzN2dFJURWErRFI5Zk9UQmhvTVNBdUhjVDU5SlFCS0syTFUyK3hy?=
 =?utf-8?B?UU02R1VkY2Y4VjRCZExJTTFGQ0k0RFNhSmJwOVVZQ1dFWGNYQ0FKZlluWVFW?=
 =?utf-8?B?Wnl5UXE3ZDYwc2JBL1o4N2dUNExFSERIbWo0bXVvWnVyLzROYkhpOGRIWi85?=
 =?utf-8?B?Tnh0UDcxRHBwVWI4WGtXQ2hXd3NzM0d0aE0yWWNCOFVCYnNtcERKNEU3MWto?=
 =?utf-8?B?a2dpbU9EaW91a2Q2R1RWUWVJWTVpSy8rSHZWNXhodU13SzlhUm9XK2xBSzV3?=
 =?utf-8?B?blJLNElWMUxmTFJ6bFZwN0Y0dGVRRWMxZDhHNGZxeFRGVjljSG04eVJOd0g5?=
 =?utf-8?Q?FIo38rzP8QU9sVHd9N5nmFU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91152F76D08C6843BEFE29678C868F32@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c20396-f605-40c7-1dbb-08dcb7bb56d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 15:04:02.3019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71uz9g4qEGZCHX64BzaG5YMgPCU98amq1mkqSNmQy93X/KQ7oOqthD41LdVQ1fzH+AYT5eMbewtmg+X4DSbUiXXUTE6AdfMmsBkIBENK2TjmZ/RuFGtqR08xY/HEH5oH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7691
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA4LzA4LzIwMjQgMTQ6MzEsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCANCj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDgvNi8yMDI0IDI6MzUg
UE0sIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+DQo+PiBPbiAwNS8wOC8yMDI0IDA4
OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4g
RG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIA0KPj4+IHVubGVzcyB0aGlz
IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IA0KPj4+IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+IEFkZCBhbiBuZXcgZWxlbWVudCBzY2FsYWJs
ZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrIHNjYWxhYmxlDQo+Pj4gbW9kZXJuIG1v
ZGUsIHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUgcHJvcGVy
dHkNCj4+PiBmaW5hbGx5Lg0KPj4+DQo+Pj4gRm9yIG5vdywgaXQncyBvbmx5IGEgcGxhY2VoaG9s
ZGVyIGFuZCB1c2VkIGZvciBhZGRyZXNzIHdpZHRoDQo+Pj4gY29tcGF0aWJpbGl0eSBjaGVjayBh
bmQgYmxvY2sgaG9zdCBkZXZpY2UgcGFzc3Rocm91Z2ggdW50aWwgbmVzdGluZw0KPj4+IGlzIHN1
cHBvcnRlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqDCoCBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aCB8wqAgMSArDQo+Pj4gwqDCoCBody9pMzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKg
IHwgMTIgKysrKysrKysrLS0tDQo+Pj4gwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmggDQo+Pj4gYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0K
Pj4+IGluZGV4IDFlYjA1YzI5ZmMuLjc4OGVkNDI0NzcgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPj4+IEBAIC0yNjIsNiArMjYyLDcgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7
DQo+Pj4NCj4+PiDCoMKgwqDCoMKgwqAgYm9vbCBjYWNoaW5nX21vZGU7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogUk8gLSBpcyBjYXAgQ00gZW5hYmxlZD8gKi8NCj4+PiDCoMKgwqDCoMKg
wqAgYm9vbCBzY2FsYWJsZV9tb2RlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSTyAtIGlz
IFNjYWxhYmxlIE1vZGUgDQo+Pj4gc3VwcG9ydGVkPyAqLw0KPj4+ICvCoMKgwqAgYm9vbCBzY2Fs
YWJsZV9tb2Rlcm47wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUk8gLSBpcyBtb2Rlcm4gU00gc3Vw
cG9ydGVkPyAqLw0KPj4+IMKgwqDCoMKgwqDCoCBib29sIHNub29wX2NvbnRyb2w7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIFJPIC0gaXMgU05QIGZpbGVkIA0KPj4+IHN1cHBvcnRlZD8gKi8N
Cj4+Pg0KPj4+IMKgwqDCoMKgwqDCoCBkbWFfYWRkcl90IHJvb3Q7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIEN1cnJlbnQgcm9vdCB0YWJsZSBwb2ludGVyICovDQo+Pj4gZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+
IGluZGV4IGUzNDY1ZmMyN2QuLmMxMzgyYTU2NTEgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gQEAgLTM4
NzIsNyArMzg3MiwxMyBAQCBzdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3Rh
dGUgDQo+Pj4gKnMsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4+IC3CoMKgwqAg
cmV0dXJuIHRydWU7DQo+Pj4gK8KgwqDCoCBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+
ICvCoMKgwqDCoMKgwqDCoCAvKiBBbGwgY2hlY2tzIHJlcXVlc3RlZCBieSBWVEQgbm9uLW1vZGVy
biBtb2RlIHBhc3MgKi8NCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4gK8Kg
wqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiaG9zdCBkZXZpY2Ug
aXMgdW5zdXBwb3J0ZWQgaW4gc2NhbGFibGUgbW9kZXJuIA0KPj4+IG1vZGUgeWV0Iik7DQo+Pj4g
K8KgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4gwqDCoCB9DQo+Pj4NCj4+PiDCoMKgIHN0YXRpYyBi
b29sIHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCAN
Cj4+PiBpbnQgZGV2Zm4sDQo+Pj4gQEAgLTQyNjIsOSArNDI2OCw5IEBAIHN0YXRpYyBib29sIHZ0
ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSANCj4+PiAqcywgRXJyb3IgKiplcnJwKQ0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+Pj4g
LcKgwqDCoCAvKiBDdXJyZW50bHkgb25seSBhZGRyZXNzIHdpZHRocyBzdXBwb3J0ZWQgYXJlIDM5
IGFuZCA0OCBiaXRzICovDQo+Pj4gwqDCoMKgwqDCoMKgIGlmICgocy0+YXdfYml0cyAhPSBWVERf
SE9TVF9BV18zOUJJVCkgJiYNCj4+PiAtwqDCoMKgwqDCoMKgwqAgKHMtPmF3X2JpdHMgIT0gVlRE
X0hPU1RfQVdfNDhCSVQpKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIChzLT5hd19iaXRzICE9IFZU
RF9IT1NUX0FXXzQ4QklUKSAmJg0KPj4+ICvCoMKgwqDCoMKgwqDCoCAhcy0+c2NhbGFibGVfbW9k
ZXJuKSB7DQo+PiBXaHkgZG9lcyBzY2FsYWJsZV9tb2Rlcm4gYWxsb3cgdG8gdXNlIGEgdmFsdWUg
b3RoZXIgdGhhbiAzOSBvciA0OD8NCj4+IElzIGl0IHNhZmU/DQo+DQo+IFRoZSBjaGVjayBmb3Ig
c2NhbGFibGVfbW9kZXJuIGlzIGluIHBhdGNoMTQ6DQo+DQo+IGlmICgocy0+YXdfYml0cyAhPSBW
VERfSE9TVF9BV180OEJJVCkgJiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+DQo+IGVycm9yX3Nl
dGcoZXJycCwgIlN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCIsIA0KPiBWVERf
SE9TVF9BV180OEJJVCk7DQo+DQo+IHJldHVybiBmYWxzZTsNCj4NCj4gfQ0KPg0KPiBMZXQgbWUg
a25vdyBpZiB5b3UgcHJlZmVyIHRvIG1vdmUgaXQgaW4gdGhpcyBwYXRjaC4NClllcywgeW91IGFy
ZSByaWdodCwgaXQgd291bGQgYmUgYmV0dGVyIHRvIG1vdmUgdGhlIGNoZWNrIGhlcmUuDQoNCkJ1
dCBJIHRoaW5rIHRoZSBmaXJzdCBjaGVjayBzaG91bGQgYWxzbyBmYWlsIGV2ZW4gd2hlbiBzY2Fs
YWJsZV9tb2Rlcm4gDQppcyBlbmFibGVkIGJlY2F1c2UgdmFsdWVzIG90aGVyIHRoYW4gMzkgYW5k
IDQ4IGFyZSBub3Qgc3VwcG9ydGVkIGF0IGFsbCwgDQp3aGF0ZXZlciB0aGUgbW9kZS4NClRoZW4s
IHdlIHNob3VsZCBjaGVjayBpZiB0aGUgdmFsdWUgaXMgdmFsaWQgZm9yIHNjYWxhYmxlX21vZGVy
biBtb2RlLg0KDQpUaGFua3MNCiA+Y21kDQo+DQo+IFRoYW5rcw0KPg0KPiBaaGVuemhvbmcNCj4N
Cg==

