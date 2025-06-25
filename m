Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF4C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOUN-00050H-JK; Wed, 25 Jun 2025 07:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUH-0004zi-Hr
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUE-0000OA-71
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851618; x=1782387618;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mDbF64GvnsvxTtaOAUx/GD/nchfeL4MbsaLpNMT/bjk=;
 b=etf1EwOOChKu1xUWyEV+A7gjFrWCjHY7XanwXalG68piTr7wAfjNsP8e
 9XZoRdI9cYUAsaycIjgT1Ejxir9HAdAiL3R/d5dAfKc9VqNBKyRZL3K/E
 aWWWdok6TQv2LPKLJkRTa9AUt8jGrmdFP0/H3PGyvT4ax4pu6Rd9tSgTg
 MntOs24KMFRmMPrk8s7a24sYucl0D64kDvC8/3an+h5SDmP38D/sL0XJw
 f0yYemUIJSSRbmjk2ycXUrgNV21friGW1WwAD++EBcLCjmmi4/ZmMgwdQ
 njaHHZPSqNLed+8sEhB3898OLpWkk/lbJ6TZRMC8o19CGT9VPG7WMJxU9 g==;
X-CSE-ConnectionGUID: 1oOj0AFzSku2cq2pQd+jPQ==
X-CSE-MsgGUID: 3HdxKisgThe8OiR4U3NIVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64473559"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="64473559"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:10 -0700
X-CSE-ConnectionGUID: FK/FBZbkTeSELy9UcyELdw==
X-CSE-MsgGUID: cwr+C2ZfTOmeoktKTdDIWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="183228795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFolmGB1/qpL5Hw5LYm21t0Oxc75NoIt50NzofH9r+J/oHqkLS6TMrZnO4wvRGpcyCRnBDQSkkYK2h6c2hEJmI+Yj6ItqSWxTMJ02LA0LdcvqW4k40XCB6nn64h8hwd+/RgKiIv32ieZmon4cvjcYpl/BSiJaSEmwHwwJ6zY4PM821vd40sSPOVxRQ0sLezWRiG0Uba39C6yBJriYcm7FatByal3hyeFAXA2u+ThxJME0v57V6z9fIpAQt6fGKQqOpLcjar1DYqBS226SX4qBKOLZP7sSx7CX23pItqbCDbMk5yVPeZv8s4MLANNUHe5y4iOas46QFtzi7FIFlRxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVtFi8sc7dSMtxaJYC8yzshAgpxHou4/aNvsBQE+QOI=;
 b=H4oqKvPW43iTU1XWd68MSkFpHbg4qMZAf6m2/JohbBs45s/5rRfIKMRcIjI0V6lUh0NDq/+UtfDCbX6FBMYgJYtiZqWsoeHjdSggHgXkOlCFx/hc1UP9NEsA1uaTLBnu7GPsmPh0hTACgjd+6H6QRTivksCnygMXxUzN7/tZ0WBDL1MAqDc+ECqfVtkjhwBT9nLACLQhuHcAeoYJX9y2JI73A4sp6tyVRRhW0rLshdwRwcEigi91J2KsPZ0DWWD6ApFLAGMbv7LLtP+rnu7xEcNW7lRiu1k4DL5KbMk8BogMO7Tjg4FtedhFCnotVTlr9tPh5ygP3Bo88JYd/F++bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 33/38] vfio/iommufd: reconstruct device
Thread-Topic: [PATCH V5 33/38] vfio/iommufd: reconstruct device
Thread-Index: AQHb2h4PHaQmHFB+HE2ywKFDGxvAY7QT0yUw
Date: Wed, 25 Jun 2025 11:40:01 +0000
Message-ID: <IA3PR11MB9136ED60B695DC51D2C4C3E1927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-34-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-34-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: b61e288c-5e37-4244-ea74-08ddb3dd056d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?npHVepwgBfhFGCr8ifbMjcVO67+9Hi+vkjGM8qF/K8PTacFpVSVsKcRHQNqE?=
 =?us-ascii?Q?6hFazgvIvm384FC8uydCQmZCrg5/gkhjhLwrtJdj8bIJUkBEICH3rqtRLmeq?=
 =?us-ascii?Q?j5LRzjud2C/efwH69sOaxES28vQgbNtJ9yz0npH0ZKXoJOK4LQcDcB/4Gn7x?=
 =?us-ascii?Q?kWeI1Kgpa/mtZWbpFgvA5b1so02OhV/LiB/k6parHLVpkUn44LLNpl4AeQZM?=
 =?us-ascii?Q?gk4ffGQ4DxDooeSs9Juj41GtrSDtQfYWiXSPG6El+iAXvJGWTp1OgSveav++?=
 =?us-ascii?Q?5f2JSfnYqhp6ve5IXsUbuXXa1LEqFa69coq4juBHDFcJ5oIr2RiDXSijzrJ7?=
 =?us-ascii?Q?tDOeNX221IcWnZrLCf/nenLjoAKTT+9E6Epvur+i6U4cqW7e8SeSjmqSPAdI?=
 =?us-ascii?Q?jOGcUJ/WvU6eq1GclGoplW9uLuyggzUTfpARFovZ+o+szVzXWiOoziPugTLf?=
 =?us-ascii?Q?fNYMJoENYANl+SdhJ/Y4WEFQvTQiTuTiN8kWOjrm8VME7rHBrc16kkNA1YbS?=
 =?us-ascii?Q?rgsZOl3NmpaOUoHpFzO4uT27/MAp0Br18ZaJ1KNBTE0ERuckf09MaxtC3Glz?=
 =?us-ascii?Q?qPRGtrG5buTKXIeq/QqFHosyYnpQ5ySlHVW+pFxZUi0Bw+rAGb+fED8XOcJh?=
 =?us-ascii?Q?4yM2ZwlNTp317FptTQYXnNKpgYicBrDRH0ZkANxHDWuhV1fTJfvwU/5EIOuI?=
 =?us-ascii?Q?OI5VWtP+oCcs+85iVegBpF+fX0iAdEfmDafJvP0UeGfdkWO1MRgckyv7fQVW?=
 =?us-ascii?Q?q4bOewgi5hHrhVgRSMqWoUADNofAiLfLlMTTBm4h05VZqmQoMso8l+yBuFrJ?=
 =?us-ascii?Q?6yLFzHTBIg2g8gghSusJ0bE0SgbhqQ+0pyI1iRK8aNSYEmwrE/Xkomflbjsu?=
 =?us-ascii?Q?EFGtOV71BQyCa2Qw1+dmWCE0MF+xPF0kudD6PYSxVFCKJzFegolDlsO7JgB1?=
 =?us-ascii?Q?QLGWNsYVHK2AJbDJ2ozFwjKfuY1NApJEP6M/Qca0PltS4B/NRQV+cGDT7oFi?=
 =?us-ascii?Q?YhZrpwPzNJ6RHkKOojMn4kgnJVBI9TBJcH3+8v3UrmUfuURjGBFRqfacmqbP?=
 =?us-ascii?Q?dFJqwJRSJ58WBmEuKt/XhWwB1WvV6MN6Kj1SoWvPjcsix8OYupOkeE04jgr5?=
 =?us-ascii?Q?i0nJsXykI1+b6YtAblXNUdw+ZjSbYsUf1khqKa4EcB+hoElN0nDdGqKzb1p1?=
 =?us-ascii?Q?Ke/5vjfM9raFRhYKUJnJm/dmOocXwaXKqqNZRyB42RHdiDJeEvtjIlHVwUK2?=
 =?us-ascii?Q?D3hW4r4k3FFPYcEQjXQFVjO9/J+XoFTfgOWu6Y7dmBJh2puL+OU321crOT0f?=
 =?us-ascii?Q?/gwPrudskp2qUwhvJPbmRgaDLUnu+hfvmwgJZl3gwKvcnXLNTJnkAb6NI5sn?=
 =?us-ascii?Q?8IoVtd2mOxYVcoIr323d9JebJrkJ5GFN22iYqiVQ+xmY+YK6yqdm+hBMAUUG?=
 =?us-ascii?Q?2qzJgSQNYgldBMgSQjXZ+8gd7+2bILS3St0QvTfGLGh1uAiA+ZGDFbfhYIi8?=
 =?us-ascii?Q?UkUxK8hHgRr03S4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6h/BjaWSnb61MfdXo2DHBcCyTMB95vS3LEHkLQhWvw3tQ1DNGnjWBnAyD/XQ?=
 =?us-ascii?Q?PUfjZfaGT3YSh5djl2r64bC2GiNHQc1eQF7FGf7NT94itCTO90uSwhfj+W5D?=
 =?us-ascii?Q?7BQCseMAFpxVLEicGadhO2M22viFDrdWSLYEiU5nVeXrGhr1bOSFBV9FQ3Kl?=
 =?us-ascii?Q?yoNKBhXPLZc9jntmFFdKnpcaG8ZqQPc5Tl7b/PU8c4awBQGMq8CsVa0g0NCK?=
 =?us-ascii?Q?9UXgfb028T5hxBJkZKsHQ0xAqOlrwmEbrGrZst8hQoWkeYDrn7A3dvS5a2/F?=
 =?us-ascii?Q?sFnNXERZLJoqRaeKfx+XDsMf/E8J3Vh8mB1YFUTPQdZjqjAR6Xw/rIzzEduN?=
 =?us-ascii?Q?pPKSvxZB0lUO4AD7X5Zxcfsa24nmCV1ZpmYTz69LK/ZQChsS1dyb4t+zLwHz?=
 =?us-ascii?Q?oHv8jzqjHbg7nw+s6+rmwNSn6Bqz0sFXJY0yweAAtw1iDZJPxpTcj129sS6B?=
 =?us-ascii?Q?NaHzcYFgS5ZXVykz/rH2xSbOMriPX2Zd+RvQ27e4Jg8LcmMFWOqfaZqekpUJ?=
 =?us-ascii?Q?WJfZpaYXYhI3P/G9rmhJB/lroZZiHxwQpiNmLzrQ7iY2k3Ss/QksIGNn7ASz?=
 =?us-ascii?Q?AQhANQ+2GNfict5WOt2SAPukIq7lThI16tIYJ4aI+SrYDGLo8/VNNdXtPV5o?=
 =?us-ascii?Q?05/jkDiCs9ML8IVmAK91hoCFzY767+ubfaR8jZ6uDCBsG1oqqhr8VhOkLzEs?=
 =?us-ascii?Q?1p4SmrBdjrJqCNBm2llGmP0T2+UGIgya9+hrKFOJfvIGi/NDa/YEuIw/pAGL?=
 =?us-ascii?Q?mKMINwidkJGicK1ByYDC/SwBYm1TdfVVO6yjv78bNYu8HQMmAi26r8zC3b/0?=
 =?us-ascii?Q?IP90ANPHfzchxNSpI97OKLKaxgevLWnIHP6vpvzdmHsCROyGQn379cVoO3Kd?=
 =?us-ascii?Q?A3g5xnoDgcfpBxoKit0/PaHDdBjT0AOpYiENuaXC1nMyciDfsj0Il8WYnJn1?=
 =?us-ascii?Q?aFkmGhgs4OvfQgbBQKwI54lBK3ZLSpvjtPGdxL0zvgTiB/Qi8WyGny0WyZw1?=
 =?us-ascii?Q?+gu+WZUehm56rCmMkq304ca0R69XpzQzKWBYY/s6FjRKigI72CxY4KunxH16?=
 =?us-ascii?Q?8x1ESzYydvINCS5mYYWA0KbJwQmTaoP2loAvlWv4hSMAsgxRlrbJ+uqs4QYc?=
 =?us-ascii?Q?rQN+0bFezi1nlis1pbYdBD/wvvatN/g8h0r0qPhdh7uxjzjWqQ/mQSsaO2J0?=
 =?us-ascii?Q?rmu0vI7i4MbTsvoRXtd0pFkMoTJHfA/7La+f5eOYRXUf567h3tiBVhvma78e?=
 =?us-ascii?Q?qqgpt/R7SNajzneX4Trf5hscYGvFYFA/dbh7FqGEHM3AFE6W4HSvT7WEa1U6?=
 =?us-ascii?Q?v9sB5DufgaaN/3AptlZGARIui4MhEIXJ4fy5wS0oKCrSLTwSwIp3ViQu1vT+?=
 =?us-ascii?Q?ObpnIPQ8ULG5JIJiyU6GJZLGc6tfMQPmA/ew5tkJ+3KipgzZZFm4CpZIhVXw?=
 =?us-ascii?Q?+bxUyoVpcbPwufIKjgYAp8sXZlaSu84QBi83Qd0yce4FlCqJ2nMt/csG9gkU?=
 =?us-ascii?Q?cKkFLCMQxbZitIlTP26aU6mL+MQW0RWhwBgkDIqrWF/UG3bu+fGwnqU1ppCn?=
 =?us-ascii?Q?dfuCNbq34AtE7uICh9efqnFCvj1OOEPdWF5kZA1z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61e288c-5e37-4244-ea74-08ddb3dd056d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:01.6363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlNRl3C8IyychECSC/GkPSOM+ozq+GjvntsqlYLu9T68S6QTueqaRZs48DynuFACh3+e3eLznHgCsZAYvSSaiBay8slThqv5OuORrs0y7QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
>Subject: [PATCH V5 33/38] vfio/iommufd: reconstruct device
>
>Reconstruct userland device state after CPR.  During vfio_realize, skip al=
l
>ioctls that configure the device, as it was already configured in old QEMU=
.
>
>Skip bind, and use the devid from CPR state.
>
>Skip allocation of, and attachment to, ioas_id.  Recover ioas_id from CPR
>state, and use it to find a matching container, if any, before creating a
>new one.
>
>This reconstruction is not complete.  hwpt_id is handled in a subsequent
>patch.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/iommufd.c | 30 ++++++++++++++++++++++++++++--
> 1 file changed, 28 insertions(+), 2 deletions(-)
>
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index f0d57ea..a650517 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -25,6 +25,7 @@
> #include "system/reset.h"
> #include "qemu/cutils.h"
> #include "qemu/chardev_open.h"
>+#include "migration/cpr.h"
> #include "pci.h"
> #include "vfio-iommufd.h"
> #include "vfio-helpers.h"
>@@ -121,6 +122,10 @@ static bool
>iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>         goto err_kvm_device_add;
>     }
>
>+    if (cpr_is_incoming()) {
>+        goto skip_bind;
>+    }
>+
>     /* Bind device to iommufd */
>     bind.iommufd =3D iommufd->fd;
>     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>@@ -132,6 +137,8 @@ static bool
>iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>     vbasedev->devid =3D bind.out_devid;
>     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>                                         vbasedev->fd, vbasedev->devid);
>+
>+skip_bind:

I'm not sure if we should take above trace for CPR..

>     return true;
> err_bind:
>     iommufd_cdev_kvm_device_del(vbasedev);
>@@ -421,7 +428,9 @@ static bool iommufd_cdev_attach_container(VFIODevice
>*vbasedev,
>         return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>     }
>
>-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, e=
rrp);
>+    /* If CPR, we are already attached to ioas_id. */
>+    return cpr_is_incoming() ||
>+           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, e=
rrp);
> }
>
> static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>@@ -510,6 +519,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     VFIOAddressSpace *space;
>     struct vfio_device_info dev_info =3D { .argsz =3D sizeof(dev_info) };
>     int ret, devfd;
>+    bool res;
>     uint32_t ioas_id;
>     Error *err =3D NULL;
>     const VFIOIOMMUClass *iommufd_vioc =3D
>@@ -540,7 +550,16 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>             vbasedev->iommufd !=3D container->be) {
>             continue;
>         }
>-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>+
>+        if (!cpr_is_incoming()) {
>+            res =3D iommufd_cdev_attach_container(vbasedev, container, &e=
rr);
>+        } else if (vbasedev->cpr.ioas_id =3D=3D container->ioas_id) {
>+            res =3D true;
>+        } else {
>+            continue;
>+        }
>+
>+        if (!res) {
>             const char *msg =3D error_get_pretty(err);
>
>             trace_iommufd_cdev_fail_attach_existing_container(msg);
>@@ -557,6 +576,11 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>         }
>     }
>
>+    if (cpr_is_incoming()) {
>+        ioas_id =3D vbasedev->cpr.ioas_id;
>+        goto skip_ioas_alloc;
>+    }
>+
>     /* Need to allocate a new dedicated container */
>     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>         goto err_alloc_ioas;
>@@ -564,10 +588,12 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>
>     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>
>+skip_ioas_alloc:

Same here, others look good.

>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>     QLIST_INIT(&container->hwpt_list);
>+    vbasedev->cpr.ioas_id =3D ioas_id;
>
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>--
>1.8.3.1


