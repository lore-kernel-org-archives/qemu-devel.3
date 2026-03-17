Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87C7FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2YZG-0006Wq-70; Tue, 17 Mar 2026 13:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYz-00068T-Mq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2YYx-0007Ri-8x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:50:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso51324285e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773769837; x=1774374637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFaMGZ66GEVxgBo88H6zll0QV5dpg233EdqdQXAs2WE=;
 b=Qr9oVmn72wtvD66n7s9757bWFxSc3a6JRb4Ou9nxo3jnQhEzuaC86NQF3DcrbUViqY
 z/j8bvUUhmB0e5cmIKF2J+heSKyAxxzpSxvjw0HvGgkAHe1druyFSej6vNrTVRDMffy1
 mis3IyWmFc2XPY9gxle4tNag8um2lQwLbMAcjP20txm5u1mAWUS1MfMY21gDFKiBDnFT
 qtXBcsGnlqDuuP8YyzmVmxUu5FzRAcbpPc2aMkxBjT3vex0HbfHg2X8Bu6gzZtOaeVSO
 GzsjsXFoOh0+bl5DkN8EkcMOr+/hVrPtHv0hK6UgTWGH1E8/jAnPP71nrJoWMn6mjfKT
 WqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773769837; x=1774374637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QFaMGZ66GEVxgBo88H6zll0QV5dpg233EdqdQXAs2WE=;
 b=i7BAsFUHFegyP0kjcq3VNWM21dh1XZjHYZ/ysWs9euLtEVGP7YbSKs0b7z8OgEB1Nw
 YTN+k32Fh97x2uq0+hnLIpVb1tZeDWMIDelIjUIoQk4mynjqzimMWsUi392qKXR2Kfrw
 iX43sOcfIaguJxn63JRqFEzvBC7aGUDMjL8tRyq5vp2joaueKEpc/FZbbtebB6xNMVDU
 qwb6/B+XHBzfRiIP1TuDEcNNpOCnqIryBecCVt7P0s+JICpxPzDUgw+o+LW3elW4E5+n
 5EUN/4/3WYyRkX1DBw5r7lWRru4mHVSvc8xCu8FJJLb+5C1wrzAXGUNMic8lRLAO79ku
 JHKg==
X-Gm-Message-State: AOJu0YyvIG+eVXdtcsVQcc7U8JbsjJSnHJlIOBI0f2Ml4XFiCLT5Wvnv
 u5SN+Nrnm2k0c0oMrSdkCzc+VGQmwR5kwaaRV8HopKIN4fls1t8YZzzUutJXTStVX7gIJva0zWy
 Asdrp
X-Gm-Gg: ATEYQzwpSZo/OjnQtbf+/vup6G0Z1V8o7UO4tkJKX7BOZrQRFdfTW/Vo4iJoHYusqdZ
 mcKF/AZfseFZ491WvGCZwr/cPLiZGmitXf7tLermPcwsAJNZqMzPQbaPTr+RP2QhANdZND6KX7Z
 4E9DZRGTVxdSM1sl6TEP2CrTRN89Yt8mTsAohm8Gvt+IIG6hMOSOBrtYjrttcfvTM9m8A+aBI4B
 iitsi49yU56jB4IYeVxboiEGs6sc7B/lrkK+NN2Et1uujJBIZbT78zue+CldYbXp+pFxdfv2q8d
 kaXwFQzcHdFirksuATXF0wI9w5ElTHLV2/zPV3+UMozx0Ux2KqRZ5zQ/kKCf+w53d+2WqEMy/r7
 IGiSX9LNBzVGRNlFH0d3jK1HSZrpN5sI1NMuzof9nvjAxr04hkFUEEBjbOmYqHVNNS3M8rm+koC
 kWpqOUqBed4sHuLDeamo7YiwDc9uyY1lw2OG96vehDG94LPjMo4nKnNtLIi2hlLWnDHwhWuFlAk
 Fde7fKuy7vxHobOhRQcjYmFpYNQhEE=
X-Received: by 2002:a05:600c:19d4:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-486f4440f10mr7730165e9.5.1773769836688; 
 Tue, 17 Mar 2026 10:50:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c7220dsm118786995e9.30.2026.03.17.10.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:50:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 2/3] target/mips: Free mvp in unrealize
Date: Tue, 17 Mar 2026 17:50:29 +0000
Message-ID: <20260317175031.3035740-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317175031.3035740-1-peter.maydell@linaro.org>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

We allocate memory for cpu->mvp in mips_cpu_realizefn(), but we
never free it, which causes memory leaks like this:

    Direct leak of 24 byte(s) in 2 object(s) allocated from:
        #0 0x5f9458e61c8d in calloc (/home/pm215/qemu/build/san/qemu-mips+0x4d8c8d) (BuildId: 4153e33b3d08657a71ce2a04a82d0c2954966d9c)
        #1 0x74761891a771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
        #2 0x5f94590687aa in mvp_init /home/pm215/qemu/build/san/../../target/mips/cpu-defs.c.inc:1037:16
        #3 0x5f94590687aa in mips_cpu_realizefn /home/pm215/qemu/build/san/../../target/mips/cpu.c:489:5
        #4 0x5f9459366a3a in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
        #5 0x5f9459380a49 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
        #6 0x5f945937bace in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
        #7 0x5f945938816c in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
        #8 0x5f94592cc100 in cpu_copy /home/pm215/qemu/build/san/../../linux-user/main.c:240:25
        #9 0x5f9459309931 in do_syscall1 /home/pm215/qemu/build/san/../../linux-user/syscall.c
        #10 0x5f94593058d8 in do_syscall /home/pm215/qemu/build/san/../../linux-user/syscall.c:14422:15
        #11 0x5f945905c73e in cpu_loop /home/pm215/qemu/build/san/../../linux-user/mips/cpu_loop.c:124:23

for linux-user, where each new guest thread is a new CPU object that
we need to destroy on thread exit.

Add an unrealize method which frees this memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/cpu.c | 12 ++++++++++++
 target/mips/cpu.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 789ca188b5..0663cda003 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -502,6 +502,16 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static void mips_cpu_unrealizefn(DeviceState *dev)
+{
+    MIPSCPU *cpu = MIPS_CPU(dev);
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
+
+    g_free(cpu->mvp);
+
+    mcc->parent_unrealize(dev);
+}
+
 static void mips_cpu_initfn(Object *obj)
 {
     MIPSCPU *cpu = MIPS_CPU(obj);
@@ -606,6 +616,8 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, mips_cpu_properties);
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
+    device_class_set_parent_unrealize(dc, mips_cpu_unrealizefn,
+                                      &mcc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, mips_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 8de3178b6d..ca36ca0d6f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1225,6 +1225,7 @@ struct MIPSCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     const struct mips_def_t *cpu_def;
 
-- 
2.43.0


