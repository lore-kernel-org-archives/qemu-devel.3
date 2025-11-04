Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984E5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL2i-0002f5-SM; Tue, 04 Nov 2025 12:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGL2g-0002eR-3r; Tue, 04 Nov 2025 12:42:02 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGL2d-0001dE-L4; Tue, 04 Nov 2025 12:42:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kqdp3kddX6cVxp6vSenakm843l9v/6+vAYV0OYTLp1C5phTyQc4RQeGmzu5G2zQ5AAUxifSdtN2q2tqs1Lja3xIhqBPeuDJLnOn821G9r0dGgRw99wmwbpjsZUfRHcgULi/2zzxsk71oMZC670qPSxAPYxUa8VDLp7TqWwD5EUvt0LOqwjoed/d2mRVEMwj1gOyXaAevu33mwKP6Q82HpLFXq3cmtz66qkXc41pYBXPTkufYOztul0CQuOFEvAQdVIHD6m1pZrGNLB/K/Zpb3JoSAH9uhxj1XgOktqKzA31btT3YFeljskPY3ZPbfr74K7oNTDNt9qm2Sk339aOAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am0VSCqlt2gjgZN1M5Zy3sYbkPCMY0iCC2bqlVI0dU8=;
 b=AA66sn1lZ5fDH+ChtqYK+XCi6OeUUPXwU2gSHoOmva1dhem9vSYLDsUTKQsiVV0Jf31UjUsZ+SxNVsSZTRTAEHrogIQ5FH8xbD1V3hbi6+BwCMdRgweic9SAsbrKaaho6JsASF/wJWQLY4FkCcMtumqA4m4tP04dUq2ZkT+tE2aGAc967UnMtgbgdkg1SfhgnVn3LlUFRdw9edVlgrzqRHj2e1D9AoKROTqVf+Cb3VZRLVhoWllK8Ht/3vAoiZ9amrJMgM2/tAx2g4IATCraFCNxqdBA287bqdynP7rqDybOdD14UQSua1tmktY9zKeDlb4XlolTCsaJKYfGoLR1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am0VSCqlt2gjgZN1M5Zy3sYbkPCMY0iCC2bqlVI0dU8=;
 b=JdPMVOnFbcR66KPjsAI2HCBtzKQ0GWGr3FxMLaErRqOHUkNDU9zTV9BNYm8ngfxpoU8++3Gw46+JSpdOxrXpoa3gtH2wKSJQ/v5iBINFAwVlCQoSoCYb61iU/eQYkmTRyvmBv7Z7vDmyH2KmhPqzY0lD0h6BxlGckTfC4yrA3JOIQX4n/hQ8APjg3aG+A0wv9X/aokY/1WIg8Q/MWevcBqosPKmoIWSMbW4VC0zqLbfccUryX/FevVr5+3kFe2P/0aQO9Uq2dm51umGSCAYXFZuhNfHcI506RilPS3o/jt9jSxnHzWNFKiME3ZkkinWIeI5/FUoVkG74vPbL/ioISQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Tue, 4 Nov 2025 17:41:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:41:53 +0000
Date: Tue, 4 Nov 2025 13:41:52 -0400
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
Message-ID: <20251104174152.GI1537560@nvidia.com>
References: <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:208:234::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: feeb606a-9580-4095-6722-08de1bc97104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wCsN84kPLNm/5P2fiMAI6lhRmYbNSEZvDFLlwb2JNz0pxFbp96bJlTFnxmHM?=
 =?us-ascii?Q?SdrYMZXMvoviZAYPrXadruqNFl80kjMDAARMsw8QktOk8QrR46IsErYgXkUL?=
 =?us-ascii?Q?9fuXRKB433z1OZDD8chTHAynq1ry0ZL2pPzYoVrhZv59LGzF/LjyaAoWaPgD?=
 =?us-ascii?Q?u32RvoujAx1ffLTlMMqfaTJpgnY+HS+3RwSvDdSahtiSLFPYkyCBNsSAVcvs?=
 =?us-ascii?Q?ETeZmAnqMr2+I3bel4dBTrOO86pw6XbfbkAi66IkHafOzJkjeMPHl+WQBYSx?=
 =?us-ascii?Q?43JivCA02ZMze546hfC6uO3C0Ep8IdKv72g46WFljqqXsCwayFqTgYL+I/M0?=
 =?us-ascii?Q?XnHAqtB17ZxKS2oDSWrrRVu9RwSs7YOaDzUuMf7Vjxfs83+3QW4cPyM6kvHE?=
 =?us-ascii?Q?bIgKZTC5RJHl8XsC8XjEznjn/2PqgEydlcYmfzaoAXf48MRk3ftAozBB6tfv?=
 =?us-ascii?Q?AKy5zCCO+jiR0dVe8nCPhK7txveWs8UNQ2XJhgIgxVXUspPlNB2GcOrkaIHO?=
 =?us-ascii?Q?8dZfOeHyQGM/ZZrUtuR0Noa78ZKV9SyDS9iq8yz+DBoRTbEE4lBNt7/2iYFx?=
 =?us-ascii?Q?jnojdqIu/OYVcYIFeiutAm0edOc8v/4dY1w+tU1jy4DZJQECqXAspZyI9ioN?=
 =?us-ascii?Q?wAIBAf/cB8M1Vczo0haQwALZUXlUalQ/lGqmabf1KMy9JtamQFqbOoOLQ4mf?=
 =?us-ascii?Q?oTiLip0JPF+J1zb9wQXZ8kOmzb8YKK2gdqThce9G1bkqMaffWB8QF9SVVeUR?=
 =?us-ascii?Q?IZLESBGJ0w3u5s1nhCJDJ3zECHecAXs2ZS3nh5OfIwHy2nEScCouYulAIGLm?=
 =?us-ascii?Q?E1J+CWKgrxJdgZYK81uGe7S0wevhHHXtysb4U4d/Rs2PPdvSFuFKRIpQ10ss?=
 =?us-ascii?Q?JV3XW++3e7N7Acl8nvf2GUvAvcsorl+iRhjF6NE/pxOUXpJReVrFi0/EqDtD?=
 =?us-ascii?Q?9ob4jwlCQV1pxNw3pIIcHKZIMqGqxsmcmG0ITzv6dhMxwbZJ2uA1t+KmIVGq?=
 =?us-ascii?Q?c51v7MOr71Pb4wTQhfTN/wTC8TLK/VlJed6Px0nNZEbMv81eSVwRtMHm70Z/?=
 =?us-ascii?Q?Q190P7gVOkpm0OlMEb5pQga/1/IYzYwkmyQTmFcxvCuAeN9Romapz3ZiKKLn?=
 =?us-ascii?Q?yHnn+UQK7uw9NPT8gWTyZfhRhc0PeWiKAGupMrWM542KygbcpBMbfY1vstyG?=
 =?us-ascii?Q?fUIpbj6/rcxvDnZn/tNkrG7UWJb0MM0cos906qVe8vPtJHHr3mAAc2JEsgDQ?=
 =?us-ascii?Q?XOvWBg2Bae+pXsjxSlx/hThUm4bIVcZHDqcgh4knGUpX04GVjEuk6/+r1gpC?=
 =?us-ascii?Q?VhjLPFTa/w6cdo8hRUwALqVuJsDkC+aDXV0dLeLCx3IXj/nL69rUTxdcEhkm?=
 =?us-ascii?Q?vUKd7Tuq8ahnD6qNaQIYIZbK/m1Jp+hLtHU+TKxWBej5D/bf33u2MGACfoYX?=
 =?us-ascii?Q?1TTCT7FPAjHNSffYU4VFf72sipgQyRWQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlvMipUAd3qT6q8Y0FyfLj5+krJsQDubDYb9iUQLpvZ/i5z5aE+sNJptDyvU?=
 =?us-ascii?Q?5q//jW4NCytUTLKlPX6tvosClxQ4vpRFK29N3WXOeC04slGuQW8hSmxGglCh?=
 =?us-ascii?Q?dsN0Oo/wn7MWR1Igzriy/XjqM/3MStsxz6Pg8wZyAUT3qqFvg2edx4f8Bdu7?=
 =?us-ascii?Q?2WnDwNLt+QK6CrgB5VD6sZBGK7zP++r993LpFXwx1TzzHvFxsZJ1vPH3fa11?=
 =?us-ascii?Q?kPv8YimenTIJt4PgB+j/PpZDQgGQzDMJPoGUS5GBJ/kC1UTa1KRqfBWyE+NP?=
 =?us-ascii?Q?9ZDaWP/tkdcbn8zb0G6Fbz9v6SIsgOkhpFJgpcUBmJ0/e6B/2ieHCKooGLcH?=
 =?us-ascii?Q?6VvnYew/yZ5VkPuIWKlSpnwDC8SCIMrgEmoSjW8pibb3jlRccbWF2hMboM0f?=
 =?us-ascii?Q?EojA4UYndi38Txq9dWpe7CPj9+zsmuKAYwUOaP2jeUuChJggFi09CpHR71uP?=
 =?us-ascii?Q?8q6h8rHuU4Xz2znjAaUF1jL7VIx1wD7MtiUCIgkzZJ2G0XrfYqVz6z/ojuVG?=
 =?us-ascii?Q?Q/VZTj0ArpUa6HtmWx8YObflVWWocE608brH7ZGsY2Z5ugmUtE8rQrcoY0la?=
 =?us-ascii?Q?0NfiiGuGOm6BHzp0rsfqcAcvGZ01bBs4JLzX2Wti0UEEJUw5vaxI97U1XTvW?=
 =?us-ascii?Q?OsQhrAyMV8NwCub4JYtal+btReV94yBDSS6PaU8YviTfIw4Kfl9jr9K+M7WY?=
 =?us-ascii?Q?km/wbvNGQ/UKm9tfaXkCthIxYD1M7o+TLlw2jSdLB4mv/xNEIaY/wV1dtzbF?=
 =?us-ascii?Q?njUlPNJLTm6GK9jNQw/0ON/3YK/rS30ruA3PYqZlfY0Q/ZOPdokKeO4fDRAZ?=
 =?us-ascii?Q?+sIg9n9PjJs9x++DlCApzBFrm/qTGiKIZZlOyPWXPAXBsq/dQ26pjwWVQCbL?=
 =?us-ascii?Q?7Bb+/p0jJnMQYUbYH8if8kfWIk6Ev/gt6zIm6VvDIJ0t+HlfWpbp+EpeoI+X?=
 =?us-ascii?Q?gRiBCtswR90DluXI8me4cWpCAFGp/z20eaF1pu0Lk3Fd6bljL/hFEjBGive9?=
 =?us-ascii?Q?gtm05Wl1pMgsc+P4Km/vLagTWZcum5MbwDea9sPq6ngyVmi2V4wSgaJDs8cu?=
 =?us-ascii?Q?/fXGEjV3HaG2ofSvYzVYUPSbebgCOYoLzkHYxy5fuo8XWP3pHPjeEru+k0QQ?=
 =?us-ascii?Q?+auVRiKiZrZiG5ceuUXyNiT1MpBjanQqCnFEMGP8yZTYKEBPgNLTI2nGXLz5?=
 =?us-ascii?Q?bQpxm1cdqtSQ2YbByei3k4KYjIt+DfQCputb+hkW53Aq0GHrGzYZoLva4xGG?=
 =?us-ascii?Q?XQza5nbkAsmiAsrFhDWX5WhjiVN/GBnHrsSNfMs7ZRKJ3beeljM+gqYDeMFu?=
 =?us-ascii?Q?zxH+74+OMO0Rv+6UMhAD9oqLSBj+GaLMA8JPScD7fboTEBHRM0zG9GQIqqyH?=
 =?us-ascii?Q?Zt5K2MAvXrrLhMVItYSoS75VG8j9hJDOu6rEd6xt7y+zeov0Qad5I/ahzjFV?=
 =?us-ascii?Q?gT54RWo1esPQ/eP3HEl1DRebsv6hbUIn/ekUxgVsIo7C2nhdy+mMhMVSijuY?=
 =?us-ascii?Q?KzuhqpWs86inO8H6c5vO8ErchIEe1oHMssYYHoCQN7FbCC0XQUuVc54UeM3R?=
 =?us-ascii?Q?xL382J2N1HEmm3CL388=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feeb606a-9580-4095-6722-08de1bc97104
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:41:53.3518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZMqWFyn4whAPxquAqKvxpo1w2BjLDFaN+pVNe4sHNh7hSpxg4uffn9JHkpbF5H+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=jgg@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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

On Tue, Nov 04, 2025 at 09:11:55AM -0800, Nicolin Chen wrote:
> On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
> > > > On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > > > > Sure it is trapped, but nothing should be looking at the MSI address
> > > > > > from the guest, it is meaningless and wrong information. Just ignore
> > > > > > it.
> > > > >
> > > > > Hmm.. we need to setup the doorbell address correctly.
> > > > 
> > > > > If we don't do the translation here, it will use the Guest IOVA
> > > > > address. Remember, we are using the IORT RMR identity mapping to get
> > > > > MSI working.
> > > > 
> > > > Either you use the RMR value, which is forced by the kernel into the
> > > > physical MSI through iommufd and kernel ignores anything qemu
> > > > does. So fully ignore the guest's vMSI address.
> > > 
> > > Well, we are sort of trying to do the same through this patch here. 
> > > But to avoid a "translation" completely it will involve some changes to
> > > Qemu pci subsystem. I think this is the least intrusive path I can think
> > > of now. And this is a one time setup mostly.
> > 
> > Should be explained in the commit message that the translation is
> > pointless. I'm not sure about this, any translation seems risky
> > because it could fail. The guest can use any IOVA for MSI and none may
> > fail.
> 
> In the current design of KVM in QEMU, it does a generic translation
> from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
> has an accelerated IOMMU or an emulated IOMMU.

And what happens if the translation fails because there is no mapping?
It should be ignored for this case and not ignored for others.

Jason

