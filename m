Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159A0FEDA05
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJS-0003xz-Rv; Tue, 17 Mar 2026 14:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJL-0003um-Sl; Tue, 17 Mar 2026 14:38:35 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJE-0002se-UN; Tue, 17 Mar 2026 14:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMHegIbGLscFBCeDMd5FXSC1xFos+6AVffLfUBNfB8fwdTQePt0xjR2VIeA9wdFylxH5l9YR5jW56o06EwnBEDYPI6Md7SubQbW1aeIvwiGc9fxHExQmblh/UsLQn1FaGCutflzqES747POWG4TY4t6ID7APkQpydFQujRC6PGR7gLQIkz5tI0C7ZHtciJ/bnqBGg81PoRi60NSNoatZAQrmtv1a67ipEkdM4GS5aFMdCBNhNxqJt+qBNoh4fzOlwhkxHC97WaaheKPHt5GVmi2rAxWnf+PDwaFOL4qGX6Ct4MtjvLZW+8A0NQP2Jc49DxiSPm9NYuMnARA3UXcsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekHUfECvxRuKT8kvOoWjKOxGLk5CouunhGs7NhJ3GCI=;
 b=yYwWcGsNxRqLMcgBTQay6O6jAcBjoYZIPsH6HDNXHpvYNj+LbKlml3OUpECAWF8skd9s8KVbTa489S+dZbZnmBECzVmp0Zh0x+/FImhP+lgf7KYPmuENfKDJ1SKCoqAI+PWUI26XsxO6L9No+2rU3P2otLGSYuIeP6LgwtXaYuHHAbOejyQcYiqmzb0iVaAcij6mAVCRu0O3cUxh03kbv1L1rMazWHvWaYD1FJcEkKbgj5mMXGlbBdl3Jcbuf3pPQfmnWHzNfqqeNJribBi5StjV6na5wxuK7wkAo8F3gPhnSfKgSm8v+16RnSv3IoezTc0xGhQGtkts9RGxtGBuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekHUfECvxRuKT8kvOoWjKOxGLk5CouunhGs7NhJ3GCI=;
 b=t8in0arJMRae8Qjp0uAUR6nfml7gkRYpIRv0HI352OAXmiOtzx6sSDk0awuE2404eq7u+uwvTlsQTSrHEhxDRI5HiDr3WxhJxRTknAUBIr7b03yA/M85M4HmJCjl2aLx/lYzXKwkXkxAC/f1SHhzb/Wg4J7zNOX7IcApP5SoulyyME0vQjQAYTmlnodlpP/2xutlAb3W5v3cUYRfeEdj5tWBTp+YeBWhYi9cLjH+1oti+gcxdAUxzcq8vxINJSJVdsS2znpzIBH/KS9HuGEx47iODecwJ6lFus5hrpIbZUxC+N12HwqUnXCr9jidhWCJ8PGpC/FfAOobzEBDU1XFbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:18 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:18 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH for-11.0 v3 0/8] hw/arm/smmuv3-accel: Support AUTO properties
Date: Tue, 17 Mar 2026 11:37:47 -0700
Message-ID: <20260317183755.3721625-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8f90e0-6c48-44fa-5001-08de84545bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /zexTEsLxN5c+rkVcRN3Zilslakb17xDgW8i5fD01atMNC1EKYhMybDLNuwEPr2bWyhKO0KJOMsCmN5ZekWz2/CDxJln4UimZOZBJSiCz5wToNG7M9rV9KzSoarxQE5n1jt3MiCMl3CJGZe4W+tNJQEZ4/PmEfVdS21H9SAvdb8/mbFq+xQrB97utuLdgf+sTiEcj7iTq6ghTSYBTcAw1emqDNEQhs6XMizsJucahfACGNMpLGDqOvcUItdFWp7Cq5oIvdY54XNX/TMfuRBk9tR3lxrvKYgklhDlel27/qtKvkLuLUgBpaVk7+pUyvJEZNmjFE0es+CyJf70Mph61r4wh/yUoXNeKSpQAHDiVVdq0V+Jl9MQZGLazqAB0oozAdL5BxQzdnG726OI0CyCS82ESX2ijqRmZaGo/W6eGw/CMdiT+JGLN8C/KMqcPllXfj2k58fs5HhxKG+axiIxDiLh9yF2PSFnoE07feu+y0btHbFz+hikmuA29KrBqPFLriJWM7lr4R38tSED/Z6En0BMTFaxMx2ti8Lm8HGdI2Mc+VHmLvqv7kGcXGwnuKzJsiS67xrHnnVha4sjptys56kg2oe0nDGkxAzuXOpOXWlS/HID6xhEUE6oq1dXEiZvV3ul93Oua5nP7IbKYRlv1bS5eZE8MhyJ5iHPPuLlM8UnRngdWiViLWoGRxqvdQ61H9pz3Fi78S8CiDBsJG+aud3bZMPe2AVkejnhXrFs+aA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NE/TRhAfZGHTV9QbUrewXdmstTfADdFNDmgz2SL01RraAWi72LV4GjZfZpU+?=
 =?us-ascii?Q?2g0oQkrCWZ5QY8Yhm+RY2nVXoHsIP0poWl7Efrc/OImA1oXduQuguj2YZ35i?=
 =?us-ascii?Q?dZJWo6HLR4Zp4xIZLWKqrAJ/A9I77yPA6/5pBUnjxSgZ6TQmyM1G+/X0kgfT?=
 =?us-ascii?Q?lbL5EdKMKcvHXOewOvuzjnzg+iy7an3VycOAcKm3AxpgM8RszEMPt5tpyTNq?=
 =?us-ascii?Q?LIyeYr6BGyeNsv1DcXRaS8Og69idtny+K+tBHMyHFVSScYIdeMQ9daDq1snD?=
 =?us-ascii?Q?LXnqWdMVK6SQ3pnfAvtZBqSyNpj69LduGdtrW+KXKKb8+LHsR99eAAf0EqUW?=
 =?us-ascii?Q?yScrzqJrRrJ7yq2NTLhs1plvQc28+DmBOXgeXIfijyF7juVtqGkWK5eZ1vXl?=
 =?us-ascii?Q?1dV/WVjrQP5t4BQ3zpOVdYQtDfF837ML3GrvTQmntYIX1IQRLxXFMkuWYizh?=
 =?us-ascii?Q?e7xVtaIZZpZYWs8X7SNN6NB590oJ0cidHMLUZXYito3X8eMlcpHBGkwAsYbJ?=
 =?us-ascii?Q?mPslBcrKqENe8I48QF4+5YLCfkwof9TleyjPCnprLF8b4GkgjZc/8wSRzCjV?=
 =?us-ascii?Q?nEEpDkV/8ZrJnq9BukkDVzmGQjemuIzmSAMGJePr95bKIMBNS10MD1HPCwAe?=
 =?us-ascii?Q?1NXeLfsoB9hIzH6MBB/qEOdyhzA4KTvwfXyCU264hpfEIHcC5pcGfRRJM+O0?=
 =?us-ascii?Q?GmEL2Re7YAx2JBgcrpp89c3L7v1pdJMYS6qxGK1PM2akyhnSPYexhXjD0Jvc?=
 =?us-ascii?Q?+eu12P8u/m9bEEZeLx78mpUXOxR5hraMpadRHYyOjSDc3ffV9zHIBfmlffhK?=
 =?us-ascii?Q?r8VmMJska08v0w4WaWFgiSGI+4+aGU6ROUk8uJIdYOD6KndntLAar43GCsi9?=
 =?us-ascii?Q?wVXS07KawjI9j47xMnmp1Z/BBC1haR3W2rRNAmdoByGbT8VFWbzupzQEHtSx?=
 =?us-ascii?Q?A8QDKiW5WoiXmfY0uE3SKyqdv+QASEkAGIrmPREp4pI02KXOJJXZP4wuAshL?=
 =?us-ascii?Q?h0rC/BTq0uKaXDL8NGfqnOD8Hd42XrulnYk+pA3/CD/NgD/xxmaXmm41szAN?=
 =?us-ascii?Q?mjt136KJiSfgIrybJaKNUONiOt8CdFbR6ff5jiLETYW4gGF9lDQN+aV6ZqUK?=
 =?us-ascii?Q?eZH799IKKxJTQb1i4MfqU/EuXRrCpBhlW1CPOt1OlUEMQ1PJk/Fwdaw4pIQo?=
 =?us-ascii?Q?PsN26ZpfTQe5yF6VEFC0ePXbCANrvdYb68/y1Gt+P1kxhUgSNXfL3Dhou2VD?=
 =?us-ascii?Q?iHkNkz1TRc19s2UwNd64dx2z95A21qr1vYBcPmPXut1TdZByQyh7XxIVNUuW?=
 =?us-ascii?Q?H5FaAi7bYj26nmqgghjtwzzSHvTLR5DtnvmaA/hx4LMD0ybx0+8zt4JWS9sS?=
 =?us-ascii?Q?0LvkEiATv4A1Hz+SqcPWPu91wkyIpLVpfhU88uLhkINDuJaHH+U+PWZcB2At?=
 =?us-ascii?Q?OfoeYrTy8ey2ZcW+lsHq1vRccMRxkVgbgzsg+eUnA5UO2rVW3CfG++XtOquB?=
 =?us-ascii?Q?raR77f/YMRQUfwXw3FJqu8L/HBKaWwIlE3ArpHJSTXsXSQZenroyv/JkQIs9?=
 =?us-ascii?Q?d2amUoJtSTwV7fvcJm5t83drg/FWqcOkmc5Qno9fAg6wKbL5hp1n3/uic6nU?=
 =?us-ascii?Q?FRGqIaEEvAqTjSDGgqLADLUfGQJLo0CC9RuHRg4F28TVS7ENF/eNtzFXJ2T1?=
 =?us-ascii?Q?TlrylB1u3RhACwmIU3iMsa9vyOpexkj55mJCsHnZKboaxsu+LPF4DOi2IeiR?=
 =?us-ascii?Q?aQpRQuCYBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f90e0-6c48-44fa-5001-08de84545bc3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:18.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv9WGivFghpuRGjC7NlOicfmSDa4Uc8WlSB05ZcC23zY277lLK1ol4qvSnirLhv02L5VdXRQtv4VDlXbvA1uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a follow-up to the previous series [0] that introduces support
for specifying 'auto' for arm-smmuv3 accelerated mode's ATS, RIL,
SSIDSIZE, and OAS feature properties.

In QEMU 11.0 we introduced new options for vSMMU [1], but feedback received
when starting the integration of layered products shows the need for
auto/host-retrieved values. To avoid breaking JSON/QMP compat, we want
to fix the option types so that they can later support the auto mode. At
the moment the auto mode is not supported though.

A future series will introduce support for resolving the 'auto' values
based on host SMMUv3 IDR values, as well as setting per-device ATS
capability.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-v3

Please take a look and let me know your feedback.

Thanks,
Nathan

Changes from v2:
- Enforce 'auto' value not being supported for HW-accel SMMUv3 props
- Revise docs to mention auto is not supported and these properties
  are only applicable when accel=on.
- Only override non-defaults in smmuv3_accel_idr_override()
- Remove check for SSIDSIZE AUTO in smmuv3_accel_idr_override() as
  smmu_validate_property() checks for AUTO beforehand
- Consolidate comments for ssidsize_mode_to_value()
- Include Fixes tags in commit descriptions
- Include R-by tags from v2

Changes from RFCv1:
- Remove changes that resolve the 'auto' values based on host SMMUv3
- Restore defaults values for RIL, OAS, SSIDSIZE, and ATS
- Update OasMode to accept all OAS sizes instead of only auto, 44, and
  48
- Include comment in SsidSizeMode schema clarifying enum value
  ordering
- Replace ats-enabled prop with a helper that accepts the dynamic
  casted TYPE_ARM_SMMUV3 object
- Separate out guest vs. host ATS check in
  smmuv3_accel_check_hw_compatible() to a different commit
- Document accel, RIL, OAS, SSIDSIZE, and ATS properties in
  qemu-options.hx

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Additional
testing and feedback are welcome.

[0] https://lore.kernel.org/qemu-devel/20260312210328.2016191-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/all/20260126104342.253965-1-skolothumtho@nvidia.com/

Nathan Chen (8):
  hw/arm/smmuv3-accel: Check ATS compatibility between host and guest
  hw/arm/smmuv3-accel: Change ATS property to OnOffAuto
  hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
  qdev: Add a SsidSizeMode property
  hw/arm/smmuv3-accel: Change SSIDSIZE property to SsidSizeMode
  qdev: Add an OasMode property
  hw/arm/smmuv3-accel: Change OAS property to OasMode
  qemu-options.hx: Document arm-smmuv3 device's accel properties

 hw/arm/smmuv3-accel.c                    | 43 ++++++++++++++++++----
 hw/arm/smmuv3.c                          | 45 ++++++++++++++++--------
 hw/arm/virt-acpi-build.c                 |  2 +-
 hw/core/qdev-properties-system.c         | 27 ++++++++++++++
 include/hw/arm/smmuv3.h                  | 11 +++---
 include/hw/core/qdev-properties-system.h |  6 ++++
 qapi/misc-arm.json                       | 44 +++++++++++++++++++++++
 qapi/pragma.json                         |  1 +
 qemu-options.hx                          | 35 +++++++++++++++++-
 9 files changed, 187 insertions(+), 27 deletions(-)

-- 
2.43.0


