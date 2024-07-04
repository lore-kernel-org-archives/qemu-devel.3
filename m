Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A432C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 00:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPAJB-0008V6-6F; Wed, 03 Jul 2024 20:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sPAJ9-0008Ui-6h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:26:43 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sPAJ7-0005mv-0v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 20:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTMObFMeMD7S4/uwywLYxUXfH/FU7codkjeUD+LAwbc/LgKkli8YbLuznlJkJg1hdlsgJqksNHJ/+gtl1enTf3xnXo50CL6FGKvnVfIROwrLTKhjRMlwhFlw6EP7e/KKI+4S1xpRrR4VOwVEYnjkdgIX6mMLIglFPZYqOO+OlxngxVBr9jFjNWekDQHM5DXEsi/nobzHa9xjdzMykcZmdWTYQTm5F/bt6aHuMFXOUfRnLsoCpnd6euSQ4H/YTeeZnQZexl9CjCauD+nQIx2RQABpX9t8UEAlVBMJMi/0pY0+T2ZDzek65lpIIcXkHXT3ayWAiFlYynWUcFRex5DoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HyVivyHN42ITDAsI33kA4lo3u/1pg1ShRiELeXaUNk=;
 b=f6KLgMxznqTURPYG23MfO8DoC3hIgKoF26e0w+Y08veaTNxUFCbQ2tbWzWYVUSGsMzMxIdog0QjlMeyCr4iLABjvF+qTkCOrbGtKVFUZZ1mX1/99ycV6fH6Z8t+T5UCUaAUjA91eAKgy7hYDSOJI9S8m81Zeng6r2eHiBcw8EiJKj+kQOheMlHgsBQVoJjlp/QQ++tY/Hu9tCPIUdBnVpVO3NHGdoHBGGyK0ibvjVEiFeEn6LTeQomulmTNjVhQLJ08Vu+eoVywnor+mt8uPRYDNl0IzNaVaylG5YYYviLSGwAODamPtj7PesGq/Vh+TZ+yrXff8sRXpibqHSD/uUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HyVivyHN42ITDAsI33kA4lo3u/1pg1ShRiELeXaUNk=;
 b=3jQtGvcTn+iJHD1gG8NENiBedxPvVvNZjWPCna5nh0b8pKCZcnKCGlVj1fvUOq7fZRtZcrLpgyNn0eOg+VlVh3iDLx3Dm69Z+sNFsiQRBOGhcXBJY3t2FPawXVEC2NwcMOCOeg+t3rVg5Iv8yKbloO31/WiEJdV6J4Xiqb5x0MA=
Received: from PH7P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::18)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 00:26:33 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::9b) by PH7P221CA0039.outlook.office365.com
 (2603:10b6:510:33c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 00:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 00:26:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 19:26:32 -0500
Date: Wed, 3 Jul 2024 19:26:15 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <zixchen@redhat.com>
Subject: Re: [RFC PATCH 0/2] target/i386: SEV: allow running SNP guests with
 "-cpu host"
Message-ID: <20240704002615.ffmdnewoldrntkia@amd.com>
References: <20240703110134.1645979-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703110134.1645979-1-pbonzini@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6644b6ae-467d-4920-0e8e-08dc9bbff506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3gZKf8S9XRmeXv8G7o2ouKonpx4jtQluv/Oaltp7EmoadjMp+CHTdRFyZYX?=
 =?us-ascii?Q?G/0Wr0qVAQr0bDfgw7ZZQO1t8VxP7FOekU5k0qDeGLlu+DuEHw4ddXQRUu2e?=
 =?us-ascii?Q?2ZRv2wKND2ImUNGezLwpvTOPGLVy2LTKRK3HtVM6CQznc1N3u/PSc+nYrxfP?=
 =?us-ascii?Q?mEYvqCoU0tuCyAPgx3qNL8O8ZOXsjZiwHETXVPkJWOHo/ypv2TKhksR0saV1?=
 =?us-ascii?Q?99ezxPizvasu4HtbNVC29rjrSqKtaIlAUKo8ZcT+CbaCvg1XieWYAlmUq7rN?=
 =?us-ascii?Q?HQPuf5hEBBEwlf+uc8WO9r+JEr6PwQzlhsawrBcQawpQfwDTAWXqYXdJpvbR?=
 =?us-ascii?Q?ag6b0dCx2xbAUtpTREEVXzo9esMhmHfzeSb10nT9i66HN/Y+yXkjs3e3nJSE?=
 =?us-ascii?Q?7cLGXUhOYCE2nlOLSpiG9xTZGQo0Icg9haDBd09ftKBIkf8L2EWjXAvay47Q?=
 =?us-ascii?Q?1wHSpDzAXbIbI18RXO1JfntQnRDfddnCsiIgOWXdzzQWkWZ2h8SKbgfnFAbF?=
 =?us-ascii?Q?2LWnXPZyIR9ZAA4Tf2aYD42nXPfNSlZ+F3s5xNbj5YGiBUvkdceR5g5gd/Pc?=
 =?us-ascii?Q?7RGEy56FC0p+QQZPQdIJ1YVw/jJOlxA2WiB52UNtRmjDDAhjqrlRMHOCpW7d?=
 =?us-ascii?Q?2S2nozzQfNAAkQw6rc3fOVc9AzoIWtbuept15JNK5R1GUUBvRECVglG/NRAY?=
 =?us-ascii?Q?BMy9znpJODX5fFFuPzfY+5/kJQuKsRJ8AC97xhYfNQWYtGhqcmRWnSBYpf27?=
 =?us-ascii?Q?jpmgrjEZLF3L8abs8FVl1MsXAl39DgBcrfUU1P13dwepAxQQG9fZtEU/po5M?=
 =?us-ascii?Q?U7SnetluCNGHS65HdxFg8QoU3N8sw57qFwY/77NDgNwq/6yomBtA0Qc3oNAp?=
 =?us-ascii?Q?gAtmWSVqWOgU7rl/4oNsHj7KDwQCtp20uxZ8QG2iDBEYmChiLEeZlk8H2VxC?=
 =?us-ascii?Q?QaHa4O5ew8v0VrvAXV4u0ErSasCXbeDV45r748NC3riC0ghA4dtGfwey4cez?=
 =?us-ascii?Q?iNIRpQgdCJxZSxyzzvEuo8ohZPLOWA50dvOLDGostWI11F1dwzyPQVSHkdU9?=
 =?us-ascii?Q?wnnQYzgU+9H6ZygbO/crSOswalIheBG5E680zwz8HzLShOo45ZI655t1THUt?=
 =?us-ascii?Q?r4vwYeBxrjWIACh7eQ4GQmlW6umf4PLrnYJyhC0uCUXlmgZUe64D3jIAihm9?=
 =?us-ascii?Q?/8OYe0uSWUp+7RqMflB6zEXF68UkkmKffE+0nC+FHAa8fU8scbeOmr9qnD67?=
 =?us-ascii?Q?L743OBY+flOFbFqEPhEOp1WbEg563eDOrXMC+LvBu0ws8nyjmwk+KDpiCYAH?=
 =?us-ascii?Q?iQC1leLIIDLiHV+v9auz/3eZ/62l7iiFJGYi5cjM7/BI3J5303JZxY4FDe/X?=
 =?us-ascii?Q?wUYSJ4ZsnMKCfUjZMlNDUajr9SpsIHqoBxGc2KJh1uK+7f5IuiuYVOVOvIYZ?=
 =?us-ascii?Q?RXS07Ji4sQnpastFlKNWIFBIDPUHKCuB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:26:33.0391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6644b6ae-467d-4920-0e8e-08dc9bbff506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
Received-SPF: permerror client-ip=2a01:111:f403:2417::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 03, 2024 at 01:01:32PM +0200, Paolo Bonzini wrote:
> Some CPUID features may be provided by KVM for some guests, independent of
> processor support, for example TSC deadline or TSC adjust.  They are not going
> to be present in named models unless the vendor implements them in hardware,
> but they will be present in "-cpu host".
> 
> If these bits are not supported by the confidential computing firmware,
> however, the guest will fail to start, and indeed this is a problem when
> you run SNP guests with "-cpu host".  This series fixes the issue.
> 
> However, I am marking this as RFC because it's not future proof.
> If in the future AMD processors do provide any of these bits, this is
> going to break (tsc_deadline and tsc_adjust are the most likely one).
> Including the bits if they are present in host CPUID is not super safe
> either, since the firmware might not be updated to follow suit.
> 
> Michael, any ideas?  Is there a way for the host to retrieve the supported
> CPUID bits for SEV-SNP guests?

If we want to support -cpu host, then I don't really see a way around
needing to maintain a filter of some sort sanitize what gets passed to
firmware. Generally, every new CPU model is likely to have some features
which might be a liability security-wise to allow in SNP guests, so the
CPUID validation is sort of a whitelist of curated features that make
sense for guests and can be enabled securely in the context of SNP.

Everything else would need to be filtered out, so we'd need to keep that
list constantly updated.

I think that may be possible, but do we have a strong use-case for
supporting -cpu host in conjunction with SNP guests that this would be
a worthwhile endeavor?

> 
> One possibility is to set up a fake guest---either in QEMU or when KVM
> starts---to do a LAUNCH_UPDATE for the CPUID page, but even that is not
> perfect.  For example, I got

Yah, the firmware-provided responses are more of a debug tool and not
something I think we can rely on to enumerate capabilities.

You could in theory take the ruleset in the PPR (Chapter 2, CPUID Policy
Enforcement), turn that into something programmatic, and apply that
against the host's CPUID values, but the policies are a bit more
specific in some cases, and the PPR is per-CPU-model so both the rules
and inputs can change from one host to the next.

So I don't see a great way to leverage that to make things easier here.
The manually-maintained filter you've proposed here seems more reliable
to me.

> 
>  > function 0x7, index: 0x0 provided: edx: 0xbc000010, expected: edx: 0x00000000
> 
> even though the FSRM bit (0x10) is supported.  That might be just a
> firmware bug however.

That's a possibility. It seems like 'BitMask' fields (as documented in
the PPR section "CPUID Policy Enforcement") generally return the AND of
what the host supports with what is passed in. I'll look into this a
bit more and raise a ticket with firmware folks if it is unexpected.

Thanks,

Mike

> 
> Paolo
> 
> Based-on: <20240627140628.1025317-1-pbonzini@redhat.com>
> 
> Paolo Bonzini (4):
>   target/i386: add support for masking CPUID features in confidential
>     guests
>   target/i386/SEV: implement mask_cpuid_features
> 
>  target/i386/confidential-guest.h | 24 ++++++++++++++++++++++++
>  target/i386/cpu.c                |  9 +++++++++
>  target/i386/cpu.h                |  4 ++++
>  target/i386/kvm/kvm.c            |  5 +++++
>  target/i386/sev.c                | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 75 insertions(+)
> 
> -- 
> 2.45.2
> 

