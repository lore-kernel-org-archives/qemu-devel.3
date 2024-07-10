Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB068C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUmO-00012k-MW; Wed, 10 Jul 2024 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRUmL-00011u-Cz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:42:29 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRUmJ-0006fx-JE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720608148; x=1752144148;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CY39c94HT0ya74Qhuxz891r5tIpmQd5gH4gsXjOVcc4=;
 b=BcjJh2a5D7PkgP01pU6xD1ABuYwS1azOU5OmnvUfwo8+Y0W2lqg4jRwH
 aXxJ+0rCyiqegUdLK/eOJgXo2bW66HcvT0MkJ09BRwR/MgyYahVn36a4Z
 CfhYeZem47zCFiClWndnjdihx31WAgL51KuFaPYzauLupWl0twBjLGlwd
 yad3WA5XOgB5WMLvDoF10+VmfTeaEWbsJUxKMRw7f4rmjbkgwN7En8Kvl
 Ov2DKkMnbX+gsX2M48zEcLL+ffDwpjDaUN0jay4F3zu1MK1wZRinvcMSr
 fK9UmcBkiH2myuRlGddHhby0Hqm7QspnV8PSvg+aIcwiCX6xKQtwyKhIG A==;
X-CSE-ConnectionGUID: Bp1vUagQRECEqhoLnV76mA==
X-CSE-MsgGUID: ddvXHavpS8CCkPgm/VLu2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21683697"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="21683697"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 03:42:26 -0700
X-CSE-ConnectionGUID: 8WgpvnQWStq/th4afdxEIw==
X-CSE-MsgGUID: NXXq1TCqQjWHQFr43Am7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="48080064"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jul 2024 03:42:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 03:42:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 03:42:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 03:42:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jspvJuW/71cmvl5nHOwSaOCTflZwh0+PHFBioJ/b2fRBl+LcEq5qPHRWi7SUqLyuk0ei1jjSSHwjkLi6AD8BTsMYVzB/RjvFRgWJWwAG5wvUl4TfOHw7F4LiOHeB+AV9SaPNdhLVEaJuN7BGWTqcWuOvfEDkKBe2g3+DWZAr48CSbgCyCHPgUHRcvUn2SPWiA/0WfKrRhg5t420sqldVddqEsIwwtAX4JTcXiiLgEaztkfqfILxMdlqA8tOzUEZlIYVp32Z7fV2BTUE1wqbfHSVMa2DbdDaZh3dR5cLDKxeuE3jJE0A8IVpqOeWIz0biFseOH2HcYiAAuuhOm2kJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROI4STm8gg81gNQsb0nw8jJ/rpKVBXZF2o7aUtWKbng=;
 b=G4dUgFhxOQv4ZK0JN4bYYJ0RKUmclYNhUjYey7HB1RqQ6UIJoZ8prBtTNzaE2fOkiilKjEpFAEfI0ynzzwrlKBp69wBopF6fPFY2ocXEEwkFSD1ei2rOIuM3L1KJKNZ7Qr5eamrUHjFkTwwSwSGKVZj36STQLjvKnBL8AlMzE7Sopv/tXlufxyr+NnwSpMPwXlXotlyHlydwIPrldccrQ4eoLgx1iaivoAjEPgev7Y5h4vGe3dcVHOXBYZuiwIgjGoaloYgC5bGBHw6FagTSuqTuy3/pi1C/QHDEUKL/GmvZqYLsectpVlHUFGU6j98aD45j9Vqe8eE6xoQAccsYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 10:42:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:42:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
 tracking
Thread-Topic: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
 tracking
Thread-Index: AQHa0UQSb+rFgyK5v0up5P3Bd/Zrd7HvyKLQ
Date: Wed, 10 Jul 2024 10:42:18 +0000
Message-ID: <SJ0PR11MB67448EFD79F088F76FBE0E7492A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-11-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-11-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4783:EE_
x-ms-office365-filtering-correlation-id: c75b9cc3-00c2-4ee4-e181-08dca0ccf859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3pzEZ0PnyVfBaFwOnQaug+WsuXlMqIGsIBxOuRq2mtH7lbVcZybtJJzUx8an?=
 =?us-ascii?Q?T9ySEM8LImPEpxW9K10WstIdQY4NShW3zKC9Jmc8ybOzmQnq5IkRC1InI201?=
 =?us-ascii?Q?sgHdvNPDoD8KYCShpAHBz0BKZZTWVnDDzZiHk0+79bbuf9ffykDliLq70gEJ?=
 =?us-ascii?Q?Dus6crl5zbTQp9qbRaYnWEsg+qWFPWbdCWu1+lajjPUOo8FlV5YTgGX4LFBy?=
 =?us-ascii?Q?8jzVoEVPIpmYoZCZscw8rn5OHWN4RqmiwW333jHyEyd2rw/7abtzj2X9ZA+b?=
 =?us-ascii?Q?smdNdQE50+MsDrwZ6y8eZMstnEzJYweg7m2BbDLMlC61yWLyYm+MxagudCVw?=
 =?us-ascii?Q?4A4NYILpFkOCJ5S0eZCzR3488iTWzE7SoBcnUm/rFM2x7Zy9hUrXjfaGzupb?=
 =?us-ascii?Q?907JzMGXhFNqEJHHCj2asqkqivG3Gda8bzKdM9SSwyMbRZ+jGQa4bRTPD67w?=
 =?us-ascii?Q?k42AP9t/7F7ltChBJZOsE5FjWwXqP0jYa7N8mxV2SFXrpe7MSguB19bbCWIy?=
 =?us-ascii?Q?htvQKm4D1V0hWN4cbvbO9O9jy0I7n2MzDl6w5sgOXzMjwmBJxOtQAJAwpGr6?=
 =?us-ascii?Q?R92UGYIVC+AQ36PNldJchVYO5PcqYjjvynYdnF+Z1EimCa5kq1PJBg8bXmTL?=
 =?us-ascii?Q?WYpQ4G41AMls+KdVhKqNni28QJzFArCHdYJed0U4LT1uB9RjoQqqsQqpHwMA?=
 =?us-ascii?Q?Xk03UcPGSdEt++13G09XpoyxMcLXAvLJP6QONEKaO0l22/SM301/yCG+c3qJ?=
 =?us-ascii?Q?7skLnT8MgnCz9drz5/z3UgckBs297OP2kOvDIRwqYkQfZwJSDZvpP/qJvndc?=
 =?us-ascii?Q?FlT6EiOgQ5iVLUHuod57VS0T2N+YPYmdGEjHlbKA1kjhNFY9CXbrM1otKBDd?=
 =?us-ascii?Q?RhaJsQ52DdQ9W+CTfiuXPcoNfrg9h12xrUAp5CNX9/YHd13/NUHMe9tPmc8r?=
 =?us-ascii?Q?vbDB0LqeQpPlkrYugi84xcMVAS59T9Ap/5WCb4xYucVun4F7laobhXhUELWl?=
 =?us-ascii?Q?ZbyKH0HsRcvA+lm2NH5YOMfbzHwo7h4JuenNPSgUoanLa4tHXm4FkjNOsgPx?=
 =?us-ascii?Q?uwhBk+3/fOssE1O5Z7MYrmJDEHUSNkyFvOsWf3pQms5DrgDpGIaQWoAr7ruV?=
 =?us-ascii?Q?E+mrxsUPk2iEi85w/vPUM+afjwiMb+Zkub+6tseXs76mGnHhwlbGh5JS+YFO?=
 =?us-ascii?Q?BA/fYKIncNd3asYB+emkRSuRBmIvBUoz7JvzaB5z+RFIeSy4GJRpdGW8QAg4?=
 =?us-ascii?Q?HUGICNDSrGlc0eUM55AFQ+MKMEpGyoh8Shf8ukJ5uxSf0oaVLpsaPAVtCrpU?=
 =?us-ascii?Q?IHvN8z69wEVk4++zAX44vxCqTL0OMB4x5ALgf6o0wW2IeuwLexJEiy42RxEQ?=
 =?us-ascii?Q?UGcjACPMxfXj3MCUCRzeBI6dA7H/EfwnhKYUGg5m/Rfu11T1Sg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aioax5PQb4E5CTwQeBh7AFNgXl24lHYOyxJoQZLMdoGoOmTS33H6LxCnWg9m?=
 =?us-ascii?Q?8HDYioFiv9L8LQlmg+3wGj9/rIzqgOH59F986hF6KcXoFETcVg6Skpwx1lrR?=
 =?us-ascii?Q?A9gcG4zYxwcOoBQhTWa5swylnco4jP7QsTGnxzQg8qIdBd1qN4mnn4bhNfE6?=
 =?us-ascii?Q?OkigaXzteZXfGMH9FemwBQFH4WdUi4gcNDJhrN7QRMbzTIOuloxNyhLW6EDy?=
 =?us-ascii?Q?vi5OLtJX9ZM7H4/kA0j1kKgDzQ9lVmkRuh0XsKW59hwrFaE8IU4wU16iHmLW?=
 =?us-ascii?Q?+pw6mjpTVwlfwZf5ujuZX/eQNp66qQ3zLxsQWZNecUZdKRhc12aHoxHmfCui?=
 =?us-ascii?Q?CMIw44GVf6jLvMyMNLtguGO6weQU+pOEwWsP7Z5cwFUUEv75188X9ogCvkrA?=
 =?us-ascii?Q?vUIivHJMr4gV3p4L72wzXeW0RFjSUSzcnk0hg6jlVVm2RmrPIopNY01ZcxAM?=
 =?us-ascii?Q?TrlVUeD5iD8JD/51esaA7HUoCJpncalCYq6EONitPIJ5rFCqIdX1X3qxlM17?=
 =?us-ascii?Q?VgBAV8UIzmXZeOFNuJrr0oa50X0/ScBBE9Ap6hoG7Wdq1Vd94w4zoIlXVGmt?=
 =?us-ascii?Q?bW0ftsMFqez3G/dUmnQOjY6+x2Ws1ZIK26FeFDjXe9GJf8qXChcYUP26XiTf?=
 =?us-ascii?Q?fzMyPwTMPkvcoY48VnS2a6ZfEy6MqktfgGL4391id7tBREQtYt6s64HwSLQy?=
 =?us-ascii?Q?H7gJ8v5HRwNbHHC6izpwOxM1tnKMVKH45NaoLE577XbuvP3WhgAdZEL3cFFI?=
 =?us-ascii?Q?zOGFOK0Kj3uNU+FH/JaIVxTVwbqFwm8z9OoQ+T951WSXvB+iVXikaJnDyFsd?=
 =?us-ascii?Q?IrBcNSsraUhpXx/9eCQ33IzE/zcIHm68I0FOvIN7BfbQnqlsHzY8UfePdtO9?=
 =?us-ascii?Q?1Gr0DDx1HfDhHyEOQPrW1OaBnSxbYLCkTUZmHqbURUSV4NV8mVgeDifNA6xT?=
 =?us-ascii?Q?F8JQt0yXec8M425hrKlCp3gV52aOXi6R/WU1oCdSAxC9jr2ic5GsOq8bWwgg?=
 =?us-ascii?Q?Y9jnAtmhNSmICJFrzyGOoRVK55q5QL/wSA38Ghkjl5xsplC0/ymFuxghzoNp?=
 =?us-ascii?Q?PKhHsvnfkKnDv6ajY+q/FhAVpIvAXVg9X2BRKgzvLdmepryq0AqSfo7Hxc98?=
 =?us-ascii?Q?t3BzA88cv+Xb+t+aCoIXKJ2i7VItsvd1Nsnx/xJ/W+Z9WnlU3AWq0xuyX9+O?=
 =?us-ascii?Q?nOqL0qL0C34/esnXDQUvxMou7Jf2y7Nffmut5XRyh88xh79aTV69RLmr9Qy2?=
 =?us-ascii?Q?c1Fgy2bNRe883YUt/qVN5RvQ2aQu3PgOlYrv4oaq2izay+TcxEl2P5d52eKS?=
 =?us-ascii?Q?m+ZX1skrzwlXUAKQ2G9IPztlgZyM6FaS+dTz6ZWLGPjO7LtQ8rkzXqhnZu0k?=
 =?us-ascii?Q?YsHobdKAbALMNjUUylrJS3muPag4PtUSeq14sUzmDErpCSQtxzZ9O+h67Hrz?=
 =?us-ascii?Q?RkY5L4td6NdMWTxj10vARDbBGWmkU+1pF7pqWltH4b7mjPH9aV5NbP8GcAup?=
 =?us-ascii?Q?ytTk2l2+4qMqIycm18KBkJjsIPS3n72PtROmiTGiKqcPh9RXmI+0VYIm4zWO?=
 =?us-ascii?Q?ZS3CmReCwWfDyGgJPcqcTA6zdPAmFL1wXDwRG+LY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75b9cc3-00c2-4ee4-e181-08dca0ccf859
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 10:42:18.0133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4qwvrN7icvyGunUgs86PHQ4rJ7htBC/1x/UGglF8cRuXV7SDyxlltfqrs01Onl1uR4VcQAWgWqFjtzWjrT/uzlVc1zb4IOjlotlBhEBOos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v3 10/10] vfio/common: Allow disabling device dirty page
>tracking
>
>The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
>tracking of VF pre-copy phase of dirty page tracking, though it means
>that it will only be used at the start of the switchover phase.
>
>Add an option that disables the VF dirty page tracking, and fall
>back into container-based dirty page tracking. This also allows to
>use IOMMU dirty tracking even on VFs with their own dirty
>tracker scheme.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h | 1 +
> hw/vfio/common.c              | 3 +++
> hw/vfio/migration.c           | 3 ++-
> hw/vfio/pci.c                 | 3 +++
> 4 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 7ce925cfab19..9db3fd31cfae 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -137,6 +137,7 @@ typedef struct VFIODevice {
>     VFIOMigration *migration;
>     Error *migration_blocker;
>     OnOffAuto pre_copy_dirty_page_tracking;
>+    OnOffAuto device_dirty_page_tracking;
>     bool dirty_pages_supported;
>     bool dirty_tracking;
>     HostIOMMUDevice *hiod;
>diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>index 7cdb969fd396..eaa33d9ee037 100644
>--- a/hw/vfio/common.c
>+++ b/hw/vfio/common.c
>@@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const
>VFIOContainerBase *bcontainer)
>     VFIODevice *vbasedev;
>
>     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>+        if (vbasedev->device_dirty_page_tracking =3D=3D ON_OFF_AUTO_OFF) =
{
>+            return false;

Maybe we can initialize vbasedev->dirty_pages_supported to false by checkin=
g vbasedev->device_dirty_page_tracking =3D=3D ON_OFF_AUTO_OFF?
This way we can avoid extra check.

>+        }
>         if (!vbasedev->dirty_pages_supported) {
>             return false;
>         }
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index 89195928666f..35d67332db20 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1037,7 +1037,8 @@ bool vfio_migration_realize(VFIODevice
>*vbasedev, Error **errp)
>         return !vfio_block_migration(vbasedev, err, errp);
>     }
>
>-    if (!vbasedev->dirty_pages_supported &&
>+    if ((!vbasedev->dirty_pages_supported ||
>+         vbasedev->device_dirty_page_tracking =3D=3D ON_OFF_AUTO_OFF) &&
>         (vbasedev->iommufd &&
>          !hiodc->get_cap(vbasedev->hiod,
>                          HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index e03d9f3ba546..22819b2036b3 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -3362,6 +3362,9 @@ static Property vfio_pci_dev_properties[] =3D {
>     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking",
>VFIOPCIDevice,
>                             vbasedev.pre_copy_dirty_page_tracking,
>                             ON_OFF_AUTO_ON),
>+    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking",
>VFIOPCIDevice,
>+                            vbasedev.device_dirty_page_tracking,
>+                            ON_OFF_AUTO_ON),
>     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                             display, ON_OFF_AUTO_OFF),
>     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>--
>2.17.2


