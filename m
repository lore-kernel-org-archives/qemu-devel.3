Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4C3C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTu3F-0002hg-CL; Tue, 16 Jul 2024 22:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTu3B-0002h7-5R
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:05:49 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTu37-00015M-8v
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721181945; x=1752717945;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QO8tVQBgGQUqKNrzLf8e9RucWvxDJ3GNEA7xe3pP9lE=;
 b=PH2UVVZoGE0c0ZK4eDOX82y/loBrq8RzTBYGbm3208QP9gMs/qngNgp9
 MZxxuSNCbc0OtKVW2W/BjYQGOnsjDDjxnvTeeMppJksl6MV25NGk+H/P9
 4SyHny+RHbeCkaxL8KbVqN0izD+IlXfD6Gbar9jYx9Ijly6dEr9MaT8Ij
 z7gmHeMRJo8tFeQi2mAbgrMf3UJMRn8v6LUrt991h/5iKGJS+6J6ayPir
 5nGTFlAEzBpKTSVbjtcGvD7AGLrDSQhag2WFWHKVbdf11iLiocR/xzdYG
 tz8FKmAbtPrcN8U8Qp7TTOPD+3ZNpQwL8/Pb2XiY+ioqHmyWDCNEYWNLl g==;
X-CSE-ConnectionGUID: Jo2ZvAl9QvOeQd+8/Xf+MQ==
X-CSE-MsgGUID: hegkiI6lRcC2/HjylhkUEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18852177"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="18852177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 19:05:41 -0700
X-CSE-ConnectionGUID: 0nXPbabMRDy3ymS1lS/itg==
X-CSE-MsgGUID: mGM47beIQ6O1UvNPz7XlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50290236"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 19:05:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:05:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 19:05:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea351HWTreVq1cGDy6LdVTWgIzncfY22iQ01Zc+UqCEBMyCpmtRWmAGi5avo0+m779HPwzJfXzH3dfmMeAOCLljBFoWvThysKJMGDHIBqgqcQYu1+i0YKeVw8ehLnX9GWJSvSUP3lVHfTWv1FfV68pZ1w8SCx8bGxqL4hP9FqWYadihETipueD1taFqb/A/G8VmsOEd3jzf6KmhIli2tRqf2IVLF+oGE8VyWZe2qpNXjNUCgvTwA5rjTluuhSsI0IORB05B9XhF1cS0HEBFg28KsbSQvOYaMyf4P5T53uwhVCPsoVqc+sbyN2G9kuLj46fZDQBTya05bK1T1RMINLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO8tVQBgGQUqKNrzLf8e9RucWvxDJ3GNEA7xe3pP9lE=;
 b=TNNNFGeJ+nI/pWyqqiii0fiJm5OpH6BHlG64zKK0g4KiBaTP5z46H6/ZEF5vCuBW1qGSt7O7YV/GBxcUufOmNmppz0K/ZKJWKZPhP4OoC8cvjF7tGlVggRNSMzixBHKl5QIyZbQLpRLkQrXJnlCDBYukl8rmubfhtJdOOSM5NSMhPsriANBvpozYGHClm3e+3wjfthz8vB1QTLviIYEBcTnAyhjealgs4FhKcL+2qlVk0PNpcI0RPCCjQznoG/tUcVUNgSYRub/Nju6tFqMaYXZI3vmfjs9HrtyiTDtQE0+DL1mP6RjBZRGLHGmyDC5jk7yw+AxIOfWayifvKjkYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 02:05:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 02:05:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
Thread-Topic: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
Thread-Index: AQHa1FFS0cowcWO6ZUSMvcz1LquWZbH6MiRA
Date: Wed, 17 Jul 2024 02:05:36 +0000
Message-ID: <SJ0PR11MB6744FCF630DDF790C832363F92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-8-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5277:EE_
x-ms-office365-filtering-correlation-id: dcc04a04-4605-472d-8805-08dca604f29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VElLMitRMW4zMk9JbzkzaUUxaEdIWE92OTdBNEprTG1rdlVmbkp2TEsyWGp6?=
 =?utf-8?B?NnNmSnQ5bWJXNUVRZStnM3NYTjhxZ0lBYUh0ajZEVkJDMWhXa1g2d0I3Vzhj?=
 =?utf-8?B?bHUvTjFHM1VLbm5jQ2JZREVydHcrWGlmdWZyMmpXbHR3THd3anJvT3ZJYUt3?=
 =?utf-8?B?cEgyVVRHN1llQndFcE1kdEt5LzhmUCtKV3NkTXlLaktuQmtMY0NTbVFYdFpZ?=
 =?utf-8?B?eVg1MzE3Rk1Cd2ZmWktaUlBOUmFud2dPRVAxYTArSmRwNEtOUGtIRkNaNlZL?=
 =?utf-8?B?Zm5GRU16R1RBOGhwNU9uWFpJK0JkcGl0N25mam5yWVU4NEJaK3BkMjBqTmNO?=
 =?utf-8?B?dnBLejNCZ2o2RFBkcUlOdWRBRzBCTmx6QW1uVWhNN1dmNkkzajl2Rlloc0Nj?=
 =?utf-8?B?MEtXUE9zU1J4anRHenFOK3JjbVI1MzR4ZjE1S3pGRHlYMCt0MUl4ZE11bHlt?=
 =?utf-8?B?b2dqRXRVWE1wUVc3ZEVKT1BDQ1ZHbGF2SnRBVythMkZSdXpoL3VtYitaNzJP?=
 =?utf-8?B?RVk3VlNsTlZTVmgxUnpKRzZXSTBUc0JGQVFzU2tBUmE3MkdLY1JxSmp0SndV?=
 =?utf-8?B?SysybzlLYXR4WEFRTkd0ZEZjK0RYWDlKQlZ0YmFpcFZZSVMrWVd1akE5VjJT?=
 =?utf-8?B?MWdoVzFYNUNlVko5eE54YktnSmJYR1d3bGFGSGJ5Um9TcHBHdUxUODJ5ZllJ?=
 =?utf-8?B?Qys2bVVjd0dpbWxIVVdBcUJwQm53Y2JjUVJjaGt4bXZiY2tQbjI3bDV0Tjd4?=
 =?utf-8?B?NkpaZEVpak5ONElVZzh5aTI0WDYveFAzbUE0Ym9pd1krdzk1MG12UWRiYW04?=
 =?utf-8?B?YkllaWR5Q1IzZSsxeEh1azgyMGtVRVN0dnZpZG5jTEhNaUZwVjV6amRER2hx?=
 =?utf-8?B?MEg4dVlyc1dEOGJSdFJDZVJqbU11UzJvejUrMHZCRTRWNytrLy92MG9xdENT?=
 =?utf-8?B?MWpJY3ZKWE95TEp2ZDg1ZVVrOXI0dkh4cytpek9uODN2dGJmMnBXRWRxdzZU?=
 =?utf-8?B?RHZTR1l5RmttRWhZd1RXRjc1ZjlleVN2dzZMd25RaldPd095REtRc2puMGFm?=
 =?utf-8?B?dm9adTFrdjZ6N3c0TXIzcjdBL09lTnZ1UEU4Q1l1dlJsYys0WkRHRms2TVBW?=
 =?utf-8?B?WEdjK2txQ0ZuUGZOQ3drSm5aYWw2cWtNTU1GOXFwRlMrVWg3RnVNSW1VbXFk?=
 =?utf-8?B?VW9DQTlzUGhaK3NJQnJGOThTQVN1V01VcFcvK05FMGp5dW1tMTBVa29XL1JG?=
 =?utf-8?B?ZG5sZnExbHBsc0ZRM0lLSkwwVW9aU255dDhyV1pNcnh3N0Z1MUR4NDdCUnFv?=
 =?utf-8?B?aGpES00zVEhRa1h4amZISnpwbEdybVl5TDNBcVJMQjlvY1NHT3k1M3RCczQy?=
 =?utf-8?B?blhpTGo2OXBvSk40QXprK3NzbXVoRkZaR1dRcDU0Z25jMUl4TVVDaG9TaUpw?=
 =?utf-8?B?dVVzNjZRSU9LVkxybFg5bkx2NEhsTUVVZ2dPZmFJOE9xTGFRY21MK3dmWW0w?=
 =?utf-8?B?WnhOQkJVcVZlTWVvSjMwSU1CdnhsdUhWU2RxOEJQZ2JRaXVSQ2w0K0VVQ1Rq?=
 =?utf-8?B?dEp1OTZ5N3g3OUVmeTZBOWpFakRIRkZtZGljVENoOFNkcDV4eVlUaHYrTTln?=
 =?utf-8?B?TUV6cUtYWWVVVkphYVNrNTdhM3E3TDJJaDlDcVltZ3dlUUthSWZKT0ltazR2?=
 =?utf-8?B?dUQ2dWxINTlrNTZ4STNkR2NBRUgzK3pwMFNsSStsY21uUVFuN1ljdW9LeGtW?=
 =?utf-8?B?aHYxQzYyTTBWNjdRZEJESWpLSEhEVDViSUV3V0ZGVVU3dzdSNGVPZEREUDkx?=
 =?utf-8?B?d2l0bXhUWnI0aHNpbEZkd08xVHVaMVVwbWpPY1RlcEJZeGxGWjJjZ1Raa2tK?=
 =?utf-8?B?a0t0T0NGQnB0d2FTWWNoNzExVVVWUDRhK01kcCtXNFAza2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNWWkt6U0gwQ3N4ZFhyWUp3M3doeEpuUVA1RkJ2TWV1M2lFTUxQNGZLdDZP?=
 =?utf-8?B?SklLTFpsNW5OajREZHZ4U1pLekNjQTRQLzlsMnZZUXBjMjFpOHhSZTk3akVW?=
 =?utf-8?B?ckpLRXhkTTRUSDBlUjBFYlgrUUZkZ2JrWUhKM216S1VrM2NscE9TMzltOVp2?=
 =?utf-8?B?WXV2eVVGK1V4dXJNWWJCTVA3QnVFSW5TSEcrVFprZUMrMzN0STBlam5MUEFV?=
 =?utf-8?B?TTdlOVY1Y3AvbDQzQzRweW1zakxFU2ZjSDZTV3pBenh1dSswY3J2amwwRDZS?=
 =?utf-8?B?ZHY3UmowQVlWY2Vnem1wcEpMa2Y3S1VLT3dqbUNIZkpYODR2d0p2U1RTSkpJ?=
 =?utf-8?B?RkFCM1FEcjROdVZ1M0tzWHFCVEswd2UrRFg1WTJ2aDlBc0xpeWZTdGJqb3Rp?=
 =?utf-8?B?WkpBRlVMWTRzQ0ZsTnJFVTRaalJCYjkrMWNvcnlhNkphRXAzV1gwb2N5Tm93?=
 =?utf-8?B?WGlka2cxdDFwWXgxOWI3MnJzQWs1SlV6aGZudUs2SkFQeFNpQ0VyOFE1SHNS?=
 =?utf-8?B?dWRyS0RrV2U2dGhRanRONk5jeG1RUWJzaU9iYTBWSFpzZkdNYUEvVXVXaEhY?=
 =?utf-8?B?MTRJZWsvNEVUNGYrR3p5c0x2MXBIT2dCWDVWcERHcWxMWE41Um9ZTU9ZUDZH?=
 =?utf-8?B?dE5sNGF0OHZORXBQblRMWFJ3WDlUYkxMQXR1T0hXRTduelVaS1FkWkVOYng1?=
 =?utf-8?B?RnFJN0VuSUFlZkdTV1ZhSlpocXNtK0Ntc3ZvRnM5RXhocTRnYWFBRFRKYzh3?=
 =?utf-8?B?L3NGTFMrenNSMjloY2lIRzlETlk3T1dvbTRlaitwK2x2UjZNcmRaeGZRVHNs?=
 =?utf-8?B?VTVyTDJmYUIvQmRNcFVFMk4vTW1kblh3cnY2NWJtR0V3TEw0ZklCSVc0dTlW?=
 =?utf-8?B?ZjVVQ2xMcXdQaHNVTVprbTQxTmhyVjlWcUNrTVhMRWlQbXhHR0VEOWZURytw?=
 =?utf-8?B?bjQwUGE0VmRIL29TeFZBRnE1Y3VBakY1MWVXREdZMU5FbVNqNVFZQmRaTnZh?=
 =?utf-8?B?S1BuL1BhUzEzMk0rR1lLSDVMcGc2OStkVG5QY1hhSmFhd2hTd1N0eXpyZjR4?=
 =?utf-8?B?VlBXdEpucEhpSmMycDduS0hSVWtQblhSeXN3cWR6eHpjOWdWdW16dFBwSFJO?=
 =?utf-8?B?WjZRN2VSc3N4NHVlZU1CdEdkSk5CSHcrUnZ0ZHU5R1NiUWhzTGdWaEdKMkw2?=
 =?utf-8?B?TERjeWJaak9DVldqNmtEcE1jakNpQm5CNG04a0g5bFYxVldRV3Bjb1ZjdkhQ?=
 =?utf-8?B?UWdueDZJYTBUa3pmdThYOGc1aXhjUGFrL0lVb3E0SFEwVXF5S08wS01PV21w?=
 =?utf-8?B?b2Z3Ylg3Vm0xTm16ZGxkcllKWk5Eb2FoWmxLa3ZmOGJpdFZESlN2aWtxaEhS?=
 =?utf-8?B?VjU0c0tMN0NZRmdFdmxOYmd5cUxzWWpnT2NqM0lYSkhUWkVnMTY3QUM1b0ls?=
 =?utf-8?B?b1hqL3RsZWpUTWpmcmtkSXRqdVJXYURvS3RpejdyNGx3cjFqV0JOSDFaOE9y?=
 =?utf-8?B?WlcwT05SVHpzc1V6Qm1uR01INUdZYklzb0tGK2t1VHRUcFRxSWNidURuSnBt?=
 =?utf-8?B?RFBHYmt1Mk5WanE5Um5oYlFqU2hNT2htNWgxQUN5TWxzWDlrOUgrUys0cnNm?=
 =?utf-8?B?Um5iOUF5VENsaFgyY2I4M1pCSGh5S3NLYjZ4WHBRRW5SbDhzWDZLVm16YWlZ?=
 =?utf-8?B?ak1PRllLVnp2SHpaU3FCUWJVUjZtL3dSNXFSTEQyMGQ5WURUU054RzhmTGw3?=
 =?utf-8?B?eVA2Snp1NmM1Tm5yUkorRkZZMDREenExWGhuTzE0U29IRG1LQUdndFo5SVVw?=
 =?utf-8?B?WkE4bncxdWYxckx4Ti9pcFBoaGtzdG1mU0dSbFYvOU9neUJLdjF1M1kwTVNX?=
 =?utf-8?B?ZUwzbkx2Sm12aGlwQVUvUVN2VWE3YU1vOGFXbVRsQmVqNmIraFJ6QkVJU09k?=
 =?utf-8?B?ZEpDaGg0U0h5R05Zak4vdnUrRkw2bHBaRUZGTmdnWHhzdlJwUXNwZkplSUZa?=
 =?utf-8?B?S2MrRC9vTk1PeDUvZ3pnVmlmajUxNi9yS3l3UEp6c3dsb093WUltb0M4cWRG?=
 =?utf-8?B?Q1hHM0tEaHZ6WjVXODduT1Rmc29kaHhGeEJ0dUlHREVXcE9temtKUUpmL0xE?=
 =?utf-8?Q?Up8xI2mpnBb7VRsWgCIhvjo0S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc04a04-4605-472d-8805-08dca604f29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:05:36.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Vsvekm3bE3NuwDHU+zYpGq8BxqPzkruRYh+y3s4roooHDdmgTrkRrxYT2C0z1CknrPx6zpUBFR9FrOC1r25IkZ5pEltH327/0Z57RLwJBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjQgMDcvMTJdIHZmaW8v
e2lvbW11ZmQsY29udGFpbmVyfTogSW5pdGlhbGl6ZQ0KPkhvc3RJT01NVURldmljZUNhcHMgZHVy
aW5nIGF0dGFjaF9kZXZpY2UoKQ0KPg0KPkZldGNoIElPTU1VIGh3IHJhdyBjYXBzIGJlaGluZCB0
aGUgZGV2aWNlIGFuZCB0aHVzIG1vdmUgdGhlDQo+SG9zdElPTU1VRGV2aWNlOjpyZWFsaXplKCkg
dG8gYmUgZG9uZSBkdXJpbmcgdGhlIGF0dGFjaCBvZiB0aGUgZGV2aWNlLiBJdA0KPmFsbG93cyBp
dCB0byBjYWNoZSB0aGUgaW5mb3JtYXRpb24gb2J0YWluZWQgZnJvbSBJT01NVV9HRVRfSFdfSU5G
Tw0KPmZyb20NCj5pb21tdWZkIGVhcmx5IG9uLiBIb3dldmVyLCB3aGlsZSBsZWdhY3kgSG9zdElP
TU1VRGV2aWNlIGNhcHMNCj5hbHdheXMgcmV0dXJuIHRydWUgYW5kIGRvZXNuJ3QgaGF2ZSBkZXBl
bmRlbmN5IG9uIG90aGVyIHRoaW5ncywgdGhlDQo+SU9NTVVGRA0KPmJhY2tlbmQgcmVxdWlyZXMg
dGhlIGlvbW11ZmQgRkQgdG8gYmUgY29ubmVjdGVkIGFuZCBoYXZpbmcgYSBkZXZpZCB0byBiZQ0K
PmFibGUgdG8gcXVlcnkgY2FwYWJpbGl0aWVzLiBIZW5jZSB3aGVuIGV4YWN0bHkgaXMgSG9zdElP
TU1VRGV2aWNlDQo+aW5pdGlhbGl6ZWQgaW5zaWRlIGJhY2tlbmQgOjphdHRhY2hfZGV2aWNlKCkg
aW1wbGVtZW50YXRpb24gaXMgYmFja2VuZA0KPnNwZWNpZmljLg0KPg0KPlRoaXMgaXMgaW4gcHJl
cGFyYXRpb24gdG8gZmV0Y2ggcGFyc2UgaHcgY2FwYWJpbGl0aWVzIGFuZCB1bmRlcnN0YW5kIGlm
DQo+ZGlydHkgdHJhY2tpbmcgaXMgc3VwcG9ydGVkIGJ5IGRldmljZSBiYWNraW5nIElPTU1VIHdp
dGhvdXQgbmVjZXNzYXJpbHkNCj5kdXBsaWNhdGluZyB0aGUgYW1vdW50IG9mIGNhbGxzIHdlIGRv
IHRvIElPTU1VX0dFVF9IV19JTkZPLg0KPg0KPlN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNpZ25lZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5t
Lm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4tLS0NCj4gaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9k
ZXZpY2UuaCB8ICAxICsNCj4gaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICB8IDE2
ICsrKysrKy0tLS0tLS0tLS0NCj4gaHcvdmZpby9jb250YWluZXIuYyAgICAgICAgICAgICAgICB8
ICA2ICsrKysrKw0KPiBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgIHwgIDcgKysr
KysrKw0KPiA0IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+
Yi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+aW5kZXggMjBlNzdjZjU0NTY4
Li5iMWU1ZjRiOGFjM2UgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9k
ZXZpY2UuaA0KPisrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj5AQCAt
MjQsNiArMjQsNyBAQA0KPiAgKi8NCj4gdHlwZWRlZiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2Fw
cyB7DQo+ICAgICB1aW50MzJfdCB0eXBlOw0KPisgICAgdWludDY0X3QgaHdfY2FwczsNCj4gfSBI
b3N0SU9NTVVEZXZpY2VDYXBzOw0KPg0KPiAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0Ug
Imhvc3QtaW9tbXUtZGV2aWNlIg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcv
dmZpby9jb21tb24uYw0KPmluZGV4IGIwYmVlZDQ0MTE2ZS4uY2MxNGYwZTNmZTI0IDEwMDY0NA0K
Pi0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4rKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+QEAgLTE1
NDQsNyArMTU0NCw3IEBAIGJvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9E
ZXZpY2UNCj4qdmJhc2VkZXYsDQo+IHsNCj4gICAgIGNvbnN0IFZGSU9JT01NVUNsYXNzICpvcHMg
PQ0KPg0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lP
TU1VX0xFR0FDWSkpOw0KPi0gICAgSG9zdElPTU1VRGV2aWNlICpoaW9kOw0KPisgICAgSG9zdElP
TU1VRGV2aWNlICpoaW9kID0gTlVMTDsNCg0KTm8gbmVlZCB0byBOVUxMIGl0Pw0KDQo+DQo+ICAg
ICBpZiAodmJhc2VkZXYtPmlvbW11ZmQpIHsNCj4gICAgICAgICBvcHMgPQ0KPlZGSU9fSU9NTVVf
Q0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lPTU1VX0lPTU1VRg0KPkQpKTsN
Cj5AQCAtMTU1MiwyMSArMTU1MiwxNyBAQCBib29sIHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpu
YW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPg0KPiAgICAgYXNzZXJ0KG9wcyk7DQo+DQo+
LSAgICBpZiAoIW9wcy0+YXR0YWNoX2RldmljZShuYW1lLCB2YmFzZWRldiwgYXMsIGVycnApKSB7
DQo+LSAgICAgICAgcmV0dXJuIGZhbHNlOw0KPi0gICAgfQ0KPg0KPi0gICAgaWYgKHZiYXNlZGV2
LT5tZGV2KSB7DQo+LSAgICAgICAgcmV0dXJuIHRydWU7DQo+KyAgICBpZiAoIXZiYXNlZGV2LT5t
ZGV2KSB7DQo+KyAgICAgICAgaGlvZCA9IEhPU1RfSU9NTVVfREVWSUNFKG9iamVjdF9uZXcob3Bz
LT5oaW9kX3R5cGVuYW1lKSk7DQo+KyAgICAgICAgdmJhc2VkZXYtPmhpb2QgPSBoaW9kOw0KPiAg
ICAgfQ0KPg0KPi0gICAgaGlvZCA9IEhPU1RfSU9NTVVfREVWSUNFKG9iamVjdF9uZXcob3BzLT5o
aW9kX3R5cGVuYW1lKSk7DQo+LSAgICBpZiAoIUhPU1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyho
aW9kKS0+cmVhbGl6ZShoaW9kLCB2YmFzZWRldiwNCj5lcnJwKSkgew0KPisgICAgaWYgKCFvcHMt
PmF0dGFjaF9kZXZpY2UobmFtZSwgdmJhc2VkZXYsIGFzLCBlcnJwKSkgew0KPiAgICAgICAgIG9i
amVjdF91bnJlZihoaW9kKTsNCj4tICAgICAgICBvcHMtPmRldGFjaF9kZXZpY2UodmJhc2VkZXYp
Ow0KPisgICAgICAgIHZiYXNlZGV2LT5oaW9kID0gTlVMTDsNCj4gICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ICAgICB9DQo+LSAgICB2YmFzZWRldi0+aGlvZCA9IGhpb2Q7DQo+DQo+ICAgICByZXR1
cm4gdHJ1ZTsNCj4gfQ0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZp
by9jb250YWluZXIuYw0KPmluZGV4IGMyN2Y0NDhiYTI2ZS4uMjlkYTI2MWJiZjNlIDEwMDY0NA0K
Pi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+
QEAgLTkwNyw2ICs5MDcsNyBAQCBzdGF0aWMgYm9vbCB2ZmlvX2xlZ2FjeV9hdHRhY2hfZGV2aWNl
KGNvbnN0IGNoYXINCj4qbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJw
KQ0KPiB7DQo+ICAgICBpbnQgZ3JvdXBpZCA9IHZmaW9fZGV2aWNlX2dyb3VwaWQodmJhc2VkZXYs
IGVycnApOw0KPisgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kID0gdmJhc2VkZXYtPmhpb2Q7DQoN
Ckhpb2QgaXMgdXNlZCBvbmx5IG9uY2UgaW4gdGhpcyBmdW5jLCBtYXkgYmUgdXNlIHZiYXNlZGV2
LT5oaW9kIGRpcmVjdGx5Pw0KDQoNCj4gICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2X2l0ZXI7DQo+
ICAgICBWRklPR3JvdXAgKmdyb3VwOw0KPiAgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWlu
ZXI7DQo+QEAgLTkxNyw2ICs5MTgsMTEgQEAgc3RhdGljIGJvb2wgdmZpb19sZWdhY3lfYXR0YWNo
X2RldmljZShjb25zdCBjaGFyDQo+Km5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPg0KPiAg
ICAgdHJhY2VfdmZpb19hdHRhY2hfZGV2aWNlKHZiYXNlZGV2LT5uYW1lLCBncm91cGlkKTsNCj4N
Cj4rICAgIGlmIChoaW9kICYmDQo+KyAgICAgICAgIUhPU1RfSU9NTVVfREVWSUNFX0dFVF9DTEFT
UyhoaW9kKS0+cmVhbGl6ZShoaW9kLCB2YmFzZWRldiwNCj5lcnJwKSkgew0KPisgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4rICAgIH0NCj4rDQo+ICAgICBncm91cCA9IHZmaW9fZ2V0X2dyb3VwKGdy
b3VwaWQsIGFzLCBlcnJwKTsNCj4gICAgIGlmICghZ3JvdXApIHsNCj4gICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZk
LmMNCj5pbmRleCA4NzNjOTE5ZTMxOWMuLmQzNGRjODgyMzFlYyAxMDA2NDQNCj4tLS0gYS9ody92
ZmlvL2lvbW11ZmQuYw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTM4NCw2ICszODQs
NyBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXIgKm5hbWUsDQo+
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4gICAgIGNv
bnN0IFZGSU9JT01NVUNsYXNzICppb21tdWZkX3Zpb2MgPQ0KPg0KPlZGSU9fSU9NTVVfQ0xBU1Mo
b2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklPX0lPTU1VX0lPTU1VRg0KPkQpKTsNCj4rICAg
IEhvc3RJT01NVURldmljZSAqaGlvZCA9IHZiYXNlZGV2LT5oaW9kOw0KDQpTYW1lIGhlcmUuDQoN
Cj4NCj4gICAgIGlmICh2YmFzZWRldi0+ZmQgPCAwKSB7DQo+ICAgICAgICAgZGV2ZmQgPSBpb21t
dWZkX2NkZXZfZ2V0ZmQodmJhc2VkZXYtPnN5c2ZzZGV2LCBlcnJwKTsNCj5AQCAtNDAxLDYgKzQw
MiwxMSBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXINCj4qbmFt
ZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+DQo+ICAgICBzcGFjZSA9IHZmaW9fZ2V0X2FkZHJl
c3Nfc3BhY2UoYXMpOw0KPg0KPisgICAgaWYgKGhpb2QgJiYNCj4rICAgICAgICAhSE9TVF9JT01N
VV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpLT5yZWFsaXplKGhpb2QsIHZiYXNlZGV2LA0KPmVycnAp
KSB7DQo+KyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPisgICAgfQ0KPisNCj4gICAgIC8qIHRyeSB0
byBhdHRhY2ggdG8gYW4gZXhpc3RpbmcgY29udGFpbmVyIGluIHRoaXMgc3BhY2UgKi8NCj4gICAg
IFFMSVNUX0ZPUkVBQ0goYmNvbnRhaW5lciwgJnNwYWNlLT5jb250YWluZXJzLCBuZXh0KSB7DQo+
ICAgICAgICAgY29udGFpbmVyID0gY29udGFpbmVyX29mKGJjb250YWluZXIsIFZGSU9JT01NVUZE
Q29udGFpbmVyLA0KPmJjb250YWluZXIpOw0KPkBAIC03MjIsNiArNzI4LDcgQEAgc3RhdGljIGJv
b2wNCj5oaW9kX2lvbW11ZmRfdmZpb19yZWFsaXplKEhvc3RJT01NVURldmljZSAqaGlvZCwgdm9p
ZCAqb3BhcXVlLA0KPg0KPiAgICAgaGlvZC0+bmFtZSA9IGdfc3RyZHVwKHZkZXYtPm5hbWUpOw0K
PiAgICAgY2Fwcy0+dHlwZSA9IHR5cGU7DQo+KyAgICBjYXBzLT5od19jYXBzID0gaHdfY2FwczsN
Cj4NCj4gICAgIHJldHVybiB0cnVlOw0KPiB9DQo+LS0NCj4yLjE3LjINCg0K

