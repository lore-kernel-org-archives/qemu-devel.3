Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EB5FF495C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w77BW-0003nI-V7; Mon, 30 Mar 2026 03:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w77BR-0003iQ-EM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 03:37:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w77BN-0001pV-5N
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 03:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774856229; x=1806392229;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=11syhGJcXaF7luRYtd7VVSTb40qoZQsImIuDltWdO8s=;
 b=Qv8Qj+Rn8ZnhvOYyFrLOVfKBinRDRByJyTDsMbHzgljdXzCDQ9qWBPp5
 BdDtKbytKjpnrAVBn03ECj8mC5ahSLS5hePFwf/koRLMxC1SIMarW6Ny0
 2vI0BCVd0I1EZyPY8HW/5LAuVDO0SdQyt522sxHP6gbBSl04Ie/G3Einf
 UpJ8ZTeYOKg/u00bQHq9z4ia2b8gpowwFOIrWwpp0DleqCMzNijclCjG9
 5BAsXF8Cdfu8/BOXwCXlMURiZdhKVuGfe34rRyilGffEXYRzmKAKTI9ll
 CVGwt+wjkMxIUk6d4SwD72VSsRppCVuwek/rp0WmZg8nHhOopXseNu7gy A==;
X-CSE-ConnectionGUID: lXRwy5C8QUqCvZW9jY7Q2w==
X-CSE-MsgGUID: 7GZITdFuT6it2Wtp2VE2nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="93421155"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="93421155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 00:37:04 -0700
X-CSE-ConnectionGUID: 6yGrpVYtRBmtxCSVNZBSuQ==
X-CSE-MsgGUID: 3baBqvkFRmKK8EvYrKQDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="227592426"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 00:37:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:37:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:37:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfrMil5kfem2joHdMrwdKikzqG6vtzAkao8ktYG6L1EsOXmgob7hA+5IBemx6evjeqcm5Lo8O+/kosAnvIZxYxERm6E+g/x8fBuv7yaHGqMayDg7y5BFsOtsYbpGxZUnW2exBj8M3aiFgPqOFc52cS0Cm5deIswy0zj0UTup38lSusTIngznm8DmXpZzIJNfP+NxpCUO8V2fNCo829adSaunYkLOE2RUTnEHAhANXIrVCxKtFtfYWXDsJnZbIt15WnXNSU3ExjwxujDWH6al73LtZJjPQoDdd+pfdP4hS865j6KivCpQrqgcq3FPzBRQQ3hl5yWNaQM4TVQvtJPk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11syhGJcXaF7luRYtd7VVSTb40qoZQsImIuDltWdO8s=;
 b=WoYNdAoPYKTldCyt3NQs17I7exMlEvZU5fwp1jPvthMFeMY0sYoM5aUUKk8CykTSPxsML7EuI81+X+xnySbZyffcvXEFldd2wlZP4vN5Rrr8rL/ONooySggwN73B5K0Iid4PE5a0vAMYHI2d/lptRNr8HwsnLVowFG9s33hUA05tDk0PV8c2dvknrJJoDpd96lY/xovubDPDTpKF8oSZaYk0ti+E+CAZdYkawH0GcF1XUlO0FMGq562esoSPUE4KDt9p6S3Aac1G9hfKKX7qFFM1CPzZ9aYU0oXgEZWMFR7nYNuIQXFJvYygWw9tnMjDQ6lSIA3btKN504/l1KsybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:36:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 07:36:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 10/14] intel_iommu_accel: Handle PASID entry removal
 for system reset
Thread-Topic: [PATCH v2 10/14] intel_iommu_accel: Handle PASID entry removal
 for system reset
Thread-Index: AQHcvQCuwNf+e9ved0Cpu9wWhpA9RbXBy2cAgATWSwCAABQYoA==
Date: Mon, 30 Mar 2026 07:36:58 +0000
Message-ID: <IA3PR11MB9136B1CA0324339FC26E11129252A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-11-zhenzhong.duan@intel.com>
 <73392b21-f9b4-48f1-b712-30119cbc8648@intel.com>
 <a04bebd4-3fbb-48c5-9fda-9b5b57182d05@intel.com>
In-Reply-To: <a04bebd4-3fbb-48c5-9fda-9b5b57182d05@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7670:EE_
x-ms-office365-filtering-correlation-id: 76ef9f1f-4351-43e5-37db-08de8e2f1fe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 71HCuxkPUcd6uD7lzUJSUhEFNKPno3GhYpwHn/bvjVrcbhiXy6nbOhLCJWdyrxMD8Ll1sLaRw5TC74HZWossmc+MnC5f5VNO2Vz9GbBd0tPmtq18XhGh6X8EqL8ZCluGEOB8flp19LDk4I0H4COKmWFcAdlNY5ny/GNayOZwvGUqXeEANif76lRlBqWQkBX+KG2BPdUoCfMiVogp6ivj44FTVP+PNH8k1u1angD72YgO2psHxLdopSGMuAm3J2t+gLto7FtLRf6BpI0L220RK+F9dvcvRZnhmdcqr3Nwfl97Prtro6iaMMl7tdb16V8IOOu+UcxRyl/Vc4G4pqP702Wb+eP7TjljoxA7a3sTJtH1DzsBPl98jQmUUImpGbqnW8DV0p5Pf2zaH/WVyur89bVDnymBI/kAceNHyvkcBeqeO93Y+AnSmB7xCdYlABfMvi+fZruSWs+nc3n46eNE6omcF/DoD9N9cWyYG6J6ZJopVVxOXBRkuLNN3fJSeIj2iFcOkxn5ZoLXrbu48YtKx7AcCeIkD09BOTQl5Wd9JXpaA/du4RbUCLAA8WABhNd99EoiMTLKTzbCkdeIn4wStjTvGd338g28ePND8CPe0kHiKqqGoT8umTFlnQZVba+DquoQSRtkvla2NpJw5Ah/wLqR8IE6pEoU6cRNJ6BN+LScgwW63rxbfyJ3tWxkGdHeFsd+WNGW6Sw9JzKj69HOQVKc7CFLB8Yk8Cxfsa6p3JRi4g7GIs0+IdWLDJ/7Za0DZ/gUHRXbC2p83f1IbeQTGfs/EDLQJfGvUzJT/LxNWxw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzNTNnYyTllWZ0lkTExOa0lTUE5ETVZSWlQ5RjFGK01WeVR0RU52VVU1Ky9Z?=
 =?utf-8?B?OEQxb3pEVGxVZEgzdGV0MW1ybFpFaG53eldVMkJZamZuWU9kbXNZY0NwVE13?=
 =?utf-8?B?S3AyQzUvT2lRK2ZKdW9oUis2NkFTR1orMFdTMUdZQXRvbkxtMnovTnR3VkhI?=
 =?utf-8?B?TVFUZnVHQlUzWFpna0liTkVId01YWVhLS1J4QTVib0UyTGI0MTVkLzhONFhr?=
 =?utf-8?B?ZHBXSFh6Zk1pUFMzMllUZDJ2WHdtY2RPR2ZVWmx3QVJ3Y25yVTcvU29QaW45?=
 =?utf-8?B?NDh2eC9GczNBRHRYM1FJZVZtZEhITm5mVWFDYUlIUjJRbWJxNENaV2VyT1FT?=
 =?utf-8?B?VEEwbm85QXY0TFl2WUErNVdYbHgxVGJ5Q0M5Uld2RW1xSXhBMnYxV1ZHdkRn?=
 =?utf-8?B?OUdjbFNzRU5qV0JabEZUVEEvellVek5iZWVZWStOSDI5a2FzWC9sVzVMRHVG?=
 =?utf-8?B?a0Q0Zm1jcGprYmhLa09BOGc2dU9qNGMzRFNHT0F2M3pSMlV1Tk1OQlpCcXhP?=
 =?utf-8?B?SkhUQ2hQb3ZFR1U2NVpVbzZIOCt0TmRscUtRVytWUHJpNTZlZk5kcjVCMVJP?=
 =?utf-8?B?RDRBbFZCWlNTZDNFZnNRa24xaWcvREJPU1U3bGVRVGNVcjBFYlhmNXJiYW94?=
 =?utf-8?B?Y0FSZERsTEY3NkNvRnczRDY5d2JoZ2hOZnFUNEF0OXp3SWZNdENKamZZNUhp?=
 =?utf-8?B?ek1Bb3MwV1dqT1hoeTY1dmJVSVpxWWtCVytOQ0toT0N4WWFkQUFLMEtZSHBR?=
 =?utf-8?B?aVlpdzZuN01lWDBUWHErVVhJV1c4ZGxHekE1cGtuTWxWT3V4dGlVMmVjaFkw?=
 =?utf-8?B?Vy8zckxXUVhIYWQ0MTdOdU5LWTZQQmxrUXNBdXNvSWVoNkMvL3NvUm9kUjVT?=
 =?utf-8?B?Y0FsZ3RBbDBrQW5ZNVc1NlR1MVU1UmRCKytCVkRuOTM0NmRWRmZuVFpSL0w0?=
 =?utf-8?B?TEhabXFwck5NZ2VoRElwd0g0ZkczVzZkdkZEM0tURkpDL1dVamJFMGlYNzJE?=
 =?utf-8?B?QmlNWjY2WHJoeHVaQThFdldNS2t5bHZvd3g5U00zeFJ1ZUJrUXcycTRzYm9E?=
 =?utf-8?B?cERHYzBUK28veXdBVmxxYjlwVHR3cFVNK0ZLSUY3MVBoRXkxdzBjcFVLV3lo?=
 =?utf-8?B?SnJLOUFkVHcyVkE2dklxajdPcGxHR3o4UVV1Y1JYclVDcjNjd202UWszQ3pL?=
 =?utf-8?B?a0hrTzllbStzSXFEcG9kS0pWWUFBNkpmZWxOcFFITllFekpvUlpzVENiWGx5?=
 =?utf-8?B?TjBGZGFiWFJFejRaZFFGS1J1MjUwMTJJOEJSZ0Q4YWVPVFVyV2pjanBTV29P?=
 =?utf-8?B?NkFiVUYyWWVGNDluSjlCa3dQeEVtd3krWE9qeXlkb1lEZ09qeTVkdDIvRzI1?=
 =?utf-8?B?aEwxQUFoa3loTXZMWC9VS25EUFJ0QkNweDFpUHNNWW5kTmEyZWxPMlRGYzRi?=
 =?utf-8?B?bERiSlNrRUpGQ0Z4ZklFYStqVDRxZVdWazBVVitNRXpBRVJmNS9TZGVzVzJQ?=
 =?utf-8?B?SzN6UUxsL0NmRFpid280WUp0RjdrTGJNekN3b0RkWjlMRWFzWTJRT1RDRXho?=
 =?utf-8?B?czNvTmNpcWZxUEVDWk5TeEpvNndPQm5oNUlWWm1QRVFYTVJLRDB1NURYTnpK?=
 =?utf-8?B?bVBDNEtmVndaenphMUx5WE0xbWtvUjl1Y0RMaktoMnhrbnVPampvSkd4M0lI?=
 =?utf-8?B?UFBGc2tabmc0SnduMzV1cHcrNW81d2s1VnVFTGdpM3pxWFl3bXFDTlZyZENv?=
 =?utf-8?B?T1pQWHE0NXFxMVd5bWpkWjdDSzhRTk56U0pSbXJrL0NJQndxQXVpUnB5engy?=
 =?utf-8?B?bEc5b3VPUGo2SWNDRG1aV2tJRHByYjA1K2hYTjFLS2tXV2p4aW8wNlFhbktC?=
 =?utf-8?B?eExkMXhsZzk3a3hFQWFvVW9Sdi9sbERRb2Vxdzd4U3FVT3o4QmZsaGx0Rkhp?=
 =?utf-8?B?RkdBOVZQSkhXaVdhWko3Q21haUdORDhpMlFhWWRXcCtDYWdnTVpUZHFwbDVO?=
 =?utf-8?B?QzhDUEYxNEp2dm9yS2lyYSsxTDF6a0VSaFVxQmFpMi8yMkRwVmxQY3l1MUVs?=
 =?utf-8?B?TFFIV0M0eTBRT2pOL004UDFJRElyQmNNaFg4a09ERHJoK0dvSXJoSFNlMVJi?=
 =?utf-8?B?S3ZCNDJqZWo1Rk9INXg4SWNDdmdQaVBhbDZ4REt4VnBhQjJKdFZoOXU1bmRh?=
 =?utf-8?B?UnFzTXRQUWhSRnhSaExEWTNNSkViUFRUcFZHZElUd2wwVmFjeEtwS2lkaGFX?=
 =?utf-8?B?VkpjcG5yMGtrOUVuck1lTm5Fc1NUbXVkdjhqajBPT1VUSFN2YjRVYlhXWDlN?=
 =?utf-8?B?bU5RMVBzY3Z1RFlLYUtOdnErR3FLckFXbktWUWYwTHA0YkxOdnV1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dwkRq8V11Yl/fsZQvaftzmXKEm2uNtSvsTt+1WkEJbFdzDaAsR1r+P3k9S6jHoq2QnDRmviHYBeKcdAwC2RzZrt8XPA0HbGUDu3GgYcprcEy3SNnTwQm2+AiZE0yyE0KbNyJW3/tfPwETnt4ZXFu8j/0Q6fxMj1ue0DuVaKjEbJw94yIOJ1NK7Q2I0vhSsfIpkcH1iRk+t7NeoyBAPbokFUbQba4e45OeMocSRax8tirWww7LlElegTcqQSr+2gVYeYahyfR574nx/jA0RKRgUAse03CC8hKtAWlTTG98JDQ3FMPyRqSR1khbUGMOFbOH7YfRbPldl0phE5sOBY6jg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef9f1f-4351-43e5-37db-08de8e2f1fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 07:36:58.2780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7K5/PhFRzMU47MZaXN8Ab7/4OQxA/qctycjefOPMGdwu6kTxZlnjk1gH9oIby52cTHNGOnIwXuoA0PkCVtDTNG6cFPCrZOVnoWgBxprEpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTAvMTRdIGludGVsX2lvbW11
X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5zeXN0ZW0gcmVzZXQNCj4N
Cj5PbiAzLzI3LzI2IDEyOjMyLCBZaSBMaXUgd3JvdGU6DQo+PiBPbiAzLzI2LzI2IDE3OjExLCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBXaGVuIHN5c3RlbSBsZXZlbCByZXNldCwgRE1BIHRy
YW5zbGF0aW9uIGlzIHR1cm5lZCBvZmYsIGFsbCBQQVNJRA0KPj4+IGVudHJpZXMgYmVjb21lIHN0
YWxlIGFuZCBzaG91bGQgYmUgZGVsZXRlZC4NCj4+Pg0KPj4+IHZ0ZF9oaW9kIGxpc3QgaXMgbmV2
ZXIgYWNjZXNzZWQgd2l0aG91dCBCUUwsIHNvIG5vIG5lZWQgdG8gZ3VhcmQgd2l0aA0KPj4+IGlv
bW11IGxvY2suDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuaCB8wqAgNSArKysrKw0KPj4+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKg
wqDCoCB8wqAgMiArKw0KPj4+IMKgIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyB8IDEzICsr
KysrKysrKysrKysNCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+PiBpbmRleCBjNTk4MWEyM2JmLi4xZmI3Y2EwYWY2IDEw
MDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4+IEBAIC0yOCw2ICsyOCw3IEBAIHZvaWQNCj4+
PiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMsIHVp
bnQxNl90IGRvbWFpbl9pZCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcGFz
aWQsIGh3YWRkciBhZGRyLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCBucGFn
ZXMsIGJvb2wgaWgpOw0KPj4+IMKgIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfYWNjZWwoSW50
ZWxJT01NVVN0YXRlICpzLA0KPj4+IFZURFBBU0lEQ2FjaGVJbmZvICpwY19pbmZvKTsNCj4+PiAr
dm9pZCB2dGRfcGFzaWRfY2FjaGVfcmVzZXRfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzKTsNCj4+
PiDCoCB2b2lkIHZ0ZF9pb21tdV9vcHNfdXBkYXRlX2FjY2VsKFBDSUlPTU1VT3BzICpvcHMpOw0K
Pj4+IMKgICNlbHNlDQo+Pj4gwqAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9jaGVja19oaW9kX2Fj
Y2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+PiBAQCAtNjIsNiArNjMsMTAgQEAgc3RhdGljIGlu
bGluZSB2b2lkDQo+Pj4gdnRkX3Bhc2lkX2NhY2hlX3N5bmNfYWNjZWwoSW50ZWxJT01NVVN0YXRl
ICpzLA0KPj4+IMKgIHsNCj4+PiDCoCB9DQo+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2dGRfcGFz
aWRfY2FjaGVfcmVzZXRfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4+ICt7DQo+Pj4gK30N
Cj4+PiArDQo+Pj4gwqAgc3RhdGljIGlubGluZSB2b2lkIHZ0ZF9pb21tdV9vcHNfdXBkYXRlX2Fj
Y2VsKFBDSUlPTU1VT3BzICpvcHMpDQo+Pj4gwqAgew0KPj4+IMKgIH0NCj4+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5k
ZXggNDUxZWRlNzUzMC4uYjAyMmYzY2I5ZSAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtMzkxLDYg
KzM5MSw4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZXNldF9jYWNoZXMoSW50ZWxJT01NVVN0YXRlICpz
KQ0KPj4+IMKgwqDCoMKgwqAgdnRkX3Jlc2V0X2NvbnRleHRfY2FjaGVfbG9ja2VkKHMpOw0KPj4+
IMKgwqDCoMKgwqAgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0X2xvY2tlZChzKTsNCj4+PiDCoMKgwqDC
oMKgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgdnRkX3Bhc2lkX2Nh
Y2hlX3Jlc2V0X2FjY2VsKHMpOw0KPj4+IMKgIH0NCj4+PiDCoCBzdGF0aWMgdWludDY0X3QgdnRk
X2dldF9pb3RsYl9nZm4oaHdhZGRyIGFkZHIsIHVpbnQzMl90IGxldmVsKQ0KPj4+IGRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMNCj4+PiBpbmRleCAxZTI3YzBmZWI4Li5lOWU2N2ViMWEwIDEwMDY0NA0KPj4+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfYWNjZWwuYw0KPj4+IEBAIC01MTEsNiArNTExLDE5IEBAIHZvaWQgdnRkX3Bhc2lkX2NhY2hl
X3N5bmNfYWNjZWwoSW50ZWxJT01NVVN0YXRlDQo+Pj4gKnMsIFZURFBBU0lEQ2FjaGVJbmZvICpw
Y19pbmZvKQ0KPj4+IMKgwqDCoMKgwqAgfQ0KPj4+IMKgIH0NCj4+PiArLyogRmFrZSBhIGdsb2Fs
IHBhc2lkIGNhY2hlIGludmFsaWRhdGlvbiB0byByZW1vdmUgYWxsIHBhc2lkIGNhY2hlDQo+Pj4g
ZW50cmllcyAqLw0KPg0KPm5pdCA6IHMvZ2xvYWwvZ2xvYmFsLw0KDQpHb29kIGNhdGNoLCB3aWxs
IGZpeC4NCg0KPg0KPj4+ICt2b2lkIHZ0ZF9wYXNpZF9jYWNoZV9yZXNldF9hY2NlbChJbnRlbElP
TU1VU3RhdGUgKnMpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIFZURFBBU0lEQ2FjaGVJbmZvIHBjX2lu
Zm8gPSB7IC50eXBlID0NCj4+PiBWVERfSU5WX0RFU0NfUEFTSURDX0dfR0xPQkFMIH07DQo+Pj4g
K8KgwqDCoCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kOw0KPj4+ICvCoMKgwqAgR0hhc2hU
YWJsZUl0ZXIgYXNfaXQ7DQo+Pj4gKw0KPj4+ICvCoMKgwqAgZ19oYXNoX3RhYmxlX2l0ZXJfaW5p
dCgmYXNfaXQsIHMtPnZ0ZF9ob3N0X2lvbW11X2Rldik7DQo+Pj4gK8KgwqDCoCB3aGlsZSAoZ19o
YXNoX3RhYmxlX2l0ZXJfbmV4dCgmYXNfaXQsIE5VTEwsICh2b2lkICoqKSZ2dGRfaGlvZCkpIHsN
Cj4+DQo+PiBzL2FzX2l0L2hpb2RfaXQvDQo+Pg0KPj4gb3RoZXIgcGFydCBMR1RNLg0KPj4NCj4+
IFJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4NCj50aGlzIGZ1bmN0
aW9uIGlzIGJldHRlciB0byBiZSB2dGRfYWNjZWxfcGFzaWRfY2FjaGVfcmVzZXQoKQ0KDQpPSy4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

