Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB7F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgM-0001fI-LV; Mon, 13 Apr 2026 20:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfx-0001NE-HA
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfw-0002ym-0t
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4888375f735so48719395e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126642; x=1776731442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E+v9dwQEh1rdTkmhs/D+nnUCn7aDH8mDMozjNzzNdU=;
 b=bAbAZTNBekyEvSOdGpuBaH00Q05n0AQgoRktJNF/0PdyxEWkyPLsgckEkPqfbukV2O
 YOBUU7VRJgSiq2AcU8gZVrLPHwENs9f2ZLAYO28UnHeDYaizWgRJTTyZUrDYbQ4Og+qB
 bYhIp9JjJ61lL+aHuj1vMJdtHt8fwFOajcayvMt/18GuH7iXs8ob0sXrijtt1EQ9q9TV
 aaTnpqVgE6VpGze7D0nGElb/fjz2CIJx8R/66KZBYsYdsCUPi04g4Nm3R/sDLOm+EaFW
 lxErPf8jHISqzHQJ8OU2OE2jwDcZwpOIHG9fczQ0m0eHz3QuDQJ/hl/wmuF2Fnz8CsLt
 Zrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126642; x=1776731442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+E+v9dwQEh1rdTkmhs/D+nnUCn7aDH8mDMozjNzzNdU=;
 b=VXZuzlvrVLwZ4RzqqlpjY1/eTn7ww2vQ7j0+mV7fvyz4MaixjKPxAD2SfHWfqgf3vm
 DtQzVodK4yLHY92EexngqyxQWAKRbIjd4L2fOU3Dj54tGtsgTtPhvBCZayFKrebY7mRO
 xNrBIYUxYTNmgBB92SBvLndjcvuK10/uY1zix/cNbxnk/7k6EpWdelooE1gRk8Mx53kJ
 esVraOZV9YhSatMTYClrgn/fKSnEH74DCVysRD3ZQ90mW/8hJdXqZaRpgU2LuAcvlITd
 OCC/f7uG+e3HIltdxVpWx/zo9Es+lMvWJX2XMkiDdTW+nasqGenx9tLMmFAUq+PlIKnc
 Bo4Q==
X-Gm-Message-State: AOJu0YznagFttWbDaAtARYCYqQEp3PdNVhB4dF8zdFMYHH0koekindYu
 Hv9tVozgdzy8UcXIxvUb3Zo+YKMzmYL/Scy2rq0ozVdJgh0CBIqbZHTZaVZJGKSVqL+9GWYq+nk
 UjTetDbU=
X-Gm-Gg: AeBDiev0xNiOkneCfPUyweKst3GQV0NjC4tGV/OdiIK0mor/Ik8J6BcrRU+S+HDk0HY
 usjXoPc9HL2kYWusCLiSDxckQDepE68923U4qgmOse8rVMzndKnoZpIWm1Z2cYE6p9w2xIvJTg4
 KZSKXgE2yljxjpcplNfVs1eXddgd/6GoXBl0nTyXNKzNYBfj676NQB7wxAvLWa8EM1Tsy9EjuXf
 NeCPKC2HktyQF3GQkMH6xspLPtwCin3s35wWnp14SlubraZnT1UTljI5byD3w7PKoFga34T2mVO
 QBhAxWes4pdpKM/dIo5gOILgDZrQLnq/5jqBCHEd+i6YTUmhIFco28rebaz9Rsm2gRJW/z1nGeN
 c6azHIzcHta+U3rt2tBvqApnro5sPefFr2r/Lir2Vwe2Ed0JHjONxQ4JhXk1SRed5/dA+UhcYhT
 C0LsnCNVQVwrXog+tzWQt4K2qbBDSFGabOglTBaD3kQ9fF9PYKE0Kp36CEv5OaCFcQtngcVnPV
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488d686892emr184339135e9.25.1776126642217; 
 Mon, 13 Apr 2026 17:30:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ec77508csm33651015e9.0.2026.04.13.17.30.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 05/27] monitor: Make Xen emulation commands generic ones
Date: Tue, 14 Apr 2026 02:29:37 +0200
Message-ID: <20260414003001.97571-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In order to build hmp-commands.hx once we need to stop using
device target-specific check. Use the generic pattern to make
the command available on all targets, providing a stub with
kind error message when the feature is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
 hmp-commands.hx         |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index ce73119ee7a..bf6ac28bef4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -37,3 +39,13 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
+
+void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
+
+void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12d..06d7b17bf25 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1839,7 +1839,6 @@ SRST
 ERST
 #endif
 
-#if defined(CONFIG_XEN_EMU)
     {
         .name       = "xen-event-inject",
         .args_type  = "port:i",
@@ -1866,4 +1865,3 @@ SRST
 ``xen-event-list``
   List event channels in the guest
 ERST
-#endif
-- 
2.53.0


