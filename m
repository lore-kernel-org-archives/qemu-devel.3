Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52272C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Ha-0000L5-5E; Sat, 09 Mar 2024 14:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HY-0000KD-MG
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HW-0002VD-Bx
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:56 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5683089d4bbso1940965a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012171; x=1710616971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFjMT6zDVz6FC8tPUCQ4kyyMrqKZ8chKsrslRHOyQyw=;
 b=CqXWBu1FQrLQrx2FmDdLdS/BGLFDvUZKB+rVoGQmVFwQSM90i1GsAC8swYDoNG2P5V
 G5fvHMbj5xk/pl4pEJYjA4RA6mZAa3R5uPHtRmnZ6I0lUK6ReqHtAvzIItNbGcJDpG9/
 xGQJVYMzDXEfB4cnsOW3ixx6Kphoz5jkh3fcqzxbcrzhzy9S3Q9iwO40Vd7rC8g7CcHS
 Vct4I2T/0psb1fk2hU7+yb0ZdTRF5Pd0/JCZlymvYVjAy39WFD37Yr2kpbrfhfJeE2gN
 MefBLQCB4Fm3dAuqCSe789RMLETLxxrcf9BkBGFmnjmMC0Pd0pGPXyLrBmOaVFdLPz0s
 34BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012171; x=1710616971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFjMT6zDVz6FC8tPUCQ4kyyMrqKZ8chKsrslRHOyQyw=;
 b=NTVogR6y4ndzuGkYgAYEnexqYif2OOf5IHr9Ud0L12ivuUQ4lNc1jOtuA17uz2thbU
 PV0FJhM7/lY0zdt1iYG3WH8aaEGTj2GRMVVdEfswzmxg8SSL2hErWpryywUFuO3uVBxx
 u+wY6jcC0/C06rJ9DKrIWF0Bp7YzMATvJb+V9DX6SsOKTL5K08b7HbhEyMFanAtSNFS9
 BZZ3gzJ95eqABYQznTEW+GZp7/wRrDaOKZ0Ymu6UC76UlOzJx+jatJzSGRU8+aVNeo0F
 Bb60IZRUHB6C1G1kHiiyNrUR7qVAQx54kNmW0vNJYhk8q8NpN1sr6ZRfQoOrAOumbVXW
 QLUw==
X-Gm-Message-State: AOJu0Yy4ylKiidZbEu73WzTwZYkn+RjeJ85omesmHraPitUrvflIhwX6
 ZK2o03EcZyb3fg8MJ+KwJQ5GBpqXmNX6QGIzZrX2nfpKh7NrUUr8jGn+rKNYFfE6pocUqwQSAed
 s
X-Google-Smtp-Source: AGHT+IEOGwIBYdP/mzwuHWgPMjU0SlF6nHZcYJJa0Wt9irOScU0CVSd5Ssk82Pi/m/B9Cv/46kpyew==
X-Received: by 2002:a50:934a:0:b0:568:1882:651f with SMTP id
 n10-20020a50934a000000b005681882651fmr1774495eda.25.1710012170814; 
 Sat, 09 Mar 2024 11:22:50 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a056402359200b005648d0eebdbsm1141497edc.96.2024.03.09.11.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PULL 06/43] hw/xen: Remove unnecessary xen_hvm_inject_msi() stub
Date: Sat,  9 Mar 2024 20:21:33 +0100
Message-ID: <20240309192213.23420-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since commit 04b0de0ee8 ("xen: factor out common functions")
xen_hvm_inject_msi() stub is not required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-8-philmd@linaro.org>
---
 stubs/xen-hw-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
index 7d7ffe83a9..6cf0e9a4c1 100644
--- a/stubs/xen-hw-stub.c
+++ b/stubs/xen-hw-stub.c
@@ -24,10 +24,6 @@ int xen_set_pci_link_route(uint8_t link, uint8_t irq)
     return -1;
 }
 
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-}
-
 int xen_is_pirq_msi(uint32_t msi_data)
 {
     return 0;
-- 
2.41.0


