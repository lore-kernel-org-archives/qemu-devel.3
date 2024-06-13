Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E96C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgdA-0002ki-E8; Thu, 13 Jun 2024 05:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHgd9-0002jH-6e
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:20:27 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sHgd7-0004qn-1q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718270425; x=1749806425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KDI0y8kx8oYhD00+Sn6MWA/alzN9JPR8ZTxugRRPngY=;
 b=kEjZdPz5Mwr0qO03HrUq2B+V/2Q3j7OqUedIEis5gt2jek3prGNSLkJa
 f8AeEHkORK6XUYmIAjndXvTLxeV48puIiTLZPVSdEj/8vDgLOYlPBsjG6
 II435vPYvKeasJVeAKfgxX0hS4nHBKOhQ2QyiOrNL6d2BN+IqSGpMnPxs
 fl2fAiRCNVsdj0XojJxqYZYU7IzaKXOzFvmbM+5Vs5/lk/EC1Ru5iqhE7
 y97qd95gCTcc+qPzGMarKzmmiR77TzlybRDEoMmz4xrUcJVRBepeDoDnA
 RYPq8xv8G/iAumuMF12lXhtpkQvHaHv21jLV+I3/G7ZlGzlYxvB9K8PPj Q==;
X-CSE-ConnectionGUID: U9Jfjpa3Sf+faJCeKCIO2w==
X-CSE-MsgGUID: g0y8tXCDRsW6bujO+MmLpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26500163"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="26500163"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:20:08 -0700
X-CSE-ConnectionGUID: GYASGJd6REmm4MOFfh1e7Q==
X-CSE-MsgGUID: PKcTTAA+Rzib614uZ9Ov8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="45204478"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 02:20:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:20:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 02:20:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 02:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLXSVNSEeBJR0rTP1ALx7V6Y6QYpunz+1YHsUXKkeShxet09hMVaezoVCKfrLOt+LaOqypfz5jsixB5Wz/rt2cPqeWnREHx9bCZtktGlU+2PhigRG8QxcmClX1YQe0gLFWm5y9N4Ktj6/vDqxEKNMvNvnTQ4t/KBZ/lFM6Z0y2s9IElXWmeXv9iT+1jErUFiep9XZrqWlYrvE01Sko+wdT5L7gWD1L5RYGClolYA0SZ/9neBgG7X4PBhacMufELhsTXABAk47ZOc4f68Gb04QCQupks3XxiHSOpkTV4A6nnZxFWpy23pTmvFPAZejvE5BTSPAuG90OWTq+88bNvBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDI0y8kx8oYhD00+Sn6MWA/alzN9JPR8ZTxugRRPngY=;
 b=Duv2mzKErVyr9jUoxaDmvPZ/4JZa61RrF1/3vRQFWxETYrv50DfU29KqfbQjWLCbWt/gn4F2cfPrr3t+yB5Bo4rRZITRRH/Oj9kdy9MO2OPaYiXwsL5GM0qEZ5aCVM0WRKLzqx4hOy4QzwlWTGdRFndn0ta0uhtMB2nRfQnaNy1wrHY9W01XqqVaAhfW0d+zbR30IKNG/LN8chIjdoe4KtH3E62uLmxvN+el10iRMY3WPVC6my4sdgVk1YMLpp9Jk/W51BE/taRjU9gUuGSoaeDde6+oH6TfNr/LrsHdbNy0isKK3xUQ6lWS96MQX/OTTXfCidx+9GGd3z67p5v03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 09:20:02 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 09:20:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 15/16] vfio/container: Remove vfio_container_init()
Thread-Topic: [PATCH v1 15/16] vfio/container: Remove vfio_container_init()
Thread-Index: AQHavMjS+NsUZLFpgECYkGtY60mw27HFa9bA
Date: Thu, 13 Jun 2024 09:20:02 +0000
Message-ID: <SJ0PR11MB674417EA5535737259F15DE492C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240612130122.813935-1-clg@redhat.com>
 <20240612130122.813935-16-clg@redhat.com>
In-Reply-To: <20240612130122.813935-16-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8720:EE_
x-ms-office365-filtering-correlation-id: df7cb7ca-1fb0-4f9d-acd6-08dc8b8a019e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?dDB0bTVROWJndmRlM3BzeEs3Q1U2cjdvd3RkdWVERHNlbDdraWtFYnZkTFFU?=
 =?utf-8?B?SVEwamt3cVRFbFM5VGQ1NmFRU0NhbXV3a1lOMzJmeHNZdWIwUkE5RjM0VGlu?=
 =?utf-8?B?S1lNMW0wVEVSbWVGRlZqcjRDc3RFQmpOdmhlOGNRcmx0R0U0VjlMTjlnUmxj?=
 =?utf-8?B?NXlwNTBzWjFBbzlnUFpPUm9LcmxkZFhPQmsxSDVPQmtWWE1MNklLRDF1bGI4?=
 =?utf-8?B?RFRGbzBrY2VTL2NCRFgvcjZtSlkzNUdLOGEwWGsxOFYybUcwbHA1djQwT3Z4?=
 =?utf-8?B?ZWJ1blZZQmNqQ1BNaGMyb2sxUXZPcCtVWGViN2R2YklyZkFqUWhhdVdrYStT?=
 =?utf-8?B?b2owUVA2ZDFoazlwcGNKdUhMalM3ZXZoYnlva3BUd3c2N3kyR3hsZEhDdW9O?=
 =?utf-8?B?WkR2NmdRSDBvV29Sa3pKNFcxNDNQSWU3YS8wTGYyMVlhbHhVOU5vWU9ZRDU4?=
 =?utf-8?B?OVByU3NBOEZSR21rRFNxdCt3c0ZtL2Fkb3JxdFdZSWFsZnpZTWZNZEUyNmxp?=
 =?utf-8?B?SVI5aElGTnNqazY1OEJzV3JFeW5VcGRGRGIzZEVrdGN6V3ZaY3NiN2ZaM1Bk?=
 =?utf-8?B?aW4yUkZ3NlJEUGo5L2lWYS8ydndSUTAzejV5WGhidEVuNG1kVTNFQm5SN2Rr?=
 =?utf-8?B?NWhFYW1SeHFwVWczWWNIWDZueEIvMmF1MGxmM2p5OExCejBCcjc4YkluL1lm?=
 =?utf-8?B?dmxLbkxvbkxXQlM1U2JYc2hLYjRuRitqZlVWU2lGOVVmUUliNUNyVjE5SzJ3?=
 =?utf-8?B?UlNjbU9WTEhpZVF6TEJsYVNxQVR2RXNJWXZQMElyRlpIdXlJZm5QZUd0OUVE?=
 =?utf-8?B?UllUNDVNbGJ5RklHWG11RWlodExXK0NFbjNWelYwVW1GMWVaUUhObzRlOWZU?=
 =?utf-8?B?cUdoblVVRTF3ZSt2dHk1aWtqZzZ0bDNKcmJNVFp4V1RQS1l4UlpSM01vNng5?=
 =?utf-8?B?b1JmOGRpVDBHeEVkSVl2SXNGc2dzRnJkL2Y2R2FQaVNlWE5ieHBNNjc0REtl?=
 =?utf-8?B?QUl3RU11eXFYc1hnYWhuUmNPcEx2U1NncFh1MG1jZkpvSW1HWVlMc2lRb2ow?=
 =?utf-8?B?b2NpOGRCWG91MkF2QW5qd1I1S3A2bnJlM05XSkNVQkR3WWtVbFF3dWhOY3Ja?=
 =?utf-8?B?Q0hjRUFaaGtVdlB5SFgrNU5PanBRUzh2ZFU3NVNTRXFaeHRxY0tacEkxOVBB?=
 =?utf-8?B?Y1I3RHQ3WjBqOGw0c3Rrdzc1WnAzekUxQ2FvbkZScDRyZkd4NHZyQ1Y2d3U3?=
 =?utf-8?B?dTVST0VFeXdjMCtsTGtQL0Y0c3VKT1Q1RmtiMlhyaysxSklCRFlhQWNHTUF4?=
 =?utf-8?B?dzh4Mk5OYkUrRzdJUTFuMGt1SHhKTXVlRXhPeWM0UURONTVaUS9iRm1xNDBm?=
 =?utf-8?B?RUY4cmt2Rm1BR1BpNXJGRlFXR251Z29hWlMraFlEQUFVbk5CeXIwaHJ3MXU1?=
 =?utf-8?B?aXhxcEVJTjNWVVIzOGlNVGxRTUFtSG1aNUpLZ2ZGVmF0dFdydUVkNWl2WVZk?=
 =?utf-8?B?bjJxOWwrUDFMS21DSUlhdTRsNlpJaXlLM2dqaC9HZCtGZ3pTamtoSEg3cHEr?=
 =?utf-8?B?c0RlRGhEcGFDVC9LSE84VVZhcmU5eXoyTEdMcW1JRmtmcXNKVWZkSWNlTkhI?=
 =?utf-8?B?dEc4dWtsV2czamk3SHpaRHM4S204alBGUmo1UmZ4c25aamk3enVmUGRBMDNO?=
 =?utf-8?B?OW40MWtzWFRzQzBHZFVnUXdNV0V1aE51OTZlaGpFN052dWZvKzI2V0l5ZGYv?=
 =?utf-8?B?eHdQa3Q5V085MzI5K3RmOW9nVTRwaElkRlNCaGlJdEVQZDRFNytXSE1wODlv?=
 =?utf-8?Q?9Qe55ghjG0Pt59jMom39HOHs3JdQKdTDbsRkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVZXYm1rS1B1TFFHNm5udzVCT2dSZEdXcmNnd1M5UHQ1a0xyL0pvWVVhcGdy?=
 =?utf-8?B?V2YwUUNqck9pVk1HOUxtL3UwSU9EYjZUNHMwVE5IZWJyNGdROUNpQ3J6bUdM?=
 =?utf-8?B?aGtQaC9zQkR2UkVDVVlYUHdnb01sTTNQTGVoMWNrM1YxaEFBa29hSnEvWjhy?=
 =?utf-8?B?TktjbmQxUzFBZ0RRNXNneVJnaU1xNWwyaXNKam5hYVRYWDAxRStKZjRFZk4x?=
 =?utf-8?B?dzZLTkRNZUpCOWs3T1RENUhUWEdLZ09Va3RvbWFPSzlCUFhGalJQWm1mZ3pL?=
 =?utf-8?B?TTl6bHlOWGJCZkFML1FUUkpwUEZYWTVuRnVmMzZ3MmZialphQjdvbTEvZFJ1?=
 =?utf-8?B?bHRBVXpnMlJEcG1pUU00STlZeDYvdmhaa0ZLOGp3ZVFzMkJrRkJac3huNVFn?=
 =?utf-8?B?ZXhtWVlDYUtWV2hoYjU5RFNaY3ZkaFJmcU9Kci9hN29ZQjc0L1dERXdCV1BS?=
 =?utf-8?B?ZGhOb2I3dllNbWNQLzhPMFBrSVRIdG1Yb1ZWZ2JKdGtCNTFjRDVYZEgwZlI2?=
 =?utf-8?B?NW96NkNJeFRjZ2VvMGI3VGNkbU1TNkwxNElDN3B5Z01hY2dDWXlkTG9hQ1Bn?=
 =?utf-8?B?a2xvU29iT2s4UXpWdU4yazB0M1JTall4b0k3UXFiM01GbjBIMDdmY2VvenJ2?=
 =?utf-8?B?RFNUak4yMHNvalBxa2k2SWczRXdrMkpLU3piWmNsY2U4eHZTK2txSVJJSE1E?=
 =?utf-8?B?TVRmbmZkalh4bGM3OUVsSkw0UXdRalhQUDhpQi9WM2xLWFdtb0dKR3pZTFVh?=
 =?utf-8?B?U3FZZEwvaWRBeUpHM25xYzhTWWtMbjEyQktSNkdwUHhCdk43Mzc3UW9YQ1Qx?=
 =?utf-8?B?OEpyckdiS3JWcG5Bc2lHRUQyL2dBRThmb2FTRytzZ1BwVzJNZmhBZ1dzbkhq?=
 =?utf-8?B?RzFjWnZ1bitHbTd6ZDAyTGVQMHZVYm5wVzBwV1k4Sk81aEFCa1Y5UjVvNFdz?=
 =?utf-8?B?Y3dFUEZRa1JQSUxUdXphN1B6UTVaOTUxSlpZSmNlVnlQUGdrS0hzMmhsQTdr?=
 =?utf-8?B?bDg3SVJMYTRMUGFreVNETGgwOFhYU0dPSmZ2clAxQnlJTC84akpaSUQ0VDY4?=
 =?utf-8?B?YXQ4ZXU0cDM3bXV4NVorTmV0VGhBMzdwSGkweHF1VWtEdmxJYUlxT2ZFbCsv?=
 =?utf-8?B?Wk1nczBMYys1dERhMndPVTdlQW1IeWJQeVFEK1YvWkkwRVBtUi9POXQxL3Bs?=
 =?utf-8?B?OEV0TjJyeUtpRFFYdnovZDR2MFhvb29VbjB1cWhNclRmR2JwUkZmcmR5ZFBj?=
 =?utf-8?B?U3lvUGRaYzd3QkRoRTVFY2ROSWUwQml1Nmlic05KNkxPRkdQeGg1ZUVLZnFU?=
 =?utf-8?B?SjVmRER1REpzWmczM0pCTUFidWluTzJmalc2SUJCbUJhenplOEpjaG13WDVh?=
 =?utf-8?B?UEk2cTR0M2ZWWUlhcGxpaU8xN1hVMXA0Zzd3QnVRcldOb01VcjU1MmMwRDJL?=
 =?utf-8?B?WG5YcUxlblRmNDQ0bFJJNHhaeHQwalUxK3hjR1FVREJxZ21DK1VBTHBCeklj?=
 =?utf-8?B?NFBCUGlxbmRCcmJ0MlRqZCthMHNaVlUxcjBHcUFHcm4rSFpvR2VmYlN0VVgy?=
 =?utf-8?B?Yk42NVRacmpla0V0N2Q0ZlZxVUFYSDVZUEc2b21TVTN3VSswWnVBM3ZXUm0y?=
 =?utf-8?B?NmRmNWpmOXl6V1VUYmpiTHViSjRuRjAwVlBoUTNRUzM0d3NLZ3ZlOFU1eW41?=
 =?utf-8?B?MnlQckJFNmZ5bTRpNnlET2kvcUhSRnJMV29mOTZFcGxhQ2JRdWRtejdnSUI4?=
 =?utf-8?B?bjgwdmtkMlRqZU9xNDFhUnlLODdOZGFrbW45SkorN2gvSlZxOFY4U0dGcjBM?=
 =?utf-8?B?eVdwZDRVSHhsaEhyb2sycURCaTRqWWNCVE5UVk5aWXJ2b2VSb3lxTGpWTnJW?=
 =?utf-8?B?OG0vdVRLdENEWkFZRmVvbHludkJCdVNWYXZad3hUYjRYZTVNWkhJbTN5dWha?=
 =?utf-8?B?SW1VblFxMzlzWHdUbTh2cXo5UlBPZ29BSGd4emVQMXg0MWFNb3oyVHpIWG8v?=
 =?utf-8?B?WDJPYzBoeDdjWjdJMVBsdE84OGZBTVZJdjZISXpyY3Y0SzUvYjJJOEhlZVJu?=
 =?utf-8?B?amxMd0NIWjVvUnE2bmpVbjhFUS9qRG16QjNHdlV2OGNUN3dJUm9mbEFCODQz?=
 =?utf-8?Q?SFvXCH9hQo4yZhUNqZDYyAuxV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7cb7ca-1fb0-4f9d-acd6-08dc8b8a019e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 09:20:02.8656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bY0S94sAPnqozFwQJSDJSMtNbmY6RAOpYySI0Qy7Ov0pyXEjoF+w4chnBY/KHnBsTyW/O1nBKQsOcCDXKGmDmeSef7fUzVn1vjKZFWyv38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjEgMTUvMTZdIHZmaW8vY29udGFp
bmVyOiBSZW1vdmUgdmZpb19jb250YWluZXJfaW5pdCgpDQo+DQo+SXQncyBub3cgZW1wdHkuDQo+
DQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPi0t
LQ0KPiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIHwgMiAtLQ0KPiBody92
ZmlvL2NvbnRhaW5lci1iYXNlLmMgICAgICAgICAgICAgIHwgNSAtLS0tLQ0KPiBody92ZmlvL2Nv
bnRhaW5lci5jICAgICAgICAgICAgICAgICAgIHwgMyAtLS0NCj4gaHcvdmZpby9pb21tdWZkLmMg
ICAgICAgICAgICAgICAgICAgICB8IDEgLQ0KPiA0IGZpbGVzIGNoYW5nZWQsIDExIGRlbGV0aW9u
cygtKQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFz
ZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29udGFpbmVyLWJhc2UuaA0KPmluZGV4DQo+
NmI1N2NkOGU3ZjVkN2QyODE3ZjZlM2I5NmNlNDU2NmQyNjMwYmIxMi4uNjI0MmE2Mjc3MWNhYThj
ZjE5NDQwDQo+YTUzYWQ2ZjRkYjg2MmNhMTJkNyAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29u
dGFpbmVyLWJhc2UuaA0KPkBAIC04Niw4ICs4Niw2IEBAIGludA0KPnZmaW9fY29udGFpbmVyX3Nl
dF9kaXJ0eV9wYWdlX3RyYWNraW5nKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPiBp
bnQgdmZpb19jb250YWluZXJfcXVlcnlfZGlydHlfYml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJC
YXNlDQo+KmJjb250YWluZXIsDQo+ICAgICAgICAgICAgICAgICAgICBWRklPQml0bWFwICp2Ym1h
cCwgaHdhZGRyIGlvdmEsIGh3YWRkciBzaXplLCBFcnJvciAqKmVycnApOw0KPg0KPi12b2lkIHZm
aW9fY29udGFpbmVyX2luaXQoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+LSAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBWRklPSU9NTVVDbGFzcyAqb3BzKTsNCj4gdm9pZCB2
ZmlvX2NvbnRhaW5lcl9kZXN0cm95KFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyKTsNCg0K
TWF5YmUgd2UgY2FuIGRvIHRoZSBzYW1lIGZvciB2ZmlvX2NvbnRhaW5lcl9kZXN0cm95KCk/DQpN
b3ZlIHRoZSBjb2RlIGludG8gLmluc3RhbmNlX2ZpbmFsaXplKCkuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQoNCj4NCj4NCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXItYmFzZS5jIGIvaHcv
dmZpby9jb250YWluZXItYmFzZS5jDQo+aW5kZXgNCj4yNDY2OWQ0ZDc0NzJmNDlhYzNhZGYyNjE4
YTMyYmY3ZDgyYzVjMzQ0Li45NzBhZTIzNTZhOTJmODdkZjQ0ZTFkDQo+ZDU4ZmY4YzY3MDQ1YTI0
ZWYxIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLWJhc2UuYw0KPisrKyBiL2h3L3Zm
aW8vY29udGFpbmVyLWJhc2UuYw0KPkBAIC04MywxMSArODMsNiBAQCBpbnQgdmZpb19jb250YWlu
ZXJfcXVlcnlfZGlydHlfYml0bWFwKGNvbnN0DQo+VkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWlu
ZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJy
cCk7DQo+IH0NCj4NCj4tdm9pZCB2ZmlvX2NvbnRhaW5lcl9pbml0KFZGSU9Db250YWluZXJCYXNl
ICpiY29udGFpbmVyLA0KPi0gICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVkZJT0lPTU1V
Q2xhc3MgKm9wcykNCj4tew0KPi19DQo+LQ0KPiB2b2lkIHZmaW9fY29udGFpbmVyX2Rlc3Ryb3ko
VkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIpDQo+IHsNCj4gICAgIFZGSU9HdWVzdElPTU1V
ICpnaW9tbXUsICp0bXA7DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92
ZmlvL2NvbnRhaW5lci5jDQo+aW5kZXgNCj45ZTllMWFiMjI5YzA4MDRmMDczY2Q2NWQ5MjczNWQ0
YmJmNjNkMWQ3Li42MGEwODM4YTljYTgzYTAxMGQ3MzMNCj45NmRiY2QyZDI0ZmNkYzgwMmFlIDEw
MDY0NA0KPi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5l
ci5jDQo+QEAgLTQxOSw3ICs0MTksNiBAQCBzdGF0aWMgVkZJT0NvbnRhaW5lciAqdmZpb19jcmVh
dGVfY29udGFpbmVyKGludCBmZCwNCj5WRklPR3JvdXAgKmdyb3VwLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gew0KPiAgICAg
aW50IGlvbW11X3R5cGU7DQo+LSAgICBjb25zdCBWRklPSU9NTVVDbGFzcyAqdmlvYzsNCj4gICAg
IGNvbnN0IGNoYXIgKnZpb2NfbmFtZTsNCj4gICAgIFZGSU9Db250YWluZXIgKmNvbnRhaW5lcjsN
Cj4NCj5AQCAtNDMzLDEyICs0MzIsMTAgQEAgc3RhdGljIFZGSU9Db250YWluZXIgKnZmaW9fY3Jl
YXRlX2NvbnRhaW5lcihpbnQNCj5mZCwgVkZJT0dyb3VwICpncm91cCwNCj4gICAgIH0NCj4NCj4g
ICAgIHZpb2NfbmFtZSA9IHZmaW9fZ2V0X2lvbW11X2NsYXNzX25hbWUoaW9tbXVfdHlwZSk7DQo+
LSAgICB2aW9jID0gVkZJT19JT01NVV9DTEFTUyhvYmplY3RfY2xhc3NfYnlfbmFtZSh2aW9jX25h
bWUpKTsNCj4NCj4gICAgIGNvbnRhaW5lciA9IFZGSU9fSU9NTVVfTEVHQUNZKG9iamVjdF9uZXco
dmlvY19uYW1lKSk7DQo+ICAgICBjb250YWluZXItPmZkID0gZmQ7DQo+ICAgICBjb250YWluZXIt
PmlvbW11X3R5cGUgPSBpb21tdV90eXBlOw0KPi0gICAgdmZpb19jb250YWluZXJfaW5pdCgmY29u
dGFpbmVyLT5iY29udGFpbmVyLCB2aW9jKTsNCj4gICAgIHJldHVybiBjb250YWluZXI7DQo+IH0N
Cj4NCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0K
PmluZGV4DQo+ZTE5MzIxMzVkZjQxMGM1M2Q0MDYyNjE2ZWUyNjY0YjI3ZDMwYjkyYy4uODExZTEy
YjdkYTkxMzU3ZmE1YjgNCj41ZWJiOWRjYzNhZGVhYmZhNDFmZCAxMDA2NDQNCj4tLS0gYS9ody92
ZmlvL2lvbW11ZmQuYw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTM1Nyw3ICszNTcs
NiBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIgKm5hbWUsDQo+
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ICAgICBjb250YWluZXItPmlvYXNfaWQgPSBpb2FzX2lk
Ow0KPg0KPiAgICAgYmNvbnRhaW5lciA9ICZjb250YWluZXItPmJjb250YWluZXI7DQo+LSAgICB2
ZmlvX2NvbnRhaW5lcl9pbml0KGJjb250YWluZXIsIGlvbW11ZmRfdmlvYyk7DQo+ICAgICB2Zmlv
X2FkZHJlc3Nfc3BhY2VfaW5zZXJ0KHNwYWNlLCBiY29udGFpbmVyKTsNCj4NCj4gICAgIGlmICgh
aW9tbXVmZF9jZGV2X2F0dGFjaF9jb250YWluZXIodmJhc2VkZXYsIGNvbnRhaW5lciwgZXJycCkp
IHsNCj4tLQ0KPjIuNDUuMg0KDQo=

