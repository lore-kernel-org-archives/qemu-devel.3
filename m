Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A9CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ExC-0008KI-A5; Mon, 13 Oct 2025 05:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Ex6-0008Ji-51
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:34:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Eww-00062I-T6
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:34:46 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59CNH7fO536151; Mon, 13 Oct 2025 02:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VQ4TShD70+EGQMcjyt4NTw1DAF4oTo0Yw5tvdKssR
 pg=; b=SW8Xnxcg94gSs5WHET5BtwECAQesxvRQ+WMoZvbjCbAdkhtaFBr1Bjc8r
 3vPxAt5dNwcpWjuX3b496hinDT2IiRhtcXXqJCito9Bh+xsMtG0L85jGBqvfmPvu
 0Cnj95h5BPkq2jaKlFToqQVKEKmsqrSuQnpgZFIM/roGtayvs4eOtuc2X5829ck8
 CP3NIsarb8AERjbPfAPukmJ6VWk03FfR3R5MOelP6qxIfJ8EF8pVx/xtWCMQcP9c
 ohezQfYINqqsaQBRkmDfbC5hr7yMYT9wlY6CAVhur0StprEe4KHcMa6V0GRgU0OZ
 XkZiyZa6Od4B5NBtpGgE6E5N8frBA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022081.outbound.protection.outlook.com [52.101.53.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49qpj9atg2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 02:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EditfqIW43eBHtVg7GEyzhjTd5rE7BV4Oa8yCGMl7RjFxqMUFh/ehVcdKnjXMzEtVeANIRhqaM9DCxmhG9DF2OzsbB5UOrx0U3GIqqMTd3rzDV8+HPTJB+ZQLkBvQCxSfGTAevTWE1XuYk6SWf84h6JWNp1Ca/xcAmN9qH9/yXYCjgv21XE7YNMHHzqiguO1pX3L2An4rREfW8gTIItpjFQ38cWvPdZ7dUJBMbxn4PcKdltZK4X7ZfhxAAB2U7+oQDq5vKT/uwqAg448p/5TchZtDaHKZfSOWLlGAOCI7SThZo+8g7WKSQSaCReXGfTwFmRQPZw6eAXiAOcOVFh4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ4TShD70+EGQMcjyt4NTw1DAF4oTo0Yw5tvdKssRpg=;
 b=Hq9TlJ0IcR1Uu1DCV4t/kxZL8muy8Q8VJNhD6odLnqeMq1JsLo3OllXudZSuKthwE1Bd06f8R7eiNYdI1ZHN3+J0eSl3WGF5WK5cQDUjmaBry2gAnZpvEaMlnPFeNxE6K8QJDzMdlGq2bjkAnszL6KZv5TMsXODNFNtv5DMclgHvX+Nd3ibH9kimOIFHcT1JKyyDxk0jgJ+Tz6XdB4xOtQi91fj6Hia/nxG5r99WpFMHLBsNgGnbfE6bbJpYj1tG3/TaRXsQegOKxz2yoGSdKqxWbZra0ZuFN+f6LwRaRmfNFvNZe1mtRjnJ/BPMOUWdQjEJCxyyjRZZCgRk+/HNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ4TShD70+EGQMcjyt4NTw1DAF4oTo0Yw5tvdKssRpg=;
 b=OeLQ/T/gohVOgJUJLD7yb8v6aDvj2JCxABjEKBUhpfdOs6HDcqgJAlVr0dXHYLZn+ozVp0a4re7MKgpO/DRXZ/EDLsVjG6hCu3ngVD9wzCLKDM5l4iWriAxsi9KRcJaJhmIkUoUs5oQYZoQ+yHg6UkedokmT9dZsi0otZlaayp9am6Rw2vbsEAYQdBvk1UJZUtvMi73rFH4kuGpfq5U3A5pghwjHxSNV02A/UM/UryVrP5pAk6k5qkTDMCCZ9X/Iane+JaXR3PM8E/GXCrAVEjJD5zGYIdKdoo/rSpZaT2x8FJQl48xKyQ4m+Sq3ztEADodljmae0Grh8yVDRQsL/A==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by SA3PR02MB10066.namprd02.prod.outlook.com (2603:10b6:806:380::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 09:34:28 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 09:34:28 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: Manish Mishra <manish.mishra@nutanix.com>
Subject: Re: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Topic: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Index: AQHcPCLQIrO+EaLeX0uyMT4Fy7m+a7S/0NIA
Date: Mon, 13 Oct 2025 09:34:28 +0000
Message-ID: <F57AE00C-0B92-4F4F-818B-5CB794CBC11A@nutanix.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
 <20251013092126.3480671-3-tejus.gk@nutanix.com>
In-Reply-To: <20251013092126.3480671-3-tejus.gk@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|SA3PR02MB10066:EE_
x-ms-office365-filtering-correlation-id: 0d7c2314-bf47-4d36-c7ce-08de0a3bb4d4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dC9DSWg0REVNUGZXY25BRVNYRE5CRDFYZ2hOcmc1QVNqckp5VWJ3M2oyalMw?=
 =?utf-8?B?YWpJTVVnMk44Q2hSb3dGdDJwSE5zSU4wMFRiMDU0OW9NZDNxTHZwbEljejJ6?=
 =?utf-8?B?a3NuVUl2akx6UytVZkE2OHZmdjA5VTF6Vkg4RTFKYWhMZktPcFgvc041aWhH?=
 =?utf-8?B?QXlkR3VmdmFhcU1pdE12eUdIM2ZCSGs2emdXdDJvQXh2QTZoQTNqSFJpODBy?=
 =?utf-8?B?Y1dQVi82aUljWkN5YjJvckJNamtRc2JqVkg3MklYSnFsWnY1VHVKNWpibWVO?=
 =?utf-8?B?K2tFeUg4RXFwUHJXMFA0WU8wU3JwcDk1TkNBN1hab04zTzZHMm5POXJPaEZl?=
 =?utf-8?B?RWQ0eC9VTndBQzVoc3NmdzkrRnBJblEwRUN3UG9FL05NSlRFUzlqS1UxM1lH?=
 =?utf-8?B?bWRBQ0pxSmFFNWZRSk83elU0cEtCcmdsK3ZqMSs1YVNja2Z1blBwVlhjVDBk?=
 =?utf-8?B?REw4M1o0K3pTVSt1NTJQN0ZTQTkwcEo3QWh1T2FhVzFqY1ZuY1Rqc0VITVkr?=
 =?utf-8?B?SVZRT1dsTWZWQ08yaGxlMlhWY2pLZXhaV3lPVEg1VjZQc0lCWDRxZkx6WXUx?=
 =?utf-8?B?ZDRIdHZiNDZ4bk1uMVh6b3VpTE0vYlM5TXZ4OGpFZkF2RTREY1NtSENyMWRD?=
 =?utf-8?B?cExHWUp4S01pcWlrUFJFM1B0MzdqUDZDTGdmc0lQd1ZCUk96bE5TS3piVEVX?=
 =?utf-8?B?elJYYVZzeC9SdlYxT0xkVldTMDhoZWJTalNiejJ5TmZFMXJtMXl4Y3JWcXJI?=
 =?utf-8?B?VldKWHlDUkFKUVpxRHErc205SVhPZWhxOVRNS3NNcDFkbEYrVEpCMjI2SWIy?=
 =?utf-8?B?SGw4d29HMVJEbkxCRWxHYXVEakdnVjBiT1pyTmZZR3pGd0pZQVBpemp2K3Zw?=
 =?utf-8?B?NXBWKyt1eHYvV042WkxTeEhNeDBnVmswU1UrWUczWmVyMzd4S2RaRVg3T0Mz?=
 =?utf-8?B?ZVdyVG9SNk1zdkl6Ukx1TyszamV0S0ZZNGZqbnA0V0U5cWNEMWcyV2Fmb0Fl?=
 =?utf-8?B?a3dJSEVESjVXNTlHRTI5eStCMzZVcG03MnpwVkcwdXU4SUk2UVBOYzdUZk5q?=
 =?utf-8?B?WGhLUDkrWXhyeDBtMnY4bCtmWVJQUEFTUXQ2MXVsK1kzb3BGNVFtL0VQYUZ1?=
 =?utf-8?B?UEFKTkhDZnN3dDhjdERzdElQYnM5N2t2VnI5SVRGYzVJTWh6Q1lFeGdOUjhL?=
 =?utf-8?B?NkdGZzJCSWk2aTRFMDdXTi9aTHhvZ1lRZitoQzZZZmtKK1JEem1RdkpqbmZD?=
 =?utf-8?B?NWtCSUtaUnV4ZHdaQjdVQVpuTE93bFBpU21WMDNzZ1poTy9xMjBoc0FsRTBw?=
 =?utf-8?B?VXJJUFBDNUk0UnZqT25GZmZ0Y2tNQ0tIcW9tZi9OM1BlZU1Md24vSTlhY052?=
 =?utf-8?B?bFJGNng2R1UvaDRtZWN5Mm1oU0NMZDQ0Ly9vaEt6NldNTTJuL0JYMmk1WnZE?=
 =?utf-8?B?MjVhclN2K1ZwNHRSdkxGRnlFNnJjSnBaRGVFMCtZZllSVlNra0xqeFVmMXFi?=
 =?utf-8?B?WE50UzhWazBWVUxkZUJiSVhHeEJld3VRWjhKdGFpYzdYTTl1RnBKRlVnLzVl?=
 =?utf-8?B?d2g2VkdmRnVKejV6Ly81aGJIRlRuZHBuWlhBSGRxV2sxQmo1cFoveTAzQkdZ?=
 =?utf-8?B?YzdJU0VWSnBSVUlWcUNJK0VudlhZbDAzeTNmb1k0cDJBR1YwRGlSOUZXRkUx?=
 =?utf-8?B?MEV3SVRZL2hEWGx4WU5XZlU4blNYQTROZUlPN2ZBOEZOM1UzOTc5UDVpNGJy?=
 =?utf-8?B?UDFhTDNFK0h6T3poSEMxKzhydXhVMld4cEQ1empSaUFpVE9jM2xLaWQrVTht?=
 =?utf-8?B?Mng4b0pOeXViSTZhSmFaeTFuZHZTeWE5T0pCYmlYZXF5clZ5RzRGVlpFMlN5?=
 =?utf-8?B?RGRhd0ZHZ2ZJNm1abk1WeHltcFlvK2JZS293SCt4Y2o3UC9wNURSaC9ya0dn?=
 =?utf-8?B?VEx2VFlpajlvWVVnUkFnQ1Q3MFNZR3dteDRIOE1qaFhaeXdJdldDUnJqUk5D?=
 =?utf-8?B?eFk2Y1lYT3pnakFPdTR2SWowTmQ2THF2VVFCZU9GRFJhTmp6SXUva3FYdEdI?=
 =?utf-8?Q?sSP+ah?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnhUV0hXY0JUZGpKMzBXVWlNeTZWcXZVMUc3bmxPWDAwaFUzRStGZGlUeVJI?=
 =?utf-8?B?NnpvQW95Q1owOWxBV04wd2hCVW81NGpINHlIbzBaSDlKS1BCZk1tOW5ZR3My?=
 =?utf-8?B?TnF1Z0sxb2ZtYkNTZ2VBbENpZ0Z0NEZjNXZINDZXSzhHZWpCZ3h0TnFZalZw?=
 =?utf-8?B?QXk0SWlQSm4rZGxTaGFHMTJFUm02MldFK2dhMDNyQ3F2T3FLZ0JBWSt5V1N6?=
 =?utf-8?B?MXNIUWJJaDlYSE5wTzBHd0lhbHF2WGhFc2hoL0pBM0dVV0NKUDlUQ3VPNW1C?=
 =?utf-8?B?ak9qVUd6eWVSVzQzQ3VqNCtxNUZwK05ERHQveFZwcyt2K01MTmNKc0plLzZm?=
 =?utf-8?B?NVlnT1FHd3lBMHJnc0t0M25PeFJWY3p5TncydUhiQW91S3FHRmF4R0tURnBi?=
 =?utf-8?B?QWg5RlhSR1M4bSs1SWhzdHRkZnNQTk85bkR4QmNWaklpR20yVHRCZDlaNVdk?=
 =?utf-8?B?cVIyT3VSc0MrRkVRbVFzTlAvMzhaTjFIYWkxelpnOVh0cGtMMHQwTUNsdzBC?=
 =?utf-8?B?RUhQY3ZWVktPak02L3dYWGhxU3FWUThQVEtYU3VTNHVvcjA1dTZIMFFsVSti?=
 =?utf-8?B?Y05UTHJRd1dKUkRIU3pOQ1JEdVRsNWV2NXVGSGl4TEFJTytwTGcwS3RuL01x?=
 =?utf-8?B?TG1teFRFODNJUjdSYldVSlZnTGI1WkphTTduOVNNMTdCTU1IbHlDMzFaWU10?=
 =?utf-8?B?WE05V3NtYXpjd2V2Z2Q0MVVhdEo1WDY0bm9JTGhWbnhIdUowNEQwSXlaTEtG?=
 =?utf-8?B?T0Fyb3FqYWo3Vm90dExJb1VWaTdpZ094d2I5V0NUQUpnY2FuRUhWb0c5NHpC?=
 =?utf-8?B?UVJaM1dvMU9Ld0RSRWJNblNnZ1VWeTcwRWlCSWlMbDE5QnJESVdCbGp5RW9W?=
 =?utf-8?B?dHRGQ2tlSHVqMnNVazdlRWNNQ1RBTGhjN2JZNTBzTi9aZVhhVWs5QzgwWE42?=
 =?utf-8?B?Slk0SUZUVm9qeGlnNExSY3dPVEppT3JkWTRSbE55a3Y2b3J1elFWbzhLNGhx?=
 =?utf-8?B?V2tuOFMya1RvUWkrRTVJekhYcWVDSU1lWDFCdmY5Ry9GWHF1a3I5dklOTnJL?=
 =?utf-8?B?M0hIaFlKWGRKVWp2V0R0Rlk0SHVqd3NpR21WTDhjQUJ5SnRSUUw3WldUdlA1?=
 =?utf-8?B?bHgxa3JQUHJMd2VGM09IMUdLaDB2cUljdFF1dndVMFZuSFIzTHNGdUZIR2sy?=
 =?utf-8?B?cTZPdDVRa0Q0d2hjam9IYXZCMnFMd25qaTVpY2hKSUpPajMrcWc2NGY1WG1q?=
 =?utf-8?B?amlQM2FqMlVIZGhxVGJ6YzJJaU5xNTU0SWJuZldERG1qOVQvWlZWblZJeUs2?=
 =?utf-8?B?MnBlNzArM3I3ZDN0T214S0I3UGNmU2JBbGhUQ2xPbnRCR2lrMElydEZ1Rndq?=
 =?utf-8?B?VkhaUUVtKzlRSjhOcjNTNDZucmo4NWlRNFVYdzRvcDFOYk9BYWVJT0VuM28x?=
 =?utf-8?B?V3lETC9sc3doOHF3WXVyNlR4NmtEa01ZVnVYRE1mdld5ZlU0WGEveVIrT2NI?=
 =?utf-8?B?M1ZiOHFKR0dPQkkxTXVVZTMrdk5FeTBwcG1FMnYrQTAzZHErbFExYmsya0hC?=
 =?utf-8?B?ZVB5ZlJxQTYzdFdoRHdQOUEyWXdFbU9qYWsxeUl1V2UySEJRczZONjRVcCtz?=
 =?utf-8?B?UE9tV0FKMWdrcVVnQ01zUHUzRmMwSnBpUmRnT0drSFJHUnA4dCtEa1lSMlNT?=
 =?utf-8?B?ZWlDTkZXb0tVbWVXUzczbzZyZ3BEUEFvZCtvWWhFVVNkaWVMYURDZzFyY1Nm?=
 =?utf-8?B?VjNROEN1THR0QTh0YjF5NERKZzBPQmVzMVRXcWZkaVBNQThCa2VXVXptdDNw?=
 =?utf-8?B?Z1FCZGp6Q2owdTNkZnBQallPbHNKKzYwZTlDWUR0N3ZLU0lXWnlvUkh2WXoz?=
 =?utf-8?B?OURnZUdtaGRUTkR4aG04QXJmL20rQXQwTlhDT293NHBBVG1OeXVvT2RuQTRO?=
 =?utf-8?B?aEhFeEljcVMyQjR1NnJ3Y0lIZ2JJRHAwZUpKOWdIL094WWVSby9GVWxIZEFu?=
 =?utf-8?B?cVYvU1didUliYUdYMGtUdnFPSVF5NG5OOEI0MkhPMUdTRjhDOHQwcDltU2VE?=
 =?utf-8?B?bnUydDE5Nzd3NFhCenFyZDZZQkFJTjd6MzMwYVRrNE1PSVg5WEJtV2IxTXQ2?=
 =?utf-8?B?dEphTTJOWDBoQXllWVJIWWk2YWhHWjN6WXJTRE9iUmFxZVZja0t1MjBieGYw?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <188948B51C90E849ADBF4D8F3262E47C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c2314-bf47-4d36-c7ce-08de0a3bb4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 09:34:28.5932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9jCYQESB7mZKYOLolDs+T3V8O2hj+vObOikbA3LUfpsG5AUtFxNjfU4Ph6yFZTUTJ2jNvLng9oUeJG1I3EqTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10066
X-Authority-Analysis: v=2.4 cv=aPb9aL9m c=1 sm=1 tr=0 ts=68ecc7a6 cx=c_pps
 a=MVTdNaybHAW3nHwJGrV5wQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=_Z55RRkifPNCcKs1K1UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9ooBjRuO-VaBv2EgS1MHI-lC6i5S2DuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA0NiBTYWx0ZWRfX7GGKVr0gWK0t
 Wdvi5tNFnkgWSG/hKjKWPyJwI/pMHF2XA0b3M29DR1CTGcWIt0ppcFd5DwbHSHY9mmZttDWKFlZ
 Km7fomQPdIJ1QqKoHZhEIlRpfs0xqHesWh9jsvWiNUSAFtwe2g//eWGdwKQSKLgrzI06bcYBjXI
 05mLKEZIn/G3t8ddivfXIFsv4WRkRNufAo0SEB05+h14sV2opk1LqGojIHMV9fNw6XVIf+TkCy2
 csJcjotmvUChQCdR/2axO2B3myKSdk1m+kGlMmAaGW8slRtdr5ks+DcjzdR/+HIOu5lrChwNdMw
 yyyPCvGp9zre+DVNPtN7OIsh1mBp7aceR0aEwoOMqmoHO+WbLUV9wOKXell6wvI2oIVp1OLCZkw
 nt/su6tHxokgBWIZ6Z7xep2Gapj03A==
X-Proofpoint-GUID: 9ooBjRuO-VaBv2EgS1MHI-lC6i5S2DuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQorIFBldGVyIGFuZCBGYWJpYW5vLCBzaW5jZSBJIG1hZGUgdGhlIG1pc3Rha2Ugb2Ygbm90IGNj
4oCZaW5nIHRoZW0gZWFybGllci4NCg0KcmVnYXJkcywNCnRlanVz

