Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F51FC25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA44z-0001PH-QD; Thu, 23 May 2024 04:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44w-0001Hw-3l; Thu, 23 May 2024 04:45:38 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA44u-0006fi-8w; Thu, 23 May 2024 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453936; x=1747989936;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lHbPsGQq9N3IcResbK2xJc9e2I7y6tmT5kU9IwAGG0U=;
 b=DgxdgPZH+qIRAyGZJGHMBrMpR0Q2A1wxaDndmimrlZMEDWXRL2VCqtVv
 FAduqU9BFz/oIitHTh2TlhQ3LhV1o4+JZjsJwav1BL6rwW0Tenkqtf7Iq
 dpPTHIsoJ43M1FWr63MxMstIiiv5UDIMrhrjv8wniLIpvgIpISE89e/ki
 b+I7yMldnXmtg4bxWsX6q2CiFpR67Dv3DYhWtnGodiNod/UCP0hfYvNcX
 oZtXNv43j2lLzDCD/iojsSB2sEeGzVbxWs0AV1pwnf8CX148+zQLW1a2n
 ICaEAXWlts6tPAPfcTqPKnMAeCRCEzll0VhCMI2AxvIFGoSwYGDugb6of g==;
X-CSE-ConnectionGUID: OmY4pm+/SEqsqld+kEbVxQ==
X-CSE-MsgGUID: BobPtbLTQAqOUoaWRzAz2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23329777"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="23329777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:45:34 -0700
X-CSE-ConnectionGUID: L/QD1n7lR3q0/5pJs9YyxA==
X-CSE-MsgGUID: k9BDqpjHQbGIzWevYZopWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="34133598"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:45:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:45:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:45:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:45:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJPlNr2cnxJ0mdTlNHi0DO72I7JwE/hSIvB4VFaFYqv9YF+A1urHpGEBnvZoz9aERV83Z6BX8AWePyaMOOLgmBgyHpvV8wAluDB3WudOG0G8XdTWlMMsMVyv8kK/PRXeLpyUd2NwuqtpMuCmXbGjG77ZGTmXDZOPhAJkyOyf/q0sGgZXZQh4jcShIE8dDDlRCaHP77RUsWWW3p1hTrqfwfxaiIk7f9+p4+Y9/+j+bHqTKgMnky7HS2UjAzPZrBDlrCI+qNJ0COlbGaMyvONq+AmheN62WNn0uHkxDbVOasAIPIMlkznzIbsvZ6ZUNHC3FuDiE6RkhN9p7fIHryfl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHbPsGQq9N3IcResbK2xJc9e2I7y6tmT5kU9IwAGG0U=;
 b=HreTvFQw1SmtCrRhynxSAQ+KcslVViNN44KYjgvBB5xb7+CKAtFVfF2ot6+v5UMH7ZmVZmyvFk4up9rdbnygGv4rUe+5kfnwjdKleecrfrXnDqIdX/Aan0Ygyjp3bpd02jtNR6xcXd35xD9Cbn8zn3dIJPgUlXl9nLrxNaHzlL3Wmgsd8eldLAYmP9MItK2yOSvrI1MDa05ny2mOAXN4b5Ri9tBjo4SPvvQuZKB1qqGWzwKY7um/7HqXo4gkhyPSbZsm9e0XY4UXR8eWlWVx/MJHSwb6EV8SMrF3ioRtaT2F2gOjzxhqxEpZkUh4lLyehNk6MgXWrtWnbEbflF8ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:45:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:45:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 5/7] vfio/ccw: Use the 'Error **errp' argument of
 vfio_ccw_realize()
Thread-Topic: [PATCH 5/7] vfio/ccw: Use the 'Error **errp' argument of
 vfio_ccw_realize()
Thread-Index: AQHarGnE4FgqRzaCC0icU2jDqE6NarGkgjIg
Date: Thu, 23 May 2024 08:45:31 +0000
Message-ID: <SJ0PR11MB674470C966965868FEC0B2E292F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-6-clg@redhat.com>
In-Reply-To: <20240522170107.289532-6-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: 57df72e6-7351-45e9-46a1-08dc7b04b45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eDFlN2JsNmRCakhZSW94UGU3UXZhcWN1S05razBwMVFYdzZIdjhGbWVZbzBu?=
 =?utf-8?B?eW5MMXdLcGE0bEZycStudnloTlF1dFBpU1h0cDhiTmlNUVNmUXRWeU9HZzBh?=
 =?utf-8?B?amNVOU9PMm1NNnhPMDB5Vk5SOXl2eklqRFUxK2NEZGJwTjc3aWEyR0JPRlEw?=
 =?utf-8?B?RkxoYUVZTUNRQmhiYk5reHNmM2dZN2dMRFZJbm13TkhaYnpYM080c2lQVjJp?=
 =?utf-8?B?bXlCRHY3VXpEY0pHMmdtY0hXOU52R2REbGtzQndkT29uelJhSnNyTlhrenBh?=
 =?utf-8?B?Wk94c0xrdllpTEtPS2xBMkNGUU5vOXZJYTNObGh1ZW9oVUl2MEEwb0NBUEs4?=
 =?utf-8?B?dkNrNVRTekxNbUo5dHhPdlA2anQxei9KY3o4ZzBHd3J5eHRuSUptdGlteXov?=
 =?utf-8?B?VHZEMGdHRzcvdFZvUitWZWUwaFNGUE5ZUmpPUUVuNlZLcHk2Q2diZ082aGlq?=
 =?utf-8?B?VTYxQzg2dGNmNTdkUDhDeHVML0hZMGJHQmlKMXRlUHdmb1FMamtsN3dPWFA1?=
 =?utf-8?B?V01BRHlXMEdVUlo5MzNDMDZVZ3hSdjhwdUFpTHlzaFdobm5IYS9mcXNrNmNp?=
 =?utf-8?B?RGYxZnk2MzhhT25jZmpPUHRyZDhDV0FPR2ZONGV0SWJhdGtJd0gzSXBPMHEw?=
 =?utf-8?B?VWVoQzFRUXg3c0ZrWjFzVjFBU2tkUjEvL1liQWU5N2l5MDJMWHo5Y1J2M3BM?=
 =?utf-8?B?NFozOWhzQ1RDaGJwNC9KcFVBaDFNb05XQXhPR1VTWGlTMktWUWR4MTVVYWh6?=
 =?utf-8?B?eFhrZ0lseDdOeWZqZThwSzdUcm9yYTRnbGNGemVuY2Zva3k4c2o2SHc4RVEz?=
 =?utf-8?B?a0tUcHNrRWFObC9EOHR5MGhKaVlVZVJlTlA2U1E2UGlVZ2xLdnJKdnZreDdS?=
 =?utf-8?B?U2xwaDFKSEtMUXdteHpSSCs3bUxKeDdHMUFjWjVSOGVnUkRXSFpMTUdkWkdP?=
 =?utf-8?B?c2tTK1JDQVpRRFcwK0tURE9zZnkwaGkwVy9veGh6M2Nod1lJcUtGNlcrSGV5?=
 =?utf-8?B?Y1JTcmo3WXZQbkl0c2JHSGcrNS9BOUVGa2tPam1mREVPYjVoUnM1YjNRUmFz?=
 =?utf-8?B?WnVnQXNVd28yK3c4VTRrYXBoQmhwQ1VLd1pOUWY5ZDd4WVJyKzdRdi9Qb1J5?=
 =?utf-8?B?NThzZ1VGODhHTW45cjJtYkZBYjVUZzhEaGM3ZnpONUdkdkJUUTlzVWVyVlk5?=
 =?utf-8?B?VG5pOEordUpTS3ZXd2RycCsySHR1czhxS0FmV3JBaVE5Z3Jham11dVZQc0M1?=
 =?utf-8?B?L3BNZ0dyMCs3ZnRoR1YxT0I4VEo4WVZaUkhZMmlCY2pMcmdDMDVGZVNyT29G?=
 =?utf-8?B?NGROTGgrZTB4YjNjNHhTbEdkQ0xrLzlBYmt6bUkreVAydVRVSFBmRUt2K0N1?=
 =?utf-8?B?YncxdncvZzVXZ2szLzdndStSSldoSDNVZWp5MDMxRkRXSktmWENhVkJOTGla?=
 =?utf-8?B?K3E4Q3BUbXJHWjdVczd2YW9MZWViMmRXaWVvNk1lRTA0U2NhK2FNQTBhU0VD?=
 =?utf-8?B?ZGg2bWNRb2hsdGdLQ2M4YmtvVVBOWit4VWw5QnZldkd1RldhUUNMcVc1OVdO?=
 =?utf-8?B?UHRkYjdwcjNWQjZuYVJxQ2lBSzk2WnpYZ0xVKzhQdEJDK3Y3N3k3VWFMWFJJ?=
 =?utf-8?B?dG9sNmNnQmNpaWNTZnA0RHpkTlVBbFc3UXFST1NIYzFzeStTYmE0ZDRVUDBZ?=
 =?utf-8?B?WE5nZVM2U1N1SnZlOWNCemQ4WlFHTHM0aDdwMVZRQjB1Q04wUG1zaFRVU0Ix?=
 =?utf-8?B?NmE3NjNaK1pYWU80S09FcE5XdHBaZGpjK3FsTEp5NGVTN3Znc3IwWEFMaVZ1?=
 =?utf-8?B?UFJ2ekpmQ0p1UWptNU00dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFdpWVp1RGJwRjNRV05xa3dEcjdUazR5ZXRnU0tjV0hKMVdFYXRqajUxalFr?=
 =?utf-8?B?NTR2QUdaK1dmYWtkTmJva0J2Y3F4OXA1K1I0bFFIdTU4K3lSNHI3RVNDQ21O?=
 =?utf-8?B?UTdtUExnT1ErVTluZ3crTG9xZkZ0ZjdhKzFGM085c2hsVmFkYzRtQmE4bW5k?=
 =?utf-8?B?aVpEYzY3U092ZnFXK0FySDJGS1hnM3VZaWtoOHByRGN6U1I3Qmg5WXJuQU1G?=
 =?utf-8?B?ZzFta0FqYkF1ZkpmZnVoVmwyWElkZHU1dW15elQ2SUY3RXcvNk1kaXlZeHZP?=
 =?utf-8?B?Sk0yQnB3MHFPZ3FQOU1pTURRNGdiMWU1K3EyRmNwcjJCMWdHTzM1L1pIOWJL?=
 =?utf-8?B?eFZpejM3ZGpZOVY4M09nRlpBMWpsWDFGUS9hNjV0UkhHT3BHYTdRdmhPY0dG?=
 =?utf-8?B?Rm1KMHVtMU1SdVRPTVBqUG4vSG1VWGNJdHF0L1BmSm8rYVR0WTVBZFF3alN3?=
 =?utf-8?B?MXhaS1MvUEwwZXV0TE11VjlzQmVROVBwVGhSc25QMDFYTXJnend6RVYzaXlx?=
 =?utf-8?B?TTQ2dm5wOWNQbGlFaU15eVNTZkpoOFJOd0U1QzBjZG13cDhQaEx4d1Nlbisz?=
 =?utf-8?B?QU1hL3YyaG5sc1drU3k2U01pTmhmQjdIejJOWCtEOVZ1dk1YWjVvaVN6b25G?=
 =?utf-8?B?MU90V1h1Rk1wdTBFNkJlL3lFWEpmOXNvL1FwTmxKMXc1cG9WMTN1a0JwVEU3?=
 =?utf-8?B?U2hQalEyQS9BVlhJVk5qMGRvTXkyVTlRT2l5NTBraHVpTlZqWHB3TDF3MnNY?=
 =?utf-8?B?RWtsNEEvK2hCd0pvQ2xqNklaeElSWDlEeWxCZEs5aDQ3U29sMmdYTWJqZ05U?=
 =?utf-8?B?QStDdk5ISnp5eGRCWlVod0s0WjBCcGVPVlBuRzNobGlIaU5VbHJFMTd6VllO?=
 =?utf-8?B?alFzRWI1SXJtbFFnYXk0ZmJ5NkJXRUFXemQ0aGtvQXQ3My9oOTVVeDJrM09H?=
 =?utf-8?B?NDh3R3lsamdqRDhZOWRCbjdCTkRTQXBiZGxxWHF4V3R2NmlqeXdVV1FJQUwv?=
 =?utf-8?B?dmNxNnlNemdQaTIxMFFCbmgxZm9PQ2NEcjUzZDBBcGNhRUozaGpnR1hlYUZ6?=
 =?utf-8?B?SG5xQjJvTXE4dVkvRllPaGMxeEJObGI0b2l3UWxMN21FMVpjZjNwSjl3dVhF?=
 =?utf-8?B?bzFvWVhZbS9uWUJHMWpiaFU2MWlQL0FqTnl3RTBaZGx1dUcwZlQ1dXFxeXZN?=
 =?utf-8?B?R2luK1ZrL1J4aFJ3WFlnZndsUkkzVjB0MFZrTnhHbmczUjdQci9abDV3YW85?=
 =?utf-8?B?cmZTWDZPRXQxZk9QUWFwMzE5QWo5NnNxQjdyZVl0SUVLS2gxaTdtV1BEcCt0?=
 =?utf-8?B?UExyN0YvTm9IeUwrQ1dRUmZXVlZ0ZDRua0JtWnJrNk5DaTEzT0c2ZHQ3ZUR2?=
 =?utf-8?B?elp2dC9DTHZtdHhSeU1hb3FYTzZwNE1lN2FVQ2tYUFpuRGFwQlViQUhGcGVT?=
 =?utf-8?B?R1NSV2VpNnRCaWhLMnUzaVVMNkJNa1ppQ3dPY2dZVU1MSk9KM1J4dUY2MzBv?=
 =?utf-8?B?c0t5MWd4UHhOaVVraHhUNjFWZmxrcTBONXQ4WTNoeDhBdHU1Q1NuWFJ4eDlp?=
 =?utf-8?B?cHdkZWhaVEt6Nkpxakh6YlBQY2twa0RWTU1iRCtnR0RtUjlnYWpWNnJWdlpZ?=
 =?utf-8?B?QzBUTmMwSktTODN1YWJBMjhxR25QWlI5ems5TWpxRkNGdEQ5WG5UN25FOEdS?=
 =?utf-8?B?MS9VSUlCNmZTd3JiU1Q0RkFsQ1JOdG91RWpqaE5ZdzNZTE5ERERPU1U2bVZp?=
 =?utf-8?B?a0dJbVMrM0dCaGY0YktBRzAyVDIva0RZcE5tV1NRdzZQUWFMNnQvK2wxeVdW?=
 =?utf-8?B?YjZ0ZjVmZFhPYVYxMlNmeW1EZ0paM0dsY0dRSnQwcGNMOTY3VThLRmp6NkZz?=
 =?utf-8?B?enM5aXVOUFFKVFJaZW9kcW9sc3ZDNTAyZ3hyeU9QQVZTcWtVWlJ3WDE4VENn?=
 =?utf-8?B?ZFFzN3A2aEVMMkVjd1hOWHhaODAxUXNJcHN5VmY0S2JDa0NIc2ErTmJxZkQx?=
 =?utf-8?B?SUh1dXltSXVVaEluRnk1R2wzbFJNOVZPRDZLTmhiMjZSbmYwRkE3ZW1XZDlM?=
 =?utf-8?B?OXVpanI0dXlpVERhVnBra091VXVRZmxuOGNqeVI5NTRWZ21NbTRBR01DV2VM?=
 =?utf-8?Q?OebsOwY6D1FXcOJRb8nSvkiDO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57df72e6-7351-45e9-46a1-08dc7b04b45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:45:31.5337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEk7uE6SMFbUeaOTdBEHKaYbZ/EKJo5MA14uc8v8K+fYXOpYHiMYOF6KJoRVmlr8Redbd0vDN7wP8n/xRfpSmXGIqy8T87gJ3q9CP0FQ6Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggNS83XSB2ZmlvL2NjdzogVXNlIHRo
ZSAnRXJyb3IgKiplcnJwJyBhcmd1bWVudCBvZg0KPnZmaW9fY2N3X3JlYWxpemUoKQ0KPg0KPlRo
ZSBsb2NhbCBlcnJvciB2YXJpYWJsZSBpcyBrZXB0IGZvciB2ZmlvX2Njd19yZWdpc3Rlcl9pcnFf
bm90aWZpZXIoKQ0KPmJlY2F1c2UgaXQgaXMgbm90IGNvbnNpZGVyZWQgYXMgYSBmYWlsaW5nIGNv
bmRpdGlvbi4gV2Ugd2lsbCBjaGFuZ2UNCj5ob3cgZXJyb3IgcmVwb3J0aW5nIGlzIGRvbmUgaW4g
Zm9sbG93aW5nIGNoYW5nZXMuDQo+DQo+UmVtb3ZlIHRoZSBlcnJvcl9wcm9wYWdhdGUoKSBjYWxs
Lg0KPg0KPkNjOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPlNp
Z25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5r
cw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaHcvdmZpby9jY3cuYyB8IDEyICsrKysrLS0tLS0tLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPmRp
ZmYgLS1naXQgYS9ody92ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cuYw0KPmluZGV4DQo+OWE4ZTA1
MjcxMWZlMmY3YzA2N2M1MjgwOGIyYWYzMGQwZWJmZWUwYy4uYTQ2OGZhMjM0MmI5N2UwZWUzNmJk
NWYNCj5iODQ0MzAyNWNjOTBhMDQ1MyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2Njdy5jDQo+Kysr
IGIvaHcvdmZpby9jY3cuYw0KPkBAIC01ODIsOCArNTgyLDggQEAgc3RhdGljIHZvaWQgdmZpb19j
Y3dfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPioqZXJycCkNCj4NCj4gICAgIC8q
IENhbGwgdGhlIGNsYXNzIGluaXQgZnVuY3Rpb24gZm9yIHN1YmNoYW5uZWwuICovDQo+ICAgICBp
ZiAoY2RjLT5yZWFsaXplKSB7DQo+LSAgICAgICAgaWYgKCFjZGMtPnJlYWxpemUoY2RldiwgdmNk
ZXYtPnZkZXYuc3lzZnNkZXYsICZlcnIpKSB7DQo+LSAgICAgICAgICAgIGdvdG8gb3V0X2Vycl9w
cm9wYWdhdGU7DQo+KyAgICAgICAgaWYgKCFjZGMtPnJlYWxpemUoY2RldiwgdmNkZXYtPnZkZXYu
c3lzZnNkZXYsIGVycnApKSB7DQo+KyAgICAgICAgICAgIHJldHVybjsNCj4gICAgICAgICB9DQo+
ICAgICB9DQo+DQo+QEAgLTU5NiwxNyArNTk2LDE3IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj5FcnJvciAqKmVycnApDQo+ICAgICAgICAgZ290byBv
dXRfYXR0YWNoX2Rldl9lcnI7DQo+ICAgICB9DQo+DQo+LSAgICBpZiAoIXZmaW9fY2N3X2dldF9y
ZWdpb24odmNkZXYsICZlcnIpKSB7DQo+KyAgICBpZiAoIXZmaW9fY2N3X2dldF9yZWdpb24odmNk
ZXYsIGVycnApKSB7DQo+ICAgICAgICAgZ290byBvdXRfcmVnaW9uX2VycjsNCj4gICAgIH0NCj4N
Cj4tICAgIGlmICghdmZpb19jY3dfcmVnaXN0ZXJfaXJxX25vdGlmaWVyKHZjZGV2LCBWRklPX0ND
V19JT19JUlFfSU5ERVgsDQo+JmVycikpIHsNCj4rICAgIGlmICghdmZpb19jY3dfcmVnaXN0ZXJf
aXJxX25vdGlmaWVyKHZjZGV2LCBWRklPX0NDV19JT19JUlFfSU5ERVgsDQo+ZXJycCkpIHsNCj4g
ICAgICAgICBnb3RvIG91dF9pb19ub3RpZmllcl9lcnI7DQo+ICAgICB9DQo+DQo+ICAgICBpZiAo
dmNkZXYtPmNyd19yZWdpb24pIHsNCj4gICAgICAgICBpZiAoIXZmaW9fY2N3X3JlZ2lzdGVyX2ly
cV9ub3RpZmllcih2Y2RldiwgVkZJT19DQ1dfQ1JXX0lSUV9JTkRFWCwNCj4tICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyKSkgew0KPisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVycnApKSB7DQo+ICAgICAgICAgICAgIGdv
dG8gb3V0X2lycV9ub3RpZmllcl9lcnI7DQo+ICAgICAgICAgfQ0KPiAgICAgfQ0KPkBAIC02MzQs
OCArNjM0LDYgQEAgb3V0X2F0dGFjaF9kZXZfZXJyOg0KPiAgICAgaWYgKGNkYy0+dW5yZWFsaXpl
KSB7DQo+ICAgICAgICAgY2RjLT51bnJlYWxpemUoY2Rldik7DQo+ICAgICB9DQo+LW91dF9lcnJf
cHJvcGFnYXRlOg0KPi0gICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQo+IH0NCj4NCj4g
c3RhdGljIHZvaWQgdmZpb19jY3dfdW5yZWFsaXplKERldmljZVN0YXRlICpkZXYpDQo+LS0NCj4y
LjQ1LjENCg0K

