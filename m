Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50E3C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlG6-0007eL-4k; Thu, 09 Jul 2026 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whlG4-0007d4-Fe; Thu, 09 Jul 2026 05:41:28 -0400
Received: from mail-centralusazon11010046.outbound.protection.outlook.com
 ([52.101.61.46] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1whlG3-0006mO-4Z; Thu, 09 Jul 2026 05:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd6o/C6UgMqJLP+kEYrbTXJe5JEE0hDmNW9NuxS1KHKbXklOY7WErGc2lWVJruMayLbAvlDAW4YL72cATnDQEfNlD4Bn9HKafkQw7FDW5pqqhQugN50j+vhYIHaqqU/QFC2U6m2Oso8lRIyfJ+tzG+Kn4FQp7/rW7GnauuDfJQkFTDlHEWucikGerCS2t+Y6FGQS+/o4QjMLa/LF5A2yTBAUFdhDjcYXds4OKFibQH+riGe+jDI9FvkkmYTL5/26Y6UUIzEfkyLpd7h/KRJNCkj6H+2YItiW+/iqAjiTbHjyqDP5DJ1hdZG5eEK+ats/qrBnc+OuBHwsiTU3fKk7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8ylLA/1CYvWOlcySjTQv46nHSK1e/8zQSwQKnvwtis=;
 b=HrYN3F8F1ZfyHaUup5iwII9iPfHNhNYCNR1RFV1hVSc9S7sWZkDigumrWXNB+lm9hR++anNClhOmquJHXJ52FUdF3HlmBUrG3/91WpITY/H/5Ynk6mMKzem0wjXyXVH866U7JN9vhzcHo0v4Egc9Z+E5qDFt234+WSn8K41rYdlNqqxA5nkIwbXLD/OUVm6ZhpEeie3lWYRdZcqYrdTrO/VkMBE58PHPVC/QmQZxFMA8IRTWCych7bDiXTCglazzNJTUVIFkFSwikC43WRJv6zm0zGMZtD3iWGykahkasN0TBooCPPmz60AWzevStv4Bsts+bhIdqEiTVATbcLRNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ylLA/1CYvWOlcySjTQv46nHSK1e/8zQSwQKnvwtis=;
 b=DL9fWJ4Ksh41YOQ8p+aAb2v6tuf1WrSqhOfWXK0/V/0GtRPtZIO1nfqc6paCUXpEcj3Q+KZ27dp0SLkvBhN4x4c120jScU8UowjeZIn3/0mnShk2bWQGECxJjAoUUUn3YSmciHehaxxGppNcabcLwpce06ZOYfkoyf5FfuKp6plk9xBnttx/CU413fPgKLKgur526xNVrGz1ZXOcDAYioatMALHLdhx8lMDyBf4UAxiyNnuoqVIMteeTVchdHMrZJo2xP2t+lrAlYw9ZKMdlHywzOf6WnF+XN1ZhJbScSiYYqmfFQyYCyg5EZ40+F48TXqGhj/qAdQjA46xaQdFUIg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 09:36:19 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 09:36:19 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Subject: RE: [PATCH v3 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
 strtab mask
Thread-Topic: [PATCH v3 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
 strtab mask
Thread-Index: AQHdDe25v27SaK3JUESFotnw/zbBj7Zk8MXw
Date: Thu, 9 Jul 2026 09:36:19 +0000
Message-ID: <SJ0PR12MB8614332E721D2C4CECC1CFE5ABFE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260707085028.165557-1-eric.auger@redhat.com>
 <20260707085028.165557-2-eric.auger@redhat.com>
In-Reply-To: <20260707085028.165557-2-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA1PR12MB6020:EE_
x-ms-office365-filtering-correlation-id: 816b9ca8-b634-4b68-d4d3-08dedd9d8801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: G0caal1ItUuTed8AOLrYcneC+vSZcPnJYyj9L/yH+oPUgRp0glx1CRplDgVIXlAboHdQHqo68ii23KQdvvkBDlD5FnO9/g1icF1BFt/arlqB0QmyJ8JkbAw6dgnmTNZXzCDkI7MoXj0sb9tD1+1q3Upin3SBqXq1FDgb6OWqCofEH/u9oaOUfILG/wAMq466MfF1KGTwB3AVIUUtYVe6R5MHrNmQQgjdhxsBSEPMRuG0whS7msnwJoV9PJTYIJoI2QUt9D1OCsFduMKGeR3RYqNWbKylDYxRENWxKCjiRuPrCEaoNWJX+aT3tEbfNyh1A7+mz2Zvum6qASSBWvv0whnsWiHdwLYlAtUgGX5ef4fq+97YYW7SR0mV85je2elxeJ4A3zpmaNOH/+adq7inVfP5A9AknO5EHghVaNLBy7X+AzIZwodjuqu2VhfKcaFjeTWLwv8JS2RD+TpdXB/3uwNJ88SNaC6nCWVc5picouG02QjFP2i9vyzpdqdALqg1s3d9KFUx+0wpxe8xxxWMyMTfpIYL0oMvfiqg2T/EM7JypLfDW1b/KDfQScv1LyYav8nLX3loMU00s9IqF/RURTD0vFtfurcLhX7C/3gAO94qqqAQgnf3pYNLqNIJOpzYmAYUQGxKKIoqr65Yv7BNhlGiwfx46RZ+YNuQOvqYXvexziwKzxsCiUejPnPJDLt6K//xJBh0fxBq0Kt8HRXTy2KzIEHo+X1V5NKQTq8p4Yo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02fLbw31u64JbYVz2k5G2Me9QINZ41fpDPYv+SEORanBlpwESYf4K3rwvKLn?=
 =?us-ascii?Q?dbXF0Mf6hEOzTY6rUHoXwIF8VIUTIhEhCUm/8tTiVLWCCPS1wV3oeHwtcPcb?=
 =?us-ascii?Q?QGr+TMiijAENAQcihzd5MZ8W/0OF6XwUb1HGwo/0qpP1wZeAWItQzkMNT/tY?=
 =?us-ascii?Q?aRIZsUApybpVMu+Etul+BPf5RkhfeSFNO1UIouWx4uYitPTAl6reaONQHRa4?=
 =?us-ascii?Q?9Hgd1crtbnJPCQb33eP2JFxHJXcq+4Of7C/yWZLChnXY7uCY1KQnBiourCjn?=
 =?us-ascii?Q?Pt83DHHtlpGtqwOp8BkpVfa3uj76XiFybOfyZUR6Qh49oDx7gIJ9xqHOiXEh?=
 =?us-ascii?Q?bfpZbE0hPMIHifwQl/xVPd9w1p95qU3J9xrUO3vpaf0POGtM3sV2O2/QXJbx?=
 =?us-ascii?Q?gziOMnDQr3A7SjNBkVhHosDl75nwdSx/QeFCuh6piQ1w/gNlcZv0Jc2VQeMT?=
 =?us-ascii?Q?Dxz1Wt9t1D3wNdC/ZLHZ7QX3R+7WS5p71JYSNV8DgGjo/0PGELgEfzlWW9uA?=
 =?us-ascii?Q?6kQ0ky2f4ocl+G0KLh8PMpTZv1V38ZNiYDBi6xBLE4QBLW1j2ErcW7BbuBia?=
 =?us-ascii?Q?JtyGg0tJ9bPOkJCvXY9eLiAiWuOR2kt7bVdokkycxxaLKzYLf1drnZ1G8WzB?=
 =?us-ascii?Q?Sd9pvP1tsnQLkoRb5D2snm6HQnBoQvkkLTHYPGglxt5ubAP0v3obpB24OL1w?=
 =?us-ascii?Q?DZQdBbPjcwHNni+tDVMSPMyEXdB1jAu6M2QiT0W/9hzbDB5f7YUtZmsS0QWj?=
 =?us-ascii?Q?072u6i9vlles6Nr2EGUvhi+YYYnp62pbD+f3b9bgdheh1oyKA90z+NkSj3Ps?=
 =?us-ascii?Q?FnZEQATfmyowu04CyqGh5kChhcc/dTbzL9M9KX1Vbf6SGAioc7Hk90hg6cEc?=
 =?us-ascii?Q?RV9uxAsdOS57zkR0fVq93qkqjtoJb0KWgQb4+hGobBNOsBI//ZoHZIAoTSMm?=
 =?us-ascii?Q?HPxDz+eEZv7wDw4jwTWl+2pveyzFXAiCIXMZlrnP4FEVDKYAM8j29S/iYDKf?=
 =?us-ascii?Q?X0BvzOb4qkFwPOkClzrT88rvbcMNyUyk70y8YM1C2KuHeIj/oL7yCRKGAe9/?=
 =?us-ascii?Q?QWIQ4fNV16ZpxsYVP+RkfUkIdH/vp/WmvD7in1+YaWie1hYcpzAJ9LXWzLnX?=
 =?us-ascii?Q?1umdQOvtVvgjz1qD6dMUZS8pPlt61WUIuqbgHeV098QRHR5SxCafGviI4ZE3?=
 =?us-ascii?Q?pajctZOuOzdVJ9j0Q4qQ8Wh2dCvFW1i0+0jGt282pDH16WWmmgISAxd0kADA?=
 =?us-ascii?Q?vjA0BHaCoDz0LzbW7wm+PNtYiIZcBOFaYLtjMwjSLEZqlmL6JDIXfVUvbRLt?=
 =?us-ascii?Q?kfnCLvsWr79A+mdVoTHbDCpEPYHG0stZp/zozX/KuzGFY6WFhSmPzJgJVnaD?=
 =?us-ascii?Q?NZEaP+G6q2cV1DWwVZzsbyrX6HpQVTrNKBFnVuVaQHw1AJ1sOivYiHHuVBUt?=
 =?us-ascii?Q?3HztwkOvlOKNNGPvkhFHVtgtkEQCEFib2HghheWycMqG3qVRCmr8IROFJjyr?=
 =?us-ascii?Q?Y/m9rOFm9eHJxpzRU29H7nZtDiS95DiBLb4QoXBo8Sv9wqBFw5XgUlgQsXML?=
 =?us-ascii?Q?ib3UeMvCYkyueKBDaWbDa6gQRrJ1l+GHRiN5gcgHmqgiNa2ho+Fx5zr86Q3k?=
 =?us-ascii?Q?JucxhbG+2Q9ab5ubLUiDIcwd9zd2nMARR/rvtM+BMnQ/c4drZmOAs1HP+lkc?=
 =?us-ascii?Q?EFVBqpBf6GQlNOpoC957B9MIjYfjJxLv8yJrhdnkyiCXEq5C/StKpAqgYzqe?=
 =?us-ascii?Q?x/qERRe03A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816b9ca8-b634-4b68-d4d3-08dedd9d8801
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:36:19.4234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiHpKiXNSBP5D2w6jYt6N9oKKnlKLzsw6H+587DFe+Gtjz7YawoNlePW1T06GD6Jo2xtKGdM9ToOUrJGiZlkTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
Received-SPF: permerror client-ip=52.101.61.46;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 07 July 2026 09:50
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>; philmd@oss.qualcomm.com
> Subject: [PATCH v3 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
> strtab mask
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The stream table base address needs to be aligned to its size.
>=20
> With FMT =3D=3D 0 (linear stream table), the table size is log2size *
> STE_SIZE (2^6). So the spec says the base address
> must have ADDR[LOG2SIZE + 5:0] =3D 0.
>=20
> With FMT =3D=3D 1 (2 level stream table), the table size is
> (log2size - split) * L1STD_SIZE (2^3) So the spec days
> the effective base address is aligned by the SMMU to the larger of
> 64 bytes or the first-level table size:
> ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] =3D 0.
>=20
> MAKE_64BIT_MASK() second argument is a size and not a shift, so
> fix this off-by-one computation.
>=20
> Subsequent patches will fix the risk of overflow in MAKE_64BIT_MASK()
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


