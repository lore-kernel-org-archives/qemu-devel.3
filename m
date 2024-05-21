Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A11C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 03:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Fur-000319-5Q; Mon, 20 May 2024 23:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9Fuo-00030Z-Cd
 for qemu-devel@nongnu.org; Mon, 20 May 2024 23:11:50 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9Ful-0006N3-3a
 for qemu-devel@nongnu.org; Mon, 20 May 2024 23:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716261108; x=1747797108;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2wvWrExe0psEtdfAndJbdC3DQh6H86FUWqZUNGh18nM=;
 b=WlgDd8dmpTqiqan3eGJ6hl1Ff1iCk+2z1vf/s43BrowMs78ulhSxvTuf
 acVsCEXxuXRUQAFKWU1DbrphNAMeRqaf4jo01xiuuOmixKs8Iz5ywjLcO
 Xi0sHMM2MFbrtCjY7f0a8IPBB6fsV3rc8F+ANROTmxqRXFpJqQ4i3xa8Y
 R0CRA5jBnZZmxrXXHXTOBCZyyOejJA2Rmye5kFm+Q6z7ufD4Fp07E9DFv
 hNqAJhQn7KiAWOfJcGzn5lhUS/ve+1WzYvtFVOlRvcBzpGmUGYL4LgTuO
 x6bKg7WNbp9zTKk6dlXfm9DDkCb+NObWmEhiE/99fEFtFv7/g7JcBp7dS w==;
X-CSE-ConnectionGUID: JNy2uokIQWS710KfFyqUMA==
X-CSE-MsgGUID: WldxFvX7Q0CZGQRvlopQzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12543891"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; d="scan'208";a="12543891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 20:11:43 -0700
X-CSE-ConnectionGUID: oGDYbtQNQrqsQ9F0jdpfjw==
X-CSE-MsgGUID: TcVpP/uGSSuYYEn6B3Bt3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; d="scan'208";a="37705272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 May 2024 20:11:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 20:11:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 20:11:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 20:11:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 20:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4xmlXMkXYHoSZTAa0CWqg0n3W89Py1vkqUnJ80ALQTU07i0Od4x5wZQFG2fqrXSIWvKqfHQQXLbECKVqqngWm/FjYO8SQJPHa3IusMpBFy6wJTI15dqeSQkWisszvCHM6wZopsafoBI9Nhqh0EqRM4bJ38IUnUe0TRXqH0e5q4jKDKLCD9f+2GOHh5bBV591Ce4R7o0RqMhYi0F7ElAJnoIx2aAhxT+fYdC2XaFnXWcnZwW155xacP5T55vGaajuXMI1qXoSFSrwiolAnv/gpWav+zlvyi8B0yi+mZbD5aB1K2fTJgqHj0Z/kAEpF2cIOVB3vk7TzrEAfq9Ua7Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wvWrExe0psEtdfAndJbdC3DQh6H86FUWqZUNGh18nM=;
 b=QVComBFGfNglASkJAD+LyJLImA/wC3r9PWO9YmPoq5Ndu9oDO3ovOXkTmhmviqWgO/VDPcKj2SWHIo+2ybj88hgzbAE40bgLyJNGhZ258geR2GrAECCzYzeRfaGOqGngz6AQ7xQKry9rXaFWKsVaqLgKXcwgbkRYtcXh6dwz0YKzN1ZQvCQTFMNbFeDRWU6crnaKgxY9zNvHGFlmN+gBSBFqoUC4g7W9VRtXD3e8mrElPNAB7vwJjV2Da16tgKjdJlk9/IrvMs8KGErd3YhoxSD8aFYYs+PT9gSR3zDy2h2ufGSc56oPWxfcdxEvG6vRJcMshF0n0SyGl74uwTvNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4595.namprd11.prod.outlook.com (2603:10b6:5:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:11:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 03:11:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v2 20/25] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHappePxRKi9iA3U0GcjHFp00phFrGbPuhQgAAJ6QCABcLnAA==
Date: Tue, 21 May 2024 03:11:39 +0000
Message-ID: <SJ0PR11MB674405DBEDD710A2B38E0E1192EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
 <20240515071057.33990-21-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB674421DBE60D5C9CF3584C6C92EE2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f86f14d-67dd-4390-99d8-469945279c04@eviden.com>
In-Reply-To: <2f86f14d-67dd-4390-99d8-469945279c04@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4595:EE_
x-ms-office365-filtering-correlation-id: 0a5abd11-6291-41c3-1943-08dc7943bba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aTU0UVE1NUZDUkI0QlJ2M0hnaXVUdjJoTG05N0xRbDJ6ZXk0aFlrUHhpMHJX?=
 =?utf-8?B?d3o2MWNxN0ltdjJRNlB2TE9BSjhuUGgyNEk2cXRFWmFPaldNUW91dlg5dTU3?=
 =?utf-8?B?cE9VWjdLQ3ZVVU5kOWVud0xBSnc0TVlFSGgvaXZ1QVdzclBDS1R1WnFkUW9s?=
 =?utf-8?B?cXM1blREa1FRczJPR2hJdWVQTW0xR1JJeXI0TUVodEZiZXU5ZEJCVUdpZWVT?=
 =?utf-8?B?ZHREVmpsWEFXNHlOUlJ5VjhEbVBsQnB0b29xcElScHNRSlBUcWhOVkxlYVhD?=
 =?utf-8?B?a1BjTWdvVkhYdndGd3d3NnFHMU5pU2J1WjlNYS82eFFETVRXamVrbktnakUv?=
 =?utf-8?B?UzQvMmhCa05mYkZLcjN4V2VIQVFORUVONHhCMGc5dDVMdmNvdnR4YXZCMXRT?=
 =?utf-8?B?Rlk1YTBVRzNlRDhCQkpWOTFWVzdydkhIVmFCbTI2TFR3VWtPVzFvaEJxKzlo?=
 =?utf-8?B?Uktyb1hYaWdHOUR0MHpWY0llbmhwL0ZLaDZkd1Vsc2ovd1JxcU9zSkhVMnA2?=
 =?utf-8?B?Y2NGRWNNcW9vL0gwTHVPRzVNUUZEd2hDczV1ZlVhR0FzK09ENmh4UWdiYmF1?=
 =?utf-8?B?cHpJby8vcXhVVjF5eDJhUUV2blpRZUU3bTFNSTlOa2tQZk5VQkNwUXZvT0lu?=
 =?utf-8?B?OHdWV05xSlZQL09XdDBvS2pzNEFKY1FiTDhNc0dZaUlxYkF3a3RoNkpUUkY2?=
 =?utf-8?B?aVNETzJLTm9BQmlzdXJjNVVxbnYvNHUvTWJPdGw0UW04TSttS1pacHNLanpN?=
 =?utf-8?B?eGo4ckFKQzc3UVRtSE5KMmUwZDczUGlBMEZlUWFtazUyaXRkeGwrWnkzbFZH?=
 =?utf-8?B?bEF2cC9XcUxvTVZQUEtVSGNlZnlyekpZZmh4QUhjK2tyWGlQQUtwcjZoWXVk?=
 =?utf-8?B?eW9kaUlJblI2R3hYZEdUbjEvOE9CVkJoN0ZUY1J1TG1BcnZsaXp5VWovRHJw?=
 =?utf-8?B?aXJKd0JSdGtvbzJaWlEzNzN1UTRlTjAxWDR0MkUyWU9oMmlxWnJpQ0JXc090?=
 =?utf-8?B?WWR0Zm52eW5BRzBRMVl5TEdUei9RY2ljem1zbk82YnN5emtMV256ZmkvbzJT?=
 =?utf-8?B?OTk1RHp6emNuZ2d6TVArNm45MlVyY211R2p4dE5aQzBNUWkyQWVrZlN4SWdy?=
 =?utf-8?B?UDZiVnBRbUJ5M3hlQjQzd0xIZ1BPbnhCZFR6NUtPNTcyOEZaN2JkWkZ3RjU2?=
 =?utf-8?B?bTE1U01RTXlPS2taZHVnaWdpV1YxT0Fidmc0N2RabGNLQXI2Rk5NUCs2QWcr?=
 =?utf-8?B?cy84RCt2cFJ1YXFUYTByaVd5N2ZaT2RHK01KTnVtd244RXlPN2hkUkx5Q09i?=
 =?utf-8?B?QnFDMnhrQUYyTWR4NjFZNEVFT1p1OHVmYVlWQlM4VWJtSHdrSXo1c2RFd1pC?=
 =?utf-8?B?WEs0Uk9TSktXNW9CaG83UHU1dHJReXl5bXdUWXBSaVNaTGdCZ0VjMzEyVEdu?=
 =?utf-8?B?MmF3QklzMm1VaHAweGpLRlhPazE5a0U4a2h0UGE5aG9ZK2VISTJIc3VGbGRs?=
 =?utf-8?B?dzFyY0FSUytySm51bXcrU2ptZE1udUFUVGRzRFJzMWhwTTgrVUhNd1VMVjV1?=
 =?utf-8?B?K3dsYkg5d2VwLzhSdmFNQXhPODBabVZRbUw4cGlLbkk3MHl5OTg5YUlyQzAw?=
 =?utf-8?B?S1RES213NVNBWksxUDVBU3FaRXpiakVFNVRqZzdWYVptV3FXaU1DR2xMRFpD?=
 =?utf-8?B?UURrZ3dNcVNpUFJhMENjNUFUYzZZbFA3VVpGUDVqekRXSE9VQXBuZFhyRnR4?=
 =?utf-8?B?TTU2OWVkbW5lNUNMZmpJQTZCTk1sekFTajFOVzZCQ0Y3NTJwNnc2NHM5azVY?=
 =?utf-8?B?U0RRUVpDcHBOdVBTQjkzUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2l4TC91UXhGQVZtNkp5S0tVeS9mQkRTMXhEckpMdHUyajRUZ3JlUERUNEV5?=
 =?utf-8?B?YXlLVUNMZi8yblFlQm13Wk1lWncwSEdadWVlK1g1cUFNOTRjZ0gycElwd2Zh?=
 =?utf-8?B?R1dPZVVURS9GNG4yeGVEMlNrY0pqdkI4QjRLWkVObmVIVFVKZXVWUUYyeEcv?=
 =?utf-8?B?VUQ3MkRCUXZRWGJXWFdhaExRcGV2UExUU0U0UFVTMDEzUldwa3RFUjNheTJS?=
 =?utf-8?B?cXFlbEdoenZSZmNBcXBDQTRkZ0kxcUtUeFpHbFNrSFZtdnJueENmbzVPMUZh?=
 =?utf-8?B?U2pWRHZJWVlVbmt3a01BTUtNSW5kMHptL2s2TnpPTmFZNXEvdHdPQWdZWHl3?=
 =?utf-8?B?eXphWVF5Z2ptMWxtc3dkRkxrWHpFYXA3THNFTUNIaXJOc2QyK2NoVktqeURn?=
 =?utf-8?B?ZkI4bW1VUVVoWWU0WCt5K01mZWFFMGVvQk1JelpmYTBaSFNURGJVdGRoeCtJ?=
 =?utf-8?B?Nks1ajFlVTUrOFAxYXBXWDlGZTdiem84QXE5aU9zZ21FYmtpaHNYVjd6M2tG?=
 =?utf-8?B?emxua1VOaTQvemxObVc2L0E3M1lrcjAwRFFQUzl3UFpoU29IREpCdm1tVW9k?=
 =?utf-8?B?MmlRcWJCREc1MjNDWmo5bjJvQnlveG4zR1hNd1Y0YUtRMTd0ZzhRb2NMb3hI?=
 =?utf-8?B?U0JXemlVdHdkb0REbVhrQ2l2T2hOb05XTTA4aXhGdHNJdy82a1c3aG1QaFow?=
 =?utf-8?B?MFlBeEszL3BLOXBXdldKeHd5emRtM1NDZ3J4MTN0N0JjS3RLOEozSjJYblY5?=
 =?utf-8?B?elFQOG83ZXpLQ2s4Vk9lL1EraUsyd3JlUnFqRFFLWUxabFhxQ1FBTFlOUUlE?=
 =?utf-8?B?eUZVdWU5TU9tWW1ESlZNZW5yTGZBazRYdzFWRHluMDBxekZkRHdsY1ppTm1K?=
 =?utf-8?B?elVvR0lvNnpDRDJsclhnWDF6VHVSQzFsc1RnQitHUEhEcHN1cTZRR25JZ3JL?=
 =?utf-8?B?R0hLbThoZWZUbDlEa1NoalZuVTFIN0E5TS9mczZnaWoyR25sRkdpellZcWlz?=
 =?utf-8?B?aStCWUFad3FqNEpMbnd3eHd1UDYrUkR2L3NjckJPWVVNNGdhTFNjUGdXWSto?=
 =?utf-8?B?QkdPWU0zV2dtdTVRM0I3WVloVHJoWVg3Uzg1MVhqWDRnV21OQlhFclUvdEhu?=
 =?utf-8?B?Q3YzWG1hQUc2VDM1QmZaSzVWY05Bc29tY3QwZ3ZyeGF3MHEzdmk4RWZ2WXBk?=
 =?utf-8?B?SWNBVDN3ZDd6VXFvRVEwcjlNSDBXUEFsVDV4RXR3NGc4bStJaUhaOENLRThD?=
 =?utf-8?B?bSszL2Rqakxxc0VVZWRxdGpqdVI1L3ZXMDJXdWhDcmI5dXJUbVVWTjY1bXVm?=
 =?utf-8?B?Vkhsc1RXeWYvblhTak8zNk5FZnUvVWh6MEt6KzhFek52czNJTjlSZW9Xa0NT?=
 =?utf-8?B?aHhYRzNpOEpwYXdZS2xENmpraFRuVUFDUDlDc1JaYlYwWS9PRlovSDdmbnAr?=
 =?utf-8?B?VTN6VnlCUEltaSs5cmxYeEJrMTBuSW9qQ2pZWUZaYkk5REo0enRNZ3lUNHJN?=
 =?utf-8?B?RDkzNU9jRDlJNTc5K3pySVptNlNabkc1YWMrdUIyaEJzWjBjVE9NTWpoeW9U?=
 =?utf-8?B?TU9yQm52THo0cFBaWlVMVll3ZHNNZGZSZUFWNEE0VlFEOE5YN2dZOFFERUs5?=
 =?utf-8?B?bitLYjNWbDd4L2F3ejBUQ1I5NmFJbWM4aEo5bHl3R1dEU1d6VGlWdU11VWZp?=
 =?utf-8?B?cGd6dlRpeUNmdWlRUCs4aXdZMzdwUTQwaE42UzkrM3IrTGZNb2laQThiNG9Y?=
 =?utf-8?B?UVBtQUl6ckpqbndhNGhFdjJmUThxVmlmbm5zbHpOM1pCYi91SlhQczhpcFhy?=
 =?utf-8?B?YUxIVFpQZit5SUxnNlNTT3o4VjYwZitHeExFZkFIUnhRZURMR09BbURkbTNS?=
 =?utf-8?B?Qm9EUXdJTVVFazltMG5vL3JLbHVSM2pNZHJBL01BTGo1RGh4emNVVm83R00x?=
 =?utf-8?B?OVlHTUxCZlBGR3IvU2JaK21YOVdtUTBsOUovN2lIZG1jb2dSRHduVUM4THVi?=
 =?utf-8?B?WlltZy9zMUVBQ2R4OTA4ZjNtRUtPQUZqSXhnWG9RcUtZUVI3VmVCUE5oamt1?=
 =?utf-8?B?UDVwS0p5ejlFaDg1VTBWOVByUG9ibUZvMm9lQXhMdjFZQSs2NnlRdXA4VTZB?=
 =?utf-8?Q?BT2Z00J6nNzvbLKfGEbvLtqBd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5abd11-6291-41c3-1943-08dc7943bba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 03:11:39.7504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ya9X0VM6gs+1AGxCpsc6yUoXKawvTrnKYtSFa3Z+fg8mMzDZNSfgmInMkfxYXJcT3kfN4JRUt6U7ODIPtcl1OvLbUPW8K0uwrXk8NLEsY8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4595
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCBhdHNfdnRkIHYyIDIwLzI1XSBpbnRlbF9pb21tdTogZmlsbCB0aGUgUEFTSUQgZmllbGQg
d2hlbg0KPmNyZWF0aW5nIGFuIGluc3RhbmNlIG9mIElPTU1VVExCRW50cnkNCj4NCj4NCj5PbiAx
Ny8wNS8yMDI0IDEyOjQwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBDYXV0aW9uOiBFeHRl
cm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVz
cyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggYXRzX3Z0ZCB2MiAyMC8yNV0gaW50ZWxf
aW9tbXU6IGZpbGwgdGhlIFBBU0lEIGZpZWxkIHdoZW4NCj4+PiBjcmVhdGluZyBhbiBpbnN0YW5j
ZSBvZiBJT01NVVRMQkVudHJ5DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRo
aWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLQ0KPmRyaWZAZXZpZGVuLmNvbT4NCj4+PiAtLS0N
Cj4+PiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA3ICsrKysrKysNCj4+PiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gaW5kZXggNTNmMTdkNjZjMC4uYzRl
YmQ0NTY5ZSAxMDA2NDQNCj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBAQCAtMjI5OSw2ICsyMjk5LDcgQEAgb3V0Og0K
Pj4+ICAgICAgZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IHZ0ZF9nZXRfc2xwdGVfYWRkcihwdGUs
IHMtPmF3X2JpdHMpICYNCj4+PiBwYWdlX21hc2s7DQo+Pj4gICAgICBlbnRyeS0+YWRkcl9tYXNr
ID0gfnBhZ2VfbWFzazsNCj4+PiAgICAgIGVudHJ5LT5wZXJtID0gYWNjZXNzX2ZsYWdzOw0KPj4+
ICsgICAgZW50cnktPnBhc2lkID0gcGFzaWQ7DQo+PiBGb3IgUENJX05PX1BBU0lELCBkbyB3ZSB3
YW50IHRvIGFzc2lnbiBQQ0lfTk9fUEFTSUQgb3IgcmlkMnBhc2lkPw0KPndlIGhhdmUgdGhlIGZv
bGxvd2luZyBzdGF0ZW1lbnQgYSBmZXcgbGluZXMgYWJvdmUgOg0KPmlmIChyaWQycGFzaWQpIHsN
Cj4gwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPn0N
Cj4NCj5zbyB3ZSBzdG9yZSByaWQycGFzaWQgaWYgdGhlIGZlYXR1cmUgaXMgZW5hYmxlZC4NCj4N
Cj5CdXQgbWF5YmUgd2Ugc2hvdWxkIHN0b3JlIFBDSV9OT19QQVNJRCBiZWNhdXNlIHRoZSByZXN0
IG9mIHRoZSB3b3JsZCBpcw0KPm5vdCBzdXBwb3NlZCB0byBiZSBhd2FyZSBvZiB3aGF0IHdlIGFy
ZSBkb2luZyB3aXRoIHJpZDJwYXNpZC4NCj4NCj5Eb2VzIGl0IGxvb2sgZ29vZCB0byB5b3U/DQoN
ClllcywgdGhhdCBtYWtlIHNlbnNlLg0KDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+
DQo+Pj4gICAgICByZXR1cm4gdHJ1ZTsNCj4+Pg0KPj4+IGVycm9yOg0KPj4+IEBAIC0yMzA3LDYg
KzIzMDgsNyBAQCBlcnJvcjoNCj4+PiAgICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0K
Pj4+ICAgICAgZW50cnktPmFkZHJfbWFzayA9IDA7DQo+Pj4gICAgICBlbnRyeS0+cGVybSA9IElP
TU1VX05PTkU7DQo+Pj4gKyAgICBlbnRyeS0+cGFzaWQgPSBQQ0lfTk9fUEFTSUQ7DQo+Pj4gICAg
ICByZXR1cm4gZmFsc2U7DQo+Pj4gfQ0KPj4+DQo+Pj4gQEAgLTM0OTcsNiArMzQ5OSw3IEBAIHN0
YXRpYyB2b2lkDQo+Pj4gdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElP
TU1VU3RhdGUgKnMsDQo+Pj4gICAgICAgICAgICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMg
PSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+Pj4gICAgICAgICAgICAgICAgICBldmVudC5lbnRy
eS5pb3ZhID0gbm90aWZpZXItPnN0YXJ0Ow0KPj4+ICAgICAgICAgICAgICAgICAgZXZlbnQuZW50
cnkucGVybSA9IElPTU1VX05PTkU7DQo+Pj4gKyAgICAgICAgICAgICAgICBldmVudC5lbnRyeS5w
YXNpZCA9IHBhc2lkOw0KPj4+ICAgICAgICAgICAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNr
ID0gbm90aWZpZXItPmVuZCAtIG5vdGlmaWVyLT5zdGFydDsNCj4+PiAgICAgICAgICAgICAgICAg
IGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+Pj4NCj4+PiBAQCAtMzY3OCw2ICsz
NjgxLDcgQEAgc3RhdGljIHZvaWQNCj4+PiB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRl
bElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4+PiAgICAgICAgICAgICAgZXZl
bnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KPj4+ICAgICAgICAg
ICAgICBldmVudC5lbnRyeS5pb3ZhID0gYWRkcjsNCj4+PiAgICAgICAgICAgICAgZXZlbnQuZW50
cnkucGVybSA9IElPTU1VX05PTkU7DQo+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBhc2lk
ID0gcGFzaWQ7DQo+Pj4gICAgICAgICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IHNpemUg
LSAxOw0KPj4+ICAgICAgICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0K
Pj4+DQo+Pj4gQEAgLTQzMzUsNiArNDMzOSw3IEBAIHN0YXRpYyB2b2lkDQo+Pj4gZG9faW52YWxp
ZGF0ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCj4+PiAgICAgIGV2
ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KPj4+ICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1V
X05PTkU7DQo+Pj4gICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4+ICsg
ICAgZXZlbnQuZW50cnkucGFzaWQgPSB2dGRfZGV2X2FzLT5wYXNpZDsNCj4+PiAgICAgIG1lbW9y
eV9yZWdpb25fbm90aWZ5X2lvbW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPj4+
IH0NCj4+Pg0KPj4+IEBAIC00OTExLDYgKzQ5MTYsNyBAQCBzdGF0aWMgSU9NTVVUTEJFbnRyeQ0K
Pj4+IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIg
YWRkciwNCj4+PiAgICAgIElPTU1VVExCRW50cnkgaW90bGIgPSB7DQo+Pj4gICAgICAgICAgLyog
V2UnbGwgZmlsbCBpbiB0aGUgcmVzdCBsYXRlci4gKi8NCj4+PiAgICAgICAgICAudGFyZ2V0X2Fz
ID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPj4+ICsgICAgICAgIC5wYXNpZCA9IHZ0ZF9hcy0+
cGFzaWQsDQo+Pj4gICAgICB9Ow0KPj4+ICAgICAgYm9vbCBzdWNjZXNzOw0KPj4+DQo+Pj4gQEAg
LTQ5MjMsNiArNDkyOSw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5DQo+Pj4gdnRkX2lvbW11X3Ry
YW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KPj4+ICAgICAg
ICAgIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERfUEFHRV9NQVNLXzRLOw0KPj4+
ICAgICAgICAgIGlvdGxiLmFkZHJfbWFzayA9IH5WVERfUEFHRV9NQVNLXzRLOw0KPj4+ICAgICAg
ICAgIGlvdGxiLnBlcm0gPSBJT01NVV9SVzsNCj4+PiArICAgICAgICBpb3RsYi5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCj4+PiAgICAgICAgICBzdWNjZXNzID0gdHJ1ZTsNCj4+PiAgICAgIH0NCj4+
Pg0KPj4+IC0tDQo+Pj4gMi40NC4wDQo=

