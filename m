Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D34CC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHaA-0002XI-66; Mon, 30 Jun 2025 12:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uWHZq-0002Pm-Hu
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:41:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uWHZn-0008QH-O3
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:41:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-22c33677183so38786325ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751301708; x=1751906508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8QqI6sUZ3+nL6u2zF4XdptHTXwj43cSqcR6sa9X3Jc=;
 b=eAJHEEra8Lt6G9rtSDoP7kmj+YaJOqYjQOpiowYN4xNYlVj5XPKB2o9DSxsgDYTdG9
 fEClwJ7Y2ksqPn2LRU4g8KDOSu/e+BYTpc1nnMXlLTFzzr+m/22Qj3gNKwgr3QUgVBnn
 7R1qOjne6PQlD4QsAO6Jk/xDSP8lYz9Rf7xZ6yv7/a/6lrJO1CopwkgXGWnESioLX68n
 SYoPrgtmTY0De9jOC8m+LZb/jtNL2rWPtDVfSOPGJkQ/40lRX59zRKg/2PhBmyyeFnUI
 wDVULFPlzsCmqgrzD2zGNW+nTLVvmaplCLNNk5aUo+ocswcfrSkjLMUgbt3W3pp4Cb5z
 aS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751301708; x=1751906508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8QqI6sUZ3+nL6u2zF4XdptHTXwj43cSqcR6sa9X3Jc=;
 b=G98dKKTXqIGWXXbhtLHAVcrtOVQ10BxEgwBzSF0YOLq/FK8jla+1zU3NKkscEsJia+
 hWDy5ufCgP1cP95r9yPm6iBBgOU6aqc6u+Bu4nrQlex/tOQCmn0DyJ0+l2qE2bGhNYn/
 bhsFkD2YxIRBmiFatT3DaHq0ue2Swp+00pQy5QKRfofS3MiNU1wxVmmhIL0x+5AZzHWL
 XGl3TNlvz5qkZPI+Q+YyTJ4SqxlBpH1ixmB7FIANTRsMmyF6ro+kYvjlVRweG4e7rKfB
 XcEdjYGIbbTLLPN6MSM3IHozkcGMjVsRiDKUjYGmyoCyR27SQV4OdfkHPQ70Fg+HZ/Mg
 6Sog==
X-Gm-Message-State: AOJu0YxLorocImMkcYyqo6hTjp1kdGGnhLJR6OZgAnhQhdaRWbZq3TC9
 KlztrqmLifYXefewubO4faMAm4lqRWDQd7ZXdNM4qJCGUuRrIEED/zHiPd+D7OO4
X-Gm-Gg: ASbGncscpmO/nht0reoAyjXdms3llyiAkgzU+KgvYJt8Wxh5n28uaHgvpVXVxaLdFgS
 LrbSfBhGAgkaWRIfeODSlxpo6i2drGQHOiZ9Y3KvzCVZiDfpd5whX51NoSzGvqYd7Tng9qITMod
 GyJyoJmMyFLHPQ0ylqq/0XXHAWv6xxSO0E6+PwyiPh1jR0+6xfxc/Ch0BGeWx+uCuXSQ9Ekjx8C
 eiqoiX6xjkkE0ePK87l6sy+vHM5MSrPZCARqKn2tH2Ku+JihroWLKreoOniM3cg0Deuwn7r7vLS
 9xd2WJSSNM+JvBzNkC3aPOd3FKlLdIlt1V8UjiWKIgl/DcHD9VAjQKqUrQ==
X-Google-Smtp-Source: AGHT+IEpPFqEcT/u2kkTUo4M0Lvw+br6S08miJoCTKJG0jWr1EYMqN6f87d3tXhWJWP7ZCV5ZpLG6A==
X-Received: by 2002:a17:902:f545:b0:234:8ec1:4af1 with SMTP id
 d9443c01a7336-23ac19ab87cmr235079365ad.0.1751301708234; 
 Mon, 30 Jun 2025 09:41:48 -0700 (PDT)
Received: from darlin ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b9fdsm90082595ad.108.2025.06.30.09.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:41:47 -0700 (PDT)
From: Yodel Eldar <yodel.eldar@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH v2 1/2] contrib/plugins/execlog: Add tab to the separator
 search of insn_disas
Date: Mon, 30 Jun 2025 11:41:23 -0500
Message-ID: <20250630164124.26315-2-yodel.eldar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630164124.26315-1-yodel.eldar@gmail.com>
References: <20250630164124.26315-1-yodel.eldar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.50.0


