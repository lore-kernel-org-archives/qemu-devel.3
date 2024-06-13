Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BD0C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgai-0000yv-2Q; Thu, 13 Jun 2024 05:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHgag-0000xu-2O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:17:54 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHgab-0004H8-Sq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718270270; x=1749806270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TrbBoBy+8jvcLAL1uRe+Fgahd9LKcuYWLZnACE6AkNI=;
 b=ZxoEjaLR95AKPXKjLm7QxWwK3O9kXgxhyOXmDALGkk6LJ47DY6scfslR
 L89eUqdr4feNxaM9GQZncrvL9mA3NlyYoXQ/VWc90zBDU7dE33WE3n+O+
 JRrYqkXQQhyl34TM7jGtNhAt/7eMAufVf6l5B7n/kalN9AHAoJFFpPcet
 WxN5n+w77ch/YOF6MEjYkEaAUuN/dQwMo242dX6iaCpadubM/V8pnTDEf
 QeU1KHK8r39qPovraExWJk6u4sXUo6Xp6pca31bYiVSsvG6Zpcn6XKlPR
 G6jcAKqWX/bCXD669n9ZJtLectu7piOXK89LZ86h8/Ijiy6scCNgZhzOb A==;
X-CSE-ConnectionGUID: Tj9kYjutSXe2ebqqIOnHCg==
X-CSE-MsgGUID: 3dGXcx1rTGS5WayciMK+KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25716676"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="25716676"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:17:46 -0700
X-CSE-ConnectionGUID: J7qIBR24Tdqa7iqzOLIEUA==
X-CSE-MsgGUID: HC/cwymkSmaptp06QZcq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="70870480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 02:17:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:17:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 02:17:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 02:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoXMtl52r6h4W2jVBVH4UO/2igjED/TPx51lw3WBiVZkbq1X5e1ta5GrqIpSCewQ6FDl8d4sq1cyy4Cl/FpPzxCWZ1G4WKMGe2KccYfyX6wgkhQE7X+vE3xoKzC9+r5Bboz3a8yDUk2X/XQ0X2zqtxEg7F/nljVnKSqfYxOs3DKksLUKhVR0pnyjYJppmUjc4k/qI9pwn9OR3xssmbHcoVWvv8fMb6sRq5iPjjUuXGoBvnrxY1lgg7mQVEt2aZVKW6frSLJXxGINR8neUfaQdF9avPH1jmN3dgCIIVS/0za1MfEZpAje7Aeqg6tdKgwK3KPetqXNalkVjQK20yH4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrbBoBy+8jvcLAL1uRe+Fgahd9LKcuYWLZnACE6AkNI=;
 b=cPPbLeQOv95QyddOJlV3btsVCfhSGcq/9BiDbqWNbFRBAi2G0IUpolpKtSZO9isbd9Y9c+bEBfmQQ1LHz8iT72QBht8xCjnqJXNrMW4DWvxVFDLSPU4Bct/3OrgdPeTXDK58J7Zlsdj5cLyVtAWExI80mzxDociKoSxskNtdVkciXfE5+BIoXkNHhcO+4bkEX7oD+P8w8f9JZfxD8ybPtXDhpfcFlZ2RpHYs/CNKmGkUsx7UHZaNyzaeH4i8aVkjxaRyr7HEWdklyb3U1F+qE55B5BFgGj7vFLhiDOS0WlKw2kvagWQUGy15xJkAraoLYT3L9mcgtRdsEoyOnDhJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 09:17:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 09:17:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 11/16] vfio/container: Change VFIOContainerBase to use
 QOM
Thread-Topic: [PATCH v1 11/16] vfio/container: Change VFIOContainerBase to use
 QOM
Thread-Index: AQHavMjmB93dDCp7Z0O3nx0fdjWGqbHFaq4A
Date: Thu, 13 Jun 2024 09:17:43 +0000
Message-ID: <SJ0PR11MB674436CD599BAA3FC4AD082892C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240612130122.813935-1-clg@redhat.com>
 <20240612130122.813935-12-clg@redhat.com>
In-Reply-To: <20240612130122.813935-12-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8720:EE_
x-ms-office365-filtering-correlation-id: 68c018df-a2e5-4fd3-38c2-08dc8b89ae78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?Y2NBbTNGVEJtYTRZYXV3Wk03RTRpNWFJMkRHYWtPdTZOSWcrbVJqY1ZBNFo4?=
 =?utf-8?B?alVMcDBpWDBmazFnRExxTzc0NmRHU0FodlRUNnlCQXlrRGFpMUZlOWN0b0V3?=
 =?utf-8?B?M1hjZHQ5bzhQeElOTmlEVWRrN1RPNWFxWGtGSTFqVEpJL0dlMkRLOFlQcW4x?=
 =?utf-8?B?NWl0cEJWUDRXY05JQ2dSWEdxdG9peXMvN25ZTzlISUFKc0ZqL1EzcUdITGRi?=
 =?utf-8?B?eWhiUFp5S0FoU2czM2pMSVpkMDJHalA3VzhGWStWZ1JKVlM4UHZYQkZPcXh3?=
 =?utf-8?B?Y3daeG44QXREaFVJanZPa0owUnYxd1o3Y2dWT2pydHZxbm5hT3hVZElWOFhC?=
 =?utf-8?B?YnplaEtMVktCMjJ1NWxKUnVKSUFSTkZGdGMxTHc0dGVZU2lKeWNFQm4vYmJq?=
 =?utf-8?B?NkZOejd4VWVFTUl4cEE4N1NDY1d6R00xNHQrRW5VVFp6SlpEVzJmZEFDSTlt?=
 =?utf-8?B?ODBrOWM4NmtBZXFMZE5WSzRPR0ZhWVlES2R0QjlUYlVHOFhERW1BeXRDRm90?=
 =?utf-8?B?Q2NRbFNwZitoRTBnYldwMTlBS2Qyd2t2QzBYNHNjelFIR3YxbHIrSHUwS2lS?=
 =?utf-8?B?VzdOQzgzcjBMT3RsS3pxRHJYczVrNmp2S05SbHRBWXVES0xGQ01kRUlCckMr?=
 =?utf-8?B?eDBSRnVPakxuendEZDZTdDRYL1JocWRRMEVPWjRtem1xSGE5VmZhTHIzMEly?=
 =?utf-8?B?RmdaTzN4SXdtUHZJNVZOd1ZibHBhbHZBeVhpa1VkSXE3WVJvYWpGeEdwSTBw?=
 =?utf-8?B?YVpoQU5kcyszWEVBUzh0eDgzWXNGeUxqRGZ3VmdwdjdTQ3pkMEFQam40c0tn?=
 =?utf-8?B?b011WUFXTEI1SXh2OVB6R2VxZ0g4QnBiU3NTRnIva0tsVUtBMHBpcGZRUVg0?=
 =?utf-8?B?a1h2SDIxeVFUL2hCdUNTMDh0bTBac3pHckpNTzM3QXFOSjRTU2tuV252bWhk?=
 =?utf-8?B?aTJVQU9tT0I4U0hyR0NGU3plSTYxd0tlY2tnRzhTRnExMUN1RWFSU2hpU3Vy?=
 =?utf-8?B?ZFJkVFFRNklCbGF6Z2ZWWW1JWXU1NTE0YmdlV1JrNGxsNHZiUGJaZ0NMZDFW?=
 =?utf-8?B?QXJtdU9reGRnOHhxNXFXcU5OQzVFc3R5b0hlTm1EZ0lDUXFRbkJqTmNiZzNl?=
 =?utf-8?B?ZW1qOURRU1RydkNDcFo4RFFQTm5DdHhpWW14Nm40NlJxQUR1QkFvTTFObnow?=
 =?utf-8?B?OFo0aHdTSmpZVGRCMGk4SHlydGtXc2t1d2pjdWwyYmtwWUo2blNpWDllUjRG?=
 =?utf-8?B?bWxIa2hnUFEvUE0vbkNYOTZlMEQ2K1Y0MFhBSXBsQyt6YUxYU1l3eEFKNnVI?=
 =?utf-8?B?Qm14OTlPSk8rQ1BYay9JNzZOVHZOcDVBLzJyRUYxOHFIOE10REZHbDllTDd4?=
 =?utf-8?B?MDRGcUxTWThSVTh4elV0M3d4L21LMFlPcy93TlFkenkxOHJvSUJxemdPMDBl?=
 =?utf-8?B?a2lYcGZLdFVpTzcyTURrVmxNRldMVXFoZFNoSUdnZ01BMERybWhPT1FUNDhX?=
 =?utf-8?B?dm04Y25RSGpocElmeFRZc2V2L1cza29JNVJ2dmh0TDZnbjhBdTR0WTNWVHNl?=
 =?utf-8?B?V1FnSldJY2FvMHlUVGxpOGVBYVRYVXh3aHMyRG4yQlFZUXM1Sy9zS0RJWGhl?=
 =?utf-8?B?SW9wOUFUc3FQV2Z2R2Z6djhabm04ZXBjWkwrZmRObUF0b1NNeFowb0dTZEhj?=
 =?utf-8?B?aFVRTzlIajd0RE01QTFkQlpZdktvanl6US9rMFE4dDBSQXVKQkF4S0ZvTTMy?=
 =?utf-8?B?dnJ2QjNsY0RieEZISTJ2cjJ0YzFXM0VXVzNFSFd6NnlIVzM3RzNHOFFaRER2?=
 =?utf-8?Q?dg6OKlCu5Y0uvhd94NaoKaC79ro6ejspjlhsY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpVc3lmaDlpM3hHdll6eWxlSnZUTWFpaDhxV2FmaFZ1b3BMd2N6VCthRGJV?=
 =?utf-8?B?UzgyNEl3dTBaSldGRlEwWlZsOTVUWm5QSWNWSjFLNHlJUHBZdDVDbW4zOWpi?=
 =?utf-8?B?eG5SS1FwcmVmYWVrbmsxNzZvYU1TcTV1dE0wTFIwMjIxNVBCbERhKzViTEcz?=
 =?utf-8?B?VFM2aDhXZDJKOVEvcWhLK0dTSFUwdVNqWW9GOHhvUWJ5REluNHk0NGhtRGk1?=
 =?utf-8?B?YXBnWmdKZ1U1UkxpVVQwY0U1dDBLRXE2cXAwd0oxMGxuTWxjU2JCYlFHSnNX?=
 =?utf-8?B?Y3diaDc5bE5VMTZ5Ry9MT2FxUDZkY2hJY25ZaHdpWWJRMlVCR1ducUhPSmRz?=
 =?utf-8?B?SDgvOXhseTlXQ1p0RDlaYXZWYnJyaXY3T3BJVWRGbXNEby94c2xkQVVVbmtz?=
 =?utf-8?B?Ums4MDlQVTVYdTFwRVNaZHJIdXBGWFZoVDE0NlJZVnJNako2WksxQVNOVVJZ?=
 =?utf-8?B?OFAxaHl4dXZlbDdSRlAvVE51QnQ0UUl2eWs5aUJUVXNBYjRteDZjbENEemtz?=
 =?utf-8?B?d0pBbGpQR3YvUyt0NlBmeUZKbm9lTUhKUGp6alZ5STlVR0NyeXRSQXVmV1JF?=
 =?utf-8?B?TUhvalBFMkFrNlZNUktmNkR6WjNzM2FIak9QNzhoamF4SmdiRkhyVTRrbWcr?=
 =?utf-8?B?NW1POUlXWVlQVVlnM09maC9zVGpMZkdxZlJ4RnhRemdnZS9Edjd4Z2ZPRzFJ?=
 =?utf-8?B?V21pUzg1VndXVTJ2L1RvaVFhbTlDeEpxaHlsME9kS1g5V2IwOS9UL2xWbHV2?=
 =?utf-8?B?Y085VWRwd2pOcHFyMGN1UFp5ekxUeGZzU3FSaThCbS9qZnRaSVdnY2RVTVlp?=
 =?utf-8?B?WGNwTVgrZk01MHoyRGxYUFllaFpybm1PTUxKVkNEam52SmQyd0R3Tk93cmRz?=
 =?utf-8?B?UmN5ZXRjUUhweVdtV3VrdWdiVU85SDFXdlZHUzBPay9YRExnbEJncjBxSTB0?=
 =?utf-8?B?RzhaaytOQ2VPVkRqU2FCcHlyMm83Vy9Id2pmbTdCWWovWEQvRUNIV2ZvOG9S?=
 =?utf-8?B?TXNWSFBlV05vcEhFNFgrdGJSOWM4bGlMM3RyaXkyWFB4UTZKbmlQNFFHVVFQ?=
 =?utf-8?B?N1pzUGl1alVIeWRZSXdwU2hNaXQzR1Nzck1Hbmo3dnd3UG5BMnNiYThaZC9T?=
 =?utf-8?B?d1RleEJoY1R2T1pJSTJCWW5VRDZiYzBZVFA1TW92Y1A2aUtmeVVzazR6YXZH?=
 =?utf-8?B?cE15eDg0cGtWYW94aytjUkkvZS8rL3JINTJHbXo5STM3K1lzK0h1S1h3SVFm?=
 =?utf-8?B?WngrZDd5cmxNb1poZDdJMWN0Umx2MlhNUW9SUlhIenJxOWlNSEhoWk90NWhE?=
 =?utf-8?B?UzNPbVRYL3NZRjQ1Rjk5Qm5QRlZJV1RPS3VTcXQzV1lRYkRWVVVhSVBaRk9O?=
 =?utf-8?B?SjF5U3NXU2cyNUc5UHlUVWxNN0FTNExUZUdoN2cwbUFSS21mUlNOMVNFaS9J?=
 =?utf-8?B?S0NUZVIrdXJXckM0NU9RaVY2aUNRM3NRRFFGQkF6eC8xMnkvTkl5SDhXc2Ny?=
 =?utf-8?B?UTF2U0NGNlJ2VGhJSnZJWEFhUW9LU0JlWE9rR3NhVHN2MkN6aTZoSTI1VTJJ?=
 =?utf-8?B?NmZzQmY1TFJKcUJuVG5JblpNak1oSTYvbWFycDNSUDZPVE5NMXN6ODVCdFkx?=
 =?utf-8?B?Q0o4OVdLODEvamI3bTdoWFFCVU9rNEhVYnZMSWhzdllza0kwM3poSEs2N1A2?=
 =?utf-8?B?Y3Jyc25TZ2srY2FqNFdlV1dNRjY2cHo3WThDQW93YkVPNjI4TEV4aXhObmtW?=
 =?utf-8?B?V3RLODdKYTVmVS8xNmY3Q1Y4WW5vWFowR05VVHUrTU1UcjhXeUNCTzRPbG5Q?=
 =?utf-8?B?Sm5JR1JVdnVyNHk5UHZJdmcrSlQ0QXFuQTlaNVZmSXZEMzRld1ZXWEF1cFVC?=
 =?utf-8?B?LzYxTTNhbUZTUnBwT2hBNWFKV21hQVVPNTBreHI4STZVSjlJUW9VQlNmVEVl?=
 =?utf-8?B?K0dyWkRER1FqTk5xTFFMUnBVQUdkYUZWaEd6V1V0NWtZOTVBTG9XYUxJZC94?=
 =?utf-8?B?Z05Ba29RZjN0RTJ2RW1QRkRxbUFGU3lEWDh4eFVvaVBWa09BQkdFMGY1MTRC?=
 =?utf-8?B?YklCVmN1QjNmcC9rZmZXWUdtdFBqNEkzNWowNGY0dWZYRVpGS0VLbXkybU9C?=
 =?utf-8?Q?BRY2jm/1XA4oY9Ms7AMCqAVWV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c018df-a2e5-4fd3-38c2-08dc8b89ae78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:17:43.3297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vF0QIX9nUUGUBa+ch5l50ZViDAjY8bHN1sJx954QCgiS7y8pgWx9zlZsxV2atmx5zXMWbgJkXaAOfj+UFiF0CiOGcSAlFW8/ixvBydVdVo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2MSAxMS8xNl0g
dmZpby9jb250YWluZXI6IENoYW5nZSBWRklPQ29udGFpbmVyQmFzZSB0byB1c2UNCj5RT00NCj4N
Cj5WRklPQ29udGFpbmVyQmFzZSB3YXMgbWFkZSBhIFFPTSBpbnRlcmZhY2UgYmVjYXVzZSB3ZSBi
ZWxpZXZlZCB0aGF0IGENCj5RT00gb2JqZWN0IHdvdWxkIGV4cG9zZSBhbGwgdGhlIElPTU1VIGJh
Y2tlbmRzIHRvIHRoZSBRRU1VIG1hY2hpbmUNCj5hbmQNCj5odW1hbiBpbnRlcmZhY2UuIFRoaXMg
b25seSBhcHBsaWVzIHRvIHVzZXIgY3JlYXRhYmxlIGRldmljZXMgb3Igb2JqZWN0cy4NCj4NCj5D
aGFuZ2UgdGhlIFZGSU9Db250YWluZXJCYXNlIG5hdHVyZSBmcm9tIGludGVyZmFjZSB0byBvYmpl
Y3QgYW5kIG1ha2UNCj50aGUgbmVjZXNzYXJ5IGFkanVzdG1lbnRzIGluIHRoZSBWRklPX0lPTU1V
IGhpZXJhcmNoeS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+DQo+LS0tDQo+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAg
fCAgNCArKysrDQo+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggfCAxMiAr
KystLS0tLS0tLS0NCj4gaHcvdmZpby9jb250YWluZXItYmFzZS5jICAgICAgICAgICAgICB8ICA0
ICsrKy0NCj4gaHcvdmZpby9jb250YWluZXIuYyAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4g
aHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gaHcvdmZpby9z
cGFwci5jICAgICAgICAgICAgICAgICAgICAgICB8ICAzICsrKw0KPiA2IGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1v
bi5oDQo+aW5kZXgNCj44MjVkODAxMzBiZDQzNWZlNTA4MzBjOGFlNWI3OTA1ZDE4MTA0ZGQ2Li41
ZDBiODQ5NmNmODViYWM4ZDRlYQ0KPjc3MGZhZTA0YWNjMDJkODRkZjgyIDEwMDY0NA0KPi0tLSBh
L2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tY29tbW9uLmgNCj5AQCAtODQsNiArODQsOCBAQCB0eXBlZGVmIHN0cnVjdCBWRklPQ29udGFp
bmVyIHsNCj4gICAgIFFMSVNUX0hFQUQoLCBWRklPR3JvdXApIGdyb3VwX2xpc3Q7DQo+IH0gVkZJ
T0NvbnRhaW5lcjsNCj4NCj4rT0JKRUNUX0RFQ0xBUkVfVFlQRShWRklPQ29udGFpbmVyLCBWRklP
SU9NTVVDbGFzcywNCj5WRklPX0lPTU1VX0xFR0FDWSk7DQoNCldoYXQgYWJvdXQgdXNpbmcgT0JK
RUNUX0RFQ0xBUkVfU0lNUExFX1RZUEU/DQoNCj4rDQo+IHR5cGVkZWYgc3RydWN0IFZGSU9Ib3N0
RE1BV2luZG93IHsNCj4gICAgIGh3YWRkciBtaW5faW92YTsNCj4gICAgIGh3YWRkciBtYXhfaW92
YTsNCj5AQCAtOTksNiArMTAxLDggQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1VRkRDb250YWlu
ZXIgew0KPiAgICAgdWludDMyX3QgaW9hc19pZDsNCj4gfSBWRklPSU9NTVVGRENvbnRhaW5lcjsN
Cj4NCj4rT0JKRUNUX0RFQ0xBUkVfVFlQRShWRklPSU9NTVVGRENvbnRhaW5lciwgVkZJT0lPTU1V
Q2xhc3MsDQo+VkZJT19JT01NVV9JT01NVUZEKTsNCg0KU2FtZSBoZXJlLg0KDQo+Kw0KPiB0eXBl
ZGVmIHN0cnVjdCBWRklPRGV2aWNlT3BzIFZGSU9EZXZpY2VPcHM7DQo+DQo+IHR5cGVkZWYgc3Ry
dWN0IFZGSU9EZXZpY2Ugew0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29udGFpbmVyLWJhc2UuaA0K
PmluZGV4DQo+ZDUwNWY2MzYwN2VjNDBlNmFhNDRhZWIzZTIwODQ4YWM3ODA1NjJhMS4uYjA3OWI3
NmY2ODk3NWM1NzAxYTI4DQo+OWNlOTAxMmU5MTJhOGU0NGZjNiAxMDA2NDQNCj4tLS0gYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+KysrIGIvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPkBAIC0zNCw2ICszNCw3IEBAIHR5cGVkZWYgc3RydWN0
IFZGSU9BZGRyZXNzU3BhY2Ugew0KPiAgKiBUaGlzIGlzIHRoZSBiYXNlIG9iamVjdCBmb3IgdmZp
byBjb250YWluZXIgYmFja2VuZHMNCj4gICovDQo+IHR5cGVkZWYgc3RydWN0IFZGSU9Db250YWlu
ZXJCYXNlIHsNCj4rICAgIE9iamVjdCBwYXJlbnQ7DQo+ICAgICBjb25zdCBWRklPSU9NTVVDbGFz
cyAqb3BzOw0KPiAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7DQo+ICAgICBNZW1vcnlMaXN0
ZW5lciBsaXN0ZW5lcjsNCj5AQCAtOTYsMTcgKzk3LDEwIEBAIHZvaWQgdmZpb19jb250YWluZXJf
ZGVzdHJveShWRklPQ29udGFpbmVyQmFzZQ0KPipiY29udGFpbmVyKTsNCj4gI2RlZmluZSBUWVBF
X1ZGSU9fSU9NTVVfU1BBUFIgVFlQRV9WRklPX0lPTU1VICItc3BhcHIiDQo+ICNkZWZpbmUgVFlQ
RV9WRklPX0lPTU1VX0lPTU1VRkQgVFlQRV9WRklPX0lPTU1VICItaW9tbXVmZCINCj4NCj4tLyoN
Cj4tICogVkZJT0NvbnRhaW5lckJhc2UgaXMgbm90IGFuIGFic3RyYWN0IFFPTSBvYmplY3QgYmVj
YXVzZSBpdCBmZWx0DQo+LSAqIHVubmVjZXNzYXJ5IHRvIGV4cG9zZSBhbGwgdGhlIElPTU1VIGJh
Y2tlbmRzIHRvIHRoZSBRRU1VIG1hY2hpbmUNCj4tICogYW5kIGh1bWFuIGludGVyZmFjZS4gSG93
ZXZlciwgd2UgY2FuIHN0aWxsIGFic3RyYWN0IHRoZSBJT01NVQ0KPi0gKiBiYWNrZW5kIGhhbmRs
ZXJzIHVzaW5nIGEgUU9NIGludGVyZmFjZSBjbGFzcy4gVGhpcyBwcm92aWRlcyBtb3JlDQo+LSAq
IGZsZXhpYmlsaXR5IHdoZW4gcmVmZXJlbmNpbmcgdGhlIHZhcmlvdXMgaW1wbGVtZW50YXRpb25z
Lg0KPi0gKi8NCj4tREVDTEFSRV9DTEFTU19DSEVDS0VSUyhWRklPSU9NTVVDbGFzcywgVkZJT19J
T01NVSwNCj5UWVBFX1ZGSU9fSU9NTVUpDQo+K09CSkVDVF9ERUNMQVJFX1RZUEUoVkZJT0NvbnRh
aW5lckJhc2UsIFZGSU9JT01NVUNsYXNzLA0KPlZGSU9fSU9NTVUpDQo+DQo+IHN0cnVjdCBWRklP
SU9NTVVDbGFzcyB7DQo+LSAgICBJbnRlcmZhY2VDbGFzcyBwYXJlbnRfY2xhc3M7DQo+KyAgICBP
YmplY3RDbGFzcyBwYXJlbnRfY2xhc3M7DQo+DQo+ICAgICAvKiBQcm9wZXJ0aWVzICovDQo+ICAg
ICBjb25zdCBjaGFyICpoaW9kX3R5cGVuYW1lOw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRh
aW5lci1iYXNlLmMgYi9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj5pbmRleA0KPjI4MGYwZGQy
ZGIxZmMzOTM5ZmU5OTI1Y2UwMGEyYzUwZDBlMTQxOTYuLjk4YzE1ZTE3NGRkNzhkZjUxNDZlZTgN
Cj4zYzA1Yzk4ZjNlYTljMWU1MmMgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb250YWluZXItYmFz
ZS5jDQo+KysrIGIvaHcvdmZpby9jb250YWluZXItYmFzZS5jDQo+QEAgLTEwMiw4ICsxMDIsMTAg
QEAgdm9pZCB2ZmlvX2NvbnRhaW5lcl9kZXN0cm95KFZGSU9Db250YWluZXJCYXNlDQo+KmJjb250
YWluZXIpDQo+IHN0YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBlc1tdID0gew0KPiAgICAgew0KPiAg
ICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1VLA0KPi0gICAgICAgIC5wYXJlbnQgPSBUWVBF
X0lOVEVSRkFDRSwNCj4rICAgICAgICAucGFyZW50ID0gVFlQRV9PQkpFQ1QsDQo+KyAgICAgICAg
Lmluc3RhbmNlX3NpemUgPSBzaXplb2YoVkZJT0NvbnRhaW5lckJhc2UpLA0KPiAgICAgICAgIC5j
bGFzc19zaXplID0gc2l6ZW9mKFZGSU9JT01NVUNsYXNzKSwNCj4rICAgICAgICAuYWJzdHJhY3Qg
PSB0cnVlLA0KPiAgICAgfSwNCj4gfTsNCj4NCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWlu
ZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj5pbmRleA0KPjk4MzcyNmY5NTE0ZWMxMTA2ZDUy
MWM5NzExYTQ2YTQ3ODA2ODhlZTEuLmYxNTE5NTE4ZDBiN2VmZDJhNjA4Ng0KPmYwN2JjNDk3NTk2
YTUyMzZhYmYgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPisrKyBiL2h3L3Zm
aW8vY29udGFpbmVyLmMNCj5AQCAtMTE5NCw2ICsxMTk0LDcgQEAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIHR5cGVzW10gPSB7DQo+ICAgICB7DQo+ICAgICAgICAgLm5hbWUgPSBUWVBFX1ZGSU9fSU9N
TVVfTEVHQUNZLA0KPiAgICAgICAgIC5wYXJlbnQgPSBUWVBFX1ZGSU9fSU9NTVUsDQo+KyAgICAg
ICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoVkZJT0NvbnRhaW5lciksDQo+ICAgICAgICAgLmNs
YXNzX2luaXQgPSB2ZmlvX2lvbW11X2xlZ2FjeV9jbGFzc19pbml0LA0KPiAgICAgfSwgew0KPiAg
ICAgICAgIC5uYW1lID0gVFlQRV9IT1NUX0lPTU1VX0RFVklDRV9MRUdBQ1lfVkZJTywNCj5kaWZm
IC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4DQo+
ZDk3YTRmNzM5Mzc5MTY2MGI5MGUzNDA0MzZjNmUwODRjMDc4MTQ0NC4uODBiYTA5Yjg1OWEwMmJi
ODk4MjMNCj40NjAwNjRhOWYwOTlmZDk4Y2ZmMCAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2lvbW11
ZmQuYw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTY3MCw2ICs2NzAsNyBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gdHlwZXNbXSA9IHsNCj4gICAgIHsNCj4gICAgICAgICAubmFtZSA9
IFRZUEVfVkZJT19JT01NVV9JT01NVUZELA0KPiAgICAgICAgIC5wYXJlbnQgPSBUWVBFX1ZGSU9f
SU9NTVUsDQo+KyAgICAgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoVkZJT0lPTU1VRkRDb250
YWluZXIpLA0KPiAgICAgICAgIC5jbGFzc19pbml0ID0gdmZpb19pb21tdV9pb21tdWZkX2NsYXNz
X2luaXQsDQo+ICAgICB9LCB7DQo+ICAgICAgICAgLm5hbWUgPSBUWVBFX0hPU1RfSU9NTVVfREVW
SUNFX0lPTU1VRkRfVkZJTywNCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9zcGFwci5jIGIvaHcvdmZp
by9zcGFwci5jDQo+aW5kZXgNCj40N2IwNDBmMWJjY2E3ZGQwYjVjZjA1MmQ5NDFiNDM1NDFlOThh
M2M1Li4wNWEzY2VkYzRiMTcwM2E2MTU3MzcNCj4zMGJjNzdmYzE1ZDQ0ZjdhOWViIDEwMDY0NA0K
Pi0tLSBhL2h3L3ZmaW8vc3BhcHIuYw0KPisrKyBiL2h3L3ZmaW8vc3BhcHIuYw0KPkBAIC0zMCw2
ICszMCw4IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9TcGFwckNvbnRhaW5lciB7DQo+ICAgICBRTElT
VF9IRUFEKCwgVkZJT0hvc3RETUFXaW5kb3cpIGhvc3R3aW5fbGlzdDsNCj4gfSBWRklPU3BhcHJD
b250YWluZXI7DQo+DQo+K09CSkVDVF9ERUNMQVJFX1RZUEUoVkZJT1NwYXByQ29udGFpbmVyLCBW
RklPSU9NTVVDbGFzcywNCj5WRklPX0lPTU1VX1NQQVBSKTsNCg0KU2FtZSBoZXJlLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo+Kw0KPiBzdGF0aWMgYm9vbCB2ZmlvX3ByZXJlZ19saXN0ZW5lcl9z
a2lwcGVkX3NlY3Rpb24oTWVtb3J5UmVnaW9uU2VjdGlvbg0KPipzZWN0aW9uKQ0KPiB7DQo+ICAg
ICBpZiAobWVtb3J5X3JlZ2lvbl9pc19pb21tdShzZWN0aW9uLT5tcikpIHsNCj5AQCAtNTQ4LDYg
KzU1MCw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBlc1tdID0gew0KPiAgICAgew0KPiAg
ICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1VX1NQQVBSLA0KPiAgICAgICAgIC5wYXJlbnQg
PSBUWVBFX1ZGSU9fSU9NTVVfTEVHQUNZLA0KPisgICAgICAgIC5pbnN0YW5jZV9zaXplID0gc2l6
ZW9mKFZGSU9TcGFwckNvbnRhaW5lciksDQo+ICAgICAgICAgLmNsYXNzX2luaXQgPSB2ZmlvX2lv
bW11X3NwYXByX2NsYXNzX2luaXQsDQo+ICAgICB9LA0KPiB9Ow0KPi0tDQo+Mi40NS4yDQoNCg==

