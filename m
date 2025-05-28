Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1A8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 07:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKAxs-0001FD-L8; Wed, 28 May 2025 03:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKAxq-0001F4-Dq
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:12:38 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKAxm-0001O6-BJ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 03:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748416354; x=1779952354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lDCL8Bfo8OkBi3z0LEbzhGo9qGtIo1SOKByH7oVZYpU=;
 b=EWTGAFwYjtCqny9SkYixT8yQSn6T6ZAhOOmiqqGckIgF1id8lq26G/nW
 gxqoT6q5f2P1gy0gQR11RqV6UEhxRgJyD9KgD6zOJUJFqiuACaoj2rxoU
 sellFuUTp1L0VRhPWzBe+eY8qxv/IJnqQRPSiHykKdNUYLtbKyCkmlgcj
 mOKAyYlZRwzK/ngBWRT5piR6i84Diac7rW0DcVdfpRPoo7UfhCEqUM+lU
 MBRnkRBr0dPJIks/4rCiJo9gIKxOuCVyDmfdJ0jsDWsFA5lrZ+lAGDe1E
 SVHlEi/Hwqaj4AG53Uc0DzzVeZ7KjjziKX435MsTjCUDvVyT4/MLG7z/Z Q==;
X-CSE-ConnectionGUID: rDDdGaRsSBi0dWkhINl0Hw==
X-CSE-MsgGUID: ZNDKV+RIQkaTXoHXsN15Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50127384"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="50127384"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 00:12:30 -0700
X-CSE-ConnectionGUID: pmbRGWEMShmY1yDCCX/WUg==
X-CSE-MsgGUID: ibeU28KnSqOObae2aC/E/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143132446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 00:12:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 00:12:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 00:12:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.72)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 00:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKUHB8KA7ZHwLZ6YAQNEBGB/uOl2TiKRlUCWXMitC6gdsxfU0AvsH2bFRnhy5isQlEmvdgDz1PcmuIwRppzcQzcxzEgR+GwSNbHf2n5jI/S1CcAHfpwTU6VCu6LqfiqmDqBKRhO52EsnigtzruT7vpTZXZptqmKHyC4giqYPcV2EcvpTD+8STJ47ij678vOkOlFWns4Ly03WS7jmmXdXcNkcnTa1ScQLFO7yCGIFp/Iirrs/fAfYWrpviVcEXm8fnWNfNv1oru3k6b2kT/Nu/cAN8h+7WH6ETNHTHDU+9lHTHiiAQe2s1FpLiSMclXIH/s/b/0tr7eI9ff/N9GojWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbH3bjLMFLA96fUWNKH8zvjgwzrrjnuU+jhQDHaza3U=;
 b=ZKRhKhseWTXpJ0naxIBkdv9TWQQRviQVbhRFG+c15h23ufBsUp2I/wmkSmpc7nhkyxzk5j8HMBpol7dT0VyU0Ut7jcgOKnk1ALZ1ovtZPDPMyDy+MYvReQmzqL1PTiWPK88gosRSECCNhTy8e05LetitrRx+tmASzIc4BsNKEY83DqEFHVjtQKN/xPRY4bf5oocggYc+x6OPH4dMoAj/Q/LFp+6XoEqoNMGBCAZSCWpSF4lN+mFfKCfSsRKkTxdDHzzfSaOO1w0igkaPZKREafH5xcGBOPyBlmjzmFHcyA2SdbWQ4QPkzVv3FrtekfAjKwJyAy2DQfqgZt0/5ECDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 07:12:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 07:12:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMA==
Date: Wed, 28 May 2025 07:12:25 +0000
Message-ID: <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
In-Reply-To: <aDSmcvZ08jNOSr05@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW6PR11MB8437:EE_
x-ms-office365-filtering-correlation-id: 518ba627-5817-4103-9f1a-08dd9db6ffc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Lp1x7Ynz5UaaZIjLOzJc7gAK+XtM1D/EEZn+9ePZ9MgcOLczLU+DEVI4PIcA?=
 =?us-ascii?Q?LlmXCaXGfxJ6Iqyk8gheg+NacE3nsjS4GoZrpZsIPVeHnuZfb+o73v6CCIly?=
 =?us-ascii?Q?/R9IZX+UurMyR13xl26W6FVfvhAdrren8vPTBHqmP2bmQq81Z9R7zjmDfKRD?=
 =?us-ascii?Q?bDPgWSNa5dWKV7RkmUVbrUYWEqwFJhTMGy8quA/Tn2ECu95i4Iv651cAu2Qb?=
 =?us-ascii?Q?9ijQy5lDGdvkp82VdLjDV/cZCcjMhqKI6A4+l8HoCRIpi94U9LO/uaq00I+B?=
 =?us-ascii?Q?e35AK/6ebbbrS0WuNN0jCO1OG9v7Oc3FkYbkbeaU2JIJsBAd/+jDarfp2Ebk?=
 =?us-ascii?Q?8Kz3IPa5iEni2Rz4rdJhQ5ZwXIDqGlNwHY6CeJZg1DQGKTrB841Q+9nGdzSc?=
 =?us-ascii?Q?zB98iP9LgPNl7WG2/W1aQDg5rNJGw89/km5Qed6w+mU25aMOd9FAXn4+LtxU?=
 =?us-ascii?Q?FYxcdNQRWDlHSIbJL8dtRI6QItHvm6AxJtbwYAgFo/TpUDTXrWWkZhqvgWE3?=
 =?us-ascii?Q?9Me53zq45fWsg96eNGf+iQgYVXfzV22VpthU7aIXJi6Fj4OJD8DLcdGm1uX8?=
 =?us-ascii?Q?hf9v4mHAy9TpwTiGnPgV70EwnigYYRwJWroAxOWRWm5G6SRa44uNaU+j0JSH?=
 =?us-ascii?Q?eURpUgmGZ+EFUKXPTYXmEUZV4xOVxJRDaRQluOhINC5SWbvOQ9ZUcZDTQfbv?=
 =?us-ascii?Q?9LHROPL4ktufVB3x+T8Z3+jFiqPGFFp5rZhYpSu2ld+Fbd/B+RMmHz3vAJVo?=
 =?us-ascii?Q?7xc8+wki1qiILoxCK4cYMvWNXpvhNTV/LRXhT+Q46xkE7di7oWbHfQCmKnWw?=
 =?us-ascii?Q?/KUtF1wuwcfobEfMCWZidjUufKznw3zMeYKfp0PNOcaHA/wHmXUh2OnSHQRo?=
 =?us-ascii?Q?psa0mr6y37H6nLTAR1gjwz3Fo8DrTStf9X4nZWQcyUnWqx8DflMxrSeFBY0V?=
 =?us-ascii?Q?52WKoJ5b7j5SSk7E44CtoeQFuy8LMlVj0hGO1J7YgsZ9/A1wVEGRAQnNcnbj?=
 =?us-ascii?Q?CuD8e3SVi4XV1pHm/DBllSTai1okdAxDTbw2UXyhjiKXiHF+V6RSM3434Aap?=
 =?us-ascii?Q?aslDjheJRTZUeH+4FtJU84z5b5yMIR54JI7JMCZwY9okNWZ4/V2WTvApLBAj?=
 =?us-ascii?Q?RLM3WMcctlVW+mOGQrB+iep5g7FGJCy7fDP455D8i+9nCEraIbTKJZsyx/jC?=
 =?us-ascii?Q?dDARU9e/QXi9s8Z67jc7sCBxvaau9HjrccB1SYsCrWCcbIYX338JPJ786oD4?=
 =?us-ascii?Q?0+4+IGRP9tMgd/3PHzI+OXn4vgMsONrMU+zwHmpoXL2Rt/G9hLssjQMy8tSP?=
 =?us-ascii?Q?j3cjT4PVECAmWrzOjRTfkODRnjZJkgGpkCVE/bUzd+ttrxvLeA4qWfWtJLLn?=
 =?us-ascii?Q?xJR5HdXphstgcT7xGE+iKkcINgadbzEDA+bQJ+EUwfT3INCwq/ahQ3Zd5Qmb?=
 =?us-ascii?Q?jgRW50r+kuy/9TlsNwqtlha0KPD/MlviC/ZmHKMRV3i5G66WkjO1KNaLBzoE?=
 =?us-ascii?Q?iKIBJ+jGFZRrrOc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CD81nReBPu8V+mBZL3zajyoYiRRJHRD60aaJ43fb0zF9wEEftJl8ad/R1raV?=
 =?us-ascii?Q?8ONSnXtDrhSuKNWi/NmOSxRuBwApXuMbHZeWJ/h8KzPivYJSYk+MIIpsI3B5?=
 =?us-ascii?Q?vcfLSateatrczjs54yF/PWs1f+YDQ3H6LV3jC3yToSMGP2PLEoqZ3ACG5Icj?=
 =?us-ascii?Q?QdJp0SAVZIWkPTN2IaKEhKgOYEFtyGs808TWYEe5fQnzbkzTCv6TKuOjX9AE?=
 =?us-ascii?Q?LTkbKX4DaA3p1DlURfCgWdSJZqi1pFfM0pKo/emKmqLS0vPOWJDd5bpAWqK4?=
 =?us-ascii?Q?y0YUAmSwvXO3p3Yp5wKrEorS76EAWvvJRKuqEMVf+P5ZlagnqByIwldxSCOi?=
 =?us-ascii?Q?ZKkNJg3Hn/6XC1GFejJvoremV4XVSrH+wZvxngb2PDOcyvdFlCC34c6bSIx7?=
 =?us-ascii?Q?Ba29HoBpgsubZ+lM6wgx1fsJl42YlLNiVD9RBLERL26WN8sciLQDWtP+wZHv?=
 =?us-ascii?Q?LyLh7Iq1rK8fmMdbMdnJ3oANsav8Ujg2h0YOVAGMOvwRcAgupHAFuSGNnWHT?=
 =?us-ascii?Q?Nu0smzABrIPLFckKGN83l+F+Be3V6Jx5s4rGsw/Ue7+vk3urgLT+XXVHZAzs?=
 =?us-ascii?Q?4j5O3bnje5ye82H/h2GTIh8SSdH6xst6h6PsnLgqpcRjU/OlYSU9ZXJHYSbD?=
 =?us-ascii?Q?wMIqy+GKkviJ+DU7zcnYqYsPsFaP/m5Qe5fgGGLjEg6g9eXykmMvCSdfo8GM?=
 =?us-ascii?Q?atNfzCA09w3WINkdPf0x30keSAxijbPsqCOvdHI6V1KWMb4GsIKSRq2pvn/9?=
 =?us-ascii?Q?VsCtQKl1bzMuLchpF9AqDgp4U5TO5DCrqXV1CswTnNnaGR8ICaGggVed7iqA?=
 =?us-ascii?Q?SfHjnS/YtH4uTsMOYSIic3FKJIiiOHqXzf0zCKYYweLZcQdnIr/ZocXjv84K?=
 =?us-ascii?Q?n+pJPiapNWeJniadFIpvuln+oNM+AdpYcjlNLOtqGl5Tubc0OUNJHaLXDHNm?=
 =?us-ascii?Q?gnki/4nFV5gu/lDM+sQZwcUtz8nA+UDg9erCYIt6JXw23XX0Y9mMKuhEcluP?=
 =?us-ascii?Q?sNYRuJHcIMDwH1NcrBl4zYCuN4X78scdwHlet+vW79IufqZA4YiBfdqooo1+?=
 =?us-ascii?Q?w7R4pOA4acgwd/iJyAaezLidEB8nSe4cJh859Dsh2xeMtrfjExXpo4cwJqna?=
 =?us-ascii?Q?mZZ0WWdkogGyYCQXGd9dDgELPpwBXrfpB4OFCQFg4zXIR0E3uFh8mTlKxgKc?=
 =?us-ascii?Q?D8t8j5g0yT8mAy2ltrnRS9tXKYgmDWnPzh1kRrN3mHZZdLNLeG1ioWkHs4ps?=
 =?us-ascii?Q?TuIYt5in1hx4upfcefSVyLfM/IrjDjYLtRNqTFJKSHE0dp3eaGRn1XHZ/AqS?=
 =?us-ascii?Q?mWkg9nDnGfP3upymnINjIGjN/BZIzmtQc897p+Pn92EzrsslzX0D9VX/NjX6?=
 =?us-ascii?Q?3pmGWdmLUKnZtPw81MW4c8z/ehZ71418MutFImWYjhr5RGl5IgOAlrm1FYyE?=
 =?us-ascii?Q?hcLbnjLKks18soDLCuLYSsNJowInJOjTB1e9r2R4apFCjA0Xz32nEQURSfgZ?=
 =?us-ascii?Q?vQn6fg6mfuTn9nLZKuO+duak46sxtKghV6XsrXirsIW2tC/3Ej4DaR98/D1x?=
 =?us-ascii?Q?nPlo+p1r3OjScbVLl/6hAsaXExV2Wy/5jTPhW6Yx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518ba627-5817-4103-9f1a-08dd9db6ffc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:12:25.6925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQJqLdKx67SwK/hfLsUF1pr9YySl/052VsIPWEVoqIyBbieetfRil6ieO7JeioMWOm+GYLXnhpqNAEJaernjOyIwSY+h/7y5wI3jR0Ez8UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
>host
>
>OK. Let me clarify this at the top as I see the gap here now:
>
>First, the vSMMU model is based on Zhenzhong's older series that
>keeps an ioas_id in the HostIOMMUDeviceIOMMUFD structure, which
>now it only keeps an hwpt_id in this RFCv3 series. This ioas_id
>is allocated when a passthrough cdev attaches to a VFIO container.
>
>Second, the vSMMU model reuses the default IOAS via that ioas_id.
>Since the VFIO container doesn't allocate a nesting parent S2 HWPT
>(maybe it could?), so the vSMMU allocates another S2 HWPT in the
>vIOMMU code.
>
>Third, the vSMMU model, for invalidation efficiency and HW Queue
>support, isolates all emulated devices out of the nesting-enabled
>vSMMU instance, suggested by Jason. So, only passthrough devices
>would use the nesting-enabled vSMMU instance, meaning there is no
>need of IOMMU_NOTIFIER_IOTLB_EVENTS:

I see, then you need to check if there is emulated device under nesting-ena=
bled vSMMU and fail if there is.

> - MAP is not needed as there is no shadow page table. QEMU only
>   traps the page table pointer and forwards it to host kernel.
> - UNMAP is not needed as QEMU only traps invalidation requests
>   and forwards them to host kernel.
>
>(let's forget about the "address space switch" for MSI for now.)
>
>So, in the vSMMU model, there is actually no need for the iommu
>AS. And there is only one IOAS in the VM instance allocated by the
>VFIO container. And this IOAS manages the GPA->PA mappings. So,
>get_address_space() returns the system AS for passthrough devices.
>
>On the other hand, the VT-d model is a bit different. It's a giant
>vIOMMU for all devices (either passthrough or emualted). For all
>emulated devices, it needs IOMMU_NOTIFIER_IOTLB_EVENTS, i.e. the
>iommu address space returned via get_address_space().
>
>That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
>for passthrough devices, right?

No, even if x-flts=3Don is configured in QEMU cmdline, that only mean virtu=
al vtd
supports stage-1 translation, guest still can choose to run in legacy mode(=
stage2),
e.g., with kernel cmdline intel_iommu=3Don,sm_off

So before guest run, we don't know which kind of page table either stage1 o=
r stage2
for this VFIO device by guest. So we have to use iommu AS to catch stage2's=
 MAP event
if guest choose stage2.

>
>IIUIC, in the VT-d model, a passthrough device also gets attached
>to the VFIO container via iommufd_cdev_attach, allocating an IOAS.
>But it returns the iommu address space, treating them like those
>emulated devices, although the underlying MR of the returned IOMMU
>AS is backed by a nodmar MR (that is essentially a system AS).
>
>This seems to completely ignore the default IOAS owned by the VFIO
>container, because it needs to bypass those RO mappings(?)
>
>Then for passthrough devices, the VT-d model allocates an internal
>IOAS that further requires an internal S2 listener, which seems an
>large duplication of what the VFIO container already does..
>
>So, here are things that I want us to conclude:
> 1) Since the VFIO container already has an IOAS for a passthrough
>    device, and IOMMU_NOTIFIER_IOTLB_EVENTS isn't seemingly needed,
>    why not setup this default IOAS to manage gPA=3D>PA mappings by
>    returning the system AS via get_address_space() for passthrough
>    devices?
>
>    I got that the VT-d model might have some concern against this,
>    as the default listener would map those RO regions. Yet, maybe
>    the right approach is to figure out a way to bypass RO regions
>    in the core v.s. duplicating another ioas_alloc()/map() and S2
>    listener?
>
> 2) If (1) makes sense, I think we can further simplify the routine
>    by allocating a nesting parent HWPT in iommufd_cdev_attach(),
>    as long as the attaching device is identified as "passthrough"
>    and there is "iommufd" in its "-device" string?
>
>    After all, IOMMU_HWPT_ALLOC_NEST_PARENT is a common flag.
>
>On Mon, May 26, 2025 at 03:24:50PM +0800, Yi Liu wrote:
>> vfio_listener_region_add, section->mr->name: pc.bios, iova: fffc0000, si=
ze:
>> 40000, vaddr: 7fb314200000, RO
>> vfio_listener_region_add, section->mr->name: pc.rom, iova: c0000, size:
>> 20000, vaddr: 7fb206c00000, RO
>..
>> vfio_listener_region_add, section->mr->name: pc.ram, iova: ce000, size:
>> 1a000, vaddr: 7fb207ece000, RO
>
>OK. They look like memory carveouts for FWs. "iova" is gPA right?
>
>And they can be in the range of a guest RAM..
>
>Mind elaborating why they shouldn't be mapped onto nesting parent
>S2?
>
>> IMHO. At least for vfio devices, I can see only one get_address_space()
>> call. So even there are two ASs, how should the vfio be notified when th=
e
>> AS changed? Since vIOMMU is the source of map/umap requests, it looks fi=
ne
>> to always return iommu AS and handle the AS switch by switching the enab=
led
>> subregions according to the guest vIOMMU translation types.
>
>No, VFIO doesn't get notified when the AS changes.
>
>The vSMMU model wants VFIO to stay in the system AS since the VFIO
>container manages the S2 mappings for guest PA.
>
>The "switch" in vSMMU model is only needed by KVM for MSI doorbell
>translation. By thinking it carefully, maybe it shouldn't switch AS
>because VFIO might be confused if it somehow does get_address_space
>again in the future..
>
>Thanks
>Nic

