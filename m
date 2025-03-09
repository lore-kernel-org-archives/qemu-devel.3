Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692CC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 19:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trMSn-00012Z-1z; Sun, 09 Mar 2025 15:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trMSk-00010u-Jq
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:37:27 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trMSh-0006TE-Py
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:37:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224191d92e4so56256635ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741549042; x=1742153842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MT3STjDQDcCpuKL/24twGSo6UOkr+VDdVFMMCjf6edc=;
 b=yUJQVXzUZtdj4RY1Ly8ovBtdu/Yh1JIcASCGLZJHXRkShnIfKtZVeO/bE7sTfWteKd
 vPn5NUuaCobUJwUo+R1YHmLnAMwvpbX4HAuhgwjAQTwElHef8aBT1SN0zq4J8wQYsVP8
 RkNCqLJOwOsMt8tyypXTJfmDJPRJrZE0SnPfpFj+uy4COcSZXsBlJKj3K//bVNFq7t7D
 1rCXr6WUWLKYak4AlTvdm2IbsIsTw4sCtAqSdx0dE4gzAEgEdX12fWAMpAt2SgEZEoXF
 OG/zVQytytOTb9Sbs2tQwVQz3g/Ke/qMzHKiRiy67TIT1TfDbjFrqk6j+fe7uJqRLi9/
 1ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741549042; x=1742153842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MT3STjDQDcCpuKL/24twGSo6UOkr+VDdVFMMCjf6edc=;
 b=jeX3U6DLK1harTUgSbKyaH/Wh2sQXE5BkSiLuyhyy2sl9Gtl/NRSQFvEBA6MVJMRPl
 CnqMqd2iup58ZYvbrC8O9WJJ/mVSYGzE5b//g4D9EYfTQLjmR7K5J5hzneQ1IKoUJ9hg
 DQKC37S9wqj4M6tPKzfvmAKyE0eqxZSBgvwNDLGyzZTxo7ovMlUOtdX/di97cfD5Vpz4
 BkMhKi/w5KDDe1W/l6DXCFVy3o11Lt1da9qUwTTs8/RYOw7+z51YS0qBn6cGAxJ52dQL
 /14DmwRU/xcDnqzCDNVWyGmMUQbPrpCXQ1Ek5QTEj2ppNSwWGXE/9VbbpLX8v/FbUX6X
 L1ug==
X-Gm-Message-State: AOJu0YwP9B3rgPa1GD0zUj3giekKdwTL0bw+pNv2DJ0NAPD5r/LZZAOI
 WtpAw908egpAfwMXtPdcSvjsTpxO11oWsDlZU0Z7mEazRVBfdGZkdaq+loiC15EbVZq7PUay+bq
 j
X-Gm-Gg: ASbGncu0OlsZGzuPcLY1fdCc2jhDFpbPt/xMxI9uJneboAu9+OWrXihKrHCXDrWjt74
 khaBzHq6jxOF4cqHJiBFpIQcwBY/qDn+qhmggwU6ZGhiW2K9w3zqNXb6UeoV+tVB7sB+p6s/rFC
 f05rVtrSLbuTk/S6QD/46Nu0AgLYJ9A4pLNgG022yrcR8NoNV+H80Ars8tBPqaZn+Cck8+zwAp1
 Di7TW4q+3U/0bhaTODYqDfKVltgg8K+5RS/sF162v8aJB8sDWGt1nOL6UNA1po47XUp9KBVCzfL
 WlNn1C3q+qyal4rz7jjYGaXFHKt27mZPXnyhYQSpMmJa
X-Google-Smtp-Source: AGHT+IH+dB0CCOZNmpt8GVAk0PYup7OWx+PWNPe+3i8iyacqepyDh2lw3VDZjaEl9pH9UU6RlYG7MQ==
X-Received: by 2002:a05:6a21:6f07:b0:1f5:79c4:5da2 with SMTP id
 adf61e73a8af0-1f579c473bdmr2368337637.31.1741549041722; 
 Sun, 09 Mar 2025 12:37:21 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281093136sm6278945a12.18.2025.03.09.12.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 12:37:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] system: initialize target_page_bits as soon as possible
Date: Sun,  9 Mar 2025 12:37:12 -0700
Message-Id: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Allow device init functions to use it, which can be convenient in some
cases (like hw/hyperv/hyperv.c).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/physmem.c | 1 -
 system/vl.c      | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 8df9f30a0bb..c5fb784a9e1 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3281,7 +3281,6 @@ void cpu_exec_init_all(void)
      * do this much later, rather than requiring board models to state
      * up front what their requirements are.
      */
-    finalize_target_page_bits();
     io_mem_init();
     memory_map_init();
 }
diff --git a/system/vl.c b/system/vl.c
index ec93988a03a..c64f8c8e808 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2848,6 +2848,9 @@ void qemu_init(int argc, char **argv)
     bool userconfig = true;
     FILE *vmstate_dump_file = NULL;
 
+    /* Set target page info before creating machine and associated devices */
+    finalize_target_page_bits();
+
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
-- 
2.39.5


