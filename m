Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EB9C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQTF-0005Rc-Nl; Tue, 03 Jun 2025 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQT4-0005FR-5Q
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:10:13 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMQSy-0002Nl-1g
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748952604; x=1780488604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FdxvgZS8/Kwj130b/ogn4muD6vK0FefxkyNgXT77OXQ=;
 b=eJQrSpZx4O4o3BH0ALAJgAbQOj0zyThQyKXpnXG2gE2K9G1trpJ3dMzl
 t6rlaUMYDQpqSs2qhkJ8iDHAfj5vgL5nS7I3S4RD7gOSDp4lHDZVfysS4
 0YRR569MrP4tcL1HQalGHBLnnUd+LIOUqDGpHkpaZ9svfW67HvmmpCCk7
 Aw/BoaOKaOWhgKX05k9zouda3f9T0YoumQX6VZZEIne8525+aYxQXsIUH
 qJPvbDWQAfN4L3Tf+vWwdkCKuIn18UZBrxgjdy23g2pHyBeDOJnSpJGgx
 A0m9zNOykYhplIRJbbJ53pnDzklyNYIK90BPrt7FsiYobaRG+O0jBOs7o Q==;
X-CSE-ConnectionGUID: sG16R18eTRWEfh24+22syg==
X-CSE-MsgGUID: 76fQWtjpQziS9xtURAcioQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54649874"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="54649874"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 05:10:00 -0700
X-CSE-ConnectionGUID: nfYka/yzREy4eTURsm5rGg==
X-CSE-MsgGUID: d3PuxHzDRwihCdUvO2j55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150129988"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 05:09:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 05:09:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 05:09:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 05:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uof+fyLleudeLZhk07vgD8hFdjJXAM8BGQPLqukGmbHabo+Fb2UKD0GbcmSZME9POyrPxy6JPwJg5JQazmJp0KxXnOIynHSEJibr4vu7rtrbevd/WRIhoK8cuduN6bMHT+72kg0h+LLcScFrTejWdxYVaWH0Ra9sjrTNy2WZEH7egoRUD9TakHNhha4wzovTdS13wjuDRaoNgAm/7Us7nDZYrG07VXRrVMRJOSUWtrydinUd+Map64NMiamMVaxm0/8MTS470W1E6MCsQ7pk1x5J89zCxtSnmzWG6dVzMWGHIKjKahi41nlfZiWxoftr43sgSYNfkpu6NjH2LHlqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdxvgZS8/Kwj130b/ogn4muD6vK0FefxkyNgXT77OXQ=;
 b=M1nZDgRi34sBTiWQSQz6YcKKg7tLhk8YJM3uTyApldgFHLE9M9P8HladfU57D7voMyXQVxVz4QvwD1faXxtCK7gmoF1T1t1o2OuOFaDlEDcncPbNMBjMqrFsh5mDOt6jJB277HH2dZxTROHoFdgiWR/ii/a6tJCqYKA/qyPYHXJjecI/kVzZx/0uax1Om5QjeaJGDdG4CKI19Vwc7JPy91iWNKpYK3rTEE0aoT8aZZPSRwHENf2KJ6hWaiNenWhK9PyHxMn8d5JJnf6zO9yllCLva69sc0RSAyFlo5j+YttD5D2wVS8nNoJzkTP3eWMi+AF53OzDMKTHPc+rPnYjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 12:09:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 12:09:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 00/43] Live update: vfio and iommufd
Thread-Topic: [PATCH V4 00/43] Live update: vfio and iommufd
Thread-Index: AQHb0M9bGlT9zoFbQEG0THmEy/hNELPxW/BQ
Date: Tue, 3 Jun 2025 12:09:43 +0000
Message-ID: <IA3PR11MB9136B5264D8B651B5FB33F5C926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: b5c1df79-5427-408b-19de-08dda297868e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmR0QnFmc3JQUENGRHlrOVpMNFJzYzhZb2txN1BQUUUvMVFIQjdJUGlteUFq?=
 =?utf-8?B?aHhISnQ5Q3d1b1BJV2x5MXRDcjdVeFBDR2hEUDk1ODd5aFV4aFlzNVNXUU55?=
 =?utf-8?B?aUgwQWNnRG40OFlzL3k3SjMyTGNPRWtFUmdEbmtYdjFrbmdUdGdCa1o5M2Y5?=
 =?utf-8?B?VVdXVlNNSytsZTh6bGRWTFpyMytKK1FzZk53aEVmMXpzZ0hsMzlUcEJ3bjgw?=
 =?utf-8?B?UE9VR2VhbnNGSTYzNUxCc2JkVkE4ei95SDFDekd0NXh2bmpmMXBlR0Z1MkYx?=
 =?utf-8?B?VC9FeW1VbHRmWGNCSnN0UVc2LzU5TlVacHZBYk1RbGlXQXI0VDBZNG9rbDZU?=
 =?utf-8?B?dmFvRnozSDdWbWRZaEprR3pPZjVDZUNqZFc5cCt1SDZOOHpEREVvWXRqQ1Ji?=
 =?utf-8?B?MHVXeENkaTBlVmxYNUVOYnBjMWNpWnhRSUR0UjFhaVB6c3RZeXpvYmd1S29W?=
 =?utf-8?B?NDdQSWZhMGdqRklkbVVnMGt2WWFiQ2pSeDZzQ3dyUFI2MHlIcFpvYXhLMVht?=
 =?utf-8?B?d2VpNXhhVTRhd1NSdjV3cUFCWDNmSVF0NjlKMVhDZTU5Rk1ES2ZHSngyNDM0?=
 =?utf-8?B?WkRyMllYcno4aHpSVm5GZWhYTlRmK0tTZm8rWnhQRnR5a1dyQVJpNEE5ZWc3?=
 =?utf-8?B?YjYvekl4M1Q1R0NMV3NtZWd5WVh1YmlyQXVIcGp5enZRT0s1QWFZL1kyVnl1?=
 =?utf-8?B?ZFFSdytmdWd0cnJYVFFqcjNKVE5vb0V0aHNqUHdlVk5rcUxFUWl1T1FkdXZu?=
 =?utf-8?B?RHZKZHVMVE9GclJ5clVOZVk0cWIrUVM1ZWhFckxJdXEwa1VSVis2VmcxUWtE?=
 =?utf-8?B?T3lRdHhZa29razRtaGdjdkZFSDFoQ3lrTWJ4V2hnbnBRY1ZGU0VGNVpZbXVE?=
 =?utf-8?B?Z2U1ekJGNFdGY2JWN0V2TE9HbHUzSVc1aW9BMzdtU0YrSjhrK1YzV0JMUEpa?=
 =?utf-8?B?MWpDaElXSW4xQWUvd1lhNmRtcFFNa0l1QnI2UW5mdWRSR0tMbGt5WitxQnBZ?=
 =?utf-8?B?cW5jdVhRMWlHemk0eWgzWXVjblpBY3V2bCtBT29sVEg2czVJWC9mU1F4UDVa?=
 =?utf-8?B?UW1ZQUxvMkxzRjU4bGMrekNmUXAxMUpURWtYL1ZFTFQ2elRWaWdRNnY3Qnp5?=
 =?utf-8?B?Z0wxS05kc3c1anlFNm4rWUh5VUJaVDZYalNUcHMxcWplTUl6WnpyYjdwenlo?=
 =?utf-8?B?MnJ6UlhZSi8rWmFKdkJkdzdQQWdjdHJhWjdCQjJza0xEOUUxTVBVcXVGcW5M?=
 =?utf-8?B?M2xTMzlHdUJacjNONmtaQWxuRWc1V1BwSlFnTUFZWVRpdWRFU2pLblA0a0N5?=
 =?utf-8?B?Q3AwTkpyektFNmRLUitiWCtnSzhTWkgxMlUybS9vSEpDM013YWxTdldpTkZI?=
 =?utf-8?B?ZXcvQkVWRTZ5ZU9jZDBhWFUrVWhmMUZNa3d6bDJRakhWQnE2MVBxYmJmR1Q5?=
 =?utf-8?B?MHBjTzhMNG1COHFjNldpV245S0pzMVAzOUthaWV3NHZxMkg4ZC9XckQyWVgv?=
 =?utf-8?B?K0UzQVJwYUhCbHcwUzVkMlVBMFdhMmIzY3VjOVVRQXJIaEl2amRSYXZKTVNs?=
 =?utf-8?B?S0wrL01hcm9RWDk1KzJGUDVHTjFwc3dPRGZKVlU4YjRuUlVnd1pEN1d1RWF4?=
 =?utf-8?B?aGx4bDFVdElCejAzZFM1VzNPdkRkMHVPdUJRQ29ESXFKcGlTbGdKeiswei95?=
 =?utf-8?B?TjU2UXY4Z2ludnY5QWFUYWZpZ3dCUWlTdUxkcDZEZWVKbTE0VE1BR0M4N21S?=
 =?utf-8?B?eXN6M1lCSjgxb1RqQ1RZenFsZ2MyTzNWUjcwcFo3UW1qSmxGVEVXVHM2c3Nx?=
 =?utf-8?B?NHRyRUYrbXp6dk83blpiMWtXL0wxS1FwRUYxTzVJZnk0aGxnWnQza2ZqdHc4?=
 =?utf-8?B?RWVTb0t5eGM3RDFMWEIxbWZFT1ExOFZwS2JSUnVyTktVeDF3c3UxODJGcTNl?=
 =?utf-8?B?NG1ybHVORHV4STB4UnFMUkJMRlFTTkRteWRTRWtxSmgxdHIzbzdpVXlPSXZE?=
 =?utf-8?B?SWtCUWdsa05BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGRFUzJoRFFzUGZJS1pnbFdvZUNOeTRJMi9IM1F4WHBpTVkyNHlVdWlZQnVF?=
 =?utf-8?B?TUkrZzZuVW9mR1hlSnF6UG4rZ3lkbzEzN0pvM3hzaHlJb3kyODR5QjRmREtU?=
 =?utf-8?B?ZytFNDBtNzJZanFBeVd4WWVHK1owYUFXdDQrV2J1MXVEeEVnZnU5MFVHUWhH?=
 =?utf-8?B?RmhnR0ZtK3dKNy9zTGJxTW5TaUV2alBZa0tjTTRscmpYK3hHbFVab1JtaTM0?=
 =?utf-8?B?RVc0bjRSY1hzRXZvTVFNMzQyTlRMTWZaYUcrSEJsa0wyMWk4QjRwK3VEME8v?=
 =?utf-8?B?ZkcrWGp2RVhrT3lGbk5EZGNGdFNXdk5jVExwcFM0YWxOT1RzbXFpQ3FLcGJQ?=
 =?utf-8?B?RnROL3hEV2oycU96V2d2cVM1cVlmWlNnRHhkazRGeEtGdUtna290c2lXODlM?=
 =?utf-8?B?Y3JlV2ExdHhUd3lNWW44WmExaEFzamk5UEtZZFBIbEtZK2Q0K0NpWDF3MXJn?=
 =?utf-8?B?U2hTNFNMdFZvb1N1RzBHZncyQVJBenJqTnM5MnN4b29hYXRmM3JHVWNaWXZL?=
 =?utf-8?B?MVZheXlzOGJEN2E1WVdwMGc3VDJONitEMGhrZFF3UW8zd3NlclRYeGJiZDBI?=
 =?utf-8?B?eXhzd2M4Qm1QYWJqUUJKRkNzcWxHOFVncVo0MjA5enZmbW0waGpCcGgzcCtT?=
 =?utf-8?B?cDhRZ0dEOGZRREhqcTZMUFE0SFNDTEF5VjB0ajFaN2c1YWk3WCtVTjlrRnND?=
 =?utf-8?B?M05aYXlZNnNVSkMvRmxGZUczcStiRW5ZOW9FL3dYVHhyQWJnenF2djAyZ0pJ?=
 =?utf-8?B?TWNsTFVUUWZ6elcxK0lUTnFDOHRDcTU5WnE0V2tjakNvU3AvQVI5T1lzYWND?=
 =?utf-8?B?VjRiU1Y0SVdDbTRiZkdDNk5nc2RsQ0lpbXJxcEhXSjIvUWkzaDRZenZxNnhU?=
 =?utf-8?B?VFMxRHg1Y0EvUVZ5YXAyTDcrUkduUEZQUHU1d0VhM3JQajlPTkoyY3ZCeExY?=
 =?utf-8?B?Y3pRQ2lhbE1abDI3VGwrT3hJM1lERG5nMHF1RnBPWUdZQW43RVlNcVBITXl5?=
 =?utf-8?B?Mmc2MHNPd3FDYm5EUU1nak13WkhKSzFkZG4xOUI2NzBQY0Q0UFhDWXI0bWtX?=
 =?utf-8?B?OFdoenZVcEZ4S28vaFhGWEo1VTNBZ3NRVkNtV0hrRm5ORDZSK0U0Z0FlcE9p?=
 =?utf-8?B?d0luR0czaHgrbXJFQ3pxOTdsNHRyQ0FPU2JaWWd1VjZvY0VNUDVsZlNFU0tJ?=
 =?utf-8?B?Sm1uNzZyM3F3ekFJZEZWM0JrY3FMUGU0RG5ic2dDL3pjcWtONENyczdzSUgx?=
 =?utf-8?B?QURoRDRXcCtFME5OcDdNVFVqYVp1UG5XSEE3QXM2cVVqQnlmc2RZQjVHNlVN?=
 =?utf-8?B?Z25adFVMOUprUElUYnZPMDdmZXVmNUxsUy9Nb0pjeW95UG9pRUlreUhqSWZG?=
 =?utf-8?B?a0p1Vk9jOFpBUklUaFlSdG8vOW9KNXZtaWVrL1B1UFNpSXNmNTY2bUV1SEVM?=
 =?utf-8?B?WDNQdmMxazZDNWtCd2ttbUdqcXBqbXViNE1yS1M4NitKWVdtTlRZUjZXL2Vt?=
 =?utf-8?B?eFNWZmxBenB0S01kVWhRdnk3SEgrcFlYcGtvcGFmK3N4U0hxRHZleXNDb0M5?=
 =?utf-8?B?eCtiOXpIZ082WUZSRkt1VzEveEJEL0RFNEppVUhINzB0Y0x2T05QYVNITUlq?=
 =?utf-8?B?b3IyTmViUDhLS2tmRGREOC9STnZYSG15QlZvdVZyWktSc2lrRW1oVVd3dlFK?=
 =?utf-8?B?QlpOd0JWL1U2d2hzNTVuR3BidU9DN1pDcFlBN2RHRFowSFZRaFlweWNvUlJY?=
 =?utf-8?B?b3JZUjAwWlMzZjZoZjN6Nk9qeU8ydW54SUlWdzhaUG1DTXVQK0VJYTFJeXNB?=
 =?utf-8?B?MDBiL3htY3A2QjJ3eXc2bTNpRnQ2emFhekxpZFVGS3JHcFQ2bWRkNUx3bUZT?=
 =?utf-8?B?STNkMGI5eW5SaHhXRzB1dmtrYktvTVFPNnM3ZW1GSVlWVXhrUndKWEUwMDg5?=
 =?utf-8?B?elErcVNBbThPU0YrN08wbktMZEtWMjMvZE9PNWxCc2ozdnNxSHJzaTNOZEtG?=
 =?utf-8?B?S29GaUdLdFFUeldlamwvR1lNaXg1bXFORHlVaEpwRGFxV0p3UjBlY2lDWVEx?=
 =?utf-8?B?TElyMm96aUFGM3RJMnRNL0NEUkFtN3BDWWkxMVZYeUNRSE82WTRxbFdUZ3F2?=
 =?utf-8?B?R0IvNEllaGlGckxnNkZ0TmJCQ0lOb0dld0V6UXd5bkdwYm54c2xNeG40Z1c0?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c1df79-5427-408b-19de-08dda297868e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 12:09:43.7374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFKpRQWm8fe58SKcDamFdUxjdYnsknjeq0NBBdD5Cc/2S2nS8CjDQ7wN3IEIOpWZrdnP8A+BFL+JSA/VSp4uyB8SWzvId8jtbz5B9XLVEeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY0IDAwLzQzXSBMaXZl
IHVwZGF0ZTogdmZpbyBhbmQgaW9tbXVmZA0KPg0KPlN1cHBvcnQgdmZpbyBhbmQgaW9tbXVmZCBk
ZXZpY2VzIHdpdGggdGhlIGNwci10cmFuc2ZlciBsaXZlIG1pZ3JhdGlvbiBtb2RlLg0KPkRldmlj
ZXMgdGhhdCBkbyBub3Qgc3VwcG9ydCBsaXZlIG1pZ3JhdGlvbiBjYW4gc3RpbGwgc3VwcG9ydCBj
cHItdHJhbnNmZXIsDQo+YWxsb3dpbmcgbGl2ZSB1cGRhdGUgdG8gYSBuZXcgdmVyc2lvbiBvZiBR
RU1VIG9uIHRoZSBzYW1lIGhvc3QsIHdpdGggbm8gbG9zcw0KPm9mIGd1ZXN0IGNvbm5lY3Rpdml0
eS4NCg0KSnVzdCBjdXJpb3VzLiBNeSB1bmRlcnN0YW5kaW5nIGlzOiBmb3IgZGV2aWNlIG5vdCBz
dXBwb3J0aW5nIGxpdmUgbWlncmF0aW9uLCBkZXZpY2UNCndpbGwgbm90IGJlIHN0b3BwZWQgZHVy
aW5nIGNwci10cmFuc2ZlciBhbmQgdGhlcmUgaXMgbm8gZGV2aWNlIHN0YXRlIHNhdmluZy9yZXN0
b3JlLg0KQnV0IGZvciBkZXZpY2Ugc3VwcG9ydGluZyBsaXZlIG1pZ3JhdGlvbiwgaXQgd2lsbCBi
ZSBzdG9wcGVkIGFuZCBkZXZpY2Ugc3RhdGUgaXMgc2F2ZWQNCmluIHNvdXJjZSBhbmQgcmVzdG9y
ZWQgaW4gZGVzdGluYXRpb24sIGl0IHRoYXQgcmlnaHQ/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

