Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC95E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 07:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyOF-0006je-QK; Thu, 19 Feb 2026 02:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsyOD-0006jP-EA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:23:58 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vsyOA-0004JY-ED
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771485834; x=1803021834;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aYo6o9slJqZ+0ADuuXlHXmiApLlPc+nE4XmH3dMb/wg=;
 b=ZEVjnocLdbfE/WHK87MBCSIvo2bQMNTApE3AweD/CF3RaQn7/AswAdyC
 ZnHS1GhtZez1x318JHlN2lXzwCWDmM7Y+utbdkcDdhaI8kRQX7L1F2wG6
 DgWM0O7EwOv8q85yPICHrPB90ZwPjSofM7f2URjl2FFpPgutrXzrM+rX1
 +9GchTvAdQhtjKRbEDoThTO9rZx4bm+cr8sk/WnqESW5KJ48f5HFUcLoI
 +XsiYrEE0AGeglbFKJZTpMY/Dlnc4fOAaOIZX1AXPBEKY0Ohvb+VnA22o
 t3S7RXtRpk7IyI2ts3lQWY48uy/QPAPPuyio/BL5OY0c/iichfxBl8gzW g==;
X-CSE-ConnectionGUID: ETee4tqrRC+itAqPF/78ZA==
X-CSE-MsgGUID: vF5Pv1NiTJKIeq655RqxJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76401588"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76401588"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 23:23:50 -0800
X-CSE-ConnectionGUID: 1ThGJmbjSnOq+5lj/UndJQ==
X-CSE-MsgGUID: jSAjD0ZZQDeTVu8FfmGGPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="237424719"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 23:23:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 23:23:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 23:23:49 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 23:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAA4m22//KE1nCEBWx7S4fwn9dXfeqKUcYAdy1iqmKulcAwFSkjgGI/AASN7oCF4U1DbspSP8FZvM6PDzF9+19dKoNSuOUbgpc98XWnh26fzu5SMFQjbbtOUW6x3Vec5BhQid7gX+2BJfTQeV+rToyMmzaCY/utiZeVHOImDl1MBgVSW4HhbuN7wxEVYODTCHztSOcznUUfCyb1rNQjrga49ngjuWQE8LqijhVFQOFaX0gZgDhUA1gRQCc3su+jUtNBLUx6fWeN02l2UuxSAGi4wxp6rEpo3uP/ZVjhmUWibMzucPslzZEgNzLKMc+Ihi7bjDAtw8MK1+QITns3ofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXblKK9Wz1Mh5tUc9h1Ng2iH8C4+5HDrUiSfmxLzxvY=;
 b=Xc+gHJCZSECxB1LA8RLs81w2MnZD12ZD3aYtsJ+aQXSBejy79b8r+NDq4Aon65RMJZ7qaKnZ66/8O8/iUXGmoXi2fCgfVwHwdgDiJ7YXQePTvUYi+/Vt7IoOdNoPvmJJgjoU5PuuNlpcDyHfwHtT+lJ6DETbbgrT0EkyJ6S+cauE3U8XA9d70Ud8I6U3LeB1EoY+4aQvh1whbSWx7193Pt1VVjNSr9s7vnni72Whm6GxGK/nYF6jn0cbVNSznPmiYV21Zcn0EvDHidKucEu1XXtJ+23Rokm9oQ6Il+53J9KXkCQgxZFevDfrldqtdx5rfH0S8J1to0x91GJAYKEEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 07:23:42 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 07:23:42 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcmls4q3luewSeSECtMA18foJZSbV74KeAgACEarCAAjb9AIAKp9Mg
Date: Thu, 19 Feb 2026 07:23:42 +0000
Message-ID: <IA0PR11MB71855A99CC24E9367DFC8223F86BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-12-vivek.kasireddy@intel.com>
 <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71856CAA4507A8EFD5AF5F45F863A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a7b64dbd-9535-4927-bf36-e579b8bec4ca@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a7b64dbd-9535-4927-bf36-e579b8bec4ca@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SN7PR11MB6704:EE_
x-ms-office365-filtering-correlation-id: ffabac3e-0456-489e-1f89-08de6f87cf3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wPUy0STp+BL92fl9j3AL7ubSArhWvC5fxokBAIWSiTqSpb4zKFE8jRvgrB?=
 =?iso-8859-1?Q?jcGrE7VH/C38WFC5FkidMSrHKBLmhg5Y+n8VHNTCux5OGRX5CR4jU09eNB?=
 =?iso-8859-1?Q?9YJFSvPmwpPjK0099nPAX6T84A+An88ZtRVvMHrqxUJXnnJ7kc3WdGu/t+?=
 =?iso-8859-1?Q?n5AVWPLBTz8bTfVUO6s9knGvReTYe9pMu8+QF+WDOWD7a4xPlFezhifTh9?=
 =?iso-8859-1?Q?cxO0oGMXsd4TqZV06ipnbjutcBpPO0rIbVWaQyhkEhdUDc+9HFpVYFukYL?=
 =?iso-8859-1?Q?EX5xa7baoGpbaGeq6bmw9DcnrezFPGeduYbKtIAvs6ZAI3UNvwkSnWetYl?=
 =?iso-8859-1?Q?9+d2Z50qpjb9+Y5NTOW6I2dVVxfWcHI4HNEckQAVBWJT3YT90b9wyRDYSF?=
 =?iso-8859-1?Q?TPVvty+zeP+KAn8L3CGiv2Mno7cQztPK4ik77kF8/H8B97obixQOYk5Jme?=
 =?iso-8859-1?Q?5gib4Ecjw1KrozyFRrh+PvwcXYDtITzjDi8tWcSOo35N12ItnNfirbSB5e?=
 =?iso-8859-1?Q?y0JQRH8eIAOqEFkJclQ8aiDtQf6057Ew1BFcnmlrbRPftx3B02CHujvGos?=
 =?iso-8859-1?Q?zveSIbj2TPg1I0KEZnUqLEovqcnekoYCOxALeQCw7dJlDIxsgfJyucppmj?=
 =?iso-8859-1?Q?sfgQEMmIMvv6VjPKk8mDNemDDKhc8nSmVQzzPRlO1cA7haLM6Y7I4ma59v?=
 =?iso-8859-1?Q?q9A9VXugLvPCiXVAaqBzZW3KmNcU7CNvsFqaKVesYIWLuuf12HVDpYzaMs?=
 =?iso-8859-1?Q?mkVD5dx/ZNz0CwAVT7Dn12A9biZdc7Hbd1O8emsoM0fpPKf1BWBwemAh3s?=
 =?iso-8859-1?Q?zUrxWd+RoS/Y93ZXGNLofvdYFUSi/oVC1UCkOgS7JMu2LLgyQpHdQnDrdf?=
 =?iso-8859-1?Q?XSb0ee24AyYSWkySDmBwtdQo7d5FyjUTP+C5DtZXWcQ0V0xg38BnA3DSxl?=
 =?iso-8859-1?Q?EzReBvB7DWpfh2Vq90l2WPDJKua5AOdEaISQvfbHv5Hoh+1L0yVq4XfWuz?=
 =?iso-8859-1?Q?1gggicX4CJPnxVrwtq9tYJlxv53nKBWLscIu/OvOtA76ZWvd/m7Xc2Gt0C?=
 =?iso-8859-1?Q?NxvramRfwSekx28PyZ0FnUDZZX8TPqNUqmMXaobG1Pxm5yYKLNMCUbECyB?=
 =?iso-8859-1?Q?9VqXwXUrxwXr7AO0W92osfOvhnJ8xWN9MmDR8NpbU/aOY1bMsMvU3YotDD?=
 =?iso-8859-1?Q?j1c3XMPyLPwWT8VKu4CcxmxbGnyJZ3QsxMbhLwvrdee1OVbKC77q1H8V/t?=
 =?iso-8859-1?Q?kQxgwUv2WwLxz2BKyd0C7035D2MxhCa6hXBylj5tnz+EfJOqHKoeNmzx50?=
 =?iso-8859-1?Q?Fju70QlvirM0XhHJ6/Q+jEwTh9KmnY4ta3R81HQUQEhI19fnA2JUGP/Ahc?=
 =?iso-8859-1?Q?WnQJdRQeXFplwFQAij2wcUpg+G/byjzZfzeOag40luPNtmyR9AVZc/7F/j?=
 =?iso-8859-1?Q?raCnX9Z+vW1yKA5IqCovVLNSFB9dVD1ATFr682EWsNYIMormnhIzcu8mJJ?=
 =?iso-8859-1?Q?w/I4FHRRmT6cYEHU84r7Q2n2dQsGX/lBY9OV75YuZQXVzhElIQagbBkJni?=
 =?iso-8859-1?Q?FxCB+7moF1/Lf/PRmGIj9smSMt0GhMTFGWuA/5N5O/Q5khsXB99ptOH1uq?=
 =?iso-8859-1?Q?zquAfZOAK7M9uCBem2c2cFQN9whWlTBOL4tRQRLeb5gwwe7Kk5vmlz+ess?=
 =?iso-8859-1?Q?Uia8xXNpQiVBRRqI7tw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IbRpS6HdJ18pUFrifOZ+06TlWeVdJGyfhq8WD/ZaYqBQ/E1AJ9YVLOpdar?=
 =?iso-8859-1?Q?n1/dv4WZ2HM88pWCLHQEOcXua9HmsAUR8Q1O4uf9r+Tx4OYfLr4VSeLmg3?=
 =?iso-8859-1?Q?rIbXyrbpOyDHdV9ZHWevmCqV6qdcfH1eXCJ2Ss+uOUUKoe+Zb0p/rVQgGd?=
 =?iso-8859-1?Q?eDX6p7g/gKGe6oZrsa76uuR5EzaA/nTxYg88d3oDdfXGUpQnn8VqHcxHkj?=
 =?iso-8859-1?Q?r7omrbZIyF8LWdRooYGcTLwpZ80Ai8v3pTLbxVx+55BnPIWc/s0qilRAvi?=
 =?iso-8859-1?Q?OVB+EXf03VqiBIYbH/aiURsDKBNj0H0doPlzX7dSQHWBO45tsnHpLV96iI?=
 =?iso-8859-1?Q?RFHU/Au3xoX1cAtipFlNTdfF/0fWLX2v26YM0jc/n7ZXtgsQ6nJAQjcamO?=
 =?iso-8859-1?Q?Yv/TNtS4SfLroSCtI0wkRrJLCvvsBvBlSRi8w7pHGiCBEDNhxg8+/IilmQ?=
 =?iso-8859-1?Q?hLfVdEYmxaTGmz0ngeYE987E5snundkq3zVWwHalhNLs+tZ5nX9UKzvmhS?=
 =?iso-8859-1?Q?I/JmAGACwH+d+pmCUhfMRVi0+WuvJpQhNsUKonj7GCqMjYvjGWZMK0SCMM?=
 =?iso-8859-1?Q?X7VXsiqIIakY3G4C7OG07s3cPOql64IWsUv7gaB1GHGBAqveOdgBJpHY5C?=
 =?iso-8859-1?Q?M/n4cUrQxpp5cxoKhinlWETi/vgGyYCvlo3GnD6iwAqV7eLsv46Pe73moZ?=
 =?iso-8859-1?Q?IIp6wG6Pw9iJQz3cS7gpVVIK2t75z9KBy/NAhpLN4qcS1vwSdrSFhLBrWP?=
 =?iso-8859-1?Q?L+iakVuGXuOFv/c2AZZjKhQkz55gplqhyod2E5qSHtVlSM3/d90nSEEXlV?=
 =?iso-8859-1?Q?Kn/rB2xUsZDOhYhTCLEWFlHKoteZJpVvuOaFSNd4c3AcM/6+Fyb6lGiruv?=
 =?iso-8859-1?Q?doglxjK4mIJWks6Zy1ig1VgNJrMWsE/y+y1uAR4nMcyIqyYNN+H2aG9iWZ?=
 =?iso-8859-1?Q?4G1ZKbYyQovwQUzQDJAS8TTBJeUt+DdnFivWHeyW4F02KOtbvLxaLRkOuU?=
 =?iso-8859-1?Q?5h3CHUBh5JyMfTJCqj3JnbeVoic8AYdEUAEF8PyfSDgAxOHDUIpatIz9k2?=
 =?iso-8859-1?Q?Hi8Zo0xckl3HWMOH1o3Z2l1sU0KPXKIlpHGvc4LUo969zJ93VvdcrUrxF+?=
 =?iso-8859-1?Q?c45ulznBen90GvFGs2KsmC2FxVpydvfbMMvhfIa0tXM0UZX8PZhTqIUcKc?=
 =?iso-8859-1?Q?ztJbyeGWDDCBHsTFFG7YJd7BZKkzJFwdtdFwoHKj8P0Or+59pXtVM4Iwkq?=
 =?iso-8859-1?Q?2nFJiLO3kiAdTtx3Mk1/DKnb7Z4ICfM9eIqYbFpVRX10CISt+qxdD9WWbp?=
 =?iso-8859-1?Q?oE8P1QUj+iBJuo3kXDgsO4rPG7xftq18ceccO/xeyTVilfm12NnuZumLra?=
 =?iso-8859-1?Q?CFjTGsx72mid6k8cG5TLE70ANfOVcOv9mgSGNf3Sl7plpNLvU+QNrbvcI8?=
 =?iso-8859-1?Q?p5aVh3OlJeQljuLdgMXWKHPpPm9VCVqhqUMcwctM/nlfIotkroN1FdF0Kn?=
 =?iso-8859-1?Q?rWuLID7gxWJSHp3qOTDyUd71RoY3himTXGSAPYtVgzkmi29Rn8shLJDYet?=
 =?iso-8859-1?Q?i/iJpBAs5Gw9Ll8rhF+fvlAe3+hGN/k6AfYtyzlBO/s+2BWrSIHhAwUB1P?=
 =?iso-8859-1?Q?A7NdQ4zSXafEe01xMQMzwcAVw4qL/yZ0IuGyjsOA2nr3dmblVPAb654iER?=
 =?iso-8859-1?Q?pBUXV1ndDs3rDAG8bkJ0bUVo6T9BZZRLoXHZCPva78M1X3ZdIYscd95ao7?=
 =?iso-8859-1?Q?WjC+3zM0NkW0zO90vWh0/fPcVIXYchTfX8hrfS6nQWr22FOmLtZr/xvCMg?=
 =?iso-8859-1?Q?EbyBCflqZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffabac3e-0456-489e-1f89-08de6f87cf3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 07:23:42.0889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/kWOJIeRNY5HoQikJbrTW9vTriYO8tbF/u5WEo0NgRUiRZfbo2w5ZMKns8zGxPQBkiig8wk7YCnzKilLZCDL7tUKT3RyS+grU//AlRe/GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

> Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we invoke
> >>> the vfio_device_create_dmabuf() API which identifies the right VFIO
> >>> device and eventually creates a dmabuf fd.
> >>>
> >>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> >>> created for the dmabuf.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/Kconfig             |  5 ++++
> >>>    hw/display/virtio-gpu-dmabuf.c | 50
> >> ++++++++++++++++++++++++++++------
> >>>    2 files changed, 47 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>> index 1e95ab28ef..0d090f25f5 100644
> >>> --- a/hw/display/Kconfig
> >>> +++ b/hw/display/Kconfig
> >>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >>>        depends on VIRTIO_PCI
> >>>        select VGA
> >>>
> >>> +config VIRTIO_GPU_VFIO_BLOB
> >>> +    bool
> >>> +    default y
> >>> +    depends on VFIO
> >>> +
> >>>    config VHOST_USER_GPU
> >>>        bool
> >>>        default y
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index d9b2ecaf31..54d010b995 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -27,6 +28,27 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> +static bool virtio_gpu_create_vfio_dmabuf(struct
> >> virtio_gpu_simple_resource *r,
> >>> +                                          Error **errp)
> >>> +{
> >>> +    bool ret =3D false;
> >>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >>> +    Error *local_err =3D NULL;
> >>> +    int fd;
> >>> +
> >>> +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd,
> &local_err))
> >> {
> >>> +        error_report_err(*errp);
> >>> +        *errp =3D NULL;
> >>> +        error_propagate(errp, local_err);
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    ret =3D true;
> >>> +    r->dmabuf_fd =3D fd;
> >>> +#endif
> >>> +    return ret;
> >>> +}
> >>> +
> >>>    static bool virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>                                          Error **errp)
> >>>    {
> >>> @@ -73,16 +95,28 @@ static bool
> virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>    static bool virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>>                                        Error **errp)
> >>>    {
> >>> +    Error *local_err =3D NULL;
> >>> +    bool ret =3D true;
> >>>        void *map;
> >>>
> >>>        map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >> res->dmabuf_fd, 0);
> >>>        if (map =3D=3D MAP_FAILED) {
> >>>            error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>> -        res->remapped =3D NULL;
> >>> -        return false;
> >>> +        map =3D NULL;
> >>> +        ret =3D false;
> >>> +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >>> +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> >>> +                                    res->blob_size, &local_err)) {
> >>> +            ret =3D true;
> >>> +        } else {
> >>> +            error_report_err(*errp);
> >>> +            *errp =3D NULL;
> >>> +        }
> >>> +#endif
> >>> +        error_propagate(errp, local_err);
> >>>        }
> >>>        res->remapped =3D map;
> >>> -    return true;
> >>> +    return ret;
> >>>    }
> >>>
> >>>    static void virtio_gpu_destroy_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> @@ -145,8 +179,10 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>>            if (!virtio_gpu_create_udmabuf(res, &local_err)) {
> >>
> >> virtio_gpu_create_udmabuf() will log "Could not find valid ramblock"
> >> even for VFIO, which shouldn't happen.
> > AFAICS, it won't log a failure here because rb->fd is valid in the VFIO
> case
> > especially after 8cfaf22668 ("Create dmabuf for PCI BAR per region").
> > The failure would occur in UDMABUF_CREATE_LIST IOCTL most likely
> > because rb->fd is not memfd in this case.
>=20
> It is still nice to ensure that the log will never be emitted in the
> VFIO case without relying on the internal behavior of the VFIO device
> code.
Ok, got it.

>=20
> >
> >>
> >> This logic should look like as follows:
> >>
> >> virtio_gpu_create_udmabuf(res);
> >> if (it turned out the memory is incompatible with udmabuf) {
> >>       virtio_gpu_create_vfio_dmabuf(res);
> >>       if (it turned out the memory is not backed by VFIO) {
> >>           qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
> >>           return;
> > I think this is mostly how I have it right now except that I am using
> > error_report_err() instead of qemu_log_mask(). Do you want me
> > to only use qemu_log_mask() when we cannot create a dmabuf via
> > udmabuf and vfio?
>=20
> More precisely, use LOG_GUEST_ERROR if and only if creating a DMA-
> BUF
> failed:
> - in *both* virtio_gpu_create_udmabuf() and
>    virtio_gpu_create_vfio_dmabuf()
Ok, but should we also set the 'Error *' when this failure occurs?

> - and it is due to a guest's fault.
I think the only case where we can consider Guest is at fault is invalid rb=
/addr
(i.e, qemu_ram_block_from_host() returning NULL). Can we limit it to just t=
his
particular case because in all other failure cases (for example, UDMABUF_CR=
EATE_LIST
IOCTL failure), I don't see any obvious way to deduce whether Guest or Host
is at fault?

>=20
> > As you can see, I am using a mix of error_report_err() and
> qemu_log_mask()
> > after Cedric suggested to improve error handling by using 'Error *'.
> >
> > On a slightly different note, do you (or Cedric/anyone) know how to
> > properly include CONFIG_DEVICES header to fix the following error:
> > ../hw/display/virtio-gpu-dmabuf.c: In function
> 'virtio_gpu_create_vfio_dmabuf':
> > ../hw/display/virtio-gpu-dmabuf.c:35:13: error: attempt to use
> poisoned 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
> >     35 | #if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> >
> > Looks like I am missing some key detail as I have tried different thing=
s
> but
> > have not been able to fix this compilation error.
>=20
> I think you are supposed to add stubs. See hw/vfio/iommufd-stubs.c for
> example.
I have tried adding stubs following the example of:
cca621c782 ("intel_iommu_accel: Check for compatibility with IOMMUFD backed=
 device when x-flts=3Don")
but it doesn't help. I still get the following errors:
In file included from ../hw/display/virtio-gpu-dmabuf.c:21:
/media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-gpu-vfio-=
dmabuf.h:14:10: error: '#include' expects '"FILENAME"' or '<FILENAME>'
   14 | #include CONFIG_DEVICES
      |          ^~~~~~~~~~~~~~
/media/myvdi/build/git-libs-64/cedric_qemu/qemu/hw/display/virtio-gpu-vfio-=
dmabuf.h:16:8: error: attempt to use poisoned 'CONFIG_VIRTIO_GPU_VFIO_BLOB'
   16 | #ifdef CONFIG_VIRTIO_GPU_VFIO_BLOB
      |        ^
In file included from /media/myvdi/build/git-libs-64/cedric_qemu/qemu/inclu=
de/exec/poison.h:7,
                 from /media/myvdi/build/git-libs-64/cedric_qemu/qemu/inclu=
de/qemu/osdep.h:38,
                 from ../hw/display/virtio-gpu-dmabuf.c:14:
./config-poison.h:233:20: note: poisoned here
  233 | #pragma GCC poison CONFIG_VIRTIO_GPU_VFIO_BLOB

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

