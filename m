Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DD0CCD190
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wFt-0003AC-I2; Wed, 15 Oct 2025 03:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8wFr-0003A2-NW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:49:03 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8wFn-0004ez-BY
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760514540; x=1792050540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hzpoyCeEngo+Ton1EeTgXeksvT3akxBQk6AwM4VJCW0=;
 b=N7vd7+d90uEOpdfTjNjqDRVniIHfu2EyJ3OA775nCp1MiKSimvGaUHJs
 1U5vTh0JDJgJYcL+QCKrjbek8Gp6O1N6IgHh7viRDWKzc3xw+Citvgfa0
 CPgxehzAxFEpXSz4cAsdWN7NMFao/LOAPTqM6fPg/uHOjsdTjRr/I1zRS
 +vGSizRuqre1Gu9OgXxq5L+gmZ9GXZ3N5V3btId6T0Q3HLiaif+smpKme
 G4W96SdUPzxyzssqXxru3IPMy/ln9uhPavPNCKsANvmVRbOV2kYGUiiSI
 1wiW8ZeMd1382fBMAf/YpqmEv41V84kXQhnx9yJZ6lQfAKb4ZBePl1OIY w==;
X-CSE-ConnectionGUID: eZM91XqrRNS438kz5rFL5g==
X-CSE-MsgGUID: m75LlPXIQYazAhcL9MsHAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62578282"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="62578282"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 00:48:43 -0700
X-CSE-ConnectionGUID: 0aNk+fYiSKCtD5gGNgCVSA==
X-CSE-MsgGUID: m1U6G5QRT0uyP1O6OwKdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="219244710"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 00:48:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:48:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 00:48:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdqJ0T1s2n/mrzBvYosI8Ekw2JyOg5XeCRlQjyk0cXL94YWY/kK0J9DUcyE+NxxiHhNP25XU5XtYKXd7cf7NFy0fHqFLDi5KzcoJmp/LayFWaTWMkC5BACh0BxQ3MJrJ7hL+gSIIHjLc9SykVE+RiP5GGX32L8dZZOB7aqAQSOYZpsylcCXEW6ITb/HqPHf0OZajppMcv1hoB1u/IKclqVJZBqilpSW2Kg6kE2baoh9S68bbweYxIJtYaoJvJQmZviWY53ls7Rmjw1yqw8Je0YD24pEo+gDMys3qI2CmVx7Z2BEhO5cPB4qEgr69AZbSPhsElYTaMLpXwR89NsZtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzpoyCeEngo+Ton1EeTgXeksvT3akxBQk6AwM4VJCW0=;
 b=ePA49eYcQOD7LURJBoS48rQBXz9L+38A4cv547yDD03dU/ZE/4JfGmZavoLba2ajRxUIM+KyGpqEYPigEfQCB83j61BKiivIbCVT5iIbc/nV/CQRAQy5cZvBXLxB98wvSNcsYX1g2wSB2d4Tu7PawvlelQniXXjnZY5uXerUKRjA8hg3mIYfw/ujIHMi7+lAQndMIdOgJ57e7nWGbm51LCzPrJERHJrznqJkdMyFe4ZqS8gLo+eUx4SgcD73RgN72hiDuq9cNHxRM91KtepheDfEtp24VFeKGYKiQB1yfwMextj/kdxltDe9IVI2wEk5rNBqRKPiptL4QaxJu89eXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA3PR11MB8968.namprd11.prod.outlook.com (2603:10b6:208:57b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 07:48:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 07:48:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Topic: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Index: AQHcIfvpBR8EG6fncUCmXH17xc4ayLS+gq4AgAEL66CAAK7kAIAA3gSggABNBgCAABhnoA==
Date: Wed, 15 Oct 2025 07:48:32 +0000
Message-ID: <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
In-Reply-To: <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA3PR11MB8968:EE_
x-ms-office365-filtering-correlation-id: 8fa0c583-b6de-4885-1ade-08de0bbf3d21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U3ZNUmtDck91Rmt4Z0tGVEZ1TVhPYlg1cSsxeXQveHl6aTFhbGxIbjJYMWE4?=
 =?utf-8?B?ZzZBMU1FRGJ6SU9lWW5rbGUyVlR6eHk5VVpKK0U3MlZValRGTDlVVzhheFVs?=
 =?utf-8?B?THVlTWhERTVOU05MMDFCbWQ5RWRncFcwQjk3SVVoZVB6Ti9MZDUvLzJ6aTlu?=
 =?utf-8?B?MThDcGg2S1RnWVBNa3JINzI1L25aNGhkZDJ3NEMza1dOZHZ0SVl2RFBZTE9r?=
 =?utf-8?B?Z3N5OFoxbDZ4UTJDVmdkVzRMSUJ2VEVvZ0IrbjVPa2dLYXhBYStFQWZNblNO?=
 =?utf-8?B?dkhVUW00dUdYSUsxb1FqY3VVcE5MTVg1MUZQM241bWVHUGUvYVVhM0dXZ0ZW?=
 =?utf-8?B?Mm11U0ZLZUhkUHFVbGl0ajZrdndPMGdzcStHWjN1d1dwWU52WFd0VVZMZ2Ro?=
 =?utf-8?B?OXJBZDRzcXNQaGxYbzZmN1pCRG8zeCtpaDR2Z0diazNiYUYwMUo1akswWVRo?=
 =?utf-8?B?ckMwc3FnOWt2em9lbk5KbEtwbDZvS1diRERvSGpRcW9RS1hYdWRDZ0E2RjNz?=
 =?utf-8?B?NDkzaDNtUEdDb0N2L3lCSjNBVmc0aDlHbGNRZjZVQm45YVg4allwSnlJdDVx?=
 =?utf-8?B?WTdqK29yY3JMU3diYTVYeFlmVE5NYkc4eTdtRWdKQm1TTytXaVRtVVZrTWR5?=
 =?utf-8?B?SVlqcDNicTl0RkUrNU1YcW1lNG91eS9CN3JLSEg0TGh3Yi9vanBXS3ZLeUIv?=
 =?utf-8?B?VWNjWG9QRFczNUVMbzlrTWJWZEFYKzdJK1o1TlE2OTV6Q0o5TWcxNW1sTG44?=
 =?utf-8?B?U0NqeHZSWnlwK1V2azkrbmxHWEt0cjlkMzc2UE5DMUFwWHRzWVY2eVBNVHZv?=
 =?utf-8?B?a1ZLaHorbkV1dkpPN0kyRTJ1M3ZKbm9tcGlyUXZPTkVXaTNkT205dTZkTXha?=
 =?utf-8?B?TU1hbG83d041V1ZnT0JwRUdKdjRyZ25aMUJPdmdUOFU5SGc5K3BFc0h0NVJK?=
 =?utf-8?B?UGF0eE5rdDlCK0hFbEtocHlPRUg2bU85Rk1IaXdPanVMMXVPWVduOTZCdVVX?=
 =?utf-8?B?cElYS3dqRDJtbmJWWkh5V1cyVkQ2THJzWE0yeXhNb2wrUVdUaXplaEkvRmhR?=
 =?utf-8?B?bU9BN2szamdyUG16WDhaQ2NKZHVLbzBmeTJjM2U2NU9pL0prZE5scVl4Um1H?=
 =?utf-8?B?cjkrZE1nemZWKzZVaXlyOTkrc0xCQ2R2akFMS0pGTE4rZjdGL1NFcHBnWUM2?=
 =?utf-8?B?QnV3S0tOWjJ0QUhnMVJWQTM5Qk9EZzV0WWdha29wdUwxNkRFYUlVZnBzcms3?=
 =?utf-8?B?OXNVeWdoUnBvQXhKVHFyeGlsUDljL0RZd0pVRlJ3RnVhR3l0VjF4OVBxNFc1?=
 =?utf-8?B?c2VHc3RySkc0bWRYU09EV3hjT3pWdk0vREdNbVJOV284WVB3R2wvZUkveFRh?=
 =?utf-8?B?M2M4dmx6NFhnMjc1cnk0QTVuRkpNdDZ0cVJaTHp3WU9uYkdhVzhJMmQxcjdH?=
 =?utf-8?B?REdXMUlCWVdDU0NVSVM4MGZtOFN5UnFGV1M0Y2FDQll5Nis2eXVPMk9SYVJ3?=
 =?utf-8?B?dTlXejdZb0Y4OGp5OG91RVNIbGh6TjRsV1drMGJsYzNOaCtJSWlxeEZYVHVC?=
 =?utf-8?B?RlFjOC9CN2RqdGtyT0lZVFA1NklxZmQyY0k2Mi9ldzNsUUFhSVZhNVNVTmJR?=
 =?utf-8?B?R0VIWGtEUVRBcktKYlI4eW9zS05NdDF2Qi9sb080QWF0YkFJelRBTHhBYUFK?=
 =?utf-8?B?NG5DcUl4aUIrOUpoamVvdm14Vk1iWkJIVUN5YXFNdnoydW5TM1BPWnZ6Nkp6?=
 =?utf-8?B?K0gyeGlNUlBRcGhzYnV4amNvQjhmUzdrOFByTXdUdEFoeDJNVStublA3bHdV?=
 =?utf-8?B?MVBlVVRtd25qYlgyem9vOW9zK3dPZDlGWkY3ckM2Ym5aLzZMTkw1T3JxRmt5?=
 =?utf-8?B?VWxkSEE3UFVvTlpEOUJ6WEVSVjNBTEpEZ2xIL2NWUXRCRGlLL1kwUTVsV2FJ?=
 =?utf-8?B?ekFIY1kzUjJVOHdOWlNyQVhOSDhSQWJqTVErODNuSytpVGlGZWM3TjZ4aFoz?=
 =?utf-8?B?Y0xGc1I3VU9pc3lGOEtxR21INjhxMkE1M1dkNEw3dWxRWXF3TUcxaGtTV0ZD?=
 =?utf-8?Q?r8IzbZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZsaU9odHp4STZCSTdlT09WdmlSTEJ4b3RxMHJkTFpzSWppcG5RT1JpZW5i?=
 =?utf-8?B?RVR6dHR4YUhiUjFuK2lOblNXSEdwc0ZBV1JoYVErT2VaellwVitONzhBUXdO?=
 =?utf-8?B?dE9zcjdBbmJtdVJUV21oT1grRENHeFhxUWM3VnF3dHFhaUdQeTF5RWo1RGNs?=
 =?utf-8?B?UUZqZVNOSjZldTdCeGRLaHRqckFxeXVLNFljaWdlaVV0Ri8wbFhuK3hQU0lX?=
 =?utf-8?B?Sld4Z0VrRjdEWExJNmcza2RkWHRNaWR4dGRPeEJ5elJuV3BWQkRZcXRGeFdo?=
 =?utf-8?B?dWFkbDlZcStmM1kwVWFnaG9BV045RFV5N0V5ejFyMEZwaGpYWmlaUnVKcWli?=
 =?utf-8?B?UVVEZy90MStMa2ZEc1V1cU1hcXVWSTdOQ3U4Nm4wSnFHOXdTVWQxMXhFMmF3?=
 =?utf-8?B?NGo1UEU3QUhaM0d0clJDd3FDdFVFR0FUb3drZ3dGRCs4SktIV3FyQUpLQ3Uz?=
 =?utf-8?B?QU1EcTRIRTdMN2M3Z0xENDhSbURVMkc5aDM4L1NyYmwrTnpVaGwxL0hSOWRk?=
 =?utf-8?B?dXVqZ256QXR5alN1S0VnalZvRlY5cUhhZmVrdmdNTE9jTjRnTVY4bWdxbG5E?=
 =?utf-8?B?bEdVUjIyUHhjcXFiTlhsSnJOREVTMzlmVk9yZGVtalJ5Zmd2NlpMYTZzNnBF?=
 =?utf-8?B?L0JRcWVLMjRsQm5YVnpFMEdLaFFQcDdhR05OWHA3WTRUVjdvYjVvZnlFckx5?=
 =?utf-8?B?ODJGb3NsVVJnOUVmR1A5OC9sQWNaU25uTVdFNENKZi9rbHJEaFAzbmdCZjYw?=
 =?utf-8?B?cm1NQTZOZDAxRXJnZXJZaDZjb05BMmxvRUJFcFcyUTdmQWtZaGZNUHFlejE0?=
 =?utf-8?B?OU5ZMTNDZ0tQa2krV2l2U3I0SU92RGw3TFhSR1ZxNnpnempSMXdZWkxJeHpv?=
 =?utf-8?B?WjFFK3l0YVhEOWhlQ2h3Qk1zSUZWb1czb0FRWFUwR09BUnNSdkxWZVV2R2t6?=
 =?utf-8?B?aUJkd1BxaXZGUEpiaC9FamphSkk5RFpZdkl4Q2xTSndlU284UTJ1ZmF5eDV2?=
 =?utf-8?B?RGx4dnYrcE85Mkc3cGowMmhnQkVLNXN0YzdGKzhkN2phamo2VTBXNUpheXR0?=
 =?utf-8?B?QkxyNjJ2VlBVWlBjRzBUK1Z3VXpWOEREN2Z1NmlSb1R1enRhUlFTczBaWHpS?=
 =?utf-8?B?MjlHVVBLelJLdHBoT0xTdjhFcFRCdFZkOGgvWjV1b3Aya0FhWXQ2bG80Mm8y?=
 =?utf-8?B?dGgzTkdTV0ltMDNIOFkyamtOa241WittMFJuUXBRQ0kxckJSQnpOSGdGa3lo?=
 =?utf-8?B?RlJVNXI0aXZVbi9TaWJ3ZDdlalVobzBDa0YvcXB1ZUJQSjVRakdsOWNYUlQ4?=
 =?utf-8?B?R0RKQUsvNVJid2JmcG9CRVdXd3hyczJqb09tYjU4MUkrMnB5REg5K1VEUTJI?=
 =?utf-8?B?UVh1V05tZmJaWkVpTlNSRmNVSU5iekNGWUxnYnBxbHJNWUFITWNJQ2FmcW9Q?=
 =?utf-8?B?R2YvT05UNGZKWmlyU3FqUkQwUEoyVVpnQUVuOWJrbWp6bXNqemRqeWhzSGgw?=
 =?utf-8?B?dm1IWjliOEtwSGY0T2VONFl3MHVjbmJzTEh5VStTbjlYRmVsa3JadGN6OW1G?=
 =?utf-8?B?V2VvZFZNRGJVYkZRYnR4cGZoK3NMRy9Kdk9vTFhGUXM0T0t1dFg2K1JVWi8y?=
 =?utf-8?B?cmFCTUVUYzRqaHRhdHdKc1FKVjZ0TEo2ZXZ6ajlmeU1uT0l1c0kxUEQ5NnBO?=
 =?utf-8?B?Tjhmb09MRW5HSWV1L0JGOFFhcUNCOENnUGk3SythdDFIVlg1WkVXai90czZl?=
 =?utf-8?B?OTVHNmJxdTRhSG5PdHdqbGh4UHBUSVRhYmRxRkM5eEJmcWVWRFJhUStRRldX?=
 =?utf-8?B?R2kyVG9vKzFCMnhua290NVVlOXRjWC9iWm5LVmNZbGFTTUgvVjN2Vnpqemlz?=
 =?utf-8?B?dFBDVzFJd2VhSFVoNzJvd3p1S0dzK3dVa3dmVVBialNxM2Z0Tk1NSk1TY0RS?=
 =?utf-8?B?M3F2UEdIVEpyOTdkTVFRZFQ1SFVyM2pZVGZ2Rm9vMTlaMHR0ZGc5MGF0TWxH?=
 =?utf-8?B?RXhhWmZFbTBpVGZ0ek9rdlowR0dZK3FLNEo2alBMeWZCUjBjbVZGYkc2em1K?=
 =?utf-8?B?MzhTSWNONHkvZEVWTE1DNDZJWm85RFNXdTF2ZEhNS1ZxN0g1QTFrcjdrSjY3?=
 =?utf-8?Q?2xAtsnirn5aBjXU2Q44YT1TLH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0c583-b6de-4885-1ade-08de0bbf3d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 07:48:32.5234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opCQj8q2jCiyLTGDIdsJU2H0UTCGdVSNwJ+11CQAI8BmMt39t9arY3PDU2JVr9rVpbfqN+9O1hDBCoCodd8x3K7nhrMxTFWaBBK5tXD5G8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8968
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBpbnRlbF9pb21tdTogT3B0
aW1pemUgdW5tYXBfYml0bWFwIGR1cmluZw0KPm1pZ3JhdGlvbg0KPg0KPk9uIDIwMjUvMTAvMTQg
MTA6MzEsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGludGVsX2lvbW11OiBPcHRpbWl6ZSB1bm1hcF9i
aXRtYXAgZHVyaW5nDQo+Pj4gbWlncmF0aW9uDQo+Pj4NCj4+PiBPbiAyMDI1LzEwLzEzIDEwOjUw
LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaW50ZWxfaW9tbXU6IE9wdGltaXplIHVu
bWFwX2JpdG1hcCBkdXJpbmcNCj4+Pj4+IG1pZ3JhdGlvbg0KPj4+Pj4NCj4+Pj4+IE9uIDIwMjUv
OS8xMCAxMDozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4gSWYgYSBWRklPIGRldmlj
ZSBpbiBndWVzdCBzd2l0Y2hlcyBmcm9tIElPTU1VIGRvbWFpbiB0byBibG9jaw0KPmRvbWFpbiwN
Cj4+Pj4+PiB2dGRfYWRkcmVzc19zcGFjZV91bm1hcCgpIGlzIGNhbGxlZCB0byB1bm1hcCB3aG9s
ZSBhZGRyZXNzIHNwYWNlLg0KPj4+Pj4+DQo+Pj4+Pj4gSWYgdGhhdCBoYXBwZW5zIGR1cmluZyBt
aWdyYXRpb24sIG1pZ3JhdGlvbiBmYWlscyB3aXRoIGxlZ2FjeSBWRklPDQo+Pj4+Pj4gYmFja2Vu
ZCBhcyBiZWxvdzoNCj4+Pj4+Pg0KPj4+Pj4+IFN0YXR1czogZmFpbGVkICh2ZmlvX2NvbnRhaW5l
cl9kbWFfdW5tYXAoMHg1NjFiYmJkOTJkOTAsDQo+Pj4+PiAweDEwMDAwMDAwMDAwMCwgMHgxMDAw
MDAwMDAwMDApID0gLTcgKEFyZ3VtZW50IGxpc3QgdG9vIGxvbmcpKQ0KPj4+Pj4NCj4+Pj4+IHRo
aXMgc2hvdWxkIGJlIGEgZ2lhbnQgYW5kIGJ1c3kgVk0uIHJpZ2h0PyBJcyBhIGZpeCB0YWcgbmVl
ZGVkIGJ5IHRoZQ0KPndheT8NCj4+Pj4NCj4+Pj4gVk0gc2l6ZSBpcyB1bnJlbGF0ZWQsIGl0J3Mg
bm90IGEgYnVnLCBqdXN0IGN1cnJlbnQgY29kZSBkb2Vzbid0IHdvcmsgd2VsbA0KPndpdGgNCj4+
PiBtaWdyYXRpb24uDQo+Pj4+DQo+Pj4+IFdoZW4gZGV2aWNlIHN3aXRjaGVzIGZyb20gSU9NTVUg
ZG9tYWluIHRvIGJsb2NrIGRvbWFpbiwgdGhlIHdob2xlDQo+Pj4gaW9tbXUNCj4+Pj4gbWVtb3J5
IHJlZ2lvbiBpcyBkaXNhYmxlZCwgdGhpcyB0cmlnZ2VyIHRoZSB1bm1hcCBvbiB0aGUgd2hvbGUg
aW9tbXUNCj4+PiBtZW1vcnkNCj4+Pj4gcmVnaW9uLA0KPj4+DQo+Pj4gSSBnb3QgdGhpcyBwYXJ0
Lg0KPj4+DQo+Pj4+IG5vIG1hdHRlciBob3cgbWFueSBvciBob3cgbGFyZ2UgdGhlIG1hcHBpbmdz
IGFyZSBpbiB0aGUgaW9tbXUgTVIuDQo+Pj4NCj4+PiBobW1tLiBBIG1vcmUgZXhwbGljaXQgcXVl
c3Rpb246IGRvZXMgdGhpcyBlcnJvciBoYXBwZW4gd2l0aCA0RyBWTQ0KPm1lbW9yeQ0KPj4+IGFz
IHdlbGw/DQo+Pg0KPj4gQ29pbmNpZGVudGx5LCBJIHJlbWVtYmVyIFFBVCB0ZWFtIHJlcG9ydGVk
IHRoaXMgaXNzdWUganVzdCB3aXRoIDRHIFZNDQo+bWVtb3J5Lg0KPg0KPm9rLiB0aGlzIG1pZ2h0
IGhhcHBlbiB3aXRoIGxlZ2FjeSB2SU9NTVUgYXMgZ3Vlc3QgdHJpZ2dlcnMgbWFwL3VubWFwLg0K
Pkl0IGNhbiBiZSBhIGxhcmdlIHJhbmdlLiBCdXQgaXQncyBzdGlsbCBub3QgY2xlYXIgdG8gbWUg
aG93IGNhbiBndWVzdA0KPm1hcCBhIHJhbmdlIG1vcmUgdGhhbiA0RyBpZiBWTSBvbmx5IGhhcyA0
RyBtZW1vcnkuDQoNCkl0IGhhcHBlbnMgd2hlbiBndWVzdCBzd2l0Y2ggZnJvbSBETUEgZG9tYWlu
IHRvIGJsb2NrIGRvbWFpbiwgYmVsb3cgc2VxdWVuY2UgaXMgdHJpZ2dlcmVkOg0KDQp2dGRfY29u
dGV4dF9kZXZpY2VfaW52YWxpZGF0ZQ0KCXZ0ZF9hZGRyZXNzX3NwYWNlX3N5bmMNCgkJdnRkX2Fk
ZHJlc3Nfc3BhY2VfdW5tYXANCg0KWW91IGNhbiBzZWUgdGhlIHdob2xlIGlvbW11IGFkZHJlc3Mg
c3BhY2UgaXMgdW5tYXBwZWQsIGl0J3MgdW5yZWxhdGVkIHRvIGFjdHVhbCBtYXBwaW5nIGluIGd1
ZXN0Lg0KDQo+DQo+Pg0KPj4+DQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gQmVjYXVzZSBsZWdhY3kg
VkZJTyBsaW1pdHMgbWF4aW11bSBiaXRtYXAgc2l6ZSB0byAyNTZNQiB3aGljaA0KPm1hcHMNCj4+
PiB0bw0KPj4+Pj4gOFRCIG9uDQo+Pj4+Pj4gNEsgcGFnZSBzeXN0ZW0sIHdoZW4gMTZUQiBzaXpl
ZCBVTk1BUCBub3RpZmljYXRpb24gaXMgc2VudCwNCj4+Pj4+IHVubWFwX2JpdG1hcA0KPj4+Pj4+
IGlvY3RsIGZhaWxzLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhlcmUgaXMgbm8gc3VjaCBsaW1pdGF0aW9u
IHdpdGggaW9tbXVmZCBiYWNrZW5kLCBidXQgaXQncyBzdGlsbCBub3QNCj5vcHRpbWFsDQo+Pj4+
Pj4gdG8gYWxsb2NhdGUgbGFyZ2UgYml0bWFwLg0KPj4+Pj4+DQo+Pj4+Pj4gT3B0aW1pemUgaXQg
YnkgaXRlcmF0aW5nIG92ZXIgRE1BTWFwIGxpc3QgdG8gdW5tYXAgZWFjaCByYW5nZSB3aXRoDQo+
Pj4gYWN0aXZlDQo+Pj4+Pj4gbWFwcGluZyB3aGVuIG1pZ3JhdGlvbiBpcyBhY3RpdmUuIElmIG1p
Z3JhdGlvbiBpcyBub3QgYWN0aXZlLA0KPnVubWFwcGluZw0KPj4+IHRoZQ0KPj4+Pj4+IHdob2xl
IGFkZHJlc3Mgc3BhY2UgaW4gb25lIGdvIGlzIG9wdGltYWwuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+
Pj4+IFRlc3RlZC1ieTogR2lvdmFubmlvIENhYmlkZHUgPGdpb3Zhbm5pLmNhYmlkZHVAaW50ZWwu
Y29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCA0Mg0K
Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4g
ICAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
Pj4+Pj4gaW5kZXggODNjNWU0NDQxMy4uNjg3NmRhZTcyNyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+Pj4+PiBAQCAtMzcsNiArMzcsNyBAQA0KPj4+Pj4+ICAgICAjaW5jbHVkZSAic3lzdGVtL3N5
c3RlbS5oIg0KPj4+Pj4+ICAgICAjaW5jbHVkZSAiaHcvaTM4Ni9hcGljX2ludGVybmFsLmgiDQo+
Pj4+Pj4gICAgICNpbmNsdWRlICJrdm0va3ZtX2kzODYuaCINCj4+Pj4+PiArI2luY2x1ZGUgIm1p
Z3JhdGlvbi9taXNjLmgiDQo+Pj4+Pj4gICAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5o
Ig0KPj4+Pj4+ICAgICAjaW5jbHVkZSAidHJhY2UuaCINCj4+Pj4+Pg0KPj4+Pj4+IEBAIC00NDIz
LDYgKzQ0MjQsNDIgQEAgc3RhdGljIHZvaWQNCj4+Pj4+IHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2
aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCj4+Pj4+PiAgICAgICAg
IHZ0ZF9pb21tdV91bmxvY2socyk7DQo+Pj4+Pj4gICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICsvKg0K
Pj4+Pj4+ICsgKiBVbm1hcHBpbmcgYSBsYXJnZSByYW5nZSBpbiBvbmUgZ28gaXMgbm90IG9wdGlt
YWwgZHVyaW5nIG1pZ3JhdGlvbg0KPj4+Pj4gYmVjYXVzZQ0KPj4+Pj4+ICsgKiBhIGxhcmdlIGRp
cnR5IGJpdG1hcCBuZWVkcyB0byBiZSBhbGxvY2F0ZWQgd2hpbGUgdGhlcmUgbWF5IGJlIG9ubHkN
Cj4+PiBzbWFsbA0KPj4+Pj4+ICsgKiBtYXBwaW5ncywgaXRlcmF0ZSBvdmVyIERNQU1hcCBsaXN0
IHRvIHVubWFwIGVhY2ggcmFuZ2Ugd2l0aA0KPmFjdGl2ZQ0KPj4+Pj4gbWFwcGluZy4NCj4+Pj4+
PiArICovDQo+Pj4+Pj4gK3N0YXRpYyB2b2lkDQo+dnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXBfaW5f
bWlncmF0aW9uKFZUREFkZHJlc3NTcGFjZQ0KPj4+Pj4gKmFzLA0KPj4+Pj4+ICsNCj4+Pj4+IElP
TU1VTm90aWZpZXIgKm4pDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArICAgIGNvbnN0IERNQU1hcCAqbWFw
Ow0KPj4+Pj4+ICsgICAgY29uc3QgRE1BTWFwIHRhcmdldCA9IHsNCj4+Pj4+PiArICAgICAgICAu
aW92YSA9IG4tPnN0YXJ0LA0KPj4+Pj4+ICsgICAgICAgIC5zaXplID0gbi0+ZW5kLA0KPj4+Pj4+
ICsgICAgfTsNCj4+Pj4+PiArICAgIElPVkFUcmVlICp0cmVlID0gYXMtPmlvdmFfdHJlZTsNCj4+
Pj4+PiArDQo+Pj4+Pj4gKyAgICAvKg0KPj4+Pj4+ICsgICAgICogRE1BTWFwIGlzIGNyZWF0ZWQg
ZHVyaW5nIElPTU1VIHBhZ2UgdGFibGUgc3luYywgaXQncyBlaXRoZXINCj4+PiA0S0INCj4+Pj4+
IG9yIGh1Z2UNCj4+Pj4+PiArICAgICAqIHBhZ2Ugc2l6ZSBhbmQgYWx3YXlzIGEgcG93ZXIgb2Yg
MiBpbiBzaXplLiBTbyB0aGUgcmFuZ2Ugb2YNCj4+Pj4+IERNQU1hcCBjb3VsZA0KPj4+Pj4+ICsg
ICAgICogYmUgdXNlZCBmb3IgVU5NQVAgbm90aWZpY2F0aW9uIGRpcmVjdGx5Lg0KPj4+Pj4+ICsg
ICAgICovDQo+Pj4+Pj4gKyAgICB3aGlsZSAoKG1hcCA9IGlvdmFfdHJlZV9maW5kKHRyZWUsICZ0
YXJnZXQpKSkgew0KPj4+Pj4NCj4+Pj4+IGhvdyBhYm91dCBhbiBlbXB0eSBpb3ZhX3RyZWU/IElm
IGd1ZXN0IGhhcyBub3QgbWFwcGVkIGFueXRoaW5nIGZvcg0KPnRoZQ0KPj4+Pj4gZGV2aWNlLCB0
aGUgdHJlZSBpcyBlbXB0eS4gQW5kIGl0IGlzIGZpbmUgdG8gbm90IHVubWFwIGFueXRpbmcuIFdo
aWxlLA0KPj4+Pj4gaWYgdGhlIGRldmljZSBpcyBhdHRhY2hlZCB0byBhbiBpZGVudGlmeSBkb21h
aW4sIHRoZSBpb3ZhX3RyZWUgaXMgZW1wdHkNCj4+Pj4+IGFzIHdlbGwuIEFyZSB3ZSBzdXJlIHRo
YXQgd2UgbmVlZCBub3QgdG8gdW5tYXAgYW55dGhpbmcgaGVyZT8gSXQgbG9va3MNCj4+Pj4+IHRo
ZSBhbnN3ZXIgaXMgeWVzLiBCdXQgSSdtIHN1c3BlY3RpbmcgdGhlIHVubWFwIGZhaWx1cmUgd2ls
bCBoYXBwZW4gaW4NCj4+Pj4+IHRoZSB2ZmlvIHNpZGU/IElmIHllcywgbmVlZCB0byBjb25zaWRl
ciBhIGNvbXBsZXRlIGZpeC4gOikNCj4+Pj4NCj4+Pj4gTm90IGdldCB3aGF0IGZhaWx1cmUgd2ls
bCBoYXBwZW4sIGNvdWxkIHlvdSBlbGFib3JhdGU/DQo+Pj4+IEluIGNhc2Ugb2YgaWRlbnRpdHkg
ZG9tYWluLCBJT01NVSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCBubyBpb21tdQ0KPj4+PiBu
b3RpZmllciB3aWxsIGV2ZXIgYmUgdHJpZ2dlcmVkLiB2ZmlvX2xpc3RlbmVyIG1vbml0b3JzIG1l
bW9yeSBhZGRyZXNzDQo+Pj4gc3BhY2UsDQo+Pj4+IGlmIGFueSBtZW1vcnkgcmVnaW9uIGlzIGRp
c2FibGVkLCB2ZmlvX2xpc3RlbmVyIHdpbGwgY2F0Y2ggaXQgYW5kIGRvIGRpcnR5DQo+Pj4gdHJh
Y2tpbmcuDQo+Pj4NCj4+PiBNeSBxdWVzdGlvbiBjb21lcyBmcm9tIHRoZSByZWFzb24gd2h5IERN
QSB1bm1hcCBmYWlscy4gSXQgaXMgZHVlIHRvDQo+Pj4gYSBiaWcgcmFuZ2UgaXMgZ2l2ZW4gdG8g
a2VybmVsIHdoaWxlIGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0LiBTbyBpZg0KPj4+IFZGSU8gZ2l2
ZXMgYSBiaWcgcmFuZ2UgYXMgd2VsbCwgaXQgc2hvdWxkIGZhaWwgYXMgd2VsbC4gQW5kIHRoaXMg
aXMNCj4+PiBwb3NzaWJsZSB3aGVuIGd1ZXN0IChhIFZNIHdpdGggbGFyZ2Ugc2l6ZSBtZW1vcnkp
IHN3aXRjaGVzIGZyb20gaWRlbnRpZnkNCj4+PiBkb21haW4gdG8gYSBwYWdpbmcgZG9tYWluLiBJ
biB0aGlzIGNhc2UsIHZmaW9fbGlzdGVuZXIgd2lsbCB1bm1hcCBhbGwNCj4+PiB0aGUgc3lzdGVt
IE1Scy4gQW5kIGl0IGNhbiBiZSBhIGJpZyByYW5nZSBpZiBWTSBzaXplIGlzIGJpZyBlbm91Z2gu
DQo+Pg0KPj4gR290IHlvdSBwb2ludC4gWWVzLCBjdXJyZW50bHkgdmZpb190eXBlMSBkcml2ZXIg
bGltaXRzIHVubWFwX2JpdG1hcCB0byA4VEINCj5zaXplLg0KPj4gSWYgZ3Vlc3QgbWVtb3J5IGlz
IGxhcmdlIGVub3VnaCBhbmQgbGVhZCB0byBhIG1lbW9yeSByZWdpb24gb2YgbW9yZSB0aGFuDQo+
OFRCIHNpemUsDQo+PiB1bm1hcF9iaXRtYXAgd2lsbCBmYWlsLiBJdCdzIGEgcmFyZSBjYXNlIHRv
IGxpdmUgbWlncmF0ZSBWTSB3aXRoIG1vcmUgdGhhbg0KPjhUQiBtZW1vcnksDQo+PiBpbnN0ZWFk
IG9mIGZpeGluZyBpdCBpbiBxZW11IHdpdGggY29tcGxleCBjaGFuZ2UsIEknZCBzdWdnZXN0IHRv
IGJ1bXAgYmVsb3cNCj5NQUNSTw0KPj4gdmFsdWUgdG8gZW5sYXJnZSB0aGUgbGltaXQgaW4ga2Vy
bmVsLCBvciBzd2l0Y2ggdG8gdXNlIGlvbW11ZmQgd2hpY2ggZG9lc24ndA0KPmhhdmUgc3VjaCBs
aW1pdC4NCj4NCj5UaGlzIGxpbWl0IHNoYWxsIG5vdCBhZmZlY3QgdGhlIHVzYWdlIG9mIGRldmlj
ZSBkaXJ0eSB0cmFja2luZy4gcmlnaHQ/DQo+SWYgeWVzLCBhZGQgc29tZXRoaW5nIHRvIHRlbGwg
dXNlciB1c2UgaW9tbXVmZCBiYWNrZW5kIGlzIGJldHRlci4gZS5nDQo+aWYgbWVtb3J5IHNpemUg
aXMgYmlnZ2VyIHRoYW4gdGhlIGxpbWl0IG9mIHZmaW8gaW9tbXUgdHlwZTEncyBkaXJ0eQ0KPmJp
dG1hcCBsaW1pdCAocXVlcnkgY2FwX21pZy5tYXhfZGlydHlfYml0bWFwX3NpemUpLCB0aGVuIGZh
aWwgdXNlciBpZg0KPnVzZXIgd2FudHMgbWlncmF0aW9uIGNhcGFiaWxpdHkuDQoNCkRvIHlvdSBt
ZWFuIGp1c3QgZGlydHkgdHJhY2tpbmcgaW5zdGVhZCBvZiBtaWdyYXRpb24sIGxpa2UgZGlydHly
YXRlPw0KSW4gdGhhdCBjYXNlLCB0aGVyZSBpcyBlcnJvciBwcmludCBhcyBhYm92ZSwgSSB0aGlu
ayB0aGF0J3MgZW5vdWdoIGFzIGEgaGludD8NCg0KSSBndWVzcyB5b3UgbWVhbiB0byBhZGQgYSBt
aWdyYXRpb24gYmxvY2tlciBpZiBsaW1pdCBpcyByZWFjaGVkPyBJdCdzIGhhcmQNCmJlY2F1c2Ug
dGhlIGxpbWl0IGlzIG9ubHkgaGVscGZ1bCBmb3IgaWRlbnRpdHkgZG9tYWluLCBETUEgZG9tYWlu
IGluIGd1ZXN0DQpkb2Vzbid0IGhhdmUgc3VjaCBsaW1pdCwgYW5kIHdlIGNhbid0IGtub3cgZ3Vl
c3QncyBjaG9pY2Ugb2YgZG9tYWluIHR5cGUNCm9mIGVhY2ggVkZJTyBkZXZpY2UgYXR0YWNoZWQu
DQoNCj4NCj4+IC8qDQo+PiAgICogSW5wdXQgYXJndW1lbnQgb2YgbnVtYmVyIG9mIGJpdHMgdG8g
Yml0bWFwX3NldCgpIGlzIHVuc2lnbmVkIGludGVnZXIsDQo+d2hpY2gNCj4+ICAgKiBmdXJ0aGVy
IGNhc3RzIHRvIHNpZ25lZCBpbnRlZ2VyIGZvciB1bmFsaWduZWQgbXVsdGktYml0IG9wZXJhdGlv
biwNCj4+ICAgKiBfX2JpdG1hcF9zZXQoKS4NCj4+ICAgKiBUaGVuIG1heGltdW0gYml0bWFwIHNp
emUgc3VwcG9ydGVkIGlzIDJeMzEgYml0cyBkaXZpZGVkIGJ5IDJeMw0KPmJpdHMvYnl0ZSwNCj4+
ICAgKiB0aGF0IGlzIDJeMjggKDI1NiBNQikgd2hpY2ggbWFwcyB0byAyXjMxICogMl4xMiA9IDJe
NDMgKDhUQikgb24gNEsNCj5wYWdlDQo+PiAgICogc3lzdGVtLg0KPj4gICAqLw0KPj4gI2RlZmlu
ZSBESVJUWV9CSVRNQVBfUEFHRVNfTUFYICAgKCh1NjQpSU5UX01BWCkNCj4+ICNkZWZpbmUgRElS
VFlfQklUTUFQX1NJWkVfTUFYDQo+RElSVFlfQklUTUFQX0JZVEVTKERJUlRZX0JJVE1BUF9QQUdF
U19NQVgpDQo+Pg0KPj4+DQo+Pj4+Pg0KPj4+Pj4+ICsgICAgICAgIElPTU1VVExCRXZlbnQgZXZl
bnQ7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklF
Ul9VTk1BUDsNCj4+Pj4+PiArICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gbWFwLT5pb3ZhOw0K
Pj4+Pj4+ICsgICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IG1hcC0+c2l6ZTsNCj4+Pj4+
PiArICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7
DQo+Pj4+Pj4gKyAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+Pj4+Pj4g
KyAgICAgICAgLyogVGhpcyBmaWVsZCBpcyBtZWFuaW5nbGVzcyBmb3IgdW5tYXAgKi8NCj4+Pj4+
PiArICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4+Pj4+ICsgICAg
ICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11X29uZShuLCAmZXZlbnQpOw0KPj4+Pj4+ICsN
Cj4+Pj4+PiArICAgICAgICBpb3ZhX3RyZWVfcmVtb3ZlKHRyZWUsICptYXApOw0KPj4+Pj4+ICsg
ICAgfQ0KPj4+Pj4+ICt9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICAgICAvKiBVbm1hcCB0aGUgd2hvbGUg
cmFuZ2UgaW4gdGhlIG5vdGlmaWVyJ3Mgc2NvcGUuICovDQo+Pj4+Pj4gICAgIHN0YXRpYyB2b2lk
IHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMsDQo+Pj4+PiBJT01N
VU5vdGlmaWVyICpuKQ0KPj4+Pj4+ICAgICB7DQo+Pj4+Pj4gQEAgLTQ0MzIsNiArNDQ2OSwxMSBA
QCBzdGF0aWMgdm9pZA0KPj4+Pj4gdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1Nw
YWNlICphcywgSU9NTVVOb3RpZmllciAqbikNCj4+Pj4+PiAgICAgICAgIEludGVsSU9NTVVTdGF0
ZSAqcyA9IGFzLT5pb21tdV9zdGF0ZTsNCj4+Pj4+PiAgICAgICAgIERNQU1hcCBtYXA7DQo+Pj4+
Pj4NCj4+Pj4+PiArICAgIGlmIChtaWdyYXRpb25faXNfcnVubmluZygpKSB7DQo+Pj4+Pg0KPj4+
Pj4gSWYgdGhlIHJhbmdlIGlzIG5vdCBiaWcgZW5vdWdoLCBpdCBpcyBzdGlsbCBiZXR0ZXIgdG8g
dW5tYXAgaW4gb25lLWdvLg0KPj4+Pj4gcmlnaHQ/IElmIHNvLCBtaWdodCBhZGQgYSBjaGVjayBv
biB0aGUgcmFuZ2UgaGVyZSB0byBnbyB0byB0aGUgaW92YV90ZWUNCj4+Pj4+IGl0ZXJhdGlvbiBj
b25kaXRpb25hbGx5Lg0KPj4+Pg0KPj4+PiBXZSBkb24ndCB3YW50IHRvIGRpdHJ5IHRyYWNrIElP
VkEgaG9sZXMgYmV0d2VlbiBJT1ZBIHJhbmdlcyBiZWNhdXNlDQo+aXQncw0KPj4+IHRpbWUgY29u
c3VtaW5nIGFuZCB1c2VsZXNzIHdvcmsuIFRoZSBob2xlIG1heSBiZSBsYXJnZSBkZXBlbmRpbmcg
b24NCj5ndWVzdA0KPj4+IGJlaGF2aW9yLg0KPj4+PiBNZWFud2hpbGUgdGhlIHRpbWUgaXRlcmF0
aW5nIG9uIGlvdmFfdHJlZSBpcyB0cml2aWFsLiBTbyB3ZSBwcmVmZXIgdHJhY2tpbmcNCj4+PiB0
aGUgZXhhY3QgaW92YSByYW5nZXMgdGhhdCBtYXkgYmUgZGlydHkgYWN0dWFsbHkuDQo+Pj4NCj4+
PiBJIHNlZS4gU28gdGhpcyBpcyB0aGUgb3B0aW1pemF0aW9uLiBBbmQgaXQgYWxzbyBXQSB0aGUg
YWJvdmUgRE1BDQo+Pj4gdW5tYXAgaXNzdWUgYXMgd2VsbC4gcmlnaHQ/IElmIHNvLCB5b3UgbWF5
IHdhbnQgdG8gY2FsbCBvdXQgaW4gdGhlDQo+Pj4gY29tbWl0IG1lc3NhZ2UuDQo+Pg0KPj4gWWVz
LCB0aGUgbWFpbiBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gZml4IHRoZSB1bm1hcF9iaXRt
YXAgaXNzdWUsIHRoZW4NCj50aGUgb3B0aW1pemF0aW9uLg0KPj4gSSdsbCByZXBocmFzZSB0aGUg
ZGVzY3JpcHRpb24gYW5kIHN1YmplY3QuDQo+DQo+eWVzLiBUaGUgY29tbWl0IG1lc3NhZ2UgZ2l2
ZXMgbWUgdGhlIGltcHJlc3Npb24gdGhpcyBpcyBidWcgZml4LiBXaGlsZQ0KPnN1YmplY3QgaXMg
b3B0aW1pemF0aW9uLiBCVFcuIHBlcmhhcHMgY2FsbCBpdCBhcyBhbiBvcHRpbWl6YXRpb24gaXMN
Cj5jbGVhcmVyIHNpbmNlIHRoaXMgc21lbGxzIG1vcmUgbGlrZSBhbiBvcHRpbWl6YXRpb24uIEZv
ciBmaXgsIEkgZ3Vlc3MNCj55b3UgbWF5IG5lZWQgdG8gY29uc2lkZXIgdGhlIHZmaW9fbGlzdGVu
ZXIgYXMgd2VsbC4NCg0KRG8geW91IGhhdmUgYW55IGlkZWEgdG8gZml4IGl0IHdpdGggdmZpb19s
aXN0ZW5lcj8NCg0KTXkgdW5kZXJzdGFuZGluZyBpcywgaXQncyBoYXJkIHRvIGZpeCB0aGlzIGlz
c3VlIGZyb20gdmZpbyBjb3JlLCBiZWNhdXNlIHZmaW9fbGlzdGVuZXIgZG9lc24ndA0Ka25vdyB0
aGUgbWFwcGluZyBkZXRhaWxzIGluIHRoZSBndWVzdCwgb25seSB2SU9NTVUgY2FjaGVkIHRoZW0g
dGhyb3VnaCBETUFNYXAuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

