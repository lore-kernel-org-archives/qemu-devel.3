Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69668F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnp-0004VU-Iy; Sat, 07 Mar 2026 10:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnn-0004JZ-Ja
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytnk-0002cs-LN
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-483a233819aso101066455e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898166; x=1773502966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxXcgTIjs3O9IFx8gABZ9Om88U+wQy7QKGtyc8xrz4s=;
 b=bHSTXC41eCO1fZhYWiunqf0MfcjmtfNkedciVsxoZIShmvUefcZ/8GA0WR2ypnVsLw
 WlJzXQOUGasFz4f/ULCJX37cGeUb5pMxdMg3bJ4LUMcy+zqBSDA9Vc49gQ7zN91icIdU
 5Px8vZZvhefXyaw8eRIMWfMaP81FuqtfBX8qYjaCcMbtNfXUv773jZhjid8zPZE3dWs/
 hts4N3XH+UzGiQZT2HqInRPNuUuTdhCo3Qk73g3+j5oHICayAay2atM/PpVbeqw833sG
 6QEKuXh+GZvvs/F4RfNbkZS8V18cm5bD9MH6VZL30X8Op+O6O5wuWcjEQPbSZFuBnbSz
 6hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898166; x=1773502966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YxXcgTIjs3O9IFx8gABZ9Om88U+wQy7QKGtyc8xrz4s=;
 b=iS+rdei5OxoBXGbKSOAPvRZY3yl0/tnzmG1NJwvh2gptp+KcCK225BWP+jIoBccxad
 ZZag231SZobhgXYrtpf8GPO1X9YherbFs3EWHzHQEguVPyfAXK61F3dUBMO6gb/XTZpB
 mi8Y8ydr9VYN7uYwxjbLG/qUwDPzRLRNx5zHWNduCT9BysrAmyiZn3woaKdxFRFCNqvf
 t0aYOnoOs0g9nl2HprebQYSNql4FvGT0FYdNmqQDuICwUTVTWdP8nJ6xVBoOjzRdEpo7
 E7HD+tNE4Q7TvaadNYVWoz4RUUDiBCmpre67t9KfVyTO5l7J5Ya2UJkpZJoX34bPxJjq
 JPGg==
X-Gm-Message-State: AOJu0YwwU7IUSGuFv6MAJAwSLxZtn7Wwpp84gs7vxUV+cZ2SGyRJNvDj
 Pw33EFS2KXKoCuhac2CNXYIxIeh71VFdk3KHNcFFbpzFCOND8zsBxEIrC/pA6MUcGSW7zHLcFSg
 D5Jfrpc8=
X-Gm-Gg: ATEYQzz15LHQ2IKryU9g+dIJTa1rGqcEF0vXp65ymvwAffPhCIk0QsGpCWciLvlp0cM
 /3QhnY77idl5iQ9yWHkkKz7esFwjeXqh1s/GZZcamY5imW+ECQ/0d+bTyVKNwgKWMaqPEMBUeAE
 O8Ftt/0LHAaBh2qk//SDprg34n/5+AC27Gz/YOQdgZ+6+lythOujL0gXMdZ4eqiGZN56u3zq9cr
 0/ZXnIrsCJOIxWa24TZsQkd7N41315loR0UUbjrEZ1J2SgF79lS5DYhlnpFvmLIojsP+xRzmDaC
 /Znl+SrnCGnQ+MuVzQTpzylVsW+fXqwbwiFylDNCZmKlrrhy1Fvb4EWZhBYGhSVt9Y2OH17eN0Y
 GXqN+gHBRT8mobsjqhfsLuK9O1OhZ4SqNBm8QaZb3mz8v3srFryFFDROgxIIeBpSkMB33bmHdk6
 RVqYcm2M+5Da1LFa/2n0qBohAApVSwDhocwjVm9Ze6aYeTbkSZC9Us5FIWsYCkPhLoMdP1WiLP
X-Received: by 2002:a05:600c:3b9e:b0:483:498f:7953 with SMTP id
 5b1f17b1804b1-48526966364mr100848005e9.28.1772898166167; 
 Sat, 07 Mar 2026 07:42:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dd017sm44629195e9.2.2026.03.07.07.42.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 6/6] hw/rtc/pl031: : Remove PL031State::migrate_tick_offset
 field
Date: Sat,  7 Mar 2026 16:42:02 +0100
Message-ID: <20260307154202.86309-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307154202.86309-1-philmd@linaro.org>
References: <20260307154202.86309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The PL031State::migrate_tick_offset boolean was only set in
the hw_compat_4_0[] array, via the 'migrate-tick-offset=false'
property.  We removed all machines using that array, lets remove
that property, along with the pl031_properties[] array which is
now empty.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/rtc/pl031.h |  1 -
 hw/rtc/pl031.c         | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/hw/rtc/pl031.h b/include/hw/rtc/pl031.h
index c8b26c2f00e..75779c63122 100644
--- a/include/hw/rtc/pl031.h
+++ b/include/hw/rtc/pl031.h
@@ -36,7 +36,6 @@ struct PL031State {
     uint32_t tick_offset_vmstate;
     uint32_t tick_offset;
     bool tick_offset_migrated;
-    bool migrate_tick_offset;
 
     uint32_t mr;
     uint32_t lr;
diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index b56877c3a20..09d1b15c779 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -278,18 +278,10 @@ static int pl031_tick_offset_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pl031_tick_offset_needed(void *opaque)
-{
-    PL031State *s = opaque;
-
-    return s->migrate_tick_offset;
-}
-
 static const VMStateDescription vmstate_pl031_tick_offset = {
     .name = "pl031/tick-offset",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = pl031_tick_offset_needed,
     .post_load = pl031_tick_offset_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tick_offset, PL031State),
@@ -319,25 +311,11 @@ static const VMStateDescription vmstate_pl031 = {
     }
 };
 
-static const Property pl031_properties[] = {
-    /*
-     * True to correctly migrate the tick offset of the RTC. False to
-     * obtain backward migration compatibility with older QEMU versions,
-     * at the expense of the guest RTC going backwards compared with the
-     * host RTC when the VM is saved/restored if using -rtc host.
-     * (Even if set to 'true' older QEMU can migrate forward to newer QEMU;
-     * 'false' also permits newer QEMU to migrate to older QEMU.)
-     */
-    DEFINE_PROP_BOOL("migrate-tick-offset",
-                     PL031State, migrate_tick_offset, true),
-};
-
 static void pl031_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_pl031;
-    device_class_set_props(dc, pl031_properties);
 }
 
 static const TypeInfo pl031_info = {
-- 
2.52.0


