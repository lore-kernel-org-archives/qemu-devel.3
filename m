Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E928CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkY-0004Sk-FY; Tue, 16 Jun 2026 14:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkM-0004Nj-Py
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkK-0000Py-Rw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOtc1172554
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=T0AI/4ltV/M
 6IjIrD/1NDSeYjjzrkIVk8AXpazMal88=; b=fk55qJnxlZXpdjMLoRmbNOET0qE
 EA/nlLj9XffomxFBztYD4Mp/Dv1gHuBvyrCyrFiJVm6ZGtjBTF437cKbinWV7/+F
 p38fCGcirzJZXnUBnX/SqizM3tpwgKLBvMhY5d3SFg7jxZtYF6JCJcqX0+JRM5GD
 yNcvEnmih8LaJQAQa2tRLQ3igwOvoBWV8iL1VgzK+xSAwmvtcOXj/9bZ9EsKwQMd
 Ean3u6QdyOmUEltxwMW6MvFTU/pAougQmbMfBzt+3beFYUN/Z+KNN64y0IDNBQaq
 oC1LTP6RxGTymLtctktZWeSvmmtL8Pozb2Ga3tb9n2lWYvRT2d56cbp25kg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kbhwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84238e83851so3200243b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635366; x=1782240166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0AI/4ltV/M6IjIrD/1NDSeYjjzrkIVk8AXpazMal88=;
 b=eL7htVL07uL+3peS6brEk/zQSs7A95wlkKob+yhokPdjf+2ZHRVa1FxaI95TJwm22P
 bZrnF/0goaMBSBNcAdQ6pjvGGfDe7dLq7FLnxC3CYI8hrDMn/l3mgxYlCyZuPuegoMXn
 6d3aCr1i/E8fB/QmYjPneuVKUBwcmtfmIvOO+tDd7ax6HbnRoA2JoQ5cFxSeEi/lhzcQ
 44B+U6m0dQnyn6PbYXpS9wmVsXlpygJb4o5uAO960/8MiQyqxsSQ1LR2dVhNYFOUSQAT
 NN1g/QLE7YAWltVw2819OJYGMPT3Zpu7lPPAkxWE0JRxh9mRUKU4iFTAd5NKrYG0bzqP
 qX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635366; x=1782240166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T0AI/4ltV/M6IjIrD/1NDSeYjjzrkIVk8AXpazMal88=;
 b=eqGHcMYoZtFxG091JCGg7Frhl9JqbbSdvRydYhJEvTlrk5t9o/vrGXas5kqpjtwf0m
 n6eDxA3KxE+6h47su/3XEjPE4KaZ1CVplFvgjz4e3tWRZTVZvd4/b6fBNAPwp6Irnce6
 R7Ze+xoqNQCzkHAk0LTXhqhy9ZooF/t0jMRl4gJh8ZxepEFfB/C+syXzzhgqMt1QX99Z
 y5O91eQgs1SzCkqz6J/Lkapo04HnHx7uYvrkyQmJi8FvPzEFek6NPF5TORwFPras8IMq
 eBDxR60Bsa384WWcqVcTffhaSV5gQge3d6OLGE+KHmKXobbefOkuhjnXJdk5omS8jIWg
 +5yw==
X-Gm-Message-State: AOJu0YwWqdX6tKlzxwYGknARNo7h8kLzT3DtRaYnuWL50QN/SLJgu4xe
 HfEZPrM9N+cYFTckJHi0yQTnRW0QkQogQNn99z04L568aWMr9b/StgRdkxwoXe4v5NKkX4Y1sl2
 CURqGlohFhZmBGG1mNFT36TL3jseKJqJbs1AoVoN5fumSQzDoLjJU6FnoTflhB/tc/Nvw
X-Gm-Gg: Acq92OFgsf6krQkuuc9peOSupKZiSiIx9NUlZil7G61r79tFXxqxuL6+16vmqMLHqr3
 KJOWjzBD49wRRxPKh1K2tNN34aGfgAiuraI0UFm8Ey/rckosu9Nq3X8m9LNRQl7il7nQet7ZLOY
 /oVVS/i365ebpju0KcYd5uiXSWRbm/fSN838W8H8Zz5cA+j/3ai8Wm/ZrqR+DAc4M66i0kh6+y0
 y1A3zSIk3r4034EH19NPKQIwh2yy8DU5ogN34632xJbNHhTQWSjnEue2PWL5QylX1MGB6Bh/Xun
 wE9aRtQbw0xMQaH82dWxgg/DDT8B93Rd/kZHOqeN9tRXS/yfEuOuzcIkdya0Jvp1M4oxsLi0MyD
 vhFSp/W1tdw59LVt72zLU+Bg+VKO86mHqhgWjUBeS+j1rUVP06oS/NAGa7wtGLO30BN1f11+FD3
 1qRKrH79Y=
X-Received: by 2002:a05:6a00:10d5:b0:842:4a39:6047 with SMTP id
 d2e1a72fcca58-84524550f44mr308178b3a.29.1781635365945; 
 Tue, 16 Jun 2026 11:42:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d5:b0:842:4a39:6047 with SMTP id
 d2e1a72fcca58-84524550f44mr308156b3a.29.1781635365505; 
 Tue, 16 Jun 2026 11:42:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/26] plugins: add userdata to
 qemu_plugin_register_vcpu_idle_cb
Date: Tue, 16 Jun 2026 11:42:13 -0700
Message-ID: <20260616184230.303038-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXzJuNH97PaVLL
 pIAU2WsoQsiFNbsnoVtJem47nQ/48P2HvrroNQ7sWXXeavMlv7u9Hf6d09tUIQQGFN82kmyKCvl
 CHeMeSWE6LfId/stv00E88sSrgZt7jU=
X-Proofpoint-GUID: janmbJGbl_7rQLBbx2WolZXfJ6W13rhu
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a319926 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Kyn2b3o906tGi1FvqMoA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: janmbJGbl_7rQLBbx2WolZXfJ6W13rhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfXz8GLjlbzDS1E
 Uweu4uc/S+PetoQ/JBtSq7aPN1NUVDjgCdQQKe9tI275naSZ6eQ/Gdp+Kd932FKSW8lzP/bDGOt
 y/4nx7K1RFpB5e4ZIb9hcG/itZ9W2D4/NwwD0oQEWlSzd25l9aVrOdTdo5k41bjWSbTQ/5k29eh
 9XYU6k/bjqf7yq1pUMK2UemfuRlp16RnwGOPJ0TAxLXlF7g57CzPnxl3KL42oK8dgQOwOF1gda1
 mgMdS0mlNxf0XAx78NAobmleplL/Ybxe6zrQRrHqL+z95Anbz4v4Zyh+eSSal/gtbvcrdyKocWf
 53OasJukFSmEMjJijb2CC8lJyLjSG1DmrJhXotKbdkkaYF3nAfG5D98+PeQNmfFmIkMxmDpWCbV
 lvKZvlqTpfOKUIKcq1duAM/uVsxXOsuRDyvvd0wOrfFRXyk9ec1VqN6IYqzBxHLyNQN2oAsSay8
 yhGeO6XhAQg0bhEyrWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-10-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/core.c                | 9 +++++----
 tests/tcg/plugins/bb.c        | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d4f8a99027e..75d2a69a3bd 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -272,12 +272,14 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU idles.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
diff --git a/plugins/core.c b/plugins/core.c
index c7dda9b2ff1..47244603786 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -114,6 +113,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
@@ -627,7 +627,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -660,9 +660,10 @@ void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index f29b466dab2..ba605246eb0 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
     qemu_plugin_scoreboard_free(counts);
 }
 
-static void vcpu_idle(unsigned int cpu_index)
+static void vcpu_idle(unsigned int cpu_index, void *userdata)
 {
     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
@@ -124,7 +124,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         counts, CPUCount, insn_count);
 
     if (idle_report) {
-        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-- 
2.47.3


