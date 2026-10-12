Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25329CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9Fr-0007og-Gb; Mon, 12 Oct 2026 02:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9FY-0007nR-7O
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:11:07 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xG9FV-0003s5-KM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 02:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791785461; x=1823321461;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Sia12l4BfrO/02/0iMZjreIZtEXvr2ekgVyZqq8Gxs4=;
 b=mes8Q2NwugueDRGt2W64/0nkG86veDQZyYSq6TkFRB2ckXBtoYkXISrK
 /YIwC33/Von1/eRsjWvH4dyUsNHTA6uq/ccwxyfPdfwaHzzZt+HiJMC6+
 iuzVQizz0Tuh/9JdQGVoPx0WZVJ1MUKgjriyVYCn3q98V5/MqS6FYeCYe
 JpW2UXyyK2huY0p22XtHjA1vT1QResrwHX5I5Z6A+dBWXvqo6yk/+87OY
 hi58VV/Jy+mNL2t++XQ3wfq4Myzy9o17E7LP7UXizmzu/ngGooM6oZLlt
 d2NepjZb1g2/PC7RhpfttKixGzLXBV1vdEPacINtlKRDoKCv1QrbYZHl3 A==;
X-CSE-ConnectionGUID: mYhzgFn/Ss+W6KmsSWeV4g==
X-CSE-MsgGUID: AZfkFGTYTBOQNanaJnsSpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="385633"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="385633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:10:39 -0700
X-CSE-ConnectionGUID: 3K5XTUKrQcOo46thfY9Y2Q==
X-CSE-MsgGUID: uuEQblxxSsudtBSCmtuo4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="744540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 23:10:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:10:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 23:10:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 23:10:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZQpKZ9DWwgVbbPEBP6W4gg7BZp3nWvAwM0ZltbD97/yywk/611bsLvPkoJHXU6MOqpHiUxKjI0h30bPTFbg3wAbGL1pqViGT9SfM6vRbqoSmImNnDoypAnlxYeckoYPknhDnyaDv0WEtCnjopEnikeoWhfMZQZ0CCbGOlTANM6hYr8Yhk0NiJ8/7BiaJJX2ub1+dtc2GOpo4Fp54pHquXN/GCe5XZRXMtZmHojuZfPF6/fBkTixTV61qitDIEcQz8n7KjgCioZUTrdiMYPK3WJB/m1/sJJqETlRnqunLQk8lxdL1QAswIMDBA/4lGbjlRJiR/hTU+n08n0WtmilRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9oHQLEvq1/vZfpjAQSqHCfjbKhznFv2DK4hJLi92+k=;
 b=LWMokbdv4JQsYYOLBQp+YjAzUIJWO1UY0/HR9l4o7yZivZ3bD+Xg1Zxm39ZZe25RKt3OZf4xZYk7SHMmz7uHfMsKCxqnDe9t9WjN/qLUKjwVGLFrpOqGRGFytDJA7YvtACck+GhmVE3KSMk73ZZtj2kHVVBej1UjOYsYt9uMwOlsvfhwjQNibPMWYNVAmKX9Ze1NSldZUUHVlW3ES64OIKp26WQbraoczCY8wE2Rt28C3MBFHcgXxJxkIYFByn4a+DzuC+vjraoke+KHZLTCfMUOaankfUKX8mW1IXtOgvX+ONLELdsKiPv+c+VIrLtwWRr7/1d5XFYMDOJe40jFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 06:10:36 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 06:10:36 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHdVphmDwVGKGE8Yk6FSLwoadjfhbbzWl4AgACY8oCAAP/oAIAEDx4Q
Date: Mon, 12 Oct 2026 06:10:36 +0000
Message-ID: <IA0PR11MB718525569086211FC8E93AA6F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-2-vivek.kasireddy@intel.com>
 <7ee490fc-7311-48a5-aa6a-434935ca0a84@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718508A4AD2A92CEB7A56B97F8922@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8da0d6fa-fe2e-4356-bf30-e17f07243ca6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8da0d6fa-fe2e-4356-bf30-e17f07243ca6@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|BL4PR11MB8797:EE_
x-ms-office365-filtering-correlation-id: 88b2fde4-797a-46b3-f846-08df28278813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|10067099003|56012099006|11063799006|4143699003|6133799003|261009221227099003|5023799004|22082099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: 3bgZdtziwAaywWB4iPSQCyvc9UBNENRv1uVkRkpt9tQsiWFmbYOO/3V3FqZ30q2oDtYtj+3Wi2QT3j1N87Qz3s/l1MCmKuP6V1igqUp5qr+MHOmfJvcbhHh+UYpPLT2Q2YJqRktPJgJvyAaOFrWktS7kOuRdBTfLpH8heBiEV+ILgUU4meN7yqjrgJaM029iAl9CdDF+6dv5k/euEalBRji/gZMz0Md6ICb7Fj2Q9oHRs6Zs/8R2yXYOVMouIgBXoUzHEAAlbsv7ed5b4gILeCDOxGTCKwxa1hM/AhfO+iPbXCHxFJMIwsc46zQHm6XgSyuZewpEpHNXtmq5b1xThrOwii2xSoc+vy9bQSUPGbU/O2ETeX50B1BHHcSiEXcufUXxCsQyq4x/EqOlqhl050wmsBqKuKm1gf8lhjmbLLnZJZYxzTMExeFfTOqLp5yw39N2U1NG8ZH/KfdiNHfavCCGSrhpMdWTHM9B50u/x1KPtidzXA3r41j/vliYur/l0iicxXFyV9XSeqe1zx8ETotvhTzCge2E2gqnVEMDdLFeJvK5fIBxtH2rftj/BaDbcaOV48YgxkWlaOIgNNdRADRSbaU1QRVBxVX+XDoiIA/VAFWXmshiYUJPr0XG6QR3fS53sdPepPceGwvwzZPFLjAWoO8PQX42k7gCOu+UV1Owl/GJ4/PxDUkbyX79GNQSQaz35eL3EZgAw+KZZx5IjtW/1I9GOKbAsQS88LeSJ/8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(261009221227099003)(5023799004)(22082099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w9odPFflbYURgnc37FC/tRzI++Og5GlJRAEa7uj9SIYzdkCrGsF/RrGmwj?=
 =?iso-8859-1?Q?KFC1irF1Bic9x8m+yF9a46muPMXrgkcgF4UStAsC7QBlGGFhU6x3azZo9J?=
 =?iso-8859-1?Q?btsuC1Cg3k+DnEkehP8MbxNYZm1aROxc0nZWa/HhP1uuzc3YeWlGXmpIif?=
 =?iso-8859-1?Q?30Z1nHJ4ue5DRYp+UwGtej2qpZN6RVE4iUzOtJ0Wrn3laJbDbuq4shmDsX?=
 =?iso-8859-1?Q?/E6QQ1/hXHyELOoT90/WQtNbgbtHvM61btxbSeLC4dzbPY9bTYffh3uX2h?=
 =?iso-8859-1?Q?EF1FyAktGdHOzB1XId3JCV/RF+xTcTSlqJJImwyN/NsmxMObeo57ER7pWJ?=
 =?iso-8859-1?Q?1wygJJ8ZLFgtMYOEoQTmCVXyEtul1tJ1LmetVI7NsYv3awioSl+ap1XgOG?=
 =?iso-8859-1?Q?tVRZeFhDOF+dYuEhZm8K3H6K6o2B9AW4B97OLqfBxbyMim7UN9P6BSKNhd?=
 =?iso-8859-1?Q?aiPI3nWQM8HFNC+U1nmUedP3ANri7Y3GENo+7UwsKwwtXGpDYCVyl//lX7?=
 =?iso-8859-1?Q?4u6PsUEBLGTdQV3Tk1WdH52gSDuaH3VkNdPxC/XfO4TGCdCdqIjdLobQYF?=
 =?iso-8859-1?Q?SP/ZVfQswI/0vI5+jWUiN4myfay1hklgeVSlGrf43P5ZFAW2Pz5BDBcvHk?=
 =?iso-8859-1?Q?PnpyHzReLldUKFYNEHUgNOybxvFFaBnYcmTf3g4xI+KrwZhtPjHa6c6O6U?=
 =?iso-8859-1?Q?INg9ecf8xbUIE2e/ywCS4vWmn7ihkiPXzDPrzPEwExME1MwRs8Ua5CmD/q?=
 =?iso-8859-1?Q?ZrJQB+Hf7z8ZXcWvMlPFgWfwcpenhZSl1d4VoYuAxB/FkUEBRaU4+kqnRH?=
 =?iso-8859-1?Q?1WZ+hMil1JFvxKTA+1hDYgXBDm8qanm9DJH6ADrJD4Mf44M3W9NPlyliGC?=
 =?iso-8859-1?Q?IEtdYcxjMQrx93lI7hPWGxcp0GWdNFCoNbwN2YH+QtsMPlXRVTkOLg31fM?=
 =?iso-8859-1?Q?J1Jc0iC8EXwdeUQPOgG0Ay2hKfLXhVnz3cWGKKf7oAfrSy4JGqIq9wrREO?=
 =?iso-8859-1?Q?8Axo6nKMhC/hFKLjQZd7el7kuiJx8GeZnvqjAde+X9xgNlSajtlKuGJm+h?=
 =?iso-8859-1?Q?J4q/Xpsrr4p0JJYDiVhjZIxGYsUunsTMUb/EBU8GDOyuqaGOnt1irZWG5b?=
 =?iso-8859-1?Q?RUSubTfTEmX6vF696oRnxUtWmJKoYEVMgR7oCHig1Qbvy/hGo9WRqTGx6T?=
 =?iso-8859-1?Q?20S1hbTBNUvHpnODdPCoeUE/J9/5KRhkDuiVlGFW6BtIQX4XmkirRCaBVF?=
 =?iso-8859-1?Q?ETKXr+VD3iBkZWwLJX8REbBnMuNcBAH7jEh6mzWcxo+41mBrz4JQLvlEYb?=
 =?iso-8859-1?Q?neI/xHw2QnhSYJg/IIHaU9HkgBLLTqgJj+2GY9skhm1fzq58hCD+cZcBdM?=
 =?iso-8859-1?Q?a8l2pdyWo5XyHXoKbWb70cw7pZGmnZpwe5Hx0pJ/DzP89XwKesDmjteiYB?=
 =?iso-8859-1?Q?hUYk/ghrfnEHqBpcwnKCXZbyO1tj5mR4h1UaoeFME5vf0vinDJ7ZY9aVot?=
 =?iso-8859-1?Q?qLSALchQj0D7M8OhxZdQ4xuSK0NbiW83Q3DcylOfKw/uol5GZ6n+Y1Zh9w?=
 =?iso-8859-1?Q?ACMBxnG/BlYOPaHKSi+HMOcUOIbAs/BwzTLr+ZiyMwT2clhIO6c3ZZWlEN?=
 =?iso-8859-1?Q?JxalR0ObTyCmIZcEATtDoE+EUa0gcFy4QTS12899PppieNUv6ITXLaeepZ?=
 =?iso-8859-1?Q?VGWD22CFTLETyq0rxwrwb7TFxuKF9j0K8ff6gSGxwEF/FYdxWFfWNG7+JP?=
 =?iso-8859-1?Q?pgiYfC4JhTVGJxuX5r05FReNLlHwrJocI1GpjXd4Jydk2hWa5Zrol/WF6Q?=
 =?iso-8859-1?Q?Cx+Gez9Q2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kqmNfUIzR/oPOklnJLPwqZ3wyG+BaRRBZuO2dByPx2zB96aN348bBbbawlKpUWu4GEUhmpHBWBsrJtnyilRyZM9a8S4rxWu4n1vl9L12xrlyECFl1t9WIGoQgLcznAqeAnzfh4D/Qxj8Mf8NoJYT8l/MrnaqL3opahalz6wA77xYu+cgPTBDfO1/2a+pUtJ08bedbiYFiZY4B95SjEXlBj2kqrR8+f3BQIDH1q+HIGJwOEDjynnIZyr4rkTny19e3lMw+KTA5NhTdNTVbzFUhUB0GRdpVt4/yG2oZbd61zzY2iY5Aqva9yN/ybGn6PA/THijGyRB1HOsh38GHPSjmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b2fde4-797a-46b3-f846-08df28278813
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:10:36.1613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCm4lhmwmeC0xuHknda/csz31kqEkyXSihxRDifvAG1c4YY4xTr4MDOfqe+HqFYzJrHdLIRfRZMrje9m501wiQnJ9BoXyK2y4Sa19Ef3vaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8797
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

> Subject: Re: [PATCH v13 1/9] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> >>> If the Guest provides a DMA address that is associated with a ram
> >>> device (such as a VFIO PCI device region and not its system memory),
> >>> then we can obtain the hva (host virtual address) by invoking
> >>> address_space_translate() followed by
> memory_region_get_ram_ptr().
> >>>
> >>> We cannot use dma_memory_map() because for memory regions that
> >> do
> >>> not support direct access, it would create bounce buffers instead
> >>> of returning the actual hva, which is not desirable here. And, since
> >>> VFIO device regions are not considered directly accessible (because
> >>> they are mostly MMIO based), virtio-gpu cannot invoke
> >> dma_memory_map()
> >>> to obtain the hva in this case.
> >>>
> >>> Therefore, in order to handle addresses associated with VFIO devices,
> >>> we need to use the address_space_translate() API to first identify
> >>> the right memory region and the appropriate offset within that
> >>> region and then use memory_region_get_ram_ptr() to get the hva.
> >>> This approach also works for addresses associated with the system
> >>> memory region.
> >>>
> >>> Note that, although we take an explicit reference on the memory
> >>> region, we would still rely on dma_memory_unmap() to drop that
> >>> reference when the dma mapping is eventually unmapped.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
> >>>    1 file changed, 18 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >>> index bb0f41bb1e..386db05e5b 100644
> >>> --- a/hw/display/virtio-gpu.c
> >>> +++ b/hw/display/virtio-gpu.c
> >>> @@ -948,6 +948,23 @@ static void
> >> virtio_gpu_set_scanout_blob(VirtIOGPU *g,
> >>>                                  &fb, res, &ss.r, &cmd->error);
> >>>    }
> >>>
> >>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>> +                                       struct virtio_gpu_ctrl_comman=
d *cmd,
> >>> +                                       uint64_t a, hwaddr *len)
> >>> +{
> >>> +    MemoryRegion *mr;
> >>> +    hwaddr xlat;
> >>> +
> >>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
> >> &xlat, len,
> >>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>> +    if (memory_region_is_ram(mr)) {
> >>> +        memory_region_ref(mr);
> >>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>
> >> On rechecking this, I don't think it is safe with Xen.
> >>
> >> memory_region_get_ram_ptr(mr) + xlat assumes a contiguous host
> >> mapping
> >> of the entire region. Xen maps guest RAM on demand through its
> >> mapcache.
> >> Here, memory_region_get_ram_ptr() obtains a mapping at offset zero
> >> without pinning the cache entry, and adding xlat afterward does not
> >> ensure that the requested range is mapped.
> >>
> >> The MemoryRegion reference keeps the region alive, but does not
> >> prevent
> >> the mapcache entry from being reused. Resource backing can therefore
> >> receive an invalid or unpinned pointer.
> >>
> >> I think we need to extend dma_memory_map() for this use case instead
> >> of
> >> replacing it, preserving its mapping and unmapping semantics.
> > I am not sure if extending dma_memory_map() might be a
> better/cleaner
> > solution for this use-case. If obtaining the hva/host ptr via
> > memory_region_get_ram_ptr(mr) + xlat for guest RAM is not safe with
> > Xen, then would it not make more sense to go back to using
> dma_memory_map()
> > for Guest RAM and memory_region_get_ram_ptr(mr) + xlat for VFIO
> > backed regions? That is, doing the following:
> >
> > static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >                                         struct virtio_gpu_ctrl_command =
*cmd,
> >                                         uint64_t a, hwaddr *len)
> > {
> >      MemoryRegion *mr =3D NULL;
> >      hwaddr xlat;
> >
> >      mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat,
> len,
> >                                   DMA_DIRECTION_TO_DEVICE,
> >                                   MEMTXATTRS_UNSPECIFIED);
> >      if (memory_region_is_ram_device(mr)) {
> >          memory_region_ref(mr);
> >          return memory_region_get_ram_ptr(mr) + xlat;
> >      }
> >
> >      return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> >                            DMA_DIRECTION_TO_DEVICE,
> >                            MEMTXATTRS_UNSPECIFIED);
> > }
>=20
> Checking this logic again, I found this patch is not necessary since
> commit ff77a515113f ("system/memory: Make ram device region directly
> accessible"). We can just drop it.
You are right, this patch is no longer necessary in light of ff77a515113f.
I dropped it from this series and re-tested my use-case again and everythin=
g
seems to work as expected.

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> +    }
> >>> +    return NULL;
> >>> +}
> >>> +
> >>>    int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >>>                                      uint32_t nr_entries, uint32_t of=
fset,
> >>>                                      struct virtio_gpu_ctrl_command *=
cmd,
> >>> @@ -993,9 +1010,7 @@ int
> virtio_gpu_create_mapping_iov(VirtIOGPU
> >> *g,
> >>>            /* TODO: a common DMA map SG helper */
> >>>            do {
> >>>                len =3D l;
> >>> -            map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a,
> >> &len,
> >>> -                                 DMA_DIRECTION_TO_DEVICE,
> >>> -                                 MEMTXATTRS_UNSPECIFIED);
> >>> +            map =3D virtio_gpu_dma_memory_map(g, cmd, a, &len);
> >>>                if (!map) {
> >>>                    qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map
> >> MMIO memory for"
> >>>                                  " element %d\n", __func__, e);
> >


