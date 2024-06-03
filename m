Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2A7C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAbc-0006tU-VJ; Mon, 03 Jun 2024 12:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sEAba-0006su-9x
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:32:19 -0400
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sEAbW-0007F7-Q7
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKfaptuOLJvlp0T1oNDcuxa35fqyAerglRXbawG1HIcipo76O5HJQjLpK06L0lry+5FZ4Utf01QxJqWDWXJoyerx9U6NToXZFliA6a5h4bEC7nWpH6cVWavbF+w6h3X5Ea31J9qr6jlBJ7d96dPS9tUCaJQ6RgAS8s0NzqsXjbmc6OkE8+71tSX6kTE3QE7hVoX4yjcfRiwFhVWbH2/uw+vCs7iJ/WEhMCek49HZrqeYoHw1MTBgvkGHV6VE0iKNtbDdoiE9L5V8n2hhiBTgbIj8WppOd9kXOzi6rypC41gAWUth0YEDtngt2v/sZnKsn53BU4DGIffO/Fx+BHGBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGabzVk/Q4H8sodOzisnP7UO4HZ5JkqN/axVNjWoUoI=;
 b=mpegGccgparZi6uk7DmspOVvOTxqNAeQXQyHsHr299yIbx/AjzMYqwuex9OI/VHAG+HzDs7vdv4QEgUILFmEtfaDgvVS9TsgBL0ByxTi4T4ltSpfVN2F0/bVIzXwirQSC8zBaa78h6BJ5ErSsWTvTP95j7Qu+9lOqxPXVVXBh8FEIfNxMCP0tb2imIbaM1Cvp4mC4Vs3TflkMZZI5s1yskQgBoMYjn84Ff/Xeec8i/s78Z3jAUQt1JQ/VRUyhs9/roRyw2NBXijJNBZa928yEhhsGGKoNwmpI2TF1NvlDmm4mSQ4lMMr6fNVnx4AAhjpBrweHS+iWBGBnIhjXbVYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGabzVk/Q4H8sodOzisnP7UO4HZ5JkqN/axVNjWoUoI=;
 b=Hyj+tBWS+13bJSlw3ja5WxsGmXJ5bqP25IgyAvC+7a/IP5DC/808mRZu2eAHVCySpt/dMpRnMKRpC5BxUGFjnz1X/XV3Mz8zjvgo/NfxaAOA2nSki9nSYXe8BrGpJoSr32bsFvUP7FN0zRljf06kZd32OUJreqpZhtUFdF50DPI=
Received: from BN0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:408:ec::24)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 16:32:05 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::ce) by BN0PR04CA0109.outlook.office365.com
 (2603:10b6:408:ec::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 16:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 16:32:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 11:32:03 -0500
Date: Mon, 3 Jun 2024 11:31:48 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, <qemu-devel@nongnu.org>, <brijesh.singh@amd.com>,
 <dovmurik@linux.ibm.com>, <armbru@redhat.com>, <xiaoyao.li@intel.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <kvm@vger.kernel.org>, 
 <anisinha@redhat.com>
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
Message-ID: <7njm47hsc56gau45qq73qkqmqms7eixdk2yt6kh7mh7ujjcnvt@isr6imh63s6f>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com>
 <Zl2vP9hohrgaPMTs@redhat.com>
 <wfu7az7ofb5lxciw2ewxoyf5xggex5npr7j2qookddfuaioikk@3lf2nzapab5c>
 <CABgObfa1ha1MXYWLRTfBtMCTh0n=wNO=9jbRgbO10ksuzMO9hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa1ha1MXYWLRTfBtMCTh0n=wNO=9jbRgbO10ksuzMO9hQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f245cb-315f-4e57-c60e-08dc83eab48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjJWc0Q1dVdDSzd5dHhVQWJMSDNsQXE3YWpXZTlFVlNwWFdjNEFWQU5VZUEx?=
 =?utf-8?B?QVliWmpSaXhjSVAyVzdmbVNHY2lKZVh3MmthSzZ4Tm13cWxDc0E1L2t5S2Iv?=
 =?utf-8?B?cUNWTkpRNldYNHE5b1NCeHl3b0NEeFJGc3owbndCUkdBaXlVSXpiV3l4cTc0?=
 =?utf-8?B?OVZrUFRzU090ZnBTd0E3UXh5R25OdTh5NlV0OVVaaGg5Q1BaNitwL3QyQmdv?=
 =?utf-8?B?aWVRa0tYMHlEZFMzdkE4WDl4bDVGUk9uRkd0dXVnMi9lYWhQRkk4Mi8zdDFY?=
 =?utf-8?B?aTVpYmtVV2lsU1RIZTVicTJBbkdTYmNQaUk0ejJtQ2ljTUdycU1zQ3N5Q1Rz?=
 =?utf-8?B?RlVIb3hLVmcwdFFLcFNwMDh1cU9zWlB2YThuZEM1YUFXdWZmWEZ1a0lwSUhz?=
 =?utf-8?B?ck1FS0pWSUpvTnRSVnhaZ3ErOWhrQVphOXdTM1E2YXhPSHBYUThzaGRCbWx4?=
 =?utf-8?B?YllXSXN2anEzT05PMHptRGJ3QkZEZUVqQlV3M09IdlAySTk3dGxabHlhK3A3?=
 =?utf-8?B?aHFGdm4vMkVlSitPcmtkRlgxdnJyUG5jRXlrUHNUTWNSTkJ3TjVXRzRvdFIz?=
 =?utf-8?B?QXhlL2JwMmViSkNRbUJCN2xTTWJDcDBFZHNIQmU1c25LWFptVndNcDN4L0tK?=
 =?utf-8?B?L091UExqQWxWbk5LUjRsSzU0RG5rdGJJbVVGVm1kU0VNK1A2YlVTLzlaaUE2?=
 =?utf-8?B?QUMrY1g0TWFFN1RVNGtwSGRxZFdpQWY2eTB0V09Hd3dJOTNVRlJ0aWdna0Rz?=
 =?utf-8?B?SG1ETndjT212TC9hK3lBeVBzUzQ3RUdWWTRKZUNyTnVGbENpanlOdnR2cnJU?=
 =?utf-8?B?bjBOTFQ0Y2FwTlhiaDdYOS9samxoeWZLNFZNTzhmZTAzVXpkeXF1VmtCVXJu?=
 =?utf-8?B?T2ExSi9WR2owK1NBeXZGWURlY2hKUEtGUkJ6bE1KbHRiVFFtSlZMT01INHFQ?=
 =?utf-8?B?cThNV0NwSmZGMXlQdXg2RXVESHV6WTZ1THRuM1AwWVVPNWlmcWt5YmwvbHB3?=
 =?utf-8?B?dzh3OFB1b2dGM1hEQjNSaGRjbkZoTmJQNFRObWVKb05JdVFiVXAxV1ByNEF4?=
 =?utf-8?B?dGpVNEJxLzRVVm9sN0I4Q0UzV2FLV3FGaDdNSG1WMVFHcERpWUR2RnBDVklK?=
 =?utf-8?B?V1VHWnhqQmJxUHZFb2kxRHZnQW43VUM2VGJDSXpQNXFEbTdBZUI2aC9mVUpQ?=
 =?utf-8?B?MjBhOFJFdVJmT2FvZm9jbytxS05qQ3JneWhrMFJkdnpXam43dHVRdXlhNWpZ?=
 =?utf-8?B?bXBxV2EzN0ZrM29PdzdVeUlWc2NNU3ZxcmlYNWlzZ0xhc3BBZitUSU1yc2RS?=
 =?utf-8?B?WGo5OVRTTzhJYzhkMmpDV3hMVE5JYXVITUFHb284UTBDeXdNR1ZONkNzZ1Zx?=
 =?utf-8?B?UCtrcWJiZHY3cmptSWkzVTdZOFcvL01CVnVtT0tIamJJaWtCbkg3VWhHV2VJ?=
 =?utf-8?B?MERjSTVWdHVTbndHTHRrQ1F3c0xYbGhncU83cHNzRXFKTk9wbjRTSnhPeGJX?=
 =?utf-8?B?MnMxSGRpbTdwT01SckpNV055UndmQ3piTmxkNEZIZU1ZYmRMeitPdmIyTkJB?=
 =?utf-8?B?U1VEMlpFbnN5ZXR3M0tOMTlYejh1WWpWcUE3MVBGZEEwelBiYmNJcW5kN3pK?=
 =?utf-8?B?MHhtWGNzNnZmNjJGNGFoMFhWRCtGWXp4OGxGOElJK1g4OVZpYUljSzdCYkkz?=
 =?utf-8?B?VndTemozdXhVUnJtSndPaDBCT1EwMnljWGViamxIQmpaYkhKODlQYWd2TExo?=
 =?utf-8?B?S3ZzV3R4S1VGOXIycFBvQTc0Y08yVTJhVFdUMmhOeFllMVM4alg0YWVGdk9k?=
 =?utf-8?B?eHRwSVFyVU9Id2JsTFFwQlJNOW1UUnNGRm5NVXp4Q25HK3R1TmFjWnJiNDVo?=
 =?utf-8?Q?ztDzDK6//x6qs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 16:32:05.4206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f245cb-315f-4e57-c60e-08dc83eab48f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
Received-SPF: permerror client-ip=2a01:111:f403:2409::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 03, 2024 at 04:31:45PM +0200, Paolo Bonzini wrote:
> On Mon, Jun 3, 2024 at 4:28 PM Michael Roth <michael.roth@amd.com> wrote:
> > So for now maybe we should plan to drop it from qemu-coco-queue and
> > focus on the stateless builds for the initial code merge.
> 
> Yes, I included it in qemu-coco-queue to ensure that other things
> didn't break split firmware (or they were properly identified), but
> basically everything else in qemu-coco-queue is ready for merge.
> 
> Please double check "i386/sev: Allow measured direct kernel boot on
> SNP" as well, as I did some reorganization of the code into a new
> class method for sev-guest and sev-snp-guest objects.

The patch changes look sensible to me, and I re-tested the following
permutations of split/unsplit OVMF with/without kernel hashing and
everything looks good (this is with PATCH 29/31 reverted):

         |split     |split      |unsplit   |unsplit    |
         |hashing=on|hashing=off|hashing=on|hashing=off|
         |----------|-----------|----------|-----------|
  svm    |      n/a |      PASS |      n/a |      PASS |
  sev    |      n/a |      PASS |     PASS |      PASS |
  sev-es |      n/a |      PASS |     PASS |      PASS |
  snp    |      n/a |      n/a  |     PASS |      PASS | 

  (split + hashing=on is not possible because hashing requires AmdSevX64
  OVMF package which is built unsplit-only by design. split tests done
  using OvmfPkgX64)

-Mike

> 
> Paolo
> 

