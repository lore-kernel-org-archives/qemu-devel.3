Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D14C27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHYoC-0006bV-KL; Wed, 12 Jun 2024 20:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sHYoA-0006bG-Us
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 20:59:19 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sHYo8-0003Hx-2V
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 20:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718240356; x=1749776356;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jPoAUWSvYgfakk3CqHUt9OKdbvnrpQHFSpxsn4AIGDo=;
 b=CArprfusVtZ84MoGQOo8E3CLjnbkiRrpeNNtXN+QjiCwbDbQqTL+/Sd5
 dUxJZ73h2I9XTU6kOgWAdsutUr5hsphp8e32/8ya1MudjuYtqSaJiZ+W/
 Itu6aweViSWlCkive2lQoJp58mit9/JYdCss8r9bz9JfYkVvihj4ZEmAh
 nG6hipQRif/fi0fuxGJLDUiMEeYkMKnhLkpBGezJmyRgrxCndZ+J2cPAv
 aDxdYtihmLX8DZrXGP6DHuHm2MuXeD+hf9/5g9P8rPpXBN+FXvLTsM4Z2
 S3eB3hlO5QWDmdLBbBRIp/035fVfmGemr3b32MwEfXZpvSN5+5CYB2o/r Q==;
X-CSE-ConnectionGUID: Xy0GPCwjQ/OwuJclXr9gaA==
X-CSE-MsgGUID: imVpxXmaSHmI7yzIm7EjcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32577220"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="32577220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 17:58:54 -0700
X-CSE-ConnectionGUID: e/xjXkEYQ769cbknAlDXBQ==
X-CSE-MsgGUID: Hjs1+BdGTpuiTQ61tqi1kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="44505740"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Jun 2024 17:58:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 17:58:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 17:58:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 17:58:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 17:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS0+ioecWy1eyv5dbCFrb5rbt4VsQJ5RXip0mhq1MbAdI4bztpssSi5E1tzgw5aBFyBF/rPfBgpegcFahDjgaBZ+t5A1hzpXPor+8j9gWt32Yb1ZsBt7J0tQkBX8pnuy/GSauLTPyaovBOVwsXs7hvLCvJc8IjmIEqbFfOHeeUQ9yQdheHk1De7g2GC4a6uC4S51x4fI3vv9hL19irj58C1qfYVOLhcxEZlIQLEHS0eghy3m5+vNGOeZpS9idcfiTsbXfmcSOqtaD7xtosuVi7J64lkjSp71hH8z7RjmasToYU4Ldg/leEDbhEAd9eMxfqv7qv3RJRoTpTCAlLFSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPoAUWSvYgfakk3CqHUt9OKdbvnrpQHFSpxsn4AIGDo=;
 b=dvg4LqsBzsq1milMES+f8LGMVidj/kjHNwTEnxg8ir2v5aMrKwfNTw8Va4iF1a1HukbnV1JkgMcEU4+VbC+aBYKlkTkV+x5CKrl3bVXp+cMuqIkISvm0xT/zWAgCvb+geFvqVxMCvg5kZJQX/n1kDGUyJ/k5QOKmn1UJWdQg9DQ+h7OOPITunwYE8L16J11C091JNKjPrHAYeMMr7k4DWuoUZADQJ1BtVA3jS5o+mZCWzbdNMGUlwLFV6eLWF0ZjnmcIsRd7y9YUyczIGgaf49lW2uTqjWqzQTWTZXaGGHDnQVOGlTBJ0OVIjtvKK0HTSqAk1f2VxrIVTFnx6uAPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 00:58:50 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 00:58:50 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v8 4/7] migration/multifd: add qpl compression method
Thread-Topic: [PATCH v8 4/7] migration/multifd: add qpl compression method
Thread-Index: AQHau9WAUDA5tpJz9EiYCAgmVPYUwLHEMaOAgACwMcA=
Date: Thu, 13 Jun 2024 00:58:50 +0000
Message-ID: <PH7PR11MB59414C61B4121940DDB51242A3C12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
 <20240610102110.900410-5-yuan1.liu@intel.com> <87msnqck32.fsf@suse.de>
In-Reply-To: <87msnqck32.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA3PR11MB7977:EE_
x-ms-office365-filtering-correlation-id: 9abcbdec-b183-4d48-d12e-08dc8b43fce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?ExVbD5y8UQYPWvvfz1TO73/03+jx2781zyz6wCipHKD6bHxwqKFEQ4vwujIP?=
 =?us-ascii?Q?axfHiJQ3ROH0ZAD3EnSzW6LDrXUpWQNvzodkzd7xNa078RpFqjYR1KSoUaaQ?=
 =?us-ascii?Q?9JstVLhwt1AmWcUr8lwZtTJdmwXI/BuhbPItIAdzXsq830BADdEUtQ1q9VtU?=
 =?us-ascii?Q?H6T27N70ITEKLdfocSurHKLSzWoykkRng/Ap5HpexTaDZWT4G/pyE/jNM25E?=
 =?us-ascii?Q?XLaSjAYiFRoXLWl1bAMQdcZa5W47E2AM3lv3EkS4r3HyuZig1CXBzVvM70cx?=
 =?us-ascii?Q?okGvkrfflqWJBZjui43luEc3FxzWmd00Mn0yARclUHdKyhhEBXpMFNyxRRs2?=
 =?us-ascii?Q?UfvQc2VPDaKVUP5B/4XWFktl69gTnzyOujwznWZE6Dq4uu2yMLeTi39x0QIF?=
 =?us-ascii?Q?xWrTRt22f710JJGOA8EI+bS5avY/r9qNhMAw8sLnzEx8DO2EtKYvkxt5stAG?=
 =?us-ascii?Q?WvziFNoursH46BB9A+ofwfpvyZ1AdF86zKtZKecVz9AKo2eox+9XJbkvGN2w?=
 =?us-ascii?Q?Cen7/yhySwjhYK0bAeJ4FPobCEVqDBcVDePMAoI00YvDDq/luIUTzYZdJDiT?=
 =?us-ascii?Q?gWo+tsGx/pJ4RAxbbSd7JX+BJhRvdHxvxtqr8Tx/4CcLAirfmmaQoapLsbQR?=
 =?us-ascii?Q?IWqGRBixrhqQDIMH1s8Ei91dwsmj9adMSPPMIxBd5i6jBOct4mcS6YzecukV?=
 =?us-ascii?Q?vtCLAJYfLDGUU+tvQGUlrpiawQLbGbGNKPfHhe7laUcY6e0fPHI+9sUCB0wE?=
 =?us-ascii?Q?ygzyzBz6zaHGRu2YafVx7cs1aPwqH9tWwWmKT7w0+0pUfKcLLhTnzjcGGy95?=
 =?us-ascii?Q?eZy6slc7WOF3amcoLvpHVDePrMbgGYtc3dkgHV3nNE3sY1I1CG5ZvNREGR33?=
 =?us-ascii?Q?tHW5FsT2/Ms/9R+iuEawKxDw1GlCWmZdTN24farKpV71tsBjXUhMwCYGv7Tx?=
 =?us-ascii?Q?hg67tk2RKVQcbc8TwiuFHrFHAVAeat9NIyOkrKNHC3g6UnEG9rlSrh1ljbdJ?=
 =?us-ascii?Q?aKeXYYPBOBLHtAoF/ZwicAqguAY1kJmSvsj7/ooOzkhA0+P3tRyIBT0djWI2?=
 =?us-ascii?Q?j38Aa9Bxx/euwltRCbF4RBMVyJ76kVSHNHsGW9Cx59LyohtxN/b0S5vibawf?=
 =?us-ascii?Q?bRP8Fv+qNC2NTFBxM/VkkHQBq4537RoF9LBoE/ksCtO3WJPBpyjycCkwOn+m?=
 =?us-ascii?Q?5PdzgdfWnTqgERETMRXQZl9JYa8SPnNUe8y3gHvKRYd/Z14sE43mJ0ksjFHE?=
 =?us-ascii?Q?XbQi372vA/U+/s63fnNqg41RcM+AeIz60qmbho0rB90GnpqxCPN2WSRgOW/g?=
 =?us-ascii?Q?rTQrgZnkPqMBAqubRoATRB+nKFeyAg8sHJ2Nx78Mmo6vozs55avsysQX6qp7?=
 =?us-ascii?Q?09mvEaI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tuo4eIFs7kInnLu9aQvnsWQozHppaRxoL2EBYcXgHzrDEml3a01YQcYmtKBE?=
 =?us-ascii?Q?xBml9+j03KuZ6XVckgCZQy10nzxu+zfk6eG/7tb3J3VrhMn/TYwy7Wj0pZ/J?=
 =?us-ascii?Q?2Zf+viymlVHOTXPuLZMIRf6xx5MU4p/FpZolg1lqKAIqsRWRCGwKY+MT9Xc5?=
 =?us-ascii?Q?lnXM5frIsr1vhAz9Zy38RTewI+nHYKolIFYiCYt3jphEfnw3r72y1Q4Tmxmr?=
 =?us-ascii?Q?5FZJfcCMg2uHBfDt1ZxFd6zrOMFMNDjutswggDFL9NYaNv34pcA5xhcBetjd?=
 =?us-ascii?Q?00d3dbDAmbFUHVOx2OMH9kxvQDQFvhzVWTpOIBirX7XlxOa9CIem/dXOZO/R?=
 =?us-ascii?Q?ySO817/wa5+fpT4ukd9Ai7iLNFoGbXaeQXmic8MuahRcDzWfB5avpXIg+hGX?=
 =?us-ascii?Q?MNyabP3nmfo5V4r51T8beS3Qa+b+VpKz9Gg6pRN0WUmDuFto/BCjQJEB9mLM?=
 =?us-ascii?Q?B3kIiFpq8ND2h8F6/XKG25Xn+K3WUvoLFh7gZCXnAavfvKVDeHxMGD/GsrKW?=
 =?us-ascii?Q?Vomvq1wLvaSyclb44WC2WZpdwPeIqQo3dWI24cyKd5bmlCDi7dc5DoqGiVbf?=
 =?us-ascii?Q?z9k6pkgybIVMTmv8nP3MS3F7pUi4vZDBJ+/tle/BIYVBz6zKCktVLHehVTLM?=
 =?us-ascii?Q?+CNgQK9CXhXEcuHgy1nZh0hzl6v3t3pv62atX652gSHotyOIsu+g3cRQoW28?=
 =?us-ascii?Q?7yu4wS9QutIcFjSF1H0/H8cQ1bSwH+0Hst7s1SnraTCXVEDcL4yhHAU6T9yR?=
 =?us-ascii?Q?IgP2HvkeqVPOBqcpTHaIMafeOHrxFLtRC5viU8pFPippdMAnD57CbZOMZeni?=
 =?us-ascii?Q?IF7IM91mSCgJPlCs3bmmgVe5arY1CgQ55scU4FnXual0jNCfRGQScf8TIIfA?=
 =?us-ascii?Q?Gm1OD1rEbQqiZr//9scKOlzBtBnAit6QB0pJCnpw1zKjvZAgnlCYwqjCXQue?=
 =?us-ascii?Q?B1fZzYTATOvj5HF5NDz2V9O47+Vwu7Kk3CGEGYILEhuZDrQkyyLTY/gwq4mm?=
 =?us-ascii?Q?LqJm+4nRI9yCQ5f/yr/ajIvxxjVAqYMUvu+REmE5Wm9umBTKgsWtcdCjXgoo?=
 =?us-ascii?Q?qv9SwRLXQ1Yb3PVpRbGuJml0qJAE9T99o5nAeVy7IhTXMmuJo8BnOnWe/zSI?=
 =?us-ascii?Q?Gi/jtd2vhnNdfM7cizF0jORRlDPtaTP8WQvvaBZ2olznvf4phXbcm+WZJ7Lc?=
 =?us-ascii?Q?APBmo9BvqARfEg7YTvo7nIk3bsfNwd9qP/CUjgfqCYUh949DF0WGS8zb6aC5?=
 =?us-ascii?Q?Xk/KmaT0m8WXAwItb6yoIZUsC6fiHUZMMz1jUary/sUlxKDzN9FtZNAEV1kf?=
 =?us-ascii?Q?610+qp+fHAsya+zM1suWDSwn7a3uYksDLMedASdAXZjS3CdrySnDs8QDUW+R?=
 =?us-ascii?Q?0cBGPNq6X3uYsKCSWKgS+w5LajoaJt2IzoAjBsFOriGeOks4m0N3a88CrG/+?=
 =?us-ascii?Q?OkA8c7UgpCFUKuDzEwp2fwqxoX6zvmnMAI8Ky+a928kH2W6h/F5wMZe0NwXv?=
 =?us-ascii?Q?+NUcdvR9gyamdtu87FrWC1HguP1+cyyqitQLE0Pw0Z2q6iRzF0vUsFkoTHSl?=
 =?us-ascii?Q?AvKqBP5A5DjnYtJVORnoBi0uCsUhkwNLGFNijysL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abcbdec-b183-4d48-d12e-08dc8b43fce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 00:58:50.1655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m99ToHL9R5b08qKG1kY0i3RBcBNGsjDzpagFpAEP4uSZ035N7WPWoZqWnihRu6eTgcrqJ8f4NY3JEwhO9+4zGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Wednesday, June 12, 2024 10:27 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> thuth@redhat.com; philmd@linaro.org
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
> Subject: Re: [PATCH v8 4/7] migration/multifd: add qpl compression method
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > add the Query Processing Library (QPL) compression method
> >
> > Introduce the qpl as a new multifd migration compression method, it can
> > use In-Memory Analytics Accelerator(IAA) to accelerate compression and
> > decompression, which can not only reduce network bandwidth requirement
> > but also reduce host compression and decompression CPU overhead.
> >
> > How to enable qpl compression during migration:
> > migrate_set_parameter multifd-compression qpl
> >
> > There is no qpl compression level parameter added since it only support=
s
> > level one, users do not need to specify the qpl compression level.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
>=20
> I don't think I ever reviewed this patch. Please drop this when you
> resubmit.

You are right, this is my mistake, I am very sorry.

