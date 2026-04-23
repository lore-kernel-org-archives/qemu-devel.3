Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4A9FDEE49
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdL-0006a4-Ts; Thu, 23 Apr 2026 15:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzd0-0005FA-7z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcx-0002TE-E6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC3C86A89D;
 Thu, 23 Apr 2026 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvefdpONNcFqysntqs+juTRcEx4K1r24uMyjySuc3B4=;
 b=HfWpPyWVopg946KlLkNC1v7DYtrHkvWa4ki5W0wM6JfeCCs9ofHdWwSPjdjlgdd+ps5aS8
 hA7dhLokseSV2vO//1ZLc5uorLB8ueB+iFsfNCz3UdZQcyQ9phZ9KxQgaSnYsdjrhR8Wwl
 yfmLnPkyEmsz+WgxYqkFLxcaXaUQMDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvefdpONNcFqysntqs+juTRcEx4K1r24uMyjySuc3B4=;
 b=84as9E81YOdwTP+XnBXGo3NLp0/8jnLyIVKjzEnmaC5DQnJSe+sOChWe3pv6tbbxJ/GkTN
 0q/XwawXza4rz+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvefdpONNcFqysntqs+juTRcEx4K1r24uMyjySuc3B4=;
 b=D5MXxWtpZy2xg66vILptiBg1Fu9LBzIAuB4o8Sm9gsW+b81v5JK+mlll83TOSED0yzI582
 TY7mpqpF1+YDuzg552/Exq+VmDXhq8hnMdHuIdYUMK0sAwLzW4fJhI1QzbYoTxKh3PQH8L
 kOKF5N7J+nRKw6G9KEt+992IAcq2xsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvefdpONNcFqysntqs+juTRcEx4K1r24uMyjySuc3B4=;
 b=kaYG5hGsYumIMgGwvSyaM2G8b+1iYKZ+7wRXyswl+Zi9697hZqtsm1HeM+30fu67hOjUh7
 AsazX5xdDbXh6iBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D43C593A3;
 Thu, 23 Apr 2026 19:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLgRGhRx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 34/43] tests/unit/test-vmstate: add tests for
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Date: Thu, 23 Apr 2026 16:19:48 -0300
Message-ID: <20260423191958.1440-35-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Add tests for VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
[peterx: Removed two tests due to macro not used, rebase, fix warning]
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-12-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
2.51.0


