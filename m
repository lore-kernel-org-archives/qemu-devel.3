Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D10C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 02:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCVr6-0000Q5-S4; Wed, 29 May 2024 22:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongwei.ma@intel.com>)
 id 1sCVr0-0000Pj-CL
 for qemu-devel@nongnu.org; Wed, 29 May 2024 22:49:22 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongwei.ma@intel.com>)
 id 1sCVqx-0000mY-W5
 for qemu-devel@nongnu.org; Wed, 29 May 2024 22:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717037360; x=1748573360;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nwiA2rrxvMkai7pjhQ+/iIiwQNRL3Sq03+gGXybrx/g=;
 b=LN1zlXjzOeHcFEDMNqllHdqEcooDYcO5xt6LUcdLo4fGQTHkG39fTAL2
 SHYj4AM5ZhB7GPuxnDf+03xP5i2J3qzI1lE+BDz9M3c4ajqYJ5gpDsGKy
 1/OeQgCeWmPeF6IZcWlqQ3YQSe7oydalsmhwo7vmTXZ71zxai9JYzShms
 IOIXNa6Zp47Gc6x/2M0gJuw0So2xbswjC2mkz5XoRXYCQMlLHBsgXpoyy
 UdTv5Ef64xAmigoud32RlXDxSo/nYvIiMozOM5+tbd7h0//bv991t/5zv
 63ReOB4z5IR8a0LQltRCzxTMAcweAfI4uB+f3Miwg/uqR9cg0+xBOzvwK g==;
X-CSE-ConnectionGUID: /RXw/Aa3S4y3LfmFIxG6rg==
X-CSE-MsgGUID: mPWs0etZT6CA+x+La3Qh0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="31013533"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="31013533"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2024 19:49:15 -0700
X-CSE-ConnectionGUID: SdxJSBMQQ8WxbYqcrDWZgA==
X-CSE-MsgGUID: pPqWqjmxQneRxwH2gIC7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="66857320"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 May 2024 19:49:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 19:49:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 19:49:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 19:49:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 19:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/oXkG7gmCiXW5XyLIA/tLIZ0uHZ7uIyHkH2GdCkNTKuWAzXLoQMOCn0saed6BZbCrKjlOw6qzY8IfD7LUU58+LoGfpboWyYYH9BjgNQOh08SoMkVD12nmCtfTHD7H9K5mmIcZcwFbVB6iKovzNRfy4nqsMl7s8XNiUiqkxLMnpoownecYGH5CREJ1LjqErFhqoiD1nZW8OQvvNBA5yWSvqqU0ClwD3D/XdDCE8FAfJt4Og/t+SH3tg/uWC6BN8jUYCPO7Y2LM4BaQ7Zkd/B0FnC8JQFSNlqrRAntlY4+Oj6+ejd8AI0en4fI9yP6Bm3a6XbMy9CQXNkSJTPdZdK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwW+QBqvvOwjKgq4BJ2u2GgTbIB9z+riYLRlMur4cCI=;
 b=cq1b8vHDwvXgikqBq9uo4+VU8pAlKDF8V+RL7kbXoqaKgtV1gIbuEA5gogG4CoQKZoDNbdao7Z6mbM5aXtLs3Y24thD4mxddQaDwULulHQ8sAip7JnCKGIvCFPDaIbB2aPGp5W4yesRbQ4HKw7BprGi53+g7Atw9J53pXDLKXKBHKJED1dVutA7ShKKXjY19r8zjUY74R831wY6v78vMXDyS93mlB/aQQ4eBOo/tkEEUs0969nZ2Z7fiiG3Fls+sJMPE/dFYpQSLEcpomtKw5w9CXCHeNRkCZLwak1xxehSJWmqEII+Cer0TXW6iNsEjkjYZSMfWwAIfolXv4LXtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5368.namprd11.prod.outlook.com (2603:10b6:208:311::17)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 02:49:06 +0000
Received: from BL1PR11MB5368.namprd11.prod.outlook.com
 ([fe80::49e7:97ee:b593:9856]) by BL1PR11MB5368.namprd11.prod.outlook.com
 ([fe80::49e7:97ee:b593:9856%3]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 02:49:05 +0000
From: "Ma, Yongwei" <yongwei.ma@intel.com>
To: "Liu, Zhao1" <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/8] tests/unit/test-smp-sparse: Misc Cleanup and Add
 Module Test
Thread-Topic: [PATCH 0/8] tests/unit/test-smp-sparse: Misc Cleanup and Add
 Module Test
Thread-Index: AQHasY4Nderuqr/yG0yqTxrv2UyhSLGvE1eA
Date: Thu, 30 May 2024 02:49:05 +0000
Message-ID: <BL1PR11MB5368F4A4C421A2A256D94DF089F32@BL1PR11MB5368.namprd11.prod.outlook.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5368:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: 63ba1622-bae3-4158-3c4b-08dc80531255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IesoZzvj5J9+SYbEZNfIL5aCBXpYIG9u6QtIvti2Pfe97iQ7XCMyPMc8OK?=
 =?iso-8859-1?Q?FfedIg7S/5689QQoVE4nGn5WUosXA9DHA4EZiElQ7N+H4gDFRspRRImpJ0?=
 =?iso-8859-1?Q?5pgBJfKuDFnp+gqddpmXcoj92jARYmMLTfuvOUS9+g04QbtLYd2SGZdrTv?=
 =?iso-8859-1?Q?lwdjVwJdtDIrm4LPBgGFgCoNBj2dA58db9vhNsHREOLL4Tz2lM6Bx3ze6L?=
 =?iso-8859-1?Q?KLCiqb5MRD7AA/6yJiwHYrsFJfrtSaPcMQ7LuXUE+rcSZ1KfIoxbn6HS7T?=
 =?iso-8859-1?Q?zzFK2u6jygfNL66DeXFGRHWjV8SiC3wTnit2sGdRWLgv7QEg3ci4qVqA+X?=
 =?iso-8859-1?Q?B2FZK107O0WKh6QHazPX9muCxn5e76GkeU8+CUBL7GZ/mpwO0xcgsuK8gy?=
 =?iso-8859-1?Q?EU9+766tNFTvY70bWPIj2kCmak++xHc1D9fBgTsePtIOiVoSZUMpGt5wNh?=
 =?iso-8859-1?Q?RkviQbGdzXncZmND59Q3orlA57rEOZ118VAGKbcClO4C2lXrb4xBpbq2Ao?=
 =?iso-8859-1?Q?0F1aQeILg3993i0FuGRJyHTCazsEspZYsoWnzJcLj56pVS91UMZX92V8mu?=
 =?iso-8859-1?Q?2VF1C4NkmCspKN3a80Z70TTixnB1rXAUhR3PRi4hKnNY3pGIVSo7eHZV21?=
 =?iso-8859-1?Q?q6O2nrINUa12Qfsj0dvBqayJ+EFH9zxPUXXuLNceN4bmPjNcUeblb51+rd?=
 =?iso-8859-1?Q?WR/+iqtEtQK4kibQ8V+hII1CLFiwixlpYUu903fpO9qzd0SAhud8VhGEIS?=
 =?iso-8859-1?Q?iOWgQvsVOTmZB5saysbkKl1fxc7JW7F2gOu+I9bJw5EcFu087SyF87Rnlq?=
 =?iso-8859-1?Q?EbA9jgVnz2ZBFskajfTetozH7/6pMhkddsbqYNPwQWKX4v/YiXec2lE6fO?=
 =?iso-8859-1?Q?SUD6KLMUv9Jb/t+57C0ViwM2StXfl+ocZx5HwSoDBBJzW/v7+HhV+nT+6c?=
 =?iso-8859-1?Q?s7y058EsdslzPsoWQoS/7OTa1Vpq+e/3Ogjv0e4B+s9Xizd9e2k4jz/I5c?=
 =?iso-8859-1?Q?zVJ5527HEmpM1nfoGf3uRj0LhT9Op538DUDO1nFgRqaWLoXtzLSDJWm6L0?=
 =?iso-8859-1?Q?qkGJGEusDbrzDkWR5rGh2CRKorHSOjglVAm2sVfNWdn+jv+/qSEPvqazEN?=
 =?iso-8859-1?Q?IW+FGjIzToX/Tb+Urflxj6ZzLPvdTl27vWQcwI0P4vwK5etU/YbBa4BuZB?=
 =?iso-8859-1?Q?Sj3M+m5wqnwWG8iTnPMlnPqFsqfGUEFM87SC065ieReau+ikAYOCjo71qT?=
 =?iso-8859-1?Q?O4HKSes4X4qdjPzZNYRNZnWHC3oh1sN0ZPf0Mmmzq5MZhjXvhKhNgiIKQo?=
 =?iso-8859-1?Q?ZnoR1LOTS8qixt8Gb6PGe9SRR5SFSrxJUx6+pmWCOp4FwAfK2JDyRcItgt?=
 =?iso-8859-1?Q?xNxuW1i12RJ0mmQ3R7I/djcMPWeW+e9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5368.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TSO8w9aUK7GI2f8CfIUBsTHVqyCQgyiSDJ7dMHthiKHzrnLZnt5VMxWCMH?=
 =?iso-8859-1?Q?DL5MafMnZmX+T+BNskjzKQcOJtOxthm11vtMzXHFVgi9gGtC8Bd0gS5WqT?=
 =?iso-8859-1?Q?C8ymW1/YiTCApi0eO+KehepbRup1UlHB1puL+tKg9lfXUx93zlY6Nm11c3?=
 =?iso-8859-1?Q?WmaqR6co4lD4v8XTvT8RL/G63tYfykd9FNyny2JgVX9xFAAqXZMMRj7lqW?=
 =?iso-8859-1?Q?1yilLqqLEcqhGfkxkwa2gzPCsF3jMIcubrt4D18pn8DGoqnQHBmE/I0VM8?=
 =?iso-8859-1?Q?8+6byDZrlRqFLh1d0A73eWpuyqlf55LgQvuJG5hS76thv/CoJG9Y+hjKPR?=
 =?iso-8859-1?Q?69ZsynZvR0pnwRFvQOqkNi41zkaISGiWM7JWwTApMqrM9mSQornsyiY3Y5?=
 =?iso-8859-1?Q?9CsCaITdWMvIzjc1/UzRSDqHE/YrZB/a9T6DzmAjxo3Ck7Z53ftLIhNKu2?=
 =?iso-8859-1?Q?nZhetUTkTWWMrP3e1d9kySWApcQtFbZ3SxQ8WhMLr7szCJUSQcHTxj6aXr?=
 =?iso-8859-1?Q?cF5vqclYq4AbNATZsVOv3MbztqkGx0uhsDGx0jEly6DKsnzVGrHCyuCOtY?=
 =?iso-8859-1?Q?PU4yqVOaU6SiFrx9k/uvKthsdH5lh4QGKItKqL1K8fio1vWB6ENccMZKlg?=
 =?iso-8859-1?Q?+49lwm2ddd71iqIXKYS2olZNYnD0TUfKR5QNPtWecLjesUVNUOp+ZxnBwZ?=
 =?iso-8859-1?Q?Xl0pQ3+BUmKHLUHEfSPereHP7D9NNzwnw+YbVmXhYej9M+7MFEV9Z1qBHq?=
 =?iso-8859-1?Q?2TK9wdKHmwFu+EtZy/t4CRLHc1P9aIGrMbjIhHGTM6sh+6ZWr8sraX1Gw3?=
 =?iso-8859-1?Q?0kMRUHXVXwgOGLJIFP9DfDeAMOh0+Jm8VEL7dPWWm9Fp7UaSO8+7Zzgwps?=
 =?iso-8859-1?Q?tJGpcYifA6QABb0xIatXcW9N43Jj8dPRw2PAHLU1cAti4VE78qJ/Tvqw4E?=
 =?iso-8859-1?Q?XktDFqTMeDZ4n6k8VFtbjMDn15imFfBPNT3pjUAhCV+Ss4Oya0HqAbVL5i?=
 =?iso-8859-1?Q?70ll25+SfOzbbbSwQjTXIyLwI+QNc4l2UrsQldUaspT/MiwKMbqtr/DGxj?=
 =?iso-8859-1?Q?X3HUzJvRMuZ+dQWNuZdFpFSPBsyk4s4Wiefk4EcWFd+eOBis/z3gTStfT1?=
 =?iso-8859-1?Q?172jl6QsZFcA/Wb8PwJ++a29uznUFOYym+R1MA3DFu1ZKutBXOLLZ4OSqf?=
 =?iso-8859-1?Q?vc3iJukWxBc98oha0VXYsDbAgV3mBMY/zl1hjcd3eCBboAeqR4VHZeqacD?=
 =?iso-8859-1?Q?HbI58Tf12E9qQr4VOoJWVoSey2rA8bkUQTMx6ORh7RV4N9JptXE9wwEbpp?=
 =?iso-8859-1?Q?zH0pr/wYmlaHTh49eb525Bywd6OzDPKbL/MVAslMsO6yiZaz84yQ2bAgUG?=
 =?iso-8859-1?Q?v7ys7JNSGVVHf5nIn5Op0a/3SA+I2M5VrLLWFEXlgxmVQ8LAxiEQ4QWcSp?=
 =?iso-8859-1?Q?RR6Qdf1psCbJpZgUCHgtdf0U7LwnhP8HByO1YuJpmpBmb+CJCMTQTdact1?=
 =?iso-8859-1?Q?hWLJ1ItjPlcWFKbfYxq3EuFMwrFImqxnXYGEQS6SFVapFGw0pVXFl6/O2V?=
 =?iso-8859-1?Q?qRKsGGc7C7QHejnd8IbrlMhUO8d2J10SRYnKPpbInYZH+N/M+kXzCPtXgd?=
 =?iso-8859-1?Q?xy+XHRkyEWHIo8X2R2GTFsgCk4zxC9BK4f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5368.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba1622-bae3-4158-3c4b-08dc80531255
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 02:49:05.7944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxPTWuSXfSfoPEyKn+uw2eepp4ugKyWxYillQj9mT7K5LmHxx+orAwA0yKiAxA105z141+S7Fi6+BpD6snBUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yongwei.ma@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/5/30 10:45, Yongwei Ma wrote:
> Hi,
>=20
> Since the module support has landed in x86, and it's time to add the
> module's -smp test cases to cover the relevant code path.
>=20
> This series adds the module tests to ensure that this new level does not
> break the current topology information calculations. It also includes som=
e
> misc cleanup.
>=20
> Thanks and Best Regadrs,
> Zhao
> ---
> Zhao Liu (8):
>   tests/unit/test-smp-parse: Fix comments of drawers and books case
>   tests/unit/test-smp-parse: Fix comment of parameters=3D1 case
>   tests/unit/test-smp-parse: Fix an invalid topology case
>   tests/unit/test-smp-parse: Use default parameters=3D0 when not set in
>     -smp
>   tests/unit/test-smp-parse: Make test cases aware of module level
>   tests/unit/test-smp-parse: Test "modules" parameter in -smp
>   tests/unit/test-smp-parse: Test "modules" and "dies" combination case
>   tests/unit/test-smp-parse: Test the full 8-levels topology hierarchy
>=20
>  tests/unit/test-smp-parse.c | 373 ++++++++++++++++++++++++++++++------
>  1 file changed, 311 insertions(+), 62 deletions(-)
>=20
> --
> 2.34.1
Tested on my x86 Ice Lake platform, 'test-smp-parse' case could PASS.
Tested-by: Yongwei Ma<yongwei.ma@intel.com>

Thanks and Best Regards,
Yongwei Ma

