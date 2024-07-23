Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650F3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW5s9-0002nT-TF; Mon, 22 Jul 2024 23:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW5s7-0002l2-Se
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:07:28 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW5s4-0005IN-Ke
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721704045; x=1753240045;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ax/QbMIQU5WrxG7kyXkyHnm6C2HIHtNah2Fxo4EM+hI=;
 b=HtdECq+t2qFXjG7+F04nyro70thruuQsTPpN4yQV7oFMRzrJu3JAzLSo
 Z+yc0Reqz1oH5L3KnZ3RrHYN618kGEJBj43GDa6PaWRT4fGAU2HemTfcX
 EXcDAtmfZv+9lMVnD6g1DgnrslWWSXio+tZAUcxiWlaM5QZZc9IQiy9bU
 WWC5XxPEFIYcfzhOhmzbMTyMPPUFIE1eYzxtvInP1CtuhdFUQ2pEGVjLI
 Go83JcqLPfoCo5rjEtLEW7FZpGeP4/QizeRYT9L6oHgsZuR1450X0NBi0
 wyZvkIyYg8YOhtIC6qm9KxwNX3k12hxv1YgrIaHXYJZ5Jt2xDZBVVfn1J Q==;
X-CSE-ConnectionGUID: 5FS20CXSQU6EoWPILte6Aw==
X-CSE-MsgGUID: v+uYTcDGSA6tv/jE/2h/UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19431525"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="19431525"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 20:07:22 -0700
X-CSE-ConnectionGUID: cd3ZSWw4QGKfwyXtWXxaRA==
X-CSE-MsgGUID: qi8N/+HQTnOLxDz405gGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="51787052"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 20:07:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:07:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:07:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 20:07:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 20:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKn8VTWBn2b4ro4vHKTgCfdxFztuBRfxQtMLTBaCLrVRnRmvsEmmDKRHyjJ8Sy2ZR/6Y8910mEDtHCB2yK2Nb1WtnsS3N13Y5o6QYE2sISwvIH3aTrz2KJfbKM+G9F77je4MVYkigTBxjjMk45gT1hInRSI4RSmm47Y8SVIEvuTwxRJEJT2O1bXqXWFO7WQJpAGGr49u+UlzpIpBGMBFlsksrdM1O3s/voOXkEPbFIo1rKCv7lgwbOSe1RQOa/vjSU28hfpVXxKykeXYgPIva2OiOCnmJ3iLALxYuQTljc3Jh78lX0yxOJfvWqQCes6ts482zEC48rTH6xESh8gYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax/QbMIQU5WrxG7kyXkyHnm6C2HIHtNah2Fxo4EM+hI=;
 b=sVAahZsnKMQ9xub0I1c0uDHz8pycSMBM325XNLli3dwws0ySXZpH8aDmVWQlEoL9tTY23tjl+Q7CFrDZcB0Ut8JILo+Tk6YWTh97aYhEV5qOwpc/uGaOtLDI2MvBPCSAIxd2RQm5scrhBxO2T+XDmx3pTy/Yu2Cov9CHZ+CkL7dsTx4GbMmd+OiLi63T9CsynFRrp0lHNUmozy6RabCbcjQQp8iBV8b/mkpILbzOhwnVjihR6PBfXqaQwo8B5FnFgieZUP8C8Wa2B77J+rcHhscVhpza4iu3azv4LuAzdiP0b+QarHLW6YIGrtAE7/yano425hDbDVUeiBJtQDBRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 03:07:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 03:07:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Topic: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Index: AQHa2dTA3KmeNYPbQE2nM4EhLBdlNrICRLsQgAAyHQCAAFb1AIAAASwAgADWa2A=
Date: Tue, 23 Jul 2024 03:07:16 +0000
Message-ID: <SJ0PR11MB67441DD39F393D0D77BAE59592A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-10-joao.m.martins@oracle.com>
 <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <be585d48-00d3-4a43-b242-fa7dd188e392@oracle.com>
 <0ba48105-c129-4221-bfe3-f2c714bc12b2@oracle.com>
 <952e96f2-24e6-4595-92fc-a8abec746c12@oracle.com>
In-Reply-To: <952e96f2-24e6-4595-92fc-a8abec746c12@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB7007:EE_
x-ms-office365-filtering-correlation-id: d96fd639-d990-4f81-c55c-08dcaac48ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFRtU2JDTXRicFZPMU1QZG5BUEc5SWV0TGt6dTBKSGNhTG91dGRxZDUxUUhF?=
 =?utf-8?B?N1JyUnFCaDFPNWJVVzJIa1ZsQjNCWG03S3RwRklyeGZJbTZMQmlqdnMwMERk?=
 =?utf-8?B?UGVhQUhjcnJuZkMxSzhvUHp5RmorUGxmQTZpWTBVcitxbXN6WE1vVjBVMExr?=
 =?utf-8?B?YlB6RHJiU0QrTWswdjFqQmw1eUNNdWEyL0ZHcWxpUnl1aytJTUUyK3ZOUnZU?=
 =?utf-8?B?amVHM2JmMGpBbzlFMTFVSHN1aC9GT0hFU3FUTUdZZnZad1hTQ09VdklYTGY3?=
 =?utf-8?B?YnVuZllBU1lIN1pmSFdqTlpSS2IxRk9aVERlZkl1REt4dzhSeU5mVmlnYlNI?=
 =?utf-8?B?Zk5iT3FRQmlSNW8xOGJkYVpLRTBqTnEzQ0ZPYXBlY1I3ZVF5c1gyN0U5dFBs?=
 =?utf-8?B?OXpCMElaNmIvalA3SzdLMSt2TzgwRnpsdXpDNEt5a3E5eXpkdmI2NS9uZUpV?=
 =?utf-8?B?V0RlclhuNDd6TVVkR2JMTkVUQXVWS3VqK08rQ3o5RzJ6TXN0NmlQUmVmeUhO?=
 =?utf-8?B?TkwwSFZJcUdVK0FpQUJFRmJHem1SbWNEcFg4azZWdkZyZ1FleDNsM2xHbGdH?=
 =?utf-8?B?aGZqYm44d0hNWFRlUWFsYVBSa096OHEyTk9UQmRGNzBlZ2kwd1R0RUcxc1hr?=
 =?utf-8?B?Q0IrTGZacXNsRTlzam5FeEtqWWZuei9IaWVhYWxWcjRMMlRuN1BqejRmY3pD?=
 =?utf-8?B?TG5TWkZ0NUpjanpkODh4RVoxeFVQd1JwdnQzL0xyU1prL1prNld5cmR4aVlV?=
 =?utf-8?B?Y21ITEZGOU1LVUN1S3BNOWNCTm1RUk50dzVlU01TaFN3dlBQM2RDYWdMTEp4?=
 =?utf-8?B?MWRUU3dGaHZIR1QxRWFNejZ5NWQvczc3cSttTGtCc3RSMXlKbzkxUDhJYTVS?=
 =?utf-8?B?MU1ZMDFVTUdQbFluUURHRW9xV0c1dk1ZVUdJbmlVKzdsVTB5Ni81QWJPRHZZ?=
 =?utf-8?B?SlU2dEI1Mm9Ycy9yem1nYVk0UUtqN3Z4TVZUdHV3WEtYOE9wYi9sRmczTG42?=
 =?utf-8?B?bnV5S1hZMXN3Y0hITlM0Y2djSCsxU2J0SjNna0RBbTJCWDBIWnNpQmc2Yytp?=
 =?utf-8?B?SVlVOERjYlNUbGtiMUpLLzE3MzJ4U2F5SEdYYmQyeWd1TEZKcUszMHlBWm04?=
 =?utf-8?B?VUY3dCtvaXROaGx1dStIakRCbzlvbzFWdStzTTZEaGFVZUkydGp1ek81R1c2?=
 =?utf-8?B?U2Q5UlJjUUxxN2g1c1g2b1V1UFB3Q29KU0xCWkttVk9TSU5XZ0FOaTNubjdU?=
 =?utf-8?B?Nm91ZzFyQ2hZanZDckZaK3JBcnJPZ1RNaUUvVDVnempQRWtiS2g3ZVByRXk5?=
 =?utf-8?B?aVJ5bVFJaUVHSEtSajFiZkpBdnIrRUdkTFdzSnZJTWVncWczRHN6V3h5K3pK?=
 =?utf-8?B?dDZQbm5FNUgyOHZrcytVOGpXVFAxMkJKVnZoOHh6aUxlNmR2U3JXVzJ1V2ZS?=
 =?utf-8?B?K1prcUpyd1J5K0ozRXJURTREam51MWl2QnJhOGlGTHRJTytPMnJkcU0zcG8r?=
 =?utf-8?B?eHZreGJidjlkc2Q2aWh1UHg2aW9xejBVN1Y0UjE3OWdBdXBnU3JpTFByenB5?=
 =?utf-8?B?cnRZZlkwMGVEL3k2SXU2STltOXhaM3dWc04vQjhSWmdzVFA1NWFkaGJUb1pj?=
 =?utf-8?B?Z2hvSmpEd1pMZFo3VTVYbi9HOUoxSjBwdWxLNHRFZ1VBcC9yYm13dmFnTUsv?=
 =?utf-8?B?RnpRZm1jelRMNUFCd2ZiRVJ2dFJBUmxna0ZBNExnMXZWaWI1WkgrVXk3MGNx?=
 =?utf-8?B?aUE3RE1icTBtSGRCMVhWTGZxemdmQndmeHdGSFdlSVkvYmtnTEZYanJzcnJV?=
 =?utf-8?B?OXNKL2c2S0o3SVN3dWo5cHFBVWpGYVZKYWVDRll4UzY5TjVOOWlXMXE0WUFw?=
 =?utf-8?B?c0podlhENlpiM2owdit3Y3BYRm5sUlY2QkkrTWJXQ0dkdWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3djT282MC9Ybm40SVdmcXgxR1dnYzR5bFN1d2tlTEdiNlh3YW5neGVwVXY3?=
 =?utf-8?B?VlExQ1VKeEduaEd2Z3lLekF4bHNTOE1ROTZ6am92OURVNmZqMG5OWVkyL0sx?=
 =?utf-8?B?Q0N6SnpDQ25XRmNXa2hJZEpQb09DRDMzdis1TFpqWTRyNEx3Vy9YZHY2WTlW?=
 =?utf-8?B?Sy9BTWlxQkZRa2N1TU9xYnFrYWptemNvMTJBUEZVdHRISmkwTDR6d3R4cGpJ?=
 =?utf-8?B?MFBkQmZwUURRVXBsUHFDUVhvUFlIYStyenpJNVVtMTRCWVgwUEtOQXFQM2Ux?=
 =?utf-8?B?UStyblpFanlORjlxTHFTN091dDFKTSs2ejlQL0ZZSTR5dktQSDR3NnFuQTlI?=
 =?utf-8?B?QU1TUzVLdmtObkYvSTZCMGQ5dEpVNGFmUXdEZ3JrL3FYdlh5VmtJSERTVzZi?=
 =?utf-8?B?Z3FaSm5oRG5sR2xmdEtxd1AzaFhCNERXSHIwdmxNZi9pSG5rRy8vaklNWGdX?=
 =?utf-8?B?SHZEQzV6TTZ1RmwyWEIrYmZ3aE1BWWpNS1Qwc0R5UVJXVjVIU0JnL1l4aU90?=
 =?utf-8?B?bktvaW9MNngrMDk1cnlMR1JnRzZoUzNxSUNxSHQwU3htd0VvQ25raGZvelV3?=
 =?utf-8?B?THhKazFuMys1c01WYitnaGlYOXZIMW1OdDRRVEpMb3lHVzZwcGJTajZWMW80?=
 =?utf-8?B?WE1SWkRXUzVXa1JFd0diVlRkcXc3Y00yK2liNDhrRER3VzJEZzZ1d2h4VTFY?=
 =?utf-8?B?bFhhakFJSmxxaDhacVRyOEpJTXRjckpick94Q1hqTGladDR4NnVJUmplNVo2?=
 =?utf-8?B?dnZ0MllhK3JZTzdPZWlmeWV6NzB2MkZMYnphMmhzMnRKWE9UZUxibFFkOHBC?=
 =?utf-8?B?bjFJZ21zOXBhLzMwdXVVTVZQQzZLQ2JQTWNpSXZvNGpVcTJpeG5IVTNjd0cy?=
 =?utf-8?B?UU9GaXo2UTV0aWozY3RTVHRrd3ZJdUxCS3l6cGF1RGtSQ0JHWGk0V0xXYjZS?=
 =?utf-8?B?SXFBQjVWUkNZdCt1YUNwZ1ROdFpMS2poWFcxT0drOTFPczM0bVdRaE00Z0NK?=
 =?utf-8?B?cTdCR3p1aXZ1dFVYaFA1dDlxbkNiRExGSFZRcDlHMUdYNkNmeXhXeTlFRy9z?=
 =?utf-8?B?TjlaNEVuaTJGVGZha1Z4Mm5hZlhyaUU5eVhaL2ZtZ0szZW5DanlVc0luZU13?=
 =?utf-8?B?aTdGY1lhR0lHZG5lb2Y2V00zYm1oK29WZUcwODBYWllLTUc0RHY3aWwrT1Zs?=
 =?utf-8?B?QnBCR29IaFVMYmpOazR6Z1ZtZXd5NG9VaFJ6V0tmRDFlTWh4MXk0dnlPelhX?=
 =?utf-8?B?bDhKQXVjbThaMzlVdXlUV2p6RmpSaDlDYXZlY0VyY1BuUEVVcEpRK1lnRmhx?=
 =?utf-8?B?b3dmRElrMXBMYVpQSmt0OTdiTTgyM3Q2TzU0REEwT0lsdW1WS09GZm1lbmxS?=
 =?utf-8?B?eGxYNWRCMkRvejdueU56MFdNRjl3UlNSeC9ReVF1bXp5V3JBUTJ0M2prT1BU?=
 =?utf-8?B?OXoxT3lPYU5MMzVPMTdkN0srMGVTcFZmeDg0aTc3dGdXTnQzUDNsblpxZDdE?=
 =?utf-8?B?QlNlSkRIbEQ2RFZCVlF3dGc4YkZuTEN4azdjSzF3OWlMOWpxWmtpMFNNSFpQ?=
 =?utf-8?B?TWVYVXlITjlsZko4SG5SZGVVbEhOR2dKZ3RPNnVrQkRoK2lZTGFMQXRsSHZE?=
 =?utf-8?B?eU83Qm1SbnZ6NDNFTHVITU5QYzc4Y21wd2ZWR2pnNUxleE1jL0U4R1QxU25h?=
 =?utf-8?B?b3RYOUF1QmZ6NEZSaE5BS3BZcU4rU1dtVytka1ZoVGhYdFN2V3hUb3NHMkh3?=
 =?utf-8?B?d2lqRGFnaHlmRTRiVjZ5Sm5Nczh6YmFORG5DdUt0MkVmN1JiaUppbDViVEdy?=
 =?utf-8?B?bzBMQVBlS1lCNTNPeldLejBLQ2xPcWNZMTNpbWxPaGNBekxPOXY2U1ozTUZq?=
 =?utf-8?B?MnAweGx4RC9EdDF0c1ZwNGFaRXNUOGM2WnhBWVArWFBqS2VtL2xHYzlLL1Zr?=
 =?utf-8?B?OWpTSW0wdEVOZGxsR0pBaE1OQ1p6OU5iQXR4YSs3WElNTnBhMGYrd1RKL3Fw?=
 =?utf-8?B?MmFkcFZuM0pRRDg0ZktEaTIxdUhCNjVsQ3hIcGZkcmp2Q3o5V1ZUc0xqWkla?=
 =?utf-8?B?MWNuWUdkaTk2OFBma01WZm1RNHdvdk9JdXFwdnRTdTd3ZEdwSm5EZkxqcWMv?=
 =?utf-8?Q?9VnblKU9JfkWuCxVVLQl/Lw0f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96fd639-d990-4f81-c55c-08dcaac48ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 03:07:16.8091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/B+03pf6UpKGUukDnDd7y4I8lw6ZbacNzod3GX/+YA5PfviRMB+eV/omebLUIcPfqOhdD2ET6BJ5+nUyLiq/rzvRfeOKMhqAkz9H9jemPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDA5LzEzXSB2
ZmlvL2lvbW11ZmQ6IFByb2JlIGFuZCByZXF1ZXN0IGh3cHQgZGlydHkNCj50cmFja2luZyBjYXBh
YmlsaXR5DQo+DQo+T24gMjIvMDcvMjAyNCAxNTowOSwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4g
T24gMjIvMDcvMjAyNCAwOTo1OCwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4+IE9uIDIyLzA3LzIw
MjQgMDc6MDUsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5t
YXJ0aW5zQG9yYWNsZS5jb20+DQo+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjUgMDkvMTNdIHZmaW8v
aW9tbXVmZDogUHJvYmUgYW5kIHJlcXVlc3QgaHdwdA0KPmRpcnR5DQo+Pj4+PiB0cmFja2luZyBj
YXBhYmlsaXR5DQo+Pj4+Pg0KPj4+Pj4gSW4gcHJlcGFyYXRpb24gdG8gdXNpbmcgdGhlIGRpcnR5
IHRyYWNraW5nIFVBUEksIHByb2JlIHdoZXRoZXIgdGhlDQo+SU9NTVUNCj4+Pj4+IHN1cHBvcnRz
IGRpcnR5IHRyYWNraW5nLiBUaGlzIGlzIGRvbmUgdmlhIHRoZSBkYXRhIHN0b3JlZCBpbg0KPj4+
Pj4gaGlvZDo6Y2Fwczo6aHdfY2FwcyBpbml0aWFsaXplZCBmcm9tIEdFVF9IV19JTkZPLg0KPj4+
Pj4NCj4+Pj4+IFFlbXUgZG9lc24ndCBrbm93IGlmIFZGIGRpcnR5IHRyYWNraW5nIGlzIHN1cHBv
cnRlZCB3aGVuIGFsbG9jYXRpbmcNCj4+Pj4+IGhhcmR3YXJlIHBhZ2V0YWJsZSBpbiBpb21tdWZk
X2NkZXZfYXV0b2RvbWFpbnNfZ2V0KCkuIFRoaXMgaXMNCj5iZWNhdXNlDQo+Pj4+PiBWRklPRGV2
aWNlIG1pZ3JhdGlvbiBzdGF0ZSBoYXNuJ3QgYmVlbiBpbml0aWFsaXplZCAqeWV0KiBoZW5jZSBp
dCBjYW4ndA0KPnBpY2sNCj4+Pj4+IGJldHdlZW4gVkYgZGlydHkgdHJhY2tpbmcgdnMgSU9NTVUg
ZGlydHkgdHJhY2tpbmcuIFNvLCBpZiBJT01NVQ0KPnN1cHBvcnRzDQo+Pj4+PiBkaXJ0eSB0cmFj
a2luZyBpdCBhbHdheXMgY3JlYXRlcyBIV1BUcyB3aXRoDQo+Pj4+PiBJT01NVV9IV1BUX0FMTE9D
X0RJUlRZX1RSQUNLSU5HDQo+Pj4+PiBldmVuIGlmIGxhdGVyIG9uIFZGSU9NaWdyYXRpb24gZGVj
aWRlcyB0byB1c2UgVkYgZGlydHkgdHJhY2tpbmcgaW5zdGVhZC4NCj4+Pj4NCj4+Pj4gSSB0aG91
Z2h0IHRoZXJlIGlzIG5vIG92ZXJoZWFkIGZvciBIV1BUIHdpdGgNCj5JT01NVV9IV1BUX0FMTE9D
X0RJUlRZX1RSQUNLSU5HIHZzLiBIV1BUIHdpdGhvdXQNCj5JT01NVV9IV1BUX0FMTE9DX0RJUlRZ
X1RSQUNLSU5HIGlmIHdlIGRvbid0IGVuYWJsZSBkaXJ0eSB0cmFja2luZy4NCj5SaWdodD8NCj4+
Pj4NCj4+Pg0KPj4+IENvcnJlY3QuDQo+Pj4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBK
b2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+
IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgIDEgKw0KPj4+Pj4gaHcvdmZpby9pb21t
dWZkLmMgICAgICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAyIGZpbGVz
IGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj4+Pj4+
IGNvbW1vbi5oDQo+Pj4+PiBpbmRleCA0ZTQ0YjI2ZDNjNDUuLjdlNTMwYzc4NjlkYyAxMDA2NDQN
Cj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4+PiArKysgYi9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+Pj4gQEAgLTk3LDYgKzk3LDcgQEAgdHlw
ZWRlZiBzdHJ1Y3QgSU9NTVVGREJhY2tlbmQNCj5JT01NVUZEQmFja2VuZDsNCj4+Pj4+DQo+Pj4+
PiB0eXBlZGVmIHN0cnVjdCBWRklPSU9BU0h3cHQgew0KPj4+Pj4gICAgIHVpbnQzMl90IGh3cHRf
aWQ7DQo+Pj4+PiArICAgIHVpbnQzMl90IGh3cHRfZmxhZ3M7DQo+Pj4+PiAgICAgUUxJU1RfSEVB
RCgsIFZGSU9EZXZpY2UpIGRldmljZV9saXN0Ow0KPj4+Pj4gICAgIFFMSVNUX0VOVFJZKFZGSU9J
T0FTSHdwdCkgbmV4dDsNCj4+Pj4+IH0gVkZJT0lPQVNId3B0Ow0KPj4+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+Pj4+IGluZGV4IGJiNDRk
OTQ4YzczNS4uMmU1YzIwN2JiY2EwIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcvdmZpby9pb21tdWZk
LmMNCj4+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+PiBAQCAtMTEwLDYgKzExMCwx
MSBAQCBzdGF0aWMgdm9pZA0KPj4+Pj4gaW9tbXVmZF9jZGV2X3VuYmluZF9hbmRfZGlzY29ubmVj
dChWRklPRGV2aWNlICp2YmFzZWRldikNCj4+Pj4+ICAgICBpb21tdWZkX2JhY2tlbmRfZGlzY29u
bmVjdCh2YmFzZWRldi0+aW9tbXVmZCk7DQo+Pj4+PiB9DQo+Pj4+Pg0KPj4+Pj4gK3N0YXRpYyBi
b29sIGlvbW11ZmRfaHdwdF9kaXJ0eV90cmFja2luZyhWRklPSU9BU0h3cHQgKmh3cHQpDQo+Pj4+
PiArew0KPj4+Pj4gKyAgICByZXR1cm4gaHdwdCAmJiBod3B0LT5od3B0X2ZsYWdzICYNCj4+Pj4+
IElPTU1VX0hXUFRfQUxMT0NfRElSVFlfVFJBQ0tJTkc7DQo+Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+
Pj4gc3RhdGljIGludCBpb21tdWZkX2NkZXZfZ2V0ZmQoY29uc3QgY2hhciAqc3lzZnNfcGF0aCwg
RXJyb3IgKiplcnJwKQ0KPj4+Pj4gew0KPj4+Pj4gICAgIEVSUlBfR1VBUkQoKTsNCj4+Pj4+IEBA
IC0yNDYsNiArMjUxLDE3IEBAIHN0YXRpYyBib29sDQo+Pj4+PiBpb21tdWZkX2NkZXZfYXV0b2Rv
bWFpbnNfZ2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+Pj4gICAgICAgICB9DQo+Pj4+PiAg
ICAgfQ0KPj4+Pj4NCj4+Pj4+ICsgICAgLyoNCj4+Pj4+ICsgICAgICogVGhpcyBpcyBxdWl0ZSBl
YXJseSBhbmQgVkZJTyBNaWdyYXRpb24gc3RhdGUgaXNuJ3QgeWV0IGZ1bGx5DQo+Pj4+PiArICAg
ICAqIGluaXRpYWxpemVkLCB0aHVzIHJlbHkgb25seSBvbiBJT01NVSBoYXJkd2FyZSBjYXBhYmls
aXRpZXMgYXMgdG8NCj4+Pj4+ICsgICAgICogd2hldGhlciBJT01NVSBkaXJ0eSB0cmFja2luZyBp
cyBnb2luZyB0byBiZSByZXF1ZXN0ZWQuIExhdGVyDQo+Pj4+PiArICAgICAqIHZmaW9fbWlncmF0
aW9uX3JlYWxpemUoKSBtYXkgZGVjaWRlIHRvIHVzZSBWRiBkaXJ0eSB0cmFja2luZw0KPj4+Pj4g
KyAgICAgKiBpbnN0ZWFkLg0KPj4+Pj4gKyAgICAgKi8NCj4+Pj4+ICsgICAgaWYgKHZiYXNlZGV2
LT5oaW9kLT5jYXBzLmh3X2NhcHMgJg0KPj4+Pj4gSU9NTVVfSFdfQ0FQX0RJUlRZX1RSQUNLSU5H
KSB7DQo+Pj4+DQo+Pj4+IExvb2tzIHRoZXJlIGlzIHN0aWxsIHJlZmVyZW5jZSB0byBod19jYXBz
LCB0aGVuIHdvdWxkIHN1Z2dlc3QgdG8gYnJpbmcNCj5iYWNrIHRoZSBORVcgQ0FQLg0KPj4+Pg0K
Pj4+IEFoLCBidXQgYmVsb3cgaGVscGVyIGlzIGNoZWNraW5nIGZvciBHRVRfSFdfSU5GTyBzdHVm
ZiwgYW5kIG5vdCBod3B0DQo+ZmxhZ3MNCj4+PiBnaXZlbiB0aGF0IHdlIGhhdmVuJ3QgYWxsb2Nh
dGVkIGEgaHdwdCB5ZXQuDQo+Pj4NCj4+PiBXaGlsZSBJIGNvdWxkIHBsYWNlIHRoaXMgY2hlY2sg
aW50byBhIGhlbHBlciBpdCB3b3VsZCBvbmx5IGhhdmUgYW4gdXNlci4gSQ0KPndpbGwNCj4+PiBu
ZWVkIGJlbG93IGhlbHBlciBpb21tdWZkX2h3cHRfZGlydHlfdHJhY2tpbmcoKSBpbiBhbm90aGVy
IHBhdGNoLCBzbw0KPnRoaXMgaXMgYQ0KPj4+IGJpdCBvZiBhIG9uZSBvZmYgY2hlY2sgb25seSAo
dW5sZXNzIHdlIHdhbnQgYSBuZXcgaGVscGVyIGZvciBjb3NtZXRpYw0KPnB1cnBvc2VzKQ0KPj4+
DQo+Pj4+PiArICAgICAgICBmbGFncyA9IElPTU1VX0hXUFRfQUxMT0NfRElSVFlfVFJBQ0tJTkc7
DQo+Pj4+PiArICAgIH0NCj4+Pj4+ICsNCj4+Pj4+ICAgICBpZiAoIWlvbW11ZmRfYmFja2VuZF9h
bGxvY19od3B0KGlvbW11ZmQsIHZiYXNlZGV2LT5kZXZpZCwNCj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRhaW5lci0+aW9hc19pZCwgZmxhZ3MsDQo+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9IV1BUX0RBVEFfTk9ORSwg
MCwgTlVMTCwNCj4+Pj4+IEBAIC0yNTUsNiArMjcxLDcgQEAgc3RhdGljIGJvb2wNCj4+Pj4+IGlv
bW11ZmRfY2Rldl9hdXRvZG9tYWluc19nZXQoVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4+Pg0K
Pj4+Pj4gICAgIGh3cHQgPSBnX21hbGxvYzAoc2l6ZW9mKCpod3B0KSk7DQo+Pj4+PiAgICAgaHdw
dC0+aHdwdF9pZCA9IGh3cHRfaWQ7DQo+Pj4+PiArICAgIGh3cHQtPmh3cHRfZmxhZ3MgPSBmbGFn
czsNCj4+Pj4+ICAgICBRTElTVF9JTklUKCZod3B0LT5kZXZpY2VfbGlzdCk7DQo+Pj4+Pg0KPj4+
Pj4gICAgIHJldCA9IGlvbW11ZmRfY2Rldl9hdHRhY2hfaW9hc19od3B0KHZiYXNlZGV2LCBod3B0
LT5od3B0X2lkLA0KPmVycnApOw0KPj4+Pj4gQEAgLTI2Nyw2ICsyODQsOCBAQCBzdGF0aWMgYm9v
bA0KPj4+Pj4gaW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklPRGV2aWNlICp2YmFzZWRl
diwNCj4+Pj4+ICAgICB2YmFzZWRldi0+aHdwdCA9IGh3cHQ7DQo+Pj4+PiAgICAgUUxJU1RfSU5T
RVJUX0hFQUQoJmh3cHQtPmRldmljZV9saXN0LCB2YmFzZWRldiwgaHdwdF9uZXh0KTsNCj4+Pj4+
ICAgICBRTElTVF9JTlNFUlRfSEVBRCgmY29udGFpbmVyLT5od3B0X2xpc3QsIGh3cHQsIG5leHQp
Ow0KPj4+Pj4gKyAgICBjb250YWluZXItPmJjb250YWluZXIuZGlydHlfcGFnZXNfc3VwcG9ydGVk
IHw9DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVmZF9od3B0X2Rp
cnR5X3RyYWNraW5nKGh3cHQpOw0KPj4+Pg0KPj4+PiBJZiB0aGVyZSBpcyBhdCBsZWFzdCBvbmUg
aHdwdCB3aXRob3V0IGRpcnR5IHRyYWNraW5nLCBzaG91bGRuJ3Qgd2UgbWFrZQ0KPmJjb250YWlu
ZXIuZGlydHlfcGFnZXNfc3VwcG9ydGVkIGZhbHNlPw0KPj4+Pg0KPj4NCj4+IE1pc3NlZCB0aGlz
IGNvbW1lbnQuIFdlIGNvdWxkIHNldCB0byBmYWxzZSBidXQgdGhlIGdlbmVyaWMgY29udGFpbmVy
DQo+YWJzdHJhY3Rpb24NCj4+IGlzIHV0aWxpemluZyB0aGlzIHRvIGxldCB0aGUgaW9jdGxzKCkg
b2YgdGhlIGluZGl2aWR1YWwgYmFja2VuZCB0byBnbyB0aHJvdWdoIHRvDQo+PiB0aGUgZGVmaW5l
ZCBjYWxsYmFjaywgYW5kIHRoYXQncyB3aHkgSSBzZXQgdG8gdHJ1ZS4NCj4+DQo+TGV0IG1lIHJl
cGhyYXNlLCBJIG1lYW50OiAgIiguLi4pIHV0aWxpemluZyB0aGlzIHRvIGxldCB0aGUgaW5kaXZp
ZHVhbCBiYWNrZW5kDQo+Y29udGFpbmVyIGNhbGxiYWNrcyBvZiBkaXJ0eSB0cmFja2luZyB0byBn
byB0aHJvdWdoLCBhbmQgdGhhdCdzIHdoeSBJIHNldCB0bw0KPnRydWUuIg0KDQpOb3QgcXVpdGUg
Z2V0Lg0KSWYgdGhlcmUgaXMgYXQgbGVhc3Qgb25lIGh3cHQgbm90IHN1cHBvcnRpbmcgZGlydHkg
dHJhY2tpbmcsIHdlIGNhbiBwcmVzdW1lIGFsbCBkaXJ0eSwgbm8gbmVlZCB0byBnbyB0aHJvdWdo
IGluZGl2aWR1YWwgYmFja2VuZCBjYWxsYmFja3M/DQoNCj4NCj4+IEFuZCB0aGF0IGlzIHJlYWxs
eSB0aGUgb25seSBlZmZlY3Qgb2YgdGhpcyBwYXRjaC4gQnkgdGhlIHRpbWUgd2UgcmVhY2ggdG8N
Cj5wYXRjaA0KPj4gMTIgKHdoaWNoIGlzIHdoYXQgcmVhbGx5IGVuYWJsZXMgbGl2ZSBtaWdyYXRp
b24gd2l0aCBJT01NVSBhdXRvbWF0aWNhbGx5KSwNCj50aGUNCj4+IElPTU1VRkQgZGlydHkgdHJh
Y2tpbmcgaXMgb25seSBjYWxsZWQgMSkgd2hlbiBub3Qgb25lIG9mIHRoZSBWRiBkb2Vzbid0DQo+
c3VwcG9ydA0KPj4gZGV2aWNlIGRpcnR5IHRyYWNraW5nIFtvbmx5IGlmIHlvdSdyZSB1c2luZyBJ
T01NVUZEIGJhY2tlbmRdLCBhbmQgZmluYWxseSAyKQ0KPj4gdGhhdCBubyBWRi9tZGV2IGhhcyBh
ZGRlZCB0aGUgbWlncmF0aW9uIGJsb2NrZXIgd2hpY2ggZXNzZW50aWFsbHkgbG9va3MNCj5hdCB0
aGUNCj4+IEhXUFQgZmxhZ3MgKGFzIG9wcG9zZWQgdG8gdGhlIGNvbnRhaW5lciBhdHRyaWJ1dGUp
Lg0KPj4NCj4+IAlKb2FvDQo+Pg0KDQo=

