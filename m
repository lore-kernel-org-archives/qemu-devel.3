Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE4C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qV-0004aQ-4u; Wed, 15 May 2024 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qK-0004Y0-JC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qH-0000oc-0E
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757265; x=1747293265;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XcjKecxBdsPpr9IsLkbs6s9MkMnBwLIwAGN4s71C3bc=;
 b=L2sx8td6Sgro9SZ6ouh0bdY6T/Pc+G3ddHHl+1Tut5X+9RQzRfz3s3zl
 YH5HejPQ57/lms1vU+ySfErQyNUfOJBob1+e0iSqy8UOqvsb56/rz7Wt9
 XDAApD1Wok9gsh9K99qXs9cEWxh7u9Aw8iuSBGl7G2Uq/TIQrXPjpq/WV
 gfDEu1KQrp74YQhXuS94Fx5IGR/d89IPvdcCZZvhIVoWpbeZDj6PFx8tC
 +w0aEQiWXVYUPXgXEf2txwIo6qtxrEByVMietjxI9za6z8hv34hgUnbgD
 CSE0g+dOWo9MwO7Iyo9ftfA03QpuXlSbS1tDpLV8cO2Y7qVqGv36+uWDR g==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12635437"
X-MGA-submission: =?us-ascii?q?MDGdBZAET//s8o3GItneiAiU43x3WGBbR/XnX5?=
 =?us-ascii?q?9ruL2nVx+nSEfm9CwdGVsKwhYCQhKNW4rOc+waaFl3LxoorXk7FAtBKf?=
 =?us-ascii?q?ICTHicB0LjvozUSsTLyYGQvgbW8PRYc+loXZq0U5/bawOkQbCnmsec9n?=
 =?us-ascii?q?L38xn4QDG9zOAaWtquygv6Ew=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU63CaEajKbDofofl/vB8BIn9lbMk1oEABVvjbGKFkGwm3ZmvyZvp/9IZiYSWwIoK8X8IPb3JEEzhgnaWSaGth66geNwDWhvAVTGAzCuNJxYd3k+A8ulUew7N7DMpMQfeMkUIidq/IbkhWv32/nrwx/i4TbOSXLsTLNVQwDZ1ZpmbiLHoLCOMM80CssW7TlcLpmwCwOSM7SCPp+BZ4h3JzhxdVZTiWIC9wufzW6ZL66THPAFhfIXQHKi1eZUPupwF2pIKdeN1xKTf49GDoaAABZrEYbtf2Bs+IJQyCqh+0CoryDwrhM8Sjb1m/eZT5Ofy+OH+/iqJ/qAshPmbfomiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcjKecxBdsPpr9IsLkbs6s9MkMnBwLIwAGN4s71C3bc=;
 b=n0xpH61ikuy5qEnXFf9O880I7pFaYUJhEwrUX5C0blPYZoLW2Rd2uRae9QybjcmmYRTfnjQ3czeJlNJOnLw6uGCenzM4lk2ahOrh4YQcPyctPpYLWk/D/KV1IBMAlH++i4hKWCIyWFj4x2V81bLmjJVCKC4VJb/QjHXgTVVGLgUHk9JFeHobf66Fz6EBzMQW+6dgP4TOohyOngSqyu9Kcc6I+FvCd6Li0yW6dTj1fkQ864G6t1MNWrYbGNxiQcIi/9T9gADnEISA6l8Y/wpRwSELiLEeBuW797MJkIpYSOJ/qiLo5vS4fr59XooXDPQVh/m58tN8T2aVihZC7t3gzg==
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
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 05/25] intel_iommu: return page walk level even
 when the translation fails
Thread-Topic: [PATCH ats_vtd v2 05/25] intel_iommu: return page walk level
 even when the translation fails
Thread-Index: AQHappd+BZPelwlHbkqPdUTJeAISqQ==
Date: Wed, 15 May 2024 07:14:15 +0000
Message-ID: <20240515071057.33990-6-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 1ac4e559-5523-48e9-9bda-08dc74aea0e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cGZIa2NFN1F0N2JicFVwTW5wbnEvMkZMZS8rcXkweEJHWWZhOU85YmRGSDJP?=
 =?utf-8?B?cUhoTTFVVFJtVUczNWkzRmJ3d1RnbldBNzM1bE5ES240ZXJydnk1V0U4Vndm?=
 =?utf-8?B?ZFE2dEZuQTFLZTYyRWxCN2xwNVllK01EejJMamh5Szl4cnNDL0E3eFJrcVdD?=
 =?utf-8?B?VEM3Z2JnWmtsQVM1MVA3K0gvVG1vMS9NZUkyL0ZKbjFZM21DdlY2NWJPNXdP?=
 =?utf-8?B?OGRENThwaURIb0RNY3V6UThEdUF3Y0dTNFU3TlZpby8wbkE1c2poM0RrL0JC?=
 =?utf-8?B?VEJBa2ttU1JtY1A4WG9KV0V2a3hnL01oV1BIaG5FbVJiZGFxYmdHV25yTG1U?=
 =?utf-8?B?NFFrUHRCb0lhU2lDOFhOZEh0Z3FzOFlQdVBaUnZpVCtNTVpJdVArejZxN3lK?=
 =?utf-8?B?ZEI5SUZOYXFxOXZzSVRCUHJSdzAxVEdldTB0U2pqTXBVTVQweENoN0ZPSCtO?=
 =?utf-8?B?SVBueml3SWhsdHdIRHBUTWhQa3JGZjgwc3BXZ1FnTVM0QmQ2dTRvUW43OFdX?=
 =?utf-8?B?MnlBM1VpTU8vdUFBTzI0V1FRdGg3SHY5MnU3TXRhT09MbFM3ZEJqWWRrUFAr?=
 =?utf-8?B?T29jWDU2di9kdmVXU0xEMkRCamJWTTVTbWJLcW5KMENxSVkxMnhJYTNaQzBY?=
 =?utf-8?B?cS9SblhRRFVnTGZqMTZORERuUUhvOUhCUUMzOUpRS21JelFnOWhMZkg0V0xJ?=
 =?utf-8?B?alBxSXh1dThrdHNMcjduRnZmYUNqQ3YxbFRDcmV5M2s3YUZlUW1LbUkrM1Zo?=
 =?utf-8?B?bWJxcDdqYWhOUXRtYUE5VzdYUW1Za2VmYkpZR3M2R2FCczlEWGlxNHAzMjNE?=
 =?utf-8?B?M2JBNGJ6RC8wMGpoR0JiZGZzQ1ViRnZrclM3SWh2aXVzTkZSMUtEdTdoMXpr?=
 =?utf-8?B?cWk1bW1QZFhwK2QrbWx6RFRLRGVBemdtN1Z0TUhUcXNwQ3NsZzVBOW5GUDIr?=
 =?utf-8?B?emFPZHQ1bDByYVAyeW1iZERtQ25XbWQ1TnUzY3ppRVNQcmpnSjFSV1l0TTZC?=
 =?utf-8?B?VjVuU1k1WG50RW10TGRvWWNSVmlsZXJGV1dtQkZVUHNnT254Y0d4aUZrdnBp?=
 =?utf-8?B?SEQraVdsUE94dEUrM1JrTWhqYmVTVERHeXlta3NsTkw1aFJSZ3hLcEszYmhI?=
 =?utf-8?B?bDQxZU1ubUFHeUs0cVhBZXFnc1hNalFValdZZzQwUjhJcGNsTHB5Z0FMRzFH?=
 =?utf-8?B?c3dmQWVzZUt5UHFXTkdzNHc4SW50bkcrUnlYNXV4eUJFYlFrYXdJQVJUOWhr?=
 =?utf-8?B?b1F4cytRU3JJb045a1BqMnRKRlNvMllxQjFTUGxrYndZL0JWNTJ0WjUrWjFp?=
 =?utf-8?B?b2dTYVM2VG9iNzlzYmNNWlJHaEtOcTI4cFlTQ2R4dmIwYThXcDl0M1RGcjZW?=
 =?utf-8?B?WmxMVC9MM21SYlpJbEhIbS9vTnJSM2pQSk9VU2FvZTVwM2R4R25EMXhGdUcv?=
 =?utf-8?B?SUVib0FhWm5GK3Z0WXlkeVZYV0E0c3B0QzVST2FBcUk0YWhrQWtRQXBaM3gw?=
 =?utf-8?B?cklVZnZHdkRCaWxqajBEZnZpVllUajJaSEticlRncXdoRG82cWhVajNBZHFu?=
 =?utf-8?B?RmhMMDFzMFZQdGp5Zm92cEFhRWlPU1llRmlCR25NYXBUaWQrdmMxQlF2cE43?=
 =?utf-8?B?aWVMVk1tbW1KbXlDQ2owL0VnQlpGZ2F4MDRaalVmcVNYakRNcjBTTmROTmwv?=
 =?utf-8?B?OFMzOFVjYlRoOEtPSktUNFVCdHpvS3I1eHpOSHl5M1dkY3VLekpsL3pjZEhJ?=
 =?utf-8?B?M3NtNmQzbVlvMGh5UVdmZHhscWh6QStTKzlrNHNSTnBNNEgrZm1kWUduQ2Jj?=
 =?utf-8?B?L0N5UHBkYjhsYm5qb3c3dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0psVG5YS0JPcHNhb24rcTdvdXRjdkovUWhDVkRPZDNBNzM5UjRwdzhmM2kr?=
 =?utf-8?B?MnNWSGw5TkpWZDRBUUpDN1UzNm5RUU1DQWZnL3FQeGF0dU9PVHlUREdINkF5?=
 =?utf-8?B?aGFZaTAvU0h3QWZJQjczdlgvcWx0VTVlWjJ0ZTVYK2JLd0h2b2ZxUWl6TFFE?=
 =?utf-8?B?ZEs5dWRMbTNKdTZZQWhUbXZHRk9YQW1IaUdCZnNQRkxIc3FPUXZSenNwZnNK?=
 =?utf-8?B?WDF4UFkrdllIVlhMTWUxckZVY25DRzc0NkZ6RVovZmM5UzJrODlEWmtnQ2Zj?=
 =?utf-8?B?dTVHSjVMbXRFK0I3Qmw3UnFLTFdFdHhiVTV4SVhrZnVlOVI4OU5ZMTBBVkVh?=
 =?utf-8?B?VTBMWVNzRTVBa2Y4V1Y0cUVUQ3ZFRHFSR0c0SWhJTHFGMFZVUCs5TjdTN2Vu?=
 =?utf-8?B?M096TW9GYWI2UlNJbzdFNnZHVXhEQVRwQ1hJemsySmZsZ3BGbzMyNHI4R201?=
 =?utf-8?B?Zkc3ekMwWnkzQ1NFUG5VWmdUdCs5VlFRbzF0OVhyY01QMUdodU1zeUp1Mk1N?=
 =?utf-8?B?cUlWR0p0Z0MwTG1JTTUwbHEwUTZYTFB3UFNmRmNoSTg2NkU0eVdPUTVsSWNO?=
 =?utf-8?B?YzFIWmdNS3JMZmtObGx6ZW9HVmxPeURrMXV6cHRwRnJDdFlVa0JCQXFScmdn?=
 =?utf-8?B?SEVvR2xYZXduWlVKR2FzTldpUWo2UURHLzBWb294cW8yU3UramtVNmlLcmpV?=
 =?utf-8?B?Vkx5MnJJVFVNbktlVk41ZDZnVVdUTWZXMzNXOEVjbFRoZ0g3aS9SOFZNdW85?=
 =?utf-8?B?OVRIbnVxbHdCdmszdEpjc3RVWExmZ2gxMUZqNnBxaGFzMGMxbTNhMlFINmEw?=
 =?utf-8?B?YzIrTTlGTCtySjBvSkl4Yjg5cW5DdmdnbFRzWlF1cHQwZDJ1NTFTNDN5cnlC?=
 =?utf-8?B?Y2c2eUpndFJieFJUdnh2RUl5WmZFTFdVaVhvVkVramVuVmFDOExKMzJzSG12?=
 =?utf-8?B?RVY3NVR2MkJFZWRqVm9aWnNlbDR1L0FrM3dSMTFKdnQ0WG9SSUtuZ0FQUnJr?=
 =?utf-8?B?MFBkSUxjVlM0T0gwZ3hUUS95c0VJWmxkbUhQQUhhUGdUbER5NklKQWhLcDlm?=
 =?utf-8?B?RWxxR1lYWFFIOUx1L1grY1plc0t4Q2tGY0hXcmJtSHRyNm8xMFIwNEZHb1VN?=
 =?utf-8?B?RHlnUFdESHRHbERvYkt4U2I3dWZTWGYySEEwWS9uNWwzTTNzRVNkcW5OVlI4?=
 =?utf-8?B?eHdrVFkrR2R2TlE1V3BLWEZIZVFvQkpqejF4UEVoSEZlbXRRR205VW9KbEJv?=
 =?utf-8?B?OFFrN2ppSjM1U0Q3TnM5RVdob0FsRFRCUndJSE55bUoxRjFTUXRINHZLYmNa?=
 =?utf-8?B?UFhxYmlzS2hvMkVqbVBkNGdXTUNRR0xZM1BQWjhlbjd5VEg2eUZHMWtwUkpY?=
 =?utf-8?B?aS9vSzRwM3JqbDVhSU9ldVJHOWtWM2VSbE5lVVlUWncxSW5RdUV5UlhPNjh1?=
 =?utf-8?B?dGFxQncveVkyc1pqQ0hqbEJSZVhHeTVQQkxzeGwyQVdySjFjTHBFZHJTaW1G?=
 =?utf-8?B?cG5pbk9GdWVsV2JoM1huYnF0bmswUmNDSlpzWVBBc0JKcGx6NTZ4alhWZ1RO?=
 =?utf-8?B?QnNTZ3lEYk1FN0x6SjRuOGYwUXNJc0RUQjlTOUhYWlhKTFBtZGpVditGV0o3?=
 =?utf-8?B?bjFCY0JnQ2cvakduVW9EVnNYdnZldWN2WW9WRlFKcks1a0xkazJFblRsckVL?=
 =?utf-8?B?MkEzTmJxeXpnY2t5bkQ4TG5UZWRqT1hwd2FHRDdTdktwbWl1elY1VEdhN3Ay?=
 =?utf-8?B?MEpmZFErMzFzR1haWXNrQkxjejZOWlJ1dDB5Y2NEY2hvMzJrVlBwRUlESjEv?=
 =?utf-8?B?Q1o5RlRoYm10YjJvR0h0QXVwY3pVLzY3WnFiNEJaeUFvYlgrUjdLNnEwaE1u?=
 =?utf-8?B?dEJLanoza3BBRW0yR0w0RXdBODM4ZlROOTJZd3Z2WUpYS1JhSURUcjBWRnlB?=
 =?utf-8?B?Y05Sa1VDTEsxbHVBWTBWQWZHbitaUU4va1pLWE5GZE5ON0dqZUh6WEdXbmhq?=
 =?utf-8?B?ak42eGUzUjRoNHVmYVhIYUIvZGl2TFd1Mi9acGhLMUxlQkxJS2JEWGpzcTIv?=
 =?utf-8?B?cjUyckpoNUFFQ29WWjNXSWFWVXNNenZKeEdpQU84VWRwMS83N1NHMnA4SmFr?=
 =?utf-8?B?S3dWdytFSmtKUXJpejVYYjZIQmNpQVJKOTFRZWxuT2lVNWUzMStMcVBvUGRL?=
 =?utf-8?Q?EGPa5e4Xi29MxlV6dzFMlIY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEA10FC47029344D86EB86531EAF3F4B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac4e559-5523-48e9-9bda-08dc74aea0e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:15.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/ukO6+HTU18UZ3b1zZRolYqWHZjaggE5tyPSrz4exaiC4WhgbXdhgRJlAipy0n0OA3FbmIWeuf6dHM0KOuuNXka8TVFmDQr2Y05l7nU8tGEJCnOqLpWWt6hb8J1oQYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
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

V2UgdXNlIHRoaXMgaW5mb3JtYXRpb24gaW4gdnRkX2RvX2lvbW11X3RyYW5zbGF0ZSB0byBwb3B1
bGF0ZSB0aGUNCklPTU1VVExCRW50cnkgYW5kIGluZGljYXRlIHRoZSBjb3JyZWN0IHBhZ2UgbWFz
ay4gVGhpcyBwcmV2ZW50cyBBVFMNCmRldmljZXMgZnJvbSBzZW5kaW5nIG1hbnkgdXNlbGVzcyB0
cmFuc2xhdGlvbiByZXF1ZXN0cyB3aGVuIGEgbWVnYXBhZ2UNCm9yIGdpZ2FwYWdlIGlvdmEgaXMg
bm90IG1hcHBlZCB0byBhIHBoeXNpY2FsIGFkZHJlc3MuDQoNClNpZ25lZC1vZmYtYnk6IENsw6lt
ZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0t
DQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMTEgKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCAyNTIzNjQ4OTNi
Li43YTRkZDczOGEzIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0yMDY0LDkgKzIwNjQsOSBAQCBzdGF0aWMgaW50IHZ0
ZF9pb3ZhX3RvX2ZscHRlKEludGVsSU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KIHsNCiAgICAg
ZG1hX2FkZHJfdCBhZGRyID0gdnRkX2dldF9pb3ZhX3BndGJsX2Jhc2UocywgY2UsIHBhc2lkKTsN
Ci0gICAgdWludDMyX3QgbGV2ZWwgPSB2dGRfZ2V0X2lvdmFfbGV2ZWwocywgY2UsIHBhc2lkKTsN
CiAgICAgdWludDMyX3Qgb2Zmc2V0Ow0KICAgICB1aW50NjRfdCBmbHB0ZTsNCisgICAgKmZscHRl
X2xldmVsID0gdnRkX2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCk7DQogDQogICAgIGlmICgh
dnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKHMsIGlvdmEsIGNlLCBwYXNpZCkpIHsNCiAgICAg
ICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogZGV0ZWN0ZWQgbm9uIGNhbm9uaWNhbCBJT1ZBIChp
b3ZhPTB4JSIgUFJJeDY0ICIsIg0KQEAgLTIwNzUsMTAgKzIwNzUsMTAgQEAgc3RhdGljIGludCB2
dGRfaW92YV90b19mbHB0ZShJbnRlbElPTU1VU3RhdGUgKnMsIFZURENvbnRleHRFbnRyeSAqY2Us
DQogICAgIH0NCiANCiAgICAgd2hpbGUgKHRydWUpIHsNCi0gICAgICAgIG9mZnNldCA9IHZ0ZF9p
b3ZhX2ZsX2xldmVsX29mZnNldChpb3ZhLCBsZXZlbCk7DQorICAgICAgICBvZmZzZXQgPSB2dGRf
aW92YV9mbF9sZXZlbF9vZmZzZXQoaW92YSwgKmZscHRlX2xldmVsKTsNCiAgICAgICAgIGZscHRl
ID0gdnRkX2dldF9mbHB0ZShhZGRyLCBvZmZzZXQpOw0KICAgICAgICAgaWYgKGZscHRlID09ICh1
aW50NjRfdCktMSkgew0KLSAgICAgICAgICAgIGlmIChsZXZlbCA9PSB2dGRfZ2V0X2lvdmFfbGV2
ZWwocywgY2UsIHBhc2lkKSkgew0KKyAgICAgICAgICAgIGlmICgqZmxwdGVfbGV2ZWwgPT0gdnRk
X2dldF9pb3ZhX2xldmVsKHMsIGNlLCBwYXNpZCkpIHsNCiAgICAgICAgICAgICAgICAgLyogSW52
YWxpZCBwcm9ncmFtbWluZyBvZiBjb250ZXh0LWVudHJ5ICovDQogICAgICAgICAgICAgICAgIHJl
dHVybiAtVlREX0ZSX0NPTlRFWFRfRU5UUllfSU5WOw0KICAgICAgICAgICAgIH0gZWxzZSB7DQpA
QCAtMjEwMywxOSArMjEwMywxOCBAQCBzdGF0aWMgaW50IHZ0ZF9pb3ZhX3RvX2ZscHRlKEludGVs
SU9NTVVTdGF0ZSAqcywgVlREQ29udGV4dEVudHJ5ICpjZSwNCiAgICAgICAgICAgICByZXR1cm4g
LVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsNCiAgICAgICAgIH0NCiANCi0gICAgICAgIGlm
ICh2dGRfaXNfbGFzdF9mbHB0ZShmbHB0ZSwgbGV2ZWwpKSB7DQorICAgICAgICBpZiAodnRkX2lz
X2xhc3RfZmxwdGUoZmxwdGUsICpmbHB0ZV9sZXZlbCkpIHsNCiAgICAgICAgICAgICBpZiAoaXNf
d3JpdGUgJiYNCiAgICAgICAgICAgICAgICAgKHZ0ZF9zZXRfZmxhZ19pbl9wdGUoYWRkciwgb2Zm
c2V0LCBmbHB0ZSwgVlREX0ZMX1BURV9EKSAhPQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhfT0spKSB7DQog
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9GU19CSVRfVVBEQVRFX0ZBSUxFRDsN
CiAgICAgICAgICAgICB9DQogICAgICAgICAgICAgKmZscHRlcCA9IGZscHRlOw0KLSAgICAgICAg
ICAgICpmbHB0ZV9sZXZlbCA9IGxldmVsOw0KICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAg
ICAgfQ0KIA0KICAgICAgICAgYWRkciA9IHZ0ZF9nZXRfZmxwdGVfYWRkcihmbHB0ZSwgYXdfYml0
cyk7DQotICAgICAgICBsZXZlbC0tOw0KKyAgICAgICAgKCpmbHB0ZV9sZXZlbCktLTsNCiAgICAg
fQ0KIH0NCiANCi0tIA0KMi40NC4wDQo=

