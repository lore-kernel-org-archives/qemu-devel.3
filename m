Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC010C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 05:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWUQ3-0004QP-Qg; Wed, 24 Jul 2024 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWUQ0-0004OZ-Vq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:20:05 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWUPx-0000B4-1M
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721798401; x=1753334401;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=juK8mxLYlhBhEFGPhe8DkX5SgJpYVPcGwqPDMeqyzag=;
 b=jTkxFUDCnmU0i7rKil2m5Pk7pDVMVmZsRILwwWATsv2CzyzXsW0Pg5st
 VfxAoiwQ6sPnlaBchXg4WIepGF8Ou7TmIW8qgeAvR2+T2lX4dUv7lBojv
 VUxdeKrZNTUS1+qKhElFwrBUlmnHRCcvyvG/iQMMmqfdFALEn+5Z4H7lK
 Cl2ibrq5B4Hw888WdnnHO4YS/ebYlEUOl7wEhN/RXxJjKUENQWrXnf+wA
 oIkF1OuaAR+0x/0wJaGS+JAYxwv+jJ8Hj98WXQJWu8riOhrZz2VXxIPkW
 CGXHyxuWKIapAkxKkhcoZ9zhtE69rd957JOsI2madxdDCnywCVNhQT37j w==;
X-CSE-ConnectionGUID: YfdIrbpaT2OlKVnfFWaiRg==
X-CSE-MsgGUID: TXM8z0dCQNmktHMy3l7jLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="12680593"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="12680593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 22:19:58 -0700
X-CSE-ConnectionGUID: /QqGJ/oURO2L3meO5gkX+w==
X-CSE-MsgGUID: naYyHIXjQgeAiBqSGhympQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="57276701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 22:19:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 22:19:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 22:19:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 22:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0P3z6n6FRiqHpcZVqZP+wCGW0NK07QQFKr4bb44oNs9YW6J6XLauCPwd6K9YqZJwPNPwMSCiY04Vy6Ril7yEMn3+Ss+d1NBjQbFbqePJycUY4aKZbbUdJBhvm6eRb161dNn9ULsnd+Zui/QqpWfw9ThTeRrBMh+ZnXTzD+7ldC1Rjl0D5zgqVfOcJwbolzAAOTRsRVC4QMuL5JjbrIonz21YHo55PDSazj9PSb6RcheNMbMQ3Y3RGlGWWn3yRBRsLYiLKzHEGQsNJ+qfYdy6j6O8a2/iJfPFtfzUaqMEBrHizChOn2CR3inEKtS1Tg4sNp4OJ7cbI5tl4Xg6rLjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juK8mxLYlhBhEFGPhe8DkX5SgJpYVPcGwqPDMeqyzag=;
 b=cXSCxkvidfF4nyEx63YWbjhVVCCvlmk9pCE3gJkgBhAAPUQpVrud9ZScQVFxmsSRsFAu0mc+BB7M2LoR5UybrHlXMBsY9j69RKuSaW3/PkCnp2EvxYipqEQrBQvv7jtdbWcRWLo8Taq7PSXHNJ3hOc222yfZaja1T47fQCLZIc5Ql/46TUZEiXhl5sQ8V6SVDgiDTb/EOlAdBVWcg/i+AZ551rAX4M953iC1IAXkI2n7qXX7wBcowJQCdglktJ2kPX1qHejitckuyzYGPIiaAypyHxRkw64qGEEt5IpXvYkljXY1b15XctKysNCp3CrrQy38RW4TxJuWBFYD2mSxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 05:19:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 05:19:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Index: AQHa2OtDN6KlO7Waz0m+MLgs31oMZrIEgXyAgAC3N7CAACbdAIAAAIaw
Date: Wed, 24 Jul 2024 05:19:54 +0000
Message-ID: <SJ0PR11MB674491FDC200B798240CD4E592AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-5-zhenzhong.duan@intel.com>
 <8bc5a4b9-9b25-42dd-aeda-8140a81e1505@eviden.com>
 <SJ0PR11MB6744432BBE635975409412CC92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <75146be8-2ee7-4b7c-bb78-06c4a846bb67@eviden.com>
In-Reply-To: <75146be8-2ee7-4b7c-bb78-06c4a846bb67@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: 4e076872-a6e1-432b-55e9-08dcaba0405f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dytad09LYmZnTllnUWxMdDFCRHFqQWVoSWdsYzM4ZG1qclljVHBsTnpacFoz?=
 =?utf-8?B?M09TTHdKcWVKSjhBbW1TVy9tYjVWQm5QY0ZWenhEZTlDdjF1WmZjd0EyNnVz?=
 =?utf-8?B?N01CcnFCbkJXVDhRQndrRkNIdEp6d2Q1UHdDV3ZKaEdyVmM4RTkzNC93dkxD?=
 =?utf-8?B?UDVQMnpMNXp1S1dzR2FwN3Nud0ZMekwzVUZndVhIV2dDSzFqdVNwOXF0N3VR?=
 =?utf-8?B?YzVkTG5UK01xZFJITUZjZm1CbytEckxxTkI1ajZHaVhFYTF5YnJQNXpoZ2py?=
 =?utf-8?B?WWRyT1l6VExSckhMSmMvVVd5WEd2K256clFiVFNMUGJZQlJTdmNtR01ldFJI?=
 =?utf-8?B?QVVGR1pseFBrWTJBcXRvOEhZb0pqNWEzcUh1eG12KzgzRFpzazJKKzBCaHd0?=
 =?utf-8?B?MkZFNjl1eEMyYzlTN3BTYjNKTDUxZ1lKRzd3VjhtbVB5cElCUm1ISHlDSDls?=
 =?utf-8?B?ODg1SUVIMWVPVDdLV0xaeXdnR01HOXAxNWhheDhZZldJR29tY0c1N3hzbFNy?=
 =?utf-8?B?clZYbzJuN2JmZE9PaFRrYjZXMGtkbHdPNG80Ky92WjNNakpYcldZZnY1L0lY?=
 =?utf-8?B?N21wdEgwZU10RFp5YWl5cnE0Vm9DQVNuaDg0RUozVWZ2N295SVhiYzc1bW5F?=
 =?utf-8?B?MDB1SGp1aExweUErK1d0aC9HZDRHajduMGNsbk9oa3BwL2padllyZHRQTnRk?=
 =?utf-8?B?QmhJNGRkMEVwSWx3RXpKTE1OOGNld3JCVVZ1dnd3a0p4ZFJUVnQzalMzRWxS?=
 =?utf-8?B?a3NYUTdKeDhSNUZIUEpPalNTNWdPUmxLRjFLYVNmSENUV1FMTXNoekVnUlRN?=
 =?utf-8?B?YXUzeUQ5OE8yd0dmYlhEMEdOUENOUDJ1dGVROUF0M2lFWjZqWWFKZldRaW5x?=
 =?utf-8?B?Y09wSmh1WjF2OW0xbW9aczVvZWFFQ1ZReFkvVnlIcVJuNlJ5M2xIUzhyZGYx?=
 =?utf-8?B?SVBmSGNSUGVVSWtURHA5SHNmcEl1WC9vREhCemN5RkNRK2xYZHpZaUF6RTlI?=
 =?utf-8?B?SVlCVWRrNE53Y0F3dDN3MGUzQzZhUXZITVFFNEtLV3llL0l2eUxOcFpoemdJ?=
 =?utf-8?B?OENzWHpEeUpQZzI2ZldXaU5KY3FSY3hvVG51bDZ6dEVobGpmbzk4dHZ1ZDl1?=
 =?utf-8?B?cUR1SkJFWTZxSHZMNUlNZkdYVDYvTGNIYldnQSttNTJRdVUveXZ3U21rZEJm?=
 =?utf-8?B?ZzVFZi9VWEowSml4bHliRVNXR2RIWENQWmpuRVBwTFBYZTFTelVLYTYrYlJj?=
 =?utf-8?B?dVNlTGhPTXdqc2Q3N096am02UkFtaVNDUkQyVGJUUERXaXdhZVNBcHBybU03?=
 =?utf-8?B?dXJ4VUVnTDZSVHlvK2wyOGtndFp0V1BSTHV5Y1J1T3IzcndJL1VxYmd5Nzk4?=
 =?utf-8?B?ZmJQTlQ1KzRuVVlYQU9oR0ExaE1tc1hrQXZYZy9tNExCd0JuQ1A2N2ZWeTVJ?=
 =?utf-8?B?YlZXcFh0TDVuU090c0dyZE44QVQvaFM5MitLM2U2Tmpxbk1DTUdVUC9MOHAx?=
 =?utf-8?B?cTlWN3lxcFRjc2poSUhack9WbFNFNVZPMXh4UnhVakIzVktwVDlDZ3VEU0g4?=
 =?utf-8?B?WHlPVkdnSXVDcmtFMFhIRjV6NVRCemd6bGtUVG5RNTZOdTRTU3QyOUhkZDQ5?=
 =?utf-8?B?amp3ZWlndUwrb0RoQVA0VlM1cGw5c3ptK3RYd2dsaDE0c0RXWkM5c2JBejNk?=
 =?utf-8?B?L2U3a3FFdjZMV1k0Z1prNVBzWllJazNnb0VleXRlM0RMSFpsWGFTQ25VZjV1?=
 =?utf-8?B?UjdZd3RkNml6L0ZtMzJqbkF0V0JBN0RJSWhrYm1EUHUzMnZ0UGlwOFcrdURa?=
 =?utf-8?B?eGdCSEtzVmlUeWp4VFI4WWg0RUZEY1IrR3cwNGtPelVoYjhNVElsUU5HZW82?=
 =?utf-8?B?NTQxTzhlS1hIbGhqZUVRWmlkbUJIOVpXY2pPTThKcHBkdWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDBJZnlNaC91K0tTS0dHNXFzd240U0FpbEhxYlRqY1QrY2ZMaVQ1QUlOazdU?=
 =?utf-8?B?ZmdwUlcrZU5LYnNyM2xUUU1qK3NQSVpmWm15WmZNV2F4NEtHNHNLQ0dTckhi?=
 =?utf-8?B?SU8vQ1hlUW91K2VZSVBQUGxxNGQ3UWIzMWhCZk40LzJFWmlndCtFd1hqc0Mx?=
 =?utf-8?B?TE4zbHozQ21ObGl0MktjUUI1TEpEZXljaG56Qldxa3lKTHJ6aXo4WWRlN3N5?=
 =?utf-8?B?dnJjNHdRaERhYUdDaDNoVXNUK3pNMHZLaC9JcndVMVA1OG5DS3RuSGtHWldQ?=
 =?utf-8?B?L0pQT09yd3pNWU00ZHhqYnZxSTl6WjZmdXlPL25TNlBsRXhxbU9KMSs1ZHpm?=
 =?utf-8?B?ZE9WSWFOSXBKMVZ5T24rT1FET3pFM0hLdFZ4OVBSYTdFV0lQLzl4VUdUKytO?=
 =?utf-8?B?OWlzcGtEa1h4TGc4TkpTWXZZMzRiMm1PSllpSXJEbXVQeXBQbmtlRVZiVXNY?=
 =?utf-8?B?S2NtTE00dExYQTkvUzRLU05qUWUwUTR0VHd1eHR4WmdrdlNPUzlUZnRqalVr?=
 =?utf-8?B?aG1ZRkQvaGRXK1g2TXZTYWZTZElZVDc4bXpDMzNmRkwrK1QrcmIxeGd5c1FW?=
 =?utf-8?B?R25lWlBYOE5MbGVOdmp4MzhBcXlsS01nUFVkWnZmbEc2WXFvT1pQWGd5Qyta?=
 =?utf-8?B?WDFDd1pra3hydWRuSENOZFVGMXVQSm43QmpYVXVZVmUwQi9kN2tkKzBUS3dB?=
 =?utf-8?B?enFicThzSUVqcDhyT1hwbEpRTFA0eUhnVjlhTVovNjI3RzhYRjVpRWRkejBH?=
 =?utf-8?B?OFJ1VjluR3FsUnZialBvbXlZVkIzMFo4cUpSZnZNeTM4U05VZ1VWYzdFME9z?=
 =?utf-8?B?Vy85OW9mUDhYbkRXSTFqODFMeEp6TXZGVS9ZTFAySUtIR0djRlY0RTNOUC85?=
 =?utf-8?B?dUVBaUJxcDUyZ2VpQ1prb2srR1EvY0xXbzVhckkwQnVCRFkxMkcwTnViWERj?=
 =?utf-8?B?aXI5ZCtLc2hwVDRSb2Z5aFBJbzljSDV1RWRFQkhjQkQ2cFJLN1RiL0RkTU12?=
 =?utf-8?B?d3JPaGdMTkpITy82SzFlN2FWQU1INWhlSU9TWHd1VXYvZHVlSEpBS1l4NEpD?=
 =?utf-8?B?VWw3QmM3bWN5c3FhM01SWTZzUytIbmFPTU5YeWxtblFxdC9OblhFMmJuckdO?=
 =?utf-8?B?N1k0U0g4UmU4RE9RVEVRL2V5dnZja1N5L2RPRXBwVy9URDhEaDNYcjZCWWZO?=
 =?utf-8?B?SVBLQmtNeDdMUGkrOVAydWdlbTVpcXRBWDAxTCtMMVdtb0dvcGhDL09pb3pD?=
 =?utf-8?B?aTl6NUk5MXVYWDgrdy9FZ2VQUlh6eUhpV0tvaUEzY0graElBZ1loSnZTYjA4?=
 =?utf-8?B?K0xmMnZIWnVlMW84RW5qcWwwdytINkhqekI1RmRVSHdPYWZkQ2Ixa0RkSWdJ?=
 =?utf-8?B?NUw5MndJZ1d1d2tuS1RDMVRETVdvNUVkT1dCQjRnYlQyM1pjWk5laGY1aUZR?=
 =?utf-8?B?ZWNwcCtjU010amFHMGdseVR1a0F6c0dzMng2d05vekxncjRQTS9Lak43UGFa?=
 =?utf-8?B?ZmsyRXFLL09OdjNFQnlnSHAwQzNCVkMvblErN0dxQ2pCR0hkU0wyemJVaC80?=
 =?utf-8?B?clVVTWdsRVpiT0UyeC9iK0ZoQXhVMnNMczl2TDNzci9sUmdzUmhMcWZxdzBX?=
 =?utf-8?B?c01BVWZLWWpCSXpkcFhCeE9qNTdnWWJEdDVyUzQ2blBuNXVidnR6eTY3UzRy?=
 =?utf-8?B?bDZSZVc0aTR5TUdyWHk2c2I3Y0E4eEtiNG4zRlByQ0JhdFNIbWo1WHd4cjZP?=
 =?utf-8?B?MEQzYk11ZnczUXBCUFZOTmlMS09BMnNMbWxCMWk3ZjRJOEo2MFdYODV5WDFz?=
 =?utf-8?B?L0wyaWxHVUU0SFdwV3dxaDV0aDBnZ2NUbjZ0SlMrYWRTWHFJV3ExaGJUOG1U?=
 =?utf-8?B?WkpYMjFxWm8yaEZ4TFJBNmNpbHpGaVJtT2tsYzlnSC92L2lWdHROMnJSbDI3?=
 =?utf-8?B?NnVLSkEycmtqK2lKbjVEWHdBN05tQnhjQUx4WVEreTFwWXpwdFE4Z2NocHli?=
 =?utf-8?B?SGZiYmZFbXgrUFEwUTRScEd4U0c2c1dZVCtEeEE3UWphcXp0MWg1VE5ZMmc2?=
 =?utf-8?B?Rm81dVlDWGxpM1ZReEk1cGh0U1ZxV2h4WHZIdlVrN25NZDVGL1E4YmMxMml2?=
 =?utf-8?Q?BpWRxb31uDjHI6sNqc/UY9N0T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e076872-a6e1-432b-55e9-08dcaba0405f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:19:54.2542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbTRisoFvCnnrA4cRKHU7bnT7Kn9Gg/YnJcpOtg9AEch3U/n27P31IDj3NUPFy5HvEWLfYkKrs3OX/dwRlulspNenmjzWWSOKnOKo1hb1Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAwNC8xN10gaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTIgY2FjaGUgaW4gUEFESUQt
DQo+c2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPg0KPg0KPg0KPk9u
IDI0LzA3LzIwMjQgMDQ6NTksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMNCj5lbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMTddIGludGVsX2lv
bW11OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluDQo+UEFESUQtDQo+Pj4gc2VsZWN0aXZlIFBBU0lE
LWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPj4+DQo+Pj4NCj4+Pg0KPj4+IE9uIDE4LzA3LzIw
MjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBl
bWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcw0KPnRo
aXMNCj4+PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlLg0KPj4+Pg0KPj4+PiBQZXIgc3BlYyA2LjUuMi40LCBQQURJRC1zZWxl
Y3RpdmUgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHdpbGwNCj4+Pj4gZmx1c2ggc3Rh
Z2UtMiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0Y2hpbmcgZG9tYWluIGlkIGFuZCBwYXNpZC4NCj4+
Pj4NCj4+Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBpbnRyb2R1Y2VkLCBndWVzdCBjb3Vs
ZCBzZW5kIFBBU0lELQ0KPnNlbGVjdGl2ZQ0KPj4+PiBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlk
YXRpb24gdG8gZmx1c2ggYm90aCBzdGFnZS0xIGFuZCBzdGFnZS0yIGVudHJpZXMuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAx
MCArKysrKw0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3OA0KPj4+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFu
Z2VkLCA4OCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4+PiBpbmRleCA0ZTAzMzFjYWJhLi5mNzFmYzkxMjM0IDEwMDY0NA0KPj4+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+Pj4+IEBAIC00NDAsNiArNDQwLDE2IEBAIHR5cGVkZWYgdW5pb24g
VlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4+PiAgICAgICAgICAgICgweDNmZmZmODAwVUxMIHwg
fihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPj4+IFZURF9TTF9UTSkpIDog
XA0KPj4+PiAgICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwg
VlREX1NMX0lHTl9DT00pKQ0KPj4+Pg0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExC
X0FMTF9JTl9QQVNJRCAgKDJVTEwgPDwgNCkNCj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJ
T1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8IDQpDQo+Pj4+ICsNCj4+Pj4gKyNkZWZpbmUgVlRE
X0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAgICAgIDB4ZmZmMDAwMDAwMDAwZmZjMFVMTA0KPj4+
PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMSAgICAgMHhmODBVTEwNCj4+
Pj4gKw0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKHZhbCkgICAgKCgo
dmFsKSA+PiAzMikgJiAweGZmZmZmVUxMKQ0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElP
VExCX0RJRCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERfRE9NQUlOX0lEX01BU0spDQo+Pj4+
ICsNCj4+Pj4gICAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9UTEIgaW52
YWxpZGF0ZSAqLw0KPj4+PiAgICBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQo+Pj4+ICAg
ICAgICB1aW50MTZfdCBkb21haW5faWQ7DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVs
X2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gaW5kZXggNDBjYmQ0YTBmNC4u
MDc1YTI3YWRhYyAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBAQCAtMjY1OSw2ICsyNjU5LDgwIEBA
IHN0YXRpYyBib29sDQo+Pj4gdnRkX3Byb2Nlc3NfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUg
KnMsIFZUREludkRlc2MgKmludl9kZXNjKQ0KPj4+PiAgICAgICAgcmV0dXJuIHRydWU7DQo+Pj4+
ICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlfcGFz
aWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlcg0KPnZhbHVlLA0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+Pj4+ICt7DQo+
Pj4+ICsgICAgVlRESU9UTEJFbnRyeSAqZW50cnkgPSAoVlRESU9UTEJFbnRyeSAqKXZhbHVlOw0K
Pj4+PiArICAgIFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQYWdlSW52SW5m
byAqKXVzZXJfZGF0YTsNCj4+Pj4gKw0KPj4+PiArICAgIHJldHVybiAoKGVudHJ5LT5kb21haW5f
aWQgPT0gaW5mby0+ZG9tYWluX2lkKSAmJg0KPj4+PiArICAgICAgICAgICAgKGVudHJ5LT5wYXNp
ZCA9PSBpbmZvLT5wYXNpZCkpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgdm9pZCB2
dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IGRvbWFpbl9pZCwg
dWludDMyX3QgcGFzaWQpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyBp
bmZvOw0KPj4+PiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4+PiArICAgIFZURENv
bnRleHRFbnRyeSBjZTsNCj4+Pj4gKw0KPj4+PiArICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWlu
X2lkOw0KPj4+PiArICAgIGluZm8ucGFzaWQgPSBwYXNpZDsNCj4+Pj4gKw0KPj4+PiArICAgIHZ0
ZF9pb21tdV9sb2NrKHMpOw0KPj4+PiArICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZShz
LT5pb3RsYiwNCj52dGRfaGFzaF9yZW1vdmVfYnlfcGFzaWQsDQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZpbmZvKTsNCj4+Pj4gKyAgICB2dGRfaW9tbXVfdW5sb2NrKHMp
Ow0KPj4+PiArDQo+Pj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRfYXNfd2l0
aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+Pj4gKyAgICAgICAgaWYgKCF2dGRfZGV2X3RvX2NvbnRl
eHRfZW50cnkocywgcGNpX2J1c19udW0odnRkX2FzLT5idXMpLA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfYXMtPmRldmZuLCAmY2UpICYmDQo+Pj4+ICsg
ICAgICAgICAgICBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRfYXMt
PnBhc2lkKSkgew0KPj4+PiArICAgICAgICAgICAgdWludDMyX3QgcmlkMnBhc2lkID0gVlREX0NF
X0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+Pj4gKw0KPj4+PiArICAgICAgICAgICAgaWYgKCh2dGRf
YXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSByaWQycGFzaWQpICYmDQo+Pj4+
ICsgICAgICAgICAgICAgICAgdnRkX2FzLT5wYXNpZCAhPSBwYXNpZCkgew0KPj4+PiArICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiArICAgICAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICsg
ICAgICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+PiArICAgICAgICAgICAg
ICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3N5bmModnRkX2FzKTsNCj4+Pj4gKyAgICAgICAgICAgIH0N
Cj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArICAgIH0NCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3Rh
dGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52X2Rl
c2MpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgdWludDE2X3QgZG9tYWluX2lkOw0KPj4+PiArICAgIHVp
bnQzMl90IHBhc2lkOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKChpbnZfZGVzYy0+dmFsWzBdICYg
VlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDApIHx8DQo+Pj4+ICsgICAgICAgIChpbnZfZGVz
Yy0+dmFsWzFdICYgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEpKSB7DQo+Pj4+ICsgICAg
ICAgIGVycm9yX3JlcG9ydF9vbmNlKCJub24temVyby1maWVsZC1pbi1waW90bGJfaW52X2Rlc2Mg
aGk6IDB4JSINCj4+PiBQUkl4NjQNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIg
UFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj4+PiBUaGlzIGVy
cm9yIGlzIG5vdCBmb3JtYXR0ZWQgYXMgdGhlIG90aGVyIHNpbWlsYXIgbWVzc2FnZXMgd2UgcHJp
bnQgd2hlbg0KPj4+IHJlc2VydmVkIGJpdHMgYXJlIG5vbi16ZXJvLg0KPj4+IEhlcmUgaXMgd2hh
dCB3ZSd2ZSBkb25lIGluIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2M6DQo+PiBTdXJlLCB3aWxsIGNo
YW5nZSBhcyBiZWxvdywNCj4+DQo+Pj4gICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBp
bnZhbGlkIGlvdGxiIGludiBkZXNjOiBoaT0weCUiUFJJeDY0DQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIiwgbG89MHglIlBSSXg2NCIgKHJlc2VydmVkIGJpdHMgdW56ZXJvKSIsDQo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT5oaSwgaW52
X2Rlc2MtPmxvKTsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiArICAgIH0NCj4+
Pj4gKw0KPj4+PiArICAgIGRvbWFpbl9pZCA9IFZURF9JTlZfREVTQ19QSU9UTEJfRElEKGludl9k
ZXNjLT52YWxbMF0pOw0KPj4+PiArICAgIHBhc2lkID0gVlREX0lOVl9ERVNDX1BJT1RMQl9QQVNJ
RChpbnZfZGVzYy0+dmFsWzBdKTsNCj4+Pj4gKyAgICBzd2l0Y2ggKGludl9kZXNjLT52YWxbMF0g
JiBWVERfSU5WX0RFU0NfSU9UTEJfRykgew0KPj4+IE5vdCBjcml0aWNhbCBidXQgd2h5IGRvbid0
IHdlIGhhdmUgVlREX0lOVl9ERVNDX1BJT1RMQl9HPw0KPj4gV2lsbCBhZGQuDQo+Pg0KPj4+PiAr
ICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQ6DQo+Pj4+ICsgICAgICAg
IHZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShzLCBkb21haW5faWQsIHBhc2lkKTsNCj4+Pj4g
KyAgICAgICAgYnJlYWs7DQo+Pj4+ICsNCj4+Pj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9U
TEJfUFNJX0lOX1BBU0lEOg0KPj4+PiArICAgICAgICBicmVhazsNCj4+Pj4gKw0KPj4+PiArICAg
IGRlZmF1bHQ6DQo+Pj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCJJbnZhbGlkIGdyYW51
bGFyaXR5IGluIFAtSU9UTEIgZGVzYyBoaTogMHglIg0KPj4+IFBSSXg2NA0KPj4+PiArICAgICAg
ICAgICAgICAgICAgIiBsbzogMHglIiBQUkl4NjQsIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNj
LT52YWxbMF0pOw0KPj4+IFNhbWUgY29tbWVudCwgSSB0aGluayB3ZSBzaG91bGQgbWFrZSB0aGUg
bWVzc2FnZXMgY29uc2lzdGVudCBhY3Jvc3MNCj4+PiBkZXNjcmlwdG9yIGhhbmRsZXJzLg0KPj4g
V2hhdCBhYm91dCBiZWxvdzoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4
IDMyOTA3NjE1OTUuLmU3NmZkOWQzNzcgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
Pj4gQEAgLTQ3OSw5ICs0NzksMTAgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRl
c2M7DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQgICgyVUxM
IDw8IDQpDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQgICgz
VUxMIDw8IDQpDQo+Pg0KPj4gKy8qIE1hc2tzIGZvciBJT1RMQiBJbnZhbGlkYXRlIERlc2NyaXB0
b3IgKi8NCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9HICAgICAgICAgICAgICAoM1VM
TCA8PCA0KQ0KPlRoaXMgb25lIGlzIGFscmVhZHkgZGVmaW5lZA0KDQpBaCwgdHlwbywgSSBtZWFu
Og0KKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9HICAgICAgICAgICAgICAoM1VMTCA8PCA0
KQ0KDQpUaGFua3MNClpoZW56aG9uZw0K

