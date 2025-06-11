Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D80C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 05:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPDgo-0000ZB-Eb; Wed, 11 Jun 2025 01:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uPDgm-0000Z0-Cm
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 01:07:52 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uPDgj-00058Y-Rw
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 01:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749618470; x=1781154470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M+W08ZrlzrTxJ0cMQYlAgn9B/bszBUUDI3IWD1cBETM=;
 b=dQU83T0xjcLo708blvpepWmn3nxdAhO+7FOtaeELEZaT93LjlgeEPsXK
 0JH92zi/3RBWZF/vPpoCNXV0piKQvW/cPcDPRN0FpOd4CeN32ZB8j1+uK
 hQKIp3QKS7jyeTL9/IKym5VsP2u2h6acybQMYPsp54g1i9tqF57YS4I3l
 ZRLFg0WQC7QZ7hvSocUNUsH9v0H3hdpJRXzbbDeTBt9picerk/sWIXfYp
 kQbDieRvUDzCpMtEGFr/+jBigL2pGoVVaVpbF+HlAXBG1TXtGalDXgPwQ
 ydiCYy5xq/zykd8eCEK4vODvfA4dwbT9UzuxWz3vbOknp2AnXZ8Wm98HQ Q==;
X-CSE-ConnectionGUID: EuFSfrNKQfKsCWj1TfVFmA==
X-CSE-MsgGUID: pv9rwXMqTSamCqvNtCsjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="54377184"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="54377184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 22:07:44 -0700
X-CSE-ConnectionGUID: bQLb6TISRtOgWoKMn/8I1w==
X-CSE-MsgGUID: LFWX6/+EQhmAGKK0EzBWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="147559477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 22:07:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 22:07:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 22:07:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.74)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 22:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adm7V9BysJfWYz1Y/HdOpeV5oRPxL+gWU72Ps2K/CawsjNOJkgbqoMU546L5DwIZHEPaWpzpVwcptWG3ebOqpdWfWUetZHXVbsexS4kewJBeCWmEHYY+oiT7JLNvqqWaH5RcKxtvywDjHiE1pOUgSe7EyU0YzHDIzVgGevJyW0zPGgKDLy6hMxsxcotNiHYpFmfOsG3XnBcP8RYUKdRow1BHzdwI5fduHLoQTgLkwqxdudi6XOl+WpcBme05KYOBh9VOX2jcEA9Fa5XOusyII64y46WJVw7SCR6vQfnT9KpYj+4sKU4ygqya3Qbkk5B4AeuHD+zRpCQbIb2wR9bJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+W08ZrlzrTxJ0cMQYlAgn9B/bszBUUDI3IWD1cBETM=;
 b=FVNIip+J0mqqxw4+/xF3ppzSIXu/egiDfGzRA6XaoqKMQ29rMpntDYDG9LuAzSmqJ3HqlcV1K+ITjIHLcQVuxBB4QmZKoZZM5oDM4ZOAsjacT3vU6fVbku/kd3ZDyUUAi/bL8qBEvEzYIlXQKCg6XNtPHH9Vc9e0INPDg25OScAWMDmO6expPxZnfIWicW0xPgsFR4Xrr9xGPsRWIVAQ6bgLIgEQP5K2zl/M7owlU2CDyTlsFtKPG5lMa9Z1ZvJ6tILUMUakhlCI7yst+05VgH7z3sIgQbhmPf7qWqH8tu3Ky+w9vf/2Zf+DmsLLelTyz1d2v6AddeUjjamHDSn/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.33; Wed, 11 Jun 2025 05:07:25 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 05:07:24 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: Frediano Ziglio <freddy77@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Kim, Dongwon" <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: RE: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Topic: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Index: AQHb0Fi8UW3vff7ct0Sn43ua8j5j4rP0SwiAgACmDjCAANPxgIAGkGQAgAAOEYCAARQMMA==
Date: Wed, 11 Jun 2025 05:07:24 +0000
Message-ID: <IA0PR11MB7185B8DDA319100C799FB9E0F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
 <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aEKVmH8ZxDcGKSeq@redhat.com>
 <CAMxuvaz1wJw-qMDDPwj_BOGPL0zdgBsi647B6+AG+OdOOomhDQ@mail.gmail.com>
 <aEgjHdDScyiuF4ID@redhat.com>
In-Reply-To: <aEgjHdDScyiuF4ID@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS7PR11MB6037:EE_
x-ms-office365-filtering-correlation-id: 7f09e427-cf75-465e-89bc-08dda8a5dab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YjVlS3E5eWJHY0VDZDNqWkxFTk5LeUwvNllWdmlxNGRZRUZtemdBMW5XYnFq?=
 =?utf-8?B?VlNFd1puYVUvVGkrZVZCMGpVd0tlaFluWjl5V3ZYbHpGcnE1MWQ3U2l6UWhD?=
 =?utf-8?B?eDlzUDAwWlRiTUxzQ0ROdkEvd3hpRWdtWmwyczhtSlNIWkxKUVcyaEVLVWFz?=
 =?utf-8?B?S3ZON1ZiSHNYTVdCb3RDeGlqMlYrb3E5aWFPemNmVlJJbEVZcEpoVU5WNVJM?=
 =?utf-8?B?WFM1NXVvcFVLSUV3dzlDdUxJOUF0UzZqVmtkdy9GUFN2OWJHK2IyQU9KQlJT?=
 =?utf-8?B?dkQwd20reEJrSG83SGJCVUdMZjhKMEtMd3pNbUF0NHo1clB3WUp6R0JQVHVj?=
 =?utf-8?B?TzY2RU1GWjNSK2JYNXhWR3ErV1RpUnovNWg4aHJhKy9nUlUzc2RsVTJ2S3hT?=
 =?utf-8?B?UmtSNHhGTDl5RFlLTzdEbFFFd0RMd0pwQUZkcU1ydnh5MjQ5bUxGdHAydzlS?=
 =?utf-8?B?a1Q1TGRZaElFZVhrZ1NEelF5SCtwd0h6VDNYV3FqZlRZYjBjTGs2UG0vTzRx?=
 =?utf-8?B?VFhpN1F4amF1b3FXTkRtRko2SnZVcXgrTGZ2WmtBdElUdXRoZXBQMU1UZGM4?=
 =?utf-8?B?N2d2K01jMmlldzU1UFFvTzduSmFpcjJ3ei81Qjd1RTMzRVlmYWdPUThmdUpw?=
 =?utf-8?B?aGRvdkJxMXU1N1B3dnl1Qm9STmpjSzFGUWx0TmJLNFN1VGpSeEhjV205UjhC?=
 =?utf-8?B?bGtZOUlOdDFGQlhJMnZSelU1RE9tNEtyaDVKLzlxaGpiMWQ0NlFuc1NHZllD?=
 =?utf-8?B?aUdRVk1iWno1SjJqMmgyMWNJWFZQV2dWYkgxdFl0eisxTjhzeWZPUnRGYmlH?=
 =?utf-8?B?NnBpLzBpRTVYUnBHZy9zRmRPVW8vbGtoYk5tU3EwT3ArR0Q1aVVKNG4yZUFG?=
 =?utf-8?B?YVR6TmdNcXgyeW5KR1JKQklKcVBIbENuNHJDeERpNFUwYUdxWWtid1o5Nkpv?=
 =?utf-8?B?L2pwa3NqWHcwUlZpWjcrR20vWHZEVE9BSkZJSGtKUDNIRWczT3dRN05XbWh1?=
 =?utf-8?B?YWNURDFDQVZYTnhDNDNERmxTc1YybG44K29BemVoSHJWQ1RiaU9udU1iYThH?=
 =?utf-8?B?TzhRVVhHSGd5UlNwNUxxb2pvUUp3bGhGLy9ROFk5Wk5GejdUQlNLTmJBdWNv?=
 =?utf-8?B?REpiSk1RbFl3NlhGaXNNd2ZUTzc0ZVIzNnNrTkFKU2VWZTFwSS9SZXhzRjla?=
 =?utf-8?B?bm85SndIcDhoa3lNYXFaR25LZGdKTS96M2tZbUNISHNQeFNPNGZCNFEza1hN?=
 =?utf-8?B?aElKekJpa2FPOGNoU3dNQXdqZlp3cEhEeHBBOTJMN1JFLzEwQTd3eThxSVM5?=
 =?utf-8?B?bUJwcStSM0lIUUlnNkRXQUJaZ1lRRXE2K1Q2cVpUc1lUTnNoZ0RwNnBZRGpL?=
 =?utf-8?B?enBSSmxjR0pEVFBIQ3JaMXJLeitmb25tYS91YzFOSFA3cEFPb0VNUFRsUGZT?=
 =?utf-8?B?NHlKbGJzNWFldytrTXQ1WW9oSVVXTUZGZHdBdVFpYTFRbnBoQjc2bURFZ3o5?=
 =?utf-8?B?Z1pORGhsdnZoVm9FZXVFeFJuby9aQW03UWlqYmp1UDAvUTNNSW1KUGhRMTF0?=
 =?utf-8?B?SXpRbVR3QTNSOHFHMk1YRy9hQmw3MDhKMC9hQUIrczNPYXRRYzlXQjVnUisy?=
 =?utf-8?B?eWdZdnpJQmtrckZadVZON1Z1dnFQenMvaHpTcmQ1K2lPZmFSTFZIOUtiSEtK?=
 =?utf-8?B?N29lbzBVQjRZeVRoVmIydDhXcVhpZ0NKWE9XTVl5eVVKWTNQN0dNd3RCUVAv?=
 =?utf-8?B?NERsc01PZ1p0cWxkcnVZOFFSY3RVSEdvQUcyM1Jxc05CUnNSY2tteTcwTVNH?=
 =?utf-8?B?YldzWkNHVlFtNnlidnB1VFEvcDBEOEJNeGhneGUzd1pFWVhmSTZnUzQyaWV5?=
 =?utf-8?B?MWQ3MnAzSi8rdzc5a0V3dXNYa295a2IvYk40R2dDNFpad1hJQ0h2NDV0SEpu?=
 =?utf-8?Q?XvjixlD/CY8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3dqVk1VcTh4Nlg0b3drU3NBekVPUkhReEZVQ205b3NVRnMrNUptSzZxL05B?=
 =?utf-8?B?MHRMMW1tREVQOWxoV2FyMGxPK0hFYjBTM0JPRlQ3bGJCQ3NEY1hZVXUvY1hU?=
 =?utf-8?B?bUIyb0RUNnNmSjBWdCt4YU50c2ZEbnJKRUNJUW1sQ0Z0WldCbjkxV0Z3a0FG?=
 =?utf-8?B?N0NlbVF1QmhmRjF0VDZ1cnVReUhmUzZ0czcwSUt4UnUzaVI2WDBBVmxJaUF6?=
 =?utf-8?B?dFFFNUZPNnRlMyt5VXMvcmdsOGRKVUQxeWE2Wk1vSmhJTkEwb1FEUnFxNnV0?=
 =?utf-8?B?bnhpL3VTODVHVWNiMEhwOHdabG0rdlhCcDRoMUFaMWM5TlBmRjI0amc2OHo0?=
 =?utf-8?B?NDlBM3A0Und1bStwNVdaUEhHRXVBYXp0S3pLa09lUUQzOEJnV2JaUEtBUnlt?=
 =?utf-8?B?RzRCMzhsZlB2emxFaEJVbUtoUU04MlJTNWdjU045YVZWR3ZpQ3dhQWduUS9J?=
 =?utf-8?B?cmtJZlkvZjU1VHZXczd6LzVRZzZUT2g2VFpmTVhvakNZSDFJV1BxaEZmQThX?=
 =?utf-8?B?cWFmblRhWWpmUFhIYVFJRTVRYjZWd0ZJeHVmWjFjRmE2RXpiUlhKQnRaeG9Z?=
 =?utf-8?B?RXFxYWludmpVNEFLNE0waFdCSC9OVEFZK3ZzaGlOS3pmMDJSSTdHcVhpcTNn?=
 =?utf-8?B?Y3RjV3Mzc1Fkak9EZGQ0UGVNNVBPRm1VOUViN1VEZVVvRHdiTmo3Z1pLTjk2?=
 =?utf-8?B?MEtpb2t2L0Z4Wk9BcHlwR0owcDBQVm9lQk9NSmtlOTdHK24xNVNvS1NHRGtR?=
 =?utf-8?B?aENXN005eURrcUtMOXJaSFFGM2xOcDg4K2N5SzZiczg4am0xY2Z2SmoxRjl5?=
 =?utf-8?B?eTZ1SDVJUy9KNEU1cXhvTzlqMW82bjNtK0FDZHlzVkhVSnQ3QytLVDRwcUZl?=
 =?utf-8?B?VlZTa0plMVczdGhmY0Nuc2xDTGVCVEF0aDd1eWdXRUVYVHRleGJkRmtlVWMv?=
 =?utf-8?B?Y1RPKy94cXhEUW01aDV4aWVmaTRIRjMzc0IrUWNvTGVXQ0pFUHhBVVQvTmV0?=
 =?utf-8?B?TVBPYXdtRldibTEvNE9zK3FqWGZvVUN6eHI1Ump3emhlam0zaS9nMmNybytM?=
 =?utf-8?B?cm9ENVN4a2lROGR6clkrNitOU0hEUW92SktlV0hxTVk4Q1UwYk5LTEtaeDAy?=
 =?utf-8?B?UU9oYktzS1lnZE50OEp6Mk1nWWlTRi9yOGVQOG1raTJ0ZTMvUElKMU1pclJ1?=
 =?utf-8?B?eWV2M3ZJa3JxM0t1V251SEc0QUY5bUZXaENRNlh2amVCWkRtaVFUbG85TEVD?=
 =?utf-8?B?TEJMdkRJN3ZUQ3FsM3hUaDRkMFdWQ0FrTVJuaE0vaWRJTG4yTzNrTUU5NTdj?=
 =?utf-8?B?ZmhFODlnQUttQmRlSHNuY283UFVLNTFEbW95aXJSQ09lZmhGV3lsdFU5OG5U?=
 =?utf-8?B?Q1hEaXljdTQzTFJKYTQ1c3ZBMEZMYU9kVWRVcnNDQ2hkcytnK0h5ZzE2RDg1?=
 =?utf-8?B?YmltdG45ellqdE54YjBBOEw2SVZMbnBEYnZOMUxyNXdFV291eUVXeDVBYWpP?=
 =?utf-8?B?d3Rib0hjMjlmOVdSckkxbVdST0dSaWJScTdVUjVib1V3ekx2Y0t0VmphNzhX?=
 =?utf-8?B?WE9hWFprY3ROR2w2TVBmaXJUZEhpeG9aVkJsdW1ud0dWbWdlSzRYcDFxa25F?=
 =?utf-8?B?N2d0NGVxUThmN1p4NVNBMis0L0NBWGdFY29DREZzblVCYmdCQ0h2a0ExQUpk?=
 =?utf-8?B?TmZBK0ZFb1d4Q1JRT0Yvb0treVNlbWxTWTB5cHY0bVprVWFQR2laekVVTkNB?=
 =?utf-8?B?VEJoOEl0UE5oVDNWRlhaL1RmdUFkT0FPWTF4RmtNeEs3NUE2VHluZXhzQ1pi?=
 =?utf-8?B?WTBJYnR2Vzdnb0VBLzNqSW9XVzdEdlJVR0RNZCtaR0xCdWxQc2kwWTN5L0pq?=
 =?utf-8?B?R3FMSEhubmlyenY0emdtSTIrbkJPSTZ4aGZLa0p5am5DNnlCN1o3Z2FDSHF0?=
 =?utf-8?B?anZ2MTJlZmRKMm5Va25FNVhOQ3Z6WUlDVy9rc0dTejcvd2RVQVFoblMvS2hD?=
 =?utf-8?B?dWNwVXJNZDE0cU5pYkRkWlpBTE1KeFl6Y1BpdFY2NUlZTkEyeFJGb1dKWkRQ?=
 =?utf-8?B?TWJjYThLUFQrSHRFeFdJSUpHaWxQZTdBMjgzSjUrY3paak9XUkpXMGhaSUUr?=
 =?utf-8?Q?uDQgHb7ahVKEkFvXhYRch2Jq8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f09e427-cf75-465e-89bc-08dda8a5dab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 05:07:24.8641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4cOkDllWTm/omi/K5wO6NDLUdbpL8RlKhx2Jh4Slf5wbh69LvVKrbCCZfKDbGsirxILO35I8TeMtAZBYT8XV6h0JCkr4qjCYnvTQ9UYHGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6037
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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

SGkgRGFuaWVsLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi83XSB1aS9zcGljZTogQWRk
IGFuIG9wdGlvbiBmb3IgdXNlcnMgdG8gcHJvdmlkZSBhDQo+IHByZWZlcnJlZCBjb2RlYw0KPiAN
Cj4gT24gVHVlLCBKdW4gMTAsIDIwMjUgYXQgMDM6MzA6MjRQTSArMDQwMCwgTWFyYy1BbmRyw6kg
THVyZWF1IHdyb3RlOg0KPiA+IEhpDQo+ID4NCj4gPiBPbiBGcmksIEp1biA2LCAyMDI1IGF0IDEx
OjE24oCvQU0gRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gPiB3
cm90ZToNCj4gPg0KPiA+ID4gT24gRnJpLCBKdW4gMDYsIDIwMjUgYXQgMDY6MTA6MzFBTSArMDAw
MCwgS2FzaXJlZGR5LCBWaXZlayB3cm90ZToNCj4gPiA+ID4gSGkgRGFuaWVsLA0KPiA+ID4gPg0K
PiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi83XSB1aS9zcGljZTogQWRkIGFuIG9w
dGlvbiBmb3IgdXNlcnMgdG8NCj4gPiA+IHByb3ZpZGUgYQ0KPiA+ID4gPiA+IHByZWZlcnJlZCBj
b2RlYw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBNYXkgMjgsIDIwMjUgYXQgMTA6MTE6
MTNQTSAtMDcwMCwgVml2ZWsgS2FzaXJlZGR5IHdyb3RlOg0KPiA+ID4gPiA+ID4gR2l2aW5nIHVz
ZXJzIGFuIG9wdGlvbiB0byBjaG9vc2UgYSBwYXJ0aWN1bGFyIGNvZGVjIHdpbGwgZW5hYmxlDQo+
ID4gPiA+ID4gPiB0aGVtIHRvIG1ha2UgYW4gYXBwcm9wcmlhdGUgZGVjaXNpb24gYmFzZWQgb24g
dGhlaXIgaGFyZHdhcmUgYW5kDQo+ID4gPiA+ID4gPiB1c2UtY2FzZS4NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+ID4gPiA+
ID4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+
DQo+ID4gPiA+ID4gPiBDYzogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFi
b3JhLmNvbT4NCj4gPiA+ID4gPiA+IENjOiBGcmVkaWFubyBaaWdsaW8gPGZyZWRkeTc3QGdtYWls
LmNvbT4NCj4gPiA+ID4gPiA+IENjOiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29t
Pg0KPiA+ID4gPiA+ID4gQ2M6IE1pY2hhZWwgU2NoZXJsZSA8bWljaGFlbC5zY2hlcmxlQHJ6LnVu
aS1mcmVpYnVyZy5kZT4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpdmVrIEthc2lyZWRk
eSA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ID4gIHFlbXUtb3B0aW9ucy5oeCB8ICA1ICsrKysrDQo+ID4gPiA+ID4gPiAgdWkvc3BpY2UtY29y
ZS5jIHwgMTIgKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3FlbXUt
b3B0aW9ucy5oeCBiL3FlbXUtb3B0aW9ucy5oeA0KPiA+ID4gPiA+ID4gaW5kZXggN2ViOGUwMmI0
Yi4uZmNkZGI1ODNjOSAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL3FlbXUtb3B0aW9ucy5oeA0K
PiA+ID4gPiA+ID4gKysrIGIvcWVtdS1vcHRpb25zLmh4DQo+ID4gPiA+ID4gPiBAQCAtMjI4MSw2
ICsyMjgxLDcgQEAgREVGKCJzcGljZSIsIEhBU19BUkcsDQo+IFFFTVVfT1BUSU9OX3NwaWNlLA0K
PiA+ID4gPiA+ID4gICAgICAiDQo+ID4gPiAgWyxzdHJlYW1pbmctdmlkZW89W29mZnxhbGx8Zmls
dGVyXV1bLGRpc2FibGUtY29weS1wYXN0ZT1vbnxvZmZdXG4iDQo+ID4gPiA+ID4gPiAgICAgICIN
Cj4gPiA+ICBbLGRpc2FibGUtYWdlbnQtZmlsZS14ZmVyPW9ufG9mZl1bLGFnZW50LW1vdXNlPVtv
bnxvZmZdXVxuIg0KPiA+ID4gPiA+ID4gICAgICAiICAgICAgIFsscGxheWJhY2stY29tcHJlc3Np
b249W29ufG9mZl1dWyxzZWFtbGVzcy0NCj4gPiA+ID4gPiBtaWdyYXRpb249W29ufG9mZl1dXG4i
DQo+ID4gPiA+ID4gPiArICAgICIgICAgICAgWyx2aWRlby1jb2RlY3M9PGVuY29kZXI+Ojxjb2Rl
Yz5cbiINCj4gPiA+ID4gPiA+ICAgICAgIiAgICAgICBbLGdsPVtvbnxvZmZdXVsscmVuZGVybm9k
ZT08ZmlsZT5dXG4iDQo+ID4gPiA+ID4gPiAgICAgICIgICAgICAgICAgICAgICAgZW5hYmxlIHNw
aWNlXG4iDQo+ID4gPiA+ID4gPiAgICAgICIgICAgICAgICAgICAgICAgYXQgbGVhc3Qgb25lIG9m
IHtwb3J0LCB0bHMtcG9ydH0gaXMNCj4gPiA+IG1hbmRhdG9yeVxuIiwNCj4gPiA+ID4gPiA+IEBA
IC0yMzY5LDYgKzIzNzAsMTAgQEAgU1JTVA0KPiA+ID4gPiA+ID4gICAgICBgYHNlYW1sZXNzLW1p
Z3JhdGlvbj1bb258b2ZmXWBgDQo+ID4gPiA+ID4gPiAgICAgICAgICBFbmFibGUvZGlzYWJsZSBz
cGljZSBzZWFtbGVzcyBtaWdyYXRpb24uIERlZmF1bHQgaXMgb2ZmLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ICsgICAgYGB2aWRlby1jb2RlY3M9PGVuY29kZXI+Ojxjb2RlYz5gYA0KPiA+ID4g
PiA+ID4gKyAgICAgICAgUHJvdmlkZSB0aGUgcHJlZmVycmVkIGNvZGVjIHRoZSBTcGljZSBzZXJ2
ZXIgc2hvdWxkIHVzZS4NCj4gPiA+ID4gPiA+ICsgICAgICAgIERlZmF1bHQgd291bGQgYmUgc3Bp
Y2U6bWpwZWcuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGxvb2tzIGxpa2UgdHdvIGRpc3Rp
bmN0IHNldHRpbmdzIG92ZXJsb2FkZWQgaW50byBvbmUgY29tbWFuZA0KPiA+ID4gPiA+IGxpbmUg
cGFyYW1ldGVyLCB3aGljaCBpcyBhIGRlc2lnbiBhbnRpLXBhdHRlcm4uDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBXaHkgY2FuJ3QgdGhpcyBiZSBkb25lIGFzIHNlcGFyYXRlIHBhcmFtZXRlcnMNCj4g
PiA+ID4gVGhlIFNwaWNlIHNlcnZlciBBUEkgdXNlZCBieSBRZW11IChzcGljZV9zZXJ2ZXJfc2V0
X3ZpZGVvX2NvZGVjcykNCj4gPiA+ID4gdG8gc2V0IHRoZSBwcmVmZXJyZWQgY29kZWMgcmVxdWly
ZXMgdGhlIHZpZGVvLWNvZGVjcyBzdHJpbmcgdG8gYmUgaW4NCj4gPiA+ID4gZW5jb2Rlcjpjb2Rl
YyBmb3JtYXQuIEFGQUlLLCB0aGVyZSBpcyBubyBvdGhlciBvcHRpb24gb3IgQVBJIHRvIHNldA0K
PiA+ID4gPiB0aGUgZW5jb2RlciBhbmQgY29kZWMgdmFsdWVzIHNlcGFyYXRlbHkuDQo+ID4gPg0K
PiA+ID4gUUVNVSBjYW4gYWNjZXB0IHRoZSBzZXBhcmF0ZSBwYXJhbWV0ZXJzIGFuZCBmb3JtYXQg
dGhlbSBpbnRvIHRoZQ0KPiBzdHJpbmcNCj4gPiA+IGZvcm1hdCB0aGF0IHRoZSBzcGljZSBBUEkg
cmVxdWlyZXMgc28gb3VyIHB1YmxpYyBBUEkgaXMgbm90IGltcGFjdGVkDQo+ID4gPiBieSB0aGlz
IHNwaWNlIGRlc2lnbiBjaG9pY2UuDQo+ID4gPg0KPiA+ID4NCj4gPiBBcHBhcmVudGx5IHlvdSBj
YW5ub3QgbWl4IGFuZCBtYXRjaCBmcmVlbHksIGl0IGhhcyBhIHJhdGhlciBmaXhlZCBzZXQgb2YN
Cj4gPiBhY3R1YWxseSB3b3JraW5nIHZhbHVlcy4NCj4gPg0KPiA+IFNlZSBoZXJlIGFuZCByZWxh
dGVkIGNvZGU6DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL3NwaWNlL3NwaWNl
Ly0NCj4gL2Jsb2IvbWFzdGVyL3NlcnZlci9yZWRzLmNwcD9yZWZfdHlwZT1oZWFkcyNMMzQ2OA0K
PiANCj4gVGhhdCdzIGp1c3Qgc2hvd2luZyB0aGUgYnVpbHQtaW4gZGVmYXVsdHMgLSB0aGUgcGFy
c2luZyBjb2RlIGlzDQo+IG5vdCBlbmZvcmNpbmcgYW55IGNvbnN0cmFpbnRzLiBUaGUgaW1wbCB0
aG91Z2ggY2xlYXJ5IG9ubHkgYWxsb3dzDQo+ICdtanBlZycgd2l0aCAnc3BpY2UnOg0KPiANCj4g
ICBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvc3BpY2Uvc3BpY2UvLS9ibG9iL21hc3Rl
ci9zZXJ2ZXIvbWpwZWctDQo+IGVuY29kZXIuYyNMMTM3MQ0KPiANCj4gPiBUYmgsIEkgZG9uJ3Qg
dGhpbmsgdGhlIGVuY29kZXIgbWF0dGVycyBtdWNoLCBhbmQgSSBkb24ndCBrbm93IHdoeSBpdCB3
YXMNCj4gPiBkZWNpZGVkIHRvIGFzc29jaWF0ZSBpdCB3aXRoIHZpZGVvIGNvZGVjIG5hbWVzLg0K
PiANCj4gQUZBSUNUIHRoZSBvbmx5IHdheSBpbiB3aGljaCB0aGUgZW5jb2RlciBtYXR0ZXJzIGlz
IHRvIGRpc3Rpbmd1aXNoIHRoZQ0KPiBidWlsdC1pbiAibWpwZWciIGltcGwgZnJvbSB0aGUgZ3N0
cmVhbWVyICJtanBlZyIgY29kZXIuDQo+IA0KPiA+IE1heWJlIHRoZSBzcGljZSBBUEkgc2hvdWxk
IHByb3ZpZGUgYSBzaW1wbGVyIGZvcm06IGFjY2VwdCBvbmx5IGNvZGVjDQo+IG5hbWVzLg0KPiA+
DQo+ID4gSW4gdGhlIG1lYW50aW1lLCBxZW11IHNob3VsZCBwZXJoYXBzIGFkZCB0aGUgIndvcmtp
bmciIGVuY29kZXIgcHJlZml4ZXMNCj4gPiAoc3BpY2U6IGZvciBtanBlZywgZ3N0cmVhbWVyOiBm
b3Igb3RoZXJzKSAgaXRzZWxmIGFuZCBub3QgZXhwb3NlIGFueSBleHRyYQ0KPiA+IG9wdGlvbiB0
byB0aGUgdXNlcj8NCj4gDQo+IFRocyBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIG5lZWQgdG8gYmUg
YWJsZSB0byByZXF1ZXN0IHRoZSBnc3RyZWFtZXINCj4gJ21qcGVnJyBpbXBsID8NCj4gDQo+IElm
IHdlIGRvLCBhbmQgd2UgYWxzbyBhc3N1bWUgdGhhdCAnc3BpY2UnIHdpbGwgbmV2ZXIgZ2FpbiBh
bnkgbW9yZSBjb2RlYw0KPiBpbXBscyBhcyBidWlsdC1pbnMsIHdlIGNvdWxkIGRvDQo+IA0KPiAg
IGJ1aWx0aW4sIG1qcGVnLCB2cDgsIHZwOSwgaDI2NA0KPiANCj4gd2hlcmUgJ2J1aWx0aW4nIGlz
IHRoZSBzdGFuZGFyZCBtanBlZyBlbmNvZGVyID8NCj4gDQo+IEFsdGVybmF0aXZlbHkgd2UgY291
bGQganVzdCBnbyB3aXRoDQo+IA0KPiAgIG1qcGVnLCB2cDgsIHZwOSwgaDI2NA0KPiANCj4gYW5k
IGluIHRoZSB1bmxpa2VseSBldmVudCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gc2tpcCB0aGUgYnVp
bHQtaW4gbWpwZWcsDQo+IHdlIGNvdWxkIGFkZCAgYSBib29sZWFuICdwcmVmZXItZ3N0cmVhbWVy
PW9ufG9mZicNClRoaXMgcGF0Y2ggc2VyaWVzIGlzIGludGVuZGVkIHRvIGJlIHVzZWQgb25seSB3
aXRoIHRoZSAiZ3N0cmVhbWVyIiBlbmNvZGVyDQp0eXBlLiBTbywgSSBndWVzcyBRZW11IGNhbiBq
dXN0IGFjY2VwdCB2aWRlby1jb2RlY3M9PGNvZGVjPiB3aGVyZSBjb2RlYw0KY291bGQgYmUgYW55
IG9mIG1qcGVnLCB2cDgsIHZwOSwgaDI2NCBhbmQgd2UgY291bGQgdGhlbiBpbnZva2UgdGhlIFNw
aWNlIEFQSQ0Kc3BpY2Vfc2VydmVyX3NldF92aWRlb19jb2RlY3MoKSB3aXRoIHRoZSBhcHByb3By
aWF0ZWx5IGZvcm1hdHRlZCBjb2RlY3MNCnN0cmluZyAoaS5lLCBnc3RyZWFtZXI6PGNvZGVjPiku
DQoNClRoYW5rcywNClZpdmVrDQoNCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0t
DQo+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tICAgIGh0dHBzOi8vd3d3LmZsaWNr
ci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAg
ICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCj4gfDog
aHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tICAgIGh0dHBzOi8vd3d3Lmluc3RhZ3Jh
bS5jb20vZGJlcnJhbmdlIDp8DQoNCg==

