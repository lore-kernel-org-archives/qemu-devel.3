Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C385DD1CA3D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Dwj-0007kS-97; Tue, 05 Nov 2024 02:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8Dwh-0007kJ-MK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:25:47 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8Dwe-00075O-S8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730791544; x=1762327544;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yvcJHGzuhHOBqX/FDpf473XPWMvgfQBPXf0psvVlRxY=;
 b=RvJzfiEhA/ejaFMDcYx/37b9Kqet+kIL+PXk822EfAz/bUMq350E9QHy
 rlRtipxZS/RSA5WA0O7AsmmYqLw9ESDK0bQE5iZ+UHJWHf/jRQNR4TUM7
 zqmDJirIrwP3TefbxmHBYtCu0WR3AO7nZBegW7mCH5IMGZEtW35ka3T5z
 YOgeOFHWEbcgIIvzyAETcRL+7gpiBkU/L2/6xgqlX04uiEngRHyAMxsAv
 6BwOMR2/WaDrYn0z8o+h528JXsst7ea246AUxHNJLeMcTI3FbGItFXBpk
 uvd7rbpsXkL+c16e4wKyf1fLfyczBXCYrvCfBZMG0NnNhljHTl9hFXXOK A==;
X-CSE-ConnectionGUID: /5s7/sCcQeKmmWAu9wWJmQ==
X-CSE-MsgGUID: XSrnp7MlTrmhNT6hMdGPUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30744861"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="30744861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 23:25:42 -0800
X-CSE-ConnectionGUID: EfsPEhl4RSCz2TBA5ko1Ig==
X-CSE-MsgGUID: fa8CZfu0SLuJvJ3JV7jJYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="84241473"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 23:25:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:25:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 23:25:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 23:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBZbYmwdzlM4yn0/40LWjMCo8+0+mwQfvmllV8oUXzX7qWnsjkzZKFNVdFnrGdW5usD3EOrO6R2G+KWgXhyYaSZ7vuJtIf69d/KstXx5KlDAcGhpBIjRDR7dcLiPk6bTBSQHxIiZS2nb65O9YlPn13jlTUnLUxL6jOBLdhu7iW+MbvsUP65a4o0HPH5u8SvixzLYY1YK0BNzMfu4nzmNRYceSf7UsW7dQYX4q5xRr2uGPGJDxKpuoZXEHen4S33bsYIM/g4VV9GMexvyGN09ND1a49C2W3JrIYH/uUctrdOGX1EQb9WObS9OAGEQoTNlAwCfY4I8nxWEcMg9KDoTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvcJHGzuhHOBqX/FDpf473XPWMvgfQBPXf0psvVlRxY=;
 b=v6whcFpt/Mvb8JpLnUDWgoD9uvw48RnkrYxK5pngQvtn/rXDpPLVJDpn853bbdcvByLzCOa8E1mi564zL+a4aHqpdilEQOGSiiu00ryL0C8PTz+KOyEWj10/feb0PsqkNIfFihuFPkeVB2JNhWPT6A3i0NQw7XaSX1Fq65SkziVv56jJf5iiNQ8n87LejyvYMfbbyyvqyoRPR2tSRH5jcmXZY1eK+EfblzmDUBg774EqPLBL04dVMbJoLp19UL0ua10VJYNNNla8xiMCdsBVsQ1JAieQDl2pBHIy/Zz4LvWEKV3ASxQjRhKB8GSrn5tiH+speRLQahJj1R3rWAjpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:25:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:25:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHbExt/KmB69XpnZUKNIck54DJye7KmpouAgABOO8CAAX0oAIAADIPg
Date: Tue, 5 Nov 2024 07:25:39 +0000
Message-ID: <SJ0PR11MB6744CD9B4B341B0F3787CD8992522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-14-zhenzhong.duan@intel.com>
 <2d2c2515-6a74-4e81-8ab5-0390aa59f6dd@intel.com>
 <SJ0PR11MB6744E7B5833C645A0E17A3F692512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e74b140a-5030-4092-b83d-8e91756c2544@intel.com>
In-Reply-To: <e74b140a-5030-4092-b83d-8e91756c2544@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4948:EE_
x-ms-office365-filtering-correlation-id: b21d3b9f-d769-490f-34cd-08dcfd6b0ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TjFvZE95MFdBY3d3LzlhR1NDa3crSHI3clhPTCtTaGd3Y1V6SzlQYWRtTlVo?=
 =?utf-8?B?ZkdwbEFCZExSVWk3ajFISFUxbWFQRGxtcS92aGlLQk8xSGt0cGpzM2FjK2Ri?=
 =?utf-8?B?UDlHdVVGRmNFVlpOcTdqalV3cXNJMGFiWVZ0VVVTYU1UamJVVFBXT01Jd2xI?=
 =?utf-8?B?UTh6SHhNeUw1Mk9zMEVwRDNTenFIMjZnTU9TNzV1cTZnZFU3T3NuRXlONE10?=
 =?utf-8?B?YVo0TjRjQlo5eUt6aXFZSzJmS3JYZUR6VEg4ZGgvK2cvWkZlRzRaVmowT2JZ?=
 =?utf-8?B?YTJDYkQzbVNtTVV3ZUhEMWRvNmtaNVVtdzB0WDJYNU1FaUt6bkROcmVSbWdL?=
 =?utf-8?B?S1V1eVUxcG5FaHBqcGthZ3VOOWd6YnhWVUE2M0Z2RGdhcTdvc2F5VVZkbkY0?=
 =?utf-8?B?a2tqMnhSMmd1RWZwc21IM0ZCVWxId0FkQjlNbTluaHlZZ05scjRPK3hzSklw?=
 =?utf-8?B?NE12Q3g3aDRVUWFlc1YzK3RuNjJGL2JncWh6dWUzV045dTZUc1Y2TndWcmJB?=
 =?utf-8?B?ZXE0RHBLOTJVSUhFcXI5dE5Ga1FSQlF3SDR6SW1NTDNPNlJHSDJKQkg1OVp0?=
 =?utf-8?B?VFU4bk1TSDNtalBmTlh1a2VMZ2c4UkM0RURrVzVvZ3V4cjNXSmRaZ1RTaTBn?=
 =?utf-8?B?Z2pqVHRLQXd3MUtIaWxvWGFyang3N2loRmtyaHV3R2tqamFPcDA5dmdZR2Zo?=
 =?utf-8?B?aFJPMCtUM3lrOFMvMEQ4d2FFOVdwb3dZK1dQSzJONVZmZ0xnZllQbXRjck9W?=
 =?utf-8?B?Y2FzU2hUMHIyeVZQc2dpUFdIUllFN1RReitZa2J2VktnOXc0MnVVVXdTTTZC?=
 =?utf-8?B?dHFGVEV3SmJiZm9ZcXN6VW5taU51dXE1TVAxRWQrVHk3WERWbVBGckNTQ252?=
 =?utf-8?B?QXduQjAwRmhwVFZ4eHlyazB5M0dMY01TWTdCWTFEOVVySEhxNGI3NGJseUxh?=
 =?utf-8?B?MHVNLzIvbFE1aTZrbjBnQUl1a0pvTDU0SWVVRzdUdVUwemF1OFBCelRPVTM1?=
 =?utf-8?B?QzFZR2ZtYnpQRytHZHMyMW1Oemtaa1J1QmVDNnVVWm9rdWZkQytRcmFsK1l2?=
 =?utf-8?B?YzY4SXdTRVFnSkQrTjYvRmpjS0VZMVNMU1VKOXhQS1dWZEhnYUk4YUdhM2dW?=
 =?utf-8?B?bjZGbm5rVkhVaEhVSmdra1VpS2NpWVNlcmxldnV3eWhOQjRQM2diNDdkOGZz?=
 =?utf-8?B?RnQxc3RqbGNFNEVlSElVT2dMdXJlbnl1VW9YdlAzZlVleStyVnRoNERQaTNM?=
 =?utf-8?B?YTkrSjNaK1hHcTNRSmF6bXMrcExtMitvcCs1QkhlNER5T0xEcXdoTFNJNlJ1?=
 =?utf-8?B?OWx4VFFoZzFxWTFLbUxWRkNMSGRMU1kxQ0VVY3BiVXRXZ09hNmlBMGN3bmlX?=
 =?utf-8?B?djVnTU9uUFEvU2JWRTM2VVpPd25UdUhheDBXL2xEcU5GN2RGckdtbE1BYlpD?=
 =?utf-8?B?cDJPd1IyYVFnVkVCUStSMjBsYUo2Vit2c2l4WCtCVnkvbFBKRVhCMHdtUjFv?=
 =?utf-8?B?S0R5cjlvTzlXd0tnYW1SelcweVJNQ21JaTk4WkgvMllYeW5xR0YrSjdiSkpO?=
 =?utf-8?B?WkI2ZUIrSWhuVlgwRXYvSmptRlNaZWFJeFBqWTc2STFGaXBtUXRCU29xdHVy?=
 =?utf-8?B?V3hQeXp2clhJaEpiVU96OFFRNGIxZE93aldZcHB5V0EyUXRKeDFsd2dpdUdI?=
 =?utf-8?B?Tm50bTdrWjZvWTBrcFh4NFBLT2JhTkc4c0s2eEdVd01CNjkzOUxIaTlyOEgx?=
 =?utf-8?B?M0h0VW5TYVVpeHJRZU56QmVvbFppOWl6dVoyV2pwbVpsNXpjajlBUlQzN21D?=
 =?utf-8?Q?z2vNC6lIW9syZt6Bqvf38KlLhuDr5BkcMv04U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2I3TXhBQXB5UGM4dGEwQ2RYcEIxQ0dZUmcvVHdpMlZFcVBqTTNJMkFQb1Nv?=
 =?utf-8?B?Qk4zMlBqKyttdXlTb3UzektsVVQ5aE9LbUpzVk5oR2xoRmdMeG1iaVFGOUp4?=
 =?utf-8?B?OUd0Nk4xSXV6bmFzNExCSWkyNE85d0M3SG9pMWtHTVQ4QisrejI0aU9qSDRD?=
 =?utf-8?B?RGVDQml6dHMvYWZLandqUXZ2RjMzZ2gvTGRLaDZHY25YL0I0N1E5T3lrdThq?=
 =?utf-8?B?SGdqRGN0Uy9HZnMyMlJzanV2ajc1NFRpVWZZeGVEYVRhTEJ4NGxsdU1RZ3Rn?=
 =?utf-8?B?MSsvYjF5SkRnZldzNFFyTHduRk1kRlpNUHBRYTZEdlFYZ2RjeXFLZUxIRTB1?=
 =?utf-8?B?YjM4aWw4MXlMTm1EdUpFdTYzRWxQQ0pvVTV5SVIzVm10Z1U1dTVNRzZRdlNi?=
 =?utf-8?B?MlcvdmhZck5LVDZUbFJGVGI3Rll4SDY4b0Z5Wkg4U0hOaXBiSitwT250R0dY?=
 =?utf-8?B?S2d0b1BaTnE3dm1pNlFpVlBwdGNIb2YxcTNQeE1VbzRhZ3NUdEtTRnI0ZE9Z?=
 =?utf-8?B?THhBVWZBcjIzQUl4ZlVpQ1BqVHdZUU9aQnpQRGdHVnVCajBvS3ljYXpyZVp3?=
 =?utf-8?B?azQvVjNtNmI4U0tsbHhQVGw4WnorOXhLK3dnOEF4VEljOFFQZXJEQVlvODlC?=
 =?utf-8?B?TnppamxKajN0UmUvOUxXOUU4aDdsT3B1YTVBRnBES3FNQkJvaUxMQUFuYjYx?=
 =?utf-8?B?aWFxb2VzV0Y0MUd4d3ZOcklvdEtaY0JKZ1NpYmJvVDFBbUF6WHdIanlzb0U2?=
 =?utf-8?B?cCtnbGN4Qzg2KytxRE1vRnVldkFJaEhSK04wK05aSkphaitadHVMUEJZKytE?=
 =?utf-8?B?M0FXUUoyQkkyUnpHcGYrL2E4NFFwV2djWTFoUE01bElRak50SXp4UXlmOTlx?=
 =?utf-8?B?U2l4L05lc2hweXNtVnZpR3k2eldCZktLOGN4WVBUa3Z5eThTTTZWdU1DR2FC?=
 =?utf-8?B?MlVPc1BXenNBc002bVpZZGFIa1VrTXJZcjdZcy8zSi9TUzFPOXNZdE9lNFJL?=
 =?utf-8?B?Y3FmZ1BUOHlqNWF0NWlSV1FMNlFLbGx5bDlkMU5ReVRWbTlvTkZoYkR3VnRK?=
 =?utf-8?B?bzBabyszRmJZaGdlRmpkNUFPUzdCT3RXVzZGNEVUV2lsY3JLM2M4M2g2ZDNS?=
 =?utf-8?B?VUFicmNIVE1ocEtHOUhvYXNJYjZacVNYTmRIQ3pxMkFRU2t4bGZkdERWZVBi?=
 =?utf-8?B?NWdzdlE5a2lNMVJUaWVxRmcxZzJIWGJiQVh2aG1wU1UyVmJRUVRLK3ZBMUIr?=
 =?utf-8?B?SUNQUjVDRTZ6SnVKczRBcTlCT3VoTXFJL0xhcFNTUDFzVEZVRmtUN0d4QkR2?=
 =?utf-8?B?RzZYQ1dnc2xnRjNGNHlDdUZCV2dRVW9TUWNkNkZGMy9QTUtreWpvS1lrWDBU?=
 =?utf-8?B?M2pWQUl6N0k0YWgyb092enIyTDBOREE0RVFMQ3hqaVowS0hNUFJuaW1HZ3h1?=
 =?utf-8?B?eGozYmtKdlJydUlPWG42L1V3eHlLZW1LQVI2NTFNWjhqeFVLRFFjVXFTTzR4?=
 =?utf-8?B?MkpBaXgwbndvZnI2K0pHMXRKeEpBUTVkNnNIZkNGbWRPblBRVGdNRlFPSUV1?=
 =?utf-8?B?VkNHeFdpSWJONUd3TGpXQ3liMHowNDAzMTVKcDlPMVlGbGl3d29Zb3IrZWU4?=
 =?utf-8?B?c3h2c21DR2dVRlVDamxqM0w4bUpIa2hxcHZYZ3JCQWZ2ZUd6U0VSbUhnRlRo?=
 =?utf-8?B?Z0M0eE90M082K3FQeERMaTdyR2NtQUlqMDNTUS9RUHlpdGZFQlNTTHA4RW0r?=
 =?utf-8?B?VWpUZUNYTDZ3RlMwRWc1RTFyUU9ZTnhlcUNDOC9pTXdpbDJKT0pNbFNZcWNo?=
 =?utf-8?B?eU1sZ0NiTnYzMEdueWwxL2djNnlZQk81S0w0NlRtdk04L3VEb09hbm1WWUwr?=
 =?utf-8?B?dndpQnhscUFjdEtwMS9idERYVW9LazYrNmF5eVJMRHZlMU1ZNm5LREw2VzJS?=
 =?utf-8?B?SkU1NUpURHVmZUtaOGlhbmpJaDFiNGFRUC9raXFzVTJlMGxScVhsS2p4bXds?=
 =?utf-8?B?QTlzRWFES2FUZGp0R1lWQ0hVd3FYa3VuOGZRVS84N1RTZUl2dGlBZ0I4bVl0?=
 =?utf-8?B?TEFVdWk2VER0cGYxQW9Da0I2UUlMUXBJUDYrdEsrQTVHRXdBelpjdUkwVWNG?=
 =?utf-8?Q?FwKujTV8APJw5Od6Hz87wd444?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21d3b9f-d769-490f-34cd-08dcfd6b0ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 07:25:39.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaoOkOJkf/ef51X3HTi+yxLFlCaT3pHpSaIw1tg13X+aM41LSb8v1gIewkylyxXmlXm+OtrTCMx+74JinItgtokV5bkwlNDSa7iiFa0A28c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgMjozMCBQTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTMvMTddIGludGVsX2lvbW11OiBwaW90bGIgaW52YWxp
ZGF0aW9uIHNob3VsZCBub3RpZnkNCj51bm1hcA0KPg0KPk9uIDIwMjQvMTEvNCAxNjoxNSwgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+PiB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJ
bnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4+Pj4gICAgICAgIGdfaGFz
aF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2dGRfaGFzaF9yZW1vdmVfYnlfcGFnZV9waW90bGIsICZpbmZvKTsN
Cj4+Pj4gICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+Pj4+ICsNCj4+Pj4gKyAgICBRTElT
VF9GT1JFQUNIKHZ0ZF9hcywgJnMtPnZ0ZF9hc193aXRoX25vdGlmaWVycywgbmV4dCkgew0KPj4+
PiArICAgICAgICBpZiAoIXZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2
dGRfYXMtPmJ1cyksDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYNCj4+Pj4gKyAgICAgICAgICAgIGRvbWFpbl9pZCA9PSB2
dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHZ0ZF9hcy0+cGFzaWQpKSB7DQo+Pj4+ICsgICAgICAg
ICAgICB1aW50MzJfdCByaWQycGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4+
PiArICAgICAgICAgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCj4+Pj4gKw0KPj4+PiArICAgICAg
ICAgICAgaWYgKCh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSByaWQy
cGFzaWQpICYmDQo+Pj4+ICsgICAgICAgICAgICAgICAgdnRkX2FzLT5wYXNpZCAhPSBwYXNpZCkg
ew0KPj4+PiArICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+DQo+Pj4gbm90IHF1aXRlIGdl
dCB0aGUgbG9naWMgaGVyZS4gcGF0Y2ggNCBoYXMgYSBzaW1pbGFyIGxvZ2ljLg0KPj4NCj4+IFRo
aXMgY29kZSBtZWFucyB3ZSBuZWVkIHRvIGludmFsaWRhdGUgZGV2aWNlIHRsYiBlaXRoZXIgd2hl
biBwYXNpZCBtYXRjaGVzDQo+YWRkcmVzcyBzcGFjZSdzIHBhc2lkIG9yIHdoZW4gcGFzaWQgbWF0
Y2hlcyByaWQycGFzaWQgaWYgdGhpcyBhZGRyZXNzIHNwYWNlIGhhcw0KPm5vIHBhc2lkLg0KPj4N
Cj4+IFllcywgcGF0Y2g0IG9ubHkgZGVhbCB3aXRoIHN0YWdlLTIsIHdoaWxlIHRoaXMgcGF0Y2gg
ZGVhbCB3aXRoIHN0YWdlLTEuDQo+DQo+dnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnko
KSBoYXMgYSBzaW1pbGFyIGNoZWNrIGFzIHdlbGwuIEJ1dA0KPml0IGNoZWNrcyBQQ0lfTk9fUEFT
SUQgYWdhaW5zdCB0aGUgcGFzaWQgaW5zdGVhZCBvZiB2dGRfcGFzLT5wYXNpZC4NCj5TbyBpdCBs
b29rcyBjb25mdXNpbmcgdG8gbWUuDQoNClllcywgaXQncyBhYm91dCBkaWZmZXJlbmNlIG9mIHBp
b3RsYiBpbnZhbGlkYXRpb24gdnMuIGlvdGxiIGludmFsaWRhdGlvbi4NCg0KdnRkX3Bpb3RsYl9w
YWdlX2ludmFsaWRhdGUoKSBoYXMgYSBwYXJhbWV0ZXIgcGFzaWQgd2hpY2ggY29tZSBmcm9tIHBp
b3RsYg0KaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IgYW5kIHNob3VsZCBuZXZlciBiZSBQQ0lfTk9f
UEFTSUQoLTEpLg0KDQpGb3IgdnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnkoKSwgcGFz
aWQgcGFyYW0gaXMgYWx3YXlzIFBDSV9OT19QQVNJRA0KZm9yIGlvdGxiIEludmFsaWRhdGlvbiwg
cmVhc29uIGlzIGlvdGxiIGludmFsaWRhdGlvbiBkb2Vzbid0IHN1cHBvcnQgcGFzaWQuDQoNCkkg
aGFkIGV2ZXIgdGhvdWdodCBhYm91dCBleHBlbmRpbmcgYW5kIHJldXNpbmcgdnRkX2lvdGxiX3Bh
Z2VfaW52YWxpZGF0ZV9ub3RpZnkoKSBmb3INCnBpb3RsYiBpbnZhbGlkYXRpb24sIGJ1dCBpdCdz
IGNsZWFuZXIgdG8gaGF2ZSBhIHNlcGFyYXRlIGNvZGUgZm9yIHBpb3RsYiBpbnZhbGlkYXRpb24u
DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

