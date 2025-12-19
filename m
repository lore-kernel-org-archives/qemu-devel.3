Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3C8D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdF0-000266-Se; Fri, 19 Dec 2025 11:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEw-0001YJ-MA
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdEu-0006KW-VC
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:22:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso16779335e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161319; x=1766766119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlZbLtyKD5Kx9RMvXZxS+ZYE1ejEy5zG7BP8ve/1sWc=;
 b=RHEQn0G9re8U7QSYgT2D6xtKIJ43OH/WKN+PPu1fMc0TfciC/uEJam/BnKx8jTWRHV
 1bdo7KBqgwPKOBpMfjPcJBPT+L+N/Cl4KEP/g1Ea5OdD+jPqn5pJ0vvm1fVhIeprYE9V
 pES10jhnHrNXSoUKikeu/IIpkr1zr88UfIgQ8RR6CKEO76Mp2qmYvrYqcMcuZFbTdD0Z
 BNjpTcpDMEBzrz7ZB5zSi/4QaA+HZnxV9Elsudg+++wVIKInLZKUFUwb4Ce3nJ6Qx113
 /56X23ngN+kSNgaaAwZwu7Mo+fuG2dRzfyMD3H0lUklDnn5TCnhY1tkrZRNbqb7QzQnv
 7xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161319; x=1766766119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MlZbLtyKD5Kx9RMvXZxS+ZYE1ejEy5zG7BP8ve/1sWc=;
 b=cZxeuXbrcuS0iq0/yKD8MsdXGEbpUL+h9/2bHIjvb9xuPxgJrTobyT1YKBDr+AEwyM
 1e+zml0HER9S39QpiEDzDdqCQhDu6ECAQfBqVsGebKtr3nOb9bvUugEbEmIqhH91f533
 GIvUmgCe6OTCdJd1g2jr9rcRLeT39QKMGOe0FPie7e4c0cVUu1O8kEfAcqLOOamjlv+L
 r8Ig0VVaZ9LYwV9bzf+ohfrUgs5jgvVhQ4YYWGMSTo6QxGPH0bWOvtfw0ws1NVwG89Y/
 tTzW21RIuZkNX3Dpw6bpAtD8bVBEDgRQd2h78iZP8RC3D5dX95W/No+U/e5JTQmFFO6w
 2Hiw==
X-Gm-Message-State: AOJu0YwGmTTLxM69m7UYLX2oFm/JsowayuLTgHZcRwbeQblJNVH4SP3Q
 xXoPyRvI8/jtKMDWf165s05EGcc6D3Uunxm/eq7HgQaexTAVmC6IrreCiuZSKi2ClEAHn4663ad
 J6PRTXrY=
X-Gm-Gg: AY/fxX7wlnkiPjLVmUJelwih/NgNmhIJiEQrSS6ifbRRsfN0Y/GfYojQjM8Z2s1QnmQ
 +yTCBAdNQ+DPmPx68OYOV6nUicRezfwJ3mYDFt2DWY/6JDPNT+NANagO6SEz3q/EtILhyI+wb0O
 W6PWgOeIRkTixQW4d4I6GGPwwNWV7eNBTqerUoWZ84ptFY+4AbOaZEdVGj0YFjcvoikW/jh4m73
 b/nhsA6N4N4vo3FDTxvsix7J0K40s9acuOoe/gLcmS00gC/taeafdWuEvCH4zjj7ctEViW6SPuW
 VImTD25Htv+mguLTLK2kpl9ti2oGASXUuly8xTHUumS+F2xzxqVGsEm8z0BTU+Yi4fE+B6Ch0gR
 U9/RyI8b623vETE8YgsEvDgDhFD+LMr257AzkH+FKaXHNRH02R8hh44gYohhY7uVH8YsWpljFnl
 2kN3jAeX0dWr5CBVIVvb42II6Sc6U253i4NSa42Da7jwivrUo11kTDSCWqAcL+
X-Google-Smtp-Source: AGHT+IEBVHrywafE04qHREF0ebxc38+U4M5dEdUoOXn78hGsX4y+BaiAoqGTB1eT/bJSeGbxgfLntg==
X-Received: by 2002:a05:600c:8107:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-47d19595f00mr32397115e9.22.1766161319064; 
 Fri, 19 Dec 2025 08:21:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbc0bsm50099865e9.11.2025.12.19.08.21.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:21:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/24] system/memory: Restrict legacy ld/st_phys()
 'native-endian' API
Date: Fri, 19 Dec 2025 17:19:44 +0100
Message-ID: <20251219161953.72724-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_USE_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll unset the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory_ldst_phys.h.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index f4c91dc7a91..e0da6d19a5b 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
+#endif /* TARGET_USE_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS  _le
 #include "system/memory_ldst_phys_endian.h.inc"
-- 
2.52.0


