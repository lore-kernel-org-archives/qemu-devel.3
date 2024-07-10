Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE0C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 04:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sROkF-0006JP-3q; Wed, 10 Jul 2024 00:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sROkD-0006If-Ew
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:15:53 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com
 ([40.107.93.51] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sROkB-0003Ot-6j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 00:15:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbYP+lxBxjaLgQ+eL3IqcWdAl7dpCRDzNmKHLlMUC1qpKEm0PKpcoPZDvxLkwfT51PUjU3BShfe8/a1FBqdaD+UXz53ceIQA2t195nqvNDWeyOqLwF5x4uHjBSRSHI8hxv6SIlLy2nCuz6M6KCr7qcMMSjgGQsRt4/Y9wVgbzkqmTQZjLMPzjFUss3s86CCZYe7WZc7IvlIYAStpG7PnQeSVtkBAe1xSEAU0q21eCg2c4l2ns3keJ0KYUO3bfVqyxbcsMHnwmIEQP8dhS9OE5Rkzyze19aHEqK4daGTmsG9J5f9KafZvdIIBycCMZ8qR/y4EwCDxh4pdmiDXS1tIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54/FxDhqyUn0crYLyliZpHwhAaFnr6QXxSj7LIONyrQ=;
 b=j43uB0+Pm3qVvc5v7YWYNATf4TfcDbvA/oL6xyxf7GQWhHy5y4hkYLfUl68RUII/OkXtv86pNM9grgBO90gXCQW8VuyCck0lNX4qkoFBuXwTEb+VS+57F7U8XUdmdLkn9HyPh4U8raBoPeQTYHxol9sEP1GgvNoQCFvyNxrJmO+V0T8jHfXi7jFFe4IqSsWj+YWyaq6BtDNK4oUQgZ6Z5s6eF1rHIbe3tedMewTvEFDmbu9x8f7R9pW0OvQoPy7sSB4JcFwCjZtE/BFRPIbtdpkH6uhCvJTpuEujbVvIuvmQpA8bMR7Stlsp5Lf6K4WShXpd1F0m6pkTgKJJixdKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54/FxDhqyUn0crYLyliZpHwhAaFnr6QXxSj7LIONyrQ=;
 b=q5dSRyxE/7NBboBY0vRt6aYHa//BTxkRWZG3MntMPwwAY0dNbquVbKYcRt03HXmOQQQCizCYNuV7dgtUr4wrMnpMOHNSo0PaqD/mEv9MYd3HiL16SBFROHgQgS4LukdLAbQXp2D9JhAUeGgaH+82UeqIKbYqXWGT5o8oZ5jIioY=
Received: from BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 04:10:42 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ae) by BYAPR06CA0024.outlook.office365.com
 (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 04:10:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 23:10:35 -0500
Date: Tue, 9 Jul 2024 23:03:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Message-ID: <20240710040319.6bvsy4x7mnnuxled@amd.com>
References: <20240704000019.3928862-1-michael.roth@amd.com>
 <CABgObfYX+nDnQSW5xyT3SjYbQ72--EW5buCkUuG_Z_JPFqfQNA@mail.gmail.com>
 <ZoZge_2UT_yRJE56@redhat.com>
 <CABgObfbf1u_RvRTcoZFepFWdavFnkqNwUCwHm1nE4tNKmM8+pA@mail.gmail.com>
 <ZoZtxUPdDmnFaya6@redhat.com>
 <CABgObfZwmvpHE-cadR1yu_a4pftid9=N7X50HBfeCYokLge6-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZwmvpHE-cadR1yu_a4pftid9=N7X50HBfeCYokLge6-g@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: f9db6a19-97e1-4047-c65e-08dca096438f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHYrNkNYSFl3dzBGcGQzeVJ0dkh0SkJhWk1iamRCbUw1TGJMSnRGbHUvWVBS?=
 =?utf-8?B?WnRhcWVxVFRIYVg1S1QvUzMwa0dUdE5RendmbTRraE1QZldXVFg5QjNtK3Bn?=
 =?utf-8?B?WmNoTHR1Sm5tWnAyWW5mN3NndjdVa3hsVGhyMXRNaTNKL1NqSjV6VW9rVnZE?=
 =?utf-8?B?d2NrdTA3OENGVjlWTXlja3hCSVd2UUxPSm1VSnVGeWFDV04xU1J0SzVMd2F6?=
 =?utf-8?B?NzRzYzFSZ3I4c01DNENiaG11VGw4QXhVV0lweFhFclZpRDZmZXFPUlE5NjNk?=
 =?utf-8?B?WVM5NU16R3R2TGVIUzlkUy9sUUVYQ3hTQVhMQmRBQkpBakcwMmcxTUhqaVMr?=
 =?utf-8?B?ZW81d0ttNTFaK0JCckpuREFNeUo0c1VKdUcxN3BpUUs4WEp3R3dVbmdIRStm?=
 =?utf-8?B?NnJvWHhjZ2Rmc0FkZUhrZkRaY3JnTGtQbXRQamhVeWpHUUZ1UVg3UDlSR0t3?=
 =?utf-8?B?c3NEUGZ5dG93TEdjWGNuVWhJbHZTZVhDVlRadGg3dGF6cnhnQm9Zc3RWUExM?=
 =?utf-8?B?YlBFYjNUYzY3SGhPY3lzY1poRllidU1HblNibkZJZ3hSaEZCUnVEZjRFWXho?=
 =?utf-8?B?UStrMDJsNStEOGRNYlpMOVBCL0JPeTBKV0lRTDY1d0daUlREeU1tcGNuVEJa?=
 =?utf-8?B?ajB6RXdRSDAyVFNVdkVHWERHNHJ1Ky9RVnlSTjNNWTl4NXcxT0tiQmtBekVR?=
 =?utf-8?B?NjhxNFhPOGhObE9YVnl5bitZMzFIM1dNZVhScUplemxHb29mNTlTNTRaWmJl?=
 =?utf-8?B?M3grVjFFUXBmbzZ2Sm9KNStXN05pM2dpVDZyRHdVSWx2ZE9Td1N6Y09mZzhn?=
 =?utf-8?B?RVJuT0IxeWdCM0JlRFdQYXRHUUlsOXRtdlA5b2RnVHQ2NFRlQ0R3QVljOFhJ?=
 =?utf-8?B?WExQRm5CLzlzR0p3UW5ZQXJDdWpOTUIrdmcxTkpTYWRUTWNDRVZMQnZYeGIr?=
 =?utf-8?B?VUZMS25sVTJRZGkrZk94TDFQQWhJZWFwTXNZNEdIU2RUYXVTUGF6TXI3QjF0?=
 =?utf-8?B?dlR4SGdoU2FPT3pvMjRsNFVLSGZKVmhENjJnU201TExVTGZiRzdLVXZtNEt0?=
 =?utf-8?B?UWk4eHMrTUlyaEdXaCtSd2tjdmJPSjFveXEvSW56TjNnY1R0WWgzRkd2QjZZ?=
 =?utf-8?B?d21xcFA2OW9yL1poS0VrRlE5YWtuMzF4T25wbTQ5MVlrMWVNRUk0R3hTaDdy?=
 =?utf-8?B?V3hqL0pkTlhrV014RTZXY21QUDJmeTFQdW83ZW1PdlczK2I1YlhmT1BvbnJt?=
 =?utf-8?B?UG1tUEI5YTVGV05PaHZTZERuYUxHaGlsTHVLa0UyNDh6N0RYdTAwYjNYdkhB?=
 =?utf-8?B?K0FscGVGVVdkT0kzL2ZtZ2FBd0Myakduc3pQSFAvRXA1S2pFRllka3lDcVJ0?=
 =?utf-8?B?elFqSUpZOWwweVlCUFhXQWZGMFBBQjFZWHJYbndnR2pxUWRyNkhBYVpnMkJN?=
 =?utf-8?B?MEpCcCtwZGhtSmZZMzBLeVVPTU5sczlmM3ZOeXVTOG1pUk13SWErNzNVNUJn?=
 =?utf-8?B?UFprTkh1LzV1eVN4K3JVaHU3Q1JSSUFGZXlLWEhxb3oxeHAycHNOYWtlaWdT?=
 =?utf-8?B?RHl0UUN2S2FrOU40OFB6akk0S051cFkzOEVZT1FJN2k1ampudVVCRmpsbjBQ?=
 =?utf-8?B?VEgrdk5FeUFRSG8zMzJJVUc4T1RWbzQ3OFVEeGtvNFBPZ05SVGRqYVVUcGk1?=
 =?utf-8?B?YVI5N3NmRHhDcm5LK0k3clh5cmNjUkozV3AvNWxnbnpNWWpjY0syUlk5eEE0?=
 =?utf-8?B?WGdTcXVjUllQWHBxVGFkSVpISGRJZnFPQURubTRPTjhVOE5HSmVmeTQrSzBE?=
 =?utf-8?B?Ri9MdS93OXNLejZSYmpTVVVHdE5XMHMzZFpwaXdwNmVrdXNlZzlYWWp0M2FI?=
 =?utf-8?B?QTdVYlJlQm9mV24yUzl4NUNQbTdDUEhnQ2xjQnlGN3pDU3dYb0M0WlVyNmxE?=
 =?utf-8?Q?U+gpeYJukm2/IjNJ381knVpeE/s+y0Mj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:10:41.5677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9db6a19-97e1-4047-c65e-08dca096438f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
Received-SPF: permerror client-ip=40.107.93.51;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Jul 04, 2024 at 11:53:33AM +0200, Paolo Bonzini wrote:
> On Thu, Jul 4, 2024 at 11:39 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > The debug_swap parameter simply could not be enabled in the old API
> > > without breaking measurements. The new API *is the fix* to allow using
> > > it (though QEMU doesn't have the option plumbed in yet). There is no
> > > extensibility.
> > >
> > > Enabling debug_swap by default is also a thorny problem; it cannot be
> > > enabled by default because not all CPUs support it, and also we'd have
> > > the same problem that we cannot enable debug_swap on new machine types
> > > without requiring a new kernel. Tying the default to the -cpu model
> > > would work but it is confusing.
> >
> > Presumably we can tie it to '-cpu host' without much problem, and
> > then just leave it as an opt-in feature flag for named CPU models.
> 
> '-cpu host' for SEV-SNP is also problematic, since CPUID is part of
> the measurement. It's okay for starting guests in a quick and dirty
> manner, but it cannot be used if measurement is in use.
> 
> It's weird to have "-cpu" provide the default for "-object", since
> -object is created much earlier than CPUs. But then "-cpu" itself is
> weird because it's a kind of "factory" for future objects. Maybe we
> should redo the same exercise I did to streamline machine
> initialization, this time focusing on -cpu/-machine/-accel, to
> understand the various phases and where sev-{,snp-}guest
> initialization fits.
> 
> > > I think it's reasonable if the fix is displayed right into the error
> > > message. It's only needed for SEV-ES though, SEV can use the old and
> > > new APIs interchangeably.
> >
> > FYI currently it is proposed to unconditionally force set legacy-vm-type=true
> > in libvirt, so QEMU guests would *never* use the new ioctl, to fix what we
> > consider to be a QEMU / kernel guest ABI regression.
> 
> Ok, so it's probably best to apply both this and your patch for now.
> Later debug-swap can be enabled and will automatically disable
> legacy-vm-type if the user left it to the default.

I think this seems like the ideal default behavior, where QEMU will
continue to stick with legacy interface unless the user specifically
enables a new option like debug-swap that relies on KVM_SEV_INIT2.
So I reworked this patch to make legacy-vm-type an OnOffAuto field,
where 'auto' implements the above semantics, and 'on'/'off' continue
to behave as they do here in v1.

At the moment, since QEMU doesn't actually expose anything that requires
KVM_SEV_INIT2 for SEV-ES, setting legacy-vm-type to 'auto' or 'on' end
up being equivalent, but by defaulting to 'auto' things will continue to
"just work" on the libvirt side even when new features are enabled. And
by adding a bit of that infrastructure now it's less likely that some
option gets exposed in a way that doesn't abide by the above semantics.

So as part of v2 I switched the default for 9.1+ to 'auto'. But if
v1+Daniel's patch is still preferred that should be fine too.

-Mike

> 
> If you want to test this combo and send a pull request (either to me
> or to Richard), that would help because I'm mostly away for a few
> days.
> 
> Paolo
> 

