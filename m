Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77775FF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlX-0003zg-6u; Tue, 17 Mar 2026 19:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlV-0003zW-BI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlT-0006Ti-MG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=gPTUT+rqSJxwd2YLjxU24wPG3n91cTQAtezPMFCagSH2Y5f2WRWFK4GLQwWa7oYIDYGX84
 aLidUYnFOB6CoDqP0VL2v4Mm1hrC9ZFl6JdOqwStsfCkZwAlZpdxCJ3NBZcxsY8+RKLjUx
 6HrLO/qkj+ZUx2WSBEvuN867ZIdF5Cc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-o0Rf9xeQPqGUbX8IIEQj9g-1; Tue, 17 Mar 2026 19:23:51 -0400
X-MC-Unique: o0Rf9xeQPqGUbX8IIEQj9g-1
X-Mimecast-MFC-AGG-ID: o0Rf9xeQPqGUbX8IIEQj9g_1773789831
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899f671ceb2so480546916d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789831; x=1774394631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=QJjNZakIwGiMsJckghSJGel/sKUe2XYsKLYMoWN6g0nM1ZJ5khcVtsnxdMY7/pRTer
 D1ACHp0GcnBduKpEtO9iwBCNPWD/b4mdR3/INh1X9IhDtv1XYxCRKTpLhe8sFFE8/AqG
 4dAsFIvHwMnMfTLdyFn/QcSwM1/wXPr+S0GIi1GOrDeatEY3O0s7TKhwHY+eXdROgb45
 e3wGOf6IEAnEvcrDl2KNi+f68PLKPpKPNjpHZVljErn9y2DcPihP8i7fXmydKMYE+4bN
 zHw8n5PB/Ry5OorjH69nlkD5p7hS0NvqHYCGx7VeR0z7Rknfs43P1rbCAhJmtyZSlp0F
 /r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789831; x=1774394631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTcRRki4RVI+IH0q3dAynZQWyxZQTTE18znN3ItjLD4=;
 b=qddy+w8orLQ7cevl8H8Cuf1KBmcfA0wNg9apI1InDYm5RzSAF97QZtY6bPWLJRPNuM
 SPnrrR5CVF14cpA1EIlck6RRdSBQJTfSCK0dGz7JaFqilnmMdTZ0z6y32art+vDGq1LK
 Ri80VbK47jxDo+yyjJpMGo1iBLytn0J5FIC9hZE/D0Jr7KjkH/LKbGyjsXodSajEY4Om
 LMvnbLyZDRMO+kBgnG0SAhklHCZ9s/NEeTMsArBFZwqeJXQs+0mASuO0wK8urWstSWLe
 mkV9V/PxnNZpVQJCHM+87mMKaGBL8HS9DfnQfh0oJHhx1Fak54rDrwlHtixuyLgMHRGN
 jIMg==
X-Gm-Message-State: AOJu0YxH0INdrvuCBkFPx0VxI2q3m0vhlwuqQb+ajTP1LDwycjH8No5I
 hK51134I67DiP0559cSjfPy2fwinPmBu5L/Z1kkHlKIxr2dIp1y56LmPp4i24g3j0PB7Jlzvtor
 C6dxhEB6Yg6DICY99JzGoqzlcBHLeHCHqCF9ryZKy5avs4mnuoAm8nD0oK3oCsFhCaIEi3GObnI
 p3YEn+dVF+p18tfyID2QBZyRvcvKnZIH0dz6LH7g==
X-Gm-Gg: ATEYQzzl/mTMK7ZbMVBroO+dKtmpDfCW9A3jW5ewFD9lLa1Oy2bEWHRKn1D1C7tKpfz
 vX9yV4lU67NktkIJ8OLsQMjbOLL0SaasEEb8ow7FKGyranBFNwqUr+TYGVhLFjkKUxBTizKjk0m
 J8zaJLcFKPILgB4he61AlokuqJEmHmDLMWGjo4IUEUW/tr8cWcjnxfJWVQ96X7u+6OzjMDiAtux
 hG7kDb47xdxwhog7aIhum2g7SDFb39MGSB/TSXcbFdiXLC6LNDc8os+TmII4iiDu/cXoQmbeqzZ
 4lVobGk9e/HFJmYQ4JIX4kuGCfa/xYsuvwfKDRQgJqZ8vUphHoTJGELrMwicMTgAuGIE6eIwGUD
 +zpWviAQpjiM0+A==
X-Received: by 2002:a05:6214:4a8d:b0:89c:3ff5:78dc with SMTP id
 6a1803df08f44-89c6b591469mr23226816d6.32.1773789830621; 
 Tue, 17 Mar 2026 16:23:50 -0700 (PDT)
X-Received: by 2002:a05:6214:4a8d:b0:89c:3ff5:78dc with SMTP id
 6a1803df08f44-89c6b591469mr23226496d6.32.1773789830091; 
 Tue, 17 Mar 2026 16:23:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC 10/10] tests/unit/test-vmstate: add tests for
 VMS_ARRAY_OF_POINTER_ALLOW_NULL
Date: Tue, 17 Mar 2026 19:23:32 -0400
Message-ID: <20260317232332.15209-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


