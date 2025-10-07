Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB18CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 04:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5zhr-00073J-8W; Tue, 07 Oct 2025 00:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zhq-00073B-HA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:53:46 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zho-0006RK-9x
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759812824; x=1791348824;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FHPp/Z/13G2CkKOw2iopbyq7s2o7/gIU8xtaMQffjgo=;
 b=nrsYICc5BWW6k6vFLkGPMe3toEMJUt1EgAMt2ZXS7x6qczTqjkHAYfL3
 F+6kiwiDX8B9UneMKM9IM+9eIh5lC0pRm/TnnvZZWebvnmyDzYn3fAk/1
 nRvjn1k8W+/72P/1fs3h253k2SPsw1m0Q37qS7in+N/Bml15MVuL7sXFY
 v1dyKtmmvf5AjDylq1sWn7rB6/xGlVcOeWtLRbktKPYxWLvyTEXU+14BX
 ifMmElZZQYyuzecEWuTFFNnf1dPt8dK0ikVVPPrvo4ey53bX+opwNG7Gd
 j9IJH+3452z1XFANEl0/RhvC2aPlYUBWz+e1KgRlq7+x5tsaw4L7XAmBG Q==;
X-CSE-ConnectionGUID: M/dmAokuRIu+gluZiISwng==
X-CSE-MsgGUID: zA2VrDxHQdGfJxrgFwisXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61699492"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="61699492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:53:42 -0700
X-CSE-ConnectionGUID: +8Di4Y4fSoKRVnXvn13bZA==
X-CSE-MsgGUID: qd7IhDMLRt2vr06ISlKACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="179190154"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:53:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:53:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 21:53:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjH2CWlgP6PSD5FVgKWI8+8w0leehHQBLJe9w6DEw2vSxcQ7R7dUo5xzijL0aaCltOVeOzKX0jZvtaiJmAxl+KVzGsQy8+2cuaeMbxBzM4ivW6kgMuTW6i/teIzhUd9gIBZAuye/OZdUrc7gcrCW/7Qvs52UE7NQ8j1kdqpYL95MFodtTJZ31wCOlGmdGjObgQcWMeuwyIBhn/AFQrrQe8/ZR4XBNcDNt+7mOjSbV+db9sVL7bLqnIco2fl03T8i2Wd4CTVpSMg0CzFHaCNjgaztyVg7HWWOxlItEAOKo7fi01k736vFP5IGsqOW6QwJouNi5NVorRjCvROaWcOORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0tTyXgKymQ3nREe1pC1mCEcnxPjXIjY7IJpNd78Uqw=;
 b=lIsZOmK/Go315joemL139ytZPQrfuEfG9kmeCDW4ahcwlYc3oP27ZPBbcA0UE7ySg3fUAc1W17TbdWdrQ51UpaFq/oWmfVJDr2MEjEAJXekrefhi77l3ehtYyd8G9d+os5UtA7tzp3jbxVcSy4k8VmR4Ug5MMbuovup43krwxVHAB56WqD0qfodvGmqL9392cCXgzQb9u7U7ZYxd4bfsgM9zZzO1qR0vfIvxmf/x9PDncIpffb47F3V76KUrTRsmeSqzQbBXZGLO7JYS/S7ZxTS5SkmpuI65182qlY8ngfXq/JAmtkpUB9GRNGGrqeWhzAy0UftAUmi/tVYdqOyV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 04:53:35 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 04:53:35 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcNL+QQn0dgmrpeUSObhHSZQs0bbS1Sv2AgACyTkA=
Date: Tue, 7 Oct 2025 04:53:35 +0000
Message-ID: <IA0PR11MB7185C259688168F984AEBDEDF8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
 <cd0b246e-7f75-4df6-b1e7-8ae41834f6d1@redhat.com>
In-Reply-To: <cd0b246e-7f75-4df6-b1e7-8ae41834f6d1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6566:EE_
x-ms-office365-filtering-correlation-id: 56267100-599f-4f5a-dc4b-08de055d7918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+k3cOYso2Y6xL8E5HmaqNViqRMAPQvmcmil3aERHnX3Rx08fTElPfzZ/1g?=
 =?iso-8859-1?Q?BQhWb1YGXFW2MEclZh7voVcDAloq/NlH8RtbN4ZbPtmmxeNgYAj33Vdo6H?=
 =?iso-8859-1?Q?F0FGHssdat0vsP8Ig3QZt8HYdcB1ZCMoI7XB/vdrHGAA2cKujNbLYkPSig?=
 =?iso-8859-1?Q?Mp5vzIykcf2WFR3v1DvgP/DdjdV2qRF1Du3kDKMxlDtYW0Z3h+aBjmDh8o?=
 =?iso-8859-1?Q?orXBWSmHzqvApPIZMpuoJIaarUX8Gd/YJM5ZelFp5UClvf1so3CWDM/y2V?=
 =?iso-8859-1?Q?qY76sFMgfv/UNQyNfLA/UY2rS4NMuETC4a8MJY4u+QSQebyTFBi3GfED9z?=
 =?iso-8859-1?Q?PcaTWpwBmD6KkgjdWHQ5hFXcOAVFXaGyU7qLrvYfFKMIKlyuFntdBhqydk?=
 =?iso-8859-1?Q?V0uo32GGVZnIe5yiIgDmDdO9BRYIuXeDiKzWG3tjoMyy0EuOshhOYZDleW?=
 =?iso-8859-1?Q?6P3XzQU8uTr9moABOISYhG/kPZXfZkV7GcGCitgS6Gr77iSIVR/CsjAROU?=
 =?iso-8859-1?Q?0iTXj7Omx8sQxMj+vZCoGS4meBJYzqdzoQjvw+PZ99vW7L1BDUafZ6ET1C?=
 =?iso-8859-1?Q?uIkjHPx2VpqAwGLXUSbJCtbbY8x/xnl6H/55/+MfV1k5AlSUPUj5wtWmOW?=
 =?iso-8859-1?Q?46q8g1G2j0PuUpyig7dUGMaThyheFLbQPgRHISJNiNeGGyoBTm+jBhUvTG?=
 =?iso-8859-1?Q?/DSV4adg+hKjR0fuVcy/dVH514JZv9zCPV22xaHYFRfyVOeywcGgiPK3wL?=
 =?iso-8859-1?Q?NVBVGkDf2jcO5BSU/iV2A0cncul9MOAGMVkWUPOx6lDAXM562TZJfCv8Xn?=
 =?iso-8859-1?Q?sVgLNwIw2pGznGiqLiMtLm4oQwMRp6KFxdfs8mxvRBr4QAtlyserqHqe9x?=
 =?iso-8859-1?Q?+LQfNaNeXz5xHPKPTquSVx16q1RKmcbiZ5rNnaYa0iiVULvAB3x85CCwWr?=
 =?iso-8859-1?Q?34rZ+MHWoaCmx4QifMGLyibV2W3xL0GvIX8JiuAo6tOh0eZalN9dr9tSXV?=
 =?iso-8859-1?Q?YfkZvU6gmd/hv1Ywa6ZTv9T2FJ14u6JcW8ytaQWK7ELOem6Os39epCxvZ5?=
 =?iso-8859-1?Q?S90CRnUnT6WvjQxE9gvDO/6u5/heHygUdAgC5ppm+mkP9LXlyrviwjBAl5?=
 =?iso-8859-1?Q?x31MYJZGVmEL0Cuzvk9UwD+eF9RbC/V5oBMMiDtBbni/uUVFXw6drm7CV2?=
 =?iso-8859-1?Q?xBexZTihUHFDpBIb7NFs0nk5M6GRFwA5oT6PMf6wBCKVljFQBhg+Ehg66m?=
 =?iso-8859-1?Q?nq3fmuUKufGnZ+UqwYBqHuQJhfiZY2U/GFtRY342O1525U2fQ8cQwXY5bW?=
 =?iso-8859-1?Q?v8PBusWIbF+53F2t+x7Qe+mxcQ8xHi2USzfi6O9jSB0sb7P2hOeXws4fZ4?=
 =?iso-8859-1?Q?cGMpT3IebAC29zqQZ+dLxJE1B7nm8iNPVfX5I3HqIvh4ynxFybs+T0sOO0?=
 =?iso-8859-1?Q?9gEeEG53FOnMUhjT9Xn34iqUMBDv0hLWoCt2pK64rRwtjiHYI2wMYORZoh?=
 =?iso-8859-1?Q?X4pI6cUxRQlirxyAUN7afnGrb6ap1mvxoElE0vfiX9Pnm+hwnCEHUNAkDa?=
 =?iso-8859-1?Q?Kwf+5azw0v9B2MHAlWUwTmUavwN7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GwlSMrEnifC7lr2bx+NfZiN+lhfwW9S5afQJQ5CAQH9AMCKwXvNiLsRgEW?=
 =?iso-8859-1?Q?3nu6QQibJJ/pPT9HGDKc0HiFaAV+GAO3eMZXx8A5VU0JlkNWyWqbfQbTd1?=
 =?iso-8859-1?Q?OvvaFMUpzs4rwIOnHID1+ErW9s/tYKpa8kHLegwX3BZF3bNT0qEywu4KZl?=
 =?iso-8859-1?Q?5wl+Z0YIxbBNfuCbq6P077q1eUKHsoSiY0P5PUaZG6n1CISGKFfbWEmxKT?=
 =?iso-8859-1?Q?JmUWRREuwjac3QrsvaevKDR+Cqltq1u0HtlYhvRikoQiOEUTUzvyfPWRKN?=
 =?iso-8859-1?Q?Ro0dBVUtPx7bBkePHcC1wpvrZ7eIp7Te9gqOIWyTQv2BZcKjFjcdaIOgH0?=
 =?iso-8859-1?Q?j3Mi6mbXLgDVKh5wyaYsYEyaYYXerwPwuWrJJ7hh/8tzi0EytAy8jixN+a?=
 =?iso-8859-1?Q?Lnce+wgKmV82w0ZPJOHR8Z7H+iZoiErg6VkJA6QmLNSeZmjmyRfESAhkF4?=
 =?iso-8859-1?Q?IGGwsI05zM1G+mcAjI6PJF0EfVDXVLCGO2mVUeJAhlo46nbpZgITnSyaI1?=
 =?iso-8859-1?Q?EBWtjYHnz3vzwe3tJW9FGU1/lh/PPW13uKP0xo/wY3QsXdTZoBvbNb5E6w?=
 =?iso-8859-1?Q?pHTSvZUtWgsTDfsr+8nlio9PgJxolAf6MN7YYud1ugqrn1xMoniahnDg3f?=
 =?iso-8859-1?Q?gltDw8MNDOAX77TP1LuzOXycuaGNMPjEk6uo8lZmsAGQ18dCE9vAMFCaUb?=
 =?iso-8859-1?Q?Y0YTIkqVOUelIys17h1gbAe5wbpCBbDk6ggPOX7wZ//n8sBizJTRR4gqqQ?=
 =?iso-8859-1?Q?TXMyD+YHeFS24UReSUrA/CKQ0TxzZVHLf9yHYuiss79emhG9onXSAAiv2X?=
 =?iso-8859-1?Q?KWnVUwmpG3nucmd2F5CRTwRt2vrM5df4UePNtbpapv7GBDwtlRRpp1Pd1z?=
 =?iso-8859-1?Q?MZ53uEE3GRCjwFfdRBbOJ1vl04DRCpPhgxVyRevBipQfOmjDVubqKQg6fu?=
 =?iso-8859-1?Q?EJZop6cmCNWTQCog8NzYqx8GxVkjsdXIW4ENlxte9TDpwOei1JSoxk+7Rj?=
 =?iso-8859-1?Q?5b2oz4wowpDUrawyypuH5XyDGXZZHGzZirGXrHTh3aXzY2QJazbwPXYC0N?=
 =?iso-8859-1?Q?HUd4/3aX+AeXXhh0MPIMJZ+ZxhWYs5cxSVslFW2yFKbWLKv1URHVBT2z8m?=
 =?iso-8859-1?Q?KRH7JAsQMELbaYlTTS8AC8euom539je7moPhWN3dlL/zrkZ7bypANYw0Mo?=
 =?iso-8859-1?Q?sWFP+XF32s7T5Bb2XWnqwOgQoU6fvO8DA90QrpFCH5/m/XWWBbGgCmb1AN?=
 =?iso-8859-1?Q?0EJnWm6RaJBYlVxyaHvMH3k2fpyxmR0Z7X36tMlgpFxOKqN8W8NNfgWpJl?=
 =?iso-8859-1?Q?qObF3xkrhPLb1+9U7Y0TQVfZKs2uAk/TT3BUJEAPLJ+sIViGqGhtPdQcEG?=
 =?iso-8859-1?Q?D4fNiOXotPkLr4ClnUFeE1567f3HfjrsILEP/4ZqaNf9cpLKdEGDE9lzNr?=
 =?iso-8859-1?Q?MJ3M+0AIDcMzuej0je9xMJMXzLWPOq67ehTW5jpmUWap337MQ7LGqo71qe?=
 =?iso-8859-1?Q?sv++ECL0k+I0A6ebkVvp6rdCdtcFfgf9HUc+JYF7r9lMrXvSQVfkwnPwpQ?=
 =?iso-8859-1?Q?o6isUiybP/Vg6AmO01QQtVMIMuagfT0IeDNxNcJAI2Xlam/UIPp04U6TNa?=
 =?iso-8859-1?Q?STl02vr2enpkz/DydhjliSDUUKX2OTblRi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56267100-599f-4f5a-dc4b-08de055d7918
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 04:53:35.4667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUXXKp4yt24uGj3jNzhq+MpxqqZo1ksPGDqz/w2KR2YrHNTWZW8ktv/eU51IXQ4jdeAfcn3+Flc9bVd7wsg9EU7dGGhOwLQRj8Qa8Qw9lTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Hi Cedric,

> Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 10/4/25 01:36, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Therefore, we first need to figure
> > out if the blob is backed by a VFIO device region or a memfd before
> > we can call the right API to get a dmabuf fd created.
> >
> > So, once we have the ramblock and the associated mr, we rely on
> > memory_region_is_ram_device() to tell us where the backing storage
> > is located. If the blob resource is VFIO backed, we try to find the
> > right VFIO device that contains the blob and then invoke the API
> > vfio_device_create_dmabuf().
> >
> > Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig              |   5 ++
> >   hw/display/virtio-gpu-udmabuf.c | 143
> ++++++++++++++++++++++++++++++--
> >   2 files changed, 141 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-
> udmabuf.c
> > index d804f321aa..bd06b4f300 100644
> > --- a/hw/display/virtio-gpu-udmabuf.c
> > +++ b/hw/display/virtio-gpu-udmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,6 +28,33 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static void vfio_create_dmabuf(VFIODevice *vdev,
> > +                               struct virtio_gpu_simple_resource *res)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, res-
> >iov_cnt);
>=20
> I didn't realize an fd was returned until this patch. I'd suggest
> renaming vfio_device_create_dmabuf() to vfio_device_create_dmabuf_fd(),
> or something explicit IMO.
Yeah, makes sense. I'll change the name.

>=20
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
> > +#endif
> > +}
> > +
> > +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    VFIODevice *vdev;
> > +
> > +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> Hmm, I'm not sure we want to expose the VFIOdevice list to other
> subsystems. I understand the need, and it's faster than iterating
> over QOM devices, but I'd prefer that an API be provided for this
> purpose.
Ok, I'll add a new API for this purpose.

>=20
> I missed how much vfio_device_list has proliferated. Needs a check.
>=20
>=20
> > +        if (vdev->dev =3D=3D mr->dev) {
> > +            return vdev;
> > +        }
> > +    }
> > +#endif
> > +    return NULL;
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       g_free(list);
> >   }
> >
> > -static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource
> *res)
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> > +                              VFIODevice *vdev)
> > +{
> > +    struct vfio_region_info *info;
> > +    ram_addr_t offset, len =3D 0;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +    RAMBlock *rb;
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev-
> >fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rcu_read_lock();
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false, &=
offset);
> > +        rcu_read_unlock();
> > +
> > +        if (!rb) {
> > +            goto err;
> > +        }
> > +
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vdev, ret, &info);
> > +#endif
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
>=20
> "hmm" again. Not this patch fault but we lack proper documentation
> for the VFIO API. Something to work on. Since this patch is using
> vfio_device_get_region_info() could you please add documentation
> for it ?
Sure, I'll add documentation for this and other routines you mentioned,
in the next version.

Thanks,
Vivek

>=20
>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> > +static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource
> *res,
> > +                                     VFIODevice *vdev)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        if (vdev) {
> > +            res->remapped =3D vfio_dmabuf_mmap(res, vdev);
> > +            if (res->remapped !=3D MAP_FAILED) {
> > +                return;
> > +            }
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    VFIODevice *vdev =3D NULL;
> >       void *pdata =3D NULL;
> > +    ram_addr_t offset;
> > +    RAMBlock *rb;
> >
> >       res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        rcu_read_lock();
> > +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false, &=
offset);
> > +        rcu_read_unlock();
> > +
> > +        if (!rb) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: Could not find ram block for host addre=
ss\n",
> > +                          __func__);
> >               return;
> >           }
> > -        virtio_gpu_remap_udmabuf(res);
> > +
> > +        if (memory_region_is_ram_device(rb->mr)) {
> > +            vdev =3D vfio_device_lookup(rb->mr);
> > +            if (!vdev) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not find device to create dma=
buf\n",
> > +                              __func__);
> > +                return;
> > +            }
> > +
> > +            vfio_create_dmabuf(vdev, res);
> > +            if (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from vfio d=
evice\n",
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else if (memory_region_is_ram(rb->mr) &&
> virtio_gpu_have_udmabuf()) {
> > +            virtio_gpu_create_udmabuf(res);
> > +            if (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from memfd\=
n",
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: memory region cannot be used to create =
dmabuf\n",
> > +                          __func__);
> > +            return;
> > +        }
> > +
> > +        virtio_gpu_remap_udmabuf(res, vdev);
> >           if (!res->remapped) {
> >               return;
> >           }
> > @@ -153,9 +284,7 @@ void virtio_gpu_init_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_udmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_udmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


