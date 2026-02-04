Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD44EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjko-0000kI-Iw; Wed, 04 Feb 2026 15:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1vnixP-0001Bu-Hk
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:54:37 -0500
Received: from mail-eastusazon11012049.outbound.protection.outlook.com
 ([52.101.53.49] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1vnixO-0002O2-5m
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:54:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq5uFkJ5kYjtv49CHC1cu97fVEf6vIq2MTuA+OMX5JvHfPQLl8JKXn7yHyTfyW16vpQoCwpE0G+jwf3VW4a4qcivnpHwimTO624CTLvAsByaUwLQP4lLG4i6Bx9KPZydjAB3z3+AL9ADTE+Ku9I+jGMYCsUp0rf50XL/phG+rJ6TlCQDpWWwJAzSM4WnekHU7leMB1pV1B8/68BxTwyclMKmuCBXS7FInOI2BoALMF0AthDbjTvGuWkXBTtCkYLkORiAc2N5kZk/CPFShB0EgD9anLglSA3lLkO5TJ+WZv30VIcIPGaA1OdK8cS+LQ1eUMuNnQVzdSYbQ0W5fxpcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ6f/Qs9OGeFxfu7/lRYeiP9Av17ZlogZ+1d9KnNPAY=;
 b=UPXbccds2VOnmLmmyqg4jzyxQ0mVuifhgyAXU1vlg8WS4++3ICm+tmEt/QAHJ/zUOzMstHBHlhrefVkla65SJwwH1l/+fZqn9Hc+9hQVN4RsgWT2nH6lhMvXA6qcJlj8q5cmwrOI55QYTJOcvFGYNtRABbfzKsU9Q7s7S3Gw3zFMiMAaXM1juLmj2cmaLcg7HwwTWADR6CM26CfV07+a9EaHfhApD1P/JA6gO3H3C/Dncv6UvS4zZPSgz102aQ+orUEqGqIDUYe2mTLsQhcnYJiJd+SOsRls3tBJ2I/S8UZ3bDuQAq+yKr5oXrrdw6LjSBX8zfQ2TyHWwvnA4ksPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ6f/Qs9OGeFxfu7/lRYeiP9Av17ZlogZ+1d9KnNPAY=;
 b=k6UpVxWtPsq88LuU4iFCg1PW7ipymjHtjAYkqbmZDaANi1JabxNYAaOF9sgtmS7ZNiAILIS9qFdsX7wbHXSkHmm7RXsMXniwmt4mJMrG/Md0ZyEYwQaBKRGUOI56xAl6i+tLE6EbXO7G3alINTmB2N2LPf2ai8SHREEmGaE/zVVc/WwzcGd3l8K9puTiu5L1k3NxyCebFbUjfcskbXUXVUiGTAIx26mu7U9IY7TJ61tq29/8hRZfXKScUdmQKuewl2FtvqOrEvg2pT04gfDu5thiCAGAf6dordlg53T0xOkRYnKifwZeql0sddQfrNOYgbNEcalguxDOJdMXubOVFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Wed, 4 Feb
 2026 19:49:27 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%4]) with mapi id 15.20.9564.007; Wed, 4 Feb 2026
 19:49:27 +0000
From: Raphael Norwitz <rnorwitz@nvidia.com>
To: thuth@redhat.com,
	mst@redhat.com
Cc: raphael.s.norwitz@gmail.com,
	rnorwitz@nvidia.com,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Switch to my NVIDIA email
Date: Wed,  4 Feb 2026 14:49:23 -0500
Message-ID: <20260204194923.17704-1-rnorwitz@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0425.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::10) To SN7PR12MB7226.namprd12.prod.outlook.com
 (2603:10b6:806:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7226:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 021c37a7-8602-4074-3895-08de642680a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AIa60ACcZgbDANB2VdxsIwRsfxsjVjYhhlLe+3oOIcDS6McKw4KWIbqzmmyd?=
 =?us-ascii?Q?b4kUG0wgshJby6KX2oA5c6t7M45HQCYT7zFDeXeFwv7BIZHo4p1obiEJj4U9?=
 =?us-ascii?Q?uJglX2geLtMi99SI0SRm7LEguE3UlwQxByE81gatc+qh6nAY92L/q74dGSap?=
 =?us-ascii?Q?nSr0BI77jWfqA41yL0jXXXzdgAouqma1yOpVBvWXr5Xlgw+2F5R6Nwhnn5U+?=
 =?us-ascii?Q?qgiZuTdnHM8J0YAuCG3tTQSYnK3o/Ojj1PhUMtPLATDiEsQDY4AFLCOQ1k8s?=
 =?us-ascii?Q?LHtsQXj93JESP1MUztqUe0MMtdAnhUcSO6YwehF0TERb33NO+e6NHRizdPc2?=
 =?us-ascii?Q?uUy51jrFxFnMgUG21JqYhOfN+5rhbDaLQ/VyO2rgQSYr7u91XoCWn45ZMQrn?=
 =?us-ascii?Q?8pK7L8xJvNPs5WuGkadCqF8K8q1vc3YsRd9zk72qYOpucpG7BmiXmMxyNWor?=
 =?us-ascii?Q?ANSF9cpIc6TcyuTCzKNWCftQKCZN0C+lQ06PXd2m9UleCAFF47jQ67Wh9nXH?=
 =?us-ascii?Q?kyrCur9tkmOwMCtncLmZRtAVMoAgMGKW2C3ytXgBstbEBHJGbC2GsA9btnOF?=
 =?us-ascii?Q?BCOV69jRlxGHrxfPGWmzCTppBE24qcKEl0qys98KdJaPm30YzGHNbFgx8Act?=
 =?us-ascii?Q?Q7mqfOB5ot3TCT0Vxx0Om4u3fsG0fqniaZzDcGufGfXOT2nwF5IqhKivLyrc?=
 =?us-ascii?Q?9EDJ64JtSCvlJC3PUmCyTuS9osLd4yAFH/fVpgWD8z8EHZCcstncWqkfthGL?=
 =?us-ascii?Q?DtbA4s7jCAUghvF/nztS/58CqQyl0NIOhKHL9qHMapaG8cG0mPYdbUoXFmqx?=
 =?us-ascii?Q?YPyaBEo7Doikl2wUHC5MYmK3SQb/Sezh2Sy7lL213Lcl7KLQx+2UK+nIfwuO?=
 =?us-ascii?Q?QTICQtcciXqxeRBmBXFGX9xVdbTD5tLxeg40GtjN2FBM0p/Dtgb/hAzEjdOd?=
 =?us-ascii?Q?YpJRnUEUSfquMJV+DNnB4XXW3LvvPFZGrPcQxoNeuO/X+Thth/un2BHim+ds?=
 =?us-ascii?Q?2x89SwuiYOrHuvqsjrqGElgTzSYrD5tEvj87qvXKCq9hnRconDsggVV0Cbcf?=
 =?us-ascii?Q?gOQy0QBzhiFlGKcr9WAVBRPmNGst25rwPE60UoPqvnbBS0sF8aE2/durZ+BU?=
 =?us-ascii?Q?OFmz5VwSJRkIbhKCpDjha2ct+8t/TM2IgBTFR2EsIR1D+ajKFKMSuyrVtLTN?=
 =?us-ascii?Q?sVTh2Rm4zrsKumO6350x/7/HYxe9vJhaN/TpofA0zU3zueQixyortwWO6P9k?=
 =?us-ascii?Q?csn9+/dY0hHgK4BP1puzBQFCWGO3DQFxdfwGJlLlrUxErCiNPLGhsrWCQLZE?=
 =?us-ascii?Q?v9xbOtDhVqKCqQ9i4+7MXcf2J8e2rJRGlQAEqQhKiMWegDK8JV461ByRR1cI?=
 =?us-ascii?Q?JZjUW8uikZlUcSHdeATp5733BnOmv0QJzuwc652qr5QVLL10YWVpkO+EhMkK?=
 =?us-ascii?Q?3JnOXMQA/axA+OXF+OZ361vz2lLKYjfc7yo0T+KyXcF5BvEepwZNM16IROvq?=
 =?us-ascii?Q?JH7dgo3BmMA3kOFNfPemUYhrR/wjm42WMJk4kG1GGGfLVWUQzExYm1WRw9WP?=
 =?us-ascii?Q?m2Cupv/6zq195T13gq4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cDD8xlH61jH43mfZTQi9aScr6SmFZgk12sVO3shNrgAiXJwzM4UPFnQ4vlc?=
 =?us-ascii?Q?axsAz41j9o4PcpGr47wpWwiAnNBix+uA2sm7Kf6xgrFkAgc3pHb7xqEiDT0e?=
 =?us-ascii?Q?f6sj9qJZXUiYHGrv/N4e4VHH+SEyTwCaalYSCZEcN8Lql3uA+1E4yH8u083U?=
 =?us-ascii?Q?kFXbQ2VuKHrPVjqJbhkvHe+kzp4jjOU70HKo1m/lU3XlYsqol8D3pjO6fQu/?=
 =?us-ascii?Q?LM5tLhXR5BelCfRsm8ZrBSJLMtSijHjPzZu7/RuuOVj5M8PSaIGpe/9+Nng3?=
 =?us-ascii?Q?x9n8i9eNmfP82YAa/m3778a5vt371dr9pfaSArun+Yrx948Y/v6qCTUBxLH3?=
 =?us-ascii?Q?KrEp0HwfjnAU7EenogjnfO9zSJ1sa3272WYZA/LBVSsxD4aONsXskZfQiJcX?=
 =?us-ascii?Q?y1BzqU2F7bLPdmMHR1zks21Aq7xGBZDly5DQgNd4oa03n8pdzgy7acJp9/Ut?=
 =?us-ascii?Q?RZ5BzmGkDTJlURSsM9AcNGkt22IgnwA54C9BmnTMfmcDMUrKIUtg1EHnAWpt?=
 =?us-ascii?Q?CzagRIgCNf761y5UapGUTGsCrrgNID8ztSh5xR/81ByNVzF+Aww+n8PAeqk2?=
 =?us-ascii?Q?bzAxSfmOsyUHHwmVgj6nHzrW7BKGUI7jiDHcWciDRGdKYfVifWOGYP/yh/Ep?=
 =?us-ascii?Q?CigxPyUyP2B0IMDi8FzhRTiNSb3THLsgVoBU2SsWcK3z8CkoEhIzE+l+znoM?=
 =?us-ascii?Q?lHjEd9sOS+15VLvSwVWQjDmEzO22o0ieJSRqb6wT1AZHMRCV1IU7Sh3Dg+9x?=
 =?us-ascii?Q?OsQM4CnhPcSPbqknmwFc5R4loJeJRfiYylf4gLnNSv32Y4WZesonKuqj92Dw?=
 =?us-ascii?Q?PVfX/4n6jYdeNVR1qwXeHanzeed+bu2mNlVSqp8RLTOBGgXDMv76RVzZmlur?=
 =?us-ascii?Q?BsBj8AN9hfwmeYUg27jjkBbJriErc4iWKlyKtFoWrNkrwQAU90YVC6+UarKI?=
 =?us-ascii?Q?etcPCjJzHjsVNdr+zWYKfbVPhohdK4wBNh/sTung/oszO3iTUBdzGXT5pyGW?=
 =?us-ascii?Q?Oi851vFkPEuYDxefdqr4zR42Ro+vGPGV1BOBA/WaHnuyzKR2xJibjtL2BxmY?=
 =?us-ascii?Q?jbwUCzMsjSvDOt0kooJPSR1O4V3b4W/jKgass0VkcDPVXtyHyKCXP3pa3f37?=
 =?us-ascii?Q?GT+I+lqYjE2Y9lJeLxIsOrBvIk7ErH8J5p5ziwlg5KmSpT39k3c17bWsfEoD?=
 =?us-ascii?Q?OeQUczSn4OBk46HVIzh8Hx3Qggsej4iQsWuLqFOv2ohyzf1WbugrFtSx8pKI?=
 =?us-ascii?Q?c4q/hPSwpYAknGp+CIUIkDn5IasE4tczqBezFafUX54SUxwChJBXisKK7j3w?=
 =?us-ascii?Q?pzB3GpJXNraw98QA0zL2szoBq03gglgZ+aeiWs1FA1y6XUnNGT/R3XGFr4gZ?=
 =?us-ascii?Q?WHfRNK1zyknuJtf/f5OwVUjaIzc5AyBQ0eQdj68WieEBAJ78Uguik3hQvOwt?=
 =?us-ascii?Q?wIHa4Mv9VEWm1SDP1rjF4IVBd5YNW1urdF/uGWzbA1FN0cr1EJ9J3Z8ibLXz?=
 =?us-ascii?Q?kCH85nK+QZZM1zIcIPAPCCZb8mbMgRZG0lspe+vCmAJr2DoVwdDsH2ylyUq8?=
 =?us-ascii?Q?3qgI0uSlKS7E19NjP+jsQIY5+n1PDDxV4t+THgNvHcbZxVb/y++/U92w3O2B?=
 =?us-ascii?Q?83k7KS79dRyRGCnfB87ma6m6xz/t03naT19d0/jMFfHRFcJK6qWcoHm87BLV?=
 =?us-ascii?Q?PA8dww4owQJUUA/t0ug+WK+GH8X5jXHU//uljcVjp7qG7uLyIRDs+74LwZwQ?=
 =?us-ascii?Q?sG3zfzzvEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021c37a7-8602-4074-3895-08de642680a3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:49:26.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPCJpMmbag3ynQJmfc9u2Gi8Tc+fGffkDibUP3n9vIw2XwDzyD4Ni+W3/0dDwoaX7SkORnJPgF6kVD370C7hdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
Received-SPF: permerror client-ip=52.101.53.49;
 envelope-from=rnorwitz@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 15:45:21 -0500
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

Signed-off-by: Raphael Norwitz <rnorwitz@nvidia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b7ed4fccb..92808fe5f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2789,7 +2789,7 @@ F: tests/functional/aarch64/test_virt_gpu.py
 F: tests/functional/x86_64/test_virtio_gpu.py
 
 vhost-user-blk
-M: Raphael Norwitz <raphael@enfabrica.net>
+M: Raphael Norwitz <rnorwitz@nvidia.com>
 S: Maintained
 F: contrib/vhost-user-blk/
 F: contrib/vhost-user-scsi/
-- 
2.50.1 (Apple Git-155)


