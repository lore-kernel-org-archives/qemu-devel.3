Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FC8C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadz-0006c0-N3; Mon, 29 Jan 2024 18:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadt-0006JG-Kt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:17 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadr-0008Sg-Gb
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:17 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-595ac2b6c59so2334399eaf.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569333; x=1707174133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bfmq9Mg4HxfU53OW0oPle9hQIH8zXg09YsWAHRVD1c=;
 b=vxmA47zgQ8yDI+I2G/5AmpdpGf63Sxab1fvJKowqrbuapwXFfZMXbUKuyrzNgWG181
 k1zazv2daTAIjTiGjAfcwRC8bx8H38LaMYCDdfWv5N1js1u41RsRwpTUuUr9p4jAAHNF
 5K4mNsi8MRh+XisYA+Hn4zPOOE0T+n2F2WFXUZG0F1ZJPk6vBF3psIv5unMDEGwATYJ8
 aSeekEtFOIo3h+gzKErjkx801293DD1yZyGIELetTihrdhF4dtB/YbufE6EBB0hHfJHw
 nyC6kOkj1GWwE/Pqy44jBL6Om5HSAyVMiPMqAgRNO4NnET3izmTKezC0RSeiaCeSzWlI
 VCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569333; x=1707174133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bfmq9Mg4HxfU53OW0oPle9hQIH8zXg09YsWAHRVD1c=;
 b=p00PBofq3XLl1mRQoE5SlG/N8+nQXGncWXiU+9NMoG6co8b3+0HE5b366HaBuygPFo
 0acBCzsuAm+rI6g/5yN/reW/AfSYo//9FvD0NjTBCV7ESK5OBiJbTW4ks6HioHqctq8V
 pd1jT1R98AuimHzBMfBtViFWrV6Qpxzfpg1yhLdb6igJWozwa1olS9q4q1r91usnSy6V
 xUPx4NVjCLbAlNwXNaZfLW8OfcmZBRMHqKCxZ8H7XYacr0LE+Q/KHPQXbSrfVuzqS5YO
 xkLh1BivvIgJbaej2JQinL92usnLS00ZGYLV4baS5H2HgHJsVODiuHxoC4KIo6KZxzZu
 uiMQ==
X-Gm-Message-State: AOJu0YyLkgKA2qj21WtfDTIAV018OAbzHOCro2LS9Y13szI3YNX8n7kQ
 TfGKYT8WJqCtFeU+daXXPU70B5eFP2PhKcZlkvWlki6J5NTBzWWfWpVuYtbkeijl22W6UBGpaqX
 aAUI=
X-Google-Smtp-Source: AGHT+IHoDrW7QWN9H/tLJDH3NN+mFr2kdUnYWJKqusufGCdPb7aEMGCN5RK8WyFxWBDUOsaT36AJwA==
X-Received: by 2002:a05:6358:5913:b0:178:77cc:a0f1 with SMTP id
 g19-20020a056358591300b0017877cca0f1mr2072515rwf.48.1706569332896; 
 Mon, 29 Jan 2024 15:02:12 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/31] tcg: Make tb_cflags() usable from target-agnostic code
Date: Tue, 30 Jan 2024 09:01:07 +1000
Message-Id: <20240129230121.8091-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently tb_cflags() is defined in exec-all.h, which is not usable
from target-agnostic code. Move it to translation-block.h, which is.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-3-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h          | 6 ------
 include/exec/translation-block.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df3d93a2e2..ce36bb10d4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -459,12 +459,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
 #endif
 
-/* Hide the qatomic_read to make code a little easier on the eyes */
-static inline uint32_t tb_cflags(const TranslationBlock *tb)
-{
-    return qatomic_read(&tb->cflags);
-}
-
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index e2b26e16da..48211c890a 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -145,4 +145,10 @@ struct TranslationBlock {
 /* The alignment given to TranslationBlock during allocation. */
 #define CODE_GEN_ALIGN  16
 
+/* Hide the qatomic_read to make code a little easier on the eyes */
+static inline uint32_t tb_cflags(const TranslationBlock *tb)
+{
+    return qatomic_read(&tb->cflags);
+}
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.34.1


