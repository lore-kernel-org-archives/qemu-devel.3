Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5403DC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPH3I-00063p-0X; Wed, 11 Jun 2025 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPH3G-00063a-Fz
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:43:18 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPH3E-0004YB-DW
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749631396; x=1781167396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3O9Z5bdl5oYA6/iZj7/0n7+hIdE/lJufkUlnLNQ8lUk=;
 b=Od+bamfwH/RPQwii7/sjZ1bqw4iKqrsZWGwuEg+jlCS3Q7MAX6YHdjQm
 JrRpCx4/u/FQ7gES/yGloqeZmDBrljeOCGzkG6RMnpOdRqrune2TxRan/
 AH9+EfEc0DdOzCLES+FY/0deqQsne9CEdlo81yj9SwPqERLtLe8exfxvO
 qr2YpzNgokclgTw2gc7LZ8OICHMBA9U9rpaCjSoeLEqoddDrap5Nbp4gw
 BFSiy+xRieokPfF4dAe9kBWV2BklcP391f/cOXgt36ycmRarsOHlPFoIm
 EzU63OPpry/IIu+r3fP81Q2RkcFPVOHo0ohfYZhOxzJjZAzp7e5zWcsX1 Q==;
X-CSE-ConnectionGUID: mFnRYTWGSIq32OgVkvqEJA==
X-CSE-MsgGUID: XEgdm2uTTcqKhkZCXHi30A==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62379155"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="62379155"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 01:43:13 -0700
X-CSE-ConnectionGUID: Up6093a/R1SxOBwroR0qMw==
X-CSE-MsgGUID: PuMskLZXQtGwVc1g9uPebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="152120979"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 01:39:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 01:39:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 01:39:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 01:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSx4zCHOz7MPvypfr85Y6FfAWBBjJNC6SGMuLNuNpKZeU5ITq9esRkSQ6CrEmIQmfQyLi9fpcQdOA7LUIz7UU0trjEswN8tUcWaaM/DhZ1ZFyYANckg72XS+ucwYp8j+Tx8CyXaRalR4gAAMUH3FjgiUKL7QoPMxyV/ACqNWdyE8A6y+YHJOulfPpnuXmPNpC6jlXxEcHHOrjyHbs015PopQS58KMMkIklZ7OsVT1Hj+M6Poo3o+Zs7NlFsI0ZB2pAENA50NSqkzSyn/PyfUvUmMOPPkJ1mcQwtjEb4x0UgNbbQW3PJsDsf4SPYqahLRm3ViAxcwItSTplaUKQh+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O9Z5bdl5oYA6/iZj7/0n7+hIdE/lJufkUlnLNQ8lUk=;
 b=bnDfiDK28ldZLEC5vITpHyZTYG6QpM6z62bBMFzK66aEm9nbLHstkpJwlR2G24vjUFO67KCaR7BoXigo7HbDGQnjfClqdC98Hn074Yz9toH5P6e3eErC0v+BFsXnQRN9xkRSDU2+OH6g9Qye1A6BEfDQB4fbenTaPIVwVj5u7b6iUpO/tMbBZsfyjoarpmCN4gqDx4Y3CFQwzuKWagUXLWzlLh2OdJnIl0yIX1E2zRAZOBbh+qEk7sFkfACyycwC9in4KZY09FxC7n/5Vl/4xzbhacqoPxHGx8tXtfa9Jk+I/TOM5Ckdn6HdjMlwZpJlfWk3UIth1klJPe7ORKHyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 08:38:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 08:38:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "john.levon@nutanix.com" <john.levon@nutanix.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
Thread-Topic: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
Thread-Index: AQHb2nsKCKwGGnAhz0mrYLLEqOa4e7P9jVMAgAAUzIA=
Date: Wed, 11 Jun 2025 08:38:58 +0000
Message-ID: <IA3PR11MB9136A50C1DB986FB0F3E99519275A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250611024228.423666-1-zhenzhong.duan@intel.com>
 <58e02d61-7f6e-41bb-a7a5-f1058e52af31@redhat.com>
In-Reply-To: <58e02d61-7f6e-41bb-a7a5-f1058e52af31@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB4993:EE_
x-ms-office365-filtering-correlation-id: c0e5c33f-ab80-49c3-3a5d-08dda8c368cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1JCcm9INzdZb21GSm9TTVhnL0k1MERhbDdWbG5jQktWQkQrZ1poMG1pSlZJ?=
 =?utf-8?B?Z1QrdW9Ob3ZPV2IzN05SMlVnbzFDMUVpY0t2bzFBZVpNWDRYNnZqUGFzYWlR?=
 =?utf-8?B?bHZ4ZnZhWWRWYmZpbXllR2VrVjAvVHNaazBWTFdyNWxMZ3ZHRm9jb0Y3NTk2?=
 =?utf-8?B?WWhsOEZSckd4L0NsZkljMGdWd3VZc2RGYzRwQTlXNE9OOUo4NWs2Z2FkSlp2?=
 =?utf-8?B?V3RGWDJ5ZmpwSWFYTE85d1FReVdSdVozS2drd1lVOGtDVmY1SmtwMXM4clpJ?=
 =?utf-8?B?dlR6ZmhKOFRFV2JOVmNmMjcxazNEaU9CZXd6VytlZWxnYXZDMmZwRGFRZkZl?=
 =?utf-8?B?OXBnQlg0S2lwei95Y2U4S2NWWEZnNm52eWZmditNUTZzMzRHZjhsd2o2NWRM?=
 =?utf-8?B?ZlpMNWorVmRTUFJTNy9Ma3pldHdvbVZramV6MUJ0WFRSRFp0U0V4UVdzcm1V?=
 =?utf-8?B?TDdURkpQUzl5RFQ0RzhNcmZIK1VEaEhPZkdQakYzWW9MOC9Gc0dsb3g5dDlD?=
 =?utf-8?B?eUR1cURrN2NDOGIzT0FBUUVlY3Rjamc1NDJIV3FydEhQLy8xUVp5WDBBQTZ2?=
 =?utf-8?B?aVltbVJRdHhGNjJvSnFmSGNMdjN1Smdzc2kvQXRJNm9IZFRscHhIK1g1SHhH?=
 =?utf-8?B?UXVvZ2R3TnowZnRaOTVqNjFUUGt4Mi9ueUJDVWNoUkp3ZE1qRXRHUXdmWDdG?=
 =?utf-8?B?RXhPbW4xcUZ4SjFKc3pYWEhLWStYeHdCK1huWnJsZk11YVlCS1RGVVFFRlZV?=
 =?utf-8?B?dUplcDIzN2hMWnBVUkVYODRpMkV4Uk1aVm1lT2tTNG5PSWRnekdPOGcxL0NG?=
 =?utf-8?B?SkFGVDN0eGFzcFl6TFY2VXlHV0p6WDVMYWh2N3hXVER6enEycmpDSFh1eVY0?=
 =?utf-8?B?TmJ5enJXa0JzaGswM1doVDFvOENneUdKb0JEQUxaOEpaUnhPYTB1dGl4OVNj?=
 =?utf-8?B?VzllM3U5dm5RemNBTXlvTWRmMGpPTmtmTXpJUUdzRFd5WjVGcHlrd1k0ZFZ3?=
 =?utf-8?B?VGp4Y200SWtJRWRnZ0VJYXpIaHlESkFwRXBzSHRxVXdCQUdTOFpEZFNCQVhs?=
 =?utf-8?B?YVk5RlZvc3dFR20zYkg3K284VXA0NU5RQUJ5KzlVeDNDZ0lrN3FoSGVudUhi?=
 =?utf-8?B?ejlWZVdtTG80WWJ3L3FQeDIvNW1yWGxsR2QwRU9nZVc0Y3JkTEZLeE1EcWtn?=
 =?utf-8?B?b1Q2UW1EaFVaalhMNTR4Z2xaT2Era3lQc0hncFBORlpNVVRLRnM1WitnbUlr?=
 =?utf-8?B?TWVUOVcwMkhQSnlDTWE1ZGRHTGRJSm1HUlIwZWNFTW85VUNFLzgrdzE5S2RW?=
 =?utf-8?B?bmp6dWc1TlVMaFYvcllteEI4RDlYeXhTQ2g2QjJPamdXdllJOEtpZnpJOWJT?=
 =?utf-8?B?ZFpyYmhabmpJUDV4V0JJVFZZSUNyMjVCVjlNaGJsUmE4enlQWmE5Q0xQTXZB?=
 =?utf-8?B?RmRUNjV1eHdCRnUralArYXV5U0FnaVcvQ01MY1lSRnB4dTFMWXR2eERvME5y?=
 =?utf-8?B?bWxmM1AwZlJqQXFZWFF0L3UrdDIwZU4wMWpRcmQxYlhYa2p2U2lYWk5vL2lP?=
 =?utf-8?B?THV2dnVycGxPWnNmczdTNzB2V1J6cHhXNUVyYlVJYnYveDdXdFF4bVFURHlh?=
 =?utf-8?B?WmpFcFNJaTJWVlNXSUdmb1ZFdU9qVE05d01rQkF0aHkyRThpZVZ1R3BuUnFv?=
 =?utf-8?B?OWdvZFkwNHpMYmt6OHZOTzlYSHZrNjBQR0kyUVVnVVpSN3N3TENKRWVJTEVq?=
 =?utf-8?B?VERzZ3pocGNvMCtGbmZxTzVEaTJQOWUrTlVYdkZJbitQczFNMHRjL3pScnJD?=
 =?utf-8?B?cXluYzQyL2l2aVlaTnhjQ0dvQ1BPQUlMNFBoVHdZQ29PM0kwY05KN3lPbUNj?=
 =?utf-8?B?V1hQVVhPdkluS0ZwNlN3eER0eXJFalY5UHIyMU5kUTZ6MWV6RkZEc2lXTlNk?=
 =?utf-8?B?MTR0MUpkUWs3QllxSTR3U0R2aE0xRlFCUnBTcHUxWjhOQ3c4UHJHNTNyZk84?=
 =?utf-8?Q?eCDjCEAuAJAiSQoiqqx9ArXRroPq5c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTBKRGxxUTZvZVNQMEVxV0ZNN3Q1T0FDNzRySUJ2cGZGNWIvK2lUMFQ2N0ox?=
 =?utf-8?B?eHh5SGJTM1JtdzZLUTcvK2RkSHRHQ2F4ZnE0aWM5UDdUckNEWFFEVWd4WnRu?=
 =?utf-8?B?RC9DbkRMR0lPZUNpWnZ2UzlSV1d3Y25JaFRkTlhXTDlRT0wzSzRGYjVqbzJ1?=
 =?utf-8?B?emNCL2I5S005bXBpQ2hPam5STUxqeDlRY25SVUNQWHNzaWxtMHVqVjVaRXhF?=
 =?utf-8?B?RXhlc2wxR3Y3aHZsOHVTQVlwV09IRDdQQW9BVUMwckNIVFl3a3JjUlVMVGhP?=
 =?utf-8?B?VEtCeGswNDNDRVpVVnVUR3hPMU9wa2twd0JrSm5tVUx5RjI2RnhDR2VkQ0NM?=
 =?utf-8?B?ZlltVWlTbHJLY1Z2b1pDam1kdTJZajNrNW85WXFXYU9qV09vWFVRMkFMakN0?=
 =?utf-8?B?N0RIVzJtWHdGc0s0L0xRaUdibTF0Mml5R3NqM3J6RUJwQTcxTEZVWXZiR0x1?=
 =?utf-8?B?aEZ5SkdDLzBsUzJVQWpJK1lnVS90WXRoWTRackxoUkVzOFQyQzlXSVNmaUtO?=
 =?utf-8?B?MXNxZ09LOElpUmJScnZwbDNDay9BUkJPZ1NWOVRnQ1ZqMmFuV2pXWVR5YmRO?=
 =?utf-8?B?elN4cFdVLzFFdFVReWFuZmZQRzByYnYwUTJLUWJ0L3FzUjA4SWJXd0xKaVlm?=
 =?utf-8?B?Y3FGV1dmRm13Zy8vWkdhL0ovdVVnNXRqbm14cnM1NW1ZdUtmQnhpZll6Z2tp?=
 =?utf-8?B?NnJsK1V3ampNRmJUVnZTaWxsRDNvdk5kYjRHNDN1OTFuWGE4VVU5Tk9Ed3BQ?=
 =?utf-8?B?dE9wd2EwOE9BSVkwaXlrV0ppSWZVUk9DNC9QVUIrL0svYXBKeGFoQlljVHph?=
 =?utf-8?B?ei8xejBJRk16cURSay8yaHNuay9DdWlrUTN1ZHZlMitpcXg3ZmhUZXlwZ0Ny?=
 =?utf-8?B?TnZCOFZHSTRwMFloLzZiS2NOVEEvMTlEMFRwc28yMGpzZVA5WENsSHZOdTZt?=
 =?utf-8?B?Z2tuSWdFMWhYNXhTbDBCM0lUU1JVbmd2RU5jN1hNMUNCR2RodE4vTDA1UzQv?=
 =?utf-8?B?NXR2aFgwd1JEYnpVVko1OUJ5NDc2WG1vaWZlMFk0Z3k1L29KSlhodDBhbk92?=
 =?utf-8?B?Qy9TdFREaTNid3BkQUhtZlJIVjNaVGVxeXU2TFZXczNvMGtha3NFeHdvRWR6?=
 =?utf-8?B?Y21tanEra1VLWVg5VWZRMWFuOXpva21QcmZvc1VPME1ObEo3YUllVmV2b0R0?=
 =?utf-8?B?TUgxTTFTOFhFUldSWUxCT21LQy9melVwYktRT3FHNkV5UEtWUkxSa1JGTEVT?=
 =?utf-8?B?UklZK1lPZ2kxSGZBWEUyNU5yVWVONm96ME1EdU9FdUd5Ym83cFNCbmtFRDNz?=
 =?utf-8?B?ODkwRjc3WTV5enQ2RktWVFBGL1BlL3k4dVc1K0VNSzlOdTZVRWdrSmhGRXpZ?=
 =?utf-8?B?MElTcUhkQzRaNXRDQVZ6SWRtUmtEV1RsNVBzV1AyaWFjZEZzUUI4VXJPc05R?=
 =?utf-8?B?U3lsM1FPVU90ai9RUWVIOFY3RkxOci9ZUmZwVzl1SnhiWG9PTnU4dUJyOW5s?=
 =?utf-8?B?RWE5RDRFZGpwajlYUXBXZHhIQlV3VTg2N2Q0OU4xNzIvVlh1M0s1SlkyZm9J?=
 =?utf-8?B?eFdmb3RCb3JlTjlUNitqdjdNVU5YTS9WUmVJQ3JUQlZQRlR1RGZnRnZzalgw?=
 =?utf-8?B?YTMrWTRRV2xMOEJ4a3F6a25VQjZNT3N3T1RVOU9uNzdJcytGczdqSVJmaE5p?=
 =?utf-8?B?cUxmd0xkM0k4VitROUR4T1FBZW5kS0hSckw5eDFKemlYK053NXIxc2J1NGwr?=
 =?utf-8?B?RUErOEdMSmxqVTIvZkpFWk94VFRpL3lpYjJrV0NXeEwyZDhHMkE5KzhlaHFm?=
 =?utf-8?B?bkZ2Z1NFWE9zN2ZSd2JXY2pjbSsxcEgzRFFObjRva2N2WnV1K0lJYUlHUHdx?=
 =?utf-8?B?S2I4SjREU2p2OWltaTZ6OENuYldrcjcwWXVwNkpkdXlkcXc1RTRVekxxdnhC?=
 =?utf-8?B?eDRzWVF5a2hKRkVwVkhra283TThYWjlLdUN5dENlNmI1Y1A4d2U1d1ppSkpo?=
 =?utf-8?B?cjJyMG9qWEJiMGRSYU50U0xaN2dUNm93NzFPZDVSTXkwVGFPNWYzVXlqekpi?=
 =?utf-8?B?SDcxSU5zUmtycldzdmlKcUFWYVZieW9iemFCeFBienhxTGdkck11SDcyblRv?=
 =?utf-8?Q?eVkftArv/xIHYGlv8uVw1pwWR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e5c33f-ab80-49c3-3a5d-08dda8c368cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 08:38:58.6164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgFrWK+F/xN92AiDXPPVGGTO3pKWhcc470bE4bqmhIm4rcFjvEe6ukQymU+K7265cSTbLmUsDsp2XPSYKtU6ZMrhIOC7ZPdcDDeFfqZZhMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvL3BjaTogRml4IGlu
c3RhbmNlX3NpemUgb2YgVkZJT19QQ0lfQkFTRQ0KPg0KPk9uIDYvMTEvMjUgMDQ6NDIsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ3VycmVudGx5IHRoZSBmaW5hbCBpbnN0YW5jZV9zaXplIG9m
IFZGSU9fUENJX0JBU0UgaXMgc2l6ZW9mKFBDSURldmljZSkuDQo+PiBJdCBzaG91bGQgYmUgc2l6
ZW9mKFZGSU9QQ0lEZXZpY2UpLCBWRklPX1BDSSB1c2VzIHNhbWUgc3RydWN0dXJlIGFzDQo+PiBi
YXNlIGNsYXNzIFZGSU9fUENJX0JBU0UsIHNvIG5vIG5lZWQgdG8gc2V0IGl0cyBpbnN0YW5jZV9z
aXplIGV4cGxpY2l0bHkuDQo+Pg0KPj4gVGhpcyBpc24ndCBjYXRhc3Ryb3BoaWMgb25seSBiZWNh
dXNlIFZGSU9fUENJX0JBU0UgaXMgYW4gYWJzdHJhY3QgY2xhc3MuDQo+Pg0KPj4gRml4ZXM6IGQ0
ZTM5MmQwYTk5YiAoInZmaW86IGFkZCB2ZmlvLXBjaS1iYXNlIGNsYXNzIikNCj4+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+DQo+DQo+
SGV5LCB3ZSB3ZXJlIGRpc2N1c3NpbmcgdGhpcyBpc3N1ZSBvbiBJUkMgeWVzdGVyZGF5ICgjcWVt
dSBvbiBPRlRDKQ0KDQpBaCwgV2hhdCBhIGNvaW5jaWRlbmNlIQ0KDQpCUnMsDQpaaGVuemhvbmcN
Cg0K

