Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18E2CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9VI-0004lU-1Q; Mon, 12 Oct 2026 02:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9VF-0004km-Vb
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:27:17 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9VC-00059U-Si
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791786435; x=1823322435;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Z1Rh40yIsvTwbl1/mO3gUUZCzmhDvKE//LSN92kjNUM=;
 b=Lh/8FrhIdoiTu8NF2Z+hSR3FZy2OiVNtFBCIFMYrgvQN5j0JrTxMbm06
 VarjwvA5ln3rhTTE8yEZq9zSnmGhAuyq+KD14RwHN+7VAegPCg1dE0IwD
 Bf2nHMcGhgzvAsgTYivDn7+VqttFcVrRHgk+zhjU/vz0Of/mXVTqJahEB
 B/ja7BanseUrW5LAEEdaCv89FQEhxzyMI9mKS3pdDgivHar56BbvUMXGR
 WyYseNRCuAs5bTX096oNWLoam2TMWK4b+6USLffMWHwa526/D2zi7zwA7
 yc7mJlINiKqpp/R4cvvg8/J0xy3dLaagwFmj5DUjoB2FTEuTTfOESwL6U A==;
X-CSE-ConnectionGUID: HgdU50YwSCaHT2btoe9ZFw==
X-CSE-MsgGUID: BfJ+Xo1eQU+iTWFu69r0EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="490357"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="490357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:27:11 -0700
X-CSE-ConnectionGUID: beQlvCZKQHOepS6Gn3oKPA==
X-CSE-MsgGUID: C0b4s3SHQyqX0XU9b2zBTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1175076"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:27:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:27:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 23:27:10 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoOW75X3VaUY/oaNGCu7lYsU0eyx4K2AIgTXT5OUrR3tg8s9o6eOAmuGNGi7zDxNHz8K5Tw/s0BxBA4B3in9fAmEZPI/eFqBIK8YYIZsPtqA2Ujv5ygj1o06OxvW+9pNroIe2t21hbOAtYG7yeTdBHbJVm6ymBgP+3/Rh6UEmaZrN1LosjxBSVRhpLzXTwI3lSdiImwy0u0Nct3Er+fmp4v6pgZ9xjogTXZicTpO3KrPn+YhXI/EDJWoEhgwKxfrtq24nyQuz7nZWjYC3hQ9WY/i1WfNboOab3d4OZ4YYBiTHqoB2GdzfPzaLj7FvIYKmRidTdY6M6MNZ8ZSniEM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffqUl9RRToQeR24bVYX9OaB2uIhYU7URhEUtKWIAB+8=;
 b=q5mkJhUTXl4lO54byy3Jt4MKcE+JQcsGVBJF5HZkYRAPdHOkV3FO9LD594lVyNPD9gkk+lEhg1wKSG/BTZdYSvYYhyuVRAFecFuWKiWQjQFfbKU3jDqFQ/Ft1WXvMEKJ+94DzCneyiS9CyqGpV1bCtVFp0zbZQNFyiXhO/tBhPo69T1EEyGRP/A6//wcFuCegIaKGUjxZotZeQo2l61HhyirUpOBx5rj6zyu3r0fVECk2u5m9Zq/yS/zIEaSWm7SQtYWq0vVoQpt4jDdBya4ORGCU2mQpiNnMx3ViyzcTC+INhp3jKwd5AMAg2anwpfYYtK6jnjTkbpDjcSDBxUOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by LV2PR11MB9598.namprd11.prod.outlook.com (2603:10b6:408:379::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 06:27:08 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 06:27:08 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
Thread-Topic: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Index: AQHdVphlAJLtaSnr1k+pnx5j3pf8VLb03vkAgAQUeTA=
Date: Mon, 12 Oct 2026 06:27:08 +0000
Message-ID: <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
In-Reply-To: <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|LV2PR11MB9598:EE_
x-ms-office365-filtering-correlation-id: 8efdc6be-851d-4dfe-47c5-08df2829d76f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|56012099006|11063799006|5023799004|4143699003|261009223027099003|260925022911599003|260925021311599003|260925021911599003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: BmcV6InTHx0psQaCB6Lg9WDvfQzFpNlJfBVBMYUI4aLCt7Lq+ijVThIheRCn9bsUz3oGl+NPka3q6VNCnaMp2Ch1SHY/07BHAo+LdCy6uI2L++uMHjy17R/Q/Ik8GjHdzUzj1xr2gCx0eu5ol/dkg3hWjUK7Iabs68tTRCvN3f9wax3yzyJzpFHdo78ZkiLK4zVj9IgQnh6H3kmBFEDlarrhqFpIvZyTGzmyghD1prY9Evcn6zew+KL9rSsB5ig4uLxeJdTTAI/YxKM90vwKMXorJC/XAXGJuaRDM73+B70PRS4OOd4s2K+gRs0UuQBncU0QlpopLgzO33zE1b9D24V9U7cpgLSq+yVy3uMtCqiW8UOxGN9sOZwNcRduWtZqTsPG1J/D4Tpwa0vBKvMXAHaYw/3M6hOX2oUxNEMyMr8RfTrajHBZwDZntDby0DZ5w9dH2c5WRyeFR9e5oYn36GDidZwFm2Pds12LzyUMpBVI7CZiy81eB+9/3WPMYzZcoanV+XW6QtFPsWmQDUL7hCUGCvDxOMNUP4tFT6IEn0D10SdYYCAsM9NPIsu7MkmrTl3kwFv9XYGBxRkI5jez4LcGbIY71oWhxWa0MuoUndbNAE9keneEVdRtaGaAC9vWolc2NdTMaRtaf/0lZNqu9eNUkJcckKUAEygr9UjcoRt3xKaDqDcNjjVudUObft6zvxxcH16fpm15OPPKnZOIxPySGWclpfCPvdHsGUij1kY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F9tVFY5LbjHuEJojVokHhIPsGoGh1vyrbApS2l7UVZcDCCP2sNDiCpqqOj?=
 =?iso-8859-1?Q?1/CQr4yOlJo8tJWz74+Q9bH/lFNvoGRxfx9ThjwnUxBsxKeI6dbLDLWPje?=
 =?iso-8859-1?Q?D7/sFRk9obVuqdSK81LpnHEK8UmiJ6PWMsQXonmD19iehBywj1bBLaFoiF?=
 =?iso-8859-1?Q?OU2tDoJkQvXVrlTi9m2BHrBlIbU6psFvdpgf15Y49CkjJ3h3t3CdYyja/l?=
 =?iso-8859-1?Q?MbRUER7AgkPvg8qyC2vlXhrKPqAR7zsa6BgmoolhObpfDpQQrYA6FVuQHb?=
 =?iso-8859-1?Q?crGSPS4ycEH8mFshvJCkGOSi1PcdP5ZHOmUY/4sD27DiVZff5eVanw6yc8?=
 =?iso-8859-1?Q?2bFAkOg3QIOHHjx216qzEWgv5XcOIlY6xjW9vTiw/6RBhEh4YBh0LT2Nei?=
 =?iso-8859-1?Q?DY7kx8RsP/N7pY5EO58NS9PgQS6uvz0pKxGYk1DYyuwy1qTrJZ4plAhO+R?=
 =?iso-8859-1?Q?yMG0CpZPycnxK/dPgEOGZgl9PUMwxseq5Eum9Nf0PVLBKpSogYkdg66YkN?=
 =?iso-8859-1?Q?5wc/EDA080wYUtWqiHJfhliw5ISLus4bY93R6UiM0m+8bO+n8sc7SJ1HMr?=
 =?iso-8859-1?Q?mmPMVrc7qVk+q6N7H2BGzU5HJNx+A/taoRYiWKyZ4EKOFYQCqa1QrwAelI?=
 =?iso-8859-1?Q?lpa3jK4EamRLhVIK/WIP3YYLrE8uPSeii+U5V8P7VHROWKUQ2QOOJynvwx?=
 =?iso-8859-1?Q?+ldp4I/ZW8rntwcCERgIjDhYPMeYCsoH+Hh1In/22Be6IwxD0agMn6i5/o?=
 =?iso-8859-1?Q?oOzGltvDxAfpCN8BjII8oDn9p1IrTTf/Y4Mzv1yldvLqz6vCjWHRBZ0JiA?=
 =?iso-8859-1?Q?GSuWHAAQWkYLHwAE/KKo55qceP0Xd4Sag1BpQlGWUzS3Jq6zfGYBykG4b6?=
 =?iso-8859-1?Q?cjzN1RnbqH44BXu/lEOlHOWag/JRvFCqAFVO/ueTzXj9SVNNjPohWUyf/4?=
 =?iso-8859-1?Q?vRz1m/66Xy1FsgP1vfEB5rmS4W6zzQdLDIiS85N81JRuAfSaiN5k0/YSLf?=
 =?iso-8859-1?Q?4DQDSh9sQIuGLU4hB/dDMwafHzMyc15DKfEfzTQfH8ynoNGqc1eG22q7ce?=
 =?iso-8859-1?Q?1J9YXqQ6JSC+xHZ7eIq/HWBH4n0lFJa9cGmgnRmWg7vPPY9EGJcUX5fcbO?=
 =?iso-8859-1?Q?AtBPZTo4KN5llbXh9V4wMoTuUD+4X+aMssuXAcjdPhSWyYVtncV5g3zV4T?=
 =?iso-8859-1?Q?jSCnt65I6gKwW7K7n9zCyxQ+LoxoUKcmDEs1QyUefaoWiFJouOMA4Laud3?=
 =?iso-8859-1?Q?x+PUzj7T2KJjKOA8mapiT63PR/11vRe6jLib/71U/045b9Xzq8toSiRm46?=
 =?iso-8859-1?Q?VkPsUcbV11HQ2sJgd5kgkdDrrzi3PEX4syTGqF4BueK7HLAkCQkuQzUUD8?=
 =?iso-8859-1?Q?QQTHOW0maSFaysN/hR9P3IDnqhnBkf09uakuKPQOR41BKMZMy0OxYPBucW?=
 =?iso-8859-1?Q?4GttOaYaneTtUKeMhOMCUQIV8kruSlvRCxMMS+/2tr8j+W4FQCqhVtVgvK?=
 =?iso-8859-1?Q?MulWyWaybRIdzXNu36jp1clWvx7FAzBVF4U/Eo/pU1TEZ29+recGJluDAH?=
 =?iso-8859-1?Q?Bebm5h9xtQVgc5Iv0v3BEyALPX4LLNknN2LkzDT2pzUhlA27IqkRD067qz?=
 =?iso-8859-1?Q?/XJKtzl5KQku6Y4iWVnE+YXRHyIxtZNjYEenPf7PKVPL6Pw7EbUR84DVRk?=
 =?iso-8859-1?Q?UhDU7sG3V877aMEne/3E6Z2y2gWSXKdokiLuH9MiK0Ot6s88G4ioXuVwoz?=
 =?iso-8859-1?Q?SFT5fhk/+SRrGaRRbtusdhjGt67Ix49SBAFlqJc14YkJBcq2NOrruQyDen?=
 =?iso-8859-1?Q?qzd+psIz9g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MKE2u0ZhmIyF161tI0vxDvP1B6/M1FtsIPxVLclmALxB3/GdJSwp+GkBEJ1V42/xq/tsNMDqs69B5d0IC5xcCNTVoHvmWR3Gj4sbemSPUPIP/vstNERKCJA3+R/1fEg+gX8JQr7UJ8qySXzPUrX2Buuq8LBUMnf+0C1OYS+YRpkXwZEhdh1QYjO56DZhLOXGm/Dm+4qIa/p+9yMUdU7z6eUcUU9sGrs/C3dM+wVeNNAaxXz78dFUXtb63rQkGc9Pw2hbhV0yx9dKtdqnt9okqb4d69tQabDZD8pUBWphlzvRgpR36zC6ZXU2OBsaQXE9Ny7WyMVXZ9tkpdduCMJdQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efdc6be-851d-4dfe-47c5-08df2829d76f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:27:08.2545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ep3GVn/ztbJw5sboKjS3DeJbN4UrX1+I8d2RueHUIWwr/R3XqJMXHY1W8PsFCuOrK0s7ityRATl3OkEmAmi5SI/TJarqZ6qO7ZYYIS4Qxpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9598
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
> from multiple ranges
>=20
> > In order to create a dmabuf associated with a buffer that spans
> > multiple ranges, we first need to identify the VFIO region and
> > index the buffer (represented by iovec) belongs to and then
> > translate its addresses to offsets within that region.
> >
> > The qemu_ram_block_from_host() API gives us both the region and
> > the offset info we need to populate the dma ranges so that we can
> > invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
> dmabuf.
> >
> > Also, instead of iterating over all QOM devices to find the
> > VFIODevice associated with a memory region, introduce a helper
> > to just use the vfio_device_list to lookup the VFIODevice.
> > And, introduce another helper to lookup the VFIO region given an
> > address.
> >
> > Lastly, introduce an enum to return the type of error encountered
> > while creating the dmabuf fd.
> >
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   include/hw/vfio/vfio-device.h |  22 +++++++
> >   hw/vfio/device.c              | 109 +++++++++++++++++++++++++++++++++=
+
> >   hw/vfio/dmabuf-stubs.c        |  17 ++++++
> >   hw/vfio/meson.build           |   1 +
> >   4 files changed, 149 insertions(+)
> >   create mode 100644 hw/vfio/dmabuf-stubs.c
> >
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> > index 8472420d3f..c05430be8a 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -41,6 +41,13 @@ enum {
> >       VFIO_DEVICE_TYPE_AP =3D 3,
> >   };
> >
> > +enum {
> > +    /* The Guest passed addresses stored in IOV are invalid */
> > +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV =3D -1,
> > +    /* Guest or Host may be at fault for this type of error */
> > +    VFIO_DMABUF_CREATE_ERR_UNSPEC =3D -2,
> > +};
>=20
> Nack.
>=20
> As said a few times already : it's a VFIO-specific enum leaking
> into vfio-device.h to serve virtio-gpu's fallback logic. The
> cleanest alternative is to use standard -errno returns and
> make the fd an output parameter.
It looks like Cedric remains unconvinced about the value or usefulness
of this error enum. Therefore, to make progress, I intend to adopt his
suggestion to use standard -errno returns for the next version, considering
that this series has been stuck for a year.=20

AFAICS, dropping this error enum means that we would not be able to
clearly identify and log (or attribute) Guest vs Host errors in virtio-gpu,
particularly the INVALID_IOV case. I am not sure if this can be considered
a significant limitation. However, if there is a reasonable middle ground
solution or an alternative that you can think of that does not involve
using VFIO error enums in virtio-gpu, then I would like to pursue that
instead.

Thanks,
Vivek
>=20
>=20
> >   typedef struct VFIODeviceOps VFIODeviceOps;
> >   typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> >   typedef struct VFIOMigration VFIOMigration;
> > @@ -323,6 +330,21 @@ bool vfio_device_has_region_cap(VFIODevice
> *vbasedev, int region, uint16_t cap_t
> >
> >   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >                                   struct vfio_irq_info *info);
> > +
> > +/**
> > + * Create a dmabuf fd by first translating the addresses in the
> > + * iovec array into VFIO region offsets and then invoking the
> > + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> > + *
> > + * @iov: array of iovec entries associated with a buffer
> > + * @iov_cnt: number of entries in the iovec array
> > + * @errp: pointer to Error*, to store an error if it happens.
> > + *
> > + * Returns the created dmabuf fd or either
> VFIO_DMABUF_CREATE_ERR_UNSPEC
> > + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> > + */
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp);
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */
> > diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> > index 4f11959633..d95503a5f1 100644
> > --- a/hw/vfio/device.c
> > +++ b/hw/vfio/device.c
> > @@ -21,7 +21,9 @@
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >
> > +#include "system/ramblock.h"
> >   #include "hw/vfio/vfio-device.h"
> > +#include "hw/vfio/vfio-region.h"
> >   #include "hw/vfio/pci.h"
> >   #include "hw/core/iommu.h"
> >   #include "trace.h"
> > @@ -667,3 +669,110 @@ static VFIODeviceIOOps
> vfio_device_io_ops_ioctl =3D {
> >       .region_read =3D vfio_device_io_region_read,
> >       .region_write =3D vfio_device_io_region_write,
> >   };
> > +
> > +/*
> > + * This helper looks up the VFIODevice corresponding to the given iov.
> It
> > + * can be useful to determinine if a buffer (represented by the iov)
> belongs
> > + * to a VFIO device or not. This is mainly invoked when external
> components
> > + * such as virtio-gpu request creation of dmabuf fds for buffers that =
may
> > + * belong to a VFIO device.
> > + */
> > +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> **vbasedevp,
> > +                               RAMBlock **first_rbp, Error **errp)
> > +{
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        error_setg(errp, "Could not find first ramblock\n");
>=20
> no \n
>=20
>=20
> > +        return false;
> > +    }
> > +
> > +    *first_rbp =3D first_rb;
> > +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
>=20
> wrong list : global_next.
>=20
>=20
> > +        if (vbasedev->dev =3D=3D first_rb->mr->dev) {
> > +            *vbasedevp =3D vbasedev;
> > +            return true;
> > +        }
> > +    }
> > +    error_setg(errp, "No VFIO device found to create dmabuf from\n");
>=20
> no \n
>=20
> > +    return false;
> > +}
> > +
> > +/*
> > + * This helper looks up the VFIORegion corresponding to the given
> address.
> > + * It also verifies that the RAMBlock associated with the address is t=
he
> > + * same as the first_rb passed in. This is to ensure that all addresse=
s
> > + * in the iov belong to the same region.
> > + */
> > +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
> > +                               RAMBlock *first_rb, ram_addr_t *offsetp=
,
> > +                               Error **errp)
> > +{
> > +    VFIORegion *region;
> > +    RAMBlock *rb;
> > +
> > +    rb =3D qemu_ram_block_from_host(addr, false, offsetp);
> > +    if (!rb || rb !=3D first_rb) {
> > +        error_setg(errp, "Dmabuf segments must belong to the same
> region\n");
>=20
> remove \n
>=20
> > +        return false;
> > +    }
> > +
> > +    region =3D vfio_get_region_from_mr(rb->mr);
> > +    if (region) {
> > +        *regionp =3D region;
> > +        return true;
> > +    }
> > +    error_setg(errp, "Could not find valid region for dmabuf segment\n=
");
>=20
> here too.
>=20
> > +    return false;
> > +}
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp)
> > +{
> > +    g_autofree struct vfio_device_feature *feature =3D NULL;
> > +    struct vfio_device_feature_dma_buf *dma_buf;
> > +    RAMBlock *first_rb =3D NULL;
> > +    VFIODevice *vbasedev;
> > +    VFIORegion *region;
> > +    ram_addr_t offset;
> > +    size_t argsz;
> > +    int i, ret;
> > +
> > +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> > +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>=20
> return -EINVAL;
>=20
> > +    }
> > +
> > +    argsz =3D sizeof(*feature) + sizeof (*dma_buf) +
> > +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> > +    feature =3D g_malloc0(argsz);
> > +    *feature =3D (struct vfio_device_feature) {
> > +        .argsz =3D argsz,
> > +        .flags =3D VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_DMA_BUF,
> > +    };
> > +    dma_buf =3D (struct vfio_device_feature_dma_buf *)feature->data;
> > +
> > +    for (i =3D 0; i < iov_cnt; i++) {
> > +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> > +                                first_rb, &offset, errp)) {
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
>=20
> return -EINVAL;
>=20
> > +        }
> > +
> > +        dma_buf->region_index =3D region->nr;
> > +        dma_buf->dma_ranges[i].offset =3D offset;
> > +        dma_buf->dma_ranges[i].length =3D iov[i].iov_len;
> > +    }
> > +
> > +    dma_buf->nr_ranges =3D iov_cnt;
> > +    dma_buf->open_flags =3D O_RDONLY | O_CLOEXEC;
> > +
> > +    ret =3D vfio_device_get_feature(vbasedev, feature);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret,
> > +                         "Could not create dmabuf fd via VFIO device")=
;
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>=20
> return ret;
>=20
> > +    }
> > +    return ret;
> > +}
> > diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> > new file mode 100644
> > index 0000000000..fb5318e929
> > --- /dev/null
> > +++ b/hw/vfio/dmabuf-stubs.c
>=20
> Fails to build on MinGW/Windows.
>=20
>      hw/vfio/dmabuf-stubs.c:12:5: error: no previous prototype for
>           'vfio_device_create_dmabuf_fd'
>       hw/vfio/dmabuf-stubs.c:19:7: error: no previous prototype for
>           'vfio_device_mmap_dmabuf'
>=20
>=20
> > @@ -0,0 +1,17 @@
> > +/*
> > + * Copyright (c) 2026 Intel and/or its affiliates.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/iov.h"
> > +#include "hw/vfio/vfio-device.h"
> > +
> > +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> iov_cnt,
> > +                                 Error **errp)
> > +{
> > +    error_setg(errp, "VFIO dmabuf support is not enabled");
> > +    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
>=20
> return -ENOTSUP;
>=20
>=20
> > +}
> > diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> > index c7c31b78f6..aa6f4bc1b4 100644
> > --- a/hw/vfio/meson.build
> > +++ b/hw/vfio/meson.build
> > @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
> >   system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> >     'display.c',
> >   ))
> > +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))


