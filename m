Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75245CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbr4K-0005sB-8V; Mon, 22 Jun 2026 22:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbr4I-0005s2-IR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:40:55 -0400
Received: from mail-westcentralusazon11013042.outbound.protection.outlook.com
 ([40.93.201.42] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbr4G-0007g0-Qi
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxiUzqbPo/4b6h/6yAB8fD+V2ViZ08JtdIbu5fAKXsYhPyecH7vr+yJzsLhmKUtiM6y5rtD5hHzjFQAu9fGU25U8wtydbQ7vwG/InF0ubsNKs4PsgA7qRzR9febyDK9xb+eeEcw42R9OEB/2B4DdRQPlmkAEHqTzEv3wna7RE/yJ8vrKenD1wTth9zFitdPNZ/uXcDPMQFKAE2/VfTMFVM0jFHr9qFktP2CjrA1BTKoFyFIHvhowqb5uPpPgpRU0SoxHS0TpxyRKLHCJgyp/DO5R1hjMNlWY4C0yadI27kcPtewY3Sk5hdpFHAbZKWTrKsrfASkXXxclY9EQ5nWlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47uedUFSLV5LOeR/Ttju7mFuB1dPjkN71JlvWGZPpGE=;
 b=WryrFEdWAR9Dei4EPIjhoiO/42a5vlHcNUa2WiH5KKLeX9oyh0OttVbZxgRRLwjbqJB/6Sd8YQLqc8dfqoW9TZtTGnuPxRjC7kkunXJOE1Dkw7QobDEIsrFAa//ARkJDYLx754rXtQyMZTCsc2UIa5cACOoy284RVQdNh/lyoEyoJF5uani+plRQlYcojXceJPzK0a+IXkPrp/vL6G6LY5n/msxlxbAUMstW4p0iqWeo/Cygb/EEvkjc0wvTWNXgvdK6zueLcsOVkpDhRZzq6+LrKkQBKKAPMRZbGo5MNu2BngGizNZCJzlEbEz2drAWkhI6XijtR3LkuX7WcKKf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47uedUFSLV5LOeR/Ttju7mFuB1dPjkN71JlvWGZPpGE=;
 b=V7Gok+oYinIgHXoYidy77JHa3/eNWfYDHf5MH/rq4MbefeFT+UbBY/0gfdq+WIE9F20a4B3kMVkRjTj9zGZKAeC2YZFJ52nneqfp2ZC6Oaog/JlSj0VJ21qn1WEbsL76r5Y2aTPzm7yk7z9fDyfHDYrcdLJEjKPcvdnv0Ok5CQCWwUov3wd+eKn6buICz6U6ynGk4DOU5ydqQr31W9hDo3hLYz3EZQC+DA0pvjXvN2CTaXtztviaOhcUVBWM2zYjG0dOy1Q24MMMFw303vhaykCz0bMnexVEthz5cewGpLSD82w9gjkMt2c4zwCKtRrw+yG2fUshTtbMeLn1oVPFBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:35:45 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:35:45 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 0/3] vfio/pci: add vfio-pci ATS control property
Date: Mon, 22 Jun 2026 19:35:38 -0700
Message-ID: <20260623023540.836825-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d54514e-f2b1-4b19-179a-08ded0d020c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3rgWbGFojg+8tkuEuCB2z4r2cAeIedyBTXTQe6+FWyQbFrFhqWXj7hflOZ0vTgDWRTiFBKH+cTxgyPGtqwqL8UDbqHiv2iBIwe42myKtkc6qq2Gl0J9nkWy+JA/ZcZBemgqG93fkAfuCF3hvEvhsCMTPhsmbuzOWlyTCg2pWfkHdUwyDzR5HG8QdOWCej1ZUre35QNy2Hm+TKb/K8NP5hNFXsSYHoBpbj3fNM7gdQXR5fZCVhBPr2Q4yxV3biAKfZojGsHG0qRq4rnWmjTJpx6NMHAEYUlqaEfsvIND0K+NsZPeGB9L6H88z+xtpqmxBUwD7rqhzBM0Soey7CwY3xKVHUtGa8W48ookb4S0IITPaDlkghhNlzb+25oVca2w36r4t++Cwue1iFPU7oa4Qm4vwq9dFgF294x50Mee0BC8/cChuDXLbrn7iNTTlf0jFScHWSfTjiiaZlQEwGC2hR4jiuG2lhkiS3mYT6u1gcIHx1457R7vWKUzD1kzOeCE2g9Mr1TE2janJJ4U4VDwg3dOh4/KHAV1vqblcE4oLrzqNT1jRKiyt17LRIZlGSis63MYJqo+z46bgP8ALN7O1gtpOeV3DGKV5kL/nD0DEX9blN2hcwN1Minc22f3HapFseHLYEKpRuOp4khE/kfM1OS5G5/UPBDxXQmBBdgkZHUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(56012099006)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9qZXdGR0hrMnUrYk84aXFLcHh5TUJMVkt4c2dpWjM5T2h1Nkg0azhXVHpC?=
 =?utf-8?B?NXp2OVVBbVprSFVFRDdPMGFCSTBaRGVnNWtZOElqR094cnpSY2JYYlBGZ0di?=
 =?utf-8?B?MFI1K1BuRDhsTU1TRDV4dm1GckRIczl1cTMxWldhK25TRlRPZmFheHNxYlN0?=
 =?utf-8?B?V2FoZHlvUFN6UFc5OXlwWVpYL1dGNW1iaVErN0NXd2w5N2Q2L3YwaTk3dGJ0?=
 =?utf-8?B?WlQzRldXd0VtWFRpNFljaXoxUVIzUFJ1dlF4UzFMZitTMVBoQ09ualFQZWhq?=
 =?utf-8?B?TlJzTWRBQ0puNjJvMUk1eGdvZ3YwK1RtQWhrV1JoTzNJRDVwK3p4MkF5K1Ex?=
 =?utf-8?B?Mlh1L0V3MDQ5RG0yZWxnU2lRYU1VdVJWYk1rRi92dFdiMktsRlVzdWdGNlY3?=
 =?utf-8?B?aHdkYzFNQWhKTXAveHhNcm9iV0RqUFYvcndBVUpZZTF3cGZ5VmNvbGNCY2l3?=
 =?utf-8?B?TURBQlk1RVRQcnZLTmY4bkdOZUoyK2xKWGl2ZmVnbXJsM0xhcjdWWG9kV3lV?=
 =?utf-8?B?WHlsSzVldi9BQ2w2UG0zM0txdi9PZHNycmZhbU1ZMDdqSDFjc2h4NlpsVEtm?=
 =?utf-8?B?RmRHSUE2cVdDSkl0clFTS2NBNE4zZC94WXhYQ1hZZ3lFYjhpY0J6NFoxdUpk?=
 =?utf-8?B?MkcvNnBZbnQ5WW56OFpldzRuUlNMWHRiYjFLemFrKytNTGIyVWVhZ3RDQjZ1?=
 =?utf-8?B?QXpLM1BYRVdGTEE0SGpBaHo5ajNkYmREUDNVeXFsRk9ydC9UYTVSeEZZbVQz?=
 =?utf-8?B?S3psVW9GWEpEOXQvR1N0Y0ZDMFhJSGVlVm92c1RtOTE4YmdZREVlV0tiRFFE?=
 =?utf-8?B?c1ZEMmdjU3JXL29xclRrUzhKTC9GdmxlSWJKN3BLZHVXdE0xcExFVFpNMVlH?=
 =?utf-8?B?azY1QlFqazNIcDRSYkd1YUZvdCtNNFppY3BPdm1sWVcvU1g0bnNYUys1bEF6?=
 =?utf-8?B?bUVLekNoWEhJRUMvSStoZkIyVWc5ZEZ4U0dqNFUrNDZkNVBlclJUdHBvdGZw?=
 =?utf-8?B?R1Z5VUEyM0lyWVdEYjRSekQ1K1dUSjlNWXBIL3JhdkF4NCtuNWJvOVNQdUNB?=
 =?utf-8?B?RWF5SFhlVTFXcHZNVEZsbkp6RVhmcUJBQU5lWEE2REhpRTlRZDkxTE40Nk5L?=
 =?utf-8?B?d21uVHNvM2V0OUxtOXNROU1HYU9BQlhwaTIrU1h4bldiWXpvY3hWS3daaEZt?=
 =?utf-8?B?VlVqczl4TlJ5ejE3Z1V2YXhERFMrWjFIQlhnV0JwcG1OazNrQ1orYzgyVGZG?=
 =?utf-8?B?VlZod0VqUURidmR0dkRJdWFxWWVySEExSEk0d1VHT0JOdmJrNUhrTWRaYlJl?=
 =?utf-8?B?ZmVSZlB1aXY3NStYNEZIMDFFbWYyTERiRFQ4cW9JZkxoeUR0aElQejBGUkQy?=
 =?utf-8?B?VVkzamVnM1RqVGpDUTAxZ2NIdm4rMlEzRHNJS2FJUmFrV2JJRURwUFBqU1dW?=
 =?utf-8?B?T2c2dndiang5OTlaU0s1WXlEamlDanFCTmx3UVpPYlJ2WW8ybHhucHB6RjRu?=
 =?utf-8?B?bmdsWjgvY0NZbUxsZ016NDAxTlV6MzlyVzhQSjZzVG9xaVFVMnRrNGJPa2FM?=
 =?utf-8?B?SGtNL2huZHA4N1lCZkdOL2RBa1FjNjhScFp0NHErZERHSTNjTnRHR2hidHF5?=
 =?utf-8?B?OFdoaWdjL010Q296OEh5V2d2U1VnVzNlaUFlSWxCdFdYV3hWM1A1K3IyL3k2?=
 =?utf-8?B?ekdMQi9VdjNhZkY0Z3NxRTE3aFhZOEtRTENoMUlGYWc4VS9TTE93dVowRjRS?=
 =?utf-8?B?MzlwbFVjNjlSQ09yRTFMb0dDZ2hxU3pFV25wa2tzdm05WVBaQWpRVkhHbTZk?=
 =?utf-8?B?T2J6VExHazdSWi81MHkyMDBFVnc0NlgwYW1HTVMxdFBNVjNHYlM3MnFTK3Qy?=
 =?utf-8?B?U1lPa3UrSXI1NEJnZDBjQ0ZRRk1zcUFrRGtKcFlXRmNlNHkxL1psS3dlU1VU?=
 =?utf-8?B?T3RGeENOSjZTWmZTMUVCV2FQUVhVblB1NEdsZkpqS0ZZZSsrc2paMWpPREFn?=
 =?utf-8?B?ZGRzVWVoMlhETi9Xc2VlRVdzZFduQVRDR0Z0UXA4cGZPVHA0c2pMU3FkSHVz?=
 =?utf-8?B?ZVViYmZPTEJ0NFFjUVpnYWwyRFVrb2FzMy90Y0dsS0MrM2xuN29GWjBZYUFo?=
 =?utf-8?B?dWVaYXdCMVh5MnoxZTlWL1d3b0pVSkZSbGEwU2dyUWc1am5LbmRvVGdUMFZy?=
 =?utf-8?B?Wm4rWUlLZGNPMXVXd3ZlcHJHQWp1REVlSWRvMkdqYm9wZDBadW9MM2hnNXJF?=
 =?utf-8?B?bnF5SDV1Vjc0aExMa29nRVMzQ0lZbEQxcEpNeFJQekxnMC9KWVlaZ0I2d0JW?=
 =?utf-8?B?RzRsRzhkNEpFVURvcng2dmhnQmpTS2RUeVlFNk1oR0U4eUxsUnFIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d54514e-f2b1-4b19-179a-08ded0d020c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:35:45.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11PQwklpR8RJ8Kx5DZQUKKvnVZ9JUrg5r4qtatFBPq2AeB5vKd/uIRGt39n3IElQNgKsMGAymRW+iYdzgxzRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
Received-SPF: permerror client-ip=40.93.201.42;
 envelope-from=nathanc@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi,

This is a follow-up to the series [0] that adds an ATS control property
to vfio-pci and wires iommufd support reporting so vfio-pci can decide
whether to expose the ATS PCIe extended capability to the guest.

The new vfio-pci property is:
  ats=on|off|auto (default: auto)

Behavior:
- off: always masks ATS from guest view
- on: requires ATS support; fails realize if kernel reports no ATS
  support via IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- auto: masks ATS only when kernel reports no ATS support via
        IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED

We intentionally omit a legacy ats=on compat override because forcing
the value to "on" on old machine types can turn a host-kernel capability
update (IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED) into a new realize-time boot
failure. So we keep the uniform default ats=auto to preserve bootability
and follow effective kernel ATS support rather than preserving the old
behavior of always advertising ATS when available.

Please note that no linux-headers sync patch is included in this series
because IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is already present in
linux-headers/linux/iommufd.h in the current base.

Testing:
Verified ATS capability visibility changes with vfio-pci ats=off/on/auto
on an NVIDIA Grace system:
- ats=on + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=auto + ATS supported by kernel => propagate ATS extended cap to
  guest view
- ats=on + hiod_iommufd_support_ats modified to return false (mimic
  kernel-reported unsupported ATS) => realize failure
- ats=auto + hiod_iommufd_support_ats modified to return false (mimic
  kernel-reported unsupported ATS) => ATS masked
- ats=off => ATS masked
- ats=on + no ATS support in physical device => warning + no ATS ext cap

Changes from v2:
- Added R-by tags, thanks all!
- Fixed alignment of two
  object_class_property_set_description() blocks in vfio_pci_properties[]
- Removed compat override setting ats=on and added a warning to the case
  where ats=auto and kernel reports ATS is not supported.
- Squash patch for warning when ats=on and there is no ATS support in
  physical device into patch #2
- Emit warning when ats=auto and no ATS support in physical device

Changes from v1:
- Set ats_needed to false by default in
  vfio_pci_ats_requested_and_supported()
- Revise log prefix from "vfio" to "vfio-pci" in
  vfio_pci_ats_requested_and_supported()
- Squash compat update patch into patch for introducing ats property for
  bisectibility
- Revise comments and descriptions for support_ats(),
  vfio_pci_ats_requested_and_supported(), and vfio_pci_class_init() to
  be more generic, removing references to
  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
- Emit a warning when ats=on and no ATS support in physical device

Changes from "Resolve AUTO properties" series:
- Split into separate patches for support_ats() handler introduction and
  iommufd implementation, "ats" property addition, and compat property fix
- Rebase on vfio-next
- Remove unnecessary includes for hw/vfio/pci.c
- Rename ats_need to ats_needed for vfio_pci_ats_requested_and_supported()
- Move the vfio_pci_ats_requested_and_supported() call to
  vfio_pci_add_capabilities() so we can propagate the Error **, and then pass
  ats_needed as a new input arg to vfio_add_ext_cap
- Fix indent error in vfio_add_ext_cap()
- Break and add a pcie_add_capability() call for the PASID case in
  vfio_add_ext_cap()
- Update comment about return value for support_ats()

Thanks,
Nathan

[0] https://lore.kernel.org/all/20260615204849.3659647-1-nathanc@nvidia.com/

Nathan Chen (2):
  iommufd: Introduce handler for device ATS support
  vfio/pci: Add ats property

 hw/vfio/pci.h                      |  1 +
 include/system/host_iommu_device.h |  9 +++
 backends/iommufd.c                 |  8 +++
 hw/vfio/pci.c                      | 88 ++++++++++++++++++++++++++++--
 4 files changed, 102 insertions(+), 4 deletions(-)

-- 
2.43.0


