Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190FDCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLTb-0002Nq-Mb; Tue, 04 Nov 2025 13:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGLTQ-0002Ak-PW; Tue, 04 Nov 2025 13:09:41 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGLTO-0003pU-BY; Tue, 04 Nov 2025 13:09:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJlSDWM+uk13TkcYrqIxUE8fZvn1KiiFL8aGEMaop7j2bLOSKQVWqvuAYLLCF82n4+NtyT/7VrGsepA7ProZS2hOKT7/UOSWMIfOWd8crUQMaV10bywVHfc/8d1N0jco0dV12dAmnKNNPmmAh8+8rIKEuW/p7ASbkjIQfc4W1rqTarKypm71CuQXoXlaV2n6/lbmirywWGBV3NJgJtfwe/R+wh+c9sznKzuibd/gxgtyV1pVIIBpvHRbZgGkEZqsa6rO4/pdxS9G+Se4EH/Gzl8m16EPXNkQ/Z1o+IDqk7XsfoXxpkSnwhVyKZxY7CS8UKwDndfeWD2ajd00jG/Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBpBqRvYwj4XIKAtQw9zMHPi0M/dD1Rxp8XF77NHGC4=;
 b=T4cywHCVq6wIm8PO/6Mek1sZMVZA+D5Jv2SWglhME9LxtghgBs5Dooj4ZDM51GGPMGgua81uo00ZmIELBhK5BBSVsGK74t73B9kDYBRUm27MIC8NAiU7t8hocEU4NfC2ya7zPEPFfOuCfNbB8SYGqdrw+2GcfV7vBsfkGkylHqtSHgn89CWypuoFv4b8t8AHlnsFWwq5ET96hRILT04HK3c83EcI1aB04BCjdW4nJcP8rWkVDngnbSJIucyJ2Cjujs9Tkv8/4V91dAost8baQNbYdBjGA3bvm1xsAIoy/6Sf5QPBdfcr9EO9xKroXjzRA67AvFaPs6UtASZKZN2btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBpBqRvYwj4XIKAtQw9zMHPi0M/dD1Rxp8XF77NHGC4=;
 b=SgbZoND+u/hyPExhwmouSGj8MGzRlQujYMTJsZt2c1mGfAYJnZhvB0u2jMvwa7QJYuE2NeOmOJCq5e3v8xpjX7EtvmVP1kAkRZmsFHHhF0ZTZVqfW72O4hETuH7WE9f2eAeEYjF5uVKJKs9QnuAuM7hRdNouFxJ/01++dRYuFXfzYEbFKH1at+L9ONTUI79iRrUG2EL5foKl/h7dhUDQ5GcnomZy524WAZlTPUgUTotmDAsudizHBk3PufEd+1gmpVXUIPEJF/SSZRLkD6rgaKpnLQSenU8J15HABh/qpeUuchoFjmAsaYHBGAdDRw+Yc4rIHiKNO7Wsg/N7Fwc6Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:09:30 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:09:29 +0000
Date: Tue, 4 Nov 2025 14:09:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
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
Message-ID: <20251104180928.GK1537560@nvidia.com>
References: <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:208:120::44) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 64812516-4646-445a-22c7-08de1bcd4c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2mHqoyRcigo8Zjo8hx0/2o3X47+OC4BFfOXYyafEdwJ4nxskBJCZFNaxx6U3?=
 =?us-ascii?Q?AtIUetTDUTi8B2yt3UmU/yGkC8wpYWKRD3qJjI8M1ioCAvT67ecbf2myF7qT?=
 =?us-ascii?Q?iEL7zK47o9P/UOosu7+tId79jdrk766jPow332GLIVxEzx0oJVN9IhGJEOg5?=
 =?us-ascii?Q?JbX0KzavRvrllH2P9B2UA7clhkYmgfkLqzVkRX2bsuLx7WgXDDhqMbxTgV1F?=
 =?us-ascii?Q?CadYn1RvVL0zt+334rQfZ1Sf6BbikQcH0RAZxzSOOmrifB7EBYt+AzSreoIZ?=
 =?us-ascii?Q?uZRo256yRsajDYdRDvgbjnjEoxoHae0R19/QvwhmLJ8fqKvNATbDW2MkBZqj?=
 =?us-ascii?Q?qRsW3oTg84s8+zT2ZHVM5uH93Y+tMZWNYB/ZQjmrlWqxQFKH23ipp9e7DT+4?=
 =?us-ascii?Q?BcibSdwWVXm0STMm4EJplASicrFYpjVW6pv8XfUKAfW4ai24KQMMzjHNGcII?=
 =?us-ascii?Q?zb/C0FnUNcd1tyRVj7Zy8cetx5WDR/dlfRVx7WZXn43IEKqJf9Izjf/op6Sm?=
 =?us-ascii?Q?bJSTSdtCSKqesPoNdpLM3ziTzMjLziZh2al8vSsKgqRYJ8Mm18JcU79tFbfM?=
 =?us-ascii?Q?uoYErTiSklfJGpX38DIr0jVn+r5JvfyHceQvRWusrxk5gtvuu8SM8qnzah+j?=
 =?us-ascii?Q?yzAHiKPIDoxWsk1oSegiMFyVimWqJ4hMo92fqNimUjrpt5PeE/L+LR2+EVPG?=
 =?us-ascii?Q?fYARfSVL8LtB29oPHVJRUMgnJp9zAlXKZLTvFGpUshd2uFVMOZrNjuvJPtLQ?=
 =?us-ascii?Q?KM4shG0Neno9J2DEMqy55Qz/+JUlVVFhEQF5rECrAdbp5bOipRdKRUrMZzdl?=
 =?us-ascii?Q?UitVZgEeRSNd4QLuVjBEw+2imA/ZEXf0wVlxw/Qq2wT7FpsQCTtYWIYWGszD?=
 =?us-ascii?Q?aw34pEAs6KTfjWpx49IHZvXCuFRbCmzo1N/zBh4bzTWRIo9rsMtyRI7QPQ4c?=
 =?us-ascii?Q?opr6QwpnyuQQZylJmM9VuRuZtZHIkkJh73FwfCeVkXY2IJut1wHYPZ+2AsjY?=
 =?us-ascii?Q?YRdj6REwKhkXBMYZ3gRr2lUI5TvJS6fUEBLc2yF5+W8MrDAG5ekcRBWDhLzz?=
 =?us-ascii?Q?NMEynHIq4/QjOzaXrHBty9Vn1V5/fkfJDyuOuR1hnHU5ao5fjX/XncxiT+lw?=
 =?us-ascii?Q?djEGmf8XrlW57pKr9A7ssOfyoyiyjY4KarJbW8Zy4JsBCcZSxVg1Sd7SAdS/?=
 =?us-ascii?Q?67W/UEZNgkdhBCv2QMQBO799NvP+TUiZmJrQAZD5J2icnNvEpsDt9yKcbH2W?=
 =?us-ascii?Q?lETp8+kyiszjL0GPOU+ydxrQAd/UeI3KvCaf6NOB/F1JipEFxjXmw3CCR3T9?=
 =?us-ascii?Q?wQO962F6TeDleDkRujnfjFRitM7Au+tBaY8WE6JeGoBt8lb8WCXHiKnNm4Nz?=
 =?us-ascii?Q?TbWAMWxpOFPMxQZQTH9hKreGCQS3MVPQCbrfBe0cGB76JC3G9mZQNqzDyd7b?=
 =?us-ascii?Q?Oe4sbSBCKWoFBS4Z3f0AsFKiDuoNcE3F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ae+XBce6cwZX5BCo2W2GeZUa0bZhWp54fvMyjiU2+PtgV0tPsp0VRai0BsN4?=
 =?us-ascii?Q?gTuRWqiMPFMmIZzUS9wO+YS1YOSHw6gHx2Fl0moDxDiaB1YPS2sLzk3amfys?=
 =?us-ascii?Q?6Y4Cic8j5eyFwReVeq4rrJyUA4N1e+cSj5/pvuAh04O2dG9y8KuHbrhmJBJa?=
 =?us-ascii?Q?NUa0/lgrhXc+V8SpCbc4YGOQA/7x7TyvQ6f5kQUKOV6jqI9UHGxG7KVm7K9Q?=
 =?us-ascii?Q?FmTupCRgtlM8rwuo/TQyCducgorj8rBxfqCTXjfrB3LEsJFYxwj30Nq57u6G?=
 =?us-ascii?Q?Y7vFfGI4wFWg+JbjxUM/TGFYcrlUaIWiPpkcEjuge0ca/av3KwB+kEBKT72t?=
 =?us-ascii?Q?eduo3zuGxfceQMw0i9WINxBp1k6w242Bfr709he31d37CcODxRxrmVBLB8m5?=
 =?us-ascii?Q?ba66WvemUDjSTWTL+hqs8NA41kxY9A+PVbGhrwYgGEO11FMRvtSHDHn/t8sz?=
 =?us-ascii?Q?z5h1XjTBU1Wj38zzTZhdb1sHoFmKkxqeByRdjbcrMtO6DinxXZWT8nmEajit?=
 =?us-ascii?Q?KzfpeUz7gE1h9bPvI2R++KBu6UjmdwdBmhFitrUzBJLhHjJhX9+KFFdU3MfF?=
 =?us-ascii?Q?PzdFPftnlxsZRgcpCz8SHyu6GMjJBC+ZvV35a5sdHObVoERS6QYFfXfr4FKr?=
 =?us-ascii?Q?VcNtK+9Z6I9bQMLt+Y2kA1+YJDlwRKOwZo9qcAvDEzRBRHvoo86AJY6hOP5g?=
 =?us-ascii?Q?PxnF/Tq0rl/j/fNnD+dLfrdIkmOkHTKahD7rMnj/WAlAzmipyvD3SoMpEQsq?=
 =?us-ascii?Q?/UryDZjVhlATM4wyQiFlaQ2Fgt0W9Tuk4HMDpfvAcj+2TK7CUWRgD220+y7q?=
 =?us-ascii?Q?HI0TJRR6v3MjVHT5CFtRHB0v7vJuanNq1u5HgexDiFh/IvTxYkAo6hFBIATm?=
 =?us-ascii?Q?oNFCCbygv750wqgtFGZxRaJvLTuDZb8LbfynwveX6/jP4lZZVTnKshrUyRth?=
 =?us-ascii?Q?JFauedUpTDxOqcs30vEcJGBNC5EiynOdXg4IBZeqPI0twe4+0P/c3B9ehx+2?=
 =?us-ascii?Q?Rn2e9nlsQ9dFBOjJzYvvuB88WqWyEzo00BB6jQwG9/g4ui9nQJMeD9KjdCez?=
 =?us-ascii?Q?P+wWK0aTEFHsflC96wH7Hy/sYW6XXGL0ccrRf5z8NALFwAiZQMiQ+2UUCNN+?=
 =?us-ascii?Q?PyEI13rRhklcNrQg9wWiHVq3iOh314Ulsm92GXCHiue20sS+nc/TMDisWWtJ?=
 =?us-ascii?Q?K23M5bSlNapnDDaREIULE4BobVw4M2hX1FblUulRhjpYMZWYzOmw5gkEsudI?=
 =?us-ascii?Q?ufKphphIpsQ3XdTkca5Rjoo5N4JMm2DRX0HlvKrDXMxjIyzfprILK2biwLpG?=
 =?us-ascii?Q?2O68lCAR+Md6eKW5g5ssBPc0LzGE0EOgRKROmQW3Rybu8+pyqhv4jqfeVUOC?=
 =?us-ascii?Q?phnGSlAo1a+UflB663120BQmyXAK0H63jLZ1ULHm3dbPvmcH7eylFhpgt531?=
 =?us-ascii?Q?B7wKmexljU5B+TLboZ+IsmVe2z1fRB2+kCduXCvMUWf96BFALC3fhAO5Oyhi?=
 =?us-ascii?Q?mWy7e74QFT9tDE+Nd5pKrze5B00bLV/4ebNSElXi47MWJKnGqblUPjOs+OC1?=
 =?us-ascii?Q?n8zNKDC8TXnyX1ZDuFw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64812516-4646-445a-22c7-08de1bcd4c18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:09:29.3965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7aEoGwxFC8fOuxLaVmuaQVbA8a4Kka6xYTme+2G07txFRUnmqSFzNpMxYZnpZY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=jgg@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 09:57:53AM -0800, Nicolin Chen wrote:
> On Tue, Nov 04, 2025 at 01:41:52PM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 04, 2025 at 09:11:55AM -0800, Nicolin Chen wrote:
> > > On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
> > > > On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > > > > > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > > > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > > > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > > > > > it.
> > > > > > >
> > > > > > > Hmm.. we need to setup the doorbell address correctly.
> > > > > > 
> > > > > > > If we don't do the translation here, it will use the Guest IOVA
> > > > > > > address. Remember, we are using the IORT RMR identity mapping to get
> > > > > > > MSI working.
> > > > > > 
> > > > > > Either you use the RMR value, which is forced by the kernel into the
> > > > > > physical MSI through iommufd and kernel ignores anything qemu
> > > > > > does. So fully ignore the guest's vMSI address.
> > > > > 
> > > > > Well, we are sort of trying to do the same through this patch here. 
> > > > > But to avoid a "translation" completely it will involve some changes to
> > > > > Qemu pci subsystem. I think this is the least intrusive path I can think
> > > > > of now. And this is a one time setup mostly.
> > > > 
> > > > Should be explained in the commit message that the translation is
> > > > pointless. I'm not sure about this, any translation seems risky
> > > > because it could fail. The guest can use any IOVA for MSI and none may
> > > > fail.
> > > 
> > > In the current design of KVM in QEMU, it does a generic translation
> > > from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
> > > has an accelerated IOMMU or an emulated IOMMU.
> > 
> > And what happens if the translation fails because there is no mapping?
> > It should be ignored for this case and not ignored for others.
> 
> It errors out and does no injection. IOW, yea, "ignored".

"does no injection" does not sound like ignored to me..

Jason

