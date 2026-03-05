Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A58F47CD7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgA-0006bu-9K; Thu, 05 Mar 2026 15:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg7-0006Zl-Gp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:16 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg4-00066x-Jp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:15 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-899fb030812so68289026d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743931; x=1773348731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYsjjk92eJf4VZg2PH2zrtLG1SUjOhyuOmJAHJxrR5A=;
 b=l1gAWfqh405qZ0JGL9Ny67G65Ypj0IpaVcC2en6VANoKhpFrH8OFgF4vX4JjhrTamx
 3TsSE9ahrgPuJ14awIv1ISI1p8c50Kifmt+roDX0j/4iwftr071fCee2heF5in5dUo6O
 yhr2MfeVMEL9N5BC0PwCjxdMw1NGcKYTSDfsC+eDCLeFcOm0DZeimtOSmgEs08rypBjW
 5NRGoBFjgdGtADMJqclLzN2IbeXVy0BW/xk4+ttbyHFXXtZgOlsn97CH47FywOB+yqP5
 Z5DAMFxQG7kULgYi9GCkMLAL4BWIxe4wJD4c7gvC6Php2UoKe2fEFnaljf1vC9A2i6gd
 5ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743931; x=1773348731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYsjjk92eJf4VZg2PH2zrtLG1SUjOhyuOmJAHJxrR5A=;
 b=AFcN+tVlGWs6C2GBy80wielyKSKd5dY17l88G0+QGOqcL2pnkZEIDLZGu/Flx1EbX8
 TBJPTBIoaIg2f0LUUsgNpQMX9jFBK32LsNorJdZQK0IudRnr5WkNPMX2k8WtTfSsqkTh
 ljH7jWAV57aCpPtYgOAF+U36Am1kIBjfKu+WvZ1gQqAu2mJFmVOU+p4QT16PcAE21Zsg
 hIq1sg/+kSnjoOV2tMqR7FWg7qct/23UZPMttiNRbE6fGNIAh6LDrcIwnkDg7zq/cTtO
 HFtqg9mnPM+4vVpgyo6coyKDlF8nMFjnupn5y8+tA3QgFGuuOd+tRjCO3yuZIMLEFYxc
 Q2Vg==
X-Gm-Message-State: AOJu0Yz8k4Ykqna/AYJ6fNv4RM2erAPnaAMT8qHNn4k4+t+L3gQTjWic
 a1iX6Q3JySPdYK6HGMTlhx6K8JxstFsyY56F+8urutk9Aalja/I0GZPzDE7x68VWzgbq1ohWP6O
 FqKT9
X-Gm-Gg: ATEYQzxPDvU+dQX5erx3efILMcGjjlZQGeqLvvfaPRccXCNzYDIkT07N5X9AL9vwE6T
 t6HfoQrCblsB3bNgMuznCrWJLXUW6O/8ebnGG9RS+S/yx1x847SFIL5GvbdzBUPU7cZ9GzfTZF5
 IjzxRhZh76kdw2+OBkrg1XQZbYCRUmtHEG28WCufbiBurH6rprl9XdoC5KxermTnoHxzxIQ70pF
 cAXmEgBuSo6vQ6exzI3gVyaYmqVmAdCOvQZQckIdCOBf8WxT3VyeP0BbetFnuWkVnsZuR2Dwr+p
 C6/iKv/lS7nwIMhML9LyNhfeR8JSXRZLnO2onyVOswlt1ptLD4KNj2G0CDH42Rm6kMSnQyVpzsV
 dWLugI/8/DfspwusrpzGZnCABh9uSkW4Cfnixmj/wr2YVN1M2YBw/NlCc0SrZG542Nun/wm1tjA
 iiS0L5JsQtQWhMAJKW9BYPenLsnubAdy0EkogYisjOVKLUWUs/D38hpzG0rlJ/VSyhWClmAz2Vn
 SMH
X-Received: by 2002:a05:6214:19c4:b0:899:f741:5aea with SMTP id
 6a1803df08f44-89a2df31935mr21711346d6.8.1772743931582; 
 Thu, 05 Mar 2026 12:52:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 07/12] plugins: prohibit writing to read-only registers
Date: Thu,  5 Mar 2026 12:51:47 -0800
Message-ID: <20260305205152.2121854-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2c.google.com
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

The opaque register handle encodes whether a register is read-only in
the lowest bit and prevents writing to the register via the plugin API
in this case.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-7-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/api.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 85b34949cbb..0c348a789b2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
     for (int i = 0; i < gdbstub_regs->len; i++) {
         GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
         qemu_plugin_reg_descriptor desc;
+        gint plugin_ro_bit = 0;
 
         /* skip "un-named" regs */
         if (!grd->name) {
@@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.is_readonly = false;
         if (g_strcmp0(desc.name, pc_str) == 0
@@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             || g_strcmp0(desc.name, rpc_str) == 0
            ) {
             desc.is_readonly = true;
+            plugin_ro_bit = 1;
         }
+        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -475,13 +477,16 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    /* Read-only property is encoded in least significant bit */
+    g_assert((GPOINTER_TO_INT(reg) & 1) == 0);
+
     if (buf->len == 0 ||
         (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
          qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
-- 
2.47.3


