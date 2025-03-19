Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E8BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxJl-0002iy-Fq; Wed, 19 Mar 2025 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuxJj-0002hN-77; Wed, 19 Mar 2025 13:34:59 -0400
Received: from mail-mw2nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuxJf-000565-F5; Wed, 19 Mar 2025 13:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWDEA/Bz54ZLS8UQrGYi+FIlOyQ7hSAOGWQkppQeA+2uMZcdRnYOU2C/0+GP0tF5nMA60ZSWbKUfhX4Gvm5X4KxNRSB4W59ij2jchTQ+nbZ48d+yl7YQoM8D077YHrykOVKD2WEiPWpNgaHa9ENEA7DMb8oZfslN2G/GUs6DA1V/ewBhFjJWe23/ig4NvfgowJ5zEWm8caDcgxyImR7ATOR2BTdSoTwpcPHf0Wz6d49SZfJZ7jf0nTqWFpRCU3HIwKkI10fqJuYRmdAGLK3eWafe/kmqqshiU6sKQJF3d9dJYghmHBAbCgSbaniRD5+9intSx+A4KqZJTIX4VBpqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/SY4vRzAw3Qro6zu6N6fY6O42ZLRfwku7sBVwp5O54=;
 b=aRnh/naj29F+bKnnO05iZKdosLTW1duOyH/UwkxNa3mdGPw4FW/iW7omelWWi4FmCo4pIr0lECoeeasmNkEYRbzBChKmT43+FHTLU9g9fBSCSq6ofYx1xsYQidqEIeqTbZDiBOkdD6zDjtmVSqNZUBfCV8GmOS0mrkPnWiUjsGMyPH6WOrHE+fErsy+ywBWIGERlWOtBtAN5lvS3M0/5c0RJKnaU6Kru+LXBooblzzzki5xq3z9OsguY79qLxe/Q+gZqWZ8DXama/pq5VBUs151yDDNWM0evdUoj9Q8pgpO/Knxf+nNOrZ0oAlX0XlrmhaNERXRqUxQMNM1iArABXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/SY4vRzAw3Qro6zu6N6fY6O42ZLRfwku7sBVwp5O54=;
 b=ovlSq5M5wWBUHwlMx9JZGPhSK68vpGyjlEgqS6KqEAhhg194w9wVgbqJ3SunzC6e8dpVZf+P2EhmIM1Jb26HVMMyFM55FwpFhg+89wp481zlUX3RKiehHY51hCNhIHP+FDzCM4ZM11AMbmFF6d3gyRy3ByjAT/9dfthkVqW/Yqju02O8n5fXiMiPvezhMJHtzM8jjaeLCo92tTxHq2OLAYDa0A1DyPgYt7zVjbZroLo1HSV4oNEYczEPitoDG/TUW75EpjoFoQaMgq+g/o57pKGjd1+kXuqr4vHXV6YUJyZ2LoJ1c8092XgxWOJLjynr6dd9ik8bKlCbNq3XznxyWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:34:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:34:46 +0000
Date: Wed, 19 Mar 2025 14:34:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <20250319173444.GN9311@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
 <a1a62689da8c43ca98a4379773db241c@huawei.com>
 <5a273945-3557-43f6-a235-1517d5db9b48@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a273945-3557-43f6-a235-1517d5db9b48@redhat.com>
X-ClientProxiedBy: MN2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:208:134::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: a39f1f51-f61f-4eee-e42a-08dd670c576a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WysBL4Cb56dpXcoilbkNNOcErxS2nogW4gczlSappD5650Q6yal3xJ5Fztq9?=
 =?us-ascii?Q?2ixqDAhAAKW+UO0cFIw271sP1tPmjbzy+tVVO3e9f1rG6Vmkfz49gd7IgJkB?=
 =?us-ascii?Q?TNHoSWlPyr0xqfOYlq4c1vggKhDqWX22QvvgTEeaDqIuu9aOPn4Ss8Tm8GgT?=
 =?us-ascii?Q?pmbOjrTAIsnJo7T9MrKlCyPT/gNVp2LHnd7+lMFcCfWCOEjMCh4mM51HD8Q1?=
 =?us-ascii?Q?HUlL9O5jXahu2wHtwZivu5+I+zFB/sXSJccT3laWZNAWsLD6EKPx2V95XZyj?=
 =?us-ascii?Q?CFTSEjsRAQ5YbCQhSVM7xS2O08uiNdI31+ttE0JKisGx3KCmbNwzfw2xQbTa?=
 =?us-ascii?Q?H8b92e4aL3ZHjW3MztjVibjE1BUoXIt1S6W3atH2i7txnZ0snt6IWOHCJtJl?=
 =?us-ascii?Q?MsIr7Zf/sxcDGMm3zlj4/yXPal6O6gloLhpSeI5XRRu+bGN5l4x91Tlor0oZ?=
 =?us-ascii?Q?EZ9u3jlMOfCnlxJRzfDm+wF13bLgeTruNrQqOZ8DsmO2JdYVHi3AllLPBYCd?=
 =?us-ascii?Q?XMFwjK75+k4ScmtWE/y9ZP5yE6SBGIPFDadL+K/3inQTEqn7OTU4iLNtuDYF?=
 =?us-ascii?Q?mWHSCZ8OgEUUWcm7thruHJtoFJqsghfqCVxFzNpSmCoPYvcj9xU8DxhuqOff?=
 =?us-ascii?Q?i+EyEqQkXlad+5ueLsLVHrPtkEi15fRGDbnGV7JfoeFslmx4zJukoDfBdYFY?=
 =?us-ascii?Q?2Ssxm7eINbVf+32WHKXkj8KZnRMQvv3Cg9IDDWiCTMOebaXNnAhi8Fvvgrj0?=
 =?us-ascii?Q?0M9JrPv7RYJYMvHTKG+JduLuaUhN5aLg8SmnZ5VKWZeU6dpZpneyHvaaLRkV?=
 =?us-ascii?Q?5Tcdu3G4Fbg9VXktfdHnTAyYkHm0BSebAwXgSyEPqhnnEoz1uc4immTz0ZdU?=
 =?us-ascii?Q?QLtVlY6VDKUM+5/yN4SN6ehZhf7O6JW8lP9CZ3IioJbZfIj7aN0DTL2qBKt6?=
 =?us-ascii?Q?G5DoqMAFC6IBN0P1kHO612+1q0PC1iqXVmdyVYLUJXF2e7qwhHcujFAGYu0+?=
 =?us-ascii?Q?1LSfB/pAcRqYR4frNeOkUHIipIbq0Umduj/ey6cpYbLLEDMYWgFsvgdZprM7?=
 =?us-ascii?Q?DET7f3Rs6hYiJPxDRf/7oZx0sMK5AbiskdK49gGcQ2ihLZIrpaoW180ouI+D?=
 =?us-ascii?Q?pMeRXQVvDrcyR9HGXtLDfHXPVoc9TxMD/9g4/QRDPjaRFbGVM9jQ6xvqLbXP?=
 =?us-ascii?Q?lbUf6OQ+aILuOPMgFqXiRXbh7KpDywTX4744FPtlGZS7kpkvZiBxtsmkzYJ9?=
 =?us-ascii?Q?z2gk9vyq6UN0O+8LHExq5u343kJCy6SWVlWKgbhC+Ck3k4V4y3by8Fc2oTic?=
 =?us-ascii?Q?Y7DTFVC1d8sEoiN/LQURUg/tIDty8/B0yWbMxrJ44L9MgLKKRsy9Idhq4/qM?=
 =?us-ascii?Q?XBq6mRLcUUPgOmUwr7SMIi6ZTIwl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jENVKUUuT0F+wVsSpvrFDk7oP3PbBjOO4yFymHyqw+gFBLPxoim/4n5xMyC?=
 =?us-ascii?Q?QwbTui6zIPQjmVqU9oQRQwSh9n46LjHZV6iYEw1Cw9/4YER7A8bGc54HAd7i?=
 =?us-ascii?Q?SnqmMnjqQ6zZjHWGq9nxRrB/ki2PNpaMlRdrsKhD14+A47t871S+iV2o5a49?=
 =?us-ascii?Q?l0tDJelvMmzNIm2u9pwnpub5O2tB8J8AyV8Sy7vYuyGBU29jekDqtQ8yO+Yf?=
 =?us-ascii?Q?E5oXOxgjveIknQu2u6OQn6zNrQZ8s4ImcTPLnd6lJ2XeRODpIgOvxIUIvZN+?=
 =?us-ascii?Q?BWwB7cxmOdMpySKLwDRhx1SO83AqyRf68r21EX1Bls2zNKu8d7tvN6lXv1o9?=
 =?us-ascii?Q?E3DfMER3qGW71mSwvcU4iQupDxI448z1k0B5yqJDHbOj7nY/7n7zuKeB4WOK?=
 =?us-ascii?Q?2WQgcuol+fT76Istj85lsfsRK3m6uoCEqHba3yHouK2crWMRY4rCAr2Bwk0c?=
 =?us-ascii?Q?I1SV4opoIDxAdgoFv6AdpptxbqSV3iKLlj74U8jnng4bQvky3VSU+4asQ/uW?=
 =?us-ascii?Q?dRbMACFXjWvVC05+7fzLQle5Mb7V7aL3EcSrTQbUY/sS2w3qY0PeSJBLoJkj?=
 =?us-ascii?Q?vzzvnhNmDQxixBG4tOxGe1aB28MHGFXt3BOR2Pg/WGEAYyXkrOID2kCPRJa+?=
 =?us-ascii?Q?jPVOELWiuAsdi/FwnUAT9hqb5wqPVoLN2MwDvUkrQcUD09wKqzyqD8rwUX0K?=
 =?us-ascii?Q?mk4zrbLjTmcaTkXb6t53cbRdQhY7ELgsogkYZ39ooCm7ZUJwKQC1+L/MM3yO?=
 =?us-ascii?Q?S+PJS4GIjQu6uiw4pewkEXg3wgR3VFqWIlsvbf5ZmuXi6t+pR1aH2OoJ+aQi?=
 =?us-ascii?Q?xxOXjg4hMm6xvigxFGC68zzXKFXiMh43xEZEa6TzYXYP5sLKVffxdjj22sA+?=
 =?us-ascii?Q?Gg2wPDEzL5en53YGO1DffKYNuqck3nquQy6dUxXAykoH4N1ibgdqXD6Bsx4n?=
 =?us-ascii?Q?16Nc+4r1oBCMruO6OM80W6N2296A/T3vymhDg1fAQBPbL0UkvRZMPeK9jZbO?=
 =?us-ascii?Q?hQqden+jcYAlRykGm6OdG87I6Cw+hmjrKJhN6Hu3gcpGPFcbMeEAekyK8nKS?=
 =?us-ascii?Q?7wyV/3ArkU+1877kUZDU0Ieg/ubbJPdMEF/AUwqhJ+Smk8wmi1T4t7kxZ5DZ?=
 =?us-ascii?Q?hv8tzLKiOtXt1c05R7XEzKMyd2tSRc6OAFJbhE0Uu/9FQoI0Tonf31h5vjKd?=
 =?us-ascii?Q?bFAFHR9haqXO7dlG4Ib9lPqOFw2YygbQmMwbgNnuPu//47YIz4P3SMoGN4l8?=
 =?us-ascii?Q?wNa3/Xx4BkQXGY9RF4YsosIfVXCvmjpNB27EXv/LGPigTu5qjJf33eTYC86a?=
 =?us-ascii?Q?LsfO3Vh38la/a4jMwgtah1wj2Hz373fG2Li05Emv2ouJPnS1bnummdXPrFvK?=
 =?us-ascii?Q?dN1dnL+v2AbcF8zCSCjvn4mszTc9DXhUoOH/WUCNKAqcnbuK8y36raK+LbbE?=
 =?us-ascii?Q?3dhW9+Gk3yvLNxMEcvc+Pooxhu/dcX9HBTlPoOpFsYXY6SQcOAEfV4WpqvCE?=
 =?us-ascii?Q?kwwNCNYW6t+mYgaEpKOwg9IX1tfX1CmH3EBlfqnXycOtcBmO+sp4EMT93Ly6?=
 =?us-ascii?Q?czCVUTKE6nCLuyiiQr90hCq9UXtfJJL/1AJc9zmo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39f1f51-f61f-4eee-e42a-08dd670c576a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:34:46.2533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSfunJOEz8N4AI0YhC17MBhNFNKQhBM2A0W6T+uy0tUa7LGXAd2J0qujfr/j6VVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
Received-SPF: permerror client-ip=2a01:111:f403:200a::61d;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On Wed, Mar 19, 2025 at 06:26:48PM +0100, Eric Auger wrote:
> Effectively with ASID invalidation you potentially need to do both qemu
> IOTLB invalidation and host invalidation propagation.
> but this code is already in place in the code and used in vhost mode:

Let's not forget the focus here, the point of the accel mode is to
run fast, especially fast invalidation.

Doing a bunch of extra stuff on hot paths just to support mixing
virtual devices with physical doesn't seem like a great direction..

Jason

