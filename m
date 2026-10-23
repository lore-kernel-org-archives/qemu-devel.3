Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24431606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdc-0000MN-E3; Fri, 23 Oct 2026 16:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd5-0008QC-Nv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd3-0006uV-Es
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIoXRqoniHxG3DmH1Cxft94rOGMrTJi0MkeoBRZuCsdq4wFZHzwIthZ2xIghu+sVgtj/0z62nYg7sScpunXqre7A8VSm80pRy+EDY9jcxZwpK2Pa0YM4DjDfbEs1yUGhtxLo/orIp23bQmaGl9hzwn6yf1ZNPC5x+7/Uzzgj9UI0Ti06ieifUEoClON4b4P+t2q8tTIL5WmBf4SIm2BHJBXrSKG4z1OJjwlzGPt452FN1s8yZ86zUKJqHVMlUjQcf7/6W0DDx19nrLf9Jmxu7RHiredcbbJvNKzYLM/Rl8hb7hZ0JckB4jkHLVEnBLTnRVIUVomVU2c4NXVP90NZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uF8ZYrYrVqzGUciNK0Q3K+sVcaI3hq+/WEhsmERaRQ=;
 b=L9iPqx+tzNeM9yxx9QanML6d7rNmJXIrw+ipgZA7BWBvKbyBNAtdmf1gYDIuSW7WLMpdjZ4aZeiZVSXqwlfcZ6WKEcp5K7QIVN5ctwxrm+PiVIe7aawlOKrGQPpBUC66mDEVZ+TMLNKJ82h4Q5OXmAeLgLfACFFeFYHSXr0LcTEAnGqaQQB2x3BHyBkg4T9arNZxb+TFp6lv1jEO2KXld6eheB0YW3Sqb0etTcDbE+KUfmHOa47xVxtHx1YBjLodyT1eRKgh6B0iJudGUCv92/FAZo7dKLo+JaOzYWcniKHTI2THdqZ+V5cpNRhfPTlj4Dcf9A0drq/DWxFtyGRdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:24 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:24 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:41:59 +0530
Subject: [PATCH v2 5/9] hw/timer: add TriCore System Timer Module (STM)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-5-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=13235;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=bsfXReBIGrr9yPJ123FLIgD06Dh2cUB61qqP2aJu2Z8=;
 b=OmQceIm3IO/4sTw/bumhYK9zPcX0LT5oIhb0+BrdwuNIL0uj9g4x67LfogW94YYCxJsfDDy2V
 Tg6xxZnailYBhssfW+SRbIDnOkgMfgBVSyisFuoAQ+BjkhUt2PRGEVb
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 934f62a9-3904-4e58-68c7-08df3141f3a5
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261009223027099003|260925021311599003|260925021911599003|260925022911599003|261021121427099003|10067099003|22082099003|56012099006|18002099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: c43JtvJp6/AcTpZu45c5NKViHi8kwQi2ZKNzlRWW8q6ElfA+yWpAJsuboJDRkUvTYoeeYLZFs3rxdEe9RVZVMzfY4aSRFI3k2XoTo7Sef9+4DXJHz9udXRpODP0KQ+jdjBUOMMAnmi/JREreBJXssvOiLutZ5j4oonX+LPTJUpkBT6mvpnFQyGJoVmsLeXDi5cW15jtGFuHwO/UvuKOA7X0ClrzHzeKuHI46orkbwopYDUXqSFtGjq7FJZHbMkWrDmpQgENW9u8UXOm0KQ5pED5D1diTy+bmZj/mlDk0ljI5ua0NHDs9V9OXEUksXTnWIoGDmg6Cp/xhok3+VrO/x/QuzjAUUU+d6b2mHeSo3GBRoDcH9jS/wXxqAmpVacU055YRNs3aVK2Lpo+I+d7zp9beG96x/nUbaC7fZWKxdTnca72jfFCNFdiefuoHY8rXACN3xGoc8XzLC1bgva8Rnh+4T+6WNMvGefpeXmMcqFMLZRpO4/+Bbj35EPACN7DTTiZJ8nyGmcbWGT3mfQqk6eyJKO9IG5qvWd4NoyUTWOravO8D2SjM9tOoZoAoiJWC25ShXrJlsaEhh+HMiiKaOrVP9C3siYnVmKAszcy6Lk/l15GAWqS6WQ5N1BziEefRvWp96M1d3F1sJivI1CPm+giUrC2UtyVxByRB2jqJxgJxX7+0cw2eG6KGYqLvZRqpXSepwdFa75eIdAq1LtJpc2T+MpKwG4m/vz/a3j9l6uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBZWFFjV1dDeE9BdmRvSEdJZjl3eUVSd1NBSXRkcnczUWJpVWxHdXR2VmI3?=
 =?utf-8?B?ZnI2Z2NTdDkxSTJremtrbkErTFJyL0ZRUHp2ak5uZFh1SG9KZ2ZDbFFlNWwr?=
 =?utf-8?B?cDQ1V0lTVFBMbFY1U3Bia2EwbktyYWhReVVmQzFBeTZBVnBiYmF2dWRseHFi?=
 =?utf-8?B?TjVORkxkQVowYXNWSzNrU2dQZGl6bUIwSkxQZDRsUkcwdFVCclRBN295MDhJ?=
 =?utf-8?B?eWx2ZlpoUDZQVWJIOFhOcnZrTVhuYlVwclVOWnNRSkFVTkh0NXVwRm5BVWNM?=
 =?utf-8?B?ejV6N3FuTWZHUi9lQXFTKzlCNFMvUW1NaTN4dnBWUG9Rcm42OUszMU1NTU9x?=
 =?utf-8?B?dVJvRXRJbHY1bUJJV3d4UGY3V0lSTmNHNk9QQjhqYWdtczJjK3BpOXhIcmhh?=
 =?utf-8?B?MFVuSHRaL0M1SWVJclBNMXlubjAwajlvK2xvSFYyeDFRZ2RSV2ErNGVpVEtB?=
 =?utf-8?B?NnFwR280aFpxRHc4V1VQZHg5c2hDY2t4ckdFNjk3QUZpaFp5MWRiS012b2Nr?=
 =?utf-8?B?R2ZKNFBxdElnSGZjSW5DQ29DTlo5c1ZnL2dkRVZ5RHRzQWlKdEprZDdZWGdl?=
 =?utf-8?B?Ny9JYi9KS2tXQjJJSk90SlNmcVdlSVpBUDRPM05OK2orcjJSZENGVHpucndI?=
 =?utf-8?B?aVowTlU4ckh4NGYyaDlhb0M0MXQ4TlVlWWUwa2ZFK01EQ0UrUDhiRFNyQlI3?=
 =?utf-8?B?SUJua2s2VStsU1lmMXpPdVZFc3ozVFNvM0hrOEJaZlp4MkhIeXhUWjVLSmh6?=
 =?utf-8?B?TEVaT21iZ3JaSUxjQTBpMlJLNmkyVmFQU0VKL3JrYzFQckRaV0lhcFBWeE8r?=
 =?utf-8?B?V3NFNXBjRTJOWkhqczUzNnFCNUVKd01xZHhyam13aXZ6YlplbitGNkZTOCs4?=
 =?utf-8?B?M1NIM0lXaFhSUmRYZlNwMDhVcXNyY3F0WS9DS2dkTEg0bUVQb1BFeitGYkNj?=
 =?utf-8?B?VXpPQWVEbktKY21VMHNVd2FuSWkrRGdTV2ZyN2xxeGxPaG4vVkdOQnBJaWoz?=
 =?utf-8?B?aENoUE41MVhNaWYvVUxYWE5tNzYycEZzSlN5bVZ5Z2ZoYjg0UUk5cDlaa0NF?=
 =?utf-8?B?WWRvTm14cndWTXVhWFJJNC9xMmltMnRJNDg5RlNRTzVTWkZQbU5FeExldWhv?=
 =?utf-8?B?bTN3cythRFlrQnEyQVd3bGt1WENyUUlVbkJwR283L0xIOVJjUXRVNTRLc3pQ?=
 =?utf-8?B?TU00NlVzYS9FSzhqaWl3b042cWFIUlhTblpjYTM3QWxabHROY3JqVFc2S3I1?=
 =?utf-8?B?RVJJNVFodVJQMEdDQ1Z3VUlUZ2lET2VyTEhlWFA3Z0FNYWZsNDE2Y2VZNFpn?=
 =?utf-8?B?TWM4ZkFGUDRLTGM1SWZ1RHhDOXF2VnBiZ2s5c0t5U2dhZENBek5JbjA3SXFL?=
 =?utf-8?B?dk0yTnpXaTBTWnJVWkpGVjVlcVZrb2lxMVVhWTBnaVd3WUs0RVIvZVJIeENR?=
 =?utf-8?B?NWpIVjVVWlNZd0F0R3dUT2RFYjM4dVY0OUVuRFNtS1cyQ05VV0hBMFFaNGg1?=
 =?utf-8?B?bDRIRTdEQVBhQnNNbWdTVDVRZVVRZGxBOWJkRTNOUzhZWG1odE5Xby9EMDlQ?=
 =?utf-8?B?Z3lkQ2kyY0UwYXRTQ2UvQjZSQVlHeWcza1hyT0tCazUyaTdPUHl5KzRVWEZP?=
 =?utf-8?B?RU9BZ2dYaFVFWkdHWWdweFZ6TjhsRENYVFFvS2tiTndYVGtHOXBCR3dsTnc1?=
 =?utf-8?B?WW00a3Z3RkRQY01IYkJYWWlJRWc4U2JabzZ4Tk5EM2pCdmFYYmdWdDlBRDhU?=
 =?utf-8?B?UW83bmpaYk1GRCtVS3k3bDBtTVhEdUMwTXB2M1ZweCs1YWNuVk1CbmN0dU9U?=
 =?utf-8?B?NVlPd243aEp2ZFZ0S2owUkxCbUZSMVdvOXVCTm9wYW9lS0d2YlpNVTZhVEVl?=
 =?utf-8?B?czFxZDA2Z2JDMHVieGdKbWtFdlo2Mkx6ajNjVWoya2ozYWhKUGVPZmp3SXE3?=
 =?utf-8?B?a1ZxaGFGSytoVi9JSUFQSDhPOWNkUWlMOVdLZHMzNU13TkdaRDQzZkNjZDZw?=
 =?utf-8?B?Snh1S3MwdGIvN3lZdWp0ZThkTjRRM1luUCtJeGpkMnRtdnYrT1RMaXdBV2px?=
 =?utf-8?B?cHFiVll3dzhmQmlld2RuWERlWG1CODd5SzNpUWNpcCsyYTM1SEc0QzJ0WjZJ?=
 =?utf-8?B?dHlnYUxESng0UWdKUmFMdFRMTXhPTXlUMjBqdlZiUzRxYVpQSnMxTDFocDBs?=
 =?utf-8?B?UlJGamphSWtMNTRtN2ZzeHByRXlyMy9VeStLZGhRQ0ROM0V6bHEwNmVHUmU5?=
 =?utf-8?B?dy9kWUJrWHVqNTFhcC9pck81dXIzTTdYZmNhMnYwWU5aQy9JWTBscURFVDdX?=
 =?utf-8?B?Qk04aE5QZGNCQmxCaWNjS0ROSmIrT25nbFhxZThLTU41VHNpVlB0dz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f62a9-3904-4e58-68c7-08df3141f3a5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:24.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLtvbyYkSCIDfkUUaS57ox7pVrHEw7UM+zTqn/LbBXkxKsCTEQOMMtD1Uz+QEDc/xHvqLTNcFBzFSaBeA73BQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Free-running 64-bit counter with compare match interrupt.
TIM0..TIM6 give shifted views of the counter, CMP0 fires
when the masked counter matches the programmed value.

Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 MAINTAINERS                    |   2 +
 hw/timer/Kconfig               |   3 +
 hw/timer/meson.build           |   1 +
 hw/timer/tricore_stm.c         | 365 +++++++++++++++++++++++++++++++++++++++++
 include/hw/timer/tricore_stm.h |  34 ++++
 5 files changed, 405 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f985ad4e3..540325d78c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -480,6 +480,8 @@ F: hw/tricore/
 F: include/hw/tricore/
 F: hw/char/tricore_asclin.c
 F: include/hw/char/tricore_asclin.h
+F: hw/timer/tricore_stm.c
+F: include/hw/timer/tricore_stm.h
 F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a..bf6e79d0b5 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -68,3 +68,6 @@ config AVR_TIMER16
 
 config HEX_QTIMER
     bool
+
+config TRICORE_STM
+    bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46..f376814593 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -36,3 +36,4 @@ system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
 
 system_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
+system_ss.add(when: 'CONFIG_TRICORE_STM', if_true: files('tricore_stm.c'))
diff --git a/hw/timer/tricore_stm.c b/hw/timer/tricore_stm.c
new file mode 100644
index 0000000000..733a8e6ef6
--- /dev/null
+++ b/hw/timer/tricore_stm.c
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Timer Module (STM)
+ *
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/clock.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/timer/tricore_stm.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+enum {
+    R_CLC,
+    R_RESERVED1,
+    R_ID,
+    R_RESERVED2,
+    R_TIM0,
+    R_TIM1,
+    R_TIM2,
+    R_TIM3,
+    R_TIM4,
+    R_TIM5,
+    R_TIM6,
+    R_CAP,
+    R_CMP0,
+    R_CMP1,
+    R_CMCON,
+    R_ICR,
+    R_ISCR,
+    R_RESERVED3,
+    R_TIM0SV  = 0x50 / 4,
+    R_CAPSV,
+    R_RESERVED4,
+    R_OCS     = 0xE8 / 4,
+    R_KRSTCLR,
+    R_KRST1,
+    R_KRST0,
+    R_ACCEN1,
+    R_ACCEN0,
+};
+
+#define MASK_ICR_CMP0EN     0x01
+#define MASK_ICR_CMP0IR     0x02
+#define MASK_ICR_CMP1IR     0x20
+
+#define MASK_ISCR_CMP0IRR   0x1
+#define MASK_ISCR_CMP0IRS   0x2
+#define MASK_ISCR_CMP1IRR   0x4
+#define MASK_ISCR_CMP1IRS   0x8
+
+#define MASK_CMCON_MSIZE0   0x1F
+#define MASK_CMCON_MSTART0  0x1F00
+
+/* Reset values */
+#define RESET_TRICORE_STM_CLC       0x0
+#define RESET_TRICORE_STM_ID        0x0000C000
+#define RESET_TRICORE_STM_TIM0      0x0
+#define RESET_TRICORE_STM_TIM1      0x0
+#define RESET_TRICORE_STM_TIM2      0x0
+#define RESET_TRICORE_STM_TIM3      0x0
+#define RESET_TRICORE_STM_TIM4      0x0
+#define RESET_TRICORE_STM_TIM5      0x0
+#define RESET_TRICORE_STM_TIM6      0x0
+#define RESET_TRICORE_STM_CAP       0x0
+#define RESET_TRICORE_STM_CMP0      0x0
+#define RESET_TRICORE_STM_CMP1      0x0
+#define RESET_TRICORE_STM_CMCON     0x0
+#define RESET_TRICORE_STM_ICR       0x0
+#define RESET_TRICORE_STM_ISCR      0x0
+#define RESET_TRICORE_STM_TIM0SV    0x0
+#define RESET_TRICORE_STM_CAPSV     0x0
+#define RESET_TRICORE_STM_OCS       0x0
+#define RESET_TRICORE_STM_KRSTCLR   0x0
+#define RESET_TRICORE_STM_KRST1     0x0
+#define RESET_TRICORE_STM_KRST0     0x0
+#define RESET_TRICORE_STM_ACCEN1    0x0
+#define RESET_TRICORE_STM_ACCEN0    0xFFFFFFFF
+
+static void tricore_stm_tim_update(TriCoreSTMState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    s->tim_counter += clock_ns_to_ticks(s->fstm, now - s->tim_base_ns);
+    s->tim_base_ns = now;
+}
+
+static void tricore_stm_timer_update(TriCoreSTMState *s)
+{
+    uint32_t mstart = (s->regs[R_CMCON] & MASK_CMCON_MSTART0) >> 8;
+    uint32_t msize = s->regs[R_CMCON] & MASK_CMCON_MSIZE0;
+    uint32_t nbits = msize + 1;
+    uint64_t tim_target = s->tim_counter;
+
+    if (!(s->regs[R_ICR] & MASK_ICR_CMP0EN) &&
+        (s->regs[R_ICR] & MASK_ICR_CMP0IR)) {
+        return;
+    }
+
+    /* Calculate the target TIM value */
+    if (mstart) {
+        tim_target = deposit64(tim_target, 0, mstart, 0);
+    }
+    tim_target = deposit64(tim_target, mstart, nbits,
+                           (uint64_t)s->regs[R_CMP0]);
+
+    /* Wrap around if needed */
+    if (tim_target <= s->tim_counter) {
+        tim_target += (1ULL << (mstart + nbits));
+    }
+
+    timer_mod(s->timer,
+              s->tim_base_ns +
+              clock_ticks_to_ns(s->fstm, tim_target - s->tim_counter));
+}
+
+static void tricore_stm_clock_update(void *opaque, enum ClockEvent event)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+
+    if (event == ClockPreUpdate) {
+        tricore_stm_tim_update(s);
+    } else {
+        tricore_stm_timer_update(s);
+    }
+}
+
+static void tricore_stm_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+    hwaddr reg_addr = offset >> 2;
+
+    switch (reg_addr) {
+    case R_CLC:
+    case R_ID:
+    case R_TIM0:
+    case R_TIM1:
+    case R_TIM2:
+    case R_TIM3:
+    case R_TIM4:
+    case R_TIM5:
+    case R_TIM6:
+    case R_CAP:
+        s->regs[reg_addr] = value;
+        break;
+    case R_CMP0:
+        s->regs[reg_addr] = value;
+        tricore_stm_tim_update(s);
+        tricore_stm_timer_update(s);
+        break;
+    case R_CMP1:
+    case R_ICR:
+        s->regs[reg_addr] = value;
+        tricore_stm_timer_update(s);
+        break;
+    case R_CMCON:
+        s->regs[reg_addr] = value;
+        tricore_stm_tim_update(s);
+        tricore_stm_timer_update(s);
+        break;
+    case R_ISCR:
+        if (value & MASK_ISCR_CMP0IRR) {
+            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP0IR);
+        }
+        if (value & MASK_ISCR_CMP1IRR) {
+            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP1IR);
+        }
+        if (value & MASK_ISCR_CMP0IRS) {
+            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
+        }
+        if (value & MASK_ISCR_CMP1IRS) {
+            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP1IR);
+        }
+        tricore_stm_timer_update(s);
+        break;
+    case R_TIM0SV:
+    case R_CAPSV:
+    case R_OCS:
+    case R_KRSTCLR:
+    case R_KRST1:
+    case R_KRST0:
+    case R_ACCEN1:
+    case R_ACCEN0:
+        s->regs[reg_addr] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "tricore_stm: write to unknown register 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static uint64_t tricore_stm_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+    uint64_t r = 0;
+    hwaddr reg_addr = offset >> 2;
+
+    if ((reg_addr >= R_TIM0 && reg_addr <= R_TIM6) ||
+        reg_addr == R_TIM0SV) {
+        tricore_stm_tim_update(s);
+        s->regs[R_CAP] = (uint32_t)(s->tim_counter >> 32);
+    }
+
+    switch (reg_addr) {
+    case R_CLC:
+    case R_ID:
+        r = s->regs[reg_addr];
+        break;
+    case R_TIM0:
+    case R_TIM1:
+    case R_TIM2:
+    case R_TIM3:
+    case R_TIM4:
+    case R_TIM5:
+    case R_TIM6:
+        r = s->tim_counter << (reg_addr - R_TIM0) * 4;
+        break;
+    case R_CAP:
+        r = s->regs[R_CAP];
+        break;
+    case R_ISCR:
+        r = 0;
+        break;
+    case R_CMP0:
+    case R_CMP1:
+    case R_CMCON:
+    case R_ICR:
+        r = s->regs[reg_addr];
+        break;
+    case R_TIM0SV:
+        r = s->tim_counter;
+        break;
+    case R_CAPSV:
+        r = s->regs[R_CAP];
+        break;
+    case R_OCS:
+    case R_KRSTCLR:
+    case R_KRST1:
+    case R_KRST0:
+    case R_ACCEN1:
+    case R_ACCEN0:
+        r = s->regs[reg_addr];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "tricore_stm: read from unknown register 0x%"
+                      HWADDR_PRIx "\n", offset);
+        r = 0;
+        break;
+    }
+
+    return r;
+}
+
+static void tricore_stm_reset(DeviceState *dev)
+{
+    TriCoreSTMState *s = TRICORE_STM(dev);
+
+    s->regs[R_CLC] = RESET_TRICORE_STM_CLC;
+    s->regs[R_ID] = RESET_TRICORE_STM_ID;
+    s->regs[R_TIM0] = RESET_TRICORE_STM_TIM0;
+    s->regs[R_TIM1] = RESET_TRICORE_STM_TIM1;
+    s->regs[R_TIM2] = RESET_TRICORE_STM_TIM2;
+    s->regs[R_TIM3] = RESET_TRICORE_STM_TIM3;
+    s->regs[R_TIM4] = RESET_TRICORE_STM_TIM4;
+    s->regs[R_TIM5] = RESET_TRICORE_STM_TIM5;
+    s->regs[R_TIM6] = RESET_TRICORE_STM_TIM6;
+    s->regs[R_CAP] = RESET_TRICORE_STM_CAP;
+    s->regs[R_CMP0] = RESET_TRICORE_STM_CMP0;
+    s->regs[R_CMP1] = RESET_TRICORE_STM_CMP1;
+    s->regs[R_CMCON] = RESET_TRICORE_STM_CMCON;
+    s->regs[R_ICR] = RESET_TRICORE_STM_ICR;
+    s->regs[R_ISCR] = RESET_TRICORE_STM_ISCR;
+    s->regs[R_TIM0SV] = RESET_TRICORE_STM_TIM0SV;
+    s->regs[R_CAPSV] = RESET_TRICORE_STM_CAPSV;
+    s->regs[R_OCS] = RESET_TRICORE_STM_OCS;
+    s->regs[R_KRSTCLR] = RESET_TRICORE_STM_KRSTCLR;
+    s->regs[R_KRST1] = RESET_TRICORE_STM_KRST1;
+    s->regs[R_KRST0] = RESET_TRICORE_STM_KRST0;
+    s->regs[R_ACCEN1] = RESET_TRICORE_STM_ACCEN1;
+    s->regs[R_ACCEN0] = RESET_TRICORE_STM_ACCEN0;
+
+    s->tim_counter = 0;
+    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static const MemoryRegionOps tricore_stm_ops = {
+    .read = tricore_stm_read,
+    .write = tricore_stm_write,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tricore_stm_timer_hit(void *opaque)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+
+    qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
+
+    if (s->regs[R_ICR] & MASK_ICR_CMP0EN) {
+        qemu_irq_pulse(s->irq);
+    }
+
+    tricore_stm_tim_update(s);
+    tricore_stm_timer_update(s);
+}
+
+static void tricore_stm_realize(DeviceState *dev, Error **errp)
+{
+    TriCoreSTMState *s = TRICORE_STM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tricore_stm_timer_hit, s);
+    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tim_counter = 0;
+
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void tricore_stm_init(Object *obj)
+{
+    TriCoreSTMState *s = TRICORE_STM(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &tricore_stm_ops, s,
+                          "tricore_stm", 0x100);
+    s->fstm = qdev_init_clock_in(DEVICE(s), "fstm",
+                                 tricore_stm_clock_update, s,
+                                 ClockPreUpdate | ClockUpdate);
+}
+
+static void tricore_stm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->legacy_reset = tricore_stm_reset;
+    dc->realize = tricore_stm_realize;
+}
+
+static const TypeInfo tricore_stm_info = {
+    .name = TYPE_TRICORE_STM,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreSTMState),
+    .instance_init = tricore_stm_init,
+    .class_init = tricore_stm_class_init,
+};
+
+static void tricore_stm_register_types(void)
+{
+    type_register_static(&tricore_stm_info);
+}
+
+type_init(tricore_stm_register_types)
diff --git a/include/hw/timer/tricore_stm.h b/include/hw/timer/tricore_stm.h
new file mode 100644
index 0000000000..b9a0538963
--- /dev/null
+++ b/include/hw/timer/tricore_stm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Timer Module (STM)
+ *
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#ifndef HW_TRICORE_STM_H
+#define HW_TRICORE_STM_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/timer.h"
+
+#define TYPE_TRICORE_STM "tricore_stm"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreSTMState, TRICORE_STM)
+
+#define STM_R_MAX           (0x100 / 4)
+
+struct TriCoreSTMState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    Clock *fstm;
+    qemu_irq irq;
+
+    uint32_t regs[STM_R_MAX];
+    uint64_t tim_counter;
+    int64_t tim_base_ns;
+};
+
+#endif /* HW_TRICORE_STM_H */

-- 
2.47.3


