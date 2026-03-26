Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D1510AB829
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtt-0004B5-TF; Thu, 26 Mar 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtq-0004A0-SL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtp-00039Y-6K
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=EBmXSVH3I9o/i6OYM80KziZ+6GuoCR3ItrDzblS2vIHBMhgdDhNfhszFUhMcMl7twxVFa6
 aEhdm1fyfJPC2ZRTaLM9ep0Yjm8RT59sS/zs7zxpAkhl7p1kRp98azti1Iub+QGen4wnPV
 s/pFmz5Ia7HRtIOBJftebREyrg75tqM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Aiqq05axPSWobj6hgbuy8A-1; Thu, 26 Mar 2026 17:05:50 -0400
X-MC-Unique: Aiqq05axPSWobj6hgbuy8A-1
X-Mimecast-MFC-AGG-ID: Aiqq05axPSWobj6hgbuy8A_1774559150
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c4ec516e5so62601016d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559150; x=1775163950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=ATCQ2GNE5zCX9ltgtp8JrzwulO2Nmq5wvAbnqD2F2GMEkTA89M6j8+lFWFOFJW8HTV
 TyiBhjhwjzFoy9VMNwKm62vYww8D2ukuTjHsloumiONBfnbHrfOQMj6U0qna6CYaZvSz
 F/VHw97bn9/eRDI0ns0OA/lCh8pt/IOWHT/mezskwEeQBB0/LRZLq7AfUKiwdQG0jf7R
 9LMGWXq9MZitf31yU190kq+e++KqYHrOXZBckbQ0nb0YqI1vwz5Iuq9JZpRURDRI88zF
 YwTVWVfEKaClKNE54zNEXEdMiOlfi3PSI/yB7Y4YPxORihf2ktSIGSxmmsXmzaMdZttr
 oORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559150; x=1775163950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=rjZSp81mc8L3AraJ7oTv1Shp//7kpVZotI0UA8aXQ9an8Di1ZJxpFd/sxvk4CFXMuf
 dKlb9VBl1IQpaWxMQkOE3FnNNUXD2EXiBBAJKJNOVuOzEAwpr0LIr+GOh+VjkxmXJI1K
 qY3F5izN0ayFuNhw+vfYo0DUWo+WtC3+ntG58M5dqB45WQuyc2qrmEgMFORQzz8oS7zc
 xn2+aTTbahHCYhXOGLJdkVApBTInhrlX76tmFhE4ZoTYvMREZg910NPX2BRCwz5VWCbO
 clL3WXBT9rD9J2uevlAw0Ey3EFsEVjZCyBMHYZzxToE67heR283cxc+HUvOBhiipCqL4
 muMg==
X-Gm-Message-State: AOJu0Yx2ZLww8YYcEeE4uAzYDqWfa6ZyGqmydvScuc0PEPoz610poNEP
 zqePeYFptNLIC92gB9P+h++zEdOUeIp/vjafgaAjQO0gE5p6tzjVT0lObY935F329TGbz23RPyQ
 QBY1uWjs/SaHUQEeYxneZKPfq1GLr3vagplxii7Pso8HHD5QjjWwP+9uhUkL4g5AIFlNVoa7ZPr
 Rev8CapoRFqp5pCF6tCjn6F0h3+Kp5rbkQL2pKmA==
X-Gm-Gg: ATEYQzyqAxwNQzx1zMIaLzF/gbC4ydSn7tk0LTauxIFjV0yMzYCGf3ojkk/Gx89254a
 0VFXnUbGK83MPUvUJNQL4DQcoZK8ysSf0g4r+Hm22BcwYOQoNGmsemMxF1ggVvMpUp8g9QVzJp3
 NwfIihR4u+lofgQ5rrYLv06QUgW2mY6yVOqsiAZXjmAZGY4ue/OwS1jcJDwQMdOzbXPMQ6YL/iu
 BPKdJO9DH00fXkgsjTxBq+oV+d1qAXqDqQgjWf9LtDc8DLAzSCaRrcM3OJob0UixRD+djpNBt93
 ywSA32xLXNYETWtnd+CS3PNdcgdmPXK7l84HJVwMNkWVnhQs1wl0ogpSlxmUMs76/BpxwYvrScC
 OjrOBkcXfCP4=
X-Received: by 2002:a05:620a:4449:b0:8cf:d469:8456 with SMTP id
 af79cd13be357-8d000f85e87mr1224703785a.4.1774559149547; 
 Thu, 26 Mar 2026 14:05:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:8cf:d469:8456 with SMTP id
 af79cd13be357-8d000f85e87mr1224696785a.4.1774559148749; 
 Thu, 26 Mar 2026 14:05:48 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 11/11] tests/unit/test-vmstate: add tests for
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Thu, 26 Mar 2026 17:05:32 -0400
Message-ID: <20260326210532.379027-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add tests for VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
[peterx: Removed two tests due to macro not used, rebase, fix warning]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/test-vmstate.c | 86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index dae15786aa..df1fb4c778 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -702,6 +702,88 @@ static void test_arr_ptr_prim_0_load(void)
     }
 }
 
+static uint8_t wire_arr_ptr_with_nulls[] = {
+    VMS_MARKER_PTR_VALID,
+    0x00, 0x00, 0x00, 0x00,
+    VMS_MARKER_PTR_NULL,
+    VMS_MARKER_PTR_VALID,
+    0x00, 0x00, 0x00, 0x02,
+    VMS_MARKER_PTR_VALID,
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
+            ar, TestVArrayOfPtrToStuctWithNULLs, ar_items_num,
+            0, vmsd_tst, TestStructTriv),
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
+    SUCCESS(load_vmstate_one(
+                &vmsd_arps_with_nulls, &obj, 1,
+                wire_arr_ptr_with_nulls, sizeof(wire_arr_ptr_with_nulls)));
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
 /* test QTAILQ migration */
 typedef struct TestQtailqElement TestQtailqElement;
 
@@ -1568,6 +1650,10 @@ int main(int argc, char **argv)
                     test_arr_ptr_prim_0_save);
     g_test_add_func("/vmstate/array/ptr/prim/0/load",
                     test_arr_ptr_prim_0_load);
+    g_test_add_func("/vmstate/array/ptr-nulls/str/save",
+                    test_arr_ptr_nulls_str_save);
+    g_test_add_func("/vmstate/array/ptr-nulls/str/load",
+                    test_arr_ptr_nulls_str_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
     g_test_add_func("/vmstate/gtree/save/savedomain", test_gtree_save_domain);
-- 
2.50.1


