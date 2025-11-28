Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA10D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 05:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOrKF-0006Zm-P3; Fri, 28 Nov 2025 00:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOrKB-0006ZQ-Ms
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 00:47:20 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOrK6-00038l-4f
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 00:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764308834; x=1795844834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Gqb8ZtuET8NxL8fmY5yvIXigMcOHQRwiFTpEydNMBj0=;
 b=LIZhiGTdHcnLCBlklT2WwGf9HRJtLBTzjEPaoLp9RlOHQJwyvzBvp1qn
 Ppq/hekWokpOjhZ2z4ra4IQ42U7IZPwr8q88szUDHJaqV2N7NrlGxYvpu
 6E8kmM/O8I6CLhxDJyWhgg/5h5duvromtT5qheCYEYghDLOLA4xjFpkK3
 BLUBRTOVy6L+2ump468HqiXv7lFPdl5Qd+ogZ/VxOXsJVI6ZmeOQLjdvL
 ZMHbFKHJohjXTEC79rkaJrRioriPnS0ebFcUc6vrELin9bgBNvEZ1xsPs
 FgdS44Xkg05Ysy40YYi1QGNkt7hYI8HSJnsrJ5aY7pvNFqT7o5DmJ0JFs Q==;
X-CSE-ConnectionGUID: kxf9hAMJS6SefVf4y1k81g==
X-CSE-MsgGUID: M4nP3wODSp24K0czc2TYRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="65348438"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="65348438"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 21:47:10 -0800
X-CSE-ConnectionGUID: peBFWe+LQDaV0YhHtiwbjA==
X-CSE-MsgGUID: rDMOdhS6T8iFIm2TJkVUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="193047294"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 21:47:10 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 21:47:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 21:47:03 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 21:47:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fmi9JhjW5VOR0FZY5Y7jHIJBU7guF14H4tDkFTsmhcjknt++ifriFqARIy5IpFF+pilv7uxYWMXWoSmGzDCJnep/FmaxZ3o2ffl7y3zcFpf25QTlqaWoCnfSl+DIJYKp/OyV5q85TkXBJsx3goDy3tVsip2QwIwnjcBqNEenUy8KG2jDNguxyP751MmL47uNYuBy7yoD6nY17bCMr3a9VZs4f624YKilDLfK5R5FpQWT5TrkM+XNSF+YEHO8M94GBRWwI/1LCw2dN/VaRAmvBdVPPC+jvX6l8B4mKA9BOLH1fYVNnZ5uQvXG/WRZRAiGqAc8wuLVk+JwT14Ul+PnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqb8ZtuET8NxL8fmY5yvIXigMcOHQRwiFTpEydNMBj0=;
 b=Ry2wN9Xv+XQRsB3Ya1oy5xaW4ML6iX0QUoU1Yk5DmC0NUFlAkWJcnSHZ8RmXd1k0816Mv3O12PNJK4EzbCtqXPcx9BD/4nPHqtlMrWDdeHdtXiZCR0dutGRv80gZ78RK8tBmPhaQnDIowrRjaJM++aDsaPcx8pGJPss+NcIGbJjSxxbWwcDbUi/m3Mx5Mry9iocg09m64Hd6xlhHCO51LuekByUXaaalt/iueX1XS/SLh4uy3PwtEEBsVthi4vXCZVnqUBl3N25AQB3cDOYKOGkzSOND4ZVJnxDjJJ6pK8OWptSweJf62Ybcy9Hkn/DliK9W+jbowN/p1YI3PjNFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by DM3PPF1CFCD9AEC.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 05:47:00 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 05:47:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Topic: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Index: AQHcV6YfX2HIuNoGSUCHWlM9EysSCrUHZtRwgAAoaACAABKHAA==
Date: Fri, 28 Nov 2025 05:47:00 +0000
Message-ID: <DS4PPF93A1BBECD600D79F1D538CC24781B92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-18-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <f6a7959e-d004-483c-bcd1-bcd66c1ad295@intel.com>
In-Reply-To: <f6a7959e-d004-483c-bcd1-bcd66c1ad295@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|DM3PPF1CFCD9AEC:EE_
x-ms-office365-filtering-correlation-id: 9e02f536-c99f-4b25-d883-08de2e418cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WlZsSDNzcFRENHI5RUVNMy83NnpTUEg1c2srNUh4MENmVEgwZFFvQm9KQ25p?=
 =?utf-8?B?N3NpYUdUbkVETTcvL3NHMDlIMklWMHNOdGl0ZDFMNFdIMDVQMVFFcTJvYm16?=
 =?utf-8?B?ZVVDTFZoYWVWOVpJR2RCMkVZc2ZYbzliNk9LOE85eGRXYjJZdjNtT0FnbkVN?=
 =?utf-8?B?V2xnYlZJTS9nNDFjbDRyTnVJNXdKRWF1d0lJUFkyamNpSm55SXMwYWFvYnFH?=
 =?utf-8?B?VGZsZWFPU0Y2RVVvZERER3hiMXhUclRHRC9odW9UaU9leTlaK0V5elNSSkxs?=
 =?utf-8?B?WFMwdmxpVVQvV3ArSVJoalFzZmFyKy85dzhZZ3l0TE9YTlg4emkxSmM4YU5D?=
 =?utf-8?B?TnFMRk1hTitDTUFuLzlmWWJRdGZMczZMZEhKQXVWTW5OQkVzZUIxWk8zREpN?=
 =?utf-8?B?OEdNdjRzVkFDTVhmOHRObHJSZHNNa2RtaGRoOWZ2OHBWeGc3S01OdVhTL28x?=
 =?utf-8?B?V0kxSENiRkV2U2JXOUtOOUJaaSttcmltcVRoMEVtdUZnY3R1NkhHYUM0cFlm?=
 =?utf-8?B?YWh3dk1PRkJPZ2NiUGowSzJFeHpQSHhzVlZzK250VFlEMEJmcm9GeTFBTVRK?=
 =?utf-8?B?VU9ycEpFUytRb08wcVM4TWVGQ3BrbmJlNk1uSEpYcjIwZ1YwVXNML3gxVFV4?=
 =?utf-8?B?WFYxUm9xQ2lSZjlyNjJ0TGtWV0hsdDhGL0NWVXYvYTEvcjdKZysxcVNKeWht?=
 =?utf-8?B?RC9pSCsxdllUbXZqQ2NCRE80UTExZk1mK2NYSGZTM1lPOWpIUW90QWE3dlpy?=
 =?utf-8?B?MjlrY2RqRDU2TUlCUmxxaEJydUl2YXQ4Vm9seXRVTVZQeWd3aTZ4NzZUVVc3?=
 =?utf-8?B?eG1uUzV2aytha3FJa3BreW1rQXR2bTFLVUxCRjFZcHlSWDNkM3FwVzBwNWxm?=
 =?utf-8?B?Q29JTjRhNFp4elhDZzMrYXZkQ3VubTVCTkdJNG93dXp2b05NSmhBMW5GczRN?=
 =?utf-8?B?Q1BWWEI5UkJMS3NaNmVtTnl3ZTRRSktSdTU5UzV4TmtiZEI4dFJvWWRRcjBH?=
 =?utf-8?B?UHlDbkF1cDRnV3p3dHNrRGdlakJjYWhPcW9OMVFWS2hnTmdhTjIza1I3UVZX?=
 =?utf-8?B?QS9yUVdQWWpDWW9MTUp0bHJHajVLK1BjcFJ3ZFNwOTcwOVA3aDUrVlhSNERw?=
 =?utf-8?B?bFhVVjR3ZDZ1N1hvb3hQdThzWlZjaklOWDZucWx2TEZWU2pRM1dvR2JUbC9L?=
 =?utf-8?B?YVcxeXUzbUhRMDNXb1d6eE9qVXUzY1YxRzZ5TkNMVjlUb3A5N0NpUnloaUFH?=
 =?utf-8?B?MDR6VnJjZnhNRjVDcXY3MUkvTWhobERLbDJFLzZNL21xNTNZRy93RkJXWmhV?=
 =?utf-8?B?bVFJdGNsM25TbHlEZmRTNVUvRjFlWkhLbmJCUHE2aEdVWk1HR2FZblJnS1hm?=
 =?utf-8?B?dXM3YzA2dlV0UXlyV2FUVXBvZjZDZ0pWbm9tWGFsMWY1UnJRUEU3enM2U1F0?=
 =?utf-8?B?SlpmYkE1OTg4N3JabDJoU0VaQVV6WjNLTFlMbW9ibm9tK0psbzdhamdSZCtZ?=
 =?utf-8?B?L2g4VHlGZ3JudGtnQnBCNEFvN25iOURZOHBjcmdtbUtxeWxnZVlGd3hGZkUr?=
 =?utf-8?B?RHQ1SG1pZnNTSFJHMWUzYWcyOWlFS3pORmtoaEl3RHlwT0QxODNrKzhPQ2RB?=
 =?utf-8?B?YnVJWGM0WWMyL0tMNTJvSDRzOFhzWnR3bU4yMnhnaVJwYjhtOXRNaGhLRThy?=
 =?utf-8?B?dXBvQ1JVVGdXamEvbDU0dGZpQTErZjRMWlB4bnQzeHphUXRLWFVZd3B2S1B6?=
 =?utf-8?B?bEc4NzNTdHR1OTZxMncxcHNobXU5WXZtT2JxbnBjT3hOWTJJTVRNZWNmWjRz?=
 =?utf-8?B?VXZmdjhlM3QrbkczYURkOFZSQ1lZcVdNYndoclZmd3h6bmVEbE92andVMVQ0?=
 =?utf-8?B?dTZ3S3ArS1loOERsNzgrYTV0V0NMclJpVTdxWlV1T2FUY1lMVmRMMWFva3Bv?=
 =?utf-8?B?NVhKV0xsQ0NlaUw5TS9ub0kxWnF0MkFxRVlVNDllR3NRY1MzMFUxK1J0V0Fs?=
 =?utf-8?B?dUxXeStDY3hzekxDV1U5RnRHa2NVNjRFMVh0dWsrTjI1MVRVYlRKay9nZDlu?=
 =?utf-8?Q?P1n8r/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXUyUlhHajlRYlFIdmhlMWUxTXJkNVVpZkp6WlZvMW9QbWFoM3lwbURMSEZI?=
 =?utf-8?B?b0FNYzZJVVBZcUNPWjNqcjFBZFB1NXJXT2o4V0FrRTQ2MXVQRHVza2ZrTzY0?=
 =?utf-8?B?WFZHRlRWY0J5VTJUWEpYclZZdCtZYmxBcWxMMDRsMWduTUt1QU1tUHdQdklv?=
 =?utf-8?B?aHFIbGwxUmxwcWxKdXpUajVhMUp6c1lkcXk1c1NsdmZ0NHlvckN5NjM4TXRZ?=
 =?utf-8?B?OG9Wb2pWeDJYMkp5Z24wRFZkaG54UFpLdEVyV3FaVGJEMkdpVWNralRzRGpF?=
 =?utf-8?B?WW5QNnFSZnMzZE8ySzVSekhTRFZQSkxlRGFyak1OTmpodTUwejBNc2VhbExk?=
 =?utf-8?B?a2J3YzV4dEFwRkFkckVyc2lRWU9tc1JwK2lBN0ZoR1U0ZktlQWVoSlQzc0ZY?=
 =?utf-8?B?SjE1NU5Da0JlcGZ4Mk9vMFRtWGZiYkF6VkxxYXZhSkhsaDJrblNWYVBzOFdX?=
 =?utf-8?B?Q094RzJIbTkzZ1Rzdk1JSUMwNWwzdG1TRnFlM1pjTVhMMVRhS0tNdU9JTW83?=
 =?utf-8?B?OUVBNkdMcGtyaEZSU3FKbjNqYml2ME8yNjRSZEJVYVBNWGdFQXU0UU9XZUI3?=
 =?utf-8?B?T2RsYmFMbUswYlZ3bUluem1MYitPTTJ6cHJWZ0hDL0pPWVNZTS9zT0ZRUVlK?=
 =?utf-8?B?RkxRVFFMeSs2cmZVRnJYMWdQT2RCZlJRTXJWUDJ2WjVhd20rVE5yNCtaWVZD?=
 =?utf-8?B?S2h5ajk1dUo5MmFJemtab3NzampBWjFqUWtYTFpVTGNiaFBYSGZXbDB6VFd0?=
 =?utf-8?B?VkgwYk9NZ0ZhNWEvK3ppc0ZldDNsV1NNckNVLzRKS1lEUzNTYXFHOXZzbXlQ?=
 =?utf-8?B?R0NBUzJxVVluSUlGVzVUSUJGVkxkVENkMXBaL0czcTFwYWQxSERyTStRYU9V?=
 =?utf-8?B?UHZpaUw5cFl3NE9iNDh1NngrVVEyWTRQKzd3Z3REcjBGdHI0VW9WSXRDbnJx?=
 =?utf-8?B?NnRPK0NzQkg4S1lBUE56dERHUEliNExqK3BmbXlzZDN2N002R1grNzRSRGdP?=
 =?utf-8?B?dGlwUEpKOWg3eE1UVGpoNlhWNStxVXAxL3FxQk5yTkU4QUhCY292QWJQSFNr?=
 =?utf-8?B?NmFVbWNVaHdEdWdIK1hUY2I0c3hOOEVlMG93YTg3K3kzclF3VGkyZC8rZ0Rm?=
 =?utf-8?B?aEpSMnpJc3c2UEE3R0x6MDUycktYUGx3ZklpRUcveFhXci9sRmtLK2JnWm45?=
 =?utf-8?B?S2FFaW5MSUYvelpJeStmalRZZ3ZVdEgrRFZBd2hKUEhSMER5QUJsSXkwT01F?=
 =?utf-8?B?QlZKYjlqRmtabDY1bVFQZ1c3MS9oc1Q5TFFqMUMvd2NGN3hJajZMcytCWHlV?=
 =?utf-8?B?TzU3djRWSjEyQy9NK2FIS3B5QzFZNjZLbVIrMWdGNTZkam9yWG1FQ0ZoVjBE?=
 =?utf-8?B?NjNtampYRjNIdFQxUUl3ZDRFcWM3SnQ2SkFqODNIMFhWbG5ZUlAvQ3IyZHFu?=
 =?utf-8?B?Z0RUV3NmQW45QWFLVnhZNys5Y1dHcEJ3RmxSaVYwU3A1WjRhUTMzb2lXYXBN?=
 =?utf-8?B?eWZHeVc5NmI3dW9lOGxFUHkzSEFyaC9pRGFsYTFhOGI4WG1lRitXTmg0OVRx?=
 =?utf-8?B?OU4vUEoyTkFRMzJ6TlN6OXhPU3pYVUQ0SisrVmZ3YmovVThXU1kzRTFYUHhu?=
 =?utf-8?B?UlRkL2FpblBnYXpGeThLQWVCRnBsZ3llekVWbnpWdzV4cEt0azZXNUZXSm44?=
 =?utf-8?B?elJ6NjNST2d0ZEpjelJhd011MFdxdDU1dTlSbG5DTzdnNGoyNEs4Mjc4YmxU?=
 =?utf-8?B?ZDE5TkIwTVJTa20zOFVGWG8xVUtjb0h5b2JmdFg1UytURDhlQVZoRytLaTU2?=
 =?utf-8?B?M1l6ZUtUUXBnWEl4MVIyTzh3U2FmRU9FSXBpVkxYWVhLNmxCVHQ1cC9KZHFN?=
 =?utf-8?B?MUNaRDFqaENOeHYySlkyb0Y4eXhWU3NmT1NzZzN6WFRzWVkzZ3lzY0E4MFhk?=
 =?utf-8?B?MkwvV1JyM1cxNkdqclBYZmpjNnE5NWdTL0picmdjUDcrVGMvOWNHZE9BNXBN?=
 =?utf-8?B?czRwWE1pRlBBdDlCTXc1Tm5jclcyaTIzenBjR3Z6U0FnclJZMU9HcEVlY1BI?=
 =?utf-8?B?dzVTUWFqMmVXalhpSWpQNE1kK1YvWlBGVGVHQ3Jkb0J0VyttamQ4VEhNYnB5?=
 =?utf-8?Q?crJEacUt2thDK0Vz+fl9ipmNc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e02f536-c99f-4b25-d883-08de2e418cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 05:47:00.3003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bV36i/p04fkv9nkXLknm39y0iIaoFSV9CCnFprJY7QPCxYRpEo0nXXuZRG5PKqPIIoSm0qkvzby8aaMyvs/iUwqPb36ylqrxXqezlxt05lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1CFCD9AEC
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMTcvMjNdIHZmaW8vbGlzdGVu
ZXI6IEJ5cGFzcyByZWFkb25seSByZWdpb24gZm9yIGRpcnR5DQo+dHJhY2tpbmcNCj4NCj5PbiAy
MDI1LzExLzI4IDEwOjA4LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBZaSwgQ2Vkcmlj
LA0KPj4NCj4+IENvdWxkIHlvdSBhbHNvIGhlbHAgY29tbWVudCBvbiB0aGlzIHBhdGNoPyBUaGlz
IGlzIGEgcHVyZSBWRklPIG1pZ3JhdGlvbg0KPnJlbGF0ZWQgb3B0aW1pemF0aW9uLCBJIHRoaW5r
IGl0J3MgYmV0dGVyIHRvIGxldCBpdCBnbyB3aXRoIHRoZSAidmZpbzogcmVsYXggdGhlDQo+dklP
TU1VIGNoZWNrIiBzZXJpZXMuDQo+PiBJJ2QgbGlrZSB0byBtb3ZlIGl0IGluIG5leHQgcmVzcGlu
IG9mICJ2ZmlvOiByZWxheCB0aGUgdklPTU1VIGNoZWNrIiBzZXJpZXMgaWYNCj55b3UgdGhpbmsg
aXQgbWFrZSBzZW5zZS4NCj4NCj5JdCBtYWtlcyBzZW5zZSB0byBtZS4NCj4NCj4+IFRoYW5rcw0K
Pj4gWmhlbnpob25nDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJv
bTogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gU3ViamVj
dDogW1BBVENIIHY4IDE3LzIzXSB2ZmlvL2xpc3RlbmVyOiBCeXBhc3MgcmVhZG9ubHkgcmVnaW9u
IGZvciBkaXJ0eQ0KPj4+IHRyYWNraW5nDQo+Pj4NCj4+PiBXaGVuIGRvaW5nIGRpdHJ5IHRyYWNr
aW5nIG9yIGNhbGN1bGF0aW5nIGRpcnR5IHRyYWNraW5nIHJhbmdlLCByZWFkb25seQ0KPg0KPnMv
ZGl0cnkvZGlydHkvDQoNCldpbGwgZml4LCBpdCdzIHN0cmFuZ2UgLS1jb2Rlc3BlbGwgZGlkbid0
IGNhdGNoIGl0Lg0KDQo+DQo+Pj4gcmVnaW9ucyBjYW4gYmUgYnlwYXNzZWQsIGJlY2F1c2UgY29y
cmVzcG9uZGluZyBETUEgbWFwcGluZ3MgYXJlDQo+cmVhZG9ubHkNCj4+PiBhbmQgbmV2ZXIgYmVj
b21lIGRpcnR5Lg0KPj4+DQo+Pj4gVGhpcyBjYW4gb3B0aW1pemUgZGlydHkgdHJhY2tpbmcgYSBi
aXQgZm9yIHBhc3N0aHJvdWdoIGRldmljZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gaHcvdmZp
by9saXN0ZW5lci5jICAgfCA0Ng0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tDQo+Pj4gaHcvdmZpby90cmFjZS1ldmVudHMgfCAgMSArDQo+Pj4gMiBmaWxlcyBj
aGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYg
LS1naXQgYS9ody92ZmlvL2xpc3RlbmVyLmMgYi9ody92ZmlvL2xpc3RlbmVyLmMNCj4+PiBpbmRl
eCAzYjQ4ZjY3OTZjLi5jYTIzNzdkODYwIDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vbGlzdGVu
ZXIuYw0KPj4+ICsrKyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4+IEBAIC03Niw4ICs3NiwxMyBA
QCBzdGF0aWMgYm9vbCB2ZmlvX2xvZ19zeW5jX25lZWRlZChjb25zdA0KPlZGSU9Db250YWluZXIN
Cj4+PiAqYmNvbnRhaW5lcikNCj4+PiAgICAgIHJldHVybiB0cnVlOw0KPj4+IH0NCj4+Pg0KPj4+
IC1zdGF0aWMgYm9vbCB2ZmlvX2xpc3RlbmVyX3NraXBwZWRfc2VjdGlvbihNZW1vcnlSZWdpb25T
ZWN0aW9uICpzZWN0aW9uKQ0KPj4+ICtzdGF0aWMgYm9vbCB2ZmlvX2xpc3RlbmVyX3NraXBwZWRf
c2VjdGlvbihNZW1vcnlSZWdpb25TZWN0aW9uDQo+KnNlY3Rpb24sDQo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgYnlwYXNzX3JvKQ0KPj4+IHsNCj4+
PiArICAgIGlmIChieXBhc3Nfcm8gJiYgc2VjdGlvbi0+cmVhZG9ubHkpIHsNCj4+PiArICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gICAgICByZXR1cm4gKCFtZW1v
cnlfcmVnaW9uX2lzX3JhbShzZWN0aW9uLT5tcikgJiYNCj4+PiAgICAgICAgICAgICAgIW1lbW9y
eV9yZWdpb25faXNfaW9tbXUoc2VjdGlvbi0+bXIpKSB8fA0KPj4+ICAgICAgICAgICAgIG1lbW9y
eV9yZWdpb25faXNfcHJvdGVjdGVkKHNlY3Rpb24tPm1yKSB8fA0KPj4+IEBAIC0zNjgsOSArMzcz
LDkgQEAgc3RhdGljIGJvb2wNCj4+PiB2ZmlvX2tub3duX3NhZmVfbWlzYWxpZ25tZW50KE1lbW9y
eVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24pDQo+Pj4gfQ0KPj4+DQo+Pj4gc3RhdGljIGJvb2wgdmZp
b19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24sDQo+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpu
YW1lKQ0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBi
eXBhc3Nfcm8sIGNvbnN0DQo+Y2hhcg0KPj4+ICpuYW1lKQ0KPj4+IHsNCj4+PiAtICAgIGlmICh2
ZmlvX2xpc3RlbmVyX3NraXBwZWRfc2VjdGlvbihzZWN0aW9uKSkgew0KPj4+ICsgICAgaWYgKHZm
aW9fbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKHNlY3Rpb24sIGJ5cGFzc19ybykpIHsNCj4+PiAg
ICAgICAgICB0cmFjZV92ZmlvX2xpc3RlbmVyX3JlZ2lvbl9za2lwKG5hbWUsDQo+Pj4gICAgICAg
ICAgICAgICAgICBzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2UsDQo+Pj4gICAg
ICAgICAgICAgICAgICBzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2UgKw0KPj4+
IEBAIC00OTcsNyArNTAyLDcgQEAgdm9pZCB2ZmlvX2NvbnRhaW5lcl9yZWdpb25fYWRkKFZGSU9D
b250YWluZXINCj4+PiAqYmNvbnRhaW5lciwNCj4+PiAgICAgIGludCByZXQ7DQo+Pj4gICAgICBF
cnJvciAqZXJyID0gTlVMTDsNCj4+Pg0KPj4+IC0gICAgaWYgKCF2ZmlvX2xpc3RlbmVyX3ZhbGlk
X3NlY3Rpb24oc2VjdGlvbiwgInJlZ2lvbl9hZGQiKSkgew0KPj4+ICsgICAgaWYgKCF2ZmlvX2xp
c3RlbmVyX3ZhbGlkX3NlY3Rpb24oc2VjdGlvbiwgZmFsc2UsICJyZWdpb25fYWRkIikpIHsNCj4+
PiAgICAgICAgICByZXR1cm47DQo+Pj4gICAgICB9DQo+Pj4NCj4+PiBAQCAtNjYzLDcgKzY2OCw3
IEBAIHN0YXRpYyB2b2lkDQo+dmZpb19saXN0ZW5lcl9yZWdpb25fZGVsKE1lbW9yeUxpc3RlbmVy
DQo+Pj4gKmxpc3RlbmVyLA0KPj4+ICAgICAgaW50IHJldDsNCj4+PiAgICAgIGJvb2wgdHJ5X3Vu
bWFwID0gdHJ1ZTsNCj4+Pg0KPj4+IC0gICAgaWYgKCF2ZmlvX2xpc3RlbmVyX3ZhbGlkX3NlY3Rp
b24oc2VjdGlvbiwgInJlZ2lvbl9kZWwiKSkgew0KPj4+ICsgICAgaWYgKCF2ZmlvX2xpc3RlbmVy
X3ZhbGlkX3NlY3Rpb24oc2VjdGlvbiwgZmFsc2UsICJyZWdpb25fZGVsIikpIHsNCj4+PiAgICAg
ICAgICByZXR1cm47DQo+Pj4gICAgICB9DQo+Pj4NCj4+PiBAQCAtNzIyLDExICs3MjcsMTEgQEAg
c3RhdGljIHZvaWQNCj4+PiB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9kZWwoTWVtb3J5TGlzdGVuZXIg
Kmxpc3RlbmVyLA0KPj4+ICAgICAgICAgIH0NCj4+Pg0KPj4+ICAgICAgICAgIC8qDQo+Pj4gLSAg
ICAgICAgICogRmFrZSBhbiBJT1RMQiBlbnRyeSBmb3IgaWRlbnRpdHkgbWFwcGluZyB3aGljaCBp
cyBuZWVkZWQgYnkNCj4+PiBkaXJ0eQ0KPj4+IC0gICAgICAgICAqIHRyYWNraW5nLiBJbiBmYWN0
LCBpbiB1bm1hcF9iaXRtYXAsIG9ubHkgdHJhbnNsYXRlZF9hZGRyIGZpZWxkDQo+aXMNCj4+PiAt
ICAgICAgICAgKiB1c2VkIHRvIHNldCBkaXJ0eSBiaXRtYXAuDQo+Pj4gKyAgICAgICAgICogRmFr
ZSBhbiBJT1RMQiBlbnRyeSBmb3Igd3JpdGFibGUgaWRlbnRpdHkgbWFwcGluZyB3aGljaCBpcw0K
Pj4+IG5lZWRlZA0KPj4+ICsgICAgICAgICAqIGJ5IGRpcnR5IHRyYWNraW5nLiBJbiBmYWN0LCBp
biB1bm1hcF9iaXRtYXAsIG9ubHkNCj4+PiB0cmFuc2xhdGVkX2FkZHINCj4+PiArICAgICAgICAg
KiBmaWVsZCBpcyB1c2VkIHRvIHNldCBkaXJ0eSBiaXRtYXAuDQo+Pj4gICAgICAgICAgICovDQo+
Pj4gLSAgICAgICAgaWYgKCFtZW1vcnlfcmVnaW9uX2lzX2lvbW11KHNlY3Rpb24tPm1yKSkgew0K
Pj4+ICsgICAgICAgIGlmICghbWVtb3J5X3JlZ2lvbl9pc19pb21tdShzZWN0aW9uLT5tcikNCj4+
PiAmJiAhc2VjdGlvbi0+cmVhZG9ubHkpIHsNCj4+PiAgICAgICAgICAgICAgZW50cnkuaW92YSA9
IGlvdmE7DQo+Pj4gICAgICAgICAgICAgIGVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IGlvdmE7DQo+
Pj4gICAgICAgICAgICAgIGlvdGxiID0gJmVudHJ5Ow0KPj4+IEBAIC04MzQsNyArODM5LDggQEAg
c3RhdGljIHZvaWQNCj4+PiB2ZmlvX2RpcnR5X3RyYWNraW5nX3VwZGF0ZShNZW1vcnlMaXN0ZW5l
ciAqbGlzdGVuZXIsDQo+Pj4gICAgICAgICAgY29udGFpbmVyX29mKGxpc3RlbmVyLCBWRklPRGly
dHlSYW5nZXNMaXN0ZW5lciwgbGlzdGVuZXIpOw0KPj4+ICAgICAgaHdhZGRyIGlvdmEsIGVuZDsN
Cj4+Pg0KPj4+IC0gICAgaWYgKCF2ZmlvX2xpc3RlbmVyX3ZhbGlkX3NlY3Rpb24oc2VjdGlvbiwg
InRyYWNraW5nX3VwZGF0ZSIpIHx8DQo+Pj4gKyAgICAvKiBCeXBhc3MgcmVhZG9ubHkgc2VjdGlv
biBhcyBpdCBuZXZlciBiZWNvbWVzIGRpcnR5ICovDQo+Pj4gKyAgICBpZiAoIXZmaW9fbGlzdGVu
ZXJfdmFsaWRfc2VjdGlvbihzZWN0aW9uLCB0cnVlLCAidHJhY2tpbmdfdXBkYXRlIikgfHwNCj4+
PiAgICAgICAgICAhdmZpb19nZXRfc2VjdGlvbl9pb3ZhX3JhbmdlKGRpcnR5LT5iY29udGFpbmVy
LCBzZWN0aW9uLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmlv
dmEsICZlbmQsIE5VTEwpKSB7DQo+Pj4gICAgICAgICAgcmV0dXJuOw0KPj4+IEBAIC0xMDkzLDYg
KzEwOTksMTkgQEAgc3RhdGljIHZvaWQNCj4+PiB2ZmlvX2lvbW11X21hcF9kaXJ0eV9ub3RpZnko
SU9NTVVOb3RpZmllciAqbiwgSU9NTVVUTEJFbnRyeQ0KPippb3RsYikNCj4+PiAgICAgIGlmICgh
bXIpIHsNCj4+PiAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+Pj4gICAgICB9DQo+Pj4gKw0K
Pj4+ICsgICAgLyoNCj4+PiArICAgICAqIFRoZSBtYXBwaW5nIGlzIHJlYWRvbmx5IHdoZW4gZWl0
aGVyIGl0J3MgYSByZWFkb25seSBtYXBwaW5nIGluDQo+Z3Vlc3QNCj4+PiArICAgICAqIG9yIG1h
cHBlZCB0YXJnZXQgaXMgcmVhZG9ubHksIGJ5cGFzcyBpdCBmb3IgZGlydHkgdHJhY2tpbmcgYXMg
aXQNCj4+PiArICAgICAqIG5ldmVyIGJlY29tZXMgZGlydHkuDQo+Pj4gKyAgICAgKi8NCj4+PiAr
ICAgIGlmICghKGlvdGxiLT5wZXJtICYgSU9NTVVfV08pIHx8IG1yLT5yZWFkb25seSkgew0KPg0K
PmlzIGl0IHBvc3NpYmxlIHRoYXQgZ3Vlc3QgbWFwcyBSVywgd2hpbGUgdGhlIGJhY2tlbmQgbXIg
aXMgcmVhZG9ubHk/DQoNCkkgdGhpbmsgYSBub3JtYWwgT1MgZG9lcyBub3QgbmVlZCB0byBtYXAg
YSByZWFkb25seSByZWdpb24gYXMgUlcsIGJlY2F1c2Ugd3JpdGluZyB3aWxsIGFsd2F5cyBmYWls
Lg0KSWYgaXQgZG9lcywgdGhlbiBzaGFkb3cgbWFwcGluZyBvbiBob3N0IHNpZGUgaXMgcmVhZG9u
bHkuIFRoaXMgZW11bGF0ZXMgc2FtZSBiZWhhdmlvciBhcyBvbiBiYXJlbWV0YWwuDQoNCj4NCj4+
PiArICAgICAgICB0cmFjZV92ZmlvX2lvbW11X21hcF9kaXJ0eV9ub3RpZnlfc2tpcF9ybyhpb3Zh
LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlvdmEgKw0KPj4+IGlvdGxiLT5hZGRyX21hc2spOw0KPj4+ICsgICAgICAgIHJjdV9yZWFkX3Vu
bG9jaygpOw0KPj4+ICsgICAgICAgIHJldHVybjsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gICAg
ICB0cmFuc2xhdGVkX2FkZHIgPSBtZW1vcnlfcmVnaW9uX2dldF9yYW1fYWRkcihtcikgKyB4bGF0
Ow0KPj4+DQo+Pj4gICAgICByZXQgPSB2ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAo
YmNvbnRhaW5lciwgaW92YSwNCj4+PiBpb3RsYi0+YWRkcl9tYXNrICsgMSwNCj4+PiBAQCAtMTIy
OCw3ICsxMjQ3LDEyIEBAIHN0YXRpYyB2b2lkDQo+Pj4gdmZpb19saXN0ZW5lcl9sb2dfc3luYyhN
ZW1vcnlMaXN0ZW5lciAqbGlzdGVuZXIsDQo+Pj4gICAgICBpbnQgcmV0Ow0KPj4+ICAgICAgRXJy
b3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+Pj4NCj4+PiAtICAgIGlmICh2ZmlvX2xpc3RlbmVyX3Nr
aXBwZWRfc2VjdGlvbihzZWN0aW9uKSkgew0KPj4+ICsgICAgLyoNCj4+PiArICAgICAqIEJ5cGFz
cyByZWFkb25seSBzZWN0aW9uIGFzIGl0IG5ldmVyIGJlY29tZXMgZGlydHksIGlvbW11DQo+bWVt
b3J5DQo+Pj4gc2VjdGlvbg0KPj4+ICsgICAgICogaXMgUlcgYW5kIG5ldmVyIGJ5cGFzc2VkLiBU
aGUgcmVhZG9ubHkgbWFwcGluZ3MgaW4gaW9tbXUgTVINCj5hcmUNCj4+PiBieXBhc3NlZA0KPj4+
ICsgICAgICogaW4gdmZpb19pb21tdV9tYXBfZGlydHlfbm90aWZ5KCkuDQo+Pj4gKyAgICAgKi8N
Cj4+PiArICAgIGlmICh2ZmlvX2xpc3RlbmVyX3NraXBwZWRfc2VjdGlvbihzZWN0aW9uLCB0cnVl
KSkgew0KPj4+ICAgICAgICAgIHJldHVybjsNCj4+PiAgICAgIH0NCj4+Pg0KPg0KPkxvb2tzIHRo
ZSB2ZmlvX2lvbW11X21hcF9ub3RpZnkoKSBpcyBtaXNzZWQuIEl0IGFsc28gaGFzIHVubWFwIG9w
LiBpcw0KPml0Pw0KDQpSaWdodCwgYmVjYXVzZSB3ZSBkb24ndCBrbm93IGV4aXN0aW5nIHNoYWRv
dyBtYXBwaW5nIGlzIHJlYWRvbmx5IG9yIG5vdCwNCnZmaW9fbGlzdGVuZXJfbG9nX3N5bmMoKSBh
bHNvIGRvZXNuJ3QgcHJvdmlkZSB0aGF0IGluZm8uDQpUaGF0IG1lYW5zIHdlIGRvIGRpcnR5IHRy
YWtpbmcgaW4gdGhpcyBjYXNlLCBidXQgcmV0dXJuZWQgYml0bWFwcyBzaG91bGQgYmUgYWxsIHpl
cm8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

