Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ABAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTNDy-0000Mb-Gc; Mon, 15 Jul 2024 11:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTNDq-0000Lu-Q5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:02:38 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTNDa-0005p6-86
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 11:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721055743; x=1752591743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QKrgKGunbCG4B/sh2MSUwBhgt1YWr7UbSdUDpVuY+Ko=;
 b=KouMJH0IX1FHI9J78Eb40uFJjuIaNgesQzC/t1n6hGbnmGDiE/IERw6x
 AAEkmb6C+OHwmSqKA8n+KZwTTxn9yv9t1m6w7wsHpNF9yR/KKx3pCvigj
 EPGW5jq8hYnrQijSRpYPrj1+42GbUrj7C7m4Jb6Q5VRjZ76pttOPdG8ty
 qCyxVV6GXGk18rL9eB6DpXZT/bCuQ8hoWWWTIhzCayGuZuW38VnTHrvyB
 aPpjIGClngMb0ksBxrrbroRl1cwIreu+Mo/hrDC9R9mIkVXEc4ftIzixi
 YK5YEZk2zif5C//FZ84ikD3QcQwurgQsFty2K5hVVX2bmB/bnu/Q1PicB g==;
X-CSE-ConnectionGUID: d2q3Zmo6ROupMi+DLRSx3A==
X-CSE-MsgGUID: bGPwTIA1T7ywzDdOVurb0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18056411"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="18056411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 08:02:18 -0700
X-CSE-ConnectionGUID: /XKp/ch1TRmUN0EQ69eLug==
X-CSE-MsgGUID: tIxcnrmFRhWldAlc9MnQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="50017246"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 08:02:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 08:02:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 08:02:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 08:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETWBgClm7lRf7kMWWbYt8mB0k2PRkD7yslOYzCp2H/Caq9BrmqBOVOFSSnEsMHQnZu9ZA+ZB8fBErQS5hbGq2Q9LD6ftA14fXfttlBEvAlodcVpXzSa00a+AeO0BnFiyQcU94y1ZXqAMtCl12Jvc3vAVYgJyhu4Luwxko+xZVITT/cOuCE5rXHgPUO1bt63X4pKx2KVIRsJoo20bUYSjbqYICgZ+Uz6yWilJFtcHTpoTNrHxSoY3jQ2tcHpGEI8nA73aVm/D3iNLrxOiykFZE/b7k0Gv+DxV/zCBIyMsoIuamQiSQHGJ0h6qU70It18qTk2nZVzE33UB4bTceempCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4zQRKm1gAronWf1RMUU4BL4ZmopjmeeH/Ira9nzx6E=;
 b=Yh2mAe/9OjU9+8M4yi7rVlMgwSNf7knApHVk3nMZZH8nimTPrPy7rPC8BRO+z9zwVwJ7e0D/MDtsmgd86aLFCyEj7kEXKgnIZZ08H6uJmiznP13Wh08t/3nVG6pzjMryKLE4FqVF21hcD4yiYHmhjp9IC54+izZcxG0Qie5VD0M9SKei0VercY0P1IUv3JOxaE1ye98ByhYLS8JUeXKLHXR8DcStR4cIW9oIliJ22NYmuOKLe8kkNoWxxl0sO6nJsbmI+vjJolqlm+YgvQoqQWBpGjPDqrtUbpaFhMxyYqrlDuvzDLZyuhkG7SPRkLkfkbxVpk5mjrHiEoN6gVFSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH7PR11MB6882.namprd11.prod.outlook.com (2603:10b6:510:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 15:02:01 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 15:02:01 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Kumar, Shivam"
 <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, "Wang, Yichen" <yichen.wang@bytedance.com>
Subject: RE: [PATCH v5 01/13] meson: Introduce new instruction set enqcmd to
 the build system.
Thread-Topic: [PATCH v5 01/13] meson: Introduce new instruction set enqcmd to
 the build system.
Thread-Index: AQHa09y9W9RvuwIPEkuCnm0pF++eQbH33EGA
Date: Mon, 15 Jul 2024 15:02:01 +0000
Message-ID: <PH7PR11MB59413BDDA018D8FA67775C9AA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-2-yichen.wang@bytedance.com>
In-Reply-To: <20240711215244.19237-2-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH7PR11MB6882:EE_
x-ms-office365-filtering-correlation-id: 55c588de-5e52-4f77-6b45-08dca4df14e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wl/aEGtlm+JIbt/7K3eFBc/4UwZmWHapXW9/Ci91WfuWC64JcRDJfV+juI?=
 =?iso-8859-1?Q?PWFuJ6GkjvFF5f0sBiT+nO2h6mEUm9cF7vhTkOKwAFRiB5zhwFSUDHTmaQ?=
 =?iso-8859-1?Q?uor1fxpaiOuRaicr6BLLWRrstoldTQhMnMxfPDTovn+AqE2KnCJfh3Gdx4?=
 =?iso-8859-1?Q?QshEld3N1jBak6ymckRJmfh28uSj7ONhUkERB97BmngRzu/flCwgppLCJt?=
 =?iso-8859-1?Q?Ji+eMPJA+PQ425gyD9smvGfSKwYjMcB3GZa2/cXlDPeHyCuBy95b7BG2Dq?=
 =?iso-8859-1?Q?cwHYhDixQ5pyjBOA4r5ryK0PJ6Znraqc28fGbiVkfG1nmSJeW8EllF9WsT?=
 =?iso-8859-1?Q?lAljPxYtfH9wWCgUtb2VLtCMgljt0FSkUkZEtuyS2eWMmfg8ellmnMSlHc?=
 =?iso-8859-1?Q?4CO7s52JHQWKJ1+pDd3b6gWdZl3fpY+N+mSLNKBwFOcSkoHecRSlJOM5hT?=
 =?iso-8859-1?Q?EZN/vXX4qdfpA/UdWB1mCKYmeRhKVqOvd0kEOt1CJyzMiVEiB0a0juKcam?=
 =?iso-8859-1?Q?F2l/p2uQjVWGmeXIoWsq4nYRPxGv733UopiBRouWM52ANCOM+MFiZNhpQS?=
 =?iso-8859-1?Q?3VHoHDwHn5K08w+Ct6WFDPXQTS/a7dDb1X0E+v9gL+BA1Yj5j32ruEUZzn?=
 =?iso-8859-1?Q?Dy+QasnMEtErsGb+WgIdDlFNPJrX59hUuqGGcbl53ik1h7kxZvJ/+Qoytu?=
 =?iso-8859-1?Q?jSWhcds8PTVZyuTiRWndegOhb+Ej0+dxtBKPzJivZ/xXXYh1EZLCSo1jZc?=
 =?iso-8859-1?Q?MxcmSPrg9dxX0PlzcYxMuiwNUdR0R4y9a64LzgU5ThNrV4u2Sbb7gMiVte?=
 =?iso-8859-1?Q?E5fBvSQ89XY9F/fJO/SqzK91vLun4iXdLI4ziDBQm29PgoVe8M+9uFDLfB?=
 =?iso-8859-1?Q?gtPxaz9zM9znj9WbqGhMbW4rvww3Cuc3HmAdNOcs1t7J/7cnTZHwY35J6f?=
 =?iso-8859-1?Q?9BR7PlfuJDgYyfHdukS1nW5WQJv9h4n71M/VzfMvL9ixgENcCBonx6Ual4?=
 =?iso-8859-1?Q?+5CgT9hU9/+64X3GWzLC7sLZVgdECpE50fkWi40izzcBxrYAfaVAN2V3g6?=
 =?iso-8859-1?Q?K7IGJm00wnXD+h8ZYCI4eRyeQKYrYsE6727euz85uphEjW/PlwECopCGH8?=
 =?iso-8859-1?Q?akMF/1a0rgLcPEVEe0n63LeIofroGOChvkTRVVTdBF5UTiCVGJxjWvo8/L?=
 =?iso-8859-1?Q?40caOmaDw/5rNa8zbSuIgw/uJOuMSQKdlxV0UizO6hFKXpIvY9ze84MUMd?=
 =?iso-8859-1?Q?nswfzdnJkJ9RiMIj25BPs+Xep5/+s06bq6FiO9y2OPk615LouZwVpa3ILW?=
 =?iso-8859-1?Q?i24hcehObM/TqF5jXEhKOma/U+AINtyE9X8OX80QnaJwD1vNC+RXBnrkPR?=
 =?iso-8859-1?Q?FqH/aOl4EaFCesEUyCeiTDHMi3WMJISBSO8qL4SPcEH4HLQgB9maZ4CvUr?=
 =?iso-8859-1?Q?Tc1XwWr80hJl7xTj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K0cZH/G8i7zsWDjGmWGnk/aILsbHQVG/CjW+34dHQRLohjQWEJQH2MUu5N?=
 =?iso-8859-1?Q?+3PyEPfEzdXJTOpGEmVyIyKPjrOoDHdp6SAlsdd6K6HM3WKwbY4L9mOZhH?=
 =?iso-8859-1?Q?Xka6Y5pJ9jqkrnCZcwgVLgELK9YKcoHZEB/b7oQlkbUQNyhZsfb5VAc3KY?=
 =?iso-8859-1?Q?eKUb3dgBfpyHTGRK/6N6sTmgg3X6YGm+U5pDmqQB2+C8ChI6syUKNJHn+x?=
 =?iso-8859-1?Q?ReHXShhoaeg2dYsFr1YtwrdiT2b4gd/7kNfbavpNz7V3Vrs9DsBm0jxMz8?=
 =?iso-8859-1?Q?Mjpo8Zxcl4fHlDqIYXLc5VX2IMfZx2KLPXIUrUKaNBozF322eFlV5aK0D0?=
 =?iso-8859-1?Q?wQLsUDE3da1FSD9yTxgtTEIw768WFw56LG8WU3mxk5TYoG/Ao+Rj9sMu0b?=
 =?iso-8859-1?Q?3xIesoT2teVQTn1z1AZ/QT95VNu11Hzr8HA+1LlXGBOM0brYHMhx1j89Kx?=
 =?iso-8859-1?Q?yhoJbRyi8JMMo2bKLsImYF+X/yautfCMIxOIDxbEYbIU5iO+WpJv4sBYvE?=
 =?iso-8859-1?Q?SKN87LzzBdbggp0xq5M92XhJclDgnbn5CI9YrGqMi5tbOSei8TE6W0V6zw?=
 =?iso-8859-1?Q?A7SC9dAjEds/L+P2mosvCWyn3lbYA/piI8E5dHkxnEYO2N2prP1kxzONzy?=
 =?iso-8859-1?Q?bbR6OajZsV4FqK016hMrlRggR/C6X5xASdpzqCFuPLOHpdxMo6qQOsfhaZ?=
 =?iso-8859-1?Q?A1e2838vsmioG4mmNZeKfxBNkuLwI9k727uwQiY3gWVlBmDq/8CM9KL/9d?=
 =?iso-8859-1?Q?hYdKSLhH8/W/cKjua/FxX33MwEXqO/m2Zid153k6BxSTyz14g6yea1iBpa?=
 =?iso-8859-1?Q?iUPM0lW/Kl6aiwm4omwO3MDDzg2LCffKsoHpm1QlEhuv8U01+y/ebvyW4R?=
 =?iso-8859-1?Q?dEuo7KDmWinAJ+ExoA/hz9k5zgBTq+dcMoSEVnhhPKfvhrnEbevuCdq/iE?=
 =?iso-8859-1?Q?SOWBPwGb2XBzengAOGiNBNE3jVJcvDWNNEQ51kTLb/LtP48D1Dp/9fkGJb?=
 =?iso-8859-1?Q?Mcb9UEjDo/cuC0X8KtDrBKnOaoI39O/hafCI//6vf7YXy56nBbp5wSQWwk?=
 =?iso-8859-1?Q?c3qqgK65TGtX+3j0ZbcQjYu/0Gb8l5Q4JierkgQdpSv9Wf9GsX7mZbarO3?=
 =?iso-8859-1?Q?3jna0pFdwWGllRrP4yTdHbA9+BMfy8oheJYO48jNCpvwpWWbxsWydlp4R2?=
 =?iso-8859-1?Q?mjQyoPDbJ1mQ92Jo27MkyEm41QS1/tp+XShIiLVe60adHBfYBPo1myLghu?=
 =?iso-8859-1?Q?S0019GPC2r+wDRF6DEjBSNk0Gh5JgTKIqctMHYdXC+UUbkERVECm1xMqDk?=
 =?iso-8859-1?Q?/ll3u+dTiCu7faxT6AcTwrCwxggS4KLdirryC5cwbuqSi8S50kL/QgZpeF?=
 =?iso-8859-1?Q?s4LnrcAVwzV2jMdEkt1hFPb7Eoczeaq7SE2fblYSrgKRx7q1eIBAx7qvbL?=
 =?iso-8859-1?Q?piCGUav9RUnoyZZYP7EUFgfKVPVjrEpdQUeA8d5NsREDyQro/2klDrGyix?=
 =?iso-8859-1?Q?Sp0NE5ZNMh/I1nV4DGBpNzgLxoY7IFLiqBG4vX2NtUYsIcUdwKAn7Lw5IP?=
 =?iso-8859-1?Q?qGJVfS82BjaxPdOzXIEp+S8H/JBZn1Cu5QecxAyQmmpLB/2smZUTJ2hB+Q?=
 =?iso-8859-1?Q?KPcr/lqzOL7hhUcmFjakyNwSNG3umas48x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c588de-5e52-4f77-6b45-08dca4df14e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 15:02:01.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aKibe/6Y/tFNCzYQGFYDhjLvQaXeCG3iG29ICDcdg3+Wn8Cy+G4ZARFV7LwP1CsJvokip1aXHrArUiGlAqecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6882
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Friday, July 12, 2024 5:53 AM
> To: Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> <armbru@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Cornelia Huck
> <cohuck@redhat.com>; qemu-devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> Subject: [PATCH v5 01/13] meson: Introduce new instruction set enqcmd to
> the build system.
>=20
> From: Hao Xiang <hao.xiang@linux.dev>
>=20
> Enable instruction set enqcmd in build.
>=20
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  meson.build                   | 14 ++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/meson.build b/meson.build
> index 6a93da48e1..af650cfabf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2893,6 +2893,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT',
> get_option('avx512bw') \
>      int main(int argc, char *argv[]) { return bar(argv[0]); }
>    '''), error_message: 'AVX512BW not available').allowed())
>=20
> +config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
> +  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot
> enable ENQCMD') \
> +  .require(cc.links('''
> +    #include <stdint.h>
> +    #include <cpuid.h>
> +    #include <immintrin.h>
> +    static int __attribute__((target("enqcmd"))) bar(void *a) {
> +      uint64_t dst[8] =3D { 0 };
> +      uint64_t src[8] =3D { 0 };
> +      return _enqcmd(dst, src);
> +    }
> +    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
> +  '''), error_message: 'ENQCMD not available').allowed())
> +

How about using cpuid instruction to dynamically detect enqcmd and movdir64=
b=20
instructions?=20

My reasons are as follows
1. enqcmd/movdir64b and DSA devices are used together. DSA devices are dyna=
mically
   detected, so enqcmd can also dynamically detect.

   Simple code for dynamically detect movdir64b and enqcmd
   bool check_dsa_instructions(void) {
       uint32_t eax, ebx, ecx, edx;
       bool movedirb_enabled;
       bool enqcmd_enabled;

       cpuid(0x07, 0x0, &eax, &ebx, &ecx, &edx);
       movedirb_enabled =3D (ecx >> 28) & 0x1;
       if (!movedirb_enabled) {
           return false;
       }
       enqcmd_enabled =3D (ecx >> 29) & 0x1;
       if (!enqcmd_enabled) {
           return false;
       }
       return true;
    }
    https://cdrdv2-public.intel.com/819680/architecture-instruction-set-ext=
ensions-programming-reference.pdf

2. The enqcmd/movdir64b are new instructions, I checked they are integrated=
 into GCC10
   However, users do not need gcc10 or higher to use two instructions.
   Simple code to implement enqcmd
   static inline int enqcmd(volatile void *reg, struct dsa_hw_desc *desc)
   {
       uint8_t retry;
       asm volatile (".byte 0xf2, 0x0f, 0x38, 0xf8, 0x02\t\n"
       "setz %0\t\n":"=3Dr" (retry):"a"(reg), "d"(desc));
       return (int)retry;
   }=20
   file:///C:/Users/yliu80/Downloads/353216-data-streaming-accelerator-user=
-guide-002.pdf

>  # For both AArch64 and AArch32, detect if builtins are available.
>  config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
>      #include <arm_neon.h>
> diff --git a/meson_options.txt b/meson_options.txt
> index 0269fa0f16..4ed820bb8d 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -121,6 +121,8 @@ option('avx2', type: 'feature', value: 'auto',
>         description: 'AVX2 optimizations')
>  option('avx512bw', type: 'feature', value: 'auto',
>         description: 'AVX512BW optimizations')
> +option('enqcmd', type: 'feature', value: 'disabled',
> +       description: 'ENQCMD optimizations')
>  option('keyring', type: 'feature', value: 'auto',
>         description: 'Linux keyring support')
>  option('libkeyutils', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index cfadb5ea86..280e117687 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -95,6 +95,7 @@ meson_options_help() {
>    printf "%s\n" '  auth-pam        PAM access control'
>    printf "%s\n" '  avx2            AVX2 optimizations'
>    printf "%s\n" '  avx512bw        AVX512BW optimizations'
> +  printf "%s\n" '  enqcmd          ENQCMD optimizations'
>    printf "%s\n" '  blkio           libblkio block device driver'
>    printf "%s\n" '  bochs           bochs image format support'
>    printf "%s\n" '  bpf             eBPF support'
> @@ -239,6 +240,8 @@ _meson_option_parse() {
>      --disable-avx2) printf "%s" -Davx2=3Ddisabled ;;
>      --enable-avx512bw) printf "%s" -Davx512bw=3Denabled ;;
>      --disable-avx512bw) printf "%s" -Davx512bw=3Ddisabled ;;
> +    --enable-enqcmd) printf "%s" -Denqcmd=3Denabled ;;
> +    --disable-enqcmd) printf "%s" -Denqcmd=3Ddisabled ;;
>      --enable-gcov) printf "%s" -Db_coverage=3Dtrue ;;
>      --disable-gcov) printf "%s" -Db_coverage=3Dfalse ;;
>      --enable-lto) printf "%s" -Db_lto=3Dtrue ;;
> --
> Yichen Wang


