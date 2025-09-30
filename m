Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D870CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VVr-0004j3-LS; Tue, 30 Sep 2025 04:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VVp-0004fk-8B; Tue, 30 Sep 2025 04:15:05 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VVj-0006mV-Hb; Tue, 30 Sep 2025 04:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrQNP+xSnozur6rlEA3thC+DiwidOv1ZNHMt4BchfrH9PpNeYjXE7YWqvNNWlMak6Z30qVf3YC+Ut0paLIJGVHq7CkYh+SGOaO7tTbmoJ8gsPE21caEcqr+fSftf1ZiL7+QGM1Hf+JsxgDb1gEO8IAmZfhQuDmhK9JMd581DL0VpHc3mbxBUWm5/jR0dBtZ1S0LfyMNoo0ECXBsYp3LaWavBSZBFAkRmAvWnnlypCG1xF4R/lylCBEug5dbGqifHHfGEyEzpwvxKNewcNCNuXvTMZyTt9B41jLlOrbzhgwzkWFhajBCbk4nik81wC4c2HC4WxrpY+FAvIHcPHaj9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GOsm/FC+vfTRpe4et8GD78wGniFr2gUYb7tJe5G0pw=;
 b=Lmy8xtk6EdkTiS/fA19QdGwpc65q9lPzbNyDeCnnHYSzyP043caTegRpH+tLmc7jEGooKoT1LwOHHR5/rpZYyCegffhnHoiUu41NXxjBSPo+bZvdATvykpi2wFrvppbpmYaxBD9qLa3GxnpqMxeRhim3AlZnYomgSUv1yV/iLFpraD6DGhDo29gSoNCbnkzXLtEEWlhzo23kECkcsuGPtQizkzPvw9+yvYMR1M0iKOvWUlVF03682ayd3apkevBPvYqr4HL7uHDvIYmemViD8Kcl20t02rZ339nx0DBCLW7U4xbbo+GqxoxmAHKKkscaJzYPhuVZSLcIKHhhZaW0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GOsm/FC+vfTRpe4et8GD78wGniFr2gUYb7tJe5G0pw=;
 b=jIqXv+8VvtVOT0at5tkjQJCVwA7EB8zfeG523nlKMUvwB8EovAT9l9jm58iyrBHVa2f7otwqHalZUpPtf8SvHo3YC3iMjoUI/ITU4YW1Pr5kkH/BGpZ7uV3HesrY0ZW/ayYHx48zYX8UXGr4pq93NsWfXZm3Zpbz4lmMdUh7mTpUaMvRDm6ticyPfUHVwRS7Euw6voHlknOZBI7sRj8/eadMp31QUbl5mYI5PibKOwAqq2eTweeLA/UPkh6k/4srrDQ+7pqUeZZPOAsKh4XGdcqfE4mNqwcwOKk44AIq5SdkaRRWe0ficftpQH+Klw/HZJXENNDh72igCCvNvyWe9w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:14:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:14:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 02/27] backends/iommufd: Introduce iommufd_vdev_alloc
Thread-Topic: [PATCH v4 02/27] backends/iommufd: Introduce iommufd_vdev_alloc
Thread-Index: AQHcMWnBY2AoEumTHE6iTA6u0fkT47SrYY9w
Date: Tue, 30 Sep 2025 08:14:46 +0000
Message-ID: <CH3PR12MB7548D5CE5F76841690BCDF33AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-3-skolothumtho@nvidia.com>
 <aNrHQT5+WITaKV3m@Asurada-Nvidia>
In-Reply-To: <aNrHQT5+WITaKV3m@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA4PR12MB9833:EE_
x-ms-office365-filtering-correlation-id: f70756df-3652-4cb5-f155-08ddfff96b3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Z3COLSkRzCZ7L2KojF97Hpw4hIkkUiIioa24CJ+/IA3+B9u7RECaf5M8hyvW?=
 =?us-ascii?Q?dKUuhjhtIwL8+fScJT0rE1Ise3rlZVF+I30i6cNJJ2tKiFrq/pwfsco1ZPmC?=
 =?us-ascii?Q?EouQ/z59QXzvhWxsVcsE5qzuEHoA0cIcupj7yklmflGrkEzVzO6MCGU7M9Uh?=
 =?us-ascii?Q?JdwE8h2h6caj3dpD4n3n2vqhram8G6m5aauaLfhWL74E0w2GlJ/XYf5lrnm7?=
 =?us-ascii?Q?QgdWflqtRWRHUfwFNJPf6SkUIakGvTGqlURd3wLIgNznT6sMtSWWeQE2EafK?=
 =?us-ascii?Q?QaKTKIs1cGk0dsD3ML/qW5MDciNstbftlIXPph3AUhUtp3rj5zjqegKZZNpU?=
 =?us-ascii?Q?bEihcsc3+ko/a15RIq2ZZ10oZkl1XByn56RO2jNsbcbp/MOuOFreI4Fuzug+?=
 =?us-ascii?Q?dkyXFr5pGSxN53KQfkDHV7gTZJgwPd1n6PEzup+l0p6fyZBxvfMzmMm4lpJ9?=
 =?us-ascii?Q?zpEzMWQitifJWfFwE7O4m90tsZHgAVRp50MKntIj5v0WmWa9unfvSuomUF9h?=
 =?us-ascii?Q?cwqwne3iVVWXAAPCxV09SUSmeLAkxY91EjYzsUxKhL2tUH8WdQYIdkkMiWvD?=
 =?us-ascii?Q?05G+HqqAfirH0hbCks8/S1kDItRWKUUUZCubxnzptdZLcX7fQCLe10wdmEuV?=
 =?us-ascii?Q?eG3sbXk09fX7XjmF9IPEb0LK8pFgpCTjjevxat+zQoJP+JHEnlHVeM51cx5s?=
 =?us-ascii?Q?3KaytNXMPJXRj8cPog1Q8scy/CAazmIpoqDtzyeLg37viKUWHztIePH2Exiz?=
 =?us-ascii?Q?hYGNSbVMnANDjWe1Mnu5/WBHA7D9ZwL3Pv9odohGs0a5rDyRaL3JD9nH4/BC?=
 =?us-ascii?Q?3GnrF9tJivY+LZf1oywL0BJSR9N6iTH1i6mhM5Ce5kyR8q6aAXGDGMlDH17K?=
 =?us-ascii?Q?P1JUUnEP6umZso7cxJ4DM7fnOzCub5vQBIoxw9OEgM4g5QmL6di42emHn6EW?=
 =?us-ascii?Q?eMdAIW5q92BxSrhdnqVTYJbrfH4d6XOip+T+XH0LjRIA1Grrdg32NGviAjkh?=
 =?us-ascii?Q?DOIvuOEGIRLZmc5MGwQbBVso081ySbAj65le4Z3pY+F8iQTGV0MCGwytjAkq?=
 =?us-ascii?Q?a+5LcTnCMZrHmj4NDuIJWRQfeckef7NzPj/sG4ny0muJYo5pEGEHsQ2Bbpzx?=
 =?us-ascii?Q?od9I/CkPUykl7c0yBb1YZ4ouBNXu7kj/845H1YJmxxsC6UQUCQe5UNb9F437?=
 =?us-ascii?Q?qF63JAXt15zS6kW67DU6BNZcX9XEbSsWLMjwRHalk2eI+MtOMEDGPEgaPkgC?=
 =?us-ascii?Q?fxS6JEU9K4BKOCbTVCahItjRJwnPBMdaUAtsmS+FFiKTWsPsjmaso8lM2YsS?=
 =?us-ascii?Q?um/Oo89GwB/EOerWnsTgkn2irKPUhkZV9XwEfBXYikGTUe1cvy/GVL6kGfA2?=
 =?us-ascii?Q?URWY+9k1IUTBIaOMzDQ089IQLAvpLPNVnJOrPUAiQ9KXhk/HMGd7iVHjupvR?=
 =?us-ascii?Q?Re04883N6CNPcacGRDtqhrkII6Ql4lPv2F0jqV1G0IUGzP1pwJxv35qH4KYR?=
 =?us-ascii?Q?QjmY356mW7VeBIkEaUuvvF42DNdSfOGnzkX3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iJs/UqAKW7KhfGVfKiP9L5UqZYI6IUYJZVp+WeMEEbrhHYaJKNZXGFIRqrT2?=
 =?us-ascii?Q?ggI/+WeSWdXD4y+Zlf/kurS1roBy2PnLeR5mIeV3zMQ8I6pGBDr4l2PYqtkb?=
 =?us-ascii?Q?v7SiPgsLo9xdkmjVG9HqCIHMKpzVP7J8B4P2OoocNb8Z7IV/uzXFFAwd4OXV?=
 =?us-ascii?Q?xNEFSsKTL9JfI5QCiBAYxIsfyivxVf7fiFIKO5ZCfAAtHC40NVM7qJ3L0S15?=
 =?us-ascii?Q?RCPWphRVt8MYOx1mAO0u0Jd6RuXgnVhyOg80nnuSTSnWKfKZC8dY2vllFCrL?=
 =?us-ascii?Q?l+xkHSFaWnJ0e5wt1RCxeDMAvKGHqTwRyaFkKNso7gYTVCoPqkvHjFQJVPh6?=
 =?us-ascii?Q?iFGvLd3oMgvhGnlVw+zM++YHtZJkhAXVqC6nk7FQwYY3IM9dnnRgluZjwjg5?=
 =?us-ascii?Q?2PpHN2Ps9oNe0KG1gybYQ69ba810iYqAy1AbVTNjc6T3PDXMK/T6mOaNSVHy?=
 =?us-ascii?Q?mXnkekaMxegCiAYMFbPdDiKfm0mn8zNu2L68UeEVh+lZY5w4Kekpndthc6GR?=
 =?us-ascii?Q?FO2/P7FIX1L99/PQQcThkWR8kVwLpa0FJCP3I2VJUknCbYpLJcTDBtMukFVx?=
 =?us-ascii?Q?SePQl0Ah1AjCFq8bou5umnf20Wb52MF7QleC55N/r3wF8sHtAlKCmyaO5Yjg?=
 =?us-ascii?Q?cH6/TIObdu4cOSbGGoQugCfllUzKwqlUTaQMGZlcGnNB9mL/LcvvV9k1JmHt?=
 =?us-ascii?Q?AFRpU9EgoCzbQ9UkZXvLW4lB+ZiFqW5v365et6spu3XDkh7qtKwZOHmlNzX3?=
 =?us-ascii?Q?HUsjK++Xoc5O0Bofs0DB0dAvfCD819YxfbJcANE7FJ3NIgrzt9XT5GJHJeqt?=
 =?us-ascii?Q?ohfDRjYyhWCH8fdg5Od43aYXMmRxNNkYAoEUcPmm6vRUNAWNgG93jGF5+J+w?=
 =?us-ascii?Q?oMXFsfQgWov36W4139cYtTH4JHQRSOlMK/p4Rh6G3PLbsGYDE8iUxtYdjqV4?=
 =?us-ascii?Q?wMRhNpv2iNOuIt3udgqq9Hk8AB3VPTEksjg9i2t+lOEe7GubCQByfcSqxpT9?=
 =?us-ascii?Q?S87rPrOLi0rZ7kKQdQwqDD9eLYEAqFeSLRZXeB1g4LpfJSa3OEng05UZBmlq?=
 =?us-ascii?Q?RYAbweRclBy7k9tcKB1uu7EDxK+JAk0DDhwx82uFTfuDxwBwKziEKTetkE35?=
 =?us-ascii?Q?FeFYiMaSxf0Bca3RD/QPQDcsoSc6aEccG9xQQdGI8ylybBCLqENAokeEeyMx?=
 =?us-ascii?Q?i0JXKiNfhvuewqe6hTZtGFpLcn/WsRfYiBVxocmyGmDlwvpzEx//gKDF2PSG?=
 =?us-ascii?Q?ZAKNlpbj6PrfgLEzM5IflF+CWmbTufmAsD0EBpEL/r9fll2uV727IPECs611?=
 =?us-ascii?Q?5ArcUxgp1uZIGkI0NTcMH9aGIarS2eLosq2CE/8EKlWU+S9v0zgbtIrODd1j?=
 =?us-ascii?Q?LEWEkgode2ZE1u8KtAv3zMbEsh2/Hy+HGcCUpbo4ys3AE6K/8raoU3c5HyiZ?=
 =?us-ascii?Q?HIioNxeLikCM9puChty/AkKi4fVDzP/xpcky5IupSMYWFtJsEaKLx4LS+sK2?=
 =?us-ascii?Q?dkjICKYtVIAvjb2rp2NvxfOSTvI0/Mx0z+iegzRb93UYZRIlbMONqVXjuEiJ?=
 =?us-ascii?Q?6CttTWJb3kuv3FzpRNEjRccc5Km7H7dmvppLeBn6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70756df-3652-4cb5-f155-08ddfff96b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:14:46.7143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oR+/iLt/CdilloslTOLrWmUehO+xGIOc8Z0c4RH5OlUd92J3bBcFMbaauh1Snw4LAqXkNlq7kM3uHEBAImAtcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Sent: 29 September 2025 18:52
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 02/27] backends/iommufd: Introduce
> iommufd_vdev_alloc
>=20
> On Mon, Sep 29, 2025 at 02:36:18PM +0100, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>

> > +bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t
> dev_id,
> > +                                uint32_t viommu_id, uint64_t virt_id,
> > +                                uint32_t *out_vdev_id, Error **errp)
>=20
> The function name in the subject is now mismatched and should be updated.
=20
Oops..missed that.

Thanks,
Shameer


