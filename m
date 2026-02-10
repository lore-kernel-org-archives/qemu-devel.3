Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8DDEA3F26
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjNt-0003NP-8g; Tue, 10 Feb 2026 03:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjNr-0003HL-5o; Tue, 10 Feb 2026 03:46:11 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjNp-00086V-0J; Tue, 10 Feb 2026 03:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+MaDGfQOHbM6zduRkeQ808Ca6/h0mctNtzWSzGTdkYWjBexY1H9i3R/gvyLRJzr73c8riQV7DU9OSHR/Toqghicaa32GfkFFtq/gE9GejUZKo69UwKjm+BtIKEVyreUWYTxzQpbxorEcsRYp9A0tlNhWe1hhxj7NNr0OMmRv5yRvCGYcgg8lZILl04Y2xRVElYWQfuumt8ni25SGC6Dvu6s4Gab622FkvlcKg6QYL6kABvg38qyYauFpI/wav+RrdepqupwoXLBcMyO+E/4DXsYEHjyhQcta8OJjMjAl9o37XB2e+VrAsClqmyOB0wWWSTevcxmENvgRjoVItP+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIBVypMr5zscfdDenl1arpRQ16uWNj9QogAHsvNzkus=;
 b=Oau4sDlErZD3Bct2QbxDGJtpcyR0yvk5RF08w5iQUude1180nXFoLfGbbzjd6rLkGbNPqhJ//61ZOaARgH8EBhnJa9mt3+BDnN54ZDJ+EMLE0FfVQYBfm+Dmk8G7KDvsK/uD+IreBp+OP2JsGSXChv/pL9HZIhnTThzOwWo8OOMkUSo+30C8BhmY6u0y7diWvFCgPQYczzBbVAIYHffkWtnfY2vkhnE+3BbsD/e0YqlXEwUwrDskqPXvwjw+Pa/8bWMHBe1nTuAjtSPr/cIOdK070NSrv1lr24lcKqwO9QqSfddkXJ0Aseiqp+92KM5W4u2VQCi9I4JYE0eHVV8Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIBVypMr5zscfdDenl1arpRQ16uWNj9QogAHsvNzkus=;
 b=PvHh86GqYJxhPKQiSibVTUw3DqU/hDgUhlq4a3FBCJs7vBHwH8phtFeuxdQY5bvkVUze7BFDfk95EBLRilkN81KkkW2asETe17YaSpLAXZtT0PNcaVJfKXQLpYJs5Iu+iEm4sqB/XzZpikszn9D88AP2ZMNO1v5MTsFEb6Z9v7m6FPzDHa4zoacHvpm57zNHGZEV6h0EP4KX69KENYcF3s8wdxxwWp89HsEDFzPLmwAzI3ChbTymPfq0TFimRCLc2jb3UpnLwS1gTpED4dGpmrd+4PdOMIhqRRKnWiHmKcpyBlO5dvQTuAR+fUl4B+bDW2/3w15qAe5f7Ur3w4S2JA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 08:46:02 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 08:46:01 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Topic: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Thread-Index: AQHcl3fclJVY+/1eUEyrJW1egg4NVbV6yXyAgADQx/A=
Date: Tue, 10 Feb 2026 08:46:01 +0000
Message-ID: <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
In-Reply-To: <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: 5480eccf-8c93-443e-776b-08de6880d1c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4Q0ZWmFPQx/1Qt0kRkK5PyzUZ1QDRW0UJd9PGiZd9coR0SNb8SdrRY0g0Tmb?=
 =?us-ascii?Q?rwUVQrkGfyReMj/Q17BXnPscCtiwXsu9LwNQ2JNC+QggKVto6O+Zskfz8I+4?=
 =?us-ascii?Q?T2kKQlTWDHxew4cg/4+NDjtqf8gy3Az+B0M/XvcwP7mD9LrAMaQRRrrm2OxC?=
 =?us-ascii?Q?4IjA/Gh4e3i70BaAkNz1a4NSfxPmAnN5NfkzkT2MQVL//y2+WBtovWFrENIy?=
 =?us-ascii?Q?ZfDoxigqU2GakSorMMKm+P/s3qCGHgfbCIs/Gu3hapZ6hKI8HiCAfFKVt52e?=
 =?us-ascii?Q?RjyXI3jeZLzbtsEQxM8JFexILJyEY23aN92GapZQbXhahoRO78gP5rMNegv1?=
 =?us-ascii?Q?sIXdffxUcb0RSL7lmqRHvk0B4piYJ8MfwQZeQSpflJhWhiFGhD/X0KcGNnC1?=
 =?us-ascii?Q?VZqRVPMDQEVGD8M14tNJP8DgZ3biumKj+qHx93Kwpnc82LKY2B7C9zQaE6eD?=
 =?us-ascii?Q?QM85ESPG2ezJ7P+ZgsN1I6YrQdQYdu5PaZSMTgeWUXZvA8vs3wjRiPCexbPd?=
 =?us-ascii?Q?nLbVr+Z4opDKJAh4nmYc+opo+pgTy4gf5qZHzRUPpjr8zdeNuuyW0frwOVPH?=
 =?us-ascii?Q?tk/vOupqw5RSZU3Eyu5UXV1ZY+A3a9COHYRw8KG+EC2WdnyTwPZzFshS63t5?=
 =?us-ascii?Q?S3Ra6MEMEtY5jJKRvUvZoMTb2xMmRQY1pFpBHVjJkeYQz8LS5DUQe95sug1t?=
 =?us-ascii?Q?gos3nZuh4GxQIcjuQOiIDfMEiwJGdB7rpBmrE6IPGrrYDaD9CE09HqrFqbW0?=
 =?us-ascii?Q?DQyDQOk4IbwSByldPpF5lcRTT3lbciTFqURjPHrTla5q3GBkcQukKFEJkOHf?=
 =?us-ascii?Q?lCZ0SbUxqNYM6406uxlJUPREVPsf6hlO3k65GscB4yDlX3poEEvzepCISqV2?=
 =?us-ascii?Q?4EIv8OrW4ca1FLqPnxec0Cus082g7htoWvPZkWJzRV43+a4F1/bb+thh4sbO?=
 =?us-ascii?Q?v3rpZUY3E/Z6R0gNEe1k547OzhS0EiO5D6FcqxKZBTw3L/hntFyC3zvEd16s?=
 =?us-ascii?Q?TwD6A1W8Gt2UnK2M0SMVGQF4N5sG9QIGXCrRDjDGVldI+XEB/pPs/jw+cZMC?=
 =?us-ascii?Q?wN8oRMC4RVzMZ3jhY4i7Idn7BYgvTi2MexvzfznFQJonUDf6crXZ438iXVCB?=
 =?us-ascii?Q?rRhyqPLBWxL6RYZUe3zNsgCBwq2RA+OHeULHq8CsmE5sWa4rbm292wUZDj0Y?=
 =?us-ascii?Q?FS/rEizbz7FUBVU35832qmeG/nzhXvnoiUaldQK2zt/yXvnY4+IdmFIs81wJ?=
 =?us-ascii?Q?hw7XnpUk7OC+WIwTHVfuOrXvJQhjUVgrejGCqnYY2jepH5dBC4KEUb9O8538?=
 =?us-ascii?Q?+jUpFxfw/rvwrVuMZGGHP+ecN3R51xIowJ0sIgcB4iCiOc+L+/5m+C3/d6Ws?=
 =?us-ascii?Q?Z9W65gbgEzqBLRevmWMJgJqI1LGY9oEFQY7l/WslevFJq4T+te6KC1x9XKfi?=
 =?us-ascii?Q?0kIRXgMMLuXIzejpKVf/wk9z9+U9M79Y1eaAT6gpfZj0zhkxcU4NLEC2bSXH?=
 =?us-ascii?Q?VIyPdWoJfLAff7UnadaetEv0axNRW3T/1nm6pqoklenPD0ajFPht4CS5VOpY?=
 =?us-ascii?Q?Zwg80Xo4s5daRfqKN8jjfhlRDzD/Xj6jhM+j07BjN8R3MXH/yzIuzLQhR13o?=
 =?us-ascii?Q?rrKivM4dR4x/RvpnSU4CTAo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyeBPJtg2TDpNVSw8vBqgdyqpZ0ipmcbCS5G3Nrj3M6LrtnlE/50WjC7rs5K?=
 =?us-ascii?Q?gWA+AgGfuCsG6yE5h1AgoHKwN8oLsArZtKu0sqTrjgAjZRdhcIm3E0EZx7md?=
 =?us-ascii?Q?KXEm1NjMPW0quWyz3Qj4rVHN8w2Hf7X5xLrwGT+C4KLGojXDpTA0mux33CFo?=
 =?us-ascii?Q?g3WyGd31d9G6uD7Kxv98sxOWcM1JNvLr5EBy7SKPSKvikzBKe7YaKUtKj0/5?=
 =?us-ascii?Q?fUdsS4515QdGehuV1esq/n+c+QSNqVIsmrBV872S9tFQKXNhZVXd6y2TMQ6x?=
 =?us-ascii?Q?+l2OEdGUA84HIsWMgO9MpRUZLY+glPzj1OfaAjHxfAOTvoWC79moDhwjzVXB?=
 =?us-ascii?Q?peGYBp8e3yzQakVINj5qLCKlyx7uRGU3EdNdEjKYVK23xH/HgMb47f70Pei5?=
 =?us-ascii?Q?RrwPhspjyryzeVrxkvlM50Zt6x4q9OMmzMn5gtqgLic3mrrTgi4iDo0Ac2vt?=
 =?us-ascii?Q?8Oi9pQlv56h55rRX6AiwGwL5F2PnIZyRR7xjNTna4XFWx2tNwIXFA+dAafvY?=
 =?us-ascii?Q?X0w7a18sYwwOAp70ae8zwnRsPpqaR4AA8yVtokJCfe0NbG3wowhwqtEiCK0W?=
 =?us-ascii?Q?xSPtul2vaK9P54oflWO+pmc5YH/hMw1QjLdfremCVldkB6hw5ty4A7b9IMOZ?=
 =?us-ascii?Q?FHoJXvdwIBQN8qUaAS30bkql5wiHzFPcGDF6f5FzoMK3VTaKTOGkyKmhLEac?=
 =?us-ascii?Q?pzRHQq28LJ78lS07g2LUD4SjJek+vcQ03wtiX+oI8WXHMZfMrxC4Bo/8a0d/?=
 =?us-ascii?Q?FWh2pnAQKF/Zmdf8UNfiHYoLXSsESBdeOvutRhKBI3DMrW1mN6E2quC5UO0l?=
 =?us-ascii?Q?W+CsiCKc8/+GkGvDjLCWFn1TrGk/ZkZtzy+jo1B+2lVnyZIzMcbZt/s1Xiz3?=
 =?us-ascii?Q?TQJ4OD7wWzt3PgvlvijC15lV3x16kY3r5uPgL72gn94/B/cp7MRYfweP2aXg?=
 =?us-ascii?Q?OdYtm3/We6Tss4Yx6mhe+UmRNss5Purok1lCw5o32sopLQRNlZKzC7i1jALr?=
 =?us-ascii?Q?5N7TbKpYO3OYgAmhd9fT5GkKA+o1LFIy5318SJTwRy516JO4GX+V/beEQZaF?=
 =?us-ascii?Q?yb0IjLIBeBQVWro+KjMIn7AbhJNRsHA1Dps6US3GD/W6NQR8J0goHwmc/F6J?=
 =?us-ascii?Q?XEa8WrPaeoz8iiERIUa6JceZfjIHG0SrrgWG6FkQEEp6bJwtDEWtRTE96dSn?=
 =?us-ascii?Q?SlYA5Kqnih23FCHyw3ZO+G55ht77qwhHTh8aXNJ4eeLzjOs0NC6fZP4YQ7s2?=
 =?us-ascii?Q?y4L/aFXNnBLA3JEdSv0Vsjl3S/TMAjBEofEegEWHFII1ZSWu8UDUSOQmJsKp?=
 =?us-ascii?Q?4Eq2QUEk8gAU5NZrglNMs0ZbI1iq0oC7p62J//OvJn4Fs3WkmY4dof/SyWog?=
 =?us-ascii?Q?sPFhd8y8JhyQsj/h+qvPNoEwzCW33ftnKFYlntZJvaFrLlrl5yVY5o0ZlPhg?=
 =?us-ascii?Q?Zv4ULpzEyNYp8DyPL3dethwOBxdfuDiI8Rrt/+OK486oo/SXHyIzvAT7GnyS?=
 =?us-ascii?Q?Gi4MhaTwaDmF0JgOldKSldW/lNkKLSl9PtIZlwKIWqA74nzOjxJUXiG0N/oX?=
 =?us-ascii?Q?lOWanO7UnBVjVruZlnEZ54ZZCl3nkuRjfc1BPQVarbRp9SFLl8jtB+zlaGq3?=
 =?us-ascii?Q?Hbvhw/XSSSBiSY7U37tzWNRjL9A+AMbJ7Wc6keAgUdaKsSWuSXW+xwcrJWcf?=
 =?us-ascii?Q?rx1t1U6LPGnNtnmQLjX9HrG2Aq7QMbWs08NXSEjDaD0nZrqHsk1JfFMImtFe?=
 =?us-ascii?Q?AywRBKyjJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5480eccf-8c93-443e-776b-08de6880d1c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 08:46:01.7004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7k8DGieTZ1rzJ1weXaadmaA+ip9HkStQxWnPFKD6eJMFY/GPgHfSjfVELy/rUQEENRd4oWK9DC4wLWmnTUo9fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 09 February 2026 19:42
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
> interface
>=20
> On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
> > CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that
> enables
> > virtualization of multiple command queues (VCMDQs).
>=20
> Let's mention "NVIDIA", noting it's a non-standard extension.

The idea of this ops based callback is to make it more generic and not
NVIDIA specific to start with. This leaves room in case ARM introduces
a standardised version of something similar in the future, or if another
vendor provides a similar extension.

>=20
> > CMDQV support is a specialization of the IOMMUFD backed accelerated
> > SMMUv3 path. Introduce an ops interface to factor CMDQV specific
> > initialization and CMDQV vIOMMU/vEVENTQ allocation behavior out of
> > the base implementation. The ops pointer and associated state are
> > stored in the accelerated SMMUv3 state.
> >
> > No functional change
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/smmuv3-accel.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> > index c9c10e55c3..ca087240e5 100644
> > --- a/hw/arm/smmuv3-accel.h
> > +++ b/hw/arm/smmuv3-accel.h
> > @@ -16,6 +16,23 @@
> >  #endif
> >  #include CONFIG_DEVICES
> >
> > +/*
> > + * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3
> to
> > + * support multiple VCMDQs with virtualization capabilities.
>=20
> Ditto
>=20
> > + * CMDQV specific behavior is factored behind this ops interface.
> > + */
> > +typedef struct SMMUv3AccelCmdqvOps {
> > +    bool (*init)(SMMUv3State *s, Error **errp);
>=20
> > +    bool (*alloc_viommu)(SMMUv3State *s,
> > +                         HostIOMMUDeviceIOMMUFD *idev,
> > +                         uint32_t *out_viommu_id,
> > +                         Error **errp);
> > +    void (*free_viommu)(SMMUv3State *s);
>=20
> I don't see much value of having alloc/free_viommu..
>=20
> Type and data structure are the only difference from the standard
> viommu routine, and both are already in the uAPI header.

That is right. But again, this is mainly to keep the interface generic.
IIUC, Eric had suggested, using an ops or object style abstraction
to separate extension specific behaviour from the core code.

>=20
> > +    bool (*alloc_veventq)(SMMUv3State *s,  Error **errp);
> > +    void (*free_veventq)(SMMUv3State *s);
>=20
> alloc_/free_veventq can be moved into alloc/free_viommu functions.
> > +    void (*reset)(SMMUv3State *s);
> > +} SMMUv3AccelCmdqvOps;
>=20
> Overall, an ops structure feels unnecessary to me. Maybe init and
> reset are somewhat plausible. But nobody else would reuse this ops
> structure that is exclusive to Tegra241CMDQV?

That's true for now, as there is only one implementation today. If this
abstraction feels over engineered at this stage, we can simplify or defer
it (and fall back to calling the tegra241-specific functions directly, as i=
n
the RFC) and revisit once there is a clearer need.

I'm open to suggestions, and let's wait to hear from others as well.

> >  /*
> >   * Represents an accelerated SMMU instance backed by an iommufd
> vIOMMU object.
> >   * Holds bypass and abort proxy HWPT IDs used for device attachment.
> > @@ -28,6 +45,8 @@ typedef struct SMMUv3AccelState {
> >      uint32_t bypass_hwpt_id;
> >      uint32_t abort_hwpt_id;
> >      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> > +    const SMMUv3AccelCmdqvOps *cmdqv_ops;
> > +    void *cmdqv;
>=20
> Having two pointers for the same extension feels redundant. Maybe
> merge them with:
>=20
> typedef struct SMMUv3AccelCmdqv {
>     void *private; // points to Tegra241CMDQV
>     struct iommu_viommu_tegra241_cmdqv viommu_data;
> } SMMUv3AccelCmdqv;
>=20
> ...
>=20
> SMMUv3AccelState {
>     ...
>     SMMUv3AccelCmdqv *cmdqv;
> };
>=20
> ?

We could fold the private data and ops into a single struct and store that
in SMMUv3AccelState. However, if we want to keep this generic, it may
be better to keep them separate.

Thanks,
Shameer

