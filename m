Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A5FC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 21:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc9gd-0004TE-NO; Wed, 16 Jul 2025 17:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uc9dt-0001SD-9s; Wed, 16 Jul 2025 17:26:26 -0400
Received: from mail-mw2nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uc9dr-0005YM-7D; Wed, 16 Jul 2025 17:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx9J5URJir4hIGdBtB/KrpyQGWjM2u/fAQGa04n8wi+YahgEOk9oKotQfRgRT8epCYcu+Z+YGrYOdPF5dQy7hsv9RFlqSi9dPgkaJSedZa0O812QUMGDsw56kS9VS51J9uMG2JuNgYNdfR0ETaVPR/QLOxwqf5eyRpT5Zmojt8qt9fl2eZ9bS59HC8XcmLSCupb3T5PTeFFyTHJr2EkE7zwMTw7G9H7+PBxhs+rcgi2FWvHSAgDoSPlrbrJjkYVW4C/xZZslWvRdjgtrSxGZKcS5rqLGaeA/gWLMnFCpWticWoeugnkRvsusL1RsEyw3Qa+yAGQ7R/7YIethUy6K0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR8AoIJ7UUcGvG/riDhzq5B4jCBYBKh+64u/QYqbwcU=;
 b=wLB4wm8GjX0QSoEwFNemukNi7Y+TdVYjNqF3s0mQuj/IoInBCa2NUW5If1Eq5LF884yovDKK+hfXzVgr4vFxEuVdt51oOWqUd5IFBQvgz38+vAF+jXHPu7iCJeaABCgpUi63q4znZ7EsbVHhUQgGlqB/xsRlbMX1rc6mto+Grqci2MjWTcbiLwcgsw/KW8Mgh9xJ7PVhsVD5NI7honuALUd30ld4Pol6+vlBFu7/C9ANKiHtfS2o6t+XlcqmqK9oHUuRpbYkEVrWGPKDUK+RQXMkOAtPyg801KETSlP+RnxfrSDLN+d+rPx47OUXpkgri0gPmAqImxL/K1KN6BY3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR8AoIJ7UUcGvG/riDhzq5B4jCBYBKh+64u/QYqbwcU=;
 b=mCIeSss/HTFz5gwSmlgQsKAcaEMxJd9Tu+FM3xstuMmn4kjPoz42H/paQpcifoWRtKhYqqfnPjbQlhfmbiwXNAUwRpPCsowy/+FQiJPyAi6mjY0+GvpLv1jQbT0IZZaWJ7cInODy/iVN0jzFcMzKomMFY9xwhoyRfkB0ABzRfBqI+mEAYjOBZT9SokV2JYrri/qvHx/A+Dc1BejTCqu0U2Mz0TTwhOZUdwVSRPyHFV5+ZDRpKwmkKVZmjOuWIUuIFmF7+O0vKaUIRKeh2SKDd3hV2RE/TZtT0siODITzd1MWWVHfiaIvFp5JhNsUJh5KsfxKvCNgTWbsO1QCzrTQjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 21:26:11 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::8dc2:b224:ba27:86e7]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::8dc2:b224:ba27:86e7%3]) with mapi id 15.20.8922.037; Wed, 16 Jul 2025
 21:26:11 +0000
Date: Wed, 16 Jul 2025 14:26:08 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] docs: Fix Aspeed title
Message-ID: <aHgY8MgsVr66uCJa@edtanousvm.nvidia.com>
References: <20250715061904.97540-1-clg@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715061904.97540-1-clg@redhat.com>
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: dad0a437-6bfe-4e13-7284-08ddc4af6216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?yjVeFd3F7OeMZsrYAMXVN2A9Klp0l+8Z4h57QjemNT7dG5FcXRzwz4Be4g?=
 =?iso-8859-1?Q?b0ZFap4YRpE9FX2t6IZW2f1gfZue7z8iUTZJimRGBsLDNmx7BJVXQQh3zF?=
 =?iso-8859-1?Q?+zQQdwzwHVM9oYZZB58mJnTL9EhkvmUbUZnBZ2j5JGyGSaLfb9OhWqAkbx?=
 =?iso-8859-1?Q?ABbJgN9chMUBAWjkScosk4Pr4LZj58o3zfzOQZJEKgkVJOKUp67mhb3n96?=
 =?iso-8859-1?Q?B1iwQeskRDxrnfgXW4ehp9y35p46sXxWzqZgh3CNswivnTbce1ljv0vNWT?=
 =?iso-8859-1?Q?2baRxDIg0QQqMB4RjcK/aBkZa4EVaB61iz37R1+XEUf3F1PFcrEP7E+U6M?=
 =?iso-8859-1?Q?Bsu08l2zLGENyy8JUJbM1/j0A6rT1wo0mFEYMwYuLHwiXc+6IPrz0+WW/F?=
 =?iso-8859-1?Q?3llv+CyZLkqNqzk6Q+fYUQ5bjhR53V9mq8HqgiGfH1QSWYgJgCInUyvbu+?=
 =?iso-8859-1?Q?s/JMnZ963H52NogVUxQny0syfMavhEo3v5S2PILTgb78Hzp06GCyFiaksy?=
 =?iso-8859-1?Q?VO4Y1/Dh9WhK+rsWCe/VOSYSAfu+3KkOaP6ylk/kIxj/2URPpe+5uMZBgf?=
 =?iso-8859-1?Q?kPkUdJBonUgveUEj2EK1h7UdiwMpscRdRNl7QMD+Ai/Madd9nwAhFJUkD8?=
 =?iso-8859-1?Q?L8g3t6BVLHAJRDsxbNpLTjXHYmI3UOON+FJMAUaFA4KukHSOQd2IpxcrRY?=
 =?iso-8859-1?Q?TU+PZVd745v7o//DrUgDHu33KxujCApgZ1uwBBu01O8ImcJgnp8FB1p6G3?=
 =?iso-8859-1?Q?UCx9PpyQl4FGMOHWvtik2+jmGppAeAw1JDOf+IAwimIWYGsZ5rKYjCGbWM?=
 =?iso-8859-1?Q?cgO8JlTMwvlgT0LnCYXXYc6LYrWpvDOYubKEthGt/mS4S+7jzFZLyIlYRw?=
 =?iso-8859-1?Q?efJbzenwl2e1s0BJmVFInLgHAKhksJzWGqZJRP6eBSRUhzzbma2V5H564E?=
 =?iso-8859-1?Q?a9jupLBTtVmPAxF+bdcW8y+O/JXm12JM4rwJapPJ9YLAOWkFD/K+9I9YV5?=
 =?iso-8859-1?Q?IRMcX2rOTIhPrJpVKmTjwaz9472pw9nWaFsidwtiFc3ToLonX9W271ak5e?=
 =?iso-8859-1?Q?AHcKH7lKWUwe2Rwjp73rr59teTwab6FH41+F2dXvVXukmE8nbHCbWuqIxb?=
 =?iso-8859-1?Q?VnVRGEFy4OsMV219gNOuHZ228bhlKWpGdLbXRdhaglkL0YSoTsmoloNI+j?=
 =?iso-8859-1?Q?qF/vomOUVbZHH7E30zC/qtiYoqJyE2Y5IV++FG5Www2o2UXn1vK1glYCGY?=
 =?iso-8859-1?Q?e8ITaYsVxUXOvNZ3xUA6GXu6N+WfwoxeFtkrdtI//HGmnTPJQu8pv62gKS?=
 =?iso-8859-1?Q?ejA/D80az7JHO1KyvAyK9CvsOWCkQg0cdNXEFyE9XAVb/GaG/ZecQdbMcp?=
 =?iso-8859-1?Q?DlsnUVCZ9I485rkIxa2JsjYCDKI2xSCDaqtug/e/ODV8VHAVh0CoFCMI83?=
 =?iso-8859-1?Q?096BObAfyUuyFmOcy6tmkPzf+ftB26PbGyllA0IPuZ1BhAYA/2fwnML58r?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3t+gvFV7PdZjxULKqvssPFXbeKu6XRoGNg2DFq5pRuhkNMjKE/ukZI44mS?=
 =?iso-8859-1?Q?vJlWiq93+rOsjxUVQ2oppF3t+fR9CXFSgHkE66Y99GuaTQHTxviln4PmYQ?=
 =?iso-8859-1?Q?7S+EU0mNmnisdbGQEy4WxiOqcfgo+5vNw7JvBkHQqcW87MUBu0lXzLuXk3?=
 =?iso-8859-1?Q?JL4FJ86LK0yNUOEpepoY7O/3IVhUYTF4YckrHdcd4Y4lO5fM17hcb9Czk/?=
 =?iso-8859-1?Q?Cx6XpFNDyd4J6csxHr/ULdot7523HyOKV/oRc+Zkb3XvupR0D8o7yaCBb+?=
 =?iso-8859-1?Q?6/5q/sxvqupLxTmslnIOSrriMQFIaG1KKoR6OI9muyyuLepe1fgZQ2Yixq?=
 =?iso-8859-1?Q?SCV20DgKl0SoIURAoIXVVh4qd/Gef+5KztqRp1TKpqH1d3B/Y2I7MX/6FE?=
 =?iso-8859-1?Q?E65AWQEuy0pS/yMJger/stfMjzzWmm6+hk48iZ+oEWMiXJTfmm4WtZhnRC?=
 =?iso-8859-1?Q?4xUrhG5S2xXCouBwlveGJvoqXJRjEFFXHKzK+2tmAPlmZuKslf0V3fbzOs?=
 =?iso-8859-1?Q?jLCG1wzbIXGoZ1VtAj01rY+poBjzFY1QkEeZclD3Wfl4snFLPoVKHa8BYB?=
 =?iso-8859-1?Q?UncN3PpR7ISO0oOMBiuwZCgqkmK5zzycMPTxo3Iol6jVdiV2a0wXdM58vu?=
 =?iso-8859-1?Q?jGEok9Ephfl/CcKmjuQl3WOaDQB7cie4QHyYWjA99OhpxvsVVepP9+MiIP?=
 =?iso-8859-1?Q?xEEo0mJ7VLkzFjg0EOpwXSMqIC08va/sroapM71AiBKjTMQVPnNtGBYuIy?=
 =?iso-8859-1?Q?WahECqGblk13mFHZuqm8jVjomC23Siz+fUa/eyT4ML8H4Z+ruEVsRBLzi5?=
 =?iso-8859-1?Q?JTog+V6KPQIWlpHLoJ5l0Zozn/454glRmpzIWBO3O7H54Wv/pKHw7fzFte?=
 =?iso-8859-1?Q?4KWF028DLHtZuIqd9mVx+/knUH6UaXZXQvv9+qaFNweGXT5/CB2QkpcG+6?=
 =?iso-8859-1?Q?oxJ17FK00pFcZxSL/5PDRHXVoRFR+BBKS4Cbb3XLfPgwdLo/b4w/Lc3UVs?=
 =?iso-8859-1?Q?mjnpSsvXfRxCJF1J0WyIRK3s1rsxOTPGxNkgqF6wDMpNDNw3b07CnO/FmF?=
 =?iso-8859-1?Q?PZhHod6xSG5jgAnsE3vvcocU/167kmUdzxQZaAF2KSofFsKtWqt+gk6vwK?=
 =?iso-8859-1?Q?rKu6c23sDGGxDWmhRbElT0+M2KvRIBcZIGTQGL6tG7FjAtXUyEy2qAKD5+?=
 =?iso-8859-1?Q?2WVRuIE8LULGM7LSwIzo4Fz2hBSAIK4LAmfbVrkDfe+8AVMr3rLfMHBvkO?=
 =?iso-8859-1?Q?5YcxnFfsouWq4AXqWDYiNT2gaHMQ9llluzS6GVHnuF3D4rxeqiviTsGCTF?=
 =?iso-8859-1?Q?yoRfVIykU2GmPDrSwQGiqC0FVml/S1uct/B8VZYVVHUftuKPajE0rw39//?=
 =?iso-8859-1?Q?ifH23ZLYlpoNRSRzBLRqU1aR+wpYe4xmucC4yGoFRI9sfEjUcn4JleFdzn?=
 =?iso-8859-1?Q?ub6pUGwhkgeXC6G/Q1z0JuHJrBNX+y5hNoU23bMyTjg+i/QE90A4/bVKut?=
 =?iso-8859-1?Q?5jwP8oL0JhsDLSkEi/o+2xEVWGXs/jYmaBDw25y07isUIT4nzngVMWt/OS?=
 =?iso-8859-1?Q?BIl5uBlbFXWFuMMxGzewXfWACCsYrY9KyyP8YHIZEHwf3OzXx9tzJZLleG?=
 =?iso-8859-1?Q?h0uI11ZNl7eIAbkUKAG4hLtoupm+d8dAp2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad0a437-6bfe-4e13-7284-08ddc4af6216
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:26:10.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6cZm/u/irl9UOyRHKQdWqZaUNPBh0QdhmghN6pSlEhvvGtcj9uJ7zJ4am0Vy5mTUY9Y6cDcsXGR/BRF7SWtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
Received-SPF: permerror client-ip=2a01:111:f403:200a::62d;
 envelope-from=etanous@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ed Tanous <etanous@nvidia.com>
From:  Ed Tanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 15, 2025 at 08:19:04AM +0200, Cédric Le Goater wrote:
> commit ad8e0e8a0088 removed the "======" underlining the file title
> which broke documentation rendering. Add it back.
> 
> Fixes: ad8e0e8a0088 ("docs: add support for gb200-bmc")
> Cc: Ed Tanous <etanous@nvidia.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  docs/system/arm/aspeed.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index bec0a1dfa8b8..bf18c5634700 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -1,4 +1,5 @@
>  Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
> +====================================================================================================================================================================================================================================================================================================================================================================================================================================
>  
>  The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
>  Aspeed evaluation boards. They are based on different releases of the
> -- 
> 2.50.1
>

LGTM

Reviewed-by: Ed Tanous <etanous@nvidia.com>

