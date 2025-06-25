Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67233C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOUp-00052f-Iq; Wed, 25 Jun 2025 07:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUX-00051I-Pr
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:39 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUQ-0000Tb-Gg
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851630; x=1782387630;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xKudrgFCT8Fr+V1PE8J+OhjUEu5bGwmOepg06yvkyeU=;
 b=OMuN0frE2r8uy7nqaveNhzms5tisDhvUSs/5duzyktCpxtcviwdsiZVS
 F518YSrGrTvWPkmYjlOUCDbAShqpeyHEAtk2O3oLb0OdjVKoHiOmkhrBc
 vxBFENDQUX0dxWGjZqwXmJF8SHEf5S9PUNWn5VIX0AXWt4IQMr8QB+Vh0
 nL4yhDlslcvnEKGVwopGv4CWKjof6gtiyAKlmqa38dc/cVLHMoitA8320
 zYsvFHRggVpTNln84pGipU/NoWU9EH/xV7GRT4UJ88kIMJI9gdHNA5GvC
 GLHnmXVnMdzFqaWg9znnSMc2ZYFIfLj7jCzvhZf8s2JHJhBKyYo2cOa3j w==;
X-CSE-ConnectionGUID: cExIO+zwTmWaeGdxbs6+qw==
X-CSE-MsgGUID: 07PeLTxRRFCF0gcnBT+gbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64473628"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="64473628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:29 -0700
X-CSE-ConnectionGUID: buBQiMOhQpK8sYFZu1Qm4Q==
X-CSE-MsgGUID: ZjNd+8TOTp+PgxDRtSf8rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="183228883"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nuf4fra8BCi5M4Y7rykzpcQKgTp9s/VRYARvSyL/3RDbOFz3YJVv7VqK74Dz9Ht7KKMjw4DClo6q4MDYQog9Gqi8GV0FXxHcWt4TpIZb9H/xPBAcoM/tz7WOaWByJ3JztPPfvgBA39VjVyPhFlqdnsqO5nCzyM7slzismalc04qvE7C11RCmzAKMCFP1Hj07Y61nmbgQcNgxO85uccWrgrYV7hQNlnYrezggNy9Z/+cLZdtXE2ollUjJqDe1nZXK1tblo90QReyRK33hEZD7WQBziCR/BhgrxCkWoPajxFG8NVwuQY7KGe8A+rM1U5O6hPMRsaX6OtT6iZKj68C6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=263nzAzeo8F7YJ8ZuO2AyA0Z8aC6RQEVFT4r/M8LtzE=;
 b=cm8DOdEOh+XlMBold73O4D7uo4E+DSgjllGTvMOXzAylNrn1TDwc41vmUjEHBbiHmUbHkbV9TcDLjXo9LGgfSM3Pqg0Gw9rJgAJ8xSzIrfRd1aWb+ujK8ZZrJzYrl8kQaXaDGGi3kYMpVkgk1EQU9JOJMW3Dsun1Q+/9XnXEJpQw7nA8sxLyK8ee6r45WhxKyjIk34kOSk6+31Q60hKphQSCFSehE5xtl5hGtrjtTBqUOiWF1h1CjQVgay+cjLG1IolyjIJ6bTX0pmwXjYsabWEQsxR9+WF2cxueQiG1znc5SHsnRo5rrh14G7jGudEQKNL7o0fTFCVkG1FvFRNBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 34/38] vfio/iommufd: reconstruct hwpt
Thread-Topic: [PATCH V5 34/38] vfio/iommufd: reconstruct hwpt
Thread-Index: AQHb2h4eL0oTv7/TEEyTdY1V60qOjLQT08Lg
Date: Wed, 25 Jun 2025 11:40:21 +0000
Message-ID: <IA3PR11MB91361EC1F78D5F6BCEA048BA927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-35-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-35-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: 7ffb8c44-a277-4cab-a0c4-08ddb3dd10f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yd0fnxRqQIQIaEwBv7QtTMZzwa0l4DaU8iWVhRV4H4ux5AKkBJxZ2+J7YVV/?=
 =?us-ascii?Q?uKIPrevtK0bJXZc1YNXi2YTn/zEhkaK+ycbKQULBM2T1lLRTc0c8A0sJy/ig?=
 =?us-ascii?Q?0pywUVdfc5L49c4w1SbSmZTHMPZ411zwYZ2G5eEvSH6xFvfksEtshq6tVOXJ?=
 =?us-ascii?Q?HsQJ9TaJMIyd/RSNw0Ey3zDaUZX7Zf08HZI8dh8UcPxqIY9MIobTHIYUAZfE?=
 =?us-ascii?Q?6+TZ1y7T34fu8/Vz5ypzhCJcbKDz6XVyw1Mv7Bg/Bsmoblv4NxzR8scAtkUu?=
 =?us-ascii?Q?goDwmdWz0feescT3iu6xoNLhXmkBejILBWcb+7MvsNJuTgIJBhqPLm8/KZ40?=
 =?us-ascii?Q?q71xV78Et3fVlFCNBd2ts6Q0EbeL6slY+RtU8I1HNifOit8abwzgge1TixXo?=
 =?us-ascii?Q?Kir14BLqCC5qcChdU9tYdTvv9+avx8Br+yxChqhqf4vG/v1SoRA3ql2RyO+E?=
 =?us-ascii?Q?ZrdEO6DkR59IDCIaKpJYD5URaMr44lGYxlUAVIBOdTmXXmmB1zRlb65TKjK0?=
 =?us-ascii?Q?gbi3GHKipUInFHfXqDLgSPZkrpVXC6CkKAT+wNxzbVRSUPAAm/HjTwqSrBFd?=
 =?us-ascii?Q?t6UhNLaAdINAu0ctEdXKXJzAmqwertpbZi7Q2skG5bbzQV8VwJoxWTN+u35i?=
 =?us-ascii?Q?qlvvc3k7Gi66MHMvSeVWD1TU63msscmW61CGQIm+wABohdCdccYOn6dLo+k7?=
 =?us-ascii?Q?raNaaBqoSd25FF5CGXg8UIvYLPvFZLPGbTd+9VgQ+4iaYc/MA0nwPSp5yZVs?=
 =?us-ascii?Q?Z/W63rchTND+xk3q00B9Of/1saEwaR5bmuA4crRQEQcwWLs314VzP89/4ZLe?=
 =?us-ascii?Q?ATn9ecV+yI24uosYrXI7B82gPjZIqH2Jic7621ynCKO/l0bOQvI05+b+Icyh?=
 =?us-ascii?Q?Gj6vDFJO3+fzlYgoSbRwr4xZ7SXcB8m0wVD681SPEfqorR5V2Mio7WVtLCFl?=
 =?us-ascii?Q?0klCgC/j7KYEKyeL0no7n2fPgpkQC3P80WJyk6c5ysBX2Id0tEu1XUmQleBI?=
 =?us-ascii?Q?sacT0sNnWP5TDHmdBa3ETjr4H3khLh3hAvA96I814VzYG7PgVUHXSdBYPobt?=
 =?us-ascii?Q?JlMHN7k51FbBKrBBQQBBBrbnG7rgugELZY3VDF1ZteL9dhLWH0Jmy+L8OTUu?=
 =?us-ascii?Q?Vch40vGmOFZbn3afgQVceChj5rFr1EDuof0PRj9qg1O7kpD4siibqm6OKMyQ?=
 =?us-ascii?Q?ih3UXVUJvBTYW55SL1LAjdbeWux0asvlce2/bsi8TSygRcLZGU7lfSSzKQ5f?=
 =?us-ascii?Q?fhEkiBKoh7/Ik7Qf79CcjpYuta7mpYqLMJKREdYgJZ8iXjopK5GqDn2Eb2Rm?=
 =?us-ascii?Q?k0Bof6pn/vUHiz7SQtzsDXgYL0km6qLe68BlFkRWmvu5xBOm90vNiyQqsgn7?=
 =?us-ascii?Q?JdHG3YcS4dsycjU1Xx4dXPcleLbouWzdAbUwcBCtUkNB+a8zhafPUOy8N/Tl?=
 =?us-ascii?Q?LojU/ywwnW787UMuMTPWWdZE8iKngZbYum4CXFSARAo0OTmp2pjCybYGqPa3?=
 =?us-ascii?Q?O9V2eBGn4Yfc6KY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SwokbQaKCYBMsCYZbVYX9ROdKcqt8vxkn6NquOC3j+DX6XNPYBok6/BF+3gj?=
 =?us-ascii?Q?ibv0JNSNyKPQGqyTvqP5j1sZBUxrQWwoLOsSzBiljUr07NJsqvEhXjtKhjRX?=
 =?us-ascii?Q?+5x8jQSpct/bJgPZX9mD8HvUgX1gqWi8LbpDZQZgJFPUPhj0WEKRUyrEhIyU?=
 =?us-ascii?Q?H8YFpvgvzKmO5bl+No6nREV0vRctgk9KH4trnzhOUf5AWGjAVmH+7+gjhySq?=
 =?us-ascii?Q?ew8tO/w2NDGFBWbUpk7gKSRLcuN1zB0fImTQ/ijVfDQR614QcsLpNjER0KIr?=
 =?us-ascii?Q?21s3WladQEg3ejbPTL1MvO1al9EZARnM3x+qBSl5t6dkDAdYqEx/9vRfnma1?=
 =?us-ascii?Q?EJ/xd1ONi2EoaTjHCiqcUow2fY6MlPkMfftxbDOoWwrFGiNmXx2dqwi85qE8?=
 =?us-ascii?Q?s+0+FhJejHwy4cKiUhYA6cvS6r5XLz7X7VQ0wszzD6WC0/hOu/ySRv/mEvcW?=
 =?us-ascii?Q?inQalryujd0Xb3sKZEOO7yOfyCMr0ybT405AHAgn/fIgj+C17rRxYWr8mmSK?=
 =?us-ascii?Q?5iy5BmBs0FZMqwkKvod8zjzbPmK+oItWsN2XOsqASEQpqiAzs/sSnf7qs71V?=
 =?us-ascii?Q?qctmvEVwnT45ntqKjeLNia1fhC38BkUEwjvkxhS7hEqd6Bds27hUn6PjDIZO?=
 =?us-ascii?Q?Mh0pVlxJcN8bxZalJuG0ZKvFWh0CRLDYtPxQ+s+Bg85+i2UPeKEewJxd2Lit?=
 =?us-ascii?Q?VP9QX4A45Oy0hq3yyn323EbbTAlFCpxNtXEFsRU/fVs3HAYoAIe/VUhSX8Ml?=
 =?us-ascii?Q?7x9TlIlODso+bOUaWTiq5Cv/+en7flhxIQtNeJO/vAkViHbp9QCdZCSrEloU?=
 =?us-ascii?Q?AcQCM0v3BZrtOmEqZTew0N2B3xtscoFs+c/K5UkywQ7XbFHalqaRZLrjXp6J?=
 =?us-ascii?Q?5BqDofvxwbjMmyCuhVyhinnsggt2FtaJNEw45mUmGxzXrA4V1QjKIV3Q2/VB?=
 =?us-ascii?Q?yw+kWivcZa9ZQzfdPAMpLrYA3XCPI5H1OzHMpdDeMwHBNRj/fb5YZY1VVP79?=
 =?us-ascii?Q?b0sUGVMSdaMQreLZfSOJZga3kVeux3ZN7l8ijfhEK9Fo8JkG0/OcTq2aEO17?=
 =?us-ascii?Q?DJQMdsmO8ckpMh15JYMAuVThvctWoMDGds+UssTGCXhAnb7LucVTo/20XzSw?=
 =?us-ascii?Q?JIXJJnvAlF8CHhOELaQYbSRMV2ItQYbzbSRDp0amOa4orGe+KZN/QR4pJ5my?=
 =?us-ascii?Q?ohtAl7GsGcLcR1m/8eMSYowCYNVupbNswzmSjauLFP7TjWd4u0KLv4MJd40E?=
 =?us-ascii?Q?iCmGsz4cCW/Ui24rC+UKIleD8ETmSALkQWTGobzxbv7nwvzMsUTuy5mVVzO1?=
 =?us-ascii?Q?3rzeIzmXBKFHHwlg6jIzFhMHuLKxV3A2NFZYeIECTC/Szk+9/rRlYmZwKXAc?=
 =?us-ascii?Q?fH+IUcgFpTopHzM/vJ5Ksq9QYVijFClaa/5NWQCP9H+ebapuVhNUKltGGCHB?=
 =?us-ascii?Q?iFgvYmK1pG3GFLDeVNxRPKqw4TE0JoOpqEuEm9jYi7B/BbDgk+sRCAON75z3?=
 =?us-ascii?Q?6iLOtD3civZx1FGDxWe4AuAg/v5oPh7GR0fI79StlrvhzN+jYX97Ko2Vwluj?=
 =?us-ascii?Q?UUPG31mmiX362ZCeGGWVJ6+t0pf4gZeyyaMyq84N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffb8c44-a277-4cab-a0c4-08ddb3dd10f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:21.0107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqgfzcrnXbEB2diPzdp30dy3Fth4L0YzV+oRvHL2V1MWJeKHUyJ+G91eZ/9tXxCt8JJ4cTNTxPOM2lORkNlsIVj0qOE/s45SkumWe2huFDQ=
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
>Subject: [PATCH V5 34/38] vfio/iommufd: reconstruct hwpt
>
>Skip allocation of, and attachment to, hwpt_id.  Recover it from CPR state=
.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

