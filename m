Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A995E10A3D9E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5wx6-0001Rp-7X; Thu, 26 Mar 2026 22:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5wx1-0001RU-KZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:29:32 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5wwz-00074C-2M
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774578569; x=1806114569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hvgz7QZ/UkFvwzAlmnm2ESB4rGcedq1pA7/JGE7HhSk=;
 b=AFhRd8AOOVNdO8Dfxvb5i2YWh6rY7A5hpYXHsBK9zCXYS4PxSbRKKMzy
 cjZWe8e4SYi/3oV3PGRaQbbmccXN5ts79HxUzopbGy/67isoqjEO06NDM
 uU7eh9pbZFUR9f4ZuPiHByXIzY09K+AFtjV0vCXKjO1by3Lp4S3LhO2GA
 Wo1lEW+lQVBa5gtk/3ZHUzFbRWGElnP75THYIOuWcH6fgXnEelCXaH3eb
 UnR6pnF7wWYk9JRI4TLfRY/XVI4fuvDhRmj2XpHvy/wRCHSy+QJ8gIZHY
 Ng9JkdKiLKuy2kSJle3CmAe2oeRc+XzXch78T3yt0RujjUxODM0CeD5y7 w==;
X-CSE-ConnectionGUID: FbG7UQapSGagIFurjcW5tw==
X-CSE-MsgGUID: Xl6aCKGYSH+R588IycwpXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86270614"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="86270614"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:29:25 -0700
X-CSE-ConnectionGUID: Wpj6CEhITCCV18ugZZDk2g==
X-CSE-MsgGUID: nlquwyDpSTulxD4SDRtRpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="229960770"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:29:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:29:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 19:29:24 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 19:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaR8mN5W3C8TyJL/MJRrCMn1rBCq+UK0uhacBQ7qUr6f2ZLU4YyJhPzvtW5GY/CQHs4w0r1C2a+4GAL4r0eOxZbJL+HsWb1JoRDSJFN/dyZ6zbORqNU3l9S4pDrDXS98poyxZc6xunx3dpUZU8FaaEUk4Jz/rNblEcQlSpwtbTHa3Ee1ChDeDiC6x47d+wkR49/z3m7Wkk2K/leSD5bb8+GQ1mT2lUS5MH6dAk7dEt6m6T4Ysh8J30nE92bD15QRtbjr3oLcUTgmFKo/KklcSa7rVYQQefHNHHIQD5hfOMcdNnqyQyzbJojkuAw/ljKRmB8g0jv/nVH/l0z/88cyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d43Q8cHoyXE1SezkvIL7bUAwYWcHVhFM4YSYjP25Po8=;
 b=JiV0Gn15flQ4N3k/Ty8VYz8ntxAGOg4Vg12rEnFvYL9J5IiHwScfYi5EBEUJY8RSa1/00KePaRYJaSg+8R3PVL5Bp/8ed/MFI4PhfuDPH8JpISNBA2HIjsh3MCMR00IVAzavQdeo8/8YhJeVyJ4cOrxe6XfxFjdtui6BAgxzBv1Wk7mFPfUSSKxQSx1O/S5heGyuBVkTQTSolVYrF8LDiA7N3zeRWwNQ6IWs56ylF/QdIb3nn68nsFgbIke/x9OyVyEqZfQ/FZnp70FX2PrG78VtV61rCExwtJLlL2Wmg4mEcFdzngDTgzCaXLIfMHaDK6x4tJtyo0OFktRius/L1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 02:29:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 02:29:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHcvQCbcM1XVclbJU+X+K8SR/ZCtrXBbNSAgAA6gOA=
Date: Fri, 27 Mar 2026 02:29:20 +0000
Message-ID: <IA3PR11MB9136D7618C06EFF1D66561549257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
 <acW5AXhPDT+wZ2qf@nvidia.com>
In-Reply-To: <acW5AXhPDT+wZ2qf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: 0fb57121-6630-433b-aaaf-08de8ba8a70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MHweF/Wuk+WKOPoIvyagT69jadAnU61WIFx8Xg1315bnfTCbEy0GUputsaNxbZL0pjz8LgafGMHMLrW6BHVFdwnCJCuuU1WnIbLs6b8XJfLN4vo6TIp2+ujFv8odLYforPwPNfH9EE9D2FFGp0CikESuLi9f8elzgBXn0rYcu/QJLUvOhbnl0sziCq2pxvC3+VkWnhMYxma1wXmdlJL4t9esP1YXT3/GICFKedM5wpscub8cVjhrNDTvmiQJ/Sl18G+/JGttQ96evY+Slv1X/iWN/iXyGcwqeV9NO+ir2ajDfIMy3nUp3144XENfn/hnR19a0TP9GH0WWTEKDYfGloiE6TVnJgK42m14buwrzXHIcSBizbTi9QtmcLf3QniAtOv/BfSlXT4/flnUNBSXvkK58cuMd6eoupgZY3IiGFHn0OKlcIX3Cohev+/qm0Wi35I7xZaQtUEwpCXhV7HDSD2i3YYPnWGPgZwDT1FbFOdbtHsbAxdvvPQFipYsz2OZxdqC07SI4g0L8WZAIK0NoqDWAJV9MlbT98p6bDVsCWbxAh/crfDi/S2NNKfLHKHiPSzVX2LEFz2I93rZWjuKc8ZHhy7LCcsGgSIZJHS0dyyMll07K2jP3MGTrcmY5VFSvU6QmrAfmGxArwfvt0caJQpM5x45xg3Y7aFWxdM203OEqTHd98L9prScDvLdesnUlDH9OzIWcK8xEkRtySjcpK6wWALmyCsPOV7lYHWPWQP4KVS6xoC+HTtL0AooD3WoOYMudcsrtylxkLIMJF1WnqjTSLW0yQVQkbTJTYFtOZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlmayJh7h8/gUY3DepO16HHi6u+jqDa+ITrTq4Oxb523MSkEhrNPRgjFVsPy?=
 =?us-ascii?Q?MgxpKpnVzx232kY+IcjnaFEy4ELTkb11hdzpG0BksETbiRgxImsZ7nTlkE2X?=
 =?us-ascii?Q?oCGX5dmTNQYc/23uiaaqXvWg66f27bDMJR3rRZOtv7cDCBWOtC8zG4CcMoFU?=
 =?us-ascii?Q?oNXh9ox5+MmTiExbEA3LTaZPM276RuHWtiK1krkKolFv4mXbWXWwS2Et7Ct1?=
 =?us-ascii?Q?iN2crpXyeM6vlwOuq2F0yrGmmgf1TdhxtueU0upGAljGYtxLvgPUuOnE5OgS?=
 =?us-ascii?Q?JAIadexjh9HhFslvwRrMMME7lj6wYEUQdAUpFuI1YKFRAJc+2wqMQHw/7UcK?=
 =?us-ascii?Q?uoLQoz5pD+HqwFe8qLPl6kb21W0QLTgzS78vjdVRRSkksKJX3cKh1lkijF22?=
 =?us-ascii?Q?6mzCeAEBcf2PRYviJqh6hgw9TnbM4fgLYTwtVY5sq/DKZwvfodm01oi45AzM?=
 =?us-ascii?Q?+TBOILsdgWZ5B4rQaVhrEBCAbbzQMTmI0VtHrGpXjVM8axT2YhjD44iEs5z9?=
 =?us-ascii?Q?k06R61696jyFY9mewSkl/3fbEN4eu/MB+CdO5jmdK+ywltXY2nKA6NvxkRau?=
 =?us-ascii?Q?UAbrssV0YufVgEWnST+7AF60LWhXARf1KlR2Ygb44vBUYckaJxPM6B4xq7VA?=
 =?us-ascii?Q?J7EXw3927WBVoGn9FtF02aZi9nIp2u2H3uXBMdrweLqVdf8QTL5Ojx53BPJW?=
 =?us-ascii?Q?hBJJbHuylU5psTlHgkEVWhFfIk6aBH061wr3XTsKf2PdIKGUyf1NXziaT4fV?=
 =?us-ascii?Q?H1WU8NSsnGBtdt6KazFnSePDlht+loXWKcvG+GBqhWkTnPaTrLF9oMTRjb4r?=
 =?us-ascii?Q?jp/fYJDb7X9bmSxAnQEDSFvjD6WTYfk3MAWDcKsV8KItWeHYe8TtEqe2lUHd?=
 =?us-ascii?Q?3FA2MFV6A0dO5NmdoTTzvA3lMQ8p++QZ9EcTmIXIVezVJ3O6zUF9KZ/FD6yO?=
 =?us-ascii?Q?oRqjvVwG45iPvU8kyJLL6zdyX+15oFnGWT9B3Y8eDG972caG3irtAFTV+r9u?=
 =?us-ascii?Q?JhxsCSr9bzAIuArBgg8GVMutNxwUouhxpsysE43QoENQQMMaosor7SFJsYfz?=
 =?us-ascii?Q?8y/RqtMRhBzAdarB/WtcxKxU9nbWAB0wc4tQ9abCdukrJZ0sZR8s3INXcKzK?=
 =?us-ascii?Q?5GO/1noNR4+hMZIb0vE8OnP+rXfIp1Vx2gSIv6QhXOxVg8Z6l2Uu12MqLuYg?=
 =?us-ascii?Q?+GzLWwq44ukMASJ5tqrjZ8luOj5OhbONmEktNj9ht0WwrF2Li7OR3KOIHdyL?=
 =?us-ascii?Q?DENnVZMybfd7WYdbfLC1czPbxyMmTTKOAqBmKvOQGaNsQCPUHoOHKAm9AGjG?=
 =?us-ascii?Q?nSabQMdaQ1wg8fr3UurM0Xssrl/eBZrR76DSCYkXr1yuqFp5MoPVEov7NToM?=
 =?us-ascii?Q?ZbqhZKfnYB1pbDyBdJupoQkGJA5GmSSOxH1xVxlY7gV9iBfHmKcmSyIFc8KX?=
 =?us-ascii?Q?h9TNj7ofYcJEDHhiYyWkuG4AMrtHz0M6u3WP3InaY8u68iMlXXN7b8l0cjKl?=
 =?us-ascii?Q?CgemaM7+Vh61w0tD+d9dp/CE/G+K2AjmHbx4uMvvLa6YVTyNoVMKu3kNoYwC?=
 =?us-ascii?Q?MpYncI22QCyF8WMGbnazOQsA8A5CEGfEtAe0uMq+WbnSi/h5waMJt6lb3r+a?=
 =?us-ascii?Q?/cbKVGSIC8ci7xy5AZ/aP6uC9gR11nTjbXLiyXqTHkJI0YMcaq4FPMqr8rSA?=
 =?us-ascii?Q?1kqOGXblA1vVK5QSZuL6KVidturF5LwlIj3Xeu1aq4ja1PlimI3pGgTz+M5r?=
 =?us-ascii?Q?3k1CSPKpyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tPm/pNWpji+4kBYQrVGZJQREsjeoS7MMwl0r8U1AYBiu8+3Povv8ol91mw3n9FBL0gje5rPBk2GujBLwMkr83xdFcaz17TxOHB1qau7xho3m32HF1zeXp+TNlaU6Z86oqCCOMl6bnrnHP58wAMclZk9HHRgc580a/c0QWALnMrWH5aOks5Q7/SlXXQKhGO93PaI2ZlqVuD18asWy4juZa84kjQhtoq9R0SX7EXmju3tzmDruLNCq5rNVq4gWReSuRdNsned70QATlPZFu7CQR/+LYSYQY22+zpqYFl+KVY4/pJO1ItMNei9+gKujC6bwjx5QDHVhTtwAgyYxQW+4xA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb57121-6630-433b-aaaf-08de8ba8a70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 02:29:20.6402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDahPjeBodf0i5IJOfz6AmnwQ8NoWtOi43/02ksh1khzO1aXLwl9fzJe3uwHWGzdbb2wdtz5J3f5Cdi//7aPp5+1LovRgti3cLpyIwqf+OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
>Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt wit=
h
>IOMMU_HWPT_ALLOC_PASID flag
>
>On Thu, Mar 26, 2026 at 05:11:17AM -0400, Zhenzhong Duan wrote:
>> @@ -430,6 +431,11 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>          }
>>      }
>>
>> +    if (max_pasid_log2 &&
>> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
>> +        flags |=3D IOMMU_HWPT_ALLOC_PASID;
>> +    }
>
>This would set it to:
>	IOMMU_HWPT_ALLOC_PASID | IOMMU_HWPT_ALLOC_NEST_PARENT
>which isn't supported on ARM :-/

I am a bit confused, if smmu supports dirty tracking, flags would be
set to IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT,
in arm_smmu_domain_alloc_paging_flags(), I see it will return -EOPNOTSUPP.
So how did smmu work in this case?

>
>The VIOMMU_FLAG_PASID_SUPPORTED flag is to allow PCI core to expose
>PASID cap. It feels like we need a different VIOMMU flag for VT-d,
>e.g. VIOMMU_FLAG_WANT_PASID_ATTACH?
>
>Thanks
>Nicolin

