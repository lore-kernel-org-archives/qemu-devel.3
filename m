Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2575FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRf-00081U-Bi; Tue, 02 Jul 2024 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRd-0007zq-FY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:49 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRb-0006Ul-Dj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899567; x=1751435567;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iQZ8LUYTZUklKaeRuFrltuVPELET5rAe9WchMbRYKbc=;
 b=p30yJ1oOxoyX7O3IUUQLY3MrQR/J+FJ82CtmkzR+mRP4IGkSYc59kLTD
 M02C4YkTpwjlXSoTn3OJ/OI5t/oKKXySRESpLthN5KlL5h8mQii5IjFwR
 f49ViQF+9mz9YocsSCK/bfqfyo2va/3F45STRUzjjbeeQ8iMnAZBMWfLA
 EdCGiS2fNdnE/JXErqcZ9xdmayuKE4YBz5DL3jKpFdezd5TEj+Gi3paNr
 WL0poavZLL3r6r482xuPskrbxs7DIYZ3kSlNqOl9n1JTB+c79pHX8sn42
 +a7EgElHvs08W7bQXfWFMbHyqO/K6lVvrYPA9MdgLjvdn0VBvpMKVeFz7 Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15813268"
X-MGA-submission: =?us-ascii?q?MDFw91toBX7UOyo149xQV8DoBLZdIXyMn2rKy3?=
 =?us-ascii?q?NVwESrMKn9UjGlA6xYP3YYrwVQKErlMKIrFtxLuv5JB42pJ5ukAJ47Ym?=
 =?us-ascii?q?Erl4h+tE7Jf36tc6o4SJzcU9s953N/+lh3w3YjbFDQzCvQV1NiJv7sqt?=
 =?us-ascii?q?Wb2vlUI8qHqKizuIUKMmPyKw=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKMGFd+sddORh9r7yOvN5bIP36I33pPm2ZrShhbEvNeS2zj1ubWTNi+oQppGFGaPb1JpkBhW2LNpXXCTa2DSsfEsmVZFojsj8MTxbpxB/dw6sXKI3M+ymYcFx5JIl+Iekle+ifUzh9o2U3YjVg9Wer3sVbJ6YLgbsceiA4mdU/b5GUM6ch+1g246FN/XVwsvA/5LXI/GtVLa//e3xVhweUnuTLQYlmXb9uBZHSklt8EnMVgEqHAP36750OQeIoYYGvu+Cmp3PM8l5LRCO54ueNdC9CjR2jJVFxQFaNeRUYUkel8B6eskKhooz1VloK8dF09spc+ee083g5dnGMOBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQZ8LUYTZUklKaeRuFrltuVPELET5rAe9WchMbRYKbc=;
 b=grVxYb5wNQX7vTLBvvA+aW86JqVZpk2AqL7aDjqjEi4lsFrTP8eQgztEoyJSJngaTRfCx2iUG+5X4A5gISKvSIFOats1pcNqoyGP6JDuSbmcjkgYp3yTOrWRyHn/53Xmc184w8eEeiWfn+ladtG3eWQ20Cnc1fvmoM1ggRoYUFxcoieFTQBTs3tcCA0LvmCtwloTuMaIl67vNvGmEq/jIJ2pQ8ypXr+zutg6hATMx/TGdtI25MUO8Q4iykkSlCplph4Gnre80pGQg9lCaYYJASq5WKpzZcRoJjENd8u+ZZi7/Nr83rC6DhmQSps6XCuFZgIgjKWqGnqtI2IsI5wJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQZ8LUYTZUklKaeRuFrltuVPELET5rAe9WchMbRYKbc=;
 b=jBaKtcaaFpzETPEW5rGWGTujnHKhlxdrEvcEc9KSC6A/AAqvA8pNLQwQgmmv3reK2ICnwmTH0S/+nuDmHHpBTrsWNR+S3VI3uPD1yHNBLVxjomXUk3HZfY+MKC2Hsb7BP6ymvZJLuY+qbbspyM70izkjGt00FKkUr24WzWDlNvr+LONdFYaQsG45JwHzJlhWEyemzOS38VfWxenIQq7Yr3FOCUBzhA9w/fUXfWF5zNL78pL6FoHwMnjd/E/zNo1CeH/H+oKvUcewxMKgG7lnsXhipMEv4R6/Dc6VzFgIDGgqmU8eVeoJUnAM1bFctQAYbvl9OttCw+i2UYOivvuChg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v5 14/22] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHazEQNLMlXcNcNXEOjFPH7XeKvtA==
Date: Tue, 2 Jul 2024 05:52:41 +0000
Message-ID: <20240702055221.1337035-15-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 70656887-d168-4284-65b5-08dc9a5b2f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzN6aGFjcStEY01sV3dXdmlqQjFiN1N5VDFvQy83bUJPVFZmcnNSNEIvS0lK?=
 =?utf-8?B?ZlZLUHlNMGc5QlFkWDYxeHJWQm1UNzBBdHhzQnhsRnA0Y1BvSHhWemk2bnYw?=
 =?utf-8?B?R0xEZFpEdkZKRXEvRExYdkpXdmJVTkp4NzQyRXV4aGtzZmgwUmZWOEtjK09B?=
 =?utf-8?B?WEErVHVHUDVjK1U3NmJWMCt6VUxUZFZnbVlDd3ZhbWNIejVoSytqbTFUdk1Z?=
 =?utf-8?B?V2NMTFEyMWJWbC9aWlZJK1BiNmdNN21pUHVVdmRkelViZkFyei9HSXVtOCta?=
 =?utf-8?B?YWc1czJzZjVqZzFKUXVMM29lYlZUMTN0WExKbGcyQVZOMnRJZmNEQzdmYTJl?=
 =?utf-8?B?c3I1S2tSY2RsbjdwVGdSY1l1V0JYNDJsUUhaU05ia2pJNDkzM09DUzBhTjBr?=
 =?utf-8?B?VzRUaG41RjR6KzYwcmp0akhPeTlQK2FWZXcwWW9OdDlGZmhCTkllY3hwZzNX?=
 =?utf-8?B?MHdhQnh4YlByMmtZOE9XMHp1NnVZVGtCK0ZMeFRnU0phOE5FRTl5WkRMRjAr?=
 =?utf-8?B?SUtEbDVHZzlHL2N0ZEtiOVJNdS8veHlrUTRlNlFaTVFCMjVCMGJGcnVGZ1lm?=
 =?utf-8?B?cGNMdFZqOGNaczJHVjBQSGI2M1l3eGY5R1hxZkcvVlpJSDc0YmExSkpJSk9O?=
 =?utf-8?B?cTA1aFpENHZpWit6UUlGM3VNNFZGT0xzMVNWOG9iS2VxU1drZDErUER1ODBW?=
 =?utf-8?B?Snltdm92eE1oZTBWbStoSmxYZ1Vhbmo0NUtYOXpudURXb0Z6ZUNIRnlPS2l3?=
 =?utf-8?B?RFVyRnN6NmlXVmV4NVh2YjhkR2YxWjlmaUI0YjFqKyt1VHRNWWJISStZUWlz?=
 =?utf-8?B?Ujc5QTdBbEVZdDRsTEIwaGFsczU5aTlZZGw3Ykw0Z2x0L1Myc1FlT280Z1VL?=
 =?utf-8?B?dm9QZlNvTUlEdVZLTG5BeWJhUjdWeng4ZlBuMkV5UWsySDdrOFFPNG0rTUNk?=
 =?utf-8?B?SkJiT1RnRGZmYkx3SlRTQmMzdk5yVHZVZFVjTDc0Z242eWNEcjBNNFE4bktn?=
 =?utf-8?B?czVkditHcW5yT1dHT3MvNU0xNzNqOG5BTGZwSXFKY3graEp4V1hQUUQweVgr?=
 =?utf-8?B?K0R0cytQMytOZnhtdU5rdGpaVHNmeWl2cTdGd2ZTNitrMFZkOU95TVczb0ZO?=
 =?utf-8?B?WEk0TkdwU0V4aGQ1S3ZTSVhaMGRLN0ZNSXljdFlOVno5RUlWNGlKMVdyU2FJ?=
 =?utf-8?B?TzErZDhFbkdVQS9tcG4wR2hGK3QxQ0QxZ3hYU1Y5aGk0OTRiNEVkZ1ZIV0c0?=
 =?utf-8?B?dTRFbDZJRHNtL1hXeEV3R1RUYXdwMXJjN3RCQnE3em55a0VjM3FyOTdQMnRL?=
 =?utf-8?B?eUdESHNMTm9UbmlMRWFyMElZdEd3U3JYMHpiRkYvc3hVY2krK3REZkJ0NjFa?=
 =?utf-8?B?S3ByYi9ybEdTQkFnNXlnWk12dHB6NlhHTFhWYWtQejNoaXFtMXhsYjJ2S0lt?=
 =?utf-8?B?dGI4MDNkclFjZStMbmlFMkwvZVpEVENPVFY5S09sVUhIRDlXb3FnckxxVVVo?=
 =?utf-8?B?dTRodVYrbjN4OG1WYmRkUGJTbGdKM1psdmdVU2xHdHR3QnVLclpRZGtWZG5B?=
 =?utf-8?B?bXBxc2l6TnJwVTY5NlpsNVFMWHhvZ0EzUmt3cTdETXJXNTNiQ0dqbDNzays4?=
 =?utf-8?B?OWlGOGlJN3p1cTZmN3dwSWNsSExzMXc3TmwvOG1ZbGEreVVoWTIyZTFWYkhs?=
 =?utf-8?B?VVdPSGkwZjJINFBNOS8xLzBpeEpoQXBDeHo5a05XNklNRFpxb1liWjQybW5y?=
 =?utf-8?B?UXF6NTk5c0FjSlNxaXh4TWJkc21NTVdUSDlFRkRWNHk0eDd1Q3g4VWR0QzhB?=
 =?utf-8?B?N3o4MnFiUDBmOHAra0dzamxxSEYwdEs1SDMrVEo3aVBGajVMRXlmZzg3TjVP?=
 =?utf-8?B?TG1Kbmk4MzhRWTZMa2IrZCs0KzJpdWYrTXQ0cHdLVHMvTXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUkzcDBzdmZXVS9yQWZldFJyRzJFb09VUy80UUpxNVFZQkN1dzFmNDR4Wldy?=
 =?utf-8?B?VGFhL1d5ekQ4WDdvL29JVTZ4ckFsSXg0eCttbTMzWGZFVWExMTVZQUxTdEFT?=
 =?utf-8?B?ZXlibDBtamw4MXo1TnJUSjRoZUhMTGhJNlRnL1pwVXlVUjFoeWFWTklUTzI1?=
 =?utf-8?B?NVNpcGNiVXpDU2VHcFBjUWNUQ1Y4ZGlTMGlJRUNQZTVySDllODUydncyYXc3?=
 =?utf-8?B?cGYvK3BaQzJ6NjJta1BybG93S3lydmVYNUV2cjdjV2E1OHdJczVDMHM0RWhs?=
 =?utf-8?B?aHlEUVV4NTRqNzZHbHdzMnZ3bXFwbldIWDZqY0h2cXBjQXdTMWRrRjd3TC81?=
 =?utf-8?B?K3JjVGJuclgvNGYrWW9pY2F0aFhyOHVsa21JN3NGekgrWUJTMXExMU9wS3hw?=
 =?utf-8?B?MmNWR1pFYk5SZUEvdWo1SXFhQmthL1ozQ3NkT2RTOSthWE5ZbU5xMU5xMFFS?=
 =?utf-8?B?bnpVR245MnFJenJwa1lTREJJT3J3cy8rMHhBajFkdER4MGFXcGdmbVRBa0Rm?=
 =?utf-8?B?RGkwaE5GU2xyN1FZZmJaRVUyRUFwNlZkODM3RFVhYzgzS3RPeEh4bzMyVkJT?=
 =?utf-8?B?WG9QWEF3NWFhZHZwRnlJSlRwc2NOeFp1aDVEaDdLNXh6RXBZS0RJNndyWUpX?=
 =?utf-8?B?TTN1MTFsR2dZdXN0VmdlY2ZnajlCNWxUVlcxSnJWMnF5QTJYaWN4WEszcWgv?=
 =?utf-8?B?NHJ0c3I3V1Q5WGtSaERVOVNSVXVVSXprRzYrZm9MQWd6Q2RSMzRiUTJKUVlo?=
 =?utf-8?B?T250MGg3aG1LY0ltVVNnN0paNXRLZEx2cjJ3ZGZrRkFXSE9oZmZCSFZQNUx1?=
 =?utf-8?B?OHQ4STJTK0t3YTcwYWVqK3hjZVNsblQ3dzl2SmxsTXRuTHNQcEw3SUI1SVZJ?=
 =?utf-8?B?SXlJaTljSlp5T1BJNGdwVTBNaUtKMGRIb3BsOVdTbEhXK2FzZUgxWlNmS3dR?=
 =?utf-8?B?aUxnMExkM1drZTVMQkVoTTRtbmVuODN6TkdlaDRZNTdrMXVpaXk5Q0MyTzMv?=
 =?utf-8?B?cGNwUkQvZDI0clNWZ0xyTzZ5WURJaDZEbEYzTWk5eFljYXJ2dnExbDg3ZGJv?=
 =?utf-8?B?ZmMybWR0bTJkaTduTm94T25VLzFvTnZyditTd0I4cGlwM1NLekNTb3I0OVlr?=
 =?utf-8?B?b1NQUEZlL3FLelZyd0lxQzQrREN3TnNwVHU4YnpjbC9ZUW9waE5IUmpRdlgr?=
 =?utf-8?B?WG4yWmNZemxkZzZRdDlBUXIwcDJxTGxzOS9BcGNqLzAwa1F4UHdXNG5kYmhX?=
 =?utf-8?B?cEpsRzliZVlLeWl4VThsTmNzRGlsTEIwWC9pMkRhZDZ2WktzVWw2UStyajhj?=
 =?utf-8?B?bWg3UG5LSW9QT1pwOS9pV1Fqckpibkx6elB5Mys2NXh4ME9GTmZ2U0ZaeCt0?=
 =?utf-8?B?bktXVWJVdDNPalNBZERpUTQ4TTVjTnNsVmJqOFRiYU9CQkJVSmR4Mk5rTVRa?=
 =?utf-8?B?dWxZT051Y3pHRDZuN3ErOGMzUURsRXNyQVhoNWlUR201TUZaa2M1ZzE0SG83?=
 =?utf-8?B?dGNPbFlPOHdSR1p0dGxobmxncmdNYzlWa2xEZE9MR0w0VXhJcVBmM1RndUtJ?=
 =?utf-8?B?dkVjMWh2Q3d5WVBPKzI5RlN5cmtoUXpsQndwOHIwN2VvWmVlZ1JlQVdOWGdH?=
 =?utf-8?B?dlZ5S1RqZlFuakJZNk0zOFhyWmpQZ204TktjZGNrYUxIVXQ4SzlaaUJiSGxp?=
 =?utf-8?B?RDdaYUU0a084TndQNWtwSWcxUUdCUlJBdFhUbHZISUlhM2JENnFtbGcweGdS?=
 =?utf-8?B?K3JCV0wwa1BQT2RxZTY0eFM2MjdTRFR2SHJ3QU54ZGlTVUJVSVF4V25EN2FV?=
 =?utf-8?B?OFYyYisrNExQMERrZXBVY09zZnQ5ZXorWGl1T1doc2dCa2dUeDh2Ty92VVJI?=
 =?utf-8?B?cnlZcHAwc1NCZ0xTbGhOckc5ZVk3ZmpLZFBrQWE1Q0Zva00yN0plcUM1NGx1?=
 =?utf-8?B?QTdTWjVOazlWVk9jbFdlU3RoeUNISW9lNXlBMUVkV21tWldFaGxmTkgwanlh?=
 =?utf-8?B?TlkwSURWSnB5eHVyREtQc2JTajZ2V09LY3dTUHFxYXlEcTJ4NlhPVlZTblFh?=
 =?utf-8?B?WFc1ZmpXdjNVOUxHNTA4djlqblU2UWVVakMvejcxNW9JOGIyL2N3ZXZFdGVm?=
 =?utf-8?B?RWNrT1lqRGNjOE1vc2RnKzEzVVExL0o4KzdnU3VYZjZVNGFDZkN6OUE4ZDlq?=
 =?utf-8?Q?68VPuYtvUiTvkE+LkNeY+kE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <166F1D4FA61437468282F07BE24DE5C8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70656887-d168-4284-65b5-08dc9a5b2f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:41.0137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+HgNqCYUAXD/5XPXwF0mHIvQc4ruiYpSnP7cjNcbmE2Z6B79dPk5W0sQ8HDDoT+tB6b4WdKJ/mYV8+BnP2LluXuXERoP8uwYj56bdV3uvu682eN1IK2rZJzNX0i/Ym7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
MTUgKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KaW5kZXggZTA0N2QyY2E4My4uMmU0ZjUzNWRkMSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNjAxMiw5ICs2MDEy
LDI0IEBAIHN0YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21tdShQQ0lCdXMgKmJ1
cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4pDQogICAgIHJldHVybiB2dGRfaG9zdF9kbWFfaW9t
bXVfcGFzaWQoYnVzLCBvcGFxdWUsIGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KIH0NCiANCitzdGF0
aWMgSU9NTVVNZW1vcnlSZWdpb24gKnZ0ZF9nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZChQQ0lCdXMg
KmJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50IGRldmZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KK3sNCisgICAgSW50
ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsN
CisNCisgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5fTUFYKTsNCisN
CisgICAgdnRkX2FzID0gdnRkX2ZpbmRfYWRkX2FzKHMsIGJ1cywgZGV2Zm4sIHBhc2lkKTsNCisg
ICAgcmV0dXJuICZ2dGRfYXMtPmlvbW11Ow0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMgdnRk
X2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lv
bW11LA0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9tbXVf
cGFzaWQsDQorICAgIC5nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCA9IHZ0ZF9nZXRfbWVtb3J5X3Jl
Z2lvbl9wYXNpZCwNCiAgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9k
ZXZpY2UsDQogICAgIC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vuc2V0X2lvbW11X2Rl
dmljZSwNCiB9Ow0KLS0gDQoyLjQ1LjI=

