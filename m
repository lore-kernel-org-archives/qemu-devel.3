Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAECC369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 20:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7gRs-00076r-6H; Wed, 23 Apr 2025 16:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u7gRo-00071h-FU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:11:58 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com
 ([40.107.243.47] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u7gRk-0006Rx-4I
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSyzF45phfCKc6SzDZVgwvBp3+zpCSL7urKGutZTXhkdULvsawTZ1gI17IIt33yD4EXj0zk+SnA5VCgue3TGl6vzF7lya6cebFJ7Qd3hZ9I4AYWLfW2iHj3jS7gztKF1ITB8q39hUQMj2RGklX+m+zZ3ggN8lu7kDvB0Yaf7vYLOG66iSDkjGwkIYyVmEghAO1xjZi+Iif60BTw0ySmyYnpoVcKHnxzeOJ3fAoAgLs7x8Jq5yNla2nighsLKfvAkF/WF450ZAxy56j/eq7HIyU9mqf8BpBvO5vCSdWOHPNENMvQ6Z7VZ6TWZPXO65y8cjPUKUm6spRyvqswF5C/dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5q7ILQJ9F3/YWFm/HCij39V5Vtgn/aplqTz6Gsb3+I=;
 b=VTJTt8rvl1eoWd89bPgz1wkDaEb1CSTFmjzL8AFbLDrpVUaX4GvX3aFYK7U+HCe3+I+FpLFZ9PmDuJVvWxQXVjYf6iC0rWriLTnrZ8uzgkC0Z4cUUT2FkO5vgxjAeABpHOOGOUdsWNAcZaKqBPP1ckvUsp8l/fzPwnxpkpysfwgOm3e1ZBX44KwqmiKywoEc5r5/5wXIWcNVbZ2nGlV7fAavx5R/Bf4dnTM1BOQeso3P6trlO+LOUQ5KhaEcNafFblXT+S+uq10jc5o0y02I4E9+xgHOJcoPREZtNtOdxweKmKIByhQZAsbtVdB6pwUf+cV+4Ufu9eMsL/nITtau+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5q7ILQJ9F3/YWFm/HCij39V5Vtgn/aplqTz6Gsb3+I=;
 b=iitltk+Hp52/BhzvnvBzKUZUKoIGotrb+RQcBw+9Dc0hHdIt+1qJv2syMREOOL7TSQLMyYKe5Ugor7A/PZUv51738LlxBHQFjFiPIR0xk2mYDgdCfZ4mwn/OYtVhYyoMdO87pPWskiWQHfFCklTKgj0MmVQG0ePmV0xx5XHjDZE=
Received: from BN9PR03CA0283.namprd03.prod.outlook.com (2603:10b6:408:f5::18)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 20:06:41 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::23) by BN9PR03CA0283.outlook.office365.com
 (2603:10b6:408:f5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 20:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 20:06:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 15:06:40 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Apr 2025 15:06:25 -0500
Message-ID: <174543878540.10784.8076246482730735433@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa176cd-4cd7-48a1-ca13-08dd82a25c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|16122699012; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjR4NjYzdk0yOUNwdEdiQkRQbVpuYndVSU1lTWpHMTBwSG9YT2FYMHhmZWww?=
 =?utf-8?B?OXo5bW1YdnVNVVBqRjVJcjhWTmNMV2FVdlYzZmdsU3JSM3F4bldYSGdFQndz?=
 =?utf-8?B?OXZMdkZtc3RwbTBXaVllZmFFNjgvckl4ZW0zbGdsZktURlJLYkU2dVhzVDJ2?=
 =?utf-8?B?ZUt2ak85NWNScjJEcElETDd0Vk9iWU9LMkREWVVRVVQyK3I4bzM0QVNOVU9U?=
 =?utf-8?B?RFJFeEYwaHI2MUxyQTdCbzRoTHBzQ0hqVUpYcEZ0NHlrTkpCS2xWQjhUY1JP?=
 =?utf-8?B?Q3hDc2kweUJRUVUxY3VuN0NwcHBWVVVjMlY0NU9ZOU9GUmtSUndoWVE1YkNi?=
 =?utf-8?B?cm96T1FZTng4ejJNeHk1bDV6TTFydlNlRVdPNlMvVGZCTk9ldVlMbUViRzlw?=
 =?utf-8?B?VGROY0JQMStIdmhJdGdOT09PSldKSnB6QnFPM2xkSTVTNElRVVJHeDlMUTVt?=
 =?utf-8?B?Yys4TDdmWCsvK29HajVEZGpZM1daTWlhcG91Q0dZOG1Gd2ZlOHpWMzBBcDdS?=
 =?utf-8?B?N1hhTkJqa21qOVNSOUYrVWoyL0tnam5aYm1KL0RPTmdqRk5YZ2pDdjVpY0g4?=
 =?utf-8?B?T3lmTURUSEJ1c2cwYWtZRy9YZGxsTkNsOG11ajhDd0RKMTk2cUcyakhscWR5?=
 =?utf-8?B?Q3RPTmEySExUSFMzSE5YS2kwY3ViMjl2SDVFY29oYVhmWkQ2ZDVFWW5nZGxT?=
 =?utf-8?B?WTRTMmN2T21GK1MwTjlrUW5NaG5rM2RNTHhkeXRGUzduMEZKUFBIaVNmbXlZ?=
 =?utf-8?B?WVBaUVE1T3R6SmxZM2phS3MvN3hHYkRFa2RmRkpZdGIvYTJLM1lKNFhUVmpq?=
 =?utf-8?B?S2xzT0wxNkNBZElUSTQrT1hwQUtYakZkSURibTZOR0FLQzNGUC82a1JmRXRT?=
 =?utf-8?B?c25JcXliZjVmMWFEaE1RekkvWGNYUjArblM5akNYK1pWQmF6SXhDN2tzTFcy?=
 =?utf-8?B?V043NzQwVUtBYmoxNWVGSDVKRGN6am5mRmhkbHcvZlpSSFZZaW8xbE54SGE1?=
 =?utf-8?B?MlpvUFljWmZvNVpDU2RFeHdvL3R0Si93MnJZb3dDamhHS3duVDlucTh4b0R4?=
 =?utf-8?B?b0dCTjJPRHRDTkVJODN3RVJ4Y3dkRHkzZ0doYVFOVXJxeGJjQ2dhMVBhUVhP?=
 =?utf-8?B?TUs2Z3FOZjF1WU9kSi9kWXA1WWFiVnJTRDBqaHRENmJETmFHbElZTmFoTFFM?=
 =?utf-8?B?a0FaRk84YjJ6dFBaejAyaXNleU1wNFJtbGpBRG1SQSs2RnFQVnU2QkcxMktO?=
 =?utf-8?B?UXM1R2piOXZoVVNlZ2pYNUdidGZaOHZ3UUhFRkY4SXFEbFZDcFVnYi82R3Bn?=
 =?utf-8?B?YzYxQm5sYVFWN1hUUDREVkVDeDZSNG9PS0ZrZStsYXo2MTczMmhYRVM1MlZI?=
 =?utf-8?B?aXFNRUc3UjAySmxVb29leEVkdkMrMzNxd1B4WFlYZmdTWEZvQmV0dkVUNDUr?=
 =?utf-8?B?NCttTyt6aTdHWVQzUzdHZE1pRnZFaFdydEtoVVBCSWNESXVjOVFmVGRlWmNV?=
 =?utf-8?B?V3RRQ2FMSTJqb2ZzajloOFYzdlVrWnEwd1B3NjA1U1hnbXdzRlh3U3hkSStj?=
 =?utf-8?B?K3ZDNkdDYitObW9lVzlPSnpzSjVsbGhid1QyU0tpMkwySW5ucTVsQy9PTXdT?=
 =?utf-8?B?L3p3eTkyR1E5UTR2cHpqdzE3OXZXNy9QRGRzeXA3c1BxdEFaL3dIOTRSSlFH?=
 =?utf-8?B?NXFRVG1rOE0vT01RZlBVWkVkcjBwb0tJV2JUTHVSZzBIb3docllnS2RGZzkv?=
 =?utf-8?B?UFQ3VFNIQ0xRd0F6aEQ4a2lOdGl3VFBOZXJrUnYwRUtDWDkwL05OZGY2RG9W?=
 =?utf-8?B?SjZidG9wQlVOdUs4b1BoUTI3djJCWkd3UnBSaUtqUEc0czRFK0FEZlh5azF6?=
 =?utf-8?B?WTYvMVpCN29KZ2RUMXVJVjN5VWxUYmV3WTMyK2h1YWJFMEY0T3VWSVpUOEhi?=
 =?utf-8?B?NUF6WXc5dHBpbXVGWCtOTlRUcXlCR1VmOE1RM05BblVWcUhhaHFPQmI1RENX?=
 =?utf-8?Q?izsUnROzdpH6vY6zYmHAzxVpTnteX8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(16122699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:06:40.4357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa176cd-4cd7-48a1-ca13-08dd82a25c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
Received-SPF: permerror client-ip=40.107.243.47;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 10.0.0 release. This release contains 2800+ commits from 211
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/10.0

Highlights include:

 * block: virtio-scsi multiqueue support for using different I/O threads to
   process requests for each queue (similar to the virtio-blk multiqueue
   support that was added in QEMU 9.2)
 * VFIO: improved support for IGD passthrough on all Intel Gen 11/12 devices
 * Documentation: significant improvement/overhaul of documentation for QEMU
   Machine Protocol to make it clearer and more organized, including all
   commands/events/types now being cross-reference-able via click-able links
   in generated documentation
 * ARM: emulation support for EL2 physical and virtual timers
 * ARM: emulation support for FEAT_AFP, FEAT_RPRES, and FEAT_XS architecture
   features
 * ARM: new board models for NPCM8445 Evaluation and i.MX 8M Plus EVK boards
 * HPPA: new SeaBIOS-hppa version 18 with lots of fixes and enhancements
 * HPPA: translation speed and virtual CPU reset improvements
 * HPPA: emulation support for Diva GSP BMC boards
 * LoongArch: support for CPU hotplug, paravirtual IPIs, KVM steal time
   accounting, and virtual 'extioi' interrupt routing.
 * RISC-V: ISA/extension support for riscv-iommu-sys devices, 'svukte',
   'ssstateen', 'smrnmi', 'smdbltrp'/'ssdbltrp', 'supm'/'sspm', and IOMMU
   translation tags
 * RISC-V: emulation support for Ascalon and RV64 Xiangshan Nanhu CPUs, and
   Microblaze V boards.
 * s390x: add CPU model support for the generation 17 mainframe CPU
 * s930x: add support for virtio-mem and for bypassing IOMMU to improve PCI
   device performance
 * x86: CPU model support for Clearwater Forest and Sierra Forest v2
 * x86: faster emulation of string instructions

 * and lots more...

Thank you to everyone involved!

