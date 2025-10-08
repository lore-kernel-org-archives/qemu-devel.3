Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98842CCD186
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UwE-0002HF-Ji; Wed, 08 Oct 2025 10:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Uw9-0002Gt-S5
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Uw0-0004Ty-JP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso90466625e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759932857; x=1760537657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Szppyz1YU92aBnsnHh7hqhpHfCekPYvzL9kvHX4gcP4=;
 b=BP/aaij1BxgB3ppkxks5MuFHl+yOxvHUiYRkkQwUJkE92SNSN9lY/T0n2hgkyrM79m
 Fk9G4tI+Q/x90uImqBNPK9dcwc1iHTP6l0HeGox+u96+/u4D+JirTV9kNr7BygXdWJm/
 JW1+sIaEy41JBgQGgSW03RyW240exqZQLlD7SP8Gn+uB7clw+KHUOHZJ3oieqE3mSUUq
 o4yskqnNY/bQowNK013nMfmV79Z+G017tRtbQKHuxxXbGp4HI/2U+5BrvsXmk6sv55Ko
 RFFYhUgSro1l6yEN/k2igUTfCVf8Mf4LDFCOkURkngbObD6oBE80El/YXN59XBZuUmTv
 97Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932857; x=1760537657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Szppyz1YU92aBnsnHh7hqhpHfCekPYvzL9kvHX4gcP4=;
 b=kykCOvl2dWC5M7TTgz4biu+/1kyEu3D65jCLt2kJ32CVvIWkCppbbZ5NpEQZiZ28Ym
 mGuizNVjyZq4X/88g12KKkfULVcrenO1+GudVy43UOYRKQQxpkdc6O2UaaId5zHgw4Ic
 I7Y6TowPaqi8WhjO9yABLvySS53FY2GCdImY9zLXZwwdlbEmYrwSm4jOxUr31HKSBl9s
 V97SrbnJCZwwOzXfKbl4fj36j1JigcN7hDcUMxKTl+AypbnPxAzptnFirUeGHikTXe01
 vn24Ee+F+bJ8S03NtDg/7CNF5NkXYBKb2MpLlLBSqCeDimfqaxkhZxRnweuc/tTIhXWQ
 YXMw==
X-Gm-Message-State: AOJu0YwzbZB937eS+rEwxQkhfnY0RIjSIslELpayhzP9nVDGhpcS47Kw
 4pZoXsbmFhRusBujPiX6mvo87Xr+yQW7O0sUbbT0nGMSMNa4rW0jvcTXTZjkOPMknA9wshCiOqG
 GiGSrkOLrUg==
X-Gm-Gg: ASbGncuRjM7Z8hFx5I1atY5pvIob2Przp9D1nB4bI4BP2nrxpsdvGzLbCwtyfM1xRn8
 q7FA8arKib+LQT6ufTyXDXq8SHXxC8GmdXYrvzqIInITN/RBkQ1xqrwMOjD7GzxQlW6lF8X2o9x
 C+J726VpVT9OKpOTeIZy5I+2K4/FrV1QHPJNhLFzY35oo/6sx2rBR8zlc9SIpzUw6yRztqtwcI0
 yjSXjxyxcWUB6c2WxQG922lfoIb0/fhIODplXb1jqGA2Xh5+il1pFao8Ttof7DxmTpBZoqzXLZU
 esjtumpRgGfDZgzz5TfEx+DboA/BGMzse+2K2LZdfstfTI293mJM+3DqkLnx5izxevsZgm0ByOq
 WR+i5+Og3P0TB9k1GcjZ4VqiJDedwfrDw+pl0BvqrbN9Et/ssdlPSeaWDnjC1cGjosBjJJCw3gF
 rfPA5bZXS1LEpDph5xwCM6aKBJ
X-Google-Smtp-Source: AGHT+IH/Au06/fgW2rLyDS0S298GyKPkoh5iIRGSqZrfOJcRPrhqgTurKnm9lpg87gHYoyMyeGodFg==
X-Received: by 2002:a05:600c:3f10:b0:46e:5cb6:b904 with SMTP id
 5b1f17b1804b1-46fa9b079f7mr22962925e9.28.1759932856710; 
 Wed, 08 Oct 2025 07:14:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf18bbe7sm1270705e9.20.2025.10.08.07.14.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 07:14:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] target/s390x/mmu_helper: Simplify
 s390_cpu_virt_mem_rw() logic
Date: Wed,  8 Oct 2025 16:14:08 +0200
Message-ID: <20251008141410.99865-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008141410.99865-1-philmd@linaro.org>
References: <20251008141410.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In order to simplify the next commit, move the
trigger_access_exception() call after the address_space_rw()
calls. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 487c41bf933..22d3d4a97df 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -541,9 +541,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     pages = g_malloc(nr_pages * sizeof(*pages));
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
-    if (ret) {
-        trigger_access_exception(&cpu->env, ret, tec);
-    } else if (hostbuf != NULL) {
+    if (ret == 0 && hostbuf != NULL) {
         AddressSpace *as = CPU(cpu)->as;
 
         /* Copy data by stepping through the area page by page */
@@ -556,6 +554,9 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
             len -= currlen;
         }
     }
+    if (ret) {
+        trigger_access_exception(&cpu->env, ret, tec);
+    }
 
     g_free(pages);
     return ret;
-- 
2.51.0


