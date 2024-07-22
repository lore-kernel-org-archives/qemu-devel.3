Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F9C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlfW-0002NO-0h; Mon, 22 Jul 2024 01:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlfU-0002MG-Bi
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:33:04 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlfR-0007Ik-PU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721626382; x=1753162382;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZLAj0WZhhv/tVaTA7b0h5XRfmgXnnJIX+H/o206amwo=;
 b=jQEV4V5QQvQGaL0rgWYDQQ0s42xoCLq7utkw4vsSV2VTw1/mbkUCfo8T
 /euFfIyJS7D+k+lwc4grQhO0fNtOYqIloxx/tEd4x+TgSBmkfcnFsH7il
 nfaAVuJOyv0Sn5HwLV36jRNokNIpqH4gxdP1N55IDo5nvyrZQvHg+ivEc
 B8jF9tKl9VziQee/QeL2KU/mc3WkctMPN0ylTNwefZLhCflLbSuo0rdAc
 SFvYhX2eBfsXls6cxfqHZ4N9+f6Zv/EA8noRtNMpIwK1psW0wuNYCWdCa
 xuDefGYPKQqX6v6XuXdioSGffhC47JRfWL+oPS8NvSVUL8lS/AlkNcz9O g==;
X-CSE-ConnectionGUID: L8fBHTyzRfKpslFVqYRXlA==
X-CSE-MsgGUID: o5tm1kF8T3uCpS1Xr2WbYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="18988630"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="18988630"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 22:32:59 -0700
X-CSE-ConnectionGUID: XMRqued5RdmehJSKI13gwA==
X-CSE-MsgGUID: ygA5kQNrT0yUDJ0VmR+2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="51492052"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 22:32:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:32:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:32:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 22:32:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 22:32:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my4LzMFPTlyPt2QHgYeNE+mQZwyTYJA5m1jAKeZlTU7h0qYvTQw4JUtVNo1orxNbabj8z2BWTk40Mh8T/QVj5D0wz+dh2MxNewfInSv9eRTb3gElHMB6pHaY4BrYI3MrtVqZqgoXxPS0bclvARL77+NSj5A8ZAQFciX3PWB6enxGbDFV0XFVE7otIfwpnehC+wm+WTq+TjAwyVBUb9NTVdxq0UFwM2s2IEEHy75LhonusnkmurhLuvym+w020e9s3pncTBaOeQ93K6ww3pp/mofW0skKb7xb1Ychm5xHUpF5xrp67Qj8scVFCnuu+WbJFr7wMONgnWkQ/3BOvU5Hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLAj0WZhhv/tVaTA7b0h5XRfmgXnnJIX+H/o206amwo=;
 b=nlqpxuo6R93nMYErmEV1cNjrnzsT3MwUyDDdyHmNm18P6VDcA1H+jBiRPohWMOARClsYEanmm+cBwqzj5JupnLIW6kVNBEp3HpxPJBekPJSPWzltP0cLd9+lH0ba9Z70W+IaCIUhbqi0ijlnN35pzngikFSt1Yf/0pA8yhg7fh2rlqoh4schr7BGgPIHgz46BYlTjfhFbO8huuEcTB/rc6GJW/yfEt6lg309bbdmIhYPJChvfIYdk1aptjx79Mb82+I1Sh8MsUfAl/XEUFUBpgGBvJjkvil9mVMJVtTKGOr7ZjsequuuJO53YpTmfm98FouGI14/6CHfQtdGffSeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Mon, 22 Jul
 2024 05:32:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 05:32:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v5 08/13] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Thread-Topic: [PATCH v5 08/13] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Thread-Index: AQHa2dymAMGl47ePHkqKQaSIpJdDJrICPVQw
Date: Mon, 22 Jul 2024 05:32:38 +0000
Message-ID: <SJ0PR11MB67447F29026E398DE8316C8492A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-9-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-9-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB7426:EE_
x-ms-office365-filtering-correlation-id: 96d3973f-594f-4548-5283-08dcaa0fb345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHE1QzR6N0NySldPLy9nN1czUmRvMDdHRk1XMUxXaWdBSExrTGZwNnJJVjcx?=
 =?utf-8?B?c2diNTlDZnlQMVBRUDZBeXZCUEl6dzJCTy9DREVrSkYwN21udGtqeFNYMVpm?=
 =?utf-8?B?OXlCbVRSeGhoMkhBQ3YyYm5kakF2SW1tS1pmbTFvalNpSkFrYVErVUNGUmxW?=
 =?utf-8?B?ZXdlaXp6bVZBUGR3dFVzRGRYR3VsSW9UZTFndjVxK0xldzVkdjFZa01Ga0lH?=
 =?utf-8?B?N0JENENRakhqdnY0aEhBVFkxRGk0UldOeEE3NS9HSG03cXQ4dXlYQWdlSmxS?=
 =?utf-8?B?dis1SFpibWYrdHdVRlZiRm9Zbng5NFkzRTFDU1EvZFF3L2xVWnZvZnhqbndH?=
 =?utf-8?B?YTB0V1RwWlpzSW4xVmRWakwzWGZydHFBcVJrSitXaHRoYXlzcEZ2aUh5RTd0?=
 =?utf-8?B?K0lFdm5TTGFGT0JLTmF1R29TdGlLUVJlMDhxWVhTRFZ3d01rSDFwQjE2V3pX?=
 =?utf-8?B?VWcwKzBIRHluUzN3K1pyY21rQWdqUFF0QU1GMUJ4U1UvRm9SMmtESGNRNnRr?=
 =?utf-8?B?S0xoT200cUVvdGQ2RkhzazE3STZHYU9XMklLT3hpQWZqTGlNSE5IWmdTa2hy?=
 =?utf-8?B?RTRDdnZXYkY1ckhmUHl2Wk54TEl3QlJ0a2FoZGF6dEZiVm95TWZFb3QwMEt3?=
 =?utf-8?B?RlhRTWNXN1Jsb3hnQlNoeWlRY3NVUXZBVStyRnI1NWlYZkh6RGNWOW5BNDlQ?=
 =?utf-8?B?ZnVTTDA3ck43ay9rUkM4WHNucEJYbnVuK0pqdW5DaXRyZXJ1aU1xZ2czUy8v?=
 =?utf-8?B?dG90Nkc4SjY1bTAzZFZsNys0d2phUkRhNDR3bDhySXovVFJHeVBNMERZdEI5?=
 =?utf-8?B?L2pxL1Q5eFVQSm1mTUtzOEZpN1NWR0d2N2dnRURlWEFWcFYrT3Brb0lVdGs5?=
 =?utf-8?B?N1VWSVRDSHk4MWpRQzA2V3hyV05JUTgySkJObnREU2FsNXNSWEFTYWh5Z3Yr?=
 =?utf-8?B?MFFpT2lrb3BBYUZMNWNjNnpZczV6V0VmZ0p1bWwvVVV6VXRHOENYaVU2NFBD?=
 =?utf-8?B?c0lxL2thVHA4K3BKRTM3ZXJ6cERXS0diWmhLRnRvaUl1QU5PTlZxRlAzOWJM?=
 =?utf-8?B?T291WWVJeVBRUDhEQlhWUlBhOXVackM2U3oyTzlPM1FUSFpIN2xCVzg0Tm9a?=
 =?utf-8?B?TDA4RmhldVVZQkg3ak9yMW9yckZ3OFBnd0lHc05EUzZ3aTE0NnFQTGZCSTNw?=
 =?utf-8?B?TFFpMGZFUVhYNjRIYUIyTzFuR3JZODBCMzlKMnBCVktIZ3ZBenhFM01mTHFu?=
 =?utf-8?B?Y05KZ3N5Z1k5THRaU1RNWkdJb0hBdWlBVk9ZSzNPaE5LaXBTN2V1RXo0OE1R?=
 =?utf-8?B?c29hYythQkUveU5KaGhld254b21iVU53ajNnYnpnREFwM1ZMT2plSkplVEpW?=
 =?utf-8?B?SHJGVERTNE5pK2s1RVA5WFk5SzQzSWdaemlOZTN4bm9Ndng1aTVTMjJqSjhs?=
 =?utf-8?B?bkNwM2FPZVNId0lmbTBJOGNoM1NtM3RVZ1NnK0Z0a1RxeW9aZDBzOU93Sjgx?=
 =?utf-8?B?ZFVSUkhLOU4rNEZtT2JxTkphSVcwa1QxOGFHMlVwMTl2aG1aR28xVWI0OTJR?=
 =?utf-8?B?dXRhdEQ1c3NxTjFMTHFIb3Yxd2p1Z0xwZVBHaUVDajY1RjM1UmEzV09QcTNP?=
 =?utf-8?B?QTRoR01xZjNEMG5KU29BS1ZRdU15b3VPQmFnQzhoUlVMWWNObHBOK21qeS9U?=
 =?utf-8?B?OC9NMjNxWTNYRTgvQ05lZlZXejhmOE42TXNad3FtWE5GOTlMUWsrL1EzSUZs?=
 =?utf-8?B?L0UrcnhzckRyN2YvTGlpOTF0ZHhXbG82V1ZueVVXTjE2dWVxL0c5dDlFaEVM?=
 =?utf-8?B?Z1Ruc0JLdVRCOVpERUFrRmJtMnpLSzRLT0xyUGlSTTdsZ3ZjVmFIdU8ydldj?=
 =?utf-8?B?Nkl5VDUyZUdHZFdKN0MzNm9mbFJHL1orUkhJQmJEZVlETWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZiSXluNzVpRUtKdUhxU3lTcDNFZko2UUlmaTFMNnFQRi9CcFlsSk1xZUdH?=
 =?utf-8?B?L0tCTkFJTjBZWHRtTTJzQkdXRFBoK3E0SlpBQlYvQXlTMk9NMVVDeTJOT3hM?=
 =?utf-8?B?NTdxNmloeDh4SjM4SnJhc2ovUVZHZEFPaEJmZHlJcFNpSlFSczQ3VVZCQm02?=
 =?utf-8?B?VHllM21KR0RpMzBGQjFHRDZGcGRQOHhlTVh1YjhnYUVTMXpyRk45MTJMb0F3?=
 =?utf-8?B?Q3dMcmk2ditzVjFjbGNYSVd5cmdGTi9QNTZ3TEp5MFd5OFpUeUdqUGlVNzE2?=
 =?utf-8?B?S0s1SHdadEphdk9rdGZ1L2hSRVRINVhrRGpaYXdIMDYrMitNY1c5d0xhbkxa?=
 =?utf-8?B?OHV2dG1Uc3BhNm05UFp4d1J4Nm1ERFBWTXJ2QWo0YUwxM0QyZ0IwOTVVbGFW?=
 =?utf-8?B?YjV0N3gzUjlibXVZVU1RQnVMVGlLRE5mRkZ3K0l3eTI0cmcvRDV6UUZ0ZE43?=
 =?utf-8?B?dkdSTE42c3BRcmVVVVF5MFJxQkF4eGFRTVd2aklITjAvejRzd1FzSnB5MnJw?=
 =?utf-8?B?Tko5YzY5TGg3VHJxeGo4MGhHNzc5dmZubWtuVzlVa1Q1bWVYWXFXeTJ0MjV5?=
 =?utf-8?B?TWJUbGtvekNKM0Q3TWdoZ2FDdXhpZ01ZSjJKRndoc21zbmtxQ1kvU1pUWlpQ?=
 =?utf-8?B?RHRiM0hNVVN1NllUTjhYTUpwTUw3YXVNeGlCaGg1ZmZKQTA5ZVYwdmxuQXVU?=
 =?utf-8?B?SENQM2FPbkFWSEgyNnRwdmp1Rlo0a21ET0dvYmpwMndkOWdCRDZ3aXpMQktB?=
 =?utf-8?B?SkJiTVVRS0d1MTQrNFZya1lBSDVKNWJ5aTBxTDI2bWRyaURyajdQd3VVakY3?=
 =?utf-8?B?cFBCWFFwVGZDcVV5SGFtSVk3MThiL1RGQUhvYktDQS9PWW9yazBWb2JrOEpj?=
 =?utf-8?B?QlROWlpSMkVqY2FUMzlFVmhCUVhzMW1wRFluZDU1bWlkeDV4K2ZGLzFEcWJR?=
 =?utf-8?B?U2hNaTBDVkxRQXJmNUNYcmNkSHVrWDJ2TVRSS0FKV1d1S1lnNU1WcDNKT0pN?=
 =?utf-8?B?Vk05RVk4NExOamdpMmtlN05Ccm1LV2t1K3NEU0NLdTB6cmJRa0hxVDAzM0Jk?=
 =?utf-8?B?NzdyOVo1UU9Jd3JhWXY2VjIyTnpLYTFCUDBnVU1OcElBNytlR1BOUmxReE9T?=
 =?utf-8?B?Wmp6TjZ6ak1acmx1Zm1kaSs5K1hPbEdKWEZoWGg1dDVGU1UzN1FOa3gvNmdB?=
 =?utf-8?B?dklaZ2hCazZvMVJ1SHpOM3NEaHlGOUJpd0xLWFdEZkpWV1VjVFI3eVk0THVX?=
 =?utf-8?B?NGw4VzJWVktxbDJWbnc5eWZRemR0c29TRUdtTVZNWmh5VFRKT2pKSzFtTUZR?=
 =?utf-8?B?OHh4Mm02eHpzVFEyTi9mOEJZNmtKVC8wVlFIeWMzTXVtK1hVejNlbTNpcnRL?=
 =?utf-8?B?Q3Z5c2o1MnpKenhxMlVsTzV4a2hEVlNGUmNNUW9MS05TcFlRc3NmbmdJMmc3?=
 =?utf-8?B?R0RkUjgvcTI0UkFNZ0wyMEhtWWx2d0dKaXU4UmVwc2ZsaHdaVEpidWd2TFFt?=
 =?utf-8?B?N1JFRGZKL1VKMDR1YStyVjRQdXV5ZFNyZ3E0WldLcVl1RmJkWE9jNEluTFM2?=
 =?utf-8?B?bGVSTUZnN0RHS1NIQW1DRUdtRGtFQitSdDJQRFJlSS9kTDVYSy9KVUNTQkNG?=
 =?utf-8?B?QjN2MmFlbW5XRzg0akMzOXR0bmFQY0J0L0tpUU4xRTlKZU1lVGlPSGNXcVl2?=
 =?utf-8?B?RE84VTdFMEl4dzZIVFB6MFZrUDN3aDNBQU1nWGtOTDRpWHNDa1kxRzVVdlJx?=
 =?utf-8?B?NVQzcVYzRDNyLzFZSVMzU3hMM2M3WkN5UUZQSGNvLytYM1pCbjBrSzUyS1Nn?=
 =?utf-8?B?WFJSU1FuMzkxbklZZU0zRVc1K1VXb2tJSERTRmI4TlhtdVRpWWZpcThUdmFL?=
 =?utf-8?B?SGNJMFdmL3BnaFkxRm5VRmZZbXJCZFBqeXJIdFZ3M2RGYUxyQzA5K1Z3M2w1?=
 =?utf-8?B?VFA2SUR0bTd0bFpFZEROMFdIa0NkMFB3RWNOa0p6U25sRHE4c0FpSURlcnFp?=
 =?utf-8?B?THkxVnZPcnprSVE5ZmIwd0FCdFV5cmpxNUVvWkxxR21hVGNLTHQzTDFWL0hO?=
 =?utf-8?B?UEtQQU9SN3ljYW5JZ25hL21NODYwMUl6cVVTb0ZYRFNsOCtSbnNQdWFPNmlp?=
 =?utf-8?Q?c/KydeRE/uwFGepk53u66yNJF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3973f-594f-4548-5283-08dcaa0fb345
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 05:32:38.8030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvzEwSPnVQWtq0lbiBF6Ct3b7IrkGnKpJlpwBmE1svuSLEo8uHM2FlRPWpqzKfJOEN9QZZu6XmM2Zq77qziBDli3FrfQqiMy8gCebUhkW+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjUgMDgvMTNdIHZmaW8v
e2lvbW11ZmQsY29udGFpbmVyfTogSW52b2tlDQo+SG9zdElPTU1VRGV2aWNlOjpyZWFsaXplKCkg
ZHVyaW5nIGF0dGFjaF9kZXZpY2UoKQ0KPg0KPk1vdmUgdGhlIEhvc3RJT01NVURldmljZTo6cmVh
bGl6ZSgpIHRvIGJlIGludm9rZWQgZHVyaW5nIHRoZSBhdHRhY2ggb2YNCj50aGUgZGV2aWNlDQo+
YmVmb3JlIHdlIGFsbG9jYXRlIElPTU1VRkQgaGFyZHdhcmUgcGFnZXRhYmxlIG9iamVjdHMgKEhX
UFQpLiBUaGlzDQo+YWxsb3dzIHRoZSB1c2UNCj5vZiB0aGUgaHdfY2FwcyBvYnRhaW5lZCBieSBJ
T01NVV9HRVRfSFdfSU5GTyB0aGF0IGVzc2VudGlhbGx5IHRlbGwgaWYNCj50aGUgSU9NTVUNCj5i
ZWhpbmQgdGhlIGRldmljZSBzdXBwb3J0cyBkaXJ0eSB0cmFja2luZy4NCj4NCj5Ob3RlOiBUaGUg
SG9zdElPTU1VRGV2aWNlIGRhdGEgZnJvbSBsZWdhY3kgYmFja2VuZCBpcyBzdGF0aWMgYW5kIGRv
ZXNuJ3QNCj5uZWVkIGFueSBpbmZvcm1hdGlvbiBmcm9tIHRoZSAodHlwZTEtaW9tbXUpIGJhY2tl
bmQgdG8gYmUgaW5pdGlhbGl6ZWQuDQo+SW4gY29udHJhc3QgaG93ZXZlciwgdGhlIElPTU1VRkQg
SG9zdElPTU1VRGV2aWNlIGRhdGEgcmVxdWlyZXMgdGhlDQo+aW9tbXVmZCBGRCB0byBiZSBjb25u
ZWN0ZWQgYW5kIGhhdmluZyBhIGRldmlkIHRvIGJlIGFibGUgdG8gc3VjY2Vzc2Z1bGx5DQo+R0VU
X0hXX0lORk8uIFRoaXMgbWVhbnMgdmZpb19kZXZpY2VfaGlvZF9yZWFsaXplKCkgaXMgY2FsbGVk
IGluDQo+ZGlmZmVyZW50IHBsYWNlcyB3aXRoaW4gdGhlIGJhY2tlbmQgLmF0dGFjaF9kZXZpY2Uo
KSBpbXBsZW1lbnRhdGlvbi4NCj4NCj5TdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNtPg0KPlNpZ25lZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tY29tbW9uLmggfCAgMSArDQo+IGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAg
ICAgIHwgMTYgKysrKysrLS0tLS0tLS0tLQ0KPiBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAg
ICB8ICA0ICsrKysNCj4gaHcvdmZpby9oZWxwZXJzLmMgICAgICAgICAgICAgfCAxMSArKysrKysr
KysrKw0KPiBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8ICA0ICsrKysNCj4gNSBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZp
by0NCj5jb21tb24uaA0KPmluZGV4IDFhOTY2NzhmOGMzOC4uNGU0NGIyNmQzYzQ1IDEwMDY0NA0K
Pi0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+KysrIGIvaW5jbHVkZS9ody92
ZmlvL3ZmaW8tY29tbW9uLmgNCj5AQCAtMjQyLDYgKzI0Miw3IEBAIHZvaWQgdmZpb19yZWdpb25f
ZmluYWxpemUoVkZJT1JlZ2lvbiAqcmVnaW9uKTsNCj4gdm9pZCB2ZmlvX3Jlc2V0X2hhbmRsZXIo
dm9pZCAqb3BhcXVlKTsNCj4gc3RydWN0IHZmaW9fZGV2aWNlX2luZm8gKnZmaW9fZ2V0X2Rldmlj
ZV9pbmZvKGludCBmZCk7DQo+IGJvb2wgdmZpb19kZXZpY2VfaXNfbWRldihWRklPRGV2aWNlICp2
YmFzZWRldik7DQo+K2Jvb2wgdmZpb19kZXZpY2VfaGlvZF9yZWFsaXplKFZGSU9EZXZpY2UgKnZi
YXNlZGV2LCBFcnJvciAqKmVycnApOw0KPiBib29sIHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpu
YW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgQWRk
cmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKTsNCj4gdm9pZCB2ZmlvX2RldGFjaF9kZXZpY2Uo
VkZJT0RldmljZSAqdmJhc2VkZXYpOw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIv
aHcvdmZpby9jb21tb24uYw0KPmluZGV4IGIwYmVlZDQ0MTE2ZS4uY2MxNGYwZTNmZTI0IDEwMDY0
NA0KPi0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4rKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+QEAg
LTE1NDQsNyArMTU0NCw3IEBAIGJvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsIFZG
SU9EZXZpY2UNCj4qdmJhc2VkZXYsDQo+IHsNCj4gICAgIGNvbnN0IFZGSU9JT01NVUNsYXNzICpv
cHMgPQ0KPg0KPlZGSU9fSU9NTVVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUoVFlQRV9WRklP
X0lPTU1VX0xFR0FDWSkpOw0KPi0gICAgSG9zdElPTU1VRGV2aWNlICpoaW9kOw0KPisgICAgSG9z
dElPTU1VRGV2aWNlICpoaW9kID0gTlVMTDsNCj4NCj4gICAgIGlmICh2YmFzZWRldi0+aW9tbXVm
ZCkgew0KPiAgICAgICAgIG9wcyA9DQo+VkZJT19JT01NVV9DTEFTUyhvYmplY3RfY2xhc3NfYnlf
bmFtZShUWVBFX1ZGSU9fSU9NTVVfSU9NTVVGDQo+RCkpOw0KPkBAIC0xNTUyLDIxICsxNTUyLDE3
IEBAIGJvb2wgdmZpb19hdHRhY2hfZGV2aWNlKGNoYXIgKm5hbWUsDQo+VkZJT0RldmljZSAqdmJh
c2VkZXYsDQo+DQo+ICAgICBhc3NlcnQob3BzKTsNCj4NCj4tICAgIGlmICghb3BzLT5hdHRhY2hf
ZGV2aWNlKG5hbWUsIHZiYXNlZGV2LCBhcywgZXJycCkpIHsNCj4tICAgICAgICByZXR1cm4gZmFs
c2U7DQo+LSAgICB9DQo+DQo+LSAgICBpZiAodmJhc2VkZXYtPm1kZXYpIHsNCj4tICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4rICAgIGlmICghdmJhc2VkZXYtPm1kZXYpIHsNCj4rICAgICAgICBoaW9k
ID0gSE9TVF9JT01NVV9ERVZJQ0Uob2JqZWN0X25ldyhvcHMtPmhpb2RfdHlwZW5hbWUpKTsNCj4r
ICAgICAgICB2YmFzZWRldi0+aGlvZCA9IGhpb2Q7DQo+ICAgICB9DQo+DQo+LSAgICBoaW9kID0g
SE9TVF9JT01NVV9ERVZJQ0Uob2JqZWN0X25ldyhvcHMtPmhpb2RfdHlwZW5hbWUpKTsNCj4tICAg
IGlmICghSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2QpLT5yZWFsaXplKGhpb2QsIHZi
YXNlZGV2LA0KPmVycnApKSB7DQo+KyAgICBpZiAoIW9wcy0+YXR0YWNoX2RldmljZShuYW1lLCB2
YmFzZWRldiwgYXMsIGVycnApKSB7DQo+ICAgICAgICAgb2JqZWN0X3VucmVmKGhpb2QpOw0KPi0g
ICAgICAgIG9wcy0+ZGV0YWNoX2RldmljZSh2YmFzZWRldik7DQo+KyAgICAgICAgdmJhc2VkZXYt
Pmhpb2QgPSBOVUxMOw0KPiAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgIH0NCj4tICAgIHZi
YXNlZGV2LT5oaW9kID0gaGlvZDsNCj4NCj4gICAgIHJldHVybiB0cnVlOw0KPiB9DQo+ZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+aW5kZXgg
YzI3ZjQ0OGJhMjZlLi5hZGIzMDIyMTZlMjMgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9jb250YWlu
ZXIuYw0KPisrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj5AQCAtOTE3LDYgKzkxNywxMCBAQCBz
dGF0aWMgYm9vbCB2ZmlvX2xlZ2FjeV9hdHRhY2hfZGV2aWNlKGNvbnN0IGNoYXINCj4qbmFtZSwg
VkZJT0RldmljZSAqdmJhc2VkZXYsDQo+DQo+ICAgICB0cmFjZV92ZmlvX2F0dGFjaF9kZXZpY2Uo
dmJhc2VkZXYtPm5hbWUsIGdyb3VwaWQpOw0KPg0KPisgICAgaWYgKCF2ZmlvX2RldmljZV9oaW9k
X3JlYWxpemUodmJhc2VkZXYsIGVycnApKSB7DQo+KyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPisg
ICAgfQ0KPisNCj4gICAgIGdyb3VwID0gdmZpb19nZXRfZ3JvdXAoZ3JvdXBpZCwgYXMsIGVycnAp
Ow0KPiAgICAgaWYgKCFncm91cCkgew0KPiAgICAgICAgIHJldHVybiBmYWxzZTsNCj5kaWZmIC0t
Z2l0IGEvaHcvdmZpby9oZWxwZXJzLmMgYi9ody92ZmlvL2hlbHBlcnMuYw0KPmluZGV4IDdlMjNl
OTA4MGM5ZC4uZWExNWM3OWRiMGEzIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vaGVscGVycy5jDQo+
KysrIGIvaHcvdmZpby9oZWxwZXJzLmMNCj5AQCAtNjg5LDMgKzY4OSwxNCBAQCBib29sIHZmaW9f
ZGV2aWNlX2lzX21kZXYoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+ICAgICBzdWJzeXMgPSByZWFs
cGF0aCh0bXAsIE5VTEwpOw0KPiAgICAgcmV0dXJuIHN1YnN5cyAmJiAoc3RyY21wKHN1YnN5cywg
Ii9zeXMvYnVzL21kZXYiKSA9PSAwKTsNCj4gfQ0KPisNCj4rYm9vbCB2ZmlvX2RldmljZV9oaW9k
X3JlYWxpemUoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4rew0KPisgICAg
SG9zdElPTU1VRGV2aWNlICpoaW9kID0gdmJhc2VkZXYtPmhpb2Q7DQo+Kw0KPisgICAgaWYgKCFo
aW9kKSB7DQo+KyAgICAgICAgcmV0dXJuIHRydWU7DQo+KyAgICB9DQo+Kw0KPisgICAgcmV0dXJu
IEhPU1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKS0+cmVhbGl6ZShoaW9kLCB2YmFzZWRl
diwNCj5lcnJwKTsNCj4rfQ0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3Zm
aW8vaW9tbXVmZC5jDQo+aW5kZXggN2ExMGIxZTkwYTZmLi5iYjQ0ZDk0OGM3MzUgMTAwNjQ0DQo+
LS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4rKysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPkBAIC00
MDMsNiArNDAzLDEwIEBAIHN0YXRpYyBib29sIGlvbW11ZmRfY2Rldl9hdHRhY2goY29uc3QgY2hh
cg0KPipuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4NCj4gICAgIHNwYWNlID0gdmZpb19n
ZXRfYWRkcmVzc19zcGFjZShhcyk7DQo+DQo+KyAgICBpZiAoIXZmaW9fZGV2aWNlX2hpb2RfcmVh
bGl6ZSh2YmFzZWRldiwgZXJycCkpIHsNCj4rICAgICAgICByZXR1cm4gZmFsc2U7DQo+KyAgICB9
DQo+Kw0KPiAgICAgLyogdHJ5IHRvIGF0dGFjaCB0byBhbiBleGlzdGluZyBjb250YWluZXIgaW4g
dGhpcyBzcGFjZSAqLw0KPiAgICAgUUxJU1RfRk9SRUFDSChiY29udGFpbmVyLCAmc3BhY2UtPmNv
bnRhaW5lcnMsIG5leHQpIHsNCj4gICAgICAgICBjb250YWluZXIgPSBjb250YWluZXJfb2YoYmNv
bnRhaW5lciwgVkZJT0lPTU1VRkRDb250YWluZXIsDQo+YmNvbnRhaW5lcik7DQo+LS0NCj4yLjE3
LjINCg0K

