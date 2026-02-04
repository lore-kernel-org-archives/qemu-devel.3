Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6F0E8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnV94-0004Ej-Nz; Wed, 04 Feb 2026 00:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnV92-0004EI-Vj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:09:40 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnV90-000523-FQ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770181779; x=1801717779;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ojRuBNI3LGgSpie5Wbd5jagJlznZK3GbO9TeHqmLZLw=;
 b=N6NYoH3ueiyeIbCcrrDaYLlxYicNJqQ/kn6eOrU3K+CprhHXempH6KE9
 hhu1jytMQiLTdy2pSsvWrhHtnPX7zG1HfjoWRhGONoo3lDSpKcKs4MQD3
 ZG1ISz4i0FNFThIei4RAH4sY4zyQl3vTpBr5ffBwdmyRftW8oSHs/nOLZ
 6fbw0q2nqKffsah+D6DpdHguX3X7OX7MauW40BKzlpSg0hbtXsHowBrGd
 9jqusyPKd8YnbW/DcT3OsfnhwwY4wOg8mrS+Zi+fNKIbKaVsGstKNGlzz
 hw03kBETSwbNdZOdtsj8XrVcVNNRH5+mMxA1rELE0MfmcEUeZrQiBUjzn w==;
X-CSE-ConnectionGUID: ctY74q2gRS+/RnvMW7Ehgw==
X-CSE-MsgGUID: NgdKxEyFSJ+QIYYK0JbiDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94015187"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="94015187"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:09:35 -0800
X-CSE-ConnectionGUID: 7/pNlsX8QUmDpDNGg/T1gQ==
X-CSE-MsgGUID: A4njLSikQ4e17WdVNuPmLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="209693171"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:09:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:09:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 21:09:34 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awL/HBiEbnPuobGhfeaPorsuVag5QF3XPdDS+SmLLBh+9fgrSgthwrFh7flc/pDO8gzrshtMoE74ByfYiC5fMa7t3OKkaQXmcrM0D769CLiV3ammfqG0KwJbAnHT63Rw+Ra2gTWXeoGDGaUoDqvIiAI2O1AiH6Raf+KllgMFQYNAeKLF3NwpmZaZwy4KeZ/dC7OStAvZiW2uH5bCYxkRJ9C1JwKePaEsaRSBzFDKgtHVB1cuxxkVSgK+55B9OkC/v/ebVjq5G5DC2Q/eZ01Tuvb7UJRXAOZK2kqKeapZojqSx66S9ViZUE8NPb2/Vv775gMmRJ0YRyu/bA7GrNZ1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivsT8JW3RmWZN4EJfVYjYD2eSMbomh8VyDPt1WPGQ+U=;
 b=S1bYmm3Zbmg/epZAQcTHXsoiTxUeoN60t1pDmPBPiVH/oKrQBI0OdAfiJ0gBMPHpTHe3mNCjafs0Rr/GuNu5oLasTdiMaXoKYcMhwDE5k4hqXPw6w1IS695pjCd97wuKIVfgZzn7rzEwRwloRgOTV+mdi/58fetmIeY+dKpVYWTUTL6KiNe6Pcs6/kXHpwghKL8KzXhRqGT0T/NuM51sOHCLrlN5ZuDrnqe8Jckk86G3oiXz7OwqQ7ll4s9pVVwJJdSaOFXl+6LhoOgbGQ+RHhlNsbIeCCJZMolLZbzM8esAnp5PGXgCRVqvnkggDb7CeeJdb8osBDfq/HNE9c7izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 05:09:32 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:09:32 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v5 06/12] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
Thread-Topic: [PATCH v5 06/12] virtio-gpu-dmabuf: Improve error handling by
 introducing 'Error **'
Thread-Index: AQHclN9L+AojOdyd9EqhAqW3myHBLbVw5WIAgACfdNA=
Date: Wed, 4 Feb 2026 05:09:31 +0000
Message-ID: <IA0PR11MB7185FAF3FB64CB2CF1D814F4F898A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-7-vivek.kasireddy@intel.com>
 <7ee2dc74-a5ec-40d8-be26-84a79a59a97f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7ee2dc74-a5ec-40d8-be26-84a79a59a97f@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|BN9PR11MB5323:EE_
x-ms-office365-filtering-correlation-id: 5f16b1d0-5f18-4682-5469-08de63ab94bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QYHqRBRKIda7AWy4TEZgrxbYfB1oqIu8ekJy70ZQgYDGqM5UC66bemfqhi?=
 =?iso-8859-1?Q?X/mNcryKLpsAVcyzWlzygNZ9r9WbUiPJO+4qgggVqRpObZHrxyKZ8sGk3B?=
 =?iso-8859-1?Q?uzt5J2DinYtrlD2/XtHTWTvzLzB1PnjEDHU4ZRqaa19MepFQQNbXHPOc0d?=
 =?iso-8859-1?Q?kO7wzlpyDhT4EqYTmEpCbWee3LrtDcaptAXMWfqyXQRvl7+3L4o5pszNuM?=
 =?iso-8859-1?Q?P/iw4+O3e+iWlpNYBnCjGkhs16eI0jk2wIUnRjB5pD4hPDxWDoau50G1MX?=
 =?iso-8859-1?Q?ZZb5hjWkzTivWUhBX5Sl/M1e5UPXvh0p4pd4zPj+ekyMZ7l4uWkGOAz6WI?=
 =?iso-8859-1?Q?vXKPZ4J8ltlZWudEMOCWSlAvspBfMlAiBJHCpKbRwZCuCPLx6UYm7LeRNk?=
 =?iso-8859-1?Q?l4bXGGwxyPvGCoomlC+ct46d0Vocqsi5yBxl8oaHuBYA10HIaz8y9kA2G1?=
 =?iso-8859-1?Q?eL8WLCGgWsT4Asu7PNbBXOsJxGR0GuY4P+Qd9jhWqEoPIl1fQ3GJ0a8k7B?=
 =?iso-8859-1?Q?vnQJbDDC94l69pDUJQ30mRLxFzaPDbm+NX8kk8K3Fiy9oGvNIPXHiODDE0?=
 =?iso-8859-1?Q?lhocGiPQUA93KJZ2pZKsxdK0Vpn5De0CAHmIBQzmW3l3/0iJl61hvBCFsE?=
 =?iso-8859-1?Q?MrTpNdVFuAwcP3krZmp0ryapkAR6YhhZWLkJf7s8MKUivmPj5vbw72eSdu?=
 =?iso-8859-1?Q?M5q7OJcnnCP6qmYQMyIiJuAKXhIQY/rbyXjXf2poyPyV8w/T2JLVyPYil5?=
 =?iso-8859-1?Q?26FwYTJFXa/OlInGTgvw7NMdEKJmDMcNEjBCDWK0OpXnDUzLJlvzuuSqVr?=
 =?iso-8859-1?Q?7p6aWdaZh+8+9w5T/MiEpJBX19IbvRG3niW9S8QvYzpnp9BCn6Ox6K4mvP?=
 =?iso-8859-1?Q?hrv2bVmEiJOb4GyrUvJgvAQTfHQ+YIGXzaGMY5a6EmEzqyewRGvojcbW+x?=
 =?iso-8859-1?Q?yML2HCjntk0g8RDzrLDyo6VtpgYd70ZSvni6MNUDtA8tHxvePvG9PUCFEM?=
 =?iso-8859-1?Q?Ntkp2sK7RMdJBrEeXlxQ0ZrDnIFrVwavSrHO70l17eAJ4q74XWed0XLkPi?=
 =?iso-8859-1?Q?OSo5728uLegMM2OzOxB6NfVklHVUMEbhx0t5p49zStLT4dGV5LTW32srBt?=
 =?iso-8859-1?Q?PkBB2R2nMu9ECafMz0ldUqY4POz5dCtKpfvyBUbIS8eLDBCcI8Jgz+iOEv?=
 =?iso-8859-1?Q?uGbNGIDR4afEROnwPdwhLDSA+dLS6XHB5/MfCGDEcKDdkQR4/Pz9YRcqEH?=
 =?iso-8859-1?Q?U7Xav6xA4klS979dfODwo26knXvNBSU+1WZ/sMoC69rHpXa/hA7UHpNJ8h?=
 =?iso-8859-1?Q?Lu9tfmziTJok07pF5nNWGW3tG03cpZQ4D811KoSAsgevN4oj2U9jOnqd8H?=
 =?iso-8859-1?Q?rIjGME/tH/pbtAkLT3kQJsU7ZC+n+3H7etlNl0PB+Ce6nImOi3hwdEOnzb?=
 =?iso-8859-1?Q?HSd3Bq7OuiTpOSllbgUgU8xXfDsOJTHkLydsDMPXl3Dzrrmbe5cJXF+5hd?=
 =?iso-8859-1?Q?1lhOV8BSJQsEDpJwwhYCQpeAlZp+bY4CF9f+f1zbDmxvGUlY24bWAiVkCL?=
 =?iso-8859-1?Q?VyWcN5STf1Yola5kvG3TWlT1/PvEgdbFJnrlMBYc+hgRz8C9SNIrg+KsCW?=
 =?iso-8859-1?Q?nxijUdgb4GQH6h9Ga14hjtzu/0j5BUv0WG0+CIDKFvDQPwZAV48QM+sBx3?=
 =?iso-8859-1?Q?L6mzJNTMP1s1lBDazCs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OhMgvmnV3bCLPlT9SjbXGW+XR6alEPyvOyv2jmzWmJWti5LJpPhjtTb/0j?=
 =?iso-8859-1?Q?F0P2lX0C+efPRYl8hd3+OMmsNbTv5RzGh70olGOg5P33yRxE38O/1UY5z9?=
 =?iso-8859-1?Q?dhJVU1+JsjdJO7Qye3HG/gNGAUdUW3XremxYmj8Q7yhmiahc4iyuAyO15Z?=
 =?iso-8859-1?Q?PMyvCXxc6jImm/IfvpltJH0+8ZfVvqOiwmO53b7DV4W1YrIJC8/z7iOu3F?=
 =?iso-8859-1?Q?uUKNpLNWScQsKDL769pAarUo45eu+w5vHlD17I9xzIqwhagatImUN+iH+S?=
 =?iso-8859-1?Q?OEF0JiPDyEsQ9jmHoExm7k6A3yrmunBmDR6jw+5QqQzp5FxS+95MFBO2b7?=
 =?iso-8859-1?Q?LkjgOtqJm+TyI20xOdvqIU6Wqzt0Los7oSSdArTQlB1vNwKK1UMfMleB78?=
 =?iso-8859-1?Q?4SjQMS1LGI1A4BNzbDhE86WcuF24U5b/r9HjyBJgp2jFnnZOGtZSnFAlz6?=
 =?iso-8859-1?Q?Py06S7ibDigOKhBmY15Ss5mhOW791Vz3JUPTGxIuqh9PXTsbN8BIDrNAzq?=
 =?iso-8859-1?Q?FPRxKN2+kVeNHTW0obPklHl7MPsf1+vgvhCECx4UR2SAcq0SsYM9wDwD9O?=
 =?iso-8859-1?Q?Z9I3euYJx2FtJayIXq45HuNl9VAhWrIsFsbWPRxoVa39b847x1Z3pJo0kM?=
 =?iso-8859-1?Q?1t5lynhmhczTQL4H0jofZfToSXUv8KpW1fQ9noWqKtTCmXiHM5ioAkVSnp?=
 =?iso-8859-1?Q?jVjmoIA10jHHSuHHvosuG8OSGGMZnu5NvjLfgTJe/hrqTu0ejGH5ROom7N?=
 =?iso-8859-1?Q?VZXqFV1g7WW8VffCXpEKdpc/jqdvbqSXFKArHPR3QWKHcVazL+oxD/PenD?=
 =?iso-8859-1?Q?YzXrap/LNQFf9qG2Bx7P2tV86sZ6lLo9zhRB6NMmo8zugXFxm8Kk/ssu+L?=
 =?iso-8859-1?Q?sGSk7auxbBVqHHdXTl2iJnDSk5Sb0IlrcMSVBZVUGzr1m6mO0kLiy6jSrp?=
 =?iso-8859-1?Q?O1C/NLkGaqZ7JctivfNWUd3w7HLh8if+yUMlJuZF0OvR1XVjWG9PYi2E4/?=
 =?iso-8859-1?Q?qqbUCJ2u4SXwbY+NiTZqHqhanVWJuj1HspVcobg6CHIU8/i8qxM8cGgDDi?=
 =?iso-8859-1?Q?Zc6WxuUN2lfIA5hHltARCiLJpSKEIz3utyiDx3/jLW7Iz2ycFKRFEhHOl5?=
 =?iso-8859-1?Q?czAe23D9e+Hszi4HzeIrrPPw7XDiQCpF/T1KjOXn3o8NmtKj/u7hhjZ+Jd?=
 =?iso-8859-1?Q?U3Tqg6iNvUoOCvR7aVCvV1cA9EJH2LakI3s1IbsihBknbH+anpE8a24krm?=
 =?iso-8859-1?Q?cXhyzMV1l+WxB5d61t1aNxqYXbbJTY41iqnCfXxZYE6VeezNdIJ1k8rXQA?=
 =?iso-8859-1?Q?OSLBTLAID39i3VDERng2h5rng+Fs+nL1Qb4gjo1PCGhxHzSKHrJEDzFAvq?=
 =?iso-8859-1?Q?X2dokiyZQYnAow3mRXEkFii9onnpkZ3emDty66qHEXKzuf81QiECQ1dpl+?=
 =?iso-8859-1?Q?TzeFmqcGryKEYVRUts63lT71MkQrhlbrLb5B4o4gmlUfLY+6qI4qE+7dgT?=
 =?iso-8859-1?Q?20p3pVngeL75WYOJqFMNsgBVit6GLg5Y0IMk2amdkUq/zYXTAF5gwzGp0u?=
 =?iso-8859-1?Q?2ooNtlje5u6ZspYSyDCdqbNj0IkKnX9Eg5LNisw69nezaI+FYJpej1tJ88?=
 =?iso-8859-1?Q?A8NetXVstpBu6u6LRUk8D0EoWqx2MYI05ISO3VFU/042gMjwE5wO8yg88U?=
 =?iso-8859-1?Q?Bbj09rlzFIQX1pYdGowxgYDLiuv1IVv1/r5oMfn3q+rXk7mY8dlUh3v5Fp?=
 =?iso-8859-1?Q?iNkDrR7wcHwhexcsD5EdV4wB8zLAPJPiWobs0Ff4QfcEMoEack6Ei23K0O?=
 =?iso-8859-1?Q?bdLFFQedEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f16b1d0-5f18-4682-5469-08de63ab94bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 05:09:31.8454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKziAVWAlPTBvn91oR7sOV/2tb9F/qC4qhYim+0gx0uDamaQVUMCeymyU3eTcOHoyGG36FZc53HD1uZszaobmCGRCQQPoNw28HMRzpccGho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Hi Akihiko,

> Subject: Re: [PATCH v5 06/12] virtio-gpu-dmabuf: Improve error
> handling by introducing 'Error **'
>=20
> On 2026/02/03 16:30, Vivek Kasireddy wrote:
> > Make the error handling more robust in virtio_gpu_init_udmabuf()
> > by passing in 'Error **' parameter to capture errors from
> > virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> > And, since they now take in 'Error **' parameter, have them
> > return a bool to adhere to best practices.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 44 ++++++++++++++++++++++--------
> ----
> >   1 file changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 8d67ef7c2a..22e66fbb12 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -27,7 +27,8 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > -static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static bool virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                      Error **errp)
> >   {
> >       g_autofree struct udmabuf_create_list *list =3D NULL;
> >       RAMBlock *rb;
> > @@ -36,7 +37,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >       udmabuf =3D udmabuf_fd();
> >       if (udmabuf < 0) {
> > -        return;
> > +        error_setg(errp, "udmabuf device not available");
> > +        return false;
> >       }
> >
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> > @@ -45,7 +47,11 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >           if (!rb || rb->fd < 0) {
> > -            return;
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Could not find valid ramblock\n",
> > +                          __func__);
> > +            error_setg(errp, "Could not find ramblock for dmabuf
> segment");
>=20
> This should stay LOG_GUEST_ERROR as this may be triggered by the
> guest.
Ok, I'll drop the error_setg() above.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +            return false;
> >           }
> >
> >           list->list[i].memfd  =3D rb->fd;
> > @@ -58,20 +64,26 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >       res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >       if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +        error_setg_errno(errp, -res->dmabuf_fd,
> > +                         "Could not create dmabuf fd via udmabuf drive=
r");
> > +        return false;
> >       }
> > +    return true;
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                    Error **err1)
> >   {
> > -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > -                         MAP_SHARED, res->dmabuf_fd, 0);
> > -    if (res->remapped =3D=3D MAP_FAILED) {
> > -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> > -                    strerror(errno));
> > +    void *map;
> > +
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        error_setg_errno(err1, errno, "dmabuf mmap failed");
> >           res->remapped =3D NULL;
> > +        return false;
> >       }
> > +    res->remapped =3D map;
> > +    return true;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -125,6 +137,7 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    Error *err1 =3D NULL;
> >       void *pdata =3D NULL;
> >
> >       res->dmabuf_fd =3D -1;
> > @@ -132,12 +145,13 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        if (!virtio_gpu_create_udmabuf(res, &err1)) {
> > +            error_report_err(err1);
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > -        if (!res->remapped) {
> > +
> > +        if (!virtio_gpu_remap_dmabuf(res, &err1)) {
> > +            error_report_err(err1);
> >               return;
> >           }
> >           pdata =3D res->remapped;


