Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE553C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqgh-0001OL-2B; Wed, 19 Aug 2026 20:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqge-0001Nz-8i
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:16 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqgc-0000HM-Fk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVZ3uLMyqdxLdQocZjPFVoqys4AMh/lPNPdoaPww/cIo9WRvLe/+ZdQQZR3dbgRmATANCZLszD6o++KD+0dIcEs921HNqXKWPM7EzFqToYtM70qEP+Yd8I1AX7T+gyQhCieE1jGbB4nIgEiwDtIT7WkvuCYAZ1TBUA1W5xbSipZMD0wuUbj8zZyyhTWI4Cfh9KqQkk887R10hwFnAjOpW0zXJB320529FDzLkbbU+tm0H4IvFA9n933ec+TeTquNl+63BAFk5qW8ZxwIk0ZXjpLoU+ohK2zO0pdOnXy9mAfUgHP48EYzpuu8oGyacmWDUwNXKQKQKzNlq68+QEbgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDrEVRtjnJHYify1iYnCgEyrdqQCIaGz/4MU/4m4ul4=;
 b=NhLZTqtg90bJEh5KYJfJ5pwS68jf3iSOwb8kiiv9oLz3pfgKuxunFZxzUE9cyP0JuSkjFq9HNOq+zf1yoheydhyMhrYIKvClBQtm9uc/KO+u8ALjozvGSVe52P97wPyC+ABk3EE1bXSb4jku0Zn88QO280q+2sexuNKEW4ca8XaZ8FzolrFNnJxt5Rzvyw7Vbm8C7BhAd9YbxM1R+PhMRkyATnxsBckPd0oJvJgYcLZT571bWuryJFHy9GFQAxm5o9PaHVIBozExwr0US6k7Kmf1dYEvQnLm44NdUl123GMVRxtYKWebyVo9MftLrlZPFsnns20hWtNAuCD6DgS2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDrEVRtjnJHYify1iYnCgEyrdqQCIaGz/4MU/4m4ul4=;
 b=ijkW6gCNR85iK53TB2pwAIkA6WeKOg4QZgS3xk/cCQbYN7PUDos8N4UqSy7Cc9k0GehrO7zyrxOTQ4F4h9GeIa2IvZGnqyjmWvqggF6hzCKcR+sL5uSzR04lMoYrVfNn+dZArgR9oW0AX/b7pdSJ+uo44eee6oj/5Wu3FGlMrWc=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB4995.namprd21.prod.outlook.com (2603:10b6:408:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:30:32 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:30:32 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH v2 3/3] target/arm/whpx: fix whpx-arm post-reset CPU state
Thread-Topic: [PATCH v2 3/3] target/arm/whpx: fix whpx-arm post-reset CPU state
Thread-Index: Ad0wOvX7KRmul+aAQVma6nc7LGcZLQ==
Date: Thu, 20 Aug 2026 00:30:32 +0000
Message-ID: <LVXPR21MB700904005D373B0ADE250F3CADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b470b1a5-60e6-4eee-b3e9-1587ea36fa65;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:29:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB4995:EE_
x-ms-office365-filtering-correlation-id: 6ebf59e4-904a-4cac-cd2f-08defe523e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|7146999003|56012099006|11063799006|6133799003|18002099003;
x-microsoft-antispam-message-info: vnFsIqe5RJCoKzgTJsCfKAsESweHLcjkmwOamHi/ftHPzKRXp1SHw51yzLXI+W7TqCliTIcCWuWkRTXxWy/BDMijqrZSFHpLiw242621Eu122RN0CUTaMhSuXWbKiJhXbfLFS/CN2FzeOcX9zoqvLfqjW/2fxdXKQ15VQpm+rHpza55FBc3LcgMyzrLGG53Ig/D74c7ebXejfQNIXy5iUcfn6A5sh5kgtmMbiwuPOLwBWtMhbFUgg3VuLMnRziVY28EMpG0rvYJNi3uvFBrSyNaPHVq65iw2k5iHNdUoYbxtwRQOjBgv92knOOL5oCnfcy769eiwFanTxF7dzgt1x78KRL2o24y5GYPtg8+BHAjbEiWrzl+eRvEu5UyB50626Qj6q/7MWOprco5JlWv0PdbwWA0ctiVLk/m8CvG5pkLy7VZHiF96mb/L3UgnTDriE9tjhsgq11zxvKaYStrLEO7wZ+EHRInE0nEK/qljUxSabyxpPJqU7WSb5tjBwBEYyqB4OljOy39vqngrGtA4BE26K/gHJj4hn7NyhOCnT195iY5sCednj5IH+Cv7jp6Vh30TcmO/dp0eJDgYPewgLkWAptLoSyWUllQNvs8vAn4gcok1huNDF5uGodN+9Qzn3aILYy6Z7i0xDojCoxmJO+10PljQeYd8GfDX4nfUtiRaeuoIEhSOHL6vJl/surubAJN3VgYpA3qtHvpkuOwnfZfG1TbRzU70YyzfPNxSsKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f1Oj4r5LKyTT+bEb5P8W1z/u0qmk0eYGMUeCrWpJWy0+aYreN3Gk6sbojM1D?=
 =?us-ascii?Q?KIsrf6g/GjX7CVBFuDelMLsBDsKzl/sZItuSPEx1dQX00M+MQu9pdMEkQUTn?=
 =?us-ascii?Q?jOKZBmO1c7IqWvq7ycN1Gye3NNGJmVBwqM29Kt6xZ8Wc02dx+izw7Lxrpipp?=
 =?us-ascii?Q?ELkZEkT36N/wpquTCmjYnAr1zUgXcUc1zA4NwZ2P49dI72qn9FUoyFKkjAOp?=
 =?us-ascii?Q?BvAaaTFMdc86KhRBqn1K2jjYgywTc7fXxHs80mhOnl1pSg1Mzcqi2G2o+n9f?=
 =?us-ascii?Q?qRCs92cggiAWWWfGfjlcu31sufkO5Dmf3Ws9P/yYLvQjxzQxfKA/2RI5rY9I?=
 =?us-ascii?Q?zuoRdA+At2ahnu6C/0d+nYEjZlg5B4EfiEcZCmi3jr3KMCfufxV2S/usiFaS?=
 =?us-ascii?Q?IsDiU9t7kNBbnxquePN3qpOtVovYNvxFIl0JPjQB1ejrltj1Iiuxeow2jleK?=
 =?us-ascii?Q?zVdyBOB3xDRlucxrPFC9h7UxbMUtt5FyVYgxsVxypZSsOu/N1p0fA7KUWLRE?=
 =?us-ascii?Q?oJpVQsNmseHtp6tbeRzHQMmSZkUtEYyMqQuL5m3lCbnWethzosZL9OEGLR89?=
 =?us-ascii?Q?7fnKWCaqsJEl0QgXk6RqMqHiYPebC3g94tWiX1rjUR9sqNOFwj5IekXKkKpJ?=
 =?us-ascii?Q?vVVa39R0409sBcHWnKfk0upOysKEVvGW0hvIlRknpNMxDffCdJL2BUtQ5Ick?=
 =?us-ascii?Q?Xq5LbEqXEATZ8Bcr98c17w8uqee6NkCrJ8NK4UTbBzzoFzl+GyT69C7SIm3Q?=
 =?us-ascii?Q?pJGh5oYPA8B30DeEIEwc+6dIId6YXG+IT/h4PAoqR5NYvFAHey5UpiI4u4N9?=
 =?us-ascii?Q?T47nAgBel/59ezwr9rQOaWk2nF3kr0clRXr0fcSK5Y3m9gk9QvBfB+IXm2SD?=
 =?us-ascii?Q?2SFD3jO4mVtyFCag8vKrOEj7SFJm8+WjUu8k8P3bHvfE13BI8gijLt4AtAOb?=
 =?us-ascii?Q?nS0wyNNaD94KbsCe51HEUxkALABVgQgrD2UBGo7nbDd4vjIeBqc2ZmphNPlF?=
 =?us-ascii?Q?35nDvKsP5+VvOyI9y07ptZcJIkQFFS6Ezw+/ZbIbg1ugf9zXGEwwdhB4mDs1?=
 =?us-ascii?Q?ZTcmNuk3SsMi+8SsroOl+TUzkNm+pDutAVuTPGG5RlEu9f5UlajAN+rivY9V?=
 =?us-ascii?Q?LyPMsQDo4kJlOZ+V4KOIp4z332/bGWCFwiCbBJE/q/GxZKTYRdoedi+0HIm8?=
 =?us-ascii?Q?aPSiJtkmDvkniHOIoFF0NLPo4ILOFR5Z9pgyWRObPtjVSVKaqBnJGGGSaGKr?=
 =?us-ascii?Q?k6tGa5xePiNeeYt75tvtbxVFA8mfBdFAgYjA80Wx8DDL3pR0Ia4qcZTiKMAe?=
 =?us-ascii?Q?txbqtxJra7Ql6hhwS3hj6gV7tq1eHF2QDIv/omZ/8cQZFLJmhzx68mz4Ngl7?=
 =?us-ascii?Q?GC2W7QkRV8QfDVdqDSPZmgXLIReTZMMM+ac9jabbHHxmMFNbv4sWWjM/j8dK?=
 =?us-ascii?Q?soWkIghFzb6RmCoMdcaG5aVv7nMyvemNMqhtubCWFGxGAr4Bg2x6tmL0e5eB?=
 =?us-ascii?Q?tU90ocPm32h+ReDMaNP+lNuFl7OZYjf+cNlZ6O8i8ndwF6kGsiXJ5tkKmlz1?=
 =?us-ascii?Q?ooHoq0vnhQAbincuEBtZ3UVFxwxEABlsQ47lSvYzZrbT/ifUYn56i4zJi0ur?=
 =?us-ascii?Q?qlNgFw5XK47fyQgK8K8mrfxPHM/jxe4E8C8JdEJVJhgmNSq4rs3RIumoYAp4?=
 =?us-ascii?Q?WXoKMwAJXcqO/hIl3XiwHLSuUSckyA8Yx5PbVTnhpQXluK9g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebf59e4-904a-4cac-cd2f-08defe523e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:30:32.2689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGYeC6w8t2TkKi/Xfhjhv4ac4W93qg8rFLUikV6N7uuhJI4sbZhITa2QdK7fKfNIb2J/Btx9M4g0Cl+2VEsmFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4995
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=dcook@microsoft.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Reset should leave CPU 0 running, and should leave all other CPUs
suspended. Instead, no CPUs are suspended and CPUs may be left in
low-power states.

Fix by updating state in whpx_set_registers WHPX_LEVEL_RESET_STATE.

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/arm/whpx/whpx-all.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index a05df7d2cb..d106400686 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -613,6 +613,37 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel =
level)
             whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
         }
     }
+
+    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
+        /*
+         * WHPX keeps the "vCPU is in a low-power wait" state (entered whe=
n the
+         * guest executes WFI/WFE) in WHvRegisterInternalActivityState, an=
d that
+         * state is not affected by writing the architectural registers ab=
ove.
+         * If the guest happened to be idle when the reset was requested, =
the
+         * vCPU would stay suspended forever.
+         *
+         * StartupSuspend is the bit WHP uses to hold a vCPU that has not =
been
+         * started yet, and it is how secondary vCPUs are parked until PSC=
I
+         * CPU_ON releases them.
+         */
+        WHV_REGISTER_NAME name =3D WHvRegisterInternalActivityState;
+        bool powered_off =3D arm_cpu->power_state =3D=3D PSCI_OFF;
+        WHV_REGISTER_VALUE ia;
+        HRESULT hr;
+
+        clean_whv_register_value(&ia);
+        hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
+            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
+        if (SUCCEEDED(hr) &&
+            (ia.InternalActivity.IdleSuspend ||
+             ia.InternalActivity.HaltSuspend ||
+             ia.InternalActivity.StartupSuspend !=3D powered_off)) {
+            ia.InternalActivity.IdleSuspend =3D 0;
+            ia.InternalActivity.HaltSuspend =3D 0;
+            ia.InternalActivity.StartupSuspend =3D powered_off;
+            whpx_set_reg(cpu, WHvRegisterInternalActivityState, ia);
+        }
+    }
 }
=20
 static uint32_t max_vcpu_index;
--=20
2.55.0.vfs.0.3

