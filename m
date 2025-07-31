Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F824C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaY1-0002SV-Nl; Thu, 31 Jul 2025 17:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZsN-0007kn-D3; Thu, 31 Jul 2025 16:27:43 -0400
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZsK-0006Ft-JC; Thu, 31 Jul 2025 16:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKry5bXiGw4/wWeUDDVPiAQt8qeOD080eQCIZAprqaMFZOvvrx8rZ1ypxiGbyplC2o088dQRrT3cypEipptDxi4nCeAwXP/4VVbkY39XdMwVbi+dAvSXZxQwBrLjpd2OmbsbBMHTcOLpkq9qZNrK4kFHS5SWP+PbPa6SkhRokJUC6kGK72KR/ZAzxLSTQFOUSVDF2I3zGeBNf25hx1acxxp+VBdrS4CTNoWr6YNZnlnbW9VScAI+HbKJDohGXk6e5KQQXtBZOwJnW+O35foYITPQJnXg36A6o+5bHS/Hlndld9cAno6NCb5ugPalERDLUf10k3rSQ0cthlX5KqpafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/yeGYZKvHGBdY/dNteK6LesywXCQWAYGl5Q2EUQXD8=;
 b=EGlqajKQ32qcWbyy1wofAmfct5LHJF17X6Z+LSANHSDJA5E5HawnY9zhvZAHYKJ08PRKuAL4vNy6XruTFJ3+w9nSpNyTk5gz56ZiwIW3Xjzv6eCHifImtDWmECSw5vedGKysP5PF5GyerU9Fzx9C2TVntbmF8QBUswNZdc6gsPMMcnkUtGfqe9Ly8f/LNHv8iKwHVp3LVgm3VDYK8C+HC2clTc8PYqRgxc+WALlLeHz/lD6y3k5V+ISwDWstAGfGJh1hp/cOEB9+bZoIxLL6C+aDMbsrveAaT/kpXkpJM0wzAtFczTSNVDXbMhMkmk/ZF91ZlO8wMhINdCEejNRtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/yeGYZKvHGBdY/dNteK6LesywXCQWAYGl5Q2EUQXD8=;
 b=13jzpi0prJUCvTdYzGy8myvGfW+XFUSpNzDHQAPxQl+LAZhtEVp1VVwxKpBTeHP2MLceE6cnr66jUkOYpLNpscQweFHMnHhIHm6GgFDEcJmMSXMylUSIZ5z0AKC+1gNENn7LtsbLRj2Z1EJod3UkTlGga2tDEii+F8D242DtxQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 20:27:35 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:27:35 +0000
Date: Thu, 31 Jul 2025 22:27:28 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 38/48] hw/arm/xlnx-versal: add a per_cluster_gic switch
 to VersalCpuClusterMap
Message-ID: <aIvRsONDvSdJdL7j@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-39-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-39-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: e65e4800-356c-49e6-0856-08ddd070af4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0NkV2RKdnRVQ2xTY0FyT1FMWkRCOWRya1BCTFl2U0VHeXp4SGRROGM2ak12?=
 =?utf-8?B?ZXJGWmFTSXVyYXByQXRoTU9jdXRhMklhOTBIWVYzMlVwSDU0VlcvVzVOSmRR?=
 =?utf-8?B?Z2pIZ3B1M2I5TzNGSEs5WjJSY1FaOFpTaWR4UE5JcTdYSzhvMFNPS1ZBOWhN?=
 =?utf-8?B?eWtuVndTMkltbVl6Tm1sN3UremZuRVRLWGVma2dMZjV0cy9iTnJobmVpZm90?=
 =?utf-8?B?VFJROU42VGozUkVkZFVaekxuRmFVK3hpQnhwa2d5L3B1Qk1nM2kwd284WFYw?=
 =?utf-8?B?ODlOUWtaSCttWEtZRlBGekMrbHNIMG5xU1ZIc3ZUbUcwSnMvd2JGTUVkVWhx?=
 =?utf-8?B?dmVzNmlEWU1kdHU2MmhGdEwxVjJ0YXRQTjZHMUo4QlVRb0haWUtPSG1MZFhD?=
 =?utf-8?B?TytuWjZwNnNSRG5rOHBXcG82T2VhL1JYeTR4eGFvVXVmejBIUHBnbkZlaWVD?=
 =?utf-8?B?R3hVR2kvT2orRXJDTHFFem51MnlKVk5mVjZKNHQySjhNM00ydjhsNFNsbXF4?=
 =?utf-8?B?ZzFxdFA1K1NsNFQvaHpqSWFWWGdiYXdKN0RiQnIwSGxtWGd4OGluKyttbEV2?=
 =?utf-8?B?SmdzRTA5UFZraHZHMlc5S0VTTytHWUEzZmxWZnNxZ1NPRFZscmpTOC9pQVZ6?=
 =?utf-8?B?cG40WG95ZnJqQWtrbzBObjk3R05vNTBSQWRYNk9Bdzd5enZuQWtEQk1vQTRV?=
 =?utf-8?B?QnMrajZsS1pwNUNHK0lGWmZ1MVNvTzRPTmNwQVBBTjNVZXZ4UEwyS0VRWVMw?=
 =?utf-8?B?bEtNMmZjVksweGo0cU9qUjhCeWVKcU9reGlJQUNDTlNiK1pZREpTcXhyN2pw?=
 =?utf-8?B?U2ozaVRzWld1QkFjdHgxNjFPMENwTzFrWDd3R3JGckdBSG1qaG40L1VtaFlO?=
 =?utf-8?B?d0R6MytEL3VxVCtJMVFVN2o2UmlGMUlDYTZNUHYvUTJCTUhEbFBWMWdmMm5i?=
 =?utf-8?B?T1dZSzlVNitpZUxXMEMyTHJ3ZW9xK2MyVGxIOXZZRE03MkdIN0FKNWpCeEFu?=
 =?utf-8?B?ZlVvVDRCMG04YkphemFWM244d0lSeTUvTEpZZHY3Q2wzdEdJb2UrcndnYlNF?=
 =?utf-8?B?bitvUkU2NmJPQ2tLc3NVVkJLWDNXQUtxSk43TjdMZHlTLytHamMxSnJNVk96?=
 =?utf-8?B?SU1TVUFnNWhEODZoMjU1NTkzNmxmVHUza0JicVlMZkwyRXo3dkVDMDJDQTl2?=
 =?utf-8?B?MkUyWGxITktNTEFtMEg5SFZBdmoyaXc0WjBVVG9sVWdIN29kSzZucWdEVGZr?=
 =?utf-8?B?dlVkRm94V1RXaTErREN2Z0FtcVQxb2dYREltWExna2w4WmxMNEhHcGRaQ2FS?=
 =?utf-8?B?Zk9BbUNDSmd3V2tpZEZXU0hBSTlXbTJZVVZFQnYzZ1FNY0Z1bnhLa1Rjb2t1?=
 =?utf-8?B?czA2R3NBeHhuR1l5aUdVem1zK2RGVVo2NUFCaENadzQ3Z3B3MkNTbGR6c3Ru?=
 =?utf-8?B?djBxMGtTU2t2WFljeDJuT3NXUTJqRGFQKzNydWtYZUgyK0I3RWw4RDVXMHJV?=
 =?utf-8?B?Qm5sUDlGNDJUS3NCWVhUK0FaRmRZekozVlE1aHZuUWs1dXdmSUd3UzRkZjRC?=
 =?utf-8?B?ZmR3WFJVTlQxcTVHNmpCRW8ybmgvQXFsSVNDYkVaRkVMTkt4RjZoQjBETmwz?=
 =?utf-8?B?ajFiYmVuOWRFeFF6dFk1WisrNjgwK3QxYVRnN0JXcThLZ2VRdk04RGVxM1E5?=
 =?utf-8?B?Yk5WK1pQVFlJMmZxaFI5V09vMldka0NBNkI4VStZWWJPdTJWQ0J4aFhEb2N0?=
 =?utf-8?B?YStUUW1uZTVvT2pZWWRpWXZZY1VyM0xOMXl1dThYYlJKZjFONU9ya2pjVmlW?=
 =?utf-8?B?OWNseXU2TnowMDhqZnpIWkVxQ2ZtemVnOGNEMnZIMnBKdFh6TmxTR0JobGpH?=
 =?utf-8?B?NlNWUHVBUHE1ZENCTko0RnZJZnpFSUlPeG1lTGUwZXFoOUVNUUdzTEFEYWY1?=
 =?utf-8?Q?XaGRbe4udc8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEkyWDh4bDBodGxNa2ViUTc3MFlMU0NjZXVPbjVZNmluaFQyd2NMZjFKY2Zl?=
 =?utf-8?B?Ry9UL2xnNUVGNE9KQk12VWdTTi8vQzJVdExEcGlUcGxjaXdTelNEM1JIZmxm?=
 =?utf-8?B?WE1mcnhMZVFrVkJhUjJMSk9xT1NOVEFqSXdYM3NzUnhvSDF3ZFRFRWxaVkMv?=
 =?utf-8?B?OFQzZkY3S0c1dGxXbGxoQ1lnRTFSRmxiZ3BDcE1MRzBMWXdKZkFxODlNdlJ0?=
 =?utf-8?B?UVQwY0ZrUHFJcVExNTNKMUZIUElZL1JvT283VDc4RE9VZVp6RDBQS211dU94?=
 =?utf-8?B?QTNYeVdPRVNObUFBUTFKclBtYnFPQUtYMkRMbVZWY0ZHVExMbURmeGVJL2Jy?=
 =?utf-8?B?V3hsOVNwZHNkUkxGaE1QM3l4dy9SSmNjdVVSeW5HMHNyRmdPVFROS2ZCbzZO?=
 =?utf-8?B?d09TSklSell3N3o5emZFdVFLTlBaY05wb0YwZU5udG5vam1QUjNheGRWY0VN?=
 =?utf-8?B?ajVlTERPYU1DUCtWRzhOcHlLVnVCY2MwL21ReWZmV2JXMnNWbFlQS3lldUds?=
 =?utf-8?B?YkVWUjkyZlFsQmwvaGl6dDNiMTZJZUJBZWVOOEZ6RmZZbUtoUFJMSitzbUJn?=
 =?utf-8?B?RmpqdkVwTGVNcVA5UVZ3S1pMV2FHVy96V3JYMW1pQWtUQytHdXcrK29YOWlJ?=
 =?utf-8?B?QndnTUs5KzFqRlM0T1hmcnFscDlIU283Y2l0RG9KcFdQN1VPNk00QlFyazNO?=
 =?utf-8?B?Ri9PbUxKSTdkYkJYTFBjS2VkUDZPL1U0SnZNa05ieXpSMmRGV0NKSXF0TStj?=
 =?utf-8?B?WDBqWXV1eXJnV2VXZzJkS1JXNXdiWCtiakUvR1hSeXJ4bVhac3NQbVNCc0Fv?=
 =?utf-8?B?REJwc3hIZ0c4Q1g1NnA3NmZCZlMzUUpKeWFxcnhudUN4ektib3kwWnNZdkNn?=
 =?utf-8?B?SDlYcXZWUUhlQjJMcE5rRlRQaUxtb29DWHBIbUVKTGwrbWhNeGRhMkFoVFBU?=
 =?utf-8?B?T1J5dVJ5QkZaaVoveXZaN1VYalZKZUp6Sk5MeWp4SmMxMjR4cVA3R3FpekR0?=
 =?utf-8?B?UXRDWmtHd1orNjJXQ1RoSTk3eUxLRk14SVF0dy9pWGYrK0N2RWpOOXVyb1hC?=
 =?utf-8?B?NG8yaU5pazJFYlNUSDQ5bzhoZ1UrRnJmaHdURnZrazc1VFBxZjFFWmFBaWly?=
 =?utf-8?B?M0htbGVZQXZoRUxQTUdUWi90cEVrVkZUUC9Ob2gydjhUaldwVXhoeFBSTCsw?=
 =?utf-8?B?RGMvOS9oVGZuemNHZlVHU1dKMWFZd2x3RzErZlYxcmxjN1czaXNRelFhOUJF?=
 =?utf-8?B?Nk9rR1MzRWI1YmJnRGxoS3A5cEh4Q0dkTTFqTHl5S1ZvaTdPSkxsUCtsam00?=
 =?utf-8?B?MUpURlRWQVJobGZwYkdoSFdLV1VsbUp6TW1TeElsdHMrRHRsNFZBUnUzYkdG?=
 =?utf-8?B?OER4VGh6SzNUWm9YL0dmeVh6d2hSWmZxQlc5cjVKd3VoWE85YkxOVHFTNDh5?=
 =?utf-8?B?YXlVbW1HOUJEak9qNXJOVWtBK0lDN0ROcDBQOXpQbFpmRHoxcUtLckxuYkJn?=
 =?utf-8?B?MXlNeG4yVXdwZ09xbkh0MUtCaVBHd0I5VmxleDlkQ0Nkc25WSXJSenFjSlUv?=
 =?utf-8?B?MGZZaW11T0dXU1lpRHBwN2JvQUh2QkM0ZDFPUVZKbVBlckl4OWFKQnFJVkcz?=
 =?utf-8?B?RHFVL2VhTllrbHl3clN2UUMyc08zOURkQ3FXUEFtb2RxZnVhcEZxc3VHNUYr?=
 =?utf-8?B?ellHSVFVcDgvaURGYWxlTFNERWFrbzVva2hFWTRMTGMyTHFuVDNSWGZUVUh3?=
 =?utf-8?B?b0dtcndLUkRNZUVIanU1Z1A4cW1XdEJvUW9YUVBrWkUra0wyRGNRK2xpY2gr?=
 =?utf-8?B?NW1USXpEeVgxQlN6RWRBNnd5SUZ5bXlkRDROeWgrMzVPbEZTemxIMEtRakJM?=
 =?utf-8?B?a1J2Z1F1RlAzcHlRa2JYSTFTazNOU2ZWaGFsamRWRlA2Mzd5RkFtOFBOYXJE?=
 =?utf-8?B?aVd0R2p0ODRVMjZxUGcyelFUT3RNZ2hoNyt2Vkp6Y1BMN2Mvcko4UFJFMGdz?=
 =?utf-8?B?bUwzZ1ZkRTJPOElMU1FEWk5tZ05CS2x1cGVsUUFENEliam5lYmxCYkR0YTV6?=
 =?utf-8?B?WE84WVZzQkgwQVE3TlVrQmdKVEcrV1FLYko1dXlDKzJ1MDc3cldSQUM2Nk0y?=
 =?utf-8?Q?L8h6qBTK20IXXCSsRq7mgoPAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65e4800-356c-49e6-0856-08ddd070af4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:27:35.5399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrp5xbRv12TXVckDAYdn9REzHhQTcnd5oDnJUClRcCttm7E5vSw+fU2pBBSUb9Ju0G3VeyJIY9Ubhhbpd+05YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
Received-SPF: permerror client-ip=2a01:111:f403:2417::60e;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hi Luc,

On Wed, Jul 16, 2025 at 11:54:20AM +0200, Luc Michel wrote:
> Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
> When set, this indicates that a GIC instance should by created
> per-cluster instead of globaly for the whole RPU or APU. This is in

s/globaly/globally/

Otherwise:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> preparation for versal2.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>  hw/arm/xlnx-versal.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index aef53876f26..9d900fe3127 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -86,10 +86,15 @@ enum StartPoweredOffMode {
>      SPO_ALL,
>  };
>  
>  typedef struct VersalCpuClusterMap {
>      VersalGicMap gic;
> +    /*
> +     * true: one GIC per cluster.
> +     * false: one GIC for all CPUs
> +     */
> +    bool per_cluster_gic;
>  
>      const char *name;
>      const char *cpu_model;
>      size_t num_core;
>      size_t num_cluster;
> @@ -828,16 +833,22 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
>              DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
>  
>              cpus[i * map->num_core + j] = cpu;
>          }
>  
> +        if (map->per_cluster_gic) {
> +            versal_create_and_connect_gic(s, map, mr, &cpus[i * map->num_core],
> +                                          map->num_core);
> +        }
>      }
>  
>      qdev_realize_and_unref(cluster, NULL, &error_fatal);
>  
> -    versal_create_and_connect_gic(s, map, mr, cpus,
> -                                  map->num_cluster * map->num_core);
> +    if (!map->per_cluster_gic) {
> +        versal_create_and_connect_gic(s, map, mr, cpus,
> +                                      map->num_cluster * map->num_core);
> +    }
>  
>      has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
>      if (map->dtb_expose && has_gtimer) {
>          qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
>          qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
> -- 
> 2.50.0
> 

