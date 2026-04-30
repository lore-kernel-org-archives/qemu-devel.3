Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A6CD13DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7q-00006L-S9; Thu, 30 Apr 2026 13:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7b-0006RX-F4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7Y-0004pX-ET
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4p09g84rCH9VSSo/bhKgqd1+fyIRUsMZGOtiz48LdA=;
 b=FEVn8C4GFUE2/aqLBo2pFCtO+nxUMGnq1S2r6LmiBd6OWvFeKHriz3vjANOLvLN/7zjNzp
 QXV27cefCrmCOr7b4XdEEdccygWvZdUr9+HNk/2Xe+Bn/vVkkUmoNFwFr8fOhAa6vsYeXQ
 lnb/G8MN6x35mBMgE59bPRl/ump7rqY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-6SI5A_JxPseqQYLNczzsmw-1; Thu, 30 Apr 2026 13:24:13 -0400
X-MC-Unique: 6SI5A_JxPseqQYLNczzsmw-1
X-Mimecast-MFC-AGG-ID: 6SI5A_JxPseqQYLNczzsmw_1777569852
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50ff0bef198so27006201cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569852; x=1778174652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4p09g84rCH9VSSo/bhKgqd1+fyIRUsMZGOtiz48LdA=;
 b=RC5XjafuIkBg3u4Liufc6Zw4zcvTUNOWuqnxOIp2SvPjz3bjavWa5LzXgjFiGsreJX
 PlPGh+yj2I6M/Rbt0ZHcbgzH92h0Q4uLR13s6YtykQEpLJIRMryJQpTUdnfZlva1Yqx9
 1KmbxtSZtFPz7GgpPTzlBfBUtbbF138XEXYHwKWY3xJBhQjqKDRLZmBvHuCISpj+748s
 u/Vcnymkz9+CCC+cuElqjl/OKTcK0M/VZgNuBF/ChaCO1Cajx8c/3CSshiGR7yTQvjFu
 rahqF358YI0kSZqmJ8h1G+zKOzH/4BHDw4KGReI7qpsxYeklHS7dBIF6brXmAexlh6OX
 rAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569852; x=1778174652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4p09g84rCH9VSSo/bhKgqd1+fyIRUsMZGOtiz48LdA=;
 b=ZpIpKVmjL3/9Zf+oSmuS/4T5ARyOk1T8a4rQun+o8E5yjhgm5/v1CsWOuv2QJoNHXo
 5EnzAEM8C1juNgpMK2yc11CO3sER/vYgjF//OpKYAI+ATnpcmvJd1z982Dlj6XsJ0IIO
 vFQHuzseGw89/iPCz9iWxEGpizrtiJL22O5hgE88cPP8z6d8cXYPmTRgEqjdgLA+cxb/
 9UICog1BQcZLqnzW4e7iS6Zk+ew8ts5LoiPmudr4MZ9tu+OnRhpMwR1vUZSc2eNFztZj
 HWSYR1Hqv4f4jla4wv9VPzLPPMYMiDVYWHxXur+u6VkJxuI/PF1+Y7cNvWjR/TZGfI9k
 /sNw==
X-Gm-Message-State: AOJu0Yz6Cwp6wPRH5TgH6rsy8lLpTej9U/7FvbVjpJCcS5UGOyoB5kWp
 m4domvxjr4iylxokgVoKPeeapui88rM183Y+Aunz/zvC2NJj6TZDA4Rv6l0DYeGISJFRbU2k2Cn
 VOzOCW/8YHghmb3DVx6EmEPerfvpegLyoz2yflUU09b5Wde8hESBVtIdGmavMMwzp5X60upQtk8
 9nFLsJJ65JCeEZRkRWmg8xJwdZXdpMUU8lNY5QO2/U
X-Gm-Gg: AeBDievHQOGmtKBV1lJXPtyw4y06SQf53oIL69OWQhm3DVKNbIk07Vr4RUK5Zx1nZv2
 wNjRpuckZD11GSBk7H2/53smSYS6TBn9s7bEYbcTtJTh2kzMlXFcLlnBrMuOzUOl5PkdALXmbQ0
 ccZbYSYRcyMfbeX4G3pnC0Si11PnHjte7K+zpF2JkOcf2/rkVF09Tz971eE3Dj88TSmJJ25/VOJ
 kWQkgUwLOX8QQQWs1H3Ki9gW6HcyQUzjjw6/isvQ61Ox8Q/vc0ZReEC4TD6qDk2JDv+W0wErJfy
 zOnb+Kvv6EwA4wXUrnpQrvkMCZUPCECTWjJHADegRDNCSaMooB+7kqgsRYM4SHtDlCcTEFdAOhi
 jh3xa3OrXwLWKXzsBlpA5DuhE2JUbr5cuiTWrQfJJ/HkTWa9Ax8BNfyQtHb9HRbzobWXCu3Bi2I
 8mR3iZyWR4rBB7LifropABh6JmeEE0cbqSpos=
X-Received: by 2002:a05:622a:1ccf:b0:50e:601a:217f with SMTP id
 d75a77b69052e-5102ad9b124mr54357981cf.25.1777569851892; 
 Thu, 30 Apr 2026 10:24:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccf:b0:50e:601a:217f with SMTP id
 d75a77b69052e-5102ad9b124mr54357191cf.25.1777569851308; 
 Thu, 30 Apr 2026 10:24:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d34e647sm214611cf.31.2026.04.30.10.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 40/58] whpx: i386: unknown MSR configurability
Date: Thu, 30 Apr 2026 19:21:46 +0200
Message-ID: <20260430172204.1006673-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Add an option to inject back a GPF for unknown MSRs.

Keep it on by default for now as Linux expects accesses to some
AMD-specific MSRs to always succeed when on an AMD host.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-18-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-all.h      |  1 +
 include/system/whpx-internal.h |  1 +
 accel/whpx/whpx-common.c       |  3 +++
 target/arm/whpx/whpx-all.c     |  4 +++
 target/i386/whpx/whpx-all.c    | 45 ++++++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 2cbea71b149..4022571ffff 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -20,6 +20,7 @@ void whpx_translate_cpu_breakpoints(
     CPUState *cpu,
     int cpu_breakpoint_count);
 void whpx_arch_destroy_vcpu(CPUState *cpu);
+void whpx_arch_accel_class_init(ObjectClass *oc);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index cf782cf5f89..86639627b36 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,7 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool ignore_unknown_msr;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 59be996aefc..497c03138ec 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -538,6 +538,8 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "hyperv",
         "Configure Hyper-V enlightenments");
+
+    whpx_arch_accel_class_init(oc);
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -552,6 +554,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_required = false;
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
+    whpx->ignore_unknown_msr = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 4019a513aa7..94304a4230b 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -823,6 +823,10 @@ void whpx_cpu_instance_init(CPUState *cs)
 {
 }
 
+void whpx_arch_accel_class_init(ObjectClass *oc)
+{
+}
+
 int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9fc44f8a67e..eecc7f48ed9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2133,6 +2133,10 @@ int whpx_vcpu_run(CPUState *cpu)
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
+            if (!is_known_msr && !whpx->ignore_unknown_msr) {
+                x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+            }
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
@@ -2532,6 +2536,47 @@ void whpx_cpu_instance_init(CPUState *cs)
  * Partition support
  */
 
+static void whpx_set_unknown_msr(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->ignore_unknown_msr = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->ignore_unknown_msr = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->ignore_unknown_msr = true;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
+void whpx_arch_accel_class_init(ObjectClass *oc)
+{
+    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
+        NULL, whpx_set_unknown_msr,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ignore-unknown-msr",
+        "Configure unknown MSR behavior");
+}
+
 int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
-- 
2.54.0


