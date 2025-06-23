Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AB5C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 03:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTXjG-0004u6-GX; Sun, 22 Jun 2025 23:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXjF-0004tx-2G
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 23:20:17 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXjC-0001HA-99
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 23:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750648814; x=1782184814;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LcJYqF5JMuL/tFRdrBCVYc4IDBv410Q13ZHYhHBayOc=;
 b=czvvyP0HRLsGmqw1VpBkNPe0jApj9nMI4/rGfU5qJQRvZ9AjNSb2q7jN
 0VuJ7Q8NjMv6StOimiSgto86dMELcbnu1UP0u2co8pSp2SIiolmDUzVuW
 gbQb96ZSyYZ52nrk0aaYvHaVDREu3bgsc4HZ/QYA47kW4NyhdqO0Lq5Hr
 jU6p61L8jwBrsH09UsmUQVxTPikeInmoaM+HI7q3ZePgENXQdAkuO9tEW
 CrsPfUn0av+f/6tcthZCSnpndsz1qnl7+jyfWVggQh8zRHbH43kTlV/wS
 RckAECUS+e5N5svcupyzrSVoLfJoJTt+k6x7zDlxRuoGLxDAZz0o8fgGl w==;
X-CSE-ConnectionGUID: e3IEwgZGTJ61LhDUiMqTpg==
X-CSE-MsgGUID: WbOTJg+MQ3GsV/r/Gsiahg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78253299"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="78253299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 20:20:11 -0700
X-CSE-ConnectionGUID: ZrXgPZrXSSSb8hvA5BPa4w==
X-CSE-MsgGUID: GkfFKD7ER2W2QUIrLIaipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="151987769"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 20:20:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 20:20:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 20:20:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 20:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A37mxpU8zgQAngviy47OEhRO/TTTo+ETR5XO+acGGriIg4BeilvpvsLWCvlSklH5cB9FPfw0VmWZxKE/pFRbBM4RMFBqUb2JV3gCGW7L/Oozp+yJqC1Xz4cuVe86FcldK2JBjh7PehNaPaMOA70Bza/eTIz24WyjT3vOuFKcz/CfQ0eoPotfyhOqYeGi+aaoZHvnyaqbYoBvz2v62HLof9Tz4bu2+c0PMymG+Dqw2v7T+fSzsSOOFBaGsiRqFWlUXEo+8tAotFffjV/AvXph57ucoxi+3NTqXXPjndHsZfSBoItn8bVGyCLz7newe/suwe3pEzDOwBV47TkCpO3CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcJYqF5JMuL/tFRdrBCVYc4IDBv410Q13ZHYhHBayOc=;
 b=xsvjNUtSpkVrzb0EtdHZepOkM8y6OGopQ8W03z+1WyYcpVx8FNeVRSI+48dJMWePQY7UHdbEVoSV4HpqbvJPRV7r5Q4TTkBRjcmXCLIAWIB4rRRnduPbyUw1wRRXcB1j6kS+1rVubMzW+ckfkN8cT3TkvLo+UY+iJAk4pvHXu2WkmBW4oik2ifIqhVEKVeP9xFx03AdRFbcpUxmZeh/Hc+KDaoH3D0/SvapTr02nTXpAPEHlLzJYhCI/XbsbN8yYmCI2e2kLQ10sA4ZFDNMNgKw+sB+Wq3anUk6n41rZLrzi/VuHRAzZVdmhq1h+BiI4Mre2YqU/t/VldcAwUPt4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 23 Jun
 2025 03:20:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 03:20:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v2 08/19] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Topic: [PATCH v2 08/19] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Index: AQHb4bQlRXzPmG6owEGr8oeV3CxX3LQL948AgAQXidA=
Date: Mon, 23 Jun 2025 03:20:06 +0000
Message-ID: <IA3PR11MB91366FB9BE5F25F8F30F7A829279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-9-zhenzhong.duan@intel.com>
 <eab32043-68ee-4970-860c-5e512316cf20@redhat.com>
In-Reply-To: <eab32043-68ee-4970-860c-5e512316cf20@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4953:EE_
x-ms-office365-filtering-correlation-id: dbe91313-19ba-4f14-94b9-08ddb204da47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b2xLK3FKUFpsRGh0Y2lnN3dIR0hBU254ZUdHMzhiSlFXZFlsdXNLajFUaGNy?=
 =?utf-8?B?TUtlOU1sbU1iZzZWNzdzMnFKTHlWV3VRSkZlYk5SZVIzUlM5V1VoVnBBeUVX?=
 =?utf-8?B?N05NblZwQ0pxYlZWK2JJaWJwT3BZM09HMUVWWUw4d2pITG9YUmU5ZHBKZkNG?=
 =?utf-8?B?M0FMZnladDFiTkwwVE4ycHlhVUtVS3pUTTR2d3Z6TnZwRExjYXg0OWpOaTZj?=
 =?utf-8?B?Q0VYTTQwMFEvbFp5V21iSmtyaytya0U2MjJEM0FkT3lNYlFwbmlNQW01eFpm?=
 =?utf-8?B?TGtaVkVGWXcvWlptSWFveFJMTVhtbk5qby9LZVVveHcvTGtJUWJVQVBiWkU3?=
 =?utf-8?B?QlRFREpIa0E3c3N2SFJhd3ZHQ1VHYXNMb2pZTXJaaC9YaFh3VXlNQ3RDdEU3?=
 =?utf-8?B?QlRvSkFYS0Y2VkxaYXV6UWZGQTduT3YxZ1lSL0V0QXBHRlNwTUxxUU1kcVho?=
 =?utf-8?B?cWNDNzcvcFNKdXIzUThMb2RoaE5SUjhvL3N4WExhaGo5UllKcXhWRGp0QVJF?=
 =?utf-8?B?aTN2Vk51MDVscXF0eTVwS1lpSXV6ZVdZeTllNUw2VkRMOU5XSlc0WGU2VEtJ?=
 =?utf-8?B?L01ORlI0a0NPb1ZSKy93NHdSYThYV2ZXZ2VWK0Z4VFdlcWh2YXdRZ0tzYnd5?=
 =?utf-8?B?UlFVY0wzTmxyazZvbEpVU2d4SEJiOGdNMTMwNUJTTk1Fa0ZjWmdkamE0VmhS?=
 =?utf-8?B?UkptRVlGN1BlY1RtcDRQUEJyb1M5Zzh5RStmYndFcGZNMzIrblNqMm11K0xB?=
 =?utf-8?B?Zkl0ZlBaamg3djUrLzRXMTNIUE1TcEVwa0dDNTB3Y3JVbmtNMmgwZDBJQXFt?=
 =?utf-8?B?NEdVd2tMVGNGQnZnaGFMMjY1ejVoWDN6ckVodHA4Y1dGZ3R6dFVQUXNsNXoy?=
 =?utf-8?B?WitNd0t1ZVAxdDV0U01LdCtEWVE1K1U2c1dEVkhCc1RhUkh0TWdmelNLTjZG?=
 =?utf-8?B?Sk1mR25KMGJWNFRnVmpmRjlnNE1EdkpLQWwrNEVreklJUVlsNVkyQldiOGtt?=
 =?utf-8?B?ZWgwYVNMbTVxdDJ2MDZaNmxvM21oQmdwaG1weXhUM21kazlxVGZCUXZwMWx0?=
 =?utf-8?B?YThUcFNMWE9kVzFFUkRHRmtnUEh1M3VySDhYZ2ErQlFGWjdkZmd3YWx2SVdx?=
 =?utf-8?B?bGRhNDBLNzJ0a0QxTjdFQXlLR2FnM1lvL2F3RGxkU1Y3YXBtRmtxckE3dzhj?=
 =?utf-8?B?Rmx2MkxOUXlzRHhUc0Zmb3JhV3dwS25uMjliQms4L0podVFSK1lTZWJKMUZu?=
 =?utf-8?B?SVhkeXdVcUVxY3F6Y3FuK0RpK2Z1V2lKZkRpazRIZjI5T3dmY1VYSEhTY3pL?=
 =?utf-8?B?eTBpclMxWGFFVWtONnQxYnUwd0QzTWZaaU5aQm5BaDFzTVRTUUhScnVzZ05x?=
 =?utf-8?B?NGhNT2JQbDJlSEkyeUJ0OTRvanNoejVDd0EvZENHSkdqV3YxZHczZUNlWVRm?=
 =?utf-8?B?MEMrMy9FaWVHamNJME5mU21EdEdSdG1VUWxnaVE1Zm4rbWRLekFPOHRqQU1P?=
 =?utf-8?B?Q204N2ttTmt4YlFsTXZETFA1Mk5NUml2M2tIWDZZZ212b1RaZTgrcnBidkJZ?=
 =?utf-8?B?TmQwUDIrQm9nc0h4U0RSVGI4TTZ6OVFhWGJPaGpKRjA4SEhCMHZ3dGYvWDZ5?=
 =?utf-8?B?QThieHhyL3NHZ1hxeHZnb1htc0s0aURFQ3ZnZlNzMzlZOEFRUUhtV0h6cGRT?=
 =?utf-8?B?RGNHNUM4MVNpWmYwMitJUEhNYUFrNElCYmMyUU1qTFRWdjh5R0g2dVZ2anJI?=
 =?utf-8?B?clcyRnltelFuTU9tbWRXUi94QnpkQzV5bmIyYlpwaHRhdlRPTmRJa2JTRXJX?=
 =?utf-8?B?a2swSE41eXczWjRPdGIyTFJzTzlScTNCdys3UE5pTjBRbTJPbjZhMFJsWXNV?=
 =?utf-8?B?QVExSGdKN0pINHZtM1kxV0FwRm9FUVZ5alRaeTJjR1YxV2RYSmNGUFVrb29Y?=
 =?utf-8?B?cXF2MkhPbEVPR1hvUm5VMXM4cjcyTDJXam12RG05M2hmOHJGUTR2bUVQbGht?=
 =?utf-8?Q?FKea+7zjFuzpEcRbMFsOs+txlCH5qE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDRmbXJzWmtUbUhocUtMeVBoK3JHWnQ1dndsRmNoZklpY0JJdWpLeWdQYWdS?=
 =?utf-8?B?RXJ2RDF4RVhHRFEvdjd0ck13bVBYUXBPVGJEU1dPZzlrL1paMTl1MGNKU3lW?=
 =?utf-8?B?cHFRN1JRMnlMVTFaRHh5WU9TdURsRndwR0cwNUxreVIra3lEalBHNEpvVUtj?=
 =?utf-8?B?S0x3VGVVYlBsSkRJZG83K0ltODFDV05CdzJndmhkVDF2alBXUjFIZVZuYTY4?=
 =?utf-8?B?Q3Q1c3Y3UEdiWG9XaGMxK05LZkVRaEY3WTc5QlNob0Y4bDFiSWcxSDhWZUwz?=
 =?utf-8?B?Mk5oVVgxeU5VNEpNejUxdktKdHVtVHZlSVRrbnlIOVh5K3lsaThPRkxITnZ4?=
 =?utf-8?B?RmtHbkxsV0Z5N0NEQzk1UXQycHJGY3hNWjVqRUVqS2Z4T0dDQVJPYWtpc0RI?=
 =?utf-8?B?S2lha1Z2d3RwcS9lMDJPOFkvTlhza0dINy92SFpKWUkxc3pwbUJmY3l2V2hs?=
 =?utf-8?B?TjloWEZUVFpacHZWQ1E1VDVZenNZTGlXc2Z0QTRZR0xQc0dzcDFPNk5LSElL?=
 =?utf-8?B?Z1owMGJzSWlGdE96SlhqdU1STHk3RkJubUVEQTlBU3QyTlpuUkQ0U1F2OW1Y?=
 =?utf-8?B?a3ZHZndKNjVBZWNQZkZTUWUySVJHZnpiaFhMeks1WE03U2RlWEs1MXIrdVNX?=
 =?utf-8?B?R291SlZZbmp2M0FKTGhCV3BJT000Q2xCOVRIODlSeHB5UnBYeE9ibVBkWHZj?=
 =?utf-8?B?T053b2R6dkt2bzllZVJXWFp1Q096R3ZUaTNSYnliNW9ZbVd6QUxiemd1TkJw?=
 =?utf-8?B?YUN5SWU2VzJhaVVwWitSMCs2SUEzbmJmNzRPZDR6eng3TUhrd2V0QU1yUjhQ?=
 =?utf-8?B?U3B0dXpjN3JYVkpIeVF2V0tpV01hRmQxRndXaXNxSml6dUZPb3pEZU93VXNt?=
 =?utf-8?B?cTRIUFpRNE9PSUZYZ3JtWGhidHYxZitZVHN3UW8yOXJwT2E4NmgyU3hiQlJ1?=
 =?utf-8?B?dTlWajRoMEQwOUpMNlA4MWJaL2R4TDY4ay9HdXZrS1hINFNBbTJ0V0lUZzN6?=
 =?utf-8?B?Y1N0T1plT0FzN1NsK1ZsMlFWblEzaUJYVVdBUHoxT1g3MFVtZHR5anRNb085?=
 =?utf-8?B?UjdwajJkUkRzVUtaYXlxOWlxRGJwQnY3TjNIUStHM3I5Y3FYMGxCbllpLzNm?=
 =?utf-8?B?ZlI3MDVqUlpMbDJpMkpndjZSR0JTbnRWQUNWK2x3TWtOZWxyWCtqUEQvRUU4?=
 =?utf-8?B?WUR6TFB2VEZ3VmFQUHgxeEpkekt6K0FKN0NFL0wranhrM2lsSjJ5K0d2Qkhs?=
 =?utf-8?B?R1lsMWFYbEo0TzhsalpTN1hqaWY4ZlN1MzZLSGgrSXdScmxyOEZ4Z1pyK09w?=
 =?utf-8?B?elg2WVlnSXR4RDEvTUNYYnFrclZSajl6Q1lOZ1FhSWdNNXYyandTUVNTMFpk?=
 =?utf-8?B?Qi8xTzdVWVhmRnpIUXRwT3VISXJiYU03dENrVXUwVTdnWGYvZWhUcDVRRitQ?=
 =?utf-8?B?ck5NSDdhc0hxNmdtWGNNd3I0TUVwRXNRQ3BHYmROOUZUTkdTUTNjTXIwNVhL?=
 =?utf-8?B?OFlyK2hIdTF5amxGVG5Ybi9sUnRFaWEzYlR2dVZ6T1BWcHVUTUlyTHYvUzI5?=
 =?utf-8?B?VHV6dTlBYnhUTTFod1lucDdYOC9NV25mMjUwQXlQNndQNFJJcEYyQUFoTGFR?=
 =?utf-8?B?cEpyTzUxYkVNc0tiL2ZqZVVRbG1ZZ2U0NmorVlJNNDQ3WnlkbnlsbE5Nak1F?=
 =?utf-8?B?K3AyaW9sUHV3eTQyK2dFNmFpTTZCMUY5TXRINUg0Ukc4endlcWZKRmJoTTdZ?=
 =?utf-8?B?YnB1SnRGMlJiNFRnY1FhNUU0U29USk1xR2NjUFhNTVA1SG5SOTJodGNiWHY0?=
 =?utf-8?B?b2FMZXJqVVQ1dXl0dXdXUHBybjlZczBsTHpHenNCWDBRYlNaYjlqa2syUlNV?=
 =?utf-8?B?aVZWTENtSkw1eG5mVTV5YVNvZzRlSlJEY0NIRWg2Qzg0ZCsyU0JsQUxORzkv?=
 =?utf-8?B?c3V4ZmhFZG8wcWR5bWVhcCtOd0hoYjNyV1hHaXA1dEt6ZElUR2xGT2ZBV2RW?=
 =?utf-8?B?ME0yMnZiYzhzNEpFV3k3S2xLRVB2L1ZKbHhxbEQ2a1p6QTBiUHA0OHk3d2Zi?=
 =?utf-8?B?UEdJbis3Y0taRzJwY3Ixdm9oWXZNTXpiY3JYWlgwT05tUFFyZTBBVzNaQW00?=
 =?utf-8?Q?pGeea6EmvGN2v7vK6OVl9C7rr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe91313-19ba-4f14-94b9-08ddb204da47
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 03:20:06.7587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2/YuxgCeuQESfc8PqefpSvxp2LPW+bMv3wY6GSJCcjEJ7FcHQ4798evLtmtY/xF7HO4nXgC5++BPe9y0sMi8c+q5A7c9O0qKsePgYXqgaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDgvMTld
IGludGVsX2lvbW11OiBGYWlsIHBhc3N0aHJvdWdoIGRldmljZSB1bmRlciBQQ0kNCj5icmlkZ2Ug
aWYgeC1mbHRzPW9uDQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvMjAvMjUgOToxOCBBTSwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDdXJyZW50bHkgd2UgZG9uJ3Qgc3VwcG9ydCBuZXN0
ZWQgdHJhbnNsYXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZQ0KPj4gd2l0aCBlbXVsYXRlZCBk
ZXZpY2UgdW5kZXIgc2FtZSBQQ0kgYnJpZGdlLg0KPg0KPkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUg
YWJvdmUuIERvIHlvdSB3YW50IHRvIGZvcmJpZCBhIGNvbmZpZ3VyYXRpb24NCj53aGVyZSBib3Ro
IGEgcGFzc3Rocm91Z2gnZWQgZGV2aWNlIGFuZCBhbiBlbXVsYXRlZCBkZXZpY2Ugd291bGQgYmUN
Cj5kb3duc3RyZWFtIHRvIGEgUENJIGJyaWRnZSBhbmQgcHJvdGVjdGVkIGJ5IG5lc3RlZCBJT01N
VT8NCj4NCj5JZiBJIGFtIG5vdCB3cm9uZyBpbiB0aGUgcGF0aCB5b3UgZG9uJ3QgY2hlY2sgY29l
eGlzdGVuY2Ugb2YgZW11bGF0ZWQNCj5hbmQgcGFzc3Rocm91Z2gnZWQgZGV2aWNlIGJ1dCBzaW1w
bHkgY2hlY2sgd2hldGhlciB0aGUgaG9zdCBhc3NpZ25lZA0KPmRldmljZSBpcyBkb3duc3RyZWFt
IHRvIGEgUENJIGJyaWRnZS4gU28gaWYgSSBhbSBub3Qgd3JvbmcgdGhpcyBpcyBub3QNCj5yZWFs
bHkgYWxpZ25lZCB0byB0aGUgY29tbWl0IG1zZyBkZXNjcmlwdGlvbi4NCg0KWW91IGFyZSByaWdo
dCwganVzdCByZWFsaXplZCBJIGRpZG4ndCBtYWtlIGl0IGNsZWFyIGhlcmUuIFdpbGwgYmUgbGlr
ZToNCg0KIkN1cnJlbnRseSB3ZSBkb24ndCBzdXBwb3J0IG5lc3RlZCB0cmFuc2xhdGlvbiBmb3Ig
cGFzc3Rocm91Z2ggZGV2aWNlIHdpdGgNCmVtdWxhdGVkIGRldmljZSB1bmRlciBzYW1lIFBDSSBi
cmlkZ2UsIGJlY2F1c2UgdGhleSByZXF1aXJlIGRpZmZlcmVudCBhZGRyZXNzDQpzcGFjZSB3aGVu
IHgtZmx0cz1vbi4NCg0KSW4gdGhlb3J5LCB3ZSBkbyBzdXBwb3J0IGlmIGRldmljZXMgdW5kZXIg
c2FtZSBQQ0kgYnJpZGdlIGFyZSBhbGwgcGFzc3Rocm91Z2gNCmRldmljZXMuIEJ1dCBlbXVsYXRl
ZCBkZXZpY2UgY2FuIGJlIGhvdHBsdWdnZWQgdW5kZXIgc2FtZSBicmlkZ2UuIEZvciBzaW1wbGlm
eSwNCmp1c3QgZm9yYmlkIHBhc3N0aHJvdWdoIGRldmljZSB1bmRlciBQQ0kgYnJpZGdlIG5vIG1h
dHRlciBpZiB0aGVyZSBpcywgb3Igd2lsbA0KYmUgZW11bGF0ZWQgZGV2aWNlcyB1bmRlciBzYW1l
IGJyaWRnZS4gVGhpcyBpcyBhY2NlcHRhYmxlIGJlY2F1c2UgUENJRSBicmlkZ2UNCmlzIG1vcmUg
cG9wdWxhciB0aGFuIFBDSSBicmlkZ2Ugbm93LiINCj4+DQo+PiBSZWFzb24gaXMgZm9yIGVtdWxh
dGVkIGRldmljZXMsIEFTIHNob3VsZCBzd2l0Y2ggdG8gaW9tbXUgTVIsIHdoaWxlIGZvcg0KPj4g
cGFzc3Rocm91Z2ggZGV2aWNlcywgaXQgbmVlZHMgdGhlIEFTIHN0aWNrIHdpdGggdGhlIHN5c3Rl
bSBNUiBoZW5jZSBiZQ0KPj4gYWJsZSB0byBrZWVwIHRoZSBWRklPIGNvbnRhaW5lciBJT0FTIGFz
IGEgR1BBIElPQVMuIFRvIHN1cHBvcnQgdGhpcywgbGV0DQo+PiBBUyBzd2l0Y2ggdG8gaW9tbXUg
TVIgYW5kIGhhdmUgYSBzZXBhcmF0ZSBHUEEgSU9BUyBpcyBuZWVkZWQsIGJ1dCB0aGF0DQo+PiBi
cmluZ3MgYSBuZXcgbWVtb3J5IGxpc3RlbmVyIHdoaWNoIGR1cGxpY2F0ZXMgd2l0aCBWRklPIG1l
bW9yeSBsaXN0ZW5lci4NCj5JIGhhdmUgZGlmZmljdWx0aWVzIHRvIHBhcnNlIHRoZSB0aGUgYWJv
dmUgc2VudGVuY2UNCg0KSSdsbCBkcm9wIHRoaXMsIHByZXN1bWluZyBhYm92ZSBjb21tZW50IGlz
IGNsZWFyLg0KDQo+Pg0KPj4gRm9yIHRyYWRlIG9mZiwgd2UgY2hvb3NlIHRvIG5vdCBzdXBwb3J0
IHRoaXMgc3BlY2lhbCBzY2VuYXJpbyBiZWNhdXNlDQo+PiBQQ0lFIGJyaWRnZSBpcyBtb3JlIHBv
cHVsYXIgdGhhbiBQQ0kgYnJpZGdlIG5vdy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUu
YyB8IDEzICsrKysrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCAxYzc5ZWZjMWNiLi45ZDRhZGM5
NDU4IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC00MzMwLDkgKzQzMzAsMTAgQEAgVlREQWRkcmVzc1Nw
YWNlDQo+KnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0K
Pj4gICAgICByZXR1cm4gdnRkX2Rldl9hczsNCj4+ICB9DQo+Pg0KPj4gLXN0YXRpYyBib29sIHZ0
ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0K
Pj4gK3N0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESG9z
dElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEVycm9yICoqZXJycCkNCj4+ICB7DQo+PiArICAgIEhvc3RJT01NVURldmljZSAqaGlvZCA9IHZ0
ZF9oaW9kLT5oaW9kOw0KPj4gICAgICBIb3N0SU9NTVVEZXZpY2VDbGFzcyAqaGlvZGMgPSBIT1NU
X0lPTU1VX0RFVklDRV9HRVRfQ0xBU1MoaGlvZCk7DQo+PiAgICAgIGludCByZXQ7DQo+Pg0KPj4g
QEAgLTQzNTksNiArNDM2MCw4IEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9N
TVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+PiAgI2lmZGVmIENPTkZJR19J
T01NVUZEDQo+PiAgICAgIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2Qt
PmNhcHM7DQo+PiAgICAgIHN0cnVjdCBpb21tdV9od19pbmZvX3Z0ZCAqdnRkID0gJmNhcHMtPnZl
bmRvcl9jYXBzLnZ0ZDsNCj4+ICsgICAgUENJQnVzICpidXMgPSB2dGRfaGlvZC0+YnVzOw0KPj4g
KyAgICBQQ0lEZXZpY2UgKnBkZXYgPSBwY2lfZmluZF9kZXZpY2UoYnVzLCBwY2lfYnVzX251bShi
dXMpLCB2dGRfaGlvZC0+ZGV2Zm4pOw0KPj4NCj4+ICAgICAgLyogUmVtYWluaW5nIGNoZWNrcyBh
cmUgYWxsIHN0YWdlLTEgdHJhbnNsYXRpb24gc3BlY2lmaWMgKi8NCj4+ICAgICAgaWYgKCFvYmpl
Y3RfZHluYW1pY19jYXN0KE9CSkVDVChoaW9kKSwNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lP
TU1VRkQpKSB7DQo+PiBAQCAtNDM4MSw2ICs0Mzg0LDEyIEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVj
a19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+PiAg
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTdGFnZS0xIDFHQiBodWdlIHBhZ2UgaXMgdW5zdXBw
b3J0ZWQgYnkgaG9zdCBJT01NVSIpOw0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAg
ICB9DQo+PiArDQo+PiArICAgIGlmIChwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4ocGRl
diwgJmJ1cywgTlVMTCwgTlVMTCkpIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkhv
c3QgZGV2aWNlIHVuZGVyIFBDSSBicmlkZ2UgaXMgdW5zdXBwb3J0ZWQgIg0KPj4gKyAgICAgICAg
ICAgICAgICAgICAid2hlbiB4LWZsdHM9b24iKTsNCj5zbyBub3cgdGhlIGNvbXBhdGliaWxpdHkg
YWxzbyBjb21lcyBmcm9tIHRoZSBkZXZpY2UgYW5kIG5vdCBvbmx5IGZyb20NCj50aGUgaG9zdCBJ
T01NVSBjYXBzLiAocmVmZXJpbmcgdG8gbXkgcHJldmlvdXMgY29tbWVudCBhYm91dA0KPnMvZGV2
aWNlL2lvbW11IGluIGVycm9yIG1zZykNCg0KWWVzLCB0aGVyZSBhcmUgdGhyZWUgdHlwZXMgb2Yg
Y2hlY2s6DQoNCjEpIGhvc3QgSU9NTVUgY2FwcyBjb21wYXRpYmlsaXR5DQoyKSBob3N0IGRldmlj
ZSBub3QgdW5kZXIgUENJIGJyaWRnZQ0KMykgQ09ORklHX0lPTU1VRkQgY29uZmlndXJlZA0KDQpU
aGFua3MNClpoZW56aG9uZw0K

