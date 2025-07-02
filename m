Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E33C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyEe-0003Ze-PC; Wed, 02 Jul 2025 10:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyEb-0003ZO-GJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:14:49 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyET-0005F3-Sv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751465682; x=1783001682;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mfpn9S4+129D/7+DgQkOxceNfrsOA0R11RdrpFn8dHk=;
 b=Ajsnghlj3UkOcylHkFjTr3ZYfAG7AY9xj1aoAR/rHvgqrBuEMfi2En3a
 jXfWJEWXqNj4R9dCerL1bh/1+1uAhi6fK8y77ircCUHzeXt6NZCEKsDj2
 oE8WB8SKOFDuZFVYqo7ZZrPnnZaLk63+ZHShusI2SB7NPhR52hPyvh/kG
 FvzCcoMGmrQYhRWALsx5R4XWuShCNhfPbiL/WdgaBLElwkGLIozGxfaom
 22SpHt6/Vxy52nLi4x+yeb3hxo0J83zWSxVQ48GPYIZ4qaTfnIPb23JEn
 gsO1yTqLIe9eVJGpnk4wtueYhLiWaXC/DFBweCeVG2tXBjwleHTg2+G1B w==;
X-CSE-ConnectionGUID: Zgo5yTHNT2SuE7d2n7NQsQ==
X-CSE-MsgGUID: 4AF+RTfLQ0KNIowU9CGFJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57542358"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="57542358"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:14:31 -0700
X-CSE-ConnectionGUID: vLfkFuKLS/+rbFvJ1oP0Bg==
X-CSE-MsgGUID: pGfQaVw/Syu9y6ckLJOBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="158356459"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:14:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:14:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 07:14:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:14:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnjnQmlXAAmxqJ9uHXg3A280G4oz1hMeH/n4NVhegr8gFzL2AsnpUXwBAOlZHOrX/jhTfSsaL0AiHkaQtKxwoQ3SU60mMbH/Zxb60+T3Wbeyjr7dWor/UNIvrlAXlfZ3rvMW366X+qYZ0Vmspjx7ulDQ/7WfQ0ENQaVl+ku6ypgnS33KUgxogNRWxy1PcGa4mO6ZQg4ba/BLjC0msV1Y3FURjMQaAkY+0AuB9103+AyV8k0WyjDI4SKyxpSMrU2FmWqPCTjfRnjy4qyutCt6Lsr8HOGnQrLZ60kr53F8OO77J0KvhCjNqXJppmk8y3ZmmbLvvXXwIyrYorIaSOxANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfpn9S4+129D/7+DgQkOxceNfrsOA0R11RdrpFn8dHk=;
 b=Vvj9ZOehvSKgxLY9YJsPGgJrXuebvfWVBWDgljEoSYyTldCWMdbbf4XAHaG+MB8lDWRdWcNj0RQyfPkjnAcZ/kiAsuOp54BTlcwG7h9QokI50DhDkJJvom/ywFpCCBL1Bg8wLFeLbJ7T6SmEJU0bZa5UIxo7mUG+orxwJ+zx9KbKD3tMwHsA0ZWc2IyG8GMY/+NPQaXhyCODd37+CzXu61/UAYZCKV+fZV1QTvlGG01s3Y6f7CDei8EdiiXLsMYdnrOyWVwHlQ+gsvMKyNygdJyKazkHcqa2GMIVF+B+Q79MwUZLOt+Wyq7HobNneurcd/XDLZQ+aXTW1qpxaAFHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 14:14:12 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 14:14:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 33/38] vfio/iommufd: reconstruct device
Thread-Topic: [PATCH V5 33/38] vfio/iommufd: reconstruct device
Thread-Index: AQHb2h4PHaQmHFB+HE2ywKFDGxvAY7QT0yUwgAmgzwCAAY6s8A==
Date: Wed, 2 Jul 2025 14:14:12 +0000
Message-ID: <IA3PR11MB9136977A9D1DCA9443D8E5E99240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-34-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136ED60B695DC51D2C4C3E1927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <622bf043-49d6-48b0-af93-73bb7f3dc415@oracle.com>
In-Reply-To: <622bf043-49d6-48b0-af93-73bb7f3dc415@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: eb6f944c-d0e5-4502-cb13-08ddb972b85e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?emRsZ0c2aTJLWU9CeGpwNkRtb3Nvcm04aEZYR2paUmFoZ214WW1FN0ZvbFVH?=
 =?utf-8?B?M1g5WTNNQ1FSY2J2cE9tUkFjb05ZOHB4SmV4T0dJTTI4aWdTWFVNMkFEOXQw?=
 =?utf-8?B?MkVuenFmVkt1cmFObEtJTU9YdHJZeGJEcmpWUmNSdlJQMU1YSndQZ3Y1UnFN?=
 =?utf-8?B?U2RJVU9adVg5SDArcXdtZkZLYmNJYTJnN0tyVG5wazYvaUxQVjQwY29QdlYv?=
 =?utf-8?B?cW5WVDBndUZVcnhvZmRoRHJBaXlqV1M4VlZHakp5QmtNV2QzcXRMc3J4eVdq?=
 =?utf-8?B?TVVyTmRNVmhGMXhWSjgxaXJWYmFUNlVYaVd0dW4vUEk2alVDeURNQTJjRWhz?=
 =?utf-8?B?VE1vMHZMQlplTUt1d3pOQUJRNy9aRnA1ZHJ6eE5rK0ZHU0F3d2hHWUtEQy9B?=
 =?utf-8?B?MndFY0s3UDdJSFJzMmZYOGYxOGxnMi9SQjkraEVITFZHMUZuUFI3NFdIQVFt?=
 =?utf-8?B?aUJzTHFCVVBleVlPb0k5aUFWU1NoMWk5SStkb1dPRWJVZS8xWHJ4TFZ0elRZ?=
 =?utf-8?B?aGN6c2xkV1EzYzNtams5R2JnRlkzM0ZmVmgwbWNLQTZDTVlMTmZtNDd2MWlT?=
 =?utf-8?B?MXltby9hWGh0bFNkMnpHenJSUWduY1Foc21MM2l5U3g5Z2YvRUN3WFdVcnBw?=
 =?utf-8?B?TEY2NFpEalhrUUsyNXFGTTJ4OWVZakp0SFpVTVQ4UXlXZ21TbnE0aktwZ2VG?=
 =?utf-8?B?TDkxZUpYQUpvdUtRUkdvOWhySGZuUU5idi8xeDd6ZkJwM0ZJQnFzZndxRStS?=
 =?utf-8?B?N2RaNEZYRG9palZCc3VtNndPVjQyYW4yQkswZ3NwVXl0N0xSdUU5L2JnZXU0?=
 =?utf-8?B?U0Q3RnhGQVQxaVN6SXlFemxyWXlDcElOR1kvNDkwQktVdjk0ZStWWTJyZ3ND?=
 =?utf-8?B?K1Z1MU9YVzFlOFdST0F5YzJpY1hyQWg0T1FULzJQZmJ2aTdCZnR1Z2JMRndR?=
 =?utf-8?B?eTBLMjdiTTVCV1RSVy8yV2l2TUh5UVhzSVQ5NWt6SE1JY2VLMjk4azFmZ1JD?=
 =?utf-8?B?M0UrU3N0VG5LcERGRDBmZjRIaGVnTUxDWE1mTWRrV0d4U2tWNlRpckx2ZSt1?=
 =?utf-8?B?UVlYQitYQ3lFTFRDL255MEV5TUxOWE03Y011SHF6OTdLYjZOV1JiR29lZjIr?=
 =?utf-8?B?RDVKTm5QQ3oxRVpDWmlKbHdhV2Z4MkZrTWI2czRlL25DbDJNOXFZb3VvNUd4?=
 =?utf-8?B?SzNnUWZzZlIxY2F0dGtibU9FZUwrOFJYWjU1dkhFWE9QTHBadys5YitBVWFr?=
 =?utf-8?B?elF4RWZMbllGNHlWeEJ2MEk1cnZFVlRJMWNtT2dDYnZNTUlsL0FWdFQ5Mktp?=
 =?utf-8?B?UWc4SXhncE1VRnp4UnRiYjV4WjFEaHJUZStPOGQvZllobzJLdkZjSURBTSsw?=
 =?utf-8?B?Z0FPMVFTTnVBdzRsOG1HTHNEZUZVS28zekRoc2FWaTM1YUJjbjdwa2xTR211?=
 =?utf-8?B?RDIrOENSRUQ0Wm5ZTEVNRWhzTUZ2SGtMN0xqS2x4RVc1aVJDd0NMMFpWUEJp?=
 =?utf-8?B?WlhsZ1Jra1ZGVmZBTzFWckx1dXk3bDI2dHROSDk2M0p2b3A0WXdwMHdkcTlO?=
 =?utf-8?B?czRHcFgxRHNKdm5aNm1qZnVxbERNaU12a2xwaTJHN1hlTy9XK0V0cmJtMUZJ?=
 =?utf-8?B?TnY0cE8zQ0NPQ0gvYnJucGN3VmZJODFjT1RxK1F4ek9Xc3hFc21sSDA2UUxU?=
 =?utf-8?B?dXJlQllISFpMbFFRdzdaNnB2anJJNlpXQ3FYdnFCc1lRcmtNVTFScVVLNFdX?=
 =?utf-8?B?VzcwS2MrUngwbWhucElSK2hhZUdyMzF2ZGJGUHA2UjhoS1kxL2VaSFpValZj?=
 =?utf-8?B?U1lnc09abDNVK2lSUWhTazdXRmJCMEt2c1kycTdmcFJ4LzlJRTNVRzFNL3hM?=
 =?utf-8?B?dmpBUTNjeE9GWTdYVFZvVk94ZklBQVUrNG5haUt2OVQ1bWhuWjdFRGJiMjdF?=
 =?utf-8?B?VVRMaGV0d1BvdzdscHUraDRmdjNHTWdsbWd3MWNUUnVNOFFJSExmTkI2bUlR?=
 =?utf-8?Q?5UgWnSG9OT6Nqnj+6AkvV33BaGhD7o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUtZdGNMOGUxZ2FkbmJ0OEFTOGx5WHB4bUxnQVJ4OTNzMEZkVnpPdXlmZ1RU?=
 =?utf-8?B?elk4a0xNSG11amU4OXBjQnd4eDVkVHhwRG1TQ3Q1ZWZySUQydk1CdTZCQVcz?=
 =?utf-8?B?MENjblAvOWFwSTBTa2p6ekZCR1cxbzhCOTRTK2VKSEdXaHN0aURUeklzUGNj?=
 =?utf-8?B?b2R0SVZuNG8yc0xBVVFwSTBITENKT1pDMkxvRHpKQXd6ekxZeHJuQkNxTjA2?=
 =?utf-8?B?bkh5L2oxMXYvYktyaWMvQk56M0wzd3MxR1BJL2tuZHRnQ2F4L0VwSVpKWVBL?=
 =?utf-8?B?R3VWc1JMdVJqUGtwTTc5YVVmaTRyNHhOMUZNSFZ1THo3Q1huejhZR0tIWFp3?=
 =?utf-8?B?dXlOWXlMYm9STlRJb2tmRHFkYzN6bEZnNUYwTWhOaTdGQmsybWRTaEltSHBG?=
 =?utf-8?B?MjI1bkRCTS9GNUVmdHNBN2NXdTdiTDlRc3hUS3pzTXlUM2Jwcm1hd1NmSmc0?=
 =?utf-8?B?TGU3bDRpVzgwcXhHWHJqYVZBVDhGcjNwajBlWkVFRlVoaHdtYmtSOTBSUGI1?=
 =?utf-8?B?Wm1UcHFSNzRaSEZNNUhxMFpla3Y4NTZLL2JHMnZoWFVJSnB1S3V1UEdZTWVH?=
 =?utf-8?B?ZTREK3R6VXpHbEdUbVRNQWxGZWh1TU1FZmFneGFnQmh4bVRheUJzaEt5SU1z?=
 =?utf-8?B?VGdmaEgrVi9jdnA3bk9PMWE2YStFbTVxNk54VVJEb2xYSUNJUjRyOXZGdXBP?=
 =?utf-8?B?ZkRlNTB3cmhqNjA3WWlUZ0hhWTJUYTF2QnJtNGVRV213cS9uMk8rTitxMkhm?=
 =?utf-8?B?MjFtZlNzZW5iTmxFZm8vbEFRQ3k0WXhDN0Y0cU85Q0VsSTNPL1FKc2VHTTR1?=
 =?utf-8?B?RFdrZ2l1YjlPVTY4N0tweUppU1lqdGpTdVJkVTJpemk2VmdGVE13ZU50Zmxp?=
 =?utf-8?B?TXVkdGlyWWFzczhtbE9QWW1EUzgweTRtcDdlU3ROUHJWRzFKRkJoNElPTGZS?=
 =?utf-8?B?b0dSZXRjcVIremkzejB2N1g5bzZUQ3U3dGMzQ1F3aXJkek1uTzd4dkJqbW8x?=
 =?utf-8?B?Y0g0ZmhmWlZMek5SVXRkMDVNSW9rc0NEQ09LaXdiRUhweXQwU1BqWnVZUWho?=
 =?utf-8?B?bTBETEE1M0Y5eG0zYisxa3J0UmkwYXltUDlRQ1lrN0pmSHpmR2loQXk5K21s?=
 =?utf-8?B?MFNKMGdLNXZZWHU4VXNHUTNHU0tRbEgxbHA4b2VLVEQ3YkJJZWlRc2JkODBV?=
 =?utf-8?B?ZytLQ1lyTDU3TlU3M1I3bGN5K2pEWTQyQ09ZZEJ4c0tuUE9ydnJZY25wL09k?=
 =?utf-8?B?WU9kcHF3bzN0WUwzRXY4TllDZStVaDI4MU1aWGNSaU95ZHp5ZFFHeFVBRytN?=
 =?utf-8?B?M3ZnWFpvcGdzeXBDbWlNcFM3a1RnTjlnalFUVnJFUmt6ck90Z0xrUGRFaGli?=
 =?utf-8?B?bzI5ckVKL2xKVjhvRmhwMzJFV2JGcHVRdERIbmRwUDFhdENsT3BMQ2RXTmZz?=
 =?utf-8?B?aE9RaEtSNzc3clhjOEgwbHQzVlVDcnRtdHJ4SUVLWHlST2ZidmxkNmpLZFRy?=
 =?utf-8?B?aFo0NldpQnJ2L09nLzBvYVRyaG1xbDU4TlJLUmNyNThmdXJIUVZBUXlYZjNl?=
 =?utf-8?B?b01nazA0MEsxWVVFaHFzOExnK2JiUU5GUXhrL3ZiMXhwbFpJeGF5UElnWCtJ?=
 =?utf-8?B?TkxxTVVQMGlMbTAxbWs0VzZkZHlmWmcyT05RSmFzd1lxanNETWFQL1JjQTFn?=
 =?utf-8?B?L2FTYTR4SUF3ZGZhUm52SlhHZ3FTclgzOEtkNUlORFBnQ2YyekY3TXBaVlVC?=
 =?utf-8?B?Y0l0UnVUOWFkS0FyZVFveFdoYzZVVEk3U2hiK1BuQ3RZN3NVVmFOUXpPZFg3?=
 =?utf-8?B?Sy9EajRCcHZVUnpsalprODNVQVlhUEpjanpIN3hYbU01ZlRkMzViTXI5TUw0?=
 =?utf-8?B?c0VtWElNZDd1WUdsc3l1L3pHaVhCMU5lY2ZhMWU3cWJMNEcxUitrVWtWdHpu?=
 =?utf-8?B?Rzh6dVlFRk5ycVFlaGFBcGVBcmYrUHREQWxES3R1WG9ZeitTRGVNVnlKZERL?=
 =?utf-8?B?NFRaMUlyd2hyU0NoVFFjbXJYWXN6bmRBcmc2QlpkZ1ZXbzJHeUp1ZkMwN2lU?=
 =?utf-8?B?Nk1mQ2dkVjRvUWZQL3JQRFVKUHFpZ29yamtJMHppNklDQm5VNmttS0RZTi8v?=
 =?utf-8?Q?Dat+Dv+b7HYVTabwVbQl89NX2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6f944c-d0e5-4502-cb13-08ddb972b85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 14:14:12.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCIgoWfaplqM4c2sBoMnZO5oncL79wHe0dSXih//c9f9zCbYDbZiGqB60JVgdIT1G8Nmy8W2TQ/zaNSta3W9aavHh+3LP3AAX6HqMV79S9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMzMvMzhd
IHZmaW8vaW9tbXVmZDogcmVjb25zdHJ1Y3QgZGV2aWNlDQo+DQo+T24gNi8yNS8yMDI1IDc6NDAg
QU0sIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4+IEZyb206IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+
Pj4gU3ViamVjdDogW1BBVENIIFY1IDMzLzM4XSB2ZmlvL2lvbW11ZmQ6IHJlY29uc3RydWN0IGRl
dmljZQ0KPj4+DQo+Pj4gUmVjb25zdHJ1Y3QgdXNlcmxhbmQgZGV2aWNlIHN0YXRlIGFmdGVyIENQ
Ui4gIER1cmluZyB2ZmlvX3JlYWxpemUsIHNraXAgYWxsDQo+Pj4gaW9jdGxzIHRoYXQgY29uZmln
dXJlIHRoZSBkZXZpY2UsIGFzIGl0IHdhcyBhbHJlYWR5IGNvbmZpZ3VyZWQgaW4gb2xkIFFFTVUu
DQo+Pj4NCj4+PiBTa2lwIGJpbmQsIGFuZCB1c2UgdGhlIGRldmlkIGZyb20gQ1BSIHN0YXRlLg0K
Pj4+DQo+Pj4gU2tpcCBhbGxvY2F0aW9uIG9mLCBhbmQgYXR0YWNobWVudCB0bywgaW9hc19pZC4g
IFJlY292ZXIgaW9hc19pZCBmcm9tIENQUg0KPj4+IHN0YXRlLCBhbmQgdXNlIGl0IHRvIGZpbmQg
YSBtYXRjaGluZyBjb250YWluZXIsIGlmIGFueSwgYmVmb3JlIGNyZWF0aW5nIGENCj4+PiBuZXcg
b25lLg0KPj4+DQo+Pj4gVGhpcyByZWNvbnN0cnVjdGlvbiBpcyBub3QgY29tcGxldGUuICBod3B0
X2lkIGlzIGhhbmRsZWQgaW4gYSBzdWJzZXF1ZW50DQo+Pj4gcGF0Y2guDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+
IC0tLQ0KPj4+IGh3L3ZmaW8vaW9tbXVmZC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lv
bW11ZmQuYw0KPj4+IGluZGV4IGYwZDU3ZWEuLmE2NTA1MTcgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcv
dmZpby9pb21tdWZkLmMNCj4+PiArKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IEBAIC0yNSw2
ICsyNSw3IEBADQo+Pj4gI2luY2x1ZGUgInN5c3RlbS9yZXNldC5oIg0KPj4+ICNpbmNsdWRlICJx
ZW11L2N1dGlscy5oIg0KPj4+ICNpbmNsdWRlICJxZW11L2NoYXJkZXZfb3Blbi5oIg0KPj4+ICsj
aW5jbHVkZSAibWlncmF0aW9uL2Nwci5oIg0KPj4+ICNpbmNsdWRlICJwY2kuaCINCj4+PiAjaW5j
bHVkZSAidmZpby1pb21tdWZkLmgiDQo+Pj4gI2luY2x1ZGUgInZmaW8taGVscGVycy5oIg0KPj4+
IEBAIC0xMjEsNiArMTIyLDEwIEBAIHN0YXRpYyBib29sDQo+Pj4gaW9tbXVmZF9jZGV2X2Nvbm5l
Y3RfYW5kX2JpbmQoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+PiAgICAg
ICAgICBnb3RvIGVycl9rdm1fZGV2aWNlX2FkZDsNCj4+PiAgICAgIH0NCj4+Pg0KPj4+ICsgICAg
aWYgKGNwcl9pc19pbmNvbWluZygpKSB7DQo+Pj4gKyAgICAgICAgZ290byBza2lwX2JpbmQ7DQo+
Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICAgLyogQmluZCBkZXZpY2UgdG8gaW9tbXVmZCAqLw0K
Pj4+ICAgICAgYmluZC5pb21tdWZkID0gaW9tbXVmZC0+ZmQ7DQo+Pj4gICAgICBpZiAoaW9jdGwo
dmJhc2VkZXYtPmZkLCBWRklPX0RFVklDRV9CSU5EX0lPTU1VRkQsICZiaW5kKSkgew0KPj4+IEBA
IC0xMzIsNiArMTM3LDggQEAgc3RhdGljIGJvb2wNCj4+PiBpb21tdWZkX2NkZXZfY29ubmVjdF9h
bmRfYmluZChWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4+ICAgICAgdmJh
c2VkZXYtPmRldmlkID0gYmluZC5vdXRfZGV2aWQ7DQo+Pj4gICAgICB0cmFjZV9pb21tdWZkX2Nk
ZXZfY29ubmVjdF9hbmRfYmluZChiaW5kLmlvbW11ZmQsDQo+dmJhc2VkZXYtPm5hbWUsDQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YmFzZWRldi0+ZmQsDQo+
dmJhc2VkZXYtPmRldmlkKTsNCj4+PiArDQo+Pj4gK3NraXBfYmluZDoNCj4+DQo+PiBJJ20gbm90
IHN1cmUgaWYgd2Ugc2hvdWxkIHRha2UgYWJvdmUgdHJhY2UgZm9yIENQUi4uDQo+DQo+TXkgdGhp
bmtpbmcgaXM6IG9uIGNwciwgd2UgZG8gbm90IGNvbm5lY3Qgb3IgYmluZCwgc28gd2Ugc2hvdWxk
IG5vdCBsb2cgaXQuDQo+aW9tbXVmZF9iYWNrZW5kX2Nvbm5lY3QoKSBpcyBjYWxsZWQgYnV0IGl0
IGp1c3QgcmV1c2VzIGEgY3ByIGZkLCBhbmQgd2UNCj5jYW4gb2JzZXJ2ZSB0aGUgbGF0dGVyIHdp
dGggY3ByIHRyYWNlcy4NCg0KT0suDQoNCj4NCj4+PiAgICAgIHJldHVybiB0cnVlOw0KPj4+IGVy
cl9iaW5kOg0KPj4+ICAgICAgaW9tbXVmZF9jZGV2X2t2bV9kZXZpY2VfZGVsKHZiYXNlZGV2KTsN
Cj4+PiBAQCAtNDIxLDcgKzQyOCw5IEBAIHN0YXRpYyBib29sDQo+aW9tbXVmZF9jZGV2X2F0dGFj
aF9jb250YWluZXIoVkZJT0RldmljZQ0KPj4+ICp2YmFzZWRldiwNCj4+PiAgICAgICAgICByZXR1
cm4gaW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldCh2YmFzZWRldiwgY29udGFpbmVyLA0KPmVy
cnApOw0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gLSAgICByZXR1cm4gIWlvbW11ZmRfY2Rldl9hdHRh
Y2hfaW9hc19od3B0KHZiYXNlZGV2LA0KPmNvbnRhaW5lci0+aW9hc19pZCwgZXJycCk7DQo+Pj4g
KyAgICAvKiBJZiBDUFIsIHdlIGFyZSBhbHJlYWR5IGF0dGFjaGVkIHRvIGlvYXNfaWQuICovDQo+
Pj4gKyAgICByZXR1cm4gY3ByX2lzX2luY29taW5nKCkgfHwNCj4+PiArICAgICAgICAgICAhaW9t
bXVmZF9jZGV2X2F0dGFjaF9pb2FzX2h3cHQodmJhc2VkZXYsDQo+Y29udGFpbmVyLT5pb2FzX2lk
LCBlcnJwKTsNCj4+PiB9DQo+Pj4NCj4+PiBzdGF0aWMgdm9pZCBpb21tdWZkX2NkZXZfZGV0YWNo
X2NvbnRhaW5lcihWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+PiBAQCAtNTEwLDYgKzUxOSw3IEBA
IHN0YXRpYyBib29sIGlvbW11ZmRfY2Rldl9hdHRhY2goY29uc3QgY2hhcg0KPipuYW1lLA0KPj4+
IFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+ICAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7
DQo+Pj4gICAgICBzdHJ1Y3QgdmZpb19kZXZpY2VfaW5mbyBkZXZfaW5mbyA9IHsgLmFyZ3N6ID0g
c2l6ZW9mKGRldl9pbmZvKSB9Ow0KPj4+ICAgICAgaW50IHJldCwgZGV2ZmQ7DQo+Pj4gKyAgICBi
b29sIHJlczsNCj4+PiAgICAgIHVpbnQzMl90IGlvYXNfaWQ7DQo+Pj4gICAgICBFcnJvciAqZXJy
ID0gTlVMTDsNCj4+PiAgICAgIGNvbnN0IFZGSU9JT01NVUNsYXNzICppb21tdWZkX3Zpb2MgPQ0K
Pj4+IEBAIC01NDAsNyArNTUwLDE2IEBAIHN0YXRpYyBib29sIGlvbW11ZmRfY2Rldl9hdHRhY2go
Y29uc3QgY2hhcg0KPipuYW1lLA0KPj4+IFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+ICAgICAg
ICAgICAgICB2YmFzZWRldi0+aW9tbXVmZCAhPSBjb250YWluZXItPmJlKSB7DQo+Pj4gICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KPj4+ICAgICAgICAgIH0NCj4+PiAtICAgICAgICBpZiAoIWlvbW11
ZmRfY2Rldl9hdHRhY2hfY29udGFpbmVyKHZiYXNlZGV2LCBjb250YWluZXIsICZlcnIpKQ0KPnsN
Cj4+PiArDQo+Pj4gKyAgICAgICAgaWYgKCFjcHJfaXNfaW5jb21pbmcoKSkgew0KPj4+ICsgICAg
ICAgICAgICByZXMgPSBpb21tdWZkX2NkZXZfYXR0YWNoX2NvbnRhaW5lcih2YmFzZWRldiwNCj5j
b250YWluZXIsICZlcnIpOw0KPj4+ICsgICAgICAgIH0gZWxzZSBpZiAodmJhc2VkZXYtPmNwci5p
b2FzX2lkID09IGNvbnRhaW5lci0+aW9hc19pZCkgew0KPj4+ICsgICAgICAgICAgICByZXMgPSB0
cnVlOw0KPj4+ICsgICAgICAgIH0gZWxzZSB7DQo+Pj4gKyAgICAgICAgICAgIGNvbnRpbnVlOw0K
Pj4+ICsgICAgICAgIH0NCj4+PiArDQo+Pj4gKyAgICAgICAgaWYgKCFyZXMpIHsNCj4+PiAgICAg
ICAgICAgICAgY29uc3QgY2hhciAqbXNnID0gZXJyb3JfZ2V0X3ByZXR0eShlcnIpOw0KPj4+DQo+
Pj4NCj50cmFjZV9pb21tdWZkX2NkZXZfZmFpbF9hdHRhY2hfZXhpc3RpbmdfY29udGFpbmVyKG1z
Zyk7DQo+Pj4gQEAgLTU1Nyw2ICs1NzYsMTEgQEAgc3RhdGljIGJvb2wgaW9tbXVmZF9jZGV2X2F0
dGFjaChjb25zdCBjaGFyDQo+Km5hbWUsDQo+Pj4gVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4g
ICAgICAgICAgfQ0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gKyAgICBpZiAoY3ByX2lzX2luY29taW5n
KCkpIHsNCj4+PiArICAgICAgICBpb2FzX2lkID0gdmJhc2VkZXYtPmNwci5pb2FzX2lkOw0KPj4+
ICsgICAgICAgIGdvdG8gc2tpcF9pb2FzX2FsbG9jOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiAg
ICAgIC8qIE5lZWQgdG8gYWxsb2NhdGUgYSBuZXcgZGVkaWNhdGVkIGNvbnRhaW5lciAqLw0KPj4+
ICAgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfYWxsb2NfaW9hcyh2YmFzZWRldi0+aW9tbXVmZCwg
JmlvYXNfaWQsDQo+ZXJycCkpIHsNCj4+PiAgICAgICAgICBnb3RvIGVycl9hbGxvY19pb2FzOw0K
Pj4+IEBAIC01NjQsMTAgKzU4OCwxMiBAQCBzdGF0aWMgYm9vbCBpb21tdWZkX2NkZXZfYXR0YWNo
KGNvbnN0IGNoYXINCj4qbmFtZSwNCj4+PiBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pg0KPj4+
ICAgICAgdHJhY2VfaW9tbXVmZF9jZGV2X2FsbG9jX2lvYXModmJhc2VkZXYtPmlvbW11ZmQtPmZk
LCBpb2FzX2lkKTsNCj4+Pg0KPj4+ICtza2lwX2lvYXNfYWxsb2M6DQo+Pg0KPj4gU2FtZSBoZXJl
LCBvdGhlcnMgbG9vayBnb29kLg0KPg0KPkR1cmluZyBjcHIsIHdlIGRvIG5vdCBhbGxvY2F0ZSBh
IG5ldyBpb2FzLCB3ZSB1c2UgdGhlIG9uZSBmcm9tIGNwciBzdGF0ZS4NCj5JIHRoaW5rIGl0IHdv
dWxkIGJlIGNvbmZ1c2luZyB0byBwcmludCBhIHRyYWNlIHRoYXQgc3VnZ2VzdHMgd2UgYWxsb2Nh
dGVkDQo+YSBuZXcgaW9hcy4NCj4NCj5QZXJoYXBzIEkgc2hvdWxkIGFkZCBhIHRyYWNlIGluIHZm
aW9fY3ByX2ZpbmRfZGV2aWNlOg0KPg0KPiAgICAgdHJhY2VfdmZpb19jcHJfZmluZF9kZXZpY2Uo
ZWxlbS0+aW9hc19pZCwgZWxlbS0+ZGV2X2lkLA0KPmVsZW0tPmh3cHRfaWQpDQoNClllcywgdGhh
dCB3aWxsIGJlIGJldHRlci4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

