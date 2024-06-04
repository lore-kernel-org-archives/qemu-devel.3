Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E4AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKlp-0003FL-74; Mon, 03 Jun 2024 23:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKlm-0003F9-Lv
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:23:30 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKlj-0001My-MQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717471407; x=1749007407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CSUi2or5DncmwAzHH+bspKiKxV9fmUJFJyEPF0pX7AI=;
 b=TVAZ9Q56/042RU8CnAlB5ehL3T5M22Lw/8D/0tPQC42y4eYN0mVyyrhh
 S8MRKHlbrQN9dQVb5KSvEoLYqCwOWX7MnAVtHMrBa3X0nzF0lsElk8Jrj
 FDVSxIrc8FpzRINnGNGS2DpjLj/+Ux68Lioly5HAOxfm1LBfHyXPigzWa
 Q6+5IzB2GgQIeNUgGzuvan4HG/XqtOjgcLnaFkS+y0nrniCcr4L+exOn5
 vWS628K/sz01mhPVnCB83zbm5X2lf0Kw0kXI7Lbs6hTGCQnXD5c6PLZMN
 ABwUNIf4gA7PeAkmsoNAv9MXRT6UkoFp5VtK2AhBjFJFzMVLUZ67V2IM7 w==;
X-CSE-ConnectionGUID: Hz1legNGTSuBSdxI4FeZuw==
X-CSE-MsgGUID: w//YOC1yRjWRyb+rnX9Nwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13798075"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13798075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:23:24 -0700
X-CSE-ConnectionGUID: zTrn/jkqSGiNNPjwY43OXQ==
X-CSE-MsgGUID: euBl3uLeQGqjS38EpB6uNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="42169906"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:23:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:23:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:23:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:23:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/qCtB8HPvQh4Gl3MevL00RxUNy8qbxXXQsPtWBmZHHlfGPoZ3Ht3WMcxVxq+6QLqsqAmlL4tkDPsGQQh6S+ua8ixZfc2VoPwTO6MkQP6gXxClXNCPVMrD7I17oyfTf/9fnXzcSMroi6wt2Dqi455lQ02lTndDx7Y/SNv71yrkgRoxu3ASp0PXHyXS3sAWVXm90HxXMBwad/Y9C+Ko4mec/wuj7mVQeotfVlsuzwRp2T76g9Xt6/XHqP/84+FDVG8wOBfaBqE19aLmOTwDgVXlbQTrSA+dnO9FU79XPlTHW5hfO3xgobnkyWUkVWn9uYemLpdhlGOGEWFqM3wnl1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSUi2or5DncmwAzHH+bspKiKxV9fmUJFJyEPF0pX7AI=;
 b=ArEJj3Gjjmm1kpcHv0MtF0QFUjOuY/nUGgzeptvQVcgPqS1rePdXHtEr1Qf04y6xbNnZ0zre/E+qJktYyiZTu9kPAKlorMOD5TuRRr0AkcbdaIj0Dt+5BtfXepjCLWLlMoZi5skNg967DGvXbyvwP/s11LxKtIYjKZsrEJiaSCfT88mDsxqZMbn13thl2KhvuYRN2X+GZxhxp6wh+KS0fEuNInoGGWxCxA7I3V092xJs5P7mD7NN6ghB3ai9J5bUp0ZELA28ODTWNaWDaRHYCiOZr8rxtL22U2wJ+vTDu1jRR55NdFIFom593vBlsrRtmyWFpoisAsKAKaDRHlQQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 03:23:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:23:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Thread-Topic: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Thread-Index: AQHatX06h36sLJ7ptUagEHDYae8P57G16ICAgAARcACAAPTFUA==
Date: Tue, 4 Jun 2024 03:23:20 +0000
Message-ID: <SJ0PR11MB6744B71456C0686F70F023C892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-12-zhenzhong.duan@intel.com>
 <d25fc439-c201-4331-9fb2-d62b37d371b1@redhat.com>
 <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
In-Reply-To: <9d061253-a762-41d3-9313-01c6f94559a1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8153:EE_
x-ms-office365-filtering-correlation-id: c62ede77-c9a2-4ca2-cc64-08dc8445aee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|376005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?V2dZU21lLys2dVVFeVhHc1hxV1JoK0RrYW1pVi9IVURpQi81UVpHSlhJbUMx?=
 =?utf-8?B?V2FQWnN3R24ydjV5UUNKMi92eVpkZ2dyOEFvc3VWaFdvblRjaTlRSGVWTE5h?=
 =?utf-8?B?bG5TTEMvMHJEOCt4VWlPVGZhUlplbkJ0WnpQK2FucXVHdC9lV25MTVpDNDNU?=
 =?utf-8?B?RnI2cWcxMjNIUTg1cy9SQ0VTM0JKVGh5cVFpajdLV0E4UjNtM1lSN1l1NHpY?=
 =?utf-8?B?UU5sVkVFQlZ4M29ReVU1T1dTcGx6a00rSjhaeWgrcnY2RGZUZlZYZHppUmJJ?=
 =?utf-8?B?VmVJL3RON2F4TnUvalkycmJGZysycGxDbDNFZ3BxaUVwOWtHTFJBYkJpWEN4?=
 =?utf-8?B?SktWS0RQYVhEVi9peWJGSzA5MURqQlFkcndMKzNmM2JjS0FkQWxhV1RIcnIr?=
 =?utf-8?B?TWNEbkFmUXBZS0RWTC9zNFM3RG5IWkpzaS9TMHVVcUQyOElHeFVaTmgrM2Rj?=
 =?utf-8?B?UjRwU1N0UnJ6dEYzRkRPVWVMVmhpV1RiaDNCM3dpQmxHSFJ5elBveEZBMHpY?=
 =?utf-8?B?SGxZSUlINDBGLzBxcG9pZkc5dHRyaTFkek9GVnJIU0F6UGc3aXlDZFgvSkUx?=
 =?utf-8?B?Lzl6S1ExTndoUDVDM1pIOS9LT0M1b2JIVGFIcEExcEdFM1FGN09uckIwcStQ?=
 =?utf-8?B?OXhpMklDS2h0eGpJNmlmN24yUllTZkhJaitHbmlJY3pMbVJSaHBncGswL2RF?=
 =?utf-8?B?Mk1qMkwxSXhyU2VNZ1p3ZzB0Z3RFbnpwQ0RkVTM1Tk45b0VXbWlNNmxSQTJH?=
 =?utf-8?B?anRPZERuTG51VEpyQXJabllLZEhWWGgrK3dpb05sZ0ZIMjgzODlONHpNWDlR?=
 =?utf-8?B?dnhRWEJ6eHlFVFIzUW9jQ01BaVVocFJod3VzU0hNK0pQRkRveDFGYnZqM0cv?=
 =?utf-8?B?ZlV4M2ZodHNLQ1JJQUNLaDJpTk9kSlVOSitrQm5NOVZ0K0tTUVpFRnp4aVRn?=
 =?utf-8?B?QUFQL3dZL1plMUhLU3Fodk4xL0cwSUY1NFpWblVFYWFQTjQvNlFWVFp5SGpG?=
 =?utf-8?B?bjZCNlh5eXFtTzdEY1podnl6NmxpWGxrR3NZRWtPQ2tDc1Q1SFJDOE5lK3Mx?=
 =?utf-8?B?OXFGSWNuVkMreEc1WEsybTc3bXEyY1RDQUhwaENTNUdjMkFOZmhxY01ONEtM?=
 =?utf-8?B?OUt0a01OdUYvQTNWYUtrUzNJWll4NlAzZWZTUTJFTUlueisxRVp1MkwzNHl6?=
 =?utf-8?B?ODd4MEdlM2MvWk5oRXR4cFozSUs3OHdXZDFna0lrOUs0cXFMc1BzZjJsdmNu?=
 =?utf-8?B?Y0k2ZWE0VjdzaUE2eEFmd3djU0pKbURNOFJTV3hoRUl6b09SdkUvUTVjUHNj?=
 =?utf-8?B?WEV6NGNINXFVNk04RTViNFRJU05TdjFtTlNYbktwYWdYV0hLUUlSTHlLZ3l3?=
 =?utf-8?B?T2dPU29XUkR0Z3o3WWJkSVZjeldINnROb0ZFbWJVT2lWaHl2T3cwNWJpa1FL?=
 =?utf-8?B?Y0w0bjBxOUNZYWNUNWpiUVc1Q1BHaGM5M284Ty81Q2FRYTVXUkJnYk9xdjBO?=
 =?utf-8?B?M0VDVVhMakEvcDh4cktyUjlDNGFZVTdIVngvTTVYRnJCU2d4TDJkRVJMSm9F?=
 =?utf-8?B?UnZ4T1NjNGYwSkJNcTE2T2FveUJERzBBS2JnVDErdWVMdUhva0pjTUN6NC9H?=
 =?utf-8?B?WXZQQnBORUhiQmVkSm5NN3FucitxeHhITzhUNHZDZDRZb3dMWDl5d0hzblNt?=
 =?utf-8?B?SDZ5aFhzRUF5c2JmVCtSR0NHbnZwdEtsNWtZZVZnYUE0UStjRmFGZ29BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am9EeS9qTU5Pd2tIWno4OGZtek9aMk1kZkloUVNmM1dBVUExM1lPY3RwOEU1?=
 =?utf-8?B?RStic1RIYlI0L24zWDBhZ0ZCN1lyWkhrSjRxUXZhTzdEaUJQM2JySGhIQWZr?=
 =?utf-8?B?dlpaQmNYaDBFNkRGUU9CZDJZOWdsU1NlYy9OcjRVbWNmWXdxQ01PcWhoOGJo?=
 =?utf-8?B?U21yUGlwNkl3a1Y1OGhIL3VrSXM4dVRYaUVyNXpOUldUTktyT1QrYWtlZ0pD?=
 =?utf-8?B?MTEyR3IzNWU0K3pJalAwT1dPVWJTaGNSbkh2a2FEOFJZKzF6RFltcVNrSmZo?=
 =?utf-8?B?bVdRYlVGYWZUN296YURQbnRsRi9JTGkzWVZKcHlUcWZBUVJSakFOTmRMeTNY?=
 =?utf-8?B?Y3ZVaVdVYUh3ZzF4dVI5Qm9YTWxnZXJGV2lBa1J4d2E5Zmt0UC9YVjBweHVm?=
 =?utf-8?B?ZDMwVEgrdVBIRWgxWjVtVWNnNjB3OHQwWEYyQkpKaloyWVdkTlM4WGtCS01O?=
 =?utf-8?B?NGRBRnp2KzJLOTVPclpyZVpDd1M5VWtYa2FNcGFzZ2IzeXp3ZXN5eVg5aFJG?=
 =?utf-8?B?S3Q2bUlLSEpkZHA5eG8zZ0t3bFo2dGdDdDVyVnRuR0pBbytaQzR5V0NzbEJG?=
 =?utf-8?B?NUV2bm9NdmlPdHBLK2tJRE53Z0RSU3dyS3BldDg3QVlTaUtvVWhFbTBGbGlo?=
 =?utf-8?B?L1lpcWV1KzBrM3h6Q0JkTUhmbU5MM1QxTWYwa2xBM2ZTaHpqdDRxc2dPMENK?=
 =?utf-8?B?TnZBUWFlTFZTbTM0R1JZbzJlczVZYmVQQjl1MjZPSVZzZ1gxRi9qaWd1Zmh5?=
 =?utf-8?B?Z3Q5NmZrKzhhUElKMXhxZ2lTcUZuK3Fka2hzS1ljWThPNFd2NTMzM0hBUXVY?=
 =?utf-8?B?UERYZCtVOUZUa3lsRG8rRjl4dUlqdUxmemtLNXNWc0RWOXMxbjRmaWYrMGZ5?=
 =?utf-8?B?azByTDlTWnp0Ry8xUDZseHA0NGhFZVRPTytXSHFHSmZkZ0ZVSDNqQldSbW9I?=
 =?utf-8?B?YUxUbysyWnlmYVRyVUhvbFBYWEVkWmo1Y2VqZjdmQTlzOUVnYUg3SkxSS2sv?=
 =?utf-8?B?Y2xwTEpxYXFiWi9zR1FvNUdRNmhFRXVPdlFDUUM0NE9ZNUQ2R0lSaUNwL3Bw?=
 =?utf-8?B?QUZKMUNpTFB6VmQ0bk13TDIzS2ZnQTRYVkUyY2I2eTUzdVZZbFRJMyt4cmNU?=
 =?utf-8?B?QmEzZ3JvQkcxNzV3a05iQS94Y2I1STh1enJZaTAzUjd3RjJlbWhVYU8rQmhX?=
 =?utf-8?B?enNRSzR2S0ZYT0diTVROeEIxMzFnS0pNQkoxY0VzTkFUeWlhVlNNRkc5Y0Ix?=
 =?utf-8?B?VzFwZWNHWHBqZjVPSG9TMUJRa0F2ZVRLL3dyL2NqamE0SWdlNlA3MVhZRVJI?=
 =?utf-8?B?aHNhbWUwWnJzaDVOaURYN2xyVS9YSUJiMVErMWFYNjhxYnF1eXF1YzdVQWsv?=
 =?utf-8?B?YVpPU1dmQnFHUHd5b0FZM1FIeFRRYVdIMlVtWHQ1enF6OUVqdGNWVytDbXA1?=
 =?utf-8?B?ME96QjJ4c0pLaWs3SlBkZDk2NDJVMXgyN1dHUFcrc2gzYktUcUs5ZmRIZ0cz?=
 =?utf-8?B?L01LY1VzUkZ3VjZiekdQM1o5UWpYRnJFVzZxOU9XZmpVbVVVMC9QSDdseHMr?=
 =?utf-8?B?NUJuTUFvaFkwcldaZHBNeW5QcDJOVDQzZFVRZFdUdnl6N2U0Y0NjdEFhRitD?=
 =?utf-8?B?QUF6Ty8vUE1SV1NLV2NTR21JclVQZ2hxa242WTFsVFJ5UjlhSVhEbk5zRGxj?=
 =?utf-8?B?S05OaDJGRVY0NkZEdFNINnhGRjdXMkhLN2tVRmpsbXJCS0IrWmIwRzA3b1dX?=
 =?utf-8?B?R1pIRHowb1N3Umtldk9kditpMXZISFlhemNkdnQ4NUpGUit1bTg1QmNoc0Yw?=
 =?utf-8?B?L283OU5CR0xiMEVvRWphWjlheTkrclFrV0hqbG5wYlAzVWh4Z1hDUytuUys3?=
 =?utf-8?B?alRuaURXei9sUFdoWTZ6cEliQUp1Nmg1TTcxRVYxdmczSXNueWl1OFV3OXBL?=
 =?utf-8?B?YThmZ013T0tNdUV1cndCQXJRTE45V1hJMjNFcnFNcmZVUkkzRnVDQUdsRlUr?=
 =?utf-8?B?UnMxazQrY3Vzamh1NGI1QVV1c1NFbkhPdi82VjFPc1dKQWU4VmtzZjlxYnZZ?=
 =?utf-8?B?T3gvSEFBbjJ4YUpHWVdCbXdkNTZCanUrNFUzaWRWZFc4MW5EUVMzUDFlQ3Ay?=
 =?utf-8?Q?M+jMwJpQyXR45v9WCMUEjdHJ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ede77-c9a2-4ca2-cc64-08dc8445aee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:23:20.1257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iBl69mUeWheOgeemUZrf50d42Rgra4wCIkZYc61oq04YTxwV5miqohhpgFj1BQJ5ANVwzaRwkI+2SUuL4rpB4ueLbMZtP7GUhKxIKGEyzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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

SGkgQ8OpZHJpYywgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0gg
djYgMTEvMTldIGJhY2tlbmRzL2lvbW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNs
YXNzOjpnZXRfY2FwKCkgaGFuZGxlcg0KPg0KPk9uIDYvMy8yNCAxMzozMiwgRXJpYyBBdWdlciB3
cm90ZToNCj4+DQo+Pg0KPj4gT24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4+IC0tLQ0KPj4+ICAgYmFja2VuZHMvaW9tbXVmZC5jIHwgMjMgKysrKysrKysrKysrKysr
KysrKysrKysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+
Pj4gaW5kZXggYzdlOTY5ZDZmNy4uZjJmN2E3NjJhMCAxMDA2NDQNCj4+PiAtLS0gYS9iYWNrZW5k
cy9pb21tdWZkLmMNCj4+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+PiBAQCAtMjMwLDYg
KzIzMCwyOCBAQCBib29sDQo+aW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZE
QmFja2VuZCAqYmUsIHVpbnQzMl90IGRldmlkLA0KPj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4+
ICAgfQ0KPj4+DQo+Pj4gK3N0YXRpYyBpbnQgaGlvZF9pb21tdWZkX2dldF9jYXAoSG9zdElPTU1V
RGV2aWNlICpoaW9kLCBpbnQgY2FwLA0KPkVycm9yICoqZXJycCkNCj4+PiArew0KPj4+ICsgICAg
SG9zdElPTU1VRGV2aWNlQ2FwcyAqY2FwcyA9ICZoaW9kLT5jYXBzOw0KPj4+ICsNCj4+PiArICAg
IHN3aXRjaCAoY2FwKSB7DQo+Pj4gKyAgICBjYXNlIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9JT01N
VV9UWVBFOg0KPj4+ICsgICAgICAgIHJldHVybiBjYXBzLT50eXBlOw0KPj4+ICsgICAgY2FzZSBI
T1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUzoNCj4+PiArICAgICAgICByZXR1cm4gY2Fwcy0+
YXdfYml0czsNCj4+PiArICAgIGRlZmF1bHQ6DQo+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiTm90IHN1cHBvcnQgZ2V0IGNhcCAleCIsIGNhcCk7DQo+PiBjYW4ndCB5b3UgYWRkIGRldGFp
bHMgYWJvdXQgdGhlIGZhdWx0aW5nIEhvc3RJT01NVURldmljZSBieSB0cmFjaW5nIHRoZQ0KPj4g
ZGV2aWQgZm9yIGluc3RhbmNlPw0KPg0KPnllcy4NCg0KZGV2aWQgaXNuJ3QgYWRkZWQgdG8gbWFr
ZSB0aGlzIHNlcmllcyBzaW1wbGVyLg0KSXQncyBhZGRlZCBpbiBuZXN0aW5nIHNlcmllcywgaHR0
cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC81MzMzYjFhMGFlMDNiM2M1MTE5
YjQ2YTFhZjc4NmQxOTlmMTAzODg5DQoNCkRvIHlvdSB3YW50IHRvIGFkZCBkZXZpZCBpbiB0aGlz
IHNlcmllcyBmb3IgdHJhY2luZyBwdXJwb3NlIG9yIGFkZGluZyB0cmFjZSBpbiBuZXN0aW5nIHNl
cmllcyBpcyBmaW5lIGZvciB5b3U/DQoNCj4NCj4+IEkgd291bGQgcmVwaHJhc2UgdGhlIGVycm9y
IG1lc3NhZ2UgaW50byBObyBzdXBwb3J0IGZvciBjYXBhYmlsaXR5IDB4JXgNCj4NCj5JIHdhcyBn
b2luZyB0byBwcm9wb3NlICJVbnN1cHBvcnRlZCBjYXBhYmlsaXR5IC4uLiINCg0KU291bmRzIGJl
dHRlciwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

