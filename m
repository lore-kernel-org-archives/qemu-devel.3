Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9ADC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvg2-0002wl-NK; Fri, 28 Feb 2025 03:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvg0-0002r5-1q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:24:56 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvfx-0001vP-5X
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731093; x=1772267093;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W/vlRNyPo/tHDiBphpxX5n5R7j/M6SBQ8Vw9VvvG6r0=;
 b=e+PAn6c0B46NSz0B4lv3mchQ6gATEoWiV5kiRRfw/HO3pREhQns7X/iO
 yPnqOvADh3dhYRwRXSIN4ETpwM20bdfeYwfnMk7WOCdmajU2Z8PRdSKrL
 tvZU9AboYfNNrHTb2XEDthkX9ZCD4j/OcrT/5cEqJgV1FkGFgTlrocr2B
 culsT4l3pEFIHoTuPK/MVRJ5E8Rwnhq8M4iL5lWOZWGIBTef/b81YS4jB
 I6zL5JBmEKBO2nowtHkYqYLKM/vwD9DYRakKX35i6wOnTIEyJbApegwab
 BUS3jIFVJsmXP9sbQEFpUnjDxpXYWijcBl0hYitydBb0LbZFUpBkv/dVa g==;
X-CSE-ConnectionGUID: kXJVaCTSRw+bJ7W3BPIQ1g==
X-CSE-MsgGUID: E3EGCbH8TNC3bApbyVvCdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41847032"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41847032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:24:46 -0800
X-CSE-ConnectionGUID: sbYlgLnFT9WQLlaPjiW1zg==
X-CSE-MsgGUID: RDOkEEGWR5ipZ0gFrWES0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="117458988"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:24:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:24:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:24:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:24:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9aI946D7qsdlYvXLx8sP+pnvKzCXAYXcCe6tnI7YuAG5kFUhQdeujrmrOfKWxRoa7ZJCf25oVWiDebqbvtFYE7/kFOI5/W0qmCdhlkCdUwVY4s3GgAbiX671Y6syWslxUxIKLpg/wEVxYxZ3JIu08yIbe05FmEYoUqX+mK4dHGe+P56BASyBTa268Vn8YWfvvh4abxGoFdoZx0EX7FD3cH7oKl19a98+VZObul9OuPbNZK/JKJ0GFAGIQ7X/ujn6D39/wJOEhEwwhmeV8SigWTaDTTZuND0GW/AAHQcrdtdgVcqJrP+duOhttQ/7iNpD63CWjk6sjDw2B2a0my1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAmW05LfIVLrZWcvLHv4WUbRBVjJZnwlLQewJOXZv1c=;
 b=MdFiTZI7ERdk+e+f6RUYbFKNeSg0vRTgmsjjGJzwSQUxy6pcdxn76OoJ5/uE/8REMBOLRhIxmVhV2XHJWfuacYwC5a2UlnY8yNNT2CtyrkIWE7MPG7g9+g7IeVurdRXrzN/rcrtXOGULL39n2OusMSA6fLDYBnUvRGCwbcyFvpsLtb8JI+fJOfV6XmeIK8v695ROTBct9mpnOpgGeNHdtLo/Y5TSfTUXLO/p/xgsgpXR/7IGbJKTn0yNnH19NpASgQrH04EjgzuhwdVeHCpz6H31p+fjXKlmMIHEoCdQlUK+tEVU2OX9dv+hQV67DhcFDD3+8TEZzqrMlGz4pWK3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:24:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:24:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
 handlers
Thread-Topic: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
 handlers
Thread-Index: AQHbgqf9txzaPDAZcEe7kvhZsu5enrNQgN8AgApwxIA=
Date: Fri, 28 Feb 2025 08:24:40 +0000
Message-ID: <SJ0PR11MB6744DB4CF84B062FF62022B992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-6-zhenzhong.duan@intel.com>
 <65c7bf72-10d2-4183-b548-f0f842083c49@redhat.com>
In-Reply-To: <65c7bf72-10d2-4183-b548-f0f842083c49@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 4b24447f-ebbd-4307-2013-08dd57d1590b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9atSFpQHViFBbjJ+EOdvBnKyzrLSdx74DP5ooxDAnmqbqkHuTL6HUa0zfF48?=
 =?us-ascii?Q?5x6HI2hORAYFiqh+Ysm995fvf6YtRsjm/X33XjkVhi9ua1pHDZtDAPvgIpcS?=
 =?us-ascii?Q?uuBGbSTalhiG96oN+9ClaM2kJavRI8hFPKJzEaXJ0Gpi38kxC6SOCqR1dYFv?=
 =?us-ascii?Q?2Q47n5Mbz9CbnhvRZFG9JAcHddfpEeN/5GrWSUJvXcLK52llPX4vgWaGbeLt?=
 =?us-ascii?Q?mVAx/eTtdecm5UVRetQRltR1jLAx1ioUXjxVm9pxoxKdPZC27J0i+M841FtJ?=
 =?us-ascii?Q?3VeDkWc2txDNk6XEgQa8C9lnphbaVlRSfUpRGW86jbGwWeRIMUfm5Md3UIlk?=
 =?us-ascii?Q?RpVGOIfNINwFFNGqhHy+wZ3/sqYbVng7e92HLPIKRjfx66BtwWD82zTvxSdr?=
 =?us-ascii?Q?kh5jEabeCXkRwfiRCaTBYyskV1/2XdBDB+CwFio+sMvT5W4EKYzT/eKuMZNP?=
 =?us-ascii?Q?ANrUiH86kbG+BP/8iP1r6ulFiGltKkZQ1eONMKhD03vaOHttjjI9eRHCgq+t?=
 =?us-ascii?Q?GZYml56KCQ00M2S9Nu4hCJUg9epm7fU4W8w4refZZ3l2RAIY9FPPn6M1cEn5?=
 =?us-ascii?Q?RBKfvokWxN1ej4Wyd3W4u4mSWBfite3JRl8E6TaM1i+1ZCNiOy3CrztvYk4F?=
 =?us-ascii?Q?E+jmp+/0XySl6gTnqbSGcB0kjx2FzGrtZ4NqaA8y5TlS732EaWD69DMRpvNk?=
 =?us-ascii?Q?FvpriRI76LDiZxUG0h50G9u9+MmKVKeviYHc3wklIwwbjYFoXlt0ZSuftGD0?=
 =?us-ascii?Q?q20CT9CzY4h32vTZH33H1JpBA/kZXFzDZEyBONffWjWmk20FfTaWN/3RpSt4?=
 =?us-ascii?Q?ZA6rq5ECFSY+4SckRbA4O4ouwQoJjUoNfHyPtpv0vIpxASzCOBH2HFVGFRR1?=
 =?us-ascii?Q?In29hqJxDWoVdJ6gs0MzQfgGIjV7URlQDGvgKtNaDsQAakpNfGudp/eNwNLr?=
 =?us-ascii?Q?lbjTxZmRuGK/wjlwJK/DVVlmtCppnsMcxcCJ0sJCGG24jaruPZEn94a1dY5n?=
 =?us-ascii?Q?VfJsPkfp+AvcNxa0Zs031yNaVjeP9pbhcAnZSbCea0uGgUgfM6WdBYRk5Ath?=
 =?us-ascii?Q?cQHfvt8zCwCDp8UMJ2dzcca48p1PPzuikurmvwtoMjXr4qFmyR6zBT9wEMtw?=
 =?us-ascii?Q?2hKrj84XDh1hdkrQo8mNfYOCBkyBDx4PrjtEyxHp5h21zHzqAvygiOJWX4mw?=
 =?us-ascii?Q?KF9Db2dR6LIFhIiJ9RJztGA9lXEbdNnrCUAI1mTRAGYowcR2eJOuldy1OcRi?=
 =?us-ascii?Q?z/1N1LEJgJaamsRMHqlQjQTQAYY8AfR9dpwtZm45vbqPFptdMXRV34G7HXga?=
 =?us-ascii?Q?YqAKplmArlA8ozzi82DoFruqQbTJN3IP6PONdmbdOJLJ9+T+HBjjBKGUa9OP?=
 =?us-ascii?Q?wbYEGGyHPfW3PEg/XZW9ISl/HxbqyOpP5NgFlQW41DhXs4IhKBrMTVFqVUd0?=
 =?us-ascii?Q?DlnbeNIwI5eE9P9ot/OoeuFmNdhfrqtW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ly2w4WQOq/GXXqe/6JA1xFRk2cAs3cyLNKTHzy4vsoxK5b7r3m/DicGBeDe?=
 =?us-ascii?Q?gV4FdVTsSZPYwkNR2roSz6BtVU9tP2i9/GpqpG6ULpOVTafAOj2ee0bHQE30?=
 =?us-ascii?Q?rDNiLXU+OrVj9zcerjAu0MKFxjFoBfiruyN0UGpq41O9TrkocFSrjP+qoCY2?=
 =?us-ascii?Q?NuLx2SH6fW6xTcFIgaTZkZ4zyxVcxICkiJrfmrEGk0C4z37eVRhtlt9ZC498?=
 =?us-ascii?Q?ZDTZ2yPNkjSg2Fxq5tZpOq7K8XZFeHpLnxkbd6NAx36oiCc7m4L1/pHICM/g?=
 =?us-ascii?Q?0kw09DvQfMHr1Q9MiWT+lhBp71hFmrDI4vZI43Q7X1IPxDGevjMdkQEbbvGg?=
 =?us-ascii?Q?nd7ngCZo3VqfIoEIxhOeOclzZVQ5fwzBaV4chJ5WtZNdHTKJq9BcnLtsLGyY?=
 =?us-ascii?Q?vVsCB5BXowv2Sf3WY8YmyORJgt3rloRzNtLXjBnLMgTOjKSeQongYGrhD/EB?=
 =?us-ascii?Q?WO+SDqrmQOc3UuITzYnI1bxy6+nl/X+ugy44nCbXk5WZI+yQwRBou4y6ky3g?=
 =?us-ascii?Q?hTf5Tcp8bSx2GGx0pZSe7ugl2rA3X56mbQzLxU435/RcbImfnAs+s4LWl/5W?=
 =?us-ascii?Q?xpKzN88kCzaLcgKJe9OhmKANkgT4+Uoo50mrrpyM68LfLqYoG5leN/0VRHCa?=
 =?us-ascii?Q?QtMmOo04UQVWAnsoxP3A8Ou+39wjCeLO23p8xfyldB04IBeRim5xlhMz8AWY?=
 =?us-ascii?Q?5aHS8uIZoa+MtQVPRZ8W7Ckuy0M1iQ1+2yMRi1szL0wWtTL2VCljF+DbrZEg?=
 =?us-ascii?Q?9ih4D+HBVicxZ6YhyE0lw7kVtW/DDnK7CFuQqw3ZxK2o/XTmvgv2sHlrDVCt?=
 =?us-ascii?Q?XI3AmUlzhaug2ejgsJBye6aBK0p/7B4s9VlLfbVsUS8VsmvLOQaNQo+NhEVM?=
 =?us-ascii?Q?vtgMy5oM3HwUNt+0gBRliKpocGINkK+pMc8D/scQm5ZDq67m9GYfL5oLTmRK?=
 =?us-ascii?Q?4688nZPAjcLzx/fWY11fGnvuakJUIw0VB29ua785BCHJsfAqXrz/jV0TiSOe?=
 =?us-ascii?Q?1pNsopBbpYD/DAS0mvRpqqJxEuZ7pg5ekY4Psw28qotxRlUwW5ouJKHAswRH?=
 =?us-ascii?Q?RXeZDr76WhPLcAhqQ86G4AdUhuJLyH2bU0RNwXO+fxYaXqTSMtED7cT61oEX?=
 =?us-ascii?Q?2sBdh6VPWF+NV2ctF4KNqSu67+L70PD3zBSOaf8vOdQydvoplovuC7p7zuvM?=
 =?us-ascii?Q?31JNtFeDTr/dfWelRvTmkNnlIRJJjxJZ7l+JjNPsRxxveOTQ0tcnp9OQ85Em?=
 =?us-ascii?Q?F+b2Ika1+Eu2DIceYNcYTtR5cBvjNZlRrf28LjkafUgW746iGYfw28F880Jf?=
 =?us-ascii?Q?ajlpJ36EBsnV13E5XBRypI1Vg04f+ONQWAwqaXInH7gcuUhU5q5RApKdGqq+?=
 =?us-ascii?Q?yqQ8pUHaJ5ERibT6LGxOWDwDeAZ0fb78dKPbCRLgSQx4i8nwyGBUOe8t/5MV?=
 =?us-ascii?Q?d4xOyb9blviRGHfAWzKc9ra863ig9ZaZcoVyc9wX0FbTe883b1RWhUKNd/WB?=
 =?us-ascii?Q?5I7lT6CNdJ21LGdQR5ZXZQsgZehQJssBvDYj+UbcKvu7k9LPUP05IPPKrXb1?=
 =?us-ascii?Q?+OZb+ax0SuByBeSjqEH8hX9bhvKcgUzR88QxBzej?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b24447f-ebbd-4307-2013-08dd57d1590b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:24:40.9658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rnJmbjXlnJxvfCaa57XU/kX/tIHf14zHzmQSIGH6ej2mBybA5Y0r0eeXbCq2EGSJoOjCdI8ni3aWUEclQSitPr6mFi+4ZeTb/OKwQkvkoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 05/20] vfio/iommufd: Implement [at|de]tach_hwpt
>handlers
>
>
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
>> utilizes them to attach to or detach from hwpt on host side.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 53639bf88b..175c4fe1f4 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -802,6 +802,24 @@ static void
>vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>      vioc->query_dirty_bitmap =3D iommufd_query_dirty_bitmap;
>>  };
>>
>> +static bool
>can't we return an integer instead. This looks more standard to me

I can do that, but I remember VFIO honors bool return value
whenever possible. We had ever cleanup patches to make all functions
return bool when possible. Do we really want to return int for only these
two functions?

Thanks
Zhenzhong

>
>Eric
>>
>+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD
>*idev,
>> +                                           uint32_t hwpt_id, Error **er=
rp)
>> +{
>> +    VFIODevice *vbasedev =3D HOST_IOMMU_DEVICE(idev)->agent;
>> +
>> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>> +}
>> +
>> +static bool
>>
>+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUF
>D *idev,
>> +                                           Error **errp)
>> +{
>> +    VFIODevice *vbasedev =3D HOST_IOMMU_DEVICE(idev)->agent;
>> +
>> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
>> +}
>> +
>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>*opaque,
>>                                        Error **errp)
>>  {
>> @@ -863,11 +881,15 @@
>hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>>  static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
>>  {
>>      HostIOMMUDeviceClass *hiodc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>> +    HostIOMMUDeviceIOMMUFDClass *idevc =3D
>HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>>
>>      hiodc->realize =3D hiod_iommufd_vfio_realize;
>>      hiodc->realize_late =3D hiod_iommufd_vfio_realize_late;
>>      hiodc->get_iova_ranges =3D hiod_iommufd_vfio_get_iova_ranges;
>>      hiodc->get_page_size_mask =3D hiod_iommufd_vfio_get_page_size_mask;
>> +
>> +    idevc->attach_hwpt =3D host_iommu_device_iommufd_vfio_attach_hwpt;
>> +    idevc->detach_hwpt =3D host_iommu_device_iommufd_vfio_detach_hwpt;
>>  };
>>
>>  static const TypeInfo types[] =3D {


