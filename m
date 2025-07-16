Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FDAC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6G7-0005s9-Ga; Wed, 16 Jul 2025 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc6Bx-0003Eg-RY; Wed, 16 Jul 2025 13:45:17 -0400
Received: from mail-mw2nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2412::613]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc6Bv-0003Dh-Ce; Wed, 16 Jul 2025 13:45:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS721WDHMLhrOX8dIMnmEcErNPdVsnfJiRc6JkN0zWw4yrPFtkyi6e8X0NSgHydJnbRqgZlu/dKEPG9BWqwPFEnahXQj7JbGu4ubKX38cK95ROptN7mvWDf5DHFUxfgCgwMlnJZT1mKAUQiAEwbK2dI8nLHQ/YzyETMXIplnjXj5JxiJGTOEPE3wN1wJ+ab+q+u2gZJ4TCcxsI/HEY403VURjuC3uTHnxttejS+opB2SWnkcZYk2VGPewD0GhpDfupDrEvV9d2KSSymt4goDwUYArRInXEHFc6F2AeiOrKqxCkKa8WvoBOMiQaLkDQBkufJbUQTUOOHC2EoxzKd9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBXzjFtdNmSKauTIxD4DSmgpEN7bZN+bR/SSvhbwhF8=;
 b=Wa2Mrty1wtwrw26haLoDzPhbc8KS2uZ0hWPGN/A1HecpWX/r1x1ilOeT02D6N43jf9T3SYlE6m639JGlOON+Gyl54hBWO1nf8LGq8CGoK8saxzFOPjdit/8PYPaHVW5NVde8D59cYxaN/AfpnHcHqg71ubZ3eRk5wHyCGeyv5/CZF0HH+c/ioLSIY4WRwEzNRcPn6uHG2d/ZNzp9B/hckPEjnm43ndneth16ZcqptBOMNmeoC4WM6b/cjk88sCks1fKITdC49GG2VR9sV8tgQ3fWA7TAWfEZPI2HLd7yBCw91HuO9NADmUaTLJLTw/m1Hi6EAw/WcoB4qJ1JlKYIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBXzjFtdNmSKauTIxD4DSmgpEN7bZN+bR/SSvhbwhF8=;
 b=jFibaUKK1TTfWletGZji7wPvVGCu/3Rb6G4ROUCh3fJUBfcA/CRfKh0PmQR3xxuRMfXFfxy0Yu0ybIJSV1KsSotLSh5qtfRIYESBA78ZTF7uVO0B30/olBXZeQ0e6Ees5JdVOLi6R9rexwgTGmK9nQyirAjvXdkL+RVjf9pSoOfn6XvxF22KC2a5IgTzlBBIlMY4eScz5YD/HbsJar0+ybBSZOb3UnRaTz9HZKJ9FuZW8ZT2cIvZhXGGKPWUy8AtH/u2Ec+WCYqdxBZwQPCx3U8r0Qn/wNYl8bB1gzGn/DWjbEQJay3aKlz/hmye6hN8zUFduH3pCQ0BZ86xJhjoCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 17:45:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 17:45:08 +0000
Date: Wed, 16 Jul 2025 14:45:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 shameerkolothum@gmail.com
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <20250716174506.GB2177622@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <20250716115123.GW2067380@nvidia.com>
 <aHfi3SS/V6qlx77H@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfi3SS/V6qlx77H@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:36e::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: e9efda6a-ad73-49d1-3125-08ddc4908134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TzRKOQGn9eP5p3W4ICyiGkBJ0XnGDIAB8+K/S2d6B9xOBCt4O1MDfO6vUtmu?=
 =?us-ascii?Q?lctlad1Zw/nMy7g46CWUnQdDdfNjsy4YxYS0NhQMvZ+STlPdsoBtoY6McEeJ?=
 =?us-ascii?Q?JgBhy3B1BYy6Iv5KlS+jn/SqnJyqiYXwELDuBoupm5lq49sXfd2JjShSr/71?=
 =?us-ascii?Q?yGNWZc4ssoyG2DEXUB/VXr3Nw5oIu3CiwMlpLotDoPmKE14IvJDtEX6SpD2P?=
 =?us-ascii?Q?w5jnRsGoieZzEU0DxyaZm3r7Q+3eChYjo64dIzHCwvZpXF00JEvqGQcZ8sfs?=
 =?us-ascii?Q?AyEPOIZ07zcxI17Yyx4Sa5BOyNPtEfQvtSfFaQqYwxF94XP7wJOm9+G07hO5?=
 =?us-ascii?Q?TZLBaqaT7K7A4QsH5qxAs5KsprNjW0ULK+PuSBZet/tvuFGuBa2zieopGGrv?=
 =?us-ascii?Q?du2yRo9vS/9YrfdY0MpLXe4Y2E+mNHH/1CycfJNbPcfjJ7P6qHb7MFlyY9Ci?=
 =?us-ascii?Q?W3+4Img/Xua5zX23GXBHYXXrybw0qLBw5hRVbcz4r1aO3LzCn03ip3jZQoIh?=
 =?us-ascii?Q?dgtQz8eaqWGSxEocxWdJ0Z+mHeWll9oPzZJ/ya5ie2FAYAwa9g503aJ+Q8y0?=
 =?us-ascii?Q?PHnm7ZoXyDbsCNRnFiLnKT86rZ7XTgd6sMIvqUVRkGyDawHlodHUNbcFw5g5?=
 =?us-ascii?Q?8V0ivNs6N7x2F2nJhfehDlUSXkVrS9cNDnCEgCfFKd/CwwKyuJqOXf+1sOyU?=
 =?us-ascii?Q?vy6avjQC2M+zaLY3YNWe4gvNAnHa9WtXpQavxARv4GA/dtuV04YFSJF8l7WM?=
 =?us-ascii?Q?yIDoJ/yTtuIYgAWkPTgIP6tseCFgBeWKjY8CzGVNgmVgCqUi4vYMyOWqfV1L?=
 =?us-ascii?Q?Zk0qBp6GP8rkybSdQH1gV6pKmq0XnE24heX08bE5HYz2G9nXjPUo2D104/6o?=
 =?us-ascii?Q?Zkw0n5ggT/1egV3YQK7VBx0yTpHwANnnn4BGAZ4pKJYlS6HfC3UKFcB9piit?=
 =?us-ascii?Q?pJC0x7wEXOPTBA+ITgPtfegWkt+zCoJvoby9WQbzGv9dpbd7GLVFZ0fLw7QM?=
 =?us-ascii?Q?G7XEF81NWin68WmvKntVm1ZSAe8GepeuLPZ0xu/Bp9SECov4U1x+TnrNKb/J?=
 =?us-ascii?Q?smXC8iTZIfKLzlVU0a6/1Bpoxj7LYoB1NGpfxnADMluW1oTRtE1DlljUwmoX?=
 =?us-ascii?Q?H8leazJAvZhFIzPW+4399qeP2AWrTswOvBjPXBjwKkKbyaWx/PgI4mEm0138?=
 =?us-ascii?Q?9Z6f5HmkJTNyMKnV6OnG1aZuLAPp7jpyZTNqlFSMeR95IGugzpMbV9YI8DAD?=
 =?us-ascii?Q?dHKp3D+h7+ARIu29bQxxChuvKSWglQmjkcSWcK9+3rX71YeqoqEb32IwmNAM?=
 =?us-ascii?Q?7bPhheSiu2e77gyhi/HLTI+Cwha0vJSBaVyidY7wbY61RcR8KnG7VeGZmhwV?=
 =?us-ascii?Q?Q1xXZWS2fq3CCcmuET3a84HGMywAtTlA/R0kVLWRo3RK+fPla07Z0wl7nXL8?=
 =?us-ascii?Q?YyVhRaiu9QQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwDUWvn2Mm4p2FZRI4f9biqLENcczMXjC3Dd706YiSxCArovdoAL7/uvrKNt?=
 =?us-ascii?Q?B6w/nOY9MBEdD8MHQtxQqD/5C3K+KKYDb8pJLo5+At5OCLNtpwYILtApSdU/?=
 =?us-ascii?Q?ppTSIxAjOud9mSf62rVVJ/vYTNi2OPs/gtfeAu7opr422X5k6UcFAeJbIpRa?=
 =?us-ascii?Q?9W73/MedSAA4eAgX6xwpef/X19dXPtPyXMJincghq1HKriv1fpj0div7lJoj?=
 =?us-ascii?Q?vYlqyc/0Hanvh6pvX0UwnbhTaaBPPNWW5Rp+VFp8qe020wLyenLiZtV8adOr?=
 =?us-ascii?Q?qhxmji1dSXo09BVBso5OSP5LNExQwQCqQ5YNINnVYXsHWSvMCf5kZWsgNnyD?=
 =?us-ascii?Q?UJs+tsn7jXxP1/EYgrvUNQz8I1qGMo3Pjd5JzolQeWx36VLOt98TiKisWPPt?=
 =?us-ascii?Q?CiGPHq1kBU/w5LKA3K9P+JcWGQb4NUOnaGrz/aTgZDT1TcNwwNWzGPpiCiln?=
 =?us-ascii?Q?t0P+2xpv9RyflN/CNfU5BNIi0jfzPo2F3SeOK1bgMU+SbnlHzAYdrsWei0/K?=
 =?us-ascii?Q?p/yZQL3zDVUmM6+0q62pSMGToxfD7d1tpKAGLBwpM/KOoDyk6+bbkb1x4XFG?=
 =?us-ascii?Q?iE8/5dHKnmWM7EZaHUGuvQ0eKj3Hm7202AavH8AkhZvkMs4KGs9HP18XhYSA?=
 =?us-ascii?Q?pyqbsQmssY1v2Sndx3fyb2pEQyG05coFgKLJ5T7tZvjYo6eAgFzNK2BB3Oaa?=
 =?us-ascii?Q?DtfI4pJVR1ON05AAef3EljSSFQnv9TxG9yVhPDZJJPqNPDZwctdTsaUrbgvJ?=
 =?us-ascii?Q?MIKtFmBqa+ulBNcfi98MGTqWNe4GSclOuYQk7Nhdu4tuxGJOoYjgY0SDzHUV?=
 =?us-ascii?Q?JIvWRrnerpvS4dFuuRdxjkrQv3RkrpZyd/5gZeM7hXv/4GbeCfH/a/DHi5jm?=
 =?us-ascii?Q?i02l6TEWxVMQCEmgCNjGAKageAe+QlJGq1vwOZHViGlPtv4ds1HuYqD/q7ma?=
 =?us-ascii?Q?UlF6vsWBhPijWcrAyHdtS6ECz82D0anmuLSLw4ne9DzZsFkx3E6MKVz8tl5T?=
 =?us-ascii?Q?7n9+H5xTJQQIldPozSv78YdN65tS5YAxpE5ovsgZLngoBxizfz+yVd2TJ8Vz?=
 =?us-ascii?Q?GMXu7xl3HQ6KU9jZMXDPKNzcx8xXei5FcDONyRucibaOtrF41172vPk9Rxer?=
 =?us-ascii?Q?WIMUugQOS/U76FBDTT6UQi4BY7323Amvp9bDvgLysT00tABiju2ET7aj/+wD?=
 =?us-ascii?Q?AK77cI+6xBUiVEdhKqZ4qZTtoKyi8f6BZ1lAj6Q/UOgvRORNwoO0Pimanv+k?=
 =?us-ascii?Q?HKEPZq1iTu3EqXhztwoN4YeHnG8y0S23yHPWr79UEHmlSafnBsshENKdHOBA?=
 =?us-ascii?Q?JiGg8gYlh+IN2rvNXPWutOOFYssoz1uBuUj0aAz3T7vXGCsR4Ai772VCXNsq?=
 =?us-ascii?Q?1mE6veG1ZEWyDlw9GJooMr4hv2twb6OaYczqorq61a+SgT2FjZLpk26t7YD7?=
 =?us-ascii?Q?SkJKG15t8QsGN2qTbTj0OA7Y4zqENd+8qdk4uB84yjG2mfe96JleBasj9frE?=
 =?us-ascii?Q?anlyC3pnrD+59RBK2Tk/hj3nOKrzbr9MlJ+ggpgYrRfCWdXok207wJJytenW?=
 =?us-ascii?Q?B7ie14jGhPEqVu84c4Su31jaeACLdUwv93Em7y4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9efda6a-ad73-49d1-3125-08ddc4908134
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:45:08.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN2VgxK0R4lv0yXXw1/Tjmgd92Gq2VR/gN6S/5OF/4U5wE4J6Y6VdTVnoxy0mF5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
Received-SPF: permerror client-ip=2a01:111:f403:2412::613;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 10:35:25AM -0700, Nicolin Chen wrote:
> On Wed, Jul 16, 2025 at 08:51:23AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 15, 2025 at 07:57:57PM -0700, Nicolin Chen wrote:
> > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> > > > +    }
> > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> > > > +    }
> > > > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> > > > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> > > > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> > > 
> > > Unless there is some conflicts between the QEMU emulation and the
> > > SMMU HW, I think we should probably just override these fields to
> > > the HW values,
> > 
> > The qemu model should be fully independent of the underlying HW, it
> > should not override from HW.
> > 
> > It should check if the underlying supports the model and fail if it
> > doesn't.
> 
> For every bit? If there is a conflict at a certain field (e.g.
> VMM only supports little endian while HW supports big endian),
> it must fail.

Yes every bit.

> But here, I mean for these specific fields such as GRANxK and
> RIL (range-based invalidation), we should override them with
> the HW values. Otherwise, the guest OS seeing RIL for example
> will issue TLBI commands that the host can't support. Right?

No.

If the SMMU model does not include RIL then RIL is not available to
the guest.

If the SMMU model only supports GRAN4K, then the guest only uses 4k.

This exactness is critical for live migration. We cannot have the IDRs
change during live migration.

So there should be some built in models in qemu that define exactly
what kind of SMMU you get, and things like if 4k/16k/64k or RIL are
included in that model or not should be command line parameters/etc
like everything else in qemu..

Jason

