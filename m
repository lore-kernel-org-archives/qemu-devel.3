Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C4CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYR-0004dm-8t; Wed, 27 May 2026 18:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYO-0004cG-QM; Wed, 27 May 2026 18:16:44 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYM-0002B1-Ps; Wed, 27 May 2026 18:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuNlK1E6h/nMg+Mvu3VgvPDciBB3Bh1LF2azdT9tb4LYdUq8rZzQhRtIZefIHTOGpM78q42BNqRwc5Aciz6+AioqnvtnkmEULUVddYd2MhMDJjKpxHwNDQapKwwo6EQjXiFoxiZrwL3rmnXXKGbf+RUqun9QMVROnw2Ykuzcs4MiEggppMTg+qHecVR+lND4xWLyWy+IaW9rc4o3J1SXPtdVdjJFJGXa5pP6q6dATfrTCq7G77E72w59JnQlLoqTI9LSXAaATHkEgiju4N5XWDzycng9hOJUJcADihxEokf9u3RXI+RCkIST7k9I71Bbc7/5YEPSSgEePPDhtL1roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlYK4cdlSNZHdola5ETVAFHx8wmX7zrw7pJdgM8Dr58=;
 b=Si5sb0hPzZzvycSPbzWXXUX21M0IcfUd6AkQ2qrEcHsfx/W9w7S+85oKHVvltOXfoZWrRWcum5yXrgQbe7T3b8POAqTQ1rZSL5ZWORC+vib5JFAYGqiArCDZk3Pf3l24x5uaBvyzZuOIgfXQGJsZGLFSeJfVxdmeDidINiHDebJRkB6fLlrnRKotg9WJtx0bwU8UUEQ0p1Sjb1r7iPtm6+OxKdyXixGc7xd7xEQh8BN+AI+Z1JHY7RWIPUIl4n/XpDvikHHvzb4U0EatsKLreqCzcO53InggMOnDn95rBLDSaGJJvZTf1lGCGLei6d59Fl0k3nTp5HlFJ3OH7eta3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlYK4cdlSNZHdola5ETVAFHx8wmX7zrw7pJdgM8Dr58=;
 b=sJlFPwZrlxsc1/j7fYsk1QFUJtkWnqo2UQGfd+x2qQvu++mVwVd28zWBCeLrzoTPHWGeEGjSCkcGP/xOysTM7RWJlpxBhPWOEDiYeQZF/js+eEgQ9qS8z9xxHjtl2axR3tIN6BLFvAZNW+WJApsh7qpV3rQ4qvF7SGz6pPVL+Lxger8FjvtegpaF+98uiWSm679SYmTz407Jt0T6HQZK8EgkM8fhVaLxLEtBXyVqmXEGtjtZMr5EoFcp6NrXT8S0wataqTOXL0K7LEkKLHJ3T4BKxGG98PGBHAEL5sHML17oqCLwh5xnbpbVAFaP/qptDt5TBg/j+mF2UzWohyQL0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:16:37 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:37 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Wed, 27 May 2026 15:16:22 -0700
Message-ID: <20260527221631.612026-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc8e382-f4e0-4754-bc74-08debc3d9e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1z15XloE/4ZRB3y7tgrWUU+NCxEQo95N314vS7arVzxzJBBQnJpZ1wF/ZljgkAsuvoK2i7R7Q9GO2x/vgT869Uhg/5bxoII1UNlNj+L3koHrrwYBC49fiJx3cPV9tFvDjhB487rB7feGtX3511fkd+ZbF56ZOxiCEFZboeuylmjoWECUf9EkaxKx487/EdlaxTfe6QWnsdcXrCQIfeq2WbgXiyj/Sr+ytj2JhaX38TMukqlThpWoCAR8jlITykIP0sUkQmo7y3Fjw/eKLgD4kNpbxwkyDqvtai8asL/9XkJQN5A73Rtd+qEP1GkOoCGsLrTDPDnlulKNRsNsnfJRZmxXHhzR7mc5oU0fbmpQ5Du5X015HhJXgw9hI3C1y4BewmI9gO/DLrem4j/lB3bdyZp5EsNfteWrmQAhI18DZSTpapb3In8lezia5oPwlZwweUaELchBaqXFIkSZotVvXRzJoeGxWthMmgWpvCODYz0SUGUr57E4B/vJg3UUCOdZPUclwXzT+9CY8BeKA/FyDtRc1mwdKthOabZ8nc6SGLNVD0Tt/E8L8Fzws2Ag0C41StRvbMyyc2DDdq0rDdEQvE+aHEXhZx818YbnARzj1humzX+O7aCN0mpM1D4Kannzaly5JxfEP3ECFkjuTEoq+VKzZSwQkoya/SaXCPCy7jETR1UoJDQOWSXtynH2f5qEfNf1ifvEXBGavEFZhEO0iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWQxakhoakFSZlQ5Z0kxQXM1eWdMQjJYL2ZkTyswY3dCTWpPdGxCM1dYNlE4?=
 =?utf-8?B?eTZWSDFqeXU0QVpsU3FuSExLME9zbS9NVSszQzlGYVgxOXd1ZE5IV2tEWmJZ?=
 =?utf-8?B?cUNCSWhqbU95WjNrczVhaXI4dzBUVzRHVDFtUCtSejlCd3FNaDFtKzMveDk4?=
 =?utf-8?B?bnBkZ3YwdzVhc3A0ZmlkUDVmN3VEczdTVTJtWWFWWHI1L09Zc2FEajBEcXZ5?=
 =?utf-8?B?c05RM3NUQko3ZUdRRE8xQ0xLblJHRFVEMktDRnR6WmxqRHo5R0xuc0EvREVU?=
 =?utf-8?B?RmZob29DL0pqSXQzUmtMVGc4STNiSURGNmNPWVk4ZXdFbDdFTWNOMk9jdDJr?=
 =?utf-8?B?elV3Ri90ZytTelM2MWExTUNmUkt1cllDMEhoQUtuQzRvUjRBVGRSV1FWdUxP?=
 =?utf-8?B?RlZsMUFRZ05jVExoZXFub2lCdDE4T0IxY0J1cEsvdE9NRlRBNG1ES0ZoOFBO?=
 =?utf-8?B?c2Jrb1RmdzVNTjFQaVIvOFlrNHAvUnIySlNtanZGblJCTFA1bXB6RW5WK01J?=
 =?utf-8?B?b3BIRStDYnMzM3k3Y0p5Q0NHdFd1amFlTHZuMkZCU1NTZnkrOElLUlBER1hU?=
 =?utf-8?B?cEtLWXgvNytVTGNBMUoyOFhNa0F3bTNLVy9IeHA0ZG96aUdIV2V2RXd6cWhD?=
 =?utf-8?B?TmxWOFlCOEtzT0d4U29wajlnUHAyQml5YmllVlFsTEV1VWJZajJ4aFhZcmo1?=
 =?utf-8?B?bG1vMksyT1JUMEgyU09COTVrWk1RR1d3M3cxanY1Y0FPT3JXOVZkTklPYThV?=
 =?utf-8?B?clBxa3BvY0RXRlVGcWx1NjhoYkdURHpLZEZ4cElnOWxrM1lJN3E3QjVMb2Vt?=
 =?utf-8?B?ZHJ3R3NJOEV2M1djTzBEWFFXQitxNmNDeEVRUkVWV3kxYURtWFBVbXRxcUc3?=
 =?utf-8?B?UzdEQ2U0UmlLby9CYVJQVGE3cVR1QmZFUUNIeklodzdzMXpFNHU1cXF0dlB1?=
 =?utf-8?B?dTJjaWgvcHNGMW5KVHo2aWFxVHBnYUt4SlpGTWZuZ3FaU1pGL21FU2czUS80?=
 =?utf-8?B?cWtoSDB4UERhWnNXc0JSWTUvTDNNQi9qRnFWZS9HejFrSUV2MWhpTjJLRWdQ?=
 =?utf-8?B?ME9lL20xVkN1d2VDVmI3bFJ3V2NYUzJoS2VVc2dQenkzbXh5aWx5L3hBQ0xi?=
 =?utf-8?B?Y085Mk1vV3hOTFB2S1RoR1hiaG9sbWJDaDNnOU9vN0ZmQ0svcnFsSkxDcnh1?=
 =?utf-8?B?d1hhYXlpSlB5R0hpbHFXMDZyV2NOWnZSNkdna01NQk5JRGljYmVheEhvUlk5?=
 =?utf-8?B?SHpTdDFQNEJmOUhSOVN2VE1CMldFbGlsb3Nidkxka0tUWmJQNUhvTjNvdWpl?=
 =?utf-8?B?SzFremxSYmNIamIvWTljZmdWenJhZmF3Tm1TMytEK1EydVlxZXhxaU1tdlJF?=
 =?utf-8?B?ZThTNlBDRTc1NUpGMlhYeGVuejBQTG9mMzkwRHE3eFNZaEk4THhFSjZtVTBY?=
 =?utf-8?B?VnBNc1ZyVDZhdm1JVVMrWEFyNk9VdVBOdVg3TGdkYTNQMFFkYUFnZVcxcnNR?=
 =?utf-8?B?aFB3eWUxL3VmS0crQ3hWNE8zRzdyUnRWVDI5RWRCZzBkcjFxUlo5WDVobVdK?=
 =?utf-8?B?Wm1OdFJIaGs2SHZaWEhpRmtQRzcwano5Q3FKRzZ1OURIUGk1bzY3ZHlFeXR3?=
 =?utf-8?B?QUQrb3NFWndxSGh1MUg3dW9mUTdOU0F5L0VyM1lTOUFQeXBIVDlZKytSWllm?=
 =?utf-8?B?MUozMU0wYmk1SlVZZUM5TVZkK3lCZDdIRjA4T0dzUXdpcGw3alBtUzB4UXBF?=
 =?utf-8?B?Q1ExYS8wRXN4ZTV4Qmx4NmMxTVN0c1BNdysxT2ZMTjROWUNhS3FWeUgxMC9z?=
 =?utf-8?B?RmdwZ3I4d0ZhNVVzVnZJOVVpNkpUWFBFQSswYis1RDRpNHYwRndIdkEzaW9X?=
 =?utf-8?B?MWxuOGNoZUUzS1h6Z2NuS1hvMUkxLzZRNzAyQ2VFaW5manR1UzlvTU0yRjNK?=
 =?utf-8?B?Q2Q2Y0VPNmVTRlJxTnhqZS9JaEIyQytkT1dVTmNJSEVGQlN6S2JJbTNPRUwz?=
 =?utf-8?B?TmlYVHlXeGVlZTJDV1hyM1BtcXpPNXcvbXBtRHlDQUFHUXByRXpvNnpyVy9a?=
 =?utf-8?B?cHgwbEQzVEUvZzNwQmtOVUVEajY3bmh2N3ZmMU9vWnFDSEVyeW42eG1obk1Q?=
 =?utf-8?B?a1pVS3VZL09vWFIzSWx1bkUrZkNjRTYraG1mcG5hdUh4U1JkRHNKWVIzMXhN?=
 =?utf-8?B?NU9qSVYxdThVaGJKK0wwVGNTVVBPOGdjZW43b1h2RStEU1E1R3pNQ3dvOUR2?=
 =?utf-8?B?SkU1ZlJuMkVFRzVadFZJamNac0dJQzBISXgydVpIa0ZxZll4Zm5pT0NqaXB3?=
 =?utf-8?B?dXZDR2NBV21xYlNJcG9qNXc2ZWUwckJjVTdLYkkrb3ZHdXFzY09lQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc8e382-f4e0-4754-bc74-08debc3d9e76
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:37.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCHf8GGy6EVuc04BLqLVAN7W5UEZvc8ZZ+7hyRC4XWNz38OEpEqwjUivo1P09WJXl/JpMKQbctOTAr47c8mSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This is a follow-up to the series [0] that introduces support for
resolving 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE,
and OAS feature properties based on host IOMMU capabilities. This is
dependent on the series [1] for changing these property types to accept
'auto' values.

Accelerated SMMUv3 Address Translation Services support is derived from
IDR0, Range Invalidation support is derived from IDR3, Substream ID
size is derived from IDR1, and output address space is derived from
IDR5.

The default values are set to 'auto' for all properties. If accel=off
and the values are set to 'auto' or are omitted and resolve to 'auto',
the default property values defined in smmuv3_init_id_regs() for OAS
and RIL will remain unchanged, while SSIDSIZE and ATS values will
remain initialized at 0.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v4

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/all/20260512193520.3109172-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/

Changes from v3:
- Added R-by tags, thanks all!
- Include a fix patch for resolving ATS support in ATC invalidation
  case
- Update host requirements documented for accel=on, oas, and ssidsize
- Fix style issue, update comments
- Update function name for smmuv3_accel_machine_done
- Remove unnecessary early return for smmuv3_accel_machine_done
- Fix formatting in qemu-options.hx based on html render

Changes from v2:
- Added R-by tags, thanks Eric, Shameer, Cédric for the feedback!
- Re-worded descriptions in qemu-options.hx and smmu_validate_property()
- Emphasize accel=off auto behavior in a comment for smmuv3_properties[]

Changes from v1:
- Update qemu-options.hx to explicitly mention auto is supported
- Update qemu-options.hx to mention auto as default
- Simplify comments in smmuv3_accel_auto_finalise()
- Update descriptions in smmuv3_class_init()
- Consolidate all default value change patches into one patch
- Implement and use smmuv3_pasid_supported() for setting PASID support
  flag
- Move smmuv3_machine_done() and qemu_add_machine_init_done_notifier()
  to smmuv3-accel.c
- Register machine done notifier only in case auto_mode is set

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Observed the
feature properties being set based on host IOMMU capabilities.
Verified that the VM boot will fail without a cold-plugged device, and
that a hot-plugged device re-uses the resolved values from the initial
cold-plug. Additional testing and feedback are welcome.

Nathan Chen (9):
  hw/arm/smmuv3: Update ATC invalidation check
  hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Implement "auto" value for "ats"
  hw/arm/smmuv3-accel: Implement "auto" value for "ril"
  hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
  hw/arm/smmuv3-accel: Implement "auto" value for "oas"
  hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
  qemu-options.hx: Support "auto" for accel SMMUv3 properties

 hw/arm/smmuv3-accel.c   | 77 ++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h   |  2 +
 hw/arm/smmuv3.c         | 81 +++++++++++++++++++++++------------------
 hw/core/machine.c       |  5 +++
 include/hw/arm/smmuv3.h |  3 ++
 qemu-options.hx         | 25 ++++++++++---
 6 files changed, 150 insertions(+), 43 deletions(-)

-- 
2.43.0


