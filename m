Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1676BC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9leG-0002QF-5I; Tue, 29 Apr 2025 10:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leD-0002CF-Nb
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leB-0006P0-U2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso4003758f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935758; x=1746540558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1RXK9TNZCyuKZFLBANjjuVrJLcCqvX//mQ8ZqVm0L0=;
 b=dydThUFYkRoJ5BnwDxTmJW4NgYqNaZ9RvtGaNLVIjXKKKzmunDf6ykEwfk+nYRlYTF
 pF6CtjahKPspfE07J9Y1cpY445J3ks9KIY3z4vA70HtBkHB/9QpobzAC+pQmZQz7/TaB
 mtqAHiE8M1SQtn95xpUxObvDQ4+75ILaQMOEdBXMSR4W0AwacPFGefBSmGLTvRJ/xICa
 fiC06jOrD+xqsioV1s6vNHaP6b8TSeyjDjHgBVxHSCiC3xteRSVco3NGVf1nN8P84wx7
 VPpLwwRPc6NjevlYj1/zcemHrpk1BSBv1hQZCrYT7zD1KwcfV38dOmQji1aTASkT13jJ
 O/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935758; x=1746540558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1RXK9TNZCyuKZFLBANjjuVrJLcCqvX//mQ8ZqVm0L0=;
 b=O0OVAS1DFXWPHqW2dbjTbIGHRDWqKnQxjmpJp/KF6gsbIscKItyxLfRaWNBHghbtTV
 t8SZYexXdB6/OXkT2XQf5W4X22UbI/xm/yJCGDr4/Ws6eK60tSFuqleSM0REFogx5szv
 E7A6ifzDE2kd6gflmWKNzGOtLE/Q9wCXn3AV/oVOnU0/AcoMKBAh1h2IKoCSrR9XSM8x
 GOYbp/hD3T1iFPQp5oMgPyotClWFv1Zhj11qYZOm0N7feiBLmlPBWTvTuS2c6ViPY7mB
 ielH3S/nvWNlSEIPbkdb9jiRVWFrW/e1SRiQgC43EOPTMpQvq+SZ+cDV1II86P4GjY3+
 XX4Q==
X-Gm-Message-State: AOJu0Yxiy0zwHQtVyFJd9YVVv5QiqFX3/jMfDUiN88XfGfToO+i7IOQL
 HTkuud62so5B084AM+PJNupjmqE1oa6vTWfbXqVCVVFc77mujmeuFGQx/nnSFFb4SASerCH3de7
 B
X-Gm-Gg: ASbGncv2jpDES0VggDf0SHnCqf0thkjUYXth7+fEaITxkFzlkjZ85fuoKonl0C5bgsB
 z6VcT2JkEshrWKROlN6EWXhymLWU6gLcI9NXipAM7lhF4+VZsenZlHKhabXHIZAMoE5MaJZSCfS
 LCfXBvbKPBlGfuWHGOEoHQSb3hHLAKZ7BhvAka6d9XcQrFk7rucDADTQhDyDrW7NlbOsMs1MKlf
 IwBB7AMVmv/QxDGfwNiCv6ifCZ78EQ0AIJB82tbdTVScf+WtX1rYV24+gVbBUHVbF/fo3YxJl8R
 jFMB5Ix/qlji0mPr8ZxTTrs8sDu6mcaTSCwBmn/S2BEBcDi03Twkb/4OcEJ+J5fou8pp+LrS1WR
 O5VAeW/+wGMLcZNJCNili
X-Google-Smtp-Source: AGHT+IHCB/jsYj3zwxBSGfvWFjGGiB+yG+BgwkFu/QQVgyRUHGUfaeCCWzLOgyEHFtklX/ddXYH2Kg==
X-Received: by 2002:a5d:64c6:0:b0:3a0:80dd:16d5 with SMTP id
 ffacd0b85a97d-3a080dd1760mr8316018f8f.55.1745935758033; 
 Tue, 29 Apr 2025 07:09:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4698csm14136643f8f.62.2025.04.29.07.09.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 10/19] hw/i386/x86: Remove X86MachineClass::save_tsc_khz
 field
Date: Tue, 29 Apr 2025 16:08:16 +0200
Message-ID: <20250429140825.25964-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The X86MachineClass::save_tsc_khz boolean was only used
by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
removed. Remove it and simplify tsc_khz_needed().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/x86.h | 5 -----
 hw/i386/x86.c         | 1 -
 target/i386/machine.c | 5 ++---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 258b1343a16..fc460b82f82 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -27,13 +27,8 @@
 #include "qom/object.h"
 
 struct X86MachineClass {
-    /*< private >*/
     MachineClass parent;
 
-    /*< public >*/
-
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
     /* CPU and apic information: */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e2d04092992..f80533df1c5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,6 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6cb561c6322..dd2dac1d443 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1060,9 +1060,8 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
-    return env->tsc_khz && x86mc->save_tsc_khz;
+
+    return env->tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
2.47.1


