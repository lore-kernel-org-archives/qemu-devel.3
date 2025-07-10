Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA53C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZon4-00025c-N2; Thu, 10 Jul 2025 06:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomg-0001r5-4r
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomZ-00077v-SC
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4530921461aso5253605e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144335; x=1752749135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY9RxYXq4hHZTz7eLFjHXNzOsjF0/KQbibaEjOzCsCE=;
 b=W7dyQx2EfsAPLbQ//IH5Pr5/iO7R5DW4SN/NXFvSCMaIIHNpLltAIkcSO5czucb0C7
 QkfgETjer6HsKZxgXC7M66JUEPs83VyRLzWuvohIsjxMn2yWYGlZ7wvVIqHwolD+q+l3
 kz2HetxPnSvONZZDS252creNNTGehDP/mlyuo6UBG46HC2Ks0gNflRZrluTXEcExjdWh
 i5ZRykit1X8eFgkF5tsSSp2l7/hBQVmhF3ifCvlr5HfK60ZlfWhLUKkCVFh0K0WwGpDG
 T2s+CT1zhsZrzYEjK9YwuEQQJ8DlMDhHtI/laOj1h9FHf/UCA4T9OzLwSl9C2/Vpn4+3
 BWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144335; x=1752749135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nY9RxYXq4hHZTz7eLFjHXNzOsjF0/KQbibaEjOzCsCE=;
 b=Rvlm0k8ec33G/QmiGLL189JMde2TrGHUkw5v9FDGjeFBpj07Huw9+FgSTVCm8Tk5xu
 LIUrUMg0UuhAkrPt8WV810g7EJo2XmLGPe9Pwd/f+s3z8Eyi7pyQ6msZ/cDPOiGhiIkM
 cquvlZJv1tN/OGW9F4Crq7kzLS5zmWdTDqGeKylnB3tzKwkMLDRWg+iMK1LU/6n5viRw
 zHbgqmZzCXNKlZy/67ij6tXPBBdQ0ZP301byDqzL5UHiDIrtIBzmMm9W2IxGRJSTMlGu
 SLbbP+z0dxSJ3keeeg/ElwREtZq9GyubBR2yO11iCZ6qpNrAb86pQxNddFaDzbhDrag8
 cCIA==
X-Gm-Message-State: AOJu0YyKGD5W/0wntagNC7kGnlCZObiMkcBEJOt3W1F4OBP0vMwlDvH2
 MKc6lGCrmh1z6zn4hZMr9x3wrSA/ISF75Hv6GpKk7n0OB9nzkxbNxd0B4FpkMSo5ZKE=
X-Gm-Gg: ASbGnct0CRL1eBNnkQ5T7lPilLVNSawKFEDnf14mBBsCHsdFbqYjVYP9e2iTGcURmbM
 KYB+uZ0oNTuVJLzBwNAfvgzA1Ww1XA9bUKEHb7JECTzZG2BJ1RYOxDX9oEK5TLZuHYywNsKxowo
 mKFPvu4LQcdFq+qlL7XCDWKjhCcZ+BpkS+3VUF0CWyJTLCFYXqBZKUTLunumXbbNiBR3b5nlwin
 cS+POY00NvMiElxj3FFxeLEjfTCJIw4cDoD+io8Ui2MEJ5YQz5BFaLkz3X4iM4HltvTikVgjXAd
 9aL9gnwLuNfcx7UJXPzWYhKafaw1vfw3FSt3QmzdrACmquYaAAjFsrrhuKiJokKDUBa+oQi27A=
 =
X-Google-Smtp-Source: AGHT+IFRgHg30ZwslKl1MTZnBnL4N3W1btuIHawrWJnd4x6DKfqZ111NWjsg2s7ZVnd+ZnlNIxukzw==
X-Received: by 2002:a05:600c:1e0d:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-454d53bc8c5mr65998125e9.31.1752144335407; 
 Thu, 10 Jul 2025 03:45:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc22a8sm1574575f8f.34.2025.07.10.03.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AE8A5F87D;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH 3/7] contrib/plugins/execlog: Add tab to the separator search
 of insn_disas
Date: Thu, 10 Jul 2025 11:45:26 +0100
Message-ID: <20250710104531.3099313-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yodel Eldar <yodel.eldar@gmail.com>

Currently, execlog searches for a space separator between the
instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
use a tab separator instead; this results in a null pointer being passed
as the haystack in g_strstr during a subsequent register search, i.e.
undefined behavior, because of a missing null check.

This patch adds tab to the separator search and a null check on the
result.

Also, an affected pointer is changed to const.

Lastly, a break statement was added to immediately terminate the
register search when a user-requested register is found in the current
instruction as a trivial optimization, because searching for the
remaining requested registers is unnecessary once one is found.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
Message-ID: <20250630164124.26315-2-yodel.eldar@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/execlog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d67d010761..06ec76d6e9 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          */
         if (disas_assist && rmatches) {
             check_regs_next = false;
-            gchar *args = g_strstr_len(insn_disas, -1, " ");
-            for (int n = 0; n < all_reg_names->len; n++) {
-                gchar *reg = g_ptr_array_index(all_reg_names, n);
-                if (g_strrstr(args, reg)) {
-                    check_regs_next = true;
-                    skip = false;
+            g_auto(GStrv) args = g_strsplit_set(insn_disas, " \t", 2);
+            if (args && args[1]) {
+                for (int n = 0; n < all_reg_names->len; n++) {
+                    const gchar *reg = g_ptr_array_index(all_reg_names, n);
+                    if (g_strrstr(args[1], reg)) {
+                        check_regs_next = true;
+                        skip = false;
+                        break;
+                    }
                 }
             }
         }
-- 
2.47.2


