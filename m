Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF69EB7EB2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxi2I-0005yz-0U; Wed, 04 Mar 2026 03:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vxi28-0005xT-Ti; Wed, 04 Mar 2026 03:56:44 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vxi20-0004Sh-TU; Wed, 04 Mar 2026 03:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772614596; x=1804150596;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LvfqPvCPtLIUNfCjsszl+Ug+q818A6XdOeT1qJ4Lp0k=;
 b=SH+vuAMLNasztu6pfRVXqGVMQbb7qQ76HR0nTV7kkDqod+K65mNYuEil
 IDgfW1Vlba8np03lkRP8pqoNNlnZMG+BG0s37MUybAX6I0N+xiRH3RrIl
 m/h3ZSjojNjtzpNHJB5oLtLV9/4nTpCYjnUbsbXr2JFY/E9eAzJd27tsE
 A1czMo7jabp757EPBcgW6/6E8MmrYyZuZhV9stR2Vf3JXF3kEBOpbSnxj
 6OIg5yWoQz+ofGTkTzkcbn36QOsmeuu5tZ5Z5KGifgKNzam7w3bbgw7Mx
 ZGZH8jZtWkiP0dhNewU6E8djfw711N3jcUHjOhGCZKYVgqCD6aD5ghz76 Q==;
X-CSE-ConnectionGUID: g+4tmr4VSXuWPYkw9EyTUA==
X-CSE-MsgGUID: JDYPHcVFTcyapNpGQW8WMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="96279728"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="96279728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 00:56:26 -0800
X-CSE-ConnectionGUID: OdgIQkb5TuCNJxvx5wHXqQ==
X-CSE-MsgGUID: PLdo+PrAQAKGeG0TOHdEpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="215250944"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 00:56:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 00:56:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 00:56:20 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 00:56:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQm7HPZa/85WkB/FrrEqngKNXlFQIsK6URoTkWozr/YkD75CKv6Z5YLJshcrff3WVe8khscnb8ynHTXd9egwqABO+4ZfK5YVr36HB/ZBswi8kcORnVMVGDP+qcMzNKvlh0AEogTyIO7/bEJEZVv0st0uI2qgk9QTnOru+gdgj6FZ+7t0FP1/mMUTnuRP4esMIt4yPXWD6R121MdkHMZnIPifM/eIUKnai1sG1h4FNfHgFiSJq2+vnyA4veHMW9F4TNnTZWz6D5NinGmXsHcxa8aJjtLIbQDKWi+5U9Qxcu09pt6FYUO0DgDzWf6j3Y3xw+mxau/Mf3AsOtPq0qJFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VjyU6PWdc8o1wVsaSs/CMyv4PLyI+j2I/y3A/N9R5g=;
 b=vHW5CqHDgs9qTZDPgKj+juF9LSPeqnh2IDKF+Q8hR9U2+cJtZ3Ce4OURLxWLzFa9l86qVX7vuFZOeI4Q3gFdwmv5GXkiNUlhX0s6TLjofaOLI8x5ZjO03d4/QXhk4anquG6cIuNh2IfosYlJwzujIa/UprLFW51rfZdokO2pWeyyxMBscKEfWJX0mAeQOmEDGWeJf39HVW11oe85LIP0K81DQLpXMWXR2Gc4ciPgbNQ16Ce3rpHnOFGHTYUo7EHji+OhKSFdPCK76MsQmQDrMitNyJ0fO8AYkhaufyY4e1wqP8d9LmHreLnGTvBOs8TBrBNCOex4HLIsjmyp/9k6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:56:17 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:56:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxrPWY0EIaO2EyyMmxqBreJU7WXd1wAgAKmngCAANiH0IACyuCw
Date: Wed, 4 Mar 2026 08:56:17 +0000
Message-ID: <IA3PR11MB913663EA85A8B00DCEAB2301927CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
 <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91365D6AF54A9D44998A9BD3927EA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB91365D6AF54A9D44998A9BD3927EA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB5824:EE_
x-ms-office365-filtering-correlation-id: d66195a6-2453-4be2-b13c-08de79cbe5a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700021; 
x-microsoft-antispam-message-info: 1lu0Kxbb8Z/pBOTje25U+nshCE24c7cKJBuJEQvUxbnOb5EuaWD77RcerSG2cXlkFOawRbq4SdWG+ClQ2FAtT7JUTX8MilwyVr11HY49uEs2pSfeLoQ1AWlL9SNskkdRJUywpk3IyYFBqVEUXbUQiOw33A3FmgIHe47InjXd7S9Y+pkebRX4iiWwirXYNyrgyfxPqOxbF1dGIGlnaPMH6jXynn2s9xsF/eIp2o4xSwA/DkcYHfT9ki10k4OhSvCba1ueQSsimp97Q6DD8lP2RZ5dnJhCC47lVgqVALyaovDVhaHR/46FVJlYFOS/w8HGjez1Eezsexywp0q3i+k/w8jQ8svyB1y10dCCRQnNUJAsdkg8cc8oYgctZ/fIjuumM31JqiVTObinWH45x+pDUEDYsV5o1r7u9dC22eHftHMoBzS+H/9DgJNr7Updn+6RCCWOtAmK1/hV6y5s+ncq8ZP456JH3jyTbwk0ooeLzbekYjlisEaGdcdYDHyEes0VVSKFPqhc15jU9+Jkb4dND6j51sKdeWbsksvUGEa43LsIikDlnDVBlY55bQIbS+n7Lwc5Rngtt2mJRg5NF2JIjXcNGbeHdUAtmyUbdXDd3/+oCFhMfptKkNhV5vAFUF3Un9kjHNlBwxHp09rTIYOapBELapah9mFP3aeHFJiNBq7rLKkh46nuo/AxhlJ4xBlUguiDwZ5wR3rZ/83K1o5srG5DR7unzCbjj4AxQ+P5FYEVnxHXTHONTjmgNaYoHzKAGclw+jG3+ydSOD44vkIPsDjTB8rR2gKylCTvfvJUpBCK2ies459/mrZvZUJfExuT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q2Mk9Y4Zeseq27RdsjbhhhPWXm07j67KXbQQJ8QKOuhxDD2gPPtJvLtpblsu?=
 =?us-ascii?Q?ITxwr+j9Ov6Zk+nEe9LwfIFXyUp8z/JdMTEu7aXGOLD8dXIlNa+JgvKmn3+c?=
 =?us-ascii?Q?6ax+o6zjFmrDrmT3EbrlOPQhG0Qg/AD19kWum7DFmsEw8a3wyyUMMDQtREPe?=
 =?us-ascii?Q?PrhzOsSQ5rwbZivCDzr7mZV5JIFb3fHMTpyi/gVO2WxV/8dq3B0a+klGu3j2?=
 =?us-ascii?Q?8P7/c0oXJ1KLYQzswfIRn09c83RZr/H6GE2OYvuXwVIIjZ5gau/mUKa4vWSt?=
 =?us-ascii?Q?/vTOWLDe8ER1bUXPvRBkiZixWUxRtlgSi6Zwsyekwpnvmq1ePp/FOXdjJm3s?=
 =?us-ascii?Q?+l6D0/o8U6Vfo0B5fHOWhQv/sv8gV04luhWGNjMIuCpRvPF1Pbq9zmEAnbEG?=
 =?us-ascii?Q?1yl/bp6W8iLm0INNyJiYqRHzHUCFc/1SZUWr7deV90Oa0b4G7kc9pbKU8zd8?=
 =?us-ascii?Q?xFAx8jiLFibKJ9t8YuDzvyni0sDj2KHDyW+9UlWfioD/9QTyFksUq1g85uLH?=
 =?us-ascii?Q?48kI2RwhrJkhUdaR7U2BOPYjsEP7Rt4wUTADzG1VQLo8pkMCSRreQ6Pk2ojJ?=
 =?us-ascii?Q?NE6M5U1JZA8xqxxIcgvIa08Oyr7eB7kjDhePEsudMjjyQCEG3YpzcPxGvq2T?=
 =?us-ascii?Q?aeQVZ9nVWKX4FcCZg1MmKD9VxkfgxpMS1Md+7SvkM1b1PlT5ROBUsb8cGmWf?=
 =?us-ascii?Q?CVM1fXm6zh0uuRJkFipbIioFSvU9GxWaWbmpL6ZbV3uQOwz1lU1gZbb0nyV/?=
 =?us-ascii?Q?v/pMCDADbQkhVfpCPT+zrKQJ6zGZzVWey60K5CHVvuZfuapxqSrVI1fjSalF?=
 =?us-ascii?Q?xMY77Z3w0vcu6WDdJsmu2zuP94KHopivo6pHZcAM+o8eQxtcaDYrBCXjV2dk?=
 =?us-ascii?Q?Tq2O4tDYG+w4I1GXQwCmV1SmxZeQ5A8vb0gEAEstgUFRwMLfqAfb+zmsZptO?=
 =?us-ascii?Q?0TyqyfGry7Yx/E1a0ifYv1aX8oGu154xJ3gM9WIx88K/e96/kYnhrJ1Fzna9?=
 =?us-ascii?Q?Br1WcEis3JkPl4+SvIj9uRtefAIdvB4iYFfhjEqSwft9OzduOkaIIqjyefqY?=
 =?us-ascii?Q?ECtsAExwKUL69/YAUlXLLFjgmcE7wgBK8qhqARpxw+7rjY4ux7Jtr/OiXNcx?=
 =?us-ascii?Q?/SqrAfsBhpl9vwiScDMn0XslWXJTQLa0Z57XNHDOhv5lNmyacNIIEQTrEvnT?=
 =?us-ascii?Q?sZsNeNp7plGMFl9gLeW7/msbAUzS4ZL5qNIEZ6e5CMs+oVacrDXoJBXb3kOW?=
 =?us-ascii?Q?WIXS80/tnFJILe4J0NhhxC8sSnYY4gff6FMKjh2TMBOXEHHLt1qVt7sMW/gb?=
 =?us-ascii?Q?eTtTv4fwSz8pnFQlZ7dwDHoj/8kXC5kYGZrIYwJ1oF+O+1+R20NWAxwOpmFX?=
 =?us-ascii?Q?6OyUyDJL9N4mpe4jGHsAAS7keKGqOcvuGucYMpoca2r7XnoRSESBScQk/N/T?=
 =?us-ascii?Q?Iy90RQMgaMDrpDSdXG+bz7JqCYEN62StAwSgR+WdEM1qxRuI8BcUWkfor+TF?=
 =?us-ascii?Q?Uq1bLuXxvpl/pIHm4rZVow1cJcvynB+dUxwG9vFUXUCnRLNxYTupyfqLbfqM?=
 =?us-ascii?Q?ckYQbwxc7OV6TdfFyhkeAEtwxAY6YbLFDEfNalJroMOmiGCid2Kl7KO1/nfM?=
 =?us-ascii?Q?jV2zRk6lgjBMQA+wVr61D/KC7z8RuhBkdd3z4aNIEYRveY8stwH5fJOSu9l8?=
 =?us-ascii?Q?UO2gvIsKkYWVCjrAgdjH64+7Fl7gk3OdyN+1LLQkDEFNsahuXVEU5Ww0OiJL?=
 =?us-ascii?Q?uM+Kh6xrPA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66195a6-2453-4be2-b13c-08de79cbe5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 08:56:17.1311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmYIFAzdogqfmWFmO9BpX8tdrY421H3ntnUAC6nKtfKceJGyiNLe6GEmCmY79VIG8KcB4lWxUIomW0qFhBsl1Y1sklGDevkcZ2Xi6NUozyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5824
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Duan, Zhenzhong
>Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
>vIOMMU events
>
>Hi Shameer,
>
>>-----Original Message-----
>>From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>>Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
>>vIOMMU events
>>
>>Hi Zhenzhong,
>>
>>> -----Original Message-----
>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>> Sent: 28 February 2026 06:28
>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>>> arm@nongnu.org; qemu-devel@nongnu.org
>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
>>> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>>> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>>> zhangfei.gao@linaro.org; philmd@linaro.org; Krishnakant Jaju
>>> <kjaju@nvidia.com>
>>> Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate hos=
t
>>> vIOMMU events
>>
>>[...]
>>
>>> > static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>>> > {
>>> >     IOMMUFDVeventq *veventq =3D accel->veventq;
>>> >@@ -397,6 +441,7 @@ static void
>>> >smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>>> >     if (!veventq) {
>>> >         return;
>>> >     }
>>> >+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>>> >     close(veventq->veventq_fd);
>>> >     iommufd_backend_free_id(accel->viommu->iommufd, veventq-
>>> >veventq_id);
>>>
>>> Did you ever see free_id failure here?
>>
>>So far I have not seen free_id() failure in my test setup.
>>
>> I'm working on PRQ using FAULTQ in
>>> intel_iommu
>>> and find a race condition, I suspect the same for vEVENTQ because both =
have
>>> similar
>>> implementation in kernel and qemu.
>>>
>>> qemu_set_fd_handler() is called to remove veventq_fd from epoll() but i=
t's
>>> async,
>>> this can lead to releasing of veventq_fd delayed after free_id(veventq_=
id),
>>> during veventq_fd releasing, it drops reference of veventq_id but it's =
too late
>>> and free_id(veventq_id) already failed.
>>>
>>> It's not easy to reproduce, we had a test case in guest to trigger FAUL=
TQ
>>> allocation
>>> and freeing sequence in loops.
>>
>>From a quick look:
>>
>>qemu_set_fd_handler(fd, NULL, NULL, NULL) -> aio_set_fd_handler()
>>
>>aio_set_fd_handler() takes ctx->list_lock. For the delete case it sets
>>node->pfd.events =3D 0 and then calls:
>>
>>ctx->fdmon_ops->update(ctx, node, new_node); where new_node =3D NULL
>>
>>In the epoll backend (util/fdmon-epoll.c) this results in:
>>
>>epoll_ctl(ctx->epollfd, EPOLL_CTL_DEL, old_node->pfd.fd, ...);
>>
>>As I understand it, epoll_ctl() is a synchronous syscall. When it returns=
,
>>the fd has been removed from the epoll interest list in the kernel.
>
>OK, I think I understand wrongly.
>
>>
>>Also, I think, aio_set_fd_handler() and aio_dispatch() run in the same th=
read for
>>a given AioContext, and dispatch runs with ctx->list_lock held (via
>>lockcnt). So looks like handler removal and dispatch are serialized at th=
e QEMU
>>level.
>
>I just found my scenario is a bit different from yours, aio_set_fd_handler=
()
>is called in vcpu thread and aio_dispatch() is called in main thread in my=
 scenario.
>
>>
>>Do you see a specific window where the fd could still trigger after
>>EPOLL_CTL_DEL returns?
>
>No, just speculation.
>
>>
>>Could you confirm which fdmon backend you are using..poll, epoll, or
>>io_uring?
>
>There is no CONFIG_LINUX_IO_URING defined in my env.
>GDB printed fdmon_poll_ops  for iohandler_ctx->fdmon_ops, I also set
>breakpoint on fdmon_epoll_try_upgrade(), no catch, I think it was
>using poll.
>
>>
>>One more question: is the FAULTQ register/unregister model identical to
>>vEVENTQ in terms of allocation and teardown ordering?
>
>register/unregister model are similar, see
>https://github.com/yiliu1765/qemu/commit/28b72d6b372555494d0e6a1ccfc97c8
>0bc34423a
>the full branch:
>https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_prq_wip/
>
>> For vEVENTQ we only
>>unregister when the last device is removed from the vIOMMU, typically via
>>device_del hot unplug.
>
>OK, this is different, register/unregister model is triggered in vcpu thre=
ad
>when guest send PASID table invalidation request in my scenario.
>
>>
>>Please let me know if you see a specific race case here that I may be
>>missing.
>
>Maybe this is a race case only in my scenario, I need to dig further.
>Thanks for your analysis.

Sorry for the noise, find root cause, this is indeed a race case only in my
scenario, because I need to delete fault_fd from polling fds in vcpu thread=
.

While aio_set_fd_handler() indeed wake up the main thread from poll(),
but there still could be a small window we call free_id(fault_id) before
poll() exit and release fault_id file reference.

I wrote below to make it work, in worst case I see free_id(fault_id) failed=
 once
and could succeed in second try.

--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -206,13 +206,20 @@ static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice =
*vtd_hiod,
                                   uint32_t fault_id, uint32_t fault_fd)
 {
     HostIOMMUDeviceIOMMUFD *idev =3D HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->h=
iod);
+    int ret, try_cnt =3D 5;

     if (!fault_id) {
         return;
     }

     close(fault_fd);
-    iommufd_backend_free_id(idev->iommufd, fault_id);
+
+    while(try_cnt--) {
+        ret =3D iommufd_backend_free_id(idev->iommufd, fault_id);
+        if (!ret || errno !=3D EBUSY ) {
+            break;
+        }
+    }
 }

BRs,
Zhenzhong

