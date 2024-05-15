Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qa-0004be-EC; Wed, 15 May 2024 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qK-0004Y2-Rf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qB-0000oS-Vm
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757260; x=1747293260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DF5SAdKmOTa81i1Lq2VmreQVuK6SYI6Kvt/QgV8+aZ0=;
 b=DHSKGvy6qDHnw4cUZ9X0C96Y4Hm2ZS9xyKhIfHPSpqzogft/8Ad1H88i
 cAJjocMw3t6X9ryLGSOtyYWW6Y2c24F73+fMF7lf9RXIdz44FaLWFtdDr
 AlEa/jJQ4375ofIp9N2Be9UtgVC9w4+jxLg+KgsH2rPanagvstpFSl4oS
 GgCTt8GYe8jtA01jl8uOhc1LPuSBIl89KmLaFxOoCdA6rNDEk+CvcLPZ/
 0lwsFC3jlj4z8d7QNuDz/MVdcYq47GVVv7d9izkMgctE/e5zlSJUDLqMY
 vQHZmZapfH1qbvX40jQi2OQgxrw+qO75+0gjmnN+WeX2nEH7GAcJTUdhK w==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12580198"
X-MGA-submission: =?us-ascii?q?MDHt+GikQvihNGNDiRqe7P9GNAmc04/nzB3Blw?=
 =?us-ascii?q?VlPSEegY3m9i/MUGF3X7xRy8HYXrpikdPlyHd+TYBuJSAa+yq1ih0jfV?=
 =?us-ascii?q?s+5lN0tLu9XTH885HqUs85TINKsmQPpbmOQ0idpyEqPg8uE+EJnDsidA?=
 =?us-ascii?q?CIp6gcZ7tmgaKKsdhRQQ0hbQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5FYm9PHVu0ViGJJhnT76xQ6ZqR+X/r9geAQ2vWl5zaIu9+em2BeY3KFjTp76dIk8lLBUEHLwNnSYxiu47qSYDReF3GR1HEt8j2cSL7kTZy9TLXJVSPDJrNoJzvBYrg6EEtJcf1ZfJj30WvDJI8HgJZS9NOB8mfqkNV5XWOZ3l81oYjCBtPN9e6deBctFcSYgx6a4TuS3ogCL6fhw8uAcVw0bwfOs+Rdu5z7Affy6onANURtgWLX4griiFJfoO65tCLjU0CQPGigcHQ9+iDcsqeV2kzRmxRPeVKJT8zpsFrLBYV+Jls8RMPUKqFYrXC8ljNGMCXIuMcm5HjG+jDWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF5SAdKmOTa81i1Lq2VmreQVuK6SYI6Kvt/QgV8+aZ0=;
 b=HyWdUGW9yMoCk3hrYFSng2VyIf+mcPc6xdF/f5oQ1FJF/onekk6CCsXTK7DccLja1zhs8pT6+OL2HtEcVjDZcE7gUsnEwevbzPIEEEww/4pXy8o+OMszOlsi7BH+lyqLBDjX6vswByKtHv+gHef/bmGwSSbC3oXzPzVvgTm6Mi3dZGK2R6ygBufr99cXBSPutl0Ua41mYmqQFbqgZAdiOOEFTj0rcReGVaiHTPV7Dzk1sdASTJMkur5vEUT3u/TnMlyY8Wj3AkOQysWCZRok/1311jsecZp3Ubsg0B5EJ+V9TbSwgcNGF7RozOATKboesAJHbrXgBsYa5Jv73Pt33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:15 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: [PATCH ats_vtd v2 06/25] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Topic: [PATCH ats_vtd v2 06/25] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Index: AQHappd+ypinSPAnNEWGRCEtiSZMgA==
Date: Wed, 15 May 2024 07:14:15 +0000
Message-ID: <20240515071057.33990-7-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 4aac8f47-67a7-4ac3-98d8-08dc74aea114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NG5LdkZUcFJ2eTgweHFGYms1U1l3WEx3bGtmamc1TnpramxsOVhXR1FFNHlm?=
 =?utf-8?B?eXMrNHgvVnlVYkdSVXpYVU5LT0psUEx6V1R4YTUzbmtlRHNZL3d0SnVxRlMw?=
 =?utf-8?B?cFlMdzc2TTdoLzA5OUdPeDZzaHFxYnc4MjV4bktnd0hUQXhDUUhRdlJHSzRq?=
 =?utf-8?B?aTJ5ODZnUEhiNHFzUW5CdmxEY00zVXE1WlYramVVZVFJUVc3Smo3SjhTdWxn?=
 =?utf-8?B?cC8xQUpzNzBTV2svNkc5c013SlNxczNKakUxclRNY1hIYXFSdUljMTQ0S29K?=
 =?utf-8?B?OG1RSU1ZNDR0dHk1aFdSaDd1K0lxbGVtdjBSRjV2amNsUHZ6L2FFOHNSdlZ3?=
 =?utf-8?B?Ny9tQ2RwMFkwWnlYMG11WkZvWVRTNi9pWEVaZ1JCSEphcnUxNmhaSXphaHBC?=
 =?utf-8?B?WER3VTFReHlia1kvdE9nNzJ1S2hMbDNwQzhCT053dlQ1ME93NVdlUzZVMzlj?=
 =?utf-8?B?Mk9CeUg5bTFFN3diZ2xFQ1VibmsyalQ3RUlmLzg2dENOTDdxeTdaQ3Rrb2to?=
 =?utf-8?B?cWV5MWRHcDFZcGdQa1ROWU1ETWVvanY0dFFsajFyZ3JqUG0ycDRnS25DVlRE?=
 =?utf-8?B?dHFZOVFuTVlPNno5WHc3YVdvMlljeUpwcDRiYXpGZWFQekxIU1IzcTRVc0lV?=
 =?utf-8?B?V2lxRUx1Z05EZFo2VnJGRmZ6cmIyQXo0TlJ6c0FWK25xbHl5N1BYWElYc2Y0?=
 =?utf-8?B?OGxzQnlUMXpBNWVMOXV5SUFOS0kzSkVEZkJxQWxDNU9scjdwQUcvc3p4Ym5v?=
 =?utf-8?B?NGZuK2w3TjBVWm9WTi9BTlFxNlc5djVvOGRBM2UxT3VOOFEzM3dxTnNCUWlP?=
 =?utf-8?B?TlNIOWQ5NWhPMlMxQTl2RzRhR3ZNR0UyR1VJZGttZ0toTnhCNmY3THFTRjBB?=
 =?utf-8?B?SkEvanZxa21XbHVIc01JNG92VkhrVnlaRzJHMlF6QzJyMnErN3VYQ1Z6R2RR?=
 =?utf-8?B?RXlUMEpjeEU3RkhpNWJ1YTQ3MlB4dDVjc2duYUJMUktGeDZnWUVkWmNJeUlO?=
 =?utf-8?B?Mzh3U3IydnNmVmZsTkY2RXUyL3BncG5WNGJGUVROejZ0ZFZFV0VSVlg5cjJh?=
 =?utf-8?B?Q3FTZnhuUzU0dlgrMkJ1cWdUQXkzTzM0VUF6TjJFZG11MlA2ZWpDVnprdVFx?=
 =?utf-8?B?aGRCVGd0aGVSakV2bXp3NkRSb0pRSEZPWi9uSGdEMitjSWZVKy9BUzlHSHZ1?=
 =?utf-8?B?eDhucGxzcjFSYkJKc0s1Q1l5bndkdFVlTU5USWVMZjBEOUxtRzJBRHllSTlw?=
 =?utf-8?B?Q1pqR0ZiK2g2UldvY3JyMW1iRkFDREJlSjdMejlNS1R1cTNNU3NJa093WWY1?=
 =?utf-8?B?TmpCVS9RczZTZ1dJdkV0cm0zc1kyWkNMVTVEQ3FtTzNWbjFkcHRvbTE2U1RZ?=
 =?utf-8?B?bm01SFMwc2dxbWEzMGQ1eDk0VzZiRjA0RTAya0lFR1dWMmtySVZSRDlyZWxu?=
 =?utf-8?B?SnFzTFdMUEg3VS8zbGIvNTBjV3lySzFNRDh6bVRMalpvMnp0b1Zib2FmZVlI?=
 =?utf-8?B?Mys0VmsyNzIwYjNwYm1qaE5zdU5ualdtcStOandxZVdLSUV3N2Nzb3doQytq?=
 =?utf-8?B?NDlhZTlIQlFLblZZWWJRVnpvMlR2YnlGME1tb21nNWxONTE2MXgyeGtWZTMx?=
 =?utf-8?B?eDB5cVhRYWxZelcybkdvWmxwWXBTM2swaHQ5YUJQNTh3d1AvWUJiMDJGYi96?=
 =?utf-8?B?aEVZNldaVUFhL055N1RDc212eVNJejNGNUR0aDYyN1N1b2Npem5lS1VrSFZ2?=
 =?utf-8?B?K0lwSkxPdDdvemxKTHF6YUx5TEJmRHN5czZPV1BnTXc5R2F2aFNqeFMwMkVH?=
 =?utf-8?B?R2V1b3AzV00rWHdFV1U2UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0x4V0lNTEtlNjBVODVOQUIxVE1hZUJldzhFYUJSTWVOOFFkeVYxT3FacUI4?=
 =?utf-8?B?NHNicmk5MEs1MHU3NXhLVTl3eVZKVENxOTZ6R2lhZWRjZUl5VWk1R0tYQW9z?=
 =?utf-8?B?L0pCWXh0cXdaOEhNRFJxanF2cmFsdm9rMGxqOHo4YTFsNFhyS0ZVN3FjcDJa?=
 =?utf-8?B?VUxhTHFha1l4elZzMWtOaVFzYVBGeXZxdzhNQUNnQnFXRW16NVIrM0FWK085?=
 =?utf-8?B?M0dpRnNHTENnZzdsR3FGUUFZYTN3TEtPVXVselBYbVJBVE53VFJzTnZkNHdX?=
 =?utf-8?B?ODR2bFYxMjNhb2VPUHhTV3NwTFBrL05BWDdtbmFBZTBwMFVyNk0wTkJuU2t4?=
 =?utf-8?B?bkY3VXNRK2xwMktJYXNwc0pXVmExOGpTM0VSbkF5eXgwY0w5a3BNLzBXeCsx?=
 =?utf-8?B?cDFzSGtZc0dXRHJCaWVKdjRGdUlTTER3ZEUrMVRFWHozbjc1aHBwR2NCdXNJ?=
 =?utf-8?B?WmhRbDZRelhRTk14RFlnTklRbEF0WkoxcmNQbm1jRmdtaHpldFByd3NwM1hQ?=
 =?utf-8?B?Tm9ycllrTE1XY0ZuZWJkU3kzeEFicE00OExqQWNOOFlTQVN0Q1k4UUVvUC90?=
 =?utf-8?B?eldzTDR6UVlqQk5BMGJab0YxOWxoOGlzeVdudHpOc2N5ZlVSa2xEbzhCTFJm?=
 =?utf-8?B?dEtoQXZoQk5lNlFiYzVJTllrM2JhN052d25NeWV1akdoM3RkYWFlekp5ZE1E?=
 =?utf-8?B?dTcxOG5XK3JiOUlUcVo4MkprUWdnUlBrSG1SM2hzQkF5cnNhd1gxZjNIMnVB?=
 =?utf-8?B?MlFNVVl1NHR0bFBnbXVCdisrTHUzZk8zOFlMUTFJMS9mYWsrQ2Y1Q0lvdXpI?=
 =?utf-8?B?d1hadTcxSnhqS2ZWSDdteE5QNjg1ZkhEZXZhWE9XNzd6UmlXUDNWbVE2Ynpk?=
 =?utf-8?B?M1VhZm95VUxaWUw5Qk0zQ0RSMzBJRXBQZ2lSamFReUJXNnk1TG5RL1dvaG5v?=
 =?utf-8?B?MmEyNHdRcVdGV0dWTDFlZjgySDQ5RzFEWS91blB3T0F2VE9iWk9BbEQ4SEJw?=
 =?utf-8?B?UE1YUCtjQ3FzYVVPTlJESFgwOEJmQ2FwYjRjUVN4NkpycHhNVWE4bzNkZjNL?=
 =?utf-8?B?WWNEaVptYWt6Z0J0UXRDRTF0UXE2bUJ3ZXJUQUw5dnhxUEhCWFBxc3dUSUxx?=
 =?utf-8?B?bWRRcHFLZmxxME5LVHU0eXNOWmFmemJFeXJyMUNCZENzV0E0UmNrdjdqcXBC?=
 =?utf-8?B?TnBMdWllUW83UGtzMVF1MmJydGVvSjNldURka0JqelNVWUJvK3lNQUVuUmg4?=
 =?utf-8?B?RjNqWUV1TXN5OU9qNEw5UE1aN2RnZ1JIY3BFNEYzd3o0cVRVUE1lNWwzdVgx?=
 =?utf-8?B?WThhNFJJRzBSRFh4aTFjY2ErVnZWK0didnd1aEUvMy9LcnhsS0t5UWVHYWFP?=
 =?utf-8?B?UXRhbHdCMTI2dyt1K0JPcG0xblJrS2x1OVR1RWtvdCtDaXhsaGF1aXJzQkZh?=
 =?utf-8?B?NWtVVVBkUkx4c3Z1VWE1OW9DVVdaa054eUFEZFZZSWJMUm93b0JQaUNBQVVi?=
 =?utf-8?B?WjFyR1JRck1rU3QzTGhlaXZUeGFxVzhLQUxPSFl4OG5jckd5VlZsNmxKcnJs?=
 =?utf-8?B?T25oVDZxOGs2U0FIbFJTb2lKYmpaSHA2ajFsTW94ekVRUGdRMzk1aS9TaElM?=
 =?utf-8?B?K0JvT2FXWnlBczFuT0MvTEJZbEZuUWI0WnNmTGJ3Z0JFeUUyVVN3aTdiamhN?=
 =?utf-8?B?Q1d2bWk3THFRQmdHb0FRZTBtOVU0T1E3c0tyTW0yTlZCUVMxT0VZYnFlcEh5?=
 =?utf-8?B?a3MzL0l0R3h2Qk04RVBMSENHTjBMdW9nQmpKRzR0TXdkcjNwcTVsT1p5QXhW?=
 =?utf-8?B?cDY0bDR5NDU2U0hvTFF6eVIwdXd4OWtpeDRjZFNvSjZEWDBVM0JhL2lBUW0w?=
 =?utf-8?B?RlIvRDUxdUZpejl0MklMd1V3UWtUc1NzR3BOb1V2QjdYTlVPalB5Q2N5U3lq?=
 =?utf-8?B?S3MrK0Y3aEp1ZTA0eDVTL3dQangrYVlZUVpHQm53WDZkMVV4QzNaRFZrQWc2?=
 =?utf-8?B?ckx4THpYWTh6ZUNtU2gvdlFyam8vc0R2K2lsVXNDZzNacDV0QUgzaEZrTkF6?=
 =?utf-8?B?NUlsZzl0TWFabGovb1p0T2lQMW1kNmZDM3RTSGM3K1VSOHQ3RVJ6NEtnZk1r?=
 =?utf-8?B?VHpieldmbFl0bzBlZHpuU3Fza2ZOaHU4akQ3Y3ZRRFJFM0xiaEFtUW5rSGov?=
 =?utf-8?Q?LMLYxkzDZ0WE//ZFQjeFr3w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <715FCAB949C26347B4CC5AD1170AF369@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aac8f47-67a7-4ac3-98d8-08dc74aea114
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:15.5207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Pg/G4dDC69kvgKxr4GONU2oTVXFhZ3snYRb2YQ4bsFfaO+E1mij68JE6DsZFGfCoHTYd/hBy6+u1O50zz9nTfPoZftbuHS7JYD0wegRCZ3zsdKZ/SYgD+y3u15eTfUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

VGhpcyBwaWVjZSBvZiBjb2RlIGNhbiBiZSBzaGFyZWQgYnkgYm90aCBJT1RMQiBpbnZhbGlkYXRp
b24gYW5kDQpQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCg0KUmV2aWV3ZWQtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6
IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29t
Pg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggN2E0ZGQ3MzhhMy4uZGJkZjEzNDcwZCAxMDA2
NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQpAQCAtNDI5Miw2ICs0MjkyLDM4IEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2ludl9p
ZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgIHJldHVybiB0cnVlOw0KIH0NCiANCitz
dGF0aWMgdm9pZCBkb19pbnZhbGlkYXRlX2RldmljZV90bGIoVlREQWRkcmVzc1NwYWNlICp2dGRf
ZGV2X2FzLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHNpemUs
IGh3YWRkciBhZGRyKQ0KK3sNCisgICAgLyoNCisgICAgICogQWNjb3JkaW5nIHRvIEFUUyBzcGVj
IHRhYmxlIDIuNDoNCisgICAgICogUyA9IDAsIGJpdHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBz
aXplOiA0Sw0KKyAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6
IDhLDQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZL
DQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQor
ICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQorICAg
ICAqIC4uLg0KKyAgICAgKi8NCisNCisgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCisgICAgdWlu
dDY0X3Qgc3o7DQorDQorICAgIGlmIChzaXplKSB7DQorICAgICAgICBzeiA9IChWVERfUEFHRV9T
SVpFICogMikgPDwgY3RvNjQoYWRkciA+PiBWVERfUEFHRV9TSElGVCk7DQorICAgICAgICBhZGRy
ICY9IH4oc3ogLSAxKTsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIHN6ID0gVlREX1BBR0VfU0la
RTsNCisgICAgfQ0KKw0KKyAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfREVWSU9UTEJf
VU5NQVA7DQorICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZ2dGRfZGV2X2FzLT5hczsNCisg
ICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gc3ogLSAxOw0KKyAgICBldmVudC5lbnRyeS5pb3Zh
ID0gYWRkcjsNCisgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgIGV2ZW50
LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQorICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lv
bW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KK30NCisNCiBzdGF0aWMgYm9vbCB2
dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVz
YykNCiB7DQpAQCAtNDMwNyw5ICs0MzM5LDcgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfZGV2
aWNlX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KIHsNCiAgICAgVlRE
QWRkcmVzc1NwYWNlICp2dGRfZGV2X2FzOw0KLSAgICBJT01NVVRMQkV2ZW50IGV2ZW50Ow0KICAg
ICBod2FkZHIgYWRkcjsNCi0gICAgdWludDY0X3Qgc3o7DQogICAgIHVpbnQxNl90IHNpZDsNCiAg
ICAgYm9vbCBzaXplOw0KIA0KQEAgLTQzMzQsMjggKzQzNjQsNyBAQCBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc19kZXZpY2VfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgICAgICBn
b3RvIGRvbmU7DQogICAgIH0NCiANCi0gICAgLyogQWNjb3JkaW5nIHRvIEFUUyBzcGVjIHRhYmxl
IDIuNDoNCi0gICAgICogUyA9IDAsIGJpdHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBzaXplOiA0
Sw0KLSAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6IDhLDQot
ICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZLDQotICAg
ICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQotICAgICAq
IFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQotICAgICAqIC4u
Lg0KLSAgICAgKi8NCi0gICAgaWYgKHNpemUpIHsNCi0gICAgICAgIHN6ID0gKFZURF9QQUdFX1NJ
WkUgKiAyKSA8PCBjdG82NChhZGRyID4+IFZURF9QQUdFX1NISUZUKTsNCi0gICAgICAgIGFkZHIg
Jj0gfihzeiAtIDEpOw0KLSAgICB9IGVsc2Ugew0KLSAgICAgICAgc3ogPSBWVERfUEFHRV9TSVpF
Ow0KLSAgICB9DQotDQotICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9ERVZJT1RMQl9V
Tk1BUDsNCi0gICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJnZ0ZF9kZXZfYXMtPmFzOw0KLSAg
ICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBzeiAtIDE7DQotICAgIGV2ZW50LmVudHJ5LmlvdmEg
PSBhZGRyOw0KLSAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCi0gICAgZXZlbnQu
ZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCi0gICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9t
bXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVudCk7DQorICAgIGRvX2ludmFsaWRhdGVfZGV2
aWNlX3RsYih2dGRfZGV2X2FzLCBzaXplLCBhZGRyKTsNCiANCiBkb25lOg0KICAgICByZXR1cm4g
dHJ1ZTsNCi0tIA0KMi40NC4wDQo=

