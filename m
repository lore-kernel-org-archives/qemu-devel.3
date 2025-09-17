Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E96CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uylvh-0006d0-CL; Wed, 17 Sep 2025 02:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uylvd-0006a4-BK
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 02:46:09 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uylvX-0001af-TK
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 02:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758091564; x=1789627564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1g4sCMuPP0Cu7hkBmZ9i54bAY8qlpSE0ZA+jTnJJd+I=;
 b=T+5k4qRbA3bQ+2Mv/859VIQbtxKZBJirmIfe9j2ChHiPheCDoMI6GZEz
 2XLtbudc7VKPbkF5aOJX6G3FNxhV42Dkup1qKDkrXegsVmSkfUr1iDkYW
 ASXwxqnQ6gycwyed5Tw6/jR7L/tOhhs7X4Xj9xiHj5475pyP+6nWMLw7a
 ksxrcxlfzMes8kWunqj0gahxzIH+PcAdN1vpP4vnjFwN+rorYCfI1KmUt
 2fw/F2U4X7Gf+2S+8pOioPmyi+APYD9XCCm5IlSZhbYn/h4lMPbmpkCtN
 wGPrYbk8fs0kD7gkQJVC1yay++NuSBAnum7le8mUtRUG3H3Wqv2bn8sqr A==;
X-CSE-ConnectionGUID: frIg8a9/RtmYVLvfavgRhQ==
X-CSE-MsgGUID: miA0YW6KREOfC7jIoZ40ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64188253"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64188253"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 23:45:54 -0700
X-CSE-ConnectionGUID: hTXpKsnAQVy1h9X/0911YA==
X-CSE-MsgGUID: TbeMPlrWTC+HRaqGInbh4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174267890"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 23:45:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:45:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 23:45:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 23:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm71Rq99vOl/GjyG8CQ782ZMXMNJZCxWSY8Ue9lmpq7D4h7gvsLGsBie/StlY7v7KK4Z+0TZEuNBNdq4TqsW/I9QaCEVnth07yp++9k9xgaEBg8w1v+P4qEjzG46FiZ2Iw0B/Ra1KnlUY56r+cIU8Ly3ISNmdN8wkW4BqTKsXKnHxzD+GRTwvthSFu/c1aSQ66a4co73swdT+YmLPAvpd9mfvlR0Ah1Ifz9akvUY4Suo0fubRkWwDE0b4MecJSJUyOArA0iUEg6OA2U6znApmozXNK6euqBltCogwkRblLaMZr6MyCX5JV8i4OHUO+zzG8K0E4IR6m+byyTSyhEy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuY9BSQVu40EYAKKR1YvjlUhh8TzRubiHQ5V3ezcK3g=;
 b=jsm6CcUyIPkaFG0+TNVL4v319OBWcr0svV+5Rbo/Tmakne0o2Hv3CD1L5Gi/m7p/qmDunwUoSLwSP6pKuSSCMEECjId6YTBQpTa0K/J/fqrKFJYh8k78ANG5EsWafTfaH5ijl50Ntn/nXgQmA9ixs2l5gjw7oPA0zc7mReyddpKPFIQDOAXjCqKmAcTWn7oI/ZDzkyyev0SEWbPeZwatry+R5oV86Kc+zvSAktPT0qlpp3p+tkvUCJZwR42H8s+x6hU4lCOqqCGUURGFGykbrvSIg0+MONxij69u99g3jfg+2PvpFbERzZxPtG76PEL9f1dykaLaOMH8yYndq0dfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 06:45:51 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 06:45:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Topic: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Index: AQHcHJY2YKFPoBQc1k6SDELAvZKU07SFiqKAgAqO7zCAAj6KgIABcGJwgAAiyYCAAJKy0IAAtdEAgAD7jGA=
Date: Wed, 17 Sep 2025 06:45:50 +0000
Message-ID: <IA0PR11MB7185BD2FBF69CAB338E73073F817A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
 <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185758D6CD5D2774E6373BBF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <43a98363-0607-42c6-906b-4f79e5740ea8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185329E174E270F6911FF03F815A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d107e7d4-f5cc-4714-b5f7-cd7d9a35dd6d@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185820387F1F84BEF4C613BF815A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <849a2f0c-55d5-4324-ba99-9333a733647b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <849a2f0c-55d5-4324-ba99-9333a733647b@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6509:EE_
x-ms-office365-filtering-correlation-id: 0aa657da-9a67-447c-6122-08ddf5b5d778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WOCMWqYJjGx9kltolPtObl/zZL540GLDm8CJtOlGdHaCtaPn+zs3VAcd+A?=
 =?iso-8859-1?Q?RFKAl9WKAfe+zDLzJJHmVUC8XqmQsO0J+1rthuU/IXK+DBVQ+T3D6b8jc5?=
 =?iso-8859-1?Q?KmHBIhrh4ehjVn9pKLKHQye4LdlnUurZ3fpRjoLrbEGhE+o3Ud/gDn2+RD?=
 =?iso-8859-1?Q?ufVMo9lYMsmCcJleCk+5zgVq2/6rTy9wDv8FKKbMdLQykWAlK0XZVLS67N?=
 =?iso-8859-1?Q?/Gml4eTi/9mZWSFGgdIiOqGi7ebMR0of8tvOecjGhNPoWNhRHVCuooSj9f?=
 =?iso-8859-1?Q?RqtJpjsCb3g0XnKzM9dfGBts4Pf7BpmnO6bxzUazMcRuD+2OLl6O605J0o?=
 =?iso-8859-1?Q?n2eQrobzUCN61qQihBECYxcejdgXDlYeSuUupRhQypP0RJv88Z8KGHLAmy?=
 =?iso-8859-1?Q?IbPAc+OQBQN6eb4yJnLR0dCMuHzq6iMnzqIPcXDEtTsjd+dOg/+xae4kat?=
 =?iso-8859-1?Q?AscY3mQ2AfnyWwpsSd/T7bth/uXfU2PfNnoS6dD12eXkNYFJbTzsQ2qY7v?=
 =?iso-8859-1?Q?DvfNt6+x3piJY8dF9slfsYQa96U43ihiwmWV4eOOvdMMHpTF9CDsNtX4Qd?=
 =?iso-8859-1?Q?BsEt9Aq3J3KaUtFAFMmbdadHh9xvS0r/o4Q9K/IGCtOkZ/BdfX84j5WsmG?=
 =?iso-8859-1?Q?q5bb1woY+E8NZ0nQzEWRxm6kOWF96oFGeIOHKEcgYZT8QL5FlbZYUo6X7C?=
 =?iso-8859-1?Q?A8cbCIMsK+96EYSK1H4mmDydo7VGXJNkARPemdibUDYrdiYFkOD5h4V0p5?=
 =?iso-8859-1?Q?Cr79dXJY550ZYqqC/Y+YBfKX44JD4K11GOgQ7+i7aXOP7yO4iBeXj/w8Um?=
 =?iso-8859-1?Q?14KKHCdnuTuiygaJxfUvxFn0PnEIpbJDadV/zfU/pgEioRa85K7jV3jjUr?=
 =?iso-8859-1?Q?/UC/pXre+UZSdpQQIUswQ2s1RL+1ilKwYCDzjKgUyR0VMnbiyyJon+KhpK?=
 =?iso-8859-1?Q?rlbsurATXIwDaNAbwbT0WJJSjBoT9fy1Xl838kpzvy1MOQ7FzmGHqvsfms?=
 =?iso-8859-1?Q?N3/KJerQ1Z9W8zKY2wJSoRdNPm50wunR3eF+rvTSgOLSzj6ukkRmfbYWEX?=
 =?iso-8859-1?Q?AeP9ZSHk+EzQbZcA3AZ124ov07+F0oliQuYGgbEBykzfmZjypskszuLfYj?=
 =?iso-8859-1?Q?LImRVBUkjpMzk+t6ELmdzJHy7JINrURenOkH5KtBSc/NClQn9mMmfwLp9X?=
 =?iso-8859-1?Q?JJlOIfjOLg0WjbmCzJ+0raudBUiSvCxQp4qYyP3jUZvL+tkoxPA+bgv5On?=
 =?iso-8859-1?Q?BR+KByVW4IgIR76ZiQ6nCh710hJjF5l+ToLiSsZqLX1czYBzvzakcT4DC/?=
 =?iso-8859-1?Q?EI9tERZImejHEifDgu+AYJkraA5ToEdae56PekU+UYt5VpK8iB3CvBojjG?=
 =?iso-8859-1?Q?tQmb40mGo5/L96IsFxYkHb2ZP5ZnPjB2DuLskuO6bsqNkKQK7hQ2lA8K12?=
 =?iso-8859-1?Q?Fkxs1lyMlLbt9GgXDFAo3dlFw+6xQ7tdcrsADwl3oUHsuCt2WZoUzpN7DV?=
 =?iso-8859-1?Q?/mqoWmyJC4O8sCojlLcnxsxdw6lzsM9uRiQ/YYu849+EPe0DcarxBzncjS?=
 =?iso-8859-1?Q?VP2T7sY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pstkTHFMScx7lDGRATVcKjX0+U47XgQDRj768wPIqLSC5DQzhC3L0c6T2+?=
 =?iso-8859-1?Q?FmcH1QCkIyAupCdTRAiAMLcDYpbfLgs10vsRh9wSfXsCZBaO49WERh5Frr?=
 =?iso-8859-1?Q?bc6LgkBmtOwNwN8tQNiMFfzxYrQ9wpjjbWmopTEJqfXhIOj7lTOBJ4aLHW?=
 =?iso-8859-1?Q?5FAf1XbK29VhXvJQusN40VBo+x8XFrIj7BZl6HyubDjGq7aWtEgPjfu6x5?=
 =?iso-8859-1?Q?GeMGeVi7EkyEaPKGzHAUoB652tyqcaALWL/k2HijfCoSaL8Hp+YvO+q6Dx?=
 =?iso-8859-1?Q?02mzkuDUCK6e1bEG7qu0HcgcA644bumMwjLqYWbLs2ADEbAwNgqK/wsETP?=
 =?iso-8859-1?Q?8WprYH8+FQ6muqtuyPOdOHXuKz92osnudTKHbDwIdY7YfCQyr/A0VHjgp6?=
 =?iso-8859-1?Q?9IGvpHT4WbIFIkIKW0GEZdqFZETwUBo0rrxock/nS4JRumKbL5Cm7N3uzs?=
 =?iso-8859-1?Q?Kixbca+D+XDOAtivo2x7WU6fu4ESfuixW/XrlZVLCNoRr0SyS0S4aqpNxN?=
 =?iso-8859-1?Q?UQKy7goDKm3y3HDs//N7GduWcbLy+Ktv32S+A29TC3sF/ZuegptaZaaN+0?=
 =?iso-8859-1?Q?pTQ7Yu7hvFHE+4/VLEQ9Tk/83JkuSSw8aPjSg9brcqeWmIG4R4QPwYUmRA?=
 =?iso-8859-1?Q?Ow0yUl1rkEk/a6Q4bwltC1LKQJEhICaClMNYVgNRzCDIqKoX1/zLWRYzhp?=
 =?iso-8859-1?Q?SSuVbSUfqzpQ+fER6D/B1P3wYKUbvngVpwFT7iWJDXVx3bGni+cAwjNzYq?=
 =?iso-8859-1?Q?Vl45PrhVbnoplpW55a1eXUnANZ43VnSU6uS1GhaMiSVxhmCsRakw2KnygA?=
 =?iso-8859-1?Q?ssvzHInvl/pRBKjmNbO8AdWdbMv45UD1HFm6agB8AyKjVUgZcTQR8ISbIx?=
 =?iso-8859-1?Q?Vrpfq0tacrTSOxIUz+jki9rmPRB8KZrUevGed+nmEdOHEY+w9Om1GUn4LK?=
 =?iso-8859-1?Q?vY/LPfMJWtgnzb+HTgt3izsM3EmGi3g/eSoCTIx4Z6s97ia9HzciTeZQNx?=
 =?iso-8859-1?Q?pLxwTGkSzpfSgRth9gSpI2QmnEPMm+ci5YusMBSWv1vdXf7eVP2QjvU2a3?=
 =?iso-8859-1?Q?TvY9VnGKgKRpKtqIbt4L9hv5aURezPNiL56wd3qos6iRvk6fwf8+N4tN4i?=
 =?iso-8859-1?Q?d4UFsaI1XpT7ilHDbcoWt2udiM9ucbPK3odE4oAdzYy0Isxyo1n0V+zPBR?=
 =?iso-8859-1?Q?MNPi9uvFkFcy3p5NXx6HmEFagj4prSho6bSU/HkhqQtTjpdunU4oqOjWp7?=
 =?iso-8859-1?Q?ocQrzrZKISXB+skapcO+CKP3epWXFJ9KGS5V+NiEM7clBp5mncmS76UMRi?=
 =?iso-8859-1?Q?W7CeEndqULJRO0GZyuk4VzvIqyhLc8ge7fhP5gFQaN6om65wTvxia5tUoG?=
 =?iso-8859-1?Q?IwA/esW7hlQ47Y/SREeK6VZxjmXg1cU7yM7hKGVw9R/xyoghYkXN9QpXjW?=
 =?iso-8859-1?Q?5P1Spmkt6ExnN8qKkKaC4RuGvw1OFna0YTXeruBv7AcMy+4dgMvoNll1b1?=
 =?iso-8859-1?Q?7V0iHzkIy8FKWa4sKkWT63jgY+/exsgG7e5EIuTojjXWnpBmvJZXrFjMi8?=
 =?iso-8859-1?Q?NG0CqAwObgUZtw+tXiumGBWVNOvWfEnPqb5OmIKVqL4iyJze+yS5JH2wfi?=
 =?iso-8859-1?Q?APiYBRZzuDRfBrxkBtzFGB3WNLrI8S/irz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa657da-9a67-447c-6122-08ddf5b5d778
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 06:45:50.8791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXUdxmtlZLcCIrAjvtRGE7xQBOBPI+4PK2eiwWbAQEvuSEPAxTGhtcE0HDgthiK2Hzz/ih4agR0XcepXXyjVsUcgjY9neRb+dxd1r7IuLoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

Hi Akihiko,

> >>>>>> On 2025/09/03 7:42, Vivek Kasireddy wrote:
> >>>>>>> The res->blob pointer is only valid for blobs that have their
> >>>>>>> backing storage in memfd. Therefore, we cannot use it to
> determine
> >>>>>>> if a resource is a blob or not. Instead, we could use res->blob_s=
ize
> >>>>>>> to make this determination as it is non-zero for blob resources
> >>>>>>> regardless of where their backing storage is located.
> >>>>>>
> >>>>>> I guess this change needs to be applied before "[RFC 3/6]
> >>>>>> virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
> >>>>>> devices"; without this patch, the "create dmabuf" patch will
> probably
> >>>>>> create an invalid blob.
> >>>>> Ok, makes sense. I'll move it earlier in the patch series.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>>>> ---
> >>>>>>>      hw/display/virtio-gpu.c | 19 +++++++++++--------
> >>>>>>>      1 file changed, 11 insertions(+), 8 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >>>>>>> index 0a1a625b0e..2f9133c3b6 100644
> >>>>>>> --- a/hw/display/virtio-gpu.c
> >>>>>>> +++ b/hw/display/virtio-gpu.c
> >>>>>>> @@ -57,7 +57,7 @@ void
> virtio_gpu_update_cursor_data(VirtIOGPU
> >> *g,
> >>>>>>>          }
> >>>>>>>
> >>>>>>>          if (res->blob_size) {
> >>>>>>> -        if (res->blob_size < (s->current_cursor->width *
> >>>>>>> +        if (!res->blob || res->blob_size < (s->current_cursor->w=
idth *
> >>>>>>
> >>>>>> I doubt that rejecting a valid blob due to an implementation
> concern
> >>>>>> (whether the backing storage is in memfd) is tolerated in the
> >> specification.
> >>>>> Are you suggesting that the whole if (res->blob_size < (s-
> >>> current_cursor-
> >>>>> width *...
> >>>>> check needs to be removed? I think it is just a sanity check to ens=
ure
> >> that the
> >>>> blob
> >>>>> size is big enough for cursor.
> >>>>
> >>>> I referred to !res->blob, the new condition. It rejects a valid blob
> >>>> that is backed by VFIO.
> >>> The problem is that for blobs backed by VFIO, res->blob can be NULL
> but
> >> this function
> >>> (virtio_gpu_update_cursor_data) is relying on res->blob always being
> >> valid. That's why
> >>> the new condition !res->blob is needed here to check the validity of =
res-
> >>> blob.
> >>
> >> I understand the host-side implementation difficulty to support this
> >> operation for VFIO, but the guest may not be prepared for the failure =
of
> >> the operation so we shouldn't simply reject it.
> > I think the worst case scenario here is Guest VM thinks its cursor is b=
eing
> > drawn using the image it provided but nothing gets drawn. I guess we
> need
> > to separately figure out if there are any alternate solutions to addres=
s this
> > issue (such as rendering the cursor on the Host side).
> >
> >>
> >> By the way, perhaps it may be possible to provide res->blob for VFIO.
> >> Since "[RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associate=
d
> >> with VFIO devices" checks memory_region_is_ram_device(), the VFIO
> >> backend providing the blob should support mmap().
> > The problem is that for dmabuf implementations in the kernel, providing
> > mmap() support is optional. And, the current vfio-pci implementation
> (that
> > provides dmabuf feature) does not support it as there was some
> pushback.
>=20
> Can you provide a reference of a relevant discussion if any?
I meant to say that it was deemed undesirable to add mmap support to
vfio-pci dmabuf implementation considering the Confidential computing
and other use-cases. Here are some references:
https://lore.kernel.org/dri-devel/20240501125309.GB941030@nvidia.com/
https://lore.kernel.org/dri-devel/Zjs2bVVxBHEGUhF_@phenom.ffwll.local/
https://lore.kernel.org/dri-devel/20250107142719.179636-5-yilun.xu@linux.in=
tel.com/

>=20
> > So, relying on res->blob always being valid is not going to work regard=
less.
> It is still possible to mmap() using the standard VFIO device API even
> if we cannot mmap() via DMA-BUF.
Ah, right. I had not considered this idea and it seems viable. I'll try to =
implement
it for the next version of this series.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

