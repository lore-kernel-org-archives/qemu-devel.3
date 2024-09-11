Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF10BEE0219
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 08:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soIwj-000328-8P; Wed, 11 Sep 2024 04:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soIwg-00031H-0W
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:43:26 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soIwd-0000h3-BP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726044203; x=1757580203;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V3GSIferUteBqSZla4f0xGFhek1WzR7FtOUwJIvfKkg=;
 b=dB9w7U/Luw54mCUuUuBxPBOIMVkipbThyH8shWmfbQelnQndQRc6SFp/
 /ZjZfL0tG3FZvIOIzWsuqXo7LFaMRDTFKnpR9kIA41vQT/lVFWi7jtqeb
 aDer54y4Z3zU9rcA2mvkXu+7nZOTTy1batHLD1+X9NxCDFOefH+NLO8mc
 K+Ol7WsShzc/1Kxwa4KM4VefXgAFg3jSkVHuqt3Ok1R/XfMrYxYJg16e7
 v0ucgzA0EnuYQurRQunlLfYvTdT8TfrzQ3rMH5OrzU3ePTwQJOV781oak
 oSvjlSdPTwYUGRhuNvVp5JOvnjC+S8vr7kkz+s3+d1JB+76O5BmUw3pGT w==;
X-CSE-ConnectionGUID: 4T3YVR+DTt2DMaGSD9vrdg==
X-CSE-MsgGUID: pVkumitKRZi4v/CdgMUSNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24968297"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="24968297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2024 01:43:21 -0700
X-CSE-ConnectionGUID: y7ZU35XLQgOHhwG3/aa1rw==
X-CSE-MsgGUID: wuA1Ig8wTQOj2z/GjsRpag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="98000210"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2024 01:43:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:43:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:43:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:43:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHbOfYkEZMcwdFRjbigPv95t93yJ/tGMfzvWHlsVj8GVbrDKQuc4b+PJTsDhOtOkfqTK3uSsS2dslJgcmUt4WEDKNFWZ0H8sj3fI756yHI5xLe7HkVKQxkELy+6FdZPUUHkbH5v3sZC2GhCFe6ljq4730oSNX0TLFyspHFgQHfcp9yIfnbQjHG0I1vYfh006GKQqAKWO+Fks1R+PKCm2lkm05OKdDrHUy1EI0apDTkr3xmvKgk8znM/HcVj8TqJCtbulSYJHuLxDH0H/VybfXJMk+st+kSPkNuiVkm0Oqq0HNs0MGMjRTpvUkwCCOUZlY3EDbbt2raNxZ6ChIjYHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3GSIferUteBqSZla4f0xGFhek1WzR7FtOUwJIvfKkg=;
 b=s22HaYQo9EpxuF9JMF2mIHcUxFtwA+rEbrqT8YODUz6XYtV/DH/83lwkz+VHqCvaOjHUyTdv/ami7XyozRQ+qddHwGT6FZ04F906+WHkEIonp7S1TAOP/zx7hNvXokWuchFSj/UaE5fCH0stlfFZvYJGMWAgFR2WmRSmRWA0Myee7KIH+Bl8X+UYWp3faE4dK6VXLu6JuHETWzcNkd5WxxbhFPDa9lGJHsvAVyPc/59HjNcPoE1UgDrMrnIkowgvKQiH1LetZ9rJjDuNmp3ihXD6GbQ1ANlPDE3ehEsNt6TeFo5HYDS3Vj9FFMTKsvbe3/IF1Nb8hUcADPy2thmTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 08:43:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 08:43:10 +0000
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
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v3 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbBAsau6moDBAkeEOd6Z8ZJ8S8pbJSJ0IAgAAcnrA=
Date: Wed, 11 Sep 2024 08:43:10 +0000
Message-ID: <SJ0PR11MB6744522A7192F1FA3794651F929B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <c84acb53-bd3b-4f3a-8c0b-7d4cae1fa8a8@eviden.com>
In-Reply-To: <c84acb53-bd3b-4f3a-8c0b-7d4cae1fa8a8@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: ba66a00e-2d11-4f8c-12eb-08dcd23dc421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aG5ZL25kTlpZczJHS2JvMDcrb1RHcm5Cd2tBcVR2ZThXVzFNMUVySHBMdVNz?=
 =?utf-8?B?OEltODJrRm9WRTNOZzhsNGVRUEZZdTdabk5YUWdHeWRQSWRpbEZCejJGWjRm?=
 =?utf-8?B?TkhxdjdYS25lVzIwRDRxWjVVV2x3QVdTWkhCZkJ3S0g2R3piMW1WMHFOM29P?=
 =?utf-8?B?dWY3ajJkbEJmU2V0RjhvSGlJWEhXZnFEaUFHWGhTTzJKSFRZdjhOSm1adVZt?=
 =?utf-8?B?MS9YdDdXeTRjeUphTENuanRRZjdBYXVLcW9kRUdCTHpVK1YySVFtSDhVMDJQ?=
 =?utf-8?B?dlhhQUJ6djc5d1R2ajBud0xPclJSb01zVGU1S2d2TitROEh1QXZET0NJNXgw?=
 =?utf-8?B?ejNlY1RwcCsrb0QyYmh1YUN4MVFBUE5rZkh2ekVYMUxlWTZOSkhVS29WeXdm?=
 =?utf-8?B?THdmOURISUl3UmppYjIveVV4YWVWZkg0QkVKOUFiV1U5c0RlejZ3SHVuL1BB?=
 =?utf-8?B?elczRmU4YTdiT1R0dWxKS0tSbjdYSFNJZnl4MEt0OTR2bUJGd0JmQTFneEFN?=
 =?utf-8?B?ck81WndJRkhQbnNtNHpObkNiTUxnL1ZxL29MaWE1dnVTbC9UTGg0QmYveTdu?=
 =?utf-8?B?YjMwNURxTkp4Z2MxQkoxUmZkc3ZzWUQxeitiZU1WakVrU0haM2VoSVdCSUkz?=
 =?utf-8?B?SDRJNWI1N3hqR1J0YlF1U1lLUWN5eFNWUW43UnQ0a085aVBIMXRyWGwvemZm?=
 =?utf-8?B?R0lQWkY0STNXQzhxbmpUVHhzYkh5bGNxY1dCVUhNdkV0YlJmWHZ4ZUNjWFZ2?=
 =?utf-8?B?WHpkNWQ1QjhINUxUcXNmRHlBSlphQzBRRlBFZnFuekpnWncrb1VsNWRFYUc2?=
 =?utf-8?B?RkYzZFlLdnRLV2dZN1FBazVYWmVCOHpJRnJlVUZvenRNWmM5OExOS0pXUVZO?=
 =?utf-8?B?VHVBcGxUbDQ0Tk9HVEtZVkZkbFJURERpWFQ2d0Fab0tkL1FlbEpXRk5YV1hp?=
 =?utf-8?B?dmdiR3BiekJDb0k0OEtlQmN4N2hSWVlVNG1NTHpGVFFsUDZKUWMrUmtSejIr?=
 =?utf-8?B?NUlrSWRSRHBIT2FlSXNNaDBGQWpJNXl3QkZ0OVVvZFN0WnJkM2RvWWg5ci9K?=
 =?utf-8?B?eVhjQ3RwWFk5aUhNenk5M2ZQL2xqTnpUNUVFcUdMNXhTLzlNNExDWjg2Rk44?=
 =?utf-8?B?eC9PdFh2WWs3N2xYSmIxYWNsaGthTTVidG42LzZXUHl0eDRqU0NxbC96WWcv?=
 =?utf-8?B?dDJ1WHFNditLNjVIODlacmh6anV2Ykl4Zm9MWjdKYWpXejVoY0RQWjdiU0lY?=
 =?utf-8?B?N3lpK1pqS0dXaytYbzY1NGhPUEJuQ2JOZU51M3FObC9odUY0YzhySkRWTy9J?=
 =?utf-8?B?MU53NmZ0S3p2S2ozcWtIcjBDYzNMekcxb1RoU2NHQWRqbGRjZll5QXRLK3Ft?=
 =?utf-8?B?YUlhTmxPUUJNb3BVRmtpNUpCUUtQYmJLUFhNcVMzT3JqUUYxQ0pyOXUvV2xQ?=
 =?utf-8?B?VXJZekFSK1JpQ3BZWlc1RTBNWGdYRkhOTjlzRXE4bUZ6MDQwSG5VaGgxbnF1?=
 =?utf-8?B?WmxvWU1SaEJVSFN6Y3ZBS1VJREw2L0MvdzVxS0pXbHV2MnE5UDhrL05DT3VE?=
 =?utf-8?B?dkRRZmdQNE5tVDhsdm83U1orYlRULzBuR2dDaXlXL25uMTdiaU1EVEdkSDIz?=
 =?utf-8?B?V3UzT2tlOS9LTXpvb3NaZUwybWMvWUlhbWsyUmd1dmpONS9rV3M4NWM0WEM1?=
 =?utf-8?B?cjd6UXg5VGJjcFpJVkk5RVVrZWR3WXU3Q3lZbCs0VGFlUWVyS1BYTWpvN3Vz?=
 =?utf-8?B?eU5hTWZFOVJUQ2FRZ1pXWW92R1RxMkFiZ2cvNTFGN3RjUWptV2dFR1J3cVlG?=
 =?utf-8?B?VHVRS01CSnE5b21yV015cm5EY3NSV2x2TVNQTERtQk8zbGdQM2hNTlFlVG9n?=
 =?utf-8?B?VWl2Y3FOUE5GWHdqOUM4VTA4c1VvNksrNGZLL0FjLzlHT0s0WjBzZDdWTFJP?=
 =?utf-8?Q?EQDhW1DaBxg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFo1bEFMaldxZUpiUThpc0ZqejJEaUNWUnoyaS9GRVJ1VGNiRWwzc2ptZCtW?=
 =?utf-8?B?SkxERXFTQmZIK0hXdXcyYzNMYUdKQ0RpWGZGZVIyNXRPYld6Q1hTVFFaeFRQ?=
 =?utf-8?B?QmFhcHNVTDN3LzRhUGJ6ZHVReU5KeG1VRWErcHN5VU9OZFpBeUk2MWZFOEpv?=
 =?utf-8?B?bGJqeldCamYvOUMvbml6bXQ0bnowNlJ4ckV3UGt3TlU5cjk3YzNsOWFMSHpx?=
 =?utf-8?B?VHIycndjdzNKemxJUEYwb1VsSy9UNFFPUHA2ZkEzdnY4SjhjZGZLanZuNDIz?=
 =?utf-8?B?RUN3bDJUWUVEVzhlL0NuSkk0VGNPMTNpWU5MeHYvWnUrMXk1NVNkSTY1U1JJ?=
 =?utf-8?B?dW1tN2psdGdVYlZrUXBnamFoMnpieFYxUmI4MkxrNjlIYUhWeGhrVnR5QnVS?=
 =?utf-8?B?ck5QT0hoYlhRWEgwdmt2NWQvQUZHRmhXUUcrSUgrQVR0N3lpajFrTkdNbkk3?=
 =?utf-8?B?WFlzcVRUem5DL3lRMmlVZGJNL2RRVTJGMmdpZlpCRHkvU1lYc3M0eTVieGI5?=
 =?utf-8?B?TDV1ZVFPSkFSZ2xkNGJkbWUyaVpRSXhNMzM1cnlSK1BDclppZk9lOGYrUGEw?=
 =?utf-8?B?ZkJEMHBPSXZvZHFHTi95Z3BsbW9rSFZ4L0JIaTZ3dTQ2bEE3OTgrL3hpN21C?=
 =?utf-8?B?a0hPZ0pYZkczSHpPa2FsMnNQOThWMGVEcmJoK1ZwVDBKc0liYlZZRDNoaGs4?=
 =?utf-8?B?Q0hPUmw0Ry96UWwrdkk2WkcxWEFqeVRYdUlmVFQ4bk53R3MzMW5QdnpJQ2tU?=
 =?utf-8?B?UG5mMTcyTDQyQkp3SmZzZDJZUVVydzlBMXByeGp5R1JTa3hoRTBGVGR3M2J2?=
 =?utf-8?B?VmRyK2dGWWxsMWZES1A5ZWFPaTRpblJzS0cvL01oU05TQzBmSEtRbE1uK2Rj?=
 =?utf-8?B?ZVhZNElSUmVtR2c1ZzBNNDhLejhnTFFZYUxYTXZ1QnNiZlVvYzkwOW5RMVk4?=
 =?utf-8?B?VThuRWNWNkxYNzY2Y3ZHdk1wT1lncjFjUXkxVFpGUXB0c0l6WUhmUlFrMW5z?=
 =?utf-8?B?NitMYUFQNGUxbkNLZlRUYWdkN2p6ay9IUlVONkY2NEFFRm1zVitvYnNxM3cv?=
 =?utf-8?B?aTFBWExHNG90SzU5eVArQVo5eTdLOWNPMlRTaVBBeDhwL0Q4c1ZnSmhjbUlw?=
 =?utf-8?B?UUNjUVIybVlnSjRObmtSRitVWUFzck11Z2E1ZCtVQlJsSW1iQjFxSEpjZDVk?=
 =?utf-8?B?YTVZTlZYbDd2b054TmV3dnBpbDFkYjEvdmhrdHhDVlJzaVMwRHZDc0ZQeEg3?=
 =?utf-8?B?UWxVQnpNRFVuREFSNHdXSGY2OHNkVW5rc09CcCt0TGhEMkJSa01FME1vam5W?=
 =?utf-8?B?WHRleHFJTzB2ZitzYk5aVDBuNEw5RVRKdTE1TWRuaVRyellNYWFFV3FSVWpV?=
 =?utf-8?B?RmdZS3kyWER2dlBYYkQ5MW5RR1JoYW84cW95aHVxYlMxeUxuNWM3Zlh5eXda?=
 =?utf-8?B?aE15R0dxeDNHL1hSNlNpOFhla2FhdG5tT2xnWG80K0xhUnZBYndZWXF6cUFP?=
 =?utf-8?B?ZVluZU5FVTZHNng5VVRMbEltODRNRHhDazNPOUdEaE5GTnpCTzVDamRtZjNV?=
 =?utf-8?B?VWZsa25wbUpxTWdkTmNzYVNJZGZSM3dqbzBZOHlJcm53MXhNUlBsTGNRMGpW?=
 =?utf-8?B?dmJkMHZxTDBlMytXNzBmeFBtL2FkVEZsaWJkc0h4QndycjZZeTdhVWJsdDRQ?=
 =?utf-8?B?dzd2R2RQZUdKV3BsUVZINUpGYnZ3Ny9PWkdXWGt1ZXZhU1dXdGI4WUQxSkF6?=
 =?utf-8?B?Qk03d2Q3OENGOTR2QkNsV3Jqa3haM3VqWlo3aDlVYVRPNzN1ZDZZeHQwc1pX?=
 =?utf-8?B?azljMXJtYXFBV0x0U2x3TERaSnZmVDM5NlQ5dFJ3VzBLTFhOOCtlczFmMVYz?=
 =?utf-8?B?Y2NVR3c4K29TR3Nxc1ZpSXVLWUtEVWhJdGdqaHR6RnEyVlZHK3lncmtCY3Vm?=
 =?utf-8?B?aW5RTE9qOGxNWEFxbHc5aFNpR0lWYjNkUm5IYmlxNVVsV0hKYjd2ZFJKSkVm?=
 =?utf-8?B?V0w3MW1COWJKOVZvUHVoeU1rekNLd1pWMWlsOW5LcXFMVHdMNG94eXI1WVhR?=
 =?utf-8?B?ZUlBYzFDazhQOWVGTzRtSFdzWklkYld1anlCSktyYldmNjFydElIZ1dIUXVu?=
 =?utf-8?Q?5yiISlo1kS0It8ZrlUN8l10Ve?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba66a00e-2d11-4f8c-12eb-08dcd23dc421
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:43:10.4745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n3Ne8DKdOLZGM8bokG0adMpbWkXV5uAaGeyiSGlxzlSll8BfhgJXaaPJmjPOZBKyxNLDvvEes7380oE57gaN2T/2rdXNQjeXmVnD30MC2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

SGkgQ2xlbWVudCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gSG9waW5nIGl0IGNvdWxkIGJl
IGFjY2VwdGVkIGluIHRoZSBmb3Jlc2VlYWJsZSBmdXR1cmUuDQoNClRoYW5rcw0KWmhlbnpob25n
DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwMC8xN10gaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZv
cg0KPmVtdWxhdGVkIGRldmljZQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5UaGFua3MgZm9yIHBv
c3RpbmcgYSBuZXcgdmVyc2lvbi4NCj5JIHRoaW5rIGl0IHN0YXJ0aW5nIHRvIGxvb2sgZ29vZC4N
Cj5KdXN0IGEgZmV3IGNvbW1lbnRzLg0KPg0KPiA+Y21kDQo+DQo+T24gMTEvMDkvMjAyNCAwNzoy
MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8g
bm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwg
Y29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4+DQo+Pg0KPj4gSGksDQo+Pg0KPj4gUGVyIEphc29uIFdhbmcncyBzdWdnZXN0aW9uLCBp
b21tdWZkIG5lc3Rpbmcgc2VyaWVzWzFdIGlzIHNwbGl0IGludG8NCj4+ICJFbmFibGUgc3RhZ2Ut
MSB0cmFuc2xhdGlvbiBmb3IgZW11bGF0ZWQgZGV2aWNlIiBzZXJpZXMgYW5kDQo+PiAiRW5hYmxl
IHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZSIgc2VyaWVzLg0KPj4N
Cj4+IFRoaXMgc2VyaWVzIGVuYWJsZXMgc3RhZ2UtMSB0cmFuc2xhdGlvbiBzdXBwb3J0IGZvciBl
bXVsYXRlZCBkZXZpY2UNCj4+IGluIGludGVsIGlvbW11IHdoaWNoIHdlIGNhbGxlZCAibW9kZXJu
IiBtb2RlLg0KPj4NCj4+IFBBVENIMS01OiAgU29tZSBwcmVwYXJpbmcgd29yayBiZWZvcmUgc3Vw
cG9ydCBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+PiBQQVRDSDYtODogIEltcGxlbWVudCBzdGFnZS0x
IHRyYW5zbGF0aW9uIGZvciBlbXVsYXRlZCBkZXZpY2UNCj4+IFBBVENIOS0xMzogRW11bGF0ZSBp
b3RsYiBpbnZhbGlkYXRpb24gb2Ygc3RhZ2UtMSBtYXBwaW5nDQo+PiBQQVRDSDE0OiAgIFNldCBk
ZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kcmVuIG1vZGUNCj4+IFBBVENIMTUt
MTY6RXhwb3NlIHNjYWxhYmxlICJtb2Rlcm4iIG1vZGUgYW5kICJ4LWNhcC1mczFncCIgdG8gY21k
bGluZQ0KPj4gUEFUQ0gxNzogICBBZGQgcXRlc3QNCj4+DQo+PiBOb3RlIGluIHNwZWMgcmV2aXNp
b24gMy40LCBpdCByZW5hbWVzICJGaXJzdC1sZXZlbCIgdG8gIkZpcnN0LXN0YWdlIiwNCj4+ICJT
ZWNvbmQtbGV2ZWwiIHRvICJTZWNvbmQtc3RhZ2UiLiBCdXQgdGhlIHNjYWxhYmxlIG1vZGUgd2Fz
IGFkZGVkDQo+PiBiZWZvcmUgdGhhdCBjaGFuZ2UuIFNvIHdlIGtlZXAgb2xkIGZhdm9yIHVzaW5n
IEZpcnN0LWxldmVsL2ZsL1NlY29uZC0NCj5sZXZlbC9zbA0KPj4gaW4gY29kZSBidXQgY2hhbmdl
IHRvIHVzZSBzdGFnZS0xL3N0YWdlLTIgaW4gY29tbWl0IGxvZy4NCj4+IEJ1dCBrZWVwIGluIG1p
bmQgRmlyc3QtbGV2ZWwvZmwvc3RhZ2UtMSBhbGwgaGF2ZSBzYW1lIG1lYW5pbmcsDQo+PiBzYW1l
IGZvciBTZWNvbmQtbGV2ZWwvc2wvc3RhZ2UtMi4NCj4+DQo+PiBRZW11IGNvZGUgY2FuIGJlIGZv
dW5kIGF0IFsyXQ0KPj4gVGhlIHdob2xlIG5lc3Rpbmcgc2VyaWVzIGNhbiBiZSBmb3VuZCBhdCBb
M10NCj4+DQo+PiBbMV0gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjQtDQo+MDEvbXNnMDI3NDAuaHRtbA0KPj4gWzJdDQo+aHR0cHM6Ly9naXRodWIuY29t
L3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfc3RhZ2UxX2VtDQo+dV92Mw0K
Pj4gWzNdDQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25n
L2lvbW11ZmRfbmVzdGluZ19yZmMNCj52Mg0KPj4NCj4+IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+
Pg0KPj4gQ2hhbmdlbG9nOg0KPj4gdjM6DQo+PiAtIGRyb3AgdW5uZWNlc3NhcnkgIShzLT5lY2Fw
ICYgVlREX0VDQVBfU01UUykgKENsZW1lbnQpDQo+PiAtIHNpbXBsaWZ5IGNhbGN1bGF0aW9uIG9m
IHJldHVybiB2YWx1ZSBmb3IgdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsKCkNCj4oTGl1eWkp
DQo+PiAtIG1ha2UgQS9EIGJpdCBzZXR0aW5nIGF0b21pYyAoTGl1eWkpDQo+PiAtIHJlZmluZSBl
cnJvciBtc2cgKENsZW1lbnQsIExpdXlpKQ0KPj4NCj4+IHYyOg0KPj4gLSBjaGVjayBlY2FwL2Nh
cCBiaXRzIGluc3RlYWQgb2Ygcy0+c2NhbGFibGVfbW9kZXJuIGluDQo+dnRkX3BlX3R5cGVfY2hl
Y2soKSAoQ2xlbWVudCkNCj4+IC0gZGVjbGFyZSBWVERfRUNBUF9GTFRTL0ZTMUdQIGFmdGVyIHRo
ZSBmZWF0dXJlIGlzIGltcGxlbWVudGVkDQo+KENsZW1lbnQpDQo+PiAtIGRlZmluZSBWVERfSU5W
X0RFU0NfUElPVExCX0cgKENsZW1lbnQpDQo+PiAtIG1ha2UgZXJyb3IgbXNnIGNvbnNpc3RlbnQg
aW4gdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoKSAoQ2xlbWVudCkNCj4+IC0gcmVmaW5lIGNvbW1p
dCBsb2cgaW4gcGF0Y2gxNiAoQ2xlbWVudCkNCj4+IC0gYWRkIFZURF9FQ0FQX0lSIHRvIEVDQVBf
TU9ERVJOX0ZJWEVEMSAoQ2xlbWVudCkNCj4+IC0gYWRkIGEga25vYiB4LWNhcC1mczFncCB0byBj
b250cm9sIHN0YWdlLTEgMUcgcGFnaW5nIGNhcGFiaWxpdHkNCj4+IC0gY29sbGVjdCBDbGVtZW50
J3MgUi1CDQo+Pg0KPj4gdjE6DQo+PiAtIGRlZmluZSBWVERfSE9TVF9BV19BVVRPIChDbGVtZW50
KQ0KPj4gLSBwYXNzaW5nIHBndHQgYXMgYSBwYXJhbWV0ZXIgdG8gdnRkX3VwZGF0ZV9pb3RsYiAo
Q2xlbWVudCkNCj4+IC0gcHJlZml4IHNsXy9mbF8gdG8gc2Vjb25kL2ZpcnN0IGxldmVsIHNwZWNp
ZmljIGZ1bmN0aW9ucyAoQ2xlbWVudCkNCj4+IC0gcGljayByZXNlcnZlZCBiaXQgY2hlY2sgZnJv
bSBDbGVtZW50LCBhZGQgaGlzIENvLWRldmVsb3BlZC1ieQ0KPj4gLSBVcGRhdGUgdGVzdCB3aXRo
b3V0IHVzaW5nIGxpYnF0ZXN0LXNpbmdsZS5oIChUaG9tYXMpDQo+Pg0KPj4gcmZjdjI6DQo+PiAt
IHNwbGl0IGZyb20gbmVzdGluZyBzZXJpZXMgKEphc29uKQ0KPj4gLSBtZXJnZWQgc29tZSBjb21t
aXRzIGZyb20gQ2xlbWVudA0KPj4gLSBhZGQgcXRlc3QgKGphc29uKQ0KPj4NCj4+DQo+PiBDbMOp
bWVudCBNYXRoaWV1LS1EcmlmICg0KToNCj4+ICAgIGludGVsX2lvbW11OiBDaGVjayBpZiB0aGUg
aW5wdXQgYWRkcmVzcyBpcyBjYW5vbmljYWwNCj4+ICAgIGludGVsX2lvbW11OiBTZXQgYWNjZXNz
ZWQgYW5kIGRpcnR5IGJpdHMgZHVyaW5nIGZpcnN0IHN0YWdlDQo+PiAgICAgIHRyYW5zbGF0aW9u
DQo+PiAgICBpbnRlbF9pb21tdTogQWRkIGFuIGludGVybmFsIEFQSSB0byBmaW5kIGFuIGFkZHJl
c3Mgc3BhY2Ugd2l0aCBQQVNJRA0KPj4gICAgaW50ZWxfaW9tbXU6IEFkZCBzdXBwb3J0IGZvciBQ
QVNJRC1iYXNlZCBkZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9uDQo+Pg0KPj4gWWkgTGl1ICgzKToN
Cj4+ICAgIGludGVsX2lvbW11OiBSZW5hbWUgc2xwdGUgdG8gcHRlDQo+PiAgICBpbnRlbF9pb21t
dTogSW1wbGVtZW50IHN0YWdlLTEgdHJhbnNsYXRpb24NCj4+ICAgIGludGVsX2lvbW11OiBNb2Rp
ZnkgeC1zY2FsYWJsZS1tb2RlIHRvIGJlIHN0cmluZyBvcHRpb24gdG8gZXhwb3NlDQo+PiAgICAg
IHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+Pg0KPj4gWXUgWmhhbmcgKDEpOg0KPj4gICAgaW50ZWxf
aW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMgZGVmaW5lZCBieSBzcGVjDQo+Pg0K
Pj4gWmhlbnpob25nIER1YW4gKDkpOg0KPj4gICAgaW50ZWxfaW9tbXU6IE1ha2UgcGFzaWQgZW50
cnkgdHlwZSBjaGVjayBhY2N1cmF0ZQ0KPj4gICAgaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9s
ZGVyIHZhcmlhYmxlIGZvciBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPj4gICAgaW50ZWxfaW9tbXU6
IEZsdXNoIHN0YWdlLTIgY2FjaGUgaW4gUEFTSUQtc2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxi
DQo+PiAgICAgIGludmFsaWRhdGlvbg0KPj4gICAgaW50ZWxfaW9tbXU6IEZsdXNoIHN0YWdlLTEg
Y2FjaGUgaW4gaW90bGIgaW52YWxpZGF0aW9uDQo+PiAgICBpbnRlbF9pb21tdTogUHJvY2VzcyBQ
QVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24NCj4+ICAgIGludGVsX2lvbW11OiBwaW90bGIg
aW52YWxpZGF0aW9uIHNob3VsZCBub3RpZnkgdW5tYXANCj4+ICAgIGludGVsX2lvbW11OiBTZXQg
ZGVmYXVsdCBhd19iaXRzIHRvIDQ4IGluIHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+PiAgICBpbnRl
bF9pb21tdTogSW50cm9kdWNlIGEgcHJvcGVydHkgdG8gY29udHJvbCBGUzFHUCBjYXAgYml0IHNl
dHRpbmcNCj4+ICAgIHRlc3RzL3F0ZXN0OiBBZGQgaW50ZWwtaW9tbXUgdGVzdA0KPj4NCj4+ICAg
TUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIHwgIDkxICsrKystDQo+PiAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oICB8ICAgOSArLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCA2OTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPi0tDQo+PiAgIHRlc3RzL3F0
ZXN0L2ludGVsLWlvbW11LXRlc3QuYyB8ICA3MCArKysrDQo+PiAgIHRlc3RzL3F0ZXN0L21lc29u
LmJ1aWxkICAgICAgICB8ICAgMSArDQo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgNzM1IGluc2VydGlv
bnMoKyksIDEzMSBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0
ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPj4NCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo=

