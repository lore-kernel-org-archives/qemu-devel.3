Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703BAC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwmM-0000LA-K0; Sun, 26 Jan 2025 02:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbwmL-0000KH-3H
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:09:57 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbwmI-000393-6y
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737875395; x=1769411395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6PB8luPDgENOHE/CnF1D8p/vQ3xQNxGAuN6/G14P1Es=;
 b=n6+YPKs/aBdbLv60+lO0u1drLGExwNVZHoCHbYbf+Ww/nOMAv4sJX53P
 86PlN0+5YJ1jIEjSFTI8g3OkrwPBQTP+KtFFjgQhMyfZ2K6nYiV5Q8rbS
 VK7T26T7aggxq3tS+zE3EZQj4O8SqBo6+aLx+h94JinpNtUhA33Z2jWfa
 JsXNYYjJ7xEHMPgyGebCiVbiYxq5ldkUHYBFzr6noyOffDFnPBKh0Q7mh
 dJOzHh7p155QoxQMh2ku5MQjoN9Zpt/22U2pM25rkMkFhWoEU9wlJdSeq
 2kNW5IlHrxEICXKFSq6ZKLkeH8KzY4Ngv0LhK+sFQtPMtGkHA0d8nDDM8 A==;
X-CSE-ConnectionGUID: /L18cXGkRvKphpRWA2IIBw==
X-CSE-MsgGUID: LHoZxzq3Tie5UOEXaotktQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="38500468"
X-IronPort-AV: E=Sophos;i="6.13,235,1732608000"; d="scan'208";a="38500468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 23:09:48 -0800
X-CSE-ConnectionGUID: tuNS5kn9SAC+4vsfOqFFxg==
X-CSE-MsgGUID: WyuUDYRvQaaYf/Hfh+4VqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145385292"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Jan 2025 23:09:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 23:09:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 23:09:46 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 23:09:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0EWCr4R78xdFqh8w9gVoOaf4/7BDEejCaA2+m67+fOwbuLhqjDXxP/oJt6PYjWkUw56wfopJ5x3jvf1dUqvCilfIcNC219buW8ktpUt30ODAqGnHNbfUjB4wj7QQtCI9L7d8L9NxI5jdbAYTXH/IzoU+z8/OW2omBTgZEnyCEca/ztw73moxCUMxru6gQGsDELvzpmzZZNGWCw0nicRRcBuWhCONpF+kU9bn9LsCdxXv26+Y+2OWe6DgtA/LSmB3+MeNq8Rh3dHUbe7Y41e64ebTU+5+MsHC0r2SqMZQjV/4qQzA2iOzkzwHvPIIp/y92w/2cPSDdqJYlPBGQ60qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PB8luPDgENOHE/CnF1D8p/vQ3xQNxGAuN6/G14P1Es=;
 b=IpWNAN4YYCT2qQcWMdeuyqFPnGjsTmO5lV1E+WQ9fo0uQVQx49qtI5O7T17bj/B594rgZseFHFb65axKbdpViIx9QMOGC2raa+uZcoSBo2bXLGwCckhVDZMNaLcCVp9zFxqwKk0wKuwduIIuJkweoIeWvvRARaYlXLI6skm39O4Rrd5AUOKvQmv0X51JWot/o8hkosRBshmkTtQ2ZIzOf1YumvopFru+E+ONa0XB0P9JyQ3NxxKtkUA7UYl8POGiHMM+MqhgBV8CVSbew8uZpqz4ERScb1PLtpayHMzi/cwyJRP/Ls7WZ+ZpU9yYTabyEV5mRLPwmZrYyoqW6F0VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 07:09:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8377.009; Sun, 26 Jan 2025
 07:09:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Wang
 <jasowang@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMgkh0AgADZNgCAAPlEgIAACqIAgAEnzgCAAHSwAIABLInggAEBMgCAAnCuMA==
Date: Sun, 26 Jan 2025 07:09:39 +0000
Message-ID: <SJ0PR11MB6744217E04903D601857AB9192ED2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0f8ed4d7-c4f7-46f8-a9e9-75d7a1e0cba4@redhat.com>
In-Reply-To: <0f8ed4d7-c4f7-46f8-a9e9-75d7a1e0cba4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8307:EE_
x-ms-office365-filtering-correlation-id: 68fc55d5-e7cb-4edb-439e-08dd3dd8667c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFF0NlZqdnFsTGEyY0RIUEZRUHRQZTU3SGQ4RHcxWlV1ZXV4QUkvcndOYmxP?=
 =?utf-8?B?SFV3cFN5azd4SytXSmoxYk0vRmEyVVNKOHFpejVHNVd0Y2hCdHZnWldwNUhj?=
 =?utf-8?B?UlpTSitiWGZnd0VyT3N2MC84NjNKZmVWYks5NGJTUG8wc1JSSkdBMkFKd0Fm?=
 =?utf-8?B?c1FPdFh5bUpkOWl4NXcrK0tUeE1iRGc5YTR5V1JkRnF3SmNZN0gvY2ZnV2lQ?=
 =?utf-8?B?bGxpbFo2VUVUQXl4VHVWSS9lK1FuTU9xdWplR20rVDduQ29nV3pxci9TM0xx?=
 =?utf-8?B?MEZBU3d6UzhwY3ZNZGs4NTZjeFd6Wm0yc2p6ZW9PR3lwbXJjZ3BRanltN3dt?=
 =?utf-8?B?Q28rcDUrTTlwWTZmM1V3WlZhQ3ZTaFV6bGp4MjE1QVRHSDF0RTB3YUh1YnVP?=
 =?utf-8?B?OVBickpjU0MwSi9WRm9TM3hXa25kTGVKVU5sL0NxQnNqZXRScS9KdFF1MHZS?=
 =?utf-8?B?KzFERlhBTzBuQWFLWWM0dWx4UitWVnFIcWZKdTh0VllyTEQ2V1Z0OFpLdkND?=
 =?utf-8?B?WUpSOGJRU082MjhQTGMvallodjg5bVdlai84Q0ErMEF4aGhjZFE4WmxRNk1B?=
 =?utf-8?B?dXp2VU5lcTd5azNzTWJtbFlLWTNYN0syMWlGdTBnTXplN1ZtajBQeU41V0RL?=
 =?utf-8?B?WjRpbFBZeDl4K1ZGK1I1TEppSC80L01uNGhjZitVZzhheHVFUWJNZzRTTmhN?=
 =?utf-8?B?TzNnZEVTTzh3eTdlZXkvOE52QlBoeHFqY2l1U2I3Y0NiRldmRE1zNFdVdHpq?=
 =?utf-8?B?UjRZU3hyd3NTbm9EbkpGTERVbXV4OU9EVEl0eGZob3dHMmhNUnY5M2ExS3BP?=
 =?utf-8?B?RUI3cmMrYzVuYmFWVDI2aEsvY29sTHEySkFSVlo2VmdJNURsTXNWa05kb2py?=
 =?utf-8?B?emNtTTJmMkd6ZnhSTUd6K1ZORjhtaFNXd1d4TGZnVnlGZXNKZjZMTFo1VFJh?=
 =?utf-8?B?TEkvRTVQU2tlVk0vL3F2UitRazNITkJJMXBLdStub21qU2IwU3N2MzZqYmtk?=
 =?utf-8?B?c0NRQUgwWnpaNWtrUmMyN1dQOFBIZ3Ruc2ZyZWFzWERZOVZDelpneFFuQVhi?=
 =?utf-8?B?bSt1VEdKY3ZVajZ4Q1dVa3prTXBxUjNKbncrUzhFMUZObW9HN2dCbngzT0Fs?=
 =?utf-8?B?ZGI5VmEySnB2L21XQnlPSGtJa3RhQTc2VWdMUk5nRitNR2tqeVoyNnp2YWty?=
 =?utf-8?B?dFhNYU5ZTkJLQng0MVZUVStGbGl3djh1YSs1OXhob2I1MkZsRlcxNTBNZTVI?=
 =?utf-8?B?MGtVMGtmYVNWSW9sUE80VDFLeGxiNG15d0hIZkd1OWVrdHUyNmpmWmJpOVR6?=
 =?utf-8?B?L0xodHdUTlUrdnRxQy9odUY5RmJWN2xkSzdXSWhPbUQ5Z0VpajREY1JVNmdZ?=
 =?utf-8?B?QUVjeVduUHBnTzgvZDZSUjh4aUlBcHZzVVBaZGE3U2p2OWxKb2RqRDA3ZWJj?=
 =?utf-8?B?VGNjNTR2N2JIY2xxNzdkdkhmMUV2UEhNVjB2Tm9rSmJ4aWQzekRPTkZEQWNa?=
 =?utf-8?B?QlgyMjNxbzIwMmNNdHo5QmQwUlZVaGhqeDZBMFFXUTZ1TkI2eG1saHBJL2hi?=
 =?utf-8?B?dEZ0UFFPdFViVk93WUNRQjlnVGk3a2VaVlo3SkFZeXRLVDJycEVFTng0eXp6?=
 =?utf-8?B?eVhDVmd5ZFFUcTZpQ2RzMUZkMHRKcHlKd21GL2VIZGIzR1IrZFM5VmR0OGFS?=
 =?utf-8?B?UjFFNjNRM1NsOENKZ1BGZysvcHQ0V1h6YlhqRmpNTjB0TDFqbnNzZ0JnZXd1?=
 =?utf-8?B?V200VUw2bFhqbU9mdDBib0k5eEhJM1R0a0twdlZTQlNZbmtBb1lTRUIvUnI1?=
 =?utf-8?B?dzNHb3UxNjhnNW05QmNSMTdYSmVjT0xRQWlpeWFvOEhsUjBnKzFkN3IxbTBw?=
 =?utf-8?B?VVpBWGFVbTFMbUlTY0lYVVZXdW1jMGRQdnpUZExyamFiMFhvYnN4SDlFdDB1?=
 =?utf-8?Q?nMNnyU1hVASekJDz5PcWflxK7KVa2Wlk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjNHRE94OVdKRUkyUFhoWFd1S28xSkVwK2thYkowV0E4RERmMmIxeUZFSDU5?=
 =?utf-8?B?ZzRuTk4yU1VHVHRqaWNDcDhENW9iSzNZdmNYb3diVE8xQzZWeks4bUk1bmEx?=
 =?utf-8?B?dktJVlV5L0t1RENUTGpCNnFndVhXVFJaUkYzTG9DWVhpUWZxS2VtbU1FbkhC?=
 =?utf-8?B?YVRaSXlETmltQXJzQ3ZSSm0yMmF2M01idmNRU1pSTGFPcWxyUjRTclN4MklC?=
 =?utf-8?B?c2FmbUVvSnRFSC9XU3c2VzY3OCtrWXhEbTgzT29WZHRqb1YweTdFZ2ZmRnRn?=
 =?utf-8?B?ZkJmUzFraHFJbTkreDUzc25pWFlPbFhQdXQxdXdGdm4rK0dtZFBuTjlkVjVh?=
 =?utf-8?B?RkpxVmk0RDFiTHhrWUcySis0OVZQQ3ArV0p2MDk3TElvbHlPeGxEaWgzZ2ZH?=
 =?utf-8?B?WjduMHhRZG5XMmVuQkJ4cEF2WGpZUWV1OEJBM0VOM1hkR0RGSGZkNTdmN0Jj?=
 =?utf-8?B?MVd3Wk5naTZYRWpTMUZ2N0w4dEp4aEZwUkM1c2dmSEpiNTVSY0p4L2JncEFT?=
 =?utf-8?B?bHFmSkFzREdlNVMwRGVtWEkxOU1OZEs0UWFUbVFMdm1yc3AxWlNSTEtzdjJR?=
 =?utf-8?B?YjM2Y25pa0JhOGdJRFNoSGVmbTEzMW8zRlBhVGZVMWlkRlNXcWlWWk1XazhP?=
 =?utf-8?B?MUpvRnRadHRRMXVLTktaU2w5YWVyRmduZWZBMFlyaTVMRzcyVFhxOVRvUVMv?=
 =?utf-8?B?ZlJVUk4xR1FtY2FieDJzcFlGSk5rVE9lVlczYmFyMTV6MmRmd3NsRzgrK2Fx?=
 =?utf-8?B?NzhjZVVBSWJYc094VnhtejU4VmFaOTF2Z0w0Nmw3WFdNNWpnTVliYzZLLzRU?=
 =?utf-8?B?dkRlNkdkcENPTE5QejJIMlVBRDZlaHkvVERWQ3V3TCtkSVdvaUpoYnc2VUl1?=
 =?utf-8?B?M1Z2MmlOVzYzU0pySmdSRzNOQmFwOFY1eDFydUJIcUNZVVBDa2FJWGJESy9z?=
 =?utf-8?B?TlhNM3VNM2paRE54Mk40NWV5ZElqcmZOTUlJN01BZGJHVFl0aUVHN1dtRGtq?=
 =?utf-8?B?ODFyN2RIUWd0VjVZcm1ZK1hDK3p0VGk3RXNjTUxzTGhrYzRLdTdXbk5EOGRi?=
 =?utf-8?B?eVFUbDB2V1hWVHU5OUIzcjRHT3VrbVh6QXh5a0J5UVgyRkhCUm56Ym8rZ3lK?=
 =?utf-8?B?amJudmF6SmdmQUlPTjhjdEpMc00xVEZHa00zK2J0U1c2Y29yMFRrZzNrdGJk?=
 =?utf-8?B?UVF0eUYzNjJYWEdia0krK2RuTzc2dTR3d0xuT3liV1I3cG5OZHFEbFZLTk1v?=
 =?utf-8?B?Y0FMNUZ0WjkwVUFMTEEwdFJTc3Jqd01hYU9tVDMwUzBIbFdIeE5CL1NPK2hI?=
 =?utf-8?B?VldBOENDSUMzbXpuVmFGcW43YlQ4eWpjeFRBSlpBUHQxV0NQZ2N5QWNocGox?=
 =?utf-8?B?VFhxeG5pVGhYOXZrVGtDZHhFaE82R3BUa3lUQjZFc1RsM1MvOEFVekxubk42?=
 =?utf-8?B?ajh0TUpFZkhjOGEvcENCVUpVNFZ6bXcyNURaTnQxQmduczZyVnQ2WldGTm5O?=
 =?utf-8?B?VFh2YXZLVUdXSk1qbVdGNExocm1IZDJQOXE2NlNndXl0dXhIcmF0ZzdhVEEy?=
 =?utf-8?B?RlBBOVZaQms3YlVTRlBaSjB6Sk9PdWdiZWhrR2l1OW9IamJCTTN1N3J2eVpX?=
 =?utf-8?B?ZTM4MEpmMnVMcG9hVStUTE9PWWMxckh3cFhXYzNycGV3RkJaWVl6eU43QXlD?=
 =?utf-8?B?ZktDVkxNREFWdEhuK1NZNUJNQ1NuMGQ3ZWNkMVV3aGYzZElnY2xRMDcrS1lt?=
 =?utf-8?B?anBFQ1Zac09qcWcrNThKdm1yYkJZWVFpMlQ1cVBxMDdRdFhncGVsLzRnZEwr?=
 =?utf-8?B?R2tLNk54UjRHOW9Pd2xMR2t5NjMyN3pZZ2hJZGREUGR3VHc2aUZsYU9PWHZI?=
 =?utf-8?B?RERHOUc3SFhjT2JGOUZOd3g4MHN4aVl6ckVNenlhYnBRSm9wdlZOelhtdm5t?=
 =?utf-8?B?cFN6MFZFU1lWQ1M0NGpsUHQvTHQvTGV1ZVBkRUh5YkMya1lVZGxhWGZqamxN?=
 =?utf-8?B?aG85QkIyL3JidisrbUJzSUJ6QWtEcC9Mdi9nR1J5T0NZZEg0UU4wdDRZV2ll?=
 =?utf-8?B?ZFJKeFNGd0VVRmx0MmczNWllaDBSYUNXRVl2b3lHRDFEL1VMdWlTZGgyRkF2?=
 =?utf-8?Q?7ZdW1ayZSXMQOdUnCLURF161e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc55d5-e7cb-4edb-439e-08dd3dd8667c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2025 07:09:39.7726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6N9nUUmFD5B1JpNDv0iUWGs3cfqr+Dvn2al4hGpxh9nW8fWMYZwdqopLi9qkLTwbxlRQDgPUMVXiFNPZGn3Fq1SSM/eRKvMwNU4TkcySzKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L3ZpcnRp
by92aG9zdDogRGlzYWJsZSBJT1RMQiBjYWxsYmFja3Mgd2hlbiBJT01NVSBnZXRzDQo+ZGlzYWJs
ZWQNCi4uLg0KPj4+Pj4+IHZ0ZF9hZGRyZXNzX3NwYWNlX3JlZnJlc2hfYWxsKCkgd2lsbCBiYXNp
Y2FsbHkgZGlzYWJsZSB0aGUgaW9tbXUNCj4+Pj4+PiBtZW1vcnkgcmVnaW9uLiBJdCBsb29rcyBu
b3Qgc3VmZmljaWVudCB0byB0cmlnZ2VyIHRoZSByZWdpb25fZGVsDQo+Pj4+Pj4gY2FsbGJhY2ss
IG1heWJlIHdlIHNob3VsZCBkZWxldGUgdGhlIHJlZ2lvbiBvciBpbnRyb2R1Y2UgbGlzdGVuZXIN
Cj4+Pj4+PiBjYWxsYmFjaz8NCj4+Pj4+IFRoaXMgaXMgZXhhY3RseSB0aGUgY29kZSBwYXRoIHdo
aWNoIGlzIGVudGVyZWQgaW4gbXkgdXNlIGNhc2UuDQo+Pj4+Pg0KPj4+Pj4gdnRkX2FkZHJlc3Nf
c3BhY2VfcmVmcmVzaF9hbGwocykgaW5kdWNlcyB0aGUgdmhvc3RfaW9tbXVfcmVnaW9uX2RlbC4g
QnV0DQo+Pj4gZ2l2ZW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50IG9mIHRoaXMgbGF0dGVyIHRoZSBJ
T1RMQiBjYWxsYmFjayBpcyBub3QgdW5zZXQgYW5kDQo+dGhlDQo+Pj4ga2VybmVsIElPVExCIGlz
IG5vdCByZWZyZXNoZWQuIEFsc28gYXMgSSBwb2ludGVkIG91dCB0aGUgIGhkZXYtPm1lbS0+cmVn
aW9ucw0KPmFyZQ0KPj4+IG5vdCB1cGRhdGVkPyBzaG91bGRuJ3QgdGhleS4gQ2FuIHlvdSBleHBs
YWluIHdoYXQgdGhleSBjb3JyZXNwb25kIHRvPw0KPj4+PiBBZGRpbmcgUGV0ZXIgZm9yIG1vcmUg
aWRlYXMuDQo+Pj4+DQo+Pj4+IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gZmluZCBhIHdheSB0byB0
cmlnZ2VyIHRoZSBsaXN0ZW5lciBoZXJlLCBwcm9iYWJseToNCj4+Pj4NCj4+Pj4gMSkgYWRkL2Rl
bGV0ZSB0aGUgbWVtb3J5IHJlZ2lvbnMgaW5zdGVhZCBvZiBlbmFibGUvZGlzYWJsZQ0KPj4+IHNv
cnJ5IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBUaGUgdmhvc3RfaW9tbXVfcmVn
aW9uX2RlbCBjYWxsDQo+Pj4gc3RhY2sgaXMgcHJvdmlkZWQgYmVsb3cgWzFdLiBXcml0ZSB0byB0
aGUgaW50ZWwgaW9tbXUgR0NNRCBURSBiaXQNCj4+PiBpbmR1Y2VzIGEgY2FsbCB0byB2aG9zdF9p
b21tdV9yZWdpb25fZGVsLiBUaGlzIGhhcHBlbnMgYmVmb3JlIHRoZQ0KPj4+IHZob3N0X2Rldl9z
dG9wIHdob3NlIGNhbGwgc3RhY2sgaXMgcHJvdmlkZWQgYmVsb3cgWzJdIGFuZCBvcmlnaW5hdGVz
DQo+PiA+ZnJvbSBhIGJ1cyByZXNldC4NCj4+PiBXZSBtYXkgaGF2ZSBpbmZsaWdodCBJT1RMQiBt
aXNzIHJlcXVlc3RzIGhhcHBlbmluZyBiZXR3ZWVuIGJvdGguDQo+Pj4NCj4+PiBJZiB0aGlzIGhh
cHBlbnMsIHZob3N0X2RldmljZV9pb3RsYl9taXNzKCkgZmFpbHMgYmVjYXVzZSB0aGUgSU9WQSBp
cyBub3QNCj4+PiB0cmFuc2xhdGVkIGFueW1vcmUgYnkgdGhlIElPTU1VIGFuZCB0aGUgaW90bGIu
dHJhbnNsYXRlZF9hZGRyIHJldHVybmVkDQo+Pj4gYnkgYWRkcmVzc19zcGFjZV9nZXRfaW90bGJf
ZW50cnkoKSBpcyBub3Qgd2l0aGluIHRoZSByZWdpc3RlcmVkDQo+Pj4gdmhvc3RfbWVtb3J5X3Jl
Z2lvbnMgbG9va2VkIHVwIGluIHZob3N0X21lbW9yeV9yZWdpb25fbG9va3VwKCksIGhlbmNlDQo+
Pj4gdGhlICJGYWlsIHRvIGxvb2t1cCB0aGUgdHJhbnNsYXRlZCBhZGRyZXNzIiBtZXNzYWdlLg0K
Pj4+DQo+Pj4gSXQgc291bmRzIHdyb25nIHRoYXQgdmhvc3Qga2VlcHMgb24gdXNpbmcgSU9WQXMg
dGhhdCBhcmUgbm90IHRyYW5zbGF0ZWQNCj4+PiBhbnltb3JlLiBJdCBsb29rcyB3ZSBoYXZlIGEg
cmVzZXQgb3JkZXJpbmcgaXNzdWUgYW5kIHRoaXMgcGF0Y2ggaXMganVzdA0KPj4+IHJlbW92aW5n
IHRoZSBzeW1wdG9uIGFuZCBub3QgdGhlIGNhdXNlLg0KPj4+DQo+Pj4gQXQgdGhlIG1vbWVudCBJ
IGRvbid0IHJlYWxseSBnZXQgd2hhdCBpcyBpbml0aWF0aW5nIHRoZSBpbnRlbCBpb21tdSBURQ0K
Pj4+IGJpdCB3cml0ZS4gVGhpcyBpcyBhIGd1ZXN0IGFjdGlvbiBidXQgaXMgaXQgaW5pdGlhdGVk
IGZyb20gYSBtaXNvcmRlcmVkDQo+Pj4gcWVtdSBldmVudD8NCj4+IER1cmluZyByZWJvb3QsIG5h
dGl2ZV9tYWNoaW5lX3NodXRkb3duKCkgY2FsbHMNCj54ODZfcGxhdGZvcm0uaW9tbXVfc2h1dGRv
d24oKQ0KPj4gdG8gZGlzYWJsZSBpb21tdSBiZWZvcmUgcmVzZXQuIFNvIFBldGVyJ3MgcGF0Y2gg
d2lsbCBub3QgYWRkcmVzcyB5b3VyIGlzc3VlLg0KPg0KPkV4YWN0bHkgSSBzZWUgdGhlIGluaXRp
YWwgSU9NTVUgZGlzYWJsZSBjb21lcyBmcm9tIHRoaXMgZ3Vlc3QgY29kZSBwYXRoDQo+KG5hdGl2
ZV9tYWNoaW5lX3NodXRkb3duKS4gSW5kZWVkIHRoaXMgaXMgdW5yZWxhdGVkIHRvIFBldGVyJ3Mg
c2VyaWVzLg0KPlRoZW4gSSBzZWUgdGhhdCB2SU9NTVUgaXMgcmVzZXQgYW5kIHRoZW4gdmhvc3Rf
ZGV2X3N0b3AgaXMgY2FsbGVkICh0aGlzDQo+aXMgcmVsYXRlZCB0byBQZXRlcidzIHNlcmllcyku
DQoNCkFncmVlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

