Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B4ECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjy2-00031g-I1; Tue, 28 Oct 2025 09:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDjxs-00030Z-VY; Tue, 28 Oct 2025 09:42:21 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDjxj-0005Lb-7x; Tue, 28 Oct 2025 09:42:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa+xJC/6wkPfMdBMLFgoPvuW0sTgI7vRaIyHRZLPcCK1YXgHZRDTUwDQnl1JOtAYkVXluztfEKrRtxu9VzYyCRYQGiCSDg5jxeFils9JP2M9iSh6fSNxnZrMUzoFmoSJ+FWsVHPmqdmeHSnHQqy8VDSXHgAbjRleU/XXZowWRRacTR8V7VUX+6oRbKsiHqEvD5rEcmCFDBNDDbm49ptyqnu9rjWorbrsgc3jgNz313x0ziYKznsukVLqs7IMSSYae18Pk2l0AH2EjiVBUE5VvllFTeWx/I/tMMeqmnfbij56JT+o3tDHf0I8818e/SNKG6gEvovP85nzt1kE5pCygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP7zxMVF1T6X4egKBIK+yZTWfxkdeJLrYBiWnXnifB4=;
 b=PiVMr+x3rV7NG15AOvGqow89SRZr5thXnI9WHIFpSeuV95yYc0bOaiDEXuiwP9mZcuEa2zPFFYKV/3NQyWcKNENyZ2bREJbIdNql95ulQrGDUlQlsetbtLK9ZXRLpV/f4a5K4KrO3O0Hwr4wByNd8WeVR/fWPFPvY3mL8n2dNhv5hiVesYbH82vAszKRLdGsquL424KSO1L2pikV4kYaAXUQLY8fcpUs95DMDsPlfdrWGeiM0RRS8CaZB6LqOpzQxaaX67S/cvcQSSaVjTD4/49usCpXMRIjufuTQA8vJrbZED8LMoPloLyL1hBZI9oWo7+eIN66FaN9LiN+XuOtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP7zxMVF1T6X4egKBIK+yZTWfxkdeJLrYBiWnXnifB4=;
 b=Af4dgrl7uyUOHcJM2hgrkx2QWYOLH/FZgVnyf5veRlCRexmRJzmc7CsAukRrx9GgfZF6+qyHw2SPH9JmQPMQ7gh8587DHlc25M6loMyFVWYkVErhPKXgIBG5Lw8CoYeeW1AZE8mihvwZGz4j9udkKcWYVAdmQHhB1FVZPZcOF3fKb43puMACnv/N/M0Mm999bGIssO1ZE0y2Aqqf8xxtsbXt7UeuBPb84PfiZjL0DzKcILm5kuYzGnUBrCoy6nAuNz0x2lKwIGrOPd0TZnnAlID2abUdHPkJKq8GzUIYiQnEbg3MEnm8bgWz05Uo/yKUWcIbrHg8hy41AUYlIAVkxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 13:41:49 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 13:41:49 +0000
Date: Tue, 28 Oct 2025 10:41:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, shameerkolothum@gmail.com
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <20251028134148.GH1018328@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
 <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
X-ClientProxiedBy: BN9PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:408:fe::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4210e51c-e5ca-4ab0-84c2-08de1627beb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x1EyFb8+I9YT6pgy0c4GFV+Xj4fT21tlAOanoS8gCHhXQwArOXRztBTLd5T5?=
 =?us-ascii?Q?aTVpaQQ2a6wo9WcyjkNRALXZS/fhMu0lPaNUOnhNa1S8xl5DHUGlbz7Csd0F?=
 =?us-ascii?Q?8o09uv8kpqTa5m4GsLqNUTa3s22GwMf49M7gzy15uth+PE4FXewTerpc7BHp?=
 =?us-ascii?Q?y+/L5lFLrejQg/N3AkecdKUP4bW2qk68mg9TOnoCtGej4pFAScYJwBFh56LC?=
 =?us-ascii?Q?a9VmYWQrZfKnsFAl5oPWvvke8PcmNiU84pUZovkxUBk4RGmD5er9tG/OzBAO?=
 =?us-ascii?Q?IpZUo+juaWrDMFcPAnlSpxh/VFk1NdICEYgxi6pYYv6uEI2hcUYyc+OOOGTf?=
 =?us-ascii?Q?W2uFd8hAzJgiKXEVD4PnhaTI0UgsY9H0zcMkyFnM/25V3lG/15MUCBzx1zLV?=
 =?us-ascii?Q?TtbuDhNprao+6iAArt2Y586jgyYjdX9o2/Txcf8EScjvzsPcSsAjpIw/YMA0?=
 =?us-ascii?Q?5Wtq4KvjfoNl2S+8uHWJqhHA6I233k0HC6YSf7OGacASKGXj7yElKTGQ5XPq?=
 =?us-ascii?Q?dMBMmdaaV4h71/IOhbHXijGbj+5iKMFmhor2tWOw5cozLSAQI+CTEP7WVhqB?=
 =?us-ascii?Q?CF0stosqYC+ODqhMro0t/+RBb9TncZWPUBgXTJUbdUcwicgnji7dyIbMgKL9?=
 =?us-ascii?Q?nlgwfzXmZuSqpMXhyyjq03ldkbWsTTjazMTPpiH4w2coFycFV3e5a1HhBJ/d?=
 =?us-ascii?Q?xiH23HmYdmbxkpKgjIhZGSg3P9W53yO6EMR3d8ckiWoyuQLyBMZMut2nTOfR?=
 =?us-ascii?Q?LCPzMTIqpebSWdhIN6y5oFSzQbjj+iXjtFy97ld0IwOwh7LOhQcXooDvr7QS?=
 =?us-ascii?Q?EPzWdd3VGEUk3AF+g/FUragJlE2T2cDB3fCPJtoYz4YS0jn998una/Ru1XQ9?=
 =?us-ascii?Q?2SSgt7ezXkQyKVztCp6QzEEmKZCxXgjawKCJib4Kp5xiNB3X5w4+2oJmbsRi?=
 =?us-ascii?Q?CKsDJO44lFcilnuXwI3hlISzxa3YvJsgtCBZ8mH+ko+wMdboPatIh9uZlzuP?=
 =?us-ascii?Q?GaAfAs2qsSUtSsximJCJufJD3mx/rS2P0bhs+mawThVFr8ZRL3VHJCGXavQR?=
 =?us-ascii?Q?mreh3Q9vc6JWYgLpq60oI8o/H0PaEc8SCCA2aE0mW2XS38j9vtjAPbiAU6t5?=
 =?us-ascii?Q?/cGm5U12hQOoFD/4m4gDv/ctcgyyz7L4xSws3P7ZqCmxemwXBhqLnDyeX+JU?=
 =?us-ascii?Q?R/SzQBjS23EDlXBL1kWCUwc4qfN7w/x3kv2po2ALqNNow4zlZkt8MdwkolQm?=
 =?us-ascii?Q?69FSsjKgHJ0u7jC56J+6/dUgE0/GAyx7W0uajJowdNuUq8ari7GkBTn3hwfc?=
 =?us-ascii?Q?+wHsShIyyDY0VL0r2cSWmVna15pqqT0xkwBRxGj0iCtUNZrpMKlj6bxxcDV8?=
 =?us-ascii?Q?7wTy4nsqLLfpmMRhoU9nNryGkLQbkclJxuNCQFe4pt3NPMwnHjU7HLfaI0hd?=
 =?us-ascii?Q?moRvt1GECO4WIY9lrA4kD+lyF6S8FFJo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mD+dXi0fITglMpca71McWsGf+t/+v2Wv0/09o1Het/RjQOakVqibRF0M1nR4?=
 =?us-ascii?Q?6lqr+XbRtavriDlGlcPwbKu3KnHCZbZiDChkpEUl/eHDjuNZH16LRUer4fmZ?=
 =?us-ascii?Q?SQTlY8/7zAg9v22WJGSsZFekiRkUrUBtAKmWP4BPhRj/7lkJjQv3DyFkg9V/?=
 =?us-ascii?Q?ZSLhYEKtVqdbs/bCL3JAWIDMrX4mnz7cVWP90BoNvzWSH8JBB99i+ivIhfgD?=
 =?us-ascii?Q?jvdLBE94AU1vaPhGjnLoHs2VkrtTJShkqBbZbjJs9kAH30b6BhApzhHRFq4s?=
 =?us-ascii?Q?N1dkDqg6qtEBwUhuDPB9gICg53EWVLc+zOlkPuc9xzaQlBsF7NN75d0YSry9?=
 =?us-ascii?Q?KghD4w1lM6SKZnOBfGiTqOJyw8Y+3NCv471INedGoO2x161h3cDLzT24vpYO?=
 =?us-ascii?Q?XTpfjcaV5uY7XOpgp2dxs0FOCnA68dSP7iuAkup3jlBg+B8vXET8zrUg2LLt?=
 =?us-ascii?Q?pjfN0xMcIEEMjc4Wxpl+D9+PzXAnomwbU5HU5qzF+hnJpg4Cg4CdGvE56dNt?=
 =?us-ascii?Q?C3bZU+zqlRidH54e76rrXdDN1t3KGUIgiBg715luedMqlVCYqcuEs8vjnd0r?=
 =?us-ascii?Q?ehXTLE1JV3TjrSZQa0YAbnHm6HaP7fRsygPf8tFv8rRoofodKVMRCeIV8mp2?=
 =?us-ascii?Q?zPJ8lX5MMqmoh/Fd0nwfGB5bXKA+3ErKCd16cXgDhOD4l5j1A5k6rbf1LqCQ?=
 =?us-ascii?Q?kYTsMoUHxS5i51yBmFdCheeRvd8h2nnlc29AuTh1Bhdf6bioUp4xIx4G1KKn?=
 =?us-ascii?Q?ULIKP0nmGGLx6IsArl3Sazjh9VZt/qHdIqrBzk2dIrEOiwqUkOFKRU++2RBj?=
 =?us-ascii?Q?r/XkxfLgJhLC//X+gUIKpOKX+aMsY5bHUwa0u6d819NPaeCYofrBwaLP2eG9?=
 =?us-ascii?Q?VppvwW5eEpyt9w1h++R2bdLrN8IN4p9MSFQFvgOTCknpKhYMg/rlbk8YipgM?=
 =?us-ascii?Q?GZo2ZPjFiEKKrA5HsdoB33qiwVdGjb0ytY4SGGyYU2rWORmEXOy/ZurapO5w?=
 =?us-ascii?Q?qA2yv/8Pxf8cXvv7v9GzC9ioFiYjhdCiclRWL+SjgVAaVA6Th6I5ipivI0nP?=
 =?us-ascii?Q?YbvZqBkTrukY1YQU+rT07y8TAOCc3KP2njPOelUnyNP3pxgR9f4wMmaq18uf?=
 =?us-ascii?Q?At5YCeiHLG7t32OvOfyjpR7V5LEvzL5lFOMGdXLYccWTvNJcVy77jLtnozk3?=
 =?us-ascii?Q?TQ4vIBfhNZULoHhv3+5BMjXsKhJA92U6n7JIlzcJQ4b4nJkqF9V0U9IB0uMr?=
 =?us-ascii?Q?D0qe1YZ9kJP3GvM2sq6jB+NHmkusRsFypDAkWCp9LTPdetEUurVWk5r2xMzu?=
 =?us-ascii?Q?EfxpaIihP/OhQNWV4bHPzCB224GRyI4n//Oarh39JaN05jvlFwTzSzi7KMcY?=
 =?us-ascii?Q?0Kvjgh2YMzved300XsdrEJMib6JndwX+SwVsImI2QTQ/zuQaTukW46TX+h85?=
 =?us-ascii?Q?PW7vgOUkXsc2vY5gPoODBrSCwS06S2nfhW0i9zm40tD6ayXFdnaeOVNVEFVE?=
 =?us-ascii?Q?p2Q/mzkYQmpyuAYGLKEaQZQrmLhMj1jGV3QMLPsxo7Ojq5SR2Td5Cwg+wHuV?=
 =?us-ascii?Q?Jvjy02XvojboxCM/Pbs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4210e51c-e5ca-4ab0-84c2-08de1627beb5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:41:49.3788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCETVSoxWxnoVlzlh9rro2GQ2WbdVCnsh6w/fziNzIkl8SeggHic/IkdUU40n0Ox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=jgg@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, Oct 28, 2025 at 02:21:32PM +0100, Eric Auger wrote:
> 
> 
> On 10/28/25 1:16 PM, Jason Gunthorpe wrote:
> > On Mon, Oct 27, 2025 at 10:53:10AM -0700, Nicolin Chen wrote:
> >
> >> Hmm, that sounds a legit reason, though adding the ATS support to
> >> the emulated SMMUv3 isn't seemingly a small effort...
> > What is "emulated ATS" anyhow?
> I guess it means implementing ATS translation requests and capability to
> send ATS invalidations. something like:
> 
> https://lore.kernel.org/all/20250628180226.133285-1-clement.mathieu--drif@eviden.com/

Why would you even want this? The cover letter didn't explain what the
point was.

qemu emulating two levels of IOTLB caching in software, with a
software page table walk?? Why??

Jason

