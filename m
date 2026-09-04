Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED0C79F8C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJk-00055a-SA; Fri, 04 Sep 2026 11:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJf-00052F-Kp; Fri, 04 Sep 2026 11:58:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJd-0004Pg-Kr; Fri, 04 Sep 2026 11:58:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVmml7hhTMKv8CrqoRquKCjQM3ld28UGU7qE7UdTDp+KAwmuO+OIR48pxXBzsVWMN24sqfp1FaOKI83mEg+8o28aih2BOaeibnP3dLvKkdVFNnf3Slnagdv+SRPTcYVd5CJJDPdBBfnRB/AA/3yWk9I5O+3xyZR8ZTgpXrKNFNwl9f4b2yJ0AoLFNg8mXfIy8xWxrt4UAhdNFYyd0k6uLc0ogtJfZYXWnxsqxLSodkQlPEkEZVTEZi6yZ4N5/pI2qVWm+dDJy1onpsrJ/56gymE7MAdMn8DWL0rJwtC0nvwZHstHE1xB6gtf8UttTQulnVAPhv8dtgQNoi7LGZQ7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVpuQeS988RY+GtPmNlJWyQ7tjoJ719xVrYE5Pgl+vo=;
 b=ErqKLKDBnODmTL7V1kOaRuFjIMrdasGBG87jmCLqeUSJ/+SINVFuUs89wJuxPpKEbCehxkBGYMRjDDa0Vv1ePJbcCGvgjpgp53Dt9eKdqTICS8Uqc2u3imEQTGroXXqlhqgTTjOa1le8owZyjxEqoAU5m/353eTBwGA8FgPf+vl+edx2dHJiaPUOYOYT/3RDcvbWdysgcBo33nkSGy+OyUQSxzsLv9Gh5YXXNcFDi/PAUCUdOCyqOJYY65rdRZRHZL6Zxr112PfOXzjkBv9nfbZc6jy2zB15xaz/EHtsyjsqfEEYc2CH+hK7U1xdoCu1cR5NWVAofERHu5sNXDq0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVpuQeS988RY+GtPmNlJWyQ7tjoJ719xVrYE5Pgl+vo=;
 b=d5av1kUG90PwKSAebnFAOu8viU0Y/h6FTm14igwh5wen7/Pj8I5XkWNflb/Kf+ZMOUid5+NxX07fyboaC5aebcmVXp1ikegqZKyT6bLqXVg9tJC3k52i7HHTdCGt/ER63Ryhfb1dniDmSSCTjsqnF9rDyVjD5wzeBLxSGjnG1YUYBu8lO7D0zep/Sc/VqQgBt40V87VQjhGqN9v2nSitSwezoz6bqaj45JlJ8ECJCbgz8w50hB4G963JoEDI3AfBJTNIT9uVpH0aRPkb8nEwol9cNjmaR9I/SFizuPh4CmeWWLxFZj89+4xtknv2iagD5GXyGpD6RUgJ6g13oZiUJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:48 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v2 12/24] hw/misc: pfsoc: Model PolarFire SoC serial number
 service
Date: Fri,  4 Sep 2026 23:57:31 +0800
Message-ID: <20260904155758.3833179-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d776b63-cce0-4da0-7f56-08df0a9d6864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qBpLfAbesdDAZ/7wKF+VDElOG8YqPIGc6LaQcrhFIGTx2kMv2NL2QL3/Fd+Hkk5rLOaZ7etsfvOp8085BrAVNGK+blOwqOgjNzFtBym3YdJFhsXGn48WUE0YtJx1sQkwrAU+w1G4A0W3zh7evLttXHMwZGHWc4U8QJd9fqBR0sDa+Ohv0147gsnVwJLKRFRdhgWYRcKQkw/RJOim0D0++LnAy8WTBoB/+hgIfsVGUxxWlImhOyZMqcH1qOzzHjy9tGUAc6NTy53xJLk+vU2V1AnY0hDVr4wNfDEscjhYgPnkpfEPwzjojb3ZcEFjgv6pLotikScPElbvZop2vpmLFMNTTRiHGsJjUWJjv2ubmnGEUgHCI/xv63ZYHqergVi7g7vvMLC8vqjWrLjZCC0HOYLuI64x0DqT2Xsvqr/gEcWSFdNnfVN8ipezfzBfsxws28to/zsuMh/Xk+2aNQR6guIUK9d5Fv8FB0RWlb/oYKKZ+hzhYN/9Z8kxUys1OYXb14z+y4EKci2z6ThhhwnNbf4TL2UZBtopNMjyGA5lq1hRlc9R54wWX/T6g5vfUc8VfNYJZYHvBua6fc3Hw3yp74LNHyt0nnhxYwOOog9x2OFAPq/T7REGs+7MWaZ4TmeFyD4CJrv11QHQ4uJsJ4ASvAvYHwukCDwc6TBOtY5Jgac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01DdTl5MjhXUWg0NnJMczZCUDNEcGNFTndkaFR0TUhlWTdMTjgrTTlWbVlF?=
 =?utf-8?B?YzJjSEt4RXlPRFBSM3VjYVhxalBBVnhXT3QrNzNEejV2VkJ5V3RFOFpRTXdp?=
 =?utf-8?B?YzRFN0FnRytvNFBDelB6VEcwOHhIY3dlVllSMnY0cklkMTZZNGUzYUJ3d1lz?=
 =?utf-8?B?ZDkwcnJicDFJckh2cFJVVGwwaWlBS3lKUGFuUlVhMkRvSHkvK1hmbzZGVHcx?=
 =?utf-8?B?cmtFSU9Id1cwOEgwU3l3bHdHUjFYUjV1NjZpZGZVYkhWWG81eXA4Z2l2WGtQ?=
 =?utf-8?B?bHoyRzhwRjh1RUx6bXZ3MVQxaXNZYi91NEhVbVpHOUNCSHZqSHFpUHFUQmZv?=
 =?utf-8?B?WlYySzFCSnNyQTYyR0RLcGs5ZFQ4MXNpLzJLYVc3a1NOK1RDbVRVeDYreFhS?=
 =?utf-8?B?dFBOZTV6V3drK3NKK2pZSXphY21mWS9OSWoxT0dSUDRvM1pNeFNEOHZBLzV6?=
 =?utf-8?B?SFcyMFZqRUVoWHQ1RW9SZmR5c1o2LzZXSjNnN1JEK1dPdG1QNWlLNTNSL2RF?=
 =?utf-8?B?Uk9LMEVmZUxGRlR3VXo1NzMvUkxhTlQ2Zkt5c2NKaGp6b2tiZWNzTk52OW1M?=
 =?utf-8?B?NUUyZ05wVDBJbEN2QUtIbjlNU2VoR0ZjN01BeXdoRllvTEVXWXFObE54T25w?=
 =?utf-8?B?Y1RmcXBiaTNNQ2U5SEtNUzR6bmprUnZrMFR4elNjaWxNZ2l6L2p5WlJ6YVZn?=
 =?utf-8?B?UW5HME5UeU1pNGJuemk2cmwzbk9oZDFDR2ZRTnIyNEhTUHdwM2J3M2VBczBO?=
 =?utf-8?B?QndFMHBzWThkNklJdnJmSkhMVlpRbEk4NEhEQWxzbm9hZzVxRXN5RURCSWRS?=
 =?utf-8?B?ZVRWZ2dGcEtmdDZzalFOVUNOZ0Q5MGUzS09mRyt0S0NTWEdyRDFnM1dhWEZ5?=
 =?utf-8?B?cnloaTdVSmt6aTluQVBKdDVpQWlzSjFhVU84SHRoN0ZRdC9vcEozTlBpY2Ri?=
 =?utf-8?B?dk5iMnhoQ1FPVVVPd3dFbFNvOXk5T2E0Z3F4RFY2QnI0dDhDcGNVa3NzUlJR?=
 =?utf-8?B?T1JxM3NhNC9rc1NSNUU3eCtTMElQTVVUVTIzL1dCNjdmbWJpTDIvQlozWDZx?=
 =?utf-8?B?QWlkSTZiRDJMem1LZmdqaXp3dnZFSzNtaWZ4MisxTFBxcm14SmJaeTQ0Vk1B?=
 =?utf-8?B?akVwcTQwV0ZheFl1R0tHOHR0QTJZcXhLVHcwbnFMVXY3WEhpaW90aWhmandM?=
 =?utf-8?B?UmRlbFRPdE5hanFwMnRvOXVXZ2daWXVYdmZwamxpd1ZLeDdQR2JvMWhuYVBt?=
 =?utf-8?B?ZE96Mno3Y25vbnNYaElTSW5SdVp4Uy9PdU42Nlo2QTZ5VUR6SnVDbXVNYkdH?=
 =?utf-8?B?bElDSlBud1I3cklqalQ0d001clo1S3ptSVZLNk9SMWRNcWd3RFdiOTFWQWJk?=
 =?utf-8?B?RVY2ZnpLNDRYTEw3VXhvN3pHZGZVVGhYUWtydlJHQ0lrblFCdWRNVE4rSDhM?=
 =?utf-8?B?OENXeU1Dek9WdFJhUCtzaG84SnhKS1JlL3VGbXNmblRGaHVkdENBNkRERUs5?=
 =?utf-8?B?ZWFRNGV6MnEzU2Y2ZU1yZ0M5WlMrUk12c0xPWDAyR0lCMnNWd1dmZExZQkl6?=
 =?utf-8?B?Q0pQRkVUMTdCNFN6cDBHUVdyMHZGZjVjbysxL2pDeEJiY2pRK014WGVoZGQ3?=
 =?utf-8?B?TXhMdlhSbzZvLzBzbHpRdFJGT3FEZnVSM1E4aTUyOGlqUUV2VC9aR1pHRVJ0?=
 =?utf-8?B?T2laK29tTGE1cERMcHNlL2V5REVoS3dYVU0vT1RmeWpPaDhIOVl5WG4rbkd5?=
 =?utf-8?B?SldzaDd3c0R2RFdGV2V3UkFuUnJKNGwrQ2xtYlpucE1CVVc2Skw3Wi9mZUZK?=
 =?utf-8?B?L2JHWEFSSWlvYkZ4MlRtaDZMSXEwaWZ4aTVNNzFZMVY3UlRDc2NMWFZrKzlN?=
 =?utf-8?B?QlNTYW8xZHQ1cFFnZDlsL0FWbS9NWFBhT2FVMVFjNXBPK3ZkS1ZTMFYybU0r?=
 =?utf-8?B?SWg2ckFhajZuSTN5UGJBeHpVTHlnczVRSzRqeEc5aWR2cDVyU2hvUm9Hd2o1?=
 =?utf-8?B?VDNGTTlRSjhWU21zRE5tNmJOemQxV2ViU1ljK2poNVVvQ25oUzY4N1BrZm1W?=
 =?utf-8?B?RlVrZU5NMG1qVUp1N2hxMEQvckNOcFhkZTBqOGQvQWp2UHFLN3pVekRaUmRC?=
 =?utf-8?B?NEg3M1NEQmo2ZmlkY1JyNFgzcVMremZxYnFsVk45ZUptNVBrNnhYWTFGQVgw?=
 =?utf-8?B?YU1Ea2xEZHNoWmpENnVFYkRYWHlUaEJ5eGM3d2Y1N21XQkZUWnZ4SmhrZFBy?=
 =?utf-8?B?UFJJNEMyM3l2MUF3VEt5T3dRSXpoam9Lb1hFUm92VURBOWl4Nm1rTXhxYUlN?=
 =?utf-8?B?Qzlxb0pFV3Q5dVU1bTNkU0E1ZXNldFJIZ0NBWFowak9ZbHkzd3ZoaCtqNUg3?=
 =?utf-8?Q?Vc+aaesl9+H8zTpo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d776b63-cce0-4da0-7f56-08df0a9d6864
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:48.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4lOacVy40XwVYJjqWFP2bxmpd5EJuU0379v1ZkdiCmCc7A9nSm4kpccKXpFWRQXyt28iF0c8dVUtl0sOJ7pm1ISsXW9Mk7gEtqArSOyOxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U-Boot requests the PolarFire SoC device serial number during board
late initialization. The IOSCB previously rejected every request, so
board setup could not complete.

Model the System Services control registers and byte-addressable
mailbox. Obtain the 128-bit serial number from an optional device
property, using a deterministic value when it is not configured.
Return an explicit failure for unsupported services and reset the new
runtime state with the rest of the device.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 141 +++++++++++++++++++++++++----
 2 files changed, 130 insertions(+), 17 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index 9687ea25b1..fd31427304 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -25,6 +25,8 @@
 
 #include "hw/core/sysbus.h"
 
+#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
+
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
     MemoryRegion container;
@@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
     MemoryRegion cfm_sgmii;
     MemoryRegion bc_sgmii;
     MemoryRegion io_calib_sgmii;
+    uint32_t services_cr;
+    uint32_t services_sr;
+    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
+    char *serial_number;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 09b702e520..7c82b55986 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 
@@ -37,6 +38,9 @@
 #define IOSCB_CCC_REG_SIZE          0x2000000
 #define IOSCB_CTRL_REG_SIZE         0x800
 #define IOSCB_QSPIXIP_REG_SIZE      0x200
+#define IOSCB_SERIAL_NUMBER_SIZE    16U
+#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
+#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
 
 
 /*
@@ -186,33 +190,71 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define SERVICES_CR             0x50
-#define SERVICES_SR             0x54
-#define SERVICES_STATUS_SHIFT   16
+#define SERVICES_CR                         0x50
+#define SERVICES_CR_REQUEST                 BIT(0)
+#define SERVICES_CR_COMMAND_SHIFT           16
+#define SERVICES_CR_COMMAND_WIDTH           8
+#define SERVICES_CR_COMMAND_MASK            \
+        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
+#define SERVICES_CR_MASK                    \
+        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
+#define SERVICES_SR                         0x54
+#define SERVICES_SR_STATUS_SHIFT            16
+#define SERVICES_COMMAND_SERIAL_NUMBER      0
+#define SERVICES_STATUS_SUCCESS             0
+#define SERVICES_STATUS_FAILED              1
+#define SERVICES_MAILBOX_RESPONSE_OFFSET    0
+
+static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
+{
+    uint32_t command;
+    uint32_t status = SERVICES_STATUS_FAILED;
+
+    if (device_is_in_reset(DEVICE(s)) ||
+        !(value & SERVICES_CR_REQUEST)) {
+        return;
+    }
+
+    /*
+     * System services complete synchronously in this model, so clear the
+     * request bit before exposing the response to the guest.
+     */
+    s->services_cr &= ~SERVICES_CR_REQUEST;
+
+    command = (value & SERVICES_CR_COMMAND_MASK) >>
+              SERVICES_CR_COMMAND_SHIFT;
+    if (command == SERVICES_COMMAND_SERIAL_NUMBER) {
+        /*
+         * The serial-number service returns a 128-bit response starting at
+         * the beginning of the mailbox.
+         */
+        memset(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET], 0,
+               IOSCB_SERIAL_NUMBER_SIZE);
+        memcpy(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET],
+               s->serial_number, strlen(s->serial_number));
+        status = SERVICES_STATUS_SUCCESS;
+    }
+
+    s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
+    qemu_irq_raise(s->irq);
+}
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
                                      unsigned size)
 {
-    uint32_t val = 0;
+    MchpPfSoCIoscbState *s = opaque;
 
     switch (offset) {
+    case SERVICES_CR:
+        return s->services_cr;
     case SERVICES_SR:
-        /*
-         * Although some services have no error codes, most do. All services
-         * that do implement errors, begin their error codes at 1. Treat all
-         * service requests as failures & return 1.
-         * See the "PolarFire® FPGA and PolarFire SoC FPGA System Services"
-         * user guide for more information on service error codes.
-         */
-        val = 1u << SERVICES_STATUS_SHIFT;
-        break;
+        return s->services_sr;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, offset);
+        return 0;
     }
-
-    return val;
 }
 
 static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
@@ -222,13 +264,17 @@ static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
 
     switch (offset) {
     case SERVICES_CR:
-        qemu_irq_raise(s->irq);
+        s->services_cr = value & SERVICES_CR_MASK;
+        services_cr_write(s, value);
+        break;
+    case SERVICES_SR:
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
                       "(size %d, value 0x%" PRIx64
                       ", offset 0x%" HWADDR_PRIx ")\n",
                       __func__, size, value, offset);
+        break;
     }
 }
 
@@ -236,6 +282,55 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops = {
     .read = mchp_pfsoc_ctrl_read,
     .write = mchp_pfsoc_ctrl_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = sizeof(uint32_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+/*
+ * The System Controller uses the mailbox as a byte-addressable shared buffer
+ * for service command payloads and responses.
+ */
+static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    return ldn_le_p(&s->mailbox_data[offset], size);
+}
+
+static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    stn_le_p(&s->mailbox_data[offset], size, value);
+}
+
+static const MemoryRegionOps mchp_pfsoc_mailbox_ops = {
+    .read = mchp_pfsoc_mailbox_read,
+    .write = mchp_pfsoc_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = sizeof(uint8_t),
+        .max_access_size = sizeof(uint32_t),
+    },
+};
+
+static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
+{
+    MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
+
+    s->services_cr = 0;
+    s->services_sr = 0;
+    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
+    qemu_irq_lower(s->irq);
+}
+
+static const Property mchp_pfsoc_ioscb_properties[] = {
+    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
+                       MchpPfSoCIoscbState, serial_number),
 };
 
 static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
@@ -243,6 +338,16 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
     MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    /* Use a deterministic identity when no serial number is configured */
+    if (!s->serial_number) {
+        s->serial_number = g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
+    }
+    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
+        error_setg(errp, "The serial number can't be longer than %u bytes",
+                   IOSCB_SERIAL_NUMBER_SIZE);
+        return;
+    }
+
     memory_region_init(&s->container, OBJECT(s),
                        "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
     sysbus_init_mmio(sbd, &s->container);
@@ -265,7 +370,7 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
                           "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s->qspixip);
 
-    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_ops, s,
                           "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG_SIZE);
     memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s->mailbox);
 
@@ -343,6 +448,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, const void *data)
 
     dc->desc = "Microchip PolarFire SoC IOSCB modules";
     dc->realize = mchp_pfsoc_ioscb_realize;
+    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
+    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
 }
 
 static const TypeInfo mchp_pfsoc_ioscb_info = {
-- 
2.53.0


