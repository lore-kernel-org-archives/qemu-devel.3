Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D5DC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVQC-0007wa-10; Fri, 24 May 2024 09:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVQ9-0007tn-Ug
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:22 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sAVQ7-0004gh-Q4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716559040; x=1748095040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5ADkeKEWp6sNnUQjI4XyN4OYgKTNh5Wvi06eJ6IsVsc=;
 b=YvHZ4bOOL7yBtaIdBmhVP0wKqaozOWDwDtRNAGq2cPomLo7leiTXHouy
 uV3TBFOlDJToVBHhS+iTdAtehB0wGFxphfqENXZWpBNUSmZIBtJZIQTkb
 fP4yzr7LHIKNPiQ237sFpjJac6fW1fyWSb/u+SLPgpqOmbRbVPCF8MvjE
 Ny4qqxCGxZkjXOtuLj5dHNWLQGAwdla043kHUwBkS+kUYjY3Qp/aFTnIa
 CEAZVfiMZl5vc/VJ72IvNDFPJh0SD7qMriA45RD6y0hC+Rdlw+5e+ZAPb
 CwhOLm9csvrxUm57tkM13EpFKx+NEJbjNOMZqEY2ABgVT2FK5sja8CLx0 A==;
X-IronPort-AV: E=Sophos;i="6.08,185,1712613600"; d="scan'208";a="13234381"
X-MGA-submission: =?us-ascii?q?MDFbcPW0vN048iuWn4rGdPOz1nhSdyMUNnRa9R?=
 =?us-ascii?q?J6EXclwDHDXUFqu7N8jJ2TJFT64cLJtGy6w9AnnCQ18TEsTdF+XhWXew?=
 =?us-ascii?q?hmf25hrN3h/XgUhUeUmoZCAg1eohcgIX8Nd8feDPyp4giuBkgZbME5G7?=
 =?us-ascii?q?P00zn0F/EgE0j6qvEMLXj99g=3D=3D?=
Received: from mail-he1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-HE1-obe.outbound.protection.outlook.com) ([104.47.13.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:57:16 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIC5Uy/RWNyrQvPGdjUOQ+PkX5cVIC1eCX1ThUT8MJRw9guHbfnN9O/jTFuzdeUgPsSH+rmVMzQ3hNjggXudOO6bUt2ezwxxqKG9yYrdN0PD+1mXHgCjDWtGl5MFjpfuylVTBqHU6qpTXiWas6tVrnQGZ4BtpC9rTe9ud9QqnqdJV85xhhrlvBtJ/hziauMYv73JW4GgH3uONbg0UcDvxJFN6eXJOUTo4GvcYig6fg28z520rKSpNwDkHA5em0QdHDDfW1LqQKhECd+i0TCs4XBqT8HDnR1dCCPu9s6jhEhuWpW4l4RN23NKiTera/J/8RrWyb3YsMArZ5DD3FKALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ADkeKEWp6sNnUQjI4XyN4OYgKTNh5Wvi06eJ6IsVsc=;
 b=Gmj74M5yEu7tCPWxCFYN1oJRLGtojxHkjhJLGu8mSXbTY7KSdphoQ4WKxlZdEzzesX+bJcnGo+1YnJ488I/bDp+HFxqIFPTpBE0FHLJOwbh5qA4Y8GcgYx+pZLPOGmOIYFPrTRYMJ6exSBaSTN1l3eyszibuvANid9+bFjSv3QgMTfaSsx36wpyi0oNOCvX7ASc4iNvcIRhTxwatson1z+yulvYclpc7HAg0uXfm7BluDz8pLFEDH948MOsvlUtO2PPOn7G/4z6dlMHivrUc+bMTeYkE0+cvYXtJ/HSoVOCUl9musIkM0ytxXAAWlU+okMEDypgb6hJHhOS8W12doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB9680.eurprd07.prod.outlook.com (2603:10a6:150:110::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:57:12 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:57:12 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
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
Subject: Re: [PATCH rfcv2 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Topic: [PATCH rfcv2 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Thread-Index: AQHarBD/bxWRrFpySESTXk4V+QEZ1LGmbFwA
Date: Fri, 24 May 2024 13:57:12 +0000
Message-ID: <086629c8-9d19-41d7-9f1a-d62a9ecb071e@eviden.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-10-zhenzhong.duan@intel.com>
In-Reply-To: <20240522062313.453317-10-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB9680:EE_
x-ms-office365-filtering-correlation-id: a19caed5-7d2f-4c10-7dc8-08dc7bf9698b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Nzh3Yk9HUkJyZElIWHBmb2gya2pGMjYyZmE5d1YxT1lBYzY4cGcwcXM3RFZK?=
 =?utf-8?B?azlsVjNtZExHMDQrdE9FNVpHblZNY1g0Mm5PUWhsWE9sNUl2bC83UUpWNkRZ?=
 =?utf-8?B?M1M4R0lHU0JFT3BuOFgyck1tdXBFOTIvSEk3YlRFWWJmZVloVlhodUZGNkNt?=
 =?utf-8?B?WW1jNmNVWEozcS9aNkRDRTJnVS9wamVzRm5LalhEVmR2UXBGU29Qajd3SDNR?=
 =?utf-8?B?U2hOYWphRFBEaVpQSTlRaGFGeUZuTkorWnN2NFNOTjgvYkh2SUxacFBHRnRj?=
 =?utf-8?B?azMzZFBIN0xXRkdkL0tKODZjNTV0bFpkenRMa0dscXBpYmw5VWxXdWp4bEsx?=
 =?utf-8?B?d2tPbjBYNXZTWklsK2UxSzlTRGQ5NWE1dlpYVHFsLzBucWx6NktXNVkvaGxO?=
 =?utf-8?B?bkIrbzJadEMrQWx0RVlCTk80QTloY3Y0cjgrdE9KZnlMd1RuRGI3Z3RWaTNP?=
 =?utf-8?B?QVkxWHI4d1p5c1UzUVczOVhUcGxiVStsM1dBR3l2ekM2VTNvUitEdXZueTV4?=
 =?utf-8?B?TDZqck4xdnU0RHM4azJOejZDR1dNYThtUDlIblVpZjl5RUZ2SFJBb2lQOElx?=
 =?utf-8?B?S0pMY2xuMVFGMG50Smk4RjArYmFGSk9wMTlQZTY3QkxNQTQzSHNSQlpGRHpN?=
 =?utf-8?B?RGVwNDU1aVNqUzJITjkwNXFHcVZPU2k2cW16M2k0Qis3S1NGOSt2SmNtWnc3?=
 =?utf-8?B?cWZVaWRMWlRPRllvbThvd0d1UEN3QkFKOXNYa3Uxcmx5T0IyTjU3Q014MjJo?=
 =?utf-8?B?Q0QwSXZsNTRpMUFzMWxmTlRHbkJDM1UyR3pFQjROYWxETU1UUHBxSkdtelZq?=
 =?utf-8?B?QksyNHZ2emxWNElKaVRoenM2MDdHOE5rY25ndVY2NnI3Yk8xSGwrYnhoRjBh?=
 =?utf-8?B?NEQ2MGNPMno0UG80Wi9Zd2pWTUNFc2FxekNKWEFaTUVSTTloaDBuRXhrNDNE?=
 =?utf-8?B?NGpvOTIvRmFoc3VSWUFzZDF6UE5KVm94NHFYQkZFY0lpMGVBODJKWUVqZDZJ?=
 =?utf-8?B?YmVXWUlNTWhOQWxnR1VSWGZUdjFRc0lBYkFuVGh3U2wvZjZaQitITU1RaEZh?=
 =?utf-8?B?eHBNTURoTXJOTDZDL2NSNDlWblFZN0t6Y082YVlycFE0UVJyRUdINlNEeU5P?=
 =?utf-8?B?bDJ5ZXEyQ3ZQeG8xRGtSaFp5Y3pGMlBBTmY3ZzBVOHdSbFl5YjYza2QxeStn?=
 =?utf-8?B?Rk4xOUE5OFJoZkZxTHQzNFYwQVVWQnFHcEZJdzU2d2dEc1ZSeW12cGk2SDU0?=
 =?utf-8?B?VXgxTTQzOWdabE9KbDZaTXcxZ3RtZnFBOXl0TTg2TEl5N2REVlNHVUVJMGhp?=
 =?utf-8?B?THBja1ZWMFNTNVkzOHFHV3NvMjJ4WkhYZWQ3TkUyQnBaTzYwdVJJZDloTHd2?=
 =?utf-8?B?UnBieUozZmpxVGxOMUV3aytiWndKUFlLUjBnaDVqQUdxdWd2QXg0R3AvSjNU?=
 =?utf-8?B?MnorbkZiaHA1VDJVdXVNVUZ3ZG90bjBHNkRvT0dwS3FXY1NSYVMvNmp4N0o5?=
 =?utf-8?B?U21aajdodDZZVnFaOENDZG5pTmEwcTQzVzJ6NXBIZ3RaTzZGYnRmMEVJQ0JL?=
 =?utf-8?B?cnFkTjRObE5mdzBYay9kU2lrNkpTeTBPd0dOa3U2a1NVL1MvMGVqTEZyL3d6?=
 =?utf-8?B?VzVtUUpqdEJpWmh1MEdSUHl6aWZ3QTA3dVpod0RrY1lOalZrYjBnbmJMUEQ2?=
 =?utf-8?B?SURLa2p2NmtFMUlEelB0YXZGbXJINHQ4cHZvK25vcWF2eEJ0S05rQkxuYkpD?=
 =?utf-8?B?Rmg0SjR1NDkzc0E3d1pRSGhIZ29IVnFsOWtTZ2dNVktIYzdJaFFCWmhUMnlC?=
 =?utf-8?B?QjU1akFTbnY1YXZpaWVSUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtLQlFwZEFDbFVWTi9jc0ZZK2YyMG1sek5iY0pHcUhpZkFUNDNSRmc2RVJ3?=
 =?utf-8?B?dHIvTGtxZnNKSHRvMDdMaENFeWhnUURHaU91R3lGK2EvZEE0elJqRWxuOExz?=
 =?utf-8?B?bGx2RHl5U0JvbVgraEVrcmhZN2JSWVppeENuNDRmeG9KZ3hLUWg2eXBCYWt1?=
 =?utf-8?B?Myt6UmZaKzRKSnc5ZVZ5T2haYmtLTURSdHdwRk1xU1J1bFZrenlMSXVianZm?=
 =?utf-8?B?TjNSTHlLSmxzMllNeGtRZmVkV1U3d0pYUEZGalIvK0V0d0RwWU05WUxKaTIw?=
 =?utf-8?B?dk1lamJrWlRJWmZwdkM3aEN3N05WQ3dObVFiTHN0QWFKSWQ2TXpiYW5BLzM5?=
 =?utf-8?B?YW9zdFVTc0p1SVdJTHV5V1RBQk9EaVFvaE5kOThqU2xLWjBFRkxGMlRCc2th?=
 =?utf-8?B?YVdrTUFVV0FNREdVUFRRMm1UVis3WkozSVZhUk1QSWp1V29USFVyVlhya0xJ?=
 =?utf-8?B?VnNGOE5vSWJvdmFRcmV1YWIxakwvRFNZT1ZiN2x6a1R5MWo0V0p3dUJFWm9Z?=
 =?utf-8?B?bzJjclNMTjFuMTJDdC9QRUFNVkFzOXd5RUc2ZXNjaW1hQUxUZGpoUXNLRWhY?=
 =?utf-8?B?aXgxRnArT241SGwrREFxdXRRa3FQZlJva0QyTHQwVkNYWkpSVFhONzNZRlhy?=
 =?utf-8?B?dGQrWVVpZ3p5TTc4aStXZ2ZPTUk5VjUvaVZnNEdlb1lVZTNrUDhORmNleVJ3?=
 =?utf-8?B?Z2RsR0FaMUluQzlWVnJ1S2wyTkpId1RPZlZleFphdXM2akQxTFNEN2s2TWlX?=
 =?utf-8?B?NUtiaE9zYXovWER0RGRJeEtpNlVMcFVDS05VNFk2cWdEQkVsK05DN1hBNE11?=
 =?utf-8?B?bmRsRWc3WjkxN0UyRERtWFhGcnVBR1Z2MlZIZVlGeThmRGVqK1A5LytGN3o0?=
 =?utf-8?B?VzA0dW00OUhoQTVmNUxFc2lOUnp0UUcraURWZlZuYUlMZDRNWXRaaFJUUzBz?=
 =?utf-8?B?S00yRkxKOWhybUZnNHhFeGZBWkhmM216cFVzLzBnMnNSMjI2aCtvZXNyU0l4?=
 =?utf-8?B?TlRBc09DclBGeEtGSHVDcS9jSHAwd0FKV3pYUlpzOVltSjBxc2hXYzBKemJj?=
 =?utf-8?B?c1hBbEJJRThhdkpBWWNFamUxdXJrVU5tT1pDa1QwOTlTL09FUGtDcmt2dGxn?=
 =?utf-8?B?VFJYSHlpZlZEZStwaE5hc1dhdkhGaTV3Qzg0clNIcTBGZkdjYmZKcGNreWox?=
 =?utf-8?B?TXBSVnVTT1ZqMzFhTGlFWFlOTjFSc3pXNTRyWkdLVUFiUUVMY25mZDFidDZF?=
 =?utf-8?B?T3VCeERYZ0R5V1p6UGJoYkVzeTR0Yy9MWS9VM2RTWGxDZ1ExcmljdFJ2T21q?=
 =?utf-8?B?ZkY4amlZcDM3UEdRTjN0Qy9YSmNjaVhTS0E3aXV2MkNtNCt0b3lvUmpVaGlu?=
 =?utf-8?B?SGhLOGlleWw1ck82c3VhUVV6YWdKR2N3cUN0UmJDVzdwRUp3ZjdUYWVSOU5B?=
 =?utf-8?B?b0pjK2pabW1GR1U3VXJxMUdkdTkzdHpndE8xcDBHbnhPQ3VFNmhLNzU2V2xQ?=
 =?utf-8?B?Zi9MSldFQllYVVdadGxWZlppNlRIb3FhZU0vUEVkTGJyNFBrNGxCdDJaemtj?=
 =?utf-8?B?azUwdjZYdjA5QXZXRkR4a1Q5WURXK0R3YzNGNDhybnpHSGZMdDBobWtHbzVt?=
 =?utf-8?B?Q1B2Ry9xbGdyRU5zKzFSdmNoQ3hqKzRDd1g1UTNJSDR3bzFoMUJhKzZSYW85?=
 =?utf-8?B?MTBudW1rNGtJZzllQVA4ODByVUZkQzBRYnFybXhEOCtiVkdreWV4YWtLTDAx?=
 =?utf-8?B?S2E1RkFseE1meXRMam1obEhqY1RrWklwTDJONzlqS01FQjhEdTdkaVNvMlRX?=
 =?utf-8?B?cmVveFY5SkY4Wk1kM21OdlBkUEZHdW41azduYVdUZ0N6TlB4ZC90cVNNZDQv?=
 =?utf-8?B?SmREYmdWd2ZRTm5hYVdaaEVjYnR4SERQTE5kRkd4bXlBT2piRkhiZUk0cFNM?=
 =?utf-8?B?N1pVbGFGWDNWN2tYT0FRWlBPU3lRQzhMdFI0K0hPdC9PeWs0cnRWdjlQRTlk?=
 =?utf-8?B?UFJQbGlIWU1PZVZnZ2R5bGZSdmxlUU5KQ2FEeUJuNnJsNnBNcTFVV0JRV3NT?=
 =?utf-8?B?em1vMkR3TVlaZXV1UTBvWWdJaXdXY2FFb1lobnhFUEltL3pVN1d4L2t4SEV2?=
 =?utf-8?B?Y1h1d1REckZiUkdHRWUyK1R2ajV4UzN4bW13aXoxY3FQUDllVEhZbXF3Rkt3?=
 =?utf-8?Q?RB2uOd16fsVH9W/cCqk55D4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6842B90B8B5138479D741A71C635F62F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19caed5-7d2f-4c10-7dc8-08dc7bf9698b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 13:57:12.7258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZ3WTSSxhORSZfkzVAuPkkLgAYgdGkCxKVjpUJoOeltUGOiphyo13voBTG75pl7uU533yq1A4Zvp5vvqY39zFLr8Cfy4mK8nE2n3luNPE+FPWh1t0ptx0ZIn6xfsWaRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9680
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

SGkgWmhlbnpob25nDQoNCk9uIDIyLzA1LzIwMjQgMDg6MjMsIFpoZW56aG9uZyBEdWFuIHdyb3Rl
Og0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIg
YW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEFjY29yZGluZyB0byBz
cGVjLCBQYWdlLVNlbGVjdGl2ZS13aXRoaW4tRG9tYWluIEludmFsaWRhdGlvbiAoMTFiKToNCj4N
Cj4gMS4gSU9UTEIgZW50cmllcyBjYWNoaW5nIHNlY29uZC1zdGFnZSBtYXBwaW5ncyAoUEdUVD0w
MTBiKSBvciBwYXNzLXRocm91Z2gNCj4gKFBHVFQ9MTAwYikgbWFwcGluZ3MgYXNzb2NpYXRlZCB3
aXRoIHRoZSBzcGVjaWZpZWQgZG9tYWluLWlkIGFuZCB0aGUNCj4gaW5wdXQtYWRkcmVzcyByYW5n
ZSBhcmUgaW52YWxpZGF0ZWQuDQo+IDIuIElPVExCIGVudHJpZXMgY2FjaGluZyBmaXJzdC1zdGFn
ZSAoUEdUVD0wMDFiKSBvciBuZXN0ZWQgKFBHVFQ9MDExYikNCj4gbWFwcGluZyBhc3NvY2lhdGVk
IHdpdGggc3BlY2lmaWVkIGRvbWFpbi1pZCBhcmUgaW52YWxpZGF0ZWQuDQo+DQo+IFNvIHBlciBz
cGVjIGRlZmluaXRpb24gdGhlIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1Eb21haW4gSW52YWxpZGF0
aW9uDQo+IG5lZWRzIHRvIGZsdXNoIGZpcnN0IHN0YWdlIGFuZCBuZXN0ZWQgY2FjaGVkIElPVExC
IGVudGllcyBhcyB3ZWxsLg0KPg0KPiBXZSBkb24ndCBzdXBwb3J0IG5lc3RlZCB5ZXQgYW5kIHBh
c3MtdGhyb3VnaCBtYXBwaW5nIGlzIG5ldmVyIGNhY2hlZCwNCj4gc28gd2hhdCBpbiBpb3RsYiBj
YWNoZSBhcmUgb25seSBmaXJzdC1zdGFnZSBhbmQgc2Vjb25kLXN0YWdlIG1hcHBpbmdzLg0KPg0K
PiBBZGQgYSB0YWcgcGd0dCBpbiBWVERJT1RMQkVudHJ5IHRvIG1hcmsgUEdUVCB0eXBlIG9mIHRo
ZSBtYXBwaW5nIGFuZA0KPiBpbnZhbGlkYXRlIGVudHJpZXMgYmFzZWQgb24gUEdUVCB0eXBlLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAxICsNCj4g
ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDIwICsrKysrKysrKysrKysrKysrLS0t
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRl
L2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBpbmRleCAwMTFmMzc0ODgzLi5iMGQ1YjVhNWJlIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiArKysgYi9pbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiBAQCAtMTU2LDYgKzE1Niw3IEBAIHN0cnVjdCBW
VERJT1RMQkVudHJ5IHsNCj4gICAgICAgdWludDY0X3QgcHRlOw0KPiAgICAgICB1aW50NjRfdCBt
YXNrOw0KPiAgICAgICB1aW50OF90IGFjY2Vzc19mbGFnczsNCj4gKyAgICB1aW50OF90IHBndHQ7
DQo+ICAgfTsNCj4NCj4gICAvKiBWVC1kIFNvdXJjZS1JRCBRdWFsaWZpZXIgdHlwZXMgKi8NCj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPiBpbmRleCAwODAxMTEyZTJlLi4wMDc4YmFkOWQ0IDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0yODcs
OSArMjg3LDIxIEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlfcGFnZShncG9p
bnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPiAgICAgICBWVERJT1RMQlBhZ2VJbnZJbmZvICpp
bmZvID0gKFZURElPVExCUGFnZUludkluZm8gKil1c2VyX2RhdGE7DQo+ICAgICAgIHVpbnQ2NF90
IGdmbiA9IChpbmZvLT5hZGRyID4+IFZURF9QQUdFX1NISUZUXzRLKSAmIGluZm8tPm1hc2s7DQo+
ICAgICAgIHVpbnQ2NF90IGdmbl90bGIgPSAoaW5mby0+YWRkciAmIGVudHJ5LT5tYXNrKSA+PiBW
VERfUEFHRV9TSElGVF80SzsNCj4gLSAgICByZXR1cm4gKGVudHJ5LT5kb21haW5faWQgPT0gaW5m
by0+ZG9tYWluX2lkKSAmJg0KPiAtICAgICAgICAgICAgKCgoZW50cnktPmdmbiAmIGluZm8tPm1h
c2spID09IGdmbikgfHwNCj4gLSAgICAgICAgICAgICAoZW50cnktPmdmbiA9PSBnZm5fdGxiKSk7
DQo+ICsNCj4gKyAgICBpZiAoZW50cnktPmRvbWFpbl9pZCAhPSBpbmZvLT5kb21haW5faWQpIHsN
Cj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiArICAgIC8qDQo+ICsg
ICAgICogQWNjb3JkaW5nIHRvIHNwZWMsIElPVExCIGVudHJpZXMgY2FjaGluZyBmaXJzdC1zdGFn
ZSAoUEdUVD0wMDFiKSBvcg0KPiArICAgICAqIG5lc3RlZCAoUEdUVD0wMTFiKSBtYXBwaW5nIGFz
c29jaWF0ZWQgd2l0aCBzcGVjaWZpZWQgZG9tYWluLWlkIGFyZQ0KPiArICAgICAqIGludmFsaWRh
dGVkLiBOZXN0ZWQgaXNuJ3Qgc3VwcG9ydGVkIHlldCwgc28gb25seSBuZWVkIHRvIGNoZWNrIDAw
MWIuDQo+ICsgICAgICovDQo+ICsgICAgaWYgKGVudHJ5LT5wZ3R0ID09IFZURF9TTV9QQVNJRF9F
TlRSWV9GTFQpIHsNCj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0KPiArDQo+ICsg
ICAgcmV0dXJuIChlbnRyeS0+Z2ZuICYgaW5mby0+bWFzaykgPT0gZ2ZuIHx8IGVudHJ5LT5nZm4g
PT0gZ2ZuX3RsYjsNCj4gICB9DQo+DQo+ICAgLyogUmVzZXQgYWxsIHRoZSBnZW4gb2YgVlREQWRk
cmVzc1NwYWNlIHRvIHplcm8gYW5kIHNldCB0aGUgZ2VuIG9mDQo+IEBAIC0zODIsNiArMzk0LDgg
QEAgc3RhdGljIHZvaWQgdnRkX3VwZGF0ZV9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQx
Nl90IHNvdXJjZV9pZCwNCj4gICAgICAgZW50cnktPmFjY2Vzc19mbGFncyA9IGFjY2Vzc19mbGFn
czsNCj4gICAgICAgZW50cnktPm1hc2sgPSB2dGRfc2xwdF9sZXZlbF9wYWdlX21hc2sobGV2ZWwp
Ow0KPiAgICAgICBlbnRyeS0+cGFzaWQgPSBwYXNpZDsNCj4gKyAgICBlbnRyeS0+cGd0dCA9IHMt
PnNjYWxhYmxlX21vZGVybiA/IFZURF9TTV9QQVNJRF9FTlRSWV9GTFQNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ7DQpXaGF0
IGFib3V0IHBhc3NpbmcgcGd0dCBhcyBhIHBhcmFtZXRlciBzbyB0aGF0IHRoZSB0cmFuc2xhdGlv
biB0eXBlIA0KZGV0ZWN0aW9uIGlzIGRvbmUgb25seSBvbmNlIChpbiB2dGRfZG9faW9tbXVfdHJh
bnNsYXRlKT8NCj4NCj4gICAgICAga2V5LT5nZm4gPSBnZm47DQo+ICAgICAgIGtleS0+c2lkID0g
c291cmNlX2lkOw0KPiAtLQ0KPiAyLjM0LjENCj4NCiNjbWQ=

