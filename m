Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91355CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RFE-00020x-SB; Wed, 08 Oct 2025 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RFC-00020e-T0
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:18:02 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RFA-0003xh-OM
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759918681; x=1791454681;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b6Z1a2gwxNspgyZ4P/DSHZ8o1p2E23G8df3a2aJW7RY=;
 b=jKhXlHAB+ef3mKjyQe3GOzSxFHLFOxaH6pcLPVi/66dp+7cji3ZffTz2
 qd13TBWqXmHcrgoAntkYthPyzcZziqbO9a8PNI5oioiLzLV2VpU8OZ4pM
 7ZJv6tHplkMkjbW+txNVvq4oDM/xOJz2/qP0vvyVlmWiWrlMBgqGxsa/m
 MCc5NlWqVqLS1aiNi7Ki1B7s0O93W64FMvGLFOUizUjA/MIchAMR80vsh
 X3ycnYtnZ9GlmU2EnR5oNGnHxToGwTPZX7VeX7iwm4ZXyXWyZzLtRVOJk
 vQxB+YFTE5IF91HUydefH3CX0sVFcjcoH+gXZdrQ9+LJc301MwX1Hn7bw g==;
X-CSE-ConnectionGUID: cZYBir/ESrWhwMNqvmobOg==
X-CSE-MsgGUID: 8U3RV2iJSgeN3ann/3vRPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61142162"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="61142162"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:17:58 -0700
X-CSE-ConnectionGUID: esbsZHz8RNOrXjqrnK0L6w==
X-CSE-MsgGUID: D4AfKe0jT0GuxjfMkuph5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="217500633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:17:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:17:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:17:57 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQuXjguv9867XUhPS4M2x20l4WvJmPrb9KVj1J9h3a0VahBgCrpRFqWzPAYLo60ugU31MFJMzanuEyiqEeKKEkKXEOcO6QzcaQ8CecnuzKHQTzfiH+25pLrykoUAwEJ9xtPGV/swoFkIReCCYHvLD5VJs+V5VwIcbQm27nxRiJmy8CJWk0Sb1cXJSle6C+nCQ4A776DOk+UYEOeW6rc1+uJ9mQTngN3003Dp6GbOiFzevyJ3GC5ZPSxO1eFLVMNa4ImkLDrK+dhFxMUqk6SqAXEy5MQRBQaT8GBXiNextwO/9X0pgROFr89cTjGra6D0xdsRc/SNm283msCSkiBKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Npy/b/rK/m/LyAfpmTWFYsqkhLHzNb2pYXsH+2FE8U=;
 b=d3ZY+nHwFTQvhXixtWlzvPtJou/DjZpvapCw8/w8DwUtpqBB9MBoEVCnSxqbH2nBuRISR2jce9ufVz7CySSKKgT3MnqpkuPUkgvQFNtSwgxrLVtjJrLet7Qa/6I46r3k3TZWjcrSYc4mwNfTt+6XE67wpZW6aMQABBZHCkP/4y0jr8fkwMC9hY3dAvABoN0TiZmekDmKNv4FvvvoTOEHqwOAE6XvvLbwhbj5gjNoEXo4eLksF9asAcetHH7m40UrCQE3XaQNCiMHk0a5cYKl57/aKWqdu+fbbetuQMLDO8jrHH9R1znOPQeUehwrMOclkZKc7138ndg8j1F6MZLKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 10:17:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 8 Oct 2025
 10:17:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>
Subject: RE: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Thread-Topic: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Thread-Index: AQHcLSFOP3lFuvTAwE6oZXK9Hxqc07Sr4xCAgAe4mDA=
Date: Wed, 8 Oct 2025 10:17:54 +0000
Message-ID: <IA3PR11MB913663E6A00FB2905B4F7AAD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
In-Reply-To: <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: 98e67a3e-77b6-41fb-6588-08de0653f1dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eijYZpppq/SnIu5k7MqGVni0LdR6rEawXZXmt+9VXVqNukwD1KH+vrFe6r?=
 =?iso-8859-1?Q?nwKTQjWHrFCOAZB6nURqjgUQ4JJX8yYzRMi6ADkqalA1xirSZ5+uJXfkrk?=
 =?iso-8859-1?Q?rIozwKw3X758MbX9lIvc+Li4cXRJwlb9FyVt2O51TT4ig7K81pAALNWx+a?=
 =?iso-8859-1?Q?snFaz7RF9/VbcJVFDlmOaJVm/zzURZlG3v/n3Qx0xYrjml5pPhXdntEWFa?=
 =?iso-8859-1?Q?ICJapLAtCveAHOMArg0GCZGOYDDSNAv47fjQnUYf0FZ2UZSqF84FYaOc9+?=
 =?iso-8859-1?Q?zXkfr0tI06oW5sDqhf4i9Sx91NF6a7r6cNqlGVBKBw5LrI/DYbe8OSPC9H?=
 =?iso-8859-1?Q?ukf6+ifGZjD8GzEDzdb/coNAIBzCWGiirGf7CpICkw4jSF0azdua7V3Gvd?=
 =?iso-8859-1?Q?C4Jj9X/gWXzcfn57ya4TLLoFPM3GJgkknZMuACbqh+qUY5qg4w+llwQkkd?=
 =?iso-8859-1?Q?yUxPgt3zQm8S83dIAzVF4uCfSgU4NXbMNEB51wYIKsOeKzYXL9zQsRPKUx?=
 =?iso-8859-1?Q?EGhYELLULgJkG1J6l9DH8JQwIZRcDGbZO7OhGnKItIZLdEJk9FXu+WE3nU?=
 =?iso-8859-1?Q?qhdljzKSneE7Mf0+VGGe7Xq7xM/VkibzI1hlHGM3/U64PAg/n0BPDlT9KZ?=
 =?iso-8859-1?Q?nOVlDHwr5O4z0SOCGAdGJ45j2lsu7FA8Pbn312aodBMlL+mFUOsWMV/YqN?=
 =?iso-8859-1?Q?IjvW/zVj3DP6fobbMU4HVHgd8B7VTExNPpYH/OwaQKyNocmhBVrfxX/2iI?=
 =?iso-8859-1?Q?7FIFdM5dlx+zKPhOqpQBHlvVoerMeItizRd0+tbNJAZ2I31yui+gTyqy6a?=
 =?iso-8859-1?Q?tEt3ESuUnphS9NurQ+U7tmqu1qtwqFMbweu/RpSBtygv6f6RUgOcVwk5BV?=
 =?iso-8859-1?Q?f+fFJx9I7yEOfSdGwJqals6tpagryhOnt42SXGNYqH0BAhB4tWELDU42jt?=
 =?iso-8859-1?Q?uhiJ8hdACNNQYQwnn+7mVqyqFyefFCo7UpjZcza5aPeJsgswT+bJZH7kgC?=
 =?iso-8859-1?Q?UQ4q5F5rVeC9X0iyqzNdW/pju/1UY1p7rO/J2t57PdhhR6c7Iig8miKWvG?=
 =?iso-8859-1?Q?VPgXWEeonNAdjeeTZE+wDGy/Nw+tcZLrcFq1mBPm8iCtKPzT+dbx0/K6m6?=
 =?iso-8859-1?Q?vSVVTorDQBOTFrL/N9AoPKjrqo41A3u/jW+CebJ4DbGCgMqWdfP9/A4qVv?=
 =?iso-8859-1?Q?VL986dutB6GQmjQ8kjDNOIop3jQhwLddBmoVtesWVi3qVx2MUXN2vYWkAj?=
 =?iso-8859-1?Q?1mNSqcooUjzOlWPJdzGhuj5bQ6ZEL18zpByZNURlx+kpjfP13IYZZv4D7r?=
 =?iso-8859-1?Q?yaC7HwGdCGODkMVxyH1PZN+NtkahA79dNWP9NbkywsJv1SMJYJYGrrFB3B?=
 =?iso-8859-1?Q?KFlw8gzIwhDXRLwUwtbSA/+L/B4pG0dEIjd5/uwCIr60zs7ymC9iJ8WRq4?=
 =?iso-8859-1?Q?AbDMLNR4lTK1mO2M9Z2Gb4ERCxDEeIFVCI7VEAaBfepSVoETUfWQ1BRSHt?=
 =?iso-8859-1?Q?bzoeWsIWLvWFUpaArLW5DRrZnmNc9QzGLneTRaO8DM2TMBiqYuh+99q3Wb?=
 =?iso-8859-1?Q?HYk5LLkJasmPmcGnynCSWhLWseZo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gmNc94zFcxKpWOYQ1NjBMuOxtcX9yg+jWF5htRfDBc8Dh6FRSHuUaqt1we?=
 =?iso-8859-1?Q?Srn1abO4TfZ8c9pyQU0d4tdiLV6aCDQURX+iakHxCvaVt4fO0OycI790lQ?=
 =?iso-8859-1?Q?PjnVlpVgX7pHOYX4E8sCfIcKc4il7uHNdrcdb2XRjiUwGDfnYkZl7urUP2?=
 =?iso-8859-1?Q?Ohq3IWjoVolGlU+4J4dos6Trn7tf9Fa37zKFdW9K/b9nwKyyfEwtN+kfnW?=
 =?iso-8859-1?Q?DDC8xLigD9zVTo3JAUwJFr78UvbE4bwXZ0Iazi/u7rtbu9OQV/FZliXh+I?=
 =?iso-8859-1?Q?RuJ0wsy8eKFoc91bnfYkuISEppYZhT6aZwDC9eCz7qyObHX78nGFBpQmBe?=
 =?iso-8859-1?Q?q5nfwf99U17pivDQ9XaKpusC1Waye3AyEtIKFBhZILUxYt4ZTVOrqiUGwB?=
 =?iso-8859-1?Q?5U5sa7MVIv8d/OgR4walXvlvXuKyIazU8rvpyEHaTsR44mZ0xG1E4xinfR?=
 =?iso-8859-1?Q?dGi5YN0JqGrjooPa+q/X0L9YgbRTA5Ra+AO35A0LH2Ojryj6YTXDd3W6GV?=
 =?iso-8859-1?Q?qBQSYpKUruL4utA00K6bQhc05Uh3ZphSlAK7Tozg4qxwXKN9Z/js36qG9K?=
 =?iso-8859-1?Q?dtlkFV6En19139zO77qmGjZPbc1fHg7J1RHLZo1Db8PSpTzMolNsgnysSd?=
 =?iso-8859-1?Q?hfxO8dFX0ZgGYh83zTDK7lzMcwOXhl4BEOTE4znPqkWRon/WLrSYIspNe/?=
 =?iso-8859-1?Q?Q9B9wyRswTrXs4UT0uGJXZOwBGDWeYU9VAEkyI2U+Xtjkn8VshnzUvBsky?=
 =?iso-8859-1?Q?PeLd2yYpPr/y2nB9W0m75roMo0eRbRxX3LFILnywPisSuoJ59P8/07ezDs?=
 =?iso-8859-1?Q?cMi8ldn5zg1kdln4OtRoXfcV3McAmGl+HB3C7WerfMI7K3jUJvoVqPVS/Y?=
 =?iso-8859-1?Q?6/QHwTeAlsUj7oKVaocQM4Qr3hqhW8AftSsggdkM1u+CTEmoLbKd7BCRvj?=
 =?iso-8859-1?Q?EndeEsnyx64sH3OP6v1VfnlVA7GvWIHPJiy9tHRhFSe92d6FF5QVEW+hWo?=
 =?iso-8859-1?Q?/GvDLhwQrJTVzjanNWNJlYNsz/fuan++VCdhDSA09Zs35eLk2ag0tfvY34?=
 =?iso-8859-1?Q?u9xUqrS/SwFHGV05WFfMfSK5tio5b2aUEq1RILYGfn5CyenZ/J3qqzSpZp?=
 =?iso-8859-1?Q?L3pHE+mFieZ7NN9a24LSYM8MyB53XuiQpgdIiSfHm63MtljLMdZFWzsbFc?=
 =?iso-8859-1?Q?ofokRAEhlSuEx/3pIjPi1RGQN5Rpa+OFsQnrEfho0BpygLZt4I71SIpOu4?=
 =?iso-8859-1?Q?Uy/FSe/ZJe90leznpw92skVZ4X8vMrpLD+KhiSRoxDpbKexkamARCLNdOe?=
 =?iso-8859-1?Q?BMNF8P6EViJjA7GuS4OtlkmSMeaRtXJa/PpUTIaJCVmc9QfL0K9on8nD0z?=
 =?iso-8859-1?Q?VUlIsAOOEYc1WnuBrYFXdhDjG8R/ihtYgsMkrJZl6bmN3cGmDhVzs1fwiN?=
 =?iso-8859-1?Q?wttyILW4QAn7W6WDjXHiN6Ne1J4jEshqQnLhTaQDCtJnCugkNCbMUlykEA?=
 =?iso-8859-1?Q?DdSQmxFTZZPYneX9xbHLHBu0S/NjaTW0zWSMZ3+pIbWBqVd4mZmMzuw3ZF?=
 =?iso-8859-1?Q?sepC6XXcKjqaE+38CLMAw6FoJ7kklOdVv/cNGlZxbCfhQoZsJUrYg2QgSg?=
 =?iso-8859-1?Q?+EqAk5SptSwOLKD0/G84ysi3Pmh4ZNEnWQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e67a3e-77b6-41fb-6588-08de0653f1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 10:17:54.2699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TXP18pUDuNVE2BwkOTcCeaeZNr9MKO5d4C93CXrG8DqctcmPXZNn+Kt4qwSAKNtgIqO2GHuPAPYh0r2oRJkCA1laGpI0wyHIsRyKD8faaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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



>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
>
>On 9/24/25 09:02, Zhenzhong Duan wrote:
>> VFIO type1 kernel uAPI supports unmapping whole address space in one cal=
l
>> since commit c19650995374 ("vfio/type1: implement unmap all"). use the
>> unmap_all variant whenever it's supported in kernel.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/container.c | 33 ++++++++++++++++++++-------------
>>   1 file changed, 20 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 030c6d3f89..2e13f04803 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -122,12 +122,12 @@ unmap_exit:
>>
>>   static int vfio_legacy_dma_unmap_one(const VFIOContainerBase
>*bcontainer,
>
>Side note for rebase :
>
>I would prefer internal routines of file hw/vfio/container.c,
>which was renamed recently to hw/vfio/container-legacy.c, to
>take a 'VFIOLegacyContainer *container' parameter.
>
>The 'VFIOContainer *bcontainer' parameter should be kept for
>high-level routines that wrap the IOMMU backend implementation.

Sure, will do

>
>>                                        hwaddr iova, ram_addr_t
>size,
>> -                                     IOMMUTLBEntry *iotlb)
>> +                                     uint32_t flags,
>IOMMUTLBEntry *iotlb)
>>   {
>>       const VFIOContainer *container =3D
>VFIO_IOMMU_LEGACY(bcontainer);
>>       struct vfio_iommu_type1_dma_unmap unmap =3D {
>>           .argsz =3D sizeof(unmap),
>> -        .flags =3D 0,
>> +        .flags =3D flags,
>>           .iova =3D iova,>           .size =3D size,
>>       };
>> @@ -187,25 +187,32 @@ static int vfio_legacy_dma_unmap(const
>VFIOContainerBase *bcontainer,
>>                                    hwaddr iova, ram_addr_t size,
>>                                    IOMMUTLBEntry *iotlb, bool
>unmap_all)
>>   {
>> +    uint32_t flags =3D 0;
>>       int ret;
>>
>>       if (unmap_all) {
>> -        /* The unmap ioctl doesn't accept a full 64-bit span. */
>> -        Int128 llsize =3D int128_rshift(int128_2_64(), 1);
>> +        const VFIOContainer *container =3D
>VFIO_IOMMU_LEGACY(bcontainer);
>>
>> -        ret =3D vfio_legacy_dma_unmap_one(bcontainer, 0,
>int128_get64(llsize),
>> -                                        iotlb);
>> +        assert(!iova && !size);
>
>The assert deserves an explanation and so probably a new patch.

Sure, will do.
I'd like to move it into core code vfio_listener_region_del().

Thanks
Zhenzhong

