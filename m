Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5587CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthgm-0002Xz-1u; Wed, 03 Sep 2025 03:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uthgk-0002Xb-5S
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:13:50 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uthgh-0006YQ-HD
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756883627; x=1788419627;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KuwmJSeN3hyR5AoxW3hp/8ob8BqZILUzG5wO0t4L+tQ=;
 b=Yg0U4LZ8oXma40y+XhJq4P0u8hGpsPrIxppeh199j0GolwJU0RHcT5t5
 WGi9xgqoqc34wxbaYap9hnwxpkcUQhpDT4FiP65DP1KHzoxgZzFEgmC76
 SMX+QsA+oA99otAAUFSXBUXd5PEri/E1wfjJ0qOrRXPBGoqQr1E0cRiae
 8Pb8M2i+BKnXpT3iXZC1AR+bXTe33fzqEKvS0V6Sj8pTyYm4SgTzIHvAj
 9wQUrQ8lmxWmlyOr8FwbG+rgqX2ysj7L/QHGCBHq7KQ53L8V4FPAnqK7h
 fBONJpntj2xsMB/hZK1CAQpFU1LIwBzUK7JyUr4rSsEQlu2ZvZPgeafXX g==;
X-CSE-ConnectionGUID: biQ3+Fi4SEa6bnlK6MN8sw==
X-CSE-MsgGUID: Nu2JIO7AS8+FtraP6Q9UwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69888512"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69888512"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 00:13:30 -0700
X-CSE-ConnectionGUID: 3/mpzrj8Qe+GhImrtyRtzw==
X-CSE-MsgGUID: VfLWNQPrQWyqvcZSIJuLfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175879045"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 00:13:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:13:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 00:13:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4fdw/hqfUVO7aOEOxdpSVYV8Ul1TNp9NdjH3w9GFZB1k+yODleR2VLEbaCngn1A9DQXLzZAMHvJeRVt2WZhiA4FXHQA+6idWmjJxiajuSceV+Qjp470fOsAjzdxlYuwUq73grVD+4oZfGbjKzkM9QLOOynZ+nGMdc+PTBUpeQ8qk6W1rNXP+r6Pne0xo9gmkaOMtxpedUP+pj4y5Kz9zpY5Eke9X0VqJRX27CQCn2RxaCDunnfaG6uQO+r8ODpnIItyq9QjaBR+BtnfgzYDM6XEPWjrRxJ63BIKDYROa+kQZ/6EGDUOXZE/UGB2O5qxx/x4la/weKnPM32n3FSDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuwmJSeN3hyR5AoxW3hp/8ob8BqZILUzG5wO0t4L+tQ=;
 b=LI8fmdVYfYAWQ6Ru2WcGSvft46RigbZJIFCyxAmDa0FdgPkxtbduvymIegCQuWYn+zrYSYF6rP5SYaSNGTOTAryHGeTrLf9Ksn5oFst7M4ivfp7chDP5xx8qJTKB0DjlZ+ph91PQbqf3hT97jT8U+mFPs0ETT/+DRLjdRQTCAIABb+MnySNuFbxvQi2+sbwqVrMMmTAapRngf17wg1O/9gl9mkUv73a1O11i6HyPAENADvaj0nLFcP+Bm8DLbZ3f2ZDM5Z/A74KBmZbsl7OvAEMJkKuIFMS6aLySOMz0J0r+rKB2TGCevkJ0OSx2ge5iouk2hthIDtgqrSqHuINFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 07:13:27 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:13:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Topic: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
Thread-Index: AQHcEy/mQAz0RvAeWUKyLIetcP08vLR3+YCAgAXhv6CAAzbmgIAACkag
Date: Wed, 3 Sep 2025 07:13:27 +0000
Message-ID: <IA3PR11MB913623AAF14892BE5CCEA6549201A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-11-zhenzhong.duan@intel.com>
 <a8e8ed01-8e37-467a-8e95-8afc2f6a16e3@intel.com>
 <IA3PR11MB913629651A0A69304F18FD719207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bff21f8a-3051-4c32-bf75-50dc0876a424@intel.com>
In-Reply-To: <bff21f8a-3051-4c32-bf75-50dc0876a424@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5093:EE_
x-ms-office365-filtering-correlation-id: d7d91ff4-c01d-4de0-316a-08ddeab960f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cWdrdlRJNFJUTWFGTVlmWWZnVHRSUGFnUVNtbkV3SEVDWGM1aUFENjBTalV1?=
 =?utf-8?B?VXY2VUNTWnNWNVpCb3M4MjJHcFl1NE1Qb0pTMzFTRzgwc2RKTkFiejk3OW1o?=
 =?utf-8?B?b0JES2ozSGJSa3QyVjFLY3VrdTA2YndpR3NTN2E1TTVpL2pMR3REekZuN29S?=
 =?utf-8?B?dDI0UW9IakxWVTlLOXJLVitHakFsSTBZY0pQQmZlZEQ0NVhHWEJ0UUFmSjZW?=
 =?utf-8?B?a2Z6WEkrMzVKYlRIMCtYb2M1RXl2S2dqdlAzSEUweXoyaGRWUUVFVWF2NzRR?=
 =?utf-8?B?ODkxSGZMQk5BclFzKzhGQkdqc09KWUlzY2pYY2RBelBOQmtoM1hpcWpaOTQz?=
 =?utf-8?B?aFVhU2RGVmQwdnFreGIzUGsxSWlFVXZSdUdDMnJzNkdUUFZXdmY3YXFBc1ll?=
 =?utf-8?B?dnZoUDhVZ2R3ZlpETHJML0pYR0VFM3ZNV2xoc1NVb3hqV28vU2lveDFtMzNr?=
 =?utf-8?B?WC9QdW9UZ0lvMGZ1dkFrQ2w3OWptMGxKRktXSzhQamVtYzQ1RUpMSmtXa3Nl?=
 =?utf-8?B?b2c5S2Q4cEM4cU5iQm5UdFF5ZWs5N2Q1ZldzZEdKS2U5N0hlTHZ4QVZGK2RF?=
 =?utf-8?B?dkZnUjNEQlZKb3dKeFVxeG51MkRCa1NmVzB6Q0IrMFlhK3loMjlQclRWdTZu?=
 =?utf-8?B?L2ZNckJzN0lGM0VNOUZ3YXpQWnNLWHhibXhYQkpuL3Rac0I3ZUxCWHgxV0FF?=
 =?utf-8?B?SUd3aVcxN0MwTTJTRWdBNlVITzJ5T1BSbzMzcUc5dU44M2FmRi9zNXFtTG96?=
 =?utf-8?B?R0xvUlNyZ3EwMmJnNnBJcTZEYitOK25LZ0pOOWF5dzFEZ2Rsd2hvblIwSzlS?=
 =?utf-8?B?ek1BNGcwNWZVYzN2TTc0eldoTy9pY3VJeEFKVDZLbElrUnZwVHF6Ujl1K2JO?=
 =?utf-8?B?MGZPKzFzUnV1TVZ1b1VMS1NGMFRPa1I1UnRYZS9SKy9FRWJQV1FsbXljcnFD?=
 =?utf-8?B?TnB2aXFCeVkzblFmSHdtNlkva0w0Mm85a3dvTFBQTkx6Y2NJeUxtQVZtL0o2?=
 =?utf-8?B?dEVEOXluaWFoNUtSdTZ1SWVtd2VRNDN3Z3dtbitBTHJibzA3a3VtT0ZVd3NR?=
 =?utf-8?B?RHdMa3FicWZZT2N4dGQ5UFVMMWl6akNxMU1RcGJVY1pmY1FwazRkZkcreWJ2?=
 =?utf-8?B?cGxVaktJK3pSK1cvZ3Q3Zk5DWml6bUhjTHVseEhzZzNGT2IweU8wMUVuaTJn?=
 =?utf-8?B?R1RybXNlQ0ZibkVOb1NmOU81R1ZXWnVsVFlDclIzUGZqMWlNaUtiQVY1QmFj?=
 =?utf-8?B?Mm9RWFpHcFhjb21OUHBUc3dHbktiL1ZCN3ZhTmdZZ2VLNDh6L2YwdzZOOUF1?=
 =?utf-8?B?V1doei9saG10ZkYzeGZyY1dVcENYZkQwYjZmQWNpazJ5cldNdm05azF6TVdn?=
 =?utf-8?B?RXNWSnB4bTdoRkRWZzZWRmhHcjEwdVRkNTVHckQzaXAyZXpTYmdMTms0Kzhm?=
 =?utf-8?B?Yk5UbFk3TmU2SXFrU3ljUytIc0RzTUlHcUNEREkzSDNIeUpMUTNiTEIyTWFX?=
 =?utf-8?B?Q1ZiSVZHZTB4TkpjK0J0akhvN2dIUW5rMzJPeVRtWGlVZFkzQzNZNThtcmJU?=
 =?utf-8?B?cWJsbmIwTTBLNVFPTjNIWjl3QmFzQXlxRjZHTS84bzJacklreTAxcWROYiti?=
 =?utf-8?B?NDI0VnExVU9QVXQ3ZmR6SHIwclRYQ05ENjQ1U2NyRmF1MUhoRjlTQzhYcEMx?=
 =?utf-8?B?MWlpd2RQNUgyaHpjelUzdW5LM3ZSaC9Sc1B4NkE2TWdZemhqZnVKUEhEUnlF?=
 =?utf-8?B?RFRRd1l2eVdIUitFYm9Qek9jVDVHcnkzNHFsUlpBR1llNmJkRzRyd29vZ25a?=
 =?utf-8?B?WC9FWjBES21aVFNtNnFFQmViNStMUlAzNGFmbm1DeXpGajY5SkkxT1JWSzJw?=
 =?utf-8?B?clkzV1lPSFNDYlRSeXA5OXVibHp5MFFCZitlSkFTa3JybVhoZGUzNVhUQ2xN?=
 =?utf-8?B?R2F4d2pRamo1NG9NaStuWE5MbXVYaTYyZ0Y4TFlrSkRNclpDS1dyV1lBSEZo?=
 =?utf-8?B?bUw2UVRsY3dnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjFDQ2pNN0lwUGtOYnZ5REtSRDNsSzhzR2h6ampZNWRvemFxbEpVWmM3TnBj?=
 =?utf-8?B?YmtyS2dkYVpWUFBZb0F5cmplaUQ2bTZiR2NUZDdnOWZXOXpxUWVPbnkzcytq?=
 =?utf-8?B?ZkFtaG1OcG9qS1VybkZCek0wL0JOeEUrakgzMWhPeE5LaVFHaEdwOGtiM3FT?=
 =?utf-8?B?Tk1rM041UXhJVHUvZGJ5UFB2S1hBS2lOZ3VndEVieS9QMlRPbHBLU0poVUR2?=
 =?utf-8?B?ajRoSTRUVkpLR1pOVzFSbGkwdkx0cXd0eVU2SmtuWGJUS01iYlV4STI2bGtZ?=
 =?utf-8?B?VnlsZW5URnJJNElNTmVYOGhwYUg4SGZTekhlM3BjZS9EbzNGelpJaUFrbkJR?=
 =?utf-8?B?R3F2L0VzVW0wWGY1c2ZjZjJaTCtWUkJQcVJCemNUL3E4M3dZdXRXNW5zSnl2?=
 =?utf-8?B?ZkI1MjFZcitsajhYNTBiNS9MZmlBR1cxZWlWdzhrVEV0ZVJ5MUdXcHQzWGYw?=
 =?utf-8?B?VzViWWpEUlVEMFkwRVpwaXRHL0U2cTZuakYwL29WNGtZNXZQdmkrVjZaMHFF?=
 =?utf-8?B?cTdJSnMxRjBhZk9UT24xYjN4ZGdCdVFoY0xJWmowdldmcWd4aG1RR3d4RnhO?=
 =?utf-8?B?aGNTRFZHK285UVd6UXpDNFlSd2N5ZXduT1ExVGpCbVpQNVJaTTRETjdxRVA1?=
 =?utf-8?B?L1doSmhqVktDTDhtVFJQS2F5TGRUSnM4Njh5TWxzc1IvTDVCYkZUckgyZXlx?=
 =?utf-8?B?MXZiSDJRMnNLN0h4alJHSGNweWdibW5tSjJDb3JmU2lLcGJyekYxd2FJR1lo?=
 =?utf-8?B?NWlHbWU5QWVxbU1Md25HZXcxTWFvQTRZWDN1QlBzaU9QTHd1NWVaYXVOVWY1?=
 =?utf-8?B?bGFHelUyT3FWNjdFT3c3Rlh3d2lXbzFaVkVuOU93aFgvTFdPLzROcXZpWEhN?=
 =?utf-8?B?UENkV0sxWDBnUXhISmphQlNWNjhFRDVKY0NraXdOVFdQZFFVOXNtcTF1bUJ3?=
 =?utf-8?B?RWhUN2R4RVhEdDVoWDBnd1ZkRHRET3M1STF2NDNOWHZ3cXlHK1BqV01nRC94?=
 =?utf-8?B?SitEUEF4WWNKVUlZbFYwQkZucThoSzd3ZHhMR0hYS0dPZmd2L3dnSFo5N3E0?=
 =?utf-8?B?NnlKbFhvWDV1ZnpqOU9hTzh3N1pjUHhhT1FRV1ZoU1VVM1lVN24wbXBFUWFE?=
 =?utf-8?B?czNnOVcvd01YaXZ0b09wOXptc05mcGJxQm1peEJDcG4rN0liN0RrSnV5Qk9z?=
 =?utf-8?B?RFNRa1VDU3BRRVRReWxsSkNjb3pNMGgwdFczZnJXcDFDaElzbVltOTBQSUpM?=
 =?utf-8?B?Zm5HZFYyd2lnOFd6MFZYMDM5VXovdG1rMFZVN1J6Q2NUQWJtQWl5UVBvT1p3?=
 =?utf-8?B?NE1BMXducXRlOGJQaTFSV0dzcUhiU0k1ajNUL1k3aFROWk9rb3BYQmtvVHhM?=
 =?utf-8?B?QllrdXRTWFFvckFyNHM3Skk3RFNFMktRVmRaTjdHQTJFTUc2TlZqT1JNNlRO?=
 =?utf-8?B?Tm1xTmhIZlFLVW5XUTA3VnZheXVnVVk0a3ZmRVZDTVJJb0tzWjVzK0dhUEwr?=
 =?utf-8?B?cmJMdG9zWjdrby8zUCtVT3djV3BXSGVrdTNDYUFPTFlhb0VKaTRyNW5IWC9Y?=
 =?utf-8?B?eGUzcGR4K1NpMzlPaE83NStKbzhELzlSSEVQZnBueThudFNoL3FrRkh1SFBQ?=
 =?utf-8?B?THpsUWk3ekVqT3ZKbXIyU3plYUw5V1lWamZRRU5kQnRQbGJUUUIrazRDSWNB?=
 =?utf-8?B?UENFeGxzTmp3cDVZNTNTQXJaZWZ2dHBmNTFpSUIrZUJzNVlCVk9hOXh0R0hk?=
 =?utf-8?B?WUtvWkVEN2VUWXd2Y1EwYzhCSTFGUCsvdXN4dEMrSzFld2RKTk5rcUVKbzc3?=
 =?utf-8?B?b05wY08rSExYZEVIU3RJWCt2Z0ZyVzVXK1Y0ZXRyVjU3T1BiekJvUEVHZHhS?=
 =?utf-8?B?ejBRQlEwaGRBcW5Ub3l5b1N5VHVyQUJFTVBPRmE2Tk9OTGJTV1NpNnh4T0pT?=
 =?utf-8?B?UllXcjIzTmRxbU5BdnJWQklGRVQzbW1ERllKVCtzWlhhSmZXUDBCMzNFK3dw?=
 =?utf-8?B?TlhGR0hwUzBIaDJrMm1QVUdWQktrL2hrMlR2S0ZrL2loSGVDbnl4ZjZKdFBy?=
 =?utf-8?B?Z3BoT1Q3Tlg5MHlnTzRCSEpWQndKRTIrbHZZYjJiNk16MS9MREVCcnVnc2RE?=
 =?utf-8?Q?QqESq6v7iyq+x+hJDeEswTWds?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d91ff4-c01d-4de0-316a-08ddeab960f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:13:27.2516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InKidBk7Md3pZLYRnSjscRy/L0eeS3DoiFG/iC2IIwOQbi2Iqak5hIq658etbOO/SkPWIwzjmMW2JZzwKEIxHfdHLzmIJyOZfzKi5Z9sZnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMjFdIGludGVsX2lvbW11
OiBJbnRyb2R1Y2UgdHdvIGhlbHBlcnMNCj52dGRfYXNfZnJvbS90b19pb21tdV9wYXNpZF9sb2Nr
ZWQNCj4NCj5PbiAyMDI1LzkvMSAxMzozMywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPg0KPj4+
PiArc3RhdGljIGludCB2dGRfYXNfdG9faW9tbXVfcGFzaWRfbG9ja2VkKFZUREFkZHJlc3NTcGFj
ZSAqdnRkX2FzLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90ICpwYXNpZCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBWVERDb250ZXh0Q2FjaGVFbnRy
eSAqY2NfZW50cnkgPQ0KPiZ2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50cnk7DQo+Pj4+ICsgICAg
SW50ZWxJT01NVVN0YXRlICpzID0gdnRkX2FzLT5pb21tdV9zdGF0ZTsNCj4+Pj4gKyAgICB1aW50
OF90IGJ1c19udW0gPSBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyk7DQo+Pj4+ICsgICAgdWludDhf
dCBkZXZmbiA9IHZ0ZF9hcy0+ZGV2Zm47DQo+Pj4+ICsgICAgVlREQ29udGV4dEVudHJ5IGNlOw0K
Pj4+PiArICAgIGludCByZXQ7DQo+Pj4+ICsNCj4+Pj4gKyAgICAvKiBGb3IgUmVxdWVzdHMtd2l0
aC1QQVNJRCwgaXRzIHBhc2lkIHZhbHVlIGlzIHVzZWQgYnkgdklPTU1VDQo+Pj4gZGlyZWN0bHkg
Ki8NCj4+Pj4gKyAgICBpZiAodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQpIHsNCj4+Pj4g
KyAgICAgICAgKnBhc2lkID0gdnRkX2FzLT5wYXNpZDsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIDA7
DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKGNjX2VudHJ5LT5jb250ZXh0X2Nh
Y2hlX2dlbiA9PSBzLT5jb250ZXh0X2NhY2hlX2dlbikgew0KPj4+PiArICAgICAgICBjZSA9IGNj
X2VudHJ5LT5jb250ZXh0X2VudHJ5Ow0KPg0KPmp1c3QgcmVhbGl6ZWQsIGlmIHlvdSBkb24ndCBy
ZWNvcmQgdGhlIGNvbnRleHRfZW50cnkgaW4gdGhlIGJlbG93DQo+YnJhbmNoLCB0aGVuIHRoaXMg
ZmxvdyB3aWxsIGFsd2F5cyBnbyB3aXRoIHRoZSBiZWxvdyBicmFuY2ggZm9yDQo+cGFzc3Rocm91
Z2ggZGV2aWNlLiBpcyBpdD8NCg0KWWVzLg0KDQo+DQo+Pj4+ICsgICAgfSBlbHNlIHsNCj4+Pj4g
KyAgICAgICAgcmV0ID0gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19udW0sIGRldmZu
LCAmY2UpOw0KPj4+PiArICAgICAgICBpZiAocmV0KSB7DQo+Pj4+ICsgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4+PiArICAgICAgICB9DQo+Pj4+ICsgICAgfQ0KPj4+PiArICAgICpwYXNpZCA9
IFZURF9DRV9HRVRfUklEMlBBU0lEKCZjZSk7DQo+Pj4NCj4+PiBsb29rcyBsaWtlIHdlIGhhdmUg
cXVpdGUgYSBmZXcgY29kZSBnZXQgcmlkX3Bhc2lkIGZyb20gdGhlIGNvbnRleHQNCj4+PiBlbnRy
eS4gSSB0aGluayB3ZSBtYXkgc2ltcGxpZnkgaXQgYnkgdXNpbmcgUEFTSUQgIzAgc2luY2UgdklP
TU1VIGRvZXMNCj4+PiBub3QgcmVwb3J0IEVDQVAuUlBTIGJpdCBhdCBhbGwuIEl0IGNvdWxkIGJl
IGRvbmUgYXMgYSBzZXBhcmF0ZSBjbGVhbnVwLg0KPj4NCj4+IFllcywgYnV0IHdlIGFscmVhZHkg
aGF2ZSBhbGwgY29kZSBzdXBwb3J0aW5nIFJQUyBjYXBhYmlsaXR5IHRob3VnaCBSUFMNCj4+IGlz
bid0IGVuYWJsZWQgaW4gQ0FQIHJlZ2lzdGVyLiBJbiB0aGVvcnkgd2UgY2FuIGVuYWJsZSBSUFMg
ZWFzaWx5IGJ5IHNldHRpbmcNCj4+IHRoZSBiaXQgaW4gQ0FQIHJlZ2lzdGVyLiBTbyBJIHdvdWxk
IGxpa2UgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoaXMgaW5zdGVhZCBvZg0KPj4gZHJvcHBpbmcg
YWxsIHRoZSBleGlzdGluZyBjb2RlIGFib3V0IFJQUyBjYXAuDQo+DQo+cmlnaHQuIFRoZSBjb2Rl
IGlzIGFsbW9zdCB0aGVyZS4gQnV0IEkgaGF2ZW4ndCBzZWVuIHRoZSBwb3NzaWJpbGl0eSB0bw0K
PnJlcG9ydCBSUFM9PTEgdG8gZ3Vlc3QuIEl0J3Mgc29tZWhvdyBhbGlnbmVkIHRoYXQgcGFzaWQj
MCB3b3VsZCBiZSB1c2VkDQo+YXMgcmlkX3Bhc2lkLiBZb3UgbWF5IGhhdmUgbm90aWNlZCBMaW51
eCBldmVuIGRvZXMgbm90IGNoZWNrIFJQUyBiaXQuIFNvDQo+c3VjaCBhIGd1ZXN0IHdpbGwgaWdu
b3JlIFJQUy4gVGhpcyBtZWFucyB0aGlzIHJlYWRpbmcgcmlkX3Bhc2lkIGZyb20gY2UNCj5lbnRy
eSBpcyBub3QgbmVjZXNzYXJ5LiBUaGlzIGlzIG5vdCB1cmdlbnQgdGFzayBhbnlob3cuDQoNCk9L
LCBpZiB3ZSBoYXZlIG5vIHBsYW4gdG8gc3VwcG9ydCBSUFMsIGEgbG90IG9mIGNvZGUgd2lsbCBi
ZSBzaW1wbGlmaWVkLiBJJ2xsIGRvIGl0IGluIHRoaXMgc2VyaWVzIGlmIG5vIG9iamVjdGlvbi4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

