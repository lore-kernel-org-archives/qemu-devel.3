Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E3BD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 03:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPuUO-0004DX-Ka; Sun, 30 Nov 2025 22:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vPuUN-0004D8-2H
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 22:22:11 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vPuUJ-0007rP-Mv
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 22:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764559328; x=1796095328;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L/JCpSRa2TgAiM6oi/ir1WFGGdeVhmKo6qoxnkKq3uA=;
 b=YzGeu3W5IjvSAttZSQJAwovBltv4zMIRPYQTn5AvUEDsYOThp5v4ZKGs
 ugFxmqShCYP49RNusvWLLlIMZIR283z9LXr8XNAG+16VqeONUh+/ZAMfD
 R6QMgK5V8qkwoRWuTPvofvDTrop4l+2H6ARsEXSB0mYBbF90HcA73Ghtn
 uCmJObD9ZieDigV+ZSdqVPUzn5TU4sN/9CkI5aVWDZTFuLNQ4tX2fOJUT
 FDzRZ5wSQbWrEnXGWsjGFeipC6jN4581Qf+hsCJkh7G7Rd0rsmYugaMbC
 8L8dmRh5aw51iIcZ+DXDfn6AQtAhNByzOVtKKOTAlNP6vAsbV8K6Fwvw5 g==;
X-CSE-ConnectionGUID: o8QgZSKuSGWEDh7x91QNAg==
X-CSE-MsgGUID: mfkY0k25TqaVocmXdSJsGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77594485"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77594485"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2025 19:22:04 -0800
X-CSE-ConnectionGUID: uaRvL8RSTPCPoBGyaKDlTA==
X-CSE-MsgGUID: BSF2e1idTQuTkZSiK5yHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="194744292"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2025 19:22:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 19:22:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 30 Nov 2025 19:22:02 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 30 Nov 2025 19:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwIIE+bPgkmjoota5qzcfYU0vvTZaFQtgo1pf56IlRWrMVraoF9DM7MvWRig1ox3GXsDcyVQ811A0T3bqAAzh4Ja/uFkVB54qc9Wb0wQIozBzIKjcZ9JUKVBCUDRuyoFRwrq2VwXWKUkVUU+hWGkONzBwSgv+PsPsc17HE6GVCksRaBgm7xdXub/JWplvglyYiuTnev20WvNlgEcH/qBMnv6HFg+QL4vaLmRKO65bctCjJMHRtb7fmDZPA/2wIUgG1sGNuLUEHBLO78LZv6QVQQ1u24hBoz6O4cquZqVer9AOzka4V9nUiiRtDY7RDv49Cs4s2xKvHtaNtvsui9xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/JCpSRa2TgAiM6oi/ir1WFGGdeVhmKo6qoxnkKq3uA=;
 b=dl7x8rUdMTkU5NHI1GJ42cUSYE360fr2C+4PS4ap+MuVMfdg05Viqf34oSYnLCkbCBHFNv/1zsU2Zqlv6rgM+y3bpjaCIXCvy89/UelvGnYQLhsWVNQDbPhpgrTd2KlEgd76X2XKht2xtOrPq2T7GcWI/6sm1EQfc3MPNO507gZDewrT81C8Zlm8Tt3MpmbYBGjD7n1MPbKf2tVZa0zZhD0n7SpzX+DdmPdVDLsod62g9KZvys6IwClKZ/DLQ1n+X3ED1WHOYGiWO4oCjJl8YImV/OG9Q0Q0bY0IG6tT+IHtc8f1XlG6lgu7MDtC82ag3dIw0JudEsijt3q9BGtbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:21:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:21:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Topic: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Thread-Index: AQHcV6YfX2HIuNoGSUCHWlM9EysSCrUHZtRwgAC3WwCABAk08A==
Date: Mon, 1 Dec 2025 03:21:57 +0000
Message-ID: <IA3PR11MB91364348A5BBC66BE3ADB5E092DBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-18-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com>
In-Reply-To: <bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA0PR11MB8354:EE_
x-ms-office365-filtering-correlation-id: dbe3e404-a101-41dc-abd2-08de3088c8f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MWVCOXM0Rlh6RTJWM0o2QWt0enhzdy9wMmRnNlZhd1hRTElzUEpyeFUyTTZ6?=
 =?utf-8?B?aGUyU1BOUkVsWDlXODBzbG05bmQ0dEFNTnBwTno4SUV1MUJoZGthOFNhWWlp?=
 =?utf-8?B?UWFXZG1LbjJodS9lVG5KTWdNbHVzdldFVTcwbDZDYitwY21VWTN5c0pTekJ2?=
 =?utf-8?B?SlBBRzlnRnNEMVZQSFl0bDB5YWFYblo1RUI0RysycWVhamRDSHE1aUxpYUxW?=
 =?utf-8?B?eWtXSjJLS09pUVlPTms3WENiMjkvZFlGSXJRME9Ya0N5aExLR05QUFU0SHlL?=
 =?utf-8?B?TFpvN3B6QzdaSzh4TFdtcWRXMXJESjhwYitMNnAzdmtBUi9odDBJZWhSbFhp?=
 =?utf-8?B?dzhEaDZZT0YxT0tucHZlZU56dHJyc3FLaFhTZzZ1dGJVVmVoK2hOR3czOEF1?=
 =?utf-8?B?REpOOG8vU3BsOU1nMTJ6dFUvaW9HQ2creEhYZVRlSG91bGhaTGNIUDlPKzFo?=
 =?utf-8?B?RG40ejdVS1FWUG1jUFpmZGtEdnJ2TkZrUzAxTnlWdFBBQ2RjT2pSNG5tOW05?=
 =?utf-8?B?dWdrZ0dwWE1URjAxdVEzcVdPeWdwZEhscVZUQWxVb01lK0pnRjBQRVRQamhY?=
 =?utf-8?B?TkYzN01ZUjZsYzA1S0VPUjBLZkNJYjEyK2JLWnNxZE85U25lVHdrdnk4dTU4?=
 =?utf-8?B?M3BiY3FhY3NmNTQ4ckRQNVhwQm9RbkVkTUs4ckhSb0lwM1N2VVQ5T1V4VGRi?=
 =?utf-8?B?a05URUkwNVU1ZEQ5cTlUblgyaEUrNmp6WjNuNVNNMUUrTjFScVlOK0NXTith?=
 =?utf-8?B?OFRWeHRna2RDZUJvbC9TTGFUR3VFOUxjaGJMNUlobXdJVEJGdDJQbENHU2FZ?=
 =?utf-8?B?OGprU09BY2grRmVGV1Y2eDM0Z0M1R3VSaDVlZWpuZzJkNWxVdjFENVF2d0lP?=
 =?utf-8?B?U3VnRTRmNTVmdVVNUUREblVDaWZ3MUZ5YUxWRDJMWmlDZ2Y1N0NyYW9sbUY2?=
 =?utf-8?B?OWpiNWRyUk1XSVp4UzVVaXZKNWtyQzdTVThvL3JWSnpsZnFZUDlUYzFsTm1T?=
 =?utf-8?B?d3FtUEdnSW1SVTJsM1dhYXNsNVM4VjlKQlp2SC9GajBNc3JScXlBRFIxMnVv?=
 =?utf-8?B?bDEwWXJic0JoS3R0eCtPdjFRdmQwSTBCMFg1Umh4RlhKUXRKMFJXN3F3aEZH?=
 =?utf-8?B?djhNNDZTTkU4NHJVOW0rbGJoaW5GQU1QZUFLc3psVks4dHo3TTVpK1N1UExv?=
 =?utf-8?B?eFpvKzRqc3hkQXJndCtjRnp1UTVqYStrSFlsT2dnVWJmWithTEJDa1d1Qmt5?=
 =?utf-8?B?UG9mdUpjaTNJbzNaVGpvc29KdGVEWjJjaTZCMTJ6YVpROTBBaUQ5YzVuRUN6?=
 =?utf-8?B?YTBxb1NDUG1HZTdWMkRZcFlIUDdpRWdNd1V5MFAwYmxWeXgzTmFDUm1OZlI2?=
 =?utf-8?B?YStoNHI4SG1KZEpaZ3VsVWVDclNxWE1vRisxclJVK2JDN3EzaWt2SjdpLzAz?=
 =?utf-8?B?WFljSjNFaHZzV1p6TjhmZXp2Wk1yaDlGT3pkYmNSWjk5OEc0d2Y5MzhtaEJK?=
 =?utf-8?B?RnVXZGZGWUpKM1hyY3dmblA5a2ZkaFdCZXV4TXhNSUdrZ3F0VkZncDB2RVdP?=
 =?utf-8?B?QWlCQ0ZuRm5BeFliUTBjSWxmSmZSMlRWdzFTbHMwamtKYVBEQnRUZnhWcE1h?=
 =?utf-8?B?NDBpcGdaUGZDNFEwTTVFQXo4Wk5EVlJzQ3pFK0JwMm4ySkhid0dZemV2SFoz?=
 =?utf-8?B?dVhCRlAxY2lNOUJvTSsvY1Q0bnBPeW8yUSt4VURsNXhEZ0xwSGxWUGxKQWVl?=
 =?utf-8?B?dEFRS2dCV2pEK2NwdUNXR3F3bkxieXc5blVvVjBnb2lwVFBMSFBrSlpjaTVZ?=
 =?utf-8?B?TjJMVHdjRzdURnFzdEtvMnowVGZSNlYzOUZoRlFOWTJsdkc4bkVlZWJHeTNT?=
 =?utf-8?B?N2hwcFhlei9ORWJnWE9Mek1LUHBtb1pIeEZYSU5pSU12QW52aVpqSkZ6eFli?=
 =?utf-8?B?UFl1a2xyZVdWbGFGV2pPZDRGYXVxbE53bFR4R0lmTjAvR01oRTFTaW40RlFF?=
 =?utf-8?B?VkE5aTRWS1lROFY1MVh6OSt3K2Z2QWw3eGhENW1hNm5jMU1veEEyR3hmYk1o?=
 =?utf-8?B?OVRyelp0dWcyZXRkdGNGeG1jMzZmUUYrMGRCdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tmx4TXd1V1pPZml0UlU3blFIREl4VUJtcERDUWNJdG1hUWFKSXN2NmhmSU9O?=
 =?utf-8?B?NUtkUFhNWWIrWkZoL2dZbkpEODZLSkZMc3BBRDFaQnhtQWZoUGJkR1I4NDRI?=
 =?utf-8?B?dEdDYXZ6YmxBL3d5dzhXbkdVOXNWRlc1MXlYTms1akdJNjZOVVZYRERNUnRV?=
 =?utf-8?B?dXBlaUhlNjcrZkFQZElFVTVnOWNTL2lXMkpNQmNBcGd3NExWUG1tWEtrbGtF?=
 =?utf-8?B?dElxR05UZGlaU0Q3RVFIREV4SzMvVG1XbFJ4YzNCWGl5MzlrU0VKdVdMMUZr?=
 =?utf-8?B?dU50TExzblhKQlJORW1LSG54SW01c1UyeTlOVUkvalJkSU5NV2pTcUdQdzZ6?=
 =?utf-8?B?bVQ1UVl4Ujl3bDhRaytMNDBkbDVrYlo3d0xMTDZrZUp5U21kREQyQW1BUWJ5?=
 =?utf-8?B?WmhyNTVHVkdqcFRVRGVuRlVyK09DaFNSSVQ1cFBtbURWM1d0TTY5MmRNeWpa?=
 =?utf-8?B?RnRBTmpJTytFaG1vWU9Ca3RINitQQkF5bkdHTy9oOGNPS283SDdPVW9mWDhi?=
 =?utf-8?B?cGFrRFd5OFFpQmU0Z0ErNzBZSzJJdTMvRDV1bWpRRnR6SDRTRzR1dkFCb25P?=
 =?utf-8?B?MktEeDhibWpoSzV1N3NJdGgrM1JSMXlyUFczQzBzVkJPUXZZaHFqN1RRbVRQ?=
 =?utf-8?B?cXhEQ281Uzd5U1FJVDV3djFpMC9VMER6YVNwRHdubFhzaS84czdWYUlkQmRY?=
 =?utf-8?B?QW9tcXgzZGRMbXMzblBCclBqZ05PcGxMM21BcWlRU2w3R2M4MlNZbDc1enRo?=
 =?utf-8?B?VE1WRE5FcGY1NHZuZkdqQnFSRmNMalR2UWFBNkRBemNIeVRVUndSU3ErTFho?=
 =?utf-8?B?SEh5YlNoWjE1WWVwZ2hCNDJOVnhmSndtb0dvbmpxTEFxOWYrYTd5blgxUnds?=
 =?utf-8?B?YlBwanVWa2l4TUMwN3dMQ01FN3VhSnUzLzRCS2ljTEJXSStUMkg5QmRIZ0pn?=
 =?utf-8?B?eFZJZmtaQUNMRjk3VVcyK3g5TGdock4xTFAvek14bUZHSEpNaHVwOWMrbktX?=
 =?utf-8?B?aGhZMDNtVkNZWTNwc0gvOEoxVW43V3JHekNRckNsWnA5MDFZWDkrL3FpVmRI?=
 =?utf-8?B?Q1RIVFZlcjFOMFFSaDIydWtsMU9wNU5zb3lyWm1IZUNYTDdQZFR2dzFRSjhw?=
 =?utf-8?B?U2MzRTMzNmxXMGt1bE1ET2Y1clZCVU9ZVjZ1MVkvOUk3azRRNHoxOU1oMGdM?=
 =?utf-8?B?T2FmeGlhcWNzWFl4ZWlJOE8rQjhsZm50UGw4SVFqSVZxMCtTTFczTUlpMEQz?=
 =?utf-8?B?a09XbHZkamphUDBjMkFwZXVRbnZ3THpqREJZcUUveHFBRHFoVVV3QnBjcXZV?=
 =?utf-8?B?cG1iNi9qRDdJL01ETXlxTnhuZ3A3a2I5SUVrRzd5dk50NzlicS90djc4bFBQ?=
 =?utf-8?B?MW9vRUlsekhaSHNpZTBjQ0dwUDRoQXc4aVRqSGh3TjFCRTE5dSt1MVNqWUNa?=
 =?utf-8?B?SzYxUjFuRmg2WFd5NE5nL1dpcm1waTlkQ2haRXdoTEdZaHdMY24rZVBMNlFl?=
 =?utf-8?B?cVU0MWo0aGorWFBURndOYUF0TkZWMWpGS3BNbnNoaDJRc2gzbTB6a2kyN0Fr?=
 =?utf-8?B?cWxEakdqYmFRdk9IYmtMMHhzaGRwS1RTUDBBazh5SDRvMVZORTZ4c1pSTEtq?=
 =?utf-8?B?MGRZTTlZRWJoYkZZNVkrVDMzNnlMTWxTcFRPOVdUaHdKa3B2MnNBc3YvRDNE?=
 =?utf-8?B?VzFzUmd4dFpTQ1VlTjB5MndQRkhkUWxCVEwvQTBGRDI0UWRWUkZiZFN6RHZX?=
 =?utf-8?B?YU1KcXdtZUpFUVpMMk90aFFVdkl3ZUw3ZVZURStwcS92VkpWcnFIZEFjU2RH?=
 =?utf-8?B?eVV6QUQwdzFSdG5yQWhDdnFHRVgvT0ZOYjNXYXNrUTkweEdFM1NsOE1aYmhm?=
 =?utf-8?B?SU5JQnlmaDFoL2p3VVBzd2JnMmZIWDFnRUtxeWxRUnZlbXYrYW5QeDRaQWdI?=
 =?utf-8?B?a1Mxa21ldEhPeTBEVzE0SDJFYlFrWGswREo3V2J4OHVzbDVkL1lDdXVoYUhZ?=
 =?utf-8?B?ZU9wZXNLUkhGb1VscFRSeVNETEpKYWF1SUFLcCtjUWZPMU5UVm44bEJmazEx?=
 =?utf-8?B?cXNPeWJUdktwUThqMjhEOGo5OXB5UUU5ODJKT0xzWkQzWW1ZeWEvWVV0NndP?=
 =?utf-8?Q?OdTB0OQuycCBsMAHKAimmotEB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe3e404-a101-41dc-abd2-08de3088c8f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 03:21:57.8644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnxC2TiDI+i1yoGLvO+lxLxGbb6ret3YaIKTedY4/SyxcGjbDomW03b3EReZ+OvvJ1ccIS8VOsa0SIejDjFsjMF0y0HSrocZDIxO9KXR0MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMTcv
MjNdIHZmaW8vbGlzdGVuZXI6IEJ5cGFzcyByZWFkb25seSByZWdpb24gZm9yIGRpcnR5DQo+dHJh
Y2tpbmcNCj4NCj5IZWxsbyBaaGVuemhvbmcsDQo+DQo+T24gMTEvMjgvMjUgMDM6MDgsIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIFlpLCBDZWRyaWMsDQo+Pg0KPj4gQ291bGQgeW91IGFs
c28gaGVscCBjb21tZW50IG9uIHRoaXMgcGF0Y2g/IFRoaXMgaXMgYSBwdXJlIFZGSU8gbWlncmF0
aW9uDQo+cmVsYXRlZCBvcHRpbWl6YXRpb24sIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gbGV0IGl0
IGdvIHdpdGggdGhlICJ2ZmlvOiByZWxheCB0aGUNCj52SU9NTVUgY2hlY2siIHNlcmllcy4NCj4+
IEknZCBsaWtlIHRvIG1vdmUgaXQgaW4gbmV4dCByZXNwaW4gb2YgInZmaW86IHJlbGF4IHRoZSB2
SU9NTVUgY2hlY2siIHNlcmllcyBpZg0KPnlvdSB0aGluayBpdCBtYWtlIHNlbnNlLg0KPg0KPklN
TywgdGhlICJ2ZmlvOiByZWxheCB0aGUgdklPTU1VIGNoZWNrIiBpcyBmaW5lIGFzIGl0IGlzLg0K
Pg0KPkkgd291bGQgaW5zdGVhZCBpbnRyb2R1Y2UgYSBuZXcgc2VyaWVzIHRvIGhhbmRsZSBFUlJB
VEFfNzcyNDE1DQo+c2luY2UgaXQgaXMgYSBzcGVjaWFsIGNhc2Ugb2YgImludGVsX2lvbW11OiBF
bmFibGUgZmlyc3Qgc3RhZ2UNCj50cmFuc2xhdGlvbiBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlIi4N
Cj4NCj5TbyB3ZSB3b3VsZCBoYXZlIDMgc2VyaWVzIChpbiBvcmRlciBvZiBhcHBlYXJhbmNlIG9u
IHRoZSBsaXN0KSA6DQo+DQo+MS4gInZmaW86IHJlbGF4IHRoZSB2SU9NTVUgY2hlY2siDQo+Mi4g
ImludGVsX2lvbW11OiBFbmFibGUgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gZm9yIHBhc3N0aHJv
dWdoDQo+ICAgICBkZXZpY2UiIHdpdGhvdXQgcXVpcmtzDQo+My4gInZmaW86IGhhbmRsZSBFUlJB
VEFfNzcyNDE1IiB3aXRoIHRoZSBxdWlyayBwYXJ0LCBzbyB0aGF0J3MNCj4gICAgcGF0Y2ggMTcs
MTksMjAsMjEgPw0KPg0KPg0KPlNlcmllcyAyIHNlZW1zIHRoZSBtb3N0IGltcG9ydGFudCwgYXMg
aXQgc2V0cyB0aGUgZm91bmRhdGlvbg0KPmZvciB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJlcyB3aGlj
aCBoYXZlIGEgbmVlZCBmb3IgbmVzdGVkDQo+SU9NTVUgc3VwcG9ydCAoc21tdS9udmlkaWEpLiBT
ZXJpZXMgMSBpcyBuaWNlIHRvIGhhdmUuDQo+U2VyaWVzIDMuIGlzIGFuIGV4dGVuc2lvbiBvZiAy
LiBmb3IgYnJva2VuIEhXLg0KDQpHb29kIHN1Z2dlc3Rpb24gdG8gc3BsaXQgb3V0IEVSUkFUQV83
NzI0MTUgZnJvbSB0aGUgYmFzZSBuZXN0aW5nIHNlcmllcy4NClRoZXJlIGlzIHNvbWUgY29kZSBp
biBwYXRjaDE3IHdoaWNoIGlzIG5lZWRlZCBieSBFUlJBVEFfNzcyNDE1LA0KaXQgbWFrZXMgc2Vu
c2UgdG8gbW92ZSBpdCB0byBFUlJBVEFfNzcyNDE1IHNlcmllcy4NCg0KPg0KPkZvciB0aGUgbmV4
dCBpdGVyYXRpb25zIChRRU1VIDExLjApLCBsZXQncyBnZXQgc2VyaWVzIDIuIGluDQo+Zmlyc3Qu
IEkgaGF2ZSBiZWVuIGluY2x1ZGluZyBpdCBpbiBteSBRRU1VIHRyZWUgZm9yIGEgd2hpbGUNCj5u
b3cgSSBkaWRuJ3Qgc2VlIGFueSByZWdyZXNzaW9uLiBTaG91bGQgYmUgZmluZS4NCj4NCj5UaGVu
LCB3ZSBjYW4gbWVyZ2UgMS4gYW5kIDMuIHRocm91Z2ggdGhlIHZmaW8gcXVldWUuIFNob3VsZG4n
dA0KPmJlIGEgbWFqb3IgdGFzayBub3cgdGhhdCB3ZSBoYWQgYWxsIHRoZXNlIHJldmlld3MuDQo+
DQo+SG93J3MgdGhhdCA/DQoNCkdvb2QgZm9yIG1lLg0KVGhlbiBJJ2xsIHNlbmQgc2VyaWVzMiwg
dGhlbiBzZXJpZXMxLCBmaW5hbGx5IHNlcmllczMgaW4gb3JkZXIuDQoNCkknZCBsaWtlIHRvIHdh
aXQgYSBmZXcgZGF5cyB0byBjb2xsZWN0IGNvbW1lbnRzIGJlZm9yZSBzZW5kaW5nIHY5IG9mIHNl
cmllczINCmJlY2F1c2UgdGhlIHNwbGl0IG9mIHNlcmllczIgYW5kIHNlcmllcyAzIGludm9sdmVz
IG9ubHkgcGF0Y2ggcmVvcmRlciBhbmQNCm5vIGNvZGUgY2hhbmdlcy4NCg0KPg0KPg0KPmJ0dywN
Cj4NCj4gICBSZWZlcmVuY2UgZnJvbSA0dGggR2VuIEludGVsIFhlb24gUHJvY2Vzc29yIFNjYWxh
YmxlIEZhbWlseQ0KPlNwZWNpZmljYXRpb24NCj4gICBVcGRhdGUsIEVycmF0YSBEZXRhaWxzLCBT
UFIxNy4NCj4NCj5odHRwczovL2VkYy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGVzaWdu
L3Byb2R1Y3RzLWFuZC1zb2x1dGlvbnMvcHINCj5vY2Vzc29ycy1hbmQtY2hpcHNldHMvZWFnbGUt
c3RyZWFtL3NhcHBoaXJlLXJhcGlkcy1zcGVjaWZpY2F0aW9uLXVwZGF0ZS8NCj4NCj5VcmwgaXMg
bm90IGFjY2Vzc2libGUgKGZvciBtZSkuDQoNCk1lIHRvbywgd2lsbCB1cGRhdGUuIGh0dHBzOi8v
Y2RyZHYyLmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50Lzc3MjQxNSBpcyBhY2Nlc3NpYmxlIGZv
ciBtZSBub3cuDQoNCkJScywNClpoZW56aG9uZw0K

