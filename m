Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18945CCFA0C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJ4g-0007NB-FP; Tue, 04 Nov 2025 10:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGJ4U-0007KJ-Lc; Tue, 04 Nov 2025 10:35:47 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGJ4T-00027o-0T; Tue, 04 Nov 2025 10:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtEytg23GFTZgyQ8FR0lv3QdyFCcWYbd1rc06cNkfgrWadp4vd4FlZ1sYuZoUDJ2T/NPAQWIx0DQG9gDmPPtEX4EiWwBpUIZ2tbcd1Eq0cpwl7YlyIcLqd8I5QmCsJ0gdzK2u1Dsn+qBLGFOy9iSy2NRHfDpPINag4pq2Kp3K1LGsbOcrLnHvuHMJxJm1IuAw/IWMthUqABFiuI5UMaVk7VTaYrFJh4bACdQ1QQ4MWlSPzpxdnd62XKkhQjb9MJeEWl6ZaH1AeP+9goKIrXpjZ0oZKzf5in394mSw8u1MNaQzxvoWL/eNetTQS0KMG52qLQv3jaDQBdzEL47KvdCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2XBjztED2AZg4VzOCAoVYicLPgD5Gi7O2vzeYbg4vc=;
 b=FKswlEior7IZ3Ld3kmEqtbvoVOctxCgpqQBXLB4MOz8QW/KfvM3eHrPQm3A5OIkudD7fjNE61MssCtUpke6MqEQ3EoyvJdeWyOngmSDQ/gnfgUjOwIM9BLbR6fqtSDLAeXHnFHrpCT0XeAWMVY4henODurA1a1Vymp9c8OvSaGvnkpofjGttiiv9rKeK6RVGwcdWjEA7woYhbRQvBVZSwdqmOwDLwAwTplN6WEu61LTVjMqyJS14epvQdbZdR4fbGdwJNfJXU0brBe5MkgVBtm/Ou3sMsNV0tLJ7dUg2n95RvKelVE15pcPHwPLoZqlVEG3a/5aq/73i0Hxjhvw7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2XBjztED2AZg4VzOCAoVYicLPgD5Gi7O2vzeYbg4vc=;
 b=B8Qgd6cpcuEywqc+eW4SfZjAbj9aYOiUxcvhPh/e4HbCa1F2dW+wSHXr+DexX5dab3PkeC27BJLiZrZlSgHJj23pqs7n31s2FUjAMS5lCpVOfZ3rU37ojex2OZoODvLRMbxxnV6GG54sINvdBNjHp7H3cGeZoXioR/mONMItbnzIHQfBPpDczdgg57DEU99aV6qOwzGfucwTm5AU90Da/FgFLc/6o9+leCvjpy7GvBtEGZl33jdX3DljH71hh54wr2Hz8WnPSsLob7wVd7jYaQT7EDZc6IzgEJuU+tyhzeD5eCB/QE1Y4KadJNDQPstiaBdZS1KXxuIZSXbVXxiVYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:35:37 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:35:37 +0000
Date: Tue, 4 Nov 2025 11:35:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251104153535.GH1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 65716622-a9f6-4c96-484b-08de1bb7cd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l0TxeOeNWyNIMSDZJCh7HCXQaKD1xijuK5AZuSW1QZNPN9RlCmeGnc1ji3nY?=
 =?us-ascii?Q?fciTOXpz9KorQ9UlrmmYmJSum9BnPUBogLiHqBqRgxFtbtTaJOLN//ddZdKF?=
 =?us-ascii?Q?cq1IFXuF9SiHmnXFJBUoszhCzBXERvmPVOC9ZNoYN4mDIkPpbERnvQhqCyJJ?=
 =?us-ascii?Q?qq+VdJN425CfBpMrl/G4g6PnCAO/mhuRx7i5dVrEaTQ2b5D2unFD7HnYYtmI?=
 =?us-ascii?Q?FUK2A7T1lEJ/UszGlpa84wOWpydJ96l/QRkEe4QhUSx91bYsgtsSdUo5x65t?=
 =?us-ascii?Q?Ol2yikeupI5330lJ6RIHo61ldKJwwlsD3DAmB18lBfIVIf37aAKFpTcLkKD4?=
 =?us-ascii?Q?T8uE03MvkCnj6urQGBJHM1Je5iYSGm3IfsfM4rCTFUvBWStd0QrEhst0GH+j?=
 =?us-ascii?Q?NgcQBETOWvbkXOwXZLdMvszSq0PF2Nl4lTU9nKG0PcddK3uxa7sQNxQRjo/i?=
 =?us-ascii?Q?sfGjMIoJY8iyIlTKItyq+oDZYoOWy1J9iKmpAl3wQfeNmiPwpIKhqN7IDJJO?=
 =?us-ascii?Q?QXq6pPgXCiPIZr61gZ+TR3QU4wF5icYcnjZjoxHxIR+fmlq4KbvyY1+FhQgo?=
 =?us-ascii?Q?woG6r5wAaJoD2AFiDb6Lk7KuOcnhwK0IuVrD61lJPYtiyNpiwB4kLaSsqniY?=
 =?us-ascii?Q?+q/mG+seiGkKPMSqL9FBffltffZIptVEqcg24g1ZxU6hmv/X13zlEhOFnQ/8?=
 =?us-ascii?Q?w48OF3CiQcMGIAPGFZVYl3l3aZoFcS12ZXSOwHWUxNaPPXDxXe7JNstqhlJE?=
 =?us-ascii?Q?GzN3UGRA/+mka3PhIuxWzcd3rlvcyPJ6KKLEsuDbH4sMKVRi2Dc3Bw0ToBp8?=
 =?us-ascii?Q?okG2it53kBAow3mLTGqmOHqe1JNW8BmCoFauHPMzgVSiB4qAurgSDige6d+X?=
 =?us-ascii?Q?qaHFHTkyFlHKJI1XGHdjpRYphQMOjWUOH6AuhplBk+GOSaV5cUaLIplFroZ1?=
 =?us-ascii?Q?Trl8K0dciqc1r+IEE85B1+2Cr4AajNVXeUOYM/f/KBub2wacjH8llHZvLmG2?=
 =?us-ascii?Q?A8cWl/ZvzvpxCW2o6eV/RQDwK3rTQp5Y90p6gTy7wRoVfotxgxs/yCE/YPC4?=
 =?us-ascii?Q?TxkM2jZNWo0QHIGFV2ZDDQKIb3kCB8xebxUXBYONUaXcIclvkxyavAHfVj9C?=
 =?us-ascii?Q?ORZNDYWF5zGf5j4aezZ+RfNScRj3NwZh74VoL2VQEwwOEAIPH0i7jVy+QXbp?=
 =?us-ascii?Q?iUKLZWf/edxaYtq2l3dVntKQu83HvwUVGYD78OPbfitHONeISf493ct3E9lW?=
 =?us-ascii?Q?M7j8hS3lGPlmAfwwuweot5KNbvbK8/lF2N9tGHjZf7AQpz1jELvXy/BQ59xo?=
 =?us-ascii?Q?ANsY/WiXGcG97875OPJ5Tl5b1G6Cp21Qy9xXJ/73qpBuxX01MGJhayKQxjTR?=
 =?us-ascii?Q?La2G8g5YK5hsE+Pln4i1qEFhrdPmozKb/hK6TuRp0t0q7BoaqyY4IFhTpAoa?=
 =?us-ascii?Q?1WcjCjfb1KB6zYEFc81aciIvWuLQxmgR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhacPxzuA7WTITx+NC+vuzKwxlBwSix+chNc9JgDnEG6p4mJ7OjR9+nPZ5v+?=
 =?us-ascii?Q?hXzU7p/5DKzON3VfMQ0RoESXgPYXuicIPVP3j/hg2GEDU3sxn6XAuKJBEY8O?=
 =?us-ascii?Q?nbi2RFIzhc6vGaNE5o2jVPp85K/gOUabpeEcRdn+DdlztOVy0RZ69f81+XOk?=
 =?us-ascii?Q?ftmmPHgtyGD8oPmidwkUYADuDoCS9R2ah71cqMffE1sQKNdZtMUhEss/XFSN?=
 =?us-ascii?Q?VFEcyrqN8WUIADroxJrOKM77c1F8WZpTcNeqJR5mt4UgdFppvL7TJWwfgrNE?=
 =?us-ascii?Q?NysYvfFkW2Y0ROTQZonQPtkMZ/jl8dNCeiXpr/IakeOUlgPVr8kPfvdDli4t?=
 =?us-ascii?Q?smI/t4JuQ9EBayW/XjzUIxAtCsA53A1DAvMPS6RSD4cpQeTORrgtlo4Du/Bj?=
 =?us-ascii?Q?46kLfbTn6hSyaep5u8IHj22l1UH55U8nXug/Z6+aqUn6DBMupSEoMBn8bmvi?=
 =?us-ascii?Q?iaP1rj7shO2sAPWtbcj4Uxe4wnqwLmCTes737zkVD/5OZOHl6/Ie7VdmDE6O?=
 =?us-ascii?Q?0kPSTfw+q+uLT4NFtpxqjVl2z68tt2783S/FiLEq3wQi2/anTZ+AB/dJuKsj?=
 =?us-ascii?Q?rX9HLg/6/uc9wRM94Js5QjNrXqW4eK76sSPuSyTg8Mc2izp1t+HzHoZbLEj0?=
 =?us-ascii?Q?midVxI5268KHR/t5XAVvBVMAxBJnvoMKBFp8YV5jnz5NYqa5JZHhe5z59mJg?=
 =?us-ascii?Q?Xs14PLYrfq2MpXQS1C8zSfFXsL3EjOH8UH1c5PPq+50hFAReeaQP3APKiCTd?=
 =?us-ascii?Q?pfMJ45OTv/aO4qsadhIK/9k1zzk3jDyeEJuYZS1uzFIjiraxdc2bSJhewB6M?=
 =?us-ascii?Q?6yqs6LCO9kXeFD8sZ4hy952Z5S9nUSQL82/XbdnQWSGtbHFu0qszsVbLOnVV?=
 =?us-ascii?Q?DZnMwRnr0/0MgQC3CpZUhl3mn8YGkitZvRdu+A4eKYtog3Cgk03p515DkCSL?=
 =?us-ascii?Q?jTp2WbQ/Kug8lPGE2b8XfYLYqR2qnFYas8sX7DPcc2TA9IVYqWGDX5i40jXd?=
 =?us-ascii?Q?4EZ1bUtsPDtR1MHciSxlEPMtGTB1rIzafdM6F4SpNdWnu1vCLUMTPQGjAwLu?=
 =?us-ascii?Q?dftwr5HaUpZhYB9Ok28WWMQteU+7bZbFlflZ4F18ma4aBVolMR6MsXX5pDjy?=
 =?us-ascii?Q?SRP8M1FNHs1xjUMh95furjeYCJ8COs45SgJNHTcqCcrxoMmN7jhWps8RRd78?=
 =?us-ascii?Q?kUaN7vmC4jPK/X+3kPw0CKi/J76z+h7UxwWLDksNZ7c/wFuBlaT6l2aHQaDs?=
 =?us-ascii?Q?t04CwimyNsFlq4xBlJksZHo+HdFnjLgtY46HxXgH/uvs84OxKpjArHErpthV?=
 =?us-ascii?Q?Gm8uj5IluIkoePbNzaFGJmJrByM3dt3PnN/pVDvgBF2o7wT35I8ZLCrOyTMa?=
 =?us-ascii?Q?X+ILPGxkBRrgcJQQQlNm8eRjeAgei8juwJ9H1F/PHIJZbvYbfKuTql3yTCX3?=
 =?us-ascii?Q?daszY6HEWErw2HRMzJgPHrpiJLdS2OrVW91vDbg0LGk2JRHwfZyH4n1RKyPe?=
 =?us-ascii?Q?IDvocnf/UGQ76OJYqM10miuV1kclUZGFkNuNC+ps6o+Gzz15N20PNBwi888C?=
 =?us-ascii?Q?T/JsIC4chHbJelYiWLs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65716622-a9f6-4c96-484b-08de1bb7cd48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:35:37.7385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmIjA2cwJocanUqVClelNQECkt705jsw965xw+otKh/jDUQOC7tkrfc55+HgwFFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=jgg@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > it.
> > >
> > > Hmm.. we need to setup the doorbell address correctly.
> > 
> > > If we don't do the translation here, it will use the Guest IOVA
> > > address. Remember, we are using the IORT RMR identity mapping to get
> > > MSI working.
> > 
> > Either you use the RMR value, which is forced by the kernel into the
> > physical MSI through iommufd and kernel ignores anything qemu
> > does. So fully ignore the guest's vMSI address.
> 
> Well, we are sort of trying to do the same through this patch here. 
> But to avoid a "translation" completely it will involve some changes to
> Qemu pci subsystem. I think this is the least intrusive path I can think
> of now. And this is a one time setup mostly.

Should be explained in the commit message that the translation is
pointless. I'm not sure about this, any translation seems risky
because it could fail. The guest can use any IOVA for MSI and none may
fail.

Jason

