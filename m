Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55B7E8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnV9n-0004gs-DK; Wed, 04 Feb 2026 00:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnV9m-0004gi-8R
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:10:26 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnV9k-0005OC-OE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770181825; x=1801717825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QIs+c+3eIyUBx0iLUMMlt8I9TmrkCOGzGLr6AiNpOPo=;
 b=XLzZlch0LvKDhdttYQt35PFuSu+AmciPssdD7Q2qFz1tGi1KzQ/KpLr+
 3ldOnSho32+X4UlNX/81DiFbKmXjSt1Zc1CykwyBEaEnppXuJ4/B9/jKu
 7byd9tb07G32DQPmrY/GR3inAoYFvqEq0PCR0cKZnlIMcXXjdj6kulW4p
 ButdWcBzjNe2vwri9etgipBTErkcGLCqilWLFd9yy/XG254YejFxAeFTu
 Tu2c4F6lyVuhc1Nh2AHXSqfSdfsgNh89bTVIT+xRySTydcp8ec4oUm12Q
 aAzolxGyIavqWO0i1DQQd43YE64FPppGOYEy4t2AEZyIPFlYMoxJE2bph Q==;
X-CSE-ConnectionGUID: v3mtjqICTXKIDaM+X5/RiQ==
X-CSE-MsgGUID: AnB8lF+FTcaaf0sAeBzqmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94015316"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="94015316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:10:23 -0800
X-CSE-ConnectionGUID: /tKJnVhkTfu5B82HpAr2zQ==
X-CSE-MsgGUID: 5IqByoyyT/WdkrPkAVXfyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; d="scan'208";a="209693328"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 21:10:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:10:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 21:10:22 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 21:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkR+miN9mDW0EOkf0X/M2W/Kq32vRW0HLMqDoCQuC7HHojQb/Vp1Qa3OTodaCTsmst4ONKt3gNnYRctoWALPPyMt4UOBMLd7r3gbuV5wptzuIMzAy8Fmctc9sRvERbjGYVqnmQ5/JEF/EoltsNV6YyWVkU70MoptUyG7IXuymZ2U8T7kbqssGSYg50wHP8qcF4LURxnAJW/Hdqo3AxH8MzmODsWcFd0v/9B9tpUni72C7Taa0R2SLeqCAddgA73gyerAVzDj7yu1+7Y/RkA+XVqGbcYvnseFJDsHzn3sH/IbV8nMfw5AxUo9y9o2Sy/tBY4PFESpAwM6Ipt+SdtPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFfZiLNCUTZhoK20eFQIaTLpVRDvXBqrQnb5fq2IYYY=;
 b=YObqFZ4vgim/Q8vysjmEGPK2Ao9IC6SQHpkpgxRlwZF73Sz00GmPNUtCKTdTL9MKT/NntkuXgfMWfO5j2W0Id383q1/R2z9wPLOJOdKGSPUrfNs8fI4S3lIwhYpLi7wYCsUv6teDS7SX5EcnVUCIYx/eGIQfDsh9K8IJlcDh2AEbxhFu0WR3e615zqYBy4xHI/Xyk7sOalKmXXeGMbd6BaLc7RAUgpk8R54P88YfTD/xzA+CsO2juy2CgBPLPpYB/cv3bu+A02VQpHS91Grx0c/ytKs4X2yN1jlA+S82AvmaSX9Ed1jcCPA7Oj3BtOYDFWIPXL98VENQPV+i8af5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 05:10:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:10:19 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v5 09/12] vfio/device: Add a helper to lookup VFIODevice
 from memory region
Thread-Topic: [PATCH v5 09/12] vfio/device: Add a helper to lookup VFIODevice
 from memory region
Thread-Index: AQHclN9MSxHLXxk870q3BItQvlgG3bVw+NuAgACMnNA=
Date: Wed, 4 Feb 2026 05:10:19 +0000
Message-ID: <IA0PR11MB7185A57303040A2F934A79B8F898A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-10-vivek.kasireddy@intel.com>
 <4f7f77df-afa9-43c4-a429-2ca387fe9df7@redhat.com>
In-Reply-To: <4f7f77df-afa9-43c4-a429-2ca387fe9df7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|BN9PR11MB5323:EE_
x-ms-office365-filtering-correlation-id: 984043de-b7cc-4f79-b332-08de63abb137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ipnupZv8kh1usaq9b1kHMqyRn+FZe5CBYAQcrj33zOTV0KWdOH3zikkeJd?=
 =?iso-8859-1?Q?DAqQ5cU5mGkO1dvHQMPrVstUoLXJR8isdBEO5SPxPaibm/iKYv0uD9yzBw?=
 =?iso-8859-1?Q?S6gGFsRv+jb+60bg6m9oFs6w04p6BVAq5nZkZISascTbxvOLbCXSjjv32b?=
 =?iso-8859-1?Q?SWuIKAcg2MVmbeWRhb8Y4uFvpqDdWjTefPTFjH7wJpgRF+9gs1Fw0D8uFM?=
 =?iso-8859-1?Q?k5PQ1iR9gaiuoGJBacalC7IoTxezx4wmWYh0cTrYOSb2CacdjwoU2tmp4n?=
 =?iso-8859-1?Q?7hSyptaV0+HpOMaJCvmHSmPj3/YZwjdIfW8OwzEHa0OvqpP1JKH0qkTeTH?=
 =?iso-8859-1?Q?kOgeRhg9peUjmcudq2Ac0H7Ve4Gh9HJwnX2kPUgBk1GZrZUrW8frzuY8IV?=
 =?iso-8859-1?Q?YXJ3Osw73Iq37hAU1r6yOnj/nHzgBaciINKp2Od1hepdzYYNuaIASyeU+1?=
 =?iso-8859-1?Q?HB7bDNk/O9SKkY4gsGWLuerVlV6cwLql7L35yyIjjwIds/6vqdlbOT2Ylz?=
 =?iso-8859-1?Q?F+vqUZPAior4nTKy2CBt+0/qkn5TwkH1KilLgt8haYt97IfLtDne7eGTAo?=
 =?iso-8859-1?Q?7Hz9qUyKPT/bnQo84Rs3pMbYgdzwdUdFXHRGSnwQ3T2xEvLAYsROUg/gi8?=
 =?iso-8859-1?Q?lsCoe5Yv2bZJ2rf+o9268UAchWzJNyLn060Sl+sKan0EQWCNjFPUVn3sJR?=
 =?iso-8859-1?Q?3rbn0U+nB9Q5F4aJNT+m+R9gsuVoWdINA26SeSJEkuqOmibhYrhSvcG4xN?=
 =?iso-8859-1?Q?IxR/Tr9RF3ugG9NfLmhVsVEW7JBICd2DALvPHPH3lZaM9MAuW0D6o/7D7v?=
 =?iso-8859-1?Q?78j1/IhRQN41mwra5ErhNkL1wA1aVFwFFFJoFau+I+PcxbkpQ0DBlAtu0f?=
 =?iso-8859-1?Q?32EIjdV9DSJFrBjvJzEjntAAe/XzTsx+01jMeMTOFjsVzUl4qwd3Drnx++?=
 =?iso-8859-1?Q?PJpWNwLoFmnYnsqLLgBW5SdE0nQ4NG6sf3O0DtBIO4ANr+QZ9a5EymaEAS?=
 =?iso-8859-1?Q?nynL8/156z7X8hoImn1TXDMynZ9sY86LxkkJN3Kz2a+44LSBOzlR3z0eMl?=
 =?iso-8859-1?Q?F3pH4EV03EgvVIvm+2qgtNXW5eO/xz7smuOU9Zi/VICjLK86vLWqXoYDQo?=
 =?iso-8859-1?Q?423eddK9a2vtA/LKTQsz3w49re18D8orcHfOhr90cbeRrDkAoeLAvnKR15?=
 =?iso-8859-1?Q?19vhv5JUs8UAELY4lK4z95rco5i+dM+jy0a2dj8NnW7IpSGZdUpz+GaeF5?=
 =?iso-8859-1?Q?p4T2NCrZSANdD5t883yVIKSDuiutXel0troi0onLq1pLv7/tBdrXDL1XH+?=
 =?iso-8859-1?Q?ZckLZtJ/5Bn2XE/OCTVepN4BojnvnuBUjTh2TPlUiUbo3J6avJ8rvnaXdV?=
 =?iso-8859-1?Q?qWZAzwoOY98Z/MyKNzOrF+90nRzfHJyagn1TB8eOlfFW00Lo1QfBTeeZ9h?=
 =?iso-8859-1?Q?ZCT9eoD57WZnUNOQ/MA4/q2C9Fll6Iz9FNFQf7AtLcSZREPr3ZBMH5gYit?=
 =?iso-8859-1?Q?b5bmwVmWopJ8nH8xCFuVkB7hPLEEBt78FLI+iz0Ryjdppc+2OftwBGsi30?=
 =?iso-8859-1?Q?F7E1agK+KFq41DaBbF0D0Gg5fZPcQtYvzRJAnMg1lW+H5XYFIexSIcsfkr?=
 =?iso-8859-1?Q?jHWpdu58HmW2xYYFhQ1Pfb1yWrZqNgjWdbmXfpyrKsjpwiN4TzR87uczUf?=
 =?iso-8859-1?Q?kEpoRzFw/+6vvsEIg8o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6Jt5fI8blunpBBeSj0lWIw8N6lERbDxDzvtDbh+35ELqi2FvqSZ3rJy9MX?=
 =?iso-8859-1?Q?b4fCGahuFADyPXF5a2xyAFAbPK52zFJGG71y45cL1m2WGhmloazolv+red?=
 =?iso-8859-1?Q?5anff+bgHcdATx8qE4Q/2SiZuAZD5uW0551i5WhssiRhapHWSaEHUkP+CF?=
 =?iso-8859-1?Q?jRMceUSAT1270pBX4yJXAX7mw5TnAC6uMoWWisAl/lTtc1Ce56VRLA08wM?=
 =?iso-8859-1?Q?19ebWFR+8D6TJN6uNGzsBBjTyU/zDIYOY60ft1Y/EpeiZqaSVM19b9D53B?=
 =?iso-8859-1?Q?4nvwBny9yUAW3JpPB0XJDv3SjCy5ONmp4PuSd5b8kw4j7fcErKjsFZFRsE?=
 =?iso-8859-1?Q?16xNsUNnDmYdx6W0SPBdEfYFcBTqOSjM5dLxaVghHvYldpebfp0tmDDRyB?=
 =?iso-8859-1?Q?Fw72T6i/X0so7XtCG4q1SIT8Rnd/hfZQJGREF7JUB+t/xbBmVDLbW4RQ3P?=
 =?iso-8859-1?Q?hWgvV5f0nTajfcP5hnchLZwrT+c4KSc3x8f9x88VnKSTjAieNMMnLjqeo6?=
 =?iso-8859-1?Q?IdtGWZW3zht/tUEz+RaAGXH3pXmvGzW/Cs7YjrDP1fiBs08fBMKmyZNCxW?=
 =?iso-8859-1?Q?3xrmlqgYQif3B7Yy1l7fJFmo4eI2ZkriWqUgkQvrCHAa1T9RHN06KAFO6V?=
 =?iso-8859-1?Q?/uD+V1kRjxCvio1Fb6hKF0Op1DrHXOeWqBrhDXp2JeBDFeA1/mujTl/Hng?=
 =?iso-8859-1?Q?FdtbaYUvUwOtfHLWvaAg7ryNCQsVLzCD4x4Eh0WZIwYq38Q5W0I1U/Qmbm?=
 =?iso-8859-1?Q?I3h12+SmEyj4vFvhVoLRfQQHBeNeEfuJ0mry4nL3WsHSGodrKxumGUu+fC?=
 =?iso-8859-1?Q?+ESonr8r8S+WqTQahk76RLukzoS1/tyCD08865ez2mSQAjPyhaXUVz1wDq?=
 =?iso-8859-1?Q?h6sWfnCwLqkj97cHRf4hPM8zD15/GuJie1jFkTXy+wGE25kFqXlq2sYkTX?=
 =?iso-8859-1?Q?e8dpDmYJWzTcJJSM2hheL0E+6R4yD3D1taTpgeRcJaVyKQhwRGYjLjQtnI?=
 =?iso-8859-1?Q?jkdrUtZufTwKAc3xIqVu2gIIS3jjNwXJXeWL53MLzMF+umqSpQiJVcVtxb?=
 =?iso-8859-1?Q?zdzqaRAih0kaPtOEtffNPMSZJroNVrnJasS1/CveZwHULBP4fuiBNd3aNN?=
 =?iso-8859-1?Q?BguBjLI+zlIIy1Tv8toYAw59idGtMw8OZkzIZpB3NRQM3wLHEfuEPUylxt?=
 =?iso-8859-1?Q?J40bCeYTGjLZbJEjeDzwSuxNCtSWRNYS2PwUt55TmebcBd8Id5OpfGWXLR?=
 =?iso-8859-1?Q?u/uh2O1CesK97Fa0gdfiZed55+cpjaHOggwVZWQASoWA+TFF4JK/7FmWEZ?=
 =?iso-8859-1?Q?GxxTXEF0IewqTDSNknnQ4NAdjPx49VAub7h5AJOWAePzAXtvu/qbfjrpj9?=
 =?iso-8859-1?Q?wmYv09qmXvR9gAMAAev6bJFm+/AZefT2SFwkvIoopBw0yA8EwwMgapN/Zx?=
 =?iso-8859-1?Q?1epRHUM4mnzvvZBMteE1ufAOSRLlB58m7xA5sLtTRwL+WYsj3BqR4eX9QD?=
 =?iso-8859-1?Q?EmVTEetCgk+cxynQlqoxtEjgRBzqx8TQwqMheDEdeBoVB6rPHpoCS6YzzO?=
 =?iso-8859-1?Q?qLonaah0bOvp0sCJSjcSHKIA976B4TfGQRm9vOqUqvJQDWfETax4mV6XZv?=
 =?iso-8859-1?Q?PzJ+5Sod62WRomPao2qvBcJoyrYqfCkbaPg5eVi6FD/7uTg+XMpU5UZQ9f?=
 =?iso-8859-1?Q?oYYDddbgk08KpYfgA0YIefBzp1gMl6ouD+NVthXaxqWGeBAeQWCzYVL8hE?=
 =?iso-8859-1?Q?dpQykO7vNzhG9Bq9TnzQJwVeZHZSkCXn57JdrDgnVHjccJBQCec/vT7nWA?=
 =?iso-8859-1?Q?C0WFzxi5qw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984043de-b7cc-4f79-b332-08de63abb137
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 05:10:19.6322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQ8h2SP+5tLSXfs4GVYLFLWScsSOHKIUEehICPrJ447nZXherCfToq9OQV0fzkEDYsGnqAH2RpvID6PxWOO+wftRMluoxFFareDjNdK+AoA=
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

Hi Cedric,

> Subject: Re: [PATCH v5 09/12] vfio/device: Add a helper to lookup
> VFIODevice from memory region
>=20
> On 2/3/26 08:30, Vivek Kasireddy wrote:
> > Instead of iterating over all QOM devices to find the VFIODevice
> > associated with a memory region, it is faster to just use the
> > vfio_device_list to lookup the VFIODevice.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/vfio/device.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 973fc35b59..ecb3581fcc 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -644,3 +644,26 @@ static VFIODeviceIOOps
> vfio_device_io_ops_ioctl =3D {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
> > +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> **vbasedevp,
> > +                               Error **errp)
> > +{
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        error_setg(errp, "Could not find first ramblock\n");
> > +        return false;
> > +    }
> > +
> > +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> > +        if (vbasedev->dev =3D=3D first_rb->mr->dev) {
> > +            *vbasedevp =3D vbasedev;
> > +            return true;
> > +        }
> > +    }
> > +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
> > +    return false;
> > +}
>=20
>=20
> This won't compile and break bisect. Please merge with the following
> patch.
Ok, I'll merge it with the next patch that adds vfio_device_create_dmabuf()=
.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.


