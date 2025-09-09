Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF60CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 04:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvq0p-0005Ee-Ko; Tue, 09 Sep 2025 00:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvq0o-00057p-1m; Tue, 09 Sep 2025 00:31:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvq0k-0002ug-0p; Tue, 09 Sep 2025 00:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1757392277; x=1788928277;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kMEEMCW+K6RMmCDd2sEHOfP33XpFK/oEL5VdeiD9ZS0=;
 b=GVbKDDxvaE6FWEySB42o595EAewNbI+pwggr39LLhAmnay+WbpM2x/yN
 cdA1Fy2NQaJLVbrDED7S6Jnzg0FUOBTsomOSNZsQctawtzxqsHfvhKLiR
 lqzWJ/jEb/zFhApyk7JFpE3MHR6QN6lSYE6w4d9yeZrZa65LecJbgxNIu
 E1Lw+LzlPwtbX8x+Dni5n9DA1IehW2oF6OwD1lFvBtUfYqJhr2PHt0sfM
 oF1Qb/IYTDtbCOyCnUUYSZi8mVA/k4SVBXHq+JD4tg5LSw7wlP0yUZ7Oe
 YVB23bjef30z573mRD4POJNEUbm73HRr0AalXWfaQrNFvkNv98grbqrQk A==;
X-CSE-ConnectionGUID: 9XJnG11xT0i7CzC/qt1J1g==
X-CSE-MsgGUID: HY6DwKT3R4m7Y+O7yDbFQw==
X-IronPort-AV: E=Sophos;i="6.18,250,1751212800"; d="scan'208";a="112991334"
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.83])
 by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 12:31:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD3j6PWvL9xIi6pDArYvoCYMZ2RZbB3vZK911BTZ6ax06FkzkLtBHJYL/YN1O3d6I6EFcFdZ6yCrajYc19RVxOy9rO3mjATginVwcu+a0lmW/OHPkq7HkcPn3ykXjWSzq7mJrBKfVMyxKIm2lBVOexn63JKmPTFywydM/tB2aD513NLfevcUajeMRZIYl6TBer06MS8fEJgtBmEkpkNQgWK49h75/XLIZIknlMusl0YftR3vB/jrSyqxLcda2akTYJwtSldGStyomu2XAqoMmqrc+qXByMZw4YgYo61kMu01ykWVJA6kl+0gkRB3V7FxY9SYfy6w3Z0ms67f5dxGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMEEMCW+K6RMmCDd2sEHOfP33XpFK/oEL5VdeiD9ZS0=;
 b=r5Y1DfTkEKbBV+T02kZMIO4Uvx+vnL98M7qyHYT0GBjJu00itVOY/TTnlLC2upOzeUfDOHAujDGnJ1zgMRCwGdogUGkxg2zrrVRKEOwGe5aG7DolD4lNKLRYjVDU1qT6iytvx4TMRvUUZ9bYPO8M2RlH/zbs5sWNMn9IISZTn7dYyqP7q3WysL9iOCZBP93t0u2EWONbBmoZKCT6uiTEoR9Ula/HJL95uAoXVhGrIhoQOMlysdU+P54VUlKE7Sgte1KkIkC5c1eiaFx8YUtSfe7GmVLo6W9oihZJVb1I5848a/5Wjrd4O94xoJDrWj7HyDSZKKJFUBYVNvE6+ujNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMEEMCW+K6RMmCDd2sEHOfP33XpFK/oEL5VdeiD9ZS0=;
 b=t7CFu2oZ461nr14yPTh5ZdR7whyOjoY0YvBvbt/Y1x+7a/mVae9odJRgWh16H9irE+sV/tyPPrfTmRWORt4AAdnAts54tPIhe65qLsHx02Rtk7Hk1pcKxpl8qIOmy2jh+z0XAh/N3sC45fsZJCGnLNb5YONy9cNbEQhngdJ5zUk=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SJ0PR04MB7166.namprd04.prod.outlook.com (2603:10b6:a03:29f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 04:31:07 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 9 Sep 2025
 04:31:07 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "stefanha@redhat.com" <stefanha@redhat.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Topic: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Index: AQHcHUm+agRvvjJkqECFgpvYbmPGGLSDb7eAgAba0gA=
Date: Tue, 9 Sep 2025 04:31:07 +0000
Message-ID: <05910b9e880058954f9313cfd90510ffd8a540cd.camel@wdc.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-5-wilfred.opensource@gmail.com>
 <20250904195021.GC122855@fedora>
In-Reply-To: <20250904195021.GC122855@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SJ0PR04MB7166:EE_
x-ms-office365-filtering-correlation-id: a8bbfce9-f763-4ec1-110f-08ddef59b1e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cFozenVkWS91WldKazRJMDB3cjN1U25lYUp4MFZHM3VCRloxWHhWUmxwMWFZ?=
 =?utf-8?B?MjhMaytOSThsWWp0V0JyUVFPa21vSXNmNEtUZEE2NXp2RjVPK25mcXYxbHBy?=
 =?utf-8?B?VnZqano5bVdVTUFUUkRoQTR6VG91Z1psdm1rQTlEMXVrdEZNdEVpWFV4azdO?=
 =?utf-8?B?bm5kMXhGcXZSWnNJNUE1K2RPcno5QVEwUW1nR2RTYk9KdDFPZ004Z1YrYzhu?=
 =?utf-8?B?QUtLSlpCc2FJUjk1NXQ1V2FXWDJSVmhPM0xBM3dGdUFuUlU1RkFJbnlXLzRz?=
 =?utf-8?B?S29ZTWFBRUN1QUYwVXdzVS85TVJGS0NUMUJKR0l3MXY1R0ZXb3BDUHNDYlkw?=
 =?utf-8?B?WmlGdyt6cmJBemJXQkR1WXUydXpMSGc1a1RNUDN5VmZGRXBJd3YvRms1bncv?=
 =?utf-8?B?ME5EaVpuV1ErRC9iTm5lV3IzT2ZUS0hyd3ljL01CWlZzOTJDMldCT3o4TlVi?=
 =?utf-8?B?MytycUduY2NYQjQ3c1ZkSDJObVQ2N2NrMFlVZVJSMTBNZi9nUUZIYlpibGZm?=
 =?utf-8?B?ekJ2YXZjREV5RWQvK1k3dkdVNEZaWWM5RnJmL1hBY2V1TmtiNGlvL3lTc2My?=
 =?utf-8?B?bW5kUTNNeUM0ZStkZnJWYy9GOG50bHBjQ0NkZ0NadnZJNjBkc3dYNFlqMlhN?=
 =?utf-8?B?Z084R2RNYXIvcFgyMlJWN2lLN1AydEN0TnpnQkg1TkxZbHcyK0VXQkUwd1RQ?=
 =?utf-8?B?ZkVvNUt1NzlzOVN2SmVuRnpJem00R2ZPUEN3MjBHUlZqcFdoZmhrM1RLcUlY?=
 =?utf-8?B?RjJjNGVrKzJ2ZG81TEUzdjFpT1VLaEVKK0ZYUFM2UitsYWoxVDZjNWNVQnE3?=
 =?utf-8?B?OWd0M2pmNWQ5bTRsMFBKQ0txUXJURC8rZURHT1hqeWpyQkFJWnJaYTM5SVlJ?=
 =?utf-8?B?UFVkeFZwbTl5cmg2NUpjT3EvNWVPWURHZFlzd2FUMnF3akdqRnVJM3dzWkYy?=
 =?utf-8?B?MTQyWmY3dTkvNGZpQmhlRktubnBCVmpTenFDU3VWdFZlQ2tmdEMwSmY4Vk0x?=
 =?utf-8?B?bHVWWGRWU1pqZGhNUEtYUVhnd1VhNkUvVWJTaVVwRDRIc0xUd2MxRTlzMzg2?=
 =?utf-8?B?eGJhanJCUXNweWM4M2JkT2ovR0s1NnJob1JMalNzdU1BRVVWMmZTRGp4Y3Vq?=
 =?utf-8?B?cWhzWWpucmtaSG5SZG12bStlN3hSK2RqeDFNazkyWkt4VGFxU1V1NmFySkJW?=
 =?utf-8?B?THN3U0RWb25TQlV3bjdwWWxjY1duMDJ1OXhXYzloOFhVbDhVa0NsNjV2ek1Y?=
 =?utf-8?B?YzRlVGpnQkVMR3pEb0NBL2phbVowVlZLaHczUHFoMmY1UE9hTGNuN0ZnKytH?=
 =?utf-8?B?MnEvbEVyWDZHNDZjQ05BNHRZMXpnL213OFpFTURKeHE5cmxDRE5IMnBwMVVq?=
 =?utf-8?B?TUFnWndsWkhsRi9PTUgyaElWQkdKakJLKzVSL3MxbkRPR3FNSk8wSDY0TGtp?=
 =?utf-8?B?ZHdDTzhURVlVWG5tdVZESWk4NkJjcXEzT0RmbUJqSHQ0dGJMMWtkRFNtaFE1?=
 =?utf-8?B?ejl4VDIvMGVRa0loZlRvT0NxeU5wWlpibzhhTkZmaFdhZE5Ta2MwbU5ualRV?=
 =?utf-8?B?Nmt4SkRrVEtTUytEQURlNlV6dHRWRUJLR2szV2RuQythT0dGRUlGbE01Wk5h?=
 =?utf-8?B?ZVhvaXFwR1FQNFJyVFovVEdUYVdtYUxLR2NHWHJ5WVg0OTZJb3pNakw5d1lv?=
 =?utf-8?B?RlVnMVFobUxCWW11dmVxb3R2ajlHOHR0VTRjN2NIVmxWMlFFbVJ3UTF2aVQr?=
 =?utf-8?B?VVdlNFRYNDFDOWQ4LzJZZS9JRkRiZjcvVFFYK2xvbXVlc3hya0czbTYyZ2Ry?=
 =?utf-8?B?THNiVHNvZ0pkNi91TEgrRHBieG54NHZXK0JWd2NvS3UxTWhuTGhDRmRCUFpz?=
 =?utf-8?B?TVgxZmhPb2ZKZEc1Z1VNblFBdGx5T2ZubXBzVEwxeHhWOFZYSTZjUjJPMTVq?=
 =?utf-8?B?TU9Rcnpvem5jRXh3azZOSjhXZ0N2V1Y3YU9qakd3QjZpV1cyNGViVFlvZnQ5?=
 =?utf-8?Q?iB6d0WcVkdNNI8ekds2y7bdTRIJbUI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjJDYzY4MFlqbTVDSDlTTEdpZEtaSkcyWlU2TVdwblNjUFVvQ0JFY3E5dkYy?=
 =?utf-8?B?ZXBVM0xRMS93RXZGOGlxbVFGdUcxWFUrTmNkSlhDMit5b3owWFRqdWZvTVo4?=
 =?utf-8?B?TytuVkNqamdvQ0ViYmszSFBmWUtndlBhZ00vZTU0aDA2bEEwRXF0MWNJem1z?=
 =?utf-8?B?QVB2ZVhCMDVUdlZmUlQyanhxRHNrVWhnU0xoU3BCUWlPUGVXRzg3ZjUzVDVx?=
 =?utf-8?B?ZFk3MFdGb0E3c1J3RmxHRkFYNTk4Qk92K1lFUWFEb0pXM1BoWDU4RWlaeVA0?=
 =?utf-8?B?L3dRNFJHUFhlNkUzTFYwTjRQd2hEYkRoU0RrT3UzMTVFTWhpc0VvSXRHc1hE?=
 =?utf-8?B?a29PQnB2TTBoY043b0NMQ0cwOTc2Z1N6TkVYT1RENkUxK3lCdUZmRnI3Z2RE?=
 =?utf-8?B?QUd6NWFiZ2J3SzBxY1hWT0ZlYldoYzlVbk14YjdGQklTWTE4TnRzbCtiT0pN?=
 =?utf-8?B?THQ3aWc3SGFBcVc1dGRtdkJpUVlZQ09oK1JadVZpY2xPZ0dBOU5Jd29sS3F6?=
 =?utf-8?B?VjNoaUJ6V0lsRE54U2ZjZG9YN0hOK2hXVzlUdlMyelVTQ0JvUDhsK081aWZo?=
 =?utf-8?B?UnhQY1dQb2Vncnk2am9maTdiTWxYbmdOV25iVEsvR081MjJRMFUyYVdCNnJk?=
 =?utf-8?B?dmRKTE9pZVdTMVJTWW1OblNhaFR4RmJpam1mMjJxeEJlK3Z4S0pMc2oyWXg2?=
 =?utf-8?B?dXJFNnhpMVI3aDBBNVd0NFFBbVQ4VXh4N25FUDd6Tll0YThEaXdMTlBCWWQy?=
 =?utf-8?B?dCsxdHZoUm41SjBIYVc5akFCaUVpV3JtVys0UGxEd1IyeXFscExTTCtyU3NS?=
 =?utf-8?B?T3VYbCtWT3hFK2x4SlQzWEgrZEx5T0ovYVhYbkRzVzY1aEtCbi96anB0RHNJ?=
 =?utf-8?B?WlFUMjNBZkVvQmk3MitxTWxQZFZnODdIaWZ3WjBva2FSTU1XVUlwa0dDU0Fl?=
 =?utf-8?B?dlhOb1lXUWdwYWZpbDdNZHBjMGtCS1RNWkNkWEdZRkYyQWhEajM2VWVaNUdn?=
 =?utf-8?B?OHUvdFlpNWJVN0gzcXN4Uk5aUWI4QnFiTTV2N3o3V0kzbWcydmQ1ZG1mV3Ra?=
 =?utf-8?B?TjNUcDUyait4dFZVS0tZTVZvYnJBL2lrcnBWb2dmMTlCQlpoL0RJOGFyTUov?=
 =?utf-8?B?L0gzZjhIWldWVnNHclRSOFFzeE8xa0l0aUppZ0hJdVF4YUc2VU9JaGIyV3Nm?=
 =?utf-8?B?UVU4c0xRZ3RMYm9RTFdPVlplVFhyblZqTXlCS250VFJUcG5oS0M1N1JBcllG?=
 =?utf-8?B?ckt1Yjl3bytIbHdFYk5qbjRvRVljTnVXOE1WaDJpUjlROGpWVkhhaUVYTzRO?=
 =?utf-8?B?SktablFpNlVxeFpKZ2lrYVhEZmJNNnoydm8yTlVoWXFITDJibXpzTVRrRTBn?=
 =?utf-8?B?bXhrUWpQdTBsU0hvbUxEUUNvbEdaY242MTF3eG40Y1hsTm8yb3NTOThVYzhh?=
 =?utf-8?B?Tll5MnhUSm15eGtKUXZKZTh6Vys0anJhb1l0WElxaGZaUFRiRVNCRTVNTnpR?=
 =?utf-8?B?VmZkSVdrQ0I2VE9YRE5JUGZTYXBVVnkyUWxBSmdtSFpkT2lnU3M3TUgvLzho?=
 =?utf-8?B?MGlJazl1K2xCRDFtQWhkMGlpQldmZDNqVVJ1dWxNOUgxdEsxazQwcWdOR2J6?=
 =?utf-8?B?dUhEWTN2TzlIb0xTcmRLNVZXdk4wdFBWWForMGY5Q1hNT2ZvWk53b2FrNU5L?=
 =?utf-8?B?b2k1NGpXUnpXYVdkZGhYbXd1QWFnSTNUTkNwN1Fua1J6QzgrNkFWUGlrejFE?=
 =?utf-8?B?L3dmdUpZQ3VjUDBSeDhUK0FXRVV0SnZGUlZpWk41NURHRnJQcUFwYW1yVlNL?=
 =?utf-8?B?bWxqTDlqVnBTOGg2K1Mva0xiZFhoRGpOVk44WjVGNkVLaEtrUkMrVTg4N0E5?=
 =?utf-8?B?N1BaeldhS2ZueU9yV3hyQlhJWEUwWWdDblNGbHVIQzB1L1VIL0JhcVlCWU4r?=
 =?utf-8?B?T1ZDSVc1ajRzRWI3VHkza2FIYjNlSDI0djQ2MWZIa2xwN2hOMTQ2TTN2L2pX?=
 =?utf-8?B?bExZM3NFQ2hCcjZYOTY3WitVTWoyTmJQRFlPbDdBMlg2MFZmVkFoaGs5dVl2?=
 =?utf-8?B?Mm8weDlERzBVMzUrTTJiQ05NZFgzQmpYbTFkcktLMTk3aTNuRDFWbVZpWjF5?=
 =?utf-8?B?bHlPL29LMWgzZVBJRU1MVXE3ZGs2RzQ0OHVZZ3R6TWRBdGhVR3VYZjRySTNQ?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30921663A0C9784297E4C78A41730C0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OoFbRuiHQC0mUn3OwJDkTZg9nS1pk4oWWUjRRkCtTYzA7/P3bQ/NtAbSM1lfCkRyTu/PmLiRHiaUhsr+1Y1YZkCnsMOw3qumzzrquIbqcAn3SQkUe0liPgaAO8j/Zg/dIjFIa1Eg7saNFlEvWGbRTl4Ec2CF0V/7vvM4BQf4awcH++gJ2PO9c+u6P8VjfW2ZZk232p35thxVCSPfVZWV1BqaNrgtVSfg8+mpji+ysFZgusPlinfAPpB/4nULjA58UL7sA8y7Tiyy3vhu+JNMC2+3Zjqt0lupFG2kPxiogJlvcArpsmyrHbMm5Sk5X0ICbbWbOMdQEUkhHLg0f9QNS3kGIvJ8y8IG5lu4D3eHxK+j8vyrySp5qVc8VQMATz8QJMoXWpt4woQHYO2+bHV/MByWzKLQ/AZYf5PZyMixKJYNi+z9pk1onqxGofmSKglTKaz/dtEEhb70y/YDMgWgu80X2vPm3YzHTGY5/kEijZ9ZfGBQ7sd/NfD9eLBKGVUD388GRPnAgFWb+VZVD8sywmAY9bmlYzn4tO/YNPEWnZMRSdygfCtxyBgVaL34Vh2ymjjZZi1+dROyAr0DoSDu8F5QkvR5th8wvZSocamkZf42o8ql1VUOKTvvolc6LvFf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bbfce9-f763-4ec1-110f-08ddef59b1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 04:31:07.2030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3yEN/FrO/RtnzeeXww7NwER7iHYgK8G7nJzn7KxlQs4VfgfdZbsMpakpewkm0AFztIrf36JJUIAH2UAdkJLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7166
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=340207e43=wilfred.mallawa@wdc.com; helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDIxOjUwICswMjAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDA0LCAyMDI1IGF0IDAxOjEwOjU3UE0gKzEwMDAsIFdpbGZyZWQgTWFs
bGF3YSB3cm90ZToNCj4gPiBGcm9tOiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3
ZGMuY29tPg0KPiA+IA0KPiA+IEFkZHMgdGhlIE5WTWUgQWRtaW4gU2VjdXJpdHkgU2VuZC9SZWNl
aXZlIGNvbW1hbmQgc3VwcG9ydCB3aXRoDQo+ID4gc3VwcG9ydA0KPiA+IGZvciBETVRGcyBTUERN
LiBUaGUgdHJhbnNwb3J0IGJpbmRpbmcgZm9yIFNQRE0gaXMgZGVmaW5lZCBpbiB0aGUNCj4gPiBE
TVRGIERTUDAyODYuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2lsZnJlZCBNYWxsYXdhIDx3
aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGh3L252bWUvY3RybC5jwqDC
oMKgwqDCoMKgIHwgMjEzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPiA+IMKgaHcvbnZtZS9udm1lLmjCoMKgwqDCoMKgwqAgfMKgwqAgNSArDQo+ID4g
wqBpbmNsdWRlL2Jsb2NrL252bWUuaCB8wqAgMTUgKysrDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQs
IDIzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBBc2lkZSBmcm9tIG15IGNv
bW1lbnQgYWJvdXQgc3BkbV9zb2NrZXQgZmQgbnVtYmVyczoNCj4gDQo+IFJldmlld2VkLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IA0KPiBJIGRpZCBub3QgcmV2
aWV3IHRoZSBOVk1lIG9yIFNQRE0gc3BlY2lmaWNzLCBqdXN0IGdlbmVyYWwgZGV2aWNlDQo+IGVt
dWxhdGlvbiBjb2RpbmcgYXNwZWN0cy4NCkhleSBTdGVmYW4sDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldyEgSSBoYXZlIG5vdyBhZGRyZXNzZWQgdGhpcyBmb3IgVjUuDQoNClJlZ2FyZHMsDQpXaWxm
cmVkDQo=

