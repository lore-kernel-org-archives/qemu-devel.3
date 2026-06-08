Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79769CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6G-0006PA-TF; Mon, 08 Jun 2026 13:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6E-0006No-K7; Mon, 08 Jun 2026 13:49:22 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6C-00074F-Qb; Mon, 08 Jun 2026 13:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFPJbKppNOjqc6fs/Gq3tavPo7qNJWx3BaBqi9uCQx6vxxrHXsh10mWBAW/moVjEOmAJxnvB5HUPcjWUM/fL02pnm3lIIJnHgOSdJRwTVeHMNsjWfTGcR76nATCYrqvY/frtS1eNK8GIJIJtQt0A2c69xmN4JX2ElRRN9d+FR4r0F3lD93XLKCf3LKk6K1iPxPdd6CAAKbeqeUII2mmVhcEU55jwUYxPmUdhEk//qDcESXlj73LV02FfMHKMITE+DnzAbe+7kgGA+OsVg934qt6uGFsdAiNTxll50D+yCT+4gQ4bPnkJ4k/HLOIAyFBYdZAjzkOQibvHHS6OH3PstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqm92WtM/up6b2eYEOYmO0xX7gkV0iMYONg2AXaWOCk=;
 b=mZT2H4HZx6C6f1+UbVmW1hf6lbTF288ZAdQh8FUSNdOln/zEo02Q1aZPRYdOQbIh56wJeNNSlrK9Wnr7Na+KEePqDysTnL+vOUrlan44VROl9GV5FhqE+H8rgsmRGuV0eXF7Opafh4qy5+u8L0MUU+MLL4i8L93n9hTdaq7g6UCwHXxDo50PN5f7TOGK1OMpTnUJq0+vCVu8PxGB/TsyMV2MYi1sSZmxPUXHyymAUQzW6UhxeHUYGZkU0fmxtAKexozYwPJJ7hg7uu4+7QAw12nG88CIq1L8Oo/4V1UZCdsPEa0XDPJTkFFu7KegTm+b4nOD0kuAYo/XDBMlYpP+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqm92WtM/up6b2eYEOYmO0xX7gkV0iMYONg2AXaWOCk=;
 b=tFYZPnyX8QrmpCmxqpgp09M/yNSuf+rkHDFy1gsrWlHUFghhyAE2lG5cOk1AExlWgtOPhdqfAVndUDwhm4CMSRQTYDkXJ6HkbuiyzNH0Lal4gde7ZU+jO87r8hN0vpoGzNT/GY8Eqauj9fbIcVgTtDdfBQA/UODHkosB8xwj+dRLQowkCOqF0Y+HQQGv4tPFuLNQ+cYet1IWdxZl4J4qTCAVP4+R+ilvTyMz3YqkQ/Tv74DMmFMVBCJIZN/li6GDEpKXudVxP5IcW9VtzKp10ECsIvO/vqS+To0CFwIDrHaCqrS9MFarCSOL2j8zXZqOXbYFiyAEUGVOhegWnbKTIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:12 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:12 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v6 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Mon,  8 Jun 2026 10:48:51 -0700
Message-ID: <20260608174900.2227340-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2443db78-41d6-4cf9-7a52-08dec5863ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rXBScRIuNg6Sh8iCvlz9uuyvWxkCXCfSlz5HMv+oTZp4+1KO/10wc0jPZuaiacAWB+9e4EuJztjwGypjscjdqMzMSFENVTsDelKivVikySyfx5YE3/vh75HpOnmDiL5pXlbxcXzIDq1BkSrA8eSDoAGndaJ0fA//tqA/Y/9WBlwnnnRvg31blm9qEI9Uc3WaRhm+udi70dwQ5M5tXhOWvVA3d2oSboeJPtQuSDtF4yFL7O09H1VOQAY92AlrZZvajUPwdvIMRYfYBp1ZnPpKGDrNQlYuUcywQiLkKLldqLX/8NTTOmZqr1hJadBCTl73R7glbceRCBydNcfcj3sKLMmMQDSm19mrDw7RR1PXquV4vuaeDSObNtshKxQHMQpbBHSMnm+efYzD8mFt6YnbtZ1dhXgCcg/U5eb1sk2RGJGYqSwdb5+Cir4LdVRKEEU5fDfSLYhnY1vcp/V3h4fydQR+IJFdpQThFVpsAjIHALUZHXW68yguJsifP3v0p0BktNKs74rcXPV4t7Fj4L/m/VMwE0LD85xEviNEIp2aLbdgZGtsCo3tgRPnoobc/zjZaQplUIOYfTRqFY+CvjpuF34HbKkV5u6qhZj+eVUXo4n0rem9bt5chcdZltjDLdEWxiKh2/AnGaD1dLaiJiEoD/3G9TEfZ9z/gBtlZqGxEG/FkhCu7LLffghKAsyGVNUbzVmZSc/QCvjI2BznRClRww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1oyQ3UxVS8zd2NURG1DSG9XY1RqV2pyd2p0RzN3MDVrSnBaMDA5Z28zUEtQ?=
 =?utf-8?B?M2dVdzE1R1M0VlU4MUUvZHBtbmVnZnVIbDcyVUxNVDBwTFBLVC9YcFlMRUQ2?=
 =?utf-8?B?NnI5ZHdGeEpoUUh3L0sxUWFLc1BBMlVaWHcyclZORmpzakdYeHlUR0RLeVRi?=
 =?utf-8?B?c2dDWTRXQ3NpN3RFd2R6NWlaYjFUaURDNHgwMHZhdnBJaDJTZHpxY3h1YWRD?=
 =?utf-8?B?ODY1cllWSWdub3pzWTBnWWpEZ3k5ZmIrdlQyWkJ5dXpPd3E2YmxXQk9rdTZU?=
 =?utf-8?B?eVYvUzdLazJHNktvUkhMcjhLRHNJeDRnV1BZaXhVdGI1N3hvTm5Xam1JVHo0?=
 =?utf-8?B?Z2dyamtzZ3N2dk1BZGU4T3grekR4QjJuWEY0ajRLeFFsNjB2R1UxbERQeFEx?=
 =?utf-8?B?aEMxWlNSOWlJaFhJcnhsck04OGR1RWpnV1ROSTRIeE4yU1czZmJ1U0VsNmY5?=
 =?utf-8?B?UGphVzE5WXhYSERTcWhKYmpQR3l0dmdZSm03MVdJay9tbEpvWVpZTHI3RkVI?=
 =?utf-8?B?MTk0LzJ1YjdPaHlXbHhjMTBtdUpxWFFWSEZIdVU0Y0paWSttdWg0d1RsNHVJ?=
 =?utf-8?B?bTkzR29jNklTZkRwTG4vUml6U3FOSC84dG5uOElMT0hZajJ6bVBwZGxKQml2?=
 =?utf-8?B?TE1Gck4remEwbWdsUWR6eDdaQzhoNzhQSUxxdSsyY25oMnRkTFhna3RRNy95?=
 =?utf-8?B?bmMxOWV2TEE0R0lvZm1uYmNJSnBudWduY2FtbGZTRWFRbWtkY2RCWXc1dUlk?=
 =?utf-8?B?US9OQjdhTGtZSFdreUdkUVdqbUhrRFEySk9VRnZFYWVFbTNhUmYzVk5MbGY4?=
 =?utf-8?B?VkZyaFJoUkdnQTkxRGhwbnJiQjZjK3djWFRwZUNjaWxMWnRyZ2VWbUZPdXRW?=
 =?utf-8?B?ZWxSbXlJbmJvQXI5STNKdjMxdWtWMUNLWTNDbWpmMjAwWDU1bXRXNUJ6NWdL?=
 =?utf-8?B?ZkFhQW1EQ2FXN3V5S2puNldPMDY2MERpSW5CWFVLeUJJWU96ZVltdVI3V3ZJ?=
 =?utf-8?B?emNqSEw3TzBqUXBIM1RWTjc5OWVJZDZmVU1FUFhaNllOcmJIZUlxN2Vhakt2?=
 =?utf-8?B?MURQQ3NHZWRUUVhOTXJtSjYxWW0vRzhUclFCN2htS3NIdytkTVErbjBaby8v?=
 =?utf-8?B?M1dKc0oxTHoxeUZiWlpReVRYbGg4VjB3UUFGdmY5OEJwbWEwc3NmVU5BZDNw?=
 =?utf-8?B?Sk5hV0V2MXg1N3ozR1ZQNnBwb05kWGxuZ0x0WTNYWXY4U1FqYmZuWno1cWVP?=
 =?utf-8?B?UzgxcGhFdlpFbkdzeTBLMWdUbU1rYTdjRS93QW0xRFZMRFBieE1qVDZlOUdV?=
 =?utf-8?B?azdQRFdQSG0vWHpZT212OHFZSEd5UEdMcGwyZGVkSnZjc1YrbTM1VEpmeFY0?=
 =?utf-8?B?bnp6SDJlVnlIbzBFTTgrOExFTTN0OU0wL3hkUk1FYnhZMVpXZnQwK3hXY1Mv?=
 =?utf-8?B?L01JbWQ1RlhsYXBPNXBjdEQzOEJhUjhQd3o4d2dzdWhGMzBsZHNzZUFNSGpO?=
 =?utf-8?B?SnpTRW5HZkdPRWFQaXcwcUx1b1Zja1Nwc0lKWjRRZUdIMW9oTjRFYVI4bGk4?=
 =?utf-8?B?TDdMbzJoNmozbGVVaHdGa0swVFNqVzRtZXJyVmQ2UWdVTzRHVHRPd3hSa1Vw?=
 =?utf-8?B?N2d6STlMMDZhdzlDempUSkhEd3JUZnZtSHVENzlEYjZlVXQ5Ujd0QjU2WWc3?=
 =?utf-8?B?MFRkNmprREZtL1NGN3RrbGdiblhTY1JDTHpidW45Z0ZqTlp0VzdLWlQ4WE9k?=
 =?utf-8?B?YW1LR2F0emxtT1I1VnEvV1M3U0xmbS9tS1FSa3lraU9YbE5lY2o3NHk1SjMv?=
 =?utf-8?B?RnFENEdJZ0xTMCsvSFVlMjNraW9uRHY4Njd6Sm03OXoxYTVJOWdrVU5xZTM2?=
 =?utf-8?B?K3RWSDdwRWFoa2RVcFJDSXk5Y0sySGprVjZ2ZXFxQmJUQkMrSVlFS2ZwZm02?=
 =?utf-8?B?QUxDVFNWMEQzbVZtaytxN0s2QnorZnlBdmJBRU1laEN1bStIa3EvTTRISG1I?=
 =?utf-8?B?TitpYXZ3SWNRZGtveGE1aXRCOHRMUW1rcmJ2Qm1CNnlDR2lBTkRkZUlLRXpr?=
 =?utf-8?B?cnRlRExOL0tUSzExejc2SWpZZTZpMHRKY2tkRVY5YlFOenllMkpBNWhpRlFo?=
 =?utf-8?B?ZzUxK09ock5HY21pOHpMYUg3emhXdkdKb21pOFkrRHJtcnYrb1ZoUFhlYzNu?=
 =?utf-8?B?SFVGcFpxVTZ4ZkUzRXN0bklYOHpoVkt3dWJEcTdRSDBBTDBSSVFQM0tWakRq?=
 =?utf-8?B?Z05TNkkzZ0hCWUFLR2dlVDY5dnhsK1FQWlIvcXY3UEFUaXRabGxMblBXeXdi?=
 =?utf-8?B?ajFuVi9Cc204cjI4elE0UHBIM2E4OHQwVExjM0VVellVa1NIQ3NGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2443db78-41d6-4cf9-7a52-08dec5863ff8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:12.3748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AszSlpboHTRS92EegmZzDq6R5VJWaBCkMlo8nbZIPFVs9+8ibzqCqUsabENqle2Z2Ioaix+z2gydPgiQ9lFQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
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
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v6

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/all/20260605001712.1823737-1-nathanc@nvidia.com/
[1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/

Changes from v5:
- Added R-by tags, thanks all!
- Rebase over latest upstream
  (https://lore.kernel.org/all/20260601215410.517009-15-stefanb@linux.ibm.com/)

Changes from v4:
- Added R-by tags, thanks all!
- Re-word smmuv3_class_init() accel description to list nested
  translation support as a pre-requisite
- Fix typo in smmuv3_class_init() SubstreamID size description

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


