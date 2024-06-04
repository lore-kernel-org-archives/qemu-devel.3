Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F44C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKBS-0001Hx-Fv; Mon, 03 Jun 2024 22:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKBQ-0001Hf-TX
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:45:56 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKBN-0002eZ-Oo
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 22:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717469153; x=1749005153;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aProL+9vGmS5bsD6B5USdrpShEr+ZEIr0AE2jGqaI34=;
 b=L+kSm+/ZWFxHn9D7o9P6X6hnaEBbMi7y5vn9u2SB7C9lIMFo/pB2jkNx
 XD19y6JP1urArKNiZjT8no1yrns8GOJ95Mqd4b2w9B2DheOr8RdmHgHEy
 LCzwttsbWgVEe5iANXRw0IqJ+BdNJ1mvbrFEbTVlSIx4II+hTvoI2272n
 HXQ9xPv71sA38dez+mGKNirOjMseTK8dOapwVwLEMF3MKm0G4AvuzNC27
 C8Bssp9DTnsu7AXkDsMZA1DUuTLg1JUXll3IJAZAV8o+F+it2tHoOX3Xn
 XIa1toStVBKApbNGdOzx2vDOjSjZia8geA3IXPnctLQSJ8R+WuqO5y0NK A==;
X-CSE-ConnectionGUID: hfd5wWzmSTWwdq0ZCnFRyQ==
X-CSE-MsgGUID: B9ehWwcfTOmPob38olquaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25388407"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="25388407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 19:45:50 -0700
X-CSE-ConnectionGUID: 62OcqWZOQCyqtYP+6HnHZw==
X-CSE-MsgGUID: dNlVWcfiS5m6OVgTUt6jiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="41512054"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 19:45:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:45:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 19:45:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 19:45:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 19:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZdaQhM2cRF0OfQTPKL3r1Tnru4vz9IxUKdAUfM7b6OeY1Ormsw/k5b3FIoghfoQD59LtQuC955lTffuUcVNiwEjNMjiQ11Ttjx7e6fdc/TT6cGRm62eTtdfHVtp0aVkiRfglQtmaTqXHohj1hYnfDAEj/3iU58zC8oNBlXJt5hVtOc9u07p/x82UlnyswWy5naeC4FYZV4Lpt1Gsj9m9eGDl5jlRXpsdUH6/wfB+CmO7i3CUnBIc1TTtJhyYDXIrXjnlfeV42DKmEs2WAgK0Iaqkax6MCeQ2q6Z5Asbx9OqPHnKptrf9g9uMIOt61TmE5Z/F0yX6H+j2AW33QS+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aProL+9vGmS5bsD6B5USdrpShEr+ZEIr0AE2jGqaI34=;
 b=Wx2UDr4QJ+E9e8o0FcXmbk9oNiLiH0pkwq7BxnIwyF+dQivLlwp5D4fy1a6ExOrx+22Lli+7X7OzXAVLrBFSz6zFBSZXg6pLsNufoXgd4ecJwasiyTPMSaiM/k9n/slh/vVtTxMLrkqEaUJO5I3LV7JHG8Crs7UbTDv9Lu1fLqb318DfhF53mqeI9tVyoj/uqZ4VYn53pso0xxfUdeUTOWm7pd3zlyzJYNtZdBANoWtUf5W20EZlnmwFbQKLYp/xkSqvI0zN6VD4EgjFgt+kgWuNbBs+ayD9b5qsZM2B7zziKRByn/CzahWdVhkT8qPjZWypVTxe6v8sdf78qCNwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 02:45:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:45:38 +0000
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
Subject: RE: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX0ydRqw39Gl6EOwkh0framnqrG15eMAgAD/KCA=
Date: Tue, 4 Jun 2024 02:45:38 +0000
Message-ID: <SJ0PR11MB674405457470C87189BE09CA92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-8-zhenzhong.duan@intel.com>
 <1a188365-7101-472d-adfb-89a74dab055b@redhat.com>
In-Reply-To: <1a188365-7101-472d-adfb-89a74dab055b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: 6deea61e-e938-4a7b-840c-08dc84406ae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|7416005|1800799015|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?T0VaTHJSMnJaZGIzK256VHhBU1FnQTJOMzNPRDFqY2RlTjRKbGNSL2Q0cWF5?=
 =?utf-8?B?djFqVUhENjBEdjlBVzk4MTRvNTNuUklrMElnRW9LT0dlRW5QVkJQUW45YnJD?=
 =?utf-8?B?elFheXJOWFh4aHd5alFkS2Z4ZjVYR2NxdTd3b2pkbjBuQlg1cVV2Rnd6dDMy?=
 =?utf-8?B?eGg1bzhKdVJGcHQvbC8rb3JnazBnNDI3WGQwTWlDc3B0cGtiNEYwM1h2OC9l?=
 =?utf-8?B?eG5kaDBoMk5sR3l2WENPRzVSalF1VXhzWmJWdGNPeWVEd0lybVlDM2p0ZjE3?=
 =?utf-8?B?MXRGZ2V0RmZjdzlqdXpyNWh4bDdkbmRxU0pkUUZWL0FETFRic2NCc3FWTVBt?=
 =?utf-8?B?b3JvNndHY25IblVtK09OUmJVWENDNElFTFVUd3FseVVTTXZNMisrZzF5a0NU?=
 =?utf-8?B?Zi82dXd6YVFnYWErSXdMUyt5UC9EdUhMQVVGbEwwWlY4a3M2TWJzeExya1Va?=
 =?utf-8?B?Nm8vQmpYS1lRNW9kYlBOZkl4dHBtYUJjcTBJdFhianBBc3dRcGFER1M5V1Ez?=
 =?utf-8?B?YnBiVWhydzFON2JpcTBpbzJtRjFSWUdXZFNVaE9rTVpGNitiYlYxdkt0REVH?=
 =?utf-8?B?M0FZV2dXUnhqa1hxd05DcXdSS1I3QlRQNHVXVWQzdG9LeXBDNGZ4dkpvSUUz?=
 =?utf-8?B?TGl4MVZqS2V6RE5maE9DbXBVK3VHamp1cFdJdXlCNWp6aysrdlQzaWxGWDJV?=
 =?utf-8?B?R1FQaTNLWjZhR1A2N3FMd21NWm00RzB1TVZpaUt4eXR3MmdZSlpWckRBb3Fp?=
 =?utf-8?B?bnBwMEtseXpYS0RVZ05kZGF3OUZ1ZFlFcGg1NnBnL05VQ2tBVU5FN1lOUGhl?=
 =?utf-8?B?N1lpU3BLRWdKV2ZZZlJ6UXBTWDQvYzFhWllGOGR1dHZMTGw3bGlwNXhKYUY1?=
 =?utf-8?B?b29xWWRlTmlvS2JTZzVtc2J0cTZ6WDA1V3Bad0RjVHNKWjNnT1o3dExvcktq?=
 =?utf-8?B?dGVrRlcrL2VEeXVCd0dpMDFMMEoyYmpKcXkwLzRiaFpYZEtJelY0OXRvMkt3?=
 =?utf-8?B?L1N5bFNUNmxzdjVMLzkvVnZYMmV1a05MWFQwdjd6ZjVXN1VTbmVMTGdMZllW?=
 =?utf-8?B?RUpNTmJMNDM5eTA1Q0gvZkhOaHkrYU9WQjluOWpUSG92am05dEtHS25HM2Zm?=
 =?utf-8?B?UWM1Z3hNNE1UYnhnSm8vQlFWNXlrY2piUTdrUUM0T0xONVBTb0tKZisxZDY4?=
 =?utf-8?B?dU50QXFHM1pwVGZ4ejg2QU8rTkZlL2wwbVZvZitoQnBOYkNVUm1INFZLNmtQ?=
 =?utf-8?B?aVk5TFVyck85Ymt3NEFoNVhtNVpIVFM5TkhHWU1URVNuRzdVVzE2MGZhM2pO?=
 =?utf-8?B?Mm5DWXVLTFpZRUphMHRnNEhqOUdycHExMWpMc1ZHbWFGWVBtaytxWWpDcDRS?=
 =?utf-8?B?QWNma1dhajlBVlJ4UERiQmUzcDMwUlZ4bFExV2R6M2ZrRW43dndUSFJHcEE5?=
 =?utf-8?B?Z1M0SU9OV0QzUWdoSmNtWlIvV1l1b1ZzMEt2VnVWd0s5RHdQMzc3cnJLYkE3?=
 =?utf-8?B?MW04RGNKcXI0Z3diL3F0VUdVdXMwM0QwMlFTeEZXTjFKcEgwcTl1d09kcTND?=
 =?utf-8?B?QmFrTnpZM0tzUHNKd2pHSGFMc01YWjUzKzJtVDFNMXR3alVmeWlNaDFJMEhP?=
 =?utf-8?B?K3FSbmlSRk1mSmdpLys0SFh2UmI4VVoxWThnSmUyaVZKU0kyeE1xNU5SYlRs?=
 =?utf-8?B?dzlEaWF3YVdPWlplTDZRdTYxOTUzTVVmanVZOWx3QXJFQjRydm94U1ZFSVR1?=
 =?utf-8?B?aHUybWthOU1pdE1paysvdHM3eDlXRjlzYTdyb3J2VlpxS3U3ZXhOeWtHVDBw?=
 =?utf-8?B?czJkVS9OdjJHZ2QyaGZ6Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXQvNkdtY3FYQmFrelh2MWE4VHROeFZFeFRzUFJ3b21FaCtYOEFuWTZzeUoy?=
 =?utf-8?B?NlpVaWxXcE5nUkZncExyeDVoaE14clZVaUFlL0Z1RStwNkQ1YkZRRHNzWDNB?=
 =?utf-8?B?WUQ1UU8zUVkrdGhvdHJnOGxBTlU3UHJTRjNGRlZ3aEZFNWtHZTBzUmtxQnZx?=
 =?utf-8?B?STIwZjBzeXF0K0s5ZmFYZ2VFclZ0SmRKT1dVZVdPaFZmTnNsbk1Yb0FYRW5y?=
 =?utf-8?B?OXp6YXk1cG9aV2dlWkdzMmJmV3hRU0dheVV5ejBEU3hBT1ZlV1lCMmhLdURS?=
 =?utf-8?B?REMwbTB2MW4yaUdQUFBMRGVudVNabExiWGlFRTJQMXBLcGFta1BITlp1c1U1?=
 =?utf-8?B?dUc2dTRHWkdXVG1GMTMyMU5zeFlUUWJLd0FIVTRaN0tobUExT1ZKaXRMTG5n?=
 =?utf-8?B?Z3JSak1GYVF4S2wvQUpCUmJYQUtWcEpRMjN0cWdLZnpCam1YR2NoaEsvV3kv?=
 =?utf-8?B?eUY2VW9UdldKNm1mdlVIUFhJTUM0M0tkVzlQd2xodlBMRUhqbWl0Q2dCVHJJ?=
 =?utf-8?B?d0dQeXRNQllmMTdNTUtNRkgvK1Q5cmU0OEIwbzhXRjRJTFR6NW11R1pPdmRi?=
 =?utf-8?B?azMvUUU3NHQ4ckRoZ1hqK3R1UXVUOWxoa042dzZYdEV6UGMvVVRReVd4TU1F?=
 =?utf-8?B?RzBIbWU5U2x2NHBLMVFqYmdqOEw3dm9VcENQTmFsY1lrdVFZUXF5MUR4VG81?=
 =?utf-8?B?KzhWcUVMcTFqZUFITHVNc0MveDRuUXhwc09SK1dFWnF0QnM0MWpuUGZmN0Jp?=
 =?utf-8?B?QzR5ZnNxL2JPaEdCWGthcGdielRCYnhLaVJpQytkRWl4OXUxVGE0akJ1MGQ2?=
 =?utf-8?B?S1dQc3JWSWRkZlFGRWhwT1BzMDBETExvUXBPeVEzQnVtdWk2alJVVVgydHRB?=
 =?utf-8?B?ekMvNHZSY1JvUjRXREY4Qk5yK2VQenZDN1dXeUsrMlorQnhUVUc3Tk1Gd01k?=
 =?utf-8?B?dEtXUGFtZWRPWUJrUTgzbzZnSDlzbC9CeWN5TWY4UnBLUjduM1R0UEIyV0Z5?=
 =?utf-8?B?M25hb3N3blZUSTR3c3U0RjJXNFNTdm01RDJERE5ZRU1QSDZJZEgyUjA1MUUx?=
 =?utf-8?B?ZGp2YUUyTnRFRVdZV1c0YnpwdlBaYTVES2o0MmQ5ZWZmUDhodzA0STBLcHlV?=
 =?utf-8?B?eHQzNXMxcUNUSUxNWTEreGZpeWNESDhRYUVScy9qYUZtVndOcFhDaHlMZTVZ?=
 =?utf-8?B?VElPZUg0SGJPV2lIdHVoUnhKQXhLZGEycGZHUld5T0pFVEc1ZHo5WndmeVB0?=
 =?utf-8?B?cUdXRk5KakFvellXYlJCc25iaUtpZ2VJT1J0aWZlakd5cXAzSWxrVE53NUVL?=
 =?utf-8?B?eXVHWG9vZDN2UE9rTlJIVzRuTlJ2UEhZKzIzUERLVFZxaUFaVGtIYTJYZFpH?=
 =?utf-8?B?cm5VMGdGWTlTLzVVOUNGeHZEUUJ4d2tpN0ZhZWRDUFY5VGQ2Q0NEM2hJbFpL?=
 =?utf-8?B?ZWJ2NlZ3QUF6TDFOdFBLUm10MFJKV3NpWHpQL243LzJPaSsrL1FscTFDMVcy?=
 =?utf-8?B?azlpODlmQ29TaExneUhZc1JBSkkvSmxKRjdna1pRNEV3N2tIaXFXRGFuTVN2?=
 =?utf-8?B?Z2lCRVE5b3c4RTdEYjR6YWFiZ2dPZTduRHVvNTdKZVVmS09sTVlRSTMzVTF1?=
 =?utf-8?B?QUp5ZDA0YTBmeklLaUlrbUVCSVBJVk5pZnZsVnRpenE0aUdybnBMV085UzZR?=
 =?utf-8?B?TnZ0Y25KSVNMbmxaVVczcGtRdG1PS3EzWHJUb2Jrb0t6bHp4M1M1c3dUcVZK?=
 =?utf-8?B?TnlTbHBrYmk2dlNGTDdFajhRNFllcndSVFlwTytrNDBpMXQ1cEs3S3dTNFdX?=
 =?utf-8?B?WS9aYjRKZDdOU3hvTlI0cExxTmpzSE94a2luTW1LOEVZYUlscVZxL1lTTHJr?=
 =?utf-8?B?cTRET3BtNjZhVUtSZ2NDek52Ulh5WWVNU0h1bnM4d3hGOUJGaTNzWGRBZzNo?=
 =?utf-8?B?eU9sRnBKNm1SK2FJSUtyRnNqR0dpaGVSajRUVkd2SVlzVG9BTkRNZWdYbkFn?=
 =?utf-8?B?VVo0UTZJdDk3MEk2Z3htSTRtSUVzWEZ4K3VLK3RhYUo4YkNEU2VpMG9qOU1j?=
 =?utf-8?B?WWxYVHVGSzltVmc2SUVHampQUi9sRDFKWjZQY0F3bFQ2VmUxcUFCQjJGTmpY?=
 =?utf-8?Q?hVmPW22Cgov0qKUxzMT9oyIcs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deea61e-e938-4a7b-840c-08dc84406ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:45:38.6156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vdArz84qXJqL00uqyRFFwL09dxLV0uh9yR5flpBMiRX3zfop5oMYIdC5yOcNLeeXhXfkcFOxy5WcLE2dqbvqxtLmeSA987GTzIOgewAWNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDcvMTld
IHZmaW8vY29udGFpbmVyOiBJbXBsZW1lbnQNCj5Ib3N0SU9NTVVEZXZpY2VDbGFzczo6cmVhbGl6
ZSgpIGhhbmRsZXINCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gNi8zLzI0IDA4OjEwLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IFV0aWxpemUgcmFuZ2VfZ2V0X2xhc3RfYml0KCkgdG8gZ2V0
IGhvc3QgSU9NTVUgYWRkcmVzcyB3aWR0aCBhbmQNCj4+IHBhY2thZ2UgaXQgaW4gSG9zdElPTU1V
RGV2aWNlQ2FwcyBmb3IgcXVlcnkgd2l0aCAuZ2V0X2NhcCgpLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+
ICBody92ZmlvL2NvbnRhaW5lci5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4gaW5kZXggYzRmY2Ey
ZGZjYS4uNDg4MDBmZTkyZiAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+
ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+IEBAIC0xMTM2LDYgKzExMzYsMzEgQEAgc3Rh
dGljIHZvaWQNCj52ZmlvX2lvbW11X2xlZ2FjeV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFz
cywgdm9pZCAqZGF0YSkNCj4+ICAgICAgdmlvYy0+cGNpX2hvdF9yZXNldCA9IHZmaW9fbGVnYWN5
X3BjaV9ob3RfcmVzZXQ7DQo+PiAgfTsNCj4+DQo+PiArc3RhdGljIGJvb2wgaGlvZF9sZWdhY3lf
dmZpb19yZWFsaXplKEhvc3RJT01NVURldmljZSAqaGlvZCwgdm9pZA0KPipvcGFxdWUsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7
DQo+PiArICAgIFZGSU9EZXZpY2UgKnZkZXYgPSBvcGFxdWU7DQo+PiArICAgIC8qIGlvdmFfcmFu
Z2VzIGlzIGEgc29ydGVkIGxpc3QgKi8NCj4+ICsgICAgR0xpc3QgKmwgPSBnX2xpc3RfbGFzdCh2
ZGV2LT5iY29udGFpbmVyLT5pb3ZhX3Jhbmdlcyk7DQo+PiArDQo+PiArICAgIC8qIE9ubHkgc3Vw
cG9ydCBxdWVyeSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUyB3aXRoDQo+bGVnYWN5IGJh
Y2tlbmQgKi8NCj5JIGRvbid0IGdldCB0aGUgY29tbWVudCBhcyBIT1NUX0lPTU1VX0RFVklDRV9D
QVBfQVdfQklUUyBzdXBwb3J0DQo+c2VlbXMNCj50byBiZSBpbnRyb2R1Y2VkIGluIFtQQVRDSCB2
NiAxMS8xOV0gYmFja2VuZHMvaW9tbXVmZDogSW1wbGVtZW50DQo+SG9zdElPTU1VRGV2aWNlQ2xh
c3M6OmdldF9jYXAoKSBoYW5kbGVyDQoNClNvcnJ5IGFib3V0IG15IHBvb3IgRW5nbGlzaCwgSSBt
ZWFuIGxlZ2FjeSBiYWNrZW5kIG9ubHkgc3VwcG9ydA0KSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0FX
X0JJVFMsIG5vIG90aGVyIGNhcHMuDQpNYXkgYmUgb25seToNCg0KLyogT25seSBzdXBwb3J0IHF1
ZXJ5IEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTICovDQoNCj4+ICsgICAgaWYgKGwpIHsN
Cj4+ICsgICAgICAgIFJhbmdlICpyYW5nZSA9IGwtPmRhdGE7DQo+PiArICAgICAgICBoaW9kLT5j
YXBzLmF3X2JpdHMgPSByYW5nZV9nZXRfbGFzdF9iaXQocmFuZ2UpICsgMTsNCj4+ICsgICAgfSBl
bHNlIHsNCj4+ICsgICAgICAgIGhpb2QtPmNhcHMuYXdfYml0cyA9IDB4ZmY7DQo+d2h5IHRoaXMg
dmFsdWU/DQoNCjB4ZmYgbWVhbnMgbm8gbGltaXRhdGlvbiBvbiBhd19iaXRzIGZyb20gaG9zdCBz
aWRlLiBBd19iaXRzIGNoZWNrDQpzaG91bGQgYWx3YXlzIHBhc3MuIFRoaXMgY291bGQgYmUgYSBj
YXNlIHRoYXQgYW4gb2xkIGtlcm5lbCBkb2Vzbid0DQpzdXBwb3J0IHF1ZXJ5IGlvdmEgcmFuZ2Vz
Lg0KDQpXaWxsIGFkZCBhIGRlZmluZSBsaWtlOg0KDQojZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNF
X0NBUF9BV19CSVRTX01BWCAweGZmDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQg
aGlvZF9sZWdhY3lfdmZpb19jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkN
Cj4+ICt7DQo+PiArICAgIEhvc3RJT01NVURldmljZUNsYXNzICpoaW9jID0gSE9TVF9JT01NVV9E
RVZJQ0VfQ0xBU1Mob2MpOw0KPj4gKw0KPj4gKyAgICBoaW9jLT5yZWFsaXplID0gaGlvZF9sZWdh
Y3lfdmZpb19yZWFsaXplOw0KPj4gK307DQo+PiArDQo+PiAgc3RhdGljIGNvbnN0IFR5cGVJbmZv
IHR5cGVzW10gPSB7DQo+PiAgICAgIHsNCj4+ICAgICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lP
TU1VX0xFR0FDWSwNCj4+IEBAIC0xMTQ0LDYgKzExNjksNyBAQCBzdGF0aWMgY29uc3QgVHlwZUlu
Zm8gdHlwZXNbXSA9IHsNCj4+ICAgICAgfSwgew0KPj4gICAgICAgICAgLm5hbWUgPSBUWVBFX0hP
U1RfSU9NTVVfREVWSUNFX0xFR0FDWV9WRklPLA0KPj4gICAgICAgICAgLnBhcmVudCA9IFRZUEVf
SE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAgICAgICAuY2xhc3NfaW5pdCA9IGhpb2RfbGVnYWN5
X3ZmaW9fY2xhc3NfaW5pdCwNCj4+ICAgICAgfQ0KPj4gIH07DQo+Pg0KPg0KPlRoYW5rcw0KPg0K
PkVyaWMNCg0K

