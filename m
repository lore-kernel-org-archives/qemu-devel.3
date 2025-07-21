Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D309C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYm-0005bt-2e; Mon, 21 Jul 2025 09:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYE-0000BC-LO
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYC-0005IE-6D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so46908965e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104445; x=1753709245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KBSm5ugZ/xrMuFfTDLrUi2oSc650VnWgZyUG+JvhWFA=;
 b=eNOQtYNQ2TPmeCWYRDtdqw2ssblrm+P8uI8+C/E2CtoS9lHwSS6zSBXDvSpRo9cbpu
 eQzu1w328EmHXShlTN+XLuLQ/rB1guhYxHl0lcnrwTWQ+0c02gb5A4Y2XweH6GDsxeG9
 K9shmHzP8ezNgG91XJ7roVEvG+SNusxAlRThfZmGQb2wWyLZvdeTCXqhpfOsULAEE9Ls
 XTIUAlmN/uD2TMycJcoMogzZxPfwOXR/k03H1+pfaiIhJd2k1ViTVsgeHQ9XHkK8lXTA
 m0dOft/TF3CMhO6Adz6PjtGTFc5zs1JhI9RL4QL80D53vJ8sPZwDFMvT3qh5j65IGju9
 9WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104445; x=1753709245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBSm5ugZ/xrMuFfTDLrUi2oSc650VnWgZyUG+JvhWFA=;
 b=rYhOjymzoAsvZL/inJnHFzBdF+IWKCCvBy0en5GSECkw8Jej6bEHBncUeXWLzfrMvF
 xHBjKScoPaF3w5Q/RHiiKLcPhIx9poetp9F1jkg9QiGsGP9uvQ1KfdGIbge/nE/EzeQ3
 z8bg/nH20jz5nYKGOfN7UIPBM8JdV7niIp1ac97ZziUedSSr1v0YKQ8A5/PyGaBPyEsR
 5A4iprNckXcx6XtJKtCN+6gpRRFsNxQieymja9I17p/FCdBbGDqhR1I/SSRWyI7HtPSj
 Zrzgpf9bLjw6ysm2/Npiruj6Y+vhs4ZDxH8wWKumwjIL+p0woi3zqsAEFR7SDlsL9Heb
 Dn8w==
X-Gm-Message-State: AOJu0YyN4lFEQ6YpsgqPZPC80IcBFvdx5pg/YhB4+zhZTgrYSWYdRwpv
 tifmxyhhnDJMotrqBamoG3fo7ABXMxBI822e2Fd5Z1bZxM5pUZLQyNQ0h3gTTulJBxTE30MRYkK
 bs00N
X-Gm-Gg: ASbGncsYTL3iUpI+LOTcQ3IwQOldrkKdedjbl0GtXEUOSviJJiMznsCuwp8rc4I5qB+
 rJFbi+YKv8yyPC/DDemfSLw3BCg6y11eOtakMNlYzj7nw8XOYmEM0aTEQypiwlLlae+/4kAqaPV
 cbBIlXUhdswUFIn6QGlpUTPKU1FZcNHnQR85jsZZQz2GonKPxLLm3ym57SMV8P5n/id2uehYdJv
 NIbvQc5Qbjxz73KcRW9EdG0m5nXf7fsm6LfOi6m5GSxjsEYbksd1e0qcCUq972fk8DMzuhzEpt2
 yDUhbdzVCZb5yL8vw41gt+G+q3eHHp1uOJMYhv1QF4M9z/1qZ6dZrKMuY/QbazgRMdI2ILA0nr6
 z5amw2zPJ7rt+xUo7QdrFHI5laeHc
X-Google-Smtp-Source: AGHT+IHJwPF4ohez1x5yFR1bFWaryY1M7C8ofGioTW/0PVshGhr54naD5p1u1AjswgRkpdRYaMkcFQ==
X-Received: by 2002:a05:600c:4e8c:b0:456:1fd9:c8f0 with SMTP id
 5b1f17b1804b1-4562e32e669mr214834575e9.2.1753104445527; 
 Mon, 21 Jul 2025 06:27:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/misc/max78000_aes: Comment Internal Key Storage
Date: Mon, 21 Jul 2025 14:27:03 +0100
Message-ID: <20250721132718.2835729-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

Coverity Scan noted an unusual pattern in the
MAX78000 aes device, with duplicated calls to
set_decrypt. This commit adds a comment noting
why the implementation is correct.

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Message-id: 20250716002622.84685-1-jcksn@duck.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/max78000_aes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
index 0bfb2f02b5b..d883ddd2b61 100644
--- a/hw/misc/max78000_aes.c
+++ b/hw/misc/max78000_aes.c
@@ -79,6 +79,12 @@ static void max78000_aes_do_crypto(Max78000AesState *s)
         keydata += 8;
     }
 
+    /*
+     * The MAX78000 AES engine stores an internal key, which it uses only
+     * for decryption. This results in the slighly odd looking pairs of
+     * set_encrypt and set_decrypt calls below; s->internal_key is
+     * being stored for later use in both cases.
+     */
     AES_KEY key;
     if ((s->ctrl & TYPE) == 0) {
         AES_set_encrypt_key(keydata, keylen, &key);
-- 
2.43.0


