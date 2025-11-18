Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FA1CED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQzB-0004As-0X; Tue, 18 Nov 2025 14:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyq-0003fh-Of
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:03:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyo-0006AI-57
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:03:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so59652815e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492582; x=1764097382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lL+h3l3mjGOMeapjYq15c/DanDIPYgu6VsVdxlpUb9Y=;
 b=LmyiGsKoYpmWwLDlx++jmC2tHBBn1HOD7TVHGYAagQWgnhItc2QBO9AIP4EwTT3vDH
 FYJxnTScHwKb9YNcZhbC60r+1yI8c3s5gMoc8r1rL5sZWZilMLSXiqSB40yq4h0sQvOP
 bI2HT1IcGoVGqN/hBvHBMqFh0q7EvZfD+VML9OFEdOFlFpWXFFC5uJWWXdzCGK9x4RdS
 0+FSVeNxyMnNomSrWToZ68SykVyyAl3rfrbGG+ZMP/KRCfbewXIo3ole8sAt1bU8vl89
 MSX4FXZMnbqRXgXUrAY2Mrg/ElmltKsZxJrfAxK0icK49RnimuaMKgiH2yQ6LxDPz+8k
 KyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492582; x=1764097382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lL+h3l3mjGOMeapjYq15c/DanDIPYgu6VsVdxlpUb9Y=;
 b=UlKWhW35JCo4ny2MutpoUK1oCFuYT7d7/+RqELDZvj0oUC47YOv0lb2i3urqNVfu7r
 Lqq41hIjzf7v3I9qdFgPK+5C8+/hSxSYak17qNiYxsk/OVV5sOpwhha5/v5Q0HGZ1Q0/
 Dz5AFCS1nG5qcvB+3v2wIc/qKshE8lZpLFvudv2fnHDm1wj4smJHI2u5qfx4aQ+3H8Re
 +kM8H+qwGzjTpSxGx86abloHC+UiUrQnSKCzE49F+NtiC6xo/UbmtRcDThIGnjcoXqcI
 Ma+Fdput2+eJSOlmLYoWTumal2EVKY4PvJjSYxlYHXfNcXWgMcJJ6eV3MXhhcyJIgsCR
 cwlg==
X-Gm-Message-State: AOJu0YwDor82svYERB5NsopsDsoTSaPn60MrBazxaI1ajZ9fzhCn0o6F
 U5cs0kZ4vo1faYSPDLmSZEYyew5EB5SUTCcanmMoQNJ/X518AHt+OvnVai7PQrU7RSrQT7hD1EG
 DY6NxvkWiTA==
X-Gm-Gg: ASbGncstXolkrEE85PL6d4UW8emDsNQ5ZB9F4nE8HOL323PzFKhcwPUkpS8A41yLkNz
 5MHxBGi/fWmDNgWvCxdbOrh0nubLQbMV3qIJbYn6uz0ft5XNXeB2WXOHDcCGCPMp+PKON8Z1jS/
 4KMZZWk+dJp7vkxq2q/1bzksDaR7UJqrlSltza9+brRC8PqGioThooXa8K8yVwhV+yM0TAdw8x9
 WBmZq6YAiyQapRXIrKnPnQOHLeNBCmB/wb9s9puJZ+0b+iIx9BmJ27aZr4giiQXMUdHVNOWB6p8
 O2vQJjjh/Rkk/gcha+XavhNncIELSJrODlHHZXOo1HbisNYpKIA+Hhqv9XQkpQ/c91ajRRgfbOx
 xl0XS+oLAwpM+K4Qs3mfckxzwQUd09KzdKO+hy9kmak8sm1mRH5N7pbq6CogTuALXdoaU3i5eo3
 UWmEe2sZiToBa4SQ25s+wFwH4u1ac7q8oqOrGUDA8RZJGdVLPJDMAktn6h10Us
X-Google-Smtp-Source: AGHT+IHxE9sYfA0A3CoSxqBnMHMtZFahP0+P9O8fDzNZiXUq4B1MBWSVST9R5XeHI9nggngL+ZDz2g==
X-Received: by 2002:a05:6000:2f83:b0:42b:3c8d:1936 with SMTP id
 ffacd0b85a97d-42b5935241dmr16941084f8f.26.1763492581826; 
 Tue, 18 Nov 2025 11:03:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b617sm33199614f8f.31.2025.11.18.11.03.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:03:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] ebpf: Clean up useless error check in ebpf_rss_set_all()
Date: Tue, 18 Nov 2025 20:00:52 +0100
Message-ID: <20251118190053.39015-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Markus Armbruster <armbru@redhat.com>

ebpf_rss_set_all() is only called when the context has an eBPF program
loaded.  Replace the dead error check with an assertion.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251118154718.3969982-3-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ebpf/ebpf_rss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index e793786c172..b64e9da3e36 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -247,10 +247,8 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key,
                       Error **errp)
 {
-    if (!ebpf_rss_is_loaded(ctx)) {
-        error_setg(errp, "eBPF program is not loaded");
-        return false;
-    }
+    g_assert(ebpf_rss_is_loaded(ctx));
+
     if (config == NULL) {
         error_setg(errp, "eBPF config table is NULL");
         return false;
-- 
2.51.0


