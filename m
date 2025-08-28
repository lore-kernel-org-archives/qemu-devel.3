Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6501C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZK4-0000ZK-Tp; Thu, 28 Aug 2025 05:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urZK3-0000Yo-En
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:53:35 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urZK1-0001mx-68
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756374813; x=1787910813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VPK8V0rtGvnMMhKvAlX/tgW64Uax8rTQb1Yk6rrbDXA=;
 b=hNPXAsNoX63UpnRHafPofRf+1vrtCy97d+UcDir0upnAsoeMNNBBEwGz
 zDVbZhQ4Y5HnTH79eBr/zc1icl4nWm1GZ2FgHGY9IplSbjyXOKbHhOt6V
 ocW5RxpYPhwN9C3sm6s8MO1C+oCnQZCpJYSm66Q92Hg17rFctMNaHBx51
 NySLFLqE6f76ghDQ+H0D/AbP1hLf8wE2VX5qJD/bP34SitrKF1IY6zoF8
 yci49fL6RsWewZZ4SNC05bcRzSEUsWRLp2ikXR99TbyOQc9kCTFWVIu4q
 lY1IGCqY2Ky263gZWQ8n5h/veYHrZntdcIBTrsmSsvGsAKDunSBmVI1hH A==;
X-CSE-ConnectionGUID: +Gmx59joRLOa82m2dEJmmg==
X-CSE-MsgGUID: a/w0AVlESdS1b9eAsTbIzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69734488"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69734488"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:53:29 -0700
X-CSE-ConnectionGUID: StcGB/wLT2ugZ6UbXqGYaQ==
X-CSE-MsgGUID: oDHj8eK1SWKNhdOfw8DL2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="170466275"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:53:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:53:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 02:53:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsOl1bVAfrLj7Gi46MZ2Bxatb/UIJcay66b4HJIM5EvRTuXRCri3gm7rOY+axYW6V8QEJ8197K2FkWkgLKUCdypC8oOB/sw630Bx4SewYYBsDKjCd/NCzGdyrV1DF+9In4RK0AiN1nLaGGqWYH71w6ktwX7yhJ6uKPmzuU8RoDSb5hLCZNyL2yKgdwCWqgdAMOAQ33dzTH04nN9CRh54+tqk3fXPjTf6ppa7Ei5NUOG1yWG5ROsi5RpCTz5TyTnLd1+z+M0eVYDfpx5jncwkUt/zVFJ3XGZweRzBu2icrT+xSxrGWBaSYMNUQYD7zB2IpsL2EO8oLDLbM3WXB+GlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPK8V0rtGvnMMhKvAlX/tgW64Uax8rTQb1Yk6rrbDXA=;
 b=pR8ys4up+Af+wi8HdUE9XzGZVQmlAH9Jh+ucUY9DEWAWD6prW2ITbZpJLBIR0kLKQAO8ww8XZxo3f1qaP7GLbK6UcW8Py5dW3vjwmY+st+CxqcfwQ/pmpjjcO3cxMJiDXgCQ7SlLkeh/C5JpfGrBMgGLuYbldRQVKWmjiDKr6Cl/Nv/a7DbT1o48D6YKWnNQh69JthFWhT/6otafPlHT32n2X0NI/54McjdndcHh1r1jUOZ4ZuLjATVhXavFxyAOWh2AANvLEB0GkqjCYfKPkoGER9RXe6AFOYbqk+pKfaCIh5rzSHxJtimtnj8W0XbGGavbOrszLCXUaPuE0U0d+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 09:53:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 09:53:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHcEy/cU7h1NYrEmkakGdO2tRUzdbR2aqYAgAFwmOA=
Date: Thu, 28 Aug 2025 09:53:21 +0000
Message-ID: <IA3PR11MB9136E928181D1B95F5AD39AB923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
In-Reply-To: <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: 46f52fe3-1a1e-413a-c3b5-08dde618b8fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WDh0amV6c0Yrb1UvZStyUGNORk9ZQnVIb2p1S1o3VjZReWw4azI1bG5Uc2tl?=
 =?utf-8?B?UCtQeW5GYTdDVEZ6S2wvQnMrckJPZDhEVjRMcEN4dTZ2UDYwMXBUNjE3SDFU?=
 =?utf-8?B?MDdlZ215eFdVSWpXNEQ3VFBYWGRlcTUwd0NuRnVnTDJjWjJOR3g0bTJpRzg0?=
 =?utf-8?B?ZnQvZ2gwOXFHYWplYkZSd2JORHp4SUd5SHdOQzZBVHd3VVVKckd6NkNkVld4?=
 =?utf-8?B?MzFVZERBd2t1ekJpU2lpNFBvNlpCb3lyM0loOWhHQmVVMWRLRm5zNS9hcjBq?=
 =?utf-8?B?cFR3bzVhYzErcG5GMkVhT2NmNjJPSFVXTGhEU2VoNEhKZmFnWW5OSWRjM2NT?=
 =?utf-8?B?UktmdytnRkgwQm1kZHZMem9JdzZnOXFSUTc0YjdkN1pmQXJyWU5jTTY3K2lQ?=
 =?utf-8?B?aUJ0WUQ4R29aTXV5WVFUUThhTHFwM09HcmFNcThLbXcyTTgxRWJxQURSNnpl?=
 =?utf-8?B?UFQrN0FkWkFJbTRiOEV6RE9wOXZ6R21kNHBVWXI2b0hCSlZVRFljdHJ0c0pR?=
 =?utf-8?B?d2RHbkJ0T0lOTHVIV3pOWXVhb3MveGRIR0R1MFRKMzUvQXVFN1JsemVxd3VO?=
 =?utf-8?B?REVGSDlXTythYithV25WL3U1RmtxcHpmaGxINk9qQ2pOSlB6S2pTUjc3SHdT?=
 =?utf-8?B?dTI1OFc4Ny9JRG9WanV0VzBnWEhveWpOamRZZlRiK0FBdStpaTlSemZVamtW?=
 =?utf-8?B?ODNhYVJMN1oyRHliQ2MxT3lMTC9MNExxdkNxOXdNbVJCYUFmNVBmNmJvV1BF?=
 =?utf-8?B?WDdmUlVxTllLN0N6SXZDOU4xVUhTd1k0WWFCNnRUM1JhZWJPOWJ1R2U0ZlFy?=
 =?utf-8?B?WHBqQTQxRDI0NU1JaHlNQ3NTaWdjc1dJRWxhUTVxL2c5dGMrUm4rdkFtRlow?=
 =?utf-8?B?UWY0bmpnbzRoblZBNlBxeGdmcDJQRUtVWm56aUlpTHRCRGZnWWFINWhMWSsr?=
 =?utf-8?B?eVpOTm80Z1VDSEFNQkNCQnI4TCtBRks5MHgrVDVybXMvc2NRZ0dVUEk3SUlx?=
 =?utf-8?B?eHVPT1pIV0hJUFRzeUpUck9NeUFqMHlydnJBUTdTSFpsWWpGZVVrcmkvUlFl?=
 =?utf-8?B?UzhqNnA2YkdkZGVWWWVYdjEvZW5iN2xSNzNKUHJxaG9nTFBDQVdjdVplTkFS?=
 =?utf-8?B?eVdBQTdmMDkrR2phNXFKckF2SGViN3BCSS91bVhaNnJQSEhrVjFjYXlNcVlm?=
 =?utf-8?B?TlU3YS9ta1NvczNWbUwyNjJJSUJDYTZTRkdlNzIrUGpuYWNsclNrdDk4NVdy?=
 =?utf-8?B?THd3eE4xNmR1N21hZnYxS01QRE1hMTdXRno3VlJEbWl0dHduS1B6Y2t3azNj?=
 =?utf-8?B?dzZNZkFVYjdxenNNY05JdkpwdzN6d0ZZZjIrWWlzS1BSemlBdEpSSjVrMzFx?=
 =?utf-8?B?YkNjMWw0OTBZSmNhSTZBN1VzVGNVZ21udkprMExtcEdRV21PQUtsR1M3ek5m?=
 =?utf-8?B?UUNHcStkdndYcjgrVU5LZ1B2aUJHTDBBc3RZM0xSN096dzNhUlFrWjRYV1Nt?=
 =?utf-8?B?OEN0SzZ0QkVYekVVMlNJMUV6Ujk3OHpQTmVsZVdZb3VBVlhiZ2Z5eFFIR2VR?=
 =?utf-8?B?ZWRiVVRSNlQ4TWs2OUMwTU4wSjBYTXZ1SnY4MTRzVnIvQnFRSGtmU1hWLzZZ?=
 =?utf-8?B?aERNazVhUDIveVp5RGVHVHFwc0dyanFWMDhnUXRWNHU5WVBaTUU0S1BFOHdu?=
 =?utf-8?B?ZGhjakwycm9Mek1aZzVHNUVDblB4d0dmcGRFUkladmFXQ2k4SWQvb3pFNjdz?=
 =?utf-8?B?b1o4dFcxaDRQRGppamU4L2YrODV1L2FvZTBrSVNvYkVMQ2IrS3I5VXdHMmRv?=
 =?utf-8?B?ZkYrNGFyY2U2bjBpSjFYelpQUEVWcWJhYWFJazdPRmR4RXBTUFI2Nkx4RHlq?=
 =?utf-8?B?MndxY0hFMTZSNEdzNGJoUStoMmY4V3dINm81N0hqYnpCMDdGcUpCTnNVN1hj?=
 =?utf-8?B?dndjMHdLMXRFcW1ibWViTHpOZEs5ZERGUFh6ckV6bkFsVk92YzE4V1krK3VH?=
 =?utf-8?B?aXJNZ21DWWZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjN4TWk1UU9pR2YwN2FLTkJpYmZVeXlWeFBxOXAvamQzdS80djNtcVBEZnBR?=
 =?utf-8?B?RUhpRzdHenNuTG1yTHNoZlFQSXU4eEh0S3pROWk2VzhZSkt2RE50ZnRtSlY4?=
 =?utf-8?B?VUkrcit4M09qc2dONDNybnBaTzRHeWlRcGxyUHU4a3d4aVJ5ZmV1azZVK3dM?=
 =?utf-8?B?MEJWbTFhMW0waFAzMmpxb0xWaXNNc2x1eVJWQWxabVpxU2lwWkFMZytQVytK?=
 =?utf-8?B?d0oySzg4TjNOVUlBVGU1WEEzWWhlVm9xeGJEVVBoZTR2dXZsa29WYXdlWSt6?=
 =?utf-8?B?TGViU0FZL0NzSi9tZHdJRzEycWVXVmoxQ2hEZ0xmR2JqeFNhVmNrNlh4Ynl0?=
 =?utf-8?B?TW5xUkxEYTlxNzZJYkpoVTE0V3hGaTVnQTNZZnoyb2NXZ2hKKyt5aWxOWkYw?=
 =?utf-8?B?d2lQbVdJS21YREJnWjQwSklRMW13T0tNZ0tveXF5SS9ha0RidS92UjJuUWF4?=
 =?utf-8?B?am1Gd3RqemhqVnFUS2V0L0diUmFHMVF6TFJUaEl6QWxRZ2diY3ZjWVF6S01M?=
 =?utf-8?B?dTYwOWVaRDNlajdyblRvUXhPVE1ibHQ1cUxjb0Ftc2FKNENMSmV5bVlYVXcx?=
 =?utf-8?B?VEFlcTBwaXBNeFlraGZIemhsR3JQaXhwc2FNTW5mVFZFTG13bHpiTmtiM3hJ?=
 =?utf-8?B?c2p3ZjhwYXhReDVGNk1CQ1lkUWFTTnVLZUtlc2NsL2ovNUVjY0g4M2JCcDlP?=
 =?utf-8?B?dWZjNnBtcmVoY25DUkxzdDdKOEFQSjNmc1p4Y29nRGxpZk9ZenJ1SXQ5M3pQ?=
 =?utf-8?B?eU1GVUo2MmJxcDhIc0Q4ZzRCVGI4MUEvVjJiUlFpSndpOURoWEFoOHdpVUVT?=
 =?utf-8?B?T1Y5bFZ6dmE4VDJyMW4vUzJwVW9BSmtlOUVrQ3VmTVpNNnhjMXVVdlBnMmpY?=
 =?utf-8?B?OG1rRmRVY1B6cmlLWCs2bHNhK1B0MFJwZjFQRGNMR3BxaG9sZC9YMHQwVTM2?=
 =?utf-8?B?NGtKa0xKZUR1bnFhMEpGaFZTckVHL2xEa3JxT29CQTRUaUdNOWNLM3BiU2Vv?=
 =?utf-8?B?WTFZcHZEcFprOTg3YkNpRld5TkpjMG5xY0FVQStYeTZoQ2JuTmcyMDJVT0w1?=
 =?utf-8?B?dFQrUjNRYythNTMyVmdnSzVpZVMxT0RRZ3dmRFJiUStFSWNKT0cwczZ2MWJB?=
 =?utf-8?B?ZXlGY0RCRkFjTlI5aHN3VTdQRVZCS3ZKMmg2V3NjZEM2ZHB6cE1VeGxaODhH?=
 =?utf-8?B?RlpNc3JJYTgzejZlcHMzdG9Mc3pJeGhkS1hUbXNtQjIvS2lZanEralhCWkRQ?=
 =?utf-8?B?M3RWdkxzQ05ZWHlhSzNOeWcvZG5FOXUwWjlJdnI2bGs2WXVoSDFsNmtKRG40?=
 =?utf-8?B?SmVRY0ZtV1ZubU1zdGhtT2dteEJ3Q2lJMGpDcE42ODRESWtydW04YktZbUo2?=
 =?utf-8?B?QnZmckFvVWVDelRDcCtuelhrTWlsTFdPcWJvVXpGaDg1akhYa3VtTEpqc2Fw?=
 =?utf-8?B?UmVlM3duYlIrNGlEU2RKQ3FaV2hzNEZwUHkrODBNZEFuandGZFFiMkcvYU5w?=
 =?utf-8?B?QUxuMmdoYm5CYUxtdUVRbFNybVJTQ0VXck5NdXZxYngxNHRlUGc5c2JNNk8z?=
 =?utf-8?B?NlVOS3RDM2d0cjJna0tJWHU4SmluS0FpS29ENzdXcFRRdWhEeFlhSlFMejds?=
 =?utf-8?B?VjBJNGpBT21xc3hESUUvRytLb3JjZTRDY3dXalpvem5vRkJkOGowNzBQcHJH?=
 =?utf-8?B?Vm9saGs2dCs5UVY3TGswN1J3QWE2R2Q4T2ZjbVppdFlacml1RVFKWEJZMmZu?=
 =?utf-8?B?b21nemRqOGVHL3MzaFBYRFFPSWNFSmVIMURPSmFXVGMvT2U2NlcyU1lmVlBQ?=
 =?utf-8?B?L2tIZEpidEFGUHpMVnhIZE5uVnI2Ymlkdjg4LzlQNnZnbnVHZ1JnNFBMQXow?=
 =?utf-8?B?NzZ3bDhJanZ2bjI5c0FMQVY4SHZleU0vWjh5d3htckwrZENtY2lGSlQrS2pz?=
 =?utf-8?B?cjEzTWczTjhVUUZLbGd0TUFuTjh1TDd3dmp2M0ZwY25YT3lYS1p3ZHR2eUZq?=
 =?utf-8?B?VlBkaXNUSmtnNkIwWjVVZ0dGUHFwelJqRTJTTGR0ekpNdnFpclY0eGh6UWdr?=
 =?utf-8?B?UXdacjFqV3llUlpvMlhFUktsSkxENEZhcFdMTndadU5GVDh3SDNucnRvVjg4?=
 =?utf-8?Q?DhjLNyc/DfCw1n9ad0nIJVpfW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f52fe3-1a1e-413a-c3b5-08dde618b8fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 09:53:21.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CDtwe5PuZsumeZXPPgCYM/fODXcY+PKZ/GnKK6P1UMVuHE1/ZqfE2GdFUbemWcwFOOHlqLeMf4PiPyUAXFtT1sRDJp+w5hJieL3COOkk3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDUvMjFd
IHZmaW8vaW9tbXVmZDogRm9yY2UgY3JlYXRpbmcgbmVzdGVkIHBhcmVudA0KPmRvbWFpbg0KPg0K
PkhpIFpoZW56aG9uZywNCj4NCj5PbiA4LzIyLzI1IDg6NDAgQU0sIFpoZW56aG9uZyBEdWFuIHdy
b3RlOg0KPj4gQ2FsbCBwY2lfZGV2aWNlX2dldF92aW9tbXVfY2FwKCkgdG8gZ2V0IGlmIHZJT01N
VSBzdXBwb3J0cw0KPlZJT01NVV9DQVBfSFdfTkVTVEVELA0KPj4gaWYgeWVzLCBjcmVhdGUgbmVz
dGVkIHBhcmVudCBkb21haW4gd2hpY2ggY291bGQgYmUgcmV1c2VkIGJ5IHZJT01NVSB0bw0KPmNy
ZWF0ZQ0KPj4gbmVzdGVkIGRvbWFpbi4NCj4+DQo+PiBJbnRyb2R1Y2UgaGVscGVyIHZmaW9fZGV2
aWNlX3Zpb21tdV9nZXRfbmVzdGVkIHRvIGZhY2lsaXRhdGUgdGhpcw0KPj4gaW1wbGVtZW50YXRp
b24uDQo+Pg0KPj4gSXQgaXMgc2FmZSBiZWNhdXNlIGV2ZW4gaWYgVklPTU1VX0NBUF9IV19ORVNU
RUQgaXMgcmV0dXJuZWQsIHMtPmZsdHMgaXMNCj4+IGZvcmJpZGRlbiBhbmQgVkZJTyBkZXZpY2Ug
ZmFpbHMgaW4gc2V0X2lvbW11X2RldmljZSgpIGNhbGwsIHVudGlsIHdlIHN1cHBvcnQNCj4+IHBh
c3N0aHJvdWdoIGRldmljZSB3aXRoIHgtZmx0cz1vbi4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IE5p
Y29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3Zm
aW8tZGV2aWNlLmggfCAgMiArKw0KPj4gIGh3L3ZmaW8vZGV2aWNlLmMgICAgICAgICAgICAgIHwg
MTIgKysrKysrKysrKysrDQo+PiAgaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgfCAgOCAr
KysrKysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaCBiL2luY2x1ZGUvaHcvdmZp
by92ZmlvLWRldmljZS5oDQo+PiBpbmRleCA2ZTRkNWNjZGFjLi5lY2Q4MmMxNmM3IDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmgNCj4+ICsrKyBiL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWRldmljZS5oDQo+PiBAQCAtMjU3LDYgKzI1Nyw4IEBAIHZvaWQgdmZpb19k
ZXZpY2VfcHJlcGFyZShWRklPRGV2aWNlICp2YmFzZWRldiwNCj5WRklPQ29udGFpbmVyQmFzZSAq
YmNvbnRhaW5lciwNCj4+DQo+PiAgdm9pZCB2ZmlvX2RldmljZV91bnByZXBhcmUoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYpOw0KPj4NCj4+ICtib29sIHZmaW9fZGV2aWNlX3Zpb21tdV9nZXRfbmVzdGVk
KFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj5JIHdvdWxkIHN1Z2dlc3QgdmZpb19kZXZpY2Vfdmlv
bW11X2hhc19mZWF0dXJlX2h3X25lc3RlZCBvciBzb21ldGhpbmcNCj5hbGlrZQ0KPmdldCB1c3Vh
bGx5IG1lYW5zIHRvdSB0YWtlIGEgcmVmIGNvdW50IGFzc29jaWF0ZWQgd2l0aCBhIHB1dA0KDQpT
dXJlLg0KDQo+PiArDQo+PiAgaW50IHZmaW9fZGV2aWNlX2dldF9yZWdpb25faW5mbyhWRklPRGV2
aWNlICp2YmFzZWRldiwgaW50IGluZGV4LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZmaW9fcmVnaW9uX2luZm8gKippbmZvKTsNCj4+ICBpbnQgdmZpb19kZXZp
Y2VfZ2V0X3JlZ2lvbl9pbmZvX3R5cGUoVkZJT0RldmljZSAqdmJhc2VkZXYsIHVpbnQzMl90DQo+
dHlwZSwNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2RldmljZS5jIGIvaHcvdmZpby9kZXZpY2Uu
Yw0KPj4gaW5kZXggMDhmMTJhYzMxZi4uM2VlYjcxYmQ1MSAxMDA2NDQNCj4+IC0tLSBhL2h3L3Zm
aW8vZGV2aWNlLmMNCj4+ICsrKyBiL2h3L3ZmaW8vZGV2aWNlLmMNCj4+IEBAIC0yMyw2ICsyMyw3
IEBADQo+Pg0KPj4gICNpbmNsdWRlICJody92ZmlvL3ZmaW8tZGV2aWNlLmgiDQo+PiAgI2luY2x1
ZGUgImh3L3ZmaW8vcGNpLmgiDQo+PiArI2luY2x1ZGUgImh3L2lvbW11LmgiDQo+PiAgI2luY2x1
ZGUgImh3L2h3LmgiDQo+PiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+PiAgI2luY2x1ZGUgInFhcGkv
ZXJyb3IuaCINCj4+IEBAIC01MDQsNiArNTA1LDE3IEBAIHZvaWQgdmZpb19kZXZpY2VfdW5wcmVw
YXJlKFZGSU9EZXZpY2UNCj4qdmJhc2VkZXYpDQo+PiAgICAgIHZiYXNlZGV2LT5iY29udGFpbmVy
ID0gTlVMTDsNCj4+ICB9DQo+Pg0KPj4gK2Jvb2wgdmZpb19kZXZpY2VfdmlvbW11X2dldF9uZXN0
ZWQoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+PiArew0KPj4gKyAgICBWRklPUENJRGV2aWNlICp2
ZGV2ID0gdmZpb19wY2lfZnJvbV92ZmlvX2RldmljZSh2YmFzZWRldik7DQo+PiArDQo+PiArICAg
IGlmICh2ZGV2KSB7DQo+PiArICAgICAgICByZXR1cm4gISEocGNpX2RldmljZV9nZXRfdmlvbW11
X2NhcCgmdmRldi0+cGRldikgJg0KPj4gKyAgICAgICAgICAgICAgICAgIFZJT01NVV9DQVBfSFdf
TkVTVEVEKTsNCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0K
Pj4gIC8qDQo+PiAgICogVHJhZGl0aW9uYWwgaW9jdGwoKSBiYXNlZCBpbw0KPj4gICAqLw0KPj4g
ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGlu
ZGV4IDhjMjcyMjJmNzUuLmU1MDNjMjMyZTEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11
ZmQuYw0KPj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0zNzksNiArMzc5LDE0IEBA
IHN0YXRpYyBib29sDQo+aW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2aWNlICp2
YmFzZWRldiwNCj4+ICAgICAgICAgIGZsYWdzID0gSU9NTVVfSFdQVF9BTExPQ19ESVJUWV9UUkFD
S0lORzsNCj4+ICAgICAgfQ0KPj4NCj4+ICsgICAgLyoNCj4+ICsgICAgICogSWYgdklPTU1VIHN1
cHBvcnRzIHN0YWdlLTEgdHJhbnNsYXRpb24sIGZvcmNlIHRvIGNyZWF0ZSBuZXN0ZWQNCj5wYXJl
bnQNCj5JIHdvdWxkIHJhdGhlciBub3QgdXNlIGFub3RoZXIgdGVybWlub2xvZ3kgaGVyZS4gWW91
IHByZXZpb3VzbHkgdXNlZA0KPmh3X25lc3RlZCwgSSB0aGluayB0aGF0J3MgYmV0dGVyLiBBbHNv
IGJlYXIgaW4gbWluZCB0aGF0IHNtbXUgc3VwcG9ydHMNCj5TMSwgUzIgYW5kIFMxK1MyIGluIGVt
dWxhdGVkIGNvZGUuDQoNCldoYXQgYWJvdXQgJ25lc3RpbmcgcGFyZW50JyB0byBtYXRjaCBrZXJu
ZWwgc2lkZSB0ZXJtaW5vbG9neSwgcGVyIE5pY29saW4ncyBzdWdnZXN0aW9uOg0KDQpJbiBrZXJu
ZWwga2RvYy91QVBJLCB3ZSB1c2U6DQogLSAibmVzdGluZyBwYXJlbnQiIGZvciBzdGFnZS0yIG9i
amVjdA0KIC0gIm5lc3RlZCBod3B0IiwgIm5lc3RlZCBkb21haW4iIGZvciBzdGFnZS0xIG9iamVj
dA0KDQpUaGFua3MNClpoZW56aG9uZw0KPg0KPlRoYW5rcw0KPg0KPkVyaWMNCj4+ICsgICAgICog
ZG9tYWluIHdoaWNoIGNvdWxkIGJlIHJldXNlZCBieSB2SU9NTVUgdG8gY3JlYXRlIG5lc3RlZA0K
PmRvbWFpbi4NCj4+ICsgICAgICovDQo+PiArICAgIGlmICh2ZmlvX2RldmljZV92aW9tbXVfZ2V0
X25lc3RlZCh2YmFzZWRldikpIHsNCj4+ICsgICAgICAgIGZsYWdzIHw9IElPTU1VX0hXUFRfQUxM
T0NfTkVTVF9QQVJFTlQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgaWYgKGNwcl9pc19pbmNv
bWluZygpKSB7DQo+PiAgICAgICAgICBod3B0X2lkID0gdmJhc2VkZXYtPmNwci5od3B0X2lkOw0K
Pj4gICAgICAgICAgZ290byBza2lwX2FsbG9jOw0KDQo=

