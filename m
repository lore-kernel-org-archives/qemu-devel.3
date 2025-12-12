Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D13D43366
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 02:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTsdv-0006IT-Dm; Thu, 11 Dec 2025 21:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTsds-0006I3-5U
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:12:24 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTsdo-000061-Ic
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765505540; x=1797041540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NsdfJT+MPmIIu3cndN4BVq//FmLiexo/7QIFrgGjSm8=;
 b=Hddjv4PHDrhjpnUmmgG+HV8sGnClG0ZjxhFMqhxKH9R8Gz6/F+BRPE+V
 tBnyPGCbyYuofm3uXf8nXCDgiBf1DQfv8NwLou9RjEuxytgDID5SjVOcV
 dfRpHjTlUTfddM4F/VpQA1rnDKEyU9F/yfAsRjw95DuWgrztAPt0DBmln
 nF7k1xbGoHbAndHp1ArRoIpxCglUG7WETMfwNtuRGyQNfoNi5dxVtQx9n
 /Y5tv7mX6QwRnI2jwES+9cx99XcLk9O7rPiK0NG5f33MkrMmQUEHmR/b+
 pkbMm4r3vwz0/A76slyWH/De5M315Qts3xsVAmFmygEbmz1mjcLWi2Gbl w==;
X-CSE-ConnectionGUID: S95+6C6lQ9awofPbhVqqRA==
X-CSE-MsgGUID: nKAwqSYKQiuSC4A4QuOIzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="84904914"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="84904914"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 18:12:17 -0800
X-CSE-ConnectionGUID: n+PYk4q3Qmm4DniBy3AlUQ==
X-CSE-MsgGUID: ULrRSwVVTPCkER5ivv7wZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="228018283"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 18:12:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:12:11 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 18:12:11 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:12:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQD7vaQIMkNkiYx3ykFluzObfpUkNthjn0JVG80oEvNS6gmamWeLkt2Ivao7aO/V3zm/eYiXxFUpROQknGkKjvgZL8wPM3tW9Rl+bUqx5aL989jn3SabMCAQcThQCPjNyhD4NhRqQiwjcfM60beNPNHEmweC0qsB89qSF8zR1oUzHjcv+28mthRyFaOb6n6PXisO0zqJAarplsNwta1VMOLvdQaBik28xvQ+tROcRj/5Nt0nYYjPfmwvtvA1C1F3UYCXelutNb3Fi3N3pHToqSneTnwcFGAVCy6/yFDiwPyCVbjTvXdLCNrqL7jLNn6uiH64BNAhGDy3vlVTdq1p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsdfJT+MPmIIu3cndN4BVq//FmLiexo/7QIFrgGjSm8=;
 b=lFzrst3FjP1e1rtqCsgC9IkVTYkPhryTn+SKRh4P1qJ3FpD25Rf7AqFKpkxkqzBmUeG8JW4CgafHiJA+D3PKuvEzoinygiHkkLzkveBCmtt1Q135z1DxbwcDrsukhBGpav6GXT+YD9h4+uRoK42D+dwx864HPkw+A7aKSaCgP2bw8+RjC1fe3V2Ff0W8ra9YHcC54kyuLeF3amj23KwFi/s0bZCcH67vYKJWa9HwkeLSdX2hNzkfcvSD+Y2xWrmlrY7eIwsLAMB+uhDkKZrbIJbNLRCP2oNKJakZ43W7itABTXNA0eB0C5yRY9Y7GglKkoiXzx9/0jgcJWF1BRV6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW3PR11MB4700.namprd11.prod.outlook.com (2603:10b6:303:2d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 02:12:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 02:12:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Thread-Topic: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Thread-Index: AQHcV6YUvl2VrinOX0+Zg5ikN/IKE7UbSWMAgADSgeCAAU2XQA==
Date: Fri, 12 Dec 2025 02:12:09 +0000
Message-ID: <IA3PR11MB913644ED17D8B3698A1CF39992AEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-14-zhenzhong.duan@intel.com>
 <52703428-96c5-4b18-b7e8-ccc3c38e2cd2@redhat.com>
 <IA3PR11MB9136F90FE5C93257ABB0772392A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136F90FE5C93257ABB0772392A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jgg@nvidia.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW3PR11MB4700:EE_
x-ms-office365-filtering-correlation-id: aaa031d1-b781-4483-0fcf-08de3923db13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YTFIMUpzc0NaQjBhbldmT0tLdmtudUh0L3hNT3BnTUZoaUQrMXFGaXh1Y3U5?=
 =?utf-8?B?WDhVeGMrWnBMY0oySXpIMXNLRHg3YnJvZU5vd3hLQWpXRzgvUDgrdXNvSXJL?=
 =?utf-8?B?QTNpekFKQzBIaTZxZmpOSndzZjRybm5TQ2dWdmg3eXJJbm5aVlIvUlphVC9W?=
 =?utf-8?B?RVgzVll6ZjZvTms2ek1GcjhxOVNYNHlJUlVPbXlYbXMwVTFsbEorYzFDaUU1?=
 =?utf-8?B?SzdOU1VWU2crTXhUVG5SQkVPb2JzYzdKdEpqbnZzQ0xkTXUyN29NYm9NRWVm?=
 =?utf-8?B?R1BlOG9xdHEzenp1a05ad1VIdnVKNWU5K0wySktITnJ0aGpiOGdEdjdnMG9l?=
 =?utf-8?B?bktKeEVobWJjWHRlTStZejVmS09NcmZjUjlzdWxGU0xEaHZiWVdzYk9lS0tX?=
 =?utf-8?B?RC9oUDM2Q2k4RGhhYWFqQngvdmI2bnEydUJoWWF1ek00UFQ3WFRDL1NLZCtr?=
 =?utf-8?B?VGxDbE0vcm9PdzIvYVBLandBdmZaNWVBbUxsQm1XUlpjU09BOXpjTmx2ejFO?=
 =?utf-8?B?S2tsNSswOElDY1hseTNZWFQ5VnZVeVBGMndCczdwaHJ4OXlwa29ZVnJLbkcx?=
 =?utf-8?B?SGJwektsRlpTNkZRWXo4SUY1b2d2Q3pJMVJTZGxDTWNiYU1tcElRU2VnWUlo?=
 =?utf-8?B?cCtocHZqUVcxbHYwTXppNHRzcFZNdjNvOHRsK3JSRnR1NGNRUWlRbGpLY3NF?=
 =?utf-8?B?eGlxVkFWd0VORmUvOHhGR21YbE9tM0FIUjBwNjJVUTlTTldvbW1RK0F5U0Uz?=
 =?utf-8?B?S1VXenhuZytqVXdmT3k4dDJhenM2RmwxTDU1YjloWmhmdmRQT0gvdzBHdENh?=
 =?utf-8?B?YzUvc0VrNVdBZ29hL0U1NGN3V2FZVkxmVXNtalFxZzUzOEViQ1REVWhpMTFt?=
 =?utf-8?B?TkUwU21uYkU2NmpUamZZSXpKcmdRdklFeEVSZllJUXRQQU1meEVEcUdXTmFo?=
 =?utf-8?B?bzdYaVdTQ3U1S2xGazdzTGpWdUdIaTlRcnhYV0NBWkdnZXRmV1IyL2kycEcr?=
 =?utf-8?B?aytmbmtteUFiK2hmSlcvc1lQSzFUMkdlczVNSHoybC8wcFZoTHliL3c0bFl6?=
 =?utf-8?B?UGdwT3ErRUtnZmlKa0VpcmpiVGdLbG8vSkhKOVBXV3UzWVFJcW5YbCtja25S?=
 =?utf-8?B?RUVYVjJQRVhLb0JLaDV5cjZTYmlmd0NIYWphL0RQSzlUSUZiLzl1bHpwZkVq?=
 =?utf-8?B?MWhTS254OVlLR1BaWisxQ3RLaU9tU1hIemIrTmxkb0tNZWhKcTJ0UVcrUm1J?=
 =?utf-8?B?WXJFSWsxdkdSa2pMZmdDZHlkWDZyUndCaThIN2R4UFJDemJBVDN5U1p5dVJv?=
 =?utf-8?B?MHNxTGJ5QVdaUkhaNHBrSXFaNVBKSXE1bm9VQ25QaVF2UG12T0FPOWRTUE1U?=
 =?utf-8?B?SWNtMWxOaG14cG94WEhnMjFrMDJHMldwN1VTeFF1NDBZZHE0TGlCbS8wN3lo?=
 =?utf-8?B?L2pXOXRmRDFYZWR0aDEwTTVFN1pDV1BPNk1hZGtXMmFORkE4QjgyNXNsQ2pa?=
 =?utf-8?B?cWFQR01MTGtMeDZXa3ZsVE1pVHRMZFFKU3lxcVlKODFqTXZ6cHQySWs0RHVu?=
 =?utf-8?B?ZGUvTnVlVFpOOU55N3JQbEVkRm5sK0d5OGZscGFjcGlqZzJQRmpkaEhERmtI?=
 =?utf-8?B?OElxcGE5MngzVmRWSEhNMHJrWVpyVEV1VlozRjVxa29rNncyaGtnM3pQU3VP?=
 =?utf-8?B?eG0rTGpXSzJsczQyby9TemJtbzUzQXJRZk9DYllPY2pFOHFkN245b21BUTJ4?=
 =?utf-8?B?QlBXcDdMaG9iL0RjbFUyNm00WWdoeUZJUFN0QkpZTU85WnNwNG1FckhLemVE?=
 =?utf-8?B?Yi94dzRGREpBLzBJejI0TkVwd2J6VVVYT0ZkQWZzMTg2SGtTcGhmM0V6bmZi?=
 =?utf-8?B?NGFUUzhOT1Vvc0VvRS9uSGZHamVUSXlMK3NyeXBkcVNzV2E5aFlod2hjN041?=
 =?utf-8?B?YWoramxPbllDM3pySnAzYUdPREo1anpiaktOQVBQY1dqVkVUSEpPbzNZbnF3?=
 =?utf-8?B?VDhibmxjSnhVVmI1VHN1ajdBOFk0eHRyZWtYbzRRTkRPaXJROTdscHVnUjdI?=
 =?utf-8?Q?S3AB2f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWpING5aUnAyQzJ0eEkxb1VzdlkvU2VuSnBTRENCQjZhWlA1c2JiWHpCalAx?=
 =?utf-8?B?WmgrUTczL04zM0hwNTdHbEo0RXpFMmRUVVo4RnpSMG1vUWxLb2dCYmhhQjdL?=
 =?utf-8?B?NlB0TC9Tam5wcWpMa2toc1ZtbjNpelIwOGhiYWZicjJEZWpRdjNCcG1Pc2R2?=
 =?utf-8?B?M00vbFI5ZHBKU1dibVpOSWh1b3RpQ0NLeUw5OSs4enhlQ2pFNmI2Y1RGSWpn?=
 =?utf-8?B?cE9QMys1dTAvdWlsNExFa0tPUDlSQjVPOHV3QjBnczJ6RWxGSk9LRVFOY2Ez?=
 =?utf-8?B?VDNFeEFUSE5UR3JXMmJhWGRyZXhUYURrY2JHci9BYy9mTGJZQ1h0aTd6YW5C?=
 =?utf-8?B?aDRPbEJJdGx3V0hTcElWcFBUU2lEc3pYTTBWTlFFWjRUYmJvSHZIcVV4dWpI?=
 =?utf-8?B?TXJ3OUN6QXhQNURSUEdHdFFXWmQ3ZE9FQWtKZHk0UCthT0ZNcGl5OThVbURL?=
 =?utf-8?B?RjFIVklOQnMyQTBpNjUwTUIxOEh4T3FkSk1Tcnl5Ri9tbzhOLzF5OUo5VVpx?=
 =?utf-8?B?MWhyOVkxS3h6R2dQNktoTVdjYzVLN1RiN1pZOU5IbjFod2RsSVd3YmJoSVp4?=
 =?utf-8?B?QTNWcitneGJ0RjZnaFVHaGpTaFNXdEJleHh3YWlFUFoxbE1PNHhGQUdIcHZQ?=
 =?utf-8?B?TzVLcGI5cEgrWk1GMW5leDdZb29TVzFqYmdqOVdoUXRwVlpnWWdlRHVBUU9I?=
 =?utf-8?B?MFZGUUdqdVRja2crSkh4dEp3cjFKOGtDcEtXWE5lUkllN05CMEhnWFVWa3I1?=
 =?utf-8?B?ZWxneVpvK0trQWRiVU9OWXBKYzIwbVY0N1dLYkFKd0NBUjZ2dFE1dnY1RjJN?=
 =?utf-8?B?cjlKcXNJM0MvdW0zd2phRFZ1TWhBOHA2a3UzUjI5Sm02dUUxd2UyRHdDd3gx?=
 =?utf-8?B?aDRYWUtWVjBvU1NrdXFCdTk3a25YRjBZV1pvMmxNUVVmdVIzWkhlMnhxTXN6?=
 =?utf-8?B?Y1JSbmpzOXVWUmVQUHRPR0ordmVTK01hVVc3Q1VYTWZseHlMb2dYMmlDdjFh?=
 =?utf-8?B?bEhMOVVDTkhYckhNWll3Rm9aQ015RTFuQzdnTlpaNEgweXI1T0JGQkdQZGtj?=
 =?utf-8?B?MEEvZnhPMGdVd0x6czg1YTBmVmR2ZjE0T1dtUmduUEU3aFd6TzBMdWJVci9S?=
 =?utf-8?B?blFtZkx6OTVCaU1zZ1crekFNRkR1ODFDT0U1dkhaNFpJY1BNdDVWeUk5UU5v?=
 =?utf-8?B?UDFETEgwTERMdDZGQmRPUytqT3VtWjc1M0tqajI4RldQcEhGOStnbVBWM2V6?=
 =?utf-8?B?SGhZVTZEazB6dEFkQkEzbTh2cnVpdURVTDlYckU2K0p5RytNOHdWbW5mRVAy?=
 =?utf-8?B?dlZFK0pZb0g5RkZBdWNwKzQ0cVhnaDFlWGY5ak9uMjlGOXF4NTZPNnFKVXhk?=
 =?utf-8?B?Wk44SXIyYzJxaXJjS1Fna291a1Y3N09CU20zd1dPa3hXRkFqSS9wRnNqUm5x?=
 =?utf-8?B?c0R6aHE4cHdtNldLWUlQQS9JeUNTRThNbC9lUU5xek9LQUZzd2lPRjNNd1JS?=
 =?utf-8?B?Ykk1WWxVRHhnWmxnQngwckoybElyK2tXSGdqM1N6d2l0VjFMYzVHTE1GZElh?=
 =?utf-8?B?ZW5zZDZNSnIvT25QcXh2aUhGVFN4ZW1wS3BPWk00TmZYeld0aWFYR1pzMTl2?=
 =?utf-8?B?T2hGcFgwcy9YTE1YY1VqM0crMmxHRFZQbXFwTVRFSnh2b2hWUGFuYkIxVFRU?=
 =?utf-8?B?aGE2Ty9PRkFmcmdUcVNlQVJHNWVScWdOdSsyTXF0RDZ3TC83ZzhXNzBoTVZB?=
 =?utf-8?B?SVRTZ0tVc2JUZ09VUjhHVFV1WHlHM2YrV21yUjBuVENiN3hPZ28vU2pPa1RI?=
 =?utf-8?B?ZnUwcnVVWVlqMTRoMUg2Mmp0alNRenorc3gzL0xkdUMwdFlManhKMzAyWjk2?=
 =?utf-8?B?cU5VMmNNK2NTTnlzc0I2cmhzMnlSM2o1NWdyMlR6VFovQkFiVU5pT25GeGgw?=
 =?utf-8?B?aWNjbmtpZjdqSzNjWlBFMU8xY3hsNE9YNVVFeTl2a1pLc0U2TDVEWUFsVEt3?=
 =?utf-8?B?SlFZZkxUWm9tN1psbXduN0ZIZEJuaUhsVXJKTFR2Ri81RUplaUhOMWl0OU5p?=
 =?utf-8?B?bE1GZjFuN2lOREtiWnFlYmZGWGRuaVZTMmVIRWNwSmltd0FMdGs4WlVjcWZv?=
 =?utf-8?Q?LhtJLUrlpnJnk8U/CdUnJQ41M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa031d1-b781-4483-0fcf-08de3923db13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 02:12:09.4866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YuTD3NiTTb24WvKvyS+0PRTD3Y1ofC2M/TiO8Kf4PLjtWtZs/XGE5woHaCGFcbkqw3H6pajuFUyeRC67f1k/BGxXhX1JJavbp1Dq6zUTe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+ICtzdGF0aWMgdm9pZCB2dGRfZGVz
dHJveV9vbGRfZnNfaHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEDQo+KmlkZXYsDQo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2Fz
KQ0KPj4+ICt7DQo+Pj4gKyAgICBpZiAoIXZ0ZF9hcy0+ZnNfaHdwdCkgew0KPj4+ICsgICAgICAg
IHJldHVybjsNCj4+PiArICAgIH0NCj4+PiArICAgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGlk
ZXYtPmlvbW11ZmQsIHZ0ZF9hcy0+ZnNfaHdwdCk7DQo+Pj4gKyAgICB2dGRfYXMtPmZzX2h3cHQg
PSAwOw0KPj5pcyBpdCBhIHZhbGlkIGFzc3VtcHRpb24gYSB2YWxpZCBJRCBjYW5ub3QgYmUgbnVs
bD8gSXMgaXQgZG9jdW1lbnRlZA0KPj5zb21ld2hlcmU/DQo+DQo+SSBkaWRuJ3QgZmluZCBpdCBp
biB1QVBJIGRvYywgYnV0IGl0J3MgaGFyZCBjb2RlZCBpbiBrZXJuZWw6DQo+DQo+eGFfaW5pdF9m
bGFncygmaWN0eC0+b2JqZWN0cywgWEFfRkxBR1NfQUxMT0MxIHwgWEFfRkxBR1NfQUNDT1VOVCk7
DQo+DQo+SGkgQGphc293YW5nQHJlZGhhdC5jb20sIEBuaWNvbGluY0BudmlkaWEuY29tIGRvIHlv
dSBoYXZlIGEgZ3VpZGVsaW5lDQo+b24gdGhpcz8NCj5Db3VsZCBJIHRha2UgemVybyBpZCByZXNl
cnZlZD8NCg0KU29ycnksIHR5cG8gZXJyb3IsIEkgbWVhbnQgdG8gQEphc29uIEd1bnRob3JwZQ0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQo=

