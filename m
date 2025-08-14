Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C04FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 18:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umcPX-0003Xz-BG; Thu, 14 Aug 2025 14:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1umcPV-0003X4-Hx
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 14:10:45 -0400
Received: from mail-dm6nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2415::621]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1umcPN-0003tE-Pl
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 14:10:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJiMXi1K5gJ/0z+cDGRx4wgqwozL0UJBs2RLAHhG0GU1JFKwR44eHk1Da35vMER35QxD4XMKySNS3pgZaVyP+6NAQoGskSkEpdWVXyJo+rSsJbY7bJ95bVDSeCuLjRJ0gcWOioKavPYFsvJial5urti/U8OU4rsdZd07vBfLBAlswjZUN1WsLJcKrd8hgLOs/7QKX7Zf3FGeP/AF2BvfppjMTkNzRkyY2EFSMXCkYI1X+eosYyYmqSaQ04vGzhvZYdzIGl06zsG9ziz0r28+62C6H3GOY6qDdmkMfW4Yvuy6GKhOySntJGWBjtUMi3Dj+ZVwldPApu5LLaOwaG0+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdDNh2OMDJDW4/2nZySW7W2x6nkB+7RJC3UJog2Wle0=;
 b=ft5aILCOuZFa8p1yRQSxz/LfOOlorciQWSzrki6p1GveWQhW8DHsdp+At+iWWwqZCkso2fhdmERfPK4+qau+ESQwFT4FjO2ZHWxA7/pb3ylaCQQPYzt/lwF5EZzU6JWVLwu6YtObEOw1vHOVyJ1g1Is3F6xbx4EEmvDsrbvPuhcflaqx/dZjOpxChmKl5iGUSU9elWtncS03Gct788LGolLHeFLWY5ST6hmt7RrUpRJTNXlOCl+mk41sQPPMsTMTo7QvL8BWvrIf9Cjpu1diqWnO02ensbKDfzYo7gmAa4ith8WfgiCnGNIlKwja7MGlfxkjaxHXf3+xyB8ByApQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdDNh2OMDJDW4/2nZySW7W2x6nkB+7RJC3UJog2Wle0=;
 b=QKXJtjw0cOMuxelHryfp1tywu46G9dXUHo3JEa+mrgUZcSAd7CTFYeuq5bLr+4r9RCccXhFLa/ZvT5z+TfY0CBETUgWSt8Yg63xYWJkSAC3Gu3a4Bo7NHaQxVA50S4KsxvoGq+NTjUrGJ9epKaLrqqxMWuJ6mHpdtpSA+uaHfmY=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 18:10:26 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::3f) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 18:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Thu, 14 Aug 2025 18:10:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 13:10:25 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be12d3b1-6cbf-48fd-8266-4425dc1cfb43@tls.msk.ru>
References: <175511889543.3775407.17880470159729384156@amd.com>
 <be12d3b1-6cbf-48fd-8266-4425dc1cfb43@tls.msk.ru>
Subject: Re: [ANNOUNCE] QEMU 10.1.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>
Date: Thu, 14 Aug 2025 13:10:11 -0500
Message-ID: <175519501110.3816551.1519037375023535616@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a206e6-65e7-4fd1-50ce-08dddb5dd84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0k5Y1doRGFoT3JWZ2JKaWo1alM3bTB1bklRVGdQRmI2aW93d2VtN0F2M2tS?=
 =?utf-8?B?RFhYNldDRUs4VjVQemNPeVlISjBlaWJJVkV1b2U4TXVNbS8vVmdNWS9QT21m?=
 =?utf-8?B?YysyTDZMTnptL1FsYzM4Uzlka1Zuek90SjF5dWRMRXdhZlhVY0lUYkZ2dFRG?=
 =?utf-8?B?RGlwOERjNmJYWmFlc2RBa1JSaklJZVFIdCthWUZENmYza1dJZGhlZkoxYnBx?=
 =?utf-8?B?cmFZYUtvcWRhWG53akJNWWZWS2JhL29VVXlrWlF6bFhHeDN0QlREOWpFb0hB?=
 =?utf-8?B?OGN1cVdWL3cvRTJwa0N4TDExaml5Mlc3YkJtOWplWFoybEFYMkZkTGV5VnVT?=
 =?utf-8?B?Nmp5ZEo0Vm5PUUQ4a0h0bHlUMlZLcllBZXVHVTRBV2gwYzVEYm5nTGdLa0FV?=
 =?utf-8?B?MEtHbTZmN2Z4N2FmdXU1clRFcERMK2hTcm54Rk9ML0swUnFCOStrRUllVXdM?=
 =?utf-8?B?cDY1ZGJ1c3ovejRQb3E0NE5mMElGYStKQ0tkanJ4WUVpSzBkRS96YzU0K0xl?=
 =?utf-8?B?elg5MWpPSjFlSWRkQ2dNNlNDMXZrOVVtVVpQOXg3NkoxNU9RVnRza2dlSjRB?=
 =?utf-8?B?Z2FKZ29VdEh5dE5nSDBSejZOVERPb2Exdk0zTWU3US82MGdtbVhQNG9SNDlG?=
 =?utf-8?B?end2c3RrVnhabW5hQlh2M1hvZnJ1NlJPR1l4alJyeXEwaW5ydjIySm5hSmd3?=
 =?utf-8?B?STFYdWdCSXlZalhrSVl6NzBlUk4zeDdkQ0hBS2tNOEhzSEovcUFUMmZBcWJh?=
 =?utf-8?B?RmlSK2ducVBWcjNsK2diNm9HME1BYXdROUgvTGh2cjl0WU8vTkZndEgxeTVB?=
 =?utf-8?B?ZDFRU3BMc0RBRGZpQzNHNStZek50cUdlV0NtOGxIOTgxZCtOYzhNaTVsSWJU?=
 =?utf-8?B?djh3WGplUDJvNW5BV3p0UDNERGxtQWt3bUwwY05rNVEySTM5eWtLZmdsb2N3?=
 =?utf-8?B?ditVUEJZMldrVm40UmFEVmZ2KzE2aVBYSUlmc25ia1JPYS81ZzVPZkcveWtZ?=
 =?utf-8?B?T3R3VmlyQlpFS1psaW5CMWcyL2xwZ3cxRUl0U1R5VFdSUDZTeFhIM3ErLzRy?=
 =?utf-8?B?TjZiK3h6S1huNGoyL21EMWlYUjZHWUFmbHNWb2pJNE9WYkpxMmFsTmFrQkI2?=
 =?utf-8?B?ejQ4UzZ0M2N6SXpiRnpEYjJRZWJMalcxRGpKK2tUVDZNTVI4UFZFYmhEL3Ir?=
 =?utf-8?B?OHNLanV5VXRtdWF6UkJ4Sm50enovN29XWndoYjNGbzZvTTRWRmdBNGFLN3dY?=
 =?utf-8?B?QTh1VTBCZGdXaHBEcGttMXh5cSszN0JOZ293cFFYNlFNZlNKamk4QjhiMnVv?=
 =?utf-8?B?b3NzTTdtRmZaSTJBM3lEb3d3SWl0a0o0M2R0eURyUnllcFRnUWhkcThZQlRz?=
 =?utf-8?B?aXRHTllicEt5OHY4dXlTd0ZDaDJaay9pWmV6d0lRN2xINVg3bERkNjN6MVQ3?=
 =?utf-8?B?U29rUDI3c2tDeHlMQnhoVld4ZXNaWklIbVJac1VCOW1UamNyZnA1OWpMZ2dD?=
 =?utf-8?B?eWNZV3JkRGErSXNmTU0zK0dXd2R6MDk1RnpNVHErZ1dMU0J5QmJZWENPQ3Bj?=
 =?utf-8?B?YzhaQWMrOVlQVHBkZFhOTTJZc2c2UndacXJVVmxxN0VNeHljOGlhVzBWSnBs?=
 =?utf-8?B?T1hMclE2c3FUa3VXN3diakxNVXVYdzJjTWhWZ3o4aG5abjRnOS9QRWQ1Ni85?=
 =?utf-8?B?ZzUrQWFNbkJOU2o3NXI0M2xvMjZJOVYxcFBUZ1QvU1dMSWtBZmY1OFBPR2dv?=
 =?utf-8?B?MXE3TnJFb2xHRSttWEQ0OCsxSzNHTmNmQjd5cVBIU2YxTXZuVHRVTHpNell5?=
 =?utf-8?B?MkFTUHhQRUVnemhpMzgwc2hJa05RMVhIa29JV2VURGpKOTNsekhnRGVoR3Fh?=
 =?utf-8?B?aDBHRUNQNkR4RHdiYWl0UU5LVE5uSnB3bkovSFNvSTJEb01BbWQrQXlFcTk4?=
 =?utf-8?Q?bEC9cng8ENI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:10:26.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a206e6-65e7-4fd1-50ce-08dddb5dd84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
Received-SPF: permerror client-ip=2a01:111:f403:2415::621;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Quoting Michael Tokarev (2025-08-14 01:24:00)
> On 14.08.2025 00:01, Michael Roth wrote:
> > Hello,
> >=20
> > On behalf of the QEMU Team, I'd like to announce the availability of the
> > fourth release candidate for the QEMU 10.1 release. This release is mea=
nt
> > for testing purposes and should not be used in a production environment.
> >=20
> >    http://download.qemu.org/qemu-10.1.0-rc3.tar.xz
> >    http://download.qemu.org/qemu-10.1.0-rc3.tar.xz.sig
>=20
> Hi Michael!

Hi Michael,

Thanks for catching this!

>=20
> This file (qemu-10.1.0-rc3.tar.xz) is incomplete - xz does not
> uncompress it.  But the signature is ok.  Something went wrong
> in the release process.
>=20
> The .bz2 one seems to be okay though.
>=20
> If there's some error checking missing (like we don't check for
> errors from tar - which might as well be the case in make-release.sh),
> we can fix it.. But if it were make-release.sh, it'd fail earlier
> and bz2 were bad too.

It looks like make-release.sh did its job okay and this is a PEBKAC
situation. =3D\

>=20
> How do you make the releases?

Roughly:

  pushd $build_dir
  $src_dir/configure --extra-cflags=3D-Wall
  make qemu-10.1.0-rc3.tar.xz
  popd

Then I decompress/build the tarball and run through 'make check' and
iotests on the resulting build to sanity-check the tarball, and that all
was okay.

However, I then copy the tarballs to a separate system to do the signing
and upload to hosting site. I saw the bz2 tarball transfer okay, but
stepped away once xz transfer started and didn't notice that it errored
due to running out of disk space. Subsequently, the bz2 signing was
successful, but xz signed also trigger ENOSPC, so that was
noticed/fixed, but not the fact that xz upload had also failed prior to
that due to ENOSPC, so that's why it's signed okay but the xz is
corrupted.

I'll add more error handling and an final md5 check before signing to close
up that gap in testing/publishing, and hopefully that should avoid similar
issues in the future.

I've reuploaded the tarball as 10.1.0-rc3-reupload to avoid conflicts
with CDN-caching, which is how we've handled reuploads in the past.

Thanks,

Mike

>=20
> Thanks,
>=20
> /mjt
>

