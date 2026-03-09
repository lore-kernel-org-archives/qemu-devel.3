Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9616EEFCD73
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXGz-0005mX-LM; Mon, 09 Mar 2026 05:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXGw-0005mE-Tr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:51:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXGu-0000Zp-QC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:51:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48374014a77so136003355e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773049891; x=1773654691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FSiI47q1uS6LXlyXsoFn8BGOPs2Ve688o13OIyq7I1Y=;
 b=Gbigss8sjfCe0HyVFIUHpVmY3M8IwJzvzC6MQJzCGGA6SYo1L8wOyOJTblGxignPZQ
 JtF/hJiNgmM6abPCrUQqtCzR7C8LMqC2cRGjxwk72PxYLVWJJsf3KkTT7HGwzdtZq7DV
 2j3iMro6OYK9MER7WcV2+IxLjMCYmbiiNhsN2Dn7K2o+vFLdnH9I9qru9Smvv0tOc6cM
 ES/TMME1PGnhCUcTtvQmaQFTTyrA2aK2agyh6aa4JuC2R7xSUI54+5fwQmfx/Q8qWbOu
 iTPR4U7mZ94bJr9JtUn2ZkkBzSmv2wnd+2lNy/GoncMucEa/qAUBIAJWxRDxRyV9qAxz
 w7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049891; x=1773654691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSiI47q1uS6LXlyXsoFn8BGOPs2Ve688o13OIyq7I1Y=;
 b=ULNh+TMlQ8xrg/P3IsE3tfE0EwUBAarTv1ePWeWCcBtTSJf0BAouZBX56l4rNFVi5G
 LpRJSyHvqR9Xxdaba5XjTnO7POQzvU+ZwyKROSawGdKg5cOONFpv/DhkeBXlT18+5IuO
 VBD6ayp3nImGhulHs9NHoCMqiOEtPkQUuW/IHQONdiEvBSPOPV3TH73vy9T/RGWFnaOo
 ziweetb8mb/bMQ05msNMukJNLcVw8SQO+iCnZuVOG0DFZl94hglUD6Ee5KSgpTd1cSaN
 uU8yTkxTCuLO6+o6Kuu2nyWBiyNwNenD3JO4AWgKqF62UBWLr5DaQgNbljj4Rq7Srokf
 zp2A==
X-Gm-Message-State: AOJu0YxBcnDoYXP0tkr+divneJAIeIaOvtm2HvL/WGeIlWSpcuEDc/mT
 u2shOEQwpL2ESfhC9+dOSXzcZ7RYnSoVBhgRy7gK1nqKnUUyv4zz+gnuFnNK+gEWpYSVK4YCngm
 oDQ8k
X-Gm-Gg: ATEYQzzoQLuXqkrY9arnU4aEBq318UrfDHLl83Tq3r7eqvhU14ePWjKYYSuMXoSx2eB
 WPu59w0oc7/jxBKAnvMVCyvz5TVkWmiLYFabVlVvWAMwhbyb7D2KNXBWgdfKOYLZpn9af4UVaUI
 VNOjQ3p9UZtA5lCItKWRhsduw8dSsFvm17+a6zXzIKDuiijMlSkufFw/U/sLCqfdVkiw8ZihC6F
 eyE+SJn54iegmmEaOnrKKzIzPkIfGDQ4ZKNQdMFSKHqqLgf/dvy9FBZ+UK6UTHeYTyqxqPtsAyT
 dcTQxA31IC1kTGiIzmuJadbeK6e1J4QK3BbPSVvNZr/P8n/eMAz2JoDU0kxaEmBq7NuwtzynHxi
 9vyHW8GMnaq3xjz12y2nRAozArZqQG5V3BAFMLOVhpeTdeKncOdqT9ZVgyKF+I9DeajFVbGNyEz
 PsMYPLGUmrbkzkV/BweGWcGE+FK/gz7jOLQlPSsRJ8+xboROOmdZ7JE3e0L03znU0kqvR1GV6Iq
 6cEFq/+swrCKzr0c4/9TNbArsKv1PnVO4PM4+lRJg==
X-Received: by 2002:a05:600c:8b58:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-4852695af23mr184477065e9.17.1773049890852; 
 Mon, 09 Mar 2026 02:51:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852381c61csm85136235e9.11.2026.03.09.02.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 02:51:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Subject: [PATCH] hw/misc/sifive_e_aon: Don't leak timer
Date: Mon,  9 Mar 2026 09:51:29 +0000
Message-ID: <20260309095129.1406506-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The sifive_e_aon watchdog creates a timer with timer_new_ns() in its
instance_init method, but does not free it in instance_finalize.
This means that QMP introspection of the device leaks it:

Direct leak of 48 byte in 1 object allocated from:
    #0  in calloc
    #1  in g_malloc0
    #2  in timer_new_full /home/pm215/qemu/include/qemu/timer.h:520:21
    #3  in timer_new /home/pm215/qemu/include/qemu/timer.h:543:12
    #4  in timer_new_ns /home/pm215/qemu/include/qemu/timer.h:563:12
    #5  in sifive_e_aon_init /home/pm215/qemu/build/san/../../hw/misc/sifive_e_aon.c:286:21
    #6  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #7  in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
    #8  in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
    #9  in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
    #10  in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
    #11  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #12  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #13  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

Allocating a separate QEMUTimer with timer_new() is not the preferred
interface (per the comments in include/qemu/timer.h); switch to an
inline struct initialized with timer_init(), which we can clean up
with timer_del() in finalize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Incidentally I notice that this device doesn't have vmstate support,
which is unfortunate -- devices really ought to either support it
or else install a migration-blocker explaining why they can't.

 hw/misc/sifive_e_aon.c         | 16 ++++++++++++----
 include/hw/misc/sifive_e_aon.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
index 0e82ae3758..e78f4f5672 100644
--- a/hw/misc/sifive_e_aon.c
+++ b/hw/misc/sifive_e_aon.c
@@ -94,9 +94,9 @@ static void sifive_e_aon_wdt_update_state(SiFiveEAONState *r)
         next += muldiv64((r->wdogcmp0 - wdogs) <<
                          FIELD_EX32(r->wdogcfg, AON_WDT_WDOGCFG, SCALE),
                          NANOSECONDS_PER_SECOND, r->wdogclk_freq);
-        timer_mod(r->wdog_timer, next);
+        timer_mod(&r->wdog_timer, next);
     } else {
-        timer_mod(r->wdog_timer, INT64_MAX);
+        timer_mod(&r->wdog_timer, INT64_MAX);
     }
 }
 
@@ -283,12 +283,19 @@ static void sifive_e_aon_init(Object *obj)
     sysbus_init_mmio(sbd, &r->mmio);
 
     /* watchdog timer */
-    r->wdog_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                 sifive_e_aon_wdt_expired_cb, r);
+    timer_init_ns(&r->wdog_timer, QEMU_CLOCK_VIRTUAL,
+                  sifive_e_aon_wdt_expired_cb, r);
     r->wdogclk_freq = SIFIVE_E_LFCLK_DEFAULT_FREQ;
     sysbus_init_irq(sbd, &r->wdog_irq);
 }
 
+static void sifive_e_aon_finalize(Object *obj)
+{
+    SiFiveEAONState *r = SIFIVE_E_AON(obj);
+
+    timer_del(&r->wdog_timer);
+}
+
 static const Property sifive_e_aon_properties[] = {
     DEFINE_PROP_UINT64("wdogclk-frequency", SiFiveEAONState, wdogclk_freq,
                        SIFIVE_E_LFCLK_DEFAULT_FREQ),
@@ -307,6 +314,7 @@ static const TypeInfo sifive_e_aon_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SiFiveEAONState),
     .instance_init = sifive_e_aon_init,
+    .instance_finalize = sifive_e_aon_finalize,
     .class_init    = sifive_e_aon_class_init,
 };
 
diff --git a/include/hw/misc/sifive_e_aon.h b/include/hw/misc/sifive_e_aon.h
index efa2c3023f..e907aa7869 100644
--- a/include/hw/misc/sifive_e_aon.h
+++ b/include/hw/misc/sifive_e_aon.h
@@ -46,7 +46,7 @@ struct SiFiveEAONState {
     MemoryRegion mmio;
 
     /*< watchdog timer >*/
-    QEMUTimer *wdog_timer;
+    QEMUTimer wdog_timer;
     qemu_irq wdog_irq;
     uint64_t wdog_restart_time;
     uint64_t wdogclk_freq;
-- 
2.43.0


