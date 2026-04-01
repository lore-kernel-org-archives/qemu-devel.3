Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B75610FCAD2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BX-0004OC-0k; Wed, 01 Apr 2026 16:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BV-0004NB-1v
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BT-00039z-FA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=cJNdBuz3S6is0ruPjvt0Pn+XtAJ72jBZJxFTphrkxe3AnzdPsl6dWLq4qDHKK4h4aW2Ctr
 b+/FIbVah2bG4MTCFPE5qfMVY78Q4y4+o2Cksi9RlhGNj3p6/6MFuXXLUgZu0IYoYp/Vqa
 d4SFxuXdfgX1K2K73LOEc943LFLJ7SI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-N5Uq9oryMmeXIIPKhyAFlg-1; Wed, 01 Apr 2026 16:29:01 -0400
X-MC-Unique: N5Uq9oryMmeXIIPKhyAFlg-1
X-Mimecast-MFC-AGG-ID: N5Uq9oryMmeXIIPKhyAFlg_1775075341
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so59896285a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075341; x=1775680141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=aUa9Rn6GgEB9uo7STWAZeliH2WTJUD4MuOu3KtoRlS5dGhz9szVwCeqOqz1U6vH0X9
 4o582ZHnJtQpZqfzbn6qgXlApwbz9GvhNv8vIVGOgtYzqcdnmd6weVgnWEmYc9RVSmpj
 WatHwSR/iD9OPr8jh0Oc2n7OqSdryvUZPTOXoyXgOMS5evpruCV4siAM4/NL0dMQlcXC
 p5NA4Nu0ViCPp8YA2/MOmUJb8IUvoULZyzQLPa/TZyr5ltwnXDzwdOHSBa69OpxBSm5X
 dcUHulVrK1hDjPSEakDTJg4gue9PjGoqKnpL2ofIW7+Mc87fxEMtacoosKufKJLe3ZAi
 oXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075341; x=1775680141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=pXSfS1JYVbwADf5/5ee8pAXyReJF9CnMUQl/wBlniLz48bZWRt2tNgZ6a1IGgSU0bw
 5ettbzEivDrAcNJ/pi2ft4yCxVwYQ9hUMZ1qAKWF6kGsqDd6rfeUSjM1I8aWsNaxyI/l
 iRH6Lh5jGpbn7rn4rksutnRAMIfdoqK3ZNml6F8I1Xonekf58gvrl9L+X96qZHS9ZxhF
 1okExlfLqgQlKtrbeJ3250R8HAQTDZCn0+EElZbAdcZkDiRhPsIoKTy5Ki6cQzPV9LHt
 8YHl1YcetC2tybEeCtTNq+9OUw7z1wmFr8FZpcnccLdFRLw3Oopt2tIOahbgfsh5jJhF
 /SkQ==
X-Gm-Message-State: AOJu0Yw9emVwOb0JwYQFYiod+zJtKkMaXNe6yybF7mSgvleUI4G1cxHJ
 67FRc8VxJo/56+VZxu9o/gufume5/1Wehi7GCOKGvhjBdAEhjjLH5PemP0PSQBXcif14HMGygLH
 Mb9Ph9Z8y48rQyBGsBV1ztr6NkdRkfQvPvvEGZDX3xNcW3u1dPpOvfTRFLYnzUAwdwspQSrFMXp
 QaFqM7WDG3aHlVZ1P9VteqkZ2jk4JRZPoEUBOJNQ==
X-Gm-Gg: ATEYQzzL6s9dlHJBmI8YMBa4rGxWbCnOYfqhYMX/7NO9qwJNm1X/NgghPL3yAOT58q3
 9S+pqNhsMy2q/yYqh2t/s+bdVsEqWfKWCCwvZb30BVNnE1aavb/kzoj9Kc4zPBdkj7cIg5Wjiba
 6jPLw3+A1UP2wZiRY2ToMLshAu71mn8g/GsLNEqZV2c4/ZP30UZhCdgp+VrphtPQybmvAr2VOrV
 Nhc/OChdODzeULLRR5gUY7K8Ho1G55RhBJMal8omBA0mRJztbZPPpMS0VIapJYHYZ4ZpacryRZ4
 AwqbD8dsw/Fhd22zHyl9Ih1uSDZ3bPzD9cE2jN0RXvuKxNtETYFlXtuCyKCAKVfrzEF5jPEKNos
 bqhoo3TOAFw/x39UFsObNj6iU8ndTAZVVMZJ0fMl45Uc=
X-Received: by 2002:a05:620a:4103:b0:8cd:8f94:259b with SMTP id
 af79cd13be357-8d1b5b876f6mr760034185a.33.1775075340676; 
 Wed, 01 Apr 2026 13:29:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4103:b0:8cd:8f94:259b with SMTP id
 af79cd13be357-8d1b5b876f6mr760027585a.33.1775075339906; 
 Wed, 01 Apr 2026 13:28:59 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 11/11] tests/unit/test-vmstate: add tests for
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Wed,  1 Apr 2026 16:28:44 -0400
Message-ID: <20260401202844.673494-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


