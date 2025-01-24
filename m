Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbAsf-0005OX-B9; Thu, 23 Jan 2025 23:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbAsc-0005OH-9Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:01:14 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbAsY-0007BD-HS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737691270; x=1769227270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jZMTzgXV2ZuWn7YgIvGFYWm6bZdojFWIGNJAcCaL36Q=;
 b=VDW97cQIitM5+4srH1SJacEQjdTXBrEcPSGTG52W4SwDBN+iTDxl2Mxb
 AMUo27YltBwsAAt7jgWptohu4HjHnvkbPGStxsI2uX1T9PPWrNuReObW4
 J1fMCYG8GtFbNIS0xhZOnUkHn7/Ogkl+QV5JWEALLut+h2ehkLvUHeRpt
 ay1bAGRjtK29pyzUn56sZlo/A/vV96I+Vsdgw7dusILlYEl68ai9bdwcq
 9nnFAcESPEijIWfw1nh8SFy1o8TsFpSbUnYQziAHcKwBTuKrUgrL5jKCZ
 5MA9U2nEAIG/oVNLdMmPGMUpIikxsxdtxJgmlWoiI9iWmQK2rUNL/nUeO w==;
X-CSE-ConnectionGUID: cHzeFqdIQRuh+ipWOQgfzA==
X-CSE-MsgGUID: KdXmhEcVTG+qWovh+4HXAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37474522"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="37474522"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 20:01:07 -0800
X-CSE-ConnectionGUID: iuhqz6ayR+e3CVT+U06YDw==
X-CSE-MsgGUID: SOpRSXH6SkWdjFyj+uFrXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="112688451"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2025 20:01:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 20:01:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 20:01:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 20:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhPLPbH04KVPgMcKKsP2P3YB1HGJR9MhVRSYaGv5ayvOQB4cK/VsoVD0Wu7eSfwBguOo5Sxj1Nhp96YHk3TJn2ri62e8LAU1gu55TxirZ0tRP09+5Q8bTvpWkJT5kwbDJbB1jeJLKBTbmrQgVYrLfndHdBLg4sWuHR3V1HdZENtr9A1NihdrMN3+DJAQU6H7t2GEGgr2II0Qosc3f+fsurEPr8F48oH5pU96u//9I85Jbm4bEafiNBqaivicv5HY6lC/JY8LIClimSqvQE8C0HvOHTXtqt4GfKfrQ5dvsmNuOmUW68gfxqu6S5BF1sLvcvNcx1Cigf7AR7oGkTUQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZMTzgXV2ZuWn7YgIvGFYWm6bZdojFWIGNJAcCaL36Q=;
 b=o3aNl7/sZKTuDkYZpivkSqRY7jzVzuGUewQEd/FiYyWAB2kuLxjD3hASiWFa4nwhjvERghfc7uF+nunsSsjl18psDAKo1IWFDOnQ9CDCpwagvuOvVwyFa5Xt61zdzJI25eUSaQLt0lvsPhzSx96I3/H7D8qB5aLstWbJ3ThESDbdSy6a5NmXjdtSscZjWGwJR2tNj9aGYY3CB9VSJOI9FfGbdSBmi7Q24GyGZT+raYkTwShqJUTnnz7etsXW4ywPaoP87Q2iJInbPjipjfaesg6JKO5v1y1wqhre4VJC3inlE7qyXqTncT8Uks5+iD3UZzq0C1aYp+9IDJG1JR9DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5812.namprd11.prod.outlook.com (2603:10b6:303:193::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 04:00:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 04:00:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMgkh0AgADZNgCAAPlEgIAACqIAgAEnzgCAAHSwAIABLInggAARvgCAAALUgIAABIRw
Date: Fri, 24 Jan 2025 04:00:57 +0000
Message-ID: <SJ0PR11MB6744A84009D365C4CCA45D9292E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
In-Reply-To: <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5812:EE_
x-ms-office365-filtering-correlation-id: 3bb62090-a122-4908-b01e-08dd3c2bb554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnZ4K05uYVdwUHN0L3dJWWlZTWlhSyt0eEUwR3BmZW50ekFjSG1KZi84NCt4?=
 =?utf-8?B?U3dIaTFaWGpiNXY5N1E3bWlhWWdCYUh0UWo5cllwSXJEQWF5aVRZSVVneldS?=
 =?utf-8?B?d2JIQUtOaXUrUmVEMG8wSnJud3lidGdzOXhjWTlWSnpySHFlcEQyaFZ3Unc5?=
 =?utf-8?B?RE0yOVZ5c3M3TUpvWmYrUWd1RXJXRC9BQ0hwblU0S1FqVlVSL28xNzhJOFdS?=
 =?utf-8?B?NENWRkkyelQrdFJpSS8yZ1JvRll1eEpOQjRvVGZ0czcrbkQvN24yckk3S24y?=
 =?utf-8?B?YzVFSzlPQ0pSTVJiMitGRkVBYTdYTjZzTDZBVFUySmxoN3pVd2RzVW55S0Ni?=
 =?utf-8?B?THFScEgxbUlQcVN6NCtjRDBJQnk4MENnZmxSdjZ0ZEJtR2pQRjM3SjdRekUz?=
 =?utf-8?B?OWE4dUpnUVA0Wlg1S1FOTEwwT2lXTEMwUlQxOTNDeVRuaEQ0TWtqaGNXY0Y5?=
 =?utf-8?B?YjlBRDBNY3lwNUJuckpuWVNydE1YMDgwdmFheXJGenZ1a2JodDJnaHJGbmxP?=
 =?utf-8?B?R1JsWTZvQU5UaGM3UnZVNGRkQTk1blFFWGk3bWlaQmZpR2Q0S010V0xUd0U5?=
 =?utf-8?B?MUJqaUQvRDBFaTUxZnNNYXE5SVdEdC92RzdaVnlHNEszdTFodlh1OEN3VmVM?=
 =?utf-8?B?RzZza3FOOGZDTDZ6bW40Zkcxc05iQytzV3pQcHNSZGNxTjd6KzMxNFIxdEZN?=
 =?utf-8?B?L0hhQXlIQnZLT0U2QWZyM0l3TlhQUTRsTW0yT2F2cDhlSmFCUURFY0Y0NzV2?=
 =?utf-8?B?eld0dUFPRmdDNHZmbUhQbTVoN3Y4ZXd6WVE3WENRM2hDMEpBNlpxR2g5UUFQ?=
 =?utf-8?B?V3Myc2JuNVI5Z3g3T1ZzWEpnaWpEWVcyRDRWY0RMYUJqbzJCRW45UzJOU0ND?=
 =?utf-8?B?MExPVmREZGVLSmFnQXdsaVk5RC81OVMvVGU2cHV2YktCT0s4Q3NtTWpWU3Z0?=
 =?utf-8?B?SWxpczNPWTg4NTA5cStyald3ZUVqYVdMVHdqRjdhM3prRmFRME8zV282YWxz?=
 =?utf-8?B?N0pDbHNNb1F2QXFlZ3FwaGhueEd1eTBiVG1vcUVQUVFQb01sNCtkTXVwUWhC?=
 =?utf-8?B?bi9MQ1gvbmI1Szd2aEdFOUtUYTF3dS9LN1FDNzM1VEUwZmYwbUhaS0JqaDRG?=
 =?utf-8?B?eGNmOXJQdzRuUTRMMUQxT1VtaWxsU2hEd2c5M1hzQzZROGdvYTdJTGY3NVVk?=
 =?utf-8?B?YXVhR295d0oxT0tHNDczV1YrVlp4N2lvb212TzhqNWYxM25ZZXRKaU9wenNV?=
 =?utf-8?B?TVlIWUxaUXI4QldZaStQdkI0UjJDMk03TG9jeHJGVDdRcnJzVVZiK1BpM3Rq?=
 =?utf-8?B?cS92eDArUHE4Mk1ES3hVR0d2YTE4ZVpyR0tudmhwbnhYMjZUTklFR21jTTZq?=
 =?utf-8?B?TWdmSmlKUEM1TmUyTUs0TnFiS09vSU15YTF3WnE2NklRUWtrOGNJSkQxZjdw?=
 =?utf-8?B?enRtOUFCbkNQV0VPM0s2cE1VRThxWXJueHNPY2VMYVR6TmowTDZ4cUdQNVo4?=
 =?utf-8?B?WGxZbElnck5MYmtIVlFMYkUwRTVjVHhvcGcxa3ozU0VONVBvR3RyTExXWDBI?=
 =?utf-8?B?WGtJNmFGZ2ZBTFg2V1hxVFAreTJOL0I3VFpQdHBZRjQwSzU3a0RMWUJwZzJW?=
 =?utf-8?B?YU1TdHNENDF0NFhsWWlib0RYcjJiOGQvRmhKVEYxdmMyTVp0SzJaR3BCOFhq?=
 =?utf-8?B?NzlVSEMvUzNMUTd6M2h4aGg5N3JBUlE1QTl6QVV5UlhtRFBZWlNuWUp5U2ZX?=
 =?utf-8?B?NHVHaG9uUXUzeVh1Z0Q1aUZudEZKWWJkb3JTU01pbUpRUlRoaTcvK1BlcC9O?=
 =?utf-8?B?UzlDTWI3ZmozWTIvbzdFMWEweEV3MUloQUc4dWhyQ2xzWWtNbXBuejNaMU4x?=
 =?utf-8?B?Z1A1S3VIMXA1ZkFwQU1vT2VKUHQrNDVubDJGZ2ltUXZDUWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUpJVUJ6SDJjS0xrZlNkZjg5RVhMNnlraWpQVXMzMXM3YzNUYitodUpsZmdN?=
 =?utf-8?B?TE9DR0RkR0ppR1NjcFBRS1FuTFErRUtaandvemJHMkhpNktSUmQwQVUzenps?=
 =?utf-8?B?MVdpaisxSkFBaGVseC9pUVUxNnYyYlE2UHNPVUt6dlBod1FzcmhwS0pPUUNp?=
 =?utf-8?B?K1d1aVorMHltY1pLb3poVW9qQWdZaWVZc0Z6SW1ST1drUFlaWkJ4WXNwZGpL?=
 =?utf-8?B?WWs2ZW5jaEtrWUp0SFkwVG9BaW9NNTNremVOeVB5cFUyeU5Zb0dyZDhJUkRt?=
 =?utf-8?B?cUt3akZFZ0svam1hdWhsTFlHbXloKzJLSEh1SCtzVFNUWHNGQlVMcjFoMDlv?=
 =?utf-8?B?SEgxYkFobG9aMUJ6V3M1OWpDN3RFVlFQaDAvWktaODFVUDU3RDN5TE9hY09L?=
 =?utf-8?B?YTgxRU1LVVFDWjMwaUFPc2hxeTdMUU1mSzBHc3pjcmRYVDA5R1BGWGVrbmEx?=
 =?utf-8?B?Z0Z4WWxNWFcvUDNpeE8xZkJISFFiTGlacEl4eU1VY1FiVEgvZXVLcGlZM1o2?=
 =?utf-8?B?ZHJzeFNtdnFncXN2WkhSSExMT0ZEQ3pINGxqMFFtZ2lDWERrTThweU91MXpx?=
 =?utf-8?B?dmVBdU1XTjY0bVBIUzdzbzZMd3BvZjhOTHJpTVRBdE9JOHJKdWVRWmZKWUZH?=
 =?utf-8?B?L3Q1QWZiNTI5eVRwOW5VdGZzY1N5RVRWbHdWY2lFeEZidUJxOXVOcld6SUxl?=
 =?utf-8?B?TFE0YXN5bGcvM2ErcU1kQVRySEpONUs2OEJTa1hObVFZaUEvUlppVzFxZm5V?=
 =?utf-8?B?aDlNaTRod3lVMitmTEFVM1FQNW9haDhwRE9YWTF6QXcxZWFhdFFzb1pVSkdm?=
 =?utf-8?B?N1c4b1RJSjdkMmdHbzBuZHRmc05mZGZWSmdaVkcxWkUwT1BmTnRic2dqQ29s?=
 =?utf-8?B?VEN2cjQ2MGV4OFV5UGl4OVVkUnRnNC9NbUpQTXBYM0xjRWVJem85L0U3Rmo0?=
 =?utf-8?B?bmh0WldwZEdVdzREL01jRGlzNitjM2ZxMk4zTXVLcFhocDA3SUxyOC80Y042?=
 =?utf-8?B?bng1Q3BaZlhmbmtVRFBud1g2bWxVVHkvd1pYL3VBOC9vaVl6WkFUejlqY2xp?=
 =?utf-8?B?dU56ZU9kNko0bHlvdG14NzlmeXdqNit2T1RYSGtnQ3o0dG9CUVlaTHhOMk9J?=
 =?utf-8?B?eVRkK3RLUUdjbmJiSXpNRnU1VlJ3ZkhKbVN0UlpSWG1KTEFqRjI2bUVjUTRR?=
 =?utf-8?B?STRWcnJTcnYwZVV4Vm51cE5vMWtRUnlZRVFkRWZnQ3BJSFJyV3Bpdk1XMklK?=
 =?utf-8?B?K3VQUjY3blJSdXQ2NzN0Z2tMK1NYbUZtbWRHS1Uyc3RvMUZhdk9YcGJXcEZh?=
 =?utf-8?B?MjB5eGNuSnJaNGRqTTNjNnByUmxlQjk3aGNrVTBtam53ZGwyeCttUWhhM0Y5?=
 =?utf-8?B?NFl3NGtlUkpydmZFVUxraEY0ckJKZE9WbmlKd3BYQ2tVRWZyM0MyYWxGendv?=
 =?utf-8?B?OXcvbEFHdjdDTytuNW5NdVptVGlxRFUwd0ZGbHVlRTNWeFRReldaNmtPVHI0?=
 =?utf-8?B?Nm40elJkTXRaOUNXU1VwM0ZRK3ZVN1I0bTRVd1hyN0NYTGoxakJnMnM2Rlpt?=
 =?utf-8?B?WGlvd2F5ZnpwNnJ3TXU2WDZiMTBtV2ZSbVFIVWd2eFN3SjhTR2pLaVlIcGZD?=
 =?utf-8?B?b08zKzFmNndFODBSclBGUnZpODcrQmxiNDhhbDlFaDlXWUZ6ZCt2dVJ4a2Z3?=
 =?utf-8?B?OHUyZm52VUdSN1AwRU9LMklxMU4yV0N2SXRXMldBOEhVd1praWFxV2hydlNm?=
 =?utf-8?B?RTdIWGN1NW55NDZLL3F5bzh6WVZZWXBPQzFtRWVlQitVSEtDNmxFMndMN3hJ?=
 =?utf-8?B?QUdkYW1aeUR1alpZc2EwWlJPeUUrUkdvNHBNeEpTV05xSHBWeVQzS0dQVFZI?=
 =?utf-8?B?dnB5N1NqVUpVd1dQa0QzNlkzMlVpblNQdnVVK0UrUENYSHl4dDZXaW1ncEI4?=
 =?utf-8?B?aDkzcmtocTdYV3NTWHpVNlM1S3lrYThFZ3JYOFJnS1R1OTFxM2JZWG9pRVFa?=
 =?utf-8?B?L0xxUkVzU2RRdUZpU2NQR0hXVjQvMjdmZ21zdXhiWUVpdFVLazVpNFptd2xo?=
 =?utf-8?B?UjdmLy9yY2NVMXhQQnlPcjU0MTNPbTVzWjgxcjRhejRKb1lXSis4cEs0a1pV?=
 =?utf-8?Q?nzzrc9cThUzXbvBCVx5fDGYoX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb62090-a122-4908-b01e-08dd3c2bb554
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 04:00:57.9424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm2oFghmOCLK4gmj/PcR4nkzN7DTDSlG7p4nsiZEr9Qf2yT0PGHP0j9wMwoC7m5W4CLQVRI3R07hZn40YsywVtg1u/tvNUzuZbAdGBaQhaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5812
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaHcvdmlydGlvL3Zob3N0OiBE
aXNhYmxlIElPVExCIGNhbGxiYWNrcyB3aGVuIElPTU1VIGdldHMNCj5kaXNhYmxlZA0KPg0KPk9u
IEZyaSwgSmFuIDI0LCAyMDI1IGF0IDExOjMw4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgMTA6NDTigK9B
TSBEdWFuLCBaaGVuemhvbmcNCj4+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0K
Pj4gPg0KPj4gPg0KPj4gPg0KPj4gPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4g
PkZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+ID4gPlN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGh3L3ZpcnRpby92aG9zdDogRGlzYWJsZSBJT1RMQiBjYWxsYmFja3Mgd2hl
biBJT01NVQ0KPmdldHMNCj4+ID4gPmRpc2FibGVkDQo+PiA+ID4NCj4+ID4gPkhpIEphc29uLA0K
Pj4gPiA+DQo+PiA+ID4NCj4+ID4gPk9uIDEvMjMvMjUgMjozNCBBTSwgSmFzb24gV2FuZyB3cm90
ZToNCj4+ID4gPj4gT24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMzo1NeKAr1BNIEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj53cm90ZToNCj4+ID4gPj4+IEhpIEphc29uLA0KPj4g
PiA+Pj4NCj4+ID4gPj4+DQo+PiA+ID4+PiBPbiAxLzIyLzI1IDg6MTcgQU0sIEphc29uIFdhbmcg
d3JvdGU6DQo+PiA+ID4+Pj4gT24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMTI6MjXigK9BTSBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiA+ID53cm90ZToNCj4+ID4gPj4+Pj4g
SGkgSmFzb24sDQo+PiA+ID4+Pj4+DQo+PiA+ID4+Pj4+IE9uIDEvMjEvMjUgNDoyNyBBTSwgSmFz
b24gV2FuZyB3cm90ZToNCj4+ID4gPj4+Pj4+IE9uIFR1ZSwgSmFuIDIxLCAyMDI1IGF0IDE6MzPi
gK9BTSBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiA+ID53cm90ZToNCj4+
ID4gPj4+Pj4+PiBXaGVuIGEgZ3Vlc3QgZXhwb3NlZCB3aXRoIGEgdmhvc3QgZGV2aWNlIGFuZCBw
cm90ZWN0ZWQgYnkgYW4NCj4+ID4gPj4+Pj4+PiBpbnRlbCBJT01NVSBnZXRzIHJlYm9vdGVkLCB3
ZSBzb21ldGltZXMgb2JzZXJ2ZSBhIHNwdXJpb3VzDQo+d2FybmluZzoNCj4+ID4gPj4+Pj4+Pg0K
Pj4gPiA+Pj4+Pj4+IEZhaWwgdG8gbG9va3VwIHRoZSB0cmFuc2xhdGVkIGFkZHJlc3MgZmZmZmUw
MDANCj4+ID4gPj4+Pj4+Pg0KPj4gPiA+Pj4+Pj4+IFdlIG9ic2VydmUgdGhhdCB0aGUgSU9NTVUg
Z2V0cyBkaXNhYmxlZCB0aHJvdWdoIGEgd3JpdGUgdG8gdGhlDQo+Z2xvYmFsDQo+PiA+ID4+Pj4+
Pj4gY29tbWFuZCByZWdpc3RlciAoQ01BUl9HQ01ELlRFKSBiZWZvcmUgdGhlIHZob3N0IGRldmlj
ZSBnZXRzDQo+PiA+ID5zdG9wcGVkLg0KPj4gPiA+Pj4+Pj4+IFdoZW4gdGhpcyB3YXJuaW5nIGhh
cHBlbnMgaXQgY2FuIGJlIG9ic2VydmVkIGFuIGluZmxpZ2h0IElPVExCDQo+PiA+ID4+Pj4+Pj4g
bWlzcyBvY2N1cnMgYWZ0ZXIgdGhlIElPTU1VIGRpc2FibGUgYW5kIGJlZm9yZSB0aGUgdmhvc3Qg
c3RvcC4gSW4NCj4+ID4gPj4+Pj4+PiB0aGF0IGNhc2UgYSBmbGF0IHRyYW5zbGF0aW9uIG9jY3Vy
cyBhbmQgdGhlIGNoZWNrIGluDQo+PiA+ID4+Pj4+Pj4gdmhvc3RfbWVtb3J5X3JlZ2lvbl9sb29r
dXAoKSBmYWlscy4NCj4+ID4gPj4+Pj4+Pg0KPj4gPiA+Pj4+Pj4+IExldCdzIGRpc2FibGUgdGhl
IElPVExCIGNhbGxiYWNrcyB3aGVuIGFsbCBJT01NVSBNUnMgaGF2ZSBiZWVuDQo+PiA+ID4+Pj4+
Pj4gdW5yZWdpc3RlcmVkLg0KPj4gPiA+Pj4+Pj4+DQo+PiA+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gPiA+Pj4+Pj4+IC0tLQ0K
Pj4gPiA+Pj4+Pj4+ICBody92aXJ0aW8vdmhvc3QuYyB8IDQgKysrKw0KPj4gPiA+Pj4+Pj4+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+PiA+ID4+Pj4+Pj4NCj4+ID4gPj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYw0KPj4g
PiA+Pj4+Pj4+IGluZGV4IDZhYTcyZmQ0MzQuLjEyOGMyYWIwOTQgMTAwNjQ0DQo+PiA+ID4+Pj4+
Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMNCj4+ID4gPj4+Pj4+PiArKysgYi9ody92aXJ0aW8v
dmhvc3QuYw0KPj4gPiA+Pj4+Pj4+IEBAIC05MzEsNiArOTMxLDEwIEBAIHN0YXRpYyB2b2lkDQo+
PiA+ID52aG9zdF9pb21tdV9yZWdpb25fZGVsKE1lbW9yeUxpc3RlbmVyICpsaXN0ZW5lciwNCj4+
ID4gPj4+Pj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+PiA+ID4+Pj4+Pj4gICAgICAgICAgfQ0K
Pj4gPiA+Pj4+Pj4+ICAgICAgfQ0KPj4gPiA+Pj4+Pj4+ICsgICAgaWYgKFFMSVNUX0VNUFRZKCZk
ZXYtPmlvbW11X2xpc3QpICYmDQo+PiA+ID4+Pj4+Pj4gKyAgICAgICAgZGV2LT52aG9zdF9vcHMt
PnZob3N0X3NldF9pb3RsYl9jYWxsYmFjaykgew0KPj4gPiA+Pj4+Pj4+ICsgICAgICAgIGRldi0+
dmhvc3Rfb3BzLT52aG9zdF9zZXRfaW90bGJfY2FsbGJhY2soZGV2LCBmYWxzZSk7DQo+PiA+ID4+
Pj4+Pj4gKyAgICB9DQo+PiA+ID4+Pj4+PiBTbyB0aGUgY3VycmVudCBjb2RlIGFzc3VtZXM6DQo+
PiA+ID4+Pj4+Pg0KPj4gPiA+Pj4+Pj4gMSkgSU9NTVUgaXMgZW5hYmxlZCBiZWZvcmUgdmhvc3Qg
c3RhcnRzDQo+PiA+ID4+Pj4+PiAyKSBJT01NVSBpcyBkaXNhYmxlZCBhZnRlciB2aG9zdCBzdG9w
cw0KPj4gPiA+Pj4+Pj4NCj4+ID4gPj4+Pj4+IFRoaXMgcGF0Y2ggc2VlbXMgdG8gZml4IDIpIGJ1
dCBub3QgMSkuIERvIHdlIG5lZWQgdG8gZGVhbCB3aXRoIHRoZQ0KPj4gPiA+Pj4+Pj4gSU9NTVUg
ZW5hYmxlZCBhZnRlciB2aG9zdCBzdGFydHM/DQo+PiA+ID4+Pj4+IHNvcnJ5IEkgaW5pdGlhbGx5
IG1pc3VuZGVyc3Rvb2QgdGhlIGFib3ZlIGNvbW1lbnQuIEluZGVlZCBpbiB0aGUNCj5yZWJvb3QN
Cj4+ID4gPj4+Pj4gY2FzZSBhc3N1bXB0aW9uIDIpIGhhcHBlbnMgdG8gYmUgd3JvbmcuIEhvd2V2
ZXIgd2hhdCBJIGN1cnJlbnRseSBkbw0KPmlzOg0KPj4gPiA+Pj4+PiBzdG9wIGxpc3RlbmluZyB0
byBpb3RsYiBtaXNzIHJlcXVlc3RzIGZyb20gdGhlIGtlcm5lbCBiZWNhdXNlIG15DQo+PiA+ID4+
Pj4+IHVuZGVyc3RhbmRpbmcgaXMgdGhvc2UgcmVxdWVzdHMgYXJlIGp1c3Qgc3B1cmlvdXMgb25l
cywgZ2VuZXJhdGUNCj4+ID4gPj4+Pj4gd2FybmluZ3MgYW5kIHdlIGRvIG5vdCBjYXJlIHNpbmNl
IHdlIGFyZSByZWJvb3RpbmcgdGhlIHN5c3RlbS4NCj4+ID4gPj4+Pj4NCj4+ID4gPj4+Pj4gSG93
ZXZlciBJIGRvIG5vdCBjbGFpbSB0aGlzIGNvdWxkIGhhbmRsZSB0aGUgY2FzZSB3aGVyZSB0aGUg
SU9NTVUNCj5NUg0KPj4gPiA+Pj4+PiB3b3VsZCBiZSB0dXJuZWQgb2ZmIGFuZCB0aGVuIHR1cm5l
ZCBvbi4gSSB0aGluayBpbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkDQo+PiA+ID4+Pj4+IGFsc28gZmx1
c2ggdGhlIGtlcm5lbCBJT1RMQiBhbmQgdGhpcyBpcyBub3QgdGFrZW4gY2FyZSBvZiBpbiB0aGlz
IHBhdGNoLg0KPj4gPiA+Pj4+PiBJcyBpdCBhIHJlbGV2YW50IHVzZSBjYXNlPw0KPj4gPiA+Pj4+
IE5vdCBzdXJlLg0KPj4gPiA+Pj4+DQo+PiA+ID4+Pj4+IHdydCByZW1vdmluZyBhc3N1bXB0aW9u
IDEpIGFuZCBhbGxvdyBJT01NVSBlbmFibGVkIGFmdGVyIHZob3N0DQo+c3RhcnQuIElzDQo+PiA+
ID4+Pj4+IHRoYXQgYSB2YWxpZCB1c2UgY2FzZSBhcyB0aGUgdmlydGlvIGRyaXZlciBpcyB1c2lu
ZyB0aGUgZG1hIGFwaT8NCj4+ID4gPj4+PiBJdCBzaG91bGQgbm90IGJlIGJ1dCB3ZSBjYW4ndCBh
c3N1bWUgdGhlIGJlaGF2aW91ciBvZiB0aGUgZ3Vlc3QuIEl0DQo+PiA+ID4+Pj4gY291bGQgYmUg
YnVnZ3kgb3IgZXZlbiBtYWxpY2lvdXMuDQo+PiA+ID4+PiBhZ3JlZWQNCj4+ID4gPj4+PiBCdHcs
IHdlIGhhZCB0aGUgZm9sbG93aW5nIGNvZGVzIHdoaWxlIGhhbmRsaW5nIHRlOg0KPj4gPiA+Pj4+
DQo+PiA+ID4+Pj4gLyogSGFuZGxlIFRyYW5zbGF0aW9uIEVuYWJsZS9EaXNhYmxlICovDQo+PiA+
ID4+Pj4gc3RhdGljIHZvaWQgdnRkX2hhbmRsZV9nY21kX3RlKEludGVsSU9NTVVTdGF0ZSAqcywg
Ym9vbCBlbikNCj4+ID4gPj4+PiB7DQo+PiA+ID4+Pj4gICAgIGlmIChzLT5kbWFyX2VuYWJsZWQg
PT0gZW4pIHsNCj4+ID4gPj4+PiAgICAgICAgIHJldHVybjsNCj4+ID4gPj4+PiAgICAgfQ0KPj4g
PiA+Pj4+DQo+PiA+ID4+Pj4gICAgIHRyYWNlX3Z0ZF9kbWFyX2VuYWJsZShlbik7DQo+PiA+ID4+
Pj4NCj4+ID4gPj4+PiAuLi4NCj4+ID4gPj4+Pg0KPj4gPiA+Pj4+ICAgICB2dGRfcmVzZXRfY2Fj
aGVzKHMpOw0KPj4gPiA+Pj4+ICAgICB2dGRfYWRkcmVzc19zcGFjZV9yZWZyZXNoX2FsbChzKTsN
Cj4+ID4gPj4+PiB9DQo+PiA+ID4+Pj4NCj4+ID4gPj4+PiB2dGRfYWRkcmVzc19zcGFjZV9yZWZy
ZXNoX2FsbCgpIHdpbGwgYmFzaWNhbGx5IGRpc2FibGUgdGhlIGlvbW11DQo+PiA+ID4+Pj4gbWVt
b3J5IHJlZ2lvbi4gSXQgbG9va3Mgbm90IHN1ZmZpY2llbnQgdG8gdHJpZ2dlciB0aGUgcmVnaW9u
X2RlbA0KPj4gPiA+Pj4+IGNhbGxiYWNrLCBtYXliZSB3ZSBzaG91bGQgZGVsZXRlIHRoZSByZWdp
b24gb3IgaW50cm9kdWNlIGxpc3RlbmVyDQo+PiA+ID4+Pj4gY2FsbGJhY2s/DQo+PiA+ID4+PiBU
aGlzIGlzIGV4YWN0bHkgdGhlIGNvZGUgcGF0aCB3aGljaCBpcyBlbnRlcmVkIGluIG15IHVzZSBj
YXNlLg0KPj4gPiA+Pj4NCj4+ID4gPj4+IHZ0ZF9hZGRyZXNzX3NwYWNlX3JlZnJlc2hfYWxsKHMp
IGluZHVjZXMgdGhlIHZob3N0X2lvbW11X3JlZ2lvbl9kZWwuDQo+QnV0DQo+PiA+ID5naXZlbiB0
aGUgY3VycmVudCBpbXBsZW1lbnQgb2YgdGhpcyBsYXR0ZXIgdGhlIElPVExCIGNhbGxiYWNrIGlz
IG5vdCB1bnNldCBhbmQNCj50aGUNCj4+ID4gPmtlcm5lbCBJT1RMQiBpcyBub3QgcmVmcmVzaGVk
LiBBbHNvIGFzIEkgcG9pbnRlZCBvdXQgdGhlICBoZGV2LT5tZW0tPnJlZ2lvbnMNCj5hcmUNCj4+
ID4gPm5vdCB1cGRhdGVkPyBzaG91bGRuJ3QgdGhleS4gQ2FuIHlvdSBleHBsYWluIHdoYXQgdGhl
eSBjb3JyZXNwb25kIHRvPw0KPj4gPiA+PiBBZGRpbmcgUGV0ZXIgZm9yIG1vcmUgaWRlYXMuDQo+
PiA+ID4+DQo+PiA+ID4+IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gZmluZCBhIHdheSB0byB0cmln
Z2VyIHRoZSBsaXN0ZW5lciBoZXJlLCBwcm9iYWJseToNCj4+ID4gPj4NCj4+ID4gPj4gMSkgYWRk
L2RlbGV0ZSB0aGUgbWVtb3J5IHJlZ2lvbnMgaW5zdGVhZCBvZiBlbmFibGUvZGlzYWJsZQ0KPj4g
PiA+c29ycnkgSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uIFRoZSB2aG9zdF9pb21t
dV9yZWdpb25fZGVsIGNhbGwNCj4+ID4gPnN0YWNrIGlzIHByb3ZpZGVkIGJlbG93IFsxXS4gV3Jp
dGUgdG8gdGhlIGludGVsIGlvbW11IEdDTUQgVEUgYml0DQo+PiA+ID5pbmR1Y2VzIGEgY2FsbCB0
byB2aG9zdF9pb21tdV9yZWdpb25fZGVsLiBUaGlzIGhhcHBlbnMgYmVmb3JlIHRoZQ0KPj4gPiA+
dmhvc3RfZGV2X3N0b3Agd2hvc2UgY2FsbCBzdGFjayBpcyBwcm92aWRlZCBiZWxvdyBbMl0gYW5k
IG9yaWdpbmF0ZXMNCj4+ID4gPmZyb20gYSBidXMgcmVzZXQuDQo+PiA+ID4NCj4+ID4gPldlIG1h
eSBoYXZlIGluZmxpZ2h0IElPVExCIG1pc3MgcmVxdWVzdHMgaGFwcGVuaW5nIGJldHdlZW4gYm90
aC4NCj4+ID4gPg0KPj4gPiA+SWYgdGhpcyBoYXBwZW5zLCB2aG9zdF9kZXZpY2VfaW90bGJfbWlz
cygpIGZhaWxzIGJlY2F1c2UgdGhlIElPVkEgaXMgbm90DQo+PiA+ID50cmFuc2xhdGVkIGFueW1v
cmUgYnkgdGhlIElPTU1VIGFuZCB0aGUgaW90bGIudHJhbnNsYXRlZF9hZGRyIHJldHVybmVkDQo+
PiA+ID5ieSBhZGRyZXNzX3NwYWNlX2dldF9pb3RsYl9lbnRyeSgpIGlzIG5vdCB3aXRoaW4gdGhl
IHJlZ2lzdGVyZWQNCj4+ID4gPnZob3N0X21lbW9yeV9yZWdpb25zIGxvb2tlZCB1cCBpbiB2aG9z
dF9tZW1vcnlfcmVnaW9uX2xvb2t1cCgpLCBoZW5jZQ0KPj4gPiA+dGhlICJGYWlsIHRvIGxvb2t1
cCB0aGUgdHJhbnNsYXRlZCBhZGRyZXNzIiBtZXNzYWdlLg0KPj4gPiA+DQo+PiA+ID5JdCBzb3Vu
ZHMgd3JvbmcgdGhhdCB2aG9zdCBrZWVwcyBvbiB1c2luZyBJT1ZBcyB0aGF0IGFyZSBub3QgdHJh
bnNsYXRlZA0KPj4gPiA+YW55bW9yZS4gSXQgbG9va3Mgd2UgaGF2ZSBhIHJlc2V0IG9yZGVyaW5n
IGlzc3VlIGFuZCB0aGlzIHBhdGNoIGlzIGp1c3QNCj4+ID4gPnJlbW92aW5nIHRoZSBzeW1wdG9u
IGFuZCBub3QgdGhlIGNhdXNlLg0KPj4gPiA+DQo+PiA+ID5BdCB0aGUgbW9tZW50IEkgZG9uJ3Qg
cmVhbGx5IGdldCB3aGF0IGlzIGluaXRpYXRpbmcgdGhlIGludGVsIGlvbW11IFRFDQo+PiA+ID5i
aXQgd3JpdGUuIFRoaXMgaXMgYSBndWVzdCBhY3Rpb24gYnV0IGlzIGl0IGluaXRpYXRlZCBmcm9t
IGEgbWlzb3JkZXJlZA0KPj4gPiA+cWVtdSBldmVudD8NCj4+ID4NCj4+ID4gRHVyaW5nIHJlYm9v
dCwgbmF0aXZlX21hY2hpbmVfc2h1dGRvd24oKSBjYWxscw0KPng4Nl9wbGF0Zm9ybS5pb21tdV9z
aHV0ZG93bigpDQo+PiA+IHRvIGRpc2FibGUgaW9tbXUgYmVmb3JlIHJlc2V0LiBTbyBQZXRlcidz
IHBhdGNoIHdpbGwgbm90IGFkZHJlc3MgeW91ciBpc3N1ZS4NCj4+ID4NCj4+ID4gQmVmb3JlIGlv
bW11IHNodXRkb3duLCBkZXZpY2Vfc2h1dGRvd24oKSBpcyBjYWxsZWQgdG8gc2h1dGRvd24gYWxs
IGRldmljZXMuDQo+PiA+IE5vdCBjbGVhciB3aHkgdmhvc3QgaXMgc3RpbGwgYWN0aXZlLg0KPj4N
Cj4+IEl0IG1pZ2h0IGJlIGJlY2F1c2UgbmVpdGhlciB2aXJ0aW8gYnVzIG5vciB2aXJ0aW8tbmV0
IHByb3ZpZGVzIGENCj4+IHNodXRkb3duIG1ldGhvZC4NCg0KT2gsIEkgc2VlLg0KDQo+Pg0KPj4g
VGhlcmUgdXNlZCB0byBiZSByZXF1ZXN0cyB0byBwcm92aWRlIHRob3NlIHRvIHVuYnJlYWsgdGhl
IGtleGVjLg0KPg0KPk1vcmUgY291bGQgYmUgc2VlbiBhdCBodHRwczovL2lzc3Vlcy5yZWRoYXQu
Y29tL2Jyb3dzZS9SSEVMLTMzMQ0KPg0KPlRoaXMgbG9va3MgZXhhY3RseSB0aGUgc2FtZSBpc3N1
ZS4NCg0KSGF2ZSBub3QgYWNjZXNz8J+Yig0KDQo+DQo+VGhhbmtzDQo+DQo+Pg0KPj4gQSBxdWlj
ayB0cnkgbWlnaHQgYmUgdG8gcHJvdmlkZSBhIC5kcml2ZXIuc2h1dGRvd24gdG8NCj4+IHZpcnRp
b19uZXRfZHJpdmVyIHN0cnVjdHVyZSBhbmQgcmVzZXQgdGhlIGRldmljZSB0aGVyZSBhcyBhIHN0
YXJ0Lg0KDQpNYWtlIHNlbnNlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

