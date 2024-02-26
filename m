Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E08C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUIk-0005Ae-QN; Mon, 26 Feb 2024 01:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUIj-0005AH-MA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:17:21 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUIg-0006de-Td
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708928239; x=1740464239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=siVd7eKC5IldXIrbDcj2lVOnUKSLcmlfM6gql2iC9RU=;
 b=MW4sJfCHNqNzUsiq9hBfES39ROMS2PwyTVQ2rcPE4P3wxJSK3MLlatrt
 a1d8Hxwuaa9hWHMm+2DHTRu3pUNVjxKsH2hOwg9Ifuqsv/aCi+QfKtwTw
 ly40vUEiXquF9rOhBwnafzzUJWYHIyReXGoUL8CavkQ9jSZYehsY0is35
 EIYqZ2gsC2cdrdN1UnR2dWGax9S8wGULqv2BVUZAtWGEjjNOYdTZy/LFy
 NMXdmt+q/FCLb6q8ZARPCtEuVF15uNzT1PS6uyvKFF/nUA90q5j/rH/7d
 XEzrxoWk9IGRBMdF/yQ77//ZBhy9YnTnX2+Ip/FsUVMAEelvIEnevJFj9 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3056763"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3056763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 22:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6485347"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 22:17:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 22:16:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 22:16:27 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 22:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mM8xC/BES/0PCui8tF5TiluNcWjhpGTnaBEnQF6f2fxxvWwvKcaC1HMU8Ku4OuYzOH9ybs1vBGmqmzo3kN/rEi9F7pXU+W/SCxzHTdG+hMpjTh2KUvH91liei0h7rj09QlFVMJI60FS7OUjm2LBa9eIPyD4h168FhI8Z4xtqI5QQtuo9itkQXutCjMree+eRzR7u+1gqNfOft/HOme2AEgmygta3wLKPH24K6h3a44aAAtl8TT0ikuYGOjAe3IKP8CAaZ6FA1LTeQoYWkKVMQSRSNlDx/1yYuO3sqg977gQQLgtlG9f8MFv1f70D831rVHiNqaf61AaAfdsra2aweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siVd7eKC5IldXIrbDcj2lVOnUKSLcmlfM6gql2iC9RU=;
 b=ZCEw1vk8d533D+O1mhne0Z0iCYFEeDceQnqGVTdvr35cs6rw8afD5oZ31GE2d4vqWOy9FF3rW9Uzs1co3IjKuDhp1oK94jcV7lNMymubKxQgDmHDSJ0TmcVDTyxLBAQ6b3dA4zF6mWsu4Vh8vWqRqMvwfDT9RFFcC0crxqFKjRoNgREsoznZ7zAJDf+allWu3NvQ4ySu2CX8ZtpMqvmY3uLhrRamhNo+ZGE1kj/wBMLo9RjoOSI546BtWW8cGaDjPGmXAyvJCpvxYG7EdhVKshxYyyIsLKkD2giW7My4hCHWCn/D5oWGKBseU3KKz5W5QJ4nRRg6x31syPOU22WKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Mon, 26 Feb
 2024 06:16:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 06:16:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 04/18] vfio: Add host iommu device instance into
 VFIODevice
Thread-Topic: [PATCH rfcv2 04/18] vfio: Add host iommu device instance into
 VFIODevice
Thread-Index: AQHaVOCVs5aykNH2U0mMtPT8RWR3mLER64SAgApeQhA=
Date: Mon, 26 Feb 2024 06:16:21 +0000
Message-ID: <SJ0PR11MB6744E9F4BC4103B1ECDDE18F925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-5-zhenzhong.duan@intel.com>
 <60307c1a-bff5-48ff-99a3-a44c1fd23db2@redhat.com>
In-Reply-To: <60307c1a-bff5-48ff-99a3-a44c1fd23db2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4994:EE_
x-ms-office365-filtering-correlation-id: af6ab07b-68cb-4e3e-5c5e-08dc3692740f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2A/wM3XzwJXRQuiKtqdpI5P4CKkO26bhRKxt+VxUQ8f/VwMhlKTwa4n9EZYg2YJ2jz9oUiLHje8oA92RGtoaJakcbjrHa9BNgFLmnsj5I0DTJR4ME/1kh1wu42jGMpBjVk6MG0OdaM9g8nylI8CXvrgcRs3ocUY5uE1S1ehK10n8/m+aRkI5gSWotj21UkeEHEPhvGyFGshptEa2OUGsss6wNbkhsyO+w8WkqC+iAXWfEfahzcXimDSWuu+Iy80T+jz9ZjXF4mWQp4MvSYmVC9Da1S5INVad4Ph6OBMDFlNeEx7l+mLPDoaO/0f4hGOL5EL5umIqe7khBX7CexBoSWesjxGahu9yx+DTkMyqpuh8qVabmKhZoI8umh+qHh+Yfqte2iP7LtxEeAfNmc4JLFZZeJ5Bi8ZozHtYhVXV99xismkHgM2AZ3MeBN/u/vB90VtU2Kjwwz4kiR+m9BETUAt36bwZBYtyQ+KxKxIjDCR+XrGDxC2iuJPmqKuQ0szCMChnr9YLkDFjffo+o8e72EWHm+8UDuPElWvfZNVazAl2FrtHh1tGPisS+wGBFYPrxQEis2xZSHjoVUrt0k/sYfnTannYvei+u3ZGsk0McBN0VZ4KIDtcafEoB/Ij831VJ+kCnKZs1rYHqJbUrn0J/HNGYjxLckmeogYWrKLW4TgI7nuu06Vkn5/badGHZ4eCxUx0i3byX3+e/KG/XsisUYLMoBqNeA9+aqT/cLmJsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1F0MnVmdFcyMXJIWjZNck9nMlY3eEUzbzVQWUdyeU5tcytobXlRd3V0R1BB?=
 =?utf-8?B?SFA2cGhScEtqVkNLYkVRYXpiZElaMUhMV1g3VVQxL29JaHhsWHp1cHZaOGo5?=
 =?utf-8?B?OG10amoyamtZZmMrSFpOV0RTcURkeXp6NWViS2s2bnVzOS85dERJcFZKdGc2?=
 =?utf-8?B?NURGQXNqbTI5UUFGWWh5N215bTVxb296VmVwUjZBWW9jVDFCdW53TXRTck5l?=
 =?utf-8?B?Z2ZreDVuLzVBaUZ1dlFYYmxLK2lnUGxsVGNQMUJzQnRTQjF1Q2tPNFBaOUpt?=
 =?utf-8?B?bjI3aFRUVlI5UjFFZUZZdnhQeEs1andDRFB0ZThRK3lJazkvWXJPSk5nbkh2?=
 =?utf-8?B?MWtjUjZhUUVKTnkrRkFEMi9KT2NGOHhHcjN0Y1B4UjQ3Yll2cVNFTHN5RlRJ?=
 =?utf-8?B?WE5SanVGS2NWZ2tQVHlrb0tNRWt4aTQzL3lMVG16UlY3UjlxN0h5Rm5mVjdu?=
 =?utf-8?B?cFp5WmRMOTVpc0N2eTJPMEVoa3RveGVvUjNiSjZGdVBqWkUzVWdrMjAxejBY?=
 =?utf-8?B?WFl4OXI4NlJ2UWJiRnN3eGpKdjdDUDNzTXM0ZnRUeWFsWUY4YnVCWjNuZkF0?=
 =?utf-8?B?dEdJVldTSkdDQlJlSk1lNE5GdWJWblJBdHhtUDhIYjJnT1JoYUhSQVNXeEU4?=
 =?utf-8?B?bXdUTXFYVXhZWlViYVkxQ0tUR0g4ZFRtc1R0NktTUkhGd3FwWDZNV1JTbDJ6?=
 =?utf-8?B?RFhUeGlMMjV4a0R1WUYyclI2bTFkNnRQVEZnZWxUalBCZjJWQlRyMEpNYThJ?=
 =?utf-8?B?VTJTUDBpQXVFdTk0cXFhNmxPZWV6K0JiZjE0RWd4cnljd1hWK0JoaEFkTzEr?=
 =?utf-8?B?MDh2dG1IYnNaYWhOTS8zc2VZTWFCbmpSVG9tOFVaRGZlRkZMMnp3UGJ3ZzFS?=
 =?utf-8?B?V05SWmU3c1dPV2d1enc1emIzSVcreUlhRlg0azhEc1o2dFNiaEFYTmQ0NUxt?=
 =?utf-8?B?Sk8yQS9ScG5mb2lRT3FISWtFQVN4eXRNRlAydksvekQ1YloxVGorSzljTnpQ?=
 =?utf-8?B?WVhUUUxVR1NvNmVmblFMMUFqNVoxWmFMQ2hFazlnYnlpV2FmakMyTDJpc3Ar?=
 =?utf-8?B?cFRiaHh5L0UvVlNFZlN2YldwemhhRStjNEpMT1ViVmN1ZlFhaHpDZTc2R2N0?=
 =?utf-8?B?Y3prMFkyRXR3MzliNXo4U25nMHEwQ21GcHdYUzQwSUFNQklOZFp6YXBRS3U2?=
 =?utf-8?B?VFdTSkJhNDlERFEzbmlWWDlMZjhIQmRHK014dDQrNmlNWW9lTmRlZWRoRVVH?=
 =?utf-8?B?SHdTKzZ1Ri9kaVpuVEVFU3pqRld4QncyREdGRVhwMXpQS3d5RGRNUjg3c1Zy?=
 =?utf-8?B?UVVQUnkvajlnM1ZZTXlmbzJ3K1lGbmhCMEY3UTNMZjZoaXVndTR1ZXBnaXJG?=
 =?utf-8?B?bm1ORk0yNUowNDVtNEJYem5tSlFhc1lUcFVJLzlzVDkxeVYyejRxelE5dDg1?=
 =?utf-8?B?MXdBbW5vRkNabm03a1dyRS9wdTBNWXFyRitCNjlveExrVDJVc1BJZkk3YXJI?=
 =?utf-8?B?YjFNcGI1eFpzdGc1THR6OUpFT3M1RzNzY2pBM1c4dC9IQ2FZRXM0ZXdKS3ZQ?=
 =?utf-8?B?SU5kTmtkRXRwd3o4Z2pkQTYwV0cwZFJtMWlRSXc2eVB6SjdPMUM1RGpwbjly?=
 =?utf-8?B?T3FPMVpFREtGSHJOdkNnbkZ3N0dGVEZVUUp5WFYvYWJWVEZ0R1FOc1lYblR3?=
 =?utf-8?B?eVhTYStZSXoxREg5U0pIbHRvT2doaE9nWUVTWHZybmVsclJpM1h3eTNySnhV?=
 =?utf-8?B?bjAzRE52U2NLS01taDVIOHpMRE1yTFRJVmFjZGk4eS9aVkQyNGhHUmw4SDdw?=
 =?utf-8?B?Z3hyQ2hkTjJueE1VZW8wTGlGSi9OVFc0RGpYd3lXTmR2NFZldFJwdEZEd29z?=
 =?utf-8?B?WGN2MmRhNDVhZmh0NDNORDNsdkNnWUsyU21QRG5aamVNSFZxR2tseHJzeTEr?=
 =?utf-8?B?QXVXa00rL1EvU1FIWWtEVi9ZV001MFFSNkNBRk5DamhpZEVrQS9rWnhTRDMv?=
 =?utf-8?B?cm1WSnUrM0hmZnFkL1FmZzhzS3VlWTZtSm9xMkVlaXVMOUpQTldKTUxUN0dE?=
 =?utf-8?B?Um9aM0RBeTNnaG1aQ2poTmMxdzF0NmZmVnpnTjlQM0dJWDJGTC9vTldMSHVH?=
 =?utf-8?Q?PZWKaaec4T7lauDDjgPrzeP2U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6ab07b-68cb-4e3e-5c5e-08dc3692740f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 06:16:22.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYKInevD2dmbXJKPIveQuE0fhJvPVUuErvxlc8hpcGopH4VzJkBfCkZNMnjzTim8RE9Fwv4dGeoDtArphplUuCWru1OO9oB64+s2i1y+6Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjIgMDQv
MThdIHZmaW86IEFkZCBob3N0IGlvbW11IGRldmljZSBpbnN0YW5jZSBpbnRvDQo+VkZJT0Rldmlj
ZQ0KPg0KPg0KPg0KPk9uIDIvMS8yNCAwODoyOCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBF
aXRoZXIgSU9NTVVMZWdhY3lEZXZpY2Ugb3IgSU9NTVVGRERldmljZSBpbnRvIFZGSU9EZXZpY2Us
IG5laXRoZXINCj4+IGJvdGguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbW1vbi5oIHwgMTEgKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1vbi5oDQo+PiBpbmRleCA4YmZiOWNi
ZTk0Li4xYmJhZDAwM2VlIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMzIs
NiArMzIsNyBAQA0KPj4gICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+PiAgI2luY2x1ZGUg
Imh3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIg0KPj4gICNpbmNsdWRlICJzeXNlbXUvaG9z
dF9pb21tdV9kZXZpY2UuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCj4+DQo+
PiAgI2RlZmluZSBWRklPX01TR19QUkVGSVggInZmaW8gJXM6ICINCj4+DQo+PiBAQCAtMTMyLDgg
KzEzMywxOCBAQCB0eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNlIHsNCj4+ICAgICAgYm9vbCBkaXJ0
eV90cmFja2luZzsNCj4+ICAgICAgaW50IGRldmlkOw0KPj4gICAgICBJT01NVUZEQmFja2VuZCAq
aW9tbXVmZDsNCj4+ICsgICAgdW5pb24gew0KPj4gKyAgICAgICAgSG9zdElPTU1VRGV2aWNlIGJh
c2VfaGRldjsNCj4+ICsgICAgICAgIElPTU1VTGVnYWN5RGV2aWNlIGxlZ2FjeV9kZXY7DQo+PiAr
ICAgICAgICBJT01NVUZERGV2aWNlIGlvbW11ZmRfZGV2Ow0KPkkgdGhpbmsgeW91IHNob3VsZCBy
YXRoZXIgaGF2ZSBhIEhvc3RJT01NVURldmljZSBoYW5kbGUuDQo+DQo+aG9zdF9pb21tdV9kZXZp
Y2VfaW5pdCBjYiB3b3VsZCBhbGxvY2F0ZSB0aGUgcmlnaHQgdHlwZSBvZiB0aGUgZGVyaXZlZA0K
Pm9iamVjdCBhbmQgeW91IHdvdWxkIHN0b3JlIHRoZSBiYXNlIG9iamVjdCBwb2ludGVyIGhlcmUu
DQoNClNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLCBqdXN0IGJhY2sgZnJvbSB2YWNhdGlvbi4NCg0K
SSBkaWRuJ3QgdXNlIGEgSG9zdElPTU1VRGV2aWNlIGhhbmRsZSBidXQgYSBzdGF0aWNhbGx5IGFs
bG9jYXRlZCBvbmUNCkJlY2F1c2UgaW4gZm9sbG93aW5nIHBhdGNoOg0KDQonW1BBVENIIHJmY3Yy
IDA1LzE4XSB2ZmlvOiBSZW1vdmUgcmVkdW5kYW50IGlvbW11ZmQgYW5kIGRldmlkIGVsZW1lbnRz
IGluIFZGSU9EZXZpY2UnDQoNCmlvbW11ZmQgYW5kIGRldmlkIGFyZSByZW1vdmVkIGZyb20gVkZJ
T0RldmljZS4gSSBuZWVkIGEgcGxhY2UgdG8gc3RvcmUNCnRoZW0gZWFybHkgaW4gYXR0YWNobWVu
dC4gVGhlIGhhbmRsZSBpcyBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYWZ0ZXINCmF0dGFjaG1lbnQg
YW5kIGNhbid0IGJlIHVzZWQgZm9yIHRoYXQgcHVycG9zZS4NCg0KSSdsbCBjaGFuZ2UgdG8gdXNl
IEhvc3RJT01NVURldmljZSBoYW5kbGUgYW5kIGRyb3AgcGF0Y2g1IGluIHJmY3YzLA0KTGV0IG1l
IGtub3cgaWYgeW91IGhhdmUgb3RoZXIgY29tbWVudHMuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

