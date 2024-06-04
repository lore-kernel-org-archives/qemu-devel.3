Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F38FC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL9G-0006a7-NJ; Mon, 03 Jun 2024 23:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL9F-0006Qz-EJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:47:45 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL9D-0002xv-9y
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472863; x=1749008863;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FC4z/h8qjRBKVNMKhe1z3kJx/6R5hMAUlcOfdC77zlc=;
 b=K5kvE8C4onqjUiCT0TcW5YWkGKrIXJ6RttY1Gjo3oMJJiH95zWklbP9C
 ZGv02bskYQ8HrSJiuRgXmITqzG82sR2+HOgCGgOmw9czWzua8UHU+Hdvm
 JlQi1oe20vN2mKX8l0CfNbTGdzprvJkXsJG3otUsLloZkRiXvEk9J07Aq
 qtA+wyYdzkshHSbAorsvQeD6ZqbXSduDlz83uR/ABByjb5I2HUPg5hDV9
 dHaRQ2nLXJ9NZSDgWsb1EhaGnYQ7Xpcs5K59gKxGZjUJJ/wU0sMPmDmaw
 e49BguUlLa9BidxNND/3KMr7gLmiZZXPTVDwj42OUuavlk9TFWusSZdHo w==;
X-CSE-ConnectionGUID: FSWBrsq+TT2tIqoR+78AEw==
X-CSE-MsgGUID: Lb1BZKeuRiO0yQEOE0Vs8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24652057"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24652057"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:47:42 -0700
X-CSE-ConnectionGUID: HmFrqLRcQImNyQadVLGnLQ==
X-CSE-MsgGUID: woLCrxz9QTKcL71vq1IuUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37157918"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:47:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:47:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:47:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:47:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/+3DoTE4GSLT4QZTkMwqyBrC7jkiTIVIdw27y//cuyZsgQfrO5u+8XyZ5Ftla9D3BxjwDsj1F18jXa2CqotdaOPudofGVk1c3mI8J+aBog5EuADfhDRGczpWP6olGSBze/cBxkMLWea+RGeLK9jwk/EXac9QRiMk0byyy1xxNhXFYHRMMcqlzPgILuiyWPyXkxLyHLLMHWYlGONNJa8ngZu4v4ulmtO4iaPBmJwQwxfxFXSuhspLaUzhWpXCBZT6uFVK7wtx7WKzxleAPXBtJEVFzmC+B+w1Xlaz3Fm4IES4Br8JNN2zIkLkwjBulsMdR8PVhTK5700360/6TWqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC4z/h8qjRBKVNMKhe1z3kJx/6R5hMAUlcOfdC77zlc=;
 b=XVBISB1Jr7LxelhaxaESxQLTgJV/qMwPr8rlQlueXsL7uqJ4MzsWnQJCK1KsfBuAfXO1UgZ3FxitiCQxNpUgzzCX5JqJLeedDGf9QJ0ElwNAm24PgJIC7wiRh1NWuJ1eVNFYWpacfd6qGqo0XDiSFaWhoxfFIhQ6qD6P3R/SYinrPAmcX32H69W9paajy0Xyao8SRruQHvssz83yJtMXsq/73NDbKm7JFt5YD0KMgwyfgttymgkP/exlECnTXUmEQo4OsDo8K/x8/6pUTlLrSGwTbHmBn6LwEQm2/sA8bcpubt79YoVtXXg5jwnFRGTiAhPsAURaOFfwuc6x+ntAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 03:47:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:47:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 13/19] vfio: Create host IOMMU device instance
Thread-Topic: [PATCH v6 13/19] vfio: Create host IOMMU device instance
Thread-Index: AQHatX1C1dYGky6fNEal/iqLPLAMAbG2AOGAgAD36bA=
Date: Tue, 4 Jun 2024 03:47:32 +0000
Message-ID: <SJ0PR11MB6744E25A8EB8E3DF4614E3D792F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-14-zhenzhong.duan@intel.com>
 <70b5f291-7615-4aa5-9f89-c84339dba9a5@redhat.com>
In-Reply-To: <70b5f291-7615-4aa5-9f89-c84339dba9a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8188:EE_
x-ms-office365-filtering-correlation-id: 5e512620-6b65-4fbe-c1aa-08dc844910d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?dEZHOE5VMndqWE1adzNZUDNieXNyQVhFQmR2akdjU0NrZlB3MWJwMWc0TXpG?=
 =?utf-8?B?WVF1bFFGbm1Uenl3S3NWL1ZnMzRQcXlXNE9aZC9CWmFYeUg5dFBRam1yalZ2?=
 =?utf-8?B?WmhZYzBwNk9ndnVBa1BBZmkrc3F0TXFoUkNJNGVCWmxqQVd2ZW1iNE9CZ2ta?=
 =?utf-8?B?d2ZHU2NGN1VpYVhJMjViS2lkZ2dNWmJyTGhZU3d2WE9kSXBQR0dsVmpNdTFF?=
 =?utf-8?B?TWZzc2ZuZ3ZMRnZaeC9pN01Jbm9VdW50RzEwSzhzRjZsWHdMeHBMSGFyUmlI?=
 =?utf-8?B?QUxqZ3BRNVZ3QXlycWhlKzBTem9WU2lsZGdLUHB5Qm1SZ1RXTkJoQkpKR3A1?=
 =?utf-8?B?QzNNZHFTTEFVK0l0MDVTYWdTcVBxdHY4N0hrNlJnc2VoLzBHVUg2ODNOYlBT?=
 =?utf-8?B?VjZOemRrQkNtZGowZ2YwdEcyUG1vUjdkWWpNSHE1U3dERnFiZXd0SkZIYU1a?=
 =?utf-8?B?TjR3cDExMFZRVnVGbEVPTVFHRVVvWGNuTlpjNmVlVmRGRlF3czlGaHovNDMr?=
 =?utf-8?B?SHcyejR6Q1g2M0FWM3hrWnl4aHJjU3Z5cFcyWjA1ZWFPS0hwbjlqbk5mZGJY?=
 =?utf-8?B?UnNQQkZWRGhaYzBQcEFGa2lGS3crMmVpTDJZMk1RSmJNTTJOVHg5NDFCdmxm?=
 =?utf-8?B?QUtuWFIxMmZ6Z05WV01UNWo2YlNTNGptZnRBRkFzbzcycGZGMURlUVpuUlZu?=
 =?utf-8?B?aUtsWGxHRlFFdEhsVUZRTFhmOEFUOGg2dzhMTDhINWJQS1pFZ05SMjl3WnUz?=
 =?utf-8?B?UkpXaGd0eDdUbm9aVEZyN2lTUUdQZGlvUlV6UmcyZWt3bm4xMUptUnZhOUF4?=
 =?utf-8?B?SkhGdkVRazZycnhyZUZROTArZ0hPWHZBTXB6TXNIVnZuUURSMENaWWw0cGNS?=
 =?utf-8?B?bGhteEF6MzRvZGNRQlpBbzRPV0xkY1VRcDNUekdRbjNiT3JSSDB4ejhWSG84?=
 =?utf-8?B?Y1hTYjN0OVdnbnZxZWFFeW1MeHNPS3loa0Y1SCtONGNmdmVVV0xFd1dkVGdS?=
 =?utf-8?B?SXFyQUVGNUwxeVZHYUZKTkhNYXBVQWF2MEtpbnprMmRwRGw1dHc2QUtIb3o1?=
 =?utf-8?B?dVd5Y0hORXZpQWxLYnc5bDNHdXRFN01QQWU4aFRBdEYvdWN5d3o4MHFBT0pK?=
 =?utf-8?B?TkdDLzA0cHJaMlQ2ekhzbnFZOE01MjVobmVOZDJDOHp5QkUreDdrVU4zTFcz?=
 =?utf-8?B?RUFEL2YwRHp5QytoTktuNzhuTStiOGNmWmZHeTZnMi8xa3RKdlhvdTE2dTF6?=
 =?utf-8?B?RHFVMFJpMEZYN3pJWlFZRzlFUnRUSG1DU2dQUFh6UlBvNytBOUpRaHYzcHdp?=
 =?utf-8?B?U0NOT2J0N3p5eGsvaTRjb0RLS0RFWThjVGtBRngxWnlyZTF4V0o3dkVpYjZ2?=
 =?utf-8?B?SUZHM2xiK3VUdk5Yb2ZMbVZsTUFDN3JUaVBLRlVOY1pqbDRuWG1wWGxsSTFs?=
 =?utf-8?B?TDFKSXViTHBpN0ZYZnpLRERRVU9CZzhxMkN5RE13MmRmMjZNc1FON0RGQnEw?=
 =?utf-8?B?V3V0dWVrK0xHYnowUHBlQWgxeUk0VmI4Tk0vcFQzSGpLNUM5V3RYbUtPam5l?=
 =?utf-8?B?R0VFdjIxTEhCNUVDRHdoUGVKa1g0ZzlLWFJJVGV4aHI3bVo0bkVFa1l6ZzZD?=
 =?utf-8?B?cWViYkpub2U0V1JBQnFFZXYwMDFROXdqRXJaT3JaTmF2Mk9vM0h6NEhGYk9p?=
 =?utf-8?B?QXZmN3E0Mzh4SHJ2R01uUWs5SXEwOUtJSVNxVDBlRUtjWlI2d25MUnRRbmNI?=
 =?utf-8?B?VS84aHpBdHRnc0tySVBuQ1lpcGRYaG5aM0FwNDUzdzhGbmI2dHBGOVhDZVpK?=
 =?utf-8?B?cXIxMXpXQTc3MGRFZVM2UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlyZjladE9TdmgzejVhUVE5eXJENTdRdXFYVHM3c05EM080WDF6ekc1cnZZ?=
 =?utf-8?B?M3ZkMGVmMWltRlB6b0pGOG1JYjl4b2NNbjRMRkxWRFYyenJIY09iZmxmaUFF?=
 =?utf-8?B?UGZIT3FsSUtscVd5eis5b2lhSjVOR2MrYmlReUFBRi9rbFNFUVF6d3c3YlZn?=
 =?utf-8?B?d3pvZVJpUytZVGJwNjVRNmI2eFhpUmMxQzNSL1JNUDFPbTZPam9Da0owNFdB?=
 =?utf-8?B?WmgyT1BMaEQ5UXY0ek1VdTJwelBMczdPbTBXTDlSNEZhYXB4Q0RIWm1uTFhS?=
 =?utf-8?B?VExVWHZXUnM5T1JHbHhYTnVYRDg2eG55ZDYzbVRIYXBLK1MxbHJNOUhVaDI3?=
 =?utf-8?B?ckwxUHdjWmZ3YkJ2a3dveEhERGgwUkpCS3VXcTM5ZnczTG9pd085Slo3M3JV?=
 =?utf-8?B?S1MyMWJEWWhxQzNFUE9tc2UxNVFrMk1vd3lnZzZNUktjbzRWREtURVo3a0o0?=
 =?utf-8?B?a2d1R1piNktDdmhGd3lDbW1nRkJVTkJwTW96SGdycm5uREhYOWl0MUttOThz?=
 =?utf-8?B?N3ZGOVpRZ1R1ZTdmNnpsYTdlaGFZYXZzOVZvQit5UnZnTHJ4aHkxc1hGR05X?=
 =?utf-8?B?YzlHUnpTbHVubEJvcUw2VkdDek9LbEFMMzFsUGNVMnprM1BnYmtDUmp4bUhN?=
 =?utf-8?B?ejdwYzdZWjNLaW9Sd2cyZDFrRnVrMXo5RHVscFpoWHNqVkhTaWtwUnJKOVUy?=
 =?utf-8?B?OXIvakhBeGc5cGxlT3lYRjVmeENBcnBpb2NUUmI4WnBFZ2VrNjFUQ1NLL2F5?=
 =?utf-8?B?dFdTaTBPUzIvczg4dGVGRFYxNGxETmcybGtaczJKRXM2Y3hXNUZzYzZkWkNi?=
 =?utf-8?B?Y2ZtRlRKQkN1dUJFSGVvYlJKYjUrMG44eUZaaXNRNytoeUpOZjB0Q21oMjFW?=
 =?utf-8?B?bkQxei8rSGxHbW5hVjRTVTZSa2tsTFJxelBIRVlGMDFBZW1oUXE3TXhPeXZB?=
 =?utf-8?B?RzlySXNkalUzWEFYOFZCZ05udWp3TG9scjJjeUJpRElXTjNNSjNtaUhBOU5q?=
 =?utf-8?B?WjJjeWtaOXJTRnBwQVc2QWcyaFVXSWJnTkRYN2xxclBMYzc3Qm1oUDVjR29z?=
 =?utf-8?B?Z2JrRU1hNm00UG54dC94Z1E4Mk83ak05N3dETWFHeTBXTnNDcDM3eUhUb1Vo?=
 =?utf-8?B?alhSc3docVlWajZSRmYwbDlYYVR1MU93elhBeldMWmpFamx1cHkzeWZmWTA0?=
 =?utf-8?B?OUlENFJSc2o0aVVvL1JmeEFlUEdrWDFXdjVvbWgxWDRQUEx4S3N6Mk9Nalpw?=
 =?utf-8?B?cXVtYUMzUERpQ09FMlR1NWo2MVlOSlI0N0JFbmtCaGpsYlpnMk05UHpoS2Rz?=
 =?utf-8?B?ajBPY25xdUFBMDB4YU5MUzhTSXNqRHJhYURhZEQyQnFyb0s1YldHSzJ1TUNh?=
 =?utf-8?B?WEcvTmxEK29XbGExbVdkVjE4dFFhU3dKZTVDbTMrSjJEbWM0ZXZFU0xuMDZu?=
 =?utf-8?B?eGhEcDRlZG1BQk45dzZMcjdlVkt6enJpeEdDakZIREpLOHMyWjdEbXBBY0V1?=
 =?utf-8?B?Y2pLenZZS1BLb2NicDgxeWlSbUFUQmhJeFVIZStxMDJwT2NFUklndGJtbnh0?=
 =?utf-8?B?TGp4T0JWcE42QTJ5aE1SSlAzTVdzM1A0V2xQdzhWY3V3b2h3K2pOR2Y0amg1?=
 =?utf-8?B?UGw3ZFdXVm1IV21kaWpyeVFaaGxwcFgxVG82V3NiZnJqMmFBbm9iMkRuN3Rx?=
 =?utf-8?B?SllRbyt6alZCc3FsNlNMa3J0WFg0TmhhUU1FNmw3N0pKMDNQTXJaY0xrQ1hs?=
 =?utf-8?B?V3A2RW05aTZhMWJUSWpoNUpXaC9iV081UE9BckptcWlCeVhRVXozekZ3c3FZ?=
 =?utf-8?B?YlZxSDhwTVhCb0VMR1gvSjgySG1ocGpjWmhTRkV3QmtaTjNLclRVbFVySW5Y?=
 =?utf-8?B?WFpHT25JZk5vb3VhWDBIM0VFVFBtaXRPdmRVemZGendmOVRtcjhBNXRrSSs2?=
 =?utf-8?B?S0YzczdmTmdIeldYSmRKcjFZRFlHZ2VtRVpCdXRUdVRhT0VXdHNEN0tqZ2tX?=
 =?utf-8?B?Z291dzNDSWl4N1M1Q2syeGxVazV0MlBBRXh6bERFMmtVNU5BSE1vSUptbjgv?=
 =?utf-8?B?MDZqb1pUdEpTRUh5WE1RVGVXVHVHYjBldndpdHhGbEpRcDE3UTR4NjFoa2M3?=
 =?utf-8?Q?VUHxXlSafxwRrbqxQRKOOcFtq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e512620-6b65-4fbe-c1aa-08dc844910d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:47:32.9240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zS+DXGJeZfoSI7GQzCj8sBljvKPLrR1vBQXFBJ88xIeOgPGPd3pnXSFhxWm804ccsBDj/yQ7GPDUV5xZySI9DdVAJoTql4cqnMldD0vHQbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDEzLzE5XSB2ZmlvOiBD
cmVhdGUgaG9zdCBJT01NVSBkZXZpY2UgaW5zdGFuY2UNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+
T24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENyZWF0ZSBob3N0IElP
TU1VIGRldmljZSBpbnN0YW5jZSBpbiB2ZmlvX2F0dGFjaF9kZXZpY2UoKSBhbmQgY2FsbA0KPj4g
LnJlYWxpemUoKSB0byBpbml0aWFsaXplIGl0IGZ1cnRoZXIuDQo+DQo+SSB3b3VsZCBzcXVhc2gg
dGhpcyB3aXRoIHRoZSBwcmV2aW91cyBwYXRjaA0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+RXJpYw0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bW1vbi5oIHwgIDEgKw0KPj4gIGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwgMTYgKysr
KysrKysrKysrKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1vbi5oDQo+PiBpbmRleCA1NmQxNzE3
MjExLi5jMDg1MWU4M2JiIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMTI3
LDYgKzEyNyw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2Ugew0KPj4gICAgICBPbk9mZkF1
dG8gcHJlX2NvcHlfZGlydHlfcGFnZV90cmFja2luZzsNCj4+ICAgICAgYm9vbCBkaXJ0eV9wYWdl
c19zdXBwb3J0ZWQ7DQo+PiAgICAgIGJvb2wgZGlydHlfdHJhY2tpbmc7DQo+PiArICAgIEhvc3RJ
T01NVURldmljZSAqaGlvZDsNCj4+ICAgICAgaW50IGRldmlkOw0KPj4gICAgICBJT01NVUZEQmFj
a2VuZCAqaW9tbXVmZDsNCj4+ICB9IFZGSU9EZXZpY2U7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZp
by9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+IGluZGV4IGY5NjE5YTFkZmIuLmYyMGE3
YjViYmEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+PiArKysgYi9ody92Zmlv
L2NvbW1vbi5jDQo+PiBAQCAtMTUyOCw2ICsxNTI4LDcgQEAgYm9vbCB2ZmlvX2F0dGFjaF9kZXZp
Y2UoY2hhciAqbmFtZSwNCj5WRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ICB7DQo+PiAgICAgIGNv
bnN0IFZGSU9JT01NVUNsYXNzICpvcHMgPQ0KPj4NCj5WRklPX0lPTU1VX0NMQVNTKG9iamVjdF9j
bGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpKTsNCj4+ICsgICAgSG9zdElPTU1V
RGV2aWNlICpoaW9kOw0KPj4NCj4+ICAgICAgaWYgKHZiYXNlZGV2LT5pb21tdWZkKSB7DQo+PiAg
ICAgICAgICBvcHMgPQ0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQ
RV9WRklPX0lPTU1VX0lPTU1VRg0KPkQpKTsNCj4+IEBAIC0xNTM1LDcgKzE1MzYsMTkgQEAgYm9v
bCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwNCj5WRklPRGV2aWNlICp2YmFzZWRldiwN
Cj4+DQo+PiAgICAgIGFzc2VydChvcHMpOw0KPj4NCj4+IC0gICAgcmV0dXJuIG9wcy0+YXR0YWNo
X2RldmljZShuYW1lLCB2YmFzZWRldiwgYXMsIGVycnApOw0KPj4gKyAgICBpZiAoIW9wcy0+YXR0
YWNoX2RldmljZShuYW1lLCB2YmFzZWRldiwgYXMsIGVycnApKSB7DQo+PiArICAgICAgICByZXR1
cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaGlvZCA9IEhPU1RfSU9NTVVfREVW
SUNFKG9iamVjdF9uZXcob3BzLT5oaW9kX3R5cGVuYW1lKSk7DQo+PiArICAgIGlmICghSE9TVF9J
T01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpLT5yZWFsaXplKGhpb2QsIHZiYXNlZGV2LA0KPmVy
cnApKSB7DQo+PiArICAgICAgICBvYmplY3RfdW5yZWYoaGlvZCk7DQo+PiArICAgICAgICBvcHMt
PmRldGFjaF9kZXZpY2UodmJhc2VkZXYpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4g
KyAgICB9DQo+PiArICAgIHZiYXNlZGV2LT5oaW9kID0gaGlvZDsNCj4+ICsNCj4+ICsgICAgcmV0
dXJuIHRydWU7DQo+PiAgfQ0KPj4NCj4+ICB2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2
aWNlICp2YmFzZWRldikNCj4+IEBAIC0xNTQzLDUgKzE1NTYsNiBAQCB2b2lkIHZmaW9fZGV0YWNo
X2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+ICAgICAgaWYgKCF2YmFzZWRldi0+YmNv
bnRhaW5lcikgew0KPj4gICAgICAgICAgcmV0dXJuOw0KPj4gICAgICB9DQo+PiArICAgIG9iamVj
dF91bnJlZih2YmFzZWRldi0+aGlvZCk7DQo+PiAgICAgIHZiYXNlZGV2LT5iY29udGFpbmVyLT5v
cHMtPmRldGFjaF9kZXZpY2UodmJhc2VkZXYpOw0KPj4gIH0NCg0K

