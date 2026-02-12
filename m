Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5751BEDF053
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRsT-0000yn-B6; Thu, 12 Feb 2026 03:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqRsS-0000yf-2M
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:16:44 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqRsP-00029E-2H
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770884201; x=1802420201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZuAWye434z+JmKSclQYV7T5Rfj3U6f1BWTYHEoUDmLQ=;
 b=md8tArf0MX8ERSC+okYhZ2ZWN+wKiITSPwpp/XYoflTyHWSVd6BuAaIT
 tAHYdtUgq4tSCsTbIPKxcWaqJNvt3BLJljB+1+C3JILCFh2i83Lha+S0p
 H30yW3sFG0SN3NbgGiLF96rVOJHu43200016Hga6lZxxorPSjvw/+ayLy
 HVmXiOs8SI0SEK6Rr10cgfFPc8Sw8ncFglVlDctj1aaRexbWf59Pl7jG5
 CBzO9Y6wRVwa2m1shoS7kk2xdBCNhEtPUcDL5VXC7snm7XCq8hw9xFSTm
 cXodsE31t5vIlWP9jOQQGds+CEhrzLXo2BGAWPMb5Oyu2JMaMg+/FCbSz A==;
X-CSE-ConnectionGUID: E683cnZcShe/B26fYPzuEw==
X-CSE-MsgGUID: bMkKiFYlTM+xxwmdTEoDYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="94691314"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="94691314"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:16:38 -0800
X-CSE-ConnectionGUID: +soZEs6FTdmMXgEtojXLBw==
X-CSE-MsgGUID: +PYIrb00S9OmXzhrmzWzdA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:16:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:16:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 00:16:37 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:16:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAGQHmhVEbTI2LPCkyJcswkQBEQgtj0U7BG297xI85Hgbdf91W93wPgPs42cLIzkVcGtbcYahCbaEJeDM9RsdAR/V5b7RVpT1HJlCFozARSUVbzDk0TGNR1tvPLxCuFfdYmriDjDQOOSCLghDaOHw+Cpvw6Yl4S61wRFK8iZkLXE2zESEbLHr5TNSBo5jT39wupsSoLm5icl0S8wl7miiZA1MoHeLIwNai/4c8FJATc4L0vQkMBBehc0RUYI7XcExhnSZj9nnODMo4nBjqx66Vzrbkhd8bRkJZqjaskrqKFqOuYatNso+FO42nkleSavmkgxcqu4URF+7fNkCNJvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuAWye434z+JmKSclQYV7T5Rfj3U6f1BWTYHEoUDmLQ=;
 b=UjkvBNDYhOsYUz7azuYkEDCgQ6QXCK2q2+cNr06ud7tSxDRauiFQWQHF6XXO62MieYlRXUJ4BBWLZ0GnPr/0YUecXpfy2Nbudc0ZHGUSKcgrh9JSKnqQHckaQemtVMib9K4vuk8ccwGzgfyuBiBhzerwPX1zquyjT/Hav4lbDzoIzsm1FsfB3nCWCdZPFoR54aHdHeP7NgxRezVLivS0R9hzlT6lYkla8whlb/1DkQddev+8438G4W7LL5p0TEDHIFONeJkfEmVLWpkifvozWz1PTnDPug5caaqnSQ4tr0e7xn2v0Xn3Q9XMOVgw3Z+s7abnuMkmnGztMy6+DRfL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA3PR11MB9509.namprd11.prod.outlook.com (2603:10b6:806:47e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 08:16:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:16:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
Thread-Index: AQHclk1PoAq5mUodfUSsvYfD19vxArV+uyyAgAACQKA=
Date: Thu, 12 Feb 2026 08:16:34 +0000
Message-ID: <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
 <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
In-Reply-To: <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA3PR11MB9509:EE_
x-ms-office365-filtering-correlation-id: 3b4a25a7-9f64-4d1c-9e1e-08de6a0f097a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?b05oSDlMQUxBdWIveVhIOXVlTllZYml2dUhKUmRMblFsdzNlR280UU9YczQx?=
 =?utf-8?B?YnA1T2lSYUEwOW4vV1JYT0VZdElrL2lJeUJzTExZOFg2SE56b21INzRIZXVo?=
 =?utf-8?B?K2VLR01zMWxmbDFmNlg3NlhoajdtU1orRlZNb2R2Z3lSN2o1eHE1Y1hFNXBt?=
 =?utf-8?B?dTRwVUxNRm84OGN0Qk5LYlRsdks4dDZub3hlQ1JQYWUvV2p0QjdaM0t1b0tT?=
 =?utf-8?B?bk1WR05pL2tMZ0ZVejFpLzJJVlFnOFFvOGgzLzhreG1aUFBWbWx3b3g1dUtv?=
 =?utf-8?B?OEFoSmRkQ1FtM0x2ZFQ5MzB4Q1FNUlJBbU9xSTA0S3EzaXB5TFFSUjJTRUFV?=
 =?utf-8?B?alMreGU2TEh2RFlleE5kem56VzRncXVIWDlMWmkzbzF4aDIvMUptMXpRR1gx?=
 =?utf-8?B?OS9adWhqL3U5d3F5UGd2dUgwNHY0K0hvbWxFNGpyaU9SZVhlbWZpOXlSZ3Fm?=
 =?utf-8?B?bzlLWWZGS3JFV1BQenJWMVordWo0VmhiWDUrci92Sy83cmh2TDlWU3JXYlA4?=
 =?utf-8?B?K00rL1EyenlFRmphQytBSlJXS0NCSjdNMzFnWHVUYmpmVXlhK21YdzhYdDlD?=
 =?utf-8?B?MXFaUERybTlHOUFXRWd4WS8wRUZpVlJjckhBTnVPcGFaQ3B0d043MkJ4d0Fx?=
 =?utf-8?B?TEJoc1JQZHFhZS9sdEJMWDFRQmlLR3pCRkY3K3c5MVRVM1hXbnRzSFJnUzlH?=
 =?utf-8?B?dHFSa3gxWGt1UUUrb1NLQ1NwbU95YnNOOThGR28wZkxDZ1psb1BFOGZvekJH?=
 =?utf-8?B?N1pLY01qWXI1K05VUUlRTko3UFpveTNFVTd5dkxzdEtnd3RrM0tNQWxFVXN0?=
 =?utf-8?B?M1o3emdKaFdFclVmUHBtOGg4M2Y2NmEwR1grZXdwcG9GWWNtdkNLQ0wwNGlC?=
 =?utf-8?B?QVFJdU00aGJKd3lEelBOSWZiQW9Mc3A1N09QK1hXUG9TREtxcHRCYSs2dk9s?=
 =?utf-8?B?THpmYjVKd1A5enZBRi82U2ZOeklFMVBvUlhEaVEvcG1kTlZVWDNadTBqSmU1?=
 =?utf-8?B?MFNIQTZHWVJ3WjBCUnZwNHdMWnZXdlIrVkRWU01PVW9xMUdrNXVNY3N3SVY0?=
 =?utf-8?B?OWlGYUNySlM0MEtEMUZFT2dRQkd0cnJYckl4M1ZYdEVEamlsZ2NzS20vTDJm?=
 =?utf-8?B?Z1diaUx6NzJ1WUVMcHpPMVRhVnNvVlVwRFBtdXlFTktRMVVlMjM0d3dpdXg4?=
 =?utf-8?B?RkluMVBUUnJKbER6MmM5Yk0vY2x3d3pjVHNjR05LVkVERHZ2MTc2UGpibENr?=
 =?utf-8?B?S2F0WWVmRXhoNmNxRFJ1TnhoVi84SEZZelhZa0wxTnpPWXhIU1pWYkFMaTZO?=
 =?utf-8?B?emZKam1lTkRZbHJCK2xIeEVlWjFrMHFyQ0JuNUwxT0FYdEFxRzFndTNIZzNk?=
 =?utf-8?B?aDlFOVEvc2czSTA0WEs0QUZjMlBYMVUvdmdXbUxuSmdJVkRicXpZaU1hYWdw?=
 =?utf-8?B?ZE1lQzA5eUZ1bFVBRk4xZDNaUC9WWTRuZFpLK1diSWZBQ3lwNVR0a2preGd1?=
 =?utf-8?B?di9oWktvUVdURFRBWTU4aGUrZlVlTkFtQ0M1RlZlZjdmL0JBQXB3Y3RsNWRw?=
 =?utf-8?B?T3dYYWhLZjRMTElqWkpzUnhnTHlUcHN1Q0ZZbXpQQnZzOE1UcUxQbXhMb0gx?=
 =?utf-8?B?ZktGcDAyVmhLaDZjMFNpSDl0UjlxUnRRT1pIaEVHWi84L0hTajQrV1JHd0c2?=
 =?utf-8?B?UkkwLzk4VjBhcFBySkJnSGV0VFZEd0dtM1BaeXVNcHN6czI5N21xWjJkN1pG?=
 =?utf-8?B?dHVHSFp6bGxIcXZpVmE4N1BUcUs4VC9uVXpnOUQrazl1bklLM3FSNTF5cU5J?=
 =?utf-8?B?L2hvUDQxRzQyM1RmTmlkT1JiSlo5SlEwZGVDVlZjbzg0Z3gzZnRQUkljeFR4?=
 =?utf-8?B?Y2x4TksxK0laMS9DNEpLNTlxdFpJM2ZaaUdJbTRrcU9ET1FHdjRMK0JXTnd3?=
 =?utf-8?B?U0dlZWtzR0lOTGw0QnNpTFJkQUpyaHhSelFpMVBDckZ2ZUVlcEpEeTF2SmRk?=
 =?utf-8?B?dUxINm9ta0srbUR5KzRWUHlReEdNQmkrODhweGxGYU1aUVM0SnlXRzNKcFRV?=
 =?utf-8?B?c3lyMDRFQUszTzc2TEhtQ0x1d3poNXlkVTV2SmxDR3lMSXM2bXJ0NjdwWWNC?=
 =?utf-8?B?YU5ORXdZR3RoMkVMRVpHZVE2c1pHczRYNTh3K2JWcFJ1eVBTSFd1SGZ5dEpZ?=
 =?utf-8?Q?K3J7VhUHT8zdTAXr0PMtGoE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlEzbTExNVpZZ2w1MFFOVmphd2hQSUJzVmN4Si9vWGlScTloVFFrZGZ6OVRj?=
 =?utf-8?B?ZEZHR2c5bGZFWlpBQUlqdk4wOXQzbWNtYmlTaTBBUGRPK1lueTRwQ0M5WVlj?=
 =?utf-8?B?N3ZmRFNkZDZZYlJROXRURjBhVGdJR0N2WWJRNThkQXBMb2FrQ2QvbnpuanJt?=
 =?utf-8?B?VDBaNmFURGxodGJyNFNUY0NlVEwzRXh3bWttZ2xYWFc1UzBIU2dJdkdIdDVh?=
 =?utf-8?B?RG1IemFON2UxbzdkeWtxL1dPVk9aWW1uZDFuTUcrM1BXWFc4V0FZY0xUdDdp?=
 =?utf-8?B?R1VyRTNSRXdPa1hCUEZ0SHlnS3duVWxneThZc0tZSkVTSEFXaEN5QVZXYWJ0?=
 =?utf-8?B?YVlscGpaOVEyVVBGYktlQWtEYjhkVERoaEVvWUd6SjZUTmczRnhRclVyU0V3?=
 =?utf-8?B?bm9PSUdFc0JsZ2QrZWNMODNXVFhRR2lvZXFqb1FVVWVhOGdLZWxPN29pYzF5?=
 =?utf-8?B?WkdMekdFWTVBY2R4TjVFK2g1WStqRTB2aTZpdENKTXRNeTg4R1hKbkpZaHRO?=
 =?utf-8?B?cGxHTGZ5cEVMWVZ2aENuS3FHRXZ1T2VieGxPS1RkQnBnMlRCOTlLUWlLZE5p?=
 =?utf-8?B?cWt0UkZQSU9mVEdaampYSnF6clBIRnZGTW1GM2JMdlBiMDcvekltWEVaOEpO?=
 =?utf-8?B?c3AvUDVmaHVhNUZsSFhCWVRZU0xwakN1K2RCM3d0OE5ScWxmWWxZYWh5RG1v?=
 =?utf-8?B?VWtDNUx0QXRIbytRWklWMDBvQjhKSzBnbmh6cEVjc1RRUU1mWlpoSmVXWHlw?=
 =?utf-8?B?ZElNRlpaam9DZC95Z3lFZ01MbXJ4NSs3NXBsTENySytOL3lmVmN4RW9sUG91?=
 =?utf-8?B?ZndOS2hKS2hNZUFycU9DeXZWTWV1NDE1R2xneHN0WXRnNUlvUFhIZDcxUDBC?=
 =?utf-8?B?cW51Yk5hMGJ5U2RRRTlFbkRJWWs3eDNUUlFTUVB1QTY4bUxtcXJmL1ZUZUpJ?=
 =?utf-8?B?Y2h2MG4vZ0gwMUtSZVN1OVZJOHY2OUxJcm41dG5hek9mNjI3SzhOY2lON1hJ?=
 =?utf-8?B?TjZKTU1PTmFGT0FGamlEMUdNVW5jSEkvQ1NPNWRBbjhpUjBHRFFlVXJNU0Qr?=
 =?utf-8?B?U1ZLTUF0YjdwcW5ETHVLbjFiOFU0U2JnbkJnVVJqL2lMcjdlTFVDSVJFc2x1?=
 =?utf-8?B?SUpQbzVJajhaRWw2M0VmYnlyZ0Y2SjIzTmhKajU0NU9vazlLcU92UlFjTUcz?=
 =?utf-8?B?dDNndGtVRXhQM21lRHM1aFUybjVQTy9sWkNBT3l6Ui9pTVlKRHNjMExhTmxq?=
 =?utf-8?B?S0d5bEEzRGpTd1RSZlpxajZoUFFTcmNOaE8xeVM3aXA2ZHBWcytyT2x4MkNE?=
 =?utf-8?B?MnhmNFNMV1BGOHdXTnJsVUVhalg5cHQzcktnQisyOHdldGlkNTYxdkEzcWxQ?=
 =?utf-8?B?aWhFZGFDbWFuZFR5aFBwQUpDbGlnOHNCbHM0STVIV0JPS2xlNWhYdEV4UUVa?=
 =?utf-8?B?UjNoeVJHckVEUmc5RGNoeCtDRTFaS3pPb05MTXpib3UzMVV0ZnY5Q2hYS2t1?=
 =?utf-8?B?TnNSRWN4emFxZEwrTncydUtJSzc4UzQ1R1hEVjkzQVVRQmhjUWVRQm5TUmd0?=
 =?utf-8?B?S2lUNHlTSzR0UTNpd0pnbEpnanlpODA2YVNEbHRIOGlsRm5KZ1U3U0FBRCtS?=
 =?utf-8?B?WWVkdGpabE00RlorMTNyRjZIVDQ5OGgwUGI2K3dqT25KYThlalN0bTFaMG9w?=
 =?utf-8?B?VWN4YWhwMGRZOXh0RVVhTnpSczZ3MGU2elFxelAyc3RGNithSnJLMTFkVnNW?=
 =?utf-8?B?QXUydjNiWmZJMTlsOUVwZU9ZWStCZ2hlWFRxbEJxNjBqV29WSE1hVElaVTh4?=
 =?utf-8?B?UEQ0cDRVaEgxWWxsVFRPTUtlWlYvNVpaQ1psSXQyOEoyVG0weDhaZE1WRDgr?=
 =?utf-8?B?enhlMFlUQkI2OHBrOE5JTHc4WmtZdTIvRkJZdnhqMWVtaHdFVzVZaStNZjc5?=
 =?utf-8?B?MTk4K3BwaExKSC8rVkY0NHFyVTZFRU9INUt0YVdVVzIrdS9tYTFESGhaQk1j?=
 =?utf-8?B?THJQVXdtUXlHQXR1eTQyb2xXUTNwaFpFZ25VQjlnL1lGRlZqR0VtTGVCdVhB?=
 =?utf-8?B?dmNtZGZnRnNlamZpbjFxVlZkZ3g1VmZCSGFFOUJFUXl5NkFaZWRNN3kzbHUx?=
 =?utf-8?B?LzcvVE10WUJTQ2VEL0JRaXFyZ1dkaHJTTVJzRDg1ZzV0dHJrQ3lKVjV2SC9O?=
 =?utf-8?B?T3RmeWZUWDRSWVBwMTJjVGZZQ2YvaEQ0Yk0xNGRqditsWENjdEJORHU4Wk9H?=
 =?utf-8?B?SjNxMWZFV2RlckpaUCtDRHlUNDNITXNQTHcwQlJjTGQzd2YyeXhjeGJlOHJO?=
 =?utf-8?B?OEU4NEtrNzJrek9nKzBKWmJYci9RYUtRMklKSVVQekQ5NmhxcHloQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4a25a7-9f64-4d1c-9e1e-08de6a0f097a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 08:16:34.8192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5c7vP5uDcC+wXYhV73mB+p5Yb1Zw11VJwH2ggWwEorxswyf67X4HVRHzcJJCqubIuUOiwR/DZvZlcqB2ci1EstjmIo3KiHVNqaWXABJJSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9509
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsZW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMDUvMTRdIGludGVsX2lvbW11OiBDaGFuZ2UgcGFzaWQgcHJvcGVydHkgZnJvbSBi
b29sIHRvDQo+dWludDgNCj4NCj4NCj5PbiBXZWQsIDIwMjYtMDItMDQgYXQgMjI6MTEgLTA1MDAs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gJ3gtcGFzaWQtbW9kZScgaXMgYSBib29sIHByb3Bl
cnR5LCB3ZSBuZWVkIGFuIGV4dHJhICdwc3MnIHByb3BlcnR5IHRvDQo+PiByZXByZXNlbnQgUEFT
SUQgc2l6ZSBzdXBwb3J0ZWQuIEJlY2F1c2UgdGhlcmUgaXMgbm8gYW55IGRldmljZSBpbiBRRU1V
DQo+PiBzdXBwb3J0aW5nIHBhc2lkIGNhcGFiaWxpdHkgeWV0LCBubyBndWVzdCBjb3VsZCB1c2Ug
dGhlIHBhc2lkIGZlYXR1cmUNCj4+IHVudGlsIG5vdywgJ3gtcGFzaWQtbW9kZScgdGFrZXMgbm8g
ZWZmZWN0Lg0KPj4NCj4+IFNvIGluc3RlYWQgb2YgYW4gZXh0cmEgJ3BzcycgcHJvcGVydHkgd2Ug
Y2FuIHVzZSBhIHNpbmdsZSAncGFzaWQnDQo+PiBwcm9wZXJ0eSBvZiB1aW50OCB0eXBlIHRvIHJl
cHJlc2VudCBpZiBwYXNpZCBpcyBzdXBwb3J0ZWQgYW5kIHRoZSBQQVNJRA0KPj4gYml0cyBzaXpl
LiBBIHZhbHVlIG9mIE4gPiAwIG1lYW5zIHBhc2lkIGlzIHN1cHBvcnRlZCBhbmQgTiAtIDEgaXMg
dGhlDQo+PiB2YWx1ZSBpbiBQU1MgZmllbGQgaW4gRUNBUCByZWdpc3Rlci4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXSht
YWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IC0tLQ0KPj4gwqBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCAxIC0NCj4+IMKgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmjCoCB8IDIgKy0NCj4+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNCArKy0tDQo+PiDCoDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGEyY2E3OWY5
MjUuLjcxY2IzYjY2MmUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5
NCw3ICsxOTQsNiBAQA0KPj4gwqAjZGVmaW5lIFZURF9FQ0FQX1BSU8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoMVVMTCA8PCAyOSkNCj4+IMKgI2RlZmluZSBWVERfRUNBUF9NSE1WwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMTVVTEwgPDwgMjApDQo+PiDCoCNkZWZpbmUgVlRE
X0VDQVBfU1JTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IDMxKQ0KPj4g
LSNkZWZpbmUgVlREX0VDQVBfUFNTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICg3VUxM
IDw8IDM1KSAvKiBsaW1pdDogTWVtVHhBdHRyczo6cGlkICovDQo+PiDCoCNkZWZpbmUgVlREX0VD
QVBfUEFTSUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MCkNCj4+IMKgI2Rl
ZmluZSBWVERfRUNBUF9TTVRTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0
MykNCj4+IMKgI2RlZmluZSBWVERfRUNBUF9TU1RTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAoMVVMTCA8PCA0NikNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaCBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCA2YzYxZmQzOWM3
Li41ZTU3NzllNDYwIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMzE1LDcg
KzMxNSw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gwqDCoMKgwqAgYm9vbCBidWdn
eV9laW07wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRm9yY2UgYnVnZ3kgRUlN
IHVubGVzcyBlaW09b2ZmICovDQo+PiDCoMKgwqDCoCB1aW50OF90IGF3X2JpdHM7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEhvc3QvSU9WQSBhZGRyZXNzIHdpZHRoIChpbiBiaXRz
KSAqLw0KPj4gwqDCoMKgwqAgYm9vbCBkbWFfZHJhaW47wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyogV2hldGhlciBETUEgci93IGRyYWluaW5nIGVuYWJsZWQgKi8NCj4+IC3CoMKg
wqAgYm9vbCBwYXNpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4gK8KgwqDCoCB1aW50OF90IHBhc2lkO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUEFTSUQgc3VwcG9ydGVkIGluIGJp
dHMsIDAgaWYgbm90ICovDQo+PiDCoMKgwqDCoCBib29sIGZzMWdwO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRmlyc3QgU3RhZ2UgMS1HQnl0ZSBQYWdlIFN1cHBv
cnQgKi8NCj4+DQo+PiDCoMKgwqDCoCAvKiBUcmFuc2llbnQgTWFwcGluZywgUmVzZXJ2ZWQoMCkg
c2luY2UgVlREIHNwZWMgcmV2aXNpb24gMy4yICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBlOGE2ZjUwYTVh
Li45MTZlYjBhZjVhIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC00MTUxLDcgKzQxNTEsNyBAQCBzdGF0
aWMgY29uc3QgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+IMKgwqDCoMKgIERFRklO
RV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVf
bW9kZSwNCj5GQUxTRSksDQo+PiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4LWZsdHMiLCBJ
bnRlbElPTU1VU3RhdGUsIGZzdHMsIEZBTFNFKSwNCj4+IMKgwqDCoMKgIERFRklORV9QUk9QX0JP
T0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsDQo+ZmFs
c2UpLA0KPj4gLcKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElP
TU1VU3RhdGUsIHBhc2lkLCBmYWxzZSksDQo+PiArwqDCoMKgIERFRklORV9QUk9QX1VJTlQ4KCJw
YXNpZCIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIDApLA0KPj4gwqDCoMKgwqAgREVGSU5FX1BS
T1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFfZHJhaW4sIHRydWUpLA0K
Pj4gwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgic3RhbGUtdG0iLCBJbnRlbElPTU1VU3RhdGUs
IHN0YWxlX3RtLCBmYWxzZSksDQo+PiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJmczFncCIs
IEludGVsSU9NTVVTdGF0ZSwgZnMxZ3AsIHRydWUpLA0KPj4gQEAgLTQ5ODEsNyArNDk4MSw3IEBA
IHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiDCoMKgwqDC
oCB9DQo+Pg0KPj4gwqDCoMKgwqAgaWYgKHMtPnBhc2lkKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAg
cy0+ZWNhcCB8PSBWVERfRUNBUF9QQVNJRCB8IFZURF9FQ0FQX1BTUzsNCj4+ICvCoMKgwqDCoMKg
wqDCoCBzLT5lY2FwID0gVlREX0VDQVBfUEFTSUQgfCBkZXBvc2l0NjQocy0+ZWNhcCwgMzUsIDUs
IHMtPnBhc2lkIC0gMSk7DQo+DQo+SSB0aGluayB0aGlzIGlzIGEgYml0IGRhbmdlcm91cywgdGhl
IE1lbVR4QXR0cnMgb25seSBhbGxvdyB1cCB0byA4IGJpdHMuDQo+V2UgaGF2ZSBhIGNvbW1lbnQg
bmV4dCB0byB0aGUgZGVmaW5pdGlvbiBvZiBWVERfRUNBUF9QU1MgYWJvdXQgdGhpcy4NCg0KQ291
bGQgeW91IGVsYWJvcmF0ZSB3aGF0IGRhbmdlcm91cyBkbyB5b3Ugc2VlIGlmIHMtPnBhc2lkID4g
OD8NCk1lbVR4QXR0cnMgb25seSBhbGxvdyB1cCB0byA4Yml0cywgdGhlbiBNYXggUEFTSUQgV2lk
dGggaW4gZW11bGF0ZWQgZGV2aWNlJ3MNClBBU0lEIGNhcGFiaWxpdHkgUmVnaXN0ZXIgaXMgbm8g
bW9yZSB0aGFuIDguIEVtdWxhdGVkIGRldmljZSBzaG91bGQgbmV2ZXIgc2VuZA0KYSBSZXF1ZXN0
LXdpdGgtcGFzaWQgd2l0aCBwYXNpZCA+IDI1NS4NCg0KSGFyZCBjb2RlIFZURF9FQ0FQX1BTUyB0
byA4IGJpdHMgd2lsbCBtYWtlIHVzIG5vdCBhYmxlIHRvIHV0aWxpemUgdGhlIGZ1bGwgcGFzaWQN
CnNwYWNlIG9mIHBhc3N0aHJvdWdoIGRldmljZSBpZiBpdCBoYXMgbGFyZ2VyIE1heCBQQVNJRCBX
aWR0aCB2YWx1ZSBpbiBwYXNpZCBjYXBhYmlsaXR5Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

