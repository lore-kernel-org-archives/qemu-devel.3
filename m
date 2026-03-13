Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C999105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GQ-0005WU-ID; Fri, 13 Mar 2026 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fw-0005Qa-Dg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fo-0006Md-55
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so23136695e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411148; x=1774015948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVGscBXdfGh8fDEwqpswNHuWUNoSPZVqRG0/M7ov0/8=;
 b=JsIK2QWZhVv9SPelNnSFnBPGlLnylxiqjYNMEwemVZRQ/dq48IaP0wZFIKNQCcW6jJ
 EzF9WcS7S2rgUVipG6uVtsTwNtWYe8IjeyXZxoTwtA9IkgRIZcxWYtRCfgfwVGlPtMOT
 W0mOjmK6h4MEv+ipVcB9fqI3l2gyaUaMeBsYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411148; x=1774015948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tVGscBXdfGh8fDEwqpswNHuWUNoSPZVqRG0/M7ov0/8=;
 b=ZspljbSxk+R6uvqQ5m0LY3S4F/a1LhgDVqjyDk2bbzZvDswmM0O1FSO45BuAsCRL5A
 KTievkByRYYnnnyjx9NYvMSSVOuze1uw5RItIHDy8qN+efyb+54YcsU7vOea0t7FDzMW
 6mOh4NOphgghsQsqApKqOV3YFJLJn+NotXl9mN8IxXydzsRzu0bwCOs5TiOKB8RChj24
 adbXquttmjFA2BGrsHoqIdntgDyU2RhiV3f7rkClrtfY9hO0730b+7jeEeyHKDJv3rld
 EDdtnzBkGbi4NKoqY0wSVFibw/O6RQhWOcsPr1OdAo7Xi2+av+/g3TIcAYZzxsKe/QsS
 3Fog==
X-Gm-Message-State: AOJu0YwyEEtjC59lDbt7vbXjElTwQ+2DMI2i6VCXwxubkYEpcvYbZSGc
 apZ4oGRV0pcfeRyGn5lTF515kVhjWep/PAFo7PG7tViCFeT5AMOCS0MUVeH6yFUVTMTyYHHCwUc
 53aDd+Go=
X-Gm-Gg: ATEYQzyAEVcRsFSatNg+zDbr4woGc2+mU32DwdHeZYXi+nn7h4rift3ldOBElolPxXU
 8Us3HeoIWf5aG5pBlY8iVIdMHDOtOFzc02K3lC0s9VFka7sVeojsF0cbnWrysPf1CP4ZeErxth+
 pkH/fOJ46ioBN2ePhNizVn9tvzkDFS0RKcX0OeOpFJwZUMaMEEuTCnSc/DZpgN8m4GMIc9Bfv85
 CTAznxHWyqK4X4ctzRCqKNBnpmT23Jlar4An/mM2ymwiTURt9vbssafVV73AgZ+YwBT0KgyLLAH
 LTW/tof4rkIulaUzwGrNKrOu4TCNqBEi/B6wdpi/AH6BsViYmk4nePVlp3TMEBWCwhus0Q7KhKc
 7fC6ZmAAib3vJxPaeDVdwMeYyspeI97oKoGGgePr5uhYF0FkZhs4aRG12MMyUPJ07Klh7GayywL
 tmmq63bdjshhIHWqkRlLO0yh8q6HrY3mMuCo7ecraywlgxwRPzTG3eau8IG2w33i59CqAOFZR3p
 9yRjam9UCW3mwH33SLcC6k=
X-Received: by 2002:a05:600c:a09:b0:483:9139:4c1d with SMTP id
 5b1f17b1804b1-485566e1a4cmr60597925e9.14.1773411147609; 
 Fri, 13 Mar 2026 07:12:27 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:27 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 3/8] tests/unit/test-vmstate: add tests for
 VMS_ARRAY_OF_POINTER_ALLOW_NULL
Date: Fri, 13 Mar 2026 15:12:16 +0100
Message-ID: <20260313141221.359503-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add tests for VMSTATE_VARRAY_OF_POINTER{,_TO_STRUCT}_UINT32_ALLOC.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/unit/test-vmstate.c | 157 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cadbab3c5e2..d10cf34fc75 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -702,6 +702,155 @@ static void test_arr_ptr_prim_0_load(void)
     }
 }
 
+static uint8_t wire_arr_ptr_with_nulls[] = {
+    VMS_NOTNULLPTR_MARKER,
+    0x00, 0x00, 0x00, 0x00,
+    VMS_NULLPTR_MARKER,
+    VMS_NOTNULLPTR_MARKER,
+    0x00, 0x00, 0x00, 0x02,
+    VMS_NOTNULLPTR_MARKER,
+    0x00, 0x00, 0x00, 0x03,
+    QEMU_VM_EOF
+};
+
+typedef struct {
+    uint32_t       ar_items_num;
+    TestStructTriv **ar;
+} TestVArrayOfPtrToStuctWithNULLs;
+
+const VMStateDescription vmsd_arps_with_nulls = {
+    .name = "test/arps_with_nulls",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(
+            ar, TestVArrayOfPtrToStuctWithNULLs, ar_items_num, 0, vmsd_tst, TestStructTriv),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void test_arr_ptr_nulls_str_save(void)
+{
+    TestStructTriv ar[AR_SIZE] = { {.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
+    TestVArrayOfPtrToStuctWithNULLs sample = {};
+    int idx;
+
+    sample.ar_items_num = AR_SIZE;
+    sample.ar = g_new0(TestStructTriv*, sample.ar_items_num);
+    sample.ar[0] = g_new0(TestStructTriv, 1);
+    *sample.ar[0] = ar[0];
+    /* note, sample.ar[1] remains NULL */
+    sample.ar[2] = g_new0(TestStructTriv, 1);
+    *sample.ar[2] = ar[2];
+    sample.ar[3] = g_new0(TestStructTriv, 1);
+    *sample.ar[3] = ar[3];
+
+    save_vmstate(&vmsd_arps_with_nulls, &sample);
+    compare_vmstate(wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls));
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        g_free(sample.ar[idx]);
+    }
+    g_free(sample.ar);
+}
+
+static void test_arr_ptr_nulls_str_load(void)
+{
+    TestStructTriv ar_gt[AR_SIZE] = {{.i = 0}, {.i = 0}, {.i = 2}, {.i = 3} };
+    TestVArrayOfPtrToStuctWithNULLs obj = {};
+    int idx;
+
+    obj.ar_items_num = AR_SIZE;
+    obj.ar = g_new0(TestStructTriv*, obj.ar_items_num);
+
+    save_buffer(wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls));
+    SUCCESS(load_vmstate_one(&vmsd_arps_with_nulls, &obj, 1,
+                          wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls)));
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        if (idx == 1) {
+            g_assert_cmpint((uintptr_t)(obj.ar[idx]), ==, 0);
+        } else {
+            /* compare the target array ar with the ground truth array ar_gt */
+            g_assert_cmpint(ar_gt[idx].i, ==, obj.ar[idx]->i);
+        }
+    }
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        g_free(obj.ar[idx]);
+    }
+    g_free(obj.ar);
+}
+
+typedef struct {
+    uint32_t ar_items_num;
+    int32_t  **ar;
+} TestVArrayOfPtrToIntWithNULLs;
+
+const VMStateDescription vmsd_arpp_with_nulls = {
+    .name = "test/arpp_with_nulls",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VARRAY_OF_POINTER_UINT32_ALLOC(
+            ar, TestVArrayOfPtrToIntWithNULLs, ar_items_num, 0, vmstate_info_int32, int32_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void test_arr_ptr_nulls_prim_save(void)
+{
+    int32_t ar[AR_SIZE] = { 0, 1, 2, 3 };
+    TestVArrayOfPtrToIntWithNULLs sample = {};
+    int idx;
+
+    sample.ar_items_num = AR_SIZE;
+    sample.ar = g_new0(int32_t*, sample.ar_items_num);
+    sample.ar[0] = g_new0(int32_t, 1);
+    *sample.ar[0] = ar[0];
+    /* note, sample.ar[1] remains NULL */
+    sample.ar[2] = g_new0(int32_t, 1);
+    *sample.ar[2] = ar[2];
+    sample.ar[3] = g_new0(int32_t, 1);
+    *sample.ar[3] = ar[3];
+
+    save_vmstate(&vmsd_arpp_with_nulls, &sample);
+    compare_vmstate(wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls));
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        g_free(sample.ar[idx]);
+    }
+    g_free(sample.ar);
+}
+
+static void test_arr_ptr_nulls_prim_load(void)
+{
+    int32_t ar_gt[AR_SIZE] = { 0, 0, 2, 3 };
+    TestVArrayOfPtrToIntWithNULLs obj = {};
+    int idx;
+
+    obj.ar_items_num = AR_SIZE;
+    obj.ar = g_new0(int32_t*, obj.ar_items_num);
+
+    save_buffer(wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls));
+    SUCCESS(load_vmstate_one(&vmsd_arpp_with_nulls, &obj, 1,
+                          wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls)));
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        if (idx == 1) {
+            g_assert_cmpint((uintptr_t)(obj.ar[idx]), ==, 0);
+        } else {
+            /* compare the target array ar with the ground truth array ar_gt */
+            g_assert_cmpint(ar_gt[idx], ==, *obj.ar[idx]);
+        }
+    }
+
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        g_free(obj.ar[idx]);
+    }
+    g_free(obj.ar);
+}
+
 /* test QTAILQ migration */
 typedef struct TestQtailqElement TestQtailqElement;
 
@@ -1568,6 +1717,14 @@ int main(int argc, char **argv)
                     test_arr_ptr_prim_0_save);
     g_test_add_func("/vmstate/array/ptr/prim/0/load",
                     test_arr_ptr_prim_0_load);
+    g_test_add_func("/vmstate/array/ptr-nulls/str/save",
+                    test_arr_ptr_nulls_str_save);
+    g_test_add_func("/vmstate/array/ptr-nulls/str/load",
+                    test_arr_ptr_nulls_str_load);
+    g_test_add_func("/vmstate/array/ptr-nulls/prim/save",
+                    test_arr_ptr_nulls_prim_save);
+    g_test_add_func("/vmstate/array/ptr-nulls/prim/load",
+                    test_arr_ptr_nulls_prim_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
     g_test_add_func("/vmstate/gtree/save/savedomain", test_gtree_save_domain);
-- 
2.47.3


