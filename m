Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E75C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSgm-00058a-47; Mon, 27 May 2024 01:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sBSgc-00057Z-RV
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:14:19 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sBSga-00008Z-9R
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716786856; x=1748322856;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Fijbk9mOVQLgsy8DWwsZNQlkhBZkFZ1ZMZApXdVe3qo=;
 b=jIXKeidqIfKRoGo/bswdB426B2nMpI9LqGcMLxHKwjnMsBGQAfgVoBDX
 M6lmR0fqsFQLtqnE4Yh6/u4NIKgWp+7mGcu10gAylIyU2ZBQHM+9chiIk
 3bFGO1+UQhBJcJHdqTq09UrQydUqOMMr4aGubLKtTMCuPz+Ux6Jz+B3Qw
 6xiwS+tBP0Vpdcr6RI6nhby1CYp49fq31SBGqsBVzzACmyPN/a06SX9UU
 DnxrE6kjLtDzDHZGifhR8jDk2wZ0TRXXSA+e74l5NnHC3w/FeR7XZFya/
 aL0jRgA3jzgrFiK6aSFnU0mN/VqMg0DcO8bmfM4XcboLX7hfMVjKHsUZa Q==;
X-IronPort-AV: E=Sophos;i="6.08,191,1712613600"; d="scan'208";a="13381847"
X-MGA-submission: =?us-ascii?q?MDGBMio32DxDxWnox/kVfQC2C5PUTCmtd8dxVU?=
 =?us-ascii?q?unGwYUx4T1RW+JYmUd7flBjhd4uc2PM9yVoB5n5PS62jWMmzJQXjdKzY?=
 =?us-ascii?q?JCnjx3Q62zZm98h/AL65RXpvc+CV0s2xl6zX/sSgESW3Kt6Xg6ilvWMv?=
 =?us-ascii?q?1U4jLoFXZYWBQ4dTkpgyLVyQ=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 07:14:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUTa9t7USlK4+CyBxHK0DLXPcmd6vzv4OqfJl+H7HIN30l7uEie3n43aF1DQrX8aBikuRnqzMwCyTRy+FrG7gspuX8BsJH5p4J7zWoREqjRq2nEym3W188aFwgz910dzakiy2SxHoVwc8cnqPSvHMAFAIWaY3lifZuznXUfsTiWG6/IPSRs23OIuES5yxVJAzbaJwll7b6vc9tgupVzAjEzRFD0Z0k22V0Mzlo+PRi8+Z7EtYRfY6qWBMs58PSATKSGDzzBkL1J++nW1s+R+YrM2+bcm/V/jeKw0utGLOMJCPUNtP2cB/ygsx802hzd2avfhicBg04oRPDFxmV5bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fijbk9mOVQLgsy8DWwsZNQlkhBZkFZ1ZMZApXdVe3qo=;
 b=iiOXFVCjVy+zQvQHWWjsw526MIQoeDva4R8xG0O/c0+35jz8X1rRhO3DuetMt4O4Ni030CtI7sn0n4QclPy8UaFD7UDW81rUmLAHbM8OfmZDcFr/R0OvHEv39p9DxJi+JVRSuSoq1g9/Bl6pqSm1M45emkI4iUmG3xocloDhP7pHHdrBbDkLKQOnDkwlCU783vgFe0ONkpSXnSrC5W8PzAFmT5pns+948Zl8FcdHCHGsFMK22pODl/dS1UhTKcP/exNxvELXQvuMBcdLuThr6ExuC96VY3q+/qjs7kPTujKXc/6AzjGkUGA6+qfcU5IADCa/WQmzYN8L99SjOAXbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6983.eurprd07.prod.outlook.com (2603:10a6:10:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 05:14:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 05:14:09 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHarBETrJJqvHUXHEOluDilF7EbI7GmbEIAgAQERACAACCzAA==
Date: Mon, 27 May 2024 05:14:09 +0000
Message-ID: <eeffbeca-33c3-4a88-9cb8-23c8aa234186@eviden.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-16-zhenzhong.duan@intel.com>
 <f80e5a23-5006-4fd6-8bd4-60a114c316e8@eviden.com>
 <SJ0PR11MB6744454F40A7E7E56967E2F092F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744454F40A7E7E56967E2F092F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6983:EE_
x-ms-office365-filtering-correlation-id: 7d646b05-75d2-4805-82af-08dc7e0bd6de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?RWN4S1JLM1ZCbVQ4RnFSbVVvSWp1WklmbEFIUlFPYVl2R2lhcUVSd0JvYStX?=
 =?utf-8?B?ZGEvQ0pROWdDTzhPNDFWeFNXWXFNUkNVRHpwQVRVMDY3MnhTV0NYU3dKaGZG?=
 =?utf-8?B?ZjFGak9MSlBmdTNXMXNuU2tGUm9CRUNQNEJYRWdZSG82dTZhQnJ0MDVCalFK?=
 =?utf-8?B?S3B3eHdkMWI0V2FSRUo4V1F4Yk1UZCs1UHZvaUpLUGlUam51SjdqV3R4bkVk?=
 =?utf-8?B?TWRpbzhNM21BV3gzSnMvWUxmaVkvaktuS29HWWtDSC9CL2tMOXZNTCtsSnVO?=
 =?utf-8?B?QlJ5SFphYUtXMUFVWXVCa3gxckVkOXljRW92V29iQWZQUWhXemZjS3FwS2hp?=
 =?utf-8?B?bDdoUzhMZTJKb0pmb2ZRNXZBNzRoTGtGOFFMTlhYRE9OeFRQNEgrNUZseTJY?=
 =?utf-8?B?cUFHQkRQQ055bWtnaEIzM0dMNUljNzIvNkRKSGc4ZnZtVzdyK0JTU0ZUUkU3?=
 =?utf-8?B?S0FndWtWQXpWNnREeCtwVHI3V1pTSnd0b0o2aWxHR25IaWUzd2NHeWh4cnI1?=
 =?utf-8?B?RTUweUdzbjF1c3VVQ3UxQzBDVlN5TUhwVjNJMHVZQ2xxeEJ2OFVqMGxmV09N?=
 =?utf-8?B?K1owb21ZVGtkVEF1TjdTaVpqNGNDS1dnTDlPcFZwQmdBYXQzeXdIQUZwWEor?=
 =?utf-8?B?d2F3YVlHK0Q2K3hkT0xwL1lHb0NZZmg2MzM3MFhVUU1NSTM4Nm9EZXVQMTlm?=
 =?utf-8?B?am1KQWdSbWpXSTFybklTWWZIUmRvc3ZYSHdCRmpoNGZsa1k2ODE1dEJxajRq?=
 =?utf-8?B?V05HWFBvcXVFYTNTTTkvWFoyMGtVWW1RQUs1enErZEJoK1VSeVEvMVRPSUl5?=
 =?utf-8?B?SWE5R0l3M04rYnplYm5Lak1JRjFmczlxWnZ1ODQ0RGtzWDlIMFpQTUt3N0JG?=
 =?utf-8?B?YmY2Vzg4Q0NsdW0wMG9jSDJKTlUwSUNzczhCbFVDT1hlcVFDZUNxMy95TkVW?=
 =?utf-8?B?dGg3dzlPU1poVUxyb3pLTS96cVBpMVZuQy9ob2IxNEtQcU5XZWZ2MHhWSkIr?=
 =?utf-8?B?c3R4dmdlVG9ST1Vnc2ltd3c3OUNUMEtCbHl1emNOUjd5ZjlSdS9nakJsNlhk?=
 =?utf-8?B?bGlZRTVsclZoVEdWTDlJeFBTeUo2bGxrWFhsdFlibDJKYnBZQjBMS2wxYW1G?=
 =?utf-8?B?bUp6UjBwdGkveDVTWGYxMnhlbWFrdlVJTFl6bWlqWmxyRDVWSzNvRGJWTG0r?=
 =?utf-8?B?Vm4wSUlFZWRWZXpYVUFZcVBqZmMwVG1GSmxhUkxGL2VpbXNua2Y4Wk9Ea2kr?=
 =?utf-8?B?MU05N3BFK2ErZVovQUZUMFJ3RHJWSGFncXg2d0FiRTFmWW5NN0k1Q0ZJb1Rs?=
 =?utf-8?B?b3Z2S3BqODhhNkcyZ2xCK05BSGZmZm9ldGJnMlpDelp3YXZOTnk3V0ZHcXph?=
 =?utf-8?B?VzB1MVZLUkg5Vy9rRGo0UkNnUnQzYzRTZW9FS2RYR3dncU1mTGxPMmp5V3hE?=
 =?utf-8?B?dlF2d3pCd1V4VnIxOTdNZWtBK0tNOWJ6dHBTSGZKWklURkU0NGg0aXR1SGRB?=
 =?utf-8?B?VVNqVHFCMDNocVdMeEZIZjlNdzJJa2M0V1Q3M29JZVJrLzY1YlBBNEpNQ0R0?=
 =?utf-8?B?WEdCaFovKzJNOG9iMERuU2orSkFUQTRQQ0dqcFZzaEplT0RxNVowdWY4WUx4?=
 =?utf-8?B?bnc2WE1xbXRVWi9HK0RyMDJpZWZ1OWg5ZzhlSWU0K2IrSENSRXN4UGl4R0Z0?=
 =?utf-8?B?UllMYjBNcVVxMkZjb0VUcVpsejY4WHZsTXVBZE1qY2JuUGcvZUt4SkpNd2RC?=
 =?utf-8?B?MFZuQi9ockp2MVJJZVBnUHNySHpOaDVsalVoRmhEWXdRRzFmaUhWOTlHS2VT?=
 =?utf-8?B?Z29vQkgxeFkzUmhXWWVZQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU1FNEgyZmZtNnhGSUtCRUVzL0g0M3VUR2tmdGZLUzRoZGVtWEhCQ3prL3pa?=
 =?utf-8?B?VHp4U0lsVmVNZVR1Qzh1UElsRStWM29yYkRtd1pHNmx4OEdwQU1YUldOZ0Fp?=
 =?utf-8?B?bi80ejhRTXNTYnM2b2hLRmN3NW1ZSHVSTGk3WGRUcFdBY0ZNVnV4NmpQOXNl?=
 =?utf-8?B?ZERYM01XVHJFU2pndGpLcGxFZ3BVQlJialpSVmFFMjVXd2NGcFlBSUd3TGpa?=
 =?utf-8?B?Ni9kUUc5VzVOVUNZay9pUTlEZmdzam1JdmxHVVl4TTRnOStubTcrSHFzWm1y?=
 =?utf-8?B?ZzJsQmlqTkszVm56RVphbVQ5TWxURjdyazloODdQZjFvTzZnUFJIRElBWXNx?=
 =?utf-8?B?dkFySC9KMG1NM2dBOWdBSi9JYTQzQXR6cDlDWGJ6UkhZQnJ3VDBCeUw1OHFR?=
 =?utf-8?B?T0IxZlYxUkp6QVZ5UWVUWHR1KzZXUWVEcitJNS9MYkx6QWxDUUJ1aTJ4akJa?=
 =?utf-8?B?Y3dRcGNpSGI2MFJ3enI3bFJMOFlITWpMVS91bC84eFB0Ykl6MmthanVldzhM?=
 =?utf-8?B?RXhVTEhXWHhLZEFMbWdHVlVJMWNlT2x6VUUwZUU0Tk1zaFcxVjJ0d2p6a1Fr?=
 =?utf-8?B?bms3MFFQNXNTYml6VUJrZTZJS2JJM0lucytvYjB0NkJjTUNpeG83OVlBL2Rr?=
 =?utf-8?B?eGd0NGVxVGRmNCtPdTlGMitha1RBcXF0WHJaakFJdVBJYk8zMzVUd3hXUlJE?=
 =?utf-8?B?YjNMYTRTNlp1QWpSMXE5THE1Ukh1Qno0amhnVDd6OVloWXRpdjk1dVk3ZlpI?=
 =?utf-8?B?aHUwZ1B3V2lxWTkwMDM0VmpkdDdSVERWdlhNdnJ0OW1QM0V0QmhYYWNaUlp6?=
 =?utf-8?B?VndESHc4eWtZOGhjK1FLR2t6SHdIbWtqN1VCS3gxWkIrUzRXNEh2MjVTV2Ft?=
 =?utf-8?B?NXhzbVQwT2JScG1lRDB6SjRLVU9sSTFiQTlLVGF5T0FBUWFwUXlHWTJCK0xS?=
 =?utf-8?B?UUR1Y29BY3NiSGR5YmJzRGtlaS82Y3h6bEZUL1IrQnFsUnpaY1AySUZVZ0cw?=
 =?utf-8?B?Z0F5RXRsdEFMbnA3anYyUE1TUWM1a3I5Y3RReGtTTkVkMW1VNWRhc2lSZVNl?=
 =?utf-8?B?UmhFYTVQU1NBWk4vdzlpL2N2ekRDZVpyWHU5M29kb3p5SHpCQ3pUeHRnUGFR?=
 =?utf-8?B?aUFZeXJiMzlTNlNLa3pxS05LaVZRZUVMLzN6b3poOTRmYnM0YUVScU1uQjRZ?=
 =?utf-8?B?M2w5TXZDR1ZqUVhWWDA4ZkZPQ05adk03NURMNGQxZHBCMTZHMTZSVzdlK05x?=
 =?utf-8?B?N01QNHRmNFU0RWpvM0t6R2RCaHpWYUNPeGdKSnkzWGRRRzVyVXFqODhRTGZX?=
 =?utf-8?B?Mkd5cTV0ZXN3QUhpMklZd2o1aGQvazhibkpHQnZlVHNSQURpbFpLcDdjTXAx?=
 =?utf-8?B?UUpFaGpBYTNKbmNtS2JKamtLclV6UVp1dVh1Y0QyeVMyVVpmSlFnOGg5ZGw0?=
 =?utf-8?B?UVBndncxR2hieHNlNlF6NzR5NVlOOGM2cldmbSt4M0J4ZEhJRkdwV3JWSW9p?=
 =?utf-8?B?eFpHRHhhTHVTaHJiY0Y5bXJTdzErZE9YLzBzK3NjaEZWdnJpNVpvbmZqUkda?=
 =?utf-8?B?UVF3aDlKbGpoL1RxR2JadmpmNFJIbjVZZDR6VFd1K3h5NXhPRFlzZEhPbFNz?=
 =?utf-8?B?ZXdZMmJHa3MrbkZKYkZoZkZnK1ZacVEveGswQVFFa2ZoY3QzZFJyYXp2TWFi?=
 =?utf-8?B?dUFiQ1gzSFlheGgwZXpkUXEyRCtCaU4xaVgrSkdScENtb1pueUFta3NXMmg5?=
 =?utf-8?B?emhQc2c5REpob2l4ZmZUa2p5MExNVGtPS0FoZk01S3liVlpaUFBBWW9NeE5l?=
 =?utf-8?B?VXdUdk9OZno2KzFpSFZ4eHpjMTl1Y3NyRHY4TXgvOEV1WE5XVVl0bkpiMk0v?=
 =?utf-8?B?eDBZTk0yV2N2SVNYMTRRUXpMR0ZweEpjMFdMWjB5dm1PS1ovWXBLTlQrcm5s?=
 =?utf-8?B?UTJlZ2VSNXpzcVBaWmh5WmxEVXpvZC9ISXlmbWgvN1Riak1ZWWdZTEN1WmYx?=
 =?utf-8?B?MEhSZkhEMmhzOXNDT25BenpwZ0RhY0tVVDRRbWd1Y3pndzR6SVh5emtDVFFz?=
 =?utf-8?B?MmR2NDEwUkJtZWc4bEl6MzVPMGN6VWlqVTFxeGVRR2JTYzAzOFNXTFhzQkZy?=
 =?utf-8?B?SUhuUGpKZE8wRkljUk02ck03cE1hVDNLNWhwMDRTMk1seVZyZ0d5UFpZWElm?=
 =?utf-8?Q?aXd7V0eUJlnvsCgPbnxJXt0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F156F5DD5D32E64E81C1AC0372FEA76A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d646b05-75d2-4805-82af-08dc7e0bd6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 05:14:09.3784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgjBj8MrxxkiSIMZXYvIZjVAsIEemepz/v338pJGv9qN4QdtpufZeS/DIrLqhKs611FdChb7kV7AiUH6gafIvKNd/isHbRM/HbLvdug+5S1fO2hl4IhrHRkIT4dYtrG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6983
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQpPbiAyNy8wNS8yMDI0IDA1OjE2LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gSGkgQ2xlbWVudCwNCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gU2VudDogRnJpZGF5LCBNYXkgMjQsIDIw
MjQgOTo1NyBQTQ0KPj4gVG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPjsgcWVtdS0NCj4+IGRldmVsQG5vbmdudS5vcmcNCj4+IENjOiBhbGV4LndpbGxpYW1zb25A
cmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4+IG1z
dEByZWRoYXQuY29tOyBwZXRlcnhAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsNCj4+
IGpnZ0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOyBqb2FvLm0ubWFydGluc0BvcmFj
bGUuY29tOyBUaWFuLA0KPj4gS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgTGl1LCBZaSBM
IDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFANCj4+IDxjaGFvLnAucGVuZ0BpbnRl
bC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPj4g
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0
DQo+PiA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD47IE1hcmNlbCBBcGZlbGJhdW0gPG1hcmNlbC5hcGZl
bGJhdW1AZ21haWwuY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCByZmN2MiAxNS8xN10gaW50
ZWxfaW9tbXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4NCj4+IHNjYWxhYmxlIG1vZHJl
biBtb2RlDQo+Pg0KPj4gSGkgWmhlbnpob25nDQo+Pg0KPj4gT24gMjIvMDUvMjAyNCAwODoyMywg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPj4gZW1haWwg
Y29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4+Pg0KPj4+IEFjY29yZGluZyB0byBWVEQgc3BlYywgc3RhZ2UtMSBwYWdlIHRhYmxlIGNv
dWxkIHN1cHBvcnQgNC1sZXZlbCBhbmQNCj4+PiA1LWxldmVsIHBhZ2luZy4NCj4+Pg0KPj4+IEhv
d2V2ZXIsIDUtbGV2ZWwgcGFnaW5nIHRyYW5zbGF0aW9uIGVtdWxhdGlvbiBpcyB1bnN1cHBvcnRl
ZCB5ZXQuDQo+Pj4gVGhhdCBtZWFucyB0aGUgb25seSBzdXBwb3J0ZWQgdmFsdWUgZm9yIGF3X2Jp
dHMgaXMgNDguDQo+Pj4NCj4+PiBTbyBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUg
bW9kZXJuIG1vZGUuIEluIG90aGVyIGNhc2VzLA0KPj4+IGl0IGlzIHN0aWxsIGRlZmF1bHQgdG8g
MzkgZm9yIGNvbXBhdGliaWxpdHkuDQo+Pj4NCj4+PiBBZGQgYSBjaGVjayB0byBlbnN1cmUgdXNl
ciBzcGVjaWZpZWQgdmFsdWUgaXMgNDggaW4gbW9kZXJuIG1vZGUNCj4+PiBmb3Igbm93Lg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCj4+PiAtLS0NCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxNiArKysrKysr
KysrKysrKystDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBpbmRleCBlMDdkYWFiYTk5Li5hNGMyNDFlYTk2IDEw
MDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+ICsrKyBiL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4+IEBAIC0zNzQ4LDcgKzM3NDgsNyBAQCBzdGF0aWMgUHJvcGVydHkg
dnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
T05fT0ZGX0FVVE9fQVVUTyksDQo+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woIngtYnVnZ3kt
ZWltIiwgSW50ZWxJT01NVVN0YXRlLCBidWdneV9laW0sDQo+PiBmYWxzZSksDQo+Pj4gICAgICAg
IERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRzIiwgSW50ZWxJT01NVVN0YXRlLCBhd19iaXRzLA0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQUREUkVTU19XSURUSCksDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAweGZmKSwNCj4+IHlvdSBjb3VsZCBkZWZpbmUgYSBjb25z
dGFudCBmb3IgdGhpcyBpbnZhbGlkIHZhbHVlDQo+IFN1cmUsIG1heWJlIFZURF9IT1NUX0FERFJF
U1NfV0lEVEhfVU5ERUZJTkVEPw0KWWVzLCBmaW5lIGZvciBtZQ0KPg0KPiBUaGFua3MNCj4gWmhl
bnpob25nDQo+DQo+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9kZSIsIElu
dGVsSU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLA0KPj4gRkFMU0UpLA0KPj4+ICAgICAgICBERUZJ
TkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsDQo+PiBzY2Fs
YWJsZV9tb2RlLCBGQUxTRSksDQo+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNv
bnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsDQo+PiBzbm9vcF9jb250cm9sLCBmYWxzZSksDQo+Pj4g
QEAgLTQ2NjMsNiArNDY2MywxNCBAQCBzdGF0aWMgYm9vbA0KPj4gdnRkX2RlY2lkZV9jb25maWco
SW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+Pj4gICAgICAgICAgICB9DQo+Pj4g
ICAgICAgIH0NCj4+Pg0KPj4+ICsgICAgaWYgKHMtPmF3X2JpdHMgPT0gMHhmZikgew0KPj4+ICsg
ICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiArICAgICAgICAgICAgcy0+YXdf
Yml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPj4+ICsgICAgICAgIH0gZWxzZSB7DQo+Pj4gKyAg
ICAgICAgICAgIHMtPmF3X2JpdHMgPSBWVERfSE9TVF9BV18zOUJJVDsNCj4+PiArICAgICAgICB9
DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hP
U1RfQVdfMzlCSVQpICYmDQo+Pj4gICAgICAgICAgICAocy0+YXdfYml0cyAhPSBWVERfSE9TVF9B
V180OEJJVCkgJiYNCj4+PiAgICAgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiBA
QCAtNDY3MSw2ICs0Njc5LDEyIEBAIHN0YXRpYyBib29sDQo+PiB2dGRfZGVjaWRlX2NvbmZpZyhJ
bnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4+PiAgICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4+PiAgICAgICAgfQ0KPj4+DQo+Pj4gKyAgICBpZiAoKHMtPmF3X2JpdHMgIT0gVlRE
X0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+ICsgICAgICAgIGVy
cm9yX3NldGcoZXJycCwgIlN1cHBvcnRlZCB2YWx1ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCIsDQo+
PiBzcGVjaWZ5ICdpbiBtb2Rlcm4gbW9kZScgaW4gdGhlIG1lc3NhZ2U/DQo+Pj4gKyAgICAgICAg
ICAgICAgICAgICBWVERfSE9TVF9BV180OEJJVCk7DQo+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiAgICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGUgJiYg
IXMtPmRtYV9kcmFpbikgew0KPj4+ICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVlZCB0
byBzZXQgZG1hX2RyYWluIGZvciBzY2FsYWJsZSBtb2RlIik7DQo+Pj4gICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+Pj4gLS0NCj4+PiAyLjM0LjENCj4+Pg0KPj4gI2NtZA==

