Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B22E9413E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 10:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWjH-0002Rb-Du; Tue, 30 Dec 2025 05:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaWjB-0002Q3-Ds; Tue, 30 Dec 2025 05:13:22 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaWj8-00018B-58; Tue, 30 Dec 2025 05:13:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaWxkDOJaDQfCp0/sgeLIU416aDodTqo05NjRntmKTDUW/fUs3HWxH6Q5SuZLeyMiNSLwVZ8hhs/vlX+kLbSeT+8lrX8i+0DbuVljN/c4QVzQ1w01MVyfCnlRSQd3DGLNdPmxE58HoblATEErPIhMUCx4MOOaXDU/3RsJ1dHmUMlFQWE/1lni1q7GrogILvc16NZoMLaVB0tv2DXw4Ni9VA4YA0PNoi325HsH1MAsbqRF+ZoK/y5R2YJ8VxEZDafjoe/XadM+zzPVrkNU9CI4InPP34hIFDBYfMVvok4BUuXEem876Ool49g5ktJ9Z1OOLRARvxnjxvxPTmpBsf2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5zxjPb5LbdzFpFmj72IMFa07hNCnrQf3+3oAmqUhL0=;
 b=niXyRT+LWmLr8+L7F3lvlzWv2CyPyzEMAkYxkkX/whvaufa5PIifd8/hxjJk6llEc4UKt1ycyzccqAQWruGOW0PLZXb9F/H2KFuXeLJopxgcFNK0vFSSdNe5hzRDzPqY4P16BMfjHzZwQoz/umnk20bqTu6NIFrCKbvD1WMdEAh1FVopFfmLsoKf25BzPEeWOhdjl9J9B9uxrm2bFn/l+22pbBB6ajAE/qP52chi6PMSecZLD6tsWc/2L9TnmIbb94Ibcb03L6++OyT+meRwRcOtEl1r6W02cO1Ac8VVM/niLdxa+WWPXwrd7oWyrjQOhQhCqvSZGTXGQYCD+zcWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5zxjPb5LbdzFpFmj72IMFa07hNCnrQf3+3oAmqUhL0=;
 b=dCkzMudJDiwN4K2CuaxYn4Nnpcgd0PXbXsYyZcauWifY+bVpFj5IONMaLkGqoFQNBb98BzOlccianDeO94RI5OQyeltBlUSx8tWZKgVQi21OtWdzHHdmoc493UfG/itcJ12PQRKEoKL2gBDGRPyllA6n3rsRkN7UEq8j5x2YEQjSv/8/YOOCR2x9YmthQhZB16GSD6KGf+yV0jFleGyZ0TGQrS9I2ee9iNKVuGse4LLc/z3utP/Q1how+TAtJF2gUQvySFrVbKutuPhuKdb5KPiRxI/+WEOW07OHdoAwBiVmdRnFCBDTRgQwQ+xVMg29OQ1I94hiylV21Q7ipJ11aw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 10:13:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 10:13:12 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Thread-Topic: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241 CMDQV
 nodes in DSDT
Thread-Index: AQHcadrI+NnRATD/c0u4kZbIiV9u27U5Ks6AgADmM+A=
Date: Tue, 30 Dec 2025 10:13:12 +0000
Message-ID: <CH3PR12MB7548E7EC8F2C1FD748BCAA65ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-16-skolothumtho@nvidia.com>
 <aVLgV+kscNVlHjIq@Asurada-Nvidia>
In-Reply-To: <aVLgV+kscNVlHjIq@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB9085:EE_
x-ms-office365-filtering-correlation-id: 9d07f7ef-3c8b-4766-a5de-08de478c0a2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QUea8QJ4KpoZ9WlAnmtDeUlWMdVuvqAYZYIe2tmMSoDelS1BF35s861UjIh/?=
 =?us-ascii?Q?KHF+MssXi1RyNHOOiV/FSmZOrouMb+jdwAIYagxH/3V34XqL74ZPNzTBC5qx?=
 =?us-ascii?Q?lpKAyxo2B4d/4p0DBDXkxBy1gAoMm+igEeRxboPCoz2nKOn5dshpcvnw+S5o?=
 =?us-ascii?Q?7fkxBJBI1WW6aeYWNFD+fi3F9+ZQMHWOJG6L95luvRtSeQieuzkQ/Wp+jXSV?=
 =?us-ascii?Q?tONTr5QPnCFoO5V4LMgQ7Q4Wra95HLXyn+4j+iMZvZou54U0yiyeWTKSNFva?=
 =?us-ascii?Q?79nvDsBkZdcXQpuWXBUZzlyUSaQIePL1xYchR9pprSsCztLaOXmb/lTL2zaF?=
 =?us-ascii?Q?E5Cp0FhTgCVd6hb7Vjezk5mkCKQLSeL1CCwvDJJw1wA6abJsFCoX9tLVcK0N?=
 =?us-ascii?Q?71dKpBTQdUVUyV7HtEHlS4VBYD4hRzIFi6YMB5NWx+Ha5Z9jrr4dsJ7OcNxT?=
 =?us-ascii?Q?TPO2zmnHw8oJd0JK1AqkZgKnEtRC68nr87w0INB2hCybJK4Brd+KxhIn4b/z?=
 =?us-ascii?Q?KFAdSMqmTSpO1BMBlAyz4p0ZoZSuMoNWDTkPffGPNddl5UVD9AA3vp18tAyV?=
 =?us-ascii?Q?80EtdMSjQB6QS1BUt7u7suZlqk5l1E3UoQPKdFxJ11S/mq74fB74i+3np8Hk?=
 =?us-ascii?Q?2lq0zTrhRmSlzJihslcyB3IJgbX2gzyg2W0vZEjgQa6f5+3m+8hHWA9LG5LV?=
 =?us-ascii?Q?eqf0LNSTYJN9sYpCwLnHx2JWPHgNlxtWJAlEw68Td9kUco9cRVlMGIw250mP?=
 =?us-ascii?Q?n/2KmMvEiud0a4BdzZFiBZkp8RGGBPzP4jPmUqMoR/fAjp7wxdT3W6vVrx2+?=
 =?us-ascii?Q?bCrO5D0lNyTuvetqNDhZv7wp/4P68y8gDGFhqpAyvOkcpKTesmqlZ5md/ZmA?=
 =?us-ascii?Q?zDTdSGijl7w5KHj1OFgBUXz6RqfdgXZ0XigKFqBt9uIEf7EC6H7mUen+fZNe?=
 =?us-ascii?Q?2iDwqavmUp5sTePgaaDMFErm0XGSsZdK8ME3GKk8mWk3G86u9zr8TPL59WNX?=
 =?us-ascii?Q?W+2SkJunqkeopFeLZCcrFJnXSILISfJ4KBF+DVBP9OACAnkd48q2dIKkrIK5?=
 =?us-ascii?Q?A/4pWNqBcOf6+m/fGwyxpL7AklOdpc6XbE/KVY8uOHUyy9LU8daH6O831lQp?=
 =?us-ascii?Q?/zuB8yPHRc9pJsqj9CJGETCHu+eSDid3V3Kb2dC7A4aLTabp7kK2ek+gxiNr?=
 =?us-ascii?Q?eZ1ydy9KkXU45Bpd27hoZkNH5CgjpfSvIjitgIs0FpvyiAAI2jHuI033GLrk?=
 =?us-ascii?Q?LQ6D85QOSDMYxZTUpep0PD1W6orY9/XIvtPmQx8y339tmgMBUDUSfomR+Ikv?=
 =?us-ascii?Q?RlqP3xmFJQQK02iYxIHIFN1DHN45sMUkQw7M/tClAOlvZoqx4Xl7Kx25QAN/?=
 =?us-ascii?Q?7e+4AzlncrYmj0jRYa/V/kq/DM6DOi5D393dpaGLh50Y7bziVfoDqgY7srcM?=
 =?us-ascii?Q?d+zfFZD8Akb1sRt2Fte/3wqvNmrw7x9cOi1htT+cwunZZoP1KaEYyFv6ilcE?=
 =?us-ascii?Q?AkM6OOcpg96FAkVOpC4F1W8zDDzzaQ8TEg9E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y6mjG6R89EKf5yae2As6xqpk3SHbvt7ZwkCBbR8xbbc/SJnwqzaoyzTqEU6R?=
 =?us-ascii?Q?qQ3I3IF9QjcdG3XlJlMsvq1uZD+pqQaMDKvavKwUHBA66FxWZlb7xzH34wI/?=
 =?us-ascii?Q?+jdKB6/oAhOZWUoOis58Mx4J7FMPfjYHbCPcAwuoYXznGWNWXkIsVTQCt3lN?=
 =?us-ascii?Q?+KiElqFFAq8LtH0dl3Rk+Roa9eyVEjr6Qs0km+4fUjacDwBuIF0lSl6M5EAs?=
 =?us-ascii?Q?+BKXd+rAkKwqUHPQ7Xzr9V14zXl6hjRZ/dVSdOZ0zO4B4XaX5Nf7jPsFHlyf?=
 =?us-ascii?Q?vMSVJXpo7ZAlx/lnMcZrA/bXmeukzAZXxWDeFFvJ+O11KUC6jdq8Tnm1NtA7?=
 =?us-ascii?Q?rYyxnyymiysUWSeeJubTDNfcYOaxiqy4BppHRlgFM1gopuvFX6LHb+TSqo03?=
 =?us-ascii?Q?LLlEnIaLCabbXDN6s34akWhlAOfbwVhz7n/2aTVL5z7Rf/zEI38oYAB5Ko9F?=
 =?us-ascii?Q?5vK16Suqf5kPt0j4ootOCFkAnJKtFzm/e0y1eHcPAHfpILs20gYsr3uwkBsB?=
 =?us-ascii?Q?p64iTSb9/pMHaTvNASBza519VdJ8Mo1OFLGTp/T35msL2yQWI2lHn3DjQl83?=
 =?us-ascii?Q?es4FEN4Teyf+DICm0tMoJs/SIS9dIrchC8HHghtSIvjRr3SvTZhUT77nQW1T?=
 =?us-ascii?Q?0+db6J/DRfkc6PbWF+30+3dDo4BB2z9S3Fp+R12uDXWDnLtI0nnyIppFy+es?=
 =?us-ascii?Q?Q6PjYMLtb3t0BnQtyeLQruXEfZVsmBBrvhSSMFkSWI2hboijUQJXgtdjwlz1?=
 =?us-ascii?Q?06+5dN1Bl9Zu+0jJIl6m+PwIPlmsyTgXdeDWeeXWp+73Otaokw/q/1XV/AIi?=
 =?us-ascii?Q?s1g2DHiKFNr7+scN5eKd6YcOLDnyZzemNII/oJ0MDK59toGz5f5LAwvOkJas?=
 =?us-ascii?Q?Laf8CAMQOxRp+vGigqTAGF4a20KW+gcMQJwRlq91IQ67/Tgr4oXl3Z9vntxN?=
 =?us-ascii?Q?Ohw1+FCbidEvcvGBqNvDtrn9L6ETgu8nTrAdit2zdCbHzPCeCtnWzc0YcODX?=
 =?us-ascii?Q?g27/B/EtMiM02LQgCjlmk5Sulo4zFhCKcc7ivxAckji9UdE6C3vYHuOUto56?=
 =?us-ascii?Q?d933UvY//kS26k+9JNbywL7uvnbI1dK+lQoIAAJCrM5l4u4OuirqUy922MSt?=
 =?us-ascii?Q?YIhslFabxmd3irrNO/MxjOXl0akRX8Ko5kve7Qr5ZFbljz59P8Qfq6/l6hRE?=
 =?us-ascii?Q?Kx2/KQPlaacHUCWWkLL4579wVWG59K6bPI+xhYVhpyFo1DhFAF0ThSe7z1VS?=
 =?us-ascii?Q?6+l49FokC05nx7+4+FjIXWFfg+bNDtvVf2j76QDt2LqoMzrFFOqcDgClzCiU?=
 =?us-ascii?Q?cS8nzGi/kyZrR69gUVJHEDN9K16ufLi4FWiL+h4POHEYgzu4SWHDNsY0bqAR?=
 =?us-ascii?Q?8AR9zyMYve6kD2acvGDw0M6n7mn4eLq79ep4KNsslbP9bdJC3r6HauLSAUEv?=
 =?us-ascii?Q?KhUONciWsUIW1ReY07nx6ene0wdd+Z7Xd9OwTu3zjCcbeEsbC/HyblywE5GK?=
 =?us-ascii?Q?jRCGPcCtMgIJga7UTojXxjMFODxc1jU0lp8a+aLuNlkWhQVDd+Nt09cQvJza?=
 =?us-ascii?Q?yA3jxXZ1TnHipKB9psRWAFaltZ51V3bNnC29larePAwarhpMG+A1g9NBA9Ua?=
 =?us-ascii?Q?E4n4+nR/IPgUuO2Zic9ydhVGA68q6EWfHzNzhuLQhFJL4eeKBNnlANErk6Qv?=
 =?us-ascii?Q?U08RbhXwWHPYbXIXkV/ztOwf4CwkFDXA3JcQ3fJATx1MQ9pv+1911X2xrcu4?=
 =?us-ascii?Q?lwyf1iADwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d07f7ef-3c8b-4766-a5de-08de478c0a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 10:13:12.4710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7O8YDF/Fxrh4tO01zsarzIeN/oQwkN6XlCSJHYODRC35YLwAkB79CyENgRZAO5SvbG3DwKh/5dzCRDcwS8WoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 29 December 2025 20:11
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 15/16] hw/arm/virt-acpi: Advertise Tegra241
> CMDQV nodes in DSDT
>=20
> On Wed, Dec 10, 2025 at 01:37:36PM +0000, Shameer Kolothum wrote:
> > +static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
> > +{
> > +    VirtMachineState *vms =3D VIRT_MACHINE(qdev_get_machine());
> > +    GArray *sdev_blob =3D opaque;
> > +    PlatformBusDevice *pbus;
> > +    AcpiSMMUv3Dev sdev;
> > +    SysBusDevice *sbdev;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
> > +        return 0;
> > +    }
> > +
> > +    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
> > +        return 0;
> > +    }
> > +
> > +    pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> > +    sbdev =3D SYS_BUS_DEVICE(obj);
> > +    sdev.base =3D platform_bus_get_mmio_addr(pbus, sbdev, 1);
> > +    sdev.base +=3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > +    sdev.irq =3D platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
> > +    sdev.irq +=3D vms->irqmap[VIRT_PLATFORM_BUS];
> > +    sdev.irq +=3D ARM_SPI_BASE;
> > +    g_array_append_val(sdev_blob, sdev);
> > +    return 0;
>=20
> This is pre-building SMMU's IORT nodes right? Maybe a different
> naming? And can be shared with the existing iort_smmuv3_devices?

Not really, if you are referring about this patch here,
https://github.com/NVIDIA/QEMU/commit/cc3b65e6a49a9b7addf44b377d4ef1de99bfe=
e3f

I didn't find a clean way to store the pre-built smmuv3_devs other than
placing them in struct AcpiBuildTables. It's not clear we gain much by
restructuring things to populate and store them separately. At best,
it might slightly improve boot time, and if that becomes important we
can always add it as an optimization later.

This patch enumerates SMMUv3 accel instances with CMDQV separately, uses
that information to build the DSDT, and then frees the device array.

>=20
> We do so, because we need to link CMDQV's DSDT node to the SMMU's
> IORT node but it is created in build_iort() that is called after
> build_dsdt().

Hmm..not sure I get that. Does this mean IORT has a link to DSDT? I can't f=
ind one..
Maybe I missed. Please let me know.

Thanks,
Shameer

