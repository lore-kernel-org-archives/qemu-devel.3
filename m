Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFE2EA4E08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3tH-0005Nn-SN; Mon, 02 Mar 2026 09:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sN-00051U-E2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:18 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sK-0003rN-7i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:03:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoJTstco/mjfn8z+X9A4PZJ6B1eA0X5uQMaxVHU7N+/S84S8jWpb6KhQ6AaQl2qp0ksMZxw4ZU5Ib8Kc1K9HHsiIEvRImNgoF8xcjs2aocld6p4ZZWXc2pqzacoq08jsFASB/p68l/9dJ/BA1wVyRhIdGLwdF0/ENJPP1zYvp8BhyY3wQCeZSiQ86YEYTCsft620+urgzfPFeO1xAZD2PQ7TIAedUwisHYAokns60vNkWlR1K4/ikn3uZAcNeuYlXgVNVArVcsL7cBXtWGuslNWYIt2i5nw/zo2hKCixrDroPK6HZDTVZGHlq+MBrxVf2uVGt2iIqQUw0O27NfcdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42SBTE34Pgecvosx7fUI5JMniasj5R8s48n88vQBM+A=;
 b=uyGs04tAA9Y7M8vLH1d5Z3A6EJK2lNq76pYri2VzzfUx1Z1f/24+yC9pEozS/cnV+MTO3/gSAs0xOXnJGxpYcI0ABLbZ45jaem/+BAyYP4RFRwF9rZvDGGRN+d4MNeJCX1L/avM7IOSwrAi0EvMH8EoLa3uLIY8QFYTDnNyO+NzVLnu0ftfqQF0pH3KKEqbRBpkQ0UW8OkNrFczAyXgfmFLeV73EOOfjFli5zi3NhcqZGIeykwYxkuy0xiIkm74Ud6KGU0FDWiu4adearfoCtq0ewJgKO2c0UMM6tirwOnB5CV56p5Aomh2lyjyzkw01Wg+pri5mgUGolwGmRGGbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42SBTE34Pgecvosx7fUI5JMniasj5R8s48n88vQBM+A=;
 b=OsMZBZlGtlE9jWBjYN2m/nKF00lIbxyIyVwoiF7Q98gtfTHnTOo4mreVP+ZJHmGWPmJ3uyDwXjXI3+E1h4/3DQ/R53T92MZoZAb+NiizdJnwAvVewLUkYyGE5PWB9HGlZyWTNqAbgpVdbAEjWm05tTv+xt6b+KEjOWj9mngtwpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1788.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:50 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:50 +0000
Message-ID: <c40638e5-3972-42c8-88a4-93357c951a7a@epfl.ch>
Date: Mon, 2 Mar 2026 15:01:35 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 6/7] plugins: prohibit writing to read-only registers
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1788:EE_
X-MS-Office365-Filtering-Correlation-Id: e77c37bd-3a33-4915-e633-08de786486ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|366016|376014; 
X-Microsoft-Antispam-Message-Info: dJbLmNoMuatpNaiO/trTKidnm3h1LZJWvhH/OcYN8A5+2ZA/dbB6gqTl/txZS6Zcwn3bmzv59AvxKy0uoaffOrS91gE4lLLsA3NRcc6DojFcafyudRBx/P8qIoyVafCC3BEFUx63d5ny7Ip8ls5+8FRM1ypPFmL1t42P2E62GmNIgncosGcUOBap5TH8bCCA8kZPYKPpNkWWg4d+p9dJESm7tIlZhev+V+w3CoEJSouxDxUqLCQVG2ZdV0GWgZkHPoOl9BIpJPuq9vK48YaOnExz1a4tjaDDX3ngDTmNjv40a+7CoLx/uXP5sJEjy8PIDJb0/KqHH6wm2rW7KpNypU4bg9lfUPzly2+BbJyxJWP4JiuJ9deG3j0ZoBENJh5bxBP0KVtxtfqy4ffbOL4i+8kEIiKAczH15E8cbbQUbVggr4lMyCPiZZ+dKJdPWw+VMJ6wjo6vjIFr48H8DSAKcL3iBm0udRtfbi9baDUsUtjD3a7rRLnN4O9aZZnNY3ybO2gTTJ2VMs5M95IhrxXZrRTSLe0teUuWP5QO2uHV9sRWDN11o0kYbBOF5LJizC009LoCguNWoXGPVVmxRaVqbqfZBOAhA3dmRnZKJ+qyg6abQJVqx0Bj7AF+UWYvh6ixCb5GJjs4/x7zSo9+OfuEE0g6UxEdcXsxuzuiUCgZ4KppYNPB+8zPdnwikgRzFswnPZkDOxKpmwV6zTKi3Il3K3RbaLEjoug4Yil03nL2WVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(366016)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGU3djZoWTc4ZjFjNi96d2xsendLUlVHcmdtY1dsUkJwVjltT2tpUXAyYXlP?=
 =?utf-8?B?KzlKNWV5RnVYM21lSy9nd2RaTzExQmJOZzcySXdpNXlsTEhRb3lHam5sY1RB?=
 =?utf-8?B?RjljU3hTM3F3dDlUU3lkYXA1TlNnajhJeEVpZDUvOGd5MkdHQm1STjhhcXJn?=
 =?utf-8?B?WENZblI0RjFiUnJMa2p2dWU1QUdEcEFJajZ5am01QzU4YUNBWXFMRys3REJV?=
 =?utf-8?B?TDJtSzI4dEhkQ3FCN3FlMmJyWlZWY1l1OWxBUGRJVjFDaHBML2tqcGQzdS9z?=
 =?utf-8?B?dEhMckZjZm12UWgwdTZqbmFORC8zZG55cWdMZFVQeVkzaGFUZHpGWm1aN284?=
 =?utf-8?B?ZWZ6S0JHelB3MEltQ3BuNDJ2MGttUk5KZm5UTWIrRTNBd294Zm5CNWlkNFNE?=
 =?utf-8?B?cVJnME1GMTBNWjh3K2p4Vm1aYTFaaXhJVUxWSTU5dUgrMi8yODZHR0N5dHRR?=
 =?utf-8?B?cjZpRTN5S0RoaGN5USs4MmZqY1Z0dHdjL3dVNlNlL3lrbGk3Z0p1R0ZYcmdG?=
 =?utf-8?B?L2hoM0dPZGY4VFpnSHhFRUdVbTNZUFoxY25rbXpVUWJrc294T1JFTmtIYWtR?=
 =?utf-8?B?Vkk0YmRPZWdKUEI4Z0xoTzBQQXdBVVNWWWU1ZWVIbkFWSVVEZGJPM2Rxa2Nm?=
 =?utf-8?B?ak5rZnRZTjlsanlPc2xmRURSelJydVRiNFdWaG5PbGsxOCs1NFdweFFlYTF5?=
 =?utf-8?B?VHBzdmkxK0d2SkM4UCt6TWpqUzZQWUhUVEsrNEZ1N1pkZlB0ZHdxTmNJRUxx?=
 =?utf-8?B?RnpuWnJyYThOK1QvQ05UdmhBTUVaNGRWQk5Qb2ViWUxhQkpkbjNNL0VGVGYv?=
 =?utf-8?B?UDErbXMyZ1o3azU1NE9vK2l5ZHhKM1FVR0F1STRLaFN6MDE2VkZuNUxUeHpR?=
 =?utf-8?B?cHpTSnVXeEZvNTVjcjI4ZlRja2NRS0huTzZrSU9MSmNYTUZ4aVg2b0ZMYzZp?=
 =?utf-8?B?bTg0bUxuVGkvSVBMNGlwRHJwYmZCUDBmb3BsdUQ4a2JsOUdiRG9Sb3FIVkxz?=
 =?utf-8?B?QnVzUVNvRjlFdTZhU1RPNndXSWhnTHM5Y2ovaVE4dVZQU3dMRnFTc2Y1dE10?=
 =?utf-8?B?cnJGSFpidGV3NzROSmVmcHU0WVdWdndEdGIyT1JDSk5wRWRMUkNPMURlZFNL?=
 =?utf-8?B?Zmp6dHlPb1RmcVdQc0NzakxOZllvandibC80T2FQdm5qUWV6KzJNdVlvKzRl?=
 =?utf-8?B?VENTMlVvMjR6d1k3YVZOeUJVR0VFVnNJNmltbXRsbWU0SU5KNUswbDhBQzg1?=
 =?utf-8?B?eXBaTXVIWEdkejEyZ2dTME1oVU1ndDh3SHE5MUVzV3laNmtiRnB2UHhSU3JW?=
 =?utf-8?B?MkhXMldRekFGWDFiN3M4Ukd1NFVLSWZjVXVNUkdvOEVPVGhSd0NMMGxZNU02?=
 =?utf-8?B?STJHMXdFRldvZHZmM1dFNjNRdkRma0JaVEJ0WVRSVjl0ZDFqd0dwMWUzUFVE?=
 =?utf-8?B?R21qR055Y3RNVWRpd2E1d0wza0xzV1ZESXFvK0lxRDVvQk0ydlI4WWJMcXRm?=
 =?utf-8?B?ZjdtNy9JekdSblNDUUdKblpySCtienVaelBmVGNjOHV1N1Z1Uk1XNHFJS2Ri?=
 =?utf-8?B?Y1JkL2twVDlTSTRPTUdHakdpdGNpemNaQXhYWXVMS3U3OHVEa3RGd1hCWTJx?=
 =?utf-8?B?WGxlbDBzTHdDSkJ3SVUyTm5LVFEvOEdJK3htSHpGZFhSUDBRd29YbFlMTDRk?=
 =?utf-8?B?Tm1idlE4S2RzUUUrWjErcW0reHRLZXB6a0RvRGZTTDNodzBCK2hZalE1RlMw?=
 =?utf-8?B?aUREdHFqZEVsMllsVWZ3UjZ3R0xXb2luZzVIeUJaWUxURnliWm5VUUlmbjhn?=
 =?utf-8?B?YVJnQWRCbExnbmtSR2M3by94T01qTGs1SURIMUNxZ3lqUnhVYlh6aEtxWDhP?=
 =?utf-8?B?R1NlSkNJWEdpV1ZrWnRIQ1RqV1FJUFV3ZUo3WDFWVlJreE5oYzdvVSt0NS8v?=
 =?utf-8?B?WnJsRjh3K0psYW92U20xQkVwUEhXbHMwZDEyS1lnc0d5djlDK3pvTU1ka0Vn?=
 =?utf-8?B?RlJzdGhTZTRVM1duVlFoQ0FZa0QwTU5MUGZ2SEM5aEVYa3dHYzJlRUFIbVJE?=
 =?utf-8?B?dEhuWkZUaHp5M04vUXdLT1BSMVJ5aHZ2b2VqaTFBNmY3RXEwU0s4cDV3NkU0?=
 =?utf-8?B?MitEMjczNGxrSHZVeURHZ1ZEZzdQem9mWUpGcWtlc1djTDhpdW13R3VXL2VM?=
 =?utf-8?B?bHI2dFk4S0FYRDJJZElGSEJPeEk5ak1NNUFaMGFiU0xHK216K0s5TmpSVXpQ?=
 =?utf-8?B?RHlOeGJSZEM5TlNzSW95WGJZT0wrZXlLcTd1U0FwNzdZYjlLSVkvYzhlU1NG?=
 =?utf-8?B?VU9pTWFRWWVnc2E1TkdKKzdWNVYyWk5Db3htK0p1a2MzMUNQRGdsZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e77c37bd-3a33-4915-e633-08de786486ec
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:49.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPQFnWM5kGBYcTkTOmMkfiiY1y4PCxA2tn2Raskby7FR7SDB5c/orqsjTl8RZnlMoovC+1lg9tWf0iO8Byj5v+7fZCS66suxz2T5g/MyRLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1788
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 plugins/api.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 85b34949cb..0c348a789b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
     for (int i = 0; i < gdbstub_regs->len; i++) {
         GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
         qemu_plugin_reg_descriptor desc;
+        gint plugin_ro_bit = 0;
 
         /* skip "un-named" regs */
         if (!grd->name) {
@@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.is_readonly = false;
         if (g_strcmp0(desc.name, pc_str) == 0
@@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, rpc_str) == 0
            ) {
             desc.is_readonly = true;
+            plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -475,13 +477,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    /* Read-only property is encoded in least significant bit */
+    g_assert((GPOINTER_TO_INT(reg) & 1) == 0);
+
     if (buf->len == 0 ||
         (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
-- 
2.53.0

