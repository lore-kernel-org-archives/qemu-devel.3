Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04F4EFCE4D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwD0-0005d0-Mg; Wed, 04 Mar 2026 19:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1vxwCy-0005cl-UC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:04:52 -0500
Received: from mail-northcentralusazon11012062.outbound.protection.outlook.com
 ([40.107.200.62] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1vxwCw-0000iv-Mu
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:04:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRQVnpgc4hLT/7Ac1eUzku7lu+B9GfbNeX/oxzpcWUD7kRGtsKgg5J4UV1IRX7bap+o8YKP/9j31uBcqY3Prfk03Dms1eAzGiK5L1XADjvL9l5yNHOiXlJDpvV5UEyu+KdZC1JNOKa4N7CyHXSF1KwPKxs6mcYboOsGqbu2gNYPqDHVKXeVwPpOvQgvfwBraWzkUrgAChiD8ewfzPA0JfO6dWlCZXa+CSK2m05SVtXNUbYe2Wi+e8bwktZkF8x0FB5onqioavloKdBpwap9HCthWu6lbsjw9f62rIRZOMbaXP018PRVJKkY3NHFebXK23oFaqv/gqERUpAmR6mN92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch29dcSMJucCWbOaueIqD6MTsLWj7sStnHz2sZuGtI4=;
 b=TZ7cN/oMjc34/E8loK/1UnPtcCC8zh4VX3/0Ns6BsfmFTetx9+pkSWQZ0YkDkuZtK4dtWZ7ic3+m7vb1Tl+dypyfNNK5C9Bs/fNWWAL/ZIsCvuZc0Wra38exzZyR/xQmrTEKpzkEuXuwZHmN9v23biU0/VCr7UpTybq7AwBIl1juNxjDAh85VQkZodBPTALwwPVxdJUXhxuNGonHxCyuokpihKFUWntgw2WmN2a4wUR/tgIl+fJLSdCYUPsylqqlIRzXqwRoOStm2PBs1UmU3c2r4Riksts0RWi6eaVydJjct5iyfvJLLgrUWH6IOGBpVtpEO4cEjitscHhNs2+WWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch29dcSMJucCWbOaueIqD6MTsLWj7sStnHz2sZuGtI4=;
 b=hFcSOHIuOdBMiwj3GB5ZfWHTCxFdjjB6ubY0dJYODFxvfnSd5dDygHr+dsKD5A0REbUmD55Wt++Rvn4CCeN3sg7ZP1NqHHrZba9JT9Yr7ZQ+kwZfJG33ybQVH/nnZcMSD+VpMfR0A9maG9ki3bDtNYCGZCSHoqSTp7ZMZLIgPGI=
Received: from CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 23:59:42 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::9e) by CH0PR04CA0105.outlook.office365.com
 (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 23:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 23:59:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 17:59:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 17:59:41 -0600
Received: from ubuntu-20.04.2-arm64.shared (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 4 Mar 2026 17:59:41 -0600
Date: Wed, 4 Mar 2026 15:59:35 -0800
From: Stefano Stabellini <stefano.stabellini@amd.com>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
CC: <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 <edgar.iglesias@amd.com>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v1 2/5] xen: mapcache: Add function to check if the
 mapcache is enabled
In-Reply-To: <20260304015222.979224-3-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2603041559280.250016@ubuntu-linux-20-04-desktop>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-3-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 496567f6-e8ad-416c-ac81-08de7a4a1a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: sV8sZ+wqsVBoZhIsq3qxSEoqKvabd20wGRyiEOa3WQLZXGZv1khrRRmyxaIkKt0lYRhARVrvJ+4zWnAfKasw//yp6I//cDfauh+w2UdD2qW5uM++NdZIFlNlA95G31k5vpETDuNzbaaTAZ8s3s71FMwdvG4tZCSVQN69kbfqgxWWGEI2mdIEZDCxg5jwujymqT0XGTV5f5aSFi6LjDUVPKQD2AAEKM4MmOSrqIjpp7nNmlgjVIn8vk50ZpknJvRizq/21UFWLC3YN/MlA6s8T4vbr4rkIA8hxx0G9kDnU20PeBhx7WEECqOsZPTJMR5n2X6ZTpBm8PxiDP2HkKIiQznlgHEN30lPeBa0q7z4m/iFrRVdBAWZJbpkXAmgy1xaR4Jeh8N83Mh0eGj2upj0JxklMQ9yEzwfoiSKkFQinn4eIE5CiBdFC9vEpKy1Cydc4BNjq9jIcF157f8mQnmuEiT2RLs7iy+9Ytk2NHl9gOJmcMxdQNI+/qsZ9Boht/7z+7URO30/aWpvf7YJxuGTokrVD+Ek5u2cWh9i/x+oOGUCvvZgzqoOrX4Tib/vTxeN5XwoJ8EYLF97FcpeLzivw7PvPlLkWpspLQ8utze1TWGGBUyEmPnLU3fmh9kkjPJxcv1BUhi6WvLeJ9X5qCNborJ2rqNCkHpHK7kFpHy+4at4QtTIw7DHuZLvKD4qpwtiH19eqHmaSq1KAPJa2Dk3fydmf44fQW31SoVTMlaevLkZa0O7VxGrmPUpmY/kLBFvoJHxSIgGq87H6d+a0ZPaBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nict4oubIoCW7Ll+jOvGsrF9yj+lzfYC9R9PGLoBzATbHJ36Xi45aH3FB8uQf/CW7w0v0Rxmpb5eb5lgTeMCHHWv2gJAAFwMliKxVyZVjJJQYcB05rYq0FfwJqsROoCbwV5GhH1C0gvDy0G+fX3aUGudtf7HJGKtCmp7kR5ocx0LpcnjZ7zFuXVt+OIowBtd2L6h+TO7U6XYvjBf87sQl2ez2erNf2FqsjAMiKrYEONwGMRkhTYae67Loaa3TDGV/BlTCVWSmPbWfxBZID2Wg1Q0V6bIOn2dbi62d4dxF3/4hMsd5nsNkNY5Su3jE7vYiDsYQmp8wG79Zafyf9e2b5y0vVxdzH+KfdOtdJsczG343sXHX35uHHXsy8E2/4iUy6aDBH/zxHKlv5CLtqycdJXKUhNLfZ0O3Ub0FSMc70eTcamb5PBDCCIfH+IUfEQY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 23:59:42.1138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496567f6-e8ad-416c-ac81-08de7a4a1a5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
Received-SPF: permerror client-ip=40.107.200.62;
 envelope-from=stefano.stabellini@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

On Wed, 4 Mar 2026, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add function to check if the mapcache is enabled.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


