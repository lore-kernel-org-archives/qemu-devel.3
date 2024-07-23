Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7B6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Y0-0004Kl-0o; Tue, 23 Jul 2024 03:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW9Xy-0004KF-Jt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:02:54 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW9Xv-0000hS-Ex
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721718172; x=1753254172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kPOlIE+Uf6x0E+Ztuh29/PhIrHeoAme+RQgkzFSkMd0=;
 b=jrY/MxLf1T9Q8H8ViCqvIPyKMNJWKYMTYTmLYG1gB90+ZNrEV0J+MoEL
 NYQRe0Rb/E7Vt22dSJsvFAXXqgPtLQWWRzqs/7ZfnLkXbw8oqdw5wAb6H
 R42J4ZRPBzXvVRDDTWhCuRN3UfAul0J55gdpsbFpRDEeQgOsYuf8td87x
 bn+7NJc0kLHEpnmfwAVKOfhbfHqZEvEcooawbJj2/jRzfYbTDCcatD00v
 Z55EvO2+RNsaAT3lQigWqDMyv00lWl+ucIwPqZ3hEe9xSwCmQclhpVYmt
 QU6YQFZhRaaOM9AKfPmmnteadUxcnSKKu6rHV1+3oNoGXooGCnLuPQgY+ w==;
X-CSE-ConnectionGUID: fStGrP3rRKCpqdwHZ48l+g==
X-CSE-MsgGUID: ClInEkJ1RrW464FnqrTCvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="41850894"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="41850894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 00:02:48 -0700
X-CSE-ConnectionGUID: J6DMWsRuSUuMLzEmvU8wWw==
X-CSE-MsgGUID: eYzExC8CSvaiXYQMpsDZRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="56971544"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 00:02:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 00:02:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 00:02:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 00:02:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 00:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/X2ptCT3SdP9i8ktKg3QHg5OHOxrw/JpRNnsp8cHk/9Ubfq//EEkQNuc7sWFGYphheF92GJu5gpHq8Hqsrxu8ECXYoUJIhhWBTXGBFElQ8ZK3JuGXn1CSbGX0WdY6tQ2h+WUHYYcYTgxUh0eK6pPwvFDBBS1SwBMWSXN0IOu5kwl3uTAImDkrB/HgBs3ONT+c15nJfhS8QvwCdCNcF6YmAwIxMHmAOPDXyv1b/0QTp4h09xH3OmRKSJhg/VbH48l5aaTn812qIzU58CIB3AvcKWafjZUsb+Hfe920Zu+UfUrOH0STa05TWgDLOvz5+qADun8+Kht8GX4fsd26XMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPOlIE+Uf6x0E+Ztuh29/PhIrHeoAme+RQgkzFSkMd0=;
 b=xY/ohVMh89ppMc/v4UyImPlWngPYqk4kUiBBiw5nMxTR7UhCNzVRjpQSuxbKE59bndjnjdbtnc+W3zJwef9Q6ZbCXVI8r8uh+Tzs+JELShTbYGNvG63abtn2aqKi/y/l111HpoO7qV5ewKZubGCpQwyXefmvdFzQ4VgZoVc1hYjtpoE0U7rPNdHPxqk4NH44AAoQBWYf+gpiIIUpNlmC3Tl6XyL+EZaXa5qw5QUuQMOfgJFsXm31e4Ct2t8yLr2lDHLphB6yykBtr4OEKa+aY/GjjsW4FfKUNfb2yz45567G8UQpugSyIuum7UmVsxeeW8ZWWXnf41fDo/Pz4IE5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 07:02:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:02:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Topic: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Index: AQHa3HwbkOv4L/RGkU2FXdaMlUqNeLIDxF8ggAARj4CAAAw6gIAAAQRA
Date: Tue, 23 Jul 2024 07:02:38 +0000
Message-ID: <SJ0PR11MB6744E4FE087F0991E1DB69A892A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <SJ0PR11MB6744237AD1896B5EFA8E045B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <88eaa782-9221-4fce-90ad-353487cae649@oracle.com>
 <0557ef54-475a-4512-b755-75610a2fcab9@redhat.com>
In-Reply-To: <0557ef54-475a-4512-b755-75610a2fcab9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4859:EE_
x-ms-office365-filtering-correlation-id: c294898c-bb5c-447d-648a-08dcaae56ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZTlLSDU0Q014KytpN0FXeW81YkZOUWVjQXdvdzZNWGF4RXh6aWRGYjJqYTFN?=
 =?utf-8?B?d3Z6aU4reXFMZEV3emM5dUJvRjJKMlR6RzlFcXdTUUEwa0swVms4TnJ5cmRO?=
 =?utf-8?B?cU9YMXRXZWdZQi9tb3pqYnpSdVJoM2E4aGZlNFFVZ2dVUG4wZVJ6UHBOWnpE?=
 =?utf-8?B?Z2VSS0ZqWm9pZkJFYitlcytnVjlwYXdpWW9WQyt1QnZMLytiK2RpMmRFUTdt?=
 =?utf-8?B?UXNscTdnaVIrbVQ2TWZlSTdYTmo0QXhKQllJeERRSHNVd2tpcEhIOGxSTThR?=
 =?utf-8?B?UmExZGxNTXZsdEJqWWc0OXE1TFQzRzd2cEo3aUdoVU10K2RyaW9HWW5FY2Jx?=
 =?utf-8?B?U2hPMUpsRGxuSEtRaWt5d0FwRG1sTytoMWJzQ0xvamhmWm1sdFdQTVJFNUpm?=
 =?utf-8?B?UVRvS0tyY2NiNmU4M3BwYzkrV29VYjZmMTEvWDNTaVM3b0gxVU1pYmM2c2x4?=
 =?utf-8?B?WGNkdHJ1QnI0aXFYdDFkVUFBVHBIT0Q0T0pyU1pmRkNQeWFQOWNNOHNXcVlM?=
 =?utf-8?B?aGVjUVRqVFBOTHlzeGRxSWtCQnVhRkh3RGxFMzZOc0h1WlJYRk4reUdPQ2px?=
 =?utf-8?B?T0NRaWI3YVR0RkJ4ZEVIQ0UyUDBwdStJV05LZmZQOG1qeGpEb1BWU2VtTFhF?=
 =?utf-8?B?azBibHJmdW1UU2t1UldXNHF3WUxUcEQrWGlmcDBtSUhRM080cHNqeCtVaVNv?=
 =?utf-8?B?b202eHBOU09iR04zMlRMNjhSWUhVVzRvd0ZUOGxMQ1JkWG9ESGNiK3lOVXph?=
 =?utf-8?B?dC80SFU3OC9xMkgvbUZBY1dIOXhWUVFTRjc5RFY3N3NYUVkwci9YVlJRRSt0?=
 =?utf-8?B?WEFFNmxHaG5va1JPb1E3Q2pMU0lNTDdWVE14NU9Mbkw1d3pKTmtvZk1CUk1R?=
 =?utf-8?B?YTBUTlpmYm44YkZ1aGdPemp1bnc5SnFOWGsrTjJSalpxQUtoVVUzSHNEbGw4?=
 =?utf-8?B?bTB3UDNxc2ZtWUVqK0pVeVVpTUxmOEplS3Bscmt6WThiZGlQMnlNUHVxaUwy?=
 =?utf-8?B?ZnJUVXRzcjJHamRTOGVNMWpjMGh0Q1VZS1M0KytmMTZwMkh4YVlJb3hiR0Iz?=
 =?utf-8?B?c3hxbDR6WGh0NmJGaUE1TXd2dEFsN1Zqd2RJSktTK2pxbnFWcHRubStXMWRW?=
 =?utf-8?B?akc4blU0NmczWnVxRkVTTExmOHVmWWJ4c2FLYnYxUURHdGJJSzZDeEU4VUJP?=
 =?utf-8?B?Zml0YkVhVVZHNjd1RFNSd20yNVF1aTFxYnBpTU9xcllRUjM3Skt0UlJxYlAz?=
 =?utf-8?B?TmU3MTZXelZrbGpUTGNsU3VQRUZZWDNTdmJTNk5jQXk0YjdYV3BLbFB5WU90?=
 =?utf-8?B?V1VTMnU4RnEzOHlYQ0h5Z1N5VG1Vd1QrOHY0eXlZVEY2SWJ0WlIwYzJzdXdK?=
 =?utf-8?B?SXZXUFJBVlZ5MlhReTQrOVA1UTN4ZFNCL0xWZUhSQmJSN3VvWHNjR0hrZ3ZN?=
 =?utf-8?B?Z2w1RDEvMHZNWkdPRG1VRUZyRThwQUNyS1dvZE5OV3QyT1J4VVgzM2w2RjdJ?=
 =?utf-8?B?NE9kb1EzSGhKRkQ4aytjZ1ZxakRSNHNnc2ZMQkh3ZUNIU1cwUmwyT0xXUzVh?=
 =?utf-8?B?eERNQVYzKzZiYUV6TTdLeGtNM0FEVVlQK3hhY3B5d2xPS0FxekVyc2xFbHNq?=
 =?utf-8?B?Q0RtZHVVWFJWVHF0QnBzUzhOV0tUa3hmZUdBMTVyMlo1MHZ0MFN5Sm9SdXNN?=
 =?utf-8?B?NEFqeFhyOEFPVS9xYWg4R1NYMm8xUms4SFRweVJhSVlNQjV1eEJHYnE5TTNU?=
 =?utf-8?B?K0hYK3ZJWVZCWUlxVmM3YzBSUkdRUmZnZ3JHQ1VtSE0yV00vZUJ1dGJPLzNL?=
 =?utf-8?B?eEdFUjF1blREYmFHTHBoc0RhQkQ1cDFTZlBqT0Y5bUtqMHJITTZiTlVGZTBS?=
 =?utf-8?B?NGMrVXo1Q3Z6cjQ0UTJxTHZOYjdYZ1VscFFpV29pM2F1RHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWxKb29jVHo2emYvbjFLNlcrMXJNcG1ZVzJ2TnVRRzhweGVmQ1diN2loR3Ri?=
 =?utf-8?B?Z1FhenlxdWpKKzhtTlF1djFmTmxxRG1SMDUzM3lXMHZZTnVmbG9nUjlIdkVQ?=
 =?utf-8?B?ZC81NzAvcUV2TW9xS2l4c2tZVjhTRkVpK0FlYU51Ykk3UEU2S0Q2Z0NNMzNR?=
 =?utf-8?B?TlErb0FzL1BQUGJranhsSCsyVkFOSUd4VElDZ0VQOWswTjlXNlRuQ3lzcHBJ?=
 =?utf-8?B?eExmTm5MQWI0Y2wxUDd6UEJ0NlRhMEh3U2ZoZXNLQ2NSVVBOOVYyRzJQU0My?=
 =?utf-8?B?ak5kUzFNVS9hUW1vaDIxWmRaY0h3UTl3VmJSMnEyNkRubEpMMmhMUDRacEZI?=
 =?utf-8?B?RTNvMVp2R0NRdnZrSDExNUtna0tIek0wVHFDYWhtM0d4TXJVd0JtSkM4Z2Ja?=
 =?utf-8?B?eFQ2THZkakJLTUhxMUpvbzJvTWhNa29zckhYNXgrTjZqekZXMnk2NGpBamd6?=
 =?utf-8?B?aEpDNUczVHZVbm56bVNZZnVFTjBudDE3V0I5NGJlaG95S05sNTNONThjeXlo?=
 =?utf-8?B?bHQrMVREWldCQWkrMnkyOEszQmJEbWxQaGxmbFk5U0RDUCtGOWI0L3M3K0g2?=
 =?utf-8?B?TGJmem5FQ3pyTzE5aWw1TnNGbTlqL21scFJUSDB5RWtYSUxSaEw2dzRFVllU?=
 =?utf-8?B?TU5oWkMwQVpnKzVPMHNzNW13ZTBFSVJNT3pHVmhoUDlNSVNXZXB1aVFjckc0?=
 =?utf-8?B?bmdCazVtOGY0L2lCb0VZRFJ2am5aTGpGTWswbHFTWjZ5U1A5cC9QSm1vWkps?=
 =?utf-8?B?d3ZEeFUxMUpHTFdXRXZEUEZudy9ja0owWUpqWUc5eFFNSVM2Nk1TMC81VFdK?=
 =?utf-8?B?QXkwbFVmcFdnTExXeE5jaGpsS04zajdUQktrdHJuNklpVk4zY1Q3NHRlQ0Rz?=
 =?utf-8?B?YXdjUWxlYlNNcGszQ2NMRGN1empSYitISE81Zk1KOWUxN0dZZHAxdG82TTRE?=
 =?utf-8?B?Y0FNVUY5Tzh0aTYvT0p0Z3VIOUYyMjk4ajN1RGQ1SDZtWXM0KzBGbnVyNGM1?=
 =?utf-8?B?YzFVRE0yL0V6ZEFpamcrQ1lxelByc3Nqakx6cHJMclJwdGF5ZFY2aHRMSTY1?=
 =?utf-8?B?bWEzZ3dWQ1E0T25QRCsvOU1rUyt4RXN3RGF1RlRUN1FudzFpeWpqbFBPdHhT?=
 =?utf-8?B?ckVsT0RwdzFaRWlzRDA0MmNJNkt0dy9TMkZCMmh3bThyUDFjUFl0OW5CS0Uw?=
 =?utf-8?B?RkVnSDMxNi8zeWlGTDVEYjRsd1BSMHVuZStWSXFZTUZlbE4rbzJoaVF2bEk1?=
 =?utf-8?B?U0ZoY1I1MmxmbGl4S0xtN2lSbkNBM2xQL3VoTXFQcGZQODZYWjF3R2FQcUtC?=
 =?utf-8?B?eXAyYVgvTmt1SysraWkrRTFWcUVObVNVUnRoSnFXN29DeUtZbGtlVzQ0cVNW?=
 =?utf-8?B?UDRqbzJmemZUNHdzMzE1N2t5bmdDZS9uc1lMZGVBenp6UVVEYkpIMmVtSENJ?=
 =?utf-8?B?Tzl5dk9XdHhxL3RUbmpSWXFaeWZUTjlJenc1SGhyb2RCOWFzNDFTNG5VenRS?=
 =?utf-8?B?UEhURDkrYUMyeUNLaVVsakpNK0ZtZ2hJTWZyOFFMQmxHU1k2QVVMTWpCS1dv?=
 =?utf-8?B?SGlnUEZmN0Y1Q2xaTWpFNWI3Qys4Y1hycHA2aDZ6VUZnU295bWlwYWpNWG5V?=
 =?utf-8?B?YWJvUmRPMTVrb2ovdk4vUVdWOEVNRWFZYU8zNFRwaTlxbWtmYmxqanY2Qjhq?=
 =?utf-8?B?N3hPdnhSUjlvWjlCZTBuYlhCU1N3Z1V0b2ViNm5hZEN3UGdTYXRTYTRYY3Er?=
 =?utf-8?B?VW9vUjJkN3l0RlF6bTR3MFV1Rm9iS0MyTjRPWnEzSUZRb2tnbGJDU1dRL2lx?=
 =?utf-8?B?OWt5MkNieDMwQTN1N3pBOEpTYmhaZzYySTNBc2xpUnBtN1ozWGc3NDRVeDE1?=
 =?utf-8?B?Q1pLc0xOeWV3dm1hQ1N2WE1OenhvY2FDRDA4aUlUcXd2QUdnd2lvSzNUVDdO?=
 =?utf-8?B?cW1ZZTh1bmQ1TjI1VE0yY2J0UUJ3bnFISHoxem5nekhvSWxZOS9zeFhBTEJF?=
 =?utf-8?B?RjljenNFcHhRTHNxTDNtbEZBREpkRzBWQXUyMzYvcElBZmY3UkhMeG81UFBS?=
 =?utf-8?B?SGhaeWp0SEp1eDFnaUZrZnhqOGErRHhreXQ1OGorMGhHMDdxMXdDQzRGZTZD?=
 =?utf-8?Q?7V2tBUPCRp35A4wkiWQHxc+FD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c294898c-bb5c-447d-648a-08dcaae56ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:02:38.2067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh7J6dP5rle2xeRs5N6dqI9w2n8P/0/f6vGRc+/ZKuKPl+7CZbXiF5PcjG8Y+YHu/yGKwZeR2lvuU6rh0vT3l8waLEPY+Vg/hSUKvMjmoxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDUvOV0gdmZpby9pb21t
dWZkOiBQcm9iZSBhbmQgcmVxdWVzdCBod3B0IGRpcnR5DQo+dHJhY2tpbmcgY2FwYWJpbGl0eQ0K
Pg0KPk9uIDcvMjMvMjQgMDg6MTMsIEpvYW8gTWFydGlucyB3cm90ZToNCj4+IE9uIDIzLzA3LzIw
MjQgMDY6MTEsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbT4NCj4+Pj4gU3ViamVjdDogW1BBVENIIHY2IDUvOV0gdmZpby9pb21tdWZk
OiBQcm9iZSBhbmQgcmVxdWVzdCBod3B0IGRpcnR5DQo+Pj4+IHRyYWNraW5nIGNhcGFiaWxpdHkN
Cj4+Pj4NCj4+Pj4gSW4gcHJlcGFyYXRpb24gdG8gdXNpbmcgdGhlIGRpcnR5IHRyYWNraW5nIFVB
UEksIHByb2JlIHdoZXRoZXIgdGhlDQo+SU9NTVUNCj4+Pj4gc3VwcG9ydHMgZGlydHkgdHJhY2tp
bmcuIFRoaXMgaXMgZG9uZSB2aWEgdGhlIGRhdGEgc3RvcmVkIGluDQo+Pj4+IGhpb2Q6OmNhcHM6
Omh3X2NhcHMgaW5pdGlhbGl6ZWQgZnJvbSBHRVRfSFdfSU5GTy4NCj4+Pj4NCj4+Pj4gUWVtdSBk
b2Vzbid0IGtub3cgaWYgVkYgZGlydHkgdHJhY2tpbmcgaXMgc3VwcG9ydGVkIHdoZW4gYWxsb2Nh
dGluZw0KPj4+PiBoYXJkd2FyZSBwYWdldGFibGUgaW4gaW9tbXVmZF9jZGV2X2F1dG9kb21haW5z
X2dldCgpLiBUaGlzIGlzDQo+YmVjYXVzZQ0KPj4+PiBWRklPRGV2aWNlIG1pZ3JhdGlvbiBzdGF0
ZSBoYXNuJ3QgYmVlbiBpbml0aWFsaXplZCAqeWV0KiBoZW5jZSBpdCBjYW4ndA0KPnBpY2sNCj4+
Pj4gYmV0d2VlbiBWRiBkaXJ0eSB0cmFja2luZyB2cyBJT01NVSBkaXJ0eSB0cmFja2luZy4gU28s
IGlmIElPTU1VDQo+c3VwcG9ydHMNCj4+Pj4gZGlydHkgdHJhY2tpbmcgaXQgYWx3YXlzIGNyZWF0
ZXMgSFdQVHMgd2l0aA0KPj4+PiBJT01NVV9IV1BUX0FMTE9DX0RJUlRZX1RSQUNLSU5HDQo+Pj4+
IGV2ZW4gaWYgbGF0ZXIgb24gVkZJT01pZ3JhdGlvbiBkZWNpZGVzIHRvIHVzZSBWRiBkaXJ0eSB0
cmFja2luZyBpbnN0ZWFkLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2FvIE1hcnRpbnMg
PGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBpbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb21tb24uaCB8ICAyICsrDQo+Pj4+IGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAg
ICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZp
by1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPj4+PiBjb21tb24uaA0KPj4+PiBp
bmRleCA0ZTQ0YjI2ZDNjNDUuLjFlMDJjOThiMDliYSAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmgNCj4+Pj4gQEAgLTk3LDYgKzk3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgSU9NTVVGREJh
Y2tlbmQNCj5JT01NVUZEQmFja2VuZDsNCj4+Pj4NCj4+Pj4gdHlwZWRlZiBzdHJ1Y3QgVkZJT0lP
QVNId3B0IHsNCj4+Pj4gICAgICB1aW50MzJfdCBod3B0X2lkOw0KPj4+PiArICAgIHVpbnQzMl90
IGh3cHRfZmxhZ3M7DQo+Pj4+ICAgICAgUUxJU1RfSEVBRCgsIFZGSU9EZXZpY2UpIGRldmljZV9s
aXN0Ow0KPj4+PiAgICAgIFFMSVNUX0VOVFJZKFZGSU9JT0FTSHdwdCkgbmV4dDsNCj4+Pj4gfSBW
RklPSU9BU0h3cHQ7DQo+Pj4+IEBAIC0xMzksNiArMTQwLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJ
T0RldmljZSB7DQo+Pj4+ICAgICAgT25PZmZBdXRvIHByZV9jb3B5X2RpcnR5X3BhZ2VfdHJhY2tp
bmc7DQo+Pj4+ICAgICAgYm9vbCBkaXJ0eV9wYWdlc19zdXBwb3J0ZWQ7DQo+Pj4+ICAgICAgYm9v
bCBkaXJ0eV90cmFja2luZzsNCj4+Pj4gKyAgICBib29sIGlvbW11X2RpcnR5X3RyYWNraW5nOw0K
Pj4+PiAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZDsNCj4+Pj4gICAgICBpbnQgZGV2aWQ7DQo+
Pj4+ICAgICAgSU9NTVVGREJhY2tlbmQgKmlvbW11ZmQ7DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IGluZGV4IDIzMjRiZjg5MmM1
Ni4uN2FmZWEwYjA0MWVkIDEwMDY0NA0KPj4+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4+
PiArKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+PiBAQCAtMTEwLDYgKzExMCwxMSBAQCBzdGF0
aWMgdm9pZA0KPj4+PiBpb21tdWZkX2NkZXZfdW5iaW5kX2FuZF9kaXNjb25uZWN0KFZGSU9EZXZp
Y2UgKnZiYXNlZGV2KQ0KPj4+PiAgICAgIGlvbW11ZmRfYmFja2VuZF9kaXNjb25uZWN0KHZiYXNl
ZGV2LT5pb21tdWZkKTsNCj4+Pj4gfQ0KPj4+Pg0KPj4+PiArc3RhdGljIGJvb2wgaW9tbXVmZF9o
d3B0X2RpcnR5X3RyYWNraW5nKFZGSU9JT0FTSHdwdCAqaHdwdCkNCj4+Pj4gK3sNCj4+Pj4gKyAg
ICByZXR1cm4gaHdwdCAmJiBod3B0LT5od3B0X2ZsYWdzICYNCj4+Pj4gSU9NTVVfSFdQVF9BTExP
Q19ESVJUWV9UUkFDS0lORzsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiBzdGF0aWMgaW50IGlvbW11
ZmRfY2Rldl9nZXRmZChjb25zdCBjaGFyICpzeXNmc19wYXRoLCBFcnJvciAqKmVycnApDQo+Pj4+
IHsNCj4+Pj4gICAgICBFUlJQX0dVQVJEKCk7DQo+Pj4+IEBAIC0yNDYsNiArMjUxLDE3IEBAIHN0
YXRpYyBib29sDQo+Pj4+IGlvbW11ZmRfY2Rldl9hdXRvZG9tYWluc19nZXQoVkZJT0RldmljZSAq
dmJhc2VkZXYsDQo+Pj4+ICAgICAgICAgIH0NCj4+Pj4gICAgICB9DQo+Pj4+DQo+Pj4+ICsgICAg
LyoNCj4+Pj4gKyAgICAgKiBUaGlzIGlzIHF1aXRlIGVhcmx5IGFuZCBWRklPIE1pZ3JhdGlvbiBz
dGF0ZSBpc24ndCB5ZXQgZnVsbHkNCj4+Pj4gKyAgICAgKiBpbml0aWFsaXplZCwgdGh1cyByZWx5
IG9ubHkgb24gSU9NTVUgaGFyZHdhcmUgY2FwYWJpbGl0aWVzIGFzIHRvDQo+Pj4+ICsgICAgICog
d2hldGhlciBJT01NVSBkaXJ0eSB0cmFja2luZyBpcyBnb2luZyB0byBiZSByZXF1ZXN0ZWQuIExh
dGVyDQo+Pj4+ICsgICAgICogdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIG1heSBkZWNpZGUgdG8g
dXNlIFZGIGRpcnR5IHRyYWNraW5nDQo+Pj4+ICsgICAgICogaW5zdGVhZC4NCj4+Pj4gKyAgICAg
Ki8NCj4+Pj4gKyAgICBpZiAodmJhc2VkZXYtPmhpb2QtPmNhcHMuaHdfY2FwcyAmDQo+Pj4+IElP
TU1VX0hXX0NBUF9ESVJUWV9UUkFDS0lORykgew0KPj4+PiArICAgICAgICBmbGFncyA9IElPTU1V
X0hXUFRfQUxMT0NfRElSVFlfVFJBQ0tJTkc7DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICAg
ICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpb21tdWZkLCB2YmFzZWRldi0+ZGV2
aWQsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250YWluZXIt
PmlvYXNfaWQsIGZsYWdzLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSU9NTVVfSFdQVF9EQVRBX05PTkUsIDAsIE5VTEwsDQo+Pj4+IEBAIC0yNTUsNiArMjcxLDcg
QEAgc3RhdGljIGJvb2wNCj4+Pj4gaW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2
aWNlICp2YmFzZWRldiwNCj4+Pj4NCj4+Pj4gICAgICBod3B0ID0gZ19tYWxsb2MwKHNpemVvZigq
aHdwdCkpOw0KPj4+PiAgICAgIGh3cHQtPmh3cHRfaWQgPSBod3B0X2lkOw0KPj4+PiArICAgIGh3
cHQtPmh3cHRfZmxhZ3MgPSBmbGFnczsNCj4+Pj4gICAgICBRTElTVF9JTklUKCZod3B0LT5kZXZp
Y2VfbGlzdCk7DQo+Pj4+DQo+Pj4+ICAgICAgcmV0ID0gaW9tbXVmZF9jZGV2X2F0dGFjaF9pb2Fz
X2h3cHQodmJhc2VkZXYsIGh3cHQtPmh3cHRfaWQsDQo+ZXJycCk7DQo+Pj4+IEBAIC0yNjUsOCAr
MjgyLDExIEBAIHN0YXRpYyBib29sDQo+Pj4+IGlvbW11ZmRfY2Rldl9hdXRvZG9tYWluc19nZXQo
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4+ICAgICAgfQ0KPj4+Pg0KPj4+PiAgICAgIHZiYXNl
ZGV2LT5od3B0ID0gaHdwdDsNCj4+Pj4gKyAgICB2YmFzZWRldi0+aW9tbXVfZGlydHlfdHJhY2tp
bmcgPQ0KPj4+PiBpb21tdWZkX2h3cHRfZGlydHlfdHJhY2tpbmcoaHdwdCk7DQo+Pj4NCj4+PiBE
b24ndCB3ZSBuZWVkIHRvIGRvIHNhbWUgaWYgYXR0YWNoIHRvIGV4aXN0aW5nIGh3cHQ/DQo+Pj4N
Cj4+DQo+PiBOaWNlIGNhdGNoIQ0KPj4NCj4+IFllcywgd2UgZG8gbmVlZCBpdCBlLmcuIHdlIHdp
bGwgbmVlZCB0aGlzIGZpeCB1cCBmbyB0aGlzIHBhdGNoDQo+DQo+DQo+Rml4ZWQgb24gdmZpby05
LjEuDQoNCkZlZWwgZnJlZSB0byBhZGQgbXkgUkIsDQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcg
RHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+
DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8v
aW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IDkyYjk3NjQ2NDI4My4uODMz
YTc0MDA0ODZjIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3
L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtMzA1LDYgKzMwNSw3IEBAIHN0YXRpYyBib29sDQo+aW9t
bXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICAgICAg
ICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgICAgICB2YmFzZWRldi0+aHdwdCA9IGh3cHQ7DQo+
PiAgICAgICAgICAgICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZod3B0LT5kZXZpY2VfbGlzdCwgdmJh
c2VkZXYsIGh3cHRfbmV4dCk7DQo+PiArICAgICAgICAgICAgdmJhc2VkZXYtPmlvbW11X2RpcnR5
X3RyYWNraW5nID0NCj5pb21tdWZkX2h3cHRfZGlydHlfdHJhY2tpbmcoaHdwdCk7DQo+PiAgICAg
ICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gICAgICAgICAgIH0NCj4+ICAgICAgIH0NCj4+DQoN
Cg==

