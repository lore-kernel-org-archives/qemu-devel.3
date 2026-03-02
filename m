Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFE2EA4E08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3tG-0005I5-59; Mon, 02 Mar 2026 09:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sJ-00050K-Rz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:11 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sG-0003rA-DI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:03:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwSXF+f6LVlpAFeJOlDt9nUsUQ67DDBLUFlS66EHTp0CzUFduZcPltW47pB+sNbMQ/Zi7bjgiTChdTdaSPOFs7CUdNFVYlpJ+nKjUkSK0PTQGg4wdUJ0tyTyl/k7kipnzuRqymc/lt7RKLXFnwNOYfE+E//WhIweOOdHrLLyJUSYTPr7fUGVkkWFpWh5475daE3fAqzeQy4h3umxVHJ//VJv7mlIo9Rga5kbrcxcQQx//MCopoxReF11vlGEbWunot3A3otiRRsGCPiDzPlo5ieQLshAl8iE4nxpJi3s8sHyLmFJhzBL3fRQZMCD15BZD5D70xU+rFBlGJuMydKCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aydg6UENx8H3vEPcpSG/lAEjOt91j8TzpMK3+iJo6n0=;
 b=wJSUoDeBjFqe5uE4fP24vbkI/Cy8Cv9fHXfQy3IyzTKzX/Ch1aSQV7mX9RuKO+uHcLeykXuZhQ5eeqrj0eeMnWfxCGasKDfd2bBi+E6FqLXY2Y8SE2BLGFAkXnwuASMjg6muUDdunY/HEePsANSSYFiJ2xuzMeLkTQpIzwyNEM1qEu02JArfdIjgUWGis/5qt4jBfQD0udR1mmp7Rp5kR5KmvRrfdPitm3gsaQVKruQQtxkoFrFTgxBK1WZ5EF+4w86Yq02G2DBNa2E8WKWzULXiZpje3r43wvRRD9068DR0Uy6wmx/ZBYYg9NGSN+nziWLwy4kFA097taD24A4tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aydg6UENx8H3vEPcpSG/lAEjOt91j8TzpMK3+iJo6n0=;
 b=XWsW9MrGZ5j8kNj4gbOAIaiXReu7vfixWvnTJE0OkuHuI1uQN0MlVNa1uAfiuRaAjQYuxGkykC1pewjrYVre7U9+Y7CPOf/msR7+7SjPJAAECo33qW4zJr150hVRMDU6dElSxBaHSpQSDQa8U4GmUSK1hpsAPK93af5nKvQSesA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:46 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:46 +0000
Message-ID: <90d7abc0-0539-4e3f-978f-5f51ef911415@epfl.ch>
Date: Mon, 2 Mar 2026 14:55:57 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/7] plugins: add flag to specify whether PC is rw
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1029:EE_
X-MS-Office365-Filtering-Correlation-Id: 4079db75-445e-4cb4-9cda-08de78648535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|1800799024|19092799006; 
X-Microsoft-Antispam-Message-Info: BNgmPhb2hgO0EWqBfjCmmlyt1R9ETIU4GQ1RYHAXTz4n5f80A8hTovlzm82rPdlVD3AJ+N9B/9SyEbyjo3e94xZxAhmuAa7/XmnUgqmGyy6N3ytmHzzVWja4TdtKIgeT3uZW9ok6rBEmF+K3o3YCpDn9GtWRdgoPfusHBerjvCRY7bXRJfWtJXZ/Lb51O3wjb/NN0+jn8z6/cMUX+L3uUQdw5U+2XYkkBADS10trfvO78CK6H3N9rVoaWxCSqRRs+qaG5l8SpS1vRgzZd3VoxRxqKdUnnNZEOKIJBlnfkI/TuOaKxGhzr5H1/GnqFaCQ7K264CbFPfZqHFmMJ2tnuM04Am1Mfgg4dRHG6UnKbBPPceb9GvFviDd9PF3HCnfWMBTFYlkSDmgHEST7CIqxcmzXiZnPrMmD9S9RzBNGmE42Q3WpH5kNghNcLnDLCGmutlvs3hn/Bv44UX3ezAHhbvthh0fLq4AbfrHR44z+9dSV6njHRNQAu0XYY0V8auH3ZUoEtNJGfCXf+Wv/AaiG7R/8tVZ+SWIstSc2Zl76HyEYwC64unxljwKOb+MSTV2hy67YBUsABMj9c2vJxQwK8XI7xyCFzctiA0UmOh3gZ+OCVMpqT5VFPyhzLnCADHxgBggbuox6poXnZgfWjT8DU30+kFDDC4e9mXRoH69CI0RRm8yDluiGtsot7jnbssUICAH3eWebz7z0CkLWa+MUjT5XSNCq4h9/UOoa/UOehh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(1800799024)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5ZeWZqdGVkQmR1Ukg0TXk4UGdjU295WkVJMXZIYjF0aUxlZ3RHUjBoTHV1?=
 =?utf-8?B?SnlIdTFtYUNROUVKWStiVW9NZmJFT1dWVjAwajNSVFE3dmdCS0pPUXNSdXBE?=
 =?utf-8?B?WVpaNUt4UjRDOUhSM2pPcVQwSDArVTlYelM1UjZXT24wRndWTVdQMUR3RndS?=
 =?utf-8?B?WDRtRUJsSFNWYzFGMm1FS2RmclQ4eFhMUjBCemVMZ0VhWWxmbUR5V0FMSnAw?=
 =?utf-8?B?NGpBaW9HWXlUbC9nUGhtSEcweGZEaWZBM0FSbE02WFUyM0RTLzg1L3NXbmxv?=
 =?utf-8?B?YTVrN1FQaDNoNElwc0VZaGFlMG9SbmNkRDZNd2JyeFp1WjJOU3JPNCtWODRh?=
 =?utf-8?B?MTNyVVZ4dTM3RjkwMjFkRjZZeEF1OXR1UmFwOGZzTlhQZk9VOTJWa0xYUm5R?=
 =?utf-8?B?S3lhTU9xK3I0cllpYk44eDZFYkxWN3NqQmRLMERLVXNaK0p6VGlSSTZhY3JW?=
 =?utf-8?B?cXdQNDdNSE1aT1EzaC9EQjAvWGdXazVkaGh4YUtaNjNnOGlxdnpjdGtLcmZK?=
 =?utf-8?B?NVlEcEdZdGRtcTRaNGRzRllRVHdNR0pYcEo1TVVZTHU1M3laU0o3L0ZtbVhV?=
 =?utf-8?B?aDlUM0pTdjVYT0FvTmFOdXJySmd4WUlOcTZQTlBZT3R4TnlFQ1NNNFlOWE9Z?=
 =?utf-8?B?LzFUMDQ4Q1FUb2FpRGhtN1RlQ0d4U0hienhPczZVUTJvU0ZEM2FxVVdoZEs1?=
 =?utf-8?B?ZGpLNnJDSEVJdXdDbUdKQXlwSFdUYm9yUUwzaUFYUXdPRlZiVnRadDJvT3px?=
 =?utf-8?B?TzY4TGhsN2cwekgzN3MzditRbFZ2NEo4ZU1JVHNGUWlDTjVRc2NzSCtCekFB?=
 =?utf-8?B?UjhGcGYzdUVPVWs3TWRKbzhURWJKaGZtd2pSS3ZvZ0c3ZnVyMGdYZDljUFo1?=
 =?utf-8?B?V0VSNThvbU01dVlFRmNLWUZmU3pWMERNWUpQeTR6NkJaZDJNbllaU2pGbm92?=
 =?utf-8?B?eFNvNEEvSEh1UVpieWZlK2VMcU94bTUxQnlINUVOSnlVVTF0MnVTMVlvSHFP?=
 =?utf-8?B?d3QwU1JaMTl0ZldwNjI4MjVKbWcwZVNYYnNYZ2FYbVl0SXhsUWdGdCtySHIw?=
 =?utf-8?B?Nmloa1FRMm1sT0dNQXJTWEo5ZkttZFZ0TWFRWUhLMmhvWjFucVFDSFRRWjFH?=
 =?utf-8?B?dFBwN0QrS2h0ZlFZWFFQbEtRVWEyUjNLS3ZaWlVNbHVEN2xPZGc4V01HZmQr?=
 =?utf-8?B?aU8yejlZaWhyU3ZFaWpjUC9aMUlOdU5aeFlBaExTeWxDQjFhaWtZWDVkeVJ1?=
 =?utf-8?B?OHhhMlI3eFlnaEdWSUs1QmZUU3I0WEVoT1IvMnRISzUxNEYzL3lScVU3VjZw?=
 =?utf-8?B?REg0U0RRUmNJZ1U4SUc2MTFUU1dEczZPcXhLbk9GU0ovV2xVbFo3VXdFNnUx?=
 =?utf-8?B?MW53NytrZXNzRVhSTmU1djBobHdPbUpHNWg1dDZUNnhSSEJwZVBka1dkNjBa?=
 =?utf-8?B?NDMxRktiWlZxbXhKdUZXMFdHL3Rwdmd3NGVxWWtIekkzWGl1Z0RxaFpaTDlr?=
 =?utf-8?B?U3JyME8yU2lQcFFOODVta3J4Nno5bXhqeXNCd0Q1UjBEVEdTSmZ4NE1zS24y?=
 =?utf-8?B?YTl3VWIzTlFBMXB4bzJOSXhOZ3N2N3A3UTNFZXppWTVzNmpnWVZBbFQ1T3JI?=
 =?utf-8?B?U0taTkJ0TnR3b2tWekZFUURXamovdjlkbXVnZExmbktFZmdONEJFUlJVNU5x?=
 =?utf-8?B?MlNTa0poNkJZWGVWMzBOdEQ4YWlUcXNzNXhMekNrMExKV2RIdGFkZ1o2cFdM?=
 =?utf-8?B?WVAwREE4OVRSTCtsT2lweWF5elV5S1d0VmNudXRCUjZaTGhMSEtZVXRib3Qx?=
 =?utf-8?B?dllweTJhNGFreEVmZEx1LzFXSVNUaDFLVGlwRVNvV01qMHVyWXlDOWMwMVp4?=
 =?utf-8?B?bUgyVVlQSEhpOStLUW9mR0ZMSGZtVTJrODlNNUgxWUl0QWQ5NGpuNHRGWW5J?=
 =?utf-8?B?NDZTcTFwdnZDbHVmamZJOStoenRVMlJyVXhFbFBxSm9tYXFjZFNoVy9YdUhz?=
 =?utf-8?B?ZGV0Z3lqYU9uNGVENUdMMUFjZzFML080Wlc3Q3FNS201RXFWem5tejQrUFlh?=
 =?utf-8?B?bnNsYytZbVlGSkc1bDVoTWUzRzZiMU84c3g4dWFFbitScEhRMzJMYklTbi9M?=
 =?utf-8?B?TTkveDQ5YXMvY1FvSm1jZWV4TS9jNThEV1RDV09XcUZ6Z1FTTFJ3aUZFYVJB?=
 =?utf-8?B?dExnK0d0bWpjSmVmaWozUUorUzFwaUI3VERoVFRBWFZpVkV6K1RuWVRTUUpV?=
 =?utf-8?B?R3JUWHBCUktVZGF3Q25nUUk2eEJJMDgxYjB4SlJSYTFyYlVSQXM0cW9FWXpt?=
 =?utf-8?B?NWZVQmNOdnJGS21YQ1MwLzZqdWlhSW5SMjJxWVYxVjFBN0plNWoyQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 4079db75-445e-4cb4-9cda-08de78648535
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:46.1802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMjKGRJAL3P4JHRfvayAY9WHosCw5+ipPExG0YO7MLtKsmCslGOXapqhdSE4VHnFrsurAM82Y/LmIk3/51dJfU2qbV8ING9lF+OAPQvld4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1029
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In addition to the flags specifying whether general-purpose registers
are read-write (rw) during a plugin callback, we add an additional flag
explicitly stating whether the PC is writable. This is in preparation of
a patch that allows to explicitly set the PC to divert control flow from
within a plugin callback, which is currently not possible.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  4 +++-
 plugins/core.c                | 29 ++++++++++++++++-------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca9..a6ec8e275d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -325,11 +325,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
=20
 enum qemu_plugin_mem_rw {
diff --git a/plugins/api.c b/plugins/api.c
index 04ca7da7f1..32eb086300 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -458,7 +458,9 @@ bool qemu_plugin_write_register(struct qemu_plugin_regi=
ster *reg,
 {
     g_assert(current_cpu);
=20
-    if (buf->len =3D=3D 0 || qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_C=
B_RW_REGS) {
+    if (buf->len =3D=3D 0 ||
+        (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS &&
+         qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
=20
diff --git a/plugins/core.c b/plugins/core.c
index 42fd986593..7220b9dbb4 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,7 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to =3D cpu->cc->get_pc(cpu);
=20
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time =
*/
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
+        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
+        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
=20
-    static TCGHelperInfo info[3] =3D {
+    static TCGHelperInfo info[4] =3D {
         [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =3D
+        [0 ... 3].typemask =3D
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t=
)
@@ -534,7 +537,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, ui=
nt64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func =3D cb->f.vcpu_syscall;
=20
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7,=
 a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -558,7 +561,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_=
t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func =3D cb->f.vcpu_syscall_ret;
=20
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -584,7 +587,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t =
num, uint64_t a1,
         return false;
     }
=20
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
=20
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func =3D cb->f.vcpu_syscall_f=
ilter;
@@ -605,7 +608,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case *=
/
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -614,7 +617,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -885,6 +888,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_fl=
ags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }
--=20
2.53.0

