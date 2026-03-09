Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB64FCA173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfkk-0000RA-G9; Mon, 09 Mar 2026 14:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfk4-0000Ha-AG; Mon, 09 Mar 2026 14:54:12 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzfjz-0006pr-QL; Mon, 09 Mar 2026 14:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3G9TxD04BBJNfUB/hvSUS209vF+xORdtnndYlV2ewVDQ5D6GE1Dr105uLkI6T5kjPcwm736ayfMZcVuKnQyWxJyj651VgtPAMkvMl+3XjtfOPEa5w5H2u7e6Zitryr8kbviSuG1VsF+lLN+GU1h8YoQocnu3FlgTyOKxHb/BWk5OGIbUmyrjvXLPAzRajguEHWrm1vziWN/XthB5mO/30c9CHizmH2I35OvroRnvI60lsbrAxB+sKVLQp1C6hs7985LHCOS23+VeZnyn9GilkgvH6NC+JnG+ZIDDiqz0CJSNg3oZMFP+LYIVODmSFtUDsAcfPXrdYaYUisQ0MQFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMkXLUc/J67g4dIAaAwPhwKIB5qmSgUfW2LzKRuNy+k=;
 b=aUrYD/nnt1SUjs/6CiVBRXuacP7olecpQzVRCWIs32Ryyn0Awpv4HiO/D2xd8b9PIKmRBdh+Sa7t6Y39JpbraL4BEi/9onZE6vpdEJAS6Q2uGUzhkdCObCeRCRj9WxvOzFS5C74fuXwHb15gYWrKz1eZzN+yuYAY295HXAVkhzjyLHmfLqdjYr6hsE4LeO9MqQCsqu7hc9mwYKAap84voqrsvoyl2/3i/UwbCQteyYi1dqQxWRD4qvikgyWgnWl6UUpID+2zneKpQxFww4Pd1vwloFsUgwQgJ7cUZDFktWmphH8SMJW3rZykkRk4T4749mYG1RQaxOSiRpgB4D/BgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMkXLUc/J67g4dIAaAwPhwKIB5qmSgUfW2LzKRuNy+k=;
 b=eKtrDAFMOUsNQxkFv6sHQxhpCizFJ+zoxqqlAFsQMAfHVmiKu1AyLTmKoQN6zmt0O7amZ/SPmkemmZ1UJJbM2kmMW8MJYLABWWngVs2N4nGpQqrPzg86SyApRu3zrHn2kl3pGdKf+i45Pcx9PWtelEWWckcUO7EMqsWKduNL3gesTECAA6oeqU0Xy81iO8tFRijoKRv2ISwJwJvjU4RH9Fkre2yFbk5DWehW4PkzbPQ7/hTFCVjVnCuggb15Ap0RP20yIiJtu0MVt5EzWCXkxBsDIeeMIZlHkihuMxUaWlBB8ufDNNaEs8rGit6u04MZVH+IQGCMDRRz7vXPo3GmBg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:54:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 18:53:59 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register reads
Thread-Topic: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and VINTF
 VCMDQ register reads
Thread-Index: AQHcpw4MPrhF2lqugUmW20bAlt57w7WmipEAgAAClSCAAA1IAIAAAVQg
Date: Mon, 9 Mar 2026 18:53:59 +0000
Message-ID: <CH3PR12MB75481A77D2468CA6848824EEAB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-16-skolothumtho@nvidia.com>
 <1b64d8d1-85d9-4894-8813-d645977aee68@redhat.com>
 <CH3PR12MB7548413828C8ED32C75B1ED1AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aa8UOhKhA4jIXVxf@Asurada-Nvidia>
In-Reply-To: <aa8UOhKhA4jIXVxf@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SN7PR12MB7451:EE_
x-ms-office365-filtering-correlation-id: cd7d34f3-7270-42bc-b19e-08de7e0d399a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: zQWtABGNINfPAqJX+5ZoeQoJwqub131l/dvf5FsiHHaM8I8r76SUnYeEpZC/HHn7g8muDr1+znfBqOzmmTqF5fzFd7Pzq5lIwp+Z85b9VZ7jknS9/bEjsIG2i84yIRLUUbtJsfsXKIQ5UXznV4nEHBHpivkK33bh+0koJsqo6cW8bCIVzeiPuzWN3nD9JNTRsRW47ti+iIr6DMcECY3AF88a6lw/sfGr7XhLMotA9+CheEFIMoJB8raCIi64d7P2+tWVggq87IZIdQt3KaOI8evxxlS+Sq5L6BIadZnYlqAIO0/LsdC6IoYFMPOlVRm4t1uTxASgBJiTBYJuFB93iUcVoU+Iy6xnBhWfqDUcWvd+MSQIYUuKV1man/ZY6kDKom98NFgTKoW48+HVNNpKKg/9ujtwbrxjKOWfIlLORm8kaqFpQLN4Nzwk9f7kqTFYJVrrdo0HiueeeI9MWYHzB3FoZJthwNlLASEkta/Af6AZWc0ZAtNKXzDIA5cydDgz5ymLtIBk+yTvmFIpVFf1wdwmP5TGt4UV+NyTVc5F7i2qluBMaPdF30mMRe8qjvCcESsAoX/+UQ7/z8/7y8dFHhzuyy2KYyYONkr1zwwcCpdfCeUJmEHttTDM/rOhjsH0IMYnjDknD+SDQ2HsTcWJMdQBvB/KXLmmJEbT1+qoq/5tFck1zxjai9woWH3KML+iunxu5MADb28Smlkc4Or3rW6FD6h2mVKTC6Br7joPc+vwFPnClLvUjP8dnjewLeIhh5LZgboZVIRdkIllS0nj3WbQKgqbvO6lw37HLceyeYY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vJa1mZj32pWQWluh5emA1cxgCjnLbN9VAw/9GZiYhWV6rUcHDnQNt0kGyBtn?=
 =?us-ascii?Q?XvOB/3dKl2dynnedshbNtWzDf09Ib+HitCa8w+wYUhRsOY5Zx929utt5BJET?=
 =?us-ascii?Q?0L36UjfeHdShZ9ODlh4i2/FIEJwP/7Ck7AK306ndSziJ42h5ftO/qH9fWvU3?=
 =?us-ascii?Q?hhHeHAVUhk3DXheqBhbopzYwVVMXLgh45K4vTCdNj+tcD/Ac5T/uGqm6uP3E?=
 =?us-ascii?Q?Skg6SsItlCU+u7xSCjKRK4zLpKONvHSHPgHKePs1mNEu7XpFne/Bmpcf4NC6?=
 =?us-ascii?Q?8DPzm5s6tOPUvxwbnijaS6MVhUkWtPmCn3fA3d0R+b+Xyyd3QYtq+IbK0skq?=
 =?us-ascii?Q?T6UveUOFS68ukeOynODbcDF3TVT2UIVY5u2OhLgV2IUXNkFWwAC5Y+qOgzeM?=
 =?us-ascii?Q?Bcm69iyAq9rk80RwzTVGGTB3XL/KlQmR4rboucS4nDq3oYilrsT2OVURYZqa?=
 =?us-ascii?Q?nG3TMq6ggewbuBZWcQOt6B4vx/uocc7jEgCR/320wCKNjD+fJz/u9XwZomsI?=
 =?us-ascii?Q?IiH5zBSXBI1ew/BCvKxtWD5NMKN1qi3IQhbWQHnAJe5D+XgJwSw771IG3b+3?=
 =?us-ascii?Q?wxqk6PU+hW9uIIb8RfWjZu0OyaeEab9pdjey6TxPUq6hXfZrotonLHbVsWHT?=
 =?us-ascii?Q?UNQQZAbm//xQGh7iR7v1aXgB8ym6Kr7GYBgZcxgTNy6kRdFXQTQEggmjZGle?=
 =?us-ascii?Q?zkDvw8DLFbiQ0bfPYRv3h6GsPflm1PL1spJ7BA+VOUImjrjDDyCfbMxjHl1r?=
 =?us-ascii?Q?dOJY99ld1/KTdTJhC8U9OLIx8KAOEukA7Nf/YvdWPlC4O6xJHBgbRpjYm3bX?=
 =?us-ascii?Q?tfwfN5YxYteRu4ZgqWO/01kEjcUJ8saq+6sLjFTGHXnktMLnfdX6A/msgDkN?=
 =?us-ascii?Q?t6ZCSH346wvC/nnfPcm4wUnfpCzL8Gj2IfrLZV7GjBjgt9G2moHTVmSuQWts?=
 =?us-ascii?Q?m77ywciKvm5TRrLdV/uuZSQ3JmU+KVqHpxeKL5NbcXuvOeSD1ITB2YYEn1B2?=
 =?us-ascii?Q?IM+4sszrhghaEC8MUpb9RUAD5v2Pth6iPrBQnlPETmXJ8G7CZZmcapKVqmFc?=
 =?us-ascii?Q?/X79jiLNDwy2bCIkOGkYnMCDvMSLcZg31eDODaFf9DcP7pcZ9cuYlh2Im9ux?=
 =?us-ascii?Q?bGpCgyKw1Z5ZVKUd05I7zpNi4Cgh7xkUhpVTHEWkxiPNkueRPa3uNiHsXnfH?=
 =?us-ascii?Q?e0JBvaIx7ZMo5TYG2rELNJH9lqznkH+3MC87VuCcU6LDGQ3XtIvT+AaDAEpb?=
 =?us-ascii?Q?3ZecbUobSSmNOtI6XLEO5B4uknIObPJ/QzbgDeh6oCvuc65WlZr1Wj22YV18?=
 =?us-ascii?Q?LBDWFwzm3oewEdPX5+dHCe8rxGTKu0TuZlkq4QzEmXp8oMk63uLPTL6TMEOK?=
 =?us-ascii?Q?+xmTFgTyNhzpcB9wPjmShnV0pXfa2ZjR4oedJ7H0ysfbu2DOThcaFfQL5X9A?=
 =?us-ascii?Q?rUm4p4ImOUrSjHwiFIXRMc6sl65FGpOf6UxV2uGAp9w1A/V5lxKJnOaRqyps?=
 =?us-ascii?Q?Twi/tLNnnC84TS7/JUEjDlxiFvCAINGEf3tUiUn5I0Pf9NE1pf5qLaUaOxXF?=
 =?us-ascii?Q?5Lg/ueyNu0CIo/N7cuY38eSI1ObeBVQOeMAWhMVV9n4ddr+RCbaVBP1YsJDd?=
 =?us-ascii?Q?8E90bE6TgJJzHciBfef0B9Q/3drtUahPzLgoLI8SMobUYbthCyYM2jlh8MVR?=
 =?us-ascii?Q?6mYhRhLz9Y8LXYknaUGXrSjufAWZg6x+pSIursrAOuROoewazlU1TpOrY1fG?=
 =?us-ascii?Q?2WL9AAppyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7d34f3-7270-42bc-b19e-08de7e0d399a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 18:53:59.8942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI68zrNOxcJp8S1JTDogertjAFYe4bSuSCN2RawjhpLNuI+RkBRktiLrOWH1ZV14y2Bh1sRVFBRbtrhO97SdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> Sent: 09 March 2026 18:41
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>; phrdina@redhat.com
> Subject: Re: [PATCH v3 15/32] hw/arm/tegra241-cmdqv: Emulate global and
> VINTF VCMDQ register reads
>=20
> On Mon, Mar 09, 2026 at 11:04:31AM -0700, Shameer Kolothum Thodi
> wrote:
> > > > The VI_VCMDQ register ranges are an alias of the global VCMDQ regis=
ters
> > > > and are only meaningful when a VCMDQ is mapped to a VINTF via ioctl
> > > > IOMMU_HW_QUEUE_ALLOC.
>=20
> > > If the guest detects he can use a single VMCDQs (I guess he can
> > > introspect this by reading the SMMU_CMDQ_PARAM_0) how does he
> know if
> > > he
> > > shall access your so-called "Global VCMD regs" at 0x10000 or VI0 regs
> > > (0x30000-40000). How does the guest know that he is supposed to use
> VI0?
> >
> > The CMDQ registers can be accessed via both the so called "Global VCMDQ
> registers
> > Page0" and by "VINTF logical VCMDQ registers Page 0". And they are alia=
sed.
> >
> > The difference being(from Nicolin's explanation here[0]):
> >
> > "
> > The global page0 is programmable at any time so long as CMDQV_EN
> > is enabled.
> >
> > The logical page0 is programmable only when SW allocates and maps
> > global vcmdq(s) to a VINTF. "logical" also means "local" to that
> > VINTF.
> > ".
> >
> > IIUC, for now a Linux Guest kernel will only use "VINTF logical VCMDQ
> > registers Page 0".
>=20
> Yes.
>=20
> > The question is whether QEMU should also support accesses via the
> > "Global VCMDQ registers Page 0" if some other guest implementation
> > chooses to use that path.
>=20
> Yes.
>=20
> The point is that we can't reject guest's access to the global MMIO
> space. So, QEMU has to support both. But guest OS is allowed to do a
> partial map/alloc, so global MMIO page isn't identical to the VINTF
> logical page in this case.

Are there any benefits for a guest implementation making use of the
"Global VCMDQ registers Page 0"?

If not, the VINTF-based access path seems preferable from a hardware
isolation point of view. In that case, would it make sense to restrict
usage to the VINTF logical page and recommend that guests use that
interface?

Thanks,
Shameer

