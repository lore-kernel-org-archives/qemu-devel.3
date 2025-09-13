Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8EBCAC582
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 02:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxGEd-0002ac-Gg; Fri, 12 Sep 2025 22:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGEb-0002aP-Mh
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:43:29 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGEU-0005Qz-Gs
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757731403; x=1789267403;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gQUC/xh1R2c5O/4aH3oYypfdAP9Lg8MAYNBne1fWI8U=;
 b=jyNVDvPhmJHcrZW7n891ytklDYqOzSYkVLNPFB7cPDZ/SOR7pzM9JHRp
 ZbLAc7QzFYKJ3vW7bpWcOBKvOYIljUp6A07ZgPgO8AbO/rLfQrXK7VpBl
 oDl+RMoWIsGBF8mGBvw7CyPDXatYVAOgl42e9pV7hywmyAtWNyyijYzJn
 ev9zajKIQDB6nQ7JwffcN6DEteRYzcbDEemkFMlGMs9i9humtZC/+CdaN
 BADKOc7vlapv53iTrm0H0XBAYkpqGrBf44EVclg6D1+qtTNwu3DH8R9Cn
 zeFCD5egq6MNlZByr2J/oLeMmJu5byBWmm3weUm6D+18euPSfZG41UKda g==;
X-CSE-ConnectionGUID: J/YdO6wrSVipXwXD7Ld68A==
X-CSE-MsgGUID: zpellwJtQOWZo4UPBZrVdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60137662"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60137662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:43:17 -0700
X-CSE-ConnectionGUID: zX5aYM6URe2EV8ckCK28Rg==
X-CSE-MsgGUID: v7sb+PF3Teynafbzb5FEdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="174202849"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:43:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:43:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 19:43:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzULA7z6eTqXo1ZJrzq7nLADkQYKCPlf9Khry55XiPqdOnS0SqIQb1Tb1fjbNTk4fLAMK/fBvx29TGE32Wy81EB2MB4GSIDlLHM1xeaQe1hN7htj78OsOW+kN34I/ZEaYbcPQkbND28EwJXQk1Obm7g9ZxQbIrFpAag5FpTxLLFFOdI5n+KyfTbuQnxit4kh2sub4Cj9Zdxjz1p25MWJQdXZDJRM/ZggsNIis2LcWjC7PaiLC97FOgH0Y8nXGnAlcxV4MLry/rqmAyVuLnma6gIIGagmdgAxnRdgyIqj/vIkTiFKybJZp6wSn/RIG5N1978LE71ptsa0nw+dAxh7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsbwVGNT9fpQUDeT8Gg/hzti8IttKNCtzHBi9+CJAGI=;
 b=AVaiwMjUkIoGPx65MyQgASfpeWKu+FD6juqkXxANecMxn5jTEJMN5TRJZzF9tV6hR5vEBACxaxsaC3Rujw+kIM6eUZYH4orgjuwsF7QMlATD549JpUdQGuPY07WGxVaDWa6yg6ccs3+ztZuMLGG48j+tGVONY7UVfOEJ5fAcbc5ZBn2wRPHZUEy0sKhKfGDmuxYH2nJ1njoiUF5Qm0CKhmuGFagdQfj2r1oNTHx00zAeuyG0jxMc3ZVXdDICWZEQiVLYgh0wF7Un30ABfndONCg0dCxgFM2NvOhi2eeiCR/213RVmMo4QVqK7NwBMTLu3hOASUcmNimgGInAULk6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA4PR11MB8916.namprd11.prod.outlook.com (2603:10b6:208:55e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 02:43:14 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 02:43:13 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associated
 with VFIO devices
Thread-Topic: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associated
 with VFIO devices
Thread-Index: AQHcHJY2UoRSgBTU8kiOLETShajzz7SFh/WAgAqPWZA=
Date: Sat, 13 Sep 2025 02:43:13 +0000
Message-ID: <IA0PR11MB7185F10B489C1650577CE085F80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-4-vivek.kasireddy@intel.com>
 <684609f1-bc19-4c28-8ae1-802fc9a1ad6f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <684609f1-bc19-4c28-8ae1-802fc9a1ad6f@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA4PR11MB8916:EE_
x-ms-office365-filtering-correlation-id: d538798d-9b04-40b5-bae5-08ddf26f492a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TP6LwhSpw5sjLcB+pJaNwT2YEQT+a8O5FeZlVSAQnL8L0Bv7YIInz6Rw53?=
 =?iso-8859-1?Q?RwbsNsAyBuSbe5hVI8vm//l2DP0ce8wH8X4Tx28J3zn/woAdeP7GJlqPVn?=
 =?iso-8859-1?Q?J3ex37/XiYLk3wA1Ose6b5nPipt7HJm34lBdEoCs3u/K86YceWZff0USpU?=
 =?iso-8859-1?Q?L17SSVorUiLhqGwkTSGEjh7VaGkVh5owEnXVH0SzfF9GpTVzqqE9ETCSef?=
 =?iso-8859-1?Q?gnJGKb/KszUiwcwRsvrsN/ZveQWvzJyMFZyuaKxZSVaaF2m27TNmW8UMeS?=
 =?iso-8859-1?Q?FKzF3bam8pBJtWCxTW1saT8ekCVOEw2qNy7wHTxZdt6bVo9HiRYo4ngFAf?=
 =?iso-8859-1?Q?foH4aLxak3R7R/wZCEW7F3LYc047rA4tTd4Bd7/KKMBAo09Dmfzv9qN6Rh?=
 =?iso-8859-1?Q?VyEtvmVfQhjf2MQHcICFzrOIWZXSkYBUy3dv7GAEpqJ56k89ftBbLz565/?=
 =?iso-8859-1?Q?XwXt279SqIK/LaYOeNtI1j0gd+WGQhzWW7j73VcvNgp7XCzp2dZItj0jwM?=
 =?iso-8859-1?Q?BIH9/XpuWenKquKUl1VXZRMWch8MwjN8/PTtwvLceJ0YARxmONRNV8SxUD?=
 =?iso-8859-1?Q?qolbhL5+3tcS9YY1eOhw5fE35OZEcj28rGI/EcBhDdpXI3QUgpdujTTeug?=
 =?iso-8859-1?Q?jsLiFxpbcSR+iNIy31MxqO1+eMGCOq6vkOZIp9Z2O7UUpcLk0YFdjl0HMU?=
 =?iso-8859-1?Q?kg5PsHQxS3zyt+w1RBjMzzx4m+0LUpSvoEFYxktj9XrdUxA07yueWcRSpP?=
 =?iso-8859-1?Q?aJR3CNbpGrhXedyg64dTDubuO1Pw+8j8MVMYGAydxL8PfJsKaSQVQ8cIx7?=
 =?iso-8859-1?Q?0S6JRNlJxuDwQ0s/Vc3Yzy+w1cSY3NLbTKrlQgBCvaohpMz+NShiV7xyvy?=
 =?iso-8859-1?Q?T4I8x+NcT2o5G7Cwz3QISOXTcr2fIdRMRoXuSEOwAkXjjeWtqSdg96FX/L?=
 =?iso-8859-1?Q?jYBPd4CQWqh3plI5Deh3aXqpqQ9KaBqN766XjEwMHECc5zmH4FxFJmtwwb?=
 =?iso-8859-1?Q?ASoVlm/DBzroocmAkSLheeX52GWqMXhcQxSo6RlSM6pt+lO4rSbOBWJ404?=
 =?iso-8859-1?Q?lp/ewRhl0wpFiD9hOyJLqttid9drHwoDSXP7RlbXiSnu/brLIVc7Gkhevy?=
 =?iso-8859-1?Q?Y116GsXm/X3T1WRx77A9nOMXCe4/Lcj5fLw2AamiaVvyeZLqp4HDGE7C1x?=
 =?iso-8859-1?Q?DLyy77Zx/Ne209eXHXAlA16iENGm/wIqs6gzY5dc9ysEZaybmsFJMGUW5n?=
 =?iso-8859-1?Q?irj7EN/UVsw+sF0JVJ2TxbQGQSbgeDlmWfWeucwySRHwGpSoTk7Z+Vd0T1?=
 =?iso-8859-1?Q?UcF7T4kMqRqxkwTAHN3BFXzSh4k75tOpL7QS+Qu+7gCxS1iLkwkUtfjaQY?=
 =?iso-8859-1?Q?rBlXC8s2ZbAfC/V4NkDy4QD7tgl7wK9/2yJnTY5vC3OJUyVadh0unTpDW+?=
 =?iso-8859-1?Q?ruw+NT9vN277wkurltCmi3CLqrOxBjqi6yYxNIF+bK98Yme/fvB/ABLBgG?=
 =?iso-8859-1?Q?VlHjBI4NDAbgWIE4Y81LUAQYgpHgc2xURV2Uv2eKzVutDAMxTjZ1yN6wqc?=
 =?iso-8859-1?Q?dEcwLAI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NxGTwXuF9BjnWaQ7VZkV0nDiQEKkFcmgdkVJtttnA34Pjnma+mFs0/rEGe?=
 =?iso-8859-1?Q?O8SFScXKiHkc03ykudbN2HIZUYBzqU0uS1dVbtiWyw+grBgc2dxKivwgC/?=
 =?iso-8859-1?Q?hvKDmnuG+lDha5vFf0lEc4YR8BjiWBnTA0F9+R5nmWK3SFKt8+wEqPH/TV?=
 =?iso-8859-1?Q?kiA5NDyrWkVhM+A6gQQ9vYYsox2cNtVk4WP6+zBpu0AcIrDkOmG16HDzmw?=
 =?iso-8859-1?Q?DhnOFAZFVyvRrm5ykW1TwGBDdBqFyWxVN/vBbHk+N4L22h2MDQfwxk0lWU?=
 =?iso-8859-1?Q?c/91N9pBpFsXjenZIB3Y5F/ciuviQruRffk0nZ9gMtIFKBXKAF3XniTB6b?=
 =?iso-8859-1?Q?2TIyr1Z4JxhqoxVXTI3nMK8gZt67YTZgqjjVhNYo9DeEoBx6vZNoH1ush/?=
 =?iso-8859-1?Q?8Qfk+CG9ouJXKIzzkL6K4/k2MpiGEKlWdjjIHzvYoXT+I9btQguipL4aNq?=
 =?iso-8859-1?Q?5hNaY0cG8VbCcMOIVD4WB9NYGzd5KdWCzrCjB7SjH1NYRHjt6ilixFiBSe?=
 =?iso-8859-1?Q?A1IvURnO1kmdFzEAR9bpe5aJR3Ks41r0h0SobSotIEhJMyvw0WcSj2q8Pl?=
 =?iso-8859-1?Q?2HXICQ2QZtKSZ6A2nnKMg+ZrNfJiJF0wWKRaUS5HMNNEzizgVSegBQr43w?=
 =?iso-8859-1?Q?FZrm2drk426N/BOXsgpv3e9H/mG8A4lYXL0tm0GwyRP3IGt8LC2cl4DX9f?=
 =?iso-8859-1?Q?e8HDgtZ9ESHC4klYJw0mrRp5SJKBaKKU6ELa4sVCRWRfD59Wqi6iLbfiIG?=
 =?iso-8859-1?Q?NcE4x82Au/cfaFjcM0N288XKLvmRb7B6E0+BqeSIZqFKWn9ZwIDlAeeHX0?=
 =?iso-8859-1?Q?XUVAMjvZAEhL2a+XJoHOApcD/WY+W+7Y8SEAZiObVXHXFez8C+ljN3QsAN?=
 =?iso-8859-1?Q?Ki53PbDpEpBzjCWK3bWC+6ROOMWPJ+Yd3fWZ18Inu+cT37XhaU02yl2d4w?=
 =?iso-8859-1?Q?oieDw1ER5H4B5glp6TMJfszm3HLCXcWkXjWjWci6darmC0rX/9vR5dUz0s?=
 =?iso-8859-1?Q?W89kw6p4Y5wEa99lD2AcpL5Tm/m82eOiNMl2ycyu2ptjQNQbSJvsqSc4Ou?=
 =?iso-8859-1?Q?KQeonCHCHnrIPKoI3AXI/4ENErTFMQCpJggE3aZk2TIL8dOJalVWM+tEB7?=
 =?iso-8859-1?Q?jH3tDelH+nhTk0SYb+FWccNnCR2irE5RViBjpqZMMEj9BBevhi1An/jOt1?=
 =?iso-8859-1?Q?yPs10gM5KjbPHTCdZvSHKqlBMQXuafmCgykQtp/11FAkN35rtkXR1RU0jT?=
 =?iso-8859-1?Q?kkAuDfRWovCehgJ8cceLXgBySQL2T0jGaECzRKvOH3On+hu8cvpslfMXgy?=
 =?iso-8859-1?Q?gk07wJ4SYrsuT8TgsseKnsfH/QmbxAbNAoN0JFUUfigeBL3OUYzapUDNRp?=
 =?iso-8859-1?Q?FqJVA0Lubym+Q8sG2Wl0LQPmO54cB7k8CZ0fy+oi50ruTHKT6ps4BMBjOd?=
 =?iso-8859-1?Q?4vQVJpeZ0zVW5pWm1S4YNiIvmZBXrTzHQtZzEKl2w6aPktQ2ue22HOfNXd?=
 =?iso-8859-1?Q?4ADTOnojo0D2yvzqOUH910Jczf4P1V5S1hu8eHxPaJCrfo9HSCQ/OSIQG4?=
 =?iso-8859-1?Q?Is3Bduoo316gMIdNt5DcBMRdsbmOCpSedca+0mDExq5q9PbrqANQrh52K5?=
 =?iso-8859-1?Q?IDg00NgLtVkG7y6KcYSO7vnKrhbJbm+PIe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d538798d-9b04-40b5-bae5-08ddf26f492a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 02:43:13.8888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThmTu7AeYbxETAHk6offVH9UjV40V8czXZ0tTNuWb0CqaJJ8NZPihDp2LLa12/JJauWQtUvRWsj76m01mKILPw/auafWnJPe/HureHrVAOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8916
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Subject: Re: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/09/03 7:42, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Therefore, we first need to figure
> > out if the blob is backed by a VFIO device region or a memfd before
> > we can call the right API to get a dmabuf fd created.
> >
> > So, once we have the ramblock and the associated mr, we rely on
> > memory_region_is_ram_device() to tell us where the backing storage
> > is located. If the blob resource is VFIO backed, we try to find the
> > right VFIO device that contains the blob and then invoke the API
> > vfio_create_dmabuf().
> >
> > Note that we only call virtio_gpu_remap_udmabuf() if the blob is
> > backed by a memfd. This is because the VFIO dmabuf implementation
> > may not support mmap.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-udmabuf.c | 60 ++++++++++++++++++++++++++++--
> ---
> >   1 file changed, 52 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-
> udmabuf.c
> > index d804f321aa..0390a8f488 100644
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
> > @@ -27,6 +28,32 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static void vfio_create_dmabuf(VFIODevice *vdev,
> > +                               struct virtio_gpu_simple_resource *res)
> > +{
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf(vdev, res->iov, res-
> >iov_cnt);
> > +    if (res->dmabuf_fd < 0) {
> > +        warn_report("%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s", __func__,
> > +                    strerror(errno));
> > +    }
> > +}
> > +
> > +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> > +{
> > +    VFIODevice *vdev;
> > +
> > +    if (QLIST_EMPTY(&vfio_device_list)) {
> > +        return NULL;
> > +    }
>=20
> I think this QLIST_EMPTY() check can be removed.
Yeah, agreed. I'll remove it.

>=20
> > +
> > +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> > +        if (vdev->dev =3D=3D mr->dev) {
> > +            return vdev;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -130,6 +157,9 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    bool memfd_blob =3D false;
> > +    ram_addr_t offset;
> > +    RAMBlock *rb;
> >       void *pdata =3D NULL;
> >
> >       res->dmabuf_fd =3D -1;
> > @@ -137,15 +167,31 @@ void virtio_gpu_init_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +        if (rb && memory_region_is_ram_device(rb->mr)) {
> > +            VFIODevice *vdev =3D vfio_device_lookup(rb->mr);
> > +
> > +            if (!vdev) {
> > +                warn_report("Could not find device to create dmabuf");
>=20
> It is odd to print a warning only when the memory region is a RAM device
> not backed by VFIO while it prints no warning for the other incompatible
> memory regions. It is better to keep the behavior for the incompatible
> memory regions consistent.
Ok, I'll have the warning printed in other incompatible cases as well.

Thanks,
Vivek

>=20
> > +                return;
> > +            }
> > +            vfio_create_dmabuf(vdev, res);
> > +        } else {
> > +            virtio_gpu_create_udmabuf(res);
> > +            memfd_blob =3D true;
> > +        }
> > +
> >           if (res->dmabuf_fd < 0) {
> >               return;
> >           }
> > -        virtio_gpu_remap_udmabuf(res);
> > -        if (!res->remapped) {
> > -            return;
> > +
> > +        if (memfd_blob) {
> > +            virtio_gpu_remap_udmabuf(res);
> > +            if (!res->remapped) {
> > +                return;
> > +            }
> > +            pdata =3D res->remapped;
> >           }
> > -        pdata =3D res->remapped;
> >       }
> >
> >       res->blob =3D pdata;
> > @@ -153,9 +199,7 @@ void virtio_gpu_init_udmabuf(struct
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
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf
> *dmabuf)


