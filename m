Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D023EC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPM-0007yx-Jk; Tue, 03 Jun 2025 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMPPH-0007vX-R1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMPPE-00028s-8q
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748948528; x=1780484528;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IsE1omYh4+r1cOgc4lf1f7+SELPZdnH5E76Uz6PcIVU=;
 b=EHfQcEj3GDIQG69gx4XZmmNCmrrB3kBZ04zwldFE//nHDMpe8WduPz/y
 ThsFSRZofG24ubkqbP/ALg3kbyDWgBLsuazZ01GeeZdCcgQ+Qfed2oih3
 8uuqWL5GCNnA3Vjw+UMwO+ltTYnPtAXGkJvcFTsXW6ivWc8V/XmLAS+Yz
 h4p0RXF3fUDxznVq7VYV4gt5WzB2bBDR0jMyww9xG5Iql1FCWiqqW2VfJ
 oW0mXcOLXDJvq+dEEibj9/lju/bxQSONfWs/7EnoaXDqzXnlDAT0DrKJb
 SI1m5DHvJK4yf1gz9XYzofyiDdGWAMNny/059oewSpNQJ3fNj2v33tY63 g==;
X-CSE-ConnectionGUID: JmjUfEjNSYu12uO2WYPPVg==
X-CSE-MsgGUID: Lx255rVbRJ2X+q6Ra3xotA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61603066"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="61603066"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:02:03 -0700
X-CSE-ConnectionGUID: jLEdbu/kRDKR8CHYoYx2nw==
X-CSE-MsgGUID: gK3BKrs/T1KvJkcANnRzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="145798213"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 04:02:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 04:02:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 04:02:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 04:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8D5QRlNBQVXXDJWLtwRD8QWT5Me/QAvAcMV0dB3SfLlGwFY7mPHrUTGg7UhwEQvATt2DKqcmYK/bYe9yVWoFfqZhJ1S+yAuUDh+6zNtehQXhSeXarUJi+KvNUhj5zEl9rvaq700/DR7DiaMM6iP03WFhBSj5Ba3ZsALbVZmALY5fPqvTnaLWezjXmEj7lKNGaWK3TaXXl5rzA6bKv6jAyr/bQXLgYQHpGw5GBPfn+uI+bMBqPGbGzNMrvvaB9GL7pEiU0jpddiw1zJjzBgIQBjg7wE4jvEgz1YYrqYRZMUWSbzJR2B9nQOijaMJko0WpKom3r+GxY8STfohk/ROTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsE1omYh4+r1cOgc4lf1f7+SELPZdnH5E76Uz6PcIVU=;
 b=Dm5W726KLNlQjBWv3J+gf7tziJyhkkEUZShZEgKG2yUr7mahjlujDBLdInJYe2mkfruaOBcXyBkAWCzDL6IUQMyNeIY/WImvsP6CoTI5d7sfeDP/XbcsgfeC/R0Z5XL297O0EgsFXpzXcYq7f+wT0dx5rjHIZ6dwYI1Szfj7QYW4+KfwaR3XoSZoaMcA9PQH6lzR2fyz7JD2ELlL6aSG6B1sxRECWzGTsNGgonSEte+TDQilg+kmh4Vvac4fHaRhmk7UaBFve0eJUosIxkHflFDcs+o4OekOTEJpqvMBoi8P9QogiCFjQld4TP/e5c+hWkCjopS4zujbraMro2QZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 3 Jun
 2025 11:01:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:01:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 08/43] vfio: move vfio-cpr.h
Thread-Topic: [PATCH V4 08/43] vfio: move vfio-cpr.h
Thread-Index: AQHb0M9isZET7AQkIUu/uiHPJz9kq7PxTBsw
Date: Tue, 3 Jun 2025 11:01:43 +0000
Message-ID: <IA3PR11MB9136A47FF0D563C373AFCAC9926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-9-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1748546679-154091-9-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6396:EE_
x-ms-office365-filtering-correlation-id: 1730e407-a1dd-4e78-c510-08dda28e06c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2VMUkRkd0xINXlLOVRsTk1EeE1KbEtGKzhMNmRhN2kyUUxnNHRiSWtvUmxn?=
 =?utf-8?B?UFJ4VzR0dlpiSzZOWnZSQ2VCcGlUd3FXd0ZiS2RONmI3NENKMnN2TXUrb3pN?=
 =?utf-8?B?VkE4cUpydVladVB6Q2ZoamluaEE5WkhYaUdBTSthU29sOFB6dWhmQ3I2dTdT?=
 =?utf-8?B?UzliVlluMjU4S3RZN1c4SXU3ekhWRVJ0OXNsT1FWVzlQNGdRNitXUWc3dTZj?=
 =?utf-8?B?YzdIRWMyZEVteG5OUEJ2aUxmTE1qOFlJV29VcXhCdG9qa29yNE5USWhuRUxr?=
 =?utf-8?B?TmVoM1N6L0pUang3TmJKSXk1SFVBVkFGMkZEVXUxOTJxVkxzZC9mbk4yV1FN?=
 =?utf-8?B?VDlTaVlubk1ZbEdteVdYUlJ0TXJ0WVR0WEx4LzE2OSt1TWllQ2hRV05TeVB4?=
 =?utf-8?B?TnAyRE9QZEx3Z0hINitoN3RXSVlMOXI3cjNZVGRxQXo2UWxYOHBRWWhlaHFn?=
 =?utf-8?B?VFp4STBMN1lFbEorNFNxaGw2ZmNxYlVxUGNYQUx6R1BKRE5SeHlSTm9xSE1y?=
 =?utf-8?B?QUxVZ1BqTVJmVVNPSDhSeTkySHJGUDRaR1hGa0JOWUQwd2svM3dTSUdjVElj?=
 =?utf-8?B?OHAySC9FcndlWkRibXpadXNuTXdqQi9zYlhua1EvNTk1UDhEV3ZMZFJ2NCtx?=
 =?utf-8?B?SVhuL3VNWlJMaC80SmJ3SG9XVDA2ZjhhZzJPdk9JajYzSGxzY0RTcExucy81?=
 =?utf-8?B?RTd2QmozdVNscTVTeVJjZTFPZzBzOEVQWTc0TkZxNW53N1VpbXRpeWtzWmRs?=
 =?utf-8?B?TDZwOGRZSmJxL2lCWWwyNXR3d1ZTWnVRbEZOaHBYbXVFQjJZemtnWjhiQmYz?=
 =?utf-8?B?L3kzMXdEdDBtVndyRVFxSGk4OGJXMGR6MHM0dExHZmFSQ2hOU1kyakVwV2JD?=
 =?utf-8?B?NkY0WTBSclRSbTRBSGVRM1pOcERZZlpuL3NuUTJHTFJseGIxT0hISzhmZmJn?=
 =?utf-8?B?WkRlMXNkbG1HNTg0RGtRbW94Nk1CbmpnWVZBS3B1QldtOHNMQmptdkt6cXhK?=
 =?utf-8?B?WTNsTWg0eXJGMnl2TmVGY2VweEVFQi83ZERyTS90SGRVWE0waHBRM0prMTFx?=
 =?utf-8?B?bkZrV3p1K2pGa2FDM2xneXJtVjN6akRDK3o4Q2lPT2djNHVGOHdsT0dhQk00?=
 =?utf-8?B?MTd6NEQzdnZEcFZPcnA2UlhyWENTU3RmQXBmZ0FhV3J6WEFJMnJrVm82STFr?=
 =?utf-8?B?a3V5dlNrbXZDei9tdkh4dEI5QlVBak4xU1k0TmhMaDM1MjRLbCt0dkROeWtw?=
 =?utf-8?B?blFkY25qOE5INUhvR0R0MFpFKzlUYUNwMmwyckh0YmV0VEZnQ3dXS2t5UlUr?=
 =?utf-8?B?Y2svVHEzL1hQK1I5ODl5R3ArV2ZKdWR4Y0xsNVlYb2o1RnJPUTVkTnp2K2hZ?=
 =?utf-8?B?Y0V6djhZdm0xaGZFUHpFZWVCbU9TK0wvODlaT25PWnFOKytJRHZPY3JidDFT?=
 =?utf-8?B?RlB5TmZ3V1pxUVArQm5CdmRmR3IvNWVSb2VIOGJQQjNEU3JkUHY5anBlNGwx?=
 =?utf-8?B?ejRhazhDZGlOTzMyWTQ4MEZTNFRrQTlaVU5ZNjFWajJzeVVYdzlna3lLUGtO?=
 =?utf-8?B?WDZEMWVRb21QVUZhb1c2WDFRb3VoTzdUMEx1WHZXRnBic2dZVTBrNjk1L1dX?=
 =?utf-8?B?bnVUV0RJNTQycjl0dHJjejk0dUxhTUdYNW1zS2dVeWFkeFRYODMxSGc1R2hv?=
 =?utf-8?B?V2E5MW84eFJDdWVZR1VNYkFVay9zdHRFZG85dnRhQzY2c0VSQ2VGUGVTUTZs?=
 =?utf-8?B?NnhvME1VKzdBU0pjNXY0MXpBT05jRld1cWlEZGc2LzlWTytoNW9CRklNTnNv?=
 =?utf-8?B?MjdOdTBiZlJBNnBWTWlJU0Q1cVVhT3dOMGQ5aTRIU2RETkpCRVhtSjJEWDBL?=
 =?utf-8?B?ZWdGay9xOU45SkwzMzYxdi9wUFNNdThDeXZVSjRTV3A2Tk40S3JHVDZsamky?=
 =?utf-8?B?YnNVd3pubThlZHBmWFBISjBmYVRONm5ZYXlrWlBPVWVUMTZSayt6NDZWNVpC?=
 =?utf-8?B?bkNIODVMcXlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUMxaEZnT3duRmtOZEQ3WGNEb0dPV2JvZ2xxWWpnVnVyRTkwcjY5a0VuZXFs?=
 =?utf-8?B?aDBYYmJoVUdjbDdzVzZ4MlNuUDlCWGFjMExjZnVhN1dONC94d05wbHlzTUxh?=
 =?utf-8?B?MGt2bHRINFRydVh0YmlET2cyQmx6amdxMmtLcDJqMlhoejlNeURPelc0ZWhQ?=
 =?utf-8?B?S0trTGRJYy8zODVDYnRSNHRSNlc4NENjanZxb0lBa1BMVXY4am5VcGVMUWZ2?=
 =?utf-8?B?MEVPQVRLOFNiSHlUQWNieE42c3JFN2E1QVlFdU1qOFoxeDg2Y093clNRNi9B?=
 =?utf-8?B?TytXcE1iWHFTVXZ3a0hQbGRUdThnNTlVQVBpWFpkZEdOemJab1dMV3c3M3h5?=
 =?utf-8?B?eTd2ejNwbitoQ0lwVzFBbHpCdW4weGtaSUVHM1RuaGRIWTRLcEs3ZTV0eFdT?=
 =?utf-8?B?Yld1NEt5a2JnWkxmcmsvcnMyVG53UTliRzdTT3VWQkZiejNOUGs1R3lqUTFP?=
 =?utf-8?B?NUMyUWxvZ2x1eVhsTmQzMXk4dTU2Z0JTbGNZTXZPcWtmaXNZU1VHWEZFc1hF?=
 =?utf-8?B?MHlvVjZkTVFZTlZrUFVzMnhydk1uQnBvSi9PMzBucmNXQU05VjRLY09XeDU4?=
 =?utf-8?B?VzBYQzJXM2pmRWRlVW9WV2U5SjlOWkNobjZ1eEsrN3NBZjUrRnY4SXYyUmFj?=
 =?utf-8?B?eCs2TXREMGk3czNXTmRhU1Zab2l6OGs5cjN0M0s4YWpFM0VLbmRvN2s4ZG1t?=
 =?utf-8?B?dlQ3T1JVMHpPN3BjcmVUUjUxVkpHT2NKcHhndGpRY09ScC9FWlhrREhMaTdN?=
 =?utf-8?B?cEEvcXZlYUo0UXRjaHRzbjl5YWg4U09vK1lXOUVTZXRPODg4RE91RWFLZnlo?=
 =?utf-8?B?Y2NUVTJmK3RRU1FqcDFOSHRpQmxjRVJkSk1KdlpwRnNSWFFWZTAvZTEvUnRY?=
 =?utf-8?B?YlBoNVREaHZKcHkvYjMrYm9RVXhWUzBLTlNaVzNSK0Ewa3hpQW1qZmFueGl0?=
 =?utf-8?B?TExFRzgra01xVnNlMjFaeTZpRDZsdHNoZ3EvbFJtVEo1RXp3ajBhK2J6cXJ5?=
 =?utf-8?B?bi8yalkwNHNyZnlJUmVFWTlJTnJVc0U4V056N1dmNE5JTERYenNVZUN0RzdJ?=
 =?utf-8?B?bjhQRnk4VlBGZDBDTlRpSW5FSm5QcUhoOS9HVnQwcmd6UG9FcGtrTGs2elRW?=
 =?utf-8?B?eStNNVkvRVA4OXA5N0RzWGo3NjFJUVJuL0tTL0xGczV6S1E1ak1kbHNJdjJY?=
 =?utf-8?B?cmhacEhWVEVCdUdacnN6VlhmSHpjRksxc1AwUWdETDgzRGJHczZReno3Zzh3?=
 =?utf-8?B?VnRTZEN1VUFSOEU3SXdQSXl2N25tbXlsSGNraWN3by9LNjBqNy9zQ1kxYXcz?=
 =?utf-8?B?UWVBMUNKZXByNTBDOVZkRHFVUUs0OTlNVWNJbVRtOCtjUStxZXJ6dmRNbFAy?=
 =?utf-8?B?NlM5UVErVi9uaVFuVWpKeksrYzV3TERIWHJUa0FaN3lVMTFCNUNiZTBIRERG?=
 =?utf-8?B?LzFNS3Z4V3F4S21pZHIxSjRyYkNRWDdjdnZRc0srSWxnTEJreHZlZXlXYmEw?=
 =?utf-8?B?YzlMS1YvNGRQVVUvdzM3d241dlgvNVZYNjBwOWRKMkNCNnY2Qi9JWG44UktC?=
 =?utf-8?B?eWxyTUpvQWw1cmxsZVRuMHY2WFZrMDJGQW5PcEUxSURIYkFHbHlURXAxWDJE?=
 =?utf-8?B?TGRSOW1VOEd3UWxFK3hNNlhqc3pOdVZOcGZwQndYZUl1Uk5MTmY4QXpiMkZ2?=
 =?utf-8?B?RmJEeHdvMVdDd2NMdGtrZFNnMmI5eEV5NjVvZC92RzlaMngwNVp4bHBYc2Ry?=
 =?utf-8?B?bXY0OHNkUVZDYWdWdEVYMWNEWkxyQUJhTEhzMzRRWXNHM2NFU3pVMWhLZkpn?=
 =?utf-8?B?NnNXRlpiS0cydmJmNExxeGRkZEh6V0ppWFN0cEJ0U1dZcW56TzViWmkrS3FR?=
 =?utf-8?B?ZDRhNGQ4bTRteGVxKzU3YkdNa1FtS0c1MGRSTmhyU3h4TEdFbWV3YUhwS0F5?=
 =?utf-8?B?bXlZbG1EV2FaYUJrVDZEMkNrSE9OWUl4eDdkVGJwL0NJdTZCSG1tQ0hrWjhj?=
 =?utf-8?B?Y0FSNWxwN1cweHlJVkFxR0NZUzlWcU9oVzFWeHJ6K2VjZDczenFObHZSK2ZZ?=
 =?utf-8?B?MkNUbWJON0lYK01uUjNFSFpsaG5nYlVORmErMzAwT0hDNTdYMzQ5UnJHVGx1?=
 =?utf-8?Q?RcG3zLTbOcDAhErHKb9Eiijiu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1730e407-a1dd-4e78-c510-08dda28e06c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 11:01:43.8374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUBtyIj++mF0D2LYf1O0Cio5zBPGsXbtELo1+0bJYkqHJIvffUdUFJ1VxwuMcCCMoDYVuCNSDhMzLxpmEdlPfplANDtClGlHIHdQyPKTZNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY0IDA4LzQzXSB2Zmlv
OiBtb3ZlIHZmaW8tY3ByLmgNCj4NCj5Nb3ZlIHZmaW8tY3ByLmggdG8gaW5jbHVkZS9ody92Zmlv
LCBiZWNhdXNlIGl0IHdpbGwgbmVlZCB0byBiZSBpbmNsdWRlZCBieQ0KPm90aGVyIGZpbGVzIHRo
ZXJlLg0KPg0KPlNpZ25lZC1vZmYtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9y
YWNsZS5jb20+DQo+UmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQoNCj4tLS0NCj4gTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgfCAgMSArDQo+IGh3L3Zm
aW8vdmZpby1jcHIuaCAgICAgICAgIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+IGluY2x1ZGUvaHcv
dmZpby92ZmlvLWNwci5oIHwgMTggKysrKysrKysrKysrKysrKysrDQo+IGh3L3ZmaW8vY29udGFp
bmVyLmMgICAgICAgIHwgIDIgKy0NCj4gaHcvdmZpby9jcHIuYyAgICAgICAgICAgICAgfCAgMiAr
LQ0KPiBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICB8ICAyICstDQo+IDYgZmlsZXMgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IGRlbGV0ZSBtb2RlIDEwMDY0
NCBody92ZmlvL3ZmaW8tY3ByLmgNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvdmZp
by92ZmlvLWNwci5oDQo+DQo+ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
Cj5pbmRleCBlMjlmYjRmLi43YjkxOWQ3IDEwMDY0NA0KPi0tLSBhL01BSU5UQUlORVJTDQo+Kysr
IGIvTUFJTlRBSU5FUlMNCj5AQCAtMzAzNCw2ICszMDM0LDcgQEAgQ2hlY2tQb2ludCBhbmQgUmVz
dGFydCAoQ1BSKQ0KPiBSOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29t
Pg0KPiBTOiBTdXBwb3J0ZWQNCj4gRjogaHcvdmZpby9jcHIqDQo+K0Y6IGluY2x1ZGUvaHcvdmZp
by92ZmlvLWNwci5oDQo+IEY6IGluY2x1ZGUvbWlncmF0aW9uL2Nwci5oDQo+IEY6IG1pZ3JhdGlv
bi9jcHIqDQo+IEY6IHRlc3RzL3F0ZXN0L21pZ3JhdGlvbi9jcHIqDQo+ZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vdmZpby1jcHIuaCBiL2h3L3ZmaW8vdmZpby1jcHIuaA0KPmRlbGV0ZWQgZmlsZSBtb2Rl
IDEwMDY0NA0KPmluZGV4IDEzNGI4M2EuLjAwMDAwMDANCj4tLS0gYS9ody92ZmlvL3ZmaW8tY3By
LmgNCj4rKysgL2Rldi9udWxsDQo+QEAgLTEsMTUgKzAsMCBAQA0KPi0vKg0KPi0gKiBWRklPIENQ
Ug0KPi0gKg0KPi0gKiBDb3B5cmlnaHQgKGMpIDIwMjUgT3JhY2xlIGFuZC9vciBpdHMgYWZmaWxp
YXRlcy4NCj4tICoNCj4tICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXINCj4tICovDQo+LQ0KPi0jaWZuZGVmIEhXX1ZGSU9fQ1BSX0gNCj4tI2RlZmluZSBIV19WRklP
X0NQUl9IDQo+LQ0KPi1ib29sIHZmaW9fY3ByX3JlZ2lzdGVyX2NvbnRhaW5lcihWRklPQ29udGFp
bmVyQmFzZSAqYmNvbnRhaW5lciwgRXJyb3IgKiplcnJwKTsNCj4tdm9pZCB2ZmlvX2Nwcl91bnJl
Z2lzdGVyX2NvbnRhaW5lcihWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+LQ0KPi0j
ZW5kaWYgLyogSFdfVkZJT19DUFJfSCAqLw0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jcHIuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oDQo+bmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj5pbmRleCAwMDAwMDAwLi43NTBlYTViDQo+LS0tIC9kZXYvbnVsbA0KPisrKyBiL2lu
Y2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oDQo+QEAgLTAsMCArMSwxOCBAQA0KPisvKg0KPisgKiBW
RklPIENQUg0KPisgKg0KPisgKiBDb3B5cmlnaHQgKGMpIDIwMjUgT3JhY2xlIGFuZC9vciBpdHMg
YWZmaWxpYXRlcy4NCj4rICoNCj4rICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXINCj4rICovDQo+Kw0KPisjaWZuZGVmIEhXX1ZGSU9fVkZJT19DUFJfSA0KPisjZGVm
aW5lIEhXX1ZGSU9fVkZJT19DUFJfSA0KPisNCj4rc3RydWN0IFZGSU9Db250YWluZXJCYXNlOw0K
PisNCj4rYm9vbCB2ZmlvX2Nwcl9yZWdpc3Rlcl9jb250YWluZXIoc3RydWN0IFZGSU9Db250YWlu
ZXJCYXNlICpiY29udGFpbmVyLA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApOw0KPit2b2lkIHZmaW9fY3ByX3VucmVnaXN0ZXJfY29udGFpbmVyKHN0cnVj
dCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+Kw0KPisjZW5kaWYgLyogSFdfVkZJ
T19WRklPX0NQUl9IICovDQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92
ZmlvL2NvbnRhaW5lci5jDQo+aW5kZXggYThjNzZlYi4uMGY5NDhkMCAxMDA2NDQNCj4tLS0gYS9o
dy92ZmlvL2NvbnRhaW5lci5jDQo+KysrIGIvaHcvdmZpby9jb250YWluZXIuYw0KPkBAIC0zMyw4
ICszMyw4IEBADQo+ICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ICNpbmNsdWRlICJwY2kuaCIN
Cj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWluZXIuaCINCj4rI2luY2x1ZGUgImh3L3Zm
aW8vdmZpby1jcHIuaCINCj4gI2luY2x1ZGUgInZmaW8taGVscGVycy5oIg0KPi0jaW5jbHVkZSAi
dmZpby1jcHIuaCINCj4gI2luY2x1ZGUgInZmaW8tbGlzdGVuZXIuaCINCj4NCj4gI2RlZmluZSBU
WVBFX0hPU1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPDQo+VFlQRV9IT1NUX0lPTU1VX0RFVklD
RSAiLWxlZ2FjeS12ZmlvIg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2Nwci5jIGIvaHcvdmZpby9j
cHIuYw0KPmluZGV4IDMyMTQxODQuLjAyMTBlNzYgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jcHIu
Yw0KPisrKyBiL2h3L3ZmaW8vY3ByLmMNCj5AQCAtOCw5ICs4LDkgQEANCj4gI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1kZXZpY2UuaCINCj4gI2luY2x1
ZGUgIm1pZ3JhdGlvbi9taXNjLmgiDQo+KyNpbmNsdWRlICJody92ZmlvL3ZmaW8tY3ByLmgiDQo+
ICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ICNpbmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUuaCIN
Cj4tI2luY2x1ZGUgInZmaW8tY3ByLmgiDQo+DQo+IHN0YXRpYyBpbnQgdmZpb19jcHJfcmVib290
X25vdGlmaWVyKE5vdGlmaWVyV2l0aFJldHVybiAqbm90aWZpZXIsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1pZ3JhdGlvbkV2ZW50ICplLCBFcnJvciAqKmVycnApDQo+
ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj5pbmRl
eCBhOGNjNTQzLi5lYjJmODhkIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Kysr
IGIvaHcvdmZpby9pb21tdWZkLmMNCj5AQCAtMjEsMTMgKzIxLDEzIEBADQo+ICNpbmNsdWRlICJx
YXBpL2Vycm9yLmgiDQo+ICNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0KPiAjaW5jbHVkZSAi
aHcvcWRldi1jb3JlLmgiDQo+KyNpbmNsdWRlICJody92ZmlvL3ZmaW8tY3ByLmgiDQo+ICNpbmNs
dWRlICJzeXN0ZW0vcmVzZXQuaCINCj4gI2luY2x1ZGUgInFlbXUvY3V0aWxzLmgiDQo+ICNpbmNs
dWRlICJxZW11L2NoYXJkZXZfb3Blbi5oIg0KPiAjaW5jbHVkZSAicGNpLmgiDQo+ICNpbmNsdWRl
ICJ2ZmlvLWlvbW11ZmQuaCINCj4gI2luY2x1ZGUgInZmaW8taGVscGVycy5oIg0KPi0jaW5jbHVk
ZSAidmZpby1jcHIuaCINCj4gI2luY2x1ZGUgInZmaW8tbGlzdGVuZXIuaCINCj4NCj4gI2RlZmlu
ZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkRfVkZJTyAgICAgICAgICAgICBcDQo+LS0N
Cj4xLjguMy4xDQoNCg==

