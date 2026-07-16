Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00A9C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSDE-0008LW-C1; Thu, 16 Jul 2026 15:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD4-0008IF-6R
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD2-0000Hc-0C
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:29 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJonbC3452877
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KKRRYIcs4Tt
 66pHFgJrptlI6dqEiDxQ9rUN2KePZGoQ=; b=OnJG8FfjclxQzsEnyGyvBehzW2B
 TQApWLtoTWDBIYQxlEAy1veP5753I2Y+soAAla9cClW0Q0LH5ffP8aL+ZPg5rXXn
 C+a3t/UGC8SFX8h5Wwr+bBaRwtp3KtVEc4AK3L5fIIbprttKejEipAZQekaZ98XL
 1NVJk2FkjQ7nd/FTmfKNmX1EfRw+iq1PQe06Zt7dAbfb4S5zofx1huVLULtyGjaK
 iv2/BYl2ftNHfK0gtHneVQBbCub2M4S3QpRWCRAUKYxu8L6mG+PQ/pxW8BVMYlxZ
 aia7ziqX3mL13BsYRy9I+K/Jwzs+aBATzWCX6PtoZuXbjBaYYPz1EWDXxvA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9h7fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38d7fcd1f66so10227350a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231846; x=1784836646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KKRRYIcs4Tt66pHFgJrptlI6dqEiDxQ9rUN2KePZGoQ=;
 b=QT3csInCF28sEulHHdnNYZnlshCt2VmU/jVetCSLlYRD2nyJQzKoh65PynqiE8mjlU
 1CMGyCnDbQnf6VDKW2Kjhtg8RiF5OQKWlPPlFYGoJe8L+zuS57w/JaMk0MB1ZR2TytLT
 UKTfWF7/TeZIivgsGBKKKIGTAZEz6q4gxO4m4YUbgLPc2wmmZw/rDPpbIrk2WE/xU/3s
 fXgl5Mx+SInTFrKEkWozVLe8loukGfw6J2W8cPhIfvz/yFBsy21cBnxKDaAWL0urbPL+
 CGxh9zAi3mIcDtwcT2H4fJMkMfXGde0RLPpaYavd6qrhu88x5YJUKlqSx7RFzz8C9WJf
 fiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231846; x=1784836646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KKRRYIcs4Tt66pHFgJrptlI6dqEiDxQ9rUN2KePZGoQ=;
 b=Vb8orUe5+zHvZs3Roa8scAPd9Qyvc269SpdIKnboPqC9EgWgFssNAZBxn1FU1T4cby
 taRamXZDBjsUIReP1HxaZB+ycRok1Enz+ttHxLjY4q/wKTIPndBde/deVVmnKZWQRcFh
 er9q0/TJNU76AjY2T81mTE2c5Wv2BTC1PfKkN98tMpNLKRAbyRJCAwQdcm7qjx5rv0U5
 oO53sihKQy4xQ+SJs1tGhgAeG26a3+Qb2RpJWBU02nx6UoSO1Qv19cOiEf90iFiMN0FV
 iH9f3Vghn+6rwoUci3ivxjKnr7Gsik4UIFcr7D+F2fdjTidkqJud2EHLCSA+M3mQfHz3
 fZFw==
X-Gm-Message-State: AOJu0YxRUUy9y8qPGvAiUq8b+XGRVBtOga89Ipv8Qf3GNapTaY6Sq/vI
 SldbqTdDptzhiaED4fNW9f5gOUoK6RwIakd5BVVPUyMIOd7+3gH1gOavoZIVzuEV0bGJiOoodDv
 NwNjA4wWDAiL3jMHC9khbRkx9rrSklDVFxk6EuTKBww9Pa8hsqD5LNYTKWeiQwkkLsA==
X-Gm-Gg: AfdE7ckEynFQrMpDHpr4xEBhgMFhNAho2T4USBSLT17gPRRuxF80xgsUsgI7QnSJKY2
 /4YMXGtqtMP6/rdLAgY36aDurqaLFcOZw524L3S61eERG28Mj6nJ28YBeRI3d0/QuABzxvMC3YP
 XyCMB9Hf+ZhpXd+vXRZQW1J5vBrLzmsEV7ObUQcwvgba9Yi4QKpVT2+U89gJrfUIje5lpIxi7+i
 RBbodf08dQHd65cnWRrEjXdb14NTETbmqhT6jKkG+Q/PuSUlgRsYSn4nDandOfRCwNtyC/5p/ys
 gYbVaNwv4G61CzTJfdv7jhsXm6y5WvhlcywVxE7f4ykbHNvC+hGA9Gt5VmZjiZ6Ou0cGcsY+Y3Q
 7atkaWjpXClRspxRIvv8ag3dDOK83fKR8vJ1UQu+qN8eeU9mch4YQahZ+AjYxFgfWkWG/lZQ=
X-Received: by 2002:a17:90b:4f91:b0:381:270c:4dd1 with SMTP id
 98e67ed59e1d1-38e1af1336emr12012208a91.20.1784231845549; 
 Thu, 16 Jul 2026 12:57:25 -0700 (PDT)
X-Received: by 2002:a17:90b:4f91:b0:381:270c:4dd1 with SMTP id
 98e67ed59e1d1-38e1af1336emr12012179a91.20.1784231845023; 
 Thu, 16 Jul 2026 12:57:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6a5174sm14494672eec.15.2026.07.16.12.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:57:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
Date: Thu, 16 Jul 2026 12:57:14 -0700
Message-ID: <20260716195715.3218862-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716195715.3218862-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260716195715.3218862-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a5937a6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=OZcmDFxvAAAA:8 a=EUspDBNiAAAA:8 a=rbnd9Ml30cmRLrCZr6QA:9 a=O8hF6Hzn-FEA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfXyjbvRj3y+Exq
 2LAzL5d9vAFh33Uj78Bxhe4BxKM4lxPdizdxOGYfvEJl8n2cCFJY5mxd2MmlCLaQ40NYN/oYzh7
 RPQ+ONhW7tAlopxQualuObNpSwRqtYW2G7n1Ufw8Yvqxa6vRdl0gc9aiuQjtu0h7XE0fC8WPKcE
 Z4uBGkHzt2YKGZ+Qkgnud7/NUIBmKcMOiKl9z9E0CSrgUzC4qzU/LX8vIW3kgPdvTKqKN26nXDP
 s1czEKKJ4rw4XexIuZN7UbxNwqumv5tgT/e+0gryG+AdbOaf2OUy1+W8KqzWLB8mGIh+cm9o84+
 iIfRcj4impe9WCH+QYNotEQjsyppnczzSgOZgyzedM8jFIxFCHw1q7yQi+nCIzPasRf2/Kve9b6
 V3iU2u5XlyjUID5pV5E7t/CzqeRt9bH9EyetcGkqu55Er6rs5iZjY6hLufyo+h3RfvnP+zeYKx9
 ujzEg6UB1BjOC3U2wQA==
X-Proofpoint-GUID: M-GW0k1iG62Mr71hiIz1f8OJTD4A2ZZ1
X-Proofpoint-ORIG-GUID: M-GW0k1iG62Mr71hiIz1f8OJTD4A2ZZ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfX+mwxmmVPArN7
 bQEX/XMswCeV4lAhJTXFgBaTfd7sJYTZdu0nU7/HYgbHIsrAN0Tjkh08jCloOpPRKISXKxMFbVd
 a32ECCF9yqw2fCU+eKjx09EUHRSpMGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Harry van Haaren <harry.vanhaaren@openchip.com>

The existing code in execlog was never upgraded to the Scoreboard
API, resulting in a bespoke implementation of per-vCPU datastructure
handling. This had some race-conditions, and causes segfaults with
a simple multi-threaded program and two instances of execlog running.

The patch here refactors the custom GArray and GRWLock code away, and
uses the scoreboard APIs like the other plugins. This solves the
"printing while expanding" race-condition of two plugins with multiple
threads in the guest, and hence fixes a segfault.

Output remains atomic per instruction by building the full line
(including the trailing newline) in the per-vCPU GString before making
a single qemu_plugin_outs() call, relying on QEMU's own log locking
rather than an additional mutex.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
Link: https://lore.kernel.org/qemu-devel/20260716094126.787556-2-harry.vanhaaren@openchip.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/execlog.c | 68 +++++++++++++--------------------------
 1 file changed, 23 insertions(+), 45 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 74325495cce..dfe00bf836c 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -31,8 +31,12 @@ typedef struct CPU {
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static GArray *cpus;
-static GRWLock expand_array_lock;
+/*
+ * Per-vCPU state stored in a qemu_plugin_scoreboard. The scoreboard manages
+ * per-vCPU storage automatically, eliminating the need for manual array
+ * growth, locks, or pointer-stability workarounds.
+ */
+static struct qemu_plugin_scoreboard *cpus;
 
 static GPtrArray *imatches;
 static GArray *amatches;
@@ -41,23 +45,13 @@ static bool disas_assist;
 static GMutex add_reg_name_lock;
 static GPtrArray *all_reg_names;
 
-static CPU *get_cpu(int vcpu_index)
-{
-    CPU *c;
-    g_rw_lock_reader_lock(&expand_array_lock);
-    c = &g_array_index(cpus, CPU, vcpu_index);
-    g_rw_lock_reader_unlock(&expand_array_lock);
-
-    return c;
-}
-
 /**
  * Add memory read or write information to current instruction log
  */
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
                      uint64_t vaddr, void *udata)
 {
-    CPU *c = get_cpu(cpu_index);
+    CPU *c = qemu_plugin_scoreboard_find(cpus, cpu_index);
     GString *s = c->last_exec;
 
     /* Find vCPU in array */
@@ -117,7 +111,7 @@ static void insn_check_regs(CPU *cpu)
 /* Log last instruction while checking registers */
 static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu = get_cpu(cpu_index);
+    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
 
     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
@@ -125,8 +119,8 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
             insn_check_regs(cpu);
         }
 
+        g_string_append_c(cpu->last_exec, '\n');
         qemu_plugin_outs(cpu->last_exec->str);
-        qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
@@ -138,7 +132,7 @@ static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
 /* Log last instruction while checking registers, ignore next */
 static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu = get_cpu(cpu_index);
+    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
 
     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
@@ -146,8 +140,8 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
             insn_check_regs(cpu);
         }
 
+        g_string_append_c(cpu->last_exec, '\n');
         qemu_plugin_outs(cpu->last_exec->str);
-        qemu_plugin_outs("\n");
     }
 
     /* reset */
@@ -157,12 +151,12 @@ static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
 /* Log last instruction without checking regs, setup next */
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
-    CPU *cpu = get_cpu(cpu_index);
+    CPU *cpu = qemu_plugin_scoreboard_find(cpus, cpu_index);
 
     /* Print previous instruction in cache */
     if (cpu->last_exec->len) {
+        g_string_append_c(cpu->last_exec, '\n');
         qemu_plugin_outs(cpu->last_exec->str);
-        qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
@@ -378,40 +372,28 @@ static GPtrArray *registers_init(int vcpu_index)
  *   - last_exec tracking data
  *   - list of tracked registers
  *   - initial value of registers
- *
- * As we could have multiple threads trying to do this we need to
- * serialise the expansion under a lock.
  */
 static void vcpu_init(unsigned int vcpu_index, void *userdata)
 {
-    CPU *c;
-
-    g_rw_lock_writer_lock(&expand_array_lock);
-    if (vcpu_index >= cpus->len) {
-        g_array_set_size(cpus, vcpu_index + 1);
-    }
-    g_rw_lock_writer_unlock(&expand_array_lock);
-
-    c = get_cpu(vcpu_index);
+    CPU *c = qemu_plugin_scoreboard_find(cpus, vcpu_index);
     c->last_exec = g_string_new(NULL);
     c->registers = registers_init(vcpu_index);
 }
 
 /**
- * On plugin exit, print last instruction in cache
+ * On plugin exit, flush any remaining cached instructions and free state.
  */
 static void plugin_exit(void *p)
 {
-    guint i;
-    g_rw_lock_reader_lock(&expand_array_lock);
-    for (i = 0; i < cpus->len; i++) {
-        CPU *c = get_cpu(i);
-        if (c->last_exec && c->last_exec->str) {
+    int n = qemu_plugin_num_vcpus();
+    for (int i = 0; i < n; i++) {
+        CPU *c = qemu_plugin_scoreboard_find(cpus, i);
+        if (c->last_exec && c->last_exec->len) {
+            g_string_append_c(c->last_exec, '\n');
             qemu_plugin_outs(c->last_exec->str);
-            qemu_plugin_outs("\n");
         }
     }
-    g_rw_lock_reader_unlock(&expand_array_lock);
+    qemu_plugin_scoreboard_free(cpus);
 }
 
 /* Add a match to the array of matches */
@@ -452,12 +434,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
-    /*
-     * Initialize dynamic array to cache vCPU instruction. In user mode
-     * we don't know the size before emulation.
-     */
-    cpus = g_array_sized_new(true, true, sizeof(CPU),
-                             info->system_emulation ? info->system.max_vcpus : 1);
+    /* Initialize scoreboard to cache per-vCPU instruction state. */
+    cpus = qemu_plugin_scoreboard_new(sizeof(CPU));
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
-- 
2.47.3


