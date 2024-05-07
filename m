Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E62C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FM8-0000df-2S; Tue, 07 May 2024 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4FM5-0000bz-B6; Tue, 07 May 2024 03:35:17 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4FLo-0005ur-2Z; Tue, 07 May 2024 03:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715067300; x=1746603300;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FHC/RvquFAsrv53P1UE15YkfzvlMarM3uS+hNpW1mjA=;
 b=eA3a1jzTAPrm7mBISCRCMNV7U2USF7X8eUjYNKz1V86+hr2m+OzkJuAV
 7BhL9yQMi3FKO3A731iEI6WSHm8ENUV6hBAtbPRtB4ecvYOKXScFE+1wj
 rVhAHCWs/TJ3OR7QqhBV2hfNoFKEt+/lPLQKm/AtDcqz3aDQK1PN3vXvi
 xTJuBz7PvUkJUo1zEJP8HCmp7rRuLdpq482GUJiwuF/PjXFFEdn5DNjby
 bDE5vKUa5ZqLodMRRg6lf8DiHXPgYhmoNBzn0AzOUYVQGtj+SADjKs5FO
 z5/3ljovYVa9sbqBEgJkxOhtEAGcSYimftHQ9Sb4eJwpQ9RLkipbQnGgC A==;
X-CSE-ConnectionGUID: FhQ/87jxT+GoU8ixT/e8mg==
X-CSE-MsgGUID: SxGjUZYfTAShMQDfin8ozw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28367651"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28367651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 00:34:54 -0700
X-CSE-ConnectionGUID: WqIgnkvhS1KFNXXuJ0ramA==
X-CSE-MsgGUID: zrC7xfEISaSW8ZO3Hf64Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="33100395"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 00:34:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:34:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 00:34:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 00:34:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0MNR1NHr1ZJpU+QWMDcIg1uS4nSadr+ruaZ/RY9NS28rzn4qMlzDEUZsUu8f1LnVDAm8n18qGRpJppUeFBlWXmNUUc9E4fuOKaWDTqS4+t7sHn9JEg1AnHsrPmCvINQiw+xnI4Gq1ulY4wJD32WwCKm3n/YvaV64O1KTiN5t1j23Lh/rOeUHUxs60b2ZZeoLfqRR1RjE7RcWahXklGkKp4HwzRUga0A7NLUvWDLZIURwxCT3qps+IpgOlahATssqaeGtEvmIRaeSvm4YP1xOvlM0J0cj9qehtVewa1AoDzcJKNDJ6ccWi3IQyb+ZtyElnxgrO8GY3Ag8KZNeVw/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHC/RvquFAsrv53P1UE15YkfzvlMarM3uS+hNpW1mjA=;
 b=S+qk9aCA1Ymd3SsyRzEBGrVI2Tc9CAboH5NRKebExsa8WhY6aeSx09tCoz1paole6kk0c6g8t+5dux3Pij0kzNk+kUQOkU6EMXXMYZ48KmcVDHcSZAtRlQG0M/jZ8zdx5NKpQG3OQxjOJg9c3PnAwidoJNFOSkFjo815e6ywRgU17tzyfNWl3TiiIhnjWcC6kKVhi3L9qnf6U0mxIMFb8TpE3ljCM/0sr+lxlVzG6BJ4nDgBq8CClirSg1i5DhPOWXBPYGrFkXBJwPJZ7+Nwsr67GplGEjSwuo6Od9Fk7Wt3j90MF6AffT/83al/CssOlLjmXB64mrP0m1jodwZptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:34:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:34:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:vfio-ap" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 03/11] vfio: Make VFIOIOMMUClass::attach_device() and
 its wrapper return bool
Thread-Topic: [PATCH v2 03/11] vfio: Make VFIOIOMMUClass::attach_device() and
 its wrapper return bool
Thread-Index: AQHaoEooeQoMtihlEku2iC5fXx8IWrGLX2WAgAAA9nA=
Date: Tue, 7 May 2024 07:34:44 +0000
Message-ID: <SJ0PR11MB67441AFCCDC343645A408B3192E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-4-zhenzhong.duan@intel.com>
 <a41fe2df-62dd-4d65-ba00-45ca888dedbf@redhat.com>
In-Reply-To: <a41fe2df-62dd-4d65-ba00-45ca888dedbf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6134:EE_
x-ms-office365-filtering-correlation-id: fb1c4436-bc5a-48db-1ff4-08dc6e682a95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?RzN0M05kd0tFMWdsZkhBU0hHeTZ2eklvTE81RlBDZ1U2Qng1OGlHVlNxbHh0?=
 =?utf-8?B?TzNBOVZaTWtiVGkraW1PNVhOaFg0NERlaDYweDc1ek0zR21pd3NPTUxiQnZv?=
 =?utf-8?B?RkdQT2l5SUZINi8vZWZkeHpMUmJRSE9ERnlMRkdMVDVqdGUvSERmYWpRbVph?=
 =?utf-8?B?dXE0aEpGaDFaZFlsSmU5VFhTSDdRQmIyMzVHdWd3cnJtU3ZnbElLTDZ1VURW?=
 =?utf-8?B?NWYxek01UVhCbGpjR3YwSVdRWjJIKzVtbnVMMGJjZTk1TjBVQVFBZW1JZ25q?=
 =?utf-8?B?WTRyaUdVZmVGNzY2TWdIckFIOVQwa2VXSUdPZC92VzJ1bTloVlJiR1dQRWxZ?=
 =?utf-8?B?VWR5Y2IrdGEvYklsU29FNFNIV051THhWRkNjanVRYUs5Vnh1VS9vK2xHZ1Jv?=
 =?utf-8?B?MkRkbG5rTkFuK2JVL0NlUC9lZEpJUHJqeUh0UUxaUENSRTVRVEV1R0xkWTVZ?=
 =?utf-8?B?ZGRxcW0ra0QxZWVidHNmVldBL21od2IzV0dqbEpPbGhaTmQ4QUdwL0s2bDdY?=
 =?utf-8?B?M1A1bjhLb0NQejl3TXA3d21ZdXlBdkhoN3RDcTZQdnVTQjZCN0xFajZ3RHJF?=
 =?utf-8?B?MXk0Y01EQlpnS0ltWWJQck9QbENtZ1I4dEVJOXZBRW0rSloydFZnOHZISm42?=
 =?utf-8?B?NUFJa0h6Y2NVRXFwenp2TXN0dmxiT3hqaHgwdU9jSjh4V0Y5ZFJHR3h2ajBo?=
 =?utf-8?B?czA5K2dHbkxFd0JsYWNpTVdtbzVuekNwc1F1cEc2UXNMVXdCZzNSWWw2QS9j?=
 =?utf-8?B?N2Zvd1NwR1c1VXlaSkR5V3RnamtJRmxkOW5lQllkZFJBZnV1UmFPOU03OERH?=
 =?utf-8?B?MGtjYlROU0lUYVREemxXMU1ldGE4T2RvZFE2L1NUKzlGYkU0aWMrMUFKVERl?=
 =?utf-8?B?SVNKUEVwcmYyU1dlZlZQVDV5ODQ3SFEzYWFCbzRzYUwvOEVJTXBvZVYyZkd4?=
 =?utf-8?B?cWFwYy9oUm9maER2MU9hbGZzVm5peTg0UXR2bzdHT2pDaW5ZKzVhaG0walY4?=
 =?utf-8?B?eGp5WEtqNCtyUjIvWCtxWHEvMEhXU0pac1hNTldFMUUvM28xMGEwOGxlN3VI?=
 =?utf-8?B?UVFDSEdLdUg0a0kvVEo1OVBiVjl2ZURkNWlzcVNiaDMzSjBUUE5tZ3hmU0wz?=
 =?utf-8?B?TnFoNWc0dW13ekc0ekdsam1vd1JXNmVyVHNkeFBHTGV6T1JsS0xYVnpQS0sw?=
 =?utf-8?B?a1VTaGFUcjRlZ09JOTNBS1R6eXVIZkk4RUVlUitDM3hCS2Q1dWt4eEdNVkJC?=
 =?utf-8?B?SXJoYU12RHhSaUo0VHlSRDVxZ2JLQ0dQWms1SWFZUGRuYXlnc1NnaHVHTWVo?=
 =?utf-8?B?dVp4d2h3THgrdmlaZlZ0UDlGNnQrdklRdXhVNkxCYlNSTVI1TS9tclVMOTZy?=
 =?utf-8?B?ZXJla2lkR05wa3lqZE5QTjVTSHZVQUYwY3RRVGJWWW9Mcnl3REpBa1Vmbis0?=
 =?utf-8?B?RkwzWXRac3M3enkrdFV4MHBWbmRwRWFEWVhPQkdOUnZ3RDlIV0ZiSnNWNFUz?=
 =?utf-8?B?OVpuNUphVFA5N3QrWWNYS3hpY1BkUGRHemgzYWRtZWQxbU94UkdpemF0OEw3?=
 =?utf-8?B?RTRuRGh5ZTc1eURhZEtZaVc2a2M5bU5QZG5oOEtTQXFZTGE5VExpT2dORUJN?=
 =?utf-8?B?Ynl2cmFGZEM1Mm1OMEhvdTl3aStxWjQxamEwMGNlKzFrbjI5cWJSUDJSbERN?=
 =?utf-8?B?Y2cwUHZUZklyaUdVS2xhYUIrMWtzQWMvb3crQm0vTDRYWTYvRW1jMTNQZjli?=
 =?utf-8?Q?OwidPedNkk7urK2i+c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlZMcWxDL3J1c2NSRXVyQ0M4WE5HSDRSVVpMeVNSd0hEUG9JOUFyWGcxckJi?=
 =?utf-8?B?Q0tLRUcyZHZ4QjZTdVlxdWoyY0VmVEFWK3hXbXhNK1gvbVpHejBUemFjSzFt?=
 =?utf-8?B?aW5NQXdsaXhqcFlNY2MrckNSTEE1Z0UyTjBjdHZXS0JpRWNBSEdLSHpCNW5D?=
 =?utf-8?B?bmpXM1plZkVmS0p6dXRCVTlPR2ZtOE5qNEEvVW5NVGJmV0FRNWRCV3VNYjhB?=
 =?utf-8?B?V254VVcxYUJlS1E5Q0kxOGN3c1FlREthYkpha3lmdExoeG9Cc0FoMWRORXpr?=
 =?utf-8?B?d0IwMWpRdVZ1ZjZUQjhrUnpBam80YmRSYTBTR2lvMC9lVldxV2NLeG9pcmJF?=
 =?utf-8?B?SXJyMWZlc2N3WGFWQjUrYXZ0dTVONVpsUFR4a3U4UUVPdEV6MGZBaEc0eHVm?=
 =?utf-8?B?YmxEWEIwTXd5RnhvTXhWWXo5QVVrdXdxbUhzT3dXdEpoYlNjOXhaVk1EOVZ5?=
 =?utf-8?B?dzcrUGgweWZuaExLVTBsRlFDLys3TGwvOGVnVjVCSWp4cXMwc1BaT0RtQyt5?=
 =?utf-8?B?eHZYWUkrZlVPR2ZETWgxck9uYmI2WEQ5T1JxNUJZakhEYmkzNGhqdWxpa1By?=
 =?utf-8?B?M0RSTm1KM2xyNlkzV3BXcFZKTWo5azN3dCtxR29BNGVnU1U2Mm83ZHlCMHBP?=
 =?utf-8?B?UmxhUUdibTVYK2R0Vmg4d05VUThLOUxoUjJGanRrZHRNQjI0YVhndGNYcE1O?=
 =?utf-8?B?QmtOVlF5RnNDWGdtd3NHUEZEODlaS2VBZnNuM2Z5aVBSOUlaYzB5OXBMVTdk?=
 =?utf-8?B?bHFVYm1XNnpIMERXMkxOdHBTTFlKU3IwYndmNTA1eDMrUmxDWXdzRU1Tbmxo?=
 =?utf-8?B?dVR2Uy90RnNGWEE0SUgrMzEzVjF0OVdSamQ3My9OOFpBZjF6NVIvVlIyR1Zq?=
 =?utf-8?B?RXpWZkZoVEZ1ZFM3eWlqL3NFdGRIdVRXZDB5N3gwUU8rQVpsdG5BQnZtcEhN?=
 =?utf-8?B?WGgrVjdBU3Roa050bThreE9sd0J3SnVtRy9YVGZiZVdnbUFCZTVFenM3WGdH?=
 =?utf-8?B?SU9KSUd4MjhmOUd6SGNYaTkzaGhIYkhGVEM4TU9wNmpxeW9Rdks0anZJRy9z?=
 =?utf-8?B?bG5VUmtpNTJ5ellRczZlUXZNY3NyMFpQcklObmlud0xZSHNtMHVaa3JBVnov?=
 =?utf-8?B?eTlxMXd3TW14bmhIanVFd1hoOHFFRFBzRlA3U1hFWFMzRy85cnVkRTV6V0ps?=
 =?utf-8?B?aStXb2JCczkzK2FDeXkzY215UkNVZVdxSFJiV0VaWWNjdWx6bk1VR2hQZEN5?=
 =?utf-8?B?c3Q5ZHFLQzc2WTVvMzViSkpNU0F3ZlMvaDE3VytEN0RLWGNNL2RXYUFTY3pH?=
 =?utf-8?B?cDNyRHh6anh6Q2xScVl3ZXoyK0tjOEMrL2pERWgrZi9menNUTXFFKzZIQ0dZ?=
 =?utf-8?B?WUFDZnBiRVg0SDNndFhZQ3RRUkQvbHl6SVNkWkpxNVJDOGc5OWUxMlh2UEZR?=
 =?utf-8?B?M1FiZGJjSHFGTDZVWUZuSks0K3hvdEltQkg5QWc1UGltOHdCazAzUHZoRDZL?=
 =?utf-8?B?WlZFRlMxMUFnSC92bDR5YVBieGdXRUpHRWQ0NjJMWWsxYkJoRTV1WXJoSUZw?=
 =?utf-8?B?NUs0VzFUUkxFRVp0eGdnOVowNmhqZ0lybTN4RWxxL2xvSWF4NmFlc3dLUGVY?=
 =?utf-8?B?d2hseUNxeXk0bnRYSWRwV3F1OTZiQUZIQUJPdDNMYkR1Ky9ISGVRUElrZExq?=
 =?utf-8?B?U1kyM3NaZTV4dk1pdFpCbHVQSUQ5UjlESWJURmN1RndJNDltcjRaeHdpREZJ?=
 =?utf-8?B?Mm1HSGJCNklycmtkNTZ6VnduZVkveERJV3IxZHBDOGJGOWE3VHlkbjVvT2I3?=
 =?utf-8?B?cDdDNkwwMVMycy9uMS84SWVOS0lHdjMvUURiQmJRSWIya0FwNGZvd2dFeFRi?=
 =?utf-8?B?OGxlTG16OE1obkp2ZU0xdXl0VjZOTU1FQkRHM1hOaWhJRTJEclFUNFVhM1ZH?=
 =?utf-8?B?Y2FFaHl3eHQrSU5kcVNKbTUwZlMrYTlsZXBkQWNKVU9xODJVRHF4bTAzcUlq?=
 =?utf-8?B?RlU5dDdoSCtVekwwblpMcGF6RzJNdmUzWEVnOTZvSERFOTN4dE8zKzR6eG96?=
 =?utf-8?B?T0xpTFNOV2VTSU83REZEK2dtUnZFYlBkVHlCczJTYUZOMCtUaFZtRXBiVU00?=
 =?utf-8?Q?A6ddmII87QxbQUWUDgdFLoLRy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1c4436-bc5a-48db-1ff4-08dc6e682a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 07:34:44.9589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdwv3fqNIETUTQT26ljXytM7pUoEQLphVM4KGbfzKF3JDNEM1jZ9+xpnGbP7NUsMRJs6Hw6r79M6zgXkoivCtKHau5V6X4aMYZ4LA/jo8+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzExXSB2ZmlvOiBN
YWtlIFZGSU9JT01NVUNsYXNzOjphdHRhY2hfZGV2aWNlKCkNCj5hbmQgaXRzIHdyYXBwZXIgcmV0
dXJuIGJvb2wNCj4NCj5PbiA1LzcvMjQgMDg6NDIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
TWFrZSBWRklPSU9NTVVDbGFzczo6YXR0YWNoX2RldmljZSgpIGFuZCBpdHMgd3JhcHBlciBmdW5j
dGlvbg0KPj4gdmZpb19hdHRhY2hfZGV2aWNlKCkgcmV0dXJuIGJvb2wuDQo+Pg0KPj4gVGhpcyBp
cyB0byBmb2xsb3cgdGhlIGNvZGluZyBzdGFuZGFuZCB0byByZXR1cm4gYm9vbCBpZiAnRXJyb3Ig
KionDQo+PiBpcyB1c2VkIHRvIHBhc3MgZXJyb3IuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUv
aHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAgfCAgNCArKy0tDQo+PiAgIGluY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggfCAgNCArKy0tDQo+PiAgIGh3L3ZmaW8vYXAuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKy0tLS0NCj4+ICAgaHcvdmZpby9jY3cuYyAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tLQ0KPj4gICBody92ZmlvL2NvbW1vbi5j
ICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystLQ0KPj4gICBody92ZmlvL2NvbnRhaW5lci5j
ICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKy0tLS0tLS0NCj4+ICAgaHcvdmZpby9pb21t
dWZkLmMgICAgICAgICAgICAgICAgICAgICB8IDExICsrKysrLS0tLS0tDQo+PiAgIGh3L3ZmaW8v
cGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNSArKy0tLQ0KPj4gICBody92ZmlvL3Bs
YXRmb3JtLmMgICAgICAgICAgICAgICAgICAgIHwgIDcgKysrLS0tLQ0KPj4gICA5IGZpbGVzIGNo
YW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92Zmlv
LQ0KPmNvbW1vbi5oDQo+PiBpbmRleCBiOWRhNmMwOGVmLi5hN2I2ZmM4ZjQ2IDEwMDY0NA0KPj4g
LS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMTk4LDggKzE5OCw4IEBAIHZvaWQgdmZpb19yZWdp
b25fZXhpdChWRklPUmVnaW9uICpyZWdpb24pOw0KPj4gICB2b2lkIHZmaW9fcmVnaW9uX2ZpbmFs
aXplKFZGSU9SZWdpb24gKnJlZ2lvbik7DQo+PiAgIHZvaWQgdmZpb19yZXNldF9oYW5kbGVyKHZv
aWQgKm9wYXF1ZSk7DQo+PiAgIHN0cnVjdCB2ZmlvX2RldmljZV9pbmZvICp2ZmlvX2dldF9kZXZp
Y2VfaW5mbyhpbnQgZmQpOw0KPj4gLWludCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwg
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNz
U3BhY2UgKmFzLCBFcnJvciAqKmVycnApOw0KPj4gK2Jvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNo
YXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+PiAgIHZvaWQgdmZpb19kZXRh
Y2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+DQo+PiAgIGludCB2ZmlvX2t2bV9k
ZXZpY2VfYWRkX2ZkKGludCBmZCwgRXJyb3IgKiplcnJwKTsNCj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
DQo+Y29udGFpbmVyLWJhc2UuaA0KPj4gaW5kZXggMzU4MmQ1Zjk3YS4uYzgzOWNmZDljYiAxMDA2
NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+ICsr
KyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+IEBAIC0xMTgsOCAr
MTE4LDggQEAgc3RydWN0IFZGSU9JT01NVUNsYXNzIHsNCj4+ICAgICAgIGludCAoKmRtYV91bm1h
cCkoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIElPTU1VVExCRW50cnkgKmlvdGxiKTsNCj4+IC0gICAgaW50ICgqYXR0YWNoX2Rl
dmljZSkoY29uc3QgY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+PiAr
ICAgIGJvb2wgKCphdHRhY2hfZGV2aWNlKShjb25zdCBjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2
YmFzZWRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NTcGFjZSAqYXMs
IEVycm9yICoqZXJycCk7DQo+PiAgICAgICB2b2lkICgqZGV0YWNoX2RldmljZSkoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYpOw0KPj4gICAgICAgLyogbWlncmF0aW9uIGZlYXR1cmUgKi8NCj4+ICAgICAg
IGludCAoKnNldF9kaXJ0eV9wYWdlX3RyYWNraW5nKShjb25zdCBWRklPQ29udGFpbmVyQmFzZSAq
YmNvbnRhaW5lciwNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2FwLmMgYi9ody92ZmlvL2FwLmMN
Cj4+IGluZGV4IDdjNGNhYTU5MzguLmQ1MDYwMGI3MDIgMTAwNjQ0DQo+PiAtLS0gYS9ody92Zmlv
L2FwLmMNCj4+ICsrKyBiL2h3L3ZmaW8vYXAuYw0KPj4gQEAgLTE1Niw3ICsxNTYsNiBAQCBzdGF0
aWMgdm9pZA0KPnZmaW9fYXBfdW5yZWdpc3Rlcl9pcnFfbm90aWZpZXIoVkZJT0FQRGV2aWNlICp2
YXBkZXYsDQo+PiAgIHN0YXRpYyB2b2lkIHZmaW9fYXBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIEVSUlBfR1VBUkQoKTsNCj4+IC0gICAg
aW50IHJldDsNCj4+ICAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KPj4gICAgICAgVkZJT0FQRGV2
aWNlICp2YXBkZXYgPSBWRklPX0FQX0RFVklDRShkZXYpOw0KPj4gICAgICAgVkZJT0RldmljZSAq
dmJhc2VkZXYgPSAmdmFwZGV2LT52ZGV2Ow0KPj4gQEAgLTE2NSw5ICsxNjQsOCBAQCBzdGF0aWMg
dm9pZCB2ZmlvX2FwX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3INCj4qKmVycnApDQo+
PiAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgcmV0ID0gdmZpb19h
dHRhY2hfZGV2aWNlKHZiYXNlZGV2LT5uYW1lLCB2YmFzZWRldiwNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNlX21lbW9yeSwgZXJycCk7DQo+PiAtICAgIGlm
IChyZXQpIHsNCj4+ICsgICAgaWYgKCF2ZmlvX2F0dGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUs
IHZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFj
ZV9tZW1vcnksIGVycnApKSB7DQo+PiAgICAgICAgICAgZ290byBlcnJvcjsNCj4+ICAgICAgIH0N
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jY3cuYyBiL2h3L3ZmaW8vY2N3LmMNCj4+IGlu
ZGV4IDkwZTRhNTM0MzcuLjc4MmJkNGJlZDcgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2Njdy5j
DQo+PiArKysgYi9ody92ZmlvL2Njdy5jDQo+PiBAQCAtNTgwLDcgKzU4MCw2IEBAIHN0YXRpYyB2
b2lkIHZmaW9fY2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj5FcnJvciAqKmVycnApDQo+
PiAgICAgICBTMzkwQ0NXRGV2aWNlQ2xhc3MgKmNkYyA9IFMzOTBfQ0NXX0RFVklDRV9HRVRfQ0xB
U1MoY2Rldik7DQo+PiAgICAgICBWRklPRGV2aWNlICp2YmFzZWRldiA9ICZ2Y2Rldi0+dmRldjsN
Cj4+ICAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KPj4gLSAgICBpbnQgcmV0Ow0KPj4NCj4+ICAg
ICAgIC8qIENhbGwgdGhlIGNsYXNzIGluaXQgZnVuY3Rpb24gZm9yIHN1YmNoYW5uZWwuICovDQo+
PiAgICAgICBpZiAoY2RjLT5yZWFsaXplKSB7DQo+PiBAQCAtNTk0LDkgKzU5Myw4IEBAIHN0YXRp
YyB2b2lkIHZmaW9fY2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj5FcnJvciAqKmVycnAp
DQo+PiAgICAgICAgICAgcmV0dXJuOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgcmV0ID0gdmZp
b19hdHRhY2hfZGV2aWNlKGNkZXYtPm1kZXZpZCwgdmJhc2VkZXYsDQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnksIGVycnApOw0KPj4gLSAgICBp
ZiAocmV0KSB7DQo+PiArICAgIGlmICghdmZpb19hdHRhY2hfZGV2aWNlKGNkZXYtPm1kZXZpZCwg
dmJhc2VkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhZGRyZXNzX3NwYWNl
X21lbW9yeSwgZXJycCkpIHsNCj4+ICAgICAgICAgICBnb3RvIG91dF9hdHRhY2hfZGV2X2VycjsN
Cj4+ICAgICAgIH0NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3Zm
aW8vY29tbW9uLmMNCj4+IGluZGV4IDhmOWNiZGMwMjYuLjg5MGQzMDkxMGUgMTAwNjQ0DQo+PiAt
LS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBAQCAt
MTQ5Miw4ICsxNDkyLDggQEAgcmV0cnk6DQo+PiAgICAgICByZXR1cm4gaW5mbzsNCj4+ICAgfQ0K
Pj4NCj4+IC1pbnQgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZi
YXNlZGV2LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJy
b3IgKiplcnJwKQ0KPj4gK2Jvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZGSU9E
ZXZpY2UgKnZiYXNlZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NTcGFj
ZSAqYXMsIEVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gICAgICAgY29uc3QgVkZJT0lPTU1VQ2xh
c3MgKm9wcyA9DQo+Pg0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQ
RV9WRklPX0lPTU1VX0xFR0FDWSkpOw0KPg0KPlRoaXMgaXMgc3RpbGwgYnJva2VuLiBObyBuZWVk
IHRvIHJlc2VuZC4gSSB3aWxsIHVwZGF0ZSB0aGUgY29kZS4NCg0KSSBwdXQgdGhpcyBzZXJpZXMg
YmVmb3JlIHByZXEgdjQsIHNvIHlvdSBkb24ndCBzZWUgdGhhdCBjaGFuZ2UuDQpTZWUgaHR0cHM6
Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdHMvemhlbnpob25nL2lvbW11ZmRfbmVz
dGluZ19yZmN2Ml9wcmVxX3Y0X2hhc192ZmlvX2NsZWFudXAvDQoNClRoYXQgY2hhbmdlIGlzIGlu
IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXQvMGJlYzQ5OTQ1NmE5YWE1
YTA3OWVkMjMzNWNlMTU4MWQ3OWUyODUwZA0KDQpUaGFua3MNClpoZW56aG9uZw0K

