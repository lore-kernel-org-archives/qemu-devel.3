Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE01C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 02:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucEbg-0003ER-FU; Wed, 16 Jul 2025 22:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucEbd-0003CF-Fa
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 22:44:21 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucEbS-0000lc-Fy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 22:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752720250; x=1784256250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gLyrh5Z0+mUnvGTEKFJUV80qDI9x1YxVe54Lwjvd9Eg=;
 b=jdyL39UutbYKUdlfNtHB5/DWyttA0PR7ns7NCacQRHhrPcs43ks/6jxl
 pFYMZ1/KiCdg36Os/SGAsgDIC3PGcHE97EjJ4S/nLZ0ntoMoU1AAKIitJ
 bZz/0sFs3OJZ+kUsjO434jpCrLn4EiURtTMEmBhwGjcHMSZCXg+pmYDy7
 8ZwXwELRVsmSBdnR06b6M6IrPQSH3ajVmzvJfpQHKBm57uEH6ymChFlMC
 62nK97smGucdHlQpYn08A8pV3Ipek+IdXYbswCP1kWE8iCSu8F03PwtsZ
 PKhPjnZw9ojv1beDiwkQREgo420hOXuQ8ZgfpVsyeV/jhf4Le3epLbxD1 Q==;
X-CSE-ConnectionGUID: hjBHdBtPT9qFW1KSqHZ4ow==
X-CSE-MsgGUID: NQmurrGnSdGmxKspWQuM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55131817"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="55131817"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 19:44:07 -0700
X-CSE-ConnectionGUID: NpU+EoKERiWQaXVmu9Z4SA==
X-CSE-MsgGUID: YQE8nU0sSDm8K3cfViP1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; d="scan'208";a="163300489"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 19:44:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 19:44:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 19:44:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 19:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy9JeV1AWktjxQUaTLuvuqrqbUPqldfRBCnzSMskSWo8XIN/TxjD00MvZBwNt2Vx4HICL27F4BsfZSaSKnF40qClfvVyhHPQhI9y/PfBXDGv9nsOsi+w3zA/mDwwjihew+kbz5WqwgaRPhpp/6idDexhqK5G6ZSdi0OfnaQuM/IgEg7a2kgntPztVSvoTu4+t1zmdBu+DFwsZOmjC4fkCld2ehRlD5K5cS541VNIqVKfDz0wLNQUNt3K1I5NY146vfmHwytvIw3VWPjiQnnA+9glOwwJOEVZbX9BV2C1M62CmnFtAZTC8AZpg+9Rr/FyzlBdXRZVyRfmdK5GhpdmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBaX+Z3T/b2FU0QypeHT4DImRqVvdrZSSnlXhnCWOhA=;
 b=EVs+fPRG8exkB03JGGj00wrn9HOTJwG8MYxrX9HprKLZyu2aiSW3fkSym8PFAQPPHDC/hVwYsHpNVxrN4LrbW9Hf1B6VvhSK82KXwO3KA2nkK3qvARvtK2QzHOi2ohFoxgRtFGZshKoqAml3xFPEylUIJhu5cfQaAc9oFh2kkPnh5J2G1PV0FW8Yb/gaxz8Z7N9H5iEFFutwi3jwDgWh2TtZqXsZIjTDedhSaut2ZOhNM973b30SuTCP/wuuKg9/OAXiogAHBvZW1HMiuyd8+hTEp1niF8yRzOK0em1Fwn2QIFZu3VwVgNCdxzXBraezLicWgvErfJ8q4Xy5t5Kp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Thu, 17 Jul
 2025 02:43:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 02:43:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Cedric Le Goater <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Topic: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Index: AQHb9nxa2lXNdDeN/UCbI5NjRCQA1LQ1mmWw
Date: Thu, 17 Jul 2025 02:43:50 +0000
Message-ID: <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB8097:EE_
x-ms-office365-filtering-correlation-id: 492c799a-6362-49b8-f534-08ddc4dbc33e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f++DOMqjK5L18r3BMswp3/WfC5BxqkGrsadm9cvQe4ytXvajaNNSPtndLVBF?=
 =?us-ascii?Q?qEab7OVsW9PFMVWP/6ogSj20uCa7PgaicNIfn1KZ+Bw/HB9wdomsYfrKJXGD?=
 =?us-ascii?Q?Us4D5Xwsgybhk+QyVZYOqF8BF6YduvVxXtMxn79jow1/GdhCdoe4+5OIXe8W?=
 =?us-ascii?Q?LKm4BGF5X1vZ6ywAC2BluOi5m6N1/pfKUuSP0bDraEImylhfQiT+qCVdPATt?=
 =?us-ascii?Q?sIUnvAMFOcEHLHXsVBXttzUiGnU2vvvtKNBf60xcqBCrGMHfOgeXtHzCgGK1?=
 =?us-ascii?Q?OBuX0q++BddrcHfXz9ak+r2c9njE9da0gRRgduCctE0/moQcYAKE1kxdbPZX?=
 =?us-ascii?Q?NUZa34sf3WxXNgktw4tSs2YHnuICHWkej3pYOzaIwmPhLMUdRVmobQXWZjUB?=
 =?us-ascii?Q?hqCWwg2TnHRM/3toGsvdvmwOVXKm5PB//xbuaXshE6xoaNjBOTUsmld/wQwU?=
 =?us-ascii?Q?l67ZuSuNlYGY7jrbwgt9HXwLmoDXKFw+PrDWulyCOAA+TthtrdRBvsINfmcj?=
 =?us-ascii?Q?Q7+Y7NsJUUDqt+OL/CBvHH0a6h0gzLV6cNqJlkSW5iMIiLjwspVRKh46r8Oj?=
 =?us-ascii?Q?R8ClyltlRaqsNECLmUbE1w3Y6u6UhmR6zK3KBNrcJTQPR/garn0h8tfdJ3oE?=
 =?us-ascii?Q?zf288iKSqcP9uboKmdEM5CgyBrzsNESQ2GMyz/UZWN8J4+GGYkJz21VdWcjH?=
 =?us-ascii?Q?uFdujNmr+HZuxFAi+m42MNrMPXbK4LtT1cagDjXPxpP7NEE/Y7bHoG/rkJ2+?=
 =?us-ascii?Q?FFA5OacC/BW+7F9UxdqGI9cXWRCWndPZEOMvW7/sVepMiXobJc3j1yaV8OQF?=
 =?us-ascii?Q?HhJyLQWj6Wjhl6otSbgjUNcR/x1AfYufL+K+x+z8evlB3bc68sc/YqhbJm+U?=
 =?us-ascii?Q?K0DIVhoacRO07CYlCEn3IbCDcwQhyucApdev3uGwdYHkykaxW4aERlgAkP7P?=
 =?us-ascii?Q?AlrQ5qXQneOiEGh7tFS+nKRJB6e6/Y5sovKm+HcrziqYtDsb1PTURV4QZ1yG?=
 =?us-ascii?Q?clOCT9NjgBgWB90ltKj0QKpToD/84zPzpjfljFCFPAbLesYmDZmjXFyqRlHl?=
 =?us-ascii?Q?zPbx7qxbKqox0YwYkc0/umdDsI4UR4TfIwu0Ti3xVWYbNf/p2GKkh9yl6utj?=
 =?us-ascii?Q?jtCs0zSQ5W2Yf5BtCmn40qxWCEw/RHLeIvEZpQnc86FbTLUFpFqhBSbsOTC2?=
 =?us-ascii?Q?xYvxuxEdE16yST3X+nHapa0ChPs2vjthB6z2SiMOvCHGtvssROA3SIH/Ax4F?=
 =?us-ascii?Q?s5w8oN4jIozDUOEwNEIn9zELE3lZkTI2xYb+L/BxU/TDTlJyNFZvopJUuTKW?=
 =?us-ascii?Q?Q4zUU2pxLo44u7VsvKI+zofnTPsk2rLe0Kgv7en7wCexqjfxY1WkJV6KXS/A?=
 =?us-ascii?Q?ReIaMnxhl/rWIqYqJM2qYIc+wGD3zKObS2ue4E0y0UYjn0/QxzOqDaNb93dD?=
 =?us-ascii?Q?E1jurAl3VU2TesvvssyN/Oz4S9aCNPWUlb1M0N2rBnc+h0k5ZnpJRw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qREzMc8zKErJGiFR35TRmaqxo8ivg43yz/AbEQ2rviHjaayDpewDkChAKRAB?=
 =?us-ascii?Q?Fhev55yuE+MMQdN5mkJD2+avZViguLJu+HTEJNyBpq2Z42P9QBzHKH43JEOD?=
 =?us-ascii?Q?7jEV/6t+LCsmWYFT+K/Xp3kHvnGuBa1e67KlrNEUMYxQgK81GLkvWeufnnzX?=
 =?us-ascii?Q?XbqVNkXfXW4thyBpJyg8obRduO0zcDdTRfRVjFsNNKYaD7BJpvMZaeLlToWF?=
 =?us-ascii?Q?iMtwnB4RgAxQONZEBokdMOn6wSo4JS5u2zs5mXLNUsrOs5SAu5u7OzcLBVe5?=
 =?us-ascii?Q?QcUnr3rfPSY7wg3NV+jYaEHXucCshjBYOQDcUf90CjaEh+yXbSkaxuPy/WGH?=
 =?us-ascii?Q?OSzlgOHR5aPI5CTaIgKNMHc15DpAnJfVjsxFtL3uzmXMXKOo+TcwrUisUYCc?=
 =?us-ascii?Q?192cLgaO1FmvI3P27PiPeZZgVk8XkWTL9VHCwOBRGC8M/Yq0PjG5li4Qk0MW?=
 =?us-ascii?Q?3IYaKLXytT4kT/cvPh9npax68cjYmOkGMsKN+cWygTmPB7NnEfJ06tMVgSo+?=
 =?us-ascii?Q?4JmDkTOCF8yKO+Z+Ffq/ax7k/qTmXUdR7CT8DL80JMQzd9IdO53OEohhZXLq?=
 =?us-ascii?Q?sXbOb5yFFQ/3Mxk1KwTrF51Ge/bNQZirobL2XP+p7hx6qoB7Mmx7Y4Qgn5Iy?=
 =?us-ascii?Q?FjKQQsrtJ4+H5e/vsqHJEJMDqs8PR/TRWNl9is2OvK7SIJABU7p1UfhqYcvz?=
 =?us-ascii?Q?Fjym3ALbWGaekSw+s1OlJ7i5fH2getRB5rckKAMtt9Dzla0OtX5rEb/QKEv0?=
 =?us-ascii?Q?46/W3NyyuA61XDPt7eVDM8/v2S0ilZVm7DXr1O/B3Gi+hWo9pLs9N/Lf418E?=
 =?us-ascii?Q?vu4VaVIeaWitHchWY22Cc1YvF6tW/VDaueHAjHasQjOSpQgGcuNTsEw9XvD/?=
 =?us-ascii?Q?f1Z6oeoQjKjpEjNC6i0bdfDj/rZSUAbm82lfw7nSRCEjkCh4V8YBRCXVSPK1?=
 =?us-ascii?Q?m1wY9EL/Z8sQo7tWEtM1TfCzVfu5J9C6pRSs5v1g/U/0naf5OaowtDo8lOpB?=
 =?us-ascii?Q?eghPk7ZJkJtrkXhbRJ1I028s12ntbNmnckZFw5j7H/W7wFn6V1blhOkjGCgT?=
 =?us-ascii?Q?jqCo8okV7uxmqVn483sEgDOHz3fiSZqhEK8V4pWpEsRhi0MBz1OA0qUYAQI+?=
 =?us-ascii?Q?Wcx0roT4RJZbIRC+Xy1uYn5UnmNtaXy3o5IVi/DbY4EXxxsTOcr5c+p3LNRg?=
 =?us-ascii?Q?8epTaZAx+RVemipTaHVgmaU/gDlX9BiabgluFzavo4dzlYKTu7ES4HgDZiea?=
 =?us-ascii?Q?pOw5dJ3Hc5J/ffmgrgBYHOXaC/DbOI/sUOAOdDV5EmHv9FHAG1lo56uW3uf3?=
 =?us-ascii?Q?Tu6WofeHpgBvReoLMbgF3daSI/uku64ArxTROgDgVmAcoZ7VR2pJmouK4IZq?=
 =?us-ascii?Q?G2vk2uq7ftImBeodKBE3RHVaUpvdgQKsaaFa5IC5fUId8a2dxPwMf9EQZOBW?=
 =?us-ascii?Q?TsEjnxKHbTq8vnAnWd4rWJZwZKryNMSgUi6tlMAilZkvWOhw4pKIUiFO6ci/?=
 =?us-ascii?Q?hfa64oJkLgwpnkTrucmPVyzdbrMJ30QwS5HPp2pqPTcS3abtKZ8maARAcrzN?=
 =?us-ascii?Q?aAuKM9RDEp6L2zu05ShnGKph2xpFjrkbj9ZD+qMB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492c799a-6362-49b8-f534-08ddc4dbc33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 02:43:50.8505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVExwG+xSKkEpEVubsk8KoL+RrN4OcwSpVLntfz9Rtidk1H0UXxqGURd8PG+mMBVHdOLc+kY7duwd/6iPUpy73Cv4iFTJov9IwZpZba/Y4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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



>-----Original Message-----
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>
>cpr-transfer may lose a VFIO interrupt because the KVM instance is
>destroyed and recreated.  If an interrupt arrives in the middle, it is
>dropped.  To fix, stop pending new interrupts during cpr save, and pick
>up the pieces.  In more detail:
>
>Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD
>to
>deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM=
.
>After this call, interrupts fall back to the kernel vfio_msihandler, which
>writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>eventfd.  When the route is re-established in new QEMU, the kernel tests
>the eventfd and injects an interrupt to KVM if necessary.

With this patch, producer is detached from the kvm consumer, do we still ne=
ed to close kvm fd on source QEMU?

Zhenzhong

>
>Deassign INTx in a similar manner.  For both MSI and INTx, remove the
>eventfd handler so old QEMU does not consume an event.
>
>If an interrupt was already pended to KVM prior to the completion of
>kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
>subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
>state to userland prior to saving it in vmstate.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr.c              | 91
>++++++++++++++++++++++++++++++++++++++
> hw/vfio/pci.c              |  2 +
> hw/vfio/pci.h              |  1 +
> include/hw/vfio/vfio-cpr.h |  6 +++
> 4 files changed, 100 insertions(+)
>
>diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>index 2a244fc4b6..bca74ea20a 100644
>--- a/hw/vfio/cpr.c
>+++ b/hw/vfio/cpr.c
>@@ -198,3 +198,94 @@ void vfio_cpr_add_kvm_notifier(void)
>                                     MIG_MODE_CPR_TRANSFER);
>     }
> }
>+
>+static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>+                                  EventNotifier *rn, int virq, bool
>enable)
>+{
>+    if (enable) {
>+        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
>+    } else {
>+        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
>+    }
>+}
>+
>+static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool
>enable)
>+{
>+    const char *op =3D (enable ? "enable" : "disable");
>+    PCIDevice *pdev =3D &vdev->pdev;
>+    int i, nr_vectors, ret =3D 0;
>+
>+    if (msix_enabled(pdev)) {
>+        nr_vectors =3D vdev->msix->entries;
>+
>+    } else if (msi_enabled(pdev)) {
>+        nr_vectors =3D msi_nr_vectors_allocated(pdev);
>+
>+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>+        ret =3D set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>+                                     &vdev->intx.unmask,
>vdev->intx.route.irq,
>+                                     enable);
>+        if (ret) {
>+            error_setg_errno(errp, -ret, "failed to %s INTx irq %d",
>+                             op, vdev->intx.route.irq);
>+            return ret;
>+        }
>+        vfio_pci_intx_set_handler(vdev, enable);
>+        return ret;
>+
>+    } else {
>+        return 0;
>+    }
>+
>+    for (i =3D 0; i < nr_vectors; i++) {
>+        VFIOMSIVector *vector =3D &vdev->msi_vectors[i];
>+        if (vector->use) {
>+            ret =3D set_irqfd_notifier_gsi(kvm_state,
>&vector->kvm_interrupt,
>+                                         NULL, vector->virq,
>enable);
>+            if (ret) {
>+                error_setg_errno(errp, -ret,
>+                                 "failed to %s msi vector %d
>virq %d",
>+                                 op, i, vector->virq);
>+                return ret;
>+            }
>+            vfio_pci_msi_set_handler(vdev, i, enable);
>+        }
>+    }
>+
>+    return ret;
>+}
>+
>+/*
>+ * When CPR starts, detach IRQs from the VFIO device so future interrupts
>+ * are posted to kvm_interrupt, which is preserved in new QEMU.
>Interrupts
>+ * that were already posted to the old KVM instance, but not delivered to=
 the
>+ * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM
>instance
>+ * in new QEMU.
>+ *
>+ * If CPR fails, reattach the IRQs.
>+ */
>+static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>+                                 MigrationEvent *e, Error **errp)
>+{
>+    VFIOPCIDevice *vdev =3D
>+        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
>+
>+    if (e->type =3D=3D MIG_EVENT_PRECOPY_SETUP) {
>+        return vfio_cpr_set_msi_virq(vdev, errp, false);
>+    } else if (e->type =3D=3D MIG_EVENT_PRECOPY_FAILED) {
>+        return vfio_cpr_set_msi_virq(vdev, errp, true);
>+    }
>+    return 0;
>+}
>+
>+void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>+{
>+    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
>+                                vfio_cpr_pci_notifier,
>+                                MIG_MODE_CPR_TRANSFER);
>+}
>+
>+void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
>+{
>+    migration_remove_notifier(&vdev->cpr.transfer_notifier);
>+}
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index 8b471c054a..22a4125131 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -2993,6 +2993,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
> {
>     vfio_display_finalize(vdev);
>     vfio_bars_finalize(vdev);
>+    vfio_cpr_pci_unregister_device(vdev);
>     g_free(vdev->emulated_config_bits);
>     g_free(vdev->rom);
>     /*
>@@ -3442,6 +3443,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error
>**errp)
>     vfio_pci_register_err_notifier(vdev);
>     vfio_pci_register_req_notifier(vdev);
>     vfio_setup_resetfn_quirk(vdev);
>+    vfio_cpr_pci_register_device(vdev);
>
>     return;
>
>diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>index 80c8fcfa07..7989b94eb3 100644
>--- a/hw/vfio/pci.h
>+++ b/hw/vfio/pci.h
>@@ -194,6 +194,7 @@ struct VFIOPCIDevice {
>     bool skip_vsc_check;
>     VFIODisplay *dpy;
>     Notifier irqchip_change_notifier;
>+    VFIOPCICPR cpr;
> };
>
> /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot
>match hw */
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 80ad20d216..d37daffbc5 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
>     uint32_t ioas_id;
> } VFIODeviceCPR;
>
>+typedef struct VFIOPCICPR {
>+    NotifierWithReturn transfer_notifier;
>+} VFIOPCICPR;
>+
> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>                                         Error **errp);
> void vfio_legacy_cpr_unregister_container(struct VFIOContainer
>*container);
>@@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
> extern const VMStateDescription vmstate_cpr_vfio_devices;
>
> void vfio_cpr_add_kvm_notifier(void);
>+void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
>+void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
>
> #endif /* HW_VFIO_VFIO_CPR_H */
>--
>2.39.3


