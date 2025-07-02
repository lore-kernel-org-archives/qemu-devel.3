Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE0FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2yv-0007cN-S9; Wed, 02 Jul 2025 15:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX2yp-0007bL-47; Wed, 02 Jul 2025 15:18:51 -0400
Received: from mail-bn8nam04on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2408::605]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX2yj-0007UI-76; Wed, 02 Jul 2025 15:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMnsnfX1i5ocAikv5/VJ+EbHa5R1bdeFBbKgevUCzyT4uMVU+mBEJlcYTc3kLcXSFKGTCLj6b9ChWJaZoIu5JGUPHPHGNrTHaU9xs0ybjB8OUmiQhipujstuMGRpuR4PUIYjqqJqW1jhZUOnPYLQY8xUSF2TNeLfIGNVi8O8kj3pCCd9iXcx8QCyr4gA5wd/xER8lwNPbKZg0rLYhkhWfXr91NY9t/kSZ3SNd8/0XKn2yr5qa+CQooXzRaipv5SBRk1e7m44DnojV77iiSZu5UaSHRXmLgghfGpJOWtRobrerk4UVDztXD9XwPpLDLFp44bEDbHABuWW2s5yIuwrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjEa+59OwSp52te+ePswFi9/qbA2S2qAyh/MAr5dLdo=;
 b=c2kVCswbEki/vDZkMclN3/Fgv/q1Yrq7LARsRUuScbLOEQTpUfMp1i3NosLX/6aal5a2KBZcG3huYrPEIna9LrDLDXDC+KjWW5J1EHl89j5pMTozL3/Hm7XTYRnIoAdNJm28iCXn3hiTTwEBecV5nWSaw/Pa+5yOHK7gZdurKu0p1qWgZP9t+uIOU9l+dkOEtV9CtIP5KzniWisAlNRWQ6sUkMZRPttIs8WBQzSKcx6H3yXzMwxccCwa//ieYRRGiKuHDfJ+szM++CAU5i0db3f4pxpNdNSzXgMFpblv81WuIjbTlLkkg5TfcBVYR+SGXzul0h/Eqds7ShcuFAByHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjEa+59OwSp52te+ePswFi9/qbA2S2qAyh/MAr5dLdo=;
 b=kFIWmaBJfqv7d2UFkUO9YazTqe2nmExm9N4VQ/EiBL+KHkAnov1OvJnrCJ0k1YFP/zj5c+2IfitrB4Y2nPEV0p5mIXpkJhdauPzEbi6d01ABrLRvNGP8PN9/lCmJ8YjWsnIcYOZiw4uDvA6PhzAsyflsSh3HK0y2r7o9NuKA4VcdPwRWiL7VCMWcqbVeCvmwSspeQStQgmnwa2AQ8dmk1ZShWOzbz2ND/kCKgFqaWjYJb1OTUtXKxYoxqSNtszcPxkOtFSRxNm7P6YQh8Gpxcf0ous/LUVxkX7YptFhesIFz2B9DTIOCOrEjYwy6i/YbOmbfIBQ/STWPNMbe2eqmyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 19:18:31 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 19:18:31 +0000
Date: Wed, 2 Jul 2025 12:18:29 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <ed@tanous.net>
Subject: Re: [PATCH 1/4] hw/arm: Add PCA9554 to ARM target
Message-ID: <aGWGBdpvelKJgZKP@edtanousvm.nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-2-etanous@nvidia.com>
 <f7e9fcba-e844-42e3-8e4c-9cc67a3069e7@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e9fcba-e844-42e3-8e4c-9cc67a3069e7@kaod.org>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9148ee25-8ce4-47ad-5d67-08ddb99d3b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?shuX4Rs69rv0/MWwXWS4Skyj0f6KattgsCTotEDpeCPc5GRhIVREOWEfoV?=
 =?iso-8859-1?Q?r2qPgLG9XiP6cQ3WjW3e4lGlZ67ak51h2nOqJhHt4Hwr+gSboiSKejjpT9?=
 =?iso-8859-1?Q?6yrjU5xp86fIJS8EG7DHSMpL0DD45iYSznsxHKYqFagIBIv6uoPqK9p0l+?=
 =?iso-8859-1?Q?8bX3ay0RzUIhTZsCpcXHPLSTgFDIVTLpkLlf2SR+16C2o04HhX7LZX8fRT?=
 =?iso-8859-1?Q?n9l3hdYkGi2gvhqVtfSvB7iRVZTjVwzximZt87MPXlULnKt3K577s6Bz1x?=
 =?iso-8859-1?Q?Xb9K6iUJCFHF4MCTFQspWPMBd8xuQVoRZ3MCMt3VrlUGvCuHZKonRs05Sb?=
 =?iso-8859-1?Q?zz3wEM6wpUpEzSa1TKlTs0qzUnbJEYjAuxYIPEVzyesiOLyEkZG8DhpCAf?=
 =?iso-8859-1?Q?uuYnolLaEFeY9hjhoQxQjx1ZqPh3717k4JknJmRXiJY1AhSx5BWtrJTklZ?=
 =?iso-8859-1?Q?A7j3ApwK5BMbKiTT+yXlKaFcc17VnsEcdsrLCo5E0ORRZ1FWBdufEQryyY?=
 =?iso-8859-1?Q?KkE8xH+2qnvIxACBy4yUvCPvX5vY/cDCzxCTBb9MwrgKeheoxvog/GoUnd?=
 =?iso-8859-1?Q?fHgMlaLOWVr/ijQ+ADEcyMxfjpI6VEiW9GtvhQFX0HSVrdlef5Wnad96Wx?=
 =?iso-8859-1?Q?e4/F6F2G1EkCClw2C0YM7UF3PWb75zT3HanDnpobeAFg8RLTqrKvJcH9Y3?=
 =?iso-8859-1?Q?pWEJSVh/BtcBqC8hNT9jl2hNeHDlrz9ZegCBqcPklDT/SBYOqnGlpWEu0Z?=
 =?iso-8859-1?Q?/xHnhosX6yMjTS8vHUyK503ScAV/pdxTwZ1p3A3OxWXeYPYmsYt+udnmsY?=
 =?iso-8859-1?Q?oXCIq2hNArZGP6gPfBP0OXKxJH7abq/Kh0/GflzcP2H+md35gHgALv0ONz?=
 =?iso-8859-1?Q?mfMDG+T5HhcSsOTkOj7F2qiudtX2nOtvs/gWf5UfrmBXuqIBbp7SZ/ehD7?=
 =?iso-8859-1?Q?kGQPMSXJ6Q+kVPqG9iPHS6nP7BtL/01ifCu8bGWpasRtPCtaerdydH6tJ+?=
 =?iso-8859-1?Q?uiSYSj6wSMgm+wK8l1OI0uA1Z7cNdCRGkRGoEokT0MKmZbJsPSbRZNBsK8?=
 =?iso-8859-1?Q?in3cxOB0YAX2r9vXQk9/K6vYCmiI0Efe3tl4KNNg4DnvsbKoWn7Sa0F5Wh?=
 =?iso-8859-1?Q?fYkbWd1y17JdQFGQnwGeDIUnEWBdYoTdkA6HE3qdmqbyQ6hGuqfBccjN8I?=
 =?iso-8859-1?Q?RlOfXxro3/WFXpqHyWaD2+m+1Q4dSVf/BzevEGP8h6iks697JuoS4aJvRY?=
 =?iso-8859-1?Q?+vfIQQwl4DXrsG8MRf7wWaFYXsP7dJ8TZKpJoIHasSpWukyujwzFUIlBZu?=
 =?iso-8859-1?Q?4KfXPzn7FZehT4zSGeyd3SPZHMXpEtkgKI4Ac60tAJ2+N/7fX9NxyBJQt0?=
 =?iso-8859-1?Q?nxuWIiVxZ4zCmKtNIz2w4qN30MnbDGAxUCrZqnC1xf9CpNZosNKXJ8jRAX?=
 =?iso-8859-1?Q?CS4sLdhsO+R4OsduCIumr33/H0weMjnyBDnE6ecyw+dLzkxcP3Ei9IB9+1?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CDL5Q3qOIR8NA9clIxtykBQ8fK+gH4x8+6S4JTqB4lmbfyTZ+jHxe5YqaE?=
 =?iso-8859-1?Q?4DrHP/A/N7syLRN2UF/bosQAGwE2rBfhda/neciNdi134ijpx4UUpbm1dX?=
 =?iso-8859-1?Q?3eSPzKc9mPolXS77cDxHFOwM93umKyfwfSrFkMPJBfBozVqDGk++MZfqXS?=
 =?iso-8859-1?Q?d3I9xLSNSyIy/H/67ijLLtIs4t0iAyZrGzizDopsUeGavkAFZGY9R4chfK?=
 =?iso-8859-1?Q?9+YHSl2a8LsPx964JCVHXZ/M5/Wg9aP8jdGe8TJrBR0afhNPYQv2iMQbvy?=
 =?iso-8859-1?Q?5a+73ulJihd/0qB3QSM+JAJsBMyZg404XaZ+d8hmZ45hR4mVyWZrRzI9ur?=
 =?iso-8859-1?Q?ZeNYmyenmPlOeb7BTfW44+M2FaXj4IHs1fjvuy6UkmPD6pdmSb2fASz2+K?=
 =?iso-8859-1?Q?l1O2PqDXdVF3m4M12h2Ne6KNTIN2xEyqKAoub1zied6MeP7UUWmXw8akxs?=
 =?iso-8859-1?Q?vg+d4iVXf5dfwgmcN5fdnHRPWjuHf2dLXFrD9wqAy0EcyWyHa0o4Gcaz1B?=
 =?iso-8859-1?Q?mPmbL7sQ+lJLp1M08V03SzeAM3eXicE1IRkuFoEYXqz0LduRWCiOI1KKhR?=
 =?iso-8859-1?Q?T4XtERg6q+JRmEznx/vzUWRUMLOGnwg+4riG3vnljyrrlWzoe3Cdq10F8Z?=
 =?iso-8859-1?Q?1RzX8FsKaDTTvNpG0y1ovLnda1FIxlNVyfjXsPjtRmu0/mW0qqwB2lcmQk?=
 =?iso-8859-1?Q?c6WDQ5rV4GoraF8VMz6Ixuc+rqQCdDefM4NB4WowPUXNzHm0VQGjBd93cL?=
 =?iso-8859-1?Q?Ep37SKQPn+8khtfTMjEcSVIPG6HiA6BwVhPL4Zf23aPRU+LKWJVAFY2ndm?=
 =?iso-8859-1?Q?MH5ieW6mmsQEnHd/6IwhVqrrL2xwIdPZDzS99hl/c6/dlsBmpR34a4EAqz?=
 =?iso-8859-1?Q?P71R9bHqcBSbUWBobbgU3sMewSc7NCPK2ArKY1FGL5xB3YPmIATclO1xzr?=
 =?iso-8859-1?Q?VRcMi+U/+Zj/BDEADAmYQlri1skL5cfcRgWXap/YF+WciheutYzoSJJeuc?=
 =?iso-8859-1?Q?zrqV0Yln75g37SKnHIXPAr7Nikz6TI+FfAmSeHCQbT3Bf1a7YhSNyQYdwf?=
 =?iso-8859-1?Q?l94Rhq5Npuun2zHwXFexFU8CW/qVMpRar0jhYqNLiXgBku2/xb4vID1sFh?=
 =?iso-8859-1?Q?RMdDxNGlklumRgM/V6aSN4SeAmV3Ey9u3x+I3fSZ873c79HxFjHMZMW92f?=
 =?iso-8859-1?Q?9BhcM1LDd7mMnK6a16jwPwWvmQYDbkb3QlJWUGHXgYqEVtAQqCtnUg7ZDx?=
 =?iso-8859-1?Q?uMZbYusBG5gWrZZouDXX/MPEC18OXjIe0zSxosfA+iKbf5Tn2IiwzSXkUj?=
 =?iso-8859-1?Q?Cel7eJ4FGb7SKvewNDkeKPV5hwqQsEqo5EMYWuagspQAjO2gHphf9c0xlg?=
 =?iso-8859-1?Q?RAyBc3G6l0nyB/x8gPfWWFA9XU0oqpW/8cVyrLDT/nhzaJ1aep1q5zfXAa?=
 =?iso-8859-1?Q?Y9BTR/rUBf/mJm7dxa2MF0PYkc2nJiPVSHoerMRByiZV3Y9v0eWS2TlbHh?=
 =?iso-8859-1?Q?nx1Ev6rPfHWPYFM65KvlnE5aVYAaisULyaB8m8B2ybG6wGBAFwmVIJ2hyN?=
 =?iso-8859-1?Q?DyIs7BitF3dBzIoBX/TlK2pfxYIslu2xny5d18TZ3ZSO3GxqYEti0ZHrBR?=
 =?iso-8859-1?Q?dgZfmmfsxHuT53Q5ytu4A+lJcUL/DR7b/9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148ee25-8ce4-47ad-5d67-08ddb99d3b17
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:18:31.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FM3B94JgKLGgpOrgQN9IBMFg/+v5jayqXhdrYDxW1Us2t1w7fBT5Ml6SFgMSstcytcnsXKxct36QLXHtDl/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
Received-SPF: permerror client-ip=2a01:111:f403:2408::605;
 envelope-from=etanous@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  etanous <etanous@nvidia.com>
From:  etanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 02, 2025 at 08:47:48AM +0200, Cédric Le Goater wrote:
> 
> 
> 
> 
> This was already added by Patrick in patch :
>

ACK.  Will remove this patch in next series.

