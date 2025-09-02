Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD2FCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 02:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utGVO-0004Sl-FB; Mon, 01 Sep 2025 22:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utGVL-0004RI-Q0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:12:15 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1utGVI-0001tc-MR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 22:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756779132; x=1788315132;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9Sbe1e2BO/BOQwCMolSHuRiYoDZmNeIIIruwkVqrk8I=;
 b=WPrxYNuqXawV13487oxSCI79KL7K9IscEUUJ56FjH9CTKuIZJp2ub4Al
 E7Jw+hcx0oFvC5yT0JN7tAbV9W9aGatRbClSEgwYAYJa3DFgscWK+T6tb
 97FnwQ63lLREBRz1GRtcNTB063N08N9Db0P+z3MvP+rhB4SaOMdUrH03A
 DgZRO2NfkZUvWCEC9xiT6ThnR0pRXIGaZMa+2PFGPLRC5EBsynJUKbaT/
 jjuMKup+Nnuhx+572VYmJrwmDsD1cHWBK66KhGoh2IuIV6eum80NDDv29
 xqi9CyEM0mUGaMF5DRzw0DbCPqRaMYWI1vu4k/TRAzM51dS+GkRMtkg4a A==;
X-CSE-ConnectionGUID: CW4pkfrCSnefgwjJ3WC15g==
X-CSE-MsgGUID: X2+0DdhtR8mmFlRuMMUaCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69740048"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="69740048"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 19:12:09 -0700
X-CSE-ConnectionGUID: QeNA2l5wQZq1volvEr6bug==
X-CSE-MsgGUID: J63g+IRFRS2knxcg8yARPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="170700656"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 19:12:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 19:12:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 19:12:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 19:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHkyRrYrZsjvDrfV0kKNFMfdYt7d+YQuho3i+048rBXHdWBukIuZJJ39Nis4UcLh1XUSGJ04aV3SRBQvEp6ipWTFvJf+bbvZVTeXD8MAM3mkmoYmZoRlaQAjkfGG8a+SPIrK5KLim3LlJ65ZvM4WCwjjHRUPvKFCfaInKUiyOxGJunMySA+IVDmCAcJ9zsfsQGu4rertv2QAbyCRYBqtFmVEtRex0lmhdz7NXByACDp0GNazW4aX74ltlksaxr5RJqTtkOPXhgJETF69abLuoN2CxRjU9e5wiACVSl5fN+vZesvkhOKarRWIIHaXkUW6cWHTY6qXXhL0mUhy3WO7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Sbe1e2BO/BOQwCMolSHuRiYoDZmNeIIIruwkVqrk8I=;
 b=bM3EhDlD0TpH27GdVQ7T9rA2O8d53Ujthh4+OtDqoN/Kd5/vSSBF39tafN5M8w8pIcnxhUxDEGrZU03gctbEALhxe87KERHfpiU6ymq0cS1FJowiZQzVrL/MHZOfapH+s+0onP+0cgqhq+bvssFLpZnjhBoWVxj/KBGI0JG1yMfsHjKMGOMSD+CnoAMmyYc9C91bP1I3gakdS8tea39yLV2uAn1pPYwINR4HnR3fnbLWSovWJh6cCi2Zj5SC28HXtnBhhqg/bTP5ellkpQ5RPqHvClclV3n/27KllP5896jQ/NSwc1TLoA+hEbr5eE04FevshKxZQW2+nigVf9WF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Tue, 2 Sep
 2025 02:12:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 02:12:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Thread-Topic: [PATCH v5 04/21] vfio: Introduce helper
 vfio_pci_from_vfio_device()
Thread-Index: AQHcEy/YB7cQcg3gL0aN3yJDmSz5FLR+lq4AgACgciA=
Date: Tue, 2 Sep 2025 02:12:06 +0000
Message-ID: <IA3PR11MB9136828EE0C6EE87FC2257669206A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-5-zhenzhong.duan@intel.com>
 <125624f5-824d-4b40-ac8e-38a2dd7ae8ef@redhat.com>
In-Reply-To: <125624f5-824d-4b40-ac8e-38a2dd7ae8ef@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW3PR11MB4619:EE_
x-ms-office365-filtering-correlation-id: 9988610c-c630-48a5-097c-08dde9c61d94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q2x6RjZXVlpQYm9IbXJ1ZXJlTWh3WDM0dE9pbWZHalgvRFRkRURoVjl4TGFa?=
 =?utf-8?B?ZlhvUkRPV2FoMWR1OEtjNjhCME9VdTd0WElYcUNrcWM5RS9JMUY0N1ltemtV?=
 =?utf-8?B?SUVMcjRtY3UzS3V5TVg4SzNudW9nZXA4ZjlvQmxwWmk3K3VRVm9tYW55S2s1?=
 =?utf-8?B?MytNcm9ZT1hOVHp0ZU1DQndCWXZHZHg1RFZHQVEvd3dLKzBDR3plSEVuVkV1?=
 =?utf-8?B?NzI3M1JkYStpUGpabUs1LzRoNC96UEY2MHJobEJrNFoyZ1lOeC9hb0tNWHpU?=
 =?utf-8?B?T2UrK2lIbTVuNytMYkZJRFQ4NktidlJUODZUWFFlemQxc0dBbHIyK0U2dnJ0?=
 =?utf-8?B?bWRWUWcwbVViYzUvRlR3dTBRczNTMkUySnhlZ3k4UGxyRDU2Z0ZtWHlsQkFk?=
 =?utf-8?B?bHJ3M0hRTHJCZEl3QUwyYUxZeHplMStLa3FJUnhHMDJDWVpUVm1YRk4wQzM2?=
 =?utf-8?B?bWhmaU4vbEFaTWZ1VWg1Nzl0RWZwbHUrRkVxU0dtZHUzNFFXNTJFY2ZNWHlS?=
 =?utf-8?B?clBiYys1MGZONUpuOHZ3Y0dHUFhmUFc4OFphVzNvaEtKZSt4ci8razZNeHNZ?=
 =?utf-8?B?WGUxbUNBZi9OQXN2ZDNacVZtRHRvRlZIVjIvc2hrK2JmSWpYVEJTNHNVQ0Z2?=
 =?utf-8?B?bSt1Mmx0YnpOM2RrekpFcGc3TFZ3UnEvZUMxcFZCeWlsa2tLSVZnTlYvMGtx?=
 =?utf-8?B?bGpXRDlkMy8xV2hBeWREeStENHkza1V1aU15ZThTRFZVU1FRM1hhbmRzQlF5?=
 =?utf-8?B?blBEby8vM1Uvd0R4Z3A5YkNRZzk4L0xlZ2JWdzFIVWFGcnJrZXlNdWwxRHUv?=
 =?utf-8?B?OTJscC9WbHprRXpDakpiK3I1S3VOYmR0Sk5LMko2QUl4UVFKTUJSN3V4WTlV?=
 =?utf-8?B?OXhMSHZuUzVGKzBFb21kZVVKKzhObHNlQXovT1BsWVQxeE5yTnovSmRML090?=
 =?utf-8?B?ZEhQM1BRZ1VUeXg1ZVptNW43V01iUkorZjNLaXBucyt6R0ZyN2RjZlZ0bzdh?=
 =?utf-8?B?dWFkS3k3NDFjREx0a2VVQ0I0YUhtMDgzdmRXemJ2RG9pa3hFOE5hZkFCK0Fz?=
 =?utf-8?B?QkJwN3hGNWFPc0cyQ0JuYzZQMUQ3RUUybTZZVko1NnFiejNoZmNWVlAvbjVp?=
 =?utf-8?B?a1pPd2lNc29IaWhyTk9SU1ZUNE5Lb2lrcFpDK2wxbzBDN1RoUzlKZWhUSzJ1?=
 =?utf-8?B?NmJkMkZZQTBRaHFCU1FoR3BNUmIzQ2EzUVNFcjBlZVNCY3BBdHU4eFpWTGE0?=
 =?utf-8?B?aWZvYUVISFB6dmRRSi9qRjVBZm94QmxIVVVZakdjeEVtd2pXM2c2dVh1dU0z?=
 =?utf-8?B?VHoyL3djY05vd0FJTUNzRGxNTEZUWE11WVFaa0RtbENCYzNON1JFWFYzMkxB?=
 =?utf-8?B?QjBtSERHZ3A3QmFGVk5SY1Q3TVBiN1U1ZmpOWXVWc0VGa1ZtYWNvblBhNHBZ?=
 =?utf-8?B?SnR3SmhGTUVodUp6Q1Zzekh3cURSRWQ0NHhKUDliVW1ReWhMQ0dzcnhNeENQ?=
 =?utf-8?B?ZjBzU1Zpc3hYV2QwWldPZ3krUlpaOWZSd3lTN1BZN0VWdHFQQU8vUitIaE8z?=
 =?utf-8?B?TnFUMldNckkyVjhKZHc1WUJBRWtzRFdEek5CME1GTWlBTUd0MHFSTkhkRHR1?=
 =?utf-8?B?L0lSQy9za0t4MFhVUFNLeVI3RFhlMHZuQmQ3eVpyaThKMy9qb2Y3Z3loOXlS?=
 =?utf-8?B?emR0NGxlZW1VK0tTT08ya2xyZGVCbDAzeVVpdGZJVjVZNncza2tNeEZyTmtt?=
 =?utf-8?B?VG5zdS9sZWpoeFJjM0RXdTFRODhURWNReDVDNG5WVjdjWEtrTk5nWFpNcGlY?=
 =?utf-8?B?elNoNmVvbXJFWEZUOGh5d0xicHYrWEhlVVFyUUpTckRwam80Y0N1a1czczhN?=
 =?utf-8?B?OGR0bi9GMjFxek5wNDRZbG5mKytRcVkxRDcxQ0dTdkFZa2RFWDFYTXo1L2dN?=
 =?utf-8?B?amgzYy9VM05EYVVuT2JJQzBxc2owRlp3YytRblhkVEl2TFVPVXJDaDRYbmo5?=
 =?utf-8?Q?RaGjVWG+OpUVyVpK/nBPuZA6scCbeA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytQR3ZkTVhyamhGVWczOGNURUVJeWloaFJFUHNIcnN6azZzVTlveXhwcHRL?=
 =?utf-8?B?M1BtR29vMDFMd3FrSStlSmt0YlFtNHpPcVdFNCsrK3ZiRFY5cWJKTmhXWng0?=
 =?utf-8?B?RXNIb0hHYmppNWp3VFJrcUs3bTBiazdSTlZldmRHQnpNTDd5Y090MUxUNEhk?=
 =?utf-8?B?MUJDVmx2SFNUTnlTVXREN2Ivbkd0czVwV1poVEVpQjZNQk00eWxhdzNzVmxL?=
 =?utf-8?B?R3VKcjFTVkVEMEhVQjVyS1RKNW1oaW5ZSzk0cjhVR3MyVDFMWTFCa0ZQNytN?=
 =?utf-8?B?a1BmbEVrUWh0U0d1Vi9Gb3NvbkxoMFFWREdwNFI2dm5PVEtSSVNjYmVEYkN1?=
 =?utf-8?B?N05HTURHQkFxT011ejM2dlFqdnhwOEF2YVdIRmt6UTlwdFpNQjUzRThGdTg1?=
 =?utf-8?B?Q0ZoMSszVU5IODVOK1pkM2NLOWdYaTRwVDEwcFlYajdzcEx2TkJDbVIzVEFV?=
 =?utf-8?B?VStyclp0Z2RuVUV4RUQzVDhzZlF6OTlnOFA2THY2K1Qxc0xodjVvMCs3RVdy?=
 =?utf-8?B?dUxwOVRYcHd5dnNHeVdWS2h0STVyRVZ2VXJHMHgycXdYNU5jVW1ic2RlVExT?=
 =?utf-8?B?RlRyejNlUDlmZjN2czJDNTY5UVBDYkNNWnJ4TG1mQmNOSjh3NXpjVkc3eFNF?=
 =?utf-8?B?VWNSaGNya1AwbVlUbnc0SjAyOGFNa3Voa0lCMHRCUUc5SWNqbWVQcFBXb0dt?=
 =?utf-8?B?a3F2aFRSYzFhTE1vdTlkKzlGN3U5d2loOStVUDJ6aHpacU9BS0tMMk5HQjla?=
 =?utf-8?B?MkJiNFR1Q2gwSHlEdTN1ZUc3Sks1aTVVMktkejVkWkhjTzh5WVB6d3FLdmxW?=
 =?utf-8?B?V3UydWtPZXhaSTVOUjdaMHlHTHkzQmJ1bUtjbG8zdXZwTy9XZ0dGR2NFVkt4?=
 =?utf-8?B?YkZLWG1ZWDhsVlpUbDBhTTBmTGc1WDR2MVg2cDlFcjFkNWxNYmwydTJLMG5Q?=
 =?utf-8?B?a1lGZFViVjAyRkVlNE9WSTViaGVwZXRKYk94cm8zSU52UWJiVXRwN2RhUnFD?=
 =?utf-8?B?eTdPdnNNMmxOVTdyaVdRNXFIejcxMEllZGRiWmVZVCtBV3FWSjBSUmRSeE1W?=
 =?utf-8?B?b2M4SzhTTEU2ZzFiUVFOeWVHK1hUbTlQNTJ6dWp5YzRrV2Vrb3g3dFgyODJU?=
 =?utf-8?B?Q3BIU3FZTDA3cmhmNC9WM1ZZalRUZEtGU3dwT2FCVmNEVnRrRGQ5K1R5bHpk?=
 =?utf-8?B?cU1teU1kVjA0OVFhY1ZSalFYWUtaL2pWd2pPU1U1Y01mMk5CNmNoaUY2N1d5?=
 =?utf-8?B?ejZ2aXZ2aUVETUFMYXNYb2RFWjYrRVd3VlR0ZXRFYkwrWGlTQVhISGpuMDVO?=
 =?utf-8?B?K1M1NkxOOGNkeGtBbXgwSnJ3KytUbU42R1hKRldkNlorczdNK3NweVRueUZw?=
 =?utf-8?B?eHdWcXMwbkJZME1peURJbWM0aWVXK3RGQ0pwOGRIT0JVTnZmR3VrbXRsaTZV?=
 =?utf-8?B?Qm9ldGplbVdHZkNUcFdWek91bkdTSTBjZXFjODZuay9mQzJoczZyaXFtY2Jx?=
 =?utf-8?B?enZPNlBOKzFFZmJSbVFWYkZFWXZoeVVxeTEyeE4wWWF1SGhuSjFPaUF0bzBz?=
 =?utf-8?B?K2lQUDd4RjJva25EUndHRDFRd3FySjdBNTE5eXNhTUpocXlDVWl0U1h3eDQw?=
 =?utf-8?B?MUtkb3dGNngrR2ZULzNvRGdyd3NJMVpvazNCYTljYmhOdEcreXNkY2pTVnVY?=
 =?utf-8?B?NlFEWW1NTXkwMlpmOVR0UVd2dVJWU1NVRHBDK3ArQTgzblpIRng4SkY3Q2tz?=
 =?utf-8?B?ZURUTktxTTY2RGhEYXpmczkrdkRCN1lZUnFCZjJEMHVOQWRQRHpvRlBRa1ZM?=
 =?utf-8?B?MGo2RlZ0RGFEQWhSTk1NQmQvNUNJUmdTNFlPUTJuNllNblljd1YwV01HZHps?=
 =?utf-8?B?NmlQZC9Hb0VmMGZ6aGZRNzMzOU5pQVVZcUNITFBlRFB4b3ZBek1kaStnR3N4?=
 =?utf-8?B?alVEbUxrdS9CZlFNTm1Pa1lSQktET05tZGNLaWVaSE82YWFqYjdUKzVZeFlV?=
 =?utf-8?B?SWJVMXJ6ZmRIeHRoNVRmZkVQcFk1bFVSUG5mbDR0R2dqZ09nSUJ4T2d6Z1h5?=
 =?utf-8?B?TTErZktkU1pmR2FhNzE3RHAxb3ZaYWpyaU5sN0tIb0FRcHRJSkxzcS9KcjVF?=
 =?utf-8?Q?66tWRVYti2dzDxBHrHAtFcGh2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9988610c-c630-48a5-097c-08dde9c61d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 02:12:06.5361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eHqY++EauyMIUYSoj83ycvZg2oGkMJ3ENvVFyYL6Uau020hH1YVis6FVsit77ksDSBevV0Kv5vTjAQddKnQkwXBkBMgCvng8A9greDvFzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDQv
MjFdIHZmaW86IEludHJvZHVjZSBoZWxwZXINCj52ZmlvX3BjaV9mcm9tX3ZmaW9fZGV2aWNlKCkN
Cj4NCj5aaGVuemhvbmcsDQo+DQo+T24gOC8yMi8yNSAwODo0MCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBJbnRyb2R1Y2UgaGVscGVyIHZmaW9fcGNpX2Zyb21fdmZpb19kZXZpY2UoKSB0byB0
cmFuc2Zvcm0gZnJvbSBWRklPRGV2aWNlDQo+PiB0byBWRklPUENJRGV2aWNlLCBhbHNvIHRvIGhp
ZGUgbG93IGxldmVsIFZGSU9fREVWSUNFX1RZUEVfUENJIHR5cGUNCj5jaGVjay4NCj4+DQo+PiBT
dWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4gTGluazoN
Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwODAxMDIzNTMzLjE0NTg2
NDQtMS16aGVuemhvbmcuDQo+ZHVhbkBpbnRlbC5jb20NCj4+IFsgY2xnOiBBZGRlZCBkb2N1bWVu
dGF0aW9uIF0NCj4+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0
LmNvbT4NCj4NCj5Xb3VsZCB5b3UgbGlrZSBtZSB0byBtZXJnZSB0aGVzZSBWRklPIGNoYW5nZXMg
dXBmcm9udCA/DQo+DQo+VGhleSBkbyBub3Qgc2VlbSB0byBjb25mbGljdCB3aXRoIHRoZSBzZXJp
ZXMgSSBoYXZlIHF1ZXVlZCBmb3IgMTAuMiBzbyBmYXIuDQoNClllcywgSSB0aGluayBpdCdzIGZp
bmUgdG8gcGljayB0aGlzIHBhdGNoIHVwZnJvbnQuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

