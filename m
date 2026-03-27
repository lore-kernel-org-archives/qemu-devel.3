Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A70910BA432
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w60xX-0005tp-VI; Fri, 27 Mar 2026 02:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w60xI-0005re-21; Fri, 27 Mar 2026 02:46:04 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w60xA-00069x-7h; Fri, 27 Mar 2026 02:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774593956; x=1806129956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6gvQe9l5b3KgHl2eNoN002s4IGQ+TJ1vV+fI79rxKGA=;
 b=aIt2QMFlr9nQFwAyEtVu6jVTD+xaxNfMAWKUmg7YcClCJo6D2Hh0vcK7
 0Neyzc73uwzRAfoN3ptztGJO+YgyDMQi+VA1tUp13Lto52kk28hKOTJ/s
 r3AxSd90dc0ZA735Q1tJwnLnQWOK8ofrZeRdjEjaO9D/rBunl9nlThhFK
 ELWIdGd9YUqx+i9rR5Ew0KbtT0jZ4v3qe6dOKs7xF3yHyQMQhCMPu133K
 2g3U6SHHxfCnUhMGxJg1EWZGuVue7/Bqd4Iblt1ABBFcZr6aa6UokgBeo
 GgjRU0wK3r2oa820Lpn7hEaisG7LTej4tQw4MD1x6nX8xqyn56DqL0NVh g==;
X-CSE-ConnectionGUID: IjGK5qlOT7WncCs02k5q1g==
X-CSE-MsgGUID: VD93eSkTTg+01KT18tNndA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86739729"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="86739729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:45:54 -0700
X-CSE-ConnectionGUID: w1nsC2xJQZSWR/eAYioIpA==
X-CSE-MsgGUID: JDnrUZ58TBa3+JHGNO3mOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="248561608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:45:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:45:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 23:45:52 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTRLje2Ig7ojO/aKyAwkvhN9StrGFA863YSFBZ67alnVUF+pP1kiiXYpCwlwJWIP/I3oc8RxgfeavBYEm3TRrMHDxM/B1f86eYuvP7rlrGa8gk2bcIt4WuWhjoAmU7GH3M6cybJGvrIKltiCIN4yZ36WOwn2K6VJNpLSTzX00Bi2rRCxkN2yRvpRitgRyDCgyL4BdgEPKjIBYwXLVI9MVjk+3lfM0iB622ft5D7OEJDq/XlVek5CdF348GJpUXnvkBpyIFWK2yNZnh7dZ7p346+WRGWTM6zmkeZTPZe1iSc1UIkGOY6sF52tRcb1PXuM+4hm0BCgwaR6ZPxtaqkLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY7X73bshGHd5DpATxRomxbjyfrdNaPVpunrQs911nw=;
 b=BziPLg2Be6oP6obYXfGcAHEUh2d4559oKquAwfPTKshP0oI7jQGMGarfzBrbZZQa2AFSZfm2AdCKgzTS9xh9B8Y9vBkS0mQFT2DfItjO3xiwDYDBhTo9+cNBplVpmuW4AegL4HFF8gx4+vruTTa/mvJSgD6bgtHsGmVDl6gR2m7lyT2RpOble47sJofBanAGA/r1trVK6+pNo8637oqCx9vtHG4H8mebuQkshc/F/Sa240WAs8IF+9yO9KMB8K9pB1n6oDuosjIVPBZYLG9Nq3j9Il7i0O7xwadtDyg5Fkdwl5GLYdFxnYULPpC7RmpYTuWiPfFSL/psdAOu0w8nzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 06:45:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 06:45:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHcvQCbR71K6Acm9EmcQazKuEj1x7XByqeAgAAbx6A=
Date: Fri, 27 Mar 2026 06:45:47 +0000
Message-ID: <IA3PR11MB9136996CF56E60E4C8D08EC79257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <953db036-af16-45ef-89be-40fdd5d2b52b@intel.com>
In-Reply-To: <953db036-af16-45ef-89be-40fdd5d2b52b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7975:EE_
x-ms-office365-filtering-correlation-id: 0735075f-390a-4989-f8f4-08de8bcc7a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: e7r9d5xPiNPfPXhDxwKimRdpgOs7EY/bdnsQq7UU9g6ghnEF4dQdFm10CKbwljVzdvUrgI2af6kqGr9seNCvilbm/7csp2c5qwT1wuVngiHSGDWJLXJgIQhcrWWT8ilJqBrDDlx9Za16U1KOD0IPsjsTRwkdc5A5a3TSMRFnNKT2MOfPMvOlJceMw6hfo0+qSwgxO8d0kaWg2RpRsTXrweCFy2E7Y6PZ4A76QBZzTuO2YZoN9f+Fuex+x63h2ktsTimwkuQ7sRc4GrAv3JFai5VMTON1rtyLJSGhp3EPyU6uBIOjY9zREJDyy9K6EW0KPM/mGDt2RknYaxLC121347zQtA7nQ79vL38g9qOere92xPhrf+XeYOooMo/15doih00h38X5iCuG0aKg/cugdRH7zxq92cWWmcWIRdNzKWw5GGj8avCADgomgnAsHSsmbVWuwoziUkRGxlZdOG6MThlOsIW2cOa7V5xAREOnWtao4p6yQh3/Cmi2ew/ZDFQL6G5tqlv/21neru656cVe59hqyaho/lON7nO7JzgKN/ajFGoAOX0t9sgXOt2mfwjcTnPZ4Mlgs6SfjpA0Kfjg6kHHNPdDcGDDOHqD7Dh1uEaza9Kt0a81h7caveJ22QHlR/EvBMuGBeOlkhPZmK5ofFcFDb4EKaXu8PNbEF0JnUiiKbINTx6Nd8fS5r5F0fYO/X5Tk3uNBDceQ1qnzPYQw/VfWTczvVv3svqMFAC3B+/7vqCKrSbqwVjfCbztylK2qHPpe+wyxWdi2FiVxN0Gczwm6GtjmpXIh8KjjbhO7VE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PW/i0mGGOqI9F3m+wWc8xmFbYnvg5FV2B7qxABnd/bf4y5+odnk6wLI0ZwmN?=
 =?us-ascii?Q?wg+h5lw+kXWJ0sEx99Na9Xvqx9fb5FkhDFzfzlk3RRKZUvYqLWBDEQn+VI0p?=
 =?us-ascii?Q?g1GXTH0jTY9i3qJ1tK9OVRlkdzSS3z2FOryu/c4kw4X6Fc1y03Y6V23SpIiu?=
 =?us-ascii?Q?zBrqT6JvQ9jtFUU3dd5FNo/aX2vwgqg0TcQXmnRRgOUb4JPH2Lo+2uZPaXUI?=
 =?us-ascii?Q?AfUWoSqYXpIlkxnewtcJ07QuJSb1rotOq3DV5EELJJ3eEwdAl+yFtJyBy32i?=
 =?us-ascii?Q?tgiDENArITJ22t1/QMeNIlVay4J+ZgQqflPcrJ/UdDBiXxkOnK5cJxfcIUjW?=
 =?us-ascii?Q?jWg/pKxFSDSqEBHdaBGBabp+7nJkbWla48+2ywXBEDy5lIan5tLnhlPK+5IG?=
 =?us-ascii?Q?X7f3CFrxkoFO1wq0FJKq8e+Y/BR7ogZbvbl52rJTqzef2iOTERXloTN5DGMd?=
 =?us-ascii?Q?OymoUyN5NEtwLPRLWfnXL9Ej8I8qFoGEpbhLlijhxSLJQmQ4XMaZz5WlcUFR?=
 =?us-ascii?Q?2V+SwYkr8Xc3tU7aw2XtK9Fw5hl/fqUeZnDP+59LWjG7P/0pNf00qBk68KA1?=
 =?us-ascii?Q?pu+bRJR1chFOozpqIujubFGzqCL6ZJAj511DRQs4HrctBFbU1quq1kBFBuoZ?=
 =?us-ascii?Q?ybGyga7GUtc1pKu94/ChyZm/lVASdCd8YWQvE/rZ+4zcw9ZDqn5QuZmt6muI?=
 =?us-ascii?Q?XwKtVJsEqamj5nez8YL5xt5wF1RU+jqDFt6+XrkEH1jwuQU5da6zqHNwxBgE?=
 =?us-ascii?Q?XDyrqL+SftCdKxrph5DIfPCxfbvsHFfmAKmF/xTVLMhsjr5uhKne5dDGrZpH?=
 =?us-ascii?Q?Oz5Tla3VDlzyF0DRYlm1lAinsttbmnpN0RG2ovc3F9xSbPiLySMkysUrr/Qo?=
 =?us-ascii?Q?gUh5Z7Yj+WP7FJ67ehndNL6gkNFuGjez91dwBHS67u5hE/PKA4wxQrPzBDLC?=
 =?us-ascii?Q?5RGCvQ98gylfHCpc1nF/wNhRQBbmozGm2G1E3fJOw3WSNA9IT5w+SwbY04MS?=
 =?us-ascii?Q?CaZClWj02t0fnJFJiKRDxcqo2xGZ/+gMjyYwGDzTbsCewVT6IM5Ue/qsx3aE?=
 =?us-ascii?Q?wwwi9MKrOyUD4ZQqv1eBT1OOk1/I1jBVNbOg3e6U/xgs7Zdxl1eYmwM740aR?=
 =?us-ascii?Q?eUIvm3eUj4c8yc9lZPmDtrVCzIL3gUN/KFY9kZBOKnbP9RFDnrxX19AU8R12?=
 =?us-ascii?Q?80qZxAmIhKcuAVvV3x/mRxQvoEksEk5ZU3684x7+YZ6FbEnKAKFS++YiyaR+?=
 =?us-ascii?Q?jbqsYGeIcTdcyusC2epXj+zl6gG91bBk/NmyAOg2U3rMKl2G7iMjqI+wngGt?=
 =?us-ascii?Q?jZ1vvm7CX7a+sSJNxtOodGIiQCPCNbCVZifFFbmnAEyZCiflNL0N5/tJC4yP?=
 =?us-ascii?Q?pWMMO51/DG6l+kavebN1af5hs0/SCFRzQplsvGn0BtizJYIMh6Raah7nm0ve?=
 =?us-ascii?Q?eXvKRX/EMzfJt/TsKWVqXB1DDfJF4cetW6k+I9yYfwDdIulXuw8OSaFbJBV4?=
 =?us-ascii?Q?9bjGbO4kyWJTeUBbcpZ8KL2YDp7EUWqyhOAcR/V7eYwOH6SJKOS9fX4JdQEG?=
 =?us-ascii?Q?aP0dW7S/1Pl4+s3I3PXflVCZ1z+Iaf0EDtEbfEAB7a12C4yqIdhbh2K84Erc?=
 =?us-ascii?Q?29acXtVkq9IpkF9qb/lD43JGSKSWrcN5QiMM+HBhhuy4NFWnh/82EK80EwVj?=
 =?us-ascii?Q?aCbZw6ZfFpdzVw4a+tUK5q6H4O9omTTZ9MDRQn4bK2VlHCZDfl0C8R2ymM+t?=
 =?us-ascii?Q?i/ilVJMihg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WR8Ff59tDRF9Jw4oK71Ov4Ha58hOM6u59NaFW8nZvYZGlqRr4SPlyNrBcu3gXVP8pvZDP6oyQD9m2tUBJ36WvZK0cGV15Evn46/6IwjkCLAkqzgviBo3X4lndIFmCrLaUMZS8KqCIAq6leK8UNSyJUWUosWCDrDNIZLPt2/kpldcFi1Xppnf2Rjr5iOK5wNxTnVCTuDS03Me6R5CuzhvZ8I8OGa+VzC7AjZtIWCNcHGkiOSP20m1fLVnXjF/8mkXTAJ3dPiAOfrh5JZc5j8PGH8JqtrfYdpSyXqnR9UQNT5y1kp9pqPLrQxqZKbc8uhLDg2iowja3/o70rVLC4tBBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0735075f-390a-4989-f8f4-08de8bcc7a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 06:45:47.9153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCMyP4Dt1BnsyTWEwyj1Qog90M+4UtGE4qC1l1ROhx83Dr7WKcbxIvVsGj7IV8vAaU59CxoaiAPj6YtBDtNx576Rv7MMKW6IesfalCgdOt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks=
 to
>support pasid
>
>On 3/26/26 17:11, Zhenzhong Duan wrote:
>
>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>> index 67d54849f2..45c08c8f6f 100644
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -121,7 +121,8 @@ static bool
>vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>>           }
>>       }
>>
>> -    ret =3D host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
>> +    ret =3D host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
>hwpt_id,
>> +                                                errp);
>>       trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, =
ret);
>
>The trace looks to use the wrong pasid. could you make it use
>IOMMU_NO_PASID as well? Same to the below chunks.

OK, will do. In fact vtd_as->pasid always equals to IOMMU_NO_PASID here bec=
ause we don't support pasid yet.

Thanks
Zhenzhong

>
>>       if (ret) {
>>           /* Destroy old fs_hwpt if it's a replacement */
>> @@ -145,7 +146,7 @@ static bool
>vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>>       bool ret;
>>
>>       if (s->dmar_enabled && s->root_scalable) {
>> -        ret =3D host_iommu_device_iommufd_detach_hwpt(idev, errp);
>> +        ret =3D host_iommu_device_iommufd_detach_hwpt(idev,
>IOMMU_NO_PASID, errp);
>>           trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
>>       } else {
>>           /*
>> @@ -153,7 +154,8 @@ static bool
>vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>>            * we fallback to the default HWPT which contains shadow page =
table.
>>            * So guest DMA could still work.
>>            */
>> -        ret =3D host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_=
id,
>errp);
>> +        ret =3D host_iommu_device_iommufd_attach_hwpt(idev,
>IOMMU_NO_PASID,
>> +                                                    idev->hwpt_id, errp=
);
>>           trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->h=
wpt_id,
>>                                              ret);
>
>Regards,
>Yi Liu

