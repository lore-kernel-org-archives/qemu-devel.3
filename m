Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58564C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pV3-0000Os-G5; Thu, 10 Sep 2026 20:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4nuK-0000fA-Ny
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:10:26 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4nuI-0006t4-NO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W27AytqZosFsifqI6aiIu32myuuCaK6WzEpdhbfPI7KklwuCl3i0Ctk+FVKzV86q+JzH18w0Q0vJR4GocWPj0eCky+wtqOG8NE7NEP9d9K2TIHM0Cyz2ObAEAkeRrTTC2/qoe+TFI9sWTy1EHzu13jIt7wS+6hiksK4ZICkTcbOVmxbYERE2ccY8Pn1OephCzgwLJhA7qOeSmjulvcLRXIwFbMDqQ/XGbsTGxUUda2B2WX3z8ULBhAJC3oZtWBzOz4UI5u+Jw0qoOG3mi7A7UtfIbWbpG3N0kj9QvpD0v8Thv0DpU9JtBjrqKSYYJ+bKaaWyDgIJ+dkwO1ZaVWKRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h2Vgx5T3NefKq/SUpKbCwcQ1ON/YIbBwQLD1GV/WAQ=;
 b=vG+DDJrYGC3bgGOGoDwdYolaeSS+oYia49fSxqf75Dqt+Iy77uRQ0+tYzoyjCop/8gQoVudgyH6yR/CmPihzuPloX3mdD/LYYPPfqrJEyGTtjP/HvRFeXPUzJOWthmjBvSaTEhZwmWU+hs0K2VqnTVTrWbmV6B7o4ootwaVk+ZAyOpDmADi//ldEtR/74IaDYAD7KpONrpdpEbnVUokF4VWdzJ0zvaDUBM1BWCr5Uc6RS7PUu+OTpDThSlGCJVln2kxFjPKibwYqIII5rCd+wgGrAcjYK5OJumReMMFVXSoo+WwFp4u4Ys/A7n8AwPKFdpNbn3CSFerC3tDbzN3AuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h2Vgx5T3NefKq/SUpKbCwcQ1ON/YIbBwQLD1GV/WAQ=;
 b=tay5oiId99ddGe3sWccbt3yY0cCdjI5Lzz7Dm997taHcU3FHFGUYmLdL7GpqnsLJnJbs3eO6yTBkj08miI4nfr3z64UBNVjXdxn/DFQeEz6AYdgwGWB4SwJAQ4Wwh7j4tS1DtL88P7dUciI/0zjNcKRpl07GJmZlKTW1WgvY5wI=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:10:04 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ac) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:10:04 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 18:10:03 -0500
Date: Thu, 10 Sep 2026 18:08:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: David Hildenbrand <david@kernel.org>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v5 09/12] machine: Rename machine_require_guest_memfd()
 to *_private()
Message-ID: <742iw72k4pc5bigmbyx6rls3n2nm34x4duvo34ylgamhnwrjpg@vzoi4ozrpied>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-10-michael.roth@amd.com>
 <e4a6efac-c241-417c-85d7-16415348378b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4a6efac-c241-417c-85d7-16415348378b@kernel.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: c43bd48e-e9a6-434f-d857-08df0f90a5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KnMICpMmOW6I/rxPq6VswkH4W5Z9OG3fDRT3E29MQXDB4GrhbAhG1UoqNCLWH3uAdcNhMpUh/qZxRJxx7bKjACZRGSjSXtxz2F4uTYvpwno1jlLsh30Ju9NhcejDpxjaQZzVHcrsV6msH3mlLSPzXWO+SiQB9tNnOROUtdc0Ge7mvJVZcdQPmjdcV0juYI0Qyj8cJjwqST5w9YRLCClc7JE+2Rs82Mxvs9+wDzTEsqHbB41GHDw1cWIENlwvu3Jd15qXxKIwdJmF5PbhKM2+gPp3hq4KvCYnEED4J7OVDiQp40aGYmBoOMpjJI1DSvdamxJx5+heIPTF2MwxyF1QJ3Vfi4V6eW2I0yGVz2cgL92ZJ83U0zCdz2Kn/c3m9jdFgjVD1FGkHSdyv4esUyrqk0VGZgPM+SFIrd6CqL6YNNI9MhHR7LU80L9n4Jo23wSls61fRciBKZEYE9dqwWsY2B5Uk9LiDBJqaovpNtUeQCW+0fqJAsxMacVPqmPEY9EEgZ/OA9UoHCHAiV7GGUj7ZMCuJu856pXYkG5/ANL6xNn11zo0xXHhB7KsPX5drcbeBl4gTkd39EfpBezxaOYzhDyMk0w0EY3e2N3ZSzBsU4UUh1iskyLVdb5YoZjB0nkG/n2VcYqSOvgwoHc7+CwWBiOSEWYelbmGYCSadO+yrk8djbvuiCQidDDRZn2d6u0ZTm7UEAU3oaF2bcd3X+yKVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qUfwldOK+Wd+5BEJH822JvjE53i44rQlTOO9PEpSMJmCqHLPkaH5NJmIJBq7wXCNyou4eg5L6S4BQ38NvEif51elaaqAORzSRH8USW5RJc/lriNfEqR1YIJ7gkNVr0oi2V3cVDA7ts2Vtu6VN4wy/JgGY+EtFbzg+wsR9bi8/MzAnaWeTeMKu9RqBUXjd/q2+GAxuAjOtol2hunfxG6hUUBkk2fmaThSKL/iEUbPQFjYLkJb5NXapnM+PaFqKlJfhMS1xWVfQ/LRoL04YL/7Bk4SvOML48vZNqnzBYppNVV5pk2BtYRh05Qw9PG5WAEZPmeMg2lQi01rUas0Rm0RISHDd8WCkHXXj2112jKBwcNKvWkx3h9v2Xg+LM6W/vl8SoEdcOO6GE1tWeOaM9jbrJ5qcyMLAe/PFXoXC2VAA5Mw+76EthkBwbqbpxmLvbTJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:10:04.3326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bd48e-e9a6-434f-d857-08df0f90a5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

On Thu, Sep 10, 2026 at 10:55:09AM +0200, David Hildenbrand wrote:
> On 9/8/26 15:30, Michael Roth wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Differenciate it from fully shared guest-memfd use cases.
> 
> s/Differenciate/Differentiate/

I prefer the other spelling, but I guess the ship has sailed on that
discussion :)

> 
> > 
> > When at it, add proper brackets in kvm_handle_hc_map_gpa_range() otherwise
> > checkpatch may complain.
> 
> Why is this patch not moved further up, where we rename other stuff?

Hmm... I'm not sure. Technically they are not dependencies of this patch,
but that's also true for some of the other renamings, so I'll plan to move
this to the end of the series for v6 unless Peter has any objections.

Thanks,

Mike

> 
> Reviewed-by: David Hildenbrand <david@kernel.org>
> -- 
> Cheers,
> 
> David
> 

